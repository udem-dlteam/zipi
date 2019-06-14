(define-macro (all-bytecodes)
   (let ((l '(MOD
	      NOP SEQ BLOCK
	      PRAGMA UNINIT NUM STR
	      VAR0 VAR1 VAR2 VAR3 VAR4 VAR5
	      REF0 REF1 REF2 REF3 REF4 REF5
	      SET0 SET1 SET2 SET3 SET4 SET5
	      GGET GPUT GET PUT
	      LAM0 LAM1 LAM2 LAM3 LAM4
	      RLAM0 RLAM1 RLAM2 RLAM3 RLAM4
	      TAIL RET
	      CALL0 CALL1 CALL2 CALL3 CALL4
	      + -
	      TEST
	      <)))
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
       (error "bytecode" "wrong bytecode (integer expected)" code)
       (apply vector code args)))

(define (bytecode-ref bcode n)
   (vector-ref bcode n))

(define (bytecode-name bcode)
   (car (list-ref (all-bytecodes) (bytecode-ref bcode 0))))

(define (no-return . l)
   (error "return" "Illegal return" #f))

(define uninit
   (let ((hclass (make-HClass '#() '())))
      (make-PyObject hclass '#())))

(define locals
   (py-procedure->function
      (lambda (bcode env global return)
	 (let ((frame (meaning (bytecode-ref bcode 2) env global return))
	       (names (meaning (bytecode-ref bcode 3) env global return)))
	    (or (cell-ref frame)
		(let ((hclass (make-HClass (list->vector names) '()))
		      (vals (map (lambda (name) #f)
			       names)))
		   (cell-set! frame (make-PyObject hclass (list->vector vals)))
		   frame))))))

(define (py-beval ast conf)
   (let* ((hclass0 (make-HClass '#(print locals) '()))
	  (hclass1 (make-HClass '#(__builtins__) '()))
	  (__builtins__ (make-PyObject hclass0 '#(- -)))
	  (global (make-PyObject hclass1 (vector __builtins__))))
      (PyObject-elements-set! __builtins__ 0 (py-procedure->function print))
      (PyObject-elements-set! __builtins__ 1 locals)
      (meaning (compile ast '()) '() global no-return)))

(define (compile* nodes env)
   (map (lambda (n) (compile n env)) nodes))

(define (compile+ vals decls env)
   (let loop ((vals vals)
	      (decls decls)
	      (env env)
	      (acc '()))
      (if (null? vals)
	  acc
	  (loop (cdr vals) (cdr decls) (cons (car decls) env)
	     (cons (compile (car vals) env) acc)))))

(define-walk-method (compile this::PyNode env)
   (error "compile" "Not implemented" (typeof this)))

(define-walk-method (compile this::PyModule env)
   (bytecode (code 'MOD)
      (bytecode (code 'SEQ)
	 (compile* (PyModule-stmts this) (PyModule-globals this)))))

(define-walk-method (compile this::PySeq env)
   (bytecode (code 'SEQ)
      (compile* (PySeq-nodes this) env)))

(define-walk-method (compile this::PyBlock env)
   (bytecode (code 'BLOCK)
      (compile+ (PyBlock-vals this) (PyBlock-decls this) env)
      (compile (PyBlock-body this) (append (PyBlock-decls this) env))))

(define-walk-method (compile this::PyReturn env)
   (bytecode (code (if (PyReturn-tail this) 'TAIL 'RET))
      (compile (PyReturn-val this) env)))

(define-walk-method (compile this::PyIf env)
   (bytecode (code 'TEST)
      (compile (PyIf-test this) env)
      (compile (PyIf-then this) env)
      (compile (PyIf-else this) env)))

(define-walk-method (compile this::PyDeclInit env)
   (if (eq? (PyDeclInit-scope this) 'local)
       (bytecode (code 'SET0)
	  (compile (PyDeclInit-val this) env))
       (bytecode (code 'GPUT)
	  (PyDeclInit-id this)
	  (compile (PyDeclInit-val this) env)
	  (make-PCache #f -1))))

(define-walk-method (compile this::PyAssig env)

   (define (compile-assig-ref this)
      (let* ((ref (PyAssig-lhs this))
	     (decl (PyRef-decl ref))
	     (val (compile (PyAssig-rhs this) env)))
	 (case (PyDecl-scope decl)
	    ((global)
	     (bytecode (code 'GPUT) (PyDecl-id decl) val (make-PCache #f -1)))
	    (else
	     (bytecode (code 'SET0 (min (lookup decl env) 4)) val)))))
      
   (cond
      ((PyRef? (PyAssig-lhs this))
       (compile-assig-ref this))
      (else
       (error "compile-assig" "Not implemented" (py->list this)))))

(define-walk-method (compile this::PyPragma env)
   (bytecode (code 'PRAGMA) (PyPragma-expr this)))

(define-walk-method (compile this::PyUninit env)
   (bytecode (code 'UNINIT)))

(define-walk-method (compile this::PyNumber env)
   (bytecode (code 'NUM) (PyNumber-val this)))

(define-walk-method (compile this::PyBinary env)
   (bytecode (code (PyBinary-op this))
      (compile (PyBinary-lhs this) env)
      (compile (PyBinary-rhs this) env)))

(define-walk-method (compile this::PyFun env)
   (let* ((args (PyFun-args this))
	  (body (compile (PyFun-body this) (append args env)))
	  (needret (PyFun-need-return this)))
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
	  (error "compile-lambda" "Not implemented" (py->list args))))))

(define-walk-method (compile this::PyCall env)
   (cond
      ((null? (PyCall-args this))
       (bytecode (code 'CALL0) (compile (PyCall-fun this) env)
	  (bytecode (code 'VAR0 (min (lookup-by-id '%frame env))))
	  (bytecode (code 'VAR0 (min (lookup-by-id '%names env))))))
      ((<= (length (PyCall-args this)) 4)
       (apply bytecode (code 'CALL0 (length (PyCall-args this)))
	  (compile (PyCall-fun this) env)
	  (compile* (PyCall-args this) env)))
      (else
       (error "call" "Not implemented" (length (PyCall-args this))))))
   
(define-walk-method (compile this::PyRef env)
   (let ((decl (PyRef-decl this)))
      (case (PyDecl-scope decl)
	 ((global)
	  (bytecode (code 'GGET) (PyDecl-id decl) (make-PCache #f -1)))
	 ((block)
	  (bytecode (code 'VAR0 (min (lookup decl env) 4))))
	 (else
	  (bytecode (code 'REF0 (min (lookup decl env) 4)))))))
	  
(define-walk-method (compile this::PyRefUnresolved env)
   (bytecode (code 'GGET) (PyRefUnresolved-id this) (make-PCache #f -1)))

(define (lookup decl env)
   (let loop ((i 0)
	      (env env))
      (cond
	 ((null? env) #f)
	 ((eq? (car env) decl) i)
	 (else (loop (+ i 1) (cdr env))))))
	  
(define (lookup-by-id id env)
   (let loop ((i 0)
	      (env env))
      (cond
	 ((null? env) #f)
	 ((eq? (PyDecl-id (car env)) id) i)
	 (else (loop (+ i 1) (cdr env))))))
	  
(define (meaning bcode env global return)
   (bytecode-case bcode
      ;; literals
      ((NUM)
       (bytecode-ref bcode 1))
      ((UNINIT)
       uninit)
      ((PRAGMA)
       (eval (bytecode-ref bcode 1)))
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
      ((BLOCK)
       (let loop ((vals (bytecode-ref bcode 1))
		  (env env))
	  (if (null? vals)
	      (meaning (bytecode-ref bcode 2) env global return)
	      (loop (cdr vals)
		 (cons (meaning (car vals) env global return) env)))))
      ;; possibly unitialized or deleted variables
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
      ;; variables
      ((VAR0)
       (car env))
      ((VAR1)
       (cadr env))
      ((VAR2)
       (caddr env))
      ((VAR3)
       (cadddr env))
      ((VAR4)
       (list-ref env (bytecode-ref bcode 2)))
      ;; set
      ((SET0)
       (set-car! env
	  (meaning (bytecode-ref bcode 1) env global return)))
      ((SET1)
       (set-car! (cdr env)
	  (meaning (bytecode-ref bcode 1) env global return)))
      ((SET2)
       (set-car! (cddr env)
	  (meaning (bytecode-ref bcode 1) env global return)))
      ((SET3)
       (set-car! (cdddr env)
	  (meaning (bytecode-ref bcode 1) env global return)))
      ((SET4)
       (set-car! (cddddr env)
	  (meaning (bytecode-ref bcode 1) env global return)))
      
      ;; properties
      ((GGET)
       (let ((cache (bytecode-ref bcode 2)))
	  (if (eq? (PyObject-hclass global) (PCache-hclass cache))
	      (PyObject-elements-ref global (PCache-index cache))
	      (gget global bcode))))
      ((GPUT)
       (let ((cache (bytecode-ref bcode 3))
	     (val (meaning (bytecode-ref bcode 2) env global return)))
	  (if (eq? (PyObject-hclass global) (PCache-hclass cache))
	      (PyObject-elements-set! global (PCache-index cache) val)
	      (gput global bcode val))))
      
      ;; lambda
      ((LAM0)
       (make-PyFunction (PyFunction-default-hclass) '#()
	  (lambda ()
	     (bind-exit (return)
		(meaning (bytecode-ref bcode 1) env global return)))))
      ((LAM1)
       (make-PyFunction (PyFunction-default-hclass) '#()
	  (lambda (x)
	     (meaning (bytecode-ref bcode 1) (cons x env) global return))))
      ((LAM2)
       (make-PyFunction (PyFunction-default-hclass) '#()
	  (lambda (x y)
	     (meaning (bytecode-ref bcode 1) (cons* x y env) global return))))
      ((LAM3)
       (make-PyFunction (PyFunction-default-hclass) '#()
	  (lambda (x y z)
	     (meaning (bytecode-ref bcode 1) (cons* x y z env) global return))))
      ((LAM4)
       (make-PyFunction (PyFunction-default-hclass) '#()
	  (lambda (x y z t)
	     (meaning (bytecode-ref bcode 1) (cons* x y z t env) global return))))
      ((RLAM0)
       (make-PyFunction (PyFunction-default-hclass) '#()
	  (lambda ()
	     (bind-exit (return)
		(meaning (bytecode-ref bcode 1) env global return)))))
      ((RLAM1)
       (make-PyFunction (PyFunction-default-hclass) '#()
	  (lambda (x)
	     (bind-exit (return)
		(meaning (bytecode-ref bcode 1) (cons x env) global return)))))
      ((RLAM2)
       (make-PyFunction (PyFunction-default-hclass) '#()
	  (lambda (x y)
	     (bind-exit (return)
		(meaning (bytecode-ref bcode 1) (cons* x y env) global return)))))
      ((RLAM3)
       (make-PyFunction (PyFunction-default-hclass) '#()
	  (lambda (x y z)
	     (bind-exit (return)
		(meaning (bytecode-ref bcode 1) (cons* x y z env) global return)))))
      ((RLAM4)
       (make-PyFunction (PyFunction-default-hclass) '#()
	  (lambda (x y z t)
	     (bind-exit (return)
		(meaning (bytecode-ref bcode 1) (cons* x y z t env) global return)))))
      ;; tail return
      ((TAIL)
       (meaning (bytecode-ref bcode 1) env global return))
      ;; return
      ((RET)
       (return (meaning (bytecode-ref bcode 1) env global return)))
      ;; app
      ((CALL0)
       (let ((proc (meaning (bytecode-ref bcode 1) env global return)))
	  (if (eq? proc locals)
	      ((PyFunction-procedure locals) bcode env global return)
	      (PyFunction-call0 proc))))
      ((CALL1)
       (PyFunction-call1 (meaning (bytecode-ref bcode 1) env global return)
	  (meaning (bytecode-ref bcode 2) env global return)))
      ((CALL2)
       (PyFunction-call2 (meaning (bytecode-ref bcode 1) env global return)
	  (meaning (bytecode-ref bcode 2) env global return)
	  (meaning (bytecode-ref bcode 3) env global return)))
      ((CALL3)
       (PyFunction-call3 (meaning (bytecode-ref bcode 1) env global return)
	  (meaning (bytecode-ref bcode 2) env global return)
	  (meaning (bytecode-ref bcode 3) env global return)
	  (meaning (bytecode-ref bcode 4) env global return)))
      ((CALL4)
       (PyFunction-call4 (meaning (bytecode-ref bcode 1) env global return)
	  (meaning (bytecode-ref bcode 2) env global return)
	  (meaning (bytecode-ref bcode 3) env global return)
	  (meaning (bytecode-ref bcode 4) env global return)
	  (meaning (bytecode-ref bcode 5) env global return)))
      
      ;; binop
      ((+)
       (+ (meaning (bytecode-ref bcode 1) env global return)
	  (meaning (bytecode-ref bcode 2) env global return)))
      ((-)
       (- (meaning (bytecode-ref bcode 1) env global return)
	  (meaning (bytecode-ref bcode 2) env global return)))
      
      ;; test
      ((TEST)
       (if (meaning (bytecode-ref bcode 1) env global return)
	   (meaning (bytecode-ref bcode 2) env global return)
	   (meaning (bytecode-ref bcode 3) env global return)))
      
      ;; compare
      ((<)
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
	  (index (PyObject-find-prop obj name)))
      (cond
	 ((>= index 0)
	  (PCache-set! cache (PyObject-hclass obj) index)
	  (PyObject-elements-ref obj index))
	 (else
	  (let* ((__builtins__ (PyObject-elements-ref obj 0))
		 (idxb (PyObject-find-prop __builtins__ name)))
	     (if (>=fx idxb 0)
		 (PyObject-elements-ref __builtins__ idxb)
		 (error "NameError" "global name is not defined" name)))))))

(define (gput obj bcode val)
   (let* ((name (bytecode-ref bcode 1))
	  (cache (bytecode-ref bcode 3))
	  (index (PyObject-find-prop obj name))
	  (hclass (PyObject-hclass obj)))
      (if (>= index 0)
	  (begin
	     (PCache-set! cache hclass index)
	     (PyObject-elements-set! obj index val))
	  (let* ((nhclass (HClass-next hclass name '+))
		 (index (HClass-last-index nhclass)))
	     (PyObject-hclass-set! obj nhclass)
	     (PCache-set! cache nhclass index)
	     (PyObject-elements-set! obj index val)))))

