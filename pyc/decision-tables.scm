;; =====================================================================
;; Macros and helpers
;; =====================================================================

(define-macro (replace-system sexp)
  (define host (cond-expand (gambit gambit:) (bigloo 'bigloo:)))

  (define known-hosts '(bigloo: gambit:))

  (define (replace sexp)
    (if (pair? sexp)
      (if (and (pair? (car sexp)) (memq (caar sexp) known-hosts))
        (cadr (assq host sexp))
        (map replace sexp))
      sexp))

  (replace sexp))

(define-macro (define-operator signature body)

  (define (add-bindings arguments body)
    (if (null? arguments)
      (list 'quasiquote body)
      (list
        'let
        `(($body ,(add-bindings (cdr arguments) body)))
        (list
          'if
          `(pair? ,(car arguments))
          (list
            'quasiquote
              (list
              'let
                (list (car arguments) (list ' unquote (car arguments)))
                (list 'unquote '$body)))
            (list
              'replace-symbol
              '$body
              (list 'quote (car arguments))
              (car arguments))))))

  `(replace-system
    (define ,signature
      ,(add-bindings (cdr signature) body))))

(define-macro (define-PycBinary-table signature . body)
  (define (symbol-append . rest)
    (string->symbol (apply string-append (map symbol->string rest))))

  (define (parse-signature signature)
    (cond
      ((and (pair? signature) (symbol? (car signature)))
        (let ((tail (parse-signature (cdr signature))))
          (cons (cons (car signature) (car tail)) (cdr tail))))
      (else
        ;; treat the rest of the signature as bindings for let*
        (cons '() signature))))

  (define (parse-single-predicate predicate arguments)
    (if (and (pair? predicate) (memq (car predicate) '(or and)))
      `(,(car predicate) ,@(map (lambda (sexp) (parse-single-predicate sexp arguments)) (cdr predicate)))
      `(,predicate ,@arguments)))

  (define (parse-body-predicates body arguments)
    (cond
      ((null? body) '())
      ((eq? (caar body) 'else)
        `((else ,@(cdar body))))
      (else
        `((,(parse-single-predicate (caar body) arguments) ,@(cdar body)) ;; a conditional branch
          ,@(parse-body-predicates (cdr body) arguments)))))

  (define (parse-body body arguments)
    `(cond ,@(parse-body-predicates body arguments)))

  (let* ((parsed-signature (parse-signature signature))
         (name (caar parsed-signature))
         (arguments (cdar parsed-signature))
         (bindings (cdr parsed-signature)))

  `(replace-system
    (define (,name ,@arguments)
      (let* (,@bindings)
        ,(parse-body body arguments))))))

(define (replace-symbol sexp target replacement)
  (cond
    ((eq? sexp target) replacement)
    ((pair? sexp) (cons (replace-symbol (car sexp) target replacement)
                        (replace-symbol (cdr sexp) target replacement)))
    (else sexp)))

;; =====================================================================
;; System-dependant operators
;; =====================================================================

;; ADDITION
(define-operator (py-fx+ left right)
  ((gambit: (or (|##fx+| left right) (py-bint-from-scheme (|##+2| left right))))
   (bigloo: (py-int-from-scheme (+fx/overflow left right)))))

(define-operator (unboxed-fx+ left right)
  ((gambit: (or (|##fx+| left right) (|##+2| left right)))
   (bigloo: (+fx/overflow left right))))

(define-operator (py-fl+ left right)
  ((gambit: (|##fl+| left right))
   (bigloo: (+fl left right))))

;; SUBTRACTION
(define-operator (py-fx- left right)
  ((gambit: (or (|##fx-| left right) (py-bint-from-scheme (|##-2| left right))))
   (bigloo: (py-int-from-scheme (-fx/overflow left right)))))

(define-operator (py-fl- left right)
  ((gambit: (|##fl-| left right))
   (bigloo: (-fl left right))))

(define-operator (py-fl- left right)
  ((gambit: (|##fl-| left right))
   (bigloo: (-fl left right))))

;; MULTIPLICATION
(define-operator (py-fx* left right)
  ((gambit: (or (|##fx*| left right) (py-bint-from-scheme (|##*2| left right))))
   (bigloo: (py-int-from-scheme (*fx/overflow left right)))))

(define-operator (unboxed-fx* left right)
  ((gambit: (or (|##fx*| left right) (|##*2| left right)))
   (bigloo: (*fx/overflow left right))))

(define-operator (py-fl* left right)
  ((gambit: (|##fl*| left right))
   (bigloo: (*fl left right))))

(define (py-mul-str-literal pycstring pycnumber conf)
  (let ((string (PycLiteralValue-val pycstring))
        (number (PycLiteralValue-val pycnumber)))
    (if (< (* (string-length string) number) 10000) ;; Put some arbitrary limit on the result size at compile-time
      (scheme (new-PycString (PycNode-loc pycstring) (fold string-append "" (make-list number string))) conf)
      #f)))
;; =====================================================================
;; Predicates
;; =====================================================================

;; Helpers
(define (lhs-is? pycbinary predicate)
  (predicate (PycBinary-lhs pycbinary)))

(define (rhs-is? pycbinary predicate)
  (predicate (PycBinary-rhs pycbinary)))

(define (operands-are? pycbinary predicate)
  (and (lhs-is? pycbinary predicate) (rhs-is? pycbinary predicate)))

(define (lhs-number-literal-value-is? pycbinary predicate)
  (lhs-is?
    pycbinary
    (lambda (lhs)
      (and (isa? lhs PycNumber)
           (predicate (PycLiteralValue-val lhs))))))

(define (rhs-number-literal-value-is? pycbinary predicate)
  (rhs-is?
    pycbinary
    (lambda (rhs)
      (and (isa? rhs PycNumber)
           (predicate (PycLiteralValue-val rhs))))))

(define (operands-number-literals-value-are? pycbinary predicate)
    (and (lhs-number-literal-value-is? pycbinary predicate)
         (rhs-number-literal-value-is? pycbinary predicate)))

(define (operands-are-statically-typed-as? pycbinary type)
  (let ((lhs-type-hint (PycBinary-lhs-type-hint pycbinary))
        (rhs-type-hint (PycBinary-rhs-type-hint pycbinary)))
    (and (eq? lhs-type-hint type) (eq? rhs-type-hint type))))

;; Predicates usable in table
(define (operands-are-complex-literals? pycbinary conf)
  (operands-number-literals-value-are? pycbinary (lambda (value) (not (real? value)))))

(define (operands-are-int-literals? pycbinary conf)
  (operands-number-literals-value-are? pycbinary (lambda (value) (and (real? value) (not (flonum? value))))))

(define (operands-are-int-or-float-literals? pycbinary conf)
  (operands-number-literals-value-are? pycbinary real?))

(define (operands-are-string-literals? pycbinary conf)
  (operands-are? pycbinary (lambda (operand) (isa? operand PycString))))

(define (operands-are-unboxed-integers? pycbinary conf)
  (operands-are? pycbinary (lambda (value) (and (real? value) (not (flonum? value))))))

(define (operands-are-unboxed-fixnums? pycbinary conf)
  (operands-are-statically-typed-as? pycbinary 'Usint))

(define (operands-are-unboxed-integers? pycbinary conf)
  (or
    (operands-are-statically-typed-as? pycbinary 'Uint)
    (operands-are-statically-typed-as? pycbinary 'Ubint)
    (operands-are-statically-typed-as? pycbinary 'Usint)))

(define (operands-are-unboxed-bool? pycbinary conf)
  (operands-are-statically-typed-as? pycbinary 'Ubool))

(define (operands-are-unboxed-flonums? pycbinary conf)
  (operands-are-statically-typed-as? pycbinary 'Ufloat))

(define (operands-are-unboxed-strings? pycbinary conf)
  (operands-are-statically-typed-as? pycbinary 'Ustr))

(define (lhs-is-a-str-literal pycbinary conf)
  (lhs-is? pycbinary (lambda (lhs) (isa? lhs PycString))))

(define (rhs-is-a-str-literal pycbinary conf)
  (rhs-is? pycbinary (lambda (rhs) (isa? rhs PycString))))

(define (lhs-is-a-sint-literal pycbinary conf)
  (lhs-number-literal-value-is? pycbinary fixnum?))

(define (rhs-is-a-sint-literal pycbinary conf)
  (rhs-number-literal-value-is? pycbinary fixnum?))

;; =====================================================================
;; Decision tables
;; =====================================================================

;; ADDITION
(define-PycBinary-table (add-decision-table this conf (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (operands-are-int-literals?
    (let ((result (+ (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))))
      (if (fixnum? result) result `(py-bint-from-scheme ,result))))
  (operands-are-int-or-float-literals?
    (+ (PycLiteralValue-val lhs) (PycLiteralValue-val rhs)))
  (operands-are-string-literals?
    (scheme (new-PycString (PycNode-loc lhs)
                           (string-append (PycLiteralValue-val lhs) (PycLiteralValue-val rhs)))
            conf))
  (operands-are-unboxed-fixnums?
    (unboxed-fx+ (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-integers?
    `(+ ,(scheme lhs conf) ,(scheme rhs conf)))
  (operands-are-unboxed-flonums?
    (py-fl+ (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-strings?
    `(string-append ,(scheme lhs conf) ,(scheme rhs conf)))
  (else
    `(let (($left ,(scheme lhs conf)) ($right ,(scheme rhs conf)))
       (cond
         ((and (fixnum? $left) (fixnum? $right))
           ,(py-fx+ '$left '$right))
         ((and (flonum? $left) (flonum? $right))
           ,(py-fl+ '$left '$right))
         (else
           (py-add $left $right))))))

;; SUBTRACTION
(define-PycBinary-table (sub-decision-table this conf (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (operands-are-int-literals?
    (let ((result (- (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))))
      (if (fixnum? result) result `(py-bint-from-scheme ,result))))
  (operands-are-int-or-float-literals?
    (- (PycLiteralValue-val lhs) (PycLiteralValue-val rhs)))
  (operands-are-unboxed-fixnums?
    (unboxed-fx- (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-integers?
    `(- ,(scheme lhs conf) ,(scheme rhs conf)))
  (operands-are-unboxed-flonums?
    (py-fl- (scheme lhs conf) (scheme rhs conf)))
  (else
    `(let (($left ,(scheme lhs conf)) ($right ,(scheme rhs conf)))
       (cond
         ((and (fixnum? $left) (fixnum? $right))
           ,(py-fx- '$left '$right))
         ((and (flonum? $left) (flonum? $right))
           ,(py-fl- '$left '$right))
         (else
           (py-sub $left $right))))))

;; MULTIPLICATION
(define-PycBinary-table (mul-decision-table this conf (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (operands-are-int-literals?
    (let ((result (* (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))))
      (if (fixnum? result) result `(py-bint-from-scheme ,result))))
  (operands-are-int-or-float-literals?
    (* (PycLiteralValue-val lhs) (PycLiteralValue-val rhs)))
  (operands-are-unboxed-fixnums?
    (unboxed-fx* (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-integers?
    `(* ,(scheme lhs conf) ,(scheme rhs conf)))
  (operands-are-unboxed-flonums?
    (py-fl* (scheme lhs conf) (scheme rhs conf)))
  ((and lhs-is-a-str-literal rhs-is-a-sint-literal)
    (or (py-mul-str-literal lhs rhs conf) `(py-mul ,(scheme lhs conf) ,(scheme rhs conf))))
  ((and lhs-is-a-sint-literal rhs-is-a-str-literal)
    (or (py-mul-str-literal rhs lhs conf) `(py-mul ,(scheme lhs conf) ,(scheme rhs conf))))
  (else
    `(let (($left ,(scheme lhs conf)) ($right ,(scheme rhs conf)))
       (cond
         ((and (fixnum? $left) (fixnum? $right))
           ,(py-fx* '$left '$right))
         ((and (flonum? $left) (flonum? $right))
           ,(py-fl* '$left '$right))
         (else
           (py-mul $left $right))))))

;; Dispatch
(define (default-python-op binop conf)
  `(,(symbol-append 'py- (PycBinary-op binop))
    ,(scheme (PycBinary-lhs binop) conf)
    ,(scheme (PycBinary-rhs binop) conf)))

(define (dispatch-PycBinary-to-decision-table pycbinary conf)
  (let ((op (PycBinary-op pycbinary)))
    (cond ((eq? op 'add) (add-decision-table pycbinary conf))
          ((eq? op 'sub) (sub-decision-table pycbinary conf))
          ((eq? op 'mul) (mul-decision-table pycbinary conf))
          (else (default-python-op pycbinary conf)))))
