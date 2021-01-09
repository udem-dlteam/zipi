(define (py-add-floatX-floatY-fallback self2 other3)
  (py-float-from-scheme
   (py+ (py-float-to-scheme self2) (py-float-to-scheme other3))))

(define-macro (py-add-floatX-floatY-inline self2 other3)
  `(let ((self2 ,self2) (other3 ,other3))
     (py-float-from-scheme
      (py+ (py-float-to-scheme self2) (py-float-to-scheme other3)))))

(define (py-add-floatX-boolY-fallback self5 other6)
  (py-float-from-scheme
   (py+ (py-float-to-scheme self5) (py-bool-to-scheme other6))))

(define (py-add-floatX-sintY-fallback self8 other9)
  (py-float-from-scheme
   (py+ (py-float-to-scheme self8) (py-sint-to-scheme other9))))

(define (py-add-floatX-bintY-fallback self11 other12)
  (py-float-from-scheme
   (py+ (py-float-to-scheme self11) (py-bint-to-scheme other12))))

(define (py-add-boolX-floatY-fallback self14 other15)
  (py-float-from-scheme
   (py+ (py-bool-to-scheme other15) (py-float-to-scheme self14))))

(define (py-add-boolX-boolY-fallback self17 other18)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme self17) (py-bool-to-scheme other18))))

(define (py-add-boolX-sintY-fallback self20 other21)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme self20) (py-sint-to-scheme other21))))

(define (py-add-boolX-bintY-fallback self23 other24)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme self23) (py-bint-to-scheme other24))))

(define (py-add-sintX-floatY-fallback self26 other27)
  (py-float-from-scheme
   (py+ (py-sint-to-scheme other27) (py-float-to-scheme self26))))

(define (py-add-sintX-boolY-fallback self29 other30)
  (py-int-from-scheme
   (py+ (py-sint-to-scheme self29) (py-bool-to-scheme other30))))

(define (py-add-sintX-sintY-fallback self32 other33)
  (py-int-from-scheme
   (py+ (py-sint-to-scheme self32) (py-sint-to-scheme other33))))

(define-macro (py-add-sintX-sintY-inline self32 other33)
  `(let ((self32 ,self32) (other33 ,other33))
     (py-int-from-scheme
      (py+ (py-sint-to-scheme self32) (py-sint-to-scheme other33)))))

(define (py-add-sintX-bintY-fallback self35 other36)
  (py-int-from-scheme
   (py+ (py-sint-to-scheme self35) (py-bint-to-scheme other36))))

(define (py-add-bintX-floatY-fallback self38 other39)
  (py-float-from-scheme
   (py+ (py-bint-to-scheme other39) (py-float-to-scheme self38))))

(define (py-add-bintX-boolY-fallback self41 other42)
  (py-int-from-scheme
   (py+ (py-bint-to-scheme self41) (py-bool-to-scheme other42))))

(define (py-add-bintX-sintY-fallback self44 other45)
  (py-int-from-scheme
   (py+ (py-bint-to-scheme self44) (py-sint-to-scheme other45))))

(define (py-add-bintX-bintY-fallback self47 other48)
  (py-int-from-scheme
   (py+ (py-bint-to-scheme self47) (py-bint-to-scheme other48))))

(define (py-bitand-floatX-floatY-fallback self50 other51)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'float'"))))

(define-macro (py-bitand-floatX-floatY-inline self50 other51)
  `(let ((self50 ,self50) (other51 ,other51))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for &: 'float' and 'float'")))))

(define (py-bitand-floatX-boolY-fallback self53 other54)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'bool'"))))

(define (py-bitand-floatX-sintY-fallback self56 other57)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'int'"))))

(define (py-bitand-floatX-bintY-fallback self59 other60)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'int'"))))

(define (py-bitand-boolX-floatY-fallback self62 other63)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'bool' and 'float'"))))

(define (py-bitand-boolX-boolY-fallback self65 other66)
  (if (py-test-is self65 py-True) other66 py-False))

(define (py-bitand-boolX-sintY-fallback self68 other69)
  (py-int-from-scheme
   (py& (py-bool-to-scheme self68) (py-sint-to-scheme other69))))

(define (py-bitand-boolX-bintY-fallback self71 other72)
  (py-int-from-scheme
   (py& (py-bool-to-scheme self71) (py-bint-to-scheme other72))))

(define (py-bitand-sintX-floatY-fallback self74 other75)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'int' and 'float'"))))

(define (py-bitand-sintX-boolY-fallback self77 other78)
  (py-int-from-scheme
   (py& (py-sint-to-scheme self77) (py-bool-to-scheme other78))))

(define (py-bitand-sintX-sintY-fallback self80 other81)
  (py-int-from-scheme
   (py& (py-sint-to-scheme self80) (py-sint-to-scheme other81))))

(define-macro (py-bitand-sintX-sintY-inline self80 other81)
  `(let ((self80 ,self80) (other81 ,other81))
     (py-int-from-scheme
      (py& (py-sint-to-scheme self80) (py-sint-to-scheme other81)))))

(define (py-bitand-sintX-bintY-fallback self83 other84)
  (py-int-from-scheme
   (py& (py-sint-to-scheme self83) (py-bint-to-scheme other84))))

(define (py-bitand-bintX-floatY-fallback self86 other87)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'int' and 'float'"))))

(define (py-bitand-bintX-boolY-fallback self89 other90)
  (py-int-from-scheme
   (py& (py-bint-to-scheme self89) (py-bool-to-scheme other90))))

(define (py-bitand-bintX-sintY-fallback self92 other93)
  (py-int-from-scheme
   (py& (py-bint-to-scheme self92) (py-sint-to-scheme other93))))

(define (py-bitand-bintX-bintY-fallback self95 other96)
  (py-int-from-scheme
   (py& (py-bint-to-scheme self95) (py-bint-to-scheme other96))))

(define (py-bitor-floatX-floatY-fallback self98 other99)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'float'"))))

(define-macro (py-bitor-floatX-floatY-inline self98 other99)
  `(let ((self98 ,self98) (other99 ,other99))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for |: 'float' and 'float'")))))

(define (py-bitor-floatX-boolY-fallback self101 other102)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'bool'"))))

(define (py-bitor-floatX-sintY-fallback self104 other105)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'int'"))))

(define (py-bitor-floatX-bintY-fallback self107 other108)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'int'"))))

(define (py-bitor-boolX-floatY-fallback self110 other111)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'bool' and 'float'"))))

(define (py-bitor-boolX-boolY-fallback self113 other114)
  (if (py-test-is self113 py-True) py-True other114))

(define (py-bitor-boolX-sintY-fallback self116 other117)
  (py-int-from-scheme
   (py+b (py-bool-to-scheme self116) (py-sint-to-scheme other117))))

(define (py-bitor-boolX-bintY-fallback self119 other120)
  (py-int-from-scheme
   (py+b (py-bool-to-scheme self119) (py-bint-to-scheme other120))))

(define (py-bitor-sintX-floatY-fallback self122 other123)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'int' and 'float'"))))

(define (py-bitor-sintX-boolY-fallback self125 other126)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme self125) (py-bool-to-scheme other126))))

(define (py-bitor-sintX-sintY-fallback self128 other129)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme self128) (py-sint-to-scheme other129))))

(define-macro (py-bitor-sintX-sintY-inline self128 other129)
  `(let ((self128 ,self128) (other129 ,other129))
     (py-int-from-scheme
      (py+b (py-sint-to-scheme self128) (py-sint-to-scheme other129)))))

(define (py-bitor-sintX-bintY-fallback self131 other132)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme self131) (py-bint-to-scheme other132))))

(define (py-bitor-bintX-floatY-fallback self134 other135)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'int' and 'float'"))))

(define (py-bitor-bintX-boolY-fallback self137 other138)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme self137) (py-bool-to-scheme other138))))

(define (py-bitor-bintX-sintY-fallback self140 other141)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme self140) (py-sint-to-scheme other141))))

(define (py-bitor-bintX-bintY-fallback self143 other144)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme self143) (py-bint-to-scheme other144))))

