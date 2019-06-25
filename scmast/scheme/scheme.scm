(define (pyc-scheme ast conf)
   (let* ((cnt (make-cell 0))
	  (caches (collect-caches ast cnt)))
      (PycModule-caches-set! ast (cell-ref cnt))
      (PycNode-%info-set! ast (scheme ast conf))
      ast))

(define (pyc-scheme-eval ast conf)
   (let ((def (PycNode-%info ast)))
      (when (>= (config-get conf 'verbose 0) 1)
	(newline (current-error-port)))
      ((eval def) (py-make-global) (py-make-caches (PycModule-caches ast)))))

(define (pyc-scheme-bigloo ast conf)
   (pp `(module ,(string->symbol (config-get conf 'src "__stdin"))
	   (import __py_object)
	   (import __py_hclass)
	   (import __py_iterator)
	   (main main)))
   (pp `(define (main argv)
	   (pyc (py-make-global) (py-make-caches ,(PycModule-caches ast)))))
   (pp `(define pyc ,(PycNode-%info ast))))

(define (pyc-scheme-gambit ast conf)
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

(define (scheme* nodes conf)
   (map (lambda (n) (scheme n conf)) nodes))

(define (scheme+ vals decls conf)
   (let loop ((vals vals)
	      (decls decls)
	      (conf conf)
	      (acc '()))
      (if (null? vals)
	  acc
	  (loop (cdr vals) (cdr decls) (cons (car decls) conf)
	     (cons (scheme (car vals) conf) acc)))))

(define-walk-method (scheme this::PycNode conf)
   (error "scheme" "Not implemented" (pyc->list this)))

(define-walk-method (scheme this::PycModule conf)
   (epairify this
      `(lambda (%global %caches)
	  ,@(scheme* (PycModule-stmts this) (PycModule-globals this)))))

(define-walk-method (scheme this::PycSeq conf)
   (epairify this
      `(begin ,@(scheme* (PycSeq-nodes this) conf))))

(define-walk-method (scheme this::PycBlock conf)
   (epairify this
      `(letrec* ,(map (lambda (decl)
			 `(,(scheme-decl decl conf)
			   ,(scheme (PycDeclInit-val decl) conf)))
		    (PycBlock-decls this))
	  ,(scheme (PycBlock-body this) conf))))

(define-walk-method (scheme this::PycReturn conf)
   (if (PycReturn-tail this)
       (scheme (PycReturn-val this) conf)
       (epairify this
	  `(return (scheme (PycReturn-val this) conf)))))

(define-walk-method (scheme this::PycReturnYield conf)
   (let ((kont (PycReturnYield-kont this))
	 (gen (PycReturnYield-generator this)))
      (epairify this
	 `(,(if gen 'py-generator-yield* 'py-generator-yield)
	   %gen ,(scheme (PycReturnYield-val this) conf)
	   ,(scheme kont conf)))))

(define-walk-method (scheme this::PycStmtExpr conf)
   (scheme (PycStmtExpr-expr this) conf))

(define (pyc-test this conf)
   (if (eq? (PycExpr-type this) 'bool)
       (scheme this conf)
       (epairify this
	  `(py-test ,(scheme this conf)))))

(define-walk-method (scheme this::PycWhile conf)

   (define (scheme-while this)
      (let ((loop (gensym '%while)))
	 (epairify this
	    (if (PycLoop-need-continue this)
		`(let ,loop ()
		      (bind-exit (%continue)
			 (when ,(pyc-test (PycWhile-test this) conf)
			    ,(scheme (PycLoop-body this) conf)
			    (,loop))))
		`(let ,loop ()
		      (when ,(pyc-test (PycWhile-test this) conf)
			 ,(scheme (PycLoop-body this) conf)
			 (,loop)))))))
   
   (cond
      ((PycLoop-need-break this)
       (epairify this
	  `(bind-exit (%break)
	      ,(scheme-while this)
	      ,@(if (isa? (PycLoop-else this) PycPass)
		    '()
		    (scheme (PycLoop-else this) conf)))))
      ((isa? (PycLoop-else this) PycPass)
       (scheme-while this))
      (else
       (epairify this
	  `(begin
	      ,(scheme-while this)
	      ,(scheme (PycLoop-else this) conf))))))

(define-walk-method (scheme this::PycFor conf)

   (define (scheme-for this)
      (let ((loop (gensym '%for))
	    (target (gensym '%target))
	    (iterable (gensym '%iterable))
	    (iterator (gensym '%iterator))
	    (next (gensym '%next)))
	 (epairify this
	    `(let* ((,iterable ,(scheme (PycFor-iter this) conf))
		    (,iterator (PyFunction-call1
				  (object-get ,iterable
				     (& "__iter__")
				     ,(scheme-cache (PycFor-cachei this)))
				  ,iterable))
		    (,next (object-get ,iterator (& "__next__")
			      ,(scheme-cache (PycFor-cachen this)))))
		(let ,loop ()
		     (let ((,target (py-for-next ,iterator ,next)))
			(unless (eq? ,target 'StopIteration)
			   ,(let ((assig (new-PycAssig (PycNode-loc this)
					    (PycFor-target this)
					    (new-PycPragma (PycNode-loc this) target))))
			       (scheme  assig conf))
			   ,(if (PycLoop-need-continue this)
				`(bind-exit (%continue)
				    ,(scheme (PycLoop-body this) conf))
				(scheme (PycLoop-body this) conf))
			   (,loop))))))))
   
   (cond
      ((PycLoop-need-break this)
       (epairify this
	  `(bind-exit (%break)
	      ,(scheme-for this)
	      ,@(if (isa? (PycLoop-else this) PycPass)
		    '()
		    (scheme (PycLoop-else this) conf)))))
      ((isa? (PycLoop-else this) PycPass)
       (scheme-for this))
      (else
       (epairify this
	  `(begin
	      ,(scheme-for this)
	      ,(scheme (PycLoop-else this) conf))))))

(define-walk-method (scheme this::PycIf conf)
   (epairify this
      `(if ,(pyc-test (PycIf-test this) conf)
	   ,(scheme (PycIf-then this) conf)
	   ,(scheme (PycIf-else this) conf))))

(define-walk-method (scheme this::PycWith conf)
   (epairify this
      `(py-with ,(scheme (PycWith-expr this) conf)
	  (lambda ()
	     ,(scheme (PycWith-body this) conf)))))

(define-walk-method (scheme this::PycTry conf)
   
   (define (scheme-try this conf)
      `(with-handler
	  (lambda (%exn)
	     (cond
		,@(map (lambda (h) (scheme h conf))
		   (PycTry-handlers this))))
	  ,(if (isa? (PycTry-else this) PycPass)
	       (scheme (PycTry-body this) conf)
	       `(begin
		   ,(scheme (PycTry-body this) conf)
		   ,(scheme (PycTry-else this) conf)))))
   
   (epairify this
      (if (isa? (PycTry-finally this) PycPass)
	  (scheme-try this conf)
	  `(unwind-protect
	      ,(scheme-try this conf)
	      ,(scheme (PycTry-finally this) conf)))))

(define-walk-method (scheme this::PycRaise conf)
   (epairify this
      `(py-throw ,(scheme (PycRaise-exc this) conf))))

(define-walk-method (scheme this::PycHandler conf)
   (epairify this
      `(,(if (isa? (PycHandler-type this) PycUninit)
	     #t
	     `(isa? %exn ,(scheme (PycHandler-type this) conf)))
	,(scheme (PycHandler-body this) conf))))
			
(define-walk-method (scheme this::PycPass conf)
   #f)

(define-walk-method (scheme this::PycBreak conf)
   (epairify this '(%break #f)))

(define-walk-method (scheme this::PycContinue conf)
   (epairify this '(%continue #f)))

(define (scheme-decl this conf)
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

(define-walk-method (scheme this::PycDecl conf)
   (scheme-decl this conf))

(define-walk-method (scheme this::PycDeclInit conf)
   (let ((val (scheme (PycDeclInit-val this) conf)))
      (epairify this
	 (if (eq? (PycDecl-scope this) 'local)
	     `(set! ,(scheme-decl this conf) ,val)
	     `(global-put! %global ,(pyc-propname (PycDecl-id this)) ,val
		 ,(scheme-cache (PycDeclInit-cache this)))))))

(define-walk-method (scheme this::PycAssig conf)
   (cond
      ((isa? (PycAssig-lhs this) PycRef)
       (let* ((ref (PycAssig-lhs this))
	      (decl (PycRef-decl ref))
	      (val (scheme (PycAssig-rhs this) conf)))
	  (epairify this
	     (case (PycDecl-scope decl)
		((global)
		 `(global-put! %global ,(pyc-propname (PycDecl-id decl)) ,val
		     ,(scheme-cache (PycRef-cache (PycAssig-lhs this)))))
		(else
		 `(set! ,(scheme-decl decl conf) ,val))))))
      ((isa? (PycAssig-lhs this) PycRefUnresolved)
       (let* ((ref (PycAssig-lhs this))
	      (val (scheme (PycAssig-rhs this) conf)))
	  (epairify this
	     `(global-put! %global ,(pyc-propname (PycRefUnresolved-id ref)) ,val
		 ,(scheme-cache (PycRefUnresolved-cache (PycAssig-lhs this)))))))
      ((isa? (PycAssig-lhs this) PycAccess)
       (let* ((axs (PycAssig-lhs this))
	      (obj (PycAccess-obj axs))
	      (field (PycAccess-field axs))
	      (val (scheme (PycAssig-rhs this) conf)))
	  (epairify this
	     `(object-put! ,(scheme obj conf) ,(pyc-propname field)
		 ,(scheme (PycAssig-rhs this) conf)
		 ,(scheme-cache (PycAccess-cache (PycAssig-lhs this)))))))
      (else
       (let* ((axs (PycAssig-lhs this))
	      (obj (PycSubscript-obj axs))
	      (index (PycSubscript-index axs))
	      (val (scheme (PycAssig-rhs this) conf)))
	  (epairify this
	     `(py-setitem! ,(scheme obj conf)
		 ,(scheme index conf)
		 ,(scheme (PycAssig-rhs this) conf)))))))

(define-walk-method (scheme this::PycAugAssig conf)
   (cond
      ((isa? (PycAssig-lhs this) PycRef)
       (let* ((loc (PycNode-loc this))
	      (lhs (PycAssig-lhs this))
	      (assig (new-PycAssig loc lhs
			(new-PycCall loc
			   (new-PycPragma loc `(& ,(PycAugAssig-op this)))
			   (list
			      lhs
			      (PycAssig-rhs this)
			      (new-PycPragma loc
				 (scheme-cache (PycAugAssig-cache this))))))))
	  (scheme assig conf)))
      ((isa? (PycAssig-lhs this) PycAccess)
       (let* ((loc (PycNode-loc this))
	      (%o (gensym '%o))
	      (lhs (PycAssig-lhs this))
	      (field (PycAccess-field lhs))
	      (assig (new-PycAssig loc
			(new-PycAccess loc (new-PycPragma loc %o) field
			   :cache (PycAccess-cache lhs))
			(new-PycCall loc
			   (new-PycPragma loc `(& ,(PycAugAssig-op this)))
			   (list
			      (new-PycAccess loc (new-PycPragma loc %o) field
				 :cache (PycAccess-cache lhs))
			      (PycAssig-rhs this)
			      (new-PycPragma loc
				 (scheme-cache (PycAugAssig-cache this))))))))
	  (epairify this
	     `(let ((,%o ,(scheme (PycAccess-obj lhs) conf)))
		 ,(scheme assig conf)))))
      (else
       (let* ((loc (PycNode-loc this))
	      (%o (gensym '%o))
	      (%i (gensym '%i))
	      (lhs (PycAssig-lhs this))
	      (obj (PycSubscript-obj lhs))
	      (index (PycSubscript-index lhs))
	      (assig (new-PycAssig loc
			(new-PycSubscript loc
			   (new-PycPragma loc %o) (new-PycPragma loc %i))
			(new-PycCall loc
			   (new-PycPragma loc `(& ,(PycAugAssig-op this)))
			   (list
			      (new-PycSubscript loc
				 (new-PycPragma loc %o) (new-PycPragma loc %i))
			      (PycAssig-rhs this)
			      (new-PycPragma loc
				 (scheme-cache (PycAugAssig-cache this))))))))
	  (epairify this
	     `(let* ((,%i ,(scheme (PycSubscript-index lhs) conf))
		     (,%o ,(scheme (PycSubscript-obj lhs) conf)))
		 ,(scheme assig conf)))))))

(define-walk-method (scheme this::PycPragma conf)
   (epairify this
      (PycPragma-expr this)))

(define-walk-method (scheme this::PycUninit conf)
   (epairify this
      '(py-uninit)))

(define-walk-method (scheme this::PycBool conf)
   (PycLiteralValue-val this))

(define-walk-method (scheme this::PycNumber conf)
   (PycLiteralValue-val this))

(define-walk-method (scheme this::PycString conf)
   (PycLiteralValue-val this))

(define-walk-method (scheme this::PycBinary conf)
   (epairify this
      `(,(string->symbol (string-append "py-" (PycBinary-op this)))
	,(scheme (PycBinary-lhs this) conf)
	,(scheme (PycBinary-rhs this) conf)
	,(scheme-cache (PycBinary-cache this)))))

(define-walk-method (scheme this::PycFun conf)
   
   (define (generator this::PycFun exp)
      (if (PycFun-generator this)
	  (epairify this
	     `(letrec ((%gen (py-make-generator (lambda (%v %e) ,exp))))
		 %gen))
	  exp))
   
   (let ((args (map (lambda (a) (scheme a conf)) (PycFun-args this)))
	 (body (scheme (PycFun-body this) conf)))
      (epairify this
	 `(make-PyFunction (PyFunction-default-hclass) '#()
	     ,(if (PycFun-need-return this)
		  `(lambda ,args ,(generator this `(bind-exit (return) ,body)))
		  `(lambda ,args ,(generator this body)))))))

(define-walk-method (scheme this::PycClass conf)

   (define (pyc-class this::PycClass)
      (epairify this
	 `(py-make-class
	     ,@(append-map (lambda (decl)
			      `((& ,(symbol->string (PycDecl-id decl)))
				,(scheme-decl decl conf)))
		  (PycClass-decls this)))))
				  
   (let ((body (scheme (PycClass-body this) conf)))
      (epairify this
	 (match-case body
	    ((letrec* ?bindings . ?body)
	     `(letrec* ,bindings ,@body ,(pyc-class this)))
	    (else
	     `(begin ,body ,(pyc-class this)))))))

(define-walk-method (scheme this::PycKont conf)
   (let ((param (scheme (PycKont-param this) conf))
	 (exn (scheme (PycKont-exn this) conf)))
      (epairify this
	 `(lambda (,param ,exn)
	     ,(scheme (PycKont-body this) conf)))))

(define-walk-method (scheme this::PycCall conf)
   
   (define (invoke fun args)
      (let ((call (case (length args)
		     ((0) 'PyFunction-call0)
		     ((1) 'PyFunction-call1)
		     ((2) 'PyFunction-call2)
		     ((3) 'PyFunction-call4)
		     (else (error "scheme" "Not implemented" (pyc->list this))))))
	 `(,call ,fun ,@args)))

   (let ((fun (PycCall-fun this)))
      (if (isa? fun PycAccess)
	  ;; method call
	  (let ((obj (gensym '%obj)))
	     (epairify this
		`(let ((,obj ,(scheme (PycAccess-obj fun) conf)))
		    ,(invoke `(object-get ,obj
				 ,(pyc-propname (PycAccess-field fun))
				 ,(scheme-cache (PycAccess-cache fun)))
			(cons obj
			   (map (lambda (a) (scheme a conf))
			      (PycCall-args this)))))))
	  ;; function call
	  (epairify this
	     (invoke (scheme fun conf)
		(map (lambda (a) (scheme a conf)) (PycCall-args this)))))))

(define-walk-method (scheme this::PycCollection conf)
   (epairify this
      `(,(if (isa? this PycList) 'py-make-list 'py-make-tuple)
	,@(map (lambda (e) (scheme e conf)) (PycList-elts this)))))

(define-walk-method (scheme this::PycRef conf)
   (let ((decl (PycRef-decl this)))
      (case (PycDecl-scope decl)
	 ((global)
	  (epairify this
	     `(global-get %global ,(pyc-propname (PycDecl-id decl))
		 ,(scheme-cache (PycRef-cache this)))))
	 (else
	  (scheme-decl decl conf)))))

(define-walk-method (scheme this::PycRefUnresolved conf)
   (epairify this
      `(global-get %global ,(pyc-propname (PycRefUnresolved-id this))
	  ,(scheme-cache (PycRefUnresolved-cache this)))))

(define-walk-method (scheme this::PycAccess conf)
   (epairify this
      `(object-get ,(scheme (PycAccess-obj this) conf)
	  ,(pyc-propname (PycAccess-field this))
	  ,(scheme-cache (PycAccess-cache this)))))

(define-walk-method (scheme this::PycSubscript conf)
   (epairify this
      `(py-getitem ,(scheme (PycSubscript-obj this) conf)
	  ,(scheme (PycSubscript-index this) conf))))

(define-walk-method (scheme this::PycSlice conf)
   (epairify this
      `(py-slice ,(scheme (PycSlice-obj this) conf)
	  ,(scheme (PycSlice-lower this) conf)
	  ,(scheme (PycSlice-upper this) conf)
	  ,(scheme (PycSlice-step this) conf))))

(define (scheme-cache cache)
   `(vector-ref %caches ,cache))

;; collect caches
(define-walk-method (collect-caches this::PycNode cnt)
   (call-default-walker))

(define-walk-method (collect-caches this::PycDeclInit cnt)
   (call-default-walker)
   (when (eq? (PycDecl-scope this) 'global)
      (let ((n (cell-ref cnt)))
	 (cell-set! cnt (+ 1 n))
	 (PycDeclInit-cache-set! this n))))
      
(define-walk-method (collect-caches this::PycRef cnt)
   (when (eq? (PycDecl-scope (PycRef-decl this)) 'global)
      (let ((n (cell-ref cnt)))
	 (cell-set! cnt (+ 1 n))
	 (PycRef-cache-set! this n))))

(define-walk-method (collect-caches this::PycBinary cnt)
   (let ((n (cell-ref cnt)))
      (cell-set! cnt (+ 1 n))
      (PycBinary-cache-set! this n)))

(define-walk-method (collect-caches this::PycRefUnresolved cnt)
   (let ((n (cell-ref cnt)))
      (cell-set! cnt (+ 1 n))
      (PycRefUnresolved-cache-set! this n)))

(define-walk-method (collect-caches this::PycAccess cnt)
   (call-default-walker)
   (let ((n (cell-ref cnt)))
      (cell-set! cnt (+ 1 n))
      (PycAccess-cache-set! this n)))

(define-walk-method (collect-caches this::PycAugAssig cnt)
   (call-default-walker)
   (let ((n (cell-ref cnt)))
      (cell-set! cnt (+ 1 n))
      (PycAugAssig-cache-set! this n)))

(define-walk-method (collect-caches this::PycFor cnt)
   (call-default-walker)
   (let ((n (cell-ref cnt)))
      (cell-set! cnt (+ 1 n))
      (let ((m (cell-ref cnt)))
	 (cell-set! cnt (+ 1 m))
	 (PycFor-cachei-set! this n)
	 (PycFor-cachen-set! this m))))
	  
   
