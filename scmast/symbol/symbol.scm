;; symbol resolution
(define (py-symbol! this::PyNode conf)
   (let ((env (collect-global* this)))
      (resolve! this env conf)))

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
	 (else (values (car env) -1)))))
 
