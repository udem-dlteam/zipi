;*=====================================================================*/
;*    serrano/prgm/project/zipi/rts/make_lib.scm                       */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Tue Jul  2 07:06:22 2019                          */
;*    Last change :  Mon May 25 14:20:27 2020 (serrano)                */
;*    Copyright   :  2019-20 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The module used to build the pyc heap file.                      */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __py_makelib

   (import __py_rts
      __py_bigloo)

   (eval (export-all)
      (class PyObject)
      (class PyFunction)
      (class PyGenerator)
      (class PCache)
      (class HClass)))
