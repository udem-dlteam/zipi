(define (py-scheme ast conf)
   (let* ((cnt (make-cell 0))
	  (caches (collect-caches ast cnt)))
      (PyModule-caches-set! ast (cell-ref cnt))
      (PyNode-%info-set! ast (pyc-scheme ast conf))
      ast))

(define (py-scheme-eval ast conf)
   (let ((def (PyNode-%info ast)))
      ((eval def) (py-make-global) (py-make-caches (PyModule-caches ast)))))

(define (py-scheme-bigloo ast conf)
   (pp `(module ,(string->symbol (config-get conf 'src "__stdin"))
	   (import __py_object)
	   (import __py_hclass)
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
      `(letrec* ,(map (lambda (decl val)
			 `((,(pyc-scheme decl conf) ,(pyc-scheme val conf))))
		    (PyBlock-decls this) (PyBlock-vals this))
	  ,(pyc-scheme (PyBlock-body this) conf))))

(define-walk-method (pyc-scheme this::PyReturn conf)
   (if (PyReturn-tail this)
       (pyc-scheme (PyReturn-val this) conf)
       (epairify this
	  `(return (pyc-scheme (PyReturn-val this) conf)))))

(define (pyc-test this conf)
   (if (eq? (PyExpr-type this) 'bool)
       (pyc-scheme this conf)
       (epairify this
	  `(py-test ,(pyc-scheme this conf)))))

(define-walk-method (pyc-scheme this::PyWhile conf)

   (define (pyc-scheme-while this)
      (let ((loop (gensym 'loop)))
	 (epairify this
	    (if (PyWhile-need-continue this)
		`(let ,loop ()
		      (bind-exit (%continue)
			 (when ,(pyc-test (PyWhile-test this) conf)
			    ,(pyc-scheme (PyWhile-body this) conf)
			    (,loop))))
		`(let ,loop ()
		      (when ,(pyc-test (PyWhile-test this) conf)
			 ,(pyc-scheme (PyWhile-body this) conf)
			 (,loop)))))))
   (cond
      ((PyWhile-need-break this)
       (epairify this
	  `(bind-exit (%break)
	      ,(pyc-scheme-while this)
	      ,@(if (isa? (PyWhile-else this) PyPass)
		    '()
		    (pyc-scheme (PyWhile-else this) conf)))))
      ((isa? (PyWhile-else this) PyPass)
       (pyc-scheme-while this))
      (else
       (epairify this
	  `(begin
	      ,(pyc-scheme-while this)
	      ,(pyc-scheme (PyWhile-else this) conf))))))

(define-walk-method (pyc-scheme this::PyIf conf)
   (epairify this
      `(if ,(pyc-test (PyIf-test this) conf)
	   ,(pyc-scheme (PyIf-then this) conf)
	   ,(pyc-scheme (PyIf-else this) conf))))

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
   `(& ,(symbol->string name)))

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
   (let ((args (map (lambda (a) (pyc-scheme a conf)) (PyFun-args this)))
	 (body (pyc-scheme (PyFun-body this) conf)))
      (epairify this
	 `(make-PyFunction (PyFunction-default-hclass) '#()
	     ,(if (PyFun-need-return this)
		  `(lambda ,args (bind-exit (return) ,body))
		  `(lambda ,args ,body))))))

(define-walk-method (pyc-scheme this::PyCall conf)
   (let ((call (case (length (PyCall-args this))
		  ((0) 'PyFunction-call0)
		  ((1) 'PyFunction-call1)
		  ((2) 'PyFunction-call2)
		  ((3) 'PyFunction-call4)
		  (else (error "pyc-scheme" "Not implemented" (py->list this))))))
      (epairify this
	 `(,call
	     ,(pyc-scheme (PyCall-fun this) conf)
	     ,@(map (lambda (a) (pyc-scheme a conf)) (PyCall-args this))))))

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

(define-walk-method (collect-caches this::PyAssig cnt)
   (call-default-walker)
   (when (isa? (PyAssig-lhs this) PyRef)
      (when (eq? (PyDecl-scope (PyRef-decl (PyAssig-lhs this))) 'global)
	 (let ((n (cell-ref cnt)))
	    (cell-set! cnt (+ 1 n))
	    (PyNode-%info-set! this n)))))
	  
   
