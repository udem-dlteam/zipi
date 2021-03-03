;; inline c code

(define-macro (inline-c-code code)
  (cond-expand
    (gambit
      `(let () (declare (extended-bindings)) (|##c-code| ,code)))
    (bigloo
      #f)))

;; calls

(define-macro (with-specialized-PyObjectFunction-args-limit macro-name . args)
  `(,macro-name 10 ,@args))

(define-macro (py-call0-maybe-super fn cls instance)
  `(let (($fn ,fn))
      (if (eq? $fn py-builtin-super)
        ,(if (not (and cls instance))
          `(py-throw-super-no-arguments-error)
          `(py-call py-builtin-super ,cls ,instance))
        (py-call $fn))))

(define-macro (py-global-call global procedure global-id init-value name cache . args)
  (if (symbol? global-id)
    `(if (eq? ,global-id ,init-value)
        (,procedure ,@args)
        (py-call
          (if (eq? ,global-id py-absent) (global-get ,global ,name ,cache) ,global-id)
          ,@args))
    (error "py-global-call" "global-id must be a symbol" global-id)))

(define-macro (py-call0 fun)
  `(let (($fun ,fun))
    (if (PyObjectFunctionArity0? $fun)
      ((PyObjectFunction-procedure $fun))
      (py-call0-fallback $fun))))

(define-macro (py-callX X fun . args)
  `(with-specialized-PyObjectFunction-args-limit $py-callX ,X ,fun ,@args))

(define-macro ($py-callX specialized-args-limit X fun . args)
  (cond
    ((= X 0) `(py-call0 ,fun))
    ((<= X specialized-args-limit)
      (let ((min-neg-arity (- 0 X 1))
            (args-names (map
                          (lambda (i) (string->symbol (string-append "$arg" (number->string i))))
                          (iota X))))
        `(let* (($fun ,fun)
                ,@(map list args-names args))
          (if (,(string->symbol (string-append "PyObjectFunctionArity" (number->string X) "?")) $fun)
            ((PyObjectFunction-procedure $fun) ,@args-names)
            (py-callX-fallback ,min-neg-arity $fun ,@args-names)))))
    (else
      (py-callX-fallback ,(- 0 X 1) ,fun ,@args))))

