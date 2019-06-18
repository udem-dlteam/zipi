;; Mark as generator functions that use yield
(define-walk-method (mark-generator this::PyNode fun)
   (call-default-walker))

(define-walk-method (mark-generator this::PyFun fun)
   (mark-generator (PyFun-body this) this)
   this)

(define-walk-method (mark-generator this::PyYield fun)
   (if fun
       (PyFun-generator-set! fun #t)
       (error "py-generator" "Illegal generator" this)))

