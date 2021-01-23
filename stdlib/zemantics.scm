(define-macro (py-add-fallback x2 y3)
  `(let ((x2 ,x2) (y3 ,y3)) (py-add-fallback:normal x2 y3)))

(define-macro (py-bitand-fallback x8 y9)
  `(let ((x8 ,x8) (y9 ,y9)) (py-bitand-fallback:normal x8 y9)))

(define-macro (py-bitor-fallback x14 y15)
  `(let ((x14 ,x14) (y15 ,y15)) (py-bitor-fallback:normal x14 y15)))

(define-macro (py-floordiv-fallback x20 y21)
  `(let ((x20 ,x20) (y21 ,y21)) (py-floordiv-fallback:normal x20 y21)))

(define-macro (py-lshift-fallback x26 y27)
  `(let ((x26 ,x26) (y27 ,y27)) (py-lshift-fallback:normal x26 y27)))

(define-macro (py-matmul-fallback x32 y33)
  `(let ((x32 ,x32) (y33 ,y33)) (py-matmul-fallback:normal x32 y33)))

(define-macro (py-mod-fallback x38 y39)
  `(let ((x38 ,x38) (y39 ,y39)) (py-mod-fallback:normal x38 y39)))

(define-macro (py-mul-fallback x44 y45)
  `(let ((x44 ,x44) (y45 ,y45)) (py-mul-fallback:normal x44 y45)))

(define-macro (py-pow-fallback x50 y51)
  `(let ((x50 ,x50) (y51 ,y51)) (py-pow-fallback:normal x50 y51)))

(define-macro (py-rshift-fallback x56 y57)
  `(let ((x56 ,x56) (y57 ,y57)) (py-rshift-fallback:normal x56 y57)))

(define-macro (py-sub-fallback x62 y63)
  `(let ((x62 ,x62) (y63 ,y63)) (py-sub-fallback:normal x62 y63)))

(define-macro (py-truediv-fallback x68 y69)
  `(let ((x68 ,x68) (y69 ,y69)) (py-truediv-fallback:normal x68 y69)))

(define-macro (py-xor-fallback x74 y75)
  `(let ((x74 ,x74) (y75 ,y75)) (py-xor-fallback:normal x74 y75)))

(define-macro (py-iadd-fallback x80 y81)
  `(let ((x80 ,x80) (y81 ,y81)) (py-iadd-fallback:inplace x80 y81)))

(define-macro (py-ibitand-fallback x87 y88)
  `(let ((x87 ,x87) (y88 ,y88)) (py-ibitand-fallback:inplace x87 y88)))

(define-macro (py-ibitor-fallback x94 y95)
  `(let ((x94 ,x94) (y95 ,y95)) (py-ibitor-fallback:inplace x94 y95)))

(define-macro (py-ifloordiv-fallback x101 y102)
  `(let ((x101 ,x101) (y102 ,y102)) (py-ifloordiv-fallback:inplace x101 y102)))

(define-macro (py-ilshift-fallback x108 y109)
  `(let ((x108 ,x108) (y109 ,y109)) (py-ilshift-fallback:inplace x108 y109)))

(define-macro (py-imatmul-fallback x115 y116)
  `(let ((x115 ,x115) (y116 ,y116)) (py-imatmul-fallback:inplace x115 y116)))

(define-macro (py-imod-fallback x122 y123)
  `(let ((x122 ,x122) (y123 ,y123)) (py-imod-fallback:inplace x122 y123)))

(define-macro (py-imul-fallback x129 y130)
  `(let ((x129 ,x129) (y130 ,y130)) (py-imul-fallback:inplace x129 y130)))

(define-macro (py-ipow-fallback x136 y137)
  `(let ((x136 ,x136) (y137 ,y137)) (py-ipow-fallback:inplace x136 y137)))

(define-macro (py-irshift-fallback x143 y144)
  `(let ((x143 ,x143) (y144 ,y144)) (py-irshift-fallback:inplace x143 y144)))

(define-macro (py-isub-fallback x150 y151)
  `(let ((x150 ,x150) (y151 ,y151)) (py-isub-fallback:inplace x150 y151)))

(define-macro (py-itruediv-fallback x157 y158)
  `(let ((x157 ,x157) (y158 ,y158)) (py-itruediv-fallback:inplace x157 y158)))

(define-macro (py-ixor-fallback x164 y165)
  `(let ((x164 ,x164) (y165 ,y165)) (py-ixor-fallback:inplace x164 y165)))

(define-macro (py-ge-fallback x171 y172)
  `(let ((x171 ,x171) (y172 ,y172)) (py-ge-fallback:normal x171 y172)))

(define-macro (py-gt-fallback x177 y178)
  `(let ((x177 ,x177) (y178 ,y178)) (py-gt-fallback:normal x177 y178)))

(define-macro (py-le-fallback x183 y184)
  `(let ((x183 ,x183) (y184 ,y184)) (py-le-fallback:normal x183 y184)))

(define-macro (py-lt-fallback x189 y190)
  `(let ((x189 ,x189) (y190 ,y190)) (py-lt-fallback:normal x189 y190)))

(define-macro (py-eq-fallback x195 y196)
  `(let ((x195 ,x195) (y196 ,y196)) (py-eq-fallback:normal x195 y196)))

(define-macro (py-ne-fallback x201 y202)
  `(let ((x201 ,x201) (y202 ,y202)) (py-ne-fallback:normal x201 y202)))

(define (py-add-fallback:normal x225 y226)
  (letrec* ((magic_method445 (getattribute-from-obj-mro x225 (&& "__add__"))))
    (if (py-test (py-is magic_method445 py-absent))
        (py-add-fallback:reflected x225 y226)
        (letrec* ((result446 (py-call magic_method445 x225 y226)))
          (if (py-test (py-is result446 py-NotImplemented))
              (py-add-fallback:reflected x225 y226)
              result446)))))

(define (py-add-fallback:reflected x227 y228)
  (letrec* ((magic_method449 (getattribute-from-obj-mro y228 (&& "__radd__"))))
    (if (py-test (py-is magic_method449 py-absent))
        (py-add-fallback:err x227 y228)
        (letrec* ((result450 (py-call magic_method449 y228 x227)))
          (if (py-test (py-is result450 py-NotImplemented))
              (py-add-fallback:err x227 y228)
              result450)))))

