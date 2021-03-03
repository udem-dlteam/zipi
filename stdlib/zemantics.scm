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
  (letrec* ((magic_method-160 (getattribute-from-obj-mro x-2 (&& "__add__"))))
    (if (py-test (py-is magic_method-160 py-absent))
        (py-add-fallback:reflected x-2 y-3)
        (letrec* ((result-166 (py-call magic_method-160 x-2 y-3)))
          (if (py-test (py-is result-166 py-NotImplemented))
              (py-add-fallback:reflected x-2 y-3)
              result-166)))))

(define (py-add-fallback:reflected x-2 y-3)
  (letrec* ((magic_method-150 (getattribute-from-obj-mro y-3 (&& "__radd__"))))
    (if (py-test (py-is magic_method-150 py-absent))
        (py-add-fallback:err x-2 y-3)
        (letrec* ((result-156 (py-call magic_method-150 y-3 x-2)))
          (if (py-test (py-is result-156 py-NotImplemented))
              (py-add-fallback:err x-2 y-3)
              result-156)))))

(define (py-add-fallback:err x-2 y-3)
  (py-throw
   (py-builtin-TypeError
    (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for +: '")
                                    (py-getattribute
                                     (py-builtin-type x-2)
                                     (& "__name__")))
                            (&& "' and '"))
                    (py-getattribute (py-builtin-type y-3) (& "__name__")))
            (&& "'")))))

(define (py-bitand-fallback:normal x-4 y-5)
  (letrec* ((magic_method-190 (getattribute-from-obj-mro x-4 (&& "__and__"))))
    (if (py-test (py-is magic_method-190 py-absent))
        (py-bitand-fallback:reflected x-4 y-5)
        (letrec* ((result-196 (py-call magic_method-190 x-4 y-5)))
          (if (py-test (py-is result-196 py-NotImplemented))
              (py-bitand-fallback:reflected x-4 y-5)
              result-196)))))

(define (py-bitand-fallback:reflected x-4 y-5)
  (letrec* ((magic_method-180 (getattribute-from-obj-mro y-5 (&& "__rand__"))))
    (if (py-test (py-is magic_method-180 py-absent))
        (py-bitand-fallback:err x-4 y-5)
        (letrec* ((result-186 (py-call magic_method-180 y-5 x-4)))
          (if (py-test (py-is result-186 py-NotImplemented))
              (py-bitand-fallback:err x-4 y-5)
              result-186)))))

(define (py-bitand-fallback:err x-4 y-5)
  (py-throw
   (py-builtin-TypeError
    (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for &: '")
                                    (py-getattribute
                                     (py-builtin-type x-4)
                                     (& "__name__")))
                            (&& "' and '"))
                    (py-getattribute (py-builtin-type y-5) (& "__name__")))
            (&& "'")))))

(define (py-bitor-fallback:normal x-6 y-7)
  (letrec* ((magic_method-220 (getattribute-from-obj-mro x-6 (&& "__or__"))))
    (if (py-test (py-is magic_method-220 py-absent))
        (py-bitor-fallback:reflected x-6 y-7)
        (letrec* ((result-226 (py-call magic_method-220 x-6 y-7)))
          (if (py-test (py-is result-226 py-NotImplemented))
              (py-bitor-fallback:reflected x-6 y-7)
              result-226)))))

(define (py-bitor-fallback:reflected x-6 y-7)
  (letrec* ((magic_method-210 (getattribute-from-obj-mro y-7 (&& "__ror__"))))
    (if (py-test (py-is magic_method-210 py-absent))
        (py-bitor-fallback:err x-6 y-7)
        (letrec* ((result-216 (py-call magic_method-210 y-7 x-6)))
          (if (py-test (py-is result-216 py-NotImplemented))
              (py-bitor-fallback:err x-6 y-7)
              result-216)))))

(define (py-bitor-fallback:err x-6 y-7)
  (py-throw
   (py-builtin-TypeError
    (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for |: '")
                                    (py-getattribute
                                     (py-builtin-type x-6)
                                     (& "__name__")))
                            (&& "' and '"))
                    (py-getattribute (py-builtin-type y-7) (& "__name__")))
            (&& "'")))))

(define (py-floordiv-fallback:normal x-8 y-9)
  (letrec* ((magic_method-250
             (getattribute-from-obj-mro x-8 (&& "__floordiv__"))))
    (if (py-test (py-is magic_method-250 py-absent))
        (py-floordiv-fallback:reflected x-8 y-9)
        (letrec* ((result-256 (py-call magic_method-250 x-8 y-9)))
          (if (py-test (py-is result-256 py-NotImplemented))
              (py-floordiv-fallback:reflected x-8 y-9)
              result-256)))))

(define (py-floordiv-fallback:reflected x-8 y-9)
  (letrec* ((magic_method-240
             (getattribute-from-obj-mro y-9 (&& "__rfloordiv__"))))
    (if (py-test (py-is magic_method-240 py-absent))
        (py-floordiv-fallback:err x-8 y-9)
        (letrec* ((result-246 (py-call magic_method-240 y-9 x-8)))
          (if (py-test (py-is result-246 py-NotImplemented))
              (py-floordiv-fallback:err x-8 y-9)
              result-246)))))

(define (py-floordiv-fallback:err x-8 y-9)
  (py-throw
   (py-builtin-TypeError
    (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for //: '")
                                    (py-getattribute
                                     (py-builtin-type x-8)
                                     (& "__name__")))
                            (&& "' and '"))
                    (py-getattribute (py-builtin-type y-9) (& "__name__")))
            (&& "'")))))

(define (py-lshift-fallback:normal x-10 y-11)
  (letrec* ((magic_method-280
             (getattribute-from-obj-mro x-10 (&& "__lshift__"))))
    (if (py-test (py-is magic_method-280 py-absent))
        (py-lshift-fallback:reflected x-10 y-11)
        (letrec* ((result-286 (py-call magic_method-280 x-10 y-11)))
          (if (py-test (py-is result-286 py-NotImplemented))
              (py-lshift-fallback:reflected x-10 y-11)
              result-286)))))

(define (py-lshift-fallback:reflected x-10 y-11)
  (letrec* ((magic_method-270
             (getattribute-from-obj-mro y-11 (&& "__rlshift__"))))
    (if (py-test (py-is magic_method-270 py-absent))
        (py-lshift-fallback:err x-10 y-11)
        (letrec* ((result-276 (py-call magic_method-270 y-11 x-10)))
          (if (py-test (py-is result-276 py-NotImplemented))
              (py-lshift-fallback:err x-10 y-11)
              result-276)))))

(define (py-lshift-fallback:err x-10 y-11)
  (py-throw
   (py-builtin-TypeError
    (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for <<: '")
                                    (py-getattribute
                                     (py-builtin-type x-10)
                                     (& "__name__")))
                            (&& "' and '"))
                    (py-getattribute (py-builtin-type y-11) (& "__name__")))
            (&& "'")))))

(define (py-matmul-fallback:normal x-12 y-13)
  (letrec* ((magic_method-310
             (getattribute-from-obj-mro x-12 (&& "__matmul__"))))
    (if (py-test (py-is magic_method-310 py-absent))
        (py-matmul-fallback:reflected x-12 y-13)
        (letrec* ((result-316 (py-call magic_method-310 x-12 y-13)))
          (if (py-test (py-is result-316 py-NotImplemented))
              (py-matmul-fallback:reflected x-12 y-13)
              result-316)))))

