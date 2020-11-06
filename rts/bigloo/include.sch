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
;*    include ...                                                      */
;*---------------------------------------------------------------------*/
(define-macro (include file)
   (let ((f (string-append file ".scm")))
      (if (file-exists? f)
	  (loadq f)
	  (let ((f (make-file-path file f)))
	     (if (file-exists? f)
		 (loadq f)
		 (warning "import:cannot include module" file)))))
   #unspecified)
