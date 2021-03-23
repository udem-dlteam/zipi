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
  (letrec* ((magic_method-173 (getattribute-from-obj-mro x-2 (&& "__add__"))))
    (if (py-test (py-is magic_method-173 py-absent))
        (py-add-fallback:reflected x-2 y-3)
        (letrec* ((result-179 (py-call magic_method-173 x-2 y-3)))
          (if (py-test (py-is result-179 py-NotImplemented))
              (py-add-fallback:reflected x-2 y-3)
              result-179)))))

(define (py-add-fallback:reflected x-2 y-3)
  (letrec* ((magic_method-163 (getattribute-from-obj-mro y-3 (&& "__radd__"))))
    (if (py-test (py-is magic_method-163 py-absent))
        (py-add-fallback:err x-2 y-3)
        (letrec* ((result-169 (py-call magic_method-163 y-3 x-2)))
          (if (py-test (py-is result-169 py-NotImplemented))
              (py-add-fallback:err x-2 y-3)
              result-169)))))

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
  (letrec* ((magic_method-203 (getattribute-from-obj-mro x-4 (&& "__and__"))))
    (if (py-test (py-is magic_method-203 py-absent))
        (py-bitand-fallback:reflected x-4 y-5)
        (letrec* ((result-209 (py-call magic_method-203 x-4 y-5)))
          (if (py-test (py-is result-209 py-NotImplemented))
              (py-bitand-fallback:reflected x-4 y-5)
              result-209)))))

(define (py-bitand-fallback:reflected x-4 y-5)
  (letrec* ((magic_method-193 (getattribute-from-obj-mro y-5 (&& "__rand__"))))
    (if (py-test (py-is magic_method-193 py-absent))
        (py-bitand-fallback:err x-4 y-5)
        (letrec* ((result-199 (py-call magic_method-193 y-5 x-4)))
          (if (py-test (py-is result-199 py-NotImplemented))
              (py-bitand-fallback:err x-4 y-5)
              result-199)))))

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
  (letrec* ((magic_method-233 (getattribute-from-obj-mro x-6 (&& "__or__"))))
    (if (py-test (py-is magic_method-233 py-absent))
        (py-bitor-fallback:reflected x-6 y-7)
        (letrec* ((result-239 (py-call magic_method-233 x-6 y-7)))
          (if (py-test (py-is result-239 py-NotImplemented))
              (py-bitor-fallback:reflected x-6 y-7)
              result-239)))))

(define (py-bitor-fallback:reflected x-6 y-7)
  (letrec* ((magic_method-223 (getattribute-from-obj-mro y-7 (&& "__ror__"))))
    (if (py-test (py-is magic_method-223 py-absent))
        (py-bitor-fallback:err x-6 y-7)
        (letrec* ((result-229 (py-call magic_method-223 y-7 x-6)))
          (if (py-test (py-is result-229 py-NotImplemented))
              (py-bitor-fallback:err x-6 y-7)
              result-229)))))

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
  (letrec* ((magic_method-263
             (getattribute-from-obj-mro x-8 (&& "__floordiv__"))))
    (if (py-test (py-is magic_method-263 py-absent))
        (py-floordiv-fallback:reflected x-8 y-9)
        (letrec* ((result-269 (py-call magic_method-263 x-8 y-9)))
          (if (py-test (py-is result-269 py-NotImplemented))
              (py-floordiv-fallback:reflected x-8 y-9)
              result-269)))))

(define (py-floordiv-fallback:reflected x-8 y-9)
  (letrec* ((magic_method-253
             (getattribute-from-obj-mro y-9 (&& "__rfloordiv__"))))
    (if (py-test (py-is magic_method-253 py-absent))
        (py-floordiv-fallback:err x-8 y-9)
        (letrec* ((result-259 (py-call magic_method-253 y-9 x-8)))
          (if (py-test (py-is result-259 py-NotImplemented))
              (py-floordiv-fallback:err x-8 y-9)
              result-259)))))

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
  (letrec* ((magic_method-293
             (getattribute-from-obj-mro x-10 (&& "__lshift__"))))
    (if (py-test (py-is magic_method-293 py-absent))
        (py-lshift-fallback:reflected x-10 y-11)
        (letrec* ((result-299 (py-call magic_method-293 x-10 y-11)))
          (if (py-test (py-is result-299 py-NotImplemented))
              (py-lshift-fallback:reflected x-10 y-11)
              result-299)))))

(define (py-lshift-fallback:reflected x-10 y-11)
  (letrec* ((magic_method-283
             (getattribute-from-obj-mro y-11 (&& "__rlshift__"))))
    (if (py-test (py-is magic_method-283 py-absent))
        (py-lshift-fallback:err x-10 y-11)
        (letrec* ((result-289 (py-call magic_method-283 y-11 x-10)))
          (if (py-test (py-is result-289 py-NotImplemented))
              (py-lshift-fallback:err x-10 y-11)
              result-289)))))

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
  (letrec* ((magic_method-323
             (getattribute-from-obj-mro x-12 (&& "__matmul__"))))
    (if (py-test (py-is magic_method-323 py-absent))
        (py-matmul-fallback:reflected x-12 y-13)
        (letrec* ((result-329 (py-call magic_method-323 x-12 y-13)))
          (if (py-test (py-is result-329 py-NotImplemented))
              (py-matmul-fallback:reflected x-12 y-13)
              result-329)))))

(define (py-matmul-fallback:reflected x-12 y-13)
  (letrec* ((magic_method-313
             (getattribute-from-obj-mro y-13 (&& "__rmatmul__"))))
    (if (py-test (py-is magic_method-313 py-absent))
        (py-matmul-fallback:err x-12 y-13)
        (letrec* ((result-319 (py-call magic_method-313 y-13 x-12)))
          (if (py-test (py-is result-319 py-NotImplemented))
              (py-matmul-fallback:err x-12 y-13)
              result-319)))))

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
  (letrec* ((magic_method-353 (getattribute-from-obj-mro x-14 (&& "__mod__"))))
    (if (py-test (py-is magic_method-353 py-absent))
        (py-mod-fallback:reflected x-14 y-15)
        (letrec* ((result-359 (py-call magic_method-353 x-14 y-15)))
          (if (py-test (py-is result-359 py-NotImplemented))
              (py-mod-fallback:reflected x-14 y-15)
              result-359)))))

