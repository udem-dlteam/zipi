(define (config-get conf key #!optional def)
   (let ((c (memq key conf)))
      (if c (cadr c) def)))

(define (my-gensym sym)
    (let ((i gensym-count))
      (set! gensym-count (+ i 1))
      (string->symbol (string-append "$" (symbol->string sym) "_" (number->string i)))))
(define gensym-count 0)

(define (interleave . rest)
  (let ((non-empty (filter pair? rest)))
    (if (null? non-empty)
      '()
      (append
        (map car non-empty)
        (apply interleave (map cdr non-empty))))))

(define (flatten l)
  (apply append (map (lambda (x) (if (pair? x) x (list x))) l)))

(define (all? pred lst)
  (cond
    ((null? lst)
      #t)
    ((pred (car lst))
      (all? pred (cdr lst)))
    (else
      #f)))

(define (any? pred lst)
  (cond
    ((null? lst)
      #f)
    ((pred (car lst))
      #t)
    (else
      (any? pred (cdr lst)))))