(define (py-add-fallback:err x229 y230)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for +: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x229)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y230)
                             (& "__name__")))
                    (&& "'")))))

(define (py-bitand-fallback:normal x231 y232)
  (letrec* ((magic_method453 (getattribute-from-obj-mro x231 (&& "__and__"))))
    (if (py-test (py-is magic_method453 py-absent))
        (py-bitand-fallback:reflected x231 y232)
        (letrec* ((result454 (py-call magic_method453 x231 y232)))
          (if (py-test (py-is result454 py-NotImplemented))
              (py-bitand-fallback:reflected x231 y232)
              result454)))))

(define (py-bitand-fallback:reflected x233 y234)
  (letrec* ((magic_method457 (getattribute-from-obj-mro y234 (&& "__rand__"))))
    (if (py-test (py-is magic_method457 py-absent))
        (py-bitand-fallback:err x233 y234)
        (letrec* ((result458 (py-call magic_method457 y234 x233)))
          (if (py-test (py-is result458 py-NotImplemented))
              (py-bitand-fallback:err x233 y234)
              result458)))))

(define (py-bitand-fallback:err x235 y236)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for &: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x235)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y236)
                             (& "__name__")))
                    (&& "'")))))

(define (py-bitor-fallback:normal x237 y238)
  (letrec* ((magic_method461 (getattribute-from-obj-mro x237 (&& "__or__"))))
    (if (py-test (py-is magic_method461 py-absent))
        (py-bitor-fallback:reflected x237 y238)
        (letrec* ((result462 (py-call magic_method461 x237 y238)))
          (if (py-test (py-is result462 py-NotImplemented))
              (py-bitor-fallback:reflected x237 y238)
              result462)))))

(define (py-bitor-fallback:reflected x239 y240)
  (letrec* ((magic_method465 (getattribute-from-obj-mro y240 (&& "__ror__"))))
    (if (py-test (py-is magic_method465 py-absent))
        (py-bitor-fallback:err x239 y240)
        (letrec* ((result466 (py-call magic_method465 y240 x239)))
          (if (py-test (py-is result466 py-NotImplemented))
              (py-bitor-fallback:err x239 y240)
              result466)))))

(define (py-bitor-fallback:err x241 y242)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for |: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x241)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y242)
                             (& "__name__")))
                    (&& "'")))))

(define (py-floordiv-fallback:normal x243 y244)
  (letrec* ((magic_method469
             (getattribute-from-obj-mro x243 (&& "__floordiv__"))))
    (if (py-test (py-is magic_method469 py-absent))
        (py-floordiv-fallback:reflected x243 y244)
        (letrec* ((result470 (py-call magic_method469 x243 y244)))
          (if (py-test (py-is result470 py-NotImplemented))
              (py-floordiv-fallback:reflected x243 y244)
              result470)))))

(define (py-floordiv-fallback:reflected x245 y246)
  (letrec* ((magic_method473
             (getattribute-from-obj-mro y246 (&& "__rfloordiv__"))))
    (if (py-test (py-is magic_method473 py-absent))
        (py-floordiv-fallback:err x245 y246)
        (letrec* ((result474 (py-call magic_method473 y246 x245)))
          (if (py-test (py-is result474 py-NotImplemented))
              (py-floordiv-fallback:err x245 y246)
              result474)))))

(define (py-floordiv-fallback:err x247 y248)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for //: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x247)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y248)
                             (& "__name__")))
                    (&& "'")))))

(define (py-lshift-fallback:normal x249 y250)
  (letrec* ((magic_method477
             (getattribute-from-obj-mro x249 (&& "__lshift__"))))
    (if (py-test (py-is magic_method477 py-absent))
        (py-lshift-fallback:reflected x249 y250)
        (letrec* ((result478 (py-call magic_method477 x249 y250)))
          (if (py-test (py-is result478 py-NotImplemented))
              (py-lshift-fallback:reflected x249 y250)
              result478)))))

(define (py-lshift-fallback:reflected x251 y252)
  (letrec* ((magic_method481
             (getattribute-from-obj-mro y252 (&& "__rlshift__"))))
    (if (py-test (py-is magic_method481 py-absent))
        (py-lshift-fallback:err x251 y252)
        (letrec* ((result482 (py-call magic_method481 y252 x251)))
          (if (py-test (py-is result482 py-NotImplemented))
              (py-lshift-fallback:err x251 y252)
              result482)))))

(define (py-lshift-fallback:err x253 y254)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for <<: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x253)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y254)
                             (& "__name__")))
                    (&& "'")))))

(define (py-matmul-fallback:normal x255 y256)
  (letrec* ((magic_method485
             (getattribute-from-obj-mro x255 (&& "__matmul__"))))
    (if (py-test (py-is magic_method485 py-absent))
        (py-matmul-fallback:reflected x255 y256)
        (letrec* ((result486 (py-call magic_method485 x255 y256)))
          (if (py-test (py-is result486 py-NotImplemented))
              (py-matmul-fallback:reflected x255 y256)
              result486)))))

(define (py-matmul-fallback:reflected x257 y258)
  (letrec* ((magic_method489
             (getattribute-from-obj-mro y258 (&& "__rmatmul__"))))
    (if (py-test (py-is magic_method489 py-absent))
        (py-matmul-fallback:err x257 y258)
        (letrec* ((result490 (py-call magic_method489 y258 x257)))
          (if (py-test (py-is result490 py-NotImplemented))
              (py-matmul-fallback:err x257 y258)
              result490)))))

(define (py-matmul-fallback:err x259 y260)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for @: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x259)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y260)
                             (& "__name__")))
                    (&& "'")))))

(define (py-mod-fallback:normal x261 y262)
  (letrec* ((magic_method493 (getattribute-from-obj-mro x261 (&& "__mod__"))))
    (if (py-test (py-is magic_method493 py-absent))
        (py-mod-fallback:reflected x261 y262)
        (letrec* ((result494 (py-call magic_method493 x261 y262)))
          (if (py-test (py-is result494 py-NotImplemented))
              (py-mod-fallback:reflected x261 y262)
              result494)))))

