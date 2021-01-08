;; Macros to enable/disable various implementation strategies.

;; Should the Python int type be represented using fixnums and bignums?
(define-macro (py-if-specialized-int-representation yes no) yes)

;; Should the Python float type be represented using flonums?
(define-macro (py-if-specialized-float-representation yes no) no)

(define-macro (py-specialized-int-float-dispatch-let name obj int float other)
  `(let ((,name ,obj))
     (cond ((py-if-specialized-int-representation (exact-int? ,name) #f)
            ,int)
           ((py-if-specialized-float-representation (flonum? ,name) #f)
            ,float)
           (else
            ,other))))

(define-macro (exact-int? obj)
  (cond-expand
    (gambit
     `(exact-integer? ,obj))
    (bigloo
     `(let (($obj ,obj))
        (or (fixnum? $obj) (bignum? $obj))))))

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
  `(py-specialized-int-float-dispatch-let
    $obj
    ,obj
    py-int-hclass-of-instances
    py-float-hclass-of-instances
    (py-PyObject-hclass $obj)))

;; Get class of object given specialized representations of int and float

(define-macro (py-PyObjectType-mro cls)
  (cond-expand
    (gambit ;; TODO: prettify... equivalent to (PyObjectType-mro ,cls)
     `(|##unchecked-structure-ref| ,cls 5 #f #f))
    (bigloo
     `(PyObjectType-mro ,cls))))

