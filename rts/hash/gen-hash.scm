;; List of "intrinsic" names.  These are names for which the generated
;; hash function will give unique hash codes.  This is useful for creating
;; perfect hash tables (of all these names or a subset of these names).

(define intrinsic-names '(

;; These are magic methods:

"__abs__"              "__add__"              "__alloc__"
"__and__"              "__base__"             "__bases__"
"__basicsize__"        "__bool__"             "__call__"
"__cause__"            "__ceil__"             "__class__"
"__contains__"         "__context__"          "__delattr__"
"__delete__"           "__delitem__"          "__dict__"
"__dictoffset__"       "__dir__"              "__divmod__"
"__doc__"              "__enter__"            "__eq__"
"__exit__"             "__flags__"            "__float__"
"__floor__"            "__floordiv__"         "__format__"
"__func__"             "__ge__"               "__get__"
"__getattribute__"     "__getformat__"        "__getitem__"
"__getnewargs__"       "__gt__"               "__hash__"
"__iadd__"             "__iand__"             "__imul__"
"__index__"            "__init__"             "__init_subclass__"
"__instancecheck__"    "__int__"              "__invert__"
"__ior__"              "__isabstractmethod__" "__isub__"
"__itemsize__"         "__iter__"             "__ixor__"
"__le__"               "__len__"              "__length_hint__"
"__lshift__"           "__lt__"               "__mod__"
"__module__"           "__mro__"              "__mul__"
"__name__"             "__ne__"               "__neg__"
"__new__"              "__next__"             "__or__"
"__pos__"              "__pow__"              "__prepare__"
"__qualname__"         "__radd__"             "__rand__"
"__rdivmod__"          "__reduce__"           "__reduce_ex__"
"__repr__"             "__reversed__"         "__rfloordiv__"
"__rlshift__"          "__rmod__"             "__rmul__"
"__ror__"              "__round__"            "__rpow__"
"__rrshift__"          "__rshift__"           "__rsub__"
"__rtruediv__"         "__rxor__"             "__self__"
"__self_class__"       "__set__"              "__set_format__"
"__setattr__"          "__setitem__"          "__setstate__"
"__sizeof__"           "__str__"              "__sub__"
"__subclasscheck__"    "__subclasses__"       "__subclasshook__"
"__suppress_context__" "__text_signature__"   "__thisclass__"
"__traceback__"        "__truediv__"          "__trunc__"
"__weakrefoffset__"    "__xor__"

;; These are non-magic methods:

"add" "append" "args" "as_integer_ratio" "bit_length" "c_contiguous" "capitalize" "casefold" "cast" "center" "characters_written" "clear" "code" "conjugate" "contiguous" "copy" "count" "decode" "deleter" "denominator" "difference" "difference_update" "discard" "encode" "encoding" "end" "endswith" "errno" "expandtabs" "extend" "f_contiguous" "fdel" "fget" "filename" "filename2" "find" "format" "format_map" "from_bytes" "fromhex" "fromkeys" "fset" "get" "getter" "hex" "imag" "index" "indices" "insert" "intersection" "intersection_update" "is_integer" "isalnum" "isalpha" "isascii" "isdecimal" "isdigit" "isdisjoint" "isidentifier" "islower" "isnumeric" "isprintable" "isspace" "issubset" "issuperset" "istitle" "isupper" "items" "itemsize" "join" "keys" "lineno" "ljust" "lower" "lstrip" "maketrans" "mro" "msg" "name" "nbytes" "ndim" "numerator" "obj" "object" "offset" "partition" "path" "pop" "popitem" "print_file_and_line" "readonly" "real" "reason" "release" "remove" "replace" "reverse" "rfind" "rindex" "rjust" "rpartition" "rsplit" "rstrip" "setdefault" "setter" "shape" "sort" "split" "splitlines" "start" "startswith" "step" "stop" "strerror" "strides" "strip" "suboffsets" "swapcase" "symmetric_difference" "symmetric_difference_update" "text" "title" "to_bytes" "tobytes" "tolist" "toreadonly" "translate" "union" "update" "upper" "value" "values" "with_traceback" "zfill"

))

(declare (standard-bindings) (extended-bindings) (block) (not safe))

