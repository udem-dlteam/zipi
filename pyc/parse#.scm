(define (pysexp file libdir)
   (open-process
      (list path: (path-expand "scmast.py" libdir)
	 arguments: (list file))))
