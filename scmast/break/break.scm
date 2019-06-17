;; annotate return statements with tail/notail information
;; annotation function definitions with need-return values
(define (py-break this conf)
   (mark-nobreak-nocontinue this)
   (breakont this #f conf)
   this)

;; PyFun have been first initialized with need-breakont set to #t
;; The first stage of this optimization is to replace all this #t with #f
;; The analysis will then set to #t only functions that need to be
(define-walk-method (mark-nobreak-nocontinue this::PyNode)
   (call-default-walker))

(define-walk-method (mark-nobreak-nocontinue this::PyLoop)
   (PyLoop-need-break-set! this #f)
   (PyLoop-need-continue-set! this #f))

;; Traverse the AST to mark all non-tail breakonts and mark the functions
;; that use such breakonts
(define-walk-method (breakont this::PyNode loop conf)
   (call-default-walker))

(define-walk-method (breakont this::PyLoop loop conf)
   (breakont (PyLoop-body this) this conf)
   (breakont (PyLoop-else this) loop conf))

(define-walk-method (breakont this::PyBreak loop conf)
   (if (isa? loop PyLoop)
       (PyLoop-need-break-set! loop #t)
       (error "breakont" "Illegal break" (py->list this))))

(define-walk-method (breakont this::PyContinue loop conf)
   (if (isa? loop PyLoop)
       (PyLoop-need-continue-set! loop #t)
       (error "breakont" "Illegal continue" (py->list this))))
