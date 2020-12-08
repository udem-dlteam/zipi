;; Macros to enable/disable various implementation strategies.

;; Should the Python int type be represented using fixnums and bignums?
(define-macro (py-if-specialized-int-representation yes no) yes)

;; Should the Python float type be represented using flonums?
(define-macro (py-if-specialized-float-representation yes no) no)

;; Get class of object given specialized representations of int and float

(define-macro (py-obj-cls obj) ;; get object's class
  (let* ((fallback
          (cond-expand
            (gambit ;; TODO: prettify... equivalent to (PyObject-class $obj)
             `(|##unchecked-structure-ref| $obj 3 #f #f))
            (bigloo
             `(PyObject-class $obj))))
         (special-case-float
          `(py-if-specialized-float-representation
            (if (flonum? $obj) py-float-class ,fallback)
            ,fallback))
         (special-case-int
          `(py-if-specialized-int-representation
            (if (exact-integer? $obj) py-int-class ,special-case-float)
            ,special-case-float)))
    `(let (($obj ,obj))
       ,special-case-int)))

(define-macro (py-obj-mro obj) ;; get MRO of object's class
  (cond-expand
    (gambit ;; TODO: prettify... equivalent to (PyObjectType-mro ...)
     `(|##unchecked-structure-ref| (py-obj-cls ,obj) 5 #f #f))
    (bigloo
     `(PyObjectType-mro (py-obj-cls ,obj)))))

;; Specialized type tests for int

(define-macro (py-has-type-int? obj)
  `(py-if-specialized-int-representation
    (exact-integer? ,obj)
    (eq? (py-type ,obj) py-int-class)))

(define-macro (py-subtype-of-int? obj)
  `(let (($obj ,obj))
     (or (py-if-specialized-int-representation
          (exact-integer? $obj)
          (eq? (vector-ref (py-obj-mro $obj) 0) py-int-class)) ;; common case
         (py-isinstance? $obj py-int-class))))

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
               `(py-int-from-scheme-dynamic ,value))))
      `(py-int-from-scheme-dynamic ,value)))

(define-macro (py-int-to-scheme obj)
  `(py-if-specialized-int-representation
    ,obj
    (PyObjectInt-value ,obj)))

(define-macro (py-subtype-of-int-to-scheme obj)
  `(py-if-specialized-int-representation
    (let (($obj ,obj))
      (if (exact-integer? $obj)
          $obj
          (PyObjectInt-value $obj)))
    (PyObjectInt-value ,obj)))

;; Specialized type tests for float

(define-macro (py-has-type-float? obj)
  `(eq? (py-type ,obj) py-float-class))

(define-macro (py-subtype-of-float? obj)
  `(let (($obj ,obj))
     (or (eq? (vector-ref (py-obj-mro $obj) 0) py-float-class) ;; common case
         (py-isinstance? $obj py-float-class))))

(define-macro (py-float-from-scheme value)
  `(py-float-from-scheme-dynamic ,value))

(define-macro (py-float-to-scheme obj)
  `(py-if-specialized-float-representation
    ,obj
    (PyObjectFloat-value ,obj)))

(define-macro (py-subtype-of-float-to-scheme obj)
  `(py-if-specialized-float-representation
    (let (($obj ,obj))
      (if (flonum? $obj)
          $obj
          (PyObjectFloat-value $obj)))
    (PyObjectFloat-value ,obj)))
