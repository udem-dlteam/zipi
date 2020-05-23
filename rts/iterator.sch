;; ==========================================================
;; Class accessors
;; Bigloo (4.3i)
;; Inria -- Sophia Antipolis     Thu 14 May 2020 10:13:43 AM CEST 
;; (bigloo -classgen iterator.bgl -o iterator.sch)
;; ==========================================================

;; The directives
(directives

;; PyGenerator
(cond-expand ((and bigloo-class-sans (not bigloo-class-generate))
  (export
    (inline make-PyGenerator::PyGenerator hclass1060::obj %elements1061::obj %next1062::obj)
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
(define-inline (make-PyGenerator::PyGenerator hclass1060::obj %elements1061::obj %next1062::obj) (instantiate::PyGenerator (hclass hclass1060) (%elements %elements1061) (%next %next1062)))
(define-inline (PyGenerator?::bool obj::obj) ((@ isa? __object) obj (@ PyGenerator __py_iterator)))
(define (PyGenerator-nil::PyGenerator) (class-nil (@ PyGenerator __py_iterator)))
(define-inline (PyGenerator-%next::obj o::PyGenerator) (-> |#!bigloo_wallow| o %next))
(define-inline (PyGenerator-%next-set! o::PyGenerator v::obj) (set! (-> |#!bigloo_wallow| o %next) v))
(define-inline (PyGenerator-%elements::obj o::PyGenerator) (-> |#!bigloo_wallow| o %elements))
(define-inline (PyGenerator-%elements-set! o::PyGenerator v::obj) (set! (-> |#!bigloo_wallow| o %elements) v))
(define-inline (PyGenerator-hclass::obj o::PyGenerator) (-> |#!bigloo_wallow| o hclass))
(define-inline (PyGenerator-hclass-set! o::PyGenerator v::obj) (set! (-> |#!bigloo_wallow| o hclass) v))
))
