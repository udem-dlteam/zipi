;*=====================================================================*/
;*    serrano/prgm/project/zipi/zipi/rts/make_lib.scm                  */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Tue Jul  2 07:06:22 2019                          */
;*    Last change :  Thu Aug 12 09:58:51 2021 (serrano)                */
;*    Copyright   :  2019-21 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The module used to build the pyc heap file.                      */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __py_makelib
   
   (import __py_rts
           __py_bigloo
	   __py_configure
	   __stdlib_zemantics
	   __stdlib_behaviors)
   
   (eval (export-all)
      (class PyObject)
      (class PyGenerator)
      (class PCache)
      (class HClass)))
