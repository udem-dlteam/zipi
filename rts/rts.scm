;; =============================================================================
;;  Common macros
;; =============================================================================

(cond-expand
  (gambit
   (declare (standard-bindings) (extended-bindings) (not safe))
   (define-macro (declare-fixnum . body) `(declare (fixnum)))
   (define-macro (declare-not-interrupts-enabled) `(declare (not interrupts-enabled))))

  (bigloo
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
   (define-macro (declare-not-interrupts-enabled) `(begin))))

;; Specialized type tests for int

(define-macro (py-has-type-int? obj)
  `(let (($obj ,obj))
     (py-if-specialized-int-representation
      (exact-integer? $obj)
      (eq? (py-type $obj) py-int-class))))

(define-macro (py-instance-of-int? obj)
  `(let (($obj ,obj))
     (or (py-if-specialized-int-representation
          (exact-integer? $obj)
          (eq? (vector-ref (py-obj-mro $obj) 0) py-int-class)) ;; common case
         (py-isinstance? $obj py-int-class))))

(cond-expand
  (gambit
   ;; py-int-from-scheme is a macro defined int rts#.scm
   )
  (bigloo
   (define-macro (warn0)
     (print "===bigloo=== py-int-from-scheme should be defined as a macro")
     '(begin))
   (warn0)
   (define (py-int-from-scheme value)
     (py-int-from-scheme-dynamic value))))

(define (py-int-to-scheme obj)
  (py-if-specialized-int-representation
   obj
   (PyObjectInt-value obj)))

(define (py-instance-of-int-to-scheme obj)
  (py-if-specialized-int-representation
   (if (exact-integer? obj)
       obj
       (PyObjectInt-value obj))
   (PyObjectInt-value obj)))

;; Specialized type tests for float

(define-macro (py-has-type-float? obj)
  `(eq? (py-type ,obj) py-float-class))

(define-macro (py-instance-of-float? obj)
  `(let (($obj ,obj))
     (or (eq? (vector-ref (py-obj-mro $obj) 0) py-float-class) ;; common case
         (py-isinstance? $obj py-float-class))))

(define (py-float-from-scheme value)
  (py-float-from-scheme-dynamic value))

(define (py-float-to-scheme obj)
  (py-if-specialized-float-representation
   obj
   (PyObjectFloat-value obj)))

(define (py-instance-of-float-to-scheme obj)
  (py-if-specialized-float-representation
   (if (flonum? obj)
       obj
       (PyObjectFloat-value obj))
   (PyObjectFloat-value obj)))

;; General exception thrower helper
(define-macro (py-throw-exception-with-message exc . msg)
  (define (f el acc)
    (if (and (string? el) (not (null? acc)) (string? (car acc)))
      (cons (string-append el (car acc)) (cdr acc))
      (cons el acc)))

  (define (foldr kons knil lis1 . lists)
     (if (pair? lists)
         (let recur ((lists (cons lis1 lists)))
            (let ((cdrs (%cdrs lists)))
               (if (null? cdrs) knil
                   (apply kons (%cars+ lists (recur cdrs))))))

         (let recur ((lis lis1))
            (if (not (pair? lis)) knil
                (let ((head (car lis)))
                   (kons head (recur (cdr lis))))))))

  (let ((folded-msg (foldr f '() msg)))
    (if (and (= (length folded-msg) 1) (string? (car folded-msg)))
      ;; Use & if given message can be folded to a string literal
      `(py-throw
        (py-call
          ,exc
          (& ,(car folded-msg))))
      `(py-throw
        (py-call
          ,exc
          (py-str-from-scheme (string-append ,@folded-msg)))))))

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

(define-macro (HClass-next hc name op)
  `(let (($hc ,hc) ($name ,name))
    (let* ((key (cons $name ,op))
           (tran (assq key (HClass-transitions $hc))))
      (if (pair? tran)
        (cdr tran)
        (let ((nhclass
                (make-HClass
                  (vector-extend (HClass-names $hc) $name)
                  '())))
          (HClass-transition-add! $hc key nhclass)
          nhclass)))))

(define-macro (str-representatives-eq? self other)
  `(eq? (str-representative-get ,self) (str-representative-get ,other)))

(define-macro (define-all-py-callX)
  (include "config/config.scm")

  (define (define-py-callX X)
    (let ((py-call-name (string->symbol (string-append "py-call" (number->string X))))
          (args (map gensym (make-list X 'arg)))
          (min-neg-arity (- 0 X 1)))
      `(define (,py-call-name fun ,@args)
         (declare-fixnum)
	 (let ((fun-type (py-type fun)))
	    (if (eq? fun-type py-function-class)
		(let ((arity (PyObjectFunction-arity fun)))
		   (cond
		      ((eqv? arity ,X)
		       ((PyObjectFunction-procedure fun) ,@args))
		      ((not arity)
		       (py-call-generic fun (list ,@args)))
		      ((and (< arity 0) (>= arity ,min-neg-arity))
		       (apply
			  (PyObjectFunction-procedure fun)
			  (pack-extra-args arity (list ,@args))))
		      (else
		       ;; Error messages
		       (if (< arity 0)
			   (py-throw-exception-with-message
			      py-builtin-TypeError
			      "missing "
			      ,(number->string (- 0 min-neg-arity X))
			      " required positional argument")
			   (if (< arity ,X)
			       (py-throw-exception-with-message
				  py-builtin-TypeError
				  "function takes "
				  (number->string arity)
				  " positional arguments but "
				  ,(number->string X)
				  " were given")
			       (py-throw-exception-with-message
				  py-builtin-TypeError
				  "missing "
				  (number->string (- arity ,X))
				  " required positional argument"))))))
		(py-call-generic fun (list ,@args)))))))
    (let loop ((i 1) (acc '()))
      (if (> i py-callX-args-limit)
        `(begin ,@acc)
        (loop (+ i 1) (cons (define-py-callX i) acc)))))

(define debug-verbosity 0)

(define (possible-error verbosity . msg)
  (if (>= debug-verbosity verbosity)
      (display (string-append "*** WARNING --- " (append-strings msg) "\n")
               (current-error-port))))

(define (fatal-error . msg)
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

;; WARNING: this must be a constant otherwise it may be garbage collected
;; in some case and no longer be eq? with its version stored in literal objects
(define py-absent '%py-absent)

;; =============================================================================
;;  HIDDEN CLASSES
;; =============================================================================

(define py-object-hclass-of-instances
  (make-builtin-HClass
    (vector)
    '()))

;; instances of type are classes
;; this is the hidden class of classes
(define py-type-hclass-of-instances
   (make-builtin-HClass
      (vector)
;*     (vector                                                         */
;*       (& "__name__")                                                */
;*       (& "__call__"))                                               */
    '()))

(define py-str-hclass-of-instances
  (make-builtin-HClass
    (vector)
    '()))

(define py-tuple-hclass-of-instances
  (make-builtin-HClass
    (vector)
    '()))

(define py-int-hclass-of-instances
  (make-builtin-HClass
    (vector)
    '()))

(define py-float-hclass-of-instances
  (make-builtin-HClass
    (vector)
    '()))

(define py-complex-hclass-of-instances
  (make-builtin-HClass
    (vector)
    '()))

(define py-slice-hclass-of-instances
  (make-builtin-HClass
    (vector)
    '()))


(define py-bytearray-hclass-of-instances
  (make-builtin-HClass
    (vector)
    '()))

(define py-method-hclass-of-instances
  (make-builtin-HClass
    (vector)
;*       (& "__self__"))                                               */
    '()))

(define py-function-hclass-of-instances
  (make-builtin-HClass
    (vector)
    '()))

(define py-list-hclass-of-instances
  (make-builtin-HClass
    (vector)
    '()))

(define py-dict-hclass-of-instances
  (make-builtin-HClass
    (vector)
    '()))

(define py-set-hclass-of-instances
  (make-builtin-HClass
    (vector)
    '()))

(define py-module-hclass-of-instances
  (make-builtin-HClass
    (vector
      (& "__name__")
      (& "__builtins__"))
    '()))

(define py-list-iterator-hclass-of-instances
  (make-builtin-HClass
    (vector)
    '()))

;; bytearray iterator
(define py-bytearray-iterator-hclass-of-instances
  (make-builtin-HClass
   (vector)
   '()))

;; tuple iterator
(define py-tuple-iterator-hclass-of-instances
  (make-builtin-HClass
    (vector)
    '()))

;; dict-keys iterator
(define py-dict-keyiterator-hclass-of-instances
  (make-builtin-HClass
    (vector)
    '()))

(define py-generator-hclass
  (make-builtin-HClass
   (vector)
;*     (& "__next__")                                                  */
;*     (& "send"))                                                     */
   '()))

(define py-TextIOWrapper-hclass-of-instances
  (make-builtin-HClass
    (vector)
    '()))

(define py-super-hclass-of-instances
  (make-builtin-HClass
    (vector)
    '()))

(define py-range-hclass-of-instances
  (make-builtin-HClass
    (vector)
    '()))

(define py-range_iterator-hclass-of-instances
  (make-builtin-HClass
    (vector)
    '()))

;; Method for fast access to attributes defined in hidden classes
;; Those are unsafe methods

(define (method-__self__-fast-get obj)
  (PyObject-elements-ref obj 0))

(define (method-__self__-fast-set! obj value)
  (PyObject-elements-set! obj 0 value))

;; object allocation

(define (py-obj-alloc cls hclass-of-instances)
  (let ((self
         (make-PyObject
          hclass-of-instances
          (make-vector
            (vector-length (HClass-names hclass-of-instances))
            py-absent)
          cls)))
    self))

;; type allocation

(define (py-type-alloc metaclass bases mro hclass-of-instance)
  (make-PyObjectType
    py-type-hclass-of-instances
    (make-vector
      (vector-length (HClass-names py-type-hclass-of-instances))
      py-absent)
    metaclass
    bases
    mro
    hclass-of-instance))

(define (py-builtin-type-alloc metaclass bases mro hclass-of-instance)
  (make-still-copy
    (make-PyObjectType
      py-type-hclass-of-instances
      (make-vector
        (vector-length (HClass-names py-type-hclass-of-instances))
        py-absent)
      metaclass
      bases
      mro
      hclass-of-instance)))

(define (py-dict-alloc ordered-table)
  (make-PyObjectDict
    py-dict-hclass-of-instances
    (make-vector
      (vector-length (HClass-names py-dict-hclass-of-instances))
      py-absent)
    py-dict-class
    ordered-table))

(define (py-dict-keyiterator-alloc first iterator-token)
  (make-PyObjectDictKeyIterator
    py-dict-keyiterator-hclass-of-instances
    (make-vector
      (vector-length (HClass-names py-dict-keyiterator-hclass-of-instances))
      py-absent)
    py-dict-keyiterator-class
    first
    iterator-token))

(define (py-list-iterator-alloc index lst)
  (make-PyObjectListIterator
    py-list-iterator-hclass-of-instances
    (make-vector
      (vector-length (HClass-names py-list-iterator-hclass-of-instances))
      py-absent)
    py-list-iterator-class
    index
    lst))

(define (py-tuple-iterator-alloc index vec)
  (make-PyObjectTupleIterator
    py-tuple-iterator-hclass-of-instances
    (make-vector
      (vector-length (HClass-names py-tuple-iterator-hclass-of-instances))
      py-absent)
    py-tuple-iterator-class
    index
    vec))

(define (py-bytearray-iterator-alloc index bytearray)
  (make-PyObjectBytearrayIterator
    py-bytearray-iterator-hclass-of-instances
    (make-vector
      (vector-length (HClass-names py-bytearray-iterator-hclass-of-instances))
      py-absent)
    py-bytearray-iterator-class
    index
    bytearray))

(define (py-TextIOWrapper-alloc port mode encoding)
  (make-PyObjectTextIOWrapper
    py-TextIOWrapper-hclass-of-instances
    (make-vector
      (vector-length (HClass-names py-TextIOWrapper-hclass-of-instances))
      py-absent)
    py-TextIOWrapper-class
    port
    mode
    encoding))

;; ----------------------------------------------------------------------------
(define (append-lists list-of-lists)
  (let outer-loop ((lists-tail list-of-lists) (outer-acc '()))
    (if (null? lists-tail)
      (reverse! outer-acc)
      (let inner-loop ((head (car lists-tail)) (inner-acc outer-acc))
        (if (null? head)
          (outer-loop (cdr lists-tail) inner-acc)
          (inner-loop (cdr head) (cons (car head) inner-acc)))))))

(define (global-get global name cache)
   (if (eq? (PyObject-hclass global) (PCache-hclass cache))
     (let ((val (PyObject-elements-ref global (PCache-index cache))))
       (if (not (eq? val py-absent))
           val
           ;; TODO: use a different cache
           (global-get-from-builtins name cache)))
     (global-get/miss global name cache)))

(define (global-get/miss global name cache)
  (let ((i (py-own-attr-index global name)))
    (if (< i 0)
      ;; as per Python 3.8 (maybe 3.7?) builtins module is no longer recovered
      ;; through __builtins__, this was also documented as an implementation
      ;; detail: https://docs.python.org/3/library/builtins.html
      ;; TODO: use a different cache
      (global-get-from-builtins name cache)
      (let ((hclass (PyObject-hclass global)))
        (PCache-set! cache hclass i)
        (let ((val (PyObject-elements-ref global i)))
          (if (not (eq? val py-absent))
              val
              ;; TODO: use a different cache
              (global-get-from-builtins name cache)))))))

;; TODO: use a cache for builtins and one for global access
(define (global-get-from-builtins name cache)
  (define (throw-NameError)
    (py-throw-exception-with-message
      py-builtin-NameError
      "name '" (PyObjectStr-value name) "' is not defined"))
  (let ((builtins-hclass (PyObject-hclass builtins-mod)))
    (if (eq? builtins-hclass (PCache-hclass cache))
      (let ((val (PyObject-elements-ref builtins-mod (PCache-index cache))))
        (if (eq? val py-absent)
          (throw-NameError)
          val))
      (let ((i (py-own-attr-index builtins-mod name)))
        (if (< i 0)
          (throw-NameError)
          (let ((val (PyObject-elements-ref builtins-mod i)))
            (PCache-set! cache builtins-hclass i)
            (if (eq? val py-absent)
                (throw-NameError)
                val)))))))

(define (global-put! global name val cache)
   (if (eq? (PyObject-hclass global) (PCache-hclass cache))
       (PyObject-elements-set! global (PCache-index cache) val)
       (object-put!/miss global name val cache)))

(define (object-put!/miss obj name val cache)
  (let* ((index (py-own-attr-index obj name))
         (hclass (PyObject-hclass obj)))
    (if (>= index 0)
        (begin
          (PCache-set! cache hclass index)
          (PyObject-elements-set! obj index val))
        (let* ((name-representative (str-representative-get name))
               (nhclass (HClass-next hclass name-representative '+))
               (index (HClass-last-index nhclass)))
          (PyObject-hclass-set! obj nhclass)
          (PCache-set! cache nhclass index)
          (PyObject-elements-set! obj index val)))))

;; Boostrap functions
;; Functions are objects of type 'function', but their type cannot be assigned
;; as long as the py-function-class has not been created.
;; Before the creation of py-function-class, we instantiate class-less objects
;; which we keep in the functions-awaiting-bootstap list. Once py-function-class
;; is created, we can recover these functions and add their type.

(define functions-awaiting-bootstap '())

;; signature: '#(args posonlyargs vararg kwonlyargs kw_defaults kwarg defaults)
;; takes in a signature and returns an arity.
;; positive arity: a function takes a fixed number of positional arguments
;; negative arity: functions takes x arguments, last argument is a *args
;; #f arity: unknown arity due to defaults value
(define (signature->arity signature)
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

(define (prebootstrap-procedure->py-function procedure signature)
  (let ((py-function
          (make-PyObjectFunction
            py-function-hclass-of-instances
            (make-vector
              (vector-length (HClass-names py-function-hclass-of-instances))
              py-absent)
            #f
            procedure
            (signature->arity signature)
            signature)))
    (set!
      functions-awaiting-bootstap
      (cons py-function functions-awaiting-bootstap))
    py-function))

(define (postbootstrap-procedure->py-function procedure signature)
  (make-PyObjectFunction
    py-function-hclass-of-instances
    (make-vector
      (vector-length (HClass-names py-function-hclass-of-instances))
      py-absent)
    py-function-class
    procedure
    (signature->arity signature)
    signature))

(define procedure->py-function prebootstrap-procedure->py-function)

(define (bootstrap-functions)
  (set! procedure->py-function postbootstrap-procedure->py-function)
  (let loop ((functions functions-awaiting-bootstap))
    (if (not (null? functions))
      (begin
        (PyObject-class-set! (car functions) py-function-class)
        (loop (cdr functions))))))

(define (pack-extra-args arity args)
  (if (= arity -1)
    (cons (py-tuple-from-scheme (list->vector args)) '())
    (cons (car args) (pack-extra-args (+ arity 1) (cdr args)))))

(define (py-call0 fun)
  (let ((fun-type (py-type fun)))
    (if (eq? fun-type py-function-class)
      (let ((arity (PyObjectFunction-arity fun)))
        (cond
          ((not arity) (py-call-generic fun '()))
          ((= arity 0)
            ((PyObjectFunction-procedure fun)))
          ((= arity -1)
            ((PyObjectFunction-procedure fun)
              (py-tuple-from-scheme '#())))
          (else
            (let ((min-pos-arguments (if (< arity 0) (- 0 arity 1) arity)))
              (py-throw-exception-with-message
                py-builtin-TypeError
                "function takes "
                (number->string min-pos-arguments)
                " positional arguments but 0 were given")))))
      (py-call-generic fun '()))))

(define-all-py-callX)

(define (py-call-generic/*args obj args *args-lst)
  (let ((unpacked-args (iterables*->list *args-lst)))
    (py-call-generic obj (append args unpacked-args))))

(define (py-call-generic obj args)
  (let ((obj-type (py-type obj)))
    (cond
      ((eq? obj-type py-function-class)
        (let* ((procedure (PyObjectFunction-procedure obj))
               (signature (PyObjectFunction-signature obj))
               (aligned-args (align-args-with-signature args signature)))
          (apply procedure aligned-args)))
      ((eq? obj-type py-method-class)
        (let* ((procedure (PyObjectMethod-procedure obj))
               (signature (PyObjectMethod-signature obj))
               (__self__ (method-__self__-fast-get obj))
               (bound-args (cons __self__ args))
               (aligned-args (align-args-with-signature bound-args signature)))
          (apply procedure aligned-args)))
      (else
        (let ((__call__ (getattribute-from-obj-mro obj (& "__call__"))))
          (if (eq? __call__ py-absent)
            (py-throw-not-callable obj)
            (py-call-generic __call__ (cons obj args))))))))

(define (align-args-with-signature caller-args signature)
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
          (total-args-len (+ args-len posonlyargs-len)))
      (cond
        ((= caller-args-len total-args-len)
          (if vararg
            (append
              caller-args
              (cons (py-tuple-from-scheme '#()) '())
              (vector->list kw-defaults)
              (if kwarg (cons (py-make-empty-dict) '()) '()))
            (if (or kwarg (> (vector-length kw-defaults) 0))
              (append
                caller-args
                (vector->list kw-defaults)
                (if kwarg (cons (py-make-empty-dict) '()) '()))
              caller-args)))
        ((< caller-args-len total-args-len)
          (let ((missing-args-len (- total-args-len caller-args-len)))
            (if (>= default-len missing-args-len)
              (append
                caller-args
                (vector->list
                  (subvector defaults (- default-len missing-args-len) default-len))
                (vector->list kw-defaults)
                (if kwarg (cons (py-make-empty-dict) '()) '()))
              (py-throw-exception-with-message
                py-builtin-TypeError
                "missing "
                (number->string (- missing-args-len default-len))
                " required positional argument"))))
        (vararg
          (if (or kwarg (> (vector-length kw-defaults) 0))
            (append
              (pack-extra-args (- 0 1 total-args-len) caller-args)
              (vector->list kw-defaults)
              (if kwarg (cons (py-make-empty-dict) '()) '()))
            (pack-extra-args (- 0 1 total-args-len) caller-args)))
        (else
          (if (= default-len 0)
            (py-throw-exception-with-message
              py-builtin-TypeError
              "function takes "
              (number->string total-args-len)
              " arguments but "
              (number->string caller-args-len)
              " were given")
            (let ((min-pos-arguments (- total-args-len default-len)))
              (py-throw-exception-with-message
                py-builtin-TypeError
                "function takes from "
                (number->string min-pos-arguments)
                " to "
                (number->string total-args-len)
                " arguments but "
                (number->string caller-args-len)
                " were given"))))))))

(define (py-call-hashed-kwargs obj args *args-lst kwargs-table)
  (let ((obj-type (py-type obj)))
    (cond
      ((eq? obj-type py-function-class)
        (let* ((procedure (PyObjectFunction-procedure obj))
               (signature (PyObjectFunction-signature obj))
               (aligned-args (align-with-signature/hashed-kwargs args kwargs-table *args-lst signature)))
          (apply procedure aligned-args)))
      ((eq? obj-type py-method-class)
        (let* ((procedure (PyObjectMethod-procedure obj))
               (signature (PyObjectMethod-signature obj))
               (__self__ (method-__self__-fast-get obj))
               (bound-args (cons __self__ args))
               (aligned-args (align-with-signature/hashed-kwargs bound-args kwargs-table *args-lst signature)))
          (apply procedure aligned-args)))
      (else
        (let ((__call__ (getattribute-from-obj-mro obj (& "__call__"))))
          (if (eq? __call__ py-absent)
            (py-throw-not-callable obj)
            (py-call-hashed-kwargs __call__ (cons obj args) *args-lst kwargs-table)))))))

(define (py-call-generic-kwargs obj args *args-lst kwargs **kwargs-lst)
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
        (let* ((procedure (PyObjectMethod-procedure obj))
               (signature (PyObjectMethod-signature obj))
               (__self__ (method-__self__-fast-get obj))
               (bound-args (cons __self__ args))
               (kwargs-ordered-table (make-kwargs-ordered-table kwargs **kwargs-lst))
               (aligned-args (align-with-signature/kwargs-ordered-table bound-args kwargs-ordered-table *args-lst signature)))
          (apply procedure aligned-args)))
      (else
        (let ((__call__ (getattribute-from-obj-mro obj (& "__call__"))))
          (if (eq? __call__ py-absent)
            (py-throw-not-callable obj)
            (py-call-generic-kwargs __call__ (cons obj args) *args-lst kwargs **kwargs-lst)))))))

(define (unpack-kwargs obj)
  (let* ((keys-method (py-getattribute obj (& "keys")))
        (mapping-keys (py-call keys-method))
        (keys-iterator (py-iter mapping-keys)))
    (let loop ((acc '()) (next-key (py-next keys-iterator)))
      (cond
        ((PyObjectStr? next-key)
          (loop
            (cons (cons next-key (py-getitem obj next-key)) acc)
            (py-next keys-iterator)))
        ((not next-key)
          (reverse! acc))
        (else
          (py-throw-exception-with-message
            py-builtin-TypeError
            "keywords must be strings"))))))

(define kwargs-already-seen '%kwargs-already-seen)

(define (kwargs-table-pop! table key)
  ;; NOTE: key will always either be from a signature or a call-table
  ;; key will always have been hashed at compile time
  (let* ((index-table (vector-ref table 0))
        (hash (PyObjectStr-hash key))
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

(define (zip-vectors vec1 vec2)
  (map
    cons
    (vector->list vec1)
    (vector->list vec2)))

(define (ncdr lst n)
  (if (= n 0)
    lst
    (ncdr (cdr lst) (- n 1))))

(define-macro (define-signature-aligner name get-values get-values-or-default get-unused-kwargs)
  `(define (,name pos-caller-args caller-kwargs-table *args-lst signature)
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

(define (align-with-signature-hashed-kwargs:get-values args kwargs-table)
  (if (null? args)
    '()
    (let* ((name (car args))
          (value (kwargs-table-pop! kwargs-table name)))
      (if value
        (cons (cdr value) (align-with-signature-hashed-kwargs:get-values (cdr args) kwargs-table))
        (py-throw-exception-with-message
          py-builtin-TypeError
          "pending exception message (code 23)")))))

(define (align-with-signature-hashed-kwargs:get-values-or-default args-defaults kwargs-table)
  (if (null? args-defaults)
    '()
    (let* ((name (caar args-defaults))
          (default (cdar args-defaults))
          (value (kwargs-table-pop! kwargs-table name)))
      (cond
        ((not value)
          (cons default (align-with-signature-hashed-kwargs:get-values (cdr args-defaults) kwargs-table)))
        ((eq? value kwargs-already-seen)
          (py-throw-exception-with-message
            py-builtin-TypeError
            "pending exception message (code 24)"))
        (else
          (cons (cdr value) (align-with-signature-hashed-kwargs:get-values (cdr args-defaults) kwargs-table)))))))

(define (align-with-signature-hashed-kwargs:get-unused-kwargs kwargs-table kwarg)
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
        (let ((unknown-keyword (str-force! (caar unused-kwargs))))
          (py-throw-exception-with-message
            py-builtin-TypeError
            "got an unexpected keyword argument '" unknown-keyword "'"))))))

(define-signature-aligner
  align-with-signature/hashed-kwargs
  align-with-signature-hashed-kwargs:get-values
  align-with-signature-hashed-kwargs:get-values-or-default
  align-with-signature-hashed-kwargs:get-unused-kwargs)

(define (align-with-signature-kwargs-ordered-table:get-values args ordered-table)
  (if (null? args)
    '()
    (let* ((name (car args))
          (value (ordered-table-pop! ordered-table name #f)))
      (if value
        (cons value (align-with-signature-kwargs-ordered-table:get-values (cdr args) ordered-table))
        (py-throw-exception-with-message
          py-builtin-TypeError
          "pending exception message (code 30)")))))

(define (align-with-signature-kwargs-ordered-table:get-values-or-default args-defaults ordered-table)
  (if (null? args-defaults)
    '()
    (let* ((name (caar args-defaults))
           (default (cdar args-defaults))
           (value (ordered-table-pop! ordered-table name #f)))
      (cond
        ((not value)
          (cons default (align-with-signature-kwargs-ordered-table:get-values (cdr args-defaults) ordered-table)))
        ((eq? value kwargs-already-seen)
          (py-throw-exception-with-message
            py-builtin-TypeError
            "pending exception message (code 31)"))
        (else
          (cons value (align-with-signature-kwargs-ordered-table:get-values (cdr args-defaults) ordered-table)))))))

(define (align-with-signature-kwargs-ordered-table:get-unused-kwargs unused-kwargs kwarg)
  (if kwarg
    (list (py-dict-alloc unused-kwargs))
    (if (= (ordered-table-length unused-kwargs) 0)
      '()
      (let ((unknown-keyword (str-force! (ordered-table-first-key unused-kwargs))))
        (py-throw-exception-with-message
          py-builtin-TypeError
          "got an unexpected keyword argument '" unknown-keyword "'")))))

(define-signature-aligner
  align-with-signature/kwargs-ordered-table
  align-with-signature-kwargs-ordered-table:get-values
  align-with-signature-kwargs-ordered-table:get-values-or-default
  align-with-signature-kwargs-ordered-table:get-unused-kwargs)

(define (py-is-in-mro? target mro)
  (declare-fixnum)
  (let loop ((i 0))
     (and (< i (vector-length mro))
	  (let* ((cls (vector-ref mro i)))
	     (or (eq? cls target)
		 (loop (+ i 1)))))))

(define (py-isinstance? obj cls)
  (let ((mro (py-obj-mro obj)))
    (py-is-in-mro? cls mro)))

(define (py-issubclass? cls parent)
  (if (py-isinstance? cls py-type-class)
    (let ((mro (PyObjectType-mro cls)))
      (py-is-in-mro? parent mro))
    #f))

(define (py-throw exc)
  (cond ((not (PyObject? exc))
         (raise (py-call py-builtin-TypeError)))
        ((py-is-in-mro? py-builtin-BaseException (py-obj-mro exc))
         (raise exc))
        ((py-is-in-mro? py-builtin-BaseException (PyObjectType-mro exc))
         (raise (py-call exc)))
        (else
         (raise (py-call py-builtin-TypeError)))))

;; =============================================================================
;; Exception thrower helpers
;; =============================================================================
(define (throw-unsupported-unary-operand x operator)
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

(define (throw-unhashable x)
  (let ((x-type-name (py-own-attr-ref (py-type x) (& "__name__"))))
    (py-throw
      (py-call
        py-builtin-TypeError
        (py-str-from-scheme
          (string-append
            "unhashable type: '"
            (py-str-to-scheme x-type-name)
            "'"))))))

(define (py-throw-not-an-integer obj)
  (let ((given-type (py-str-to-scheme (py-own-attr-ref (py-type obj) (& "__name__")))))
    (py-throw
      (py-call py-builtin-TypeError
        (py-str-from-scheme
          (string-append
            "'"
            given-type
            "' object cannot be interpreted as an integer"))))))

(define (py-throw-has-no-len obj)
  (let ((given-type (py-str-to-scheme (py-own-attr-ref (py-type obj) (& "__name__")))))
    (py-throw
      (py-call py-builtin-TypeError
        (py-str-from-scheme
          (string-append
            "object of type '"
            given-type
            "' has no len()"))))))

(define (py-throw-index-out-of-range type)
  (py-throw
    (py-call py-builtin-IndexError
      (py-str-from-scheme
        (string-append
          type
          " index out of range")))))

(define (py-throw-action-out-of-range type action)
  (py-throw
    (py-call py-builtin-IndexError
      (py-str-from-scheme
        (string-append
          type
          " "
          action
          " out of range")))))

(define (py-throw-pop-from-empty-list)
  (py-throw
    (py-call py-builtin-IndexError
      (py-str-from-scheme "pop from empty list"))))

(define (py-throw-wrong-index-type type expected-description item)
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

(define (py-throw-can-only-assign-iterable)
  (py-throw
    (py-call py-builtin-TypeError
      (&& "can only assign an iterable"))))

(define (py-throw-extended-slice-wrong-len actual-len expected-len)
  (py-throw
    (py-call py-builtin-ValueError
      (py-str-from-scheme
        (string-append
          "attempt to assign sequence of size "
          (number->string actual-len)
          " to extended slice of size "
          (number->string expected-len))))))

(define (throw-not-iteralble obj)
  (let ((obj-type-name (py-own-attr-ref (py-type obj) (& "__name__"))))
    (py-throw (py-call
                py-builtin-TypeError
                (py-str-from-scheme
                  (string-append
                    "argument of type '"
                    (py-str-to-scheme obj-type-name)
                    "' is not iterable"))))))

(define (py-throw-not-an-iterator obj)
  (let ((given-type (py-str-to-scheme (py-own-attr-ref (py-type obj) (& "__name__")))))
    (py-throw
      (py-call py-builtin-TypeError
        (py-str-from-scheme
          (string-append "'" given-type "' object is not an iterator"))))))

(define (py-throw-not-callable obj)
  (let ((given-type (py-str-to-scheme (py-own-attr-ref (py-type obj) (& "__name__")))))
    (py-throw
      (py-call py-builtin-TypeError
        (py-str-from-scheme
          (string-append "'" given-type "' object is not callable"))))))

(define (py-throw-required-type method-name required-type arg)
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

(define (py-throw-not-a-subtype fun-name wrong-type type-name)
  (let ((wrong-type-name (py-str-to-scheme (py-own-attr-ref wrong-type (& "__name__")))))
    (py-throw
      (py-call py-builtin-TypeError
        (py-str-from-scheme
          (string-append
              fun-name "(" wrong-type-name "): " wrong-type-name " is not a subtype of " type-name))))))

(define (py-throw-not-a-type-object fun-name obj)
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
(define (py-throw-wrong-new-argument cls-name arg)
  (let ((fun-name (string-append cls-name ".__new__")))
    (if (py-isinstance? arg py-type-class)
      (py-throw-not-a-subtype fun-name arg cls-name)
      (py-throw-not-a-type-object fun-name arg))))

(define (throw-returned-wrong-type fun-name obj qualifier)
  (let* ((type (py-type obj))
         (type-name (py-own-attr-ref type (& "__name__"))))
    (py-throw
      (py-call
        py-builtin-TypeError
        (py-str-from-scheme
          (string-append
            fun-name " returned " qualifier " (type " type-name ")"))))))

;; -----------------------------------------------------------------------------

(define (py-make-caches size)
   (list->vector
      (map (lambda (n) (make-PCache #f -1))
         (iota size))))

;;;----------------------------------------------------------------------------

;; =============================================================================
;;  OPERATORS PROTOCOLS
;; =============================================================================

(define (throw-unsupported-operand x y operator)
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

;; ==
(define (py-eq x y)
  (let* ((__eq__ (getattribute-from-obj-mro x (& "__eq__")))
         (left-op-result
            (if (eq? __eq__ py-absent)
              py-NotImplemented
              (py-call __eq__ x y))))
      (if (eq? left-op-result py-NotImplemented)
        (let ((right-__eq__ (getattribute-from-obj-mro y (& "__eq__"))))
          (let ((right-op-result
                  (if (eq? right-__eq__ py-absent)
                    py-NotImplemented
                    (py-call right-__eq__ y x))))
            (if (eq? right-op-result py-NotImplemented)
              ;; fall back on 'is'
              (py-is x y)
              right-op-result)))
        left-op-result)))


;; !=
(define (py-ne x y) ;; x != y
  (let ((__ne__ (getattribute-from-obj-mro x (& "__ne__"))))
    (let ((left-op-result
            (if (eq? __ne__ py-absent)
              py-NotImplemented
              (py-call __ne__ x y))))
      (if (eq? left-op-result py-NotImplemented)
        (let* ((right-__ne__ (getattribute-from-obj-mro y (& "__ne__")))
               (right-op-result
                  (if (eq? right-__ne__ py-absent)
                    py-NotImplemented
                    (py-call right-__ne__ y x))))
            (if (eq? right-op-result py-NotImplemented)
              ;; fall back on 'not x == y'
              (let ((eq-result (py-eq x y)))
                (if (py-test eq-result)
                  py-False
                  py-True))
              right-op-result))
        left-op-result))))

;; generic operator protocol
(define-macro (define-binary-operator-protocol fun-name method rmethod operator)
 `(define (,fun-name x y)
   (let ((__op__ (getattribute-from-obj-mro x (& ,method))))
     (let ((left-op-result
             (if (eq? __op__ py-absent)
               py-NotImplemented
               (py-call __op__ x y))))
       (if (eq? left-op-result py-NotImplemented)
         (let ((__rop__ (getattribute-from-obj-mro y (& ,rmethod))))
           (let ((right-op-result
                   (if (eq? __rop__ py-absent)
                     py-NotImplemented
                     (py-call __rop__ y x))))
             (if (eq? right-op-result py-NotImplemented)
               (throw-unsupported-operand x y ,operator)
               right-op-result)))
         left-op-result)))))

(define-binary-operator-protocol py-lt "__lt__" "__gt__" "<")

(define-binary-operator-protocol py-le "__le__" "__ge__" "<=")

(define-binary-operator-protocol py-gt "__gt__" "__lt__" ">")

(define-binary-operator-protocol py-ge "__ge__" "__le__" ">=")

(define (py-is x y) ;; x is y
  (if (eq? x y)
    py-True
    py-False))

(define (py-isnot x y) ;; x is not y
  (if (not (eq? x y))
    py-True
    py-False))

;; special case of x in y when y is an iterator
(define (py-in-iterator item iterator)
  (let ((next-item (py-next iterator)))
    (cond
      ((not next-item) py-False)
      ((py-eq item next-item) py-True)
      (else (py-in-iterator item iterator)))))

(define (py-in item container) ;; x in y
  (let ((__contains__ (getattribute-from-obj-mro container (& "__contains__"))))
    (if (eq? __contains__ py-absent)
      (let ((iterator (py-obj->iterator container)))
        (if iterator
          (py-in-iterator item iterator)
          (throw-not-iteralble container)))
      (if (py-test (py-call __contains__ container item)) py-True py-False))))

(define (py-notin item container) ;; x not in y
  (if (py-test (py-in item container))
    py-False
    py-True))

(define-macro (define-inplace-operator-protocol
                fun-name
                imethod
                lmethod
                rmethod
                operator)
  (let ((fall-back-name (string->symbol
          (string-append (symbol->string fun-name) "$fall-back"))))
    `(begin
      (define-binary-operator-protocol ,fall-back-name ,lmethod ,rmethod ,operator)
      (define (,fun-name x y cache)
        (let ((__op__ (getattribute-from-obj-mro x (& ,imethod))))
          (let ((inplace-result
                  (if (eq? __op__ py-absent)
                    py-NotImplemented
                    (py-call __op__ x y))))
            (if (eq? inplace-result py-NotImplemented)
              (,fall-back-name x y)
              inplace-result)))))))

(define-inplace-operator-protocol py-iadd "__iadd__" "__add__" "__radd__" "+=")

(define-inplace-operator-protocol py-iand "__iand__" "__and__" "__rand__" "&=")

(define-inplace-operator-protocol py-idiv "__itruediv__" "__truediv__" "__rtruediv__" "/=")

(define-inplace-operator-protocol py-ifloordiv "__ifloordiv__" "__floordiv__" "__rfloordiv__" "//=")

(define-inplace-operator-protocol py-ilshift "__ilshift__" "__lshift__" "__rlshift__" "<<=")

(define-inplace-operator-protocol py-imatmul "__imatmul__" "__matmul__" "__rmatmul__" "@=")

(define-inplace-operator-protocol py-imod "__imod__" "__mod__" "__rmod__" "%=")

(define-inplace-operator-protocol py-imul "__imul__" "__mul__" "__rmul__" "*=")

(define-inplace-operator-protocol py-ior "__ior__" "__or__" "__ror__" "|=")

(define-inplace-operator-protocol py-ipow "__ipow__" "__pow__" "__rpow__" "**=")

(define-inplace-operator-protocol py-irshift "__irshift__" "__rshift__" "__rrshift__" ">>=")

(define-inplace-operator-protocol py-isub "__isub__" "__sub__" "__rsub__" "-=")

(define-inplace-operator-protocol py-ixor "__ixor__" "__xor__" "__ixor__" "^=")

;; Unary operators
(define-macro (define-unary-operator-protocol fun-name method operator)
  `(define (,fun-name x cache)
    (let ((__op__ (getattribute-from-obj-mro x (& ,method))))
      (if (eq? __op__ py-absent)
          (throw-unsupported-unary-operand x ,operator)
          (py-call __op__ x)))))

(define-unary-operator-protocol py-invert "__invert__" "~")

(define-unary-operator-protocol py-neg "__neg__" "-")

(define-unary-operator-protocol py-pos "__pos__" "+")

;; meant to be called as the builtin abs(), not an operator but follows
;; the same logic
(define (py-abs x)
  (let ((__abs__ (getattribute-from-obj-mro x (& "__abs__"))))
    (if (eq? __abs__ py-absent)
        (throw-unsupported-unary-operand x "abs()")
        (py-call __abs__ x))))

(define (py-hash x)
  (let ((__hash__ (getattribute-from-obj-mro x (& "__hash__"))))
    (if (eq? __hash__ py-absent)
        (throw-unhashable x)
        (let ((h (py-call __hash__ x)))
          (if (py-instance-of-int? h)
            (let ((h-value (py-instance-of-int-to-scheme h)))
              (py-int-from-scheme (truncate-hash h-value)))
            (py-throw-exception-with-message
               py-builtin-RuntimeError
               "__hash__ method should return an integer"))))))


(define (py-dir x)
  (if (eq? x py-absent)
      (py-throw-exception-with-message
        py-builtin-NotImplementedError
        "dir() call with no arguments is not yet implemented ")
      (let ((__dir__ (getattribute-from-obj-mro x (& "__dir__"))))
       (py-call py-builtin-sorted (py-call __dir__ x)))))

;; =============================================================================
;; int operations
;; =============================================================================

(define (int-new cls value)
  (cond

   ((eq? cls py-int-class)
    (cond
     ((eq? value py-absent)
      ;; TODO this could be removed by setting value default to the int 0
      ;; int() return 0
      (py-int-from-scheme 0))
     ((py-has-type-int? value)
      ;; int(x) return the same object when x is an int
      value)
     ((py-instance-of-int? value)
      ;; up-typing an instance of subclass to an int
      (py-int-from-scheme (py-instance-of-int-to-scheme value)))
     (else
      (py-throw-exception-with-message
       py-builtin-NotImplementedError
       "int.__new__ unimplemented for non int"))))

   ((py-issubclass? cls py-int-class)
    (cond
     ((eq? value py-absent)
      (py-int-subtype-from-scheme 0 cls))
     ((py-instance-of-int? value)
      (py-int-subtype-from-scheme (py-instance-of-int-to-scheme value) cls))
     (else
      (py-throw-exception-with-message
       py-builtin-NotImplementedError
       "int.__new__ only supports subtypes of int"))))

   (else
    (py-throw-wrong-new-argument "int" cls))))

(define int.__new__
  (procedure->py-function
    int-new
    (make-signature posonlyargs: (cls value) defaults: (vector py-absent))))

(define-macro (define-int-into-int-binary-operator fun-name method-name scheme-op)
  (let ((py-func-name (string->symbol (string-append "int." method-name))))
    `(begin
       (define (,fun-name self other)
         (if (py-instance-of-int? self)
             (if (py-instance-of-int? other)
                 (py-int-from-scheme
                  (,scheme-op (py-instance-of-int-to-scheme self)
                              (py-instance-of-int-to-scheme other)))
                 py-NotImplemented)
             (py-throw-required-type ,method-name "int" self)))
       (define ,py-func-name
         (procedure->py-function
          ,fun-name
          (make-signature posonlyargs: (self other)))))))

(define-macro (define-int-into-int-division-operator fun-name method-name scheme-op)
  (let ((py-func-name (string->symbol (string-append "int." method-name))))
    `(begin
       (define (,fun-name self other)
         (if (py-instance-of-int? self)
             (if (py-instance-of-int? other)
                 (let ((other-value (py-instance-of-int-to-scheme other)))
                   (if (not (= 0 other-value))
                       (py-int-from-scheme
                        (,scheme-op (py-instance-of-int-to-scheme self)
                                    other-value))
                       (py-throw
                        (py-call py-builtin-ZeroDivisionError
                                 (&& "integer division or modulo by zero")))))
                 py-NotImplemented)
             (py-throw-required-type ,method-name "int" self)))
       (define ,py-func-name
         (procedure->py-function
          ,fun-name
          (make-signature posonlyargs: (self other)))))))

(define-macro (define-int-into-float-division-operator fun-name method-name scheme-op)
  (let ((py-func-name (string->symbol (string-append "int." method-name))))
    `(begin
       (define (,fun-name self other)
         (if (py-instance-of-int? self)
             (if (py-instance-of-int? other)
                 (let ((other-value (py-instance-of-int-to-scheme other)))
                   (if (not (= 0 other-value))
                       (py-float-from-scheme
                        (,scheme-op (inexact
                                     (py-instance-of-int-to-scheme self))
                                    other-value))
                       (py-throw
                        (py-call py-builtin-ZeroDivisionError
                                 (&& "division by zero")))))
                 py-NotImplemented)
             (py-throw-required-type ,method-name "int" self)))
       (define ,py-func-name
         (procedure->py-function
          ,fun-name
          (make-signature posonlyargs: (self other)))))))

(define-macro (define-int-comparison-operator fun-name method-name scheme-op)
  (let ((py-func-name (string->symbol (string-append "int." method-name))))
    `(begin
       (define (,fun-name self other)
         (if (py-instance-of-int? self)
             (if (py-instance-of-int? other)
                 (if (,scheme-op (py-instance-of-int-to-scheme self)
                                 (py-instance-of-int-to-scheme other))
                     py-True
                     py-False)
                 py-NotImplemented)
             (py-throw-required-type ,method-name "int" self)))
       (define ,py-func-name
         (procedure->py-function
          ,fun-name
          (make-signature posonlyargs: (self other)))))))

(define-macro (define-int-unary-operator fun-name method-name scheme-op)
  (let ((py-func-name (string->symbol (string-append "int." method-name))))
    `(begin
       (define (,fun-name self)
         (if (py-instance-of-int? self)
             (py-int-from-scheme
              (,scheme-op (py-instance-of-int-to-scheme self)))
             (py-throw-required-type ,method-name "int" self)))
       (define ,py-func-name
         (procedure->py-function
          ,fun-name
          (make-signature posonlyargs: (self)))))))

;; helpers

(define (arithmetic-lshift x y) (arithmetic-shift x (- y)))

(define (!= x y) (not (= x y)))

;; operations

(define-int-into-int-binary-operator int-add "__add__" +)

(define-int-into-int-binary-operator int-sub "__sub__" -)

(define-int-into-int-binary-operator int-mul "__mul__" *)

(define-int-into-int-binary-operator int-and "__and__" bitwise-and)

(define-int-into-int-binary-operator int-lshift "__lshift__" arithmetic-shift)

(define-int-into-int-binary-operator int-rshift "__rshift__" arithmetic-lshift)

(define-int-into-int-binary-operator int-or "__or__" bitwise-ior)

(define-int-into-int-binary-operator int-pow "__pow__" expt)

(define-int-into-int-binary-operator int-xor "__xor__" bitwise-xor)

(define-int-into-int-division-operator int-mod "__mod__" modulo)

(define-int-into-int-division-operator int-floordiv "__floordiv__" floor-quotient)

(define-int-into-float-division-operator int-truediv "__truediv__" /)

;; Comparisons

(define-int-comparison-operator int-eq "__eq__" =)

(define-int-comparison-operator int-ne "__ne__" !=)

(define-int-comparison-operator int-lt "__lt__" <)

(define-int-comparison-operator int-lte "__le__" <=)

(define-int-comparison-operator int-gt "__gt__" >)

(define-int-comparison-operator int-gte "__ge__" >=)

;; in-place operators

(define-int-into-int-binary-operator int-iadd "__iadd__" +)

(define-int-into-int-binary-operator int-isub "__isub__" -)

(define-int-into-int-binary-operator int-imul "__imul__" *)

(define-int-into-int-binary-operator int-iand "__iand__" bitwise-and)

(define-int-into-int-binary-operator int-ilshift "__ilshift__" arithmetic-shift)

(define-int-into-int-binary-operator int-irshift "__irshift__"
  (lambda (x y) (arithmetic-shift x (- y))))

(define-int-into-int-binary-operator int-ior "__ior__" bitwise-ior)

(define-int-into-int-binary-operator int-ipow "__ipow__" expt)

(define-int-into-int-binary-operator int-ixor "__ixor__" bitwise-xor)

(define-int-into-int-binary-operator int-imod "__imod__" modulo)

(define-int-into-int-division-operator int-ifloordiv "__ifloordiv__" floor-quotient)

(define-int-into-float-division-operator int-itruediv "__itruediv__" /)

;; unary operators

(define-int-unary-operator int-invert "__invert__" bitwise-not)

(define-int-unary-operator int-neg "__neg__" -)

(define-int-unary-operator int-pos "__pos__" +)

(define-int-unary-operator int-abs "__abs__" abs)

(define-int-unary-operator int-hash "__hash__"
   (let ()
      truncate-hash))

(define (int-repr self)
  (if (py-instance-of-int? self)
      (py-str-from-scheme (number->string (py-instance-of-int-to-scheme self)))
      (py-throw-required-type "__repr__" "int" self)))

(define int.__repr__
  (procedure->py-function
    int-repr
    (make-signature posonlyargs: (self))))

(define (int-index self)
  (cond
   ((py-has-type-int? self)
    self)
   ((py-instance-of-int? self)
    ;;TODO: this code seems incorrect!
    (py-str-from-scheme (number->string (py-instance-of-int-to-scheme self))))
   (else
    (py-throw-required-type "__repr__" "int" self))))

(define int.__index__
  (procedure->py-function
    int-index
    (make-signature posonlyargs: (self))))

;; =============================================================================
;; float operations
;; =============================================================================

(define (float-new cls #!optional (value py-absent))
  (cond

   ((eq? cls py-float-class)
    (cond
     ((eq? value py-absent)
      (py-float-from-scheme 0.0))
     ((py-has-type-float? value)
      ;; float(x) return the same object when x is a float
      value)
     ((py-instance-of-float? value)
      ;; up-typing an instance of subclass to an float
      (py-float-from-scheme (py-instance-of-float-to-scheme value)))
     (else
      (py-throw-exception-with-message
       py-builtin-NotImplementedError
       "float.__new__ unimplemented for non float"))))

   ((py-issubclass? cls py-float-class)
    (cond
     ((eq? value py-absent)
      (py-float-subtype-from-scheme 0.0 cls))
     ((py-instance-of-float? value)
      (py-float-subtype-from-scheme (py-instance-of-float-to-scheme value) cls))
     (else
      (py-throw-exception-with-message
       py-builtin-NotImplementedError
       "float.__new__ only supports subtypes of float"))))

   (else
    (py-throw-wrong-new-argument "float" cls))))

(define float.__new__
  (procedure->py-function
    float-new
    (make-signature posonlyargs: (cls value) defaults: (vector py-absent))))


;; scheme-to-py-op defines an operator that RETURNS A PYTHON TYPE

(define-macro (define-float-binary-operator fun-name method-name float-float-op)
  (let ((py-func-name (string->symbol (string-append "float." method-name))))
    `(begin
       (define (,fun-name self other)
         (if (py-instance-of-float? self)
             (cond
              ((py-instance-of-float? other)
               (,float-float-op (py-instance-of-float-to-scheme self)
                                (py-instance-of-float-to-scheme other)))
              ((py-instance-of-int? other)
               ;; If the operation is float-int, it converts the int to a float
               (,float-float-op (py-instance-of-float-to-scheme self)
                                (inexact (py-instance-of-int-to-scheme other))))
              (else py-NotImplemented))
             (py-throw-required-type ,method-name "float" self)))
       (define ,py-func-name
         (procedure->py-function
          ,fun-name
          (make-signature posonlyargs: (self other)))))))

(define-macro (define-float-binary-operator-reverse fun-name method-name float-float-op)
  (let ((py-func-name (string->symbol (string-append "float." method-name))))
    `(begin
       (define (,fun-name self other)
         (if (py-instance-of-float? self)
             (cond
              ((py-instance-of-float? other)
               (,float-float-op (py-instance-of-float-to-scheme other)
                                (py-instance-of-float-to-scheme self)))
              ((py-instance-of-int? other)
               ;; If the operation is float-int, it converts the int to a float
               (,float-float-op (inexact (py-instance-of-int-to-scheme other))
                                (py-instance-of-float-to-scheme self)))
              (else py-NotImplemented))
             (py-throw-required-type ,method-name "float" self)))
       (define ,py-func-name
         (procedure->py-function
          ,fun-name
          (make-signature posonlyargs: (self other)))))))
;; Helpers

(define (reverse-args fun)
  (lambda (x y) (fun y x)))

(define (result-to-float op)
   ;; !!! overriden by a macro
  (lambda (x y) (py-float-from-scheme (op x y))))

(define (comparison-conversion scheme-comp-op)
  (lambda (x y)
    (if (scheme-comp-op x y) py-True py-False)))

;; int-or-float is the function of the conversion to sheme number to py numbers
(define (div-to-float op)
  (lambda (x y)
    (if (= y 0)
      (py-throw
        (py-call py-builtin-ZeroDivisionError
          (&& "float division by zero")))
      (py-float-from-scheme (inexact (op x y))))))

(define (mod-to-float op)
  (lambda (x y)
    (if (= y 0)
      (py-throw
        (py-call py-builtin-ZeroDivisionError
          (&& "float modulo")))
      (py-float-from-scheme (inexact (op x y))))))

(define (floor-div x y)
  (floor (/ (exact x) (exact y))))


(define (flmod fl1 fl2)
  (let ((div (fl/ fl1 fl2)))
    (fl- fl1 (fl* fl2
                (if (fl< 0. fl2)
                  (flfloor div)
                  (flceiling div))))))

(define (fl!= x y)
  (not (fl= x y)))

(define-float-binary-operator float-add "__add__"            (result-to-float fl+))
(define-float-binary-operator float-radd "__radd__"          (result-to-float fl+))
(define-float-binary-operator float-sub "__sub__"            (result-to-float fl-))
(define-float-binary-operator-reverse float-rsub "__rsub__"  (result-to-float fl-))

(define-float-binary-operator float-truediv "__truediv__"    (div-to-float fl/))
(define-float-binary-operator-reverse float-rtruediv "__rtruediv__"  (div-to-float fl/))
(define-float-binary-operator float-floordiv "__floordiv__"   (div-to-float floor-div)               )
(define-float-binary-operator-reverse float-rfloordiv "__rfloordiv__" (div-to-float floor-div))

(define-float-binary-operator float-mod "__mod__"            (mod-to-float flmod))
(define-float-binary-operator-reverse float-rmod "__rmod__"  (mod-to-float flmod))

(define-float-binary-operator float-mul "__mul__"            (result-to-float fl*))
(define-float-binary-operator float-rmul "__rmul__"          (result-to-float fl*))
(define-float-binary-operator float-pow "__pow__"            (result-to-float flexpt))
(define-float-binary-operator-reverse float-rpow "__rpow__"  (result-to-float flexpt))

(define-float-binary-operator float-eq "__eq__" (comparison-conversion fl=))
(define-float-binary-operator float-ne "__ne__" (comparison-conversion fl!=))
(define-float-binary-operator float-gt "__gt__" (comparison-conversion fl>))
(define-float-binary-operator float-ge "__ge__" (comparison-conversion fl>=))
(define-float-binary-operator float-lt "__lt__" (comparison-conversion fl<))
(define-float-binary-operator float-le "__le__" (comparison-conversion fl<=))

(define-macro (define-float-unary-operator fun-name method-name scheme-op)
  (let ((py-func-name (string->symbol (string-append "float." method-name))))
    `(begin
      (define (,fun-name self)
        (if (py-instance-of-float? self)
          (,scheme-op (py-instance-of-float-to-scheme self))
          (py-throw-required-type ,method-name "float" self)))
      (define ,py-func-name
        (procedure->py-function
          ,fun-name
          (make-signature posonlyargs: (self)))))))

(define (unary-to-float op)
  (lambda (x) (py-float-from-scheme (op x))))

(define (unary-to-bool x)
  (if (fl= x 0.0)
    py-False
    py-True))

(define-float-unary-operator float-abs "__abs__" (unary-to-float abs))
(define-float-unary-operator float-neg "__neg__" (unary-to-float fl-))
(define-float-unary-operator float-bool "__bool__" unary-to-bool)

(define-float-unary-operator float-int "__int__" (lambda (x) (py-int-from-scheme (exact (fltruncate x)))))
(define-float-unary-operator float-trunk "__trunc__" (lambda (x) (py-float-from-scheme (fltruncate x))))
(define-float-unary-operator float-round "__round__" (lambda (x) (py-float-from-scheme (flround x))))
(define-float-unary-operator float-is_integer "is_integer" (lambda (x) (if (integer? x) py-True py-False)))

;; identity functions
(define-float-unary-operator float-float "__float__" (unary-to-float (lambda (x) x)))
(define-float-unary-operator float-pos "__pos__" (unary-to-float (lambda (x) x)))
(define-float-unary-operator float-conjugate "conjugate" (unary-to-float (lambda (x) x)))

;; =============================================================================
;; bool operations
;; =============================================================================

;; the bool class is a wrapper aroung int 0 and 1 to print them as False and True

(define (bool-new cls #!optional (value py-absent))
  (if (py-issubclass? cls py-bool-class)
    (if (and (not (eq? value py-absent)) (py-test value)) py-True py-False)
    ;; TODO: incorrect error message
    (py-throw
      (py-call py-builtin-TypeError
         (&& "object.__new__(X): X is not a type object")))))

(define bool.__new__
  (procedure->py-function
    bool-new
    (make-signature posonlyargs: (cls value) defaults: (vector py-absent))))

(define (bool-str self)
  (cond
    ((eq? self py-True) (&& "True"))
    ((eq? self py-False) (&& "False"))
    (else
      (py-throw-required-type "__str__" "bool" self))))

(define bool.__str__
  (procedure->py-function
    bool-str
    (make-signature posonlyargs: (self))))

(define (bool-repr self)
  (cond
    ((eq? self py-True) (&& "True"))
    ((eq? self py-False) (&& "False"))
    (else
      (py-throw-required-type "__repr__" "bool" self))))

(define bool.__repr__
  (procedure->py-function
    bool-repr
    (make-signature posonlyargs: (self))))


;;;----------------------------------------------------------------------------

(define (py-maybe-len obj)
  (let ((__len__ (getattribute-from-obj-mro obj (& "__len__"))))
    (if (eq? __len__ py-absent)
        py-absent
        (let ((len (py-call __len__ obj)))
          (cond ((py-has-type-int? len)
                 len)
                ((py-instance-of-int? len)
                 (py-int-from-scheme (py-instance-of-int-to-scheme len)))
                (else
                 (py-throw-not-an-integer len)))))))

(define (py-len obj)
  (let ((len (py-maybe-len obj)))
    (if (eq? len py-absent)
        (py-throw-has-no-len obj)
        len)))

;;;----------------------------------------------------------------------------

;;; Object attribute store/fetch.

(define (py-own-attr-set! obj attr val)
  (declare-fixnum)
  (let* ((attr-representative (str-representative-get attr))
	 (i (py-own-attr-index obj attr-representative)))
     (if (< i 0)
	 (let* ((hclass (PyObject-hclass obj))
		(new-hclass (HClass-next hclass attr-representative '+))
		(index (HClass-last-index new-hclass)))
	    (PyObject-hclass-set! obj new-hclass)
	    (PyObject-elements-set! obj index val))
	 (PyObject-elements-set! obj i val))))

(define (py-own-attr-ref obj attr #!optional (default py-absent))
  (declare-fixnum)
  (let ((i (py-own-attr-index obj attr)))
     (if (< i 0)
	 default
	 (PyObject-elements-ref obj i)))) ;; TODO: could vector-ref be used?

(define (py-own-attr-index obj attr)
  (declare-fixnum)
  (let* ((hclass (PyObject-hclass obj))
	 (names (HClass-names hclass))
	 (attr-representative (str-representative-get attr)))
     (let loop ((i (- (vector-length names) 1)))
	(cond ((< i 0)
	       -1)
	      ((eq? attr-representative (vector-ref names i))
	       i)
	      (else
	       (loop (- i 1)))))))

;; ===================
;; DESCRIPTOR PROTOCOL
;; ===================

;; Binds a recovered attribute by calling attr.__class__.__get__ if it exists
;; if the __get__ method does not exist on the attr's class, return the attr
(define (object-get-bind-descriptor attr instance #!optional (owner py-None))
  (let ((__get__ (getattribute-from-obj-mro attr (& "__get__"))))
    (if (not (eq? __get__ py-absent))
      (py-call __get__ attr instance owner)
      attr)))

;; ================
;; GETATTR PROTOCOL
;; ================

;; Recover an attribute from the given class
;;   Does so by looking through the classes of the MRO
;;   returns the first occurence of the attribute
;;   found on an element of the MRO
(define (getattribute-from-cls-mro cls name)
   (declare-fixnum)
   (declare-not-interrupts-enabled)
   (let ((mro (PyObjectType-mro cls)))
      (let loop-mro ((i 0))
	 (if (< i (vector-length mro))
	     (let ((cls (vector-ref mro i)))
		;; inlining of py-own-attr-ref to avoid py-absent handling
		(let ((j (py-own-attr-index cls name)))
		   (if (< j 0)
		       (loop-mro (+ i 1))
		       (PyObject-elements-ref cls j)))
		#;
		(let ((attr (py-own-attr-ref cls name)))
		   (if (not (eq? attr py-absent))
		       attr
		       (loop-mro (+ i 1)))))
	     py-absent))))

;; Does the same a getattribute-from-cls-mro but also returns the class
;; which owned the attribute. This may be necessary for super
(define (getattribute-from-cls-mro-with-owner cls name)
   (declare-fixnum)
   (let ((mro (PyObjectType-mro cls)))
      (let loop-mro ((i 0))
	 (if (< i (vector-length mro))
	     (let ((cls (vector-ref mro i)))
		(let ((attr (py-own-attr-ref cls name)))
		   (if (not (eq? attr py-absent))
		       (values attr cls)
		       (loop-mro (+ i 1)))))
	     (values py-absent py-absent)))))

(cond-expand
  (gambit
   ;; getattribute-from-obj-mro is defined as a macro
   )
  (bigloo
   (define-macro (warn1)
     (print "===bigloo=== getattribute-from-obj-mro should be defined as a macro")
     '(begin))
   (warn1)
   ;; Recover an attribute from the class of 'obj'
   (define (getattribute-from-obj-mro obj name)
     (declare-not-interrupts-enabled)
     (getattribute-from-obj-mro-dynamic obj name))))

;; Recover an attribute from the class of 'obj'
(define (getattribute-from-obj-mro-dynamic obj name)
  (declare-not-interrupts-enabled)
  (getattribute-from-cls-mro (py-obj-cls obj) name))

;; Does the same a getattribute-from-obj-mro but also returns the class
;; which owned the attribute. This may be necessary for the getattr protocol
(define (getattribute-from-obj-mro-with-owner obj name)
  (getattribute-from-cls-mro-with-owner (py-obj-cls obj) name))

;; Implements object.__getattribute__
;;   Entry point of the getattr protocol
;;   Look into the object's own attributes
;;   Defer to py-getattribute-from-obj-mro if not found
(define (object-getattribute obj name)
  (let ((attr (py-own-attr-ref obj name)))
    (if (not (eq? attr py-absent))
        attr
        (receive (cls-attr owner) (getattribute-from-obj-mro-with-owner obj name)
          (if (not (eq? cls-attr py-absent))
              (object-get-bind-descriptor cls-attr obj owner)
              (py-throw py-builtin-AttributeError))))))

;; The Python object object.__getattribute__
(define py-object-getattribute
  (procedure->py-function
    object-getattribute
    (make-signature posonlyargs: (obj name))))

;; Implements type.__getattribute__
(define (type-getattribute obj name)
  (if (py-isinstance? obj py-type-class)
    (let ((attr (getattribute-from-cls-mro obj name)))
      (if (not (eq? attr py-absent))
        (object-get-bind-descriptor attr py-None obj)
        (receive (cls-attr owner) (getattribute-from-obj-mro-with-owner obj name)
          (if (not (eq? cls-attr py-absent))
            (object-get-bind-descriptor cls-attr obj owner)
            (py-throw py-builtin-AttributeError)))))
    (py-throw-required-type "__getattribute__" "type" obj)))

;; The Python object type.__getattribute__
(define type.__getattribute__
  (procedure->py-function
    type-getattribute
    (make-signature posonlyargs: (obj name))))

(define (object-put! obj attr val cache)
  (py-own-attr-set! obj attr val))

(define (object-has obj attr)
   (>= (py-own-attr-index obj attr) 0))

;; ================
;; BOOL PROTOCOL
;; ================

(define (int-bool self)
  (if (py-instance-of-int? self)
      (let ((value (py-instance-of-int-to-scheme self)))
        (if (= value 0)
            py-False
            py-True))
      (py-throw-required-type "__bool__" "int" self)))

;; The Python object int.__bool__
(define int.__bool__
  (procedure->py-function
    int-bool
    (make-signature posonlyargs: (self))))


;; Returns the truthiness of an object by calling obj.__bool__
;; py-test is expected to return #t or #f, not a Python objects
;; True and False are converted to #t and #f
(define (py-test obj)
  (cond ((eq? obj py-True) ;; base case
         #t)
        ((eq? obj py-False) ;; base case
         #f)
        ((py-has-type-int? obj) ;; optimization (test common case first)
         (not (eq? obj py-int-0)))
        (else
         (let ((__bool__ (getattribute-from-obj-mro obj (& "__bool__"))))
           (if (not (eq? __bool__ py-absent))
               (let ((test-value (py-call __bool__ obj)))
                 (py-test test-value))
               (let ((len (py-maybe-len obj)))
                 (if (eq? len py-absent)
                     #t
                     (py-test len))))))))

(define (py-not obj cache)
  (if (py-test obj)
    py-False
    py-True))

;; =============
;; CALL PROTOCOL
;; =============

;; slow way to call method through method.__call__
;; interfaces between manual __call__ and py-call
(define (method-call self args)
  (if (eq? (py-type self) py-method-class)
    (let ((args-list (vector->list (PyObjectTuple-value args))))
      (py-call-generic self args-list))
    (py-throw-required-type "__call__" "method" self)))

(define method.__call__
  (procedure->py-function
    method-call
    (make-signature
      posonlyargs: (self)
      vararg: args)))

;; slow way to call function through function.__call__
;; interfaces between manual __call__ and py-call
(define (function-call self args)
  (if (eq? (py-type self) py-function-class)
    (let ((args-list (vector->list (PyObjectTuple-value args))))
      (py-call-generic self args-list))
    (py-throw-required-type "__call__" "method" self)))

(define function.__call__
  (procedure->py-function
    function-call
    (make-signature
      posonlyargs: (self)
      vararg: args)))

(define (function-get self instance owner)
  (if (eq? instance py-None)
    self
    (let ((method (make-PyObjectMethod
                    py-method-hclass-of-instances
                    (make-vector
                      (vector-length (HClass-names py-method-hclass-of-instances))
                      py-absent)
                    py-method-class
                    (PyObjectFunction-procedure self)
                    py-absent
                    (PyObjectFunction-signature self))))
      (method-__self__-fast-set! method instance)
      method)))

(define function.__get__
  (procedure->py-function
    function-get
    (make-signature posonlyargs: (self instance owner))))

;; TODO: remove the tuple->list conversion once we support argument unpacking
(define (type-call self args)
  (let ((__new__ (getattribute-from-cls-mro self (& "__new__")))
        (args-list (vector->list (PyObjectTuple-value args))))
    (let ((instance (py-call-generic __new__ (cons self args-list))))
      (if (eq? (py-obj-cls instance) self)
        (let ((__init__ (getattribute-from-cls-mro self (& "__init__"))))
            (py-call-generic __init__ (cons instance args-list))
            instance)
        instance))))

(define type.__call__
  (procedure->py-function
    type-call
    (make-signature
      posonlyargs: (self)
      vararg: args)))


;; TODO: remove the tuple->list conversion once we support argument unpacking
(define (type-new metacls cls args)
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

(define type.__new__
  (procedure->py-function
    type-new
    (make-signature
      posonlyargs: (metacls cls)
      vararg: args)))

(define (tuple-new cls iterable)
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
              (let* ((value (PyObjectList-value iterable))
                     (vec (subvector (cdr value) 0 (car value))))
               (py-tuple-subtype-from-scheme (vector-copy vec) cls)))
             (else
               (let* ((iterator (py-iter iterable))
                      (content (list->vector (iterator->list iterator))))
                 (py-tuple-subtype-from-scheme (vector-copy content) cls))))))
      (py-throw-wrong-new-argument "tuple" cls)))

(define tuple.__new__
  (procedure->py-function
    tuple-new
    (make-signature posonlyargs: (cls iterable) defaults: (vector py-absent))))

;; TODO: raise TypeError on unsafe call, ex: object.__new__(int)
;; TODO: raise TypeError when cannot create, ex: list_iterator.__new__()
;; TODO: remove the tuple->list conversion once we support argument unpacking
;; TODO: that's really a lot of todos...
(define (object-new cls args)
  (if (py-isinstance? cls py-type-class)
    (py-obj-alloc cls (PyObjectType-hclass-of-instances cls))
    (py-throw
      (py-call py-builtin-TypeError
        (&& "object.__new__(X): X is not a type object")))))

(define object.__new__
  (procedure->py-function
    object-new
    (make-signature
      posonlyargs: (cls)
      vararg: args)))

;; object.__init__ exists but does nothing
;; its purpose is that super().__init__ does not raise and AttributeError
(define object.__init__
  (procedure->py-function
    (lambda (self args) py-None)
    (make-signature
      posonlyargs: (self)
      vararg: args)))


;; =============================================================================
;;  str and repr protocols
;; =============================================================================

(define str-representatives (get-registered-constants-table))

(define (str-value-collect-components-aux! value components)
  (if (pair? value)
    (let ((left (car value))
          (right (cdr value)))
      (str-value-collect-components-aux!
        (PyObjectStr-value right)
        (str-value-collect-components-aux!
          (PyObjectStr-value left)
          components)))
    (cons value components)))

(define (str-value-collect-components value)
  (reverse (str-value-collect-components-aux! value '())))

(define (str-force! str)
  (let ((value (PyObjectStr-value str)))
    (cond
      ((string? value)
        value)
      ((pair? value)
        (let* ((str-components (str-value-collect-components value))
              (new-string (append-strings str-components)))
          (PyObjectStr-value-set! str new-string)
          new-string))
      (else
        (error "str-force!" "received object with value" value)))))

(define (str-representative-get str)
  (or (PyObjectStr-representative str)
      (str-representative-create str)))

(define (str-representative-create str)
  (let* ((str-value (str-force! str))
         (rep (table-ref str-representatives str-value #f)))
    (if rep
        (begin
          (PyObjectStr-representative-set! str rep)
          rep)
        (let ((new-rep (make-still-copy str)))
          (table-set! str-representatives str-value new-rep)
          (PyObjectStr-representative-set! str new-rep)
          (PyObjectStr-representative-set! new-rep new-rep)
          new-rep))))

(define (str-new cls value)
  (cond
    ((eq? cls py-str-class)
     (if (eq? value py-absent)
         (&& "")
         (let* ((__str__ (getattribute-from-obj-mro value (& "__str__")))
                (result (py-call __str__ value)))
           (if (py-isinstance? result py-str-class)
               result
               (throw-returned-wrong-type "__str__" value "non-string")))))
    ((py-issubclass? cls py-str-class)
     (if (eq? value py-absent)
         (py-str-subtype-from-scheme
           ""
           cls)
         (let* ((__str__ (getattribute-from-obj-mro value (& "__str__")))
                (result (py-call __str__ value)))
           (if (py-isinstance? result py-str-class)
               (py-str-subtype-from-scheme
                 (PyObjectStr-value result)
                 cls)
               (throw-returned-wrong-type "__str__" value "non-string")))))
    (else
      (py-throw-wrong-new-argument "str" cls))))

(define str.__new__
  (procedure->py-function
    str-new
    (make-signature posonlyargs: (cls value) defaults: (vector py-absent))))

(define (str-str self)
  (if (py-isinstance? self py-str-class)
    self
    (py-throw-required-type "__str__" "str" self)))

(define str.__str__
  (procedure->py-function
    str-str
    (make-signature posonlyargs: (self))))

(define (str-repr self)
    (if (py-isinstance? self py-str-class)
      (let* ((string (py-str-to-scheme self))
             (string-repr (py-str-repr-scheme string)))
        (py-str-from-scheme string-repr))
      (py-throw-required-type "__str__" "str" self)))

(define str.__repr__
  (procedure->py-function
    str-repr
    (make-signature posonlyargs: (self))))

(define (string-join-vector separator vec)
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

(define (str-len self)
  (if (py-isinstance? self py-str-class)
    (let* ((string (py-str-to-scheme self))
           (string-len (string-length string)))
      (py-int-from-scheme string-len))
    (py-throw-required-type "__str__" "str" self)))

(define str.__len__
  (procedure->py-function
    str-len
    (make-signature posonlyargs: (self))))

(define (integer->hex-string x)
  (string-append "0x" (number->string x 16)))

(define-macro (define-eq-ne-str fun-name method-name yes no)
  (let ((py-func-name (string->symbol (string-append "str." method-name))))
    `(begin
      (define (,fun-name self other)
        (if (py-isinstance? self py-str-class)
            (if (eq? self other)
                ,yes
                (if (py-isinstance? other py-str-class)
                    (let* ((self-representative (str-representative-get self))
                           (other-representative (str-representative-get other)))
                      (if (eq? self-representative other-representative)
                          ,yes
                          ,no))
                    py-NotImplemented))
            (py-throw-required-type ,method-name "str" self)))
      (define ,py-func-name
        (procedure->py-function
          ,fun-name
          (make-signature posonlyargs: (self other)))))))

(define-eq-ne-str str-eq "__eq__" py-True py-False)
(define-eq-ne-str str-ne "__ne__" py-False py-True)

(define-macro (define-str-comparison-operator fun-name method-name scheme-op)
  (let ((py-func-name (string->symbol (string-append "str." method-name))))
    `(begin
      (define (,fun-name self other)
        (if (py-isinstance? self py-str-class)
          (cond
            ((py-isinstance? other py-str-class)
              (let ((self-value (str-force! self))
                    (other-value (str-force! other)))
                (if (,scheme-op self-value other-value) py-True py-False)))
            (else py-NotImplemented))
          (py-throw-required-type ,method-name "str" self)))
      (define ,py-func-name
        (procedure->py-function
          ,fun-name
          (make-signature posonlyargs: (self other)))))))

(define-str-comparison-operator str-gt "__gt__" string>?)
(define-str-comparison-operator str-lt "__lt__" string<?)
(define-str-comparison-operator str-ge "__ge__" string>=?)
(define-str-comparison-operator str-le "__le__" string<=?)

(define (str-hash-value str)
  (let ((cached-hash (PyObjectStr-hash str)))
    (if cached-hash
      cached-hash
      (let ((hash (hash-FNV1a (PyObjectStr-value str))))
        ;; if hash is a bignum (on 32-bit architecture), it must be a still-copy
        ;; otherwise str representative may end with a wild pointer as hash
        (if (fixnum? hash)
          (PyObjectStr-hash-set! str hash)
          (PyObjectStr-hash-set! str (make-still-copy hash)))
        hash))))

(define (str-hash self)
  (if (PyObjectStr? self)
    (py-int-from-scheme (str-hash-value self))
    (py-throw-required-type "__hash__" "str" self)))

(define str.__hash__
  (procedure->py-function
    str-hash
    (make-signature posonlyargs: (self))))

(define (str-add self other)
   (if (py-isinstance? self py-str-class)
       (if (py-isinstance? other py-str-class)
           ;; !!! MS 6 Nov 2020: this is erroneously typed
           (py-str-from-scheme (cons self other))
           py-NotImplemented)
       (py-throw-required-type "__add__" "str" self)))

(define str.__add__
  (procedure->py-function
    str-add
    (make-signature posonlyargs: (self other))))

(define (add-hclass-names-to-table table obj)
  (vector-for-each
    (lambda (name)
      (table-set! table name #t))
    (HClass-names (PyObject-hclass obj))))

(define (object-dir self)
  (let ((table (make-table test: eq?)))
   (add-hclass-names-to-table table self)
   (vector-for-each (lambda (x) (add-hclass-names-to-table table x))
                    (PyObjectType-mro (py-obj-cls self)))
   (py-list-from-scheme
     (list->dynamic-vector
       (map car (table->list table))))))

(define object.__dir__
  (procedure->py-function
    object-dir
    (make-signature posonlyargs: (self))))

(define (type-dir self)
  (if (py-isinstance? self py-type-class)
      (let ((table (make-table test: eq?)))
       (vector-for-each (lambda (x) (add-hclass-names-to-table table x))
                        (PyObjectType-mro self))
       (py-list-from-scheme
         (list->dynamic-vector
           (map car (table->list table)))))
      (py-throw-required-type "__dir__" "type" self)))

(define type.__dir__
  (procedure->py-function
    type-dir
    (make-signature posonlyargs: (self))))

(define (object-repr self)
  (let* ((self-type (py-type self))
         (self-type-name (py-str-to-scheme (py-own-attr-ref self-type (& "__name__"))))
         (addr (integer->hex-string (object->serial-number self)))
         (result (string-append "<" self-type-name " object #" addr ">")))
    (py-str-from-scheme result)))

(define object.__repr__
  (procedure->py-function
    object-repr
    (make-signature posonlyargs: (self))))

(define (object-str self)
  (py-repr self))

(define object.__str__
  (procedure->py-function
    object-str
    (make-signature posonlyargs: (self))))

(define (float->string-with-padded-zeros value)
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

(define (float-repr self)
  (if (py-instance-of-float? self)
      (py-str-from-scheme
       (let ((value (py-instance-of-float-to-scheme self)))
         (float->string-with-padded-zeros value)))
      (py-throw-required-type "__repr__" "float" self)))

(define float.__repr__
  (procedure->py-function
   float-repr
   (make-signature posonlyargs: (self))))

(define (py-display obj port)
  ;; check some common cases first for efficiency
  (let ((t (py-type obj)))
    (cond ((eq? t py-str-class)
           (display (py-str-to-scheme obj)
                    port))
          ((eq? t py-int-class)
           (display (py-instance-of-int-to-scheme obj)
                    port))
          ((eq? t py-float-class)
           (display (float->string-with-padded-zeros
                     (py-instance-of-float-to-scheme obj))
                    port))
          ((eq? t py-bool-class)
           (if (eq? obj py-True)
               (display "True" port)
               (display "False" port)))
          (else
           (display (py-str-to-scheme (py-str obj)) port)))))

(define (py-str obj)
  (let* ((__str__ (getattribute-from-obj-mro obj (& "__str__")))
        (str-instance (py-call __str__ obj)))
    (if (py-isinstance? str-instance py-str-class)
      str-instance
      (throw-returned-wrong-type "__str__" obj "non-string"))))

(define (py-repr obj)
  (let* ((__repr__ (getattribute-from-obj-mro obj (& "__repr__")))
        (repr (py-call __repr__ obj)))
    (if (py-isinstance? repr py-str-class)
      repr
      (throw-returned-wrong-type "__repr__" obj "non-string"))))

(define (py-str-repr-scheme str)
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
           (apply string-append
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

(define repr-cache (make-PCache -1 -1))

(define (py-chr i)
  (if (py-instance-of-int? i)
      (let ((value (py-instance-of-int-to-scheme i)))
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
;;  BUILTIN CLASSES
;; =============================================================================

(define py-object-class #f)
(define py-type-class   #f)
(define py-str-class    #f)
(define py-tuple-class  #f)
(define py-int-class    #f)
(define py-bytearray-class #f)
(define py-float-class  #f)
(define py-bool-class   #f)
(define py-complex-class #f)
(define py-slice-class  #f)
(define py-method-class #f)
(define py-function-class #f)
(define py-list-class   #f)
(define py-dict-class   #f)
(define py-set-class    #f)
(define py-module-class #f)

(cond-expand
  (gambit
   ;; py-obj-cls is a macro defined in rts#.scm
   )
  (bigloo
   (define-macro (warn2)
     (print "===bigloo=== py-obj-cls should be defined as a macro")
     '(begin))
   (warn2)
   (define (py-obj-cls obj)
     (py-if-specialized-int-representation
      (if (exact-integer? obj)
          py-int-class
          (py-if-specialized-float-representation
           (if (flonum? obj)
               py-float-class
               (PyObject-class obj))
           (PyObject-class obj)))
      (PyObject-class obj)))))

(define (py-obj-mro obj) ;; return MRO of object
  (PyObjectType-mro (py-obj-cls obj)))

;;;----------------------------------------------------------------------------

;;; Converters between Scheme objects and Python objects for basic
;;; types.
;; TODO: remove direct indexing and use fast-set! methods in this section

;; TODO: only include these functions when specialized int representation
;; not used.

(define (alloc-new-int-from-scheme value)
  (make-PyObjectInt
    py-int-hclass-of-instances
    '#() ;; we know length is 0
;;    (make-vector
;;      (vector-length (HClass-names py-int-hclass-of-instances))
;;      py-absent)
    py-int-class
    value))

(define int-cache-low -5)
(define int-cache-high 256)

(define (make-int-cache)
  (let* ((cache (make-vector (- int-cache-high int-cache-low -1))))
    (let loop ((int int-cache-low))
      (if (<= int int-cache-high)
        (begin
          (vector-set! cache (- int int-cache-low) (alloc-new-int-from-scheme int))
          (loop (+ int 1)))
        cache))))

;; Set on bootstrap when int class is defined
(define int-cache #f)

(define (py-int-from-scheme-dynamic value)
  (py-if-specialized-int-representation
   value
   (if (and (<= value int-cache-high)
            (>= value int-cache-low))
       (vector-ref int-cache (- value int-cache-low))
       (alloc-new-int-from-scheme value))))

(define (py-int-subtype-from-scheme value int-subclass)
  ;; int-subclass is known to not be int-class
  (make-PyObjectInt
    py-int-hclass-of-instances
    (make-vector
      (vector-length (HClass-names py-int-hclass-of-instances))
      py-absent)
    int-subclass
    value))

(define (py-float-from-scheme-dynamic value)
  (py-if-specialized-float-representation
   value
   (make-PyObjectFloat
    py-float-hclass-of-instances
    (make-vector
     (vector-length (HClass-names py-float-hclass-of-instances))
     py-absent)
    py-float-class
    value)))

(define (py-float-subtype-from-scheme value float-subclass)
  ;; float-subclass is known to not be float-class
  (make-PyObjectFloat
    py-float-hclass-of-instances
    (make-vector
      (vector-length (HClass-names py-float-hclass-of-instances))
      py-absent)
    float-subclass
    value))

(define (py-str-from-scheme value)
  (make-PyObjectStr
    py-str-hclass-of-instances
    (make-vector
      (vector-length (HClass-names py-str-hclass-of-instances))
      py-absent)
    py-str-class
    value
    #f ;;representative
    #f))      ;; hash

(define (py-str-subtype-from-scheme value str-subclass)
  (make-PyObjectStr
    py-str-hclass-of-instances
    (make-vector
      (vector-length (HClass-names py-str-hclass-of-instances))
      py-absent)
    str-subclass
    value
    #f ;; representative
    #f))      ;; hash

(define (py-str-to-scheme self)
  (str-force! self))

(define (py-set-from-scheme elems)
  (py-throw-exception-with-message
    py-builtin-NameError
    "py-set-from-scheme not implemented"))

(define (py-bytearray-from-scheme len-vec-pair)
  (make-PyObjectBytearray
    py-bytearray-hclass-of-instances
    (make-vector
      (vector-length (HClass-names py-bytearray-hclass-of-instances))
      py-absent)
    py-bytearray-class
    len-vec-pair))

(define (py-bytearray-subtype-from-scheme len-vec-pair bytearray-subtype)
  (make-PyObjectBytearray
    py-bytearray-hclass-of-instances
    (make-vector
      (vector-length (HClass-names py-bytearray-hclass-of-instances))
      py-absent)
    bytearray-subtype
    len-vec-pair))

;; Bootstraps type and object
;; Create barebone object, type, str and tuple classes
;; These will need to be filled in later
(define (bootstrap-type-hierarchy-phase1)
  (let* ((type-class
          (py-builtin-type-alloc
            #f ;; cls
            #f ;; bases
            #f ;; mro
            py-type-hclass-of-instances))
        (object-class
          (py-builtin-type-alloc
            #f ;; cls
            #f ;; bases
            #f ;; mro
            py-object-hclass-of-instances))
        (str-class
          (py-builtin-type-alloc
            #f ;; cls
            #f ;; bases
            #f ;; mro
            py-str-hclass-of-instances))
        (tuple-class
          (py-builtin-type-alloc
            #f ;; cls
            #f ;; bases
            #f ;; mro
            py-tuple-hclass-of-instances)))

    (set! py-object-class object-class)
    (set! py-type-class type-class)
    (set! py-str-class str-class)
    (set! py-tuple-class tuple-class)

    ;; init all object (& ...) to a py-str object
    (init-registered-constants)

    ;; builtin hidden classes
    (HClass-names-set! py-type-hclass-of-instances
       (vector (& "__name__") (& "__call__")))
    (HClass-names-set! py-method-hclass-of-instances
       (vector (& "__self__")))
    (HClass-names-set! py-module-hclass-of-instances
       (vector (& "__next__") (& "send")))

    ;; Fill in object class
    (PyObject-class-set! object-class type-class)
    (PyObjectType-bases-set! object-class '#())
    (PyObjectType-mro-set! object-class (vector object-class))
    (PyObjectType-hclass-of-instances-set! object-class py-object-hclass-of-instances)
    (py-own-attr-set! object-class (& "__name__") (&& "object"))
    (py-own-attr-set! object-class (& "__module__") (&& "builtins"))
    (py-own-attr-set! object-class (& "__new__") object.__new__)
    (py-own-attr-set! object-class (& "__init__") object.__init__)
    (py-own-attr-set! object-class (& "__getattribute__") py-object-getattribute)
    (py-own-attr-set! object-class (& "__repr__") object.__repr__)
    (py-own-attr-set! object-class (& "__str__") object.__str__)
    (py-own-attr-set! object-class (& "__dir__") object.__dir__)


    ;; Fill in type class
    (PyObject-class-set! type-class type-class)
    (PyObjectType-bases-set! type-class (vector object-class))
    (PyObjectType-mro-set! type-class (vector type-class object-class))
    (PyObjectType-hclass-of-instances-set! type-class py-type-hclass-of-instances)
    (py-own-attr-set! type-class (& "__name__") (&& "type"))
    (py-own-attr-set! type-class (& "__module__") (&& "builtins"))
    (py-own-attr-set! type-class (& "__new__") type.__new__)
    (py-own-attr-set! type-class (& "__call__") type.__call__)
    (py-own-attr-set! type-class (& "__getattribute__") type.__getattribute__)
    (py-own-attr-set! type-class (& "__dir__") type.__dir__)

    ;; Fill in tuple class
    (PyObject-class-set! tuple-class type-class)
    (PyObjectType-bases-set! tuple-class (vector object-class))
    (PyObjectType-mro-set! tuple-class (vector tuple-class object-class))
    (PyObjectType-hclass-of-instances-set! tuple-class py-tuple-hclass-of-instances)
    (py-own-attr-set! tuple-class (& "__name__") (&& "tuple"))
    (py-own-attr-set! tuple-class (& "__module__") (&& "builtins"))
    (py-own-attr-set! tuple-class (& "__new__") tuple.__new__)

    ;; Fill in str class
    (PyObject-class-set! str-class type-class)
    (PyObjectType-bases-set! str-class (vector object-class))
    (PyObjectType-mro-set! str-class (vector str-class object-class))
    (PyObjectType-hclass-of-instances-set! str-class py-str-hclass-of-instances)
    (py-own-attr-set! str-class (& "__name__") (&& "str"))
    (py-own-attr-set! str-class (& "__module__") (&& "builtins"))
    (py-own-attr-set! str-class (& "__new__") str.__new__)
    (py-own-attr-set! str-class (& "__eq__") str.__eq__)
    (py-own-attr-set! str-class (& "__hash__") str.__hash__)
    (py-own-attr-set! str-class (& "__str__") str.__str__)
    (py-own-attr-set! str-class (& "__repr__") str.__repr__)
    (py-own-attr-set! str-class (& "__len__") str.__len__)
    (py-own-attr-set! str-class (& "__add__") str.__add__)

    (py-own-attr-set! str-class (& "__ne__") str.__ne__)
    (py-own-attr-set! str-class (& "__gt__") str.__gt__)
    (py-own-attr-set! str-class (& "__lt__") str.__lt__)
    (py-own-attr-set! str-class (& "__ge__") str.__ge__)
    (py-own-attr-set! str-class (& "__le__") str.__le__)))

(bootstrap-type-hierarchy-phase1)

(define (py-compute-mro cls)

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

(define (py-make-class-from-type-allocator name module bases type-allocator attrs)
  (define (make-cls attr-names attr-values)
    (let* ((bases-vect
            (if (null? bases)
              (vector py-object-class)
              (list->vector bases)))
           (cls (type-allocator py-type-class bases-vect #f #f)))
      (PyObjectType-mro-set! cls (py-compute-mro cls))
      ;; TODO implement better introspection of hclass of instance
      ;; This current implementation will fail on multiple inheritance
      (PyObjectType-hclass-of-instances-set!
        cls
        (PyObjectType-hclass-of-instances
          (vector-ref bases-vect 0)))
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
    (make-cls (reverse rev-attr-names)
            (reverse rev-attr-values)))))

(define (py-make-class name module bases . attrs)
  (py-make-class-from-type-allocator name module bases py-type-alloc attrs))

(define (py-make-builtin-class name module bases hclass-of-instances . attrs)
  (let ((cls
          (py-make-class-from-type-allocator
            name module bases py-builtin-type-alloc attrs)))
    (PyObjectType-hclass-of-instances-set! cls hclass-of-instances)
    cls))
;; ================
;; MODULE FUNCTIONS
;; ================


(define (module-dir self)
  (if (py-isinstance? self py-module-class)
      (py-list-from-scheme
        (list->dynamic-vector (vector->list (HClass-names (PyObject-hclass self)))))
      (throw-returned-wrong-type "__dir__" self "not a module")))

(define module.__dir__
  (procedure->py-function
    module-dir
    (make-signature posonlyargs: (self))))


;; =============================================================================
;;  ITER PROTOCOL
;; =============================================================================

;; TODO: implement the sequence protocole where object are iterable if they
;; have a __getitem__ method starting from index 0
(define (py-obj->iterator obj)
  (let ((__iter__ (getattribute-from-obj-mro obj (& "__iter__"))))
    (if (eq? __iter__ py-absent)
      #f
      (py-call __iter__ obj))))

;; Wraps py-obj->iterator to raise a TypeError when the object is not iterable
(define (py-iter obj)
  (or (py-obj->iterator obj)
      (throw-not-iteralble obj)))

(define (iterator-next obj default)
    (let ((__next__ (getattribute-from-obj-mro obj (& "__next__"))))
      (if (eq? __next__ py-absent)
        (py-throw-not-an-iterator obj)
        (if (eq? default py-absent)
          (py-call __next__ obj)
          (with-handler
            (lambda (exc)
              (if (and (PyObject? exc)
                       (py-isinstance? exc py-builtin-StopIteration))
                default
                (raise exc)))
            (py-call __next__ obj))))))

(define (iterator->list it)
  (let loop ((acc '()))
    (let ((nxt (iterator-next it #f)))
      (if nxt
        (loop (cons nxt acc))
        (reverse! acc)))))

(define (iterables*->list lst)
  (let outer-loop ((iterators lst) (outer-acc '()))
    (if (null? iterators)
      (reverse! outer-acc)
      (let ((it (py-iter (car iterators))))
        (let inner-loop ((inner-acc outer-acc))
          (let ((nxt (iterator-next it #f)))
            (if nxt
              (inner-loop (cons nxt inner-acc))
              (outer-loop (cdr iterators) inner-acc))))))))

;; list iterator

(define (list-iterator-iter self)
  (if (eq? (py-type self) py-list-iterator-class)
    self
    (py-throw-exception-with-message py-builtin-TypeError "pending error message (code 6)")))

(define list_iterator.__iter__
  (procedure->py-function
    list-iterator-iter
    (make-signature posonlyargs: (self))))

;; By setting index to #f, the iterator always raises StopIteration
(define (stop-list-iterator iterator)
  (PyObjectListIterator-index-set! iterator #f)
  (py-throw py-builtin-StopIteration))

(define (list-iterator-next self)
  (if (eq? (py-type self) py-list-iterator-class)
    (let ((index (PyObjectListIterator-index self)))
      (if index
        (let* ((lst (PyObjectListIterator-list self))
               (len-vec-pair (PyObjectList-value lst))
               (len (car len-vec-pair))
               (vec (cdr len-vec-pair)))
          (if (< index len)
            (let ((item (vector-ref vec index)))
              (PyObjectListIterator-index-set! self (+ index 1))
              item)
            (stop-list-iterator self)))
          (stop-list-iterator self)))
    (py-throw-exception-with-message py-builtin-TypeError "pending error message (code 7)")))

(define list_iterator.__next__
  (procedure->py-function
    list-iterator-next
    (make-signature posonlyargs: (self))))

(define py-list-iterator-class
  (py-make-builtin-class
    (&& "list_iterator")
    (&& "builtins")
    (list)
    py-list-iterator-hclass-of-instances
      (& "__iter__") list_iterator.__iter__
      (& "__next__") list_iterator.__next__))

(define (tuple-iterator-iter self)
  (if (eq? (py-type self) py-tuple-iterator-class)
    self
    (py-throw-exception-with-message py-builtin-TypeError "pending error message (code 8)")))

(define py-tuple-iterator-iter
  (procedure->py-function
    tuple-iterator-iter
    (make-signature posonlyargs: (self))))

(define (tuple-iterator-next self)
  (if (eq? (py-type self) py-tuple-iterator-class)
    (let* ((index (PyObjectTupleIterator-index self))
           (vec (PyObjectTupleIterator-vec self)))
      (if (< index (vector-length vec))
        (let ((item (vector-ref vec index)))
          (begin
            (PyObjectTupleIterator-index-set! self (+ index 1))
            item))
        (py-throw py-builtin-StopIteration)))
    (py-throw-exception-with-message py-builtin-TypeError "pending error message (code 9)")))

(define py-tuple-iterator-next
  (procedure->py-function
    tuple-iterator-next
    (make-signature posonlyargs: (self))))

(define py-tuple-iterator-class
  (py-make-builtin-class
    (&& "tuple_iterator")
    (&& "builtins")
    (list)
    py-tuple-iterator-hclass-of-instances
      (& "__iter__") py-tuple-iterator-iter
      (& "__next__") py-tuple-iterator-next))

(define (stop-bytearray-iterator iterator)
  (PyObjectBytearrayIterator-index-set! iterator #f)
  (py-throw py-builtin-StopIteration))

(define (bytearray-iterator-iter self)
  (if (eq? (py-type self) py-bytearray-iterator-class)
    self
    (py-throw-exception-with-message py-builtin-TypeError "pending error message (code 10)")))

(define py-bytearray-iterator.__iter__
  (procedure->py-function
    bytearray-iterator-iter
    (make-signature posonlyargs: (self))))

(define (bytearray-iterator-next self)
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


(define py-bytearray-iterator.__next__
  (procedure->py-function
    bytearray-iterator-next
    (make-signature posonlyargs: (self))))

(define py-bytearray-iterator-class
  (py-make-builtin-class
    (&& "bytearray_iterator")
    (&& "builtins")
    (list)
    py-bytearray-iterator-hclass-of-instances
      (& "__iter__") py-bytearray-iterator.__iter__
      (& "__next__") py-bytearray-iterator.__next__))

;; ======================
;; Dynamic vector helper
;; =====================
;; These classes are used for lists and bytearrays
;; list class

(define-macro (make-dynamic-vector len vector)
  `(cons ,len ,vector))

(define (index-in-length-range index len)
  (and (< index len) (>= index (- len))))

(define (py-index-in-subvector item vec start stop)
  (let loop ((i start))
    (cond
      ((>= i stop)
        #f)
      ((py-test (py-eq (vector-ref vec i) item))
        i)
      (else
        (loop (+ i 1))))))

(define list-growth-factor 1.125)
(define list-shrink-threshold 1.5)
(define min-list-inner-length 5)
(define list-empty-cell (cons 'empty-cell '()))

(define (get-dvec-inner-len len)
  (+
    min-list-inner-length
    (inexact->exact (round (* len list-growth-factor)))))

(define (get-shrink-threshold-len inner-len)
  (- (round (/ inner-len list-shrink-threshold)) min-list-inner-length))

(define (list->dynamic-vector elements)
  (let* ((len (length elements))
        (vec-len (get-dvec-inner-len len))
        (vec (make-vector vec-len list-empty-cell)))
    (let loop ((i 0) (elements elements))
      (if (null? elements)
        (make-dynamic-vector len vec)
        (begin
          (vector-set! vec i (car elements))
          (loop (+ i 1) (cdr elements)))))))


(define-macro (define-concat-dynamic-vector name vref vset vmake vempty-list)
`(define (,name container1 container2)
  (let* ((len1 (car container1))
        (v1 (cdr container1))
        (len2 (car container2))
        (v2 (cdr container2))
        (total-len (+ len1 len2))
        (vec-len (get-dvec-inner-len total-len))
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

(define-concat-dynamic-vector concat-dynamic-vectors vector-ref vector-set! make-vector list-empty-cell)
(define-concat-dynamic-vector concat-dynamic-u8vectors u8vector-ref u8vector-set! make-u8vector 0)

(define (py-make-list . elements)
  (let ((len (length elements))
        (len-vec-pair (list->dynamic-vector elements)))
  (py-list-from-scheme len-vec-pair)))

(define (py-list-from-scheme len-vec-pair)
  (make-PyObjectList
    py-list-hclass-of-instances
    (make-vector
      (vector-length (HClass-names py-list-hclass-of-instances))
      py-absent)
    py-list-class
    len-vec-pair))

(define (py-list-subtype-from-scheme len-vec-pair cls)
  (make-PyObjectList
    py-list-hclass-of-instances
    (make-vector
      (vector-length (HClass-names py-list-hclass-of-instances))
      py-absent)
    cls
    len-vec-pair))

(define (vector-head->dynamic-vector vec stop)
  (let ((inner-len (get-dvec-inner-len stop)))
    (make-dynamic-vector
      stop
      (vector-append
        (subvector vec 0 stop)
        (make-vector (- inner-len stop) list-empty-cell)))))

(define (list-new cls iterable)
  (if (or (eq? cls py-list-class) (py-issubclass? cls py-list-class))
      (if (eq? iterable py-absent)
          (py-list-subtype-from-scheme (make-dynamic-vector 0 '#()) cls)
          (let ((iterable-type (py-type iterable)))
           (cond
             ((eq? iterable-type py-tuple-class)
              (let ((vec (PyObjectTuple-value iterable)))
               (py-list-subtype-from-scheme
                 (vector-head->dynamic-vector vec (vector-length vec))
                 cls)))
             ((eq? iterable-type py-list-class)
              (let* ((dvec (PyObjectList-value iterable))
                     (len (car dvec))
                     (vec (cdr dvec)))
                (py-list-subtype-from-scheme
                  (vector-head->dynamic-vector vec len)
                  cls)))
             (else
               (let* ((iterator (py-iter iterable))
                      (content (list->vector (iterator->list iterator))))
                 (py-list-subtype-from-scheme
                   (vector-head->dynamic-vector content (vector-length content))
                   cls))))))
      (py-throw-wrong-new-argument "list" cls)))

(define list.__new__
  (procedure->py-function
    list-new
    (make-signature posonlyargs: (cls value) defaults: (vector py-absent))))

(define (list-iter self)
  (if (py-isinstance? self py-list-class)
    (py-list-iterator-alloc 0 self)
    (py-throw-not-a-type-object "list.__iter__" self)))

(define list.__iter__
  (procedure->py-function
    list-iter
    (make-signature posonlyargs: (self))))

;; TODO: use list real length instead of vector-length
;; otherwise this will crash once list is an actual dynamic array
(define (list-contains self item)
  (if (py-isinstance? self py-list-class)
    (let* ((len-vec-pair (PyObjectList-value self))
           (len (car len-vec-pair))
           (vec (cdr len-vec-pair)))
      (let loop ((i 0))
        (if (< i len)
          (if (py-test (py-eq item (vector-ref vec i)))
            py-True
            (loop (+ i 1)))
          py-False)))
    (py-throw-not-a-type-object "list.__contains__" self)))

(define list.__contains__
  (procedure->py-function
    list-contains
    (make-signature posonlyargs: (self item))))

;; TODO: print cyclic structures
(define (list-repr self)
  (if (py-isinstance? self py-list-class)
    (let* ((len-vec-pair (PyObjectList-value self))
           (len (car len-vec-pair))
           (vec (cdr len-vec-pair))
           (content-strs (vector-map py-repr (subvector vec 0 len)))
           (content-strings (vector-map (lambda (x) (PyObjectStr-value x)) content-strs)))
      (py-str-from-scheme
        (string-append
          "["
          (string-join-vector ", " content-strings)
          "]")))
    (py-throw-not-a-type-object "list.__repr__" self)))

(define list.__repr__
  (procedure->py-function
    list-repr
    (make-signature posonlyargs: (self))))

(define (list-add self other)
  (if (py-isinstance? self py-list-class)
    (if (py-isinstance? other py-list-class)
      (let ((c1 (PyObjectList-value self))
            (c2 (PyObjectList-value other)))
        (py-list-from-scheme (concat-dynamic-vectors c1 c2)))
      py-NotImplemented)
    (py-throw-not-a-type-object "list.__add__" self)))

(define list.__add__
  (procedure->py-function
    list-add
    (make-signature posonlyargs: (self other))))

(define-macro (define-*n-dynamic-vector name vref vset vmake vempty-list)
  `(define (,name c n)
  (let* ((len (car c))
         (vec (cdr c))
         (total-len (* len n))
         (target-inner-len (get-dvec-inner-len total-len))
         (out (,vmake target-inner-len ,vempty-list)))
    (let loop ((target-pos 0))
      (if (< target-pos total-len)
        (let inner-loop ((source-pos 0))
          (if (< source-pos len)
            (begin
              (,vset out (+ target-pos source-pos) (,vref vec source-pos))
              (inner-loop (+ source-pos 1)))
            (loop (+ target-pos len))))
        (make-dynamic-vector total-len out))))))

(define-*n-dynamic-vector dynamic-vector*n vector-ref vector-set! make-vector list-empty-cell)
(define-*n-dynamic-vector dynamic-u8vector*n u8vector-ref u8vector-set! make-u8vector 0)

(define (list-mul self n)
  (if (py-isinstance? self py-list-class)
      (if (py-instance-of-int? n)
          (let ((c (PyObjectList-value self))
                (n (py-instance-of-int-to-scheme n)))
            (py-list-from-scheme (dynamic-vector*n c n)))
          py-NotImplemented)
      (py-throw-not-a-type-object "list.__mul__" self)))

(define list.__mul__
  (procedure->py-function
    list-mul
    (make-signature posonlyargs: (self n))))

(define list.__rmul__
  (procedure->py-function
    list-mul
    (make-signature posonlyargs: (self n))))

(define (list-imul self n)
  (if (py-isinstance? self py-list-class)
      (if (py-instance-of-int? n)
          (let ((c (PyObjectList-value self))
                (n (py-instance-of-int-to-scheme n)))
            (PyObjectList-value-set! self (dynamic-vector*n c n))
            self)
          py-NotImplemented)
      (py-throw-not-a-type-object "list.__mul__" self)))

(define list.__imul__
  (procedure->py-function
    list-imul
    (make-signature posonlyargs: (self n))))

(define (list-len self)
  (if (py-isinstance? self py-list-class)
    (py-int-from-scheme
      (car
        (PyObjectList-value self)))
    (py-throw-not-a-type-object "list.__len__" self)))

(define list.__len__
  (procedure->py-function
    list-len
    (make-signature posonlyargs: (self))))

(define (dynamic-vector-py-eq? c1 c2)
  (let ((len1 (car c1))
        (v1 (cdr c1))
        (len2 (car c2))
        (v2 (cdr c2)))
    (if (= len1 len2)
      (let loop ((i 0))
        (if (< i len1)
          (let* ((el1 (vector-ref v1 i))
                 (el2 (vector-ref v2 i)))
            (if (py-test (py-eq el1 el2))
              (loop (+ i 1))
              #f))
          #t))
      #f)))

(define (dynamic-vector-py-ne? v1 v2)
  (not (dynamic-vector-py-eq? v1 v2)))

(define-macro (define-dynamic-vector-comparator name py-strict-op scheme-op)
  `(define (,name c1 c2)
    (let* ((len1 (car c1))
          (len2 (car c2))
          (v1 (cdr c1))
          (v2 (cdr c2))
          (min-len (min len1 len2)))
      (let loop ((i 0))
        (if (< i min-len)
          (let* ((el1 (vector-ref v1 i))
                 (el2 (vector-ref v2 i)))
            (if (py-test (,py-strict-op el1 el2))
              #t
              (if (py-test (py-eq el1 el2))
                (loop (+ i 1))
                #f)))
          (,scheme-op len1 len2))))))

(define-dynamic-vector-comparator dynamic-vector-py-lt? py-lt <)

(define-dynamic-vector-comparator dynamic-vector-py-le? py-lt <=)

(define-dynamic-vector-comparator dynamic-vector-py-gt? py-gt >)

(define-dynamic-vector-comparator dynamic-vector-py-ge? py-gt >=)

(define-macro (define-list-binary-comparator name py-name dynamic-vector-comparator)
  `(begin
    (define (,name self other)
      (if (py-isinstance? self py-list-class)
        (if (py-isinstance? other py-list-class)
          (let ((c1 (PyObjectList-value self))
                (c2 (PyObjectList-value other)))
            (if (,dynamic-vector-comparator c1 c2)
              py-True
              py-False))
          py-NotImplemented)
        (py-throw-not-a-type-object ,(symbol->string py-name) self)))

    (define ,py-name
      (procedure->py-function
        ,name
        (make-signature posonlyargs: (self other))))))

(define-list-binary-comparator list-eq list.__eq__ dynamic-vector-py-eq?)

(define-list-binary-comparator list-ne list.__ne__ dynamic-vector-py-ne?)

(define-list-binary-comparator list-lt list.__lt__ dynamic-vector-py-lt?)

(define-list-binary-comparator list-le list.__le__ dynamic-vector-py-le?)

(define-list-binary-comparator list-gt list.__gt__ dynamic-vector-py-gt?)

(define-list-binary-comparator list-ge list.__ge__ dynamic-vector-py-ge?)

(define-macro (define-slice-dynamic-vector name vref vset vmake vlist-empty)
  `(define (,name vec start stop step)
  (let* ((len (max 0 (ceiling (/ (- stop start) step))))
        (inner-len (get-dvec-inner-len len))
        (out (,vmake inner-len ,vlist-empty)))
    (let loop ((source start) (target 0))
      (if (< target len)
        (begin
          (,vset out target (,vref vec source))
          (loop (+ source step) (+ target 1)))))
    (make-dynamic-vector len out))))

(define-slice-dynamic-vector dynamic-vector-slice vector-ref vector-set! make-vector list-empty-cell)
(define-slice-dynamic-vector dynamic-u8vector-slice u8vector-ref u8vector-set! make-u8vector 0)

;; NOTE: follows requirements of slice.indices(len)
(define (py-slice-indices slice len)
  (let* ((py-start (PyObjectSlice-start slice))
         (py-stop (PyObjectSlice-stop slice))
         (py-step (PyObjectSlice-step slice))
         (step
           (cond
             ((eq? py-step py-None) 1)
             ((eq? py-step py-int-0)
              (py-throw (py-call py-builtin-ValueError (&& "slice step cannot be zero"))))
             ((py-instance-of-int? py-step)
                (py-instance-of-int-to-scheme py-step))
             (else (py-throw-wrong-index-type "slice" "integers or None" py-step))))
         (start
           (cond
             ((eq? py-start py-None) (if (> step 0) 0 (- len 1)))
             ((py-instance-of-int? py-start)
                (let ((i (py-instance-of-int-to-scheme py-start)))
                  (if (< i 0) (+ len i) i)))
             (else (py-throw-wrong-index-type "slice" "integers or None" py-start))))
         (stop
           (cond
             ((eq? py-stop py-None) (if (> step 0) len -1))
             ((py-instance-of-int? py-stop)
                (let ((i (py-instance-of-int-to-scheme py-stop)))
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

(define-macro (define-py-slice-dynamic-vector name vref vdynamic-slice)
  `(define (,name dvec slice)
  (let* ((len (car dvec))
        (vec (cdr dvec))
        (slice-indices (py-slice-indices slice len)))
    (,vdynamic-slice
      vec
      (vector-ref slice-indices 0)
      (vector-ref slice-indices 1)
      (vector-ref slice-indices 2)))))

(define-py-slice-dynamic-vector dynamic-vector-py-slice vector-ref dynamic-vector-slice)
(define-py-slice-dynamic-vector dynamic-u8vector-py-slice u8vector-ref dynamic-u8vector-slice)

(define (list-getitem self item)
  (if (py-isinstance? self py-list-class)
    (cond
      ((py-instance-of-int? item)
        (let* ((container (PyObjectList-value self))
               (len (car container))
               (vec (cdr container))
               (i (py-instance-of-int-to-scheme item)))
          (if (index-in-length-range i len)
            (vector-ref vec (modulo i len))
            (py-throw-index-out-of-range "list"))))
      ((py-isinstance? item py-slice-class)
        (py-list-from-scheme
          (dynamic-vector-py-slice
            (PyObjectList-value self)
            item)))
      (else (py-throw-wrong-index-type "list" "integers or slices" item)))
    (py-throw-not-a-type-object "list.__getitem__" self)))

(define list.__getitem__
  (procedure->py-function
    list-getitem
    (make-signature posonlyargs: (self item))))

(define-macro (vector-ref-to-scheme-int vec index)
  `(py-instance-of-int-to-scheme (vector-ref ,vec ,index)))

;; slices of the form lst[1:4]
(define-macro (define-set-simple-slice-dynamic-vector name vshift-right-by vshift-left-by vset vref)
  `(define (,name dvec start stop vec len)
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


(define-set-simple-slice-dynamic-vector dynamic-vector-set-simple-slice! dynamic-vector-shift-right-by! dynamic-vector-shift-left-by! vector-set! vector-ref)
(define-set-simple-slice-dynamic-vector dynamic-u8vector-u8vector-set-simple-slice! dynamic-u8vector-shift-right-by! dynamic-u8vector-shift-left-by! u8vector-set! u8vector-ref)
(define-set-simple-slice-dynamic-vector dynamic-u8vector-vector-set-simple-slice! dynamic-u8vector-shift-right-by! dynamic-u8vector-shift-left-by! u8vector-set! vector-ref-to-scheme-int)


;;slices of the form lst[1:6:2] (i.e. with a step)
(define-macro (define-set-extended-dynamic-vector name vref vset)
  `(define (,name dvec start stop step vec len)
  (let ((self-vec (cdr dvec))
        (slice-len (max 0 (ceiling (/ (- stop start) step)))))
    (if (= len slice-len)
      (let loop ((src-index 0) (tgt-index start))
        (if (< src-index len)
          (begin
            (,vset self-vec tgt-index (,vref vec src-index))
            (loop (+ src-index 1) (+ tgt-index step)))))
      (py-throw-extended-slice-wrong-len len slice-len)))))

(define-set-extended-dynamic-vector dynamic-vector-set-extended-slice! vector-ref vector-set!)
(define-set-extended-dynamic-vector dynamic-u8vector-u8vector-set-extended-slice! u8vector-ref u8vector-set!)
(define-set-extended-dynamic-vector dynamic-u8vector-vector-set-extended-slice! vector-ref-to-scheme-int u8vector-set!)

(define (list-set-slice self slice value)
  (let* ((dvec (PyObjectList-value self))
        (self-len (car dvec))
        (indices (py-slice-indices slice self-len))
        (start (vector-ref indices 0))
        (stop (vector-ref indices 1))
        (step (vector-ref indices 2))
        (value-type (py-type value)))
    (cond
      ((eq? value-type py-list-class)
        (let* ((value-dvec (PyObjectList-value value))
              (value-len (car value-dvec))
              (value-vec (cdr value-dvec)))
          (if (eq? step 1)
            (dynamic-vector-set-simple-slice! dvec start stop value-vec value-len)
            (dynamic-vector-set-extended-slice! dvec start stop step value-vec value-len))))
      ((eq? value-type py-tuple-class)
        (let* ((value-vec (PyObjectTuple-value value))
               (value-len (vector-length value-vec)))
          (if (eq? step 1)
            (dynamic-vector-set-simple-slice! dvec start stop value-vec value-len)
            (dynamic-vector-set-extended-slice! dvec start stop step value-vec value-len))))
      (else
        (let ((iterator (py-obj->iterator value)))
          (if iterator
            (let* ((value-vec (list->vector (iterator->list iterator)))
                  (value-len (vector-length value-vec)))
              (if (eq? step 1)
                (dynamic-vector-set-simple-slice! dvec start stop value-vec value-len)
                (dynamic-vector-set-extended-slice! dvec start stop step value-vec value-len)))
            (py-throw-can-only-assign-iterable)))))))

(define (list-setitem self item value)
  (if (py-isinstance? self py-list-class)
    (cond
      ((py-instance-of-int? item)
        (let* ((container (PyObjectList-value self))
               (len (car container))
               (vec (cdr container))
               (i (py-instance-of-int-to-scheme item)))
          (if (index-in-length-range i len)
            (vector-set! vec (modulo i len) value)
            (py-throw-action-out-of-range "list" "assignment"))))
      ((py-isinstance? item py-slice-class)
        (list-set-slice self item value))
      (else (py-throw-wrong-index-type "list" "integers or slices" item)))
    (py-throw-not-a-type-object "list.__setitem__" self))
  py-None)

(define list.__setitem__
  (procedure->py-function
    list-setitem
    (make-signature posonlyargs: (self item value))))

(define-macro (define-shrink-dynamic-vector name vsubvec)
  `(define (,name dvec)
    (let* ((len (car dvec))
           (vec (cdr dvec))
           (new-inner-len (get-dvec-inner-len len)))
      (set-cdr! dvec (,vsubvec vec 0 new-inner-len)))))

(define-shrink-dynamic-vector dynamic-vector-shrink! subvector)
(define-shrink-dynamic-vector dynamic-u8vector-shrink! subu8vector)

(define-macro (define-grow-dynamic-vector name vset vmake vlist-empty vappend)
  `(define (,name dvec)
  (let* ((len (car dvec))
        (vec (cdr dvec))
        (new-inner-len (get-dvec-inner-len len)))
    (set-cdr!
      dvec
      (,vappend vec (,vmake (- new-inner-len len) ,vlist-empty))))))

(define-grow-dynamic-vector dynamic-vector-grow! vector-set! make-vector list-empty-cell vector-append)
(define-grow-dynamic-vector dynamic-u8vector-grow! u8vector-set! make-u8vector 0 u8vector-append)

(define-macro (define-grow-by-dynamic-vector name vmake vlist-empty vappend )
  `(define (,name dvec amount)
    (let* ((len (car dvec))
           (vec (cdr dvec))
           (new-inner-len (get-dvec-inner-len (+ len amount))))
      (set-cdr!
       dvec
       (,vappend vec (,vmake (- new-inner-len len) ,vlist-empty))))))

(define-grow-by-dynamic-vector dynamic-vector-grow-by! make-vector list-empty-cell vector-append)
(define-grow-by-dynamic-vector dynamic-u8vector-grow-by! make-u8vector 0 u8vector-append)

(define (dynamic-vector-shift-left! dvec index)
  (let ((len (car dvec))
        (vec (cdr dvec)))
    (let loop ((i index))
      (if (< i len)
        (begin
          (vector-set! vec (- i 1) (vector-ref vec i))
          (loop (+ i 1)))))
    (vector-set! vec (- len 1) list-empty-cell)
    (set-car! dvec (- len 1))
    (if (<
          len
          (get-shrink-threshold-len (vector-length vec)))
      (dynamic-vector-shrink! dvec))))

(define-macro (define-shift-left-by-dynamic-vector name vshrink-by vset vempty-list vref vlength)
  `(define (,name dvec index amount)
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
               (get-shrink-threshold-len (,vlength vec)))
              (,vshrink-by dvec))))))

(define-shift-left-by-dynamic-vector dynamic-vector-shift-left-by! dynamic-vector-shrink! vector-set! list-empty-cell vector-ref vector-length)
(define-shift-left-by-dynamic-vector dynamic-u8vector-shift-left-by! dynamic-u8vector-shrink! u8vector-set! 0 u8vector-ref u8vector-length)

;; NOTE: shift-right does not insert 'list-empty-cell' at index
;;       it is assumed shift is done with intent to write at index
(define (dynamic-vector-shift-right! dvec index)
  (let ((len (car dvec))
        (vec (cdr dvec)))
    (if (= len (vector-length vec))
      (begin
        (dynamic-vector-grow! dvec)
        (set! vec (cdr dvec))))
    (let loop ((i len))
      (if (> i index)
        (begin
          (vector-set! vec i (vector-ref vec (- i 1)))
          (loop (- i 1)))))
    (set-car! dvec (+ len 1))))

(define-macro (define-shift-right-by-dynamic-vector name vgrow-by vset vref vlength)
  `(define (,name dvec index amount)
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

(define-shift-right-by-dynamic-vector dynamic-vector-shift-right-by! dynamic-vector-grow-by! vector-set! vector-ref vector-length)
(define-shift-right-by-dynamic-vector dynamic-u8vector-shift-right-by! dynamic-u8vector-grow-by! u8vector-set! u8vector-ref u8vector-length)

(define (dynamic-vector-pop-last! dvec)
  (let* ((len (car dvec))
        (vec (cdr dvec))
        (last-index (- len 1))
        (last (vector-ref vec last-index)))
    (vector-set! vec last-index list-empty-cell)
    (set-car! dvec last-index)
    (if (<
          len
          (get-shrink-threshold-len (vector-length vec)))
      (dynamic-vector-shrink! dvec))
    last))

(define (dynamic-vector-del-extended-slice! dvec start stop step)
  (let* ((len (car dvec))
        (vec (cdr dvec))
        (slice-len (max 0 (ceiling (/ (- stop start) step))))
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
        ;; shift-left handles dynamic-vector-shrink
        (dynamic-vector-shift-left-by! dvec read-index slice-len)))))

(define (list-delitem self item)
  (if (py-isinstance? self py-list-class)
    (cond
      ((py-instance-of-int? item)
        (let* ((dvec (PyObjectList-value self))
               (len (car dvec))
               (i (py-instance-of-int-to-scheme item)))
          (if (index-in-length-range i len)
            (dynamic-vector-shift-left! dvec (+ (modulo i len) 1))
            (py-throw-action-out-of-range "list" "assignement"))))
      ((py-isinstance? item py-slice-class)
        (let* ((dvec (PyObjectList-value self))
              (len (car dvec))
              (indices (py-slice-indices item len))
              (start (vector-ref indices 0))
              (stop (vector-ref indices 1))
              (step (vector-ref indices 2)))
          (if (= step 1)
            (let ((size (- stop start)))
              (dynamic-vector-shift-left-by! dvec stop size))
            (dynamic-vector-del-extended-slice! dvec start stop step))))
      (else (py-throw-wrong-index-type "list" "integers or slices" item)))
    (py-throw-not-a-type-object "list.__delitem__" self))
  py-None)

(define list.__delitem__
  (procedure->py-function
    list-delitem
    (make-signature posonlyargs: (self item))))

(define (list-pop self index)
  (if (py-isinstance? self py-list-class)
    (cond
      ((eq? index py-absent)
        (let* ((dvec (PyObjectList-value self))
               (len (car dvec)))
          (if (> len 0)
            (dynamic-vector-pop-last! dvec)
            (py-throw-pop-from-empty-list))))
      ((py-instance-of-int? index)
        (let* ((dvec (PyObjectList-value self))
               (len (car dvec))
               (vec (cdr dvec))
               (i (py-instance-of-int-to-scheme index)))
          (if (index-in-length-range i len)
            (let* ((actual-i (modulo i len))
                   (element (vector-ref vec actual-i)))
              (dynamic-vector-shift-left! dvec (+ actual-i 1))
              element)
            (py-throw-action-out-of-range "list" "pop"))))
      ((py-isinstance? index py-slice-class)
        (py-throw-exception-with-message py-builtin-NotImplementedError "list-delitem slice not implemented"))
      (else (py-throw-wrong-index-type "list" "integers" index)))
    (py-throw-not-a-type-object "list.pop" self)))

(define list.pop
  (procedure->py-function
    list-pop
    (make-signature posonlyargs: (self index) defaults: (vector py-absent))))

(define (list-append self value)
  (if (py-isinstance? self py-list-class)
    (let* ((dvec (PyObjectList-value self))
          (len (car dvec))
          (vec (cdr dvec)))
      (if (= len (vector-length vec))
        (begin
          (dynamic-vector-grow! dvec)
          (set! vec (cdr dvec))))
      (vector-set! vec len value)
      (set-car! dvec (+ len 1)))
    (py-throw-not-a-type-object "list.append" self))
  py-None)

(define list.append
  (procedure->py-function
    list-append
    (make-signature posonlyargs: (self value))))

(define (list-clear self)
  (if (py-isinstance? self py-list-class)
    (PyObjectList-value-set!
      self
      (make-dynamic-vector 0 (make-vector min-list-inner-length list-empty-cell)))
    (py-throw-not-a-type-object "list.clear" self))
  py-None)

(define list.clear
  (procedure->py-function
    list-clear
    (make-signature posonlyargs: (self))))

;; Could not call list-copy due to collision with Scheme list-copy
(define (list-copy-procedure self)
  (if (py-isinstance? self py-list-class)
    (let* ((dvec (PyObjectList-value self))
          (dvec-copy
            (make-dynamic-vector
              (car dvec)
              (vector-copy (cdr dvec)))))
      (py-list-from-scheme dvec-copy))
    (py-throw-not-a-type-object "list.copy" self)))

(define list.copy
  (procedure->py-function
    list-copy-procedure
    (make-signature posonlyargs: (self))))

(define (list-count self item)
  (if (py-isinstance? self py-list-class)
    (let* ((dvec (PyObjectList-value self))
           (len (car dvec))
           (vec (cdr dvec)))
      (let loop ((i 0) (count 0))
        (cond
          ((= i len)
            (py-int-from-scheme count))
          ((py-test (py-eq (vector-ref vec i) item))
            (loop (+ i 1) (+ count 1)))
          (else
            (loop (+ i 1) count)))))
    (py-throw-not-a-type-object "list.count" self)))

(define list.count
  (procedure->py-function
    list-count
    (make-signature posonlyargs: (self item))))

(define (list-index self item start stop)
  (if (py-isinstance? self py-list-class)
    (let* ((dvec (PyObjectList-value self))
           (len (car dvec))
           (vec (cdr dvec))
           (start-index
            (if (eq? start py-absent)
              0
              (if (py-instance-of-int? start)
                (let ((val (py-instance-of-int-to-scheme start)))
                  (if (< val 0)
                    (modulo (max (- len) val) len)
                    (min len val)))
                    (py-throw-wrong-index-type "list" "integers" start))))
           (stop-index
             (if (eq? stop py-absent)
               len
               (if (py-instance-of-int? stop)
                 (let ((val (py-instance-of-int-to-scheme stop)))
                   (if (< val 0)
                     (modulo (max (- len) val) len)
                     (min len val)))
                     (py-throw-wrong-index-type "list" "integers" stop)))))
      (let ((res (py-index-in-subvector item vec start-index stop-index)))
        (if res
          (py-int-from-scheme res)
          (py-throw
            (py-call
              py-builtin-ValueError
              (&& "list.index(x): x not in list"))))))
    (py-throw-not-a-type-object "list.index" self)))

(define list.index
  (procedure->py-function
    list-index
    (make-signature posonlyargs: (self item start stop) defaults: (vector py-absent py-absent))))

(define (list-insert self index value)
  (if (py-isinstance? self py-list-class)
    (if (py-instance-of-int? index)
      (let* ((dvec (PyObjectList-value self))
            (len (car dvec))
            (i (py-instance-of-int-to-scheme index)))
        (let ((insertion-index
                (if (< i 0)
                  (modulo (max (- len) i) len)
                  (min len i))))
          (dynamic-vector-shift-right! dvec insertion-index)
          (vector-set! (cdr dvec) insertion-index value)))
        (py-throw-wrong-index-type "list" "integers" index))
    (py-throw-not-a-type-object "list.insert" self))
  py-None)

(define list.insert
  (procedure->py-function
    list-insert
    (make-signature posonlyargs: (self index value))))

(define (extend-dynamic-vector-with-vector-head dvec source-vec stop)
  (let* ((len (car dvec))
        (vec (cdr dvec))
        (inner-len (vector-length vec)))
    (if (>= stop (- inner-len len))
      (begin
        (dynamic-vector-grow-by! dvec stop)
        (set! vec (cdr dvec))))
    (let loop ((i len) (j 0))
      (if (< j stop)
        (begin
          (vector-set! vec i (vector-ref source-vec j))
          (loop (+ i 1) (+ j 1)))))
    (set-car! dvec (+ len stop))))

(define (dynamic-vector-extend-with-iterable dvec iterable)
  (let ((iterable-type (py-type iterable)))
    (cond
      ((eq? iterable-type py-tuple-class)
        (let ((vec (PyObjectTuple-value iterable)))
          (extend-dynamic-vector-with-vector-head
            dvec
            vec
            (vector-length vec))))
      ((eq? iterable-type py-list-class)
        (let* ((other-dvec (PyObjectList-value iterable))
               (len (car other-dvec))
               (vec (cdr other-dvec)))
          (extend-dynamic-vector-with-vector-head
            dvec
            vec
            len)))
      (else
        (let* ((iterator (py-iter iterable))
               (content (list->vector (iterator->list iterator))))
          (extend-dynamic-vector-with-vector-head
            dvec
            content
            (vector-length content)))))))

(define (list-extend self iterable)
  (if (py-isinstance? self py-list-class)
    (let ((dvec (PyObjectList-value self)))
      (dynamic-vector-extend-with-iterable dvec iterable))
    (py-throw-not-a-type-object "list.extend" self))
  py-None)

(define list.extend
  (procedure->py-function
    list-extend
    (make-signature posonlyargs: (self iterable))))

(define (list-iadd self other)
  (if (py-isinstance? self py-list-class)
    (let ((dvec (PyObjectList-value self)))
      (dynamic-vector-extend-with-iterable dvec other))
    (py-throw-not-a-type-object "list.__iadd__" self))
  self)

(define list.__iadd__
  (procedure->py-function
    list-iadd
    (make-signature posonlyargs: (self other))))

(define (list-remove self item)
  (if (py-isinstance? self py-list-class)
    (let* ((dvec (PyObjectList-value self))
           (len (car dvec))
           (vec (cdr dvec)))
      (let ((index (py-index-in-subvector item vec 0 len)))
        (if index
          (dynamic-vector-shift-left! dvec (+ index 1))
          (py-throw
            (py-call
              py-builtin-ValueError
              (&& "list.remove(x): x not in list"))))))
    (py-throw-not-a-type-object "list.remove" self))
  py-None)

(define list.remove
  (procedure->py-function
    list-remove
    (make-signature posonlyargs: (self item))))

(define (dynamic-vector-reverse! dvec)
  (let ((len (car dvec))
        (vec (cdr dvec)))
    (let loop ((left 0) (right (- len 1)))
      (if (< left right)
        (begin
          (let ((tmp (vector-ref vec left)))
            (vector-set! vec left (vector-ref vec right))
            (vector-set! vec right tmp))
          (loop (+ left 1) (- right 1)))))))

(define (list-reverse self)
    (if (py-isinstance? self py-list-class)
      (dynamic-vector-reverse! (PyObjectList-value self))
      (py-throw-not-a-type-object "list.reverse" self))
    py-None)

(define list.reverse
  (procedure->py-function
    list-reverse
    (make-signature posonlyargs: (self))))

(define list.sort #f)

;; tuple class

(define (tuple-iter self)
  (if (py-isinstance? self py-tuple-class)
    (py-tuple-iterator-alloc 0 (PyObjectTuple-value self))
    (py-throw-exception-with-message py-builtin-TypeError "pending error message (code 12)")))

(define tuple.__iter__
  (procedure->py-function
    tuple-iter
    (make-signature posonlyargs: (self))))

(define (tuple-contains self item)
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

(define tuple.__contains__
  (procedure->py-function
    tuple-contains
    (make-signature posonlyargs: (self item))))

(define (tuple-add self other)
  (if (py-isinstance? self py-tuple-class)
    (if (py-isinstance? other py-tuple-class)
      (let ((v1 (PyObjectTuple-value self))
            (v2 (PyObjectTuple-value other)))
        (py-tuple-from-scheme (vector-append v1 v2)))
      py-NotImplemented)
    (py-throw-not-a-type-object "tuple.__add__" self)))

(define tuple.__add__
  (procedure->py-function
    tuple-add
    (make-signature posonlyargs: (self other))))

(define (vector*n v n)
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

(define (tuple-mul self n)
  (if (py-isinstance? self py-tuple-class)
    (if (py-instance-of-int? n)
      (let ((v (PyObjectTuple-value self))
            (n (py-instance-of-int-to-scheme n)))
        (py-tuple-from-scheme (vector*n v n)))
      py-NotImplemented)
    (py-throw-not-a-type-object "tuple.__mul__" self)))

(define tuple.__mul__
  (procedure->py-function
    tuple-mul
    (make-signature posonlyargs: (self n))))

(define tuple.__rmul__
  (procedure->py-function
    tuple-mul
    (make-signature posonlyargs: (self n))))

(define (vector-py-eq? v1 v2)
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

(define (vector-py-ne? v1 v2)
  (not (vector-py-eq? v1 v2)))

(define-macro (define-vector-comparator name py-strict-op scheme-op)
  `(define (,name v1 v2)
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
    (define (,name self other)
      (if (py-isinstance? self py-tuple-class)
        (if (py-isinstance? other py-tuple-class)
          (let ((v1 (PyObjectTuple-value self))
                (v2 (PyObjectTuple-value other)))
            (if (,vector-comparator v1 v2)
              py-True
              py-False))
          py-NotImplemented)
        (py-throw-not-a-type-object ,(symbol->string py-name) self)))

    (define ,py-name
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
(define (tuple-repr self)
  (if (py-isinstance? self py-tuple-class)
    (let* ((vec (PyObjectTuple-value self))
           (content-strs (vector-map py-repr vec))
           (content-strings (vector-map (lambda (x) (PyObjectStr-value x)) content-strs)))
      (py-str-from-scheme
        (string-append
          "("
          (string-join-vector ", " content-strings)
          (if (= (vector-length vec) 1) ",)" ")"))))
    (py-throw-not-a-type-object "tuple.__repr__" self)))

(define tuple.__repr__
  (procedure->py-function
    tuple-repr
    (make-signature posonlyargs: (self))))

(define (tuple-len self)
  (if (py-isinstance? self py-tuple-class)
    (let* ((vec (PyObjectTuple-value self)))
      (py-int-from-scheme (vector-length vec)))
    (py-throw-not-a-type-object "tuple.__len__" self)))

(define tuple.__len__
  (procedure->py-function
    tuple-len
    (make-signature posonlyargs: (self))))

(define (vector-slice vec start stop step)
  (let* ((len (max 0 (ceiling (/ (- stop start) step))))
        (out (make-vector len list-empty-cell)))
    (let loop ((source start) (target 0))
      (if (< target len)
        (begin
          (vector-set! out target (vector-ref vec source))
          (loop (+ source step) (+ target 1)))))
    out))

(define (vector-py-slice vec slice)
  (let* ((len (vector-length vec))
        (slice-indices (py-slice-indices slice len)))
    (vector-slice
      vec
      (vector-ref slice-indices 0)
      (vector-ref slice-indices 1)
      (vector-ref slice-indices 2))))

(define (tuple-getitem self item)
  (if (py-isinstance? self py-tuple-class)
    (cond
      ((py-instance-of-int? item)
        (let* ((vec (PyObjectTuple-value self))
               (len (vector-length vec))
               (i (py-instance-of-int-to-scheme item)))
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

(define tuple.__getitem__
  (procedure->py-function
    tuple-getitem
    (make-signature posonlyargs: (self item))))

(define (tuple-count self item)
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

(define tuple.count
  (procedure->py-function
    tuple-count
    (make-signature posonlyargs: (self item))))

(define (tuple-index self item start stop)
  (if (py-isinstance? self py-tuple-class)
    (let* ((vec (PyObjectTuple-value self))
           (len (vector-length vec))
           (start-index
            (if (eq? start py-absent)
              0
              (if (py-instance-of-int? start)
                (let ((val (py-instance-of-int-to-scheme start)))
                  (if (< val 0)
                    (modulo (max (- len) val) len)
                    (min len val)))
                    (py-throw-wrong-index-type "tuple" "integers" start))))
           (stop-index
             (if (eq? stop py-absent)
               len
               (if (py-instance-of-int? stop)
                 (let ((val (py-instance-of-int-to-scheme stop)))
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

(define tuple.index
  (procedure->py-function
    tuple-index
    (make-signature
      posonlyargs: (self item start stop)
      defaults: (vector py-absent py-absent))))

;; slices

(define (py-slice-from-scheme start stop step)
  (make-PyObjectSlice
    py-slice-hclass-of-instances
    (make-vector
      (vector-length (HClass-names py-slice-hclass-of-instances))
      py-absent)
    py-slice-class
    start
    stop
    step))

(define (slice-new cls arg1 arg2 arg3)
  (if (or (eq? cls py-slice-class) (py-issubclass? cls py-slice-class))
    (cond
      ((eq? arg2 py-absent)
        (py-slice-from-scheme py-None arg1 py-None))
      ((eq? arg3 py-absent)
        (py-slice-from-scheme arg1 arg2 py-None))
      (else
        (py-slice-from-scheme arg1 arg2 arg3)))
    (py-throw-wrong-new-argument "list" cls)))

(define slice.__new__
  (procedure->py-function
    slice-new
    (make-signature
      posonlyargs: (cls arg1 arg2 arg3)
      defaults: (vector py-absent py-absent))))

(define (slice-indices self len)
    (if (py-isinstance? self py-slice-class)
      (if (py-instance-of-int? len)
        (let ((len-i (py-instance-of-int-to-scheme len)))
          (py-tuple-from-scheme
            (vector-map
             (lambda (n) (py-int-from-scheme n))
             (py-slice-indices self len-i))))
        (py-throw-exception-with-message py-builtin-TypeError "pending error message (code 13)")) ;; TODO: add error message
      (py-throw-not-a-type-object "slice.indices" self)))

(define slice.indices
  (procedure->py-function
    slice-indices
    (make-signature posonlyargs: (self len))))


;; =========================
;; bytearray operations
;; =========================

(define (py-int-in-byte-range? value)
  (and (<= 0 value) (>= 255 value)))

(define (vector-in-byte-range? vec)
  (let loop ((i 0))
    (if (< i (vector-length vec))
        (let ((item (vector-ref vec i)))
          (if (and
               (py-instance-of-int? item)
               (py-int-in-byte-range? (py-instance-of-int-to-scheme item)))
              (loop (+ 1 i))
              #f))
        #t)))

(define u8-empty-vector (make-u8vector 0 0))

(define (bytearray-new cls arg1 arg2 agr3)
  (if (py-issubclass? cls py-bytearray-class)
    (cond
       ((eq? arg1 py-absent)
        ;; MS 11jun2020: to be removed when Bigloo's fixed
        ;; (py-bytearray-from-scheme (cons 0 #u8())))
        (py-bytearray-subtype-from-scheme (make-dynamic-vector 0 u8-empty-vector) cls))
      ((eq? arg2 py-absent)
        (cond
          ((py-instance-of-int? arg1)
            (let ((i (py-instance-of-int-to-scheme arg1)))
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


(define bytearray.__new__
  (procedure->py-function
    bytearray-new
    (make-signature
      posonlyargs: (cls source encoding errors)
      defaults: (vector py-absent py-absent py-absent))))


(define (bytearray-getitem self item)
  (if (py-isinstance? self py-bytearray-class)
      (cond
        ((py-instance-of-int? item)
        (let ((bytearray (PyObjectBytearray-value self))
              (i (py-instance-of-int-to-scheme item)))
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

(define bytearray.__getitem__
  (procedure->py-function
    bytearray-getitem
    (make-signature posonlyargs:
      (self item))))

(define (bytearray-set-slice self slice value)
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


(define (bytearray-setitem self key value)
  (if (py-isinstance? self py-bytearray-class)
      (cond
       ((py-instance-of-int? key)
        (if (py-instance-of-int? value)
            (let ((key-int (py-instance-of-int-to-scheme key))
                  (bytearray (PyObjectBytearray-value self))
                  (value-int (py-instance-of-int-to-scheme value)))
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

(define bytearray.__setitem__
  (procedure->py-function
    bytearray-setitem
      (make-signature posonlyargs:
        (self key value))))

(define (bytearray-append self elem)
  (cond
    ((not (py-isinstance? self py-bytearray-class))
      (py-throw-not-a-type-object "bytearray.append" self))
    ((not (py-instance-of-int? elem))
      (py-throw-exception-with-message py-builtin-TypeError "this type cannot be interpreted as an integer"))
    (else
      (let* ((bytearray (PyObjectBytearray-value self))
            (real-length (u8vector-length (cdr bytearray)))
            (elem-int (py-instance-of-int-to-scheme elem)))
        (if (not (py-int-in-byte-range? elem-int))
            (py-throw-exception-with-message py-builtin-ValueError "byte must be in range(0, 255)")
            (begin
              (if (= real-length (car bytearray))
                  (dynamic-u8vector-grow! bytearray))
              (u8vector-set! (cdr bytearray) (car bytearray) elem-int)
              (set-car! bytearray (+ 1 (car bytearray)))))))))

(define bytearray.append
  (procedure->py-function
    bytearray-append
    (make-signature posonlyargs:
      (self value))))

(define (bytearray-add self other)
  (if (py-isinstance? self py-bytearray-class)
      (if (py-isinstance? other py-bytearray-class)
          (let ((c1 (PyObjectBytearray-value self))
                (c2 (PyObjectBytearray-value other)))
            (py-bytearray-from-scheme (concat-dynamic-u8vectors c1 c2)))
          py-NotImplemented)
      (py-throw-not-a-type-object "bytearray.__add__" self)))

(define bytearray.__add__
  (procedure->py-function
   bytearray-add
   (make-signature posonlyargs: (self other))))

(define (dynamic-u8vector-extend dvec-target dvec-source)
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


(define (bytearray-iadd self other)
  (if (py-isinstance? self py-bytearray-class)
      (if (py-isinstance? other py-bytearray-class)
          (let ((c1 (PyObjectBytearray-value self))
                (c2 (PyObjectBytearray-value other)))
            (dynamic-u8vector-extend c1 c2)
            self)
          py-NotImplemented)
      (py-throw-not-a-type-object "bytearray.__iadd__" self)))

(define bytearray.__iadd__
  (procedure->py-function
   bytearray-iadd
   (make-signature posonlyargs: (self other))))

(define (bytearray-repr self)
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

(define bytearray.__repr__
  (procedure->py-function
   bytearray-repr
   (make-signature posonlyargs: (self))))

(define (bytearray-mul self n)
  (if (py-isinstance? self py-bytearray-class)
      (if (py-instance-of-int? n)
          (let ((c (PyObjectBytearray-value self))
                (n (py-instance-of-int-to-scheme n)))
            (py-bytearray-from-scheme (dynamic-u8vector*n c n)))
          py-NotImplemented)
      (py-throw-not-a-type-object "bytearray.__mul__" self)))

(define bytearray.__mul__
  (procedure->py-function
   bytearray-mul
   (make-signature posonlyargs: (self other))))

(define bytearray.__rmul__
  (procedure->py-function
   bytearray-mul
   (make-signature posonlyargs: (self n))))

(define (bytearray-imul self n)
  (if (py-isinstance? self py-bytearray-class)
      (if (py-instance-of-int? n)
          (let ((c (PyObjectBytearray-value self))
                (n (py-instance-of-int-to-scheme n)))
            (PyObjectBytearray-value-set! self (dynamic-u8vector*n c n))
            self)
          py-NotImplemented)
      (py-throw-not-a-type-object "bytearray.__mul__" self)))

(define bytearray.__imul__
  (procedure->py-function
   bytearray-imul
   (make-signature posonlyargs: (self n))))

(define (bytearray-len self)
  (if (py-isinstance? self py-bytearray-class)
      (py-int-from-scheme
       (car
        (PyObjectBytearray-value self)))
      (py-throw-not-a-type-object "bytearray.__len__" self)))

(define bytearray.__len__
  (procedure->py-function
   bytearray-len
   (make-signature posonlyargs: (self))))

(define-macro (define-search-function endfunction name func-name)
  `(begin
     (define (,name self item start stop)
       (cond
        ((not (py-isinstance? self py-bytearray-class))
         ((py-throw-not-a-type-object ,(symbol->string func-name) self)))
        ((not (py-instance-of-int? item))
         ((py-throw-action-out-of-range "bytearray" "assignment")))
        (else
         (let* ((bytearray (PyObjectBytearray-value self))
                (item-int (py-instance-of-int-to-scheme item)))
           (if (py-int-in-byte-range? item-int)
               (let ((start-int
                      (if (eq? py-absent start)
                          0
                          (max 0 (py-instance-of-int-to-scheme start))))
                     (stop-int
                      (if (eq? py-absent stop)
                          (car bytearray)
                          (min (car bytearray) (py-instance-of-int-to-scheme stop)))))
                 (,endfunction (cdr bytearray) item-int start-int stop-int))
               (py-throw-exception-with-message py-builtin-ValueError "byte must be in range(0, 255)")
               )))))
     (define ,func-name
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
     (define  (,func-name self other)
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
     (define ,(string->symbol (string-append "bytearray." name))
       (procedure->py-function
        ,func-name
        (make-signature posonlyargs: (self other))))))


(dynamic-u8vector-comparator-eq 1 #f #t "__gt__" bytearray-gt)
(dynamic-u8vector-comparator-eq 1 #t #t "__ge__" bytearray-ge)
(dynamic-u8vector-comparator-eq -1 #f #t "__lt__" bytearray-lt)
(dynamic-u8vector-comparator-eq -1 #t #t"__le__" bytearray-le)

(dynamic-u8vector-comparator-eq 0 #f #t "__eq__" bytearray-eq)
(dynamic-u8vector-comparator-eq 0 #f #f "__ne__" bytearray-ne)


(define (bytearray-iter self)
  (if (py-isinstance? self py-bytearray-class)
      (py-bytearray-iterator-alloc 0 (PyObjectBytearray-value self))
      (py-throw-not-a-type-object "bytearray.__iter__" self)))

(define bytearray.__iter__
  (procedure->py-function
   bytearray-iter
   (make-signature posonlyargs: (self))))

;; =============================================================================
;;  Generators
;; =============================================================================

(define (py-generator-yield gen val kont)
   (py-throw-exception-with-message
     py-builtin-NotImplementedError
     "py-generator-yield not implemented"))

(define (py-make-generator proc)
  (py-throw-exception-with-message
    py-builtin-NotImplementedError
    "py-make-generator not implemented"))

(define (py-generator-send self value)
  (py-throw-exception-with-message
    py-builtin-NotImplementedError
    "py-generator-send not implemented"))

(define (py-next iterator)
  (let ((next (getattribute-from-obj-mro iterator (& "__next__"))))
     (with-handler
        (lambda (e)
          (if (and (PyObject? e) (py-isinstance? e py-builtin-StopIteration))
                 #f
                 (raise e)))
        (py-call next iterator))))


;; =============================================================================
;;  Dict
;; =============================================================================

;; define a doubly-linked-list type for order-preservation
(define-type doubly-linked-list-node value next prev)

(define (doubly-linked-list-node-remove! node ordered-table)
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
(define empty-table-cell (cons 'empty-table-cell '()))

(define table-growth-factor 2)
(define table-full-ratio (/ 2 3))

(define (get-table-inner-len len)
  (fxarithmetic-shift
    1
    (integer-length (inexact->exact (ceiling (/ len table-full-ratio))))))

(define-type ordered-table table length first last iterator-token)

(define (ordered-table-first-key ot)
  (dict-cell-key
    (doubly-linked-list-node-value
      (ordered-table-first ot))))

(define (ordered-table->list ordered-table)
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

(define (ordered-table-append! ordered-table node)
  (let ((first (ordered-table-first ordered-table)))
    (if first
      (let ((last (ordered-table-last ordered-table)))
        (ordered-table-last-set! ordered-table node)
        (doubly-linked-list-node-next-set! last node)
        (doubly-linked-list-node-prev-set! node last))
      (begin
        (ordered-table-first-set! ordered-table node)
        (ordered-table-last-set! ordered-table node)))))

(define (make-empty-ordered-table length-hint)
  (make-ordered-table
    (make-vector (get-table-inner-len length-hint) empty-table-cell)
    0
    #f
    #f
    (box #t)))

(define (ordered-table-drop-token! ordered-table)
  ;; signal to any iterator that there was a change to the table which
  ;; prevents further iteration
  (set-box! (ordered-table-iterator-token ordered-table) #f)
  ;; drop old token and create a new one
  (ordered-table-iterator-token-set! ordered-table (box #t)))

(define (cell-next i size)
  ;; we use bitwise-and because size is always a power of 2
  (bitwise-and (+ (* 5 i) 1) (- size 1)))

(define (hash->cell hash size)
  ;; use and because size is always a power of 2
  (bitwise-and hash (- size 1)))

(define (ordered-table-get-cell ordered-table key)
  (let* ((hash (py-instance-of-int-to-scheme (py-hash key)))
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

(define (table-bucket-indices table size i)
  (let loop ((i i))
    (if (eq? (vector-ref table i) empty-table-cell)
      '()
      (cons
        i
        (table-bucket-indices
          table
          size
          (cell-next i size))))))

(define (table-reinsert-node! table node)
  (let* ((cell (doubly-linked-list-node-value node))
        (hash (dict-cell-hash cell))
        (size (vector-length table)))
    (let loop ((i (hash->cell hash size)))
      (let ((current-node (vector-ref table i)))
        (if (eq? current-node empty-table-cell)
          ;; case where we found an empty cell
          (vector-set! table i node)
          (loop (cell-next i size)))))))

(define (table-bucket-reinsert table indices)
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

(define (ordered-table-remove-key! ordered-table key)
  (let* ((hash (py-instance-of-int-to-scheme (py-hash key)))
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

(define (table-vector-set! ordered-table vec size hash key value)
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

(define (ordered-table-grow! ordered-table)
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

(define (ordered-table-set-cell! ordered-table key value)
  (let* ((hash (py-instance-of-int-to-scheme (py-hash key)))
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

(define (ordered-table-get ordered-table key default)
  (let* ((cell (ordered-table-get-cell ordered-table key)))
    (if (eq? cell empty-table-cell)
      (if (eq? default py-absent)
        (py-throw (py-call py-builtin-KeyError key))
        default)
      (dict-cell-value cell))))

(define (ordered-table-pop! ordered-table key default)
  (let* ((hash (py-instance-of-int-to-scheme (py-hash key)))
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

(define (py-make-empty-dict)
  (py-dict-alloc (make-empty-ordered-table 0)))

(define (py-dict-from-scheme key-value-pairs)
  (py-dict-alloc (py-ordered-table-from-scheme key-value-pairs)))

(define (py-ordered-table-from-scheme key-value-pairs)
  (let* ((ordered-table (make-empty-ordered-table (length key-value-pairs)))
         (table-vector (ordered-table-table ordered-table)))
    (let loop ((key-value-pairs key-value-pairs))
      (if (null? key-value-pairs)
        ordered-table
        (let* ((pair (car key-value-pairs))
              (key (car pair))
              (value (cdr pair))
              (hash (py-instance-of-int-to-scheme (py-hash key))))
          (table-vector-set!
            ordered-table
            table-vector
            (vector-length table-vector)
            hash
            key
            value)
          (loop (cdr key-value-pairs)))))))

(define (dict-setitem self key value)
  (if (py-isinstance? self py-dict-class)
    (let ((ordered-table (PyObjectDict-value self)))
      (ordered-table-set-cell! ordered-table key value))
    (py-throw-not-a-type-object "dict.__setitem__" self))
  py-None)

(define dict.__setitem__
  (procedure->py-function
   dict-setitem
    (make-signature posonlyargs: (self key value))))

(define (dict-get self key default)
  (if (py-isinstance? self py-dict-class)
    (let ((ordered-table (PyObjectDict-value self)))
      (ordered-table-get ordered-table key (if (eq? default py-absent) py-None default)))
    (py-throw-not-a-type-object "dict.get" self)))

(define dict.get
  (procedure->py-function
    dict-get
    (make-signature posonlyargs: (self key default) defaults: (vector py-absent))))

(define (dict-getitem self key)
  (if (py-isinstance? self py-dict-class)
    (let ((ordered-table (PyObjectDict-value self)))
      (ordered-table-get ordered-table key py-absent))
    (py-throw-not-a-type-object "dict.__getitem__" self)))

(define dict.__getitem__
  (procedure->py-function
    dict-getitem
    (make-signature posonlyargs: (self key))))

(define (dict-delitem self key)
  (if (py-isinstance? self py-dict-class)
    (let* ((ordered-table (PyObjectDict-value self))
           (res (ordered-table-remove-key! ordered-table key)))
      (if (not res)
        (py-throw (py-call py-builtin-KeyError key))
        py-None))
    (py-throw-not-a-type-object "dict.__delitem__" self)))

(define dict.__delitem__
  (procedure->py-function
    dict-delitem
    (make-signature posonlyargs: (self key))))

(define (dict-len self)
  (if (py-isinstance? self py-dict-class)
    (let* ((ordered-table (PyObjectDict-value self))
           (len (ordered-table-length ordered-table)))
      (py-int-from-scheme len))
    (py-throw-not-a-type-object "dict.__len__" self)))

(define dict.__len__
  (procedure->py-function
    dict-len
    (make-signature posonlyargs: (self))))

(define (dict-iter self)
  (if (py-isinstance? self py-dict-class)
    (dict->dict-keyiterator self)
    (py-throw-not-a-type-object "dict.__len__" self)))

(define dict.__iter__
  (procedure->py-function
    dict-iter
    (make-signature posonlyargs: (self))))

;; TODO: incorrect implementation, should return a dict_keys object
(define (dict-keys self)
  (if (py-isinstance? self py-dict-class)
    (py-tuple-from-scheme
      (list->vector
        (iterator->list
          (dict->dict-keyiterator self))))
    (py-throw-not-a-type-object "dict.keys" self)))

(define dict.keys
  (procedure->py-function
    dict-keys
    (make-signature posonlyargs: (self))))

;; =============================================================================
;;  Dict iterators
;; =============================================================================

(define (dict-keyiterator-iter self)
  (if (PyObjectDictKeyIterator? self)
    self
    (py-throw-not-a-type-object "dict_keyiterator.__iter__" self)))

(define (dict->dict-keyiterator d)
  (let* ((ordered-table (PyObjectDict-value d))
        (first (ordered-table-first ordered-table))
        (token (ordered-table-iterator-token ordered-table)))
    (py-dict-keyiterator-alloc first token)))

(define dict_keyiterator.__iter__
  (procedure->py-function
    dict-keyiterator-iter
    (make-signature posonlyargs: (self))))

(define (dict-keyiterator-next self)
  (if (py-isinstance? self py-dict-keyiterator-class)
    (let ((node (PyObjectDictKeyIterator-node self))
          (token (PyObjectDictKeyIterator-iterator-token self)))
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
            (PyObjectDictKeyIterator-node-set! self next)
            key))))
    (py-throw-not-a-type-object "dict_keyiterator.__next__" self)))

(define dict_keyiterator.__next__
  (procedure->py-function
    dict-keyiterator-next
    (make-signature posonlyargs: (self))))

(define py-dict-keyiterator-class
  (py-make-builtin-class
    (&& "dict_keyiterator")
    (&& "builtins")
    (list)
    py-dict-keyiterator-hclass-of-instances
      (& "__iter__") dict_keyiterator.__iter__
      (& "__next__") dict_keyiterator.__next__))

;; -----------------------------------------------------------------------------

(define (bootstrap-type-hierarchy-phase2)
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
     py-module-hclass-of-instances
     (& "__dir__") module.__dir__))

  (set! py-int-class
    (py-make-builtin-class
     (&& "int")
     (&& "builtins")
     (list)
     py-int-hclass-of-instances
     (& "__new__") int.__new__
     (& "__bool__") int.__bool__
     (& "__add__") int.__add__
     (& "__sub__") int.__sub__
     (& "__mul__") int.__mul__
     (& "__floordiv__") int.__floordiv__
     (& "__and__") int.__and__
     (& "__lshift__") int.__lshift__
     (& "__rshift__") int.__rshift__
     (& "__mod__") int.__mod__
     (& "__or__") int.__or__
     (& "__pow__") int.__pow__
     (& "__xor__") int.__xor__
     (& "__iadd__") int.__iadd__
     (& "__isub__") int.__isub__
     (& "__imul__") int.__imul__
     (& "__ifloordiv__") int.__ifloordiv__
     (& "__iand__") int.__iand__
     (& "__ilshift__") int.__ilshift__
     (& "__irshift__") int.__irshift__
     (& "__imod__") int.__imod__
     (& "__ior__") int.__ior__
     (& "__ipow__") int.__ipow__
     (& "__ixor__") int.__ixor__
     (& "__eq__") int.__eq__
     (& "__ne__") int.__ne__
     (& "__lt__") int.__lt__
     (& "__le__") int.__le__
     (& "__gt__") int.__gt__
     (& "__ge__") int.__ge__
     (& "__neg__") int.__neg__
     (& "__pos__") int.__pos__
     (& "__invert__") int.__invert__
     (& "__abs__") int.__abs__
     (& "__hash__") int.__hash__
     (& "__truediv__") int.__truediv__
     (& "__itruediv__") int.__itruediv__
     (& "__repr__") int.__repr__
     ))

  ;; Pre-allocate ints from -5 to 256 and cache them
  (set! int-cache (make-int-cache))

  (set! py-float-class
    (py-make-builtin-class
     (&& "float")
     (&& "builtins")
     (list)
     py-float-hclass-of-instances
     (& "__new__") float.__new__
     (& "__repr__") float.__repr__
     (& "__add__") float.__add__
     (& "__radd__") float.__radd__
     (& "__sub__") float.__sub__
     (& "__rsub__") float.__rsub__
     (& "__mul__") float.__mul__
     (& "__rmul__") float.__rmul__
     (& "__pow__") float.__pow__
     (& "__rpow__") float.__rpow__
     (& "__eq__") float.__eq__
     (& "__ne__") float.__ne__
     (& "__lt__") float.__lt__
     (& "__le__") float.__le__
     (& "__gt__") float.__gt__
     (& "__ge__") float.__ge__
     (& "__truediv__") float.__truediv__
     (& "__rtruediv__") float.__rtruediv__
     (& "__floordiv__") float.__floordiv__
     (& "__rfloordiv__") float.__rfloordiv__
     (& "__mod__") float.__mod__
     (& "__rmod__") float.__rmod__

     (& "__neg__") float.__neg__
     (& "__pos__") float.__pos__
     (& "__abs__") float.__abs__
     (& "__bool__") float.__bool__

     (& "__float__") float.__float__
     (& "__int__") float.__int__
     (& "__round__") float.__round__
     (& "__trunc__") float.__trunc__
     (& "conjugate") float.conjugate
     (& "is_integer") float.is_integer

     ))

  (set! py-bool-class
    (py-make-builtin-class
     (&& "bool")
     (&& "builtins")
     (list py-int-class)
     py-int-hclass-of-instances
     (& "__new__") bool.__new__
     (& "__str__") bool.__str__
     (& "__repr__") bool.__repr__))

  (set! py-complex-class
    (py-make-builtin-class
     (& "complex")
     (& "builtins")
     (list)
     py-complex-hclass-of-instances))

  (set! py-slice-class
    (py-make-builtin-class
     (&& "slice")
     (&& "builtins")
     (list)
     py-slice-hclass-of-instances
     (& "__new__") slice.__new__
     (& "indices") slice.indices))

  (set! py-method-class
    (py-make-builtin-class
     (&& "method")
     (&& "builtins")
     (list)
     py-method-hclass-of-instances
     (& "__call__") method.__call__))

  (set! py-function-class
    (py-make-builtin-class
     (&& "function")
     (&& "builtins")
     (list)
     py-function-hclass-of-instances
     (& "__call__") function.__call__
     (& "__get__") function.__get__))

  (set! py-list-class
    (py-make-builtin-class
     (&& "list")
     (&& "builtins")
     (list)
     py-list-hclass-of-instances
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
     py-dict-hclass-of-instances
     (& "__getitem__") dict.__getitem__
     (& "__setitem__") dict.__setitem__
     (& "__delitem__") dict.__delitem__
     (& "__len__") dict.__len__
     (& "__iter__") dict.__iter__
     (& "keys") dict.keys
     (& "get") dict.get
     ))

  (set! py-set-class
    (py-make-builtin-class
     (&& "set")
     (&& "builtins")
     (list)
     py-set-hclass-of-instances))

  (set! py-bytearray-class
    (py-make-builtin-class
      (&& "bytearray")
      (&& "builtins")
      (list)
      py-set-hclass-of-instances
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
(bootstrap-functions)

;; Save low ints for fast access
(define py-int-0 (py-int-from-scheme 0))
(define py-int-1 (py-int-from-scheme 1))
(define py-int-2 (py-int-from-scheme 2))
(define py-int-3 (py-int-from-scheme 3))
(define py-int-4 (py-int-from-scheme 4))

;; =============================================================================
;;  IO
;; =============================================================================
;; TODO: some content of this section should be moved to the io module

(define (TextIOWrapper-enter self)
  (if (py-isinstance? self py-TextIOWrapper-class)
    self
    (py-throw-not-a-type-object "TextIOWrapper.__enter__" self)))

(define TextIOWrapper.__enter__
  (procedure->py-function
    TextIOWrapper-enter
    (make-signature posonlyargs: (self))))

(define (TextIOWrapper-close-port! self)
  (let ((port (PyObjectTextIOWrapper-port self)))
    ;; Some ports may stay open even after close-port, by dereferencing
    ;; the port we make sure its ressources are freed by the gc
    ;; we thus have to first check the port was not already closed (ie. set to #f)
    ;; and then we fully close it by setting the port attribute to #f
    (if port
      (begin
        (close-port port)
        (PyObjectTextIOWrapper-port-set! self #f)))))

(define (TextIOWrapper-exit self exc-type exc exc-traceback)
  (if (py-isinstance? self py-TextIOWrapper-class)
    (TextIOWrapper-close-port! self)
    (py-throw-not-a-type-object "TextIOWrapper.__exit__" self))
  py-None)

(define TextIOWrapper.__exit__
  (procedure->py-function
    TextIOWrapper-exit
    (make-signature posonlyargs: (self exc_type exc_value traceback))))

(define (TextIOWrapper-close self)
  (if (py-isinstance? self py-TextIOWrapper-class)
    (TextIOWrapper-close-port! self)
    (py-throw-not-a-type-object "TextIOWrapper.close" self))
  py-None)

(define TextIOWrapper.close
  (procedure->py-function
    TextIOWrapper-close
    (make-signature posonlyargs: (self))))

(define (TextIOWrapper-read self)
  (if (py-isinstance? self py-TextIOWrapper-class)
    (let ((port (PyObjectTextIOWrapper-port self)))
      (if port
          (py-str-from-scheme (read-string port))
        (py-throw-exception-with-message
          py-builtin-ValueError
          "I/O operation on closed file.")))
    (py-throw-not-a-type-object "TextIOWrapper.read" self)))

(define TextIOWrapper.read
  (procedure->py-function
    TextIOWrapper-read
    (make-signature posonlyargs: (self))))

(define py-TextIOWrapper-class
  (py-make-builtin-class
    (&& "TextIOWrapper")
    (&& "_io")
    ;; TODO: the correct mro is actually [<class '_io.TextIOWrapper'>, <class '_io._TextIOBase'>, <class '_io._IOBase'>, <class 'object'>]
    (list)
    py-TextIOWrapper-hclass-of-instances
      (& "__enter__") TextIOWrapper.__enter__
      (& "__exit__") TextIOWrapper.__exit__
      (& "close") TextIOWrapper.close
      (& "read") TextIOWrapper.read))

;; TODO: arguments other than file are currentl ignored
(define (py-open file mode buffering encoding errors newline closefd opener)
  (cond
    ((py-isinstance? file py-str-class)
      (let ((filename (PyObjectStr-value file)))
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

(define py-True
  (py-int-subtype-from-scheme 1 py-bool-class))

(define py-False
  (py-int-subtype-from-scheme 0 py-bool-class))

;; NotImplemented object

(define (NotImplementedType-new cls)
  (if (eq? cls py-NotImplementedType-class)
    py-NotImplemented
    (py-throw
      (py-call
        py-builtin-TypeError
        ;; TODO: Incorrect error message
        (&& "not a subtype of NotImplementedType")))))

(define NotImplementedType.__new__
  (procedure->py-function
    NotImplementedType-new
    (make-signature posonlyargs: (cls))))

(define (NotImplementedType-repr self)
  (if (eq? self py-NotImplemented)
    (&& "NotImplemented")
    (py-throw
      (py-call
        py-builtin-TypeError
        ;; TODO: Incorrect error message
        (&& "descriptor '__repr__' requires a 'NotImplementedType' object")))))

(define NotImplementedType.__repr__
  (procedure->py-function
    NotImplementedType-repr
    (make-signature posonlyargs: (self))))

(define py-NotImplementedType-class
  (py-make-builtin-class
    (&& "NotImplementedType")
    (&& "builtins")
    (list)
    py-object-hclass-of-instances
      (& "__new__") NotImplementedType.__new__
      (& "__repr__") NotImplementedType.__repr__))

(define py-NotImplemented
  (py-obj-alloc
    py-NotImplementedType-class
    py-object-hclass-of-instances))

;; None object

(define (NoneType-new cls)
  (if (eq? cls py-NoneType-class)
    py-None
    (py-throw
      (py-call
        py-builtin-TypeError
        ;; TODO: Incorrect error message
        (&& "not a subtype of NoneType")))))

(define NoneType.__new__
  (procedure->py-function
    NoneType-new
    (make-signature posonlyargs: (cls))))

(define (NoneType-repr self)
  (if (eq? self py-None)
    (&& "None")
    (py-throw
      (py-call
        py-builtin-TypeError
        ;; TODO: Incorrect error message
        (&& "descriptor '__repr__' requires a 'NoneType' object")))))

(define NoneType.__repr__
  (procedure->py-function
    NoneType-repr
    (make-signature posonlyargs: (self))))

(define (NoneType-bool self)
  (if (eq? self py-None)
    py-False
    (py-throw
      (py-call
        py-builtin-TypeError
        ;; TODO: Incorrect error message
        (&& "descriptor '__repr__' requires a 'NoneType' object")))))

(define NoneType.__bool__
  (procedure->py-function
    NoneType-bool
    (make-signature posonlyargs: (self))))

(define py-NoneType-class
  (py-make-builtin-class
    (&& "NoneType")
    (&& "builtins")
    (list)
    py-object-hclass-of-instances
      (& "__new__") NoneType.__new__
      (& "__repr__") NoneType.__repr__
      (& "__bool__") NoneType.__bool__))

(define py-None
  (py-obj-alloc
    py-NoneType-class
    py-object-hclass-of-instances))

;;;----------------------------------------------------------------------------

(define (py-make-set elements)
  (py-set-from-scheme elements))

(define (py-make-tuple . elements)
  (py-tuple-from-scheme (list->vector elements)))

(define (py-tuple-from-scheme elements)
  (make-PyObjectTuple
    py-tuple-hclass-of-instances
    (make-vector
      (vector-length (HClass-names py-tuple-hclass-of-instances))
      py-absent)
    py-tuple-class
    elements))

(define (py-tuple-subtype-from-scheme elements cls)
  (make-PyObjectTuple
    py-tuple-hclass-of-instances
    (make-vector
      (vector-length (HClass-names py-tuple-hclass-of-instances))
      py-absent)
    cls
    elements))

(define py-make-dict py-dict-from-scheme)

(define (py-type obj)
  (py-obj-cls obj))

;; ----------------------
;; builtins initialization
;; ---------------------

(define builtins-mod py-absent)

(define (py-make-global)
  (let ((mod
         (py-obj-alloc
          py-module-class
          py-module-hclass-of-instances)))
    (PyObject-class-set! mod py-module-class)
    (py-own-attr-set! mod (& "__builtins__") builtins-mod)
    mod))

(define (py-make-module name)
  (let ((mod (py-make-global)))
   (py-own-attr-set! mod (& "__name__") name)
   (dict-setitem (sys.modules-get) name mod)
   mod))

;; ===========================================
;; IMPORT SYSTEM
;; ===========================================


(define zipi-stdlib-dir (path-expand "stdlib" (getenv "ZIPIROOT" "~~zipidir")))

(define (py-make-sys-mod)
  (let ((mod (py-make-global)))
   (py-own-attr-set! mod (& "__name__") (&& "sys"))
   (py-own-attr-set! mod (& "modules")
                     (py-make-dict
                       (list
                         (cons (&& "sys") mod))))

   (py-own-attr-set! mod (& "path")
                     (py-make-list
                           (py-str-from-scheme zipi-stdlib-dir)))
       mod))

(define sys-mod (py-make-sys-mod))

(define (sys.modules-get)
  (py-own-attr-ref sys-mod (& "modules")))

(define (sys.path-get)
  (py-own-attr-ref sys-mod (& "path")))

;; == CACHE SYSTEM ==

;; WARNING : dont change this location without knowing what you do because (delete-zipi-cache) in run-zipi recursively deletes this directory
(define (cache-location) (path-expand "~~zipicache/cache@zipi_0_0_1"))

(define compile-flag #f)
(define (compile-flag-set! value)
  (set! compile-flag value))

(define debug-flag #f)
(define (debug-flag-set! value)
  (set! debug-flag value))

(define profile-flag #f)
(define (profile-flag-set! value)
  (set! profile-flag value))

(module-search-order-add! (cache-location))

(define (ensure-parent-dir-exists path)

  (define (wind path todo)
    (let* ((dir (path-strip-trailing-directory-separator
                  (path-directory path)))
           (fi (with-exception-catcher
                 (lambda (exc) #f)
                 (lambda () (file-info dir)))))
      (if fi
          (if (eq? (file-info-type fi) 'directory)
              (unwind todo)
              (error (string-append "directory component can't be created: " fi)))
          (wind dir (cons dir todo)))))

  (define (unwind todo)
    (if (pair? todo)
        (begin
          (create-directory (car todo))
          (unwind (cdr todo)))))

  (wind path '()))


(define (compile-to-cache path path-info)
  (let* ((path-cache
           (string-append
             (cache-location)
             (path-strip-extension path)
             "/"
             (path-strip-extension (path-strip-directory path))
             ".sld"))
         (path-cache-info (file-info path-cache #t #f)))

    (define (create-_must-build_)
      ;; create empty "._must-build_" file
      (if compile-flag
          (let ((_must-build_-path
                  (string-append (path-strip-extension path-cache) "._must-build_")))
            (if compile-flag
                (with-output-to-file _must-build_-path list)
                (delete-file _must-build_-path)))))

    ;; compile file and return #f if compilation failed
    (define (compile)
      (ensure-parent-dir-exists path-cache)
      (create-_must-build_)
      (fx= 0 (compile-source path path-cache)))

    (if path-cache-info
        ;; check according to modified date
        (if (< (time->seconds (file-info-last-modification-time path-info))
               (time->seconds (file-info-last-modification-time path-cache-info)))
            (begin
              (possible-error 1 "skipping compilation of unmodified file at " path ", compiled file found : " path-cache "\n")
              (create-_must-build_)
              #t) ;; compilation "successful" (file already compiled)
            (compile))
        (compile)))) ;; compiled file does not exist (must compile)

(define (compile-and-get-mod path path-info py-__name__)
  (let ((mod-init
          (and
            (compile-to-cache path path-info)
            ;; TODO : for windows user, the path is not formated with a / before
            (load-module-and-get-init
              (substring path 1 (string-length (path-strip-extension path)))))))
    (if mod-init
        (mod-init py-__name__)
        #f)))

(define (import-with-zipi-cache path py-__name__)
  (let* ((path-package (path-expand "__init__.py" path))
         (path-package-info (file-info path-package #t #f)))
    (if path-package-info
        (let ((mod (compile-and-get-mod path-package path-package-info py-__name__)))
         (py-own-attr-set! mod (& "__path__") (py-make-list (py-str-from-scheme path)))
         mod)
        (let* ((path-mod (string-append path ".py"))
               (path-mod-info (file-info path-mod #t #f)))
          (if path-mod-info
              (compile-and-get-mod path-mod path-mod-info py-__name__)
              #f)))))

(define (import-from-sys.path sys.path __name__ py-__name__)
  (or (dict-get (sys.modules-get) py-__name__ #f)
      (let ((sys.path-iter (py-iter sys.path)))
       (let loop ((value sys.path-iter))
        (let ((value (py-next value)))
         (if value
             (if (py-isinstance? value py-str-class) ;; TODO : support bytes
                 (let ((path (string-append
                               (path-normalize (str-force! value))
                               __name__)))
                   (or (import-with-zipi-cache path py-__name__)
                       (loop sys.path-iter)))
                 (loop sys.path-iter))
             #f))))))

(define (default-builtin-__import__ __name__)
   (let ((name-split (string-split __name__ #\.)))
   (let loop ((sys.path (sys.path-get))
              (name-split name-split)
              (name-cumulative (car name-split))
              (last-module #f))
     (let ((module (import-from-sys.path sys.path (car name-split) (py-str-from-scheme name-cumulative))))
      (if (and module (py-isinstance? module py-module-class))
          (begin
            (if last-module
                (py-own-attr-set! last-module (py-str-from-scheme (car name-split)) module))
            (if (pair? (cdr name-split))
                (let ((module.__path__ (py-own-attr-ref module (& "__path__"))))
                 (if (eq? py-absent module.__path__)
                     (py-throw-exception-with-message
                       py-builtin-ModuleNotFoundError
                       "No module named '" __name__ "'; " (car name-split) " is not a package")
                     (loop module.__path__
                           (cdr name-split)
                           (string-append name-cumulative "." (cadr name-split))
                           module)))
                module))
          (py-throw-exception-with-message
            py-builtin-ModuleNotFoundError
            "No module named '" __name__ "'"))))))

(define (builtin-__import__ __name__)
   (or (native-builtin-__import__ __name__)
       (default-builtin-__import__ __name__)))

(define (py-import path depth)
  (builtin-__import__ path))

(define (run-as-main path)
  (build-builtins)
  (let ((sys.modules (sys.modules-get)))
   (list-append (sys.path-get) (py-str-from-scheme (path-directory path)))
   (with-exception-catcher
     (lambda (e) (if (PyObject? e) (print-exception e) (raise e)))
     (lambda ()
      (if profile-flag
        (let ((profile-dir
                (py-str-from-scheme
                  (path-expand "__main__.profile" (current-directory)))))
          (statprof-begin)
          (compile-and-get-mod path (file-info path) (& "__main__"))
          (statprof-end profile-dir))
        (compile-and-get-mod path (file-info path) (& "__main__")))))))

(define py-import-root (current-directory))


;; MODULES


;; time

(define time.time
  (procedure->py-function
    (lambda ()
      (py-float-from-scheme (time->seconds (current-time))))
    (make-signature)))

(define (make-time-mod)
  (let ((mod (py-make-module (&& "time"))))
   (py-own-attr-set! mod (& "time") time.time)))

(make-time-mod)

;; statprof

(define statprof.begin
  (procedure->py-function
    statprof-begin
    (make-signature)))

(define statprof.end
  (procedure->py-function
    statprof-end
    (make-signature posonlyargs: (file))))

(define (make-statprof-mod)
  (let ((mod (py-make-module (&& "statprof"))))
   (py-own-attr-set! mod (& "begin") statprof.begin)
   (py-own-attr-set! mod (& "end") statprof.end)))

(make-statprof-mod)

;; ===========================================
;; BUITLINS
;; ===========================================

;;-------------------- abs(x)

;; Return the absolute value of a number. The argument may be an
;; integer or a floating point number. If the argument is a complex
;; number, its magnitude is returned. If x defines __abs__(), abs(x)
;; returns x.__abs__().

(define py-builtin-abs
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

(define py-builtin-all
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

(define py-builtin-any
  (procedure->py-function
    (lambda (iterable)
      (py-throw-exception-with-message py-builtin-NotImplementedError "any not implemented"))
    (make-signature posonlyargs: (iterable))))

;;-------------------- ascii(object)

;; As repr(), return a string containing a printable representation of an
;; object, but escape the non-ASCII characters in the string returned by
;; repr() using \x, \u or \U escapes. This generates a string similar to
;; that returned by repr() in Python 2.

(define py-builtin-ascii
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

(define py-builtin-bin
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

(define py-builtin-bool py-bool-class)

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

(define py-builtin-breakpoint
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

(define py-builtin-bytearray py-bytearray-class)
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

(define py-builtin-bytes
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

(define py-builtin-callable
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

(define py-builtin-chr
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

(define py-builtin-classmethod
  (procedure->py-function
    (lambda (function)
      (py-throw-exception-with-message py-builtin-NotImplementedError "classmethod not implemented"))
    (make-signature posonlyargs: (function))))

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

(define py-builtin-compile
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

(define py-builtin-complex py-complex-class)

;;-------------------- delattr(object, name)

;; This is a relative of setattr(). The arguments are an object and a
;; string. The string must be the name of one of the object’s
;; attributes. The function deletes the named attribute, provided the
;; object allows it. For example, delattr(x, 'foobar') is equivalent to
;; del x.foobar.

(define py-builtin-delattr
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

(define py-builtin-dict py-dict-class)

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

(define py-builtin-dir
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

(define py-builtin-divmod
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

(define py-builtin-enumerate
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

(define py-builtin-eval
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

(define py-builtin-exec
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

(define py-builtin-filter
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

(define py-builtin-float py-float-class)

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

(define py-builtin-format
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

(define py-builtin-frozenset
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

(define py-builtin-getattr
  (procedure->py-function
    (lambda (object name default)
      (if (py-isinstance? name py-str-class)
        (if (not (eq? default py-absent))
          (with-handler
            (lambda (exc)
              (if (and
                    (PyObject? exc)
                    (py-isinstance? exc py-builtin-AttributeError))
                default
                (raise exc)))
            (py-getattribute object name))
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

(define py-builtin-globals
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
(define py-builtin-hasattr
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

(define py-builtin-hash
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

(define py-builtin-help
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

(define py-builtin-hex
  (procedure->py-function
    (lambda (x)
      (py-throw-exception-with-message py-builtin-NotImplementedError "hex not implemented"))
    (make-signature posonlyargs: (x))))

;;-------------------- id(object)

;; Return the “identity” of an object. This is an integer which is
;; guaranteed to be unique and constant for this object during its
;; lifetime. Two objects with non-overlapping lifetimes may have the same
;; id() value.
;;
;; CPython implementation detail: This is the address of the object in
;; memory.

(define py-builtin-id
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

(define py-builtin-input
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

(define py-builtin-int py-int-class)

;;-------------------- isinstance(object, classinfo)

;; Return true if the object argument is an instance of the classinfo
;; argument, or of a (direct, indirect or virtual) subclass thereof. If
;; object is not an object of the given type, the function always returns
;; false. If classinfo is a tuple of type objects (or recursively, other
;; such tuples), return true if object is an instance of any of the
;; types. If classinfo is not a type or tuple of types and such tuples, a
;; TypeError exception is raised.

(define py-builtin-isinstance
  (procedure->py-function
    (lambda (object classinfo)
      (if (py-isinstance? object classinfo) py-True py-False))
    (make-signature posonlyargs: (object classinfo))))

;;-------------------- issubclass(class, classinfo)

;; Return true if class is a subclass (direct, indirect or virtual) of
;; classinfo. A class is considered a subclass of itself. classinfo may
;; be a tuple of class objects, in which case every entry in classinfo
;; will be checked. In any other case, a TypeError exception is raised.

(define py-builtin-issubclass
  (procedure->py-function
    (lambda (object classinfo)
      (py-throw-exception-with-message py-builtin-NotImplementedError "issubclass not implemented"))
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

(define py-builtin-iter
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

(define py-builtin-len
  (procedure->py-function
    py-len
    (make-signature posonlyargs: (obj))))

;;-------------------- class list([iterable])

;; Rather than being a function, list is actually a mutable sequence
;; type, as documented in Lists and Sequence Types — list, tuple, range.

(define py-builtin-list py-list-class)

;;-------------------- locals()

;; Update and return a dictionary representing the current local symbol
;; table. Free variables are returned by locals() when it is called in
;; function blocks, but not in class blocks. Note that at the module
;; level, locals() and globals() are the same dictionary.
;;
;; Note The contents of this dictionary should not be modified; changes
;; may not affect the values of local and free variables used by the
;; interpreter.

(define py-builtin-locals
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

(define py-builtin-map
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

(define py-builtin-max
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

(define py-builtin-memoryview
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

(define py-builtin-min
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

(define py-builtin-next
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

(define py-builtin-object py-object-class)

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

(define py-builtin-oct
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

(define py-builtin-open
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

(define py-builtin-ord
  (procedure->py-function
    (lambda (c)
      (py-int-from-scheme 0)) ;; dummy implementation for testing
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

(define py-builtin-pow
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

(define py-builtin-print
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

(define py-builtin-property
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

(define py-builtin-range
  (procedure->py-function
    (lambda (arg1 arg2 arg3)
      (py-throw-exception-with-message py-builtin-NotImplementedError "range unimplemented generic procedure for builtin"))
    (make-signature
      posonlyargs: (arg1 arg2 arg3)
      defaults: (vector py-absent py-absent))))

(define py-builtin-range_iterator #f)

;;-------------------- repr(object)

;; Return a string containing a printable representation of an
;; object. For many types, this function makes an attempt to return a
;; string that would yield an object with the same value when passed to
;; eval(), otherwise the representation is a string enclosed in angle
;; brackets that contains the name of the type of the object together
;; with additional information often including the name and address of
;; the object. A class can control what this function returns for its
;; instances by defining a __repr__() method.

(define py-builtin-repr
  (procedure->py-function
    py-repr
    (make-signature posonlyargs: (repr))))

;;-------------------- reversed(seq)

;; Return a reverse iterator. seq must be an object which has a
;; __reversed__() method or supports the sequence protocol (the __len__()
;; method and the __getitem__() method with integer arguments starting at
;; 0).

(define py-builtin-reversed
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

(define py-builtin-round
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

(define py-builtin-set py-set-class)

;;-------------------- setattr(object, name, value)

;; This is the counterpart of getattr(). The arguments are an object, a
;; string and an arbitrary value. The string may name an existing
;; attribute or a new attribute. The function assigns the value to the
;; attribute, provided the object allows it. For example, setattr(x,
;; 'foobar', 123) is equivalent to x.foobar = 123.

(define py-builtin-setattr
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

(define py-builtin-slice py-slice-class)

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

(define py-builtin-sorted
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

(define py-builtin-staticmethod
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

(define py-builtin-str py-str-class)

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

(define py-builtin-sum
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

(define (py-flag-super-called-without-arguments)
  'super-called-without-arguments
)

(define (super-init self type object)
  (cond ((eq? type py-absent)
          (raise (py-flag-super-called-without-arguments)))
        ((eq? object py-absent)
          (error "super not implemented for 1 argument"))
        (else
          (begin
            (py-own-attr-set! self (& "__thisclass__") type)
            (py-own-attr-set! self (& "__self__") object)))))

(define super.__init__
  (procedure->py-function
    super-init
    (make-signature
      posonlyargs: (self type object)
      defaults: (vector py-absent py-absent))))

(define (super-getattribute self name)
  (if (eq? (str-representative-get name) (& "__class__"))
    py-builtin-super
    (let* ((this-class (py-own-attr-ref self (& "__thisclass__")))
          (this-self (py-own-attr-ref self (& "__self__")))
          (mro (PyObjectType-mro this-class))
          (parent-cls (vector-ref mro 1)))
      (receive (attr owner) (getattribute-from-cls-mro-with-owner parent-cls name)
          (if (eq? attr py-absent)
            (object-getattribute self name)
            (object-get-bind-descriptor attr this-self owner))))))

(define super.__getattribute__
  (procedure->py-function
    super-getattribute
    (make-signature posonlyargs: (self name))))

(define py-builtin-super
  (py-make-builtin-class
    (&& "super")
    (&& "builtins")
    (list)
    py-super-hclass-of-instances
      (& "__init__") super.__init__
      (& "__getattribute__") super.__getattribute__
    ))

;;-------------------- tuple([iterable])

;; Rather than being a function, tuple is actually an immutable sequence
;; type, as documented in Tuples and Sequence Types — list, tuple, range.

(define py-builtin-tuple py-tuple-class)

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

(define py-builtin-type py-type-class)

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

(define py-builtin-vars
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

(define py-builtin-zip
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

(define py-builtin-__import__
  (procedure->py-function
   (lambda (name globals locals fromlist level)
     (cond
      ((eq? globals py-None)
       (if (py-isinstance? name py-str-class)
           (builtin-__import__ (str-force! name))
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

(define py-builtin-ArithmeticError #f)
(define py-builtin-AssertionError #f)
(define py-builtin-AttributeError #f)
(define py-builtin-BaseException #f)
(define py-builtin-BlockingIOError #f)
(define py-builtin-BrokenPipeError #f)
(define py-builtin-BufferError #f)
(define py-builtin-BytesWarning #f)
(define py-builtin-ChildProcessError #f)
(define py-builtin-ConnectionAbortedError #f)
(define py-builtin-ConnectionError #f)
(define py-builtin-ConnectionRefusedError #f)
(define py-builtin-ConnectionResetError #f)
(define py-builtin-DeprecationWarning #f)
(define py-builtin-EOFError #f)
(define py-builtin-EnvironmentError #f)
(define py-builtin-Exception #f)
(define py-builtin-FileExistsError #f)
(define py-builtin-FileNotFoundError #f)
(define py-builtin-FloatingPointError #f)
(define py-builtin-FutureWarning #f)
(define py-builtin-GeneratorExit #f)
(define py-builtin-IOError #f)
(define py-builtin-ImportError #f)
(define py-builtin-ImportWarning #f)
(define py-builtin-IndentationError #f)
(define py-builtin-IndexError #f)
(define py-builtin-InterruptedError #f)
(define py-builtin-IsADirectoryError #f)
(define py-builtin-KeyError #f)
(define py-builtin-KeyboardInterrupt #f)
(define py-builtin-LookupError #f)
(define py-builtin-MemoryError #f)
(define py-builtin-ModuleNotFoundError #f)
(define py-builtin-NameError #f)
(define py-builtin-NotADirectoryError #f)
(define py-builtin-NotImplementedError #f)
(define py-builtin-OSError #f)
(define py-builtin-OverflowError #f)
(define py-builtin-PendingDeprecationWarning #f)
(define py-builtin-PermissionError #f)
(define py-builtin-ProcessLookupError #f)
(define py-builtin-RecursionError #f)
(define py-builtin-ReferenceError #f)
(define py-builtin-ResourceWarning #f)
(define py-builtin-RuntimeError #f)
(define py-builtin-RuntimeWarning #f)
(define py-builtin-StopAsyncIteration #f)
(define py-builtin-StopIteration #f)
(define py-builtin-SyntaxError #f)
(define py-builtin-SyntaxWarning #f)
(define py-builtin-SystemError #f)
(define py-builtin-SystemExit #f)
(define py-builtin-TabError #f)
(define py-builtin-TimeoutError #f)
(define py-builtin-TypeError #f)
(define py-builtin-UnboundLocalError #f)
(define py-builtin-UnicodeDecodeError #f)
(define py-builtin-UnicodeEncodeError #f)
(define py-builtin-UnicodeError #f)
(define py-builtin-UnicodeTranslateError #f)
(define py-builtin-UnicodeWarning #f)
(define py-builtin-UserWarning #f)
(define py-builtin-ValueError #f)
(define py-builtin-Warning #f)
(define py-builtin-ZeroDivisionError #f)

;; Exception Helpers


;; TODO: use Zipi print instead of calling __str__ manually
;; error message should just be print(exc.__name__, ": ", exc)
;; TODO: print that to stderr
(define (print-exception exc)
  (let ((exc-name (getattribute-from-obj-mro exc (& "__name__")))
        (out (current-output-port))
        (__str__ (getattribute-from-obj-mro exc (& "__str__"))))
    (py-display exc-name out)
    (let ((str-exc (py-call __str__ exc)))
      (if (> (string-length (py-str-to-scheme str-exc)) 0)
        (begin
          (display ": " out)
          (py-display str-exc out))))
    (display "\n" out)))

;;==============================================================================
;; BUILTINS
;;==============================================================================

;; Once builtins.py is loaded, we need to keep a direct access to some builtins
;; Examples are exceptions which are part of Python protocols, such as StopIteration
(define (bootstrap-builtins builtins-mod)
  ;; builtin functions
  (set! py-builtin-sorted (py-own-attr-ref builtins-mod (& "sorted")))

  ;; Exceptions
  (set! py-builtin-ArithmeticError (py-own-attr-ref builtins-mod (& "ArithmeticError")))
  (set! py-builtin-AssertionError (py-own-attr-ref builtins-mod (& "AssertionError")))
  (set! py-builtin-AttributeError (py-own-attr-ref builtins-mod (& "AttributeError")))
  (set! py-builtin-BaseException (py-own-attr-ref builtins-mod (& "BaseException")))
  (set! py-builtin-BlockingIOError (py-own-attr-ref builtins-mod (& "BlockingIOError")))
  (set! py-builtin-BrokenPipeError (py-own-attr-ref builtins-mod (& "BrokenPipeError")))
  (set! py-builtin-BufferError (py-own-attr-ref builtins-mod (& "BufferError")))
  (set! py-builtin-BytesWarning (py-own-attr-ref builtins-mod (& "BytesWarning")))
  (set! py-builtin-ChildProcessError (py-own-attr-ref builtins-mod (& "ChildProcessError")))
  (set! py-builtin-ConnectionAbortedError (py-own-attr-ref builtins-mod (& "ConnectionAbortedError")))
  (set! py-builtin-ConnectionError (py-own-attr-ref builtins-mod (& "ConnectionError")))
  (set! py-builtin-ConnectionRefusedError (py-own-attr-ref builtins-mod (& "ConnectionRefusedError")))
  (set! py-builtin-ConnectionResetError (py-own-attr-ref builtins-mod (& "ConnectionResetError")))
  (set! py-builtin-DeprecationWarning (py-own-attr-ref builtins-mod (& "DeprecationWarning")))
  (set! py-builtin-EOFError (py-own-attr-ref builtins-mod (& "EOFError")))
  (set! py-builtin-EnvironmentError (py-own-attr-ref builtins-mod (& "EnvironmentError")))
  (set! py-builtin-Exception (py-own-attr-ref builtins-mod (& "Exception")))
  (set! py-builtin-FileExistsError (py-own-attr-ref builtins-mod (& "FileExistsError")))
  (set! py-builtin-FileNotFoundError (py-own-attr-ref builtins-mod (& "FileNotFoundError")))
  (set! py-builtin-FloatingPointError (py-own-attr-ref builtins-mod (& "FloatingPointError")))
  (set! py-builtin-FutureWarning (py-own-attr-ref builtins-mod (& "FutureWarning")))
  (set! py-builtin-GeneratorExit (py-own-attr-ref builtins-mod (& "GeneratorExit")))
  (set! py-builtin-IOError (py-own-attr-ref builtins-mod (& "IOError")))
  (set! py-builtin-ImportError (py-own-attr-ref builtins-mod (& "ImportError")))
  (set! py-builtin-ImportWarning (py-own-attr-ref builtins-mod (& "ImportWarning")))
  (set! py-builtin-IndentationError (py-own-attr-ref builtins-mod (& "IndentationError")))
  (set! py-builtin-IndexError (py-own-attr-ref builtins-mod (& "IndexError")))
  (set! py-builtin-InterruptedError (py-own-attr-ref builtins-mod (& "InterruptedError")))
  (set! py-builtin-IsADirectoryError (py-own-attr-ref builtins-mod (& "IsADirectoryError")))
  (set! py-builtin-KeyError (py-own-attr-ref builtins-mod (& "KeyError")))
  (set! py-builtin-KeyboardInterrupt (py-own-attr-ref builtins-mod (& "KeyboardInterrupt")))
  (set! py-builtin-LookupError (py-own-attr-ref builtins-mod (& "LookupError")))
  (set! py-builtin-MemoryError (py-own-attr-ref builtins-mod (& "MemoryError")))
  (set! py-builtin-ModuleNotFoundError (py-own-attr-ref builtins-mod (& "ModuleNotFoundError")))
  (set! py-builtin-NameError (py-own-attr-ref builtins-mod (& "NameError")))
  (set! py-builtin-NotADirectoryError (py-own-attr-ref builtins-mod (& "NotADirectoryError")))
  (set! py-builtin-NotImplementedError (py-own-attr-ref builtins-mod (& "NotImplementedError")))
  (set! py-builtin-OSError (py-own-attr-ref builtins-mod (& "OSError")))
  (set! py-builtin-OverflowError (py-own-attr-ref builtins-mod (& "OverflowError")))
  (set! py-builtin-PendingDeprecationWarning (py-own-attr-ref builtins-mod (& "PendingDeprecationWarning")))
  (set! py-builtin-PermissionError (py-own-attr-ref builtins-mod (& "PermissionError")))
  (set! py-builtin-ProcessLookupError (py-own-attr-ref builtins-mod (& "ProcessLookupError")))
  (set! py-builtin-RecursionError (py-own-attr-ref builtins-mod (& "RecursionError")))
  (set! py-builtin-ReferenceError (py-own-attr-ref builtins-mod (& "ReferenceError")))
  (set! py-builtin-ResourceWarning (py-own-attr-ref builtins-mod (& "ResourceWarning")))
  (set! py-builtin-RuntimeError (py-own-attr-ref builtins-mod (& "RuntimeError")))
  (set! py-builtin-RuntimeWarning (py-own-attr-ref builtins-mod (& "RuntimeWarning")))
  (set! py-builtin-StopAsyncIteration (py-own-attr-ref builtins-mod (& "StopAsyncIteration")))
  (set! py-builtin-StopIteration (py-own-attr-ref builtins-mod (& "StopIteration")))
  (set! py-builtin-SyntaxError (py-own-attr-ref builtins-mod (& "SyntaxError")))
  (set! py-builtin-SyntaxWarning (py-own-attr-ref builtins-mod (& "SyntaxWarning")))
  (set! py-builtin-SystemError (py-own-attr-ref builtins-mod (& "SystemError")))
  (set! py-builtin-SystemExit (py-own-attr-ref builtins-mod (& "SystemExit")))
  (set! py-builtin-TabError (py-own-attr-ref builtins-mod (& "TabError")))
  (set! py-builtin-TimeoutError (py-own-attr-ref builtins-mod (& "TimeoutError")))
  (set! py-builtin-TypeError (py-own-attr-ref builtins-mod (& "TypeError")))
  (set! py-builtin-UnboundLocalError (py-own-attr-ref builtins-mod (& "UnboundLocalError")))
  (set! py-builtin-UnicodeDecodeError (py-own-attr-ref builtins-mod (& "UnicodeDecodeError")))
  (set! py-builtin-UnicodeEncodeError (py-own-attr-ref builtins-mod (& "UnicodeEncodeError")))
  (set! py-builtin-UnicodeError (py-own-attr-ref builtins-mod (& "UnicodeError")))
  (set! py-builtin-UnicodeTranslateError (py-own-attr-ref builtins-mod (& "UnicodeTranslateError")))
  (set! py-builtin-UnicodeWarning (py-own-attr-ref builtins-mod (& "UnicodeWarning")))
  (set! py-builtin-UserWarning (py-own-attr-ref builtins-mod (& "UserWarning")))
  (set! py-builtin-ValueError (py-own-attr-ref builtins-mod (& "ValueError")))
  (set! py-builtin-Warning (py-own-attr-ref builtins-mod (& "Warning")))
  (set! py-builtin-ZeroDivisionError (py-own-attr-ref builtins-mod (& "ZeroDivisionError")))

  ;; Reuse sorted procedure for list.sort
  (set! list.sort
    (procedure->py-function
      (lambda (self key reversed)
        (PyObjectList-value-set!
          self
          (PyObjectList-value
            ((PyObjectFunction-procedure py-builtin-sorted)
             self key reversed)))
        py-None)

      ;;TODO: change default arguments to kwonlyargs
      (make-signature
        args: (self key reversed)
        defaults: (vector py-None py-False))))

  (py-own-attr-set! py-list-class (& "sort") list.sort)

  (py-own-attr-set! builtins-mod (& "None") py-None)
  (py-own-attr-set! builtins-mod (& "NotImplemented") py-NotImplemented)
  (py-own-attr-set! builtins-mod (& "False") py-False)
  (py-own-attr-set! builtins-mod (& "True") py-True)
  (py-own-attr-set! builtins-mod (& "abs") py-builtin-abs)
  (py-own-attr-set! builtins-mod (& "all") py-builtin-all)
  (py-own-attr-set! builtins-mod (& "any") py-builtin-any)
  (py-own-attr-set! builtins-mod (& "ascii") py-builtin-ascii)
  (py-own-attr-set! builtins-mod (& "bin") py-builtin-bin)
  (py-own-attr-set! builtins-mod (& "bool") py-builtin-bool)
  (py-own-attr-set! builtins-mod (& "breakpoint") py-builtin-breakpoint)
  (py-own-attr-set! builtins-mod (& "bytearray") py-builtin-bytearray)
  (py-own-attr-set! builtins-mod (& "bytes") py-builtin-bytes)
  (py-own-attr-set! builtins-mod (& "callable") py-builtin-callable)
  (py-own-attr-set! builtins-mod (& "chr") py-builtin-chr)
  (py-own-attr-set! builtins-mod (& "classmethod") py-builtin-classmethod)
  (py-own-attr-set! builtins-mod (& "compile") py-builtin-compile)
  (py-own-attr-set! builtins-mod (& "complex") py-builtin-complex)
  (py-own-attr-set! builtins-mod (& "delattr") py-builtin-delattr)
  (py-own-attr-set! builtins-mod (& "dict") py-builtin-dict)
  (py-own-attr-set! builtins-mod (& "dir") py-builtin-dir)
  (py-own-attr-set! builtins-mod (& "divmod") py-builtin-divmod)
  (py-own-attr-set! builtins-mod (& "enumerate") py-builtin-enumerate)
  (py-own-attr-set! builtins-mod (& "eval") py-builtin-eval)
  (py-own-attr-set! builtins-mod (& "exec") py-builtin-exec)
  (py-own-attr-set! builtins-mod (& "filter") py-builtin-filter)
  (py-own-attr-set! builtins-mod (& "float") py-builtin-float)
  (py-own-attr-set! builtins-mod (& "format") py-builtin-format)
  (py-own-attr-set! builtins-mod (& "frozenset") py-builtin-frozenset)
  (py-own-attr-set! builtins-mod (& "getattr") py-builtin-getattr)
  (py-own-attr-set! builtins-mod (& "globals") py-builtin-globals)
  (py-own-attr-set! builtins-mod (& "hasattr") py-builtin-hasattr)
  (py-own-attr-set! builtins-mod (& "hash") py-builtin-hash)
  (py-own-attr-set! builtins-mod (& "help") py-builtin-help)
  (py-own-attr-set! builtins-mod (& "hex") py-builtin-hex)
  (py-own-attr-set! builtins-mod (& "id") py-builtin-id)
  (py-own-attr-set! builtins-mod (& "input") py-builtin-input)
  (py-own-attr-set! builtins-mod (& "int") py-builtin-int)
  (py-own-attr-set! builtins-mod (& "isinstance") py-builtin-isinstance)
  (py-own-attr-set! builtins-mod (& "issubclass") py-builtin-issubclass)
  (py-own-attr-set! builtins-mod (& "iter") py-builtin-iter)
  (py-own-attr-set! builtins-mod (& "len") py-builtin-len)
  (py-own-attr-set! builtins-mod (& "list") py-builtin-list)
  (py-own-attr-set! builtins-mod (& "locals") py-builtin-locals)
  (py-own-attr-set! builtins-mod (& "map") py-builtin-map)
  (py-own-attr-set! builtins-mod (& "max") py-builtin-max)
  (py-own-attr-set! builtins-mod (& "memoryview") py-builtin-memoryview)
  (py-own-attr-set! builtins-mod (& "min") py-builtin-min)
  (py-own-attr-set! builtins-mod (& "next") py-builtin-next)
  (py-own-attr-set! builtins-mod (& "object") py-builtin-object)
  (py-own-attr-set! builtins-mod (& "oct") py-builtin-oct)
  (py-own-attr-set! builtins-mod (& "open") py-builtin-open)
  (py-own-attr-set! builtins-mod (& "ord") py-builtin-ord)
  (py-own-attr-set! builtins-mod (& "pow") py-builtin-pow)
  (py-own-attr-set! builtins-mod (& "print") py-builtin-print)
  (py-own-attr-set! builtins-mod (& "property") py-builtin-property)
  (py-own-attr-set! builtins-mod (& "repr") py-builtin-repr)
  (py-own-attr-set! builtins-mod (& "reversed") py-builtin-reversed)
  (py-own-attr-set! builtins-mod (& "round") py-builtin-round)
  (py-own-attr-set! builtins-mod (& "set") py-builtin-set)
  (py-own-attr-set! builtins-mod (& "setattr") py-builtin-setattr)
  (py-own-attr-set! builtins-mod (& "slice") py-builtin-slice)
  (py-own-attr-set! builtins-mod (& "sorted") py-builtin-sorted)
  (py-own-attr-set! builtins-mod (& "staticmethod") py-builtin-staticmethod)
  (py-own-attr-set! builtins-mod (& "str") py-builtin-str)
  (py-own-attr-set! builtins-mod (& "sum") py-builtin-sum)
  (py-own-attr-set! builtins-mod (& "super") py-builtin-super)
  (py-own-attr-set! builtins-mod (& "tuple") py-builtin-tuple)
  (py-own-attr-set! builtins-mod (& "type") py-builtin-type)
  (py-own-attr-set! builtins-mod (& "vars") py-builtin-vars)
  (py-own-attr-set! builtins-mod (& "zip") py-builtin-zip)
  (py-own-attr-set! builtins-mod (& "__import__") py-builtin-__import__)

  (set! py-builtin-range (py-own-attr-ref builtins-mod (& "range")))
  (set! py-builtin-range_iterator (py-own-attr-ref builtins-mod (& "range_iterator"))))

(define (py-make-builtins-mod)
  (let ((builtins-mod (builtin-__import__ "builtins")))
     (bootstrap-builtins builtins-mod)
    builtins-mod))

(define (build-builtins)
  (if (eq? builtins-mod py-absent)
      (set! builtins-mod (py-make-builtins-mod))))

(end-registering-constants)
