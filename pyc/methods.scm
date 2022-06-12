;; This module annotates methods (functions within a class) as to compile
;; a "pending-binding" version of the method. This prevent the formation fo closure (binding)
;; when calling methods.

(define (pyc-methods this conf)
  (collect-methods this)
  this)

(define (PycClass-methods-add class method)
  (PycClass-methods-set! class (cons method (PycClass-methods class))))

(define (collect-methods this)
  (collect-methods* this #f))

(define (make-method-id method class)
  (my-gensym
    (string->symbol
      (string-append
        (PycClass-name class)
        "."
        (symbol->string (PycFun-name method))))))

(define-walk-method (collect-methods* this::PycNode class)
  (call-default-walker))

(define-walk-method (collect-methods* this::PycAssig class)
  (let ((lhs (PycAssig-lhs this))
        (rhs (PycAssig-rhs this)))
    (if (and class (isa? lhs PycRef) (isa? rhs PycFun))
      (let ((var (PycRef-decl lhs)))
        (PycFun-method-var-set! rhs var)
        (PycFun-method-of-set! rhs class)
        (PycClass-methods-add class rhs)
        (cons this (call-default-walker)))
      (call-default-walker))))

(define-walk-method (collect-methods* this::PycFun class)
  (collect-methods* (PycFun-body this) #f))

(define-walk-method (collect-methods* this::PycClass class)
  (collect-methods* (PycClass-body this) this))
