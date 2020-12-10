(define-macro (py-add x2 y3) `(let ((x2 ,x2) (y3 ,y3)) (py-add:normal x2 y3)))

(define (py-add:normal x189 y190)
  (letrec* ((magic_method321 (getattribute-from-obj-mro x189 (& "__add__"))))
    (if (eq? magic_method321 py-absent)
        (py-add:reflected x189 y190)
        (letrec* ((result322 (py-call magic_method321 x189 y190)))
          (if (eq? result322 py-NotImplemented)
              (py-add:reflected x189 y190)
              result322)))))

(define (py-add:reflected x191 y192)
  (letrec* ((magic_method325 (getattribute-from-obj-mro y192 (& "__radd__"))))
    (if (eq? magic_method325 py-absent)
        (py-add:err)
        (letrec* ((result326 (py-call magic_method325 y192 x191)))
          (if (eq? result326 py-NotImplemented) (py-add:err) result326)))))

(define (py-add:err) (py-throw py-builtin-ValueError))

(define-macro (py-bitand x8 y9)
  `(let ((x8 ,x8) (y9 ,y9)) (py-bitand:normal x8 y9)))

(define (py-bitand:normal x193 y194)
  (letrec* ((magic_method329 (getattribute-from-obj-mro x193 (& "__and__"))))
    (if (eq? magic_method329 py-absent)
        (py-bitand:reflected x193 y194)
        (letrec* ((result330 (py-call magic_method329 x193 y194)))
          (if (eq? result330 py-NotImplemented)
              (py-bitand:reflected x193 y194)
              result330)))))

(define (py-bitand:reflected x195 y196)
  (letrec* ((magic_method333 (getattribute-from-obj-mro y196 (& "__rand__"))))
    (if (eq? magic_method333 py-absent)
        (py-bitand:err)
        (letrec* ((result334 (py-call magic_method333 y196 x195)))
          (if (eq? result334 py-NotImplemented) (py-bitand:err) result334)))))

(define (py-bitand:err) (py-throw py-builtin-ValueError))

(define-macro (py-bitor x14 y15)
  `(let ((x14 ,x14) (y15 ,y15)) (py-bitor:normal x14 y15)))

(define (py-bitor:normal x197 y198)
  (letrec* ((magic_method337 (getattribute-from-obj-mro x197 (& "__or__"))))
    (if (eq? magic_method337 py-absent)
        (py-bitor:reflected x197 y198)
        (letrec* ((result338 (py-call magic_method337 x197 y198)))
          (if (eq? result338 py-NotImplemented)
              (py-bitor:reflected x197 y198)
              result338)))))

(define (py-bitor:reflected x199 y200)
  (letrec* ((magic_method341 (getattribute-from-obj-mro y200 (& "__ror__"))))
    (if (eq? magic_method341 py-absent)
        (py-bitor:err)
        (letrec* ((result342 (py-call magic_method341 y200 x199)))
          (if (eq? result342 py-NotImplemented) (py-bitor:err) result342)))))

(define (py-bitor:err) (py-throw py-builtin-ValueError))

(define-macro (py-floordiv x20 y21)
  `(let ((x20 ,x20) (y21 ,y21)) (py-floordiv:normal x20 y21)))

(define (py-floordiv:normal x201 y202)
  (letrec* ((magic_method345
             (getattribute-from-obj-mro x201 (& "__floordiv__"))))
    (if (eq? magic_method345 py-absent)
        (py-floordiv:reflected x201 y202)
        (letrec* ((result346 (py-call magic_method345 x201 y202)))
          (if (eq? result346 py-NotImplemented)
              (py-floordiv:reflected x201 y202)
              result346)))))

(define (py-floordiv:reflected x203 y204)
  (letrec* ((magic_method349
             (getattribute-from-obj-mro y204 (& "__rfloordiv__"))))
    (if (eq? magic_method349 py-absent)
        (py-floordiv:err)
        (letrec* ((result350 (py-call magic_method349 y204 x203)))
          (if (eq? result350 py-NotImplemented)
              (py-floordiv:err)
              result350)))))

(define (py-floordiv:err) (py-throw py-builtin-ValueError))

