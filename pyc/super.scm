(define (pyc-super this conf)
   (mark-super this #f #f)
   this)

;; Add a reference to their class to the function which may use super
(define-walk-method (mark-super this::PycNode fun class)
   (call-default-walker))

 (define-walk-method (mark-super this::PycClass fun class)
    (mark-super (PycFun-body this) #f class)
    this)

(define-walk-method (mark-super this::PycFun fun class)
   (mark-super (PycFun-body this) this class)
   this)

(define-walk-method (mark-super this::PycVar fun class)
   (if (and fun class)
       #t
       #f))
