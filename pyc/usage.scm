(define (pyc-usage this conf)
   (mark-usage this conf)
   this)

(define-walk-method (mark-usage this::PycNode conf)
   (call-default-walker))

(define-walk-method (mark-usage this::PycAssig conf)
  (let ((lhs (PycAssig-lhs this)))
    (if (PycRef? lhs)
      (let ((decl (PycRef-decl lhs)))
        (PycDecl-usage-set! decl (cons 'assig (PycDecl-usage decl))))
        (mark-usage lhs conf))
    (mark-usage (PycAssig-rhs this) conf)))
