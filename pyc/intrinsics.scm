(define (pyc-intrinsics this conf)
   (intrinsics this conf))

(define (collect-import-intrinsics nodes)
  (if (null? nodes)
    '()
    (cons
      (PycRefUnresolved-id (PycAssig-lhs (car nodes)))
      (collect-import-intrinsics (cdr nodes)))))

(define (remove-stmt stmts target-stmt)
  (cond
    ((null? stmts)
      '())
    ((eq? (car stmts) target-stmt)
      (cdr stmts))
    (else
      (cons (car stmts) (remove-stmt (cdr stmts) target-stmt)))))

(define (intrinsics this conf)
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
              (error "SyntaxError" "cannot import __compiler_intrinsics__ as a module" #f)
              this)))
        ((PycBlock? fst-line-stmt)
          (let* ((decls (PycBlock-decls fst-line-stmt))
                (fst-decl (car decls)))
            (if (PycVar? fst-decl)
              (let ((val (PycDeclInit-val fst-decl)))
                (if (and (PycImport? val)
                         (equal? (PycImport-path val) "__compiler_intrinsics__"))
                  (let* ((nodes (PycSeq-nodes (PycBlock-body fst-line-stmt)))
                         (intrinsics (collect-import-intrinsics nodes)))
                    (PycModule-stmts-set!
                      this
                      (remove-stmt
                        (PycModule-stmts this)
                        fst-line-stmt))
                    (use-intrinsics! this intrinsics))
                  this))
              this)))
        (else this))))

(define valid-intrinsic
  '(define_semantics use_static_builtins use_simple_scoping class_getattr absent))

(define (check-invalid-intrinsics intrinsics)
  (cond
    ((null? intrinsics)
      #t)
    ((member (car intrinsics) valid-intrinsic)
      (check-invalid-intrinsics (cdr intrinsics)))
    (else
      (error "SyntaxError" "invalid __compiler_intrinsics__" (car intrinsics)))))

(define (use-intrinsics! this intrinsics)
  (check-invalid-intrinsics intrinsics)
  (check-no-intrinsics-assignation this intrinsics)
  (pp intrinsics)
  this)

(define-walk-method (check-no-intrinsics-assignation this::PycNode intrinsics)
  (call-default-walker))

(define-walk-method (check-no-intrinsics-assignation this::PycDecl intrinsics)
  (if (member (PycDecl-id this) intrinsics)
    (error "SyntaxError" "cannot use compiler intrinsic as name" (PycDecl-id this)))
  (call-default-walker))

(define-walk-method (check-no-intrinsics-assignation this::PycAssig intrinsics)
  (let ((lhs (PycAssig-lhs this)))
    (if (and
          (PycRefUnresolved? lhs)
          (member (PycRefUnresolved-id lhs) intrinsics))
      (error "SyntaxError" "cannot use compiler intrinsic as name" (PycRefUnresolved-id lhs)))
    (call-default-walker)))
