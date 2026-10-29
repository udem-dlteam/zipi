(define expansion-debug? #f)

(define (bigloo#symbol-append . symbols)
  (string->symbol (string-concatenate (map symbol->string symbols))))

(define (bigloo#string-contains string1 string2 #!optional (start 0))
  ;; Does string string1 contain string string2?
  (let ((len (string-length string2)))
    (let loop ((i start))
      (let ((end (fx+ i len)))
        (if (fx<= end (string-length string1))
            (if (string=? (substring string1 i end) string2)
                i
                (loop (fx+ i 1)))
            #f)))))

(define (bigloo#directives-expand rest)

;;  (##import bigloo)

  (define generated-includes '())
  (define generated-code '())

  (define (handle form)
    (if (pair? form)
        (case (car form)
          ((include)
           (for-each
            (lambda (file)
              (if (member file '("ast/types.sch"))
                  (set! file "ast/ast.bgl"))
              (set! generated-includes
                (cons `(include ,(string-append "../" file))
                      generated-includes)))
            (cdr form))))))

  (for-each handle rest)

  (let ((expansion `(begin ,@(append (reverse generated-includes)
                                     (reverse generated-code)))))
    expansion))

(define (bigloo#module-expand rest)

;;  (##import bigloo)

  (define generated-includes '())
  (define generated-code '())

  (define (handle form)
    (if (pair? form)
        (case (car form)
          ((export)
           (for-each
            (lambda (def)
              (let ((kind (if (pair? def) (car def) #f)))
                (case kind
                  ((class abstract-class final-class)
                   (let* ((nt (bigloo#name-and-type (cadr def)))
                          (name (car nt))
                          (type (cdr nt))
                          (fields
                           (map (lambda (f)
                                  (let* ((nt (bigloo#name-and-type (if (pair? f) (car f) f)))
                                         (name (car nt))
                                         (type (cdr nt)))
                                    name))
                                (cddr def)))
                          (type-def
                           `(,(if type
                                  (bigloo#symbol-append 'define-type-of- type)
                                  'define-type)
                             ,name
                             id:
                             ,name
                             extender:
                             ,(bigloo#symbol-append 'define-type-of- name)
                             type-exhibitor:
                             ,(bigloo#symbol-append 'type-of- name)
                             ;;macros:
                             ,@fields)))
                     (let ((parents
                            (cons (cons name fields)
                                  (if type
                                      (let ((x (cdr (assq type bigloo#type-hierarchy))))
                                        (vector-set! x 1 (cons name (vector-ref x 1)))
                                        (vector-ref x 2))
                                      '()))))
                       (set! bigloo#type-hierarchy
                         (cons (cons name (vector (car def) '() parents))
                               bigloo#type-hierarchy)))
                     (set! generated-code
                       (cons type-def
                             generated-code))
                     (set! generated-code
                       (cons `(define ,name
                                (,(bigloo#symbol-append 'type-of- name)))
                             generated-code))
                     (set! generated-code
                       (cons `(define-macro (,(bigloo#symbol-append '|with-access::| name)
                                             obj
                                             with-fields
                                             .
                                             body)
                              ;;  (##import bigloo)
                                `(let (($obj ,obj))
                                   (let ,(map (lambda (f)
                                                (list f (bigloo#gen-field-ref ',name f '$obj)))
                                              with-fields)
                                     (let (($result (begin ,@body)))
                                       ,@(map (lambda (f)
                                                (bigloo#gen-field-set! ',name f '$obj f))
                                              with-fields)
                                       $result))))
                             generated-code)))))))
            (cdr form)))
          #;
          ((include)
           (for-each
            (lambda (file)
              (set! generated-includes
                (cons `(include ,(string-append "../" file))
                      generated-includes)))
            (cdr form))))))

  (if (##unbound? (##global-var-ref (##make-global-var 'bigloo#type-hierarchy)))
      (##global-var-set! (##make-global-var 'bigloo#type-hierarchy) '()))

  (for-each handle (cdr rest))

  (let ((expansion `(begin ,@(append (reverse generated-includes)
                                     (reverse generated-code)))))
    (if expansion-debug? (pretty-print expansion))
    expansion))

(define (bigloo#define-generic-expand rest)

;;  (##import bigloo)

  (define (def-gen head body)
    (let* ((nt (bigloo#name-and-type (car head)))
           (name (car nt))
           (type (cdr nt))
           (nt2 (bigloo#name-and-type (cadr head)))
           (name2 (car nt2))
           (type2 (cdr nt2))
           (derived (bigloo#derived-classes-no-self type2))
           (params (map (lambda (x) (car (bigloo#name-and-type x))) (cdr head)))
           (expansion
            `(begin
               (define (,name ,@params)
                 (cond ,@(map (lambda (d)
                                (let ((meth (bigloo#symbol-append name '|::| d)))
                                  `((,(bigloo#symbol-append d '?) ,(car params))
                                    (,meth ,@params))))
                              derived)
                       (else
                        (error "unhandled class in" '(,name ,@params) ,(car params)))))
               (define (,(bigloo#symbol-append name '|::| type2) ,@params)
                 ,@body)
               ,@(map (lambda (d)
                        (let ((meth (bigloo#symbol-append name '|::| d))
                              (superclass (bigloo#superclass d)))
                          `(define (,meth ,@params)
                             (,(bigloo#symbol-append name '|::| superclass)
                              ,@params))))
                      derived))))
      (if expansion-debug? (pretty-print expansion))
      expansion))

  (def-gen (car rest) (cdr rest)))

(define (bigloo#define-method-expand rest)

;;  (##import bigloo)

  (define (def-meth head body)
    (let* ((nt (bigloo#name-and-type (car head)))
           (name (car nt))
           (type (cdr nt))
           (nt2 (bigloo#name-and-type (cadr head)))
           (name2 (car nt2))
           (type2 (cdr nt2))
           (params (map (lambda (x) (car (bigloo#name-and-type x))) (cdr head)))
           (expansion
            `(set!,(bigloo#symbol-append name '|::| type2)
                  (lambda (,@params)
                    ,@body))))
      (if expansion-debug? (pretty-print expansion))
      expansion))

  (def-meth (car rest) (cdr rest)))

(define (bigloo#derived-classes class self?)
  (let ((x (assq class bigloo#type-hierarchy)))
    (if (not x)
        (error "unknown class" class)
        (let* ((v (cdr x))
               (kind (vector-ref v 0))
               (subclasses (vector-ref v 1))
               (superclasses (vector-ref v 2))
               (derived
                (apply append
                       (map (lambda (c) (bigloo#derived-classes c #t))
                            subclasses))))
          (if self?
              (append derived (list class))
              derived)))))

(define (bigloo#derived-classes-no-self class)
  (bigloo#derived-classes class #f))

(define (bigloo#name-and-type sym)
  (let* ((str (symbol->string sym))
         (i (bigloo#string-contains str "::")))
    (if i
        (cons (string->symbol (substring str 0 i))
              (string->symbol (substring str (fx+ i 2) (string-length str))))
        (cons sym
              #f))))

(define (bigloo#gen-field class field set!?)
  (let* ((x (assq class bigloo#type-hierarchy))
         (v (cdr x))
         (superclasses (vector-ref v 2)))
    (let loop ((lst superclasses))
      (if (pair? lst)
          (if (memq field (cdr (car lst)))
              (if set!?
                  (bigloo#symbol-append (car (car lst)) '- field '-set!)
                  (bigloo#symbol-append (car (car lst)) '- field))
              (loop (cdr lst)))
          (error "field does not exist" field)))))

(define (bigloo#superclass class)
  (let* ((x (assq class bigloo#type-hierarchy))
         (v (cdr x))
         (superclasses (vector-ref v 2))
         (s (cdr superclasses)))
    (if (pair? s)
        (car (car s))
        #f)))

(define (bigloo#gen-field-ref class field obj)
  (list (bigloo#gen-field class field #f) obj))

(define (bigloo#gen-field-set! class field obj expr)
  (list (bigloo#gen-field class field #t) obj expr))

(define (bigloo#args-parse-expand rest)
  (let ((args (car rest))
        (clauses (cdr rest)))
    (let ((xxx
    `(let $loop (($args ,args))
       (define (args-parse-usage ?) #f)
       (if (pair? $args)
           (let (($arg (car $args)))
             (cond
              ,@(map (lambda (clause)
                       (let ((opt (car clause)))
                         (if (not (pair? opt))
                             `(else
                               (let ((,opt $arg))
                                 ,@(cdr clause)
                                 ($loop (cdr $args))))
                             (let ((opt-pattern (car opt)))

                               (define (handle opts)
                                 `((member $arg ',opts)
                                   ,(if (and (symbol? (cadr opt))
                                             (equal? 0 (bigloo#string-contains (symbol->string (cadr opt)) "?")))
                                        (let ((var (string->symbol (substring (symbol->string (cadr opt)) 1 (string-length (symbol->string (cadr opt)))))))
                                          `(let ((,var (cadr $args)))
                                             ,@(cdr clause)
                                             ($loop (cddr $args))))
                                        `(let ()
                                           ,@(cdr clause)
                                           ($loop (cdr $args))))))

                               (cond ((pair? opt-pattern)
                                      (handle opt-pattern))
                                     ((bigloo#string-contains opt-pattern "?")
                                      =>
                                      (lambda (i)
                                        `((equal? 0 (bigloo#string-contains $arg ,(substring opt-pattern 0 i)))
                                          (let ((,(string->symbol (substring opt-pattern (+ i 1) (string-length opt-pattern)))
                                                 (substring $arg ,i (string-length $arg))))
                                            ,@(cdr clause)
                                            ($loop (cdr $args))))))
                                     ((string? opt-pattern)
                                      (handle (list opt-pattern)))
                                     (else
                                      (error "unhandled args-parse clause" clause)))))))
                     clauses)))))))
;;    (pp xxx)
    xxx)))

(define (bigloo#bind-exit-expand rest)
  `(call-with-current-continuation
    (lambda (,(car (car rest)))
      ,@(cdr rest))))

(define (bigloo#with-handler-expand rest)
  `(with-exception-catcher
    ,(car rest)
    (lambda ()
      ,@(cdr rest))))

(define (bigloo#unwind-protect-expand rest)
  `(dynamic-wind
     (lambda () #f)
     (lambda () ,(car rest))
     (lambda () ,@(cdr rest))))

(define (bigloo#match-case-expand rest)

  (define gensym ;; a version of gensym useful for debugging
    (let ((count 0))
      (lambda ()
        (set! count (+ count 1))
        (string->symbol (string-append "g" (number->string count))))))

  (define (pattern-variable? x)
    (and (symbol? x)
         (let* ((str (symbol->string x))
                (len (string-length str)))
           (and (>= len 0)
                (char=? #\? (string-ref str 0))
                (string->symbol (substring str 1 len))))))

  (define (if-equal? var pattern yes no)
    (cond ((pattern-variable? pattern)
           =>
           (lambda (pattern-var)
             `(let ((,pattern-var ,var))
                ,yes)))
          ((null? pattern)
           `(if (null? ,var) ,yes ,no))
          ((symbol? pattern)
           `(if (eq? ,var ',pattern) ,yes ,no))
          ((boolean? pattern)
           `(if (eq? ,var ,pattern) ,yes ,no))
          ((or (number? pattern)
               (char? pattern))
           `(if (eqv? ,var ,pattern) ,yes ,no))
          ((string? pattern)
           `(if (equal? ,var ,pattern) ,yes ,no))
          ((pair? pattern)
           (let ((carvar (gensym))
                 (cdrvar (gensym)))
             `(if (pair? ,var)
                  (let ((,carvar (car ,var)))
                    ,(if-equal?
                      carvar
                      (car pattern)
                      `(let ((,cdrvar (cdr ,var)))
                         ,(if-equal?
                           cdrvar
                           (cdr pattern)
                           yes
                           no))
                      no))
                  ,no)))
          (else
           (error "unknown match-case pattern"))))

  (let* ((subject
         (car rest))
        (clauses
         (cdr rest))
        (var
         (gensym))
        (fns
         (map (lambda (x) (gensym))
              clauses))
        (default
         (gensym)))

    (let ((expansion
           `(let ((,var ,subject))
              ,@(map (lambda (fn1 fn2 clause)
                       `(define (,fn1)
                          ,(if (eq? (car clause) 'else)
                               `(begin ,@(cdr clause))
                               (if-equal? var
                                          (car clause)
                                          (if (and (eq? (cadr clause) 'when)
                                                   (pair? (cddr clause)))
                                              `(if ,(caddr clause)
                                                   ,(cadddr clause)
                                                   (,fn2))
                                              (cadr clause))
                                          `(,fn2)))))
                     fns
                     (append (cdr fns) (list default))
                     clauses)

              (define (,default)
                ;; (error "match-case failed" ,var)
                #f)

              (,(car fns)))))
      (if expansion-debug? (pretty-print expansion))
      expansion)))
