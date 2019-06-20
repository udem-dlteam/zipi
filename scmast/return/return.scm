;; annotate return statements with tail/notail information
;; annotation function definitions with need-return values
(define (py-return this conf)
   (mark-noreturn this)
   (return this #f #t conf)
   this)

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

(define-walk-method (return this::PyBlock fun tail conf)
   (for-each (lambda (d) (return (PyDeclInit-val d) fun #f conf))
      (PyBlock-decls this))
   (return (PyBlock-body this) fun tail conf))

(define-walk-method (return this::PyAssig fun tail conf)
   (return (PyAssig-rhs this) fun #f conf)
   (return (PyAssig-lhs this) fun #f conf))

(define-walk-method (return this::PyIf fun tail conf)
   (return (PyIf-test this) fun #f conf)
   (return (PyIf-then this) fun tail conf)
   (return (PyIf-else this) fun tail conf))

(define-walk-method (return this::PyWhile fun tail conf)
   (return (PyWhile-test this) fun #f conf)
   (return (PyLoop-body this) fun #f conf)
   (return (PyLoop-else this) fun tail conf))

(define-walk-method (return this::PyReturn fun tail conf)
   (when (and (PyFun? fun) (not tail))
      (PyFun-need-return-set! fun #t)
      (PyReturn-tail-set! this #f)))

(define-walk-method (return this::PyStmtExpr fun tail conf)
   (return (PyStmtExpr-expr this) fun #f conf))

(define-walk-method (return this::PyTry fun tail conf)
   (return (PyTry-body this) fun #f conf)
   (return (PyTry-else this) fun tail conf)
   (return (PyTry-finally this) fun #f conf)
   (for-each (lambda (h) (return (PyHandler-body h) fun tail conf))
      (PyTry-handlers this)))

(define-walk-method (return this::PyPass fun tail conf)
   #f)

(define-walk-method (return this::PyBreak fun tail conf)
   #f)

(define-walk-method (return this::PyContinue fun tail conf)
   #f)
