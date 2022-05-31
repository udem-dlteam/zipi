;; =====================================================================
;; Predicates
;; =====================================================================

  (define probably-mro-fields
    '(
      ;; list methods
      append clear copy count extend index insert pop remove reverse sort
      ;; magic attributes
      __add__ __radd__ __iadd__
      __sub__ __rsub__ __isub__
      __mul__ __rmul__ __imul__
      __matmul__ __rmatmul__ __imatmul__
      __truediv__ __rtruediv__ __itruediv__
      __floordiv__ __rfloordiv__ __ifloordiv__
      __mod__ __rmod__ __imod__
      __divmod__ __rdivmod__
      __pow__ __rpow__ __ipow__
      __lshift__ __rlshift__ __ilshift__
      __rshift__ __rrshift__ __irshift__
      __and__ __rand__ __iand__
      __xor__ __rxor__ __ixor__
      __or__ __ror__ __ior__
      __neg__ __pos__ __abs__ __invert__
      __complex__ __int__ __float__ __index__ __bool__
      __repr__ __str__ __bytes__ __format__
      __round__ __trunc__ __floor__ __ceil__
      __eq__ __ne__ __lt__ __le__ __gt__ __ge__
      __call__
      __get__ __set__ __delete__
      __getattribute__ __getattr__ __setattr__
      __getitem__ __setitem__ __delitem__ __missing__
      __iter__ __next__ __reversed__ __contains__
      __len__ __length_hint__
      __hash__ __dir__
      __new__ __init__))

(define builtin-classes
  '(ArithmeticError AssertionError AttributeError BaseException BlockingIOError BrokenPipeError BufferError BytesWarning
    ChildProcessError ConnectionAbortedError ConnectionError ConnectionRefusedError ConnectionResetError DeprecationWarning
    EOFError EnvironmentError Exception FileExistsError FileNotFoundError FloatingPointError FutureWarning GeneratorExit
    IOError ImportError ImportWarning IndentationError IndexError InterruptedError IsADirectoryError KeyError KeyboardInterrupt
    LookupError MemoryError ModuleNotFoundError NameError NotADirectoryError NotImplementedError OSError OverflowError
    PendingDeprecationWarning PermissionError ProcessLookupError RecursionError ReferenceError ResourceWarning RuntimeError
    RuntimeWarning StopAsyncIteration StopIteration SyntaxError SyntaxWarning SystemError SystemExit TabError TimeoutError
    TypeError UnboundLocalError UnicodeDecodeError UnicodeEncodeError UnicodeError UnicodeTranslateError UnicodeWarning
    UserWarning ValueError Warning ZeroDivisionError __loader__ bool bytearray bytes classmethod complex dict enumerate
    filter float frozenset int list map memoryview object property range reversed set slice staticmethod str super tuple
    type zip))

  (define (guess-access-types access)
    ;; heuristic:
    ;; First - Try to guess what the object being accessed is, this is what yields the most information.
    ;;         In case of variables (PycRef and PycRefUnresolved), it is sometimes possible to guess their
    ;;         origin. For example, this is most easily done in the case of classes, builtins and imports
    ;; Second - If the above fails, use the name of the attribute as a hint. Some names such as magic methods'
    ;;          names or common method names such as 'append', 'pop', etc., are usually used to access a bound
    ;;          method found in the mro
    ;; Third  - If the above also fails, see what is being done with the attribute. Whether it is used in a
    ;;          call, an unary or binary operation, etc. gives a hint as to its values. Function are most likely
    ;;          found in mro/on types while numbers are most likely to be found on objects
    ;; Fourth - If all fails, use a default priority which works as often as possible

    (define default-priority '(object mro))
    (define probably-mro-priority '(mro type))
    (define probably-builtin-class-priority '(type))
    (define probably-builtin-non-class-priority '(object))
    (define probably-module-priority '(module))
    (define probably-type-priority '(type))
    (define callable-attribute-priority '(mro type))
    (define arithmetic-operand-priority '(object mro type))

    (define (guess-access-type-PycRef obj field)
      (let* ((var (PycRef-decl obj))
             (assigs (PycVar-assig var)))
        (if (null? assigs)
          (guess-access-type-no-origin obj field)
          (let ((last-assig (PycAssig-rhs (car assigs)))) ;; last time I checked this is the last syntactical assig in the file
            (cond
              ((isa? last-assig PycClass)
                probably-type-priority)
              ((isa? last-assig PycImport)
                probably-module-priority)
              (else
                (guess-access-type-no-origin obj field)))))))

    (define (guess-access-type-PycRefUnresolved obj field)
      (if (memq (PycRefUnresolved-id obj) builtin-classes)
        probably-builtin-class-priority
        probably-builtin-non-class-priority))

    (define (guess-access-type-no-origin obj field)
      (cond
        ((memq field probably-mro-fields)
          probably-mro-priority)
        ((eq? field '__name__)
          '(type object module)) ;; usually on types, function or modules
        (else
          (guess-access-type-from-usage obj field))))

    (define (guess-access-type-from-usage obj field)
      (let ((usage (PycAccess-usage access)))
        (cond
          ((isa? usage PycCall)
            callable-attribute-priority)
          ((isa? usage PycBinary)
            arithmetic-operand-priority)
          ((isa? usage PycUnary)
            arithmetic-operand-priority)
          (else
            default-priority))))

    (let ((obj (PycAccess-obj access))
          (field (PycAccess-field access)))
      (cond
        ((isa? obj PycRef) (guess-access-type-PycRef obj field))
        ((isa? obj PycRefUnresolved) (guess-access-type-PycRefUnresolved obj field))
        (else (guess-access-type-no-origin obj field)))))

(define-predicate (in-semantics? access conf params)
  (let ((current-fun (config-get conf fun:)))
    (and current-fun (isa? current-fun PycSemantics))))

;; =====================================================================
;; Code generation
;; =====================================================================

(define (default-cached-access access conf params)
  (if (in-semantics? access conf params)
    ;; no caches exist for semantics
    ;; attributes used in semantics should have special slots
    (epairify access
      `(py-getattribute-fallback
        ,(scheme (PycAccess-obj access) conf)
        ,(pyc-propname (PycAccess-field access))))
    (epairify access
      `(py-getattribute-cached
        ,(scheme (PycAccess-obj access) conf)
        ,(pyc-propname (PycAccess-field access))
        ,(scheme-cache (PycAccess-cache access) access)
        ,(guess-access-types access)))))

;; Dispatch

(define-compilation-to-scheme (access-to-scheme access conf params)
  (else
    (default-cached-access access conf params)))

(define (PycAccess-to-scheme access conf . rest)
  (if (> (length rest) 1) (error "PycAccess-to-scheme" "takes 3 arguments" (length rest)))

  (let ((params (if (> (length rest) 0) (list-ref rest 0) '())))
    (access-to-scheme access conf params)))
