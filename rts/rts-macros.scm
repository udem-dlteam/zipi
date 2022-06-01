;; macro to implement rts procedure profiling
(cond-expand
  (gambit
   (define-syntax define-rts
     (lambda (form-src)
       (define (sourcify x)
         (if (or (|##source?| x) (not (|##source?| form-src)))
             x
             (|##sourcify-aux1| x form-src)))
       (define (err)
         (sourcify `(syntax-error "invalid define-rts")))
       (define (instrument? name)
         (let* ((co
                 (|##global-var-ref|
                  (|##make-global-var| '|##compilation-options|)))
                (comp-opts
                 (if (|##unbound?| co) '() co)))
           (assq 'debug comp-opts)))
       (define (instrument-body name body)
         (if (instrument? name)
             (list (sourcify (list (sourcify 'enter-rts)
                                   (sourcify name)))
                   (sourcify (cons (sourcify '|##let|)
                                   (cons (sourcify '())
                                         body))))
             body))
       (let ((form (|##source-strip| form-src)))
         (cond ((not (and (pair? (cdr form)) (pair? (cddr form))))
                (err))
               ((and (symbol? (|##source-strip| (cadr form)))
                     (null? (cdddr form)))
                (let* ((val-src (caddr form))
                       (val (|##source-strip| val-src)))
                  (if (and (pair? val)
                           (memq (|##source-strip| (car val))
                                 '(lambda |##lambda|)))
                      (list (sourcify 'define)
                            (sourcify (cadr form))
                            (sourcify (cons (sourcify (car val))
                                            (cons (sourcify (cadr val))
                                                  (instrument-body
                                                   (cadr form)
                                                   (cddr val))))))
                      (list (sourcify 'define)
                            (sourcify (cadr form))
                            (sourcify val)))))
               ((pair? (|##source-strip| (cadr form)))
                (cons (sourcify 'define)
                      (cons (sourcify (cadr form))
                            (instrument-body
                             (car (|##source-strip| (cadr form)))
                             (cddr form)))))
               (else
                (err))))))
   (define-syntax enter-rts
     (lambda (form-src)
       (define disable-trace? #t)
       (let ((form (|##source-strip| form-src)))
         (cond ((not (and (pair? (cdr form)) (null? (cddr form))))
                `(syntax-error "invalid enter-rts"))
               (disable-trace?
                `(|##begin|))
               (else
                `(|##println|
                  port: |##stderr-port|
                  "=== entering "
                  ',(|##source-strip| (cadr form)))))))))
  (bigloo
   (define-expander define-rts
      (lambda (x e)
	 (set-car! x 'define)
	 (e x e))))
  (else
   (define-macro (define-rts pattern . body)
     (if (pair? pattern)
         `(define ,pattern
            ;; uncomment to print each call in bigloo
            ;#(print ',pattern)
            ,@body)
         `(define ,pattern ,@body)))))


;; inline c code

(define-macro (inline-c-code code)
  (cond-expand
    (gambit
      `(let () (declare (extended-bindings)) (|##c-code| ,code)))
    (bigloo
      #f)))

;; calls

(define-macro (with-specialized-PyObjectFunction-args-limit macro-name . args)
  `(,macro-name 10 ,@args))

(define-macro (py-call0-maybe-super fn cls instance)
   (cond-expand (gambit (define-syntax match-case (lambda (src) (##import _match/match-expand) (match-expand src #t #f #t)))) (else))
   (match-case fn
      ((py-getattribute (and ?obj (py-call (global-get %global (& "super") ?-) ?cls ?instance)) ?prop ?cache ?inline-priorities)
       `(let (($fn ,fn))
	   (py-call0-maybe-super $fn ,cls ,instance)))
      ((py-getattribute ?obj ?prop ?cache ?inline-priorities)
       `(py-getattribute-and-call0-maybe-super-cached ,obj ,prop
	   ,cls ,instance ,cache ,inline-priorities))
      (else
       `(let (($fn ,fn))
	   (if (eq? $fn py-builtin-super)
	       ,(if (and cls instance)
		    `(py-call py-builtin-super ,cls ,instance)
		    `(py-throw-super-no-arguments-error))
	       (py-call $fn))))))

(define-macro (py-global-call global procedure global-id init-value name cache . args)
   (if (symbol? global-id)
       (let ((params (map (lambda (e) (gensym 'p)) args)))
          `(let* ,(map (lambda (p a) (list p a)) params args)
              (if (eq? ,global-id ,init-value)
                  (,procedure ,@params)
                  (py-call (or ,global-id (global-get ,global ,name ,cache))
                     ,@params))))
       (error "py-global-call" "global-id must be a symbol" global-id)))

(define-macro (py-call0 fun)
  `(let (($fun ,fun))
    (if (PyObjectFunctionArity0? $fun)
      ((PyObjectFunction-procedure $fun))
      (py-call0-fallback $fun))))

(define-macro (py-callX X fun . args)
  `(with-specialized-PyObjectFunction-args-limit $py-callX ,X ,fun ,@args))

(define-macro ($py-callX specialized-args-limit X fun . args)
   (define (fallback sz)
      (case sz
 	 ((1) 'py-call1-fallback)
	 ((2) 'py-call2-fallback)
	 ((3) 'py-call3-fallback)
	 (else 'py-callX-fallback)))
   (cond
      ((= X 0) `(py-call0 ,fun))
      ((<= X specialized-args-limit)
       (let ((min-neg-arity (- 0 X 1))
	     (args-names (map
			    (lambda (i) (string->symbol (string-append "$arg" (number->string i))))
			    (iota X))))
	  `(let* (($fun ,fun)
		  ,@(map list args-names args))
	      (if (,(string->symbol (string-append "PyObjectFunctionArity" (number->string X) "?")) $fun)
		  ((PyObjectFunction-procedure $fun) ,@args-names)
		  (,(fallback (length args)) ,min-neg-arity $fun ,@args-names)))))
      (else
       (,(fallback (length args)) ,(- 0 X 1) ,fun ,@args))))

(define-macro (py-getattribute-and-callX X obj attr args . opts)
   (let ((cache (if (null? opts) #f (car opts)))
         (inlines (if (or (null? opts) (null? (cdr opts))) '() (cadr opts))))
      (if cache
	  (let ((args-names (map (lambda (i)
				    (string->symbol
				       (string-append "$arg"
					  (number->string i))))
			       (iota X))))
	     `(let* ,(map list args-names args)
		 (py-getattribute-and-callX-cached ,obj ,attr ,X
		    ,args-names ,cache ,inlines)))
          `(py-callX ,X (py-getattribute-fallback ,obj ,attr) ,@args))))

(define-macro (py-callMethodX X attr instance . args)
  `(with-specialized-PyObjectFunction-args-limit $py-callMethodX ,X ,attr ,instance ,@args))

(define-macro ($py-callMethodX specialized-args-limit X attr instance . args)
   (define (gen-method)
      `(make-PyObjectMethod py-method-hclass-of-instances
	  '#() py-method-class ,instance ,attr))
   (define (fallback sz)
      (case sz
 	 ((1) 'py-call1-fallback)
	 ((2) 'py-call2-fallback)
	 ((3) 'py-call3-fallback)
	 (else 'py-callX-fallback)))
  (cond
     ((= X 0)
      `(let (($func ,attr))
	  (if (eq? (PyObjectFunction-scheme-arity $func) 1)
	      (let (($self ,instance))
		 ((PyObjectFunction-procedure $func) $self))
	      (py-call0-fallback ,(gen-method)))))
    ((<= X specialized-args-limit)
     (let ((min-neg-arity (- 0 X 1))
	   (args-names (map
                          (lambda (i) (string->symbol (string-append "$arg" (number->string i))))
                          (iota X))))
        `(let* (,@(map list args-names args))
	    (let (($func ,attr))
	       (if (eq? (PyObjectFunction-scheme-arity $func)
		      ,(+ 1 (length args)))
		   (let (($self ,instance))
		      ((PyObjectFunction-procedure $func) $self ,@args))
		   (,(fallback (length args)) ,min-neg-arity ,(gen-method) ,@args-names))))))
    (else
      (,(fallback (length args)) ,(- 0 X 1) ,(gen-method) ,@args))))

(define-macro (py-make-PyObjectFunction hclass elements cls procedure arity scheme-arity signature)
  `(with-specialized-PyObjectFunction-args-limit $py-make-PyObjectFunction ,hclass ,elements ,cls ,procedure ,arity ,scheme-arity ,signature))

(define-macro ($py-make-PyObjectFunction specialized-args-limit hclass elements cls procedure arity scheme-arity signature)
  `(let (($hclass ,hclass)
         ($elements ,elements)
         ($cls ,cls)
         ($procedure procedure)
         ($arity ,arity)
         ($scheme-arity ,scheme-arity)
         ($signature ,signature))
      (cond
        ,@(let loop ((i 0))
            (if (> i specialized-args-limit)
              '()
              (cons
                `((eqv? $arity ,i)
                    (,(string->symbol (string-append "make-PyObjectFunctionArity" (number->string i)))
                        $hclass $elements $cls $procedure $arity $scheme-arity $signature))
                (loop (+ i 1)))))
        (else (make-PyObjectFunction $hclass $elements $cls $procedure $arity $scheme-arity $signature)))))

(define-macro (define-method signature . body)
  (define method-signature #f)
  (define method-body #f)
  (define binding #f)
  (define guards '())

  (define (parse-error message body)
    (error "define-method" message (car body)))

  (define (parse body)
    (if (null? body)
      (parse-end body)
      (case (car body)
        ((signature:) (parse-signature (cdr body)))
        ((body:) (parse-body (cdr body)))
        ((guard:) (parse-guard (cdr body)))
        ((binding:) (parse-binding (cdr body)))
        (else (parse-error "unknown keyword" body)))))

  (define (parse-binding body)
    (if (or (null? body) (keyword? (car body)))
      (parse-error "binding: keyword without value" body)
      (if binding
        (parse-error "duplicate keyword binding:" body)
        (begin
          (set! binding (car body))
          (parse (cdr body))))))

  (define (parse-signature body)
    (if (or (null? body) (keyword? (car body)))
      (parse-error "signature: keyword without value" body)
      (if method-signature
        (parse-error "duplicate keyword signature:" body)
        (begin
          (set! method-signature (car body))
          (parse (cdr body))))))

  (define (parse-body body)
    (if (or (null? body) (keyword? (car body)))
      (parse-error "body: keyword without value" body)
      (if method-body
        (parse-error "duplicate keyword body:" body)
        (let loop ((body body))
          (if (or (null? body) (keyword? (car body)))
            (parse body)
            (begin
              (set! method-body (append (or method-body '()) (list (car body))))
              (loop (cdr body))))))))

  (define (parse-guard body)
    (if (or (null? body) (null? (cdr body))
            (keyword? (car body)) (keyword? (cadr body)))
      (parse-error "guard: must be followed by a condition and an exception throw" body)
      (begin
        (set! guards (append guards (list (list (car body) (cadr body)))))
        (parse (cddr body)))))

  (define (parse-end body)
    (set! binding (or binding 'method))
    (cond
      ((not method-signature)
        (parse-error "missing signature:" body))
      ((not method-body)
        (parse-error "missing body:" body))
      ((not (memq binding '(method classmethod staticmethod)))
        (parse-error "binding: must be method, classmethod or staticmethod" body))))

  (define (make-signature-for-pending-binding)
    ;; TODO: add a check that the method has enough arguments to be bound
    ;; otherwise abort and let normal exception at runtime
    ;; At the moment this will crash if this case arises
    (define remove-first-argument #f)

    (let* ((posonlyargs-cons (memq posonlyargs: method-signature))
           (posonlyargs (if posonlyargs-cons (cadr posonlyargs-cons) '()))
           (bound-posonlyargs
             (list
               posonlyargs:
               (case binding
                 ((method)
                   posonlyargs)
                 ((classmethod)
                   (if (null? posonlyargs)
                     (begin
                       (set! remove-first-argument #t)
                       (list (gensym '_)))
                     (cons (gensym '_) (cdr posonlyargs))))
                 ((staticmethod)
                   (cons (gensym '_) posonlyargs))))))

    (append
      (let loop ((method-signature method-signature))
        (cond
          ((null? method-signature)
            '())
          ((eq? (car method-signature) posonlyargs:)
            (loop (cddr method-signature))) ;; skip posonlyargs: as we add our own
          ((and remove-first-argument (eq? (car method-signature) args:))
            (cons args:
              (cons (cdadr method-signature) ;; remove first argument in args:
                    (loop (cdr method-signature)))))
          (else
            (cons (car method-signature) (loop (cdr method-signature))))))
      bound-posonlyargs)))

  (parse body)

  (let* ((name (car signature))
         (arguments (cdr signature))
         (name-string (symbol->string name))
         (procedure-name (string->symbol (string-append name-string ":procedure")))
         (unsafe-name (string->symbol (string-append name-string ":unsafe")))
         (binding-closure-maker-name (string->symbol (string-append name-string ":make-pending-binding-closure")))
         (binding-method-name (string->symbol (string-append name-string ":pending-binding")))
         (procedure-signature (cons procedure-name arguments))
         (unsafe-signature (cons unsafe-name arguments))
         (binding-arguments
           (case binding
             ((method) arguments)
             ((classmethod) (cons (gensym '_) (cdr arguments))) ;; cls will be passed in a pre-computed closure
             ((staticmethod) (cons (gensym '_) arguments))))
         (binding-method-signature (make-signature-for-pending-binding))
         (default-procedure-definition
           `(define-rts ,procedure-signature
             (cond
               ,@guards
               (else (,unsafe-name ,@arguments)))))
         (unsafe-procedure-definition
           `(define-rts ,unsafe-signature
             ,@method-body))
         (default-python-function-defintion
           `(define-rts ,name
             (procedure->py-function
               ,procedure-name
               ,method-signature)))
          (pending-binding-function-definition
            (case binding
              ((method)
                `(define-rts ,binding-method-name
                  (procedure->py-function
                    ,unsafe-name
                    ,binding-method-signature)))
              ((classmethod)
                (let ((cls-argument (gensym 'cls)))
                  `(define-rts (,binding-closure-maker-name ,cls-argument)
                    (procedure->py-function
                      (lambda ,(cons (gensym '_) (cdr arguments))
                        (,unsafe-name ,cls-argument ,@(cdr arguments)))
                      ,binding-method-signature))))
              ((staticmethod)
                `(define-rts ,binding-method-name
                  (procedure->py-function
                    (lambda ,(cons (gensym '_) arguments) (,unsafe-name ,@arguments))
                    ,binding-method-signature))))))

  `(begin
    ,unsafe-procedure-definition
    ,default-procedure-definition
    ,default-python-function-defintion
    ,pending-binding-function-definition)))


(define-macro (binding-skip-success? x)
  `(not (procedure? x)))

(define-macro (binding-skip-fail? x)
  `(procedure? x))

(define-macro (binding-skip-callback x)
  `(,x))

;; executions points in the type.__call__ method
(define-macro (type-call-from-instance self instance args-w/-instance) ;;args should contain instance
   `(let* (($self ,self)
	   ($instance ,instance)
	   ($args-w/-instance ,args-w/-instance))
       (if (eq? (py-obj-cls $instance) $self)
	   (let ((__init__ (getattribute-from-cls-mro $self (& "__init__"))))
	      (py-call-generic __init__ $args-w/-instance)
	      $instance)
	   $instance)))

(define-macro (type-callX-from-instance self instance . args)
   `(let* (($self ,self)
	   ($instance ,instance))
       (if (eq? (py-obj-cls $instance) $self)
	   (let ((__init__ (getattribute-from-cls-mro $self (& "__init__"))))
	      (py-call __init__ ,@args)
	      $instance)
	   $instance)))

(define-macro (type-call-from-new-method self args __new__)
  `(let* (($self ,self)
         ($args ,args)
         ($__new__ ,__new__)
         (args-w/-instance (cons $self $args))
         (instance (py-call-generic $__new__ args-w/-instance)))
      (type-call-from-instance $self instance args-w/-instance)))

(define-macro (type-callX-from-new-method cls __new__ . args)
   `(let* (($cls ,cls)
	         ($__new__ ,__new__)
	         (instance (py-call $__new__ $cls ,@args)))
      (type-callX-from-instance $cls instance $cls ,@args)))

;; Macros to enable/disable various implementation strategies.

(define-macro (py-if-specialized-sint-representation yes no) yes)
(define-macro (py-if-specialized-float-representation yes no) yes)
(define-macro (py-if-enable-behaviors-optimization yes no) yes)
(define-macro (py-if-enable-inline-behavior-dispatch yes no) no)
(define-macro (py-if-enable-inlined-mixed-types-behaviors yes no) yes)
(define-macro (py-if-enable-inline-partial-behavior-dispatch yes no) no)

(define-macro (py-when-enable-cache-debug . code)
  (define enable-cache-debug #f)
  `(begin ,@(if enable-cache-debug code '())))

(define-macro (py-bool-to-scheme-float arg)
  `(fixnum->flonum (py-bool-to-scheme-int ,arg)))

(define-macro (py-int-to-scheme-float arg)
  `(exact->inexact (py-int-to-scheme ,arg)))

(define-macro (py-sint-to-scheme-float arg)
  `(fixnum->flonum (py-sint-to-scheme ,arg)))

(define-macro (py-bint-to-scheme-float arg)
  `(exact->inexact (py-bint-to-scheme ,arg)))

(define-macro (py-int-to-scheme obj)
  `(py-if-specialized-sint-representation
    (let (($obj ,obj))
      (if (fixnum? $obj)
          $obj
          (PyObjectInt-value $obj)))
    (PyObjectInt-value ,obj)))

(define-macro (py-subtype-of-int-to-scheme obj)
  `(py-if-specialized-sint-representation
    (let (($obj ,obj))
      (if (fixnum? $obj)
          $obj
          (PyObjectInt-value $obj)))
    (PyObjectInt-value ,obj)))

(define-macro (py-strict-subtype-of-int-to-scheme obj)
  `(PyObjectInt-value ,obj))

(define-macro (py-bool-to-scheme-int arg)
  `(py-strict-subtype-of-int-to-scheme ,arg)) ;; a bool is an int with value 0 or 1

(define-macro (py-bool-from-scheme-bool arg)
  `(if ,arg py-True py-False))

(define-macro (py-bool-to-scheme-bool arg)
  (cond
    ((eq? arg 'py-True) #t)
    ((eq? arg 'py-False) #f)
    (else `(py-test-is ,arg py-True))))

(define-macro (py-sint-to-scheme arg)
  `(py-if-specialized-sint-representation
    ,arg
    (PyObjectInt-value ,arg)))

(define-macro (py-bint-to-scheme arg)
  `(PyObjectInt-value ,arg))

(define-macro (py-float-to-scheme arg)
  `(py-if-specialized-float-representation
    ,arg
    (PyObjectFloat-value ,arg)))

(define-macro (py-subtype-of-float-to-scheme obj)
  `(py-if-specialized-float-representation
    (let (($obj ,obj))
      (if (flonum? $obj)
          $obj
          (PyObjectFloat-value $obj)))
    (PyObjectFloat-value ,obj)))

(define-macro (py-strict-subtype-of-float-to-scheme obj)
  `(PyObjectFloat-value ,obj))

(define-macro (alloc-new-PyObjectInt-from-scheme value)
  `(make-PyObjectInt
      py-int-hclass-of-instances
      '#()
      py-builtin-int
      ,value))

(define-macro (py-bint-from-scheme value)
  `(py-bint-from-scheme-fallback ,value))

;; TODO: handle overflow (these procedures should raise an OverflowError
(define-macro (py-int-to-float value)
  `(let (($value ,value))
    (if (fixnum? $value)
      (py-sint-to-float $value)
      (exact->inexact (PyObjectInt-value $value)))))

(define-macro (py-sint-to-float value)
  `(fixnum->flonum ,value))

(define-macro (py-bint-to-float value)
  `(exact->inexact (py-bint-to-scheme ,value)))

(define-macro (py-bool-to-float value)
  `(if (eq? ,value py-True) 1.0 0.0))

(define-macro (py-int-from-scheme arg)

  ;; assume all small int operations don't cause an overflow?
  (define disregard-sint-overflow? #f)

  (define unary-operators-gambit
    '((pypos    X ;; bool or non-ov. sint
                X ;; sint
                X ;; otherwise
                )
      (pyneg    (py-sint-from-scheme (|##fx-| X)) ;; bool or non-ov. sint
                (or (|##fx-?| X) (|##negate| X)) ;; sint
                (pyneg-UintX-fallback X) ;; otherwise
                )
      (pyinvert (py-sint-from-scheme (|##fxnot| X)) ;; bool or non-ov. sint
                (py-sint-from-scheme (|##fxnot| X)) ;; sint
                (pyinvert-UintX-fallback X) ;; otherwise
                )))

  (define binary-operators-gambit
    '((py+  (py-sint-from-scheme (|##fx+| X Y)) ;; bool/bool or non-ov. sint/sint
            (or (|##fx+?| X Y) (pyadd-UintX-UintY-fallback X Y)) ;; sint/sint
            (pyadd-UintX-UintY-fallback X Y) ;; otherwise
            )
      (py-  (py-sint-from-scheme (|##fx-| X Y)) ;; bool/bool or non-ov. sint/sint
            (or (|##fx-?| X Y) (pysub-UintX-UintY-fallback X Y)) ;; sint/sint
            (pysub-UintX-UintY-fallback X Y) ;; otherwise
            )
      (py*  (py-sint-from-scheme (|##fx*| X Y)) ;; bool/bool or non-ov. sint/sint
            (or (|##fx*?| X Y) (pymul-UintX-UintY-fallback X Y)) ;; sint/sint
            (pymul-UintX-UintY-fallback X Y) ;; otherwise
            )
      ;; TODO: define and use a primitive
      (py** (py-int-from-scheme (expt X Y))
            (py-int-from-scheme (expt X Y))
            (py-int-from-scheme (expt X Y))
            )
      (py&  (py-sint-from-scheme (|##fxand| X Y)) ;; bool/bool or non-ov. sint/sint
            (py-sint-from-scheme (|##fxand| X Y)) ;; sint/sint
            (py&-UintX-UintY-fallback X Y) ;; otherwise
            )
      (py+b (py-sint-from-scheme (|##fxior| X Y)) ;; bool/bool or non-ov. sint/sint
            (py-sint-from-scheme (|##fxior| X Y)) ;; sint/sint
            (py+b-UintX-UintY-fallback X Y) ;; otherwise
            )
      (py^  (py-sint-from-scheme (|##fxxor| X Y)) ;; bool/bool or non-ov. sint/sint
            (py-sint-from-scheme (|##fxxor| X Y)) ;; sint/sint
            (py^-UintX-UintY-fallback X Y) ;; otherwise
            )
      (py>> (py-sint-from-scheme (|##fxarithmetic-shift-right| X Y)) ;; bool/bool or non-ov. sint/sint
            (or (|##fxarithmetic-shift-right?| X Y) (py>>-UintX-UintY-fallback X Y)) ;; sint/sint
            (py>>-UintX-UintY-fallback X Y) ;; otherwise
            )
      (py<< (py-sint-from-scheme (|##fxarithmetic-shift-left| X Y)) ;; bool/bool or non-ov. sint/sint
            (or (|##fxarithmetic-shift-left?| X Y) (py<<-UintX-UintY-fallback X Y)) ;; sint/sint
            (py<<-UintX-UintY-fallback X Y) ;; otherwise
            )
      (py// (py-sint-from-scheme (|##fxquotient| X Y)) ;; bool/bool or non-ov. sint/sint
            (if (|##eqv?| Y -1) ;; sint/sint
                (or (|##fx-?| X) (|##negate| X))
                (|##fxquotient| X Y))
            (py//-UintX-UintY-fallback X Y) ;; otherwise
            )
      (py%  (py-sint-from-scheme (|##fxmodulo| X Y)) ;; bool/bool or non-ov. sint/sint
            (py-sint-from-scheme (|##fxmodulo| X Y)) ;; sint/sint
            (py%-UintX-UintY-fallback X Y) ;; otherwise
            )))

  (define unary-operators-bigloo
    '((pypos    X ;; bool or non-ov. sint
                X ;; sint
                X ;; otherwise
                )
      (pyneg    (py-sint-from-scheme (negfx X)) ;; bool or non-ov. sint
                (py-int-from-scheme (- X)) ;; sint
                (py-int-from-scheme (- X)) ;; otherwise
                )
      (pyinvert (py-sint-from-scheme (bit-not X)) ;; bool or non-ov. sint
                (py-sint-from-scheme (bit-not X)) ;; sint
                (py-int-from-scheme (bit-not X)) ;; otherwise
                )))

  (define binary-operators-bigloo
    '((py+  (py-sint-from-scheme (+fx X Y)) ;; bool/bool or non-ov. sint/sint
            (py-int-from-scheme (+fx/overflow X Y)) ;; sint/sint
            (py-int-from-scheme (+ X Y)) ;; otherwise
            )
      (py-  (py-sint-from-scheme (-fx X Y)) ;; bool/bool or non-ov. sint/sint
            (py-int-from-scheme (-fx/overflow X Y)) ;; sint/sint
            (py-int-from-scheme (- X Y)) ;; otherwise
            )
      (py*  (py-sint-from-scheme (*fx X Y)) ;; bool/bool or non-ov. sint/sint
            (py-int-from-scheme (*fx/overflow X Y)) ;; sint/sint
            (py-int-from-scheme (* X Y)) ;; otherwise
            )
      (py** (py-sint-from-scheme (exptfx X Y)) ;; bool/bool or non-ov. sint/sint
            (py-int-from-scheme (expt X Y)) ;; sint/sint
            (py-int-from-scheme (expt X Y)) ;; otherwise
            )
      (py&  (py-sint-from-scheme (bit-and X Y)) ;; bool/bool or non-ov. sint/sint
            (py-int-from-scheme (bit-and X Y)) ;; sint/sint
            (py-int-from-scheme (bit-and X Y)) ;; otherwise
            )
      (py+b (py-sint-from-scheme (bit-or X Y)) ;; bool/bool or non-ov. sint/sint
            (py-int-from-scheme (bit-or X Y)) ;; sint/sint
            (py-int-from-scheme (bit-or X Y)) ;; otherwise
            )
      (py^  (py-sint-from-scheme (bit-xor X Y)) ;; bool/bool or non-ov. sint/sint
            (py-int-from-scheme (bit-xor X Y)) ;; sint/sint
            (py-int-from-scheme (bit-xor X Y)) ;; otherwise
            )
      (py>> (py-sint-from-scheme (bit-rsh X Y)) ;; bool/bool or non-ov. sint/sint
            (py-int-from-scheme (bit-rsh X Y)) ;; sint/sint
            (py-int-from-scheme (bit-rsh X Y)) ;; otherwise
            )
      (py<< (py-sint-from-scheme (bit-lsh X Y)) ;; bool/bool or non-ov. sint/sint
            (py-int-from-scheme (bit-lsh X Y)) ;; sint/sint
            (py-int-from-scheme (bit-lsh X Y)) ;; otherwise
            )
      (py// (py-sint-from-scheme (quotientfx X Y)) ;; bool/bool or non-ov. sint/sint
            (py-int-from-scheme (quotient X Y)) ;; sint/sint
            (py-int-from-scheme (quotient X Y)) ;; otherwise
            )
      (py%  (py-sint-from-scheme (modulofx X Y)) ;; bool/bool or non-ov. sint/sint
            (py-int-from-scheme (modulo X Y)) ;; sint/sint
            (py-int-from-scheme (modulo X Y)) ;; otherwise
            )))

  (define host (cond-expand (gambit 'gambit) (bigloo 'bigloo)))

  (define (type operand)
    (cond
      ((pair? operand)
        (let ((x (assq (car operand)
                        '((py-bool-to-scheme-int bool)
                          (py-sint-to-scheme sint)
                          (py-str-len-to-scheme sint)
                          (py-bint-to-scheme bint)
                          (py-int-to-scheme  int)
                          (py-float-to-scheme float)
                          (py-subtype-of-float-to-scheme float)
                          (py-str-to-scheme  str)))))
          (and x (cadr x))))
      ((fixnum? operand)
        'sint)
      ((flonum? operand)
        'float)
      (((cond-expand (gambit |##bignum?|) (bigloo bignum?)) operand)
        'bint)
      (else
        #f)))

  (define (bool? t) (eq? t 'bool))
  (define (bool-or-sint? t) (or (eq? t 'bool) (eq? t 'sint)))

  (define (out-of-line arg)
    `(py-int-from-scheme-fallback ,arg))

  (define (fallback arg)
    `(py-if-specialized-sint-representation
      (let (($arg ,arg))
        (if (fixnum? $arg)
            $arg
            ,(out-of-line '$arg)))
      ,(out-of-line arg)))

  (define (all? pred lst)
    (not (member #f (map pred lst))))

  (define (strip-py-bint-from-scheme expr)
    (if (pair? expr)
        (if (eq? (car expr) 'py-bint-from-scheme)
            (strip-py-bint-from-scheme (cadr expr))
            (map strip-py-bint-from-scheme expr))
        expr))

  (define (special-case-sint expr)
    (let ((expr-without-bint (strip-py-bint-from-scheme expr)))
      (if (equal? expr expr-without-bint)
          expr
          `(py-if-specialized-sint-representation
            ,expr
            ,(out-of-line expr-without-bint)))))

  (cond ((pair? arg)
         (let* ((operator (car arg))
                (operands (cdr arg))
                (operand-types (map type operands)))
           (case (length operands)
             ((1)
              (cond ((assq operator
                            (case host
                              ((gambit) unary-operators-gambit)
                              ((bigloo) unary-operators-bigloo)))
                     =>
                     (lambda (entry)
                       (cond ((or (bool? (car operand-types))
                                  disregard-sint-overflow?)
                              (let ((expr (cadr entry)))
                                (if (eq? expr 'X)
                                    (cadr (car operands))
                                    `(let ((X ,(car operands)))
                                       ,expr))))
                             ((bool-or-sint? (car operand-types))
                              (let ((expr (caddr entry)))
                                (if (eq? expr 'X)
                                    (cadr (car operands))
                                    `(let ((X ,(car operands)))
                                       ,(special-case-sint expr)))))
                             (else
                              (let ((expr (cadddr entry)))
                                (if (eq? expr 'X)
                                    (cadr (car operands))
                                    `(let ((X ,(car operands)))
                                       ,expr)))))))
                    (else
                     (fallback arg))))
             ((2)
              (cond ((assq operator
                            (case host
                              ((gambit) binary-operators-gambit)
                              ((bigloo) binary-operators-bigloo)))
                     =>
                     (lambda (entry)
                       (cond ((or (all? bool? operand-types)
                                  disregard-sint-overflow?)
                              (let ((expr (cadr entry)))
                                `(let* ((X ,(car operands))
                                        (Y ,(cadr operands)))
                                   ,expr)))
                             ((all? bool-or-sint? operand-types)
                              (let ((expr (caddr entry)))
                                `(let* ((X ,(car operands))
                                        (Y ,(cadr operands)))
                                   ,(special-case-sint expr))))
                             (else
                              (let ((expr (cadddr entry)))
                                `(let* ((X ,(car operands))
                                        (Y ,(cadr operands)))
                                   ,expr))))))
                    (else
                     (fallback arg))))
             (else
              (fallback arg)))))
        ((and (number? arg) (exact? arg) (integer? arg))
         `(py-if-specialized-sint-representation
           ,arg
           ,(let ()
              (define int-cache-low -5) ;; must be same as in rts.scm
              (define int-cache-high 256)
              (if (and (<= arg int-cache-high)
                       (>= arg int-cache-low))
                  `(vector-ref int-cache ,(- arg int-cache-low))
                  (fallback arg)))))
        (else
         (fallback arg))))

(define-macro (py-sint-from-scheme arg)
 `(py-if-specialized-sint-representation
   ,arg
   (alloc-new-PyObjectInt-from-scheme ,arg)))

(define-macro (py-float-from-scheme arg)

 (define unary-operators-gambit
   '((pypos X)
     (pyneg (|##fl-| X))))

 (define binary-operators-gambit
   '((py+  (|##fl+| X Y))
     (py-  (|##fl-| X Y))
     (py*  (|##fl*| X Y))
     (py** (|##flexpt| X Y))
     (py/  (|##fl/| X Y))
     (py// (|##flfloor| (|##fl/| X Y)))
     (py%
      (let (($temp (fl/ X Y)))
        (|##fl-| X
                 (|##fl*| Y
                          (if (|##fl<| 0.0 X)
                              (|##flfloor| $temp)
                              (|##flceiling| $temp))))))))

 (define unary-operators-bigloo
   '((pypos X)
     (pyneg (negfl X))))

 (define binary-operators-bigloo
   '((py+  (+fl X Y))
     (py-  (-fl X Y))
     (py*  (*fl X Y))
     (py** (exptfl X Y))
     (py/  (/fl X Y))
     (py// (floorfl (/fl X Y)))
     (py%
      (let (($temp (/fl X Y)))
        (-fl X
             (*fl Y
                  (if (<fl 0.0 X)
                      (floorfl $temp)
                      (ceilingfl $temp))))))))

 (define host (cond-expand (gambit 'gambit) (bigloo 'bigloo)))

 (define (type operand)
   (cond
     ((pair? operand)
       (let ((x (assq (car operand)
                       '((py-bool-to-scheme-int bool)
                         (py-sint-to-scheme sint)
                         (py-str-len-to-scheme sint)
                         (py-bint-to-scheme bint)
                         (py-int-to-scheme  int)
                         (py-float-to-scheme float)
                         (py-subtype-of-float-to-scheme float)
                         (py-str-to-scheme  str)))))
         (and x (cadr x))))
     ((fixnum? operand)
       'sint)
     ((flonum? operand)
       'float)
     (((cond-expand (gambit |##bignum?|) (bigloo bignum?)) operand)
       'bint)
     (else
       #f)))

 (define (fallback arg)
   `(py-if-specialized-float-representation
     ,arg
     (py-float-from-scheme-fallback ,arg)))

 (define (to-float operand)
   (case (type operand)
     ((sint bint int)
      (list (string->symbol
             (string-append (symbol->string (car operand))
                            "-float"))
            (cadr operand)))
     ((bool) `(py-bool-to-scheme-float ,(cadr operand)))
     ((float) operand)
     (else
      (error "unexpected type" operand))))

 (cond ((pair? arg)
        (let* ((operator (car arg))
               (operands (cdr arg))
               (operand-types (map type operands)))
          (case (length operands)
            ((1)
             (cond ((assq operator
                           (case host
                             ((gambit) unary-operators-gambit)
                             ((bigloo) unary-operators-bigloo)))
                    =>
                    (lambda (entry)
                      (let ((expr (cadr entry)))
                        (if (and (eq? expr 'X)
                                 (eq? (type (car operands)) 'float))
                            (cadr (car operands))
                            `(let ((X ,(to-float (car operands))))
                               ,expr)))))
                   (else
                    (fallback arg))))
            ((2)
             (cond ((assq operator
                           (case host
                             ((gambit) binary-operators-gambit)
                             ((bigloo) binary-operators-bigloo)))
                    =>
                    (lambda (entry)
                      (let ((expr (cadr entry)))
                        `(let* ((X ,(to-float (car operands)))
                                (Y ,(to-float (cadr operands))))
                           ,expr))))
                   (else
                    (fallback arg))))
            (else
             (fallback arg)))))
       (else
        (fallback arg))))

(define-macro (py-test-from-scheme arg)

  (define comparison-operators-gambit
    '((py== (|##fx=| X Y) ;; sint-sint
            (|##fl=| X Y) ;; float-float
            (|##=2| X Y) ;; sint-float
            (|##=2| X Y) ;; float-sint
            (|##string=?| X Y) ;; str-str
            (|##=2| X Y) ;; otherwise
            )
      (py!= (|##not| (|##fx=| X Y)) ;; sint-sint
            (|##not| (|##fl=| X Y)) ;; float-float
            (|##not| (|##=2| X Y)) ;; sint-float
            (|##not| (|##=2| X Y)) ;; float-sint
            (|##not| (|##string=?| X Y)) ;; str-str
            (|##not| (|##=2| X Y)) ;; otherwise
            )
      (py>= (|##fx>=| X Y) ;; sint-sint
            (|##fl>=| X Y) ;; float-float
            (|##>=| X Y) ;; sint-float
            (|##>=| X Y) ;; float-sint
            (|##string>=?| X Y) ;; str-str
            (|##>=| X Y) ;; otherwise
            )
      (py>  (|##fx>| X Y) ;; sint-sint
            (|##fl>| X Y) ;; float-float
            (|##>| X Y) ;; sint-float
            (|##>| X Y) ;; float-sint
            (|##string>?| X Y) ;; str-str
            (|##>| X Y) ;; otherwise
            )
      (py<= (|##fx<=| X Y) ;; sint-sint
            (|##fl<=| X Y) ;; float-float
            (|##<=| X Y) ;; sint-float
            (|##<=| X Y) ;; float-sint
            (|##string<=?| X Y) ;; str-str
            (|##<=| X Y) ;; otherwise
            )
      (py<  (|##fx<| X Y) ;; sint-sint
            (|##fl<| X Y) ;; float-float
            (|##<| X Y) ;; sint-float
            (|##<| X Y) ;; float-sint
            (|##string<?| X Y) ;; str-str
            (|##<| X Y) ;; otherwise
            )))

  (define comparison-operators-bigloo
    '((py== (=fx X Y) ;; sint-sint
            (=fl X Y) ;; float-float
            (= X Y) ;; sint-float
            (= X Y) ;; float-sint
            (string=? X Y) ;; str-str
            (= X Y) ;; otherwise
            )
      (py!= (not (=fx X Y)) ;; sint-sint
            (not (=fl X Y)) ;; float-float
            (not (= X Y)) ;; sint-float
            (not (= X Y)) ;; float-sint
            (not (string=? X Y)) ;; str-str
            (not (= X Y)) ;; otherwise
            )
      (py>= (>=fx X Y) ;; sint-sint
            (>=fl X Y) ;; float-float
            (>= X Y) ;; sint-float
            (>= X Y) ;; float-sint
            (string>=? X Y) ;; str-str
            (>= X Y) ;; otherwise
            )
      (py>  (>fx X Y) ;; sint-sint
            (>fl X Y) ;; float-float
            (> X Y) ;; sint-float
            (> X Y) ;; float-sint
            (string>? X Y) ;; str-str
            (> X Y) ;; otherwise
            )
      (py<= (<=fx X Y) ;; sint-sint
            (<=fl X Y) ;; float-float
            (<= X Y) ;; sint-float
            (<= X Y) ;; float-sint
            (string<=? X Y) ;; str-str
            (<= X Y) ;; otherwise
            )
      (py<  (<fx X Y) ;; sint-sint
            (<fl X Y) ;; float-float
            (< X Y) ;; sint-float
            (< X Y) ;; float-sint
            (string<? X Y) ;; str-str
            (< X Y) ;; otherwise
            )))

  (define (dispatch-operator ops types)
    (cond
      ((equal? types '(sint sint)) (car ops))
      ((equal? types '(float float)) (cadr ops))
      ((equal? types '(sint float)) (caddr ops))
      ((equal? types '(float sint)) (cadddr ops))
      ((equal? types '(str str)) (list-ref ops 4))
      (else (list-ref ops 5))))

  (define host (cond-expand (gambit 'gambit) (bigloo 'bigloo)))

  (define (type operand)
    (cond
      ((pair? operand)
        (let ((x (assq (car operand)
                        '((py-bool-to-scheme-int bool)
                          (py-sint-to-scheme sint)
                          (py-str-len-to-scheme sint)
                          (py-bint-to-scheme bint)
                          (py-int-to-scheme  int)
                          (py-float-to-scheme float)
                          (py-subtype-of-float-to-scheme float)
                          (py-str-to-scheme  str)))))
          (and x (cadr x))))
      ((fixnum? operand)
        'sint)
      ((flonum? operand)
        'float)
      (((cond-expand (gambit |##bignum?|) (bigloo bignum?)) operand)
        'bint)
      (else
        #f)))

  (define (bool? t) (eq? t 'bool))
  (define (bool-or-sint? t) (or (eq? t 'bool) (eq? t 'sint)))

  (define (all? pred lst)
    (not (member #f (map pred lst))))

  (define (fallback arg)
    `(py-test-fallback ,arg))

  (cond
    ((pair? arg)
      (let* ((operator (car arg))
             (operands (cdr arg))
             (operand-types (map type operands)))
        (cond ((assq operator
                      (case host
                        ((gambit) comparison-operators-gambit)
                        ((bigloo) comparison-operators-bigloo)))
                =>
                (lambda (entry)
                  `(let* ((X ,(car operands))
                          (Y ,(cadr operands)))
                     ,(dispatch-operator (cdr entry) operand-types))))
              (else (fallback arg)))))
    (else
      ;; scheme value should be tested as is
      ,arg)))

(define-macro (py-mul-UstrX-UintY string repetitions)
  ;; TODO: Check for memory error if string * repetitions is a bint
  `(let* (($repetitions ,repetitions)
          ($string ,string)
          (len (string-length $string))
          (result-len (* len $repetitions))
          (result (make-string result-len)))
     (let loop ((i 0))
       (if (>= i result-len)
           result
           (begin
             (substring-move! $string 0 len result i)
             (loop (+ i len)))))))

(define-macro (py-str-len-to-scheme arg)
  `(PyObjectStr-len ,arg))

(define-macro (py-str-from-scheme arg)
  (define (fallback arg)
    `(py-str-from-scheme-fallback ,arg))

  (define (type operand)
    (cond
      ((pair? operand)
        (let ((x (assq (car operand)
                        '((py-bool-to-scheme-int bool)
                          (py-sint-to-scheme sint)
                          (py-str-len-to-scheme sint)
                          (py-bint-to-scheme bint)
                          (py-int-to-scheme  int)
                          (py-float-to-scheme float)
                          (py-subtype-of-float-to-scheme float)
                          (py-str-to-scheme  str)))))
          (and x (cadr x))))
      ((fixnum? operand)
        'sint)
      ((flonum? operand)
        'float)
      (((cond-expand (gambit |##bignum?|) (bigloo bignum?)) operand)
        'bint)
      (else
        #f)))

  (define number-type '(int sint bint bool))

  (define (to-str x)
    (if (and (pair? x) (eq? (car x) 'py-str-to-scheme))
      (cadr x)
      x))

  (define (str-concat left right)
    ;; remove py-str-to-scheme and apply concat optimisation w/o unboxing
    `(py-concat-strX-strY ,(to-str left) ,(to-str right)))

  (define (str-mul left right)
    (define (error-non-int) (error "py-str-from-scheme" "str multiplication with non-integer"))

    (let ((left-type (type left))
          (right-type (type right)))
      (if (eq? left-type 'str)
        ;; left is the string
        (if (memq right-type number-type)
          `(py-str-from-scheme-fallback (py-mul-UstrX-UintY ,left ,right))
          (error-non-int))
        (if (eq? right-type 'str)
          ;; right is the string
          (if (memq left-type number-type)
            `(py-str-from-scheme-fallback (py-mul-UstrX-UintY ,right ,left))
            (error-non-int))
          (error "py-str-from-scheme" "str multiplication called on non-str's" left right)))))

  (if (pair? arg)
    (let* ((operator (car arg))
           (operands (cdr arg)))
      (case operator
        ((py+) (apply str-concat operands))
        ((py*) (apply str-mul operands))
        (else (fallback arg))))
    (fallback arg)))

(define-macro (py-specialized-sint-float-dispatch-let name obj int float other)
  `(let ((,name ,obj))
     (cond ((py-if-specialized-sint-representation (fixnum? ,name) #f)
            ,int)
           ((py-if-specialized-float-representation (flonum? ,name) #f)
            ,float)
           (else
            ,other))))

;; Get hclass of object given specialized representations of int and float

(define-macro (py-obj-hclass obj)
  `(py-specialized-sint-float-dispatch-let
    $obj
    ,obj
    py-int-hclass-of-instances
    py-float-hclass-of-instances
    (py-obj-hclass-general $obj)))

(define-macro (py-obj-hclass-general obj)
  `(PyObject-hclass ,obj))

;; Get class of object given specialized representations of int and float

(define-macro (py-obj-cls-general obj)
  `(PyObject-class ,obj))

(define-macro (py-obj-cls obj) ;; get object's class
  `(py-specialized-sint-float-dispatch-let
    $obj
    ,obj
    py-builtin-int
    py-builtin-float
    (py-obj-cls-general $obj)))

(define-macro (py-obj-mro obj) ;; get MRO of object's class
  `(PyObjectType-mro (py-obj-cls ,obj)))

(define-macro (py-obj-class-index obj)
  `(with-class-indices-info $py-obj-class-index ,obj))

(define-macro ($py-obj-class-index indices-info obj)
  (define sint-class-index (cadr (assq 'sint indices-info)))
  (define float-class-index (cadr (assq 'float indices-info)))

  `(py-specialized-sint-float-dispatch-let
    $obj
    ,obj
    ,sint-class-index
    ,float-class-index
    (py-obj-class-index-general $obj)))

(define-macro (py-obj-class-index-general obj)
  `(PyObjectType-class-index (py-obj-cls-general ,obj)))

;; Specialized type tests for int
(define-macro (py-has-type-sint? obj)
  `(py-specialized-sint-float-dispatch-let
    $obj
    ,obj
    #t
    #f
    (py-if-specialized-sint-representation
      #f
      (and (py-has-type-int? $obj) (fixnum? (py-int-to-scheme $obj))))))

(define-macro (py-has-type-bint? obj)
  `(py-specialized-sint-float-dispatch-let
    $obj
    ,obj
    #f
    #f
    (and (py-has-type-int? $obj) (not (fixnum? (py-int-to-scheme $obj))))))

(define-macro (py-has-type-int? obj)
  `(py-specialized-sint-float-dispatch-let
    $obj
    ,obj
    #t
    #f
    (eq? (PyObject-class $obj) py-builtin-int)))

(define-macro (py-subtype-of-int? obj)
  `(py-specialized-sint-float-dispatch-let
    $obj
    ,obj
    #t
    #f
    (or (eq? (PyObject-class $obj) py-builtin-int)
        (py-isinstance? $obj py-builtin-int))))

(define-macro (py-strict-subtype-of-int? obj)
  `(py-specialized-sint-float-dispatch-let
    $obj
    ,obj
    #f
    #f
    (and (not (eq? (PyObject-class $obj) py-builtin-int))
         (py-isinstance? $obj py-builtin-int))))

;; Specialized type tests for float

(define-macro (py-has-type-float? obj)
  `(py-specialized-sint-float-dispatch-let
    $obj
    ,obj
    #f
    #t
    #f))

(define-macro (py-subtype-of-float? obj)
  `(py-specialized-sint-float-dispatch-let
    $obj
    ,obj
    #f
    #t
    (or (eq? (PyObject-class $obj) py-builtin-float)
        (py-isinstance? $obj py-builtin-float))))

(define-macro (py-strict-subtype-of-float? obj)
  `(py-specialized-sint-float-dispatch-let
    $obj
    ,obj
    #f
    #f
    (and (not (eq? (PyObject-class $obj) py-builtin-float))
         (py-isinstance? $obj py-builtin-float))))

;; Specialized type tests for str

(define-macro (py-has-type-str? obj)
  (let* ((case-PyObject
          `(eq? (PyObject-class $obj) py-str-class))
         (special-case-float
          `(py-if-specialized-float-representation
            (and (not (flonum? $obj))
                 ,case-PyObject)
            ,case-PyObject))
         (special-case-int
          `(py-if-specialized-sint-representation
            (and (not (fixnum? $obj))
                 ,special-case-float)
            ,special-case-float)))
    `(let (($obj ,obj))
       ,special-case-int)))

(define-macro (py-subtype-of-str? obj)
  (let* ((case-PyObject
          `(or (eq? (PyObject-class $obj) ;; optimize common case
                    py-str-class)
               (py-isinstance? $obj py-str-class)))
         (special-case-float
          `(py-if-specialized-float-representation
            (and (not (flonum? $obj))
                 ,case-PyObject)
            ,case-PyObject))
         (special-case-int
          `(py-if-specialized-sint-representation
            (and (not (fixnum? $obj))
                 ,special-case-float)
            ,special-case-float)))
    `(let (($obj ,obj))
       ,special-case-int)))

(define-macro (py-subtype-of-str-from-scheme string str-subclass)
  `(py-subtype-of-str-from-scheme-fallback ,string ,str-subclass))

(define-macro (py-str-to-scheme str)
  `(py-str-to-scheme-fallback ,str))

(define-macro (py-str-representative str)
  `(let ((str ,str))
     (let ((rep (PyObjectStr-part2-or-rep str)))
       (if (PyObjectStrRep? rep)
           rep
           (py-str-representative-fallback str)))))

(define-macro (py-add-strX-strY str1 str2)
  `(py-add-SstrX-SstrY-fallback ,str1 ,str2))

;; operations on lists

(define-macro (list-get-inner-len len)
  `(let (($len ,len))
    (fx+
      4
      (fx+ $len
           (fxquotient $len 8))))) ;; growth factor = 1.125

(define-macro (list-get-shrink-threshold len)
  `(let (($len ,len))
    (fxmax
      4
      (fx- $len
           (fxquotient $len 3)))))

(define-macro (py-make-list . elements)
  (let* ((len (length elements))
         (inner-len (+ 4 (+ len (quotient len 8)))) ;; must mirror list-get-inner-len macro
         (empty-len (- inner-len len)))
    `(py-list-from-scheme
      (vector ,@elements ,@(make-list empty-len #f))
      ,len)))

(define-macro (py-list-from-scheme vec len)
  `(make-PyObjectList
    py-list-hclass-of-instances
    '#()
    py-list-class
    ,vec
    ,len))

(define-macro (py-list-subtype-from-scheme cls vec len)
  `(make-PyObjectList
    (PyObjectType-hclass-of-instances cls)
    '#()
    ,cls
    ,vec
    ,len))

(define-macro (py-make-list-from-elems elements)
  `(let* (($elements ,elements)
          (len (length $elements))
          (inner-len (list-get-inner-len len))
          (vec (make-vector inner-len #f)))
    (let loop ((i 0) (lst $elements))
      (if (null? lst)
        (py-list-from-scheme vec len)
        (begin
          (vector-set! vec i (car lst))
          (loop (fx+ i 1) (cdr lst)))))))

(define-macro (py-make-list-from-vec vec)
  `(let* (($vec ,vec)
          (len (vector-length $vec))
          (inner-len (list-get-inner-len len))
          (new-vector (make-vector inner-len #f)))
    (subvector-move! $vec 0 len new-vector 0)
    (py-list-from-scheme new-vector len)))

(define-macro (py-add-listX-listY-inline list1 list2)
  (let (($list1 (gensym 'list))
        ($list2 (gensym 'list))
        ($len1 (gensym 'len))
        ($len2 (gensym 'len))
        ($res-len (gensym 'len))
        ($res-vec (gensym 'vec)))
    `(let* ((,$list1 ,list1)
           (,$list2 ,list2)
           (,$len1 (PyObjectList-len ,$list1))
           (,$len2 (PyObjectList-len ,$list2))
           (,$res-len (fx+ ,$len1 ,$len2))
           (,$res-vec (make-vector (list-get-inner-len ,$res-len) #f)))
      (subvector-move! (PyObjectList-vector ,$list1) 0 ,$len1 ,$res-vec 0)
      (subvector-move! (PyObjectList-vector ,$list2) 0 ,$len2 ,$res-vec ,$len1)
      (py-list-from-scheme ,$res-vec ,$res-len))))

(define-macro (py-mul-listX-UintY lst n)
  (let (($list (gensym 'list))
        ($len (gensym 'len))
        ($vec (gensym 'vec))
        ($n (gensym 'n))
        ($res-len (gensym 'len))
        ($res-vec (gensym 'vec)))
    `(let* ((,$list ,lst)
           (,$len (PyObjectList-len ,$list))
           (,$vec (PyObjectList-vector ,$list))
           (,$n ,n)
           (,$res-len (* ,$n ,$len))
           (,$res-vec (make-vector (list-get-inner-len ,$res-len) #f)))
      (let loop ((i 0))
        (if (< i ,$res-len)
          (begin
            (subvector-move! ,$vec 0 ,$len ,$res-vec i)
            (loop (+ i ,$len)))
          (py-list-from-scheme ,$res-vec ,$res-len))))))

(define-macro (py-EQUAL?-listX-listY list1 list2 yes no)
  (let (($list1 (gensym 'list))
        ($list2 (gensym 'list))
        ($len1 (gensym 'len))
        ($len2 (gensym 'len))
        ($vec1 (gensym 'vec))
        ($vec2 (gensym 'vec)))
    `(let* ((,$list1 ,list1)
           (,$list2 ,list2)
           (,$len1 (PyObjectList-len ,$list1))
           (,$len2 (PyObjectList-len ,$list2))
           (,$vec1 (PyObjectList-vector ,$list1))
           (,$vec2 (PyObjectList-vector ,$list2)))
      (if (fx= ,$len1 ,$len2)
        (let loop ((i 0))
          (if (< i ,$len1)
            (if (py-test (py-eq (vector-ref ,$vec1 i) (vector-ref ,$vec2 i)))
              (loop (+ i 1))
              ,no)
            ,yes))
        ,no))))

(define-macro (py-eq-listX-listY list1 list2)
  `(py-EQUAL?-listX-listY ,list1 ,list2 py-True py-False))

(define-macro (py-ne-listX-listY list1 list2)
  `(py-EQUAL?-listX-listY ,list1 ,list2 py-False py-True))

(define-macro (py-CMP?-listX-listY list1 list2 py-op tiebreak)
  (let (($list1 (gensym 'list))
        ($list2 (gensym 'list))
        ($len1 (gensym 'len))
        ($len2 (gensym 'len))
        ($min-len (gensym 'len))
        ($vec1 (gensym 'vec))
        ($vec2 (gensym 'vec)))
    `(let* ((,$list1 ,list1)
           (,$list2 ,list2)
           (,$len1 (PyObjectList-len ,$list1))
           (,$len2 (PyObjectList-len ,$list2))
           (,$min-len (min ,$len1 ,$len2))
           (,$vec1 (PyObjectList-vector ,$list1))
           (,$vec2 (PyObjectList-vector ,$list2)))
      (let loop ((i 0))
        (if (< i ,$min-len)
          (let ((el1 (vector-ref ,$vec1 i))
                (el2 (vector-ref ,$vec2 i)))
            (if (py-test (,py-op el1 el2))
              py-True
              (if (py-test (py-eq el1 el2))
                (loop (fx+ i 1))
                py-False)))
          (if (,tiebreak ,$len1 ,$len2) py-True py-False))))))

(define-macro (py-lt-listX-listY list1 list2)
  `(py-CMP?-listX-listY ,list1 ,list2 py-lt <))

(define-macro (py-le-listX-listY list1 list2)
  `(py-CMP?-listX-listY ,list1 ,list2 py-lt <=))

(define-macro (py-gt-listX-listY list1 list2)
  `(py-CMP?-listX-listY ,list1 ,list2 py-gt >))

(define-macro (py-ge-listX-listY list1 list2)
  `(py-CMP?-listX-listY ,list1 ,list2 py-gt >=))

(define-macro (stop-list-iterator iterator raise)
  `(begin
    (PyObjectListIterator-index-set! ,iterator #f)
    ,(if raise `(py-throw py-builtin-StopIteration) #f)))

(define-macro (list-iterator-next self raise)
  (let (($self (gensym 'self)))
    `(let* ((,$self ,self)
            (index (PyObjectListIterator-index ,$self)))
      (if index
        (let* ((lst (PyObjectListIterator-list ,$self))
               (vec (PyObjectList-vector lst))
               (len (PyObjectList-len lst)))
          (if (< index len)
            (let ((item (vector-ref vec index)))
              (PyObjectListIterator-index-set! ,$self (+ index 1))
              item)
            (stop-list-iterator ,$self ,raise)))
          (stop-list-iterator ,$self ,raise)))))

;; operations on tuples

(define-macro (tuple-iterator-next self raise)
  (let (($self (gensym 'self)))
    `(let* ((,$self ,self)
            (index (PyObjectTupleIterator-index ,$self))
                   (vec (PyObjectTupleIterator-vec ,$self)))
              (if (< index (vector-length vec))
                (let ((item (vector-ref vec index)))
                  (begin
                    (PyObjectTupleIterator-index-set! ,$self (+ index 1))
                    item))
                ,(if raise
                   `(py-throw py-builtin-StopIteration)
                   #f)))))

;; operations on generators

;; PyObjectGenerator-continuation can be three things:
;; 1) a procedure which represent the continuation
;; 2) #t meaning the generator is active, but already runnning
;; 3) #f meaning the generator is closed

(define-macro (py-generator-yield gen val kont)
  (let (($gen (gensym 'gen)))
    `(let ((,$gen ,gen))
      (PyObjectGenerator-continuation-set! ,$gen ,kont)
      ,val)))

(define-macro (py-generator-next self . rest)
  `(let* (($self ,self)
         ($value ,(case (length rest)
                   ((0) 'py-None)
                   ((1) (car rest))
                   (else (error "py-generator-next" "takes at most 2 arguments not " (length rest)))))
         (cont (PyObjectGenerator-continuation $self)))
    (cond
      ((procedure? cont) ;; active and ready
        (PyObjectGenerator-continuation-set! $self #t)
        (cont $value #f))
      (cont ;; active, but running (can be something else than #t, by example '%avoid-StopIteration)
        (py-throw-exception-with-message
          py-builtin-ValueError
          "generator is already executing"))
      (else ;; closed
        (py-throw py-builtin-StopIteration)))))

(define-macro (py-generator-next-avoid-StopIteration self)
  `(let* (($self ,self)
         (cont (PyObjectGenerator-continuation $self)))
    (cond
      ((procedure? cont) ;; active and ready
        (PyObjectGenerator-continuation-set! $self '%avoid-StopIteration)
        (cont py-None #f))
      (cont ;; active, but running (can be something else than #t, by example '%avoid-StopIteration)
        (py-throw-exception-with-message
          py-builtin-ValueError
          "generator is already executing"))
      (else ;; closed
        (py-throw py-builtin-StopIteration)))))

(define-macro (py-generator-end gen)
  `(PyObjectGenerator-continuation-set! ,gen #f))

;; all zipi PyObjectType have reserved slots for the following magic methods
;; see: ;; https://docs.python.org/3/reference/datamodel.html
(define-macro (with-list-of-magic-attrs . args)
  (let ((list-of-magic-attrs
          '("__add__" "__radd__" "__iadd__"
            "__sub__" "__rsub__" "__isub__"
            "__mul__" "__rmul__" "__imul__"
            "__matmul__" "__rmatmul__" "__imatmul__"
            "__truediv__" "__rtruediv__" "__itruediv__"
            "__floordiv__" "__rfloordiv__" "__ifloordiv__"
            "__mod__" "__rmod__" "__imod__"
            "__divmod__" "__rdivmod__"
            "__pow__" "__rpow__" "__ipow__"
            "__lshift__" "__rlshift__" "__ilshift__"
            "__rshift__" "__rrshift__" "__irshift__"
            "__and__" "__rand__" "__iand__"
            "__xor__" "__rxor__" "__ixor__"
            "__or__" "__ror__" "__ior__"
            "__neg__" "__pos__" "__abs__" "__invert__"
            "__complex__" "__int__" "__float__" "__index__" "__bool__"
            "__repr__" "__str__" "__bytes__" "__format__"
            "__round__" "__trunc__" "__floor__" "__ceil__"
            "__eq__" "__ne__" "__lt__" "__le__" "__gt__" "__ge__"
            "__call__"
            "__get__" "__set__" "__delete__"
            "__getattribute__" "__getattr__" "__setattr__"
            "__getitem__" "__setitem__" "__delitem__" "__missing__"
            "__iter__" "__next__" "__reversed__" "__contains__"
            "__len__" "__length_hint__"
            "__hash__" "__dir__"
            "__new__" "__init__")))
    ;; add info as first arg to allow rest arguments
    `(,(car args) ,list-of-magic-attrs ,@(cdr args))))

(define-macro (fill-representatives-magic-index)
  `(with-list-of-magic-attrs $fill-representatives-magic-index))

(define-macro ($fill-representatives-magic-index list-of-magic-attrs)
  `(begin
    ,@(let loop ((list-of-magic-attrs list-of-magic-attrs) (i 0))
      (if (null? list-of-magic-attrs)
        '()
        (cons
          `(PyObjectStrRep-magic-index-set!
            (& ,(car list-of-magic-attrs))
            ,i)
          (loop (cdr list-of-magic-attrs) (+ i 1)))))))

(define-macro (get-list-of-magic-attrs)
  `(with-list-of-magic-attrs $get-list-of-magic-attrs))

(define-macro ($get-list-of-magic-attrs the-list)
  `(quote ,the-list))

(define-macro (py-getattribute-from-obj-mro-2cont obj name succeed fail)
  `(with-list-of-magic-attrs $py-getattribute-from-obj-mro-2cont ,obj ,name ,succeed ,fail))

(define-macro ($py-getattribute-from-obj-mro-2cont list-of-magic-attrs obj name succeed fail)
  (define (not-a-magic-attribute)
    `(getattribute-from-cls-mro-with-owner-2cont
      (py-obj-cls ,obj)
      ,name
      (lambda ($val $owner) (,succeed $val))
      ,fail))

  (if (and (pair? name)
           (memq (car name) '(& &&)))
    (let* ((name-string (cadr name))
           (x (member name-string list-of-magic-attrs)))
      (if x
        ;; magic attribute, we know its index
        (let ((magic-index (- (length list-of-magic-attrs) (length x))))
          `(get-magic-attribute-from-cls-mro-with-owner-2cont
            (py-obj-cls ,obj)
            ,magic-index
            (lambda ($val $owner) (,succeed $val))
            ,fail))
        ;; not a magic attributs
        (not-a-magic-attribute)))
      (not-a-magic-attribute)))

(define-macro (getattribute-from-obj-mro obj name)
  `(py-getattribute-from-obj-mro-2cont
    ,obj
    ,name
    (lambda ($value) $value)
    (lambda () py-absent)))

(define-macro (getattribute-from-cls-mro-with-owner-2cont cls name succeed fail)
  `(let* (($mro (PyObjectType-mro ,cls))
         ($succeed ,succeed)
         ($mro-length (vector-length $mro)))
     (let $loop-mro (($cls-index 0))
       (if (fx< $cls-index $mro-length)
           (let (($cls (vector-ref $mro $cls-index)))
           (py-own-attr-ref-2cont
            $cls
            ,name
            (lambda ($val)
              ($succeed $val $cls))
            (lambda ()
              ($loop-mro (fx+ $cls-index 1)))))
               (,fail)))))

(define-macro (get-magic-attribute-from-cls-mro-with-owner-2cont cls magic-index succeed fail)
  `(let* (($mro (PyObjectType-mro ,cls))
         ($magic-index ,magic-index)
         ($succeed ,succeed)
         ($mro-length (vector-length $mro)))
    (let $loop-mro (($cls-index 0))
      (if (fx< $cls-index $mro-length)
           (let* (($cls (vector-ref $mro $cls-index))
              ($attr (magic-attr-ref $cls $magic-index)))
          (if $attr
            (,succeed $attr $cls)
            ($loop-mro (fx+ $cls-index 1))))
       (,fail)))))

(define-macro (getattribute-from-cls-mro-with-index/owner-2cont cls name succeed fail)
 `(let (($mro (PyObjectType-mro ,cls)))
    (let $loop-mro (($cls-index 0))
      (if (fx< $cls-index (vector-length $mro))
           (let (($cls (vector-ref $mro $cls-index)))
          (py-own-attr-index/ref-2cont
           $cls
           ,name
           (lambda ($index $val)
             (,succeed $index $val $cls))
           (lambda ()
             ($loop-mro (fx+ $cls-index 1)))))
               (,fail)))))

(define-macro (getattribute-from-cls-mro cls name)
  `(getattribute-from-cls-mro-with-owner-2cont
    ,cls
    ,name
    (lambda (val owner) val)
    (lambda () py-absent)))

(define-macro (py-cls-own-attr-ref-2cont cls attr succeed fail)
  `(let* (($cls ,cls)
          ($attr ,attr)
;*           ($succeed ,succeed)                                       */
;*           ($fail ,fail)                                             */
          ($attr-representative (py-str-representative $attr))
          ($magic-index (PyObjectStrRep-magic-index $attr-representative)))
    (if $magic-index
      (let (($val
            (magic-attr-ref
              $obj
              $magic-index)))
        (if $val (,succeed $val) (,fail)))
      (py-own-attr-index-2cont-from-representative
        $obj
        $attr-representative
        (lambda ($attr-index)
          (,succeed (PyObject-elements-ref $obj $attr-index)))
        ,fail))))

(define-macro (py-cls-own-attr-index/ref-2cont cls attr succeed fail)
  `(let* (($cls ,cls)
          ($attr ,attr)
;*           ($succeed ,succeed)                                       */
;*           ($fail ,fail)                                             */
          ($attr-representative (py-str-representative $attr))
          ($magic-index (PyObjectStrRep-magic-index $attr-representative)))
    (if $magic-index
      (let (($val
            (magic-attr-ref
              $obj
              $magic-index)))
        (if $val (,succeed -1 $val) (,fail)))
      (py-own-attr-index-2cont-from-representative
        $obj
        $attr-representative
        (lambda ($attr-index)
          (,succeed $attr-index (PyObject-elements-ref $obj $attr-index)))
        ,fail))))

(define-macro (py-own-attr-ref-2cont obj attr succeed fail)
  ;; TODO: fix case when obj is not represented with a PyObject
  `(let* (($obj ,obj)
          ($attr ,attr)
;*           ($succeed ,succeed)                                       */
;*           ($fail ,fail)                                             */
	  )
      (if (PyObjectType? $obj)
        (py-cls-own-attr-ref-2cont $obj $attr ,succeed ,fail)
        (py-own-attr-index-2cont
         $obj
         $attr
         (lambda ($attr-index) (,succeed (PyObject-elements-ref $obj $attr-index)))
         ,fail))))

(define-macro (py-own-attr-index/ref-2cont obj attr succeed fail)
 ;; TODO: fix case when obj is not represented with a PyObject
 `(let* (($obj ,obj)
         ($attr ,attr)
;*          ($succeed ,succeed)                                        */
;*          ($fail ,fail))                                             */
	 )
     (if (PyObjectType? $obj)
       (py-cls-own-attr-index/ref-2cont $obj $attr ,succeed ,fail)
       (py-own-attr-index-2cont
        $obj
        $attr
        (lambda ($attr-index) (,succeed $attr-index (PyObject-elements-ref $obj $attr-index)))
        ,fail))))

(define-macro (magic-attr-set! cls attr-index val)
 `(vector-set! (PyObjectType-magic-attrs ,cls) ,attr-index ,val))

(define-macro (magic-attr-ref cls attr-index)
 `(vector-ref (PyObjectType-magic-attrs ,cls) ,attr-index))

(define-macro (py-own-attr-index-2cont-from-representative obj rep succeed fail)
 `(let* (($hclass (py-obj-hclass ,obj))
         ($names (HClass-names $hclass))
         ($attr-representative ,rep))
    (let $loop-names (($attr-index (fx- (vector-length $names) 1)))
      (cond ((fx< $attr-index 0)
             (,fail))
            ((eq? $attr-representative (vector-ref $names $attr-index))
             (,succeed $attr-index))
            (else
             ($loop-names (fx- $attr-index 1)))))))

(define-macro (py-own-attr-index-2cont obj attr succeed fail)
 `(py-own-attr-index-2cont-from-representative
   ,obj
   (py-str-representative ,attr)
   ,succeed
   ,fail))

(define-macro (getattribute-from-obj-mro-with-owner-2cont obj name succeed fail)
 `(getattribute-from-cls-mro-with-owner-2cont (py-obj-cls ,obj) ,name ,succeed ,fail))

(define-macro (getattribute-from-obj-mro-with-index/owner-2cont obj name succeed fail)
`(getattribute-from-cls-mro-with-index/owner-2cont (py-obj-cls ,obj) ,name ,succeed ,fail))

;* (define-expander py-throw                                           */
;*    (lambda (x e)                                                    */
;*       (match-case x                                                 */
;* 	 ((?- ?exc)                                                    */
;* 	  (e `(begin                                                   */
;* 		 (tprint "throwing..." ',(if (epair? x) (cer x) '???)) */
;* 		 ((@ py-throw __py_rts) ,exc))                         */
;* 	     e)))))                                                    */

;; object.__getattribute__ error message
(define-macro (py-throw-object-getattribute-error obj name)
  `(py-throw
    (py-call
      py-builtin-AttributeError
      (py-add*
        (&& "'")
        (py-getattribute (py-obj-cls ,obj) (& "__name__"))
        (&& "' object has no attribute '")
        ,name
        (&& "'")))))

;; type.__getattribute__ error message
(define-macro (py-throw-type-getattribute-error obj name)
  `(py-throw
    (py-call
      py-builtin-AttributeError
      (py-add*
        (&& "type object '")
        (py-getattribute ,obj (& "__name__"))
        (&& "' has no attribute '")
        ,name
        (&& "'")))))

;; module.__getattribute__ error message
(define-macro (py-throw-module-getattribute-error obj name)
  `(py-throw
    (py-call
      py-builtin-AttributeError
      (py-add*
        (&& "module '")
        (py-getattribute ,obj (& "__name__"))
        (&& "' has no attribute '")
        ,name
        (&& "'")))))

;; global contains a vector #(getter setter [maybe value for inner use])
(define-macro (global-cell-getter-get cell)
  `(vector-ref ,cell 0))

(define-macro (global-cell-getter-set! cell getter)
  `(vector-set! ,cell 0 ,getter))

(define-macro (global-cell-get-val cell)
  `((global-cell-getter-get ,cell)))

(define-macro (global-cell-setter-get cell)
  `(vector-ref ,cell 1))

(define-macro (global-cell-setter-set! cell setter)
  `(vector-set! ,cell 1 ,setter))

(define-macro (global-cell-set-val! cell val)
  `((global-cell-setter-get ,cell) ,val))

(define-macro (PyObject-global-elements-ref global offset)
  `(global-cell-get-val (vector-ref (PyObject-%elements ,global) ,offset)))

(define-macro (py-global-elements-set! elements offset val)
  `(global-cell-set-val! (vector-ref ,elements ,offset) ,val))

(define-macro (make-global-cell val)
  `(let* (($cell (vector #f #f ,val))
         ($getter (lambda () (vector-ref $cell 2)))
         ($setter (lambda (val) (vector-set! $cell 2 val))))
    (global-cell-getter-set! $cell $getter)
    (global-cell-setter-set! $cell $setter)
    $cell))

;; behavior dispatch

(define-macro (with-class-indices-info . args)
  (let ((info
            ;; WARNING: type must be ordered by class-index

            ;; name   class-index  has-arithmetic-behavior   can-have-getter
          '((default        0               #t                   #t) ;; reserved spot for default semantics
            (sint           1               #t                   #f)
            (bint           2               #t                   #f)
            (bool           3               #t                   #f)
            (float          4               #t                   #f)
            (str            5               #t                   #f)
            ;; extra indices with no arithmetic optimisations (NOTE: must be at tail of the list)
            (object         6               #f                   #f)
            (type           7               #f                   #f)
            (function       8               #f                   #t)
            (generator      9               #f                   #f)
            (tuple          10              #f                   #f)
            (tuple_iterator 11              #f                   #f)
            (list           12              #f                   #f)
            (list_iterator  13              #f                   #f)
            (range          14              #f                   #f)
            (range_iterator 15              #f                   #f)
            (slice          16              #f                   #f))))

    ;; add info as first arg due to rest arguments in py-make-builtin-class
    `(,(car args) ,info ,@(cdr args))))

(define-macro (get-behavior-type-index name)
  `(with-class-indices-info $get-behavior-type-index ,name))

(define-macro ($get-behavior-type-index indices-info name)
  (cadr (assq name indices-info)))

(define-macro (py-make-builtin-class name module bases . attrs)
  (define hclass-of-instances
    '((object . py-object-hclass-of-instances)
      (type . #f) ;; NOTE: this is ok! each type should have a different hclass for attribute caching purpose
                  ;; for this reasons there is no "py-type-hclass-of-instances"
      (str . py-str-hclass-of-instances)
      (tuple . py-tuple-hclass-of-instances)
      (int . py-int-hclass-of-instances)
      (bool . py-bool-hclass-of-instances)
      (float . py-float-hclass-of-instances)
      (slice . py-slice-hclass-of-instances)
      (bytearray . py-bytearray-hclass-of-instances)
      (method . py-method-hclass-of-instances)
      (staticmethod . py-staticmethod-hclass-of-instances)
      (classmethod . py-classmethod-hclass-of-instances)
      (function . py-function-hclass-of-instances)
      (generator . py-generator-hclass-of-instances)
      (list . py-list-hclass-of-instances)
      (dict . py-dict-hclass-of-instances)
      (set . py-set-hclass-of-instances)
      (module . py-module-hclass-of-instances)
      (list_iterator . py-list-iterator-hclass-of-instances)
      (bytearray_iterator . py-bytearray-iterator-hclass-of-instances)
      (tuple_iterator . py-tuple-iterator-hclass-of-instances)
      (dict_keyiterator . py-dict-keyiterator-hclass-of-instances)
      (dict_valueiterator . py-dict-valueiterator-hclass-of-instances)
      (TextIOWrapper . py-TextIOWrapper-hclass-of-instances)
      (super . py-super-hclass-of-instances)
      (range . py-range-hclass-of-instances)
      (range_iterator . py-range_iterator-hclass-of-instances)))

  (define pre-bootstrap-classes
    '((object . py-object-class)
      (type . py-type-class)
      (str . py-str-class)
      (tuple . py-tuple-class)
      (int . py-int-class)
      (bool . py-bool-class)
      (float . py-float-class)
      (function . py-function-class)))

  (let* ((scheme-name
          (if (and (pair? name) (memq (car name) '(& &&)))
            (string->symbol (cadr name))
            (error "py-make-builtin-class" "name must be a Python string literal" name)))
        (pre-bootstrap-class
          (let ((pair (assq scheme-name pre-bootstrap-classes))) (if pair (cdr pair) #f)))
        (hclass-of-instances
          (let ((pair (assq scheme-name hclass-of-instances)))
            (if pair
              (cdr pair)
              `(make-HClass '#() '())))))

  (if pre-bootstrap-class
    `(py-extend-builtin-core-class
        ,pre-bootstrap-class
        ,@attrs)
    `(with-class-indices-info
      $py-make-builtin-class-with-class-info
      ,name
      ,module
      ,bases
      ,hclass-of-instances
      ,@attrs))))

(define-macro ($py-make-builtin-class-with-class-info indices-info name module bases hclass-of-instances . attrs)
  (define (get-class-info-by-name name-symbol)
    (let ((class-info
            (if (eq? name-symbol 'int)
              (assq 'bint indices-info)
              (or (assq name-symbol indices-info) (assq 'default indices-info)))))
      (list
        (cadr class-info) ;; class-index
        (caddr class-info)))) ;; can-have-getter

  (if (and (pair? name) (memq (car name) '(& &&)))
    (let* ((name-value (cadr name))
           (class-info (get-class-info-by-name (string->symbol name-value))))
      `(py-make-builtin-class-with-class-info ,@class-info ,name ,module ,bases ,hclass-of-instances ,@attrs))
    (error "py-make-builtin-class" "name argument must be a static PyObjectStr" name)))

(define-macro (define-semantics-body func type-extrapolation-table default-behavior vector calculate-index calculate-index-macro . args)
  `(with-class-indices-info $define-semantics-body ,func ,type-extrapolation-table ,default-behavior ,vector ,calculate-index ,calculate-index-macro ,@args))

(define-macro ($calculate-behavior-table-index indices-info $obj $item . args)
  (define (type-index type) (cadr (assq type indices-info)))

  (let ((indices-info-length (length indices-info)))
    `(fx+
      ;; here we dont use directly py-obj-class-index because we can calculate
      ;; at compile time the multiplication in some cases
      (cond
       ((fixnum? ,$obj) ,(* (type-index 'sint) indices-info-length))
       ((flonum? ,$obj) ,(* (type-index 'float) indices-info-length))
       (else (fx* ,indices-info-length (py-obj-class-index-general ,$obj))))
      (py-obj-class-index ,$item))))

(define-macro ($calculate-behavior-table-index-flipped indices-info $obj $item . args)
  `($calculate-behavior-table-index ,indices-info ,$item ,$obj ,@args))

(define-macro ($define-semantics-body indices-info func type-extrapolation-table default-behavior behavior-vector flipped-indices . args)
  (define (calculate-index indices-info-length obj-index item-index)
    (+ (* obj-index indices-info-length) item-index))

  (define (calculate-index-flipped indices-info-length obj-index item-index)
    (+ (* item-index indices-info-length) obj-index))

  (define (type-index type) (cadr (assq type indices-info)))

  (define (list-until lst obj)
    (if (or (not (pair? lst)) (eq? obj (car lst)))
        '()
        (cons (car lst) (list-until (cdr lst) obj))))

  (define post-fix-indices '#("X" "Y" "Z"))

  (define (generate-func-name func type-args indices-count #!optional (indice 0))
    (if (eqv? indices-count indice)
        (string->symbol func)
        (let* ((sym-name (if (pair? type-args)
                             (symbol->string (car type-args))
                             ""))
               (post-fix-index (vector-ref post-fix-indices indice)))
          (generate-func-name
           (string-append
            func
            "-"
            sym-name
            post-fix-index)
           (if (pair? type-args) (cdr type-args)
               type-args)
           indices-count
           (+ 1 indice)))))

  (let* (($index (gensym 'index))
         (types (memq types: args))
         (type-args (if types (cadr types) default-behavior))
         (behavior-args (list-until args types:))
         (sym-behavior-args (map (lambda (n)
                                   (gensym 'behavior-arg))
                                 (iota (length behavior-args))))

         (indices-info-length (length indices-info))
         ;; This should always return a type combination for which a behavior exists
         (expected-types
          (let ((pair (assoc type-args type-extrapolation-table)))
            (if pair (cdr pair) default-behavior)))
         (expected-index-args (map type-index expected-types))
         (expected-index (apply (if flipped-indices calculate-index-flipped calculate-index) indices-info-length expected-index-args))
         (inline-behavior
          (generate-func-name
           (symbol->string func)
           expected-types
           (length behavior-args))))

    `(let* (,@(map (lambda (sym behavior) `(,sym ,behavior)) sym-behavior-args behavior-args)
            (,$index (,(if flipped-indices
                           '$calculate-behavior-table-index-flipped
                           '$calculate-behavior-table-index)
                      ,indices-info
                      ,@sym-behavior-args)))
       (if (fx= ,$index ,expected-index)
           (,inline-behavior ,@sym-behavior-args)
           ((vector-ref
             ,behavior-vector
             ,$index)
            ,@sym-behavior-args)))))

(define-macro (init-behavior-dispatch-vector)
 `(begin
   (with-class-indices-info $init-arithmetic-behavior-dispatch-vector)
   (with-class-indices-info $init-iteration-behavior-dispatch-vector)

   (define-behavior-dispatch-vector
     py-getitem-behavior-table
     (;; table of function <-> type
      (py-getitem-listX-sintY-fallback   list  sint)
      (py-getitem-listX-sliceY-fallback  list  slice)
      (py-getitem-listX-boolY-fallback   list  bool)

      (py-getitem-tupleX-sintY-fallback  tuple sint)
      (py-getitem-tupleX-sliceY-fallback tuple slice )
      (py-getitem-tupleX-boolY-fallback  tuple bool)

      (py-getitem-strX-sintY-fallback    str   sint)
      (py-getitem-strX-sliceY-fallback   str   slice)
      (py-getitem-strX-boolY-fallback    str   bool)
      )
     py-getitem-fallback
     #t)

   (define-behavior-dispatch-vector
     py-setitem-behavior-table
     (;; table of function <-> type
      (py-setitem-listX-sintY-Z-fallback   list  sint)
      )
     py-setitem-fallback
     #t)))

(define-macro (define-behavior-dispatch-vector name type-definition default-fallback calculate-index)
  `(with-class-indices-info $define-behavior-dispatch-vector ,name ,type-definition ,default-fallback ,calculate-index))

;; defines a behavior-dispatch-vector according to the size of the type-definition. You should need only 2
(define-macro ($define-behavior-dispatch-vector indices-info name type-definition default-fallback flip-index)
  (define (type-index type)
    (cadr (assq type indices-info)))

  (define (calculate-index indices-info-length obj-index item-index)
    (+ (* obj-index indices-info-length) item-index))

  (define (calculate-index-flipped indices-info-length obj-index item-index)
    (+ (* item-index indices-info-length) obj-index))

  (define (add-case func . args)
    `(vector-set! ,name
                  ,(apply
                    (if flip-index calculate-index-flipped calculate-index)
                    (length indices-info) (map type-index args))
                  ,func))
  `(begin
     (define-rts ,name
       (make-vector ,(expt (length indices-info) (- (length (car type-definition)) 1)) ,default-fallback))

     ,@(map (lambda (x) (apply add-case x)) type-definition)))


(define-macro ($init-arithmetic-behavior-dispatch-vector indices-info)
  (define types-with-specialized-behaviors
    (let loop ((info indices-info))
      (cond
        ((null? info) '())
        ((caddar info) ;; has-specialized-behavior
          (cons (caar info) (loop (cdr info))))
        (else (loop (cdr info))))))

  (define behavior-table-size (+ 1 (apply max (map cadr indices-info)))) ;; one by behavior + default

  ;; those are the tail behaviors which have no arithmetic behavior, but have a class index and so must have a slot in the vector
  (define behavior-table-default-tail-size (- behavior-table-size (length types-with-specialized-behaviors)))

  (define inplace-ops
    '(iadd ibitand ibitor ifloordiv ilshift imatmul imod imul ipow irshift isub itruediv ixor))

  (define cmp-ops
    '(eq ne ge gt le lt))

  (define test-cmp-ops
    '(test-eq test-ne test-ge test-gt test-le test-lt))

  (define binary-ops-with-behaviors
    (append
      '(add bitand bitor floordiv lshift matmul mod mul pow rshift sub truediv xor)
      inplace-ops
      cmp-ops
      test-cmp-ops))

  (define unary-ops-with-behaviors
    '(pos neg invert))

  (define unary-truthiness-ops-with-behaviors
    '(test truth))

  (define (test-op->cmp-op op)
    (case op
      ((test-eq) 'eq)
      ((test-ne) 'ne)
      ((test-ge) 'ge)
      ((test-gt) 'gt)
      ((test-le) 'le)
      ((test-lt) 'lt)))

  (define (get-behaviors-table-name op)
    (string->symbol (string-append "py-" (symbol->string op) "-behaviors-table")))

  (define (use-default-binary-semantics? op lhs-type rhs-type)
    (cond
      ((or (eq? lhs-type 'default)
           (eq? rhs-type 'default)
           (not (memq lhs-type types-with-specialized-behaviors))
           (not (memq rhs-type types-with-specialized-behaviors)))
        #t)
      ((and (memq op '(mod imod))
            (eq? lhs-type 'str))
        #t)
      (else
        #f)))

  (define (get-binary-behavior-name op lhs-type rhs-type)
    (if (use-default-binary-semantics? op lhs-type rhs-type)
      ;; use the full semantics
      (cond
        ((memq op inplace-ops)
          (string->symbol
            (string-append "py-" (symbol->string op) "-fallback:inplace")))
        ((memq op test-cmp-ops)
          ;; call comparison semantics followed by bool semantics
          `(lambda (x y)
            (py-test
              (,(string->symbol (string-append "py-" (symbol->string (test-op->cmp-op op)) "-fallback"))
                x y))))
        (else
          (string->symbol
            (string-append "py-" (symbol->string op) "-fallback:normal"))))
      ;; use a behavior
      (string->symbol
        (string-append
          "py-"
          (symbol->string op)
          "-"
          (symbol->string lhs-type)
          "X-"
          (symbol->string rhs-type)
          "Y-fallback"))))

  (define (get-unary-behavior-name op type)
    (if (or (eq? type 'default) (not (memq type types-with-specialized-behaviors)))
      ;; use the full semantics
      (string->symbol
          (string-append "py-" (symbol->string op) "-fallback:normal"))
      ;; use a behavior
      (string->symbol
        (string-append
          "py-"
          (symbol->string op)
          "-"
          (symbol->string type)
          "X-fallback"))))

  (define (get-unary-truthiness-behavior-name op type)
    (if (or (eq? type 'default) (not (memq type types-with-specialized-behaviors)))
      ;; use the full semantics
      (string->symbol
          (string-append "py-" (symbol->string op) "-fallback"))
      ;; use a behavior
      (string->symbol
        (string-append
          "py-"
          (symbol->string op)
          "-"
          (symbol->string type)
          "X-fallback"))))

  (define (make-binary-behaviors-list op)
    (let lhs-loop ((lhs-types indices-info))
      (if (null? lhs-types)
        '()
        (let rhs-loop ((rhs-types indices-info))
          (if (null? rhs-types)
            (lhs-loop (cdr lhs-types))
            (cons
              (get-binary-behavior-name op (caar lhs-types) (caar rhs-types))
              (rhs-loop (cdr rhs-types))))))))

  (define (make-unary-behaviors-list op)
    (let loop ((types indices-info))
      (if (null? types)
        '()
        (cons
          (get-unary-behavior-name op (caar types))
          (loop (cdr types))))))

  (define (make-unary-truthiness-behaviors-list op)
    (let loop ((types indices-info))
      (if (null? types)
        '()
        (cons
          (get-unary-truthiness-behavior-name op (caar types))
          (loop (cdr types))))))

  (define (get-behavior-call-fallback-name op)
    (string->symbol
      (string-append "py-" (symbol->string op) "-behavior-call-fallback")))

  (define (get-behavior-call-with-lhs-index-fallback-name op)
    (string->symbol
      (string-append "py-" (symbol->string op) "-behavior-call-with-lhs-index-fallback")))

  (define (get-behavior-call-with-rhs-index-fallback-name op)
    (string->symbol
      (string-append "py-" (symbol->string op) "-behavior-call-with-rhs-index-fallback")))

  (define (get-binary-behavior-call-fallback op)
    `(define-rts (,(get-behavior-call-fallback-name op) lhs rhs)
        ($py-binary-behavior-call ,op lhs rhs)))

  (define (get-behavior-call-with-lhs-index-fallback op)
    `(define-rts (,(get-behavior-call-with-lhs-index-fallback-name op) lhs-index lhs rhs)
        ($py-binary-behavior-call-with-lhs-index ,op lhs-index lhs rhs)))

  (define (get-behavior-call-with-rhs-index-fallback op)
    `(define-rts (,(get-behavior-call-with-rhs-index-fallback-name op) lhs rhs-index rhs)
        ($py-binary-behavior-call-with-rhs-index ,op lhs rhs-index rhs)))

  (define (get-unary-behavior-call-fallback op)
    `(define-rts (,(get-behavior-call-fallback-name op) x)
        ($py-unary-behavior-call ,op x)))

  (define (make-init-table-code ops behaviors-list-maker)
    (if (null? ops)
      '()
      (let* ((op (car ops))
            (behaviors-table-name (get-behaviors-table-name op))
            (behaviors (behaviors-list-maker op)))
        (cons
          `(define-rts ,behaviors-table-name (vector ,@behaviors))
          (make-init-table-code (cdr ops) behaviors-list-maker)))))

  (let ((tables-init-code
          (append
            (make-init-table-code binary-ops-with-behaviors make-binary-behaviors-list)
            (make-init-table-code unary-ops-with-behaviors make-unary-behaviors-list)
            (make-init-table-code unary-truthiness-ops-with-behaviors make-unary-truthiness-behaviors-list)))
        (behavior-call-fallbacks
          (append
            (let loop ((ops binary-ops-with-behaviors))
              (if (null? ops)
                '()
                (let* ((op (car ops))
                      (binary-behavior-call-fallback (get-binary-behavior-call-fallback op))
                      (behavior-call-with-lhs-index-fallback (get-behavior-call-with-lhs-index-fallback op))
                      (behavior-call-with-rhs-index-fallback (get-behavior-call-with-rhs-index-fallback op)))
                  (cons
                    binary-behavior-call-fallback
                    (cons
                      behavior-call-with-lhs-index-fallback
                      (cons
                        behavior-call-with-rhs-index-fallback
                        (loop (cdr ops))))))))
            (let loop ((ops (append unary-ops-with-behaviors unary-truthiness-ops-with-behaviors)))
              (if (null? ops)
                '()
                (let* ((op (car ops))
                      (unary-behavior-call-fallback (get-unary-behavior-call-fallback op)))
                  (cons
                    unary-behavior-call-fallback
                    (loop (cdr ops)))))))))
    `(begin
        ,@tables-init-code
        ,@behavior-call-fallbacks)))


(define-macro ($init-iteration-behavior-dispatch-vector indices-info)
  (define behavior-tables-size (+ 1 (apply max (map cadr indices-info))))

  `(begin
    (define-rts py-next-behaviors-table
      (make-vector ,behavior-tables-size py-next-fallback))

    (vector-set!
      py-next-behaviors-table
      (get-behavior-type-index list_iterator)
      (lambda (it)
        (list-iterator-next it #f)))

    (vector-set!
      py-next-behaviors-table
      (get-behavior-type-index tuple_iterator)
      (lambda (it)
        (tuple-iterator-next it #f)))

    (vector-set!
      py-next-behaviors-table
      (get-behavior-type-index range_iterator)
      (lambda (it)
        (let ((start (py-int-to-scheme (PyObjectRangeIterator-start it)))
              (stop (py-int-to-scheme (PyObjectRangeIterator-stop it)))
              (step (py-int-to-scheme (PyObjectRangeIterator-step it))))
          (if (or (and (> step 0) (< start stop))
                  (and (< step 0) (> start stop)))
            (begin
              (PyObjectRangeIterator-start-set! it (py-int-from-scheme (+ start step)))
              start)
            #f))))

    (vector-set!
      py-next-behaviors-table
      (get-behavior-type-index generator)
      (lambda (gen)
        (py-try-except
          (lambda (e)
            (if (py-isinstance? e py-builtin-StopIteration)
              #f
              (py-throw-unsafe e)))
          (lambda () (py-generator-next gen)))))))

(define-macro (py-for-each-listX iterable body)
  (let (($iterable (gensym 'iterable)))
    `(let ((,$iterable ,iterable))
       (let loop ((i 0))
         (if (fx< i (PyObjectList-len ,$iterable))
             (begin
               (,body (vector-ref (PyObjectList-vector ,$iterable) i))
               (loop (fx+ i 1))))))))

(define-macro (py-for-each-tupleX iterable body)
  (let (($iterable (gensym 'iterable))
        ($vec (gensym 'vector))
        ($len (gensym 'len)))
    `(let* ((,$iterable ,iterable)
            (,$vec (PyObjectTuple-value ,$iterable))
            (,$len (vector-length ,$vec)))
       (let loop ((i 0))
         (if (fx< i ,$len)
             (begin
               (,body (vector-ref ,$vec i))
               (loop (fx+ i 1))))))))
(define-macro (get-behavior-index lhs-index rhs-index)
   `(with-class-indices-info $get-behavior-index ,lhs-index ,rhs-index))

(define-macro ($get-behavior-index indices-info lhs-index rhs-index)
  (define indices (map cadr indices-info))

  (define indices-length (length indices))

  (cond-expand
    (gambit
      `(|##fx+| (|##fx*| ,indices-length ,lhs-index) ,rhs-index))
    (bigloo
      `(+fx (*fx ,indices-length ,lhs-index) ,rhs-index))))

(define-macro (py-binary-behavior-ref op lhs-index rhs-index)
  (let ((behavior-table-name
          (string->symbol (string-append "py-" (symbol->string op) "-behaviors-table"))))
    `(vector-ref ,behavior-table-name (get-behavior-index ,lhs-index ,rhs-index))))

(define-macro (py-unary-behavior-ref op index)
  (let ((behavior-table-name
          (string->symbol (string-append "py-" (symbol->string op) "-behaviors-table"))))
    `(vector-ref ,behavior-table-name ,index)))

(define-macro (py-binary-behavior-call op lhs rhs)
  (let ((behavior-call-fallback-name
          (string->symbol
            (string-append "py-" (symbol->string op) "-behavior-call-fallback"))))
    `(py-if-enable-inline-behavior-dispatch
        ($py-binary-behavior-call ,op ,lhs ,rhs)
        (,behavior-call-fallback-name ,lhs ,rhs))))

(define-macro ($py-binary-behavior-call op lhs rhs)
  `(let (($lhs ,lhs)
         ($rhs ,rhs))
      ((py-binary-behavior-ref
        ,op
        (py-obj-class-index $lhs)
        (py-obj-class-index $rhs))
        $lhs
        $rhs)))

(define-macro (py-unary-behavior-call op lhs)
  (let ((behavior-call-fallback-name
          (string->symbol
            (string-append "py-" (symbol->string op) "-behavior-call-fallback"))))
    `(py-if-enable-inline-behavior-dispatch
        ($py-unary-behavior-call ,op ,lhs)
        (,behavior-call-fallback-name ,lhs))))

(define-macro ($py-unary-behavior-call op lhs)
  `(let (($lhs ,lhs))
      ((py-unary-behavior-ref
        ,op
        (py-obj-class-index $lhs))
        $lhs)))

(define-macro (py-binary-behavior-call-with-lhs-index op lhs-index lhs rhs)
  (let ((behavior-call-fallback-name
          (string->symbol
            (string-append "py-" (symbol->string op) "-behavior-call-with-lhs-index-fallback"))))
    `(py-if-enable-inline-partial-behavior-dispatch
        ($py-binary-behavior-call-with-lhs-index ,op ,lhs-index ,lhs ,rhs)
        (,behavior-call-fallback-name ,lhs-index ,lhs ,rhs))))

(define-macro ($py-binary-behavior-call-with-lhs-index op lhs-index lhs rhs)
  `(let (($rhs ,rhs))
      ((py-binary-behavior-ref
        ,op
        ,lhs-index
        (py-obj-class-index $rhs))
        ,lhs
        $rhs)))

(define-macro (py-binary-behavior-call-with-rhs-index op lhs rhs-index rhs)
  (let ((behavior-call-fallback-name
          (string->symbol
            (string-append "py-" (symbol->string op) "-behavior-call-with-rhs-index-fallback"))))
    `(py-if-enable-inline-partial-behavior-dispatch
        ($py-binary-behavior-call-with-rhs-index ,op ,lhs ,rhs-index ,rhs)
        (,behavior-call-fallback-name ,lhs ,rhs-index ,rhs))))

(define-macro ($py-binary-behavior-call-with-rhs-index op lhs rhs-index rhs)
  `(let (($lhs ,lhs))
      ((py-binary-behavior-ref
        ,op
        (py-obj-class-index $lhs)
        ,rhs-index)
        $lhs
        ,rhs)))

;; Semantics

(define-macro (py-specialized-binop-dispatch op lhs rhs)
  `(with-class-indices-info $py-specialized-binop-dispatch ,op ,lhs ,rhs))

(define-macro ($py-specialized-binop-dispatch indices-info op lhs rhs)

  (define sint-sint-op (string->symbol (string-append "py-" (symbol->string op) "-sintX-sintY-inline")))
  (define float-float-op (string->symbol (string-append "py-" (symbol->string op) "-floatX-floatY-inline")))
  (define sint-float-op (string->symbol (string-append "py-" (symbol->string op) "-sintX-floatY-inline")))
  (define float-sint-op (string->symbol (string-append "py-" (symbol->string op) "-floatX-sintY-inline")))

  (define sint-class-index (cadr (assq 'sint indices-info)))
  (define float-class-index (cadr (assq 'float indices-info)))

  `(py-if-enable-behaviors-optimization
    (let (($lhs ,lhs)
          ($rhs ,rhs))
      (cond ((py-if-specialized-sint-representation (fixnum? $lhs) #f)
             (py-if-enable-inlined-mixed-types-behaviors
              (cond
               ((py-if-specialized-sint-representation (fixnum? $rhs) #f)
                (,sint-sint-op $lhs $rhs))
               ((py-if-specialized-float-representation (flonum? $rhs) #f)
                (,sint-float-op $lhs $rhs))
               (else
                (py-binary-behavior-call-with-lhs-index ,op ,sint-class-index $lhs $rhs)))
              (if (py-if-specialized-sint-representation (fixnum? $rhs) #f)
                  (,sint-sint-op $lhs $rhs)
                  (py-binary-behavior-call-with-lhs-index ,op ,sint-class-index $lhs $rhs))))
            ((py-if-specialized-float-representation (flonum? $lhs) #f)
             (py-if-enable-inlined-mixed-types-behaviors
              (cond
               ((py-if-specialized-sint-representation (fixnum? $rhs) #f)
                (,float-sint-op $lhs $rhs))
               ((flonum? $rhs)
                (,float-float-op $lhs $rhs))
               (else
                (py-binary-behavior-call-with-lhs-index ,op ,float-class-index $lhs $rhs)))
              (if (flonum? $rhs)
                  (,float-float-op $lhs $rhs)
                  (py-binary-behavior-call-with-lhs-index ,op ,float-class-index $lhs $rhs))))
            (else
             (py-binary-behavior-call ,op $lhs $rhs))))
    (,(string->symbol (string-append "py-" (symbol->string op) "-fallback")) ,lhs ,rhs)))

(define-macro (py-specialized-unop-dispatch op x)
  `(with-class-indices-info $py-specialized-unop-dispatch ,op ,x))

(define-macro ($py-specialized-unop-dispatch indices-info op x)

  (define sint-op (string->symbol (string-append "py-" (symbol->string op) "-sintX-inline")))
  (define float-op (string->symbol (string-append "py-" (symbol->string op) "-floatX-inline")))

  `(py-if-enable-behaviors-optimization
    (let (($x ,x))
      (cond ((py-if-specialized-sint-representation (fixnum? $x) #f)
             (,sint-op $x))
            ((py-if-specialized-float-representation (flonum? $x) #f)
             (,float-op $x))
            (else
             (py-unary-behavior-call ,op $x))))
    (,(string->symbol (string-append "py-" (symbol->string op) "-fallback")) ,x)))

(define-macro (py-add x y)
  (if (and (pair? x) (memq (car x) '(& &&)) (pair? y) (memq (car y) '(& &&)))
    `(&& ,(string-append (cadr x) (cadr y)))
    `(py-specialized-binop-dispatch add ,x ,y)))

(define-macro (py-add* . args)
  (case (length args)
    ((0 1)
      (error "py-add*" "requires at least 2 argument and got" (length args)))
    ((2)
      `(py-add ,@args))
    (else
      `(py-add ,(car args) (py-add* ,@(cdr args))))))

(define-macro (py-bitand x y)
  `(py-specialized-binop-dispatch bitand ,x ,y))

(define-macro (py-bitor x y)
  `(py-specialized-binop-dispatch bitor ,x ,y))

(define-macro (py-floordiv x y)
  `(py-specialized-binop-dispatch floordiv ,x ,y))

(define-macro (py-lshift x y)
  `(py-specialized-binop-dispatch lshift ,x ,y))

(define-macro (py-matmul x y)
  `(py-specialized-binop-dispatch matmul ,x ,y))

(define-macro (py-mod x y)
  `(py-specialized-binop-dispatch mod ,x ,y))

(define-macro (py-mul x y)
  (define (str-literal? o)
    (if (and (pair? o) (memq (car o) '(& &&)))
      (cadr o)
      #f))

  (define (int-literal? o)
    (if (and (pair? o) (eq? (car o) 'py-int-from-scheme))
      (cadr o)
      #f))

  (define (str-mul? s count)
    (if (< (* (string-length s) count) 1000) ;; Put some limit on the result size at compile-time
      (fold string-append "" (make-list count s))
      #f))

  (define (str-mul-literal? lhs rhs)
    (let ((lhs-int (int-literal? lhs))
          (lhs-str (str-literal? lhs))
          (rhs-int (int-literal? rhs))
          (rhs-str (str-literal? rhs)))
    (cond
      ((and lhs-int rhs-str)
        `(&& ,(str-mul? rhs-str lhs-int)))
      ((and lhs-str rhs-int)
        `(&& ,(str-mul? lhs-str rhs-int)))
      (else
        #f))))

  (or (str-mul-literal? x y) `(py-specialized-binop-dispatch mul ,x ,y)))

(define-macro (py-pow x y)
  `(py-specialized-binop-dispatch pow ,x ,y))

(define-macro (py-rshift x y)
  `(py-specialized-binop-dispatch rshift ,x ,y))

(define-macro (py-sub x y)
  `(py-specialized-binop-dispatch sub ,x ,y))

(define-macro (py-truediv x y)
  `(py-specialized-binop-dispatch truediv ,x ,y))

(define-macro (py-xor x y)
  `(py-specialized-binop-dispatch xor ,x ,y))

(define-macro (py-iadd x y)
  `(py-specialized-binop-dispatch iadd ,x ,y))

(define-macro (py-ibitand x y)
  `(py-specialized-binop-dispatch ibitand ,x ,y))

(define-macro (py-ibitor x y)
  `(py-specialized-binop-dispatch ibitor ,x ,y))

(define-macro (py-ifloordiv x y)
  `(py-specialized-binop-dispatch ifloordiv ,x ,y))

(define-macro (py-ilshift x y)
  `(py-specialized-binop-dispatch ilshift ,x ,y))

(define-macro (py-imatmul x y)
  `(py-specialized-binop-dispatch imatmul ,x ,y))

(define-macro (py-imod x y)
  `(py-specialized-binop-dispatch imod ,x ,y))

(define-macro (py-imul x y)
  `(py-specialized-binop-dispatch imul ,x ,y))

(define-macro (py-ipow x y)
  `(py-specialized-binop-dispatch ipow ,x ,y))

(define-macro (py-irshift x y)
  `(py-specialized-binop-dispatch irshift ,x ,y))

(define-macro (py-isub x y)
  `(py-specialized-binop-dispatch isub ,x ,y))

(define-macro (py-itruediv x y)
  `(py-specialized-binop-dispatch itruediv ,x ,y))

(define-macro (py-ixor x y)
  `(py-specialized-binop-dispatch ixor ,x ,y))

(define-macro (py-pos x)
  `(py-specialized-unop-dispatch pos ,x))

(define-macro (py-neg x)
  `(py-specialized-unop-dispatch neg ,x))

(define-macro (py-invert x)
  `(py-specialized-unop-dispatch invert ,x))

(define-macro (py-ge x y)
  `(py-specialized-binop-dispatch ge ,x ,y))

(define-macro (py-gt x y)
  `(py-specialized-binop-dispatch gt ,x ,y))

(define-macro (py-le x y)
  `(py-specialized-binop-dispatch le ,x ,y))

(define-macro (py-lt x y)
  `(py-specialized-binop-dispatch lt ,x ,y))

(define-macro (py-eq x y)
  `(py-specialized-binop-dispatch eq ,x ,y))

(define-macro (py-ne x y)
  `(py-specialized-binop-dispatch ne ,x ,y))

(define-macro (py-not obj)
  `(if (py-test ,obj) py-False py-True))

(define-macro (py-is x y) ;; x is y
  `(if (py-test-is ,x ,y) py-True py-False))

(define-macro (py-isnot x y) ;; x is not y
  `(if (py-test-isnot ,x ,y) py-True py-False))

(define-macro (py-test-ge x y)
  `(py-specialized-binop-dispatch test-ge ,x ,y))

(define-macro (py-test-gt x y)
  `(py-specialized-binop-dispatch test-gt ,x ,y))

(define-macro (py-test-le x y)
  `(py-specialized-binop-dispatch test-le ,x ,y))

(define-macro (py-test-lt x y)
  `(py-specialized-binop-dispatch test-lt ,x ,y))

(define-macro (py-test-eq x y)
  `(py-specialized-binop-dispatch test-eq ,x ,y))

(define-macro (py-test-ne x y)
  `(py-specialized-binop-dispatch test-ne ,x ,y))

(define-macro (py-test-is x y)
  `(eq? ,x ,y))

(define-macro (py-test-isnot x y)
  `(not (py-test-is ,x ,y)))

(define-macro (py-test x . params)

  (define cmp-operator-test-version
    '((py-eq py-test-eq)
      (py-ne py-test-ne)
      (py-ge py-test-ge)
      (py-gt py-test-gt)
      (py-le py-test-le)
      (py-lt py-test-lt)
      (py-is py-test-is)
      (py-isnot py-test-isnot)))

  (let* ((type (memq type: params))
         (obj-type (and type (cadr type))))
      (if (pair? x)
          (let ((test-version (assq (car x) cmp-operator-test-version)))
            (cond
              (test-version
                `(,(cadr test-version) ,@(cdr x)))
              ((eq? (car x) 'py-bool-from-scheme-bool)
                (cadr x))
              (else
                `($py-test ,x ,obj-type))))
          `($py-test ,x ,obj-type))))

(define-macro ($py-test obj obj-type)
  (let (($obj (gensym 'obj))
        ($obj-index (gensym 'obj-index)))
    (case (or obj-type 'bool)
      ((bool)
        `(let ((,$obj ,obj))
          (or (eq? ,$obj py-True)
              (and
                (not (eq? ,$obj py-False))
                (py-specialized-unop-dispatch test ,$obj)))))
      ((str)
        `(let* ((,$obj ,obj)
               (,$obj-index (py-obj-class-index ,$obj)))
          (if (fx= ,$obj-index (get-behavior-type-index str))
            (py-test-strX-inline ,$obj)
            ((py-unary-behavior-ref
              test
              ,$obj-index)
              ,$obj))))
      (else
        `(py-specialized-unop-dispatch test ,obj)))))

(define-macro (py-truth obj)
  `(py-specialized-unop-dispatch truth ,obj))

(define-macro (py-trunc obj)
  `(py-trunc-fallback ,obj))

(define-macro (py-maybe-trunc obj)
  `(py-maybe-trunc-fallback ,obj))

(define-macro (py-to-int obj)
  `(py-to-int-fallback ,obj))

(define-macro (py-maybe-to-int obj)
  `(py-maybe-to-int-fallback ,obj))

(define-macro (py-to-float obj)
  `(py-to-float-fallback ,obj))

(define-macro (py-maybe-to-float obj)
  `(py-maybe-to-float-fallback ,obj))

(define-macro (py-index obj)
  `(py-index-fallback ,obj))

(define-macro (py-maybe-index obj)
  `(py-maybe-index-fallback ,obj))

(define-macro (py-big-index obj)
  `(py-big-index-fallback ,obj))

(define-macro (py-maybe-big-index obj)
  `(py-maybe-big-index-fallback ,obj))

(define-macro (py-length obj)
  `(py-length-fallback ,obj))

(define-macro (py-maybe-length obj)
  `(py-maybe-length-fallback ,obj))

(define-macro (py-getattribute obj attr . opts)
  (let ((cache (if (null? opts) #f (car opts)))
        (inlines (if (or (null? opts) (null? (cdr opts))) '() (cadr opts))))
  (if cache
    `(py-getattribute-cached ,obj ,attr ,cache ,inlines)
    `(py-getattribute-fallback ,obj ,attr))))

(define-macro (py-getattribute-cached obj attr cache inline-priorities)
  ;; attr should always be a string literal
  `(py-specialized-sint-float-dispatch-let
     $OBJ
     ,obj
     ;; TODO: use macro to determine exact attribute in case of
     ;; int and float, those can be determined statically
     (py-getattribute-fallback $OBJ ,attr)
     (py-getattribute-fallback $OBJ ,attr)
     ,(let loop ((inlines inline-priorities))
       (if (null? inlines)
         `(py-getattribute-cached-modular-fallback
            $OBJ (py-obj-hclass-general $OBJ) ,attr ,cache
            ,(not (not (memq 'object inline-priorities)))
            ,(not (not (memq 'mro inline-priorities)))
            ,(not (not (memq 'type inline-priorities)))
            ,(not (not (memq 'module inline-priorities))))
         `(let (($cache ,cache)
                ($hclass (py-obj-hclass-general $OBJ)))
             ,(case (car inlines)
                ((object)
                  `(if (eq? $hclass (AttributeCache-object-hclass $cache))
                       (py-getattribute-from-object-cache $OBJ $cache)
                       ,(loop (cdr inlines))))
                ((mro)
                  `(if (eq? $hclass (AttributeCache-mro-hclass $cache))
                       (py-getattribute-from-mro-cache $OBJ $cache)
                       ,(loop (cdr inlines))))
                ((type)
                  `(if (eq? $hclass (AttributeCache-type-hclass $cache))
                       (py-getattribute-from-type-cache $OBJ $cache)
                       ,(loop (cdr inlines))))
                ((module)
                  `(if (eq? $hclass (AttributeCache-module-hclass $cache))
                       (py-getattribute-from-module-cache $OBJ $cache)
                       ,(loop (cdr inlines))))
                (else (error "py-getattribute-cached" "unknown inlining priority" (car inlines)))))))))

(define-macro (py-getattribute-and-call0-maybe-super-cached obj attr cls instance cache inline-priorities)
   (define (gen-py-callX expr)
      `(if (eq? ,expr py-builtin-super)
	   ,(if (and cls instance)
		`(py-call py-builtin-super ,cls ,instance)
		`(py-throw-super-no-arguments-error))
	   (py-callX ,0 ,expr)))
   ;; attr should always be a string literal
   `(py-specialized-sint-float-dispatch-let
       $OBJ
       ,obj
       ;; TODO: use macro to determine exact attribute in case of
       ;; int and float, those can be determined statically
       ,(gen-py-callX `(py-getattribute-fallback $OBJ ,attr))
       ,(gen-py-callX `(py-getattribute-fallback $OBJ ,attr))
       ,(let loop ((inlines inline-priorities))
	   (if (null? inlines)
	       (gen-py-callX
		  `(py-getattribute-cached-modular-fallback
		      $OBJ (py-obj-hclass-general $OBJ) ,attr ,cache
		      ,(not (not (memq 'object inline-priorities)))
		      ,(not (not (memq 'mro inline-priorities)))
		      ,(not (not (memq 'type inline-priorities)))
		      ,(not (not (memq 'module inline-priorities)))))
	       `(let (($cache ,cache)
		      ($hclass (py-obj-hclass-general $OBJ)))
		   ,(case (car inlines)
		       ((object)
			`(if (eq? $hclass (AttributeCache-object-hclass $cache))
			     ,(gen-py-callX `(py-getattribute-from-object-cache $OBJ $cache))
			     ,(loop (cdr inlines))))
		       ((mro)
			`(if (eq? $hclass (AttributeCache-mro-hclass $cache))
			      (py-getattribute-and-call0-from-mro-maybe-super-cache $OBJ ,cls ,instance $cache)
			     ,(loop (cdr inlines))))
		       ((type)
			`(if (eq? $hclass (AttributeCache-type-hclass $cache))
			     (py-getattribute-and-call0-from-type-maybe-super-cache $OBJ ,cls ,instance $cache)
			     ,(loop (cdr inlines))))
		       ((module)
			`(if (eq? $hclass (AttributeCache-module-hclass $cache))
			     ,(gen-py-callX `(py-getattribute-from-module-cache $OBJ $cache))
			     ,(loop (cdr inlines))))
		       (else (error "py-getattribute-and-callX-cached" "unknown inlining priority" (car inlines)))))))))

(define-macro (py-getattribute-and-callX-cached obj attr X args cache inline-priorities)
   (define (gen-py-callX expr)
      `(py-callX ,X ,expr ,@args))
   ;; attr should always be a string literal
   `(py-specialized-sint-float-dispatch-let
       $OBJ
       ,obj
       ;; TODO: use macro to determine exact attribute in case of
       ;; int and float, those can be determined statically
       ,(gen-py-callX `(py-getattribute-fallback $OBJ ,attr))
       ,(gen-py-callX `(py-getattribute-fallback $OBJ ,attr))
       ,(let loop ((inlines inline-priorities))
	   (if (null? inlines)
	       (gen-py-callX
		  `(py-getattribute-cached-modular-fallback
		      $OBJ (py-obj-hclass-general $OBJ) ,attr ,cache
		      ,(not (not (memq 'object inline-priorities)))
		      ,(not (not (memq 'mro inline-priorities)))
		      ,(not (not (memq 'type inline-priorities)))
		      ,(not (not (memq 'module inline-priorities)))))
	       `(let (($cache ,cache)
		      ($hclass (py-obj-hclass-general $OBJ)))
		   ,(case (car inlines)
		       ((object)
			`(if (eq? $hclass (AttributeCache-object-hclass $cache))
			     ,(gen-py-callX `(py-getattribute-from-object-cache $OBJ $cache))
			     ,(loop (cdr inlines))))
		       ((mro)
			`(if (eq? $hclass (AttributeCache-mro-hclass $cache))
			      (py-getattribute-and-callX-from-mro-cache $OBJ ,X ,args $cache)
			     ,(loop (cdr inlines))))
		       ((type)
			`(if (eq? $hclass (AttributeCache-type-hclass $cache))
			     (py-getattribute-and-callX-from-type-cache $OBJ ,X ,args $cache)
			     ,(loop (cdr inlines))))
		       ((module)
			`(if (eq? $hclass (AttributeCache-module-hclass $cache))
			     ,(gen-py-callX `(py-getattribute-from-module-cache $OBJ $cache))
			     ,(loop (cdr inlines))))
		       (else (error "py-getattribute-and-callX-cached" "unknown inlining priority" (car inlines)))))))))


(define-macro (py-getattribute-from-module-cache obj cache)
  `(let* (($cache ,cache)
          ($obj ,obj)
          (index (AttributeCache-index $cache)))
    (if (fx= index -1)
      (py-getattribute-from-mro-cache $obj $cache)
      (or
        (PyObject-global-elements-ref $obj index)
        (py-getattribute-from-mro-cache $obj $cache)))))

(define-macro (py-getattribute-from-object-cache obj cache)
  `(let* (($cache ,cache)
         ($obj ,obj)
         (index (AttributeCache-index $cache)))
    (if (fx= index -1)
      (py-getattribute-from-mro-cache $obj $cache)
      (let ((attr (PyObject-elements-ref $obj index)))
        (if (eq? attr py-absent)
          (py-getattribute-from-mro-cache $obj $cache)
          attr)))))

(define-macro (py-getattribute-from-mro-cache obj cache)
  ;; obj should never be a sint or float, those case can be resolved statically
  `(let (($cache ,cache))
      (py-descriptor-get (AttributeCache-attr $cache) ,obj (AttributeCache-owner $cache))))

(define-macro (py-getattribute-and-callX-from-mro-cache obj X args cache)
  ;; obj should never be a sint or float, those case can be resolved statically
  `(let (($cache ,cache))
      (py-descriptor-get-and-callX (AttributeCache-attr $cache) ,obj (AttributeCache-owner $cache) ,X ,args)))

(define-macro (py-getattribute-and-call0-from-mro-maybe-super-cache obj cls instance cache)
  ;; obj should never be a sint or float, those case can be resolved statically
  `(let (($cache ,cache))
      (py-descriptor-get-and-call0-maybe-super (AttributeCache-attr $cache) ,obj (AttributeCache-owner $cache) ,cls ,instance)))

(define-macro (py-getattribute-from-type-cache obj cache)
  ;; obj should never be a sint or float, those are not types
  `(let (($obj ,obj)
         ($cache ,cache))
    (if (eq? (AttributeCache-bind $cache) 'self)
        (py-descriptor-get (AttributeCache-attr $cache) ,obj (AttributeCache-owner $cache))
        (py-descriptor-get (AttributeCache-attr $cache) py-None (AttributeCache-owner $cache)))))

(define-macro (py-getattribute-and-callX-from-type-cache obj X args cache)
  ;; obj should never be a sint or float, those are not types
  `(let (($obj ,obj)
         ($cache ,cache))
    (if (eq? (AttributeCache-bind $cache) 'self)
        (py-descriptor-get-and-callX (AttributeCache-attr $cache) ,obj (AttributeCache-owner $cache) ,X ,args)
        (py-callX ,X (py-descriptor-get (AttributeCache-attr $cache) py-None (AttributeCache-owner $cache)) ,@args))))

(define-macro (py-getattribute-and-call0-from-type-maybe-super-cache obj cls instance cache)
   ;; obj should never be a sint or float, those are not types
   `(let (($obj ,obj)
	  ($cache ,cache))
       (if (eq? (AttributeCache-bind $cache) 'self)
	   (py-descriptor-get-and-call0-maybe-super (AttributeCache-attr $cache) ,obj (AttributeCache-owner $cache) ,cls ,instance)
	   (let (($fn (py-descriptor-get (AttributeCache-attr $cache) py-None (AttributeCache-owner $cache))))
	      (if (eq? $fn py-builtin-super)
		  ,(if (and cls instance)
		       `(py-call py-builtin-super ,cls ,instance)
		       `(py-throw-super-no-arguments-error))
		  (py-callX 0 $fn))))))

(define-macro (py-setattribute obj attr val)
  `(py-setattribute-fallback ,obj ,attr ,val))


;; TODO : The case of having a step of 1 in the slice could be optimized with
;;        a vector-copy directly. This is curently pending and not used (need testing)
;;        See https://github.com/udem-dlteam/zipi/pull/518#discussion_r669576132
(define-macro (py-getitem-listX-sliceY-step1 lst slice)
  (let (($list (gensym 'list))
        ($len (gensym 'len))
        ($vec (gensym 'vec))
        ($indices (gensym 'indices))
        ($start (gensym 'start))
        ($stop (gensym 'stop))
        ($res-len (gensym 'len))
        ($res-vec (gensym 'vec)))
    `(let* ((,$list ,lst)
            (,$len (PyObjectList-len ,$list))
            (,$vec (PyObjectList-vector ,$list))
            (,$indices (py-slice-indices ,slice ,$len))
            (,$start (vector-ref ,$indices 0))
            (,$stop (vector-ref ,$indices 1))
            (,$res-len (- ,$stop ,$start)))
       (py-list-from-scheme (vector-copy ,$vec ,$start ,$stop) ,res-len))))

(define-macro (get-slice-length start stop step)
  `(max 0 (quotient (+ (- ,stop ,start) ,step (if (< ,step 0) 1 -1)) ,step)))

(define-macro (py-getitem-listX-sliceY lst slice)
  (let (($list (gensym 'list))
        ($len (gensym 'len))
        ($vec (gensym 'vec))
        ($indices (gensym 'indices))
        ($start (gensym 'start))
        ($stop (gensym 'stop))
        ($step (gensym 'step))
        ($quot (gensym 'diff))
        ($res-len (gensym 'res-len))
        ($res-vec (gensym 'vec)))
    `(let* ((,$list ,lst)
            (,$len (PyObjectList-len ,$list))
            (,$vec (PyObjectList-vector ,$list))
            (,$indices (py-slice-indices ,slice ,$len))
            (,$start (vector-ref ,$indices 0))
            (,$stop (vector-ref ,$indices 1))
            (,$step (vector-ref ,$indices 2))
            (,$res-len (get-slice-length ,$start ,$stop ,$step))
            (,$res-vec (make-vector (list-get-inner-len ,$res-len) #f)))
       (let loop ((source ,$start) (target 0))
         (if (< target ,$res-len)
             (begin
               (vector-set! ,$res-vec target (vector-ref ,$vec source))
               (loop (+ source ,$step) (+ target 1)))
             (py-list-from-scheme ,$res-vec ,$res-len))))))

(define-macro (py-getitem-listX-sintY lst item)
  (let (($lst (gensym 'list))
        ($len (gensym 'len))
        ($vec (gensym 'vec))
        ($i (gensym 'i)))
    `(let* ((,$lst ,lst)
            (,$len (PyObjectList-len ,$lst))
            (,$vec (PyObjectList-vector ,$lst))
            (,$i (py-sint-to-scheme ,item)))
       (if (fx>= ,$i 0)
           (if (fx< ,$i ,$len)
               (vector-ref ,$vec ,$i)
               (py-throw-index-out-of-range "list"))
           (if (fx>= ,$i (fx- 0 ,$len))
               (vector-ref ,$vec (fx+ ,$i ,$len))
               (py-throw-index-out-of-range "list"))))))

(define-macro (py-getitem-listX-boolY lst bool)
  (let (($lst (gensym 'lst))
        ($len (gensym 'len))
        ($vec (gensym 'vec))
        ($index (gensym 'index)))
    `(let* ((,$lst ,lst)
            (,$len (PyObjectList-len ,$lst))
            (,$vec (PyObjectList-vector ,$lst))
            (,$index (if (eq? ,bool py-True) 1 0)))
       (if (> ,$len ,$index)
           (vector-ref ,$vec ,$index)
           (py-throw-index-out-of-range "list")))))

(define-macro (py-getitem-strX-sintY str int)
  (let (($str (gensym 'str))
        ($len (gensym 'len))
        ($scheme-str (gensym 'scheme-str))
        ($i (gensym 'i)))
    `(let* ((,$str ,str)
            (,$len (PyObjectStr-len ,$str))
            (,$scheme-str (py-str-to-scheme ,$str))
            (,$i (py-sint-to-scheme ,int)))
       (if (fx>= ,$i 0)
           (if (fx< ,$i ,$len)
               (py-str-from-string
                1
                (make-string 1 (string-ref ,$scheme-str ,$i)))
               (py-throw-index-out-of-range "string"))
           (if (fx>= ,$i (fx- 0 ,$len))
               (py-str-from-string
                1
                (make-string 1 (string-ref ,$scheme-str (fx+ ,$i ,$len))))
               (py-throw-index-out-of-range "string"))))))

(define-macro (py-getitem-strX-boolY str bool)
  (let (($str (gensym 'str))
        ($len (gensym 'len))
        ($scheme-str (gensym 'scheme-str))
        ($index (gensym 'index)))

    `(let* ((,$str ,str)
            (,$len (PyObjectStr-len ,$str))
            (,$scheme-str (py-str-to-scheme ,$str))
            (,$index (if (eq? ,bool py-True) 1 0)))

       (if (> ,$len ,$index)
           (py-str-from-string 1
                               (make-string 1 (string-ref ,$scheme-str ,$index)))
           (py-throw-index-out-of-range "string")))))

(define-macro (py-getitem-strX-sliceY str slice)
  (let (($str (gensym 'str))
        ($len (gensym 'len))
        ($scheme-str (gensym 'scheme-str))
        ($indices (gensym 'indices))
        ($start (gensym 'start))
        ($stop (gensym 'stop))
        ($step (gensym 'step))
        ($res-len (gensym 'len))
        ($res-str (gensym 'res-str)))
    `(let* ((,$str ,str)
            (,$len (PyObjectStr-len ,$str))
            (,$scheme-str (py-str-to-scheme ,$str))
            (,$indices (py-slice-indices ,slice ,$len))
            (,$start (vector-ref ,$indices 0))
            (,$stop (vector-ref ,$indices 1))
            (,$step (vector-ref ,$indices 2))
            (,$res-len (get-slice-length ,$start ,$stop ,$step))
            (,$res-str (make-string ,$res-len #\0)))
       (let loop ((source ,$start) (target 0))
         (if (< target ,$res-len)
             (begin
               (string-set! ,$res-str target (string-ref ,$scheme-str source))
               (loop (+ source ,$step) (+ target 1)))
             (begin
               (py-str-from-string ,$res-len ,$res-str)))))))

(define-macro (py-getitem-tupleX-sliceY tuple slice)
  (let (($tuple (gensym 'tuple))
        ($len (gensym 'len))
        ($vec (gensym 'vec))
        ($indices (gensym 'indices))
        ($start (gensym 'start))
        ($stop (gensym 'stop))
        ($step (gensym 'step))
        ($res-len (gensym 'len))
        ($res-vec (gensym 'vec)))
  `(let* ((,$tuple ,tuple)
         (,$vec (PyObjectTuple-value ,$tuple))
         (,$len (vector-length ,$vec))
         (,$indices (py-slice-indices ,slice ,$len))
         (,$start (vector-ref ,$indices 0))
         (,$stop (vector-ref ,$indices 1))
         (,$step (vector-ref ,$indices 2))
         (,$res-len (get-slice-length ,$start ,$stop ,$step))
         (,$res-vec (make-vector ,$res-len #f)))
    (let loop ((source ,$start) (target 0))
      (if (< target ,$res-len)
        (begin
          (vector-set! ,$res-vec target (vector-ref ,$vec source))
          (loop (+ source ,$step) (+ target 1)))
        (py-tuple-from-scheme ,$res-vec))))))

(define-macro (py-getitem-tupleX-sintY tuple item)
  (let (($tuple (gensym 'tuple))
        ($len (gensym 'len))
        ($vec (gensym 'vec))
        ($i (gensym 'i)))
    `(let* ((,$tuple ,tuple)
            (,$vec (PyObjectTuple-value ,$tuple))
            (,$len (vector-length ,$vec))
            (,$i (py-sint-to-scheme ,item)))
       (if (fx>= ,$i 0)
           (if (fx< ,$i ,$len)
               (vector-ref ,$vec ,$i)
               (py-throw-index-out-of-range "tuple"))
           (if (fx>= ,$i (fx- 0 ,$len))
               (vector-ref ,$vec (fx+ ,$i ,$len))
               (py-throw-index-out-of-range "tuple"))))))

(define-macro (py-getitem-tupleX-boolY tuple bool)
  (let (($tuple (gensym 'tuple))
        ($len (gensym 'len))
        ($vec (gensym 'vec))
        ($index (gensym 'index)))

    `(let* ((,$tuple ,tuple)
            (,$vec (PyObjectTuple-value ,$tuple))
            (,$len (vector-length ,$vec))
            (,$index (if (eq? ,bool py-True) 1 0)))

       (if (> ,$len ,$index)
           (vector-ref ,$vec ,$index)
           (py-throw-index-out-of-range "tuple")))))



(define-macro (py-getitem obj item . args)
  `(define-semantics-body
    py-getitem

    (;; list-sint
      ((list sint) . (list sint))
      ((list #f)   . (list sint))
      ((#f sint)   . (list sint))
      ((#f #f)     . (list sint))
      ;; list-slice
      ((list slice) . (list slice))
      ((#f slice)   . (list slice))
      ;; list-bool
      ((list bool) . (list bool))
      ((#f bool) . (list bool))
      ;; tuple-sint
      ((tuple sint) . (tuple sint))
      ((tuple #f)   . (tuple sint))
      ;; tuple-slice
      ((tuple slice) . (tuple slice))
      ;; tuple-bool
      ((tuple bool) . (tuple bool))
      ;; str-sint
      ((str sint) . (str sint))
      ((str #f)   . (str sint))
      ;; str-slice
      ((str slice) . (str slice))
      ;; str-bool
      ((str bool) . (str bool)))
    (list sint)
    py-getitem-behavior-table
    #t
    ,obj
    ,item
    ,@args))


(define-macro (py-setitem-listX-sintY-Z lst item value)
  (let (($lst (gensym 'list))
        ($len (gensym 'len))
        ($vec (gensym 'vec))
        ($i (gensym 'i)))
    `(let* ((,$lst ,lst)
            (,$len (PyObjectList-len ,$lst))
            (,$vec (PyObjectList-vector ,$lst))
            (,$i (py-sint-to-scheme ,item)))
       (if (fx>= ,$i 0)
           (if (fx< ,$i ,$len)
               (vector-set! ,$vec ,$i ,value)
               (py-throw-assignment-index-out-of-range "list"))
           (if (fx>= ,$i (fx- 0 ,$len))
               (vector-set! ,$vec (fx+ ,$i ,$len) ,value)
               (py-throw-assignment-index-out-of-range "list"))))))

(define-macro (py-setitem obj item value . args)
  `(define-semantics-body
    py-setitem

    (;; list-sint
     ((list sint) . (list sint))
     ((list #f)   . (list sint))
     ((#f sint)     . (list sint))
     ((#f #f)     . (list sint))
     )
    (list sint)
    py-setitem-behavior-table
    #t

    ,obj
    ,item
    ,value
    ,@args))

(define-macro (py-delitem obj item)
  `(py-delitem-fallback ,obj ,item))

(define-macro (py-enter obj)
  `(py-enter-fallback ,obj))

(define-macro (py-exit obj exc)
  `(py-exit-fallback ,obj ,exc))

(define-macro (py-descriptor-get attr instance owner)
  `(let* (($attr ,attr)
         ($instance ,instance)
         ($owner ,owner)
         ($cls (py-obj-cls ,attr)))
    (cond
      ((not (PyObjectType-can-have-getter $cls))
        $attr) ;; this covers the case fixnum/flonum
      ((PyObjectFunction? $attr)
        (py-descriptor-get-functionX-Y-Z-inline $attr $instance $owner))
      (else
       (py-descriptor-get-fallback $attr $instance $owner)))))

(define-macro (py-descriptor-get-and-callX attr instance owner X args)
   `(let* (($attr ,attr)
	   ($instance ,instance)
	   ($owner ,owner)
	   ($cls (py-obj-cls ,attr)))
       (cond
	  ((not (PyObjectType-can-have-getter $cls))
	   (py-callX ,X $attr ,@args)) ;; this covers the case fixnum/flonum
	  ((PyObjectFunction? $attr)
	   (py-callMethodX ,X $attr $instance ,@args))
	  (else
	   (py-callX ,X (py-descriptor-get-fallback $attr $instance $owner) ,@args)))))

(define-macro (py-descriptor-get-and-call0-maybe-super attr instance owner cls inst)
   `(let* (($attr ,attr)
	   ($instance ,instance)
	   ($owner ,owner)
	   ($cls (py-obj-cls ,attr)))
       (cond
	  ((not (PyObjectType-can-have-getter $cls))
	   (py-callX ,0 $attr)) ;; this covers the case fixnum/flonum
	  ((PyObjectFunction? $attr)
	   (if (eq? $attr py-builtin-super)
	       ,(if (and cls inst)
		    `(py-call py-builtin-super ,cls ,inst)
		    `(py-throw-super-no-arguments-error))
	       (py-callMethodX 0 $attr $instance)))
	  (else
	   (py-callX 0 (py-descriptor-get-fallback $attr $instance $owner))))))

(define-macro (py-iter obj)
  `(py-iter-fallback ,obj))

(define-macro (py-next obj)
  (let* (($obj (gensym 'obj)))
    `(let* ((,$obj ,obj))
      ((vector-ref py-next-behaviors-table (py-obj-class-index ,$obj)) ,$obj))))

(define-macro (py-for-each-range-call $element iter-callee body . args)
  (let* (($iterator (gensym 'iterator))
         ($start (gensym 'start))
         ($stop (gensym 'stop))
         ($step (gensym 'step))
         ($iter-callee (gensym 'range???))
         ($init-loop (gensym 'init-loop))
         (args-names (map (lambda (a) (gensym 'arg)) args))
         (range-args
           (case (length args)
             ((1)
               `((,$start 0)
                 (,$stop ,(car args-names))
                 (,$step 1)))
             ((2)
               `((,$start ,(car args-names))
                 (,$stop ,(cadr args-names))
                 (,$step 1)))
             ((3)
               `((,$start ,(car args-names))
                 (,$stop ,(cadr args-names))
                 (,$step ,(caddr args-names))))
             (else
               #f))))
      (if range-args
        `(let* ((,$iter-callee ,iter-callee)
               ,@(map (lambda (a v) `(,a ,v)) args-names args)
               ,@range-args
               (,$init-loop
                 (lambda (,$element ,$iterator)
                   (let loop ((,$element ,$element))
                     (if ,$element
                       (begin ,body (loop (py-for-next ,$element ,$iterator))))))))
          (if (and (eq? ,$iter-callee py-builtin-range)
                   (fixnum? ,$start)
                   (fixnum? ,$stop)
                   (fixnum? ,$step)
                   (not (fx= ,$step 0))
                   (cond-expand
                     (gambit
                       (|##fx+?| ,$stop ,$step))
                     (bigloo
                       (fixnum? (+ ,$stop ,$step)))))
              (,$init-loop ,$start (cons ,$stop ,$step))
              (py-for-iter (py-call ,$iter-callee ,@args) ,$init-loop)))
        `(py-for-each ,$element (py-call ,iter-callee ,@args) body))))

(define-macro (py-for-each-cps element iterable body loop forelse)
  (let (($body (gensym 'for-body))
        ($forelse (gensym 'for-else))
        ($iterator (gensym 'iterator))
        ($index (gensym 'cls-index))
        ($behavior-next (gensym 'behavior-next)))
    `(let* ((,$iterator (py-iter ,iterable))
              (,$index (py-obj-class-index ,$iterator))
              (,$behavior-next (vector-ref py-next-behaviors-table ,$index)))
      (let ,loop ()
        (let ((,element (,$behavior-next ,$iterator)))
          (if ,element
            ,body
            ,forelse))))))

;; semantics which creates a (non-python) specialized iterator for for-loops
(define-macro (py-for-iter iterable init-loop)
  (let (($init-loop (gensym 'init-loop))
        ($iterable (gensym 'iterable))
        ($iterator (gensym 'iterator))
        ($cls-index (gensym 'cls-index))
        ($start (gensym 'start))
        ($stop (gensym 'stop))
        ($step (gensym 'step))
        ($vec (gensym 'vec))
        ($len (gensym 'len)))
    `(let* ((,$init-loop ,init-loop)
            (,$iterable ,iterable)
            (,$cls-index (py-obj-class-index ,$iterable)))
      (cond
        ((fx= ,$cls-index (get-behavior-type-index list))
          (let ((,$vec (PyObjectList-vector ,$iterable))
                (,$len (PyObjectList-len ,$iterable)))
            (,$init-loop
              (if (fx> ,$len 0) (vector-ref ,$vec 0) #f)
              (cons ,$iterable 1))))
        ((fx= ,$cls-index (get-behavior-type-index tuple))
          (let ((,$vec (PyObjectTuple-value ,$iterable)))
            (,$init-loop
              (if (fx> (vector-length ,$vec) 0) (vector-ref ,$vec 0) #f)
              ;; vector of length 2 = tuple
              (vector ,$vec 1))))
        ((fx= ,$cls-index (get-behavior-type-index range))
          (let ((,$start (PyObjectRange-start ,$iterable))
                (,$stop (PyObjectRange-stop ,$iterable))
                (,$step (PyObjectRange-step ,$iterable)))
            ;; NOTE: only range for-loop on fixnums are inlined
            (if (and (fixnum? ,$start)
                     (fixnum? ,$stop)
                     (fixnum? ,$step)
                     (not (fx= ,$step 0))
                    (cond-expand
                      (gambit
                        (|##fx+?| ,$stop ,$step))
                      (bigloo
                        (fixnum? (+ ,$stop ,$step)))))
                 (,$init-loop
                   (and (or (and (fx> ,$step 0) (fx< ,$start ,$stop))
                            (and (fx< ,$step 0) (fx> ,$start ,$stop)))
                        ,$start)
                   (cons ,$stop ,$step))
                   (let ((,$iterator (py-iter ,iterable)))
                     (,$init-loop (py-next ,$iterator) ,$iterator)))))
        ((fx= ,$cls-index (get-behavior-type-index generator))
          (,$init-loop
            (py-try-except
              (lambda (e)
                (if (py-isinstance? e py-builtin-StopIteration)
                  #f
                  (py-throw-unsafe e)))
              (lambda () (py-generator-next-avoid-StopIteration ,$iterable)))
            ;; vector of length 3 = generator (the last slot serves no purpose)
            ,$iterable))
        (else
          (let ((,$iterator (py-iter ,iterable)))
            (,$init-loop (py-next ,$iterator) ,$iterator)))))))

;; semantics which gets next values from a (non-python) specialized iterator for for-loops
(define-macro (py-for-next last-element iterator)
  (let (($iterator (gensym 'iterator))
        ($element (gensym 'last-element))
        ($step (gensym 'step))
        ($lst-or-stop (gensym 'lst-or-stop))
        ($vec (gensym 'vec))
        ($index (gensym 'index))
        ($tmp (gensym 'tmp)))
    `(let ((,$iterator ,iterator)
           (,$element ,last-element))
      (cond
        ((pair? ,$iterator)
          (let ((,$lst-or-stop (car ,$iterator)))
            (if (fixnum? ,$lst-or-stop)
              ;; case range on fixnum
              (let* ((,$step (cdr ,$iterator))
                     (,$tmp (fx+ ,$element ,$step)))
                (and (or (and (fx> ,$step 0) (fx< ,$tmp ,$lst-or-stop))
                         (and (fx< ,$step 0) (fx> ,$tmp ,$lst-or-stop)))
                     ,$tmp))
              ;; case list
              (let ((,$index (cdr ,$iterator)))
                (if (fx< ,$index (PyObjectList-len ,$lst-or-stop))
                    (let ((,$tmp (vector-ref (PyObjectList-vector (car ,$iterator)) ,$index)))
                      (set-cdr! ,$iterator (fx+ ,$index 1))
                      ,$tmp)
                    #f)))))
        ((vector? ,$iterator)
          ;; case tuple
          (let ((,$vec (vector-ref ,$iterator 0))
                (,$index (vector-ref ,$iterator 1)))
            (if (fx< ,$index (vector-length ,$vec))
                (let ((,$tmp (vector-ref ,$vec ,$index)))
                  (vector-set! ,$iterator 1 (fx+ ,$index 1))
                  ,$tmp)
                #f)))
        ((PyObjectGenerator? ,$iterator)
          (py-try-except
            (lambda (e)
              (if (py-isinstance? e py-builtin-StopIteration)
                #f
                (py-throw-unsafe e)))
            (lambda ()
             (py-generator-next-avoid-StopIteration ,$iterator))))
        ;; case PyObject iterator
        (else
          (py-next ,$iterator))))))

(define-macro (py-for-each $element iterable body)
  (let (($iterator (gensym 'iterator)))
    `(py-for-iter
      ,iterable
      (lambda (,$element ,$iterator)
        (let loop ((,$element ,$element))
          (if ,$element
            (begin ,body (loop (py-for-next ,$element ,$iterator)))))))))
