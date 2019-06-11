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
       (error "call0" "wrong call" fun)))

(define (PyFunction-call2 fun a0 a1)
   (if (and (isa? fun PyFunction) (correct-arity? (PyFunction-procedure fun) 2))
       ((PyFunction-procedure fun) a0 a1)
       (error "call0" "wrong call" fun)))

(define (PyFunction-call3 fun a0 a1 a2)
   (if (and (isa? fun PyFunction) (correct-arity? (PyFunction-procedure fun) 2))
       ((PyFunction-procedure fun) a0 a1 a2)
       (error "call0" "wrong call" fun)))

(define (PyFunction-call4 fun a0 a1 a2 a3)
   (if (and (isa? fun PyFunction) (correct-arity? (PyFunction-procedure fun) 2))
       ((PyFunction-procedure fun) a0 a1 a2 a3)
       (error "call0" "wrong call" fun)))
