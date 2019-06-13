;; annotate functions that might call locals
(define (py-locals this::PyNode conf)
   (locals conf #f)
   this)

;; Traverse the AST to mark functions
;; that use such returns
(define-walk-method (locals this::PyNode fun)
   (call-default-walker))

(define-walk-method (locals this::PyFun fun)
   (locals (PyFun-body fun) this))


(define-walk-method (locals this::PyCall fun)
   (when (and (null? (PyCall-args this)) fun)
      (PyFun-can-locals-set! fun #t))
   (call-default-walker))

