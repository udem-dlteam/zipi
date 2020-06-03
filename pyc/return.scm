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
(define-walk-method (return this::PycNode fun tail conf)
   (call-default-walker))

(define-walk-method (return this::PycStmt fun tail conf)
   (call-default-walker))

(define-walk-method (return this::PycSeq fun tail conf)
   (let loop ((nodes (PycSeq-nodes this)))
      (cond
	 ((null? (cdr nodes))
	  (return (car nodes) fun tail conf))
	 ((PycReturn? (car nodes))
	  (set-cdr! nodes '())
	  (return (car nodes) fun tail conf))
   ((PycRaise? (car nodes))
    (set-cdr! nodes '())
    ;; Is this needed? There can be no return inside a raise
    (return (car nodes) fun tail conf))
	 (else
	  (return (car nodes) fun #f conf)
	  (loop (cdr nodes))))))

(define-walk-method (return this::PycReturn fun tail conf)
   (when (and (PycFun? fun) (not tail))
      (PycFun-need-return-set! fun #t)
      (PycReturn-tail-set! this #f)))

(define-walk-method (return this::PycFun fun tail conf)
   (return (PycFun-body this) this #t conf))

;* (define-walk-method (return this::PycBlock fun tail conf)            */
;*    (for-each (lambda (d) (return (PycDeclInit-val d) fun #f conf))   */
;*       (PycBlock-decls this))                                         */
;*    (return (PycBlock-body this) fun tail conf))                      */
;*                                                                     */
;* (define-walk-method (return this::PycAssig fun tail conf)            */
;*    (return (PycAssig-rhs this) fun #f conf)                          */
;*    (return (PycAssig-lhs this) fun #f conf))                         */
;*                                                                     */
;* (define-walk-method (return this::PycIf fun tail conf)               */
;*    (return (PycIf-test this) fun #f conf)                            */
;*    (return (PycIf-then this) fun tail conf)                          */
;*    (return (PycIf-else this) fun tail conf))                         */
;*                                                                     */
;* (define-walk-method (return this::PycWhile fun tail conf)            */
;*    (return (PycWhile-test this) fun #f conf)                         */
;*    (return (PycLoop-body this) fun #f conf)                          */
;*    (return (PycLoop-else this) fun tail conf))                       */
;*                                                                     */
;* (define-walk-method (return this::PycStmtExpr fun tail conf)         */
;*    (return (PycStmtExpr-expr this) fun #f conf))                     */
;*                                                                     */
;* (define-walk-method (return this::PycTry fun tail conf)              */
;*    (return (PycTry-body this) fun #f conf)                           */
;*    (return (PycTry-else this) fun tail conf)                         */
;*    (return (PycTry-finally this) fun #f conf)                        */
;*    (for-each (lambda (h) (return (PycHandler-body h) fun tail conf)) */
;*       (PycTry-handlers this)))                                       */

(define-walk-method (return this::PycPass fun tail conf)
   #f)

(define-walk-method (return this::PycBreak fun tail conf)
   #f)

(define-walk-method (return this::PycContinue fun tail conf)
   #f)
