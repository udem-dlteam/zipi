;; symbol resolution
(define (pyc-symbol! this conf)
   (let* ((env (collect* this 'global))
	  (gla (collect-free* this #t '() 'global))
	  (%env (cons '% env))
	  (extras (filter-map (lambda (id)
				 (unless (lookup-id (cdr %env) id )
				    (new-PycDeclInit (PycNode-loc this)
				       id 'global
				       (new-PycUninit (PycNode-loc this)))))
		     gla)))
      (PycModule-stmts-set! this (append extras (PycModule-stmts this)))
      (glodecl! this %env)
      (resolve! this (append extras (cdr %env)) '() conf)))

;; collect declarations
(define-walk-method (collect* this::PycNode scope)
   (call-default-walker))

(define-walk-method (collect* this::PycFun scope)
   '())

(define-walk-method (collect* this::PycSemantics scope)
   '())

(define-walk-method (collect* this::PycDecl scope)
   (if (eq? (PycDecl-scope this) scope)
       (list this)
       '()))

;; create all global declarations
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

(define-walk-method (glodecl! this::PycSemantics %env)
   this)

(define-walk-method (glodecl! this::PycClass %env)
   this)

;; symbol resolution
(define-walk-method (resolve! this::PycNode env freeenv conf)
   (call-default-walker))

(define-walk-method (resolve! this::PycModule env freeenv conf)
   (PycModule-globals-set! this env)
   (call-default-walker))

(define-walk-method (resolve! this::PycBlock env freeenv conf)
   (let loop ((env env)
	      (decls (PycBlock-decls this)))
      (if (null? decls)
	  (begin
	     (PycBlock-body-set! this
		(resolve! (PycBlock-body this) env freeenv conf))
	     this)
	  (let ((decl (car decls)))
	     (PycDeclInit-val-set! decl
		(resolve! (PycDeclInit-val decl) env freeenv conf))
	     (loop (cons decl env) (cdr decls))))))

(define-walk-method (resolve! this::PycRefUnresolved env freeenv conf)
   (let ((loc (PycNode-loc this)))
      (let ((decl (lookup-id env (PycRefUnresolved-id this))))
	 (if (PycDecl? decl)
	     (new-PycRef loc decl)
	     this))))

(define-walk-method (resolve! this::PycFun env _ conf)
  (let*
   ((loc (PycNode-loc this))
    (vararg (PycFun-vararg this))
    (kwarg (PycFun-kwarg this))
    (args
      (append
        (PycFun-posonlyargs this)
        (PycFun-args this)
        (if (PycDecl? vararg) (list (PycDecl-id vararg)) '())
        (PycFun-kwonlyargs this)
        (if (PycDecl? kwarg) (list (PycDecl-id kwarg)) '())))
	  (decls (collect* (PycFun-body this) 'local))
	  (freeenv (collect-free* (PycFun-body this) #f '() '*))
	  (aenv (collect-free-assig* (PycFun-body this)
		   (append
         decls
         args
          env)
		   (cons '% freeenv)))
	  (bdgs (map (lambda (decl)
			(let ((loc (PycNode-loc decl)))
			   (new-PycDeclInit loc (PycDecl-id decl) 'local
			      (new-PycUninit loc))))
		   (append aenv decls))))
      (PycFun-decls-set! this bdgs)
      (if (pair? bdgs)
	  (PycFun-body-set! this
	     (new-PycBlock loc
		bdgs
		(resolve! (PycFun-body this)
		   (append bdgs args env) freeenv conf)))
	  (PycFun-body-set! this
	     (resolve! (PycFun-body this)
		(append args env) freeenv conf)))
      this))

(define-walk-method (resolve! this::PycSemantics env _ conf)
  (let*
   ((loc (PycNode-loc this))
    (args (PycSemantics-args this))
	  (decls (collect* (PycSemantics-body this) 'local))
	  (freeenv (collect-free* (PycSemantics-body this) #f '() '*))
	  (aenv (collect-free-assig* (PycSemantics-body this)
		   (append
         decls
         args
          env)
		   (cons '% freeenv)))
	  (bdgs (map (lambda (decl)
			(let ((loc (PycNode-loc decl)))
			   (new-PycDeclInit loc (PycDecl-id decl) 'local
			      (new-PycUninit loc))))
		   (append aenv decls))))
      (PycSemantics-decls-set! this bdgs)
      (if (pair? bdgs)
	  (PycSemantics-body-set! this
	     (new-PycBlock loc
		bdgs
		(resolve! (PycSemantics-body this)
		   (append bdgs args env) freeenv conf)))
	  (PycSemantics-body-set! this
	     (resolve! (PycSemantics-body this)
		(append args env) freeenv conf)))
      this))

(define-walk-method (resolve! this::PycClass env freeenv conf)
   (let* ((loc (PycNode-loc this))
	  (decls (collect* (PycClass-body this) 'local))
	  (aenv (collect-free-assig* (PycClass-body this)
		   (append decls env)
		   '(%)))
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
		   (append bdgs env) freeenv conf)))
	  (PycClass-body-set! this
	     (resolve! (PycClass-body this) env freeenv conf)))
      this))

(define-walk-method (resolve! this::PycDeclInit env freeenv conf)
   (if (eq? (PycDecl-scope this) 'local)
       (let ((loc (PycNode-loc this)))
	  ;; replace the declaration with an assignment
	  (let ((decl (lookup-id env (PycDecl-id this))))
	     (new-PycAssig loc (new-PycRef loc decl)
		(resolve! (PycDeclInit-val this) env freeenv conf))))
       (call-default-walker)))

(define-walk-method (resolve! this::PycSymbols env global conf)
   (new-PycPass (PycNode-loc this)))

;; collect free variable assignments
(define-walk-method (collect-free-assig* this::PycNode env freeenv)
   (call-default-walker))

(define-walk-method (collect-free-assig* this::PycAssig env freeenv)
   (cond
      ((not (isa? (PycAssig-lhs this) PycRefUnresolved))
       (call-default-walker))
      ((memq (PycRefUnresolved-id (PycAssig-lhs this)) freeenv)
       (error "symbol" "SyntaxError: name assigned before declaration"
	  (pyc->list this)))
      ((lookup-id env (PycRefUnresolved-id (PycAssig-lhs this)))
       (collect-free-assig* (PycAssig-rhs this) env freeenv))
      (else
       (let* ((loc (PycNode-loc (PycAssig-lhs this)))
	      (decl (new-PycDeclInit loc
		       (PycRefUnresolved-id (PycAssig-lhs this))
		       'local
		       (new-PycUninit loc))))
	  (cons decl
	     (collect-free-assig* (PycAssig-rhs this)
		(cons decl env) freeenv))))))

(define-walk-method (collect-free-assig* this::PycWithItem env freeenv)
  (let ((context-expr (PycWithItem-context-expr this))
        (optional-vars (PycWithItem-optional-vars this)))
    (if (isa? optional-vars PycRefUnresolved)
      (let* ((loc (PycNode-loc this))
             (decl
               (new-PycDeclInit
                 loc
                 (PycRefUnresolved-id optional-vars)
                 'local
                 (new-PycUninit loc))))
        (cons
          decl
          (collect-free-assig* context-expr env freeenv)))
      (collect-free-assig* context-expr env freeenv))))

(define-walk-method (collect-free-assig* this::PycFor env freeenv)
  (let ((n (PycFor-target this)))
    (if (and (isa? n PycRefUnresolved)
             (not (lookup-id env (PycRefUnresolved-id n))))
      (let* ((loc (PycNode-loc this))
            (decl
              (new-PycDeclInit loc
                (PycRefUnresolved-id n)
                'local
                (new-PycUninit loc))))
        (cons
          decl
          (collect-free-assig* (PycLoop-body this) (cons decl env) freeenv)))
      ;; no need to scan the iterators as they are plain expressions
      (collect-free-assig* (PycLoop-body this) env freeenv))))

(define-walk-method (collect-free-assig* this::PycSymbols env freeenv)
   (for-each (lambda (id)
		(set-cdr! freeenv (remq! id (cdr freeenv))))
      (list-copy (PycSymbols-names this)))
   '())

;; collect variables declared in a global statement
(define-walk-method (collect-free* this::PycNode rec env scope)
   (call-default-walker))

(define-walk-method (collect-free* this::PycSymbols rec env scope)
   (if (or (eq? (PycSymbols-scope this) scope) (eq? scope '*))
       (delete-duplicates (append (PycSymbols-names this) env))
       env))

(define-walk-method (collect-free* this::PycFun rec env scope)
   (if rec
       (call-default-walker)
       '()))

(define-walk-method (collect-free* this::PycSemantics rec env scope)
   (if rec
       (call-default-walker)
       '()))

;; find a variable in the environment
(define (lookup-id env id)
   (let loop ((env env))
      (cond
	 ((null? env) #f)
	 ((not (eq? (PycDecl-id (car env)) id)) (loop (cdr env)))
	 ((eq? (PycDecl-scope (car env)) 'local) (car env))
	 ((eq? (PycDecl-scope (car env)) 'block) (car env))
	 (else (car env)))))