(define-macro (py-lshift x26 y27)
  `(let ((x26 ,x26) (y27 ,y27)) (py-lshift:normal x26 y27)))

(define (py-lshift:normal x205 y206)
  (letrec* ((magic_method353
             (getattribute-from-obj-mro x205 (& "__lshift__"))))
    (if (eq? magic_method353 py-absent)
        (py-lshift:reflected x205 y206)
        (letrec* ((result354 (py-call magic_method353 x205 y206)))
          (if (eq? result354 py-NotImplemented)
              (py-lshift:reflected x205 y206)
              result354)))))

(define (py-lshift:reflected x207 y208)
  (letrec* ((magic_method357
             (getattribute-from-obj-mro y208 (& "__rlshift__"))))
    (if (eq? magic_method357 py-absent)
        (py-lshift:err)
        (letrec* ((result358 (py-call magic_method357 y208 x207)))
          (if (eq? result358 py-NotImplemented) (py-lshift:err) result358)))))

(define (py-lshift:err) (py-throw py-builtin-ValueError))

(define-macro (py-matmul x32 y33)
  `(let ((x32 ,x32) (y33 ,y33)) (py-matmul:normal x32 y33)))

(define (py-matmul:normal x209 y210)
  (letrec* ((magic_method361
             (getattribute-from-obj-mro x209 (& "__matmul__"))))
    (if (eq? magic_method361 py-absent)
        (py-matmul:reflected x209 y210)
        (letrec* ((result362 (py-call magic_method361 x209 y210)))
          (if (eq? result362 py-NotImplemented)
              (py-matmul:reflected x209 y210)
              result362)))))

(define (py-matmul:reflected x211 y212)
  (letrec* ((magic_method365
             (getattribute-from-obj-mro y212 (& "__rmatmul__"))))
    (if (eq? magic_method365 py-absent)
        (py-matmul:err)
        (letrec* ((result366 (py-call magic_method365 y212 x211)))
          (if (eq? result366 py-NotImplemented) (py-matmul:err) result366)))))

(define (py-matmul:err) (py-throw py-builtin-ValueError))

(define-macro (py-mod x38 y39)
  `(let ((x38 ,x38) (y39 ,y39)) (py-mod:normal x38 y39)))

(define (py-mod:normal x213 y214)
  (letrec* ((magic_method369 (getattribute-from-obj-mro x213 (& "__mod__"))))
    (if (eq? magic_method369 py-absent)
        (py-mod:reflected x213 y214)
        (letrec* ((result370 (py-call magic_method369 x213 y214)))
          (if (eq? result370 py-NotImplemented)
              (py-mod:reflected x213 y214)
              result370)))))

(define (py-mod:reflected x215 y216)
  (letrec* ((magic_method373 (getattribute-from-obj-mro y216 (& "__rmod__"))))
    (if (eq? magic_method373 py-absent)
        (py-mod:err)
        (letrec* ((result374 (py-call magic_method373 y216 x215)))
          (if (eq? result374 py-NotImplemented) (py-mod:err) result374)))))

(define (py-mod:err) (py-throw py-builtin-ValueError))

(define-macro (py-mul x44 y45)
  `(let ((x44 ,x44) (y45 ,y45)) (py-mul:normal x44 y45)))

(define (py-mul:normal x217 y218)
  (letrec* ((magic_method377 (getattribute-from-obj-mro x217 (& "__mul__"))))
    (if (eq? magic_method377 py-absent)
        (py-mul:reflected x217 y218)
        (letrec* ((result378 (py-call magic_method377 x217 y218)))
          (if (eq? result378 py-NotImplemented)
              (py-mul:reflected x217 y218)
              result378)))))

(define (py-mul:reflected x219 y220)
  (letrec* ((magic_method381 (getattribute-from-obj-mro y220 (& "__rmul__"))))
    (if (eq? magic_method381 py-absent)
        (py-mul:err)
        (letrec* ((result382 (py-call magic_method381 y220 x219)))
          (if (eq? result382 py-NotImplemented) (py-mul:err) result382)))))

(define (py-mul:err) (py-throw py-builtin-ValueError))

