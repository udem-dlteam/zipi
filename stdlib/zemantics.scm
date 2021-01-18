(define-macro (py-add-fallback x2 y3)
  `(let ((x2 ,x2) (y3 ,y3)) (py-add-fallback:normal x2 y3)))

(define (py-add-fallback:normal x189 y190)
  (letrec* ((magic_method373 (getattribute-from-obj-mro x189 (&& "__add__"))))
    (if (py-test-is magic_method373 py-absent)
        (py-add-fallback:reflected x189 y190)
        (letrec* ((result374 (py-call magic_method373 x189 y190)))
          (if (py-test-is result374 py-NotImplemented)
              (py-add-fallback:reflected x189 y190)
              result374)))))

(define (py-add-fallback:reflected x191 y192)
  (letrec* ((magic_method377 (getattribute-from-obj-mro y192 (&& "__radd__"))))
    (if (py-test-is magic_method377 py-absent)
        (py-add-fallback:err x191 y192)
        (letrec* ((result378 (py-call magic_method377 y192 x191)))
          (if (py-test-is result378 py-NotImplemented)
              (py-add-fallback:err x191 y192)
              result378)))))

(define (py-add-fallback:err x193 y194)
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

(define-macro (py-bitand-fallback x8 y9)
  `(let ((x8 ,x8) (y9 ,y9)) (py-bitand-fallback:normal x8 y9)))

(define (py-bitand-fallback:normal x195 y196)
  (letrec* ((magic_method381 (getattribute-from-obj-mro x195 (&& "__and__"))))
    (if (py-test-is magic_method381 py-absent)
        (py-bitand-fallback:reflected x195 y196)
        (letrec* ((result382 (py-call magic_method381 x195 y196)))
          (if (py-test-is result382 py-NotImplemented)
              (py-bitand-fallback:reflected x195 y196)
              result382)))))

(define (py-bitand-fallback:reflected x197 y198)
  (letrec* ((magic_method385 (getattribute-from-obj-mro y198 (&& "__rand__"))))
    (if (py-test-is magic_method385 py-absent)
        (py-bitand-fallback:err x197 y198)
        (letrec* ((result386 (py-call magic_method385 y198 x197)))
          (if (py-test-is result386 py-NotImplemented)
              (py-bitand-fallback:err x197 y198)
              result386)))))

