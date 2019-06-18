;; CPS transform functions that use yield
(define (py-cps this conf)
   (mark-yield this #f)
   (cps! this))

;; Mark as generator functions that use yield
(define-walk-method (mark-yield this::PyNode fun)
   (call-default-walker))

(define-walk-method (mark-yield this::PyFun fun)
   (mark-yield (PyFun-body this) this)
   this)

(define-walk-method (mark-yield this::PyYield fun)
   (if fun
       (PyFun-generator-set! fun #t)
       (error "py-cps" "Illegal yield" this)))



