;; cps-stmt transform functions that use yield
;; This pass assumes that the GENERATOR pass has already execute
;; and so generator function are alread marked
(define (pyc-cps this conf)
   (cps-fun! this))

(define-walk-method (cps-fun! this::PycNode)
  (call-default-walker))

(define-walk-method (cps-fun! this::PycFun)
  (if (PycFun-generator this)
    (PycFun-body-set!
      this
      (cps-stmt (cps-fun! (PycFun-body this)) #f #f #f #f)))
  this)

;; does an expression need cps
(define (need-cps? this)
  (let ((v (yield-expr* this)))
    (if (null? v) #f v)))

(define-walk-method (yield-expr* this::PycNode)
   (call-default-walker))

(define-walk-method (yield-expr* this::PycYield)
   (list this))

(define-walk-method (yield-expr* this::PycReturn)
   (list this))

(define-walk-method (yield-expr* this::PycFun)
   '())

;; Transform generators statements to cps

(define (new-kont-var id scope)
  (new-PycVar '(-1 -1) (my-gensym id) scope))

(define (new-kont-ref loc var ctx)
  (new-PycRef loc var ctx can-direct-access: #t))

(define-walk-method (cps-stmt this::PycNode k kbreak kcontinue kraise)
  (error "cps-stmt" "Unimplemented statement for generators" (pyc->list this)))

(define-walk-method (cps-stmt this::PycExpr k kbreak kcontinue kraise)
  (cps-expr this k kraise))

(define (cps-stmt* nodes k kbreak kcontinue kraise)
  (if (null? nodes)
    (list (new-PycCallKont '(-1 -1) k))
    (let* ((node (car nodes))
           (loc (PycNode-loc node))
           (tail (cps-stmt* (cdr nodes) k kbreak kcontinue kraise)))
      (if (need-cps? node)
        (let ((kont
                 (new-PycKont
                   loc
                   '()
                   (new-PycSeq loc tail))))
          (cons (cps-stmt node kont kbreak kcontinue kraise) '()))
        (cons node tail)))))

(define-walk-method (cps-stmt this::PycSeq k kbreak kcontinue kraise)
  (new-PycSeq
    (PycNode-loc this)
    (cps-stmt* (PycSeq-nodes this) k kbreak kcontinue kraise)))

(define-walk-method (cps-stmt this::PycYield k kbreak kcontinue kraise)
  (let ((loc (PycNode-loc this))
        (val (PycYield-val this)))
    (if (need-cps? val)
      (let* ((var (new-kont-var 'kparam 'kont))
             (param (new-kont-ref loc var 'Store))
             (param-load (new-kont-ref loc var 'Load))
             (kont
               (new-PycKont
                 loc
                 (list param)
                 (new-PycReturnYield loc param-load k generator: #t))))
        (cps-stmt val kont kbreak kcontinue kraise))
      (new-PycReturnYield loc val k generator: #t))))

(define-walk-method (cps-stmt this::PycReturn k kbreak kcontinue kraise)
  (let ((loc (PycNode-loc this)))
    (if kraise
      (error "cps-stmt" "NotImplemented: return inside a try" this)
      (new-PycRaise
        loc
        (new-PycPragma loc 'py-builtin-StopIteration)
        (new-PycUninit loc)))))

(define-walk-method (cps-stmt this::PycLiteralValue k kbreak kcontinue kraise)
  (if k
    (new-PycCallKont (PycNode-loc this) k args: (list this))
    this))

(define-walk-method (cps-stmt this::PycStmtExpr k kbreak kcontinue kraise)
  (if (need-cps? this)
    (let* ((loc (PycNode-loc this))
           (var (new-kont-var 'unused-kparam 'kont))
           (param (new-kont-ref loc var 'Store))
           (kont
             (new-PycKont
               loc
               (list param)
               (new-PycCallKont loc k))))
      (cps-expr (PycStmtExpr-expr this) kont kraise))
    this))

(define-walk-method (cps-stmt this::PycIf k kbreak kcontinue kraise)
  (let* ((loc (PycNode-loc this))
         (test (PycIf-test this))
         (then (PycIf-then this))
         (orelse (PycIf-else this)))
    (if (need-cps? this)
      (let* ((kparam-var (new-kont-var 'kparam 'kont))
            (kparam-store (new-kont-ref loc kparam-var 'Store))
            (kparam-load (new-kont-ref loc kparam-var 'Load)))
      (cps-stmt
        test
        (new-PycKont
          loc
          (list kparam-store)
          (let* ((kont-var (new-kont-var 'kont 'block))
                (kont-store (new-kont-ref loc kont-var 'Store))
                (kont-load (new-kont-ref loc kont-var 'Load)))
            (new-PycBlock
              loc
              (list (new-PycAssig loc kont-store k))
              (new-PycIf
                loc
                kparam-load
                (cps-stmt then kont-load kbreak kcontinue kraise)
                (cps-stmt orelse kont-load kbreak kcontinue kraise)))))
        kbreak kcontinue kraise))
        this)))

(define-walk-method (cps-stmt  this::PycFor k kbreak kcontinue kraise)
  (let* ((loc (PycNode-loc this))
         (target (PycFor-target this))
         (iter (PycFor-target this))
         (body (PycLoop-body this))
         (forelse (PycLoop-else this)))
    this))

;; transforme generators expressions to cps

(define-walk-method (cps-expr this::PycNode k kraise)
  (error "cps-expr" "should not be called on statements" (pyc->list this)))

(define-walk-method (cps-expr this::PycNode k kraise)
  (cond
    ((not k)
      this)
    ((not (need-cps? this))
      (new-PycCallKont (PycNode-loc this) k args: (list this)))
    (else
      (error "cps-expr" "Unimplemented expression for generators" (pyc->list this)))))
