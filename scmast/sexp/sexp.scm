(define (py-sexp exp conf)
   (sexp exp #t 'global conf))

(define (sexp exp tail scope conf)
   (match-case exp
      
      ;; mod
      ((Module ?loc ?body . ?type_ignors)
       ;; Module(stmt* body, type_ignore *type_ignores)
       (new-PyModule loc "???" (compile-stmt* body #t 'global conf)))
      
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
	     (new-PySeq loc (compile-stmt* body #t 'local conf)))))
      ((Return ?loc ?expr)
       ;; Return(expr? value)
       (new-PyReturn loc (sexp expr #f scope conf) tail))
      ((Delete ?loc ?targets)
       ;; Delete(expr* targets)
       (new-PyDelete loc (map (lambda (t) (sexp t #f scope conf)) targets)))
      ((Assign ?loc ?targets ?value . ?type_comment)
       ;; Assign(expr* targets, expr value, string? type_comment)
       (if (null? (cdr targets))
	   (new-PyAssig loc
	      (sexp (car targets) #f scope conf)
	      (sexp value #f scope conf))
	   (let* ((id (gensym 'tmp))
		  (var (new-PyVar loc id 'block))
		  (val (sexp value #f scope conf)))
	      (let loop ((targets targets)
			 (assigs '()))
		 (if (null? targets)
		     (new-PyBlock loc (list var) (list val)
			(new-PySeq loc assigs))
		     (let ((ref (sexp (car targets) #f scope conf)))
			(loop (cdr targets)
			   (cons (new-PyAssig loc ref
				    (new-PyRefUnresolved (PyNode-loc ref) id))
			      assigs))))))))
      ((If ?loc ?test ?body ?otherwise)
       ;; If(expr test, stmt* body, stmt* orelse)
       (new-PyIf loc (sexp test #f scope conf)
	  (new-PySeq loc (compile-stmt* body tail scope conf))
	  (new-PySeq loc (compile-stmt* otherwise tail scope conf))))

      ((Expr ?loc ?value)
       ;; Expr(expr value)
       (sexp value tail scope conf))

      ;; expr
      ((Num ?loc ?val)
       (new-PyNumber loc (string->number val)))
      ((Constant ?loc ?val ?string)
       ;; Constant(constant value, string? kind) [3.8]
       (if string
	   (new-PyString loc val)
	   (new-PyNumber loc (string->number val))))
      ((BinOp ?loc ?left ?op ?right)
       ;; BinOp(expr left, operator op, expr right)
       (make-PyBinary loc #f 'any
	  (case op
	     ((Add) '+)
	     ((Sub) '-)
	     (else "BinOp" "Illegal operator" op))
	  (sexp left #f scope conf)
	  (sexp right #f scope conf)))
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
		 (else (error "Compare" "Illegal operator" (car ops))))
	      (sexp left #f scope conf)
	      (sexp (car rights) #f scope conf))))
      ((Call ?loc ?fun ?args ?keywords)
       ;; Call(expr func, expr* args, keyword* keywords)
       (new-PyCall loc
	  (sexp fun #f scope conf)
	  (map (lambda (a) (sexp a #f scope conf)) args)
	  (map (lambda (k) (sexp k #f scope conf)) keywords)))
      ((Name ?loc ?id ?ctx)
       ;; Name(identifier id, expr_context ctx)
       (case ctx
	  ((Load) (new-PyRefUnresolved loc id))
	  ((Store) (new-PyRefUnresolved loc id))
	  ((Delete) (new-PyRefUnresolved loc id))
	  (else (error "ctx" "Not implemented" ctx))))
      (else
       (error "sexp" "Not implemented" exp))))
      
(define (compile-stmt* body tail scope conf)
   (let loop ((body body))
      (if (null? (cdr body))
	  (list (sexp (car body) tail scope conf))
	  (cons (sexp (car body) #f scope conf) (loop (cdr body))))))
