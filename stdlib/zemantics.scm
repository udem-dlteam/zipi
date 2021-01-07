(define-macro (py-add x2 y3) `(let ((x2 ,x2) (y3 ,y3)) (py-add:normal x2 y3)))

(define (py-add:normal x189 y190)
  (letrec* ((magic_method373 (getattribute-from-obj-mro x189 (&& "__add__"))))
    (if (eq? magic_method373 py-absent)
        (py-add:reflected x189 y190)
        (letrec* ((result374 (py-call magic_method373 x189 y190)))
          (if (eq? result374 py-NotImplemented)
              (py-add:reflected x189 y190)
              result374)))))

(define (py-add:reflected x191 y192)
  (letrec* ((magic_method377 (getattribute-from-obj-mro y192 (&& "__radd__"))))
    (if (eq? magic_method377 py-absent)
        (py-add:err x191 y192)
        (letrec* ((result378 (py-call magic_method377 y192 x191)))
          (if (eq? result378 py-NotImplemented)
              (py-add:err x191 y192)
              result378)))))

(define (py-add:err x193 y194)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for +: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x193)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y194)
                             (& "__name__")))
                    (&& "'")))))

(define-macro (py-bitand x8 y9)
  `(let ((x8 ,x8) (y9 ,y9)) (py-bitand:normal x8 y9)))

(define (py-bitand:normal x195 y196)
  (letrec* ((magic_method381 (getattribute-from-obj-mro x195 (&& "__and__"))))
    (if (eq? magic_method381 py-absent)
        (py-bitand:reflected x195 y196)
        (letrec* ((result382 (py-call magic_method381 x195 y196)))
          (if (eq? result382 py-NotImplemented)
              (py-bitand:reflected x195 y196)
              result382)))))

(define (py-bitand:reflected x197 y198)
  (letrec* ((magic_method385 (getattribute-from-obj-mro y198 (&& "__rand__"))))
    (if (eq? magic_method385 py-absent)
        (py-bitand:err x197 y198)
        (letrec* ((result386 (py-call magic_method385 y198 x197)))
          (if (eq? result386 py-NotImplemented)
              (py-bitand:err x197 y198)
              result386)))))

(define (py-bitand:err x199 y200)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for &: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x199)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y200)
                             (& "__name__")))
                    (&& "'")))))

(define-macro (py-bitor x14 y15)
  `(let ((x14 ,x14) (y15 ,y15)) (py-bitor:normal x14 y15)))

(define (py-bitor:normal x201 y202)
  (letrec* ((magic_method389 (getattribute-from-obj-mro x201 (&& "__or__"))))
    (if (eq? magic_method389 py-absent)
        (py-bitor:reflected x201 y202)
        (letrec* ((result390 (py-call magic_method389 x201 y202)))
          (if (eq? result390 py-NotImplemented)
              (py-bitor:reflected x201 y202)
              result390)))))

(define (py-bitor:reflected x203 y204)
  (letrec* ((magic_method393 (getattribute-from-obj-mro y204 (&& "__ror__"))))
    (if (eq? magic_method393 py-absent)
        (py-bitor:err x203 y204)
        (letrec* ((result394 (py-call magic_method393 y204 x203)))
          (if (eq? result394 py-NotImplemented)
              (py-bitor:err x203 y204)
              result394)))))

(define (py-bitor:err x205 y206)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for |: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x205)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y206)
                             (& "__name__")))
                    (&& "'")))))

(define-macro (py-floordiv x20 y21)
  `(let ((x20 ,x20) (y21 ,y21)) (py-floordiv:normal x20 y21)))

(define (py-floordiv:normal x207 y208)
  (letrec* ((magic_method397
             (getattribute-from-obj-mro x207 (&& "__floordiv__"))))
    (if (eq? magic_method397 py-absent)
        (py-floordiv:reflected x207 y208)
        (letrec* ((result398 (py-call magic_method397 x207 y208)))
          (if (eq? result398 py-NotImplemented)
              (py-floordiv:reflected x207 y208)
              result398)))))

(define (py-floordiv:reflected x209 y210)
  (letrec* ((magic_method401
             (getattribute-from-obj-mro y210 (&& "__rfloordiv__"))))
    (if (eq? magic_method401 py-absent)
        (py-floordiv:err x209 y210)
        (letrec* ((result402 (py-call magic_method401 y210 x209)))
          (if (eq? result402 py-NotImplemented)
              (py-floordiv:err x209 y210)
              result402)))))

(define (py-floordiv:err x211 y212)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for //: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x211)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y212)
                             (& "__name__")))
                    (&& "'")))))

