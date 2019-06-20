(define (py->list this)
   (if (PyNode? this)
       (pynode->list this)
       `(alien :typeof ,(string->symbol (typeof this)) :expr ,this)))

(define-walk-method (pynode->list this::PyNode)
   `(,(string->symbol (typeof this))))

(define-walk-method (pynode->list this::PyModule)
   `(,(string->symbol (typeof this))
     :version ,(PyModule-version this)
     :ident ,(PyModule-ident this)
     ,@(map pynode->list (PyModule-stmts this))))

(define-walk-method (pynode->list this::PySeq)
   `(,(string->symbol (typeof this)) ,@(map pynode->list (PySeq-nodes this))))

(define-walk-method (pynode->list this::PyBlock)
   `(,(string->symbol (typeof this))
     ,(map pynode->list (PyBlock-decls this))
     ,(pynode->list (PyBlock-body this))))

(define-walk-method (pynode->list this::PyAssig)
   `(,(string->symbol (typeof this))
     ,(pynode->list (PyAssig-lhs this))
     ,(pynode->list (PyAssig-rhs this))))

(define-walk-method (pynode->list this::PyIf)
   `(,(string->symbol (typeof this))
     ,(pynode->list (PyIf-test this))
     ,(pynode->list (PyIf-then this))
     ,(pynode->list (PyIf-else this))))

(define-walk-method (pynode->list this::PyDecl)
   `(,(string->symbol (typeof this))
     :scope ,(PyDecl-scope this)
     :key ,(PyDecl-key this)
     ,(PyDecl-id this)))

(define-walk-method (pynode->list this::PyDeclInit)
   `(,(string->symbol (typeof this))
     :scope ,(PyDecl-scope this)
     ,(PyDecl-id this) ,(pynode->list (PyDeclInit-val this))))

(define-walk-method (pynode->list this::PyReturn)
   `(,(string->symbol (typeof this))
     :tail ,(PyReturn-tail this)
     ,(pynode->list (PyReturn-val this))))

(define-walk-method (pynode->list this::PyReturnYield)
   `(,(string->symbol (typeof this))
     :generator ,(PyReturnYield-generator this)
     ,(pynode->list (PyReturnYield-val this))
     ,(pynode->list (PyReturnYield-kont this))))

(define-walk-method (pynode->list this::PyStmtExpr)
   `(,(string->symbol (typeof this))
     ,(pynode->list (PyStmtExpr-expr this))))

(define-walk-method (pynode->list this::PyYield)
   `(,(string->symbol (typeof this))
     :generator ,(PyYield-generator this)
     ,(pynode->list (PyYield-val this))))

(define-walk-method (pynode->list this::PyPragma)
   `(,(string->symbol (typeof this))
     :lang ,(PyPragma-lang this)
     ,(PyPragma-expr this)))

(define-walk-method (pynode->list this::PyUninit)
   `(,(string->symbol (typeof this))))

(define-walk-method (pynode->list this::PyLiteral)
   `(,(string->symbol (typeof this)) ,(PyLiteralValue-val this)))

(define-walk-method (pynode->list this::PyRef)
   `(,(string->symbol (typeof this))
     ,(PyDecl-id (PyRef-decl this))))

(define-walk-method (pynode->list this::PyRefUnresolved)
   `(,(string->symbol (typeof this)) ,(PyRefUnresolved-id this)))

(define-walk-method (pynode->list this::PyFun)
   `(,(string->symbol (typeof this))
     :need-return ,(PyFun-need-return this)
     :can-locals ,(PyFun-can-locals this)
     :args ,(map pynode->list (PyFun-args this))
     ,(pynode->list (PyFun-body this))))

(define-walk-method (pynode->list this::PyKont)
   `(,(string->symbol (typeof this))
     (,(pynode->list (PyKont-param this))
      ,(pynode->list (PyKont-exn this)))
     ,(pynode->list (PyKont-body this))))

(define-walk-method (pynode->list this::PyCall)
   `(,(string->symbol (typeof this))
     ,(pynode->list (PyCall-fun this))
     ,@(map pynode->list (PyCall-args this))))

(define-walk-method (pynode->list this::PyBinary)
   `(,(string->symbol (typeof this))
     ,(PyBinary-op this)
     ,(pynode->list (PyBinary-lhs this))
     ,(pynode->list (PyBinary-rhs this))))
