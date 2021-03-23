(define-macro (py-add-fallback x-2 y-3)
  `(let ((x-2 ,x-2) (y-3 ,y-3)) (py-add-fallback:normal x-2 y-3)))

(define-macro (py-bitand-fallback x-4 y-5)
  `(let ((x-4 ,x-4) (y-5 ,y-5)) (py-bitand-fallback:normal x-4 y-5)))

(define-macro (py-bitor-fallback x-6 y-7)
  `(let ((x-6 ,x-6) (y-7 ,y-7)) (py-bitor-fallback:normal x-6 y-7)))

(define-macro (py-floordiv-fallback x-8 y-9)
  `(let ((x-8 ,x-8) (y-9 ,y-9)) (py-floordiv-fallback:normal x-8 y-9)))

(define-macro (py-lshift-fallback x-10 y-11)
  `(let ((x-10 ,x-10) (y-11 ,y-11)) (py-lshift-fallback:normal x-10 y-11)))

(define-macro (py-matmul-fallback x-12 y-13)
  `(let ((x-12 ,x-12) (y-13 ,y-13)) (py-matmul-fallback:normal x-12 y-13)))

(define-macro (py-mod-fallback x-14 y-15)
  `(let ((x-14 ,x-14) (y-15 ,y-15)) (py-mod-fallback:normal x-14 y-15)))

(define-macro (py-mul-fallback x-16 y-17)
  `(let ((x-16 ,x-16) (y-17 ,y-17)) (py-mul-fallback:normal x-16 y-17)))

(define-macro (py-pow-fallback x-18 y-19)
  `(let ((x-18 ,x-18) (y-19 ,y-19)) (py-pow-fallback:normal x-18 y-19)))

(define-macro (py-rshift-fallback x-20 y-21)
  `(let ((x-20 ,x-20) (y-21 ,y-21)) (py-rshift-fallback:normal x-20 y-21)))

(define-macro (py-sub-fallback x-22 y-23)
  `(let ((x-22 ,x-22) (y-23 ,y-23)) (py-sub-fallback:normal x-22 y-23)))

(define-macro (py-truediv-fallback x-24 y-25)
  `(let ((x-24 ,x-24) (y-25 ,y-25)) (py-truediv-fallback:normal x-24 y-25)))

(define-macro (py-xor-fallback x-26 y-27)
  `(let ((x-26 ,x-26) (y-27 ,y-27)) (py-xor-fallback:normal x-26 y-27)))

(define-macro (py-iadd-fallback x-28 y-29)
  `(let ((x-28 ,x-28) (y-29 ,y-29)) (py-iadd-fallback:inplace x-28 y-29)))

(define-macro (py-ibitand-fallback x-30 y-31)
  `(let ((x-30 ,x-30) (y-31 ,y-31)) (py-ibitand-fallback:inplace x-30 y-31)))

(define-macro (py-ibitor-fallback x-32 y-33)
  `(let ((x-32 ,x-32) (y-33 ,y-33)) (py-ibitor-fallback:inplace x-32 y-33)))

(define-macro (py-ifloordiv-fallback x-34 y-35)
  `(let ((x-34 ,x-34) (y-35 ,y-35)) (py-ifloordiv-fallback:inplace x-34 y-35)))

(define-macro (py-ilshift-fallback x-36 y-37)
  `(let ((x-36 ,x-36) (y-37 ,y-37)) (py-ilshift-fallback:inplace x-36 y-37)))

(define-macro (py-imatmul-fallback x-38 y-39)
  `(let ((x-38 ,x-38) (y-39 ,y-39)) (py-imatmul-fallback:inplace x-38 y-39)))

(define-macro (py-imod-fallback x-40 y-41)
  `(let ((x-40 ,x-40) (y-41 ,y-41)) (py-imod-fallback:inplace x-40 y-41)))

(define-macro (py-imul-fallback x-42 y-43)
  `(let ((x-42 ,x-42) (y-43 ,y-43)) (py-imul-fallback:inplace x-42 y-43)))

(define-macro (py-ipow-fallback x-44 y-45)
  `(let ((x-44 ,x-44) (y-45 ,y-45)) (py-ipow-fallback:inplace x-44 y-45)))

(define-macro (py-irshift-fallback x-46 y-47)
  `(let ((x-46 ,x-46) (y-47 ,y-47)) (py-irshift-fallback:inplace x-46 y-47)))

(define-macro (py-isub-fallback x-48 y-49)
  `(let ((x-48 ,x-48) (y-49 ,y-49)) (py-isub-fallback:inplace x-48 y-49)))

(define-macro (py-itruediv-fallback x-50 y-51)
  `(let ((x-50 ,x-50) (y-51 ,y-51)) (py-itruediv-fallback:inplace x-50 y-51)))

(define-macro (py-ixor-fallback x-52 y-53)
  `(let ((x-52 ,x-52) (y-53 ,y-53)) (py-ixor-fallback:inplace x-52 y-53)))

(define-macro (py-pos-fallback x-54)
  `(let ((x-54 ,x-54)) (py-pos-fallback:normal x-54)))

(define-macro (py-neg-fallback x-55)
  `(let ((x-55 ,x-55)) (py-neg-fallback:normal x-55)))

(define-macro (py-invert-fallback x-56)
  `(let ((x-56 ,x-56)) (py-invert-fallback:normal x-56)))

(define-macro (py-ge-fallback x-57 y-58)
  `(let ((x-57 ,x-57) (y-58 ,y-58)) (py-ge-fallback:normal x-57 y-58)))

(define-macro (py-gt-fallback x-59 y-60)
  `(let ((x-59 ,x-59) (y-60 ,y-60)) (py-gt-fallback:normal x-59 y-60)))

(define-macro (py-le-fallback x-61 y-62)
  `(let ((x-61 ,x-61) (y-62 ,y-62)) (py-le-fallback:normal x-61 y-62)))

(define-macro (py-lt-fallback x-63 y-64)
  `(let ((x-63 ,x-63) (y-64 ,y-64)) (py-lt-fallback:normal x-63 y-64)))

(define-macro (py-eq-fallback x-65 y-66)
  `(let ((x-65 ,x-65) (y-66 ,y-66)) (py-eq-fallback:normal x-65 y-66)))