(define (py-matmul-fallback:reflected x-12 y-13)
  (letrec* ((magic_method-300
             (getattribute-from-obj-mro y-13 (&& "__rmatmul__"))))
    (if (py-test (py-is magic_method-300 py-absent))
        (py-matmul-fallback:err x-12 y-13)
        (letrec* ((result-306 (py-call magic_method-300 y-13 x-12)))
          (if (py-test (py-is result-306 py-NotImplemented))
              (py-matmul-fallback:err x-12 y-13)
              result-306)))))

(define (py-matmul-fallback:err x-12 y-13)
  (py-throw
   (py-builtin-TypeError
    (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for @: '")
                                    (py-getattribute
                                     (py-builtin-type x-12)
                                     (& "__name__")))
                            (&& "' and '"))
                    (py-getattribute (py-builtin-type y-13) (& "__name__")))
            (&& "'")))))

(define (py-mod-fallback:normal x-14 y-15)
  (letrec* ((magic_method-340 (getattribute-from-obj-mro x-14 (&& "__mod__"))))
    (if (py-test (py-is magic_method-340 py-absent))
        (py-mod-fallback:reflected x-14 y-15)
        (letrec* ((result-346 (py-call magic_method-340 x-14 y-15)))
          (if (py-test (py-is result-346 py-NotImplemented))
              (py-mod-fallback:reflected x-14 y-15)
              result-346)))))

(define (py-mod-fallback:reflected x-14 y-15)
  (letrec* ((magic_method-330
             (getattribute-from-obj-mro y-15 (&& "__rmod__"))))
    (if (py-test (py-is magic_method-330 py-absent))
        (py-mod-fallback:err x-14 y-15)
        (letrec* ((result-336 (py-call magic_method-330 y-15 x-14)))
          (if (py-test (py-is result-336 py-NotImplemented))
              (py-mod-fallback:err x-14 y-15)
              result-336)))))

(define (py-mod-fallback:err x-14 y-15)
  (py-throw
   (py-builtin-TypeError
    (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for %: '")
                                    (py-getattribute
                                     (py-builtin-type x-14)
                                     (& "__name__")))
                            (&& "' and '"))
                    (py-getattribute (py-builtin-type y-15) (& "__name__")))
            (&& "'")))))

(define (py-mul-fallback:normal x-16 y-17)
  (letrec* ((magic_method-370 (getattribute-from-obj-mro x-16 (&& "__mul__"))))
    (if (py-test (py-is magic_method-370 py-absent))
        (py-mul-fallback:reflected x-16 y-17)
        (letrec* ((result-376 (py-call magic_method-370 x-16 y-17)))
          (if (py-test (py-is result-376 py-NotImplemented))
              (py-mul-fallback:reflected x-16 y-17)
              result-376)))))

(define (py-mul-fallback:reflected x-16 y-17)
  (letrec* ((magic_method-360
             (getattribute-from-obj-mro y-17 (&& "__rmul__"))))
    (if (py-test (py-is magic_method-360 py-absent))
        (py-mul-fallback:err x-16 y-17)
        (letrec* ((result-366 (py-call magic_method-360 y-17 x-16)))
          (if (py-test (py-is result-366 py-NotImplemented))
              (py-mul-fallback:err x-16 y-17)
              result-366)))))

(define (py-mul-fallback:err x-16 y-17)
  (py-throw
   (py-builtin-TypeError
    (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for *: '")
                                    (py-getattribute
                                     (py-builtin-type x-16)
                                     (& "__name__")))
                            (&& "' and '"))
                    (py-getattribute (py-builtin-type y-17) (& "__name__")))
            (&& "'")))))

(define (py-pow-fallback:normal x-18 y-19)
  (letrec* ((magic_method-400 (getattribute-from-obj-mro x-18 (&& "__pow__"))))
    (if (py-test (py-is magic_method-400 py-absent))
        (py-pow-fallback:reflected x-18 y-19)
        (letrec* ((result-406 (py-call magic_method-400 x-18 y-19)))
          (if (py-test (py-is result-406 py-NotImplemented))
              (py-pow-fallback:reflected x-18 y-19)
              result-406)))))

(define (py-pow-fallback:reflected x-18 y-19)
  (letrec* ((magic_method-390
             (getattribute-from-obj-mro y-19 (&& "__rpow__"))))
    (if (py-test (py-is magic_method-390 py-absent))
        (py-pow-fallback:err x-18 y-19)
        (letrec* ((result-396 (py-call magic_method-390 y-19 x-18)))
          (if (py-test (py-is result-396 py-NotImplemented))
              (py-pow-fallback:err x-18 y-19)
              result-396)))))

(define (py-pow-fallback:err x-18 y-19)
  (py-throw
   (py-builtin-TypeError
    (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for **: '")
                                    (py-getattribute
                                     (py-builtin-type x-18)
                                     (& "__name__")))
                            (&& "' and '"))
                    (py-getattribute (py-builtin-type y-19) (& "__name__")))
            (&& "'")))))

(define (py-rshift-fallback:normal x-20 y-21)
  (letrec* ((magic_method-430
             (getattribute-from-obj-mro x-20 (&& "__rshift__"))))
    (if (py-test (py-is magic_method-430 py-absent))
        (py-rshift-fallback:reflected x-20 y-21)
        (letrec* ((result-436 (py-call magic_method-430 x-20 y-21)))
          (if (py-test (py-is result-436 py-NotImplemented))
              (py-rshift-fallback:reflected x-20 y-21)
              result-436)))))

(define (py-rshift-fallback:reflected x-20 y-21)
  (letrec* ((magic_method-420
             (getattribute-from-obj-mro y-21 (&& "__rrshift__"))))
    (if (py-test (py-is magic_method-420 py-absent))
        (py-rshift-fallback:err x-20 y-21)
        (letrec* ((result-426 (py-call magic_method-420 y-21 x-20)))
          (if (py-test (py-is result-426 py-NotImplemented))
              (py-rshift-fallback:err x-20 y-21)
              result-426)))))

(define (py-rshift-fallback:err x-20 y-21)
  (py-throw
   (py-builtin-TypeError
    (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for >>: '")
                                    (py-getattribute
                                     (py-builtin-type x-20)
                                     (& "__name__")))
                            (&& "' and '"))
                    (py-getattribute (py-builtin-type y-21) (& "__name__")))
            (&& "'")))))

(define (py-sub-fallback:normal x-22 y-23)
  (letrec* ((magic_method-460 (getattribute-from-obj-mro x-22 (&& "__sub__"))))
    (if (py-test (py-is magic_method-460 py-absent))
        (py-sub-fallback:reflected x-22 y-23)
        (letrec* ((result-466 (py-call magic_method-460 x-22 y-23)))
          (if (py-test (py-is result-466 py-NotImplemented))
              (py-sub-fallback:reflected x-22 y-23)
              result-466)))))

(define (py-sub-fallback:reflected x-22 y-23)
  (letrec* ((magic_method-450
             (getattribute-from-obj-mro y-23 (&& "__rsub__"))))
    (if (py-test (py-is magic_method-450 py-absent))
        (py-sub-fallback:err x-22 y-23)
        (letrec* ((result-456 (py-call magic_method-450 y-23 x-22)))
          (if (py-test (py-is result-456 py-NotImplemented))
              (py-sub-fallback:err x-22 y-23)
              result-456)))))

