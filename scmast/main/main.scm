(define passes-beval
   (list (cons "symbol" py-symbol!)
      (cons "return" py-return)
      (cons "locals" py-locals)
      (cons "beval" py-beval)))
#;
(define passes-scheme
   (list (cons "symbol" py-symbol!)
      (cons "return" py-return)
      (cons "locals" py-locals)
      (cons "scheme" py-scheme)))
#;
(define passes-javascript
   (list (cons "symbol" py-symbol!)
      (cons "return" py-return)
      (cons "locals" py-locals)
      (cons "javascript" py-javascript)))

(define (pyc conf)
   (let* ((src (config-get conf 'src))
	  (ast (if src
		   (py-sexp (call-with-input-file src read) '())
		   (py-sexp (read) '())))
	  (env (getenv "PYTRACE"))
	  (conf (cons* 'trace (and (string? env) (string-contains env "trace"))
		   'tmp (make-file-path (os-tmp)
			   (or (getenv "USER") "anonymous") "PYC")
		   conf))
	  (passes (case (config-get conf 'target)
		     ((beval) passes-beval)
		     ((javascript) passes-javascript)
		     ((scheme) passes-javascript)
		     (else (error "pyc" "Unknown target language"
			      (config-get conf 'target))))))
      (compile-pyc ast passes conf)))

(define (compile-pyc ast passes conf)
   (let ((tracedir (make-file-name (config-get conf 'tmp)
		      (config-get conf 'filename "stdin"))))
      (when (config-get conf 'trace)
	 (make-directories tracedir))
      (let loop ((ast ast)
		 (passes passes))
	 (when (pair? passes)
	    (when (config-get conf 'verbose)
	       (display "  . ")
	       (display (caar passes))
	       (newline))
	    (let ((nast ((cdar passes) ast conf)))
	       (when (config-get conf 'trace)
		  (call-with-output-file (make-file-path tracedir (caar passes))
		     (lambda (p)
			(fprint p ";; -*-bee-*-")
			(fprint p ";; " (caar passes))
			(pp (py->list nast) p))))
	       (loop nast (cdr passes)))))))

(define (config-get conf key . def)
   (let ((c (memq key conf)))
      (if c (cadr c) (if (pair? def) (car def) #f))))
	       
   
       
