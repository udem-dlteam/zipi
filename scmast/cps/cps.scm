;; CPS transform functions that use yield
;; This pass assumes that the GENERATOR pass has already execute
;; and so generator function are alread marked
(define (py-cps this conf)
   (cps-fun! this))

;; Transform CPS functions
(define-walk-method (cps-fun! this::PyNode)
   (call-default-walker))

;; debug macros
(define-macro (kcall kont arg) `(,kont ,arg))
(define-macro (KontExpr proc node link . name) proc)
(define-macro (KontStmt proc node link . name) proc)

(define-walk-method (cps-fun! this::PyFun)
   (if (PyFun-generator this)
       (PyFun-body-set! this
	  (cps (PyFun-body this) (KontStmt kid this #f) kid '() '() #f this))
       (cps-fun! (PyFun-body this)))
   this)

(define (kid n) n)
(define (kid? obj) (eq? obj kid))

(define (cps*::PyNode nodes k* pack kbreaks kcontinues ktry fun)
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

(define-walk-method (cps this::PyNode k pack kbreaks kcontinues ktry fun)
   (error "cps" "Should not be here" (py->list this)))

(define-walk-method (cps this::PyLiteral k pack kbreaks kcontinues ktry fun)
   (kcall k this))

(define-walk-method (cps this::PyUninit k pack kbreaks kcontinues ktry fun)
   (kcall k this))

(define-walk-method (cps this::PyRef k pack kbreaks kcontinues ktry fun)
   (kcall k this))

(define-walk-method (cps this::PyUnary k pack kbreaks kcontinues ktry fun)
   (let ((expr (PyUnary-expr this)))
      (if (yield-expr? expr kbreaks kcontinues)
	  (cps expr
	     (KontExpr (lambda (kexpr)
			  (kcall k (new-PyUnary (PyNode-loc this)
				      (PyUnary-op this)
				      kexpr)))
		this k)
	     pack kbreaks kcontinues ktry fun)
	  (kcall k this))))

(define-walk-method (cps this::PyBinary k pack kbreaks kcontinues ktry fun)
   (let ((lhs (PyBinary-lhs this))
	 (rhs (PyBinary-rhs this)))
      (cond
	 ((yield-expr? lhs kbreaks kcontinues)
	  (cps lhs
	     (KontExpr (lambda (klhs)
			  (cps (new-PyBinary (PyNode-loc this)
				  (PyBinary-op this) klhs rhs)
			     k pack kbreaks kcontinues ktry fun))
		this k)
	     pack kbreaks kcontinues ktry fun))
	 ((yield-expr? rhs kbreaks kcontinues)
	  (cps rhs
	     (KontExpr (lambda (krhs)
			  (cps (new-PyBinary (PyNode-loc this)
				  (PyBinary-op this) lhs krhs)
			     k pack kbreaks kcontinues ktry fun))
		this k)
	     pack kbreaks kcontinues ktry fun))
	 (else
	  (kcall k this)))))

(define-walk-method (cps this::PyYield k pack kbreaks kcontinues ktry fun)

   (define (make-yield-kont k loc)
      (let* ((arg (new-PyDecl loc (gensym '%arg) 'local))
	     (exn (new-PyDecl loc (gensym '%exn) 'local))
	     (body (kcall k (new-PyRef loc arg)))
	     (cont (new-PyIf loc
		      (new-PyBinary loc 'eq? (new-PyRef loc exn) (new-PyBool loc #t))
		      (new-PyRaise loc :exc (new-PyRef loc arg))
		      body)))
	 (new-PyKont loc arg exn (pack cont))))
   
   (let* ((loc (PyNode-loc this))
	  (expr (PyYield-expr this))
	  (gen (PyYield-generator this))
	  (kont (make-yield-kont k loc)))
      (if (yield-expr? expr kbreaks kcontinues)
	  (cps expr
	     (KontExpr (lambda (kexpr)
			  (new-PyReturnYield loc kexpr kont :generator gen))
		this k)
	     pack kbreaks kcontinues ktry fun)
	  (new-PyReturnYield loc (cps-fun! expr) kont :generator gen))))

(define-walk-method (cps this::PyReturn k pack kbreaks kcontinues ktry fun)
   (let ((loc (PyNode-loc this))
	 (expr (PyReturn-val this)))
      (if (yield-expr? expr kbreaks kcontinues)
	  (cps expr
	     (KontExpr (lambda (kexpr)
			  (if ktry
			      '(new-PyTail loc
				(new-PyCall loc
				   (new-PyRef loc ktry)
				   (PyBool #t)
				   kexpr))
			      (new-PyReturnYield loc kexpr
				 (new-PyUninit loc))))
		this k)
	     pack kbreaks kcontinues ktry fun)
	  (if ktry
	      (tprint "TODO")
	      (new-PyReturnYield loc (cps-fun! expr) (new-PyUninit loc))))))
				  
;; does an expression may yield or return?
(define (yield-expr? this kbreaks kcontinues)
   (let ((v (yield-expr* this kbreaks kcontinues)))
      (find (lambda (v) v) v)))

(define-walk-method (yield-expr* this::PyNode kbreaks kcontinues)
   (call-default-walker))

(define-walk-method (yield-expr* this::PyYield kbreaks kcontinues)
   (list this))

(define-walk-method (yield-expr* this::PyReturn kbreaks kcontinues)
   (list this))

(define-walk-method (yield-expr* this::PyFun kbreaks kcontinues)
   '())

;* (define-walk-method (yield-expr* this::PyBreak kbreaks kcontinues)  */
;*    (with-access::PyBreak this (target)                              */
;*       (if (assq target kbreaks)                                     */
;* 	  (list this)                                                  */
;* 	  '())))                                                       */
;*                                                                     */
;* (define-walk-method (yield-expr* this::PyContinue kbreaks kcontinues) */
;*    (with-access::PyContinue this (target)                           */
;*       (if (assq target kcontinues)                                  */
;* 	  (list this)                                                  */
;* 	  '())))                                                       */

