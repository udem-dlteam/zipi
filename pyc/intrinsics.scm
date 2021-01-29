(define (pyc-intrinsics this conf)
   (intrinsics this conf))

(define (collect-import-intrinsics nodes)
  (if (null? nodes)
    '()
    (cons
      (PycRefUnresolved-id (PycAssig-lhs (car nodes)))
      (collect-import-intrinsics (cdr nodes)))))

(define (list-remove lst x)
  (cond
    ((null? lst)
      '())
    ((eq? (car lst) x)
      (cdr lst))
    (else
      (cons (car lst) (list-remove (cdr lst) x)))))

(define (list-remove-pred lst pred?)
  (cond
    ((null? lst)
      '())
    ((pred? (car lst))
      (list-remove-pred (cdr lst) pred?))
    (else
      (cons (car lst) (list-remove-pred (cdr lst) pred?)))))

(define (intrinsics this conf)
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
        ((PycDeclInit? fst-line-stmt)
          (let ((val (PycDeclInit-val fst-line-stmt)))
            (if (and (PycImport? val)
                     (equal? (PycImport-path val) "__compiler_intrinsics__"))
              (error "SyntaxError" "cannot import __compiler_intrinsics__ as a module" #f)
              this)))
        ((PycBlock? fst-line-stmt)
          (let* ((decls (PycBlock-decls fst-line-stmt))
                (fst-decl (car decls)))
            (if (PycVar? fst-decl)
              (let ((val (PycDeclInit-val fst-decl)))
                (if (and (PycImport? val)
                         (equal? (PycImport-path val) "__compiler_intrinsics__"))
                  (let* ((nodes (PycSeq-nodes (PycBlock-body fst-line-stmt)))
                         (intrinsics (collect-import-intrinsics nodes)))
                    (PycModule-stmts-set!
                      this
                      (list-remove
                        (PycModule-stmts this)
                        fst-line-stmt))
                    (use-intrinsics! this intrinsics))
                  this))
              this)))
        (else this))))

(define (make-inline_host_code this)
  (let* ((loc (PycNode-loc this))
        (args (PycCall-args this))
        (args-len (length args)))
    (if (and
          (= args-len 1)
          (PycString? (car args)))
      (new-PycPragma loc (call-with-input-string (PycLiteralValue-val (car args)) read))
      (error "SyntaxError" "wrong argument for inline_host_code" args))))

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
    (cons 'py_float_to_host (make-pragma-call-maker 'py-float-to-scheme))
    (cons 'py_float_from_host (make-pragma-call-maker 'py-float-from-scheme))
    (cons 'py_int_from_host (make-pragma-call-maker 'py-int-from-scheme))
    (cons 'py_int_to_host (make-pragma-call-maker 'py-int-to-scheme))
    (cons 'py_bool_to_host_int (make-pragma-call-maker 'py-bool-to-scheme-int))
    (cons 'py_sint_to_host (make-pragma-call-maker 'py-sint-to-scheme))
    (cons 'py_bint_to_host (make-pragma-call-maker 'py-bint-to-scheme))
    (cons 'py_bool_from_host_bool (make-pragma-call-maker 'py-bool-from-scheme-bool))
    (cons 'py_bool_to_host_bool (make-pragma-call-maker 'py-bool-to-scheme-bool))))

(define static-intrinsics
  (list
    (cons 'absent 'py-absent)))

;; TODO: generate a full table of builtins with Zipi rts name
(define static-builtins
  '(
    ;; builtin callables
    (super . py-builtin-super)
    (type . py-builtin-type)
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
      builtin_class)))

(define (make-intrinsics-assoc-list intrinsics assoc-list)
  (if (null? intrinsics)
    '()
    (let ((pair (assoc (car intrinsics) assoc-list)))
      (if pair
        (cons pair (make-intrinsics-assoc-list (cdr intrinsics) assoc-list))
        (make-intrinsics-assoc-list (cdr intrinsics) assoc-list)))))