(define (py-sub-fallback:err x-22 y-23)
  (py-throw
   (py-builtin-TypeError
    (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for -: '")
                                    (py-getattribute
                                     (py-builtin-type x-22)
                                     (& "__name__")))
                            (&& "' and '"))
                    (py-getattribute (py-builtin-type y-23) (& "__name__")))
            (&& "'")))))

(define (py-truediv-fallback:normal x-24 y-25)
  (letrec* ((magic_method-490
             (getattribute-from-obj-mro x-24 (&& "__truediv__"))))
    (if (py-test (py-is magic_method-490 py-absent))
        (py-truediv-fallback:reflected x-24 y-25)
        (letrec* ((result-496 (py-call magic_method-490 x-24 y-25)))
          (if (py-test (py-is result-496 py-NotImplemented))
              (py-truediv-fallback:reflected x-24 y-25)
              result-496)))))

(define (py-truediv-fallback:reflected x-24 y-25)
  (letrec* ((magic_method-480
             (getattribute-from-obj-mro y-25 (&& "__rtruediv__"))))
    (if (py-test (py-is magic_method-480 py-absent))
        (py-truediv-fallback:err x-24 y-25)
        (letrec* ((result-486 (py-call magic_method-480 y-25 x-24)))
          (if (py-test (py-is result-486 py-NotImplemented))
              (py-truediv-fallback:err x-24 y-25)
              result-486)))))

(define (py-truediv-fallback:err x-24 y-25)
  (py-throw
   (py-builtin-TypeError
    (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for /: '")
                                    (py-getattribute
                                     (py-builtin-type x-24)
                                     (& "__name__")))
                            (&& "' and '"))
                    (py-getattribute (py-builtin-type y-25) (& "__name__")))
            (&& "'")))))

(define (py-xor-fallback:normal x-26 y-27)
  (letrec* ((magic_method-520 (getattribute-from-obj-mro x-26 (&& "__xor__"))))
    (if (py-test (py-is magic_method-520 py-absent))
        (py-xor-fallback:reflected x-26 y-27)
        (letrec* ((result-526 (py-call magic_method-520 x-26 y-27)))
          (if (py-test (py-is result-526 py-NotImplemented))
              (py-xor-fallback:reflected x-26 y-27)
              result-526)))))

(define (py-xor-fallback:reflected x-26 y-27)
  (letrec* ((magic_method-510
             (getattribute-from-obj-mro y-27 (&& "__rxor__"))))
    (if (py-test (py-is magic_method-510 py-absent))
        (py-xor-fallback:err x-26 y-27)
        (letrec* ((result-516 (py-call magic_method-510 y-27 x-26)))
          (if (py-test (py-is result-516 py-NotImplemented))
              (py-xor-fallback:err x-26 y-27)
              result-516)))))

(define (py-xor-fallback:err x-26 y-27)
  (py-throw
   (py-builtin-TypeError
    (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for ^: '")
                                    (py-getattribute
                                     (py-builtin-type x-26)
                                     (& "__name__")))
                            (&& "' and '"))
                    (py-getattribute (py-builtin-type y-27) (& "__name__")))
            (&& "'")))))

(define (py-iadd-fallback:inplace x-28 y-29)
  (letrec* ((magic_method-562
             (getattribute-from-obj-mro x-28 (&& "__iadd__"))))
    (if (py-test (py-is magic_method-562 py-absent))
        (py-iadd-fallback:normal x-28 y-29)
        (letrec* ((result-568 (py-call magic_method-562 x-28 y-29)))
          (if (py-test (py-is result-568 py-NotImplemented))
              (py-iadd-fallback:normal x-28 y-29)
              result-568)))))

(define (py-iadd-fallback:normal x-28 y-29)
  (letrec* ((magic_method-552 (getattribute-from-obj-mro x-28 (&& "__add__"))))
    (if (py-test (py-is magic_method-552 py-absent))
        (py-iadd-fallback:reflected x-28 y-29)
        (letrec* ((result-558 (py-call magic_method-552 x-28 y-29)))
          (if (py-test (py-is result-558 py-NotImplemented))
              (py-iadd-fallback:reflected x-28 y-29)
              result-558)))))

(define (py-iadd-fallback:reflected x-28 y-29)
  (letrec* ((magic_method-542
             (getattribute-from-obj-mro y-29 (&& "__radd__"))))
    (if (py-test (py-is magic_method-542 py-absent))
        (py-iadd-fallback:err x-28 y-29)
        (letrec* ((result-548 (py-call magic_method-542 y-29 x-28)))
          (if (py-test (py-is result-548 py-NotImplemented))
              (py-iadd-fallback:err x-28 y-29)
              result-548)))))

(define (py-iadd-fallback:err x-28 y-29)
  (py-throw
   (py-builtin-TypeError
    (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for +=: '")
                                    (py-getattribute
                                     (py-builtin-type x-28)
                                     (& "__name__")))
                            (&& "' and '"))
                    (py-getattribute (py-builtin-type y-29) (& "__name__")))
            (&& "'")))))

(define (py-ibitand-fallback:inplace x-30 y-31)
  (letrec* ((magic_method-604
             (getattribute-from-obj-mro x-30 (&& "__iand__"))))
    (if (py-test (py-is magic_method-604 py-absent))
        (py-ibitand-fallback:normal x-30 y-31)
        (letrec* ((result-610 (py-call magic_method-604 x-30 y-31)))
          (if (py-test (py-is result-610 py-NotImplemented))
              (py-ibitand-fallback:normal x-30 y-31)
              result-610)))))

(define (py-ibitand-fallback:normal x-30 y-31)
  (letrec* ((magic_method-594 (getattribute-from-obj-mro x-30 (&& "__and__"))))
    (if (py-test (py-is magic_method-594 py-absent))
        (py-ibitand-fallback:reflected x-30 y-31)
        (letrec* ((result-600 (py-call magic_method-594 x-30 y-31)))
          (if (py-test (py-is result-600 py-NotImplemented))
              (py-ibitand-fallback:reflected x-30 y-31)
              result-600)))))

(define (py-ibitand-fallback:reflected x-30 y-31)
  (letrec* ((magic_method-584
             (getattribute-from-obj-mro y-31 (&& "__rand__"))))
    (if (py-test (py-is magic_method-584 py-absent))
        (py-ibitand-fallback:err x-30 y-31)
        (letrec* ((result-590 (py-call magic_method-584 y-31 x-30)))
          (if (py-test (py-is result-590 py-NotImplemented))
              (py-ibitand-fallback:err x-30 y-31)
              result-590)))))

(define (py-ibitand-fallback:err x-30 y-31)
  (py-throw
   (py-builtin-TypeError
    (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for &=: '")
                                    (py-getattribute
                                     (py-builtin-type x-30)
                                     (& "__name__")))
                            (&& "' and '"))
                    (py-getattribute (py-builtin-type y-31) (& "__name__")))
            (&& "'")))))