(define-macro (py-lshift x26 y27)
  `(let ((x26 ,x26) (y27 ,y27)) (py-lshift:normal x26 y27)))

(define (py-lshift:normal x213 y214)
  (letrec* ((magic_method405
             (getattribute-from-obj-mro x213 (&& "__lshift__"))))
    (if (eq? magic_method405 py-absent)
        (py-lshift:reflected x213 y214)
        (letrec* ((result406 (py-call magic_method405 x213 y214)))
          (if (eq? result406 py-NotImplemented)
              (py-lshift:reflected x213 y214)
              result406)))))

(define (py-lshift:reflected x215 y216)
  (letrec* ((magic_method409
             (getattribute-from-obj-mro y216 (&& "__rlshift__"))))
    (if (eq? magic_method409 py-absent)
        (py-lshift:err x215 y216)
        (letrec* ((result410 (py-call magic_method409 y216 x215)))
          (if (eq? result410 py-NotImplemented)
              (py-lshift:err x215 y216)
              result410)))))

(define (py-lshift:err x217 y218)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for <<: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x217)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y218)
                             (& "__name__")))
                    (&& "'")))))

(define-macro (py-matmul x32 y33)
  `(let ((x32 ,x32) (y33 ,y33)) (py-matmul:normal x32 y33)))

(define (py-matmul:normal x219 y220)
  (letrec* ((magic_method413
             (getattribute-from-obj-mro x219 (&& "__matmul__"))))
    (if (eq? magic_method413 py-absent)
        (py-matmul:reflected x219 y220)
        (letrec* ((result414 (py-call magic_method413 x219 y220)))
          (if (eq? result414 py-NotImplemented)
              (py-matmul:reflected x219 y220)
              result414)))))

(define (py-matmul:reflected x221 y222)
  (letrec* ((magic_method417
             (getattribute-from-obj-mro y222 (&& "__rmatmul__"))))
    (if (eq? magic_method417 py-absent)
        (py-matmul:err x221 y222)
        (letrec* ((result418 (py-call magic_method417 y222 x221)))
          (if (eq? result418 py-NotImplemented)
              (py-matmul:err x221 y222)
              result418)))))

(define (py-matmul:err x223 y224)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for @: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x223)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y224)
                             (& "__name__")))
                    (&& "'")))))

(define-macro (py-mod x38 y39)
  `(let ((x38 ,x38) (y39 ,y39)) (py-mod:normal x38 y39)))

(define (py-mod:normal x225 y226)
  (letrec* ((magic_method421 (getattribute-from-obj-mro x225 (&& "__mod__"))))
    (if (eq? magic_method421 py-absent)
        (py-mod:reflected x225 y226)
        (letrec* ((result422 (py-call magic_method421 x225 y226)))
          (if (eq? result422 py-NotImplemented)
              (py-mod:reflected x225 y226)
              result422)))))

(define (py-mod:reflected x227 y228)
  (letrec* ((magic_method425 (getattribute-from-obj-mro y228 (&& "__rmod__"))))
    (if (eq? magic_method425 py-absent)
        (py-mod:err x227 y228)
        (letrec* ((result426 (py-call magic_method425 y228 x227)))
          (if (eq? result426 py-NotImplemented)
              (py-mod:err x227 y228)
              result426)))))

(define (py-mod:err x229 y230)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for %: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x229)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y230)
                             (& "__name__")))
                    (&& "'")))))

(define-macro (py-mul x44 y45)
  `(let ((x44 ,x44) (y45 ,y45)) (py-mul:normal x44 y45)))

(define (py-mul:normal x231 y232)
  (letrec* ((magic_method429 (getattribute-from-obj-mro x231 (&& "__mul__"))))
    (if (eq? magic_method429 py-absent)
        (py-mul:reflected x231 y232)
        (letrec* ((result430 (py-call magic_method429 x231 y232)))
          (if (eq? result430 py-NotImplemented)
              (py-mul:reflected x231 y232)
              result430)))))

(define (py-mul:reflected x233 y234)
  (letrec* ((magic_method433 (getattribute-from-obj-mro y234 (&& "__rmul__"))))
    (if (eq? magic_method433 py-absent)
        (py-mul:err x233 y234)
        (letrec* ((result434 (py-call magic_method433 y234 x233)))
          (if (eq? result434 py-NotImplemented)
              (py-mul:err x233 y234)
              result434)))))

(define (py-mul:err x235 y236)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for *: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x235)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y236)
                             (& "__name__")))
                    (&& "'")))))