(define-macro (py-obj-cls obj) ;; get object's class
  (let* ((special-case-float
          `(py-if-specialized-float-representation
            (if (flonum? $obj)
                py-float-class
                (py-PyObject-class $obj))
            (py-PyObject-class $obj)))
         (special-case-int
          `(py-if-specialized-int-representation
            (if (exact-int? $obj)
                py-int-class
                ,special-case-float)
            ,special-case-float)))
    `(let (($obj ,obj))
       ,special-case-int)))

(define-macro (py-obj-mro obj) ;; get MRO of object's class
  `(py-PyObjectType-mro (py-obj-cls ,obj)))

;; Specialized type tests for int

(define-macro (py-PyObjectInt-value obj)
  (cond-expand
    (gambit ;; TODO: prettify... equivalent to (PyObjectInt-value ,obj)
     `(|##unchecked-structure-ref| ,obj 4 #f #f))
    (bigloo
     `(PyObjectInt-value ,obj))))

(define-macro (py-has-type-int? obj)
  (let* ((case-PyObject
          `(py-if-specialized-int-representation
            #f
            (eq? (py-PyObject-class $obj) py-int-class)))
         (special-case-float
          `(py-if-specialized-float-representation
            (and (not (flonum? $obj))
                 ,case-PyObject)
            ,case-PyObject))
         (special-case-int
          `(py-if-specialized-int-representation
            (exact-int? $obj)
            ,special-case-float)))
    `(let (($obj ,obj))
       ,special-case-int)))

(define-macro (py-subtype-of-int? obj)
  (let* ((case-PyObject
          `(or (py-if-specialized-int-representation
                #f
                (eq? (py-PyObject-class $obj) ;; optimize common case
                     py-int-class))
               (py-isinstance? $obj py-int-class)))
         (special-case-float
          `(py-if-specialized-float-representation
            (and (not (flonum? $obj))
                 ,case-PyObject)
            ,case-PyObject))
         (special-case-int
          `(py-if-specialized-int-representation
            (or (exact-int? $obj)
                ,special-case-float)
            ,special-case-float)))
    `(let (($obj ,obj))
       ,special-case-int)))

(define-macro (py-int-from-scheme value)
  (if (and (number? value) (exact? value) (integer? value)) ;; TODO: get (exact-integer? value) to work here with bigloo
      `(py-if-specialized-int-representation
        ,value
        ,(let ()
           (define int-cache-low -5) ;; must be same as in rts.scm
           (define int-cache-high 256)
           (if (and (<= value int-cache-high)
                    (>= value int-cache-low))
               `(vector-ref int-cache ,(- value int-cache-low))
               `(py-int-from-scheme-fallback ,value))))
      `(py-int-from-scheme-fallback ,value)))

(define-macro (py-int-to-scheme obj)
  `(py-if-specialized-int-representation
    ,obj
    (py-PyObjectInt-value ,obj)))

(define-macro (py-subtype-of-int-to-scheme obj)
  `(py-if-specialized-int-representation
    (let (($obj ,obj))
      (if (exact-int? $obj)
          $obj
          (py-PyObjectInt-value $obj)))
    (py-PyObjectInt-value ,obj)))

;; Specialized type tests for float

(define-macro (py-PyObjectFloat-value obj)
  (cond-expand
    (gambit ;; TODO: prettify... equivalent to (PyObjectFloat-value ,obj)
     `(|##unchecked-structure-ref| ,obj 4 #f #f))
    (bigloo
     `(PyObjectFloat-value ,obj))))

(define-macro (py-has-type-float? obj)
  (let* ((case-PyObject
          `(py-if-specialized-float-representation
            #f
            (eq? (py-PyObject-class $obj) py-float-class)))
         (special-case-int
          `(py-if-specialized-int-representation
            (and (not (exact-int? $obj))
                 ,case-PyObject)
            ,case-PyObject))
         (special-case-float
          `(py-if-specialized-float-representation
            (flonum? $obj)
            ,special-case-int)))
    `(let (($obj ,obj))
       ,special-case-float)))

(define-macro (py-subtype-of-float? obj)
  (let* ((case-PyObject
          `(or (py-if-specialized-float-representation
                #f
                (eq? (py-PyObject-class $obj) ;; optimize common case
                     py-float-class))
               (py-isinstance? $obj py-float-class)))
         (special-case-int
          `(py-if-specialized-int-representation
            (and (not (exact-int? $obj))
                 ,case-PyObject)
            ,case-PyObject))
         (special-case-float
          `(py-if-specialized-float-representation
            (or (flonum? $obj)
                ,special-case-int)
            ,special-case-int)))
    `(let (($obj ,obj))
       ,special-case-float)))

(define-macro (py-float-from-scheme value)
  `(py-if-specialized-float-representation
    ,value
    (py-float-from-scheme-fallback ,value)))

(define-macro (py-float-to-scheme obj)
  `(py-if-specialized-float-representation
    ,obj
    (py-PyObjectFloat-value ,obj)))

(define-macro (py-subtype-of-float-to-scheme obj)
  `(py-if-specialized-float-representation
    (let (($obj ,obj))
      (if (flonum? $obj)
          $obj
          (py-PyObjectFloat-value $obj)))
    (py-PyObjectFloat-value ,obj)))

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
          `(py-if-specialized-int-representation
            (and (not (exact-int? $obj))
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
          `(py-if-specialized-int-representation
            (and (not (exact-int? $obj))
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


;; Semantics

(define-macro (py-add x y)
  `(py-add-fallback ,x ,y))

(define-macro (py-bitand x y)
  `(py-bitand-fallback ,x ,y))

(define-macro (py-bitor x y)
  `(py-bitor-fallback ,x ,y))

(define-macro (py-floordiv x y)
  `(py-floordiv-fallback ,x ,y))

(define-macro (py-lshift x y)
  `(py-lshift-fallback ,x ,y))

(define-macro (py-matmul x y)
  `(py-matmul-fallback ,x ,y))

(define-macro (py-mod x y)
  `(py-mod-fallback ,x ,y))

(define-macro (py-mul x y)
  `(py-mul-fallback ,x ,y))

(define-macro (py-pow x y)
  `(py-pow-fallback ,x ,y))

(define-macro (py-rshift x y)
  `(py-rshift-fallback ,x ,y))

(define-macro (py-sub x y)
  `(py-sub-fallback ,x ,y))

(define-macro (py-truediv x y)
  `(py-truediv-fallback ,x ,y))

(define-macro (py-xor x y)
  `(py-xor-fallback ,x ,y))

(define-macro (py-iadd x y)
  `(py-iadd-fallback ,x ,y))

(define-macro (py-ibitand x y)
  `(py-ibitand-fallback ,x ,y))

(define-macro (py-ibitor x y)
  `(py-ibitor-fallback ,x ,y))

(define-macro (py-ifloordiv x y)
  `(py-ifloordiv-fallback ,x ,y))

(define-macro (py-ilshift x y)
  `(py-ilshift-fallback ,x ,y))

(define-macro (py-imatmul x y)
  `(py-imatmul-fallback ,x ,y))

(define-macro (py-imod x y)
  `(py-imod-fallback ,x ,y))

(define-macro (py-imul x y)
  `(py-imul-fallback ,x ,y))

(define-macro (py-ipow x y)
  `(py-ipow-fallback ,x ,y))

(define-macro (py-irshift x y)
  `(py-irshift-fallback ,x ,y))

(define-macro (py-isub x y)
  `(py-isub-fallback ,x ,y))

(define-macro (py-itruediv x y)
  `(py-itruediv-fallback ,x ,y))

(define-macro (py-ixor x y)
  `(py-ixor-fallback ,x ,y))

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
