;; CPS transform functions that use yield
;; This pass assumes that the GENERATOR pass has already execute
;; and so generator function are alread marked
(define (py-cps this conf)
   (cps-fun! this))

;; Transform CPS functions
(define-walk-method (cps-fun! this::PyNode)
   (call-default-walker))

(define-walk-method (cps-fun! this::PyFun)
   (if (PyFun-generator this)
       (PyFun-body-set! this (cps (PyFunBody ...)))
       (cps-fun! (PyFun-Body this))))
   