(define-macro (py-pow x50 y51)
  `(let ((x50 ,x50) (y51 ,y51)) (py-pow:normal x50 y51)))

(define (py-pow:normal x221 y222)
  (letrec* ((magic_method385 (getattribute-from-obj-mro x221 (& "__pow__"))))
    (if (eq? magic_method385 py-absent)
        (py-pow:reflected x221 y222)
        (letrec* ((result386 (py-call magic_method385 x221 y222)))
          (if (eq? result386 py-NotImplemented)
              (py-pow:reflected x221 y222)
              result386)))))

(define (py-pow:reflected x223 y224)
  (letrec* ((magic_method389 (getattribute-from-obj-mro y224 (& "__rpow__"))))
    (if (eq? magic_method389 py-absent)
        (py-pow:err)
        (letrec* ((result390 (py-call magic_method389 y224 x223)))
          (if (eq? result390 py-NotImplemented) (py-pow:err) result390)))))

(define (py-pow:err) (py-throw py-builtin-ValueError))

(define-macro (py-rshift x56 y57)
  `(let ((x56 ,x56) (y57 ,y57)) (py-rshift:normal x56 y57)))

(define (py-rshift:normal x225 y226)
  (letrec* ((magic_method393
             (getattribute-from-obj-mro x225 (& "__rshift__"))))
    (if (eq? magic_method393 py-absent)
        (py-rshift:reflected x225 y226)
        (letrec* ((result394 (py-call magic_method393 x225 y226)))
          (if (eq? result394 py-NotImplemented)
              (py-rshift:reflected x225 y226)
              result394)))))

(define (py-rshift:reflected x227 y228)
  (letrec* ((magic_method397
             (getattribute-from-obj-mro y228 (& "__rrshift__"))))
    (if (eq? magic_method397 py-absent)
        (py-rshift:err)
        (letrec* ((result398 (py-call magic_method397 y228 x227)))
          (if (eq? result398 py-NotImplemented) (py-rshift:err) result398)))))

(define (py-rshift:err) (py-throw py-builtin-ValueError))

(define-macro (py-sub x62 y63)
  `(let ((x62 ,x62) (y63 ,y63)) (py-sub:normal x62 y63)))

(define (py-sub:normal x229 y230)
  (letrec* ((magic_method401 (getattribute-from-obj-mro x229 (& "__sub__"))))
    (if (eq? magic_method401 py-absent)
        (py-sub:reflected x229 y230)
        (letrec* ((result402 (py-call magic_method401 x229 y230)))
          (if (eq? result402 py-NotImplemented)
              (py-sub:reflected x229 y230)
              result402)))))

(define (py-sub:reflected x231 y232)
  (letrec* ((magic_method405 (getattribute-from-obj-mro y232 (& "__rsub__"))))
    (if (eq? magic_method405 py-absent)
        (py-sub:err)
        (letrec* ((result406 (py-call magic_method405 y232 x231)))
          (if (eq? result406 py-NotImplemented) (py-sub:err) result406)))))

(define (py-sub:err) (py-throw py-builtin-ValueError))

(define-macro (py-truediv x68 y69)
  `(let ((x68 ,x68) (y69 ,y69)) (py-truediv:normal x68 y69)))

(define (py-truediv:normal x233 y234)
  (letrec* ((magic_method409
             (getattribute-from-obj-mro x233 (& "__truediv__"))))
    (if (eq? magic_method409 py-absent)
        (py-truediv:reflected x233 y234)
        (letrec* ((result410 (py-call magic_method409 x233 y234)))
          (if (eq? result410 py-NotImplemented)
              (py-truediv:reflected x233 y234)
              result410)))))

(define (py-truediv:reflected x235 y236)
  (letrec* ((magic_method413
             (getattribute-from-obj-mro y236 (& "__rtruediv__"))))
    (if (eq? magic_method413 py-absent)
        (py-truediv:err)
        (letrec* ((result414 (py-call magic_method413 y236 x235)))
          (if (eq? result414 py-NotImplemented) (py-truediv:err) result414)))))

(define (py-truediv:err) (py-throw py-builtin-ValueError))

(define-macro (py-xor x74 y75)
  `(let ((x74 ,x74) (y75 ,y75)) (py-xor:normal x74 y75)))

(define (py-xor:normal x237 y238)
  (letrec* ((magic_method417 (getattribute-from-obj-mro x237 (& "__xor__"))))
    (if (eq? magic_method417 py-absent)
        (py-xor:reflected x237 y238)
        (letrec* ((result418 (py-call magic_method417 x237 y238)))
          (if (eq? result418 py-NotImplemented)
              (py-xor:reflected x237 y238)
              result418)))))

(define (py-xor:reflected x239 y240)
  (letrec* ((magic_method421 (getattribute-from-obj-mro y240 (& "__rxor__"))))
    (if (eq? magic_method421 py-absent)
        (py-xor:err)
        (letrec* ((result422 (py-call magic_method421 y240 x239)))
          (if (eq? result422 py-NotImplemented) (py-xor:err) result422)))))

(define (py-xor:err) (py-throw py-builtin-ValueError))

(define-macro (py-iadd x80 y81)
  `(let ((x80 ,x80) (y81 ,y81)) (py-iadd:inplace x80 y81)))

