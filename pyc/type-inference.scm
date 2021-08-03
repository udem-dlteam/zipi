(define (pyc-type-inference this conf)
  (type-inference* this '())
  this)

(define (type-set! node type)
  (PycExpr-type-set! node type))

(define (append-type table var type)
  (list (cons var type)))

(define (combine-types type1 type2)
  (if type1
      (if type2
          type1 ;; for now we default to taking the first one
          type1)
      type2))

(define (list-union l1 l2)
  (cond
   ((null? l1) l2)
   ((memq (car l1) l2)
    (list-union (cdr l1) l2))
   (else (cons (car l1)
               (list-union (cdr l1) l2)))))


(define-walk-method (type-inference* this::PycNode table)
  (call-default-walker))

(define-macro (define-literal-type-inference node type)
  `(define-walk-method (type-inference* ,node table)
     (type-set! this ,type)
     '()))

(define-literal-type-inference this::PycBool   'bool)
(define-literal-type-inference this::PycString 'str)
(define-literal-type-inference this::PycList   'list)
(define-literal-type-inference this::PycTuple  'tuple)
(define-literal-type-inference this::PycDict   'dict)
(define-literal-type-inference this::PycSet    'set)

(define-walk-method (type-inference* this::PycNumber table)
  (let ((val (PycLiteralValue-val this)))
    (cond
     ((fixnum? val) (type-set! this 'sint))
     ((flonum? val) (type-set! this 'float))))
  '())

(define-walk-method (type-inference* this::PycBinary table)
  (let* ((rhs (PycBinary-rhs this))
         (lhs (PycBinary-lhs this))
         (table-rhs (type-inference* rhs table))
         (table-lhs (type-inference* lhs table))
         (type-rhs (PycExpr-type rhs))
         (type-lhs (PycExpr-type lhs)))

    (type-set! this (combine-types type-rhs type-lhs))
    (list-union table-rhs table-lhs)))


(define-walk-method (type-inference* this::PycAssig table)
  (let* ((lhs (PycAssig-lhs this))
         (rhs (PycAssig-rhs this))
         (table-rhs (type-inference* rhs table))
         (type (PycExpr-type rhs)))
    (if (and (PycRef? lhs) type)
        (list-union (append-type table (PycRef-decl lhs) type) table-rhs)
        table-rhs)))

(define-walk-method (type-inference* this::PycSeq table)
  (let loop ((nodes (PycSeq-nodes this))
             (table table))
    (if (null? nodes)
        table
        (loop (cdr nodes)
              (list-union (type-inference* (car nodes) table) table)))))

(define-walk-method (type-inference* this::PycModule table)
  (let loop ((nodes (PycModule-stmts this))
             (table table))
    (if (null? nodes)
        table
        (loop (cdr nodes)
              (list-union table (type-inference* (car nodes) table))))))

(define-walk-method (type-inference* this::PycRef table)
  (let* ((var (PycRef-decl this))
         (type (assq var table)))
    (if type
        (type-set! this (cdr type))))
  (call-default-walker))

(define-walk-method (type-inference* this::PycSemantics table)
  (call-default-walker))

(define-walk-method (type-inference* this::PycIf table)
  (let ((test (PycIf-test this))
        (then (PycIf-then this))
        (orelse (PycIf-else this)))
    (type-inference* test table)
    (list-union
     (type-inference* then table)
     (type-inference* orelse table))))


(define-walk-method (type-inference* this::PycFun table)
  (call-default-walker)
  '())
