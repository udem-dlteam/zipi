;; =====================================================================
;; Macros and helpers
;; =====================================================================

(define-macro (replace-system sexp)
  (define host (cond-expand (gambit gambit:) (bigloo 'bigloo:)))

  (define known-hosts '(bigloo: gambit:))

  (define (replace sexp)
    (if (pair? sexp)
      (if (and (pair? (car sexp)) (memq (caar sexp) known-hosts))
        (cdr (assq host sexp))
        (map replace sexp))
      sexp))

  (replace sexp))

(define-macro (define-table-case signature . body)
  `(replace-system (define ,signature ,@body)))

(define-macro (define-binop-table signature . body)
  (define (symbol-append . rest)
    (string->symbol (apply string-append (map symbol->string rest))))

  (let* ((argument (cadr signature))
         (lhs (symbol-append argument '-lhs))
         (rhs (symbol-append argument '-rhs)))
  `(replace-system
    (define ,signature
      (let ((,lhs (PycBinary-lhs ,argument))
            (,rhs (PycBinary-rhs ,argument)))
        (cond
         ,@body))))))

(define-macro (make-default-decision-table name generic-op rt-fixnum-op rt-flonum-op python-op)
 `(define-binop-table (,name this conf)
   ((and (isa? this-lhs PycNumber) (isa? this-rhs PycNumber))
     (let ((lhs-val (PycLiteralValue-val this-lhs))
           (rhs-val (PycLiteralValue-val this-rhs)))
       (cond
         ((or (not (real? lhs-val)) (not (real? rhs-val)))
           `(py-throw-exception-with-message py-builtin-NotImplementedError
             "complex number at line " ,(number->string (car (PycNode-loc this)))))
         ((and (flonum? lhs-val) (flonum? rhs-val))
           (,generic-op lhs-val rhs-val))
         ((and (exact? lhs-val) (exact? rhs-val))
           (let ((result (,generic-op lhs-val rhs-val)))
             (if (fixnum? result) result `(py-int-from-scheme ,result))))
         (else
           `(,,python-op ,(scheme this-lhs conf) ,(scheme this-rhs conf))))))
   (else
     `(let (($left ,(scheme this-lhs conf)) ($right ,(scheme this-rhs conf)))
        (cond
          ((and (fixnum? $left) (fixnum? $right))
            ,(,rt-fixnum-op '$left '$right))
          ((and (flonum? $left) (flonum? $right))
            ,(,rt-flonum-op '$left '$right))
          (else
            (,,python-op $left $right)))))))

;; =====================================================================
;; Sub-cases for decision tables
;; =====================================================================

;; ADDITION
(define-table-case (py:fx+fx left right)
  `((gambit: (or (|##fx+| ,left ,right) (py-bint-from-scheme (|##+2| ,left ,right))))
    (bigloo: (py-int-from-scheme (+fx/overflow ,left ,right)))))

(define-table-case (py:fl+fl left right)
  `((gambit: (|##fl+| ,left ,right))
    (bigloo: (+fl ,left ,right))))

;; SUBTRACTION
(define-table-case (py:fx-fx left right)
  `((gambit: (or (|##fx-| ,left ,right) (py-bint-from-scheme (|##-2| ,left ,right))))
    (bigloo: (py-int-from-scheme (+fx/overflow ,left ,right)))))

(define-table-case (py:fl-fl left right)
  `((gambit: (|##fl-| ,left ,right))
    (bigloo: (-fl ,left ,right))))

;; =====================================================================
;; Decision tables
;; =====================================================================

(make-default-decision-table add-decision-table + py:fx+fx py:fl+fl 'py-add)

(make-default-decision-table sub-decision-table - py:fx-fx py:fl-fl 'py-sub)

(define (dispatch-to-decision-table this conf)
  (let ((op (PycBinary-op this)))
    (cond ((eq? op 'add) (add-decision-table this conf))
          ((eq? op 'sub) (sub-decision-table this conf))
          (else #f))))
