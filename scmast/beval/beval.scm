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

(define uninit (cons 1 2))

(define (py-beval ast conf)
   (let* ((hclass0 (make-HClass '#(print) '()))
	  (global (make-PyObject hclass0 '#())))
      (PyObject-elements-set! global 0 (py-procedure->function print))
      (meaning (compile ast) '() global no-return)))

(define-walk-method (compile this::PyNode)
   (error "compile" "Not implemented" (typeof this)))

(define-walk-method (compile this::PyModule)
   (bytecode (code 'MOD)
      (bytecode (code 'SEQ)
	 (map compile (PyModule-stmts this)))))

(define-walk-method (compile this::PySeq)
   (bytecode (code 'SEQ)
      (map compile (PySeq-nodes this))))

(define-walk-method (compile this::PyReturn)
   (bytecode (code (if (PyReturn-tail this) 'TAIL 'RET))
      (compile (PyReturn-val this))))

(define-walk-method (compile this::PyIf)
   (bytecode (code 'TEST)
      (compile (PyIf-test this))
      (compile (PyIf-then this))
      (compile (PyIf-else this))))

(define-walk-method (compile this::PyDeclInit)
   (if (eq? (PyDeclInit-scope this) 'local)
       (bytecode (code 'SET0)
	  (compile (PyDeclInit-val this)))
       (bytecode (code 'GPUT)
	  (PyDeclInit-id this)
	  (compile (PyDeclInit-val this))
	  (make-PCache #f -1))))

(define-walk-method (compile this::PyAssig)
   (tprint "TODO"))

(define-walk-method (compile this::PyNumber)
   (bytecode (code 'NUM) (PyNumber-val this)))

(define-walk-method (compile this::PyBinary)
   (bytecode (code (PyBinary-op this))
      (compile (PyBinary-lhs this))
      (compile (PyBinary-rhs this))))

(define-walk-method (compile this::PyFun)
   (let ((args (PyFun-args this))
	 (body (compile (PyFun-body this)))
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
	  (error "compile-lambda" "Not implement" (length args))))))

(define-walk-method (compile this::PyCall)
   (if (<= (length (PyCall-args this)) 4)
       (apply bytecode (code 'CALL0 (length (PyCall-args this)))
	  (compile (PyCall-fun this))
	  (map compile (PyCall-args this)))
       (error "call" "Not implemented" (length (PyCall-args this)))))
   
(define-walk-method (compile this::PyRef)
   (let ((decl (PyRef-decl this)))
      (if (eq? (PyDecl-scope decl) 'global)
	  (bytecode (code 'GGET) (PyDecl-id decl) (make-PCache #f -1))
	  (bytecode (code 'REF0 (min (PyRef-index this) 4))))))
	  
(define-walk-method (compile this::PyRefUnresolved)
   (bytecode (code 'GGET) (PyRefUnresolved-id this) (make-PCache #f -1)))
	  
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
       (PyFunction-call0 (meaning (bytecode-ref bcode 1) env global return)))
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
      (if (>= index 0)
	  (begin
	     (PCache-set! cache (PyObject-hclass obj) index)
	     (PyObject-elements-ref obj index))
	  (error "NameError" "global name is not defined" name))))

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

