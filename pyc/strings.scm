(define (pyc-strings module conf)
  (define (stringify s)
    ;; some strings are stored as symbols in ast
    (if (string? s) s (symbol->string s)))

  (let ((strings (uniq (map stringify (collect-strings* module)))))
    (PycModule-strings-set! module strings)
    module))

(define-walk-method (collect-strings* this::PycNode)
  (call-default-walker))

(define-walk-method (collect-strings* this::PycString)
  (list (PycLiteralValue-val this)))

(define-walk-method (collect-strings* this::PycAccess)
  (cons (PycAccess-field this) (call-default-walker)))

(define-walk-method (collect-strings* this::PycClass)
  (cons (PycClass-name this) (cons (PycClass-module this) (call-default-walker))))

(define-walk-method (collect-strings* this::PycVar)
  (list (PycVar-id this)))

(define-walk-method (collect-strings* this::PycRefUnresolved)
  (list (PycRefUnresolved-id this)))
