(define (pyc-super this conf)
   (mark-super this #f #f)
   this)

;; Add a reference to their class to the function which may use super
(define-walk-method (mark-super this::PycNode fun class)
   (call-default-walker))

(define-walk-method (mark-super this::PycClass fun class)
   (let ((cls-key (my-gensym '%cls)))
     (PycClass-super-key-set! this cls-key)
     (mark-super (PycClass-body this) #f this)
     this))

(define-walk-method (mark-super this::PycFun fun class)
   (mark-super (PycFun-body this) this class)
   this)

(define-walk-method (mark-super this::PycRefUnresolved fun class)
  (if (and fun class (eq? (PycRefUnresolved-id this) 'super))
    (PycFun-super-in-class-set! fun (PycClass-super-key class))))
