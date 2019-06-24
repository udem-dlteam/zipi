(define passes-beval
   (list (cons "symbol" py-symbol!)
      (cons "return" py-return)
      (cons "break" py-break)
      (cons "locals" py-locals)
      (cons "generator" py-generator)
      (cons "cps" py-cps)
      (cons "beval" py-beval)))

(define passes-scheme
   (list (cons "symbol" py-symbol!)
      (cons "return" py-return)
      (cons "break" py-break)
      (cons "locals" py-locals)
      (cons "generator" py-generator)
      (cons "cps" py-cps)
      (cons "scheme" py-scheme)
      (cons "eval" py-scheme-eval)))

(define passes-bigloo
   (list (cons "symbol" py-symbol!)
      (cons "return" py-return)
      (cons "break" py-break)
      (cons "locals" py-locals)
      (cons "generator" py-generator)
      (cons "cps" py-cps)
      (cons "scheme" py-scheme)
      (cons "bigloo" py-scheme-bigloo)))

(define passes-gambit
   (list (cons "symbol" py-symbol!)
      (cons "return" py-return)
      (cons "break" py-break)
      (cons "locals" py-locals)
      (cons "generator" py-generator)
      (cons "cps" py-cps)
      (cons "scheme" py-scheme)
      (cons "gambit" py-scheme-gambit)))

(define passes-javascript
   (list (cons "symbol" py-symbol!)
      (cons "locals" py-locals)
      (cons "generator" py-generator)
      (cons "javascript" py-javascript)))

(define (pyc conf)
   (let* ((src (config-get conf 'src))
	  (ast (if src
		   (py-sexp (scmast.py src) '())
		   (py-sexp (read) '())))
	  (env (getenv "PYTRACE"))
	  (conf (cons* 'trace
		   (and (string? env) (string-contains env "pyc:dump"))
		   'tmp (make-file-path (os-tmp)
			   (or (getenv "USER") "anonymous") "PYC")
		   conf))
	  (passes (case (config-get conf 'target)
		     ((beval) passes-beval)
		     ((scheme) passes-scheme)
		     ((bigloo) passes-bigloo)
		     ((gambit) passes-gambit)
		     ((javascript) passes-javascript)
		     (else (error "pyc" "Unknown target language"
			      (config-get conf 'target))))))
      (compile-pyc ast passes conf)))

(define (compile-pyc ast passes conf)
   (let ((tracedir (make-file-name (config-get conf 'tmp)
		      (config-get conf 'filename "stdin"))))
      (when (config-get conf 'trace)
	 (make-directories tracedir)
	 (dump-trace tracedir "sexp" ast))
      (let loop ((ast ast)
		 (passes passes))
	 (when (pair? passes)
	    (when (>= (config-get conf 'verbose 0) 1)
	       (display "  . " (current-error-port))
	       (display (caar passes) (current-error-port))
	       (newline (current-error-port)))
	    (let ((nast ((cdar passes) ast conf)))
	       (when (config-get conf 'trace)
		  (dump-trace tracedir (caar passes) nast))
	       (loop nast (cdr passes)))))))

(define (dump-trace tracedir pass ast)
   (call-with-output-file (make-file-path tracedir pass)
      (lambda (p)
	 (fprint p ";; -*-bee-*-")
	 (fprint p ";; " pass)
	 (pp (py->list ast) p))))

(define (config-get conf key . def)
   (let ((c (memq key conf)))
      (if c (cadr c) (if (pair? def) (car def) #f))))
	       
   
(cond-expand
  (bigloo

   (define-macro (get-build-path) (pwd))
		 
   (define build-path (get-build-path))
      
   (define (scmast.py file)
     (let ((all-args
            (append (list (make-file-path build-path "./scmast.py") file)
                    (list :input :pipe
		       :output :pipe))))
       (let* ((proc (apply run-process all-args))
              (result (read (process-output-port proc))))
         result))))

  (gambit

   (define (scmast.py file)
     (let ((dir (path-expand ".." (path-directory (car (command-line))))))
       (let* ((port (open-process (list path: (path-expand "scmast.py" dir)
                                        arguments: (list file))))
              (result (read port)))
         result)))))
