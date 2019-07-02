;; ==========================================================
;; Class accessors
;; Bigloo (4.3f)
;; Inria -- Sophia Antipolis     Mon Jun 24 18:10:06 CEST 2019 
;; (bigloo -classgen hclass.bgl -o hclass.sch)
;; ==========================================================

;; The directives
(directives

;; PCache
(cond-expand ((and bigloo-class-sans (not bigloo-class-generate))
  (export
    (inline make-PCache::PCache hclass1062::obj index1063::long)
    (inline PCache?::bool ::obj)
    (PCache-nil::PCache)
    (inline PCache-index::long ::PCache)
    (inline PCache-index-set! ::PCache ::long)
    (inline PCache-hclass::obj ::PCache)
    (inline PCache-hclass-set! ::PCache ::obj))))

;; HClass
(cond-expand ((and bigloo-class-sans (not bigloo-class-generate))
  (export
    (inline make-HClass::HClass class-mro1058::vector names1059::vector transitions1060::pair-nil)
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
;; PCache
(define-inline (make-PCache::PCache hclass1062::obj index1063::long) (instantiate::PCache (hclass hclass1062) (index index1063)))
(define-inline (PCache?::bool obj::obj) ((@ isa? __object) obj (@ PCache __py_hclass)))
(define (PCache-nil::PCache) (class-nil (@ PCache __py_hclass)))
(define-inline (PCache-index::long o::PCache) (-> |#!bigloo_wallow| o index))
(define-inline (PCache-index-set! o::PCache v::long) (set! (-> |#!bigloo_wallow| o index) v))
(define-inline (PCache-hclass::obj o::PCache) (-> |#!bigloo_wallow| o hclass))
(define-inline (PCache-hclass-set! o::PCache v::obj) (set! (-> |#!bigloo_wallow| o hclass) v))

;; HClass
(define-inline (make-HClass::HClass class-mro1058::vector names1059::vector transitions1060::pair-nil) (instantiate::HClass (class-mro class-mro1058) (names names1059) (transitions transitions1060)))
(define-inline (HClass?::bool obj::obj) ((@ isa? __object) obj (@ HClass __py_hclass)))
(define (HClass-nil::HClass) (class-nil (@ HClass __py_hclass)))
(define-inline (HClass-transitions::pair-nil o::HClass) (-> |#!bigloo_wallow| o transitions))
(define-inline (HClass-transitions-set! o::HClass v::pair-nil) (set! (-> |#!bigloo_wallow| o transitions) v))
(define-inline (HClass-names::vector o::HClass) (-> |#!bigloo_wallow| o names))
(define-inline (HClass-names-set! o::HClass v::vector) (set! (-> |#!bigloo_wallow| o names) v))
(define-inline (HClass-class-mro::vector o::HClass) (-> |#!bigloo_wallow| o class-mro))
(define-inline (HClass-class-mro-set! o::HClass v::vector) (set! (-> |#!bigloo_wallow| o class-mro) v))
))
