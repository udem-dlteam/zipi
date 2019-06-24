(define (py-generator this conf)
   (mark-generator this #f)
   this)

;; Mark as generator functions that use yield
(define-walk-method (mark-generator this::PycNode fun)
   (call-default-walker))

(define-walk-method (mark-generator this::PycFun fun)
   (mark-generator (PycFun-body this) this)
   this)

(define-walk-method (mark-generator this::PycYield fun)
   (if fun
       (PycFun-generator-set! fun #t)
       (error "py-generator" "Illegal generator" this)))

