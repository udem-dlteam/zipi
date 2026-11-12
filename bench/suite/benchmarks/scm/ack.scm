;; Compute the ackermann function using recursion

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

(define m 3)
(define n 9)

(define (ack m n)
  (cond ((fx= m 0)
         (fx+ n 1))
        ((and (fx> m 0) (fx= n 0))
         (ack (fx- m 1) 1))
        (else
         (ack (fx- m 1) (ack m (fx- n 1))))))

(define result (fx- (ack 3 7) 1021)) ;; dry run

(define bench-time (current-second))
(set! result (fx+ result (ack m n)))
(set! bench-time (- (current-second) bench-time))

(display bench-time)
(display " seconds: ack(")
(display m)
(display ", ")
(display n)
(display ") = ")
(display result)
(newline)
