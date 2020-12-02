;*=====================================================================*/
;*    serrano/prgm/project/zipi/bench/demangle.scm                     */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Wed Dec  2 13:45:26 2020                          */
;*    Last change :  Wed Dec  2 13:45:27 2020 (serrano)                */
;*    Copyright   :  2020 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    Bigloo demangler                                                 */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module demangle
   (main main))

;*---------------------------------------------------------------------*/
;*    *demangle-grammar* ...                                           */
;*---------------------------------------------------------------------*/
(define *demangle-grammar*
   (regular-grammar ((id (: (or alpha #\_) (* (or alpha digit #\_))))
		     (rest (in "<>/:;'~`@#$%^&*()_-+=\|]}[{\\\"")))
      ((: id #\_ (+ (in digit)))
       ;; this is likely to be a Bigloo local variable
       (let ((len (the-length))
	     (str (the-string)))
	  (let loop ((i (-fx len 1)))
	     (if (char=? (string-ref str i) #\_)
		 (let ((substr (substring str 0 i)))
		    (cond
		       ((bigloo-mangled? substr)
			(display (bigloo-demangle substr)))
		       (else
			(display (the-string)))))
		 (loop (-fx i 1)))))
       (ignore))
      (id
       ;; a plain identifier
       (let ((str (the-string)))
	  (cond
	     ((bigloo-mangled? str)
	      (multiple-value-bind (id module)
		 (bigloo-demangle str)
		 (display id)
		 (if (string? module)
		     (display* "@" module))))
	     ((bigloo-class-mangled? str)
	      (display (bigloo-class-demangle str)))
	     (else
	      (display str))))
       (ignore))
      (blank
       (display (the-string))
       (ignore))
      ((+ (or digit punct rest))
       (display (the-string))
       (ignore))
      (else
       (let ((c (the-failure)))
	  (if (eof-object? c)
	      c
	      (begin
		 (write-char c)
		 (ignore)))))))

;*---------------------------------------------------------------------*/
;*    main ...                                                         */
;*---------------------------------------------------------------------*/
(define (main argv)
   (define (doit)
      (read/rp *demangle-grammar* (current-input-port)))
   (if (pair? (cdr argv))
       (with-input-from-file (cadr argv) doit)
       (doit)))
