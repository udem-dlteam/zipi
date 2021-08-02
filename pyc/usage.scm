(define (pyc-usage! this conf)
  (mark-can-be-deleted! this conf)
  (mark-global-functions-usage! this conf)
  (mark-global-usage! this conf)
  (mark-assig! this conf)
  (mark-access-usage! this conf)
  this)

(define-walk-method (mark-global-usage! this::PycNode conf)
  (call-default-walker))

(define-walk-method (mark-global-usage! this::PycRef conf)
  (if (PycVar-global-always-defined (PycRef-decl this))
    (PycRef-can-direct-access-set! this #t))
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
  (mark-body-usage* this '() conf)
  this)

;; mark-body-usage* annotates PycRef which can be accessed without checking if the variable is referenced before assignment
;; it returns a list of references (PycVar) which can be accessed directly after the given statement
(define-walk-method (mark-body-usage* this::PycNode locals-can-direct-access conf)
  (call-default-walker))

(define-walk-method (mark-body-usage* this::PycFun locals-can-direct-access conf)
  (let ((arg-vars
          (append
            (PycFun-posonlyargs this)
            (PycFun-args this)
            (PycFun-kwonlyargs this)
            (let ((vararg (PycFun-vararg this))) (if vararg (list vararg) '()))
            (let ((kwarg (PycFun-kwarg this))) (if kwarg (list kwarg) '()))
            )))
    (for-each (lambda (d) (mark-body-usage* d locals-can-direct-access conf)) (PycFun-decorators this))
    (for-each (lambda (d) (mark-body-usage* d locals-can-direct-access conf)) (PycFun-defaults this))
    (for-each (lambda (d) (mark-body-usage* d locals-can-direct-access conf)) (PycFun-kw-defaults this))
    (mark-body-usage* (PycFun-body this) arg-vars conf)
    locals-can-direct-access))

(define-walk-method (mark-body-usage* this::PycSeq locals-can-direct-access conf)
  (let loop ((nodes (PycSeq-nodes this))
             (locals-can-direct-access locals-can-direct-access))
    (if (null? nodes)
      locals-can-direct-access
      (loop (cdr nodes) (mark-body-usage* (car nodes) locals-can-direct-access conf)))))

(define-walk-method (mark-body-usage* this::PycAssig locals-can-direct-access conf)
  (let ((lhs (PycAssig-lhs this))
        (rhs (PycAssig-rhs this)))
    (mark-body-usage* lhs locals-can-direct-access conf)
    (mark-body-usage* rhs locals-can-direct-access conf)
    (if (and (isa? lhs PycRef)
             (eq? (PycVar-scope (PycRef-decl lhs)) 'local))
      (cons (PycRef-decl lhs) locals-can-direct-access)
      locals-can-direct-access)))

(define-walk-method (mark-body-usage* this::PycWhile locals-can-direct-access conf)
  (let ((test (PycWhile-test this))
        (body (PycLoop-body this))
        (orelse (PycLoop-else this)))
    (mark-body-usage* test locals-can-direct-access conf)
    (mark-body-usage* body locals-can-direct-access conf)
    (mark-body-usage* orelse locals-can-direct-access conf)
  locals-can-direct-access))

(define-walk-method (mark-body-usage* this::PycFor locals-can-direct-access conf)
  (let ((iter (PycFor-iter this))
        (target (PycFor-target this))
        (body (PycLoop-body this))
        (orelse (PycLoop-else this)))
    (mark-body-usage* target locals-can-direct-access conf)
    (mark-body-usage* iter locals-can-direct-access conf)
    (mark-body-usage*
      body
      (if (and (isa? target PycRef)
               (eq? (PycVar-scope (PycRef-decl target)) 'local))
          (cons (PycRef-decl target) locals-can-direct-access)
          locals-can-direct-access)
      conf)
    (mark-body-usage* orelse locals-can-direct-access conf)
  locals-can-direct-access))

(define (list-intersection l1 l2)
  (cond
    ((null? l1) '())
    ((memq (car l1) l2)
      (cons (car l1)
            (list-intersection (cdr l1) l2)))
    (else (list-intersection (cdr l1) l2))))

(define-walk-method (mark-body-usage* this::PycIf locals-can-direct-access conf)
  (let ((test (PycIf-test this))
        (then (PycIf-then this))
        (orelse (PycIf-else this)))
    (mark-body-usage* test locals-can-direct-access conf)
    (list-intersection
      (mark-body-usage* then locals-can-direct-access conf)
      (mark-body-usage* orelse locals-can-direct-access conf))))

(define-walk-method (mark-body-usage* this::PycRef locals-can-direct-access conf)
  (if (and (not (PycVar-can-be-deleted (PycRef-decl this)))
           (memq (PycRef-decl this) locals-can-direct-access))
    (PycRef-can-direct-access-set! this #t))
  locals-can-direct-access)

(define-walk-method (mark-assig! this::PycNode conf)
  (call-default-walker))

(define-walk-method (mark-assig! this::PycAssig conf)
  (let ((lhs (PycAssig-lhs this)))
    (if (isa? lhs PycRef)
      (let ((var (PycRef-decl lhs)))
        (PycVar-assig-set! var (cons this (PycVar-assig var))))))
  (call-default-walker))

(define-walk-method (mark-access-usage! this::PycNode conf)
  (call-default-walker))

(define-walk-method (mark-access-usage! this::PycBinary conf)
  (let ((lhs (PycBinary-lhs this))
        (rhs (PycBinary-rhs this)))
    (if (isa? lhs PycAccess)
      (PycAccess-usage-set! lhs this))
    (if (isa? rhs PycAccess)
      (PycAccess-usage-set! rhs this)))
  (call-default-walker))

(define-walk-method (mark-access-usage! this::PycUnary conf)
  (let ((expr (PycUnary-expr this)))
    (if (isa? expr PycAccess)
      (PycAccess-usage-set! expr this)))
  (call-default-walker))

(define-walk-method (mark-access-usage! this::PycCall conf)
  (let ((fun (PycCall-fun this)))
    (if (isa? fun PycAccess)
      (PycAccess-usage-set! fun this)))
  (call-default-walker))
