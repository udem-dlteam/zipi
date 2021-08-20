;*=====================================================================*/
;*    serrano/prgm/project/zipi/zipi/rts/bigloo/call.sch               */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Thu Nov  5 10:30:55 2020                          */
;*    Last change :  Fri Aug 20 15:20:41 2021 (serrano)                */
;*    Copyright   :  2020-21 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    Macros for Python calls                                          */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The directives                                                   */
;*---------------------------------------------------------------------*/
(directives
   (option (loadq "hash/hash.scm")
           (loadq "bigloo/call_expd.sch")))

;*---------------------------------------------------------------------*/
;*    signatures                                                       */
;*---------------------------------------------------------------------*/
(define-expander make-signature make-signature-expander)
;* (define-expander empty-signature empty-signature-expander)          */
;* (define-expander make-vararg-only-signature make-vararg-only-signature-expander) */
;* (define-expander make-posonly-signature make-posonly-signature-expander) */
;* (define-expander make-posonly-defaults-signature make-posonly-defaults-signature-expander) */
;* (define-expander make-args-defaults-signature make-args-defaults-signature-expander) */

(define-expander register-constants-perfect-hashtable register-constants-perfect-hashtable-expander)

(define-expander py-call py-call-expander)

(define-expander signature-defaults signature-defaults-expander)
(define-expander signature-arity-alignment signature-arity-alignment-expander)
(define-expander signature-location signature-location-expander)
