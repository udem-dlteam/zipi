(define (config-get conf key #!optional def)
   (let ((c (memq key conf)))
      (if c (cadr c) def)))
               