(define-macro (py-pow x50 y51)
  `(let ((x50 ,x50) (y51 ,y51)) (py-pow:normal x50 y51)))

(define (py-pow:normal x237 y238)
  (letrec* ((magic_method437 (getattribute-from-obj-mro x237 (&& "__pow__"))))
    (if (eq? magic_method437 py-absent)
        (py-pow:reflected x237 y238)
        (letrec* ((result438 (py-call magic_method437 x237 y238)))
          (if (eq? result438 py-NotImplemented)
              (py-pow:reflected x237 y238)
              result438)))))

(define (py-pow:reflected x239 y240)
  (letrec* ((magic_method441 (getattribute-from-obj-mro y240 (&& "__rpow__"))))
    (if (eq? magic_method441 py-absent)
        (py-pow:err x239 y240)
        (letrec* ((result442 (py-call magic_method441 y240 x239)))
          (if (eq? result442 py-NotImplemented)
              (py-pow:err x239 y240)
              result442)))))

(define (py-pow:err x241 y242)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for **: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x241)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y242)
                             (& "__name__")))
                    (&& "'")))))

(define-macro (py-rshift x56 y57)
  `(let ((x56 ,x56) (y57 ,y57)) (py-rshift:normal x56 y57)))

(define (py-rshift:normal x243 y244)
  (letrec* ((magic_method445
             (getattribute-from-obj-mro x243 (&& "__rshift__"))))
    (if (eq? magic_method445 py-absent)
        (py-rshift:reflected x243 y244)
        (letrec* ((result446 (py-call magic_method445 x243 y244)))
          (if (eq? result446 py-NotImplemented)
              (py-rshift:reflected x243 y244)
              result446)))))

(define (py-rshift:reflected x245 y246)
  (letrec* ((magic_method449
             (getattribute-from-obj-mro y246 (&& "__rrshift__"))))
    (if (eq? magic_method449 py-absent)
        (py-rshift:err x245 y246)
        (letrec* ((result450 (py-call magic_method449 y246 x245)))
          (if (eq? result450 py-NotImplemented)
              (py-rshift:err x245 y246)
              result450)))))

(define (py-rshift:err x247 y248)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for >>: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x247)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y248)
                             (& "__name__")))
                    (&& "'")))))

(define-macro (py-sub x62 y63)
  `(let ((x62 ,x62) (y63 ,y63)) (py-sub:normal x62 y63)))

(define (py-sub:normal x249 y250)
  (letrec* ((magic_method453 (getattribute-from-obj-mro x249 (&& "__sub__"))))
    (if (eq? magic_method453 py-absent)
        (py-sub:reflected x249 y250)
        (letrec* ((result454 (py-call magic_method453 x249 y250)))
          (if (eq? result454 py-NotImplemented)
              (py-sub:reflected x249 y250)
              result454)))))

(define (py-sub:reflected x251 y252)
  (letrec* ((magic_method457 (getattribute-from-obj-mro y252 (&& "__rsub__"))))
    (if (eq? magic_method457 py-absent)
        (py-sub:err x251 y252)
        (letrec* ((result458 (py-call magic_method457 y252 x251)))
          (if (eq? result458 py-NotImplemented)
              (py-sub:err x251 y252)
              result458)))))

(define (py-sub:err x253 y254)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for -: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x253)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y254)
                             (& "__name__")))
                    (&& "'")))))

(define-macro (py-truediv x68 y69)
  `(let ((x68 ,x68) (y69 ,y69)) (py-truediv:normal x68 y69)))

(define (py-truediv:normal x255 y256)
  (letrec* ((magic_method461
             (getattribute-from-obj-mro x255 (&& "__truediv__"))))
    (if (eq? magic_method461 py-absent)
        (py-truediv:reflected x255 y256)
        (letrec* ((result462 (py-call magic_method461 x255 y256)))
          (if (eq? result462 py-NotImplemented)
              (py-truediv:reflected x255 y256)
              result462)))))

(define (py-truediv:reflected x257 y258)
  (letrec* ((magic_method465
             (getattribute-from-obj-mro y258 (&& "__rtruediv__"))))
    (if (eq? magic_method465 py-absent)
        (py-truediv:err x257 y258)
        (letrec* ((result466 (py-call magic_method465 y258 x257)))
          (if (eq? result466 py-NotImplemented)
              (py-truediv:err x257 y258)
              result466)))))

(define (py-truediv:err x259 y260)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for /: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x259)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y260)
                             (& "__name__")))
                    (&& "'")))))