(define (py-bitand-fallback:err x199 y200)
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

(define-macro (py-bitor-fallback x14 y15)
  `(let ((x14 ,x14) (y15 ,y15)) (py-bitor-fallback:normal x14 y15)))

(define (py-bitor-fallback:normal x201 y202)
  (letrec* ((magic_method389 (getattribute-from-obj-mro x201 (&& "__or__"))))
    (if (py-test-is magic_method389 py-absent)
        (py-bitor-fallback:reflected x201 y202)
        (letrec* ((result390 (py-call magic_method389 x201 y202)))
          (if (py-test-is result390 py-NotImplemented)
              (py-bitor-fallback:reflected x201 y202)
              result390)))))

(define (py-bitor-fallback:reflected x203 y204)
  (letrec* ((magic_method393 (getattribute-from-obj-mro y204 (&& "__ror__"))))
    (if (py-test-is magic_method393 py-absent)
        (py-bitor-fallback:err x203 y204)
        (letrec* ((result394 (py-call magic_method393 y204 x203)))
          (if (py-test-is result394 py-NotImplemented)
              (py-bitor-fallback:err x203 y204)
              result394)))))

(define (py-bitor-fallback:err x205 y206)
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

(define-macro (py-floordiv-fallback x20 y21)
  `(let ((x20 ,x20) (y21 ,y21)) (py-floordiv-fallback:normal x20 y21)))

(define (py-floordiv-fallback:normal x207 y208)
  (letrec* ((magic_method397
             (getattribute-from-obj-mro x207 (&& "__floordiv__"))))
    (if (py-test-is magic_method397 py-absent)
        (py-floordiv-fallback:reflected x207 y208)
        (letrec* ((result398 (py-call magic_method397 x207 y208)))
          (if (py-test-is result398 py-NotImplemented)
              (py-floordiv-fallback:reflected x207 y208)
              result398)))))

(define (py-floordiv-fallback:reflected x209 y210)
  (letrec* ((magic_method401
             (getattribute-from-obj-mro y210 (&& "__rfloordiv__"))))
    (if (py-test-is magic_method401 py-absent)
        (py-floordiv-fallback:err x209 y210)
        (letrec* ((result402 (py-call magic_method401 y210 x209)))
          (if (py-test-is result402 py-NotImplemented)
              (py-floordiv-fallback:err x209 y210)
              result402)))))

(define (py-floordiv-fallback:err x211 y212)
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

(define-macro (py-lshift-fallback x26 y27)
  `(let ((x26 ,x26) (y27 ,y27)) (py-lshift-fallback:normal x26 y27)))

(define (py-lshift-fallback:normal x213 y214)
  (letrec* ((magic_method405
             (getattribute-from-obj-mro x213 (&& "__lshift__"))))
    (if (py-test-is magic_method405 py-absent)
        (py-lshift-fallback:reflected x213 y214)
        (letrec* ((result406 (py-call magic_method405 x213 y214)))
          (if (py-test-is result406 py-NotImplemented)
              (py-lshift-fallback:reflected x213 y214)
              result406)))))

(define (py-lshift-fallback:reflected x215 y216)
  (letrec* ((magic_method409
             (getattribute-from-obj-mro y216 (&& "__rlshift__"))))
    (if (py-test-is magic_method409 py-absent)
        (py-lshift-fallback:err x215 y216)
        (letrec* ((result410 (py-call magic_method409 y216 x215)))
          (if (py-test-is result410 py-NotImplemented)
              (py-lshift-fallback:err x215 y216)
              result410)))))

(define (py-lshift-fallback:err x217 y218)
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

(define-macro (py-matmul-fallback x32 y33)
  `(let ((x32 ,x32) (y33 ,y33)) (py-matmul-fallback:normal x32 y33)))

(define (py-matmul-fallback:normal x219 y220)
  (letrec* ((magic_method413
             (getattribute-from-obj-mro x219 (&& "__matmul__"))))
    (if (py-test-is magic_method413 py-absent)
        (py-matmul-fallback:reflected x219 y220)
        (letrec* ((result414 (py-call magic_method413 x219 y220)))
          (if (py-test-is result414 py-NotImplemented)
              (py-matmul-fallback:reflected x219 y220)
              result414)))))

(define (py-matmul-fallback:reflected x221 y222)
  (letrec* ((magic_method417
             (getattribute-from-obj-mro y222 (&& "__rmatmul__"))))
    (if (py-test-is magic_method417 py-absent)
        (py-matmul-fallback:err x221 y222)
        (letrec* ((result418 (py-call magic_method417 y222 x221)))
          (if (py-test-is result418 py-NotImplemented)
              (py-matmul-fallback:err x221 y222)
              result418)))))

(define (py-matmul-fallback:err x223 y224)
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

(define-macro (py-mod-fallback x38 y39)
  `(let ((x38 ,x38) (y39 ,y39)) (py-mod-fallback:normal x38 y39)))

(define (py-mod-fallback:normal x225 y226)
  (letrec* ((magic_method421 (getattribute-from-obj-mro x225 (&& "__mod__"))))
    (if (py-test-is magic_method421 py-absent)
        (py-mod-fallback:reflected x225 y226)
        (letrec* ((result422 (py-call magic_method421 x225 y226)))
          (if (py-test-is result422 py-NotImplemented)
              (py-mod-fallback:reflected x225 y226)
              result422)))))

(define (py-mod-fallback:reflected x227 y228)
  (letrec* ((magic_method425 (getattribute-from-obj-mro y228 (&& "__rmod__"))))
    (if (py-test-is magic_method425 py-absent)
        (py-mod-fallback:err x227 y228)
        (letrec* ((result426 (py-call magic_method425 y228 x227)))
          (if (py-test-is result426 py-NotImplemented)
              (py-mod-fallback:err x227 y228)
              result426)))))

(define (py-mod-fallback:err x229 y230)
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

(define-macro (py-mul-fallback x44 y45)
  `(let ((x44 ,x44) (y45 ,y45)) (py-mul-fallback:normal x44 y45)))

(define (py-mul-fallback:normal x231 y232)
  (letrec* ((magic_method429 (getattribute-from-obj-mro x231 (&& "__mul__"))))
    (if (py-test-is magic_method429 py-absent)
        (py-mul-fallback:reflected x231 y232)
        (letrec* ((result430 (py-call magic_method429 x231 y232)))
          (if (py-test-is result430 py-NotImplemented)
              (py-mul-fallback:reflected x231 y232)
              result430)))))

(define (py-mul-fallback:reflected x233 y234)
  (letrec* ((magic_method433 (getattribute-from-obj-mro y234 (&& "__rmul__"))))
    (if (py-test-is magic_method433 py-absent)
        (py-mul-fallback:err x233 y234)
        (letrec* ((result434 (py-call magic_method433 y234 x233)))
          (if (py-test-is result434 py-NotImplemented)
              (py-mul-fallback:err x233 y234)
              result434)))))

(define (py-mul-fallback:err x235 y236)
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

(define-macro (py-pow-fallback x50 y51)
  `(let ((x50 ,x50) (y51 ,y51)) (py-pow-fallback:normal x50 y51)))

(define (py-pow-fallback:normal x237 y238)
  (letrec* ((magic_method437 (getattribute-from-obj-mro x237 (&& "__pow__"))))
    (if (py-test-is magic_method437 py-absent)
        (py-pow-fallback:reflected x237 y238)
        (letrec* ((result438 (py-call magic_method437 x237 y238)))
          (if (py-test-is result438 py-NotImplemented)
              (py-pow-fallback:reflected x237 y238)
              result438)))))

(define (py-pow-fallback:reflected x239 y240)
  (letrec* ((magic_method441 (getattribute-from-obj-mro y240 (&& "__rpow__"))))
    (if (py-test-is magic_method441 py-absent)
        (py-pow-fallback:err x239 y240)
        (letrec* ((result442 (py-call magic_method441 y240 x239)))
          (if (py-test-is result442 py-NotImplemented)
              (py-pow-fallback:err x239 y240)
              result442)))))

(define (py-pow-fallback:err x241 y242)
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

(define-macro (py-rshift-fallback x56 y57)
  `(let ((x56 ,x56) (y57 ,y57)) (py-rshift-fallback:normal x56 y57)))

(define (py-rshift-fallback:normal x243 y244)
  (letrec* ((magic_method445
             (getattribute-from-obj-mro x243 (&& "__rshift__"))))
    (if (py-test-is magic_method445 py-absent)
        (py-rshift-fallback:reflected x243 y244)
        (letrec* ((result446 (py-call magic_method445 x243 y244)))
          (if (py-test-is result446 py-NotImplemented)
              (py-rshift-fallback:reflected x243 y244)
              result446)))))

(define (py-rshift-fallback:reflected x245 y246)
  (letrec* ((magic_method449
             (getattribute-from-obj-mro y246 (&& "__rrshift__"))))
    (if (py-test-is magic_method449 py-absent)
        (py-rshift-fallback:err x245 y246)
        (letrec* ((result450 (py-call magic_method449 y246 x245)))
          (if (py-test-is result450 py-NotImplemented)
              (py-rshift-fallback:err x245 y246)
              result450)))))

(define (py-rshift-fallback:err x247 y248)
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

(define-macro (py-sub-fallback x62 y63)
  `(let ((x62 ,x62) (y63 ,y63)) (py-sub-fallback:normal x62 y63)))

(define (py-sub-fallback:normal x249 y250)
  (letrec* ((magic_method453 (getattribute-from-obj-mro x249 (&& "__sub__"))))
    (if (py-test-is magic_method453 py-absent)
        (py-sub-fallback:reflected x249 y250)
        (letrec* ((result454 (py-call magic_method453 x249 y250)))
          (if (py-test-is result454 py-NotImplemented)
              (py-sub-fallback:reflected x249 y250)
              result454)))))

(define (py-sub-fallback:reflected x251 y252)
  (letrec* ((magic_method457 (getattribute-from-obj-mro y252 (&& "__rsub__"))))
    (if (py-test-is magic_method457 py-absent)
        (py-sub-fallback:err x251 y252)
        (letrec* ((result458 (py-call magic_method457 y252 x251)))
          (if (py-test-is result458 py-NotImplemented)
              (py-sub-fallback:err x251 y252)
              result458)))))

(define (py-sub-fallback:err x253 y254)
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

(define-macro (py-truediv-fallback x68 y69)
  `(let ((x68 ,x68) (y69 ,y69)) (py-truediv-fallback:normal x68 y69)))

(define (py-truediv-fallback:normal x255 y256)
  (letrec* ((magic_method461
             (getattribute-from-obj-mro x255 (&& "__truediv__"))))
    (if (py-test-is magic_method461 py-absent)
        (py-truediv-fallback:reflected x255 y256)
        (letrec* ((result462 (py-call magic_method461 x255 y256)))
          (if (py-test-is result462 py-NotImplemented)
              (py-truediv-fallback:reflected x255 y256)
              result462)))))

(define (py-truediv-fallback:reflected x257 y258)
  (letrec* ((magic_method465
             (getattribute-from-obj-mro y258 (&& "__rtruediv__"))))
    (if (py-test-is magic_method465 py-absent)
        (py-truediv-fallback:err x257 y258)
        (letrec* ((result466 (py-call magic_method465 y258 x257)))
          (if (py-test-is result466 py-NotImplemented)
              (py-truediv-fallback:err x257 y258)
              result466)))))

(define (py-truediv-fallback:err x259 y260)
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

(define-macro (py-xor-fallback x74 y75)
  `(let ((x74 ,x74) (y75 ,y75)) (py-xor-fallback:normal x74 y75)))

(define (py-xor-fallback:normal x261 y262)
  (letrec* ((magic_method469 (getattribute-from-obj-mro x261 (&& "__xor__"))))
    (if (py-test-is magic_method469 py-absent)
        (py-xor-fallback:reflected x261 y262)
        (letrec* ((result470 (py-call magic_method469 x261 y262)))
          (if (py-test-is result470 py-NotImplemented)
              (py-xor-fallback:reflected x261 y262)
              result470)))))

(define (py-xor-fallback:reflected x263 y264)
  (letrec* ((magic_method473 (getattribute-from-obj-mro y264 (&& "__rxor__"))))
    (if (py-test-is magic_method473 py-absent)
        (py-xor-fallback:err x263 y264)
        (letrec* ((result474 (py-call magic_method473 y264 x263)))
          (if (py-test-is result474 py-NotImplemented)
              (py-xor-fallback:err x263 y264)
              result474)))))

(define (py-xor-fallback:err x265 y266)
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

(define-macro (py-iadd-fallback x80 y81)
  `(let ((x80 ,x80) (y81 ,y81)) (py-iadd-fallback:inplace x80 y81)))

(define (py-iadd-fallback:inplace x267 y268)
  (letrec* ((magic_method477 (getattribute-from-obj-mro x267 (&& "__iadd__"))))
    (if (py-test-is magic_method477 py-absent)
        (py-iadd-fallback:normal x267 y268)
        (letrec* ((result478 (py-call magic_method477 x267 y268)))
          (if (py-test-is result478 py-NotImplemented)
              (py-iadd-fallback:normal x267 y268)
              result478)))))

(define (py-iadd-fallback:normal x269 y270)
  (letrec* ((magic_method481 (getattribute-from-obj-mro x269 (&& "__add__"))))
    (if (py-test-is magic_method481 py-absent)
        (py-iadd-fallback:reflected x269 y270)
        (letrec* ((result482 (py-call magic_method481 x269 y270)))
          (if (py-test-is result482 py-NotImplemented)
              (py-iadd-fallback:reflected x269 y270)
              result482)))))

(define (py-iadd-fallback:reflected x271 y272)
  (letrec* ((magic_method485 (getattribute-from-obj-mro y272 (&& "__radd__"))))
    (if (py-test-is magic_method485 py-absent)
        (py-iadd-fallback:err x271 y272)
        (letrec* ((result486 (py-call magic_method485 y272 x271)))
          (if (py-test-is result486 py-NotImplemented)
              (py-iadd-fallback:err x271 y272)
              result486)))))

(define (py-iadd-fallback:err x273 y274)
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

(define-macro (py-ibitand-fallback x87 y88)
  `(let ((x87 ,x87) (y88 ,y88)) (py-ibitand-fallback:inplace x87 y88)))

(define (py-ibitand-fallback:inplace x275 y276)
  (letrec* ((magic_method489 (getattribute-from-obj-mro x275 (&& "__iand__"))))
    (if (py-test-is magic_method489 py-absent)
        (py-ibitand-fallback:normal x275 y276)
        (letrec* ((result490 (py-call magic_method489 x275 y276)))
          (if (py-test-is result490 py-NotImplemented)
              (py-ibitand-fallback:normal x275 y276)
              result490)))))

(define (py-ibitand-fallback:normal x277 y278)
  (letrec* ((magic_method493 (getattribute-from-obj-mro x277 (&& "__and__"))))
    (if (py-test-is magic_method493 py-absent)
        (py-ibitand-fallback:reflected x277 y278)
        (letrec* ((result494 (py-call magic_method493 x277 y278)))
          (if (py-test-is result494 py-NotImplemented)
              (py-ibitand-fallback:reflected x277 y278)
              result494)))))

(define (py-ibitand-fallback:reflected x279 y280)
  (letrec* ((magic_method497 (getattribute-from-obj-mro y280 (&& "__rand__"))))
    (if (py-test-is magic_method497 py-absent)
        (py-ibitand-fallback:err x279 y280)
        (letrec* ((result498 (py-call magic_method497 y280 x279)))
          (if (py-test-is result498 py-NotImplemented)
              (py-ibitand-fallback:err x279 y280)
              result498)))))

(define (py-ibitand-fallback:err x281 y282)
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

(define-macro (py-ibitor-fallback x94 y95)
  `(let ((x94 ,x94) (y95 ,y95)) (py-ibitor-fallback:inplace x94 y95)))

(define (py-ibitor-fallback:inplace x283 y284)
  (letrec* ((magic_method501 (getattribute-from-obj-mro x283 (&& "__ior__"))))
    (if (py-test-is magic_method501 py-absent)
        (py-ibitor-fallback:normal x283 y284)
        (letrec* ((result502 (py-call magic_method501 x283 y284)))
          (if (py-test-is result502 py-NotImplemented)
              (py-ibitor-fallback:normal x283 y284)
              result502)))))

(define (py-ibitor-fallback:normal x285 y286)
  (letrec* ((magic_method505 (getattribute-from-obj-mro x285 (&& "__or__"))))
    (if (py-test-is magic_method505 py-absent)
        (py-ibitor-fallback:reflected x285 y286)
        (letrec* ((result506 (py-call magic_method505 x285 y286)))
          (if (py-test-is result506 py-NotImplemented)
              (py-ibitor-fallback:reflected x285 y286)
              result506)))))

(define (py-ibitor-fallback:reflected x287 y288)
  (letrec* ((magic_method509 (getattribute-from-obj-mro y288 (&& "__ror__"))))
    (if (py-test-is magic_method509 py-absent)
        (py-ibitor-fallback:err x287 y288)
        (letrec* ((result510 (py-call magic_method509 y288 x287)))
          (if (py-test-is result510 py-NotImplemented)
              (py-ibitor-fallback:err x287 y288)
              result510)))))

(define (py-ibitor-fallback:err x289 y290)
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

(define-macro (py-ifloordiv-fallback x101 y102)
  `(let ((x101 ,x101) (y102 ,y102)) (py-ifloordiv-fallback:inplace x101 y102)))

(define (py-ifloordiv-fallback:inplace x291 y292)
  (letrec* ((magic_method513
             (getattribute-from-obj-mro x291 (&& "__ifloordiv__"))))
    (if (py-test-is magic_method513 py-absent)
        (py-ifloordiv-fallback:normal x291 y292)
        (letrec* ((result514 (py-call magic_method513 x291 y292)))
          (if (py-test-is result514 py-NotImplemented)
              (py-ifloordiv-fallback:normal x291 y292)
              result514)))))

(define (py-ifloordiv-fallback:normal x293 y294)
  (letrec* ((magic_method517
             (getattribute-from-obj-mro x293 (&& "__floordiv__"))))
    (if (py-test-is magic_method517 py-absent)
        (py-ifloordiv-fallback:reflected x293 y294)
        (letrec* ((result518 (py-call magic_method517 x293 y294)))
          (if (py-test-is result518 py-NotImplemented)
              (py-ifloordiv-fallback:reflected x293 y294)
              result518)))))

(define (py-ifloordiv-fallback:reflected x295 y296)
  (letrec* ((magic_method521
             (getattribute-from-obj-mro y296 (&& "__rfloordiv__"))))
    (if (py-test-is magic_method521 py-absent)
        (py-ifloordiv-fallback:err x295 y296)
        (letrec* ((result522 (py-call magic_method521 y296 x295)))
          (if (py-test-is result522 py-NotImplemented)
              (py-ifloordiv-fallback:err x295 y296)
              result522)))))

(define (py-ifloordiv-fallback:err x297 y298)
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

(define-macro (py-ilshift-fallback x108 y109)
  `(let ((x108 ,x108) (y109 ,y109)) (py-ilshift-fallback:inplace x108 y109)))

(define (py-ilshift-fallback:inplace x299 y300)
  (letrec* ((magic_method525
             (getattribute-from-obj-mro x299 (&& "__ilshift__"))))
    (if (py-test-is magic_method525 py-absent)
        (py-ilshift-fallback:normal x299 y300)
        (letrec* ((result526 (py-call magic_method525 x299 y300)))
          (if (py-test-is result526 py-NotImplemented)
              (py-ilshift-fallback:normal x299 y300)
              result526)))))

(define (py-ilshift-fallback:normal x301 y302)
  (letrec* ((magic_method529
             (getattribute-from-obj-mro x301 (&& "__lshift__"))))
    (if (py-test-is magic_method529 py-absent)
        (py-ilshift-fallback:reflected x301 y302)
        (letrec* ((result530 (py-call magic_method529 x301 y302)))
          (if (py-test-is result530 py-NotImplemented)
              (py-ilshift-fallback:reflected x301 y302)
              result530)))))

(define (py-ilshift-fallback:reflected x303 y304)
  (letrec* ((magic_method533
             (getattribute-from-obj-mro y304 (&& "__rlshift__"))))
    (if (py-test-is magic_method533 py-absent)
        (py-ilshift-fallback:err x303 y304)
        (letrec* ((result534 (py-call magic_method533 y304 x303)))
          (if (py-test-is result534 py-NotImplemented)
              (py-ilshift-fallback:err x303 y304)
              result534)))))

(define (py-ilshift-fallback:err x305 y306)
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

(define-macro (py-imatmul-fallback x115 y116)
  `(let ((x115 ,x115) (y116 ,y116)) (py-imatmul-fallback:inplace x115 y116)))

(define (py-imatmul-fallback:inplace x307 y308)
  (letrec* ((magic_method537
             (getattribute-from-obj-mro x307 (&& "__imatmul__"))))
    (if (py-test-is magic_method537 py-absent)
        (py-imatmul-fallback:normal x307 y308)
        (letrec* ((result538 (py-call magic_method537 x307 y308)))
          (if (py-test-is result538 py-NotImplemented)
              (py-imatmul-fallback:normal x307 y308)
              result538)))))

(define (py-imatmul-fallback:normal x309 y310)
  (letrec* ((magic_method541
             (getattribute-from-obj-mro x309 (&& "__matmul__"))))
    (if (py-test-is magic_method541 py-absent)
        (py-imatmul-fallback:reflected x309 y310)
        (letrec* ((result542 (py-call magic_method541 x309 y310)))
          (if (py-test-is result542 py-NotImplemented)
              (py-imatmul-fallback:reflected x309 y310)
              result542)))))

(define (py-imatmul-fallback:reflected x311 y312)
  (letrec* ((magic_method545
             (getattribute-from-obj-mro y312 (&& "__rmatmul__"))))
    (if (py-test-is magic_method545 py-absent)
        (py-imatmul-fallback:err x311 y312)
        (letrec* ((result546 (py-call magic_method545 y312 x311)))
          (if (py-test-is result546 py-NotImplemented)
              (py-imatmul-fallback:err x311 y312)
              result546)))))

(define (py-imatmul-fallback:err x313 y314)
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

(define-macro (py-imod-fallback x122 y123)
  `(let ((x122 ,x122) (y123 ,y123)) (py-imod-fallback:inplace x122 y123)))

(define (py-imod-fallback:inplace x315 y316)
  (letrec* ((magic_method549 (getattribute-from-obj-mro x315 (&& "__imod__"))))
    (if (py-test-is magic_method549 py-absent)
        (py-imod-fallback:normal x315 y316)
        (letrec* ((result550 (py-call magic_method549 x315 y316)))
          (if (py-test-is result550 py-NotImplemented)
              (py-imod-fallback:normal x315 y316)
              result550)))))

(define (py-imod-fallback:normal x317 y318)
  (letrec* ((magic_method553 (getattribute-from-obj-mro x317 (&& "__mod__"))))
    (if (py-test-is magic_method553 py-absent)
        (py-imod-fallback:reflected x317 y318)
        (letrec* ((result554 (py-call magic_method553 x317 y318)))
          (if (py-test-is result554 py-NotImplemented)
              (py-imod-fallback:reflected x317 y318)
              result554)))))

(define (py-imod-fallback:reflected x319 y320)
  (letrec* ((magic_method557 (getattribute-from-obj-mro y320 (&& "__rmod__"))))
    (if (py-test-is magic_method557 py-absent)
        (py-imod-fallback:err x319 y320)
        (letrec* ((result558 (py-call magic_method557 y320 x319)))
          (if (py-test-is result558 py-NotImplemented)
              (py-imod-fallback:err x319 y320)
              result558)))))

(define (py-imod-fallback:err x321 y322)
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

(define-macro (py-imul-fallback x129 y130)
  `(let ((x129 ,x129) (y130 ,y130)) (py-imul-fallback:inplace x129 y130)))

(define (py-imul-fallback:inplace x323 y324)
  (letrec* ((magic_method561 (getattribute-from-obj-mro x323 (&& "__imul__"))))
    (if (py-test-is magic_method561 py-absent)
        (py-imul-fallback:normal x323 y324)
        (letrec* ((result562 (py-call magic_method561 x323 y324)))
          (if (py-test-is result562 py-NotImplemented)
              (py-imul-fallback:normal x323 y324)
              result562)))))

(define (py-imul-fallback:normal x325 y326)
  (letrec* ((magic_method565 (getattribute-from-obj-mro x325 (&& "__mul__"))))
    (if (py-test-is magic_method565 py-absent)
        (py-imul-fallback:reflected x325 y326)
        (letrec* ((result566 (py-call magic_method565 x325 y326)))
          (if (py-test-is result566 py-NotImplemented)
              (py-imul-fallback:reflected x325 y326)
              result566)))))

(define (py-imul-fallback:reflected x327 y328)
  (letrec* ((magic_method569 (getattribute-from-obj-mro y328 (&& "__rmul__"))))
    (if (py-test-is magic_method569 py-absent)
        (py-imul-fallback:err x327 y328)
        (letrec* ((result570 (py-call magic_method569 y328 x327)))
          (if (py-test-is result570 py-NotImplemented)
              (py-imul-fallback:err x327 y328)
              result570)))))

(define (py-imul-fallback:err x329 y330)
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

(define-macro (py-ipow-fallback x136 y137)
  `(let ((x136 ,x136) (y137 ,y137)) (py-ipow-fallback:inplace x136 y137)))

(define (py-ipow-fallback:inplace x331 y332)
  (letrec* ((magic_method573 (getattribute-from-obj-mro x331 (&& "__ipow__"))))
    (if (py-test-is magic_method573 py-absent)
        (py-ipow-fallback:normal x331 y332)
        (letrec* ((result574 (py-call magic_method573 x331 y332)))
          (if (py-test-is result574 py-NotImplemented)
              (py-ipow-fallback:normal x331 y332)
              result574)))))

(define (py-ipow-fallback:normal x333 y334)
  (letrec* ((magic_method577 (getattribute-from-obj-mro x333 (&& "__pow__"))))
    (if (py-test-is magic_method577 py-absent)
        (py-ipow-fallback:reflected x333 y334)
        (letrec* ((result578 (py-call magic_method577 x333 y334)))
          (if (py-test-is result578 py-NotImplemented)
              (py-ipow-fallback:reflected x333 y334)
              result578)))))

(define (py-ipow-fallback:reflected x335 y336)
  (letrec* ((magic_method581 (getattribute-from-obj-mro y336 (&& "__rpow__"))))
    (if (py-test-is magic_method581 py-absent)
        (py-ipow-fallback:err x335 y336)
        (letrec* ((result582 (py-call magic_method581 y336 x335)))
          (if (py-test-is result582 py-NotImplemented)
              (py-ipow-fallback:err x335 y336)
              result582)))))

(define (py-ipow-fallback:err x337 y338)
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

(define-macro (py-irshift-fallback x143 y144)
  `(let ((x143 ,x143) (y144 ,y144)) (py-irshift-fallback:inplace x143 y144)))

(define (py-irshift-fallback:inplace x339 y340)
  (letrec* ((magic_method585
             (getattribute-from-obj-mro x339 (&& "__irshift__"))))
    (if (py-test-is magic_method585 py-absent)
        (py-irshift-fallback:normal x339 y340)
        (letrec* ((result586 (py-call magic_method585 x339 y340)))
          (if (py-test-is result586 py-NotImplemented)
              (py-irshift-fallback:normal x339 y340)
              result586)))))

(define (py-irshift-fallback:normal x341 y342)
  (letrec* ((magic_method589
             (getattribute-from-obj-mro x341 (&& "__rshift__"))))
    (if (py-test-is magic_method589 py-absent)
        (py-irshift-fallback:reflected x341 y342)
        (letrec* ((result590 (py-call magic_method589 x341 y342)))
          (if (py-test-is result590 py-NotImplemented)
              (py-irshift-fallback:reflected x341 y342)
              result590)))))

(define (py-irshift-fallback:reflected x343 y344)
  (letrec* ((magic_method593
             (getattribute-from-obj-mro y344 (&& "__rrshift__"))))
    (if (py-test-is magic_method593 py-absent)
        (py-irshift-fallback:err x343 y344)
        (letrec* ((result594 (py-call magic_method593 y344 x343)))
          (if (py-test-is result594 py-NotImplemented)
              (py-irshift-fallback:err x343 y344)
              result594)))))

(define (py-irshift-fallback:err x345 y346)
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

(define-macro (py-isub-fallback x150 y151)
  `(let ((x150 ,x150) (y151 ,y151)) (py-isub-fallback:inplace x150 y151)))

(define (py-isub-fallback:inplace x347 y348)
  (letrec* ((magic_method597 (getattribute-from-obj-mro x347 (&& "__isub__"))))
    (if (py-test-is magic_method597 py-absent)
        (py-isub-fallback:normal x347 y348)
        (letrec* ((result598 (py-call magic_method597 x347 y348)))
          (if (py-test-is result598 py-NotImplemented)
              (py-isub-fallback:normal x347 y348)
              result598)))))

(define (py-isub-fallback:normal x349 y350)
  (letrec* ((magic_method601 (getattribute-from-obj-mro x349 (&& "__sub__"))))
    (if (py-test-is magic_method601 py-absent)
        (py-isub-fallback:reflected x349 y350)
        (letrec* ((result602 (py-call magic_method601 x349 y350)))
          (if (py-test-is result602 py-NotImplemented)
              (py-isub-fallback:reflected x349 y350)
              result602)))))

(define (py-isub-fallback:reflected x351 y352)
  (letrec* ((magic_method605 (getattribute-from-obj-mro y352 (&& "__rsub__"))))
    (if (py-test-is magic_method605 py-absent)
        (py-isub-fallback:err x351 y352)
        (letrec* ((result606 (py-call magic_method605 y352 x351)))
          (if (py-test-is result606 py-NotImplemented)
              (py-isub-fallback:err x351 y352)
              result606)))))

(define (py-isub-fallback:err x353 y354)
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

(define-macro (py-itruediv-fallback x157 y158)
  `(let ((x157 ,x157) (y158 ,y158)) (py-itruediv-fallback:inplace x157 y158)))

(define (py-itruediv-fallback:inplace x355 y356)
  (letrec* ((magic_method609
             (getattribute-from-obj-mro x355 (&& "__itruediv__"))))
    (if (py-test-is magic_method609 py-absent)
        (py-itruediv-fallback:normal x355 y356)
        (letrec* ((result610 (py-call magic_method609 x355 y356)))
          (if (py-test-is result610 py-NotImplemented)
              (py-itruediv-fallback:normal x355 y356)
              result610)))))

(define (py-itruediv-fallback:normal x357 y358)
  (letrec* ((magic_method613
             (getattribute-from-obj-mro x357 (&& "__truediv__"))))
    (if (py-test-is magic_method613 py-absent)
        (py-itruediv-fallback:reflected x357 y358)
        (letrec* ((result614 (py-call magic_method613 x357 y358)))
          (if (py-test-is result614 py-NotImplemented)
              (py-itruediv-fallback:reflected x357 y358)
              result614)))))

(define (py-itruediv-fallback:reflected x359 y360)
  (letrec* ((magic_method617
             (getattribute-from-obj-mro y360 (&& "__rtruediv__"))))
    (if (py-test-is magic_method617 py-absent)
        (py-itruediv-fallback:err x359 y360)
        (letrec* ((result618 (py-call magic_method617 y360 x359)))
          (if (py-test-is result618 py-NotImplemented)
              (py-itruediv-fallback:err x359 y360)
              result618)))))

(define (py-itruediv-fallback:err x361 y362)
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

(define-macro (py-ixor-fallback x164 y165)
  `(let ((x164 ,x164) (y165 ,y165)) (py-ixor-fallback:inplace x164 y165)))

(define (py-ixor-fallback:inplace x363 y364)
  (letrec* ((magic_method621 (getattribute-from-obj-mro x363 (&& "__ixor__"))))
    (if (py-test-is magic_method621 py-absent)
        (py-ixor-fallback:normal x363 y364)
        (letrec* ((result622 (py-call magic_method621 x363 y364)))
          (if (py-test-is result622 py-NotImplemented)
              (py-ixor-fallback:normal x363 y364)
              result622)))))

(define (py-ixor-fallback:normal x365 y366)
  (letrec* ((magic_method625 (getattribute-from-obj-mro x365 (&& "__xor__"))))
    (if (py-test-is magic_method625 py-absent)
        (py-ixor-fallback:reflected x365 y366)
        (letrec* ((result626 (py-call magic_method625 x365 y366)))
          (if (py-test-is result626 py-NotImplemented)
              (py-ixor-fallback:reflected x365 y366)
              result626)))))

(define (py-ixor-fallback:reflected x367 y368)
  (letrec* ((magic_method629 (getattribute-from-obj-mro y368 (&& "__rxor__"))))
    (if (py-test-is magic_method629 py-absent)
        (py-ixor-fallback:err x367 y368)
        (letrec* ((result630 (py-call magic_method629 y368 x367)))
          (if (py-test-is result630 py-NotImplemented)
              (py-ixor-fallback:err x367 y368)
              result630)))))

(define (py-ixor-fallback:err x369 y370)
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

(define (py-getattribute-fallback obj171 attr172)
  (letrec* ((__getattribute__633
             (getattribute-from-obj-mro obj171 (&& "__getattribute__"))))
    (with-handler
     (lambda ($%exc_0)
       (cond ((py-isinstance? $%exc_0 py-builtin-AttributeError)
              (letrec* ((__getattr__634
                         (getattribute-from-obj-mro
                          obj171
                          (&& "__getattr__"))))
                (if (py-test-is __getattr__634 py-absent)
                    (py-throw $%exc_0)
                    (py-call __getattr__634 obj171 attr172))))
             (else (raise $%exc_0))))
     (py-call __getattribute__633 obj171 attr172))))

(define (py-getitem-fallback obj174 index175)
  (letrec* ((__getitem__636
             (getattribute-from-obj-mro obj174 (&& "__getitem__"))))
    (if (py-test-is __getitem__636 py-absent)
        (py-throw
         (py-call py-builtin-TypeError (&& "object is not subscriptable")))
        (py-call __getitem__636 obj174 index175))))

(define (py-setitem-fallback obj177 index178 value179)
  (letrec* ((__setitem__638
             (getattribute-from-obj-mro obj177 (&& "__setitem__"))))
    (if (py-test-is __setitem__638 py-absent)
        (py-throw
         (py-call py-builtin-TypeError
                  (&& "object does not support item assignment")))
        (py-call __setitem__638 obj177 index178 value179))))

(define (py-delitem-fallback obj181 index182)
  (letrec* ((__delitem__640
             (getattribute-from-obj-mro obj181 (&& "__delitem__"))))
    (if (py-test-is __delitem__640 py-absent)
        (py-throw
         (py-call py-builtin-TypeError
                  (&& "object does not support item deletion")))
        (py-call __delitem__640 obj181 index182))))

(define (py-enter-fallback obj184)
  (letrec* ((__enter__642 (getattribute-from-obj-mro obj184 (&& "__enter__"))))
    (if (py-test-is __enter__642 py-absent)
        (py-throw (py-call py-builtin-AttributeError (&& "__enter__")))
        (py-call __enter__642 obj184))))

(define (py-exit-fallback obj186 exc187)
  (letrec* ((__exit__645 (getattribute-from-obj-mro obj186 (&& "__exit__"))))
    (if (py-test-is __exit__645 py-absent)
        (py-throw (py-call py-builtin-AttributeError (&& "__exit__")))
        (if (py-test-is exc187 py-None)
            (py-call __exit__645 obj186 py-None py-None py-None)
            (letrec* ((exit_result646
                       (py-call __exit__645
                                obj186
                                (py-call py-builtin-type exc187)
                                exc187
                                py-None)))
              (if (py-test exit_result646) py-None (py-throw exc187)))))))

