;*=====================================================================*/
;*    serrano/prgm/project/zipi/zpc/param.sch                          */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Wed Dec  6 18:17:19 2006                          */
;*    Last change :  Tue Dec  1 08:57:51 2020 (serrano)                */
;*    Copyright   :  2006-20 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    Parameters expander                                              */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    define-parameter ...                                             */
;*---------------------------------------------------------------------*/
(define-expander define-parameter
   
   (define (expand-define-parameter id default setter x)
      (let ((vid (symbol-append '* id '*))
	    (set (symbol-append id '-set!)))
	 `(begin
	     (define ,vid ,default)
	     ,(evepairify `(define (,id) ,vid) x)
	     ,(evepairify `(define (,set v)
			      ,(if (pair? setter)
				   `(set! ,vid (,(car setter) v))
				   `(set! ,vid v))
			      v)
		 x)
	     ,@(if (pair? setter)
		   (list (evepairify `(,set (,id)) x))
		   '()))))
   
   (lambda (x e)
      (match-case x
	 ((?- ?id ?default . ?setter)
	  (e (expand-define-parameter id default setter x) e))
	 (else
	  (error "define-expander" "Illegal form" x)))))
