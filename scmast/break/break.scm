;; annotate return statements with tail/notail information
;; annotation function definitions with need-return values
(define (py-break this conf)
   (mark-nobreak-nocontinue this)
   (breakont this #f conf)
   this)

;; PycFun have been first initialized with need-breakont set to #t
;; The first stage of this optimization is to replace all this #t with #f
;; The analysis will then set to #t only functions that need to be
(define-walk-method (mark-nobreak-nocontinue this::PycNode)
   (call-default-walker))

(define-walk-method (mark-nobreak-nocontinue this::PycLoop)
   (PycLoop-need-break-set! this #f)
   (PycLoop-need-continue-set! this #f))

;; Traverse the AST to mark all non-tail breakonts and mark the functions
;; that use such breakonts
(define-walk-method (breakont this::PycNode loop conf)
   (call-default-walker))

(define-walk-method (breakont this::PycLoop loop conf)
   (breakont (PycLoop-body this) this conf)
   (breakont (PycLoop-else this) loop conf))

(define-walk-method (breakont this::PycBreak loop conf)
   (if (isa? loop PycLoop)
       (PycLoop-need-break-set! loop #t)
       (error "breakont" "Illegal break" (py->list this))))

(define-walk-method (breakont this::PycContinue loop conf)
   (if (isa? loop PycLoop)
       (PycLoop-need-continue-set! loop #t)
       (error "breakont" "Illegal continue" (py->list this))))
