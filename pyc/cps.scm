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
  (if (PycFun-generator this)
    ;; generators do not need non-terminal return since returns are converted to cps
    (PycFun-need-return-set! this #f))

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

(define (new-PycCallKont-as-stmt loc k #!key (args '()))
  (new-PycStmtExpr
    loc
    (new-PycCallKont loc k args: args)))

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
                (new-PycCallKont-as-stmt (PycNode-loc forelse) else-kont-load)
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
                      (new-PycCallKont-as-stmt loc body-kont-load)
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
          (new-PycCallKont-as-stmt loc loop-kont-load)))
      this)))

(define-walk-method (cps-stmt this::PycBreak k kbreak kcontinue kraise)
  (new-PycCallKont-as-stmt (PycNode-loc this) kbreak))

(define-walk-method (cps-stmt this::PycContinue k kbreak kcontinue kraise)
  (new-PycCallKont-as-stmt (PycNode-loc this) kcontinue))

(define-walk-method (cps-stmt this::PycAssig k kbreak kcontinue kraise)
  (if (need-cps? this)
    (let* ((loc (PycNode-loc this))
           (lhs (PycAssig-lhs this))
           (rhs (PycAssig-rhs this))
           (rhs-var (new-kont-var 'kassig 'kont))
           (rhs-store (new-kont-ref loc rhs-var 'Store))
           (rhs-load (new-kont-ref loc rhs-var 'Load)))
      (cps-expr
        rhs
        (new-PycKont
          loc
          (list rhs-store)
          (new-PycSeq
            loc
            (list
              (new-PycAssig loc lhs rhs-load)
              (new-PycCallKont loc k))))
        kraise))
    this))

(define-walk-method (cps-stmt this::PycHandler k kbreak kcontinue kraise)
  (if (need-cps? this)
    (let* ((loc (PycNode-loc this))
	   (exc-var (new-kont-var 'exc 'kont))
	   (exc-load (new-kont-ref loc exc-var 'Load))
	   (exc-store (new-kont-ref loc exc-var 'Store)))
      (cps-expr
        (PycHandler-type this)
        (new-PycKont
          loc
          (list exc-store)
          (new-PycHandler
            loc
            (PycHandler-exc-var this)
            exc-load
            (cps-stmt (PycHandler-body this) k kbreak kcontinue kraise)))
        kraise))
    this))

;; TODO: fix code duplication in finally branches
(define-walk-method (cps-stmt this::PycTry k kbreak kcontinue kraise)
  (define (cps-handlers handlers k kbreak kcontinue kraise)
    (let* ((try-loc (PycNode-loc this))
          (handled-var (new-kont-var 'khandled 'kont))
          (handled-load (new-kont-ref try-loc handled-var 'Load))
          (handled-store (new-kont-ref try-loc handled-var 'Store)))
      (new-PycBlock
        try-loc
        (list (new-PycAssig try-loc handled-store k))
        (let loop ((handlers handlers))
            (if (null? handlers)
              (new-PycCallKont try-loc kraise args: (list (new-PycRef try-loc (PycTry-exc-var this) 'Load)))
              (let* ((handler (car handlers))
                    (handler-type (PycHandler-type handler))
                    (loc (PycNode-loc handler))
                    (exc-var (new-kont-var 'exc 'kont))
                    (exc-load (new-kont-ref loc exc-var 'Load))
                    (exc-store (new-kont-ref loc exc-var 'Store)))
                (if (isa? handler-type PycUninit)
                  (new-PycHandlerCPS
                    loc
                    (PycHandler-exc-var handler)
                    (new-PycUninit loc)
                    (cps-stmt (PycHandler-body handler) handled-load kbreak kcontinue kraise)
                    (loop '()))
                  (cps-expr
                    handler-type
                    (new-PycKont
                      loc
                      (list exc-store)
                      (new-PycHandlerCPS
                        loc
                        (PycHandler-exc-var handler)
                        exc-load
                        (cps-stmt (PycHandler-body handler) handled-load kbreak kcontinue kraise)
                        (loop (cdr handlers))))
                    kraise))))))))

  (let* (;; node attributes
         (loc (PycNode-loc this))
         (body (PycTry-body this))
         (handlers (PycTry-handlers this))
         (orelse (PycTry-else this))
         (finally (PycTry-finally this))
         ;; k continuation references
         (k-var (new-kont-var 'kont 'kont))
         (k-load (new-kont-ref loc k-var 'Load))
         (k-store (new-kont-ref loc k-var 'Store))
         ;; break continuation references
         (break-var (new-kont-var 'kbreak 'kont))
         (break-load (new-kont-ref loc break-var 'Load))
         (break-store (new-kont-ref loc break-var 'Store))
         ;; continue continuation references
         (continue-var (new-kont-var 'kcontinue 'kont))
         (continue-load (new-kont-ref loc continue-var 'Load))
         (continue-store (new-kont-ref loc continue-var 'Store))
         ;; raise continuation references
         (raise-var (new-kont-var 'kraise 'kont))
         (raise-load (new-kont-ref loc raise-var 'Load))
         (raise-store (new-kont-ref loc raise-var 'Store))
         ;; handlers continuation references
         (handlers-var (new-kont-var 'khandlers 'kont))
         (handlers-load (new-kont-ref loc handlers-var 'Load))
         (handlers-store (new-kont-ref loc handlers-var 'Store))
         ;; else continuation references
         (else-var (new-kont-var 'kelse 'kont))
         (else-load (new-kont-ref loc else-var 'Load))
         (else-store (new-kont-ref loc else-var 'Store))
         ;; finally continuation references
         (finally-var (new-kont-var 'kfinally 'kont))
         (finally-load (new-kont-ref loc finally-var 'Load))
         (finally-store (new-kont-ref loc finally-var 'Store))
         ;; ref to hold continuation to be called in finally block
         (exit-var (new-kont-var 'kexit 'kont))
         (exit-load (new-kont-ref loc exit-var 'Load))
         (exit-store (new-kont-ref loc exit-var 'Store))
         ;; else continuation references
         (exc-var (new-kont-var 'kexc 'kont))
         (exc-load (new-kont-ref loc exc-var 'Load))
         (exc-store (new-kont-ref loc exc-var 'Store))
         ;; continuations
         (finally-kont
           (new-PycKont
             loc
             (list exit-store)
             (cps-stmt finally exit-load kbreak kcontinue kraise)))
         (finally-exit
           (new-PycKont
             loc
             '()
             (new-PycCallKont loc finally-load args: (list k))))
         (finally-break
           (and
             kbreak
             (new-PycKont
               loc
               '()
               (new-PycCallKont loc finally-load args: (list kbreak)))))
         (finally-continue
           (and
             kcontinue
             (new-PycKont
               loc
               '()
               (new-PycCallKont loc finally-load args: (list kcontinue)))))
         (else-kont
           (new-PycKont
             loc
             '()
             (cps-stmt orelse finally-exit kbreak kcontinue kraise)))
         (finally-raise
           (new-PycKont
             loc
             (list exc-store)
             (cps-stmt
               finally
               (if kraise
                 (new-PycKont loc '() (new-PycCallKont loc kraise args: (list exc-load)))
                 (new-PycKont loc '() (new-PycRaise loc exc-load (new-PycUninit loc))))
               kbreak
               kcontinue
               (or kraise (new-PycKont loc (list exc-store) (new-PycRaise loc exc-load (new-PycUninit loc)))))))
         (handlers-kont
           (new-PycKont
             loc
             (list (new-PycRef loc (PycTry-exc-var this) 'Store))
             (cps-handlers handlers finally-exit finally-break finally-continue finally-raise)))
         ;; continuations assignments
         (assigs
          (append
            ;; outer continuations
            (list (new-PycAssig loc k-store k))
            (if kbreak (list (new-PycAssig loc break-store kbreak)) '())
            (if kcontinue (list (new-PycAssig loc continue-store kcontinue)) '())
            (if kraise (list (new-PycAssig loc raise-store kraise)) '())
            ;; try inner continuations
            (list (new-PycAssig loc finally-store finally-kont))
            (list (new-PycAssig loc else-store else-kont))
            (list (new-PycAssig loc handlers-store handlers-kont)))))
    (new-PycBlock
      loc
      assigs
      (cps-stmt body else-store finally-break finally-continue handlers-load))))


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

(define (make-ReturnYield-k loc k kraise)
  (let* ((var (new-kont-var 'kparam 'kont))
         (param (new-kont-ref loc var 'Store))
         (param-load (new-kont-ref loc var 'Load))
         (exc-var (new-PycVar '(-1 -1) 'exc 'block))
         (exc-load (new-PycRef loc exc-var 'Load can-direct-access: #t)))
  (if kraise
    (new-PycKont
      loc
      (list param)
      (new-PycTry
        loc
        (new-PycCallKont-as-stmt loc k args: (list param-load))
        (list
          (new-PycHandler
            loc
            exc-var
            (new-PycUninit loc)
            (new-PycCallKont-as-stmt
              loc
              kraise
              args: (list exc-load))))
        (new-PycPass loc)
        (new-PycPass loc)
        exc-var))
    k)))

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
                 (new-PycReturnYield loc param-load (make-ReturnYield-k loc k kraise) generator: #t))))
        (cps-expr val kont kraise))
      (new-PycReturnYield loc val (make-ReturnYield-k loc k kraise) generator: #t))))
