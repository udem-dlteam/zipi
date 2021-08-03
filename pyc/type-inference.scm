(define (pyc-type-inference this conf)
  (type-inference* this '())
  this)

(define LITERAL_POINTS 10)

#;(define old-val 0)

(define-walk-method (type-inference* this::PycNode table)
  (call-default-walker))

(define (type-set! node type)
  (PycExpr-type-set! node type))

(define (append-type table var type)
  (let ((var-table (assq var table)))
    (if var-table
        (begin
          (set-cdr! var-table type)
          table)
        (cons (cons var type) table))
    )
  )

(define (combine-types type1 type2)
  (if type1
      (if type2
          type1 ;; for now we default to taking the first one
          type1)
      type2))

(define-macro (define-literal-type-inference node type)
  `(define-walk-method (type-inference* ,node table)
     (type-set! this ,type)
     table))

(define-literal-type-inference this::PycBool 'bool)
(define-literal-type-inference this::PycString 'str)
(define-literal-type-inference this::PycList 'list)
(define-literal-type-inference this::PycTuple 'tuple)
(define-literal-type-inference this::PycDict 'dict)
(define-literal-type-inference this::PycSet 'set)

(define-walk-method (type-inference* this::PycLiteralValue table)
  (let ((val (PycLiteralValue-val this)))
    (cond
     ((fixnum? val) (type-set! this 'sint))
     ((flonum? val) (type-set! this 'float))))
  table)

(define-walk-method (type-inference* this::PycBinary table)
  (let* ((rhs (PycBinary-rhs this))
         (lhs (PycBinary-lhs this)))

    (type-inference* rhs table)
    (type-inference* lhs table)

    (let ((type-rhs (PycExpr-type rhs))
          (type-lhs (PycExpr-type lhs)))

      (type-set! this (combine-types type-rhs type-lhs))
      table)))

(define-walk-method (type-inference* this::PycAssig table)
  (let* ((lhs (PycAssig-lhs this))
         (rhs (PycAssig-rhs this))
         (_ (type-inference* rhs table))
         (type (PycExpr-type rhs)))
    (if (PycRef? lhs)
        (if type
            (append-type table (PycRef-decl lhs) type)
            table)
        table)))

(define-walk-method (type-inference* this::PycSeq table)
  (let loop ((nodes (PycSeq-nodes this))
             (table table))
    (if (null? nodes)
        table
        (loop (cdr nodes) (type-inference* (car nodes) table)))))

(define-walk-method (type-inference* this::PycModule table)
  (let loop ((nodes (PycModule-stmts this))
             (table table))
    (if (null? nodes)
        table
        (loop (cdr nodes) (type-inference* (car nodes) table)))))

(define-walk-method (type-inference* this::PycRef table)
  (let* ((var (PycRef-decl this))
         (type (assq var table)))
    (if type
        (type-set! this (cdr type))))
  table)

(define-walk-method (type-inference* this::PycSemantics table)
  table)

(define (list-union l1 l2)
  (cond
   ((null? l1) '())
   ((memq (car l1) l2)
    (list-union (cdr l1) l2))
   (else (cons (car l1)
               (list-union (cdr l1) l2)))))

(define-walk-method (type-inference* this::PycIf table)
  (let ((test (PycIf-test this))
        (then (PycIf-then this))
        (orelse (PycIf-else this)))
    (type-inference* test table)
    (list-union
     (type-inference* then table)
     (type-inference* orelse table))))
