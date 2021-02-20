
(define (pyc-scheme ast conf)
   (pyc-cache! ast conf)
   (scheme ast conf))

(define (pyc-cache! ast conf)
   (let* ((cnt (make-cell 0))
	  (caches (collect-caches ast cnt)))
      (PycModule-caches-set! ast (cell-ref cnt))))

(define (declaration->define sexp)
   (match-case sexp
      ((define (?- . ?-) . ?-) sexp)
      ((define ?id ?expr) `(define ,id #f))
      (else #f)))

(define (declaration->expression sexp)
   (match-case sexp
      ((define (?- . ?-) . ?-) #f)
      ((define ?id ?expr) `(set! ,id ,expr))
      (else sexp)))

(define (pyc-scheme-bigloo ast conf)
   (pyc-cache! ast conf)
   (let* ((tlfuns (if (config-get conf optim-toplevel-module:)
		      (collect-tl-funs* ast conf)
		      '()))
	  (tldecls (if (config-get conf optim-toplevel-module:)
		       (scheme-tl* ast conf)
		       '()))
	  (prog (scheme ast conf))
	  (file (config-get conf file:))
	  (path (config-get conf dir:))
	  (globals (if (config-get conf optim-globals:)
		       (collect-globals* ast)
		       '()))
	  (full-path (if (and file path) (make-file-path path file) #f)))
      `((module ,(string->symbol
		    (or (config-get conf module-name:)
			(config-get conf src:)
			"__stdin"))
	   ,@(if (config-get conf bootstrap:)
		 '((import __py_rts
		      __py_bigloo
		      __stdlib_zemantics
		      __stdlib_behaviors)
		   (include "rts-macros.scm"
		      "bigloo/call.sch"
		      "bigloo/constants.sch"))
		 '((library zipi)))
	   ,@(if (config-get conf main:)
		 '((main main))
		 '((export (zipi-init ::bstring)))))
	(start-registering-constants)
	,@(if (config-get conf optim-toplevel-module:)
	      `((define %global |#unspecified|)
		(define %caches |#unspecified|)
		,@(map (lambda (d)
			  `(define ,(scheme-decl-optim-global-name-init d conf) #f))
		     tlfuns)
		,@tldecls)
	      '())
	,@(if (config-get conf optim-toplevel-module:)
	      (filter-map declaration->define prog)
	      '())
	,(if (config-get conf optim-toplevel-module:)
	     `(define (py-module global caches)
		 (set! %global global)
		 (set! %caches caches)
		 ,@(filter-map declaration->expression prog))
	     `(define py-module ,prog))
	,(cond
	    ((config-get conf main:)
	     `(define (main argv)
		 (bigloo-library-path-set!
		    (cons ,(config-get conf lib-dir:) (bigloo-library-path)))
		 (build-builtins)
		 (init-registered-constants)
		 (with-handler
		    (lambda (e)
		       (if (PyObject? e)
			   (exception-notify e)
			   (raise e)))
		    (py-module
		       (py-make-global)
		       (py-make-caches ,(PycModule-caches ast))))))
	    (else
	     `(define (zipi-init name)
		 (init-registered-constants)
		 (let ((caches (py-make-caches ,(PycModule-caches ast)))
		       (module (py-make-module (py-str-from-scheme name))))
		    ,@(if full-path
			  `((py-own-attr-set!
			       module (& "__file__") (& ,full-path)))
			  '())
		    (py-module module caches)
		    module))))
	(end-registering-constants))))

(define (sort-semantics semantics)
  (define (only form)
    (let loop ((s semantics))
      (cond
        ((null? s) '())
        ((eq? (cadar s) form) (cons (car s) (loop (cdr s))))
        (else (loop (cdr s))))))

  (append (only 'define-macro) (only 'define)))

(define (pyc-scheme-gambit ast conf)
  (define (scheme-init-globals declinits)
    (map
      (lambda (declinit)
        `(define ,(scheme-decl-optim-global-name declinit conf) py-absent))
      declinits))

  (define (scheme-register-globals declinits)
    (map
      (lambda (declinit)
        `(global-register!
          %global
          ,(pyc-propname (PycDecl-id declinit))
          (lambda () ,(scheme-decl-optim-global-name declinit conf))
          (lambda (v)
            (set! ,(scheme-decl-optim-global-name declinit conf) v))))
      declinits))

  (pyc-cache! ast conf)

  (let* ((semantics (sort-semantics (collect-semantics* ast conf))))
    (if (null? semantics)
      ;; normal compilation
      (let* ((file (config-get conf file:))
            (path (config-get conf dir:))
            (tlfuns (if (config-get conf optim-toplevel-module:)
         		      (collect-tl-funs* ast conf)
         		      '()))
         	  (tldecls
              (if (config-get conf optim-toplevel-module:)
                (scheme-tl* ast conf)
                '()))
            (globals (if (config-get conf optim-globals:)
        		       (collect-globals* ast)
        		       '()))
            (prog (scheme ast conf))
            (full-path (if (and file path) (make-file-path path file) #f)))
        (list `(define-library (,(string->symbol (config-get conf name:)))
                  (export init)
                  (import (gambit) (zipi rts))
                  (begin
                    (py-begin-module)

                    ,@(if (config-get conf optim-toplevel-module:)
                      `((define %global #f)
                        (define %caches #f)
                        ,@(map (lambda (d)
                        `(define ,(scheme-decl-optim-global-name-init d conf) #f))
                        tlfuns)
                        ,@tldecls
                        ,@(filter-map declaration->define prog)
                        ,@(scheme-init-globals globals))
                      '())

                    ,(if (config-get conf optim-toplevel-module:)
                      `(define (py-module global caches)
                        (set! %global global)
                        (set! %caches caches)
                        ,@(scheme-register-globals globals)
                        ,@(filter-map declaration->expression prog))
                         `(define py-module ,prog))

                    (define (init name)
                      (py-init-module)
                      (let ((caches (py-make-caches ,(PycModule-caches ast)))
                            (module (py-make-module name)))
                        ,(if full-path
                          `(py-own-attr-set!
                            module (& "__file__") (&& ,full-path))
                          `(begin))
                        (py-module module caches)
                        module))
                    (py-end-module)))))
      (let ((semantics-definitions (map cdr semantics)))
        (print
          port: (current-error-port)
          "Warning: compiling .py script with define_semantics will not generate an executable script")
        semantics-definitions
        ;;semantics-definitions
        ))))


(define-walk-method (collect-semantics* this::PycNode conf)
  (call-default-walker))

(define-walk-method (collect-semantics* this::PycSemantics conf)
  (let* ((args (scheme* (PycFun-args this) conf))
        (need-return (PycFun-need-return this))
        (return-sym (if need-return (my-gensym '%return) #f))
        (body-conf
          (if need-return
            (cons* fun: this return: return-sym conf)
            (cons* fun: this conf)))
        (body (scheme (PycFun-body this) body-conf))
        (scheme-name (PycFun-name this)))
    (list
      (cons
        scheme-name
        (if (PycSemantics-inline this)
          (if (PycSemantics-inline-as-is this)
            (list 'define-macro (cons scheme-name args)
                (list 'quasiquote body))
            (list 'define-macro (cons scheme-name args)
                (list 'quasiquote
                (list 'let (map (lambda (name) (list name (list 'unquote name))) args)
                body))))
          `(define (,scheme-name ,@args) ,body))))))

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
   (let* ((stmts (PycModule-stmts this))
	  (sexps (scheme* (PycModule-stmts this)
		    (cons* module: (PycModule-globals this) conf))))
      (if (config-get conf optim-toplevel-module:)
	  sexps
	  (epairify this
	     `(lambda (%global %caches)
		 ,@(if (null? stmts)
		       '(#f)
		       sexps))))))

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
  (epairify this
    `(if ,(pyc-test (PycIf-test this) conf)
      ,(scheme (PycIf-then this) conf)
      ,(scheme (PycIf-else this) conf))))

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
                (py-exit ,ctx-sym py-None)))
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
                (py-exit ,ctx-sym py-None)))
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
                    (py-exit ,ctx-sym py-None))
                `(let ((,ctx-sym ,(scheme context-expr conf)))
                   (set! ,(scheme-decl decl conf) (py-enter ,ctx-sym))
                   (with-handler
                    (lambda (%exn)
                      (if (PyObject? %exn)
                        ;; it is the responsability of py-exit to re-raise the exc or not
                        (py-exit ,ctx-sym %exn)
                        (raise %exn)))
                    ,(in-contexts (cdr items) body))
                    (py-exit ,ctx-sym py-None)))))
          (else
            (error "scheme::PycWith" "only supports assignation to variable" optional-vars))))))
  (in-contexts (PycWith-items this) (PycWith-body this)))

(define-walk-method (scheme this::PycTry conf)
  (let* ((body-block (PycTry-body this))
        (handlers (PycTry-handlers this))
        (handlers-exc-sym (PycTry-exc-sym this))
        (else-block (PycTry-else this))
        (finally-block (PycTry-finally this))
        (res-sym (my-gensym '%res))
        (conf-with-exc (cons* current-exc: handlers-exc-sym conf)))
    (if (PycPass? finally-block)
      ;; there is no finally block
      (if (PycPass? else-block)
        ;; optimized case for try-except simple blocks
        `(with-handler
          (lambda (,handlers-exc-sym)
            (cond
              ,@(map (lambda (h) (scheme h conf-with-exc)) handlers)
              (else (raise ,handlers-exc-sym))))
          ,(scheme body-block conf))
        ;; try-except-else
        `(let ((,handlers-exc-sym #f))
            (let ((,res-sym
                    (with-handler
                      (lambda (%exc)
                        (set! ,handlers-exc-sym %exc)
                        (cond
                          ,@(map (lambda (h) (scheme h conf-with-exc)) handlers)
                          (else (raise ,handlers-exc-sym))))
                      ,(scheme body-block conf))))
            (if (not ,handlers-exc-sym)
              ,(scheme else-block conf)
               ,res-sym))))
      ;; there is a finally block
      (let* ((return-sym (if (PycStmt-need-return this) (my-gensym '%return) #f))
            (body-conf (if return-sym (cons* return: return-sym conf) conf))
            (current-exc-sym (my-gensym '%current-exc))
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
	    '-
	    (string->symbol (number->string (PycDecl-key this))))))
   (PycDecl-name this))

(define (scheme-decl-optim-global-name this conf)
   (let ((scheme-name (scheme-decl this conf)))
      (symbol-append '@ scheme-name)))

(define (scheme-decl-optim-global-name-init this conf)
   (symbol-append (scheme-decl-optim-global-name this conf) '-init))

(define (scheme-decl-function-name this conf)
   (let ((scheme-name (scheme-decl this conf)))
      (symbol-append '& scheme-name)))

(define (scheme-ref-global this conf)

   (define (ref decl)
      (scheme-decl-optim-global-name decl conf)
      `(global-get %global ,(pyc-propname (PycDecl-id decl))
	       ,(scheme-cache (PycRef-cache this) this)))

   (let ((decl (PycRef-decl this)))
      (if (config-get conf optim-globals:)
    ;; TODO: this could be changed to using #f, but will require some reengineering of the rts attribute access
	  `(if (not (eq? ,(scheme-decl-optim-global-name decl conf) py-absent))
         ,(scheme-decl-optim-global-name decl conf)
	       ,(ref decl))
	  (ref decl))))

(define (scheme-declinit-global this val conf)

  (define (declinit-default decl)
    `(global-put! %global ,(pyc-propname (PycDecl-id this)) ,val
    ,(scheme-cache (PycDeclInit-cache this) this)))

  (define (declinit-optim decl)
    (or
      (and (PycFun? (PycDeclInit-val decl))
           (optimize-fun-decl? decl (PycDeclInit-val decl))
           (global-init-fun-value decl))
      `(set! ,(scheme-decl-optim-global-name this conf) ,val)))

  (define (global-init-fun-value this)
    (let ((fun (PycDeclInit-val this)))
      (if (PycFun-&proc fun)
        ;; a toplevel function
        (let ((glo-name (scheme-decl-optim-global-name this conf))
              (init-name (scheme-decl-optim-global-name-init this conf)))
          `(begin
            (set! ,glo-name ,val)
            (set! ,init-name ,glo-name)))
        #f)))

  (if (config-get conf optim-globals:)
    (declinit-optim this)
    (declinit-default this)))

(define (scheme-assig-global this ref decl val conf)

   (define (assig val)
      `(global-put! %global ,(pyc-propname (PycDecl-id decl)) ,val
	  ,(scheme-cache (PycRef-cache (PycAssig-lhs this))
	      (PycAssig-lhs this))))

   (if (config-get conf optim-globals:)
       (let ((tmp (gensym '%tmp))
	     (id (scheme-decl-optim-global-name decl conf)))
	  `(set! ,id ,val))
       (assig val)))

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
	     (scheme-declinit-global this val conf)))))

(define-walk-method (scheme this::PycAssig conf)
   (cond
      ((isa? (PycAssig-lhs this) PycRef)
       (let* ((ref (PycAssig-lhs this))
	      (decl (PycRef-decl ref))
	      (val (scheme (PycAssig-rhs this) conf)))
	  (epairify this
	     (case (PycDecl-scope decl)
		((global)
		 (scheme-assig-global this ref decl val conf))
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
	     `(py-setattribute ,(scheme obj conf) ,(pyc-propname field)
		 ,(scheme (PycAssig-rhs this) conf)))))
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
		 ,val))))
      ((isa? (PycAssig-lhs this) PycSubscript)
       (let* ((axs (PycAssig-lhs this))
	      (obj (PycSubscript-obj axs))
	      (index (PycSubscript-index axs))
	      (val (scheme (PycAssig-rhs this) conf)))
	  (epairify this
	     `(py-setitem ,(scheme obj conf)
		 ,(scheme index conf)
		 ,(scheme (PycAssig-rhs this) conf)))))
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
			      (PycAssig-rhs this))))))
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
			      (PycAssig-rhs this))))))
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
			      (PycAssig-rhs this))))))
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

(define (dispatch-native-bin-operator op)
  (define ops
    `((add . py+)
      (bitand . py&)
      (bitor . py+b) ;; TODO replace by |py\|| once supported by bigloo
      (floordiv . py//)
      (lshift . py<<)
      (mod . py%)
      (mul . py*)
      (pow . py**)
      (rshift . py>>)
      (sub . py-)
      (truediv . py/)
      (xor . py^)
      ;; inplace
      (iadd . py+)
      (ibitand . py&)
      (ibitor . py+b) ;; TODO replace by |py\|| once supported by bigloo
      (ifloordiv . py//)
      (ilshift . py<<)
      (imod . py%)
      (imul . py*)
      (ipow . py**)
      (irshift . py>>)
      (isub . py-)
      (itruediv . py/)
      (ixor . py^)))
  (let ((res (assq op ops)))
    (and res (cdr res))))

(define (dispatch-native-cmp-operator op)
  (define ops
    `((eq . py==)
      (ne . py!=)
      (ge . py>=)
      (gt . py>)
      (le . py<=)
      (lt . py<)))
  (let ((res (assq op ops)))
    (and res (cdr res))))

(define (dispatch-native-un-operator op)
  (define ops
    `((pos . pypos)
      (neg . pyneg)
      (invert . pyinvert)))
  (let ((res (assq op ops)))
    (and res (cdr res))))

(define-walk-method (scheme this::PycBinary conf)
  (define native-types '(Uint Usint Ubint Ufloat Ubool Ustr))

  (define (python-op)
    (epairify this
      `(,(symbol-append 'py- (PycBinary-op this))
        ,(scheme (PycBinary-lhs this) conf)
        ,(scheme (PycBinary-rhs this) conf))))

  (define (scheme-op)
    (epairify this
      (let ((op (dispatch-native-bin-operator (PycBinary-op this))))
        (if op
          `(,op
            ,(scheme (PycBinary-lhs this) conf)
            ,(scheme (PycBinary-rhs this) conf))
          `(py-test-from-scheme
              (,(dispatch-native-cmp-operator (PycBinary-op this))
              ,(scheme (PycBinary-lhs this) conf)
              ,(scheme (PycBinary-rhs this) conf)))))))

  (let ((lhs-type-hint (PycBinary-lhs-type-hint this))
        (rhs-type-hint (PycBinary-rhs-type-hint this)))
    (if (and lhs-type-hint (memq lhs-type-hint native-types))
      (if (and rhs-type-hint (memq rhs-type-hint native-types))
        (scheme-op)
        (error "scheme::PycBinary" "operation between lhs native type and non-native type" rhs-type-hint))
      (if (and rhs-type-hint (memq rhs-type-hint native-types))
        (error "scheme::PycBinary" "operation between rhs native type and non-native type" lhs-type-hint)
        (python-op)))))

(define-walk-method (scheme this::PycUnary conf)
  (define native-types '(Uint Usint Ubint Ufloat Ubool Ustr))

  (define (python-op)
    (epairify this
      `(,(symbol-append 'py- (PycUnary-op this))
        ,(scheme (PycUnary-expr this) conf))))

  (define (scheme-op)
    (epairify this
      (let ((op (dispatch-native-un-operator (PycUnary-op this))))
        `(,op
          ,(scheme (PycUnary-expr this) conf)))))

  (let ((type-hint (PycUnary-type-hint this)))
    (if (and type-hint (memq type-hint native-types))
      (scheme-op)
      (python-op))))

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

   (define (signature fun conf)
      (let ((args (PycFun-args fun))
	    (posonlyargs (PycFun-posonlyargs fun))
	    (vararg (PycFun-vararg fun))
	    (kwonlyargs (PycFun-kwonlyargs fun))
	    (kw-defaults (PycFun-kw-defaults fun))
	    (kwarg (PycFun-kwarg fun))
	    (defaults (PycFun-defaults fun)))
	 `(make-signature
	     ,@(append
		  (if (null? args)
		      '()
		      `(args: ,(map PycDecl-id args)))
		  (if (null? posonlyargs)
		      '()
		      `(posonlyargs: ,(map PycDecl-id posonlyargs)))
		  (cond
		     ((PycDecl? vararg)
		      `(vararg: ,(PycDecl-id vararg)))
		     ((PycUninit? vararg)
		      '())
		     (else
		      (error "signature" "unknown value for vararg" vararg)))
		  (if (null? kwonlyargs)
		      '()
		      `(kwonlyargs: ,(map PycDecl-id kwonlyargs)))
		  (if (null? kw-defaults)
		      '()
		      `(kw-defaults: (vector ,@(scheme* kw-defaults conf))))
		  (cond
		     ((PycDecl? kwarg)
		      `(kwarg: ,(PycDecl-id kwarg)))
		     ((PycUninit? kwarg)
		      '())
		     (else (error "signature" "unknown value for kwarg" kwarg)))
		  (if (null? defaults)
		      '()
		      `(defaults: (vector ,@(scheme* defaults conf))))))))

   (let loop ((decs (PycFun-decorators this)))
      (if (null? decs)
	  (epairify this
	     `(procedure->py-function
		 ,(or (PycFun-&proc this)
		      (scheme-procedure-proc this conf))
		 ,(signature this conf)))
	  `(py-call ,(scheme (car decs) conf) ,(loop (cdr decs))))))

(define (scheme-procedure-proc this conf)

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

   (let* ((vararg (PycFun-vararg this))
	  (kwarg (PycFun-kwarg this))
	  (args (scheme*
		   (append
		      (PycFun-posonlyargs this)
		      (PycFun-args this)
		      (if (PycDecl? vararg) (list vararg) '())
		      (PycFun-kwonlyargs this)
		      (if (PycDecl? kwarg) (list kwarg) '()))
		   conf))
	  (need-return (PycFun-need-return this))
	  (return-sym (if need-return (my-gensym '%return) #f))
	  (body-conf (if need-return
			 (cons* fun: this return: return-sym conf)
			 (cons* fun: this conf)))
	  (body (locals this (scheme (PycFun-body this) body-conf))))
      (if need-return
	  `(lambda ,args
	      ,(generator this `(bind-exit (,return-sym) ,body)))
	  `(lambda ,args
	      ,(generator this body)))))

(define-walk-method (scheme this::PycClass conf)
   (define (make-HClass-name name)
      (string->symbol (string-append "py-" name "-hclass-of-instances")))

   (define (pyc-class this::PycClass)
     (let ((cls-symbol (PycClass-super-key this))
           (is-builtin (PycClass-is-builtin this)))
      (epairify this
	 `(begin
     ,(if is-builtin
       `(set! ,cls-symbol (py-make-builtin-class
    	     (&& ,(PycClass-name this))
    	     (&& ,(PycClass-module this))
    	     (list ,@(map (lambda (b) (scheme b conf)) (PycClass-bases this)))
           ,(make-HClass-name (PycClass-name this))
    	     ,@(append-map (lambda (decl)
    			      `((& ,(symbol->string (PycDecl-id decl)))
    				,(scheme-decl decl conf)))
    		  (PycClass-decls this))))
       `(set! ,cls-symbol (py-make-class
    	     (&& ,(PycClass-name this))
    	     (&& ,(PycClass-module this))
    	     (list ,@(map (lambda (b) (scheme b conf)) (PycClass-bases this)))
    	     ,@(append-map (lambda (decl)
    			      `((& ,(symbol->string (PycDecl-id decl)))
    				,(scheme-decl decl conf)))
    		  (PycClass-decls this)))))
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

   (define (correct-arity? fun args)
      (=fx (length (PycFun-args fun)) (length args)))

   (define (invoke-global fun args)
    (let ((f (PycCall-fun this)))
      (cond
        ((PycRef? f)
          (let ((decl (PycRef-decl f)))
             (if (PycDeclInit? decl)
              (let ((val (PycDeclInit-val decl)))
               (if (and (PycFun? val)
                          (symbol? (PycFun-&proc val))
                          (correct-arity? val args))
                `(py-global-call
                    %global
                    ,(PycFun-&proc val)
                    ,(scheme-decl-optim-global-name decl conf)
                    ,(scheme-decl-optim-global-name-init decl conf)
                    (& ,(symbol->string (PycDecl-id decl)))
                    ,(scheme-cache (PycRef-cache f) this)
                    ,@args)
              #f))
            #f)))
        ((PycRefUnresolved? f) #f) ;; TODO: apply optimisation for top-level calls
        (else #f))))

   (define (invoke fun args)
      (if (or (> (length args) 0) (not (PycCall-can-be-super this)))
	  (or (invoke-global fun args)
	      `(py-call ,fun ,@args))
	  (let* ((caller (config-get conf fun:))
		 (caller-args (and caller (PycFun-args caller)))
		 (class-key (and caller (PycFun-super-in-class caller)))
		 (super-instance (if (and caller-args (> (length caller-args) 0))
				     (PycDecl-name (list-ref caller-args 0))
				     #f)))
	     `(py-call0-maybe-super ,fun ,class-key ,super-instance))))

   (define (gen-args call conf)
      (append
	 (let loop ((args (PycCall-args call)) (acc '()))
	    (cond
	       ((null? args)
		(reverse acc))
	       ((PycStarredExpr? (car args))
		(loop
		   (cdr args)
		   (cons
		      (scheme (PycStarredExpr-expr (car args)) conf)
		      (cons *: acc))))
	       (else
		(loop (cdr args) (cons (scheme (car args) conf) acc)))))
	 (let loop ((kwargs (PycCall-keywords-values this))
		    (names (PycCall-keywords-names this))
		    (acc '()))
	    (cond
	       ((null? names)
		(reverse acc))
	       ((car names)
		(loop
		   (cdr kwargs)
		   (cdr names)
		   (cons
		      (scheme (car kwargs) conf)
		      (cons (string->keyword (symbol->string (car names)))
			 acc))))
	       (else
		(loop
		   (cdr kwargs)
		   (cdr names)
		   (cons
		      (scheme (car kwargs) conf)
		      (cons **: acc))))))))

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
	     (invoke
		(scheme fun conf)
		(gen-args this conf)))))))

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
	     (scheme-ref-global this conf)))
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
            ,(scheme (PycSubscript-index expr-to-delete) conf)))
      ((PycSlice? expr-to-delete)
        (let ((lower (PycSlice-lower expr-to-delete))
              (upper (PycSlice-upper expr-to-delete))
              (step (PycSlice-step expr-to-delete)))
          `(py-delitem
             ,(scheme (PycSlice-obj expr-to-delete) conf)
              (py-slice-from-scheme
            	  ,(if (PycUninit? lower) 'py-None (scheme lower conf))
            	  ,(if (PycUninit? upper) 'py-None (scheme upper conf))
            	  ,(if (PycUninit? step) 'py-None (scheme step conf))))))
      (else
        (error "scheme::PycDelete" "only del subscript/slice are supported" #f)))))

(define-walk-method (scheme this::PycAccess conf)
  (epairify this
    `(py-getattribute ,(scheme (PycAccess-obj this) conf)
	  ,(pyc-propname (PycAccess-field this)))))

(define-walk-method (scheme this::PycSubscript conf)
   (epairify this
      `(py-getitem ,(scheme (PycSubscript-obj this) conf)
	  ,(scheme (PycSubscript-index this) conf))))

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
      	  ,(if (PycUninit? step) 'py-None (scheme step conf)))))))

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
  (epairify this
    `(if (py-test ,(scheme (PycIfExp-test this) conf))
         ,(scheme (PycIfExp-body this) conf)
         ,(scheme (PycIfExp-orelse this) conf))))

(define-walk-method (scheme this::PycUnimplemented conf)
  `(py-throw-exception-with-message
      py-builtin-NotImplementedError
        ,(PycUnimplemented-msg this)
        " at line "
        ,(number->string (car (PycNode-loc this)))))

(define-walk-method (scheme this::PycStatic conf)
  (PycStatic-value this))

(define-walk-method (scheme this::PycStaticSexp conf)
  (PycStaticSexp-value this))

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

;; collect global variables
(define-walk-method (collect-globals* this::PycNode)
   (call-default-walker))

(define-walk-method (collect-globals* this::PycDeclInit)
   (if (eq? (PycDecl-scope this) 'global)
       (list this)
       '()))

;; collect the python function declarations that could
;; be compiled into scheme top-level definitions

(define (fix-arity? fun)
  (and (null? (PycFun-posonlyargs fun))
       (not (PycDecl? (PycFun-vararg fun)))
       (null? (PycFun-kwonlyargs fun))))

(define (optimize-fun-decl? decl fun)
  ;; true iff the function can be compiled as a top-level
  ;; scheme function
  (and (PycFun? fun)
       (fix-arity? fun)
       (not (memq 'assig (PycDecl-usage decl)))))

(define-walk-method (collect-tl-funs* this::PycNode conf)
   (call-default-walker))

(define-walk-method (collect-tl-funs* this::PycDeclInit conf)
  (if (eq? (PycDecl-scope this) 'global)
    (let ((val (PycDeclInit-val this)))
      (if (optimize-fun-decl? this val)
        (if (null? (PycFun-decorators val))
          (let ((id (scheme-decl-function-name this conf)))
            (PycFun-&proc-set! val id)
            (list this))
          '())
        '()))
    '()))

;; compile scheme top-level definitions
(define-walk-method (scheme-tl* this::PycNode conf)
   (call-default-walker))

(define-walk-method (scheme-tl* this::PycDeclInit conf)
  (if (eq? (PycDecl-scope this) 'local)
    '()
    (let ((val (PycDeclInit-val this)))
      (if (PycFun? val)
        (let ((id (PycFun-&proc val)))
          (if (symbol? id)
            (let ((fun (PycNode-%info val)))
              `((define ,id ,(scheme-procedure-proc val conf))))
            '()))
        '()))))
