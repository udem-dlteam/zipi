;*=====================================================================*/
;*    serrano/prgm/project/zipi/zipi/rts/bigloo/constants.sch          */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Nov 22 06:35:05 2014                          */
;*    Last change :  Sun May  2 15:55:51 2021 (serrano)                */
;*    Copyright   :  2014-21 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    constants Helper macros.                                         */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The directives                                                   */
;*---------------------------------------------------------------------*/
(directives
   (option (loadq "bigloo/constants_expd.sch")))

;*---------------------------------------------------------------------*/
;*    & ...                                                            */
;*---------------------------------------------------------------------*/
(define-expander & &-expander)
(define-expander &init! &init!-expander)
(define-expander &begin! &begin!-expander)
(define-expander GEE &begin!-expander)
(define-expander &end! &end!-expander)

(define-expander && &&-expander)
(define-expander start-registering-constants start-registering-constants-expander)
(define-expander end-registering-constants end-registering-constants-expander)
(define-expander init-registered-constants init-registered-constants-expander)
