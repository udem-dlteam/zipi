;; symbol resolution
(define (py-symbol! this::PyNode conf)
   (glodecl! this)
   (let ((env (collect-global* this)))
      (resolve! this env conf)))

;; create all the global declarations
(define-walk-method (glodecl! this::PyNode)
   (call-default-walker))

(define-walk-method (glodecl! this::PyAssig)
   (let ((lhs (PyAssig-lhs this)))
      (if (PyRefUnresolved? lhs)
	  (make-PyDeclInit (PyNode-loc this)
	     (PyRefUnresolved-id lhs) 'global (glodecl! (PyAssig-rhs this)))
	  (call-default-walker))))
   
;; collect all global declarations
(define-walk-method (collect-global* this::PyNode)
   (call-default-walker))

(define-walk-method (collect-global* this::PyFun)
   '())

(define-walk-method (collect-global* this::PyDecl)
   (if (eq? (PyDecl-scope this) 'global)
       (list this)
       '()))

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
   (let ((loc (PyRefUnresolved-loc this)))
      (multiple-value-bind (decl offset)
	 (lookup env (PyRefUnresolved-id this))
	 (if (PyDecl? decl)
	     (make-PyRef loc decl offset)
	     this))))

(define-walk-method (resolve! this::PyFun env conf)
   (PyFun-body-set! this
      (resolve! (PyFun-body this) (append (PyFun-args this) env) conf))
   this)

(define (lookup env id)
   (let loop ((env env)
	      (offset 0))
      (cond
	 ((null? env) (values #f -1))
	 ((not (eq? (PyDecl-id (car env)) id)) (loop (cdr env) (+ offset 1)))
	 ((eq? (PyDecl-scope (car env)) 'local) (values (car env) offset))
	 ((eq? (PyDecl-scope (car env)) 'block) (values (car env) offset))
	 (else (values (car env) -1)))))
 
