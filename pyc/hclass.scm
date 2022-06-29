;; Precompute attributes of instance of each classes
;; this allows preallocating hidden classes

;; if propagate-attributes-to-superclasses is #t the attributes of a class
;; will be propagated to its superclass.
(define propagate-attributes-to-superclasses #t)

;; if propagate-attributes-to-subclasses is #t the attributes of a class
;; will be propagated to its subclass after the propagation to superclasses
;; this allows cousin classes to share the same hclass
(define propagate-attributes-to-subclasses #t)

(define (pyc-hclass this conf)
  (let ((classes (collect-classes* this)))
    (for-each
      (lambda (name-cls-pair)
        (pyc-class-compute-attributes! (cdr name-cls-pair) classes '()))
      classes)
    (apply-attributes-propagation! classes)
    ;; sort attributes such that classes with the same attributes can share the same HClass
    (map normalize-attributes (map cdr classes))
    (assign-hclasses! this (map cdr classes))
    ;;(pp (map (lambda (c) (cons (PycClass-name c) (PycClass-attributes c))) (map cdr classes)))
    this))

(define (assign-hclasses! this classes)
  (define (group-by-attributes classes)
    (let ((assoc-table '()))
      (let loop ((classes classes))
        (if (pair? classes)
          (let* ((class (car classes))
                 ;; attributes should have been sorted by hclass.scm
                 (attributes (PycClass-attributes class))
                 (table-pair (assoc attributes assoc-table)))
            (if table-pair
              (set-cdr! table-pair (cons class (cdr table-pair)))
              (set! assoc-table (cons
                                  (cons attributes (list class))
                                  assoc-table)))
            (loop (cdr classes)))))
      assoc-table))

  (define (make-hclass-name classes)
    (let* ((names (reverse (map PycClass-name classes)))
           (hclass-name
             (apply string-append
               (map
                 (lambda (n) (string-append n "-"))
                 names))))
      (my-gensym
        (string->symbol
          (string-append hclass-name "hclass-of-instances")))))

  (define (make-init-hclass-name cls)
    (my-gensym (symbol-append '|init-hclass:| (string->symbol (PycClass-name cls)))))

  (let* ((class-table (group-by-attributes classes)))
    (map
      (lambda (attributes-classes)
        (let* ((attributes (car attributes-classes))
               (classes (cdr attributes-classes))
               (hclass-name (make-hclass-name classes))
               (hclass (new-PycHClass hclass-name attributes classes)))
        (for-each
          (lambda (cls)
            (PycClass-initial-hclass-name-set! cls (make-init-hclass-name cls))
            (PycClass-hclass-set! cls hclass))
          classes)
        (PycModule-hclasses-set! this (cons hclass (PycModule-hclasses this)))))
      class-table)))

(define (normalize-attributes cls)
  (PycClass-attributes-set! cls (sort string<? (PycClass-attributes cls))))

(define (merge-cls-attributes cls1 cls2)
  (uniq (append (PycClass-attributes cls1) (PycClass-attributes cls2))))

(define (apply-attributes-propagation! classes)
  ;; NOTE: we must avoid loops! Even though they cannot happen at runtime
  ;; they can at compile time, example:
  ;; class A(B): pass
  ;; class B(A): pass
  (define (propagate-up cls seen)
    (for-each
      (lambda (supercls)
        (if (not (memq supercls seen))
          (begin
            (PycClass-attributes-set! supercls (merge-cls-attributes supercls cls))
            (propagate-up supercls (cons cls seen)))))
      (get-expected-Pyc-bases cls classes)))

  (define (propagate-down cls seen)
    (for-each
      (lambda (subcls)
        (if (not (memq subcls seen))
          (begin
            (PycClass-attributes-set! subcls (merge-cls-attributes subcls cls))
            (propagate-up subcls (cons cls seen)))))
      (get-expected-Pyc-direct-subclasses cls classes)))

  (if propagate-attributes-to-superclasses
    (for-each
      (lambda (cls) (propagate-up cls '()))
      (map cdr classes)))

  (if propagate-attributes-to-subclasses
    (for-each
      (lambda (cls) (propagate-down cls '()))
      (map cdr classes))))

(define (get-expected-Pyc-bases cls classes)
  (filter-map
    (lambda (ref)
      (if (isa? ref PycRef)
        (let* ((var (PycRef-decl ref))
               (x (assq var classes)))
           (if x
             (let ((superclass (cdr x)))
               ;; avoid compile time infinite loop if
               ;; code contains class X(X):
               ;; this typically does not work at runtime, but we
               ;; ignore execution order here
               (if (not (eq? superclass cls)) superclass #f))
             #f))
        #f))
    (PycClass-bases cls)))

(define (get-expected-Pyc-direct-subclasses cls classes)
  (filter-map
    (lambda (other-cls)
      (if (and (not (eq? cls other-cls))
               (memq cls (get-expected-Pyc-bases other-cls classes)))
        other-cls
        #f))
    (map cdr classes)))

(define (pyc-class-compute-attributes! cls classes seen)
  ;; compute and set expected attributes of instance
  ;; We do it by searching 2 things:
  ;; 1) attribute access and set on instance in methods
  ;; 2) Attributes found recursively on superclasses
  ;; NOTE: This cannot be 100% accurate due to Python dynamic nature
  ;; but most of the time, classes are defined as if they were static
  (if (or (memq cls seen)
          (not (null? (PycClass-attributes cls))))
    ;; avoid pathological case where an infinite loop can happen, for example:
    ;; class A(B): pass
    ;; class B(A): pass
    ;; this would fail at runtime, but need to be handled at compile time
    (PycClass-attributes cls)
    (let* ((superclasses-attributes
             (apply append
               (map
                 (lambda (superclass)
                   (pyc-class-compute-attributes!
                     superclass classes
                     (cons cls seen)))
                 (get-expected-Pyc-bases cls classes))))
           (own-attributes (collect-cls-own-attributes* cls cls))
           ;; remove duplicates
           (all-attributes (uniq (append own-attributes superclasses-attributes))))
      (PycClass-attributes-set! cls all-attributes)
      all-attributes)))

(define-walk-method (collect-cls-own-attributes* this::PycNode cls)
  (call-default-walker))

(define-walk-method (collect-cls-own-attributes* this::PycAssig cls)
  (let ((lhs (PycAssig-lhs this))
        (rhs (PycAssig-rhs this)))
    (if (and
          (isa? rhs PycFun)
          ;; not decorated by staticmethod or classmethod
          (not (string=? (symbol->string (PycFun-name rhs)) "__new__")) ;; __new__ is static
          (not (any?
                 (lambda (decorator)
                    (and (isa? decorator PycRefUnresolved)
                         (memq (PycRefUnresolved-id decorator) '(classmethod staticmethod))))
                 (PycFun-decorators rhs))))
        (let* ((args (PycFun-args rhs)))
          (if (pair? args)
            (collect-field-access-on-var* rhs (car args) cls)
            '()))
        '())))

(define-walk-method (collect-field-access-on-var* this::PycNode var cls)
  (call-default-walker))

(define-walk-method (collect-field-access-on-var* this::PycAccess var cls)
  (let ((obj (PycAccess-obj this)))
    (if (and (isa? obj PycRef) (eq? (PycRef-decl obj) var))
      (begin
        (PycAccess-hclass-attribute-of-set! this cls)
        (cons (PycAccess-field this) (call-default-walker)))
      (call-default-walker))))

(define-walk-method (collect-classes* this::PycNode)
  (call-default-walker))

(define-walk-method (collect-classes* this::PycAssig)
  (let ((lhs (PycAssig-lhs this))
        (rhs (PycAssig-rhs this)))
    (if (isa? rhs PycClass)
      (cons
        (cons
          (PycRef-decl lhs)
          rhs)
        (call-default-walker))
      (call-default-walker))))
