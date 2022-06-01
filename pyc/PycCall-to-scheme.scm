(define (PycCall-copy call)
  (new-PycCall
    (PycNode-loc call)
    (PycCall-fun call)
    (PycCall-args call)
    %info: (PycNode-%info call)
    cps: (PycNode-cps call)
    type: (PycExpr-type call)
    keywords-values: (PycCall-keywords-values call)
    keywords-names: (PycCall-keywords-names call)
    can-be-super: (PycCall-can-be-super call)))

;; =====================================================================
;; Predicates
;; =====================================================================

(define-predicate (call-to-a-pragma? call conf params)
  (isa? (PycCall-fun call) PycPragma))

(define-predicate (call-to-an-attribute? call conf params)
  (isa? (PycCall-fun call) PycAccess))

(define-predicate (call-has-keyword-arguments? call conf params)
  (pair? (PycCall-keywords-names call)))

(define-predicate (call-has-fixed-arity? call conf params)
  (let* ((args (PycCall-args call))
         (keywords-names (PycCall-keywords-names call))
         (keywords-values (PycCall-keywords-values call)))
    (and
      (all? (lambda (x) (not (isa? x PycStarredExpr))) args) ;; contains no *args
      (all? (lambda (x) x) keywords-names)))) ;; Contains no **kwargs

(define (correct-arity? fun call conf params)
   (and
     (not (call-has-keyword-arguments? call conf params))
     (=
       (+ (length (PycFun-args fun)) (length (PycFun-posonlyargs fun)))
       (length (PycCall-args call)))))

