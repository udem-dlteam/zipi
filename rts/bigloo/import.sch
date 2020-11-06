;*=====================================================================*/
;*    serrano/prgm/project/zipi/rts/bigloo/import.sch                  */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Fri Nov  6 09:26:43 2020                          */
;*    Last change :  Fri Nov  6 09:26:44 2020 (serrano)                */
;*    Copyright   :  2020 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    Gambit import compatibility macro                                */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    import ...                                                       */
;*---------------------------------------------------------------------*/
(define-macro (import l)
   (for-each (lambda (m)
		(let* ((m (symbol->string! m))
		       (f (string-append m ".scm")))
		   (if (file-exists? f)
		       (load f)
		       (let ((f (make-file-path m f)))
			  (if (file-exists? f)
			      (load f)
			      (warning "import:cannot find module" m))))))
      l)
   #unspecified)
