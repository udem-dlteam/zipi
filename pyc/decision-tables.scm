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

(define-macro (define-operator signature . body)
  `(replace-system (define ,signature ,@body)))

(define-macro (define-binop-table signature . body)
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

  (define (parse-body-predicates body arguments)
    (cond
      ((null? body) '())
      ((eq? (caar body) 'else)
        `((else ,@(cdar body))))
      (else
        `(((,(caar body) ,@arguments) ,@(cdar body)) ;; a conditional branch
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

;; =====================================================================
;; System-dependant operators
;; =====================================================================

;; ADDITION
(define-operator (py:fx+fx left right)
  `((gambit: (or (|##fx+| ,left ,right) (py-bint-from-scheme (|##+2| ,left ,right))))
    (bigloo: (py-int-from-scheme (+fx/overflow ,left ,right)))))

(define-operator (py:fl+fl left right)
  `((gambit: (|##fl+| ,left ,right))
    (bigloo: (+fl ,left ,right))))

;; =====================================================================
;; Predicates
;; =====================================================================

;; Helpers
(define (operands-are? pycbinary predicate)
  (and (predicate (PycBinary-lhs pycbinary)) (predicate (PycBinary-rhs pycbinary))))

(define (operands-number-literals-value-are? pycbinary predicate)
  (operands-are?
    pycbinary
    (lambda (operand)
      (and (isa? operand PycNumber)
           (predicate (PycLiteralValue-val operand))))))

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

;; =====================================================================
;; Decision tables
;; =====================================================================

(define-binop-table (add-decision-table this conf (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (operands-are-complex-literals?
    `(py-throw-exception-with-message py-builtin-NotImplementedError "complex number"))
  (operands-are-int-literals?
    (let ((result (+ (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))))
      (if (fixnum? result) result `(py-int-from-scheme ,result))))
  (operands-are-int-or-float-literals?
    (+ (PycLiteralValue-val lhs) (PycLiteralValue-val rhs)))
  (operands-are-string-literals?
    (scheme (new-PycString (PycNode-loc lhs)
                           (string-append (PycLiteralValue-val lhs) (PycLiteralValue-val rhs)))
            conf))
  (operands-are-unboxed-fixnums?
    `(let (($left ,(scheme lhs conf)) ($right ,(scheme rhs conf)))
      ((gambit: (or (|##fx+| $left $right) (|##+2| $left $right)))
       (bigloo: (+fx/overflow $left $right)))))
  (operands-are-unboxed-integers?
    `(+ ,(scheme lhs conf) ,(scheme rhs conf)))
  (operands-are-unboxed-flonums?
    `(let (($left ,(scheme lhs conf)) ($right ,(scheme rhs conf)))
       ,(py:fl+fl '$left '$right)))
  (operands-are-unboxed-strings?
    `(let (($left ,(scheme lhs conf)) ($right ,(scheme rhs conf)))
       (string-append $left $right)))
  (else
    `(let (($left ,(scheme lhs conf)) ($right ,(scheme rhs conf)))
       (cond
         ((and (fixnum? $left) (fixnum? $right))
           ,(py:fx+fx '$left '$right))
         ((and (flonum? $left) (flonum? $right))
           ,(py:fl+fl '$left '$right))
         (else
           (py-add $left $right))))))

;; Dispatch
(define (default-python-op binop conf)
  `(,(symbol-append 'py- (PycBinary-op binop))
    ,(scheme (PycBinary-lhs binop) conf)
    ,(scheme (PycBinary-rhs binop) conf)))

(define (dispatch-PycBinary-to-decision-table pycbinary conf)
  (let ((op (PycBinary-op pycbinary)))
    (cond ((eq? op 'add) (add-decision-table pycbinary conf))
          (else (default-python-op pycbinary conf)))))
