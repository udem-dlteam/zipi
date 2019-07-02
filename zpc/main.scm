(define (target-driver target)
   (case target
      ((bigloo) (pyc-bigloo-driver))
      ((gambit) (pyc-gambit-driver))
      ((javascript) (pyc-javascript-driver))
      ((scheme) (pyc-scheme-driver))
      (else (error "zpc" "unknown target" target))))