(define (py-floordiv-floatX-floatY-fallback self146 other147)
  (if (py-test (py-ne other147 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-float-to-scheme self146) (py-float-to-scheme other147)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define-macro (py-floordiv-floatX-floatY-inline self146 other147)
  `(let ((self146 ,self146) (other147 ,other147))
     (if (py-test (py-ne other147 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py// (py-float-to-scheme self146) (py-float-to-scheme other147)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define (py-floordiv-floatX-boolY-fallback self149 other150)
  (if (py-test (py-ne other150 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py// (py-float-to-scheme self149) (py-bool-to-scheme other150)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-floatX-sintY-fallback self152 other153)
  (if (py-test (py-ne other153 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py// (py-float-to-scheme self152) (py-sint-to-scheme other153)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-floatX-bintY-fallback self155 other156)
  (if (py-test (py-ne other156 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py// (py-float-to-scheme self155) (py-bint-to-scheme other156)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-boolX-floatY-fallback self158 other159)
  (if (py-test (py-ne self158 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-bool-to-scheme other159) (py-float-to-scheme self158)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-boolX-boolY-fallback self161 other162)
  (if (py-test (py-ne other162 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bool-to-scheme self161) (py-bool-to-scheme other162)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-boolX-sintY-fallback self164 other165)
  (if (py-test (py-ne other165 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bool-to-scheme self164) (py-sint-to-scheme other165)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-boolX-bintY-fallback self167 other168)
  (if (py-test (py-ne other168 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bool-to-scheme self167) (py-bint-to-scheme other168)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-sintX-floatY-fallback self170 other171)
  (if (py-test (py-ne self170 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-sint-to-scheme other171) (py-float-to-scheme self170)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-sintX-boolY-fallback self173 other174)
  (if (py-test (py-ne other174 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-sint-to-scheme self173) (py-bool-to-scheme other174)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-sintX-sintY-fallback self176 other177)
  (if (py-test (py-ne other177 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-sint-to-scheme self176) (py-sint-to-scheme other177)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define-macro (py-floordiv-sintX-sintY-inline self176 other177)
  `(let ((self176 ,self176) (other177 ,other177))
     (if (py-test (py-ne other177 (py-int-from-scheme 0)))
         (py-int-from-scheme
          (py// (py-sint-to-scheme self176) (py-sint-to-scheme other177)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "integer division by zero"))))))

(define (py-floordiv-sintX-bintY-fallback self179 other180)
  (if (py-test (py-ne other180 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-sint-to-scheme self179) (py-bint-to-scheme other180)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-bintX-floatY-fallback self182 other183)
  (if (py-test (py-ne self182 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-bint-to-scheme other183) (py-float-to-scheme self182)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-bintX-boolY-fallback self185 other186)
  (if (py-test (py-ne other186 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bint-to-scheme self185) (py-bool-to-scheme other186)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-bintX-sintY-fallback self188 other189)
  (if (py-test (py-ne other189 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bint-to-scheme self188) (py-sint-to-scheme other189)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-bintX-bintY-fallback self191 other192)
  (if (py-test (py-ne other192 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bint-to-scheme self191) (py-bint-to-scheme other192)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-lshift-floatX-floatY-fallback self194 other195)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'float'"))))

(define-macro (py-lshift-floatX-floatY-inline self194 other195)
  `(let ((self194 ,self194) (other195 ,other195))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for <<: 'float' and 'float'")))))

(define (py-lshift-floatX-boolY-fallback self197 other198)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'bool'"))))

(define (py-lshift-floatX-sintY-fallback self200 other201)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'int'"))))

(define (py-lshift-floatX-bintY-fallback self203 other204)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'int'"))))

(define (py-lshift-boolX-floatY-fallback self206 other207)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'bool' and 'float'"))))

(define (py-lshift-boolX-boolY-fallback self209 other210)
  (py-int-from-scheme
   (py<< (py-bool-to-scheme self209) (py-bool-to-scheme other210))))

(define (py-lshift-boolX-sintY-fallback self212 other213)
  (py-int-from-scheme
   (py<< (py-bool-to-scheme self212) (py-sint-to-scheme other213))))

(define (py-lshift-boolX-bintY-fallback self215 other216)
  (py-int-from-scheme
   (py<< (py-bool-to-scheme self215) (py-bint-to-scheme other216))))

(define (py-lshift-sintX-floatY-fallback self218 other219)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'int' and 'float'"))))

(define (py-lshift-sintX-boolY-fallback self221 other222)
  (py-int-from-scheme
   (py<< (py-sint-to-scheme self221) (py-bool-to-scheme other222))))

(define (py-lshift-sintX-sintY-fallback self224 other225)
  (py-int-from-scheme
   (py<< (py-sint-to-scheme self224) (py-sint-to-scheme other225))))

(define-macro (py-lshift-sintX-sintY-inline self224 other225)
  `(let ((self224 ,self224) (other225 ,other225))
     (py-int-from-scheme
      (py<< (py-sint-to-scheme self224) (py-sint-to-scheme other225)))))

(define (py-lshift-sintX-bintY-fallback self227 other228)
  (py-int-from-scheme
   (py<< (py-sint-to-scheme self227) (py-bint-to-scheme other228))))

(define (py-lshift-bintX-floatY-fallback self230 other231)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'int' and 'float'"))))

(define (py-lshift-bintX-boolY-fallback self233 other234)
  (py-int-from-scheme
   (py<< (py-bint-to-scheme self233) (py-bool-to-scheme other234))))

(define (py-lshift-bintX-sintY-fallback self236 other237)
  (py-int-from-scheme
   (py<< (py-bint-to-scheme self236) (py-sint-to-scheme other237))))

(define (py-lshift-bintX-bintY-fallback self239 other240)
  (py-int-from-scheme
   (py<< (py-bint-to-scheme self239) (py-bint-to-scheme other240))))

(define (py-matmul-floatX-floatY-fallback self242 other243)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'float'"))))

(define-macro (py-matmul-floatX-floatY-inline self242 other243)
  `(let ((self242 ,self242) (other243 ,other243))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @: 'float' and 'float'")))))

(define (py-matmul-floatX-boolY-fallback self245 other246)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'bool'"))))

(define (py-matmul-floatX-sintY-fallback self248 other249)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'int'"))))

(define (py-matmul-floatX-bintY-fallback self251 other252)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'int'"))))

(define (py-matmul-boolX-floatY-fallback self254 other255)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'float'"))))

(define (py-matmul-boolX-boolY-fallback self257 other258)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'bool'"))))

(define (py-matmul-boolX-sintY-fallback self260 other261)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'int'"))))

(define (py-matmul-boolX-bintY-fallback self263 other264)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'int'"))))

(define (py-matmul-sintX-floatY-fallback self266 other267)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'float'"))))

(define (py-matmul-sintX-boolY-fallback self269 other270)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'bool'"))))

(define (py-matmul-sintX-sintY-fallback self272 other273)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define-macro (py-matmul-sintX-sintY-inline self272 other273)
  `(let ((self272 ,self272) (other273 ,other273))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @: 'int' and 'int'")))))

(define (py-matmul-sintX-bintY-fallback self275 other276)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-matmul-bintX-floatY-fallback self278 other279)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'float'"))))

(define (py-matmul-bintX-boolY-fallback self281 other282)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'bool'"))))

(define (py-matmul-bintX-sintY-fallback self284 other285)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-matmul-bintX-bintY-fallback self287 other288)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-mod-floatX-floatY-fallback self290 other291)
  (if (py-test (py-ne other291 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-float-to-scheme self290) (py-float-to-scheme other291)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define-macro (py-mod-floatX-floatY-inline self290 other291)
  `(let ((self290 ,self290) (other291 ,other291))
     (if (py-test (py-ne other291 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py% (py-float-to-scheme self290) (py-float-to-scheme other291)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float modulo by zero"))))))

(define (py-mod-floatX-boolY-fallback self293 other294)
  (if (py-test (py-ne other294 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py% (py-float-to-scheme self293) (py-bool-to-scheme other294)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-floatX-sintY-fallback self296 other297)
  (if (py-test (py-ne other297 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py% (py-float-to-scheme self296) (py-sint-to-scheme other297)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-floatX-bintY-fallback self299 other300)
  (if (py-test (py-ne other300 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py% (py-float-to-scheme self299) (py-bint-to-scheme other300)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-boolX-floatY-fallback self302 other303)
  (if (py-test (py-ne self302 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-bool-to-scheme other303) (py-float-to-scheme self302)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-boolX-boolY-fallback self305 other306)
  (if (py-test (py-ne other306 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bool-to-scheme self305) (py-bool-to-scheme other306)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-boolX-sintY-fallback self308 other309)
  (if (py-test (py-ne other309 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bool-to-scheme self308) (py-sint-to-scheme other309)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-boolX-bintY-fallback self311 other312)
  (if (py-test (py-ne other312 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bool-to-scheme self311) (py-bint-to-scheme other312)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-sintX-floatY-fallback self314 other315)
  (if (py-test (py-ne self314 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-sint-to-scheme other315) (py-float-to-scheme self314)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-sintX-boolY-fallback self317 other318)
  (if (py-test (py-ne other318 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-sint-to-scheme self317) (py-bool-to-scheme other318)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-sintX-sintY-fallback self320 other321)
  (if (py-test (py-ne other321 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-sint-to-scheme self320) (py-sint-to-scheme other321)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define-macro (py-mod-sintX-sintY-inline self320 other321)
  `(let ((self320 ,self320) (other321 ,other321))
     (if (py-test (py-ne other321 (py-int-from-scheme 0)))
         (py-int-from-scheme
          (py% (py-sint-to-scheme self320) (py-sint-to-scheme other321)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError (&& "modulo by zero"))))))

(define (py-mod-sintX-bintY-fallback self323 other324)
  (if (py-test (py-ne other324 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-sint-to-scheme self323) (py-bint-to-scheme other324)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-bintX-floatY-fallback self326 other327)
  (if (py-test (py-ne self326 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-bint-to-scheme other327) (py-float-to-scheme self326)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-bintX-boolY-fallback self329 other330)
  (if (py-test (py-ne other330 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bint-to-scheme self329) (py-bool-to-scheme other330)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-bintX-sintY-fallback self332 other333)
  (if (py-test (py-ne other333 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bint-to-scheme self332) (py-sint-to-scheme other333)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-bintX-bintY-fallback self335 other336)
  (if (py-test (py-ne other336 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bint-to-scheme self335) (py-bint-to-scheme other336)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mul-floatX-floatY-fallback self338 other339)
  (py-float-from-scheme
   (py* (py-float-to-scheme self338) (py-float-to-scheme other339))))

(define-macro (py-mul-floatX-floatY-inline self338 other339)
  `(let ((self338 ,self338) (other339 ,other339))
     (py-float-from-scheme
      (py* (py-float-to-scheme self338) (py-float-to-scheme other339)))))

(define (py-mul-floatX-boolY-fallback self341 other342)
  (py-float-from-scheme
   (py* (py-float-to-scheme self341) (py-bool-to-scheme other342))))

(define (py-mul-floatX-sintY-fallback self344 other345)
  (py-float-from-scheme
   (py* (py-float-to-scheme self344) (py-sint-to-scheme other345))))

(define (py-mul-floatX-bintY-fallback self347 other348)
  (py-float-from-scheme
   (py* (py-float-to-scheme self347) (py-bint-to-scheme other348))))

(define (py-mul-boolX-floatY-fallback self350 other351)
  (py-float-from-scheme
   (py* (py-bool-to-scheme other351) (py-float-to-scheme self350))))

(define (py-mul-boolX-boolY-fallback self353 other354)
  (py-int-from-scheme
   (py* (py-bool-to-scheme self353) (py-bool-to-scheme other354))))

(define (py-mul-boolX-sintY-fallback self356 other357)
  (py-int-from-scheme
   (py* (py-bool-to-scheme self356) (py-sint-to-scheme other357))))

(define (py-mul-boolX-bintY-fallback self359 other360)
  (py-int-from-scheme
   (py* (py-bool-to-scheme self359) (py-bint-to-scheme other360))))

(define (py-mul-sintX-floatY-fallback self362 other363)
  (py-float-from-scheme
   (py* (py-sint-to-scheme other363) (py-float-to-scheme self362))))

(define (py-mul-sintX-boolY-fallback self365 other366)
  (py-int-from-scheme
   (py* (py-sint-to-scheme self365) (py-bool-to-scheme other366))))

(define (py-mul-sintX-sintY-fallback self368 other369)
  (py-int-from-scheme
   (py* (py-sint-to-scheme self368) (py-sint-to-scheme other369))))

(define-macro (py-mul-sintX-sintY-inline self368 other369)
  `(let ((self368 ,self368) (other369 ,other369))
     (py-int-from-scheme
      (py* (py-sint-to-scheme self368) (py-sint-to-scheme other369)))))

(define (py-mul-sintX-bintY-fallback self371 other372)
  (py-int-from-scheme
   (py* (py-sint-to-scheme self371) (py-bint-to-scheme other372))))

(define (py-mul-bintX-floatY-fallback self374 other375)
  (py-float-from-scheme
   (py* (py-bint-to-scheme other375) (py-float-to-scheme self374))))

(define (py-mul-bintX-boolY-fallback self377 other378)
  (py-int-from-scheme
   (py* (py-bint-to-scheme self377) (py-bool-to-scheme other378))))

(define (py-mul-bintX-sintY-fallback self380 other381)
  (py-int-from-scheme
   (py* (py-bint-to-scheme self380) (py-sint-to-scheme other381))))

(define (py-mul-bintX-bintY-fallback self383 other384)
  (py-int-from-scheme
   (py* (py-bint-to-scheme self383) (py-bint-to-scheme other384))))

(define (py-pow-floatX-floatY-fallback self386 other387)
  (py-float-from-scheme
   (py** (py-float-to-scheme self386) (py-float-to-scheme other387))))

(define-macro (py-pow-floatX-floatY-inline self386 other387)
  `(let ((self386 ,self386) (other387 ,other387))
     (py-float-from-scheme
      (py** (py-float-to-scheme self386) (py-float-to-scheme other387)))))

(define (py-pow-floatX-boolY-fallback self389 other390)
  (py-float-from-scheme
   (py** (py-float-to-scheme self389) (py-bool-to-scheme other390))))

(define (py-pow-floatX-sintY-fallback self392 other393)
  (py-float-from-scheme
   (py** (py-float-to-scheme self392) (py-sint-to-scheme other393))))

(define (py-pow-floatX-bintY-fallback self395 other396)
  (py-float-from-scheme
   (py** (py-float-to-scheme self395) (py-bint-to-scheme other396))))

(define (py-pow-boolX-floatY-fallback self398 other399)
  (py-float-from-scheme
   (py** (py-bool-to-scheme other399) (py-float-to-scheme self398))))

(define (py-pow-boolX-boolY-fallback self401 other402)
  (py-int-from-scheme
   (py** (py-bool-to-scheme self401) (py-bool-to-scheme other402))))

(define (py-pow-boolX-sintY-fallback self404 other405)
  (py-int-from-scheme
   (py** (py-bool-to-scheme self404) (py-sint-to-scheme other405))))

(define (py-pow-boolX-bintY-fallback self407 other408)
  (py-int-from-scheme
   (py** (py-bool-to-scheme self407) (py-bint-to-scheme other408))))

(define (py-pow-sintX-floatY-fallback self410 other411)
  (py-float-from-scheme
   (py** (py-sint-to-scheme other411) (py-float-to-scheme self410))))

(define (py-pow-sintX-boolY-fallback self413 other414)
  (py-int-from-scheme
   (py** (py-sint-to-scheme self413) (py-bool-to-scheme other414))))

(define (py-pow-sintX-sintY-fallback self416 other417)
  (py-int-from-scheme
   (py** (py-sint-to-scheme self416) (py-sint-to-scheme other417))))

(define-macro (py-pow-sintX-sintY-inline self416 other417)
  `(let ((self416 ,self416) (other417 ,other417))
     (py-int-from-scheme
      (py** (py-sint-to-scheme self416) (py-sint-to-scheme other417)))))

(define (py-pow-sintX-bintY-fallback self419 other420)
  (py-int-from-scheme
   (py** (py-sint-to-scheme self419) (py-bint-to-scheme other420))))

(define (py-pow-bintX-floatY-fallback self422 other423)
  (py-float-from-scheme
   (py** (py-bint-to-scheme other423) (py-float-to-scheme self422))))

(define (py-pow-bintX-boolY-fallback self425 other426)
  (py-int-from-scheme
   (py** (py-bint-to-scheme self425) (py-bool-to-scheme other426))))

(define (py-pow-bintX-sintY-fallback self428 other429)
  (py-int-from-scheme
   (py** (py-bint-to-scheme self428) (py-sint-to-scheme other429))))

(define (py-pow-bintX-bintY-fallback self431 other432)
  (py-int-from-scheme
   (py** (py-bint-to-scheme self431) (py-bint-to-scheme other432))))

(define (py-rshift-floatX-floatY-fallback self434 other435)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'float'"))))

(define-macro (py-rshift-floatX-floatY-inline self434 other435)
  `(let ((self434 ,self434) (other435 ,other435))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for >>: 'float' and 'float'")))))

(define (py-rshift-floatX-boolY-fallback self437 other438)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'bool'"))))

(define (py-rshift-floatX-sintY-fallback self440 other441)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'int'"))))

(define (py-rshift-floatX-bintY-fallback self443 other444)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'int'"))))

(define (py-rshift-boolX-floatY-fallback self446 other447)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'bool' and 'float'"))))

(define (py-rshift-boolX-boolY-fallback self449 other450)
  (py-int-from-scheme
   (py>> (py-bool-to-scheme self449) (py-bool-to-scheme other450))))

(define (py-rshift-boolX-sintY-fallback self452 other453)
  (py-int-from-scheme
   (py>> (py-sint-to-scheme self452) (py-bool-to-scheme other453))))

(define (py-rshift-boolX-bintY-fallback self455 other456)
  (py-int-from-scheme
   (py>> (py-bint-to-scheme self455) (py-bool-to-scheme other456))))

(define (py-rshift-sintX-floatY-fallback self458 other459)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'int' and 'float'"))))

(define (py-rshift-sintX-boolY-fallback self461 other462)
  (py-int-from-scheme
   (py>> (py-bool-to-scheme self461) (py-sint-to-scheme other462))))

(define (py-rshift-sintX-sintY-fallback self464 other465)
  (py-int-from-scheme
   (py>> (py-sint-to-scheme self464) (py-sint-to-scheme other465))))

(define-macro (py-rshift-sintX-sintY-inline self464 other465)
  `(let ((self464 ,self464) (other465 ,other465))
     (py-int-from-scheme
      (py>> (py-sint-to-scheme self464) (py-sint-to-scheme other465)))))

(define (py-rshift-sintX-bintY-fallback self467 other468)
  (py-int-from-scheme
   (py>> (py-bint-to-scheme self467) (py-sint-to-scheme other468))))

(define (py-rshift-bintX-floatY-fallback self470 other471)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'int' and 'float'"))))

(define (py-rshift-bintX-boolY-fallback self473 other474)
  (py-int-from-scheme
   (py>> (py-bool-to-scheme self473) (py-bint-to-scheme other474))))

(define (py-rshift-bintX-sintY-fallback self476 other477)
  (py-int-from-scheme
   (py>> (py-sint-to-scheme self476) (py-bint-to-scheme other477))))

(define (py-rshift-bintX-bintY-fallback self479 other480)
  (py-int-from-scheme
   (py>> (py-bint-to-scheme self479) (py-bint-to-scheme other480))))

(define (py-sub-floatX-floatY-fallback self482 other483)
  (py-float-from-scheme
   (py- (py-float-to-scheme self482) (py-float-to-scheme other483))))

(define-macro (py-sub-floatX-floatY-inline self482 other483)
  `(let ((self482 ,self482) (other483 ,other483))
     (py-float-from-scheme
      (py- (py-float-to-scheme self482) (py-float-to-scheme other483)))))

(define (py-sub-floatX-boolY-fallback self485 other486)
  (py-float-from-scheme
   (py- (py-float-to-scheme self485) (py-bool-to-scheme other486))))

(define (py-sub-floatX-sintY-fallback self488 other489)
  (py-float-from-scheme
   (py- (py-float-to-scheme self488) (py-sint-to-scheme other489))))

(define (py-sub-floatX-bintY-fallback self491 other492)
  (py-float-from-scheme
   (py- (py-float-to-scheme self491) (py-bint-to-scheme other492))))

(define (py-sub-boolX-floatY-fallback self494 other495)
  (py-float-from-scheme
   (py- (py-bool-to-scheme other495) (py-float-to-scheme self494))))

(define (py-sub-boolX-boolY-fallback self497 other498)
  (py-int-from-scheme
   (py- (py-bool-to-scheme self497) (py-bool-to-scheme other498))))

(define (py-sub-boolX-sintY-fallback self500 other501)
  (py-int-from-scheme
   (py- (py-bool-to-scheme self500) (py-sint-to-scheme other501))))

(define (py-sub-boolX-bintY-fallback self503 other504)
  (py-int-from-scheme
   (py- (py-bool-to-scheme self503) (py-bint-to-scheme other504))))

(define (py-sub-sintX-floatY-fallback self506 other507)
  (py-float-from-scheme
   (py- (py-sint-to-scheme other507) (py-float-to-scheme self506))))

(define (py-sub-sintX-boolY-fallback self509 other510)
  (py-int-from-scheme
   (py- (py-sint-to-scheme self509) (py-bool-to-scheme other510))))

(define (py-sub-sintX-sintY-fallback self512 other513)
  (py-int-from-scheme
   (py- (py-sint-to-scheme self512) (py-sint-to-scheme other513))))

(define-macro (py-sub-sintX-sintY-inline self512 other513)
  `(let ((self512 ,self512) (other513 ,other513))
     (py-int-from-scheme
      (py- (py-sint-to-scheme self512) (py-sint-to-scheme other513)))))

(define (py-sub-sintX-bintY-fallback self515 other516)
  (py-int-from-scheme
   (py- (py-sint-to-scheme self515) (py-bint-to-scheme other516))))

(define (py-sub-bintX-floatY-fallback self518 other519)
  (py-float-from-scheme
   (py- (py-bint-to-scheme other519) (py-float-to-scheme self518))))

(define (py-sub-bintX-boolY-fallback self521 other522)
  (py-int-from-scheme
   (py- (py-bint-to-scheme self521) (py-bool-to-scheme other522))))

(define (py-sub-bintX-sintY-fallback self524 other525)
  (py-int-from-scheme
   (py- (py-bint-to-scheme self524) (py-sint-to-scheme other525))))

(define (py-sub-bintX-bintY-fallback self527 other528)
  (py-int-from-scheme
   (py- (py-bint-to-scheme self527) (py-bint-to-scheme other528))))

(define (py-truediv-floatX-floatY-fallback self530 other531)
  (if (py-test (py-ne other531 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme self530) (py-float-to-scheme other531)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define-macro (py-truediv-floatX-floatY-inline self530 other531)
  `(let ((self530 ,self530) (other531 ,other531))
     (if (py-test (py-ne other531 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py/ (py-float-to-scheme self530) (py-float-to-scheme other531)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define (py-truediv-floatX-boolY-fallback self533 other534)
  (if (py-test (py-ne other534 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme self533) (py-bool-to-scheme other534)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-floatX-sintY-fallback self536 other537)
  (if (py-test (py-ne other537 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme self536) (py-sint-to-scheme other537)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-floatX-bintY-fallback self539 other540)
  (if (py-test (py-ne other540 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme self539) (py-bint-to-scheme other540)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-boolX-floatY-fallback self542 other543)
  (if (py-test (py-ne self542 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme other543) (py-float-to-scheme self542)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-boolX-boolY-fallback self545 other546)
  (if (py-test (py-ne other546 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme self545) (py-bool-to-scheme other546)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-boolX-sintY-fallback self548 other549)
  (if (py-test (py-ne other549 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme self548) (py-sint-to-scheme other549)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-boolX-bintY-fallback self551 other552)
  (if (py-test (py-ne other552 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme self551) (py-bint-to-scheme other552)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-sintX-floatY-fallback self554 other555)
  (if (py-test (py-ne self554 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme other555) (py-float-to-scheme self554)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-sintX-boolY-fallback self557 other558)
  (if (py-test (py-ne other558 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme self557) (py-bool-to-scheme other558)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-sintX-sintY-fallback self560 other561)
  (if (py-test (py-ne other561 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme self560) (py-sint-to-scheme other561)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define-macro (py-truediv-sintX-sintY-inline self560 other561)
  `(let ((self560 ,self560) (other561 ,other561))
     (if (py-test (py-ne other561 (py-int-from-scheme 0)))
         (py-float-from-scheme
          (py/ (py-sint-to-scheme self560) (py-sint-to-scheme other561)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError (&& "division by zero"))))))

(define (py-truediv-sintX-bintY-fallback self563 other564)
  (if (py-test (py-ne other564 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme self563) (py-bint-to-scheme other564)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-bintX-floatY-fallback self566 other567)
  (if (py-test (py-ne self566 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme other567) (py-float-to-scheme self566)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-bintX-boolY-fallback self569 other570)
  (if (py-test (py-ne other570 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme self569) (py-bool-to-scheme other570)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-bintX-sintY-fallback self572 other573)
  (if (py-test (py-ne other573 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme self572) (py-sint-to-scheme other573)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-bintX-bintY-fallback self575 other576)
  (if (py-test (py-ne other576 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme self575) (py-bint-to-scheme other576)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-xor-floatX-floatY-fallback self578 other579)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'float'"))))

(define-macro (py-xor-floatX-floatY-inline self578 other579)
  `(let ((self578 ,self578) (other579 ,other579))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for ^: 'float' and 'float'")))))

(define (py-xor-floatX-boolY-fallback self581 other582)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'bool'"))))

(define (py-xor-floatX-sintY-fallback self584 other585)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'int'"))))

(define (py-xor-floatX-bintY-fallback self587 other588)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'int'"))))

(define (py-xor-boolX-floatY-fallback self590 other591)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'bool' and 'float'"))))

(define (py-xor-boolX-boolY-fallback self593 other594)
  (py-isnot self593 other594))

(define (py-xor-boolX-sintY-fallback self596 other597)
  (py-int-from-scheme
   (py^ (py-bool-to-scheme self596) (py-sint-to-scheme other597))))

(define (py-xor-boolX-bintY-fallback self599 other600)
  (py-int-from-scheme
   (py^ (py-bool-to-scheme self599) (py-bint-to-scheme other600))))

(define (py-xor-sintX-floatY-fallback self602 other603)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'int' and 'float'"))))

(define (py-xor-sintX-boolY-fallback self605 other606)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme self605) (py-bool-to-scheme other606))))

(define (py-xor-sintX-sintY-fallback self608 other609)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme self608) (py-sint-to-scheme other609))))

(define-macro (py-xor-sintX-sintY-inline self608 other609)
  `(let ((self608 ,self608) (other609 ,other609))
     (py-int-from-scheme
      (py^ (py-sint-to-scheme self608) (py-sint-to-scheme other609)))))

(define (py-xor-sintX-bintY-fallback self611 other612)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme self611) (py-bint-to-scheme other612))))

(define (py-xor-bintX-floatY-fallback self614 other615)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'int' and 'float'"))))

(define (py-xor-bintX-boolY-fallback self617 other618)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme self617) (py-bool-to-scheme other618))))

(define (py-xor-bintX-sintY-fallback self620 other621)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme self620) (py-sint-to-scheme other621))))

(define (py-xor-bintX-bintY-fallback self623 other624)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme self623) (py-bint-to-scheme other624))))

(define (py-iadd-floatX-floatY-fallback self626 other627)
  (py-float-from-scheme
   (py+ (py-float-to-scheme self626) (py-float-to-scheme other627))))

(define-macro (py-iadd-floatX-floatY-inline self626 other627)
  `(let ((self626 ,self626) (other627 ,other627))
     (py-float-from-scheme
      (py+ (py-float-to-scheme self626) (py-float-to-scheme other627)))))

(define (py-iadd-floatX-boolY-fallback self629 other630)
  (py-float-from-scheme
   (py+ (py-float-to-scheme self629) (py-bool-to-scheme other630))))

(define (py-iadd-floatX-sintY-fallback self632 other633)
  (py-float-from-scheme
   (py+ (py-float-to-scheme self632) (py-sint-to-scheme other633))))

(define (py-iadd-floatX-bintY-fallback self635 other636)
  (py-float-from-scheme
   (py+ (py-float-to-scheme self635) (py-bint-to-scheme other636))))

(define (py-iadd-boolX-floatY-fallback self638 other639)
  (py-float-from-scheme
   (py+ (py-bool-to-scheme other639) (py-float-to-scheme self638))))

(define (py-iadd-boolX-boolY-fallback self641 other642)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme self641) (py-bool-to-scheme other642))))

(define (py-iadd-boolX-sintY-fallback self644 other645)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme self644) (py-sint-to-scheme other645))))

(define (py-iadd-boolX-bintY-fallback self647 other648)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme self647) (py-bint-to-scheme other648))))

(define (py-iadd-sintX-floatY-fallback self650 other651)
  (py-float-from-scheme
   (py+ (py-sint-to-scheme other651) (py-float-to-scheme self650))))

(define (py-iadd-sintX-boolY-fallback self653 other654)
  (py-int-from-scheme
   (py+ (py-sint-to-scheme self653) (py-bool-to-scheme other654))))

(define (py-iadd-sintX-sintY-fallback self656 other657)
  (py-int-from-scheme
   (py+ (py-sint-to-scheme self656) (py-sint-to-scheme other657))))

(define-macro (py-iadd-sintX-sintY-inline self656 other657)
  `(let ((self656 ,self656) (other657 ,other657))
     (py-int-from-scheme
      (py+ (py-sint-to-scheme self656) (py-sint-to-scheme other657)))))

(define (py-iadd-sintX-bintY-fallback self659 other660)
  (py-int-from-scheme
   (py+ (py-sint-to-scheme self659) (py-bint-to-scheme other660))))

(define (py-iadd-bintX-floatY-fallback self662 other663)
  (py-float-from-scheme
   (py+ (py-bint-to-scheme other663) (py-float-to-scheme self662))))

(define (py-iadd-bintX-boolY-fallback self665 other666)
  (py-int-from-scheme
   (py+ (py-bint-to-scheme self665) (py-bool-to-scheme other666))))

(define (py-iadd-bintX-sintY-fallback self668 other669)
  (py-int-from-scheme
   (py+ (py-bint-to-scheme self668) (py-sint-to-scheme other669))))

(define (py-iadd-bintX-bintY-fallback self671 other672)
  (py-int-from-scheme
   (py+ (py-bint-to-scheme self671) (py-bint-to-scheme other672))))

(define (py-ibitand-floatX-floatY-fallback self674 other675)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'float'"))))

(define-macro (py-ibitand-floatX-floatY-inline self674 other675)
  `(let ((self674 ,self674) (other675 ,other675))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for &: 'float' and 'float'")))))

(define (py-ibitand-floatX-boolY-fallback self677 other678)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'bool'"))))

(define (py-ibitand-floatX-sintY-fallback self680 other681)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'int'"))))

(define (py-ibitand-floatX-bintY-fallback self683 other684)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'int'"))))

(define (py-ibitand-boolX-floatY-fallback self686 other687)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'bool' and 'float'"))))

(define (py-ibitand-boolX-boolY-fallback self689 other690)
  (if (py-test-is self689 py-True) other690 py-False))

(define (py-ibitand-boolX-sintY-fallback self692 other693)
  (py-int-from-scheme
   (py& (py-bool-to-scheme self692) (py-sint-to-scheme other693))))

(define (py-ibitand-boolX-bintY-fallback self695 other696)
  (py-int-from-scheme
   (py& (py-bool-to-scheme self695) (py-bint-to-scheme other696))))

(define (py-ibitand-sintX-floatY-fallback self698 other699)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'int' and 'float'"))))

(define (py-ibitand-sintX-boolY-fallback self701 other702)
  (py-int-from-scheme
   (py& (py-sint-to-scheme self701) (py-bool-to-scheme other702))))

(define (py-ibitand-sintX-sintY-fallback self704 other705)
  (py-int-from-scheme
   (py& (py-sint-to-scheme self704) (py-sint-to-scheme other705))))

(define-macro (py-ibitand-sintX-sintY-inline self704 other705)
  `(let ((self704 ,self704) (other705 ,other705))
     (py-int-from-scheme
      (py& (py-sint-to-scheme self704) (py-sint-to-scheme other705)))))

(define (py-ibitand-sintX-bintY-fallback self707 other708)
  (py-int-from-scheme
   (py& (py-sint-to-scheme self707) (py-bint-to-scheme other708))))

(define (py-ibitand-bintX-floatY-fallback self710 other711)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'int' and 'float'"))))

(define (py-ibitand-bintX-boolY-fallback self713 other714)
  (py-int-from-scheme
   (py& (py-bint-to-scheme self713) (py-bool-to-scheme other714))))

(define (py-ibitand-bintX-sintY-fallback self716 other717)
  (py-int-from-scheme
   (py& (py-bint-to-scheme self716) (py-sint-to-scheme other717))))

(define (py-ibitand-bintX-bintY-fallback self719 other720)
  (py-int-from-scheme
   (py& (py-bint-to-scheme self719) (py-bint-to-scheme other720))))

(define (py-ibitor-floatX-floatY-fallback self722 other723)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'float'"))))

(define-macro (py-ibitor-floatX-floatY-inline self722 other723)
  `(let ((self722 ,self722) (other723 ,other723))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for |: 'float' and 'float'")))))

(define (py-ibitor-floatX-boolY-fallback self725 other726)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'bool'"))))

(define (py-ibitor-floatX-sintY-fallback self728 other729)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'int'"))))

(define (py-ibitor-floatX-bintY-fallback self731 other732)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'int'"))))

(define (py-ibitor-boolX-floatY-fallback self734 other735)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'bool' and 'float'"))))

(define (py-ibitor-boolX-boolY-fallback self737 other738)
  (if (py-test-is self737 py-True) py-True other738))

(define (py-ibitor-boolX-sintY-fallback self740 other741)
  (py-int-from-scheme
   (py+b (py-bool-to-scheme self740) (py-sint-to-scheme other741))))

(define (py-ibitor-boolX-bintY-fallback self743 other744)
  (py-int-from-scheme
   (py+b (py-bool-to-scheme self743) (py-bint-to-scheme other744))))

(define (py-ibitor-sintX-floatY-fallback self746 other747)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'int' and 'float'"))))

(define (py-ibitor-sintX-boolY-fallback self749 other750)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme self749) (py-bool-to-scheme other750))))

(define (py-ibitor-sintX-sintY-fallback self752 other753)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme self752) (py-sint-to-scheme other753))))

(define-macro (py-ibitor-sintX-sintY-inline self752 other753)
  `(let ((self752 ,self752) (other753 ,other753))
     (py-int-from-scheme
      (py+b (py-sint-to-scheme self752) (py-sint-to-scheme other753)))))

(define (py-ibitor-sintX-bintY-fallback self755 other756)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme self755) (py-bint-to-scheme other756))))

(define (py-ibitor-bintX-floatY-fallback self758 other759)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'int' and 'float'"))))

(define (py-ibitor-bintX-boolY-fallback self761 other762)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme self761) (py-bool-to-scheme other762))))

(define (py-ibitor-bintX-sintY-fallback self764 other765)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme self764) (py-sint-to-scheme other765))))

(define (py-ibitor-bintX-bintY-fallback self767 other768)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme self767) (py-bint-to-scheme other768))))

(define (py-ifloordiv-floatX-floatY-fallback self770 other771)
  (if (py-test (py-ne other771 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-float-to-scheme self770) (py-float-to-scheme other771)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define-macro (py-ifloordiv-floatX-floatY-inline self770 other771)
  `(let ((self770 ,self770) (other771 ,other771))
     (if (py-test (py-ne other771 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py// (py-float-to-scheme self770) (py-float-to-scheme other771)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define (py-ifloordiv-floatX-boolY-fallback self773 other774)
  (if (py-test (py-ne other774 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py// (py-float-to-scheme self773) (py-bool-to-scheme other774)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-floatX-sintY-fallback self776 other777)
  (if (py-test (py-ne other777 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py// (py-float-to-scheme self776) (py-sint-to-scheme other777)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-floatX-bintY-fallback self779 other780)
  (if (py-test (py-ne other780 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py// (py-float-to-scheme self779) (py-bint-to-scheme other780)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-boolX-floatY-fallback self782 other783)
  (if (py-test (py-ne self782 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-bool-to-scheme other783) (py-float-to-scheme self782)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-boolX-boolY-fallback self785 other786)
  (if (py-test (py-ne other786 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bool-to-scheme self785) (py-bool-to-scheme other786)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-boolX-sintY-fallback self788 other789)
  (if (py-test (py-ne other789 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bool-to-scheme self788) (py-sint-to-scheme other789)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-boolX-bintY-fallback self791 other792)
  (if (py-test (py-ne other792 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bool-to-scheme self791) (py-bint-to-scheme other792)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-sintX-floatY-fallback self794 other795)
  (if (py-test (py-ne self794 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-sint-to-scheme other795) (py-float-to-scheme self794)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-sintX-boolY-fallback self797 other798)
  (if (py-test (py-ne other798 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-sint-to-scheme self797) (py-bool-to-scheme other798)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-sintX-sintY-fallback self800 other801)
  (if (py-test (py-ne other801 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-sint-to-scheme self800) (py-sint-to-scheme other801)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define-macro (py-ifloordiv-sintX-sintY-inline self800 other801)
  `(let ((self800 ,self800) (other801 ,other801))
     (if (py-test (py-ne other801 (py-int-from-scheme 0)))
         (py-int-from-scheme
          (py// (py-sint-to-scheme self800) (py-sint-to-scheme other801)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "integer division by zero"))))))

(define (py-ifloordiv-sintX-bintY-fallback self803 other804)
  (if (py-test (py-ne other804 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-sint-to-scheme self803) (py-bint-to-scheme other804)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-bintX-floatY-fallback self806 other807)
  (if (py-test (py-ne self806 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-bint-to-scheme other807) (py-float-to-scheme self806)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-bintX-boolY-fallback self809 other810)
  (if (py-test (py-ne other810 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bint-to-scheme self809) (py-bool-to-scheme other810)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-bintX-sintY-fallback self812 other813)
  (if (py-test (py-ne other813 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bint-to-scheme self812) (py-sint-to-scheme other813)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-bintX-bintY-fallback self815 other816)
  (if (py-test (py-ne other816 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bint-to-scheme self815) (py-bint-to-scheme other816)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ilshift-floatX-floatY-fallback self818 other819)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'float'"))))

(define-macro (py-ilshift-floatX-floatY-inline self818 other819)
  `(let ((self818 ,self818) (other819 ,other819))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for <<: 'float' and 'float'")))))

(define (py-ilshift-floatX-boolY-fallback self821 other822)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'bool'"))))

(define (py-ilshift-floatX-sintY-fallback self824 other825)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'int'"))))

(define (py-ilshift-floatX-bintY-fallback self827 other828)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'int'"))))

(define (py-ilshift-boolX-floatY-fallback self830 other831)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'bool' and 'float'"))))

(define (py-ilshift-boolX-boolY-fallback self833 other834)
  (py-int-from-scheme
   (py<< (py-bool-to-scheme self833) (py-bool-to-scheme other834))))

(define (py-ilshift-boolX-sintY-fallback self836 other837)
  (py-int-from-scheme
   (py<< (py-bool-to-scheme self836) (py-sint-to-scheme other837))))

(define (py-ilshift-boolX-bintY-fallback self839 other840)
  (py-int-from-scheme
   (py<< (py-bool-to-scheme self839) (py-bint-to-scheme other840))))

(define (py-ilshift-sintX-floatY-fallback self842 other843)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'int' and 'float'"))))

(define (py-ilshift-sintX-boolY-fallback self845 other846)
  (py-int-from-scheme
   (py<< (py-sint-to-scheme self845) (py-bool-to-scheme other846))))

(define (py-ilshift-sintX-sintY-fallback self848 other849)
  (py-int-from-scheme
   (py<< (py-sint-to-scheme self848) (py-sint-to-scheme other849))))

(define-macro (py-ilshift-sintX-sintY-inline self848 other849)
  `(let ((self848 ,self848) (other849 ,other849))
     (py-int-from-scheme
      (py<< (py-sint-to-scheme self848) (py-sint-to-scheme other849)))))

(define (py-ilshift-sintX-bintY-fallback self851 other852)
  (py-int-from-scheme
   (py<< (py-sint-to-scheme self851) (py-bint-to-scheme other852))))

(define (py-ilshift-bintX-floatY-fallback self854 other855)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'int' and 'float'"))))

(define (py-ilshift-bintX-boolY-fallback self857 other858)
  (py-int-from-scheme
   (py<< (py-bint-to-scheme self857) (py-bool-to-scheme other858))))

(define (py-ilshift-bintX-sintY-fallback self860 other861)
  (py-int-from-scheme
   (py<< (py-bint-to-scheme self860) (py-sint-to-scheme other861))))

(define (py-ilshift-bintX-bintY-fallback self863 other864)
  (py-int-from-scheme
   (py<< (py-bint-to-scheme self863) (py-bint-to-scheme other864))))

(define (py-imatmul-floatX-floatY-fallback self866 other867)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'float'"))))

(define-macro (py-imatmul-floatX-floatY-inline self866 other867)
  `(let ((self866 ,self866) (other867 ,other867))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @: 'float' and 'float'")))))

(define (py-imatmul-floatX-boolY-fallback self869 other870)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'bool'"))))

(define (py-imatmul-floatX-sintY-fallback self872 other873)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'int'"))))

(define (py-imatmul-floatX-bintY-fallback self875 other876)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'int'"))))

(define (py-imatmul-boolX-floatY-fallback self878 other879)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'float'"))))

(define (py-imatmul-boolX-boolY-fallback self881 other882)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'bool'"))))

(define (py-imatmul-boolX-sintY-fallback self884 other885)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'int'"))))

(define (py-imatmul-boolX-bintY-fallback self887 other888)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'int'"))))

(define (py-imatmul-sintX-floatY-fallback self890 other891)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'float'"))))

(define (py-imatmul-sintX-boolY-fallback self893 other894)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'bool'"))))

(define (py-imatmul-sintX-sintY-fallback self896 other897)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define-macro (py-imatmul-sintX-sintY-inline self896 other897)
  `(let ((self896 ,self896) (other897 ,other897))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @: 'int' and 'int'")))))

(define (py-imatmul-sintX-bintY-fallback self899 other900)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-imatmul-bintX-floatY-fallback self902 other903)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'float'"))))

(define (py-imatmul-bintX-boolY-fallback self905 other906)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'bool'"))))

(define (py-imatmul-bintX-sintY-fallback self908 other909)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-imatmul-bintX-bintY-fallback self911 other912)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-imod-floatX-floatY-fallback self914 other915)
  (if (py-test (py-ne other915 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-float-to-scheme self914) (py-float-to-scheme other915)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define-macro (py-imod-floatX-floatY-inline self914 other915)
  `(let ((self914 ,self914) (other915 ,other915))
     (if (py-test (py-ne other915 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py% (py-float-to-scheme self914) (py-float-to-scheme other915)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float modulo by zero"))))))

(define (py-imod-floatX-boolY-fallback self917 other918)
  (if (py-test (py-ne other918 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py% (py-float-to-scheme self917) (py-bool-to-scheme other918)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-floatX-sintY-fallback self920 other921)
  (if (py-test (py-ne other921 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py% (py-float-to-scheme self920) (py-sint-to-scheme other921)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-floatX-bintY-fallback self923 other924)
  (if (py-test (py-ne other924 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py% (py-float-to-scheme self923) (py-bint-to-scheme other924)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-boolX-floatY-fallback self926 other927)
  (if (py-test (py-ne self926 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-bool-to-scheme other927) (py-float-to-scheme self926)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-boolX-boolY-fallback self929 other930)
  (if (py-test (py-ne other930 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bool-to-scheme self929) (py-bool-to-scheme other930)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-boolX-sintY-fallback self932 other933)
  (if (py-test (py-ne other933 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bool-to-scheme self932) (py-sint-to-scheme other933)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-boolX-bintY-fallback self935 other936)
  (if (py-test (py-ne other936 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bool-to-scheme self935) (py-bint-to-scheme other936)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-sintX-floatY-fallback self938 other939)
  (if (py-test (py-ne self938 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-sint-to-scheme other939) (py-float-to-scheme self938)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-sintX-boolY-fallback self941 other942)
  (if (py-test (py-ne other942 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-sint-to-scheme self941) (py-bool-to-scheme other942)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-sintX-sintY-fallback self944 other945)
  (if (py-test (py-ne other945 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-sint-to-scheme self944) (py-sint-to-scheme other945)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define-macro (py-imod-sintX-sintY-inline self944 other945)
  `(let ((self944 ,self944) (other945 ,other945))
     (if (py-test (py-ne other945 (py-int-from-scheme 0)))
         (py-int-from-scheme
          (py% (py-sint-to-scheme self944) (py-sint-to-scheme other945)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError (&& "modulo by zero"))))))

(define (py-imod-sintX-bintY-fallback self947 other948)
  (if (py-test (py-ne other948 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-sint-to-scheme self947) (py-bint-to-scheme other948)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-bintX-floatY-fallback self950 other951)
  (if (py-test (py-ne self950 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-bint-to-scheme other951) (py-float-to-scheme self950)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-bintX-boolY-fallback self953 other954)
  (if (py-test (py-ne other954 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bint-to-scheme self953) (py-bool-to-scheme other954)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-bintX-sintY-fallback self956 other957)
  (if (py-test (py-ne other957 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bint-to-scheme self956) (py-sint-to-scheme other957)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-bintX-bintY-fallback self959 other960)
  (if (py-test (py-ne other960 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bint-to-scheme self959) (py-bint-to-scheme other960)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imul-floatX-floatY-fallback self962 other963)
  (py-float-from-scheme
   (py* (py-float-to-scheme self962) (py-float-to-scheme other963))))

(define-macro (py-imul-floatX-floatY-inline self962 other963)
  `(let ((self962 ,self962) (other963 ,other963))
     (py-float-from-scheme
      (py* (py-float-to-scheme self962) (py-float-to-scheme other963)))))

(define (py-imul-floatX-boolY-fallback self965 other966)
  (py-float-from-scheme
   (py* (py-float-to-scheme self965) (py-bool-to-scheme other966))))

(define (py-imul-floatX-sintY-fallback self968 other969)
  (py-float-from-scheme
   (py* (py-float-to-scheme self968) (py-sint-to-scheme other969))))

(define (py-imul-floatX-bintY-fallback self971 other972)
  (py-float-from-scheme
   (py* (py-float-to-scheme self971) (py-bint-to-scheme other972))))

(define (py-imul-boolX-floatY-fallback self974 other975)
  (py-float-from-scheme
   (py* (py-bool-to-scheme other975) (py-float-to-scheme self974))))

(define (py-imul-boolX-boolY-fallback self977 other978)
  (py-int-from-scheme
   (py* (py-bool-to-scheme self977) (py-bool-to-scheme other978))))

(define (py-imul-boolX-sintY-fallback self980 other981)
  (py-int-from-scheme
   (py* (py-bool-to-scheme self980) (py-sint-to-scheme other981))))

(define (py-imul-boolX-bintY-fallback self983 other984)
  (py-int-from-scheme
   (py* (py-bool-to-scheme self983) (py-bint-to-scheme other984))))

(define (py-imul-sintX-floatY-fallback self986 other987)
  (py-float-from-scheme
   (py* (py-sint-to-scheme other987) (py-float-to-scheme self986))))

(define (py-imul-sintX-boolY-fallback self989 other990)
  (py-int-from-scheme
   (py* (py-sint-to-scheme self989) (py-bool-to-scheme other990))))

(define (py-imul-sintX-sintY-fallback self992 other993)
  (py-int-from-scheme
   (py* (py-sint-to-scheme self992) (py-sint-to-scheme other993))))

(define-macro (py-imul-sintX-sintY-inline self992 other993)
  `(let ((self992 ,self992) (other993 ,other993))
     (py-int-from-scheme
      (py* (py-sint-to-scheme self992) (py-sint-to-scheme other993)))))

(define (py-imul-sintX-bintY-fallback self995 other996)
  (py-int-from-scheme
   (py* (py-sint-to-scheme self995) (py-bint-to-scheme other996))))

(define (py-imul-bintX-floatY-fallback self998 other999)
  (py-float-from-scheme
   (py* (py-bint-to-scheme other999) (py-float-to-scheme self998))))

(define (py-imul-bintX-boolY-fallback self1001 other1002)
  (py-int-from-scheme
   (py* (py-bint-to-scheme self1001) (py-bool-to-scheme other1002))))

(define (py-imul-bintX-sintY-fallback self1004 other1005)
  (py-int-from-scheme
   (py* (py-bint-to-scheme self1004) (py-sint-to-scheme other1005))))

(define (py-imul-bintX-bintY-fallback self1007 other1008)
  (py-int-from-scheme
   (py* (py-bint-to-scheme self1007) (py-bint-to-scheme other1008))))

(define (py-ipow-floatX-floatY-fallback self1010 other1011)
  (py-float-from-scheme
   (py** (py-float-to-scheme self1010) (py-float-to-scheme other1011))))

(define-macro (py-ipow-floatX-floatY-inline self1010 other1011)
  `(let ((self1010 ,self1010) (other1011 ,other1011))
     (py-float-from-scheme
      (py** (py-float-to-scheme self1010) (py-float-to-scheme other1011)))))

(define (py-ipow-floatX-boolY-fallback self1013 other1014)
  (py-float-from-scheme
   (py** (py-float-to-scheme self1013) (py-bool-to-scheme other1014))))

(define (py-ipow-floatX-sintY-fallback self1016 other1017)
  (py-float-from-scheme
   (py** (py-float-to-scheme self1016) (py-sint-to-scheme other1017))))

(define (py-ipow-floatX-bintY-fallback self1019 other1020)
  (py-float-from-scheme
   (py** (py-float-to-scheme self1019) (py-bint-to-scheme other1020))))

(define (py-ipow-boolX-floatY-fallback self1022 other1023)
  (py-float-from-scheme
   (py** (py-bool-to-scheme other1023) (py-float-to-scheme self1022))))

(define (py-ipow-boolX-boolY-fallback self1025 other1026)
  (py-int-from-scheme
   (py** (py-bool-to-scheme self1025) (py-bool-to-scheme other1026))))

(define (py-ipow-boolX-sintY-fallback self1028 other1029)
  (py-int-from-scheme
   (py** (py-bool-to-scheme self1028) (py-sint-to-scheme other1029))))

(define (py-ipow-boolX-bintY-fallback self1031 other1032)
  (py-int-from-scheme
   (py** (py-bool-to-scheme self1031) (py-bint-to-scheme other1032))))

(define (py-ipow-sintX-floatY-fallback self1034 other1035)
  (py-float-from-scheme
   (py** (py-sint-to-scheme other1035) (py-float-to-scheme self1034))))

(define (py-ipow-sintX-boolY-fallback self1037 other1038)
  (py-int-from-scheme
   (py** (py-sint-to-scheme self1037) (py-bool-to-scheme other1038))))

(define (py-ipow-sintX-sintY-fallback self1040 other1041)
  (py-int-from-scheme
   (py** (py-sint-to-scheme self1040) (py-sint-to-scheme other1041))))

(define-macro (py-ipow-sintX-sintY-inline self1040 other1041)
  `(let ((self1040 ,self1040) (other1041 ,other1041))
     (py-int-from-scheme
      (py** (py-sint-to-scheme self1040) (py-sint-to-scheme other1041)))))

(define (py-ipow-sintX-bintY-fallback self1043 other1044)
  (py-int-from-scheme
   (py** (py-sint-to-scheme self1043) (py-bint-to-scheme other1044))))

(define (py-ipow-bintX-floatY-fallback self1046 other1047)
  (py-float-from-scheme
   (py** (py-bint-to-scheme other1047) (py-float-to-scheme self1046))))

(define (py-ipow-bintX-boolY-fallback self1049 other1050)
  (py-int-from-scheme
   (py** (py-bint-to-scheme self1049) (py-bool-to-scheme other1050))))

(define (py-ipow-bintX-sintY-fallback self1052 other1053)
  (py-int-from-scheme
   (py** (py-bint-to-scheme self1052) (py-sint-to-scheme other1053))))

(define (py-ipow-bintX-bintY-fallback self1055 other1056)
  (py-int-from-scheme
   (py** (py-bint-to-scheme self1055) (py-bint-to-scheme other1056))))

(define (py-irshift-floatX-floatY-fallback self1058 other1059)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'float'"))))

(define-macro (py-irshift-floatX-floatY-inline self1058 other1059)
  `(let ((self1058 ,self1058) (other1059 ,other1059))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for >>: 'float' and 'float'")))))

(define (py-irshift-floatX-boolY-fallback self1061 other1062)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'bool'"))))

(define (py-irshift-floatX-sintY-fallback self1064 other1065)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'int'"))))

(define (py-irshift-floatX-bintY-fallback self1067 other1068)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'int'"))))

(define (py-irshift-boolX-floatY-fallback self1070 other1071)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'bool' and 'float'"))))

(define (py-irshift-boolX-boolY-fallback self1073 other1074)
  (py-int-from-scheme
   (py>> (py-bool-to-scheme self1073) (py-bool-to-scheme other1074))))

(define (py-irshift-boolX-sintY-fallback self1076 other1077)
  (py-int-from-scheme
   (py>> (py-sint-to-scheme self1076) (py-bool-to-scheme other1077))))

(define (py-irshift-boolX-bintY-fallback self1079 other1080)
  (py-int-from-scheme
   (py>> (py-bint-to-scheme self1079) (py-bool-to-scheme other1080))))

(define (py-irshift-sintX-floatY-fallback self1082 other1083)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'int' and 'float'"))))

(define (py-irshift-sintX-boolY-fallback self1085 other1086)
  (py-int-from-scheme
   (py>> (py-bool-to-scheme self1085) (py-sint-to-scheme other1086))))

(define (py-irshift-sintX-sintY-fallback self1088 other1089)
  (py-int-from-scheme
   (py>> (py-sint-to-scheme self1088) (py-sint-to-scheme other1089))))

(define-macro (py-irshift-sintX-sintY-inline self1088 other1089)
  `(let ((self1088 ,self1088) (other1089 ,other1089))
     (py-int-from-scheme
      (py>> (py-sint-to-scheme self1088) (py-sint-to-scheme other1089)))))

(define (py-irshift-sintX-bintY-fallback self1091 other1092)
  (py-int-from-scheme
   (py>> (py-bint-to-scheme self1091) (py-sint-to-scheme other1092))))

(define (py-irshift-bintX-floatY-fallback self1094 other1095)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'int' and 'float'"))))

(define (py-irshift-bintX-boolY-fallback self1097 other1098)
  (py-int-from-scheme
   (py>> (py-bool-to-scheme self1097) (py-bint-to-scheme other1098))))

(define (py-irshift-bintX-sintY-fallback self1100 other1101)
  (py-int-from-scheme
   (py>> (py-sint-to-scheme self1100) (py-bint-to-scheme other1101))))

(define (py-irshift-bintX-bintY-fallback self1103 other1104)
  (py-int-from-scheme
   (py>> (py-bint-to-scheme self1103) (py-bint-to-scheme other1104))))

(define (py-isub-floatX-floatY-fallback self1106 other1107)
  (py-float-from-scheme
   (py- (py-float-to-scheme self1106) (py-float-to-scheme other1107))))

(define-macro (py-isub-floatX-floatY-inline self1106 other1107)
  `(let ((self1106 ,self1106) (other1107 ,other1107))
     (py-float-from-scheme
      (py- (py-float-to-scheme self1106) (py-float-to-scheme other1107)))))

(define (py-isub-floatX-boolY-fallback self1109 other1110)
  (py-float-from-scheme
   (py- (py-float-to-scheme self1109) (py-bool-to-scheme other1110))))

(define (py-isub-floatX-sintY-fallback self1112 other1113)
  (py-float-from-scheme
   (py- (py-float-to-scheme self1112) (py-sint-to-scheme other1113))))

(define (py-isub-floatX-bintY-fallback self1115 other1116)
  (py-float-from-scheme
   (py- (py-float-to-scheme self1115) (py-bint-to-scheme other1116))))

(define (py-isub-boolX-floatY-fallback self1118 other1119)
  (py-float-from-scheme
   (py- (py-bool-to-scheme other1119) (py-float-to-scheme self1118))))

(define (py-isub-boolX-boolY-fallback self1121 other1122)
  (py-int-from-scheme
   (py- (py-bool-to-scheme self1121) (py-bool-to-scheme other1122))))

(define (py-isub-boolX-sintY-fallback self1124 other1125)
  (py-int-from-scheme
   (py- (py-bool-to-scheme self1124) (py-sint-to-scheme other1125))))

(define (py-isub-boolX-bintY-fallback self1127 other1128)
  (py-int-from-scheme
   (py- (py-bool-to-scheme self1127) (py-bint-to-scheme other1128))))

(define (py-isub-sintX-floatY-fallback self1130 other1131)
  (py-float-from-scheme
   (py- (py-sint-to-scheme other1131) (py-float-to-scheme self1130))))

(define (py-isub-sintX-boolY-fallback self1133 other1134)
  (py-int-from-scheme
   (py- (py-sint-to-scheme self1133) (py-bool-to-scheme other1134))))

(define (py-isub-sintX-sintY-fallback self1136 other1137)
  (py-int-from-scheme
   (py- (py-sint-to-scheme self1136) (py-sint-to-scheme other1137))))

(define-macro (py-isub-sintX-sintY-inline self1136 other1137)
  `(let ((self1136 ,self1136) (other1137 ,other1137))
     (py-int-from-scheme
      (py- (py-sint-to-scheme self1136) (py-sint-to-scheme other1137)))))

(define (py-isub-sintX-bintY-fallback self1139 other1140)
  (py-int-from-scheme
   (py- (py-sint-to-scheme self1139) (py-bint-to-scheme other1140))))

(define (py-isub-bintX-floatY-fallback self1142 other1143)
  (py-float-from-scheme
   (py- (py-bint-to-scheme other1143) (py-float-to-scheme self1142))))

(define (py-isub-bintX-boolY-fallback self1145 other1146)
  (py-int-from-scheme
   (py- (py-bint-to-scheme self1145) (py-bool-to-scheme other1146))))

(define (py-isub-bintX-sintY-fallback self1148 other1149)
  (py-int-from-scheme
   (py- (py-bint-to-scheme self1148) (py-sint-to-scheme other1149))))

(define (py-isub-bintX-bintY-fallback self1151 other1152)
  (py-int-from-scheme
   (py- (py-bint-to-scheme self1151) (py-bint-to-scheme other1152))))

(define (py-itruediv-floatX-floatY-fallback self1154 other1155)
  (if (py-test (py-ne other1155 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme self1154) (py-float-to-scheme other1155)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define-macro (py-itruediv-floatX-floatY-inline self1154 other1155)
  `(let ((self1154 ,self1154) (other1155 ,other1155))
     (if (py-test (py-ne other1155 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py/ (py-float-to-scheme self1154) (py-float-to-scheme other1155)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define (py-itruediv-floatX-boolY-fallback self1157 other1158)
  (if (py-test (py-ne other1158 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme self1157) (py-bool-to-scheme other1158)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-floatX-sintY-fallback self1160 other1161)
  (if (py-test (py-ne other1161 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme self1160) (py-sint-to-scheme other1161)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-floatX-bintY-fallback self1163 other1164)
  (if (py-test (py-ne other1164 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme self1163) (py-bint-to-scheme other1164)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-boolX-floatY-fallback self1166 other1167)
  (if (py-test (py-ne self1166 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme other1167) (py-float-to-scheme self1166)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-boolX-boolY-fallback self1169 other1170)
  (if (py-test (py-ne other1170 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme self1169) (py-bool-to-scheme other1170)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-boolX-sintY-fallback self1172 other1173)
  (if (py-test (py-ne other1173 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme self1172) (py-sint-to-scheme other1173)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-boolX-bintY-fallback self1175 other1176)
  (if (py-test (py-ne other1176 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme self1175) (py-bint-to-scheme other1176)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-sintX-floatY-fallback self1178 other1179)
  (if (py-test (py-ne self1178 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme other1179) (py-float-to-scheme self1178)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-sintX-boolY-fallback self1181 other1182)
  (if (py-test (py-ne other1182 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme self1181) (py-bool-to-scheme other1182)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-sintX-sintY-fallback self1184 other1185)
  (if (py-test (py-ne other1185 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme self1184) (py-sint-to-scheme other1185)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define-macro (py-itruediv-sintX-sintY-inline self1184 other1185)
  `(let ((self1184 ,self1184) (other1185 ,other1185))
     (if (py-test (py-ne other1185 (py-int-from-scheme 0)))
         (py-float-from-scheme
          (py/ (py-sint-to-scheme self1184) (py-sint-to-scheme other1185)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError (&& "division by zero"))))))

(define (py-itruediv-sintX-bintY-fallback self1187 other1188)
  (if (py-test (py-ne other1188 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme self1187) (py-bint-to-scheme other1188)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-bintX-floatY-fallback self1190 other1191)
  (if (py-test (py-ne self1190 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme other1191) (py-float-to-scheme self1190)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-bintX-boolY-fallback self1193 other1194)
  (if (py-test (py-ne other1194 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme self1193) (py-bool-to-scheme other1194)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-bintX-sintY-fallback self1196 other1197)
  (if (py-test (py-ne other1197 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme self1196) (py-sint-to-scheme other1197)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-bintX-bintY-fallback self1199 other1200)
  (if (py-test (py-ne other1200 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme self1199) (py-bint-to-scheme other1200)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-ixor-floatX-floatY-fallback self1202 other1203)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'float'"))))

(define-macro (py-ixor-floatX-floatY-inline self1202 other1203)
  `(let ((self1202 ,self1202) (other1203 ,other1203))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for ^: 'float' and 'float'")))))

(define (py-ixor-floatX-boolY-fallback self1205 other1206)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'bool'"))))

(define (py-ixor-floatX-sintY-fallback self1208 other1209)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'int'"))))

(define (py-ixor-floatX-bintY-fallback self1211 other1212)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'int'"))))

(define (py-ixor-boolX-floatY-fallback self1214 other1215)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'bool' and 'float'"))))

(define (py-ixor-boolX-boolY-fallback self1217 other1218)
  (py-isnot self1217 other1218))

(define (py-ixor-boolX-sintY-fallback self1220 other1221)
  (py-int-from-scheme
   (py^ (py-bool-to-scheme self1220) (py-sint-to-scheme other1221))))

(define (py-ixor-boolX-bintY-fallback self1223 other1224)
  (py-int-from-scheme
   (py^ (py-bool-to-scheme self1223) (py-bint-to-scheme other1224))))

(define (py-ixor-sintX-floatY-fallback self1226 other1227)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'int' and 'float'"))))

(define (py-ixor-sintX-boolY-fallback self1229 other1230)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme self1229) (py-bool-to-scheme other1230))))

(define (py-ixor-sintX-sintY-fallback self1232 other1233)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme self1232) (py-sint-to-scheme other1233))))

(define-macro (py-ixor-sintX-sintY-inline self1232 other1233)
  `(let ((self1232 ,self1232) (other1233 ,other1233))
     (py-int-from-scheme
      (py^ (py-sint-to-scheme self1232) (py-sint-to-scheme other1233)))))

(define (py-ixor-sintX-bintY-fallback self1235 other1236)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme self1235) (py-bint-to-scheme other1236))))

(define (py-ixor-bintX-floatY-fallback self1238 other1239)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'int' and 'float'"))))

(define (py-ixor-bintX-boolY-fallback self1241 other1242)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme self1241) (py-bool-to-scheme other1242))))

(define (py-ixor-bintX-sintY-fallback self1244 other1245)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme self1244) (py-sint-to-scheme other1245))))

(define (py-ixor-bintX-bintY-fallback self1247 other1248)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme self1247) (py-bint-to-scheme other1248))))

