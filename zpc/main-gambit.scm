#!/usr/bin/env gsi

(define (main . args)
  (let ((verbose 0)
        (target 'gambit)
        (main #t)
        (module-name #f)
        (dir #f)
        (src #f)
        (output #f)
        (libdir (zipi-lib-dir))
        (bindir (zipi-bin-dir))
        (conf '()))

    (let loop ((args args))
      (if (pair? args)
          (let ((arg (car args))
                (rest (cdr args)))
            (cond ((and (pair? rest) (member arg '("-t" "--target")))
                   (set! target (string->symbol (car rest)))
                   (loop (cdr rest)))
                  ((and (pair? rest) (member arg '("-d" "--dir")))
                   (set! dir (car rest))
                   (loop (cdr rest)))
                  ((and (pair? rest) (member arg '("-b" "--bindir")))
                   (set! bindir (car rest))
                   (loop (cdr rest)))
                  ((and (pair? rest) (member arg '("-l" "--libdir")))
                   (set! libdir (car rest))
                   (loop (cdr rest)))
                  ((and (pair? rest) (member arg '("-m" "--module-name")))
                   (set! module-name (car rest))
                   (loop (cdr rest)))
                  ((and (pair? rest) (member arg '("-o" "--output")))
                   (set! output (car rest))
                   (loop (cdr rest)))
                  ((member arg '("--py-module-main"))
                   (set! main #t)
                   (loop rest))
                  ((member arg '("-n" "--no-main" "--no-py-module-main"))
                   (set! main #f)
                   (loop rest))
                  ((member arg '("-v0"))
                   (set! verbose 0)
                   (loop rest))
                  ((member arg '("-v1"))
                   (set! verbose 1)
                   (loop rest))
                  ((member arg '("-v2"))
                   (set! verbose 2)
                   (loop rest))
                  ((member arg '("-v"))
                   (set! verbose (+ verbose 1))
                   (loop rest))
                  (else
                   (if (and (>= (string-length arg) 2)
                            (string=? (substring arg 0 2) "--"))
                       (begin
                         (println "ignoring option " arg)
                         (loop rest))
                       (begin
                         (set! src arg)
                         (loop rest))))))))

    (let ((generated-code
           (pyc (target-driver target)
                (cons*
                 verbose: verbose
                 target: target
                 lib-dir: libdir
                 bin-dir: bindir
                 dir: dir
                 src: src
                 main: main
                 module-name: module-name
                 conf))))

      (define (dump port)
        (for-each (lambda (expr)
                    (pp expr port)
                    (newline port))
                  generated-code))

      (if output
          (call-with-output-file output dump)
          (dump (current-output-port))))))

(##main-set! main)