(define (py-mod-fallback:reflected x-14 y-15)
  (letrec* ((magic_method-343
             (getattribute-from-obj-mro y-15 (&& "__rmod__"))))
    (if (py-test (py-is magic_method-343 py-absent))
        (py-mod-fallback:err x-14 y-15)
        (letrec* ((result-349 (py-call magic_method-343 y-15 x-14)))
          (if (py-test (py-is result-349 py-NotImplemented))
              (py-mod-fallback:err x-14 y-15)
              result-349)))))

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
  (letrec* ((magic_method-383 (getattribute-from-obj-mro x-16 (&& "__mul__"))))
    (if (py-test (py-is magic_method-383 py-absent))
        (py-mul-fallback:reflected x-16 y-17)
        (letrec* ((result-389 (py-call magic_method-383 x-16 y-17)))
          (if (py-test (py-is result-389 py-NotImplemented))
              (py-mul-fallback:reflected x-16 y-17)
              result-389)))))

(define (py-mul-fallback:reflected x-16 y-17)
  (letrec* ((magic_method-373
             (getattribute-from-obj-mro y-17 (&& "__rmul__"))))
    (if (py-test (py-is magic_method-373 py-absent))
        (py-mul-fallback:err x-16 y-17)
        (letrec* ((result-379 (py-call magic_method-373 y-17 x-16)))
          (if (py-test (py-is result-379 py-NotImplemented))
              (py-mul-fallback:err x-16 y-17)
              result-379)))))

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
  (letrec* ((magic_method-413 (getattribute-from-obj-mro x-18 (&& "__pow__"))))
    (if (py-test (py-is magic_method-413 py-absent))
        (py-pow-fallback:reflected x-18 y-19)
        (letrec* ((result-419 (py-call magic_method-413 x-18 y-19)))
          (if (py-test (py-is result-419 py-NotImplemented))
              (py-pow-fallback:reflected x-18 y-19)
              result-419)))))

(define (py-pow-fallback:reflected x-18 y-19)
  (letrec* ((magic_method-403
             (getattribute-from-obj-mro y-19 (&& "__rpow__"))))
    (if (py-test (py-is magic_method-403 py-absent))
        (py-pow-fallback:err x-18 y-19)
        (letrec* ((result-409 (py-call magic_method-403 y-19 x-18)))
          (if (py-test (py-is result-409 py-NotImplemented))
              (py-pow-fallback:err x-18 y-19)
              result-409)))))

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
  (letrec* ((magic_method-443
             (getattribute-from-obj-mro x-20 (&& "__rshift__"))))
    (if (py-test (py-is magic_method-443 py-absent))
        (py-rshift-fallback:reflected x-20 y-21)
        (letrec* ((result-449 (py-call magic_method-443 x-20 y-21)))
          (if (py-test (py-is result-449 py-NotImplemented))
              (py-rshift-fallback:reflected x-20 y-21)
              result-449)))))

(define (py-rshift-fallback:reflected x-20 y-21)
  (letrec* ((magic_method-433
             (getattribute-from-obj-mro y-21 (&& "__rrshift__"))))
    (if (py-test (py-is magic_method-433 py-absent))
        (py-rshift-fallback:err x-20 y-21)
        (letrec* ((result-439 (py-call magic_method-433 y-21 x-20)))
          (if (py-test (py-is result-439 py-NotImplemented))
              (py-rshift-fallback:err x-20 y-21)
              result-439)))))

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
  (letrec* ((magic_method-473 (getattribute-from-obj-mro x-22 (&& "__sub__"))))
    (if (py-test (py-is magic_method-473 py-absent))
        (py-sub-fallback:reflected x-22 y-23)
        (letrec* ((result-479 (py-call magic_method-473 x-22 y-23)))
          (if (py-test (py-is result-479 py-NotImplemented))
              (py-sub-fallback:reflected x-22 y-23)
              result-479)))))

(define (py-sub-fallback:reflected x-22 y-23)
  (letrec* ((magic_method-463
             (getattribute-from-obj-mro y-23 (&& "__rsub__"))))
    (if (py-test (py-is magic_method-463 py-absent))
        (py-sub-fallback:err x-22 y-23)
        (letrec* ((result-469 (py-call magic_method-463 y-23 x-22)))
          (if (py-test (py-is result-469 py-NotImplemented))
              (py-sub-fallback:err x-22 y-23)
              result-469)))))

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
  (letrec* ((magic_method-503
             (getattribute-from-obj-mro x-24 (&& "__truediv__"))))
    (if (py-test (py-is magic_method-503 py-absent))
        (py-truediv-fallback:reflected x-24 y-25)
        (letrec* ((result-509 (py-call magic_method-503 x-24 y-25)))
          (if (py-test (py-is result-509 py-NotImplemented))
              (py-truediv-fallback:reflected x-24 y-25)
              result-509)))))

(define (py-truediv-fallback:reflected x-24 y-25)
  (letrec* ((magic_method-493
             (getattribute-from-obj-mro y-25 (&& "__rtruediv__"))))
    (if (py-test (py-is magic_method-493 py-absent))
        (py-truediv-fallback:err x-24 y-25)
        (letrec* ((result-499 (py-call magic_method-493 y-25 x-24)))
          (if (py-test (py-is result-499 py-NotImplemented))
              (py-truediv-fallback:err x-24 y-25)
              result-499)))))

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
  (letrec* ((magic_method-533 (getattribute-from-obj-mro x-26 (&& "__xor__"))))
    (if (py-test (py-is magic_method-533 py-absent))
        (py-xor-fallback:reflected x-26 y-27)
        (letrec* ((result-539 (py-call magic_method-533 x-26 y-27)))
          (if (py-test (py-is result-539 py-NotImplemented))
              (py-xor-fallback:reflected x-26 y-27)
              result-539)))))