(define (py-iadd:inplace x241 y242)
  (letrec* ((magic_method425 (getattribute-from-obj-mro x241 (& "__iadd__"))))
    (if (eq? magic_method425 py-absent)
        (py-iadd:reflected x241 y242)
        (letrec* ((result426 (py-call magic_method425 x241 y242)))
          (if (eq? result426 py-NotImplemented)
              (py-iadd:normal x241 y242)
              result426)))))

(define (py-iadd:normal x243 y244)
  (letrec* ((magic_method429 (getattribute-from-obj-mro x243 (& "__add__"))))
    (if (eq? magic_method429 py-absent)
        (py-iadd:reflected x243 y244)
        (letrec* ((result430 (py-call magic_method429 x243 y244)))
          (if (eq? result430 py-NotImplemented)
              (py-iadd:reflected x243 y244)
              result430)))))

(define (py-iadd:reflected x245 y246)
  (letrec* ((magic_method433 (getattribute-from-obj-mro y246 (& "__radd__"))))
    (if (eq? magic_method433 py-absent)
        (py-iadd:err)
        (letrec* ((result434 (py-call magic_method433 y246 x245)))
          (if (eq? result434 py-NotImplemented) (py-iadd:err) result434)))))

(define (py-iadd:err) (py-throw py-builtin-ValueError))

(define-macro (py-ibitand x87 y88)
  `(let ((x87 ,x87) (y88 ,y88)) (py-ibitand:inplace x87 y88)))

(define (py-ibitand:inplace x247 y248)
  (letrec* ((magic_method437 (getattribute-from-obj-mro x247 (& "__iand__"))))
    (if (eq? magic_method437 py-absent)
        (py-ibitand:reflected x247 y248)
        (letrec* ((result438 (py-call magic_method437 x247 y248)))
          (if (eq? result438 py-NotImplemented)
              (py-ibitand:normal x247 y248)
              result438)))))

(define (py-ibitand:normal x249 y250)
  (letrec* ((magic_method441 (getattribute-from-obj-mro x249 (& "__and__"))))
    (if (eq? magic_method441 py-absent)
        (py-ibitand:reflected x249 y250)
        (letrec* ((result442 (py-call magic_method441 x249 y250)))
          (if (eq? result442 py-NotImplemented)
              (py-ibitand:reflected x249 y250)
              result442)))))

(define (py-ibitand:reflected x251 y252)
  (letrec* ((magic_method445 (getattribute-from-obj-mro y252 (& "__rand__"))))
    (if (eq? magic_method445 py-absent)
        (py-ibitand:err)
        (letrec* ((result446 (py-call magic_method445 y252 x251)))
          (if (eq? result446 py-NotImplemented) (py-ibitand:err) result446)))))

(define (py-ibitand:err) (py-throw py-builtin-ValueError))

(define-macro (py-ibitor x94 y95)
  `(let ((x94 ,x94) (y95 ,y95)) (py-ibitor:inplace x94 y95)))

(define (py-ibitor:inplace x253 y254)
  (letrec* ((magic_method449 (getattribute-from-obj-mro x253 (& "__ior__"))))
    (if (eq? magic_method449 py-absent)
        (py-ibitor:reflected x253 y254)
        (letrec* ((result450 (py-call magic_method449 x253 y254)))
          (if (eq? result450 py-NotImplemented)
              (py-ibitor:normal x253 y254)
              result450)))))

(define (py-ibitor:normal x255 y256)
  (letrec* ((magic_method453 (getattribute-from-obj-mro x255 (& "__or__"))))
    (if (eq? magic_method453 py-absent)
        (py-ibitor:reflected x255 y256)
        (letrec* ((result454 (py-call magic_method453 x255 y256)))
          (if (eq? result454 py-NotImplemented)
              (py-ibitor:reflected x255 y256)
              result454)))))

(define (py-ibitor:reflected x257 y258)
  (letrec* ((magic_method457 (getattribute-from-obj-mro y258 (& "__ror__"))))
    (if (eq? magic_method457 py-absent)
        (py-ibitor:err)
        (letrec* ((result458 (py-call magic_method457 y258 x257)))
          (if (eq? result458 py-NotImplemented) (py-ibitor:err) result458)))))

