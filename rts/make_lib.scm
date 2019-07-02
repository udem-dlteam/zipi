;*=====================================================================*/
;*    serrano/prgm/project/zipi/rts/make_lib.scm                       */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Tue Jul  2 07:06:22 2019                          */
;*    Last change :  Tue Jul  2 11:43:55 2019 (serrano)                */
;*    Copyright   :  2019 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The module used to build the pyc heap file.                      */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __py_makelib
   
   (import
      __py_object
      __py_iterator
      __py_import
      __py_hclass)
   
   (eval (class PyObject)
      (class PyFunction)
      (class PyGenerator)
      (class PCache)
      (class HClass)))