(define (py-xor-fallback:reflected x-26 y-27)
  (letrec* ((magic_method-523
             (getattribute-from-obj-mro y-27 (&& "__rxor__"))))
    (if (py-test (py-is magic_method-523 py-absent))
        (py-xor-fallback:err x-26 y-27)
        (letrec* ((result-529 (py-call magic_method-523 y-27 x-26)))
          (if (py-test (py-is result-529 py-NotImplemented))
              (py-xor-fallback:err x-26 y-27)
              result-529)))))

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
  (letrec* ((magic_method-575
             (getattribute-from-obj-mro x-28 (&& "__iadd__"))))
    (if (py-test (py-is magic_method-575 py-absent))
        (py-iadd-fallback:normal x-28 y-29)
        (letrec* ((result-581 (py-call magic_method-575 x-28 y-29)))
          (if (py-test (py-is result-581 py-NotImplemented))
              (py-iadd-fallback:normal x-28 y-29)
              result-581)))))

(define (py-iadd-fallback:normal x-28 y-29)
  (letrec* ((magic_method-565 (getattribute-from-obj-mro x-28 (&& "__add__"))))
    (if (py-test (py-is magic_method-565 py-absent))
        (py-iadd-fallback:reflected x-28 y-29)
        (letrec* ((result-571 (py-call magic_method-565 x-28 y-29)))
          (if (py-test (py-is result-571 py-NotImplemented))
              (py-iadd-fallback:reflected x-28 y-29)
              result-571)))))

(define (py-iadd-fallback:reflected x-28 y-29)
  (letrec* ((magic_method-555
             (getattribute-from-obj-mro y-29 (&& "__radd__"))))
    (if (py-test (py-is magic_method-555 py-absent))
        (py-iadd-fallback:err x-28 y-29)
        (letrec* ((result-561 (py-call magic_method-555 y-29 x-28)))
          (if (py-test (py-is result-561 py-NotImplemented))
              (py-iadd-fallback:err x-28 y-29)
              result-561)))))

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
  (letrec* ((magic_method-617
             (getattribute-from-obj-mro x-30 (&& "__iand__"))))
    (if (py-test (py-is magic_method-617 py-absent))
        (py-ibitand-fallback:normal x-30 y-31)
        (letrec* ((result-623 (py-call magic_method-617 x-30 y-31)))
          (if (py-test (py-is result-623 py-NotImplemented))
              (py-ibitand-fallback:normal x-30 y-31)
              result-623)))))

(define (py-ibitand-fallback:normal x-30 y-31)
  (letrec* ((magic_method-607 (getattribute-from-obj-mro x-30 (&& "__and__"))))
    (if (py-test (py-is magic_method-607 py-absent))
        (py-ibitand-fallback:reflected x-30 y-31)
        (letrec* ((result-613 (py-call magic_method-607 x-30 y-31)))
          (if (py-test (py-is result-613 py-NotImplemented))
              (py-ibitand-fallback:reflected x-30 y-31)
              result-613)))))

(define (py-ibitand-fallback:reflected x-30 y-31)
  (letrec* ((magic_method-597
             (getattribute-from-obj-mro y-31 (&& "__rand__"))))
    (if (py-test (py-is magic_method-597 py-absent))
        (py-ibitand-fallback:err x-30 y-31)
        (letrec* ((result-603 (py-call magic_method-597 y-31 x-30)))
          (if (py-test (py-is result-603 py-NotImplemented))
              (py-ibitand-fallback:err x-30 y-31)
              result-603)))))

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
  (letrec* ((magic_method-659 (getattribute-from-obj-mro x-32 (&& "__ior__"))))
    (if (py-test (py-is magic_method-659 py-absent))
        (py-ibitor-fallback:normal x-32 y-33)
        (letrec* ((result-665 (py-call magic_method-659 x-32 y-33)))
          (if (py-test (py-is result-665 py-NotImplemented))
              (py-ibitor-fallback:normal x-32 y-33)
              result-665)))))

(define (py-ibitor-fallback:normal x-32 y-33)
  (letrec* ((magic_method-649 (getattribute-from-obj-mro x-32 (&& "__or__"))))
    (if (py-test (py-is magic_method-649 py-absent))
        (py-ibitor-fallback:reflected x-32 y-33)
        (letrec* ((result-655 (py-call magic_method-649 x-32 y-33)))
          (if (py-test (py-is result-655 py-NotImplemented))
              (py-ibitor-fallback:reflected x-32 y-33)
              result-655)))))

(define (py-ibitor-fallback:reflected x-32 y-33)
  (letrec* ((magic_method-639 (getattribute-from-obj-mro y-33 (&& "__ror__"))))
    (if (py-test (py-is magic_method-639 py-absent))
        (py-ibitor-fallback:err x-32 y-33)
        (letrec* ((result-645 (py-call magic_method-639 y-33 x-32)))
          (if (py-test (py-is result-645 py-NotImplemented))
              (py-ibitor-fallback:err x-32 y-33)
              result-645)))))

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
  (letrec* ((magic_method-701
             (getattribute-from-obj-mro x-34 (&& "__ifloordiv__"))))
    (if (py-test (py-is magic_method-701 py-absent))
        (py-ifloordiv-fallback:normal x-34 y-35)
        (letrec* ((result-707 (py-call magic_method-701 x-34 y-35)))
          (if (py-test (py-is result-707 py-NotImplemented))
              (py-ifloordiv-fallback:normal x-34 y-35)
              result-707)))))

(define (py-ifloordiv-fallback:normal x-34 y-35)
  (letrec* ((magic_method-691
             (getattribute-from-obj-mro x-34 (&& "__floordiv__"))))
    (if (py-test (py-is magic_method-691 py-absent))
        (py-ifloordiv-fallback:reflected x-34 y-35)
        (letrec* ((result-697 (py-call magic_method-691 x-34 y-35)))
          (if (py-test (py-is result-697 py-NotImplemented))
              (py-ifloordiv-fallback:reflected x-34 y-35)
              result-697)))))

