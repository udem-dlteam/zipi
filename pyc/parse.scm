;*---------------------------------------------------------------------*/
;*    pyc-parse ...                                                    */
;*---------------------------------------------------------------------*/
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
	  (pysexp port-or-file
		   (config-get conf bin-dir: (zipi-bin-dir))))
      conf))

;*---------------------------------------------------------------------*/
;*    pysexp ...                                                       */
;*---------------------------------------------------------------------*/
(cond-expand
   (bigloo

    (define (pysexp file::bstring path::bstring)
       (read (process-output-port
	  (run-process (make-file-path path "pysexp.py") file
	     :input :pipe :output :pipe)))))

   (gambit

    (define (pysexp file path)
      (let* ((process
             (open-process
      	        (list
                  path: (path-expand "pysexp.py" path)
      	          arguments: (list file))))
             (content (read process)))
        (if (= (process-status process) 0)
          content
          (exit #f))))))
