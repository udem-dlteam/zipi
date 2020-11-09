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
;*    The directives                                                   */
;*---------------------------------------------------------------------*/
(directives
   (option (loadq "hash/hash.scm")
           (loadq "config/config.scm")
           (loadq "bigloo/call_expd.sch")))

;*---------------------------------------------------------------------*/
;*    signatures                                                       */
;*---------------------------------------------------------------------*/
(define-expander make-signature make-signature-expander)
(define-expander empty-signature empty-signature-expander)
(define-expander make-vararg-only-signature make-vararg-only-signature-expander)
(define-expander make-posonly-signature make-posonly-signature-expander)
(define-expander make-posonly-defaults-signature make-posonly-defaults-signature-expander)
(define-expander make-args-defaults-signature make-args-defaults-signature-expander)
(define-expander register-constants-perfect-hashtable register-constants-perfect-hashtable-expander)

(define-expander py-call py-call-expander)

