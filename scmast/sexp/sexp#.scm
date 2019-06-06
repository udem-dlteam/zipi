(define-macro (match-case expr clauses)
   
   (define (ident sym)
      (let* ((s (symbol->string sym))
	     (l (string-length s)))
	 (if (char=? (string-ref s (-fx l 2) #\?))
	     (string->symbol (substring s 0 (-fx l 1)))
	     sym)))
   
   (let ((e (gensym 'expr)))
      `(let ((,e ,expr))
	  ,@(map (lambda (clause)
		    (cond
		       ((not (pair? clause))
			(error "match-case" "illegal clause" clause))
		       ((eq? (car clause) 'else)
			clauses)
		       ((not (pair? (car clause)))
			(error "match-case" "illegal clause" clause))
		       (else
			`((,(caar clause))
			  (apply (lambda ,(map ident (car clause))
				    ,@(cdr clause))
			     ,e)))))))))

(define (tprint . args)
   (for-each display args)
   (newline))
