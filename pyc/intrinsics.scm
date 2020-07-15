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

(define (make-class_getattr this)
  (let* ((loc (PycNode-loc this))
        (args (PycCall-args this))
        (args-len (length args))
        (attr (cadr args)))
      (if (and
            (= args-len 2)
            (PycString? attr))
        (new-PycMacro loc 'class_getattr 'getattribute-from-obj-mro args)
        (error "SyntaxError" "wrong argument for class_getattr" #f))))

(define (make-call_host this)
  (let* ((loc (PycNode-loc this))
        (args (PycCall-args this))
        (args-len (length args))
        (attr (cadr args)))
      (if (and
            (>= args-len 1)
            (PycString? (car args)))
        (new-PycMacro
          loc
          'call_host
          'call-host
          (cons
            (new-PycStatic
              loc
              'host-signature
              (PycLiteralValue-val (car args)))
            (cdr args)))
        (error "SyntaxError" "wrong argument for call_host" #f))))

(define macro-intrinsics
  (list
    (cons 'class_getattr make-class_getattr)
    (cons 'call_host make-call_host)))

(define static-intrinsics
  (list
    (cons 'absent 'py-absent)))

;; TODO: generate a full table of builtins with Zipi rts name
(define static-builtins
  (list
    ;; builtin callables
    (cons 'super 'py-builtin-super)
    ;; builtin constants
    (cons 'NotImplemented 'py-NotImplemented)
    ;; exceptions
    (cons 'ArithmeticError 'py-builtin-ArithmeticError)
    (cons 'AssertionError 'py-builtin-AssertionError)
    (cons 'AttributeError 'py-builtin-AttributeError)
    (cons 'BaseException 'py-builtin-BaseException)
    (cons 'BlockingIOError 'py-builtin-BlockingIOError)
    (cons 'BrokenPipeError 'py-builtin-BrokenPipeError)
    (cons 'BufferError 'py-builtin-BufferError)
    (cons 'BytesWarning 'py-builtin-BytesWarning)
    (cons 'ChildProcessError 'py-builtin-ChildProcessError)
    (cons 'ConnectionAbortedError 'py-builtin-ConnectionAbortedError)
    (cons 'ConnectionError 'py-builtin-ConnectionError)
    (cons 'ConnectionRefusedError 'py-builtin-ConnectionRefusedError)
    (cons 'ConnectionResetError 'py-builtin-ConnectionResetError)
    (cons 'DeprecationWarning 'py-builtin-DeprecationWarning)
    (cons 'EOFError 'py-builtin-EOFError)
    (cons 'EnvironmentError 'py-builtin-EnvironmentError)
    (cons 'Exception 'py-builtin-Exception)
    (cons 'FileExistsError 'py-builtin-FileExistsError)
    (cons 'FileNotFoundError 'py-builtin-FileNotFoundError)
    (cons 'FloatingPointError 'py-builtin-FloatingPointError)
    (cons 'FutureWarning 'py-builtin-FutureWarning)
    (cons 'GeneratorExit 'py-builtin-GeneratorExit)
    (cons 'IOError 'py-builtin-IOError)
    (cons 'ImportError 'py-builtin-ImportError)
    (cons 'ImportWarning 'py-builtin-ImportWarning)
    (cons 'IndentationError 'py-builtin-IndentationError)
    (cons 'IndexError 'py-builtin-IndexError)
    (cons 'InterruptedError 'py-builtin-InterruptedError)
    (cons 'IsADirectoryError 'py-builtin-IsADirectoryError)
    (cons 'KeyError 'py-builtin-KeyError)
    (cons 'KeyboardInterrupt 'py-builtin-KeyboardInterrupt)
    (cons 'LookupError 'py-builtin-LookupError)
    (cons 'MemoryError 'py-builtin-MemoryError)
    (cons 'ModuleNotFoundError 'py-builtin-ModuleNotFoundError)
    (cons 'NameError 'py-builtin-NameError)
    (cons 'NotADirectoryError 'py-builtin-NotADirectoryError)
    (cons 'NotImplementedError 'py-builtin-NotImplementedError)
    (cons 'OSError 'py-builtin-OSError)
    (cons 'OverflowError 'py-builtin-OverflowError)
    (cons 'PendingDeprecationWarning 'py-builtin-PendingDeprecationWarning)
    (cons 'PermissionError 'py-builtin-PermissionError)
    (cons 'ProcessLookupError 'py-builtin-ProcessLookupError)
    (cons 'RecursionError 'py-builtin-RecursionError)
    (cons 'ReferenceError 'py-builtin-ReferenceError)
    (cons 'ResourceWarning 'py-builtin-ResourceWarning)
    (cons 'RuntimeError 'py-builtin-RuntimeError)
    (cons 'RuntimeWarning 'py-builtin-RuntimeWarning)
    (cons 'StopAsyncIteration 'py-builtin-StopAsyncIteration)
    (cons 'StopIteration 'py-builtin-StopIteration)
    (cons 'SyntaxError 'py-builtin-SyntaxError)
    (cons 'SyntaxWarning 'py-builtin-SyntaxWarning)
    (cons 'SystemError 'py-builtin-SystemError)
    (cons 'SystemExit 'py-builtin-SystemExit)
    (cons 'TabError 'py-builtin-TabError)
    (cons 'TimeoutError 'py-builtin-TimeoutError)
    (cons 'TypeError 'py-builtin-TypeError)
    (cons 'UnboundLocalError 'py-builtin-UnboundLocalError)
    (cons 'UnicodeDecodeError 'py-builtin-UnicodeDecodeError)
    (cons 'UnicodeEncodeError 'py-builtin-UnicodeEncodeError)
    (cons 'UnicodeError 'py-builtin-UnicodeError)
    (cons 'UnicodeTranslateError 'py-builtin-UnicodeTranslateError)
    (cons 'UnicodeWarning 'py-builtin-UnicodeWarning)
    (cons 'UserWarning 'py-builtin-UserWarning)
    (cons 'ValueError 'py-builtin-ValueError)
    (cons 'Warning 'py-builtin-Warning)
    (cons 'ZeroDivisionError 'py-builtin-ZeroDivisionError)))

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
    '(define_semantics use_static_builtins use_simple_scoping absent)))

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
  (check-invalid-intrinsics intrinsics)
  (check-no-intrinsics-assignation this intrinsics)
  (resolve-statics!
    this
    intrinsics
    (make-intrinsics-assoc-list intrinsics static-intrinsics)
    (make-intrinsics-assoc-list intrinsics macro-intrinsics)
    #f)
  (if (member 'use_simple_scoping intrinsics)
    (mark-use-simple-scoping! this))
  (if (member 'define_semantics intrinsics)
    (begin
      (mark-define-semantics! this #f)
      (lambda-lift-semantics! this)))
  this)

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

(define-walk-method (mark-define-semantics! this::PycNode parent-semantics)
  (call-default-walker))

(define-walk-method (mark-define-semantics! this::PycFun parent-semantics)
  (let* ((decorators (PycFun-decorators this))
        (is-decorated-semantics (contains-PycRef-with-name? decorators 'define_semantics)))
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
            (name (PycFun-name res)))
        (new-PycSemantics
          loc
          args
          posonlyargs
          vararg
          kwonlyargs
          kw-defaults
          kwarg
          defaults
          (mark-define-semantics! body #t)
          decorators:
            (list-remove-pred
              decorators
              (lambda (d)
                (or (PycRef-with-name? d 'use_simple_scoping)
                    (PycRef-with-name? d 'define_semantics))))
          decls: decls
          use-simple-scoping: #t
          name: (if is-decorated-semantics (symbol-append 'py- name) name)))
      (call-default-walker))))

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
        (lifted-semantics (get-lifted-semantics* (PycFun-body sem) (PycFun-name sem) cte)))
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
        (new-PycMacro
          loc
          new-name
          new-name
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

(define-walk-method (get-lifted-semantics* this::PycNode parent-name cte)
  (call-default-walker))

(define-walk-method (get-lifted-semantics* this::PycSemantics parent-name cte)
  (let* ((loc (PycNode-loc this))
        (sem-cte (collect-semantics-decls* this #t))
        (sem-refs (collect-semantics-refs* this #t))
        (lifted-vars (get-variables-to-lift cte sem-cte sem-refs)))
    (PycFun-args-set!
      this
      (append
        (map (lambda (name) (new-PycDecl loc name 'local)) lifted-vars)
        (PycFun-args this)))
    (list
      (list
        this ;; semantics
        (PycFun-name this) ;; old name
        (symbol-append parent-name '- (PycFun-name this)) ;; new name
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

;; collect-semantics-refs*

(define-walk-method (collect-semantics-refs* this::PycNode search-nested-semantics)
  (call-default-walker))

(define-walk-method (collect-semantics-refs* this::PycSemantics search-nested-semantics)
  (if search-nested-semantics
    (call-default-walker)
    '()))

(define-walk-method (collect-semantics-refs* this::PycRefUnresolved search-nested-semantics)
  (list (PycRefUnresolved-id this)))

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
