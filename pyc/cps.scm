;; CPS transform functions that use yield
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
      (cps (cps-fun! (PycFun-body this)) #f #f #f #f this)))
  this)

;; does an expression may yield or return?
(define (yield-expr? this)
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

;; Transform CPS functions

(define (new-kont-var)
  (new-PycVar '(-1 -1) (my-gensym 'kparam) 'kont))

(define (new-kont-ref loc var ctx)
  (new-PycRef loc var ctx can-direct-access: #t))

(define-walk-method (cps this::PycNode k kbreak kcontinue kraise fun)
  (error "cps" "Should not be here" (pyc->list this)))

(define (cps* nodes k kbreak kcontinue kraise fun)
  (if (null? nodes)
    (new-PycCallKont '(-1 -1) k)
    (let* ((node (car nodes))
           (loc (PycNode-loc node))
           (tail (cps* (cdr nodes) k kbreak kcontinue kraise fun)))
      (if (yield-expr? node)
        (let ((kont
                 (new-PycKont
                   loc
                   '()
                   tail)))
          (cons (cps node kont kbreak kcontinue kraise fun) '()))
        (cons node tail)))))

(define-walk-method (cps this::PycSeq k kbreak kcontinue kraise fun)
  (new-PycSeq
    (PycNode-loc this)
    (cps* (PycSeq-nodes this) k kbreak kcontinue kraise fun)))

(define-walk-method (cps this::PycYield k kbreak kcontinue kraise fun)
  (let ((loc (PycNode-loc this))
        (val (PycYield-val this)))
    (if (yield-expr? val)
      (let* ((var (new-kont-var))
             (param (new-kont-ref loc var 'Store))
             (param-load (new-kont-ref loc var 'Load))
             (kont
               (new-PycKont
                 loc
                 (list param)
                 (new-PycReturnYield loc param-load k generator: #t))))
        (cps val kont kbreak kcontinue kraise fun))
      (new-PycReturnYield loc val k generator: #t))))

(define-walk-method (cps this::PycReturn k kbreak kcontinue kraise fun)
  (let ((loc (PycNode-loc this)))
    (if kraise
      (error "cps" "NotImplemented: return inside a try" this)
      (new-PycRaise
        loc
        (new-PycPragma loc 'py-builtin-StopIteration)
        (new-PycUninit loc)))))

(define-walk-method (cps this::PycLiteralValue k kbreak kcontinue kraise fun)
  this)

(define-walk-method (cps this::PycStmtExpr k kbreak kcontinue kraise fun)
  (call-default-walker))
