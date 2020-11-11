(define-library (hash)
  (export
    truncate-hash
    fast-range-hash
    hash-FNV1a)

  (import gambit)
  (include "hash.scm"))
