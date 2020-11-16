;; =============================================================================
;;   Hashing
;; =============================================================================


;; TODO: explore faster alternative using this approach:
;; https://lemire.me/blog/2016/06/27/a-fast-alternative-to-the-modulo-reduction/
;; This proved to be unsuccesful with hash-FNVA1, both 32 and 64 bits
(define (fast-range-hash hash range)
  (modulo hash range))

;; Biggest fixnum Mersene prime
;; See explanation here: https://stackoverflow.com/a/37614051/5079316
(define max-hash-64 (- (expt 2 61) 1))
(define max-hash-32 (- (expt 2 29) 1))

(define (truncate-hash-32 x) (remainder x max-hash-32))
(define (truncate-hash-64 x) (remainder x max-hash-64))

;; Litterally just taken from here
;; https://en.wikipedia.org/wiki/Fowler%E2%80%93Noll%E2%80%93Vo_hash_function#FNV_hash_parameters
(define FNV1a-prime-64 #x00000100000001B3)
;;(define FNV1a-offset-basis-64 #xcbf29ce484222325)
(define FNV1a-offset-basis-64 #xbf29ce484222325)

(define FNV1a-prime-32 #x01000193 )
(define FNV1a-offset-basis-32 #x811c9dc5)

(define (hash-FNV1a-32 string)
  (let ((bytes (map char->integer (string->list string)))
        (h FNV1a-offset-basis-32))
    (let loop ((bytes bytes) (h h))
      (if (null? bytes)
        h
        (loop
          (cdr bytes)
          (truncate-hash-32 (fxwrap* (bitwise-xor h (car bytes)) FNV1a-prime-32)))))))

(define (hash-FNV1a-64 string)
  (let ((bytes (map char->integer (string->list string)))
        (h FNV1a-offset-basis-64))
    (let loop ((bytes bytes) (h h))
      (if (null? bytes)
        h
        (loop
          (cdr bytes)
          (truncate-hash-64 (fxwrap* (bitwise-xor h (car bytes)) FNV1a-prime-64)))))))

(define truncate-hash truncate-hash-32)
(define hash-FNV1a hash-FNV1a-32)
