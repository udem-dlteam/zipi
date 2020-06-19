;; ==========================================================
;; Class accessors
;; Bigloo (4.3f)
;; Inria -- Sophia Antipolis     Thu 04 Jul 2019 08:10:18 AM CEST 
;; (bigloo -classgen rts.bgl -o rts.sch)
;; ==========================================================

;; The directives
(directives

;; PyObject
(cond-expand ((and bigloo-class-sans (not bigloo-class-generate))
  (export
    (inline make-PyObject::PyObject hclass1091::obj %elements1092::obj)
    (inline PyObject?::bool ::obj)
    (PyObject-nil::PyObject)
    (inline PyObject-%elements::obj ::PyObject)
    (inline PyObject-%elements-set! ::PyObject ::obj)
    (inline PyObject-hclass::obj ::PyObject)
    (inline PyObject-hclass-set! ::PyObject ::obj))))

;; PyFunction
(cond-expand ((and bigloo-class-sans (not bigloo-class-generate))
  (export
    (inline make-PyFunction::PyFunction hclass1087::obj %elements1088::obj procedure1089::obj)
    (inline PyFunction?::bool ::obj)
    (PyFunction-nil::PyFunction)
    (inline PyFunction-procedure::obj ::PyFunction)
    (inline PyFunction-%elements::obj ::PyFunction)
    (inline PyFunction-%elements-set! ::PyFunction ::obj)
    (inline PyFunction-hclass::obj ::PyFunction)
    (inline PyFunction-hclass-set! ::PyFunction ::obj))))

;; PyGenerator
(cond-expand ((and bigloo-class-sans (not bigloo-class-generate))
  (export
    (inline make-PyGenerator::PyGenerator hclass1083::obj %elements1084::obj %next1085::obj)
    (inline PyGenerator?::bool ::obj)
    (PyGenerator-nil::PyGenerator)
    (inline PyGenerator-%next::obj ::PyGenerator)
    (inline PyGenerator-%next-set! ::PyGenerator ::obj)
    (inline PyGenerator-%elements::obj ::PyGenerator)
    (inline PyGenerator-%elements-set! ::PyGenerator ::obj)
    (inline PyGenerator-hclass::obj ::PyGenerator)
    (inline PyGenerator-hclass-set! ::PyGenerator ::obj))))

;; PCache
(cond-expand ((and bigloo-class-sans (not bigloo-class-generate))
  (export
    (inline make-PCache::PCache hclass1080::obj index1081::long)
    (inline PCache?::bool ::obj)
    (PCache-nil::PCache)
    (inline PCache-index::long ::PCache)
    (inline PCache-index-set! ::PCache ::long)
    (inline PCache-hclass::obj ::PCache)
    (inline PCache-hclass-set! ::PCache ::obj))))

;; HClass
(cond-expand ((and bigloo-class-sans (not bigloo-class-generate))
  (export
    (inline make-HClass::HClass class-mro1076::vector names1077::vector transitions1078::pair-nil)
    (inline HClass?::bool ::obj)
    (HClass-nil::HClass)
    (inline HClass-transitions::pair-nil ::HClass)
    (inline HClass-transitions-set! ::HClass ::pair-nil)
    (inline HClass-names::vector ::HClass)
    (inline HClass-names-set! ::HClass ::vector)
    (inline HClass-class-mro::vector ::HClass)
    (inline HClass-class-mro-set! ::HClass ::vector)))))

