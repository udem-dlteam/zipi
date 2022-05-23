;; =====================================================================
;; Predicates
;; =====================================================================

(define-predicate (call-to-a-prama? call conf params)
  (isa? (PycCall-fun call) PycPragma))

(define-predicate (call-to-an-attribute? call conf params)
  (isa? (PycCall-fun call) PycAccess))

(define-predicate (call-has-keyword-arguments? call conf params)
  (pair? (PycBinary-keywords-names call)))

(define-predicate (call-matches-signature-to-global-function? call conf params)
  (define (correct-arity? fun call)
     (and
       (not (call-has-keyword-arguments? call))
       (=
         (+ (length (PycFun-args fun)) (length (PycFun-posonlyargs fun)))
         (length (PycCall-args this)))))

  (let ((fun (PycCall-fun this))
        (global-funs (config-get params global-funs:)))
    (if (isa? fun PycRef)
      (let* ((var (PycRef-decl fun)))
        (if (eq? (PycVar-scope var) 'global)
          (let ((init-val (and global-funs (get-def-with-var global-funs var))))
             (and (isa? init-val PycFun)
                  (symbol? (PycFun-&proc init-val))
                  (correct-arity? init-val call)))
          #f))
      #f)))

(define-predicate (static-call-to-global-function? call conf params)
  (and
    (PycVar-global-ref-to-init-def (PycRef-decl (PycCall-fun call)))
    (call-matches-signature-to-global-function? call conf params)))

(define-predicate (ignore-global-functions? call conf params)
  (config-get params ignore-global-functions:))

;; =====================================================================
;; Code generation
;; =====================================================================

(define (get-static-global-call-procedure-name call conf)
  (define (get-def-with-var global-funs var)
    (if (null? global-funs)
      #f
      (let ((fn-var (PycRef-decl (PycAssig-lhs (car global-funs)))))
        (if (eq? fn-var var)
          (PycAssig-rhs (car global-funs))
          (get-def-with-var (cdr global-funs) var)))))

  (let* ((fun (PycCall-fun call))
         (var (PycRef-decl fun))
         (global-funs (config-get params global-funs:))
         (init-val (get-def-with-var global-funs var)))
    (PycFun-&proc init-val)))

(define (py-static-global-call call conf)
  `(,(get-static-global-call-procedure-name call conf) ,@(PycCall-args call)))

(define (py-global-call call conf params)
  (let* ((fun (PycCall-fun call))
         (var (PycRef-decl f))
         (args (PycCall-args call))
         (args-syms (map (lambda (e) (my-gensym 'arg)) args))
         (global-name (scheme-var-name var conf))
         (global-init-val-name ,(scheme-def-optim-globals-name-init var conf)))
    `(let* ,(map (lambda (p a) (list p (scheme a conf))) args-syms args)
      (if (eq? ,global-name ,global-init-val-name)
        (,global-name ,@args-syms)
        ,(call-to-scheme call
                         conf
                         (cons*
                           ignore-global-functions: #t
                           params))))))

(define-compilation-to-scheme (call-to-scheme call conf params
                                              (fun (PycCall-fun call))
                                              (args (PycCall-args call))
                                              (keywords-names (PycBinary-keywords-names call))
                                              (keywords-values (PycBinary-keywords-values call)))
  (call-to-a-prama?
    `(,(scheme fun conf) ,@(map (lambda (a) (scheme a conf)) args)))
  (static-call-to-global-function?
    (py-static-global-call call conf))
  ((and call-matches-signature-to-global-function?
        (not ignore-global-functions?))
    (py-global-call call conf params))
  (call-to-an-attribute?
    #f)
  ((not call-has-keyword-arguments?)
    #f)
  (else
    (PycBinary-default-case call conf params py-fx// py-fl// 'floordiv)))

;; Dispatch
(define (default-call call conf params)
  `(py-call
    #f))

(define (PycCall-to-scheme call conf . rest)
  (if (> (length rest) 1) (error "PycCall-to-scheme" "takes 3 arguments" (length rest)))

  (let ((params (if (> (length rest) 0) (list-ref rest 0) '())))
    (call-to-scheme call conf params)))
