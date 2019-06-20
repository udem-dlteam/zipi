(define (py-sexp exp conf)
   (sexp exp #t 'global conf))

;; The Python syntax parsed by this function is defined at the url:
;;    https://docs.python.org/3.8/library/ast.html
(define (sexp exp tail scope conf)

   (match-case (car exp)
      ;; language detection
      ((Expr ?loc (Str ?loc ?lang))
       (when (and (pair? exp) (string? (car exp)))
	  (let ((p (memq language: conf)))
	     (if (pair? p)
		 (set-car! (cdr p) lang)
		 (set-cdr! (last-pair conf) (list language: lang)))))))

   (match-case exp
      
      ;; mod
      ((Module ?loc ?body . ?type_ignors)
       ;; Module(stmt* body, type_ignore *type_ignores)
       (new-PyModule loc "???" (compile* loc body #t 'global conf)))
      
      ;; stmt
      ((FunctionDef ?loc ?id ?args ?body ?decorator_list ?returns . ?type_comment)
       ;; FunctionDef(identifier name, arguments args,
       ;;             stmt* body, expr* decorator_list, expr? returns,
       ;;             string? type_comment)
       (new-PyDeclInit loc id scope
	  (new-PyFun loc
	     (map (lambda (a)
		     (new-PyDecl loc (car a) 'local))
		(car args))
	     (compile-stmt* loc body #t 'local conf))))
      ((ClassDef ?loc ?id ?bases ?keywords ?body ?decorator_list)
       ;; ClassDef(identifier name,
       ;;       expr* bases,
       ;;       keyword* keywords,
       ;;       stmt* body,
       ;;       expr* decorator_list)
       (tprint "TODO"))
      
      ((Return ?loc ?expr)
       ;; Return(expr? value)
       (new-PyReturn loc (sexp expr #f scope conf) tail))
      ((Delete ?loc ?targets)
       ;; Delete(expr* targets)
       (if (null? (cdr targets))
	   (new-PyDelete loc (sexp (car targets) #f scope conf))
	   (new-PySeq loc
	      (map (lambda (t)
		      (new-PyDelete loc (sexp t #f scope conf)))
		 targets))))
      ((Assign ?loc ?targets ?value . ?type_comment)
       ;; Assign(expr* targets, expr value, string? type_comment)
       (if (null? (cdr targets))
	   (new-PyAssig loc
	      (sexp (car targets) #f scope conf)
	      (sexp value #f scope conf))
	   (let* ((id (gensym 'tmp))
		  (var (new-PyVar loc id 'block (sexp value #f scope conf))))
	      (let loop ((targets targets)
			 (assigs '()))
		 (if (null? targets)
		     (new-PyBlock loc (list var)
			(new-PySeq loc assigs))
		     (let ((ref (sexp (car targets) #f scope conf)))
			(loop (cdr targets)
			   (cons (new-PyAssig loc ref
				    (new-PyRefUnresolved (PyNode-loc ref) id))
			      assigs))))))))
      ((For ?loc ?target ?iter ?body ?orelse . ?type_comment)
      ;; For(expr target, expr iter, stmt* body, stmt* orelse, string? type_comment)
       (new-PyFor loc
	  (compile-stmt* loc body #f scope conf)
	  (compile-stmt* loc orelse #f scope conf)
	  (sexp target #f scope conf)
	  (sexp iter #f scope conf)))
      ((While ?loc ?test ?body ?orelse)
       ;; While(expr test, stmt* body, stmt* orelse)
       (new-PyWhile loc
	  (compile-stmt* loc body #f scope conf)
	  (compile-stmt* loc orelse tail scope conf)
	  (sexp test #f scope conf)))
       
      ((If ?loc ?test ?body ?otherwise)
       ;; If(expr test, stmt* body, stmt* orelse)
       (new-PyIf loc (sexp test #f scope conf)
	  (compile-stmt* loc body tail scope conf)
	  (compile-stmt* loc otherwise tail scope conf)))

      ((Raise ?loc ?exc ?cause)
       ;; Raise(expr? exc, expr? cause)
       (new-PyRaise loc
	  (if exc (sexp exc #f scope conf) (new-PyUninit loc))
 	  (if cause (sexp cause #f scope conf) (new-PyUninit loc))))
      ((Try ?loc ?body ?handlers ?orelse ?finally)
       ;; Try(stmt* body, excepthandler* handlers, stmt* orelse, stmt* finalbody)
       (new-PyTry loc (compile-stmt* loc body #f scope conf)
	  (map (lambda (h) (compile-handler h scope conf)) handlers)
	  (compile-stmt* loc orelse #f scope conf)
	  (compile-stmt* loc finally #f scope conf)))

      ((Import ?loc ?aliases)
       ;; Import(alias* names)
       (match-case (car aliases)
	  ((builtins #f)
	   (new-PyAssig loc (new-PyRefUnresolved loc 'builtins)
	      (new-PyPragma loc '(py-builtins))))
	  (else
	   (error "Import" "Unsupported form" exp))))
      
      ((Expr ?loc ?value)
       ;; Expr(expr value)
       (new-PyStmtExpr loc
	  (sexp value tail scope conf)))

      ((Pass ?loc)
       ;; Pass
       (new-PyPass loc))
      ((Break ?loc)
       ;; Continue
       (new-PyBreak loc))
      ((Continue ?loc)
       ;; Continue
       (new-PyContinue loc))

      ;; expr
      ((Num ?loc ?val)
       (new-PyNumber loc (string->number val)))
      ((Str ?loc ?val)
       (new-PyString loc val))
      ((Constant ?loc ?val ?string)
       ;; Constant(constant value, string? kind) [3.8]
       (if string
	   (new-PyString loc val)
	   (new-PyNumber loc (string->number val))))
      ((BinOp ?loc ?left ?op ?right)
       ;; BinOp(expr left, operator op, expr right)
       (new-PyBinary loc 
	  (case op
	     ((Add) '+)
	     ((Sub) '-)
	     ((Div) '/)
	     ((Mul) '*)
	     (else "BinOp" "Illegal operator" op))
	  (sexp left #f scope conf)
	  (sexp right #f scope conf)
	  type: (op-type op)))
      ((UnaryOp ?loc ?op ?expr)
       (new-PyUnary loc op (sexp expr #f scope conf)))
      ((Yield ?loc ?value)
       (new-PyYield loc (sexp value tail scope conf)))
      ;; Yield(expr? value)
      ((Compare ?loc ?left ?ops ?rights)
       ;; Compare(expr left, cmpop* ops, expr* comparators)
       (if (pair? (cdr ops))
	   (error "Compare" "Not implemented" ops)
	   (make-PyBinary loc #f 'bool
	      (case (car ops)
		 ((< <= > >=) (car ops))
		 ((Lt) '<)
		 ((Le) '<=)
		 ((Gt) '>)
		 ((Ge) '>=)
		 ((Eq) 'is?)
		 ((NotEq) '!=)
		 (else (error "Compare" "Illegal operator" (car ops))))
	      (sexp left #f scope conf)
	      (sexp (car rights) #f scope conf))))
      ((Call ?loc ?fun ?args ?keywords)
       ;; Call(expr func, expr* args, keyword* keywords)
       (new-PyCall loc
	  (sexp fun #f scope conf)
	  (map (lambda (a) (sexp a #f scope conf)) args)
	  (map (lambda (k) (sexp k #f scope conf)) keywords)))
      ((Attribute ?loc ?value ?attr ?ctx)
       ;; Attribute(expr value, identifier attr, expr_context ctx)
       (new-PyAccess loc (sexp value #f scope conf) (symbol->string attr)))
      ((Name ?loc ?id ?ctx)
       ;; Name(identifier id, expr_context ctx)
       (case ctx
	  ((Load) (new-PyRefUnresolved loc id))
	  ((Store) (new-PyRefUnresolved loc id))
	  ((Delete) (new-PyRefUnresolved loc id))
	  (else (error "ctx" "Not implemented" ctx))))
      (else
       (error "sexp" "Not implemented" exp))))

(define (compile-handler handler scope conf)
   (match-case handler
      ((ExceptHandler ?loc ?type ?name ?body)
       (let ((expr (if type
		       (sexp type #f scope conf)
		       (new-PyUninit loc))))
	  (if name
	      (let ((body (new-PyBlock loc
			     (list (new-PyVar loc name 'block
				      (new-PyPragma loc '%exn)))
			     (compile-stmt* loc body #f scope conf))))
		 (new-PyHandler loc expr body))
	      (new-PyHandler loc expr (compile-stmt* loc body #f scope conf)))))
      (else
       (error "sexp" "Wrong handler" handler))))
       
(define (compile-stmt* loc body tail scope conf)
   (if (null? body)
       (new-PyPass loc)
       (new-PySeq loc
	  (let loop ((body body))
	     (if (null? (cdr body))
		 (list (sexp (car body) tail scope conf))
		 (cons (sexp (car body) #f scope conf) (loop (cdr body))))))))

(define (compile* loc body tail scope conf)
   (let loop ((body body))
      (if (null? (cdr body))
	  (list (sexp (car body) tail scope conf))
	  (cons (sexp (car body) #f scope conf) (loop (cdr body))))))

(define (op-type op)
   (if (memq op '(< <= > >= ==))
       'bool
       'unknown))
