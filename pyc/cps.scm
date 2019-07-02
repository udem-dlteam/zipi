;; CPS transform functions that use yield
;; This pass assumes that the GENERATOR pass has already execute
;; and so generator function are alread marked
(define (pyc-cps this conf)
   (cps-fun! this))

;; Transform CPS functions
(define-walk-method (cps-fun! this::PycNode)
   (call-default-walker))

;; debug macros
(define-macro (kcall kont arg) `(,kont ,arg))
(define-macro (KontExpr proc node link . name) proc)
(define-macro (KontExpr* proc node link . name) proc)
(define-macro (KontStmt proc node link . name) proc)

(define-walk-method (cps-fun! this::PycFun)
   (if (PycFun-generator this)
       (PycFun-body-set! this
	  (cps (PycFun-body this) (KontStmt kid this #f) kid '() '() #f this))
       (cps-fun! (PycFun-body this)))
   this)

(define (kid n) n)
(define (kid? obj) (eq? obj kid))

(define (cps* nodes k* pack kbreaks kcontinues ktry fun)
   (let loop ((nodes nodes)
	      (knodes '()))
      (if (null? nodes)
	  (kcall k* (reverse! knodes))
	  (cps (car nodes)
	     (KontExpr (lambda (kexpr)
			  (loop (cdr nodes)
			     (cons kexpr knodes)))
		nodes k*)
	     pack kbreaks kcontinues ktry fun))))

(define-walk-method (cps this::PycNode k pack kbreaks kcontinues ktry fun)
   (error "cps" "Should not be here" (pyc->list this)))

(define-walk-method (cps this::PycStmtExpr k pack kbreaks kcontinues ktry fun)
   (let ((loc (PycNode-loc this))
	 (expr (PycStmtExpr-expr this)))
      (if (yield-expr? expr kbreaks kcontinues)
	  (cps expr
	     (KontExpr (lambda (ke)
			  (kcall k (new-PycStmtExpr loc ke)))
		this k "expr")
	     pack kbreaks kcontinues ktry fun)
	  (begin
	     (cps-fun! expr)
	     (kcall k this)))))

(define-walk-method (cps this::PycLiteral k pack kbreaks kcontinues ktry fun)
   (kcall k this))

(define-walk-method (cps this::PycUninit k pack kbreaks kcontinues ktry fun)
   (kcall k this))

(define-walk-method (cps this::PycRef k pack kbreaks kcontinues ktry fun)
   (kcall k this))

(define-walk-method (cps this::PycUnary k pack kbreaks kcontinues ktry fun)
   (let ((expr (PycUnary-expr this)))
      (if (yield-expr? expr kbreaks kcontinues)
	  (cps expr
	     (KontExpr (lambda (kexpr)
			  (kcall k (new-PycUnary (PycNode-loc this)
				      (PycUnary-op this)
				      kexpr)))
		this k)
	     pack kbreaks kcontinues ktry fun)
	  (kcall k this))))

(define-walk-method (cps this::PycBinary k pack kbreaks kcontinues ktry fun)
   (let ((lhs (PycBinary-lhs this))
	 (rhs (PycBinary-rhs this)))
      (cond
	 ((yield-expr? lhs kbreaks kcontinues)
	  (cps lhs
	     (KontExpr (lambda (klhs)
			  (cps (new-PycBinary (PycNode-loc this)
				  (PycBinary-op this) klhs rhs)
			     k pack kbreaks kcontinues ktry fun))
		this k)
	     pack kbreaks kcontinues ktry fun))
	 ((yield-expr? rhs kbreaks kcontinues)
	  (cps rhs
	     (KontExpr (lambda (krhs)
			  (cps (new-PycBinary (PycNode-loc this)
				  (PycBinary-op this) lhs krhs)
			     k pack kbreaks kcontinues ktry fun))
		this k)
	     pack kbreaks kcontinues ktry fun))
	 (else
	  (kcall k this)))))

(define-walk-method (cps this::PycYield k pack kbreaks kcontinues ktry fun)

   (define (make-yield-kont k loc)
      (let* ((arg (new-PycDecl loc (gensym '%arg) 'local))
	     (exn (new-PycDecl loc (gensym '%exn) 'local))
	     (body (kcall k (new-PycRef loc arg)))
	     (cont (new-PycIf loc
		      (new-PycBinary loc 'is
			 (new-PycRef loc exn) (new-PycBool loc #t) type: 'bool)
		      (new-PycRaise loc (new-PycRef loc arg) (new-PycUninit loc))
		      body)))
	 (new-PycKont loc arg exn (pack cont))))
   
   (let* ((loc (PycNode-loc this))
	  (val (PycYield-val this))
	  (gen (PycYield-generator this))
	  (kont (make-yield-kont k loc)))
      (if (yield-expr? val kbreaks kcontinues)
	  (cps val
	     (KontExpr (lambda (kexpr)
			  (new-PycReturnYield loc kexpr kont generator: gen))
		this k)
	     pack kbreaks kcontinues ktry fun)
	  (new-PycReturnYield loc (cps-fun! val) kont generator: gen))))

(define-walk-method (cps this::PycReturn k pack kbreaks kcontinues ktry fun)
   (let ((loc (PycNode-loc this))
	 (expr (PycReturn-val this)))
      (if (yield-expr? expr kbreaks kcontinues)
	  (cps expr
	     (KontExpr (lambda (kexpr)
			  (if ktry
			      '(new-PycTail loc
				(new-PycCall loc
				   (new-PycRef loc ktry)
				   (PycBool #t)
				   kexpr))
			      (new-PycReturnYield loc kexpr
				 (new-PycUninit loc))))
		this k)
	     pack kbreaks kcontinues ktry fun)
	  (if ktry
	      (tprint "TODO")
	      (begin
		 (PycReturn-val-set! this (new-PycPragma loc ''StopIteration))
		 (new-PycSeq loc
		    (list
		       (new-PycStmtExpr loc (cps-fun! expr))
		       this)))))))

(define-walk-method (cps this::PycCall k pack kbreaks kcontinues ktry fun)
   (let ((args (PycCall-args this)))
      (cond
	 ((yield-expr? (PycCall-fun this) kbreaks kcontinues)
	  (cps (PycCall-fun this)
	     (KontExpr (lambda (kfun)
			  (PycCall-fun-set! this kfun)
			  (cps this k pack kbreaks kcontinues ktry fun))
		this k)
	     pack kbreaks kcontinues ktry fun))
	 ((any (lambda (e) (yield-expr? e kbreaks kcontinues)) args)
	  (cps-fun! (PycCall-fun this))
	  (cps* args
	     (KontExpr* (lambda (kargs)
			   (PycCall-args-set! this kargs)
			   (cps this k pack kbreaks kcontinues ktry fun))
		args k)
	     pack kbreaks kcontinues ktry fun))
	 (else
	  (cps-fun! (PycCall-fun this))
	  (for-each cps-fun! args)
	  (kcall k this)))))

(define-walk-method (cps this::PycSeq k pack kbreaks kcontinues ktry fun)
   
   (define (pack-seq this prev res)
      (if (pair? prev)
	  (set-cdr! prev (list res))
	  (PycSeq-nodes-set! this (list res)))
      (PycSeq-nodes-set! this
	 (filter (lambda (x) (not (isa? x PycPass))) (PycSeq-nodes this)))
      (if (and (pair? (PycSeq-nodes this)) (null? (cdr (PycSeq-nodes this))))
	  (if (isa? this PycBlock)
	      (if (isa? (car (PycSeq-nodes this)) PycBlock)
		  (car (PycSeq-nodes this))
		  this)
	      (car (PycSeq-nodes this)))
	  this))
   
   (let ((loc (PycNode-loc this)))
      (let loop ((walk (PycSeq-nodes this))
		 (pnodes '()))
	 (cond
	    ((null? walk)
	     (kcall k this))
	    ((not (yield-expr? (car walk) kbreaks kcontinues))
	     (cps-fun! (car walk))
	     (loop (cdr walk) walk))
	    ((null? (cdr walk))
	     (pack-seq this pnodes
		(cps (car walk)
		   k pack kbreaks kcontinues ktry fun)))
	    (else
	     (pack-seq this pnodes
		(cps (car walk)
		   (KontStmt (lambda (khead)
				(cps (new-PycSeq loc
					(cons khead (cdr walk)))
				   k pack kbreaks kcontinues ktry fun))
		      this k)
		   pack kbreaks kcontinues ktry fun)))))))

(define-walk-method (cps this::PycBlock k pack kbreaks kcontinues ktry fun)
   (let loop ((wdecls (PycBlock-decls this))
	      (pdecls '())
	      (sdecls '()))
      (cond
	 ((null? wdecls)
	  (new-PycBlock (PycNode-loc this)
	     (PycBlock-decls this)
	     (cps (PycBlock-body this) k pack kbreaks kcontinues ktry fun)))
	 ((not (yield-expr? (car wdecls) kbreaks kcontinues))
	  (cps-fun! (car wdecls))
	  (loop (cdr wdecls) wdecls
	     (if (pair? sdecls) sdecls wdecls)))
	 (else
	  (PycDecl-scope-set! (car wdecls) 'kont)
	  (let* ((y (cps (car wdecls)
		       (KontStmt (lambda (ndecl)
				    (cond
				       ((null? (cdr wdecls))
					(new-PycBlock (PycNode-loc this)
					   (list ndecl) 
					   (cps (PycBlock-body this)
					      k pack kbreaks kcontinues
					      ktry fun)))
				       (else
					(PycBlock-decls-set! this (cdr wdecls))
					(new-PycBlock (PycNode-loc this)
					   (list ndecl)
					   (cps this
					      k pack kbreaks kcontinues
					      ktry fun)))))
			  this k)
		       pack kbreaks kcontinues ktry fun))
		 (b (if (isa? y PycExpr) (new-PycStmtExpr (PycNode-loc y) y) y)))
	     (if (null? pdecls)
		 b
		 (begin
		    (set-cdr! pdecls '())
		    (new-PycBlock (PycNode-loc this) sdecls b))))))))

;; does an expression may yield or return?
(define (yield-expr? this kbreaks kcontinues)
  (let ((v (yield-expr* this kbreaks kcontinues)))
      (find (lambda (v) v) v)))

(define-walk-method (yield-expr* this::PycNode kbreaks kcontinues)
   (call-default-walker))

(define-walk-method (yield-expr* this::PycYield kbreaks kcontinues)
   (list this))

(define-walk-method (yield-expr* this::PycReturn kbreaks kcontinues)
   (list this))

(define-walk-method (yield-expr* this::PycFun kbreaks kcontinues)
   '())

;* (define-walk-method (yield-expr* this::PycBreak kbreaks kcontinues)  */
;*    (with-access::PycBreak this (target)                              */
;*       (if (assq target kbreaks)                                     */
;* 	  (list this)                                                  */
;* 	  '())))                                                       */
;*                                                                     */
;* (define-walk-method (yield-expr* this::PycContinue kbreaks kcontinues) */
;*    (with-access::PycContinue this (target)                           */
;*       (if (assq target kcontinues)                                  */
;* 	  (list this)                                                  */
;* 	  '())))                                                       */

