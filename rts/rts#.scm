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
      (define-type PyStaticStr
        ;; NOTE: id must be the same as PyObject
        id: %pystaticobject
        constructor: %make-PyStaticStr
        prefix: %
        hclass
        elements
        class
        value
        representative
        hash)
      (define (make-PyStaticStr value)
        (import (zipi rts hash))
        (let ((static-str
                (%make-PyStaticStr
                  #f
                  '#()
                  #f
                  value
                  '%py-absent
                  (hash-FNV1a value))))
          ,(if constants-must-be-representatives
            `(begin
                (%PyStaticStr-representative-set! static-str static-str)
                static-str)
              'static-str)))
      (define (get-PyStaticStr e)
        (if (string? e)
          (let ((cached (constants-ref %constants e)))
            (if cached
              cached
              (let ((obj (make-PyStaticStr e)))
                (constants-set! %constants e obj)
                obj)))
          (error "PyStaticStr" "requires string literal but got" e)))
      (define %constants (%make-Constants (make-table) #f))
      (define (constants-table) (%Constants-table %constants))
      (define (constants-ref c key) (table-ref (%Constants-table c) key #f))
      (define (constants-set! c key val) (table-set! (%Constants-table c) key val))
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
  `',(get-PyStaticStr e))

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
         (let (($elements-new (make-vector (max 1 (fx* 2 $elements-len)) py-absent)))
           (subvector-move! $elements 0 $elements-len $elements-new 0)
           (vector-set! $elements-new $offset $val)
           (PyObject-%elements-set! $obj $elements-new))
         (vector-set! $elements $offset $val))))

(define-type-of-PyObject PyObjectType
    id: PyObjectType-C6486EB6-1522-42BA-A082-B6563F943CDF
    copier: #f
    ;; attrs
    (bases unprintable:)
    (mro unprintable:)
    (hclass-of-instances unprintable:))

(define-type-of-PyObject PyObjectInt
  id: PyObjectInt-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  ;; attrs
  value)

(define-type-of-PyObject PyObjectFloat
  id: PyObjectFloat-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  ;; attrs
  value)

(define-type-of-PyObject PyObjectComplex
  id: PyObjectComplex-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  ;; attrs
  value)

(define-type-of-PyObject PyObjectList
  id: PyObjectList-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  ;; attrs
  value)

(define-type-of-PyObject PyObjectListIterator
  id: PyObjectListIterator-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  ;; attrs
  index
  list)

(define-type-of-PyObject PyObjectBytearray
  id: PyObjectBytearray-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  ;; attrs
  value)

(define-type-of-PyObject PyObjectBytearrayIterator
  id: PyObjectBytearrayIterator-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  ;; attrs
  index
  bytearray)

(define-type-of-PyObject PyObjectStr
  id: PyObjectStr-C6486EB6-1522-42BA-A082-B6563F943CDF
  type-exhibitor: PyObjectStr-type-get
  copier: #f
  ;; attrs
  value
  (representative unprintable:)
  hash)

(define-type-of-PyObject PyObjectFunction
  id: PyObjectFunction-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  ;; attrs
  procedure
  arity
  signature)

(define-type-of-PyObject PyObjectMethod
  id: PyObjectMethod-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  ;; attrs
  procedure
  arity
  signature)

(define-type-of-PyObject PyObjectDict
  id: PyObjectDict-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  ;; attrs
  value)

(define-type-of-PyObject PyObjectSet
  id: PyObjectSet-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  ;; attrs
  value)

(define-type-of-PyObject PyObjectTuple
  id: PyObjectTuple-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  ;; attrs
  value)

(define-type-of-PyObject PyObjectTupleIterator
  id: PyObjectTupleIterator-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  ;; attrs
  index
  vec)

(define-type-of-PyObject PyObjectDictKeyIterator
  id: PyObjectDictKeyIterator-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  ;; attrs
  node
  iterator-token)

(define-type-of-PyObject PyObjectSlice
  id: PyObjectSlice-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  ;; attrs
  start
  stop
  step)

(define-type-of-PyObject PyObjectTextIOWrapper
  id: PyObjectTextIOWrapper-C6486EB6-1522-42BA-A082-B6563F943CDF
  copier: #f
  ;; attrs
  port
  mode
  encoding)

;; =============================================================================
;;  PCache
;; =============================================================================

(define-type PCache
  id: A1E4C683-1891-4179-81F6-797D0A717E37
  constructor: %make-PCache
  predicate: PCache?
  implementer: implement-PCache
  copier: #f
  opaque:
  prefix: %
  macros: hclass index)

(define-macro (make-PCache hc i)
  `(%make-PCache ,hc ,i))

(define-macro (PCache-hclass pc)
  `(%PCache-hclass ,pc))

(define-macro (PCache-index pc)
  `(%PCache-index ,pc))

(define-macro (PCache-set! pc hc i)
  `(let (($pc ,pc))
     (%PCache-hclass-set! $pc ,hc)
     (%PCache-index-set! $pc ,i)))

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
  macros:
  ;; attrs
  names
  (transitions unprintable:))

;; =============================================================================
;;  Calls
;; =============================================================================

(define-macro (make-signature . rest)
  (define (constantify sym)
    `,(get-PyStaticStr (symbol->string sym)))

  (define (constantify* lst)
    `#(,@(map constantify lst)))

  (define (get-keyword-or-default kw default)
    (let ((tail (memq kw rest)))
      (if tail
        (cadr tail)
        default)))

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
          ,(constantify* args)
          ,(constantify* posonlyargs)
          ,(and vararg `',(constantify vararg))
          ,(constantify* kwonlyargs)
          ,(or kw-defaults #())
          ,(and kwarg `',(constantify kwarg))
          ,(or defaults #()))
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
    (lambda (e) (if (string? e) (get-PyStaticStr e) e))
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

  (define (make-py-call-name n)
    (string->symbol
      (string-append
        "py-call"
        (number->string n))))

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
          (import (zipi rts config))
          (cond
            ((not (null? *args))
              `(py-call-generic/*args ,f (list ,@pos-args) (list ,@*args)))
            ((<= nargs py-callX-args-limit)
              `(,(make-py-call-name nargs) ,f ,@pos-args))
            (else
              `(py-call-generic ,f (list ,@pos-args)))))))))

(define (string-split string split)
  (call-with-input-string string (lambda (port) (read-all port (lambda (p) (read-line p split))))))

(import (zipi rts hash))
