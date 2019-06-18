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
			(lambda (self) (py-generator-send self "NONE")))
		     (py-procedure->function
			(lambda rest (error "send" "not implemented" #f))
			py-generator-send))
		  proc)))
      o))

(define (py-generator-send gen val)
   (let ((r ((PyGenerator-%next gen) val #f)))
      (if (eq? r 'StopIteration)
	  (tprint "TODO")
	  r)))
      
		     
