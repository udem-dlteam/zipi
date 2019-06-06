(cond-expand
   (gambit
    (define-macro (match-case expr clauses)
       
       (define (ident sym)
	  (let* ((s (symbol->string sym))
		 (l (string-length s)))
	     (if (char=? (string-ref s (-fx l 2) #\?))
		 (string->symbol (substring s 0 (-fx l 1)))
		 sym)))
       
       (let ((e (gensym 'expr)))
	  `(let ((,e ,expr))
	      ,@(map (lambda (clause)
			(cond
			   ((not (pair? clause))
			    (error "match-case" "illegal clause" clause))
			   ((eq? (car clause) 'else)
			    clauses)
			   ((not (pair? (car clause)))
			    (error "match-case" "illegal clause" clause))
			   (else
			    `((,(caar clause))
			      (apply (lambda ,(map ident (car clause))
					,@(cdr clause))
				 ,e)))))))))))

(cond-expand
   (gambit
    (define-macro (bind-exit exit . body)
       `(call/cc (lambda ,exit ,@body)))))

(cond-expand
   (gambit
    (define (tprint . args)
       (for-each display args)
       (newline))))

(define-macro (all-bytecodes)
   (let ((l '(MOD
	      NOP SEQ
	      NUM STR
	      REG0 REG1 REG2 REG3 REG4 REG5
	      REF0 REF1 REF2 REF3 REF4 REF5
	      SET0 SET1 SET2 SET3 SET4 SET5
	      GGET GPUT GET PUT
	      LAM0 LAM1 LAM2 LAM3 LAM4
	      RLAM0 RLAM1 RLAM2 RLAM3 RLAM4
	      TAIL RET
	      CALL0 CALL1 CALL2 CALL3 CALL4
	      ADD SUB
	      TEST
	      LT)))
      `',(map (lambda (s n)
		 (cons s n))
	    l (iota (length l)))))

(define-macro (bytecode-case bcode . clauses)
   `(case (bytecode-ref bcode 0)
       ,@(map (lambda (clause)
		 (if (eq? (car clause) 'else)
		     clause
		     (let* ((code (caar clause))
			    (c (assq code (all-bytecodes))))
			(if (not c)
			    (error "bytecode-case" "illegal code" code)
			    `((,(cdr c)) ,@(cdr clause))))))
	  clauses)))

