(define (pyc-intrinsics this conf)
   (intrinsics this conf))

;; utilities

(define (list-remove lst x)
  (list-remove-pred lst (lambda (el) (eq? el x))))

(define (list-remove-pred lst pred?)
  (cond
    ((null? lst)
      '())
    ((pred? (car lst))
      (list-remove-pred (cdr lst) pred?))
    (else
      (cons (car lst) (list-remove-pred (cdr lst) pred?)))))

(define (list-find-PycVar-by-id lst id)
  (cond
    ((null? lst)
      #f)
    ((eq? (PycVar-id (car lst)) id)
      (car lst))
    (else
      (list-find-PycVar-by-id (cdr lst) id))))

(define (list-find-PycRef-by-id lst id)
  (cond
    ((null? lst)
      #f)
    ((and (isa? (car lst) PycRef)
          (eq? (PycVar-id (PycRef-decl (car lst))) id))
      (car lst))
    (else
      (list-find-PycRef-by-id (cdr lst) id))))

(define (list-find-PycRef-by-PycVar lst var)
  (cond
    ((null? lst)
      #f)
    ((and (isa? (car lst) PycRef)
          (eq? (PycRef-decl (car lst)) var))
      (car lst))
    (else
      (list-find-PycRef-by-PycVar (cdr lst) var))))

;; definitions for intrinsic calls/values
(define (make-inline_host_code this)
 (let* ((loc (PycNode-loc this))
       (args (PycCall-args this))
       (args-len (length args)))
   (if (and
         (= args-len 1)
         (PycString? (car args)))
     (new-PycPragma loc (call-with-input-string (PycLiteralValue-val (car args)) read))
     (error "SyntaxError" "wrong argument for inline_host_code" args))))

(define (make-semantics-scheme-name-from-fun-name name)
  (let ((id-with-dashes
          (string->symbol
            (list->string
              (map
                (lambda (c) (if (eq? c #\_) #\- c))
                (string->list (symbol->string name)))))))
    (symbol-append 'py- id-with-dashes '-fallback)))

(define (make-class_getattr this)
 (let* ((loc (PycNode-loc this))
       (args (PycCall-args this))
       (args-len (length args))
       (attr (cadr args)))
     (if (and
           (= args-len 2)
           (PycString? attr))
       (new-PycCall
         loc
         (new-PycPragma loc 'getattribute-from-obj-mro)
         args)
       (error "SyntaxError" "wrong argument for class_getattr" args))))

(define (make-call_host this)
 (let* ((loc (PycNode-loc this))
       (args (PycCall-args this))
       (args-len (length args))
       (attr (cadr args)))
     (if (and
           (>= args-len 1)
           (PycString? (car args)))
       (new-PycCall
         loc
         (new-PycPragma loc 'call-host)
         (cons
           (new-PycStatic
             loc
             'host-signature
             (PycLiteralValue-val (car args)))
           (cdr args)))
       (error "SyntaxError" "wrong argument for call_host" #f))))

(define (make-py-int-to-scheme this)
  (let* ((loc (PycNode-loc this))
        (args (PycCall-args this)))
    (if (not (= (length args) 1))
      (error "make-py-int-to-scheme" "incorrect arity for call to py-int-to-scheme" this))
    (let ((arg0 (car args)))
      (if (and
            (isa? arg0 PycNumber)
            (integer? (PycLiteralValue-val arg0)))
        (new-PycPragma
          loc
          (PycLiteralValue-val arg0)
          type: (if (fixnum? (PycLiteralValue-val arg0)) 'Usint 'Ubint))
        (new-PycCall
          loc
          (new-PycPragma loc 'py-int-to-scheme)
          args)))))

(define (make-py-sint-to-scheme this)
  (let* ((loc (PycNode-loc this))
        (args (PycCall-args this)))
    (if (not (= (length args) 1))
      (error "make-py-sint-to-scheme" "incorrect arity for call to py-sint-to-scheme" this))
    (let ((arg0 (car args)))
      (if (and (isa? arg0 PycLiteralValue))
        (if (fixnum? (PycLiteralValue-val arg0))
          (new-PycPragma
            loc
            (PycLiteralValue-val arg0)
            type: (if (fixnum? (PycLiteralValue-val arg0)) 'Usint 'Ubint))
          (error "make-py-sint-to-scheme" "called with non fixnum literal" this))
        (new-PycCall
          loc
          (new-PycPragma loc 'py-sint-to-scheme)
          args)))))

(define (make-py-float-to-scheme this)
  (let* ((loc (PycNode-loc this))
        (args (PycCall-args this)))
    (if (not (= (length args) 1))
      (error "make-py-float-to-scheme" "incorrect arity for call to py-float-to-scheme" this))
    (let ((arg0 (car args)))
      (if (and
            (isa? arg0 PycNumber)
            (flonum? (PycLiteralValue-val arg0)))
        (new-PycPragma
          loc
          (PycLiteralValue-val arg0)
          type: 'Ufloat)
        (new-PycCall
          loc
          (new-PycPragma loc 'py-float-to-scheme)
          args)))))

(define (make-alloc this)
  (define (get-kwarg-value name pairs)
    (if (pair? name)
      ;; keyword has a default value
      (let ((val (assq (car name) pairs)))
        (if val
          (cdr val)
          (cadr name)))
      (cdr
        (or
          (assq name pairs)
          (error "alloc()" "missing keyword" name)))))

  (define (do-alloc constructor attributes-names hclass-of-instances)
    (lambda (this args kwargs-pairs)
      (case (length args)
        ((0)
          (let* ((loc (PycNode-loc this))
                (attributes
                  (map
                    (lambda (a)
                      (let ((v (get-kwarg-value a kwargs-pairs)))
                        (if (isa? v PycNode)
                          v
                          (new-PycPragma loc v))))
                      attributes-names)))
            (new-PycCall
              loc
              (new-PycPragma loc constructor)
              (append
                (list
                  (new-PycPragma loc hclass-of-instances)
                  (new-PycPragma loc '(quote #())))
                attributes))))
        (else
          (error "alloc()" "takes one positional arguments" "")))))

  (define alloc-range
    (do-alloc 'make-PyObjectRange '((cls py-builtin-range) start stop step) 'py-range-hclass-of-instances))

  (define alloc-range-iterator
    (do-alloc 'make-PyObjectRangeIterator '((cls py-builtin-range_iterator) start stop step) 'py-range_iterator-hclass-of-instances))

  (define alloc-int
    (do-alloc 'make-PyObjectInt '((cls py-builtin-int) value) 'py-int-hclass-of-instances))

  (define alloc-float
    (do-alloc 'make-PyObjectFloat '((cls py-builtin-float) value) 'py-float-hclass-of-instances))

  (let* ((loc (PycNode-loc this))
        (args (PycCall-args this))
        (kw-names (PycCall-keywords-names this))
        (kw-values (PycCall-keywords-values this)))
    (if (not (null? args))
      (let* ((alloc-kind
              (cond
                ((isa? (car args) PycRef)
                  (PycVar-id (PycRef-decl (car args))))
                ((isa? (car args) PycRefUnresolved)
                  (PycRefUnresolved-id (car args)))
                (else
                  (error "alloc()" "first argument not recognized statically as builtin type" ""))))
            (maker
              (case alloc-kind
                ((range) alloc-range)
                ((range_iterator) alloc-range-iterator)
                ((int) alloc-int)
                ((float) alloc-float)
                (else (error "alloc()" "first argument cannot be allocated with alloc():" alloc-kind)))))
        (maker this (cdr args) (map cons kw-names kw-values)))
      (error "alloc()" "requires at least one argument object type to alloc" ""))))

(define (make-isinstance this)
  (let* ((loc (PycNode-loc this))
        (args (PycCall-args this))
        (args-len (length args)))
    (if (= args-len 2)
      (let ((arg1 (car args))
            (arg2 (cadr args)))
        (if (isa? arg2 PycRefUnresolved)
          (case (PycRefUnresolved-id arg2)
            ((sint)
              (new-PycCall
                loc
                (new-PycPragma loc 'py-has-type-sint?)
                (list arg1)
                type: 'Ubool))
            ((bint)
              (new-PycCall
                loc
                (new-PycPragma loc 'py-has-type-bint?)
                (list arg1)
                type: 'Ubool))
            (else
              (new-PycCall
                loc
                (new-PycPragma loc 'py-isinstance?)
                args
                type: 'Ubool)))
          (new-PycCall
            loc
            (new-PycPragma loc 'py-isinstance?)
            args
            type: 'Ubool)))
      (error "SyntaxError" "wrong argument for isinstance" args))))

(define (make-type this)
  (let* ((loc (PycNode-loc this))
        (args (PycCall-args this))
        (args-len (length args)))
    (if (= args-len 1)
      (new-PycCall
        loc
        (new-PycPragma loc 'py-obj-cls)
        args)
      (error "SyntaxError" "wrong argument for type" args))))


(define (make-pragma-call-maker name)
 (lambda (this)
   (let* ((loc (PycNode-loc this))
         (args (PycCall-args this)))
     (new-PycCall
       loc
       (new-PycPragma loc name)
       args))))

(define macro-intrinsics
 (list
   (cons 'inline_host_code make-inline_host_code)
   (cons 'class_getattr make-class_getattr)
   (cons 'call_host make-call_host)
   (cons 'alloc make-alloc)
   (cons 'py_float_to_host make-py-float-to-scheme)
   (cons 'py_float_from_host (make-pragma-call-maker 'py-float-from-scheme))
   (cons 'py_int_from_host (make-pragma-call-maker 'py-int-from-scheme))
   (cons 'py_int_to_host make-py-int-to-scheme)
   (cons 'py_bool_to_host_int (make-pragma-call-maker 'py-bool-to-scheme-int))
   (cons 'py_sint_to_host make-py-sint-to-scheme)
   (cons 'py_bint_to_host (make-pragma-call-maker 'py-bint-to-scheme))
   (cons 'py_bool_from_host_bool (make-pragma-call-maker 'py-bool-from-scheme-bool))
   (cons 'py_bool_to_host_bool (make-pragma-call-maker 'py-bool-to-scheme-bool))
   (cons 'py_str_to_host (make-pragma-call-maker 'py-str-to-scheme))
   (cons 'py_str_from_host (make-pragma-call-maker 'py-str-from-scheme))
   (cons 'py_str_len_to_host (make-pragma-call-maker 'py-str-len-to-scheme))
   ;; semantics
   (cons 'semantics_to_int (make-pragma-call-maker 'py-to-int))
   (cons 'semantics_maybe_to_int (make-pragma-call-maker 'py-maybe-to-int))
   (cons 'semantics_index (make-pragma-call-maker 'py-index))
   (cons 'semantics_maybe_index (make-pragma-call-maker 'py-maybe-index))
   (cons 'semantics_trunc (make-pragma-call-maker 'py-trunc))
   (cons 'semantics_maybe_trunc (make-pragma-call-maker 'py-maybe-trunc))))

(define static-intrinsics
 (list
   (cons 'absent 'py-absent)))

(define macro-static-builtins
  (list
    (cons 'isinstance make-isinstance)
    (cons 'type make-type)))

;; TODO: generate a full table of builtins with Zipi rts name
(define static-builtins
 '(
   ;; builtin callables
   (super . py-builtin-super)
   (type . py-builtin-type)
   (int . py-builtin-int)
   (bool . py-builtin-bool)
   (float . py-builtin-float)
   (str . py-builtin-str)
   (range . py-builtin-range)
   ;; builtin constants
   (NotImplemented . py-NotImplemented)
   ;; exceptions
   (ArithmeticError . py-builtin-ArithmeticError)
   (AssertionError . py-builtin-AssertionError)
   (AttributeError . py-builtin-AttributeError)
   (BaseException . py-builtin-BaseException)
   (BlockingIOError . py-builtin-BlockingIOError)
   (BrokenPipeError . py-builtin-BrokenPipeError)
   (BufferError . py-builtin-BufferError)
   (BytesWarning . py-builtin-BytesWarning)
   (ChildProcessError . py-builtin-ChildProcessError)
   (ConnectionAbortedError . py-builtin-ConnectionAbortedError)
   (ConnectionError . py-builtin-ConnectionError)
   (ConnectionRefusedError . py-builtin-ConnectionRefusedError)
   (ConnectionResetError . py-builtin-ConnectionResetError)
   (DeprecationWarning . py-builtin-DeprecationWarning)
   (EOFError . py-builtin-EOFError)
   (EnvironmentError . py-builtin-EnvironmentError)
   (Exception . py-builtin-Exception)
   (FileExistsError . py-builtin-FileExistsError)
   (FileNotFoundError . py-builtin-FileNotFoundError)
   (FloatingPointError . py-builtin-FloatingPointError)
   (FutureWarning . py-builtin-FutureWarning)
   (GeneratorExit . py-builtin-GeneratorExit)
   (IOError . py-builtin-IOError)
   (ImportError . py-builtin-ImportError)
   (ImportWarning . py-builtin-ImportWarning)
   (IndentationError . py-builtin-IndentationError)
   (IndexError . py-builtin-IndexError)
   (InterruptedError . py-builtin-InterruptedError)
   (IsADirectoryError . py-builtin-IsADirectoryError)
   (KeyError . py-builtin-KeyError)
   (KeyboardInterrupt . py-builtin-KeyboardInterrupt)
   (LookupError . py-builtin-LookupError)
   (MemoryError . py-builtin-MemoryError)
   (ModuleNotFoundError . py-builtin-ModuleNotFoundError)
   (NameError . py-builtin-NameError)
   (NotADirectoryError . py-builtin-NotADirectoryError)
   (NotImplementedError . py-builtin-NotImplementedError)
   (OSError . py-builtin-OSError)
   (OverflowError . py-builtin-OverflowError)
   (PendingDeprecationWarning . py-builtin-PendingDeprecationWarning)
   (PermissionError . py-builtin-PermissionError)
   (ProcessLookupError . py-builtin-ProcessLookupError)
   (RecursionError . py-builtin-RecursionError)
   (ReferenceError . py-builtin-ReferenceError)
   (ResourceWarning . py-builtin-ResourceWarning)
   (RuntimeError . py-builtin-RuntimeError)
   (RuntimeWarning . py-builtin-RuntimeWarning)
   (StopAsyncIteration . py-builtin-StopAsyncIteration)
   (StopIteration . py-builtin-StopIteration)
   (SyntaxError . py-builtin-SyntaxError)
   (SyntaxWarning . py-builtin-SyntaxWarning)
   (SystemError . py-builtin-SystemError)
   (SystemExit . py-builtin-SystemExit)
   (TabError . py-builtin-TabError)
   (TimeoutError . py-builtin-TimeoutError)
   (TypeError . py-builtin-TypeError)
   (UnboundLocalError . py-builtin-UnboundLocalError)
   (UnicodeDecodeError . py-builtin-UnicodeDecodeError)
   (UnicodeEncodeError . py-builtin-UnicodeEncodeError)
   (UnicodeError . py-builtin-UnicodeError)
   (UnicodeTranslateError . py-builtin-UnicodeTranslateError)
   (UnicodeWarning . py-builtin-UnicodeWarning)
   (UserWarning . py-builtin-UserWarning)
   (ValueError . py-builtin-ValueError)
   (Warning . py-builtin-Warning)
   (ZeroDivisionError . py-builtin-ZeroDivisionError)))

(define static-builtins-table
 (let ((table (make-hashtable)))
   (for-each
     (lambda (pair)
       (let ((key (car pair))
             (value (cdr pair)))
         (hashtable-put! table key value)))
     static-builtins)
     table))

(define valid-intrinsics
 (append
   (map car static-intrinsics)
   (map car macro-intrinsics)
   '(define_semantics
     define_behavior
     use_static_builtins
     use_simple_scoping absent
     builtin
     private)))

;; Detect intrinsics import
(define (intrinsics this conf)

  (define (collect-import-intrinsics nodes)
    (if (null? nodes)
      '()
      (cons
        (PycRef-decl (PycAssig-lhs (car nodes)))
        (collect-import-intrinsics (cdr nodes)))))

  (let ((fst-line-stmt
          (let loop ((stmts (PycModule-stmts this)))
            (if (null? stmts)
              #f
              (let* ((stmt (car stmts))
                     (loc (PycNode-loc stmt))
                     (lineno (car loc))
                     (col-offset (cadr loc)))
                (if (and (>= lineno 0) (>= col-offset 0))
                  stmt
                  (loop (cdr stmts))))))))
      (cond
        ((not fst-line-stmt) this)
        ((PycAssig? fst-line-stmt)
          (let ((val (PycAssig-rhs fst-line-stmt)))
            (if (and (PycImport? val)
                     (equal? (PycImport-path val) "__compiler_intrinsics__"))
              (error "SyntaxError" "cannot import __compiler_intrinsics__ as a module" #f)
              this)))
        ((PycBlock? fst-line-stmt)
          (let* ((decls (PycBlock-decls fst-line-stmt))
                (fst-decl (and (not (null? decls)) (car decls))))
            (if fst-decl
              (let ((val (PycAssig-rhs fst-decl)))
                (if (and (PycImport? val)
                         (equal? (PycImport-path val) "__compiler_intrinsics__"))
                  (let* ((nodes (PycSeq-nodes (PycBlock-body fst-line-stmt)))
                         (intrinsics (collect-import-intrinsics nodes)))
                    (PycModule-stmts-set!
                      this
                      (list-remove (PycModule-stmts this) fst-line-stmt))
                    (use-intrinsics! this intrinsics))
                  this))
              this)))
        (else this))))

;; apply intrinsics
(define (make-intrinsics-assoc-list intrinsics assoc-list)
  (if (null? intrinsics)
    '()
    (let* ((var (car intrinsics))
          (id (PycVar-id var))
          (pair (assoc id assoc-list)))
      (if pair
        (cons
          (cons var (cdr pair))
          (make-intrinsics-assoc-list (cdr intrinsics) assoc-list))
        (make-intrinsics-assoc-list (cdr intrinsics) assoc-list)))))

(define (use-intrinsics! this intrinsics)

  (define (check-invalid-intrinsics intrinsics)
    (cond
      ((null? intrinsics)
        #t)
      ((memq (PycVar-id (car intrinsics))
             valid-intrinsics)
        (check-invalid-intrinsics (cdr intrinsics)))
      (else
        (error "SyntaxError" "invalid __compiler_intrinsics__" (car intrinsics)))))

  (check-invalid-intrinsics intrinsics)
  (check-no-intrinsics-assignation this intrinsics)

  (let* ((statics-assoc-list (make-intrinsics-assoc-list intrinsics static-intrinsics))
         (macro-assoc-list (make-intrinsics-assoc-list intrinsics macro-intrinsics))
         (intrinsics-info
          (list
            intrinsics
            statics-assoc-list
            macro-assoc-list)))

  (let ((define_semantics-var (list-find-PycVar-by-id intrinsics 'define_semantics)))
    (if define_semantics-var
        (begin
          (mark-define-semantics! this #f intrinsics-info define_semantics-var)
          (let ((semantics (collect-top-level-semantics-intrinsics* this)))
            (set!
              macro-assoc-list
              (append
                macro-assoc-list
                (map
                  (lambda (pair) (cons (car pair) (make-pragma-call-maker (PycFun-name (cdr pair)))))
                  semantics))))
          (lambda-lift-semantics! this))))

  ;; static functions and values
  (resolve-statics-calls!
    this
    intrinsics
    macro-assoc-list
    #f)

  (resolve-statics!
    this
    intrinsics
    statics-assoc-list
    macro-assoc-list
    #f)

  ;; scoping/behaviors intrinsics
  (let ((use_simple_scoping-var (list-find-PycVar-by-id intrinsics 'use_simple_scoping)))
    (if use_simple_scoping-var
        (mark-use-simple-scoping! this (list-find-PycVar-by-id intrinsics 'use_simple_scoping))))
  (let ((define_behavior-var (list-find-PycVar-by-id intrinsics 'define_behavior)))
    (if define_behavior-var
      (mark-define-behavior! this intrinsics-info define_behavior-var)))

  (let ((builtin-var (list-find-PycVar-by-id intrinsics 'builtin))
        (private-var (list-find-PycVar-by-id intrinsics 'private)))
    (when (or builtin-var private-var)
      (mark-builtin-functions-and-classes-semantics! this builtin-var private-var)
      (PycModule-special-init-set! this 'builtins)))
  this))

;; check no intrinsics assig
(define-walk-method (check-no-intrinsics-assignation this::PycNode intrinsics)
  (call-default-walker))

(define-walk-method (check-no-intrinsics-assignation this::PycRef intrinsics)
  (if (memq (PycRef-ctx this) '(Store Del))
    (if (memq (PycRef-decl this) intrinsics)
      (error "SyntaxError" "cannot assign/delete compiler intrinsic name" (PycVar-id (PycRef-decl this)))
      (call-default-walker)))
    (call-default-walker))

;; resolve static intrinsics

(define-walk-method (resolve-statics! this::PycNode instrinsics statics macros use-static-builtins)
  (call-default-walker))

(define-walk-method (resolve-statics! this::PycRef intrinsics statics macros use-static-builtins)
  (let* ((var (PycRef-decl this))
        (static-value
          (let ((pair (assq var statics))) (if pair (cdr pair) #f))))
    (if static-value
      (new-PycStatic (PycNode-loc this) (PycVar-id var) static-value)
      this)))

(define-walk-method (resolve-statics! this::PycRefUnresolved intrinsics statics macros use-static-builtins)
  (let* ((id (PycRefUnresolved-id this))
         (static-value
           (and use-static-builtins (hashtable-get static-builtins-table id))))
    (if static-value
      (new-PycStatic (PycNode-loc this) id static-value)
      this)))

(define-walk-method (resolve-statics! this::PycFun intrinsics statics macros use-static-builtins)
  (let* ((decorators (PycFun-decorators this))
         (use_static_builtins-var (list-find-PycVar-by-id intrinsics 'use_static_builtins)))
    (if (or use-static-builtins
            (list-find-PycRef-by-PycVar
              decorators
              use_static_builtins-var))
      (let* ((body (PycFun-body this))
            (new-body (resolve-statics! body intrinsics statics macros #t)))
        (PycFun-decorators-set!
          this
          (list-remove-pred
            decorators
            (lambda (d)
              (and (isa? d PycRef)
                   (eq? (PycRef-decl d) use_static_builtins-var)))))
        (PycFun-body-set! this new-body)
        this)
      (call-default-walker))))


(define (check-and-set-static-can-be-super! this)
  (let* ((fun (PycCall-fun this)))
    (if (or (and
              (isa? fun PycRefUnresolved)
              (not (eq? (PycRefUnresolved-id fun) 'super)))
            (and
              (isa? fun PycPragma)
              (not (eq? (PycPragma-expr fun) 'py-builtin-super))))
      (PycCall-can-be-super-set! this #f))
    this))

(define-walk-method (resolve-statics-calls! this::PycNode intrinsics macros use-static-builtins)
  (call-default-walker))

(define-walk-method (resolve-statics-calls! this::PycFun intrinsics macros use-static-builtins)
  (let* ((decorators (PycFun-decorators this))
         (use_static_builtins-var (list-find-PycVar-by-id intrinsics 'use_static_builtins)))
    (if (or use-static-builtins
            (list-find-PycRef-by-PycVar
              decorators
              use_static_builtins-var))
      (let* ((body (PycFun-body this))
            (new-body (resolve-statics-calls! body intrinsics macros #t)))
        ;; do not remove the decorator yet
        (PycFun-body-set! this new-body)
        this)
      (call-default-walker))))

(define-walk-method (resolve-statics-calls! this::PycCall intrinsics macros use-static-builtins)
  (let* ((this (call-default-walker))
       (fun (PycCall-fun this)))
    (if use-static-builtins (check-and-set-static-can-be-super! this))
    (cond
      ((PycRef? fun)
        (let* ((pair (assq (PycRef-decl fun) macros)))
          (if pair
            ((cdr pair) this)
            this)))
      ((PycRefUnresolved? fun)
        (let* ((pair (assq (PycRefUnresolved-id fun) macro-static-builtins)))
          (if pair
            ((cdr pair) this)
            this)))
      (else this))))

;; resolve statically types binops
(define (get-pragma-call-type-hint call)
  (let* ((fun (PycCall-fun call))
        (expr (PycPragma-expr fun)))
    (cond
      ((eq? expr 'py-int-to-scheme) 'Uint)
      ((eq? expr 'py-bool-to-scheme-int) 'Usint)
      ((eq? expr 'py-sint-to-scheme) 'Usint)
      ((eq? expr 'py-bint-to-scheme) 'Ubint)
      ((eq? expr 'py-float-to-scheme) 'Ufloat)
      ((eq? expr 'py-bool-to-scheme-bool) 'Ubool)
      ((eq? expr 'py-str-to-scheme) 'Ustr)
      ((eq? expr 'py-int-from-scheme) 'int)
      ((eq? expr 'py-sint-from-scheme) 'sint)
      ((eq? expr 'py-bint-from-scheme) 'bint)
      ((eq? expr 'py-float-from-scheme) 'float)
      ((eq? expr 'py-bool-from-scheme-bool) 'bool)
      ((eq? expr 'py-str-from-scheme) 'str)
      ((eq? expr 'py-str-len-to-scheme) 'Usint)
      (else #f))))

(define (get-expr-type-hint expr)
  (cond
    ((and (PycCall? expr) (PycPragma? (PycCall-fun expr)))
      (get-pragma-call-type-hint expr))
    ((PycExpr-type expr)
      (PycExpr-type expr))
    (else
      #f)))

(define-walk-method (resolve-statics! this::PycBinary intrinsics statics macros use-static-builtins)
  (let* ((this (call-default-walker))
        (lhs-type-hint (get-expr-type-hint (PycBinary-lhs this)))
        (rhs-type-hint (get-expr-type-hint (PycBinary-rhs this))))
    (PycBinary-lhs-type-hint-set! this lhs-type-hint)
    (PycBinary-rhs-type-hint-set! this rhs-type-hint)
    this))

(define-walk-method (resolve-statics! this::PycUnary intrinsics statics macros use-static-builtins)
  (let* ((this (call-default-walker)))
    (PycUnary-type-hint-set! this (get-expr-type-hint (PycUnary-expr this)))
    this))

;; detects the use_simple-scoping intrinsics
(define-walk-method (mark-use-simple-scoping! this::PycNode use_simple_scoping-var)
  (call-default-walker))

(define-walk-method (mark-use-simple-scoping! this::PycFun use_simple_scoping-var)
  (let ((decorators (PycFun-decorators this)))
    (if (list-find-PycRef-by-id
          decorators
          use_simple_scoping-var)
      (begin
        (PycFun-decorators-set!
          this
          (list-remove-pred
            decorators
            (lambda (d)
              (and (isa? d PycRef)
                   (eq? (PycRef-decl d) use_simple_scoping-var)))))
        (PycFun-use-simple-scoping-set! this #t)))
      (call-default-walker)))

;; semantics
(define inlined-behaviors '(
  ;; binary
  (sint sint) (float float) (sint float) (float sint)
  ;;unary
  (sint) (float)))

(define (is-inlined-semantics name)
  (not (not
    (memq name '(add bitand bitor floordiv lshift matmul mod mul pow rshift sub
                 truediv xor
                 iadd ibitand ibitor ifloordiv ilshift imatmul imod
                 pos neg invert
                 imul ipow irshift isub itruediv ixor
                 ge gt le lt eq ne)))))

(define-walk-method (mark-define-semantics! this::PycNode parent-semantics intrinsics-info define_semantics-var)
  (call-default-walker))

(define-walk-method (mark-define-semantics! this::PycFun parent-semantics intrinsics-info define_semantics-var)
  (let* ((decorators (PycFun-decorators this))
         (semantics-decorator (list-find-PycRef-by-PycVar decorators define_semantics-var)))
    (if (isa? semantics-decorator PycRef)
      (resolve-statics!
        (PycFun-body this)
        (car intrinsics-info)
        (cadr intrinsics-info)
        (caddr intrinsics-info)
        #t))
    (if (or semantics-decorator parent-semantics)
      (let* ((res (call-default-walker))
            (loc (PycNode-loc res))
            (args (PycFun-args res))
            (posonlyargs (PycFun-posonlyargs res))
            (vararg (PycFun-vararg res))
            (kwonlyargs (PycFun-kwonlyargs res))
            (kw-defaults (PycFun-kw-defaults res))
            (kwarg (PycFun-kwarg res))
            (defaults (PycFun-defaults res))
            (body (PycFun-body res))
            (decls (PycFun-decls res))
            (name (PycFun-name res))
            (annotation (PycFun-annotation this))
            (annotation-names (PycFun-annotation-names this)))
        (new-PycSemantics
          loc
          args
          posonlyargs
          vararg
          kwonlyargs
          kw-defaults
          kwarg
          defaults
          (mark-define-semantics! body #t intrinsics-info define_semantics-var)
          decorators:
            (list-remove
              decorators
              semantics-decorator)
          decls: decls
          use-simple-scoping: #t
          name: (if semantics-decorator (make-semantics-scheme-name-from-fun-name name) name)
          annotation: annotation
          annotation-names: annotation-names
          inline: (if semantics-decorator (is-inlined-semantics name) #f)))
      (call-default-walker))))

;; behaviors
(define (schemify-name name)
  (list->string
    (let loop ((chars (string->list (symbol->string name))))
      (if (null? chars)
        chars
        (let ((fst (car chars)))
          (cons (if (char=? fst #\_) #\- fst) (loop (cdr chars))))))))

(define (make-fallback-behavior-name name)
  (string->symbol (string-append (schemify-name name) "-fallback")))

(define (make-inline-behavior-name name)
  (string->symbol (string-append (schemify-name name) "-inline")))

(define-walk-method (mark-define-behavior! this::PycNode intrinsics-info define_behavior-var)
  (call-default-walker))

(define (PycSemantics-has-inlinable-annotation fn)
  (define (ref->symbol ref)
    (if (PycRefUnresolved? ref) (PycRefUnresolved-id ref) #f))

  (let ((fn-annotation (map ref->symbol (PycFun-annotation fn))))
    (let loop ((annotations inlined-behaviors))
      (if (null? annotations)
        #f
        (if (equal? (car annotations) fn-annotation) #t (loop (cdr annotations)))))))

(define-walk-method (mark-define-behavior! this::PycFun intrinsics-info define_behavior-var)
  (let* ((loc (PycNode-loc this))
        (name (PycFun-name this))
        (body (PycFun-body this))
        (args (PycFun-args this))
        (posonlyargs (PycFun-posonlyargs this))
        (decorators (PycFun-decorators this))
        (behavior-decorator (list-find-PycRef-by-PycVar decorators define_behavior-var)))
    (define (make-behavior name body inline inline-as-is)
      (let* ((vararg (PycFun-vararg this))
            (kwonlyargs (PycFun-kwonlyargs this))
            (kw-defaults (PycFun-kw-defaults this))
            (kwarg (PycFun-kwarg this))
            (defaults (PycFun-defaults this))
            (decls (PycFun-decls this))
            (annotation (PycFun-annotation this))
            (annotation-names (PycFun-annotation-names this)))
        (new-PycSemantics
          loc
          args
          posonlyargs
          vararg
          kwonlyargs
          kw-defaults
          kwarg
          defaults
          body
          decorators:
            (list-remove
              decorators
              behavior-decorator)
          decls: decls
          use-simple-scoping: #t
          name: name
          annotation: annotation
          annotation-names: annotation-names
          inline: inline
          inline-as-is: inline-as-is)))

    (define (make-default-inline-behavior-body)
      (new-PycSeq
        loc
        (list
          (new-PycReturn
            loc
            (new-PycCall
              loc
              (new-PycPragma loc (make-fallback-behavior-name name))
              (map
                (lambda (a)
                  (new-PycCall
                    loc
                    (new-PycPragma loc 'unquote)
                    (list (new-PycRef loc a 'Load))))
                (append posonlyargs args)))))))

    (if behavior-decorator
      (begin
        (resolve-statics!
          (PycFun-body this)
          (car intrinsics-info)
          (cadr intrinsics-info)
          (caddr intrinsics-info)
          #t)
        (if (PycSemantics-has-inlinable-annotation this)
          ;; TODO: both semantics have the same (eq?) body, might be safer to make a deepcopy
          (new-PycSeq
            loc
            (list
              (make-behavior (make-fallback-behavior-name name) body #f #f)
              (make-behavior (make-inline-behavior-name name) body #t #f)))
          (new-PycSeq
            loc
            (list
              (make-behavior (make-fallback-behavior-name name) body #f #f)
              (make-behavior (make-inline-behavior-name name) (make-default-inline-behavior-body) #t #t)))))
      this)))

;; lambda lifting of semantics

(define (lambda-lift-semantics! module)
  (lambda-lift-semantics-walk! module))

(define-walk-method (lambda-lift-semantics-walk! this::PycNode)
  (call-default-walker))

(define-walk-method (lambda-lift-semantics-walk! this::PycAssig)
  (let ((val (PycAssig-rhs this)))
    (if (isa? val PycSemantics)
      (lambda-lift-nested-semantics val)
      this)))

(define (lambda-lift-nested-semantics sem)
  (let* ((loc (PycNode-loc sem))
        (cte
          (append
            (PycFun-args sem)
            (map PycRef-decl (collect-semantics-decls* (PycFun-body sem) #f))))
        (args-order (map (lambda (a) (PycVar-id a)) (PycFun-args sem)))
        (lifted-semantics (get-lifted-semantics* (PycFun-body sem) (PycFun-name sem) cte args-order)))
    (for-each
      (lambda (info)
        (let ((nested-sem (car info))
              (old-name (cadr info))
              (new-name (caddr info))
              (lifted-vars (cadddr info)))
          (PycFun-name-set! nested-sem new-name)
          (update-semantics-calls! sem old-name new-name lifted-vars)))
      lifted-semantics)
    (remove-semantics-decl!
      (new-PycBlock
        loc
        '()
        (new-PycSeq
          loc
          (cons
            sem
            (map car lifted-semantics)))))))

;; update-semantics-calls!
(define-walk-method (update-semantics-calls! this::PycNode old-name new-name lifted-vars)
  (call-default-walker))

(define-walk-method (update-semantics-calls! this::PycCall old-name new-name lifted-vars)
  (let ((loc (PycNode-loc this))
        (fun (PycCall-fun this))
        (args (PycCall-args this)))
    (if (and (isa? fun PycRef) (eq? (PycRef-decl fun) old-name))
      (let ((ref-loc (PycNode-loc fun)))
        (new-PycCall
          loc
          (new-PycPragma loc new-name)
          (append
            (map
              (lambda (var) (new-PycRef ref-loc var 'Load))
              lifted-vars)
            (map (lambda (a) (update-semantics-calls! a old-name new-name lifted-vars)) args))))
      (call-default-walker))))

;; get-lifted-semantics*

(define (get-variables-to-lift cte sem-cte sem-refs)
  (let ((table (make-hashtable)))
    (for-each
      (lambda (r) (hashtable-put! table r 'ref))
      sem-refs)
    (for-each
      (lambda (r) (if (hashtable-get table r) (hashtable-put! table r 'liftable)))
      cte)
    (for-each
      (lambda (r) (if (hashtable-get table r) (hashtable-put! table r #f)))
      sem-cte)
    (let loop ((pairs (hashtable->list table)) (acc '()))
      (if (null? pairs)
        acc
        (if (eq? (cdar pairs) 'liftable)
          (loop (cdr pairs) (cons (caar pairs) acc))
          (loop (cdr pairs) acc))))))

(define (sort-lifted-vars refs args-order)
  (define (var-sort lst)
    (sort
      (lambda (l r)
        (string<?
          (symbol->string (PycVar-id l))
          (symbol->string (PycVar-id r))))
      lst))

  (let* ((with-order
          (let loop ((lst args-order) (acc '()))
                (cond
                  ((null? lst)
                    (reverse acc))
                  ((list-find-PycRef-by-PycVar refs (car lst))
                    (loop (cdr lst) (cons (car lst) acc)))
                  (else
                    (loop (cdr lst) acc)))))
        (w/o-order
          (let loop ((lst refs) (acc '()))
                (cond
                  ((null? lst)
                    (reverse acc))
                  ((list-find-PycRef-by-PycVar args-order (car lst))
                    (loop (cdr lst) acc))
                  (else
                    (loop (cdr lst) (cons (car lst) acc))))))
        (sorted-w/o-order (var-sort w/o-order)))
    (append with-order sorted-w/o-order)))

(define-walk-method (get-lifted-semantics* this::PycNode parent-name cte args-order)
  (call-default-walker))

(define-walk-method (get-lifted-semantics* this::PycAssig parent-name cte args-order)
  (let ((lhs (PycAssig-lhs this))
        (rhs (PycAssig-rhs this)))
    (if (and (isa? lhs PycRef) (isa? rhs PycSemantics))
      (let* ((loc (PycNode-loc rhs))
            (sem-cte (map PycRef-decl (collect-semantics-decls* rhs #t))) ;; return Store PycRef in semantics
            (sem-refs (map PycRef-decl (collect-semantics-refs* rhs #t))) ;; return Load PycRef in semantics
            (lifted-vars (sort-lifted-vars (get-variables-to-lift cte sem-cte sem-refs) args-order)))
        (PycFun-args-set!
          rhs
          (append
            lifted-vars
            (PycFun-args rhs)))
        (list
          (list
            rhs ;; semantics
            (PycRef-decl lhs) ;; old name
            (symbol-append parent-name ': (PycFun-name rhs)) ;; new name
            lifted-vars)))
      (call-default-walker))))

;; collect-semantics-decls*

(define-walk-method (collect-semantics-decls* this::PycNode search-nested-semantics)
  (call-default-walker))

(define-walk-method (collect-semantics-decls* this::PycSemantics search-nested-semantics)
  (if search-nested-semantics
    (call-default-walker)
    '()))

(define-walk-method (collect-semantics-decls* this::PycRef search-nested-semantics)
  (if (eq? (PycRef-ctx this) 'Store)
    (list this)
    '()))

(define-walk-method (collect-semantics-decls* this::PycAssig search-nested-semantics)
  ;; this step is meant to avoid collecting PycRef for semantics as they will all be lifted
  ;; and so will become global refs
  (let ((lhs (PycAssig-lhs this))
        (rhs (PycAssig-rhs this)))
    (cond
      ((isa? rhs PycSemantics)
        (collect-semantics-decls* rhs search-nested-semantics))
      ((isa? lhs PycRef)
        (cons lhs (collect-semantics-decls* rhs search-nested-semantics)))
      (else
        (call-default-walker)))))


;; collect-semantics-refs*

(define-walk-method (collect-semantics-refs* this::PycNode search-nested-semantics)
  (call-default-walker))

(define-walk-method (collect-semantics-refs* this::PycSemantics search-nested-semantics)
  (if search-nested-semantics
    (call-default-walker)
    '()))

(define-walk-method (collect-semantics-refs* this::PycRef search-nested-semantics)
  (if (eq? (PycRef-ctx this) 'Load)
    (list this)
    '()))

;; remove-semantics-decl!

(define-walk-method (remove-semantics-decl! this::PycNode)
  (call-default-walker))

(define-walk-method (remove-semantics-decl! this::PycSeq)
  (PycSeq-nodes-set!
    this
    (let filter ((nodes (PycSeq-nodes this)))
      (cond
        ((null? nodes)
          '())
        ((and (isa? (car nodes) PycAssig)
              (isa? (PycAssig-rhs (car nodes)) PycSemantics))
          (filter (cdr nodes)))
        (else
          (cons (remove-semantics-decl! (car nodes)) (filter (cdr nodes)))))))
  this)

;; mark-builtin-functions-and-classes-semantics!

(define (mark-builtin-functions-and-classes-semantics! this builtin-var private-var)
  (if builtin-var (mark-is-builtin! this builtin-var))
  (if private-var (mark-is-private! this private-var))
  (set-builtins-scope! this)
  (let ((builtins-class-usage (collect-builtins-class-with-optimized-structures-usage* this builtin-var)))
    (if (not (null? builtins-class-usage))
      (optimize-builtin-class-with-optimized-structures-refs! this builtins-class-usage #f #f))))

(define-walk-method (set-builtins-scope! this::PycNode)
  (call-default-walker))

(define-walk-method (set-builtins-scope! this::PycAssig)
  (let ((lhs (PycAssig-lhs this))
        (rhs (PycAssig-rhs this)))
    (cond
      ((isa? rhs PycClass)
        (when (PycClass-is-builtin rhs)
            (PycVar-global-always-defined-set! (PycRef-decl lhs) #t)
            (PycVar-is-builtin-set! (PycRef-decl lhs) #t))
        (when (PycClass-is-private rhs)
      (PycVar-global-only-accessed-in-module-set! (PycRef-decl lhs) #t)))
      ((isa? rhs PycFun)
        (when (PycFun-is-builtin rhs)
            (PycVar-global-always-defined-set! (PycRef-decl lhs) #t)
            (PycVar-global-ref-to-init-def-set! (PycRef-decl lhs) #t)
            (PycVar-is-builtin-set! (PycRef-decl lhs) #t))
        (when (PycFun-is-private rhs)
            (PycVar-global-only-accessed-in-module-set! (PycRef-decl lhs) #t))))
    (call-default-walker)))

(define-walk-method (mark-is-builtin! this::PycNode builtin-var)
  (call-default-walker))

(define-walk-method (mark-is-builtin! this::PycClass builtin-var)
  (let* ((decorators (PycClass-decorators this))
        (builtin-decorator (list-find-PycRef-by-PycVar decorators builtin-var)))
    (if builtin-decorator
      (begin
        (PycClass-is-builtin-set! this #t)
        (PycClass-decorators-set! this (list-remove (PycClass-decorators this) builtin-decorator))))
    (call-default-walker)))

(define-walk-method (mark-is-builtin! this::PycFun builtin-var)
  (let* ((decorators (PycFun-decorators this))
        (builtin-decorator (list-find-PycRef-by-PycVar decorators builtin-var)))
    (if builtin-decorator
      (begin
        (PycFun-is-builtin-set! this #t)
        (PycFun-decorators-set! this (list-remove (PycFun-decorators this) builtin-decorator))))
    (call-default-walker)))

(define-walk-method (mark-is-private! this::PycNode private-var)
  (call-default-walker))

(define-walk-method (mark-is-private! this::PycClass private-var)
  (let* ((decorators (PycClass-decorators this))
        (private-decorator (list-find-PycRef-by-PycVar decorators private-var)))
    (if private-decorator
      (begin
        (PycClass-is-private-set! this #t)
        (PycClass-decorators-set! this (list-remove (PycClass-decorators this) private-decorator))))
    (call-default-walker)))

(define-walk-method (mark-is-private! this::PycFun private-var)
  (let* ((decorators (PycFun-decorators this))
        (private-decorator (list-find-PycRef-by-PycVar decorators private-var)))
    (if private-decorator
      (begin
        (PycFun-is-private-set! this #t)
        (PycFun-decorators-set! this (list-remove (PycFun-decorators this) private-decorator))))
    (call-default-walker)))

(define builtin-class-structure-name-assoc-list
  '((range . PyObjectRange)
    (range_iterator . PyObjectRangeIterator)))

(define-walk-method (collect-builtins-class-with-optimized-structures-usage* this::PycNode builtin-var)
  (call-default-walker))

(define (get-builtin-class-structure-name class-name)
  (let ((res (assq class-name builtin-class-structure-name-assoc-list)))
    (if res
      (cdr res)
      #f)))

(define-walk-method (collect-builtins-class-with-optimized-structures-usage* this::PycAssig builtin-var)
  (let ((lhs (PycAssig-lhs this))
        (rhs (PycAssig-rhs this)))
    (if (and (isa? lhs PycRef) (isa? rhs PycClass))
      (let* ((name (string->symbol (PycClass-name rhs))))
        (if (PycClass-is-builtin rhs)
          (let ((structure (get-builtin-class-structure-name name)))
            (if structure
              (cons
                (cons
                  (PycRef-decl lhs)
                  structure)
                (call-default-walker))
              (call-default-walker)))
          (call-default-walker)))
      (call-default-walker))))

(define-walk-method (optimize-builtin-class-with-optimized-structures-refs! this::PycNode builtins-class-table class self)
  (call-default-walker))

(define (make-maker-name name)
  (string->symbol (string-append "make-" (symbol->string name))))

(define (make-HClass-name name)
  (string->symbol (string-append "py-" (symbol->string name) "-hclass-of-instances")))

(define (make-getter-name name field)
  (string->symbol (string-append (symbol->string name) "-" field)))

(define (make-setter-name name field)
  (string->symbol (string-append (symbol->string name) "-" field "-set!")))

(define (make-scheme-class-name name)
  (string->symbol (string-append "py-builtin-" (symbol->string name))))

(define (get-fun-first-arg fun)
  (let ((posonlyargs (PycFun-posonlyargs fun)))
    (if (null? posonlyargs)
      (let ((args (PycFun-args fun)))
        (if (null? args)
          #f
          (car args)))
      (car posonlyargs))))

(define-walk-method (optimize-builtin-class-with-optimized-structures-refs! this::PycFun builtins-class-table class self)
  (if class
    (let ((first-arg (get-fun-first-arg this)))
      (if first-arg
        (begin
          (PycFun-decorators-set!
            this
            (map (lambda (node) (optimize-builtin-class-with-optimized-structures-refs! node builtins-class-table class self))
                 (PycFun-decorators this)))
          (PycFun-body-set!
            this
            (optimize-builtin-class-with-optimized-structures-refs! (PycFun-body this) builtins-class-table class first-arg))))
      this)
    (call-default-walker)))

(define-walk-method (optimize-builtin-class-with-optimized-structures-refs! this::PycAssig builtins-class-table class self)
  (let ((lhs (PycAssig-lhs this))
        (rhs (PycAssig-rhs this)))
    (cond
      ((PycAccess? lhs)
        (if (and class self)
          (let ((obj (PycAccess-obj lhs))
                (loc (PycNode-loc this)))
            (if (and (PycRef? obj) (eq? (PycRef-decl obj) self))
              (new-PycCall
                loc
                (new-PycPragma loc
                  (make-setter-name
                    (cdr (assq class builtins-class-table))
                    (PycAccess-field lhs)))
                (list
                  (optimize-builtin-class-with-optimized-structures-refs! obj builtins-class-table class self)
                  (optimize-builtin-class-with-optimized-structures-refs! rhs builtins-class-table class self)))
              (begin
                (PycAssig-rhs-set!
                  this
                  (optimize-builtin-class-with-optimized-structures-refs! (PycAssig-rhs this) builtins-class-table class self))
                this)))
          (call-default-walker)))
        ((and (isa? lhs PycRef) (isa? rhs PycClass))
          (let ((scheme-class-info (assq (PycRef-decl lhs) builtins-class-table)))
            (if scheme-class-info
              (let ((scheme-class (PycRef-decl lhs)))
                (PycClass-bases-set!
                  rhs
                  (map (lambda (node) (optimize-builtin-class-with-optimized-structures-refs! node builtins-class-table class self))
                       (PycClass-bases rhs)))
                (PycClass-body-set!
                  rhs
                  (optimize-builtin-class-with-optimized-structures-refs! (PycClass-body rhs) builtins-class-table scheme-class #f))
                (PycClass-decorators-set!
                  rhs
                  (map (lambda (node) (optimize-builtin-class-with-optimized-structures-refs! node builtins-class-table class self))
                       (PycClass-decorators rhs)))
                this)
              (call-default-walker))))
        (else (call-default-walker)))))

(define-walk-method (optimize-builtin-class-with-optimized-structures-refs! this::PycAccess builtins-class-table class self)
  (let ((obj (PycAccess-obj this))
        (loc (PycNode-loc this)))
    (if (and (PycRef? obj) (eq? (PycRef-decl obj) self))
      (new-PycCall
        loc
        (new-PycPragma loc
          (make-getter-name
            (cdr (assq class builtins-class-table))
            (PycAccess-field this)))
        (list
          (optimize-builtin-class-with-optimized-structures-refs! obj builtins-class-table class self)))
      (call-default-walker))))

(define-walk-method (collect-top-level-semantics-intrinsics* this::PycNode)
  (call-default-walker))

(define-walk-method (collect-top-level-semantics-intrinsics* this::PycAssig)
  (let ((lhs (PycAssig-lhs this))
        (rhs (PycAssig-rhs this)))
    (if (and (isa? lhs PycRef) (isa? rhs PycSemantics))
      (list (cons (PycRef-decl lhs) rhs))
      (call-default-walker))))

(define-walk-method (collect-top-level-semantics-intrinsics* this::PycSemantics)
  (error "collect-top-level-semantics-intrinsics*::PycSemantics" "semantics not in PycAssig" this))

(define-walk-method (collect-top-level-semantics-intrinsics* this::PycFun)
  '())

(define-walk-method (collect-top-level-semantics-intrinsics* this::PycClass)
  '())