(define (py-ifloordiv-fallback:reflected x-34 y-35)
  (letrec* ((magic_method-681
             (getattribute-from-obj-mro y-35 (&& "__rfloordiv__"))))
    (if (py-test (py-is magic_method-681 py-absent))
        (py-ifloordiv-fallback:err x-34 y-35)
        (letrec* ((result-687 (py-call magic_method-681 y-35 x-34)))
          (if (py-test (py-is result-687 py-NotImplemented))
              (py-ifloordiv-fallback:err x-34 y-35)
              result-687)))))

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
  (letrec* ((magic_method-743
             (getattribute-from-obj-mro x-36 (&& "__ilshift__"))))
    (if (py-test (py-is magic_method-743 py-absent))
        (py-ilshift-fallback:normal x-36 y-37)
        (letrec* ((result-749 (py-call magic_method-743 x-36 y-37)))
          (if (py-test (py-is result-749 py-NotImplemented))
              (py-ilshift-fallback:normal x-36 y-37)
              result-749)))))

(define (py-ilshift-fallback:normal x-36 y-37)
  (letrec* ((magic_method-733
             (getattribute-from-obj-mro x-36 (&& "__lshift__"))))
    (if (py-test (py-is magic_method-733 py-absent))
        (py-ilshift-fallback:reflected x-36 y-37)
        (letrec* ((result-739 (py-call magic_method-733 x-36 y-37)))
          (if (py-test (py-is result-739 py-NotImplemented))
              (py-ilshift-fallback:reflected x-36 y-37)
              result-739)))))

(define (py-ilshift-fallback:reflected x-36 y-37)
  (letrec* ((magic_method-723
             (getattribute-from-obj-mro y-37 (&& "__rlshift__"))))
    (if (py-test (py-is magic_method-723 py-absent))
        (py-ilshift-fallback:err x-36 y-37)
        (letrec* ((result-729 (py-call magic_method-723 y-37 x-36)))
          (if (py-test (py-is result-729 py-NotImplemented))
              (py-ilshift-fallback:err x-36 y-37)
              result-729)))))

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
  (letrec* ((magic_method-785
             (getattribute-from-obj-mro x-38 (&& "__imatmul__"))))
    (if (py-test (py-is magic_method-785 py-absent))
        (py-imatmul-fallback:normal x-38 y-39)
        (letrec* ((result-791 (py-call magic_method-785 x-38 y-39)))
          (if (py-test (py-is result-791 py-NotImplemented))
              (py-imatmul-fallback:normal x-38 y-39)
              result-791)))))

(define (py-imatmul-fallback:normal x-38 y-39)
  (letrec* ((magic_method-775
             (getattribute-from-obj-mro x-38 (&& "__matmul__"))))
    (if (py-test (py-is magic_method-775 py-absent))
        (py-imatmul-fallback:reflected x-38 y-39)
        (letrec* ((result-781 (py-call magic_method-775 x-38 y-39)))
          (if (py-test (py-is result-781 py-NotImplemented))
              (py-imatmul-fallback:reflected x-38 y-39)
              result-781)))))

(define (py-imatmul-fallback:reflected x-38 y-39)
  (letrec* ((magic_method-765
             (getattribute-from-obj-mro y-39 (&& "__rmatmul__"))))
    (if (py-test (py-is magic_method-765 py-absent))
        (py-imatmul-fallback:err x-38 y-39)
        (letrec* ((result-771 (py-call magic_method-765 y-39 x-38)))
          (if (py-test (py-is result-771 py-NotImplemented))
              (py-imatmul-fallback:err x-38 y-39)
              result-771)))))

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
  (letrec* ((magic_method-827
             (getattribute-from-obj-mro x-40 (&& "__imod__"))))
    (if (py-test (py-is magic_method-827 py-absent))
        (py-imod-fallback:normal x-40 y-41)
        (letrec* ((result-833 (py-call magic_method-827 x-40 y-41)))
          (if (py-test (py-is result-833 py-NotImplemented))
              (py-imod-fallback:normal x-40 y-41)
              result-833)))))

(define (py-imod-fallback:normal x-40 y-41)
  (letrec* ((magic_method-817 (getattribute-from-obj-mro x-40 (&& "__mod__"))))
    (if (py-test (py-is magic_method-817 py-absent))
        (py-imod-fallback:reflected x-40 y-41)
        (letrec* ((result-823 (py-call magic_method-817 x-40 y-41)))
          (if (py-test (py-is result-823 py-NotImplemented))
              (py-imod-fallback:reflected x-40 y-41)
              result-823)))))

(define (py-imod-fallback:reflected x-40 y-41)
  (letrec* ((magic_method-807
             (getattribute-from-obj-mro y-41 (&& "__rmod__"))))
    (if (py-test (py-is magic_method-807 py-absent))
        (py-imod-fallback:err x-40 y-41)
        (letrec* ((result-813 (py-call magic_method-807 y-41 x-40)))
          (if (py-test (py-is result-813 py-NotImplemented))
              (py-imod-fallback:err x-40 y-41)
              result-813)))))

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
  (letrec* ((magic_method-869
             (getattribute-from-obj-mro x-42 (&& "__imul__"))))
    (if (py-test (py-is magic_method-869 py-absent))
        (py-imul-fallback:normal x-42 y-43)
        (letrec* ((result-875 (py-call magic_method-869 x-42 y-43)))
          (if (py-test (py-is result-875 py-NotImplemented))
              (py-imul-fallback:normal x-42 y-43)
              result-875)))))

(define (py-imul-fallback:normal x-42 y-43)
  (letrec* ((magic_method-859 (getattribute-from-obj-mro x-42 (&& "__mul__"))))
    (if (py-test (py-is magic_method-859 py-absent))
        (py-imul-fallback:reflected x-42 y-43)
        (letrec* ((result-865 (py-call magic_method-859 x-42 y-43)))
          (if (py-test (py-is result-865 py-NotImplemented))
              (py-imul-fallback:reflected x-42 y-43)
              result-865)))))

