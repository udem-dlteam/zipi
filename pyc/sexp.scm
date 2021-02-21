(define (pyc-sexp exp conf)
  (sexp exp #t 'global conf))

(define (my-gensym sym)
    (let ((i gensym-count))
      (set! gensym-count (+ i 1))
      (string->symbol (string-append "$" (symbol->string sym) "_" (number->string i)))))
(define gensym-count 0)

(define (collect-annotation-info arg-info loc scope conf)
  (let* ((posonly (car arg-info))
        (args (cadr arg-info))
        (vararg (caddr arg-info))
        (kwonly (cadddr arg-info))
        (kwarg (list-ref arg-info 5))
        (chained-args (append
                        posonly
                        args
                        (if vararg (list vararg) '())
                        kwonly
                        (if kwarg (list kwarg) '()))))
    (let loop ((chained-args chained-args) (names-acc '()) (ann-acc '()))
      (if (null? chained-args)
        (cons (reverse names-acc) (reverse ann-acc))
        (let* ((arg (car chained-args))
               (name (car arg))
               (ann (cadr arg)))
          (if ann
            (loop (cdr chained-args)
                  (cons name names-acc)
                  (cons (sexp ann #f scope conf) ann-acc))
            (loop (cdr chained-args)
                  (cons (new-PycUninit loc) names-acc)
                  (cons (new-PycUninit loc) ann-acc))))))))

;; The Python syntax parsed by this function is defined at the url:
;;    https://docs.python.org/3.8/library/ast.html
(define (sexp exp tail scope conf)
  (when (pair? exp)
    (match-case (car exp)
       ;; language detection
       ((Expr ?loc (Str ?loc ?lang))
        (when (and (pair? exp) (string? (car exp)))
          (let ((p (memq language: conf)))
           (if (pair? p)
               (set-car! (cdr p) lang)
               (set-cdr! (last-pair conf) (list language: lang))))))))
  (match-case exp
    ;; mod
    ((Module ?loc ?body . ?type_ignors)
     ;; Module(stmt* body, type_ignore *type_ignores)
     (new-PycModule loc "???"
                    (compile* loc body #t 'global conf)))

    ;; lambda
    ((Lambda ?loc ?args ?body . ?type_comment)
      (let* ((annotation-info (collect-annotation-info args loc scope conf))
             (annotation-names (car annotation-info))
             (annotation (cdr annotation-info)))
     (new-PycFun
       loc
       ;; args
       (map (lambda (a)
              (new-Var (car a) 'local))
            (car args))
       ;; posonlyargs
       (map (lambda (a)
              (new-Var (car a) 'local))
            (cadr args))
       ;; vararg
       (let ((a (caddr args)))
         (if a
             (new-Var (car a) 'local)
             (new-PycUninit loc)))
       ;; kwonlyargs
       (map (lambda (a)
              (new-Var (car a) 'local))
            (list-ref args 3))
       ;; kw-defaults
       (map (lambda (a)
              (sexp a tail scope conf))
            (list-ref args 4))
       ;; kwarg
       (let ((a (list-ref args 5)))
         (if a
             (new-Var (car a) 'local)
             (new-PycUninit loc)))
       ;; defaults
       (map
         (lambda (a)
           (sexp a tail scope conf))
         (list-ref args 6))

       ;; body
       (let* ((body-ast (sexp body #t 'local conf))
              (body-loc (PycNode-loc body-ast)))
         (new-PycSeq body-loc (list (new-PycReturn body-loc body-ast))))
      annotation: annotation
      annotation-names: annotation-names)))

    ;; stmt
    ((FunctionDef ?loc ?id ?args ?body ?decorator_list ?returns . ?type_comment)
     ;; FunctionDef(identifier name, arguments args,
     ;;             stmt* body, expr* decorator_list, expr? returns,
     ;;             string? type_comment)
     (let* ((annotation-info (collect-annotation-info args loc scope conf))
            (annotation-names (car annotation-info))
            (annotation (cdr annotation-info)))
      (new-PycAssig
        (new-PycRefUnresolved id)
        (new-PycFun
          loc
          ;; args
          (map (lambda (a)
                 (new-PycVar (car a) 'local))
               (car args))
          ;; posonlyargs
          (map (lambda (a)
                 (new-PycVar (car a) 'local))
               (cadr args))
          ;; vararg
          (let ((a (caddr args)))
            (if a
                (new-PycVar (car a) 'local)
                (new-PycUninit loc)))
          ;; kwonlyargs
          (map (lambda (a)
                 (new-PycVar (car a) 'local))
               (list-ref args 3))
          ;; kw-defaults
          (map (lambda (a)
                 (sexp a tail scope conf))
               (list-ref args 4))
          ;; kwarg
          (let ((a (list-ref args 5)))
            (if a
                (new-PycVar (car a) 'local)
                (new-PycUninit loc)))
          ;; defaults
          (map (lambda (a)
                 (sexp a tail scope conf))
               (list-ref args 6))
          (compile-stmt* loc body #t 'local conf)
          decorators: (map
                        (lambda (d) (sexp d #f scope conf)) decorator_list)
          name: id
          annotation: annotation
          annotation-names: annotation-names)))
    ((ClassDef ?loc ?id ?bases ?keywords ?body ?decorator_list)
     ;; ClassDef(identifier name,
     ;;       expr* bases,
     ;;       keyword* keywords,
     ;;       stmt* body,
     ;;       expr* decorator_list)
     (new-PycAssig loc (new-PycRefUnresolved loc id)
                   (new-PycClass loc
                                 (symbol->string id)
                                 (config-get conf module: "__main__")
                                 (map (lambda (b) (sexp b #f scope conf)) bases)
                                 (compile-stmt* loc body #f 'local conf)
                                 decorators: (map (lambda (b) (sexp b #f scope conf)) decorator_list))))
    ((Return ?loc ?expr)
     ;; Return(expr? value)
     (if expr
         (new-PycReturn loc (sexp expr #f scope conf))
         (new-PycReturn loc (new-PycNone loc #f))))
    ((Delete ?loc ?targets)
     ;; Delete(expr* targets)
     (if (null? (cdr targets))
         (new-PycDelete loc (sexp (car targets) #f scope conf))
         (new-PycSeq loc
                     (map (lambda (t)
                            (new-PycDelete loc (sexp t #f scope conf)))
                          targets))))
    ((Assign ?loc ?targets ?value . ?type_comment)
     ;; Assign(expr* targets, expr value, string? type_comment)
     (if (null? (cdr targets))
         (new-PycAssig loc
                       (sexp (car targets) #f scope conf)
                       (sexp value #f scope conf))
         (let* ((id (gensym 'tmp))
                (var (new-PycVar loc id 'block (sexp value #f scope conf))))
           (let loop ((targets targets)
                      (assigs '()))
             (if (null? targets)
                 (new-PycBlock loc (list var)
                               (new-PycSeq loc assigs))
                 (let ((ref (sexp (car targets) #f scope conf)))
                  (loop (cdr targets)
                        (cons (new-PycAssig loc ref
                                            (new-PycRefUnresolved (PycNode-loc ref) id))
                              assigs))))))))
    ((AugAssign ?loc ?target ?op ?value . ?type_comment)
     ;; AugAssign(expr target, operator op, expr value)
     (new-PycAugAssig loc
                      (sexp target #f scope conf)
                      (sexp value #f scope conf)
                      (binary-operator op 'AugAssign)))
    ((AnnAssign ?loc ?target ?annotation ?value ?simple)
     ;; AnnAssign(expr target, expr annotation, expr? value, int simple)
     (if value
         (new-PycAssig loc
                       (sexp target #f scope conf)
                       (sexp value #f scope conf))
         (new-PycUninit loc)))
    ((For ?loc ?target ?iter ?body ?orelse . ?type_comment)
     ;; For(expr target, expr iter, stmt* body, stmt* orelse, string? type_comment)
     (new-PycFor loc
                 (compile-stmt* loc body #f scope conf)
                 (compile-stmt* loc orelse #f scope conf)
                 (sexp target #f scope conf)
                 (sexp iter #f scope conf)))
    ((While ?loc ?test ?body ?orelse)
     ;; While(expr test, stmt* body, stmt* orelse)
     (new-PycWhile loc
                   (compile-stmt* loc body #f scope conf)
                   (compile-stmt* loc orelse tail scope conf)
                   (sexp test #f scope conf)))

    ((If ?loc ?test ?body ?otherwise)
     ;; If(expr test, stmt* body, stmt* orelse)
     (new-PycIf loc (sexp test #f scope conf)
                (compile-stmt* loc body tail scope conf)
                (compile-stmt* loc otherwise tail scope conf)))
    ((IfExp ?loc ?test ?body ?orelse)
     (new-PycIfExp
       loc
       (sexp test #f scope conf)
       (sexp body tail scope conf)
       (sexp orelse tail scope conf)))
    ((With ?loc ?items ?body . ?type_comment)
     (new-PycWith
       loc
       (map
         (lambda (item)
           (new-PycWithItem
             loc
             (sexp (car item) #f scope conf)
             (if (cadr item)
                 (sexp (cadr item) #f scope conf)
                 (new-PycUninit loc)))) ;; TODO: is that the correct usecase of PycUninit?
         items)
       (compile-stmt* loc body tail scope conf)))
    ;; With(withitem* items, stmt* body, string? type_comment)
    ((Raise ?loc ?exc ?cause)
     ;; Raise(expr? exc, expr? cause)
     (new-PycRaise loc
                   (if exc (sexp exc #f scope conf) (new-PycUninit loc))
                   (if cause (sexp cause #f scope conf) (new-PycUninit loc))))
    ((Try ?loc ?body ?handlers ?orelse ?finally)
     ;; Try(stmt* body, excepthandler* handlers, stmt* orelse, stmt* finalbody)
     (let ((handlers-exc-sym (my-gensym '%exc)))
      (new-PycTry loc (compile-stmt* loc body #f scope conf)
                  (map (lambda (h) (compile-handler h scope handlers-exc-sym conf)) handlers)
                  (compile-stmt* loc orelse #f scope conf)
                  (compile-stmt* loc finally #f scope conf)
                  handlers-exc-sym)))

    ((Import ?loc ?aliases)
     ;; Import(alias* names)
     (if (null? (cdr aliases))
         (compile-import loc (car aliases) conf)
         (new-PycSeq loc
                     (map (lambda (a) (compile-import loc a conf))
                          aliases))))
    ((ImportFrom ?loc ?module ?aliases . ?level)
     ;; ImportFrom(identifier? module, alias* names, int? level)
     (compile-import-from loc module aliases level conf))
    ((Global ?loc ?names)
     ;; Global(identifier* names)
     (new-PycSymbols loc 'global names))
    ((Nonlocal ?loc ?names)
     ;; Nonlocal(identifier* names)
     (new-PycSymbols loc 'nonlocal names))
    ((Expr ?loc ?value)
     ;; Expr(expr value)
     (new-PycStmtExpr loc
                      (sexp value tail scope conf)))

    ((Pass ?loc)
     ;; Pass
     (new-PycPass loc))
    ((Break ?loc)
     ;; Continue
     (new-PycBreak loc))
    ((Continue ?loc)
     ;; Continue
     (new-PycContinue loc))

    ;; expr
    ((Num ?loc ?val)
     (new-PycNumber loc (string->number val)))
    ((Str ?loc ?val)
     (new-PycString loc val))
    ((Constant ?loc ?val ?string)
     ;; Constant(constant value, string? kind) [3.8]
     (cond
       ((or string (string? val))
        (new-PycString loc val))
       ((eq? val 'False)
        (new-PycBool loc #f))
       ((eq? val 'True)
        (new-PycBool loc #t))
       ((eq? val 'None)
        (new-PycNone loc #f))
       (else
         (new-PycNumber loc val))))
    ((BinOp ?loc ?left ?op ?right)
     ;; BinOp(expr left, operator op, expr right)
     (new-PycBinary loc
                    (binary-operator op 'BinOp)
                    (sexp left #f scope conf)
                    (sexp right #f scope conf)
                    type: (op-type op)))
    ((BoolOp ?loc ?op ?args)
     (new-PycBoolOp
       loc
       (boolean-operator op)
       (map (lambda (a) (sexp a #f scope conf)) args)))
    ((UnaryOp ?loc ?op ?expr)
     ;; UnaryOp(unaryop op, expr operand)
     (new-PycUnary loc
                   (unary-operator op)
                   (sexp expr #f scope conf)))
    ((Dict ?loc ?keys ?values)
     ;; Dict(expr* keys, expr* values)
     (new-PycDict loc
                  (map (lambda (v) (sexp v #f scope conf)) values)
                  (map (lambda (k) (sexp k #f scope conf)) keys)))
    ((Set ?loc ?values)
     ;; Set(expr* values)
     (new-PycSet loc
                 (map (lambda (v) (sexp v #f scope conf)) values)))
    ((Yield ?loc ?value)
     (new-PycYield loc (sexp value tail scope conf)))
    ;; Yield(expr? value)
    ((Compare ?loc ?left ?ops ?rights)
     ;; Compare(expr left, cmpop* ops, expr* comparators)
     (if (pair? (cdr ops))
         (error "Compare" "Not implemented" ops)
         (let ((left-node (sexp left #f scope conf))
               (right-nodes (sexp (car rights) #f scope conf)))
           (new-PycBinary loc
                          (compare-operator (car ops))
                          left-node
                          right-nodes))))
    ((Call ?loc ?fun ?args ?keywords)
     ;; Call(expr func, expr* args, keyword* keywords)
     (new-PycCall loc
                  (sexp fun #f scope conf)
                  (map (lambda (a) (sexp a #f scope conf)) args)
                  keywords-values: (map (lambda (k) (sexp (cadr k) #f scope conf)) keywords)
                  keywords-names: (map car keywords)))
    ((Attribute ?loc ?value ?attr ?ctx)
     ;; Attribute(expr value, identifier attr, expr_context ctx)
     (new-PycAccess loc (sexp value #f scope conf) (symbol->string attr)))
    ((Subscript ?loc ?value ?slc ?ctx)
     (subscript loc value slc scope conf))
    ((Starred ?loc ?value ?ctx)
      (new-PycStarredExpr loc (sexp value #f scope conf)))
    ((Name ?loc ?id ?ctx)
     ;; Name(identifier id, expr_context ctx)
     (case ctx
       ((Load) (new-PycRefUnresolved loc id))
       ((Store) (new-PycRefUnresolved loc id))
       ((Del) (new-PycRefUnresolved loc id))
       (else (error "ctx" "Not implemented" ctx))))
    ((List ?loc ?elts ?ctx)
     ;; List(expr* elts, expr_context ctx)
     (new-PycList loc (map (lambda (e) (sexp e #f scope conf)) elts)))
    ((Tuple ?loc ?elts ?ctx)
     ;; Tuple(expr* elts, expr_context ctx)
     (new-PycTuple loc (map (lambda (e) (sexp e #f scope conf)) elts)))

    ((Assert ?loc ?test ?msg)
     (if msg
         (new-PycAssert loc (sexp test #f scope conf) (sexp msg #f scope conf))
         (new-PycAssert loc (sexp test #f scope conf) (new-PycUninit loc))))
    ((ListComp ?loc ?elt ?generators)
     (new-PycUnimplemented loc "list comprehension not implemented"))
    ((GeneratorExp ?loc ?elt ?generators)
     (new-PycUnimplemented loc "generator expression not implemented"))
    (else
      (if (eof-object? exp)
          (error "sexp" "premature eof" exp)
          (error "sexp" "Not implemented" exp)))))

(define (subscript loc obj exp scope conf)
   (match-case exp
      ((Slice ?loc ?lower ?upper ?step)
       ;; Slice(expr? lower, expr? upper, expr? step)
       (new-PycSlice loc (sexp obj #f scope conf)
	  (if lower (sexp lower #f scope conf) (new-PycUninit loc))
	  (if upper (sexp upper #f scope conf) (new-PycUninit loc))
	  (if step (sexp step #f scope conf) (new-PycUninit loc))))
      ((Index ?loc ?exp)
       ;; Index(expr value)
       (new-PycSubscript loc (sexp obj #f scope conf)
	  (sexp exp #f scope conf)))
      (else
       (error "slice" "Not implemented" exp))))

(define (compile-handler handler scope exc-sym conf)
  (match-case handler
    ((ExceptHandler ?loc ?type ?name ?body)
     (let ((expr
             (if type
                 (sexp type #f scope conf)
                 (new-PycUninit loc))))
       (if name
           (let ((body
                   (new-PycBlock loc
                     (list (new-PycVar loc
                             name
                             'block
                             (new-PycPragma loc exc-sym)))
                     (compile-stmt* loc body #f scope conf))))
             (new-PycHandler loc expr body))
           (new-PycHandler loc expr (compile-stmt* loc body #f scope conf)))))
    (else
      (error "sexp" "Wrong handler" handler))))

(define (compile-stmt* loc body tail scope conf)
   (if (null? body)
       (new-PycPass loc)
       (new-PycSeq loc
	  (let loop ((body body))
	     (if (null? (cdr body))
		 (list (sexp (car body) tail scope conf))
		 (cons (sexp (car body) #f scope conf) (loop (cdr body))))))))

(define (compile* loc body tail scope conf)
  (cond
    ((null? body)
      '())
    ((null? (cdr body))
      (list (sexp (car body) tail scope conf)))
    (else
      (cons
        (sexp (car body) #f scope conf)
        (compile* loc (cdr body) tail scope conf)))))

(define (import-prefix name)
   (let* ((s (symbol->string name))
	  (i (string-index s #\.)))
      (if i
	  (string->symbol (substring s 0 i))
	  name)))

(define (compile-import loc alias conf)
   (match-case alias
      ((?name #f)
       (let ((name-split (string-split (symbol->string name) ".")))
        (if (pair? (cdr name-split))
            (new-PycSeq
              loc
              (list
                (new-PycAssig
                  loc
                  (new-PycRefUnresolved loc (import-prefix name))
                  (new-PycImport loc (car name-split)))
                (new-PycImport loc (symbol->string name))))
            (new-PycAssig
              loc
              (new-PycRefUnresolved loc (import-prefix name))
              (new-PycImport loc (symbol->string name))))))
      ((?name ?sym)
       (new-PycAssig
         loc
         (new-PycRefUnresolved loc sym)
         (new-PycImport loc (symbol->string name))))
      (else
       (error "import" "Unsupported form" alias))))

(define (compile-import-from loc module aliases level conf)
  (let ((base (string-append (symbol->string module) "."))
        (module-ref
          (new-PycVar
             loc '%mod 'block
             (new-PycImport loc (symbol->string module)))))
   (new-PycBlock loc
     (list module-ref)
     (new-PycSeq loc
       (map (lambda (alias)
              (match-case alias
                ((?name #f)
                 (new-PycAssig loc
                   (new-PycRefUnresolved loc name)
                   (new-PycAccess loc (new-PycRef loc module-ref) name)))
                ((?name ?sym)
                 (new-PycAssig loc
                   (new-PycRefUnresolved loc sym)
                   (new-PycAccess loc (new-PycRef loc module-ref) name)))
                (else
                  (error "import-from" "Unsupported form" alias))))
            aliases)))))

(define (op-type op)
   (if (memq op '(< <= > >= ==))
       'bool
       'unknown))

(define (binary-operator op node)
   (case op
      ((Add)      (if (eq? node 'BinOp) 'add      'iadd))
      ((Div)      (if (eq? node 'BinOp) 'truediv  'itruediv))
      ((BitAnd)   (if (eq? node 'BinOp) 'bitand   'ibitand))
      ((BitOr)    (if (eq? node 'BinOp) 'bitor    'ibitor))
      ((BitXor)   (if (eq? node 'BinOp) 'xor      'ixor))
      ((FloorDiv) (if (eq? node 'BinOp) 'floordiv 'ifloordiv))
      ((LShift)   (if (eq? node 'BinOp) 'lshift   'ilshift))
      ((Mod)      (if (eq? node 'BinOp) 'mod      'imod))
      ((Mult)     (if (eq? node 'BinOp) 'mul      'imul))
      ((Pow)      (if (eq? node 'BinOp) 'pow      'ipow))
      ((RShift)   (if (eq? node 'BinOp) 'rshift   'irshift))
      ((Sub)      (if (eq? node 'BinOp) 'sub      'isub))
      (else
       (error "binary-operator" "Illegal operator" op))))

(define (unary-operator op)
   (case op
      ((Invert) 'invert)
      ((UAdd)   'pos)
      ((USub)   'neg)
      ((Not)    'not)
      (else
       (error "unary-operator" "Illegal operator" op))))

(define (boolean-operator op)
   (case op
      ((Or)  'or)
      ((And) 'and)
      (else
       (error "boolean-operator" "Illegal operator" op))))

(define (compare-operator op)
  (case op
    ((Lt)    'lt)
    ((LtE)    'le)
    ((Gt)    'gt)
    ((GtE)    'ge)
    ((Eq)    'eq)
    ((NotEq) 'ne)
    ((Is)    'is)
    ((IsNot) 'isnot)
    ((In)    'in)
    ((NotIn) 'notin)
    (else    (error "Compare" "Illegal operator" op))))

(define (config-get conf key . def)
   (let ((c (memq key conf)))
      (if c (cadr c) (if (pair? def) (car def) #f))))
