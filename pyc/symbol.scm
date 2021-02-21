;; symbol resolution
(define (pyc-symbol! this conf)
  (let* ((global-env (resolve-and-collect-globals! this)))
    (resolve-top-level! this global-env)))

;; ================================
;; Manage compile time environments
;; ================================

(define (make-var-store-from-lst scope lst)
  (cons scope lst))

(define (make-var-store scope)
  (make-var-store-from-lst scope '()))

(define (var-store-get vars id scope create-if-not-exists)
  (if (eq? scope (car vars))
    (let ((var-lst (cdr vars)))
      (let loop ((lst var-lst))
        (if (null? lst)
          (if create-if-not-exists
            ;; var does not exist, create an entry
            (let ((var (new-PycVar id scope)))
              (set-cdr! vars (cons var var-lst)))
            #f)
          ;; look for the var in the lst
          (if (eq? (PycVar-id (car lst)) id)
            (car lst)
            (loop (cdr lst)))))))
    (error "var-store-get" "attempting to get var from wrong store" (car vars) scope))

(define (global-store-get vars id)
  (var-store-get vars id 'global #f)

(define (global-store-get-or-create vars id)
  (var-store-get vars id 'global #t)

(define (local-store-get vars id)
  (var-store-get vars id 'local #f)

(define (local-store-get-or-create vars id)
  (var-store-get vars id 'local #t)

(define (free-store-get vars id)
  (var-store-get vars id 'free #f)

;; class scope is special in the sense that it declarations in this scope
;; cannot be accessed from a closure
(define (class-store-get vars id)
  (var-store-get vars id 'class)

;; ================================================================
;; Replace global PycUnresolved by PycRef and return list of PycVar
;; ================================================================

(define (resolve-and-collect-globals! this)
  (let* ((global-vars (make-var-store 'global)))
    (resolve-global! this global-vars)
    global-vars))

(define-walk-method (resolve-global! this::PycNode global-vars)
  (call-default-walker))

(define-walk-method (resolve-global! this::PycRefUnresolved global-vars)
  (let ((var (global-store-get-or-create global-vars (PycRefUnresolved-id this))))
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
         (local-env (make-var-store-from-lst)))
  (PycFun-body-set!
    (resolve-function-body!
      (PycFun-body this)
      global-env
      local-env
      (make-var-store 'free)))))

(define-walk-method (resolve-top-level! this::PycFun global-env)
  (check-args-are-unique this)
  (PycClass-body-set!
    (resolve-class-body!
      (PycFun-body this)
      global-env
      (make-var-store 'local)
      (make-var-store 'free)))))

;; ======================
;; Resolve function scope
;; ======================

(define-walk-method (resolve-function-body! this::PycNode global-env local-env free-env)
  (call-default-walker))


;; ======================
;; Resolve class scope
;; ======================

(define-walk-method (resolve-class-body! this::PycNode global-env local-env free-env)
  (call-default-walker))
