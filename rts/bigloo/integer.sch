;*=====================================================================*/
;*    serrano/prgm/project/zipi/rts/bigloo/integer.sch                 */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Tue Dec  1 16:18:10 2020                          */
;*    Last change :  Tue Dec  1 16:18:10 2020 (serrano)                */
;*    Copyright   :  2020 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    Fixnum preallocation                                             */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    py-int-from-scheme ...                                           */
;*---------------------------------------------------------------------*/
(define-macro (py-int-from-scheme value)
  (if (fixnum? value)
      (let ((int-cache-low -5)
	    (int-cache-high 256))
        (if (and (<=fx value int-cache-high)
                 (>=fx value int-cache-low))
            `(vector-ref int-cache ,(-fx value int-cache-low))
            `(py-int-from-scheme-dynamic ,value)))
      `(py-int-from-scheme-dynamic ,value)))

