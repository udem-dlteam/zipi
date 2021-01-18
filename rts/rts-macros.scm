;; Macros to enable/disable various implementation strategies.

(define-macro (py-if-specialized-sint-representation yes no) yes)
(define-macro (py-if-specialized-float-representation yes no) yes)
(define-macro (py-if-enable-behaviors-optimization yes no) yes)
(define-macro (py-if-enable-inline-behavior-dispatch yes no) no)
(define-macro (py-if-enable-inlined-mixed-types-behaviors yes no) no)

(define-macro (py-bool-to-scheme-float arg)
  `(fixnum->flonum (py-bool-to-scheme ,arg)))

(define-macro (py-sint-to-scheme-float arg)
  `(fixnum->flonum (py-sint-to-scheme ,arg)))

(define-macro (py-bint-to-scheme-float arg)
  `(exact->inexact (py-bint-to-scheme ,arg)))

(define-macro (py-int-to-scheme obj)
  `(py-if-specialized-sint-representation
    (let (($obj ,obj))
      (if (fixnum? $obj)
          $obj
          (py-PyObjectInt-value $obj)))
    (py-PyObjectInt-value ,obj)))

(define-macro (py-subtype-of-int-to-scheme obj)
  `(py-if-specialized-sint-representation
    (let (($obj ,obj))
      (if (fixnum? $obj)
          $obj
          (py-PyObjectInt-value $obj)))
    (py-PyObjectInt-value ,obj)))

(define-macro (py-strict-subtype-of-int-to-scheme obj)
  `(py-PyObjectInt-value ,obj))

(define-macro (py-bool-to-scheme arg)
  `(py-strict-subtype-of-int-to-scheme ,arg)) ;; a bool is an int with value 0 or 1

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
          (py-PyObjectFloat-value $obj)))
    (py-PyObjectFloat-value ,obj)))

(define-macro (py-strict-subtype-of-float-to-scheme obj)
  `(py-PyObjectFloat-value ,obj))

