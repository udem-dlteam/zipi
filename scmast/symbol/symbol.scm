;; symbol resolution
(define (pyc-symbol! this conf)
   (let* ((env (collect* this 'global))
	  (%env (cons '% env)))
      (glodecl! this %env)
      (resolve! this (cdr %env) conf)))

;; collect declarations
(define-walk-method (collect* this::PycNode scope)
   (call-default-walker))

(define-walk-method (collect* this::PycFun scope)
   '())

(define-walk-method (collect* this::PycDecl scope)
   (if (eq? (PycDecl-scope this) scope)
       (list this)
       '()))

;; create all the global declarations
(define-walk-method (glodecl! this::PycNode %env)
   (call-default-walker))

(define-walk-method (glodecl! this::PycAssig %env)
   (let ((lhs (PycAssig-lhs this)))
      (cond
	 ((not (PycRefUnresolved? lhs))
	  (call-default-walker))
	 ((lookup-id (cdr %env) (PycRefUnresolved-id lhs))
	  (call-default-walker))
	 (else
	  (let ((decl (new-PycDeclInit (PycNode-loc this)
			 (PycRefUnresolved-id lhs) 'global
			 (glodecl! (PycAssig-rhs this) %env))))
	     (set-cdr! %env (cons decl (cdr %env)))
	     decl)))))

(define-walk-method (glodecl! this::PycFun %env)
   this)

(define-walk-method (glodecl! this::PycClass %env)
   this)

;; symbol resolution
(define-walk-method (resolve! this::PycNode env conf)
   (call-default-walker))

(define-walk-method (resolve! this::PycModule env conf)
   (PycModule-globals-set! this env)
   (call-default-walker))

(define-walk-method (resolve! this::PycBlock env conf)
   (let loop ((env env)
	      (decls (PycBlock-decls this)))
      (if (null? decls)
	  (begin
	     (PycBlock-body-set! this (resolve! (PycBlock-body this) env conf))
	     this)
	  (let ((decl (car decls)))
	     (PycDeclInit-val-set! decl
		(resolve! (PycDeclInit-val decl) env conf))
	     (loop (cons decl env) (cdr decls))))))

(define-walk-method (resolve! this::PycRefUnresolved env conf)
   (let ((loc (PycNode-loc this)))
      (let ((decl (lookup-id env (PycRefUnresolved-id this))))
	 (if (PycDecl? decl)
	     (new-PycRef loc decl)
	     this))))

(define-walk-method (resolve! this::PycFun env conf)
   (let* ((loc (PycNode-loc this))
	  (decls (collect* (PycFun-body this) 'local))
	  (aenv (collect-free-assig* (PycFun-body this)
		   (append decls (PycFun-args this) env)))
	  (bdgs (map (lambda (decl)
			(let ((loc (PycNode-loc decl)))
			   (new-PycDeclInit loc (PycDecl-id decl) 'local
			      (new-PycUninit loc))))
		   (append aenv decls))))
      (if (pair? bdgs)
	  (PycFun-body-set! this
	     (new-PycBlock loc
		bdgs
		(resolve! (PycFun-body this)
		   (append bdgs (PycFun-args this) env) conf)))
	  (PycFun-body-set! this
	     (resolve! (PycFun-body this) (append (PycFun-args this) env) conf)))
      this))

(define-walk-method (resolve! this::PycClass env conf)
   (let* ((loc (PycNode-loc this))
	  (decls (collect* (PycClass-body this) 'local))
	  (aenv (collect-free-assig* (PycClass-body this)
		   (append decls env)))
	  (bdgs (map (lambda (decl)
			(let ((loc (PycNode-loc decl)))
			   (new-PycDeclInit loc (PycDecl-id decl) 'local
			      (new-PycUninit loc))))
		   (append aenv decls))))
      (PycClass-decls-set! this bdgs)
      (if (pair? bdgs)
	  (PycClass-body-set! this
	     (new-PycBlock loc
		bdgs
		(resolve! (PycClass-body this)
		   (append bdgs env) conf)))
	  (PycClass-body-set! this
	     (resolve! (PycClass-body this) env conf)))
      this))

(define-walk-method (resolve! this::PycDeclInit env conf)
   (if (eq? (PycDecl-scope this) 'local)
       (let ((loc (PycNode-loc this)))
	  ;; replace the declaration with an assignment
	  (let ((decl (lookup-id env (PycDecl-id this))))
	     (new-PycAssig loc (new-PycRef loc decl)
		(resolve! (PycDeclInit-val this) env conf))))
       (call-default-walker)))

;; collect free variable assignments
(define-walk-method (collect-free-assig* this::PycNode env)
   (call-default-walker))

(define-walk-method (collect-free-assig* this::PycAssig env)
   (if (isa? (PycAssig-lhs this) PycRefUnresolved)
       (if (lookup-id env (PycRefUnresolved-id (PycAssig-lhs this)))
	   (collect-free-assig* (PycAssig-rhs this) env)
	   (let* ((loc (PycNode-loc (PycAssig-lhs this)))
		  (decl (new-PycDeclInit loc
			   (PycRefUnresolved-id (PycAssig-lhs this))
			   'local
			   (new-PycUninit loc))))
	      (cons decl
		 (collect-free-assig* (PycAssig-rhs this) (cons decl env)))))
       (call-default-walker)))

(define-walk-method (collect-free-assig* this::PycFor env)
   (let ((n (PycFor-target this)))
      (if (and (isa? n PycRefUnresolved)
	       (not (lookup-id env (PycRefUnresolved-id n))))
	  (let* ((loc (PycNode-loc this))
		 (decl (new-PycDeclInit loc
			  (PycRefUnresolved-id n)
			  'local
			  (new-PycUninit loc))))
	     (cons decl
		(collect-free-assig* (PycLoop-body this) (cons decl env))))
	  ;; no need to scan the iterators as they are plain expressions
	  (collect-free-assig* (PycLoop-body this) env))))
   
;; find a variable in the environment
(define (lookup-id env id)
   (let loop ((env env))
      (cond
	 ((null? env) #f)
	 ((not (eq? (PycDecl-id (car env)) id)) (loop (cdr env)))
	 ((eq? (PycDecl-scope (car env)) 'local) (car env))
	 ((eq? (PycDecl-scope (car env)) 'block) (car env))
	 (else (car env)))))

 
