(define-macro (match-case expr . clauses)
   
   (define (ident sym)
      (let* ((s (symbol->string sym))
	     (l (string-length s)))
	 (if (char=? (string-ref s 0) #\?)
	     (string->symbol (substring s 1))
	     sym)))

   (define (idents x)
     (cond ((symbol? x)
            (ident x))
           ((pair? x)
            (cons (idents (car x))
                  (idents (cdr x))))
           (else
            x)))
   (let ((e (gensym 'expr)))
     `(let ((,e ,expr))
        (case (car ,e)
	  ,@(map (lambda (clause)
		    (cond
		       ((not (pair? clause))
			(error "match-case" "illegal clause" clause))
		       ((eq? (car clause) 'else)
			`(else
                          ,@(cdr clause)))
		       ((not (pair? (car clause)))
			(error "match-case" "illegal clause" clause))
		       (else
			`((,(caar clause))
			  (apply (lambda ,(idents (car clause))
				   ,@(cdr clause))
			         ,e)))))
                 clauses)))))

(define (tprint . args)
   (for-each display args)
   (newline))
