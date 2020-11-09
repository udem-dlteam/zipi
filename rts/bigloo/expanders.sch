;*=====================================================================*/
;*    serrano/prgm/project/zipi/rts/bigloo/expanders.sch               */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Wed Dec  6 18:25:11 2006                          */
;*    Last change :  Mon Nov  9 11:42:18 2020 (serrano)                */
;*    Copyright   :  2006-20 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    zipi expanders installer                                         */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    zipi-install-expanders! ...                                      */
;*---------------------------------------------------------------------*/
(define (zipi-install-expanders!)
   ;; constants
   (eval `(define-expander &
	     ,&-expander))
   (eval `(define-expander &init!
	     ,&init!-expander))
   (eval `(define-expander &begin!
	     ,&begin!-expander))
   (eval `(define-expander &end!
	     ,&end!-expander))
   (eval `(define-expander &&
	     ,&&-expander))
   (eval `(define-expander start-registering-constants
	     ,start-registering-constants-expander))
   (eval `(define-expander end-registering-constants
	     ,end-registering-constants-expander))
   (eval `(define-expander init-registered-constants
	     ,init-registered-constants-expander))
   ;; call
   (eval `(define-expander make-signature
	     ,make-signature-expander))
   (eval `(define-expander empty-signature
	     ,empty-signature-expander))
   (eval `(define-expander make-vararg-only-signature
	     ,make-vararg-only-signature-expander))
   (eval `(define-expander make-posonly-signature
	     ,make-posonly-signature-expander))
   (eval `(define-expander make-posonly-defaults-signature
	     ,make-posonly-defaults-signature-expander))
   (eval `(define-expander make-args-defaults-signature
	     ,make-args-defaults-signature-expander))
   (eval `(define-expander register-constants-perfect-hashtable
	     ,register-constants-perfect-hashtable-expander))
   (eval `(define-expander py-call
	     ,py-call-expander)))