(define (py-ibitor-fallback:inplace x-32 y-33)
  (letrec* ((magic_method-646 (getattribute-from-obj-mro x-32 (&& "__ior__"))))
    (if (py-test (py-is magic_method-646 py-absent))
        (py-ibitor-fallback:normal x-32 y-33)
        (letrec* ((result-652 (py-call magic_method-646 x-32 y-33)))
          (if (py-test (py-is result-652 py-NotImplemented))
              (py-ibitor-fallback:normal x-32 y-33)
              result-652)))))

(define (py-ibitor-fallback:normal x-32 y-33)
  (letrec* ((magic_method-636 (getattribute-from-obj-mro x-32 (&& "__or__"))))
    (if (py-test (py-is magic_method-636 py-absent))
        (py-ibitor-fallback:reflected x-32 y-33)
        (letrec* ((result-642 (py-call magic_method-636 x-32 y-33)))
          (if (py-test (py-is result-642 py-NotImplemented))
              (py-ibitor-fallback:reflected x-32 y-33)
              result-642)))))

(define (py-ibitor-fallback:reflected x-32 y-33)
  (letrec* ((magic_method-626 (getattribute-from-obj-mro y-33 (&& "__ror__"))))
    (if (py-test (py-is magic_method-626 py-absent))
        (py-ibitor-fallback:err x-32 y-33)
        (letrec* ((result-632 (py-call magic_method-626 y-33 x-32)))
          (if (py-test (py-is result-632 py-NotImplemented))
              (py-ibitor-fallback:err x-32 y-33)
              result-632)))))

(define (py-ibitor-fallback:err x-32 y-33)
  (py-throw
   (py-builtin-TypeError
    (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for |=: '")
                                    (py-getattribute
                                     (py-builtin-type x-32)
                                     (& "__name__")))
                            (&& "' and '"))
                    (py-getattribute (py-builtin-type y-33) (& "__name__")))
            (&& "'")))))

(define (py-ifloordiv-fallback:inplace x-34 y-35)
  (letrec* ((magic_method-688
             (getattribute-from-obj-mro x-34 (&& "__ifloordiv__"))))
    (if (py-test (py-is magic_method-688 py-absent))
        (py-ifloordiv-fallback:normal x-34 y-35)
        (letrec* ((result-694 (py-call magic_method-688 x-34 y-35)))
          (if (py-test (py-is result-694 py-NotImplemented))
              (py-ifloordiv-fallback:normal x-34 y-35)
              result-694)))))

(define (py-ifloordiv-fallback:normal x-34 y-35)
  (letrec* ((magic_method-678
             (getattribute-from-obj-mro x-34 (&& "__floordiv__"))))
    (if (py-test (py-is magic_method-678 py-absent))
        (py-ifloordiv-fallback:reflected x-34 y-35)
        (letrec* ((result-684 (py-call magic_method-678 x-34 y-35)))
          (if (py-test (py-is result-684 py-NotImplemented))
              (py-ifloordiv-fallback:reflected x-34 y-35)
              result-684)))))

(define (py-ifloordiv-fallback:reflected x-34 y-35)
  (letrec* ((magic_method-668
             (getattribute-from-obj-mro y-35 (&& "__rfloordiv__"))))
    (if (py-test (py-is magic_method-668 py-absent))
        (py-ifloordiv-fallback:err x-34 y-35)
        (letrec* ((result-674 (py-call magic_method-668 y-35 x-34)))
          (if (py-test (py-is result-674 py-NotImplemented))
              (py-ifloordiv-fallback:err x-34 y-35)
              result-674)))))

(define (py-ifloordiv-fallback:err x-34 y-35)
  (py-throw
   (py-builtin-TypeError
    (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for //=: '")
                                    (py-getattribute
                                     (py-builtin-type x-34)
                                     (& "__name__")))
                            (&& "' and '"))
                    (py-getattribute (py-builtin-type y-35) (& "__name__")))
            (&& "'")))))

(define (py-ilshift-fallback:inplace x-36 y-37)
  (letrec* ((magic_method-730
             (getattribute-from-obj-mro x-36 (&& "__ilshift__"))))
    (if (py-test (py-is magic_method-730 py-absent))
        (py-ilshift-fallback:normal x-36 y-37)
        (letrec* ((result-736 (py-call magic_method-730 x-36 y-37)))
          (if (py-test (py-is result-736 py-NotImplemented))
              (py-ilshift-fallback:normal x-36 y-37)
              result-736)))))

(define (py-ilshift-fallback:normal x-36 y-37)
  (letrec* ((magic_method-720
             (getattribute-from-obj-mro x-36 (&& "__lshift__"))))
    (if (py-test (py-is magic_method-720 py-absent))
        (py-ilshift-fallback:reflected x-36 y-37)
        (letrec* ((result-726 (py-call magic_method-720 x-36 y-37)))
          (if (py-test (py-is result-726 py-NotImplemented))
              (py-ilshift-fallback:reflected x-36 y-37)
              result-726)))))

(define (py-ilshift-fallback:reflected x-36 y-37)
  (letrec* ((magic_method-710
             (getattribute-from-obj-mro y-37 (&& "__rlshift__"))))
    (if (py-test (py-is magic_method-710 py-absent))
        (py-ilshift-fallback:err x-36 y-37)
        (letrec* ((result-716 (py-call magic_method-710 y-37 x-36)))
          (if (py-test (py-is result-716 py-NotImplemented))
              (py-ilshift-fallback:err x-36 y-37)
              result-716)))))

(define (py-ilshift-fallback:err x-36 y-37)
  (py-throw
   (py-builtin-TypeError
    (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for <<=: '")
                                    (py-getattribute
                                     (py-builtin-type x-36)
                                     (& "__name__")))
                            (&& "' and '"))
                    (py-getattribute (py-builtin-type y-37) (& "__name__")))
            (&& "'")))))

(define (py-imatmul-fallback:inplace x-38 y-39)
  (letrec* ((magic_method-772
             (getattribute-from-obj-mro x-38 (&& "__imatmul__"))))
    (if (py-test (py-is magic_method-772 py-absent))
        (py-imatmul-fallback:normal x-38 y-39)
        (letrec* ((result-778 (py-call magic_method-772 x-38 y-39)))
          (if (py-test (py-is result-778 py-NotImplemented))
              (py-imatmul-fallback:normal x-38 y-39)
              result-778)))))

(define (py-imatmul-fallback:normal x-38 y-39)
  (letrec* ((magic_method-762
             (getattribute-from-obj-mro x-38 (&& "__matmul__"))))
    (if (py-test (py-is magic_method-762 py-absent))
        (py-imatmul-fallback:reflected x-38 y-39)
        (letrec* ((result-768 (py-call magic_method-762 x-38 y-39)))
          (if (py-test (py-is result-768 py-NotImplemented))
              (py-imatmul-fallback:reflected x-38 y-39)
              result-768)))))

(define (py-imatmul-fallback:reflected x-38 y-39)
  (letrec* ((magic_method-752
             (getattribute-from-obj-mro y-39 (&& "__rmatmul__"))))
    (if (py-test (py-is magic_method-752 py-absent))
        (py-imatmul-fallback:err x-38 y-39)
        (letrec* ((result-758 (py-call magic_method-752 y-39 x-38)))
          (if (py-test (py-is result-758 py-NotImplemented))
              (py-imatmul-fallback:err x-38 y-39)
              result-758)))))

