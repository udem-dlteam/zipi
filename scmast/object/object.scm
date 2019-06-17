(define (global-get global name cache)
   (if (eq? (PyObject-hclass global) (PCache-hclass cache))
       (PyObject-elements-ref global (PCache-index cache))
       (global-get/miss global name cache)))

(define (global-get/miss obj name cache)
   (let ((index (PyObject-find-prop obj name)))
      (cond
	 ((>= index 0)
	  (PCache-set! cache (PyObject-hclass obj) index)
	  (PyObject-elements-ref obj index))
	 (else
	  (let* ((__builtins__ (PyObject-elements-ref obj 0))
		 (idxb (PyObject-find-prop __builtins__ name)))
	     (if (>=fx idxb 0)
		 (PyObject-elements-ref __builtins__ idxb)
		 (error "NameError" "global name is not defined" name)))))))

(define (global-put! global name val cache)
   (if (eq? (PyObject-hclass global) (PCache-hclass cache))
       (PyObject-elements-set! global (PCache-index cache) val)
       (global-put!/miss global name val cache)))

(define (global-put!/miss obj name val cache)
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

(define (PyObject-find-prop obj name)
   (let* ((hclass (PyObject-hclass obj))
	  (names (HClass-names hclass)))
      (let loop ((i (- (vector-length names) 1)))
	 (cond
	    ((= i -1) i)
	    ((eq? name (vector-ref names i)) i)
	    (else (loop (- i 1)))))))

(define fun-hclass
   (make-HClass '#() '()))

(define (PyFunction-default-hclass)
   fun-hclass)

(define (py-procedure->function proc)
   (make-PyFunction (PyFunction-default-hclass) '#() proc))

(define (PyFunction-call0 fun)
   (if (and (isa? fun PyFunction) (correct-arity? (PyFunction-procedure fun) 0))
       ((PyFunction-procedure fun))
       (error "call0" "wrong call" fun)))

(define (PyFunction-call1 fun a0)
   (if (and (isa? fun PyFunction) (correct-arity? (PyFunction-procedure fun) 1))
       ((PyFunction-procedure fun) a0)
       (error "call1" "wrong call" fun)))

(define (PyFunction-call2 fun a0 a1)
   (if (and (isa? fun PyFunction) (correct-arity? (PyFunction-procedure fun) 2))
       ((PyFunction-procedure fun) a0 a1)
       (error "call2" "wrong call" fun)))

(define (PyFunction-call3 fun a0 a1 a2)
   (if (and (isa? fun PyFunction) (correct-arity? (PyFunction-procedure fun) 2))
       ((PyFunction-procedure fun) a0 a1 a2)
       (error "call3" "wrong call" fun)))

(define (PyFunction-call4 fun a0 a1 a2 a3)
   (if (and (isa? fun PyFunction) (correct-arity? (PyFunction-procedure fun) 2))
       ((PyFunction-procedure fun) a0 a1 a2 a3)
       (error "call4" "wrong call" fun)))

(define (py-make-global)
   (let* ((hclass0 (make-HClass (vector (& "print") (& "locals")) '()))
	  (hclass1 (make-HClass (vector (& "__builtins__")) '()))
	  (__builtins__ (make-PyObject hclass0 '#(- -)))
	  (%global (make-PyObject hclass1 (vector __builtins__))))
      (PyObject-elements-set! __builtins__ 0 (py-procedure->function print))
      (PyObject-elements-set! __builtins__ 1 "locals")))

(define (py-make-caches size)
   (list->vector
      (map (lambda (n) (make-PCache #f -1))
	 (iota size))))
   
