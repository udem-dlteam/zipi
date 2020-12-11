;; Solve the n-queens problem using bit sets and recursion

(cond-expand
  (gambit
   (declare (standard-bindings) (extended-bindings) (block) (not safe)))
  (bigloo))

(define n 12)

(define (q i diag1 diag2 cols)
  (if (fx= i 0)
      1
      (let ((free (fxand diag1 diag2 cols)))
        (let loop ((col 1) (nsols 0))
          (if (fx> col free)
              nsols
              (loop (fxarithmetic-shift-left col 1)
                    (if (fx= 0 (fxand col free))
                        nsols
                        (fx+ nsols
                             (q (fx- i 1)
                                (fx+ (fxarithmetic-shift-left (fx- diag1 col) 1) 1)
                                (fxarithmetic-shift-right (fx- diag2 col) 1)
                                (fx- cols col))))))))))

(define (queens n)
  (q n -1 -1 (fx- (fxarithmetic-shift-left 1 n) 1)))

(define bench-time (time->seconds (current-time)))
(define result (queens n))
(set! bench-time (- (time->seconds (current-time)) bench-time))

(display bench-time)
(display " seconds for queens( ")
(display n)
(display " ) = ")
(display result)
(newline)
