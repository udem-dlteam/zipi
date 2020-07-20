;; =============================================================================
;;   Hashing
;; =============================================================================

;; Biggest fixnum Mersene prime
;; See explanation here: https://stackoverflow.com/a/37614051/5079316
(define max-hash (- (expt 2 61) 1))

(define (truncate-hash x) (remainder x max-hash))

;; Litterally just taken from here
;; https://en.wikipedia.org/wiki/Fowler%E2%80%93Noll%E2%80%93Vo_hash_function#FNV_hash_parameters
(define FNV1a-prime #x00000100000001B3)
(define FNV1a-offset-basis #xcbf29ce484222325)

(define (hash-FNV1a string)
  (let ((bytes (map char->integer (string->list string)))
        (h FNV1a-offset-basis))
    (let loop ((bytes bytes) (h h))
      (if (null? bytes)
        h
        (loop
          (cdr bytes)
          (truncate-hash (* (bitwise-xor h (car bytes)) FNV1a-prime)))))))
