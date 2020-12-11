;; Compute nth fibonacci number using double recursion

(cond-expand
  (gambit
   (declare (standard-bindings) (extended-bindings) (block) (not safe)))
  (bigloo))

(define n 33)

(define (fib n)
  (if (fx< n 2)
      n
      (fx+ (fib (fx- n 1)) (fib (fx- n 2)))))

(define bench-time (time->seconds (current-time)))
(define result (fib n))
(set! bench-time (- (time->seconds (current-time)) bench-time))

(display bench-time)
(display " seconds for fib( ")
(display n)
(display " ) = ")
(display result)
(newline)
