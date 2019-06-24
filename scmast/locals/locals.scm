;; annotate functions that might call locals
(define (pyc-locals this conf)
   (mark-no-can-locals this)
   (locals this #f)
   this)

;; PycFun have been first initialized with can-locals set to #t
;; The first stage of this optimization is to replace all this #t with #f
;; The analysis will then set to #t only functions that need to be
(define-walk-method (mark-no-can-locals this::PycNode)
   (call-default-walker))

(define-walk-method (mark-no-can-locals this::PycFun)
   (PycFun-can-locals-set! this #f))

;; Traverse the AST to mark functions
;; that might use locals
(define-walk-method (locals this::PycNode fun)
   (call-default-walker))

(define-walk-method (locals this::PycFun fun)

   (define (function-names fun)
      (map! PycDecl-id (append (PycFun-args fun) (PycFun-decls fun))))
   
   (locals (PycFun-body this) this)
   (when (PycFun-can-locals this)
      (let ((loc (PycNode-loc (PycFun-body this))))
	 (PycFun-body-set! this
	    (new-PycBlock loc
	       (list
		  (new-PycDeclInit loc '%frame 'block
		     (new-PycPragma loc '(make-cell #f)))
		  (new-PycDeclInit loc '%names 'block
		     (new-PycPragma loc `',(function-names this))))
	       (PycFun-body this)))))
   this)

(define-walk-method (locals this::PycCall fun)
   (when (and (null? (PycCall-args this)) fun)
      (PycFun-can-locals-set! fun #t))
   (call-default-walker))

