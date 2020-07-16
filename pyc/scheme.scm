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
	     ,@(if (config-get conf bootstrap:)
		   '((import __py_rts) (export (zipi-init)))
		   '((library zipi)))
	     ,@(if (config-get conf main:) '((main main)) '()))
	 `(define py-module ,@prog)
	 (cond
	    ((config-get conf main:)
	     `(define (main argv)
		 (py-module
		    (py-make-global)
		    (py-make-caches ,(PycModule-caches ast)))))
	    ((config-get conf bootstrap:)
	     `(define (zipi-init)
		 (let ((global (py-make-global))
		       (caches (py-make-caches ,(PycModule-caches ast))))
		    (py-module global caches)
		    global)))
	    (else
	     `(lambda ()
		 (let ((global (py-make-global))
		       (caches (py-make-caches ,(PycModule-caches ast))))
		    (py-module global caches)
		    global)))))))

(define (pyc-scheme-gambit ast conf)
  (let* ((semantics (collect-semantics* ast conf)))
    (if (null? semantics)
      ;; normal compilation
      (let* ((prog (pyc-scheme ast conf))
            (file (config-get conf file:))
            (path (config-get conf dir:))
            (full-path (if (and file path) (make-file-path path file) #f)))
        (list `(define-library (,(string->symbol (config-get conf name:)))
                  (export init)
                  (import (gambit) (zipi rts))
                  (begin
                    (start-registering-constants)

                    (define py-module ,@prog)

                    (define (init name)
                      (init-registered-constants)
                      (let ((caches (py-make-caches ,(PycModule-caches ast)))
                            (module (py-make-module name)))
                        ,(if full-path
                          `(py-own-attr-set!
                            module (& "__file__") (&& ,full-path))
                          `,@(list))
                        (py-module module caches)
                        module))
                    (end-registering-constants)))))
      (let ((semantics-definitions (map cdr semantics)))
        (print
          port: (current-error-port)
          "Warning: compiling .py script with define_semantics will not generate an executable script")
        semantics-definitions
        ;;semantics-definitions
        ))))


(define-walk-method (collect-semantics* this::PycNode conf)
  (call-default-walker))

(define-walk-method (collect-semantics* this::PycFun conf)
  (if (PycFun-semantics this)
    (let* ((args (scheme* (PycFun-args this) conf))
          (need-return (PycFun-need-return this))
          (return-sym (if need-return (my-gensym '%return) #f))
          (body-conf
            (if need-return
              (cons* fun: this return: return-sym conf)
              (cons* fun: this conf)))
          (body (scheme (PycFun-body this) body-conf))
          (scheme-name (symbol-append 'py- (PycFun-name this))))
      (list
        (cons
          scheme-name
          `(define (,scheme-name ,@args) ,body))))
    (call-default-walker)))

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
  (let ((stmts (PycModule-stmts this)))
    (epairify this
      `(lambda (%global %caches)
        ,@(if (null? stmts)
          '(#f)
          (scheme* (PycModule-stmts this)
            (cons* module: (PycModule-globals this) conf)))))))

(define-walk-method (scheme this::PycSeq conf)
  (let ((nodes (PycSeq-nodes this)))
    ;; this condition is only for generated code readability, it makes no semantic difference
    (if (= (length nodes) 1)
      (scheme (car nodes) conf)
      (epairify this
        `(begin ,@(scheme* nodes conf))))))

(define-walk-method (scheme this::PycBlock conf)
  (let ((decls (PycBlock-decls this)))
    ;; this condition is only for generated code readability, it makes no semantic difference
    (if (null? decls)
      (scheme (PycBlock-body this) conf)
      (epairify this
        `(letrec* ,(map (lambda (decl)
        	 `(,(scheme-decl decl conf)
        	   ,(scheme (PycDeclInit-val decl) conf)))
            decls)
          ,(scheme (PycBlock-body this) conf))))))

