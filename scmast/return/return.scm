;; annotate return statements with tail/notail information
(define (py-return this::PyNode conf)
   (return this #f #t conf))

(define-walk-method (return this::PyNode fun tail conf)
   (call-default-walker))

(define-walk-method (return this::PyStmt fun tail conf)
   (error "return" "Should not be here" (typeof this)))

(define-walk-method (return this::PySeq fun tail conf)
   (let loop ((nodes (PySeq-nodes this)))
      (if (null? (cdr nodes))
	  (return (car nodes) fun tail conf)
	  (begin
	     (return (car nodes) fun #f conf)
	     (loop (cdr nodes))))))

(define-walk-method (return this::PyIf fun tail conf)
   (return (PyIf-test this) fun #f conf)
   (return (PyIf-then this) fun tail conf)
   (return (PyIf-else this) fun tail conf))
   
(define-walk-method (return this::PyReturn fun tail conf)
   (when (and (PyFun? fun) (not tail))
      (PyFun-need-return-set! fun #t)
      (PyReturn-tail-set! this #f)))

