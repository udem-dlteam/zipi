;; annotate return statements with tail/notail information
;; annotation function definitions with need-return values
(define (pyc-return this conf)
   (add-implicit-return-none this)
   (remove-unreachable this (cons #t '()))
   (return this #f #t conf)
   this)

(define (last-cdr lst)
  (if (null? (cdr lst))
    lst
    (last-cdr (cdr lst))))

(define (need-return-set! node value)
  (cond
    ((PycFun? node)
      (PycFun-need-return-set! node value))
    (else
      (error "need-return-set!" "cannot set need return" node))))

(define-walk-method (add-implicit-return-none this::PycNode)
  (call-default-walker))

(define-walk-method (add-implicit-return-none this::PycFun)
  (let* ((body (PycFun-body this))
         (seq
           (cond
             ((PycBlock? body) (PycBlock-body body))
             ((PycSeq? body) body)
             (else (error "add-implicit-return-none::PycFun" "unknown body type" body))))
         (nodes (PycSeq-nodes seq))
         (tail (last-cdr nodes))
         (loc (PycNode-loc (car tail))))
    (add-implicit-return-none body)
    ;; add "return None" to all functions tail
    ;; this return will later be removed if it is unreachable
    (set-cdr! tail (list (new-PycReturn loc (new-PycNone loc #f))))))

(define-walk-method (remove-unreachable this::PycNode found-path-to-next-ref)
  (call-default-walker))

(define-walk-method (remove-unreachable this::PycSeq found-path-to-next-ref)
  (let loop ((nodes (PycSeq-nodes this)))
    (if (not (null? nodes))
      (let ((node-found-path-to-next-ref (cons #t '())))
        (remove-unreachable (car nodes) node-found-path-to-next-ref)
        (if (car node-found-path-to-next-ref)
          (loop (cdr nodes))
          (begin
            (set-car! found-path-to-next-ref #f)
            (set-cdr! nodes '())))))))

(define-walk-method (remove-unreachable this::PycIf found-path-to-next-ref)
  (let ((then-found-path-to-next-ref (cons #t '()))
        (else-found-path-to-next-ref (cons #t '())))
    (remove-unreachable (PycIf-then this) then-found-path-to-next-ref)
    (remove-unreachable (PycIf-else this) else-found-path-to-next-ref)
    (if (and (not (car then-found-path-to-next-ref))
             (not (car else-found-path-to-next-ref)))
      (set-car! found-path-to-next-ref #f))))

(define-walk-method (remove-unreachable this::PycLoop found-path-to-next-ref)
  ;; TODO incomplete detection, need info on break/continue
  ;; for this reason we just consider the next block as reachable
  (let ((loop-found-path-to-next-ref (cons #t '()))
        (else-found-path-to-next-ref (cons #t '())))
    (remove-unreachable (PycLoop-body this) loop-found-path-to-next-ref)
    (remove-unreachable (PycLoop-body this) else-found-path-to-next-ref)))

(define-walk-method (remove-unreachable this::PycTry found-path-to-next-ref)
  (let* ((body (PycTry-body this))
        (handlers (PycTry-handlers this))
        (else_ (PycTry-else this))
        (finally (PycTry-finally this))
        (body-found-path-to-next-ref (cons #t '()))
        (handlers-found-path-to-next-ref (map (lambda (_) (cons #t '())) handlers))
        (else-found-path-to-next-ref (cons #t '()))
        (finally-found-path-to-next-ref (cons #t '())))
    (remove-unreachable body body-found-path-to-next-ref)
    (for-each
      (lambda (h fp) (remove-unreachable h fp))
      handlers
      handlers-found-path-to-next-ref)
    (if (not (PycPass? else_))
      (remove-unreachable else_ else-found-path-to-next-ref)
      (set-car! else-found-path-to-next-ref #f))
    (if (not (PycPass? finally))
      (remove-unreachable finally finally-found-path-to-next-ref))
    (if (or (not (car finally-found-path-to-next-ref))
            (and (not (car body-found-path-to-next-ref))
                 (or (null? handlers)
                     (not (fold (lambda (l r) (or l r)) #f (map car handlers-found-path-to-next-ref))))
                 (not (car else-found-path-to-next-ref))))
      (set-car! found-path-to-next-ref #f))))

(define-walk-method (remove-unreachable this::PycFun _)
  (remove-unreachable (PycFun-body this) (cons #t '())))

(define-walk-method (remove-unreachable this::PycClass _)
  (remove-unreachable (PycClass-body this) (cons #t '())))

(define-walk-method (remove-unreachable this::PycReturn found-path-to-next-ref)
  (set-car! found-path-to-next-ref #f))

(define-walk-method (remove-unreachable this::PycRaise found-path-to-next-ref)
  (set-car! found-path-to-next-ref #f))

(define-walk-method (remove-unreachable this::PycBreak found-path-to-next-ref)
  (set-car! found-path-to-next-ref #f))

(define-walk-method (remove-unreachable this::PycContinue found-path-to-next-ref)
  (set-car! found-path-to-next-ref #f))

;; Traverse the AST to mark all non-tail returns and mark the functions
;; that use such returns
(define-walk-method (return this::PycNode fun tail conf)
   (call-default-walker))

(define-walk-method (return this::PycStmt fun tail conf)
   (call-default-walker))

(define-walk-method (return this::PycSeq fun tail conf)
  (let loop ((nodes (PycSeq-nodes this)))
    (if (null? (cdr nodes))
      (return (car nodes) fun tail conf)
      (begin
        (return (car nodes) fun #f conf)
        (loop (cdr nodes))))))

(define-walk-method (return this::PycReturn fun tail conf)
  (when (and fun (not tail))
    (need-return-set! fun #t)
    (PycReturn-tail-set! this #f)))

(define-walk-method (return this::PycTry fun tail conf)
  (let ((has-else (not (isa? (PycTry-else this) PycPass)))
        (has-finally (not (isa? (PycTry-finally this) PycPass))))
    (return (PycTry-body this) fun (and (not has-finally) tail) conf)
    (return (PycTry-else this) fun (and (not has-finally) tail) conf)
    (for-each
      (lambda (h)
        (return
          h
          fun
          (and (not (or has-else has-finally)) tail)
          conf))
      (PycTry-handlers this))
    (return (PycTry-finally this) fun #f conf))) ;; finally is never tail because it may need to interrupt unwind to return

(define-walk-method (return this::PycFun fun tail conf)
   (return (PycFun-body this) this #t conf))

(define-walk-method (return this::PycFor fun tail conf)
   (return (PycLoop-body this) fun #f conf)
   (return (PycLoop-else this) fun tail conf)
   (return (PycFor-target this) fun #f conf)
   (return (PycFor-iter this) fun #f conf))

(define-walk-method (return this::PycWhile fun tail conf)
   (return (PycLoop-body this) fun #f conf)
   (return (PycLoop-else this) fun tail conf)
   (return (PycWhile-test this) fun #f conf))
