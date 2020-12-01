(define (target-driver target)
   (case target
      ((bigloo) (error "zpc" "bigloo target not supported" "use \"zpc.bigloo\""))
      ((gambit) (pyc-gambit-driver))
      ((javascript) (pyc-javascript-driver))
      ((scheme) (pyc-scheme-driver))
      (else (error "zpc" "unknown target" target))))
