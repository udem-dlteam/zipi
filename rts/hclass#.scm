;*=====================================================================*/
;*    serrano/nosync/py19/scmast/hclass/hclass.bgl                     */
;*    -------------------------------------------------------------    */
;*    Author      :  Marc Feeley & Manuel Serrano                      */
;*    Creation    :  Tue Jun  4 14:49:14 2019                          */
;*    Last change :  Tue Jun  4 15:36:41 2019 (serrano)                */
;*    Copyright   :  2019 M. Feeley & M. Serrano                       */
;*    -------------------------------------------------------------    */
;*    Hidden classes for python ast interpreter                        */
;*=====================================================================*/

(define-type PCache
  id: A1E4C683-1891-4179-81F6-797D0A717E37
  constructor: make-PCache
  implementer: implement-PCache
  copier: #f
  opaque:
  macros:
;;  prefix: macro-

  hclass
  index
)

(define-type HClass
  id: C253A20A-30F8-4148-941E-C8BED47E9E79
  constructor: make-HClass
  implementer: implement-HClass
  copier: #f
  opaque:
  macros:
;;  prefix: macro-

  names
  transitions
)

(define-macro (make-pcache)
  `(make-PCache '() -1))

(define-macro (pcache-hclass pc)
  `(PCache-hclass ,pc))
   
(define-macro (pcache-index pc)
  `(PCache-index ,pc))
   
(define-macro (pcache-set! pc hc i)
  `(let (($pc ,pc))
     (PCache-hclass-set! $pc ,hc)
     (PCache-index-set! $pc ,i)))

(define-macro (make-hclass names)
  `(make-HClass ,names '()))

(define-macro (hclass-names hclass)
  `(HClass-names ,hclass))

(define-macro (hclass-transitions hclass)
  `(HClass-transitions ,hclass))

(define-macro (hclass-last-index hclass)
  `(fx- (vector-length (HClass-names ,hclass)) 1))
