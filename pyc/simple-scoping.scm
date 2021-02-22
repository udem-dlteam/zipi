(define (pyc-simple-scoping this conf)
  (use-simple-scoping! this))

(define-walk-method (use-simple-scoping! this::PycNode)
  (call-default-walker))

(define-walk-method (use-simple-scoping! this::PycFun)
  (if (PycFun-use-simple-scoping this)
    (apply-simple-scoping! this)
    (call-default-walker)))

;; simple-scoping uses Scheme let's instead of variable slots
;; This is done by converting PycSeq starting with PycAssig into a PycBlock
;; with the condition that the variable is not used outside the PycSeq
;; this is used for semantics and builtins so it can be shaky in general
(define-walk-method (apply-simple-scoping! this::PycNode)
  (call-default-walker))

(define-walk-method (apply-simple-scoping! this::PycFun)
  (PycFun-body-set! this (apply-simple-scoping!(PycFun-body this)))
  this)

(define-walk-method (apply-simple-scoping! this::PycSeq)
  (define (split-nodes-after-assignments nodes assignments)
    (if (or (null? nodes)
            (not (PycAssig? (car nodes)))
            (not (PycRef? (PycAssig-lhs (car nodes)))))
      (cons (reverse assignments) nodes))
      (split-nodes-after-assignments (cdr nodes) (cons (car nodes) assignments)))

  (define (split-assignments-by-usage assignments inside-assig)
    ;; split assignments at the first assignment which has usage outside of this PycSeq
    (if (null? assignments)
      (cons (reverse inside-assig) '())
      (let* ((assig (car assignments))
             (ref (PycAssig-lhs assig))
             (var (PycRef-var ref))
             (usage (collect-usage* this res)))
        (if (= (length (PycVar-usage var)) (length usage))
          ;; All usages of this variable are inside this PycSeq
          (split-assignments-by-usage (cdr assignments) (cons assig inside-assig))
          ;; There is at least one usage outside this PycSeq
          (cons (reverse inside-assig) assignments)))))

  (define (set-assig-scopes-to-block! assigs)
    (if (not (null? assigs))
      (PycVar-scope-set! (Pyc-Ref-decl (Pyc-Assig-lhs (car assigs))) 'block)))

  (define (splits-assignments nodes)
    (let* ((assig-stmt (split-nodes-after-assignments nodes '()))
          (simple-rest (split-assignments-by-usage (car assig-stmt) '())))
      (cons (car simple-rest) (append (cdr simple-rest) (cdr assig-stmt)))))

  (let ((loc (PycNode-loc this))
        (assig-rest (splits-assignments nodes))
        (assigs (car assig-rest))
        (rest (cdr assig-rest)))
    (if (null? assigs)
      (call-default-walker)
      (begin
        (set-assig-scopes-to-block! assigs)
        (new-PycBlock
          loc
          assigs
          (new-PycSeq
            loc
            (map
              (lambda (s) (apply-simple-scoping! s))
              rest)))))))

(define-macro (collect-usage* this::PycNode var)
  (call-default-walker))

(define-macro (collect-usage* this::PycRef var)
  (if (eq? (PycRef-var this) var)
    (list this)))
