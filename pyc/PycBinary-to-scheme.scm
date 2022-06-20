;; =====================================================================
;; System-dependant operators
;; =====================================================================

(cond-expand
  (bigloo
    (define bitwise-xor bit-xor)
    (define bitwise-ior bit-or)
    (define bitwise-and bit-and)
    (define fold reduce))
  (gambit #f))

(define (replace-symbol sexp target replacement)
  (cond
    ((eq? sexp target) replacement)
    ((pair? sexp) (cons (replace-symbol (car sexp) target replacement)
                        (replace-symbol (cdr sexp) target replacement)))
    (else sexp)))

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
                (list (list (car arguments) (list ' unquote (car arguments))))
                (list 'unquote '$body)))
            (list
              'replace-symbol
              '$body
              (list 'quote (car arguments))
              (car arguments))))))

  `(replace-system
    (define ,signature
      ,(add-bindings (cdr signature) body))))

;; ADDITION
(define-operator (py-fx+ left right)
  ((gambit: (or (|##fx+?| left right) (py-bint-from-scheme (|##+2| left right))))
   (bigloo: (py-int-from-scheme (+fx/overflow left right)))))

(define-operator (py-test-fx+ left right)
  ((gambit: (not (eq? (|##fx+?| left right) 0)))
   (bigloo: (not (eq? (+fx/overflow left right) 0)))))

(define-operator (unboxed-fx+ left right)
  ((gambit: (or (|##fx+?| left right) (|##+2| left right)))
   (bigloo: (+fx/overflow left right))))

(define-operator (py-fl+ left right)
  ((gambit: (|##fl+| left right))
   (bigloo: (+fl left right))))

(define-operator (py-test-fl+ left right)
  ((gambit: (not (|##fl=| (|##fl+| left right) 0.0)))
   (bigloo: (not (=fl (+fl left right) 0.0)))))

(define-operator (unboxed-fx-fl+ left right)
 (((gambit: |##fl+|) (bigloo: +fl))
   (fixnum->flonum left)
   right))

(define-operator (unboxed-fl-fx+ left right)
 (((gambit: |##fl+|) (bigloo: +fl))
   left
   (fixnum->flonum right)))

(define (unboxed-str+ left right)
  ;; NOTE: defers code generation to the rts py-str-from-scheme macro whci recognizes py+
  `(py+ ,left ,right))