(define (py-mod-fallback:reflected x263 y264)
  (letrec* ((magic_method497 (getattribute-from-obj-mro y264 (&& "__rmod__"))))
    (if (py-test (py-is magic_method497 py-absent))
        (py-mod-fallback:err x263 y264)
        (letrec* ((result498 (py-call magic_method497 y264 x263)))
          (if (py-test (py-is result498 py-NotImplemented))
              (py-mod-fallback:err x263 y264)
              result498)))))

(define (py-mod-fallback:err x265 y266)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for %: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x265)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y266)
                             (& "__name__")))
                    (&& "'")))))

(define (py-mul-fallback:normal x267 y268)
  (letrec* ((magic_method501 (getattribute-from-obj-mro x267 (&& "__mul__"))))
    (if (py-test (py-is magic_method501 py-absent))
        (py-mul-fallback:reflected x267 y268)
        (letrec* ((result502 (py-call magic_method501 x267 y268)))
          (if (py-test (py-is result502 py-NotImplemented))
              (py-mul-fallback:reflected x267 y268)
              result502)))))

(define (py-mul-fallback:reflected x269 y270)
  (letrec* ((magic_method505 (getattribute-from-obj-mro y270 (&& "__rmul__"))))
    (if (py-test (py-is magic_method505 py-absent))
        (py-mul-fallback:err x269 y270)
        (letrec* ((result506 (py-call magic_method505 y270 x269)))
          (if (py-test (py-is result506 py-NotImplemented))
              (py-mul-fallback:err x269 y270)
              result506)))))

(define (py-mul-fallback:err x271 y272)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for *: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x271)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y272)
                             (& "__name__")))
                    (&& "'")))))

(define (py-pow-fallback:normal x273 y274)
  (letrec* ((magic_method509 (getattribute-from-obj-mro x273 (&& "__pow__"))))
    (if (py-test (py-is magic_method509 py-absent))
        (py-pow-fallback:reflected x273 y274)
        (letrec* ((result510 (py-call magic_method509 x273 y274)))
          (if (py-test (py-is result510 py-NotImplemented))
              (py-pow-fallback:reflected x273 y274)
              result510)))))

(define (py-pow-fallback:reflected x275 y276)
  (letrec* ((magic_method513 (getattribute-from-obj-mro y276 (&& "__rpow__"))))
    (if (py-test (py-is magic_method513 py-absent))
        (py-pow-fallback:err x275 y276)
        (letrec* ((result514 (py-call magic_method513 y276 x275)))
          (if (py-test (py-is result514 py-NotImplemented))
              (py-pow-fallback:err x275 y276)
              result514)))))

(define (py-pow-fallback:err x277 y278)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for **: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x277)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y278)
                             (& "__name__")))
                    (&& "'")))))

(define (py-rshift-fallback:normal x279 y280)
  (letrec* ((magic_method517
             (getattribute-from-obj-mro x279 (&& "__rshift__"))))
    (if (py-test (py-is magic_method517 py-absent))
        (py-rshift-fallback:reflected x279 y280)
        (letrec* ((result518 (py-call magic_method517 x279 y280)))
          (if (py-test (py-is result518 py-NotImplemented))
              (py-rshift-fallback:reflected x279 y280)
              result518)))))

(define (py-rshift-fallback:reflected x281 y282)
  (letrec* ((magic_method521
             (getattribute-from-obj-mro y282 (&& "__rrshift__"))))
    (if (py-test (py-is magic_method521 py-absent))
        (py-rshift-fallback:err x281 y282)
        (letrec* ((result522 (py-call magic_method521 y282 x281)))
          (if (py-test (py-is result522 py-NotImplemented))
              (py-rshift-fallback:err x281 y282)
              result522)))))

(define (py-rshift-fallback:err x283 y284)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for >>: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x283)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y284)
                             (& "__name__")))
                    (&& "'")))))

(define (py-sub-fallback:normal x285 y286)
  (letrec* ((magic_method525 (getattribute-from-obj-mro x285 (&& "__sub__"))))
    (if (py-test (py-is magic_method525 py-absent))
        (py-sub-fallback:reflected x285 y286)
        (letrec* ((result526 (py-call magic_method525 x285 y286)))
          (if (py-test (py-is result526 py-NotImplemented))
              (py-sub-fallback:reflected x285 y286)
              result526)))))

(define (py-sub-fallback:reflected x287 y288)
  (letrec* ((magic_method529 (getattribute-from-obj-mro y288 (&& "__rsub__"))))
    (if (py-test (py-is magic_method529 py-absent))
        (py-sub-fallback:err x287 y288)
        (letrec* ((result530 (py-call magic_method529 y288 x287)))
          (if (py-test (py-is result530 py-NotImplemented))
              (py-sub-fallback:err x287 y288)
              result530)))))

(define (py-sub-fallback:err x289 y290)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for -: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x289)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y290)
                             (& "__name__")))
                    (&& "'")))))

(define (py-truediv-fallback:normal x291 y292)
  (letrec* ((magic_method533
             (getattribute-from-obj-mro x291 (&& "__truediv__"))))
    (if (py-test (py-is magic_method533 py-absent))
        (py-truediv-fallback:reflected x291 y292)
        (letrec* ((result534 (py-call magic_method533 x291 y292)))
          (if (py-test (py-is result534 py-NotImplemented))
              (py-truediv-fallback:reflected x291 y292)
              result534)))))

(define (py-truediv-fallback:reflected x293 y294)
  (letrec* ((magic_method537
             (getattribute-from-obj-mro y294 (&& "__rtruediv__"))))
    (if (py-test (py-is magic_method537 py-absent))
        (py-truediv-fallback:err x293 y294)
        (letrec* ((result538 (py-call magic_method537 y294 x293)))
          (if (py-test (py-is result538 py-NotImplemented))
              (py-truediv-fallback:err x293 y294)
              result538)))))

(define (py-truediv-fallback:err x295 y296)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for /: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x295)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y296)
                             (& "__name__")))
                    (&& "'")))))

