(define (py-add-intX-intY-fallback self2 other3)
  (py-int-from-scheme
   (py+ (py-int-to-scheme self2) (py-int-to-scheme other3))))

(define (py-add-intX-floatY-fallback self5 other6)
  (py-float-from-scheme
   (py+ (py-int-to-scheme other6) (py-float-to-scheme self5))))

(define (py-add-intX-boolY-fallback self8 other9)
  (py-int-from-scheme
   (py+ (py-int-to-scheme self8) (py-bool-to-scheme other9))))

(define (py-add-intX-sintY-fallback self11 other12)
  (py-int-from-scheme
   (py+ (py-int-to-scheme self11) (py-sint-to-scheme other12))))

(define (py-add-intX-bintY-fallback self14 other15)
  (py-int-from-scheme
   (py+ (py-int-to-scheme self14) (py-bint-to-scheme other15))))

(define (py-add-floatX-intY-fallback self17 other18)
  (py-float-from-scheme
   (py+ (py-float-to-scheme self17) (py-int-to-scheme other18))))

(define (py-add-floatX-floatY-fallback self20 other21)
  (py-float-from-scheme
   (py+ (py-float-to-scheme self20) (py-float-to-scheme other21))))

(define-macro (py-add-floatX-floatY-inline self20 other21)
  `(let ((self20 ,self20) (other21 ,other21))
     (py-float-from-scheme
      (py+ (py-float-to-scheme self20) (py-float-to-scheme other21)))))

(define (py-add-floatX-boolY-fallback self23 other24)
  (py-float-from-scheme
   (py+ (py-float-to-scheme self23) (py-bool-to-scheme other24))))

(define (py-add-floatX-sintY-fallback self26 other27)
  (py-float-from-scheme
   (py+ (py-float-to-scheme self26) (py-sint-to-scheme other27))))

(define (py-add-floatX-bintY-fallback self29 other30)
  (py-float-from-scheme
   (py+ (py-float-to-scheme self29) (py-bint-to-scheme other30))))

(define (py-add-boolX-intY-fallback self32 other33)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme self32) (py-int-to-scheme other33))))

(define (py-add-boolX-floatY-fallback self35 other36)
  (py-float-from-scheme
   (py+ (py-bool-to-scheme other36) (py-float-to-scheme self35))))

(define (py-add-boolX-boolY-fallback self38 other39)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme self38) (py-bool-to-scheme other39))))

(define (py-add-boolX-sintY-fallback self41 other42)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme self41) (py-sint-to-scheme other42))))

(define (py-add-boolX-bintY-fallback self44 other45)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme self44) (py-bint-to-scheme other45))))

(define (py-add-sintX-intY-fallback self47 other48)
  (py-int-from-scheme
   (py+ (py-sint-to-scheme self47) (py-int-to-scheme other48))))

(define (py-add-sintX-floatY-fallback self50 other51)
  (py-float-from-scheme
   (py+ (py-sint-to-scheme other51) (py-float-to-scheme self50))))

(define (py-add-sintX-boolY-fallback self53 other54)
  (py-int-from-scheme
   (py+ (py-sint-to-scheme self53) (py-bool-to-scheme other54))))

(define (py-add-sintX-sintY-fallback self56 other57)
  (py-int-from-scheme
   (py+ (py-sint-to-scheme self56) (py-sint-to-scheme other57))))

(define-macro (py-add-sintX-sintY-inline self56 other57)
  `(let ((self56 ,self56) (other57 ,other57))
     (py-int-from-scheme
      (py+ (py-sint-to-scheme self56) (py-sint-to-scheme other57)))))

(define (py-add-sintX-bintY-fallback self59 other60)
  (py-int-from-scheme
   (py+ (py-sint-to-scheme self59) (py-bint-to-scheme other60))))

(define (py-add-bintX-intY-fallback self62 other63)
  (py-int-from-scheme
   (py+ (py-bint-to-scheme self62) (py-int-to-scheme other63))))

(define (py-add-bintX-floatY-fallback self65 other66)
  (py-float-from-scheme
   (py+ (py-bint-to-scheme other66) (py-float-to-scheme self65))))

(define (py-add-bintX-boolY-fallback self68 other69)
  (py-int-from-scheme
   (py+ (py-bint-to-scheme self68) (py-bool-to-scheme other69))))

(define (py-add-bintX-sintY-fallback self71 other72)
  (py-int-from-scheme
   (py+ (py-bint-to-scheme self71) (py-sint-to-scheme other72))))

(define (py-add-bintX-bintY-fallback self74 other75)
  (py-int-from-scheme
   (py+ (py-bint-to-scheme self74) (py-bint-to-scheme other75))))

(define (py-bitand-intX-intY-fallback self77 other78)
  (py-int-from-scheme
   (py& (py-int-to-scheme self77) (py-int-to-scheme other78))))

(define (py-bitand-intX-floatY-fallback self80 other81)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'int' and 'float'"))))

(define (py-bitand-intX-boolY-fallback self83 other84)
  (py-int-from-scheme
   (py& (py-int-to-scheme self83) (py-bool-to-scheme other84))))

(define (py-bitand-intX-sintY-fallback self86 other87)
  (py-int-from-scheme
   (py& (py-int-to-scheme self86) (py-sint-to-scheme other87))))

(define (py-bitand-intX-bintY-fallback self89 other90)
  (py-int-from-scheme
   (py& (py-int-to-scheme self89) (py-bint-to-scheme other90))))

(define (py-bitand-floatX-intY-fallback self92 other93)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'int'"))))

(define (py-bitand-floatX-floatY-fallback self95 other96)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'float'"))))

(define-macro (py-bitand-floatX-floatY-inline self95 other96)
  `(let ((self95 ,self95) (other96 ,other96))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for &: 'float' and 'float'")))))

(define (py-bitand-floatX-boolY-fallback self98 other99)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'bool'"))))

(define (py-bitand-floatX-sintY-fallback self101 other102)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'int'"))))

(define (py-bitand-floatX-bintY-fallback self104 other105)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'int'"))))

(define (py-bitand-boolX-intY-fallback self107 other108)
  (py-int-from-scheme
   (py& (py-bool-to-scheme self107) (py-int-to-scheme other108))))

(define (py-bitand-boolX-floatY-fallback self110 other111)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'bool' and 'float'"))))

(define (py-bitand-boolX-boolY-fallback self113 other114)
  (if (py-test (py-is self113 py-True)) other114 py-False))

(define (py-bitand-boolX-sintY-fallback self116 other117)
  (py-int-from-scheme
   (py& (py-bool-to-scheme self116) (py-sint-to-scheme other117))))

(define (py-bitand-boolX-bintY-fallback self119 other120)
  (py-int-from-scheme
   (py& (py-bool-to-scheme self119) (py-bint-to-scheme other120))))

(define (py-bitand-sintX-intY-fallback self122 other123)
  (py-int-from-scheme
   (py& (py-sint-to-scheme self122) (py-int-to-scheme other123))))

(define (py-bitand-sintX-floatY-fallback self125 other126)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'int' and 'float'"))))

(define (py-bitand-sintX-boolY-fallback self128 other129)
  (py-int-from-scheme
   (py& (py-sint-to-scheme self128) (py-bool-to-scheme other129))))

(define (py-bitand-sintX-sintY-fallback self131 other132)
  (py-int-from-scheme
   (py& (py-sint-to-scheme self131) (py-sint-to-scheme other132))))

(define-macro (py-bitand-sintX-sintY-inline self131 other132)
  `(let ((self131 ,self131) (other132 ,other132))
     (py-int-from-scheme
      (py& (py-sint-to-scheme self131) (py-sint-to-scheme other132)))))

(define (py-bitand-sintX-bintY-fallback self134 other135)
  (py-int-from-scheme
   (py& (py-sint-to-scheme self134) (py-bint-to-scheme other135))))

(define (py-bitand-bintX-intY-fallback self137 other138)
  (py-int-from-scheme
   (py& (py-bint-to-scheme self137) (py-int-to-scheme other138))))

(define (py-bitand-bintX-floatY-fallback self140 other141)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'int' and 'float'"))))

(define (py-bitand-bintX-boolY-fallback self143 other144)
  (py-int-from-scheme
   (py& (py-bint-to-scheme self143) (py-bool-to-scheme other144))))

(define (py-bitand-bintX-sintY-fallback self146 other147)
  (py-int-from-scheme
   (py& (py-bint-to-scheme self146) (py-sint-to-scheme other147))))

(define (py-bitand-bintX-bintY-fallback self149 other150)
  (py-int-from-scheme
   (py& (py-bint-to-scheme self149) (py-bint-to-scheme other150))))

(define (py-bitor-intX-intY-fallback self152 other153)
  (py-int-from-scheme
   (py+b (py-int-to-scheme self152) (py-int-to-scheme other153))))

(define (py-bitor-intX-floatY-fallback self155 other156)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'int' and 'float'"))))

(define (py-bitor-intX-boolY-fallback self158 other159)
  (py-int-from-scheme
   (py+b (py-int-to-scheme self158) (py-bool-to-scheme other159))))

(define (py-bitor-intX-sintY-fallback self161 other162)
  (py-int-from-scheme
   (py+b (py-int-to-scheme self161) (py-sint-to-scheme other162))))

(define (py-bitor-intX-bintY-fallback self164 other165)
  (py-int-from-scheme
   (py+b (py-int-to-scheme self164) (py-bint-to-scheme other165))))

(define (py-bitor-floatX-intY-fallback self167 other168)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'int'"))))

(define (py-bitor-floatX-floatY-fallback self170 other171)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'float'"))))

(define-macro (py-bitor-floatX-floatY-inline self170 other171)
  `(let ((self170 ,self170) (other171 ,other171))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for |: 'float' and 'float'")))))

(define (py-bitor-floatX-boolY-fallback self173 other174)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'bool'"))))

(define (py-bitor-floatX-sintY-fallback self176 other177)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'int'"))))

(define (py-bitor-floatX-bintY-fallback self179 other180)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'int'"))))

(define (py-bitor-boolX-intY-fallback self182 other183)
  (py-int-from-scheme
   (py+b (py-bool-to-scheme self182) (py-int-to-scheme other183))))

(define (py-bitor-boolX-floatY-fallback self185 other186)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'bool' and 'float'"))))

(define (py-bitor-boolX-boolY-fallback self188 other189)
  (if (py-test (py-is self188 py-True)) py-True other189))

(define (py-bitor-boolX-sintY-fallback self191 other192)
  (py-int-from-scheme
   (py+b (py-bool-to-scheme self191) (py-sint-to-scheme other192))))

(define (py-bitor-boolX-bintY-fallback self194 other195)
  (py-int-from-scheme
   (py+b (py-bool-to-scheme self194) (py-bint-to-scheme other195))))

(define (py-bitor-sintX-intY-fallback self197 other198)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme self197) (py-int-to-scheme other198))))

(define (py-bitor-sintX-floatY-fallback self200 other201)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'int' and 'float'"))))

(define (py-bitor-sintX-boolY-fallback self203 other204)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme self203) (py-bool-to-scheme other204))))

(define (py-bitor-sintX-sintY-fallback self206 other207)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme self206) (py-sint-to-scheme other207))))

(define-macro (py-bitor-sintX-sintY-inline self206 other207)
  `(let ((self206 ,self206) (other207 ,other207))
     (py-int-from-scheme
      (py+b (py-sint-to-scheme self206) (py-sint-to-scheme other207)))))

(define (py-bitor-sintX-bintY-fallback self209 other210)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme self209) (py-bint-to-scheme other210))))

(define (py-bitor-bintX-intY-fallback self212 other213)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme self212) (py-int-to-scheme other213))))

(define (py-bitor-bintX-floatY-fallback self215 other216)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'int' and 'float'"))))

(define (py-bitor-bintX-boolY-fallback self218 other219)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme self218) (py-bool-to-scheme other219))))

(define (py-bitor-bintX-sintY-fallback self221 other222)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme self221) (py-sint-to-scheme other222))))

(define (py-bitor-bintX-bintY-fallback self224 other225)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme self224) (py-bint-to-scheme other225))))

