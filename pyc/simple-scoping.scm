(define (pyc-simple-scoping this conf)
  (use-simple-scoping! this))

(define-walk-method (use-simple-scoping! this::PycNode)
  (call-default-walker))

(define-walk-method (use-simple-scoping! this::PycFun)
  (if (PycFun-use-simple-scoping this)
    (apply-simple-scoping! this this '())
    (call-default-walker)))

(define (add-block-ref-to-decl decl block)
  (PycDeclInit-simple-scoping-top-block-set! decl block))

(define (list-remove lst x)
  (cond
    ((null? lst)
      '())
    ((eq? (car lst) x)
      (cdr lst))
    (else
      (cons (car lst) (list-remove (cdr lst) x)))))

(define (remove-decl-from-old-block decl)
  (let ((block (PycDeclInit-simple-scoping-top-block decl)))
    (PycBlock-decls-set!
      block
      (list-remove (PycBlock-decls block) decl))
    (PycDeclInit-simple-scoping-top-block-set! decl #f)))

(define-walk-method (apply-simple-scoping! this::PycNode fun locals)
  (call-default-walker))

(define-walk-method (apply-simple-scoping! this::PycFun fun locals)
  (PycFun-body-set!
    this
    (apply-simple-scoping!
      (PycFun-body this)
      fun
      locals))
  this)

(define-walk-method (apply-simple-scoping! this::PycBlock fun locals)
  (for-each (lambda (d) (add-block-ref-to-decl d this)) (PycBlock-decls this))
  (PycBlock-body-set!
    this
    (apply-simple-scoping!
      (PycBlock-body this)
      fun
      (append
        (PycBlock-decls this)
        locals)))
  this)

(define-walk-method (apply-simple-scoping! this::PycSeq fun locals)
  (let loop ((nodes (PycSeq-nodes this)))
    (if (null? nodes)
      (call-default-walker)
      (let ((head (car nodes)))
        (if (PycAssig? head)
          (let ((lhs (PycAssig-lhs head)))
            (if (PycRef? lhs)
              (let ((decl (PycRef-decl lhs)))
                (if (and
                       (memq decl locals)
                       (can-drop-decl fun decl head))
                  (let* ((tail (cdr nodes))
                        (loc (PycNode-loc head))
                        (tail-block
                          (new-PycBlock
                            loc
                            (list decl)
                            (new-PycSeq loc tail))))
                    (PycDeclInit-val-set! decl (PycAssig-rhs head))
                    (set-car! nodes tail-block)
                    (set-cdr! nodes '())
                    (remove-decl-from-old-block decl)
                    (call-default-walker))
                (call-default-walker)))
              (call-default-walker)))
          (call-default-walker))))))

;; Using a let-block instead of an initialisation requires that the variable
;; be used nowhere outside the let block. This is a very restrictive condition
;; which may possibily be improved in the future
(define (can-drop-decl this from-decl to-assign)
  (call/cc
    (lambda (cc)
      (no-parallel-usage this from-decl to-assign (lambda () (cc #f)))
      #t)))

(define-walk-method (no-parallel-usage this::PycNode from-decl to-assign fail)
  (call-default-walker))

(define-walk-method (no-parallel-usage this::PycRef from-decl to-assign fail)
  (if (eq? (PycRef-decl this) from-decl)
    (fail)
    (call-default-walker)))

(define-walk-method (no-parallel-usage this::PycSeq from-decl to-assign fail)
  (let loop ((nodes (PycSeq-nodes this)))
    (if (null? nodes)
      #t ;; do nothing
      (let ((head (car nodes)))
        (if (eq? head to-assign)
          #t ;; do nothing
          (begin
            (no-parallel-usage head from-decl to-assign fail)
            (loop (cdr nodes))))))))
