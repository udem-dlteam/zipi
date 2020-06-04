;; annotate return statements with tail/notail information
;; annotation function definitions with need-return values
(define (pyc-return this conf)
   (add-implicit-return-none this)
   (return this #f #t conf)
   this)

(define (last-cdr lst)
  (if (null? (cdr lst))
    lst
    (last-cdr (cdr lst))))

(define (need-return-set! node value)
  (cond
    ((PycTry? node)
      (PycTry-need-return-set! node value))
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
    ;; add "return None" to all functions tail
    ;; this return will later be removed if it is unreachable
    (set-cdr! tail (list (new-PycReturn loc (new-PycNone loc #f))))))


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
   (when (and (PycFun? block) (not tail))
      (need-return-set! block #t)
      (PycReturn-tail-set! this #f)))

;; try statements are a special case for two reasons
;;   1) a finally block will capture the return of other blocks
;;      thus when a finally block exists, any return in try-except-else
;;      must be bound to the try-block, not the function
;;   2) try-except-else-finally are chaining, not branching
(define-walk-method (return this::PycTry block tail conf)
  (let* ((has-else (PycPass? (PycTry-else this)))
        (has-finally (PycPass? (PycTry-finally this)))
        (handlers/else-tail (and tail (not has-finally))))
    (return (PycTry-body this) this #f conf)
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
      (return (PycTry-finally this) block tail conf))
    (PycTry-tail-set! this tail)
    (if (and (PycTry-need-return this) (not tail))
      (need-return-set! block #t))))

(define-walk-method (return this::PycFun block tail conf)
   (return (PycFun-body this) this #t conf))
