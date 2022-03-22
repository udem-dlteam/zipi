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

;; =====================================================================
;; Sub-cases for decision tables
;; =====================================================================

(define-table-case (py+fixnum-fixnum-no-overflow left right)
  `((gambit: (|##fx+| ,left ,right))
    (bigloo: (+fx ,left ,right))))

(define-table-case (py+fixnum-fixnum left right)
  `((gambit: (or (|##fx+| ,left ,right) (py-bint-from-scheme (|##+2| ,left ,right))))
    (bigloo: (py-int-from-scheme (+fx/overflow ,left ,right)))))

(define-table-case (py+Uint-Uint left right)
  `((gambit: (let (($res (|##+2| ,left ,right))) (if (fixnum? $res) $res (py-bint-from-scheme $res))))
    (bigloo: (let (($res (+ ,left ,right))) (if (fixnum? $res) $res (py-bint-from-scheme $res))))))

(define-table-case (py+flonum-flonum left right)
  `((gambit: (|##fl+| ,left ,right))
    (bigloo: (+fl ,left ,right))))

;; =====================================================================
;; Decision tables
;; =====================================================================

(define-binop-table (add-decision-table this conf)
  ((and (isa? this-lhs PycNumber) (isa? this-rhs PycNumber))
    (let ((lhs-val (PycLiteralValue-val this-lhs))
          (rhs-val (PycLiteralValue-val this-rhs)))
      (cond
        ((or (not (real? lhs-val)) (not (real? rhs-val)))
          `(py-throw-exception-with-message py-builtin-NotImplementedError
            "complex number at line " ,(number->string (car (PycNode-loc this)))))
        ((and (flonum? lhs-val) (flonum? rhs-val))
          `(py-float-from-scheme ,(+ lhs-val rhs-val)))
        ((and (exact? lhs-val) (exact? rhs-val))
          (let ((result (+ lhs-val rhs-val)))
            (if (fixnum? result) result `(py-int-from-scheme ,result))))
        (else
          `(py-add ,(scheme this-lhs conf) ,(scheme this-rhs conf))))))
  (else
    `(let (($left ,(scheme this-lhs conf)) ($right ,(scheme this-rhs conf)))
       (cond
         ((and (fixnum? $left) (fixnum? $right))
           ,(py+fixnum-fixnum '$left '$right))
         ((and (flonum? $left) (flonum? $right))
           ,(py+flonum-flonum '$left '$right))
         (else
           (py-add $left $right))))))
