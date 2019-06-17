(define (py-javascript ast conf)
   (pyc-javascript ast conf))

(define (pyc-javascript* nodes conf)
   (map (lambda (n) (pyc-javascript n conf)) nodes))

(define (pyc-javascript+ vals decls conf)
   (let loop ((vals vals)
	      (decls decls)
	      (conf conf)
	      (acc '()))
      (if (null? vals)
	  acc
	  (loop (cdr vals) (cdr decls) (cons (car decls) conf)
	     (cons (pyc-javascript (car vals) conf) acc)))))

(define-walk-method (pyc-javascript this::PyNode env)
   (error "pyc-javascript" "Not implemented" (py->list this)))

(define-walk-method (pyc-javascript this::PyModule env)
   `(lambda (global)
       ,@(pyc-javascript* (PyModule-stmts this) (PyModule-globals this))))

