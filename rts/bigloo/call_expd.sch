;*=====================================================================*/
;*    serrano/prgm/project/zipi/rts/bigloo/call_expd.sch               */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Thu Nov  5 10:30:55 2020                          */
;*    Last change :  Mon Nov  9 11:45:07 2020 (serrano)                */
;*    Copyright   :  2020 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    Macros for Python calls                                          */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    make-signature-expander                                          */
;*---------------------------------------------------------------------*/
(define (make-signature-expander x e)
   (define (constantify val)
      (match-case val
	 (((kwote quote) ())
	  '())
	 (else
	  `(constantify ,val))))
   
   (define (constantify* lst)
      (match-case lst
	 (((kwote quote) ())
	  '())
	 (else
	  `#(,@(map constantify lst)))))
   
   (match-case x
      ((make-signature ?args ?posonlyargs ?vararg ?kwonlyargs ?kw-defaults ?kwarg ?defaults)
       (e (if (or kw-defaults defaults)
	      `(vector
		  ',(constantify* args)
		  ',(constantify* posonlyargs)
		  ,(and (kwote vararg) `',(constantify vararg))
		  ,(constantify* kwonlyargs)
		  ,(or (kwote kw-defaults) ''#())
		  ,(and (kwote kwarg) `',(constantify kwarg))
		  ,(or defaults ''#()))
	      ;; signature with no default can be optimized to a constant
	      `'#(,(constantify* args)
		  ,(constantify* posonlyargs)
		  ,(and vararg (constantify vararg))
		  ,(constantify* kwonlyargs)
		  #()
		  ,(and kwarg (constantify kwarg))
		  #()))
	  e))
      (else
       (error "make-signature" "bad syntax" x))))

;*---------------------------------------------------------------------*/
;*    empty-signature-expander ...                                     */
;*---------------------------------------------------------------------*/
(define (empty-signature-expander x e)
   (match-case x
      ((empty-signature)
       (e ''#(#() #() #f #() #() #f #()) e))
      (else
       (error "empty-signature" "bad syntax" x))))

;*---------------------------------------------------------------------*/
;*    make-vararg-only-signature-expander ...                          */
;*---------------------------------------------------------------------*/
(define (make-vararg-only-signature-expander x e)
   (match-case x
      ((make-vararg-only-signature ?vararg)
       (e `(make-signature '() '() ,vararg '() #f #f #f) e))
      (else
       (error "make-vararg-only-signature" "bad syntax" x))))

;*---------------------------------------------------------------------*/
;*    make-posonly-signature-expander ...                              */
;*---------------------------------------------------------------------*/
(define (make-posonly-signature-expander x e)
   (match-case x
      ((make-posonly-signature ?posonlyargs)
       (e `(make-signature '() ,posonlyargs #f '() #f #f #f) e))
      (else
       (error "make-posonly-signature" "bad syntax" x))))

;*---------------------------------------------------------------------*/
;*    make-posonly-defaults-signature-expander ...                     */
;*---------------------------------------------------------------------*/
(define (make-posonly-defaults-signature-expander x e)
   (match-case x
      ((make-posonly-defaults-signature ?posonlyargs ?defaults)
       (e `(make-signature '() ,posonlyargs #f '() #f #f ,defaults) e))
      (else
       (error "make-posonly-defaults-signature" "bad syntax" x))))

;*---------------------------------------------------------------------*/
;*    make-args-defaults-signature-expander ...                        */
;*---------------------------------------------------------------------*/
(define (make-args-defaults-signature-expander x e)
   (match-case x
      ((make-args-defaults-signature ?args ?defaults)
       (e `(make-signature ,args '() #f '() #f #f ,defaults) e))
      (else
       (error "make-args-defaults-signature" "bad syntax" x))))

;*---------------------------------------------------------------------*/
;*    register-constants-perfect-hashtable-expander ...                */
;*---------------------------------------------------------------------*/
(define (register-constants-perfect-hashtable-expander x e)
   (match-case x
      ((register-constants-perfect-hashtable ?table)
       (vector-map
	  (lambda (e) (if (string? e) (get-PyStaticStr e) e))
	  table)
       #unspecified)
      (else
       (error "register-constants-perfect-hashtable" "bad syntax" x))))

;*---------------------------------------------------------------------*/
;*    py-call-expander ...                                             */
;*---------------------------------------------------------------------*/
(define (py-call-expander x e)
   
   (define (make-kwargs-loc-table names)
      (let* ((names-length (length names))
	     (max-table-length (* names-length 3))
	     (perfect-table-length
		(let loop ((size names-length))
		   (cond
		      ((> size max-table-length)
		       #f)
		      ;; the following condition check that there is no collision
		      ;; in a table of length 'size'
		      ((= names-length
			  (table-length
			     (list->table
				(map
				   (lambda (n) (cons (fast-range-hash (hash-FNV1a n) size) #t))
				   names))))
		       size)
		      (else
		       (loop (+ size 1)))))))
	 (if perfect-table-length
	     ;; i: index at which element will be found. The table itself is an
	     ;; index table which will be at index 0, which is why i starts at 1
	     (let loop ((names names) (i 1) (table (make-vector (* 2 perfect-table-length) #f)))
		(if (null? names)
		    table
		    (let* ((name (car names))
			   (hash (hash-FNV1a name))
			   (name-index (* 2 (fast-range-hash hash perfect-table-length))))
		       (vector-set! table name-index name)
		       (vector-set! table (+ name-index 1) i)
		       (loop (cdr names) (+ i 1) table))))
	     #f)))

   (define (make-py-call-name n)
      (string->symbol
	 (string-append
	    "py-call"
	    (number->string n))))

   (define (call-expander f args)
      (let* ((split-args
		(let loop ((args args) (acc '()))
		   (if (or (null? args) (keyword? (car args)))
		       (cons (reverse acc) args)
		       (loop (cdr args) (cons (car args) acc)))))
	     (pos-args (car split-args))
	     (split-special-args
		;; result: #(kwargs *args **kwargs)
		(let loop ((args (cdr split-args)) (acc (vector '() '() '())))
		   (cond
		      ((null? args)
		       (vector-map reverse acc))
		      ((eq? (car args) *:)
		       (begin
			  (vector-set! acc 1 (cons (cadr args) (vector-ref acc 1)))
			  (loop (cddr args) acc)))
		      ((eq? (car args) **:)
		       (begin
			  (vector-set! acc 2 (cons (cadr args) (vector-ref acc 2)))
			  (loop (cddr args) acc)))
		      (else
		       (begin
			  (vector-set! acc 0 (cons (cons (car args) (cadr args)) (vector-ref acc 0)))
			  (loop (cddr args) acc))))))
	     (kwargs (vector-ref split-special-args 0))
	     (kwargs-names (map (lambda (e) (keyword->string (car e))) kwargs))
	     (kwargs-values (map cdr kwargs))
	     (*args (vector-ref split-special-args 1))
	     (**kwargs (vector-ref split-special-args 2))
	     (kwargs-table
		(if (and (null? **kwargs) (not (null? kwargs)))
		    (make-kwargs-loc-table kwargs-names)
		    #f))
	     ;; extra-kwargs are kwargs which could not be hashed in a perfect hashtable
	     ;; at compile time, they are treated as provided in a **kwargs at run-time
	     (extra-kwargs
		(if (and (not kwargs-table) (not (null? kwargs)))
		    `(list
			,@(map
			     (lambda (name value)
				`(cons (& ,name) ,value))
			     kwargs-names
			     kwargs-values))
		    #f)))
	 
	 (cond
	    (kwargs-table
	     `(py-call-hashed-kwargs
		 ,f
		 (list ,@pos-args)
		 (list ,@*args)
		 (vector
		    (register-constants-perfect-hashtable ,kwargs-table)
		    ,@(map
			 (lambda (key value) `(cons (& ,key) ,value))
			 kwargs-names
			 kwargs-values))))
	    ((or extra-kwargs (not (null? **kwargs)))
	     `(py-call-generic-kwargs
		 ,f
		 (list ,@pos-args)
		 (list ,@*args)
		 ,(or extra-kwargs `'())
		 (list ,@**kwargs)))
	    (else
	     (let ((nargs (length pos-args)))
		(cond
		   ((not (null? *args))
		    `(py-call-generic/*args ,f (list ,@pos-args) (list ,@*args)))
		   ((<= nargs py-callX-args-limit)
		    `(,(make-py-call-name nargs) ,f ,@pos-args))
		   (else
		    `(py-call-generic ,f (list ,@pos-args)))))))))
   
   (match-case x
      ((py-call ?f . ?args)
       (e (call-expander f args) e))
      (else
       (error "py-call" "bad syntax" x))))