(define-macro (code id . offset)
   `(let ((c (assq ,id (all-bytecodes))))
       (if (not c)
	   (error "code" "illegal code" ,id)
	   (+ (cdr c) ,(if (pair? offset) (car offset) 0)))))

(define (bytecode code . args)
   (if (not (integer? code))
       (error "bytecode" "wrong bytecode" code)
       (apply vector code args)))

(define (bytecode-ref bcode n)
   (vector-ref bcode n))

(define (bytecode-name bcode)
   (car (list-ref (all-bytecodes) (bytecode-ref bcode 0))))

(define (no-return . l)
   (error "return" "Illegal return" #f))

(define uninit (cons 1 2))

(define (evalpy exp)
   (let* ((hclass0 (make-hclass '#(print)))
	  (global (make-pyobject hclass0)))
      (pyobject-elements-set! global 0 print)
      (meaning (compile exp '() #t (make-cell #f)) '() global no-return)))

(define (meaning bcode env global return)
   (bytecode-case bcode
      ;; literals
      ((NUM)
       (bytecode-ref bcode 1))
      ((STR)
       (bytecode-ref bcode 1))

      ;; misc
      ((NOP)
       #f)
      ((SEQ)
       (let loop ((l (bytecode-ref bcode 1)))
	  (if (null? (cdr l))
	      (meaning (car l) env global return)
	      (begin
		 (meaning (car l) env global return)
		 (loop (cdr l))))))
      ;; reg (non deleted variables)
      ((REG0)
       (car env))
      ((REG1)
       (cadr env))
      ((REG2)
       (caddr env))
      ((REG3)
       (cadddr env))
      ((REG4)
       (list-ref env (bytecode-ref bcode 2)))
      ;; possibly deleted variables
      ((REF0)
       (vref (car env) bcode))
      ((REF1)
       (vref (cadr env) bcode))
      ((REF2)
       (vref (caddr env) bcode))
      ((REF3)
       (vref (cadddr env) bcode))
      ((REF4)
       (vref (list-ref env (bytecode-ref bcode 2)) bcode))
      ;; set
      ((SET0)
       (vref (car env) bcode))
      ((SET1)
       (vref (cadr env) bcode))
      ((SET2)
       (vref (caddr env) bcode))
      ((SET3)
       (vref (cadddr env) bcode))
      ((SET4)
       (vref (list-ref env (bytecode-ref bcode 2)) bcode))

      ;; properties
      ((GGET)
       (let ((cache (bytecode-ref bcode 2)))
	  (if (eq? (pyobject-hclass global) (pcache-hclass cache))
	      (pyobject-elements-ref global (pcache-index cache))
	      (gget global bcode))))
      ((GPUT)
       (let ((cache (bytecode-ref bcode 3))
	     (val (meaning (bytecode-ref bcode 2) env global return)))
	  (if (eq? (pyobject-hclass global) (pcache-hclass cache))
	      (pyobject-elements-set! global (pcache-index cache) val)
	      (gput global bcode val))))

      ;; lambda
      ((LAM0)
       (lambda ()
	  (bind-exit (return)
	     (meaning (bytecode-ref bcode 1) env global return))))
      ((LAM1)
       (lambda (x)
	  (meaning (bytecode-ref bcode 1) (cons x env) global return)))
      ((LAM2)
       (lambda (x y)
	  (meaning (bytecode-ref bcode 1) (cons* x y env) global return)))
      ((LAM3)
       (lambda (x y z)
	  (meaning (bytecode-ref bcode 1) (cons* x y z env) global return)))
      ((LAM4)
       (lambda (x y z t)
	  (meaning (bytecode-ref bcode 1) (cons* x y z t env) global return)))
      ((RLAM0)
       (lambda ()
	  (bind-exit (return)
	     (meaning (bytecode-ref bcode 1) env global return))))
      ((RLAM1)
       (lambda (x)
	  (bind-exit (return)
	     (meaning (bytecode-ref bcode 1) (cons x env) global return))))
      ((RLAM2)
       (lambda (x y)
	  (bind-exit (return)
	     (meaning (bytecode-ref bcode 1) (cons* x y env) global return))))
      ((RLAM3)
       (lambda (x y z)
	  (bind-exit (return)
	     (meaning (bytecode-ref bcode 1) (cons* x y z env) global return))))
      ((RLAM4)
       (lambda (x y z t)
	  (bind-exit (return)
	     (meaning (bytecode-ref bcode 1) (cons* x y z t env) global return))))
      ;; tail return
      ((TAIL)
       (meaning (bytecode-ref bcode 1) env global return))
      ;; return
      ((RET)
       (return (meaning (bytecode-ref bcode 1) env global return)))
      ;; app
      ((CALL0)
       ((meaning (bytecode-ref bcode 1) env global return)))
      ((CALL1)
       ((meaning (bytecode-ref bcode 1) env global return)
	(meaning (bytecode-ref bcode 2) env global return)))
      ((CALL2)
       ((meaning (bytecode-ref bcode 1) env global return)
	(meaning (bytecode-ref bcode 2) env global return)
	(meaning (bytecode-ref bcode 3) env global return)))
      ((CALL3)
       ((meaning (bytecode-ref bcode 1) env global return)
	(meaning (bytecode-ref bcode 2) env global return)
	(meaning (bytecode-ref bcode 3) env global return)
	(meaning (bytecode-ref bcode 4) env global return)))
      ((CALL4)
       ((meaning (bytecode-ref bcode 1) env global return)
	(meaning (bytecode-ref bcode 2) env global return)
	(meaning (bytecode-ref bcode 3) env global return)
	(meaning (bytecode-ref bcode 4) env global return)
	(meaning (bytecode-ref bcode 5) env global return)))
      
      ;; binop
      ((ADD)
       (+ (meaning (bytecode-ref bcode 1) env global return)
	  (meaning (bytecode-ref bcode 2) env global return)))
      ((SUB)
       (- (meaning (bytecode-ref bcode 1) env global return)
	  (meaning (bytecode-ref bcode 2) env global return)))

      ;; test
      ((TEST)
       (if (meaning (bytecode-ref bcode 1) env global return)
	   (meaning (bytecode-ref bcode 2) env global return)
	   (meaning (bytecode-ref bcode 3) env global return)))
      
      ;; compare
      ((LT)
       (< (meaning (bytecode-ref bcode 1) env global return)
	  (meaning (bytecode-ref bcode 2) env global return)))

      ;; module
      ((MOD)
       (meaning (bytecode-ref bcode 1) env global return))
      (else
       (error "meaning" "Illegal byte code" bcode))))

(define (vref val bcode)
   (if (eq? val uninit)
       (error "UnboundLocalError"
	  "local variable reference before assignment"
	  (bytecode-ref bcode 2))
       val))

(define (gget obj bcode)
   (let* ((name (bytecode-ref bcode 1))
	  (cache (bytecode-ref bcode 2))
	  (index (pyobject-find-prop obj name)))
      (if (>= index 0)
	  (begin
	     (pcache-set! cache (pyobject-hclass obj) index)
	     (pyobject-elements-ref obj index))
	  (error "NameError" "global name is not defined" name))))

(define (gput obj bcode val)
   (let* ((name (bytecode-ref bcode 1))
	  (cache (bytecode-ref bcode 3))
	  (index (pyobject-find-prop obj name))
	  (hclass (pyobject-hclass obj)))
      (if (>= index 0)
	  (begin
	     (pcache-set! cache hclass index)
	     (pyobject-elements-set! obj index val))
	  (let* ((nhclass (hclass-next hclass name '+))
		 (index (hclass-last-index nhclass)))
	     (pyobject-hclass-set! obj nhclass)
	     (pcache-set! cache nhclass index)
	     (pyobject-elements-set! obj index val)))))

(define (compile exp env tail needret)
   (match-case exp
      
      ;; mod
      ((Module ?body . ?type_ignors)
       ;; Module(stmt* body, type_ignore *type_ignores)
       (bytecode (code 'MOD) (compile-stmt* body env #t needret)))

      ;; stmt
      ((Return ?expr)
       ;; Return(expr? value)
       (if tail
	   (bytecode (code 'TAIL) (compile expr env #f needret))
	   (begin
	      (set-car! needret #t)
	      (bytecode (code 'RET) (compile expr env #f needret)))))
      ((Delete ?targets)
       ;; Delete(expr* targets)
       (compile-expr* targets env tail needref))
      ((If ?test ?body ?otherwise)
       ;; If(expr test, stmt* body, stmt* orelse)
       (bytecode (code 'TEST) (compile test env #f needret)
	  (compile-stmt* body env tail needret)
	  (compile-stmt* otherwise env tail needret)))
      ((FunctionDef ?name ?args ?body ?decorator_list ?returns . ?type_comment)
       ;; FunctionDef(identifier name, arguments args,
       ;;             stmt* body, expr* decorator_list, expr? returns,
       ;;             string? type_comment)
       (let ((needret (make-cell #f)))
	  (compile-set name env
	     (compile-lambda (cell-ref needret) (car args)
		(compile-stmt* body
		   (check-delete body
		      (extend-env (map car (car args)) env))
		   #t needret)))))
      ((Expr ?value)
       ;; Expr(expr value)
       (compile value env tail needret))
      
      ;; expr
      ((Num ?val)
       (bytecode (code 'NUM) (string->number val)))
      ((Constant ?val ?string)
       ;; Constant(constant value, string? kind) [3.8]
       (if (string (bytecode (code 'STR) val))
	   (bytecode (code 'NUM) (string->number val))))
      ((BinOp ?left ?op ?right)
       ;; BinOp(expr left, operator op, expr right)
       (case op
	  ((Add)
	   (bytecode (code 'ADD)
	      (compile left env #f needret)
	      (compile right env #f needret)))
	  ((Sub)
	   (bytecode (code 'SUB)
	      (compile left env #f needret)
	      (compile right env #f needret)))
	  (else
	   (error "BinOp" "Not implemented" op))))

      ((Compare ?left ?ops ?rights)
       ;; Compare(expr left, cmpop* ops, expr* comparators)
       (let loop ((left (compile left env #f needret))
		  (ops ops)
		  (rights rights))
	  (if (null? (cdr ops))
	      (compile-compare (car ops) left
		 (compile (car rights) env #f needret))
	      (error "Compare" "Not implemented" ops))))
      
      ((Call ?fun ?args ?keywords)
       ;; Call(expr func, expr* args, keyword* keywords)
       (if (<= (length args) 4)
	   (apply bytecode (code 'CALL0 (length args))
	      (compile fun env #f needret)
	      (map (lambda (a) (compile a env #f needret)) args))
	   (error "call" "Not implemented" (length args))))
      ((Name ?id ?ctx)
       ;; Name(identifier id, expr_context ctx)
       (case ctx
	  ((Load) (compile-ref id env))
	  ((Delete) (compile-delete id env))
	  (else (error "ctx" "Not implemented" ctx))))
      (else
       (error "compile" "Not implemented" exp))))

(define (compile-stmt* exp env tail needret)
   (bytecode (code 'SEQ)
      (let loop ((exp exp))
	 (if (null? (cdr exp))
	     (list (compile (car exp) env tail needret))
	     (cons (compile (car exp) env #f needret) (loop (cdr exp)))))))

(define (compile-expr* exp env tail needret)
   (bytecode (code 'SEQ)
      (let loop ((exp exp))
	 (if (null? (cdr exp))
	     (list (compile (car exp) env tail needret))
	     (cons (compile (car exp) env #f needret) (loop (cdr exp)))))))

(define (compile-ref id env)
   (let loop ((env env)
	      (offset 0))
      (cond
	 ((null? env) (bytecode (code 'GGET) id (make-pcache)))
	 ((not (eq? (caar env) id)) (loop (cdr env) (+ offset 1)))
	 ((<= offset 3) (bytecode (code (if (cdar env) 'REG0 'REF0) offset) id))
	 (else (bytecode (code (if (cdar env) 'REG4 'REF4)) id offset)))))

(define (compile-set id env val)
   (let loop ((env env)
	      (offset 0))
      (cond
	 ((null? env) (bytecode (code 'GPUT) id val (make-pcache)))
	 ((not (eq? (car env) id)) (loop (cdr env) (+ offset 1)))
	 ((<= offset 3) (bytecode (code 'SET0 offset) id) val)
	 (else (bytecode (code 'SET4) id offset val)))))

(define (extend-env args env)
   (append (map (lambda (a) (cons args #t)) env)))

(define (compile-lambda needret args body)
   (cond
      ((null? args)
       (bytecode (code (if needret 'RLAM0 'LAM0)) body))
      ((null? (cdr args))
       (bytecode (code (if needret 'RLAM1 'LAM1)) body))
      ((null? (cddr args))
       (bytecode (code (if needret 'RLAM2 'LAM2)) body))
      ((null? (cdddr args))
       (bytecode (code (if needret 'RLAM3 'LAM3)) body))
      ((null? (cddddr args))
       (bytecode (code (if needret 'RLAM4 'LAM4)) body))
      (else
       (error "compile-lambda" "Not implement" (length args)))))

(define (compile-compare op left right)
   (case op
      ((Lt) (bytecode (code 'LT) left right))
      (else (tprint "compile compare: not implemented"))))
