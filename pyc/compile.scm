(define (pyc-scheme-driver)
   `(("symbol" ,pyc-symbol!)
     ("return" ,pyc-return)
     ("break" ,pyc-break)
     ("locals" ,pyc-locals)
     ("generator" ,pyc-generator)
     ("cps" ,pyc-cps)
     ("scheme" ,pyc-scheme)))

(define (pyc-bigloo-driver)
   `(("symbol" ,pyc-symbol!)
     ("return" ,pyc-return)
     ("break" ,pyc-break)
     ("locals" ,pyc-locals)
     ("generator" ,pyc-generator)
     ("cps" ,pyc-cps)
     ("scheme" ,pyc-scheme)
     ("bigloo" ,pyc-scheme-bigloo)))

(define (pyc-gambit-driver)
   `(("symbol" ,pyc-symbol!)
     ("return" ,pyc-return)
     ("break" ,pyc-break)
     ("locals" ,pyc-locals)
     ("generator" ,pyc-generator)
     ("cps" ,pyc-cps)
     ("scheme" ,pyc-scheme)
     ("gambit" ,pyc-scheme-gambit)))

(define (pyc-javascript-driver)
   `(("symbol" ,pyc-symbol!)
     ("locals" ,pyc-locals)
     ("generator" ,pyc-generator)
     ("javascript" ,pyc-javascript)))

(define (absolute path)
   (if (char=? (string-ref path 0) #\/)
       path
       (make-file-name (pwd) path)))

(define (pyc driver conf)
   (let* ((src (config-get conf 'src))
          (ast (if src
                   (pyc-sexp (scmast.py src) '())
                   (pyc-sexp (read) '())))
          (env (getenv "PYTRACE"))
          (conf (cons*
                   'trace (and (string? env) (string-contains env "pyc:dump"))
                   'tmp (make-file-path (os-tmp)
                           (or (getenv "USER") "anonymous") "PYC")
                   conf)))
      (pyc-compile ast driver conf)))

(define (pyc-compile ast passes conf)
   (let ((tracedir (make-file-name (config-get conf 'tmp)
                      (or (config-get conf 'src) "stdin"))))
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
         (pp (pyc->list ast) p))))

(define (config-get conf key . def)
   (let ((c (memq key conf)))
      (if c (cadr c) (if (pair? def) (car def) #f))))
               
   
(cond-expand
  (bigloo

   (define (scmast.py file)
      
     (define-macro (get-build-path) (pwd))

     (define (root-dir)
       (or (getenv "ZIPIROOT")
           (get-build-path)))

     (let ((all-args
            (append (list (make-file-path (root-dir) "scmast.py") file)
                    (list :input :pipe
                          :output :pipe))))
       (let* ((proc (apply run-process all-args))
              (result (read (process-output-port proc))))
         result))))

  (gambit

   (define (scmast.py file)

     (define (root-dir)
       (or (getenv "ZIPIROOT")
           (path-expand ".." (path-directory (car (command-line))))))

     (let* ((port (open-process
                   (list path: (path-expand "scmast.py" (root-dir))
                         arguments: (list file))))
            (result (read port)))
         result))))