(define-macro (py-xor x74 y75)
  `(let ((x74 ,x74) (y75 ,y75)) (py-xor:normal x74 y75)))

(define (py-xor:normal x261 y262)
  (letrec* ((magic_method469 (getattribute-from-obj-mro x261 (&& "__xor__"))))
    (if (eq? magic_method469 py-absent)
        (py-xor:reflected x261 y262)
        (letrec* ((result470 (py-call magic_method469 x261 y262)))
          (if (eq? result470 py-NotImplemented)
              (py-xor:reflected x261 y262)
              result470)))))

(define (py-xor:reflected x263 y264)
  (letrec* ((magic_method473 (getattribute-from-obj-mro y264 (&& "__rxor__"))))
    (if (eq? magic_method473 py-absent)
        (py-xor:err x263 y264)
        (letrec* ((result474 (py-call magic_method473 y264 x263)))
          (if (eq? result474 py-NotImplemented)
              (py-xor:err x263 y264)
              result474)))))

(define (py-xor:err x265 y266)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for ^: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x265)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y266)
                             (& "__name__")))
                    (&& "'")))))

(define-macro (py-iadd x80 y81)
  `(let ((x80 ,x80) (y81 ,y81)) (py-iadd:inplace x80 y81)))

(define (py-iadd:inplace x267 y268)
  (letrec* ((magic_method477 (getattribute-from-obj-mro x267 (&& "__iadd__"))))
    (if (eq? magic_method477 py-absent)
        (py-iadd:normal x267 y268)
        (letrec* ((result478 (py-call magic_method477 x267 y268)))
          (if (eq? result478 py-NotImplemented)
              (py-iadd:normal x267 y268)
              result478)))))

(define (py-iadd:normal x269 y270)
  (letrec* ((magic_method481 (getattribute-from-obj-mro x269 (&& "__add__"))))
    (if (eq? magic_method481 py-absent)
        (py-iadd:reflected x269 y270)
        (letrec* ((result482 (py-call magic_method481 x269 y270)))
          (if (eq? result482 py-NotImplemented)
              (py-iadd:reflected x269 y270)
              result482)))))

(define (py-iadd:reflected x271 y272)
  (letrec* ((magic_method485 (getattribute-from-obj-mro y272 (&& "__radd__"))))
    (if (eq? magic_method485 py-absent)
        (py-iadd:err x271 y272)
        (letrec* ((result486 (py-call magic_method485 y272 x271)))
          (if (eq? result486 py-NotImplemented)
              (py-iadd:err x271 y272)
              result486)))))

(define (py-iadd:err x273 y274)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for +: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x273)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y274)
                             (& "__name__")))
                    (&& "'")))))

(define-macro (py-ibitand x87 y88)
  `(let ((x87 ,x87) (y88 ,y88)) (py-ibitand:inplace x87 y88)))

(define (py-ibitand:inplace x275 y276)
  (letrec* ((magic_method489 (getattribute-from-obj-mro x275 (&& "__iand__"))))
    (if (eq? magic_method489 py-absent)
        (py-ibitand:normal x275 y276)
        (letrec* ((result490 (py-call magic_method489 x275 y276)))
          (if (eq? result490 py-NotImplemented)
              (py-ibitand:normal x275 y276)
              result490)))))

(define (py-ibitand:normal x277 y278)
  (letrec* ((magic_method493 (getattribute-from-obj-mro x277 (&& "__and__"))))
    (if (eq? magic_method493 py-absent)
        (py-ibitand:reflected x277 y278)
        (letrec* ((result494 (py-call magic_method493 x277 y278)))
          (if (eq? result494 py-NotImplemented)
              (py-ibitand:reflected x277 y278)
              result494)))))

(define (py-ibitand:reflected x279 y280)
  (letrec* ((magic_method497 (getattribute-from-obj-mro y280 (&& "__rand__"))))
    (if (eq? magic_method497 py-absent)
        (py-ibitand:err x279 y280)
        (letrec* ((result498 (py-call magic_method497 y280 x279)))
          (if (eq? result498 py-NotImplemented)
              (py-ibitand:err x279 y280)
              result498)))))

(define (py-ibitand:err x281 y282)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for &: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x281)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y282)
                             (& "__name__")))
                    (&& "'")))))

(define-macro (py-ibitor x94 y95)
  `(let ((x94 ,x94) (y95 ,y95)) (py-ibitor:inplace x94 y95)))

(define (py-ibitor:inplace x283 y284)
  (letrec* ((magic_method501 (getattribute-from-obj-mro x283 (&& "__ior__"))))
    (if (eq? magic_method501 py-absent)
        (py-ibitor:normal x283 y284)
        (letrec* ((result502 (py-call magic_method501 x283 y284)))
          (if (eq? result502 py-NotImplemented)
              (py-ibitor:normal x283 y284)
              result502)))))

(define (py-ibitor:normal x285 y286)
  (letrec* ((magic_method505 (getattribute-from-obj-mro x285 (&& "__or__"))))
    (if (eq? magic_method505 py-absent)
        (py-ibitor:reflected x285 y286)
        (letrec* ((result506 (py-call magic_method505 x285 y286)))
          (if (eq? result506 py-NotImplemented)
              (py-ibitor:reflected x285 y286)
              result506)))))

