(define (filter pred lst)
  (if (pair? lst)
      (if (pred (car lst))
          (cons (car lst) (filter pred (cdr lst)))
          (filter pred (cdr lst)))
      '()))

(define (any pred lst)
  (if (pair? lst)
      (if (pred (car lst))
          #t
          (any pred (cdr lst)))
      #f))

(define (find pred lst)
  (if (pair? lst)
      (if (pred (car lst))
          (car lst)
          (find pred (cdr lst)))
      #f))

