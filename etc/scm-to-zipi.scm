#!gsi-script

(define placeholder '@placeholder@)

(cond-expand
   ((not bigloo)
    (define (cons* heads last)
       (if (null? heads)
	   last
	   (cons (car heads) (cons* (cdr heads) last))))))

(define (sexp-unpack-replace sexp replacements)
  (if (pair? sexp)
    (if (eq? (car sexp) placeholder)
      (cons*
        replacements
        (sexp-unpack-replace (cdr sexp) replacements))
      (cons
        (sexp-unpack-replace (car sexp) replacements)
        (sexp-unpack-replace (cdr sexp) replacements)))
      sexp))

(define (extract-gambit-top-level-from-file path)
  (call-with-input-file
    path
    (lambda (port)
      (let loop ()
        (let ((e (read port)))
          (if (eof-object? e)
            '()
            (cond
              ((not (pair? e))
                (loop))
              ((memq (car e) '(define define-macro))
                (if (pair? (cadr e))
                  (cons (caadr e) (loop))
                  (cons (cadr e) (loop))))
              (else
                (loop)))))))))

(define (main-gambit template-path sources-path)
  (let ((exports (apply append (map extract-gambit-top-level-from-file sources-path)))
        (template
          (call-with-input-file
            template-path
            (lambda (port)
              (let loop ((e (read port)))
                (if (eof-object? e) '() (cons e (loop (read port)))))))))
    (sexp-unpack-replace template exports)))

(define (extract-bigloo-top-level-from-file path)
  (call-with-input-file
    path
    (lambda (port)
      (let loop ()
        (let ((e (read port)))
          (if (eof-object? e)
            '()
            (cond
              ((not (pair? e))
                (loop))
              ((eq? (car e) 'define)
                (cons (cadr e) (loop)))
              ((eq? (car e) 'define-macro)
                (cons (cons 'macro (cadr e)) (loop)))
              (else
                (loop)))))))))

(define (main-bigloo template-path sources-path)
  (let ((exports (apply append (map extract-bigloo-top-level-from-file sources-path)))
        (template
          (call-with-input-file
            template-path
            (lambda (port)
              (let loop ((e (read port)))
                (if (eof-object? e) '() (cons e (loop (read port)))))))))

    (cons*
      (sexp-unpack-replace template exports)
      (cons*
        (cons
          '(start-registering-constants)
          (apply append
            (map
              (lambda (path)
                (call-with-input-file
                  path
                  (lambda (port)
                    (let loop ((e (read port)))
                      (if (eof-object? e) '() (cons e (loop (read port))))))))
              sources-path)))
          '((end-registering-constants))))))

(define (main . args)
  (if (< (length args) 3)
    (error "scm-to-zipi" "wrong number of arguments" (length args)))

  (let ((backend (car args))
        (template (cadr args))
        (sources (cddr args)))
    (case (string->symbol backend)
      ((gambit) (map pp (main-gambit template sources)))
      ((bigloo) (map pp (main-bigloo template sources)))
      (else
        (error "scm-to-zipi" "unknown backend" backend)))))

(cond-expand
   (bigloo
    (apply main (cdr (command-line)))))