(define (py-imul-fallback:reflected x-42 y-43)
  (letrec* ((magic_method-849
             (getattribute-from-obj-mro y-43 (&& "__rmul__"))))
    (if (py-test (py-is magic_method-849 py-absent))
        (py-imul-fallback:err x-42 y-43)
        (letrec* ((result-855 (py-call magic_method-849 y-43 x-42)))
          (if (py-test (py-is result-855 py-NotImplemented))
              (py-imul-fallback:err x-42 y-43)
              result-855)))))

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
  (letrec* ((magic_method-911
             (getattribute-from-obj-mro x-44 (&& "__ipow__"))))
    (if (py-test (py-is magic_method-911 py-absent))
        (py-ipow-fallback:normal x-44 y-45)
        (letrec* ((result-917 (py-call magic_method-911 x-44 y-45)))
          (if (py-test (py-is result-917 py-NotImplemented))
              (py-ipow-fallback:normal x-44 y-45)
              result-917)))))

(define (py-ipow-fallback:normal x-44 y-45)
  (letrec* ((magic_method-901 (getattribute-from-obj-mro x-44 (&& "__pow__"))))
    (if (py-test (py-is magic_method-901 py-absent))
        (py-ipow-fallback:reflected x-44 y-45)
        (letrec* ((result-907 (py-call magic_method-901 x-44 y-45)))
          (if (py-test (py-is result-907 py-NotImplemented))
              (py-ipow-fallback:reflected x-44 y-45)
              result-907)))))

(define (py-ipow-fallback:reflected x-44 y-45)
  (letrec* ((magic_method-891
             (getattribute-from-obj-mro y-45 (&& "__rpow__"))))
    (if (py-test (py-is magic_method-891 py-absent))
        (py-ipow-fallback:err x-44 y-45)
        (letrec* ((result-897 (py-call magic_method-891 y-45 x-44)))
          (if (py-test (py-is result-897 py-NotImplemented))
              (py-ipow-fallback:err x-44 y-45)
              result-897)))))

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
  (letrec* ((magic_method-953
             (getattribute-from-obj-mro x-46 (&& "__irshift__"))))
    (if (py-test (py-is magic_method-953 py-absent))
        (py-irshift-fallback:normal x-46 y-47)
        (letrec* ((result-959 (py-call magic_method-953 x-46 y-47)))
          (if (py-test (py-is result-959 py-NotImplemented))
              (py-irshift-fallback:normal x-46 y-47)
              result-959)))))

(define (py-irshift-fallback:normal x-46 y-47)
  (letrec* ((magic_method-943
             (getattribute-from-obj-mro x-46 (&& "__rshift__"))))
    (if (py-test (py-is magic_method-943 py-absent))
        (py-irshift-fallback:reflected x-46 y-47)
        (letrec* ((result-949 (py-call magic_method-943 x-46 y-47)))
          (if (py-test (py-is result-949 py-NotImplemented))
              (py-irshift-fallback:reflected x-46 y-47)
              result-949)))))

(define (py-irshift-fallback:reflected x-46 y-47)
  (letrec* ((magic_method-933
             (getattribute-from-obj-mro y-47 (&& "__rrshift__"))))
    (if (py-test (py-is magic_method-933 py-absent))
        (py-irshift-fallback:err x-46 y-47)
        (letrec* ((result-939 (py-call magic_method-933 y-47 x-46)))
          (if (py-test (py-is result-939 py-NotImplemented))
              (py-irshift-fallback:err x-46 y-47)
              result-939)))))

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
  (letrec* ((magic_method-995
             (getattribute-from-obj-mro x-48 (&& "__isub__"))))
    (if (py-test (py-is magic_method-995 py-absent))
        (py-isub-fallback:normal x-48 y-49)
        (letrec* ((result-1001 (py-call magic_method-995 x-48 y-49)))
          (if (py-test (py-is result-1001 py-NotImplemented))
              (py-isub-fallback:normal x-48 y-49)
              result-1001)))))

(define (py-isub-fallback:normal x-48 y-49)
  (letrec* ((magic_method-985 (getattribute-from-obj-mro x-48 (&& "__sub__"))))
    (if (py-test (py-is magic_method-985 py-absent))
        (py-isub-fallback:reflected x-48 y-49)
        (letrec* ((result-991 (py-call magic_method-985 x-48 y-49)))
          (if (py-test (py-is result-991 py-NotImplemented))
              (py-isub-fallback:reflected x-48 y-49)
              result-991)))))

(define (py-isub-fallback:reflected x-48 y-49)
  (letrec* ((magic_method-975
             (getattribute-from-obj-mro y-49 (&& "__rsub__"))))
    (if (py-test (py-is magic_method-975 py-absent))
        (py-isub-fallback:err x-48 y-49)
        (letrec* ((result-981 (py-call magic_method-975 y-49 x-48)))
          (if (py-test (py-is result-981 py-NotImplemented))
              (py-isub-fallback:err x-48 y-49)
              result-981)))))

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
  (letrec* ((magic_method-1037
             (getattribute-from-obj-mro x-50 (&& "__itruediv__"))))
    (if (py-test (py-is magic_method-1037 py-absent))
        (py-itruediv-fallback:normal x-50 y-51)
        (letrec* ((result-1043 (py-call magic_method-1037 x-50 y-51)))
          (if (py-test (py-is result-1043 py-NotImplemented))
              (py-itruediv-fallback:normal x-50 y-51)
              result-1043)))))

(define (py-itruediv-fallback:normal x-50 y-51)
  (letrec* ((magic_method-1027
             (getattribute-from-obj-mro x-50 (&& "__truediv__"))))
    (if (py-test (py-is magic_method-1027 py-absent))
        (py-itruediv-fallback:reflected x-50 y-51)
        (letrec* ((result-1033 (py-call magic_method-1027 x-50 y-51)))
          (if (py-test (py-is result-1033 py-NotImplemented))
              (py-itruediv-fallback:reflected x-50 y-51)
              result-1033)))))