(define (py-xor-fallback:normal x297 y298)
  (letrec* ((magic_method541 (getattribute-from-obj-mro x297 (&& "__xor__"))))
    (if (py-test (py-is magic_method541 py-absent))
        (py-xor-fallback:reflected x297 y298)
        (letrec* ((result542 (py-call magic_method541 x297 y298)))
          (if (py-test (py-is result542 py-NotImplemented))
              (py-xor-fallback:reflected x297 y298)
              result542)))))

(define (py-xor-fallback:reflected x299 y300)
  (letrec* ((magic_method545 (getattribute-from-obj-mro y300 (&& "__rxor__"))))
    (if (py-test (py-is magic_method545 py-absent))
        (py-xor-fallback:err x299 y300)
        (letrec* ((result546 (py-call magic_method545 y300 x299)))
          (if (py-test (py-is result546 py-NotImplemented))
              (py-xor-fallback:err x299 y300)
              result546)))))

(define (py-xor-fallback:err x301 y302)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for ^: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x301)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y302)
                             (& "__name__")))
                    (&& "'")))))

(define (py-iadd-fallback:inplace x303 y304)
  (letrec* ((magic_method549 (getattribute-from-obj-mro x303 (&& "__iadd__"))))
    (if (py-test (py-is magic_method549 py-absent))
        (py-iadd-fallback:normal x303 y304)
        (letrec* ((result550 (py-call magic_method549 x303 y304)))
          (if (py-test (py-is result550 py-NotImplemented))
              (py-iadd-fallback:normal x303 y304)
              result550)))))

(define (py-iadd-fallback:normal x305 y306)
  (letrec* ((magic_method553 (getattribute-from-obj-mro x305 (&& "__add__"))))
    (if (py-test (py-is magic_method553 py-absent))
        (py-iadd-fallback:reflected x305 y306)
        (letrec* ((result554 (py-call magic_method553 x305 y306)))
          (if (py-test (py-is result554 py-NotImplemented))
              (py-iadd-fallback:reflected x305 y306)
              result554)))))

(define (py-iadd-fallback:reflected x307 y308)
  (letrec* ((magic_method557 (getattribute-from-obj-mro y308 (&& "__radd__"))))
    (if (py-test (py-is magic_method557 py-absent))
        (py-iadd-fallback:err x307 y308)
        (letrec* ((result558 (py-call magic_method557 y308 x307)))
          (if (py-test (py-is result558 py-NotImplemented))
              (py-iadd-fallback:err x307 y308)
              result558)))))

(define (py-iadd-fallback:err x309 y310)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for +=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x309)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y310)
                             (& "__name__")))
                    (&& "'")))))

(define (py-ibitand-fallback:inplace x311 y312)
  (letrec* ((magic_method561 (getattribute-from-obj-mro x311 (&& "__iand__"))))
    (if (py-test (py-is magic_method561 py-absent))
        (py-ibitand-fallback:normal x311 y312)
        (letrec* ((result562 (py-call magic_method561 x311 y312)))
          (if (py-test (py-is result562 py-NotImplemented))
              (py-ibitand-fallback:normal x311 y312)
              result562)))))

(define (py-ibitand-fallback:normal x313 y314)
  (letrec* ((magic_method565 (getattribute-from-obj-mro x313 (&& "__and__"))))
    (if (py-test (py-is magic_method565 py-absent))
        (py-ibitand-fallback:reflected x313 y314)
        (letrec* ((result566 (py-call magic_method565 x313 y314)))
          (if (py-test (py-is result566 py-NotImplemented))
              (py-ibitand-fallback:reflected x313 y314)
              result566)))))

(define (py-ibitand-fallback:reflected x315 y316)
  (letrec* ((magic_method569 (getattribute-from-obj-mro y316 (&& "__rand__"))))
    (if (py-test (py-is magic_method569 py-absent))
        (py-ibitand-fallback:err x315 y316)
        (letrec* ((result570 (py-call magic_method569 y316 x315)))
          (if (py-test (py-is result570 py-NotImplemented))
              (py-ibitand-fallback:err x315 y316)
              result570)))))

(define (py-ibitand-fallback:err x317 y318)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for &=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x317)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y318)
                             (& "__name__")))
                    (&& "'")))))

(define (py-ibitor-fallback:inplace x319 y320)
  (letrec* ((magic_method573 (getattribute-from-obj-mro x319 (&& "__ior__"))))
    (if (py-test (py-is magic_method573 py-absent))
        (py-ibitor-fallback:normal x319 y320)
        (letrec* ((result574 (py-call magic_method573 x319 y320)))
          (if (py-test (py-is result574 py-NotImplemented))
              (py-ibitor-fallback:normal x319 y320)
              result574)))))

(define (py-ibitor-fallback:normal x321 y322)
  (letrec* ((magic_method577 (getattribute-from-obj-mro x321 (&& "__or__"))))
    (if (py-test (py-is magic_method577 py-absent))
        (py-ibitor-fallback:reflected x321 y322)
        (letrec* ((result578 (py-call magic_method577 x321 y322)))
          (if (py-test (py-is result578 py-NotImplemented))
              (py-ibitor-fallback:reflected x321 y322)
              result578)))))

(define (py-ibitor-fallback:reflected x323 y324)
  (letrec* ((magic_method581 (getattribute-from-obj-mro y324 (&& "__ror__"))))
    (if (py-test (py-is magic_method581 py-absent))
        (py-ibitor-fallback:err x323 y324)
        (letrec* ((result582 (py-call magic_method581 y324 x323)))
          (if (py-test (py-is result582 py-NotImplemented))
              (py-ibitor-fallback:err x323 y324)
              result582)))))

(define (py-ibitor-fallback:err x325 y326)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for |=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x325)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y326)
                             (& "__name__")))
                    (&& "'")))))

(define (py-ifloordiv-fallback:inplace x327 y328)
  (letrec* ((magic_method585
             (getattribute-from-obj-mro x327 (&& "__ifloordiv__"))))
    (if (py-test (py-is magic_method585 py-absent))
        (py-ifloordiv-fallback:normal x327 y328)
        (letrec* ((result586 (py-call magic_method585 x327 y328)))
          (if (py-test (py-is result586 py-NotImplemented))
              (py-ifloordiv-fallback:normal x327 y328)
              result586)))))

