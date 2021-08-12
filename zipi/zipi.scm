(define (main . args)
  (let ((help      #f)
        (compile   #t)
        (debug     #f)
        (profile   #f)
        (expansion #f)
        (reset     #f)
        (version   0) ;; count number of -V
        (file      #f)
        (argv      #f))

    (let loop ((args args))
      (if (pair? args)
          (let ((arg (car args))
                (rest (cdr args)))
            (cond ((and (pair? rest) (member arg '("-X")))
                   (let ((option (car rest)))
                     (cond ((string=? option "compile")
                            (set! compile #t))
                           ((string=? option "interpret")
                            (set! compile #f))
                           ((string=? option "debug")
                            (set! debug #t))
                           ((string=? option "flamegraph")
                            (let ((p (or profile '())))
                              (set! profile
                                (if (member 'flamegraph p)
                                    p
                                    (cons 'flamegraph p)))))
                           ((string=? option "profile")
                            (let ((p (or profile '())))
                              (set! profile
                                (if (member 'profile p)
                                    p
                                    (cons 'profile p)))))
                           ((string=? option "expansion")
                            (set! expansion #t))
                           ((string=? option "reset")
                            (set! reset #t))
                           (else
                            (print "*** ignoring option -X " option)))
                     (loop (cdr rest))))
                  ((member arg '("-h" "-?" "--help"))
                   (set! help #t)
                   (loop rest))
                  ((member arg '("-V"))
                   (set! version (+ version 1))
                   (loop rest))
                  ((member arg '("-VV"))
                   (set! version (+ version 2))
                   (loop rest))
                  (else
                   (if (and (>= (string-length arg) 1)
                            (char=? (string-ref arg 0) #\-))
                       (begin
                         (print "*** ignoring option " arg)
                         (loop rest))
                       (begin
                         (set! file arg)
                         (set! argv (cons arg rest)))))))))

    (cond (help
           (usage))
          ((>= version 1)
           (print "Zipi " (zipi-version))
           (if (>= version 2)
               (print "git branch: " (zipi-branch))))
          (else

           (if (or reset expansion) (reset-cache))

           (if (not file)
               (if (not reset) (usage))
               (let ((path (path-normalize file)))
		  (run path argv compile debug profile expansion)))))))

(define (usage)
   (print (string-append "usage: zipi"
	     " [option] ... [file] [arg] ...\n"
	     "options and arguments:\n"
	     "  -h     : print this help message and exit (also --help)\n"
	     "   V     : print the zipi version number and exit (also --version)\n"
	     "         when given twice, print more information about the build\n"
	     "   X opt : system dependent option:\n"
	     "          compile     compile Scheme program\n"
	     "          interpret   interpret Scheme program\n"
	     "          debug       generate debugging information in compiled code\n"
	     "          flamegraph  generate statistical profile as a flamegraph\n"
	     "          profile     generate statistical profile as .html files\n"
	     "          expansion   show Scheme code of module after expansion\n"
	     "          reset       reset the zipi module cache\n"
	     
	     )))


