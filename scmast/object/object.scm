(define (PyObject-find-prop obj name)
   (let* ((hclass (PyObject-hclass obj))
	  (names (HClass-names hclass)))
      (let loop ((i (- (vector-length names) 1)))
	 (cond
	    ((= i -1) i)
	    ((eq? name (vector-ref names i)) i)
	    (else (loop (- i 1)))))))
