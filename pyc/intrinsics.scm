(define (pyc-intrinsics this conf)
   (intrinsics this conf))

(define intrinsic-names
  '(absent class_getattr define_semantics))

(define intrinsic-statics
  (list
    (cons 'absent 'py-absent)
    (cons 'AttributeError 'py-builtin-AttributeError)))

(define (make-class-getattr loc cls attr)
  (if (PycString? attr)
    (new-PycMacro
      loc
      'class_getattr
      (list cls attr))
    (error "SyntaxError" "class_getattr second argument must be a string literal" attr)))

(define intrinsic-macros
  (list
    (cons 'class_getattr make-class-getattr)))

(define intrinsic-decorators
  '(define_semantics))

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
                    (use-intrinsics this intrinsics))
                  this))
              this)))
        (else this))))

(define (use-intrinsics this intrinsics)
  ;; check intrinsics exist
  (let loop ((intr intrinsics))
    (cond
      ((null? intr) #t)
      ((member (car intr) intrinsic-names)
        (loop (cdr intr)))
      (else
        (error "SyntaxError" "compiler intrinsic does not exist" (car intr)))))
  (no-intrinsics-assignation this intrinsics)
  (convert-intrinsics! this intrinsics))

(define-walk-method (no-intrinsics-assignation this::PycNode intrinsics)
  (call-default-walker))

(define-walk-method (no-intrinsics-assignation this::PycDecl intrinsics)
  (if (member (PycDecl-id this) intrinsic-names)
    (error "SyntaxError" "cannot use compiler intrinsic as name" (PycDecl-id this)))
  (call-default-walker))

(define-walk-method (no-intrinsics-assignation this::PycAssig intrinsics)
  (let ((lhs (PycAssig-lhs this)))
    (if (and
          (PycRefUnresolved? lhs)
          (member (PycRefUnresolved-id lhs) intrinsic-names))
      (error "SyntaxError" "cannot use compiler intrinsic as name" (PycRefUnresolved-id lhs)))
    (call-default-walker)))

(define-walk-method (convert-intrinsics! this::PycNode intrinsics)
  (call-default-walker))

(define-walk-method (convert-intrinsics! this::PycRefUnresolved intrinsics)
  (let* ((loc (PycNode-loc this))
        (id (PycRefUnresolved-id this))
        (pair (assoc id intrinsic-statics)))
    (if pair
      (new-PycStatic loc id (cdr pair))
      (call-default-walker))))

(define-walk-method (convert-intrinsics! this::PycCall intrinsics)
  (let ((caller (PycCall-fun this))
        (loc (PycNode-loc this)))
    (if (PycRefUnresolved? caller)
      (let* ((caller-id (PycRefUnresolved-id caller))
             (pair (assoc caller-id intrinsic-macros)))
        (if pair
          (apply (cdr pair) loc (PycCall-args this))
          (call-default-walker)))
      (call-default-walker))))

(define-walk-method (convert-intrinsics! this::PycDeclInit intrinsics)
  (let* ((new-this (call-default-walker))
         (val (PycDeclInit-val new-this)))
    (if (PycSemantics? val)
      (let ((id (PycDecl-id this)))
        (PycIntrinsics-id-set! val id)
        val)
      new-this)))

(define-walk-method (convert-intrinsics! this::PycFun intrinsics)
  (let* ((decorators (PycFun-decorators this))
        (intrinsic-decorators
          (let loop ((decs decorators))
            (if (null? decs)
              '()
              (let ((d (car decs)))
                (if (and (PycRefUnresolved? d)
                         (member (PycRefUnresolved-id d) intrinsic-decorators))
                    (cons (PycRefUnresolved-id d) (loop (cdr decs)))
                    (loop (cdr decs))))))))
    (let ((intrinsic-decorators-length (length intrinsic-decorators))
          (decorators-length (length decorators)))
      (if (> intrinsic-decorators-length 0)
        (if (< intrinsic-decorators-length decorators-length)
          (error "SyntaxError" "intrinsic decorator cannot be used with other decorators" #f)
          (let ((args (PycFun-args this))
                (body (PycFun-body this)))
            (new-PycSemantics
              (PycNode-loc this)
              #f ;; set later when treating the assignation of this semantic
              args
              (convert-intrinsics! body intrinsics)
              intrinsic-decorators)))
        (call-default-walker)))))