(define (py-imatmul-fallback:err x-38 y-39)
  (py-throw
   (py-builtin-TypeError
    (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for @=: '")
                                    (py-getattribute
                                     (py-builtin-type x-38)
                                     (& "__name__")))
                            (&& "' and '"))
                    (py-getattribute (py-builtin-type y-39) (& "__name__")))
            (&& "'")))))

(define (py-imod-fallback:inplace x-40 y-41)
  (letrec* ((magic_method-814
             (getattribute-from-obj-mro x-40 (&& "__imod__"))))
    (if (py-test (py-is magic_method-814 py-absent))
        (py-imod-fallback:normal x-40 y-41)
        (letrec* ((result-820 (py-call magic_method-814 x-40 y-41)))
          (if (py-test (py-is result-820 py-NotImplemented))
              (py-imod-fallback:normal x-40 y-41)
              result-820)))))

(define (py-imod-fallback:normal x-40 y-41)
  (letrec* ((magic_method-804 (getattribute-from-obj-mro x-40 (&& "__mod__"))))
    (if (py-test (py-is magic_method-804 py-absent))
        (py-imod-fallback:reflected x-40 y-41)
        (letrec* ((result-810 (py-call magic_method-804 x-40 y-41)))
          (if (py-test (py-is result-810 py-NotImplemented))
              (py-imod-fallback:reflected x-40 y-41)
              result-810)))))

(define (py-imod-fallback:reflected x-40 y-41)
  (letrec* ((magic_method-794
             (getattribute-from-obj-mro y-41 (&& "__rmod__"))))
    (if (py-test (py-is magic_method-794 py-absent))
        (py-imod-fallback:err x-40 y-41)
        (letrec* ((result-800 (py-call magic_method-794 y-41 x-40)))
          (if (py-test (py-is result-800 py-NotImplemented))
              (py-imod-fallback:err x-40 y-41)
              result-800)))))

(define (py-imod-fallback:err x-40 y-41)
  (py-throw
   (py-builtin-TypeError
    (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for %=: '")
                                    (py-getattribute
                                     (py-builtin-type x-40)
                                     (& "__name__")))
                            (&& "' and '"))
                    (py-getattribute (py-builtin-type y-41) (& "__name__")))
            (&& "'")))))

(define (py-imul-fallback:inplace x-42 y-43)
  (letrec* ((magic_method-856
             (getattribute-from-obj-mro x-42 (&& "__imul__"))))
    (if (py-test (py-is magic_method-856 py-absent))
        (py-imul-fallback:normal x-42 y-43)
        (letrec* ((result-862 (py-call magic_method-856 x-42 y-43)))
          (if (py-test (py-is result-862 py-NotImplemented))
              (py-imul-fallback:normal x-42 y-43)
              result-862)))))

(define (py-imul-fallback:normal x-42 y-43)
  (letrec* ((magic_method-846 (getattribute-from-obj-mro x-42 (&& "__mul__"))))
    (if (py-test (py-is magic_method-846 py-absent))
        (py-imul-fallback:reflected x-42 y-43)
        (letrec* ((result-852 (py-call magic_method-846 x-42 y-43)))
          (if (py-test (py-is result-852 py-NotImplemented))
              (py-imul-fallback:reflected x-42 y-43)
              result-852)))))

(define (py-imul-fallback:reflected x-42 y-43)
  (letrec* ((magic_method-836
             (getattribute-from-obj-mro y-43 (&& "__rmul__"))))
    (if (py-test (py-is magic_method-836 py-absent))
        (py-imul-fallback:err x-42 y-43)
        (letrec* ((result-842 (py-call magic_method-836 y-43 x-42)))
          (if (py-test (py-is result-842 py-NotImplemented))
              (py-imul-fallback:err x-42 y-43)
              result-842)))))

(define (py-imul-fallback:err x-42 y-43)
  (py-throw
   (py-builtin-TypeError
    (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for *=: '")
                                    (py-getattribute
                                     (py-builtin-type x-42)
                                     (& "__name__")))
                            (&& "' and '"))
                    (py-getattribute (py-builtin-type y-43) (& "__name__")))
            (&& "'")))))

(define (py-ipow-fallback:inplace x-44 y-45)
  (letrec* ((magic_method-898
             (getattribute-from-obj-mro x-44 (&& "__ipow__"))))
    (if (py-test (py-is magic_method-898 py-absent))
        (py-ipow-fallback:normal x-44 y-45)
        (letrec* ((result-904 (py-call magic_method-898 x-44 y-45)))
          (if (py-test (py-is result-904 py-NotImplemented))
              (py-ipow-fallback:normal x-44 y-45)
              result-904)))))

(define (py-ipow-fallback:normal x-44 y-45)
  (letrec* ((magic_method-888 (getattribute-from-obj-mro x-44 (&& "__pow__"))))
    (if (py-test (py-is magic_method-888 py-absent))
        (py-ipow-fallback:reflected x-44 y-45)
        (letrec* ((result-894 (py-call magic_method-888 x-44 y-45)))
          (if (py-test (py-is result-894 py-NotImplemented))
              (py-ipow-fallback:reflected x-44 y-45)
              result-894)))))

(define (py-ipow-fallback:reflected x-44 y-45)
  (letrec* ((magic_method-878
             (getattribute-from-obj-mro y-45 (&& "__rpow__"))))
    (if (py-test (py-is magic_method-878 py-absent))
        (py-ipow-fallback:err x-44 y-45)
        (letrec* ((result-884 (py-call magic_method-878 y-45 x-44)))
          (if (py-test (py-is result-884 py-NotImplemented))
              (py-ipow-fallback:err x-44 y-45)
              result-884)))))

(define (py-ipow-fallback:err x-44 y-45)
  (py-throw
   (py-builtin-TypeError
    (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for **=: '")
                                    (py-getattribute
                                     (py-builtin-type x-44)
                                     (& "__name__")))
                            (&& "' and '"))
                    (py-getattribute (py-builtin-type y-45) (& "__name__")))
            (&& "'")))))

(define (py-irshift-fallback:inplace x-46 y-47)
  (letrec* ((magic_method-940
             (getattribute-from-obj-mro x-46 (&& "__irshift__"))))
    (if (py-test (py-is magic_method-940 py-absent))
        (py-irshift-fallback:normal x-46 y-47)
        (letrec* ((result-946 (py-call magic_method-940 x-46 y-47)))
          (if (py-test (py-is result-946 py-NotImplemented))
              (py-irshift-fallback:normal x-46 y-47)
              result-946)))))

(define (py-irshift-fallback:normal x-46 y-47)
  (letrec* ((magic_method-930
             (getattribute-from-obj-mro x-46 (&& "__rshift__"))))
    (if (py-test (py-is magic_method-930 py-absent))
        (py-irshift-fallback:reflected x-46 y-47)
        (letrec* ((result-936 (py-call magic_method-930 x-46 y-47)))
          (if (py-test (py-is result-936 py-NotImplemented))
              (py-irshift-fallback:reflected x-46 y-47)
              result-936)))))

