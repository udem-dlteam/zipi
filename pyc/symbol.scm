;; symbol resolution
(define (pyc-symbol! this conf)
  (let* ((global-env (resolve-and-collect-globals! this)))
    (resolve-top-level! this global-env)))

;; ================================
;; Manage compile time environments
;; ================================

(define (make-var-env-from-lst scope lst)
  (cons scope lst))

(define (make-var-env scope)
  (make-var-env-from-lst scope '()))

(define (var-env-get vars id scope-to-create-if-not-exists)
  (let ((var-lst (cdr vars)))
    (let loop ((lst var-lst))
      (if (null? lst)
        (if scope-to-create-if-not-exists
          ;; var does not exist, create an entry
          (let ((var (new-PycVar id scope-to-create-if-not-exists)))
            (set-cdr! vars (cons var var-lst)))
          #f)
        ;; look for the var in the lst
        (if (eq? (PycVar-id (car lst)) id)
          (car lst)
          (loop (cdr lst)))))))

(define (env-get vars id)
  (let ((var-lst (cdr vars)))
    (let loop ((lst var-lst))
      (if (null? lst)
        #f
        ;; look for the var in the lst
        (if (eq? (PycVar-id (car lst)) id)
          (car lst)
          (loop (cdr lst)))))))

(define (env-get-or-create vars id scope)
  (let ((var-lst (cdr vars)))
    (let loop ((lst var-lst))
      (if (null? lst)
        (env-add-id vars id scope)
        (if (eq? (PycVar-id (car lst)) id)
          (car lst)
          (loop (cdr lst)))))))

(define (env-add-id vars id scope)
  ;; Does not check for existence, use get-or-create
  ;; if you want to check if var already in env first
  (let ((var (new-PycVar id scope)))
    (env-add-PycVar vars var)))

(define (env-add-PycVar vars v)
  ;; Does not check for existence, use get-or-create
  ;; if you want to check if var already in env first
  (set-cdr! vars (cons v (cdr vars)))
  v)

(define (env-add-custom vars o)
  ;; Does not check for existence, use get-or-create
  ;; if you want to check if var already in env first
  (set-cdr! vars (cons o (cdr vars)))
  o)

(define (merge-envs scope . envs)
  (make-var-env-from-lst scope (apply append (map cdr envs))))

(define (env->list env) (cdr env))

(define (PycVar-add-usage var ref)
  (PycVar-usage-set! var (cons ref (PycVar-usage var))))

;; ================================================================
;; Replace global PycUnresolved by PycRef and return list of PycVar
;; ================================================================

(define (resolve-and-collect-globals! module)
  (let* ((global-vars (make-var-env 'global)))
    (resolve-global! module global-vars)
    (PycModule-global-defs-set! module (collect-global-defs* module))
    global-vars))

(define-walk-method (resolve-global! this::PycNode global-vars)
  (call-default-walker))

(define-walk-method (resolve-global! this::PycRefUnresolved global-vars)
  (let* ((var (env-get-or-create global-vars (PycRefUnresolved-id this) 'global))
         (ref (new-PycRef (PycNode-loc this) var (PycRefUnresolved-ctx this))))
    (PycVar-add-usage var ref)
    ref))

(define-walk-method (resolve-global! this::PycFun global-vars)
  (PycFun-defaults-set!
    this
    (map (lambda (d) (resolve-global! d global-vars)) (PycFun-defaults this)))
  (PycFun-kw-defaults-set!
    this
    (map (lambda (d) (resolve-global! d global-vars)) (PycFun-kw-defaults this)))
  this)

(define-walk-method (resolve-global! this::PycClass global-vars)
  (PycClass-bases-set!
    this
    (map (lambda (d) (resolve-global! d global-vars)) (PycClass-bases this)))
  this)

;; collect global function definitions for global call optimisation

(define-walk-method (collect-global-defs* this::PycNode)
  (call-default-walker))

(define-walk-method (collect-global-defs* this::PycClass)
  '())

(define-walk-method (collect-global-defs* this::PycAssig)
  (if (PycFun? (PycAssig-rhs this))
    (list this)
    (call-default-walker)))

;; ==================================================
;; Search functions and class to resolve their scopes
;; ==================================================

(define-walk-method (resolve-top-level! this::PycNode global-env)
  (call-default-walker))

(define (get-args-vars fun)
  (append
    (PycFun-posonlyargs fun)
    (PycFun-args fun)
    (PycFun-kwonlyargs fun)
    (let ((vararg (PycFun-vararg fun)))
      (if (PycVar? vararg) (list vararg) '()))
    (let ((kwarg (PycFun-kwarg fun)))
      (if (PycVar? kwarg) (list kwarg) '()))))

(define-walk-method (resolve-top-level! this::PycFun global-env)
  (PycFun-body-set!
    this
    (resolve-function-body!
      this
      global-env
      (make-var-env 'free)))
  this)

(define-walk-method (resolve-top-level! this::PycClass global-env)
  (PycClass-body-set!
    this
    (resolve-class-body!
      this
      (PycClass-body this)
      global-env
      (make-var-env 'free)))
  this)

;; ==============
;; Resolve scopes
;; ==============

(define (check-args-are-unique fun)
  (let ((ids
          (map
            (lambda (a) (PycVar-id a))
            (append
              (PycFun-posonlyargs fun)
              (PycFun-args fun)
              (PycFun-kwonlyargs fun)
              (let ((vararg (PycFun-vararg fun)))
                (if (PycVar? vararg) (list vararg) '()))
              (let ((kwarg (PycFun-kwarg fun)))
                (if (PycVar? kwarg) (list kwarg) '()))))))
    (let loop ((ids ids))
      (if (not (null? ids))
        (if (memq (car ids) (cdr ids))
          (error "SyntaxError:" "duplicate argument in function definition:" (car ids))
          (loop (cdr ids)))))))

(define (resolve-function-body! fun global-env free-env)
  (check-args-are-unique fun)
  (let* ((body (PycFun-body fun))
        (conts (make-var-env 'continuations))
        (args-vars (get-args-vars fun))
        (local-env (make-var-env-from-lst 'local args-vars)))
    (resolve-body-assignments! body 'function global-env local-env free-env (make-var-env 'seen) conts)
    (resolve-body-refs! body 'function global-env local-env free-env)
    ;; store function declarations
    (PycFun-decls-set! fun (env->list local-env))
    ;; now that the full scope has been analyzed we can recursively call nested scopes
    (for-each (lambda (cont) (cont)) conts)
    body))

(define (resolve-class-body! cls body global-env free-env)
  (let ((conts (make-var-env 'continuations))
        (local-env (make-var-env 'local)))
    (resolve-body-assignments! body 'class global-env local-env free-env (make-var-env 'seen) conts)
    (resolve-body-refs! body 'class global-env local-env free-env)
    ;; store class declarations
    (PycClass-decls-set! cls (env->list local-env))
    ;; now that the full scope has been analyzed we can recursively call nested scopes
    (for-each (lambda (cont) (cont)) conts)
    body))

(define-walk-method (resolve-body-assignments! this::PycNode kind global-env local-env free-env seen-ids conts)
  (call-default-walker))

(define-walk-method (resolve-body-assignments! this::PycSymbols kind global-env local-env free-env seen-ids conts)
  (define (check-usage-prior-to-declaration symbols seen-ids)
    ;; 'symbols' may be confusing here, it means a 'global' or 'nonlocal'
    (let loop ((names (PycSymbols-names symbols)))
      (cond
        ((null? names)
          #f)
        ((env-get seen-ids (car names))
          (error
            "SyntaxError:"
            "name is used prior to declaration:"
            (car names)))
        (else
          (loop (cdr names))))))

  (check-usage-prior-to-declaration this seen-ids)
  ;; At that point we are assured that the variable should not have been used yet
  ;; and so should have no PycVar in local-env
  (case (PycSymbols-scope this)
    ((global)
      (for-each
        (lambda (n)
          (let ((glo-var (env-get-or-create global-env n 'global)))
            (env-add-PycVar local-env glo-var)))
        (PycSymbols-names this)))
    ((nonlocal)
      (for-each
        (lambda (n)
          (let ((free-var (env-get free-env n)))
            (if free-var
              (env-add-PycVar local-env free-var)
              (error "SyntaxError:" "no binding for nonlocal found:" n ))))
        (PycSymbols-names this)))))

(define-walk-method (resolve-body-assignments! this::PycRefUnresolved global-env kind local-env free-env seen-ids conts)
  ;; seen env is a dummy env to detect that a global or nonlocal was not called after usage
  (env-get-or-create seen-ids (PycRefUnresolved-id this) 'seen)
  (case (PycRefUnresolved-ctx this)
    ((Store Del)
      (let* ((local-var (env-get-or-create local-env (PycRefUnresolved-id this) 'local))
            (ref (new-PycRef (PycNode-loc this) local-var 'Load)))
        (PycVar-add-usage local-var ref)
        ref))
    (else this)))

(define-walk-method (resolve-body-assignments! this::PycFun kind global-env local-env free-env seen-ids conts)
  (PycFun-defaults-set!
    this
    (map
      (lambda (d)
        (resolve-body-assignments! d 'function global-env local-env free-env seen-ids conts))
      (PycFun-defaults this)))
  (PycFun-kw-defaults-set!
    this
    (map
      (lambda (d)
        (resolve-body-assignments! d 'function global-env local-env free-env seen-ids conts))
      (PycFun-kw-defaults this)))

  ;; add the function to the continuations to analyze this function once done w/ this scope
  (env-add-custom
    conts
    (lambda ()
      (PycFun-body-set!
        this
        (resolve-function-body!
          this
          global-env
          (case kind
            ((function)
              ;; order is important, local should be on the left of the list so closest syntactic var is used
              (merge-envs 'free local-env free-env))
            ((class)
              free-env)
            (else
              (error "resolve-body-assignments!::::PycFun" "wrong kind of env" kind)))))))
  this)

(define-walk-method (resolve-body-assignments! this::PycClass kind global-env local-env free-env seen-ids conts)
  (PycClass-bases-set!
    this
    (map
      (lambda (d) (resolve-body-assignments! d 'class global-env local-env free-env seen-ids conts))
      (PycClass-bases this)))
  (env-add-custom
    conts
    (lambda ()
      (PycClass-body-set!
        this
        (resolve-class-body!
          this
          (PycClass-body this)
          global-env
          (case kind
            ((function)
              ;; order is important, local should be on the left of the list so closest syntactic var is used
              (merge-envs 'free local-env free-env))
            ((class)
              free-env)
            (else
              (error "resolve-body-assignments!::::PycFun" "wrong kind of env" kind)))))))
  this)

;; resolve for refs

(define-walk-method (resolve-body-refs! this::PycNode kind global-env local-env free-env)
  (call-default-walker))

(define-walk-method (resolve-body-refs! this::PycRefUnresolved kind global-env local-env free-env)
  (let ((id (PycRefUnresolved-id this))
        (loc (PycNode-loc this)))
    (case (PycRefUnresolved-ctx this)
      ((Load)
        (let ((var (or (env-get local-env id) (env-get free-env id) (env-get global-env id))))
          (if var
            ;; link the variable to found scope
            (let ((ref (new-PycRef loc var 'Load)))
              (PycVar-add-usage var ref)
              ref)
            ;; leave variable unresolved
            this)))
      (else this))))

(define-walk-method (resolve-body-refs! this::PycFun kind global-env local-env free-env)
  (PycFun-defaults-set!
    this
    (map
      (lambda (d)
        (resolve-body-refs! d 'function global-env local-env free-env))
      (PycFun-defaults this)))
  (PycFun-kw-defaults-set!
    this
    (map
      (lambda (d)
        (resolve-body-refs! d 'function global-env local-env free-env))
      (PycFun-kw-defaults this)))
  this)

(define-walk-method (resolve-body-refs! this::PycClass kind global-env local-env free-env)
  (PycClass-bases-set!
    this
    (map (lambda (d) (resolve-body-refs! d 'class global-env local-env free-env)) (PycClass-bases this)))
  this)
