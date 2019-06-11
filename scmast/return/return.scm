;; annotate return statements with tail/notail information
;; annotation function definitions with need-return values
(define (py-return this::PyNode conf)
   (mark-noreturn this)
   (return this #f #t conf))

;; PyFun have been first initialized with need-return set to #t
;; The first stage of this optimization is to replace all this #t with #f
;; The analysis will then set to #t only functions that need to be
(define-walk-method (mark-noreturn this::PyNode)
   (call-default-walker))

(define-walk-method (mark-noreturn this::PyFun)
   (PyFun-need-return-set! this #f))

;; Traverse the AST to mark all non-tail returns and mark the functions
;; that use such returns
(define-walk-method (return this::PyNode fun tail conf)
   (call-default-walker))

(define-walk-method (return this::PyStmt fun tail conf)
   (error "return" "Should not be here" (typeof this)))

(define-walk-method (return this::PySeq fun tail conf)
   (let loop ((nodes (PySeq-nodes this)))
      (cond
	 ((null? (cdr nodes))
	  (return (car nodes) this tail conf))
	 ((PyReturn? (car nodes))
	  (set-cdr! nodes '())
	  (return (car nodes) this tail conf))
	 (else
	  (return (car nodes) this #f conf)
	  (loop (cdr nodes))))))

(define-walk-method (return this::PyIf fun tail conf)
   (return (PyIf-test this) fun #f conf)
   (return (PyIf-then this) fun tail conf)
   (return (PyIf-else this) fun tail conf))
   
(define-walk-method (return this::PyReturn fun tail conf)
   (when (and (PyFun? fun) (not tail))
      (PyFun-need-return-set! fun #t)
      (PyReturn-tail-set! this #f)))

