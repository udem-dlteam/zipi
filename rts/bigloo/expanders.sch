;*=====================================================================*/
;*    serrano/prgm/project/zipi/rts/bigloo/expanders.sch               */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Wed Dec  6 18:25:11 2006                          */
;*    Last change :  Mon Nov  9 11:42:18 2020 (serrano)                */
;*    Copyright   :  2006-21 Manuel Serrano                            */
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
   (eval `(define-expander register-constants-perfect-hashtable
	     ,register-constants-perfect-hashtable-expander))
   (eval `(define-expander py-call
	     ,py-call-expander))
   (eval `(define-expander py-global-call
	     ,py-global-call-expander)))
