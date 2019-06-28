(define (pyc-sexp exp conf)
   (sexp exp #t 'global conf))

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
	  (cons
	     (new-PycDeclInit loc '__name__ scope
		(new-PycString loc (config-get conf 'module "__main__")))
	     (compile* loc body #t 'global conf))))
      
      ;; stmt
      ((FunctionDef ?loc ?id ?args ?body ?decorator_list ?returns . ?type_comment)
       ;; FunctionDef(identifier name, arguments args,
       ;;             stmt* body, expr* decorator_list, expr? returns,
       ;;             string? type_comment)
       (new-PycDeclInit loc id scope
	  (new-PycFun loc
	     (map (lambda (a)
		     (new-PycDecl loc (car a) 'local))
		(car args))
	     (compile-stmt* loc body #t 'local conf))))
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
	     (compile-stmt* loc body #f 'local conf))))
      ((Return ?loc ?expr)
       ;; Return(expr? value)
       (new-PycReturn loc (sexp expr #f scope conf) tail))
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
      ((With ?loc ?items ?body . ?type_comment)
       (if (and (pair? items) (null? (cdr items)))
	   (let ((item (car items)))
	      (if (cadr item)
		  (new-PycSeq loc
		     (list
			(new-PycAssig loc (sexp (cadr item) #f scope conf)
			   (sexp (car item) #f scope conf))
			(new-PycWith loc
			   (sexp (cadr item) #f scope conf)
			   (compile-stmt* loc body #f scope conf))))
		  (new-PycWith loc
		     (sexp (car item) #f scope conf)
		     (compile-stmt* loc body #f scope conf))))
	   (error "With" "Not implemented" exp)))
       ;; With(withitem* items, stmt* body, string? type_comment)
      ((Raise ?loc ?exc ?cause)
       ;; Raise(expr? exc, expr? cause)
       (new-PycRaise loc
	  (if exc (sexp exc #f scope conf) (new-PycUninit loc))
 	  (if cause (sexp cause #f scope conf) (new-PycUninit loc))))
      ((Try ?loc ?body ?handlers ?orelse ?finally)
       ;; Try(stmt* body, excepthandler* handlers, stmt* orelse, stmt* finalbody)
       (new-PycTry loc (compile-stmt* loc body #f scope conf)
	  (map (lambda (h) (compile-handler h scope conf)) handlers)
	  (compile-stmt* loc orelse #f scope conf)
	  (compile-stmt* loc finally #f scope conf)))

      ((Import ?loc ?aliases)
       ;; Import(alias* names)
       (if (null? (cdr aliases))
	   (compile-import loc (car aliases) scope conf)
	   (new-PycSeq loc
	      (map (lambda (a) (compile-import loc a scope conf))
		 aliases))))
      ((ImportFrom ?loc ?module ?aliases . ?level)
       ;; ImportFrom(identifier? module, alias* names, int? level)
       (compile-import-from loc module aliases scope conf))
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
       (if string
	   (new-PycString loc val)
	   (new-PycNumber loc val)))
      ((BinOp ?loc ?left ?op ?right)
       ;; BinOp(expr left, operator op, expr right)
       (new-PycBinary loc 
	  (binary-operator op 'BinOp)
	  (sexp left #f scope conf)
	  (sexp right #f scope conf)
	  type: (op-type op)))
      ((UnaryOp ?loc ?op ?expr)
       (new-PycUnary loc
	  (unary-operator op)
          (sexp expr #f scope conf)))
      
      ((Yield ?loc ?value)
       (new-PycYield loc (sexp value tail scope conf)))
      ;; Yield(expr? value)
      ((Compare ?loc ?left ?ops ?rights)
       ;; Compare(expr left, cmpop* ops, expr* comparators)
       (if (pair? (cdr ops))
	   (error "Compare" "Not implemented" ops)
	   (new-PycBinary loc
              (compare-operator (car ops))
	      (sexp left #f scope conf)
	      (sexp (car rights) #f scope conf)
	      type: 'bool)))
      ((Call ?loc ?fun ?args ?keywords)
       ;; Call(expr func, expr* args, keyword* keywords)
       (new-PycCall loc
	  (sexp fun #f scope conf)
	  (map (lambda (a) (sexp a #f scope conf)) args)
	  keywords: (map (lambda (k) (sexp k #f scope conf)) keywords)))
      ((Attribute ?loc ?value ?attr ?ctx)
       ;; Attribute(expr value, identifier attr, expr_context ctx)
       (new-PycAccess loc (sexp value #f scope conf) (symbol->string attr)))
      ((Subscript ?loc ?value ?slc ?ctx)
       (subscript loc value slc scope conf))
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
      (else
       (error "sexp" "Not implemented" exp))))

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

(define (compile-handler handler scope conf)
   (match-case handler
      ((ExceptHandler ?loc ?type ?name ?body)
       (let ((expr (if type
		       (sexp type #f scope conf)
		       (new-PycUninit loc))))
	  (if name
	      (let ((body (new-PycBlock loc
			     (list (new-PycVar loc name 'block
				      (new-PycPragma loc '%exn)))
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
   (let loop ((body body))
      (if (null? (cdr body))
	  (list (sexp (car body) tail scope conf))
	  (cons (sexp (car body) #f scope conf) (loop (cdr body))))))

(define (import-prefix name)
   (let* ((s (symbol->string name))
	  (i (string-index s #\.)))
      (if i
	  (string->symbol (substring s 0 i))
	  name)))

(define (compile-import loc alias scope conf)
   (match-case alias
      ((?name #f)
       (new-PycAssig loc (new-PycRefUnresolved loc (import-prefix name))
	  (new-PycImport loc (symbol->string name))))
      ((?name ?sym)
       (new-PycAssig loc (new-PycRefUnresolved loc sym)
	  (new-PycImport loc (symbol->string name))))
      (else
       (error "import" "Unsupported form" alias))))

(define (compile-import-from loc module aliases scope conf)

   (define (name-depth name)
      (let ((s (symbol->string name)))
	 (let loop ((i 0)
		    (c 1))
	    (let ((ni (string-index s #\. i)))
	       (cond
		  ((not ni) c)
		  ((= ni (- (string-length s) 1)) c)
		  (else (loop (+ ni 1) (+ c 1))))))))
      
   (let ((base (string-append (symbol->string module) ".")))
      (new-PycBlock loc
	 (list (new-PycVar loc '%mod 'block
		  (new-PycImport loc (symbol->string module))))
	 (new-PycSeq loc
	    (map (lambda (alias)
		    (match-case alias
		       ((?name #f)
			(new-PycAssig loc
			   (new-PycRefUnresolved loc (import-prefix name))
			   (new-PycImport loc
			      (string-append base (symbol->string name))
			      depth: (name-depth module))))
		       ((?name ?sym)
			(new-PycAssig loc (new-PycRefUnresolved loc sym)
			   (new-PycImport loc
			      (string-append base (symbol->string name))
			      depth: (name-depth module))))
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
      ((Div)      (if (eq? node 'BinOp) 'div      'idiv))
      ((BitAnd)   (if (eq? node 'BinOp) 'and      'iand))
      ((BitOr)    (if (eq? node 'BinOp) 'or       'ior))
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
      (else
       (error "unary-operator" "Illegal operator" op))))

(define (compare-operator op)
  (case op
    ((Lt)    'lt)
    ((Le)    'le)
    ((Gt)    'gt)
    ((Ge)    'ge)
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