(define (py-irshift-fallback:reflected x-46 y-47)
  (letrec* ((magic_method-920
             (getattribute-from-obj-mro y-47 (&& "__rrshift__"))))
    (if (py-test (py-is magic_method-920 py-absent))
        (py-irshift-fallback:err x-46 y-47)
        (letrec* ((result-926 (py-call magic_method-920 y-47 x-46)))
          (if (py-test (py-is result-926 py-NotImplemented))
              (py-irshift-fallback:err x-46 y-47)
              result-926)))))

(define (py-irshift-fallback:err x-46 y-47)
  (py-throw
   (py-builtin-TypeError
    (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for >>=: '")
                                    (py-getattribute
                                     (py-builtin-type x-46)
                                     (& "__name__")))
                            (&& "' and '"))
                    (py-getattribute (py-builtin-type y-47) (& "__name__")))
            (&& "'")))))

(define (py-isub-fallback:inplace x-48 y-49)
  (letrec* ((magic_method-982
             (getattribute-from-obj-mro x-48 (&& "__isub__"))))
    (if (py-test (py-is magic_method-982 py-absent))
        (py-isub-fallback:normal x-48 y-49)
        (letrec* ((result-988 (py-call magic_method-982 x-48 y-49)))
          (if (py-test (py-is result-988 py-NotImplemented))
              (py-isub-fallback:normal x-48 y-49)
              result-988)))))

(define (py-isub-fallback:normal x-48 y-49)
  (letrec* ((magic_method-972 (getattribute-from-obj-mro x-48 (&& "__sub__"))))
    (if (py-test (py-is magic_method-972 py-absent))
        (py-isub-fallback:reflected x-48 y-49)
        (letrec* ((result-978 (py-call magic_method-972 x-48 y-49)))
          (if (py-test (py-is result-978 py-NotImplemented))
              (py-isub-fallback:reflected x-48 y-49)
              result-978)))))

(define (py-isub-fallback:reflected x-48 y-49)
  (letrec* ((magic_method-962
             (getattribute-from-obj-mro y-49 (&& "__rsub__"))))
    (if (py-test (py-is magic_method-962 py-absent))
        (py-isub-fallback:err x-48 y-49)
        (letrec* ((result-968 (py-call magic_method-962 y-49 x-48)))
          (if (py-test (py-is result-968 py-NotImplemented))
              (py-isub-fallback:err x-48 y-49)
              result-968)))))

(define (py-isub-fallback:err x-48 y-49)
  (py-throw
   (py-builtin-TypeError
    (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for -=: '")
                                    (py-getattribute
                                     (py-builtin-type x-48)
                                     (& "__name__")))
                            (&& "' and '"))
                    (py-getattribute (py-builtin-type y-49) (& "__name__")))
            (&& "'")))))

(define (py-itruediv-fallback:inplace x-50 y-51)
  (letrec* ((magic_method-1024
             (getattribute-from-obj-mro x-50 (&& "__itruediv__"))))
    (if (py-test (py-is magic_method-1024 py-absent))
        (py-itruediv-fallback:normal x-50 y-51)
        (letrec* ((result-1030 (py-call magic_method-1024 x-50 y-51)))
          (if (py-test (py-is result-1030 py-NotImplemented))
              (py-itruediv-fallback:normal x-50 y-51)
              result-1030)))))

(define (py-itruediv-fallback:normal x-50 y-51)
  (letrec* ((magic_method-1014
             (getattribute-from-obj-mro x-50 (&& "__truediv__"))))
    (if (py-test (py-is magic_method-1014 py-absent))
        (py-itruediv-fallback:reflected x-50 y-51)
        (letrec* ((result-1020 (py-call magic_method-1014 x-50 y-51)))
          (if (py-test (py-is result-1020 py-NotImplemented))
              (py-itruediv-fallback:reflected x-50 y-51)
              result-1020)))))

(define (py-itruediv-fallback:reflected x-50 y-51)
  (letrec* ((magic_method-1004
             (getattribute-from-obj-mro y-51 (&& "__rtruediv__"))))
    (if (py-test (py-is magic_method-1004 py-absent))
        (py-itruediv-fallback:err x-50 y-51)
        (letrec* ((result-1010 (py-call magic_method-1004 y-51 x-50)))
          (if (py-test (py-is result-1010 py-NotImplemented))
              (py-itruediv-fallback:err x-50 y-51)
              result-1010)))))

(define (py-itruediv-fallback:err x-50 y-51)
  (py-throw
   (py-builtin-TypeError
    (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for /=: '")
                                    (py-getattribute
                                     (py-builtin-type x-50)
                                     (& "__name__")))
                            (&& "' and '"))
                    (py-getattribute (py-builtin-type y-51) (& "__name__")))
            (&& "'")))))

(define (py-ixor-fallback:inplace x-52 y-53)
  (letrec* ((magic_method-1066
             (getattribute-from-obj-mro x-52 (&& "__ixor__"))))
    (if (py-test (py-is magic_method-1066 py-absent))
        (py-ixor-fallback:normal x-52 y-53)
        (letrec* ((result-1072 (py-call magic_method-1066 x-52 y-53)))
          (if (py-test (py-is result-1072 py-NotImplemented))
              (py-ixor-fallback:normal x-52 y-53)
              result-1072)))))

(define (py-ixor-fallback:normal x-52 y-53)
  (letrec* ((magic_method-1056
             (getattribute-from-obj-mro x-52 (&& "__xor__"))))
    (if (py-test (py-is magic_method-1056 py-absent))
        (py-ixor-fallback:reflected x-52 y-53)
        (letrec* ((result-1062 (py-call magic_method-1056 x-52 y-53)))
          (if (py-test (py-is result-1062 py-NotImplemented))
              (py-ixor-fallback:reflected x-52 y-53)
              result-1062)))))

(define (py-ixor-fallback:reflected x-52 y-53)
  (letrec* ((magic_method-1046
             (getattribute-from-obj-mro y-53 (&& "__rxor__"))))
    (if (py-test (py-is magic_method-1046 py-absent))
        (py-ixor-fallback:err x-52 y-53)
        (letrec* ((result-1052 (py-call magic_method-1046 y-53 x-52)))
          (if (py-test (py-is result-1052 py-NotImplemented))
              (py-ixor-fallback:err x-52 y-53)
              result-1052)))))

(define (py-ixor-fallback:err x-52 y-53)
  (py-throw
   (py-builtin-TypeError
    (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for ^=: '")
                                    (py-getattribute
                                     (py-builtin-type x-52)
                                     (& "__name__")))
                            (&& "' and '"))
                    (py-getattribute (py-builtin-type y-53) (& "__name__")))
            (&& "'")))))

(define (py-pos-fallback:normal x-54)
  (letrec* ((magic_method-1083
             (getattribute-from-obj-mro x-54 (&& "__pos__"))))
    (if (py-test (py-is magic_method-1083 py-absent))
        (py-pos-fallback:err x-54)
        (py-call magic_method-1083 x-54))))

(define (py-pos-fallback:err x-54)
  (py-throw
   (py-builtin-TypeError
    (py-add (py-add (&& "bad operand type for unary +: '")
                    (py-getattribute (py-builtin-type x-54) (& "__name__")))
            (&& "'")))))

(define (py-neg-fallback:normal x-55)
  (letrec* ((magic_method-1096
             (getattribute-from-obj-mro x-55 (&& "__neg__"))))
    (if (py-test (py-is magic_method-1096 py-absent))
        (py-neg-fallback:err x-55)
        (py-call magic_method-1096 x-55))))

