#!/usr/bin/env gsi

(define (main . args)
  (import (zipi rts))
  (run-as-main (path-normalize (car args))))
