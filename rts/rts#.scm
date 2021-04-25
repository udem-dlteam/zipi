;*=====================================================================*/
;*    serrano/prgm/project/zipi/rts/rts#.scm                        */
;*    -------------------------------------------------------------    */
;*    Author      :  Marc Feeley & Manuel Serrano                      */
;*    Creation    :  Tue Jun  4 14:49:14 2019                          */
;*    Last change :  Sat May 23 06:58:13 2020 (serrano)                */
;*    Copyright   :  2019-20 M. Feeley & M. Serrano                    */
;*    -------------------------------------------------------------    */
;*    Object representation                                            */
;*=====================================================================*/

;; =============================================================================
;;  Objects interning
;; =============================================================================

(define-macro (start-registering-constants #!key (constants-must-be-representatives #f))
  (eval
    `(begin

       (define-type Constants
         id: %constants
         constructor: %make-Constants
         prefix: %
         table
         vector)

       ;; IMPORTANT: this definition must be kept in sync with PyObjectStr
       (define-type StaticPyObjectStr
         ;; NOTE: id must be the same as PyObjectStr
         id: PyObjectStr-C6486EB6-1522-42BA-A082-B6563F943CDF
         extender: define-type-of-StaticPyObjectStr
         constructor: %make-StaticPyObjectStr
         prefix: %
         hclass
         elements
         class
         len
         part1-or-string
         part2-or-rep)

       ;; IMPORTANT: this definition must be kept in sync with PyObjectStrRep
       (define-type-of-StaticPyObjectStr StaticPyObjectStrRep
         ;; NOTE: id must be the same as PyObjectStrRep
         id: PyObjectStrRep-C6486EB6-1522-42BA-A082-B6563F943CDF
         constructor: %make-StaticPyObjectStrRep
         prefix: %
         hash
         index)

       (define (make-StaticPyObjectStr string)
         (import (zipi rts hash))
         (let ((static-str
                (%make-StaticPyObjectStr
                 #f
                 '#()
                 #f
                 (string-length string)
                 string
                 #f)))
           static-str))

       (define (make-StaticPyObjectStrRep string)
         (import (zipi rts hash))
         (let ((static-str
                (%make-StaticPyObjectStrRep
                 #f
                 '#()
                 #f
                 (string-length string)
                 string
                 #f ;; will be set to the created str
                 (hash-FNV1a string)
                 #f))) ;; index
           (%StaticPyObjectStr-part2-or-rep-set! static-str static-str)
           static-str))

       (define (constant-string e)
         (if (string? e)
             (or (constants-ref %constants e)
                 (let ((obj
                        ,(if constants-must-be-representatives
                             `(make-StaticPyObjectStrRep e)
                             `(make-StaticPyObjectStr e))))
                   (constants-set! %constants e obj)
                   obj))
             (error "constant-string" "requires string literal but got" e)))

       (define %constants (%make-Constants (make-table) #f))

       (define (constants-table)
         (%Constants-table %constants))

       (define (constants-ref c key)
         (table-ref (%Constants-table c) key #f))

       (define (constants-set! c key val)
         (table-set! (%Constants-table c) key val))

       (define (vectorify-constant-table)
         (%Constants-vector-set!
          %constants
          (list->vector (map cdr (table->list (constants-table))))))

       (define (listify-constant-table)
         (%Constants-table-set!
          %constants
          (table->list (constants-table))))))
  `(##begin))

(define-macro (init-registered-constants)
  `(init-constants ',%constants))

(define-macro (get-registered-constants-table)
  `(list->table (##unchecked-structure-ref ',%constants 1 #f #f) test: string=? weak-values: #t))

(define-macro (end-registering-constants)
  (vectorify-constant-table)
  (listify-constant-table))

(define-macro (& e)
  `',(constant-string e))

(define-macro (&& e)
  `(& ,e))

(start-registering-constants constants-must-be-representatives: #t)

;; =============================================================================
;;  PyObject
;; =============================================================================

(define-type PyObject
  id: PyObject-C6486EB6-1522-42BA-A082-B6563F943CDF
  extender: define-type-of-PyObject
  type-exhibitor: PyObject-type-get
  copier: #f
  macros: ;; this will inline the operations on this type

  ;; attrs
  (hclass unprintable:)
  (%elements unprintable:)
  (class unprintable:))

(define-macro (PyObject-elements-ref obj offset)
  `(vector-ref (PyObject-%elements ,obj) ,offset))

(define-macro (PyObject-elements-set! obj offset val)
  `(let* (($obj ,obj)
          ($offset ,offset)
          ($val ,val)
          ($elements (PyObject-%elements $obj))
          ($elements-len (vector-length $elements)))
     (if (fx>= $offset $elements-len)
         (let (($elements-new (make-vector (max 1 (fx* 2 $offset)) py-absent)))
           (subvector-move! $elements 0 $elements-len $elements-new 0)
           (vector-set! $elements-new $offset $val)
           (PyObject-%elements-set! $obj $elements-new))
         (vector-set! $elements $offset $val))))

(define-type-of-PyObject PyObjectType
  id: PyObjectType-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  macros: ;; this will inline the operations on this type
  ;; attrs
  class-index
  (bases unprintable:)
  (mro unprintable:)
  (hclass-of-instances unprintable:)
  (is-builtin unprintable:)
  (magic-attrs unprintable:))

(define-type-of-PyObject PyObjectModule
  id: PyObjectModule-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  macros: ;; this will inline the operations on this type
  )

(define-type-of-PyObject PyObjectInt
  id: PyObjectInt-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  macros: ;; this will inline the operations on this type
  ;; attrs
  value)

(define-type-of-PyObject PyObjectFloat
  id: PyObjectFloat-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  macros: ;; this will inline the operations on this type
  ;; attrs
  value)

(define-type-of-PyObject PyObjectComplex
  id: PyObjectComplex-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  macros: ;; this will inline the operations on this type
  ;; attrs
  value)

(define-type-of-PyObject PyObjectList
  id: PyObjectList-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  macros: ;; this will inline the operations on this type
  ;; attrs
  value)

(define-type-of-PyObject PyObjectListIterator
  id: PyObjectListIterator-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  macros: ;; this will inline the operations on this type
  ;; attrs
  index
  list)

(define-type-of-PyObject PyObjectBytearray
  id: PyObjectBytearray-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  macros: ;; this will inline the operations on this type
  ;; attrs
  value)

(define-type-of-PyObject PyObjectBytearrayIterator
  id: PyObjectBytearrayIterator-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  macros: ;; this will inline the operations on this type
  ;; attrs
  index
  bytearray)

;; IMPORTANT: this definition must be kept in sync with StaticPyObjectStr
(define-type-of-PyObject PyObjectStr
  id: PyObjectStr-C6486EB6-1522-42BA-A082-B6563F943CDF
  extender: define-type-of-PyObjectStr
  type-exhibitor: PyObjectStr-type-get
  copier: #f
  macros: ;; this will inline the operations on this type
  ;; attrs
  len
  part1-or-string
  part2-or-rep)

;; IMPORTANT: this definition must be kept in sync with StaticPyObjectStrRep
(define-type-of-PyObjectStr PyObjectStrRep
  id: PyObjectStrRep-C6486EB6-1522-42BA-A082-B6563F943CDF
  type-exhibitor: PyObjectStrRep-type-get
  copier: #f
  macros: ;; this will inline the operations on this type
  ;; attrs
  hash
  magic-index)

(define-type-of-PyObject PyObjectFunction
  id: PyObjectFunction-C6486EB6-1522-42BA-A082-B6563F943CDF
  extender: define-type-of-PyObjectFunction
  copier: #f
  macros: ;; this will inline the operations on this type
  ;; attrs
  procedure
  arity
  signature)

(define-type-of-PyObjectFunction PyObjectFunctionArity0
  id: PyObjectFunctionArity0-C6486EB6-1522-42BA-A082-B6563F943CDF
  macros:)
(define-type-of-PyObjectFunction PyObjectFunctionArity1
  id: PyObjectFunctionArity1-C6486EB6-1522-42BA-A082-B6563F943CDF
  macros:)
(define-type-of-PyObjectFunction PyObjectFunctionArity2
  id: PyObjectFunctionArity2-C6486EB6-1522-42BA-A082-B6563F943CDF
  macros:)
(define-type-of-PyObjectFunction PyObjectFunctionArity3
  id: PyObjectFunctionArity3-C6486EB6-1522-42BA-A082-B6563F943CDF
  macros:)
(define-type-of-PyObjectFunction PyObjectFunctionArity4
  id: PyObjectFunctionArity4-C6486EB6-1522-42BA-A082-B6563F943CDF
  macros:)
(define-type-of-PyObjectFunction PyObjectFunctionArity5
  id: PyObjectFunctionArity5-C6486EB6-1522-42BA-A082-B6563F943CDF
  macros:)
(define-type-of-PyObjectFunction PyObjectFunctionArity6
  id: PyObjectFunctionArity6-C6486EB6-1522-42BA-A082-B6563F943CDF
  macros:)
(define-type-of-PyObjectFunction PyObjectFunctionArity7
  id: PyObjectFunctionArity7-C6486EB6-1522-42BA-A082-B6563F943CDF
  macros:)
(define-type-of-PyObjectFunction PyObjectFunctionArity8
  id: PyObjectFunctionArity8-C6486EB6-1522-42BA-A082-B6563F943CDF
  macros:)
(define-type-of-PyObjectFunction PyObjectFunctionArity9
  id: PyObjectFunctionArity9-C6486EB6-1522-42BA-A082-B6563F943CDF
  macros:)
(define-type-of-PyObjectFunction PyObjectFunctionArity10
  id: PyObjectFunctionArity10-C6486EB6-1522-42BA-A082-B6563F943CDF
  macros:)

(define-type-of-PyObject PyObjectMethod
  id: PyObjectMethod-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  macros: ;; this will inline the operations on this type
  ;; attrs
  self
  method)

(define-type-of-PyObject PyObjectMethodWrapper
  id: PyObjectMethodWrapper-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  macros: ;; this will inline the operations on this type
  ;; attrs
  method)

(define-type-of-PyObject PyObjectDict
  id: PyObjectDict-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  macros: ;; this will inline the operations on this type
  ;; attrs
  value)

(define-type-of-PyObject PyObjectSet
  id: PyObjectSet-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  macros: ;; this will inline the operations on this type
  ;; attrs
  value)

(define-type-of-PyObject PyObjectTuple
  id: PyObjectTuple-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  macros: ;; this will inline the operations on this type
  ;; attrs
  value)

(define-type-of-PyObject PyObjectTupleIterator
  id: PyObjectTupleIterator-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  macros: ;; this will inline the operations on this type
  ;; attrs
  index
  vec)

(define-type-of-PyObject PyObjectDictKeyIterator
  id: PyObjectDictKeyIterator-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  macros: ;; this will inline the operations on this type
  ;; attrs
  node
  iterator-token)

(define-type-of-PyObject PyObjectSlice
  id: PyObjectSlice-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  macros: ;; this will inline the operations on this type
  ;; attrs
  start
  stop
  step)

(define-type-of-PyObject PyObjectRange
  id: PyObjectRange-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  ;; macros: ;; this will inline the operations on this type
  ;; attrs
  start
  stop
  step)

(define-type-of-PyObject PyObjectRangeIterator
  id: PyObjectRangeIterator-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  ;; macros: ;; this will inline the operations on this type
  ;; attrs
  start
  stop
  step)

(define-type-of-PyObject PyObjectTextIOWrapper
  id: PyObjectTextIOWrapper-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  macros: ;; this will inline the operations on this type
  ;; attrs
  port
  mode
  encoding)

;; =============================================================================
;;  Caches
;; =============================================================================

(define-type PCache
  id: PCache-A1E4C683-1891-4179-81F6-797D0A717E37
  copier: #f
  macros: ;; this will inline the operations on this type
  hclass
  index)


(define-macro (make-init-PCache)
  `(make-PCache #f -1))

(define-macro (PCache-set! pc hc i)
  `(let (($pc ,pc))
     (PCache-hclass-set! $pc ,hc)
     (PCache-index-set! $pc ,i)))

(define-type AttributeCache
 id: AttributeCache-A1E4C683-1891-4179-81F6-797D0A717E37
 copier: #f
 macros:
 ;; hclass for caching attr found on object
 object-hclass
 ;; hclass for caching attr found on object's mro
 mro-hclass
 ;; hclass for caching attr found on module
 module-hclass
 ;; hclass for caching attr found on type
 type-hclass
 ;; index of an attribute found on the instance itself
 index
 ;; slots for caching attr found on the mro of the object's class
 ;; the attribute cached
 attr
 ;; the owner
 owner
 ;; how to bind the object ('self or 'none)
 bind)

(define-macro (AttributeCache-set! cache object-hclass mro-hclass module-hclass type-hclass index attr owner bind)
  `(let (($c ,cache))
     (AttributeCache-object-hclass-set! $c ,object-hclass)
     (AttributeCache-mro-hclass-set! $c ,mro-hclass)
     (AttributeCache-module-hclass-set! $c ,module-hclass)
     (AttributeCache-type-hclass-set! $c ,type-hclass)
     (AttributeCache-index-set! $c ,index)
     (AttributeCache-attr-set! $c ,attr)
     (AttributeCache-owner-set! $c ,owner)
     (AttributeCache-bind-set! $c ,bind)))

(define-macro (make-init-AttributeCache)
  `(make-AttributeCache #f #f #f #f -1 #f #f #f))

(define-macro (AttributeCache-reset! cache)
  `(AttributeCache-set! ,cache #f #f #f #f -1 #f #f #f))

(define-macro (AttributeCache-object-hit! cache object-hclass index)
  `(AttributeCache-set! ,cache ,object-hclass #f #f #f ,index #f #f #f))

(define-macro (AttributeCache-module-hit! cache module-hclass index)
  `(AttributeCache-set! ,cache #f #f ,module-hclass #f ,index #f #f #f))

(define-macro (AttributeCache-type-hit! cache type-hclass attr owner)
  `(AttributeCache-set! ,cache #f #f #f ,type-hclass -1 ,attr ,owner (quote 'none)))

(define-macro (AttributeCache-mro-hit! cache mro-hclass attr owner)
  `(AttributeCache-set! ,cache #f ,mro-hclass #f #f -1 ,attr ,owner #f))

;; this happens when the attribute is present in the object hclass
;; but is py-absent and ends up being found in the mro
(define-macro (AttributeCache-object-or-mro-hit! cache object-hclass index attr owner)
  `(let (($object-hclass ,object-hclass))
    (AttributeCache-set! ,cache $object-hclass $object-hclass #f #f ,index ,attr ,owner #f)))

;; NOTE: there is no AttributeCache-module-mro-hit! macro since this case is identical to AttributeCache-object-mro-hit!

(define-macro (AttributeCache-module-or-mro-hit! cache module-hclass index attr owner)
  `(let (($module-hclass ,module-hclass))
    (AttributeCache-set! ,cache #f $module-hclass $module-hclass #f ,index ,attr ,owner #f)))

(define-macro (AttributeCache-type-mro-hit! cache type-hclass attr owner)
  `(AttributeCache-set! ,cache #f #f #f ,type-hclass -1 ,attr ,owner (quote 'self)))

;; NOTE: there is no AttributeCache-type-or-mro-hit! macro since it would complexify the cache structure
;; while being a case which practically never happens [citation needed]

;; =============================================================================
;;  HClass
;; =============================================================================

(define-type HClass
  id: C253A20A-30F8-4148-941E-C8BED47E9E79
  constructor: make-HClass
  predicate: HClass?
  implementer: implement-HClass
  copier: #f
  opaque:
  macros: ;; this will inline the operations on this type
  ;; attrs
  names
  (transitions unprintable:))

;; =============================================================================
;;  Calls
;; =============================================================================

(define-macro (make-signature . rest)
  (define (constantify sym)
    `,(constant-string (symbol->string sym)))

  (define (constantify* lst)
    `#(,@(map constantify lst)))

  (define (get-keyword-or-default kw default)
    (let ((tail (memq kw rest)))
      (if tail
        (cadr tail)
        default)))

   (define (kwote val)
      (if (vector? val) `',val val))

  ;; Check the arguments of make-signature are valid keywords followed by values
  (let ((known-keywords
         '(args: posonlyargs: vararg: kwonlyargs: kw-defaults: kwarg: defaults:)))
    (let loop ((lst rest))
      (cond
        ((null? lst)
          #t)
        ((not (keyword? (car lst)))
          (error "make-signature invalid syntax" (car lst)))
        ((or (null? (cdr lst)) (keyword? (cdr lst)))
          (error "make-signature invalid syntax after" (car lst)))
        ((not (memq (car lst) known-keywords))
          (error "make-signature invalid keyword" (car lst)))
        (else
          (loop (cddr lst))))))

  (let ((args (get-keyword-or-default args: '()))
        (posonlyargs (get-keyword-or-default posonlyargs: '()))
        (vararg (get-keyword-or-default vararg: #f))
        (kwonlyargs (get-keyword-or-default kwonlyargs: '()))
        (kw-defaults (get-keyword-or-default kw-defaults: #f))
        (kwarg (get-keyword-or-default kwarg: #f))
        (defaults (get-keyword-or-default defaults: #f)))
    (if (or kw-defaults defaults)
      `(vector
	  ,(kwote (constantify* args))
	  ,(kwote (constantify* posonlyargs))
	  ,(and vararg `',(constantify vararg))
	  ,(kwote (constantify* kwonlyargs))
	  ,(or kw-defaults (kwote '#()))
	  ,(and kwarg `',(constantify kwarg))
	  ,(or defaults (kwote '#())))
      ;; signature with no default can be optimized to a constant
      `'#(,(constantify* args)
          ,(constantify* posonlyargs)
          ,(and vararg (constantify vararg))
          ,(constantify* kwonlyargs)
          #()
          ,(and kwarg (constantify kwarg))
          #()))))

(define-macro (register-constants-perfect-hashtable table)
  (vector-map
    (lambda (e) (if (string? e) (constant-string e) e))
    table))

(define-macro (py-call f . args)
  (define (make-kwargs-loc-table names)
    (import (zipi rts hash))
    (let* ((names-length (length names))
           (max-table-length (* names-length 3))
           (perfect-table-length
             (let loop ((size names-length))
                (cond
                  ((> size max-table-length)
                    #f)
                  ;; the following condition check that there is no collision
                  ;; in a table of length 'size'
                  ((= names-length
                      (table-length
                        (list->table
                          (map
                            (lambda (n) (cons (fast-range-hash (hash-FNV1a n) size) #t))
                            names))))
                    size)
                  (else
                    (loop (+ size 1)))))))
      (if perfect-table-length
        ;; i: index at which element will be found. The table itself is an
        ;; index table which will be at index 0, which is why i starts at 1
        (let loop ((names names) (i 1) (table (make-vector (* 2 perfect-table-length) #f)))
          (if (null? names)
            table
            (let* ((name (car names))
                   (hash (hash-FNV1a name))
                   (name-index (* 2 (fast-range-hash hash perfect-table-length))))
              (vector-set! table name-index name)
              (vector-set! table (+ name-index 1) i)
              (loop (cdr names) (+ i 1) table))))
        #f)))

  (let* ((split-args
          (let loop ((args args) (acc '()))
            (if (or (null? args) (keyword? (car args)))
              (cons (reverse acc) args)
              (loop (cdr args) (cons (car args) acc)))))
        (pos-args (car split-args))
        (split-special-args
          ;; result: #(kwargs *args **kwargs)
          (let loop ((args (cdr split-args)) (acc (vector '() '() '())))
            (cond
              ((null? args)
                (vector-map reverse acc))
              ((eq? (car args) *:)
                (begin
                  (vector-set! acc 1 (cons (cadr args) (vector-ref acc 1)))
                  (loop (cddr args) acc)))
              ((eq? (car args) **:)
                (begin
                  (vector-set! acc 2 (cons (cadr args) (vector-ref acc 2)))
                  (loop (cddr args) acc)))
              (else
                (begin
                  (vector-set! acc 0 (cons (cons (car args) (cadr args)) (vector-ref acc 0)))
                  (loop (cddr args) acc))))))
        (kwargs (vector-ref split-special-args 0))
        (kwargs-names (map (lambda (e) (keyword->string (car e))) kwargs))
        (kwargs-values (map cdr kwargs))
        (*args (vector-ref split-special-args 1))
        (**kwargs (vector-ref split-special-args 2))
        (kwargs-table
          (if (and (null? **kwargs) (not (null? kwargs)))
            (make-kwargs-loc-table kwargs-names)
            #f))
        ;; extra-kwargs are kwargs which could not be hashed in a perfect hashtable
        ;; at compile time, they are treated as provided in a **kwargs at run-time
        (extra-kwargs
          (if (and (not kwargs-table) (not (null? kwargs)))
            `(list
              ,@(map
                  (lambda (name value)
                    `(cons (& ,name) ,value))
                  kwargs-names
                  kwargs-values))
            #f)))

    (cond
      (kwargs-table
        `(py-call-hashed-kwargs
            ,f
            (list ,@pos-args)
            (list ,@*args)
            (vector
              (register-constants-perfect-hashtable ,kwargs-table)
              ,@(map
                  (lambda (key value) `(cons (& ,key) ,value))
                  kwargs-names
                  kwargs-values))))
      ((or extra-kwargs (not (null? **kwargs)))
        `(py-call-generic-kwargs
          ,f
          (list ,@pos-args)
          (list ,@*args)
          ,(or extra-kwargs `'())
          (list ,@**kwargs)))
      (else
        (let ((nargs (length pos-args)))
          (cond
            ((not (null? *args))
              `(py-call-generic/*args ,f (list ,@pos-args) (list ,@*args)))
            (else
              `(py-callX ,nargs ,f ,@pos-args))))))))

(define (string-split string split)
  (call-with-input-string string (lambda (port) (read-all port (lambda (p) (read-line p split))))))

(define (native-builtin-__import__ name)
   #f)

;;(define-macro (py-pos x)        `(py-expression (py-pos ,x)))
;;(define-macro (py-neg x)        `(py-expression (py-neg ,x)))
;;(define-macro (py-invert x)     `(py-expression (py-invert ,x)))

;;(define-macro (py-add x y)      `(py-expression (py-add ,x ,y)))
;;(define-macro (py-sub x y)      `(py-expression (py-sub ,x ,y)))
;;(define-macro (py-mul x y)      `(py-expression (py-mul ,x ,y)))
;;(define-macro (py-floordiv x y) `(py-expression (py-floordiv ,x ,y)))
;;(define-macro (py-mod x y)      `(py-expression (py-mod ,x ,y)))

;;(define-macro (py-gt x y)       `(py-expression (py-gt ,x ,y)))
;;(define-macro (py-lt x y)       `(py-expression (py-lt ,x ,y)))

#;
(define-macro (py-expression expr)

  (define (is-int-literal? expr)
    (and (pair? expr)
         (eq? (car expr) 'py-int-from-scheme)))

  (define (int-literal-value expr) (cadr expr))

  (define (is-unary-op? expr)
    (and (pair? expr)
         (member (car expr) '(py-pos py-neg py-invert))))

  (define (unary-op-operator expr) (car expr))
  (define (unary-op-operand expr) (cadr expr))

  (define (is-binary-op? expr)
    (and (pair? expr)
         (member (car expr) '(py-add py-sub py-mul py-floordiv py-mod
                              py-lt py-gt))))

  (define (binary-op-operator expr) (car expr))
  (define (binary-op-operand1 expr) (cadr expr))
  (define (binary-op-operand2 expr) (caddr expr))

  (define (reduce expr)

    (cond ((is-unary-op? expr)
           (let* ((operator (unary-op-operator expr))
                  (x (reduce (unary-op-operand expr))))
             (if (is-int-literal? x)
                 (list 'py-int-from-scheme-fallback
                       (case operator
                         ((py-pos)
                          (int-literal-value x))
                         ((py-neg)
                          (- (int-literal-value x)))
                         ((py-invert)
                          (bitwise-not (int-literal-value x)))))
                 (list operator x))))

          ((is-binary-op? expr)
           (let* ((operator (binary-op-operator expr))
                  (x (reduce (binary-op-operand1 expr)))
                  (y (reduce (binary-op-operand2 expr))))
             (if (and (is-int-literal? x)
                      (is-int-literal? y)
                      (not (member operator '(py-lt py-gt)))
                      (not (and (member operator '(py-floordiv py-mod))
                                (= 0 (int-literal-value y)))))
                 (list 'py-int-from-scheme-fallback
                       (case operator
                         ((py-add)
                          (+ (int-literal-value x)
                             (int-literal-value y)))
                         ((py-sub)
                          (- (int-literal-value x)
                             (int-literal-value y)))
                         ((py-mul)
                          (* (int-literal-value x)
                             (int-literal-value y)))
                         ((py-floordiv)
                          (quotient (int-literal-value x)
                                    (int-literal-value y)))
                         ((py-mod)
                          (modulo (int-literal-value x)
                                  (int-literal-value y)))))
                 (list operator x y))))

          (else
           expr)))

  (define (is-int? operand)
    `(let ()
       (declare (standard-bindings) (extended-bindings) (not safe))
       (eq? (##type-id (##structure-type ,operand))
            '##type-4-PyObjectInt-C6486EB6-1522-42BA-A082-B6563F943CDF)))

  (define (get-value operand)
    `(let ()
       (declare (standard-bindings) (extended-bindings) (not safe))
       (##unchecked-structure-ref ,operand 4 #f #f))
    #;
    `(PyObjectInt-value ,operand))

  (let ((e (reduce expr)))

    (cond ((is-int-literal? e)
           (let ((value (int-literal-value e)))
             (define int-cache-low -5) ;; must be same as in rts.scm
             (define int-cache-high 256)
             (if (and (<= value int-cache-high)
                      (>= value int-cache-low))
                 `(let ()
                    (declare (standard-bindings) (not safe))
                    (vector-ref int-cache ,(- value int-cache-low)))
                 `(py-int-from-scheme-fallback ,value))))

          ((is-unary-op? e)
           (let* ((operator (unary-op-operator e))
                  (x (unary-op-operand e)))
             (let ((op (assoc operator
                              '((py-pos py-pos:normal +)
                                (py-neg py-neg:normal -)
                                (py-invert py-invert:normal bitwise-not)))))
               `(let (($operand ,x))
                  (declare (standard-bindings) (extended-bindings) (not safe))
                  (if ,(is-int? '$operand)
                      (py-int-from-scheme-fallback
                       ((let () (##namespace ("" ,(caddr op))) ,(caddr op))
                        ,(get-value '$operand))
                       (,(cadr op) $operand)))))))

          ((is-binary-op? e)
           (let* ((operator (binary-op-operator e))
                  (x (binary-op-operand1 e))
                  (y (binary-op-operand2 e)))
             (case operator
               ((py-add py-sub py-mul)
                (let ((op (assoc operator
                                 '((py-add py-add:normal +)
                                   (py-sub py-sub:normal -)
                                   (py-mul py-mul:normal *)))))
                  (cond ((is-int-literal? x)
                         `(let (($operand2 ,y))
                            (declare (standard-bindings) (extended-bindings) (not safe))
                            (if ,(is-int? '$operand2)
                                (py-int-from-scheme-fallback
                                 ((let () (##namespace ("" ,(caddr op))) ,(caddr op))
                                  ,(int-literal-value x)
                                  ,(get-value '$operand2)))
                                (,(cadr op) ,x $operand2))))
                        ((is-int-literal? y)
                         `(let (($operand1 ,x))
                            (declare (standard-bindings) (extended-bindings) (not safe))
                            (if ,(is-int? '$operand1)
                                (py-int-from-scheme-fallback
                                 ((let () (##namespace ("" ,(caddr op))) ,(caddr op))
                                  ,(get-value '$operand1)
                                  ,(int-literal-value y)))
                                (,(cadr op) $operand1 ,y))))
                        (else
                         `(let* (($operand1 ,x)
                                 ($operand2 ,y))
                            (declare (standard-bindings) (extended-bindings) (not safe))
                            (if (and ,(is-int? '$operand1)
                                     ,(is-int? '$operand2))
                                (py-int-from-scheme-fallback
                                 ((let () (##namespace ("" ,(caddr op))) ,(caddr op))
                                  ,(get-value '$operand1)
                                  ,(get-value '$operand2)))
                                (,(cadr op) $operand1 $operand2)))))))
               ((py-lt py-gt)
                (let ((op (assoc operator
                                 '((py-lt py-lt:normal <)
                                   (py-gt py-gt:normal >)))))
                  (cond (else
                         `(let* (($operand1 ,x)
                                 ($operand2 ,y))
                            (declare (standard-bindings) (extended-bindings) (not safe))
                            (if (and ,(is-int? '$operand1)
                                     ,(is-int? '$operand2))
                                (if ((let () (##namespace ("" ,(caddr op))) ,(caddr op))
                                     ,(get-value '$operand1)
                                     ,(get-value '$operand2))
                                    py-True
                                    py-False)
                                (,(cadr op) $operand1 $operand2)))))))
               (else
                (let ((op (assoc operator
                                 '((py-floordiv py-floordiv:normal)
                                   (py-mod      py-mod:normal)))))
                  `(let* (($operand1 ,x)
                          ($operand2 ,y))
                     (declare (standard-bindings) (extended-bindings) (not safe))
                     (,(cadr op) $operand1 $operand2)))))))

          (else
           (error "unexpected expression" e)))))

(define-macro (py-begin-module)
  `(begin
    (declare (standard-bindings) (extended-bindings) (not safe) (block))
    (start-registering-constants)))

(define-macro (py-end-module)
  `(end-registering-constants))

(define-macro (py-init-module)
  `(init-registered-constants))

(import (zipi rts hash))