(define (py-ibitor:err) (py-throw py-builtin-ValueError))

(define-macro (py-ifloordiv x101 y102)
  `(let ((x101 ,x101) (y102 ,y102)) (py-ifloordiv:inplace x101 y102)))

(define (py-ifloordiv:inplace x259 y260)
  (letrec* ((magic_method461
             (getattribute-from-obj-mro x259 (& "__ifloordiv__"))))
    (if (eq? magic_method461 py-absent)
        (py-ifloordiv:reflected x259 y260)
        (letrec* ((result462 (py-call magic_method461 x259 y260)))
          (if (eq? result462 py-NotImplemented)
              (py-ifloordiv:normal x259 y260)
              result462)))))

(define (py-ifloordiv:normal x261 y262)
  (letrec* ((magic_method465
             (getattribute-from-obj-mro x261 (& "__floordiv__"))))
    (if (eq? magic_method465 py-absent)
        (py-ifloordiv:reflected x261 y262)
        (letrec* ((result466 (py-call magic_method465 x261 y262)))
          (if (eq? result466 py-NotImplemented)
              (py-ifloordiv:reflected x261 y262)
              result466)))))

(define (py-ifloordiv:reflected x263 y264)
  (letrec* ((magic_method469
             (getattribute-from-obj-mro y264 (& "__rfloordiv__"))))
    (if (eq? magic_method469 py-absent)
        (py-ifloordiv:err)
        (letrec* ((result470 (py-call magic_method469 y264 x263)))
          (if (eq? result470 py-NotImplemented)
              (py-ifloordiv:err)
              result470)))))

(define (py-ifloordiv:err) (py-throw py-builtin-ValueError))

(define-macro (py-ilshift x108 y109)
  `(let ((x108 ,x108) (y109 ,y109)) (py-ilshift:inplace x108 y109)))

(define (py-ilshift:inplace x265 y266)
  (letrec* ((magic_method473
             (getattribute-from-obj-mro x265 (& "__ilshift__"))))
    (if (eq? magic_method473 py-absent)
        (py-ilshift:reflected x265 y266)
        (letrec* ((result474 (py-call magic_method473 x265 y266)))
          (if (eq? result474 py-NotImplemented)
              (py-ilshift:normal x265 y266)
              result474)))))

(define (py-ilshift:normal x267 y268)
  (letrec* ((magic_method477
             (getattribute-from-obj-mro x267 (& "__lshift__"))))
    (if (eq? magic_method477 py-absent)
        (py-ilshift:reflected x267 y268)
        (letrec* ((result478 (py-call magic_method477 x267 y268)))
          (if (eq? result478 py-NotImplemented)
              (py-ilshift:reflected x267 y268)
              result478)))))

(define (py-ilshift:reflected x269 y270)
  (letrec* ((magic_method481
             (getattribute-from-obj-mro y270 (& "__rlshift__"))))
    (if (eq? magic_method481 py-absent)
        (py-ilshift:err)
        (letrec* ((result482 (py-call magic_method481 y270 x269)))
          (if (eq? result482 py-NotImplemented) (py-ilshift:err) result482)))))

(define (py-ilshift:err) (py-throw py-builtin-ValueError))

(define-macro (py-imatmul x115 y116)
  `(let ((x115 ,x115) (y116 ,y116)) (py-imatmul:inplace x115 y116)))

(define (py-imatmul:inplace x271 y272)
  (letrec* ((magic_method485
             (getattribute-from-obj-mro x271 (& "__imatmul__"))))
    (if (eq? magic_method485 py-absent)
        (py-imatmul:reflected x271 y272)
        (letrec* ((result486 (py-call magic_method485 x271 y272)))
          (if (eq? result486 py-NotImplemented)
              (py-imatmul:normal x271 y272)
              result486)))))

(define (py-imatmul:normal x273 y274)
  (letrec* ((magic_method489
             (getattribute-from-obj-mro x273 (& "__matmul__"))))
    (if (eq? magic_method489 py-absent)
        (py-imatmul:reflected x273 y274)
        (letrec* ((result490 (py-call magic_method489 x273 y274)))
          (if (eq? result490 py-NotImplemented)
              (py-imatmul:reflected x273 y274)
              result490)))))

(define (py-imatmul:reflected x275 y276)
  (letrec* ((magic_method493
             (getattribute-from-obj-mro y276 (& "__rmatmul__"))))
    (if (eq? magic_method493 py-absent)
        (py-imatmul:err)
        (letrec* ((result494 (py-call magic_method493 y276 x275)))
          (if (eq? result494 py-NotImplemented) (py-imatmul:err) result494)))))

(define (py-imatmul:err) (py-throw py-builtin-ValueError))

(define-macro (py-imod x122 y123)
  `(let ((x122 ,x122) (y123 ,y123)) (py-imod:inplace x122 y123)))