(define-walk-method (scheme this::PycReturn conf)
   (if (PycReturn-tail this)
      (scheme (PycReturn-val this) conf)
      (let ((return-sym (config-get conf return:)))
        (epairify this
  	      `(,return-sym ,(scheme (PycReturn-val this) conf))))))

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
		     (let ((,target (py-next ,iterator)))
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
  (let ((test (PycIf-test this)))
    (if (and (PycBinary? test)
             (eq? (PycBinary-op test) 'is))
      ;; special case of is which is an eq?
      (epairify this
        `(if (eq? ,(scheme (PycBinary-lhs test) conf)
                  ,(scheme (PycBinary-rhs test) conf))
          ,(scheme (PycIf-then this) conf)
          ,(scheme (PycIf-else this) conf)))
      ;; general case
      (epairify this
        `(if ,(pyc-test (PycIf-test this) conf)
          ,(scheme (PycIf-then this) conf)
          ,(scheme (PycIf-else this) conf))))))

(define-walk-method (scheme this::PycWith conf)
  (define (in-contexts items body)
    (if (null? items)
      (scheme body conf)
      (let* ((item (car items))
             (context-expr (PycWithItem-context-expr item))
             (optional-vars (PycWithItem-optional-vars item))
             (ctx-sym (my-gensym '%with-ctx)))
        (cond
          ((PycUninit? optional-vars)
            `(let ((,ctx-sym ,(scheme context-expr conf)))
               (py-enter ,ctx-sym)
               (with-handler
                (lambda (%exn)
                  (if (PyObject? %exn)
                    (py-exit ,ctx-sym %exn)
                    (raise %exn)))
                ,(in-contexts (cdr items) body))
                (py-exit ,ctx-sym #f)))
          ((PycRefUnresolved? optional-vars)
            `(let ((,ctx-sym ,(scheme context-expr conf)))
               (global-put!
                 %global
                 ,(pyc-propname (PycRefUnresolved-id optional-vars))
                 (py-enter ,ctx-sym)
                 ,(scheme-cache
                   (PycRefUnresolved-cache optional-vars)
                   optional-vars))
               (with-handler
                (lambda (%exn)
                  (if (PyObject? %exn)
                    ;; it is the responsability of py-exit to re-raise the exc or not
                    (py-exit ,ctx-sym %exn)
                    (raise %exn)))
                ,(in-contexts (cdr items) body))
                (py-exit ,ctx-sym #f)))
          ((PycRef? optional-vars)
            (let ((decl (PycRef-decl optional-vars)))
              (if (eq? (PycDecl-scope decl) 'global)
                `(let ((,ctx-sym ,(scheme context-expr conf)))
                   (global-put!
                     %global
                     ,(pyc-propname (PycDecl-id decl))
                     (py-enter ,ctx-sym)
                     ,(scheme-cache
                       (PycRef-cache optional-vars)
                       optional-vars))
                   (with-handler
                    (lambda (%exn)
                      (if (PyObject? %exn)
                        ;; it is the responsability of py-exit to re-raise the exc or not
                        (py-exit ,ctx-sym %exn)
                        (raise %exn)))
                    ,(in-contexts (cdr items) body))
                    (py-exit ,ctx-sym #f))
                `(let ((,ctx-sym ,(scheme context-expr conf)))
                   (set! ,(scheme-decl decl conf) (py-enter ,ctx-sym))
                   (with-handler
                    (lambda (%exn)
                      (if (PyObject? %exn)
                        ;; it is the responsability of py-exit to re-raise the exc or not
                        (py-exit ,ctx-sym %exn)
                        (raise %exn)))
                    ,(in-contexts (cdr items) body))
                    (py-exit ,ctx-sym #f)))))
          (else
            (error "scheme::PycWith" "only supports assignation to variable" optional-vars))))))
  (in-contexts (PycWith-items this) (PycWith-body this)))

(define-walk-method (scheme this::PycTry conf)
  (let* ((body-block (PycTry-body this))
        (handlers (PycTry-handlers this))
        (else-block (PycTry-else this))
        (finally-block (PycTry-finally this))
        (current-exc-sym (my-gensym '%current-exc))
        (res-sym (my-gensym '%res))
        (conf-with-exc (cons* current-exc: current-exc-sym conf)))
    (if (PycPass? finally-block)
      ;; there is no finally block
      (if (PycPass? else-block)
        ;; optimized case for try-except simple blocks
        `(with-handler
          (lambda (,current-exc-sym)
            (cond
              ,@(map (lambda (h) (scheme h conf-with-exc)) handlers)
              (else (raise ,current-exc-sym))))
          ,(scheme body-block conf))
        ;; try-except-else
        `(let ((,current-exc-sym #f))
            (let ((,res-sym
                    (with-handler
                      (lambda (%exc)
                        (set! ,current-exc-sym %exc)
                        (cond
                          ,@(map (lambda (h) (scheme h conf-with-exc)) handlers)
                          (else (raise ,current-exc-sym))))
                      ,(scheme body-block conf))))
            (if (not ,current-exc-sym)
              ,(scheme else-block conf)
               ,res-sym))))
      ;; there is a finally block
      (let* ((return-sym (if (PycStmt-need-return this) (my-gensym '%return) #f))
            (body-conf (if return-sym (cons* return: return-sym conf) conf))
            (current-exc-sym (my-gensym '%current-exc))
            (handlers-exc-sym (my-gensym '%exc))
            (current-ret-sym (my-gensym '%current-ret))
            (finally-ret-sym (my-gensym '%finally-ret))
            (handled-flag-sym (my-gensym '%handled-an-exception))
            (handlers-conf (cons* current-exc: handlers-exc-sym body-conf)))
        (if return-sym
          ;; if there is a finally block all returns will be non-tail return
          ;; it is thus possible to catch them by specifying the bind-exit symbol
          ;; as return: attribute of the conf
          `(let* ((,handled-flag-sym #f)
                 (,current-exc-sym #f)
                 (,current-ret-sym
                  (with-handler
                    (lambda (%exc) (set! ,current-exc-sym %exc) #f)
                    (bind-exit
                      (,return-sym)
                      (begin
                        (with-handler
                          (lambda (,handlers-exc-sym)
                            (set! ,handled-flag-sym #t)
                            (cond
                              ,@(map (lambda (h) (scheme h handlers-conf)) handlers)
                              (else (set! ,current-exc-sym ,handlers-exc-sym))))
                          ,(scheme body-block body-conf))
                        (if (not ,handled-flag-sym)
                          ,(scheme else-block body-conf)
                           ,res-sym)
                        ;; return #f if the bind-exit was not exited through the continuation
                        ;; there can be no tail-return inside a try-except-else followed by a
                        ;; finally block
                        #f)))))
              ,(let* ((finally-conf
                      (if (PycStmt-need-return finally-block)
                        (cons* return: finally-ret-sym conf)
                        conf))
                    (finally-code
                      `(begin
                        ,(scheme finally-block finally-conf)
                        (cond
                          (,current-exc-sym
                            (raise ,current-exc-sym))
                          (,current-ret-sym
                            ,(if (PycTry-tail this)
                                current-ret-sym
                                `(,(config-get conf return:) ,current-ret-sym)))
                          (else #f)))))
              (if (PycStmt-need-return finally-block)
                `(bind-exit (,finally-ret-sym)
                    ,finally-code)
                 finally-code)))
          ;; if there is no return inside the try-except-else, there is no need
          ;; to rebind the return
          `(let ((,handled-flag-sym #f)
                 (,current-exc-sym #f))
            (with-handler
              (lambda (%exc) (set! ,current-exc-sym %exc))
                (begin
                  (with-handler
                    (lambda (,handlers-exc-sym)
                      (set! ,handled-flag-sym #t)
                      (cond
                        ,@(map (lambda (h) (scheme h handlers-conf)) handlers)
                        (else (set! ,current-exc-sym ,handlers-exc-sym))))
                    ,(scheme body-block body-conf))
                  (if (not ,handled-flag-sym)
                    ,(scheme else-block body-conf))
                  ;; return #f if the bind-exit was not exited through the continuation
                  ;; there can be no tail-return inside a try-except-else followed by a
                  ;; finally block
                  #f))
              ,(let* ((finally-conf
                      (if (PycStmt-need-return finally-block)
                        (cons* return: finally-ret-sym conf)
                        conf))
                    (finally-code
                      `(begin
                        ,(scheme finally-block finally-conf)
                        (if ,current-exc-sym
                            (raise ,current-exc-sym)))))
                (if (PycStmt-need-return finally-block)
                  `(bind-exit (,finally-ret-sym)
                      ,finally-code)
                   finally-code))))))))

(define-walk-method (scheme this::PycRaise conf)
  (let ((exc (PycRaise-exc this)))
    (if (PycUninit? exc)
      (epairify this
        `(py-throw ,(config-get conf current-exc:)))
      (epairify this
        `(py-throw ,(scheme exc conf))))))

(define-walk-method (scheme this::PycHandler conf)
   (epairify this
      `(,(if (isa? (PycHandler-type this) PycUninit)
	     #t
	     `(py-isinstance? ,(config-get conf current-exc:) ,(scheme (PycHandler-type this) conf)))
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
    ((isa? (PycAssig-lhs this) PycSlice)
      (let* ((axs (PycAssig-lhs this))
            (obj (PycSlice-obj axs))
            (lower (PycSlice-lower axs))
            (upper (PycSlice-upper axs))
            (step (PycSlice-step axs))
            (val (scheme (PycAssig-rhs this) conf)))
        (epairify this
          `(py-setitem
             ,(scheme obj conf)
             (py-slice-from-scheme
           	  ,(if (PycUninit? lower) 'py-None (scheme lower conf))
           	  ,(if (PycUninit? upper) 'py-None (scheme upper conf))
           	  ,(if (PycUninit? step) 'py-None (scheme step conf)))
             ,val
             #f))))
    ((isa? (PycAssig-lhs this) PycSubscript)
      (let* ((axs (PycAssig-lhs this))
            (obj (PycSubscript-obj axs))
            (index (PycSubscript-index axs))
            (val (scheme (PycAssig-rhs this) conf)))
      (epairify this
        `(py-setitem ,(scheme obj conf)
        ,(scheme index conf)
        ,(scheme (PycAssig-rhs this) conf)
        ,(scheme-cache (PycSubscript-cache axs) axs)))))
    ((isa? (PycAssig-lhs this) PycTuple)
      `(py-throw-exception-with-message
          py-builtin-NotImplementedError
            "multiple assignations unimplemented at line "
            ,(number->string (car (PycNode-loc this)))))
    (else
      (error "scheme:PycAssig" "unknown assignation type" this))))


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
      'py-absent))

(define-walk-method (scheme this::PycBool conf)
   (if (PycLiteralValue-val this)
    `py-True
    `py-False))

(define-walk-method (scheme this::PycNone conf)
  `py-None)

;; TODO: all values are stored as int, float and complex are untreated
(define-walk-method (scheme this::PycNumber conf)
   (if (flonum? (PycLiteralValue-val this))
      (epairify this
        `(py-float-from-scheme ,(PycLiteralValue-val this)))
   	  (epairify this
    	`(py-int-from-scheme ,(PycLiteralValue-val this)))))

(define-walk-method (scheme this::PycString conf)
   (epairify this
      `(&& ,(PycLiteralValue-val this))))

(define-walk-method (scheme this::PycBinary conf)
   (epairify this
      `(,(symbol-append 'py- (PycBinary-op this))
	,(scheme (PycBinary-lhs this) conf)
	,(scheme (PycBinary-rhs this) conf))))

(define-walk-method (scheme this::PycUnary conf)
   (epairify this
      `(,(symbol-append 'py- (PycUnary-op this))
	,(scheme (PycUnary-expr this) conf)
	,(scheme-cache (PycUnary-cache this) this))))

(define-walk-method (scheme this::PycBoolOp conf)
  (define (scheme-or args conf)
    (if (null? (cdr args))
      (scheme (car args) conf)
      (let ((sym (my-gensym 'or-arg)))
        `(let ((,sym ,(scheme (car args) conf)))
            (if (py-test ,sym)
              ,sym
              ,(scheme-or (cdr args) conf))))))

  (define (scheme-and args conf)
    (if (null? (cdr args))
      (scheme (car args) conf)
      (let ((sym (my-gensym 'or-arg)))
        `(let ((,sym ,(scheme (car args) conf)))
            (if (py-test ,sym)
              ,(scheme-and (cdr args) conf)
              ,sym)))))

  (let ((op (PycBoolOp-op this))
        (args (PycBoolOp-args this)))
    (case op
      ((or) (scheme-or args conf))
      ((and) (scheme-and args conf))
      (else (error "scheme::PycBoolOp" "unknown op" op)))))


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
        '#(,@(map PycDecl-id (PycFun-args fun)))
        '#(,@(map PycDecl-id (PycFun-posonlyargs fun)))
        ,(cond
            ((PycDecl? vararg) `(quote ,(PycDecl-id vararg)))
            ((PycUninit? vararg) #f)
            (else (error "signature" "unknown value for vararg" vararg)))
        '#(,@(map PycDecl-id (PycFun-kwonlyargs fun)))
        (vector ,@(scheme* (PycFun-kw-defaults fun) conf))
        ,(cond
            ((PycDecl? kwarg) `(quote ,(PycDecl-id kwarg)))
            ((PycUninit? kwarg) #f)
            (else (error "signature" "unknown value for kwarg" kwarg)))
        (vector ,@(scheme* (PycFun-defaults fun) conf)))))

    (define (apply-decorators fun conf)
        (let*
          ((vararg (PycFun-vararg this))
           (kwarg (PycFun-kwarg this))
           (args
            (scheme*
              (append
                (PycFun-posonlyargs this)
                (PycFun-args this)
                (if (PycDecl? vararg) (list vararg) '())
                (PycFun-kwonlyargs this)
                (if (PycDecl? kwarg) (list kwarg) '()))
                conf))
          (need-return (PycFun-need-return this))
          (return-sym (if need-return (my-gensym '%return) #f))
          (body-conf
            (if need-return
              (cons* fun: this return: return-sym conf)
              (cons* fun: this conf)))
     	    (body (locals this (scheme (PycFun-body this) body-conf)))
          (decs (PycFun-decorators fun)))
        (let loop ((decs decs))
          (if (null? decs)
            (epairify this
           	 `(procedure->py-function
           	     ,(if need-return
           		  `(lambda ,args ,(generator this `(bind-exit (,return-sym) ,body)))
           		  `(lambda ,args ,(generator this body)))
                 ,(signature this conf)))
            `(py-call ,(scheme (car decs) conf) ,(loop (cdr decs)))))))

   (apply-decorators this conf))

(define-walk-method (scheme this::PycClass conf)
   (define (pyc-class this::PycClass)
     (let ((cls-symbol (PycClass-super-key this)))
      (epairify this
	 `(begin
     (set! ,cls-symbol (py-make-class
  	     (&& ,(PycClass-name this))
  	     (&& ,(PycClass-module this))
  	     (list ,@(map (lambda (b) (scheme b conf)) (PycClass-bases this)))
  	     ,@(append-map (lambda (decl)
  			      `((& ,(symbol->string (PycDecl-id decl)))
  				,(scheme-decl decl conf)))
  		  (PycClass-decls this))))
      ,cls-symbol))))

   (let ((body (scheme (PycClass-body this) conf)))
     (let ((cls-symbol (PycClass-super-key this)))
        (epairify this
      `(let (( ,cls-symbol py-absent))
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
;;		       (py-call ,f))
;;		  `(if (eq? ,f py-builtin-globals)
;;		       (py-builtin-globals)
;;		       (py-call ,f))))))

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
            (if (eq? %exn (py-flag-super-called-without-arguments))
              ,(super-hook)
              (raise %exn)))
          ,call)))

   (define (invoke fun args)
        (let* ((call `(py-call ,fun ,@args)))
          (if (or (> (length args) 0) (not (PycCall-can-be-super this)))
              call
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
        ,@(map
            (lambda (k v) `(cons ,(scheme k conf) ,(scheme v conf)))
            (PycDict-keys this)
            (PycCollection-elts this))))))

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
  (let ((expr-to-delete (PycDelete-expr this)))
    (cond
      ((PycSubscript? expr-to-delete)
        `(py-delitem
            ,(scheme (PycSubscript-obj expr-to-delete) conf)
            ,(scheme (PycSubscript-index expr-to-delete) conf)
            #f))
      ((PycSlice? expr-to-delete)
        (let ((lower (PycSlice-lower expr-to-delete))
              (upper (PycSlice-upper expr-to-delete))
              (step (PycSlice-step expr-to-delete)))
          `(py-delitem
             ,(scheme (PycSlice-obj expr-to-delete) conf)
              (py-slice-from-scheme
            	  ,(if (PycUninit? lower) 'py-None (scheme lower conf))
            	  ,(if (PycUninit? upper) 'py-None (scheme upper conf))
            	  ,(if (PycUninit? step) 'py-None (scheme step conf)))
              #f)))
      (else
        (error "scheme::PycDelete" "only del subscript/slice are supported" #f)))))

(define-walk-method (scheme this::PycAccess conf)
  (epairify this
    `(py-getattribute ,(scheme (PycAccess-obj this) conf)
	  ,(pyc-propname (PycAccess-field this)))))

(define-walk-method (scheme this::PycSubscript conf)
   (epairify this
      `(py-getitem ,(scheme (PycSubscript-obj this) conf)
	  ,(scheme (PycSubscript-index this) conf)
	  ,(scheme-cache (PycSubscript-cache this) this))))

(define-walk-method (scheme this::PycSlice conf)
  (let ((lower (PycSlice-lower this))
        (upper (PycSlice-upper this))
        (step (PycSlice-step this)))
   (epairify this
     `(py-getitem
        ,(scheme (PycSlice-obj this) conf)
        (py-slice-from-scheme
      	  ,(if (PycUninit? lower) 'py-None (scheme lower conf))
      	  ,(if (PycUninit? upper) 'py-None (scheme upper conf))
      	  ,(if (PycUninit? step) 'py-None (scheme step conf)))
        #f))))

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

(define-walk-method (scheme this::PycIfExp conf)
  `(if (py-test ,(scheme (PycIfExp-test this) conf))
       ,(scheme (PycIfExp-body this) conf)
       ,(scheme (PycIfExp-orelse this) conf)))

(define-walk-method (scheme this::PycUnimplemented conf)
  `(py-throw-exception-with-message
      py-builtin-NotImplementedError
        ,(PycUnimplemented-msg this)
        " at line "
        ,(number->string (car (PycNode-loc this)))))

(define-walk-method (scheme this::PycStatic conf)
  (PycStatic-value this))

(define-walk-method (scheme this::PycMacro conf)
  (let* ((id (PycIntrinsics-id this))
        (value (PycMacro-value this))
        (args (PycMacro-args this)))
    `(,value ,@(scheme* args conf))))

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
