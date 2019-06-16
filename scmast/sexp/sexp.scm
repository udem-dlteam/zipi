(##import ast)

(define (py-sexp exp conf)
   (compile3 exp #t 'global conf))

(define (compile3 exp tail scope conf)
   (match-case exp
      
      ;; mod
      ((Module ?loc ?body . ?type_ignors)
       ;; Module(stmt* body, type_ignore *type_ignores)
       (make-PyModule loc 1 "???" (compile-stmt* body #t 'global conf) '()))
      
      ;; stmt
      ((FunctionDef ?loc ?name ?args ?body ?decorator_list ?returns . ?type_comment)
       ;; FunctionDef(identifier name, arguments args,
       ;;             stmt* body, expr* decorator_list, expr? returns,
       ;;             string? type_comment)
       (make-PyDeclInit loc name scope
	  (make-PyFun loc
	     (map (lambda (a) (make-PyDecl loc (car a) 'local)) (car args))
	     '()
	     (make-PySeq loc (compile-stmt* body #t 'local conf))
	     #t #t)))
      ((Return ?loc ?expr)
       ;; Return(expr? value)
       (make-PyReturn loc (compile3 expr #f scope conf) tail))
      ((Delete ?loc ?targets)
       ;; Delete(expr* targets)
       (make-PyDelete loc (map (lambda (t) (compile3 t #f scope conf)) targets)))
      ((Assign ?loc ?targets ?value . ?type_comment)
       ;; Assign(expr* targets, expr value, string? type_comment)
       (if (null? (cdr targets))
	   (make-PyAssig loc (compile3 (car targets) #f scope conf)
	      (compile3 value #f scope conf))
	   (let* ((id (gensym 'tmp))
		  (var (make-PyVar loc id 'block))
		  (val (compile3 value #f scope conf)))
	      (let loop ((targets targets)
			 (assigs '()))
		 (if (null? targets)
		     (make-PyBlock loc (list var) (list val)
			(make-PySeq loc assigs))
		     (let ((ref (compile3 (car targets) #f scope conf)))
			(loop (cdr targets)
			   (cons (make-PyAssig loc ref
				    (make-PyRefUnresolved (PyNode-loc ref) id))
			      assigs))))))))
      ((If ?loc ?test ?body ?otherwise)
       ;; If(expr test, stmt* body, stmt* orelse)
       (make-PyIf loc (compile3 test #f scope conf)
	  (make-PySeq loc (compile-stmt* body tail scope conf))
	  (make-PySeq loc (compile-stmt* otherwise tail scope conf))))
      
      ((Expr ?loc ?value)
       ;; Expr(expr value)
       (compile3 value tail scope conf))
      
      ;; expr
      ((Num ?loc ?val)
       (make-PyNumber loc (string->number val)))
      ((Constant ?loc ?val ?string)
       ;; Constant(constant value, string? kind) [3.8]
       (if string
	   (make-PyString loc val)
	   (make-PyNumber loc (string->number val))))
      ((BinOp ?loc ?left ?op ?right)
       ;; BinOp(expr left, operator op, expr right)
       (make-PyBinary loc 'any
	  (case op
	     ((Add) '+)
	     ((Sub) '-)
	     (else "BinOp" "Illegal operator" op))
	  (compile3 left #f scope conf)
	  (compile3 right #f scope conf)))
      ((Compare ?loc ?left ?ops ?rights)
       ;; Compare(expr left, cmpop* ops, expr* comparators)
       (if (pair? (cdr ops))
	   (error "Compare" "Not implemented" ops)
	   (make-PyBinary loc 'bool
	      (case (car ops)
		 ((< <= > >=) (car ops))
		 ((Lt) '<)
		 ((Le) '<=)
		 ((Gt) '>)
		 ((Ge) '>=)
		 (else (error "Compare" "Illegal operator" (car ops))))
	      (compile3 left #f scope conf)
	      (compile3 (car rights) #f scope conf))))
      ((Call ?loc ?fun ?args ?keywords)
       ;; Call(expr func, expr* args, keyword* keywords)
       (make-PyCall loc
	  (compile3 fun #f scope conf)
	  (map (lambda (a) (compile3 a #f scope conf)) args)
	  (map (lambda (k) (compile3 k #f scope conf)) keywords)))
      ((Name ?loc ?id ?ctx)
       ;; Name(identifier id, expr_context ctx)
       (case ctx
	  ((Load) (make-PyRefUnresolved loc id))
	  ((Store) (make-PyRefUnresolved loc id))
	  ((Delete) (make-PyRefUnresolved loc id))
	  (else (error "ctx" "Not implemented" ctx))))
      (else
       (error "compile3" "Not implemented" exp))))
      
(define (compile-stmt* body tail scope conf)
   (let loop ((body body))
      (if (null? (cdr body))
	  (list (compile3 (car body) tail scope conf))
	  (cons (compile3 (car body) #f scope conf) (loop (cdr body))))))