(define (py-ifloordiv-fallback:normal x329 y330)
  (letrec* ((magic_method589
             (getattribute-from-obj-mro x329 (&& "__floordiv__"))))
    (if (py-test (py-is magic_method589 py-absent))
        (py-ifloordiv-fallback:reflected x329 y330)
        (letrec* ((result590 (py-call magic_method589 x329 y330)))
          (if (py-test (py-is result590 py-NotImplemented))
              (py-ifloordiv-fallback:reflected x329 y330)
              result590)))))

(define (py-ifloordiv-fallback:reflected x331 y332)
  (letrec* ((magic_method593
             (getattribute-from-obj-mro y332 (&& "__rfloordiv__"))))
    (if (py-test (py-is magic_method593 py-absent))
        (py-ifloordiv-fallback:err x331 y332)
        (letrec* ((result594 (py-call magic_method593 y332 x331)))
          (if (py-test (py-is result594 py-NotImplemented))
              (py-ifloordiv-fallback:err x331 y332)
              result594)))))

(define (py-ifloordiv-fallback:err x333 y334)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for //=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x333)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y334)
                             (& "__name__")))
                    (&& "'")))))

(define (py-ilshift-fallback:inplace x335 y336)
  (letrec* ((magic_method597
             (getattribute-from-obj-mro x335 (&& "__ilshift__"))))
    (if (py-test (py-is magic_method597 py-absent))
        (py-ilshift-fallback:normal x335 y336)
        (letrec* ((result598 (py-call magic_method597 x335 y336)))
          (if (py-test (py-is result598 py-NotImplemented))
              (py-ilshift-fallback:normal x335 y336)
              result598)))))

(define (py-ilshift-fallback:normal x337 y338)
  (letrec* ((magic_method601
             (getattribute-from-obj-mro x337 (&& "__lshift__"))))
    (if (py-test (py-is magic_method601 py-absent))
        (py-ilshift-fallback:reflected x337 y338)
        (letrec* ((result602 (py-call magic_method601 x337 y338)))
          (if (py-test (py-is result602 py-NotImplemented))
              (py-ilshift-fallback:reflected x337 y338)
              result602)))))

(define (py-ilshift-fallback:reflected x339 y340)
  (letrec* ((magic_method605
             (getattribute-from-obj-mro y340 (&& "__rlshift__"))))
    (if (py-test (py-is magic_method605 py-absent))
        (py-ilshift-fallback:err x339 y340)
        (letrec* ((result606 (py-call magic_method605 y340 x339)))
          (if (py-test (py-is result606 py-NotImplemented))
              (py-ilshift-fallback:err x339 y340)
              result606)))))

(define (py-ilshift-fallback:err x341 y342)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for <<=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x341)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y342)
                             (& "__name__")))
                    (&& "'")))))

(define (py-imatmul-fallback:inplace x343 y344)
  (letrec* ((magic_method609
             (getattribute-from-obj-mro x343 (&& "__imatmul__"))))
    (if (py-test (py-is magic_method609 py-absent))
        (py-imatmul-fallback:normal x343 y344)
        (letrec* ((result610 (py-call magic_method609 x343 y344)))
          (if (py-test (py-is result610 py-NotImplemented))
              (py-imatmul-fallback:normal x343 y344)
              result610)))))

(define (py-imatmul-fallback:normal x345 y346)
  (letrec* ((magic_method613
             (getattribute-from-obj-mro x345 (&& "__matmul__"))))
    (if (py-test (py-is magic_method613 py-absent))
        (py-imatmul-fallback:reflected x345 y346)
        (letrec* ((result614 (py-call magic_method613 x345 y346)))
          (if (py-test (py-is result614 py-NotImplemented))
              (py-imatmul-fallback:reflected x345 y346)
              result614)))))

(define (py-imatmul-fallback:reflected x347 y348)
  (letrec* ((magic_method617
             (getattribute-from-obj-mro y348 (&& "__rmatmul__"))))
    (if (py-test (py-is magic_method617 py-absent))
        (py-imatmul-fallback:err x347 y348)
        (letrec* ((result618 (py-call magic_method617 y348 x347)))
          (if (py-test (py-is result618 py-NotImplemented))
              (py-imatmul-fallback:err x347 y348)
              result618)))))

(define (py-imatmul-fallback:err x349 y350)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for @=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x349)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y350)
                             (& "__name__")))
                    (&& "'")))))

(define (py-imod-fallback:inplace x351 y352)
  (letrec* ((magic_method621 (getattribute-from-obj-mro x351 (&& "__imod__"))))
    (if (py-test (py-is magic_method621 py-absent))
        (py-imod-fallback:normal x351 y352)
        (letrec* ((result622 (py-call magic_method621 x351 y352)))
          (if (py-test (py-is result622 py-NotImplemented))
              (py-imod-fallback:normal x351 y352)
              result622)))))

(define (py-imod-fallback:normal x353 y354)
  (letrec* ((magic_method625 (getattribute-from-obj-mro x353 (&& "__mod__"))))
    (if (py-test (py-is magic_method625 py-absent))
        (py-imod-fallback:reflected x353 y354)
        (letrec* ((result626 (py-call magic_method625 x353 y354)))
          (if (py-test (py-is result626 py-NotImplemented))
              (py-imod-fallback:reflected x353 y354)
              result626)))))

(define (py-imod-fallback:reflected x355 y356)
  (letrec* ((magic_method629 (getattribute-from-obj-mro y356 (&& "__rmod__"))))
    (if (py-test (py-is magic_method629 py-absent))
        (py-imod-fallback:err x355 y356)
        (letrec* ((result630 (py-call magic_method629 y356 x355)))
          (if (py-test (py-is result630 py-NotImplemented))
              (py-imod-fallback:err x355 y356)
              result630)))))

(define (py-imod-fallback:err x357 y358)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for %=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x357)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y358)
                             (& "__name__")))
                    (&& "'")))))

(define (py-imul-fallback:inplace x359 y360)
  (letrec* ((magic_method633 (getattribute-from-obj-mro x359 (&& "__imul__"))))
    (if (py-test (py-is magic_method633 py-absent))
        (py-imul-fallback:normal x359 y360)
        (letrec* ((result634 (py-call magic_method633 x359 y360)))
          (if (py-test (py-is result634 py-NotImplemented))
              (py-imul-fallback:normal x359 y360)
              result634)))))