(define (py-ibitor:reflected x287 y288)
  (letrec* ((magic_method509 (getattribute-from-obj-mro y288 (&& "__ror__"))))
    (if (eq? magic_method509 py-absent)
        (py-ibitor:err x287 y288)
        (letrec* ((result510 (py-call magic_method509 y288 x287)))
          (if (eq? result510 py-NotImplemented)
              (py-ibitor:err x287 y288)
              result510)))))

(define (py-ibitor:err x289 y290)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for |: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x289)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y290)
                             (& "__name__")))
                    (&& "'")))))

(define-macro (py-ifloordiv x101 y102)
  `(let ((x101 ,x101) (y102 ,y102)) (py-ifloordiv:inplace x101 y102)))

(define (py-ifloordiv:inplace x291 y292)
  (letrec* ((magic_method513
             (getattribute-from-obj-mro x291 (&& "__ifloordiv__"))))
    (if (eq? magic_method513 py-absent)
        (py-ifloordiv:normal x291 y292)
        (letrec* ((result514 (py-call magic_method513 x291 y292)))
          (if (eq? result514 py-NotImplemented)
              (py-ifloordiv:normal x291 y292)
              result514)))))

(define (py-ifloordiv:normal x293 y294)
  (letrec* ((magic_method517
             (getattribute-from-obj-mro x293 (&& "__floordiv__"))))
    (if (eq? magic_method517 py-absent)
        (py-ifloordiv:reflected x293 y294)
        (letrec* ((result518 (py-call magic_method517 x293 y294)))
          (if (eq? result518 py-NotImplemented)
              (py-ifloordiv:reflected x293 y294)
              result518)))))

(define (py-ifloordiv:reflected x295 y296)
  (letrec* ((magic_method521
             (getattribute-from-obj-mro y296 (&& "__rfloordiv__"))))
    (if (eq? magic_method521 py-absent)
        (py-ifloordiv:err x295 y296)
        (letrec* ((result522 (py-call magic_method521 y296 x295)))
          (if (eq? result522 py-NotImplemented)
              (py-ifloordiv:err x295 y296)
              result522)))))

(define (py-ifloordiv:err x297 y298)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for //: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x297)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y298)
                             (& "__name__")))
                    (&& "'")))))

(define-macro (py-ilshift x108 y109)
  `(let ((x108 ,x108) (y109 ,y109)) (py-ilshift:inplace x108 y109)))

(define (py-ilshift:inplace x299 y300)
  (letrec* ((magic_method525
             (getattribute-from-obj-mro x299 (&& "__ilshift__"))))
    (if (eq? magic_method525 py-absent)
        (py-ilshift:normal x299 y300)
        (letrec* ((result526 (py-call magic_method525 x299 y300)))
          (if (eq? result526 py-NotImplemented)
              (py-ilshift:normal x299 y300)
              result526)))))

(define (py-ilshift:normal x301 y302)
  (letrec* ((magic_method529
             (getattribute-from-obj-mro x301 (&& "__lshift__"))))
    (if (eq? magic_method529 py-absent)
        (py-ilshift:reflected x301 y302)
        (letrec* ((result530 (py-call magic_method529 x301 y302)))
          (if (eq? result530 py-NotImplemented)
              (py-ilshift:reflected x301 y302)
              result530)))))

(define (py-ilshift:reflected x303 y304)
  (letrec* ((magic_method533
             (getattribute-from-obj-mro y304 (&& "__rlshift__"))))
    (if (eq? magic_method533 py-absent)
        (py-ilshift:err x303 y304)
        (letrec* ((result534 (py-call magic_method533 y304 x303)))
          (if (eq? result534 py-NotImplemented)
              (py-ilshift:err x303 y304)
              result534)))))

(define (py-ilshift:err x305 y306)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for <<: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x305)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y306)
                             (& "__name__")))
                    (&& "'")))))

(define-macro (py-imatmul x115 y116)
  `(let ((x115 ,x115) (y116 ,y116)) (py-imatmul:inplace x115 y116)))

(define (py-imatmul:inplace x307 y308)
  (letrec* ((magic_method537
             (getattribute-from-obj-mro x307 (&& "__imatmul__"))))
    (if (eq? magic_method537 py-absent)
        (py-imatmul:normal x307 y308)
        (letrec* ((result538 (py-call magic_method537 x307 y308)))
          (if (eq? result538 py-NotImplemented)
              (py-imatmul:normal x307 y308)
              result538)))))

(define (py-imatmul:normal x309 y310)
  (letrec* ((magic_method541
             (getattribute-from-obj-mro x309 (&& "__matmul__"))))
    (if (eq? magic_method541 py-absent)
        (py-imatmul:reflected x309 y310)
        (letrec* ((result542 (py-call magic_method541 x309 y310)))
          (if (eq? result542 py-NotImplemented)
              (py-imatmul:reflected x309 y310)
              result542)))))

(define (py-imatmul:reflected x311 y312)
  (letrec* ((magic_method545
             (getattribute-from-obj-mro y312 (&& "__rmatmul__"))))
    (if (eq? magic_method545 py-absent)
        (py-imatmul:err x311 y312)
        (letrec* ((result546 (py-call magic_method545 y312 x311)))
          (if (eq? result546 py-NotImplemented)
              (py-imatmul:err x311 y312)
              result546)))))

(define (py-imatmul:err x313 y314)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for @: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x313)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y314)
                             (& "__name__")))
                    (&& "'")))))

(define-macro (py-imod x122 y123)
  `(let ((x122 ,x122) (y123 ,y123)) (py-imod:inplace x122 y123)))

