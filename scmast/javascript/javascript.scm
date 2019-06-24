(define (pyc-javascript ast conf)
   (javascript ast conf))

(define (javascript* nodes conf)
   (map (lambda (n) (javascript n conf)) nodes))

(define (javascript+ vals decls conf)
   (let loop ((vals vals)
	      (decls decls)
	      (conf conf)
	      (acc '()))
      (if (null? vals)
	  acc
	  (loop (cdr vals) (cdr decls) (cons (car decls) conf)
	     (cons (javascript (car vals) conf) acc)))))

(define-walk-method (javascript this::PycNode env)
   (error "javascript" "Not implemented" (pyc->list this)))

(define-walk-method (javascript this::PycModule env)
   `(lambda (global)
       ,@(javascript* (PycModule-stmts this) (PycModule-globals this))))