(define (py-neg-fallback:err x-55)
  (py-throw
   (py-builtin-TypeError
    (py-add (py-add (&& "bad operand type for unary -: '")
                    (py-getattribute (py-builtin-type x-55) (& "__name__")))
            (&& "'")))))

(define (py-invert-fallback:normal x-56)
  (letrec* ((magic_method-1109
             (getattribute-from-obj-mro x-56 (&& "__invert__"))))
    (if (py-test (py-is magic_method-1109 py-absent))
        (py-invert-fallback:err x-56)
        (py-call magic_method-1109 x-56))))

(define (py-invert-fallback:err x-56)
  (py-throw
   (py-builtin-TypeError
    (py-add (py-add (&& "bad operand type for unary ~: '")
                    (py-getattribute (py-builtin-type x-56) (& "__name__")))
            (&& "'")))))

(define (py-ge-fallback:normal x-57 y-58)
  (letrec* ((magic_method-1135 (getattribute-from-obj-mro x-57 (&& "__ge__"))))
    (if (py-test (py-is magic_method-1135 py-absent))
        (py-ge-fallback:reflected x-57 y-58)
        (letrec* ((result-1141 (py-call magic_method-1135 x-57 y-58)))
          (if (py-test (py-is result-1141 py-NotImplemented))
              (py-ge-fallback:reflected x-57 y-58)
              result-1141)))))

(define (py-ge-fallback:reflected x-57 y-58)
  (letrec* ((magic_method-1125 (getattribute-from-obj-mro y-58 (&& "__le__"))))
    (if (py-test (py-is magic_method-1125 py-absent))
        (py-ge-fallback:err x-57 y-58)
        (letrec* ((result-1131 (py-call magic_method-1125 y-58 x-57)))
          (if (py-test (py-is result-1131 py-NotImplemented))
              (py-ge-fallback:err x-57 y-58)
              result-1131)))))

(define (py-ge-fallback:err x-57 y-58)
  (py-throw
   (py-builtin-TypeError
    (py-add (py-add (py-add (py-add (&& "'>=' not supported between instances of '")
                                    (py-getattribute
                                     (py-builtin-type x-57)
                                     (& "__name__")))
                            (&& "' and '"))
                    (py-getattribute (py-builtin-type y-58) (& "__name__")))
            (&& "'")))))

(define (py-gt-fallback:normal x-59 y-60)
  (letrec* ((magic_method-1165 (getattribute-from-obj-mro x-59 (&& "__gt__"))))
    (if (py-test (py-is magic_method-1165 py-absent))
        (py-gt-fallback:reflected x-59 y-60)
        (letrec* ((result-1171 (py-call magic_method-1165 x-59 y-60)))
          (if (py-test (py-is result-1171 py-NotImplemented))
              (py-gt-fallback:reflected x-59 y-60)
              result-1171)))))

(define (py-gt-fallback:reflected x-59 y-60)
  (letrec* ((magic_method-1155 (getattribute-from-obj-mro y-60 (&& "__lt__"))))
    (if (py-test (py-is magic_method-1155 py-absent))
        (py-gt-fallback:err x-59 y-60)
        (letrec* ((result-1161 (py-call magic_method-1155 y-60 x-59)))
          (if (py-test (py-is result-1161 py-NotImplemented))
              (py-gt-fallback:err x-59 y-60)
              result-1161)))))

(define (py-gt-fallback:err x-59 y-60)
  (py-throw
   (py-builtin-TypeError
    (py-add (py-add (py-add (py-add (&& "'>' not supported between instances of '")
                                    (py-getattribute
                                     (py-builtin-type x-59)
                                     (& "__name__")))
                            (&& "' and '"))
                    (py-getattribute (py-builtin-type y-60) (& "__name__")))
            (&& "'")))))

(define (py-le-fallback:normal x-61 y-62)
  (letrec* ((magic_method-1195 (getattribute-from-obj-mro x-61 (&& "__le__"))))
    (if (py-test (py-is magic_method-1195 py-absent))
        (py-le-fallback:reflected x-61 y-62)
        (letrec* ((result-1201 (py-call magic_method-1195 x-61 y-62)))
          (if (py-test (py-is result-1201 py-NotImplemented))
              (py-le-fallback:reflected x-61 y-62)
              result-1201)))))

(define (py-le-fallback:reflected x-61 y-62)
  (letrec* ((magic_method-1185 (getattribute-from-obj-mro y-62 (&& "__ge__"))))
    (if (py-test (py-is magic_method-1185 py-absent))
        (py-le-fallback:err x-61 y-62)
        (letrec* ((result-1191 (py-call magic_method-1185 y-62 x-61)))
          (if (py-test (py-is result-1191 py-NotImplemented))
              (py-le-fallback:err x-61 y-62)
              result-1191)))))

(define (py-le-fallback:err x-61 y-62)
  (py-throw
   (py-builtin-TypeError
    (py-add (py-add (py-add (py-add (&& "'<=' not supported between instances of '")
                                    (py-getattribute
                                     (py-builtin-type x-61)
                                     (& "__name__")))
                            (&& "' and '"))
                    (py-getattribute (py-builtin-type y-62) (& "__name__")))
            (&& "'")))))

(define (py-lt-fallback:normal x-63 y-64)
  (letrec* ((magic_method-1225 (getattribute-from-obj-mro x-63 (&& "__lt__"))))
    (if (py-test (py-is magic_method-1225 py-absent))
        (py-lt-fallback:reflected x-63 y-64)
        (letrec* ((result-1231 (py-call magic_method-1225 x-63 y-64)))
          (if (py-test (py-is result-1231 py-NotImplemented))
              (py-lt-fallback:reflected x-63 y-64)
              result-1231)))))

(define (py-lt-fallback:reflected x-63 y-64)
  (letrec* ((magic_method-1215 (getattribute-from-obj-mro y-64 (&& "__gt__"))))
    (if (py-test (py-is magic_method-1215 py-absent))
        (py-lt-fallback:err x-63 y-64)
        (letrec* ((result-1221 (py-call magic_method-1215 y-64 x-63)))
          (if (py-test (py-is result-1221 py-NotImplemented))
              (py-lt-fallback:err x-63 y-64)
              result-1221)))))

(define (py-lt-fallback:err x-63 y-64)
  (py-throw
   (py-builtin-TypeError
    (py-add (py-add (py-add (py-add (&& "'<' not supported between instances of '")
                                    (py-getattribute
                                     (py-builtin-type x-63)
                                     (& "__name__")))
                            (&& "' and '"))
                    (py-getattribute (py-builtin-type y-64) (& "__name__")))
            (&& "'")))))

(define (py-eq-fallback:normal x-65 y-66)
  (letrec* ((magic_method-1253 (getattribute-from-obj-mro x-65 (&& "__eq__"))))
    (if (py-test (py-is magic_method-1253 py-absent))
        (py-eq-fallback:reflected x-65 y-66)
        (letrec* ((result-1259 (py-call magic_method-1253 x-65 y-66)))
          (if (py-test (py-is result-1259 py-NotImplemented))
              (py-eq-fallback:reflected x-65 y-66)
              result-1259)))))

