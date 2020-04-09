(define py-generator-hclass
  (make-HClass
   '#()
   (vector
    (& "**class**")
    (& "__class__")
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
                     py-object-class
                     py-object-class
		  (procedure->py-function (lambda (self) (py-generator-send self py-None)))
		  (procedure->py-function py-generator-send))
		  proc)))
      o))

(define (py-generator-send gen val)
   (let ((r ((PyGenerator-%next gen) val #f)))
      (if (eq? r 'StopIteration)
	  (py-throw 'StopIteration)
	  r)))

(define (py-for-next iterator)
  (let ((next (getattribute-from-obj-mro iterator (& "__next__"))))
     (with-handler
        (lambda (e)
          (if (and (PyObject? e) (py-isinstance? e py-builtin-StopIteration))
  	         #f
  	         (raise e)))
        (py-call next iterator))))
