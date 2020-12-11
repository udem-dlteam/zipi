;; Compute nth fibonacci number using double recursion

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

(define n 33)

(define (fib n)
  (if (fx< n 2)
      n
      (fx+ (fib (fx- n 1)) (fib (fx- n 2)))))

(define bench-time (current-second))
(define result (fib n))
(set! bench-time (- (current-second) bench-time))

(display bench-time)
(display " seconds: fib(")
(display n)
(display ") = ")
(display result)
(newline)
