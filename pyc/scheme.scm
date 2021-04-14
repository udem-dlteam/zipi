
(define (pyc-scheme ast conf)
   (pyc-cache! ast conf)
   (scheme ast conf))

(define (add-cache-to-store store kind)
  (set-car! store (+ (car store) 1))
  (set-cdr! store (cons kind (cdr store)))
  (- (car store) 1))

(define (pyc-cache! ast conf)
  (let ((store (cons 0 '())))
    (collect-caches ast store)
    (PycModule-caches-set! ast (reverse (cdr store)))))

(define (scheme-make-caches ast)
  `(py-make-caches (quote (,@(PycModule-caches ast)))))

(define (every? pred? lst)
  (cond
    ((null? lst)
      #t)
    ((pred? (car lst))
      (every? pred? (cdr lst)))
    (else
      #f)))

(define (sort-semantics semantics)
  (define (only form)
    (let loop ((s semantics))
      (cond
        ((null? s) '())
        ((eq? (cadar s) form) (cons (car s) (loop (cdr s))))
        (else (loop (cdr s))))))
  (append (only 'define-macro) (only 'define)))

(define (scheme-init-globals vars conf)
  (map
    (lambda (name)
      `(define ,name #f))
    (get-unique-var-names-lst vars conf)))

(define (scheme-init-global-procedures defs conf)
  (filter-map
    (lambda (d)
      (let ((proc-name (get-def-procedure-name d))
            (var (PycRef-decl (PycAssig-lhs d))))
        (if proc-name
          `(define ,proc-name ,(scheme-procedure-proc (PycAssig-rhs d) conf))
          #f)))
    defs))

(define (scheme-init-global-init-defs defs conf)
  (filter-map
    (lambda (d)
      (let ((proc-name (get-def-procedure-name d))
            (var (PycRef-decl (PycAssig-lhs d))))
        (if proc-name
          `(define ,(scheme-def-optim-globals-name-init var conf) (quote %uninit))
          #f)))
    defs))

(define (filter-private-vars vars)
  (cond
    ((null? vars)
      '())
    ((PycVar-global-only-accessed-in-module (car vars))
      (filter-private-vars (cdr vars)))
    (else
      (cons (car vars) (filter-private-vars (cdr vars))))))

(define (scheme-register-globals vars conf)
  (map
    (lambda (var)
      `(global-register!
        %global
        ,(pyc-propname (PycVar-id var))
        (lambda () ,(scheme-var-name var conf))
        (lambda (v)
          (set! ,(scheme-var-name var conf) v))))
    (get-unique-var-lst (filter-private-vars vars) conf)))

(define (set-procedure-names! defs conf)
  (if (not (null? defs))
    ;; defs are PycAssic with PycRef (lhs) and PycFun (rhs)
    (let* ((def (car defs))
          (ref (PycAssig-lhs def))
          (var (PycRef-decl ref))
          (fun (PycAssig-rhs def)))
      ;; only keep procedure for functions which do not seem to be reassigned
      (if (optimize-fun-def? ref fun)
        (begin
          (PycFun-&proc-set! fun (scheme-def-procedure-name var conf))
          (PycFun-&proc-init-set! fun (scheme-def-optim-globals-name-init var conf))))
      (set-procedure-names! (cdr defs) conf))))

(define (get-def-procedure-name def)
  (PycFun-&proc (PycAssig-rhs def)))

(define (get-unique-var-names-lst vars conf)
  (map (lambda (v) (scheme-var-name v conf)) (get-unique-var-lst vars conf)))

(define (get-unique-var-lst vars conf)
  (let loop ((vars vars) (acc '()))
    (if (null? vars)
      acc
      (if (memq (car vars) acc)
        (loop (cdr vars) acc)
        (loop (cdr vars) (cons (car vars) acc))))))

(define (pyc-scheme-bigloo ast conf)
   (pyc-cache! ast conf)
   (let* ((file (config-get conf file:))
	        (path (config-get conf dir:))
          (global-funs
            (if (config-get conf optim-globals:)
                (let ((defs (PycModule-global-defs ast)))
                  (set-procedure-names! defs conf)
                  defs)
                '()))
          (global-refs
            (if (config-get conf optim-globals:)
              (collect-globals* ast)
              '()))
	        (globals (if (config-get conf optim-globals:)
		       (collect-globals* ast)
		       '()))
          (conf-with-defs (cons* global-funs: global-funs conf))
          (prog (scheme ast (cons* global-funs: global-funs conf-with-defs)))
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
		 '((export (zipi-init ::bstring ::bstring ::bstring)))))
	(start-registering-constants)
  ,@(if (config-get conf-with-defs optim-globals:)
    `((define %global #f)
      (define %caches #f)
      ,@(scheme-init-global-procedures global-funs conf-with-defs)
      ,@(scheme-init-global-init-defs global-funs conf-with-defs)
      ,@(scheme-init-globals (map PycRef-decl global-refs) conf-with-defs))
    '())
  ,(if (config-get conf-with-defs optim-globals:)
    `(define (py-module global caches)
      (set! %global global)
      (set! %caches caches)
      ,@(scheme-register-globals (map PycRef-decl global-refs) conf-with-defs)
      ,@prog)
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
		       ,(scheme-make-caches ast)))))
	    (else
	     `(define (zipi-init name package path)
		 (init-registered-constants)
		 (let ((caches ,(scheme-make-caches ast))
		       (module (py-make-module
                         (py-str-from-scheme name)
                         (py-str-from-scheme package)
                         (py-str-from-scheme path))))
		    ,@(if full-path
			  `((py-own-attr-set!
			       module (& "__file__") (& ,full-path)))
			  '())
		    (py-module module caches)
		    module))))
	(end-registering-constants))))

(define (pyc-scheme-gambit ast conf)
  (pyc-cache! ast conf)

  (let* ((semantics (sort-semantics (collect-semantics* ast conf))))
    (if (null? semantics)
      ;; normal compilation
      (let* ((file (config-get conf file:))
            (path (config-get conf dir:))
            (special-init
              (if (eq? (PycModule-special-init ast) 'builtins)
                'init-builtin-module
                #f))
            (global-funs
              (if (config-get conf optim-globals:)
                  (let ((defs (PycModule-global-defs ast)))
                    (set-procedure-names! defs conf)
                    defs)
         		      '()))
            (global-refs
              (if (config-get conf optim-globals:)
                (collect-globals* ast)
        		    '()))
            (conf-with-defs (cons* global-funs: global-funs conf))
            (prog (scheme ast (cons* global-funs: global-funs conf-with-defs)))
            (full-path (if (and file path) (make-file-path path file) #f)))
        (list
          `(define-library (,(string->symbol (config-get conf name:)))
            ,(if special-init
              `(export
                init
                ,special-init
                ,@(map
                  (lambda (var) (scheme-var-name var conf))
                  (get-unique-var-lst (map PycRef-decl global-refs) conf)))
              `(export init))
            (import (gambit) (zipi rts))
            (begin
              (py-begin-module)

              ,@(if (config-get conf-with-defs optim-globals:)
                ;; procedures are static
                `(,@(scheme-init-global-procedures global-funs conf-with-defs)
                  (declare (separate))
                  (define %global #f)
                  (define %caches #f)
                  ;; function objects and global variables are dynamic
                  ,@(scheme-init-global-init-defs global-funs conf-with-defs)
                  ,@(scheme-init-globals (map PycRef-decl global-refs) conf-with-defs)
                  (declare (block)))
                '())

              ,(if (config-get conf-with-defs optim-globals:)
                `(define (py-module global caches)
                  (set! %global global)
                  (set! %caches caches)
                  ,@(scheme-register-globals (map PycRef-decl global-refs) conf-with-defs)
                  ,@prog)
                   `(define py-module ,prog))

              ,@(if special-init
                `((define (init name package __path__)
                    builtins-mod))
                '())

              (define (,(or special-init 'init) name package __path__)
                (py-init-module)
                (let ((caches ,(scheme-make-caches ast))
                      (module (py-make-module name package __path__)))
                  ,(if full-path
                    `(global-put!
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
   (let* ((args (PycFun-args this))
	  (arg-names (map (lambda (a) (scheme-var-name a conf)) args))
	  (need-return (PycFun-need-return this))
	  (return-sym (if need-return (my-gensym '%return) #f))
	  (body-conf (if need-return
			 (cons* fun: this return: return-sym conf)
			 (cons* fun: this conf)))
	  (body (scheme (PycFun-body this) body-conf))
	  (scheme-name (PycFun-name this)))
      (list
	 (cons
	    scheme-name
	    (if (PycSemantics-inline this)
		(if (PycSemantics-inline-as-is this)
		    (list 'define-macro (cons scheme-name arg-names)
		       (list 'quasiquote body))
		    (list 'define-macro (cons scheme-name arg-names)
		       (list 'quasiquote
			  (list 'let (map (lambda (name) (list name (list 'unquote name))) arg-names)
			     body))))
		`(define (,scheme-name ,@arg-names) ,body))))))

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
      (if (config-get conf optim-globals:)
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
        `(letrec*
          ,(map
            (lambda (assig)
              (let ((lhs (PycAssig-lhs assig))
                    (rhs (PycAssig-rhs assig)))
                (if (PycRef? lhs)
                  `(,(scheme-var-name (PycRef-decl lhs) conf)
                    ,(scheme rhs conf))
                  (error "scheme::PycBlock" "block assignment must be PycRef" lhs))))
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
     (if (eq? (PycExpr-type this) 'Ubool)
      (scheme this conf)
      (cond
        ((isa? this PycBoolOp)
          ;; in a test we try to skip conversion of expression to Python bool
          ;; and convert directly to scheme bool
          (let ((op (PycBoolOp-op this))
                (args (PycBoolOp-args this)))
            (case op
              ((or)
                `(or ,@(map (lambda (a) (pyc-test a conf)) args)))
              ((and)
                `(and ,@(map (lambda (a) (pyc-test a conf)) args)))
              (else (error "scheme::PycBoolOp" "unknown op" op)))))
        ((isa? this PycChainCmp)
          (let ((left-chain-symbol (my-gensym '%left-elt)))
            `(let ((,left-chain-symbol ,(scheme (PycChainCmp-lhs this) conf)))
              ,(let loop ((left left-chain-symbol)
                         (rights
                           (map
                             (lambda (e) (scheme e conf))
                             (PycChainCmp-rest this)))
                         (ops (PycChainCmp-ops this)))
                (if (null? (cdr ops))
                  (epairify this
                    `(py-test
                      (,(symbol-append 'py- (car ops))
                        ,left
                        ,(car rights))))
                  (let ((chain-symbol (my-gensym '%chain-elt))
                        (res-symbol (my-gensym '%chain-result)))
                    `(let* ((,chain-symbol ,(car rights))
                            (,res-symbol (py-test (,(symbol-append 'py- (car ops)) ,left ,chain-symbol))))
                      (and ,res-symbol
                          ,(loop chain-symbol (cdr rights) (cdr ops))))))))))
	      (else `(py-test ,(scheme this conf)))))))

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
            (let ((var (PycRef-decl optional-vars)))
              (if (eq? (PycVar-scope var) 'global)
                `(let ((,ctx-sym ,(scheme context-expr conf)))
                   ,(scheme-assig-global optional-vars `(py-enter ,ctx-sym) conf)
                   (with-handler
                    (lambda (%exn)
                      (if (PyObject? %exn)
                        ;; it is the responsability of py-exit to re-raise the exc or not
                        (py-exit ,ctx-sym %exn)
                        (raise %exn)))
                    ,(in-contexts (cdr items) body))
                    (py-exit ,ctx-sym py-None))
                `(let ((,ctx-sym ,(scheme context-expr conf)))
                   (set! ,(scheme-var-name var conf) (py-enter ,ctx-sym))
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

(define (scheme-var-name var conf)
  (let ((current-name (PycVar-name var)))
    (if current-name
      current-name
      (let* ((name
              (cond
                ((PycVar-is-builtin var)
                  (symbol-append '&py-builtin- (PycVar-id var)))
                ((eq? (PycVar-scope var) 'global)
                  (symbol-append
                    '|global:|
                    (PycVar-id var)
                    '-
                    (string->symbol (number->string (PycVar-key var)))))
                (else
                  (symbol-append
                     (PycVar-id var)
              	     '-
              	     (string->symbol (number->string (PycVar-key var))))))))
        (PycVar-name-set! var name)
        name))))

(define (scheme-def-optim-globals-name-init this conf)
   (symbol-append '|init:| (scheme-var-name this conf)))

(define (scheme-def-procedure-name this conf)
   (symbol-append '|procedure:| (scheme-var-name this conf)))

(define (scheme-default-global-assig ref var val)
 `(global-put! %global ,(pyc-propname (PycVar-id var)) ,val
   ,(scheme-cache (PycRef-cache ref) ref)))

(define (scheme-assig-global ref val conf)
  (let ((var (PycRef-decl ref)))
    (if (config-get conf optim-globals:)
      `(set! ,(scheme-var-name var conf) ,val)
      (scheme-default-global-assig ref var val))))

(define (scheme-assig-global-fun ref fun conf)
  (let ((var (PycRef-decl ref))
        (val (scheme fun conf)))
    (if (config-get conf optim-globals:)
      (if (PycFun-&proc fun)
        ;; optimized global fun, set an init value for fast call
        `(let (($fun-obj ,val))
          (set! ,(scheme-var-name var conf) $fun-obj)
          (set! ,(PycFun-&proc-init fun) $fun-obj))
        ;; non-optimized global fun
        `(set! ,(scheme-var-name var conf) ,val))
      (scheme-default-global-assig ref var val))))

(define (pyc-propname name)
   (cond
      ((string? name) `(& ,name))
      ((symbol? name) `(& ,(symbol->string name)))
      (else (error "pyc-propname" "Wrong property name" name))))

(define (assignable-collection? x)
  (and (isa? x PycCollection) (not (isa? x PycDict))))

(define (scheme-simple-assig lhs rhs conf)
  (cond
    ;; X = ...
    ((isa? lhs PycRef)
      (let* ((var (PycRef-decl lhs)))
        (case (PycVar-scope var)
          ((global)
            (if (isa? rhs PycFun)
              (scheme-assig-global-fun lhs rhs conf)
              (scheme-assig-global lhs (scheme rhs conf) conf)))
          (else
            `(set! ,(scheme-var-name var conf) ,(scheme rhs conf))))))
    ((isa? lhs PycRefUnresolved)
      (error "scheme::PycAssig" "assignment to unresolved variable" lhs))
    ;; X.attr = ...
    ((isa? lhs PycAccess)
      (let* ((obj (PycAccess-obj lhs))
             (field (PycAccess-field lhs)))
        `(py-setattribute
          ,(scheme obj conf)
          ,(pyc-propname field)
          ,(scheme rhs conf))))
    ;; l[x:y:z] = X
    ((isa? lhs PycSlice)
      (let* ((obj (PycSlice-obj lhs))
             (lower (PycSlice-lower lhs))
             (upper (PycSlice-upper lhs))
             (step (PycSlice-step lhs)))
        `(py-setitem
          ,(scheme obj conf)
          (py-slice-from-scheme
            ,(if (PycUninit? lower) 'py-None (scheme lower conf))
            ,(if (PycUninit? upper) 'py-None (scheme upper conf))
            ,(if (PycUninit? step) 'py-None (scheme step conf)))
          ,(scheme rhs conf))))
    ;; l[x] = X
    ((isa? lhs PycSubscript)
      (let* ((obj (PycSubscript-obj lhs))
             (index (PycSubscript-index lhs)))
      `(py-setitem
        ,(scheme obj conf)
        ,(scheme index conf)
        ,(scheme rhs conf))))
    ;; error
    (else
      (error "scheme-simple-assig" "unknown assignment type" lhs))))

(define (scheme-simple-multiple-assig lhs-elts rhs-elts conf)
  (let ((lhs-len (length lhs-elts)) (rhs-len (length rhs-elts)))
    (cond
      ((= lhs-len rhs-len)
        (let* ((tmps (map (lambda (a) (my-gensym 'tmp)) rhs-elts))
              (tmp-let (map (lambda (sym r) (list sym (scheme r conf))) tmps rhs-elts)))
          `(let ,tmp-let
              ,@(map (lambda (l sym) (scheme-simple-assig l (new-PycPragma (PycNode-loc l) sym) conf)) lhs-elts tmps))))
      ((> lhs-len rhs-len)
        `(py-throw-exception-with-message
            py-builtin-ValueError
            ,(string-append "not enough values to unpack (expected " (number->string lhs-len) ", got " (number->string rhs-len) ")")))
      (else
        `(py-throw-exception-with-message
            py-builtin-ValueError
            ,(string-append "too many values to unpack (expected " (number->string lhs-len) ", got " (number->string rhs-len) ")"))))))

(define (parse-mutliple-assig-lhs lhs-elts)
  (define (parse-left rev-left tail)
    (cond
      ((null? tail)
        (list (reverse rev-left) #f '()))
      ((isa? (car tail) PycStarredExpr)
        (list (reverse rev-left) (car tail) (parse-right (cdr tail))))
      (else
        (parse-left (cons (car tail) rev-left) (cdr tail)))))

  (define (parse-right tail)
    (if (every? (lambda (e) (not (isa? e PycStarredExpr))) tail)
      tail
      (error "SyntaxError" "multiple starred expressions in assignment" "")))

  (parse-left '() lhs-elts))

(define (scheme-multiple-assig-fallback lhs-elts rhs conf)
  (let* ((left-star-right (parse-mutliple-assig-lhs lhs-elts))
         (left (car left-star-right))
         (left-len (length left))
         (starred (cadr left-star-right))
         (right (caddr left-star-right))
         (right-len (length right))
         (unpack-sym (my-gensym 'unpacked))
         (left-sym (my-gensym 'left))
         (mid-sym (my-gensym 'mid))
         (right-sym (my-gensym 'right)))
    (if starred
      ;; TODO: optimize case where right is null
      `(let* ((,unpack-sym (py-ternary-unpack ,(scheme rhs conf) ,left-len ,right-len))
              (,left-sym (vector-ref ,unpack-sym 0))
              (,mid-sym (vector-ref ,unpack-sym 1))
              (,right-sym (vector-ref ,unpack-sym 2)))
        ,@(map
            (lambda (expr index)
              (scheme-simple-assig
                expr
                (new-PycPragma (PycNode-loc expr) `(vector-ref ,left-sym ,index))
                conf))
            left
            (iota (length left)))
        ,(scheme-simple-assig
          (PycStarredExpr-expr starred)
          (new-PycPragma (PycNode-loc starred) mid-sym)
          conf)
        ,@(map
            (lambda (expr index)
              (scheme-simple-assig
                expr
                (new-PycPragma (PycNode-loc expr) `(vector-ref ,right-sym ,index))
                conf))
            right
            (iota (length right))))
      `(let* ((,unpack-sym (list->vector (py-unpack ,(scheme rhs conf)))))
        (if (fx= (vector-length ,unpack-sym) ,left-len)
          (begin
            ,@(map
              (lambda (expr index)
                (scheme-simple-assig
                  expr
                  (new-PycPragma (PycNode-loc expr) `(vector-ref ,unpack-sym ,index))
                  conf))
              left
              (iota (length left))))
          (py-throw-exception-with-message
            py-builtin-ValueError
            ,(string-append
              "too many values to unpack (expected "
              (number->string (length left))
              ")")))))))


(define (scheme-multiple-assig tuple-lhs rhs conf)
  (let ((lhs-elts (PycCollection-elts tuple-lhs)))
    (if (assignable-collection? rhs)
      (let ((rhs-elts (PycCollection-elts rhs)))
        (if (and
              (every? (lambda (e) (not (isa? e PycStarredExpr))) lhs-elts)
              (every? (lambda (e) (not (isa? e PycStarredExpr))) rhs-elts))
          (scheme-simple-multiple-assig lhs-elts rhs-elts conf)
          (scheme-multiple-assig-fallback lhs-elts rhs conf)))
      (scheme-multiple-assig-fallback lhs-elts rhs conf))))

(define-walk-method (scheme this::PycAssig conf)
  (let* ((lhs (PycAssig-lhs this))
         (rhs (PycAssig-rhs this)))
    (if (assignable-collection? lhs)
      (scheme-multiple-assig lhs rhs conf)
      (scheme-simple-assig lhs rhs conf))))

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
			   obj-cache: (PycAccess-obj-cache lhs)
         mro-cache: (PycAccess-mro-cache lhs))
			(new-PycCall loc
			   (new-PycPragma loc (symbol-append 'py- (PycAugAssig-op this)))
			   (list
			      (new-PycAccess loc (new-PycPragma loc %o) field
				 obj-cache: (PycAccess-obj-cache lhs)
         mro-cache: (PycAccess-mro-cache lhs))
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
        (begin
        (error "scheme::PycBinary" "operation between rhs native type and non-native type" lhs-type-hint))
        (python-op)))))

(define-walk-method (scheme this::PycChainCmp conf)
  (let ((left-chain-symbol (my-gensym '%left-elt)))
    `(let ((,left-chain-symbol ,(scheme (PycChainCmp-lhs this) conf)))
      ,(let loop ((left left-chain-symbol)
                 (rights
                   (map
                     (lambda (e) (scheme e conf))
                     (PycChainCmp-rest this)))
                 (ops (PycChainCmp-ops this)))
        (if (null? (cdr ops))
          (epairify this
            `(,(symbol-append 'py- (car ops))
              ,left
              ,(car rights)))
          (let ((chain-symbol (my-gensym '%chain-elt))
                (res-symbol (my-gensym '%chain-result)))
            `(let* ((,chain-symbol ,(car rights))
                    (,res-symbol (,(symbol-append 'py- (car ops)) ,left ,chain-symbol)))
              (if (py-test ,res-symbol)
                  ,(loop chain-symbol (cdr rights) (cdr ops))
                  ,res-symbol))))))))

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
      (let ((sym (my-gensym 'and-arg)))
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
		      `(args: ,(map PycVar-id args)))
		  (if (null? posonlyargs)
		      '()
		      `(posonlyargs: ,(map PycVar-id posonlyargs)))
		  (cond
		     ((PycVar? vararg)
		      `(vararg: ,(PycVar-id vararg)))
		     ((PycUninit? vararg)
		      '())
		     (else
		      (error "signature" "unknown value for vararg" vararg)))
		  (if (null? kwonlyargs)
		      '()
		      `(kwonlyargs: ,(map PycVar-id kwonlyargs)))
		  (if (null? kw-defaults)
		      '()
		      `(kw-defaults: (vector ,@(scheme* kw-defaults conf))))
		  (cond
		     ((PycVar? kwarg)
		      `(kwarg: ,(PycVar-id kwarg)))
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

  (define (generator this exp)
    (if (PycFun-generator this)
      (epairify this
        `(letrec ((%gen (py-make-generator (lambda (%v %e) ,exp))))
          %gen))
      exp))

  (define (locals fun body)
    (let ((body-with-vars
            `(letrec*
              ,(map (lambda (decl)
                 `(,(scheme-var-name decl conf)
                  #f))
                (PycFun-decls fun))
              ,body)))
      (if (PycFun-can-locals fun)
        `(let ((%frame (make-cell #f))
               (%names
                 ',(map! PycVar-id
                   (append (PycFun-args fun) (PycFun-decls fun)))))
                ,body-with-vars)
        body-with-vars)))

  (let* ((vararg (PycFun-vararg this))
        (kwarg (PycFun-kwarg this))
        (args
          (map
            scheme-var-name
    		    (append
    		      (PycFun-posonlyargs this)
    		      (PycFun-args this)
    		      (if (PycVar? vararg) (list vararg) '())
    		      (PycFun-kwonlyargs this)
    		      (if (PycVar? kwarg) (list kwarg) '()))
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
  (define (pyc-class this)
    (let ((cls-symbol (PycClass-super-key this))
          (is-builtin (PycClass-is-builtin this)))
      (epairify this
        `(begin
          ,(if is-builtin
            ;; builtin classes defined in he builtins.py
            `(set! ,cls-symbol
              (py-make-builtin-class
                (&& ,(PycClass-name this))
                (&& ,(PycClass-module this))
                (list ,@(map (lambda (b) (scheme b conf)) (PycClass-bases this)))
                ,@(append-map
                  (lambda (var)
                    `(,(pyc-propname (PycVar-id var))
                      ,(scheme-var-name var conf)))
                    (PycClass-decls this))))
            ;; user-defined class
            `(set! ,cls-symbol
              (py-make-class
                (&& ,(PycClass-name this))
                (&& ,(PycClass-module this))
                (list ,@(map (lambda (b) (scheme b conf)) (PycClass-bases this)))
                ,@(append-map
                  (lambda (var)
                    `(,(pyc-propname (PycVar-id var))
                    ,(scheme-var-name var conf)))
                  (PycClass-decls this)))))
              ,cls-symbol))))

  (let* ((body (scheme (PycClass-body this) conf))
         (body-with-vars
            `(letrec*
              ,(map (lambda (decl)
                 `(,(scheme-var-name decl conf)
                  #f))
                (PycClass-decls this))
              ,body))
         (cls-symbol (PycClass-super-key this)))
    (epairify this
      `(let ((,cls-symbol py-absent))
        ,(match-case body-with-vars
          ((letrec* ?bindings . ?body)
            `(letrec* ,bindings ,@body ,(pyc-class this)))
          (else
            `(begin ,body-with-vars ,(pyc-class this))))))))

(define-walk-method (scheme this::PycKont conf)
   (epairify this
      `(lambda ,(map (lambda (p)
			(let ((d (PycRef-decl p)))
			   (scheme-var-name d conf)))
		   (PycKont-params this))
	  ,(scheme (PycKont-body this) conf))))

(define-walk-method (scheme this::PycCallKont conf)
   (epairify this
      `(,(scheme (PycCallKont-kont this) conf)
	,@(map (lambda (a) (scheme a conf)) (PycCallKont-args this)))))

(define (get-def-with-var global-funs var)
  (if (null? global-funs)
    #f
    (let ((fn-var (PycRef-decl (PycAssig-lhs (car global-funs)))))
      (if (eq? fn-var var)
        (PycAssig-rhs (car global-funs))
        (get-def-with-var (cdr global-funs) var)))))

(define-walk-method (scheme this::PycCall conf)

   (define (correct-arity? fun this)
      (and
        (null? (PycCall-keywords-names this))
        (=fx
          (+ (length (PycFun-args fun)) (length (PycFun-posonlyargs fun)))
          (length (PycCall-args this)))))

   (define (invoke-global fun args)
    (let ((f (PycCall-fun this)))
      (cond
        ((PycRef? f)
          (let* ((var (PycRef-decl f)))
            (if (eq? (PycVar-scope var) 'global)
              (let* ((global-funs
                      (let ((gf (memq global-funs: conf))) (and gf (cadr gf))))
                    (init-val (and global-funs (get-def-with-var global-funs var))))
                 (if (and (PycFun? init-val)
                          (symbol? (PycFun-&proc init-val))
                          (correct-arity? init-val this))
                  (if (PycVar-global-ref-to-init-def var)
                    `(,(PycFun-&proc init-val) ,@args)
                    `(py-global-call
                        %global
                        ,(PycFun-&proc init-val)
                        ,(scheme-var-name var conf)
                        ,(scheme-def-optim-globals-name-init var conf)
                        ,(pyc-propname (PycVar-id var))
                        ,(scheme-cache (PycRef-cache f) this)
                        ,@args))
                  #f))
              #f)))
        ((PycRefUnresolved? f) #f)
        (else #f))))

   (define (invoke fun args)
      (if (or (> (length args) 0) (not (PycCall-can-be-super this)))
	  (or (invoke-global fun args)
	      `(py-call ,fun ,@args))
	  (let* ((caller (config-get conf fun:))
		 (caller-args (and caller (PycFun-args caller)))
		 (class-key (and caller (PycFun-super-in-class caller)))
		 (super-instance
       (if (and caller-args (> (length caller-args) 0))
		      (scheme-var-name (list-ref caller-args 0) conf)
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
      (let ((depth (PycImport-depth this)))
        (if (= depth 0)
            `(py-import ,(PycImport-path this) ',(PycImport-from-list this))
            `(py-import-relative %global ,(PycImport-path this) ',(PycImport-from-list this) ,depth)))))

(define-walk-method (scheme this::PycRef conf)
   (let* ((var (PycRef-decl this))
          (id (PycVar-id var))
          (name (scheme-var-name var conf)))
    (cond
      ((PycRef-can-direct-access this)
        name)
  	  ((eq? (PycVar-scope var) 'global)
        (cond-expand
          (bigloo
           (if (config-get conf optim-globals:)
         `(or ,name
              (global-get
           %global
           ,(pyc-propname id)
           ,(scheme-cache (PycRef-cache this) this)))
         `(global-get
           %global
           ,(pyc-propname id)
           ,(scheme-cache (PycRef-cache this) this))))
          (else
           `(or ,name
          (global-get
             %global
             ,(pyc-propname id)
             ,(scheme-cache (PycRef-cache this) this))))))
  	  (else
  	   `(or ,name
  	        (py-throw-exception-with-message
  	 	  py-builtin-UnboundLocalError
  	 	  ,(string-append "local variable '" (symbol->string id) "' referenced before assignment")))))))

(define-walk-method (scheme this::PycRefUnresolved conf)
   (epairify this
      `(global-get
        %global
        ,(pyc-propname (PycRefUnresolved-id this))
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
        (error "scheme::PycDelete" "only del subscript/slice are supported" this)))))

(define-walk-method (scheme this::PycAccess conf)
  (epairify this
    `(py-getattribute ,(scheme (PycAccess-obj this) conf)
	  ,(pyc-propname (PycAccess-field this))
    ,(scheme-cache (PycAccess-obj-cache this) this)
    ,(scheme-cache (PycAccess-mro-cache this) this))))

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
    `(if ,(pyc-test (PycIfExp-test this) conf)
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
(define-walk-method (collect-caches this::PycNode store)
   (call-default-walker))

(define-walk-method (collect-caches this::PycRef store)
  (when (eq? (PycVar-scope (PycRef-decl this)) 'global)
    (PycRef-cache-set! this (add-cache-to-store store 'hclass))))

(define-walk-method (collect-caches this::PycUnary store)
  (call-default-walker)
  (PycUnary-cache-set! this (add-cache-to-store store 'hclass)))

(define-walk-method (collect-caches this::PycRefUnresolved store)
  (PycRefUnresolved-cache-set! this (add-cache-to-store store 'hclass)))

(define-walk-method (collect-caches this::PycAccess store)
  (call-default-walker)
  (PycAccess-obj-cache-set! this (add-cache-to-store store 'hclass))
  (PycAccess-mro-cache-set! this (add-cache-to-store store 'mro)))

(define-walk-method (collect-caches this::PycAugAssig store)
   (call-default-walker)
   (PycAugAssig-cache-set! this (add-cache-to-store store 'hclass)))

(define-walk-method (collect-caches this::PycFor store)
   (call-default-walker)
	 (PycFor-cachei-set! this (add-cache-to-store store 'hclass))
	 (PycFor-cachen-set! this (add-cache-to-store store 'hclass)))

;; collect global variables
(define-walk-method (collect-globals* this::PycNode)
   (call-default-walker))

(define-walk-method (collect-globals* this::PycRef)
  (if (eq? (PycVar-scope (PycRef-decl this)) 'global)
    (list this)
    '()))

;; collect the python function declarations that could
;; be compiled into scheme top-level definitions

(define (fix-arity? fun)
  (and (not (PycVar? (PycFun-vararg fun)))
       (not (PycVar? (PycFun-kwarg fun)))
       (null? (PycFun-kwonlyargs fun))))

(define (optimize-fun-def? ref fun)
  ;; true iff the function can be compiled as a top-level
  ;; scheme function
  (let ((var (PycRef-decl ref)))
    (if (eq? (PycVar-scope var) 'global)
      (let ((assig-usage
              (let loop ((usage (PycVar-usage var)))
                (cond
                  ((null? usage)
                    '())
                  ((eq? (PycRef-ctx (car usage)) 'Store)
                    (cons (car usage) (loop (cdr usage))))
                  (else
                    (loop (cdr usage)))))))
        (and (PycFun? fun)
             (null? (PycFun-decorators fun))
             (fix-arity? fun)
             (= (length assig-usage) 1)))
        #f)))