(define (py-imod:inplace x277 y278)
  (letrec* ((magic_method497 (getattribute-from-obj-mro x277 (& "__imod__"))))
    (if (eq? magic_method497 py-absent)
        (py-imod:reflected x277 y278)
        (letrec* ((result498 (py-call magic_method497 x277 y278)))
          (if (eq? result498 py-NotImplemented)
              (py-imod:normal x277 y278)
              result498)))))

(define (py-imod:normal x279 y280)
  (letrec* ((magic_method501 (getattribute-from-obj-mro x279 (& "__mod__"))))
    (if (eq? magic_method501 py-absent)
        (py-imod:reflected x279 y280)
        (letrec* ((result502 (py-call magic_method501 x279 y280)))
          (if (eq? result502 py-NotImplemented)
              (py-imod:reflected x279 y280)
              result502)))))

(define (py-imod:reflected x281 y282)
  (letrec* ((magic_method505 (getattribute-from-obj-mro y282 (& "__rmod__"))))
    (if (eq? magic_method505 py-absent)
        (py-imod:err)
        (letrec* ((result506 (py-call magic_method505 y282 x281)))
          (if (eq? result506 py-NotImplemented) (py-imod:err) result506)))))

(define (py-imod:err) (py-throw py-builtin-ValueError))

(define-macro (py-imul x129 y130)
  `(let ((x129 ,x129) (y130 ,y130)) (py-imul:inplace x129 y130)))

(define (py-imul:inplace x283 y284)
  (letrec* ((magic_method509 (getattribute-from-obj-mro x283 (& "__imul__"))))
    (if (eq? magic_method509 py-absent)
        (py-imul:reflected x283 y284)
        (letrec* ((result510 (py-call magic_method509 x283 y284)))
          (if (eq? result510 py-NotImplemented)
              (py-imul:normal x283 y284)
              result510)))))

(define (py-imul:normal x285 y286)
  (letrec* ((magic_method513 (getattribute-from-obj-mro x285 (& "__mul__"))))
    (if (eq? magic_method513 py-absent)
        (py-imul:reflected x285 y286)
        (letrec* ((result514 (py-call magic_method513 x285 y286)))
          (if (eq? result514 py-NotImplemented)
              (py-imul:reflected x285 y286)
              result514)))))

(define (py-imul:reflected x287 y288)
  (letrec* ((magic_method517 (getattribute-from-obj-mro y288 (& "__rmul__"))))
    (if (eq? magic_method517 py-absent)
        (py-imul:err)
        (letrec* ((result518 (py-call magic_method517 y288 x287)))
          (if (eq? result518 py-NotImplemented) (py-imul:err) result518)))))

(define (py-imul:err) (py-throw py-builtin-ValueError))

(define-macro (py-ipow x136 y137)
  `(let ((x136 ,x136) (y137 ,y137)) (py-ipow:inplace x136 y137)))

(define (py-ipow:inplace x289 y290)
  (letrec* ((magic_method521 (getattribute-from-obj-mro x289 (& "__ipow__"))))
    (if (eq? magic_method521 py-absent)
        (py-ipow:reflected x289 y290)
        (letrec* ((result522 (py-call magic_method521 x289 y290)))
          (if (eq? result522 py-NotImplemented)
              (py-ipow:normal x289 y290)
              result522)))))

(define (py-ipow:normal x291 y292)
  (letrec* ((magic_method525 (getattribute-from-obj-mro x291 (& "__pow__"))))
    (if (eq? magic_method525 py-absent)
        (py-ipow:reflected x291 y292)
        (letrec* ((result526 (py-call magic_method525 x291 y292)))
          (if (eq? result526 py-NotImplemented)
              (py-ipow:reflected x291 y292)
              result526)))))

