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

;; Transform CPS functions

(define (new-kont-var id scope)
  (new-PycVar '(-1 -1) (my-gensym id) scope))

(define (new-kont-ref loc var ctx)
  (new-PycRef loc var ctx can-direct-access: #t))

(define-walk-method (cps this::PycNode k kbreak kcontinue kraise fun)
  (error "cps" "Unimplemented form for generators" (pyc->list this)))

(define (cps* nodes k kbreak kcontinue kraise fun)
  (if (null? nodes)
    (list (new-PycCallKont '(-1 -1) k))
    (let* ((node (car nodes))
           (loc (PycNode-loc node))
           (tail (cps* (cdr nodes) k kbreak kcontinue kraise fun)))
      (if (need-cps? node)
        (let ((kont
                 (new-PycKont
                   loc
                   '()
                   (new-PycSeq loc tail))))
          (cons (cps node kont kbreak kcontinue kraise fun) '()))
        (cons node tail)))))

(define-walk-method (cps this::PycSeq k kbreak kcontinue kraise fun)
  (new-PycSeq
    (PycNode-loc this)
    (cps* (PycSeq-nodes this) k kbreak kcontinue kraise fun)))

(define-walk-method (cps this::PycYield k kbreak kcontinue kraise fun)
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
  (if (need-cps? this)
    (let* ((loc (PycNode-loc this))
           (var (new-kont-var 'unused-kparam 'kont))
           (param (new-kont-ref loc var 'Store))
           (kont
             (new-PycKont
               loc
               (list param)
               (new-PycCallKont loc k))))
      (cps (PycStmtExpr-expr this) kont kbreak kcontinue kraise fun))
    this))

(define-walk-method (cps this::PycIf k kbreak kcontinue kraise fun)
  (let* ((loc (PycNode-loc this))
         (test (PycIf-test this))
         (then (PycIf-then this))
         (orelse (PycIf-else this))
         (test-need-cps (need-cps? test))
         (then-need-cps (need-cps? then))
         (orelse-need-cps (need-cps? orelse))
         (body-need-cps (or then-need-cps orelse-need-cps)))
    (cond
      ((and test-need-cps body-need-cps)
        (let* ((kparam-var (new-kont-var 'kparam 'kont))
              (kparam-store (new-kont-ref loc kparam-var 'Store))
              (kparam-load (new-kont-ref loc kparam-var 'Load)))
        (cps
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
                  (cps then kont-load kbreak kcontinue kraise fun)
                  (cps orelse kont-load kbreak kcontinue kraise fun)))))
          kbreak kcontinue kraise fun)))
      ((and test-need-cps (not body-need-cps))
        (let* ((kparam-var (new-kont-var 'kparam 'kont))
              (kparam-store (new-kont-ref loc kparam-var 'Store))
              (kparam-load (new-kont-ref loc kparam-var 'Load)))
        (cps
          test
          (new-PycKont
            loc
            (list kparam-store)
            (new-PycSeq
              loc
              (list
                (new-PycIf loc kparam-load then orelse)
                (new-PycCallKont loc k))))
          kbreak kcontinue kraise fun)))
      ((and (not test-need-cps) body-need-cps)
        (let* ((kont-var (new-kont-var 'kont 'block))
              (kont-store (new-kont-ref loc kont-var 'Store))
              (kont-load (new-kont-ref loc kont-var 'Load)))
          (new-PycBlock
            loc
            (list (new-PycAssig loc kont-store k))
            (new-PycIf
              loc
              test
              (cps then kont-load kbreak kcontinue kraise fun)
              (cps orelse kont-load kbreak kcontinue kraise fun)))))
      (else
        this))))
