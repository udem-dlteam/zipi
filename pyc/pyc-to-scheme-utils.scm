;; =====================================================================
;; Macros and helpers
;; =====================================================================
(define-macro (replace-system sexp)
  (define host (cond-expand (gambit gambit:) (bigloo 'bigloo:)))

  (define known-hosts '(bigloo: gambit:))

  (define (replace sexp)
    (if (pair? sexp)
      (if (and (pair? (car sexp)) (memq (caar sexp) known-hosts))
        (let ((host-data (assq host sexp)))
          (if host-data
            (cadr host-data)
            (error "replace-system" "cannot find system in" sexp)))
        (map replace sexp))
      sexp))

  (replace sexp))

(define-macro (define-compilation-to-scheme signature . body)
  (define (symbol-append . rest)
    (string->symbol (apply string-append (map symbol->string rest))))

  (define (parse-signature signature)
    (cond
      ((and (pair? signature) (symbol? (car signature)))
        (let ((tail (parse-signature (cdr signature))))
          (cons (cons (car signature) (car tail)) (cdr tail))))
      (else
        ;; treat the rest of the signature as bindings for let*
        (cons '() signature))))

  (define (parse-single-predicate predicate arguments)
    (if (and (pair? predicate) (memq (car predicate) '(or and not)))
      `(,(car predicate) ,@(map (lambda (sexp) (parse-single-predicate sexp arguments)) (cdr predicate)))
      `(,predicate ,@arguments)))

  (define (parse-body-predicates body arguments)
    (cond
      ((null? body) '())
      ((eq? (caar body) 'else)
        `((else ,@(cdar body))))
      (else
        `((,(parse-single-predicate (caar body) arguments) ,@(cdar body)) ;; a conditional branch
          ,@(parse-body-predicates (cdr body) arguments)))))

  (define (parse-body body arguments)
    `(cond ,@(parse-body-predicates body arguments)))

  (let* ((parsed-signature (parse-signature signature))
         (name (caar parsed-signature))
         (arguments (cdar parsed-signature))
         (bindings (cdr parsed-signature)))

  `(replace-system
    (define (,name ,@arguments)
      (let* (,@bindings)
        ,(parse-body body arguments))))))

(define-macro (define-predicate signature . body)
  `(define ,signature
    ;;(pp (quote ,(car signature)))
    ,@body))


;; util predicates

(define-predicate (in-semantics? access conf params)
  (let ((current-fun (config-get conf fun:)))
    (and current-fun (isa? current-fun PycSemantics))))