(define (py-imod:inplace x315 y316)
  (letrec* ((magic_method549 (getattribute-from-obj-mro x315 (&& "__imod__"))))
    (if (eq? magic_method549 py-absent)
        (py-imod:normal x315 y316)
        (letrec* ((result550 (py-call magic_method549 x315 y316)))
          (if (eq? result550 py-NotImplemented)
              (py-imod:normal x315 y316)
              result550)))))

(define (py-imod:normal x317 y318)
  (letrec* ((magic_method553 (getattribute-from-obj-mro x317 (&& "__mod__"))))
    (if (eq? magic_method553 py-absent)
        (py-imod:reflected x317 y318)
        (letrec* ((result554 (py-call magic_method553 x317 y318)))
          (if (eq? result554 py-NotImplemented)
              (py-imod:reflected x317 y318)
              result554)))))

(define (py-imod:reflected x319 y320)
  (letrec* ((magic_method557 (getattribute-from-obj-mro y320 (&& "__rmod__"))))
    (if (eq? magic_method557 py-absent)
        (py-imod:err x319 y320)
        (letrec* ((result558 (py-call magic_method557 y320 x319)))
          (if (eq? result558 py-NotImplemented)
              (py-imod:err x319 y320)
              result558)))))

(define (py-imod:err x321 y322)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for %: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x321)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y322)
                             (& "__name__")))
                    (&& "'")))))

(define-macro (py-imul x129 y130)
  `(let ((x129 ,x129) (y130 ,y130)) (py-imul:inplace x129 y130)))

(define (py-imul:inplace x323 y324)
  (letrec* ((magic_method561 (getattribute-from-obj-mro x323 (&& "__imul__"))))
    (if (eq? magic_method561 py-absent)
        (py-imul:normal x323 y324)
        (letrec* ((result562 (py-call magic_method561 x323 y324)))
          (if (eq? result562 py-NotImplemented)
              (py-imul:normal x323 y324)
              result562)))))

(define (py-imul:normal x325 y326)
  (letrec* ((magic_method565 (getattribute-from-obj-mro x325 (&& "__mul__"))))
    (if (eq? magic_method565 py-absent)
        (py-imul:reflected x325 y326)
        (letrec* ((result566 (py-call magic_method565 x325 y326)))
          (if (eq? result566 py-NotImplemented)
              (py-imul:reflected x325 y326)
              result566)))))

(define (py-imul:reflected x327 y328)
  (letrec* ((magic_method569 (getattribute-from-obj-mro y328 (&& "__rmul__"))))
    (if (eq? magic_method569 py-absent)
        (py-imul:err x327 y328)
        (letrec* ((result570 (py-call magic_method569 y328 x327)))
          (if (eq? result570 py-NotImplemented)
              (py-imul:err x327 y328)
              result570)))))

(define (py-imul:err x329 y330)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for *: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x329)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y330)
                             (& "__name__")))
                    (&& "'")))))

(define-macro (py-ipow x136 y137)
  `(let ((x136 ,x136) (y137 ,y137)) (py-ipow:inplace x136 y137)))

(define (py-ipow:inplace x331 y332)
  (letrec* ((magic_method573 (getattribute-from-obj-mro x331 (&& "__ipow__"))))
    (if (eq? magic_method573 py-absent)
        (py-ipow:normal x331 y332)
        (letrec* ((result574 (py-call magic_method573 x331 y332)))
          (if (eq? result574 py-NotImplemented)
              (py-ipow:normal x331 y332)
              result574)))))

(define (py-ipow:normal x333 y334)
  (letrec* ((magic_method577 (getattribute-from-obj-mro x333 (&& "__pow__"))))
    (if (eq? magic_method577 py-absent)
        (py-ipow:reflected x333 y334)
        (letrec* ((result578 (py-call magic_method577 x333 y334)))
          (if (eq? result578 py-NotImplemented)
              (py-ipow:reflected x333 y334)
              result578)))))

