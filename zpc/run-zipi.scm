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
  (let* ((clean-after-flag (member "--clean-after" args))
        (args (remove-flags args))
        (path (path-normalize (car args)))
        (dir (path-directory path))
        (module-name (path-strip-extension (path-strip-directory path)))
        (scm-target (string-append (path-strip-extension path) ".scm")))
    (compile-source path scm-target)
    (##module-search-order-add! dir)
    (let  ((res
            (with-exception-catcher
              (lambda (e)
                (if clean-after-flag (delete-file scm-target))
                (raise e))
              (lambda ()
                (run-as-main module-name)
                (if clean-after-flag (delete-file scm-target))))))
      res)))