(define-macro (define-hash-definitions . quoted)

  (define definitions
    '(
       ;; hash constants for 29 bit fixnums (these were determined by
       ;; the search algorithm below)

       (define hash-prime #x103D327A)
       (define hash-basis #x011C9DC5)
       (define hash-shift1 13)
       (define hash-shift2 16) ;; (- 29 shift1)
       (define hash-mask #x1FFFFFFF) ;; (- (expt 2 29) 1)

       (define (hash-string str)
         (let loop ((h hash-basis) (i (fx- (string-length str) 1)))
           (if (fx< i 0)
               (fxand hash-mask h)
               (loop (fxwrap* hash-prime
                              (fxxor h (char->integer (string-ref str i))))
                     (fx- i 1)))))

       (define (hash-scale h range)
         (fxarithmetic-shift-right
          (fx* range (fxarithmetic-shift-right h hash-shift1))
          hash-shift2))))

  `(begin
     ,@definitions
     (define hash-definitions ',definitions)))

(define-hash-definitions)

;; htable constructor and operations

(define (make-htable range)
  (make-vector range #f))

(define (htable-member ht key)
  (let* ((range (vector-length ht))
         (i (hash-scale (hash-string key) range))
         (x (vector-ref ht i)))
    (and x
         (string=? x key)
         i)))

(define (htable-add! ht key)
  (let* ((range (vector-length ht))
         (i (hash-scale (hash-string key) range))
         (x (vector-ref ht i)))
    (if x
        #f
        (begin
          (vector-set! ht i key)
          #t))))

(define (htable-fill! ht names)
  (let loop ((lst names))
    (cond ((null? lst)
           ht)
          ((htable-add! ht (car lst))
           (loop (cdr lst)))
          (else
           #f))))

(define (list->htable names size-limit)
  (let* ((len (length names))
         (start-range (fx* len 2)))
    (let loop ((range start-range))
      (or (htable-fill! (make-htable range) names)
          (if (fx= range size-limit)
              #f
              (loop (fx+ range 1)))))))

(begin

;; generation of hash.scm hash functions based on above hash constants

(define ht (list->htable intrinsic-names 0))

(define generated-code
  (with-output-to-string
    (lambda ()
      (newline)
      (for-each (lambda (expr) (pretty-print expr) (newline))
                hash-definitions)
      (display "(define htable-of-intrinsic-names '")
      (write ht)
      (display ")\n"))))

(define hash-file "hash.scm")

(define output
  (with-input-from-file
      hash-file
    (lambda ()
      (let loop ((keep #t) (rev-output '()))
        (let ((line (read-line)))
          (cond ((eof-object? line)
                 (string-concatenate (reverse rev-output) "\n"))
                ((equal? ";;BEGIN-GENERATED-CODE" line)
                 (loop #f (cons generated-code (cons line rev-output))))
                ((or (equal? ";;END-GENERATED-CODE" line)
                     keep)
                 (loop #t (cons line rev-output)))
                (else
                 (loop #f rev-output))))))))

(with-output-to-file
    hash-file
  (lambda ()
    (display output)))

)

#;
(begin

;; algorithm to search for good hash constants

(define best-range (fx* (length intrinsic-names) 32))

(define (search-best-shift)
  (set! hash-shift1 12)
  (let loop ((best #f))
    (set! hash-shift2 (fx- 29 hash-shift1))
    (if (fx<= hash-shift1 16)
        (let ((ht (list->htable intrinsic-names best-range)))
          (set! hash-shift1 (fx+ hash-shift1 1))
          (if best
              (if (and ht (fx< (vector-length ht) (cadr best)))
                  (loop (list hash-shift1 (vector-length ht)))
                  (loop best))
              (if ht
                  (loop (list hash-shift1 (vector-length ht)))
                  (loop #f))))
        best)))

(define (search-best-prime)
  (let loop ((best #f))
    (let ((x (search-best-shift)))

      (define (new-best)
        (let ((best (cons hash-prime x)))
          (pretty-print best)
          (force-output)
          (set! best-range (cadr x))
          (next best)))

      (define (next best)
        (set! hash-prime (random-integer #x1FFFFFFF))
        (loop best))

      (if best
          (if (and x (fx< (cadr x) (caddr best)))
              (new-best)
              (next best))
          (if x
              (new-best)
              (next #f))))))

(define (search-best-basis)
  (let loop ((best #f))
    (let ((x (search-best-shift)))

      (define (new-best)
        (let ((best (cons hash-basis x)))
          (pretty-print best)
          (force-output)
          (set! best-range (cadr x))
          (next best)))

      (define (next best)
        (set! hash-basis (random-integer #x1FFFFFFF))
        (loop best))

      (if best
          (if (and x (fx< (cadr x) (caddr best)))
              (new-best)
              (next best))
          (if x
              (new-best)
              (next #f))))))

(random-source-randomize! default-random-source)

(search-best-prime)
;;(search-best-basis)
)
