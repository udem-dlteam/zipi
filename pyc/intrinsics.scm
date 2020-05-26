(define (pyc-intrinsics this conf)
   (intrinsics this conf))

(define intrinsic-nodes
  (list
    (cons 'absent PycStatic)
    (cons 'class_getattr PycMacro)
    (cons 'define_semantics PycSemantics)))

(define (collect-intrinsics block)
  (let ((seq (PycBlock-body block)))
    (let loop ((nodes (PycSeq-nodes seq)))
      (if (null? nodes)
        nodes
        (cons
          (PycRefUnresolved-id (PycAssig-lhs (car nodes)))
          (loop (cdr nodes)))))))

(define (remove-stmt stmts target-stmt)
  (cond
    ((null? stmts)
      '())
    ((eq? (car stmts) target-stmt)
      (cdr stmts))
    (else
      (cons (car stmts) (remove-stmt (cdr stmts) target-stmt)))))

(define-walk-method (intrinsics this::PycNode conf)
   (error "intrinsics::PycNode" "intrinsics driver must be called on module" this))

(define-walk-method (intrinsics this::PycModule conf)
  (let ((fst-line-stmt
          (let loop ((stmts (PycModule-stmts this)))
            (if (null? stmts)
              #f
              (let* ((stmt (car stmts))
                     (loc (PycNode-loc stmt))
                     (lineno (car loc))
                     (col-offset (cadr loc)))
                (if (and (>= lineno 0) (>= col-offset 0))
                  stmt
                  (loop (cdr stmts))))))))
      (cond
        ((not fst-line-stmt) this)
        ((PycDeclInit? fst-line-stmt)
          (let ((val (PycDeclInit-val fst-line-stmt)))
            (if (and (PycImport? val)
                     (equal? (PycImport-path val) "__compiler_intrinsics__"))
              (error "SyntaxError" "cannot import __compiler_intrinsics__ as a module" #f))
              this))
        ((PycBlock? fst-line-stmt)
          (let* ((decls (PycBlock-decls fst-line-stmt))
                (fst-decl (car decls)))
            (if (PycVar? fst-decl)
              (let ((val (PycDeclInit-val fst-decl)))
                (if (and (PycImport? val)
                         (equal? (PycImport-path val) "__compiler_intrinsics__"))
                  (let ((intrinsics (collect-intrinsics fst-line-stmt)))
                    (PycModule-stmts-set!
                      this
                      (remove-stmt
                        (PycModule-stmts this)
                        fst-line-stmt))
                    (use-intrinsics this intrinsics))
                  this))
              this))))))

(define (use-intrinsics this intrinsics)
  (no-intrinsics-assignation this intrinsics)
  this)

(define-walk-method (no-intrinsics-assignation this::PycNode intrinsics)
  (call-default-walker))

(define-walk-method (no-intrinsics-assignation this::PycDecl intrinsics)
  (if (assoc (PycDecl-id this) intrinsic-nodes)
    (error "SyntaxError" "cannot use compiler intrinsic as name" (PycDecl-id this)))
  (call-default-walker))

(define-walk-method (no-intrinsics-assignation this::PycAssig intrinsics)
  (let ((lhs (PycAssig-lhs this)))
    (if (and
          (PycRefUnresolved? lhs)
          (assoc (PycRefUnresolved-id lhs) intrinsic-nodes))
      (error "SyntaxError" "cannot use compiler intrinsic as name" (PycRefUnresolved-id lhs)))
    (call-default-walker)))
