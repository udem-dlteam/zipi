(define (py-scheme ast conf)
   (let* ((cnt (make-cell 0))
	  (caches (collect-caches ast cnt)))
      (PyModule-caches-set! ast (cell-ref cnt))
      (PyNode-%info-set! ast (pyc-scheme ast conf))
      ast))

(define (py-scheme-eval ast conf)
   (let ((def (PyNode-%info ast)))
      (when (>= (config-get conf 'verbose 0) 1)
	 (newline (current-error-port)))
      ((eval def) (py-make-global) (py-make-caches (PyModule-caches ast)))))

(define (py-scheme-bigloo ast conf)
   (pp `(module ,(string->symbol (config-get conf 'src "__stdin"))
	   (import __py_object)
	   (import __py_hclass)
	   (import __py_iterator)
	   (main main)))
   (pp `(define (main argv)
	   (pyc (py-make-global) (py-make-caches ,(PyModule-caches ast)))))
   (pp `(define pyc ,(PyNode-%info ast))))
		    
(define (py-scheme-gambit ast conf)
   (tprint "TODO"))

(define (config-get conf key . def)
   (let ((c (memq key conf)))
      (if c (cadr c) (if (pair? def) (car def) #f))))

(define uninit
   (let ((hclass (make-HClass '#() '())))
      (make-PyObject hclass '#())))

(define (pyc-scheme* nodes conf)
   (map (lambda (n) (pyc-scheme n conf)) nodes))

(define (pyc-scheme+ vals decls conf)
   (let loop ((vals vals)
	      (decls decls)
	      (conf conf)
	      (acc '()))
      (if (null? vals)
	  acc
	  (loop (cdr vals) (cdr decls) (cons (car decls) conf)
	     (cons (pyc-scheme (car vals) conf) acc)))))

(define-walk-method (pyc-scheme this::PyNode conf)
   (error "pyc-scheme" "Not implemented" (py->list this)))

(define-walk-method (pyc-scheme this::PyModule conf)
   (epairify this
      `(lambda (%global %caches)
	  ,@(pyc-scheme* (PyModule-stmts this) (PyModule-globals this)))))

(define-walk-method (pyc-scheme this::PySeq conf)
   (epairify this
      `(begin ,@(pyc-scheme* (PySeq-nodes this) conf))))

(define-walk-method (pyc-scheme this::PyBlock conf)
   (epairify this
      `(letrec* ,(map (lambda (decl)
			 `(,(pyc-scheme-decl decl conf)
			   ,(pyc-scheme (PyDeclInit-val decl) conf)))
		    (PyBlock-decls this))
	  ,(pyc-scheme (PyBlock-body this) conf))))

(define-walk-method (pyc-scheme this::PyReturn conf)
   (if (PyReturn-tail this)
       (pyc-scheme (PyReturn-val this) conf)
       (epairify this
	  `(return (pyc-scheme (PyReturn-val this) conf)))))

(define-walk-method (pyc-scheme this::PyReturnYield conf)
   (let ((kont (PyReturnYield-kont this))
	 (gen (PyReturnYield-generator this)))
      (epairify this
	 `(,(if gen 'py-generator-yield* 'py-generator-yield)
	   %gen ,(pyc-scheme (PyReturnYield-val this) conf)
	   ,(pyc-scheme kont conf)))))

(define-walk-method (pyc-scheme this::PyStmtExpr conf)
   (pyc-scheme (PyStmtExpr-expr this) conf))

(define (pyc-test this conf)
   (if (eq? (PyExpr-type this) 'bool)
       (pyc-scheme this conf)
       (epairify this
	  `(py-test ,(pyc-scheme this conf)))))

(define-walk-method (pyc-scheme this::PyWhile conf)

   (define (pyc-scheme-while this)
      (let ((loop (gensym 'loop)))
	 (epairify this
	    (if (PyLoop-need-continue this)
		`(let ,loop ()
		      (bind-exit (%continue)
			 (when ,(pyc-test (PyWhile-test this) conf)
			    ,(pyc-scheme (PyLoop-body this) conf)
			    (,loop))))
		`(let ,loop ()
		      (when ,(pyc-test (PyWhile-test this) conf)
			 ,(pyc-scheme (PyLoop-body this) conf)
			 (,loop)))))))
   (cond
      ((PyLoop-need-break this)
       (epairify this
	  `(bind-exit (%break)
	      ,(pyc-scheme-while this)
	      ,@(if (isa? (PyLoop-else this) PyPass)
		    '()
		    (pyc-scheme (PyLoop-else this) conf)))))
      ((isa? (PyLoop-else this) PyPass)
       (pyc-scheme-while this))
      (else
       (epairify this
	  `(begin
	      ,(pyc-scheme-while this)
	      ,(pyc-scheme (PyLoop-else this) conf))))))

(define-walk-method (pyc-scheme this::PyIf conf)
   (epairify this
      `(if ,(pyc-test (PyIf-test this) conf)
	   ,(pyc-scheme (PyIf-then this) conf)
	   ,(pyc-scheme (PyIf-else this) conf))))

(define-walk-method (pyc-scheme this::PyTry conf)
   
   (define (pyc-scheme-try this conf)
      `(with-handler
	  (lambda (%exn)
	     (cond
		,@(map (lambda (h) (pyc-scheme h conf))
		   (PyTry-handlers this))))
	  ,(if (isa? (PyTry-else this) PyPass)
	       (pyc-scheme (PyTry-body this) conf)
	       `(begin
		   ,(pyc-scheme (PyTry-body this) conf)
		   ,(pyc-scheme (PyTry-else this) conf)))))
   
   (epairify this
      (if (isa? (PyTry-finally this) PyPass)
	  (pyc-scheme-try this conf)
	  `(unwind-protect
	      ,(pyc-scheme-try this conf)
	      ,(pyc-scheme (PyTry-finally this) conf)))))

(define-walk-method (pyc-scheme this::PyRaise conf)
   (epairify this
      `(py-throw ,(pyc-scheme (PyRaise-exc this) conf))))

(define-walk-method (pyc-scheme this::PyHandler conf)
   (epairify this
      `(,(if (isa? (PyHandler-type this) PyUninit)
	     #t
	     `(isa? %exn ,(pyc-scheme (PyHandler-type this) conf)))
	,(pyc-scheme (PyHandler-body this) conf))))
			
(define-walk-method (pyc-scheme this::PyPass conf)
   #f)

(define-walk-method (pyc-scheme this::PyBreak conf)
   (epairify this '(%break #f)))

(define-walk-method (pyc-scheme this::PyContinue conf)
   (epairify this '(%continue #f)))

(define (pyc-scheme-decl this conf)
   (unless (PyDecl-name this)
      (PyDecl-name-set! this
	 (symbol-append (PyDecl-id this)
	    (string->symbol (number->string (PyDecl-key this))))))
   (PyDecl-name this))

(define (pyc-propname name)
   (cond
      ((string? name) `(& ,name))
      ((symbol? name) `(& ,(symbol->string name)))
      (else (error "pyc-propname" "Wrong property name" name))))

(define-walk-method (pyc-scheme this::PyDecl conf)
   (pyc-scheme-decl this conf))

(define-walk-method (pyc-scheme this::PyDeclInit conf)
   (let ((val (pyc-scheme (PyDeclInit-val this) conf)))
      (epairify this
	 (if (eq? (PyDecl-scope this) 'local)
	     `(set! ,(pyc-scheme-decl this conf) ,val)
	     `(global-put! %global ,(pyc-propname (PyDecl-id this)) ,val
		 (vector-ref %caches ,(PyNode-%info this)))))))

(define-walk-method (pyc-scheme this::PyAssig conf)
   (let* ((ref (PyAssig-lhs this))
	  (decl (PyRef-decl ref))
	  (val (pyc-scheme (PyAssig-rhs this) conf)))
      (epairify this
	 (case (PyDecl-scope decl)
	    ((global)
	     `(global-put! %global ,(pyc-propname (PyDecl-id decl)) ,val
		 (vector-ref %caches ,(PyNode-%info this))))
	    (else
	     `(set! ,(pyc-scheme-decl decl conf) ,val))))))

(define-walk-method (pyc-scheme this::PyPragma conf)
   (epairify this
      (PyPragma-expr this)))

(define-walk-method (pyc-scheme this::PyUninit conf)
   uninit)

(define-walk-method (pyc-scheme this::PyBool conf)
   (PyLiteralValue-val this))

(define-walk-method (pyc-scheme this::PyNumber conf)
   (PyLiteralValue-val this))

(define-walk-method (pyc-scheme this::PyString conf)
   (PyLiteralValue-val this))

(define-walk-method (pyc-scheme this::PyBinary conf)
   (epairify this
      `(,(symbol-append 'py (PyBinary-op this))
	,(pyc-scheme (PyBinary-lhs this) conf)
	,(pyc-scheme (PyBinary-rhs this) conf))))

(define-walk-method (pyc-scheme this::PyFun conf)
   
   (define (generator this::PyFun exp)
      (if (PyFun-generator this)
	  (epairify this
	     `(letrec ((%gen (py-make-generator (lambda (%v %e) ,exp))))
		 %gen))
	  exp))
   
   (let ((args (map (lambda (a) (pyc-scheme a conf)) (PyFun-args this)))
	 (body (pyc-scheme (PyFun-body this) conf)))
      (epairify this
	 `(make-PyFunction (PyFunction-default-hclass) '#()
	     ,(if (PyFun-need-return this)
		  `(lambda ,args ,(generator this `(bind-exit (return) ,body)))
		  `(lambda ,args ,(generator this body)))))))

(define-walk-method (pyc-scheme this::PyKont conf)
   (let ((param (pyc-scheme (PyKont-param this) conf))
	 (exn (pyc-scheme (PyKont-exn this) conf)))
      (epairify this
	 `(lambda (,param ,exn)
	     ,(pyc-scheme (PyKont-body this) conf)))))

(define-walk-method (pyc-scheme this::PyCall conf)
   
   (define (invoke fun args)
      (let ((call (case (length args)
		     ((0) 'PyFunction-call0)
		     ((1) 'PyFunction-call1)
		     ((2) 'PyFunction-call2)
		     ((3) 'PyFunction-call4)
		     (else (error "pyc-scheme" "Not implemented" (py->list this))))))
	 `(,call ,fun ,@args)))

   (let ((fun (PyCall-fun this)))
      (if (isa? fun PyAccess)
	  ;; method call
	  (let ((obj (gensym '%obj)))
	     (epairify this
		`(let ((,obj ,(pyc-scheme (PyAccess-obj fun) conf)))
		    ,(invoke `(object-get ,obj
				 ,(pyc-propname (PyAccess-field fun))
				 (vector-ref %caches ,(PyNode-%info fun)))
			(cons obj
			   (map (lambda (a) (pyc-scheme a conf))
			      (PyCall-args this)))))))
	  ;; function call
	  (epairify this
	     (invoke (pyc-scheme fun conf)
		(map (lambda (a) (pyc-scheme a conf)) (PyCall-args this)))))))

(define-walk-method (pyc-scheme this::PyRef conf)
   (let ((decl (PyRef-decl this)))
      (case (PyDecl-scope decl)
	 ((global)
	  (epairify this
	     `(global-get %global ,(pyc-propname (PyDecl-id decl))
		 (vector-ref %caches ,(PyNode-%info this)))))
	 (else
	  (pyc-scheme decl conf)))))

(define-walk-method (pyc-scheme this::PyRefUnresolved conf)
   (epairify this
      `(global-get %global ,(pyc-propname (PyRefUnresolved-id this))
	  (vector-ref %caches ,(PyNode-%info this)))))

(define-walk-method (pyc-scheme this::PyAccess conf)
   (epairify this
      `(object-get ,(pyc-scheme (PyAccess-obj this) conf)
	  ,(pyc-propname (PyAccess-field this))
	  (vector-ref %caches ,(PyNode-%info this)))))

;; collect caches
(define-walk-method (collect-caches this::PyNode cnt)
   (call-default-walker))

(define-walk-method (collect-caches this::PyDeclInit cnt)
   (call-default-walker)
   (when (eq? (PyDecl-scope this) 'global)
      (let ((n (cell-ref cnt)))
	 (cell-set! cnt (+ 1 n))
	 (PyNode-%info-set! this n))))
      
(define-walk-method (collect-caches this::PyRef cnt)
   (when (eq? (PyDecl-scope (PyRef-decl this)) 'global)
      (let ((n (cell-ref cnt)))
	 (cell-set! cnt (+ 1 n))
	 (PyNode-%info-set! this n))))

(define-walk-method (collect-caches this::PyRefUnresolved cnt)
   (let ((n (cell-ref cnt)))
      (cell-set! cnt (+ 1 n))
      (PyNode-%info-set! this n)))

(define-walk-method (collect-caches this::PyAccess cnt)
   (call-default-walker)
   (let ((n (cell-ref cnt)))
      (cell-set! cnt (+ 1 n))
      (PyNode-%info-set! this n)))

(define-walk-method (collect-caches this::PyAssig cnt)
   (call-default-walker)
   (when (isa? (PyAssig-lhs this) PyRef)
      (when (eq? (PyDecl-scope (PyRef-decl (PyAssig-lhs this))) 'global)
	 (let ((n (cell-ref cnt)))
	    (cell-set! cnt (+ 1 n))
	    (PyNode-%info-set! this n)))))
	  
   