(define (py-ipow:reflected x293 y294)
  (letrec* ((magic_method529 (getattribute-from-obj-mro y294 (& "__rpow__"))))
    (if (eq? magic_method529 py-absent)
        (py-ipow:err)
        (letrec* ((result530 (py-call magic_method529 y294 x293)))
          (if (eq? result530 py-NotImplemented) (py-ipow:err) result530)))))

(define (py-ipow:err) (py-throw py-builtin-ValueError))

(define-macro (py-irshift x143 y144)
  `(let ((x143 ,x143) (y144 ,y144)) (py-irshift:inplace x143 y144)))

(define (py-irshift:inplace x295 y296)
  (letrec* ((magic_method533
             (getattribute-from-obj-mro x295 (& "__irshift__"))))
    (if (eq? magic_method533 py-absent)
        (py-irshift:reflected x295 y296)
        (letrec* ((result534 (py-call magic_method533 x295 y296)))
          (if (eq? result534 py-NotImplemented)
              (py-irshift:normal x295 y296)
              result534)))))

(define (py-irshift:normal x297 y298)
  (letrec* ((magic_method537
             (getattribute-from-obj-mro x297 (& "__rshift__"))))
    (if (eq? magic_method537 py-absent)
        (py-irshift:reflected x297 y298)
        (letrec* ((result538 (py-call magic_method537 x297 y298)))
          (if (eq? result538 py-NotImplemented)
              (py-irshift:reflected x297 y298)
              result538)))))

(define (py-irshift:reflected x299 y300)
  (letrec* ((magic_method541
             (getattribute-from-obj-mro y300 (& "__rrshift__"))))
    (if (eq? magic_method541 py-absent)
        (py-irshift:err)
        (letrec* ((result542 (py-call magic_method541 y300 x299)))
          (if (eq? result542 py-NotImplemented) (py-irshift:err) result542)))))

(define (py-irshift:err) (py-throw py-builtin-ValueError))

(define-macro (py-isub x150 y151)
  `(let ((x150 ,x150) (y151 ,y151)) (py-isub:inplace x150 y151)))

(define (py-isub:inplace x301 y302)
  (letrec* ((magic_method545 (getattribute-from-obj-mro x301 (& "__isub__"))))
    (if (eq? magic_method545 py-absent)
        (py-isub:reflected x301 y302)
        (letrec* ((result546 (py-call magic_method545 x301 y302)))
          (if (eq? result546 py-NotImplemented)
              (py-isub:normal x301 y302)
              result546)))))

(define (py-isub:normal x303 y304)
  (letrec* ((magic_method549 (getattribute-from-obj-mro x303 (& "__sub__"))))
    (if (eq? magic_method549 py-absent)
        (py-isub:reflected x303 y304)
        (letrec* ((result550 (py-call magic_method549 x303 y304)))
          (if (eq? result550 py-NotImplemented)
              (py-isub:reflected x303 y304)
              result550)))))

(define (py-isub:reflected x305 y306)
  (letrec* ((magic_method553 (getattribute-from-obj-mro y306 (& "__rsub__"))))
    (if (eq? magic_method553 py-absent)
        (py-isub:err)
        (letrec* ((result554 (py-call magic_method553 y306 x305)))
          (if (eq? result554 py-NotImplemented) (py-isub:err) result554)))))

(define (py-isub:err) (py-throw py-builtin-ValueError))

(define-macro (py-itruediv x157 y158)
  `(let ((x157 ,x157) (y158 ,y158)) (py-itruediv:inplace x157 y158)))

(define (py-itruediv:inplace x307 y308)
  (letrec* ((magic_method557
             (getattribute-from-obj-mro x307 (& "__itruediv__"))))
    (if (eq? magic_method557 py-absent)
        (py-itruediv:reflected x307 y308)
        (letrec* ((result558 (py-call magic_method557 x307 y308)))
          (if (eq? result558 py-NotImplemented)
              (py-itruediv:normal x307 y308)
              result558)))))

(define (py-itruediv:normal x309 y310)
  (letrec* ((magic_method561
             (getattribute-from-obj-mro x309 (& "__truediv__"))))
    (if (eq? magic_method561 py-absent)
        (py-itruediv:reflected x309 y310)
        (letrec* ((result562 (py-call magic_method561 x309 y310)))
          (if (eq? result562 py-NotImplemented)
              (py-itruediv:reflected x309 y310)
              result562)))))

(define (py-itruediv:reflected x311 y312)
  (letrec* ((magic_method565
             (getattribute-from-obj-mro y312 (& "__rtruediv__"))))
    (if (eq? magic_method565 py-absent)
        (py-itruediv:err)
        (letrec* ((result566 (py-call magic_method565 y312 x311)))
          (if (eq? result566 py-NotImplemented)
              (py-itruediv:err)
              result566)))))

(define (py-itruediv:err) (py-throw py-builtin-ValueError))

(define-macro (py-ixor x164 y165)
  `(let ((x164 ,x164) (y165 ,y165)) (py-ixor:inplace x164 y165)))

