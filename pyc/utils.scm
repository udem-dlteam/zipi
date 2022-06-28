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

;; return a list of the elements in lst without duplicated (with eq?)
(define (uniq lst)
  (define (uniq-aux rest acc)
    (cond
      ((null? rest)
        acc)
      ((memq (car rest) acc)
        (uniq-aux (cdr rest) acc))
      (else
        (uniq-aux (cdr rest) (cons (car rest) acc)))))
  (uniq-aux lst '()))

(define (filter-map fn lst)
  (if (null? lst)
    '()
    (let ((res (fn (car lst))))
      (if res
        (cons res (filter-map fn (cdr lst)))
        (filter-map fn (cdr lst))))))

(cond-expand
  (gambit #f)
  (bigloo
    (define (append-strings strings) (apply string-append strings))))