(define-macro (py-ne-fallback x-67 y-68)
  `(let ((x-67 ,x-67) (y-68 ,y-68)) (py-ne-fallback:normal x-67 y-68)))

(define (py-add-fallback:normal x-2 y-3)
  (letrec* ((magic_method-177 (getattribute-from-obj-mro x-2 (&& "__add__"))))
    (if (py-test (py-is magic_method-177 py-absent))
        (py-add-fallback:reflected x-2 y-3)
        (letrec* ((result-183 (py-call magic_method-177 x-2 y-3)))
          (if (py-test (py-is result-183 py-NotImplemented))
              (py-add-fallback:reflected x-2 y-3)
              result-183)))))

(define (py-add-fallback:reflected x-2 y-3)
  (letrec* ((magic_method-167 (getattribute-from-obj-mro y-3 (&& "__radd__"))))
    (if (py-test (py-is magic_method-167 py-absent))
        (py-add-fallback:err x-2 y-3)
        (letrec* ((result-173 (py-call magic_method-167 y-3 x-2)))
          (if (py-test (py-is result-173 py-NotImplemented))
              (py-add-fallback:err x-2 y-3)
              result-173)))))

(define (py-add-fallback:err x-2 y-3)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for +: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-2)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-3)
                             (& "__name__")))
                    (&& "'")))))

(define (py-bitand-fallback:normal x-4 y-5)
  (letrec* ((magic_method-207 (getattribute-from-obj-mro x-4 (&& "__and__"))))
    (if (py-test (py-is magic_method-207 py-absent))
        (py-bitand-fallback:reflected x-4 y-5)
        (letrec* ((result-213 (py-call magic_method-207 x-4 y-5)))
          (if (py-test (py-is result-213 py-NotImplemented))
              (py-bitand-fallback:reflected x-4 y-5)
              result-213)))))

(define (py-bitand-fallback:reflected x-4 y-5)
  (letrec* ((magic_method-197 (getattribute-from-obj-mro y-5 (&& "__rand__"))))
    (if (py-test (py-is magic_method-197 py-absent))
        (py-bitand-fallback:err x-4 y-5)
        (letrec* ((result-203 (py-call magic_method-197 y-5 x-4)))
          (if (py-test (py-is result-203 py-NotImplemented))
              (py-bitand-fallback:err x-4 y-5)
              result-203)))))

(define (py-bitand-fallback:err x-4 y-5)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for &: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-4)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-5)
                             (& "__name__")))
                    (&& "'")))))

(define (py-bitor-fallback:normal x-6 y-7)
  (letrec* ((magic_method-237 (getattribute-from-obj-mro x-6 (&& "__or__"))))
    (if (py-test (py-is magic_method-237 py-absent))
        (py-bitor-fallback:reflected x-6 y-7)
        (letrec* ((result-243 (py-call magic_method-237 x-6 y-7)))
          (if (py-test (py-is result-243 py-NotImplemented))
              (py-bitor-fallback:reflected x-6 y-7)
              result-243)))))

(define (py-bitor-fallback:reflected x-6 y-7)
  (letrec* ((magic_method-227 (getattribute-from-obj-mro y-7 (&& "__ror__"))))
    (if (py-test (py-is magic_method-227 py-absent))
        (py-bitor-fallback:err x-6 y-7)
        (letrec* ((result-233 (py-call magic_method-227 y-7 x-6)))
          (if (py-test (py-is result-233 py-NotImplemented))
              (py-bitor-fallback:err x-6 y-7)
              result-233)))))

(define (py-bitor-fallback:err x-6 y-7)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for |: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-6)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-7)
                             (& "__name__")))
                    (&& "'")))))

(define (py-floordiv-fallback:normal x-8 y-9)
  (letrec* ((magic_method-267
             (getattribute-from-obj-mro x-8 (&& "__floordiv__"))))
    (if (py-test (py-is magic_method-267 py-absent))
        (py-floordiv-fallback:reflected x-8 y-9)
        (letrec* ((result-273 (py-call magic_method-267 x-8 y-9)))
          (if (py-test (py-is result-273 py-NotImplemented))
              (py-floordiv-fallback:reflected x-8 y-9)
              result-273)))))

(define (py-floordiv-fallback:reflected x-8 y-9)
  (letrec* ((magic_method-257
             (getattribute-from-obj-mro y-9 (&& "__rfloordiv__"))))
    (if (py-test (py-is magic_method-257 py-absent))
        (py-floordiv-fallback:err x-8 y-9)
        (letrec* ((result-263 (py-call magic_method-257 y-9 x-8)))
          (if (py-test (py-is result-263 py-NotImplemented))
              (py-floordiv-fallback:err x-8 y-9)
              result-263)))))

(define (py-floordiv-fallback:err x-8 y-9)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for //: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-8)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-9)
                             (& "__name__")))
                    (&& "'")))))

(define (py-lshift-fallback:normal x-10 y-11)
  (letrec* ((magic_method-297
             (getattribute-from-obj-mro x-10 (&& "__lshift__"))))
    (if (py-test (py-is magic_method-297 py-absent))
        (py-lshift-fallback:reflected x-10 y-11)
        (letrec* ((result-303 (py-call magic_method-297 x-10 y-11)))
          (if (py-test (py-is result-303 py-NotImplemented))
              (py-lshift-fallback:reflected x-10 y-11)
              result-303)))))

(define (py-lshift-fallback:reflected x-10 y-11)
  (letrec* ((magic_method-287
             (getattribute-from-obj-mro y-11 (&& "__rlshift__"))))
    (if (py-test (py-is magic_method-287 py-absent))
        (py-lshift-fallback:err x-10 y-11)
        (letrec* ((result-293 (py-call magic_method-287 y-11 x-10)))
          (if (py-test (py-is result-293 py-NotImplemented))
              (py-lshift-fallback:err x-10 y-11)
              result-293)))))

(define (py-lshift-fallback:err x-10 y-11)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for <<: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-10)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-11)
                             (& "__name__")))
                    (&& "'")))))

(define (py-matmul-fallback:normal x-12 y-13)
  (letrec* ((magic_method-327
             (getattribute-from-obj-mro x-12 (&& "__matmul__"))))
    (if (py-test (py-is magic_method-327 py-absent))
        (py-matmul-fallback:reflected x-12 y-13)
        (letrec* ((result-333 (py-call magic_method-327 x-12 y-13)))
          (if (py-test (py-is result-333 py-NotImplemented))
              (py-matmul-fallback:reflected x-12 y-13)
              result-333)))))

(define (py-matmul-fallback:reflected x-12 y-13)
  (letrec* ((magic_method-317
             (getattribute-from-obj-mro y-13 (&& "__rmatmul__"))))
    (if (py-test (py-is magic_method-317 py-absent))
        (py-matmul-fallback:err x-12 y-13)
        (letrec* ((result-323 (py-call magic_method-317 y-13 x-12)))
          (if (py-test (py-is result-323 py-NotImplemented))
              (py-matmul-fallback:err x-12 y-13)
              result-323)))))

(define (py-matmul-fallback:err x-12 y-13)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for @: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-12)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-13)
                             (& "__name__")))
                    (&& "'")))))

(define (py-mod-fallback:normal x-14 y-15)
  (letrec* ((magic_method-357 (getattribute-from-obj-mro x-14 (&& "__mod__"))))
    (if (py-test (py-is magic_method-357 py-absent))
        (py-mod-fallback:reflected x-14 y-15)
        (letrec* ((result-363 (py-call magic_method-357 x-14 y-15)))
          (if (py-test (py-is result-363 py-NotImplemented))
              (py-mod-fallback:reflected x-14 y-15)
              result-363)))))

(define (py-mod-fallback:reflected x-14 y-15)
  (letrec* ((magic_method-347
             (getattribute-from-obj-mro y-15 (&& "__rmod__"))))
    (if (py-test (py-is magic_method-347 py-absent))
        (py-mod-fallback:err x-14 y-15)
        (letrec* ((result-353 (py-call magic_method-347 y-15 x-14)))
          (if (py-test (py-is result-353 py-NotImplemented))
              (py-mod-fallback:err x-14 y-15)
              result-353)))))

(define (py-mod-fallback:err x-14 y-15)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for %: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-14)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-15)
                             (& "__name__")))
                    (&& "'")))))

(define (py-mul-fallback:normal x-16 y-17)
  (letrec* ((magic_method-387 (getattribute-from-obj-mro x-16 (&& "__mul__"))))
    (if (py-test (py-is magic_method-387 py-absent))
        (py-mul-fallback:reflected x-16 y-17)
        (letrec* ((result-393 (py-call magic_method-387 x-16 y-17)))
          (if (py-test (py-is result-393 py-NotImplemented))
              (py-mul-fallback:reflected x-16 y-17)
              result-393)))))

(define (py-mul-fallback:reflected x-16 y-17)
  (letrec* ((magic_method-377
             (getattribute-from-obj-mro y-17 (&& "__rmul__"))))
    (if (py-test (py-is magic_method-377 py-absent))
        (py-mul-fallback:err x-16 y-17)
        (letrec* ((result-383 (py-call magic_method-377 y-17 x-16)))
          (if (py-test (py-is result-383 py-NotImplemented))
              (py-mul-fallback:err x-16 y-17)
              result-383)))))

(define (py-mul-fallback:err x-16 y-17)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for *: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-16)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-17)
                             (& "__name__")))
                    (&& "'")))))

(define (py-pow-fallback:normal x-18 y-19)
  (letrec* ((magic_method-417 (getattribute-from-obj-mro x-18 (&& "__pow__"))))
    (if (py-test (py-is magic_method-417 py-absent))
        (py-pow-fallback:reflected x-18 y-19)
        (letrec* ((result-423 (py-call magic_method-417 x-18 y-19)))
          (if (py-test (py-is result-423 py-NotImplemented))
              (py-pow-fallback:reflected x-18 y-19)
              result-423)))))

(define (py-pow-fallback:reflected x-18 y-19)
  (letrec* ((magic_method-407
             (getattribute-from-obj-mro y-19 (&& "__rpow__"))))
    (if (py-test (py-is magic_method-407 py-absent))
        (py-pow-fallback:err x-18 y-19)
        (letrec* ((result-413 (py-call magic_method-407 y-19 x-18)))
          (if (py-test (py-is result-413 py-NotImplemented))
              (py-pow-fallback:err x-18 y-19)
              result-413)))))

(define (py-pow-fallback:err x-18 y-19)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for **: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-18)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-19)
                             (& "__name__")))
                    (&& "'")))))

(define (py-rshift-fallback:normal x-20 y-21)
  (letrec* ((magic_method-447
             (getattribute-from-obj-mro x-20 (&& "__rshift__"))))
    (if (py-test (py-is magic_method-447 py-absent))
        (py-rshift-fallback:reflected x-20 y-21)
        (letrec* ((result-453 (py-call magic_method-447 x-20 y-21)))
          (if (py-test (py-is result-453 py-NotImplemented))
              (py-rshift-fallback:reflected x-20 y-21)
              result-453)))))

(define (py-rshift-fallback:reflected x-20 y-21)
  (letrec* ((magic_method-437
             (getattribute-from-obj-mro y-21 (&& "__rrshift__"))))
    (if (py-test (py-is magic_method-437 py-absent))
        (py-rshift-fallback:err x-20 y-21)
        (letrec* ((result-443 (py-call magic_method-437 y-21 x-20)))
          (if (py-test (py-is result-443 py-NotImplemented))
              (py-rshift-fallback:err x-20 y-21)
              result-443)))))

(define (py-rshift-fallback:err x-20 y-21)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for >>: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-20)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-21)
                             (& "__name__")))
                    (&& "'")))))

(define (py-sub-fallback:normal x-22 y-23)
  (letrec* ((magic_method-477 (getattribute-from-obj-mro x-22 (&& "__sub__"))))
    (if (py-test (py-is magic_method-477 py-absent))
        (py-sub-fallback:reflected x-22 y-23)
        (letrec* ((result-483 (py-call magic_method-477 x-22 y-23)))
          (if (py-test (py-is result-483 py-NotImplemented))
              (py-sub-fallback:reflected x-22 y-23)
              result-483)))))

(define (py-sub-fallback:reflected x-22 y-23)
  (letrec* ((magic_method-467
             (getattribute-from-obj-mro y-23 (&& "__rsub__"))))
    (if (py-test (py-is magic_method-467 py-absent))
        (py-sub-fallback:err x-22 y-23)
        (letrec* ((result-473 (py-call magic_method-467 y-23 x-22)))
          (if (py-test (py-is result-473 py-NotImplemented))
              (py-sub-fallback:err x-22 y-23)
              result-473)))))

(define (py-sub-fallback:err x-22 y-23)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for -: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-22)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-23)
                             (& "__name__")))
                    (&& "'")))))

(define (py-truediv-fallback:normal x-24 y-25)
  (letrec* ((magic_method-507
             (getattribute-from-obj-mro x-24 (&& "__truediv__"))))
    (if (py-test (py-is magic_method-507 py-absent))
        (py-truediv-fallback:reflected x-24 y-25)
        (letrec* ((result-513 (py-call magic_method-507 x-24 y-25)))
          (if (py-test (py-is result-513 py-NotImplemented))
              (py-truediv-fallback:reflected x-24 y-25)
              result-513)))))

(define (py-truediv-fallback:reflected x-24 y-25)
  (letrec* ((magic_method-497
             (getattribute-from-obj-mro y-25 (&& "__rtruediv__"))))
    (if (py-test (py-is magic_method-497 py-absent))
        (py-truediv-fallback:err x-24 y-25)
        (letrec* ((result-503 (py-call magic_method-497 y-25 x-24)))
          (if (py-test (py-is result-503 py-NotImplemented))
              (py-truediv-fallback:err x-24 y-25)
              result-503)))))

(define (py-truediv-fallback:err x-24 y-25)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for /: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-24)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-25)
                             (& "__name__")))
                    (&& "'")))))

(define (py-xor-fallback:normal x-26 y-27)
  (letrec* ((magic_method-537 (getattribute-from-obj-mro x-26 (&& "__xor__"))))
    (if (py-test (py-is magic_method-537 py-absent))
        (py-xor-fallback:reflected x-26 y-27)
        (letrec* ((result-543 (py-call magic_method-537 x-26 y-27)))
          (if (py-test (py-is result-543 py-NotImplemented))
              (py-xor-fallback:reflected x-26 y-27)
              result-543)))))

(define (py-xor-fallback:reflected x-26 y-27)
  (letrec* ((magic_method-527
             (getattribute-from-obj-mro y-27 (&& "__rxor__"))))
    (if (py-test (py-is magic_method-527 py-absent))
        (py-xor-fallback:err x-26 y-27)
        (letrec* ((result-533 (py-call magic_method-527 y-27 x-26)))
          (if (py-test (py-is result-533 py-NotImplemented))
              (py-xor-fallback:err x-26 y-27)
              result-533)))))

(define (py-xor-fallback:err x-26 y-27)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for ^: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-26)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-27)
                             (& "__name__")))
                    (&& "'")))))

(define (py-iadd-fallback:inplace x-28 y-29)
  (letrec* ((magic_method-579
             (getattribute-from-obj-mro x-28 (&& "__iadd__"))))
    (if (py-test (py-is magic_method-579 py-absent))
        (py-iadd-fallback:normal x-28 y-29)
        (letrec* ((result-585 (py-call magic_method-579 x-28 y-29)))
          (if (py-test (py-is result-585 py-NotImplemented))
              (py-iadd-fallback:normal x-28 y-29)
              result-585)))))

(define (py-iadd-fallback:normal x-28 y-29)
  (letrec* ((magic_method-569 (getattribute-from-obj-mro x-28 (&& "__add__"))))
    (if (py-test (py-is magic_method-569 py-absent))
        (py-iadd-fallback:reflected x-28 y-29)
        (letrec* ((result-575 (py-call magic_method-569 x-28 y-29)))
          (if (py-test (py-is result-575 py-NotImplemented))
              (py-iadd-fallback:reflected x-28 y-29)
              result-575)))))

(define (py-iadd-fallback:reflected x-28 y-29)
  (letrec* ((magic_method-559
             (getattribute-from-obj-mro y-29 (&& "__radd__"))))
    (if (py-test (py-is magic_method-559 py-absent))
        (py-iadd-fallback:err x-28 y-29)
        (letrec* ((result-565 (py-call magic_method-559 y-29 x-28)))
          (if (py-test (py-is result-565 py-NotImplemented))
              (py-iadd-fallback:err x-28 y-29)
              result-565)))))

(define (py-iadd-fallback:err x-28 y-29)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for +=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-28)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-29)
                             (& "__name__")))
                    (&& "'")))))

(define (py-ibitand-fallback:inplace x-30 y-31)
  (letrec* ((magic_method-621
             (getattribute-from-obj-mro x-30 (&& "__iand__"))))
    (if (py-test (py-is magic_method-621 py-absent))
        (py-ibitand-fallback:normal x-30 y-31)
        (letrec* ((result-627 (py-call magic_method-621 x-30 y-31)))
          (if (py-test (py-is result-627 py-NotImplemented))
              (py-ibitand-fallback:normal x-30 y-31)
              result-627)))))

(define (py-ibitand-fallback:normal x-30 y-31)
  (letrec* ((magic_method-611 (getattribute-from-obj-mro x-30 (&& "__and__"))))
    (if (py-test (py-is magic_method-611 py-absent))
        (py-ibitand-fallback:reflected x-30 y-31)
        (letrec* ((result-617 (py-call magic_method-611 x-30 y-31)))
          (if (py-test (py-is result-617 py-NotImplemented))
              (py-ibitand-fallback:reflected x-30 y-31)
              result-617)))))

(define (py-ibitand-fallback:reflected x-30 y-31)
  (letrec* ((magic_method-601
             (getattribute-from-obj-mro y-31 (&& "__rand__"))))
    (if (py-test (py-is magic_method-601 py-absent))
        (py-ibitand-fallback:err x-30 y-31)
        (letrec* ((result-607 (py-call magic_method-601 y-31 x-30)))
          (if (py-test (py-is result-607 py-NotImplemented))
              (py-ibitand-fallback:err x-30 y-31)
              result-607)))))

(define (py-ibitand-fallback:err x-30 y-31)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for &=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-30)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-31)
                             (& "__name__")))
                    (&& "'")))))

(define (py-ibitor-fallback:inplace x-32 y-33)
  (letrec* ((magic_method-663 (getattribute-from-obj-mro x-32 (&& "__ior__"))))
    (if (py-test (py-is magic_method-663 py-absent))
        (py-ibitor-fallback:normal x-32 y-33)
        (letrec* ((result-669 (py-call magic_method-663 x-32 y-33)))
          (if (py-test (py-is result-669 py-NotImplemented))
              (py-ibitor-fallback:normal x-32 y-33)
              result-669)))))

(define (py-ibitor-fallback:normal x-32 y-33)
  (letrec* ((magic_method-653 (getattribute-from-obj-mro x-32 (&& "__or__"))))
    (if (py-test (py-is magic_method-653 py-absent))
        (py-ibitor-fallback:reflected x-32 y-33)
        (letrec* ((result-659 (py-call magic_method-653 x-32 y-33)))
          (if (py-test (py-is result-659 py-NotImplemented))
              (py-ibitor-fallback:reflected x-32 y-33)
              result-659)))))

(define (py-ibitor-fallback:reflected x-32 y-33)
  (letrec* ((magic_method-643 (getattribute-from-obj-mro y-33 (&& "__ror__"))))
    (if (py-test (py-is magic_method-643 py-absent))
        (py-ibitor-fallback:err x-32 y-33)
        (letrec* ((result-649 (py-call magic_method-643 y-33 x-32)))
          (if (py-test (py-is result-649 py-NotImplemented))
              (py-ibitor-fallback:err x-32 y-33)
              result-649)))))

(define (py-ibitor-fallback:err x-32 y-33)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for |=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-32)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-33)
                             (& "__name__")))
                    (&& "'")))))

(define (py-ifloordiv-fallback:inplace x-34 y-35)
  (letrec* ((magic_method-705
             (getattribute-from-obj-mro x-34 (&& "__ifloordiv__"))))
    (if (py-test (py-is magic_method-705 py-absent))
        (py-ifloordiv-fallback:normal x-34 y-35)
        (letrec* ((result-711 (py-call magic_method-705 x-34 y-35)))
          (if (py-test (py-is result-711 py-NotImplemented))
              (py-ifloordiv-fallback:normal x-34 y-35)
              result-711)))))

(define (py-ifloordiv-fallback:normal x-34 y-35)
  (letrec* ((magic_method-695
             (getattribute-from-obj-mro x-34 (&& "__floordiv__"))))
    (if (py-test (py-is magic_method-695 py-absent))
        (py-ifloordiv-fallback:reflected x-34 y-35)
        (letrec* ((result-701 (py-call magic_method-695 x-34 y-35)))
          (if (py-test (py-is result-701 py-NotImplemented))
              (py-ifloordiv-fallback:reflected x-34 y-35)
              result-701)))))

(define (py-ifloordiv-fallback:reflected x-34 y-35)
  (letrec* ((magic_method-685
             (getattribute-from-obj-mro y-35 (&& "__rfloordiv__"))))
    (if (py-test (py-is magic_method-685 py-absent))
        (py-ifloordiv-fallback:err x-34 y-35)
        (letrec* ((result-691 (py-call magic_method-685 y-35 x-34)))
          (if (py-test (py-is result-691 py-NotImplemented))
              (py-ifloordiv-fallback:err x-34 y-35)
              result-691)))))

(define (py-ifloordiv-fallback:err x-34 y-35)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for //=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-34)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-35)
                             (& "__name__")))
                    (&& "'")))))

(define (py-ilshift-fallback:inplace x-36 y-37)
  (letrec* ((magic_method-747
             (getattribute-from-obj-mro x-36 (&& "__ilshift__"))))
    (if (py-test (py-is magic_method-747 py-absent))
        (py-ilshift-fallback:normal x-36 y-37)
        (letrec* ((result-753 (py-call magic_method-747 x-36 y-37)))
          (if (py-test (py-is result-753 py-NotImplemented))
              (py-ilshift-fallback:normal x-36 y-37)
              result-753)))))

(define (py-ilshift-fallback:normal x-36 y-37)
  (letrec* ((magic_method-737
             (getattribute-from-obj-mro x-36 (&& "__lshift__"))))
    (if (py-test (py-is magic_method-737 py-absent))
        (py-ilshift-fallback:reflected x-36 y-37)
        (letrec* ((result-743 (py-call magic_method-737 x-36 y-37)))
          (if (py-test (py-is result-743 py-NotImplemented))
              (py-ilshift-fallback:reflected x-36 y-37)
              result-743)))))

(define (py-ilshift-fallback:reflected x-36 y-37)
  (letrec* ((magic_method-727
             (getattribute-from-obj-mro y-37 (&& "__rlshift__"))))
    (if (py-test (py-is magic_method-727 py-absent))
        (py-ilshift-fallback:err x-36 y-37)
        (letrec* ((result-733 (py-call magic_method-727 y-37 x-36)))
          (if (py-test (py-is result-733 py-NotImplemented))
              (py-ilshift-fallback:err x-36 y-37)
              result-733)))))

(define (py-ilshift-fallback:err x-36 y-37)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for <<=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-36)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-37)
                             (& "__name__")))
                    (&& "'")))))

(define (py-imatmul-fallback:inplace x-38 y-39)
  (letrec* ((magic_method-789
             (getattribute-from-obj-mro x-38 (&& "__imatmul__"))))
    (if (py-test (py-is magic_method-789 py-absent))
        (py-imatmul-fallback:normal x-38 y-39)
        (letrec* ((result-795 (py-call magic_method-789 x-38 y-39)))
          (if (py-test (py-is result-795 py-NotImplemented))
              (py-imatmul-fallback:normal x-38 y-39)
              result-795)))))

(define (py-imatmul-fallback:normal x-38 y-39)
  (letrec* ((magic_method-779
             (getattribute-from-obj-mro x-38 (&& "__matmul__"))))
    (if (py-test (py-is magic_method-779 py-absent))
        (py-imatmul-fallback:reflected x-38 y-39)
        (letrec* ((result-785 (py-call magic_method-779 x-38 y-39)))
          (if (py-test (py-is result-785 py-NotImplemented))
              (py-imatmul-fallback:reflected x-38 y-39)
              result-785)))))

(define (py-imatmul-fallback:reflected x-38 y-39)
  (letrec* ((magic_method-769
             (getattribute-from-obj-mro y-39 (&& "__rmatmul__"))))
    (if (py-test (py-is magic_method-769 py-absent))
        (py-imatmul-fallback:err x-38 y-39)
        (letrec* ((result-775 (py-call magic_method-769 y-39 x-38)))
          (if (py-test (py-is result-775 py-NotImplemented))
              (py-imatmul-fallback:err x-38 y-39)
              result-775)))))

(define (py-imatmul-fallback:err x-38 y-39)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for @=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-38)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-39)
                             (& "__name__")))
                    (&& "'")))))

(define (py-imod-fallback:inplace x-40 y-41)
  (letrec* ((magic_method-831
             (getattribute-from-obj-mro x-40 (&& "__imod__"))))
    (if (py-test (py-is magic_method-831 py-absent))
        (py-imod-fallback:normal x-40 y-41)
        (letrec* ((result-837 (py-call magic_method-831 x-40 y-41)))
          (if (py-test (py-is result-837 py-NotImplemented))
              (py-imod-fallback:normal x-40 y-41)
              result-837)))))

(define (py-imod-fallback:normal x-40 y-41)
  (letrec* ((magic_method-821 (getattribute-from-obj-mro x-40 (&& "__mod__"))))
    (if (py-test (py-is magic_method-821 py-absent))
        (py-imod-fallback:reflected x-40 y-41)
        (letrec* ((result-827 (py-call magic_method-821 x-40 y-41)))
          (if (py-test (py-is result-827 py-NotImplemented))
              (py-imod-fallback:reflected x-40 y-41)
              result-827)))))

(define (py-imod-fallback:reflected x-40 y-41)
  (letrec* ((magic_method-811
             (getattribute-from-obj-mro y-41 (&& "__rmod__"))))
    (if (py-test (py-is magic_method-811 py-absent))
        (py-imod-fallback:err x-40 y-41)
        (letrec* ((result-817 (py-call magic_method-811 y-41 x-40)))
          (if (py-test (py-is result-817 py-NotImplemented))
              (py-imod-fallback:err x-40 y-41)
              result-817)))))

(define (py-imod-fallback:err x-40 y-41)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for %=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-40)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-41)
                             (& "__name__")))
                    (&& "'")))))

(define (py-imul-fallback:inplace x-42 y-43)
  (letrec* ((magic_method-873
             (getattribute-from-obj-mro x-42 (&& "__imul__"))))
    (if (py-test (py-is magic_method-873 py-absent))
        (py-imul-fallback:normal x-42 y-43)
        (letrec* ((result-879 (py-call magic_method-873 x-42 y-43)))
          (if (py-test (py-is result-879 py-NotImplemented))
              (py-imul-fallback:normal x-42 y-43)
              result-879)))))

(define (py-imul-fallback:normal x-42 y-43)
  (letrec* ((magic_method-863 (getattribute-from-obj-mro x-42 (&& "__mul__"))))
    (if (py-test (py-is magic_method-863 py-absent))
        (py-imul-fallback:reflected x-42 y-43)
        (letrec* ((result-869 (py-call magic_method-863 x-42 y-43)))
          (if (py-test (py-is result-869 py-NotImplemented))
              (py-imul-fallback:reflected x-42 y-43)
              result-869)))))

(define (py-imul-fallback:reflected x-42 y-43)
  (letrec* ((magic_method-853
             (getattribute-from-obj-mro y-43 (&& "__rmul__"))))
    (if (py-test (py-is magic_method-853 py-absent))
        (py-imul-fallback:err x-42 y-43)
        (letrec* ((result-859 (py-call magic_method-853 y-43 x-42)))
          (if (py-test (py-is result-859 py-NotImplemented))
              (py-imul-fallback:err x-42 y-43)
              result-859)))))

(define (py-imul-fallback:err x-42 y-43)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for *=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-42)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-43)
                             (& "__name__")))
                    (&& "'")))))

(define (py-ipow-fallback:inplace x-44 y-45)
  (letrec* ((magic_method-915
             (getattribute-from-obj-mro x-44 (&& "__ipow__"))))
    (if (py-test (py-is magic_method-915 py-absent))
        (py-ipow-fallback:normal x-44 y-45)
        (letrec* ((result-921 (py-call magic_method-915 x-44 y-45)))
          (if (py-test (py-is result-921 py-NotImplemented))
              (py-ipow-fallback:normal x-44 y-45)
              result-921)))))

(define (py-ipow-fallback:normal x-44 y-45)
  (letrec* ((magic_method-905 (getattribute-from-obj-mro x-44 (&& "__pow__"))))
    (if (py-test (py-is magic_method-905 py-absent))
        (py-ipow-fallback:reflected x-44 y-45)
        (letrec* ((result-911 (py-call magic_method-905 x-44 y-45)))
          (if (py-test (py-is result-911 py-NotImplemented))
              (py-ipow-fallback:reflected x-44 y-45)
              result-911)))))

(define (py-ipow-fallback:reflected x-44 y-45)
  (letrec* ((magic_method-895
             (getattribute-from-obj-mro y-45 (&& "__rpow__"))))
    (if (py-test (py-is magic_method-895 py-absent))
        (py-ipow-fallback:err x-44 y-45)
        (letrec* ((result-901 (py-call magic_method-895 y-45 x-44)))
          (if (py-test (py-is result-901 py-NotImplemented))
              (py-ipow-fallback:err x-44 y-45)
              result-901)))))

(define (py-ipow-fallback:err x-44 y-45)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for **=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-44)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-45)
                             (& "__name__")))
                    (&& "'")))))

(define (py-irshift-fallback:inplace x-46 y-47)
  (letrec* ((magic_method-957
             (getattribute-from-obj-mro x-46 (&& "__irshift__"))))
    (if (py-test (py-is magic_method-957 py-absent))
        (py-irshift-fallback:normal x-46 y-47)
        (letrec* ((result-963 (py-call magic_method-957 x-46 y-47)))
          (if (py-test (py-is result-963 py-NotImplemented))
              (py-irshift-fallback:normal x-46 y-47)
              result-963)))))

(define (py-irshift-fallback:normal x-46 y-47)
  (letrec* ((magic_method-947
             (getattribute-from-obj-mro x-46 (&& "__rshift__"))))
    (if (py-test (py-is magic_method-947 py-absent))
        (py-irshift-fallback:reflected x-46 y-47)
        (letrec* ((result-953 (py-call magic_method-947 x-46 y-47)))
          (if (py-test (py-is result-953 py-NotImplemented))
              (py-irshift-fallback:reflected x-46 y-47)
              result-953)))))

(define (py-irshift-fallback:reflected x-46 y-47)
  (letrec* ((magic_method-937
             (getattribute-from-obj-mro y-47 (&& "__rrshift__"))))
    (if (py-test (py-is magic_method-937 py-absent))
        (py-irshift-fallback:err x-46 y-47)
        (letrec* ((result-943 (py-call magic_method-937 y-47 x-46)))
          (if (py-test (py-is result-943 py-NotImplemented))
              (py-irshift-fallback:err x-46 y-47)
              result-943)))))

(define (py-irshift-fallback:err x-46 y-47)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for >>=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-46)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-47)
                             (& "__name__")))
                    (&& "'")))))

(define (py-isub-fallback:inplace x-48 y-49)
  (letrec* ((magic_method-999
             (getattribute-from-obj-mro x-48 (&& "__isub__"))))
    (if (py-test (py-is magic_method-999 py-absent))
        (py-isub-fallback:normal x-48 y-49)
        (letrec* ((result-1005 (py-call magic_method-999 x-48 y-49)))
          (if (py-test (py-is result-1005 py-NotImplemented))
              (py-isub-fallback:normal x-48 y-49)
              result-1005)))))

(define (py-isub-fallback:normal x-48 y-49)
  (letrec* ((magic_method-989 (getattribute-from-obj-mro x-48 (&& "__sub__"))))
    (if (py-test (py-is magic_method-989 py-absent))
        (py-isub-fallback:reflected x-48 y-49)
        (letrec* ((result-995 (py-call magic_method-989 x-48 y-49)))
          (if (py-test (py-is result-995 py-NotImplemented))
              (py-isub-fallback:reflected x-48 y-49)
              result-995)))))

(define (py-isub-fallback:reflected x-48 y-49)
  (letrec* ((magic_method-979
             (getattribute-from-obj-mro y-49 (&& "__rsub__"))))
    (if (py-test (py-is magic_method-979 py-absent))
        (py-isub-fallback:err x-48 y-49)
        (letrec* ((result-985 (py-call magic_method-979 y-49 x-48)))
          (if (py-test (py-is result-985 py-NotImplemented))
              (py-isub-fallback:err x-48 y-49)
              result-985)))))

(define (py-isub-fallback:err x-48 y-49)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for -=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-48)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-49)
                             (& "__name__")))
                    (&& "'")))))

(define (py-itruediv-fallback:inplace x-50 y-51)
  (letrec* ((magic_method-1041
             (getattribute-from-obj-mro x-50 (&& "__itruediv__"))))
    (if (py-test (py-is magic_method-1041 py-absent))
        (py-itruediv-fallback:normal x-50 y-51)
        (letrec* ((result-1047 (py-call magic_method-1041 x-50 y-51)))
          (if (py-test (py-is result-1047 py-NotImplemented))
              (py-itruediv-fallback:normal x-50 y-51)
              result-1047)))))

(define (py-itruediv-fallback:normal x-50 y-51)
  (letrec* ((magic_method-1031
             (getattribute-from-obj-mro x-50 (&& "__truediv__"))))
    (if (py-test (py-is magic_method-1031 py-absent))
        (py-itruediv-fallback:reflected x-50 y-51)
        (letrec* ((result-1037 (py-call magic_method-1031 x-50 y-51)))
          (if (py-test (py-is result-1037 py-NotImplemented))
              (py-itruediv-fallback:reflected x-50 y-51)
              result-1037)))))

(define (py-itruediv-fallback:reflected x-50 y-51)
  (letrec* ((magic_method-1021
             (getattribute-from-obj-mro y-51 (&& "__rtruediv__"))))
    (if (py-test (py-is magic_method-1021 py-absent))
        (py-itruediv-fallback:err x-50 y-51)
        (letrec* ((result-1027 (py-call magic_method-1021 y-51 x-50)))
          (if (py-test (py-is result-1027 py-NotImplemented))
              (py-itruediv-fallback:err x-50 y-51)
              result-1027)))))

(define (py-itruediv-fallback:err x-50 y-51)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for /=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-50)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-51)
                             (& "__name__")))
                    (&& "'")))))

(define (py-ixor-fallback:inplace x-52 y-53)
  (letrec* ((magic_method-1083
             (getattribute-from-obj-mro x-52 (&& "__ixor__"))))
    (if (py-test (py-is magic_method-1083 py-absent))
        (py-ixor-fallback:normal x-52 y-53)
        (letrec* ((result-1089 (py-call magic_method-1083 x-52 y-53)))
          (if (py-test (py-is result-1089 py-NotImplemented))
              (py-ixor-fallback:normal x-52 y-53)
              result-1089)))))

(define (py-ixor-fallback:normal x-52 y-53)
  (letrec* ((magic_method-1073
             (getattribute-from-obj-mro x-52 (&& "__xor__"))))
    (if (py-test (py-is magic_method-1073 py-absent))
        (py-ixor-fallback:reflected x-52 y-53)
        (letrec* ((result-1079 (py-call magic_method-1073 x-52 y-53)))
          (if (py-test (py-is result-1079 py-NotImplemented))
              (py-ixor-fallback:reflected x-52 y-53)
              result-1079)))))

(define (py-ixor-fallback:reflected x-52 y-53)
  (letrec* ((magic_method-1063
             (getattribute-from-obj-mro y-53 (&& "__rxor__"))))
    (if (py-test (py-is magic_method-1063 py-absent))
        (py-ixor-fallback:err x-52 y-53)
        (letrec* ((result-1069 (py-call magic_method-1063 y-53 x-52)))
          (if (py-test (py-is result-1069 py-NotImplemented))
              (py-ixor-fallback:err x-52 y-53)
              result-1069)))))

(define (py-ixor-fallback:err x-52 y-53)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for ^=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-52)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-53)
                             (& "__name__")))
                    (&& "'")))))

(define (py-pos-fallback:normal x-54)
  (letrec* ((magic_method-1100
             (getattribute-from-obj-mro x-54 (&& "__pos__"))))
    (if (py-test (py-is magic_method-1100 py-absent))
        (py-pos-fallback:err x-54)
        (py-call magic_method-1100 x-54))))

(define (py-pos-fallback:err x-54)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (&& "bad operand type for unary +: '")
                            (py-getattribute
                             (py-call py-builtin-type x-54)
                             (& "__name__")))
                    (&& "'")))))

(define (py-neg-fallback:normal x-55)
  (letrec* ((magic_method-1113
             (getattribute-from-obj-mro x-55 (&& "__neg__"))))
    (if (py-test (py-is magic_method-1113 py-absent))
        (py-neg-fallback:err x-55)
        (py-call magic_method-1113 x-55))))

(define (py-neg-fallback:err x-55)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (&& "bad operand type for unary -: '")
                            (py-getattribute
                             (py-call py-builtin-type x-55)
                             (& "__name__")))
                    (&& "'")))))

(define (py-invert-fallback:normal x-56)
  (letrec* ((magic_method-1126
             (getattribute-from-obj-mro x-56 (&& "__invert__"))))
    (if (py-test (py-is magic_method-1126 py-absent))
        (py-invert-fallback:err x-56)
        (py-call magic_method-1126 x-56))))

(define (py-invert-fallback:err x-56)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (&& "bad operand type for unary ~: '")
                            (py-getattribute
                             (py-call py-builtin-type x-56)
                             (& "__name__")))
                    (&& "'")))))

(define (py-ge-fallback:normal x-57 y-58)
  (letrec* ((magic_method-1152 (getattribute-from-obj-mro x-57 (&& "__ge__"))))
    (if (py-test (py-is magic_method-1152 py-absent))
        (py-ge-fallback:reflected x-57 y-58)
        (letrec* ((result-1158 (py-call magic_method-1152 x-57 y-58)))
          (if (py-test (py-is result-1158 py-NotImplemented))
              (py-ge-fallback:reflected x-57 y-58)
              result-1158)))))

(define (py-ge-fallback:reflected x-57 y-58)
  (letrec* ((magic_method-1142 (getattribute-from-obj-mro y-58 (&& "__le__"))))
    (if (py-test (py-is magic_method-1142 py-absent))
        (py-ge-fallback:err x-57 y-58)
        (letrec* ((result-1148 (py-call magic_method-1142 y-58 x-57)))
          (if (py-test (py-is result-1148 py-NotImplemented))
              (py-ge-fallback:err x-57 y-58)
              result-1148)))))

(define (py-ge-fallback:err x-57 y-58)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "'>=' not supported between instances of '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-57)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-58)
                             (& "__name__")))
                    (&& "'")))))

(define (py-gt-fallback:normal x-59 y-60)
  (letrec* ((magic_method-1182 (getattribute-from-obj-mro x-59 (&& "__gt__"))))
    (if (py-test (py-is magic_method-1182 py-absent))
        (py-gt-fallback:reflected x-59 y-60)
        (letrec* ((result-1188 (py-call magic_method-1182 x-59 y-60)))
          (if (py-test (py-is result-1188 py-NotImplemented))
              (py-gt-fallback:reflected x-59 y-60)
              result-1188)))))

(define (py-gt-fallback:reflected x-59 y-60)
  (letrec* ((magic_method-1172 (getattribute-from-obj-mro y-60 (&& "__lt__"))))
    (if (py-test (py-is magic_method-1172 py-absent))
        (py-gt-fallback:err x-59 y-60)
        (letrec* ((result-1178 (py-call magic_method-1172 y-60 x-59)))
          (if (py-test (py-is result-1178 py-NotImplemented))
              (py-gt-fallback:err x-59 y-60)
              result-1178)))))

(define (py-gt-fallback:err x-59 y-60)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "'>' not supported between instances of '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-59)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-60)
                             (& "__name__")))
                    (&& "'")))))

(define (py-le-fallback:normal x-61 y-62)
  (letrec* ((magic_method-1212 (getattribute-from-obj-mro x-61 (&& "__le__"))))
    (if (py-test (py-is magic_method-1212 py-absent))
        (py-le-fallback:reflected x-61 y-62)
        (letrec* ((result-1218 (py-call magic_method-1212 x-61 y-62)))
          (if (py-test (py-is result-1218 py-NotImplemented))
              (py-le-fallback:reflected x-61 y-62)
              result-1218)))))

(define (py-le-fallback:reflected x-61 y-62)
  (letrec* ((magic_method-1202 (getattribute-from-obj-mro y-62 (&& "__ge__"))))
    (if (py-test (py-is magic_method-1202 py-absent))
        (py-le-fallback:err x-61 y-62)
        (letrec* ((result-1208 (py-call magic_method-1202 y-62 x-61)))
          (if (py-test (py-is result-1208 py-NotImplemented))
              (py-le-fallback:err x-61 y-62)
              result-1208)))))

(define (py-le-fallback:err x-61 y-62)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "'<=' not supported between instances of '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-61)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-62)
                             (& "__name__")))
                    (&& "'")))))

(define (py-lt-fallback:normal x-63 y-64)
  (letrec* ((magic_method-1242 (getattribute-from-obj-mro x-63 (&& "__lt__"))))
    (if (py-test (py-is magic_method-1242 py-absent))
        (py-lt-fallback:reflected x-63 y-64)
        (letrec* ((result-1248 (py-call magic_method-1242 x-63 y-64)))
          (if (py-test (py-is result-1248 py-NotImplemented))
              (py-lt-fallback:reflected x-63 y-64)
              result-1248)))))

(define (py-lt-fallback:reflected x-63 y-64)
  (letrec* ((magic_method-1232 (getattribute-from-obj-mro y-64 (&& "__gt__"))))
    (if (py-test (py-is magic_method-1232 py-absent))
        (py-lt-fallback:err x-63 y-64)
        (letrec* ((result-1238 (py-call magic_method-1232 y-64 x-63)))
          (if (py-test (py-is result-1238 py-NotImplemented))
              (py-lt-fallback:err x-63 y-64)
              result-1238)))))

(define (py-lt-fallback:err x-63 y-64)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "'<' not supported between instances of '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-63)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-64)
                             (& "__name__")))
                    (&& "'")))))

(define (py-eq-fallback:normal x-65 y-66)
  (letrec* ((magic_method-1270 (getattribute-from-obj-mro x-65 (&& "__eq__"))))
    (if (py-test (py-is magic_method-1270 py-absent))
        (py-eq-fallback:reflected x-65 y-66)
        (letrec* ((result-1276 (py-call magic_method-1270 x-65 y-66)))
          (if (py-test (py-is result-1276 py-NotImplemented))
              (py-eq-fallback:reflected x-65 y-66)
              result-1276)))))

(define (py-eq-fallback:reflected x-65 y-66)
  (letrec* ((magic_method-1260 (getattribute-from-obj-mro y-66 (&& "__eq__"))))
    (if (py-test (py-is magic_method-1260 py-absent))
        (py-eq-fallback:default x-65 y-66)
        (letrec* ((result-1266 (py-call magic_method-1260 y-66 x-65)))
          (if (py-test (py-is result-1266 py-NotImplemented))
              (py-eq-fallback:default x-65 y-66)
              result-1266)))))

(define (py-eq-fallback:default x-65 y-66) (py-is x-65 y-66))

(define (py-ne-fallback:normal x-67 y-68)
  (letrec* ((magic_method-1298 (getattribute-from-obj-mro x-67 (&& "__ne__"))))
    (if (py-test (py-is magic_method-1298 py-absent))
        (py-ne-fallback:reflected x-67 y-68)
        (letrec* ((result-1304 (py-call magic_method-1298 x-67 y-68)))
          (if (py-test (py-is result-1304 py-NotImplemented))
              (py-ne-fallback:reflected x-67 y-68)
              result-1304)))))

(define (py-ne-fallback:reflected x-67 y-68)
  (letrec* ((magic_method-1288 (getattribute-from-obj-mro y-68 (&& "__ne__"))))
    (if (py-test (py-is magic_method-1288 py-absent))
        (py-ne-fallback:default x-67 y-68)
        (letrec* ((result-1294 (py-call magic_method-1288 y-68 x-67)))
          (if (py-test (py-is result-1294 py-NotImplemented))
              (py-ne-fallback:default x-67 y-68)
              result-1294)))))

(define (py-ne-fallback:default x-67 y-68) (py-isnot x-67 y-68))

(define (py-maybe-trunc-fallback obj-69)
  (letrec* ((__trunc__-1308
             (getattribute-from-obj-mro obj-69 (&& "__trunc__"))))
    (if (py-test (py-is __trunc__-1308 py-absent))
        py-absent
        (letrec* ((result-1313 (py-call __trunc__-1308 obj-69)))
          (if (py-test (py-is (py-call py-builtin-type result-1313)
                              py-builtin-int))
              result-1313
              (py-throw
               (py-call py-builtin-TypeError
                        (py-add (py-add (&& "__trunc__ returned non-int type: '")
                                        (py-getattribute
                                         (py-call py-builtin-type obj-69)
                                         (& "__name__")))
                                (&& "'")))))))))

(define (py-trunc-fallback obj-70)
  (letrec* ((result-1318 (py-maybe-trunc-fallback obj-70)))
    (if (py-test (py-is result-1318 py-absent))
        (py-throw
         (py-call py-builtin-TypeError
                  (py-add (py-add (&& "type '")
                                  (py-getattribute
                                   (py-call py-builtin-type obj-70)
                                   (& "__name__")))
                          (&& "' doesn't define __trunc__ method"))))
        result-1318)))

(define (py-maybe-to-int-fallback obj-71)
  (letrec* ((__int__-1325 (getattribute-from-obj-mro obj-71 (&& "__int__"))))
    (if (py-test (py-is __int__-1325 py-absent))
        py-absent
        (letrec* ((result-1330 (py-call __int__-1325 obj-71)))
          (if (py-test (py-is (py-call py-builtin-type result-1330)
                              py-builtin-int))
              result-1330
              (py-throw
               (py-call py-builtin-TypeError
                        (py-add (py-add (&& "__int__ returned non-int type: '")
                                        (py-getattribute
                                         (py-call py-builtin-type obj-71)
                                         (& "__name__")))
                                (&& "'")))))))))

(define (py-to-int-fallback obj-72)
  (letrec* ((result-1335 (py-maybe-to-int-fallback obj-72)))
    (if (py-test (py-is result-1335 py-absent))
        (py-throw
         (py-call py-builtin-TypeError
                  (py-add (py-add (&& "'")
                                  (py-getattribute
                                   (py-call py-builtin-type obj-72)
                                   (& "__name__")))
                          (&& "' object cannot be interpreted as an integer"))))
        result-1335)))

(define (py-maybe-to-float-fallback obj-73)
  (letrec* ((__float__-1342
             (getattribute-from-obj-mro obj-73 (&& "__float__"))))
    (if (py-test (py-is __float__-1342 py-absent))
        py-absent
        (letrec* ((result-1347 (py-call __float__-1342 obj-73)))
          (if (py-isinstance? result-1347 py-builtin-float)
              result-1347
              (py-throw
               (py-call py-builtin-TypeError
                        (py-add (py-add (&& "__float__ returned non-float type: '")
                                        (py-getattribute
                                         (py-call py-builtin-type obj-73)
                                         (& "__name__")))
                                (&& "'")))))))))

(define (py-to-float-fallback obj-74)
  (letrec* ((result-1353 (py-maybe-to-float-fallback obj-74)))
    (if (py-test (py-is result-1353 py-absent))
        (py-throw
         (py-call py-builtin-TypeError
                  (py-add (py-add (&& "'")
                                  (py-getattribute
                                   (py-call py-builtin-type obj-74)
                                   (& "__name__")))
                          (&& "' object cannot be interpreted as a float"))))
        result-1353)))

(define (py-maybe-index-fallback obj-75)
  (letrec* ((__index__-1360
             (getattribute-from-obj-mro obj-75 (&& "__index__"))))
    (if (py-test (py-is __index__-1360 py-absent))
        py-absent
        (letrec* ((result-1365 (py-call __index__-1360 obj-75)))
          (if (py-test (py-is result-1365 py-absent))
              py-absent
              (if (py-has-type-sint? result-1365)
                  result-1365
                  (if (py-has-type-bint? result-1365)
                      (py-throw
                       (py-call py-builtin-OverflowError
                                (&& "cannot fit 'int' into an index-sized integer")))
                      (py-throw
                       (py-call py-builtin-TypeError
                                (py-add (py-add (&& "__index__ returned non-int type: '")
                                                (py-getattribute
                                                 (py-call py-builtin-type
                                                          obj-75)
                                                 (& "__name__")))
                                        (&& "'")))))))))))

(define (py-index-fallback obj-76)
  (letrec* ((result-1373 (py-maybe-index-fallback obj-76)))
    (if (py-test (py-is result-1373 py-absent))
        (py-throw
         (py-call py-builtin-TypeError
                  (py-add (py-add (&& "'")
                                  (py-getattribute
                                   (py-call py-builtin-type obj-76)
                                   (& "__name__")))
                          (&& "' object cannot be interpreted as an integer"))))
        result-1373)))

(define (py-maybe-len-fallback obj-77)
  (letrec* ((__len__-1380 (getattribute-from-obj-mro obj-77 (&& "__len__"))))
    (if (py-test (py-is __len__-1380 py-absent))
        py-absent
        (letrec* ((len_result-1385 (py-call __len__-1380 obj-77)))
          (py-index-fallback len_result-1385)))))

(define (py-len-fallback obj-78)
  (letrec* ((result-1388 (py-maybe-len-fallback obj-78)))
    (if (py-test (py-is result-1388 py-absent))
        (py-throw
         (py-call py-builtin-TypeError
                  (py-add (py-add (&& "object of type")
                                  (py-getattribute
                                   (py-call py-builtin-type obj-78)
                                   (& "__name__")))
                          (&& "has no len()"))))
        result-1388)))

(define (py-truth-fallback obj-79)
  (letrec* ((__bool__-1395 (getattribute-from-obj-mro obj-79 (&& "__bool__"))))
    (if (py-test (py-isnot __bool__-1395 py-absent))
        (letrec* ((result-1400 (py-call __bool__-1395 obj-79)))
          (if (py-test (py-is (py-call py-builtin-type result-1400)
                              py-builtin-bool))
              result-1400
              (py-throw
               (py-call py-builtin-TypeError
                        (py-add (py-add (&& "__bool__ should return bool, returned '")
                                        (py-getattribute
                                         (py-call py-builtin-type obj-79)
                                         (& "__name__")))
                                (&& "'"))))))
        (letrec* ((len_result-1405 (py-maybe-len-fallback obj-79)))
          (if (py-test (py-isnot len_result-1405 py-absent))
              (py-ne len_result-1405 (py-int-from-scheme 0))
              py-True)))))

(define (py-test-fallback obj-80)
  (py-bool-to-scheme-bool (py-truth-fallback obj-80)))

(define (py-getattribute-fallback obj-81 attr-82)
  (letrec* ((__getattribute__-1411
             (getattribute-from-obj-mro obj-81 (&& "__getattribute__"))))
    (with-handler
     (lambda ($%exc_0)
       (cond ((py-isinstance? $%exc_0 py-builtin-AttributeError)
              (letrec* ((__getattr__-1417
                         (getattribute-from-obj-mro
                          obj-81
                          (&& "__getattr__"))))
                (if (py-test (py-is __getattr__-1417 py-absent))
                    (py-throw $%exc_0)
                    (py-call __getattr__-1417 obj-81 attr-82))))
             (else (raise $%exc_0))))
     (py-call __getattribute__-1411 obj-81 attr-82))))

(define (py-setattribute-fallback obj-83 attr-84 val-85)
  (letrec* ((__setattr__-1420
             (getattribute-from-obj-mro obj-83 (&& "__setattr__"))))
    (py-call __setattr__-1420 obj-83 attr-84 val-85)))

(define (py-getitem-fallback obj-86 index-87)
  (letrec* ((__getitem__-1426
             (getattribute-from-obj-mro obj-86 (&& "__getitem__"))))
    (if (py-test (py-is __getitem__-1426 py-absent))
        (py-throw
         (py-call py-builtin-TypeError (&& "object is not subscriptable")))
        (py-call __getitem__-1426 obj-86 index-87))))

(define (py-setitem-fallback obj-88 index-89 value-90)
  (letrec* ((__setitem__-1433
             (getattribute-from-obj-mro obj-88 (&& "__setitem__"))))
    (if (py-test (py-is __setitem__-1433 py-absent))
        (py-throw
         (py-call py-builtin-TypeError
                  (&& "object does not support item assignment")))
        (py-call __setitem__-1433 obj-88 index-89 value-90))))

(define (py-delitem-fallback obj-91 index-92)
  (letrec* ((__delitem__-1441
             (getattribute-from-obj-mro obj-91 (&& "__delitem__"))))
    (if (py-test (py-is __delitem__-1441 py-absent))
        (py-throw
         (py-call py-builtin-TypeError
                  (&& "object does not support item deletion")))
        (py-call __delitem__-1441 obj-91 index-92))))

(define (py-enter-fallback obj-93)
  (letrec* ((__enter__-1448
             (getattribute-from-obj-mro obj-93 (&& "__enter__"))))
    (if (py-test (py-is __enter__-1448 py-absent))
        (py-throw (py-call py-builtin-AttributeError (&& "__enter__")))
        (py-call __enter__-1448 obj-93))))

(define (py-exit-fallback obj-94 exc-95)
  (letrec* ((__exit__-1454 (getattribute-from-obj-mro obj-94 (&& "__exit__"))))
    (if (py-test (py-is __exit__-1454 py-absent))
        (py-throw (py-call py-builtin-AttributeError (&& "__exit__")))
        (if (py-test (py-is exc-95 py-None))
            (py-call __exit__-1454 obj-94 py-None py-None py-None)
            (letrec* ((exit_result-1461
                       (py-call __exit__-1454
                                obj-94
                                (py-call py-builtin-type exc-95)
                                exc-95
                                py-None)))
              (if (py-test exit_result-1461) py-None (py-throw exc-95)))))))

