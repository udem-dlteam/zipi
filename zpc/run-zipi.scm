#!/usr/bin/env gsi

(define (flag? s)
  (and (>= (string-length s) 2)
       (string=? (substring s 0 2) "--")))

(define (remove-flags args)
  (cond
    ((null? args)
      '())
    ((flag? (car args))
      (remove-flags (cdr args)))
    (else
      (cons (car args) (remove-flags (cdr args))))))

;; TODO: make a cleaner script
(define (main . args)
  (import (zipi rts))
  (##module-search-order-add! ".")
  (let* ((clean-after-flag (member "--clean-after" args))
        (args (remove-flags args))
        (path (car args))
        (scm-target (string-append (path-strip-extension path) ".scm"))
        (module-name (path-strip-extension (path-normalize path #t)))
        (_ (compile-to-scheme path scm-target))
        (res
          (with-exception-catcher
            (lambda (e) #f)
            (lambda () (exec-main module-name)))))
    (if clean-after-flag
      (delete-file scm-target))
    res))
