(define (pyc-parse port-or-file conf)
   (when (>= (config-get conf verbose: 0) 2)
      (display " [")
      (display (config-get conf bin-dir: (zipi-bin-dir)))
      (display "/pysexp.py ")
      (display port-or-file)
      (display "] "))
   (pyc-sexp
      (if (input-port? port-or-file)
	  (read port-or-file)
	  (read (pysexp port-or-file
		   (config-get conf bin-dir: (zipi-bin-dir)))))
      conf))