;; The definitions
(cond-expand (bigloo-class-sans
;; PyObject
(define-inline (make-PyObject::PyObject hclass1091::obj %elements1092::obj) (instantiate::PyObject (hclass hclass1091) (%elements %elements1092)))
(define-inline (PyObject?::bool obj::obj) ((@ isa? __object) obj (@ PyObject __py_rts)))
(define (PyObject-nil::PyObject) (class-nil (@ PyObject __py_rts)))
(define-inline (PyObject-%elements::obj o::PyObject) (-> |#!bigloo_wallow| o %elements))
(define-inline (PyObject-%elements-set! o::PyObject v::obj) (set! (-> |#!bigloo_wallow| o %elements) v))
(define-inline (PyObject-hclass::obj o::PyObject) (-> |#!bigloo_wallow| o hclass))
(define-inline (PyObject-hclass-set! o::PyObject v::obj) (set! (-> |#!bigloo_wallow| o hclass) v))

;; PyFunction
(define-inline (make-PyFunction::PyFunction hclass1087::obj %elements1088::obj procedure1089::obj) (instantiate::PyFunction (hclass hclass1087) (%elements %elements1088) (procedure procedure1089)))
(define-inline (PyFunction?::bool obj::obj) ((@ isa? __object) obj (@ PyFunction __py_rts)))
(define (PyFunction-nil::PyFunction) (class-nil (@ PyFunction __py_rts)))
(define-inline (PyFunction-procedure::obj o::PyFunction) (-> |#!bigloo_wallow| o procedure))
(define-inline (PyFunction-procedure-set! o::PyFunction v::obj) (set! (-> |#!bigloo_wallow| o procedure) v))
(define-inline (PyFunction-%elements::obj o::PyFunction) (-> |#!bigloo_wallow| o %elements))
(define-inline (PyFunction-%elements-set! o::PyFunction v::obj) (set! (-> |#!bigloo_wallow| o %elements) v))
(define-inline (PyFunction-hclass::obj o::PyFunction) (-> |#!bigloo_wallow| o hclass))
(define-inline (PyFunction-hclass-set! o::PyFunction v::obj) (set! (-> |#!bigloo_wallow| o hclass) v))

;; PyGenerator
(define-inline (make-PyGenerator::PyGenerator hclass1083::obj %elements1084::obj %next1085::obj) (instantiate::PyGenerator (hclass hclass1083) (%elements %elements1084) (%next %next1085)))
(define-inline (PyGenerator?::bool obj::obj) ((@ isa? __object) obj (@ PyGenerator __py_rts)))
(define (PyGenerator-nil::PyGenerator) (class-nil (@ PyGenerator __py_rts)))
(define-inline (PyGenerator-%next::obj o::PyGenerator) (-> |#!bigloo_wallow| o %next))
(define-inline (PyGenerator-%next-set! o::PyGenerator v::obj) (set! (-> |#!bigloo_wallow| o %next) v))
(define-inline (PyGenerator-%elements::obj o::PyGenerator) (-> |#!bigloo_wallow| o %elements))
(define-inline (PyGenerator-%elements-set! o::PyGenerator v::obj) (set! (-> |#!bigloo_wallow| o %elements) v))
(define-inline (PyGenerator-hclass::obj o::PyGenerator) (-> |#!bigloo_wallow| o hclass))
(define-inline (PyGenerator-hclass-set! o::PyGenerator v::obj) (set! (-> |#!bigloo_wallow| o hclass) v))

;; PCache
(define-inline (make-PCache::PCache hclass1080::obj index1081::long) (instantiate::PCache (hclass hclass1080) (index index1081)))
(define-inline (PCache?::bool obj::obj) ((@ isa? __object) obj (@ PCache __py_rts)))
(define (PCache-nil::PCache) (class-nil (@ PCache __py_rts)))
(define-inline (PCache-index::long o::PCache) (-> |#!bigloo_wallow| o index))
(define-inline (PCache-index-set! o::PCache v::long) (set! (-> |#!bigloo_wallow| o index) v))
(define-inline (PCache-hclass::obj o::PCache) (-> |#!bigloo_wallow| o hclass))
(define-inline (PCache-hclass-set! o::PCache v::obj) (set! (-> |#!bigloo_wallow| o hclass) v))

;; HClass
(define-inline (make-HClass::HClass class-mro1076::vector names1077::vector transitions1078::pair-nil) (instantiate::HClass (class-mro class-mro1076) (names names1077) (transitions transitions1078)))
(define-inline (HClass?::bool obj::obj) ((@ isa? __object) obj (@ HClass __py_rts)))
(define (HClass-nil::HClass) (class-nil (@ HClass __py_rts)))
(define-inline (HClass-transitions::pair-nil o::HClass) (-> |#!bigloo_wallow| o transitions))
(define-inline (HClass-transitions-set! o::HClass v::pair-nil) (set! (-> |#!bigloo_wallow| o transitions) v))
(define-inline (HClass-names::vector o::HClass) (-> |#!bigloo_wallow| o names))
(define-inline (HClass-names-set! o::HClass v::vector) (set! (-> |#!bigloo_wallow| o names) v))
(define-inline (HClass-class-mro::vector o::HClass) (-> |#!bigloo_wallow| o class-mro))
(define-inline (HClass-class-mro-set! o::HClass v::vector) (set! (-> |#!bigloo_wallow| o class-mro) v))
))
