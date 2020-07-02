#!/usr/bin/env gsi
(define (flag? s)
  (and (>= (string-length s) 2)
       (string=? (substring s 0 2) "--")))

(define (get-file-name args)
  (fold (lambda (x y) (if (flag? x) y x)) #f args))

(define (main . args)
  (import (zipi rts))
  (if (member "--clear-cache" args)
      (delete-zipi-cache))
  (if (member "--compile"  args)
      (set-compile-flag #t)
      (set-compile-flag #f))
  (build-builtins)
  (if (get-file-name args)
      (let ((path (path-normalize (get-file-name args))))
       (or  (run-as-main path)
            (print "error : File named " (car args) " at " path " cannot be found")))

      (print "Usage : ./run-zipi [--compile --clear-cache] file ")))
