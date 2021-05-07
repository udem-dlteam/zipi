;; cps-stmt transform functions that use yield
;; This pass assumes that the GENERATOR pass has already execute
;; and so generator function are alread marked
(define (pyc-cps this conf)
  (mark-need-cps* this #f #f)
  (cps-fun! this))

(define-walk-method (cps-fun! this::PycNode)
  (call-default-walker))

(define-walk-method (cps-fun! this::PycFun)
  (if (PycFun-generator this)
    (PycFun-body-set!
      this
      (cps-stmt (cps-fun! (PycFun-body this)) 'not-a-continuation-placeholder #f #f #f)))
  this)

;; does an expression need cps
(define-walk-method (mark-need-cps* this::PycNode return-need-cps break-continue-need-cps)
  (let loop ((children-need-cps (call-default-walker)))
    (cond
      ((null? children-need-cps)
        '(#f))
      ((car children-need-cps)
        (PycNode-cps-set! this #t)
        '(#t))
      (else
        (loop (cdr children-need-cps))))))

(define-walk-method (mark-need-cps* this::PycFun return-need-cps break-continue-need-cps)
  (mark-need-cps* (PycFun-body this) (PycFun-generator this) #f)
  (let loop ((default-need-cps
              (apply append
                (map
                  (lambda (d) (mark-need-cps* d return-need-cps break-continue-need-cps))
                  (append (PycFun-defaults this) (PycFun-kw-defaults this))))))
    (cond
      ((null? default-need-cps)
        '(#f))
      ((car default-need-cps)
        (PycNode-cps-set! this #t)
        '(#t))
      (else
        (loop (cdr default-need-cps))))))

(define-walk-method (mark-need-cps* this::PycLoop return-need-cps break-continue-need-cps)
  (let loop ((children-need-cps (call-default-walker)))
    (cond
      ((null? children-need-cps)
        '(#f))
      ((car children-need-cps)
        (mark-need-cps* (PycLoop-body this) return-need-cps #t)
        (PycNode-cps-set! this #t)
        '(#t))
      (else
        (loop (cdr children-need-cps))))))

(define-walk-method (mark-need-cps* this::PycYield return-need-cps break-continue-need-cps)
  (call-default-walker)
  (PycNode-cps-set! this #t)
  '(#t))

(define-walk-method (mark-need-cps* this::PycBreak return-need-cps break-continue-need-cps)
  (PycNode-cps-set! this break-continue-need-cps)
  (list break-continue-need-cps))

(define-walk-method (mark-need-cps* this::PycContinue return-need-cps break-continue-need-cps)
  (PycNode-cps-set! this break-continue-need-cps)
  (list break-continue-need-cps))

(define-walk-method (mark-need-cps* this::PycReturn return-need-cps break-continue-need-cps)
  (PycNode-cps-set! this return-need-cps)
  (cons return-need-cps (call-default-walker)))

(define (need-cps? this)
  (PycNode-cps this))

;; Transform generators statements to cps

(define (new-kont-var id scope)
  (new-PycVar '(-1 -1) id scope))

(define (new-kont-ref loc var ctx)
  (new-PycRef loc var ctx can-direct-access: #t))

(define-walk-method (cps-stmt this::PycNode k kbreak kcontinue kraise)
  (error "cps-stmt" "should not be called on this" (pyc->list this)))

(define-walk-method (cps-stmt this::PycStmt k kbreak kcontinue kraise)
  (cond
    ((not k)
      this)
    ((not (need-cps? this))
      (new-PycSeq
        (PycNode-loc this)
        (list
          this
          (new-PycCallKont (PycNode-loc this) k))))
    (else
      (error "cps-expr" "Unimplemented statement for generators" (pyc->list this)))))

(define-walk-method (cps-stmt this::PycPass k kbreak kcontinue kraise)
  (if (not k)
    this
    (new-PycCallKont (PycNode-loc this) k)))

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

(define-walk-method (cps-stmt this::PycReturn k kbreak kcontinue kraise)
  ;; TODO: return the value
  (let ((loc (PycNode-loc this)))
    (if kraise
      (error "cps-stmt" "NotImplemented: return inside a try" this)
      (new-PycRaise
        loc
        (new-PycPragma loc 'py-builtin-StopIteration)
        (new-PycUninit loc)))))

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
      (let* ((kparam-var (new-kont-var 'ktest 'kont))
            (kparam-store (new-kont-ref loc kparam-var 'Store))
            (kparam-load (new-kont-ref loc kparam-var 'Load)))
        (cps-expr
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
          kraise))
        this)))

(define-walk-method (cps-stmt this::PycFor k kbreak kcontinue kraise)
  (let* ((loc (PycNode-loc this))
         (target (PycFor-target this))
         (iter (PycFor-iter this))
         (body (PycLoop-body this))
         (forelse (PycLoop-else this)))
    (if (or (need-cps? iter) (need-cps? body) (need-cps? forelse))
      (let* ((cps-loop-kont-var (new-kont-var 'cps-for-loop 'kont))
             (cps-loop-kont-load (new-kont-ref loc cps-loop-kont-var 'Load))
             (kiter-var (new-kont-var 'kiter 'kont))
             (kiter-store (new-kont-ref loc kiter-var 'Store))
             (kiter-load (new-kont-ref loc kiter-var 'Load))
             (kont-var (new-kont-var 'kont 'block))
             (kont-store (new-kont-ref loc kont-var 'Store))
             (kont-load (new-kont-ref loc kont-var 'Load))
             (else-kont-var (new-kont-var 'else-kont 'block))
             (else-kont-store (new-kont-ref loc else-kont-var 'Store))
             (else-kont-load (new-kont-ref loc else-kont-var 'Load)))
        (cps-expr
          iter
          (new-PycKont
            loc
            (list kiter-store)
            (new-PycBlock
              loc
              (list
                ;; continuation for next stmt
                (new-PycAssig
                  loc
                  kont-store
                  k)
                ;; continuation for else block
                (new-PycAssig
                  loc
                  else-kont-store
                  (new-PycKont
                    loc
                    '()
                    (cps-stmt forelse kont-load kbreak kcontinue kraise))))
              (new-PycCPSFor
                loc
                (cps-stmt body cps-loop-kont-load kont-load cps-loop-kont-load kraise)
                (new-PycCallKont (PycNode-loc forelse) else-kont-load)
                target
                kiter-load
                cps-loop-kont-var
                else-kont-var)))
          kraise))
      this)))

(define-walk-method (cps-stmt this::PycWhile k kbreak kcontinue kraise)
  (let* ((loc (PycNode-loc this))
         (test (PycWhile-test this))
         (body (PycLoop-body this))
         (whileelse (PycLoop-else this)))
    (if (or (need-cps? test) (need-cps? body) (need-cps? whileelse))
      (let* ((kont-var (new-kont-var 'kont 'kont))
             (kont-store (new-kont-ref loc kont-var 'Store))
             (kont-load (new-kont-ref loc kont-var 'Load))
             (loop-kont-var (new-kont-var 'cps-while-loop 'kont))
             (loop-kont-store (new-kont-ref loc loop-kont-var 'Store))
             (loop-kont-load (new-kont-ref loc loop-kont-var 'Load))
             (body-kont-var (new-kont-var 'cps-while-body 'kont))
             (body-kont-store (new-kont-ref loc body-kont-var 'Store))
             (body-kont-load (new-kont-ref loc body-kont-var 'Load))
             (else-kont-var (new-kont-var 'cps-while-else 'kont))
             (else-kont-store (new-kont-ref loc else-kont-var 'Store))
             (else-kont-load (new-kont-ref loc else-kont-var 'Load))
             (ktest-var (new-kont-var 'ktest 'kont))
             (ktest-store (new-kont-ref loc ktest-var 'Store))
             (ktest-load (new-kont-ref loc ktest-var 'Load)))
        (new-PycBlock
          loc
          (list
            ;; next stmt
            (new-PycAssig
              loc
              kont-store
              k)
            ;; loop
            (new-PycAssig
              loc
              loop-kont-store
              (new-PycKont
                loc
                '()
                (cps-expr
                  test
                  (new-PycKont
                    loc
                    (list ktest-store)
                    (new-PycIf
                      loc
                      ktest-load
                      (new-PycCallKont loc body-kont-load)
                      (cps-stmt whileelse kont-load kbreak kcontinue kraise)))
                  kraise)))
            ;; body
            (new-PycAssig
              loc
              body-kont-store
              (new-PycKont
                loc
                '()
                (cps-stmt body loop-kont-load kont-load loop-kont-load kraise)))
            ;; else
            (new-PycAssig
              loc
              else-kont-store
              (new-PycKont
                loc
                '()
                (cps-stmt whileelse kont-load kbreak kcontinue kraise))))
          (new-PycCallKont loc loop-kont-load)))
      this)))

(define-walk-method (cps-stmt this::PycBreak k kbreak kcontinue kraise)
  (new-PycCallKont (PycNode-loc this) kbreak))

(define-walk-method (cps-stmt this::PycContinue k kbreak kcontinue kraise)
  (new-PycCallKont (PycNode-loc this) kcontinue))

;; transform generators expressions to cps

(define-walk-method (cps-expr this::PycNode k kraise)
  (error "cps-expr" "should not be called on statements" (pyc->list this)))

(define-walk-method (cps-expr this::PycExpr k kraise)
  (cond
    ((not k)
      this)
    ((not (need-cps? this))
      (new-PycCallKont (PycNode-loc this) k args: (list this)))
    (else
      (error "cps-expr" "Unimplemented expression for generators" (pyc->list this)))))

(define-walk-method (cps-expr this::PycYield k kraise)
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
        (cps-expr val kont kraise))
      (new-PycReturnYield loc val k generator: #t))))
