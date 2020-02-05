;*=====================================================================*/
;*    serrano/nosync/py19/scmast/object/object#.scm                    */
;*    -------------------------------------------------------------    */
;*    Author      :  Marc Feeley & Manuel Serrano                      */
;*    Creation    :  Tue Jun  4 14:49:14 2019                          */
;*    Last change :  Thu Jun 20 08:38:58 2019 (serrano)                */
;*    Copyright   :  2019 M. Feeley & M. Serrano                       */
;*    -------------------------------------------------------------    */
;*    Object representation                                            */
;*=====================================================================*/

(define-type PyObject
  id: C6486EB6-1522-42BA-A082-B6563F943CDF
  constructor: make-PyObject
  implementer: implement-PyObject
  copier: #f
  opaque:
  macros:
;;  prefix: macro-

  hclass
  elements
)

(define-macro (make-pyobject hclass)
  `(make-PyObject ,hclass (make-vector 4)))

(define-macro (pyobject-hclass obj)
  `(PyObject-hclass ,obj))

(define-macro (pyobject-hclass-set! obj hc)
  `(PyObject-hclass-set! ,obj ,hc))

(define-macro (pyobject-elements-ref obj offset)
  `(vector-ref (PyObject-elements ,obj) ,offset))

(define-macro (pyobject-elements-set! obj offset val)
  `(let* (($obj ,obj)
          ($offset ,offset)
          ($val ,val)
          ($elements (PyObject-elements $obj))
          ($elements-len (vector-length $elements)))
     (if (fx>= $offset $elements-len)
         (let (($elements-new (make-vector (fx* 2 $elements-len))))
           (subvector-move! $elements 0 $elements-len $elements-new 0)
           (vector-set! $elements-new $offset $val)
           (PyObject-elements-set! $obj $elements-new))
         (vector-set! $elements $offset $val))))
