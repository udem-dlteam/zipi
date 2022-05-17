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

(define-macro (define-PycBinary-to-scheme signature . body)
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
    (if (and (pair? predicate) (memq (car predicate) '(or and not)))
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

;; EXPONENT
(define-operator (py-fx** left right)
  (py-int-from-scheme (expt left right)))

(define-operator (unboxed-fx** left right)
  (expt left right))

(define-operator (py-fl** left right)
  (expt left right))

;; BIT-AND
(define-operator (py-fx& left right)
  ((gambit: (|##fxand| left right))
   (bigloo: (bit-and left right))))

(define-operator (unboxed-fx& left right)
  ((gambit: (|##fxand| left right))
   (bigloo: (bit-and left right))))

;; BIT-OR
(define-operator (py-fx-or left right)
  ((gambit: (|##fxior| left right))
   (bigloo: (bit-or left right))))

(define-operator (unboxed-fx-or left right)
  ((gambit: (|##fxxor| left right))
   (bigloo: (bit-or left right))))

;; BIT-XOR
(define-operator (py-fx^ left right)
  ((gambit: (|##fxxor| left right))
   (bigloo: (bit-xor left right))))

(define-operator (unboxed-fx^ left right)
  ((gambit: (|##fxor| left right))
   (bigloo: (bit-xor left right))))

;; BIT-SHIFT-LEFT
(define-operator (py-fx<< left right)
  (if ((gambit: (|##fx>=| right 0))
       (bigloo: (>=fx right 0)))
    ((gambit: (or (|##fxarithmetic-shift-left?| left right)
                  (py-bint-from-scheme (|##arithmetic-shift| left right))))
     (bigloo: (py-int-from-scheme (bit-lsh left right))))
    (py-lshift-sintX-sintNeg1-fallback left)))

(define-operator (unboxed-fx<< left right)
  (if ((gambit: (|##fx>=| right 0))
       (bigloo: (>=fx right 0)))
    ((gambit: (|##arithmetic-shift| left right))
     (bigloo: (bit-lsh left right)))
    (py-lshift-sintX-sintNeg1-fallback left)))

;; BIT-SHIFT-RIGHT
(define-operator (py-fx>> left right)
  (if ((gambit: (|##fx>=| right 0))
       (bigloo: (>=fx right 0)))
    ((gambit: (or (|##fxarithmetic-shift-right?| left right)
                  (py-bint-from-scheme (|##arithmetic-shift| left (|##negate| right)))))
     (bigloo: (py-int-from-scheme (bit-rsh left right))))
    (py-rshift-sintX-sintNeg1-fallback left)))

(define-operator (unboxed-fx>> left right)
  (if ((gambit: (|##fx>=| right 0))
       (bigloo: (>=fx right 0)))
    ((gambit: (|##arithmetic-shift| left (|##negate| right))))
     (bigloo: (bit-rsh left right))
    (py-rshift-sintX-sintNeg1-fallback left)))

;; FLOORDIV

(define-operator (py-fx// left right)
  (if ((gambit: (|##fx=| right 0))
       (bigloo: (=fx right 0)))
    (py-floordiv-sintX-sint0-fallback left)
    ((gambit: (|##fxquotient| left right))
     (bigloo: (quotientfx left right)))))

(define-operator (unboxed-fx// left right)
  (if ((gambit: (|##fx=| right 0))
       (bigloo: (=fx right 0)))
    (py-floordiv-sintX-sint0-fallback left)
    ((gambit: (|##fxquotient| left right))
     (bigloo: (quotientfx left right)))))

(define-operator (py-fl// left right)
  (if ((gambit: (|##fl=| right 0.0))
       (bigloo: (=fl right 0.0)))
    (py-floordiv-floatX-float0-fallback left)
    ((gambit: (|##flfloor| (|##fl/| left right)))
     (bigloo: (floorfl (/fl left right))))))

;; TRUEDIV

(define-operator (py-fx/ left right)
  (if ((gambit: (|##fx=| right 0))
       (bigloo: (=fx right 0)))
    (py-truediv-sintX-sint0-fallback left)
    ((gambit: (|##fl/| (|##fixnum->flonum| left) (|##fixnum->flonum| right)))
     (bigloo: (/ left right)))))

(define-operator (unboxed-fx/ left right)
  (if ((gambit: (|##fx=| right 0))
       (bigloo: (=fx right 0)))
    (py-truediv-sintX-sint0-fallback left)
    ((gambit: (|##fl/| (|##fixnum->flonum| left) (|##fixnum->flonum| right)))
     (bigloo: (/ left right)))))

(define-operator (py-fl/ left right)
  (if ((gambit: (|##fl=| right 0.0))
       (bigloo: (=fl right 0.0)))
    (py-truediv-floatX-float0-fallback left)
    ((gambit: (|##fl/| left right))
     (bigloo:(/fl left right)))))

;; MODULO

(define-operator (py-fx% left right)
  (if ((gambit: (|##fx=| right 0))
       (bigloo: (=fx right 0)))
    (py-mod-sintX-sint0-fallback left)
    ((gambit: (|##fxmodulo| left right))
     (bigloo: (fxmodulo left right)))))

(define-operator (unboxed-fx% left right)
  (if ((gambit: (|##fx=| right 0))
       (bigloo: (=fx right 0)))
    (py-mod-sintX-sint0-fallback left)
    ((gambit: (|##fxmodulo| left right))
     (bigloo: (fxmodulo left right)))))

(define-operator (py-fl% left right)
  (if ((gambit: (|##fl=| right 0.0))
       (bigloo: (=fl right 0.0)))
    (py-mod-floatX-float0-fallback left)
    ((gambit:
      (let (($temp (fl/ left right)))
        (|##fl-| left
                 (|##fl*| right
                          (if (|##fl<| 0.0 left)
                              (|##flfloor| $temp)
                              (|##flceiling| $temp))))))
     (bigloo:
       (let (($temp (/fl left right)))
         (-fl left
              (*fl right
                   (if (<fl 0.0 left)
                       (floorfl $temp)
                       (ceilingfl $temp)))))))))

;; COMPARISON OPERATORS

(define-macro (define-comparison-operators symbol)
  (let ((py-fx (string->symbol (string-append "py-fx" (symbol->string symbol))))
        (unboxed-integer (string->symbol (string-append "unboxed-integer" (symbol->string symbol))))
        (py-test-fx (string->symbol (string-append "py-test-fx" (symbol->string symbol))))
        (unboxed-test-integer (string->symbol (string-append "unboxed-test-integer" (symbol->string symbol))))
        (py-fl (string->symbol (string-append "py-fl" (symbol->string symbol))))
        (py-test-fl (string->symbol (string-append "py-test-fl" (symbol->string symbol))))
        (gambit-fx-op (string->symbol (string-append "##fx" (symbol->string symbol))))
        (bigloo-fx-op (string->symbol (string-append (symbol->string symbol) "fx")))
        (gambit-fl-op (string->symbol (string-append "##fl" (symbol->string symbol))))
        (bigloo-fl-op (string->symbol (string-append (symbol->string symbol) "fl"))))
    `(begin
      (define-operator (,py-fx left right)
        (if ((gambit: (,gambit-fx-op left right))
             (bigloo: (,bigloo-fx-op left right)))
          py-True
          py-False))

      (define-operator (,unboxed-integer left right)
        (if (,symbol left right)
          py-True
          py-False))

      (define-operator (,py-test-fx  left right)
        ((gambit: (,gambit-fx-op left right))
         (bigloo: (,bigloo-fx-op left right))))

      (define-operator (,unboxed-test-integer  left right)
        (,symbol left right))

      (define-operator (,py-fl left right)
        (if ((gambit: (,gambit-fl-op left right))
             (bigloo: (,bigloo-fl-op left right)))
          py-True
          py-False))

      (define-operator (,py-test-fl left right)
        ((gambit: (,gambit-fl-op left right))
         (bigloo: (,bigloo-fl-op left right)))))))

(define-comparison-operators =)
(define-comparison-operators >)
(define-comparison-operators >=)
(define-comparison-operators <)
(define-comparison-operators <=)

;; NEQ
(define-operator (py-fx!= left right)
  (if ((gambit: (|##fx=| left right))
       (bigloo: (=fx left right)))
    py-False
    py-True))

(define-operator (unboxed-integer!= left right)
  (if (= left right)
    py-False
    py-True))

(define-operator (py-test-fx!= left right)
  (not ((gambit: (|##fx=| left right))
        (bigloo: (=fx left right)))))

(define-operator (unboxed-test-integer!= left right)
  (not (= left right)))

(define-operator (py-fl!= left right)
  (if ((gambit: (|##fl=| left right))
       (bigloo: (=fl left right)))
    py-False
    py-True))

(define-operator (py-test-fl!= left right)
  (not ((gambit: (|##fl=| left right))
        (bigloo: (=fl left right)))))

;; String literal operations

(define (py-mul-str-literal pycstring pycnumber conf)
  (let ((string (PycLiteralValue-val pycstring))
        (number (PycLiteralValue-val pycnumber)))
    (if (< (* (string-length string) number) 10000) ;; Put some arbitrary limit on the result size at compile-time
      (scheme (new-PycString (PycNode-loc pycstring) (fold string-append "" (make-list number string))) conf)
      #f)))
;; =====================================================================
;; Predicates
;; =====================================================================

(define-macro (define-predicate . rest)
  `(define ,@rest))

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
(define-predicate (operands-are-complex-literals? pycbinary conf params)
  (operands-number-literals-value-are? pycbinary (lambda (value) (not (real? value)))))

(define-predicate (operands-are-int-literals? pycbinary conf params)
  (operands-number-literals-value-are? pycbinary (lambda (value) (and (real? value) (not (flonum? value))))))

(define-predicate (operands-are-int-or-float-literals? pycbinary conf params)
  (operands-number-literals-value-are? pycbinary real?))

(define-predicate (operands-are-string-literals? pycbinary conf params)
  (operands-are? pycbinary (lambda (operand) (isa? operand PycString))))

(define-predicate (operands-are-unboxed-integers? pycbinary conf params)
  (operands-are? pycbinary (lambda (value) (and (real? value) (not (flonum? value))))))

(define-predicate (operands-are-unboxed-fixnums? pycbinary conf params)
  (operands-are-statically-typed-as? pycbinary 'Usint))

(define-predicate (operands-are-unboxed-integers? pycbinary conf params)
  (or
    (operands-are-statically-typed-as? pycbinary 'Uint)
    (operands-are-statically-typed-as? pycbinary 'Ubint)
    (operands-are-statically-typed-as? pycbinary 'Usint)))

(define-predicate (operands-are-unboxed-bool? pycbinary conf params)
  (operands-are-statically-typed-as? pycbinary 'Ubool))

(define-predicate (operands-are-unboxed-flonums? pycbinary conf params)
  (operands-are-statically-typed-as? pycbinary 'Ufloat))

(define-predicate (operands-are-unboxed-strings? pycbinary conf params)
  (operands-are-statically-typed-as? pycbinary 'Ustr))

(define-predicate (lhs-is-a-str-literal? pycbinary conf params)
  (lhs-is? pycbinary (lambda (lhs) (isa? lhs PycString))))

(define-predicate (rhs-is-a-str-literal? pycbinary conf params)
  (rhs-is? pycbinary (lambda (rhs) (isa? rhs PycString))))

(define-predicate (operands-are-str-literals? pycbinary conf params)
   (and (lhs-is-a-str-literal? pycbinary conf params)
        (rhs-is-a-str-literal? pycbinary conf params)))

(define-predicate (lhs-is-a-sint-literal? pycbinary conf params)
  (lhs-number-literal-value-is? pycbinary fixnum?))

(define-predicate (rhs-is-a-sint-literal? pycbinary conf params)
  (rhs-number-literal-value-is? pycbinary fixnum?))

(define-predicate (lhs-is-a-float-literal? pycbinary conf params)
  (lhs-number-literal-value-is? pycbinary flonum?))

(define-predicate (rhs-is-a-float-literal? pycbinary conf params)
  (rhs-number-literal-value-is? pycbinary flonum?))

(define-predicate (lhs-could-be-sint? pycbinary conf params)
  (or
    (lhs-is? pycbinary (lambda (lhs) (not (isa? lhs PycLiteralValue))))
    (lhs-is-a-sint-literal? pycbinary conf params)))

(define-predicate (rhs-could-be-sint? pycbinary conf params)
  (or
    (rhs-is? pycbinary (lambda (rhs) (not (isa? rhs PycLiteralValue))))
    (rhs-is-a-sint-literal? pycbinary conf params)))

(define-predicate (operands-could-be-sint? pycbinary conf params)
  (and
    (lhs-could-be-sint? pycbinary conf params)
    (rhs-could-be-sint? pycbinary conf params)))

(define-predicate (lhs-could-be-float? pycbinary conf params)
  (or
    (lhs-is? pycbinary (lambda (lhs) (not (isa? lhs PycLiteralValue))))
    (lhs-is-a-float-literal? pycbinary conf params)))

(define-predicate (rhs-could-be-float? pycbinary conf params)
  (or
    (rhs-is? pycbinary (lambda (rhs) (not (isa? rhs PycLiteralValue))))
    (rhs-is-a-float-literal? pycbinary conf params)))

(define-predicate (operands-could-be-float? pycbinary conf params)
  (and
    (lhs-could-be-float? pycbinary conf params)
    (rhs-could-be-float? pycbinary conf params)))

(define-predicate (rhs-is-non-negative-literal? pycbinary conf params)
  (rhs-number-literal-value-is? pycbinary (lambda (val) (>= val 0))))

(define-predicate (rhs-is-non-zero-literal? pycbinary conf params)
  (rhs-number-literal-value-is? pycbinary (lambda (val) (not (= val 0)))))

(define-predicate (must-return-host-bool pycbinary conf params)
  (let ((data (memq must-return-host-bool: params)))
    (and data (cadr data))))

;; =====================================================================
;; Decision tables
;; =====================================================================

(define (PycBinary-default-case this conf params fx-op fl-op py-op)
  (let (($left (my-gensym 'left))
        ($right (my-gensym 'right)))
    `(let ((,$left ,(scheme (PycBinary-lhs this) conf))
           (,$right ,(scheme (PycBinary-rhs this) conf)))
       (cond
         ,@(filter
           (lambda (x) x)
           (list
             (and
               fx-op
               (operands-could-be-sint? this conf)
                `((and (fixnum? ,$left) (fixnum? ,$right)) ,(fx-op $left $right)))
             (and
               fl-op
               (operands-could-be-float? this conf)
               `((and (flonum? ,$left) (flonum? ,$right)) ,(fl-op $left $right)))
             `(else
               (,py-op ,$left ,$right))))))))

;; ADDITION
(define-PycBinary-to-scheme (add-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
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
    (PycBinary-default-case this conf params py-fx+ py-fl+ 'py-add)))

;; SUBTRACTION
(define-PycBinary-to-scheme (sub-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
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
    (PycBinary-default-case this conf params py-fx- py-fl- 'py-sub)))

;; MULTIPLICATION
(define-PycBinary-to-scheme (mul-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
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
  ((and lhs-is-a-str-literal? rhs-is-a-sint-literal?)
    (or (py-mul-str-literal lhs rhs conf) `(py-mul ,(scheme lhs conf) ,(scheme rhs conf))))
  ((and lhs-is-a-sint-literal? rhs-is-a-str-literal?)
    (or (py-mul-str-literal rhs lhs conf) `(py-mul ,(scheme lhs conf) ,(scheme rhs conf))))
  (else
    (PycBinary-default-case this conf params py-fx* py-fl* 'py-mul)))

;; EXPONENT
(define-PycBinary-to-scheme (pow-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (operands-are-int-literals?
    (let ((result (expt (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))))
      (if (fixnum? result) result `(py-bint-from-scheme ,result))))
  (operands-are-int-or-float-literals?
    (expt (PycLiteralValue-val lhs) (PycLiteralValue-val rhs)))
  (operands-are-unboxed-fixnums?
    (unboxed-fx** (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-integers?
    `(expt ,(scheme lhs conf) ,(scheme rhs conf)))
  (operands-are-unboxed-flonums?
    (py-fl** (scheme lhs conf) (scheme rhs conf)))
  (else
    (PycBinary-default-case this conf params py-fx** py-fl** 'py-pow)))

;; BITAND
(define-PycBinary-to-scheme (bitand-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (operands-are-int-literals?
    (let ((result (bitwise-and (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))))
      (if (fixnum? result) result `(py-bint-from-scheme ,result))))
  (operands-are-unboxed-fixnums?
    (unboxed-fx& (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-integers?
    `(bitwise-and ,(scheme lhs conf) ,(scheme rhs conf)))
  (else
    (PycBinary-default-case this conf params py-fx& #f 'py-pow)))

;; BITOR
(define-PycBinary-to-scheme (bitor-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (operands-are-int-literals?
    (let ((result (bitwise-ior (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))))
      (if (fixnum? result) result `(py-bint-from-scheme ,result))))
  (operands-are-unboxed-fixnums?
    (unboxed-fx-or (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-integers?
    `(bitwise-and ,(scheme lhs conf) ,(scheme rhs conf)))
  (else
    (PycBinary-default-case this conf params py-fx-or #f 'py-bitor)))

;; XOR
(define-PycBinary-to-scheme (xor-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (operands-are-int-literals?
    (let ((result (bitwise-xor (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))))
      (if (fixnum? result) result `(py-bint-from-scheme ,result))))
  (operands-are-unboxed-fixnums?
    (unboxed-fx^ (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-integers?
    `(bitwise-xor ,(scheme lhs conf) ,(scheme rhs conf)))
  (else
    (PycBinary-default-case this conf params py-fx^ #f 'py-xor)))

;; SHIFT-LEFT
(define-PycBinary-to-scheme (lshift-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  ((and operands-are-int-literals? rhs-is-non-negative-literal?)
    (let ((result (arithmetic-shift (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))))
      (if (fixnum? result) result `(py-bint-from-scheme ,result))))
  (operands-are-unboxed-fixnums?
    (unboxed-fx<< (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-integers?
    `(arithmetic-shift ,(scheme lhs conf) ,(scheme rhs conf)))
  (else
    (PycBinary-default-case this conf params py-fx<< #f 'py-lshift)))

;; SHIFT-RIGHT
(define-PycBinary-to-scheme (rshift-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  ((and operands-are-int-literals? rhs-is-non-negative-literal?)
    (let ((result (arithmetic-shift (PycLiteralValue-val lhs) (- (PycLiteralValue-val rhs)))))
      (if (fixnum? result) result `(py-bint-from-scheme ,result))))
  (operands-are-unboxed-fixnums?
    (unboxed-fx>> (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-integers?
    `(arithmetic-shift ,(scheme lhs conf) (- ,(scheme rhs conf))))
  (else
    (PycBinary-default-case this conf params py-fx>> #f 'py-rshift)))

;; FLOORDIV
(define-PycBinary-to-scheme (floordiv-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  ((and operands-are-int-literals? rhs-is-non-zero-literal?)
    (let ((result (quotient (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))))
      (if (fixnum? result) result `(py-bint-from-scheme ,result))))
  (operands-are-unboxed-fixnums?
    (unboxed-fx// (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-integers?
    `(quotient ,(scheme lhs conf) ,(scheme rhs conf)))
  (else
    (PycBinary-default-case this conf params py-fx// py-fl// 'py-floordiv)))

;; TRUEDIV
(define-PycBinary-to-scheme (truediv-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  ((and operands-are-int-literals? rhs-is-non-zero-literal?)
    (exact->inexact (/ (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))))
  (operands-are-unboxed-fixnums?
    (unboxed-fx/ (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-integers?
    `(exact->inexact (/ ,(scheme lhs conf) ,(scheme rhs conf))))
  (else
    (PycBinary-default-case this conf params py-fx/ py-fl/ 'py-truediv)))

;; MODULO
(define-PycBinary-to-scheme (mod-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  ((and operands-are-int-literals? rhs-is-non-zero-literal?)
    (let ((result (modulo (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))))
      (if (fixnum? result) result `(py-bint-from-scheme ,result))))
  (operands-are-unboxed-fixnums?
    (unboxed-fx% (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-integers?
    `(modulo ,(scheme lhs conf) ,(scheme rhs conf)))
  (else
    (PycBinary-default-case this conf params py-fx% py-fl% 'py-mod)))

;; COMPARISONS
(define-macro (define-comparisons-to-scheme op-name py-fx unboxed-integer py-fl py-op
                                            op-test-name py-test-fx unboxed-test-integer py-test-fl py-test-op
                                            op string-op)
  `(begin
    (define-PycBinary-to-scheme (,op-name this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
      (must-return-host-bool
        (,op-test-name this conf params))
      (operands-are-int-or-float-literals?
        (if (,op (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))
            'py-True
            'py-False))
      (operands-are-str-literals?
        (if (,string-op (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))
            'py-True
            'py-False))
      (operands-are-unboxed-fixnums?
        (,py-fx (scheme lhs conf) (scheme rhs conf)))
      (operands-are-unboxed-integers?
        (,unboxed-integer (scheme lhs conf) (scheme rhs conf)))
      (operands-are-unboxed-flonums?
        (,py-fl (scheme lhs conf) (scheme rhs conf)))
      (else
        (PycBinary-default-case this conf params ,py-fx ,py-fl (quote ,py-op))))

    (define-PycBinary-to-scheme (,op-test-name this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
      (operands-are-int-or-float-literals?
        (,op (PycLiteralValue-val lhs) (PycLiteralValue-val rhs)))
      (operands-are-str-literals?
        (,string-op (PycLiteralValue-val lhs) (PycLiteralValue-val rhs)))
      (operands-are-unboxed-fixnums?
        (,py-test-fx (scheme lhs conf) (scheme rhs conf)))
      (operands-are-unboxed-integers?
        (,unboxed-test-integer (scheme lhs conf) (scheme rhs conf)))
      (operands-are-unboxed-flonums?
        (,py-test-fl (scheme lhs conf) (scheme rhs conf)))
      (else
        (PycBinary-default-case this conf params ,py-test-fx ,py-test-fl (quote ,py-test-op))))))

;; EQ
(define-comparisons-to-scheme eq-to-scheme
                              py-fx= unboxed-integer= py-fl= py-eq
                              test-eq-to-scheme
                              py-test-fx= unboxed-test-integer= py-test-fl= py-test-eq
                              = string=?)

;; GT
(define-comparisons-to-scheme gt-to-scheme
                              py-fx> unboxed-integer> py-fl> py-gt
                              test-gt-to-scheme
                              py-test-fx> unboxed-test-integer> py-test-fl> py-test-gt
                              > string>?)

;; GE
(define-comparisons-to-scheme ge-to-scheme
                              py-fx>= unboxed-integer>= py-fl>= py-ge
                              test-ge-to-scheme
                              py-test-fx>= unboxed-test-integer>= py-test-fl>= py-test-ge
                              >= string>=?)

;; LT
(define-comparisons-to-scheme lt-to-scheme
                              py-fx< unboxed-integer< py-fl< py-lt
                              test-lt-to-scheme
                              py-test-fx< unboxed-test-integer< py-test-fl< py-test-lt
                              < string<?)

;; LE
(define-comparisons-to-scheme le-to-scheme
                              py-fx<= unboxed-inteler<= py-fl<= py-le
                              test-le-to-scheme
                              py-test-fx<= unboxed-test-inteler<= py-test-fl<= py-test-le
                              <= string<=?)

;; NE
(define-PycBinary-to-scheme (ne-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (must-return-host-bool
    (test-ne-to-scheme this conf params))
  (operands-are-int-or-float-literals?
    (if (= (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))
        'py-False
        'py-True))
  (operands-are-str-literals?
    (if (string=? (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))
        'py-False
        'py-True))
  (operands-are-unboxed-fixnums?
    (py-fx!= (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-integers?
    (unboxed-integer!= (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-flonums?
    (py-fl!= (scheme lhs conf) (scheme rhs conf)))
  (else
    (PycBinary-default-case this conf params py-fx!= py-fl!= 'py-ne)))

(define-PycBinary-to-scheme (test-ne-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (operands-are-int-or-float-literals?
    (not (= (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))))
  (operands-are-str-literals?
    (not (string=? (PycLiteralValue-val lhs) (PycLiteralValue-val rhs)))
  (operands-are-unboxed-fixnums?
    (py-test-fx!= (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-integers?
    (unboxed-test-integer!= (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-flonums?
    (py-test-fl!= (scheme lhs conf) (scheme rhs conf)))
  (else
    (PycBinary-default-case this conf params py-test-fx!= py-test-fl!= 'py-test-ne))))

;; Dispatch
(define (default-python-op binop conf params)
  `(,(symbol-append 'py- (PycBinary-op binop))
    ,(scheme (PycBinary-lhs binop) conf)
    ,(scheme (PycBinary-rhs binop) conf)))

(define (PycBinary-to-scheme pycbinary conf . rest)
  (if (> (length rest) 1) (error "PycBinary-to-scheme" "takes 3 arguments" (length rest)))

  (let ((params (if (> (length rest) 0) (list-ref rest 0) '()))
        (op (PycBinary-op pycbinary)))
    ;; TODO normal and inplace operations are the same
    ;; for int and float, change that if sequences other than
    ;; str are included
    (cond
          ;; arithmetic
          ((memq op '(add iadd)) (add-to-scheme pycbinary conf params))
          ((memq op '(sub isub)) (sub-to-scheme pycbinary conf params))
          ((memq op '(mul imul)) (mul-to-scheme pycbinary conf params))
          ((memq op '(pow ipow)) (pow-to-scheme pycbinary conf params))
          ((memq op '(bitand ibitand)) (bitand-to-scheme pycbinary conf params))
          ((memq op '(bitor ibitor)) (bitor-to-scheme pycbinary conf params))
          ((memq op '(xor ixor)) (xor-to-scheme pycbinary conf params))
          ((memq op '(lshift ilshift)) (lshift-to-scheme pycbinary conf params))
          ((memq op '(rshift irshift)) (rshift-to-scheme pycbinary conf params))
          ((memq op '(floordiv ifloordiv)) (floordiv-to-scheme pycbinary conf params))
          ((memq op '(truediv itruediv)) (truediv-to-scheme pycbinary conf params))
          ((memq op '(mod imod)) (mod-to-scheme pycbinary conf params))

          ;; comparisons
          ((eq? op 'eq) (eq-to-scheme pycbinary conf params))
          ((eq? op 'ne) (ne-to-scheme pycbinary conf params))
          ((eq? op 'gt) (gt-to-scheme pycbinary conf params))
          ((eq? op 'ge) (ge-to-scheme pycbinary conf params))
          ((eq? op 'lt) (lt-to-scheme pycbinary conf params))
          ((eq? op 'le) (le-to-scheme pycbinary conf params))

          (else (default-python-op pycbinary conf params)))))