(define (check-invalid-intrinsics intrinsics)
  (cond
    ((null? intrinsics)
      #t)
    ((member (car intrinsics) valid-intrinsics)
      (check-invalid-intrinsics (cdr intrinsics)))
    (else
      (error "SyntaxError" "invalid __compiler_intrinsics__" (car intrinsics)))))

(define (use-intrinsics! this intrinsics)
  (let* ((statics-assoc-list (make-intrinsics-assoc-list intrinsics static-intrinsics))
         (macro-assoc-list (make-intrinsics-assoc-list intrinsics macro-intrinsics))
         (intrinsics-info
          (list
            intrinsics
            statics-assoc-list
            macro-assoc-list)))
  (check-invalid-intrinsics intrinsics)
  (check-no-intrinsics-assignation this intrinsics)
  (resolve-statics!
    this
    intrinsics
    statics-assoc-list
    macro-assoc-list
    #f)
  (if (member 'use_simple_scoping intrinsics)
      (mark-use-simple-scoping! this))
  (if (member 'define_semantics intrinsics)
      (begin
        (mark-define-semantics! this #f intrinsics-info)
        (lambda-lift-semantics! this)))
  (if (member 'define_behavior intrinsics)
    (mark-define-behavior! this intrinsics-info))
  (if (member 'builtin_class intrinsics)
      (mark-builtin-class-semantics! this))
  this))

(define-walk-method (check-no-intrinsics-assignation this::PycNode intrinsics)
  (call-default-walker))

(define-walk-method (check-no-intrinsics-assignation this::PycDecl intrinsics)
  (if (member (PycDecl-id this) intrinsics)
    (error "SyntaxError" "cannot use compiler intrinsic as name" (PycDecl-id this)))
  (call-default-walker))

(define-walk-method (check-no-intrinsics-assignation this::PycAssig intrinsics)
  (let ((lhs (PycAssig-lhs this)))
    (if (and
          (PycRefUnresolved? lhs)
          (member (PycRefUnresolved-id lhs) intrinsics))
      (error "SyntaxError" "cannot use compiler intrinsic as name" (PycRefUnresolved-id lhs)))
    (call-default-walker)))

(define-walk-method (resolve-statics! this::PycNode instrinsics statics macros use-static-builtins)
  (call-default-walker))

(define-walk-method (resolve-statics! this::PycRefUnresolved intrinsics statics macros use-static-builtins)
  (let* ((id (PycRefUnresolved-id this))
        (static-value
          (or
            (let ((pair (assoc id statics)))
              (if pair (cdr pair) #f))
            (and
              use-static-builtins
              (hashtable-get static-builtins-table id)))))
    (if static-value
      (let ((loc (PycNode-loc this)))
        (new-PycStatic loc id static-value))
      this)))

(define (PycRef-with-name? x name)
  (and (PycRefUnresolved? x) (eq? (PycRefUnresolved-id x) name)))

(define (contains-PycRef-with-name? lst name)
  (cond
    ((null? lst)
      #f)
    ((PycRef-with-name? (car lst) name)
      #t)
    (else
      (contains-PycRef-with-name? (cdr lst) name))))

(define-walk-method (resolve-statics! this::PycFun intrinsics statics macros use-static-builtins)
  (let ((decorators (PycFun-decorators this)))
    (if (or use-static-builtins
            (and
              (member 'use_static_builtins intrinsics)
              (contains-PycRef-with-name? decorators 'use_static_builtins)))
      (let* ((body (PycFun-body this))
            (new-body (resolve-statics! body intrinsics statics macros #t)))
        (PycFun-decorators-set!
          this
          (list-remove-pred decorators (lambda (d) (PycRef-with-name? d 'use_static_builtins))))
        (PycFun-body-set! this new-body)
        this)
      (call-default-walker))))

(define-walk-method (resolve-statics! this::PycCall intrinsics statics macros use-static-builtins)
  (let ((this (call-default-walker))
       (fun (PycCall-fun this)))
    (if (and use-static-builtins
           (or
             (not (PycStatic? fun))
             (not (eq? (PycIntrinsics-id fun) 'super))))
      (PycCall-can-be-super-set! this #f))
    (if (PycRefUnresolved? fun)
      (let* ((pair (assoc (PycRefUnresolved-id fun) macros)))
        (if pair
          ((cdr pair) this)
          this))
      this)))

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
      ((eq? expr 'py-int-from-scheme) 'int)
      ((eq? expr 'py-sint-from-scheme) 'sint)
      ((eq? expr 'py-bint-from-scheme) 'bint)
      ((eq? expr 'py-float-from-scheme) 'float)
      ((eq? expr 'py-bool-from-scheme-bool) 'bool)
      (else #f))))

(define (get-expr-type-hint expr)
  (if (and (PycCall? expr) (PycPragma? (PycCall-fun expr)))
    (get-pragma-call-type-hint expr)
    #f))

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

(define-walk-method (mark-use-simple-scoping! this::PycNode)
  (call-default-walker))

(define-walk-method (mark-use-simple-scoping! this::PycFun)
  (let ((decorators (PycFun-decorators this)))
    (if (contains-PycRef-with-name? decorators 'use_simple_scoping)
      (begin
        (PycFun-decorators-set!
          this
          (list-remove-pred decorators (lambda (d) (PycRef-with-name? d 'use_simple_scoping))))
        (PycFun-use-simple-scoping-set! this #t)))
      (call-default-walker)))

(define-walk-method (mark-define-semantics! this::PycNode parent-semantics intrinsics-info)
  (call-default-walker))

(define (is-inlined-semantics name)
  (not (not
    (memq name '(add bitand bitor floordiv lshift matmul mod mul pow rshift sub
                 truediv xor
                 iadd ibitand ibitor ifloordiv ilshift imatmul imod
                 pos neg invert
                 imul ipow irshift isub itruediv ixor
                 ge gt le lt eq ne)))))

(define-walk-method (mark-define-semantics! this::PycFun parent-semantics intrinsics-info)
  (let* ((decorators (PycFun-decorators this))
        (is-decorated-semantics (contains-PycRef-with-name? decorators 'define_semantics)))
    (if is-decorated-semantics
      (resolve-statics!
        (PycFun-body this)
        (car intrinsics-info)
        (cadr intrinsics-info)
        (caddr intrinsics-info)
        #t))
    (if (or is-decorated-semantics parent-semantics)
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
          (mark-define-semantics! body #t intrinsics-info)
          decorators:
            (list-remove-pred
              decorators
              (lambda (d)
                (or (PycRef-with-name? d 'use_simple_scoping)
                    (PycRef-with-name? d 'define_semantics))))
          decls: decls
          use-simple-scoping: #t
          name: (if is-decorated-semantics (symbol-append 'py- name '-fallback) name)
          annotation: annotation
          annotation-names: annotation-names
          inline: (if is-decorated-semantics (is-inlined-semantics name) #f)))
      (call-default-walker))))

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

(define-walk-method (mark-define-behavior! this::PycNode intrinsics-info)
  (call-default-walker))

(define inlined-behaviors '(
  ;; binary
  (sint sint) (float float) (sint float) (float sint)
  ;;unary
  (sint) (float)))

(define (PycSemantics-has-inlinable-annotation fn)
  (define (ref->symbol ref)
    (if (PycRefUnresolved? ref) (PycRefUnresolved-id ref) #f))

  (let ((fn-annotation (map ref->symbol (PycFun-annotation fn))))
    (let loop ((annotations inlined-behaviors))
      (if (null? annotations)
        #f
        (if (equal? (car annotations) fn-annotation) #t (loop (cdr annotations)))))))

(define-walk-method (mark-define-behavior! this::PycFun intrinsics-info)
  (let* ((loc (PycNode-loc this))
        (name (PycFun-name this))
        (body (PycFun-body this))
        (args (PycFun-args this))
        (posonlyargs (PycFun-posonlyargs this))
        (decorators (PycFun-decorators this))
        (is-decorated-behavior (contains-PycRef-with-name? decorators 'define_behavior)))

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
            (list-remove-pred
              decorators
              (lambda (d)
                (or (PycRef-with-name? d 'use_simple_scoping)
                    (PycRef-with-name? d 'define_behavior))))
          decls: decls
          use-simple-scoping: #t
          name: name
          annotation: annotation
          annotation-names: annotation-names
          inline: inline
          inline-as-is: inline-as-is)))

    (define (make-default-inline-behavior-body)
      (define args-names (append (map PycDecl-id posonlyargs) (map PycDecl-id args)))
      (new-PycSeq
        loc
        (list
          (new-PycReturn
            loc
            (new-PycCall
              loc
              (new-PycPragma loc (make-fallback-behavior-name name))
              (map
                (lambda (name)
                  (new-PycCall
                    loc
                    (new-PycPragma loc 'unquote)
                    (list (new-PycRefUnresolved loc name))))
                args-names))))))

    (if is-decorated-behavior
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

(define (lambda-lift-semantics! module)
  (lambda-lift-semantics-walk! module))

(define-walk-method (lambda-lift-semantics-walk! this::PycNode)
  (call-default-walker))

(define-walk-method (lambda-lift-semantics-walk! this::PycDeclInit)
  (let ((val (PycDeclInit-val this)))
    (if (isa? val PycSemantics)
      (lambda-lift-nested-semantics val)
      this)))

(define (lambda-lift-nested-semantics sem)
  (let* ((loc (PycNode-loc sem))
        (cte
          (append
            (apply append (map (lambda (arg) (collect-semantics-decls* arg #f)) (PycFun-args sem)))
            (collect-semantics-decls* (PycFun-body sem) #f)))
        (args-order (map (lambda (a) (PycDecl-id a)) (PycFun-args sem)))
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
    (if (and (isa? fun PycRefUnresolved) (eq? (PycRefUnresolved-id fun) old-name))
      (let ((ref-loc (PycNode-loc fun)))
        (new-PycCall
          loc
          (new-PycPragma loc new-name)
          (append
            (map
              (lambda (name) (new-PycRefUnresolved ref-loc name))
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

(define (sort-lifted-vars vars order)
  (define (symbol-sort lst)
    (map string->symbol (sort string<? (map symbol->string lst))))

  (let* ((with-order
          (let loop ((lst order) (acc '()))
                (cond
                  ((null? lst)
                    (reverse acc))
                  ((member (car lst) vars)
                    (loop (cdr lst) (cons (car lst) acc)))
                  (else
                    (loop (cdr lst) acc)))))
        (w/o-order
          (let loop ((lst vars) (acc '()))
                (cond
                  ((null? lst)
                    (reverse acc))
                  ((member (car lst) order)
                    (loop (cdr lst) acc))
                  (else
                    (loop (cdr lst) (cons (car lst) acc))))))
        (sorted-w/o-order (symbol-sort w/o-order)))
    (append with-order sorted-w/o-order)))

(define-walk-method (get-lifted-semantics* this::PycNode parent-name cte args-order)
  (call-default-walker))

(define-walk-method (get-lifted-semantics* this::PycSemantics parent-name cte args-order)
  (let* ((loc (PycNode-loc this))
        (sem-cte (collect-semantics-decls* this #t))
        (sem-refs (collect-semantics-refs* this #t))
        (lifted-vars (sort-lifted-vars (get-variables-to-lift cte sem-cte sem-refs) args-order)))
    (PycFun-args-set!
      this
      (append
        (map (lambda (name) (new-PycDecl loc name 'local)) lifted-vars)
        (PycFun-args this)))
    (list
      (list
        this ;; semantics
        (PycFun-name this) ;; old name
        (symbol-append parent-name ': (PycFun-name this)) ;; new name
        lifted-vars))))

;; collect-semantics-decls*

(define-walk-method (collect-semantics-decls* this::PycNode search-nested-semantics)
  (call-default-walker))

(define-walk-method (collect-semantics-decls* this::PycSemantics search-nested-semantics)
  (if search-nested-semantics
    (call-default-walker)
    '()))

(define-walk-method (collect-semantics-decls* this::PycDecl search-nested-semantics)
  (list (PycDecl-id this)))

(define-walk-method (collect-semantics-decls* this::PycDeclInit search-nested-semantics)
  ;; Assumption: all sub-procedures in semantics are liftable and will be global
  (if (isa? (PycDeclInit-val this) PycSemantics)
    '()
    (list (PycDecl-id this))))

(define-walk-method (collect-semantics-decls* this::PycAssig search-nested-semantics)
  (collect-semantics-refs* (PycAssig-lhs this) search-nested-semantics))

;; collect-semantics-refs*

(define-walk-method (collect-semantics-refs* this::PycNode search-nested-semantics)
  (call-default-walker))

(define-walk-method (collect-semantics-refs* this::PycSemantics search-nested-semantics)
  (if search-nested-semantics
    (call-default-walker)
    '()))

(define-walk-method (collect-semantics-refs* this::PycRefUnresolved search-nested-semantics)
  (list (PycRefUnresolved-id this)))

(define-walk-method (collect-semantics-refs* this::PycAssig search-nested-semantics)
  (collect-semantics-refs* (PycAssig-rhs this) search-nested-semantics))

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
        ((and (isa? (car nodes) PycDeclInit)
              (isa? (PycDeclInit-val (car nodes)) PycSemantics))
          (filter (cdr nodes)))
        (else
          (cons (remove-semantics-decl! (car nodes)) (filter (cdr nodes)))))))
  this)

;; mark-builtin-class-semantics!

(define (mark-builtin-class-semantics! this)
  (let ((builtins-class-usage (collect-builtins-class-usage* this)))
    (if (not (null? builtins-class-usage))
      (optimize-builtin-class-refs! this builtins-class-usage #f #f))))

(define-walk-method (collect-builtins-class-usage* this::PycNode)
  (call-default-walker))

(define (get-builtin-class-decorator-name node)
  (if (PycCall? node)
    (let ((fun (PycCall-fun node)))
      (if (and (PycRefUnresolved? fun) (eq? (PycRefUnresolved-id fun) 'builtin_class))
        (let ((args (PycCall-args node)))
          (if (< (length args) 1)
            (error "SyntaxError" "builtin_class requires at least one argument, the object type linked to the class" fun)
            (let ((scheme-class-name (car args)))
              (if (PycString? scheme-class-name)
                (PycLiteralValue-val scheme-class-name)
                (error "SyntaxError" "builtin_class first argument must be a string literal" scheme-class-name)))))
        #f))
    #f))

(define (find-class-decorator-name decorators)
  (if (null? decorators)
    #f
    (or (get-builtin-class-decorator-name (car decorators))
        (find-class-decorator-name (cdr decorators)))))

(define builtin-class-structure-name-assoc-list
  '((int . PyObjectInt)
    (bool . PyObjectInt)
    (float . PyObjectFloat)
    (range . PyObjectRange)
    (range_iterator . PyObjectRangeIterator)))

(define (get-builtin-class-structure-name class-name)
  (let ((res (assq class-name builtin-class-structure-name-assoc-list)))
    (if res
      (cdr res)
      (error "get-builtin-class-structure-name" "unknown structure for class" class-name))))

(define-walk-method (collect-builtins-class-usage* this::PycClass)
  (let* ((decorators (PycClass-decorators this))
        (name (string->symbol (PycClass-name this))))
    (if (contains-PycRef-with-name? decorators 'builtin_class)
      (cons
        (cons
          name
          (get-builtin-class-structure-name name))
        (call-default-walker))
      (call-default-walker))))

(define-walk-method (optimize-builtin-class-refs! this::PycNode builtins-class-table class self)
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

(define-walk-method (optimize-builtin-class-refs! this::PycCall builtins-class-table class self)
  (let ((fun (PycCall-fun this)))
    (if (PycRefUnresolved? fun)
      (let ((scheme-class (assq (PycRefUnresolved-id fun) builtins-class-table)))
        (if scheme-class
          (let ((loc (PycNode-loc this)))
            (new-PycCall
              loc
              (new-PycPragma loc (make-maker-name (cdr scheme-class)))
              (append
                (list
                  (new-PycStatic loc 'arg1 (make-HClass-name (car scheme-class)))
                  (new-PycStaticSexp loc 'arg2 '(quote #()))
                  (new-PycStatic loc 'arg3 (make-scheme-class-name (car scheme-class))))
                (map
                  (lambda (n)
                    (optimize-builtin-class-refs!
                      n
                      builtins-class-table
                      class
                      self))
                  (PycCall-args this)))))
          (call-default-walker)))
      (call-default-walker))))

(define-walk-method (optimize-builtin-class-refs! this::PycClass builtins-class-table class self)
  (let ((scheme-class-info (assq (string->symbol (PycClass-name this)) builtins-class-table)))
    (if scheme-class-info
      (let ((scheme-class (cdr scheme-class-info)))
        (new-PycClass
          (PycNode-loc this)
          (PycClass-name this)
          (PycClass-module this)
          ;; bases
          (map (lambda (node) (optimize-builtin-class-refs! node builtins-class-table class self))
               (PycClass-bases this))
          ;; body
          (optimize-builtin-class-refs! (PycClass-body this) builtins-class-table scheme-class self)
          decorators:
            (map (lambda (node) (optimize-builtin-class-refs! node builtins-class-table class self))
                 (PycClass-decorators this))
          is-builtin: #t))
      (call-default-walker))))

(define (get-fun-first-arg fun)
  (let ((posonlyargs (PycFun-posonlyargs fun)))
    (if (null? posonlyargs)
      (let ((args (PycFun-args fun)))
        (if (null? args)
          #f
          (PycDecl-id (car args))))
      (PycDecl-id (car posonlyargs)))))

(define-walk-method (optimize-builtin-class-refs! this::PycFun builtins-class-table class self)
  (if class
    (let ((first-arg (get-fun-first-arg this)))
      (if first-arg
        (begin
          (PycFun-decorators-set!
            this
            (map (lambda (node) (optimize-builtin-class-refs! node builtins-class-table class self))
                 (PycFun-decorators this)))
          (PycFun-body-set!
            this
            (optimize-builtin-class-refs! (PycFun-body this) builtins-class-table class first-arg))))
      this)
    (call-default-walker)))

(define-walk-method (optimize-builtin-class-refs! this::PycAssig builtins-class-table class self)
  (if (and class self)
    (let ((lhs (PycAssig-lhs this)))
      (if (PycAccess? lhs)
        (let ((obj (PycAccess-obj lhs))
              (loc (PycNode-loc this)))
          (if (and (PycRefUnresolved? obj) (eq? (PycRefUnresolved-id obj) self))
            (new-PycCall
              loc
              (new-PycPragma loc (make-setter-name class (PycAccess-field lhs)))
              (list
                (optimize-builtin-class-refs! obj builtins-class-table class self)
                (optimize-builtin-class-refs! (PycAssig-rhs this) builtins-class-table class self)))
            (call-default-walker)))
        (call-default-walker)))
  (call-default-walker)))

(define-walk-method (optimize-builtin-class-refs! this::PycAccess builtins-class-table class self)
  (let ((obj (PycAccess-obj this))
        (loc (PycNode-loc this)))
    (if (and (PycRefUnresolved? obj) (eq? (PycRefUnresolved-id obj) self))
      (new-PycCall
        loc
        (new-PycPragma loc (make-getter-name class (PycAccess-field this)))
        (list
          (optimize-builtin-class-refs! obj builtins-class-table class self)))
      (call-default-walker))))
