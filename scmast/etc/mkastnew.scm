;*=====================================================================*/
;*    serrano/nosync/py19/scmast/etc/mknew.scm                         */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Mon Jun 17 08:56:38 2019                          */
;*    Last change :                                                    */
;*    Copyright   :  2019 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    Create AST new functions (constructors with optional args).      */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module mkastnew
   (main main))

;*---------------------------------------------------------------------*/
;*    main ...                                                         */
;*---------------------------------------------------------------------*/
(define (main argv)
   (if (null? (cdr argv))
       (mkastnew (current-input-port))
       (call-with-input-file (cadr argv)
	  (lambda (ip)
	     (mkastnew ip
		(when (pair? (cddr argv))
		   (call-with-input-string (caddr argv) read)))))))

;*---------------------------------------------------------------------*/
;*    mkastnew ...                                                     */
;*---------------------------------------------------------------------*/
(define (mkastnew port mod)
   (let* ((expr (read port))
	  (env (collect-classes expr)))
      (match-case expr
	 ((module ?name . ?clauses)
	  (let ((funs (append-map (match-lambda
				     ((export . ?exports)
				      (filter-map (match-lambda
						     ((class ?name . ?props)
						      (new-class name props env))
						     ((final-class ?name . ?props)
						      (new-class name props env))
						     (else
						      #f))
					 exports))
				     (else
				      '()))
			 clauses)))
	     (cond
		((pair? mod)
		 (print ";; generated file, don't edit")
		 (display-module mod funs))
		((eq? mod 'directives)
		 (print ";; generated file, don't edit")
		 (display-directives funs)
		 (newline)
		 (for-each display-definition funs))
		(else
		 (print ";; generated file, don't edit")
		 (for-each display-definition funs)))))
	 (else
	  (error "mkastnew" "bad module syntax" expr)))))

;*---------------------------------------------------------------------*/
;*    symbol-id ...                                                    */
;*---------------------------------------------------------------------*/
(define (symbol-id p)
   (let ((s (symbol->string p)))
      (let ((i (string-index s #\:)))
	 (if i
	     (string->symbol (substring s 0 i))
	     p))))

;*---------------------------------------------------------------------*/
;*    symbol-type ...                                                  */
;*---------------------------------------------------------------------*/
(define (symbol-type p)
   (let ((s (symbol->string p)))
      (let ((i (string-index s #\:)))
	 (when i
	    (string->symbol (substring s (+fx i 2) (string-length s)))))))

;*---------------------------------------------------------------------*/
;*    collect-classes ...                                              */
;*---------------------------------------------------------------------*/
(define (collect-classes expr)

   (define (def-class name props)
      (let ((kla (symbol-id name))
	    (sup (symbol-type name)))
	 `(,kla ,sup ,props)))
      
   (match-case expr
      ((module ?name . ?clauses)
       (append-map (match-lambda
		      ((export . ?exports)
		       (filter-map (match-lambda
				      ((class ?name . ?props)
				       (def-class name props))
				      ((abstract-class ?name . ?props)
				       (def-class name props))
				      ((final-class ?name . ?props)
				       (def-class name props))
				      (else
				       #f))
			  exports))
		      (else
		       '()))
	  clauses))
      (else
       (error "mkastnew" "bad module syntax" expr))))

;*---------------------------------------------------------------------*/
;*    new-class ...                                                    */
;*---------------------------------------------------------------------*/
(define (new-class name props env)
   
   (define (find-default p)
      (let loop ((attrs (cdr p)))
	 (when (pair? attrs)
	    (match-case (car attrs)
	       ((default ?val) (car attrs))
	       (else (loop (cdr attrs)))))))
   
   (define (super-class-props id env)
      (let loop ((props '())
		 (id id))
	 (let* ((def (assq id env))
		(props (append (caddr def) props )))
	    (if (not (cadr def))
		props
		(loop props (cadr def))))))
   
   (let* ((id (symbol-id name))
	  (props (super-class-props id env))
	  (names (map (lambda (p)
			 (if (symbol? p)
			     (symbol-id p)
			     (symbol-id (car p))))
		    props))
	  (fixs (filter-map (lambda (p)
			       (cond
				  ((symbol? p) (symbol-id p))
				  ((not (find-default p)) (symbol-id (car p)))
				  (else #f)))
		   props))
	  (opts (filter-map (lambda (p)
			       (when (pair? p)
				  (let ((d (find-default p)))
				     (when d
					(list (symbol-id (car p)) (cadr d))))))
		   props)))
      (if (pair? opts)
	  `(define-inline (,(symbol-append 'new- id) ,@fixs #!key ,@opts)
	      (,(symbol-append 'make- id) ,@names))
	  `(define-inline (,(symbol-append 'new- id) ,@fixs)
	      (,(symbol-append 'make- id) ,@names)))))

;*---------------------------------------------------------------------*/
;*    display-module ...                                               */
;*---------------------------------------------------------------------*/
(define (display-module mod funs)
   (print "(module " (cadr mod))
   (for-each (lambda (c) (printf "   ~s\n" c)) (cddr mod))
   (print "   (export")
   (for-each (lambda (funs)
		(print "      " `(inline ,@(cadr funs))))
      funs)
   (print "      ))"))

;*---------------------------------------------------------------------*/
;*    display-directives ...                                           */
;*---------------------------------------------------------------------*/
(define (display-directives funs)
   (print "(directives")
   (for-each (lambda (funs)
		(print "   " `(inline ,@(cadr funs))))
      funs)
   (print "   ))"))
   
;*---------------------------------------------------------------------*/
;*    display-definition ...                                           */
;*---------------------------------------------------------------------*/
(define (display-definition fun)
   (print ";; " (cadr fun))
   (print "(" (car fun) " " (cadr fun))
   (print "   " (caddr fun) ")")
   (newline))
