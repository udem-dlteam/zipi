;*=====================================================================*/
;*    serrano/prgm/project/zipi/rts/rts-call.sch                       */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Thu Nov  5 10:30:55 2020                          */
;*    Last change :  Thu Nov  5 10:30:56 2020 (serrano)                */
;*    Copyright   :  2020 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    Macros for Python calls                                          */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    signatures                                                       */
;*---------------------------------------------------------------------*/
(define-macro (make-signature args posonlyargs vararg kwonlyargs kw-defaults kwarg defaults)
   
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
   
   (if (or kw-defaults defaults)
       `'#(vector
	   ,(constantify* args)
	   ,(constantify* posonlyargs)
	   ,(and vararg `',(constantify vararg))
	   ,(constantify* kwonlyargs)
	   ,(or kw-defaults '#())
	   ,(and kwarg `',(constantify kwarg))
	   ,(or defaults '#()))
       ;; signature with no default can be optimized to a constant
       `'#(,(constantify* args)
	   ,(constantify* posonlyargs)
	   ,(and vararg (constantify vararg))
	   ,(constantify* kwonlyargs)
	   #()
	   ,(and kwarg (constantify kwarg))
	   #())))

(define-macro (empty-signature)
  ''#(#() #() #f #() #() #f #()))

(define-macro (make-vararg-only-signature vararg)
  `(make-signature '() '() ,vararg '() #f #f #f))

(define-macro (make-posonly-signature posonlyargs)
  `(make-signature '() ,posonlyargs #f '() #f #f #f))

(define-macro (make-posonly-defaults-signature posonlyargs defaults)
  `(make-signature '() ,posonlyargs #f '() #f #f ,defaults))

(define-macro (make-args-defaults-signature args defaults)
  `(make-signature ,args '() #f '() #f #f ,defaults))

(define-macro (register-constants-perfect-hashtable table)
  (vector-map
    (lambda (e) (if (string? e) (get-PyStaticStr e) e))
    table))

(define-macro (py-call f . args)
   (loadq "hash/hash.scm")
   (loadq "config/config.scm")
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
