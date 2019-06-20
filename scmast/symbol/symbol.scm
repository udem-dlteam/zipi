;; symbol resolution
(define (py-symbol! this conf)
   (let* ((env (collect* this 'global))
	  (%env (cons '% env)))
      (glodecl! this %env)
      (resolve! this (cdr %env) conf)))

;; collect declarations
(define-walk-method (collect* this::PyNode scope)
   (call-default-walker))

(define-walk-method (collect* this::PyFun scope)
   '())

(define-walk-method (collect* this::PyDecl scope)
   (if (eq? (PyDecl-scope this) scope)
       (list this)
       '()))

;; create all the global declarations
(define-walk-method (glodecl! this::PyNode %env)
   (call-default-walker))

(define-walk-method (glodecl! this::PyAssig %env)
   (let ((lhs (PyAssig-lhs this)))
      (cond
	 ((not (PyRefUnresolved? lhs))
	  (call-default-walker))
	 ((lookup-id (cdr %env) (PyRefUnresolved-id lhs))
	  (call-default-walker))
	 (else
	  (let ((decl (new-PyDeclInit (PyNode-loc this)
			 (PyRefUnresolved-id lhs) 'global
			 (glodecl! (PyAssig-rhs this) %env))))
	     (set-cdr! %env (cons decl (cdr %env)))
	     decl)))))

(define-walk-method (glodecl! this::PyFun %env)
   this)

;; symbol resolution
(define-walk-method (resolve! this::PyNode env conf)
   (call-default-walker))

(define-walk-method (resolve! this::PyModule env conf)
   (PyModule-globals-set! this env)
   (call-default-walker))

(define-walk-method (resolve! this::PyBlock env conf)
   (let loop ((env env)
	      (decls (PyBlock-decls this)))
      (if (null? decls)
	  (begin
	     (PyBlock-body-set! this (resolve! (PyBlock-body this) env conf))
	     this)
	  (let ((decl (car decls)))
	     (PyDeclInit-val-set! decl
		(resolve! (PyDeclInit-val decl) env conf))
	     (loop (cons decl env) (cdr decls))))))

(define-walk-method (resolve! this::PyRefUnresolved env conf)
   (let ((loc (PyNode-loc this)))
      (let ((decl (lookup-id env (PyRefUnresolved-id this))))
	 (if (PyDecl? decl)
	     (new-PyRef loc decl)
	     this))))

(define-walk-method (resolve! this::PyFun env conf)
   (let* ((loc (PyNode-loc this))
	  (decls (collect* (PyFun-body this) 'local))
	  (aenv (collect-free-assig* (PyFun-body this)
		   (append decls (PyFun-args this) env)))
	  (bdgs (map (lambda (decl)
			(let ((loc (PyDecl-loc decl)))
			   (new-PyDeclInit loc (PyDecl-id decl) 'local
			      (new-PyUninit loc))))
		   (append aenv decls))))
      (if (pair? bdgs)
	  (PyFun-body-set! this
	     (new-PyBlock loc
		bdgs
		(resolve! (PyFun-body this)
		   (append bdgs (PyFun-args this) env) conf)))
	  (PyFun-body-set! this
	     (resolve! (PyFun-body this) (append (PyFun-args this) env) conf)))
      this))

(define-walk-method (resolve! this::PyDeclInit env conf)
   (if (eq? (PyDecl-scope this) 'local)
       (let ((loc (PyNode-loc this)))
	  ;; replace the declaration with an assignment
	  (let ((decl (lookup-id env (PyDecl-id this))))
	     (new-PyAssig loc (new-PyRef loc decl)
		(resolve! (PyDeclInit-val this) env conf))))
       (call-default-walker)))

;; collect free variable assignments
(define-walk-method (collect-free-assig* this::PyNode env)
   (call-default-walker))

(define-walk-method (collect-free-assig* this::PyAssig env)
   (if (isa? (PyAssig-lhs this) PyRefUnresolved)
       (if (lookup-id env (PyRefUnresolved-id (PyAssig-lhs this)))
	   (collect-free-assig* (PyAssig-rhs this) env)
	   (let* ((loc (PyNode-loc (PyAssig-lhs this)))
		  (decl (new-PyDeclInit loc
			   (PyRefUnresolved-id (PyAssig-lhs this))
			   'local
			   (new-PyUninit loc))))
	      (cons decl
		 (collect-free-assig* (PyAssig-rhs this) (cons decl env)))))
       (call-default-walker)))

(define-walk-method (collect-free-assig* this::PyFor env)
   (let ((n (PyFor-target this)))
      (if (and (isa? n PyRefUnresolved)
	       (not (lookup-id env (PyRefUnresolved-id n))))
	  (let* ((loc (PyNode-loc this))
		 (decl (new-PyDeclInit loc
			  (PyRefUnresolved-id n)
			  'local
			  (new-PyUninit loc))))
	     (cons decl
		(collect-free-assig* (PyFor-body this) (cons decl env))))
	  ;; no need to scan the iterators as they are plain expressions
	  (collect-free-assig* (PyFor-body this) env))))
   
;; find a variable in the environment
(define (lookup-id env id)
   (let loop ((env env))
      (cond
	 ((null? env) #f)
	 ((not (eq? (PyDecl-id (car env)) id)) (loop (cdr env)))
	 ((eq? (PyDecl-scope (car env)) 'local) (car env))
	 ((eq? (PyDecl-scope (car env)) 'block) (car env))
	 (else (car env)))))

 