(define (py-imul-fallback:normal x361 y362)
  (letrec* ((magic_method637 (getattribute-from-obj-mro x361 (&& "__mul__"))))
    (if (py-test (py-is magic_method637 py-absent))
        (py-imul-fallback:reflected x361 y362)
        (letrec* ((result638 (py-call magic_method637 x361 y362)))
          (if (py-test (py-is result638 py-NotImplemented))
              (py-imul-fallback:reflected x361 y362)
              result638)))))

(define (py-imul-fallback:reflected x363 y364)
  (letrec* ((magic_method641 (getattribute-from-obj-mro y364 (&& "__rmul__"))))
    (if (py-test (py-is magic_method641 py-absent))
        (py-imul-fallback:err x363 y364)
        (letrec* ((result642 (py-call magic_method641 y364 x363)))
          (if (py-test (py-is result642 py-NotImplemented))
              (py-imul-fallback:err x363 y364)
              result642)))))

(define (py-imul-fallback:err x365 y366)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for *=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x365)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y366)
                             (& "__name__")))
                    (&& "'")))))

(define (py-ipow-fallback:inplace x367 y368)
  (letrec* ((magic_method645 (getattribute-from-obj-mro x367 (&& "__ipow__"))))
    (if (py-test (py-is magic_method645 py-absent))
        (py-ipow-fallback:normal x367 y368)
        (letrec* ((result646 (py-call magic_method645 x367 y368)))
          (if (py-test (py-is result646 py-NotImplemented))
              (py-ipow-fallback:normal x367 y368)
              result646)))))

(define (py-ipow-fallback:normal x369 y370)
  (letrec* ((magic_method649 (getattribute-from-obj-mro x369 (&& "__pow__"))))
    (if (py-test (py-is magic_method649 py-absent))
        (py-ipow-fallback:reflected x369 y370)
        (letrec* ((result650 (py-call magic_method649 x369 y370)))
          (if (py-test (py-is result650 py-NotImplemented))
              (py-ipow-fallback:reflected x369 y370)
              result650)))))

(define (py-ipow-fallback:reflected x371 y372)
  (letrec* ((magic_method653 (getattribute-from-obj-mro y372 (&& "__rpow__"))))
    (if (py-test (py-is magic_method653 py-absent))
        (py-ipow-fallback:err x371 y372)
        (letrec* ((result654 (py-call magic_method653 y372 x371)))
          (if (py-test (py-is result654 py-NotImplemented))
              (py-ipow-fallback:err x371 y372)
              result654)))))

(define (py-ipow-fallback:err x373 y374)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for **=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x373)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y374)
                             (& "__name__")))
                    (&& "'")))))

(define (py-irshift-fallback:inplace x375 y376)
  (letrec* ((magic_method657
             (getattribute-from-obj-mro x375 (&& "__irshift__"))))
    (if (py-test (py-is magic_method657 py-absent))
        (py-irshift-fallback:normal x375 y376)
        (letrec* ((result658 (py-call magic_method657 x375 y376)))
          (if (py-test (py-is result658 py-NotImplemented))
              (py-irshift-fallback:normal x375 y376)
              result658)))))

(define (py-irshift-fallback:normal x377 y378)
  (letrec* ((magic_method661
             (getattribute-from-obj-mro x377 (&& "__rshift__"))))
    (if (py-test (py-is magic_method661 py-absent))
        (py-irshift-fallback:reflected x377 y378)
        (letrec* ((result662 (py-call magic_method661 x377 y378)))
          (if (py-test (py-is result662 py-NotImplemented))
              (py-irshift-fallback:reflected x377 y378)
              result662)))))

(define (py-irshift-fallback:reflected x379 y380)
  (letrec* ((magic_method665
             (getattribute-from-obj-mro y380 (&& "__rrshift__"))))
    (if (py-test (py-is magic_method665 py-absent))
        (py-irshift-fallback:err x379 y380)
        (letrec* ((result666 (py-call magic_method665 y380 x379)))
          (if (py-test (py-is result666 py-NotImplemented))
              (py-irshift-fallback:err x379 y380)
              result666)))))

(define (py-irshift-fallback:err x381 y382)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for >>=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x381)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y382)
                             (& "__name__")))
                    (&& "'")))))

(define (py-isub-fallback:inplace x383 y384)
  (letrec* ((magic_method669 (getattribute-from-obj-mro x383 (&& "__isub__"))))
    (if (py-test (py-is magic_method669 py-absent))
        (py-isub-fallback:normal x383 y384)
        (letrec* ((result670 (py-call magic_method669 x383 y384)))
          (if (py-test (py-is result670 py-NotImplemented))
              (py-isub-fallback:normal x383 y384)
              result670)))))

(define (py-isub-fallback:normal x385 y386)
  (letrec* ((magic_method673 (getattribute-from-obj-mro x385 (&& "__sub__"))))
    (if (py-test (py-is magic_method673 py-absent))
        (py-isub-fallback:reflected x385 y386)
        (letrec* ((result674 (py-call magic_method673 x385 y386)))
          (if (py-test (py-is result674 py-NotImplemented))
              (py-isub-fallback:reflected x385 y386)
              result674)))))

(define (py-isub-fallback:reflected x387 y388)
  (letrec* ((magic_method677 (getattribute-from-obj-mro y388 (&& "__rsub__"))))
    (if (py-test (py-is magic_method677 py-absent))
        (py-isub-fallback:err x387 y388)
        (letrec* ((result678 (py-call magic_method677 y388 x387)))
          (if (py-test (py-is result678 py-NotImplemented))
              (py-isub-fallback:err x387 y388)
              result678)))))

(define (py-isub-fallback:err x389 y390)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for -=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x389)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y390)
                             (& "__name__")))
                    (&& "'")))))