(define (py-itruediv-fallback:reflected x-50 y-51)
  (letrec* ((magic_method-1017
             (getattribute-from-obj-mro y-51 (&& "__rtruediv__"))))
    (if (py-test (py-is magic_method-1017 py-absent))
        (py-itruediv-fallback:err x-50 y-51)
        (letrec* ((result-1023 (py-call magic_method-1017 y-51 x-50)))
          (if (py-test (py-is result-1023 py-NotImplemented))
              (py-itruediv-fallback:err x-50 y-51)
              result-1023)))))

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
  (letrec* ((magic_method-1079
             (getattribute-from-obj-mro x-52 (&& "__ixor__"))))
    (if (py-test (py-is magic_method-1079 py-absent))
        (py-ixor-fallback:normal x-52 y-53)
        (letrec* ((result-1085 (py-call magic_method-1079 x-52 y-53)))
          (if (py-test (py-is result-1085 py-NotImplemented))
              (py-ixor-fallback:normal x-52 y-53)
              result-1085)))))

(define (py-ixor-fallback:normal x-52 y-53)
  (letrec* ((magic_method-1069
             (getattribute-from-obj-mro x-52 (&& "__xor__"))))
    (if (py-test (py-is magic_method-1069 py-absent))
        (py-ixor-fallback:reflected x-52 y-53)
        (letrec* ((result-1075 (py-call magic_method-1069 x-52 y-53)))
          (if (py-test (py-is result-1075 py-NotImplemented))
              (py-ixor-fallback:reflected x-52 y-53)
              result-1075)))))

(define (py-ixor-fallback:reflected x-52 y-53)
  (letrec* ((magic_method-1059
             (getattribute-from-obj-mro y-53 (&& "__rxor__"))))
    (if (py-test (py-is magic_method-1059 py-absent))
        (py-ixor-fallback:err x-52 y-53)
        (letrec* ((result-1065 (py-call magic_method-1059 y-53 x-52)))
          (if (py-test (py-is result-1065 py-NotImplemented))
              (py-ixor-fallback:err x-52 y-53)
              result-1065)))))

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
  (letrec* ((magic_method-1096
             (getattribute-from-obj-mro x-54 (&& "__pos__"))))
    (if (py-test (py-is magic_method-1096 py-absent))
        (py-pos-fallback:err x-54)
        (py-call magic_method-1096 x-54))))

(define (py-pos-fallback:err x-54)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (&& "bad operand type for unary +: '")
                            (py-getattribute
                             (py-call py-builtin-type x-54)
                             (& "__name__")))
                    (&& "'")))))

(define (py-neg-fallback:normal x-55)
  (letrec* ((magic_method-1109
             (getattribute-from-obj-mro x-55 (&& "__neg__"))))
    (if (py-test (py-is magic_method-1109 py-absent))
        (py-neg-fallback:err x-55)
        (py-call magic_method-1109 x-55))))

(define (py-neg-fallback:err x-55)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (&& "bad operand type for unary -: '")
                            (py-getattribute
                             (py-call py-builtin-type x-55)
                             (& "__name__")))
                    (&& "'")))))

(define (py-invert-fallback:normal x-56)
  (letrec* ((magic_method-1122
             (getattribute-from-obj-mro x-56 (&& "__invert__"))))
    (if (py-test (py-is magic_method-1122 py-absent))
        (py-invert-fallback:err x-56)
        (py-call magic_method-1122 x-56))))

(define (py-invert-fallback:err x-56)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (&& "bad operand type for unary ~: '")
                            (py-getattribute
                             (py-call py-builtin-type x-56)
                             (& "__name__")))
                    (&& "'")))))

(define (py-ge-fallback:normal x-57 y-58)
  (letrec* ((magic_method-1148 (getattribute-from-obj-mro x-57 (&& "__ge__"))))
    (if (py-test (py-is magic_method-1148 py-absent))
        (py-ge-fallback:reflected x-57 y-58)
        (letrec* ((result-1154 (py-call magic_method-1148 x-57 y-58)))
          (if (py-test (py-is result-1154 py-NotImplemented))
              (py-ge-fallback:reflected x-57 y-58)
              result-1154)))))

(define (py-ge-fallback:reflected x-57 y-58)
  (letrec* ((magic_method-1138 (getattribute-from-obj-mro y-58 (&& "__le__"))))
    (if (py-test (py-is magic_method-1138 py-absent))
        (py-ge-fallback:err x-57 y-58)
        (letrec* ((result-1144 (py-call magic_method-1138 y-58 x-57)))
          (if (py-test (py-is result-1144 py-NotImplemented))
              (py-ge-fallback:err x-57 y-58)
              result-1144)))))

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
  (letrec* ((magic_method-1178 (getattribute-from-obj-mro x-59 (&& "__gt__"))))
    (if (py-test (py-is magic_method-1178 py-absent))
        (py-gt-fallback:reflected x-59 y-60)
        (letrec* ((result-1184 (py-call magic_method-1178 x-59 y-60)))
          (if (py-test (py-is result-1184 py-NotImplemented))
              (py-gt-fallback:reflected x-59 y-60)
              result-1184)))))

(define (py-gt-fallback:reflected x-59 y-60)
  (letrec* ((magic_method-1168 (getattribute-from-obj-mro y-60 (&& "__lt__"))))
    (if (py-test (py-is magic_method-1168 py-absent))
        (py-gt-fallback:err x-59 y-60)
        (letrec* ((result-1174 (py-call magic_method-1168 y-60 x-59)))
          (if (py-test (py-is result-1174 py-NotImplemented))
              (py-gt-fallback:err x-59 y-60)
              result-1174)))))

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
  (letrec* ((magic_method-1208 (getattribute-from-obj-mro x-61 (&& "__le__"))))
    (if (py-test (py-is magic_method-1208 py-absent))
        (py-le-fallback:reflected x-61 y-62)
        (letrec* ((result-1214 (py-call magic_method-1208 x-61 y-62)))
          (if (py-test (py-is result-1214 py-NotImplemented))
              (py-le-fallback:reflected x-61 y-62)
              result-1214)))))