(define (py-ipow:reflected x335 y336)
  (letrec* ((magic_method581 (getattribute-from-obj-mro y336 (&& "__rpow__"))))
    (if (eq? magic_method581 py-absent)
        (py-ipow:err x335 y336)
        (letrec* ((result582 (py-call magic_method581 y336 x335)))
          (if (eq? result582 py-NotImplemented)
              (py-ipow:err x335 y336)
              result582)))))

(define (py-ipow:err x337 y338)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for **: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x337)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y338)
                             (& "__name__")))
                    (&& "'")))))

(define-macro (py-irshift x143 y144)
  `(let ((x143 ,x143) (y144 ,y144)) (py-irshift:inplace x143 y144)))

(define (py-irshift:inplace x339 y340)
  (letrec* ((magic_method585
             (getattribute-from-obj-mro x339 (&& "__irshift__"))))
    (if (eq? magic_method585 py-absent)
        (py-irshift:normal x339 y340)
        (letrec* ((result586 (py-call magic_method585 x339 y340)))
          (if (eq? result586 py-NotImplemented)
              (py-irshift:normal x339 y340)
              result586)))))

(define (py-irshift:normal x341 y342)
  (letrec* ((magic_method589
             (getattribute-from-obj-mro x341 (&& "__rshift__"))))
    (if (eq? magic_method589 py-absent)
        (py-irshift:reflected x341 y342)
        (letrec* ((result590 (py-call magic_method589 x341 y342)))
          (if (eq? result590 py-NotImplemented)
              (py-irshift:reflected x341 y342)
              result590)))))

(define (py-irshift:reflected x343 y344)
  (letrec* ((magic_method593
             (getattribute-from-obj-mro y344 (&& "__rrshift__"))))
    (if (eq? magic_method593 py-absent)
        (py-irshift:err x343 y344)
        (letrec* ((result594 (py-call magic_method593 y344 x343)))
          (if (eq? result594 py-NotImplemented)
              (py-irshift:err x343 y344)
              result594)))))

(define (py-irshift:err x345 y346)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for >>: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x345)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y346)
                             (& "__name__")))
                    (&& "'")))))

(define-macro (py-isub x150 y151)
  `(let ((x150 ,x150) (y151 ,y151)) (py-isub:inplace x150 y151)))

(define (py-isub:inplace x347 y348)
  (letrec* ((magic_method597 (getattribute-from-obj-mro x347 (&& "__isub__"))))
    (if (eq? magic_method597 py-absent)
        (py-isub:normal x347 y348)
        (letrec* ((result598 (py-call magic_method597 x347 y348)))
          (if (eq? result598 py-NotImplemented)
              (py-isub:normal x347 y348)
              result598)))))

(define (py-isub:normal x349 y350)
  (letrec* ((magic_method601 (getattribute-from-obj-mro x349 (&& "__sub__"))))
    (if (eq? magic_method601 py-absent)
        (py-isub:reflected x349 y350)
        (letrec* ((result602 (py-call magic_method601 x349 y350)))
          (if (eq? result602 py-NotImplemented)
              (py-isub:reflected x349 y350)
              result602)))))

(define (py-isub:reflected x351 y352)
  (letrec* ((magic_method605 (getattribute-from-obj-mro y352 (&& "__rsub__"))))
    (if (eq? magic_method605 py-absent)
        (py-isub:err x351 y352)
        (letrec* ((result606 (py-call magic_method605 y352 x351)))
          (if (eq? result606 py-NotImplemented)
              (py-isub:err x351 y352)
              result606)))))

(define (py-isub:err x353 y354)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for -: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x353)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y354)
                             (& "__name__")))
                    (&& "'")))))

(define-macro (py-itruediv x157 y158)
  `(let ((x157 ,x157) (y158 ,y158)) (py-itruediv:inplace x157 y158)))

(define (py-itruediv:inplace x355 y356)
  (letrec* ((magic_method609
             (getattribute-from-obj-mro x355 (&& "__itruediv__"))))
    (if (eq? magic_method609 py-absent)
        (py-itruediv:normal x355 y356)
        (letrec* ((result610 (py-call magic_method609 x355 y356)))
          (if (eq? result610 py-NotImplemented)
              (py-itruediv:normal x355 y356)
              result610)))))

(define (py-itruediv:normal x357 y358)
  (letrec* ((magic_method613
             (getattribute-from-obj-mro x357 (&& "__truediv__"))))
    (if (eq? magic_method613 py-absent)
        (py-itruediv:reflected x357 y358)
        (letrec* ((result614 (py-call magic_method613 x357 y358)))
          (if (eq? result614 py-NotImplemented)
              (py-itruediv:reflected x357 y358)
              result614)))))

(define (py-itruediv:reflected x359 y360)
  (letrec* ((magic_method617
             (getattribute-from-obj-mro y360 (&& "__rtruediv__"))))
    (if (eq? magic_method617 py-absent)
        (py-itruediv:err x359 y360)
        (letrec* ((result618 (py-call magic_method617 y360 x359)))
          (if (eq? result618 py-NotImplemented)
              (py-itruediv:err x359 y360)
              result618)))))

(define (py-itruediv:err x361 y362)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for /: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x361)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y362)
                             (& "__name__")))
                    (&& "'")))))

(define-macro (py-ixor x164 y165)
  `(let ((x164 ,x164) (y165 ,y165)) (py-ixor:inplace x164 y165)))

