#!/usr/bin/env gsi

(define (main . args)
  (import (zipi rts))
  (let ((path (path-normalize (car args))))
   (or  (run-as-main path)
        (print "error : File named " (car args) " at " path " cannot be found"))))
