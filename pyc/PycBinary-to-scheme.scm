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
    ((gambit: (|##arithmetic-shift| left right)))
     (bigloo: (bit-lsh left right))
    (py-lshift-sintX-sintNeg1-fallback left)))

;; BIT-SHIFT-RIGHT
(define-operator (py-fx>> left right)
  (if ((gambit: (|##fx>=| right 0))
       (bigloo: (>=fx right 0)))
    ((gambit: (or (|##fxarithmetic-shift-right?| left right)
                  (py-bint-from-scheme (|##arithmetic-shift| left (||##negate| right)))))
     (bigloo: (py-int-from-scheme (bit-rsh left right))))
    (py-rshift-sintX-sintNeg1-fallback left)))

(define-operator (unboxed-fx>> left right)
  (if ((gambit: (|##fx>=| right 0))
       (bigloo: (>=fx right 0)))
    ((gambit: (|##arithmetic-shift| left (||##negate| right))))
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
(define-predicate (operands-are-complex-literals? pycbinary conf)
  (operands-number-literals-value-are? pycbinary (lambda (value) (not (real? value)))))

(define-predicate (operands-are-int-literals? pycbinary conf)
  (operands-number-literals-value-are? pycbinary (lambda (value) (and (real? value) (not (flonum? value))))))

(define-predicate (operands-are-int-or-float-literals? pycbinary conf)
  (operands-number-literals-value-are? pycbinary real?))

(define-predicate (operands-are-string-literals? pycbinary conf)
  (operands-are? pycbinary (lambda (operand) (isa? operand PycString))))

(define-predicate (operands-are-unboxed-integers? pycbinary conf)
  (operands-are? pycbinary (lambda (value) (and (real? value) (not (flonum? value))))))

(define-predicate (operands-are-unboxed-fixnums? pycbinary conf)
  (operands-are-statically-typed-as? pycbinary 'Usint))

(define-predicate (operands-are-unboxed-integers? pycbinary conf)
  (or
    (operands-are-statically-typed-as? pycbinary 'Uint)
    (operands-are-statically-typed-as? pycbinary 'Ubint)
    (operands-are-statically-typed-as? pycbinary 'Usint)))

(define-predicate (operands-are-unboxed-bool? pycbinary conf)
  (operands-are-statically-typed-as? pycbinary 'Ubool))

(define-predicate (operands-are-unboxed-flonums? pycbinary conf)
  (operands-are-statically-typed-as? pycbinary 'Ufloat))

(define-predicate (operands-are-unboxed-strings? pycbinary conf)
  (operands-are-statically-typed-as? pycbinary 'Ustr))

(define-predicate (lhs-is-a-str-literal? pycbinary conf)
  (lhs-is? pycbinary (lambda (lhs) (isa? lhs PycString))))

(define-predicate (rhs-is-a-str-literal? pycbinary conf)
  (rhs-is? pycbinary (lambda (rhs) (isa? rhs PycString))))

(define-predicate (lhs-is-a-sint-literal? pycbinary conf)
  (lhs-number-literal-value-is? pycbinary fixnum?))

(define-predicate (rhs-is-a-sint-literal? pycbinary conf)
  (rhs-number-literal-value-is? pycbinary fixnum?))

(define-predicate (lhs-is-a-float-literal? pycbinary conf)
  (lhs-number-literal-value-is? pycbinary flonum?))

(define-predicate (rhs-is-a-float-literal? pycbinary conf)
  (rhs-number-literal-value-is? pycbinary flonum?))

(define-predicate (lhs-could-be-sint? pycbinary conf)
  (or
    (lhs-is? pycbinary (lambda (lhs) (not (isa? lhs PycLiteralValue))))
    (lhs-is-a-sint-literal? pycbinary conf)))

(define-predicate (rhs-could-be-sint? pycbinary conf)
  (or
    (rhs-is? pycbinary (lambda (rhs) (not (isa? rhs PycLiteralValue))))
    (rhs-is-a-sint-literal? pycbinary conf)))

(define-predicate (operands-could-be-sint? pycbinary conf)
  (and
    (lhs-could-be-sint? pycbinary conf)
    (rhs-could-be-sint? pycbinary conf)))

(define-predicate (lhs-could-be-float? pycbinary conf)
  (or
    (lhs-is? pycbinary (lambda (lhs) (not (isa? lhs PycLiteralValue))))
    (lhs-is-a-float-literal? pycbinary conf)))

(define-predicate (rhs-could-be-float? pycbinary conf)
  (or
    (rhs-is? pycbinary (lambda (rhs) (not (isa? rhs PycLiteralValue))))
    (rhs-is-a-float-literal? pycbinary conf)))

(define-predicate (operands-could-be-float? pycbinary conf)
  (and
    (lhs-could-be-float? pycbinary conf)
    (rhs-could-be-float? pycbinary conf)))

(define-predicate (rhs-is-non-negative-literal? pycbinary conf)
  (rhs-number-literal-value-is? pycbinary (lambda (val) (>= val 0))))

(define-predicate (rhs-is-non-zero-literal? pycbinary conf)
  (rhs-number-literal-value-is? pycbinary (lambda (val) (not (= val 0)))))


;; =====================================================================
;; Decision tables
;; =====================================================================

(define (PycBinary-default-case this conf fx-op fl-op py-op)
  (let (($left (my-gensym 'left))
        ($right (my-gensym 'right)))
    `(let ((,$left ,(scheme (PycBinary-lhs this) conf))
           (,$right ,(scheme (PycBinary-rhs this) conf)))
       (cond
         ,@(filter-false*
           (and
             fx-op
             (operands-could-be-sint? this conf)
              `((and (fixnum? ,$left) (fixnum? ,$right)) (,fx-op ,$left ,$right)))
           (and
             fl-op
             (operands-could-be-float? this conf)
             `((and (flonum? ,$left) (flonum? ,$right)) (,fl-op ,$left ,$right)))
           `(else
             (,py-op ,$left ,$right)))))))

;; ADDITION
(define-PycBinary-to-scheme (add-to-scheme this conf (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
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
    (PycBinary-default-case this conf 'py-fx+ 'py-fl+ 'py-add)))

;; SUBTRACTION
(define-PycBinary-to-scheme (sub-to-scheme this conf (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
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
    (PycBinary-default-case this conf 'py-fx- 'py-fl- 'py-sub)))

;; MULTIPLICATION
(define-PycBinary-to-scheme (mul-to-scheme this conf (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
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
    (PycBinary-default-case this conf 'py-fx* 'py-fl* 'py-mul)))

;; EXPONENT
(define-PycBinary-to-scheme (pow-to-scheme this conf (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
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
    (PycBinary-default-case this conf 'py-fx** 'py-fl** 'py-pow)))

;; BITAND
(define-PycBinary-to-scheme (bitand-to-scheme this conf (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (operands-are-int-literals?
    (let ((result (bitwise-and (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))))
      (if (fixnum? result) result `(py-bint-from-scheme ,result))))
  (operands-are-unboxed-fixnums?
    (unboxed-fx& (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-integers?
    `(bitwise-and ,(scheme lhs conf) ,(scheme rhs conf)))
  (else
    (PycBinary-default-case this conf 'py-fx& #f 'py-pow)))

;; BITOR
(define-PycBinary-to-scheme (bitor-to-scheme this conf (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (operands-are-int-literals?
    (let ((result (bitwise-ior (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))))
      (if (fixnum? result) result `(py-bint-from-scheme ,result))))
  (operands-are-unboxed-fixnums?
    (unboxed-fx-or (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-integers?
    `(bitwise-and ,(scheme lhs conf) ,(scheme rhs conf)))
  (else
    (PycBinary-default-case this conf 'py-fx-or #f 'py-bitor)))

;; XOR
(define-PycBinary-to-scheme (xor-to-scheme this conf (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (operands-are-int-literals?
    (let ((result (bitwise-xor (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))))
      (if (fixnum? result) result `(py-bint-from-scheme ,result))))
  (operands-are-unboxed-fixnums?
    (unboxed-fx^ (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-integers?
    `(bitwise-xor ,(scheme lhs conf) ,(scheme rhs conf)))
  (else
    (PycBinary-default-case this conf 'py-fx^ #f 'py-xor)))

;; SHIFT-LEFT
(define-PycBinary-to-scheme (lshift-to-scheme this conf (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  ((and operands-are-int-literals? rhs-is-non-negative-literal?)
    (let ((result (arithmetic-shift (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))))
      (if (fixnum? result) result `(py-bint-from-scheme ,result))))
  (operands-are-unboxed-fixnums?
    (unboxed-fx<< (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-integers?
    `(arithmetic-shift ,(scheme lhs conf) ,(scheme rhs conf)))
  (else
    (PycBinary-default-case this conf 'py-fx<< #f 'py-lshift)))

;; SHIFT-RIGHT
(define-PycBinary-to-scheme (rshift-to-scheme this conf (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  ((and operands-are-int-literals? rhs-is-non-negative-literal?)
    (let ((result (arithmetic-shift (PycLiteralValue-val lhs) (- (PycLiteralValue-val rhs)))))
      (if (fixnum? result) result `(py-bint-from-scheme ,result))))
  (operands-are-unboxed-fixnums?
    (unboxed-fx>> (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-integers?
    `(arithmetic-shift ,(scheme lhs conf) (- ,(scheme rhs conf))))
  (else
    (PycBinary-default-case this conf 'py-fx>> #f 'py-rshift)))

;; FLOORDIV
(define-PycBinary-to-scheme (floordiv-to-scheme this conf (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  ((and operands-are-int-literals? rhs-is-non-zero-literal?)
    (let ((result (quotient (PycLiteralValue-val lhs) (- (PycLiteralValue-val rhs)))))
      (if (fixnum? result) result `(py-bint-from-scheme ,result))))
  (operands-are-unboxed-fixnums?
    (unboxed-fx// (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-integers?
    `(quotient ,(scheme lhs conf) (- ,(scheme rhs conf))))
  (else
    (PycBinary-default-case this conf 'py-fx// py-fl// 'py-floordiv)))

;; TRUEDIV
(define-PycBinary-to-scheme (truediv-to-scheme this conf (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  ((and operands-are-int-literals? rhs-is-non-zero-literal?)
    (let ((result (exact->inexact (/ (PycLiteralValue-val lhs) (- (PycLiteralValue-val rhs))))))
      (if (fixnum? result) result `(py-bint-from-scheme ,result))))
  (operands-are-unboxed-fixnums?
    (unboxed-fx/ (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-integers?
    `(exact->inexact (/ ,(scheme lhs conf) (- ,(scheme rhs conf)))))
  (else
    (PycBinary-default-case this conf 'py-fx/ py-fl/ 'py-truediv)))à

;; MODULO
(define-PycBinary-to-scheme (modulo-to-scheme this conf (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  ((and operands-are-int-literals? rhs-is-non-zero-literal?)
    (let ((result (modulo (PycLiteralValue-val lhs) (- (PycLiteralValue-val rhs)))))
      (if (fixnum? result) result `(py-bint-from-scheme ,result))))
  (operands-are-unboxed-fixnums?
    (unboxed-fx% (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-integers?
    `(modulo ,(scheme lhs conf) (- ,(scheme rhs conf))))
  (else
    (PycBinary-default-case this conf 'py-fx% py-fl% 'py-mod)))

;; Dispatch
(define (default-python-op binop conf)
  `(,(symbol-append 'py- (PycBinary-op binop))
    ,(scheme (PycBinary-lhs binop) conf)
    ,(scheme (PycBinary-rhs binop) conf)))

(define (PycBinary-to-scheme pycbinary conf)
  (let ((op (PycBinary-op pycbinary)))
    (cond ((eq? op 'add) (add-to-scheme pycbinary conf))
          ((eq? op 'sub) (sub-to-scheme pycbinary conf))
          ((eq? op 'mul) (mul-to-scheme pycbinary conf))
          ((eq? op 'pow) (pow-to-scheme pycbinary conf))
          ((eq? op 'bitand) (bitand-to-scheme pycbinary conf))
          ((eq? op 'bitor) (bitor-to-scheme pycbinary conf))
          ((eq? op 'xor) (xor-to-scheme pycbinary conf))
          ((eq? op 'lshift) (lshift-to-scheme pycbinary conf))
          ((eq? op 'rshift) (rshift-to-scheme pycbinary conf))
          ((eq? op 'floordiv) (floordiv-to-scheme pycbinary conf))
          ((eq? op 'truediv) (truediv-to-scheme pycbinary conf))
          ((eq? op 'mod) (mod-to-scheme pycbinary conf))
          (else (default-python-op pycbinary conf)))))
