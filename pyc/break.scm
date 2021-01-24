;; annotate loops with need-continue and need-break
(define (pyc-break this conf)
   (mark-break-continue this)
   this)

(define-walk-method (mark-break-continue this::PycNode)
   (call-default-walker))

(define-walk-method (mark-break-continue this::PycLoop)
   (PycLoop-need-break-set! this #f)
   (PycLoop-need-continue-set! this #f)
   (breakont (PycLoop-body this) this))

;; Traverse the AST to mark loops with a break/continue
(define-walk-method (breakont this::PycNode loop)
   (call-default-walker))

;; break does not signal outside function scope
(define-walk-method (breakont this::PycFun loop)
  (mark-break-continue this))

;;
(define-walk-method (breakont this::PycLoop loop)
   (mark-break-continue this)
   ;; break/continue on the else body of a nested loop applies to the outer loop
   (breakont (PycLoop-else this) loop))

(define-walk-method (breakont this::PycBreak loop)
   (if (isa? loop PycLoop)
       (PycLoop-need-break-set! loop #t)
       (error "breakont" "Illegal break" (pyc->list this))))

(define-walk-method (breakont this::PycContinue loop)
   (if (isa? loop PycLoop)
       (PycLoop-need-continue-set! loop #t)
       (error "breakont" "Illegal continue" (pyc->list this))))
