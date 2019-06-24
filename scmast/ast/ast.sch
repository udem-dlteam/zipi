;*=====================================================================*/
;*    serrano/nosync/py19/scmast/ast/ast.sch                           */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Thu Jun  6 15:20:59 2019                          */
;*    Last change :  Thu Jun  6 15:21:20 2019 (serrano)                */
;*    Copyright   :  2019 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    Bigloo ast global import                                         */
;*=====================================================================*/

(directives
   (include "ast/types.sch"
	    "ast/new.sch"
	    "ast/walk.sch")
   (import __py_ast))
