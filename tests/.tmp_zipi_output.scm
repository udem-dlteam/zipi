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
    (set! py-import-root "/home/olivier/udem-dlteam/zipi/tests/exceptions/")
    (global-put!
     %global
     (& "__name__")
     (py-str-from-scheme "raisable")
     (vector-ref %caches 0))
    (global-put!
     %global
     (& "__file__")
     (py-str-from-scheme "./exceptions/raisable.py")
     (vector-ref %caches 1))
    (with-handler
     (lambda (%exn)
       (cond ((py-isinstance?
               %exn
               (global-get %global (& "ValueError") (vector-ref %caches 2)))
              (begin
                (py-call (global-get
                          %global
                          (& "print")
                          (vector-ref %caches 3))
                         (py-str-from-scheme
                          "Cannot raise object which is not subclass of BaseException"))))))
     (begin (py-throw 0)))))
(begin
  (define (main args) (py-module (py-make-global) (py-make-caches 4)))
  (main (command-line)))