;; SUBTRACTION
(define-operator (py-fx- left right)
  ((gambit: (or (|##fx-?| left right) (py-bint-from-scheme (|##-2| left right))))
   (bigloo: (py-int-from-scheme (-fx/overflow left right)))))

(define-operator (py-test-fx- left right)
  ((gambit: (not (|##fx=| left right)))
   (bigloo: (not  (=fx fx left right)))))

(define-operator (unboxed-fx- left right)
  ((gambit: (or (|##fx-?| left right) (|##-2| left right)))
   (bigloo: (-fx/overflow left right))))

(define-operator (py-fl- left right)
  ((gambit: (|##fl-| left right))
   (bigloo: (-fl left right))))

(define-operator (py-test-fl- left right)
  ((gambit: (not (|##fl=| (|##fl-| left right) 0.0)))
   (bigloo: (not (=fl (-fl left right) 0.0)))))

(define-operator (unboxed-fx-fl- left right)
 (((gambit: |##fl-|) (bigloo: -fl))
   (fixnum->flonum left)
   right))

(define-operator (unboxed-fl-fx- left right)
 (((gambit: |##fl-|) (bigloo: -fl))
   left
   (fixnum->flonum right)))

;; MULTIPLICATION
(define-operator (py-fx* left right)
  ((gambit: (or (|##fx*?| left right) (py-bint-from-scheme (|##*2| left right))))
   (bigloo: (py-int-from-scheme (*fx/overflow left right)))))

(define-operator (py-test-fx* left right)
  ((gambit: (not (eq? (|##fx*?| left right) 0)))
   (bigloo: (not (eq? (*fx left right) 0)))))

(define-operator (unboxed-fx* left right)
  ((gambit: (or (|##fx*?| left right) (|##*2| left right)))
   (bigloo: (*fx/overflow left right))))

(define-operator (py-fl* left right)
  ((gambit: (|##fl*| left right))
   (bigloo: (*fl left right))))

(define-operator (py-test-fl* left right)
  ((gambit: (not (|##fl=| (|##fl*| left right) 0.0)))
   (bigloo: (not (=fl (*fl left right) 0.0)))))

  ;; TODO handle potential overflow
(define-operator (unboxed-fx-fl* left right)
 (((gambit: |##fl*|) (bigloo: *fl))
   (fixnum->flonum left)
   right))

(define-operator (unboxed-fl-fx* left right)
 (((gambit: |##fl*|) (bigloo: *fl))
   left
   (fixnum->flonum right)))

(define-operator (unboxed-real* left right)
 (((gambit: |##fl*|) (bigloo: *fl))
   (exact->inexact left)
   (exact->inexact right)))

;; EXPONENT
(define-operator (py-fx** left right)
  ((gambit:
    (if (|##fx>=| right 0)
        (py-int-from-scheme (expt left right))
        (expt left (fixnum->flonum right))))
   (bigloo:
     (if (>=fx right 0)
         (py-int-from-scheme (expt left right))
         (expt left (fixnum->flonum right))))))

(define-operator (py-test-fx** left right)
  (not (= (expt left right) 0)))

(define-operator (unboxed-fx** left right)
  ((gambit:
    (if (|##fx>=| right 0)
        (expt left right)
        (expt left (fixnum->flonum right))))
   (bigloo:
     (if (>=fx right 0)
         (expt left right)
         (expt left (fixnum->flonum right))))))

(define-operator (py-fl** left right)
  (expt left right))

(define-operator (py-test-fl** left right)
  (not (((gambit: |##fl=|) (bigloo: =fl)) (expt left right) 0.0)))

(define-operator (unboxed-fx-fl** left right)
 (expt
   (fixnum->flonum left)
   right))

(define-operator (unboxed-fl-fx** left right)
 (expt
   left
   (fixnum->flonum right)))

;; BIT-AND
(define-operator (py-fx& left right)
  ((gambit: (|##fxand| left right))
   (bigloo: (bit-and left right))))

(define-operator (py-test-fx& left right)
  ((gambit: (not (|##fx=| (|##fxand| left right) 0)))
   (bigloo: (not (=fx (bit-and left right) 0)))))

(define-operator (unboxed-fx& left right)
  ((gambit: (|##fxand| left right))
   (bigloo: (bit-and left right))))

(define-operator (unboxed-integer& left right)
  ((gambit: (bitwise-and left right))
   (bigloo: (bit-and left right))))

;; BIT-OR
(define-operator (py-fx-or left right)
  ((gambit: (|##fxior| left right))
   (bigloo: (bit-or left right))))

(define-operator (py-test-fx-or left right)
  ((gambit: (not (|##fx=| (|##fxior| left right) 0)))
   (bigloo: (not (=fx (bit-or left right) 0)))))

(define-operator (unboxed-fx-or left right)
  ((gambit: (|##fxxor| left right))
   (bigloo: (bit-or left right))))

(define-operator (unboxed-integer-or left right)
  ((gambit: (bitwise-ior left right))
   (bigloo: (bit-or left right))))

;; BIT-XOR
(define-operator (py-fx^ left right)
  ((gambit: (|##fxxor| left right))
   (bigloo: (bit-xor left right))))

(define-operator (py-test-fx^ left right)
  ((gambit: (not (|##fx=| (|##fxxor| left right) 0)))
   (bigloo: (not (=fx (bit-xor left right) 0)))))

(define-operator (unboxed-fx^ left right)
  ((gambit: (|##fxxor| left right))
   (bigloo: (bit-xor left right))))

(define-operator (unboxed-integer^ left right)
  ((gambit: (bitwise-xor left right))
   (bigloo: (bit-xor left right))))

;; BIT-SHIFT-LEFT
(define-operator (py-fx<< left right)
  ((gambit: (or (|##fxarithmetic-shift-left?| left right)
                (if (|##fx>=| right 0)
                   (py-bint-from-scheme (|##arithmetic-shift| left right))
                   (py-lshift-sintX-sintNeg1-fallback left))))
   (bigloo:
     (if (>=fx right 0)
         (py-int-from-scheme (bit-lsh left right))
         (py-lshift-sintX-sintNeg1-fallback left)))))

(define-operator (py-test-fx<< left right)
  ((gambit: (if (|##fx>=| right 0)
                (not (|##fx=| left 0))
                (py-lshift-sintX-sintNeg1-fallback left)))
   (bigloo:
     (if (>=fx right 0)
         (not (=fx left 0))
         (py-lshift-sintX-sintNeg1-fallback left)))))

(define-operator (unboxed-fx<< left right)
  ((gambit: (or (|##fxarithmetic-shift-left?| left right)
                (if (|##fx>=| right 0)
                   (|##arithmetic-shift| left right)
                   (py-lshift-sintX-sintNeg1-fallback left))))
   (bigloo:
     (if (>=fx right 0)
         (bit-lsh left right)
         (py-lshift-sintX-sintNeg1-fallback left)))))

(define-operator (unboxed-interger<< left right)
  ((gambit: (arithmetic-shift left right))
   (bigloo: (bit-lsh left right))))

;; BIT-SHIFT-RIGHT
(define-operator (py-fx>> left right)
  ((gambit: (or (|##fxarithmetic-shift-right?| left right)
                (py-rshift-sintX-sintNeg1-fallback left)))
   (bigloo:
     (if (>=fx right 0)
         (bit-rsh left right)
         (py-rshift-sintX-sintNeg1-fallback left)))))

(define-operator (py-test-fx>> left right)
  ((gambit: (not
              (|##fx=|
                (or (|##fxarithmetic-shift-right?| left right)
                    (py-rshift-sintX-sintNeg1-fallback left))
                0)))
   (bigloo:
     (if (>=fx right 0)
         (not (=fx (bit-rsh left right) 0))
         (py-rshift-sintX-sintNeg1-fallback left)))))

(define-operator (unboxed-fx>> left right)
  ((gambit: (or (|##fxarithmetic-shift-right?| left right)
                (py-rshift-sintX-sintNeg1-fallback left)))
   (bigloo:
     (if (>=fx right 0)
         (bit-rsh left right)
         (py-rshift-sintX-sintNeg1-fallback left)))))

(define-operator (unboxed-interger>> left right)
  ((gambit: (arithmetic-shift left (- right)))
   (bigloo: (bit-rsh left right))))

;; FLOORDIV

(define-operator (py-fx// left right)
  (if ((gambit: (|##fx=| right 0))
       (bigloo: (=fx right 0)))
    (py-floordiv-sintX-sint0-fallback left)
    ((gambit: (|##fxquotient| left right))
     (bigloo: (quotientfx left right)))))

(define-operator (py-test-fx// left right)
  (if ((gambit: (|##fx=| right 0))
       (bigloo: (=fx right 0)))
    (py-floordiv-sintX-sint0-fallback left)
    ((gambit: (or (|##fx<| left 0) (|##fx>=| left right)))
     (bigloo: (or (<fx left 0) (>=fx left right))))))

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

(define-operator (py-test-fl// left right)
  (not
    (((gambit: |##fl=|) (bigloo: =fl))
      (if ((gambit: (|##fl=| right 0.0))
           (bigloo: (=fl right 0.0)))
        (py-floordiv-floatX-float0-fallback left)
        ((gambit: (|##flfloor| (|##fl/| left right)))
         (bigloo: (floorfl (/fl left right)))))
      0.0)))

(define-operator (unboxed-fx-fl// left right)
  ((gambit: (|##flfloor| (|##fl/| (fixnum->flonum left) right)))
   (bigloo: (floorfl (/fl (fixnum->flonum left) right)))))

(define-operator (unboxed-fl-fx// left right)
  ((gambit: (|##flfloor| (|##fl/| left (fixnum->flonum right))))
   (bigloo: (floorfl (/fl left (fixnum->flonum right))))))

(define-operator (unboxed-real// left right)
  ((gambit: (|##flfloor| (|##fl/| (exact->inexact left) (exact->inexact right))))
   (bigloo: (floorfl (/fl (exact->inexact left) (exact->inexact right))))))

;; TRUEDIV

(define-operator (py-fx/ left right)
  (if ((gambit: (|##fx=| right 0))
       (bigloo: (=fx right 0)))
    (py-truediv-sintX-sint0-fallback left)
    ((gambit: (|##fl/| (|##fixnum->flonum| left) (|##fixnum->flonum| right)))
     (bigloo: (/ left right)))))

(define-operator (py-test-fx/ left right)
  (not
    (((gambit: |##fl=|) (bigloo: =fl))
    (if ((gambit: (|##fx=| right 0))
         (bigloo: (=fx right 0)))
      (py-truediv-sintX-sint0-fallback left)
      ((gambit: (|##fl/| (|##fixnum->flonum| left) (|##fixnum->flonum| right)))
       (bigloo: (/ left right))))
    0.0)))

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

(define-operator (py-test-fl/ left right)
  (not
    (((gambit: |##fl=|) (bigloo: =fl))
    (if ((gambit: (|##fl=| right 0.0))
         (bigloo: (=fl right 0.0)))
      (py-truediv-floatX-float0-fallback left)
      ((gambit: (|##fl/| left right))
       (bigloo:(/fl left right))))
    0.0)))

(define-operator (unboxed-fx-fl/ left right)
  ((gambit: (|##fl/| (fixnum->flonum left) right))
   (bigloo: (/fl (fixnum->flonum left) right))))

(define-operator (unboxed-fl-fx/ left right)
  ((gambit: (|##fl/| left (fixnum->flonum right)))
   (bigloo: (/fl left (fixnum->flonum right)))))

(define-operator (unboxed-real/ left right)
  ((gambit: (|##fl/| (exact->inexact left) (exact->inexact right)))
   (bigloo: (/fl (exact->inexact left) (exact->inexact right)))))

;; MODULO

(define-operator (py-fx% left right)
  (if ((gambit: (|##fx=| right 0))
       (bigloo: (=fx right 0)))
    (py-mod-sintX-sint0-fallback left)
    ((gambit: (|##fxmodulo| left right))
     (bigloo: (fxmodulo left right)))))

(define-operator (py-test-fx% left right)
  (not
    (((gambit: |##fx=|) (bigloo: =fx))
    (if ((gambit: (|##fx=| right 0))
         (bigloo: (=fx right 0)))
      (py-mod-sintX-sint0-fallback left)
      ((gambit: (|##fxmodulo| left right))
       (bigloo: (fxmodulo left right))))
    0)))

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
      (|##fl-| left (|##fl*| right (|##flfloor| (|##fl/| left right)))))
     (bigloo:
       (-fl left (*fl right (floorfl (/fl left right))))))))

(define-operator (py-test-fl% left right)
  (not
    (((gambit: |##fl=|) (bigloo: =fl))
      (if ((gambit: (|##fl=| right 0.0))
           (bigloo: (=fl right 0.0)))
        (py-mod-floatX-float0-fallback left)
        ((gambit:
          (|##fl-| left (|##fl*| right (|##flfloor| (|##fl/| left right)))))
         (bigloo:
           (-fl left (*fl right (floorfl (/fl left right)))))))
      0.0)))

(define-operator (unboxed-fx-fl% left right)
  ((gambit:
    (let* ((left (fixnum->flonum left)))
      (|##fl-| left (|##fl*| right (|##flfloor| (|##fl/| left right))))))
   (bigloo:
     (let* ((left (fixnum->flonum left)))
       (-fl left (*fl right (floorfl (/fl left right))))))))

(define-operator (unboxed-fl-fx% left right)
  ((gambit:
    (let* ((right (fixnum->flonum right)))
      (|##fl-| left (|##fl*| right (|##flfloor| (|##fl/| left right))))))
   (bigloo:
     (let* ((right (fixnum->flonum right)))
       (-fl left (*fl right (floorfl (/fl left right))))))))

(define-operator (unboxed-real% left right)
  ((gambit:
    (let* ((left (exact->inexact left))
           (right (exact->inexact right)))
      (|##fl-| left (|##fl*| right (|##flfloor| (|##fl/| left right))))))
   (bigloo:
     (le* ((left (exact->inexact left))
           (right (exact->inexact right)))
       (-fl left (*fl right (floorfl (/fl left right))))))))

;; COMPARISON OPERATORS

(define-macro (define-comparison-operators symbol)
  (let ((py-fx (string->symbol (string-append "py-fx" (symbol->string symbol))))
        (unboxed-real (string->symbol (string-append "unboxed-real" (symbol->string symbol))))
        (unboxed-fx-fl (string->symbol (string-append "unboxed-fx-fl" (symbol->string symbol))))
        (unboxed-fl-fx (string->symbol (string-append "unboxed-fl-fx" (symbol->string symbol))))
        (py-test-fx (string->symbol (string-append "py-test-fx" (symbol->string symbol))))
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

      (define-operator (,unboxed-fx-fl left right)
        ((gambit: (,gambit-fl-op (fixnum->flonum left) right))
         (bigloo: (,bigloo-fl-op (fixnum->flonum left) right))))

      (define-operator (,unboxed-fl-fx left right)
        ((gambit: (,gambit-fl-op left (fixnum->flonum right)))
         (bigloo: (,bigloo-fl-op left (fixnum->flonum right)))))

      (define-operator (,unboxed-real left right)
        (,symbol left right))

      (define-operator (,py-test-fx  left right)
        ((gambit: (,gambit-fx-op left right))
         (bigloo: (,bigloo-fx-op left right))))

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

(define-operator (unboxed-real!= left right)
  (not (= left right)))

(define-operator (unboxed-fx-fl!= left right)
  (not ((gambit: (|##fl=| (fixnum->flonxum left) right))
        (bigloo: (=fl (fixnum->flonxum left) right)))))

(define-operator (unboxed-fl-fx!= left right)
  (not ((gambit: (|##fl=| left (fixnum->flonum right)))
        (bigloo: (=fl left (fixnum->flonum right))))))

(define-operator (py-test-fx!= left right)
  (not ((gambit: (|##fx=| left right))
        (bigloo: (=fx left right)))))

(define-operator (py-fl!= left right)
  (if ((gambit: (|##fl=| left right))
       (bigloo: (=fl left right)))
    py-False
    py-True))

(define-operator (py-test-fl!= left right)
  (not ((gambit: (|##fl=| left right))
        (bigloo: (=fl left right)))))

(define-operator (py-mul-Uint-Ustr number string)
  (py-mul-UstrX-UintY string number))

(define-operator (py-mul-Ustr-Uint string number)
  (py-mul-UstrX-UintY string number))

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

(define (operands-are-statically-typed-as? pycbinary types)
  (let ((types (if (list? types) types (list types))))
    (and (lhs-is-statically-typed-as? pycbinary types)
         (rhs-is-statically-typed-as? pycbinary types))))

(define (lhs-is-statically-typed-as? pycbinary types)
  (let ((lhs-type-hint (PycBinary-lhs-type-hint pycbinary))
        (types (if (list? types) types (list types))))
    (and (memq lhs-type-hint types) #t)))

(define (rhs-is-statically-typed-as? pycbinary types)
  (let ((rhs-type-hint (PycBinary-rhs-type-hint pycbinary))
        (types (if (list? types) types (list types))))
    (and (memq rhs-type-hint types) #t)))

;; Predicates usable in table
(define-predicate (operands-are-complex-literals? pycbinary conf params)
  (operands-number-literals-value-are? pycbinary (lambda (value) (not (real? value)))))

(define-predicate (operands-are-int-literals? pycbinary conf params)
  (operands-number-literals-value-are? pycbinary (lambda (value) (and (real? value) (not (flonum? value))))))

(define-predicate (operands-are-int-or-float-literals? pycbinary conf params)
  (operands-number-literals-value-are? pycbinary real?))

(define-predicate (operands-are-string-literals? pycbinary conf params)
  (operands-are? pycbinary (lambda (operand) (isa? operand PycString))))

(define-predicate (operands-are-sint? pycbinary conf params)
  (operands-are-statically-typed-as? pycbinary 'sint))

(define-predicate (lhs-is-fixnum? pycbinary conf params)
  (lhs-is-statically-typed-as? pycbinary (list 'Usint 'Ubool)))

(define-predicate (rhs-is-fixnum? pycbinary conf params)
  (rhs-is-statically-typed-as? pycbinary (list 'Usint 'Ubool)))

(define-predicate (lhs-is-flonum? pycbinary conf params)
  (lhs-is-statically-typed-as? pycbinary 'Ufloat))

(define-predicate (rhs-is-flonum? pycbinary conf params)
  (rhs-is-statically-typed-as? pycbinary 'Ufloat))

(define-predicate (operands-are-unboxed-fixnums? pycbinary conf params)
  (operands-are-statically-typed-as? pycbinary '(Usint Ubool)))

(define-predicate (operands-are-unboxed-integers? pycbinary conf params)
  (operands-are-statically-typed-as? pycbinary '(Uint Ubint Usint)))

(define-predicate (operands-are-unboxed-bool? pycbinary conf params)
  (operands-are-statically-typed-as? pycbinary 'Ubool))

(define-predicate (operands-are-unboxed-reals? pycbinary conf params)
  (operands-are-statically-typed-as? pycbinary (list 'Uint 'Usint 'Ubint 'Ubool 'Ufloat)))

(define-predicate (operands-are-unboxed-flonums? pycbinary conf params)
  (operands-are-statically-typed-as? pycbinary 'Ufloat))

(define-predicate (operands-are-unboxed-strings? pycbinary conf params)
  (operands-are-statically-typed-as? pycbinary 'Ustr))

(define-predicate (lhs-is-a-str-literal? pycbinary conf params)
  (lhs-is? pycbinary (lambda (lhs) (isa? lhs PycString))))

(define-predicate (rhs-is-a-str-literal? pycbinary conf params)
  (rhs-is? pycbinary (lambda (rhs) (isa? rhs PycString))))

(define-predicate (lhs-is-unboxed-string? pycbinary conf params)
  (lhs-is-statically-typed-as? pycbinary '(Ustr)))

(define-predicate (rhs-is-unboxed-string? pycbinary conf params)
  (rhs-is-statically-typed-as? pycbinary '(Ustr)))

(define-predicate (lhs-is-unboxed-integer? pycbinary conf params)
  (lhs-is-statically-typed-as? pycbinary '(Uint Ubint Usint)))

(define-predicate (rhs-is-unboxed-integer? pycbinary conf params)
  (rhs-is-statically-typed-as? pycbinary '(Uint Ubint Usint)))

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
  (config-get params must-return-host-value:))

;; =====================================================================
;; Code generation
;; =====================================================================

(define (PycBinary-default-case this conf params fx-op fl-op)
  (if (config-get conf in-semantics:)
    (error "PycBinary-default-case" "must not use default case for behavior" (pyc->list this)))

  (let ((op-name (if (must-return-host-bool this conf params)
                     (symbol-append 'test- (PycBinary-op this))
                     (PycBinary-op this)))
        ($left (my-gensym (symbol-append (PycBinary-op this) '-lhs)))
        ($right (my-gensym (symbol-append (PycBinary-op this) '-rhs))))
    `(let ((,$left ,(scheme (PycBinary-lhs this) conf))
           (,$right ,(scheme (PycBinary-rhs this) conf)))
       (cond
         ,@(filter
           (lambda (x) x)
           (list
             (and
               fx-op
               (operands-could-be-sint? this conf params)
                `((and (fixnum? ,$left) (fixnum? ,$right)) ,(fx-op $left $right)))
             (and
               fl-op
               (operands-could-be-float? this conf params)
               `((and (flonum? ,$left) (flonum? ,$right)) ,(fl-op $left $right)))
             `(else
               (py-binary-behavior-call ,op-name ,$left ,$right))))))))

(define (PycBinary-arithmetic-test-case this conf params fx-op fl-op)
  (if (config-get conf in-semantics:)
    (error "PycBinary-default-case" "must not use default case for behavior" (pyc->list this)))

  (let ((op-name (PycBinary-op this))
        ($left (my-gensym (symbol-append (PycBinary-op this) '-lhs)))
        ($right (my-gensym (symbol-append (PycBinary-op this) '-rhs))))
    `(let ((,$left ,(scheme (PycBinary-lhs this) conf))
           (,$right ,(scheme (PycBinary-rhs this) conf)))
       (cond
         ,@(filter
           (lambda (x) x)
           (list
             (and
               fx-op
               (operands-could-be-sint? this conf params)
                `((and (fixnum? ,$left) (fixnum? ,$right)) ,(fx-op $left $right)))
             (and
               fl-op
               (operands-could-be-float? this conf params)
               `((and (flonum? ,$left) (flonum? ,$right)) ,(fl-op $left $right)))
             `(else
               (py-test (py-binary-behavior-call ,op-name ,$left ,$right)))))))))

(define (test-real-literal-truthiness result)
  (if (number? result)
    (= result 0)
    #f)) ;; boxed literals cannot be zero

;; ADDITION
(define-compilation-to-scheme (add-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (must-return-host-bool
    (test-add-to-scheme this conf params))
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
  (operands-are-sint?
    (py-fx+ (scheme lhs conf) (scheme rhs conf)))
  ((and lhs-is-fixnum? rhs-is-flonum?)
    (unboxed-fx-fl+ (scheme lhs conf) (scheme rhs conf)))
  ((and lhs-is-flonum? rhs-is-fixnum?)
    (unboxed-fl-fx+ (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-flonums?
    (py-fl+ (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-reals?
    `(+ ,(scheme lhs conf) ,(scheme rhs conf)))
  (operands-are-unboxed-strings?
    (unboxed-str+ (scheme lhs conf) (scheme rhs conf)))
  (else
    (PycBinary-default-case this conf params py-fx+ py-fl+)))

(define-compilation-to-scheme (test-add-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (operands-are-int-or-float-literals?
    (test-real-literal-truthiness
      (add-to-scheme this conf (cons* must-return-host-bool: #f params))))
  (else
    (PycBinary-arithmetic-test-case this conf params py-test-fx+ py-test-fl+)))

;; SUBTRACTION
(define-compilation-to-scheme (sub-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (must-return-host-bool
    (test-sub-to-scheme this conf params))
  (operands-are-int-literals?
    (let ((result (- (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))))
      (if (fixnum? result) result `(py-bint-from-scheme ,result))))
  (operands-are-int-or-float-literals?
    (- (PycLiteralValue-val lhs) (PycLiteralValue-val rhs)))
  (operands-are-unboxed-fixnums?
    (unboxed-fx- (scheme lhs conf) (scheme rhs conf)))
  (operands-are-sint?
    (py-fx- (scheme lhs conf) (scheme rhs conf)))
  ((and lhs-is-fixnum? rhs-is-flonum?)
    (unboxed-fx-fl- (scheme lhs conf) (scheme rhs conf)))
  ((and lhs-is-flonum? rhs-is-fixnum?)
    (unboxed-fl-fx- (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-flonums?
    (py-fl- (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-reals?
    `(- ,(scheme lhs conf) ,(scheme rhs conf)))
  (else
    (PycBinary-default-case this conf params py-fx- py-fl-)))

(define-compilation-to-scheme (test-sub-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (operands-are-int-or-float-literals?
    (test-real-literal-truthiness
      (sub-to-scheme this conf (cons* must-return-host-bool: #f params))))
  (else
    (PycBinary-arithmetic-test-case this conf params py-test-fx- py-test-fl-)))

;; MULTIPLICATION
(define-compilation-to-scheme (mul-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (must-return-host-bool
    (test-mul-to-scheme this conf params))
  (operands-are-int-literals?
    (let ((result (* (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))))
      (if (fixnum? result) result `(py-bint-from-scheme ,result))))
  (operands-are-int-or-float-literals?
    (* (exact->inexact (PycLiteralValue-val lhs)) (exact->inexact (PycLiteralValue-val rhs))))
  (operands-are-unboxed-fixnums?
    (unboxed-fx* (scheme lhs conf) (scheme rhs conf)))
  (operands-are-sint?
    (py-fx* (scheme lhs conf) (scheme rhs conf)))
  ((and lhs-is-fixnum? rhs-is-flonum?)
    (unboxed-fx-fl* (scheme lhs conf) (scheme rhs conf)))
  ((and lhs-is-flonum? rhs-is-fixnum?)
    (unboxed-fl-fx* (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-flonums?
    (py-fl* (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-reals?
    (unboxed-real* (scheme lhs conf) (scheme rhs conf)))
  ((and lhs-is-a-str-literal? rhs-is-a-sint-literal?)
    (or (py-mul-str-literal lhs rhs conf) `(py-mul ,(scheme lhs conf) ,(scheme rhs conf))))
  ;; TODO handle case where there might be an overflow in runtime string multiplication?
  ((and lhs-is-unboxed-integer? rhs-is-unboxed-string?)
    (py-mul-Uint-Ustr (scheme lhs conf) (scheme rhs conf)))
  ((and lhs-is-unboxed-string? rhs-is-unboxed-integer?)
    (py-mul-Ustr-Uint (scheme lhs conf) (scheme rhs conf)))
  (else
    (PycBinary-default-case this conf params py-fx* py-fl*)))

(define-compilation-to-scheme (test-mul-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (operands-are-int-or-float-literals?
    (test-real-literal-truthiness
      (mul-to-scheme this conf (cons* must-return-host-bool: #f params))))
  (else
    (PycBinary-arithmetic-test-case this conf params py-test-fx* py-test-fl*)))

;; EXPONENT
(define-compilation-to-scheme (pow-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (must-return-host-bool
    (test-pow-to-scheme this conf params))
  (operands-are-int-literals?
    (let ((result (expt (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))))
      (if (fixnum? result) result `(py-bint-from-scheme ,result))))
  (operands-are-int-or-float-literals?
    (exact->inexact (expt (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))))
  (operands-are-unboxed-fixnums?
    (unboxed-fx** (scheme lhs conf) (scheme rhs conf)))
  (operands-are-sint?
    (py-fx** (scheme lhs conf) (scheme rhs conf)))
  ((and lhs-is-fixnum? rhs-is-flonum?)
    (unboxed-fx-fl** (scheme lhs conf) (scheme rhs conf)))
  ((and lhs-is-flonum? rhs-is-fixnum?)
    (unboxed-fl-fx** (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-flonums?
    (py-fl** (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-reals?
    `(exact->inexact (expt ,(scheme lhs conf) ,(scheme rhs conf))))
  (else
    (PycBinary-default-case this conf params py-fx** py-fl**)))

(define-compilation-to-scheme (test-pow-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (operands-are-int-or-float-literals?
    (test-real-literal-truthiness
      (pow-to-scheme this conf (cons* must-return-host-bool: #f params))))
  (else
    (PycBinary-arithmetic-test-case this conf params py-test-fx** py-test-fl**)))

;; BITAND
(define-compilation-to-scheme (bitand-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (must-return-host-bool
    (test-bitand-to-scheme this conf params))
  (operands-are-int-literals?
    (let ((result (bitwise-and (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))))
      (if (fixnum? result) result `(py-bint-from-scheme ,result))))
  (operands-are-unboxed-fixnums?
    (unboxed-fx& (scheme lhs conf) (scheme rhs conf)))
  (operands-are-sint?
    (py-fx& (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-integers?
    (unboxed-integer& (scheme lhs conf) (scheme rhs conf)))
  (else
    (PycBinary-default-case this conf params py-fx& #f)))

(define-compilation-to-scheme (test-bitand-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (operands-are-int-or-float-literals?
    (test-real-literal-truthiness
      (bitand-to-scheme this conf (cons* must-return-host-bool: #f params))))
  (else
    (PycBinary-arithmetic-test-case this conf params py-test-fx& #f)))

;; BITOR
(define-compilation-to-scheme (bitor-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (must-return-host-bool
    (test-bitor-to-scheme this conf params))
  (operands-are-int-literals?
    (let ((result (bitwise-ior (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))))
      (if (fixnum? result) result `(py-bint-from-scheme ,result))))
  (operands-are-unboxed-fixnums?
    (unboxed-fx-or (scheme lhs conf) (scheme rhs conf)))
  (operands-are-sint?
    (py-fx-or (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-integers?
    (unboxed-integer-or (scheme lhs conf) (scheme rhs conf)))
  (else
    (PycBinary-default-case this conf params py-fx-or #f)))

(define-compilation-to-scheme (test-bitor-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (operands-are-int-or-float-literals?
    (test-real-literal-truthiness
      (bitor-to-scheme this conf (cons* must-return-host-bool: #f params))))
  (else
    (PycBinary-arithmetic-test-case this conf params py-test-fx-or #f)))

;; XOR
(define-compilation-to-scheme (xor-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (must-return-host-bool
    (test-xor-to-scheme this conf params))
  (operands-are-int-literals?
    (let ((result (bitwise-xor (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))))
      (if (fixnum? result) result `(py-bint-from-scheme ,result))))
  (operands-are-unboxed-fixnums?
    (unboxed-fx^ (scheme lhs conf) (scheme rhs conf)))
  (operands-are-sint?
    (py-fx^ (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-integers?
    (unboxed-integer^ (scheme lhs conf) (scheme rhs conf)))
  (else
    (PycBinary-default-case this conf params py-fx^ #f)))

(define-compilation-to-scheme (test-xor-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (operands-are-int-or-float-literals?
    (test-real-literal-truthiness
      (xor-to-scheme this conf (cons* must-return-host-bool: #f params))))
  (else
    (PycBinary-arithmetic-test-case this conf params py-test-fx^ #f)))

;; SHIFT-LEFT
(define-compilation-to-scheme (lshift-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (must-return-host-bool
    (test-lshift-to-scheme this conf params))
  ((and operands-are-int-literals? rhs-is-non-negative-literal?)
    (let ((result
            ((gambit: (arithmetic-shift (PycLiteralValue-val lhs) (PycLiteralValue-val rhs)))
             (bigloo: bit-lsh (PycLiteralValue-val lhs) (PycLiteralValue-val rhs)))))
      (if (fixnum? result) result `(py-bint-from-scheme ,result))))
  (operands-are-unboxed-fixnums?
    (unboxed-fx<< (scheme lhs conf) (scheme rhs conf)))
  (operands-are-sint?
    (py-fx<< (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-integers?
    (unboxed-interger<< (scheme lhs conf) (scheme rhs conf)))
  (else
    (PycBinary-default-case this conf params py-fx<< #f)))

(define-compilation-to-scheme (test-lshift-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (operands-are-int-or-float-literals?
    (test-real-literal-truthiness
      (lshift-to-scheme this conf (cons* must-return-host-bool: #f params))))
  (else
    (PycBinary-arithmetic-test-case this conf params py-test-fx<< #f)))

;; SHIFT-RIGHT
(define-compilation-to-scheme (rshift-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (must-return-host-bool
    (test-rshift-to-scheme this conf params))
  ((and operands-are-int-literals? rhs-is-non-negative-literal?)
    (let ((result
           ((gambit: (arithmetic-shift (PycLiteralValue-val lhs) (- (PycLiteralValue-val rhs))))
            (bigloo: bit-lsh (PycLiteralValue-val lhs) (PycLiteralValue-val rhs)))))
      (if (fixnum? result) result `(py-bint-from-scheme ,result))))
  (operands-are-unboxed-fixnums?
    (unboxed-fx>> (scheme lhs conf) (scheme rhs conf)))
  (operands-are-sint?
    (py-fx>> (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-integers?
    `(unboxed-interger>> ,(scheme lhs conf) (- ,(scheme rhs conf))))
  (else
    (PycBinary-default-case this conf params py-fx>> #f)))

(define-compilation-to-scheme (test-rshift-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (operands-are-int-or-float-literals?
    (test-real-literal-truthiness
      (rshift-to-scheme this conf (cons* must-return-host-bool: #f params))))
  (else
    (PycBinary-arithmetic-test-case this conf params py-test-fx>> #f)))

;; FLOORDIV
(define-compilation-to-scheme (floordiv-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (must-return-host-bool
    (test-floordiv-to-scheme this conf params))
  ((and operands-are-int-literals? rhs-is-non-zero-literal?)
    (let ((result (quotient (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))))
      (if (fixnum? result) result `(py-bint-from-scheme ,result))))
  (operands-are-unboxed-fixnums?
    (unboxed-fx// (scheme lhs conf) (scheme rhs conf)))
  (operands-are-sint?
    (py-fx// (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-integers?
    `(quotient ,(scheme lhs conf) ,(scheme rhs conf)))
  ((and lhs-is-fixnum? rhs-is-flonum?)
    (unboxed-fx-fl// (scheme lhs conf) (scheme rhs conf)))
  ((and lhs-is-flonum? rhs-is-fixnum?)
    (unboxed-fl-fx// (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-flonums?
    (py-fl// (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-reals?
    (unboxed-real// (scheme lhs conf) (scheme rhs conf)))
  (else
    (PycBinary-default-case this conf params py-fx// py-fl//)))

(define-compilation-to-scheme (test-floordiv-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (operands-are-int-or-float-literals?
    (test-real-literal-truthiness
      (floordiv-to-scheme this conf (cons* must-return-host-bool: #f params))))
  (else
    (PycBinary-arithmetic-test-case this conf params py-test-fx// py-test-fl//)))

;; TRUEDIV
(define-compilation-to-scheme (truediv-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (must-return-host-bool
    (test-truediv-to-scheme this conf params))
  ((and operands-are-int-literals? rhs-is-non-zero-literal?)
    (exact->inexact (/ (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))))
  (operands-are-unboxed-fixnums?
    (unboxed-fx/ (scheme lhs conf) (scheme rhs conf)))
  (operands-are-sint?
    (py-fx/ (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-integers?
    `(exact->inexact (/ ,(scheme lhs conf) ,(scheme rhs conf))))
  ((and lhs-is-fixnum? rhs-is-flonum?)
    (unboxed-fx-fl/ (scheme lhs conf) (scheme rhs conf)))
  ((and lhs-is-flonum? rhs-is-fixnum?)
    (unboxed-fl-fx/ (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-flonums?
    (py-fl/ (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-reals?
    (unboxed-real/ (scheme lhs conf) (scheme rhs conf)))
  (else
    (PycBinary-default-case this conf params py-fx/ py-fl/)))

(define-compilation-to-scheme (test-truediv-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (operands-are-int-or-float-literals?
    (test-real-literal-truthiness
      (truediv-to-scheme this conf (cons* must-return-host-bool: #f params))))
  (else
    (PycBinary-arithmetic-test-case this conf params py-test-fx/ py-test-fl/)))

;; MODULO
(define-compilation-to-scheme (mod-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (must-return-host-bool
    (test-mod-to-scheme this conf params))
  ((and operands-are-int-literals? rhs-is-non-zero-literal?)
    (let ((result (modulo (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))))
      (if (fixnum? result) result `(py-bint-from-scheme ,result))))
  (operands-are-unboxed-fixnums?
    (unboxed-fx% (scheme lhs conf) (scheme rhs conf)))
  (operands-are-sint?
    (py-fx% (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-integers?
    `(modulo ,(scheme lhs conf) ,(scheme rhs conf)))
  ((and lhs-is-fixnum? rhs-is-flonum?)
    (unboxed-fx-fl% (scheme lhs conf) (scheme rhs conf)))
  ((and lhs-is-flonum? rhs-is-fixnum?)
    (unboxed-fl-fx% (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-flonums?
    (py-fl% (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-reals?
    (unboxed-real% (scheme lhs conf) (scheme rhs conf)))
  (else
    (PycBinary-default-case this conf params py-fx% py-fl%)))

(define-compilation-to-scheme (test-mod-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (operands-are-int-or-float-literals?
    (test-real-literal-truthiness
      (mod-to-scheme this conf (cons* must-return-host-bool: #f params))))
  (else
    (PycBinary-arithmetic-test-case this conf params py-test-fx% py-test-fl%)))

;; COMPARISONS
(define-macro (define-comparisons-to-scheme name py-fx unboxed-real unboxed-fx-fl unboxed-fl-fx py-fl
                                            test-name py-test-fx py-test-fl
                                            op string-op)
  `(begin
    (define-compilation-to-scheme (,name this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
      (must-return-host-bool
        (,test-name this conf params))
      (operands-are-int-or-float-literals?
        (if (,op (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))
            'py-True
            'py-False))
      (operands-are-str-literals?
        (if (,string-op (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))
            'py-True
            'py-False))
      (operands-are-unboxed-strings?
        (list (quote ,string-op) (scheme lhs conf) (scheme rhs conf)))
      ((or operands-are-unboxed-fixnums? operands-are-sint?)
        (,py-test-fx (scheme lhs conf) (scheme rhs conf)))
      ((and lhs-is-fixnum? rhs-is-flonum?)
        (,unboxed-fx-fl (scheme lhs conf) (scheme rhs conf)))
      ((and lhs-is-flonum? rhs-is-fixnum?)
        (,unboxed-fl-fx (scheme lhs conf) (scheme rhs conf)))
      (operands-are-unboxed-flonums?
        (,py-test-fl (scheme lhs conf) (scheme rhs conf)))
      (operands-are-unboxed-reals?
        (,unboxed-real (scheme lhs conf) (scheme rhs conf)))
      (else
        (PycBinary-default-case this conf params ,py-fx ,py-fl)))

    (define-compilation-to-scheme (,test-name this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
      (operands-are-int-or-float-literals?
        (,op (PycLiteralValue-val lhs) (PycLiteralValue-val rhs)))
      (operands-are-str-literals?
        (,string-op (PycLiteralValue-val lhs) (PycLiteralValue-val rhs)))
      (operands-are-unboxed-strings?
        (list (quote ,string-op) (scheme lhs conf) (scheme rhs conf)))
      ((or operands-are-unboxed-fixnums? operands-are-sint?)
        (,py-test-fx (scheme lhs conf) (scheme rhs conf)))
      ((and lhs-is-fixnum? rhs-is-flonum?)
        (,unboxed-fx-fl (scheme lhs conf) (scheme rhs conf)))
      ((and lhs-is-flonum? rhs-is-fixnum?)
        (,unboxed-fl-fx (scheme lhs conf) (scheme rhs conf)))
      (operands-are-unboxed-flonums?
        (,py-test-fl (scheme lhs conf) (scheme rhs conf)))
      (operands-are-unboxed-reals?
        (,unboxed-real (scheme lhs conf) (scheme rhs conf)))
      (else
        (PycBinary-default-case this conf params ,py-test-fx ,py-test-fl)))))

;; EQ
(define-comparisons-to-scheme eq-to-scheme
                              py-fx= unboxed-real= unboxed-fx-fl= unboxed-fl-fx= py-fl=
                              test-eq-to-scheme
                              py-test-fx= py-test-fl=
                              = string=?)

;; GT
(define-comparisons-to-scheme gt-to-scheme
                              py-fx> unboxed-real> unboxed-fx-fl> unboxed-fl-fx> py-fl>
                              test-gt-to-scheme
                              py-test-fx> py-test-fl>
                              > string>?)

;; GE
(define-comparisons-to-scheme ge-to-scheme
                              py-fx>= unboxed-real>= unboxed-fx-fl>= unboxed-fl-fx>= py-fl>=
                              test-ge-to-scheme
                              py-test-fx>= py-test-fl>=
                              >= string>=?)

;; LT
(define-comparisons-to-scheme lt-to-scheme
                              py-fx< unboxed-real< unboxed-fx-fl< unboxed-fl-fx< py-fl<
                              test-lt-to-scheme
                              py-test-fx< py-test-fl<
                              < string<?)

;; LE
(define-comparisons-to-scheme le-to-scheme
                              py-fx<= unboxed-real<= unboxed-fx-fl<= unboxed-fl-fx<= py-fl<=
                              test-le-to-scheme
                              py-test-fx<= py-test-fl<=
                              <= string<=?)

;; NE
(define-compilation-to-scheme (ne-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
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
  (operands-are-unboxed-strings?
    `(not (string=? ,(scheme lhs conf) ,(scheme rhs conf))))
  ((or operands-are-unboxed-fixnums? operands-are-sint?)
    (py-test-fx!= (scheme lhs conf) (scheme rhs conf)))
  ((and lhs-is-fixnum? rhs-is-flonum?)
    (unboxed-fx-fl!= (scheme lhs conf) (scheme rhs conf)))
  ((and lhs-is-flonum? rhs-is-fixnum?)
    (unboxed-fl-fx!= (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-flonums?
    (py-test-fl!= (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-reals?
    (unboxed-real!= (scheme lhs conf) (scheme rhs conf)))
  (else
    (PycBinary-default-case this conf params py-fx!= py-fl!=)))

(define-compilation-to-scheme (test-ne-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (operands-are-int-or-float-literals?
    (not (= (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))))
  (operands-are-str-literals?
    (not (string=? (PycLiteralValue-val lhs) (PycLiteralValue-val rhs))))
  (operands-are-unboxed-strings?
    `(not (string=? ,(scheme lhs conf) ,(scheme rhs conf))))
  ((or operands-are-unboxed-fixnums? operands-are-sint?)
    (py-test-fx!= (scheme lhs conf) (scheme rhs conf)))
  ((and lhs-is-fixnum? rhs-is-flonum?)
    (unboxed-fx-fl!= (scheme lhs conf) (scheme rhs conf)))
  ((and lhs-is-flonum? rhs-is-fixnum?)
    (unboxed-fl-fx!= (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-flonums?
    (py-test-fl!= (scheme lhs conf) (scheme rhs conf)))
  (operands-are-unboxed-reals?
    (unboxed-real!= (scheme lhs conf) (scheme rhs conf)))
  (else
    (PycBinary-default-case this conf params py-test-fx!= py-test-fl!=)))

(define-compilation-to-scheme (is-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (must-return-host-bool
    `(py-test-is ,(scheme lhs conf) ,(scheme rhs conf)))
  (else
    `(py-is ,(scheme lhs conf) ,(scheme rhs conf))))

(define-compilation-to-scheme (isnot-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (must-return-host-bool
    `(py-test-isnot ,(scheme lhs conf) ,(scheme rhs conf)))
  (else
    `(py-isnot ,(scheme lhs conf) ,(scheme rhs conf))))

(define-compilation-to-scheme (in-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (must-return-host-bool
    `(py-test-in ,(scheme lhs conf) ,(scheme rhs conf)))
  (else
    `(py-in ,(scheme lhs conf) ,(scheme rhs conf))))

(define-compilation-to-scheme (notin-to-scheme this conf params (lhs (PycBinary-lhs this)) (rhs (PycBinary-rhs this)))
  (must-return-host-bool
    `(py-test-notin ,(scheme lhs conf) ,(scheme rhs conf)))
  (else
    `(py-notin ,(scheme lhs conf) ,(scheme rhs conf))))

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
          ((eq? op 'is) (is-to-scheme pycbinary conf params))
          ((eq? op 'isnot) (isnot-to-scheme pycbinary conf params))
          ((eq? op 'in) (in-to-scheme pycbinary conf params))
          ((eq? op 'notin) (notin-to-scheme pycbinary conf params))

          (else (default-python-op pycbinary conf params)))))
