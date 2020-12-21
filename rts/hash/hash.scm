;; =============================================================================
;;   Hashing
;; =============================================================================

;; This hash function gives perfect hashing for Python "instrinsic" names.
;; See gen-hash.scm for the algorithm to find good hash function constants.
;; The hashing function returns an integer in the range 0 .. 2**29 - 1 which
;; must fit in a fixnum (for Gambit this is true even on 32 bit processors).

;;BEGIN-GENERATED-CODE

(define hash-prime 272446074)

(define hash-basis 18652613)

(define hash-shift1 13)

(define hash-shift2 16)

(define hash-mask 536870911)

(define (hash-string str)
  (let loop ((h hash-basis) (i (fx- (string-length str) 1)))
    (if (fx< i 0)
        (fxand hash-mask h)
        (loop (fxwrap* hash-prime (fxxor h (char->integer (string-ref str i))))
              (fx- i 1)))))

(define (hash-scale h range)
  (fxarithmetic-shift-right
   (fx* range (fxarithmetic-shift-right h hash-shift1))
   hash-shift2))

(define htable-of-intrinsic-names '#(#f #f #f #f #f #f #f #f "start" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "__cause__" #f #f #f "__float__" #f #f #f #f #f #f #f #f #f #f #f "fromhex" #f #f #f "filename2" #f #f "pop" #f #f #f #f #f #f "real" "c_contiguous" #f #f #f "__getattribute__" #f #f #f #f #f #f #f "format" #f "__getitem__" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "conjugate" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "hex" #f "endswith" #f #f "__pow__" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "sort" #f #f #f "swapcase" #f #f #f #f #f #f #f #f #f #f "__rtruediv__" #f #f #f #f "__mul__" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "__format__" #f #f #f "__mod__" #f #f #f #f #f #f "__self_class__" #f #f #f "__rlshift__" #f #f #f #f "__flags__" #f #f #f #f #f #f #f "expandtabs" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "text" #f #f #f #f #f #f #f "object" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "startswith" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "__or__" #f #f #f #f #f #f #f "obj" #f #f #f #f #f #f #f #f #f #f #f #f #f "step" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "symmetric_difference_update" "value" #f #f #f "itemsize" #f #f "__add__" #f #f #f #f #f #f #f #f #f #f #f #f #f #f "characters_written" #f #f #f #f #f #f #f #f #f "tolist" #f #f #f #f #f #f "__int__" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "readonly" #f #f "__module__" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "__sub__" "__new__" #f #f "with_traceback" #f "__setattr__" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "indices" #f #f "__iadd__" #f #f #f "__init__" #f #f #f #f #f #f #f #f #f #f #f #f #f #f "__traceback__" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "__floordiv__" #f "difference_update" #f #f #f #f #f "cast" "__dictoffset__" #f #f #f #f #f #f #f #f #f "__length_hint__" #f #f #f #f #f #f #f #f #f #f "__name__" #f "__subclasshook__" #f #f #f #f "zfill" #f #f #f #f #f #f #f #f "__qualname__" #f #f "__contains__" #f #f #f #f #f #f #f #f #f #f #f #f "__rshift__" #f #f "__init_subclass__" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "translate" #f #f #f #f #f "maketrans" #f #f #f #f #f #f "__isub__" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "rindex" #f #f #f "isalpha" "rsplit" #f #f #f #f #f #f #f #f #f #f "__rfloordiv__" #f #f #f "lower" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "__rdivmod__" #f #f #f #f #f "__rxor__" #f "__dir__" #f #f #f #f #f "__ge__" "__round__" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "__floor__" #f #f #f #f #f #f "upper" #f #f #f #f #f #f #f #f #f #f #f #f "__reduce_ex__" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "__radd__" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "__basicsize__" #f #f #f #f #f "isalnum" #f #f #f #f #f #f #f #f #f #f #f #f "__subclasscheck__" #f #f "insert" "__hash__" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "fset" #f #f #f #f #f #f #f #f #f #f #f #f #f "deleter" #f #f #f #f #f #f #f #f #f #f #f #f #f #f "imag" #f #f #f #f #f #f #f #f #f #f #f "mro" #f #f "__index__" #f #f #f #f #f #f #f #f #f #f #f "__ceil__" #f #f #f #f #f #f #f #f #f #f #f "__rsub__" #f "__ror__" #f #f #f "getter" #f #f #f #f #f #f #f #f #f #f #f #f #f #f "count" #f #f #f #f #f #f #f #f #f #f "remove" #f #f #f #f #f "__rmod__" "__neg__" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "path" #f "__subclasses__" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "__isabstractmethod__" #f #f #f #f "reverse" #f #f #f "suboffsets" #f #f #f #f #f #f "__reversed__" #f #f "update" #f #f #f #f "end" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "__xor__" #f #f #f #f #f #f #f #f #f "__eq__" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "__getnewargs__" #f #f #f #f #f #f #f "msg" #f #f #f #f #f #f #f #f #f #f #f #f #f #f "istitle" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "__get__" #f #f #f #f #f #f #f #f #f "__pos__" #f #f #f "setter" #f #f "__len__" #f "__ior__" "islower" #f #f #f #f #f #f #f "args" #f #f #f #f #f #f #f #f "copy" #f #f #f #f #f #f "__invert__" #f #f #f #f #f #f #f #f #f #f #f "__gt__" #f #f #f #f #f #f #f #f #f #f #f #f "print_file_and_line" #f "filename" #f #f #f #f #f #f "rpartition" #f #f #f #f #f "symmetric_difference" "__class__" #f #f #f #f #f #f #f #f #f #f #f #f "__delitem__" #f #f #f "get" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "clear" #f #f "__set_format__" #f "union" #f #f #f #f #f #f #f #f #f #f #f #f #f "keys" #f #f "isdisjoint" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "f_contiguous" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "__reduce__" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "setdefault" #f #f #f #f #f #f #f #f #f #f #f #f "center" #f #f #f #f #f #f #f "rfind" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "errno" #f #f #f #f "__rand__" "__ne__" "rjust" #f #f #f #f #f #f #f "__context__" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "casefold" #f #f #f #f "intersection" #f #f "format_map" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "find" #f #f #f #f #f #f #f #f "encode" #f #f #f #f #f #f "strerror" #f #f #f "__le__" #f #f #f "rstrip" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "append" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "isprintable" #f #f #f #f #f #f #f #f "__divmod__" #f #f #f "replace" #f #f #f #f #f "stop" #f #f #f #f #f #f #f #f #f #f "__prepare__" #f "isdigit" #f #f #f #f #f #f "ljust" #f #f #f #f #f #f #f "lstrip" #f #f #f #f #f #f #f #f #f #f #f #f #f "__set__" #f "__base__" #f #f #f #f #f #f #f #f #f #f #f #f "is_integer" #f "nbytes" #f #f #f #f #f #f #f #f #f #f #f "name" #f #f #f #f #f "__bool__" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "index" #f #f "lineno" #f #f #f #f #f #f #f #f #f #f #f #f #f "__bases__" #f #f #f #f #f #f #f #f #f #f #f "reason" #f "__delattr__" #f "__sizeof__" #f #f #f #f #f "shape" #f "splitlines" #f #f #f #f #f #f #f #f #f "__alloc__" #f "decode" "isspace" #f #f #f #f #f "isnumeric" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "__mro__" "__rmul__" #f #f #f #f #f #f #f #f #f #f #f #f #f "__weakrefoffset__" #f #f #f #f #f "__lshift__" #f #f #f #f #f #f #f #f #f #f "__and__" #f "issuperset" #f #f #f #f #f #f "to_bytes" #f #f #f #f "discard" #f #f #f "contiguous" #f #f #f #f "fromkeys" "toreadonly" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "title" #f "__setstate__" #f #f #f #f #f #f "__doc__" #f #f #f #f #f #f #f "fget" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "__call__" #f #f #f "numerator" #f #f #f #f #f #f "partition" "__instancecheck__" #f #f #f #f #f "__trunc__" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "__exit__" #f #f #f #f #f #f #f "denominator" #f #f "extend" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "isupper" #f #f #f #f #f #f "isascii" #f #f #f #f "intersection_update" #f #f #f #f #f "__getformat__" #f #f #f "__self__" #f #f #f #f #f "__thisclass__" #f "__next__" #f #f #f #f "__imul__" #f "encoding" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "strides" #f #f #f #f #f "__str__" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "__delete__" #f #f "__iand__" "bit_length" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "__abs__" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "popitem" #f #f #f #f #f #f #f #f #f #f #f #f #f #f "values" #f #f #f #f #f #f #f #f #f #f "isdecimal" #f #f #f #f #f "items" #f #f #f #f #f #f #f #f #f "__rpow__" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "split" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "tobytes" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "offset" "release" #f #f #f #f #f #f #f #f #f "code" #f #f "__suppress_context__" #f #f #f #f #f #f #f #f "__func__" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "issubset" #f #f #f #f #f "ndim" #f #f #f #f #f #f #f #f #f #f #f "__repr__" #f #f #f #f #f #f #f #f #f "__enter__" "__itemsize__" #f #f "fdel" #f #f #f #f #f #f #f "__ixor__" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "__rrshift__" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "from_bytes" #f #f #f #f "as_integer_ratio" #f #f #f #f #f "join" "add" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "__truediv__" #f #f #f #f #f #f #f #f #f #f "__iter__" #f #f #f #f "__dict__" #f #f #f #f #f #f #f #f #f #f "capitalize" #f #f #f #f "strip" #f #f "__text_signature__" #f #f "difference" #f "__setitem__" #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f "__lt__" #f #f "isidentifier" #f #f))

;;END-GENERATED-CODE

(define (truncate-hash n)
  (bitwise-and hash-mask n))

(define (fast-range-hash hash range)
  (hash-scale hash range))

(define hash-FNV1a hash-string) ;; rename this export as it is now only loosely inspired by FNV1a

#|
;; Old hash function

;; TODO: explore faster alternative using this approach:
;; https://lemire.me/blog/2016/06/27/a-fast-alternative-to-the-modulo-reduction/
;; This proved to be unsuccesful with hash-FNVA1, both 32 and 64 bits
(define (fast-range-hash hash range)
  (modulo hash range))

;; Biggest fixnum Mersene prime
;; See explanation here: https://stackoverflow.com/a/37614051/5079316
(define max-hash-64 (- (expt 2 61) 1))
(define max-hash-32 (- (expt 2 29) 1))

(define (truncate-hash-32 x) (remainder x max-hash-32))
(define (truncate-hash-64 x) (remainder x max-hash-64))

;; Litterally just taken from here
;; https://en.wikipedia.org/wiki/Fowler%E2%80%93Noll%E2%80%93Vo_hash_function#FNV_hash_parameters
(define FNV1a-prime-64 #x00000100000001B3)
;;(define FNV1a-offset-basis-64 #xcbf29ce484222325)
(define FNV1a-offset-basis-64 #xbf29ce484222325)

(define FNV1a-prime-32 #x01000193 )
(define FNV1a-offset-basis-32 #x811c9dc5)

(define (hash-FNV1a-32 string)
  (let ((bytes (map char->integer (string->list string)))
        (h FNV1a-offset-basis-32))
    (let loop ((bytes bytes) (h h))
      (if (null? bytes)
        h
        (loop
          (cdr bytes)
          (truncate-hash-32 (fxwrap* (bitwise-xor h (car bytes)) FNV1a-prime-32)))))))

(define (hash-FNV1a-64 string)
  (let ((bytes (map char->integer (string->list string)))
        (h FNV1a-offset-basis-64))
    (let loop ((bytes bytes) (h h))
      (if (null? bytes)
        h
        (loop
          (cdr bytes)
          (truncate-hash-64 (fxwrap* (bitwise-xor h (car bytes)) FNV1a-prime-64)))))))

(define truncate-hash truncate-hash-32)
(define hash-FNV1a hash-FNV1a-32)
|#
