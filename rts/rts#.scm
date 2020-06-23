;*=====================================================================*/
;*    serrano/prgm/project/zipi/rts/rts#.scm                        */
;*    -------------------------------------------------------------    */
;*    Author      :  Marc Feeley & Manuel Serrano                      */
;*    Creation    :  Tue Jun  4 14:49:14 2019                          */
;*    Last change :  Sat May 23 06:58:13 2020 (serrano)                */
;*    Copyright   :  2019-20 M. Feeley & M. Serrano                    */
;*    -------------------------------------------------------------    */
;*    Object representation                                            */
;*=====================================================================*/

;; =============================================================================
;;  Objects interning
;; =============================================================================

(define-macro (start-registering-constants)
  (eval
    `(begin
      (define-type Constants
        id: %constants
        constructor: %make-Constants
        prefix: %
        macros: table)
      (define-type PyStaticObject
        id: %static-pyobject
        constructor: %make-PyStaticObject
        prefix: %
        macros: hclass elements)
      (define (make-PyStaticObject elts hclass) (%make-PyStaticObject elts hclass))
      (define %constants (%make-Constants (make-table)))
      (define (constants-table) (%Constants-table %constants))
      (define (constants-ref c key) (table-ref (%Constants-table c) key #f))
      (define (constants-set! c key val) (table-set! (%Constants-table c) key val))))
  `(inject-constants ',%constants))

(define %constants #f)
(define (inject-constants constants)
  (set! %constants (##vector-ref constants 1)))

(start-registering-constants)

(define-macro (end-registering-constants)
  (pp (table->list (constants-table))))

(define-macro (& e)
  (if (string? e)
    (let ((cached (constants-ref %constants e)))
      (if cached
        `',cached
        (let ((obj (make-PyStaticObject #f #f)))
          (constants-set! %constants e obj)
          `',obj)))
    (error "&" "requires string literal but got" e)))

;; =============================================================================
;;  PyObject
;; =============================================================================

(define-type PyObject
  id: C6486EB6-1522-42BA-A082-B6563F943CDF
  constructor: %make-PyObject
  predicate: %PyObject?
  type-exhibitor: %PyObject-type-get
  implementer: implement-PyObject
  copier: #f
  opaque:
  prefix: %
  macros: hclass elements)

(define (PyObject? x)
  (%PyObject? x))

(define-macro (make-PyObject hclass elts)
  `(%make-PyObject ,hclass ,elts))

(define-macro (PyObject-hclass obj)
  `(%PyObject-hclass ,obj))

(define-macro (PyObject-hclass-set! obj hc)
  `(%PyObject-hclass-set! ,obj ,hc))

(define-macro (PyObject-elements-ref obj offset)
  `(vector-ref (%PyObject-elements ,obj) ,offset))

(define-macro (PyObject-elements-set! obj offset val)
  `(let* (($obj ,obj)
          ($offset ,offset)
          ($val ,val)
          ($elements (%PyObject-elements $obj))
          ($elements-len (vector-length $elements)))
     (if (fx>= $offset $elements-len)
         (let (($elements-new (make-vector (fx* 2 $elements-len))))
           (subvector-move! $elements 0 $elements-len $elements-new 0)
           (vector-set! $elements-new $offset $val)
           (%PyObject-elements-set! $obj $elements-new))
         (vector-set! $elements $offset $val))))

;; =============================================================================
;;  PCache
;; =============================================================================

(define-type PCache
  id: A1E4C683-1891-4179-81F6-797D0A717E37
  constructor: %make-PCache
  predicate: PCache?
  implementer: implement-PCache
  copier: #f
  opaque:
  prefix: %
  macros: hclass index)

(define-macro (make-PCache hc i)
  `(%make-PCache ,hc ,i))

(define-macro (PCache-hclass pc)
  `(%PCache-hclass ,pc))

(define-macro (PCache-index pc)
  `(%PCache-index ,pc))

(define-macro (PCache-set! pc hc i)
  `(let (($pc ,pc))
     (%PCache-hclass-set! $pc ,hc)
     (%PCache-index-set! $pc ,i)))

;; =============================================================================
;;  HClass
;; =============================================================================

(define-type HClass
  id: C253A20A-30F8-4148-941E-C8BED47E9E79
  constructor: make-HClass
  predicate: HClass?
  implementer: implement-HClass
  copier: #f
  opaque:
  macros: class-mro names transitions)

(define-macro (HClass-last-index hclass)
  `(fx- (vector-length (HClass-names ,hclass)) 1))

(define-macro (HClass-transition-add! hc transitions target)
  `(let (($hc ,hc))
    (HClass-transitions-set!
     $hc
     (cons (cons ,transitions ,target) (HClass-transitions $hc)))))

(define-macro (vector-extend vec el)
  `(let (($vec ,vec) ($el ,el))
     (let* ((len (vector-length $vec))
  	  (nvec (make-vector (+ len 1))))
        (vector-copy! nvec 0 $vec)
        (vector-set! nvec len $el)
        nvec)))

(define-macro (HClass-next hc name op)
  `(let (($hc ,hc) ($name ,name))
    (let* ((key (cons $name ,op))
           (tran (assoc key (HClass-transitions $hc))))
      (if (pair? tran)
        (cdr tran)
        (let ((nhclass
                (make-HClass
                  (HClass-class-mro $hc)
                  (vector-extend (HClass-names $hc) $name)
                  '())))
          (HClass-transition-add! $hc key nhclass)
          nhclass)))))
