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
  (let ((var (new-PycVar id scope-to-create-if-not-exists)))
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
  (make-env-from-lst scope (apply append (map cdr envs))))

;; ================================================================
;; Replace global PycUnresolved by PycRef and return list of PycVar
;; ================================================================

(define (resolve-and-collect-globals! this)
  (let* ((global-vars (make-var-env 'global)))
    (resolve-global! this global-vars)
    global-vars))

(define-walk-method (resolve-global! this::PycNode global-vars)
  (call-default-walker))

(define-walk-method (resolve-global! this::PycRefUnresolved global-vars)
  (let ((var (env-get-or-create global-vars (PycRefUnresolved-id this) 'global)))
    (new-PycRef var (PycRefUnresolved-ctx this))))

(define-walk-method (resolve-global! this::PycFun global-vars)
  (PycFun-defaults-set!
    this
    (map (lambda (d) (resolve-global! d global-vars)) (Pyc-defaults this)))
  (PycFun-kw-defaults-set!
    this
    (map (lambda (d) (resolve-global! d global-vars)) (Pyc-kw-defaults this)))
  this)

(define-walk-method (resolve-global! this::PycClass global-vars)
  (PycClass-bases-set!
    this
    (map (lambda (d) (resolve-global! d global-vars)) (PycClass-bases this)))
  this)

;; ==================================================
;; Search functions and class to resolve their scopes
;; ==================================================

(define-walk-method (resolve-top-level! this::PycNode global-env)
  (call-default-walker))

(define (check-args-are-unique fun)
  (let ((ids
          (map
            (lambda (a) (PycVar-id a))
            (append
              (PycFun-posonlyargs this)
              (PycFun-args this)
              (PycFun-kwonlyargs this)
              (let ((vararg (PycFun-vararg this)))
                (if (PycVar? vararg) (list vararg) '()))
              (let ((kwarg (PycFun-kwarg this)))
                (if (PycVar? kwarg) (list kwarg) '()))))))
    (let loop ((ids ids))
      (if (not (null? ids))
        (if (memq (car ids) (cdr ids))
          (error "SyntaxError:" "duplicate argument in function definition:" (car ids))
          (loop (cdr ids)))))))

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
  (check-args-are-unique this)

  (let* ((args-vars (get-args-vars this))
         (local-env (make-var-env-from-lst)))
  (PycFun-body-set!
    (resolve-function-body!
      (PycFun-body this)
      global-env
      local-env
      (make-var-env 'free)))))

(define-walk-method (resolve-top-level! this::PycClass global-env)
  (PycClass-body-set!
    (resolve-class-body!
      (PycFun-body this)
      global-env
      (make-var-env 'local)
      (make-var-env 'free))))

;; ==============
;; Resolve scopes
;; ==============

(define (resolve-function-body! body global-env local-env free-env)
  (let ((conts (make-var-env 'continuations)))
    (resolve-body-assignments! body 'function global-env local-env free-env (make-var-env 'seen) conts)
    (resolve-body-refs! body 'function global-env local-env free-env)
    ;; now that the full scope has been analyzed we can recursively call nested scopes
    (for-each (lambda (cont) (cont)) conts)
    body))

(define (resolve-class-body! body global-env local-env free-env)
  (let ((conts (make-var-env 'continuations)))
    (resolve-body-assignments! body 'class global-env local-env free-env (make-var-env 'seen) conts)
    (resolve-body-refs! body 'class global-env local-env free-env)
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
            "SyntaxError:" "name '"
            (car names)
            "' is used prior to "
            (PycSymbols-scope symbols)
            " declaration"))
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
              (error "SyntaxError:" "no binding for nonlocal '" n "' found"))))
        (PycSymbols-names this)))))

(define-walk-method (resolve-body-assignments! this::PycRefUnresolved global-env kind local-env free-env seen-ids conts)
  ;; seen env is a dummy env to detect that a global or nonlocal was not called after usage
  (env-get-or-create seen-ids (PycRefUnresolved-id this) 'seen)
  (case (PycRefUnresolved-ctx this)
    ((Store Del)
      (let ((local-var (env-get-or-create local-env (PycRefUnresolved-id this) 'local)))
        (new-PycRef local-var 'Load)))
    (else this)))

(define-walk-method (resolve-body-assignments! this::PycFun kind global-env local-env free-env seen-ids conts)
  (PycFun-defaults-set!
    this
    (map
      (lambda (d)
        (resolve-body-assignments! d 'function global-env local-env free-env seen-ids conts))
      (Pyc-defaults this)))
  (PycFun-kw-defaults-set!
    this
    (map
      (lambda (d)
        (resolve-body-assignments! d 'function global-env local-env free-env seen-ids conts))
      (Pyc-kw-defaults this)))

  ;; add the function to the continuations to analyze this function once done w/ this scope
  (env-add-custom
    cont
    (lambda ()
      (check-args-are-unique this)
      (let* ((args-vars (get-args-vars this))
             (nested-local-env (make-var-env-from-lst)))
        (PycFun-body-set!
          (resolve-function-body!
            (PycFun-body this)
            global-env
            nested-local-env
            (case kind
              ((function)
                (merge-envs 'free local-env free-env))
              ((class
                free-env))
              (else
                (error "resolve-body-assignments!::::PycFun" "wrong kind of env" kind))))))))
  this)

(define-walk-method (resolve-body-assignments! this::PycClass kind global-env local-env free-env seen-ids conts)
  (PycClass-bases-set!
    this
    (map
      (lambda (d) (resolve-body-assignments! d 'class global-vars local-env free-env seen-ids conts))
      (PycClass-bases this)))
  (env-add-custom
    cont
    (lambda ()
      (PycClass-body-set!
        (resolve-class-body!
          (PycFun-body this)
          global-env
          (make-var-env 'local)
          (case kind
            ((function)
              (merge-envs 'free local-env free-env))
            ((class
              free-env))
            (else
              (error "resolve-body-assignments!::::PycFun" "wrong kind of env" kind)))))))
  this)

;; resolve for refs

(define-macro (resolve-body-refs! this::PycNode kind global-env local-env free-env)
  (call-default-walker))

(define-walk-method (resolve-body-refs! this::PycRefUnresolved kind global-env local-env free-env)
  (let ((id (PycRefUnresolved-id this)))
    (case (PycRefUnresolved-ctx this)
      ((Load)
        (let ((var (or (env-get local-env id) (env-get free-env id) (env-get global-env id))))
          (if var
            ;; link the variable to found scope
            (new-PycRef local-var 'Load)
            ;; leave variable unresolved
            this)))
      (else this))))

(define-walk-method (resolve-body-refs! this::PycFun kind global-env local-env free-env)
  (PycFun-defaults-set!
    this
    (map
      (lambda (d)
        (resolve-body-refs! d 'function global-env local-env free-env))
      (Pyc-defaults this)))
  (PycFun-kw-defaults-set!
    this
    (map
      (lambda (d)
        (resolve-body-refs! d 'function global-env local-env free-env))
      (Pyc-kw-defaults this)))
  this)

(define-walk-method (resolve-body-refs! this::PycClass kind global-env local-env free-env)
  (PycClass-bases-set!
    this
    (map (lambda (d) (resolve-body-refs! d 'class global-env local-env free-env)) (PycClass-bases this)))
  this)