(define (py-itruediv-fallback:inplace x391 y392)
  (letrec* ((magic_method681
             (getattribute-from-obj-mro x391 (&& "__itruediv__"))))
    (if (py-test (py-is magic_method681 py-absent))
        (py-itruediv-fallback:normal x391 y392)
        (letrec* ((result682 (py-call magic_method681 x391 y392)))
          (if (py-test (py-is result682 py-NotImplemented))
              (py-itruediv-fallback:normal x391 y392)
              result682)))))

(define (py-itruediv-fallback:normal x393 y394)
  (letrec* ((magic_method685
             (getattribute-from-obj-mro x393 (&& "__truediv__"))))
    (if (py-test (py-is magic_method685 py-absent))
        (py-itruediv-fallback:reflected x393 y394)
        (letrec* ((result686 (py-call magic_method685 x393 y394)))
          (if (py-test (py-is result686 py-NotImplemented))
              (py-itruediv-fallback:reflected x393 y394)
              result686)))))

(define (py-itruediv-fallback:reflected x395 y396)
  (letrec* ((magic_method689
             (getattribute-from-obj-mro y396 (&& "__rtruediv__"))))
    (if (py-test (py-is magic_method689 py-absent))
        (py-itruediv-fallback:err x395 y396)
        (letrec* ((result690 (py-call magic_method689 y396 x395)))
          (if (py-test (py-is result690 py-NotImplemented))
              (py-itruediv-fallback:err x395 y396)
              result690)))))

(define (py-itruediv-fallback:err x397 y398)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for /=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x397)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y398)
                             (& "__name__")))
                    (&& "'")))))

(define (py-ixor-fallback:inplace x399 y400)
  (letrec* ((magic_method693 (getattribute-from-obj-mro x399 (&& "__ixor__"))))
    (if (py-test (py-is magic_method693 py-absent))
        (py-ixor-fallback:normal x399 y400)
        (letrec* ((result694 (py-call magic_method693 x399 y400)))
          (if (py-test (py-is result694 py-NotImplemented))
              (py-ixor-fallback:normal x399 y400)
              result694)))))

(define (py-ixor-fallback:normal x401 y402)
  (letrec* ((magic_method697 (getattribute-from-obj-mro x401 (&& "__xor__"))))
    (if (py-test (py-is magic_method697 py-absent))
        (py-ixor-fallback:reflected x401 y402)
        (letrec* ((result698 (py-call magic_method697 x401 y402)))
          (if (py-test (py-is result698 py-NotImplemented))
              (py-ixor-fallback:reflected x401 y402)
              result698)))))

(define (py-ixor-fallback:reflected x403 y404)
  (letrec* ((magic_method701 (getattribute-from-obj-mro y404 (&& "__rxor__"))))
    (if (py-test (py-is magic_method701 py-absent))
        (py-ixor-fallback:err x403 y404)
        (letrec* ((result702 (py-call magic_method701 y404 x403)))
          (if (py-test (py-is result702 py-NotImplemented))
              (py-ixor-fallback:err x403 y404)
              result702)))))

(define (py-ixor-fallback:err x405 y406)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for ^=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x405)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y406)
                             (& "__name__")))
                    (&& "'")))))

(define (py-ge-fallback:normal x407 y408)
  (letrec* ((magic_method705 (getattribute-from-obj-mro x407 (&& "__ge__"))))
    (if (py-test (py-is magic_method705 py-absent))
        (py-ge-fallback:reflected x407 y408)
        (letrec* ((result706 (py-call magic_method705 x407 y408)))
          (if (py-test (py-is result706 py-NotImplemented))
              (py-ge-fallback:reflected x407 y408)
              result706)))))

(define (py-ge-fallback:reflected x409 y410)
  (letrec* ((magic_method709 (getattribute-from-obj-mro y410 (&& "__le__"))))
    (if (py-test (py-is magic_method709 py-absent))
        (py-ge-fallback:err x409 y410)
        (letrec* ((result710 (py-call magic_method709 y410 x409)))
          (if (py-test (py-is result710 py-NotImplemented))
              (py-ge-fallback:err x409 y410)
              result710)))))

(define (py-ge-fallback:err x411 y412)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "'>=' not supported between instances of '")
                                            (py-getattribute
                                             (py-call py-builtin-type x411)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y412)
                             (& "__name__")))
                    (&& "'")))))

(define (py-gt-fallback:normal x413 y414)
  (letrec* ((magic_method713 (getattribute-from-obj-mro x413 (&& "__gt__"))))
    (if (py-test (py-is magic_method713 py-absent))
        (py-gt-fallback:reflected x413 y414)
        (letrec* ((result714 (py-call magic_method713 x413 y414)))
          (if (py-test (py-is result714 py-NotImplemented))
              (py-gt-fallback:reflected x413 y414)
              result714)))))

(define (py-gt-fallback:reflected x415 y416)
  (letrec* ((magic_method717 (getattribute-from-obj-mro y416 (&& "__lt__"))))
    (if (py-test (py-is magic_method717 py-absent))
        (py-gt-fallback:err x415 y416)
        (letrec* ((result718 (py-call magic_method717 y416 x415)))
          (if (py-test (py-is result718 py-NotImplemented))
              (py-gt-fallback:err x415 y416)
              result718)))))

(define (py-gt-fallback:err x417 y418)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "'>' not supported between instances of '")
                                            (py-getattribute
                                             (py-call py-builtin-type x417)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y418)
                             (& "__name__")))
                    (&& "'")))))

(define (py-le-fallback:normal x419 y420)
  (letrec* ((magic_method721 (getattribute-from-obj-mro x419 (&& "__le__"))))
    (if (py-test (py-is magic_method721 py-absent))
        (py-le-fallback:reflected x419 y420)
        (letrec* ((result722 (py-call magic_method721 x419 y420)))
          (if (py-test (py-is result722 py-NotImplemented))
              (py-le-fallback:reflected x419 y420)
              result722)))))

(define (py-le-fallback:reflected x421 y422)
  (letrec* ((magic_method725 (getattribute-from-obj-mro y422 (&& "__ge__"))))
    (if (py-test (py-is magic_method725 py-absent))
        (py-le-fallback:err x421 y422)
        (letrec* ((result726 (py-call magic_method725 y422 x421)))
          (if (py-test (py-is result726 py-NotImplemented))
              (py-le-fallback:err x421 y422)
              result726)))))