(define-predicate (call-matches-signature-to-global-function? call conf params)
  (let ((fun (PycCall-fun call))
        (global-funs (config-get conf global-funs:)))
    (if (isa? fun PycRef)
      (let* ((var (PycRef-decl fun)))
        (if (eq? (PycVar-scope var) 'global)
          (let ((init-val (and global-funs (get-def-with-var global-funs var))))
             (and (isa? init-val PycFun)
                  (symbol? (PycFun-&proc init-val))
                  (correct-arity? init-val call conf params)))
          #f))
      #f)))

(define-predicate (static-call-to-global-function? call conf params)
  (and
    (call-matches-signature-to-global-function? call conf params)
    (PycVar-global-ref-to-init-def (PycRef-decl (PycCall-fun call)))))

(define-predicate (ignore-global-functions? call conf params)
  (config-get params ignore-global-functions:))

(define-predicate (ignore-arity-check? call conf params)
  (config-get params ignore-arity-check:))

(define-predicate (call-after-skipped-binding? call conf params)
  (config-get params skipped-binding:))

(define-predicate (call-with-no-arguments? call conf params)
  (and (null? (PycCall-args call)) (null? (PycCall-keywords-names call))))

;; =====================================================================
;; Code generation
;; =====================================================================

(define (get-static-global-call-procedure-name call conf)
  (define (get-def-with-var global-funs var)
    (if (null? global-funs)
      #f
      (let ((fn-var (PycRef-decl (PycAssig-lhs (car global-funs)))))
        (if (eq? fn-var var)
          (PycAssig-rhs (car global-funs))
          (get-def-with-var (cdr global-funs) var)))))

  (let* ((fun (PycCall-fun call))
         (var (PycRef-decl fun))
         (global-funs (config-get conf global-funs:))
         (init-val (get-def-with-var global-funs var)))
    (PycFun-&proc init-val)))

(define (py-static-global-call call conf)
  `(,(get-static-global-call-procedure-name call conf)
    ,@(map (lambda (a) (scheme a conf)) (PycCall-args call))))

(define (py-global-call call conf params)
  (let* ((fun (PycCall-fun call))
         (var (PycRef-decl fun))
         (args (PycCall-args call))
         (args-syms (map (lambda (e) (my-gensym 'arg)) args))
         (global-name (scheme-var-name var conf))
         (global-init-val-name (scheme-def-optim-globals-name-init var conf)))
    `(let* ,(map (lambda (p a) (list p (scheme a conf))) args-syms args)
      (if (eq? ,global-name ,global-init-val-name)
        ((PyObjectFunction-procedure ,global-name) ,@args-syms)
        ,(call-to-scheme call
                         conf
                         (cons*
                           ignore-global-functions: #t
                           params))))))

(define (py-call-with-arity-check call conf params)
  ;; call by checking the arity of a call with no keyword and no *args
  (let* ((fun (PycCall-fun call))
         (fun-sym (my-gensym 'fun))
         (fun-code (scheme fun conf))
         (args (PycCall-args call))
         (X (length args))
         ;; function such as f(x, y, *args) have a negative arity to mark the *args
         ;; the function f(x1, x2, ..., xn, *args) has an arity N = -(n + 1), thus
         ;; the number of arguments A must be A > n = -(N + 1)
         (min-negative-arity (- 0 X 1))
         (args-code (map (lambda (a) (scheme a conf)) args))
         (args-sym (map (lambda (_) (my-gensym 'arg)) args))
         (args-bindings (map list args-sym args-code))
         (bindings (cons (list fun-sym fun-code) args-bindings))
         (dynamic-super-call (dynamic-super-call? call conf params))
         (cond-to-call-super-if-needed
           (if dynamic-super-call
             (list `((py-test-is ,fun-sym py-builtin-super) ,dynamic-super-call))
             '())))
    `(let* ,bindings
      ;; TODO: limit X to what the rts can handle
      (if (,(string->symbol (string-append "PyObjectFunctionArity" (number->string X) "?")) ,fun-sym)
          ((PyObjectFunction-procedure ,fun-sym) ,@args-sym)
          ,(call-to-scheme
            (new-PycCall
              (PycNode-loc call)
              (new-PycStatic (PycNode-loc fun) fun-sym fun-sym)
              (PycCall-args call)
              %info: (PycNode-%info call)
              cps: (PycNode-cps call)
              type: (PycExpr-type call)
              keywords-values: (PycCall-keywords-values call)
              keywords-names: (PycCall-keywords-names call)
              can-be-super: (PycCall-can-be-super call))
            conf
            (cons* minimum-negative-arity: min-negative-arity
                   ignore-arity-check: #t
                   params))))))

(define (dynamic-super-call? call conf params)
  ;; A dynamic super call occurs when the user calls super()
  ;; but the compiler calls super(cls, self)
  ;; this may occur whenever the called expression evaluates to super
  ;; at runtime.
  (let* ((loc (PycNode-loc call))
         (fun-loc (PycNode-loc (PycCall-fun call)))
         (caller (config-get conf fun:))
         (caller-args (and caller (PycFun-args caller)))
         (class-key (and caller (PycFun-super-in-class caller)))
         (super-instance
           (if (and caller-args (> (length caller-args) 0))
              (scheme-var-name (list-ref caller-args 0) conf)
              #f)))
    (if (and (call-with-no-arguments? call conf params)
             class-key
             super-instance)
      (call-to-scheme
        (new-PycCall loc (new-PycStatic fun-loc 'py-builtin-super 'py-builtin-super)
                         (list (new-PycStatic fun-loc class-key class-key)
                               (new-PycStatic fun-loc super-instance super-instance)))
        conf params)
      #f)))

(define (default-call call conf params)
  (define (default-call-no-super-check fun args keywords-names keywords-values conf params)
    (let ((minimum-negative-arity (config-get params minimum-negative-arity:))
          (call-after-skipped-binding (call-after-skipped-binding? call conf params))
          (fun-sym (my-gensym 'fun)))
      (if minimum-negative-arity
        (if call-after-skipped-binding
          `(let ((,fun-sym ,(scheme (PycCall-fun call) conf)))
            (if (binding-skip-success? ,fun-sym)
              (py-callX-fallback
                ,minimum-negative-arity
                ,fun-sym
                ,@(flatten
                    (map (lambda (a)
                           (if (isa? a PycStarredExpr)
                               (list *: (scheme (PycStarredExpr-expr a) conf))
                               (list (scheme a conf))))
                         args)))
              ,(let ((call-copy (PycCall-copy call)))
                (PycCall-fun-set!
                  call-copy
                  (new-PycStatic (PycNode-loc (PycCall-fun call)) 'binding-callback `(binding-skip-callback ,fun-sym)))
                (PycCall-args-set! call-copy (cdr (PycCall-args call)))
                (call-to-scheme call-copy
                  conf
                  (cons* skipped-binding: #f
                         minimum-negative-arity: (+ minimum-negative-arity 1)
                         params)))))
          ;; TODO this does not add a call to super when required
          `(py-callX-fallback
            ,minimum-negative-arity
            ,(scheme fun conf)
            ,@(flatten
                (map (lambda (a)
                       (if (isa? a PycStarredExpr)
                           (list *: (scheme (PycStarredExpr-expr a) conf))
                           (list (scheme a conf))))
                     args))))
        (if call-after-skipped-binding
          `(let ((,fun-sym ,(scheme (PycCall-fun call) conf)))
            (if (binding-skip-success? ,fun-sym)
              (py-call
                ,fun-sym
                ,@(flatten
                    (map (lambda (a)
                           (if (isa? a PycStarredExpr)
                               (list *: (scheme (PycStarredExpr-expr a) conf))
                               (list (scheme a conf))))
                         args))
                ,@(interleave
                    (map (lambda (n) (if n (string->keyword (symbol->string n)) **:)) keywords-names)
                    (map (lambda (v) (scheme v conf)) keywords-values)))
              ,(let ((call-copy (PycCall-copy call)))
                (PycCall-fun-set!
                  call-copy
                  (new-PycStatic (PycNode-loc (PycCall-fun call)) 'binding-callback `(binding-skip-callback ,fun-sym)))
                (PycCall-args-set! call-copy (cdr (PycCall-args call)))
                (call-to-scheme call-copy conf (cons* skipped-binding: #f params)))))
          `(py-call
            ,(scheme fun conf)
            ,@(flatten
                (map (lambda (a)
                       (if (isa? a PycStarredExpr)
                           (list *: (scheme (PycStarredExpr-expr a) conf))
                           (list (scheme a conf))))
                     args))
            ,@(interleave
                (map (lambda (n) (if n (string->keyword (symbol->string n)) **:)) keywords-names)
                (map (lambda (v) (scheme v conf)) keywords-values)))))))

  (let* ((fun (PycCall-fun call))
         (fun-loc (PycNode-loc fun))
         (args (PycCall-args call))
         (keywords-names (PycCall-keywords-names call))
         (keywords-values (PycCall-keywords-values call))
         (dynamic-super-call (dynamic-super-call? call conf params)))
    (if dynamic-super-call
      (let ((fn-sym (my-gensym 'fun-maybe-super)))
        `(let ((,fn-sym ,(scheme fun conf)))
           (if (py-test-is ,fn-sym py-builtin-super)
              ,dynamic-super-call
              ,(default-call-no-super-check
                (new-PycStatic fun-loc fn-sym fn-sym)
                args
                keywords-names
                keywords-values
                conf
                params))))
      (default-call-no-super-check fun args keywords-names keywords-values conf params))))

(define (default-call-method-with-binding-skip call conf params)
  (let* ((method-access (PycCall-fun call))
         (obj (PycAccess-obj method-access))
         (obj-sym (my-gensym 'obj))
         (obj-sym-static (new-PycStatic (PycNode-loc obj) obj-sym obj-sym))
         (unbound-method-or-callback-sym (my-gensym 'unbound-method-or-callback))
         (getattribute-method-sym (symbol-append obj-sym '.__getattribute__))
         (field (PycAccess-field method-access)))
  `(let* ((,obj-sym ,(scheme obj conf))
          (,unbound-method-or-callback-sym
            (py-getattribute-skip-binding
              ,obj-sym
              ,(pyc-propname field)
              #f
             ,(if (in-semantics? method-access conf params)
                  #f
                  (scheme-cache (PycAccess-cache method-access) method-access)))))
    ,(call-to-scheme
      (new-PycCall
        (PycNode-loc call)
        (new-PycStatic (PycNode-loc method-access) unbound-method-or-callback-sym unbound-method-or-callback-sym)
        (cons (new-PycStatic (PycNode-loc obj) obj-sym obj-sym) (PycCall-args call))
        %info: (PycNode-%info call)
        cps: (PycNode-cps call)
        type: (PycExpr-type call)
        keywords-values: (PycCall-keywords-values call)
        keywords-names: (PycCall-keywords-names call)
        can-be-super: (PycCall-can-be-super call))
      conf
      (cons* skipped-binding: #t params)))))

;; Dispatch

(define-macro (define-method-call-compilation-to-scheme name . body)
  (define (parse-case method-case)
    (let* ((conditional-method-name (list-ref method-case 0))
          (expected-nargs (list-ref method-case 1))
          (expected-type (list-ref method-case 2))
          (must-bind (list-ref method-case 3))
          (procedure-name (list-ref method-case 4))
          (fast-type-check (list-ref method-case 5))
          (predicate
            `(lambda (call conf params)
              (and (not (call-has-keyword-arguments? call conf params))
                   (call-has-fixed-arity? call conf params)
                   (string=? (PycAccess-field (PycCall-fun call)) ,conditional-method-name)
                   (= (length args) ,expected-nargs))))
          (code-generation
            `(let ((obj-sym (my-gensym 'self))
                   (obj-ast (PycAccess-obj fun)))
              `(let ((,obj-sym ,(scheme obj-ast conf)))
                 (if ,,(if fast-type-check
                         ``(,,fast-type-check ,obj-sym)
                         ``(py-test-is (py-obj-cls ,obj-sym) ,,expected-type))
                    ;; TODO: this duplicates the code of arguments, is that ok?
                    ,,(if must-bind
                       ``(,,procedure-name ,obj-sym ,@(map (lambda (a) (scheme a conf)) args))
                       ``(,,procedure-name ,@(map (lambda (a) (scheme a conf)) args)))
                    ,(default-call-method-with-binding-skip
                      (new-PycCall (PycNode-loc call)
                        ;; TODO abstract the copy function
                        (new-PycAccess (PycNode-loc obj-ast)
                                       (new-PycStatic (PycNode-loc fun) obj-sym obj-sym)
                                       (PycAccess-field fun)
                                       usage: (PycAccess-usage fun)
                                       cache: (PycAccess-cache fun)
                                       cps: (PycNode-cps fun)
                                       %info: (PycNode-%info fun))
                         args)
                      conf params))))))
      (list predicate code-generation)))

  (let* ((bindings
          `((fun (PycCall-fun call))
            (args (PycCall-args call))
            (keyword-values (PycCall-keywords-values call))
            (keywords-names (PycCall-keywords-names call))))
         (signature `(,name call conf params ,@bindings)))
    `(define-compilation-to-scheme ,signature
      ,@(map (lambda (c) (if (eq? (car c) 'else) c (parse-case c))) body))))

(define-method-call-compilation-to-scheme call-method-to-scheme
  ;; method-name     nargs      type               bind   procedure            ;;fast-type-check
  ("append"          1          'py-builtin-list    #t    'list-append:unsafe  #f)
  ("lower"           0          'py-builtin-str     #t    'str.lower:unsafe    'py-has-type-str?)
  (else (default-call-method-with-binding-skip call conf params)))

(define-compilation-to-scheme (call-to-scheme call conf params
                                              (fun (PycCall-fun call))
                                              (args (PycCall-args call)))
  (call-to-a-pragma?
    `(,(scheme fun conf) ,@(map (lambda (a) (scheme a conf)) args)))
  (static-call-to-global-function?
    (py-static-global-call call conf))
  ((and (not ignore-global-functions?)
        call-matches-signature-to-global-function?)
    (py-global-call call conf params))
  (call-to-an-attribute?
    (call-method-to-scheme call conf params))
  ;; NOTE: cases below must handle call-after-skipped-binding?
  ((and (not ignore-arity-check?)
        (not call-has-keyword-arguments?)
        call-has-fixed-arity?)
    (py-call-with-arity-check call conf params))
  (else
    (default-call call conf params)))

(define (PycCall-to-scheme call conf . rest)
  (if (> (length rest) 1) (error "PycCall-to-scheme" "takes 3 arguments" (length rest)))

  (let ((params (if (> (length rest) 0) (list-ref rest 0) '())))
    (call-to-scheme call conf params)))
