;; Solve the n-queens problem using bit sets and recursion

(cond-expand
  (gambit
   (declare (standard-bindings) (extended-bindings) (block) (not safe)))
  (bigloo
   (define (current-second) (/ (current-milliseconds) 1000.0))
   (define-macro (fx+ . args) `(+fx ,@args))
   (define-macro (fx- x . args) (if (null? args) `(negfx ,x) `(-fx ,x ,@args)))
   (define-macro (fx* . args) `(*fx ,@args))
   (define-macro (fxquotient . args) `(quotientfx ,@args))
   (define-macro (fxmodulo . args) `(modulofx ,@args))
   (define-macro (fxremainder . args) `(remainderfx ,@args))
   (define-macro (fx= . args) `(=fx ,@args))
   (define-macro (fx< . args) `(<fx ,@args))
   (define-macro (fx<= . args) `(<=fx ,@args))
   (define-macro (fx> . args) `(>fx ,@args))
   (define-macro (fx>= . args) `(>=fx ,@args))
   (define-macro (fxand . args) `(bit-and ,@args))
   (define-macro (fxior . args) `(bit-or ,@args))
   (define-macro (fxxor . args) `(bit-xor ,@args))
   (define-macro (fxnot x)      `(bit-not ,x))
   (define-macro (fxarithmetic-shift-left  . args) `(bit-lsh ,@args))
   (define-macro (fxarithmetic-shift-right . args) `(bit-rsh ,@args))))

(define n 12)

(define (q i diag1 diag2 cols)
  (if (fx= i 0)
      1
      (let ((free (fxand (fxand diag1 diag2) cols)))
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

(define result (fx- (queens 8) 92)) ;; dry run

(define bench-time (current-second))
(set! result (fx+ result (queens n)))
(set! bench-time (- (current-second) bench-time))

(display bench-time)
(display " seconds: queens(")
(display n)
(display ") = ")
(display result)
(newline)
