(##import bigloo)
(##include "/home/olivier/udem-dlteam/zipi/etc/../rts/hclass.bgl")
(##include "/home/olivier/udem-dlteam/zipi/etc/../rts/hclass.scm")
(##include "/home/olivier/udem-dlteam/zipi/etc/../rts/object.bgl")
(##include "/home/olivier/udem-dlteam/zipi/etc/../rts/object.scm")
(##include "/home/olivier/udem-dlteam/zipi/etc/../rts/iterator.bgl")
(##include "/home/olivier/udem-dlteam/zipi/etc/../rts/iterator.scm")
(##include "/home/olivier/udem-dlteam/zipi/etc/../rts/import.bgl")
(##include "/home/olivier/udem-dlteam/zipi/etc/../rts/import.scm")
(define py-module
  (lambda (%global %caches)
    (set! py-import-root "/home/olivier/udem-dlteam/zipi/tests/assert/")
    (global-put!
     %global
     (& "__name__")
     (py-str-from-scheme "assert_false")
     (vector-ref %caches 0))
    (global-put!
     %global
     (& "__file__")
     (py-str-from-scheme "./assert/assert_false.py")
     (vector-ref %caches 1))
    (if (not (py-test #f)) (py-throw py-builtin-AssertionError))))
(begin
  (define (main args) (py-module (py-make-global) (py-make-caches 2)))
  (main (command-line)))