(define-macro (py-int-from-scheme arg)

  ;; assume all small int operations don't cause an overflow?
  (define disregard-sint-overflow? #f)

  (define unary-operators-gambit
    '((pypos    X ;; bool or non-ov. sint
                X ;; sint
                X ;; otherwise
                )
      (pyneg    (py-sint-from-scheme (|##fx-| X)) ;; bool or non-ov. sint
                (or (|##fx-?| X) (py-bint-from-scheme (|##negate| X))) ;; sint
                (py-int-from-scheme (|##negate| X)) ;; otherwise
                )
      (pyinvert (py-sint-from-scheme (|##fxnot| X)) ;; bool or non-ov. sint
                (py-sint-from-scheme (|##fxnot| X)) ;; sint
                (py-int-from-scheme (|##bitwise-not| X)) ;; otherwise
                )))

  (define binary-operators-gambit
    '((py+  (py-sint-from-scheme (|##fx+| X Y)) ;; bool/bool or non-ov. sint/sint
            (or (|##fx+?| X Y) (py-bint-from-scheme (|##+2| X Y))) ;; sint/sint
            (py-int-from-scheme (|##+2| X Y)) ;; otherwise
            )
      (py-  (py-sint-from-scheme (|##fx-| X Y)) ;; bool/bool or non-ov. sint/sint
            (or (|##fx-?| X Y) (py-bint-from-scheme (|##-2| X Y))) ;; sint/sint
            (py-int-from-scheme (|##-2| X Y)) ;; otherwise
            )
      (py*  (py-sint-from-scheme (|##fx*| X Y)) ;; bool/bool or non-ov. sint/sint
            (or (|##fx*?| X Y) (py-bint-from-scheme (|##*2| X Y))) ;; sint/sint
            (py-int-from-scheme (|##*2| X Y)) ;; otherwise
            )
      (py** (py-int-from-scheme (expt X Y)) ;; TODO: define and use a primitive
            (py-int-from-scheme (expt X Y))
            (py-int-from-scheme (expt X Y))
            )
      (py&  (py-sint-from-scheme (|##fxand| X Y)) ;; bool/bool or non-ov. sint/sint
            (py-sint-from-scheme (|##fxand| X Y)) ;; sint/sint
            (py-int-from-scheme (|##bitwise-and| X Y)) ;; otherwise
            )
      (py+b (py-sint-from-scheme (|##fxior| X Y)) ;; bool/bool or non-ov. sint/sint
            (py-sint-from-scheme (|##fxand| X Y)) ;; sint/sint
            (py-int-from-scheme (|##bitwise-ior| X Y)) ;; otherwise
            )
      (py^  (py-sint-from-scheme (|##fxxor| X Y)) ;; bool/bool or non-ov. sint/sint
            (py-sint-from-scheme (|##fxxor| X Y)) ;; sint/sint
            (py-int-from-scheme (|##bitwise-xor| X Y)) ;; otherwise
            )
      (py>> (py-sint-from-scheme (|##fxarithmetic-shift-right| X Y)) ;; bool/bool or non-ov. sint/sint
            (py-int-from-scheme (|##arithmetic-shift| X (|##negate| Y))) ;; sint/sint
            (py-int-from-scheme (|##arithmetic-shift| X (|##negate| Y))) ;; otherwise
            )
      (py<< (py-sint-from-scheme (|##fxarithmetic-shift-left| X Y)) ;; bool/bool or non-ov. sint/sint
            (py-int-from-scheme (|##arithmetic-shift| X Y)) ;; sint/sint
            (py-int-from-scheme (|##arithmetic-shift| X Y)) ;; otherwise
            )
      (py// (py-sint-from-scheme (|##fxquotient| X Y)) ;; bool/bool or non-ov. sint/sint
            (if (|##eqv?| Y -1) ;; sint/sint
                (or (|##fx-?| X) (py-bint-from-scheme (|##negate| X)))
                (|##fxquotient| X Y))
            (py-int-from-scheme (|##quotient| X Y)) ;; otherwise
            )
      (py%  (py-sint-from-scheme (|##fxmodulo| X Y)) ;; bool/bool or non-ov. sint/sint
            (py-sint-from-scheme (|##fxmodulo| X Y)) ;; sint/sint
            (py-int-from-scheme (|##modulo| X Y)) ;; otherwise
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
            (py-int-from-scheme (+ X Y)) ;; sint/sint
            (py-int-from-scheme (+ X Y)) ;; otherwise
            )
      (py-  (py-sint-from-scheme (-fx X Y)) ;; bool/bool or non-ov. sint/sint
            (py-int-from-scheme (- X Y)) ;; sint/sint
            (py-int-from-scheme (- X Y)) ;; otherwise
            )
      (py*  (py-sint-from-scheme (*fx X Y)) ;; bool/bool or non-ov. sint/sint
            (py-int-from-scheme (* X Y)) ;; sint/sint
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
                         '((py-bool-to-scheme bool)
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
   (py-int-from-scheme-fallback ,arg)))

(define-macro (py-bint-from-scheme arg)
 `(py-int-from-scheme-fallback ,arg))

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
                        '((py-bool-to-scheme  bool)
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
     ((bool sint bint int)
      (list (string->symbol
             (string-append (symbol->string (car operand))
                            "-float"))
            (cadr operand)))
     ((float)
      operand)
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

(define-macro (py-specialized-sint-float-dispatch-let name obj int float other)
  `(let ((,name ,obj))
     (cond ((py-if-specialized-sint-representation (fixnum? ,name) #f)
            ,int)
           ((py-if-specialized-float-representation (flonum? ,name) #f)
            ,float)
           (else
            ,other))))

;; Access PyObject fields

(define-macro (py-PyObject-hclass obj)
  (cond-expand
    (gambit ;; TODO: prettify... equivalent to (PyObject-hclass ,obj)
     `(|##unchecked-structure-ref| ,obj 1 #f #f))
    (bigloo
     `(PyObject-hclass ,obj))))

(define-macro (py-PyObject-%elements obj)
  (cond-expand
    (gambit ;; TODO: prettify... equivalent to (PyObject-%elements ,obj)
     `(|##unchecked-structure-ref| ,obj 2 #f #f))
    (bigloo
     `(PyObject-%elements ,obj))))

(define-macro (py-PyObject-class obj)
  (cond-expand
    (gambit ;; TODO: prettify... equivalent to (PyObject-class ,obj)
     `(|##unchecked-structure-ref| ,obj 3 #f #f))
    (bigloo
     `(PyObject-class ,obj))))

;; Get hclass of object given specialized representations of int and float

(define-macro (py-obj-hclass obj)
  `(py-specialized-sint-float-dispatch-let
    $obj
    ,obj
    py-int-hclass-of-instances
    py-float-hclass-of-instances
    (py-PyObject-hclass $obj)))

;; Get class of object given specialized representations of int and float

(define-macro (py-PyObjectType-class-index cls)
  (cond-expand
    (gambit ;; TODO: prettify... equivalent to (PyObjectType-class-index ,cls)
     `(|##unchecked-structure-ref| ,cls 4 #f #f))
    (bigloo
     `(PyObjectType-class-index ,cls))))

(define-macro (py-PyObjectType-mro cls)
  (cond-expand
    (gambit ;; TODO: prettify... equivalent to (PyObjectType-mro ,cls)
     `(|##unchecked-structure-ref| ,cls 6 #f #f))
    (bigloo
     `(PyObjectType-mro ,cls))))

(define-macro (py-obj-cls-general obj)
  `(py-PyObject-class ,obj))

(define-macro (py-obj-cls obj) ;; get object's class
  `(py-specialized-sint-float-dispatch-let
    $obj
    ,obj
    py-int-class
    py-float-class
    (py-obj-cls-general $obj)))

(define-macro (py-obj-mro obj) ;; get MRO of object's class
  `(py-PyObjectType-mro (py-obj-cls ,obj)))

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
  `(py-PyObjectType-class-index (py-obj-cls-general ,obj)))

;; Specialized type tests for int

(define-macro (py-PyObjectInt-value obj)
  (cond-expand
    (gambit ;; TODO: prettify... equivalent to (PyObjectInt-value ,obj)
     `(|##unchecked-structure-ref| ,obj 4 #f #f))
    (bigloo
     `(PyObjectInt-value ,obj))))

(define-macro (py-has-type-int? obj)
  `(py-specialized-sint-float-dispatch-let
    $obj
    ,obj
    #t
    #f
    (eq? (py-PyObject-class $obj) py-int-class)))

(define-macro (py-subtype-of-int? obj)
  `(py-specialized-sint-float-dispatch-let
    $obj
    ,obj
    #t
    #f
    (or (eq? (py-PyObject-class $obj) py-int-class)
        (py-isinstance? $obj py-int-class))))

(define-macro (py-strict-subtype-of-int? obj)
  `(py-specialized-sint-float-dispatch-let
    $obj
    ,obj
    #f
    #f
    (and (not (eq? (py-PyObject-class $obj) py-int-class))
         (py-isinstance? $obj py-int-class))))

;; Specialized type tests for float

(define-macro (py-PyObjectFloat-value obj)
  (cond-expand
    (gambit ;; TODO: prettify... equivalent to (PyObjectFloat-value ,obj)
     `(|##unchecked-structure-ref| ,obj 4 #f #f))
    (bigloo
     `(PyObjectFloat-value ,obj))))

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
    (or (eq? (py-PyObject-class $obj) py-float-class)
        (py-isinstance? $obj py-float-class))))

(define-macro (py-strict-subtype-of-float? obj)
  `(py-specialized-sint-float-dispatch-let
    $obj
    ,obj
    #f
    #f
    (and (not (eq? (py-PyObject-class $obj) py-float-class))
         (py-isinstance? $obj py-float-class))))

;; Specialized type tests for str

(define-macro (py-PyObjectStr-len obj)
  (cond-expand
    (gambit ;; TODO: prettify... equivalent to (PyObjectStr-len ,obj)
     `(|##unchecked-structure-ref| ,obj 4 #f #f))
    (bigloo
     `(PyObjectStr-len ,obj))))

(define-macro (py-PyObjectStr-part1-or-string obj)
  (cond-expand
    (gambit ;; TODO: prettify... equivalent to (PyObjectStr-part1-or-string ,obj)
     `(|##unchecked-structure-ref| ,obj 5 #f #f))
    (bigloo
     `(PyObjectStr-part1-or-string ,obj))))

(define-macro (py-PyObjectStr-part2-or-rep obj)
  (cond-expand
    (gambit ;; TODO: prettify... equivalent to (PyObjectStr-part2-or-rep ,obj)
     `(|##unchecked-structure-ref| ,obj 6 #f #f))
    (bigloo
     `(PyObjectStr-part2-or-rep ,obj))))

(define-macro (py-PyObjectStrRep-hash obj)
  (cond-expand
    (gambit ;; TODO: prettify... equivalent to (PyObjectStrRep-hash ,obj)
     `(|##unchecked-structure-ref| ,obj 7 #f #f))
    (bigloo
     `(PyObjectStrRep-hash ,obj))))

(define-macro (py-has-type-str? obj)
  (let* ((case-PyObject
          `(eq? (py-PyObject-class $obj) py-str-class))
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
          `(or (eq? (py-PyObject-class $obj) ;; optimize common case
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

(define-macro (py-str-from-scheme string)
  `(py-str-from-scheme-fallback ,string))

(define-macro (py-subtype-of-str-from-scheme string str-subclass)
  `(py-subtype-of-str-from-scheme-fallback ,string ,str-subclass))

(define-macro (py-str-to-scheme str)
  `(py-str-to-scheme-fallback ,str))

(define-macro (py-subtype-of-str-to-scheme str)
  `(py-subtype-of-str-to-scheme-fallback ,str))

(define-macro (py-str-representative str)
  `(py-str-representative-fallback ,str))

(define-macro (py-add-strX-strY str1 str2)
  `(py-add-strX-strY-fallback ,str1 ,str2))

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
            (str           0                  #f)
            (tuple         0                  #f)
            (sint          1                  #t) ;; is a sint index necessary?
            (bint          2                  #t)
            (bool          3                  #t)
            (float         4                  #t))))

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

  (define ops-with-behaviors
    (append
      '(add bitand bitor floordiv lshift matmul mod mul pow rshift sub truediv xor)
      inplace-ops))

  (define (get-behaviors-table-name op)
    (string->symbol (string-append "py-" (symbol->string op) "-behaviors-table")))

  (define (get-behavior-name op lhs-type rhs-type)
    (if (or (eq? lhs-type 'default) (eq? rhs-type 'default))
      ;; use the full semantics
      (string->symbol
        (string-append
          "py-"
          (symbol->string op)
          "-fallback"
          (if (memq op inplace-ops) ":inplace" ":normal")))
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

  (define (make-behaviors-list op)
    (let lhs-loop ((lhs-types types-with-specialized-behaviors))
      (if (null? lhs-types)
        '()
        (let rhs-loop ((rhs-types types-with-specialized-behaviors))
          (if (null? rhs-types)
            (lhs-loop (cdr lhs-types))
            (cons
              (get-behavior-name op (caar lhs-types) (caar rhs-types))
              (rhs-loop (cdr rhs-types))))))))

  (define (get-behavior-call-fallback-name op)
    (string->symbol
      (string-append "py-" (symbol->string op) "-behavior-call-fallback")))

  (define (get-behavior-call-with-lhs-index-fallback-name op)
    (string->symbol
      (string-append "py-" (symbol->string op) "-behavior-call-with-lhs-index-fallback")))

  (define (get-behavior-call-with-rhs-index-fallback-name op)
    (string->symbol
      (string-append "py-" (symbol->string op) "-behavior-call-with-rhs-index-fallback")))

  (define (get-behavior-call-fallback op)
    `(define (,(get-behavior-call-fallback-name op) lhs rhs)
        ($py-behavior-call ,op lhs rhs)))

  (define (get-behavior-call-with-lhs-index-fallback op)
    `(define (,(get-behavior-call-with-lhs-index-fallback-name op) lhs-index lhs rhs)
        ($py-behavior-call-with-lhs-index ,op lhs-index lhs rhs)))

  (define (get-behavior-call-with-rhs-index-fallback op)
    `(define (,(get-behavior-call-with-rhs-index-fallback-name op) lhs rhs-index rhs)
        ($py-behavior-call-with-lhs-index ,op lhs rhs-index rhs)))

  (let ((tables-init-code
          (let loop ((ops ops-with-behaviors))
            (if (null? ops)
              '()
              (let* ((op (car ops))
                    (behavior-table-name (get-behaviors-table-name op))
                    (behaviors (make-behaviors-list op)))
                (cons
                  `(define ,behavior-table-name (vector ,@behaviors))
                  (loop (cdr ops)))))))
        (behavior-call-fallbacks
          (let loop ((ops ops-with-behaviors))
            (if (null? ops)
              '()
              (let* ((op (car ops))
                    (behavior-call-fallback (get-behavior-call-fallback op))
                    (behavior-call-with-lhs-index-fallback (get-behavior-call-with-lhs-index-fallback op))
                    (behavior-call-with-rhs-index-fallback (get-behavior-call-with-rhs-index-fallback op)))
                (cons
                  behavior-call-fallback
                  (cons
                    behavior-call-with-lhs-index-fallback
                    (cons
                      behavior-call-with-rhs-index-fallback
                      (loop (cdr ops))))))))))

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

(define-macro (py-behavior-ref op lhs-index rhs-index)
  (let ((behavior-table-name
          (string->symbol (string-append "py-" (symbol->string op) "-behaviors-table"))))
    `(vector-ref ,behavior-table-name (get-behavior-index ,lhs-index ,rhs-index))))

(define-macro (py-behavior-set!! op lhs-index rhs-index val)
  (let ((behavior-table-name
          (string->symbol (string-append "py-" (symbol->string op) "-behaviors-table"))))
    `(vector-set! ,behavior-table-name (get-behavior-index ,lhs-index ,rhs-index) ,val)))

(define-macro (py-behavior-call op lhs rhs)
  (let ((behavior-call-fallback-name
          (string->symbol
            (string-append "py-" (symbol->string op) "-behavior-call-fallback"))))
    `(py-if-enable-inline-behavior-dispatch
        ($py-behavior-call ,op ,lhs ,rhs)
        (,behavior-call-fallback-name ,lhs ,rhs))))

(define-macro ($py-behavior-call op lhs rhs)
  `(let (($lhs ,lhs)
         ($rhs ,rhs))
      ((py-behavior-ref
        ,op
        (py-obj-class-index $lhs)
        (py-obj-class-index $rhs))
        $lhs
        $rhs)))

(define-macro (py-behavior-call-with-lhs-index op lhs-index lhs rhs)
  (let ((behavior-call-fallback-name
          (string->symbol
            (string-append "py-" (symbol->string op) "-behavior-call-with-lhs-index-fallback"))))
    `(py-if-enable-inline-behavior-dispatch
        ($py-behavior-call-with-lhs-index ,op ,lhs-index ,lhs ,rhs)
        (,behavior-call-fallback-name ,lhs-index ,lhs ,rhs))))

(define-macro ($py-behavior-call-with-lhs-index op lhs-index lhs rhs)
  `(let (($rhs ,rhs))
      ((py-behavior-ref
        ,op
        ,lhs-index
        (py-obj-class-index $rhs))
        ,lhs
        $rhs)))

(define-macro (py-behavior-call-with-rhs-index op lhs rhs-index rhs)
  (let ((behavior-call-fallback-name
          (string->symbol
            (string-append "py-" (symbol->string op) "-behavior-call-with-rhs-index-fallback"))))
    `(py-if-enable-inline-behavior-dispatch
        ($py-behavior-call-with-rhs-index ,op ,lhs ,rhs-index ,rhs)
        (,behavior-call-fallback-name ,lhs ,rhs-index rhs))))

(define-macro ($py-behavior-call-with-rhs-index op lhs rhs-index rhs)
  `(let (($lhs ,lhs))
      ((py-behavior-ref
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
                      (py-behavior-call-with-lhs-index ,op ,sint-class-index $lhs $rhs)))
                  (if (fixnum? $rhs)
                    (,sint-sint-op $lhs $rhs)
                    (py-behavior-call-with-lhs-index ,op ,sint-class-index $lhs $rhs))))
             ((py-if-specialized-float-representation (flonum? $lhs) #f)
                (py-if-enable-inlined-mixed-types-behaviors
                  (cond
                    ((py-if-specialized-sint-representation (fixnum? $rhs) #f)
                      (,float-sint-op $lhs $rhs))
                    ((flonum? $rhs)
                      (,float-float-op $lhs $rhs))
                    (else
                      (py-behavior-call-with-lhs-index ,op ,float-class-index $lhs $rhs)))
                  (if (flonum? $rhs)
                    (,float-float-op $lhs $rhs)
                    (py-behavior-call-with-lhs-index ,op ,float-class-index $lhs $rhs))))
             (else
               (cond
                 ((py-if-specialized-sint-representation (fixnum? $rhs) #f)
                   (py-behavior-call-with-rhs-index ,op $lhs ,sint-class-index $rhs))
                 ((py-if-specialized-float-representation (flonum? $rhs) #f)
                   (py-behavior-call-with-rhs-index ,op $lhs ,float-class-index $rhs))
                 (else
                   (py-behavior-call ,op $lhs $rhs))))))
    (,(string->symbol (string-append "py-" (symbol->string op) "-fallback")) ,lhs ,rhs)))

(define-macro (py-add x y)
  `(py-specialized-binop-dispatch add ,x , y))

(define-macro (py-bitand x y)
  `(py-specialized-binop-dispatch bitand ,x , y))

(define-macro (py-bitor x y)
  `(py-specialized-binop-dispatch bitor ,x , y))

(define-macro (py-floordiv x y)
  `(py-specialized-binop-dispatch floordiv ,x , y))

(define-macro (py-lshift x y)
  `(py-specialized-binop-dispatch lshift ,x , y))

(define-macro (py-matmul x y)
  `(py-specialized-binop-dispatch matmul ,x , y))

(define-macro (py-mod x y)
  `(py-specialized-binop-dispatch mod ,x , y))

(define-macro (py-mul x y)
  `(py-specialized-binop-dispatch mul ,x , y))

(define-macro (py-pow x y)
  `(py-specialized-binop-dispatch pow ,x , y))

(define-macro (py-rshift x y)
  `(py-specialized-binop-dispatch rshift ,x , y))

(define-macro (py-sub x y)
  `(py-specialized-binop-dispatch sub ,x , y))

(define-macro (py-truediv x y)
  `(py-specialized-binop-dispatch truediv ,x , y))

(define-macro (py-xor x y)
  `(py-specialized-binop-dispatch xor ,x , y))

(define-macro (py-iadd x y)
  `(py-specialized-binop-dispatch iadd ,x , y))

(define-macro (py-ibitand x y)
  `(py-specialized-binop-dispatch ibitand ,x , y))

(define-macro (py-ibitor x y)
  `(py-specialized-binop-dispatch ibitor ,x , y))

(define-macro (py-ifloordiv x y)
  `(py-specialized-binop-dispatch ifloordiv ,x , y))

(define-macro (py-ilshift x y)
  `(py-specialized-binop-dispatch ilshift ,x , y))

(define-macro (py-imatmul x y)
  `(py-specialized-binop-dispatch imatmul ,x , y))

(define-macro (py-imod x y)
  `(py-specialized-binop-dispatch imod ,x , y))

(define-macro (py-imul x y)
  `(py-specialized-binop-dispatch imul ,x , y))

(define-macro (py-ipow x y)
  `(py-specialized-binop-dispatch ipow ,x , y))

(define-macro (py-irshift x y)
  `(py-specialized-binop-dispatch irshift ,x , y))

(define-macro (py-isub x y)
  `(py-specialized-binop-dispatch isub ,x , y))

(define-macro (py-itruediv x y)
  `(py-specialized-binop-dispatch itruediv ,x , y))

(define-macro (py-ixor x y)
  `(py-specialized-binop-dispatch ixor ,x , y))

(define-macro (py-getattribute obj attr)
  `(py-getattribute-fallback ,obj ,attr))

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

(define-macro (py-test-is x y)
  `(eq? ,x ,y))