(define-macro (py-make-PyObjectFunction hclass elements cls procedure arity signature)
  `(with-specialized-PyObjectFunction-args-limit $py-make-PyObjectFunction ,hclass ,elements ,cls ,procedure ,arity ,signature))

(define-macro ($py-make-PyObjectFunction specialized-args-limit hclass elements cls procedure arity signature)
  `(let (($hclass ,hclass)
         ($elements ,elements)
         ($cls ,cls)
         ($procedure procedure)
         ($arity ,arity)
         ($signature ,signature))
      (cond
        ,@(let loop ((i 0))
            (if (> i specialized-args-limit)
              '()
              (cons
                `((eqv? $arity ,i)
                    (,(string->symbol (string-append "make-PyObjectFunctionArity" (number->string i)))
                        $hclass $elements $cls $procedure $arity $signature))
                (loop (+ i 1)))))
        (else (make-PyObjectFunction $hclass $elements $cls $procedure $arity $signature)))))

;; Macros to enable/disable various implementation strategies.

(define-macro (py-if-specialized-sint-representation yes no) yes)
(define-macro (py-if-specialized-float-representation yes no) yes)
(define-macro (py-if-enable-behaviors-optimization yes no) yes)
(define-macro (py-if-enable-inline-behavior-dispatch yes no) no)
(define-macro (py-if-enable-inlined-mixed-types-behaviors yes no) yes)
(define-macro (py-if-enable-inline-partial-behavior-dispatch yes no) no)

(define-macro (py-bool-to-scheme-float arg)
  `(fixnum->flonum (py-bool-to-scheme-int ,arg)))

(define-macro (py-int-to-scheme-float arg)
  `(fixnum->flonum (py-int-to-scheme ,arg)))

(define-macro (py-sint-to-scheme-float arg)
  `(fixnum->flonum (py-sint-to-scheme ,arg)))

(define-macro (py-bint-to-scheme-float arg)
  `(exact->inexact (py-bint-to-scheme ,arg)))

(define-macro (py-int-to-scheme obj)
  `(py-if-specialized-sint-representation
    (let (($obj ,obj))
      (if (fixnum? $obj)
          $obj
          (PyObjectInt-value $obj)))
    (PyObjectInt-value ,obj)))

(define-macro (py-subtype-of-int-to-scheme obj)
  `(py-if-specialized-sint-representation
    (let (($obj ,obj))
      (if (fixnum? $obj)
          $obj
          (PyObjectInt-value $obj)))
    (PyObjectInt-value ,obj)))

(define-macro (py-strict-subtype-of-int-to-scheme obj)
  `(PyObjectInt-value ,obj))

(define-macro (py-bool-to-scheme-int arg)
  `(py-strict-subtype-of-int-to-scheme ,arg)) ;; a bool is an int with value 0 or 1

(define-macro (py-bool-from-scheme-bool arg)
  `(if ,arg py-True py-False))

(define-macro (py-bool-to-scheme-bool arg)
  (cond
    ((eq? arg 'py-True) #t)
    ((eq? arg 'py-False) #f)
    (else `(py-test-is ,arg py-True))))

(define-macro (py-sint-to-scheme arg)
  `(py-if-specialized-sint-representation
    ,arg
    (PyObjectInt-value ,arg)))

(define-macro (py-bint-to-scheme arg)
  `(PyObjectInt-value ,arg))

(define-macro (py-float-to-scheme arg)
  `(py-if-specialized-float-representation
    ,arg
    (PyObjectFloat-value ,arg)))

(define-macro (py-subtype-of-float-to-scheme obj)
  `(py-if-specialized-float-representation
    (let (($obj ,obj))
      (if (flonum? $obj)
          $obj
          (PyObjectFloat-value $obj)))
    (PyObjectFloat-value ,obj)))

(define-macro (py-strict-subtype-of-float-to-scheme obj)
  `(PyObjectFloat-value ,obj))

(define-macro (alloc-new-PyObjectInt-from-scheme value)
  `(make-PyObjectInt
      py-int-hclass-of-instances
      '#()
      py-int-class
      ,value))

(define-macro (py-bint-from-scheme value)
  `(py-bint-from-scheme-fallback ,value))

(define-macro (py-int-from-scheme arg)

  ;; assume all small int operations don't cause an overflow?
  (define disregard-sint-overflow? #f)

  (define unary-operators-gambit
    '((pypos    X ;; bool or non-ov. sint
                X ;; sint
                X ;; otherwise
                )
      (pyneg    (py-sint-from-scheme (|##fx-| X)) ;; bool or non-ov. sint
                (or (|##fx-?| X) (pyneg-UintX X)) ;; sint
                (pyneg-UintX X) ;; otherwise
                )
      (pyinvert (py-sint-from-scheme (|##fxnot| X)) ;; bool or non-ov. sint
                (py-sint-from-scheme (|##fxnot| X)) ;; sint
                (pyinvert-UintX X) ;; otherwise
                )))

  (define binary-operators-gambit
    '((py+  (py-sint-from-scheme (|##fx+| X Y)) ;; bool/bool or non-ov. sint/sint
            (or (|##fx+?| X Y) (pyadd-UintX-UintY-fallback X Y)) ;; sint/sint
            (pyadd-UintX-UintY-fallback X Y) ;; otherwise
            )
      (py-  (py-sint-from-scheme (|##fx-| X Y)) ;; bool/bool or non-ov. sint/sint
            (or (|##fx-?| X Y) (pysub-UintX-UintY-fallback X Y)) ;; sint/sint
            (pysub-UintX-UintY-fallback X Y) ;; otherwise
            )
      (py*  (py-sint-from-scheme (|##fx*| X Y)) ;; bool/bool or non-ov. sint/sint
            (or (|##fx*?| X Y) (pymul-UintX-UintY-fallback X Y)) ;; sint/sint
            (pymul-UintX-UintY-fallback X Y) ;; otherwise
            )
      ;; TODO: define and use a primitive
      (py** (py-int-from-scheme (expt X Y))
            (py-int-from-scheme (expt X Y))
            (py-int-from-scheme (expt X Y))
            )
      (py&  (py-sint-from-scheme (|##fxand| X Y)) ;; bool/bool or non-ov. sint/sint
            (py-sint-from-scheme (|##fxand| X Y)) ;; sint/sint
            (py&-UintX-UintY-fallback X Y) ;; otherwise
            )
      (py+b (py-sint-from-scheme (|##fxior| X Y)) ;; bool/bool or non-ov. sint/sint
            (py-sint-from-scheme (|##fxior| X Y)) ;; sint/sint
            (py+b-UintX-UintY-fallback X Y) ;; otherwise
            )
      (py^  (py-sint-from-scheme (|##fxxor| X Y)) ;; bool/bool or non-ov. sint/sint
            (py-sint-from-scheme (|##fxxor| X Y)) ;; sint/sint
            (py^-UintX-UintY-fallback X Y) ;; otherwise
            )
      (py>> (py-sint-from-scheme (|##fxarithmetic-shift-right| X Y)) ;; bool/bool or non-ov. sint/sint
            (or (|##fxarithmetic-shift-right?| X Y) (py>>-UintX-UintY-fallback X Y)) ;; sint/sint
            (py>>-UintX-UintY-fallback X Y) ;; otherwise
            )
      (py<< (py-sint-from-scheme (|##fxarithmetic-shift-left| X Y)) ;; bool/bool or non-ov. sint/sint
            (or (|##fxarithmetic-shift-left?| X Y) (py<<-UintX-UintY-fallback X Y)) ;; sint/sint
            (py<<-UintX-UintY-fallback X Y) ;; otherwise
            )
      (py// (py-sint-from-scheme (|##fxquotient| X Y)) ;; bool/bool or non-ov. sint/sint
            (if (|##eqv?| Y -1) ;; sint/sint
                (or (|##fx-?| X) (pyneg-UintX X))
                (|##fxquotient| X Y))
            (py//-UintX-UintY-fallback X Y) ;; otherwise
            )
      (py%  (py-sint-from-scheme (|##fxmodulo| X Y)) ;; bool/bool or non-ov. sint/sint
            (py-sint-from-scheme (|##fxmodulo| X Y)) ;; sint/sint
            (py%-UintX-UintY-fallback X Y) ;; otherwise
            )))

  (define unary-operators-bigloo
    '((pypos    X ;; bool or non-ov. sint
                X ;; sint
                X ;; otherwise
                )
      (pyneg    (py-sint-from-scheme (negfx X)) ;; bool or non-ov. sint
                (py-int-from-scheme (- X)) ;; sint
                (py-int-from-scheme (- X)) ;; otherwise
                )
      (pyinvert (py-sint-from-scheme (bit-not X)) ;; bool or non-ov. sint
                (py-sint-from-scheme (bit-not X)) ;; sint
                (py-int-from-scheme (bit-not X)) ;; otherwise
                )))

  (define binary-operators-bigloo
    '((py+  (py-sint-from-scheme (+fx X Y)) ;; bool/bool or non-ov. sint/sint
            (py-int-from-scheme (+fx/overflow X Y)) ;; sint/sint
            (py-int-from-scheme (+ X Y)) ;; otherwise
            )
      (py-  (py-sint-from-scheme (-fx X Y)) ;; bool/bool or non-ov. sint/sint
            (py-int-from-scheme (-fx/overflow X Y)) ;; sint/sint
            (py-int-from-scheme (- X Y)) ;; otherwise
            )
      (py*  (py-sint-from-scheme (*fx X Y)) ;; bool/bool or non-ov. sint/sint
            (py-int-from-scheme (*fx/overflow X Y)) ;; sint/sint
            (py-int-from-scheme (* X Y)) ;; otherwise
            )
      (py** (py-sint-from-scheme (exptfx X Y)) ;; bool/bool or non-ov. sint/sint
            (py-int-from-scheme (expt X Y)) ;; sint/sint
            (py-int-from-scheme (expt X Y)) ;; otherwise
            )
      (py&  (py-sint-from-scheme (bit-and X Y)) ;; bool/bool or non-ov. sint/sint
            (py-int-from-scheme (bit-and X Y)) ;; sint/sint
            (py-int-from-scheme (bit-and X Y)) ;; otherwise
            )
      (py+b (py-sint-from-scheme (bit-or X Y)) ;; bool/bool or non-ov. sint/sint
            (py-int-from-scheme (bit-or X Y)) ;; sint/sint
            (py-int-from-scheme (bit-or X Y)) ;; otherwise
            )
      (py^  (py-sint-from-scheme (bit-xor X Y)) ;; bool/bool or non-ov. sint/sint
            (py-int-from-scheme (bit-xor X Y)) ;; sint/sint
            (py-int-from-scheme (bit-xor X Y)) ;; otherwise
            )
      (py>> (py-sint-from-scheme (bit-rsh X Y)) ;; bool/bool or non-ov. sint/sint
            (py-int-from-scheme (bit-rsh X Y)) ;; sint/sint
            (py-int-from-scheme (bit-rsh X Y)) ;; otherwise
            )
      (py<< (py-sint-from-scheme (bit-lsh X Y)) ;; bool/bool or non-ov. sint/sint
            (py-int-from-scheme (bit-lsh X Y)) ;; sint/sint
            (py-int-from-scheme (bit-lsh X Y)) ;; otherwise
            )
      (py// (py-sint-from-scheme (quotientfx X Y)) ;; bool/bool or non-ov. sint/sint
            (py-int-from-scheme (quotient X Y)) ;; sint/sint
            (py-int-from-scheme (quotient X Y)) ;; otherwise
            )
      (py%  (py-sint-from-scheme (modulofx X Y)) ;; bool/bool or non-ov. sint/sint
            (py-int-from-scheme (modulo X Y)) ;; sint/sint
            (py-int-from-scheme (modulo X Y)) ;; otherwise
            )))

  (define host (cond-expand (gambit 'gambit) (bigloo 'bigloo)))

  (define (type operand)
    (and (pair? operand)
         (let ((x (assq (car operand)
                         '((py-bool-to-scheme-int bool)
                           (py-sint-to-scheme sint)
                           (py-bint-to-scheme bint)
                           (py-int-to-scheme  int)))))
           (and x
                (cadr x)))))

  (define (bool? t) (eq? t 'bool))
  (define (bool-or-sint? t) (or (eq? t 'bool) (eq? t 'sint)))

  (define (out-of-line arg)
    `(py-int-from-scheme-fallback ,arg))

  (define (fallback arg)
    `(py-if-specialized-sint-representation
      (let (($arg ,arg))
        (if (fixnum? $arg)
            $arg
            ,(out-of-line '$arg)))
      ,(out-of-line arg)))

  (define (all? pred lst)
    (not (member #f (map pred lst))))

  (define (strip-py-bint-from-scheme expr)
    (if (pair? expr)
        (if (eq? (car expr) 'py-bint-from-scheme)
            (strip-py-bint-from-scheme (cadr expr))
            (map strip-py-bint-from-scheme expr))
        expr))

  (define (special-case-sint expr)
    (let ((expr-without-bint (strip-py-bint-from-scheme expr)))
      (if (equal? expr expr-without-bint)
          expr
          `(py-if-specialized-sint-representation
            ,expr
            ,(out-of-line expr-without-bint)))))

  (cond ((pair? arg)
         (let* ((operator (car arg))
                (operands (cdr arg))
                (operand-types (map type operands)))
           (case (length operands)
             ((1)
              (cond ((assq operator
                            (case host
                              ((gambit) unary-operators-gambit)
                              ((bigloo) unary-operators-bigloo)))
                     =>
                     (lambda (entry)
                       (cond ((or (bool? (car operand-types))
                                  disregard-sint-overflow?)
                              (let ((expr (cadr entry)))
                                (if (eq? expr 'X)
                                    (cadr (car operands))
                                    `(let ((X ,(car operands)))
                                       ,expr))))
                             ((bool-or-sint? (car operand-types))
                              (let ((expr (caddr entry)))
                                (if (eq? expr 'X)
                                    (cadr (car operands))
                                    `(let ((X ,(car operands)))
                                       ,(special-case-sint expr)))))
                             (else
                              (let ((expr (cadddr entry)))
                                (if (eq? expr 'X)
                                    (cadr (car operands))
                                    `(let ((X ,(car operands)))
                                       ,expr)))))))
                    (else
                     (fallback arg))))
             ((2)
              (cond ((assq operator
                            (case host
                              ((gambit) binary-operators-gambit)
                              ((bigloo) binary-operators-bigloo)))
                     =>
                     (lambda (entry)
                       (cond ((or (all? bool? operand-types)
                                  disregard-sint-overflow?)
                              (let ((expr (cadr entry)))
                                `(let* ((X ,(car operands))
                                        (Y ,(cadr operands)))
                                   ,expr)))
                             ((all? bool-or-sint? operand-types)
                              (let ((expr (caddr entry)))
                                `(let* ((X ,(car operands))
                                        (Y ,(cadr operands)))
                                   ,(special-case-sint expr))))
                             (else
                              (let ((expr (cadddr entry)))
                                `(let* ((X ,(car operands))
                                        (Y ,(cadr operands)))
                                   ,expr))))))
                    (else
                     (fallback arg))))
             (else
              (fallback arg)))))
        ((and (number? arg) (exact? arg) (integer? arg))
         `(py-if-specialized-sint-representation
           ,arg
           ,(let ()
              (define int-cache-low -5) ;; must be same as in rts.scm
              (define int-cache-high 256)
              (if (and (<= arg int-cache-high)
                       (>= arg int-cache-low))
                  `(vector-ref int-cache ,(- arg int-cache-low))
                  (fallback arg)))))
        (else
         (fallback arg))))

(define-macro (py-sint-from-scheme arg)
 `(py-if-specialized-sint-representation
   ,arg
   (alloc-new-PyObjectInt-from-scheme ,arg)))

(define-macro (py-float-from-scheme arg)

 (define unary-operators-gambit
   '((pypos X)
     (pyneg (|##fl-| X))))

 (define binary-operators-gambit
   '((py+  (|##fl+| X Y))
     (py-  (|##fl-| X Y))
     (py*  (|##fl*| X Y))
     (py** (|##flexpt| X Y))
     (py/  (|##fl/| X Y))
     (py// (|##flfloor| (|##fl/| X Y)))
     (py%
      (let (($temp (fl/ X Y)))
        (|##fl-| X
                 (|##fl*| Y
                          (if (|##fl<| 0.0 X)
                              (|##flfloor| $temp)
                              (|##flceiling| $temp))))))))

 (define unary-operators-bigloo
   '((pypos X)
     (pyneg (negfl X))))

 (define binary-operators-bigloo
   '((py+  (+fl X Y))
     (py-  (-fl X Y))
     (py*  (*fl X Y))
     (py** (exptfl X Y))
     (py/  (/fl X Y))
     (py// (floorfl (/fl X Y)))
     (py%
      (let (($temp (/fl X Y)))
        (-fl X
             (*fl Y
                  (if (<fl 0.0 X)
                      (floorfl $temp)
                      (ceilingfl $temp))))))))

 (define host (cond-expand (gambit 'gambit) (bigloo 'bigloo)))

 (define (type operand)
   (and (pair? operand)
        (let ((x (assq (car operand)
                        '((py-bool-to-scheme-int  bool)
                          (py-sint-to-scheme  sint)
                          (py-bint-to-scheme  bint)
                          (py-int-to-scheme   int)
                          (py-float-to-scheme float)))))
          (and x
               (cadr x)))))

 (define (fallback arg)
   `(py-if-specialized-float-representation
     ,arg
     (py-float-from-scheme-fallback ,arg)))

 (define (to-float operand)
   (case (type operand)
     ((sint bint int)
      (list (string->symbol
             (string-append (symbol->string (car operand))
                            "-float"))
            (cadr operand)))
     ((bool) `(py-bool-to-scheme-float ,(cadr operand)))
     ((float) operand)
     (else
      (error "unexpected type" operand))))

 (cond ((pair? arg)
        (let* ((operator (car arg))
               (operands (cdr arg))
               (operand-types (map type operands)))
          (case (length operands)
            ((1)
             (cond ((assq operator
                           (case host
                             ((gambit) unary-operators-gambit)
                             ((bigloo) unary-operators-bigloo)))
                    =>
                    (lambda (entry)
                      (let ((expr (cadr entry)))
                        (if (and (eq? expr 'X)
                                 (eq? (type (car operands)) 'float))
                            (cadr (car operands))
                            `(let ((X ,(to-float (car operands))))
                               ,expr)))))
                   (else
                    (fallback arg))))
            ((2)
             (cond ((assq operator
                           (case host
                             ((gambit) binary-operators-gambit)
                             ((bigloo) binary-operators-bigloo)))
                    =>
                    (lambda (entry)
                      (let ((expr (cadr entry)))
                        `(let* ((X ,(to-float (car operands)))
                                (Y ,(to-float (cadr operands))))
                           ,expr))))
                   (else
                    (fallback arg))))
            (else
             (fallback arg)))))
       (else
        (fallback arg))))

(define-macro (py-test-from-scheme arg)

  (define comparison-operators-gambit
    '((py== (|##fx=| X Y) ;; sint-sint
            (|##fl=| X Y) ;; float-float
            (|##=2| X Y) ;; sint-float
            (|##=2| X Y) ;; float-sint
            (|##string=?| X Y) ;; str-str
            (|##=2| X Y) ;; otherwise
            )
      (py!= (|##not| (|##fx=| X Y)) ;; sint-sint
            (|##not| (|##fl=| X Y)) ;; float-float
            (|##not| (|##=2| X Y)) ;; sint-float
            (|##not| (|##=2| X Y)) ;; float-sint
            (|##not| (|##string=?| X Y)) ;; str-str
            (|##not| (|##=2| X Y)) ;; otherwise
            )
      (py>= (|##fx>=| X Y) ;; sint-sint
            (|##fl>=| X Y) ;; float-float
            (|##>=| X Y) ;; sint-float
            (|##>=| X Y) ;; float-sint
            (|##string>=?| X Y) ;; str-str
            (|##>=| X Y) ;; otherwise
            )
      (py>  (|##fx>| X Y) ;; sint-sint
            (|##fl>| X Y) ;; float-float
            (|##>| X Y) ;; sint-float
            (|##>| X Y) ;; float-sint
            (|##string>?| X Y) ;; str-str
            (|##>| X Y) ;; otherwise
            )
      (py<= (|##fx<=| X Y) ;; sint-sint
            (|##fl<=| X Y) ;; float-float
            (|##<=| X Y) ;; sint-float
            (|##<=| X Y) ;; float-sint
            (|##string<=?| X Y) ;; str-str
            (|##<=| X Y) ;; otherwise
            )
      (py<  (|##fx<| X Y) ;; sint-sint
            (|##fl<| X Y) ;; float-float
            (|##<| X Y) ;; sint-float
            (|##<| X Y) ;; float-sint
            (|##string<?| X Y) ;; str-str
            (|##<| X Y) ;; otherwise
            )))

  (define comparison-operators-bigloo
    '((py== (=fx X Y) ;; sint-sint
            (=fl X Y) ;; float-float
            (= X Y) ;; sint-float
            (= X Y) ;; float-sint
            (string=? X Y) ;; str-str
            (= X Y) ;; otherwise
            )
      (py!= (not (=fx X Y)) ;; sint-sint
            (not (=fl X Y)) ;; float-float
            (not (= X Y)) ;; sint-float
            (not (= X Y)) ;; float-sint
            (not (string=? X Y)) ;; str-str
            (not (= X Y)) ;; otherwise
            )
      (py>= (>=fx X Y) ;; sint-sint
            (>=fl X Y) ;; float-float
            (>= X Y) ;; sint-float
            (>= X Y) ;; float-sint
            (string>=? X Y) ;; str-str
            (>= X Y) ;; otherwise
            )
      (py>  (>fx X Y) ;; sint-sint
            (>fl X Y) ;; float-float
            (> X Y) ;; sint-float
            (> X Y) ;; float-sint
            (string>? X Y) ;; str-str
            (> X Y) ;; otherwise
            )
      (py<= (<=fx X Y) ;; sint-sint
            (<=fl X Y) ;; float-float
            (<= X Y) ;; sint-float
            (<= X Y) ;; float-sint
            (string<=? X Y) ;; str-str
            (<= X Y) ;; otherwise
            )
      (py<  (<fx X Y) ;; sint-sint
            (<fl X Y) ;; float-float
            (< X Y) ;; sint-float
            (< X Y) ;; float-sint
            (string<? X Y) ;; str-str
            (< X Y) ;; otherwise
            )))

  (define (dispatch-operator ops types)
    (cond
      ((equal? types '(sint sint)) (car ops))
      ((equal? types '(float float)) (cadr ops))
      ((equal? types '(sint float)) (caddr ops))
      ((equal? types '(float sint)) (cadddr ops))
      ((equal? types '(str str)) (list-ref ops 4))
      (else (list-ref ops 5))))

  (define host (cond-expand (gambit 'gambit) (bigloo 'bigloo)))

  (define (type operand)
    (and (pair? operand)
         (let ((x (assq (car operand)
                         '((py-bool-to-scheme-int bool)
                           (py-sint-to-scheme sint)
                           (py-bint-to-scheme bint)
                           (py-int-to-scheme  int)
                           (py-str-to-scheme  str)))))
           (and x (cadr x)))))

  (define (bool? t) (eq? t 'bool))
  (define (bool-or-sint? t) (or (eq? t 'bool) (eq? t 'sint)))

  (define (all? pred lst)
    (not (member #f (map pred lst))))

  (define (fallback arg)
    `(py-test-fallback ,arg))

  (cond
    ((pair? arg)
      (let* ((operator (car arg))
             (operands (cdr arg))
             (operand-types (map type operands)))
        (cond ((assq operator
                      (case host
                        ((gambit) comparison-operators-gambit)
                        ((bigloo) comparison-operators-bigloo)))
                =>
                (lambda (entry)
                  `(let* ((X ,(car operands))
                          (Y ,(cadr operands)))
                     ,(dispatch-operator (cdr entry) operand-types))))
              (else (fallback arg)))))
    (else
      ;; scheme value should be tested as is
      ,arg)))

(define-macro (py-mul-UstrX-UintY string repetitions)
  ;; TODO: Check for memory error if string * repetitions is a bint
  `(let* (($repetitions ,repetitions)
          ($string ,string)
          (len (string-length $string))
          (result-len (* len $repetitions))
          (result (make-string result-len)))
     (let loop ((i 0))
       (if (>= i result-len)
           result
           (begin
             (substring-move! $string 0 len result i)
             (loop (+ i len)))))))

(define-macro (py-str-from-scheme arg)
  (define (fallback arg)
    `(py-str-from-scheme-fallback ,arg))

  (define (type operand)
    (and (pair? operand)
         (let ((x (assq (car operand)
                         '((py-bool-to-scheme-int  bool)
                           (py-sint-to-scheme  sint)
                           (py-bint-to-scheme  bint)
                           (py-int-to-scheme   int)
                           (py-str-to-scheme str)))))
           (and x
                (cadr x)))))

  (define number-type '(int sint bint bool))

  (define (to-str x)
    (if (and (pair? x) (eq? (car x) 'py-str-to-scheme))
      (cadr x)
      x))

  (define (str-concat left right)
    ;; remove py-str-to-scheme and apply concat optimisation w/o unboxing
    `(py-concat-strX-strY ,(to-str left) ,(to-str right)))

  (define (str-mul left right)
    (define (error-non-int) (error "py-str-from-scheme" "str multiplication with non-integer"))

    (let ((left-type (type left))
          (right-type (type right)))
      (if (eq? left-type 'str)
        ;; left is the string
        (if (memq right-type number-type)
          `(py-str-from-scheme-fallback (py-mul-UstrX-UintY ,left ,right))
          (error-non-int))
        (if (eq? right-type 'str)
          ;; right is the string
          (if (memq left-type number-type)
            `(py-str-from-scheme-fallback (py-mul-UstrX-UintY ,right ,left))
            (error-non-int))
          (error "py-str-from-scheme" "str multiplication called on non-str's" left right)))))

  (if (pair? arg)
    (let* ((operator (car arg))
           (operands (cdr arg)))
      (case operator
        ((py+) (apply str-concat operands))
        ((py*) (apply str-mul operands))
        (else (fallback arg))))
    (fallback arg)))

(define-macro (py-specialized-sint-float-dispatch-let name obj int float other)
  `(let ((,name ,obj))
     (cond ((py-if-specialized-sint-representation (fixnum? ,name) #f)
            ,int)
           ((py-if-specialized-float-representation (flonum? ,name) #f)
            ,float)
           (else
            ,other))))

;; Get hclass of object given specialized representations of int and float

(define-macro (py-obj-hclass obj)
  `(py-specialized-sint-float-dispatch-let
    $obj
    ,obj
    py-int-hclass-of-instances
    py-float-hclass-of-instances
    (PyObject-hclass $obj)))

;; Get class of object given specialized representations of int and float

(define-macro (py-obj-cls-general obj)
  `(PyObject-class ,obj))

(define-macro (py-obj-cls obj) ;; get object's class
  `(py-specialized-sint-float-dispatch-let
    $obj
    ,obj
    py-int-class
    py-float-class
    (py-obj-cls-general $obj)))

(define-macro (py-obj-mro obj) ;; get MRO of object's class
  `(PyObjectType-mro (py-obj-cls ,obj)))

(define-macro (py-obj-class-index obj)
  `(with-class-indices-info $py-obj-class-index ,obj))

(define-macro ($py-obj-class-index indices-info obj)
  (define sint-class-index (cadr (assq 'sint indices-info)))
  (define float-class-index (cadr (assq 'float indices-info)))

  `(py-specialized-sint-float-dispatch-let
    $obj
    ,obj
    ,sint-class-index
    ,float-class-index
    (py-obj-class-index-general $obj)))

(define-macro (py-obj-class-index-general obj)
  `(PyObjectType-class-index (py-obj-cls-general ,obj)))

;; Specialized type tests for int
(define-macro (py-has-type-sint? obj)
  `(py-specialized-sint-float-dispatch-let
    $obj
    ,obj
    #t
    #f
    (py-if-specialized-sint-representation
      #f
      (and (py-has-type-int? $obj) (fixnum? (py-int-to-scheme $obj))))))

(define-macro (py-has-type-bint? obj)
  `(py-specialized-sint-float-dispatch-let
    $obj
    ,obj
    #f
    #f
    (and (py-has-type-int? $obj) (not (fixnum? (py-int-to-scheme $obj))))))

(define-macro (py-has-type-int? obj)
  `(py-specialized-sint-float-dispatch-let
    $obj
    ,obj
    #t
    #f
    (eq? (PyObject-class $obj) py-int-class)))

(define-macro (py-subtype-of-int? obj)
  `(py-specialized-sint-float-dispatch-let
    $obj
    ,obj
    #t
    #f
    (or (eq? (PyObject-class $obj) py-int-class)
        (py-isinstance? $obj py-int-class))))

(define-macro (py-strict-subtype-of-int? obj)
  `(py-specialized-sint-float-dispatch-let
    $obj
    ,obj
    #f
    #f
    (and (not (eq? (PyObject-class $obj) py-int-class))
         (py-isinstance? $obj py-int-class))))

;; Specialized type tests for float

(define-macro (py-has-type-float? obj)
  `(py-specialized-sint-float-dispatch-let
    $obj
    ,obj
    #f
    #t
    #f))

(define-macro (py-subtype-of-float? obj)
  `(py-specialized-sint-float-dispatch-let
    $obj
    ,obj
    #f
    #t
    (or (eq? (PyObject-class $obj) py-float-class)
        (py-isinstance? $obj py-float-class))))

(define-macro (py-strict-subtype-of-float? obj)
  `(py-specialized-sint-float-dispatch-let
    $obj
    ,obj
    #f
    #f
    (and (not (eq? (PyObject-class $obj) py-float-class))
         (py-isinstance? $obj py-float-class))))

;; Specialized type tests for str

(define-macro (py-has-type-str? obj)
  (let* ((case-PyObject
          `(eq? (PyObject-class $obj) py-str-class))
         (special-case-float
          `(py-if-specialized-float-representation
            (and (not (flonum? $obj))
                 ,case-PyObject)
            ,case-PyObject))
         (special-case-int
          `(py-if-specialized-sint-representation
            (and (not (fixnum? $obj))
                 ,special-case-float)
            ,special-case-float)))
    `(let (($obj ,obj))
       ,special-case-int)))

(define-macro (py-subtype-of-str? obj)
  (let* ((case-PyObject
          `(or (eq? (PyObject-class $obj) ;; optimize common case
                    py-str-class)
               (py-isinstance? $obj py-str-class)))
         (special-case-float
          `(py-if-specialized-float-representation
            (and (not (flonum? $obj))
                 ,case-PyObject)
            ,case-PyObject))
         (special-case-int
          `(py-if-specialized-sint-representation
            (and (not (fixnum? $obj))
                 ,special-case-float)
            ,special-case-float)))
    `(let (($obj ,obj))
       ,special-case-int)))

(define-macro (py-subtype-of-str-from-scheme string str-subclass)
  `(py-subtype-of-str-from-scheme-fallback ,string ,str-subclass))

(define-macro (py-str-to-scheme str)
  `(py-str-to-scheme-fallback ,str))

(define-macro (py-subtype-of-str-to-scheme str)
  `(py-subtype-of-str-to-scheme-fallback ,str))

(define-macro (py-str-representative str)
  `(py-str-representative-fallback ,str))

(define-macro (py-add-strX-strY str1 str2)
  `(py-add-SstrX-SstrY-fallback ,str1 ,str2))

(define-macro (py-getattribute-from-obj-mro-2cont obj name succeed fail)

  (define list-of-magic-attrs ;; keep in sync with rts.scm
    '("__add__" "__radd__" "__iadd__"
      "__mul__" "__rmul__" "__imul__"
      "__sub__" "__rsub__" "__isub__"
      "__eq__" "__ne__" "__lt__" "__le__" "__gt__" "__ge__"
      "__call__" "__get__"))

  (let ((x (and (pair? name)
                (pair? (cdr name))
                (null? (cddr name))
                (eq? (car name) '&)
                (member (cadr name) list-of-magic-attrs))))
    (if (not x)
        `(getattribute-from-obj-mro-fallback ,obj ,name)
        (let ((magic-index (- (length list-of-magic-attrs) (length x))))
          `(let* (($obj ,obj)
                  ($name ,name)
                  ($value
                   (vector-ref (PyObjectType-magic-attrs (py-obj-cls $obj))
                               ,magic-index)))
             (if $value
                 (,succeed $value)
                 ;; TODO: replace this branch by (,fail) when
                 ;; magic-attrs vector is fully filled-in
                 (let (($value
                        (getattribute-from-obj-mro-fallback $obj $name)))
                   (if (eq? $value py-absent)
                       (,fail)
                       (,succeed $value))))))))) ;; Beware of code duplication of succeed branch! (this will go away after the TODO is done)

(define-macro (getattribute-from-obj-mro obj name)
  `(py-getattribute-from-obj-mro-2cont
    ,obj
    ,name
    (lambda ($value) $value)
    (lambda () py-absent)))

;; behavior dispatch

(define-macro (with-class-indices-info . args)
  (let ((info
            ;; WARNING: type must be ordered by class-index and only one
            ;; type by index can have has-specialized-behavior set to #t

            ;; name   class-index     has-specialized-behavior
          '((default       0                  #t)
            (type          0                  #f)
            (object        0                  #f)
            (tuple         0                  #f)
            (sint          1                  #t) ;; is a sint index necessary?
            (bint          2                  #t)
            (bool          3                  #t)
            (float         4                  #t)
            (str           5                  #t))))

    ;; add info as first arg due to rest arguments in py-make-builtin-class
    `(,(car args) ,info ,@(cdr args))))

(define-macro (get-behavior-type-index name)
  `(with-class-indices-info $get-behavior-type-index ,name))

(define-macro ($get-behavior-type-index indices-info name)
  (cadr (assq name indices-info)))

(define-macro (py-make-builtin-class name module bases hclass-of-instances . attrs)
  `(with-class-indices-info $py-make-builtin-class-with-class-index-info ,name ,module ,bases ,hclass-of-instances ,@attrs))

(define-macro ($py-make-builtin-class-with-class-index-info indices-info name module bases hclass-of-instances . attrs)
  (define (get-class-index-by-name name-symbol)
    (if (eq? name-symbol 'int)
      (cadr (assq 'bint indices-info))
      (let ((res (assq name-symbol indices-info)))
        (if res (cadr res) (cadr (assq 'default indices-info))))))

  (if (and (pair? name) (memq (car name) '(& &&)))
    (let* ((name-value (cadr name))
           (class-index (get-class-index-by-name (string->symbol name-value))))
      `(py-make-builtin-class-with-class-index ,class-index ,name ,module ,bases ,hclass-of-instances ,@attrs))
    (error "py-make-builtin-class" "name argument must be a static PyObjectStr" name)))

(define-macro (init-behavior-dispatch-vector)
 `(with-class-indices-info $init-behavior-dispatch-vector))

(define-macro ($init-behavior-dispatch-vector indices-info)
  (define types-with-specialized-behaviors
    (let loop ((info indices-info))
      (cond
        ((null? info) '())
        ((caddar info) ;; has-specialized-behavior
          (cons (car info) (loop (cdr info))))
        (else (loop (cdr info))))))

  (define behavior-table-size (length types-with-specialized-behaviors)) ;; one by behavior + default

  (define inplace-ops
    '(iadd ibitand ibitor ifloordiv ilshift imatmul imod imul ipow irshift isub itruediv ixor))

  (define cmp-ops
    '(eq ne ge gt le lt))

  (define test-cmp-ops
    '(test-eq test-ne test-ge test-gt test-le test-lt))

  (define binary-ops-with-behaviors
    (append
      '(add bitand bitor floordiv lshift matmul mod mul pow rshift sub truediv xor)
      inplace-ops
      cmp-ops
      test-cmp-ops))

  (define unary-ops-with-behaviors
    '(pos neg invert))

  (define (test-op->cmp-op op)
    (case op
      ((test-eq) 'eq)
      ((test-ne) 'ne)
      ((test-ge) 'ge)
      ((test-gt) 'gt)
      ((test-le) 'le)
      ((test-lt) 'lt)))

  (define (get-behaviors-table-name op)
    (string->symbol (string-append "py-" (symbol->string op) "-behaviors-table")))

  (define (get-binary-behavior-name op lhs-type rhs-type)
    (if (or (eq? lhs-type 'default) (eq? rhs-type 'default))
      ;; use the full semantics
      (cond
        ((memq op inplace-ops)
          (string->symbol
            (string-append "py-" (symbol->string op) "-fallback:inplace")))
        ((memq op test-cmp-ops)
          ;; call comparison semantics followed by bool semantics
          `(lambda (x y)
            (py-test
              (,(string->symbol (string-append "py-" (symbol->string (test-op->cmp-op op)) "-fallback"))
                x y))))
        (else
          (string->symbol
            (string-append "py-" (symbol->string op) "-fallback:normal"))))
      ;; use a behavior
      (string->symbol
        (string-append
          "py-"
          (symbol->string op)
          "-"
          (symbol->string lhs-type)
          "X-"
          (symbol->string rhs-type)
          "Y-fallback"))))

  (define (get-unary-behavior-name op type)
    (if (or (eq? type 'default))
      ;; use the full semantics
      (string->symbol
          (string-append "py-" (symbol->string op) "-fallback:normal"))
      ;; use a behavior
      (string->symbol
        (string-append
          "py-"
          (symbol->string op)
          "-"
          (symbol->string type)
          "X-fallback"))))

  (define (make-binary-behaviors-list op)
    (let lhs-loop ((lhs-types types-with-specialized-behaviors))
      (if (null? lhs-types)
        '()
        (let rhs-loop ((rhs-types types-with-specialized-behaviors))
          (if (null? rhs-types)
            (lhs-loop (cdr lhs-types))
            (cons
              (get-binary-behavior-name op (caar lhs-types) (caar rhs-types))
              (rhs-loop (cdr rhs-types))))))))

  (define (make-unary-behaviors-list op)
    (let loop ((types types-with-specialized-behaviors))
      (if (null? types)
        '()
        (cons
          (get-unary-behavior-name op (caar types))
          (loop (cdr types))))))

  (define (get-behavior-call-fallback-name op)
    (string->symbol
      (string-append "py-" (symbol->string op) "-behavior-call-fallback")))

  (define (get-behavior-call-with-lhs-index-fallback-name op)
    (string->symbol
      (string-append "py-" (symbol->string op) "-behavior-call-with-lhs-index-fallback")))

  (define (get-behavior-call-with-rhs-index-fallback-name op)
    (string->symbol
      (string-append "py-" (symbol->string op) "-behavior-call-with-rhs-index-fallback")))

  (define (get-binary-behavior-call-fallback op)
    `(define (,(get-behavior-call-fallback-name op) lhs rhs)
        ($py-binary-behavior-call ,op lhs rhs)))

  (define (get-behavior-call-with-lhs-index-fallback op)
    `(define (,(get-behavior-call-with-lhs-index-fallback-name op) lhs-index lhs rhs)
        ($py-binary-behavior-call-with-lhs-index ,op lhs-index lhs rhs)))

  (define (get-behavior-call-with-rhs-index-fallback op)
    `(define (,(get-behavior-call-with-rhs-index-fallback-name op) lhs rhs-index rhs)
        ($py-binary-behavior-call-with-rhs-index ,op lhs rhs-index rhs)))

  (define (get-unary-behavior-call-fallback op)
    `(define (,(get-behavior-call-fallback-name op) x)
        ($py-unary-behavior-call ,op x)))

  (define (make-init-table-code ops behaviors-list-maker)
    (if (null? ops)
      '()
      (let* ((op (car ops))
            (behaviors-table-name (get-behaviors-table-name op))
            (behaviors (behaviors-list-maker op)))
        (cons
          `(define ,behaviors-table-name (vector ,@behaviors))
          (make-init-table-code (cdr ops) behaviors-list-maker)))))

  (let ((tables-init-code
          (append
            (make-init-table-code binary-ops-with-behaviors make-binary-behaviors-list)
            (make-init-table-code unary-ops-with-behaviors make-unary-behaviors-list)))
        (behavior-call-fallbacks
          (append
            (let loop ((ops binary-ops-with-behaviors))
              (if (null? ops)
                '()
                (let* ((op (car ops))
                      (binary-behavior-call-fallback (get-binary-behavior-call-fallback op))
                      (behavior-call-with-lhs-index-fallback (get-behavior-call-with-lhs-index-fallback op))
                      (behavior-call-with-rhs-index-fallback (get-behavior-call-with-rhs-index-fallback op)))
                  (cons
                    binary-behavior-call-fallback
                    (cons
                      behavior-call-with-lhs-index-fallback
                      (cons
                        behavior-call-with-rhs-index-fallback
                        (loop (cdr ops))))))))
            (let loop ((ops unary-ops-with-behaviors))
              (if (null? ops)
                '()
                (let* ((op (car ops))
                      (unary-behavior-call-fallback (get-unary-behavior-call-fallback op)))
                  (cons
                    unary-behavior-call-fallback
                    (loop (cdr ops)))))))))
    `(begin
        ,@tables-init-code
        ,@behavior-call-fallbacks)))

(define-macro (get-behavior-index lhs-index rhs-index)
   `(with-class-indices-info $get-behavior-index ,lhs-index ,rhs-index))

(define-macro ($get-behavior-index indices-info lhs-index rhs-index)
  (define indices
    (let loop ((info indices-info))
      (cond
        ((null? info) '())
        ((caddar info) ;has-specialized-behavior
          (cons (cadar info) (loop (cdr info))))
        (else (loop (cdr info))))))

  (define indices-length (length indices))

  (cond-expand
    (gambit
      `(|##fx+| (|##fx*| ,indices-length ,lhs-index) ,rhs-index))
    (bigloo
      `(+fx (*fx ,indices-length ,lhs-index) ,rhs-index))))

(define-macro (py-binary-behavior-ref op lhs-index rhs-index)
  (let ((behavior-table-name
          (string->symbol (string-append "py-" (symbol->string op) "-behaviors-table"))))
    `(vector-ref ,behavior-table-name (get-behavior-index ,lhs-index ,rhs-index))))

(define-macro (py-unary-behavior-ref op index)
  (let ((behavior-table-name
          (string->symbol (string-append "py-" (symbol->string op) "-behaviors-table"))))
    `(vector-ref ,behavior-table-name ,index)))

(define-macro (py-binary-behavior-call op lhs rhs)
  (let ((behavior-call-fallback-name
          (string->symbol
            (string-append "py-" (symbol->string op) "-behavior-call-fallback"))))
    `(py-if-enable-inline-behavior-dispatch
        ($py-binary-behavior-call ,op ,lhs ,rhs)
        (,behavior-call-fallback-name ,lhs ,rhs))))

(define-macro ($py-binary-behavior-call op lhs rhs)
  `(let (($lhs ,lhs)
         ($rhs ,rhs))
      ((py-binary-behavior-ref
        ,op
        (py-obj-class-index $lhs)
        (py-obj-class-index $rhs))
        $lhs
        $rhs)))


(define-macro (py-unary-behavior-call op lhs)
  (let ((behavior-call-fallback-name
          (string->symbol
            (string-append "py-" (symbol->string op) "-behavior-call-fallback"))))
    `(py-if-enable-inline-behavior-dispatch
        ($py-binary-behavior-call ,op ,lhs)
        (,behavior-call-fallback-name ,lhs))))

(define-macro ($py-unary-behavior-call op lhs)
  `(let (($lhs ,lhs))
      ((py-unary-behavior-ref
        ,op
        (py-obj-class-index $lhs))
        $lhs)))

(define-macro (py-binary-behavior-call-with-lhs-index op lhs-index lhs rhs)
  (let ((behavior-call-fallback-name
          (string->symbol
            (string-append "py-" (symbol->string op) "-behavior-call-with-lhs-index-fallback"))))
    `(py-if-enable-inline-partial-behavior-dispatch
        ($py-binary-behavior-call-with-lhs-index ,op ,lhs-index ,lhs ,rhs)
        (,behavior-call-fallback-name ,lhs-index ,lhs ,rhs))))

(define-macro ($py-binary-behavior-call-with-lhs-index op lhs-index lhs rhs)
  `(let (($rhs ,rhs))
      ((py-binary-behavior-ref
        ,op
        ,lhs-index
        (py-obj-class-index $rhs))
        ,lhs
        $rhs)))

(define-macro (py-binary-behavior-call-with-rhs-index op lhs rhs-index rhs)
  (let ((behavior-call-fallback-name
          (string->symbol
            (string-append "py-" (symbol->string op) "-behavior-call-with-rhs-index-fallback"))))
    `(py-if-enable-inline-partial-behavior-dispatch
        ($py-binary-behavior-call-with-rhs-index ,op ,lhs ,rhs-index ,rhs)
        (,behavior-call-fallback-name ,lhs ,rhs-index ,rhs))))

(define-macro ($py-binary-behavior-call-with-rhs-index op lhs rhs-index rhs)
  `(let (($lhs ,lhs))
      ((py-binary-behavior-ref
        ,op
        (py-obj-class-index $lhs)
        ,rhs-index)
        $lhs
        ,rhs)))

;; Semantics

(define-macro (py-specialized-binop-dispatch op lhs rhs)
  `(with-class-indices-info $py-specialized-binop-dispatch ,op ,lhs ,rhs))

(define-macro ($py-specialized-binop-dispatch indices-info op lhs rhs)

  (define sint-sint-op (string->symbol (string-append "py-" (symbol->string op) "-sintX-sintY-inline")))
  (define float-float-op (string->symbol (string-append "py-" (symbol->string op) "-floatX-floatY-inline")))
  (define sint-float-op (string->symbol (string-append "py-" (symbol->string op) "-sintX-floatY-inline")))
  (define float-sint-op (string->symbol (string-append "py-" (symbol->string op) "-floatX-sintY-inline")))

  (define sint-class-index (cadr (assq 'sint indices-info)))
  (define float-class-index (cadr (assq 'float indices-info)))

  `(py-if-enable-behaviors-optimization
    (let (($lhs ,lhs)
          ($rhs ,rhs))
      (cond ((py-if-specialized-sint-representation (fixnum? $lhs) #f)
             (py-if-enable-inlined-mixed-types-behaviors
              (cond
               ((py-if-specialized-sint-representation (fixnum? $rhs) #f)
                (,sint-sint-op $lhs $rhs))
               ((py-if-specialized-float-representation (flonum? $rhs) #f)
                (,sint-float-op $lhs $rhs))
               (else
                (py-binary-behavior-call-with-lhs-index ,op ,sint-class-index $lhs $rhs)))
              (if (py-if-specialized-sint-representation (fixnum? $rhs) #f)
                  (,sint-sint-op $lhs $rhs)
                  (py-binary-behavior-call-with-lhs-index ,op ,sint-class-index $lhs $rhs))))
            ((py-if-specialized-float-representation (flonum? $lhs) #f)
             (py-if-enable-inlined-mixed-types-behaviors
              (cond
               ((py-if-specialized-sint-representation (fixnum? $rhs) #f)
                (,float-sint-op $lhs $rhs))
               ((flonum? $rhs)
                (,float-float-op $lhs $rhs))
               (else
                (py-binary-behavior-call-with-lhs-index ,op ,float-class-index $lhs $rhs)))
              (if (flonum? $rhs)
                  (,float-float-op $lhs $rhs)
                  (py-binary-behavior-call-with-lhs-index ,op ,float-class-index $lhs $rhs))))
            (else
             (py-binary-behavior-call ,op $lhs $rhs))))
    (,(string->symbol (string-append "py-" (symbol->string op) "-fallback")) ,lhs ,rhs)))

(define-macro (py-specialized-unop-dispatch op x)
  `(with-class-indices-info $py-specialized-unop-dispatch ,op ,x))

(define-macro ($py-specialized-unop-dispatch indices-info op x)

  (define sint-op (string->symbol (string-append "py-" (symbol->string op) "-sintX-inline")))
  (define float-op (string->symbol (string-append "py-" (symbol->string op) "-floatX-inline")))

  `(py-if-enable-behaviors-optimization
    (let (($x ,x))
      (cond ((py-if-specialized-sint-representation (fixnum? $x) #f)
             (,sint-op $x))
            ((py-if-specialized-float-representation (flonum? $x) #f)
             (,float-op $x))
            (else
             (py-unary-behavior-call ,op $x))))
    (,(string->symbol (string-append "py-" (symbol->string op) "-fallback")) ,x)))

(define-macro (py-add x y)
  (if (and (pair? x) (memq (car x) '(& &&)) (pair? y) (memq (car y) '(& &&)))
    `(&& ,(string-append (cadr x) (cadr y)))
    `(py-specialized-binop-dispatch add ,x ,y)))

(define-macro (py-bitand x y)
  `(py-specialized-binop-dispatch bitand ,x ,y))

(define-macro (py-bitor x y)
  `(py-specialized-binop-dispatch bitor ,x ,y))

(define-macro (py-floordiv x y)
  `(py-specialized-binop-dispatch floordiv ,x ,y))

(define-macro (py-lshift x y)
  `(py-specialized-binop-dispatch lshift ,x ,y))

(define-macro (py-matmul x y)
  `(py-specialized-binop-dispatch matmul ,x ,y))

(define-macro (py-mod x y)
  `(py-specialized-binop-dispatch mod ,x ,y))

(define-macro (py-mul x y)
  (define (str-literal? o)
    (if (and (pair? o) (memq (car o) '(& &&)))
      (cadr o)
      #f))

  (define (int-literal? o)
    (if (and (pair? o) (eq? (car o) 'py-int-from-scheme))
      (cadr o)
      #f))

  (define (str-mul? s count)
    (if (< (* (string-length s) count) 1000) ;; Put some limit on the result size at compile-time
      (fold string-append "" (make-list count s))
      #f))

  (define (str-mul-literal? lhs rhs)
    (let ((lhs-int (int-literal? lhs))
          (lhs-str (str-literal? lhs))
          (rhs-int (int-literal? rhs))
          (rhs-str (str-literal? rhs)))
    (cond
      ((and lhs-int rhs-str)
        `(&& ,(str-mul? rhs-str lhs-int)))
      ((and lhs-str rhs-int)
        `(&& ,(str-mul? lhs-str rhs-int)))
      (else
        #f))))

  (or (str-mul-literal? x y) `(py-specialized-binop-dispatch mul ,x ,y)))

(define-macro (py-pow x y)
  `(py-specialized-binop-dispatch pow ,x ,y))

(define-macro (py-rshift x y)
  `(py-specialized-binop-dispatch rshift ,x ,y))

(define-macro (py-sub x y)
  `(py-specialized-binop-dispatch sub ,x ,y))

(define-macro (py-truediv x y)
  `(py-specialized-binop-dispatch truediv ,x ,y))

(define-macro (py-xor x y)
  `(py-specialized-binop-dispatch xor ,x ,y))

(define-macro (py-iadd x y)
  `(py-specialized-binop-dispatch iadd ,x ,y))

(define-macro (py-ibitand x y)
  `(py-specialized-binop-dispatch ibitand ,x ,y))

(define-macro (py-ibitor x y)
  `(py-specialized-binop-dispatch ibitor ,x ,y))

(define-macro (py-ifloordiv x y)
  `(py-specialized-binop-dispatch ifloordiv ,x ,y))

(define-macro (py-ilshift x y)
  `(py-specialized-binop-dispatch ilshift ,x ,y))

(define-macro (py-imatmul x y)
  `(py-specialized-binop-dispatch imatmul ,x ,y))

(define-macro (py-imod x y)
  `(py-specialized-binop-dispatch imod ,x ,y))

(define-macro (py-imul x y)
  `(py-specialized-binop-dispatch imul ,x ,y))

(define-macro (py-ipow x y)
  `(py-specialized-binop-dispatch ipow ,x ,y))

(define-macro (py-irshift x y)
  `(py-specialized-binop-dispatch irshift ,x ,y))

(define-macro (py-isub x y)
  `(py-specialized-binop-dispatch isub ,x ,y))

(define-macro (py-itruediv x y)
  `(py-specialized-binop-dispatch itruediv ,x ,y))

(define-macro (py-ixor x y)
  `(py-specialized-binop-dispatch ixor ,x ,y))

(define-macro (py-pos x)
  `(py-specialized-unop-dispatch pos ,x))

(define-macro (py-neg x)
  `(py-specialized-unop-dispatch neg ,x))

(define-macro (py-invert x)
  `(py-specialized-unop-dispatch invert ,x))

(define-macro (py-ge x y)
  `(py-specialized-binop-dispatch ge ,x ,y))

(define-macro (py-gt x y)
  `(py-specialized-binop-dispatch gt ,x ,y))

(define-macro (py-le x y)
  `(py-specialized-binop-dispatch le ,x ,y))

(define-macro (py-lt x y)
  `(py-specialized-binop-dispatch lt ,x ,y))

(define-macro (py-eq x y)
  `(py-specialized-binop-dispatch eq ,x ,y))

(define-macro (py-ne x y)
  `(py-specialized-binop-dispatch ne ,x ,y))

(define-macro (py-is x y) ;; x is y
  `(if (py-test-is ,x ,y) py-True py-False))

(define-macro (py-isnot x y) ;; x is not y
  `(if (py-test-isnot ,x ,y) py-True py-False))

(define-macro (py-test-ge x y)
  `(py-specialized-binop-dispatch test-ge ,x ,y))

(define-macro (py-test-gt x y)
  `(py-specialized-binop-dispatch test-gt ,x ,y))

(define-macro (py-test-le x y)
  `(py-specialized-binop-dispatch test-le ,x ,y))

(define-macro (py-test-lt x y)
  `(py-specialized-binop-dispatch test-lt ,x ,y))

(define-macro (py-test-eq x y)
  `(py-specialized-binop-dispatch test-eq ,x ,y))

(define-macro (py-test-ne x y)
  `(py-specialized-binop-dispatch test-ne ,x ,y))

(define-macro (py-test-is x y)
  `(eq? ,x ,y))

(define-macro (py-test-isnot x y)
  `(not (py-test-is ,x ,y)))

(define-macro (py-test x)

  (define cmp-operator-test-version
    '((py-eq py-test-eq)
      (py-ne py-test-ne)
      (py-ge py-test-ge)
      (py-gt py-test-gt)
      (py-le py-test-le)
      (py-lt py-test-lt)
      (py-is py-test-is)
      (py-isnot py-test-isnot)))

  (if (pair? x)
      (let ((test-version (assq (car x) cmp-operator-test-version)))
        (if test-version
            `(,(cadr test-version) ,@(cdr x))
            `(py-test-fallback ,x)))
      `(py-test-fallback ,x)))

(define-macro (py-getattribute obj attr)
  `(py-getattribute-fallback ,obj ,attr))

(define-macro (py-setattribute obj attr val)
  `(py-setattribute-fallback ,obj ,attr ,val))

(define-macro (py-getitem obj item)
  `(py-getitem-fallback ,obj ,item))

(define-macro (py-setitem obj item value)
  `(py-setitem-fallback ,obj ,item ,value))

(define-macro (py-delitem obj item)
  `(py-delitem-fallback ,obj ,item))

(define-macro (py-enter obj)
  `(py-enter-fallback ,obj))

(define-macro (py-exit obj exc)
  `(py-exit-fallback ,obj ,exc))
