;; =============================================================================
;;  Common macros
;; =============================================================================
(cond-expand
  (gambit
   (define-macro (declare-standard-bindings-extended-bindings-not-safe)
     `(declare (standard-bindings) (extended-bindings) (not safe)))
   (define-macro (declare-fixnum)
     `(declare (fixnum)))
   (define-macro (declare-not-interrupts-enabled)
     `(declare (not interrupts-enabled))))

  (bigloo
   (define-macro (declare-standard-bindings-extended-bindings-not-safe)
     `(begin))
   (define-macro (declare-fixnum)
     `(begin
        (define (+ x y) (+fx x y))
        (define (- x y) (-fx x y))
        (define (* x y) (*fx x y))
        (define (/ x y) (/fx x y))
        (define (<= x y) (<=fx x y))
        (define (< x y) (<fx x y))
        (define (>= x y) (>=fx x y))
        (define (> x y) (>fx x y))
        (define (= x y) (=fx x y))))
   (define-macro (declare-not-interrupts-enabled)
     `(begin))))

(declare-standard-bindings-extended-bindings-not-safe)

;; General exception thrower helper
(define-rts (py-throw-exception-with-message exc . msgs)
  (py-throw
   (py-call
    exc
    (py-str-from-scheme (append-strings msgs)))))

(define-macro (make-builtin-HClass names transitions)
  `(make-still-copy (make-HClass ,names ,transitions)))

(define-macro (HClass-last-index hclass)
  `(fx- (vector-length (HClass-names ,hclass)) 1))

(define-macro (HClass-transition-add! hc transitions target)
  `(let (($hc ,hc))
    (HClass-transitions-set!
     $hc
     (cons (cons ,transitions ,target) (HClass-transitions $hc)))))

(define-macro (vector-extend vec el)
  `(let (($vec ,vec) ($el ,el))
     (let* ((len (vector-length $vec))
          (nvec (make-vector (+ len 1))))
        (vector-copy! nvec 0 $vec)
        (vector-set! nvec len $el)
        nvec)))

(define-rts (find-next name op lst)
   (let loop ((lst lst))
      (if (null? lst)
          '()
          (let ((a (car lst)))
             (if (and (eq? name (caar a)) (eq? op (cdar a)))
                 a
                 (loop (cdr lst)))))))

(define-macro (HClass-next hc name op)
  `(let (($hc ,hc) ($name ,name))
    (let ((tran (find-next $name ,op (HClass-transitions $hc))))
       (if (pair? tran)
           (cdr tran)
        (let ((nhclass
                (make-HClass
                  (vector-extend (HClass-names $hc) $name)
                  '())))
          (HClass-transition-add! $hc (cons $name ,op) nhclass)
          nhclass)))))

(define-macro (str-representatives-eq? self other)
  `(eq? (py-str-representative ,self) (py-str-representative ,other)))

;;----------------------------------------------------------------------------

;;; Object attribute store/fetch.

