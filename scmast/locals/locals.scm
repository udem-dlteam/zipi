;; annotate functions that might call locals
(define (py-locals this conf)
   (mark-no-can-locals this)
   (locals this #f)
   this)

;; PyFun have been first initialized with can-locals set to #t
;; The first stage of this optimization is to replace all this #t with #f
;; The analysis will then set to #t only functions that need to be
(define-walk-method (mark-no-can-locals this::PyNode)
   (call-default-walker))

(define-walk-method (mark-no-can-locals this::PyFun)
   (PyFun-can-locals-set! this #f))

;; Traverse the AST to mark functions
;; that might use locals
(define-walk-method (locals this::PyNode fun)
   (call-default-walker))

(define-walk-method (locals this::PyFun fun)

   (define (function-names fun)
      (map! PyDecl-id (append (PyFun-args fun) (PyFun-decls fun))))
   
   (locals (PyFun-body this) this)
   (when (PyFun-can-locals this)
      (let ((loc (PyNode-loc (PyFun-body this))))
	 (PyFun-body-set! this
	    (new-PyBlock loc
	       (list (new-PyDecl loc '%frame 'block)
		  (new-PyDecl loc '%names 'block))
	       (list (new-PyPragma loc '(make-cell #f))
		  (new-PyPragma loc `',(function-names this)))
	       (PyFun-body this)))))
   this)

(define-walk-method (locals this::PyCall fun)
   (when (and (null? (PyCall-args this)) fun)
      (PyFun-can-locals-set! fun #t))
   (call-default-walker))