(define (py-floordiv-intX-intY-fallback self227 other228)
  (if (py-test (py-ne other228 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-int-to-scheme self227) (py-int-to-scheme other228)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-intX-floatY-fallback self230 other231)
  (if (py-test (py-ne self230 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-int-to-scheme other231) (py-float-to-scheme self230)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-intX-boolY-fallback self233 other234)
  (if (py-test (py-ne other234 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-int-to-scheme self233) (py-bool-to-scheme other234)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-intX-sintY-fallback self236 other237)
  (if (py-test (py-ne other237 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-int-to-scheme self236) (py-sint-to-scheme other237)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-intX-bintY-fallback self239 other240)
  (if (py-test (py-ne other240 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-int-to-scheme self239) (py-bint-to-scheme other240)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-floatX-intY-fallback self242 other243)
  (if (py-test (py-ne other243 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py// (py-float-to-scheme self242) (py-int-to-scheme other243)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-floatX-floatY-fallback self245 other246)
  (if (py-test (py-ne other246 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-float-to-scheme self245) (py-float-to-scheme other246)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define-macro (py-floordiv-floatX-floatY-inline self245 other246)
  `(let ((self245 ,self245) (other246 ,other246))
     (if (py-test (py-ne other246 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py// (py-float-to-scheme self245) (py-float-to-scheme other246)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define (py-floordiv-floatX-boolY-fallback self248 other249)
  (if (py-test (py-ne other249 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py// (py-float-to-scheme self248) (py-bool-to-scheme other249)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-floatX-sintY-fallback self251 other252)
  (if (py-test (py-ne other252 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py// (py-float-to-scheme self251) (py-sint-to-scheme other252)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-floatX-bintY-fallback self254 other255)
  (if (py-test (py-ne other255 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py// (py-float-to-scheme self254) (py-bint-to-scheme other255)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-boolX-intY-fallback self257 other258)
  (if (py-test (py-ne other258 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bool-to-scheme self257) (py-int-to-scheme other258)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-boolX-floatY-fallback self260 other261)
  (if (py-test (py-ne self260 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-bool-to-scheme other261) (py-float-to-scheme self260)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-boolX-boolY-fallback self263 other264)
  (if (py-test (py-ne other264 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bool-to-scheme self263) (py-bool-to-scheme other264)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-boolX-sintY-fallback self266 other267)
  (if (py-test (py-ne other267 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bool-to-scheme self266) (py-sint-to-scheme other267)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-boolX-bintY-fallback self269 other270)
  (if (py-test (py-ne other270 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bool-to-scheme self269) (py-bint-to-scheme other270)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-sintX-intY-fallback self272 other273)
  (if (py-test (py-ne other273 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-sint-to-scheme self272) (py-int-to-scheme other273)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-sintX-floatY-fallback self275 other276)
  (if (py-test (py-ne self275 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-sint-to-scheme other276) (py-float-to-scheme self275)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-sintX-boolY-fallback self278 other279)
  (if (py-test (py-ne other279 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-sint-to-scheme self278) (py-bool-to-scheme other279)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-sintX-sintY-fallback self281 other282)
  (if (py-test (py-ne other282 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-sint-to-scheme self281) (py-sint-to-scheme other282)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define-macro (py-floordiv-sintX-sintY-inline self281 other282)
  `(let ((self281 ,self281) (other282 ,other282))
     (if (py-test (py-ne other282 (py-int-from-scheme 0)))
         (py-int-from-scheme
          (py// (py-sint-to-scheme self281) (py-sint-to-scheme other282)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "integer division by zero"))))))

(define (py-floordiv-sintX-bintY-fallback self284 other285)
  (if (py-test (py-ne other285 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-sint-to-scheme self284) (py-bint-to-scheme other285)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-bintX-intY-fallback self287 other288)
  (if (py-test (py-ne other288 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bint-to-scheme self287) (py-int-to-scheme other288)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-bintX-floatY-fallback self290 other291)
  (if (py-test (py-ne self290 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-bint-to-scheme other291) (py-float-to-scheme self290)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-bintX-boolY-fallback self293 other294)
  (if (py-test (py-ne other294 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bint-to-scheme self293) (py-bool-to-scheme other294)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-bintX-sintY-fallback self296 other297)
  (if (py-test (py-ne other297 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bint-to-scheme self296) (py-sint-to-scheme other297)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-bintX-bintY-fallback self299 other300)
  (if (py-test (py-ne other300 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bint-to-scheme self299) (py-bint-to-scheme other300)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-lshift-intX-intY-fallback self302 other303)
  (py-int-from-scheme
   (py<< (py-int-to-scheme self302) (py-int-to-scheme other303))))

(define (py-lshift-intX-floatY-fallback self305 other306)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'int' and 'float'"))))

(define (py-lshift-intX-boolY-fallback self308 other309)
  (py-int-from-scheme
   (py<< (py-int-to-scheme self308) (py-bool-to-scheme other309))))

(define (py-lshift-intX-sintY-fallback self311 other312)
  (py-int-from-scheme
   (py<< (py-int-to-scheme self311) (py-sint-to-scheme other312))))

(define (py-lshift-intX-bintY-fallback self314 other315)
  (py-int-from-scheme
   (py<< (py-int-to-scheme self314) (py-bint-to-scheme other315))))

(define (py-lshift-floatX-intY-fallback self317 other318)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'int'"))))

(define (py-lshift-floatX-floatY-fallback self320 other321)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'float'"))))

(define-macro (py-lshift-floatX-floatY-inline self320 other321)
  `(let ((self320 ,self320) (other321 ,other321))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for <<: 'float' and 'float'")))))

(define (py-lshift-floatX-boolY-fallback self323 other324)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'bool'"))))

(define (py-lshift-floatX-sintY-fallback self326 other327)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'int'"))))

(define (py-lshift-floatX-bintY-fallback self329 other330)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'int'"))))

(define (py-lshift-boolX-intY-fallback self332 other333)
  (py-int-from-scheme
   (py<< (py-bool-to-scheme self332) (py-int-to-scheme other333))))

(define (py-lshift-boolX-floatY-fallback self335 other336)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'bool' and 'float'"))))

(define (py-lshift-boolX-boolY-fallback self338 other339)
  (py-int-from-scheme
   (py<< (py-bool-to-scheme self338) (py-bool-to-scheme other339))))

(define (py-lshift-boolX-sintY-fallback self341 other342)
  (py-int-from-scheme
   (py<< (py-bool-to-scheme self341) (py-sint-to-scheme other342))))

(define (py-lshift-boolX-bintY-fallback self344 other345)
  (py-int-from-scheme
   (py<< (py-bool-to-scheme self344) (py-bint-to-scheme other345))))

(define (py-lshift-sintX-intY-fallback self347 other348)
  (py-int-from-scheme
   (py<< (py-sint-to-scheme self347) (py-int-to-scheme other348))))

(define (py-lshift-sintX-floatY-fallback self350 other351)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'int' and 'float'"))))

(define (py-lshift-sintX-boolY-fallback self353 other354)
  (py-int-from-scheme
   (py<< (py-sint-to-scheme self353) (py-bool-to-scheme other354))))

(define (py-lshift-sintX-sintY-fallback self356 other357)
  (py-int-from-scheme
   (py<< (py-sint-to-scheme self356) (py-sint-to-scheme other357))))

(define-macro (py-lshift-sintX-sintY-inline self356 other357)
  `(let ((self356 ,self356) (other357 ,other357))
     (py-int-from-scheme
      (py<< (py-sint-to-scheme self356) (py-sint-to-scheme other357)))))

(define (py-lshift-sintX-bintY-fallback self359 other360)
  (py-int-from-scheme
   (py<< (py-sint-to-scheme self359) (py-bint-to-scheme other360))))

(define (py-lshift-bintX-intY-fallback self362 other363)
  (py-int-from-scheme
   (py<< (py-bint-to-scheme self362) (py-int-to-scheme other363))))

(define (py-lshift-bintX-floatY-fallback self365 other366)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'int' and 'float'"))))

(define (py-lshift-bintX-boolY-fallback self368 other369)
  (py-int-from-scheme
   (py<< (py-bint-to-scheme self368) (py-bool-to-scheme other369))))

(define (py-lshift-bintX-sintY-fallback self371 other372)
  (py-int-from-scheme
   (py<< (py-bint-to-scheme self371) (py-sint-to-scheme other372))))

(define (py-lshift-bintX-bintY-fallback self374 other375)
  (py-int-from-scheme
   (py<< (py-bint-to-scheme self374) (py-bint-to-scheme other375))))

(define (py-matmul-intX-intY-fallback self377 other378)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-matmul-intX-floatY-fallback self380 other381)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'float'"))))

(define (py-matmul-intX-boolY-fallback self383 other384)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'bool'"))))

(define (py-matmul-intX-sintY-fallback self386 other387)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-matmul-intX-bintY-fallback self389 other390)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-matmul-floatX-intY-fallback self392 other393)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'int'"))))

(define (py-matmul-floatX-floatY-fallback self395 other396)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'float'"))))

(define-macro (py-matmul-floatX-floatY-inline self395 other396)
  `(let ((self395 ,self395) (other396 ,other396))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @: 'float' and 'float'")))))

(define (py-matmul-floatX-boolY-fallback self398 other399)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'bool'"))))

(define (py-matmul-floatX-sintY-fallback self401 other402)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'int'"))))

(define (py-matmul-floatX-bintY-fallback self404 other405)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'int'"))))

(define (py-matmul-boolX-intY-fallback self407 other408)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'int'"))))

(define (py-matmul-boolX-floatY-fallback self410 other411)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'float'"))))

(define (py-matmul-boolX-boolY-fallback self413 other414)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'bool'"))))

(define (py-matmul-boolX-sintY-fallback self416 other417)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'int'"))))

(define (py-matmul-boolX-bintY-fallback self419 other420)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'int'"))))

(define (py-matmul-sintX-intY-fallback self422 other423)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-matmul-sintX-floatY-fallback self425 other426)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'float'"))))

(define (py-matmul-sintX-boolY-fallback self428 other429)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'bool'"))))

(define (py-matmul-sintX-sintY-fallback self431 other432)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define-macro (py-matmul-sintX-sintY-inline self431 other432)
  `(let ((self431 ,self431) (other432 ,other432))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @: 'int' and 'int'")))))

(define (py-matmul-sintX-bintY-fallback self434 other435)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-matmul-bintX-intY-fallback self437 other438)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-matmul-bintX-floatY-fallback self440 other441)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'float'"))))

(define (py-matmul-bintX-boolY-fallback self443 other444)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'bool'"))))

(define (py-matmul-bintX-sintY-fallback self446 other447)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-matmul-bintX-bintY-fallback self449 other450)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-mod-intX-intY-fallback self452 other453)
  (if (py-test (py-ne other453 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-int-to-scheme self452) (py-int-to-scheme other453)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-intX-floatY-fallback self455 other456)
  (if (py-test (py-ne self455 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-int-to-scheme other456) (py-float-to-scheme self455)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-intX-boolY-fallback self458 other459)
  (if (py-test (py-ne other459 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-int-to-scheme self458) (py-bool-to-scheme other459)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-intX-sintY-fallback self461 other462)
  (if (py-test (py-ne other462 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-int-to-scheme self461) (py-sint-to-scheme other462)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-intX-bintY-fallback self464 other465)
  (if (py-test (py-ne other465 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-int-to-scheme self464) (py-bint-to-scheme other465)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-floatX-intY-fallback self467 other468)
  (if (py-test (py-ne other468 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py% (py-float-to-scheme self467) (py-int-to-scheme other468)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-floatX-floatY-fallback self470 other471)
  (if (py-test (py-ne other471 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-float-to-scheme self470) (py-float-to-scheme other471)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define-macro (py-mod-floatX-floatY-inline self470 other471)
  `(let ((self470 ,self470) (other471 ,other471))
     (if (py-test (py-ne other471 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py% (py-float-to-scheme self470) (py-float-to-scheme other471)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float modulo by zero"))))))

(define (py-mod-floatX-boolY-fallback self473 other474)
  (if (py-test (py-ne other474 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py% (py-float-to-scheme self473) (py-bool-to-scheme other474)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-floatX-sintY-fallback self476 other477)
  (if (py-test (py-ne other477 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py% (py-float-to-scheme self476) (py-sint-to-scheme other477)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-floatX-bintY-fallback self479 other480)
  (if (py-test (py-ne other480 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py% (py-float-to-scheme self479) (py-bint-to-scheme other480)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-boolX-intY-fallback self482 other483)
  (if (py-test (py-ne other483 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bool-to-scheme self482) (py-int-to-scheme other483)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-boolX-floatY-fallback self485 other486)
  (if (py-test (py-ne self485 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-bool-to-scheme other486) (py-float-to-scheme self485)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-boolX-boolY-fallback self488 other489)
  (if (py-test (py-ne other489 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bool-to-scheme self488) (py-bool-to-scheme other489)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-boolX-sintY-fallback self491 other492)
  (if (py-test (py-ne other492 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bool-to-scheme self491) (py-sint-to-scheme other492)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-boolX-bintY-fallback self494 other495)
  (if (py-test (py-ne other495 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bool-to-scheme self494) (py-bint-to-scheme other495)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-sintX-intY-fallback self497 other498)
  (if (py-test (py-ne other498 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-sint-to-scheme self497) (py-int-to-scheme other498)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-sintX-floatY-fallback self500 other501)
  (if (py-test (py-ne self500 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-sint-to-scheme other501) (py-float-to-scheme self500)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-sintX-boolY-fallback self503 other504)
  (if (py-test (py-ne other504 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-sint-to-scheme self503) (py-bool-to-scheme other504)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-sintX-sintY-fallback self506 other507)
  (if (py-test (py-ne other507 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-sint-to-scheme self506) (py-sint-to-scheme other507)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define-macro (py-mod-sintX-sintY-inline self506 other507)
  `(let ((self506 ,self506) (other507 ,other507))
     (if (py-test (py-ne other507 (py-int-from-scheme 0)))
         (py-int-from-scheme
          (py% (py-sint-to-scheme self506) (py-sint-to-scheme other507)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError (&& "modulo by zero"))))))

(define (py-mod-sintX-bintY-fallback self509 other510)
  (if (py-test (py-ne other510 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-sint-to-scheme self509) (py-bint-to-scheme other510)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-bintX-intY-fallback self512 other513)
  (if (py-test (py-ne other513 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bint-to-scheme self512) (py-int-to-scheme other513)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-bintX-floatY-fallback self515 other516)
  (if (py-test (py-ne self515 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-bint-to-scheme other516) (py-float-to-scheme self515)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-bintX-boolY-fallback self518 other519)
  (if (py-test (py-ne other519 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bint-to-scheme self518) (py-bool-to-scheme other519)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-bintX-sintY-fallback self521 other522)
  (if (py-test (py-ne other522 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bint-to-scheme self521) (py-sint-to-scheme other522)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-bintX-bintY-fallback self524 other525)
  (if (py-test (py-ne other525 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bint-to-scheme self524) (py-bint-to-scheme other525)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mul-intX-intY-fallback self527 other528)
  (py-int-from-scheme
   (py* (py-int-to-scheme self527) (py-int-to-scheme other528))))

(define (py-mul-intX-floatY-fallback self530 other531)
  (py-float-from-scheme
   (py* (py-int-to-scheme other531) (py-float-to-scheme self530))))

(define (py-mul-intX-boolY-fallback self533 other534)
  (py-int-from-scheme
   (py* (py-int-to-scheme self533) (py-bool-to-scheme other534))))

(define (py-mul-intX-sintY-fallback self536 other537)
  (py-int-from-scheme
   (py* (py-int-to-scheme self536) (py-sint-to-scheme other537))))

(define (py-mul-intX-bintY-fallback self539 other540)
  (py-int-from-scheme
   (py* (py-int-to-scheme self539) (py-bint-to-scheme other540))))

(define (py-mul-floatX-intY-fallback self542 other543)
  (py-float-from-scheme
   (py* (py-float-to-scheme self542) (py-int-to-scheme other543))))

(define (py-mul-floatX-floatY-fallback self545 other546)
  (py-float-from-scheme
   (py* (py-float-to-scheme self545) (py-float-to-scheme other546))))

(define-macro (py-mul-floatX-floatY-inline self545 other546)
  `(let ((self545 ,self545) (other546 ,other546))
     (py-float-from-scheme
      (py* (py-float-to-scheme self545) (py-float-to-scheme other546)))))

(define (py-mul-floatX-boolY-fallback self548 other549)
  (py-float-from-scheme
   (py* (py-float-to-scheme self548) (py-bool-to-scheme other549))))

(define (py-mul-floatX-sintY-fallback self551 other552)
  (py-float-from-scheme
   (py* (py-float-to-scheme self551) (py-sint-to-scheme other552))))

(define (py-mul-floatX-bintY-fallback self554 other555)
  (py-float-from-scheme
   (py* (py-float-to-scheme self554) (py-bint-to-scheme other555))))

(define (py-mul-boolX-intY-fallback self557 other558)
  (py-int-from-scheme
   (py* (py-bool-to-scheme self557) (py-int-to-scheme other558))))

(define (py-mul-boolX-floatY-fallback self560 other561)
  (py-float-from-scheme
   (py* (py-bool-to-scheme other561) (py-float-to-scheme self560))))

(define (py-mul-boolX-boolY-fallback self563 other564)
  (py-int-from-scheme
   (py* (py-bool-to-scheme self563) (py-bool-to-scheme other564))))

(define (py-mul-boolX-sintY-fallback self566 other567)
  (py-int-from-scheme
   (py* (py-bool-to-scheme self566) (py-sint-to-scheme other567))))

(define (py-mul-boolX-bintY-fallback self569 other570)
  (py-int-from-scheme
   (py* (py-bool-to-scheme self569) (py-bint-to-scheme other570))))

(define (py-mul-sintX-intY-fallback self572 other573)
  (py-int-from-scheme
   (py* (py-sint-to-scheme self572) (py-int-to-scheme other573))))

(define (py-mul-sintX-floatY-fallback self575 other576)
  (py-float-from-scheme
   (py* (py-sint-to-scheme other576) (py-float-to-scheme self575))))

(define (py-mul-sintX-boolY-fallback self578 other579)
  (py-int-from-scheme
   (py* (py-sint-to-scheme self578) (py-bool-to-scheme other579))))

(define (py-mul-sintX-sintY-fallback self581 other582)
  (py-int-from-scheme
   (py* (py-sint-to-scheme self581) (py-sint-to-scheme other582))))

(define-macro (py-mul-sintX-sintY-inline self581 other582)
  `(let ((self581 ,self581) (other582 ,other582))
     (py-int-from-scheme
      (py* (py-sint-to-scheme self581) (py-sint-to-scheme other582)))))

(define (py-mul-sintX-bintY-fallback self584 other585)
  (py-int-from-scheme
   (py* (py-sint-to-scheme self584) (py-bint-to-scheme other585))))

(define (py-mul-bintX-intY-fallback self587 other588)
  (py-int-from-scheme
   (py* (py-bint-to-scheme self587) (py-int-to-scheme other588))))

(define (py-mul-bintX-floatY-fallback self590 other591)
  (py-float-from-scheme
   (py* (py-bint-to-scheme other591) (py-float-to-scheme self590))))

(define (py-mul-bintX-boolY-fallback self593 other594)
  (py-int-from-scheme
   (py* (py-bint-to-scheme self593) (py-bool-to-scheme other594))))

(define (py-mul-bintX-sintY-fallback self596 other597)
  (py-int-from-scheme
   (py* (py-bint-to-scheme self596) (py-sint-to-scheme other597))))

(define (py-mul-bintX-bintY-fallback self599 other600)
  (py-int-from-scheme
   (py* (py-bint-to-scheme self599) (py-bint-to-scheme other600))))

(define (py-pow-intX-intY-fallback self602 other603)
  (py-int-from-scheme
   (py** (py-int-to-scheme self602) (py-int-to-scheme other603))))

(define (py-pow-intX-floatY-fallback self605 other606)
  (py-float-from-scheme
   (py** (py-int-to-scheme other606) (py-float-to-scheme self605))))

(define (py-pow-intX-boolY-fallback self608 other609)
  (py-int-from-scheme
   (py** (py-int-to-scheme self608) (py-bool-to-scheme other609))))

(define (py-pow-intX-sintY-fallback self611 other612)
  (py-int-from-scheme
   (py** (py-int-to-scheme self611) (py-sint-to-scheme other612))))

(define (py-pow-intX-bintY-fallback self614 other615)
  (py-int-from-scheme
   (py** (py-int-to-scheme self614) (py-bint-to-scheme other615))))

(define (py-pow-floatX-intY-fallback self617 other618)
  (py-float-from-scheme
   (py** (py-float-to-scheme self617) (py-int-to-scheme other618))))

(define (py-pow-floatX-floatY-fallback self620 other621)
  (py-float-from-scheme
   (py** (py-float-to-scheme self620) (py-float-to-scheme other621))))

(define-macro (py-pow-floatX-floatY-inline self620 other621)
  `(let ((self620 ,self620) (other621 ,other621))
     (py-float-from-scheme
      (py** (py-float-to-scheme self620) (py-float-to-scheme other621)))))

(define (py-pow-floatX-boolY-fallback self623 other624)
  (py-float-from-scheme
   (py** (py-float-to-scheme self623) (py-bool-to-scheme other624))))

(define (py-pow-floatX-sintY-fallback self626 other627)
  (py-float-from-scheme
   (py** (py-float-to-scheme self626) (py-sint-to-scheme other627))))

(define (py-pow-floatX-bintY-fallback self629 other630)
  (py-float-from-scheme
   (py** (py-float-to-scheme self629) (py-bint-to-scheme other630))))

(define (py-pow-boolX-intY-fallback self632 other633)
  (py-int-from-scheme
   (py** (py-bool-to-scheme self632) (py-int-to-scheme other633))))

(define (py-pow-boolX-floatY-fallback self635 other636)
  (py-float-from-scheme
   (py** (py-bool-to-scheme other636) (py-float-to-scheme self635))))

(define (py-pow-boolX-boolY-fallback self638 other639)
  (py-int-from-scheme
   (py** (py-bool-to-scheme self638) (py-bool-to-scheme other639))))

(define (py-pow-boolX-sintY-fallback self641 other642)
  (py-int-from-scheme
   (py** (py-bool-to-scheme self641) (py-sint-to-scheme other642))))

(define (py-pow-boolX-bintY-fallback self644 other645)
  (py-int-from-scheme
   (py** (py-bool-to-scheme self644) (py-bint-to-scheme other645))))

(define (py-pow-sintX-intY-fallback self647 other648)
  (py-int-from-scheme
   (py** (py-sint-to-scheme self647) (py-int-to-scheme other648))))

(define (py-pow-sintX-floatY-fallback self650 other651)
  (py-float-from-scheme
   (py** (py-sint-to-scheme other651) (py-float-to-scheme self650))))

(define (py-pow-sintX-boolY-fallback self653 other654)
  (py-int-from-scheme
   (py** (py-sint-to-scheme self653) (py-bool-to-scheme other654))))

(define (py-pow-sintX-sintY-fallback self656 other657)
  (py-int-from-scheme
   (py** (py-sint-to-scheme self656) (py-sint-to-scheme other657))))

(define-macro (py-pow-sintX-sintY-inline self656 other657)
  `(let ((self656 ,self656) (other657 ,other657))
     (py-int-from-scheme
      (py** (py-sint-to-scheme self656) (py-sint-to-scheme other657)))))

(define (py-pow-sintX-bintY-fallback self659 other660)
  (py-int-from-scheme
   (py** (py-sint-to-scheme self659) (py-bint-to-scheme other660))))

(define (py-pow-bintX-intY-fallback self662 other663)
  (py-int-from-scheme
   (py** (py-bint-to-scheme self662) (py-int-to-scheme other663))))

(define (py-pow-bintX-floatY-fallback self665 other666)
  (py-float-from-scheme
   (py** (py-bint-to-scheme other666) (py-float-to-scheme self665))))

(define (py-pow-bintX-boolY-fallback self668 other669)
  (py-int-from-scheme
   (py** (py-bint-to-scheme self668) (py-bool-to-scheme other669))))

(define (py-pow-bintX-sintY-fallback self671 other672)
  (py-int-from-scheme
   (py** (py-bint-to-scheme self671) (py-sint-to-scheme other672))))

(define (py-pow-bintX-bintY-fallback self674 other675)
  (py-int-from-scheme
   (py** (py-bint-to-scheme self674) (py-bint-to-scheme other675))))

(define (py-rshift-intX-intY-fallback self677 other678)
  (py-int-from-scheme
   (py>> (py-int-to-scheme self677) (py-int-to-scheme other678))))

(define (py-rshift-intX-floatY-fallback self680 other681)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'int' and 'float'"))))

(define (py-rshift-intX-boolY-fallback self683 other684)
  (py-int-from-scheme
   (py>> (py-bool-to-scheme self683) (py-int-to-scheme other684))))

(define (py-rshift-intX-sintY-fallback self686 other687)
  (py-int-from-scheme
   (py>> (py-sint-to-scheme self686) (py-int-to-scheme other687))))

(define (py-rshift-intX-bintY-fallback self689 other690)
  (py-int-from-scheme
   (py>> (py-bint-to-scheme self689) (py-int-to-scheme other690))))

(define (py-rshift-floatX-intY-fallback self692 other693)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'int'"))))

(define (py-rshift-floatX-floatY-fallback self695 other696)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'float'"))))

(define-macro (py-rshift-floatX-floatY-inline self695 other696)
  `(let ((self695 ,self695) (other696 ,other696))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for >>: 'float' and 'float'")))))

(define (py-rshift-floatX-boolY-fallback self698 other699)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'bool'"))))

(define (py-rshift-floatX-sintY-fallback self701 other702)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'int'"))))

(define (py-rshift-floatX-bintY-fallback self704 other705)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'int'"))))

(define (py-rshift-boolX-intY-fallback self707 other708)
  (py-int-from-scheme
   (py>> (py-int-to-scheme self707) (py-bool-to-scheme other708))))

(define (py-rshift-boolX-floatY-fallback self710 other711)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'bool' and 'float'"))))

(define (py-rshift-boolX-boolY-fallback self713 other714)
  (py-int-from-scheme
   (py>> (py-bool-to-scheme self713) (py-bool-to-scheme other714))))

(define (py-rshift-boolX-sintY-fallback self716 other717)
  (py-int-from-scheme
   (py>> (py-sint-to-scheme self716) (py-bool-to-scheme other717))))

(define (py-rshift-boolX-bintY-fallback self719 other720)
  (py-int-from-scheme
   (py>> (py-bint-to-scheme self719) (py-bool-to-scheme other720))))

(define (py-rshift-sintX-intY-fallback self722 other723)
  (py-int-from-scheme
   (py>> (py-int-to-scheme self722) (py-sint-to-scheme other723))))

(define (py-rshift-sintX-floatY-fallback self725 other726)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'int' and 'float'"))))

(define (py-rshift-sintX-boolY-fallback self728 other729)
  (py-int-from-scheme
   (py>> (py-bool-to-scheme self728) (py-sint-to-scheme other729))))

(define (py-rshift-sintX-sintY-fallback self731 other732)
  (py-int-from-scheme
   (py>> (py-sint-to-scheme self731) (py-sint-to-scheme other732))))

(define-macro (py-rshift-sintX-sintY-inline self731 other732)
  `(let ((self731 ,self731) (other732 ,other732))
     (py-int-from-scheme
      (py>> (py-sint-to-scheme self731) (py-sint-to-scheme other732)))))

(define (py-rshift-sintX-bintY-fallback self734 other735)
  (py-int-from-scheme
   (py>> (py-bint-to-scheme self734) (py-sint-to-scheme other735))))

(define (py-rshift-bintX-intY-fallback self737 other738)
  (py-int-from-scheme
   (py>> (py-int-to-scheme self737) (py-bint-to-scheme other738))))

(define (py-rshift-bintX-floatY-fallback self740 other741)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'int' and 'float'"))))

(define (py-rshift-bintX-boolY-fallback self743 other744)
  (py-int-from-scheme
   (py>> (py-bool-to-scheme self743) (py-bint-to-scheme other744))))

(define (py-rshift-bintX-sintY-fallback self746 other747)
  (py-int-from-scheme
   (py>> (py-sint-to-scheme self746) (py-bint-to-scheme other747))))

(define (py-rshift-bintX-bintY-fallback self749 other750)
  (py-int-from-scheme
   (py>> (py-bint-to-scheme self749) (py-bint-to-scheme other750))))

(define (py-sub-intX-intY-fallback self752 other753)
  (py-int-from-scheme
   (py- (py-int-to-scheme self752) (py-int-to-scheme other753))))

(define (py-sub-intX-floatY-fallback self755 other756)
  (py-float-from-scheme
   (py- (py-int-to-scheme other756) (py-float-to-scheme self755))))

(define (py-sub-intX-boolY-fallback self758 other759)
  (py-int-from-scheme
   (py- (py-int-to-scheme self758) (py-bool-to-scheme other759))))

(define (py-sub-intX-sintY-fallback self761 other762)
  (py-int-from-scheme
   (py- (py-int-to-scheme self761) (py-sint-to-scheme other762))))

(define (py-sub-intX-bintY-fallback self764 other765)
  (py-int-from-scheme
   (py- (py-int-to-scheme self764) (py-bint-to-scheme other765))))

(define (py-sub-floatX-intY-fallback self767 other768)
  (py-float-from-scheme
   (py- (py-float-to-scheme self767) (py-int-to-scheme other768))))

(define (py-sub-floatX-floatY-fallback self770 other771)
  (py-float-from-scheme
   (py- (py-float-to-scheme self770) (py-float-to-scheme other771))))

(define-macro (py-sub-floatX-floatY-inline self770 other771)
  `(let ((self770 ,self770) (other771 ,other771))
     (py-float-from-scheme
      (py- (py-float-to-scheme self770) (py-float-to-scheme other771)))))

(define (py-sub-floatX-boolY-fallback self773 other774)
  (py-float-from-scheme
   (py- (py-float-to-scheme self773) (py-bool-to-scheme other774))))

(define (py-sub-floatX-sintY-fallback self776 other777)
  (py-float-from-scheme
   (py- (py-float-to-scheme self776) (py-sint-to-scheme other777))))

(define (py-sub-floatX-bintY-fallback self779 other780)
  (py-float-from-scheme
   (py- (py-float-to-scheme self779) (py-bint-to-scheme other780))))

(define (py-sub-boolX-intY-fallback self782 other783)
  (py-int-from-scheme
   (py- (py-bool-to-scheme self782) (py-int-to-scheme other783))))

(define (py-sub-boolX-floatY-fallback self785 other786)
  (py-float-from-scheme
   (py- (py-bool-to-scheme other786) (py-float-to-scheme self785))))

(define (py-sub-boolX-boolY-fallback self788 other789)
  (py-int-from-scheme
   (py- (py-bool-to-scheme self788) (py-bool-to-scheme other789))))

(define (py-sub-boolX-sintY-fallback self791 other792)
  (py-int-from-scheme
   (py- (py-bool-to-scheme self791) (py-sint-to-scheme other792))))

(define (py-sub-boolX-bintY-fallback self794 other795)
  (py-int-from-scheme
   (py- (py-bool-to-scheme self794) (py-bint-to-scheme other795))))

(define (py-sub-sintX-intY-fallback self797 other798)
  (py-int-from-scheme
   (py- (py-sint-to-scheme self797) (py-int-to-scheme other798))))

(define (py-sub-sintX-floatY-fallback self800 other801)
  (py-float-from-scheme
   (py- (py-sint-to-scheme other801) (py-float-to-scheme self800))))

(define (py-sub-sintX-boolY-fallback self803 other804)
  (py-int-from-scheme
   (py- (py-sint-to-scheme self803) (py-bool-to-scheme other804))))

(define (py-sub-sintX-sintY-fallback self806 other807)
  (py-int-from-scheme
   (py- (py-sint-to-scheme self806) (py-sint-to-scheme other807))))

(define-macro (py-sub-sintX-sintY-inline self806 other807)
  `(let ((self806 ,self806) (other807 ,other807))
     (py-int-from-scheme
      (py- (py-sint-to-scheme self806) (py-sint-to-scheme other807)))))

(define (py-sub-sintX-bintY-fallback self809 other810)
  (py-int-from-scheme
   (py- (py-sint-to-scheme self809) (py-bint-to-scheme other810))))

(define (py-sub-bintX-intY-fallback self812 other813)
  (py-int-from-scheme
   (py- (py-bint-to-scheme self812) (py-int-to-scheme other813))))

(define (py-sub-bintX-floatY-fallback self815 other816)
  (py-float-from-scheme
   (py- (py-bint-to-scheme other816) (py-float-to-scheme self815))))

(define (py-sub-bintX-boolY-fallback self818 other819)
  (py-int-from-scheme
   (py- (py-bint-to-scheme self818) (py-bool-to-scheme other819))))

(define (py-sub-bintX-sintY-fallback self821 other822)
  (py-int-from-scheme
   (py- (py-bint-to-scheme self821) (py-sint-to-scheme other822))))

(define (py-sub-bintX-bintY-fallback self824 other825)
  (py-int-from-scheme
   (py- (py-bint-to-scheme self824) (py-bint-to-scheme other825))))

(define (py-truediv-intX-intY-fallback self827 other828)
  (if (py-test (py-ne other828 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-int-to-scheme self827) (py-int-to-scheme other828)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-intX-floatY-fallback self830 other831)
  (if (py-test (py-ne self830 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-int-to-scheme other831) (py-float-to-scheme self830)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-intX-boolY-fallback self833 other834)
  (if (py-test (py-ne other834 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-int-to-scheme self833) (py-bool-to-scheme other834)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-intX-sintY-fallback self836 other837)
  (if (py-test (py-ne other837 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-int-to-scheme self836) (py-sint-to-scheme other837)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-intX-bintY-fallback self839 other840)
  (if (py-test (py-ne other840 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-int-to-scheme self839) (py-bint-to-scheme other840)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-floatX-intY-fallback self842 other843)
  (if (py-test (py-ne other843 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme self842) (py-int-to-scheme other843)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-floatX-floatY-fallback self845 other846)
  (if (py-test (py-ne other846 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme self845) (py-float-to-scheme other846)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define-macro (py-truediv-floatX-floatY-inline self845 other846)
  `(let ((self845 ,self845) (other846 ,other846))
     (if (py-test (py-ne other846 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py/ (py-float-to-scheme self845) (py-float-to-scheme other846)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define (py-truediv-floatX-boolY-fallback self848 other849)
  (if (py-test (py-ne other849 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme self848) (py-bool-to-scheme other849)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-floatX-sintY-fallback self851 other852)
  (if (py-test (py-ne other852 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme self851) (py-sint-to-scheme other852)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-floatX-bintY-fallback self854 other855)
  (if (py-test (py-ne other855 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme self854) (py-bint-to-scheme other855)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-boolX-intY-fallback self857 other858)
  (if (py-test (py-ne other858 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme self857) (py-int-to-scheme other858)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-boolX-floatY-fallback self860 other861)
  (if (py-test (py-ne self860 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme other861) (py-float-to-scheme self860)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-boolX-boolY-fallback self863 other864)
  (if (py-test (py-ne other864 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme self863) (py-bool-to-scheme other864)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-boolX-sintY-fallback self866 other867)
  (if (py-test (py-ne other867 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme self866) (py-sint-to-scheme other867)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-boolX-bintY-fallback self869 other870)
  (if (py-test (py-ne other870 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme self869) (py-bint-to-scheme other870)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-sintX-intY-fallback self872 other873)
  (if (py-test (py-ne other873 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme self872) (py-int-to-scheme other873)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-sintX-floatY-fallback self875 other876)
  (if (py-test (py-ne self875 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme other876) (py-float-to-scheme self875)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-sintX-boolY-fallback self878 other879)
  (if (py-test (py-ne other879 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme self878) (py-bool-to-scheme other879)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-sintX-sintY-fallback self881 other882)
  (if (py-test (py-ne other882 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme self881) (py-sint-to-scheme other882)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define-macro (py-truediv-sintX-sintY-inline self881 other882)
  `(let ((self881 ,self881) (other882 ,other882))
     (if (py-test (py-ne other882 (py-int-from-scheme 0)))
         (py-float-from-scheme
          (py/ (py-sint-to-scheme self881) (py-sint-to-scheme other882)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError (&& "division by zero"))))))

(define (py-truediv-sintX-bintY-fallback self884 other885)
  (if (py-test (py-ne other885 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme self884) (py-bint-to-scheme other885)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-bintX-intY-fallback self887 other888)
  (if (py-test (py-ne other888 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme self887) (py-int-to-scheme other888)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-bintX-floatY-fallback self890 other891)
  (if (py-test (py-ne self890 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme other891) (py-float-to-scheme self890)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-bintX-boolY-fallback self893 other894)
  (if (py-test (py-ne other894 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme self893) (py-bool-to-scheme other894)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-bintX-sintY-fallback self896 other897)
  (if (py-test (py-ne other897 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme self896) (py-sint-to-scheme other897)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-bintX-bintY-fallback self899 other900)
  (if (py-test (py-ne other900 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme self899) (py-bint-to-scheme other900)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-xor-intX-intY-fallback self902 other903)
  (py-int-from-scheme
   (py^ (py-int-to-scheme self902) (py-int-to-scheme other903))))

(define (py-xor-intX-floatY-fallback self905 other906)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'int' and 'float'"))))

(define (py-xor-intX-boolY-fallback self908 other909)
  (py-int-from-scheme
   (py^ (py-int-to-scheme self908) (py-bool-to-scheme other909))))

(define (py-xor-intX-sintY-fallback self911 other912)
  (py-int-from-scheme
   (py^ (py-int-to-scheme self911) (py-sint-to-scheme other912))))

(define (py-xor-intX-bintY-fallback self914 other915)
  (py-int-from-scheme
   (py^ (py-int-to-scheme self914) (py-bint-to-scheme other915))))

(define (py-xor-floatX-intY-fallback self917 other918)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'int'"))))

(define (py-xor-floatX-floatY-fallback self920 other921)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'float'"))))

(define-macro (py-xor-floatX-floatY-inline self920 other921)
  `(let ((self920 ,self920) (other921 ,other921))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for ^: 'float' and 'float'")))))

(define (py-xor-floatX-boolY-fallback self923 other924)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'bool'"))))

(define (py-xor-floatX-sintY-fallback self926 other927)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'int'"))))

(define (py-xor-floatX-bintY-fallback self929 other930)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'int'"))))

(define (py-xor-boolX-intY-fallback self932 other933)
  (py-int-from-scheme
   (py^ (py-bool-to-scheme self932) (py-int-to-scheme other933))))

(define (py-xor-boolX-floatY-fallback self935 other936)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'bool' and 'float'"))))

(define (py-xor-boolX-boolY-fallback self938 other939)
  (py-isnot self938 other939))

(define (py-xor-boolX-sintY-fallback self941 other942)
  (py-int-from-scheme
   (py^ (py-bool-to-scheme self941) (py-sint-to-scheme other942))))

(define (py-xor-boolX-bintY-fallback self944 other945)
  (py-int-from-scheme
   (py^ (py-bool-to-scheme self944) (py-bint-to-scheme other945))))

(define (py-xor-sintX-intY-fallback self947 other948)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme self947) (py-int-to-scheme other948))))

(define (py-xor-sintX-floatY-fallback self950 other951)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'int' and 'float'"))))

(define (py-xor-sintX-boolY-fallback self953 other954)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme self953) (py-bool-to-scheme other954))))

(define (py-xor-sintX-sintY-fallback self956 other957)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme self956) (py-sint-to-scheme other957))))

(define-macro (py-xor-sintX-sintY-inline self956 other957)
  `(let ((self956 ,self956) (other957 ,other957))
     (py-int-from-scheme
      (py^ (py-sint-to-scheme self956) (py-sint-to-scheme other957)))))

(define (py-xor-sintX-bintY-fallback self959 other960)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme self959) (py-bint-to-scheme other960))))

(define (py-xor-bintX-intY-fallback self962 other963)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme self962) (py-int-to-scheme other963))))

(define (py-xor-bintX-floatY-fallback self965 other966)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'int' and 'float'"))))

(define (py-xor-bintX-boolY-fallback self968 other969)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme self968) (py-bool-to-scheme other969))))

(define (py-xor-bintX-sintY-fallback self971 other972)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme self971) (py-sint-to-scheme other972))))

(define (py-xor-bintX-bintY-fallback self974 other975)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme self974) (py-bint-to-scheme other975))))

(define (py-iadd-intX-intY-fallback self977 other978)
  (py-int-from-scheme
   (py+ (py-int-to-scheme self977) (py-int-to-scheme other978))))

(define (py-iadd-intX-floatY-fallback self980 other981)
  (py-float-from-scheme
   (py+ (py-int-to-scheme other981) (py-float-to-scheme self980))))

(define (py-iadd-intX-boolY-fallback self983 other984)
  (py-int-from-scheme
   (py+ (py-int-to-scheme self983) (py-bool-to-scheme other984))))

(define (py-iadd-intX-sintY-fallback self986 other987)
  (py-int-from-scheme
   (py+ (py-int-to-scheme self986) (py-sint-to-scheme other987))))

(define (py-iadd-intX-bintY-fallback self989 other990)
  (py-int-from-scheme
   (py+ (py-int-to-scheme self989) (py-bint-to-scheme other990))))

(define (py-iadd-floatX-intY-fallback self992 other993)
  (py-float-from-scheme
   (py+ (py-float-to-scheme self992) (py-int-to-scheme other993))))

(define (py-iadd-floatX-floatY-fallback self995 other996)
  (py-float-from-scheme
   (py+ (py-float-to-scheme self995) (py-float-to-scheme other996))))

(define-macro (py-iadd-floatX-floatY-inline self995 other996)
  `(let ((self995 ,self995) (other996 ,other996))
     (py-float-from-scheme
      (py+ (py-float-to-scheme self995) (py-float-to-scheme other996)))))

(define (py-iadd-floatX-boolY-fallback self998 other999)
  (py-float-from-scheme
   (py+ (py-float-to-scheme self998) (py-bool-to-scheme other999))))

(define (py-iadd-floatX-sintY-fallback self1001 other1002)
  (py-float-from-scheme
   (py+ (py-float-to-scheme self1001) (py-sint-to-scheme other1002))))

(define (py-iadd-floatX-bintY-fallback self1004 other1005)
  (py-float-from-scheme
   (py+ (py-float-to-scheme self1004) (py-bint-to-scheme other1005))))

(define (py-iadd-boolX-intY-fallback self1007 other1008)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme self1007) (py-int-to-scheme other1008))))

(define (py-iadd-boolX-floatY-fallback self1010 other1011)
  (py-float-from-scheme
   (py+ (py-bool-to-scheme other1011) (py-float-to-scheme self1010))))

(define (py-iadd-boolX-boolY-fallback self1013 other1014)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme self1013) (py-bool-to-scheme other1014))))

(define (py-iadd-boolX-sintY-fallback self1016 other1017)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme self1016) (py-sint-to-scheme other1017))))

(define (py-iadd-boolX-bintY-fallback self1019 other1020)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme self1019) (py-bint-to-scheme other1020))))

(define (py-iadd-sintX-intY-fallback self1022 other1023)
  (py-int-from-scheme
   (py+ (py-sint-to-scheme self1022) (py-int-to-scheme other1023))))

(define (py-iadd-sintX-floatY-fallback self1025 other1026)
  (py-float-from-scheme
   (py+ (py-sint-to-scheme other1026) (py-float-to-scheme self1025))))

(define (py-iadd-sintX-boolY-fallback self1028 other1029)
  (py-int-from-scheme
   (py+ (py-sint-to-scheme self1028) (py-bool-to-scheme other1029))))

(define (py-iadd-sintX-sintY-fallback self1031 other1032)
  (py-int-from-scheme
   (py+ (py-sint-to-scheme self1031) (py-sint-to-scheme other1032))))

(define-macro (py-iadd-sintX-sintY-inline self1031 other1032)
  `(let ((self1031 ,self1031) (other1032 ,other1032))
     (py-int-from-scheme
      (py+ (py-sint-to-scheme self1031) (py-sint-to-scheme other1032)))))

(define (py-iadd-sintX-bintY-fallback self1034 other1035)
  (py-int-from-scheme
   (py+ (py-sint-to-scheme self1034) (py-bint-to-scheme other1035))))

(define (py-iadd-bintX-intY-fallback self1037 other1038)
  (py-int-from-scheme
   (py+ (py-bint-to-scheme self1037) (py-int-to-scheme other1038))))

(define (py-iadd-bintX-floatY-fallback self1040 other1041)
  (py-float-from-scheme
   (py+ (py-bint-to-scheme other1041) (py-float-to-scheme self1040))))

(define (py-iadd-bintX-boolY-fallback self1043 other1044)
  (py-int-from-scheme
   (py+ (py-bint-to-scheme self1043) (py-bool-to-scheme other1044))))

(define (py-iadd-bintX-sintY-fallback self1046 other1047)
  (py-int-from-scheme
   (py+ (py-bint-to-scheme self1046) (py-sint-to-scheme other1047))))

(define (py-iadd-bintX-bintY-fallback self1049 other1050)
  (py-int-from-scheme
   (py+ (py-bint-to-scheme self1049) (py-bint-to-scheme other1050))))

(define (py-ibitand-intX-intY-fallback self1052 other1053)
  (py-int-from-scheme
   (py& (py-int-to-scheme self1052) (py-int-to-scheme other1053))))

(define (py-ibitand-intX-floatY-fallback self1055 other1056)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'int' and 'float'"))))

(define (py-ibitand-intX-boolY-fallback self1058 other1059)
  (py-int-from-scheme
   (py& (py-int-to-scheme self1058) (py-bool-to-scheme other1059))))

(define (py-ibitand-intX-sintY-fallback self1061 other1062)
  (py-int-from-scheme
   (py& (py-int-to-scheme self1061) (py-sint-to-scheme other1062))))

(define (py-ibitand-intX-bintY-fallback self1064 other1065)
  (py-int-from-scheme
   (py& (py-int-to-scheme self1064) (py-bint-to-scheme other1065))))

(define (py-ibitand-floatX-intY-fallback self1067 other1068)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'int'"))))

(define (py-ibitand-floatX-floatY-fallback self1070 other1071)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'float'"))))

(define-macro (py-ibitand-floatX-floatY-inline self1070 other1071)
  `(let ((self1070 ,self1070) (other1071 ,other1071))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for &: 'float' and 'float'")))))

(define (py-ibitand-floatX-boolY-fallback self1073 other1074)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'bool'"))))

(define (py-ibitand-floatX-sintY-fallback self1076 other1077)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'int'"))))

(define (py-ibitand-floatX-bintY-fallback self1079 other1080)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'int'"))))

(define (py-ibitand-boolX-intY-fallback self1082 other1083)
  (py-int-from-scheme
   (py& (py-bool-to-scheme self1082) (py-int-to-scheme other1083))))

(define (py-ibitand-boolX-floatY-fallback self1085 other1086)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'bool' and 'float'"))))

(define (py-ibitand-boolX-boolY-fallback self1088 other1089)
  (if (py-test (py-is self1088 py-True)) other1089 py-False))

(define (py-ibitand-boolX-sintY-fallback self1091 other1092)
  (py-int-from-scheme
   (py& (py-bool-to-scheme self1091) (py-sint-to-scheme other1092))))

(define (py-ibitand-boolX-bintY-fallback self1094 other1095)
  (py-int-from-scheme
   (py& (py-bool-to-scheme self1094) (py-bint-to-scheme other1095))))

(define (py-ibitand-sintX-intY-fallback self1097 other1098)
  (py-int-from-scheme
   (py& (py-sint-to-scheme self1097) (py-int-to-scheme other1098))))

(define (py-ibitand-sintX-floatY-fallback self1100 other1101)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'int' and 'float'"))))

(define (py-ibitand-sintX-boolY-fallback self1103 other1104)
  (py-int-from-scheme
   (py& (py-sint-to-scheme self1103) (py-bool-to-scheme other1104))))

(define (py-ibitand-sintX-sintY-fallback self1106 other1107)
  (py-int-from-scheme
   (py& (py-sint-to-scheme self1106) (py-sint-to-scheme other1107))))

(define-macro (py-ibitand-sintX-sintY-inline self1106 other1107)
  `(let ((self1106 ,self1106) (other1107 ,other1107))
     (py-int-from-scheme
      (py& (py-sint-to-scheme self1106) (py-sint-to-scheme other1107)))))

(define (py-ibitand-sintX-bintY-fallback self1109 other1110)
  (py-int-from-scheme
   (py& (py-sint-to-scheme self1109) (py-bint-to-scheme other1110))))

(define (py-ibitand-bintX-intY-fallback self1112 other1113)
  (py-int-from-scheme
   (py& (py-bint-to-scheme self1112) (py-int-to-scheme other1113))))

(define (py-ibitand-bintX-floatY-fallback self1115 other1116)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'int' and 'float'"))))

(define (py-ibitand-bintX-boolY-fallback self1118 other1119)
  (py-int-from-scheme
   (py& (py-bint-to-scheme self1118) (py-bool-to-scheme other1119))))

(define (py-ibitand-bintX-sintY-fallback self1121 other1122)
  (py-int-from-scheme
   (py& (py-bint-to-scheme self1121) (py-sint-to-scheme other1122))))

(define (py-ibitand-bintX-bintY-fallback self1124 other1125)
  (py-int-from-scheme
   (py& (py-bint-to-scheme self1124) (py-bint-to-scheme other1125))))

(define (py-ibitor-intX-intY-fallback self1127 other1128)
  (py-int-from-scheme
   (py+b (py-int-to-scheme self1127) (py-int-to-scheme other1128))))

(define (py-ibitor-intX-floatY-fallback self1130 other1131)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'int' and 'float'"))))

(define (py-ibitor-intX-boolY-fallback self1133 other1134)
  (py-int-from-scheme
   (py+b (py-int-to-scheme self1133) (py-bool-to-scheme other1134))))

(define (py-ibitor-intX-sintY-fallback self1136 other1137)
  (py-int-from-scheme
   (py+b (py-int-to-scheme self1136) (py-sint-to-scheme other1137))))

(define (py-ibitor-intX-bintY-fallback self1139 other1140)
  (py-int-from-scheme
   (py+b (py-int-to-scheme self1139) (py-bint-to-scheme other1140))))

(define (py-ibitor-floatX-intY-fallback self1142 other1143)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'int'"))))

(define (py-ibitor-floatX-floatY-fallback self1145 other1146)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'float'"))))

(define-macro (py-ibitor-floatX-floatY-inline self1145 other1146)
  `(let ((self1145 ,self1145) (other1146 ,other1146))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for |: 'float' and 'float'")))))

(define (py-ibitor-floatX-boolY-fallback self1148 other1149)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'bool'"))))

(define (py-ibitor-floatX-sintY-fallback self1151 other1152)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'int'"))))

(define (py-ibitor-floatX-bintY-fallback self1154 other1155)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'int'"))))

(define (py-ibitor-boolX-intY-fallback self1157 other1158)
  (py-int-from-scheme
   (py+b (py-bool-to-scheme self1157) (py-int-to-scheme other1158))))

(define (py-ibitor-boolX-floatY-fallback self1160 other1161)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'bool' and 'float'"))))

(define (py-ibitor-boolX-boolY-fallback self1163 other1164)
  (if (py-test (py-is self1163 py-True)) py-True other1164))

(define (py-ibitor-boolX-sintY-fallback self1166 other1167)
  (py-int-from-scheme
   (py+b (py-bool-to-scheme self1166) (py-sint-to-scheme other1167))))

(define (py-ibitor-boolX-bintY-fallback self1169 other1170)
  (py-int-from-scheme
   (py+b (py-bool-to-scheme self1169) (py-bint-to-scheme other1170))))

(define (py-ibitor-sintX-intY-fallback self1172 other1173)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme self1172) (py-int-to-scheme other1173))))

(define (py-ibitor-sintX-floatY-fallback self1175 other1176)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'int' and 'float'"))))

(define (py-ibitor-sintX-boolY-fallback self1178 other1179)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme self1178) (py-bool-to-scheme other1179))))

(define (py-ibitor-sintX-sintY-fallback self1181 other1182)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme self1181) (py-sint-to-scheme other1182))))

(define-macro (py-ibitor-sintX-sintY-inline self1181 other1182)
  `(let ((self1181 ,self1181) (other1182 ,other1182))
     (py-int-from-scheme
      (py+b (py-sint-to-scheme self1181) (py-sint-to-scheme other1182)))))

(define (py-ibitor-sintX-bintY-fallback self1184 other1185)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme self1184) (py-bint-to-scheme other1185))))

(define (py-ibitor-bintX-intY-fallback self1187 other1188)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme self1187) (py-int-to-scheme other1188))))

(define (py-ibitor-bintX-floatY-fallback self1190 other1191)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'int' and 'float'"))))

(define (py-ibitor-bintX-boolY-fallback self1193 other1194)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme self1193) (py-bool-to-scheme other1194))))

(define (py-ibitor-bintX-sintY-fallback self1196 other1197)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme self1196) (py-sint-to-scheme other1197))))

(define (py-ibitor-bintX-bintY-fallback self1199 other1200)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme self1199) (py-bint-to-scheme other1200))))

(define (py-ifloordiv-intX-intY-fallback self1202 other1203)
  (if (py-test (py-ne other1203 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-int-to-scheme self1202) (py-int-to-scheme other1203)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-intX-floatY-fallback self1205 other1206)
  (if (py-test (py-ne self1205 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-int-to-scheme other1206) (py-float-to-scheme self1205)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-intX-boolY-fallback self1208 other1209)
  (if (py-test (py-ne other1209 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-int-to-scheme self1208) (py-bool-to-scheme other1209)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-intX-sintY-fallback self1211 other1212)
  (if (py-test (py-ne other1212 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-int-to-scheme self1211) (py-sint-to-scheme other1212)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-intX-bintY-fallback self1214 other1215)
  (if (py-test (py-ne other1215 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-int-to-scheme self1214) (py-bint-to-scheme other1215)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-floatX-intY-fallback self1217 other1218)
  (if (py-test (py-ne other1218 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py// (py-float-to-scheme self1217) (py-int-to-scheme other1218)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-floatX-floatY-fallback self1220 other1221)
  (if (py-test (py-ne other1221 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-float-to-scheme self1220) (py-float-to-scheme other1221)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define-macro (py-ifloordiv-floatX-floatY-inline self1220 other1221)
  `(let ((self1220 ,self1220) (other1221 ,other1221))
     (if (py-test (py-ne other1221 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py// (py-float-to-scheme self1220) (py-float-to-scheme other1221)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define (py-ifloordiv-floatX-boolY-fallback self1223 other1224)
  (if (py-test (py-ne other1224 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py// (py-float-to-scheme self1223) (py-bool-to-scheme other1224)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-floatX-sintY-fallback self1226 other1227)
  (if (py-test (py-ne other1227 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py// (py-float-to-scheme self1226) (py-sint-to-scheme other1227)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-floatX-bintY-fallback self1229 other1230)
  (if (py-test (py-ne other1230 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py// (py-float-to-scheme self1229) (py-bint-to-scheme other1230)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-boolX-intY-fallback self1232 other1233)
  (if (py-test (py-ne other1233 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bool-to-scheme self1232) (py-int-to-scheme other1233)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-boolX-floatY-fallback self1235 other1236)
  (if (py-test (py-ne self1235 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-bool-to-scheme other1236) (py-float-to-scheme self1235)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-boolX-boolY-fallback self1238 other1239)
  (if (py-test (py-ne other1239 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bool-to-scheme self1238) (py-bool-to-scheme other1239)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-boolX-sintY-fallback self1241 other1242)
  (if (py-test (py-ne other1242 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bool-to-scheme self1241) (py-sint-to-scheme other1242)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-boolX-bintY-fallback self1244 other1245)
  (if (py-test (py-ne other1245 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bool-to-scheme self1244) (py-bint-to-scheme other1245)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-sintX-intY-fallback self1247 other1248)
  (if (py-test (py-ne other1248 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-sint-to-scheme self1247) (py-int-to-scheme other1248)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-sintX-floatY-fallback self1250 other1251)
  (if (py-test (py-ne self1250 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-sint-to-scheme other1251) (py-float-to-scheme self1250)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-sintX-boolY-fallback self1253 other1254)
  (if (py-test (py-ne other1254 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-sint-to-scheme self1253) (py-bool-to-scheme other1254)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-sintX-sintY-fallback self1256 other1257)
  (if (py-test (py-ne other1257 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-sint-to-scheme self1256) (py-sint-to-scheme other1257)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define-macro (py-ifloordiv-sintX-sintY-inline self1256 other1257)
  `(let ((self1256 ,self1256) (other1257 ,other1257))
     (if (py-test (py-ne other1257 (py-int-from-scheme 0)))
         (py-int-from-scheme
          (py// (py-sint-to-scheme self1256) (py-sint-to-scheme other1257)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "integer division by zero"))))))

(define (py-ifloordiv-sintX-bintY-fallback self1259 other1260)
  (if (py-test (py-ne other1260 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-sint-to-scheme self1259) (py-bint-to-scheme other1260)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-bintX-intY-fallback self1262 other1263)
  (if (py-test (py-ne other1263 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bint-to-scheme self1262) (py-int-to-scheme other1263)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-bintX-floatY-fallback self1265 other1266)
  (if (py-test (py-ne self1265 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-bint-to-scheme other1266) (py-float-to-scheme self1265)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-bintX-boolY-fallback self1268 other1269)
  (if (py-test (py-ne other1269 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bint-to-scheme self1268) (py-bool-to-scheme other1269)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-bintX-sintY-fallback self1271 other1272)
  (if (py-test (py-ne other1272 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bint-to-scheme self1271) (py-sint-to-scheme other1272)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-bintX-bintY-fallback self1274 other1275)
  (if (py-test (py-ne other1275 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bint-to-scheme self1274) (py-bint-to-scheme other1275)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ilshift-intX-intY-fallback self1277 other1278)
  (py-int-from-scheme
   (py<< (py-int-to-scheme self1277) (py-int-to-scheme other1278))))

(define (py-ilshift-intX-floatY-fallback self1280 other1281)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'int' and 'float'"))))

(define (py-ilshift-intX-boolY-fallback self1283 other1284)
  (py-int-from-scheme
   (py<< (py-int-to-scheme self1283) (py-bool-to-scheme other1284))))

(define (py-ilshift-intX-sintY-fallback self1286 other1287)
  (py-int-from-scheme
   (py<< (py-int-to-scheme self1286) (py-sint-to-scheme other1287))))

(define (py-ilshift-intX-bintY-fallback self1289 other1290)
  (py-int-from-scheme
   (py<< (py-int-to-scheme self1289) (py-bint-to-scheme other1290))))

(define (py-ilshift-floatX-intY-fallback self1292 other1293)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'int'"))))

(define (py-ilshift-floatX-floatY-fallback self1295 other1296)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'float'"))))

(define-macro (py-ilshift-floatX-floatY-inline self1295 other1296)
  `(let ((self1295 ,self1295) (other1296 ,other1296))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for <<: 'float' and 'float'")))))

(define (py-ilshift-floatX-boolY-fallback self1298 other1299)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'bool'"))))

(define (py-ilshift-floatX-sintY-fallback self1301 other1302)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'int'"))))

(define (py-ilshift-floatX-bintY-fallback self1304 other1305)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'int'"))))

(define (py-ilshift-boolX-intY-fallback self1307 other1308)
  (py-int-from-scheme
   (py<< (py-bool-to-scheme self1307) (py-int-to-scheme other1308))))

(define (py-ilshift-boolX-floatY-fallback self1310 other1311)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'bool' and 'float'"))))

(define (py-ilshift-boolX-boolY-fallback self1313 other1314)
  (py-int-from-scheme
   (py<< (py-bool-to-scheme self1313) (py-bool-to-scheme other1314))))

(define (py-ilshift-boolX-sintY-fallback self1316 other1317)
  (py-int-from-scheme
   (py<< (py-bool-to-scheme self1316) (py-sint-to-scheme other1317))))

(define (py-ilshift-boolX-bintY-fallback self1319 other1320)
  (py-int-from-scheme
   (py<< (py-bool-to-scheme self1319) (py-bint-to-scheme other1320))))

(define (py-ilshift-sintX-intY-fallback self1322 other1323)
  (py-int-from-scheme
   (py<< (py-sint-to-scheme self1322) (py-int-to-scheme other1323))))

(define (py-ilshift-sintX-floatY-fallback self1325 other1326)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'int' and 'float'"))))

(define (py-ilshift-sintX-boolY-fallback self1328 other1329)
  (py-int-from-scheme
   (py<< (py-sint-to-scheme self1328) (py-bool-to-scheme other1329))))

(define (py-ilshift-sintX-sintY-fallback self1331 other1332)
  (py-int-from-scheme
   (py<< (py-sint-to-scheme self1331) (py-sint-to-scheme other1332))))

(define-macro (py-ilshift-sintX-sintY-inline self1331 other1332)
  `(let ((self1331 ,self1331) (other1332 ,other1332))
     (py-int-from-scheme
      (py<< (py-sint-to-scheme self1331) (py-sint-to-scheme other1332)))))

(define (py-ilshift-sintX-bintY-fallback self1334 other1335)
  (py-int-from-scheme
   (py<< (py-sint-to-scheme self1334) (py-bint-to-scheme other1335))))

(define (py-ilshift-bintX-intY-fallback self1337 other1338)
  (py-int-from-scheme
   (py<< (py-bint-to-scheme self1337) (py-int-to-scheme other1338))))

(define (py-ilshift-bintX-floatY-fallback self1340 other1341)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'int' and 'float'"))))

(define (py-ilshift-bintX-boolY-fallback self1343 other1344)
  (py-int-from-scheme
   (py<< (py-bint-to-scheme self1343) (py-bool-to-scheme other1344))))

(define (py-ilshift-bintX-sintY-fallback self1346 other1347)
  (py-int-from-scheme
   (py<< (py-bint-to-scheme self1346) (py-sint-to-scheme other1347))))

(define (py-ilshift-bintX-bintY-fallback self1349 other1350)
  (py-int-from-scheme
   (py<< (py-bint-to-scheme self1349) (py-bint-to-scheme other1350))))

(define (py-imatmul-intX-intY-fallback self1352 other1353)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-imatmul-intX-floatY-fallback self1355 other1356)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'float'"))))

(define (py-imatmul-intX-boolY-fallback self1358 other1359)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'bool'"))))

(define (py-imatmul-intX-sintY-fallback self1361 other1362)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-imatmul-intX-bintY-fallback self1364 other1365)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-imatmul-floatX-intY-fallback self1367 other1368)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'int'"))))

(define (py-imatmul-floatX-floatY-fallback self1370 other1371)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'float'"))))

(define-macro (py-imatmul-floatX-floatY-inline self1370 other1371)
  `(let ((self1370 ,self1370) (other1371 ,other1371))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @: 'float' and 'float'")))))

(define (py-imatmul-floatX-boolY-fallback self1373 other1374)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'bool'"))))

(define (py-imatmul-floatX-sintY-fallback self1376 other1377)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'int'"))))

(define (py-imatmul-floatX-bintY-fallback self1379 other1380)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'int'"))))

(define (py-imatmul-boolX-intY-fallback self1382 other1383)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'int'"))))

(define (py-imatmul-boolX-floatY-fallback self1385 other1386)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'float'"))))

(define (py-imatmul-boolX-boolY-fallback self1388 other1389)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'bool'"))))

(define (py-imatmul-boolX-sintY-fallback self1391 other1392)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'int'"))))

(define (py-imatmul-boolX-bintY-fallback self1394 other1395)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'int'"))))

(define (py-imatmul-sintX-intY-fallback self1397 other1398)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-imatmul-sintX-floatY-fallback self1400 other1401)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'float'"))))

(define (py-imatmul-sintX-boolY-fallback self1403 other1404)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'bool'"))))

(define (py-imatmul-sintX-sintY-fallback self1406 other1407)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define-macro (py-imatmul-sintX-sintY-inline self1406 other1407)
  `(let ((self1406 ,self1406) (other1407 ,other1407))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @: 'int' and 'int'")))))

(define (py-imatmul-sintX-bintY-fallback self1409 other1410)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-imatmul-bintX-intY-fallback self1412 other1413)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-imatmul-bintX-floatY-fallback self1415 other1416)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'float'"))))

(define (py-imatmul-bintX-boolY-fallback self1418 other1419)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'bool'"))))

(define (py-imatmul-bintX-sintY-fallback self1421 other1422)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-imatmul-bintX-bintY-fallback self1424 other1425)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-imod-intX-intY-fallback self1427 other1428)
  (if (py-test (py-ne other1428 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-int-to-scheme self1427) (py-int-to-scheme other1428)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-intX-floatY-fallback self1430 other1431)
  (if (py-test (py-ne self1430 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-int-to-scheme other1431) (py-float-to-scheme self1430)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-intX-boolY-fallback self1433 other1434)
  (if (py-test (py-ne other1434 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-int-to-scheme self1433) (py-bool-to-scheme other1434)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-intX-sintY-fallback self1436 other1437)
  (if (py-test (py-ne other1437 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-int-to-scheme self1436) (py-sint-to-scheme other1437)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-intX-bintY-fallback self1439 other1440)
  (if (py-test (py-ne other1440 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-int-to-scheme self1439) (py-bint-to-scheme other1440)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-floatX-intY-fallback self1442 other1443)
  (if (py-test (py-ne other1443 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py% (py-float-to-scheme self1442) (py-int-to-scheme other1443)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-floatX-floatY-fallback self1445 other1446)
  (if (py-test (py-ne other1446 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-float-to-scheme self1445) (py-float-to-scheme other1446)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define-macro (py-imod-floatX-floatY-inline self1445 other1446)
  `(let ((self1445 ,self1445) (other1446 ,other1446))
     (if (py-test (py-ne other1446 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py% (py-float-to-scheme self1445) (py-float-to-scheme other1446)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float modulo by zero"))))))

(define (py-imod-floatX-boolY-fallback self1448 other1449)
  (if (py-test (py-ne other1449 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py% (py-float-to-scheme self1448) (py-bool-to-scheme other1449)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-floatX-sintY-fallback self1451 other1452)
  (if (py-test (py-ne other1452 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py% (py-float-to-scheme self1451) (py-sint-to-scheme other1452)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-floatX-bintY-fallback self1454 other1455)
  (if (py-test (py-ne other1455 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py% (py-float-to-scheme self1454) (py-bint-to-scheme other1455)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-boolX-intY-fallback self1457 other1458)
  (if (py-test (py-ne other1458 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bool-to-scheme self1457) (py-int-to-scheme other1458)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-boolX-floatY-fallback self1460 other1461)
  (if (py-test (py-ne self1460 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-bool-to-scheme other1461) (py-float-to-scheme self1460)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-boolX-boolY-fallback self1463 other1464)
  (if (py-test (py-ne other1464 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bool-to-scheme self1463) (py-bool-to-scheme other1464)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-boolX-sintY-fallback self1466 other1467)
  (if (py-test (py-ne other1467 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bool-to-scheme self1466) (py-sint-to-scheme other1467)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-boolX-bintY-fallback self1469 other1470)
  (if (py-test (py-ne other1470 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bool-to-scheme self1469) (py-bint-to-scheme other1470)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-sintX-intY-fallback self1472 other1473)
  (if (py-test (py-ne other1473 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-sint-to-scheme self1472) (py-int-to-scheme other1473)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-sintX-floatY-fallback self1475 other1476)
  (if (py-test (py-ne self1475 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-sint-to-scheme other1476) (py-float-to-scheme self1475)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-sintX-boolY-fallback self1478 other1479)
  (if (py-test (py-ne other1479 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-sint-to-scheme self1478) (py-bool-to-scheme other1479)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-sintX-sintY-fallback self1481 other1482)
  (if (py-test (py-ne other1482 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-sint-to-scheme self1481) (py-sint-to-scheme other1482)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define-macro (py-imod-sintX-sintY-inline self1481 other1482)
  `(let ((self1481 ,self1481) (other1482 ,other1482))
     (if (py-test (py-ne other1482 (py-int-from-scheme 0)))
         (py-int-from-scheme
          (py% (py-sint-to-scheme self1481) (py-sint-to-scheme other1482)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError (&& "modulo by zero"))))))

(define (py-imod-sintX-bintY-fallback self1484 other1485)
  (if (py-test (py-ne other1485 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-sint-to-scheme self1484) (py-bint-to-scheme other1485)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-bintX-intY-fallback self1487 other1488)
  (if (py-test (py-ne other1488 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bint-to-scheme self1487) (py-int-to-scheme other1488)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-bintX-floatY-fallback self1490 other1491)
  (if (py-test (py-ne self1490 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-bint-to-scheme other1491) (py-float-to-scheme self1490)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-bintX-boolY-fallback self1493 other1494)
  (if (py-test (py-ne other1494 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bint-to-scheme self1493) (py-bool-to-scheme other1494)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-bintX-sintY-fallback self1496 other1497)
  (if (py-test (py-ne other1497 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bint-to-scheme self1496) (py-sint-to-scheme other1497)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-bintX-bintY-fallback self1499 other1500)
  (if (py-test (py-ne other1500 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bint-to-scheme self1499) (py-bint-to-scheme other1500)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imul-intX-intY-fallback self1502 other1503)
  (py-int-from-scheme
   (py* (py-int-to-scheme self1502) (py-int-to-scheme other1503))))

(define (py-imul-intX-floatY-fallback self1505 other1506)
  (py-float-from-scheme
   (py* (py-int-to-scheme other1506) (py-float-to-scheme self1505))))

(define (py-imul-intX-boolY-fallback self1508 other1509)
  (py-int-from-scheme
   (py* (py-int-to-scheme self1508) (py-bool-to-scheme other1509))))

(define (py-imul-intX-sintY-fallback self1511 other1512)
  (py-int-from-scheme
   (py* (py-int-to-scheme self1511) (py-sint-to-scheme other1512))))

(define (py-imul-intX-bintY-fallback self1514 other1515)
  (py-int-from-scheme
   (py* (py-int-to-scheme self1514) (py-bint-to-scheme other1515))))

(define (py-imul-floatX-intY-fallback self1517 other1518)
  (py-float-from-scheme
   (py* (py-float-to-scheme self1517) (py-int-to-scheme other1518))))

(define (py-imul-floatX-floatY-fallback self1520 other1521)
  (py-float-from-scheme
   (py* (py-float-to-scheme self1520) (py-float-to-scheme other1521))))

(define-macro (py-imul-floatX-floatY-inline self1520 other1521)
  `(let ((self1520 ,self1520) (other1521 ,other1521))
     (py-float-from-scheme
      (py* (py-float-to-scheme self1520) (py-float-to-scheme other1521)))))

(define (py-imul-floatX-boolY-fallback self1523 other1524)
  (py-float-from-scheme
   (py* (py-float-to-scheme self1523) (py-bool-to-scheme other1524))))

(define (py-imul-floatX-sintY-fallback self1526 other1527)
  (py-float-from-scheme
   (py* (py-float-to-scheme self1526) (py-sint-to-scheme other1527))))

(define (py-imul-floatX-bintY-fallback self1529 other1530)
  (py-float-from-scheme
   (py* (py-float-to-scheme self1529) (py-bint-to-scheme other1530))))

(define (py-imul-boolX-intY-fallback self1532 other1533)
  (py-int-from-scheme
   (py* (py-bool-to-scheme self1532) (py-int-to-scheme other1533))))

(define (py-imul-boolX-floatY-fallback self1535 other1536)
  (py-float-from-scheme
   (py* (py-bool-to-scheme other1536) (py-float-to-scheme self1535))))

(define (py-imul-boolX-boolY-fallback self1538 other1539)
  (py-int-from-scheme
   (py* (py-bool-to-scheme self1538) (py-bool-to-scheme other1539))))

(define (py-imul-boolX-sintY-fallback self1541 other1542)
  (py-int-from-scheme
   (py* (py-bool-to-scheme self1541) (py-sint-to-scheme other1542))))

(define (py-imul-boolX-bintY-fallback self1544 other1545)
  (py-int-from-scheme
   (py* (py-bool-to-scheme self1544) (py-bint-to-scheme other1545))))

(define (py-imul-sintX-intY-fallback self1547 other1548)
  (py-int-from-scheme
   (py* (py-sint-to-scheme self1547) (py-int-to-scheme other1548))))

(define (py-imul-sintX-floatY-fallback self1550 other1551)
  (py-float-from-scheme
   (py* (py-sint-to-scheme other1551) (py-float-to-scheme self1550))))

(define (py-imul-sintX-boolY-fallback self1553 other1554)
  (py-int-from-scheme
   (py* (py-sint-to-scheme self1553) (py-bool-to-scheme other1554))))

(define (py-imul-sintX-sintY-fallback self1556 other1557)
  (py-int-from-scheme
   (py* (py-sint-to-scheme self1556) (py-sint-to-scheme other1557))))

(define-macro (py-imul-sintX-sintY-inline self1556 other1557)
  `(let ((self1556 ,self1556) (other1557 ,other1557))
     (py-int-from-scheme
      (py* (py-sint-to-scheme self1556) (py-sint-to-scheme other1557)))))

(define (py-imul-sintX-bintY-fallback self1559 other1560)
  (py-int-from-scheme
   (py* (py-sint-to-scheme self1559) (py-bint-to-scheme other1560))))

(define (py-imul-bintX-intY-fallback self1562 other1563)
  (py-int-from-scheme
   (py* (py-bint-to-scheme self1562) (py-int-to-scheme other1563))))

(define (py-imul-bintX-floatY-fallback self1565 other1566)
  (py-float-from-scheme
   (py* (py-bint-to-scheme other1566) (py-float-to-scheme self1565))))

(define (py-imul-bintX-boolY-fallback self1568 other1569)
  (py-int-from-scheme
   (py* (py-bint-to-scheme self1568) (py-bool-to-scheme other1569))))

(define (py-imul-bintX-sintY-fallback self1571 other1572)
  (py-int-from-scheme
   (py* (py-bint-to-scheme self1571) (py-sint-to-scheme other1572))))

(define (py-imul-bintX-bintY-fallback self1574 other1575)
  (py-int-from-scheme
   (py* (py-bint-to-scheme self1574) (py-bint-to-scheme other1575))))

(define (py-ipow-intX-intY-fallback self1577 other1578)
  (py-int-from-scheme
   (py** (py-int-to-scheme self1577) (py-int-to-scheme other1578))))

(define (py-ipow-intX-floatY-fallback self1580 other1581)
  (py-float-from-scheme
   (py** (py-int-to-scheme other1581) (py-float-to-scheme self1580))))

(define (py-ipow-intX-boolY-fallback self1583 other1584)
  (py-int-from-scheme
   (py** (py-int-to-scheme self1583) (py-bool-to-scheme other1584))))

(define (py-ipow-intX-sintY-fallback self1586 other1587)
  (py-int-from-scheme
   (py** (py-int-to-scheme self1586) (py-sint-to-scheme other1587))))

(define (py-ipow-intX-bintY-fallback self1589 other1590)
  (py-int-from-scheme
   (py** (py-int-to-scheme self1589) (py-bint-to-scheme other1590))))

(define (py-ipow-floatX-intY-fallback self1592 other1593)
  (py-float-from-scheme
   (py** (py-float-to-scheme self1592) (py-int-to-scheme other1593))))

(define (py-ipow-floatX-floatY-fallback self1595 other1596)
  (py-float-from-scheme
   (py** (py-float-to-scheme self1595) (py-float-to-scheme other1596))))

(define-macro (py-ipow-floatX-floatY-inline self1595 other1596)
  `(let ((self1595 ,self1595) (other1596 ,other1596))
     (py-float-from-scheme
      (py** (py-float-to-scheme self1595) (py-float-to-scheme other1596)))))

(define (py-ipow-floatX-boolY-fallback self1598 other1599)
  (py-float-from-scheme
   (py** (py-float-to-scheme self1598) (py-bool-to-scheme other1599))))

(define (py-ipow-floatX-sintY-fallback self1601 other1602)
  (py-float-from-scheme
   (py** (py-float-to-scheme self1601) (py-sint-to-scheme other1602))))

(define (py-ipow-floatX-bintY-fallback self1604 other1605)
  (py-float-from-scheme
   (py** (py-float-to-scheme self1604) (py-bint-to-scheme other1605))))

(define (py-ipow-boolX-intY-fallback self1607 other1608)
  (py-int-from-scheme
   (py** (py-bool-to-scheme self1607) (py-int-to-scheme other1608))))

(define (py-ipow-boolX-floatY-fallback self1610 other1611)
  (py-float-from-scheme
   (py** (py-bool-to-scheme other1611) (py-float-to-scheme self1610))))

(define (py-ipow-boolX-boolY-fallback self1613 other1614)
  (py-int-from-scheme
   (py** (py-bool-to-scheme self1613) (py-bool-to-scheme other1614))))

(define (py-ipow-boolX-sintY-fallback self1616 other1617)
  (py-int-from-scheme
   (py** (py-bool-to-scheme self1616) (py-sint-to-scheme other1617))))

(define (py-ipow-boolX-bintY-fallback self1619 other1620)
  (py-int-from-scheme
   (py** (py-bool-to-scheme self1619) (py-bint-to-scheme other1620))))

(define (py-ipow-sintX-intY-fallback self1622 other1623)
  (py-int-from-scheme
   (py** (py-sint-to-scheme self1622) (py-int-to-scheme other1623))))

(define (py-ipow-sintX-floatY-fallback self1625 other1626)
  (py-float-from-scheme
   (py** (py-sint-to-scheme other1626) (py-float-to-scheme self1625))))

(define (py-ipow-sintX-boolY-fallback self1628 other1629)
  (py-int-from-scheme
   (py** (py-sint-to-scheme self1628) (py-bool-to-scheme other1629))))

(define (py-ipow-sintX-sintY-fallback self1631 other1632)
  (py-int-from-scheme
   (py** (py-sint-to-scheme self1631) (py-sint-to-scheme other1632))))

(define-macro (py-ipow-sintX-sintY-inline self1631 other1632)
  `(let ((self1631 ,self1631) (other1632 ,other1632))
     (py-int-from-scheme
      (py** (py-sint-to-scheme self1631) (py-sint-to-scheme other1632)))))

(define (py-ipow-sintX-bintY-fallback self1634 other1635)
  (py-int-from-scheme
   (py** (py-sint-to-scheme self1634) (py-bint-to-scheme other1635))))

(define (py-ipow-bintX-intY-fallback self1637 other1638)
  (py-int-from-scheme
   (py** (py-bint-to-scheme self1637) (py-int-to-scheme other1638))))

(define (py-ipow-bintX-floatY-fallback self1640 other1641)
  (py-float-from-scheme
   (py** (py-bint-to-scheme other1641) (py-float-to-scheme self1640))))

(define (py-ipow-bintX-boolY-fallback self1643 other1644)
  (py-int-from-scheme
   (py** (py-bint-to-scheme self1643) (py-bool-to-scheme other1644))))

(define (py-ipow-bintX-sintY-fallback self1646 other1647)
  (py-int-from-scheme
   (py** (py-bint-to-scheme self1646) (py-sint-to-scheme other1647))))

(define (py-ipow-bintX-bintY-fallback self1649 other1650)
  (py-int-from-scheme
   (py** (py-bint-to-scheme self1649) (py-bint-to-scheme other1650))))

(define (py-irshift-intX-intY-fallback self1652 other1653)
  (py-int-from-scheme
   (py>> (py-int-to-scheme self1652) (py-int-to-scheme other1653))))

(define (py-irshift-intX-floatY-fallback self1655 other1656)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'int' and 'float'"))))

(define (py-irshift-intX-boolY-fallback self1658 other1659)
  (py-int-from-scheme
   (py>> (py-bool-to-scheme self1658) (py-int-to-scheme other1659))))

(define (py-irshift-intX-sintY-fallback self1661 other1662)
  (py-int-from-scheme
   (py>> (py-sint-to-scheme self1661) (py-int-to-scheme other1662))))

(define (py-irshift-intX-bintY-fallback self1664 other1665)
  (py-int-from-scheme
   (py>> (py-bint-to-scheme self1664) (py-int-to-scheme other1665))))

(define (py-irshift-floatX-intY-fallback self1667 other1668)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'int'"))))

(define (py-irshift-floatX-floatY-fallback self1670 other1671)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'float'"))))

(define-macro (py-irshift-floatX-floatY-inline self1670 other1671)
  `(let ((self1670 ,self1670) (other1671 ,other1671))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for >>: 'float' and 'float'")))))

(define (py-irshift-floatX-boolY-fallback self1673 other1674)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'bool'"))))

(define (py-irshift-floatX-sintY-fallback self1676 other1677)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'int'"))))

(define (py-irshift-floatX-bintY-fallback self1679 other1680)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'int'"))))

(define (py-irshift-boolX-intY-fallback self1682 other1683)
  (py-int-from-scheme
   (py>> (py-int-to-scheme self1682) (py-bool-to-scheme other1683))))

(define (py-irshift-boolX-floatY-fallback self1685 other1686)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'bool' and 'float'"))))

(define (py-irshift-boolX-boolY-fallback self1688 other1689)
  (py-int-from-scheme
   (py>> (py-bool-to-scheme self1688) (py-bool-to-scheme other1689))))

(define (py-irshift-boolX-sintY-fallback self1691 other1692)
  (py-int-from-scheme
   (py>> (py-sint-to-scheme self1691) (py-bool-to-scheme other1692))))

(define (py-irshift-boolX-bintY-fallback self1694 other1695)
  (py-int-from-scheme
   (py>> (py-bint-to-scheme self1694) (py-bool-to-scheme other1695))))

(define (py-irshift-sintX-intY-fallback self1697 other1698)
  (py-int-from-scheme
   (py>> (py-int-to-scheme self1697) (py-sint-to-scheme other1698))))

(define (py-irshift-sintX-floatY-fallback self1700 other1701)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'int' and 'float'"))))

(define (py-irshift-sintX-boolY-fallback self1703 other1704)
  (py-int-from-scheme
   (py>> (py-bool-to-scheme self1703) (py-sint-to-scheme other1704))))

(define (py-irshift-sintX-sintY-fallback self1706 other1707)
  (py-int-from-scheme
   (py>> (py-sint-to-scheme self1706) (py-sint-to-scheme other1707))))

(define-macro (py-irshift-sintX-sintY-inline self1706 other1707)
  `(let ((self1706 ,self1706) (other1707 ,other1707))
     (py-int-from-scheme
      (py>> (py-sint-to-scheme self1706) (py-sint-to-scheme other1707)))))

(define (py-irshift-sintX-bintY-fallback self1709 other1710)
  (py-int-from-scheme
   (py>> (py-bint-to-scheme self1709) (py-sint-to-scheme other1710))))

(define (py-irshift-bintX-intY-fallback self1712 other1713)
  (py-int-from-scheme
   (py>> (py-int-to-scheme self1712) (py-bint-to-scheme other1713))))

(define (py-irshift-bintX-floatY-fallback self1715 other1716)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'int' and 'float'"))))

(define (py-irshift-bintX-boolY-fallback self1718 other1719)
  (py-int-from-scheme
   (py>> (py-bool-to-scheme self1718) (py-bint-to-scheme other1719))))

(define (py-irshift-bintX-sintY-fallback self1721 other1722)
  (py-int-from-scheme
   (py>> (py-sint-to-scheme self1721) (py-bint-to-scheme other1722))))

(define (py-irshift-bintX-bintY-fallback self1724 other1725)
  (py-int-from-scheme
   (py>> (py-bint-to-scheme self1724) (py-bint-to-scheme other1725))))

(define (py-isub-intX-intY-fallback self1727 other1728)
  (py-int-from-scheme
   (py- (py-int-to-scheme self1727) (py-int-to-scheme other1728))))

(define (py-isub-intX-floatY-fallback self1730 other1731)
  (py-float-from-scheme
   (py- (py-int-to-scheme other1731) (py-float-to-scheme self1730))))

(define (py-isub-intX-boolY-fallback self1733 other1734)
  (py-int-from-scheme
   (py- (py-int-to-scheme self1733) (py-bool-to-scheme other1734))))

(define (py-isub-intX-sintY-fallback self1736 other1737)
  (py-int-from-scheme
   (py- (py-int-to-scheme self1736) (py-sint-to-scheme other1737))))

(define (py-isub-intX-bintY-fallback self1739 other1740)
  (py-int-from-scheme
   (py- (py-int-to-scheme self1739) (py-bint-to-scheme other1740))))

(define (py-isub-floatX-intY-fallback self1742 other1743)
  (py-float-from-scheme
   (py- (py-float-to-scheme self1742) (py-int-to-scheme other1743))))

(define (py-isub-floatX-floatY-fallback self1745 other1746)
  (py-float-from-scheme
   (py- (py-float-to-scheme self1745) (py-float-to-scheme other1746))))

(define-macro (py-isub-floatX-floatY-inline self1745 other1746)
  `(let ((self1745 ,self1745) (other1746 ,other1746))
     (py-float-from-scheme
      (py- (py-float-to-scheme self1745) (py-float-to-scheme other1746)))))

(define (py-isub-floatX-boolY-fallback self1748 other1749)
  (py-float-from-scheme
   (py- (py-float-to-scheme self1748) (py-bool-to-scheme other1749))))

(define (py-isub-floatX-sintY-fallback self1751 other1752)
  (py-float-from-scheme
   (py- (py-float-to-scheme self1751) (py-sint-to-scheme other1752))))

(define (py-isub-floatX-bintY-fallback self1754 other1755)
  (py-float-from-scheme
   (py- (py-float-to-scheme self1754) (py-bint-to-scheme other1755))))

(define (py-isub-boolX-intY-fallback self1757 other1758)
  (py-int-from-scheme
   (py- (py-bool-to-scheme self1757) (py-int-to-scheme other1758))))

(define (py-isub-boolX-floatY-fallback self1760 other1761)
  (py-float-from-scheme
   (py- (py-bool-to-scheme other1761) (py-float-to-scheme self1760))))

(define (py-isub-boolX-boolY-fallback self1763 other1764)
  (py-int-from-scheme
   (py- (py-bool-to-scheme self1763) (py-bool-to-scheme other1764))))

(define (py-isub-boolX-sintY-fallback self1766 other1767)
  (py-int-from-scheme
   (py- (py-bool-to-scheme self1766) (py-sint-to-scheme other1767))))

(define (py-isub-boolX-bintY-fallback self1769 other1770)
  (py-int-from-scheme
   (py- (py-bool-to-scheme self1769) (py-bint-to-scheme other1770))))

(define (py-isub-sintX-intY-fallback self1772 other1773)
  (py-int-from-scheme
   (py- (py-sint-to-scheme self1772) (py-int-to-scheme other1773))))

(define (py-isub-sintX-floatY-fallback self1775 other1776)
  (py-float-from-scheme
   (py- (py-sint-to-scheme other1776) (py-float-to-scheme self1775))))

(define (py-isub-sintX-boolY-fallback self1778 other1779)
  (py-int-from-scheme
   (py- (py-sint-to-scheme self1778) (py-bool-to-scheme other1779))))

(define (py-isub-sintX-sintY-fallback self1781 other1782)
  (py-int-from-scheme
   (py- (py-sint-to-scheme self1781) (py-sint-to-scheme other1782))))

(define-macro (py-isub-sintX-sintY-inline self1781 other1782)
  `(let ((self1781 ,self1781) (other1782 ,other1782))
     (py-int-from-scheme
      (py- (py-sint-to-scheme self1781) (py-sint-to-scheme other1782)))))

(define (py-isub-sintX-bintY-fallback self1784 other1785)
  (py-int-from-scheme
   (py- (py-sint-to-scheme self1784) (py-bint-to-scheme other1785))))

(define (py-isub-bintX-intY-fallback self1787 other1788)
  (py-int-from-scheme
   (py- (py-bint-to-scheme self1787) (py-int-to-scheme other1788))))

(define (py-isub-bintX-floatY-fallback self1790 other1791)
  (py-float-from-scheme
   (py- (py-bint-to-scheme other1791) (py-float-to-scheme self1790))))

(define (py-isub-bintX-boolY-fallback self1793 other1794)
  (py-int-from-scheme
   (py- (py-bint-to-scheme self1793) (py-bool-to-scheme other1794))))

(define (py-isub-bintX-sintY-fallback self1796 other1797)
  (py-int-from-scheme
   (py- (py-bint-to-scheme self1796) (py-sint-to-scheme other1797))))

(define (py-isub-bintX-bintY-fallback self1799 other1800)
  (py-int-from-scheme
   (py- (py-bint-to-scheme self1799) (py-bint-to-scheme other1800))))

(define (py-itruediv-intX-intY-fallback self1802 other1803)
  (if (py-test (py-ne other1803 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-int-to-scheme self1802) (py-int-to-scheme other1803)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-intX-floatY-fallback self1805 other1806)
  (if (py-test (py-ne self1805 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-int-to-scheme other1806) (py-float-to-scheme self1805)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-intX-boolY-fallback self1808 other1809)
  (if (py-test (py-ne other1809 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-int-to-scheme self1808) (py-bool-to-scheme other1809)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-intX-sintY-fallback self1811 other1812)
  (if (py-test (py-ne other1812 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-int-to-scheme self1811) (py-sint-to-scheme other1812)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-intX-bintY-fallback self1814 other1815)
  (if (py-test (py-ne other1815 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-int-to-scheme self1814) (py-bint-to-scheme other1815)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-floatX-intY-fallback self1817 other1818)
  (if (py-test (py-ne other1818 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme self1817) (py-int-to-scheme other1818)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-floatX-floatY-fallback self1820 other1821)
  (if (py-test (py-ne other1821 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme self1820) (py-float-to-scheme other1821)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define-macro (py-itruediv-floatX-floatY-inline self1820 other1821)
  `(let ((self1820 ,self1820) (other1821 ,other1821))
     (if (py-test (py-ne other1821 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py/ (py-float-to-scheme self1820) (py-float-to-scheme other1821)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define (py-itruediv-floatX-boolY-fallback self1823 other1824)
  (if (py-test (py-ne other1824 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme self1823) (py-bool-to-scheme other1824)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-floatX-sintY-fallback self1826 other1827)
  (if (py-test (py-ne other1827 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme self1826) (py-sint-to-scheme other1827)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-floatX-bintY-fallback self1829 other1830)
  (if (py-test (py-ne other1830 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme self1829) (py-bint-to-scheme other1830)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-boolX-intY-fallback self1832 other1833)
  (if (py-test (py-ne other1833 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme self1832) (py-int-to-scheme other1833)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-boolX-floatY-fallback self1835 other1836)
  (if (py-test (py-ne self1835 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme other1836) (py-float-to-scheme self1835)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-boolX-boolY-fallback self1838 other1839)
  (if (py-test (py-ne other1839 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme self1838) (py-bool-to-scheme other1839)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-boolX-sintY-fallback self1841 other1842)
  (if (py-test (py-ne other1842 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme self1841) (py-sint-to-scheme other1842)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-boolX-bintY-fallback self1844 other1845)
  (if (py-test (py-ne other1845 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme self1844) (py-bint-to-scheme other1845)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-sintX-intY-fallback self1847 other1848)
  (if (py-test (py-ne other1848 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme self1847) (py-int-to-scheme other1848)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-sintX-floatY-fallback self1850 other1851)
  (if (py-test (py-ne self1850 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme other1851) (py-float-to-scheme self1850)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-sintX-boolY-fallback self1853 other1854)
  (if (py-test (py-ne other1854 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme self1853) (py-bool-to-scheme other1854)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-sintX-sintY-fallback self1856 other1857)
  (if (py-test (py-ne other1857 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme self1856) (py-sint-to-scheme other1857)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define-macro (py-itruediv-sintX-sintY-inline self1856 other1857)
  `(let ((self1856 ,self1856) (other1857 ,other1857))
     (if (py-test (py-ne other1857 (py-int-from-scheme 0)))
         (py-float-from-scheme
          (py/ (py-sint-to-scheme self1856) (py-sint-to-scheme other1857)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError (&& "division by zero"))))))

(define (py-itruediv-sintX-bintY-fallback self1859 other1860)
  (if (py-test (py-ne other1860 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme self1859) (py-bint-to-scheme other1860)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-bintX-intY-fallback self1862 other1863)
  (if (py-test (py-ne other1863 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme self1862) (py-int-to-scheme other1863)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-bintX-floatY-fallback self1865 other1866)
  (if (py-test (py-ne self1865 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme other1866) (py-float-to-scheme self1865)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-bintX-boolY-fallback self1868 other1869)
  (if (py-test (py-ne other1869 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme self1868) (py-bool-to-scheme other1869)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-bintX-sintY-fallback self1871 other1872)
  (if (py-test (py-ne other1872 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme self1871) (py-sint-to-scheme other1872)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-bintX-bintY-fallback self1874 other1875)
  (if (py-test (py-ne other1875 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme self1874) (py-bint-to-scheme other1875)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-ixor-intX-intY-fallback self1877 other1878)
  (py-int-from-scheme
   (py^ (py-int-to-scheme self1877) (py-int-to-scheme other1878))))

(define (py-ixor-intX-floatY-fallback self1880 other1881)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'int' and 'float'"))))

(define (py-ixor-intX-boolY-fallback self1883 other1884)
  (py-int-from-scheme
   (py^ (py-int-to-scheme self1883) (py-bool-to-scheme other1884))))

(define (py-ixor-intX-sintY-fallback self1886 other1887)
  (py-int-from-scheme
   (py^ (py-int-to-scheme self1886) (py-sint-to-scheme other1887))))

(define (py-ixor-intX-bintY-fallback self1889 other1890)
  (py-int-from-scheme
   (py^ (py-int-to-scheme self1889) (py-bint-to-scheme other1890))))

(define (py-ixor-floatX-intY-fallback self1892 other1893)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'int'"))))

(define (py-ixor-floatX-floatY-fallback self1895 other1896)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'float'"))))

(define-macro (py-ixor-floatX-floatY-inline self1895 other1896)
  `(let ((self1895 ,self1895) (other1896 ,other1896))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for ^: 'float' and 'float'")))))

(define (py-ixor-floatX-boolY-fallback self1898 other1899)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'bool'"))))

(define (py-ixor-floatX-sintY-fallback self1901 other1902)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'int'"))))

(define (py-ixor-floatX-bintY-fallback self1904 other1905)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'int'"))))

(define (py-ixor-boolX-intY-fallback self1907 other1908)
  (py-int-from-scheme
   (py^ (py-bool-to-scheme self1907) (py-int-to-scheme other1908))))

(define (py-ixor-boolX-floatY-fallback self1910 other1911)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'bool' and 'float'"))))

(define (py-ixor-boolX-boolY-fallback self1913 other1914)
  (py-isnot self1913 other1914))

(define (py-ixor-boolX-sintY-fallback self1916 other1917)
  (py-int-from-scheme
   (py^ (py-bool-to-scheme self1916) (py-sint-to-scheme other1917))))

(define (py-ixor-boolX-bintY-fallback self1919 other1920)
  (py-int-from-scheme
   (py^ (py-bool-to-scheme self1919) (py-bint-to-scheme other1920))))

(define (py-ixor-sintX-intY-fallback self1922 other1923)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme self1922) (py-int-to-scheme other1923))))

(define (py-ixor-sintX-floatY-fallback self1925 other1926)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'int' and 'float'"))))

(define (py-ixor-sintX-boolY-fallback self1928 other1929)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme self1928) (py-bool-to-scheme other1929))))

(define (py-ixor-sintX-sintY-fallback self1931 other1932)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme self1931) (py-sint-to-scheme other1932))))

(define-macro (py-ixor-sintX-sintY-inline self1931 other1932)
  `(let ((self1931 ,self1931) (other1932 ,other1932))
     (py-int-from-scheme
      (py^ (py-sint-to-scheme self1931) (py-sint-to-scheme other1932)))))

(define (py-ixor-sintX-bintY-fallback self1934 other1935)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme self1934) (py-bint-to-scheme other1935))))

(define (py-ixor-bintX-intY-fallback self1937 other1938)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme self1937) (py-int-to-scheme other1938))))

(define (py-ixor-bintX-floatY-fallback self1940 other1941)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'int' and 'float'"))))

(define (py-ixor-bintX-boolY-fallback self1943 other1944)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme self1943) (py-bool-to-scheme other1944))))

(define (py-ixor-bintX-sintY-fallback self1946 other1947)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme self1946) (py-sint-to-scheme other1947))))

(define (py-ixor-bintX-bintY-fallback self1949 other1950)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme self1949) (py-bint-to-scheme other1950))))