(define-macro (py-getattribute-cached-fallback-body obj-sym hclass-sym name-sym cache-sym
                                                    include-object include-mro include-type include-module)
  `(cond
    ,@(if include-object
      `(((eq? ,hclass-sym (AttributeCache-object-hclass ,cache-sym))
        (py-getattribute-from-object-cache ,obj-sym ,cache-sym)))
      '())
    ,@(if include-mro
      `(((eq? ,hclass-sym (AttributeCache-mro-hclass ,cache-sym))
        (py-getattribute-from-mro-cache ,obj-sym ,cache-sym)))
      '())
    ,@(if include-type
      `(((eq? ,hclass-sym (AttributeCache-type-hclass ,cache-sym))
        (py-getattribute-from-type-cache ,obj-sym ,cache-sym)))
      '())
    ,@(if include-module
      `(((eq? ,hclass-sym (AttributeCache-module-hclass ,cache-sym))
        (py-getattribute-from-module-cache ,obj-sym ,cache-sym)))
      '())
    (else
      (py-getattribute-cached/miss ,obj-sym ,name-sym ,cache-sym))))

(define-rts (py-getattribute-cached-fallback obj hclass name cache)
  (py-getattribute-cached-fallback-body obj hclass name cache #t #t #t #t))

(define-rts (py-getattribute-cached-fallback/no-object obj hclass name cache)
  (py-getattribute-cached-fallback-body obj hclass name cache #f #t #t #t))

(define-rts (py-getattribute-cached-fallback/no-mro obj hclass name cache)
  (py-getattribute-cached-fallback-body obj hclass name cache #t #f #t #t))

(define-rts (py-getattribute-cached-fallback/no-type obj hclass name cache)
  (py-getattribute-cached-fallback-body obj hclass name cache #t #t #f #t))

(define-rts (py-getattribute-cached-fallback/no-module obj hclass name cache)
  (py-getattribute-cached-fallback-body obj hclass name cache #t #t #t #f))

(define-rts (py-getattribute-cached-modular-fallback obj hclass name cache
	       include-object include-mro include-type include-module)
  (cond
    ((and include-object
          (eq? hclass (AttributeCache-object-hclass cache)))
      (py-getattribute-from-object-cache obj cache))
    ((and include-mro
          (eq? hclass (AttributeCache-mro-hclass cache)))
      (py-getattribute-from-mro-cache obj cache))
    ((and include-type
          (eq? hclass (AttributeCache-type-hclass cache)))
      (py-getattribute-from-type-cache obj cache))
    ((and include-module
          (eq? hclass (AttributeCache-module-hclass cache)))
        (py-getattribute-from-module-cache obj cache))
    (else
      (py-getattribute-cached/miss obj name cache))))

(define-rts (py-getattribute-cached/miss obj name cache)
  (define (getattribute-from-getattr attribute-error)
    (getattribute-from-cls-mro-with-owner-2cont
      (py-obj-cls obj)
      (& "__getattr__")
      (lambda (__getattr__ owner)
        ;; caches cannot save you if this happens
        (py-call __getattr__ obj name))
      attribute-error))

  (py-when-enable-cache-debug (pp "cache miss"))

  (let ((__getattribute__ (getattribute-from-obj-mro obj (& "__getattribute__"))))
    (cond
      ((eq? __getattribute__ object.__getattribute__)
        (or
          (object-getattribute obj name #f cache)
          (getattribute-from-getattr
            (lambda () (py-throw-object-getattribute-error obj name)))))
      ((eq? __getattribute__ type.__getattribute__)
        (begin
          (or
            (type-getattribute obj name #f cache)
            (getattribute-from-getattr
              (lambda () (py-throw-type-getattribute-error obj name))))))
      ((eq? __getattribute__ module.__getattribute__)
        (or
          (module-getattribute obj name #f cache)
          (getattribute-from-getattr
            (lambda () (py-throw-module-getattribute-error obj name)))))
      (else
        (py-getattribute-fallback obj name)))))

(define-rts (py-own-attr-index obj attr)
  (py-own-attr-index-2cont
   obj
   attr
   (lambda (i) i)
   (lambda () -1)))

(define-rts (py-own-attr-ref obj attr)
 (py-own-attr-ref-2cont
  obj
  attr
  (lambda (val) val)
  (lambda () py-absent)))

(define-rts (py-own-attr-set! obj attr val)
  ;; TODO: fix case when obj is not represented with a PyObject
  ;; TODO: use py-own-attr-index-2cont
  (declare-fixnum)
  (let* ((attr-representative (py-str-representative attr)))
    (if (and
          (PyObjectType? obj)
          (PyObjectStrRep-magic-index attr-representative))
      ;; set a magic method
      (magic-attr-set!
        obj
        (PyObjectStrRep-magic-index attr-representative)
        val)
      ;; set a normal attribute
      (py-own-attr-index-2cont obj attr
        (lambda (i) (PyObject-elements-set! obj i val))
        (lambda ()
          (let* ((hclass (py-obj-hclass obj))
                 (new-hclass (HClass-next hclass attr-representative '+))
                 (index (HClass-last-index new-hclass)))
            (PyObject-hclass-set! obj new-hclass)
            (PyObject-elements-set! obj index val)))))))

;;----------------------------------------------------------------------------


(define-rts debug-verbosity 0)

(define-rts (possible-error verbosity . msg)
  (if (>= debug-verbosity verbosity)
      (display (string-append "*** WARNING --- " (append-strings msg) "\n")
               (current-error-port))))

(define-rts (fatal-error . msg)
  (display (string-append "*** FATAL ERROR --- " (append-strings msg) "\n")
           (current-error-port))
  (exit 1))

;;==============================================================================
;; compiler intrinsics
;;==============================================================================

(define-macro (call-host signature . args)
  `(py-throw-exception-with-message
    py-builtin-NotImplementedError
    "call_host intrinsic function not implemented"))

;; =============================================================================
;;  py-absent
;; =============================================================================

(define-rts py-absent '%py-absent)

;; =============================================================================
;;  HIDDEN CLASSES
;; =============================================================================

(define-macro (define-hclass-of-instances-preallocations . names)
  `(begin
    ,@(map
      (lambda (name)
        `(define-rts ,name
          (make-builtin-HClass
            '#()
            '())))
      names)))

(define-hclass-of-instances-preallocations
  py-object-hclass-of-instances
  py-str-hclass-of-instances
  py-tuple-hclass-of-instances
  py-int-hclass-of-instances
  py-bool-hclass-of-instances
  py-float-hclass-of-instances
  py-slice-hclass-of-instances
  py-bytearray-hclass-of-instances
  py-method-hclass-of-instances
  py-classmethod-hclass-of-instances
  py-staticmethod-hclass-of-instances
  py-function-hclass-of-instances
  py-generator-hclass-of-instances
  py-list-hclass-of-instances
  py-dict-hclass-of-instances
  py-set-hclass-of-instances
  py-module-hclass-of-instances
  py-list-iterator-hclass-of-instances
  py-bytearray-iterator-hclass-of-instances
  py-tuple-iterator-hclass-of-instances
  py-dict-keyiterator-hclass-of-instances
  py-dict-valueiterator-hclass-of-instances
  py-TextIOWrapper-hclass-of-instances
  py-super-hclass-of-instances
  py-range-hclass-of-instances
  py-range_iterator-hclass-of-instances)

;; object allocation

(define-rts (py-obj-alloc cls)
  (let ((hclass-of-instances (PyObjectType-hclass-of-instances cls)))
    (make-PyObject
      hclass-of-instances
      (make-vector (vector-length (HClass-names hclass-of-instances)) py-absent)
      cls)))

(define-rts (py-module-alloc cls hclass-of-instances)
  (let ((self
         (make-PyObjectModule
          py-module-hclass-of-instances
          (vector-map
            (lambda (_) (make-global-cell #f))
            (make-vector (vector-length (HClass-names hclass-of-instances))))
          cls)))
    self))

;; initialize index for magic methods

;; some attributes are stored at a specific index in PyObjectType for fast lookup in the mro
;; these are typically attributes for magic methods (ex: __add__, __next__, etc.)
;; These indices are stored in the string representative of the attribute
;; Here we loop over the list of such attributes and populate their magic-index field

(define-rts list-of-magic-attrs (get-list-of-magic-attrs))

(define-rts magic-attrs-length (length list-of-magic-attrs))

;; type allocation

(define-rts (py-type-alloc metaclass class-index can-have-getter bases mro hclass-of-instance)
  (make-PyObjectType
    (make-HClass '#() '()) ;; each type has its own hclass for attribute caching purpose
    '#()
    metaclass
    class-index
    bases
    mro
    hclass-of-instance
    #f ;; is-builtin
    can-have-getter
    (make-vector magic-attrs-length #f)))

(define-rts (py-builtin-type-alloc metaclass class-index can-have-getter bases mro hclass-of-instance)
  (let ((cls
          (make-still-copy
            (py-type-alloc metaclass class-index can-have-getter bases mro hclass-of-instance))))
    (PyObjectType-is-builtin-set! cls #t)
    cls))

(define-rts (py-dict-alloc ordered-table)
  (make-PyObjectDict
    py-dict-hclass-of-instances
    '#()
    py-dict-class
    ordered-table))

(define-rts (py-dict-keyiterator-alloc first iterator-token)
  (make-PyObjectDictItemsIterator
    py-dict-keyiterator-hclass-of-instances
    '#()
    py-dict-keyiterator-class
    first
    iterator-token))

(define-rts (py-dict-valueiterator-alloc first iterator-token)
  (make-PyObjectDictItemsIterator
    py-dict-valueiterator-hclass-of-instances
    '#()
    py-dict-valueiterator-class
    first
    iterator-token))

(define-rts (py-list-iterator-alloc index lst)
  (make-PyObjectListIterator
    py-list-iterator-hclass-of-instances
    '#()
    py-list-iterator-class
    index
    lst))

(define-rts (py-tuple-iterator-alloc index vec)
  (make-PyObjectTupleIterator
    py-tuple-iterator-hclass-of-instances
    '#()
    py-tuple-iterator-class
    index
    vec))

(define-rts (py-bytearray-iterator-alloc index bytearray)
  (make-PyObjectBytearrayIterator
    py-bytearray-iterator-hclass-of-instances
    '#()
    py-bytearray-iterator-class
    index
    bytearray))

(define-rts (py-TextIOWrapper-alloc port mode encoding)
  (make-PyObjectTextIOWrapper
    py-TextIOWrapper-hclass-of-instances
    '#()
    py-TextIOWrapper-class
    port
    mode
    encoding))

;; ----------------------------------------------------------------------------
(define-rts (append-lists list-of-lists)
  (let outer-loop ((lists-tail list-of-lists) (outer-acc '()))
    (if (null? lists-tail)
      (reverse! outer-acc)
      (let inner-loop ((head (car lists-tail)) (inner-acc outer-acc))
        (if (null? head)
          (outer-loop (cdr lists-tail) inner-acc)
          (inner-loop (cdr head) (cons (car head) inner-acc)))))))

;; used to set the #(getter setter) in the elements of a module w/o invoking the setter
(define-macro (py-global-elements-direct-set! obj offset val)
  `(let* (($obj ,obj)
          ($offset ,offset)
          ($val ,val)
          ($elements (PyObject-%elements $obj))
          ($elements-len (vector-length $elements)))
     (if (fx>= $offset $elements-len)
         (let* (($new-len (max 1 (fx* 2 $offset)))
                ($diff-len (fx- $new-len $elements-len))
                ($elements-new (make-vector $new-len)))
           ;; copy existing cells
           (subvector-move! $elements 0 $elements-len $elements-new 0)
           ;; create new cells
           (subvector-move!
             ;; vector of cells
             (vector-map!
               (lambda (_)
                  (make-global-cell #f))
               (make-vector $diff-len))
             0
             $diff-len
             $elements-new
             $elements-len)
           ;; set the element
           (vector-set!
             $elements-new
             $offset
             $val)
           (PyObject-%elements-set! $obj $elements-new))
           (vector-set!
             $elements
             $offset
             $val))))

(define-macro (PyObject-global-elements-set! obj offset val)
  `(let* (($obj ,obj)
          ($offset ,offset)
          ($val ,val)
          ($elements (PyObject-%elements $obj))
          ($elements-len (vector-length $elements)))
     (if (fx>= $offset $elements-len)
         (let* (($new-len (max 1 (fx* 2 $offset)))
                ($diff-len (fx- $new-len $elements-len))
                ($elements-new (make-vector $new-len)))
           ;; copy existing cells
           (subvector-move! $elements 0 $elements-len $elements-new 0)
           ;; create new cells
           (subvector-move!
             ;; vector of cells
             (vector-map
               (lambda (_) (make-global-cell #f))
               (make-vector $diff-len))
             0
             $diff-len
             $elements-new
             $elements-len)
           ;; set the element
           (py-global-elements-set! $elements-new $offset $val)
           (PyObject-%elements-set! $obj $elements-new))
         (py-global-elements-set! $elements $offset $val))))

(define-rts (global-get global name cache)
  (if (eq? (PyObject-hclass global) ;; TODO: should py-obj-hclass be used instead?
           (PCache-hclass cache))
      (let ((val (PyObject-global-elements-ref global (PCache-index cache))))
        (or val
            (global-get-from-builtins name cache)))
      (global-get/miss global name cache)))

(define-rts (global-get/miss global name cache)
  (let ((i (py-own-attr-index global name)))
    (if (< i 0)
        ;; as per Python 3.8 (maybe 3.7?) builtins module is no longer recovered
        ;; through __builtins__, this was also documented as an implementation
        ;; detail: https://docs.python.org/3/library/builtins.html
        (global-get-from-builtins name cache)
        (let ((hclass (PyObject-hclass global))) ;; TODO: should py-obj-hclass be used instead?
          (PCache-set! cache hclass i)
          (let ((val (PyObject-global-elements-ref global i)))
            (or val
                (global-get-from-builtins name cache)))))))

(define-rts (global-own-attr-ref-no-cache global name)
  (py-own-attr-index-2cont
    global
    name
    (lambda (i) (PyObject-global-elements-ref global i))
    (lambda () #f)))

;; TODO: use a cache for builtins and one for global access
(define-rts (global-get-from-builtins name cache)
  (define (throw-NameError)
    (py-throw-exception-with-message
     py-builtin-NameError
     "name '" (py-str-to-scheme name) "' is not defined"))
  (let ((builtins-hclass (PyObject-hclass builtins-mod))) ;; TODO: should py-obj-hclass be used instead?
    (if (eq? builtins-hclass (PCache-hclass cache))
        (let ((val (PyObject-global-elements-ref
                      builtins-mod
                      (PCache-index cache))))
          (or val
              (throw-NameError)))
        (let ((i (py-own-attr-index builtins-mod name)))
          (if (< i 0)
              (throw-NameError)
              (let ((val (PyObject-global-elements-ref builtins-mod i)))
                (PCache-set! cache builtins-hclass i)
                (or val
                    (throw-NameError))))))))

(define-rts (global-put! global name val cache)
  (if (eq? (PyObject-hclass global)
           (PCache-hclass cache))
      (PyObject-global-elements-set! global (PCache-index cache) val)
      (global-put!/miss global name val cache)))

(define-rts (global-put!/miss obj name val cache)
  (let* ((index (py-own-attr-index obj name))
         (hclass (PyObject-hclass obj)))
    (if (>= index 0)
        (begin
          (PCache-set! cache hclass index)
          (py-global-elements-set! (PyObject-%elements obj) index val))
        ;; We have to create a cell
        (let* ((name-representative (py-str-representative name))
               (nhclass (HClass-next hclass name-representative '+))
               (index (HClass-last-index nhclass)))
          (PyObject-hclass-set! obj nhclass)
          (PCache-set! cache nhclass index)
          (PyObject-global-elements-set! obj index val)))))

(define-rts (global-own-attr-put-no-cache! global name val)
  (let* ((index (py-own-attr-index global name))
         (hclass (PyObject-hclass global)))
    (if (>= index 0)
        (PyObject-global-elements-set! global index val)
        ;; We have to create a cell
        (let* ((name-representative (py-str-representative name))
               (nhclass (HClass-next hclass name-representative '+))
               (index (HClass-last-index nhclass)))
          (PyObject-hclass-set! global nhclass)
          (PyObject-global-elements-set! global index val)))))

(define-rts (global-register! obj name getter setter)
  (let* ((index (py-own-attr-index obj name))
         (hclass (PyObject-hclass obj)))
    (if (>= index 0)
      (begin
        (py-global-elements-direct-set!
          obj
          index
          (vector getter setter)))
      (let* ((name-representative (py-str-representative name))
             (nhclass (HClass-next hclass name-representative '+))
             (index (HClass-last-index nhclass)))
        (PyObject-hclass-set! obj nhclass)
        (py-global-elements-direct-set!
          obj
          index
          (vector getter setter))))))

;; Boostrap functions
;; Functions are objects of type 'function', but their type cannot be assigned
;; as long as the py-function-class has not been created.
;; Before the creation of py-function-class, we instantiate class-less objects
;; which we keep in the functions-awaiting-bootstap list. Once py-function-class
;; is created, we can recover these functions and add their type.

(define-rts functions-awaiting-bootstap '())

;; signature: '#(args posonlyargs vararg kwonlyargs kw_defaults kwarg defaults)
;; takes in a signature and returns an arity.
;; positive arity: a function takes a fixed number of positional arguments
;; negative arity: functions takes x arguments, last argument is a *args
;; #f arity: unknown arity due to defaults value
(define-rts (signature->arity signature)
   (let ((args (vector-ref signature 0))
	 (posonlyargs (vector-ref signature 1))
	 (vararg (vector-ref signature 2))
	 (kwonlyargs (vector-ref signature 3))
	 (kw-defaults (vector-ref signature 4))
	 (kwarg (vector-ref signature 5))
	 (defaults (vector-ref signature 6)))
      (if (and
	   (eq? (vector-length kwonlyargs) 0)
	   (eq? (vector-length kw-defaults) 0)
	   (not kwarg)
	   (eq? (vector-length defaults) 0))
	  (if vararg
	      (- -1 (vector-length args) (vector-length posonlyargs))
	      (+ (vector-length args) (vector-length posonlyargs)))
	  #f)))

(define-rts (signature->scheme-arity signature)
  (let ((args (vector-ref signature 0))
        (posonlyargs (vector-ref signature 1))
        (vararg (vector-ref signature 2))
        (kwonlyargs (vector-ref signature 3))
        (kw-defaults (vector-ref signature 4))
        (kwarg (vector-ref signature 5))
        (defaults (vector-ref signature 6)))
     (if (and
	  (eq? (vector-length kwonlyargs) 0)
	  (not kwarg)
	  (not vararg))
	 (+ (vector-length args) (vector-length posonlyargs))
	 #f)))

(define-rts (prebootstrap-procedure->py-function procedure signature)
  (let ((py-function
          (py-make-PyObjectFunction
            py-function-hclass-of-instances
            '#()
            #f
            procedure
            (signature->arity signature)
            (signature->scheme-arity signature)
            signature)))
    (set!
      functions-awaiting-bootstap
      (cons py-function functions-awaiting-bootstap))
    py-function))

(define-rts (postbootstrap-procedure->py-function procedure signature)
  (py-make-PyObjectFunction
    py-function-hclass-of-instances
    '#()
    py-function-class
    procedure
    (signature->arity signature)
    (signature->scheme-arity signature)
    signature))

(define-rts procedure->py-function prebootstrap-procedure->py-function)

(define-rts (bootstrap-functions)
  (set! procedure->py-function postbootstrap-procedure->py-function)
  (let loop ((functions functions-awaiting-bootstap))
    (if (not (null? functions))
      (begin
        (PyObject-class-set! (car functions) py-function-class)
        (loop (cdr functions))))))

(define-rts (pack-extra-args arity args)
  (if (= arity -1)
    (cons (py-tuple-from-scheme (list->vector args)) '())
    (cons (car args) (pack-extra-args (+ arity 1) (cdr args)))))

(define-rts (py-call-wrong-arity arity nargs nargs-string)
  (if (fx< arity 0)
    (py-throw-exception-with-message
       py-builtin-TypeError
       (string-append
         "missing "
         (number->string (fx- 0 (fx+ arity (fx+ 1 nargs))))
         " required positional argument"))
    (if (fx< arity nargs)
      (py-throw-exception-with-message
        py-builtin-TypeError
        "function takes "
        (number->string arity)
        (string-append
          " positional arguments but "
          nargs-string
          " were given"))
      (py-throw-exception-with-message
        py-builtin-TypeError
        "missing "
        (number->string (fx- arity nargs))
        " required positional argument"))))

(define-rts (py-call0-fallback fun)
   (let ((fun-type (py-obj-cls fun)))
      (cond
	 ((eq? fun-type py-function-class)
	  (let ((arity (PyObjectFunction-arity fun)))
	     (cond
		((eqv? arity -1)
		 ((PyObjectFunction-procedure fun)
		  (py-tuple-from-scheme '#())))
		((not arity) (py-call0-generic fun))
		(else
		 (py-call-wrong-arity arity 0 "0")))))
	 ((eq? fun-type py-method-class)
	  (let* ((func (PyObjectMethod-method fun))
		 (__self__ (PyObjectMethod-self fun))
		 (arity (PyObjectFunction-scheme-arity func)))
	     (if (eq? arity 1)
		 ((PyObjectFunction-procedure func) __self__)
		 (py-call1-generic func __self__))))
	 (else
	  (py-call0-generic fun)))))

(define-rts (py-call1-fallback min-neg-arity fun a0)
  (let ((fun-type (py-obj-cls fun)))
     (cond
	((eq? fun-type py-function-class)
	 (let ((arity (PyObjectFunction-arity fun)))
	    (cond
	       ((not arity)
		(py-call1-generic fun a0))
	       ((and (fx< arity 0) (fx>= arity min-neg-arity))
		(apply
		   (PyObjectFunction-procedure fun)
		   (pack-extra-args arity (cons a0 '()))))
	       (else
		;; Error messages
		(py-call-wrong-arity arity 1 "1")))))
	((eq? fun-type py-method-class)
	 (let* ((func (PyObjectMethod-method fun))
		(__self__ (PyObjectMethod-self fun))
		(arity (PyObjectFunction-scheme-arity func)))
	    (if (eq? arity 2)
		((PyObjectFunction-procedure func) __self__ a0)
		(py-call2-generic func __self__ a0))))
	(else
	 (py-call1-generic fun a0)))))

(define-rts (py-call2-fallback min-neg-arity fun a0 a1)
  (let ((fun-type (py-obj-cls fun)))
     (cond
	((eq? fun-type py-function-class)
	 (let ((arity (PyObjectFunction-arity fun)))
	    (cond
	       ((not arity)
		(py-call2-generic fun a0 a1))
	       ((and (fx< arity 0) (fx>= arity min-neg-arity))
		(apply
		   (PyObjectFunction-procedure fun)
		   (pack-extra-args arity (cons* a0 a1 '()))))
	       (else
		;; Error messages
		(py-call-wrong-arity arity 2 "2")))))
	((eq? fun-type py-method-class)
	 (let* ((func (PyObjectMethod-method fun))
		(__self__ (PyObjectMethod-self fun))
		(arity (PyObjectFunction-scheme-arity func)))
	    (if (eq? arity 3)
		((PyObjectFunction-procedure func) __self__ a0 a1)
		(py-call3-generic func __self__ a0 a1))))
	(else
	 (py-call2-generic fun a0 a1)))))

(define-rts (py-call3-fallback min-neg-arity fun a0 a1 a2)
  (let ((fun-type (py-obj-cls fun)))
     (cond
	((eq? fun-type py-function-class)
	 (let ((arity (PyObjectFunction-arity fun)))
	    (cond
	       ((not arity)
		(py-call3-generic fun a0 a1 a2))
	       ((and (fx< arity 0) (fx>= arity min-neg-arity))
		(apply
		   (PyObjectFunction-procedure fun)
		   (pack-extra-args arity (cons* a0 a1 a2 '()))))
	       (else
		;; Error messages
		(py-call-wrong-arity arity 3 "3")))))
	((eq? fun-type py-method-class)
	 (let* ((func (PyObjectMethod-method fun))
		(__self__ (PyObjectMethod-self fun))
		(arity (PyObjectFunction-scheme-arity func)))
	    (if (eq? arity 4)
		((PyObjectFunction-procedure func) __self__ a0 a1 a2)
		(py-call4-generic func __self__ a0 a1 a2))))
	(else
	 (py-call3-generic fun a0 a1 a2)))))

(define-rts (py-callX-fallback min-neg-arity fun . args)
  (let ((fun-type (py-obj-cls fun)))
     (if (eq? fun-type py-function-class)
	 (let ((arity (PyObjectFunction-arity fun)))
	    (cond
	       ((not arity)
		(py-call-generic fun args))
	       ((and (fx< arity 0) (fx>= arity min-neg-arity))
		(apply
		   (PyObjectFunction-procedure fun)
		   (pack-extra-args arity args)))
	       (else
		;; Error messages
		(py-call-wrong-arity arity (length args) (number->string (length args))))))
	 (py-call-generic fun args))))

(define-rts (py-call-generic/*args obj args *args-lst)
   (let ((unpacked-args (iterables*->list *args-lst)))
     (py-call-generic obj (append args unpacked-args))))

(define-rts (py-call-generic obj args)
   (let ((obj-type (py-type obj)))
      ;;(tprint "py-call-generic obj=" (typeof obj) " args=" (length args))
    (cond
      ((eq? obj-type py-function-class)
        (let* ((procedure (PyObjectFunction-procedure obj))
               (signature (PyObjectFunction-signature obj))
               (aligned-args (align-args-with-signature args signature)))
          (apply procedure aligned-args)))
      ((eq? obj-type py-method-class)
        (let* ((func (PyObjectMethod-method obj))
               (__self__ (PyObjectMethod-self obj)))
          (py-call-generic func (cons __self__ args))))
      ;; initialization of instances from type with no special metaclass
      ((eq? obj-type py-type-class)
        (let ((__new__ (getattribute-from-cls-mro obj (& "__new__"))))
          (if (eq? __new__ object.__new__)
            (if (eq? obj py-object-class)
              (if (null? args)
                ;; TODO: raise TypeError on unsafe call, ex: object.__new__(int)
                ;; this should be done concurrently in object-new
                (py-obj-alloc py-object-class)
                (py-throw-exception-with-message
                  py-builtin-TypeError
                  "object() takes no arguments"))
              (let ((instance (py-obj-alloc obj)))
                (type-call-from-instance obj instance (cons instance args))))
            (type-call-from-new-method-fallback obj args __new__))))
      (else
        (let ((__call__ (getattribute-from-obj-mro obj (& "__call__"))))
          (if (eq? __call__ py-absent)
            (py-throw-not-callable obj)
            (py-call-generic __call__ (cons obj args))))))))

(define-rts (py-call0-generic obj)
   (py-call-generic obj '()))
;*    (let ((obj-type (py-type obj)))                                  */
;*       (cond                                                         */
;* 	 ((eq? obj-type py-function-class)                             */
;* 	  (let* ((procedure (PyObjectFunction-procedure obj))          */
;* 		 (signature (PyObjectFunction-signature obj))          */
;* 		 (aligned-args (align-args-with-signature '() signature))) */
;* 	     (tprint "py-call0-generic obj=" (typeof obj) " " procedure */
;* 		" " (length aligned-args) " " signature)               */
;* 	     (apply procedure aligned-args)))                          */
;* 	 ((eq? obj-type py-method-class)                               */
;* 	  (let* ((func (PyObjectMethod-method obj))                    */
;* 		 (__self__ (PyObjectMethod-self obj)))                 */
;* 	     (py-call1-generic func __self__)))                        */
;* 	 ;; initialization of instances from type with no special metaclass */
;* 	 ((eq? obj-type py-type-class)                                 */
;* 	  (let ((__new__ (getattribute-from-cls-mro obj (& "__new__")))) */
;* 	     (if (eq? __new__ object.__new__)                          */
;* 		 (if (eq? obj py-object-class)                         */
;* 		     (py-throw-exception-with-message                  */
;* 			py-builtin-TypeError                           */
;* 			"object() takes no arguments")                 */
;* 		     (let ((instance (py-obj-alloc obj)))              */
;* 			(type-call-from-instance obj instance (cons instance '())))) */
;* 		 (type-call-from-new-method-fallback obj '() __new__)))) */
;* 	 (else                                                         */
;* 	  (let ((__call__ (getattribute-from-obj-mro obj (& "__call__")))) */
;* 	     (if (eq? __call__ py-absent)                              */
;* 		 (py-throw-not-callable obj)                           */
;* 		 (py-call1-generic __call__ obj)))))))                 */

(define-rts (py-call1-generic obj a0)
      (py-call-generic obj (list a0)))
;*    (let ((obj-type (py-type obj)))                                  */
;*       (cond                                                         */
;* 	 ((eq? obj-type py-function-class)                             */
;* 	  (let* ((procedure (PyObjectFunction-procedure obj))          */
;* 		 (signature (PyObjectFunction-signature obj))          */
;* 		 (aligned-args (align-args-with-signature (cons a0 '()) signature))) */
;* 	     (tprint "py-call1-generic obj=" (typeof obj) " " procedure  */
;* 		" " (length aligned-args) " " signature)               */
;* 	     (apply procedure aligned-args)))                          */
;* 	 ((eq? obj-type py-method-class)                               */
;* 	  (let* ((func (PyObjectMethod-method obj))                    */
;* 		 (__self__ (PyObjectMethod-self obj)))                 */
;* 	     (py-call2-generic func __self__ a0)))                     */
;* 	 ;; initialization of instances from type with no special metaclass */
;* 	 ((eq? obj-type py-type-class)                                 */
;* 	  (let ((__new__ (getattribute-from-cls-mro obj (& "__new__")))) */
;* 	     (if (eq? __new__ object.__new__)                          */
;* 		 (if (eq? obj py-object-class)                         */
;* 		     (py-throw-exception-with-message                  */
;* 			py-builtin-TypeError                           */
;* 			"object() takes no arguments")                 */
;* 		     (let ((instance (py-obj-alloc obj)))              */
;* 			(type-call-from-instance obj instance (cons instance (cons a0 '()))))) */
;* 		 (type-call-from-new-method-fallback obj (cons a0 '()) __new__)))) */
;* 	 (else                                                         */
;* 	  (let ((__call__ (getattribute-from-obj-mro obj (& "__call__")))) */
;* 	     (if (eq? __call__ py-absent)                              */
;* 		 (py-throw-not-callable obj)                           */
;* 		 (py-call2-generic __call__ obj a0)))))))              */

(define-rts (py-call2-generic obj a0 a1)
      (py-call-generic obj (list a0 a1)))
;*    (let ((obj-type (py-type obj)))                                  */
;*       (cond                                                         */
;* 	 ((eq? obj-type py-function-class)                             */
;* 	  (let* ((procedure (PyObjectFunction-procedure obj))          */
;* 		 (signature (PyObjectFunction-signature obj))          */
;* 		 (aligned-args (align-args-with-signature (cons* a0 a1 '()) signature))) */
;* 	     (tprint "py-call-generic2 obj=" (typeof obj) " " procedure  */
;* 		" " (length aligned-args) " " signature)               */
;* 	     (apply procedure aligned-args)))                          */
;* 	 ((eq? obj-type py-method-class)                               */
;* 	  (let* ((func (PyObjectMethod-method obj))                    */
;* 		 (__self__ (PyObjectMethod-self obj)))                 */
;* 	     (py-call3-generic func __self__ a0 a1)))                  */
;* 	 ;; initialization of instances from type with no special metaclass */
;* 	 ((eq? obj-type py-type-class)                                 */
;* 	  (let ((__new__ (getattribute-from-cls-mro obj (& "__new__")))) */
;* 	     (if (eq? __new__ object.__new__)                          */
;* 		 (if (eq? obj py-object-class)                         */
;* 		     (py-throw-exception-with-message                  */
;* 			py-builtin-TypeError                           */
;* 			"object() takes no arguments")                 */
;* 		     (let ((instance (py-obj-alloc obj)))              */
;* 			(type-call-from-instance obj instance (cons instance (cons* a0 a1 '()))))) */
;* 		 (type-call-from-new-method-fallback obj (cons* a0 a1 '()) __new__)))) */
;* 	 (else                                                         */
;* 	  (let ((__call__ (getattribute-from-obj-mro obj (& "__call__")))) */
;* 	     (if (eq? __call__ py-absent)                              */
;* 		 (py-throw-not-callable obj)                           */
;* 		 (py-call3-generic __call__ obj a0 a1)))))))           */

(define-rts (py-call3-generic obj a0 a1 a2)
      (py-call-generic obj (list a0 a1 a2)))

;*    (let ((obj-type (py-type obj)))                                  */
;*       (cond                                                         */
;* 	 ((eq? obj-type py-function-class)                             */
;* 	  (let* ((procedure (PyObjectFunction-procedure obj))          */
;* 		 (signature (PyObjectFunction-signature obj))          */
;* 		 (aligned-args (align-args-with-signature (cons* a0 a1 '()) signature))) */
;* 	     (tprint "py-call-generic3 obj=" (typeof obj) " " procedure  */
;* 		" " (length aligned-args) " " signature)               */
;* 	     (apply procedure aligned-args)))                          */
;* 	 ((eq? obj-type py-method-class)                               */
;* 	  (let* ((func (PyObjectMethod-method obj))                    */
;* 		 (__self__ (PyObjectMethod-self obj)))                 */
;* 	     (py-call4-generic func __self__ a0 a1 a2)))               */
;* 	 ;; initialization of instances from type with no special metaclass */
;* 	 ((eq? obj-type py-type-class)                                 */
;* 	  (let ((__new__ (getattribute-from-cls-mro obj (& "__new__")))) */
;* 	     (if (eq? __new__ object.__new__)                          */
;* 		 (if (eq? obj py-object-class)                         */
;* 		     (py-throw-exception-with-message                  */
;* 			py-builtin-TypeError                           */
;* 			"object() takes no arguments")                 */
;* 		     (let ((instance (py-obj-alloc obj)))              */
;* 			(type-call-from-instance obj instance (cons instance (cons* a0 a1 '()))))) */
;* 		 (type-call-from-new-method-fallback obj (cons* a0 a1 '()) __new__)))) */
;* 	 (else                                                         */
;* 	  (let ((__call__ (getattribute-from-obj-mro obj (& "__call__")))) */
;* 	     (if (eq? __call__ py-absent)                              */
;* 		 (py-throw-not-callable obj)                           */
;* 		 (py-call4-generic __call__ obj a0 a1 a2)))))))        */

(define-rts (py-call4-generic obj a0 a1 a2 a3)
   (py-call-generic obj (list a0 a1 a2 a3)))

;*     (cond                                                           */
;*       ((eq? obj-type py-function-class)                             */
;*         (let* ((procedure (PyObjectFunction-procedure obj))         */
;*                (signature (PyObjectFunction-signature obj))         */
;*                (aligned-args (align-args-with-signature args signature))) */
;* {* 	   (tprint "py-call-generic obj=" (typeof obj) " " procedure " " (length args) *} */
;* {* 	      " " (length aligned-args) " " signature)                 *} */
;*           (apply procedure aligned-args)))                          */
;*       ((eq? obj-type py-method-class)                               */
;*         (let* ((func (PyObjectMethod-method obj))                   */
;*                (__self__ (PyObjectMethod-self obj)))                */
;*           (py-call-generic func (cons __self__ args))))             */
;*       ;; initialization of instances from type with no special metaclass */
;*       ((eq? obj-type py-type-class)                                 */
;*         (let ((__new__ (getattribute-from-cls-mro obj (& "__new__")))) */
;*           (if (eq? __new__ object.__new__)                          */
;*             (if (eq? obj py-object-class)                           */
;*               (if (null? args)                                      */
;*                 ;; TODO: raise TypeError on unsafe call, ex: object.__new__(int) */
;*                 ;; this should be done concurrently in object-new   */
;*                 (py-obj-alloc py-object-class)                      */
;*                 (py-throw-exception-with-message                    */
;*                   py-builtin-TypeError                              */
;*                   "object() takes no arguments"))                   */
;*               (let ((instance (py-obj-alloc obj)))                  */
;*                 (type-call-from-instance obj instance (cons instance args)))) */
;*             (type-call-from-new-method-fallback obj args __new__)))) */
;*       (else                                                         */
;*         (let ((__call__ (getattribute-from-obj-mro obj (& "__call__")))) */
;*           (if (eq? __call__ py-absent)                              */
;*             (py-throw-not-callable obj)                             */
;*             (py-call-generic __call__ (cons obj args))))))))        */

(define-rts (align-args-with-signature caller-args signature)
  (let ((args (vector-ref signature 0))
        (posonlyargs (vector-ref signature 1))
        (vararg (vector-ref signature 2))
        (kwonlyargs (vector-ref signature 3))
        (kw-defaults (vector-ref signature 4))
        (kwarg (vector-ref signature 5))
        (defaults (vector-ref signature 6)))
    (let* ((caller-args-len (length caller-args))
          (args-len (vector-length args))
          (posonlyargs-len (vector-length posonlyargs))
          (default-len (vector-length defaults))
          (total-args-len (fx+ args-len posonlyargs-len)))
      (cond
        ((fx= caller-args-len total-args-len)
          (if vararg
            (append
              caller-args
              (cons (py-tuple-from-scheme '#()) '())
              (vector->list kw-defaults)
              (if kwarg (cons (py-make-empty-dict) '()) '()))
            (if (or kwarg (fx> (vector-length kw-defaults) 0))
              (append
                caller-args
                (vector->list kw-defaults)
                (if kwarg (cons (py-make-empty-dict) '()) '()))
              caller-args)))
        ((fx< caller-args-len total-args-len)
          (let ((missing-args-len (fx- total-args-len caller-args-len)))
            (if (fx>= default-len missing-args-len)
              (append
                caller-args
                (vector->list
                  (subvector defaults (fx- default-len missing-args-len) default-len))
                (vector->list kw-defaults)
                (if kwarg (cons (py-make-empty-dict) '()) '()))
              (py-throw-exception-with-message
                py-builtin-TypeError
                "missing "
                (number->string (- missing-args-len default-len))
                " required positional argument"))))
        (vararg
          (if (or kwarg (fx> (vector-length kw-defaults) 0))
            (append
              (pack-extra-args (fx- 0 (fx+ 1 total-args-len)) caller-args)
              (vector->list kw-defaults)
              (if kwarg (cons (py-make-empty-dict) '()) '()))
            (pack-extra-args (fx- 0 (fx+ 1 total-args-len)) caller-args)))
        (else
          (if (fx= default-len 0)
            (py-throw-exception-with-message
              py-builtin-TypeError
              "function takes "
              (number->string total-args-len)
              " arguments but "
              (number->string caller-args-len)
              " were given")
            (let ((min-pos-arguments (fx- total-args-len default-len)))
              (py-throw-exception-with-message
                py-builtin-TypeError
                "function takes from "
                (number->string min-pos-arguments)
                " to "
                (number->string total-args-len)
                " arguments but "
                (number->string caller-args-len)
                " were given"))))))))

(define-rts (py-call-hashed-kwargs obj args *args-lst kwargs-table)
  (let ((obj-type (py-type obj)))
    (cond
      ((eq? obj-type py-function-class)
        (let* ((procedure (PyObjectFunction-procedure obj))
               (signature (PyObjectFunction-signature obj))
               (aligned-args (align-with-signature/hashed-kwargs args kwargs-table *args-lst signature)))
          (apply procedure aligned-args)))
      ((eq? obj-type py-method-class)
        (let* ((func (PyObjectMethod-method obj))
               (__self__ (PyObjectMethod-self obj)))
          (py-call-hashed-kwargs func (cons __self__ args) *args-lst kwargs-table)))
      (else
        (let ((__call__ (getattribute-from-obj-mro obj (& "__call__"))))
          (if (eq? __call__ py-absent)
            (py-throw-not-callable obj)
            (py-call-hashed-kwargs __call__ (cons obj args) *args-lst kwargs-table)))))))

(define-rts (py-call-generic-kwargs obj args *args-lst kwargs **kwargs-lst)
  (define (make-kwargs-ordered-table kwargs **kwargs-lst)
    (py-ordered-table-from-scheme (append-lists (cons kwargs (map unpack-kwargs **kwargs-lst)))))

  (let ((obj-type (py-type obj)))
    (cond
      ((eq? obj-type py-function-class)
        (let* ((procedure (PyObjectFunction-procedure obj))
               (signature (PyObjectFunction-signature obj))
               (kwargs-ordered-table (make-kwargs-ordered-table kwargs **kwargs-lst))
               (aligned-args (align-with-signature/kwargs-ordered-table args kwargs-ordered-table *args-lst signature)))
          (apply procedure aligned-args)))
      ((eq? obj-type py-method-class)
        (let* ((func (PyObjectMethod-method obj))
               (__self__ (PyObjectMethod-self obj)))
          (py-call-generic-kwargs func (cons __self__ args) *args-lst kwargs **kwargs-lst)))
      (else
        (let ((__call__ (getattribute-from-obj-mro obj (& "__call__"))))
          (if (eq? __call__ py-absent)
            (py-throw-not-callable obj)
            (py-call-generic-kwargs __call__ (cons obj args) *args-lst kwargs **kwargs-lst)))))))

(define-rts (unpack-kwargs obj)
  (let* ((keys-method (py-getattribute obj (& "keys")))
         (mapping-keys (py-call keys-method))
         (keys-iterator (py-iter mapping-keys)))
    (let loop ((acc '()) (next-key (py-next keys-iterator)))
      (cond ((not next-key)
              (reverse! acc))
            ((py-subtype-of-str? next-key)
             (loop
              (cons (cons next-key (py-getitem obj next-key)) acc)
              (py-next keys-iterator)))
            (else
             (py-throw-exception-with-message
              py-builtin-TypeError
              "keywords must be strings"))))))

(define-rts kwargs-already-seen '%kwargs-already-seen)

(define-rts (kwargs-table-pop! table key)
  ;; NOTE: key will always either be from a signature or a call-table
  ;; key will always have been hashed at compile time
  (let* ((index-table (vector-ref table 0))
        (hash (str-hash-value key))
        ;; index-table contains keys at even indices; index of value at odd indices
        (hash-index
          (fxarithmetic-shift-left
            (fast-range-hash
              hash
              (fxarithmetic-shift-right
                (vector-length index-table)
                1))
            1))
        (key-hit (vector-ref index-table hash-index)))
    (if (and key-hit (str-representatives-eq? key key-hit))
      (let* ((index-index (fx+ hash-index 1))
            (value-index (vector-ref index-table index-index))
            (value (vector-ref table value-index)))
        ;; TODO: For now it is fine to alter the table BUT NOT the index-table
        ;; since the index-table is constant. It may change in the future, so
        ;; find a better way to indicate that a kwarg as already been collected
        (vector-set! table value-index kwargs-already-seen)
        value)
      #f)))

(define-rts (zip-vectors vec1 vec2)
  (map
    cons
    (vector->list vec1)
    (vector->list vec2)))

(define-rts (ncdr lst n)
  (if (= n 0)
    lst
    (ncdr (cdr lst) (- n 1))))

(define-macro (define-signature-aligner name get-values get-values-or-default get-unused-kwargs)
  `(define-rts (,name pos-caller-args caller-kwargs-table *args-lst signature)
      (let* ((args (vector-ref signature 0))
            (posonlyargs (vector-ref signature 1))
            (vararg (vector-ref signature 2))
            (kwonlyargs (vector-ref signature 3))
            (kw-defaults (vector-ref signature 4))
            (kwarg (vector-ref signature 5))
            (defaults (vector-ref signature 6))
            (unpacked-args-lst (iterables*->list *args-lst))
            (caller-args (append pos-caller-args unpacked-args-lst))
            ;; lengths
            (args-length (vector-length args))
            (defaults-length (vector-length defaults))
            (posonlyargs-length (vector-length posonlyargs))
            (caller-args-length (length caller-args))
            (max-positional-args (+ args-length posonlyargs-length))
            (extra-positional-args-length
              (max
                0
                (- caller-args-length max-positional-args)))
            (standard-args-given-as-pos (- caller-args-length posonlyargs-length))
            (args-w/o-defaults-length (- args-length defaults-length))
            (free-args-w/o-default-length
              (max
                args-w/o-defaults-length
                (- standard-args-given-as-pos args-w/o-defaults-length)))
            (shadowed-defaults-length
              (max 0 (- standard-args-given-as-pos args-w/o-defaults-length))))
        ;; ensure there are no more positional arguments then allowed
        (if (and (> caller-args-length max-positional-args) (not vararg))
          (if (= defaults-length 0)
            (py-throw-exception-with-message
              py-builtin-TypeError
              "function takes "
              (number->string max-positional-args)
              " arguments but "
              (number->string caller-args-length)
              " were given")
            (let ((min-positional-args (- max-positional-args defaults-length)))
              (py-throw-exception-with-message
                py-builtin-TypeError
                "function takes from "
                (number->string min-positional-args)
                " to "
                (number->string max-positional-args)
                " arguments but "
                (number->string caller-args-length)
                " were given"))))

        ;; ensure there are no less positional arguments then allowed
        (if (< caller-args-length posonlyargs-length)
          (py-throw-exception-with-message
            py-builtin-TypeError
            "missing "
            (number->string (- posonlyargs-length caller-args-length))
            " required positional argument"))

        (let* ((free-args-w/o-default
                (if (< standard-args-given-as-pos args-w/o-defaults-length)
                  (subvector
                    args
                    standard-args-given-as-pos
                    args-w/o-defaults-length)
                  '#()))
              (free-args-with-default
                (if (< free-args-w/o-default-length args-length)
                  (subvector
                    args
                    free-args-w/o-default-length
                    args-length)
                  '#()))
              (free-defaults
                (if (< shadowed-defaults-length defaults-length)
                  (subvector
                    defaults
                    shadowed-defaults-length
                    defaults-length)
                  '#()))
              (caller-free-args-w/o-default
                (,get-values (vector->list free-args-w/o-default) caller-kwargs-table))
              (caller-args-with-defaults
                (,get-values-or-default
                  (zip-vectors free-args-with-default free-defaults)
                  caller-kwargs-table))
              (caller-kwargs
                (,get-values-or-default
                  (zip-vectors kwonlyargs kw-defaults)
                  caller-kwargs-table)))
          (let ((caller-vararg
                  (if vararg
                    (if (> extra-positional-args-length 0)
                      (list
                        (py-tuple-from-scheme
                          (list->vector
                            (ncdr caller-args max-positional-args))))
                      (list (py-tuple-from-scheme '#())))
                    ;; it was already checked that there is not too many args
                    '()))
                (caller-positional-args
                  (if (= extra-positional-args-length 0)
                    caller-args
                    (let loop ((i 0) (args-head caller-args) (acc '()))
                      (if (< i max-positional-args)
                        (loop (+ i 1) (cdr args-head) (cons (car args-head) acc))
                        (reverse! acc)))))
                (caller-kwarg (,get-unused-kwargs caller-kwargs-table kwarg)))
            (append
              caller-positional-args
              caller-free-args-w/o-default
              caller-args-with-defaults
              caller-vararg
              caller-kwargs
              caller-kwarg))))))

(define-rts (align-with-signature-hashed-kwargs:get-values args kwargs-table)
  (if (null? args)
    '()
    (let* ((name (car args))
          (value (kwargs-table-pop! kwargs-table name)))
      (if value
        (cons (cdr value) (align-with-signature-hashed-kwargs:get-values (cdr args) kwargs-table))
        (py-throw-exception-with-message
          py-builtin-TypeError
          "pending exception message (code 23)")))))

(define-rts (align-with-signature-hashed-kwargs:get-values-or-default args-defaults kwargs-table)
  (if (null? args-defaults)
    '()
    (let* ((name (caar args-defaults))
          (default (cdar args-defaults))
          (value (kwargs-table-pop! kwargs-table name)))
      (cond
        ((not value)
          (cons default (align-with-signature-hashed-kwargs:get-values (map car (cdr args-defaults)) kwargs-table)))
        ((eq? value kwargs-already-seen)
          (py-throw-exception-with-message
            py-builtin-TypeError
            "pending exception message (code 24)"))
        (else
          (cons (cdr value) (align-with-signature-hashed-kwargs:get-values (map car (cdr args-defaults)) kwargs-table)))))))

(define-rts (align-with-signature-hashed-kwargs:get-unused-kwargs kwargs-table kwarg)
  (let* ((len (vector-length kwargs-table))
        (unused-kwargs
          (let loop ((i 1))
            (if (< i len)
              (let ((el (vector-ref kwargs-table i)))
                (if (eq? el kwargs-already-seen)
                  (loop (+ i 1))
                  (cons el (loop (+ i 1)))))
              '()))))
    (if kwarg
      (list (py-dict-from-scheme unused-kwargs))
      (if (null? unused-kwargs)
        '()
        (let ((unknown-keyword
               (py-subtype-of-str-to-scheme
                (caar unused-kwargs))))
          (py-throw-exception-with-message
            py-builtin-TypeError
            "got an unexpected keyword argument '" unknown-keyword "'"))))))

(define-signature-aligner
  align-with-signature/hashed-kwargs
  align-with-signature-hashed-kwargs:get-values
  align-with-signature-hashed-kwargs:get-values-or-default
  align-with-signature-hashed-kwargs:get-unused-kwargs)

(define-rts (align-with-signature-kwargs-ordered-table:get-values args ordered-table)
  (if (null? args)
    '()
    (let* ((name (car args))
          (value (ordered-table-pop! ordered-table name #f)))
      (if value
        (cons value (align-with-signature-kwargs-ordered-table:get-values (cdr args) ordered-table))
        (py-throw-exception-with-message
          py-builtin-TypeError
          "pending exception message (code 30)")))))

(define-rts (align-with-signature-kwargs-ordered-table:get-values-or-default args-defaults ordered-table)
  (if (null? args-defaults)
    '()
    (let* ((name (caar args-defaults))
           (default (cdar args-defaults))
           (value (ordered-table-pop! ordered-table name #f)))
      (cond
        ((not value)
          (cons default (align-with-signature-kwargs-ordered-table:get-values (map car (cdr args-defaults)) ordered-table)))
        ((eq? value kwargs-already-seen)
          (py-throw-exception-with-message
            py-builtin-TypeError
            "pending exception message (code 31)"))
        (else
          (cons value (align-with-signature-kwargs-ordered-table:get-values (map car (cdr args-defaults)) ordered-table)))))))

(define-rts (align-with-signature-kwargs-ordered-table:get-unused-kwargs unused-kwargs kwarg)
  (if kwarg
    (list (py-dict-alloc unused-kwargs))
    (if (= (ordered-table-length unused-kwargs) 0)
      '()
      (let ((unknown-keyword
             (py-subtype-of-str-to-scheme
              (ordered-table-first-key unused-kwargs))))
        (py-throw-exception-with-message
          py-builtin-TypeError
          "got an unexpected keyword argument '" unknown-keyword "'")))))

(define-signature-aligner
  align-with-signature/kwargs-ordered-table
  align-with-signature-kwargs-ordered-table:get-values
  align-with-signature-kwargs-ordered-table:get-values-or-default
  align-with-signature-kwargs-ordered-table:get-unused-kwargs)

(define-rts (py-is-in-mro? target mro)
  (declare-fixnum)
  (let loop ((i 0))
     (and (< i (vector-length mro))
          (let* ((cls (vector-ref mro i)))
             (or (eq? cls target)
                 (loop (+ i 1)))))))

(define-rts (py-isinstance? obj cls)
  (let ((mro (py-obj-mro obj)))
    (py-is-in-mro? cls mro)))

(define-rts (py-issubclass? cls parent)
  (if (py-isinstance? cls py-type-class)
    (let ((mro (PyObjectType-mro cls)))
      (py-is-in-mro? parent mro))
    #f))

(define-rts (py-throw-with-values exc . values)
  (cond ((not (PyObject? exc))
          (py-throw-exception-with-message py-builtin-TypeError "exceptions must derive from BaseException"))
        ((py-is-in-mro? py-builtin-BaseException (py-obj-mro exc))
          (if (null? values)
            (py-throw-unsafe exc)
            (py-throw-exception-with-message
              py-builtin-TypeError
              "instance exception may not have a separate value")))
        ((py-is-in-mro? py-builtin-BaseException (PyObjectType-mro exc))
         (py-throw-unsafe (py-call-generic exc values)))
        (else
         (py-throw-unsafe (py-call py-builtin-TypeError (& "exceptions must derive from BaseException"))))))

(define-rts (py-throw exc)
  (cond ((not (PyObject? exc))
          (py-throw-exception-with-message py-builtin-TypeError "exceptions must derive from BaseException"))
        ((py-is-in-mro? py-builtin-BaseException (py-obj-mro exc))
         (py-throw-unsafe exc))
        ((py-is-in-mro? py-builtin-BaseException (PyObjectType-mro exc))
         (py-throw-unsafe (py-call exc)))
        (else
         (py-throw-exception-with-message py-builtin-TypeError "exceptions must derive from BaseException"))))

;; =============================================================================
;; Exception thrower helpers
;; =============================================================================
(define-rts (throw-unsupported-unary-operand x operator)
  (let ((x-type-name (py-own-attr-ref (py-type x) (& "__name__"))))
    (py-throw
      (py-call
        py-builtin-TypeError
        (py-str-from-scheme
          (string-append
            "bad operand type for for unary "
            operator
            ": '"
            (py-str-to-scheme x-type-name)
            "'"))))))

(define-rts (throw-unhashable x)
  (let ((x-type-name (py-own-attr-ref (py-type x) (& "__name__"))))
    (py-throw
      (py-call
        py-builtin-TypeError
        (py-str-from-scheme
          (string-append
            "unhashable type: '"
            (py-str-to-scheme x-type-name)
            "'"))))))

(define-rts (py-throw-not-an-integer obj)
  (let ((given-type (py-str-to-scheme (py-own-attr-ref (py-type obj) (& "__name__")))))
    (py-throw
      (py-call py-builtin-TypeError
        (py-str-from-scheme
          (string-append
            "'"
            given-type
            "' object cannot be interpreted as an integer"))))))

(define-rts (py-throw-has-no-len obj)
  (let ((given-type (py-str-to-scheme (py-own-attr-ref (py-type obj) (& "__name__")))))
    (py-throw
      (py-call py-builtin-TypeError
        (py-str-from-scheme
          (string-append
            "object of type '"
            given-type
            "' has no len()"))))))

(define-rts (py-throw-index-out-of-range type)
  (py-throw
    (py-call py-builtin-IndexError
      (py-str-from-scheme
        (string-append
          type
          " index out of range")))))

(define-rts (py-throw-assignment-index-out-of-range type)
  (py-throw
   (py-call py-builtin-IndexError
            (py-str-from-scheme
             (string-append
              type
              " assignment index out of range")))))

(define-rts (py-throw-action-out-of-range type action)
  (py-throw
    (py-call py-builtin-IndexError
      (py-str-from-scheme
        (string-append
          type
          " "
          action
          " out of range")))))

(define-rts (py-throw-pop-from-empty-list)
  (py-throw
    (py-call py-builtin-IndexError
      (py-str-from-scheme "pop from empty list"))))

(define-rts (py-throw-wrong-index-type type expected-description item)
  (let ((given-type (py-str-to-scheme (py-own-attr-ref (py-type item) (& "__name__")))))
    (py-throw
      (py-call py-builtin-TypeError
        (py-str-from-scheme
          (string-append
            type
            " indices must be "
            expected-description
            ", not "
            given-type))))))

(define-rts (py-throw-can-only-assign-iterable)
  (py-throw
    (py-call py-builtin-TypeError
      (&& "can only assign an iterable"))))

(define-rts (py-throw-extended-slice-wrong-len actual-len expected-len)
  (py-throw
    (py-call py-builtin-ValueError
      (py-str-from-scheme
        (string-append
          "attempt to assign sequence of size "
          (number->string actual-len)
          " to extended slice of size "
          (number->string expected-len))))))

(define-rts (throw-not-iterable obj)
  (let ((obj-type-name (py-own-attr-ref (py-type obj) (& "__name__"))))
    (py-throw (py-call
                py-builtin-TypeError
                (py-str-from-scheme
                  (string-append
                    "argument of type '"
                    (py-str-to-scheme obj-type-name)
                    "' is not iterable"))))))

(define-rts (py-throw-not-an-iterator obj)
  (let ((given-type (py-str-to-scheme (py-own-attr-ref (py-type obj) (& "__name__")))))
    (py-throw
      (py-call py-builtin-TypeError
        (py-str-from-scheme
          (string-append "'" given-type "' object is not an iterator"))))))

(define-rts (py-throw-not-callable obj)
  (let ((given-type (py-str-to-scheme (py-own-attr-ref (py-type obj) (& "__name__")))))
    (py-throw
      (py-call py-builtin-TypeError
        (py-str-from-scheme
          (string-append "'" given-type "' object is not callable"))))))

(define-rts (py-throw-required-type method-name required-type arg)
  (let ((given-type (py-str-to-scheme (py-own-attr-ref (py-type arg) (& "__name__")))))
    (py-throw
      (py-call py-builtin-TypeError
        (py-str-from-scheme
          (string-append
              "descriptor '"
              method-name
              "' requires a '"
              required-type
              "' object but received a '"
              given-type
              "'"))))))

(define-rts (py-throw-not-a-subtype fun-name wrong-type type-name)
  (let ((wrong-type-name (py-str-to-scheme (py-own-attr-ref wrong-type (& "__name__")))))
    (py-throw
      (py-call py-builtin-TypeError
        (py-str-from-scheme
          (string-append
              fun-name "(" wrong-type-name "): " wrong-type-name " is not a subtype of " type-name))))))

(define-rts (py-throw-not-a-type-object fun-name obj)
  (let* ((instance-type (py-type obj))
         (instance-type-name (py-str-to-scheme (py-own-attr-ref instance-type (& "__name__")))))
    (py-throw
      (py-call py-builtin-TypeError
        (py-str-from-scheme
          (string-append
              fun-name "(X): X is not a type object (" instance-type-name ")"))))))

;; when there is a call to cls.__new__(X), X must be a subtype of cls
;; if it is not even a type the error message is:
;;    cls.__new__(X): X is not a type object ([type of X])
;; if X is a type, but not a subtype of cls, the error message is:
;;   cls.__new__([X.__name__]): [X.__name__] is not a subtype of cls
(define-rts (py-throw-wrong-new-argument cls-name arg)
  (let ((fun-name (string-append cls-name ".__new__")))
    (if (py-isinstance? arg py-type-class)
      (py-throw-not-a-subtype fun-name arg cls-name)
      (py-throw-not-a-type-object fun-name arg))))

(define-rts (throw-returned-wrong-type fun-name obj qualifier)
  (let* ((type (py-type obj))
         (type-name (py-own-attr-ref type (& "__name__"))))
    (py-throw
      (py-call
        py-builtin-TypeError
        (py-str-from-scheme
          (string-append
            fun-name " returned " qualifier " (type " type-name ")"))))))

;; -----------------------------------------------------------------------------

(define-rts attribute-caches '())

(define-rts (reset-mro-caches!)
  (for-each (lambda (cache) (AttributeCache-mro-reset! cache)) attribute-caches))

(define-rts (py-make-caches kinds)
  (define (make-cache kind)
    (case kind
      ((global) (make-init-PCache))
      ((attribute)
        (let ((attr-cache (make-init-AttributeCache)))
          (set! attribute-caches (cons attr-cache attribute-caches))
          attr-cache))
      (else
        (error "py-make-caches" "unknown cache kind" kind))))
  (list->vector (map make-cache kinds)))

;;;----------------------------------------------------------------------------

;; =============================================================================
;;  OPERATORS PROTOCOLS
;; =============================================================================

(define-rts (throw-unsupported-operand x y operator)
  (let ((x-type-name (py-own-attr-ref (py-type x) (& "__name__")))
        (y-type-name (py-own-attr-ref (py-type y) (& "__name__"))))
    (py-throw
      (py-call
        py-builtin-TypeError
        (py-str-from-scheme
          (string-append
            "unsupported operand type(s) for "
            operator
            ": '"
            (py-str-to-scheme x-type-name)
            "' and '"
            (py-str-to-scheme y-type-name)
            "'"))))))

;; special case of x in y when y is an iterator
(define-rts (py-in-iterator item iterator)
  (let ((next-item (py-next iterator)))
    (cond
      ((not next-item) py-False)
      ((py-eq item next-item) py-True)
      (else (py-in-iterator item iterator)))))

(define-rts (py-in item container) ;; x in y
  (let ((__contains__ (getattribute-from-obj-mro container (& "__contains__"))))
    (if (eq? __contains__ py-absent)
      (let ((iterator (py-obj->iterator container)))
        (if iterator
          (py-in-iterator item iterator)
          (throw-not-iterable container)))
      (if (py-test (py-call __contains__ container item)) py-True py-False))))

(define-rts (py-notin item container) ;; x not in y
  (if (py-test (py-in item container))
    py-False
    py-True))

;; meant to be called as the builtin abs(), not an operator but follows
;; the same logic
(define-rts (py-abs x)
  (let ((__abs__ (getattribute-from-obj-mro x (& "__abs__"))))
    (if (eq? __abs__ py-absent)
        (throw-unsupported-unary-operand x "abs()")
        (py-call __abs__ x))))

(define-rts (py-hash x)
  (let ((__hash__ (getattribute-from-obj-mro x (& "__hash__"))))
    (if (eq? __hash__ py-absent)
        (throw-unhashable x)
        (let ((h (py-call __hash__ x)))
          (if (py-subtype-of-int? h)
            (let ((h-value (py-subtype-of-int-to-scheme h)))
              (py-int-from-scheme (truncate-hash h-value)))
            (py-throw-exception-with-message
               py-builtin-RuntimeError
               "__hash__ method should return an integer"))))))


(define-rts (py-dir x)
  (if (eq? x py-absent)
      (py-throw-exception-with-message
        py-builtin-NotImplementedError
        "dir() call with no arguments is not yet implemented ")
      (let ((__dir__ (getattribute-from-obj-mro x (& "__dir__"))))
       (py-call py-builtin-sorted (py-call __dir__ x)))))

;; =============================================================================
;; int operations
;; =============================================================================

(cond-expand
  (gambit

   ;; fallbacks for int/int operations

   (define-rts (pyneg-UintX-fallback x)
     (py-int-from-scheme (|##negate| x)))

   (define-rts (pyinvert-UintX-fallback x)
     (py-int-from-scheme (|##bitwise-not| x)))

   (define-rts (pyadd-UintX-UintY-fallback x y)
     (py-int-from-scheme (|##+2| x y)))

   (define-rts (pysub-UintX-UintY-fallback x y)
     (py-int-from-scheme (|##-2| x y)))

   (define-rts (pymul-UintX-UintY-fallback x y)
     (py-int-from-scheme (|##*2| x y)))

   (define-rts (py&-UintX-UintY-fallback x y)
     (py-int-from-scheme (|##bitwise-and| x y)))

   (define-rts (py+b-UintX-UintY-fallback x y)
     (py-int-from-scheme (|##bitwise-ior| x y)))

   (define-rts (py^-UintX-UintY-fallback x y)
     (py-int-from-scheme (|##bitwise-xor| x y)))

   (define-rts (py>>-UintX-UintY-fallback x y)
     (py-int-from-scheme (|##arithmetic-shift| x (|##negate| y))))

   (define-rts (py<<-UintX-UintY-fallback x y)
     (py-int-from-scheme (|##arithmetic-shift| x y)))

   (define-rts (py//-UintX-UintY-fallback x y)
     (py-int-from-scheme (|##quotient| x y)))

   (define-rts (py%-UintX-UintY-fallback x y)
     (py-int-from-scheme (|##modulo| x y)))
))

(define-rts (int-repr self)
  (if (py-subtype-of-int? self)
      (py-str-from-scheme (number->string (py-subtype-of-int-to-scheme self)))
      (py-throw-required-type "__repr__" "int" self)))

(define-rts int.__repr__
  (procedure->py-function
    int-repr
    (make-signature posonlyargs: (self))))

(define-rts (int-hash self)
  (if (py-subtype-of-int? self)
      (py-int-from-scheme (truncate-hash (py-subtype-of-int-to-scheme self)))
      (py-throw-required-type "__hash__" "int" self)))

(define-rts int.__hash__
  (procedure->py-function
    int-hash
    (make-signature posonlyargs: (self))))

(define-rts (int-int self)
  (if (py-subtype-of-int? self)
      (py-int-from-scheme (py-subtype-of-int-to-scheme self))
      (py-throw-required-type "__int__" "int" self)))

(define-rts int.__int__
  (procedure->py-function
    int-int
    (make-signature posonlyargs: (self))))

(define-rts (int-bool self)
  (if (py-subtype-of-int? self)
      (py-bool-from-scheme-bool
       (not (eqv? 0 (py-subtype-of-int-to-scheme self))))
      (py-throw-required-type "__bool__" "int" self)))

(define-rts int.__bool__
  (procedure->py-function
    int-bool
    (make-signature posonlyargs: (self))))

;;;----------------------------------------------------------------------------

;; ================
;; GETATTR PROTOCOL
;; ================

;; Recover an attribute from the given class
;;   Does so by looking through the classes of the MRO
;;   returns the first occurence of the attribute
;;   found on an element of the MRO
(define-rts (getattribute-from-cls-mro-fallback cls name)
  (getattribute-from-cls-mro cls name))

;; Recover an attribute from the class of 'obj'
(define-rts (getattribute-from-obj-mro-fallback obj name)
  (getattribute-from-cls-mro (py-obj-cls obj) name))

(define-rts (object-getattribute obj name #!optional (raise? #t) (cache #f))
  (define (getattribute-from-mro index-hit-on-object-hclass)
    (getattribute-from-obj-mro-with-index/owner-2cont
      obj
      name
      (lambda (index cls-attr owner)
        (if index-hit-on-object-hclass
          (if cache
            (AttributeCache-object-or-mro-hit!
              cache
              (py-obj-hclass obj)
              index-hit-on-object-hclass
              cls-attr
              owner))
          (if cache (AttributeCache-mro-hit! cache (py-obj-hclass obj) cls-attr owner)))
        (py-descriptor-get cls-attr obj owner))
      (lambda ()
        ;; TODO: replace this hack by something better
        ;; NOTE: __class__ should get a getset_descriptor on object
        (if (eq? (py-str-representative name) (& "__class__"))
            (py-obj-cls obj)
            (begin
              (and
                raise?
                (py-throw-object-getattribute-error obj name)))))))

  (py-own-attr-index/ref-2cont
    obj
    name
    (lambda (index val)
      (if (eq? val py-absent)
        (getattribute-from-mro #t)
        (begin
          (if cache (AttributeCache-object-hit! cache (py-obj-hclass obj) index))
          val)))
    (lambda () (getattribute-from-mro #f))))

(define-rts object.__getattribute__
  (procedure->py-function
    object-getattribute
    (make-signature posonlyargs: (obj name))))

(define-rts (object-setattr obj name val)
  ;; TODO: add check that obj does not has it own setattr method
  (if (py-subtype-of-str? name)
    (begin
      (if (PyObjectType? obj) (reset-mro-caches!))
      (py-own-attr-set! obj name val))
    (py-throw-exception-with-message
     py-builtin-TypeError
     "attribute name must be string")))

(define-rts object.__setattr__
  (procedure->py-function
    object-setattr
    (make-signature posonlyargs: (obj name val))))

;; Implements type.__getattribute__
(define-rts (type-getattribute obj name #!optional (raise? #t) (cache #f))
  (if (py-isinstance? obj py-type-class)
    (getattribute-from-cls-mro-with-owner-2cont
      obj
      name
      (lambda (attr owner)
        (if cache (AttributeCache-type-hit! cache (py-obj-hclass obj) attr owner))
        (py-descriptor-get attr py-None obj))
      (lambda ()
        (getattribute-from-obj-mro-with-owner-2cont
         obj
         name
         (lambda (cls-attr owner)
           (if cache (AttributeCache-type-mro-hit! cache (py-obj-hclass obj) cls-attr owner))
           (py-descriptor-get cls-attr obj owner))
         (lambda ()
           (and raise? (py-throw-type-getattribute-error obj name))))))
    (py-throw-required-type "__getattribute__" "type" obj)))

;; The Python object type.__getattribute__
(define-rts type.__getattribute__
  (procedure->py-function
    type-getattribute
    (make-signature posonlyargs: (obj name))))

(define-rts (object-has obj attr)
   (>= (py-own-attr-index obj attr) 0))

;; =============================================================================
;;  ITER PROTOCOL
;; =============================================================================

;; TODO: implement the sequence protocole where object are iterable if they
;; have a __getitem__ method starting from index 0
(define-rts (py-obj->iterator obj)
 (let ((__iter__ (getattribute-from-obj-mro obj (& "__iter__"))))
   (if (eq? __iter__ py-absent)
     #f
     (py-call __iter__ obj))))

;; Wraps py-obj->iterator to raise a TypeError when the object is not iterable
(define-rts (py-iter-fallback obj)
 (or (py-obj->iterator obj)
     (throw-not-iterable obj)))

(define-rts (iterator-next obj default)
   (let ((__next__ (getattribute-from-obj-mro obj (& "__next__"))))
     (if (eq? __next__ py-absent)
       (py-throw-not-an-iterator obj)
       (if (eq? default py-absent)
         (py-call __next__ obj)
         (py-try-except
           (lambda (exc)
             (if (py-isinstance? exc py-builtin-StopIteration)
               default
               (py-throw-unsafe exc)))
           (lambda () (py-call __next__ obj)))))))

(define-rts (iterator->list it)
 (let loop ((acc '()))
   (let ((nxt (iterator-next it #f)))
     (if nxt
       (loop (cons nxt acc))
       (reverse! acc)))))

(define-rts (py-unpack it)
 (iterator->list (py-iter it)))

(define-rts (py-ternary-unpack it nleft nright)
 ;; return a 3-vector (left-elements list right-elements)
 ;;  left-elements is a vector containing the nleft elements
 ;;  list is a Python list containing the middle elements
 ;;  right-elements is a vector containing the nright elements
 (let* ((elts (py-unpack it))
        (min-required (fx+ nleft nright))
        (len-elts (length elts)))
   (if (< len-elts min-required)
     (py-throw-exception-with-message
       py-builtin-ValueError
       "not enough values to unpack (expected at least "
       (number->string min-required)
       ", got "
       (number->string len-elts)
       ")")
     (let* ((lefts (make-vector nleft))
           (mids-len (- len-elts min-required))
           (mids (make-vector mids-len))
           (rights (make-vector nright)))

       (define (fill-left i tail)
         (if (fx< i nleft)
           (begin
             (vector-set! lefts i (car tail))
             (fill-left (fx+ i 1) (cdr tail)))
           (fill-mid 0 tail)))

       (define (fill-mid i tail)
         (if (fx< i mids-len)
           (begin
             (vector-set! mids i (car tail))
             (fill-mid (fx+ i 1) (cdr tail)))
           (fill-right tail)))

       (define (fill-right tail)
         (vector lefts (py-make-list-from-vec mids) (list->vector tail)))

       (fill-left 0 elts)))))

(define-rts (iterables*->list lst)
 (let outer-loop ((iterators lst) (outer-acc '()))
   (if (null? iterators)
     (reverse! outer-acc)
     (let ((it (py-iter (car iterators))))
       (let inner-loop ((inner-acc outer-acc))
         (let ((nxt (iterator-next it #f)))
           (if nxt
             (inner-loop (cons nxt inner-acc))
             (outer-loop (cdr iterators) inner-acc))))))))

(define-rts (py-for-each-fallback iterable body)
  (let ((iterator (py-iter iterable)))
    (let loop ()
      (let ((element (py-next iterator)))
        (if element
          (begin
            (body element)
            (loop)))))))

;; =============================================================================
;;  NEXT PROTOCOL
;; =============================================================================

(define-rts (py-next-fallback iterator)
 (let ((next (getattribute-from-obj-mro iterator (& "__next__"))))
    (if (eq? next py-absent)
      (py-throw-exception-with-message py-builtin-TypeError "object is not an iterator")
      (py-try-except
         (lambda (e)
           (if (py-isinstance? e py-builtin-StopIteration)
               #f
               (py-throw-unsafe e)))
         (lambda () (py-call next iterator))))))

;; =============
;; CALL PROTOCOL
;; =============

;; slow way to call function through function.__call__
;; interfaces between manual __call__ and py-call
(define-rts (function-call self args)
  (if (eq? (py-type self) py-function-class)
      (let ((args-list (vector->list (PyObjectTuple-value args))))
	 (tprint "functiopn-call " (length args-list))
      (py-call-generic self args-list))
    (py-throw-required-type "__call__" "method" self)))

(define-rts function.__call__
  (procedure->py-function
    function-call
    (make-signature
      posonlyargs: (self)
      vararg: args)))

(define-rts (type-call-from-new-method-fallback self args __new__)
  (type-call-from-new-method self args __new__))

(define-rts (type-call-fallback self args)
  (type-call-from-new-method
    self
    (vector->list (PyObjectTuple-value args))
    (getattribute-from-cls-mro self (& "__new__"))))

(define-rts type.__call__
  (procedure->py-function
    type-call-fallback
    (make-signature
      posonlyargs: (self)
      vararg: args)))

(define-rts (type-setattr self name val)
  ;; TODO: add check that obj does not has it own setattr method
  (if (py-isinstance? self py-builtin-type)
    (if (py-subtype-of-str? name)
      (begin
        (reset-mro-caches!)
        (py-own-attr-set! self name val))
      (py-throw-exception-with-message
       py-builtin-TypeError
       "attribute name must be string"))
    (py-throw-exception-with-message
     py-builtin-TypeError
     "descriptor '__setattr__' requires a 'type' object")))

(define-rts type.__setattr__
  (procedure->py-function
    object-setattr
    (make-signature posonlyargs: (self name val))))


;; TODO: remove the tuple->list conversion once we support argument unpacking
(define-rts (type-new metacls cls args)
  (let* ((args-list (vector->list (PyObjectTuple-value args)))
        (args-length (length args-list)))
    (cond
      ((= args-length 0)
        (py-obj-cls cls))
      ((= args-length 2)
        (py-throw-exception-with-message py-builtin-NotImplementedError "type(name, bases, nmspace) not implemented"))
      (else
        (py-throw (py-call
          py-builtin-TypeError
          (&& "type() takes 1 or 3 arguments")))))))

(define-rts type.__new__
  (procedure->py-function
    type-new
    (make-signature
      posonlyargs: (metacls cls)
      vararg: args)))

(define-rts (tuple-new cls iterable)
  (if (or (eq? cls py-tuple-class) (py-issubclass? cls py-tuple-class))
      (if (eq? iterable py-absent)
          (py-tuple-subtype-from-scheme '#() cls)
          (let ((iterable-type (py-type iterable)))
           (cond
             ((eq? iterable-type py-tuple-class)
              (if (eq? cls py-tuple-class)
                  iterable
                  (let ((value (PyObjectTuple-value iterable)))
                   (py-tuple-subtype-from-scheme value cls))))
             ((eq? iterable-type py-list-class)
              (let* ((vec (PyObjectList-vector iterable))
                     (len (PyObjectList-len iterable)))
               (py-tuple-subtype-from-scheme (subvector vec 0 len) cls)))
             (else
               (let* ((iterator (py-iter iterable))
                      (content (list->vector (iterator->list iterator))))
                 (py-tuple-subtype-from-scheme (vector-copy content) cls))))))
      (py-throw-wrong-new-argument "tuple" cls)))

(define-rts tuple.__new__
  (procedure->py-function
    tuple-new
    (make-signature posonlyargs: (cls iterable) defaults: (vector py-absent))))

;; TODO: raise TypeError on unsafe call, ex: object.__new__(int)
;; this should be done concurrently in py-call-generic
;; TODO: raise TypeError when cannot create, ex: list_iterator.__new__()
;; TODO: raise TypeError when object() is called with arguments
(define-rts (object-new cls args kwargs)
  (if (py-isinstance? cls py-type-class)
    (py-obj-alloc cls)
    (py-throw
      (py-call py-builtin-TypeError
        (&& "object.__new__(X): X is not a type object")))))

(define-rts object.__new__
  (procedure->py-function
    object-new
    (make-signature
      posonlyargs: (cls)
      vararg: args
      kwarg: kwargs)))

;; object.__init__ exists but does nothing
;; its purpose is that super().__init__ does not raise and AttributeError
(define-rts object.__init__
  (procedure->py-function
    (lambda (self args) py-None)
    (make-signature
      posonlyargs: (self)
      vararg: args)))


;; =============================================================================
;;  str and repr protocols
;; =============================================================================

(define-rts (py-str-from-string len string)
  (make-PyObjectStr
   py-str-hclass-of-instances
   '#()
   py-str-class
   len
   string
   #f))

(define-rts (py-subtype-of-str-from-string len string str-subclass)
  (make-PyObjectStr
   py-str-hclass-of-instances
   '#()
   str-subclass
   len
   string
   #f))

(define-rts (py-str-from-concat len str1 str2)
  (make-PyObjectStr
   py-str-hclass-of-instances
   '#()
   py-str-class
   len
   str1
   str2))

(define-rts (py-str-representative-from-string len string hash)
  (let ((result
          (make-still-copy
             (make-PyObjectStrRep
              py-str-hclass-of-instances
              '#()
              py-str-class
              len
              string
              #f
              hash
              #f))))
    (PyObjectStr-part2-or-rep-set! result result) ;; own representative
    result))

(define-rts (py-str-from-scheme-fallback string)
  (let ((len (string-length string)))
    (py-str-from-string len string)))

(define-rts (py-subtype-of-str-from-scheme-fallback string str-subclass)
  (let ((len (string-length string)))
    (py-subtype-of-str-from-string len string str-subclass)))

(define-rts (py-str-to-scheme-fallback str)
  (let ((part1-or-string (PyObjectStr-part1-or-string str)))
    (if (string? part1-or-string)
        part1-or-string
        (let ((result (py-str-concatenation-to-scheme str)))

          (PyObjectStr-part1-or-string-set! str result)
          (PyObjectStr-part2-or-rep-set! str #f)

          result))))

(define-rts (py-subtype-of-str-to-scheme-fallback str)
  (py-str-to-scheme-fallback str))

(define-rts (py-str-representative-fallback str)
  (let ((part1-or-string (PyObjectStr-part1-or-string str)))
    (if (string? part1-or-string)
        (or (PyObjectStr-part2-or-rep str)
            (let ((part2-or-rep
                   (py-str-representative-from-scheme part1-or-string)))
              (PyObjectStr-part2-or-rep-set! str part2-or-rep)
              part2-or-rep))
        (let* ((part1-or-string
                (py-str-concatenation-to-scheme str))
               (part2-or-rep
                (py-str-representative-from-scheme part1-or-string)))
              (PyObjectStr-part1-or-string-set! str part1-or-string)
              (PyObjectStr-part2-or-rep-set! str part2-or-rep)
              part2-or-rep))))

(define-rts (py-str-concatenation-to-scheme str)
  (let* ((len (py-str-len-to-scheme str))
         (result (make-string len)))

    (define (store str len pos)
      (let ((part1-or-string (PyObjectStr-part1-or-string str)))
        (if (string? part1-or-string)
            (cond-expand
              (gambit
               (substring-move! part1-or-string 0 len result pos))
              (bigloo
               (let loop ((i 0) (j pos))
                 (if (fx< i len)
                     (begin
                       (string-set! result j (string-ref part1-or-string i))
                       (loop (fx+ i 1) (fx+ j 1)))))))
            (let* ((len1 (py-str-len-to-scheme part1-or-string))
                   (part2-or-rep (PyObjectStr-part2-or-rep str))
                   (len2 (py-str-len-to-scheme part2-or-rep)))
              (if (fx< len1 len2) ;; guarantee O(log n) call stack depth
                  (begin
                    (store part1-or-string len1 pos)
                    (store part2-or-rep len2 (fx+ pos len1)))
                  (begin
                    (store part2-or-rep len2 (fx+ pos len1))
                    (store part1-or-string len1 pos)))))))

    (store str len 0)

    result))

(define-rts (py-str-representative-from-scheme string)
  (or (table-ref str-representatives-htable string #f)
      (let* ((hash (hash-FNV1a string))
             (len (string-length string))
             (str (py-str-representative-from-string len string hash)))
        (table-set! str-representatives-htable string str)
        str)))

(define-rts str-representatives-htable (get-registered-constants-table))

(define-rts (py-concat-strX-strY str1 str2)

  (define optimize-small? #t) ;; optimize concatenation of small strings?
  (define small 8) ;; maximal length of a "small" string

  (let* ((len1 (py-str-len-to-scheme str1))
         (len2 (py-str-len-to-scheme str2))
         (len (fx+ len1 len2)))

    (cond ((and optimize-small?
                (fx<= len small))
           (py-str-from-string
            len
            (string-append (PyObjectStr-part1-or-string str1)
                           (PyObjectStr-part1-or-string str2))))
#;
          ((and optimize-small?
                (string? (PyObjectStr-part1-or-string str2))
                (not (string? (PyObjectStr-part1-or-string str1)))
                (string? (PyObjectStr-part1-or-string
                          (PyObjectStr-part2-or-rep str1)))
                (fx<= (fx+ (py-str-len-to-scheme
                            (PyObjectStr-part2-or-rep str1))
                           len2)
                      small))
           (py-str-from-concat
            len
            (PyObjectStr-part1-or-string str1)
            (py-str-from-string
             (fx+ (py-str-len-to-scheme (PyObjectStr-part2-or-rep str1))
                  len2)
             (string-append (PyObjectStr-part1-or-string
                             (PyObjectStr-part2-or-rep str1))
                            (PyObjectStr-part1-or-string str2)))))
#;
          ((and optimize-small?
                (string? (PyObjectStr-part1-or-string str1))
                (not (string? (PyObjectStr-part1-or-string str2)))
                (string? (PyObjectStr-part1-or-string
                          (PyObjectStr-part1-or-string str2)))
                (fx<= (fx+ len1
                           (py-str-len-to-scheme
                            (PyObjectStr-part1-or-string str2)))
                      small))
           (py-str-from-concat
            len
            (py-str-from-string
             (fx+ len1
                  (py-str-len-to-scheme (PyObjectStr-part1-or-string str2)))
             (string-append (PyObjectStr-part1-or-string str1)
                            (PyObjectStr-part1-or-string
                             (PyObjectStr-part1-or-string str2))))
            (PyObjectStr-part2-or-rep str2)))

          (else
           (py-str-from-concat
            len
            str1
            str2)))))

(define-rts (string-join-vector separator vec)
  (let* ((separator-len (string-length separator))
        (vec-len (vector-length vec))
        (last-index (- vec-len 1))
        (vec-strings-len
          (let loop ((i 0) (acc 0))
            (if (< i vec-len)
              (loop (+ i 1) (+ acc (string-length (vector-ref vec i))))
              acc)))
        (number-separators (max 0 (- vec-len 1)))
        (total-len (+ vec-strings-len (* number-separators separator-len)))
        (out (make-string total-len)))
    (let loop ((vec-pos 0) (out-pos 0))
      (if (< vec-pos vec-len)
        (begin
          (let* ((source (vector-ref vec vec-pos))
                 (source-len (string-length source)))
            (let item-loop ((source-pos 0))
              (if (< source-pos source-len)
                (begin
                  (string-set! out out-pos (string-ref source source-pos))
                  (set! out-pos (+ out-pos 1))
                  (item-loop (+ source-pos 1))))))
          (if (> number-separators 0)
            (begin
              (let separator-loop ((separator-pos 0))
                (if (< separator-pos separator-len)
                  (begin
                    (string-set! out out-pos (string-ref separator separator-pos))
                    (set! out-pos (+ out-pos 1))
                    (separator-loop (+ separator-pos 1)))))
              (set! number-separators (- number-separators 1))))
          (loop (+ vec-pos 1) out-pos))
        out))))

(define-rts (integer->hex-string x)
  (string-append "0x" (number->string x 16)))

(define-rts (str-new cls value)
  (cond
    ((eq? cls py-str-class)
     (if (eq? value py-absent)
         (&& "")
         (let* ((__str__ (getattribute-from-obj-mro value (& "__str__")))
                (result (py-call __str__ value)))
           (if (py-subtype-of-str? result)
               result
               (throw-returned-wrong-type "__str__" value "non-string")))))
    ((py-issubclass? cls py-str-class)
     (if (eq? value py-absent)
         (py-subtype-of-str-from-scheme
           ""
           cls)
         (let* ((__str__ (getattribute-from-obj-mro value (& "__str__")))
                (result (py-call __str__ value)))
           (if (py-subtype-of-str? result)
               (py-subtype-of-str-from-scheme
                 (py-subtype-of-str-to-scheme result)
                 cls)
               (throw-returned-wrong-type "__str__" value "non-string")))))
    (else
      (py-throw-wrong-new-argument "str" cls))))

(define-rts str.__new__
  (procedure->py-function
    str-new
    (make-signature posonlyargs: (cls value) defaults: (vector py-absent))))

(define-rts (str-hash-value str)
  (PyObjectStrRep-hash (py-str-representative str)))

(define-rts (str-hash self)
  (if (py-subtype-of-str? self)
      (py-int-from-scheme (str-hash-value self))
      (py-throw-required-type "__hash__" "str" self)))

(define-rts str.__hash__
  (procedure->py-function
    str-hash
    (make-signature posonlyargs: (self))))

(define-rts (str-str self)
  (if (py-subtype-of-str? self)
      self
      (py-throw-required-type "__str__" "str" self)))

(define-rts str.__str__
  (procedure->py-function
    str-str
    (make-signature posonlyargs: (self))))

(define-rts (str-repr self)
  (if (py-subtype-of-str? self)
      (let* ((string (py-subtype-of-str-to-scheme self))
             (string-repr (py-str-repr-scheme string)))
        (py-str-from-scheme string-repr))
      (py-throw-required-type "__repr__" "str" self)))

(define-rts str.__repr__
  (procedure->py-function
    str-repr
    (make-signature posonlyargs: (self))))

(define-rts (str-getitem self index)
  (if (py-subtype-of-str? self)
    (cond
      ((py-subtype-of-int? index)
        (let* ((string-content (py-subtype-of-str-to-scheme self))
               (len (py-str-len-to-scheme self))
               (i (py-subtype-of-int-to-scheme index)))
          (if (index-in-length-range i len)
            (py-str-from-scheme (string (string-ref string-content (modulo i len))))
            (py-throw-index-out-of-range "str"))))
      ((py-isinstance? index py-slice-class)
        (let* ((string-content (py-str-to-scheme self))
               (len (py-str-len-to-scheme self))
               (slice-indices (py-slice-indices index len))
               (start (vector-ref slice-indices 0))
               (stop (vector-ref slice-indices 1))
               (step (vector-ref slice-indices 2))
               (slice-len (get-slice-length start stop step))
               (slice-string (make-string slice-len)))
          (let loop ((source start) (target 0))
            (if (< target slice-len)
              (begin
                (string-set! slice-string target (string-ref string-content source))
                (loop (+ source step) (+ target 1)))
              (py-str-from-scheme slice-string)))))
      (else (py-throw-wrong-index-type "str" "integers or slices" index)))
    (py-throw-not-a-type-object "str.__getitem__" self)))

(define-rts str.__getitem__
  (procedure->py-function
    str-getitem
    (make-signature posonlyargs: (self index))))

(define-rts (str-lower self)
  (if (py-subtype-of-str? self)
      (py-str-from-scheme (string-downcase (py-subtype-of-str-to-scheme self)))
      (py-throw-required-type "lower" "str" self)))

(define-rts str.lower
  (procedure->py-function
    str-lower
    (make-signature posonlyargs: (self))))

(define-rts (add-obj-hclass-to-hashtable! table obj)
  (let* ((names (HClass-names (py-obj-hclass obj)))
        (names-len (vector-length names))
        (obj-elements-len (vector-length (PyObject-%elements obj))))
      (let loop ((i 0))
        (if (and (< i names-len) (< i obj-elements-len))
          (let ((val (PyObject-elements-ref obj i)))
            (if (not (eq? val py-absent))
              (table-set! table (vector-ref names i) val))
            (loop (+ i 1)))))))

(define-rts (add-global-hclass-to-hashtable! table obj)
  (let* ((names (HClass-names (py-obj-hclass obj)))
        (names-len (vector-length names))
        (obj-elements-len (vector-length (PyObject-%elements obj))))
      (let loop ((i 0))
        (if (and (< i names-len) (< i obj-elements-len))
          (let ((val (PyObject-global-elements-ref obj i)))
            (if val
              (table-set! table (vector-ref names i) val))
            (loop (+ i 1)))))))

;; WARNING values of left-most objects in the list will be overwritten in hashtable
(define-rts (obj*-hclass->hashtable . objs)
  (let* ((table (make-table test: eq?)))
    (for-each
      (lambda (o) (add-obj-hclass-to-hashtable! table o))
      objs)
    table))

(define-rts (global*-hclass->hashtable . glo)
  (let* ((table (make-table test: eq?)))
    (for-each
      (lambda (o) (add-global-hclass-to-hashtable! table o))
      glo)
    table))

(define-rts (py-get-list-of-obj*-str-attr . objs)
  (let ((table (apply obj*-hclass->hashtable objs)))
    (map car (table->list table))))

(define-rts (py-get-list-of-global*-str-attr . objs)
  (let ((table (apply global*-hclass->hashtable objs)))
    (map car (table->list table))))

;; TODO need some type checks in those dir methods
(define-rts (object-dir self)
  (py-make-list-from-elems
    (if (PyObject? self)
      (py-get-list-of-obj*-str-attr
        self
        (py-obj-cls self))
      ;; Non-PyObject such as fixnums have no attributes
      (py-get-list-of-obj*-str-attr
        (py-obj-cls self)))))

(define-rts object.__dir__
  (procedure->py-function
    object-dir
    (make-signature posonlyargs: (self))))

(define-rts (type-dir self)
  (py-make-list-from-elems
    (py-get-list-of-obj*-str-attr
      self
      (py-obj-cls self))))

(define-rts type.__dir__
  (procedure->py-function
    type-dir
    (make-signature posonlyargs: (self))))

(define-rts (type-repr self)
  (let* ((self-name (py-str-to-scheme (py-own-attr-ref self (& "__name__"))))
         (result (string-append "<class '" self-name "'>")))
    (py-str-from-scheme result)))

(define-rts type.__repr__
  (procedure->py-function
    type-repr
    (make-signature posonlyargs: (self))))

(define-rts (object-repr self)
  (let* ((self-type (py-type self))
         (self-type-name (py-str-to-scheme (py-own-attr-ref self-type (& "__name__"))))
         (addr (integer->hex-string (object->serial-number self)))
         (result (string-append "<" self-type-name " object #" addr ">")))
    (py-str-from-scheme result)))

(define-rts object.__repr__
  (procedure->py-function
    object-repr
    (make-signature posonlyargs: (self))))

(define-rts (object-str self)
  (py-repr self))

(define-rts object.__str__
  (procedure->py-function
    object-str
    (make-signature posonlyargs: (self))))

(define-rts (float->string-with-padded-zeros value)
  (let ((s (number->string value)))
    (cond ((char=? (string-ref s 0) #\.)
           (string-append "0" s))
          ((and (char=? (string-ref s 0) #\-)
                (char=? (string-ref s 1) #\.))
           (string-append "-0" (substring s 1 (string-length s))))
          ((char=? (string-ref s (- (string-length s) 1)) #\.)
           (string-append s "0"))
          (else
           s))))

(define-rts (float-repr self)
  (if (py-subtype-of-float? self)
    (let ((value (py-subtype-of-float-to-scheme self)))
      (cond
        ((infinite? value)
          (if (fl> value 0.) (&& "inf") (&& "-inf")))
        ((nan? value)
           (&& "nan"))
        (else
          (py-str-from-scheme (float->string-with-padded-zeros value)))))
    (py-throw-required-type "__repr__" "float" self)))

(define-rts float.__repr__
  (procedure->py-function
   float-repr
   (make-signature posonlyargs: (self))))

(define-rts (float-int self)
  (if (py-subtype-of-float? self)
      (let ((value (py-subtype-of-float-to-scheme self)))
        (if (flfinite? value)
            (py-int-from-scheme (inexact->exact (fltruncate value)))
            (py-throw-exception-with-message
             py-builtin-OverflowError
             (if (flinfinite? value)
                 "cannot convert float infinity to integer"
                 "cannot convert float NaN to integer"))))
      (py-throw-required-type "__int__" "float" self)))

(define-rts float.__int__
  (procedure->py-function
    float-int
    (make-signature posonlyargs: (self))))

(define-rts (py-display obj port)
  (display (py-str-to-scheme (py-str obj)) port))

(define-rts (py-str obj)
  (let* ((__str__ (getattribute-from-obj-mro obj (& "__str__")))
         (str-instance (py-call __str__ obj)))
    (if (py-subtype-of-str? str-instance)
        str-instance
        (throw-returned-wrong-type "__str__" obj "non-string"))))

(define-rts (py-repr obj)
  (let* ((__repr__ (getattribute-from-obj-mro obj (& "__repr__")))
         (repr (py-call __repr__ obj)))
    (if (py-subtype-of-str? repr)
        repr
        (throw-returned-wrong-type "__repr__" obj "non-string"))))

(define-rts (py-str-repr-scheme str)
  (let* ((quote-style #f)
         (chars (string->list str)))
    (for-each (lambda (c)
                (cond ((char=? c #\")
                       (set! quote-style #\'))
                      ((and (char=? c #\') (not (eqv? quote-style #\')))
                       (set! quote-style #\"))))
              chars)
    (if (not quote-style)
        (set! quote-style #\'))
    (let ((content
           (append-strings
                  (map (lambda (c)
                         (if (char=? c quote-style)
                             (string #\\ quote-style)
                             (let ((n (char->integer c)))
                               (cond ((= n 9)   "\\t")
                                     ((= n 10)  "\\n")
                                     ((= n 13)  "\\r")
                                     ((and (>= n 888)
                                           (or (>= n 1024)
                                               (<= n 889)
                                               (and (>= n 896) (<= n 899))
                                               (= n 907)
                                               (= n 909)
                                               (= n 930)))
                                      (string-append "\\u"
                                                     (substring (number->string (+ #x100000000 n) 16) 5 9)))
                                     ((or (< n 32)
                                          (and (>= n 127) (<= n 160))
                                          (= n 173))
                                      (string-append "\\x"
                                                     (substring (number->string (+ #x100 n) 16) 1 3)))
                                     (else
                                      (string c))))))
                       chars)))
          (quotes
           (string quote-style)))
      (string-append quotes content quotes))))

(define-rts (py-chr i)
  (if (py-subtype-of-int? i)
      (let ((value (py-subtype-of-int-to-scheme i)))
        (py-str-from-scheme (string (integer->char value))))
      (let* ((i-type (py-type i))
             (i-type-name (py-own-attr-ref i-type (& "__name__"))))
        (py-throw
         (py-call
          py-builtin-TypeError
          (py-str-from-scheme
           (string-append
            "an integer is required (got type "
            i-type-name
            ")")))))))

;; =============================================================================
;;  Generators
;; =============================================================================

(define-rts (py-make-generator proc)
  (make-PyObjectGenerator
    py-generator-hclass-of-instances
    '#()
    py-generator-class
    proc))

;; TODO add checks that methods are called with correct types

(define-rts (py-generator-send self value)
  (py-generator-next self value))

(define-rts generator.send
  (procedure->py-function
    py-generator-send
    (make-signature posonlyargs: (self value))))

(define-rts (py-generator-throw self type value traceback)
  (let ((cont (PyObjectGenerator-continuation self)))
    (cond
      ((procedure? cont) ;; active and ready
        (PyObjectGenerator-continuation-set! self #t)
        (cont #f (vector type value traceback)))
      (cont ;; active, but running
        (py-throw-exception-with-message
          py-builtin-ValueError
          "generator is already executing"))
      (else ;; closed
        (py-throw-with-values type value)))))

(define-rts generator.throw
  (procedure->py-function
    py-generator-throw
    (make-signature
      posonlyargs: (self type value traceback)
      defaults: '#(#f #f))))

(define-rts (py-throw-from-generator-exception-info exc-info)
  (let ((exc (vector-ref exc-info 0))
        (exc-val (vector-ref exc-info 1))
        (exc-tb (vector-ref exc-info 2)))
    (if exc-val
      (py-throw-with-values exc exc-val)
      (py-throw exc))))


(define-rts (py-generator-close self)
  (let ((cont (PyObjectGenerator-continuation self)))
    (cond
      ((procedure? cont) ;; active and ready
        (py-try-except
          (lambda (e)
            (if (or (py-isinstance? e py-builtin-StopIteration)
                    (py-isinstance? e py-builtin-GeneratorExit))
              (begin
                (py-generator-end self)
                py-None)
              (py-throw e)))
          (lambda ()
            (PyObjectGenerator-continuation-set! self #t)
            (cont #f (vector py-builtin-GeneratorExit #f #f))
            (py-throw-exception-with-message py-builtin-RuntimeError "generator ignored GeneratorExit"))))
      (cont ;; active, but running
        (py-throw-exception-with-message
          py-builtin-ValueError
          "generator is already executing"))
      (else ;; closed
        py-None))))

(define-rts generator.close
  (procedure->py-function
    py-generator-close
    (make-signature
      posonlyargs: (self))))

(define-rts (py-generator-next-fallback self)
  (py-generator-next self))

(define-rts generator.__next__
  (procedure->py-function
    py-generator-next-fallback
    (make-signature posonlyargs: (self))))

(define-rts generator.__iter__
  (procedure->py-function
    (lambda (self) self)
    (make-signature posonlyargs: (self))))

(define-rts (py-generator-new cls)
  (py-throw-exception-with-message
    py-builtin-TypeError
    "cannot create 'generator' instances"))

(define-rts generator.__new__
  (procedure->py-function
    py-generator-new
    (make-signature posonlyargs: (cls))))

;; =============================================================================
;;  BUILTIN CLASSES
;; =============================================================================

;; core types (must be created in 1st bootstrap phase)
(define-rts py-object-class #f)
(define-rts py-type-class   #f)
(define-rts py-str-class    #f)
(define-rts py-tuple-class  #f)
(define-rts py-int-class #f)
(define-rts py-bool-class #f)
(define-rts py-float-class #f)

(define-rts py-bytearray-class #f)
(define-rts py-complex-class #f)
(define-rts py-slice-class  #f)
(define-rts py-method-class #f)
(define-rts py-function-class #f)
(define-rts py-list-class   #f)
(define-rts py-dict-class   #f)
(define-rts py-set-class    #f)
(define-rts py-module-class #f)
(define-rts py-generator-class #f)

;;;----------------------------------------------------------------------------

(define-rts (py-int-from-scheme-fallback value)
  (py-if-specialized-sint-representation
   (if (fixnum? value) value (py-bint-from-scheme value))
   (alloc-new-PyObjectInt-from-scheme value)))

(define-rts (py-bint-from-scheme-fallback value)
  (alloc-new-PyObjectInt-from-scheme value))

(define-rts (py-subtype-of-int-from-scheme value int-subclass)
  ;; int-subclass is known to not be int-class
  (make-PyObjectInt
    (PyObjectType-hclass-of-instances int-subclass)
    '#()
    int-subclass
    value))

(define-rts (py-float-from-scheme-fallback value)
  (py-if-specialized-float-representation
   value
   (make-PyObjectFloat
    py-float-hclass-of-instances
    '#()
    py-builtin-float
    value)))

(define-rts (py-subtype-of-float-from-scheme value float-subclass)
  ;; float-subclass is known to not be float-class
  (make-PyObjectFloat
    (PyObjectType-hclass-of-instances float-subclass)
    '#()
    float-subclass
    value))

(define-rts (py-set-from-scheme elems)
  (py-throw-exception-with-message
    py-builtin-NameError
    "py-set-from-scheme not implemented"))

(define-rts (py-bytearray-from-scheme len-vec-pair)
  (make-PyObjectBytearray
    py-bytearray-hclass-of-instances
    '#()
    py-bytearray-class
    len-vec-pair))

(define-rts (py-bytearray-subtype-from-scheme len-vec-pair bytearray-subtype)
  (make-PyObjectBytearray
    (PyObjectType-hclass-of-instances bytearray-subtype)
    '#()
    bytearray-subtype
    len-vec-pair))

;; Bootstraps type and object
;; Create barebone object, type, str and tuple classes
;; These will need to be filled in later
(define-rts (bootstrap-type-hierarchy-phase1)
  (let* ((type-class
          (py-builtin-type-alloc
            #f ;; cls
            (get-behavior-type-index type)
            #f ;; can-have-getter
            #f ;; bases
            #f ;; mro
            #f)) ;; NOTE: this is ok! each type should have a different hclass for attribute caching purpose
                 ;; for this reasons there is no "py-type-hclass-of-instances"
        (object-class
          (py-builtin-type-alloc
            #f ;; cls
            (get-behavior-type-index object)
            #f ;; can-have-getter
            #f ;; bases
            #f ;; mro
            py-object-hclass-of-instances))
        (str-class
          (py-builtin-type-alloc
            #f ;; cls
            (get-behavior-type-index str)
            #f ;; can-have-getter
            #f ;; bases
            #f ;; mro
            py-str-hclass-of-instances))
        (tuple-class
          (py-builtin-type-alloc
            #f ;; cls
            (get-behavior-type-index tuple)
            #f ;; can-have-getter
            #f ;; bases
            #f ;; mro
            py-tuple-hclass-of-instances)))

    (set! py-object-class object-class)
    (set! py-type-class type-class)
    (set! py-str-class str-class)
    (set! py-tuple-class tuple-class)

    ;; init all object (& ...) to a py-str object
    (init-registered-constants)

    ;; set the magic-index (for attribute fast access on types) on magic attributes (__add__, __next__, etc.)
    (fill-representatives-magic-index)

    ;; Fill in object class
    (PyObject-class-set! object-class type-class)
    (PyObjectType-bases-set! object-class '#())
    (PyObjectType-mro-set! object-class (vector object-class))
    (py-own-attr-set! object-class (& "__name__") (&& "object"))
    (py-own-attr-set! object-class (& "__module__") (&& "builtins"))
    (py-own-attr-set! object-class (& "__new__") object.__new__)
    (py-own-attr-set! object-class (& "__init__") object.__init__)
    (py-own-attr-set! object-class (& "__getattribute__") object.__getattribute__)
    (py-own-attr-set! object-class (& "__setattr__") object.__setattr__)
    (py-own-attr-set! object-class (& "__repr__") object.__repr__)
    (py-own-attr-set! object-class (& "__str__") object.__str__)
    (py-own-attr-set! object-class (& "__dir__") object.__dir__)


    ;; Fill in type class
    (PyObject-class-set! type-class type-class)
    (PyObjectType-bases-set! type-class (vector object-class))
    (PyObjectType-mro-set! type-class (vector type-class object-class))
    (py-own-attr-set! type-class (& "__name__") (&& "type"))
    (py-own-attr-set! type-class (& "__module__") (&& "builtins"))
    (py-own-attr-set! type-class (& "__new__") type.__new__)
    (py-own-attr-set! type-class (& "__call__") type.__call__)
    (py-own-attr-set! type-class (& "__setattr__") type.__setattr__)
    (py-own-attr-set! type-class (& "__getattribute__") type.__getattribute__)
    (py-own-attr-set! type-class (& "__dir__") type.__dir__)
    (py-own-attr-set! type-class (& "__repr__") type.__repr__)

    ;; Fill in tuple class
    (PyObject-class-set! tuple-class type-class)
    (PyObjectType-bases-set! tuple-class (vector object-class))
    (PyObjectType-mro-set! tuple-class (vector tuple-class object-class))
    (py-own-attr-set! tuple-class (& "__name__") (&& "tuple"))
    (py-own-attr-set! tuple-class (& "__module__") (&& "builtins"))
    (py-own-attr-set! tuple-class (& "__new__") tuple.__new__)

    ;; Fill in str class
    (PyObject-class-set! str-class type-class)
    (PyObjectType-bases-set! str-class (vector object-class))
    (PyObjectType-mro-set! str-class (vector str-class object-class))
    (py-own-attr-set! str-class (& "__name__") (&& "str"))
    (py-own-attr-set! str-class (& "__module__") (&& "builtins"))
    (py-own-attr-set! str-class (& "__new__") str.__new__)
    (py-own-attr-set! str-class (& "__hash__") str.__hash__)
    (py-own-attr-set! str-class (& "__repr__") str.__repr__)
    (py-own-attr-set! str-class (& "__getitem__") str.__getitem__)
    (py-own-attr-set! str-class (& "__str__") str.__str__)
    (py-own-attr-set! str-class (& "lower") str.lower)))

(bootstrap-type-hierarchy-phase1)

(define-rts (py-getitem-listX-sintY-fallback obj item)
  (py-getitem-listX-sintY obj item))

(define-rts (py-getitem-listX-boolY-fallback obj item)
  (py-getitem-listX-boolY obj item))

(define-rts (py-getitem-listX-sliceY-fallback obj item)
  (py-getitem-listX-sliceY obj item))

(define-rts (py-getitem-tupleX-sintY-fallback obj item)
  (py-getitem-tupleX-sintY obj item))

(define-rts (py-getitem-tupleX-boolY-fallback obj item)
  (py-getitem-tupleX-boolY obj item))

(define-rts (py-getitem-tupleX-sliceY-fallback obj item)
  (py-getitem-tupleX-sliceY obj item))

(define-rts (py-getitem-strX-sintY-fallback obj item)
  (py-getitem-strX-sintY obj item))

(define-rts (py-getitem-strX-boolY-fallback obj item)
  (py-getitem-strX-boolY obj item))

(define-rts (py-getitem-strX-sliceY-fallback obj item)
  (py-getitem-strX-sliceY obj item))

(define-rts (py-setitem-listX-sintY-Z-fallback obj item value)
  (py-setitem-listX-sintY-Z obj item value))

;; adds top-level behavior tables
(init-behavior-dispatch-vector)

(define-rts (py-compute-mro cls)

  (define seen '())

  (define (add-class cls classes)
    (if (memq cls seen)
        classes
        (begin
          (set! seen (cons cls seen))
          (cons cls (add-bases (PyObjectType-bases cls) classes)))))

  (define (add-bases bases classes)
    (let loop ((i (- (vector-length bases) 1)) (classes classes))
      (if (< i 0)
          classes
          (loop (- i 1) (add-class (vector-ref bases i) classes)))))

  (list->vector (add-class cls '())))

(define-rts (py-class-parse-attributes attrs)
  (let loop ((lst attrs)
             (rev-attr-names '())
             (rev-attr-values '()))
    (if (and (pair? lst) (pair? (cdr lst)))
      (let ((name (car lst))
            (value (cadr lst))
            (rest (cddr lst)))
        (if (eq? value py-absent)
          (loop rest
                rev-attr-names
                rev-attr-values)
          (loop rest
                (cons name rev-attr-names)
                (cons value rev-attr-values))))
      (cons (reverse rev-attr-names) (reverse rev-attr-values)))))


(define-rts (py-make-class-from-type-allocator class-index can-have-getter name module bases type-allocator attrs)
  (define (make-cls attr-names attr-values)
    (let* ((bases-vect
            (if (null? bases)
              (vector py-object-class)
              (list->vector bases)))
           (cls (type-allocator py-type-class class-index can-have-getter bases-vect #f #f)))
      (PyObjectType-mro-set! cls (py-compute-mro cls))
      ;; NOTE: objects for different classes MUST have different classes for attributes caching
      (PyObjectType-hclass-of-instances-set!
        cls
        (make-HClass '#() '()))
      (let loop ((attr-names attr-names) (attr-values attr-values))
        (if (pair? attr-names)
            (begin
              (py-own-attr-set! cls (car attr-names) (car attr-values))
              (loop (cdr attr-names) (cdr attr-values)))))
      (py-own-attr-set! cls
        (& "__module__")
        module)
      (py-own-attr-set! cls
        (& "__name__")
        name)
      cls))
    (let ((parsed-attrs (py-class-parse-attributes attrs)))
      (make-cls (car parsed-attrs) (cdr parsed-attrs))))

(define-rts (py-make-class name module bases . attrs)
  (py-make-class-from-type-allocator (get-behavior-type-index default) #t name module bases py-type-alloc attrs))

(define-rts (py-make-builtin-class-with-class-info class-index can-have-getter name module bases hclass-of-instances . attrs)
  (let ((cls
          (py-make-class-from-type-allocator
            class-index can-have-getter name module bases py-builtin-type-alloc attrs)))
    (PyObjectType-hclass-of-instances-set! cls hclass-of-instances)
    cls))

(define-rts (py-extend-builtin-core-class cls . attrs)
  (define (extend-cls attr-names attr-values)
    (let loop ((attr-names attr-names) (attr-values attr-values))
      (if (pair? attr-names)
        (begin
          (py-own-attr-set! cls (car attr-names) (car attr-values))
          (loop (cdr attr-names) (cdr attr-values)))))
        cls)

  (let ((parsed-attrs (py-class-parse-attributes attrs)))
    (extend-cls (car parsed-attrs) (cdr parsed-attrs))))
;; ================
;; MODULE FUNCTIONS
;; ================


(define-rts (module-dir self)
  (if (py-isinstance? self py-module-class)
    (py-make-list-from-elems
        (py-get-list-of-global*-str-attr self))
    (throw-returned-wrong-type "__dir__" self "not a module")))

(define-rts module.__dir__
  (procedure->py-function
    module-dir
    (make-signature posonlyargs: (self))))


(define-rts (module-getattribute obj name #!optional (raise? #t) (cache #f))
  (define (getattribute-from-mro #!optional (index-of-hit-on-module #f))
    (getattribute-from-obj-mro-with-owner-2cont
      obj
      name
      (lambda (cls-attr owner)
        (if index-of-hit-on-module
          (if cache (AttributeCache-module-or-mro-hit! cache (py-obj-hclass obj) index-of-hit-on-module cls-attr owner))
          (if cache (AttributeCache-mro-hit! cache (py-obj-hclass obj) cls-attr owner)))
        (py-descriptor-get cls-attr obj owner))
     (lambda ()
        (and raise? (py-throw-module-getattribute-error obj name)))))

  (if (py-isinstance? obj py-module-class)
    (if (py-isinstance? name py-builtin-str)
      (py-own-attr-index-2cont
        obj
        name
        (lambda (index)
          (let ((val (PyObject-global-elements-ref obj index)))
            (if val
              (begin
                (if cache (AttributeCache-module-hit! cache (py-obj-hclass obj) index))
                val)
              (getattribute-from-mro index))))
        getattribute-from-mro)
      (py-throw-exception-with-message
       py-builtin-TypeError
       "attribute name must be string"))
    (throw-returned-wrong-type "__getattribute__" obj "not a module")))

(define-rts module.__getattribute__
  (procedure->py-function
    module-getattribute
    (make-signature posonlyargs: (self name))))


(define-rts (module-setattr self name val)
  (if (py-isinstance? self py-module-class)
      (if (py-isinstance? name py-builtin-str)
        (begin
          (global-own-attr-put-no-cache! self name val)
          py-None)
        (py-throw-exception-with-message
         py-builtin-TypeError
         "attribute name must be string"))
      (throw-returned-wrong-type "__setattr__" self "not a module")))

(define-rts module.__setattr__
  (procedure->py-function
    module-setattr
    (make-signature posonlyargs: (self name val))))

;; list iterator

(define-rts (list-iterator-iter self)
  (if (eq? (py-type self) py-list-iterator-class)
    self
    (py-throw-exception-with-message py-builtin-TypeError "pending error message (code 6)")))

(define-rts list_iterator.__iter__
  (procedure->py-function
    list-iterator-iter
    (make-signature posonlyargs: (self))))

(define-rts (list-iterator-next-procedure self)
  (if (eq? (py-type self) py-list-iterator-class)
    (list-iterator-next self #t) ;; #t second argument indicates to raise StopIteration at end of iterator
    (py-throw-exception-with-message py-builtin-TypeError "pending error message (code 7)")))

(define-rts list_iterator.__next__
  (procedure->py-function
    list-iterator-next-procedure
    (make-signature posonlyargs: (self))))

(define-rts py-list-iterator-class
  (py-make-builtin-class
    (&& "list_iterator")
    (&& "builtins")
    (list)
      (& "__iter__") list_iterator.__iter__
      (& "__next__") list_iterator.__next__))

(define-rts (tuple-iterator-iter self)
  (if (eq? (py-type self) py-tuple-iterator-class)
    self
    (py-throw-exception-with-message py-builtin-TypeError "pending error message (code 8)")))

(define-rts py-tuple-iterator-iter
  (procedure->py-function
    tuple-iterator-iter
    (make-signature posonlyargs: (self))))

(define-rts (tuple-iterator-next-procedure self)
  (if (eq? (py-type self) py-tuple-iterator-class)
    (tuple-iterator-next self #t) ;; second argument indicates to raise StopIteration at end of iterator
    (py-throw-exception-with-message py-builtin-TypeError "pending error message (code 9)")))

(define-rts py-tuple-iterator-next
  (procedure->py-function
    tuple-iterator-next-procedure
    (make-signature posonlyargs: (self))))

(define-rts py-tuple-iterator-class
  (py-make-builtin-class
    (&& "tuple_iterator")
    (&& "builtins")
    (list)
      (& "__iter__") py-tuple-iterator-iter
      (& "__next__") py-tuple-iterator-next))

(define-rts (stop-bytearray-iterator iterator)
  (PyObjectBytearrayIterator-index-set! iterator #f)
  (py-throw py-builtin-StopIteration))

(define-rts (bytearray-iterator-iter self)
  (if (eq? (py-type self) py-bytearray-iterator-class)
    self
    (py-throw-exception-with-message py-builtin-TypeError "pending error message (code 10)")))

(define-rts py-bytearray-iterator.__iter__
  (procedure->py-function
    bytearray-iterator-iter
    (make-signature posonlyargs: (self))))

(define-rts (bytearray-iterator-next self)
  (if (eq? (py-type self) py-bytearray-iterator-class)
    (let* ((index (PyObjectBytearrayIterator-index self))
           (vec (PyObjectBytearrayIterator-bytearray self)))
      (if (and index (< index (car vec)))
        (let ((item (u8vector-ref (cdr vec) index)))
          (begin
            (PyObjectBytearrayIterator-index-set! self (+ index 1))
            (py-int-from-scheme item)))
        (stop-bytearray-iterator self)))
    (py-throw-exception-with-message py-builtin-TypeError "pending error message (code 11)")))


(define-rts py-bytearray-iterator.__next__
  (procedure->py-function
    bytearray-iterator-next
    (make-signature posonlyargs: (self))))

(define-rts py-bytearray-iterator-class
  (py-make-builtin-class
    (&& "bytearray_iterator")
    (&& "builtins")
    (list)
      (& "__iter__") py-bytearray-iterator.__iter__
      (& "__next__") py-bytearray-iterator.__next__))

;; ======================
;; Dynamic vector helper
;; =====================
;; These classes are used for lists and bytearrays
;; list class

(define-rts (index-in-length-range index len)
  (and (< index len) (>= index (- len))))

(define-rts (py-index-in-subvector item vec start stop)
  (let loop ((i start))
    (cond
      ((>= i stop)
        #f)
      ((py-test (py-eq (vector-ref vec i) item))
        i)
      (else
        (loop (+ i 1))))))

(define-rts (list-new cls iterable)
  (if (or (eq? cls py-list-class) (py-issubclass? cls py-list-class))
      (if (eq? iterable py-absent)
          (py-list-subtype-from-scheme cls '#() 0)
          (let ((iterable-type (py-type iterable)))
           (cond
             ((eq? iterable-type py-tuple-class)
              (let ((vec (PyObjectTuple-value iterable)))
               (py-list-subtype-from-scheme
                 cls
                 (py-make-list-from-vec vec)
                 (vector-length vec))))
             ((eq? iterable-type py-list-class)
               (py-list-subtype-from-scheme
                 cls
                 (vector-copy (PyObjectList-vector iterable))
                 (PyObjectList-len iterable)))
             (else
               (let* ((iterator (py-iter iterable))
                      (content (list->vector (iterator->list iterator))))
                 (py-list-subtype-from-scheme
                   cls
                   content
                   (vector-length content)))))))
      (py-throw-wrong-new-argument "list" cls)))

(define-rts list.__new__
  (procedure->py-function
    list-new
    (make-signature posonlyargs: (cls value) defaults: (vector py-absent))))

(define-rts (list-iter self)
  (if (py-isinstance? self py-list-class)
    (py-list-iterator-alloc 0 self)
    (py-throw-not-a-type-object "list.__iter__" self)))

(define-rts list.__iter__
  (procedure->py-function
    list-iter
    (make-signature posonlyargs: (self))))

;; TODO: use list real length instead of vector-length
;; otherwise this will crash once list is an actual dynamic array
(define-rts (list-contains self item)
  (if (py-isinstance? self py-list-class)
    (let* ((len (PyObjectList-len self))
           (vec (PyObjectList-vector self)))
      (let loop ((i 0))
        (if (< i len)
          (if (py-test (py-eq item (vector-ref vec i)))
            py-True
            (loop (+ i 1)))
          py-False)))
    (py-throw-not-a-type-object "list.__contains__" self)))

(define-rts list.__contains__
  (procedure->py-function
    list-contains
    (make-signature posonlyargs: (self item))))

;; TODO: print cyclic structures
(define-rts (list-repr self)
  (if (py-isinstance? self py-list-class)
    (let* ((len (PyObjectList-len self))
           (vec (PyObjectList-vector self))
           (content-strs (vector-map py-repr (subvector vec 0 len)))
           (content-strings
            (vector-map (lambda (x) (py-subtype-of-str-to-scheme x))
                        content-strs)))
      (py-str-from-scheme
        (string-append
          "["
          (string-join-vector ", " content-strings)
          "]")))
    (py-throw-not-a-type-object "list.__repr__" self)))

(define-rts list.__repr__
  (procedure->py-function
    list-repr
    (make-signature posonlyargs: (self))))

(define-rts (list-add self other)
  (if (py-isinstance? self py-list-class)
    (if (py-isinstance? other py-list-class)
      (py-add-listX-listY-inline self other)
      py-NotImplemented)
    (py-throw-not-a-type-object "list.__add__" self)))

(define-rts list.__add__
  (procedure->py-function
    list-add
    (make-signature posonlyargs: (self other))))

(define-rts (list-mul self n)
  (if (py-isinstance? self py-list-class)
    (if (py-subtype-of-int? n)
      (py-mul-listX-UintY self (py-subtype-of-int-to-scheme n))
      py-NotImplemented)
    (py-throw-not-a-type-object "list.__mul__" self)))

(define-rts list.__mul__
  (procedure->py-function
    list-mul
    (make-signature posonlyargs: (self n))))

(define-rts list.__rmul__
  (procedure->py-function
    list-mul
    (make-signature posonlyargs: (self n))))

(define-rts (list-imul self n)
  (if (py-isinstance? self py-list-class)
      (if (py-subtype-of-int? n)
        (let ((res (py-mul-listX-UintY self (py-subtype-of-int-to-scheme n))))
          (PyObjectList-vector-set! self (PyObjectList-vector res))
          (PyObjectList-len-set! self (PyObjectList-len res))
          self)
        py-NotImplemented)
      (py-throw-not-a-type-object "list.__mul__" self)))

(define-rts list.__imul__
  (procedure->py-function
    list-imul
    (make-signature posonlyargs: (self n))))

(define-rts (list-len self)
  (if (py-isinstance? self py-list-class)
    (py-int-from-scheme (PyObjectList-len self))
    (py-throw-not-a-type-object "list.__len__" self)))

(define-rts list.__len__
  (procedure->py-function
    list-len
    (make-signature posonlyargs: (self))))

(define-macro (define-list-binary-comparator name py-name py-compare)
  `(begin
    (define-rts (,name self other)
      (if (py-isinstance? self py-list-class)
        (if (py-isinstance? other py-list-class)
          (,py-compare self other)
          py-NotImplemented)
        (py-throw-not-a-type-object ,(symbol->string py-name) self)))

    (define-rts ,py-name
      (procedure->py-function
        ,name
        (make-signature posonlyargs: (self other))))))

(define-list-binary-comparator list-eq list.__eq__ py-eq-listX-listY)

(define-list-binary-comparator list-ne list.__ne__ py-ne-listX-listY)

(define-list-binary-comparator list-lt list.__lt__ py-lt-listX-listY)

(define-list-binary-comparator list-le list.__le__ py-le-listX-listY)

(define-list-binary-comparator list-gt list.__gt__ py-gt-listX-listY)

(define-list-binary-comparator list-ge list.__ge__ py-ge-listX-listY)

;; NOTE: follows requirements of slice.indices(len)
(define-rts (py-slice-indices slice len)
  (let* ((py-start (PyObjectSlice-start slice))
         (py-stop (PyObjectSlice-stop slice))
         (py-step (PyObjectSlice-step slice))
         (step
           (cond
             ((eq? py-step py-None) (py-int-from-scheme 1))
             ((py-test-eq py-step (py-int-from-scheme 0))
              (py-throw (py-call py-builtin-ValueError (&& "slice step cannot be zero"))))
             ((py-subtype-of-int? py-step)
                (py-subtype-of-int-to-scheme py-step))
             (else (py-throw-wrong-index-type "slice" "integers or None" py-step))))
         (start
           (cond
             ((eq? py-start py-None) (if (> step 0) 0 (- len 1)))
             ((py-subtype-of-int? py-start)
                (let ((i (py-subtype-of-int-to-scheme py-start)))
                  (if (< i 0) (+ len i) i)))
             (else (py-throw-wrong-index-type "slice" "integers or None" py-start))))
         (stop
           (cond
             ((eq? py-stop py-None) (if (> step 0) len -1))
             ((py-subtype-of-int? py-stop)
                (let ((i (py-subtype-of-int-to-scheme py-stop)))
                  (if (< i 0) (+ len i) i)))
             (else (py-throw-wrong-index-type "slice" "integers or None" py-stop))))
         (first
           (if (> step 0)
              (if (>= start len)
                #f
                (max 0 start))
              (if (< start 0)
                #f
                (min (- len 1) start)))))
    (if first
      (let ((last
             (if (> step 0)
                (max 0 (min len stop))
                (max -1 (min (- len 1) stop)))))
        (vector first last step))
      (vector 0 0 step))))

(define-rts (list-getitem self item)
  (if (py-isinstance? self py-list-class)
    (cond
      ((py-subtype-of-int? item)
        (py-getitem-listX-sintY self item))
      ((py-isinstance? item py-slice-class)
        (py-getitem-listX-sliceY self item))
      (else (py-throw-wrong-index-type "list" "integers or slices" item)))
    (py-throw-not-a-type-object "list.__getitem__" self)))

(define-rts list.__getitem__
  (procedure->py-function
    list-getitem
    (make-signature posonlyargs: (self item))))


(define-rts (list-set-simple-slice! lst start stop vec len)
  (let* ((self-vec (PyObjectList-vector lst))
         (slice-len (- stop start))
         (len-diff (- slice-len len)))
    (cond
     ((< len-diff 0)
      (list-shift-right-by! lst start (- len-diff)))
     ((> len-diff 0)
      (list-shift-left-by! lst start len-diff)))
    ;; Update the vector which may have been updated when shifting
    (set! self-vec (PyObjectList-vector lst))
    (let loop ((source 0) (target start))
      (if (< source len)
          (begin
            (vector-set! self-vec target (vector-ref vec source))
            (loop (+ source 1) (+ target 1)))))))

(define-rts (list-set-extended-slice! lst start stop step vec len)
  (let ((self-vec (PyObjectList-vector lst))
         (slice-len (get-slice-length start stop step)))

    (if (= len slice-len)
      (let loop ((source 0) (target start))
        (if (< source len)
          (begin
            (vector-set! self-vec target (vector-ref vec source))
            (loop (+ source 1) (+ target step)))))
      (py-throw-extended-slice-wrong-len len slice-len))))

(define-rts (list-set-slice self slice value)
  (let* ((self-len (PyObjectList-len self))
        (indices (py-slice-indices slice self-len))
        (start (vector-ref indices 0))
        (stop (vector-ref indices 1))
        (step (vector-ref indices 2))
        (value-type (py-type value)))
    (cond
      ((eq? value-type py-list-class)
        (let* ((value-len (PyObjectList-len value))
              (value-vec (PyObjectList-vector value)))
          (if (eq? step 1)
            (list-set-simple-slice! self start stop value-vec value-len)
            (list-set-extended-slice! self start stop step value-vec value-len))))
      ((eq? value-type py-tuple-class)
        (let* ((value-vec (PyObjectTuple-value value))
               (value-len (vector-length value-vec)))
          (if (eq? step 1)
            (list-set-simple-slice! self start stop value-vec value-len)
            (list-set-extended-slice! self start stop step value-vec value-len))))
      (else
        (let ((iterator (py-obj->iterator value)))
          (if iterator
            (let* ((value-vec (list->vector (iterator->list iterator)))
                  (value-len (vector-length value-vec)))
              (if (eq? step 1)
                (list-set-simple-slice! self start stop value-vec value-len)
                (list-set-extended-slice! self start stop step value-vec value-len)))
            (py-throw-can-only-assign-iterable)))))))

(define-rts (list-setitem self item value)
  (if (py-isinstance? self py-list-class)
    (cond
      ((py-subtype-of-int? item)
        (let* ((len (PyObjectList-len self))
               (vec (PyObjectList-vector self))
               (i (py-subtype-of-int-to-scheme item)))
          (if (index-in-length-range i len)
            (vector-set! vec (modulo i len) value)
            (py-throw-assignment-index-out-of-range "list"))))
      ((py-isinstance? item py-slice-class)
        (list-set-slice self item value))
      (else (py-throw-wrong-index-type "list" "integers or slices" item)))
    (py-throw-not-a-type-object "list.__setitem__" self))
  py-None)

(define-rts list.__setitem__
  (procedure->py-function
    list-setitem
    (make-signature posonlyargs: (self item value))))

(define-rts (list-shrink! list)
   (let* ((len (PyObjectList-len list))
	  (vec (PyObjectList-vector list))
	  (new-inner-len (list-get-inner-len len)))
      (when (fx< new-inner-len (vector-length vec))
	 (vector-shrink! vec new-inner-len))
      vec))

(define-rts (list-grow! list)
  (list-grow-by! list 1))

(define-rts (list-grow-by! list amount)
  (let* ((len (PyObjectList-len list))
        (vec (PyObjectList-vector list))
        (new-inner-len (list-get-inner-len (+ len amount)))
        (new-vector (vector-append vec (make-vector (- new-inner-len len) #f))))
    (PyObjectList-vector-set!
      list
      new-vector)
    new-vector))

(define-rts (list-shift-left! lst index)
  (let ((len (PyObjectList-len lst))
        (vec (PyObjectList-vector lst)))
    (let loop ((i index))
      (if (fx< i len)
        (begin
          (vector-set! vec (fx- i 1) (vector-ref vec i))
          (loop (fx+ i 1)))))
    (vector-set! vec (fx- len 1) #f)
    (PyObjectList-len-set! lst (fx- len 1))
    (if (fx< len (list-get-shrink-threshold (vector-length vec)))
      (list-shrink! lst))))

(define-rts (list-shift-left-by! lst index amount)
  (if (> amount 0)
    (let ((len (PyObjectList-len lst))
          (vec (PyObjectList-vector lst)))
      (let loop ((i (max index amount)))
        (if (< i len)
          (begin
            (vector-set! vec (- i amount) (vector-ref vec i))
            (vector-set! vec i #f)
            (loop (+ i 1)))))
      (vector-set! vec (- len 1) #f)
      (PyObjectList-len-set! lst (- len amount))
      (if (< len (list-get-shrink-threshold (vector-length vec)))
        (list-shrink! lst)))))

;; NOTE: shift-right does not insert #f at index
;;       it is assumed shift is done with intent to write at index
(define-rts (list-shift-right! list index)
  (let ((len (PyObjectList-len list))
        (vec (PyObjectList-vector list)))
    (if (= len (vector-length vec))
      (set! vec (list-grow! list)))
    (let loop ((i len))
      (if (> i index)
        (begin
          (vector-set! vec i (vector-ref vec (- i 1)))
          (loop (- i 1)))))
    (PyObjectList-len-set! list (+ len 1))))

(define-rts (list-shift-right-by! lst index amount)
  (if (> amount 0)
    (let ((len (PyObjectList-len lst))
          (vec (PyObjectList-vector lst)))
      (if (>= (+ amount len) (vector-length vec))
        (set! vec (list-grow-by! lst amount)))
      (let loop ((i (+ amount len -1)))
        (if (>= (- i amount) index)
          (begin
            (vector-set! vec i (vector-ref vec (- i amount)))
            (loop (- i 1)))))
      (PyObjectList-len-set! lst (+ len amount)))))

(define-rts (list-pop-last! lst)
  (let* ((len (PyObjectList-len lst))
        (vec (PyObjectList-vector lst))
        (last-index (- len 1))
        (last (vector-ref vec last-index)))
    (vector-set! vec last-index #f)
    (PyObjectList-len-set! lst last-index)
    (if (< len (list-get-shrink-threshold (vector-length vec)))
      (list-shrink! lst))
      last))

(define-rts (list-del-extended-slice! lst start stop step)
  (let* ((len (PyObjectList-len lst))
        (vec (PyObjectList-vector lst))
        (slice-len (get-slice-length start stop step))
        (abs-step (abs step))
        (first
          (if (> step 0)
            start
            (+ start (* (- slice-len 1) step))))
        (last (+ first (* (- slice-len 1) abs-step))))
    ;; copy all values but skips the ones to be erased
    (let loop ((read-index first) (write-index first))
      (if (<= read-index last)
        (if (= 0 (modulo (- read-index first) abs-step))
          (loop (+ read-index 1) write-index)
          (begin
            (vector-set! vec write-index (vector-ref vec read-index))
            (loop (+ read-index 1) (+ write-index 1))))
        ;; shift-left handles shrink
        (list-shift-left-by! lst read-index slice-len)))))

(define-rts (list-delitem self item)
  (if (py-isinstance? self py-list-class)
    (cond
      ((py-subtype-of-int? item)
        (let* ((len (PyObjectList-len self))
               (i (py-subtype-of-int-to-scheme item)))
          (if (index-in-length-range i len)
            (list-shift-left! self (+ (modulo i len) 1))
            (py-throw-action-out-of-range "list" "assignement"))))
      ((py-isinstance? item py-slice-class)
        (let* ((len (PyObjectList-len self))
              (indices (py-slice-indices item len))
              (start (vector-ref indices 0))
              (stop (vector-ref indices 1))
              (step (vector-ref indices 2)))
          (if (= step 1)
            (let ((size (- stop start)))
              (list-shift-left-by! self stop size))
            (list-del-extended-slice! self start stop step))))
      (else (py-throw-wrong-index-type "list" "integers or slices" item)))
    (py-throw-not-a-type-object "list.__delitem__" self))
  py-None)

(define-rts list.__delitem__
  (procedure->py-function
    list-delitem
    (make-signature posonlyargs: (self item))))

(define-rts (list-pop self index)
  (if (py-isinstance? self py-list-class)
    (cond
      ((eq? index py-absent)
        (let ((len (PyObjectList-len self)))
          (if (> len 0)
            (list-pop-last! self)
            (py-throw-pop-from-empty-list))))
      ((py-subtype-of-int? index)
        (let* ((len (PyObjectList-len self))
               (vec (PyObjectList-vector self))
               (i (py-subtype-of-int-to-scheme index)))
          (if (index-in-length-range i len)
            (let* ((real-i (modulo i len))
                   (element (vector-ref vec real-i)))
              (list-shift-left! self (+ real-i 1))
              element)
            (py-throw-action-out-of-range "list" "pop"))))
      ((py-isinstance? index py-slice-class)
        (py-throw-exception-with-message py-builtin-NotImplementedError "list-delitem slice not implemented"))
      (else (py-throw-wrong-index-type "list" "integers" index)))
    (py-throw-not-a-type-object "list.pop" self)))

(define-rts list.pop
  (procedure->py-function
    list-pop
    (make-signature posonlyargs: (self index) defaults: (vector py-absent))))

(define-rts (list-append self value)
  (if (py-isinstance? self py-list-class)
    (let* ((len (PyObjectList-len self))
           (vec
             (let ((vec (PyObjectList-vector self)))
               (if (= len (vector-length vec))
                  (list-grow! self)
                  vec))))
      (vector-set! vec len value)
      (PyObjectList-len-set! self (+ len 1)))
    (py-throw-not-a-type-object "list.append" self))
  py-None)

(define-rts list.append
  (procedure->py-function
    list-append
    (make-signature posonlyargs: (self value))))

(define-rts (list-clear self)
  (if (py-isinstance? self py-list-class)
    (begin
      (PyObjectList-vector-set! self (make-vector (list-get-inner-len 0) #f))
      (PyObjectList-len-set! self 0))
    (py-throw-not-a-type-object "list.clear" self))
  py-None)

(define-rts list.clear
  (procedure->py-function
    list-clear
    (make-signature posonlyargs: (self))))

;; Could not call list-copy due to collision with Scheme list-copy
(define-rts (list-copy-procedure self)
  (if (py-isinstance? self py-list-class)
    (py-list-from-scheme (vector-copy (PyObjectList-vector self)) (PyObjectList-len self))
    (py-throw-not-a-type-object "list.copy" self)))

(define-rts list.copy
  (procedure->py-function
    list-copy-procedure
    (make-signature posonlyargs: (self))))

(define-rts (list-count self item)
  (if (py-isinstance? self py-list-class)
    (let* ((len (PyObjectList-len self))
           (vec (PyObjectList-vector self)))
      (let loop ((i 0) (count 0))
        (cond
          ((= i len)
            (py-int-from-scheme count))
          ((py-test (py-eq (vector-ref vec i) item))
            (loop (+ i 1) (+ count 1)))
          (else
            (loop (+ i 1) count)))))
    (py-throw-not-a-type-object "list.count" self)))

(define-rts list.count
  (procedure->py-function
    list-count
    (make-signature posonlyargs: (self item))))

(define-rts (list-index self item start stop)
  (if (py-isinstance? self py-list-class)
    (let* ((len (PyObjectList-len self))
           (vec (PyObjectList-vector self))
           (start-index
            (if start
              (if (py-subtype-of-int? start)
                (let ((val (py-subtype-of-int-to-scheme start)))
                  (if (< val 0)
                    (modulo (max (- len) val) len)
                    (min len val)))
                    (py-throw-wrong-index-type "list" "integers" start))
              0))
           (stop-index
             (if stop
               (if (py-subtype-of-int? stop)
                 (let ((val (py-subtype-of-int-to-scheme stop)))
                   (if (< val 0)
                     (modulo (max (- len) val) len)
                     (min len val)))
                     (py-throw-wrong-index-type "list" "integers" stop))
              len)))
      (let ((res (py-index-in-subvector item vec start-index stop-index)))
        (if res
          (py-int-from-scheme res)
          (py-throw
            (py-call
              py-builtin-ValueError
              (&& "list.index(x): x not in list"))))))
    (py-throw-not-a-type-object "list.index" self)))

(define-rts list.index
  (procedure->py-function
    list-index
    (make-signature posonlyargs: (self item start stop) defaults: '#(#f #f))))

(define-rts (list-insert self index value)
  (if (py-isinstance? self py-list-class)
    (if (py-subtype-of-int? index)
      (let* ((len (PyObjectList-len self))
            (i (py-subtype-of-int-to-scheme index)))
        (let ((insertion-index
                (if (< i 0)
                  (modulo (max (- len) i) len)
                  (min len i))))
          (list-shift-right! self insertion-index)
          (vector-set! (PyObjectList-vector self) insertion-index value)))
        (py-throw-wrong-index-type "list" "integers" index))
    (py-throw-not-a-type-object "list.insert" self))
  py-None)

(define-rts list.insert
  (procedure->py-function
    list-insert
    (make-signature posonlyargs: (self index value))))

(define-rts (list-extend-with-vector-head! lst source-vec stop)
  (let* ((len (PyObjectList-len lst))
         (vec
           (let ((vec (PyObjectList-vector lst)))
             (if (>= stop (- (vector-length vec) len))
                 (list-grow-by! lst stop)
                 vec))))
    (let loop ((i len) (j 0))
      (if (< j stop)
        (begin
          (vector-set! vec i (vector-ref source-vec j))
          (loop (+ i 1) (+ j 1)))))
    (PyObjectList-len-set! lst (+ len stop))))

(define-rts (list-extend-with-iterable! lst iterable)
  (let ((iterable-type (py-type iterable)))
    (cond
      ((eq? iterable-type py-tuple-class)
        (let ((vec (PyObjectTuple-value iterable)))
          (list-extend-with-vector-head!
            lst
            vec
            (vector-length vec))))
      ((eq? iterable-type py-list-class)
        (let* ((len (PyObjectList-len iterable))
               (vec (PyObjectList-vector iterable)))
          (list-extend-with-vector-head!
            lst
            vec
            len)))
      (else
        (let* ((iterator (py-iter iterable))
               (content (list->vector (iterator->list iterator))))
          (list-extend-with-vector-head!
            lst
            content
            (vector-length content)))))))

(define-rts (list-extend self iterable)
  (if (py-isinstance? self py-list-class)
    (list-extend-with-iterable! self iterable)
    (py-throw-not-a-type-object "list.extend" self))
  py-None)

(define-rts list.extend
  (procedure->py-function
    list-extend
    (make-signature posonlyargs: (self iterable))))

(define-rts (list-iadd self other)
  (if (py-isinstance? self py-list-class)
    (list-extend-with-iterable! self other)
    (py-throw-not-a-type-object "list.__iadd__" self))
  self)

(define-rts list.__iadd__
  (procedure->py-function
    list-iadd
    (make-signature posonlyargs: (self other))))

(define-rts (list-remove self item)
  (if (py-isinstance? self py-list-class)
    (let* ((len (PyObjectList-len self))
           (vec (PyObjectList-vector self)))
      (let ((index (py-index-in-subvector item vec 0 len)))
        (if index
          (list-shift-left! self (+ index 1))
          (py-throw
            (py-call
              py-builtin-ValueError
              (&& "list.remove(x): x not in list"))))))
    (py-throw-not-a-type-object "list.remove" self))
  py-None)

(define-rts list.remove
  (procedure->py-function
    list-remove
    (make-signature posonlyargs: (self item))))

(define-rts (list-reverse self)
    (if (py-isinstance? self py-list-class)
      (let ((len (PyObjectList-len self))
            (vec (PyObjectList-vector self)))
        (let loop ((left 0) (right (- len 1)))
          (if (< left right)
            (begin
              (let ((tmp (vector-ref vec left)))
                (vector-set! vec left (vector-ref vec right))
                (vector-set! vec right tmp))
              (loop (+ left 1) (- right 1))))))
      (py-throw-not-a-type-object "list.reverse" self))
    py-None)

(define-rts list.reverse
  (procedure->py-function
    list-reverse
    (make-signature posonlyargs: (self))))

(define-rts list.sort #f)

;; tuple class

(define-rts (tuple-iter self)
  (if (py-isinstance? self py-tuple-class)
    (py-tuple-iterator-alloc 0 (PyObjectTuple-value self))
    (py-throw-exception-with-message py-builtin-TypeError "pending error message (code 12)")))

(define-rts tuple.__iter__
  (procedure->py-function
    tuple-iter
    (make-signature posonlyargs: (self))))

(define-rts (tuple-contains self item)
  (if (py-isinstance? self py-tuple-class)
    (let* ((vec (PyObjectTuple-value self))
           (vec-len (vector-length vec)))
      (let loop ((i 0))
        (if (< i vec-len)
          (if (py-test (py-eq item (vector-ref vec i)))
            py-True
            (loop (+ i 1)))
          py-False)))
    (py-throw-not-a-type-object "tuple.__contains__" self)))

(define-rts tuple.__contains__
  (procedure->py-function
    tuple-contains
    (make-signature posonlyargs: (self item))))

(define-rts (tuple-add self other)
  (if (py-isinstance? self py-tuple-class)
    (if (py-isinstance? other py-tuple-class)
      (let ((v1 (PyObjectTuple-value self))
            (v2 (PyObjectTuple-value other)))
        (py-tuple-from-scheme (vector-append v1 v2)))
      py-NotImplemented)
    (py-throw-not-a-type-object "tuple.__add__" self)))

(define-rts tuple.__add__
  (procedure->py-function
    tuple-add
    (make-signature posonlyargs: (self other))))

(define-rts (vector*n v n)
  (let* ((v-len (vector-length v))
         (target-len (* n v-len))
         (out (make-vector target-len)))
    (let loop ((target-pos 0))
      (if (< target-pos target-len)
        (let inner-loop ((source-pos 0))
          (if (< source-pos v-len)
            (begin
              (vector-set! out (+ target-pos source-pos) (vector-ref v source-pos))
              (inner-loop (+ source-pos 1)))
            (loop (+ target-pos v-len))))
        out))))

(define-rts (tuple-mul self n)
  (if (py-isinstance? self py-tuple-class)
    (if (py-subtype-of-int? n)
      (let ((v (PyObjectTuple-value self))
            (n (py-subtype-of-int-to-scheme n)))
        (py-tuple-from-scheme (vector*n v n)))
      py-NotImplemented)
    (py-throw-not-a-type-object "tuple.__mul__" self)))

(define-rts tuple.__mul__
  (procedure->py-function
    tuple-mul
    (make-signature posonlyargs: (self n))))

(define-rts tuple.__rmul__
  (procedure->py-function
    tuple-mul
    (make-signature posonlyargs: (self n))))

(define-rts (vector-py-eq? v1 v2)
  (let ((v1-len (vector-length v1))
        (v2-len (vector-length v2)))
    (if (= v1-len v2-len)
      (let loop ((i 0))
        (if (< i v1-len)
          (let* ((el1 (vector-ref v1 i))
                 (el2 (vector-ref v2 i)))
            (if (py-test (py-eq el1 el2))
              (loop (+ i 1))
              #f))
          #t))
      #f)))

(define-rts (vector-py-ne? v1 v2)
  (not (vector-py-eq? v1 v2)))

(define-macro (define-vector-comparator name py-strict-op scheme-op)
  `(define-rts (,name v1 v2)
    (let* ((v1-len (vector-length v1))
          (v2-len (vector-length v2))
          (min-len (min v1-len v2-len)))
      (let loop ((i 0))
        (if (< i min-len)
          (let* ((el1 (vector-ref v1 i))
                 (el2 (vector-ref v2 i)))
            (if (py-test (,py-strict-op el1 el2))
              #t
              (if (py-test (py-eq el1 el2))
                (loop (+ i 1))
                #f)))
          (,scheme-op v1-len v2-len))))))

(define-vector-comparator vector-py-lt? py-lt <)

(define-vector-comparator vector-py-le? py-lt <=)

(define-vector-comparator vector-py-gt? py-gt >)

(define-vector-comparator vector-py-ge? py-gt >=)

(define-macro (define-tuple-binary-comparator name py-name vector-comparator)
  `(begin
    (define-rts (,name self other)
      (if (py-isinstance? self py-tuple-class)
        (if (py-isinstance? other py-tuple-class)
          (let ((v1 (PyObjectTuple-value self))
                (v2 (PyObjectTuple-value other)))
            (if (,vector-comparator v1 v2)
              py-True
              py-False))
          py-NotImplemented)
        (py-throw-not-a-type-object ,(symbol->string py-name) self)))

    (define-rts ,py-name
      (procedure->py-function
        ,name
        (make-signature posonlyargs: (self other))))))

(define-tuple-binary-comparator tuple-eq tuple.__eq__ vector-py-eq?)

(define-tuple-binary-comparator tuple-ne tuple.__ne__ vector-py-ne?)

(define-tuple-binary-comparator tuple-lt tuple.__lt__ vector-py-lt?)

(define-tuple-binary-comparator tuple-le tuple.__le__ vector-py-le?)

(define-tuple-binary-comparator tuple-gt tuple.__gt__ vector-py-gt?)

(define-tuple-binary-comparator tuple-ge tuple.__ge__ vector-py-ge?)

;; TODO: print cyclic structures
(define-rts (tuple-repr self)
  (if (py-isinstance? self py-tuple-class)
    (let* ((vec (PyObjectTuple-value self))
           (content-strs (vector-map py-repr vec))
           (content-strings
            (vector-map (lambda (x) (py-subtype-of-str-to-scheme x))
                        content-strs)))
      (py-str-from-scheme
        (string-append
          "("
          (string-join-vector ", " content-strings)
          (if (= (vector-length vec) 1) ",)" ")"))))
    (py-throw-not-a-type-object "tuple.__repr__" self)))

(define-rts tuple.__repr__
  (procedure->py-function
    tuple-repr
    (make-signature posonlyargs: (self))))

(define-rts (tuple-len self)
  (if (py-isinstance? self py-tuple-class)
    (let* ((vec (PyObjectTuple-value self)))
      (py-int-from-scheme (vector-length vec)))
    (py-throw-not-a-type-object "tuple.__len__" self)))

(define-rts tuple.__len__
  (procedure->py-function
    tuple-len
    (make-signature posonlyargs: (self))))

(define-rts (vector-slice vec start stop step)
  (let* ((len (get-slice-length start stop step))
        (out (make-vector len #f)))
    (let loop ((source start) (target 0))
      (if (< target len)
        (begin
          (vector-set! out target (vector-ref vec source))
          (loop (+ source step) (+ target 1)))))
    out))

(define-rts (vector-py-slice vec slice)
  (let* ((len (vector-length vec))
        (slice-indices (py-slice-indices slice len)))
    (vector-slice
      vec
      (vector-ref slice-indices 0)
      (vector-ref slice-indices 1)
      (vector-ref slice-indices 2))))

(define-rts (tuple-getitem self item)
  (if (py-isinstance? self py-tuple-class)
    (cond
      ((py-subtype-of-int? item)
        (let* ((vec (PyObjectTuple-value self))
               (len (vector-length vec))
               (i (py-subtype-of-int-to-scheme item)))
          (if (index-in-length-range i len)
            (vector-ref vec (modulo i len))
            (py-throw-index-out-of-range "tuple"))))
      ((py-isinstance? item py-slice-class)
        (py-tuple-from-scheme
          (vector-py-slice
            (PyObjectTuple-value self)
            item)))
      (py-throw-wrong-index-type "tuple" "integers or slices" item))
    (py-throw-not-a-type-object "tuple.__getitem__" self)))

(define-rts tuple.__getitem__
  (procedure->py-function
    tuple-getitem
    (make-signature posonlyargs: (self item))))

(define-rts (tuple-count self item)
  (if (py-isinstance? self py-tuple-class)
    (let* ((vec (PyObjectTuple-value self))
           (vec-len (vector-length vec)))
      (let loop ((i 0) (count 0))
        (cond
          ((= i vec-len)
            (py-int-from-scheme count))
          ((py-test (py-eq (vector-ref vec i) item))
            (loop (+ i 1) (+ count 1)))
          (else
            (loop (+ i 1) count)))))
    (py-throw-not-a-type-object "tuple.count" self)))

(define-rts tuple.count
  (procedure->py-function
    tuple-count
    (make-signature posonlyargs: (self item))))

(define-rts (tuple-index self item start stop)
  (if (py-isinstance? self py-tuple-class)
    (let* ((vec (PyObjectTuple-value self))
           (len (vector-length vec))
           (start-index
            (if (eq? start py-absent)
              0
              (if (py-subtype-of-int? start)
                (let ((val (py-subtype-of-int-to-scheme start)))
                  (if (< val 0)
                    (modulo (max (- len) val) len)
                    (min len val)))
                    (py-throw-wrong-index-type "tuple" "integers" start))))
           (stop-index
             (if (eq? stop py-absent)
               len
               (if (py-subtype-of-int? stop)
                 (let ((val (py-subtype-of-int-to-scheme stop)))
                   (if (< val 0)
                     (modulo (max (- len) val) len)
                     (min len val)))
                     (py-throw-wrong-index-type "tuple" "integers" stop)))))
      (let ((res (py-index-in-subvector item vec start-index stop-index)))
        (if res
          (py-int-from-scheme res)
          (py-throw
            (py-call
              py-builtin-ValueError
              (&& "tuple.index(x): x not in tuple"))))))
    (py-throw-not-a-type-object "tuple.index" self)))

(define-rts tuple.index
  (procedure->py-function
    tuple-index
    (make-signature
      posonlyargs: (self item start stop)
      defaults: (vector py-absent py-absent))))

;; slices

(define-rts (py-slice-from-scheme start stop step)
  (make-PyObjectSlice
    py-slice-hclass-of-instances
    '#()
    py-slice-class
    start
    stop
    step))

(define-rts (slice-new cls arg1 arg2 arg3)
  (if (or (eq? cls py-slice-class) (py-issubclass? cls py-slice-class))
    (cond
      ((eq? arg2 py-absent)
        (py-slice-from-scheme py-None arg1 py-None))
      ((eq? arg3 py-absent)
        (py-slice-from-scheme arg1 arg2 py-None))
      (else
        (py-slice-from-scheme arg1 arg2 arg3)))
    (py-throw-wrong-new-argument "list" cls)))

(define-rts slice.__new__
  (procedure->py-function
    slice-new
    (make-signature
      posonlyargs: (cls arg1 arg2 arg3)
      defaults: (vector py-absent py-absent))))

(define-rts (slice-indices self len)
    (if (py-isinstance? self py-slice-class)
      (if (py-subtype-of-int? len)
        (let ((len-i (py-subtype-of-int-to-scheme len)))
          (py-tuple-from-scheme
            (vector-map
             (lambda (n) (py-int-from-scheme n))
             (py-slice-indices self len-i))))
        (py-throw-exception-with-message py-builtin-TypeError "pending error message (code 13)")) ;; TODO: add error message
      (py-throw-not-a-type-object "slice.indices" self)))

(define-rts slice.indices
  (procedure->py-function
    slice-indices
    (make-signature posonlyargs: (self len))))

;; ===========================================
;; dynamic vector operations used by bytearray
;; ===========================================
;; TODO: replace this implementation of dynamic vector as pairs of (len . vector)
;; by attributes of PyObjectBytearray objects (see PyObjectList)

(define-macro (make-dynamic-vector len vector)
  `(cons ,len ,vector))

(define-macro (define-concat-dynamic-vector name vref vset vmake vempty-list)
`(define-rts (,name container1 container2)
  (let* ((len1 (car container1))
        (v1 (cdr container1))
        (len2 (car container2))
        (v2 (cdr container2))
        (total-len (+ len1 len2))
        (vec-len (list-get-inner-len total-len))
        (vec (,vmake vec-len ,vempty-list)))
    (let loop1 ((target-pos 0) (source-pos 0))
      (if (< source-pos len1)
        (begin
          (,vset vec target-pos (,vref v1 source-pos))
          (loop1 (+ target-pos 1) (+ source-pos 1)))))
    (let loop2 ((target-pos len1) (source-pos 0))
      (if (< source-pos len2)
        (begin
          (,vset vec target-pos (,vref v2 source-pos))
          (loop2 (+ target-pos 1) (+ source-pos 1)))))
    (make-dynamic-vector total-len vec))))

(define-concat-dynamic-vector concat-dynamic-u8vectors u8vector-ref u8vector-set! make-u8vector 0)


(define-macro (define-*n-dynamic-vector name vref vset vmake vempty-list)
  `(define-rts (,name c n)
  (let* ((len (car c))
         (vec (cdr c))
         (total-len (fx* len n))
         (target-inner-len (list-get-inner-len total-len))
         (out (,vmake target-inner-len ,vempty-list)))
    (let loop ((target-pos 0))
      (if (fx< target-pos total-len)
        (let inner-loop ((source-pos 0))
          (if (fx< source-pos len)
            (begin
              (,vset out (fx+ target-pos source-pos) (,vref vec source-pos))
              (inner-loop (fx+ source-pos 1)))
            (loop (fx+ target-pos len))))
        (make-dynamic-vector total-len out))))))

(define-*n-dynamic-vector dynamic-u8vector*n u8vector-ref u8vector-set! make-u8vector 0)


(define-macro (define-slice-dynamic-vector name vref vset vmake vlist-empty)
  `(define-rts (,name vec start stop step)
  (let* ((len (get-slice-length start stop step))
        (inner-len (list-get-inner-len len))
        (out (,vmake inner-len ,vlist-empty)))
    (let loop ((source start) (target 0))
      (if (< target len)
        (begin
          (,vset out target (,vref vec source))
          (loop (+ source step) (+ target 1)))))
    (make-dynamic-vector len out))))

(define-slice-dynamic-vector dynamic-u8vector-slice u8vector-ref u8vector-set! make-u8vector 0)


(define-macro (define-py-slice-dynamic-vector name vref vdynamic-slice)
  `(define-rts (,name dvec slice)
  (let* ((len (car dvec))
        (vec (cdr dvec))
        (slice-indices (py-slice-indices slice len)))
    (,vdynamic-slice
      vec
      (vector-ref slice-indices 0)
      (vector-ref slice-indices 1)
      (vector-ref slice-indices 2)))))

(define-py-slice-dynamic-vector dynamic-u8vector-py-slice u8vector-ref dynamic-u8vector-slice)


(define-macro (vector-ref-to-scheme-int vec index)
  `(py-subtype-of-int-to-scheme (vector-ref ,vec ,index)))

;; slices of the form lst[1:4]
(define-macro (define-set-simple-slice-dynamic-vector name vshift-right-by vshift-left-by vset vref)
  `(define-rts (,name dvec start stop vec len)
    (let* ((self-vec (cdr dvec))
           (slice-len (- stop start))
           (len-diff (- slice-len len)))
      (cond
       ((< len-diff 0)
        (,vshift-right-by dvec start (- len-diff)))
       ((> len-diff 0)
        (,vshift-left-by dvec start len-diff)))
      ;; Update the vector which may have been updated when shifting
      (set! self-vec (cdr dvec))
      (let loop ((src-index 0) (tgt-index start))
        (if (< src-index len)
            (begin
              (,vset self-vec tgt-index (,vref vec src-index))
              (loop (+ src-index 1) (+ tgt-index 1))))))))


(define-set-simple-slice-dynamic-vector dynamic-u8vector-u8vector-set-simple-slice! dynamic-u8vector-shift-right-by! dynamic-u8vector-shift-left-by! u8vector-set! u8vector-ref)
(define-set-simple-slice-dynamic-vector dynamic-u8vector-vector-set-simple-slice! dynamic-u8vector-shift-right-by! dynamic-u8vector-shift-left-by! u8vector-set! vector-ref-to-scheme-int)

;;slices of the form lst[1:6:2] (i.e. with a step)
(define-macro (define-set-extended-dynamic-vector name vref vset)
  `(define-rts (,name dvec start stop step vec len)
  (let ((self-vec (cdr dvec))
        (slice-len (get-slice-length start stop step)))
    (if (= len slice-len)
      (let loop ((src-index 0) (tgt-index start))
        (if (< src-index len)
          (begin
            (,vset self-vec tgt-index (,vref vec src-index))
            (loop (+ src-index 1) (+ tgt-index step)))))
      (py-throw-extended-slice-wrong-len len slice-len)))))

(define-set-extended-dynamic-vector dynamic-u8vector-u8vector-set-extended-slice! u8vector-ref u8vector-set!)
(define-set-extended-dynamic-vector dynamic-u8vector-vector-set-extended-slice! vector-ref-to-scheme-int u8vector-set!)


(define-macro (define-shrink-dynamic-vector name vsubvec)
  `(define-rts (,name dvec)
    (let* ((len (car dvec))
           (vec (cdr dvec))
           (new-inner-len (list-get-inner-len len)))
      (set-cdr! dvec (,vsubvec vec 0 new-inner-len)))))

(define-shrink-dynamic-vector dynamic-u8vector-shrink! subu8vector)

(define-macro (define-grow-dynamic-vector name vset vmake vlist-empty vappend)
  `(define-rts (,name dvec)
  (let* ((len (car dvec))
        (vec (cdr dvec))
        (new-inner-len (list-get-inner-len len)))
    (set-cdr!
      dvec
      (,vappend vec (,vmake (- new-inner-len len) ,vlist-empty))))))

(define-grow-dynamic-vector dynamic-u8vector-grow! u8vector-set! make-u8vector 0 u8vector-append)

(define-macro (define-grow-by-dynamic-vector name vmake vlist-empty vappend )
  `(define-rts (,name dvec amount)
    (let* ((len (car dvec))
           (vec (cdr dvec))
           (new-inner-len (list-get-inner-len (+ len amount))))
      (set-cdr!
       dvec
       (,vappend vec (,vmake (- new-inner-len len) ,vlist-empty))))))

(define-grow-by-dynamic-vector dynamic-u8vector-grow-by! make-u8vector 0 u8vector-append)

(define-macro (define-shift-left-by-dynamic-vector name vshrink-by vset vempty-list vref vlength)
  `(define-rts (,name dvec index amount)
    (if (> amount 0)
        (let ((len (car dvec))
              (vec (cdr dvec)))
          (let loop ((i (max index amount)))
            (if (< i len)
                (begin
                  (,vset vec (- i amount) (,vref vec i))
                  (,vset vec i ,vempty-list)
                  (loop (+ i 1)))))
          (set-car! dvec (- len amount))
          (if (<
               len
               (list-get-shrink-threshold (,vlength vec)))
              (,vshrink-by dvec))))))

(define-shift-left-by-dynamic-vector dynamic-u8vector-shift-left-by! dynamic-u8vector-shrink! u8vector-set! 0 u8vector-ref u8vector-length)

(define-macro (define-shift-right-by-dynamic-vector name vgrow-by vset vref vlength)
  `(define-rts (,name dvec index amount)
    (if (> amount 0)
        (let ((len (car dvec))
              (vec (cdr dvec)))
          (if (>= (+ amount len) (,vlength vec))
              (begin
                (,vgrow-by dvec amount)
                (set! vec (cdr dvec))))
          (let loop ((i (+ amount len -1)))
            (if (>= (- i amount) index)
                (begin
                  (,vset vec i (,vref vec (- i amount)))
                  (loop (- i 1)))))
          (set-car! dvec (+ len amount))))))

(define-shift-right-by-dynamic-vector dynamic-u8vector-shift-right-by! dynamic-u8vector-grow-by! u8vector-set! u8vector-ref u8vector-length)

;; =========================
;; bytearray operations
;; =========================

(define-rts (py-int-in-byte-range? value)
  (and (<= 0 value) (>= 255 value)))

(define-rts (vector-in-byte-range? vec)
  (let loop ((i 0))
    (if (< i (vector-length vec))
        (let ((item (vector-ref vec i)))
          (if (and
               (py-subtype-of-int? item)
               (py-int-in-byte-range? (py-subtype-of-int-to-scheme item)))
              (loop (+ 1 i))
              #f))
        #t)))

(define-rts u8-empty-vector (make-u8vector 0 0))

(define-rts (bytearray-new cls arg1 arg2 agr3)
  (if (py-issubclass? cls py-bytearray-class)
    (cond
       ((eq? arg1 py-absent)
        ;; MS 11jun2020: to be removed when Bigloo's fixed
        ;; (py-bytearray-from-scheme (cons 0 #u8())))
        (py-bytearray-subtype-from-scheme (make-dynamic-vector 0 u8-empty-vector) cls))
      ((eq? arg2 py-absent)
        (cond
          ((py-subtype-of-int? arg1)
            (let ((i (py-subtype-of-int-to-scheme arg1)))
              (if (<= 0 i)
                (py-bytearray-subtype-from-scheme (make-dynamic-vector i (make-u8vector i 0)) cls)
                (py-throw-exception-with-message py-builtin-ValueError "negative count"))))
          ((py-isinstance? arg1 py-bytearray-class)
           (let ((value (PyObjectBytearray-value arg1)))
            (py-bytearray-subtype-from-scheme (make-dynamic-vector (car value) (u8vector-copy (cdr value))) cls)))
          (else
            (error "builtin function __new__ just supports int as an argument"))))
      (else
        (error "builtin function __new__ for 'bytearray' does not yet support more than one argument "))  )
    (py-throw-wrong-new-argument "bytearray" cls)))


(define-rts bytearray.__new__
  (procedure->py-function
    bytearray-new
    (make-signature
      posonlyargs: (cls source encoding errors)
      defaults: (vector py-absent py-absent py-absent))))


(define-rts (bytearray-getitem self item)
  (if (py-isinstance? self py-bytearray-class)
      (cond
        ((py-subtype-of-int? item)
        (let ((bytearray (PyObjectBytearray-value self))
              (i (py-subtype-of-int-to-scheme item)))
          (if (index-in-length-range i (car bytearray))
            (py-int-from-scheme (u8vector-ref (cdr bytearray) (modulo i (car bytearray))))
            (py-throw-index-out-of-range "bytearray"))))
        ((py-isinstance? item py-slice-class)
         (py-bytearray-from-scheme
          (dynamic-u8vector-py-slice
           (PyObjectBytearray-value self)
           item)))
      (else (py-throw-wrong-index-type "bytearray" "integers or slices" item)))
    (py-throw-not-a-type-object "bytearray.__getitem__" self)))

(define-rts bytearray.__getitem__
  (procedure->py-function
    bytearray-getitem
    (make-signature posonlyargs:
      (self item))))

(define-rts (bytearray-set-slice self slice value)
  (let* ((dvec (PyObjectBytearray-value self))
        (self-len (car dvec))
        (indices (py-slice-indices slice self-len))
        (start (vector-ref indices 0))
        (stop (vector-ref indices 1))
        (step (vector-ref indices 2))
        (value-type (py-type value)))
    (cond
      ((eq? value-type py-bytearray-class)
        (let* ((value-dvec (PyObjectBytearray-value value))
              (value-len (car value-dvec))
              (value-vec (cdr value-dvec)))
          (if (eq? step 1)
            (dynamic-u8vector-u8vector-set-simple-slice! dvec start stop value-vec value-len)
            (dynamic-u8vector-u8vector-set-extended-slice! dvec start stop step value-vec value-len))))
      ((eq? value-type py-tuple-class)
        (let* ((value-vec (PyObjectTuple-value value))
               (value-len (vector-length value-vec)))
          (if (vector-in-byte-range? value-vec)
              (if (eq? step 1)
                  (dynamic-u8vector-vector-set-simple-slice! dvec start stop value-vec value-len)
                  (dynamic-u8vector-vector-set-extended-slice! dvec start stop step value-vec value-len))
              (py-throw-exception-with-message py-builtin-ValueError "byte must be in range (0, 255)"))))
      (else
        (let ((iterator (py-obj->iterator value)))
          (if iterator
            (let* ((value-vec (list->vector (iterator->list iterator)))
                  (value-len (vector-length value-vec)))
              (if (vector-in-byte-range? value-vec)
                  (if (eq? step 1)
                      (dynamic-u8vector-vector-set-simple-slice! dvec start stop value-vec value-len)
                      (dynamic-u8vector-vector-set-extended-slice! dvec start stop step value-vec value-len))
                  (py-throw-exception-with-message py-builtin-ValueError "byte must be in range (0, 255)")))
            (py-throw-can-only-assign-iterable)))))))


(define-rts (bytearray-setitem self key value)
  (if (py-isinstance? self py-bytearray-class)
      (cond
       ((py-subtype-of-int? key)
        (if (py-subtype-of-int? value)
            (let ((key-int (py-subtype-of-int-to-scheme key))
                  (bytearray (PyObjectBytearray-value self))
                  (value-int (py-subtype-of-int-to-scheme value)))
              (cond
               ((not (index-in-length-range key-int (car bytearray)))
                (py-throw-index-out-of-range "bytearray" ))
               ((not (py-int-in-byte-range? value-int))
                (py-throw-exception-with-message py-builtin-ValueError "byte must be in range(0, 255)"))
               (else
                (u8vector-set! (cdr bytearray) (modulo key-int (car bytearray)) value-int))))
            (py-throw-wrong-index-type "bytearray" "integers or slice" key)))
       ((py-isinstance? key py-slice-class)
        (bytearray-set-slice self key value))
       (else
         (py-throw-wrong-index-type "bytearray" "integers or slice" key)))
      (py-throw-not-a-type-object "bytearray.__getitem__" self)))

(define-rts bytearray.__setitem__
  (procedure->py-function
    bytearray-setitem
      (make-signature posonlyargs:
        (self key value))))

(define-rts (bytearray-append self elem)
  (cond
    ((not (py-isinstance? self py-bytearray-class))
      (py-throw-not-a-type-object "bytearray.append" self))
    ((not (py-subtype-of-int? elem))
      (py-throw-exception-with-message py-builtin-TypeError "this type cannot be interpreted as an integer"))
    (else
      (let* ((bytearray (PyObjectBytearray-value self))
            (real-length (u8vector-length (cdr bytearray)))
            (elem-int (py-subtype-of-int-to-scheme elem)))
        (if (not (py-int-in-byte-range? elem-int))
            (py-throw-exception-with-message py-builtin-ValueError "byte must be in range(0, 255)")
            (begin
              (if (= real-length (car bytearray))
                  (dynamic-u8vector-grow! bytearray))
              (u8vector-set! (cdr bytearray) (car bytearray) elem-int)
              (set-car! bytearray (+ 1 (car bytearray)))))))))

(define-rts bytearray.append
  (procedure->py-function
    bytearray-append
    (make-signature posonlyargs:
      (self value))))

(define-rts (bytearray-add self other)
  (if (py-isinstance? self py-bytearray-class)
      (if (py-isinstance? other py-bytearray-class)
          (let ((c1 (PyObjectBytearray-value self))
                (c2 (PyObjectBytearray-value other)))
            (py-bytearray-from-scheme (concat-dynamic-u8vectors c1 c2)))
          py-NotImplemented)
      (py-throw-not-a-type-object "bytearray.__add__" self)))

(define-rts bytearray.__add__
  (procedure->py-function
   bytearray-add
   (make-signature posonlyargs: (self other))))

(define-rts (dynamic-u8vector-extend dvec-target dvec-source)
  (let* ((target (cdr dvec-target))
        (target-length (car dvec-target))
        (target-inner-length (car dvec-target))
        (source (cdr dvec-source))
        (source-length (car dvec-source))
        (source-inner-length (car dvec-source))
        (total-len (+ target-length source-length)))
    (if (< total-len target-inner-length)
      (let loop ((source-index 0) (target-index (source-length)))
        (if (< source-index source-length)
          (begin
            (u8vector-set! target target-index (u8vector-ref source source-index))
            (loop (+ source-index 1) (+ target-index 1)))
          (set-car! dvec-target total-len)))
      (let ((new-dvec (concat-dynamic-u8vectors dvec-target dvec-source)))
        (set-car! dvec-target (car new-dvec))
        (set-cdr! dvec-target (cdr new-dvec))))))


(define-rts (bytearray-iadd self other)
  (if (py-isinstance? self py-bytearray-class)
      (if (py-isinstance? other py-bytearray-class)
          (let ((c1 (PyObjectBytearray-value self))
                (c2 (PyObjectBytearray-value other)))
            (dynamic-u8vector-extend c1 c2)
            self)
          py-NotImplemented)
      (py-throw-not-a-type-object "bytearray.__iadd__" self)))

(define-rts bytearray.__iadd__
  (procedure->py-function
   bytearray-iadd
   (make-signature posonlyargs: (self other))))

(define-rts (bytearray-repr self)
  (define (u8->char-repr x)
    (string-append "\\x" (substring (number->string (+ x 256) 16) 1 3)))

  (if (py-isinstance? self py-bytearray-class)
    (let* ((value (PyObjectBytearray-value self))
          (u8vec (cdr value))
          (bytearray-len (car value))
          (content
            (let loop ((i 0) (acc '()))
              (if (< i bytearray-len)
                (loop (+ i 1) (cons (u8->char-repr (u8vector-ref u8vec i)) acc))
                (append-strings (reverse acc))))))
      (py-str-from-scheme
        (string-append
          "bytearray(b'"
          content
          "')")))
    (py-throw-not-a-type-object "bytearray.__repr__" self)))

(define-rts bytearray.__repr__
  (procedure->py-function
   bytearray-repr
   (make-signature posonlyargs: (self))))

(define-rts (bytearray-mul self n)
  (if (py-isinstance? self py-bytearray-class)
      (if (py-subtype-of-int? n)
          (let ((c (PyObjectBytearray-value self))
                (n (py-subtype-of-int-to-scheme n)))
            (py-bytearray-from-scheme (dynamic-u8vector*n c n)))
          py-NotImplemented)
      (py-throw-not-a-type-object "bytearray.__mul__" self)))

(define-rts bytearray.__mul__
  (procedure->py-function
   bytearray-mul
   (make-signature posonlyargs: (self other))))

(define-rts bytearray.__rmul__
  (procedure->py-function
   bytearray-mul
   (make-signature posonlyargs: (self n))))

(define-rts (bytearray-imul self n)
  (if (py-isinstance? self py-bytearray-class)
      (if (py-subtype-of-int? n)
          (let ((c (PyObjectBytearray-value self))
                (n (py-subtype-of-int-to-scheme n)))
            (PyObjectBytearray-value-set! self (dynamic-u8vector*n c n))
            self)
          py-NotImplemented)
      (py-throw-not-a-type-object "bytearray.__mul__" self)))

(define-rts bytearray.__imul__
  (procedure->py-function
   bytearray-imul
   (make-signature posonlyargs: (self n))))

(define-rts (bytearray-len self)
  (if (py-isinstance? self py-bytearray-class)
      (py-int-from-scheme
       (car
        (PyObjectBytearray-value self)))
      (py-throw-not-a-type-object "bytearray.__len__" self)))

(define-rts bytearray.__len__
  (procedure->py-function
   bytearray-len
   (make-signature posonlyargs: (self))))

(define-macro (define-search-function endfunction name func-name)
  `(begin
     (define-rts (,name self item start stop)
       (cond
        ((not (py-isinstance? self py-bytearray-class))
         ((py-throw-not-a-type-object ,(symbol->string func-name) self)))
        ((not (py-subtype-of-int? item))
         ((py-throw-action-out-of-range "bytearray" "assignment")))
        (else
         (let* ((bytearray (PyObjectBytearray-value self))
                (item-int (py-subtype-of-int-to-scheme item)))
           (if (py-int-in-byte-range? item-int)
               (let ((start-int
                      (if (eq? py-absent start)
                          0
                          (max 0 (py-subtype-of-int-to-scheme start))))
                     (stop-int
                      (if (eq? py-absent stop)
                          (car bytearray)
                          (min (car bytearray) (py-subtype-of-int-to-scheme stop)))))
                 (,endfunction (cdr bytearray) item-int start-int stop-int))
               (py-throw-exception-with-message py-builtin-ValueError "byte must be in range(0, 255)")
               )))))
     (define-rts ,func-name
       (procedure->py-function
        ,name
        (make-signature posonlyargs: (self item start stop) defaults: (vector py-absent py-absent))))))

(define-macro (dynamic-u8vector-count vec item start stop)
  `(py-int-from-scheme
    (let loop ((i ,start)
               (acc 0))
      (if (fx>= i ,stop)
          acc
          (if (u8= (u8vector-ref ,vec i) ,item)
              (loop (+ 1 i) (+ 1 acc))
              (loop (+ 1 i) acc))))))

(define-macro (dynamic-u8vector-find vec item start stop)
  `(let loop ((i ,start))
     (if (fx>= i ,stop)
         (py-int-from-scheme -1)
         (if (u8= (u8vector-ref ,vec i) ,item)
             (py-int-from-scheme i)
             (loop (+ 1 i))))))


(define-macro (dynamic-u8vector-index vec item start stop)
  `(let loop ((i ,start))
     (if (fx>= i ,stop)
         (py-throw-exception-with-message py-builtin-ValueError "subsection not found")
         (if (u8= (u8vector-ref ,vec i) ,item)
             (py-int-from-scheme i)
             (loop (+ 1 i))))))


(define-macro (dynamic-u8vector-rfind vec item start stop)
  `(let loop ((i (- ,stop 1)))
     (if (fx< i ,start)
         (py-int-from-scheme -1)
         (if (u8= (u8vector-ref ,vec i) ,item)
             (py-int-from-scheme i)
             (loop (- i 1))))))


(define-macro (dynamic-u8vector-rindex vec item start stop)
  `(let loop ((i (- ,stop 1)))
     (if (fx< i ,start)
         (py-throw-exception-with-message py-builtin-ValueError "subsection not found")
         (if (u8= (u8vector-ref ,vec i) ,item)
             (py-int-from-scheme i)
             (loop (- i 1))))))

(define-search-function dynamic-u8vector-count bytearray-count bytearray.count)
(define-search-function dynamic-u8vector-find bytearray-find bytearray.find)
(define-search-function dynamic-u8vector-index bytearray-index bytearray.index)
(define-search-function dynamic-u8vector-rindex bytearray-rindex bytearray.rindex)
(define-search-function dynamic-u8vector-rfind bytearray-rfind bytearray.rfind)

(define-macro (u8vector-cmp v1 len1 v2 len2)
  `(let ((len (min ,len1 ,len2)))
    (let loop ((i 0))
      (if (fx< i len)
          (let ((e1 (u8vector-ref ,v1 i))
                (e2 (u8vector-ref ,v2 i)))
            (cond
             ((u8< e1 e2) -1)
             ((u8> e1 e2) 1)
             (else (loop (+ i 1)))))
          (if (fx= ,len1 ,len2)
              0
              (if (fx< ,len1 ,len2)
                  -1
                  1))))))

(define-macro (dynamic-u8vector-comparator-eq op-int eq? inverse-output name func-name)
  `(begin
     (define-rts  (,func-name self other)
       (if (py-isinstance? self py-bytearray-class)
           (if (py-isinstance? other py-bytearray-class)
               (let* ((c1 (PyObjectBytearray-value self))
                      (c2 (PyObjectBytearray-value other))
                      (len1 (car c1))
                      (len2 (car c2))
                      (vec1 (cdr c1))
                      (vec2 (cdr c2))
                      (cmp (u8vector-cmp vec1 len1 vec2 len2)))
                 (if ,(if eq?
                          `(or (fx= cmp 0)
                               (fx= cmp ,op-int))
                          `(fx= cmp ,op-int))
                     ,(if inverse-output `py-True `py-False)
                     ,(if inverse-output `py-False `py-True)))
               py-NotImplemented)
           (py-throw-not-a-type-object ,name self)))
     (define-rts ,(string->symbol (string-append "bytearray." name))
       (procedure->py-function
        ,func-name
        (make-signature posonlyargs: (self other))))))


(dynamic-u8vector-comparator-eq 1 #f #t "__gt__" bytearray-gt)
(dynamic-u8vector-comparator-eq 1 #t #t "__ge__" bytearray-ge)
(dynamic-u8vector-comparator-eq -1 #f #t "__lt__" bytearray-lt)
(dynamic-u8vector-comparator-eq -1 #t #t"__le__" bytearray-le)

(dynamic-u8vector-comparator-eq 0 #f #t "__eq__" bytearray-eq)
(dynamic-u8vector-comparator-eq 0 #f #f "__ne__" bytearray-ne)


(define-rts (bytearray-iter self)
  (if (py-isinstance? self py-bytearray-class)
      (py-bytearray-iterator-alloc 0 (PyObjectBytearray-value self))
      (py-throw-not-a-type-object "bytearray.__iter__" self)))

(define-rts bytearray.__iter__
  (procedure->py-function
   bytearray-iter
   (make-signature posonlyargs: (self))))

;; =============================================================================
;;  Dict
;; =============================================================================

;; define a doubly-linked-list type for order-preservation
(define-type doubly-linked-list-node value next prev)

(define-rts (doubly-linked-list-node-remove! node ordered-table)
  (let ((prev (doubly-linked-list-node-prev node))
        (next (doubly-linked-list-node-next node))
        (first (ordered-table-first ordered-table))
        (last (ordered-table-last ordered-table)))
    ;; link previous and next nodes together
    (if prev
      (doubly-linked-list-node-next-set! prev next))
    (if next
      (doubly-linked-list-node-prev-set! next prev))
    ;; if the element was the first or last it needs to be removed
    (if (eq? first node)
      (ordered-table-first-set! ordered-table next))
    (if (eq? last node)
      (ordered-table-last-set! ordered-table prev))
    ;; unlink the node from the list
    (doubly-linked-list-node-next-set! node #f)
    (doubly-linked-list-node-prev-set! node #f)))

(define-type dict-cell hash key value)
(define-rts empty-table-cell (cons 'empty-table-cell '()))

(define-rts table-growth-factor 2)
(define-rts table-full-ratio (/ 2 3))

(define-rts (get-table-inner-len len)
  (fxarithmetic-shift
    1
    (integer-length (inexact->exact (ceiling (/ len table-full-ratio))))))

(define-type ordered-table table length first last iterator-token)

(define-rts (ordered-table-first-key ot)
  (dict-cell-key
    (doubly-linked-list-node-value
      (ordered-table-first ot))))

(define-rts (ordered-table->list ordered-table)
  (let ((first (ordered-table-first ordered-table)))
    (let loop ((node first) (acc '()))
      (if node
        (let ((cell (doubly-linked-list-node-value node)))
          (loop
            (doubly-linked-list-node-next node)
            (cons
              (cons (dict-cell-key cell) (dict-cell-value cell))
              acc)))
        (reverse acc)))))

(define-rts (ordered-table-append! ordered-table node)
  (let ((first (ordered-table-first ordered-table)))
    (if first
      (let ((last (ordered-table-last ordered-table)))
        (ordered-table-last-set! ordered-table node)
        (doubly-linked-list-node-next-set! last node)
        (doubly-linked-list-node-prev-set! node last))
      (begin
        (ordered-table-first-set! ordered-table node)
        (ordered-table-last-set! ordered-table node)))))

(define-rts (make-empty-ordered-table length-hint)
  (make-ordered-table
    (make-vector (get-table-inner-len length-hint) empty-table-cell)
    0
    #f
    #f
    (box #t)))

(define-rts (ordered-table-drop-token! ordered-table)
  ;; signal to any iterator that there was a change to the table which
  ;; prevents further iteration
  (set-box! (ordered-table-iterator-token ordered-table) #f)
  ;; drop old token and create a new one
  (ordered-table-iterator-token-set! ordered-table (box #t)))

(define-rts (cell-next i size)
  ;; we use bitwise-and because size is always a power of 2
  (bitwise-and (+ (* 5 i) 1) (- size 1)))

(define-rts (hash->cell hash size)
  ;; use and because size is always a power of 2
  (bitwise-and hash (- size 1)))

(define-rts (ordered-table-get-cell ordered-table key)
  (let* ((hash (py-subtype-of-int-to-scheme (py-hash key)))
         (table (ordered-table-table ordered-table))
         (size (vector-length table)))
    (let loop ((i (hash->cell hash size)))
      (let ((node (vector-ref table i)))
        (if (eq? node empty-table-cell)
            empty-table-cell
            (let* ((cell (doubly-linked-list-node-value node))
                   (cell-key (dict-cell-key cell))
                   (cell-hash (dict-cell-hash cell)))
              (if (and (= hash cell-hash) (py-test (py-eq key cell-key)))
                  cell
                  (loop (cell-next i size)))))))))

(define-rts (table-bucket-indices table size i)
  (let loop ((i i))
    (if (eq? (vector-ref table i) empty-table-cell)
      '()
      (cons
        i
        (table-bucket-indices
          table
          size
          (cell-next i size))))))

(define-rts (table-reinsert-node! table node)
  (let* ((cell (doubly-linked-list-node-value node))
        (hash (dict-cell-hash cell))
        (size (vector-length table)))
    (let loop ((i (hash->cell hash size)))
      (let ((current-node (vector-ref table i)))
        (if (eq? current-node empty-table-cell)
          ;; case where we found an empty cell
          (vector-set! table i node)
          (loop (cell-next i size)))))))

(define-rts (table-bucket-reinsert table indices)
  (let ((nodes-to-reinsert
          (let loop ((indices indices))
            (if (null? indices)
              '()
              (begin
                (let* ((i (car indices))
                       (node (vector-ref table i)))
                  (vector-set! table i empty-table-cell)
                  (cons node (loop (cdr indices)))))))))
    (let reinsertion-loop ((nodes-to-reinsert nodes-to-reinsert))
      (if (not (null? nodes-to-reinsert))
        (let* ((node (car nodes-to-reinsert)))
          (table-reinsert-node! table node)
          (reinsertion-loop (cdr nodes-to-reinsert)))))))

(define-rts (ordered-table-remove-key! ordered-table key)
  (let* ((hash (py-subtype-of-int-to-scheme (py-hash key)))
        (table (ordered-table-table ordered-table))
        (size (vector-length table)))
    (let loop ((i (hash->cell hash size)))
      (let ((node (vector-ref table i)))
        (if (eq? node empty-table-cell)
          #f
          (let* ((cell (doubly-linked-list-node-value node))
                (cell-key (dict-cell-key cell))
                (cell-hash (dict-cell-hash cell)))
            (if (and (= hash cell-hash) (py-test (py-eq key cell-key)))
              (let ((bucket-tail
                      (table-bucket-indices table size (cell-next i size)))
                    (len (ordered-table-length ordered-table)))
                (doubly-linked-list-node-remove! node ordered-table)
                (vector-set! table i empty-table-cell)
                (ordered-table-drop-token! ordered-table)
                (ordered-table-length-set! ordered-table (- len 1))
                (table-bucket-reinsert table bucket-tail)
                #t)
              (loop (cell-next i size)))))))))

(define-rts (table-vector-set! ordered-table vec size hash key value)
  (let ((content-size (ordered-table-length ordered-table)))
    ;; loop to find the corresponding cell
    (let loop ((i (hash->cell hash size)))
      (let ((node (vector-ref vec i)))
        (if (eq? node empty-table-cell)
          ;; case where we found an empty cell
          (let ((node
                  (make-doubly-linked-list-node
                    (make-dict-cell hash key value) #f #f)))
            (ordered-table-drop-token! ordered-table)
            (ordered-table-length-set! ordered-table (+ content-size 1))
            (ordered-table-append! ordered-table node)
            (vector-set! vec i node))
          (let* ((cell (doubly-linked-list-node-value node))
                (cell-key (dict-cell-key cell))
                (cell-hash (dict-cell-hash cell)))
            (if (and (= hash cell-hash) (py-test (py-eq key cell-key)))
              ;; case where we found an existing cell with the same key
              (let ((cell (doubly-linked-list-node-value node)))
                (dict-cell-value-set! cell value))
              ;; case where there is a collision
              (loop (cell-next i size)))))))))

(define-rts (ordered-table-grow! ordered-table)
  (let* ((table (ordered-table-table ordered-table))
        (content-size (ordered-table-length ordered-table))
        (size (vector-length table))
        (new-size (* 2 size))
        (new-table (make-vector new-size empty-table-cell)))
    (let ((first (ordered-table-first ordered-table)))
      ;; reinitialize the table's vector to an empty, bigger vector
      (ordered-table-first-set! ordered-table #f)
      (ordered-table-last-set! ordered-table #f)
      (ordered-table-length-set! ordered-table 0)
      (ordered-table-table-set! ordered-table new-table)
      (let loop ((node first))
        (if node
          (let* ((cell (doubly-linked-list-node-value node))
                (cell-hash (dict-cell-hash cell))
                (cell-key (dict-cell-key cell))
                (cell-value (dict-cell-value cell)))
            (table-vector-set! ordered-table new-table new-size cell-hash cell-key cell-value)
            (loop (doubly-linked-list-node-next node))))))))

(define-rts (ordered-table-set-cell! ordered-table key value)
  (let* ((hash (py-subtype-of-int-to-scheme (py-hash key)))
        (table (ordered-table-table ordered-table))
        (content-size (ordered-table-length ordered-table))
        (size (vector-length table)))
    ;; if the table is getting full, resize it
    (if (>= content-size (* size table-full-ratio))
      (begin
        (ordered-table-grow! ordered-table)
        (set! table (ordered-table-table ordered-table))
        (set! size (vector-length table))))
    (table-vector-set! ordered-table table size hash key value)))

(define-rts (ordered-table-get ordered-table key default)
  (let* ((cell (ordered-table-get-cell ordered-table key)))
    (if (eq? cell empty-table-cell)
      (if (eq? default py-absent)
        (py-throw (py-call py-builtin-KeyError key))
        default)
      (dict-cell-value cell))))

(define-rts (ordered-table-pop! ordered-table key default)
  (let* ((hash (py-subtype-of-int-to-scheme (py-hash key)))
        (table (ordered-table-table ordered-table))
        (size (vector-length table)))
    (let loop ((i (hash->cell hash size)))
      (let ((node (vector-ref table i)))
        (if (eq? node empty-table-cell)
          default
          (let* ((cell (doubly-linked-list-node-value node))
                (cell-key (dict-cell-key cell))
                (cell-hash (dict-cell-hash cell)))
            (if (and (= hash cell-hash) (py-test (py-eq key cell-key)))
              (let ((bucket-tail
                    (table-bucket-indices table size (cell-next i size)))
                    (len (ordered-table-length ordered-table)))
                (doubly-linked-list-node-remove! node ordered-table)
                (vector-set! table i empty-table-cell)
                (ordered-table-drop-token! ordered-table)
                (ordered-table-length-set! ordered-table (- len 1))
                (table-bucket-reinsert table bucket-tail)
                (dict-cell-value cell))
              (loop (cell-next i size)))))))))

(define-rts (py-make-empty-dict)
  (py-dict-alloc (make-empty-ordered-table 0)))

(define-rts (py-dict-from-scheme key-value-pairs)
  (py-dict-alloc (py-ordered-table-from-scheme key-value-pairs)))

(define-rts (py-ordered-table-from-scheme key-value-pairs)
  (let* ((ordered-table (make-empty-ordered-table (length key-value-pairs)))
         (table-vector (ordered-table-table ordered-table)))
    (let loop ((key-value-pairs key-value-pairs))
      (if (null? key-value-pairs)
        ordered-table
        (let* ((pair (car key-value-pairs))
              (key (car pair))
              (value (cdr pair))
              (hash (py-subtype-of-int-to-scheme (py-hash key))))
          (table-vector-set!
            ordered-table
            table-vector
            (vector-length table-vector)
            hash
            key
            value)
          (loop (cdr key-value-pairs)))))))

(define-rts (dict-setitem self key value)
  (if (py-isinstance? self py-dict-class)
    (let ((ordered-table (PyObjectDict-value self)))
      (ordered-table-set-cell! ordered-table key value))
    (py-throw-not-a-type-object "dict.__setitem__" self))
  py-None)

(define-rts dict.__setitem__
  (procedure->py-function
   dict-setitem
    (make-signature posonlyargs: (self key value))))

(define-rts (dict-get self key default)
  (if (py-isinstance? self py-dict-class)
    (let ((ordered-table (PyObjectDict-value self)))
      (ordered-table-get ordered-table key (if (eq? default py-absent) py-None default)))
    (py-throw-not-a-type-object "dict.get" self)))

(define-rts dict.get
  (procedure->py-function
    dict-get
    (make-signature posonlyargs: (self key default) defaults: (vector py-absent))))

(define-rts (dict-getitem self key)
  (if (py-isinstance? self py-dict-class)
    (let ((ordered-table (PyObjectDict-value self)))
      (ordered-table-get ordered-table key py-absent))
    (py-throw-not-a-type-object "dict.__getitem__" self)))

(define-rts dict.__getitem__
  (procedure->py-function
    dict-getitem
    (make-signature posonlyargs: (self key))))

(define-rts (dict-delitem self key)
  (if (py-isinstance? self py-dict-class)
    (let* ((ordered-table (PyObjectDict-value self))
           (res (ordered-table-remove-key! ordered-table key)))
      (if (not res)
        (py-throw (py-call py-builtin-KeyError key))
        py-None))
    (py-throw-not-a-type-object "dict.__delitem__" self)))

(define-rts dict.__delitem__
  (procedure->py-function
    dict-delitem
    (make-signature posonlyargs: (self key))))

(define-rts (dict-len self)
  (if (py-isinstance? self py-dict-class)
    (let* ((ordered-table (PyObjectDict-value self))
           (len (ordered-table-length ordered-table)))
      (py-int-from-scheme len))
    (py-throw-not-a-type-object "dict.__len__" self)))

(define-rts dict.__len__
  (procedure->py-function
    dict-len
    (make-signature posonlyargs: (self))))

(define-rts (dict-iter self)
  (if (py-isinstance? self py-dict-class)
    (dict->dict-keyiterator self)
    (py-throw-not-a-type-object "dict.__len__" self)))

(define-rts dict.__iter__
  (procedure->py-function
    dict-iter
    (make-signature posonlyargs: (self))))

;; TODO: incorrect implementation, should return a dict_keys object
(define-rts (dict-keys self)
  (if (py-isinstance? self py-dict-class)
    (dict->dict-keyiterator self)
    (py-throw-not-a-type-object "dict.keys" self)))

(define-rts dict.keys
  (procedure->py-function
    dict-keys
    (make-signature posonlyargs: (self))))

;; TODO: incorrect implementation, should return a dict_values object
(define-rts (dict-values self)
  (if (py-isinstance? self py-dict-class)
    (dict->dict-valueiterator self)
    (py-throw-not-a-type-object "dict.values" self)))

(define-rts dict.values
  (procedure->py-function
    dict-values
    (make-signature posonlyargs: (self))))

;; =============================================================================
;;  Dict iterators
;; =============================================================================

;; key iterator
(define-rts (dict->dict-keyiterator d)
  (let* ((ordered-table (PyObjectDict-value d))
        (first (ordered-table-first ordered-table))
        (token (ordered-table-iterator-token ordered-table)))
    (py-dict-keyiterator-alloc first token)))

(define-rts (dict-keyiterator-iter self)
  (if (py-isinstance? self py-dict-keyiterator-class)
    self
    (py-throw-not-a-type-object "dict_keyiterator.__iter__" self)))

(define-rts dict_keyiterator.__iter__
  (procedure->py-function
    dict-keyiterator-iter
    (make-signature posonlyargs: (self))))

(define-rts (dict-keyiterator-next self)
  (if (py-isinstance? self py-dict-keyiterator-class)
    (let ((node (PyObjectDictItemsIterator-node self))
          (token (PyObjectDictItemsIterator-iterator-token self)))
      (cond
        ((not node)
          (py-throw py-builtin-StopIteration))
        ((not (unbox token)) ;; will be #f if the dict length changed
          (py-throw-exception-with-message
            py-builtin-RuntimeError
            "dictionary changed size during iteration"))
        (else
          (let* ((cell (doubly-linked-list-node-value node))
                (key (dict-cell-key cell))
                (next (doubly-linked-list-node-next node)))
            (PyObjectDictItemsIterator-node-set! self next)
            key))))
    (py-throw-not-a-type-object "dict_keyiterator.__next__" self)))

(define-rts dict_keyiterator.__next__
  (procedure->py-function
    dict-keyiterator-next
    (make-signature posonlyargs: (self))))

(define-rts py-dict-keyiterator-class
  (py-make-builtin-class
    (&& "dict_keyiterator")
    (&& "builtins")
    (list)
      (& "__iter__") dict_keyiterator.__iter__
      (& "__next__") dict_keyiterator.__next__))

;; value iterator
(define-rts (dict->dict-valueiterator d)
  (let* ((ordered-table (PyObjectDict-value d))
        (first (ordered-table-first ordered-table))
        (token (ordered-table-iterator-token ordered-table)))
    (py-dict-valueiterator-alloc first token)))

(define-rts (dict-valueiterator-iter self)
  (if (py-isinstance? self py-dict-valueiterator-class)
    self
    (py-throw-not-a-type-object "dict_valueiterator.__iter__" self)))

(define-rts dict_valueiterator.__iter__
  (procedure->py-function
    dict-valueiterator-iter
    (make-signature posonlyargs: (self))))

(define-rts (dict-valueiterator-next self)
  (if (py-isinstance? self py-dict-valueiterator-class)
    (let ((node (PyObjectDictItemsIterator-node self))
          (token (PyObjectDictItemsIterator-iterator-token self)))
      (cond
        ((not node)
          (py-throw py-builtin-StopIteration))
        ((not (unbox token)) ;; will be #f if the dict length changed
          (py-throw-exception-with-message
            py-builtin-RuntimeError
            "dictionary changed size during iteration"))
        (else
          (let* ((cell (doubly-linked-list-node-value node))
                (value (dict-cell-value cell))
                (next (doubly-linked-list-node-next node)))
            (PyObjectDictItemsIterator-node-set! self next)
            value))))
    (py-throw-not-a-type-object "dict_valueiterator.__next__" self)))

(define-rts dict_valueiterator.__next__
  (procedure->py-function
    dict-valueiterator-next
    (make-signature posonlyargs: (self))))

(define-rts py-dict-valueiterator-class
  (py-make-builtin-class
    (&& "dict_valueiterator")
    (&& "builtins")
    (list)
      (& "__iter__") dict_valueiterator.__iter__
      (& "__next__") dict_valueiterator.__next__))

;; -----------------------------------------------------------------------------

(define-rts (bootstrap-type-hierarchy-phase2)
  ;; create number core types
  (let* ((int-class
            (py-builtin-type-alloc
                py-type-class
                (get-behavior-type-index bint)
                #f ;; can-have-getter
                (vector py-object-class) ;; bases
                #f ;; mro
                py-int-hclass-of-instances))
           (bool-class
              (py-builtin-type-alloc
                  py-type-class
                  (get-behavior-type-index bool)
                  #f ;; can-have-getter
                  (vector py-object-class) ;; bases
                  #f ;; mro
                  py-bool-hclass-of-instances))
           (float-class
              (py-builtin-type-alloc
                  py-type-class
                  (get-behavior-type-index float)
                  #f ;; can-have-getter
                  (vector py-object-class) ;; bases
                  #f ;; mro
                  py-float-hclass-of-instances))
           (function-class
              (py-builtin-type-alloc
                 py-type-class
                 (get-behavior-type-index function)
                 #t ;; can-have-getter
                 (vector py-object-class) ;; bases
                 #f ;; mro
                 py-function-hclass-of-instances)))

    ;; int
    (set! py-int-class int-class)
    (PyObjectType-mro-set! int-class (vector int-class py-object-class))
    (py-own-attr-set! int-class (& "__name__") (&& "int"))
    (py-own-attr-set! int-class (& "__module__") (&& "builtins"))
    (py-own-attr-set! int-class (& "__repr__") int.__repr__)
    (py-own-attr-set! int-class (& "__hash__") int.__hash__)
    (py-own-attr-set! int-class (& "__int__") int.__int__)

    ;; bool
    (set! py-bool-class bool-class)
    (PyObjectType-mro-set! bool-class (vector bool-class int-class py-object-class))
    (py-own-attr-set! bool-class (& "__name__") (&& "bool"))
    (py-own-attr-set! bool-class (& "__module__") (&& "builtins"))

    ;;float
    (set! py-float-class float-class)
    (PyObjectType-mro-set! float-class (vector float-class py-object-class))
    (py-own-attr-set! float-class (& "__name__") (&& "float"))
    (py-own-attr-set! float-class (& "__module__") (&& "builtins"))
    (py-own-attr-set! float-class (& "__repr__") float.__repr__)
    (py-own-attr-set! float-class (& "__int__") float.__int__)

    ;; function
    (set! py-function-class function-class)
    (PyObjectType-mro-set! function-class (vector function-class py-object-class))
    (py-own-attr-set! function-class (& "__name__") (&& "function"))
    (py-own-attr-set! function-class (& "__module__") (&& "builtins"))
    (py-own-attr-set! function-class (& "__call__") function.__call__))

  ;; Fill in tuple class
  (py-own-attr-set! py-tuple-class (& "__iter__") tuple.__iter__)
  (py-own-attr-set! py-tuple-class (& "__contains__") tuple.__contains__)
  (py-own-attr-set! py-tuple-class (& "__add__") tuple.__add__)
  (py-own-attr-set! py-tuple-class (& "__mul__") tuple.__mul__)
  (py-own-attr-set! py-tuple-class (& "__rmul__") tuple.__rmul__)
  (py-own-attr-set! py-tuple-class (& "__eq__") tuple.__eq__)
  (py-own-attr-set! py-tuple-class (& "__ne__") tuple.__ne__)
  (py-own-attr-set! py-tuple-class (& "__lt__") tuple.__lt__)
  (py-own-attr-set! py-tuple-class (& "__le__") tuple.__le__)
  (py-own-attr-set! py-tuple-class (& "__gt__") tuple.__gt__)
  (py-own-attr-set! py-tuple-class (& "__ge__") tuple.__ge__)
  (py-own-attr-set! py-tuple-class (& "__repr__") tuple.__repr__)
  (py-own-attr-set! py-tuple-class (& "__len__") tuple.__len__)
  (py-own-attr-set! py-tuple-class (& "__getitem__") tuple.__getitem__)
  (py-own-attr-set! py-tuple-class (& "count") tuple.count)
  (py-own-attr-set! py-tuple-class (& "index") tuple.index)

  (set! py-module-class
    (py-make-builtin-class
     (&& "module")
     (&& "builtins")
     (list)
     (& "__dir__") module.__dir__
     (& "__getattribute__") module.__getattribute__
     (& "__setattr__") module.__setattr__))

  (set! py-complex-class
    (py-make-builtin-class
     (& "complex")
     (& "builtins")
     (list)))

  (set! py-generator-class
    (py-make-builtin-class
     (&& "generator")
     (&& "builtins")
     (list)
     (& "__new__") generator.__new__
     (& "__next__") generator.__next__
     (& "__iter__") generator.__iter__
     (& "send") generator.send
     (& "throw") generator.throw
     (& "close") generator.close))

  (set! py-slice-class
    (py-make-builtin-class
     (&& "slice")
     (&& "builtins")
     (list)
     (& "__new__") slice.__new__
     (& "indices") slice.indices))

  (set! py-list-class
    (py-make-builtin-class
     (&& "list")
     (&& "builtins")
     (list)
     (& "__new__") list.__new__
     (& "__iter__") list.__iter__
     (& "__contains__") list.__contains__
     (& "__getitem__") list.__getitem__
     (& "__setitem__") list.__setitem__
     (& "__delitem__") list.__delitem__
     (& "__eq__") list.__eq__
     (& "__ne__") list.__ne__
     (& "__lt__") list.__lt__
     (& "__le__") list.__le__
     (& "__gt__") list.__gt__
     (& "__ge__") list.__ge__
     (& "__repr__") list.__repr__
     (& "__len__") list.__len__
     (& "__add__") list.__add__
     (& "__iadd__") list.__iadd__
     (& "__mul__") list.__mul__
     (& "__rmul__") list.__rmul__
     (& "__imul__") list.__imul__
     (& "pop") list.pop
     (& "append") list.append
     (& "clear") list.clear
     (& "copy") list.copy
     (& "count") list.count
     (& "index") list.index
     (& "remove") list.remove
     (& "insert") list.insert
     (& "extend") list.extend
     (& "reverse") list.reverse
     (& "sort") #f ;; set later from py-builtin-sorted

     ))

  (set! py-dict-class
    (py-make-builtin-class
     (&& "dict")
     (&& "builtins")
     (list)
     (& "__getitem__") dict.__getitem__
     (& "__setitem__") dict.__setitem__
     (& "__delitem__") dict.__delitem__
     (& "__len__") dict.__len__
     (& "__iter__") dict.__iter__
     (& "keys") dict.keys
     (& "values") dict.values
     (& "get") dict.get))

  (set! py-set-class
    (py-make-builtin-class
     (&& "set")
     (&& "builtins")
     (list)))

  (set! py-bytearray-class
    (py-make-builtin-class
      (&& "bytearray")
      (&& "builtins")
      (list)
        (& "__getitem__") bytearray.__getitem__
        (& "__new__") bytearray.__new__
        (& "__setitem__") bytearray.__setitem__
        (& "__repr__") bytearray.__repr__
        (& "__add__") bytearray.__add__
        (& "__iadd__") bytearray.__iadd__
        (& "__mul__") bytearray.__mul__
        (& "__rmul__") bytearray.__rmul__
        (& "__imul__") bytearray.__imul__
        (& "__len__") bytearray.__len__
        (& "append") bytearray.append
        (& "count") bytearray.count
        (& "find") bytearray.find
        (& "index") bytearray.index
        (& "rindex") bytearray.rindex
        (& "rfind") bytearray.rfind
        (& "__eq__") bytearray.__eq__
        (& "__lt__") bytearray.__lt__
        (& "__le__") bytearray.__le__
        (& "__gt__") bytearray.__gt__
        (& "__ge__") bytearray.__ge__
        (& "__ne__") bytearray.__ne__
        (& "__iter__") bytearray.__iter__
        ))
      )

(bootstrap-type-hierarchy-phase2)

(define-rts py-True (py-subtype-of-int-from-scheme 1 py-bool-class))
(define-rts py-False (py-subtype-of-int-from-scheme 0 py-bool-class))

(bootstrap-functions)

;; =============================================================================
;;  IO
;; =============================================================================
;; TODO: some content of this section should be moved to the io module

(define-rts (TextIOWrapper-enter self)
  (if (py-isinstance? self py-TextIOWrapper-class)
    self
    (py-throw-not-a-type-object "TextIOWrapper.__enter__" self)))

(define-rts TextIOWrapper.__enter__
  (procedure->py-function
    TextIOWrapper-enter
    (make-signature posonlyargs: (self))))

(define-rts (TextIOWrapper-close-port! self)
  (let ((port (PyObjectTextIOWrapper-port self)))
    ;; Some ports may stay open even after close-port, by dereferencing
    ;; the port we make sure its ressources are freed by the gc
    ;; we thus have to first check the port was not already closed (ie. set to #f)
    ;; and then we fully close it by setting the port attribute to #f
    (if port
      (begin
        (close-port port)
        (PyObjectTextIOWrapper-port-set! self #f)))))

(define-rts (TextIOWrapper-exit self exc-type exc exc-traceback)
  (if (py-isinstance? self py-TextIOWrapper-class)
    (TextIOWrapper-close-port! self)
    (py-throw-not-a-type-object "TextIOWrapper.__exit__" self))
  py-None)

(define-rts TextIOWrapper.__exit__
  (procedure->py-function
    TextIOWrapper-exit
    (make-signature posonlyargs: (self exc_type exc_value traceback))))

(define-rts (TextIOWrapper-close self)
  (if (py-isinstance? self py-TextIOWrapper-class)
    (TextIOWrapper-close-port! self)
    (py-throw-not-a-type-object "TextIOWrapper.close" self))
  py-None)

(define-rts TextIOWrapper.close
  (procedure->py-function
    TextIOWrapper-close
    (make-signature posonlyargs: (self))))

(define-rts (TextIOWrapper-read self)
  (if (py-isinstance? self py-TextIOWrapper-class)
    (let ((port (PyObjectTextIOWrapper-port self)))
      (if port
          (py-str-from-scheme (read-string port))
        (py-throw-exception-with-message
          py-builtin-ValueError
          "I/O operation on closed file.")))
    (py-throw-not-a-type-object "TextIOWrapper.read" self)))

(define-rts TextIOWrapper.read
  (procedure->py-function
    TextIOWrapper-read
    (make-signature posonlyargs: (self))))

(define-rts py-TextIOWrapper-class
  (py-make-builtin-class
    (&& "TextIOWrapper")
    (&& "_io")
    ;; TODO: the correct mro is actually [<class '_io.TextIOWrapper'>, <class '_io._TextIOBase'>, <class '_io._IOBase'>, <class 'object'>]
    (list)
      (& "__enter__") TextIOWrapper.__enter__
      (& "__exit__") TextIOWrapper.__exit__
      (& "close") TextIOWrapper.close
      (& "read") TextIOWrapper.read))

;; TODO: arguments other than file are currentl ignored
(define-rts (py-open file mode buffering encoding errors newline closefd opener)
  (cond ((py-subtype-of-str? file)
         (let ((filename (py-subtype-of-str-to-scheme file)))
           (let ((file-port (open-file filename)))
             (py-TextIOWrapper-alloc
              file-port
              mode
              encoding))))
        (else
         (py-throw-exception-with-message py-builtin-NotImplementedError "py-open only str filename supported"))))

;; =============================================================================
;;  Singletons
;; =============================================================================

;; True and False



;; NotImplemented object

(define-rts (NotImplementedType-new cls)
  (if (eq? cls py-NotImplementedType-class)
    py-NotImplemented
    (py-throw
      (py-call
        py-builtin-TypeError
        ;; TODO: Incorrect error message
        (&& "not a subtype of NotImplementedType")))))

(define-rts NotImplementedType.__new__
  (procedure->py-function
    NotImplementedType-new
    (make-signature posonlyargs: (cls))))

(define-rts (NotImplementedType-repr self)
  (if (eq? self py-NotImplemented)
    (&& "NotImplemented")
    (py-throw
      (py-call
        py-builtin-TypeError
        ;; TODO: Incorrect error message
        (&& "descriptor '__repr__' requires a 'NotImplementedType' object")))))

(define-rts NotImplementedType.__repr__
  (procedure->py-function
    NotImplementedType-repr
    (make-signature posonlyargs: (self))))

(define-rts py-NotImplementedType-class
  (py-make-builtin-class
    (&& "NotImplementedType")
    (&& "builtins")
    (list)
      (& "__new__") NotImplementedType.__new__
      (& "__repr__") NotImplementedType.__repr__))

(define-rts py-NotImplemented (py-obj-alloc py-NotImplementedType-class))

;; None object

(define-rts (NoneType-new cls)
  (if (eq? cls py-NoneType-class)
    py-None
    (py-throw
      (py-call
        py-builtin-TypeError
        ;; TODO: Incorrect error message
        (&& "not a subtype of NoneType")))))

(define-rts NoneType.__new__
  (procedure->py-function
    NoneType-new
    (make-signature posonlyargs: (cls))))

(define-rts (NoneType-repr self)
  (if (eq? self py-None)
    (&& "None")
    (py-throw
      (py-call
        py-builtin-TypeError
        ;; TODO: Incorrect error message
        (&& "descriptor '__repr__' requires a 'NoneType' object")))))

(define-rts NoneType.__repr__
  (procedure->py-function
    NoneType-repr
    (make-signature posonlyargs: (self))))

(define-rts (NoneType-bool self)
  (if (eq? self py-None)
    py-False
    (py-throw
      (py-call
        py-builtin-TypeError
        ;; TODO: Incorrect error message
        (&& "descriptor '__repr__' requires a 'NoneType' object")))))

(define-rts NoneType.__bool__
  (procedure->py-function
    NoneType-bool
    (make-signature posonlyargs: (self))))

(define-rts py-NoneType-class
  (py-make-builtin-class
    (&& "NoneType")
    (&& "builtins")
    (list)
      (& "__new__") NoneType.__new__
      (& "__repr__") NoneType.__repr__
      (& "__bool__") NoneType.__bool__))

(define-rts py-None (py-obj-alloc py-NoneType-class))

;;;----------------------------------------------------------------------------

(define-rts (py-make-set elements)
  (py-set-from-scheme elements))

(define-rts (py-make-tuple . elements)
  (py-tuple-from-scheme (list->vector elements)))

(define-rts (py-tuple-from-scheme elements)
  (make-PyObjectTuple
    py-tuple-hclass-of-instances
    '#()
    py-tuple-class
    elements))

(define-rts (py-tuple-subtype-from-scheme elements cls)
  (make-PyObjectTuple
    (PyObjectType-hclass-of-instances cls)
    '#()
    cls
    elements))

(define-rts py-make-dict py-dict-from-scheme)

(define-rts (py-type obj)
  (py-obj-cls obj))

;; ----------------------
;; builtins initialization
;; ---------------------

(define-rts (py-make-global)
  (py-module-alloc py-module-class py-module-hclass-of-instances))

(define-rts (py-make-module name package #!optional (path #f))
  (let ((mod (py-make-global))
        (modules (sys.modules-get)))
   (global-own-attr-put-no-cache! mod (& "__name__") name)
   (global-own-attr-put-no-cache! mod (& "__package__") package)
   (if path (global-own-attr-put-no-cache! mod (& "__path__") path))
   (dict-setitem modules name mod)
   mod))

;; ===========================================
;; IMPORT SYSTEM
;; ===========================================


(define-rts zipi-stdlib-dir
  (let ((default-dir
          (list (path-expand (path-expand "libs" "stdlib") (path-expand "~~zipiroot"))
                (path-expand "zipitestlib" (path-expand "~~zipiroot"))))
        (env-dir
         (list
          (get-environment-variable "PYTHONPATH")
          (get-environment-variable "ZIPIPATH"))))
    (fold (lambda (env r)
            (if env (append (string-split env #\:) r) r))
          default-dir
          env-dir)))

;; note here that we assume that the list is at least of size 1 and contains as first argument the filename
(define-rts (command-line-argv-set! list-with-file-name)
  (global-own-attr-put-no-cache! sys-mod (& "argv")
       (py-make-list-from-elems (map py-str-from-scheme-fallback list-with-file-name))))

(define-rts (py-make-sys-mod)
  (let ((mod (py-make-global)))
   (global-own-attr-put-no-cache! mod (& "__name__") (&& "_sys"))
   (global-own-attr-put-no-cache! mod (& "modules")
                     (py-make-dict (list (cons (&& "_sys") mod))))

   (global-own-attr-put-no-cache! mod (& "maxsize") (py-int-from-scheme max-fixnum))
   (global-own-attr-put-no-cache! mod (& "path")
    (py-make-list-from-elems (map py-str-from-scheme-fallback zipi-stdlib-dir)))
   (global-own-attr-put-no-cache! mod (& "builtin_module_names")
    (py-tuple-from-scheme (list->vector (map py-str-from-scheme-fallback (list "_sys" "_time" "builtins" "itertools" "math" "random" "sys" "time")))))
   mod))

(define-rts sys-mod (py-make-sys-mod))

(define-rts (sys.modules-get)
  (global-own-attr-ref-no-cache sys-mod (& "modules")))

(define-rts (sys.path-get)
  (global-own-attr-ref-no-cache sys-mod (& "path")))

;; == CACHE SYSTEM ==

;; WARNING : dont change this location without knowing what you do because (delete-zipi-cache) in run-zipi recursively deletes this directory
(define-rts zipicache #f)

(define-rts (cache-location-set! path)
  (set! zipicache path))

(define-rts (cache-location-get) zipicache)

(define-rts compile-flag #f)
(define-rts (compile-flag-set! value)
  (set! compile-flag value))

(define-rts debug-flag #f)
(define-rts (debug-flag-set! value)
  (set! debug-flag value))

(define-rts profile-flag #f)
(define-rts (profile-flag-set! value)
  (set! profile-flag value))

(define-rts expansion-flag #f)
(define-rts (expansion-flag-set! value)
  (set! expansion-flag value))


;; mangle path of modules in cache to be valid scheme module names
(define-rts (mangle-cache-path path)
  (define (char-in-range? c lo hi)
    (and (char>=? c lo) (char<=? c hi)))

  (define (char-map c)
    (cond
      ((or (char-in-range? c #\a #\z)
           (char-in-range? c #\A #\Z)
           (char-in-range? c #\0 #\9)
           (char=? c #\/))
        (string c))
      ((char=? c #\_)
        "__")
      (else
        (string-append "_" (number->string (char->integer c) 16)))))

  (append-strings (map char-map (string->list path))))

;; py-module.__path__ can be #f in the case of non-package importation
(define-rts (compile-and-get-mod path path-info py-__name__ py-__package__ py-module.__path__)

  ;; useful for debugging
  (if expansion-flag
      (cond-expand
        (gambit
         (|##build-module-subprocess-default-options-set!| '((expansion))))
        (bigloo
         #f)))

  (let* ((path-in-cache (mangle-cache-path (substring path 1 (string-length path)))) ;; remove trailing /
         (mod-init
          (and
            (compile-to-cache path path-info path-in-cache)
            ;; TODO : for windows user, the path is not formated with a / before
            (load-module-and-get-init path-in-cache))))
    (if (procedure? mod-init)
        (mod-init py-__name__ py-__package__ py-module.__path__)
        #f)))

(define-rts (import-with-zipi-cache path py-__name__ py-__package__)
  (let* ((path-package (path-expand "__init__.py" path))
         (path-package-info (file-info path-package #t #f)))
    (if path-package-info
        (compile-and-get-mod path-package path-package-info py-__name__ py-__name__ (py-make-list (py-str-from-scheme path)))
        (let* ((path-mod (string-append path ".py"))
               (path-mod-info (file-info path-mod #t #f)))
          (if path-mod-info
              (compile-and-get-mod path-mod path-mod-info py-__name__ py-__package__ #f)
              #f
              )))))

(define-rts (import-from-sys.path sys.path __name__ py-__name__ py-__package__)
  (or (dict-get (sys.modules-get) py-__name__ #f)
      (let ((sys.path-iter (py-iter sys.path)))
        (let loop ((value sys.path-iter))
          (let ((value (py-next value)))
            (and value
                 (if (py-subtype-of-str? value) ;; TODO : support bytes
                     (let ((path (string-append
                                  (path-normalize
                                   (py-subtype-of-str-to-scheme value))
                                  __name__)))
                       (or (import-with-zipi-cache path py-__name__ py-__package__)
                           (loop sys.path-iter)))
                     (loop sys.path-iter))))))))

(define-rts (default-builtin-__import__ __name__)
   (let ((name-split (string-split __name__ #\.)))
    (let loop ((sys.path (sys.path-get))
               (name-split name-split)
               (name-cumulative (car name-split))
               (package-name py-None)
               (last-module #f))
      (let* ((py-name-cumulative (py-str-from-scheme name-cumulative))
             (module (import-from-sys.path sys.path
                                           (car name-split)
                                           py-name-cumulative package-name)))
       (if (and module (py-isinstance? module py-module-class))
           (begin
             (if last-module
                 (global-own-attr-put-no-cache! last-module
                                                (py-str-from-scheme (car name-split))
                                                module))
             (if (pair? (cdr name-split))
                 (let ((module.__path__ (global-own-attr-ref-no-cache module (& "__path__"))))
                  (if (eq? py-absent module.__path__)
                      (py-throw-exception-with-message
                        py-builtin-ModuleNotFoundError
                        "No module named '" __name__ "'; " (car name-split) " is not a package")
                      (loop module.__path__
                            (cdr name-split)
                            (string-append name-cumulative "." (cadr name-split))
                            py-name-cumulative
                            module)))
                 module))
           (py-throw-exception-with-message
             py-builtin-ModuleNotFoundError
             "No module named '" __name__ "'"))))))

(define-rts (builtin-__import__ __name__)
   (or (native-builtin-__import__ __name__)
       (default-builtin-__import__ __name__)))

(define-rts (string-join separator list length)
  (string-join-recur separator (cdr list) (- length 1) (car list)))

(define-rts (string-join-recur separator list length string)
  (if (or (<= length 0) (pair? list))
      string
      (string-join-recur separator (cdr list) (- length 1) (string-append string separator (car list)))))

(define-rts (py-path-join path1 path2)
  (if (string=? path1 "")
      path2
      (if (string=? path2 "")
          path1
          (string-append path1 "." path2))))

;; asuming depth > 0 and path can be ""
(define-rts (py-import-relative selfmod path from-list depth)
  (let* ((__package__ (global-own-attr-ref-no-cache selfmod (& "__package__")))
         (levels (string-split (if (or (not __package__)
                                       (py-test-is __package__ py-None))
                                   ;; the real protocol checks __name__ in this case
                                   (py-throw-exception-with-message py-builtin-ImportError "attempted relative import with no known parent package")
                                   (py-str-to-scheme __package__))
                               #\.))
         (levels-length (length levels)))
    (if (> levels-length depth)
        (py-throw-exception-with-message py-builtin-ImportError "attempted relative import with no known parent package")
        (let* ((parent-module-name (py-path-join (string-join "." levels (- levels-length depth))
                                                 path)))
          (py-import parent-module-name from-list)))))

(define-rts (py-import path from-list)
  (let ((mod (builtin-__import__ path))
        (py-path (py-str-from-scheme-fallback path)))
    (for-each
      (lambda (from)
        (let* ((py-from (py-str-from-scheme-fallback from))
               (module.from (global-own-attr-ref-no-cache mod py-from)))
          (or module.from
              (begin
                (py-import (string-append path "." from) '())
                (let ((module.from (global-own-attr-ref-no-cache mod py-from)))
                 (if (not module.from)
                     (py-throw-exception-with-message py-builtin-ImportError "Cannot import name '" from "' from '" path "'")
                     (begin
                       (global-own-attr-put-no-cache! mod py-from module.from)
                       module.from))))
              module.from)))
      from-list)
    mod))

(define-rts (run-as-main path zipicache)
  (cache-location-set! zipicache)
  (module-search-order-add! (cache-location-get))

  (let ((sys.modules (sys.modules-get)))
     (list-append (sys.path-get) (py-str-from-scheme (path-directory path)))
     (py-try-except
	(lambda (e)
	   (print-exception e (current-error-port))
	   (exit 1))
	(lambda ()
	   
	   (if profile-flag
	       (statprof-begin profile-flag))
	   
	   (compile-and-get-mod path (file-info path) (& "__main__") py-None #f)
	   
	   (if profile-flag
	       (statprof-end path))))))

(define-rts (run-as-module path zipicache mod-init)
  (cache-location-set! zipicache)
  (module-search-order-add! (cache-location-get))

  (let ((sys.modules (sys.modules-get)))
     (list-append (sys.path-get) (py-str-from-scheme (path-directory path)))
	   
     (if profile-flag
	 (statprof-begin profile-flag))

     (mod-init (& "__main__") py-None #f)
	   
     (if profile-flag
	 (statprof-end path))))

(define-rts py-import-root (current-directory))

;; MODULES

;; time

(define-rts time.clock_getres
  (procedure->py-function
    (lambda (clk_id)
      (py-float-from-scheme 1e-6))
    (make-signature posonlyargs: (clk_id))))

(define-rts time.clock_gettime
  (procedure->py-function
    (lambda (clk_id)
      (py-float-from-scheme (time->seconds (current-time))))
    (make-signature posonlyargs: (clk_id))))

(define-rts time.monotonic
  (procedure->py-function
    (lambda ()
      (py-float-from-scheme (time->seconds (current-time))))
    (make-signature)))

(define-rts time.perf_counter
  (procedure->py-function
    (lambda ()
      (py-float-from-scheme (time->seconds (current-time))))
    (make-signature)))

(define-rts time.process_time
  (procedure->py-function
    (lambda ()
      (py-float-from-scheme (time->seconds (current-time))))
    (make-signature)))

(define-rts time.time
  (procedure->py-function
    (lambda ()
      (py-float-from-scheme (time->seconds (current-time))))
    (make-signature)))

(define-rts time.thread_time
  (procedure->py-function
    (lambda ()
      (py-float-from-scheme (time->seconds (current-time))))
    (make-signature)))

(define-rts time.sleep
  (procedure->py-function
    (lambda (secs)
      (let ((s (py-float-to-scheme secs)))
        (cond-expand
          (gambit (thread-sleep! s))
          (bigloo (sleep (floor (inexact->exact (* s 1e6))))))
        py-None))
    (make-signature posonlyargs: (secs))))

(define-rts (make-time-mod)
  (let ((mod (py-make-module (& "_time") (& "") #f)))
    (global-own-attr-put-no-cache! mod (& "clock_getres") time.clock_getres)
    (global-own-attr-put-no-cache! mod (& "clock_gettime") time.clock_gettime)
    (global-own-attr-put-no-cache! mod (& "monotonic") time.monotonic)
    (global-own-attr-put-no-cache! mod (& "perf_counter") time.perf_counter)
    (global-own-attr-put-no-cache! mod (& "process_time") time.process_time)
    (global-own-attr-put-no-cache! mod (& "time") time.time)
    (global-own-attr-put-no-cache! mod (& "thread_time") time.thread_time)
    (global-own-attr-put-no-cache! mod (& "sleep") time.sleep)))

(make-time-mod)

;; statprof

(define-rts statprof.begin
  (procedure->py-function
    statprof-begin
    (make-signature)))

(define-rts statprof.end
  (procedure->py-function
    statprof-end
    (make-signature posonlyargs: (file))))

(define-rts (make-statprof-mod)
  (let ((mod (py-make-module (&& "statprof") (& "") #f)))
   (global-own-attr-put-no-cache! mod (& "begin") statprof.begin)
   (global-own-attr-put-no-cache! mod (& "end") statprof.end)))

(make-statprof-mod)

;; ===========================================
;; BUITLINS
;; ===========================================

;;-------------------- abs(x)

;; Return the absolute value of a number. The argument may be an
;; integer or a floating point number. If the argument is a complex
;; number, its magnitude is returned. If x defines __abs__(), abs(x)
;; returns x.__abs__().

(define-rts py-builtin-abs
  (procedure->py-function
    py-abs
    (make-signature posonlyargs: (x))))

;;-------------------- all(iterable)

;; Return True if all elements of the iterable are true (or if the
;; iterable is empty). Equivalent to:
;;
;; def all(iterable):
;;     for element in iterable:
;;         if not element:
;;             return False
;;     return True

(define-rts py-builtin-all
  (procedure->py-function
    (lambda (iterable)
      (py-throw-exception-with-message py-builtin-NotImplementedError "all not implemented"))
    (make-signature posonlyargs: (iterable))))

;;-------------------- any(iterable)

;; Return True if any element of the iterable is true. If the iterable is
;; empty, return False. Equivalent to:
;;
;; def any(iterable):
;;     for element in iterable:
;;         if element:
;;             return True
;;     return False

(define-rts py-builtin-any
  (procedure->py-function
    (lambda (iterable)
      (py-throw-exception-with-message py-builtin-NotImplementedError "any not implemented"))
    (make-signature posonlyargs: (iterable))))

;;-------------------- ascii(object)

;; As repr(), return a string containing a printable representation of an
;; object, but escape the non-ASCII characters in the string returned by
;; repr() using \x, \u or \U escapes. This generates a string similar to
;; that returned by repr() in Python 2.

(define-rts py-builtin-ascii
  (procedure->py-function
    (lambda (object)
      (py-throw-exception-with-message py-builtin-NotImplementedError "ascii not implemented"))
    (make-signature posonlyargs: (object))))

;;-------------------- bin(x)

;; Convert an integer number to a binary string prefixed with “0b”. The
;; result is a valid Python expression. If x is not a Python int object,
;; it has to define an __index__() method that returns an integer. Some
;; examples:
;;
;; >>> bin(3)
;; '0b11'
;; >>> bin(-10)
;; '-0b1010'
;;
;; If prefix “0b” is desired or not, you can use either of the following ways.
;;
;; >>> format(14, '#b'), format(14, 'b')
;; ('0b1110', '1110')
;; >>> f'{14:#b}', f'{14:b}'
;; ('0b1110', '1110')
;;
;; See also format() for more information.

(define-rts py-builtin-bin
  (procedure->py-function
    (lambda (x)
      (py-throw-exception-with-message py-builtin-NotImplementedError "bin not implemented"))
    (make-signature posonlyargs: (x))))

;;-------------------- class bool([x])

;; Return a Boolean value, i.e. one of True or False. x is converted
;; using the standard truth testing procedure. If x is false or omitted,
;; this returns False; otherwise it returns True. The bool class is a
;; subclass of int (see Numeric Types — int, float, complex). It cannot
;; be subclassed further. Its only instances are False and True (see
;; Boolean Values).
;;
;; Changed in version 3.7: x is now a positional-only parameter.

(define-rts py-builtin-bool #f)

;;-------------------- breakpoint(*args, **kws)

;; This function drops you into the debugger at the call
;; site. Specifically, it calls sys.breakpointhook(), passing args and
;; kws straight through. By default, sys.breakpointhook() calls
;; pdb.set_trace() expecting no arguments. In this case, it is purely a
;; convenience function so you don’t have to explicitly import pdb or
;; type as much code to enter the debugger. However, sys.breakpointhook()
;; can be set to some other function and breakpoint() will automatically
;; call that, allowing you to drop into the debugger of choice.
;;
;; New in version 3.7.

(define-rts py-builtin-breakpoint
  (procedure->py-function
    (lambda (args kwargs)
      (py-throw-exception-with-message py-builtin-NotImplementedError "breakpoint not implemented"))
    (make-signature
      vararg: args
      kwarg: kwargs)))

    ;;-------------------- class bytearray([source[, encoding[, errors]]])

;; Return a new array of bytes. The bytearray class is a mutable sequence
;; of integers in the range 0 <= x < 256. It has most of the usual
;; methods of mutable sequences, described in Mutable Sequence Types, as
;; well as most methods that the bytes type has, see Bytes and Bytearray
;; Operations.
;;
;; The optional source parameter can be used to initialize the array in a
;; few different ways:
;;
;; If it is a string, you must also give the encoding (and optionally,
;; errors) parameters; bytearray() then converts the string to bytes
;; using str.encode().  If it is an integer, the array will have that
;; size and will be initialized with null bytes.  If it is an object
;; conforming to the buffer interface, a read-only buffer of the object
;; will be used to initialize the bytes array.  If it is an iterable, it
;; must be an iterable of integers in the range 0 <= x < 256, which are
;; used as the initial contents of the array.  Without an argument, an
;; array of size 0 is created.
;;
;; See also Binary Sequence Types — bytes, bytearray, memoryview and
;; Bytearray Objects.

(define-rts py-builtin-bytearray py-bytearray-class)
;;-------------------- class bytes([source[, encoding[, errors]]])

;; Return a new “bytes” object, which is an immutable sequence of
;; integers in the range 0 <= x < 256. bytes is an immutable version of
;; bytearray – it has the same non-mutating methods and the same indexing
;; and slicing behavior.
;;
;; Accordingly, constructor arguments are interpreted as for bytearray().
;;
;; Bytes objects can also be created with literals, see String and Bytes
;; literals.
;;
;; See also Binary Sequence Types — bytes, bytearray, memoryview, Bytes
;; Objects, and Bytes and Bytearray Operations.

(define-rts py-builtin-bytes
  (procedure->py-function
    (lambda (source encoding errors)
      (py-throw-exception-with-message py-builtin-NotImplementedError "bytes not implemented"))
    (make-signature
      posonlyargs: (source encodings errors)
      defaults: (vector py-absent py-absent py-absent))))

    ;;-------------------- callable(object)

;; Return True if the object argument appears callable, False if not. If
;; this returns true, it is still possible that a call fails, but if it
;; is false, calling object will never succeed. Note that classes are
;; callable (calling a class returns a new instance); instances are
;; callable if their class has a __call__() method.
;;
;; New in version 3.2: This function was first removed in Python 3.0 and
;; then brought back in Python 3.2.

(define-rts py-builtin-callable
  (procedure->py-function
    (lambda (object)
      (py-throw-exception-with-message py-builtin-NotImplementedError "callable not implemented"))
    (make-signature posonlyargs: (object))))

;;-------------------- chr(i)

;; Return the string representing a character whose Unicode code point is
;; the integer i. For example, chr(97) returns the string 'a', while
;; chr(8364) returns the string '€'. This is the inverse of ord().
;;
;; The valid range for the argument is from 0 through 1,114,111 (0x10FFFF
;; in base 16). ValueError will be raised if i is outside that range.

(define-rts py-builtin-chr
  (procedure->py-function
    py-chr
    (make-signature posonlyargs: (i))))

;;-------------------- @classmethod

;; Transform a method into a class method.
;;
;; A class method receives the class as implicit first argument, just
;; like an instance method receives the instance. To declare a class
;; method, use this idiom:
;;
;; class C:
;;     @classmethod
;;     def f(cls, arg1, arg2, ...): ...
;;
;; The @classmethod form is a function decorator – see Function
;; definitions for details.
;;
;; A class method can be called either on the class (such as C.f()) or on
;; an instance (such as C().f()). The instance is ignored except for its
;; class. If a class method is called for a derived class, the derived
;; class object is passed as the implied first argument.
;;
;; Class methods are different than C++ or Java static methods. If you
;; want those, see staticmethod().
;;
;; For more information on class methods, see The standard type hierarchy.

(define-rts py-builtin-classmethod #f)

;;-------------------- compile(source, filename, mode, flags=0, dont_inherit=False, optimize=-1)

;; Compile the source into a code or AST object. Code objects can be
;; executed by exec() or eval(). source can either be a normal string, a
;; byte string, or an AST object. Refer to the ast module documentation
;; for information on how to work with AST objects.
;;
;; The filename argument should give the file from which the code was
;; read; pass some recognizable value if it wasn’t read from a file
;; ('<string>' is commonly used).
;;
;; The mode argument specifies what kind of code must be compiled; it can
;; be 'exec' if source consists of a sequence of statements, 'eval' if it
;; consists of a single expression, or 'single' if it consists of a
;; single interactive statement (in the latter case, expression
;; statements that evaluate to something other than None will be
;; printed).
;;
;; The optional arguments flags and dont_inherit control which future
;; statements affect the compilation of source. If neither is present (or
;; both are zero) the code is compiled with those future statements that
;; are in effect in the code that is calling compile(). If the flags
;; argument is given and dont_inherit is not (or is zero) then the future
;; statements specified by the flags argument are used in addition to
;; those that would be used anyway. If dont_inherit is a non-zero integer
;; then the flags argument is it – the future statements in effect around
;; the call to compile are ignored.
;;
;; Future statements are specified by bits which can be bitwise ORed
;; together to specify multiple statements. The bitfield required to
;; specify a given feature can be found as the compiler_flag attribute on
;; the _Feature instance in the __future__ module.
;;
;; The optional argument flags also controls whether the compiled source
;; is allowed to contain top-level await, async for and async with. When
;; the bit ast.PyCF_ALLOW_TOP_LEVEL_AWAIT is set, the return code object
;; has CO_COROUTINE set in co_code, and can be interactively executed via
;; await eval(code_object).
;;
;; The argument optimize specifies the optimization level of the
;; compiler; the default value of -1 selects the optimization level of
;; the interpreter as given by -O options. Explicit levels are 0 (no
;; optimization; __debug__ is true), 1 (asserts are removed, __debug__ is
;; false) or 2 (docstrings are removed too).
;;
;; This function raises SyntaxError if the compiled source is invalid,
;; and ValueError if the source contains null bytes.
;;
;; If you want to parse Python code into its AST representation, see
;; ast.parse().
;;
;; Raises an auditing event compile with arguments source and
;; filename. This event may also be raised by implicit compilation.
;;
;; Note When compiling a string with multi-line code in 'single' or
;; 'eval' mode, input must be terminated by at least one newline
;; character. This is to facilitate detection of incomplete and complete
;; statements in the code module.  Warning It is possible to crash the
;; Python interpreter with a sufficiently large/complex string when
;; compiling to an AST object due to stack depth limitations in Python’s
;; AST compiler.  Changed in version 3.2: Allowed use of Windows and Mac
;; newlines. Also input in 'exec' mode does not have to end in a newline
;; anymore. Added the optimize parameter.
;;
;; Changed in version 3.5: Previously, TypeError was raised when null
;; bytes were encountered in source.
;;
;; New in version 3.8: ast.PyCF_ALLOW_TOP_LEVEL_AWAIT can now be passed
;; in flags to enable support for top-level await, async for, and async
;; with.

(define-rts py-builtin-compile
  (procedure->py-function
    (lambda (source filename mode flags dont_inherit optimize)
      (py-throw-exception-with-message py-builtin-NotImplementedError "compile not implemented"))
    (make-signature
      args: (source filename mode flags dont_inherit optimize)
      defaults:
        (vector
          (py-int-from-scheme 0)
          py-False
          (py-int-from-scheme -1)))))

;;-------------------- class complex([real[, imag]])

;; Return a complex number with the value real + imag*1j or convert a
;; string or number to a complex number. If the first parameter is a
;; string, it will be interpreted as a complex number and the function
;; must be called without a second parameter. The second parameter can
;; never be a string. Each argument may be any numeric type (including
;; complex). If imag is omitted, it defaults to zero and the constructor
;; serves as a numeric conversion like int and float. If both arguments
;; are omitted, returns 0j.
;;
;; For a general Python object x, complex(x) delegates to
;; x.__complex__(). If __complex__() is not defined then it falls back to
;; __float__(). If __float__() is not defined then it falls back to
;; __index__().
;;
;; Note When converting from a string, the string must not contain
;; whitespace around the central + or - operator. For example,
;; complex('1+2j') is fine, but complex('1 + 2j') raises ValueError.  The
;; complex type is described in Numeric Types — int, float, complex.
;;
;; Changed in version 3.6: Grouping digits with underscores as in code
;; literals is allowed.
;;
;; Changed in version 3.8: Falls back to __index__() if __complex__() and
;; __float__() are not defined.

(define-rts py-builtin-complex py-complex-class)

;;-------------------- delattr(object, name)

;; This is a relative of setattr(). The arguments are an object and a
;; string. The string must be the name of one of the object’s
;; attributes. The function deletes the named attribute, provided the
;; object allows it. For example, delattr(x, 'foobar') is equivalent to
;; del x.foobar.

(define-rts py-builtin-delattr
  (procedure->py-function
    (lambda (object name)
      (py-throw-exception-with-message py-builtin-NotImplementedError "delattr not implemented"))
    (make-signature posonlyargs: (object name))))

;;-------------------- class dict(**kwarg)
;;                     class dict(mapping, **kwarg)
;;                     class dict(iterable, **kwarg)

;; Create a new dictionary. The dict object is the dictionary class. See
;; dict and Mapping Types — dict for documentation about this class.
;;
;; For other containers see the built-in list, set, and tuple classes, as
;; well as the collections module.

(define-rts py-builtin-dict py-dict-class)

;;-------------------- dir([object])

;; Without arguments, return the list of names in the current local
;; scope. With an argument, attempt to return a list of valid attributes
;; for that object.
;;
;; If the object has a method named __dir__(), this method will be called
;; and must return the list of attributes. This allows objects that
;; implement a custom __getattr__() or __getattribute__() function to
;; customize the way dir() reports their attributes.
;;
;; If the object does not provide __dir__(), the function tries its best
;; to gather information from the object’s __dict__ attribute, if
;; defined, and from its type object. The resulting list is not
;; necessarily complete, and may be inaccurate when the object has a
;; custom __getattr__().
;;
;; The default dir() mechanism behaves differently with different types
;; of objects, as it attempts to produce the most relevant, rather than
;; complete, information:
;;
;; If the object is a module object, the list contains the names of the
;; module’s attributes.  If the object is a type or class object, the
;; list contains the names of its attributes, and recursively of the
;; attributes of its bases.  Otherwise, the list contains the object’s
;; attributes’ names, the names of its class’s attributes, and
;; recursively of the attributes of its class’s base classes.  The
;; resulting list is sorted alphabetically. For example:
;;
;; >>> import struct
;; >>> dir()   # show the names in the module namespace  # doctest: +SKIP
;; ['__builtins__', '__name__', 'struct']
;; >>> dir(struct)   # show the names in the struct module # doctest: +SKIP
;; ['Struct', '__all__', '__builtins__', '__cached__', '__doc__', '__file__',
;;  '__initializing__', '__loader__', '__name__', '__package__',
;;  '_clearcache', 'calcsize', 'error', 'pack', 'pack_into',
;;  'unpack', 'unpack_from']
;; >>> class Shape:
;; ...     def __dir__(self):
;; ...         return ['area', 'perimeter', 'location']
;; >>> s = Shape()
;; >>> dir(s)
;; ['area', 'location', 'perimeter']
;;
;; Note Because dir() is supplied primarily as a convenience for use at
;; an interactive prompt, it tries to supply an interesting set of names
;; more than it tries to supply a rigorously or consistently defined set
;; of names, and its detailed behavior may change across releases. For
;; example, metaclass attributes are not in the result list when the
;; argument is a class.

(define-rts py-builtin-dir
  (procedure->py-function
    py-dir
    (make-signature posonlyargs: (object) defaults: (vector py-absent))))

;;-------------------- divmod(a, b)

;; Take two (non complex) numbers as arguments and return a pair of
;; numbers consisting of their quotient and remainder when using integer
;; division. With mixed operand types, the rules for binary arithmetic
;; operators apply. For integers, the result is the same as (a // b, a %
;; b). For floating point numbers the result is (q, a % b), where q is
;; usually math.floor(a / b) but may be 1 less than that. In any case q *
;; b + a % b is very close to a, if a % b is non-zero it has the same
;; sign as b, and 0 <= abs(a % b) < abs(b).

(define-rts py-builtin-divmod
  (procedure->py-function
    (lambda (a b)
      (py-throw-exception-with-message py-builtin-NotImplementedError "divmod not implemented"))
    (make-signature posonlyargs: (a b))))

;;-------------------- enumerate(iterable, start=0)

;; Return an enumerate object. iterable must be a sequence, an iterator,
;; or some other object which supports iteration. The __next__() method
;; of the iterator returned by enumerate() returns a tuple containing a
;; count (from start which defaults to 0) and the values obtained from
;; iterating over iterable.
;;
;; >>> seasons = ['Spring', 'Summer', 'Fall', 'Winter']
;; >>> list(enumerate(seasons))
;; [(0, 'Spring'), (1, 'Summer'), (2, 'Fall'), (3, 'Winter')]
;; >>> list(enumerate(seasons, start=1))
;; [(1, 'Spring'), (2, 'Summer'), (3, 'Fall'), (4, 'Winter')]
;; Equivalent to:
;;
;; def enumerate(sequence, start=0):
;;     n = start
;;     for elem in sequence:
;;         yield n, elem
;;         n += 1

(define-rts py-builtin-enumerate
  (procedure->py-function
    (lambda (iterable start)
      (py-throw-exception-with-message py-builtin-NotImplementedError "enumerate not implemented"))
    (make-signature
      args: (iterable start)
      defaults: (vector (py-int-from-scheme 0)))))

;;-------------------- eval(expression, globals=None, locals=None)

;; The arguments are a string and optional globals and locals. If
;; provided, globals must be a dictionary. If provided, locals can be any
;; mapping object.
;;
;; The expression argument is parsed and evaluated as a Python expression
;; (technically speaking, a condition list) using the globals and locals
;; dictionaries as global and local namespace. If the globals dictionary
;; is present and does not contain a value for the key __builtins__, a
;; reference to the dictionary of the built-in module builtins is
;; inserted under that key before expression is parsed. This means that
;; expression normally has full access to the standard builtins module
;; and restricted environments are propagated. If the locals dictionary
;; is omitted it defaults to the globals dictionary. If both dictionaries
;; are omitted, the expression is executed in the environment where
;; eval() is called. The return value is the result of the evaluated
;; expression. Syntax errors are reported as exceptions. Example:
;;
;; >>> x = 1
;; >>> eval('x+1')
;; 2
;;
;; This function can also be used to execute arbitrary code objects (such
;; as those created by compile()). In this case pass a code object
;; instead of a string. If the code object has been compiled with 'exec'
;; as the mode argument, eval()’s return value will be None.
;;
;; Hints: dynamic execution of statements is supported by the exec()
;; function. The globals() and locals() functions returns the current
;; global and local dictionary, respectively, which may be useful to pass
;; around for use by eval() or exec().
;;
;; See ast.literal_eval() for a function that can safely evaluate strings
;; with expressions containing only literals.
;;
;; Raises an auditing event exec with the code object as the
;; argument. Code compilation events may also be raised.

(define-rts py-builtin-eval
  (procedure->py-function
    (lambda (expression globals locals)
      (py-throw-exception-with-message py-builtin-NotImplementedError "eval not implemented"))
    (make-signature
      posonlyargs: (expression globals locals)
      defaults: (vector py-absent py-absent))))

;;-------------------- exec(object[, globals[, locals]])

;; This function supports dynamic execution of Python code. object must
;; be either a string or a code object. If it is a string, the string is
;; parsed as a suite of Python statements which is then executed (unless
;; a syntax error occurs). 1 If it is a code object, it is simply
;; executed. In all cases, the code that’s executed is expected to be
;; valid as file input (see the section “File input” in the Reference
;; Manual). Be aware that the return and yield statements may not be used
;; outside of function definitions even within the context of code passed
;; to the exec() function. The return value is None.
;;
;; In all cases, if the optional parts are omitted, the code is executed
;; in the current scope. If only globals is provided, it must be a
;; dictionary (and not a subclass of dictionary), which will be used for
;; both the global and the local variables. If globals and locals are
;; given, they are used for the global and local variables,
;; respectively. If provided, locals can be any mapping object. Remember
;; that at module level, globals and locals are the same dictionary. If
;; exec gets two separate objects as globals and locals, the code will be
;; executed as if it were embedded in a class definition.
;;
;; If the globals dictionary does not contain a value for the key
;; __builtins__, a reference to the dictionary of the built-in module
;; builtins is inserted under that key. That way you can control what
;; builtins are available to the executed code by inserting your own
;; __builtins__ dictionary into globals before passing it to exec().
;;
;; Raises an auditing event exec with the code object as the
;; argument. Code compilation events may also be raised.
;;
;; Note The built-in functions globals() and locals() return the current
;; global and local dictionary, respectively, which may be useful to pass
;; around for use as the second and third argument to exec().
;;
;; Note The default locals act as described for function locals() below:
;; modifications to the default locals dictionary should not be
;; attempted. Pass an explicit locals dictionary if you need to see
;; effects of the code on locals after function exec() returns.

(define-rts py-builtin-exec
  (procedure->py-function
    (lambda (expression globals locals)
      (py-throw-exception-with-message py-builtin-NotImplementedError "exec not implemented"))
    (make-signature
      posonlyargs: (expression globals locals)
      defaults: (vector py-absent py-absent))))

;;-------------------- filter(function, iterable)

;; Construct an iterator from those elements of iterable for which
;; function returns true. iterable may be either a sequence, a container
;; which supports iteration, or an iterator. If function is None, the
;; identity function is assumed, that is, all elements of iterable that
;; are false are removed.
;;
;; Note that filter(function, iterable) is equivalent to the generator
;; expression (item for item in iterable if function(item)) if function
;; is not None and (item for item in iterable if item) if function is
;; None.
;;
;; See itertools.filterfalse() for the complementary function that
;; returns elements of iterable for which function returns false.

(define-rts py-builtin-filter
  (procedure->py-function
    (lambda (function iterable)
      (py-throw-exception-with-message py-builtin-NotImplementedError "filter not implemented"))
    (make-signature posonlyargs: (function iterable))))

;;-------------------- class float([x])

;; Return a floating point number constructed from a number or string x.
;;
;; If the argument is a string, it should contain a decimal number,
;; optionally preceded by a sign, and optionally embedded in
;; whitespace. The optional sign may be '+' or '-'; a '+' sign has no
;; effect on the value produced. The argument may also be a string
;; representing a NaN (not-a-number), or a positive or negative
;; infinity. More precisely, the input must conform to the following
;; grammar after leading and trailing whitespace characters are removed:
;;
;; sign           ::=  "+" | "-"
;; infinity       ::=  "Infinity" | "inf"
;; nan            ::=  "nan"
;; numeric_value  ::=  floatnumber | infinity | nan
;; numeric_string ::=  [sign] numeric_value
;;
;; Here floatnumber is the form of a Python floating-point literal,
;; described in Floating point literals. Case is not significant, so, for
;; example, “inf”, “Inf”, “INFINITY” and “iNfINity” are all acceptable
;; spellings for positive infinity.
;;
;; Otherwise, if the argument is an integer or a floating point number, a
;; floating point number with the same value (within Python’s floating
;; point precision) is returned. If the argument is outside the range of
;; a Python float, an OverflowError will be raised.
;;
;; For a general Python object x, float(x) delegates to x.__float__(). If
;; __float__() is not defined then it falls back to __index__().
;;
;; If no argument is given, 0.0 is returned.
;;
;; Examples:
;;
;; >>>
;; >>> float('+1.23')
;; 1.23
;; >>> float('   -12345\n')
;; -12345.0
;; >>> float('1e-003')
;; 0.001
;; >>> float('+1E6')
;; 1000000.0
;; >>> float('-Infinity')
;; -inf
;;
;; The float type is described in Numeric Types — int, float, complex.
;;
;; Changed in version 3.6: Grouping digits with underscores as in code
;; literals is allowed.
;;
;; Changed in version 3.7: x is now a positional-only parameter.
;;
;; Changed in version 3.8: Falls back to __index__() if __float__() is
;; not defined.

(define-rts py-builtin-float #f)

;;-------------------- format(value[, format_spec])

;; Convert a value to a “formatted” representation, as controlled by
;; format_spec. The interpretation of format_spec will depend on the type
;; of the value argument, however there is a standard formatting syntax
;; that is used by most built-in types: Format Specification
;; Mini-Language.
;;
;; The default format_spec is an empty string which usually gives the
;; same effect as calling str(value).
;;
;; A call to format(value, format_spec) is translated to
;; type(value).__format__(value, format_spec) which bypasses the instance
;; dictionary when searching for the value’s __format__() method. A
;; TypeError exception is raised if the method search reaches object and
;; the format_spec is non-empty, or if either the format_spec or the
;; return value are not strings.
;;
;; Changed in version 3.4: object().__format__(format_spec) raises
;; TypeError if format_spec is not an empty string.

(define-rts py-builtin-format
  (procedure->py-function
    (lambda (value format_spec)
      (py-throw-exception-with-message py-builtin-NotImplementedError "format not implemented"))
    (make-signature posonlyargs: (value format_spec))))

;;-------------------- class frozenset([iterable])

;; Return a new frozenset object, optionally with elements taken from
;; iterable. frozenset is a built-in class. See frozenset and Set Types —
;; set, frozenset for documentation about this class.
;;
;; For other containers see the built-in set, list, tuple, and dict
;; classes, as well as the collections module.

(define-rts py-builtin-frozenset
  (procedure->py-function
    (lambda (iterable)
      (py-throw-exception-with-message py-builtin-NotImplementedError "frozenset not implemented"))
    (make-signature posonlyargs: (iterable))))

;;-------------------- getattr(object, name[, default])

;; Return the value of the named attribute of object. name must be a
;; string. If the string is the name of one of the object’s attributes,
;; the result is the value of that attribute. For example, getattr(x,
;; 'foobar') is equivalent to x.foobar. If the named attribute does not
;; exist, default is returned if provided, otherwise AttributeError is
;; raised.

(define-rts py-builtin-getattr
  (procedure->py-function
   (lambda (object name default)
     (if (py-subtype-of-str? name)
         (if (not (eq? default py-absent))
             (py-try-except
              (lambda (exc)
                (if (py-isinstance? exc py-builtin-AttributeError)
                    default
                    (py-throw-unsafe exc)))
              (lambda () (py-getattribute object name)))
             (py-getattribute object name))
         (py-throw-exception-with-message
          py-builtin-TypeError
          "getattr(): attribute name must be string")))
   (make-signature
    posonlyargs: (object name default)
    defaults: (vector py-absent))))

;;-------------------- globals()

;; Return a dictionary representing the current global symbol table. This
;; is always the dictionary of the current module (inside a function or
;; method, this is the module where it is defined, not the module from
;; which it is called).

(define-rts py-builtin-globals
  (procedure->py-function
    (lambda ()
      (py-throw-exception-with-message py-builtin-NotImplementedError "globals not implemented"))
    (make-signature)))

;;-------------------- hasattr(object, name)

;; The arguments are an object and a string. The result is True if the
;; string is the name of one of the object’s attributes, False if
;; not. (This is implemented by calling getattr(object, name) and seeing
;; whether it raises an AttributeError or not.)

;; TODO: full behaviour catches AttributeError to detect no attribute
(define-rts py-builtin-hasattr
  (procedure->py-function
    (lambda (object name)
      (py-throw-exception-with-message py-builtin-NotImplementedError "hasattr not implemented"))
    (make-signature posonlyargs: (object name))))

;;-------------------- hash(object)

;; Return the hash value of the object (if it has one). Hash values are
;; integers. They are used to quickly compare dictionary keys during a
;; dictionary lookup. Numeric values that compare equal have the same
;; hash value (even if they are of different types, as is the case for 1
;; and 1.0).
;;
;; Note For objects with custom __hash__() methods, note that hash()
;; truncates the return value based on the bit width of the host
;; machine. See __hash__() for details.

(define-rts py-builtin-hash
  (procedure->py-function
    py-hash
    (make-signature posonlyargs: (object))))

;;-------------------- help([object])

;; Invoke the built-in help system. (This function is intended for
;; interactive use.) If no argument is given, the interactive help system
;; starts on the interpreter console. If the argument is a string, then
;; the string is looked up as the name of a module, function, class,
;; method, keyword, or documentation topic, and a help page is printed on
;; the console. If the argument is any other kind of object, a help page
;; on the object is generated.
;;
;; Note that if a slash(/) appears in the parameter list of a function,
;; when invoking help(), it means that the parameters prior to the slash
;; are positional-only. For more info, see the FAQ entry on
;; positional-only parameters.
;;
;; This function is added to the built-in namespace by the site module.
;;
;; Changed in version 3.4: Changes to pydoc and inspect mean that the
;; reported signatures for callables are now more comprehensive and
;; consistent.

(define-rts py-builtin-help
  (procedure->py-function
    (lambda (object)
      (py-throw-exception-with-message py-builtin-NotImplementedError "help not implemented"))
    (make-signature posonlyargs: (object) defaults: (vector py-absent))))

;;-------------------- hex(x)

;; Convert an integer number to a lowercase hexadecimal string prefixed
;; with “0x”. If x is not a Python int object, it has to define an
;; __index__() method that returns an integer. Some examples:
;;
;; >>> hex(255)
;; '0xff'
;; >>> hex(-42)
;; '-0x2a'
;;
;; If you want to convert an integer number to an uppercase or lower
;; hexadecimal string with prefix or not, you can use either of the
;; following ways:
;;
;; >>> '%#x' % 255, '%x' % 255, '%X' % 255
;; ('0xff', 'ff', 'FF')
;; >>> format(255, '#x'), format(255, 'x'), format(255, 'X')
;; ('0xff', 'ff', 'FF')
;; >>> f'{255:#x}', f'{255:x}', f'{255:X}'
;; ('0xff', 'ff', 'FF')
;;
;; See also format() for more information.
;;
;; See also int() for converting a hexadecimal string to an integer using
;; a base of 16.
;;
;; Note To obtain a hexadecimal string representation for a float, use
;; the float.hex() method.

(define-rts py-builtin-hex
  (procedure->py-function
    (lambda (x)
      (py-str-from-scheme
        (string-append
          "0x"
          (number->string (py-int-to-scheme (py-index x)) 16))))
    (make-signature posonlyargs: (x))))

;;-------------------- id(object)

;; Return the “identity” of an object. This is an integer which is
;; guaranteed to be unique and constant for this object during its
;; lifetime. Two objects with non-overlapping lifetimes may have the same
;; id() value.
;;
;; CPython implementation detail: This is the address of the object in
;; memory.

(define-rts py-builtin-id
  (procedure->py-function
    (lambda (object)
      (py-throw-exception-with-message py-builtin-NotImplementedError "id not implemented"))
    (make-signature posonlyargs: (object))))

;;-------------------- input([prompt])

;; If the prompt argument is present, it is written to standard output
;; without a trailing newline. The function then reads a line from input,
;; converts it to a string (stripping a trailing newline), and returns
;; that. When EOF is read, EOFError is raised. Example:
;;
;; >>>
;; >>> s = input('--> ')
;; --> Monty Python's Flying Circus
;; >>> s
;; "Monty Python's Flying Circus"
;;
;; If the readline module was loaded, then input() will use it to provide
;; elaborate line editing and history features.
;;
;; Raises an auditing event builtins.input with argument prompt before
;; reading input
;;
;; Raises an auditing event builtins.input/result with the result after
;; successfully reading input.

(define-rts py-builtin-input
  (procedure->py-function
    (lambda (prompt)
      (py-throw-exception-with-message py-builtin-NotImplementedError "input not implemented"))
      (make-signature posonlyargs: (prompt) defaults: (vector py-absent))))

;;-------------------- class int([x])
;;                     class int(x, base=10)

;; Return an integer object constructed from a number or string x, or
;; return 0 if no arguments are given. If x defines __int__(), int(x)
;; returns x.__int__(). If x defines __index__(), it returns
;; x.__index__(). If x defines __trunc__(), it returns x.__trunc__(). For
;; floating point numbers, this truncates towards zero.
;;
;; If x is not a number or if base is given, then x must be a string,
;; bytes, or bytearray instance representing an integer literal in radix
;; base. Optionally, the literal can be preceded by + or - (with no space
;; in between) and surrounded by whitespace. A base-n literal consists of
;; the digits 0 to n-1, with a to z (or A to Z) having values 10 to
;; 35. The default base is 10. The allowed values are 0 and 2–36. Base-2,
;; -8, and -16 literals can be optionally prefixed with 0b/0B, 0o/0O, or
;; 0x/0X, as with integer literals in code. Base 0 means to interpret
;; exactly as a code literal, so that the actual base is 2, 8, 10, or 16,
;; and so that int('010', 0) is not legal, while int('010') is, as well
;; as int('010', 8).
;;
;; The integer type is described in Numeric Types — int, float, complex.
;;
;; Changed in version 3.4: If base is not an instance of int and the base
;; object has a base.__index__ method, that method is called to obtain an
;; integer for the base. Previous versions used base.__int__ instead of
;; base.__index__.
;;
;; Changed in version 3.6: Grouping digits with underscores as in code
;; literals is allowed.
;;
;; Changed in version 3.7: x is now a positional-only parameter.
;;
;; Changed in version 3.8: Falls back to __index__() if __int__() is not
;; defined.

(define-rts py-builtin-int #f)

;;-------------------- isinstance(object, classinfo)

;; Return true if the object argument is an instance of the classinfo
;; argument, or of a (direct, indirect or virtual) subclass thereof. If
;; object is not an object of the given type, the function always returns
;; false. If classinfo is a tuple of type objects (or recursively, other
;; such tuples), return true if object is an instance of any of the
;; types. If classinfo is not a type or tuple of types and such tuples, a
;; TypeError exception is raised.

(define-rts py-builtin-isinstance
  (procedure->py-function
    (lambda (object classinfo)
      (if (py-isinstance? object classinfo) py-True py-False))
    (make-signature posonlyargs: (object classinfo))))

;;-------------------- issubclass(class, classinfo)

;; Return true if class is a subclass (direct, indirect or virtual) of
;; classinfo. A class is considered a subclass of itself. classinfo may
;; be a tuple of class objects, in which case every entry in classinfo
;; will be checked. In any other case, a TypeError exception is raised.

(define-rts py-builtin-issubclass
  (procedure->py-function
    (lambda (object classinfo)
      (if (py-isinstance? object py-builtin-type)
        (cond
          ((py-isinstance? classinfo py-builtin-type)
            (py-bool-from-scheme-bool (py-issubclass? object classinfo)))
          ((py-isinstance? classinfo py-builtin-tuple)
            (py-throw py-builtin-NotImplementedError))
          (else
            (py-throw-exception-with-message
              py-builtin-TypeError
              "issubclass() arg 2 must be a class or tuple of classes")))
        (py-throw-exception-with-message
          py-builtin-TypeError
          "issubclass() arg 1 must be a class")))
    (make-signature posonlyargs: (object classinfo))))

;;-------------------- iter(object[, sentinel])

;; Return an iterator object. The first argument is interpreted very
;; differently depending on the presence of the second argument. Without
;; a second argument, object must be a collection object which supports
;; the iteration protocol (the __iter__() method), or it must support the
;; sequence protocol (the __getitem__() method with integer arguments
;; starting at 0). If it does not support either of those protocols,
;; TypeError is raised. If the second argument, sentinel, is given, then
;; object must be a callable object. The iterator created in this case
;; will call object with no arguments for each call to its __next__()
;; method; if the value returned is equal to sentinel, StopIteration will
;; be raised, otherwise the value will be returned.
;;
;; See also Iterator Types.
;;
;; One useful application of the second form of iter() is to build a
;; block-reader. For example, reading fixed-width blocks from a binary
;; database file until the end of file is reached:
;;
;; from functools import partial
;; with open('mydata.db', 'rb') as f:
;;     for block in iter(partial(f.read, 64), b''):
;;         process_block(block)

(define-rts py-builtin-iter
  (procedure->py-function
    (lambda (object sentinel)
      (if (eq? sentinel py-absent)
        (py-iter object)
        (py-throw-exception-with-message py-builtin-NotImplementedError "iter with 2 arguments not implemented")))
    (make-signature posonlyargs: (object sentinel) defaults: (vector py-absent))))

;;-------------------- len(s)

;; Return the length (the number of items) of an object. The argument may
;; be a sequence (such as a string, bytes, tuple, list, or range) or a
;; collection (such as a dictionary, set, or frozen set).

(define-rts py-builtin-len
  (procedure->py-function
    (lambda (o) (py-length o))
    (make-signature posonlyargs: (obj))))

;;-------------------- class list([iterable])

;; Rather than being a function, list is actually a mutable sequence
;; type, as documented in Lists and Sequence Types — list, tuple, range.

(define-rts py-builtin-list py-list-class)

;;-------------------- locals()

;; Update and return a dictionary representing the current local symbol
;; table. Free variables are returned by locals() when it is called in
;; function blocks, but not in class blocks. Note that at the module
;; level, locals() and globals() are the same dictionary.
;;
;; Note The contents of this dictionary should not be modified; changes
;; may not affect the values of local and free variables used by the
;; interpreter.

(define-rts py-builtin-locals
  (procedure->py-function
    (lambda ()
      (py-throw-exception-with-message py-builtin-NotImplementedError "locals not implemented"))
    (make-signature)))

;;-------------------- map(function, iterable, ...)

;; Return an iterator that applies function to every item of iterable,
;; yielding the results. If additional iterable arguments are passed,
;; function must take that many arguments and is applied to the items
;; from all iterables in parallel. With multiple iterables, the
;; iterator stops when the shortest iterable is exhausted. For cases
;; where the function inputs are already arranged into argument
;; tuples, see itertools.starmap().

(define-rts py-builtin-map
  (procedure->py-function
    (lambda (function iterable)
      (py-throw-exception-with-message py-builtin-NotImplementedError "map not implemented"))
    (make-signature posonlyargs: (function iterable))))

;;-------------------- max(iterable, *[, key, default])
;;                     max(arg1, arg2, *args[, key])

;; Return the largest item in an iterable or the largest of two or more
;; arguments.
;;
;; If one positional argument is provided, it should be an iterable. The
;; largest item in the iterable is returned. If two or more positional
;; arguments are provided, the largest of the positional arguments is
;; returned.
;;
;; There are two optional keyword-only arguments. The key argument
;; specifies a one-argument ordering function like that used for
;; list.sort(). The default argument specifies an object to return if the
;; provided iterable is empty. If the iterable is empty and default is
;; not provided, a ValueError is raised.
;;
;; If multiple items are maximal, the function returns the first one encountered. This is consistent with other sort-stability preserving tools such as sorted(iterable, key=keyfunc, reverse=True)[0] and heapq.nlargest(1, iterable, key=keyfunc).
;;
;; New in version 3.4: The default keyword-only argument.
;;
;; Changed in version 3.8: The key can be None.

(define-rts py-builtin-max
  (procedure->py-function
    (lambda (arg1 args key default)
      (py-throw-exception-with-message py-builtin-NotImplementedError "max not implemented"))
    (make-signature
      posonlyargs: (arg1)
      vararg: args
      kwonlyargs: (key default)
      kw-defaults: (vector py-absent py-absent))))

;;-------------------- memoryview(obj)

;; Return a “memory view” object created from the given argument. See
;; Memory Views for more information.

(define-rts py-builtin-memoryview
  (procedure->py-function
    (lambda (obj)
      (py-throw-exception-with-message py-builtin-NotImplementedError "memoryview not implemented"))
    (make-signature posonlyargs: (obj))))

;;-------------------- min(iterable, *[, key, default])
;;                     min(arg1, arg2, *args[, key])

;; Return the smallest item in an iterable or the smallest of two or more
;; arguments.
;;
;; If one positional argument is provided, it should be an iterable. The
;; smallest item in the iterable is returned. If two or more positional
;; arguments are provided, the smallest of the positional arguments is
;; returned.
;;
;; There are two optional keyword-only arguments. The key argument
;; specifies a one-argument ordering function like that used for
;; list.sort(). The default argument specifies an object to return if the
;; provided iterable is empty. If the iterable is empty and default is
;; not provided, a ValueError is raised.
;;
;; If multiple items are minimal, the function returns the first one
;; encountered. This is consistent with other sort-stability preserving
;; tools such as sorted(iterable, key=keyfunc)[0] and heapq.nsmallest(1,
;; iterable, key=keyfunc).
;;
;; New in version 3.4: The default keyword-only argument.
;;
;; Changed in version 3.8: The key can be None.

(define-rts py-builtin-min
  (procedure->py-function
    (lambda (arg1 args key default)
      (py-throw-exception-with-message py-builtin-NotImplementedError "min not implemented"))
    (make-signature
      posonlyargs: (arg1)
      vararg: args
      kwonlyargs: (key default)
      kw-defaults: (vector py-absent py-absent))))

;;-------------------- next(iterator[, default])

;; Retrieve the next item from the iterator by calling its __next__()
;; method. If default is given, it is returned if the iterator is
;; exhausted, otherwise StopIteration is raised.

(define-rts py-builtin-next
  (procedure->py-function
    iterator-next
    (make-signature posonlyargs: (iterator default) defaults: (vector py-absent))))

;;-------------------- class object

;; Return a new featureless object. object is a base for all classes. It
;; has the methods that are common to all instances of Python
;; classes. This function does not accept any arguments.
;;
;; Note object does not have a __dict__, so you can’t assign arbitrary
;; attributes to an instance of the object class.

(define-rts py-builtin-object py-object-class)

;;-------------------- oct(x)

;; Convert an integer number to an octal string prefixed with “0o”. The
;; result is a valid Python expression. If x is not a Python int object,
;; it has to define an __index__() method that returns an integer. For
;; example:
;;
;; >>> oct(8)
;; '0o10'
;; >>> oct(-56)
;; '-0o70'
;;
;; If you want to convert an integer number to octal string either
;; with prefix “0o” or not, you can use either of the following ways.
;;
;; >>> '%#o' % 10, '%o' % 10
;; ('0o12', '12')
;; >>> format(10, '#o'), format(10, 'o')
;; ('0o12', '12')
;; >>> f'{10:#o}', f'{10:o}'
;; ('0o12', '12')
;;
;; See also format() for more information.

(define-rts py-builtin-oct
  (procedure->py-function
    (lambda (x)
      (py-throw-exception-with-message py-builtin-NotImplementedError "oct not implemented"))
    (make-signature posonlyargs: (x))))

;;-------------------- open(file, mode='r', buffering=-1, encoding=None, errors=None, newline=None, closefd=True, opener=None)

;; Open file and return a corresponding file object. If the file cannot
;; be opened, an OSError is raised.
;;
;; file is a path-like object giving the pathname (absolute or relative
;; to the current working directory) of the file to be opened or an
;; integer file descriptor of the file to be wrapped. (If a file
;; descriptor is given, it is closed when the returned I/O object is
;; closed, unless closefd is set to False.)
;;
;; mode is an optional string that specifies the mode in which the file
;; is opened. It defaults to 'r' which means open for reading in text
;; mode. Other common values are 'w' for writing (truncating the file if
;; it already exists), 'x' for exclusive creation and 'a' for appending
;; (which on some Unix systems, means that all writes append to the end
;; of the file regardless of the current seek position). In text mode, if
;; encoding is not specified the encoding used is platform dependent:
;; locale.getpreferredencoding(False) is called to get the current locale
;; encoding. (For reading and writing raw bytes use binary mode and leave
;; encoding unspecified.) The available modes are:
;;
;; Character
;; Meaning
;; 'r'
;; open for reading (default)
;; 'w'
;; open for writing, truncating the file first
;; 'x'
;; open for exclusive creation, failing if the file already exists
;; 'a'
;; open for writing, appending to the end of the file if it exists
;; 'b'
;; binary mode
;; 't'
;; text mode (default)
;; '+'
;; open a disk file for updating (reading and writing)
;;
;; The default mode is 'r' (open for reading text, synonym of 'rt'). For
;; binary read-write access, the mode 'w+b' opens and truncates the file
;; to 0 bytes. 'r+b' opens the file without truncation.
;;
;; As mentioned in the Overview, Python distinguishes between binary and
;; text I/O. Files opened in binary mode (including 'b' in the mode
;; argument) return contents as bytes objects without any decoding. In
;; text mode (the default, or when 't' is included in the mode argument),
;; the contents of the file are returned as str, the bytes having been
;; first decoded using a platform-dependent encoding or using the
;; specified encoding if given.
;;
;; There is an additional mode character permitted, 'U', which no longer
;; has any effect, and is considered deprecated. It previously enabled
;; universal newlines in text mode, which became the default behaviour in
;; Python 3.0. Refer to the documentation of the newline parameter for
;; further details.
;;
;; Note Python doesn’t depend on the underlying operating system’s notion of text files; all the processing is done by Python itself, and is therefore platform-independent.
;;
;; buffering is an optional integer used to set the buffering
;; policy. Pass 0 to switch buffering off (only allowed in binary mode),
;; 1 to select line buffering (only usable in text mode), and an integer
;; > 1 to indicate the size in bytes of a fixed-size chunk buffer. When
;; no buffering argument is given, the default buffering policy works as
;; follows:
;;
;; Binary files are buffered in fixed-size chunks; the size of the buffer
;; is chosen using a heuristic trying to determine the underlying
;; device’s “block size” and falling back on io.DEFAULT_BUFFER_SIZE. On
;; many systems, the buffer will typically be 4096 or 8192 bytes long.
;; “Interactive” text files (files for which isatty() returns True) use
;; line buffering. Other text files use the policy described above for
;; binary files.  encoding is the name of the encoding used to decode or
;; encode the file. This should only be used in text mode. The default
;; encoding is platform dependent (whatever locale.getpreferredencoding()
;; returns), but any text encoding supported by Python can be used. See
;; the codecs module for the list of supported encodings.
;;
;; errors is an optional string that specifies how encoding and decoding
;; errors are to be handled—this cannot be used in binary mode. A variety
;; of standard error handlers are available (listed under Error
;; Handlers), though any error handling name that has been registered
;; with codecs.register_error() is also valid. The standard names
;; include:
;;
;; 'strict' to raise a ValueError exception if there is an encoding error. The default value of None has the same effect.
;;
;; 'ignore' ignores errors. Note that ignoring encoding errors can lead to data loss.
;;
;; 'replace' causes a replacement marker (such as '?') to be inserted where there is malformed data.
;;
;; 'surrogateescape' will represent any incorrect bytes as code points in the Unicode Private Use Area ranging from U+DC80 to U+DCFF. These private code points will then be turned back into the same bytes when the surrogateescape error handler is used when writing data. This is useful for processing files in an unknown encoding.
;;
;; 'xmlcharrefreplace' is only supported when writing to a file. Characters not supported by the encoding are replaced with the appropriate XML character reference &#nnn;.
;;
;; 'backslashreplace' replaces malformed data by Python’s backslashed escape sequences.
;;
;; 'namereplace' (also only supported when writing) replaces unsupported characters with \N{...} escape sequences.
;;
;; newline controls how universal newlines mode works (it only applies to text mode). It can be None, '', '\n', '\r', and '\r\n'. It works as follows:
;;
;; When reading input from the stream, if newline is None, universal
;; newlines mode is enabled. Lines in the input can end in '\n', '\r', or
;; '\r\n', and these are translated into '\n' before being returned to
;; the caller. If it is '', universal newlines mode is enabled, but line
;; endings are returned to the caller untranslated. If it has any of the
;; other legal values, input lines are only terminated by the given
;; string, and the line ending is returned to the caller untranslated.
;;
;; When writing output to the stream, if newline is None, any '\n'
;; characters written are translated to the system default line
;; separator, os.linesep. If newline is '' or '\n', no translation takes
;; place. If newline is any of the other legal values, any '\n'
;; characters written are translated to the given string.
;;
;; If closefd is False and a file descriptor rather than a filename was
;; given, the underlying file descriptor will be kept open when the file
;; is closed. If a filename is given closefd must be True (the default)
;; otherwise an error will be raised.
;;
;; A custom opener can be used by passing a callable as opener. The
;; underlying file descriptor for the file object is then obtained by
;; calling opener with (file, flags). opener must return an open file
;; descriptor (passing os.open as opener results in functionality similar
;; to passing None).
;;
;; The newly created file is non-inheritable.
;;
;; The following example uses the dir_fd parameter of the os.open()
;; function to open a file relative to a given directory:
;;
;; >>>
;; >>> import os
;; >>> dir_fd = os.open('somedir', os.O_RDONLY)
;; >>> def opener(path, flags):
;; ...     return os.open(path, flags, dir_fd=dir_fd)
;; ...
;; >>> with open('spamspam.txt', 'w', opener=opener) as f:
;; ...     print('This will be written to somedir/spamspam.txt', file=f)
;; ...
;; >>> os.close(dir_fd)  # don't leak a file descriptor
;;
;; The type of file object returned by the open() function depends on the
;; mode. When open() is used to open a file in a text mode ('w', 'r',
;; 'wt', 'rt', etc.), it returns a subclass of io.TextIOBase
;; (specifically io.TextIOWrapper). When used to open a file in a binary
;; mode with buffering, the returned class is a subclass of
;; io.BufferedIOBase. The exact class varies: in read binary mode, it
;; returns an io.BufferedReader; in write binary and append binary modes,
;; it returns an io.BufferedWriter, and in read/write mode, it returns an
;; io.BufferedRandom. When buffering is disabled, the raw stream, a
;; subclass of io.RawIOBase, io.FileIO, is returned.
;;
;; See also the file handling modules, such as, fileinput, io (where
;; open() is declared), os, os.path, tempfile, and shutil.
;;
;; Raises an auditing event open with arguments file, mode, flags.
;;
;; The mode and flags arguments may have been modified or inferred from
;; the original call.
;;
;; Changed in version 3.3:
;; The opener parameter was added.
;; The 'x' mode was added.
;; IOError used to be raised, it is now an alias of OSError.
;; FileExistsError is now raised if the file opened in exclusive creation mode ('x') already exists.
;; Changed in version 3.4:
;; The file is now non-inheritable.
;; Deprecated since version 3.4, will be removed in version 4.0: The 'U' mode.
;;
;; Changed in version 3.5:
;; If the system call is interrupted and the signal handler does not raise an exception, the function now retries the system call instead of raising an InterruptedError exception (see PEP 475 for the rationale).
;; The 'namereplace' error handler was added.
;; Changed in version 3.6:
;; Support added to accept objects implementing os.PathLike.
;; On Windows, opening a console buffer may return a subclass of io.RawIOBase other than io.FileIO.

(define-rts py-builtin-open
  (procedure->py-function
    py-open
    (make-signature
      args: (file mode buffering encoding errors newline closefd opener)
      defaults:
        (vector
          (&& "r")
          (py-int-from-scheme -1)
          py-None
          py-None
          py-None
          py-True
          py-None))))

;;-------------------- ord(c)

;; Given a string representing one Unicode character, return an
;; integer representing the Unicode code point of that character. For
;; example, ord('a') returns the integer 97 and ord('€') (Euro sign)
;; returns 8364. This is the inverse of chr().

(define-rts py-builtin-ord
  (procedure->py-function
    (lambda (c)
      (if (and (py-subtype-of-str? c) (fx= (py-str-len-to-scheme c) 1))
        (py-int-from-scheme (char->integer (string-ref (py-str-to-scheme c) 0)))
        (py-throw-exception-with-message py-builtin-TypeError "ord() expected string of length 1")))
    (make-signature posonlyargs: (c))))

;;-------------------- pow(x, y[, z])

;; Return x to the power y; if z is present, return x to the power y,
;; modulo z (computed more efficiently than pow(x, y) % z). The
;; two-argument form pow(x, y) is equivalent to using the power operator:
;; x**y.
;;
;; The arguments must have numeric types. With mixed operand types, the
;; coercion rules for binary arithmetic operators apply. For int
;; operands, the result has the same type as the operands (after
;; coercion) unless the second argument is negative; in that case, all
;; arguments are converted to float and a float result is delivered. For
;; example, 10**2 returns 100, but 10**-2 returns 0.01.
;;
;; For int operands x and y, if z is present, z must also be of integer
;; type and z must be nonzero. If z is present and y is negative, x must
;; be relatively prime to z. In that case, pow(inv_x, -y, z) is returned,
;; where inv_x is an inverse to x modulo z.
;;
;; Here’s an example of computing an inverse for 38 modulo 97:
;;
;; >>>
;; >>> pow(38, -1, 97)
;; 23
;; >>> 23 * 38 % 97 == 1
;; True
;;
;; Changed in version 3.8: For int operands, the three-argument form of
;; pow now allows the second argument to be negative, permitting
;; computation of modular inverses.

(define-rts py-builtin-pow
  (procedure->py-function
    (lambda (base exp mod)
      (py-throw-exception-with-message py-builtin-NotImplementedError "pow not implemented"))
    (make-signature
      args: (base exp mod)
      defaults: (vector py-absent))))

;;-------------------- print(*objects, sep=' ', end='\n', file=sys.stdout, flush=False)

;; Print objects to the text stream file, separated by sep and followed
;; by end. sep, end, file and flush, if present, must be given as keyword
;; arguments.
;;
;; All non-keyword arguments are converted to strings like str() does and
;; written to the stream, separated by sep and followed by end. Both sep
;; and end must be strings; they can also be None, which means to use the
;; default values. If no objects are given, print() will just write end.
;;
;; The file argument must be an object with a write(string) method; if it
;; is not present or None, sys.stdout will be used. Since printed
;; arguments are converted to text strings, print() cannot be used with
;; binary mode file objects. For these, use file.write(...) instead.
;;
;; Whether output is buffered is usually determined by file, but if the
;; flush keyword argument is true, the stream is forcibly flushed.
;;
;; Changed in version 3.3: Added the flush keyword argument.

(define-rts py-builtin-print
  (procedure->py-function
    (lambda (objects) ;; add args (non-positional): sep end file flush
      (let* ((port (current-output-port))
             (objects-vector (PyObjectTuple-value objects))
             (objects-len (vector-length objects-vector)))
        (let loop ((i 0))
          (if (< i objects-len)
            (begin
              (py-display (vector-ref objects-vector i) port)
              (if (< (+ i 1) objects-len)
                (display " " port))
              (loop (+ i 1)))))
            (newline port)
            py-None))
    (make-signature
      vararg: objects)))

;;-------------------- class property(fget=None, fset=None, fdel=None, doc=None)

;; Return a property attribute.
;;
;; fget is a function for getting an attribute value. fset is a function
;; for setting an attribute value. fdel is a function for deleting an
;; attribute value. And doc creates a docstring for the attribute.
;;
;; A typical use is to define a managed attribute x:
;;
;; class C:
;;     def __init__(self):
;;         self._x = None
;;
;;     def getx(self):
;;         return self._x
;;
;;     def setx(self, value):
;;         self._x = value
;;
;;     def delx(self):
;;         del self._x
;;
;;     x = property(getx, setx, delx, "I'm the 'x' property.")
;;
;; If c is an instance of C, c.x will invoke the getter, c.x = value will
;; invoke the setter and del c.x the deleter.
;;
;; If given, doc will be the docstring of the property
;; attribute. Otherwise, the property will copy fget’s docstring (if it
;; exists). This makes it possible to create read-only properties easily
;; using property() as a decorator:
;;
;; class Parrot:
;;     def __init__(self):
;;         self._voltage = 100000
;;
;;     @property
;;     def voltage(self):
;;         """Get the current voltage."""
;;         return self._voltage
;;
;; The @property decorator turns the voltage() method into a “getter” for
;; a read-only attribute with the same name, and it sets the docstring
;; for voltage to “Get the current voltage.”
;;
;; A property object has getter, setter, and deleter methods usable as
;; decorators that create a copy of the property with the corresponding
;; accessor function set to the decorated function. This is best
;; explained with an example:
;;
;; class C:
;;     def __init__(self):
;;         self._x = None
;;
;;     @property
;;     def x(self):
;;         """I'm the 'x' property."""
;;         return self._x
;;
;;     @x.setter
;;     def x(self, value):
;;         self._x = value
;;
;;     @x.deleter
;;     def x(self):
;;         del self._x
;;
;; This code is exactly equivalent to the first example. Be sure to give
;; the additional functions the same name as the original property (x in
;; this case.)
;;
;; The returned property object also has the attributes fget, fset, and
;; fdel corresponding to the constructor arguments.
;;
;; Changed in version 3.5: The docstrings of property objects are now
;; writeable.

(define-rts py-builtin-property
  (procedure->py-function
    (lambda (fget fset fdel doc)
      (py-throw-exception-with-message py-builtin-NotImplementedError "property not implemented"))
    (make-signature
      args: (fget fset fdel doc)
      defaults: (vector py-None py-None py-None py-None))))

;;-------------------- range(stop)
;;                     range(start, stop[, step])

;; Rather than being a function, range is actually an immutable sequence
;; type, as documented in Ranges and Sequence Types — list, tuple, range.

(define-rts py-builtin-range #f)
(define-rts py-builtin-range_iterator #f)

(define-rts range.__iter__ #f)

;;-------------------- repr(object)

;; Return a string containing a printable representation of an
;; object. For many types, this function makes an attempt to return a
;; string that would yield an object with the same value when passed to
;; eval(), otherwise the representation is a string enclosed in angle
;; brackets that contains the name of the type of the object together
;; with additional information often including the name and address of
;; the object. A class can control what this function returns for its
;; instances by defining a __repr__() method.

(define-rts py-builtin-repr
  (procedure->py-function
    py-repr
    (make-signature posonlyargs: (repr))))

;;-------------------- reversed(seq)

;; Return a reverse iterator. seq must be an object which has a
;; __reversed__() method or supports the sequence protocol (the __len__()
;; method and the __getitem__() method with integer arguments starting at
;; 0).

(define-rts py-builtin-reversed
  (procedure->py-function
    (lambda (seq)
      (py-throw-exception-with-message py-builtin-NotImplementedError "reversed not implemented"))
    (make-signature posonlyargs: (seq))))

;;-------------------- round(number[, ndigits])

;; Return number rounded to ndigits precision after the decimal point. If
;; ndigits is omitted or is None, it returns the nearest integer to its
;; input.
;;
;; For the built-in types supporting round(), values are rounded to the
;; closest multiple of 10 to the power minus ndigits; if two multiples
;; are equally close, rounding is done toward the even choice (so, for
;; example, both round(0.5) and round(-0.5) are 0, and round(1.5) is
;; 2). Any integer value is valid for ndigits (positive, zero, or
;; negative). The return value is an integer if ndigits is omitted or
;; None. Otherwise the return value has the same type as number.
;;
;; For a general Python object number, round delegates to
;; number.__round__.
;;
;; Note The behavior of round() for floats can be surprising: for
;; example, round(2.675, 2) gives 2.67 instead of the expected 2.68. This
;; is not a bug: it’s a result of the fact that most decimal fractions
;; can’t be represented exactly as a float. See Floating Point
;; Arithmetic: Issues and Limitations for more information.

(define-rts py-builtin-round
  (procedure->py-function
    (lambda (number ndigits)
      (py-throw-exception-with-message py-builtin-NotImplementedError "round not implemented"))
    (make-signature
      args: (number ndigits)
      defaults: (vector py-absent))))

;;-------------------- class set([iterable])

;; Return a new set object, optionally with elements taken from
;; iterable. set is a built-in class. See set and Set Types — set,
;; frozenset for documentation about this class.
;;
;; For other containers see the built-in frozenset, list, tuple, and dict
;; classes, as well as the collections module.

(define-rts py-builtin-set py-set-class)

;;-------------------- setattr(object, name, value)

;; This is the counterpart of getattr(). The arguments are an object, a
;; string and an arbitrary value. The string may name an existing
;; attribute or a new attribute. The function assigns the value to the
;; attribute, provided the object allows it. For example, setattr(x,
;; 'foobar', 123) is equivalent to x.foobar = 123.

(define-rts py-builtin-setattr
  (procedure->py-function
    (lambda (object name value)
      (py-throw-exception-with-message py-builtin-NotImplementedError "setattr not implemented"))
    (make-signature posonlyargs: (object name value))))

;;-------------------- class slice(stop)
;;                     class slice(start, stop[, step])

;; Return a slice object representing the set of indices specified by
;; range(start, stop, step). The start and step arguments default to
;; None. Slice objects have read-only data attributes start, stop and
;; step which merely return the argument values (or their default). They
;; have no other explicit functionality; however they are used by
;; Numerical Python and other third party extensions. Slice objects are
;; also generated when extended indexing syntax is used. For example:
;; a[start:stop:step] or a[start:stop, i]. See itertools.islice() for an
;; alternate version that returns an iterator.

(define-rts py-builtin-slice py-slice-class)

;;-------------------- sorted(iterable, *, key=None, reverse=False)

;; Return a new sorted list from the items in iterable.
;;
;; Has two optional arguments which must be specified as keyword
;; arguments.
;;
;; key specifies a function of one argument that is used to extract a
;; comparison key from each element in iterable (for example,
;; key=str.lower). The default value is None (compare the elements
;; directly).
;;
;; reverse is a boolean value. If set to True, then the list elements are
;; sorted as if each comparison were reversed.
;;
;; Use functools.cmp_to_key() to convert an old-style cmp function to a
;; key function.
;;
;; The built-in sorted() function is guaranteed to be stable. A sort is
;; stable if it guarantees not to change the relative order of elements
;; that compare equal — this is helpful for sorting in multiple passes
;; (for example, sort by department, then by salary grade).
;;
;; For sorting examples and a brief sorting tutorial, see Sorting HOW TO.

(define-rts py-builtin-sorted
  (procedure->py-function
    (lambda (iterable key reverse)
      (py-throw-exception-with-message py-builtin-NotImplementedError "sorted not implemented"))
    (make-signature
      posonlyargs: (iterable)
      kwonlyargs: (key reverse)
      kw-defaults: (vector py-absent py-False))))

;;-------------------- @staticmethod

;; Transform a method into a static method.
;;
;; A static method does not receive an implicit first argument. To
;; declare a static method, use this idiom:
;;
;; class C:
;;     @staticmethod
;;     def f(arg1, arg2, ...): ...
;; The @staticmethod form is a function decorator – see Function definitions for details.
;;
;; A static method can be called either on the class (such as C.f()) or
;; on an instance (such as C().f()).
;;
;; Static methods in Python are similar to those found in Java or
;; C++. Also see classmethod() for a variant that is useful for creating
;; alternate class constructors.
;;
;; Like all decorators, it is also possible to call staticmethod as a
;; regular function and do something with its result. This is needed in
;; some cases where you need a reference to a function from a class body
;; and you want to avoid the automatic transformation to instance
;; method. For these cases, use this idiom:
;;
;; class C:
;;     builtin_open = staticmethod(open)
;;
;; For more information on static methods, see The standard type hierarchy.

(define-rts py-builtin-staticmethod
  (procedure->py-function
    (lambda (function)
      (py-throw-exception-with-message py-builtin-NotImplementedError "staticmethod not implemented"))
    (make-signature posonlyargs: (function))))

;;-------------------- class str(object='')
;;                     class str(object=b'', encoding='utf-8', errors='strict')

;; Return a str version of object. See str() for details.
;;
;; str is the built-in string class. For general information about
;; strings, see Text Sequence Type — str.

(define-rts py-builtin-str #f)

;;-------------------- sum(iterable, /, start=0)

;; Sums start and the items of an iterable from left to right and returns
;; the total. The iterable’s items are normally numbers, and the start
;; value is not allowed to be a string.
;;
;; For some use cases, there are good alternatives to sum(). The
;; preferred, fast way to concatenate a sequence of strings is by calling
;; ''.join(sequence). To add floating point values with extended
;; precision, see math.fsum(). To concatenate a series of iterables,
;; consider using itertools.chain().
;;
;; Changed in version 3.8: The start parameter can be specified as a
;; keyword argument.

(define-rts py-builtin-sum
  (procedure->py-function
    (lambda (iterable start)
      (py-throw-exception-with-message py-builtin-NotImplementedError "sum not implemented"))
    (make-signature
      args: (start)
      posonlyargs: (iterable)
      defaults: (vector (py-int-from-scheme 0)))))

;;-------------------- super([type[, object-or-type]])

;; Return a proxy object that delegates method calls to a parent or
;; sibling class of type. This is useful for accessing inherited methods
;; that have been overridden in a class. The search order is same as that
;; used by getattr() except that the type itself is skipped.
;;
;; The __mro__ attribute of the type lists the method resolution search
;; order used by both getattr() and super(). The attribute is dynamic and
;; can change whenever the inheritance hierarchy is updated.
;;
;; If the second argument is omitted, the super object returned is
;; unbound. If the second argument is an object, isinstance(obj, type)
;; must be true. If the second argument is a type, issubclass(type2,
;; type) must be true (this is useful for classmethods).
;;
;; There are two typical use cases for super. In a class hierarchy with
;; single inheritance, super can be used to refer to parent classes
;; without naming them explicitly, thus making the code more
;; maintainable. This use closely parallels the use of super in other
;; programming languages.
;;
;; The second use case is to support cooperative multiple inheritance in
;; a dynamic execution environment. This use case is unique to Python and
;; is not found in statically compiled languages or languages that only
;; support single inheritance. This makes it possible to implement
;; “diamond diagrams” where multiple base classes implement the same
;; method. Good design dictates that this method have the same calling
;; signature in every case (because the order of calls is determined at
;; runtime, because that order adapts to changes in the class hierarchy,
;; and because that order can include sibling classes that are unknown
;; prior to runtime).
;;
;; For both use cases, a typical superclass call looks like this:
;;
;; class C(B):
;;     def method(self, arg):
;;         super().method(arg)    # This does the same thing as:
;;                                # super(C, self).method(arg)
;;
;; Note that super() is implemented as part of the binding process for
;; explicit dotted attribute lookups such as
;; super().__getitem__(name). It does so by implementing its own
;; __getattribute__() method for searching classes in a predictable order
;; that supports cooperative multiple inheritance. Accordingly, super()
;; is undefined for implicit lookups using statements or operators such
;; as super()[name].
;;
;; Also note that, aside from the zero argument form, super() is not
;; limited to use inside methods. The two argument form specifies the
;; arguments exactly and makes the appropriate references. The zero
;; argument form only works inside a class definition, as the compiler
;; fills in the necessary details to correctly retrieve the class being
;; defined, as well as accessing the current instance for ordinary
;; methods.
;;
;; For practical suggestions on how to design cooperative classes using
;; super(), see guide to using super().

(define-rts (py-throw-super-no-arguments-error)
  (py-throw-exception-with-message
      py-builtin-RuntimeError
      "super(): no arguments"))

(define-rts (super-init self type object)
  (if (eq? object py-absent)
    (error "super not implemented for 1 argument")
    (begin
      (py-own-attr-set! self (& "__thisclass__") type)
      (py-own-attr-set! self (& "__self__") object))))

(define-rts super.__init__
  (procedure->py-function
    super-init
    (make-signature
      posonlyargs: (self type object)
      defaults: (vector py-absent py-absent))))

(define-rts (super-getattribute self name)
  (if (eq? (py-str-representative name) (& "__class__"))
      py-builtin-super
      (let* ((this-class (py-own-attr-ref self (& "__thisclass__")))
             (this-self (py-own-attr-ref self (& "__self__")))
             (mro (PyObjectType-mro this-class))
             (parent-cls (vector-ref mro 1)))
        (getattribute-from-cls-mro-with-owner-2cont
         parent-cls
         name
         (lambda (attr owner)
           (py-descriptor-get attr this-self owner))
         (lambda ()
           (object-getattribute self name))))))

(define-rts super.__getattribute__
  (procedure->py-function
    super-getattribute
    (make-signature posonlyargs: (self name))))

(define-rts py-builtin-super
  (py-make-builtin-class
    (&& "super")
    (&& "builtins")
    (list)
      (& "__init__") super.__init__
      (& "__getattribute__") super.__getattribute__
    ))

;;-------------------- tuple([iterable])

;; Rather than being a function, tuple is actually an immutable sequence
;; type, as documented in Tuples and Sequence Types — list, tuple, range.

(define-rts py-builtin-tuple py-tuple-class)

;;-------------------- class type(object)
;;                     class type(name, bases, dict)

;; With one argument, return the type of an object. The return value is a
;; type object and generally the same object as returned by
;; object.__class__.
;;
;; The isinstance() built-in function is recommended for testing the type
;; of an object, because it takes subclasses into account.
;;
;; With three arguments, return a new type object. This is essentially a
;; dynamic form of the class statement. The name string is the class name
;; and becomes the __name__ attribute; the bases tuple itemizes the base
;; classes and becomes the __bases__ attribute; and the dict dictionary
;; is the namespace containing definitions for class body and is copied
;; to a standard dictionary to become the __dict__ attribute. For
;; example, the following two statements create identical type objects:
;;
;; >>> class X:
;; ...     a = 1
;; ...
;; >>> X = type('X', (object,), dict(a=1))
;;
;; See also Type Objects.
;;
;; Changed in version 3.6: Subclasses of type which don’t override
;; type.__new__ may no longer use the one-argument form to get the type
;; of an object.

(define-rts py-builtin-type py-type-class)

;;-------------------- vars([object])

;; Return the __dict__ attribute for a module, class, instance, or any
;; other object with a __dict__ attribute.
;;
;; Objects such as modules and instances have an updateable __dict__
;; attribute; however, other objects may have write restrictions on their
;; __dict__ attributes (for example, classes use a types.MappingProxyType
;; to prevent direct dictionary updates).
;;
;; Without an argument, vars() acts like locals(). Note, the locals
;; dictionary is only useful for reads since updates to the locals
;; dictionary are ignored.

(define-rts py-builtin-vars
  (procedure->py-function
    (lambda (object)
      (py-throw-exception-with-message py-builtin-NotImplementedError "vars not implemented"))
    (make-signature posonlyargs: (object) defaults: (vector py-absent))))

;;-------------------- zip(*iterables)

;; Make an iterator that aggregates elements from each of the iterables.
;;
;; Returns an iterator of tuples, where the i-th tuple contains the i-th
;; element from each of the argument sequences or iterables. The iterator
;; stops when the shortest input iterable is exhausted. With a single
;; iterable argument, it returns an iterator of 1-tuples. With no
;; arguments, it returns an empty iterator. Equivalent to:
;;
;; def zip(*iterables):
;;     # zip('ABCD', 'xy') --> Ax By
;;     sentinel = object()
;;     iterators = [iter(it) for it in iterables]
;;     while iterators:
;;         result = []
;;         for it in iterators:
;;             elem = next(it, sentinel)
;;             if elem is sentinel:
;;                 return
;;             result.append(elem)
;;         yield tuple(result)
;;
;; The left-to-right evaluation order of the iterables is
;; guaranteed. This makes possible an idiom for clustering a data series
;; into n-length groups using zip(*[iter(s)]*n). This repeats the same
;; iterator n times so that each output tuple has the result of n calls
;; to the iterator. This has the effect of dividing the input into
;; n-length chunks.
;;
;; zip() should only be used with unequal length inputs when you don’t
;; care about trailing, unmatched values from the longer iterables. If
;; those values are important, use itertools.zip_longest() instead.
;;
;; zip() in conjunction with the * operator can be used to unzip a list:
;;
;; >>>
;; >>> x = [1, 2, 3]
;; >>> y = [4, 5, 6]
;; >>> zipped = zip(x, y)
;; >>> list(zipped)
;; [(1, 4), (2, 5), (3, 6)]
;; >>> x2, y2 = zip(*zip(x, y))
;; >>> x == list(x2) and y == list(y2)
;; True

(define-rts py-builtin-zip
  (procedure->py-function
    (lambda (iterables)
      (py-throw-exception-with-message py-builtin-NotImplementedError "zip not implemented"))
    (make-signature vararg: iterables)))

;;-------------------- __import__(name, globals=None, locals=None, fromlist=(), level=0)

;; Note This is an advanced function that is not needed in everyday
;; Python programming, unlike importlib.import_module().
;;
;; This function is invoked by the import statement. It can be replaced
;; (by importing the builtins module and assigning to
;; builtins.__import__) in order to change semantics of the import
;; statement, but doing so is strongly discouraged as it is usually
;; simpler to use import hooks (see PEP 302) to attain the same goals and
;; does not cause issues with code which assumes the default import
;; implementation is in use. Direct use of __import__() is also
;; discouraged in favor of importlib.import_module().
;;
;; The function imports the module name, potentially using the given
;; globals and locals to determine how to interpret the name in a package
;; context. The fromlist gives the names of objects or submodules that
;; should be imported from the module given by name. The standard
;; implementation does not use its locals argument at all, and uses its
;; globals only to determine the package context of the import statement.
;;
;; level specifies whether to use absolute or relative imports. 0 (the
;; default) means only perform absolute imports. Positive values for
;; level indicate the number of parent directories to search relative to
;; the directory of the module calling __import__() (see PEP 328 for the
;; details).
;;
;; When the name variable is of the form package.module, normally, the
;; top-level package (the name up till the first dot) is returned, not
;; the module named by name. However, when a non-empty fromlist argument
;; is given, the module named by name is returned.
;;
;; For example, the statement import spam results in bytecode resembling
;; the following code:
;;
;; spam = __import__('spam', globals(), locals(), [], 0)
;;
;; The statement import spam.ham results in this call:
;;
;; spam = __import__('spam.ham', globals(), locals(), [], 0)
;;
;; Note how __import__() returns the toplevel module here because this is
;; the object that is bound to a name by the import statement.
;;
;; On the other hand, the statement from spam.ham import eggs, sausage as
;; saus results in
;;
;; _temp = __import__('spam.ham', globals(), locals(), ['eggs', 'sausage'], 0)
;; eggs = _temp.eggs
;; saus = _temp.sausage
;; Here, the spam.ham module is returned from __import__(). From this object, the names to import are retrieved and assigned to their respective names.
;;
;; If you simply want to import a module (potentially within a package)
;; by name, use importlib.import_module().
;;
;; Changed in version 3.3: Negative values for level are no longer
;; supported (which also changes the default value to 0).

(define-rts py-builtin-__import__
  (procedure->py-function
   (lambda (name globals locals fromlist level)
     (cond
      ((eq? globals py-None)
       (if (py-subtype-of-str? name)
           (builtin-__import__ (py-subtype-of-str-to-scheme name))
           (py-throw-exception-with-message py-builtin-TypeError "__import__() argument 1 must be str not " )))
      (else
       (py-throw-exception-with-message py-NotImplemented "__import__ with more than one argument is not yet implemented"))))
   (make-signature
    args: (name globals locals fromlist level)
    defaults:
      (vector
       py-None
       py-None
       py-absent
       (py-int-from-scheme 0)))))

;; Exceptions declarations

(define-rts py-builtin-ArithmeticError #f)
(define-rts py-builtin-AssertionError #f)
(define-rts py-builtin-AttributeError #f)
(define-rts py-builtin-BaseException #f)
(define-rts py-builtin-BlockingIOError #f)
(define-rts py-builtin-BrokenPipeError #f)
(define-rts py-builtin-BufferError #f)
(define-rts py-builtin-BytesWarning #f)
(define-rts py-builtin-ChildProcessError #f)
(define-rts py-builtin-ConnectionAbortedError #f)
(define-rts py-builtin-ConnectionError #f)
(define-rts py-builtin-ConnectionRefusedError #f)
(define-rts py-builtin-ConnectionResetError #f)
(define-rts py-builtin-DeprecationWarning #f)
(define-rts py-builtin-EOFError #f)
(define-rts py-builtin-EnvironmentError #f)
(define-rts py-builtin-Exception #f)
(define-rts py-builtin-FileExistsError #f)
(define-rts py-builtin-FileNotFoundError #f)
(define-rts py-builtin-FloatingPointError #f)
(define-rts py-builtin-FutureWarning #f)
(define-rts py-builtin-GeneratorExit #f)
(define-rts py-builtin-IOError #f)
(define-rts py-builtin-ImportError #f)
(define-rts py-builtin-ImportWarning #f)
(define-rts py-builtin-IndentationError #f)
(define-rts py-builtin-IndexError #f)
(define-rts py-builtin-InterruptedError #f)
(define-rts py-builtin-IsADirectoryError #f)
(define-rts py-builtin-KeyError #f)
(define-rts py-builtin-KeyboardInterrupt #f)
(define-rts py-builtin-LookupError #f)
(define-rts py-builtin-MemoryError #f)
(define-rts py-builtin-ModuleNotFoundError #f)
(define-rts py-builtin-NameError #f)
(define-rts py-builtin-NotADirectoryError #f)
(define-rts py-builtin-NotImplementedError #f)
(define-rts py-builtin-OSError #f)
(define-rts py-builtin-OverflowError #f)
(define-rts py-builtin-PendingDeprecationWarning #f)
(define-rts py-builtin-PermissionError #f)
(define-rts py-builtin-ProcessLookupError #f)
(define-rts py-builtin-RecursionError #f)
(define-rts py-builtin-ReferenceError #f)
(define-rts py-builtin-ResourceWarning #f)
(define-rts py-builtin-RuntimeError #f)
(define-rts py-builtin-RuntimeWarning #f)
(define-rts py-builtin-StopAsyncIteration #f)
(define-rts py-builtin-StopIteration #f)
(define-rts py-builtin-SyntaxError #f)
(define-rts py-builtin-SyntaxWarning #f)
(define-rts py-builtin-SystemError #f)
(define-rts py-builtin-SystemExit #f)
(define-rts py-builtin-TabError #f)
(define-rts py-builtin-TimeoutError #f)
(define-rts py-builtin-TypeError #f)
(define-rts py-builtin-UnboundLocalError #f)
(define-rts py-builtin-UnicodeDecodeError #f)
(define-rts py-builtin-UnicodeEncodeError #f)
(define-rts py-builtin-UnicodeError #f)
(define-rts py-builtin-UnicodeTranslateError #f)
(define-rts py-builtin-UnicodeWarning #f)
(define-rts py-builtin-UserWarning #f)
(define-rts py-builtin-ValueError #f)
(define-rts py-builtin-Warning #f)
(define-rts py-builtin-ZeroDivisionError #f)

;; Exception Helpers


;; TODO: use Zipi print instead of calling __str__ manually
;; error message should just be print(exc.__name__, ": ", exc)
;; TODO: print that to stderr
(define-rts (print-exception exc port)
  (let ((exc-name (getattribute-from-obj-mro exc (& "__name__")))
        (__str__ (getattribute-from-obj-mro exc (& "__str__"))))
    (py-display exc-name port)
    (let ((str-exc (py-call __str__ exc)))
      (if (> (string-length (py-str-to-scheme str-exc)) 0)
        (begin
          (display ": " port)
          (py-display str-exc port))))
    (display "\n" port)))

;;==============================================================================
;; BUILTINS
;;==============================================================================

(define-rts builtins-mod (bootstrap-builtins))

(end-registering-constants)