(define (py-eq-fallback:reflected x-65 y-66)
  (letrec* ((magic_method-1243 (getattribute-from-obj-mro y-66 (&& "__eq__"))))
    (if (py-test (py-is magic_method-1243 py-absent))
        (py-eq-fallback:default x-65 y-66)
        (letrec* ((result-1249 (py-call magic_method-1243 y-66 x-65)))
          (if (py-test (py-is result-1249 py-NotImplemented))
              (py-eq-fallback:default x-65 y-66)
              result-1249)))))

(define (py-eq-fallback:default x-65 y-66) (py-is x-65 y-66))

(define (py-ne-fallback:normal x-67 y-68)
  (letrec* ((magic_method-1281 (getattribute-from-obj-mro x-67 (&& "__ne__"))))
    (if (py-test (py-is magic_method-1281 py-absent))
        (py-ne-fallback:reflected x-67 y-68)
        (letrec* ((result-1287 (py-call magic_method-1281 x-67 y-68)))
          (if (py-test (py-is result-1287 py-NotImplemented))
              (py-ne-fallback:reflected x-67 y-68)
              result-1287)))))

(define (py-ne-fallback:reflected x-67 y-68)
  (letrec* ((magic_method-1271 (getattribute-from-obj-mro y-68 (&& "__ne__"))))
    (if (py-test (py-is magic_method-1271 py-absent))
        (py-ne-fallback:default x-67 y-68)
        (letrec* ((result-1277 (py-call magic_method-1271 y-68 x-67)))
          (if (py-test (py-is result-1277 py-NotImplemented))
              (py-ne-fallback:default x-67 y-68)
              result-1277)))))

(define (py-ne-fallback:default x-67 y-68) (py-isnot x-67 y-68))

(define (py-index-fallback obj-69)
  (letrec* ((__index__-1291
             (getattribute-from-obj-mro obj-69 (&& "__index__"))))
    (if (py-test (py-is __index__-1291 py-absent))
        (py-throw
         (py-builtin-TypeError
          (py-add (py-add (&& "'")
                          (py-getattribute
                           (py-builtin-type obj-69)
                           (& "__name__")))
                  (&& "' object cannot be interpreted as an integer"))))
        (letrec* ((result-1298 (py-call __index__-1291 obj-69)))
          (if (py-has-type-sint? result-1298)
              result-1298
              (if (py-has-type-bint? result-1298)
                  (py-throw
                   (py-builtin-OverflowError
                    (&& "cannot fit 'int' into an index-sized integer")))
                  (py-throw
                   (py-builtin-TypeError
                    (&& "__index__ returned non-int (type str)")))))))))

(define (py-maybe-len-fallback obj-70)
  (letrec* ((__len__-1304 (getattribute-from-obj-mro obj-70 (&& "__len__"))))
    (if (py-test (py-is __len__-1304 py-absent))
        py-absent
        (py-index-fallback (py-call __len__-1304 obj-70)))))

(define (py-len-fallback obj-71)
  (letrec* ((result-1310 (py-maybe-len-fallback obj-71)))
    (if (py-test (py-is result-1310 py-absent))
        (py-throw
         (py-builtin-TypeError
          (py-add (py-add (&& "object of type")
                          (py-getattribute
                           (py-builtin-type obj-71)
                           (& "__name__")))
                  (&& "has no len()"))))
        result-1310)))

(define (py-truth-fallback obj-72)
  (letrec* ((__bool__-1317 (getattribute-from-obj-mro obj-72 (&& "__bool__"))))
    (if (py-test (py-isnot __bool__-1317 py-absent))
        (letrec* ((result-1322 (py-call __bool__-1317 obj-72)))
          (if (py-test (py-isinstance? result-1322 py-builtin-bool))
              result-1322
              (py-throw
               (py-builtin-TypeError
                (py-add (py-add (&& "__bool__ should return bool, returned '")
                                (py-getattribute
                                 (py-builtin-type obj-72)
                                 (& "__name__")))
                        (&& "'"))))))
        (letrec* ((len_result-1328 (py-maybe-len-fallback obj-72)))
          (if (py-test (py-isnot len_result-1328 py-absent))
              (py-ne len_result-1328 (py-int-from-scheme 0))
              py-True)))))

(define (py-getattribute-fallback obj-73 attr-74)
  (letrec* ((__getattribute__-1331
             (getattribute-from-obj-mro obj-73 (&& "__getattribute__"))))
    (with-handler
     (lambda ($%exc_0)
       (cond ((py-isinstance? $%exc_0 py-builtin-AttributeError)
              (letrec* ((__getattr__-1337
                         (getattribute-from-obj-mro
                          obj-73
                          (&& "__getattr__"))))
                (if (py-test (py-is __getattr__-1337 py-absent))
                    (py-throw $%exc_0)
                    (py-call __getattr__-1337 obj-73 attr-74))))
             (else (raise $%exc_0))))
     (py-call __getattribute__-1331 obj-73 attr-74))))

(define (py-setattribute-fallback obj-75 attr-76 val-77)
  (letrec* ((__setattr__-1340
             (getattribute-from-obj-mro obj-75 (&& "__setattr__"))))
    (py-call __setattr__-1340 obj-75 attr-76 val-77)))

(define (py-getitem-fallback obj-78 index-79)
  (letrec* ((__getitem__-1346
             (getattribute-from-obj-mro obj-78 (&& "__getitem__"))))
    (if (py-test (py-is __getitem__-1346 py-absent))
        (py-throw (py-builtin-TypeError (&& "object is not subscriptable")))
        (py-call __getitem__-1346 obj-78 index-79))))

(define (py-setitem-fallback obj-80 index-81 value-82)
  (letrec* ((__setitem__-1353
             (getattribute-from-obj-mro obj-80 (&& "__setitem__"))))
    (if (py-test (py-is __setitem__-1353 py-absent))
        (py-throw
         (py-builtin-TypeError (&& "object does not support item assignment")))
        (py-call __setitem__-1353 obj-80 index-81 value-82))))

(define (py-delitem-fallback obj-83 index-84)
  (letrec* ((__delitem__-1361
             (getattribute-from-obj-mro obj-83 (&& "__delitem__"))))
    (if (py-test (py-is __delitem__-1361 py-absent))
        (py-throw
         (py-builtin-TypeError (&& "object does not support item deletion")))
        (py-call __delitem__-1361 obj-83 index-84))))

(define (py-enter-fallback obj-85)
  (letrec* ((__enter__-1368
             (getattribute-from-obj-mro obj-85 (&& "__enter__"))))
    (if (py-test (py-is __enter__-1368 py-absent))
        (py-throw (py-builtin-AttributeError (&& "__enter__")))
        (py-call __enter__-1368 obj-85))))

(define (py-exit-fallback obj-86 exc-87)
  (letrec* ((__exit__-1374 (getattribute-from-obj-mro obj-86 (&& "__exit__"))))
    (if (py-test (py-is __exit__-1374 py-absent))
        (py-throw (py-builtin-AttributeError (&& "__exit__")))
        (if (py-test (py-is exc-87 py-None))
            (py-call __exit__-1374 obj-86 py-None py-None py-None)
            (letrec* ((exit_result-1381
                       (py-call __exit__-1374
                                obj-86
                                (py-builtin-type exc-87)
                                exc-87
                                py-None)))
              (if (py-test exit_result-1381) py-None (py-throw exc-87)))))))