(define (py-ixor:inplace x313 y314)
  (letrec* ((magic_method569 (getattribute-from-obj-mro x313 (& "__ixor__"))))
    (if (eq? magic_method569 py-absent)
        (py-ixor:reflected x313 y314)
        (letrec* ((result570 (py-call magic_method569 x313 y314)))
          (if (eq? result570 py-NotImplemented)
              (py-ixor:normal x313 y314)
              result570)))))

(define (py-ixor:normal x315 y316)
  (letrec* ((magic_method573 (getattribute-from-obj-mro x315 (& "__xor__"))))
    (if (eq? magic_method573 py-absent)
        (py-ixor:reflected x315 y316)
        (letrec* ((result574 (py-call magic_method573 x315 y316)))
          (if (eq? result574 py-NotImplemented)
              (py-ixor:reflected x315 y316)
              result574)))))

(define (py-ixor:reflected x317 y318)
  (letrec* ((magic_method577 (getattribute-from-obj-mro y318 (& "__rxor__"))))
    (if (eq? magic_method577 py-absent)
        (py-ixor:err)
        (letrec* ((result578 (py-call magic_method577 y318 x317)))
          (if (eq? result578 py-NotImplemented) (py-ixor:err) result578)))))

(define (py-ixor:err) (py-throw py-builtin-ValueError))

(define (py-getattribute obj171 attr172)
  (letrec* ((__getattribute__581
             (getattribute-from-obj-mro obj171 (& "__getattribute__"))))
    (with-handler
     (lambda ($%exc_0)
       (cond ((py-isinstance? $%exc_0 py-builtin-AttributeError)
              (letrec* ((__getattr__582
                         (getattribute-from-obj-mro obj171 (& "__getattr__"))))
                (if (eq? __getattr__582 py-absent)
                    (py-throw $%exc_0)
                    (py-call __getattr__582 obj171 attr172))))
             (else (raise $%exc_0))))
     (py-call __getattribute__581 obj171 attr172))))

(define (py-getitem obj174 index175)
  (letrec* ((__getitem__584
             (getattribute-from-obj-mro obj174 (& "__getitem__"))))
    (if (eq? __getitem__584 py-absent)
        (py-throw
         (py-call py-builtin-TypeError (&& "object is not subscriptable")))
        (py-call __getitem__584 obj174 index175))))

(define (py-setitem obj177 index178 value179)
  (letrec* ((__setitem__586
             (getattribute-from-obj-mro obj177 (& "__setitem__"))))
    (if (eq? __setitem__586 py-absent)
        (py-throw
         (py-call py-builtin-TypeError
                  (&& "object does not support item assignment")))
        (py-call __setitem__586 obj177 index178 value179))))

(define (py-delitem obj181 index182)
  (letrec* ((__delitem__588
             (getattribute-from-obj-mro obj181 (& "__delitem__"))))
    (if (eq? __delitem__588 py-absent)
        (py-throw
         (py-call py-builtin-TypeError
                  (&& "object does not support item deletion")))
        (py-call __delitem__588 obj181 index182))))

(define (py-enter obj184)
  (letrec* ((__enter__590 (getattribute-from-obj-mro obj184 (& "__enter__"))))
    (if (eq? __enter__590 py-absent)
        (py-throw (py-call py-builtin-AttributeError (&& "__enter__")))
        (py-call __enter__590 obj184))))

(define (py-exit obj186 exc187)
  (letrec* ((__exit__593 (getattribute-from-obj-mro obj186 (& "__exit__"))))
    (if (eq? __exit__593 py-absent)
        (py-throw (py-call py-builtin-AttributeError (&& "__exit__")))
        (if (eq? exc187 py-None)
            (py-call __exit__593 obj186 py-None py-None py-None)
            (letrec* ((exit_result594
                       (py-call __exit__593
                                obj186
                                (py-call py-builtin-type exc187)
                                exc187
                                py-None)))
              (if (py-test exit_result594) py-None (py-throw exc187)))))))

