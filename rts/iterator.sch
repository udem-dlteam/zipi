;; ==========================================================
;; Class accessors
;; Bigloo (4.3f)
;; Inria -- Sophia Antipolis     Mon Jun 24 18:10:06 CEST 2019 
;; (bigloo -classgen iterator.bgl -o iterator.sch)
;; ==========================================================

;; The directives
(directives

;; PyGenerator
(cond-expand ((and bigloo-class-sans (not bigloo-class-generate))
  (export
    (inline make-PyGenerator::PyGenerator hclass1056::obj %elements1057::obj %next1058::obj)
    (inline PyGenerator?::bool ::obj)
    (PyGenerator-nil::PyGenerator)
    (inline PyGenerator-%next::obj ::PyGenerator)
    (inline PyGenerator-%next-set! ::PyGenerator ::obj)
    (inline PyGenerator-%elements::obj ::PyGenerator)
    (inline PyGenerator-%elements-set! ::PyGenerator ::obj)
    (inline PyGenerator-hclass::obj ::PyGenerator)
    (inline PyGenerator-hclass-set! ::PyGenerator ::obj)))))

;; The definitions
(cond-expand (bigloo-class-sans
;; PyGenerator
(define-inline (make-PyGenerator::PyGenerator hclass1056::obj %elements1057::obj %next1058::obj) (instantiate::PyGenerator (hclass hclass1056) (%elements %elements1057) (%next %next1058)))
(define-inline (PyGenerator?::bool obj::obj) ((@ isa? __object) obj (@ PyGenerator __py_iterator)))
(define (PyGenerator-nil::PyGenerator) (class-nil (@ PyGenerator __py_iterator)))
(define-inline (PyGenerator-%next::obj o::PyGenerator) (-> |#!bigloo_wallow| o %next))
(define-inline (PyGenerator-%next-set! o::PyGenerator v::obj) (set! (-> |#!bigloo_wallow| o %next) v))
(define-inline (PyGenerator-%elements::obj o::PyGenerator) (-> |#!bigloo_wallow| o %elements))
(define-inline (PyGenerator-%elements-set! o::PyGenerator v::obj) (set! (-> |#!bigloo_wallow| o %elements) v))
(define-inline (PyGenerator-hclass::obj o::PyGenerator) (-> |#!bigloo_wallow| o hclass))
(define-inline (PyGenerator-hclass-set! o::PyGenerator v::obj) (set! (-> |#!bigloo_wallow| o hclass) v))
))
