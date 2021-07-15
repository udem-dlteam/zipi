(define (pyc-sexp exp conf)
  (sexp exp #t 'global conf))

(define (my-gensym sym)
    (let ((i gensym-count))
      (set! gensym-count (+ i 1))
      (string->symbol (string-append "$" (symbol->string sym) "_" (number->string i)))))
(define gensym-count 0)

(define (collect-annotation-info arg-info args-vars loc scope conf)
  (define (get-var id)
    ;; there should always exist a var by id
    (let loop ((vars args-vars))
      (if (eq? id (PycVar-id (car vars)))
        (car vars)
        (loop (cdr vars)))))

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
                  (cons (get-var name) names-acc)
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
      (let* ((args-vars
              (map (lambda (a)
                     (new-PycVar '(-1 -1) (car a) 'local))
                   (car args)))
             (posonly-vars
               (map (lambda (a)
                      (new-PycVar '(-1 -1) (car a) 'local))
                    (cadr args)))
             (vararg-var
               (let ((a (caddr args)))
                 (if a
                     (new-PycVar '(-1 -1) (car a) 'local)
                     (new-PycUninit loc))))
             (kwonly-vars
               (map (lambda (a)
                      (new-PycVar '(-1 -1) (car a) 'local))
                    (list-ref args 3)))
             (kwarg-var
               (let ((a (list-ref args 5)))
                 (if a
                     (new-PycVar '(-1 -1) (car a) 'local)
                     (new-PycUninit loc))))
             (all-vars
               (append
                 args-vars
                 posonly-vars
                 kwonly-vars
                 (if (PycUninit? vararg-var) '() (list vararg-var))
                 (if (PycUninit? kwarg-var) '() (list kwarg-var))))
             (annotation-info (collect-annotation-info args all-vars loc scope conf))
             (annotation-names (car annotation-info))
             (annotation (cdr annotation-info)))
     (new-PycFun
       loc
       ;; args
       args-vars
       ;; posonlyargs
       posonly-vars
       ;; vararg
       vararg-var
       ;; kwonlyargs
       kwonly-vars
       ;; kw-defaults
       (map (lambda (a)
              (sexp a tail scope conf))
            (list-ref args 4))
       ;; kwarg
       kwarg-var
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
     (let* ((args-vars
             (map (lambda (a)
                    (new-PycVar '(-1 -1) (car a) 'local))
                  (car args)))
            (posonly-vars
              (map (lambda (a)
                     (new-PycVar '(-1 -1) (car a) 'local))
                   (cadr args)))
            (vararg-var
              (let ((a (caddr args)))
                (if a
                    (new-PycVar '(-1 -1) (car a) 'local)
                    (new-PycUninit loc))))
            (kwonly-vars
              (map (lambda (a)
                     (new-PycVar '(-1 -1) (car a) 'local))
                   (list-ref args 3)))
            (kwarg-var
              (let ((a (list-ref args 5)))
                (if a
                    (new-PycVar '(-1 -1) (car a) 'local)
                    (new-PycUninit loc))))
            (all-vars
              (append
                args-vars
                posonly-vars
                kwonly-vars
                (if (PycUninit? vararg-var) '() (list vararg-var))
                (if (PycUninit? kwarg-var) '() (list kwarg-var))))
            (annotation-info (collect-annotation-info args all-vars loc scope conf))
            (annotation-names (car annotation-info))
            (annotation (cdr annotation-info)))
      (new-PycAssig
        loc
        (new-PycRefUnresolved loc id 'Store)
        (new-PycFun
          loc
          ;; args
          args-vars
          ;; posonlyargs
          posonly-vars
          ;; vararg
          vararg-var
          ;; kwonlyargs
          kwonly-vars
          ;; kw-defaults
          (map (lambda (a)
                 (sexp a tail scope conf))
               (list-ref args 4))
          ;; kwarg
          kwarg-var
          ;; defaults
          (map (lambda (a)
                 (sexp a tail scope conf))
               (list-ref args 6))
          (let* ((body-node (compile-stmt* loc body #f 'local conf))
                 (stmts (PycSeq-nodes body-node)))
            (PycSeq-nodes-set!
              body-node
              (append
                stmts
                (list (new-PycReturn loc (new-PycNone loc #f))))) ;; implicit return
            body-node)
          decorators: (map
                        (lambda (d) (sexp d #f scope conf)) decorator_list)
          name: id
          annotation: annotation
          annotation-names: annotation-names))))
    ((ClassDef ?loc ?id ?bases ?keywords ?body ?decorator_list)
     ;; ClassDef(identifier name,
     ;;       expr* bases,
     ;;       keyword* keywords,
     ;;       stmt* body,
     ;;       expr* decorator_list)
     (new-PycAssig loc (new-PycRefUnresolved loc id 'Store)
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
         (let* ((id (gensym '%tmp))
                (block-var (new-PycVar '(-1 -1) id 'block))
                (block-assig
                  (new-PycAssig
                    loc
                    (new-PycRef loc block-var 'Store)
                    (sexp value #f scope conf))))
           (let loop ((targets targets)
                      (assigs '()))
             (if (null? targets)
                 (new-PycBlock loc (list block-assig) (new-PycSeq loc assigs))
                 (let ((target (sexp (car targets) #f scope conf)))
                  (loop (cdr targets)
                        (cons
                          (new-PycAssig
                            loc
                            target
                            (new-PycRef (PycNode-loc target) block-var 'Store))
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
     (let ((exc-var (new-PycVar '(-1 -1) 'exc 'block)))
      (new-PycTry loc (compile-stmt* loc body #f scope conf)
                  (map (lambda (h) (compile-handler h scope exc-var conf)) handlers)
                  (compile-stmt* loc orelse #f scope conf)
                  (compile-stmt* loc finally #f scope conf)
                  exc-var)))

    ((Import ?loc ?aliases)
     ;; Import(alias* names)
     (if (null? (cdr aliases))
         (compile-import loc (car aliases) conf)
         (new-PycSeq loc
                     (map (lambda (a) (compile-import loc a conf))
                          aliases))))
    ((ImportFrom ?loc ?module ?aliases ?level)
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
     (let ((left-value (sexp left #f scope conf))
           (right-values
             (map
               (lambda (v) (sexp v #f scope conf))
               rights)))
       (if (pair? (cdr ops))
           (new-PycChainCmp loc
                          (map compare-operator ops)
                          left-value
                          right-values)
           (new-PycBinary loc
                          (compare-operator (car ops))
                          left-value
                          (car right-values)))))
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
       ((Load) (new-PycRefUnresolved loc id 'Load))
       ((Store) (new-PycRefUnresolved loc id 'Store))
       ((Del) (new-PycRefUnresolved loc id 'Del))
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
          (new-PycUnimplemented (cadr exp) "syntax not implemented")))))

(define (subscript loc obj exp scope conf)
  (match-case exp
    ((Slice ?loc ?lower ?upper ?step)
    ;; Slice(expr? lower, expr? upper, expr? step)
      (new-PycSlice loc (sexp obj #f scope conf)
        (if lower (sexp lower #f scope conf) (new-PycUninit loc))
        (if upper (sexp upper #f scope conf) (new-PycUninit loc))
        (if step (sexp step #f scope conf) (new-PycUninit loc))))
    (else
      (new-PycSubscript loc
        (sexp obj #f scope conf)
        (sexp exp #f scope conf)))))

(define (compile-handler handler scope exc-var conf)
  (match-case handler
    ((ExceptHandler ?loc ?type ?name ?body)
     (let ((expr (if type (sexp type #f scope conf) (new-PycUninit loc))))
       (if name
           (let ((handler-body
                    (new-PycSeq
                      loc
                      (list
                        (new-PycAssig
                          loc
                          (new-PycRefUnresolved
                             loc
                             name
                             'Store)
                          (new-PycRef loc exc-var 'Load))
                        (compile-stmt* loc body #f scope conf)))))
             (new-PycHandler loc exc-var expr handler-body))
           (new-PycHandler loc exc-var expr (compile-stmt* loc body #f scope conf)))))
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

(define (compile-import loc alias conf)
   (match-case alias
      ((?name #f)
       ;; no alias
       (let ((name-split (string-split (symbol->string name) ".")))
        (if (pair? (cdr name-split))
            ;; package import
            (new-PycSeq
              loc
              (list
                ;; according to cPython: full import done before assignment
                (new-PycImport loc (symbol->string name) '() 0)
                (new-PycAssig
                  loc
                  (new-PycRefUnresolved loc (string->symbol (car name-split)) 'Store)
                  (new-PycImport loc (car name-split) '() 0))))
            ;; module import
            (new-PycAssig
              loc
              (new-PycRefUnresolved loc name 'Store)
              (new-PycImport loc (symbol->string name) '() 0)))))
      ((?name ?sym)
       ;; alias
       (new-PycAssig
         loc
         (new-PycRefUnresolved loc sym 'Store)
         (new-PycImport loc (symbol->string name) '() 0)))
      (else
       (error "import" "Unsupported form" alias))))


(define (compile-import-from loc module aliases level conf)

  ;; module can be #f in the case of from . import x
  (let* ((module-str (if module (symbol->string module) ""))
         (module-var (new-PycVar '(-1 -1) '%mod 'block))
         (module-assig
           (new-PycAssig
             loc
             (new-PycRef loc module-var 'Store)
             (new-PycImport loc module-str (map (lambda (x) (symbol->string (car x))) aliases) level))))
   (new-PycBlock loc
     (list module-assig)
     (new-PycSeq loc
       (map (lambda (alias)
              (match-case alias
                ((?name #f)
                 (new-PycAssig loc
                   (new-PycRefUnresolved loc name 'Store)
                   (new-PycAccess loc (new-PycRef loc module-var 'Load) name)))
                ((?name ?sym)
                 (new-PycAssig loc
                   (new-PycRefUnresolved loc sym 'Store)
                   (new-PycAccess loc (new-PycRef loc module-var 'Load) name)))
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
