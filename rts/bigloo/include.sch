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
		 (warning "(zipi) import:cannot include module" file)))))
   #unspecified)

;*---------------------------------------------------------------------*/
;*    u8vectors                                                        */
;*    -------------------------------------------------------------    */
;*    The Zipi runtime stores and reads fixnums in u8vectors (as with  */
;*    Gambit), while Bigloo's u8vector procedures use the uint8 type.  */
;*---------------------------------------------------------------------*/
(define-macro (u8vector-ref v i)
   `(uint8->fixnum ((@ u8vector-ref __srfi4) ,v ,i)))

(define-macro (u8vector-set! v i x)
   `((@ u8vector-set! __srfi4) ,v ,i (fixnum->uint8 ,x)))

(define-macro (make-u8vector n . init)
   `((@ make-u8vector __srfi4) ,n
       ,@(map (lambda (x) `(fixnum->uint8 ,x)) init)))
