(define py-generator-hclass
   (make-HClass
      (vector
	 (& "__next__")
	 (& "send"))
      '()))

(define (py-generator-yield gen val kont)
   (PyGenerator-%next-set! gen kont)
   val)

(define (py-make-generator proc)
   (letrec ((o (make-PyGenerator
		  py-generator-hclass
		  (vector
		     (py-procedure->function
			(lambda rest (error "__next__" "not implemented" #f))
			(lambda (self) (py-generator-send self (py-none))))
		     (py-procedure->function
			(lambda rest (error "send" "not implemented" #f))
			py-generator-send))
		  proc)))
      o))

(define (py-generator-send gen val)
   (let ((r ((PyGenerator-%next gen) val #f)))
      (if (eq? r 'StopIteration)
	  (py-throw 'StopIteration)
	  r)))
      
(define (py-for-next iterator next)
   (with-handler
      (lambda (e)
	 (if (eq? e 'StopIteration)
	     e
	     (py-throw e)))
      (PyFunction-call1 next iterator)))
