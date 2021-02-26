(define (pyc-usage! this conf)
  (mark-can-be-deleted! this conf)
  (mark-global-functions-usage! this conf)
  this)

(define-walk-method (mark-can-be-deleted! this::PycNode conf)
  (call-default-walker))

(define-walk-method (mark-can-be-deleted! this::PycRef conf)
  (if (eq? (PycRef-ctx this) 'Del)
    (PycVar-can-be-deleted-set! (PycRef-decl this) #t))
  this)

(define-walk-method (mark-global-functions-usage! this::PycNode conf)
  (call-default-walker))

(define-walk-method (mark-global-functions-usage! this::PycFun conf)
  (mark-body-usage! this '() conf))

(define-walk-method (mark-body-usage! this::PycNode locals-can-direct-access conf)
  (call-default-walker))

(define-walk-method (mark-body-usage! this::PycFun locals-can-direct-access conf)
  (let ((arg-vars
          (append
            (PycFun-posonlyargs this)
            (PycFun-args this)
            (PycFun-kwonlyargs this))))
    (PycFun-decorators-set!
      this
      (map (lambda (d) (mark-body-usage! d locals-can-direct-access conf)) (PycFun-decorators this)))
    (PycFun-defaults-set!
      this
      (map (lambda (d) (mark-body-usage! d locals-can-direct-access conf)) (PycFun-defaults this)))
    (PycFun-kw-defaults-set!
      this
      (map (lambda (d) (mark-body-usage! d locals-can-direct-access conf)) (PycFun-kw-defaults this)))
    (PycFun-body-set!
      this
      (mark-body-usage! (PycFun-body this) arg-vars conf))
    this))

(define-walk-method (mark-body-usage! this::PycSeq locals-can-direct-access conf)
  (let loop ((nodes (PycSeq-nodes this))
             (locals-can-direct-access locals-can-direct-access))
    (cond
      ((null? nodes)
        this)
      ((isa? (car nodes) PycAssig)
        (let ((lhs (PycAssig-lhs (car nodes)))
              (rhs (PycAssig-rhs (car nodes))))
          (if (and (isa? lhs PycRef)
                   (eq? (PycVar-scope (PycRef-decl lhs)) 'local))
            (begin
              (PycAssig-rhs-set! (car nodes) (mark-body-usage! rhs locals-can-direct-access conf))
              (loop (cdr nodes) (cons (PycRef-decl lhs) locals-can-direct-access)))
            (loop (cdr nodes) locals-can-direct-access))))
      (else
        (begin
          (set-car! nodes (mark-body-usage! (car nodes) locals-can-direct-access conf))
          (loop (cdr nodes) locals-can-direct-access))))))

(define-walk-method (mark-body-usage! this::PycRef locals-can-direct-access conf)
  (if (and (eq? (PycRef-ctx this) 'Load)
           (not (PycVar-can-be-deleted (PycRef-decl this)))
           (memq (PycRef-decl this) locals-can-direct-access))
    (PycRef-can-direct-access-set! this #t))
  this)
