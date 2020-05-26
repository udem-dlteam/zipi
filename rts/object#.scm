;*=====================================================================*/
;*    serrano/prgm/project/zipi/rts/object#.scm                        */
;*    -------------------------------------------------------------    */
;*    Author      :  Marc Feeley & Manuel Serrano                      */
;*    Creation    :  Tue Jun  4 14:49:14 2019                          */
;*    Last change :  Sat May 23 06:58:13 2020 (serrano)                */
;*    Copyright   :  2019-20 M. Feeley & M. Serrano                    */
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

;; debug function that prints the backtrace
;; at the point in the code where called
(define (why-am-i-here?)
  (##continuation-capture (lambda (cc) (display-continuation-backtrace cc))))

(define (object-repr self)
  (let* ((self-type (py-type self))
         (self-type-name (py-str-to-scheme (type-name-fast-get self-type)))
         (addr (integer->hex-string (##object->encoding self)))
         (result (string-append "<" self-type-name " object at " addr ">")))
    (py-str-from-scheme result)))

(define (read-string port)
   (list->string (read-all port read-char)))
