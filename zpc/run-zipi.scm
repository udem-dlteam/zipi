#!/usr/bin/env gsi

(define (main name)
  (import (zipi rts))
  (##module-search-order-add! ".")
  (exec-main name))