(define (py-le-fallback:reflected x-61 y-62)
  (letrec* ((magic_method-1198 (getattribute-from-obj-mro y-62 (&& "__ge__"))))
    (if (py-test (py-is magic_method-1198 py-absent))
        (py-le-fallback:err x-61 y-62)
        (letrec* ((result-1204 (py-call magic_method-1198 y-62 x-61)))
          (if (py-test (py-is result-1204 py-NotImplemented))
              (py-le-fallback:err x-61 y-62)
              result-1204)))))

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
  (letrec* ((magic_method-1238 (getattribute-from-obj-mro x-63 (&& "__lt__"))))
    (if (py-test (py-is magic_method-1238 py-absent))
        (py-lt-fallback:reflected x-63 y-64)
        (letrec* ((result-1244 (py-call magic_method-1238 x-63 y-64)))
          (if (py-test (py-is result-1244 py-NotImplemented))
              (py-lt-fallback:reflected x-63 y-64)
              result-1244)))))

(define (py-lt-fallback:reflected x-63 y-64)
  (letrec* ((magic_method-1228 (getattribute-from-obj-mro y-64 (&& "__gt__"))))
    (if (py-test (py-is magic_method-1228 py-absent))
        (py-lt-fallback:err x-63 y-64)
        (letrec* ((result-1234 (py-call magic_method-1228 y-64 x-63)))
          (if (py-test (py-is result-1234 py-NotImplemented))
              (py-lt-fallback:err x-63 y-64)
              result-1234)))))

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
  (letrec* ((magic_method-1266 (getattribute-from-obj-mro x-65 (&& "__eq__"))))
    (if (py-test (py-is magic_method-1266 py-absent))
        (py-eq-fallback:reflected x-65 y-66)
        (letrec* ((result-1272 (py-call magic_method-1266 x-65 y-66)))
          (if (py-test (py-is result-1272 py-NotImplemented))
              (py-eq-fallback:reflected x-65 y-66)
              result-1272)))))

(define (py-eq-fallback:reflected x-65 y-66)
  (letrec* ((magic_method-1256 (getattribute-from-obj-mro y-66 (&& "__eq__"))))
    (if (py-test (py-is magic_method-1256 py-absent))
        (py-eq-fallback:default x-65 y-66)
        (letrec* ((result-1262 (py-call magic_method-1256 y-66 x-65)))
          (if (py-test (py-is result-1262 py-NotImplemented))
              (py-eq-fallback:default x-65 y-66)
              result-1262)))))

(define (py-eq-fallback:default x-65 y-66) (py-is x-65 y-66))

(define (py-ne-fallback:normal x-67 y-68)
  (letrec* ((magic_method-1294 (getattribute-from-obj-mro x-67 (&& "__ne__"))))
    (if (py-test (py-is magic_method-1294 py-absent))
        (py-ne-fallback:reflected x-67 y-68)
        (letrec* ((result-1300 (py-call magic_method-1294 x-67 y-68)))
          (if (py-test (py-is result-1300 py-NotImplemented))
              (py-ne-fallback:reflected x-67 y-68)
              result-1300)))))

(define (py-ne-fallback:reflected x-67 y-68)
  (letrec* ((magic_method-1284 (getattribute-from-obj-mro y-68 (&& "__ne__"))))
    (if (py-test (py-is magic_method-1284 py-absent))
        (py-ne-fallback:default x-67 y-68)
        (letrec* ((result-1290 (py-call magic_method-1284 y-68 x-67)))
          (if (py-test (py-is result-1290 py-NotImplemented))
              (py-ne-fallback:default x-67 y-68)
              result-1290)))))

(define (py-ne-fallback:default x-67 y-68) (py-isnot x-67 y-68))

(define (py-maybe-trunc-fallback obj-69)
  (letrec* ((__trunc__-1304
             (getattribute-from-obj-mro obj-69 (&& "__trunc__"))))
    (if (py-test (py-is __trunc__-1304 py-absent))
        py-absent
        (letrec* ((result-1309 (py-call __trunc__-1304 obj-69)))
          (if (py-isinstance? result-1309 py-builtin-int)
              result-1309
              (py-throw
               (py-call py-builtin-TypeError
                        (py-add (py-add (&& "__trunc__ returned non-int type: '")
                                        (py-getattribute
                                         (py-call py-builtin-type obj-69)
                                         (& "__name__")))
                                (&& "'")))))))))

(define (py-trunc-fallback obj-70)
  (letrec* ((result-1315 (py-maybe-trunc-fallback obj-70)))
    (if (py-test (py-is result-1315 py-absent))
        (py-throw
         (py-call py-builtin-TypeError
                  (py-add (py-add (&& "type '")
                                  (py-getattribute
                                   (py-call py-builtin-type obj-70)
                                   (& "__name__")))
                          (&& "' doesn't define __trunc__ method"))))
        result-1315)))

(define (py-maybe-to-int-fallback obj-71)
  (letrec* ((__int__-1322 (getattribute-from-obj-mro obj-71 (&& "__int__"))))
    (if (py-test (py-is __int__-1322 py-absent))
        py-absent
        (letrec* ((result-1327 (py-call __int__-1322 obj-71)))
          (if (py-isinstance? result-1327 py-builtin-int)
              result-1327
              (py-throw
               (py-call py-builtin-TypeError
                        (py-add (py-add (&& "__int__ returned non-int type: '")
                                        (py-getattribute
                                         (py-call py-builtin-type obj-71)
                                         (& "__name__")))
                                (&& "'")))))))))

(define (py-to-int-fallback obj-72)
  (letrec* ((result-1333 (py-maybe-to-int-fallback obj-72)))
    (if (py-test (py-is result-1333 py-absent))
        (py-throw
         (py-call py-builtin-TypeError
                  (py-add (py-add (&& "'")
                                  (py-getattribute
                                   (py-call py-builtin-type obj-72)
                                   (& "__name__")))
                          (&& "' object cannot be interpreted as an integer"))))
        result-1333)))