(define (py-ixor:inplace x363 y364)
  (letrec* ((magic_method621 (getattribute-from-obj-mro x363 (&& "__ixor__"))))
    (if (eq? magic_method621 py-absent)
        (py-ixor:normal x363 y364)
        (letrec* ((result622 (py-call magic_method621 x363 y364)))
          (if (eq? result622 py-NotImplemented)
              (py-ixor:normal x363 y364)
              result622)))))

(define (py-ixor:normal x365 y366)
  (letrec* ((magic_method625 (getattribute-from-obj-mro x365 (&& "__xor__"))))
    (if (eq? magic_method625 py-absent)
        (py-ixor:reflected x365 y366)
        (letrec* ((result626 (py-call magic_method625 x365 y366)))
          (if (eq? result626 py-NotImplemented)
              (py-ixor:reflected x365 y366)
              result626)))))

(define (py-ixor:reflected x367 y368)
  (letrec* ((magic_method629 (getattribute-from-obj-mro y368 (&& "__rxor__"))))
    (if (eq? magic_method629 py-absent)
        (py-ixor:err x367 y368)
        (letrec* ((result630 (py-call magic_method629 y368 x367)))
          (if (eq? result630 py-NotImplemented)
              (py-ixor:err x367 y368)
              result630)))))

(define (py-ixor:err x369 y370)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for ^: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x369)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y370)
                             (& "__name__")))
                    (&& "'")))))

(define (py-getattribute obj171 attr172)
  (letrec* ((__getattribute__633
             (getattribute-from-obj-mro obj171 (&& "__getattribute__"))))
    (with-handler
     (lambda ($%exc_0)
       (cond ((py-isinstance? $%exc_0 py-builtin-AttributeError)
              (letrec* ((__getattr__634
                         (getattribute-from-obj-mro
                          obj171
                          (&& "__getattr__"))))
                (if (eq? __getattr__634 py-absent)
                    (py-throw $%exc_0)
                    (py-call __getattr__634 obj171 attr172))))
             (else (raise $%exc_0))))
     (py-call __getattribute__633 obj171 attr172))))

(define (py-getitem obj174 index175)
  (letrec* ((__getitem__636
             (getattribute-from-obj-mro obj174 (&& "__getitem__"))))
    (if (eq? __getitem__636 py-absent)
        (py-throw
         (py-call py-builtin-TypeError (&& "object is not subscriptable")))
        (py-call __getitem__636 obj174 index175))))

(define (py-setitem obj177 index178 value179)
  (letrec* ((__setitem__638
             (getattribute-from-obj-mro obj177 (&& "__setitem__"))))
    (if (eq? __setitem__638 py-absent)
        (py-throw
         (py-call py-builtin-TypeError
                  (&& "object does not support item assignment")))
        (py-call __setitem__638 obj177 index178 value179))))

(define (py-delitem obj181 index182)
  (letrec* ((__delitem__640
             (getattribute-from-obj-mro obj181 (&& "__delitem__"))))
    (if (eq? __delitem__640 py-absent)
        (py-throw
         (py-call py-builtin-TypeError
                  (&& "object does not support item deletion")))
        (py-call __delitem__640 obj181 index182))))

(define (py-enter obj184)
  (letrec* ((__enter__642 (getattribute-from-obj-mro obj184 (&& "__enter__"))))
    (if (eq? __enter__642 py-absent)
        (py-throw (py-call py-builtin-AttributeError (&& "__enter__")))
        (py-call __enter__642 obj184))))

(define (py-exit obj186 exc187)
  (letrec* ((__exit__645 (getattribute-from-obj-mro obj186 (&& "__exit__"))))
    (if (eq? __exit__645 py-absent)
        (py-throw (py-call py-builtin-AttributeError (&& "__exit__")))
        (if (eq? exc187 py-None)
            (py-call __exit__645 obj186 py-None py-None py-None)
            (letrec* ((exit_result646
                       (py-call __exit__645
                                obj186
                                (py-call py-builtin-type exc187)
                                exc187
                                py-None)))
              (if (py-test exit_result646) py-None (py-throw exc187)))))))

