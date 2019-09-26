(define (pyc-parse port-or-file conf)
   (when (>= (config-get conf verbose: 0) 2)
      (display " [")
      (display (config-get conf etc-dir: (zipi-etc-dir)))
      (display "/pysexp.py ")
      (display port-or-file)
      (display "] "))
   (pyc-sexp
      (if (input-port? port-or-file)
	  (read port-or-file)
	  (read (pysexp port-or-file
		   (config-get conf etc-dir: (zipi-etc-dir)))))
      conf))

;*---------------------------------------------------------------------*/
;*    pysexp ...                                                       */
;*---------------------------------------------------------------------*/
(cond-expand
   (bigloo

    (define (pysexp file::bstring etcdir::bstring)
      (process-output-port
       (run-process (make-file-path etcdir "pysexp.py") file
	            :input :pipe :output :pipe))))
   
   (gambit

    (define (pysexp file etcdir)
      (open-process
       (list path: (path-expand "pysexp.py" etcdir)
	     arguments: (list file))))))