(define (py-le-fallback:err x423 y424)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "'<=' not supported between instances of '")
                                            (py-getattribute
                                             (py-call py-builtin-type x423)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y424)
                             (& "__name__")))
                    (&& "'")))))

(define (py-lt-fallback:normal x425 y426)
  (letrec* ((magic_method729 (getattribute-from-obj-mro x425 (&& "__lt__"))))
    (if (py-test (py-is magic_method729 py-absent))
        (py-lt-fallback:reflected x425 y426)
        (letrec* ((result730 (py-call magic_method729 x425 y426)))
          (if (py-test (py-is result730 py-NotImplemented))
              (py-lt-fallback:reflected x425 y426)
              result730)))))

(define (py-lt-fallback:reflected x427 y428)
  (letrec* ((magic_method733 (getattribute-from-obj-mro y428 (&& "__gt__"))))
    (if (py-test (py-is magic_method733 py-absent))
        (py-lt-fallback:err x427 y428)
        (letrec* ((result734 (py-call magic_method733 y428 x427)))
          (if (py-test (py-is result734 py-NotImplemented))
              (py-lt-fallback:err x427 y428)
              result734)))))

(define (py-lt-fallback:err x429 y430)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "'<' not supported between instances of '")
                                            (py-getattribute
                                             (py-call py-builtin-type x429)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y430)
                             (& "__name__")))
                    (&& "'")))))

(define (py-eq-fallback:normal x431 y432)
  (letrec* ((magic_method737 (getattribute-from-obj-mro x431 (&& "__eq__"))))
    (if (py-test (py-is magic_method737 py-absent))
        (py-eq-fallback:reflected x431 y432)
        (letrec* ((result738 (py-call magic_method737 x431 y432)))
          (if (py-test (py-is result738 py-NotImplemented))
              (py-eq-fallback:reflected x431 y432)
              result738)))))

(define (py-eq-fallback:reflected x433 y434)
  (letrec* ((magic_method741 (getattribute-from-obj-mro y434 (&& "__eq__"))))
    (if (py-test (py-is magic_method741 py-absent))
        (py-eq-fallback:default x433 y434)
        (letrec* ((result742 (py-call magic_method741 y434 x433)))
          (if (py-test (py-is result742 py-NotImplemented))
              (py-eq-fallback:default x433 y434)
              result742)))))

(define (py-eq-fallback:default x435 y436) (py-is x435 y436))

(define (py-ne-fallback:normal x437 y438)
  (letrec* ((magic_method745 (getattribute-from-obj-mro x437 (&& "__ne__"))))
    (if (py-test (py-is magic_method745 py-absent))
        (py-ne-fallback:reflected x437 y438)
        (letrec* ((result746 (py-call magic_method745 x437 y438)))
          (if (py-test (py-is result746 py-NotImplemented))
              (py-ne-fallback:reflected x437 y438)
              result746)))))

(define (py-ne-fallback:reflected x439 y440)
  (letrec* ((magic_method749 (getattribute-from-obj-mro y440 (&& "__ne__"))))
    (if (py-test (py-is magic_method749 py-absent))
        (py-ne-fallback:default x439 y440)
        (letrec* ((result750 (py-call magic_method749 y440 x439)))
          (if (py-test (py-is result750 py-NotImplemented))
              (py-ne-fallback:default x439 y440)
              result750)))))

(define (py-ne-fallback:default x441 y442) (py-isnot x441 y442))

(define (py-getattribute-fallback obj207 attr208)
  (letrec* ((__getattribute__753
             (getattribute-from-obj-mro obj207 (&& "__getattribute__"))))
    (with-handler
     (lambda ($%exc_0)
       (cond ((py-isinstance? $%exc_0 py-builtin-AttributeError)
              (letrec* ((__getattr__754
                         (getattribute-from-obj-mro
                          obj207
                          (&& "__getattr__"))))
                (if (py-test (py-is __getattr__754 py-absent))
                    (py-throw $%exc_0)
                    (py-call __getattr__754 obj207 attr208))))
             (else (raise $%exc_0))))
     (py-call __getattribute__753 obj207 attr208))))

(define (py-getitem-fallback obj210 index211)
  (letrec* ((__getitem__756
             (getattribute-from-obj-mro obj210 (&& "__getitem__"))))
    (if (py-test (py-is __getitem__756 py-absent))
        (py-throw
         (py-call py-builtin-TypeError (&& "object is not subscriptable")))
        (py-call __getitem__756 obj210 index211))))

(define (py-setitem-fallback obj213 index214 value215)
  (letrec* ((__setitem__758
             (getattribute-from-obj-mro obj213 (&& "__setitem__"))))
    (if (py-test (py-is __setitem__758 py-absent))
        (py-throw
         (py-call py-builtin-TypeError
                  (&& "object does not support item assignment")))
        (py-call __setitem__758 obj213 index214 value215))))

(define (py-delitem-fallback obj217 index218)
  (letrec* ((__delitem__760
             (getattribute-from-obj-mro obj217 (&& "__delitem__"))))
    (if (py-test (py-is __delitem__760 py-absent))
        (py-throw
         (py-call py-builtin-TypeError
                  (&& "object does not support item deletion")))
        (py-call __delitem__760 obj217 index218))))

(define (py-enter-fallback obj220)
  (letrec* ((__enter__762 (getattribute-from-obj-mro obj220 (&& "__enter__"))))
    (if (py-test (py-is __enter__762 py-absent))
        (py-throw (py-call py-builtin-AttributeError (&& "__enter__")))
        (py-call __enter__762 obj220))))

(define (py-exit-fallback obj222 exc223)
  (letrec* ((__exit__765 (getattribute-from-obj-mro obj222 (&& "__exit__"))))
    (if (py-test (py-is __exit__765 py-absent))
        (py-throw (py-call py-builtin-AttributeError (&& "__exit__")))
        (if (py-test (py-is exc223 py-None))
            (py-call __exit__765 obj222 py-None py-None py-None)
            (letrec* ((exit_result766
                       (py-call __exit__765
                                obj222
                                (py-call py-builtin-type exc223)
                                exc223
                                py-None)))
              (if (py-test exit_result766) py-None (py-throw exc223)))))))

