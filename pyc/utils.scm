(define (config-get conf key #!optional def)
   (let ((c (memq key conf)))
      (if c (cadr c) def)))
               
(define (my-gensym sym)
    (let ((i gensym-count))
      (set! gensym-count (+ i 1))
      (string->symbol (string-append "$" (symbol->string sym) "_" (number->string i)))))
(define gensym-count 0)

