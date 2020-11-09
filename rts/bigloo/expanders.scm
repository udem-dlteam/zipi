;*=====================================================================*/
;*    serrano/prgm/project/zipi/rts/bigloo/expanders.scm               */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Mon Nov  9 11:34:25 2020                          */
;*    Last change :  Mon Nov  9 11:38:04 2020 (serrano)                */
;*    Copyright   :  2020 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    Zipi expanders                                                   */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __zipi_expanders

   (option  (register-srfi! 'zipi-eval))
   
   (library hop)
   
   (include "constants_expd.sch"
	    "call_expd.sch"
	    "expanders.sch")

   (export  (zipi-install-expanders!)))
