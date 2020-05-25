(define (pyc-intrinsics this conf)
   (need-intrinsics this conf)
   this)

(define-walk-method (need-intrinsics this::PycNode conf)
   this)

(define-walk-method (need-intrinsics this::PycModule conf)
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
    (if fst-line-stmt
      (cond
        ((PycDeclInit? fst-line-stmt)
          (let ((val (PycDeclInit-val fst-line-stmt)))
            (if (and (PycImport? val)
                     (equal? (PycImport-path val) "__compiler_intrinsics__"))
              (error "SyntaxError" "cannot import __compiler_intrinsics__ as a module" #f))))
        ((PycBlock? fst-line-stmt)
          (let* ((decls (PycBlock-decls fst-line-stmt))
                (fst-decl (car decls)))
            (if (PycVar? fst-decl)
              (let ((val (PycDeclInit-val fst-decl)))
                (if (and (PycImport? val)
                         (equal? (PycImport-path val) "__compiler_intrinsics__"))
                  #t)))))))
    this))
