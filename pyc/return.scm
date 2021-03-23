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
    ((PycStmt? node)
      (PycStmt-need-return-set! node value))
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

(define-walk-method (remove-unreachable this::PycTry found-path-to-next-ref)
  (let ((body (PycTry-body this))
        (handlers (PycTry-handlers this))
        (else_ (PycTry-else this))
        (finally (PycTry-finally this))
        (body-found-path-to-next-ref (cons #t '()))
        (handlers-found-path-to-next-ref (cons #t '()))
        (else-found-path-to-next-ref (cons #t '()))
        (finally-found-path-to-next-ref (cons #t '())))
    (remove-unreachable body body-found-path-to-next-ref)
    (for-each
      (lambda (h) (remove-unreachable h handlers-found-path-to-next-ref))
      handlers)
    (if (not (PycPass? else_))
      (remove-unreachable else_ else-found-path-to-next-ref)
      (set-car! else-found-path-to-next-ref #f))
    (if (not (PycPass? finally))
      (remove-unreachable finally finally-found-path-to-next-ref))
    (if (or (not (car finally-found-path-to-next-ref))
            (and (not (car body-found-path-to-next-ref))
                 (not (car handlers-found-path-to-next-ref))
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
(define-walk-method (return this::PycNode block tail conf)
   (call-default-walker))

(define-walk-method (return this::PycStmt block tail conf)
   (call-default-walker))

(define-walk-method (return this::PycSeq block tail conf)
   (let loop ((nodes (PycSeq-nodes this)))
      (cond
	 ((null? (cdr nodes))
	  (return (car nodes) block tail conf))
	 ((PycReturn? (car nodes))
	  (set-cdr! nodes '())
	  (return (car nodes) block tail conf))
   ((PycRaise? (car nodes))
    (set-cdr! nodes '())
    ;; Is this needed? There can be no return inside a raise
    (return (car nodes) block tail conf))
	 (else
	  (return (car nodes) block #f conf)
	  (loop (cdr nodes))))))

(define-walk-method (return this::PycReturn block tail conf)
   (when (and block (not tail))
      (need-return-set! block #t)
      (PycReturn-tail-set! this #f)))

;; try statements are a special case for two reasons
;;   1) a finally block will capture the return of other blocks
;;   2) try-except-else-finally are chaining, not branching
;; For these reasons, when there is a finally block, the return must be bound to
;; the finally block, not to the function, but the finally block must still
;; delegate the returned value to the function if it did no return of its own
(define-walk-method (return this::PycTry block tail conf)
  (let* ((has-else (not (PycPass? (PycTry-else this))))
        (finally-block (PycTry-finally this))
        (has-finally (not (PycPass? finally-block)))
        (body-tail (and tail (not (or has-else has-finally))))
        (handlers/else-tail (and tail (not has-finally))))
    (return
      (PycTry-body this)
      (if has-finally this block)
      body-tail
      conf)
    (for-each
      (lambda (h)
        (return
          h
          (if has-finally this block)
          handlers/else-tail
          conf))
      (PycTry-handlers this))
    (if has-else
      (return
        (PycTry-else this)
        (if has-finally this block)
        handlers/else-tail
        conf))
    (if has-finally
      ;; we do not consider finally to be a tail block due to the complexity of
      ;; the code to generate in that case
      (return finally-block finally-block #f conf))
    (PycTry-tail-set! this tail)
    (if (and (PycStmt-need-return this) (not tail))
      (need-return-set! block #t))))

(define-walk-method (return this::PycFun block tail conf)
   (return (PycFun-body this) this #t conf))

(define-walk-method (return this::PycLoop block tail conf)
   (return (PycLoop-body this) block #f conf))

(define-walk-method (return this::PycFor block tail conf)
   (return (PycLoop-body this) block #f conf)
   (return (PycFor-target this) block #f conf)
   (return (PycFor-iter this) block #f conf))

(define-walk-method (return this::PycWhile block tail conf)
   (return (PycLoop-body this) block #f conf)
   (return (PycWhile-test this) block #f conf))