(define (py-maybe-index-fallback obj-73)
  (letrec* ((__index__-1340
             (getattribute-from-obj-mro obj-73 (&& "__index__"))))
    (if (py-test (py-is __index__-1340 py-absent))
        py-absent
        (letrec* ((result-1345 (py-call __index__-1340 obj-73)))
          (if (py-test (py-is result-1345 py-absent))
              py-absent
              (if (py-has-type-sint? result-1345)
                  result-1345
                  (if (py-has-type-bint? result-1345)
                      (py-throw
                       (py-call py-builtin-OverflowError
                                (&& "cannot fit 'int' into an index-sized integer")))
                      (py-throw
                       (py-call py-builtin-TypeError
                                (py-add (py-add (&& "__index__ returned non-int type: '")
                                                (py-getattribute
                                                 (py-call py-builtin-type
                                                          obj-73)
                                                 (& "__name__")))
                                        (&& "'")))))))))))

(define (py-index-fallback obj-74)
  (letrec* ((result-1353 (py-maybe-index-fallback obj-74)))
    (if (py-test (py-is result-1353 py-absent))
        (py-throw
         (py-call py-builtin-TypeError
                  (py-add (py-add (&& "'")
                                  (py-getattribute
                                   (py-call py-builtin-type obj-74)
                                   (& "__name__")))
                          (&& "' object cannot be interpreted as an integer"))))
        result-1353)))

(define (py-maybe-len-fallback obj-75)
  (letrec* ((__len__-1360 (getattribute-from-obj-mro obj-75 (&& "__len__"))))
    (if (py-test (py-is __len__-1360 py-absent))
        py-absent
        (letrec* ((len_result-1365 (py-call __len__-1360 obj-75)))
          (py-index-fallback len_result-1365)))))

(define (py-len-fallback obj-76)
  (letrec* ((result-1368 (py-maybe-len-fallback obj-76)))
    (if (py-test (py-is result-1368 py-absent))
        (py-throw
         (py-call py-builtin-TypeError
                  (py-add (py-add (&& "object of type")
                                  (py-getattribute
                                   (py-call py-builtin-type obj-76)
                                   (& "__name__")))
                          (&& "has no len()"))))
        result-1368)))

(define (py-truth-fallback obj-77)
  (letrec* ((__bool__-1375 (getattribute-from-obj-mro obj-77 (&& "__bool__"))))
    (if (py-test (py-isnot __bool__-1375 py-absent))
        (letrec* ((result-1380 (py-call __bool__-1375 obj-77)))
          (if (py-isinstance? result-1380 py-builtin-bool)
              result-1380
              (py-throw
               (py-call py-builtin-TypeError
                        (py-add (py-add (&& "__bool__ should return bool, returned '")
                                        (py-getattribute
                                         (py-call py-builtin-type obj-77)
                                         (& "__name__")))
                                (&& "'"))))))
        (letrec* ((len_result-1386 (py-maybe-len-fallback obj-77)))
          (if (py-test (py-isnot len_result-1386 py-absent))
              (py-ne len_result-1386 (py-int-from-scheme 0))
              py-True)))))

(define (py-test-fallback obj-78)
  (py-bool-to-scheme-bool (py-truth-fallback obj-78)))

(define (py-getattribute-fallback obj-79 attr-80)
  (letrec* ((__getattribute__-1392
             (getattribute-from-obj-mro obj-79 (&& "__getattribute__"))))
    (with-handler
     (lambda ($%exc_0)
       (cond ((py-isinstance? $%exc_0 py-builtin-AttributeError)
              (letrec* ((__getattr__-1398
                         (getattribute-from-obj-mro
                          obj-79
                          (&& "__getattr__"))))
                (if (py-test (py-is __getattr__-1398 py-absent))
                    (py-throw $%exc_0)
                    (py-call __getattr__-1398 obj-79 attr-80))))
             (else (raise $%exc_0))))
     (py-call __getattribute__-1392 obj-79 attr-80))))

(define (py-setattribute-fallback obj-81 attr-82 val-83)
  (letrec* ((__setattr__-1401
             (getattribute-from-obj-mro obj-81 (&& "__setattr__"))))
    (py-call __setattr__-1401 obj-81 attr-82 val-83)))

(define (py-getitem-fallback obj-84 index-85)
  (letrec* ((__getitem__-1407
             (getattribute-from-obj-mro obj-84 (&& "__getitem__"))))
    (if (py-test (py-is __getitem__-1407 py-absent))
        (py-throw
         (py-call py-builtin-TypeError (&& "object is not subscriptable")))
        (py-call __getitem__-1407 obj-84 index-85))))

(define (py-setitem-fallback obj-86 index-87 value-88)
  (letrec* ((__setitem__-1414
             (getattribute-from-obj-mro obj-86 (&& "__setitem__"))))
    (if (py-test (py-is __setitem__-1414 py-absent))
        (py-throw
         (py-call py-builtin-TypeError
                  (&& "object does not support item assignment")))
        (py-call __setitem__-1414 obj-86 index-87 value-88))))

(define (py-delitem-fallback obj-89 index-90)
  (letrec* ((__delitem__-1422
             (getattribute-from-obj-mro obj-89 (&& "__delitem__"))))
    (if (py-test (py-is __delitem__-1422 py-absent))
        (py-throw
         (py-call py-builtin-TypeError
                  (&& "object does not support item deletion")))
        (py-call __delitem__-1422 obj-89 index-90))))

(define (py-enter-fallback obj-91)
  (letrec* ((__enter__-1429
             (getattribute-from-obj-mro obj-91 (&& "__enter__"))))
    (if (py-test (py-is __enter__-1429 py-absent))
        (py-throw (py-call py-builtin-AttributeError (&& "__enter__")))
        (py-call __enter__-1429 obj-91))))

(define (py-exit-fallback obj-92 exc-93)
  (letrec* ((__exit__-1435 (getattribute-from-obj-mro obj-92 (&& "__exit__"))))
    (if (py-test (py-is __exit__-1435 py-absent))
        (py-throw (py-call py-builtin-AttributeError (&& "__exit__")))
        (if (py-test (py-is exc-93 py-None))
            (py-call __exit__-1435 obj-92 py-None py-None py-None)
            (letrec* ((exit_result-1442
                       (py-call __exit__-1435
                                obj-92
                                (py-call py-builtin-type exc-93)
                                exc-93
                                py-None)))
              (if (py-test exit_result-1442) py-None (py-throw exc-93)))))))

