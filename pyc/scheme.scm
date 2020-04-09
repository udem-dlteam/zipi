(define (pyc-scheme ast conf)
   (let* ((cnt (make-cell 0))
	  (caches (collect-caches ast cnt)))
      (PycModule-caches-set! ast (cell-ref cnt))
      (list (scheme ast conf))))

(define (my-gensym sym)
    (let ((i gensym-count))
      (set! gensym-count (+ i 1))
      (string->symbol (string-append "$" (symbol->string sym) "_" (number->string i)))))
(define gensym-count 0)

;* (define (pyc-scheme-eval ast conf)                                  */
;*    (let ((def (PycNode-%info ast)))                                 */
;*       (when (>= (config-get conf 'verbose 0) 1)                     */
;* 	 (newline (current-error-port)))                               */
;*       ((eval def) (py-make-global) (py-make-caches (PycModule-caches ast))))) */

(define (pyc-scheme-bigloo ast conf)
   (let ((prog (pyc-scheme ast conf)))
      (list
	 `(module ,(string->symbol (or (config-get conf src:) "__stdin"))
	     (library zipi)
	     ,@(if (config-get conf main:) '((main main)) '()))
	 `(define py-module ,@prog)
	 (if (config-get conf main:)
	     `(define (main argv)
		 (py-module (py-make-global) (py-make-caches ,(PycModule-caches ast))))
	     `(lambda ()
		 (let ((global (py-make-global))
		       (caches (py-make-caches ,(PycModule-caches ast))))
		    (py-module global caches)
		    global))))))

(define (pyc-scheme-gambit ast conf)
  (let ((prog (pyc-scheme ast conf)))
      `(;;begin
	  ,@(if #t ;(config-get conf main:) ;; shouldn't this always be included?
		`((|##import| bigloo)
		  (|##include| ,(string-append (zipi-rts-dir) "/hclass.bgl"))
		  (|##include| ,(string-append (zipi-rts-dir) "/hclass.scm"))
		  (|##include| ,(string-append (zipi-rts-dir) "/object.bgl"))
		  (|##include| ,(string-append (zipi-rts-dir) "/object.scm"))
		  (|##include| ,(string-append (zipi-rts-dir) "/iterator.bgl"))
		  (|##include| ,(string-append (zipi-rts-dir) "/iterator.scm"))
		  (|##include| ,(string-append (zipi-rts-dir) "/import.bgl"))
		  (|##include| ,(string-append (zipi-rts-dir) "/import.scm"))
                  )
		'())
	  (define py-module ,@prog)
	  ,(if (config-get conf main:)
	       `(begin
     		    (define (main args)
    		      (py-module (py-make-global) (py-make-caches ,(PycModule-caches ast))))
       (with-handler
         (lambda (%exc)
          (if (PyObject? %exc)
            (print-exception %exc)
            (raise %exc)))
		   (main (command-line))))
	       `(lambda ()
		   (let ((global (py-make-global))
			 (caches (py-make-caches ,(PycModule-caches ast))))
		      (py-module global caches)
		      global))))))

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
	  (set! py-import-root ,(config-get conf dir:))
	  ,@(scheme* (PycModule-stmts this)
	       (cons* module: (PycModule-globals this) conf)))))

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
	      `(return ,(scheme (PycReturn-val this) conf)))))

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
   (epairify this
	  `(py-test ,(scheme this conf))))

(define-walk-method (scheme this::PycWhile conf)

   (define (scheme-while this)
      (let ((loop (my-gensym '%while)))
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
		    (list (scheme (PycLoop-else this) conf))))))
      ((isa? (PycLoop-else this) PycPass)
       (scheme-while this))
      (else
       (epairify this
	  `(begin
	      ,(scheme-while this)
	      ,(scheme (PycLoop-else this) conf))))))

(define-walk-method (scheme this::PycFor conf)

   (define (scheme-for this)
      (let ((loop (my-gensym '%for))
	    (target (my-gensym '%target))
	    (iterable (my-gensym '%iterable))
	    (iterator (my-gensym '%iterator)))
	 (epairify this
	    `(let* ((,iterable ,(scheme (PycFor-iter this) conf))
      		    (,iterator (py-iter ,iterable)))
		(let ,loop ()
        ;; TODO: there is definitely an optimisation to have here
        ;; cPython recovers __next__ everytime we loop, but if we are
        ;; assured that the __next__ method is never rassigned *anywhere* in
        ;; the mro, then we can get __next__ once at the start.
		     (let ((,target (py-for-next ,iterator)))
			(when ,target
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
		    (list (scheme (PycLoop-else this) conf))))))
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
	     `(py-isinstance? %exn ,(scheme (PycHandler-type this) conf)))
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
		 ,(scheme-cache (PycDeclInit-cache this) this))))))

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
		     ,(scheme-cache (PycRef-cache (PycAssig-lhs this))
			 (PycAssig-lhs this))))
		(else
		 `(set! ,(scheme-decl decl conf) ,val))))))
      ((isa? (PycAssig-lhs this) PycRefUnresolved)
       (let* ((ref (PycAssig-lhs this))
	      (val (scheme (PycAssig-rhs this) conf)))
	  (epairify this
	     `(global-put! %global ,(pyc-propname (PycRefUnresolved-id ref)) ,val
		 ,(scheme-cache (PycRefUnresolved-cache (PycAssig-lhs this))
		     (PycAssig-lhs this))))))
      ((isa? (PycAssig-lhs this) PycAccess)
       (let* ((axs (PycAssig-lhs this))
	      (obj (PycAccess-obj axs))
	      (field (PycAccess-field axs))
	      (val (scheme (PycAssig-rhs this) conf)))
	  (epairify this
	     `(object-put! ,(scheme obj conf) ,(pyc-propname field)
		 ,(scheme (PycAssig-rhs this) conf)
		 ,(scheme-cache (PycAccess-cache (PycAssig-lhs this))
		     (PycAssig-lhs this))))))
      (else
       (let* ((axs (PycAssig-lhs this))
	      (obj (PycSubscript-obj axs))
	      (index (PycSubscript-index axs))
	      (val (scheme (PycAssig-rhs this) conf)))
	  (epairify this
	     `(py-setitem ,(scheme obj conf)
		 ,(scheme index conf)
		 ,(scheme (PycAssig-rhs this) conf)
		 ,(scheme-cache (PycSubscript-cache axs) axs)))))))

(define-walk-method (scheme this::PycAugAssig conf)
   (cond
      ((isa? (PycAssig-lhs this) PycRef)
       (let* ((loc (PycNode-loc this))
	      (lhs (PycAssig-lhs this))
	      (assig (new-PycAssig loc lhs
			(new-PycCall loc
			   (new-PycPragma loc (symbol-append 'py- (PycAugAssig-op this)))
			   (list
			      lhs
			      (PycAssig-rhs this)
			      (new-PycPragma loc
				 (scheme-cache (PycAugAssig-cache this) this)))))))
	  (scheme assig conf)))
      ((isa? (PycAssig-lhs this) PycAccess)
       (let* ((loc (PycNode-loc this))
	      (%o (my-gensym '%o))
	      (lhs (PycAssig-lhs this))
	      (field (PycAccess-field lhs))
	      (assig (new-PycAssig loc
			(new-PycAccess loc (new-PycPragma loc %o) field
			   cache: (PycAccess-cache lhs))
			(new-PycCall loc
			   (new-PycPragma loc (symbol-append 'py- (PycAugAssig-op this)))
			   (list
			      (new-PycAccess loc (new-PycPragma loc %o) field
				 cache: (PycAccess-cache lhs))
			      (PycAssig-rhs this)
			      (new-PycPragma loc
				 (scheme-cache (PycAugAssig-cache this) this)))))))
	  (epairify this
	     `(let ((,%o ,(scheme (PycAccess-obj lhs) conf)))
		 ,(scheme assig conf)))))
      (else
       (let* ((loc (PycNode-loc this))
	      (%o (my-gensym '%o))
	      (%i (my-gensym '%i))
	      (lhs (PycAssig-lhs this))
	      (obj (PycSubscript-obj lhs))
	      (index (PycSubscript-index lhs))
	      (assig (new-PycAssig loc
			(new-PycSubscript loc
			   (new-PycPragma loc %o) (new-PycPragma loc %i)
			   cache: (PycSubscript-cache lhs))
			(new-PycCall loc
			   (new-PycPragma loc (symbol-append 'py- (PycAugAssig-op this)))
			   (list
			      (new-PycSubscript loc
				 (new-PycPragma loc %o) (new-PycPragma loc %i)
				 cache: (PycSubscript-cache lhs))
			      (PycAssig-rhs this)
			      (new-PycPragma loc
				 (scheme-cache (PycAugAssig-cache this) this)))))))
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
   (if (PycLiteralValue-val this)
    `py-True
    `py-False))

(define-walk-method (scheme this::PycNone conf)
  `py-None)

;; TODO: all values are stored as int, float and complex are untreated
(define-walk-method (scheme this::PycNumber conf)
   (epairify this
      `(py-int-from-scheme ,(PycLiteralValue-val this))))

(define-walk-method (scheme this::PycString conf)
   (epairify this
      `(py-str-from-scheme ,(PycLiteralValue-val this))))

(define-walk-method (scheme this::PycBinary conf)
   (epairify this
      `(,(symbol-append 'py- (PycBinary-op this))
	,(scheme (PycBinary-lhs this) conf)
	,(scheme (PycBinary-rhs this) conf)
	,(scheme-cache (PycBinary-cache this) this))))

(define-walk-method (scheme this::PycUnary conf)
   (epairify this
      `(,(symbol-append 'py- (PycUnary-op this))
	,(scheme (PycUnary-expr this) conf)
	,(scheme-cache (PycUnary-cache this) this))))

(define-walk-method (scheme this::PycFun conf)

   (define (generator this::PycFun exp)
      (if (PycFun-generator this)
	  (epairify this
	     `(letrec ((%gen (py-make-generator (lambda (%v %e) ,exp))))
		 %gen))
	  exp))

   (define (locals fun body)
      (if (PycFun-can-locals fun)
	  `(let ((%frame (make-cell #f))
		 (%names ',(map! PycDecl-id
			      (append (PycFun-args fun) (PycFun-decls fun)))))
	      ,body)
	  body))

   (define (signature fun conf)
    (let ((vararg (PycFun-vararg fun))
          (kwarg (PycFun-kwarg fun)))
      `(vector
        #(,@(map PycDecl-id (PycFun-args fun)))
        #(,@(map PycDecl-id (PycFun-posonlyargs fun)))
        ,(cond
            ((PycDecl? vararg) (PycDecl-id vararg))
            ((PycUninit? vararg) #f)
            (else (error "signature" "unknown value for vararg")))
        #(,@(map PycDecl-id (PycFun-kwonlyargs fun)))
        (vector ,@(scheme* (PycFun-kw-defaults fun) conf))
        ,(cond
            ((PycDecl? kwarg) (PycDecl-id kwarg))
            ((PycUninit? kwarg) #f)
            (else (error "signature" "unknown value for kwarg")))
        (vector ,@(scheme* (PycFun-defaults fun) conf)))))

   (let*
     ((vararg (PycFun-vararg this))
      (kwarg (PycFun-kwarg this))
      (args
       (scheme*
         (append
           (PycFun-posonlyargs this)
           (PycFun-args this)
           (if (PycDecl? vararg) (PycDecl-id (list vararg)) '())
           (PycFun-kwonlyargs this)
           (if (PycDecl? kwarg) (PycDecl-id (list kwarg)) '()))
           conf))
	    (body (locals this (scheme (PycFun-body this) (cons* fun: this conf)))))
      (epairify this
	 `(procedure->py-function
	     ,(if (PycFun-need-return this)
		  `(lambda ,args ,(generator this `(bind-exit (return) ,body)))
		  `(lambda ,args ,(generator this body)))
      ,(signature this conf)))))

(define-walk-method (scheme this::PycClass conf)
   (define (pyc-class this::PycClass)
     (let ((cls-symbol (PycClass-super-key this)))
      (epairify this
	 `(begin
     (set! ,cls-symbol (py-make-class
  	     (& ,(PycClass-name this))
  	     (& ,(PycClass-module this))
  	     (list ,@(map (lambda (b) (scheme b conf)) (PycClass-bases this)))
  	     ,@(append-map (lambda (decl)
  			      `((& ,(symbol->string (PycDecl-id decl)))
  				,(scheme-decl decl conf)))
  		  (PycClass-decls this))))
      ,cls-symbol))))

   (let ((body (scheme (PycClass-body this) conf)))
     (let ((cls-symbol (PycClass-super-key this)))
        (epairify this
      `(let (( ,cls-symbol (py-uninit)))
  	 ,(match-case body
  	    ((letrec* ?bindings . ?body)
  	     `(letrec* ,bindings ,@body ,(pyc-class this)))
  	    (else
  	     `(begin ,body ,(pyc-class this)))))))))

(define-walk-method (scheme this::PycKont conf)
   (let ((param (scheme (PycKont-param this) conf))
	 (exn (scheme (PycKont-exn this) conf)))
      (epairify this
	 `(lambda (,param ,exn)
	     ,(scheme (PycKont-body this) conf)))))

(define-walk-method (scheme this::PycCall conf)
;;   (define (invoke-maybe-locals fun)
;;      (let ((f (my-gensym '%f))
;;	    (caller (config-get conf fun:)))
;;	 `(let ((,f ,fun))
;;	     ,(if caller
;;		  `(if (eq? ,f py-builtin-locals)
;;		       (py-builtin-locals ,f %frame %names
;;			  (vector ,@(map (lambda (d)
;;					    (scheme-decl d conf))
;;				       (append (PycFun-args caller) (PycFun-decls caller)))))
;;		       (py-call0 ,f))
;;		  `(if (eq? ,f py-builtin-globals)
;;		       (py-builtin-globals)
;;		       (py-call0 ,f))))))

   ;; Catches the super-called-without-arguments to implicitly pass
   ;; arguments to a super() call
   (define (super-hook)
      (let* ((caller (config-get conf fun:))
            (caller-args (and caller (PycFun-args caller)))
            (class-key (and caller (PycFun-super-in-class caller))))
        (cond
          ((and caller class-key (> (length caller-args) 0))
           `(py-call py-builtin-super ,class-key
             ,(PycDecl-name (list-ref caller-args 0))))
          (else
           `(py-throw py-builtin-RuntimeError))
        )
      ))

   (define (super-handler call)
      (let ((caller (config-get conf fun:)))
        `(with-handler
          (lambda (%exn)
            (if (eq? %exn (flag-super-called-without-arguments))
              ,(super-hook)
              (raise %exn)))
          ,call)))

   (define (invoke fun args)
        (let* ((args-len (length args))
              (py-call-fun
                (if (<= args-len 5)
                  (string->symbol (string-append "py-call" (number->string args-len)))
                  'py-call))
              (call `(,py-call-fun ,fun ,@args)))
          (if (> (length args) 0) call
              (super-handler call))))

   (let ((fun (PycCall-fun this)))
      (cond
	 ((isa? fun PycPragma)
	  ;; builtin call
	  (epairify this
	     `(,(scheme fun conf)
	       ,@(map (lambda (a) (scheme a conf)) (PycCall-args this)))))
	 (else
	  ;; function call
	  (epairify this
	     (invoke (scheme fun conf)
		(map (lambda (a) (scheme a conf)) (PycCall-args this))))))))

(define-walk-method (scheme this::PycCollection conf)
   (epairify this
      `(,(cond
	    ((isa? this PycList) 'py-make-list)
	    ((isa? this PycTuple) 'py-make-tuple)
	    (else 'py-make-set))
	,@(map (lambda (e) (scheme e conf)) (PycCollection-elts this)))))

(define-walk-method (scheme this::PycDict conf)
   (epairify this
      `(py-make-dict
	  (list
	     ,@(map (lambda (e) (scheme e conf)) (PycDict-keys this)))
	  (list
	     ,@(map (lambda (e) (scheme e conf)) (PycCollection-elts this))))))

(define-walk-method (scheme this::PycImport conf)
   (epairify this
      `(py-import ,(PycImport-path this) ,(PycImport-depth this))))

(define-walk-method (scheme this::PycRef conf)
   (let ((decl (PycRef-decl this)))
      (case (PycDecl-scope decl)
	 ((global)
	  (epairify this
	     `(global-get %global ,(pyc-propname (PycDecl-id decl))
		 ,(scheme-cache (PycRef-cache this) this))))
	 (else
	  (scheme-decl decl conf)))))

(define-walk-method (scheme this::PycRefUnresolved conf)
   (epairify this
      `(global-get %global ,(pyc-propname (PycRefUnresolved-id this))
	  ,(scheme-cache (PycRefUnresolved-cache this) this))))

(define-walk-method (scheme this::PycDelete conf)
   (scheme
      (new-PycAssig (PycNode-loc this)
	 (PycDelete-expr this)
	 (new-PycUninit (PycNode-loc this)))
      conf))

(define-walk-method (scheme this::PycAccess conf)
   (epairify this
      `(object-get ,(scheme (PycAccess-obj this) conf)
	  ,(pyc-propname (PycAccess-field this))
	  ,(scheme-cache (PycAccess-cache this) this))))

(define-walk-method (scheme this::PycSubscript conf)
   (epairify this
      `(py-getitem ,(scheme (PycSubscript-obj this) conf)
	  ,(scheme (PycSubscript-index this) conf)
	  ,(scheme-cache (PycSubscript-cache this) this))))

(define-walk-method (scheme this::PycSlice conf)
   (epairify this
      `(py-slice ,(scheme (PycSlice-obj this) conf)
	  ,(scheme (PycSlice-lower this) conf)
	  ,(scheme (PycSlice-upper this) conf)
	  ,(scheme (PycSlice-step this) conf))))

(define-walk-method (scheme this::PycAssert conf)
   (let ((test (PycAssert-test this))
         (msg (PycAssert-msg this)))
      (epairify this
        (if (not (PycUninit? msg))
          `(if (not ,(pyc-test (PycAssert-test this) conf))
     	       (py-throw (py-call py-builtin-AssertionError
                      ,(scheme (PycAssert-msg this) conf))))
          `(if (not ,(pyc-test (PycAssert-test this) conf))
      	     (py-throw py-builtin-AssertionError))))))

(define (scheme-cache cache node)
   (if (not (integer? cache))
       (error "scheme-cache" "Bad cache" (pyc->list node))
       `(vector-ref %caches ,cache)))

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
   (call-default-walker)
   (let ((n (cell-ref cnt)))
      (cell-set! cnt (+ 1 n))
      (PycBinary-cache-set! this n)))

(define-walk-method (collect-caches this::PycUnary cnt)
   (call-default-walker)
   (let ((n (cell-ref cnt)))
      (cell-set! cnt (+ 1 n))
      (PycUnary-cache-set! this n)))

(define-walk-method (collect-caches this::PycRefUnresolved cnt)
   (let ((n (cell-ref cnt)))
      (cell-set! cnt (+ 1 n))
      (PycRefUnresolved-cache-set! this n)))

(define-walk-method (collect-caches this::PycAccess cnt)
   (call-default-walker)
   (let ((n (cell-ref cnt)))
      (cell-set! cnt (+ 1 n))
      (PycAccess-cache-set! this n)))

(define-walk-method (collect-caches this::PycSubscript cnt)
   (call-default-walker)
   (let ((n (cell-ref cnt)))
      (cell-set! cnt (+ 1 n))
      (PycSubscript-cache-set! this n)))

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
