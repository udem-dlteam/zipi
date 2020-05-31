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

(define static-intrinsics
  (list
    (cons 'absent 'py-absent)))

;; TODO: generate a full table of builtins with Zipi rts name
(define static-builtins
  (list
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
  (list->table static-builtins))

(define valid-intrinsics
  (append
    (map car static-intrinsics)
    '(define_semantics use_static_builtins use_simple_scoping class_getattr absent)))

(define (make-static-intrinsics-table intrinsics)
  (let ((used-statics
          (let loop ((intrinsics intrinsics))
            (if (null? intrinsics)
              '()
              (let ((pair (assoc (car intrinsics) static-intrinsics)))
                (if pair
                  (cons pair (loop (cdr intrinsics)))
                  (loop (cdr intrinsics))))))))
    (list->table used-statics)))

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
    (make-static-intrinsics-table intrinsics)
    #f)
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

(define-walk-method (resolve-statics! this::PycNode instrinsics statics-table use-static-builtins)
  (call-default-walker))

(define-walk-method (resolve-statics! this::PycRefUnresolved intrinsics statics-table use-static-builtins)
  (let* ((id (PycRefUnresolved-id this))
        (static-value
          (or
            (table-ref statics-table id #f)
            (and
              use-static-builtins
              (table-ref static-builtins-table id #f)))))
    (if static-value
      (let ((loc (PycNode-loc this)))
        (new-PycStatic loc id static-value))
      this)))

(define-walk-method (resolve-statics! this::PycFun intrinsics statics-table use-static-builtins)
  (define (use_static_builtins-PycRef? x)
    (and (PycRefUnresolved? x) (eq? (PycRefUnresolved-id x) 'use_static_builtins)))

  (define (use_static_builtins-PycRef-contains? lst)
    (cond
      ((null? lst)
        #f)
      ((use_static_builtins-PycRef? (car lst))
        #t)
      (else
        (use_static_builtins-PycRef-contains? (cdr lst)))))

  (let ((decorators (PycFun-decorators this)))
    (if (or use-static-builtins
            (and
              (member 'use_static_builtins intrinsics)
              (use_static_builtins-PycRef-contains? decorators)))
      (let* ((body (PycFun-body this))
            (new-body (resolve-statics! body intrinsics statics-table #t)))
        (PycFun-decorators-set! this (list-remove-pred decorators use_static_builtins-PycRef?))
        (PycFun-body-set! this new-body)
        this)
      (call-default-walker))))
