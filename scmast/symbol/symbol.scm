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
	 ((lookup2 (cdr %env) (PyRefUnresolved-id lhs))
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
	      (decls (PyBlock-decls this))
	      (vals (PyBlock-vals this)))
      (if (null? vals)
	  (begin
	     (PyBlock-body-set! this (resolve! (PyBlock-body this) env conf))
	     this)
	  (begin
	     (set-car! vals (resolve! (car vals) env conf))
	     (loop (cons (car decls) env) (cdr decls) (cdr vals))))))

(define-walk-method (resolve! this::PyRefUnresolved env conf)
   (let ((loc (PyNode-loc this)))
      (let ((decl (lookup2 env (PyRefUnresolved-id this))))
	 (if (PyDecl? decl)
	     (new-PyRef loc decl)
	     this))))

(define-walk-method (resolve! this::PyFun env conf)
   (let* ((loc (PyNode-loc this))
	  (decls (collect* (PyFun-body this) 'local))
	  (denv (map (lambda (decl)
			(new-PyDecl loc (PyDecl-id decl) 'local))
		   decls))
	  (aenv (collect-free-assig* (PyFun-body this)
		   (append denv (PyFun-args this) env)))
	  (bdgs (append aenv denv)))
      (PyFun-body-set! this
	 (new-PyBlock loc
	    bdgs
	    (map (lambda (b) (new-PyUninit (PyNode-loc b))) bdgs)
	    (resolve! (PyFun-body this)
	       (append aenv denv (PyFun-args this) env) conf)))
      this))

(define-walk-method (resolve! this::PyDeclInit env conf)
   (if (eq? (PyDecl-scope this) 'local)
       (let ((loc (PyNode-loc this)))
	  ;; replace the declaration with an assignment
	  (let ((decl (lookup2 env (PyDecl-id this))))
	     (new-PyAssig loc (new-PyRef loc decl)
		(resolve! (PyDeclInit-val this) env conf))))
       (call-default-walker)))

;; collect free variable assignments
(define-walk-method (collect-free-assig* this::PyNode env)
   (call-default-walker))

(define-walk-method (collect-free-assig* this::PyAssig env)
   (if (isa? (PyAssig-lhs this) PyRefUnresolved)
       (if (lookup2 env (PyRefUnresolved-id (PyAssig-lhs this)))
	   (collect-free-assig* (PyAssig-rhs this) env)
	   (let ((loc (PyNode-loc (PyAssig-lhs this))))
	      (cons (new-PyDeclInit loc
		       (PyRefUnresolved-id (PyAssig-lhs this))
		       'local
		       (new-PyUninit loc))
		 (collect-free-assig* (PyAssig-rhs this) env))))
       (call-default-walker)))

;; find a variable in the environment
(define (lookup2 env id)
   (let loop ((env env))
      (cond
	 ((null? env) #f)
	 ((not (eq? (PyDecl-id (car env)) id)) (loop (cdr env)))
	 ((eq? (PyDecl-scope (car env)) 'local) (car env))
	 ((eq? (PyDecl-scope (car env)) 'block) (car env))
	 (else (car env)))))

 
