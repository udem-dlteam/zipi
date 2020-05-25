(define (pyc-intrinsics this conf)
   (need-intrinsics this conf)
   this)

(define-walk-method (need-intrinsics this::PycNode conf)
   this)

(define-walk-method (need-intrinsics this::PycModule conf)
   (pp 1))
