(define py-absent (list 'absent))

(define (py-uninit) py-absent)

(define (global-get global name cache)
   (if (eq? (PyObject-hclass global) (PCache-hclass cache))
       (let ((val (PyObject-elements-ref global (PCache-index cache))))
         (if (not (eq? val py-absent))
             val
             (py-throw py-builtin-NameError)))
       (global-get/miss global name cache)))

(define (global-get/miss global name cache)
  (let ((i (py-own-attr-index global name)))
    (if (< i 0)
        (let ((bi (py-attr-ref global (& "__builtins__"))))
          (if (not (eq? bi py-absent))
              (let ((val (py-attr-ref bi name)))
                (if (not (eq? val py-absent))
                    val
                    (py-throw py-builtin-NameError)))
              (py-throw py-builtin-NameError)))
        (let ((hclass (PyObject-hclass global)))
          (PCache-set! cache hclass i)
          (let ((val (PyObject-elements-ref global i)))
            (if (not (eq? val py-absent))
                val
                (py-throw py-builtin-NameError)))))))

(define (global-put! global name val cache)
   (if (eq? (PyObject-hclass global) (PCache-hclass cache))
       (PyObject-elements-set! global (PCache-index cache) val)
       (global-put!/miss global name val cache)))

(define (global-put!/miss global name val cache)
  (let* ((i (py-own-attr-index global name))
         (hclass (PyObject-hclass global)))
    (if (< i 0)
        (let* ((new-hclass (HClass-next hclass name '+))
               (index (HClass-last-index new-hclass)))
          (PyObject-hclass-set! global new-hclass)
          (PCache-set! cache new-hclass index)
          (PyObject-elements-set! global index val))
        (begin
          (PCache-set! cache hclass i)
          (PyObject-elements-set! global i val)))))

#;
(define (object-get object name cache)
  (if (PyObject? object)
      (if (eq? (PyObject-hclass object) (PCache-hclass cache))
          (PyObject-elements-ref object (PCache-index cache))
          (object-get/miss object name cache))
      (if (eq? name (& "__class__")) ;; TODO: remove (temporary kluge)
          (py-obj-cls object)
          (object-get/miss object name cache))))

(define (object-get/miss obj name cache)
  ;; TODO: create a 'method' instance with __func__ and __self__ attributes
  ;; when attribute is a function and obj is not a class
  (let ((index (PyObject-find-prop obj name)))
    (cond ((>= index 0)
           (PCache-set! cache (PyObject-hclass obj) index)
           (PyObject-elements-ref obj index))
          (else
           (object-get/miss-in-mro obj name)))))

(define (object-get-no-cache obj name)
  (let ((index (PyObject-find-prop obj name)))
    (cond ((>= index 0)
           (PyObject-elements-ref obj index))
    (else
           (object-get/miss-in-mro obj name)))))

(define (object-get/miss-in-mro obj name)
;;  (let ((mro (py-cls-mro (py-obj-cls obj))))
  (let ((mro (HClass-class-mro (PyObject-hclass obj))))
    (let loop ((i 0))
      (if (< i (vector-length mro))
          (let ((cls (vector-ref mro i)))
            (let ((index (PyObject-find-prop cls name)))
              (if (>= index 0)
                  (PyObject-elements-ref cls index)
                  (loop (+ i 1)))))
          (error "AttributeError" "object has no attribute" name)))))

#;
(define (object-has obj name)
   (>= (PyObject-find-prop obj name) 0))

#;
(define (object-put! object name val cache)
  (if (eq? (PyObject-hclass object) (PCache-hclass cache))
      (PyObject-elements-set! object (PCache-index cache) val)
      (object-put!/miss object name val cache)))

(define (object-put!/miss obj name val cache)
  (let* ((index (PyObject-find-prop obj name))
         (hclass (PyObject-hclass obj)))
    (if (>= index 0)
        (begin
          (PCache-set! cache hclass index)
          (PyObject-elements-set! obj index val))
        (let* ((nhclass (HClass-next hclass name '+))
               (index (HClass-last-index nhclass)))
          (PyObject-hclass-set! obj nhclass)
          (PCache-set! cache nhclass index)
          (PyObject-elements-set! obj index val)))))

(define (object-put-no-cache! obj name val)
  (let* ((index (PyObject-find-prop obj name))
         (hclass (PyObject-hclass obj)))
    (if (>= index 0)
	(PyObject-elements-set! obj index val)
        (let* ((nhclass (HClass-next hclass name '+))
               (index (HClass-last-index nhclass)))
          (PyObject-hclass-set! obj nhclass)
          (PyObject-elements-set! obj index val)))))

(define (PyObject-find-prop obj name)
  (if (not (PyObject? obj))
      -1
      (let* ((hclass (PyObject-hclass obj))
             (names (HClass-names hclass)))
        (let loop ((i (- (vector-length names) 1)))
          (cond
           ((= i -1) i)
           ((eq? name (vector-ref names i)) i)
           (else (loop (- i 1))))))))

(define fun-hclass
   (make-HClass '#() '#() '()))

(define (PyFunction-default-hclass)
   fun-hclass)

(define (py-procedure->function generic-proc positional-proc)
   (make-PyFunction (PyFunction-default-hclass) '#() positional-proc))

(define (py-call0 fun)
   (if (and (isa? fun PyFunction) (correct-arity? (PyFunction-procedure fun) 0))
       ((PyFunction-procedure fun))
       (error "call0" "wrong call" fun)))

(define (py-call1 fun a0)
   (if (and (isa? fun PyFunction) (correct-arity? (PyFunction-procedure fun) 1))
       ((PyFunction-procedure fun) a0)
       (error "call1" "wrong call" fun)))

(define (py-call2 fun a0 a1)
   (if (and (isa? fun PyFunction) (correct-arity? (PyFunction-procedure fun) 2))
       ((PyFunction-procedure fun) a0 a1)
       (error "call2" "wrong call" fun)))

(define (py-call3 fun a0 a1 a2)
   (if (and (isa? fun PyFunction) (correct-arity? (PyFunction-procedure fun) 3))
       ((PyFunction-procedure fun) a0 a1 a2)
       (error "call3" "wrong call" fun)))

(define (py-call4 fun a0 a1 a2 a3)
   (if (and (isa? fun PyFunction) (correct-arity? (PyFunction-procedure fun) 4))
       ((PyFunction-procedure fun) a0 a1 a2 a3)
       (error "call4" "wrong call" fun)))

(define (py-is-in-mro? target mro)
  (let loop ((i 0))
    (and (< i (vector-length mro))
         (let* ((cls (vector-ref mro i)))
           (or (eq? cls target)
               (loop (+ i 1)))))))

(define (py-throw exc)
  (cond ((not (PyObject? exc))
         (raise py-builtin-ValueError))
        ((py-is-in-mro? py-builtin-BaseException (py-obj-mro exc))
         (raise exc))
        ((py-is-in-mro? py-builtin-BaseException (py-cls-mro exc))
         (raise (py-call0 exc)))
        (else
         (raise py-builtin-ValueError))))

(define (py-make-caches size)
   (list->vector
      (map (lambda (n) (make-PCache #f -1))
         (iota size))))

;;;----------------------------------------------------------------------------

;;; Old Python operators.

(define (pyis? x y)
   (eq? x y))

(define (py+ x y)
  (+ x y))

(define (py- x y)
  (- x y))

(define (pyneg x)
  (- x))

(define (py* x y)
  (* x y))

(define (py/ x y)
  (/ x y))

(define (py< x y)
  (< x y))

(define (py<= x y)
  (<= x y))

(define (py= x y)
  (= x y))

(define (py> x y)
  (> x y))

(define (py>= x y)
  (>= x y))

(define (py!= x y)
  (not (= x y)))

;;;----------------------------------------------------------------------------

;;; Python operators.

(define (py-add x y cache) ;; x + y
  (+ x y))

(define (py-and x y cache) ;; x & y
  (bit-and x y))

(define (py-div x y cache) ;; x / y
  (if (= y 0)
      (py-throw py-builtin-ZeroDivisionError)
      (/ (exact->inexact x) (exact->inexact y))))

(define (py-floordiv x y cache) ;; x // y
  (inexact->exact (floor (/ x y))))

(define (py-invert x cache) ;; ~ x
  (bit-not x))

(define (py-lshift x y cache) ;; x << y
  (bit-lsh x y))

(define (py-matmul x y cache) ;; x @ y
  (error "py-matmul" "not implemented" #f))

(define (py-mod x y cache) ;; x % y
  (modulo x y))

(define (py-mul x y cache) ;; x * y
  (* x y))

(define (py-neg x cache) ;; - x
  (- x))

(define (py-or x y cache) ;; x | y
  (bit-or x y))

(define (py-pos x cache) ;; + x
  (+ x))

(define (py-pow x y cache) ;; x ** y
  (expt x y))

(define (py-rshift x y cache) ;; x >> y
  (bit-rsh x y))

(define (py-sub x y cache) ;; x - y
  (- x y))

(define (py-xor x y cache) ;; x ^ y
  (bit-xor x y))

(define (py-iadd x y cache) ;; x += y
  (+ x y))

(define (py-iand x y cache) ;; x &= y
  (bit-and x y))

(define (py-idiv x y cache) ;; x /= y
  (if (= y 0)
      (py-throw py-builtin-ZeroDivisionError)
      (/ (exact->inexact x) (exact->inexact y))))

(define (py-ifloordiv x y cache) ;; x //= y
  (inexact->exact (floor (/ x y))))

(define (py-ilshift x y cache) ;; x <<= y
  (bit-lsh x y))

(define (py-imatmul x y cache) ;; x @= y
  (error "py-imatmul" "not implemented" #f))

(define (py-imod x y cache) ;; x %= y
  (modulo x y))

(define (py-imul x y cache) ;; x *= y
  (* x y))

(define (py-ior x y cache) ;; x |= y
  (bit-or x y))

(define (py-ipow x y cache) ;; x **= y
  (expt x y))

(define (py-irshift x y cache) ;; x >>= y
  (bit-rsh x y))

(define (py-isub x y cache) ;; x -= y
  (- x y))

(define (py-ixor x y cache) ;; x ^= y
  (bit-xor x y))

(define (py-eq x y cache) ;; x == y
  (= x y))

(define (py-ne x y cache) ;; x != y
  (not (= x y)))

(define (py-lt x y cache) ;; x < y
  (< x y))

(define (py-le x y cache) ;; x <= y
  (<= x y))

(define (py-gt x y cache) ;; x > y
  (> x y))

(define (py-ge x y cache) ;; x >= y
  (>= x y))

(define (py-is x y cache) ;; x is y
  (eq? x y))

(define (py-isnot x y cache) ;; x is not y
  (not (eq? x y)))

(define (py-in x y cache) ;; x in y
  (error "py-in" "not implemented" #f))

(define (py-notin x y cache) ;; x not in y
  (error "py-notin" "not implemented" #f))

;;;----------------------------------------------------------------------------

(define (py-len obj)
  (cond ((eq? py-tuple-class (py-obj-cls obj))
         (vector-length (py-tuple-to-scheme obj)))
        ((eq? py-list-class (py-obj-cls obj))
         (vector-length (py-list-to-scheme obj)))
        ((eq? py-dict-class (py-obj-cls obj))
         (length (py-dict-to-scheme obj)))
        ((eq? py-set-class (py-obj-cls obj))
         (length (py-set-to-scheme obj)))
        ((and (PyObject? obj)
              (let ((index (PyObject-find-prop obj (& "__len__"))))
                (and (>= index 0)
                     index)))
         =>
         (lambda (index)
           (let ((__len__ (PyObject-elements-ref obj index)))
             (py-call1 __len__ obj))))
        (else
         (error "len" "only object with __len__ method implemented" #f))))

(define (py-getitem obj i cache)
  (cond ((eq? py-tuple-class (py-obj-cls obj))
         (vector-ref (py-tuple-to-scheme obj) i))
        ((eq? py-list-class (py-obj-cls obj))
         (vector-ref (py-list-to-scheme obj) i))
        ((eq? py-dict-class (py-obj-cls obj))
         (let ((x (assoc i (py-dict-to-scheme obj))))
           (if x
               (cdr x)
               (error "py-getitem" "item not found" i))))
        ((eq? py-set-class (py-obj-cls obj))
         (list-ref (py-set-to-scheme obj) i))
        (else
         (let ((getitem (py-attr-ref obj (& "__getitem__"))))
           (if (eq? getitem py-absent)
               (error "getitem" "only object with __getitem__ method implemented" i)
               (py-call2 getitem obj i))))))


(define (py-setitem obj i val cache)
  (cond ((eq? py-tuple-class (py-obj-cls obj))
         (vector-set! (py-tuple-to-scheme obj) i val))
        ((eq? py-list-class (py-obj-cls obj))
         (vector-set! (py-list-to-scheme obj) i val))
        ((eq? py-dict-class (py-obj-cls obj))
         (let ((x (assoc i (py-dict-to-scheme obj))))
           (if x
               (begin
                 (set-cdr! x val)
                 (py-uninit))
	       (begin
		  (PyObject-elements-set! obj 1
		     (cons (cons i val)
			(py-dict-to-scheme obj)))
		  (py-uninit)))))
        ((eq? py-set-class (py-obj-cls obj))
         (list-set! (py-set-to-scheme obj) i val))
        (else
         (let ((setitem (py-attr-ref obj (& "__setitem__"))))
           (if (eq? setitem py-absent)
               (error "setitem" "only object with __setitem__ method implemented" i)
               (py-call3 setitem obj i val))))))

(define (py-contains obj i cache)
  (cond ((eq? py-tuple-class (py-obj-cls obj))
         (and (>= i 0) (< i (py-len obj))))
        ((eq? py-list-class (py-obj-cls obj))
         (and (>= i 0) (< i (py-len obj))))
        ((eq? py-dict-class (py-obj-cls obj))
         (let ((x (assoc i (py-dict-to-scheme obj))))
           (if x #t #f)))
        (else
         (let ((contains (py-attr-ref obj (& "__contains__"))))
           (if (eq? contains py-absent)
               (error "contains" "only object with __contains__ method implemented" i)
               (py-call2 contains obj i))))))

;;;----------------------------------------------------------------------------

;;; Python modules.

(define builtins-mod #f)

;; Base builtins module for building builtins.py
;; This can be unloaded of Scheme builtins as we build builtins.py
;; In the end this should offer minimal functions from which actual buitlins can be defined
(define (py-make-base-builtins-mod)
(let ((mod
       (py-obj-alloc
        py-module-class
        (make-HClass
         (vector py-module-class py-object-class)
         (vector (& "**class**")
                (& "__class__")
                (& "__name__")
                (& "__base_abs")
                (& "__base_all")
                (& "__base_any")
                (& "__base_ascii")
                (& "__base_bin")
                (& "__base_bool")
                (& "__base_breakpoint")
                (& "__base_bytearray")
                (& "__base_bytes")
                (& "__base_callable")
                (& "__base_chr")
                (& "__base_classmethod")
                (& "__base_compile")
                (& "__base_complex")
                (& "__base_delattr")
                (& "__base_dict")
                (& "__base_dir")
                (& "__base_divmod")
                (& "__base_enumerate")
                (& "__base_eval")
                (& "__base_exec")
                (& "__base_filter")
                (& "__base_float")
                (& "__base_format")
                (& "__base_frozenset")
                (& "__base_getattr")
                (& "__base_globals")
                (& "__base_hasattr")
                (& "__base_hash")
                (& "__base_help")
                (& "__base_hex")
                (& "__base_id")
                (& "__base_input")
                (& "__base_int")
                (& "__base_isinstance")
                (& "__base_issubclass")
                (& "__base_iter")
                (& "__base_len")
                (& "__base_list")
                (& "__base_locals")
                (& "__base_map")
                (& "__base_max")
                (& "__base_memoryview")
                (& "__base_min")
                (& "__base_next")
                (& "__base_object")
                (& "__base_oct")
                (& "__base_open")
                (& "__base_ord")
                (& "__base_pow")
                (& "__base_print")
                (& "__base_property")
                (& "__base_range")
                (& "__base_repr")
                (& "__base_reversed")
                (& "__base_round")
                (& "__base_set")
                (& "__base_setattr")
                (& "__base_slice")
                (& "__base_sorted")
                (& "__base_staticmethod")
                (& "__base_str")
                (& "__base_sum")
                (& "__base_super")
                (& "__base_tuple")
                (& "__base_type")
                (& "__base_vars")
                (& "__base_zip")
                (& "__base___import__")
                (& "BaseException")
                )
                '()))))

      (PyObject-elements-set! mod 1  py-module-class)
      (PyObject-elements-set! mod 2  (py-str-from-scheme "builtins"))
      (PyObject-elements-set! mod 3  py-builtin-abs)
      (PyObject-elements-set! mod 4  py-builtin-all)
      (PyObject-elements-set! mod 5  py-builtin-any)
      (PyObject-elements-set! mod 6  py-builtin-ascii)
      (PyObject-elements-set! mod 7  py-builtin-bin)
      (PyObject-elements-set! mod 8  py-builtin-bool)
      (PyObject-elements-set! mod 9  py-builtin-breakpoint)
      (PyObject-elements-set! mod 10 py-builtin-bytearray)
      (PyObject-elements-set! mod 11 py-builtin-bytes)
      (PyObject-elements-set! mod 12 py-builtin-callable)
      (PyObject-elements-set! mod 13 py-builtin-chr)
      (PyObject-elements-set! mod 14 py-builtin-classmethod)
      (PyObject-elements-set! mod 15 py-builtin-compile)
      (PyObject-elements-set! mod 16 py-builtin-complex)
      (PyObject-elements-set! mod 17 py-builtin-delattr)
      (PyObject-elements-set! mod 18 py-builtin-dict)
      (PyObject-elements-set! mod 19 py-builtin-dir)
      (PyObject-elements-set! mod 20 py-builtin-divmod)
      (PyObject-elements-set! mod 21 py-builtin-enumerate)
      (PyObject-elements-set! mod 22 py-builtin-eval)
      (PyObject-elements-set! mod 23 py-builtin-exec)
      (PyObject-elements-set! mod 24 py-builtin-filter)
      (PyObject-elements-set! mod 25 py-builtin-float)
      (PyObject-elements-set! mod 26 py-builtin-format)
      (PyObject-elements-set! mod 27 py-builtin-frozenset)
      (PyObject-elements-set! mod 28 py-builtin-getattr)
      (PyObject-elements-set! mod 29 py-builtin-globals)
      (PyObject-elements-set! mod 30 py-builtin-hasattr)
      (PyObject-elements-set! mod 31 py-builtin-hash)
      (PyObject-elements-set! mod 32 py-builtin-help)
      (PyObject-elements-set! mod 33 py-builtin-hex)
      (PyObject-elements-set! mod 34 py-builtin-id)
      (PyObject-elements-set! mod 35 py-builtin-input)
      (PyObject-elements-set! mod 36 py-builtin-int)
      (PyObject-elements-set! mod 37 py-builtin-isinstance)
      (PyObject-elements-set! mod 38 py-builtin-issubclass)
      (PyObject-elements-set! mod 39 py-builtin-iter)
      (PyObject-elements-set! mod 40 py-builtin-len)
      (PyObject-elements-set! mod 41 py-builtin-list)
      (PyObject-elements-set! mod 42 py-builtin-locals)
      (PyObject-elements-set! mod 43 py-builtin-map)
      (PyObject-elements-set! mod 44 py-builtin-max)
      (PyObject-elements-set! mod 45 py-builtin-memoryview)
      (PyObject-elements-set! mod 46 py-builtin-min)
      (PyObject-elements-set! mod 47 py-builtin-next)
      (PyObject-elements-set! mod 48 py-builtin-object)
      (PyObject-elements-set! mod 49 py-builtin-oct)
      (PyObject-elements-set! mod 50 py-builtin-open)
      (PyObject-elements-set! mod 51 py-builtin-ord)
      (PyObject-elements-set! mod 52 py-builtin-pow)
      (PyObject-elements-set! mod 53 py-builtin-print)
      (PyObject-elements-set! mod 54 py-builtin-property)
      (PyObject-elements-set! mod 55 py-builtin-range)
      (PyObject-elements-set! mod 56 py-builtin-repr)
      (PyObject-elements-set! mod 57 py-builtin-reversed)
      (PyObject-elements-set! mod 58 py-builtin-round)
      (PyObject-elements-set! mod 59 py-builtin-set)
      (PyObject-elements-set! mod 60 py-builtin-setattr)
      (PyObject-elements-set! mod 61 py-builtin-slice)
      (PyObject-elements-set! mod 62 py-builtin-sorted)
      (PyObject-elements-set! mod 63 py-builtin-staticmethod)
      (PyObject-elements-set! mod 64 py-builtin-str)
      (PyObject-elements-set! mod 65 py-builtin-sum)
      (PyObject-elements-set! mod 66 py-builtin-super)
      (PyObject-elements-set! mod 67 py-builtin-tuple)
      (PyObject-elements-set! mod 68 py-builtin-type)
      (PyObject-elements-set! mod 69 py-builtin-vars)
      (PyObject-elements-set! mod 70 py-builtin-zip)
      (PyObject-elements-set! mod 71 py-builtin-__import__)
      (PyObject-elements-set! mod 72 py-builtin-BaseException)
      mod))

;; This needs to be globally defined an configured instead
(define zipi-stdlib-dir "~/udem-dlteam/zipi/stdlib")

(define (py-make-builtins-mod)
  (let ((file (string-append zipi-stdlib-dir "/builtins.scm")))
     (cond-expand
	(bigloo (builtins-init))
	(else
	 ((loadv file))))))

;; Once builtins.py is loaded, we need to keep a direct access to some builtins
;; Examples are exceptions which are part of Python protocols, such as StopIteration
(define (bootstrap-builtins builtins-mod)
  (set! py-builtin-ValueError (object-get-no-cache builtins-mod  (& "ValueError")))
  (set! py-builtin-NameError (object-get-no-cache builtins-mod  (& "NameError")))
  (set! py-builtin-StopIteration (object-get-no-cache builtins-mod  (& "StopIteration")))
  (set! py-builtin-ArithmeticError (object-get-no-cache builtins-mod  (& "ArithmeticError")))
  (set! py-builtin-ZeroDivisionError (object-get-no-cache builtins-mod  (& "ZeroDivisionError")))
  (set! py-builtin-AttributeError (object-get-no-cache builtins-mod  (& "AttributeError")))
)

(define (py-builtins-mod)
  (unless builtins-mod
    (set! builtins-mod (py-make-builtins-mod))
    (bootstrap-builtins builtins-mod)
  )
  builtins-mod)

(define time-mod #f)

(define (py-make-time-mod)
  (let ((mod
         (py-obj-alloc
          py-module-class
          (make-HClass
           (vector py-module-class py-object-class)
           (vector (& "**class**")
                   (& "__class__")
                   (& "__name__")
                   (& "time")
		   )
	   '()))))

    (PyObject-elements-set! mod 1 py-module-class)
    (PyObject-elements-set! mod 2 (py-str-from-scheme "time"))
    (PyObject-elements-set! mod 3 py-time)

    mod))

(define (py-time-mod)
  (unless time-mod
    (set! time-mod (py-make-time-mod)))
  time-mod)

(define py-time
  (py-procedure->function
   (lambda rest (error "time" "unimplemented generic procedure for time" #f))
   (lambda _
     (/ (current-microseconds) 1000000.0))))

(define sys-mod #f)

(define (py-make-sys-mod)
  (let ((mod
         (py-obj-alloc
          py-module-class
          (make-HClass
           (vector py-module-class py-object-class)
           (vector (& "**class**")
                   (& "__class__")
                   (& "__name__")
                   (& "modules")
		   )
	   '()))))

    (PyObject-elements-set! mod 1 py-module-class)
    (PyObject-elements-set! mod 2 (py-str-from-scheme "sys"))
    (PyObject-elements-set! mod 3 (py-make-dict '() '()))

    mod))

(define (py-sys-mod)
  (unless sys-mod
    (set! sys-mod (py-make-sys-mod)))
  sys-mod)

;;;----------------------------------------------------------------------------

;;; Object attribute store/fetch.

(define (py-own-attr-set! obj attr val)
  (let ((i (py-own-attr-index obj attr)))
    (if (< i 0)
        (let* ((hclass (PyObject-hclass obj))
               (new-hclass (HClass-next hclass attr '+))
               (index (HClass-last-index new-hclass)))
          (PyObject-hclass-set! obj new-hclass)
          (PyObject-elements-set! obj index val))
        (PyObject-elements-set! obj i val))))

(define (py-own-attr-ref obj attr #!optional (default py-absent))
  (let ((i (py-own-attr-index obj attr)))
    (if (< i 0)
        default
        (PyObject-elements-ref obj i)))) ;; TODO: could vector-ref be used?

(define (py-own-attr-index obj attr)
  (if (not (PyObject? obj)) ;; TODO: find how this test could be removed
      -1
      (let* ((hclass (PyObject-hclass obj))
             (names (HClass-names hclass)))
        (let loop ((i (- (vector-length names) 1)))
          (cond ((< i 0) -1)
                ((eq? attr (vector-ref names i)) i)
                (else (loop (- i 1))))))))

(define (py-attr-set! obj attr val)
  (py-own-attr-set! obj attr val))

(define (py-attr-ref obj attr #!optional (default py-absent))
  (let ((mro (py-obj-mro obj)))
    (let loop1 ((i 0))
      (if (< i (vector-length mro))
          (let* ((cls (vector-ref mro i))
                 (ga (py-own-attr-ref obj (& "__getattribute__"))))
            (if (not (eq? ga py-absent))
                (error "py-attr-ref" "TODO: add case where class defines __getattribute__" #f)
                (loop1 (+ i 1))))
          (let ((val (py-own-attr-ref obj attr)))
            (if (not (eq? val py-absent))
                val
                (let loop2 ((i 0))
                  (if (< i (vector-length mro))
                      (let* ((cls (vector-ref mro i))
                             (val (py-own-attr-ref cls attr)))
                        (if (not (eq? val py-absent))
                            val
                            (loop2 (+ i 1))))
                      (let loop3 ((i 0))
                        (if (< i (vector-length mro))
                            (let* ((cls (vector-ref mro i))
                                   (ga (py-own-attr-ref obj (& "__getattr__"))))
                              (if (not (eq? ga py-absent))
                                  (error "py-attr-ref" "TODO: add case where class defines __getattr__" #f)
                                  (loop3 (+ i 1))))
                            default))))))))))

;; redefine object-put! and object-get

(define (object-put! obj attr val cache)
  (py-attr-set! obj attr val))

(define (object-get obj attr cache)
  (if (PyObject? obj)
      (let ((val (py-attr-ref obj attr)))
        (if (not (eq? val py-absent))
            val
            (object-get-fail obj attr)))
      (if (eq? attr (& "__class__")) ;; TODO: remove (temporary kluge)
          (py-obj-cls obj)
          (object-get-fail obj attr))))

(define (object-get-fail obj attr)
  (error "AttributeError" "object has no attribute" attr))

(define (object-has obj attr)
   (>= (py-own-attr-index obj attr) 0))

;;;----------------------------------------------------------------------------

;;; Bootstrap types.

;;; Objects are represented with a structure pointing to a hidden
;;; class and a vector containing the values of the object's
;;; attributes.  The hidden class indicates the names of the
;;; attributes and their position in the vector.  The hidden class
;;; also contains the method resolution order (MRO) vector of the
;;; object's class.  The first element of this vector is normally
;;; the object's class.
;;;
;;; The object model contains cycles, for example the class of the
;;; "type" class is itself, so we need to explicitly set some
;;; attributes to construct the builtin classes.
;;;
;;; Here is an example showing the representation of the string "abc"
;;; which is an instance of the "str" class.

;; +------------------------+
;; |                        |
;; |  hclass of type        |     +------+
;; |  +------------+        |     |      |
;; |  |class-mro  -+---> #(type object)  |
;; |  |names      -+---> #(**class**     |
;; |  |transitions-+->...  **bases**     |
;; |  +------------+<--+   **mro**       |
;; |                   |   ...)          |
;; |                   |                 |
;; |       type        |                 |
;; +->+------------+   |                 |
;;    | hclass    -+---+                 |
;;    +~~elements~~+                     |
;;    | **class** -+--> type             |
;;    | **bases** -+--> #(object)        |
;;    | **mro**   -+--> #(type object)   |
;;    | __class__ -+--> ...              |
;;    | __bases__ -+--> ...              |
;;    | __mro__   -+--> ...              |
;;    | __len__    |                     |
;;    | __getitem__|                     |
;;    | __setitem__|<--------------------|------------------------+
;;    +------------+<-------+            |                        |
;;                          |            |                        |
;;                          |            | /----------------------------+
;;                          |            |/                       |     |
;;    hclass of str         |     +----\ +  hclass of object      |     |
;;    +------------+        |     |     \|  +------------+        |     |
;;    |class-mro  -+---> #(type object)  +  |class-mro  -+---> #(type object)
;;    |names      -+---> #(**class**     |  |names      -+---> #(**class**
;;    |transitions-+->...  **bases**     |  |transitions-+->...  **bases**
;;    +------------+<--+   **mro**       |  +------------+<--+   **mro**
;;                     |   ...)          |                   |   ...)
;;                     |                 |                   |
;;         str         |                 |      object       |
;;    +------------+   |                 +->+------------+   |
;;    | hclass    -+---+                    | hclass    -+---+
;;    +~~elements~~+                        +~~elements~~+
;;    | **class** -+--> type                | **class** -+--> type
;;    | **bases** -+--> #(object)           | **bases** -+--> #()
;;    | **mro**   -+--> #(str object)       | **mro**   -+--> #(object)
;;    | __class__ -+--> ...                 | __class__ -+--> ...
;;    | __bases__ -+--> ...                 | __bases__ -+--> ...
;;    | __mro__   -+--> ...                 | __mro__   -+--> ...
;;    | __len__    |                        | __init__   |
;;    | __getitem__|             +--------->+------------+
;;    | __setitem__|             |
;;    +------------+<-------+    |
;;                          |    |
;;                          |    |
;;    hclass of "abc        |    |
;;    +------------+        |    |
;;    |class-mro  -+---> #(str object)
;;    |names      -+---> #(**class** **elems** __class__)
;;    |transitions-+->...
;;    +------------+<--+
;;                     |
;;        "abc"        |
;;    +------------+   |
;;    | hclass    -+---+
;;    +~~elements~~+
;;    | **class** -+--> str
;;    | **elems** -+--> "abc"
;;    | __class__ -+--> str
;;    +------------+

(define py-object-class #f)
(define py-type-class   #f)
(define py-str-class    #f)
(define py-tuple-class  #f)
(define py-list-class   #f)
(define py-dict-class   #f)
(define py-set-class    #f)
(define py-module-class #f)

(define py-object-hclass-of-instances #f)
(define py-type-hclass-of-instances   #f)
(define py-str-hclass-of-instances    #f)
(define py-tuple-hclass-of-instances  #f)
(define py-list-hclass-of-instances   #f)
(define py-dict-hclass-of-instances   #f)
(define py-set-hclass-of-instances    #f)
(define py-module-hclass-of-instances #f)

(define (py-obj-cls* obj) ;; return **class** attribute of object obj
  (cond ((PyObject? obj)
         (PyObject-elements-ref obj 0))
        ((flonum? obj)
         py-float-class)
        ((integer? obj)
         py-int-class)
        ((boolean? obj)
         py-bool-class)
        (else
         #f)))

(define (py-obj-cls obj) ;; return **class** attribute of object obj
  (or (py-obj-cls* obj)
      (error "py-obj-cls" "unhandled object type" obj)))

(define (py-obj-mro obj) ;; return MRO of object
  (py-cls-mro (py-obj-cls obj))) ;; TODO: use HClass-class-mro

(define (py-cls-bases cls) ;; return **bases** attribute of class cls
  (PyObject-elements-ref cls 1))

(define (py-cls-mro cls) ;; return **mro** attribute of class cls
  (PyObject-elements-ref cls 2))

(define (py-obj-alloc cls hclass-of-instances)
  (let ((self
         (make-PyObject
          hclass-of-instances
          (make-vector (vector-length (HClass-names hclass-of-instances))
                       (py-uninit)))))
    (PyObject-elements-set! self 0 cls) ;; set **class**
    self))

(define (py-fun-alloc cls hclass-of-instances proc)
  (let ((self
         (make-PyFunction
          hclass-of-instances
          (make-vector (vector-length (HClass-names hclass-of-instances))
                       (py-uninit))
          proc)))
    (PyObject-elements-set! self 0 cls) ;; set **class**
    self))

(define (py-obj-constructor cls hclass-of-instances init)
  (lambda args
    (let ((self (py-obj-alloc cls hclass-of-instances)))
      (PyObject-elements-set! self 1 cls) ;; set __class__
      (init self args)
      self)))

(define (py-call-init self args)
  (let ((init (py-attr-ref self (& "__init__"))))
    (if (not (eq? init py-absent))
        (if (and (isa? init PyFunction)
                 (correct-arity? (PyFunction-procedure init)
                                 (+ 1 (length args))))
            (apply (PyFunction-procedure init)
                   (cons self args))
            (error "call" "wrong call" init)))))

(define (bootstrap-basic-types-phase1)
  (let* ((type-class
          (py-fun-alloc
           #f ;; **class** is set later
           (make-HClass
            '#() ;; class-mro is set later to (vector type-class object-class)
            (vector
             (& "**class**") ;; read-only copy... is it needed?
             (& "**bases**") ;; read-only copy... is it needed?
             (& "**mro**")   ;; read-only copy... is it needed?
             (& "__class__")
             (& "__bases__")
             (& "__mro__")
             (& "__module__")
             (& "__name__"))
            '())
           #f)) ;; constructor is set later

         (object-class
          (py-fun-alloc
           type-class
           (make-HClass
            '#() ;; class-mro is set later to (vector object-class)
            (vector
             (& "**class**") ;; read-only copy... is it needed?
             (& "**bases**") ;; read-only copy... is it needed?
             (& "**mro**")   ;; read-only copy... is it needed?
             (& "__class__")
             (& "__bases__")
             (& "__mro__")
             (& "__module__")
             (& "__name__"))
            '())
           #f)) ;; constructor is set later

         (str-class
          (py-fun-alloc
           type-class
           (make-HClass
            '#() ;; class-mro is set later to (vector str-class object-class)
            (vector
             (& "**class**") ;; read-only copy... is it needed?
             (& "**bases**") ;; read-only copy... is it needed?
             (& "**mro**")   ;; read-only copy... is it needed?
             (& "__class__")
             (& "__bases__")
             (& "__mro__")
             (& "__module__")
             (& "__name__")
             (& "__len__")
             (& "__getitem__")
             (& "__setitem__"))
            '())
           #f)) ;; constructor is set later

         (tuple-class
          (py-fun-alloc
           type-class
           (make-HClass
            '#() ;; class-mro is set later to (vector tuple-class object-class)
            (vector
             (& "**class**") ;; read-only copy... is it needed?
             (& "**bases**") ;; read-only copy... is it needed?
             (& "**mro**")   ;; read-only copy... is it needed?
             (& "__class__")
             (& "__bases__")
             (& "__mro__")
             (& "__module__")
             (& "__name__")
             (& "__len__")
             (& "__getitem__")
             (& "__setitem__"))
            '())
           #f)) ;; constructor is set later

         (list-class
          (py-fun-alloc
           type-class
           (make-HClass
            '#() ;; class-mro is set later to (vector list-class object-class)
            (vector
             (& "**class**") ;; read-only copy... is it needed?
             (& "**bases**") ;; read-only copy... is it needed?
             (& "**mro**")   ;; read-only copy... is it needed?
             (& "__class__")
             (& "__bases__")
             (& "__mro__")
             (& "__module__")
             (& "__name__")
             (& "__len__")
             (& "__getitem__")
             (& "__setitem__"))
            '())
           #f)) ;; constructor is set later

         (dict-class
          (py-fun-alloc
           type-class
           (make-HClass
            '#() ;; class-mro is set later to (vector dict-class object-class)
            (vector
             (& "**class**") ;; read-only copy... is it needed?
             (& "**bases**") ;; read-only copy... is it needed?
             (& "**mro**")   ;; read-only copy... is it needed?
             (& "__class__")
             (& "__bases__")
             (& "__mro__")
             (& "__module__")
             (& "__name__")
             (& "__len__")
             (& "__getitem__")
             (& "__setitem__"))
            '())
           #f)) ;; constructor is set later

         (set-class
          (py-fun-alloc
           type-class
           (make-HClass
            '#() ;; class-mro is set later to (vector set-class object-class)
            (vector
             (& "**class**") ;; read-only copy... is it needed?
             (& "**bases**") ;; read-only copy... is it needed?
             (& "**mro**")   ;; read-only copy... is it needed?
             (& "__class__")
             (& "__bases__")
             (& "__mro__")
             (& "__module__")
             (& "__name__")
             (& "__len__")
             (& "__getitem__")
             (& "__setitem__"))
            '())
           #f)) ;; constructor is set later

         (module-class
          (py-fun-alloc
           type-class
           (make-HClass
            '#() ;; class-mro is set later to (vector module-class object-class)
            (vector
             (& "**class**") ;; read-only copy... is it needed?
             (& "**bases**") ;; read-only copy... is it needed?
             (& "**mro**")   ;; read-only copy... is it needed?
             (& "__class__")
             (& "__bases__")
             (& "__mro__")
             (& "__module__")
             (& "__name__"))
            '())
           #f)) ;; constructor is set later

         (bases-types ;; all types directly inherit from "object" except itself
          (vector object-class)))

    (let* ((mro
            (vector type-class object-class))
           (hclass-of-instances
            (PyObject-hclass type-class)))
      (set! py-type-class type-class)
      (set! py-type-hclass-of-instances hclass-of-instances)
      (HClass-class-mro-set! (PyObject-hclass (vector-ref mro 0)) mro)
      (PyObject-elements-set! type-class 0 type-class) ;; set **class**
      (PyObject-elements-set! type-class 1 bases-types) ;; set **bases**
      (PyObject-elements-set! type-class 2 mro) ;; set **mro**
      (PyFunction-procedure-set!
       type-class
       (py-obj-constructor type-class hclass-of-instances py-call-init)))

    (let* ((mro
            (vector object-class))
           (hclass-of-instances
            (make-HClass
             mro
             (vector
              (& "**class**") ;; read-only copy... is it needed?
              (& "__class__"))
             '())))
      (set! py-object-class object-class)
      (set! py-object-hclass-of-instances hclass-of-instances)
      (HClass-class-mro-set! (PyObject-hclass (vector-ref mro 0)) mro)
      (PyObject-elements-set! object-class 1 '#()) ;; set **bases**
      (PyObject-elements-set! object-class 2 mro)  ;; set **mro**
      (PyFunction-procedure-set!
       object-class
       (py-obj-constructor object-class hclass-of-instances py-call-init)))

    (let* ((mro
            (vector str-class object-class))
           (hclass-of-instances
            (make-HClass
             mro
             (vector
              (& "**class**") ;; read-only copy... is it needed?
              (& "**elems**")
              (& "__class__"))
             '())))
      (set! py-str-class str-class)
      (set! py-str-hclass-of-instances hclass-of-instances)
      (HClass-class-mro-set! (PyObject-hclass (vector-ref mro 0)) mro)
      (PyObject-elements-set! str-class 1 bases-types) ;; set **bases**
      (PyObject-elements-set! str-class 2 mro)  ;; set **mro**
      (PyFunction-procedure-set!
       str-class
       (py-obj-constructor str-class hclass-of-instances py-call-init)))

    (let* ((mro
            (vector tuple-class object-class))
           (hclass-of-instances
            (make-HClass
             mro
             (vector
              (& "**class**") ;; read-only copy... is it needed?
              (& "**elems**")
              (& "__class__"))
             '())))
      (set! py-tuple-class tuple-class)
      (set! py-tuple-hclass-of-instances hclass-of-instances)
      (HClass-class-mro-set! (PyObject-hclass (vector-ref mro 0)) mro)
      (PyObject-elements-set! tuple-class 1 bases-types) ;; set **bases**
      (PyObject-elements-set! tuple-class 2 mro)  ;; set **mro**
      (PyFunction-procedure-set!
       tuple-class
       (py-obj-constructor tuple-class hclass-of-instances py-call-init)))

    (let* ((mro
            (vector list-class object-class))
           (hclass-of-instances
            (make-HClass
             mro
             (vector
              (& "**class**") ;; read-only copy... is it needed?
              (& "__class__")
              (& "**elems**"))
             '())))
      (set! py-list-class list-class)
      (set! py-list-hclass-of-instances hclass-of-instances)
      (HClass-class-mro-set! (PyObject-hclass (vector-ref mro 0)) mro)
      (PyObject-elements-set! list-class 1 bases-types) ;; set **bases**
      (PyObject-elements-set! list-class 2 mro)  ;; set **mro**
      (PyFunction-procedure-set!
       list-class
       (py-obj-constructor list-class hclass-of-instances py-call-init)))

    (let* ((mro
            (vector dict-class object-class))
           (hclass-of-instances
            (make-HClass
             mro
             (vector
              (& "**class**") ;; read-only copy... is it needed?
              (& "**elems**")
              (& "__class__"))
             '())))
      (set! py-dict-class dict-class)
      (set! py-dict-hclass-of-instances hclass-of-instances)
      (HClass-class-mro-set! (PyObject-hclass (vector-ref mro 0)) mro)
      (PyObject-elements-set! dict-class 1 bases-types) ;; set **bases**
      (PyObject-elements-set! dict-class 2 mro)  ;; set **mro**
      (PyFunction-procedure-set!
       dict-class
       (py-obj-constructor dict-class hclass-of-instances py-call-init)))

    (let* ((mro
            (vector set-class object-class))
           (hclass-of-instances
            (make-HClass
             mro
             (vector
              (& "**class**") ;; read-only copy... is it needed?
              (& "**elems**")
              (& "__class__"))
             '())))
      (set! py-set-class set-class)
      (set! py-set-hclass-of-instances hclass-of-instances)
      (HClass-class-mro-set! (PyObject-hclass (vector-ref mro 0)) mro)
      (PyObject-elements-set! set-class 1 bases-types) ;; set **bases**
      (PyObject-elements-set! set-class 2 mro)  ;; set **mro**
      (PyFunction-procedure-set!
       set-class
       (py-obj-constructor set-class hclass-of-instances py-call-init)))

    (let* ((mro
            (vector module-class object-class))
           (hclass-of-instances
            (make-HClass
             mro
             (vector
              (& "**class**") ;; read-only copy... is it needed?
              (& "__class__")
              (& "__name__"))
             '())))
      (set! py-module-class module-class)
      (set! py-module-hclass-of-instances hclass-of-instances)
      (HClass-class-mro-set! (PyObject-hclass (vector-ref mro 0)) mro)
      (PyObject-elements-set! module-class 1 bases-types) ;; set **bases**
      (PyObject-elements-set! module-class 2 mro)  ;; set **mro**
      (PyFunction-procedure-set!
       module-class
       (py-obj-constructor module-class hclass-of-instances py-call-init)))))

(bootstrap-basic-types-phase1)

;;;----------------------------------------------------------------------------

;;; Converters between Scheme objects and Python objects for basic
;;; types.

(define (py-str-from-scheme string)
  (let ((self (py-obj-alloc py-str-class py-str-hclass-of-instances)))
    (PyObject-elements-set! self 1 string)       ;; set **elems**
    (PyObject-elements-set! self 2 py-str-class) ;; set __class__
    self))

(define (py-str-to-scheme self)
  (PyObject-elements-ref self 1))

(define (py-tuple-from-scheme vector)
  (let ((self (py-obj-alloc py-tuple-class py-tuple-hclass-of-instances)))
    (PyObject-elements-set! self 1 vector)          ;; set **elems**
    (PyObject-elements-set! self 2 py-tuple-class)  ;; set __class__
    self))

(define (py-tuple-to-scheme self)
  (PyObject-elements-ref self 1))

(define (py-list-from-scheme vector)
  (let ((self (py-obj-alloc py-list-class py-list-hclass-of-instances)))
    (PyObject-elements-set! self 1 vector)         ;; set **elems**
    (PyObject-elements-set! self 2 py-list-class)  ;; set __class__
    self))

(define (py-list-to-scheme self)
  (PyObject-elements-ref self 1))

(define (py-dict-from-scheme keys vals)
  (let ((elems (map cons keys vals)))
    (let ((self (py-obj-alloc py-dict-class py-dict-hclass-of-instances)))
      (PyObject-elements-set! self 1 elems)          ;; set **elems**
      (PyObject-elements-set! self 2 py-dict-class)  ;; set __class__
    self)))

(define (py-dict-to-scheme self)
  (PyObject-elements-ref self 1))

(define (py-set-from-scheme elems)
  (let ((self (py-obj-alloc py-set-class py-set-hclass-of-instances)))
    (PyObject-elements-set! self 1 elems)         ;; set **elems**
    (PyObject-elements-set! self 2 py-set-class)  ;; set __class__
    self))

(define (py-set-to-scheme self)
  (PyObject-elements-ref self 1))

;;;----------------------------------------------------------------------------

(define (bootstrap-basic-types-phase2)

  (define (set-attrs-with-python-values x)
    (let* ((cls   (vector-ref x 0))
           (bases (py-tuple-from-scheme (py-cls-bases cls)))
           (mro   (py-tuple-from-scheme (py-cls-mro cls)))
           (mod   (py-str-from-scheme (vector-ref x 1)))
           (name  (py-str-from-scheme (vector-ref x 2))))
      (PyObject-elements-set! cls 3 (PyObject-elements-ref cls 0)) ;; set __class__
      (PyObject-elements-set! cls 4 bases)  ;; set __bases__
      (PyObject-elements-set! cls 5 mro)    ;; set __mro__
      (PyObject-elements-set! cls 6 mod)    ;; set __module__
      (PyObject-elements-set! cls 7 name))) ;; set __name__

  (for-each set-attrs-with-python-values
            (list (vector py-object-class "builtins" "object")
                  (vector py-type-class   "builtins" "type")
                  (vector py-str-class    "builtins" "str")
                  (vector py-tuple-class  "builtins" "tuple")
                  (vector py-list-class   "builtins" "list"))))

(bootstrap-basic-types-phase2)

;(pp (py-str-to-scheme (py-str-from-scheme "abc")))
;(pp (py-tuple-to-scheme (py-tuple-from-scheme (vector 1 2 3))))
;(pp (py-list-to-scheme (py-list-from-scheme (vector 1 2 3))))
;(pp (py-str-from-scheme "abc"))
;(exit)

;(pp py-object-class)
;(pp py-type-class)
;(pp py-str-class)
;(pp py-tuple-class)
;(pp py-list-class)

;;;----------------------------------------------------------------------------

(define (py-compute-mro cls)

  (define seen '())

  (define (add-class cls classes)
    (if (memq cls seen)
        classes
        (begin
          (set! seen (cons cls seen))
          (cons cls (add-bases (py-cls-bases cls) classes)))))

  (define (add-bases bases classes)
    (let loop ((i (- (vector-length bases) 1)) (classes classes))
      (if (< i 0)
          classes
          (loop (- i 1) (add-class (vector-ref bases i) classes)))))

  (list->vector (add-class cls '())))

;;;----------------------------------------------------------------------------

(define (py-make-class name module bases . attrs)

  (define (make-cls attr-names attr-values)
    (let* ((has-init?
            (member (& "__init__") attr-names))
           (bases-vect
            (list->vector
             (if (null? bases)
                 (list py-object-class)
                 bases)))
           (cls
            #f)
           (hclass-of-instances
            #f))
          (set! cls
            (py-fun-alloc
             py-type-class
             py-type-hclass-of-instances
             (lambda args
               (let ((self (py-obj-alloc cls hclass-of-instances)))
                 (PyObject-elements-set! self 1 cls) ;; set __class__
                 (py-call-init self args)
                 self))))
          (PyObject-elements-set! cls 1 bases-vect) ;; set **bases**
          (let ((mro (py-compute-mro cls)))
            (PyObject-elements-set! cls 2 mro) ;; set **mro**
            (PyObject-elements-set! cls 3 py-type-class) ;; set __class__
            (PyObject-elements-set! cls 4 (py-tuple-from-scheme bases-vect)) ;; set __bases__
            (PyObject-elements-set! cls 5 (py-tuple-from-scheme mro)) ;; set __mro__
            (PyObject-elements-set! cls 6 (py-str-from-scheme (symbol->string module))) ;; set __module__
            (PyObject-elements-set! cls 7 (py-str-from-scheme (symbol->string name))) ;; set __name__
            (set! hclass-of-instances
              (make-HClass
               mro
               (vector
                (& "**class**") ;; read-only copy... is it needed?
                (& "__class__"))
               '()))
            (let loop ((attr-names attr-names) (attr-values attr-values))
              (if (pair? attr-names)
                  (begin
                    (py-own-attr-set! cls (car attr-names) (car attr-values))
                    (loop (cdr attr-names) (cdr attr-values)))))
            cls)))

  (let loop ((lst attrs)
             (rev-attr-names '())
             (rev-attr-values '()))
    (if (and (pair? lst) (pair? (cdr lst)))
        (let ((name (car lst))
              (value (cadr lst))
              (rest (cddr lst)))
          (if (eq? value (py-uninit))
              (loop rest
                    rev-attr-names
                    rev-attr-values)
              (loop rest
                    (cons name rev-attr-names)
                    (cons value rev-attr-values))))
        (make-cls (reverse rev-attr-names)
                  (reverse rev-attr-values)))))

(define py-default-init
  (py-procedure->function
   (lambda rest (error "__init__" "unimplemented generic procedure" #f))
   (lambda (self)
     self)))

;;;----------------------------------------------------------------------------

;;; Define other builtin classes.

(define py-int-class
  (py-make-class (& "int")
                 (& "builtins")
                 '()))

(define py-float-class
  (py-make-class (& "float")
                 (& "builtins")
                 '()))

(define py-bool-class
  (py-make-class (& "bool")
                 (& "builtins")
                 (list py-int-class)))

(define py-complex-class
  (py-make-class (& "complex")
                 (& "builtins")
                 '()))

(define py-slice-class
  (py-make-class (& "slice")
                 (& "builtins")
                 '()))

(define py-range-class
  (py-make-class (& "range")
                 (& "builtins")
                 '()))

;;;----------------------------------------------------------------------------

;;; Define constructors and methods of builtin classes.

(PyFunction-procedure-set!
 py-list-class
 (lambda (#!optional (iterable py-absent))
   (py-list-from-scheme
    (if (eq? iterable py-absent)
        (vector)
        (let ((iter (py-attr-ref iterable (& "__iter__"))))
          (if (eq? iter py-absent)
              (error "iter" "TypeError: object is not iterable" #f)
              (let ((iterator (py-call1 iter iterable)))
                (let loop ((elems '()))
                  (with-handler
                   (lambda (e)
                     (if (eq? e py-builtin-StopIteration)
                         (list->vector (reverse elems))
                         (py-throw e)))
                   (let ((e (py-call1 py-builtin-next iterator)))
                     (loop (cons e elems))))))))))))

(PyFunction-procedure-set!
 py-range-class
 (lambda (arg1 #!optional (arg2 py-absent) (arg3 py-absent))
   (cond ((eq? arg2 py-absent)
          ;; stop
          (py-range 0 arg1 1))
         ((eq? arg3 py-absent)
          ;; start, stop
          (py-range arg1 arg2 1))
         (else
          ;; start, stop, step
          (py-range arg1 arg2 arg3)))))

(define (py-range start stop step)
  (let ((hclass-of-instances
         (make-HClass
          (vector py-object-class)
          (vector (& "**class**")
                  (& "__class__")
                  (& "__iter__")
		  )
          '())))

    (define iter
      (py-procedure->function
       (lambda rest (error "__iter__" "unimplemented generic procedure" #f))
       (lambda (self)
         (let ((hclass-of-instances
                (make-HClass
                 (vector py-object-class)
                 (vector (& "**class**")
                         (& "__class__")
                         (& "__next__")
		         )
                 '())))
           (let ((i start))

             (define next
               (py-procedure->function
                (lambda rest (error "__next__" "unimplemented generic procedure" #f))
                (lambda (self)
                  (if (if (> step 0) (>= i stop) (<= i stop))
                      (py-throw py-builtin-StopIteration)
                      (let ((result i))
                        (set! i (+ i step))
                        result)))))

             (let ((self (py-obj-alloc py-object-class hclass-of-instances)))
               (PyObject-elements-set! self 1 py-object-class) ;; set __class__
               (PyObject-elements-set! self 2 next) ;; set __next__
               self))))))

    (let ((self (py-obj-alloc py-object-class hclass-of-instances)))
      (PyObject-elements-set! self 1 py-object-class) ;; set __class__
      (PyObject-elements-set! self 2 iter) ;; set __iter__
      self)))

;;;----------------------------------------------------------------------------

(define (py-make-global)
  (let ((mod
         (py-obj-alloc
          py-module-class
          (make-HClass
           (vector py-module-class py-object-class)
           (vector (& "**class**")
                   (& "__class__")
                   (& "__name__")
                   (& "__builtins__")
                   )
           '()))))

    (PyObject-elements-set! mod 1 py-module-class)
    (PyObject-elements-set! mod 2 (py-str-from-scheme "__main__"))
    (PyObject-elements-set! mod 3 (py-builtins-mod))

    mod))

    (define (py-make-base-global)
      (let ((mod
             (py-obj-alloc
              py-module-class
              (make-HClass
               (vector py-module-class py-object-class)
               (vector (& "**class**")
                       (& "__class__")
                       (& "__name__")
                       (& "__builtins__")
                       )
               '()))))

        (PyObject-elements-set! mod 1 py-module-class)
        (PyObject-elements-set! mod 2 (py-str-from-scheme "__main__"))
        (PyObject-elements-set! mod 3 (py-make-base-builtins-mod))

        mod))

#;
(define (alist->PyObject alist)
  (make-PyObject
   (make-HClass '#() (list->vector (map car alist)) '())
   (list->vector (map cdr alist))))

(define (py-make-list . elements)
  (py-list-from-scheme (list->vector elements)))

(define (py-make-set elements)
  (py-set-from-scheme (list->vector elements)))

#;
(define (py-list-from-scheme elements)
  (alist->PyObject
   (list (cons (& "__class__")
               py-list-class)
         (cons (& "__len__")
               (py-procedure->function
                (lambda rest (error "__len__" "unimplemented generic procedure" #f))
                (lambda (self)
                  (vector-length elements))))
         (cons (& "__getitem__")
               (py-procedure->function
                (lambda rest (error "__getitem__" "unimplemented generic procedure" #f))
                (lambda (self i)
                  (if (< i 0) (set! i (+ i (vector-length elements))))
                  (if (or (< i 0) (>= i (vector-length elements)))
                      (error "getitem" "index out of range" #f)
                      (vector-ref elements i)))))
         (cons (& "__setitem__")
               (py-procedure->function
                (lambda rest (error "__setitem__" "unimplemented generic procedure" #f))
                (lambda (self i val)
                  (if (< i 0) (set! i (+ i (vector-length elements))))
                  (if (or (< i 0) (>= i (vector-length elements)))
                      (error "setitem" "index out of range" #f)
                      (vector-set! elements i val)))))
         (cons (& "__iter__")
               (py-procedure->function
                (lambda rest (error "__iter__" "unimplemented generic procedure" #f))
                (lambda (self)
                  (let ((i 0))
                    (alist->PyObject
                     (list (cons (& "__next__")
                                 (py-procedure->function
                                  (lambda rest (error "__next__" "unimplemented generic procedure" #f))
                                  (lambda (self)
                                    (if (>= i (vector-length elements))
                                        (py-throw py-builtin-StopIteration)
                                        (let ((result (vector-ref elements i)))
                                          (set! i (+ i 1))
                                          result))))))))))))))

(define (py-make-tuple . elements)
  (py-tuple-from-scheme (list->vector elements)))

#;
(define (py-tuple-from-scheme elements)
  (alist->PyObject
   (list (cons (& "__class__")
               py-tuple-class)
         (cons (& "__len__")
               (py-procedure->function
                (lambda rest (error "__len__" "unimplemented generic procedure" #f))
                (lambda (self)
                  (vector-length elements))))
         (cons (& "__getitem__")
               (py-procedure->function
                (lambda rest (error "__getitem__" "unimplemented generic procedure" #f))
                (lambda (self i)
                  (if (< i 0) (set! i (+ i (vector-length elements))))
                  (if (or (< i 0) (>= i (vector-length elements)))
                      (error "getitem" "index out of range" #f)
                      (vector-ref elements i)))))
         (cons (& "__setitem__")
               (py-procedure->function
                (lambda rest (error "__setitem__" "unimplemented generic procedure" #f))
                (lambda (self i val)
                  (if (< i 0) (set! i (+ i (vector-length elements))))
                  (if (or (< i 0) (>= i (vector-length elements)))
                      (error "setitem" "index out of range" #f)
                      (vector-set! elements i val)))))
         (cons (& "__iter__")
               (py-procedure->function
                (lambda rest (error "__iter__" "unimplemented generic procedure" #f))
                (lambda (self)
                  (let ((i 0))
                    (alist->PyObject
                     (list (cons (& "__next__")
                                 (py-procedure->function
                                  (lambda rest (error "__next__" "unimplemented generic procedure" #f))
                                  (lambda (self)
                                    (if (>= i (vector-length elements))
                                        (py-throw py-builtin-StopIteration)
                                        (let ((result (vector-ref elements i)))
                                          (set! i (+ i 1))
                                          result))))))))))))))

(define (py-make-dict keys vals)
  (py-dict-from-scheme keys vals))

(define (py-string-to-name s)
  (string->symbol s))

(define (py-type obj)
  (py-obj-cls* obj)
  #;
  (cond ((and (PyObject? obj)
              (let ((index (PyObject-find-prop obj (& "__class__"))))
                (and (>= index 0)
                     index)))
         =>
         (lambda (index)
           (PyObject-elements-ref obj index)))
        ((flonum? obj)
         py-float-class)
        ((integer? obj)
         py-int-class)
        ((boolean? obj)
         py-bool-class)
	((eq? obj (py-none))
	 'none)
	((procedure? obj)
	 'function)
	((PyObject? obj)
	 'pyobj)
        (else
         (error "py-type" "unknown type" (typeof obj)))))

(define (py-print obj port)
  (display (py-str-scheme obj) port))

(define (py-str obj)
  (py-str-from-scheme (py-str-scheme obj)))

(define (py-str-scheme obj)
  (cond ((eq? obj 'None)
         "None")
        (else
         (let ((t (py-type obj)))
           (cond ((eq? t py-str-class)
                  (py-str-to-scheme obj))
                 ((eq? t py-list-class)
                  (py-list-repr-scheme obj))
                 ((eq? t py-tuple-class)
                  (py-tuple-repr-scheme obj))
                 ((eq? t py-dict-class)
                  (py-dict-repr-scheme obj))
                 ((eq? t py-set-class)
                  (py-set-repr-scheme obj))
                 ((eq? t py-type-class)
                  (string-append
                   "<class "
                   (py-str-repr-scheme
                    (let ((mod (py-str-to-scheme (PyObject-elements-ref obj 6)))
                          (name (py-str-to-scheme (PyObject-elements-ref obj 7))))
                      (if (equal? mod "builtins")
                          name
                          (string-append mod "." name))))
                   ">"))
                 ((eq? t py-module-class)
                  (string-append
                   "<module "
                   (let ((name (py-str-to-scheme (PyObject-elements-ref obj 2))))
                     (string-append
                      (py-str-repr-scheme name)
                      " "
                      (if (or (equal? name "builtins")
                              (equal? name "sys")
                              (equal? name "time"))
                          "(built-in)"
                          (let ((file (py-attr-ref obj (& "__file__"))))
                            (if (not (eq? file py-absent))
                                (string-append
                                 "from "
                                 (py-repr-scheme file))
                                "???")))))
                   ">"))
                 (else
                  (py-repr-scheme obj)))))))

(define (py-repr obj)
  (py-str-from-scheme (py-repr-scheme obj)))

(define (py-repr-scheme obj)
  (cond ((eq? obj 'None)
         "None")
        ((and (PyObject? obj)
              (let ((index (PyObject-find-prop obj (& "__repr__"))))
                (and (>= index 0)
                     index)))
         =>
         (lambda (index)
           (let ((__repr__ (PyObject-elements-ref obj index)))
             (py-str-to-scheme (py-call1 __repr__ obj)))))
        (else
         (let ((t (py-type obj)))
           (cond ((eq? t py-list-class)
                  (py-str-scheme obj))
                 ((eq? t py-tuple-class)
                  (py-str-scheme obj))
                 ((eq? t py-dict-class)
                  (py-str-scheme obj))
                 ((eq? t py-set-class)
                  (py-str-scheme obj))
                 ((eq? t py-type-class)
                  (py-str-scheme obj))
                 ((eq? t py-module-class)
                  (py-str-scheme obj))
                 ((eq? t py-str-class)
                  (py-str-repr-scheme (py-str-to-scheme obj)))
                 ((eq? t py-int-class)
                  (number->string obj))
                 ((eq? t py-float-class)
                  (number->string obj))
                 ((eq? t py-bool-class)
                  (if obj "True" "False"))
		 ((eq? t 'none)
		  "None")
		 ((eq? t 'function)
		  "<function>")
		 ((eq? t 'pyobj)
		  (format "~s" obj))
                 (else
                  "<unknown>"))))))

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

(define (py-list-repr-scheme list)
  (py-seq-repr-scheme list "[" "" "]"))

(define (py-tuple-repr-scheme tuple)
  (py-seq-repr-scheme tuple "(" "," ")"))

(define (py-set-repr-scheme set)
  (if (= 0 (py-call1 py-builtin-len set))
      "set()"
      (py-seq-repr-scheme set "{" "" "}")))

(define (py-seq-repr-scheme seq open one close)
  (let ((len (py-call1 py-builtin-len seq)))
    (let loop ((i (- len 1)) (elems '()))
      (if (>= i 0)
          (let ((x (py-repr-scheme (py-getitem seq i repr-cache))))
            (loop (- i 1)
                  (cons (string-append x (if (= i (- len 1)) "" ", ")) elems)))
          (string-append open
                         (apply string-append elems)
                         (if (= len 1) one "")
                         close)))))

(define (py-dict-repr-scheme dict)
  (let ((alist (py-dict-to-scheme dict)))
    (let loop ((lst alist) (elems '()))
      (if (pair? lst)
          (let* ((x (car lst))
                 (key (car x))
                 (val (cdr x))
                 (y (string-append
                     (py-repr-scheme key)
                     ": "
                     (py-repr-scheme val))))
            (loop (cdr lst)
                  (cons (string-append y (if (pair? (cdr lst)) ", " ""))
                        elems)))
          (string-append "{"
                         (apply string-append (reverse elems))
                         "}")))))

(define (py-chr i)
  (py-str-from-scheme (string (integer->char i))))

;;-------------------- abs(x)

;; Return the absolute value of a number. The argument may be an
;; integer or a floating point number. If the argument is a complex
;; number, its magnitude is returned. If x defines __abs__(), abs(x)
;; returns x.__abs__().

(define py-builtin-abs
  (py-procedure->function
   (lambda rest (error "abs" "unimplemented generic procedure for builtin" #f))
   (lambda (x)
     (abs x))))

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
  (py-procedure->function
   (lambda rest (error "all" "unimplemented generic procedure for builtin" #f))
   (lambda (iterable)
     (error "all" "not implemented" #f))))

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
  (py-procedure->function
   (lambda rest (error "any" "unimplemented generic procedure for builtin" #f))
   (lambda (iterable)
     (error "any" "not implemented" #f))))

;;-------------------- ascii(object)

;; As repr(), return a string containing a printable representation of an
;; object, but escape the non-ASCII characters in the string returned by
;; repr() using \x, \u or \U escapes. This generates a string similar to
;; that returned by repr() in Python 2.

(define py-builtin-ascii
  (py-procedure->function
   (lambda rest (error "ascii" "unimplemented generic procedure for builtin" #f))
   (lambda (object)
     (error "ascii" "not implemented" #f))))

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
  (py-procedure->function
   (lambda rest (error "bin" "unimplemented generic procedure for builtin" #f))
   (lambda (x)
     (error "bin" "not implemented" #f))))

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
  (py-procedure->function
   (lambda rest (error "breakpoint" "unimplemented generic procedure for builtin" #f))
   (lambda (args kws)
     (error "breakpoint" "not implemented" #f))))

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

(define py-builtin-bytearray
  (py-procedure->function
   (lambda rest (error "bytearray" "unimplemented generic procedure for builtin" #f))
   (lambda (source encoding errors)
     (error "bytearray" "not implemented" #f))))

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
  (py-procedure->function
   (lambda rest (error "bytes" "unimplemented generic procedure for builtin" #f))
   (lambda (source encoding errors)
     (error "bytes" "not implemented" #f))))

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
  (py-procedure->function
   (lambda rest (error "callable" "unimplemented generic procedure for builtin" #f))
   (lambda (object)
     (error "callable" "not implemented" #f))))

;;-------------------- chr(i)

;; Return the string representing a character whose Unicode code point is
;; the integer i. For example, chr(97) returns the string 'a', while
;; chr(8364) returns the string '€'. This is the inverse of ord().
;;
;; The valid range for the argument is from 0 through 1,114,111 (0x10FFFF
;; in base 16). ValueError will be raised if i is outside that range.

(define py-builtin-chr
  (py-procedure->function
   (lambda rest (error "chr" "unimplemented generic procedure for builtin" #f))
   (lambda (i)
     (py-chr i))))

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
  (py-procedure->function
   (lambda rest (error "classmethod" "unimplemented generic procedure for builtin" #f))
   (lambda ()
     (error "classmethod" "not implemented" #f))))

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
  (py-procedure->function
   (lambda rest (error "compile" "unimplemented generic procedure for builtin" #f))
   (lambda (source filename mode flags dont_inherit optimize)
     (error "compile" "not implemented" #f))))

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
  (py-procedure->function
   (lambda rest (error "delattr" "unimplemented generic procedure for builtin" #f))
   (lambda (object name)
     (error "delattr" "not implemented" #f))))

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
  (py-procedure->function
   (lambda rest (error "dir" "unimplemented generic procedure for builtin" #f))
   (lambda (object)
     (error "dir" "not implemented" #f))))

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
  (py-procedure->function
   (lambda rest (error "divmod" "unimplemented generic procedure for builtin" #f))
   (lambda (a b)
     (error "divmod" "not implemented" #f))))

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
  (py-procedure->function
   (lambda rest (error "enumerate" "unimplemented generic procedure for builtin" #f))
   (lambda (iterable start)
     (error "enumerate" "not implemented" #f))))

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
  (py-procedure->function
   (lambda rest (error "eval" "unimplemented generic procedure for builtin" #f))
   (lambda (expression globals locals)
     (error "eval" "not implemented" #f))))

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
  (py-procedure->function
   (lambda rest (error "exec" "unimplemented generic procedure for builtin" #f))
   (lambda (object globals locals)
     (error "eval" "not implemented" #f))))

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
  (py-procedure->function
   (lambda rest (error "filter" "unimplemented generic procedure for builtin" #f))
   (lambda (function iterable)
     (error "filter" "not implemented" #f))))

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
  (py-procedure->function
   (lambda rest (error "format" "unimplemented generic procedure for builtin" #f))
   (lambda (value format_spec)
     (error "format" "not implemented" #f))))

;;-------------------- class frozenset([iterable])

;; Return a new frozenset object, optionally with elements taken from
;; iterable. frozenset is a built-in class. See frozenset and Set Types —
;; set, frozenset for documentation about this class.
;;
;; For other containers see the built-in set, list, tuple, and dict
;; classes, as well as the collections module.

(define py-builtin-frozenset
  (py-procedure->function
   (lambda rest (error "frozenset" "unimplemented generic procedure for builtin" #f))
   (lambda (iterable)
     (error "frozenset" "not implemented" #f))))

;;-------------------- getattr(object, name[, default])

;; Return the value of the named attribute of object. name must be a
;; string. If the string is the name of one of the object’s attributes,
;; the result is the value of that attribute. For example, getattr(x,
;; 'foobar') is equivalent to x.foobar. If the named attribute does not
;; exist, default is returned if provided, otherwise AttributeError is
;; raised.

(define py-builtin-getattr
  (py-procedure->function
   (lambda rest (error "getattr" "unimplemented generic procedure for builtin" #f))
   (lambda (object name default)
     (error "getattr" "not implemented" #f))))

;;-------------------- globals()

;; Return a dictionary representing the current global symbol table. This
;; is always the dictionary of the current module (inside a function or
;; method, this is the module where it is defined, not the module from
;; which it is called).

(define py-builtin-globals
  (py-procedure->function
   (lambda rest (error "globals" "unimplemented generic procedure for builtin" #f))
   (lambda ()
     (error "globals" "not implemented" #f))))

;;-------------------- hasattr(object, name)

;; The arguments are an object and a string. The result is True if the
;; string is the name of one of the object’s attributes, False if
;; not. (This is implemented by calling getattr(object, name) and seeing
;; whether it raises an AttributeError or not.)

(define py-builtin-hasattr
  (py-procedure->function
   (lambda rest (error "hasattr" "unimplemented generic procedure for builtin" #f))
   (lambda (object name)
     (let ((val (py-attr-ref object name)))
       (not (eq? val py-absent))))))

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
  (py-procedure->function
   (lambda rest (error "hash" "unimplemented generic procedure for builtin" #f))
   (lambda (object)
     (error "hash" "not implemented" #f))))

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
  (py-procedure->function
   (lambda rest (error "help" "unimplemented generic procedure for builtin" #f))
   (lambda _
     (error "help" "not implemented" #f))))

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
  (py-procedure->function
   (lambda rest (error "hex" "unimplemented generic procedure for builtin" #f))
   (lambda (x)
     (error "hex" "not implemented" #f))))

;;-------------------- id(object)

;; Return the “identity” of an object. This is an integer which is
;; guaranteed to be unique and constant for this object during its
;; lifetime. Two objects with non-overlapping lifetimes may have the same
;; id() value.
;;
;; CPython implementation detail: This is the address of the object in
;; memory.

(define py-builtin-id
  (py-procedure->function
   (lambda rest (error "id" "unimplemented generic procedure for builtin" #f))
   (lambda (object)
     (error "id" "not implemented" #f))))

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
  (py-procedure->function
   (lambda rest (error "input" "unimplemented generic procedure for builtin" #f))
   (lambda (prompt)
     (error "input" "not implemented" #f))))

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
  (py-procedure->function
   (lambda rest (error "isinstance" "unimplemented generic procedure for builtin" #f))
   (lambda (object classinfo)
     (error "isinstance" "not implemented" #f))))

;;-------------------- issubclass(class, classinfo)

;; Return true if class is a subclass (direct, indirect or virtual) of
;; classinfo. A class is considered a subclass of itself. classinfo may
;; be a tuple of class objects, in which case every entry in classinfo
;; will be checked. In any other case, a TypeError exception is raised.

(define py-builtin-issubclass
  (py-procedure->function
   (lambda rest (error "issubclass" "unimplemented generic procedure for builtin" #f))
   (lambda (object classinfo)
     (error "issubclass" "not implemented" #f))))

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
  (py-procedure->function
   (lambda rest (error "iter" "unimplemented generic procedure for builtin" #f))
   (lambda (object #!optional (sentinel py-absent))
     (cond ((not (eq? sentinel py-absent))
            (error "iter" "with 2 arguments not implemented" #f))
           ((and (PyObject? object)
                 (let ((index (PyObject-find-prop object (& "__iter__"))))
                   (and (>= index 0)
                        index)))
            =>
            (lambda (index)
              (let ((__iter__ (PyObject-elements-ref object index)))
                (py-call1 __iter__ object))))
           (else
            (error "iter" "only object with __iter__ method implemented" #f))))))

;;-------------------- len(s)

;; Return the length (the number of items) of an object. The argument may
;; be a sequence (such as a string, bytes, tuple, list, or range) or a
;; collection (such as a dictionary, set, or frozen set).

(define py-builtin-len
  (py-procedure->function
   (lambda rest (error "len" "unimplemented generic procedure for builtin" #f))
   (lambda (s)
     (py-len s))))

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
  (py-procedure->function
   (lambda rest (error "locals" "unimplemented generic procedure for builtin" #f))
   (lambda ()
     (error "locals" "not implemented" #f))))

;;-------------------- map(function, iterable, ...)

;; Return an iterator that applies function to every item of iterable,
;; yielding the results. If additional iterable arguments are passed,
;; function must take that many arguments and is applied to the items
;; from all iterables in parallel. With multiple iterables, the
;; iterator stops when the shortest iterable is exhausted. For cases
;; where the function inputs are already arranged into argument
;; tuples, see itertools.starmap().

(define py-builtin-map
  (py-procedure->function
   (lambda rest (error "map" "unimplemented generic procedure for builtin" #f))
   (lambda (function iterable)
     (error "map" "not implemented" #f))))

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
  (py-procedure->function
   (lambda rest (error "max" "unimplemented generic procedure for builtin" #f))
   (lambda (iterable key default)
     (error "max" "not implemented" #f))))

;;-------------------- memoryview(obj)

;; Return a “memory view” object created from the given argument. See
;; Memory Views for more information.

(define py-builtin-memoryview
  (py-procedure->function
   (lambda rest (error "memoryview" "unimplemented generic procedure for builtin" #f))
   (lambda (obj)
     (error "memoryview" "not implemented" #f))))

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
  (py-procedure->function
   (lambda rest (error "min" "unimplemented generic procedure for builtin" #f))
   (lambda (iterable key default)
     (error "min" "not implemented" #f))))

;;-------------------- next(iterator[, default])

;; Retrieve the next item from the iterator by calling its __next__()
;; method. If default is given, it is returned if the iterator is
;; exhausted, otherwise StopIteration is raised.

(define py-builtin-next
  (py-procedure->function
   (lambda rest (error "next" "unimplemented generic procedure for builtin" #f))
   (lambda (iterator #!optional (default py-absent))
     (let ((next (py-attr-ref iterator (& "__next__"))))
       (if (eq? iterator py-absent)
           (error "next" "TypeError: object is not an iterator" #f)
           (if (eq? default py-absent)
               (py-call1 next iterator)
               (with-handler
                (lambda (e)
                  (if (eq? e py-builtin-StopIteration)
                      default
                      (py-throw e)))
                (py-call1 next iterator))))))))

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
  (py-procedure->function
   (lambda rest (error "oct" "unimplemented generic procedure for builtin" #f))
   (lambda (x)
     (error "oct" "not implemented" #f))))

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
  (py-procedure->function
   (lambda rest (error "open" "unimplemented generic procedure for builtin" #f))
   (lambda (file mode buffering encoding errors newline closefd opener)
     (error "open" "not implemented" #f))))

;;-------------------- ord(c)

;; Given a string representing one Unicode character, return an
;; integer representing the Unicode code point of that character. For
;; example, ord('a') returns the integer 97 and ord('€') (Euro sign)
;; returns 8364. This is the inverse of chr().

(define py-builtin-ord
  (py-procedure->function
   (lambda rest (error "ord" "unimplemented generic procedure for builtin" #f))
   (lambda (c)
     (error "ord" "not implemented" #f))))

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
  (py-procedure->function
   (lambda rest (error "pow" "unimplemented generic procedure for builtin" #f))
   (lambda (x y z)
     (error "pow" "not implemented" #f))))

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
  (py-procedure->function
   (lambda rest (error "print" "unimplemented generic procedure for builtin" #f))
   (lambda objects ;; objects sep end file flush)
     ;;(pp objects)
     (let ((port (current-output-port)))
       (let loop ((lst objects))
         (if (pair? lst)
             (let ((rest (cdr lst)))
               (py-print (car lst) port)
               (if (pair? rest)
                   (begin
                     (display " " port)
                     (loop rest))))))
       (newline port)))))

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
  (py-procedure->function
   (lambda rest (error "property" "unimplemented generic procedure for builtin" #f))
   (lambda (fget fset fdel doc)
     (error "property" "not implemented" #f))))

;;-------------------- range(stop)
;;                     range(start, stop[, step])

;; Rather than being a function, range is actually an immutable sequence
;; type, as documented in Ranges and Sequence Types — list, tuple, range.

(define py-builtin-range py-range-class)

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
  (py-procedure->function
   (lambda rest (error "repr" "unimplemented generic procedure for builtin" #f))
   (lambda (object)
     (py-repr object))))

;;-------------------- reversed(seq)

;; Return a reverse iterator. seq must be an object which has a
;; __reversed__() method or supports the sequence protocol (the __len__()
;; method and the __getitem__() method with integer arguments starting at
;; 0).

(define py-builtin-reversed
  (py-procedure->function
   (lambda rest (error "reversed" "unimplemented generic procedure for builtin" #f))
   (lambda (seq)
     (error "reversed" "not implemented" #f))))

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
  (py-procedure->function
   (lambda rest (error "round" "unimplemented generic procedure for builtin" #f))
   (lambda (number ndigits)
     (error "round" "not implemented" #f))))

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
  (py-procedure->function
   (lambda rest (error "setattr" "unimplemented generic procedure for builtin" #f))
   (lambda (object name value)
     (error "setattr" "not implemented" #f))))

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
  (py-procedure->function
   (lambda rest (error "sorted" "unimplemented generic procedure for builtin" #f))
   (lambda (iterable key reverse)
     (error "sorted" "not implemented" #f))))

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
  (py-procedure->function
   (lambda rest (error "staticmethod" "unimplemented generic procedure for builtin" #f))
   (lambda ()
     (error "staticmethod" "not implemented" #f))))

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
  (py-procedure->function
   (lambda rest (error "sum" "unimplemented generic procedure for builtin" #f))
   (lambda (iterable start)
     (error "sum" "not implemented" #f))))

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

(define py-builtin-super
  (py-procedure->function
   (lambda rest (error "super" "unimplemented generic procedure for builtin" #f))
   (lambda (type object-or-type)
     (error "super" "not implemented" #f))))

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
  (py-procedure->function
   (lambda rest (error "vars" "unimplemented generic procedure for builtin" #f))
   (lambda (object)
     (error "vars" "not implemented" #f))))

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
  (py-procedure->function
   (lambda rest (error "zip" "unimplemented generic procedure for builtin" #f))
   (lambda (iterables)
     (error "zip" "not implemented" #f))))

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
  (py-procedure->function
   (lambda rest (error "__import__" "unimplemented generic procedure for builtin" #f))
   (lambda (name globals locals fromlist level)
     (error "__import__" "not implemented" #f))))

;;-------------------- BaseException

;; The base exception cannot be created in pure Python
;; All exception must inherit from it to be considered an exception

(define py-builtin-BaseException
  (py-make-class
    (& "BaseException")
    (& "builtins")
    '()))

(define py-builtin-ValueError #f)

(define py-builtin-NameError #f)

(define py-builtin-StopIteration #f)

(define py-builtin-ArithmeticError #f)

(define py-builtin-ZeroDivisionError #f)

(define py-builtin-AttributeError #f)
