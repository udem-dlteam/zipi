(define-macro (all-bytecodes)
   (let ((l '(MOD
	      NOP SEQ BLOCK
	      PRAGMA UNINIT NUM STR
	      VAR0 VAR1 VAR2 VAR3 VAR4 VAR5
	      REF0 REF1 REF2 REF3 REF4 REF5
	      SET0 SET1 SET2 SET3 SET4 SET5
	      GGET GPUT GET PUT
	      LAM0 LAM1 LAM2 LAM3 LAM4
	      RLAM0 RLAM1 RLAM2 RLAM3 RLAM4
	      TAIL RET
	      CALL0 CALL1 CALL2 CALL3 CALL4
	      + -
	      TEST
	      <)))
      `',(map (lambda (s n)
		 (cons s n))
	    l (iota (length l)))))
