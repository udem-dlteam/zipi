(define (py-scheme ast conf)
   (let* ((cnt (make-cell 0))
	  (caches (collect-caches ast cnt)))
      (PycModule-caches-set! ast (cell-ref cnt))
      (PycNode-%info-set! ast (pyc-scheme ast conf))
      ast))

(define (py-scheme-eval ast conf)
   (let ((def (PycNode-%info ast)))
      (when (>= (config-get conf 'verbose 0) 1)
	(newline (current-error-port)))
      ((eval def) (py-make-global) (py-make-caches (PycModule-caches ast)))))

(define (py-scheme-bigloo ast conf)
   (pp `(module ,(string->symbol (config-get conf 'src "__stdin"))
	   (import __py_object)
	   (import __py_hclass)
	   (import __py_iterator)
	   (main main)))
   (pp `(define (main argv)
	   (pyc (py-make-global) (py-make-caches ,(PycModule-caches ast)))))
   (pp `(define pyc ,(PycNode-%info ast))))

(define (py-scheme-gambit ast conf)
  (pretty-print
   `(begin
      (|##import| bigloo)
      (|##include| "hclass/hclass.bgl")
      (|##include| "hclass/hclass.scm")
      (|##include| "object/object.bgl")
      (|##include| "object/object.scm")
      (|##include| "iterator/iterator.bgl")
      (|##include| "iterator/iterator.scm")
      (define (main args)
        (pyc (py-make-global) (py-make-caches ,(PycModule-caches ast))))
      (define pyc ,(PycNode-%info ast))
      (main (command-line)))))

(define (config-get conf key . def)
   (let ((c (memq key conf)))
      (if c (cadr c) (if (pair? def) (car def) #f))))

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

(define-walk-method (pyc-scheme this::PycNode conf)
   (error "pyc-scheme" "Not implemented" (py->list this)))

(define-walk-method (pyc-scheme this::PycModule conf)
   (epairify this
      `(lambda (%global %caches)
	  ,@(pyc-scheme* (PycModule-stmts this) (PycModule-globals this)))))

(define-walk-method (pyc-scheme this::PycSeq conf)
   (epairify this
      `(begin ,@(pyc-scheme* (PycSeq-nodes this) conf))))

(define-walk-method (pyc-scheme this::PycBlock conf)
   (epairify this
      `(letrec* ,(map (lambda (decl)
			 `(,(pyc-scheme-decl decl conf)
			   ,(pyc-scheme (PycDeclInit-val decl) conf)))
		    (PycBlock-decls this))
	  ,(pyc-scheme (PycBlock-body this) conf))))

(define-walk-method (pyc-scheme this::PycReturn conf)
   (if (PycReturn-tail this)
       (pyc-scheme (PycReturn-val this) conf)
       (epairify this
	  `(return (pyc-scheme (PycReturn-val this) conf)))))

(define-walk-method (pyc-scheme this::PycReturnYield conf)
   (let ((kont (PycReturnYield-kont this))
	 (gen (PycReturnYield-generator this)))
      (epairify this
	 `(,(if gen 'py-generator-yield* 'py-generator-yield)
	   %gen ,(pyc-scheme (PycReturnYield-val this) conf)
	   ,(pyc-scheme kont conf)))))

(define-walk-method (pyc-scheme this::PycStmtExpr conf)
   (pyc-scheme (PycStmtExpr-expr this) conf))

(define (pyc-test this conf)
   (if (eq? (PycExpr-type this) 'bool)
       (pyc-scheme this conf)
       (epairify this
	  `(py-test ,(pyc-scheme this conf)))))

(define-walk-method (pyc-scheme this::PycWhile conf)

   (define (pyc-scheme-while this)
      (let ((loop (gensym '%while)))
	 (epairify this
	    (if (PycLoop-need-continue this)
		`(let ,loop ()
		      (bind-exit (%continue)
			 (when ,(pyc-test (PycWhile-test this) conf)
			    ,(pyc-scheme (PycLoop-body this) conf)
			    (,loop))))
		`(let ,loop ()
		      (when ,(pyc-test (PycWhile-test this) conf)
			 ,(pyc-scheme (PycLoop-body this) conf)
			 (,loop)))))))
   
   (cond
      ((PycLoop-need-break this)
       (epairify this
	  `(bind-exit (%break)
	      ,(pyc-scheme-while this)
	      ,@(if (isa? (PycLoop-else this) PycPass)
		    '()
		    (pyc-scheme (PycLoop-else this) conf)))))
      ((isa? (PycLoop-else this) PycPass)
       (pyc-scheme-while this))
      (else
       (epairify this
	  `(begin
	      ,(pyc-scheme-while this)
	      ,(pyc-scheme (PycLoop-else this) conf))))))

(define-walk-method (pyc-scheme this::PycFor conf)

   (define (pyc-scheme-for this)
      (let ((loop (gensym '%for))
	    (target (gensym '%target))
	    (iterable (gensym '%iterable))
	    (iterator (gensym '%iterator))
	    (next (gensym '%next)))
	 (epairify this
	    `(let* ((,iterable ,(pyc-scheme (PycFor-iter this) conf))
		    (,iterator (PyFunction-call1
				  (object-get ,iterable
				     (& "__iter__")
				     (vector-ref %caches
					,(car (PycNode-%info this))))
				  ,iterable))
		    (,next (object-get ,iterator (& "__next__")
			      (vector-ref %caches ,(cdr (PycNode-%info this))))))
		(let ,loop ()
		     (let ((,target (py-for-next ,iterator ,next)))
			(unless (eq? ,target 'StopIteration)
			   ,(let ((assig (new-PycAssig (PycNode-loc this)
					    (PycFor-target this)
					    (new-PycPragma (PycNode-loc this) target))))
			       (pyc-scheme  assig conf))
			   ,(if (PycLoop-need-continue this)
				`(bind-exit (%continue)
				    ,(pyc-scheme (PycLoop-body this) conf))
				(pyc-scheme (PycLoop-body this) conf))
			   (,loop))))))))
   
   (cond
      ((PycLoop-need-break this)
       (epairify this
	  `(bind-exit (%break)
	      ,(pyc-scheme-for this)
	      ,@(if (isa? (PycLoop-else this) PycPass)
		    '()
		    (pyc-scheme (PycLoop-else this) conf)))))
      ((isa? (PycLoop-else this) PycPass)
       (pyc-scheme-for this))
      (else
       (epairify this
	  `(begin
	      ,(pyc-scheme-for this)
	      ,(pyc-scheme (PycLoop-else this) conf))))))

(define-walk-method (pyc-scheme this::PycIf conf)
   (epairify this
      `(if ,(pyc-test (PycIf-test this) conf)
	   ,(pyc-scheme (PycIf-then this) conf)
	   ,(pyc-scheme (PycIf-else this) conf))))

(define-walk-method (pyc-scheme this::PycWith conf)
   (epairify this
      `(py-with ,(pyc-scheme (PycWith-expr this) conf)
	  (lambda ()
	     ,(pyc-scheme (PycWith-body this) conf)))))

(define-walk-method (pyc-scheme this::PycTry conf)
   
   (define (pyc-scheme-try this conf)
      `(with-handler
	  (lambda (%exn)
	     (cond
		,@(map (lambda (h) (pyc-scheme h conf))
		   (PycTry-handlers this))))
	  ,(if (isa? (PycTry-else this) PycPass)
	       (pyc-scheme (PycTry-body this) conf)
	       `(begin
		   ,(pyc-scheme (PycTry-body this) conf)
		   ,(pyc-scheme (PycTry-else this) conf)))))
   
   (epairify this
      (if (isa? (PycTry-finally this) PycPass)
	  (pyc-scheme-try this conf)
	  `(unwind-protect
	      ,(pyc-scheme-try this conf)
	      ,(pyc-scheme (PycTry-finally this) conf)))))

(define-walk-method (pyc-scheme this::PycRaise conf)
   (epairify this
      `(py-throw ,(pyc-scheme (PycRaise-exc this) conf))))

(define-walk-method (pyc-scheme this::PycHandler conf)
   (epairify this
      `(,(if (isa? (PycHandler-type this) PycUninit)
	     #t
	     `(isa? %exn ,(pyc-scheme (PycHandler-type this) conf)))
	,(pyc-scheme (PycHandler-body this) conf))))
			
(define-walk-method (pyc-scheme this::PycPass conf)
   #f)

(define-walk-method (pyc-scheme this::PycBreak conf)
   (epairify this '(%break #f)))

(define-walk-method (pyc-scheme this::PycContinue conf)
   (epairify this '(%continue #f)))

(define (pyc-scheme-decl this conf)
   (unless (PycDecl-name this)
      (PycDecl-name-set! this
	 (symbol-append (PycDecl-id this)
	    (string->symbol (number->string (PycDecl-key this))))))
   (PycDecl-name this))

(define (pyc-propname name)
   (cond
      ((string? name) `(& ,name))
      ((symbol? name) `(& ,(symbol->string name)))
      (else (error "pyc-propname" "Wrong property name" name))))

(define-walk-method (pyc-scheme this::PycDecl conf)
   (pyc-scheme-decl this conf))

(define-walk-method (pyc-scheme this::PycDeclInit conf)
   (let ((val (pyc-scheme (PycDeclInit-val this) conf)))
      (epairify this
	 (if (eq? (PycDecl-scope this) 'local)
	     `(set! ,(pyc-scheme-decl this conf) ,val)
	     `(global-put! %global ,(pyc-propname (PycDecl-id this)) ,val
		 (vector-ref %caches ,(PycNode-%info this)))))))

(define-walk-method (pyc-scheme this::PycAssig conf)
   (cond
      ((isa? (PycAssig-lhs this) PycRef)
       (let* ((ref (PycAssig-lhs this))
	      (decl (PycRef-decl ref))
	      (val (pyc-scheme (PycAssig-rhs this) conf)))
	  (epairify this
	     (case (PycDecl-scope decl)
		((global)
		 `(global-put! %global ,(pyc-propname (PycDecl-id decl)) ,val
		     (vector-ref %caches ,(PycNode-%info this))))
		(else
		 `(set! ,(pyc-scheme-decl decl conf) ,val))))))
      ((isa? (PycAssig-lhs this) PycAccess)
       (let* ((axs (PycAssig-lhs this))
	      (obj (PycAccess-obj axs))
	      (field (PycAccess-field axs))
	      (val (pyc-scheme (PycAssig-rhs this) conf)))
	  (epairify this
	     `(object-put! ,(pyc-scheme obj conf) ,field
		 ,(pyc-scheme (PycAssig-rhs this) conf)))))
      (else
       (let* ((axs (PycAssig-lhs this))
	      (obj (PycSubscript-obj axs))
	      (index (PycSubscript-index axs))
	      (val (pyc-scheme (PycAssig-rhs this) conf)))
	  (epairify this
	     `(py-setitem! ,(pyc-scheme obj conf)
		 ,(pyc-scheme index conf)
		 ,(pyc-scheme (PycAssig-rhs this) conf)))))))

(define-walk-method (pyc-scheme this::PycAugAssig conf)
   (cond
      ((or (isa? (PycAssig-lhs this) PycRef)
	   (isa? (PycAssig-lhs this) PycAccess))
       (let ((assig (new-PycAssig (PycNode-loc this)
		       (PycAssig-lhs this)
		       (new-PycBinary (PycNode-loc this)
			  (PycAugAssig-op this)
			  (PycAssig-lhs this)
			  (PycAssig-rhs this))
		       %info: (PycNode-%info this))))
	  (pyc-scheme assig conf)))
      (else
       (let* ((axs (PycAssig-lhs this))
	      (obj (PycSubscript-obj axs))
	      (index (PycSubscript-index axs))
	      (val (pyc-scheme (PycAssig-rhs this) conf)))
	  (let* ((idx (gensym '%i))
		 (assig (new-PycAssig (PycNode-loc this)
			   (new-PycSubscript (PycNode-loc axs)
			      obj
			      (new-PycPragma (PycNode-loc index) idx))
			   (new-PycBinary (PycNode-loc this)
			      (PycAugAssig-op this)
			      (new-PycSubscript (PycNode-loc axs)
				 obj
				 (new-PycPragma (PycNode-loc index) idx))
			      (PycAssig-rhs this)))))
	     
	     (epairify this
		`(let ((,idx ,(pyc-scheme index conf)))
		    ,(pyc-scheme assig conf))))))))

(define-walk-method (pyc-scheme this::PycPragma conf)
   (epairify this
      (PycPragma-expr this)))

(define-walk-method (pyc-scheme this::PycUninit conf)
   (epairify this
      '(py-uninit)))

(define-walk-method (pyc-scheme this::PycBool conf)
   (PycLiteralValue-val this))

(define-walk-method (pyc-scheme this::PycNumber conf)
   (PycLiteralValue-val this))

(define-walk-method (pyc-scheme this::PycString conf)
   (PycLiteralValue-val this))

(define-walk-method (pyc-scheme this::PycBinary conf)
   (epairify this
      `(,(symbol-append 'py (PycBinary-op this))
	,(pyc-scheme (PycBinary-lhs this) conf)
	,(pyc-scheme (PycBinary-rhs this) conf))))

(define-walk-method (pyc-scheme this::PycFun conf)
   
   (define (generator this::PycFun exp)
      (if (PycFun-generator this)
	  (epairify this
	     `(letrec ((%gen (py-make-generator (lambda (%v %e) ,exp))))
		 %gen))
	  exp))
   
   (let ((args (map (lambda (a) (pyc-scheme a conf)) (PycFun-args this)))
	 (body (pyc-scheme (PycFun-body this) conf)))
      (epairify this
	 `(make-PyFunction (PyFunction-default-hclass) '#()
	     ,(if (PycFun-need-return this)
		  `(lambda ,args ,(generator this `(bind-exit (return) ,body)))
		  `(lambda ,args ,(generator this body)))))))

(define-walk-method (pyc-scheme this::PycClass conf)

   (define (pyc-class this::PycClass)
      (epairify this
	 `(py-make-class
	     ,@(append-map (lambda (decl)
			      `((& ,(symbol->string (PycDecl-id decl)))
				,(pyc-scheme-decl decl conf)))
		  (PycClass-decls this)))))
				  
   (let ((body (pyc-scheme (PycClass-body this) conf)))
      (epairify this
	 (match-case body
	    ((letrec* ?bindings . ?body)
	     `(letrec* ,bindings ,@body ,(pyc-class this)))
	    (else
	     `(begin ,body ,(pyc-class this)))))))

(define-walk-method (pyc-scheme this::PycKont conf)
   (let ((param (pyc-scheme (PycKont-param this) conf))
	 (exn (pyc-scheme (PycKont-exn this) conf)))
      (epairify this
	 `(lambda (,param ,exn)
	     ,(pyc-scheme (PycKont-body this) conf)))))

(define-walk-method (pyc-scheme this::PycCall conf)
   
   (define (invoke fun args)
      (let ((call (case (length args)
		     ((0) 'PyFunction-call0)
		     ((1) 'PyFunction-call1)
		     ((2) 'PyFunction-call2)
		     ((3) 'PyFunction-call4)
		     (else (error "pyc-scheme" "Not implemented" (py->list this))))))
	 `(,call ,fun ,@args)))

   (let ((fun (PycCall-fun this)))
      (if (isa? fun PycAccess)
	  ;; method call
	  (let ((obj (gensym '%obj)))
	     (epairify this
		`(let ((,obj ,(pyc-scheme (PycAccess-obj fun) conf)))
		    ,(invoke `(object-get ,obj
				 ,(pyc-propname (PycAccess-field fun))
				 (vector-ref %caches ,(PycNode-%info fun)))
			(cons obj
			   (map (lambda (a) (pyc-scheme a conf))
			      (PycCall-args this)))))))
	  ;; function call
	  (epairify this
	     (invoke (pyc-scheme fun conf)
		(map (lambda (a) (pyc-scheme a conf)) (PycCall-args this)))))))

(define-walk-method (pyc-scheme this::PycCollection conf)
   (epairify this
      `(,(if (isa? this PycList) 'py-make-list 'py-make-tuple)
	,@(map (lambda (e) (pyc-scheme e conf)) (PycList-elts this)))))

(define-walk-method (pyc-scheme this::PycRef conf)
   (let ((decl (PycRef-decl this)))
      (case (PycDecl-scope decl)
	 ((global)
	  (epairify this
	     `(global-get %global ,(pyc-propname (PycDecl-id decl))
		 (vector-ref %caches ,(PycNode-%info this)))))
	 (else
	  (pyc-scheme-decl decl conf)))))

(define-walk-method (pyc-scheme this::PycRefUnresolved conf)
   (epairify this
      `(global-get %global ,(pyc-propname (PycRefUnresolved-id this))
	  (vector-ref %caches ,(PycNode-%info this)))))

(define-walk-method (pyc-scheme this::PycAccess conf)
   (epairify this
      `(object-get ,(pyc-scheme (PycAccess-obj this) conf)
	  ,(pyc-propname (PycAccess-field this))
	  (vector-ref %caches ,(PycNode-%info this)))))

(define-walk-method (pyc-scheme this::PycSubscript conf)
   (epairify this
      `(py-getitem ,(pyc-scheme (PycSubscript-obj this) conf)
	  ,(pyc-scheme (PycSubscript-index this) conf))))

(define-walk-method (pyc-scheme this::PycSlice conf)
   (epairify this
      `(py-slice ,(pyc-scheme (PycSlice-obj this) conf)
	  ,(pyc-scheme (PycSlice-lower this) conf)
	  ,(pyc-scheme (PycSlice-upper this) conf)
	  ,(pyc-scheme (PycSlice-step this) conf))))

;; collect caches
(define-walk-method (collect-caches this::PycNode cnt)
   (call-default-walker))

(define-walk-method (collect-caches this::PycDeclInit cnt)
   (call-default-walker)
   (when (eq? (PycDecl-scope this) 'global)
      (let ((n (cell-ref cnt)))
	 (cell-set! cnt (+ 1 n))
	 (PycNode-%info-set! this n))))
      
(define-walk-method (collect-caches this::PycRef cnt)
   (when (eq? (PycDecl-scope (PycRef-decl this)) 'global)
      (let ((n (cell-ref cnt)))
	 (cell-set! cnt (+ 1 n))
	 (PycNode-%info-set! this n))))

(define-walk-method (collect-caches this::PycRefUnresolved cnt)
   (let ((n (cell-ref cnt)))
      (cell-set! cnt (+ 1 n))
      (PycNode-%info-set! this n)))

(define-walk-method (collect-caches this::PycAccess cnt)
   (call-default-walker)
   (let ((n (cell-ref cnt)))
      (cell-set! cnt (+ 1 n))
      (PycNode-%info-set! this n)))

(define-walk-method (collect-caches this::PycAssig cnt)
   (call-default-walker)
   (when (isa? (PycAssig-lhs this) PycRef)
      (when (eq? (PycDecl-scope (PycRef-decl (PycAssig-lhs this))) 'global)
	 (let ((n (cell-ref cnt)))
	    (cell-set! cnt (+ 1 n))
	    (PycNode-%info-set! this n)))))

(define-walk-method (collect-caches this::PycFor cnt)
   (call-default-walker)
   (let ((n (cell-ref cnt)))
      (cell-set! cnt (+ 1 n))
      (let ((m (cell-ref cnt)))
	 (cell-set! cnt (+ 1 n))
	 (PycNode-%info-set! this (cons n m)))))
	  
   
