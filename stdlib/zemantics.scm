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
  (letrec* ((magic_method-152 (getattribute-from-obj-mro x-2 (&& "__add__"))))
    (if (py-test (py-is magic_method-152 py-absent))
        (py-add-fallback:reflected x-2 y-3)
        (letrec* ((result-158 (py-call magic_method-152 x-2 y-3)))
          (if (py-test (py-is result-158 py-NotImplemented))
              (py-add-fallback:reflected x-2 y-3)
              result-158)))))

(define (py-add-fallback:reflected x-2 y-3)
  (letrec* ((magic_method-142 (getattribute-from-obj-mro y-3 (&& "__radd__"))))
    (if (py-test (py-is magic_method-142 py-absent))
        (py-add-fallback:err x-2 y-3)
        (letrec* ((result-148 (py-call magic_method-142 y-3 x-2)))
          (if (py-test (py-is result-148 py-NotImplemented))
              (py-add-fallback:err x-2 y-3)
              result-148)))))

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
  (letrec* ((magic_method-182 (getattribute-from-obj-mro x-4 (&& "__and__"))))
    (if (py-test (py-is magic_method-182 py-absent))
        (py-bitand-fallback:reflected x-4 y-5)
        (letrec* ((result-188 (py-call magic_method-182 x-4 y-5)))
          (if (py-test (py-is result-188 py-NotImplemented))
              (py-bitand-fallback:reflected x-4 y-5)
              result-188)))))

(define (py-bitand-fallback:reflected x-4 y-5)
  (letrec* ((magic_method-172 (getattribute-from-obj-mro y-5 (&& "__rand__"))))
    (if (py-test (py-is magic_method-172 py-absent))
        (py-bitand-fallback:err x-4 y-5)
        (letrec* ((result-178 (py-call magic_method-172 y-5 x-4)))
          (if (py-test (py-is result-178 py-NotImplemented))
              (py-bitand-fallback:err x-4 y-5)
              result-178)))))

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
  (letrec* ((magic_method-212 (getattribute-from-obj-mro x-6 (&& "__or__"))))
    (if (py-test (py-is magic_method-212 py-absent))
        (py-bitor-fallback:reflected x-6 y-7)
        (letrec* ((result-218 (py-call magic_method-212 x-6 y-7)))
          (if (py-test (py-is result-218 py-NotImplemented))
              (py-bitor-fallback:reflected x-6 y-7)
              result-218)))))

(define (py-bitor-fallback:reflected x-6 y-7)
  (letrec* ((magic_method-202 (getattribute-from-obj-mro y-7 (&& "__ror__"))))
    (if (py-test (py-is magic_method-202 py-absent))
        (py-bitor-fallback:err x-6 y-7)
        (letrec* ((result-208 (py-call magic_method-202 y-7 x-6)))
          (if (py-test (py-is result-208 py-NotImplemented))
              (py-bitor-fallback:err x-6 y-7)
              result-208)))))

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
  (letrec* ((magic_method-242
             (getattribute-from-obj-mro x-8 (&& "__floordiv__"))))
    (if (py-test (py-is magic_method-242 py-absent))
        (py-floordiv-fallback:reflected x-8 y-9)
        (letrec* ((result-248 (py-call magic_method-242 x-8 y-9)))
          (if (py-test (py-is result-248 py-NotImplemented))
              (py-floordiv-fallback:reflected x-8 y-9)
              result-248)))))

(define (py-floordiv-fallback:reflected x-8 y-9)
  (letrec* ((magic_method-232
             (getattribute-from-obj-mro y-9 (&& "__rfloordiv__"))))
    (if (py-test (py-is magic_method-232 py-absent))
        (py-floordiv-fallback:err x-8 y-9)
        (letrec* ((result-238 (py-call magic_method-232 y-9 x-8)))
          (if (py-test (py-is result-238 py-NotImplemented))
              (py-floordiv-fallback:err x-8 y-9)
              result-238)))))

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
  (letrec* ((magic_method-272
             (getattribute-from-obj-mro x-10 (&& "__lshift__"))))
    (if (py-test (py-is magic_method-272 py-absent))
        (py-lshift-fallback:reflected x-10 y-11)
        (letrec* ((result-278 (py-call magic_method-272 x-10 y-11)))
          (if (py-test (py-is result-278 py-NotImplemented))
              (py-lshift-fallback:reflected x-10 y-11)
              result-278)))))

(define (py-lshift-fallback:reflected x-10 y-11)
  (letrec* ((magic_method-262
             (getattribute-from-obj-mro y-11 (&& "__rlshift__"))))
    (if (py-test (py-is magic_method-262 py-absent))
        (py-lshift-fallback:err x-10 y-11)
        (letrec* ((result-268 (py-call magic_method-262 y-11 x-10)))
          (if (py-test (py-is result-268 py-NotImplemented))
              (py-lshift-fallback:err x-10 y-11)
              result-268)))))

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
  (letrec* ((magic_method-302
             (getattribute-from-obj-mro x-12 (&& "__matmul__"))))
    (if (py-test (py-is magic_method-302 py-absent))
        (py-matmul-fallback:reflected x-12 y-13)
        (letrec* ((result-308 (py-call magic_method-302 x-12 y-13)))
          (if (py-test (py-is result-308 py-NotImplemented))
              (py-matmul-fallback:reflected x-12 y-13)
              result-308)))))

(define (py-matmul-fallback:reflected x-12 y-13)
  (letrec* ((magic_method-292
             (getattribute-from-obj-mro y-13 (&& "__rmatmul__"))))
    (if (py-test (py-is magic_method-292 py-absent))
        (py-matmul-fallback:err x-12 y-13)
        (letrec* ((result-298 (py-call magic_method-292 y-13 x-12)))
          (if (py-test (py-is result-298 py-NotImplemented))
              (py-matmul-fallback:err x-12 y-13)
              result-298)))))

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
  (letrec* ((magic_method-332 (getattribute-from-obj-mro x-14 (&& "__mod__"))))
    (if (py-test (py-is magic_method-332 py-absent))
        (py-mod-fallback:reflected x-14 y-15)
        (letrec* ((result-338 (py-call magic_method-332 x-14 y-15)))
          (if (py-test (py-is result-338 py-NotImplemented))
              (py-mod-fallback:reflected x-14 y-15)
              result-338)))))

(define (py-mod-fallback:reflected x-14 y-15)
  (letrec* ((magic_method-322
             (getattribute-from-obj-mro y-15 (&& "__rmod__"))))
    (if (py-test (py-is magic_method-322 py-absent))
        (py-mod-fallback:err x-14 y-15)
        (letrec* ((result-328 (py-call magic_method-322 y-15 x-14)))
          (if (py-test (py-is result-328 py-NotImplemented))
              (py-mod-fallback:err x-14 y-15)
              result-328)))))

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
  (letrec* ((magic_method-362 (getattribute-from-obj-mro x-16 (&& "__mul__"))))
    (if (py-test (py-is magic_method-362 py-absent))
        (py-mul-fallback:reflected x-16 y-17)
        (letrec* ((result-368 (py-call magic_method-362 x-16 y-17)))
          (if (py-test (py-is result-368 py-NotImplemented))
              (py-mul-fallback:reflected x-16 y-17)
              result-368)))))

(define (py-mul-fallback:reflected x-16 y-17)
  (letrec* ((magic_method-352
             (getattribute-from-obj-mro y-17 (&& "__rmul__"))))
    (if (py-test (py-is magic_method-352 py-absent))
        (py-mul-fallback:err x-16 y-17)
        (letrec* ((result-358 (py-call magic_method-352 y-17 x-16)))
          (if (py-test (py-is result-358 py-NotImplemented))
              (py-mul-fallback:err x-16 y-17)
              result-358)))))

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
  (letrec* ((magic_method-392 (getattribute-from-obj-mro x-18 (&& "__pow__"))))
    (if (py-test (py-is magic_method-392 py-absent))
        (py-pow-fallback:reflected x-18 y-19)
        (letrec* ((result-398 (py-call magic_method-392 x-18 y-19)))
          (if (py-test (py-is result-398 py-NotImplemented))
              (py-pow-fallback:reflected x-18 y-19)
              result-398)))))

(define (py-pow-fallback:reflected x-18 y-19)
  (letrec* ((magic_method-382
             (getattribute-from-obj-mro y-19 (&& "__rpow__"))))
    (if (py-test (py-is magic_method-382 py-absent))
        (py-pow-fallback:err x-18 y-19)
        (letrec* ((result-388 (py-call magic_method-382 y-19 x-18)))
          (if (py-test (py-is result-388 py-NotImplemented))
              (py-pow-fallback:err x-18 y-19)
              result-388)))))

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
  (letrec* ((magic_method-422
             (getattribute-from-obj-mro x-20 (&& "__rshift__"))))
    (if (py-test (py-is magic_method-422 py-absent))
        (py-rshift-fallback:reflected x-20 y-21)
        (letrec* ((result-428 (py-call magic_method-422 x-20 y-21)))
          (if (py-test (py-is result-428 py-NotImplemented))
              (py-rshift-fallback:reflected x-20 y-21)
              result-428)))))

(define (py-rshift-fallback:reflected x-20 y-21)
  (letrec* ((magic_method-412
             (getattribute-from-obj-mro y-21 (&& "__rrshift__"))))
    (if (py-test (py-is magic_method-412 py-absent))
        (py-rshift-fallback:err x-20 y-21)
        (letrec* ((result-418 (py-call magic_method-412 y-21 x-20)))
          (if (py-test (py-is result-418 py-NotImplemented))
              (py-rshift-fallback:err x-20 y-21)
              result-418)))))

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
  (letrec* ((magic_method-452 (getattribute-from-obj-mro x-22 (&& "__sub__"))))
    (if (py-test (py-is magic_method-452 py-absent))
        (py-sub-fallback:reflected x-22 y-23)
        (letrec* ((result-458 (py-call magic_method-452 x-22 y-23)))
          (if (py-test (py-is result-458 py-NotImplemented))
              (py-sub-fallback:reflected x-22 y-23)
              result-458)))))

(define (py-sub-fallback:reflected x-22 y-23)
  (letrec* ((magic_method-442
             (getattribute-from-obj-mro y-23 (&& "__rsub__"))))
    (if (py-test (py-is magic_method-442 py-absent))
        (py-sub-fallback:err x-22 y-23)
        (letrec* ((result-448 (py-call magic_method-442 y-23 x-22)))
          (if (py-test (py-is result-448 py-NotImplemented))
              (py-sub-fallback:err x-22 y-23)
              result-448)))))

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
  (letrec* ((magic_method-482
             (getattribute-from-obj-mro x-24 (&& "__truediv__"))))
    (if (py-test (py-is magic_method-482 py-absent))
        (py-truediv-fallback:reflected x-24 y-25)
        (letrec* ((result-488 (py-call magic_method-482 x-24 y-25)))
          (if (py-test (py-is result-488 py-NotImplemented))
              (py-truediv-fallback:reflected x-24 y-25)
              result-488)))))

(define (py-truediv-fallback:reflected x-24 y-25)
  (letrec* ((magic_method-472
             (getattribute-from-obj-mro y-25 (&& "__rtruediv__"))))
    (if (py-test (py-is magic_method-472 py-absent))
        (py-truediv-fallback:err x-24 y-25)
        (letrec* ((result-478 (py-call magic_method-472 y-25 x-24)))
          (if (py-test (py-is result-478 py-NotImplemented))
              (py-truediv-fallback:err x-24 y-25)
              result-478)))))

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
  (letrec* ((magic_method-512 (getattribute-from-obj-mro x-26 (&& "__xor__"))))
    (if (py-test (py-is magic_method-512 py-absent))
        (py-xor-fallback:reflected x-26 y-27)
        (letrec* ((result-518 (py-call magic_method-512 x-26 y-27)))
          (if (py-test (py-is result-518 py-NotImplemented))
              (py-xor-fallback:reflected x-26 y-27)
              result-518)))))

(define (py-xor-fallback:reflected x-26 y-27)
  (letrec* ((magic_method-502
             (getattribute-from-obj-mro y-27 (&& "__rxor__"))))
    (if (py-test (py-is magic_method-502 py-absent))
        (py-xor-fallback:err x-26 y-27)
        (letrec* ((result-508 (py-call magic_method-502 y-27 x-26)))
          (if (py-test (py-is result-508 py-NotImplemented))
              (py-xor-fallback:err x-26 y-27)
              result-508)))))

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
  (letrec* ((magic_method-554
             (getattribute-from-obj-mro x-28 (&& "__iadd__"))))
    (if (py-test (py-is magic_method-554 py-absent))
        (py-iadd-fallback:normal x-28 y-29)
        (letrec* ((result-560 (py-call magic_method-554 x-28 y-29)))
          (if (py-test (py-is result-560 py-NotImplemented))
              (py-iadd-fallback:normal x-28 y-29)
              result-560)))))

(define (py-iadd-fallback:normal x-28 y-29)
  (letrec* ((magic_method-544 (getattribute-from-obj-mro x-28 (&& "__add__"))))
    (if (py-test (py-is magic_method-544 py-absent))
        (py-iadd-fallback:reflected x-28 y-29)
        (letrec* ((result-550 (py-call magic_method-544 x-28 y-29)))
          (if (py-test (py-is result-550 py-NotImplemented))
              (py-iadd-fallback:reflected x-28 y-29)
              result-550)))))

(define (py-iadd-fallback:reflected x-28 y-29)
  (letrec* ((magic_method-534
             (getattribute-from-obj-mro y-29 (&& "__radd__"))))
    (if (py-test (py-is magic_method-534 py-absent))
        (py-iadd-fallback:err x-28 y-29)
        (letrec* ((result-540 (py-call magic_method-534 y-29 x-28)))
          (if (py-test (py-is result-540 py-NotImplemented))
              (py-iadd-fallback:err x-28 y-29)
              result-540)))))

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
  (letrec* ((magic_method-596
             (getattribute-from-obj-mro x-30 (&& "__iand__"))))
    (if (py-test (py-is magic_method-596 py-absent))
        (py-ibitand-fallback:normal x-30 y-31)
        (letrec* ((result-602 (py-call magic_method-596 x-30 y-31)))
          (if (py-test (py-is result-602 py-NotImplemented))
              (py-ibitand-fallback:normal x-30 y-31)
              result-602)))))

(define (py-ibitand-fallback:normal x-30 y-31)
  (letrec* ((magic_method-586 (getattribute-from-obj-mro x-30 (&& "__and__"))))
    (if (py-test (py-is magic_method-586 py-absent))
        (py-ibitand-fallback:reflected x-30 y-31)
        (letrec* ((result-592 (py-call magic_method-586 x-30 y-31)))
          (if (py-test (py-is result-592 py-NotImplemented))
              (py-ibitand-fallback:reflected x-30 y-31)
              result-592)))))

(define (py-ibitand-fallback:reflected x-30 y-31)
  (letrec* ((magic_method-576
             (getattribute-from-obj-mro y-31 (&& "__rand__"))))
    (if (py-test (py-is magic_method-576 py-absent))
        (py-ibitand-fallback:err x-30 y-31)
        (letrec* ((result-582 (py-call magic_method-576 y-31 x-30)))
          (if (py-test (py-is result-582 py-NotImplemented))
              (py-ibitand-fallback:err x-30 y-31)
              result-582)))))

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
  (letrec* ((magic_method-638 (getattribute-from-obj-mro x-32 (&& "__ior__"))))
    (if (py-test (py-is magic_method-638 py-absent))
        (py-ibitor-fallback:normal x-32 y-33)
        (letrec* ((result-644 (py-call magic_method-638 x-32 y-33)))
          (if (py-test (py-is result-644 py-NotImplemented))
              (py-ibitor-fallback:normal x-32 y-33)
              result-644)))))

(define (py-ibitor-fallback:normal x-32 y-33)
  (letrec* ((magic_method-628 (getattribute-from-obj-mro x-32 (&& "__or__"))))
    (if (py-test (py-is magic_method-628 py-absent))
        (py-ibitor-fallback:reflected x-32 y-33)
        (letrec* ((result-634 (py-call magic_method-628 x-32 y-33)))
          (if (py-test (py-is result-634 py-NotImplemented))
              (py-ibitor-fallback:reflected x-32 y-33)
              result-634)))))

(define (py-ibitor-fallback:reflected x-32 y-33)
  (letrec* ((magic_method-618 (getattribute-from-obj-mro y-33 (&& "__ror__"))))
    (if (py-test (py-is magic_method-618 py-absent))
        (py-ibitor-fallback:err x-32 y-33)
        (letrec* ((result-624 (py-call magic_method-618 y-33 x-32)))
          (if (py-test (py-is result-624 py-NotImplemented))
              (py-ibitor-fallback:err x-32 y-33)
              result-624)))))

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
  (letrec* ((magic_method-680
             (getattribute-from-obj-mro x-34 (&& "__ifloordiv__"))))
    (if (py-test (py-is magic_method-680 py-absent))
        (py-ifloordiv-fallback:normal x-34 y-35)
        (letrec* ((result-686 (py-call magic_method-680 x-34 y-35)))
          (if (py-test (py-is result-686 py-NotImplemented))
              (py-ifloordiv-fallback:normal x-34 y-35)
              result-686)))))

(define (py-ifloordiv-fallback:normal x-34 y-35)
  (letrec* ((magic_method-670
             (getattribute-from-obj-mro x-34 (&& "__floordiv__"))))
    (if (py-test (py-is magic_method-670 py-absent))
        (py-ifloordiv-fallback:reflected x-34 y-35)
        (letrec* ((result-676 (py-call magic_method-670 x-34 y-35)))
          (if (py-test (py-is result-676 py-NotImplemented))
              (py-ifloordiv-fallback:reflected x-34 y-35)
              result-676)))))

(define (py-ifloordiv-fallback:reflected x-34 y-35)
  (letrec* ((magic_method-660
             (getattribute-from-obj-mro y-35 (&& "__rfloordiv__"))))
    (if (py-test (py-is magic_method-660 py-absent))
        (py-ifloordiv-fallback:err x-34 y-35)
        (letrec* ((result-666 (py-call magic_method-660 y-35 x-34)))
          (if (py-test (py-is result-666 py-NotImplemented))
              (py-ifloordiv-fallback:err x-34 y-35)
              result-666)))))

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
  (letrec* ((magic_method-722
             (getattribute-from-obj-mro x-36 (&& "__ilshift__"))))
    (if (py-test (py-is magic_method-722 py-absent))
        (py-ilshift-fallback:normal x-36 y-37)
        (letrec* ((result-728 (py-call magic_method-722 x-36 y-37)))
          (if (py-test (py-is result-728 py-NotImplemented))
              (py-ilshift-fallback:normal x-36 y-37)
              result-728)))))

(define (py-ilshift-fallback:normal x-36 y-37)
  (letrec* ((magic_method-712
             (getattribute-from-obj-mro x-36 (&& "__lshift__"))))
    (if (py-test (py-is magic_method-712 py-absent))
        (py-ilshift-fallback:reflected x-36 y-37)
        (letrec* ((result-718 (py-call magic_method-712 x-36 y-37)))
          (if (py-test (py-is result-718 py-NotImplemented))
              (py-ilshift-fallback:reflected x-36 y-37)
              result-718)))))

(define (py-ilshift-fallback:reflected x-36 y-37)
  (letrec* ((magic_method-702
             (getattribute-from-obj-mro y-37 (&& "__rlshift__"))))
    (if (py-test (py-is magic_method-702 py-absent))
        (py-ilshift-fallback:err x-36 y-37)
        (letrec* ((result-708 (py-call magic_method-702 y-37 x-36)))
          (if (py-test (py-is result-708 py-NotImplemented))
              (py-ilshift-fallback:err x-36 y-37)
              result-708)))))

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
  (letrec* ((magic_method-764
             (getattribute-from-obj-mro x-38 (&& "__imatmul__"))))
    (if (py-test (py-is magic_method-764 py-absent))
        (py-imatmul-fallback:normal x-38 y-39)
        (letrec* ((result-770 (py-call magic_method-764 x-38 y-39)))
          (if (py-test (py-is result-770 py-NotImplemented))
              (py-imatmul-fallback:normal x-38 y-39)
              result-770)))))

(define (py-imatmul-fallback:normal x-38 y-39)
  (letrec* ((magic_method-754
             (getattribute-from-obj-mro x-38 (&& "__matmul__"))))
    (if (py-test (py-is magic_method-754 py-absent))
        (py-imatmul-fallback:reflected x-38 y-39)
        (letrec* ((result-760 (py-call magic_method-754 x-38 y-39)))
          (if (py-test (py-is result-760 py-NotImplemented))
              (py-imatmul-fallback:reflected x-38 y-39)
              result-760)))))

(define (py-imatmul-fallback:reflected x-38 y-39)
  (letrec* ((magic_method-744
             (getattribute-from-obj-mro y-39 (&& "__rmatmul__"))))
    (if (py-test (py-is magic_method-744 py-absent))
        (py-imatmul-fallback:err x-38 y-39)
        (letrec* ((result-750 (py-call magic_method-744 y-39 x-38)))
          (if (py-test (py-is result-750 py-NotImplemented))
              (py-imatmul-fallback:err x-38 y-39)
              result-750)))))

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
  (letrec* ((magic_method-806
             (getattribute-from-obj-mro x-40 (&& "__imod__"))))
    (if (py-test (py-is magic_method-806 py-absent))
        (py-imod-fallback:normal x-40 y-41)
        (letrec* ((result-812 (py-call magic_method-806 x-40 y-41)))
          (if (py-test (py-is result-812 py-NotImplemented))
              (py-imod-fallback:normal x-40 y-41)
              result-812)))))

(define (py-imod-fallback:normal x-40 y-41)
  (letrec* ((magic_method-796 (getattribute-from-obj-mro x-40 (&& "__mod__"))))
    (if (py-test (py-is magic_method-796 py-absent))
        (py-imod-fallback:reflected x-40 y-41)
        (letrec* ((result-802 (py-call magic_method-796 x-40 y-41)))
          (if (py-test (py-is result-802 py-NotImplemented))
              (py-imod-fallback:reflected x-40 y-41)
              result-802)))))

(define (py-imod-fallback:reflected x-40 y-41)
  (letrec* ((magic_method-786
             (getattribute-from-obj-mro y-41 (&& "__rmod__"))))
    (if (py-test (py-is magic_method-786 py-absent))
        (py-imod-fallback:err x-40 y-41)
        (letrec* ((result-792 (py-call magic_method-786 y-41 x-40)))
          (if (py-test (py-is result-792 py-NotImplemented))
              (py-imod-fallback:err x-40 y-41)
              result-792)))))

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
  (letrec* ((magic_method-848
             (getattribute-from-obj-mro x-42 (&& "__imul__"))))
    (if (py-test (py-is magic_method-848 py-absent))
        (py-imul-fallback:normal x-42 y-43)
        (letrec* ((result-854 (py-call magic_method-848 x-42 y-43)))
          (if (py-test (py-is result-854 py-NotImplemented))
              (py-imul-fallback:normal x-42 y-43)
              result-854)))))

(define (py-imul-fallback:normal x-42 y-43)
  (letrec* ((magic_method-838 (getattribute-from-obj-mro x-42 (&& "__mul__"))))
    (if (py-test (py-is magic_method-838 py-absent))
        (py-imul-fallback:reflected x-42 y-43)
        (letrec* ((result-844 (py-call magic_method-838 x-42 y-43)))
          (if (py-test (py-is result-844 py-NotImplemented))
              (py-imul-fallback:reflected x-42 y-43)
              result-844)))))

(define (py-imul-fallback:reflected x-42 y-43)
  (letrec* ((magic_method-828
             (getattribute-from-obj-mro y-43 (&& "__rmul__"))))
    (if (py-test (py-is magic_method-828 py-absent))
        (py-imul-fallback:err x-42 y-43)
        (letrec* ((result-834 (py-call magic_method-828 y-43 x-42)))
          (if (py-test (py-is result-834 py-NotImplemented))
              (py-imul-fallback:err x-42 y-43)
              result-834)))))

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
  (letrec* ((magic_method-890
             (getattribute-from-obj-mro x-44 (&& "__ipow__"))))
    (if (py-test (py-is magic_method-890 py-absent))
        (py-ipow-fallback:normal x-44 y-45)
        (letrec* ((result-896 (py-call magic_method-890 x-44 y-45)))
          (if (py-test (py-is result-896 py-NotImplemented))
              (py-ipow-fallback:normal x-44 y-45)
              result-896)))))

(define (py-ipow-fallback:normal x-44 y-45)
  (letrec* ((magic_method-880 (getattribute-from-obj-mro x-44 (&& "__pow__"))))
    (if (py-test (py-is magic_method-880 py-absent))
        (py-ipow-fallback:reflected x-44 y-45)
        (letrec* ((result-886 (py-call magic_method-880 x-44 y-45)))
          (if (py-test (py-is result-886 py-NotImplemented))
              (py-ipow-fallback:reflected x-44 y-45)
              result-886)))))

(define (py-ipow-fallback:reflected x-44 y-45)
  (letrec* ((magic_method-870
             (getattribute-from-obj-mro y-45 (&& "__rpow__"))))
    (if (py-test (py-is magic_method-870 py-absent))
        (py-ipow-fallback:err x-44 y-45)
        (letrec* ((result-876 (py-call magic_method-870 y-45 x-44)))
          (if (py-test (py-is result-876 py-NotImplemented))
              (py-ipow-fallback:err x-44 y-45)
              result-876)))))

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
  (letrec* ((magic_method-932
             (getattribute-from-obj-mro x-46 (&& "__irshift__"))))
    (if (py-test (py-is magic_method-932 py-absent))
        (py-irshift-fallback:normal x-46 y-47)
        (letrec* ((result-938 (py-call magic_method-932 x-46 y-47)))
          (if (py-test (py-is result-938 py-NotImplemented))
              (py-irshift-fallback:normal x-46 y-47)
              result-938)))))

(define (py-irshift-fallback:normal x-46 y-47)
  (letrec* ((magic_method-922
             (getattribute-from-obj-mro x-46 (&& "__rshift__"))))
    (if (py-test (py-is magic_method-922 py-absent))
        (py-irshift-fallback:reflected x-46 y-47)
        (letrec* ((result-928 (py-call magic_method-922 x-46 y-47)))
          (if (py-test (py-is result-928 py-NotImplemented))
              (py-irshift-fallback:reflected x-46 y-47)
              result-928)))))

(define (py-irshift-fallback:reflected x-46 y-47)
  (letrec* ((magic_method-912
             (getattribute-from-obj-mro y-47 (&& "__rrshift__"))))
    (if (py-test (py-is magic_method-912 py-absent))
        (py-irshift-fallback:err x-46 y-47)
        (letrec* ((result-918 (py-call magic_method-912 y-47 x-46)))
          (if (py-test (py-is result-918 py-NotImplemented))
              (py-irshift-fallback:err x-46 y-47)
              result-918)))))

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
  (letrec* ((magic_method-974
             (getattribute-from-obj-mro x-48 (&& "__isub__"))))
    (if (py-test (py-is magic_method-974 py-absent))
        (py-isub-fallback:normal x-48 y-49)
        (letrec* ((result-980 (py-call magic_method-974 x-48 y-49)))
          (if (py-test (py-is result-980 py-NotImplemented))
              (py-isub-fallback:normal x-48 y-49)
              result-980)))))

(define (py-isub-fallback:normal x-48 y-49)
  (letrec* ((magic_method-964 (getattribute-from-obj-mro x-48 (&& "__sub__"))))
    (if (py-test (py-is magic_method-964 py-absent))
        (py-isub-fallback:reflected x-48 y-49)
        (letrec* ((result-970 (py-call magic_method-964 x-48 y-49)))
          (if (py-test (py-is result-970 py-NotImplemented))
              (py-isub-fallback:reflected x-48 y-49)
              result-970)))))

(define (py-isub-fallback:reflected x-48 y-49)
  (letrec* ((magic_method-954
             (getattribute-from-obj-mro y-49 (&& "__rsub__"))))
    (if (py-test (py-is magic_method-954 py-absent))
        (py-isub-fallback:err x-48 y-49)
        (letrec* ((result-960 (py-call magic_method-954 y-49 x-48)))
          (if (py-test (py-is result-960 py-NotImplemented))
              (py-isub-fallback:err x-48 y-49)
              result-960)))))

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
  (letrec* ((magic_method-1016
             (getattribute-from-obj-mro x-50 (&& "__itruediv__"))))
    (if (py-test (py-is magic_method-1016 py-absent))
        (py-itruediv-fallback:normal x-50 y-51)
        (letrec* ((result-1022 (py-call magic_method-1016 x-50 y-51)))
          (if (py-test (py-is result-1022 py-NotImplemented))
              (py-itruediv-fallback:normal x-50 y-51)
              result-1022)))))

(define (py-itruediv-fallback:normal x-50 y-51)
  (letrec* ((magic_method-1006
             (getattribute-from-obj-mro x-50 (&& "__truediv__"))))
    (if (py-test (py-is magic_method-1006 py-absent))
        (py-itruediv-fallback:reflected x-50 y-51)
        (letrec* ((result-1012 (py-call magic_method-1006 x-50 y-51)))
          (if (py-test (py-is result-1012 py-NotImplemented))
              (py-itruediv-fallback:reflected x-50 y-51)
              result-1012)))))

(define (py-itruediv-fallback:reflected x-50 y-51)
  (letrec* ((magic_method-996
             (getattribute-from-obj-mro y-51 (&& "__rtruediv__"))))
    (if (py-test (py-is magic_method-996 py-absent))
        (py-itruediv-fallback:err x-50 y-51)
        (letrec* ((result-1002 (py-call magic_method-996 y-51 x-50)))
          (if (py-test (py-is result-1002 py-NotImplemented))
              (py-itruediv-fallback:err x-50 y-51)
              result-1002)))))

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
  (letrec* ((magic_method-1058
             (getattribute-from-obj-mro x-52 (&& "__ixor__"))))
    (if (py-test (py-is magic_method-1058 py-absent))
        (py-ixor-fallback:normal x-52 y-53)
        (letrec* ((result-1064 (py-call magic_method-1058 x-52 y-53)))
          (if (py-test (py-is result-1064 py-NotImplemented))
              (py-ixor-fallback:normal x-52 y-53)
              result-1064)))))

(define (py-ixor-fallback:normal x-52 y-53)
  (letrec* ((magic_method-1048
             (getattribute-from-obj-mro x-52 (&& "__xor__"))))
    (if (py-test (py-is magic_method-1048 py-absent))
        (py-ixor-fallback:reflected x-52 y-53)
        (letrec* ((result-1054 (py-call magic_method-1048 x-52 y-53)))
          (if (py-test (py-is result-1054 py-NotImplemented))
              (py-ixor-fallback:reflected x-52 y-53)
              result-1054)))))

(define (py-ixor-fallback:reflected x-52 y-53)
  (letrec* ((magic_method-1038
             (getattribute-from-obj-mro y-53 (&& "__rxor__"))))
    (if (py-test (py-is magic_method-1038 py-absent))
        (py-ixor-fallback:err x-52 y-53)
        (letrec* ((result-1044 (py-call magic_method-1038 y-53 x-52)))
          (if (py-test (py-is result-1044 py-NotImplemented))
              (py-ixor-fallback:err x-52 y-53)
              result-1044)))))

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
  (letrec* ((magic_method-1075
             (getattribute-from-obj-mro x-54 (&& "__pos__"))))
    (if (py-test (py-is magic_method-1075 py-absent))
        (py-pos-fallback:err x-54)
        (py-call magic_method-1075 x-54))))

(define (py-pos-fallback:err x-54)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (&& "bad operand type for unary +: '")
                            (py-getattribute
                             (py-call py-builtin-type x-54)
                             (& "__name__")))
                    (&& "'")))))

(define (py-neg-fallback:normal x-55)
  (letrec* ((magic_method-1088
             (getattribute-from-obj-mro x-55 (&& "__neg__"))))
    (if (py-test (py-is magic_method-1088 py-absent))
        (py-neg-fallback:err x-55)
        (py-call magic_method-1088 x-55))))

(define (py-neg-fallback:err x-55)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (&& "bad operand type for unary -: '")
                            (py-getattribute
                             (py-call py-builtin-type x-55)
                             (& "__name__")))
                    (&& "'")))))

(define (py-invert-fallback:normal x-56)
  (letrec* ((magic_method-1101
             (getattribute-from-obj-mro x-56 (&& "__invert__"))))
    (if (py-test (py-is magic_method-1101 py-absent))
        (py-invert-fallback:err x-56)
        (py-call magic_method-1101 x-56))))

(define (py-invert-fallback:err x-56)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (&& "bad operand type for unary ~: '")
                            (py-getattribute
                             (py-call py-builtin-type x-56)
                             (& "__name__")))
                    (&& "'")))))

(define (py-ge-fallback:normal x-57 y-58)
  (letrec* ((magic_method-1127 (getattribute-from-obj-mro x-57 (&& "__ge__"))))
    (if (py-test (py-is magic_method-1127 py-absent))
        (py-ge-fallback:reflected x-57 y-58)
        (letrec* ((result-1133 (py-call magic_method-1127 x-57 y-58)))
          (if (py-test (py-is result-1133 py-NotImplemented))
              (py-ge-fallback:reflected x-57 y-58)
              result-1133)))))

(define (py-ge-fallback:reflected x-57 y-58)
  (letrec* ((magic_method-1117 (getattribute-from-obj-mro y-58 (&& "__le__"))))
    (if (py-test (py-is magic_method-1117 py-absent))
        (py-ge-fallback:err x-57 y-58)
        (letrec* ((result-1123 (py-call magic_method-1117 y-58 x-57)))
          (if (py-test (py-is result-1123 py-NotImplemented))
              (py-ge-fallback:err x-57 y-58)
              result-1123)))))

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
  (letrec* ((magic_method-1157 (getattribute-from-obj-mro x-59 (&& "__gt__"))))
    (if (py-test (py-is magic_method-1157 py-absent))
        (py-gt-fallback:reflected x-59 y-60)
        (letrec* ((result-1163 (py-call magic_method-1157 x-59 y-60)))
          (if (py-test (py-is result-1163 py-NotImplemented))
              (py-gt-fallback:reflected x-59 y-60)
              result-1163)))))

(define (py-gt-fallback:reflected x-59 y-60)
  (letrec* ((magic_method-1147 (getattribute-from-obj-mro y-60 (&& "__lt__"))))
    (if (py-test (py-is magic_method-1147 py-absent))
        (py-gt-fallback:err x-59 y-60)
        (letrec* ((result-1153 (py-call magic_method-1147 y-60 x-59)))
          (if (py-test (py-is result-1153 py-NotImplemented))
              (py-gt-fallback:err x-59 y-60)
              result-1153)))))

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
  (letrec* ((magic_method-1187 (getattribute-from-obj-mro x-61 (&& "__le__"))))
    (if (py-test (py-is magic_method-1187 py-absent))
        (py-le-fallback:reflected x-61 y-62)
        (letrec* ((result-1193 (py-call magic_method-1187 x-61 y-62)))
          (if (py-test (py-is result-1193 py-NotImplemented))
              (py-le-fallback:reflected x-61 y-62)
              result-1193)))))

(define (py-le-fallback:reflected x-61 y-62)
  (letrec* ((magic_method-1177 (getattribute-from-obj-mro y-62 (&& "__ge__"))))
    (if (py-test (py-is magic_method-1177 py-absent))
        (py-le-fallback:err x-61 y-62)
        (letrec* ((result-1183 (py-call magic_method-1177 y-62 x-61)))
          (if (py-test (py-is result-1183 py-NotImplemented))
              (py-le-fallback:err x-61 y-62)
              result-1183)))))

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
  (letrec* ((magic_method-1217 (getattribute-from-obj-mro x-63 (&& "__lt__"))))
    (if (py-test (py-is magic_method-1217 py-absent))
        (py-lt-fallback:reflected x-63 y-64)
        (letrec* ((result-1223 (py-call magic_method-1217 x-63 y-64)))
          (if (py-test (py-is result-1223 py-NotImplemented))
              (py-lt-fallback:reflected x-63 y-64)
              result-1223)))))

(define (py-lt-fallback:reflected x-63 y-64)
  (letrec* ((magic_method-1207 (getattribute-from-obj-mro y-64 (&& "__gt__"))))
    (if (py-test (py-is magic_method-1207 py-absent))
        (py-lt-fallback:err x-63 y-64)
        (letrec* ((result-1213 (py-call magic_method-1207 y-64 x-63)))
          (if (py-test (py-is result-1213 py-NotImplemented))
              (py-lt-fallback:err x-63 y-64)
              result-1213)))))

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
  (letrec* ((magic_method-1245 (getattribute-from-obj-mro x-65 (&& "__eq__"))))
    (if (py-test (py-is magic_method-1245 py-absent))
        (py-eq-fallback:reflected x-65 y-66)
        (letrec* ((result-1251 (py-call magic_method-1245 x-65 y-66)))
          (if (py-test (py-is result-1251 py-NotImplemented))
              (py-eq-fallback:reflected x-65 y-66)
              result-1251)))))

(define (py-eq-fallback:reflected x-65 y-66)
  (letrec* ((magic_method-1235 (getattribute-from-obj-mro y-66 (&& "__eq__"))))
    (if (py-test (py-is magic_method-1235 py-absent))
        (py-eq-fallback:default x-65 y-66)
        (letrec* ((result-1241 (py-call magic_method-1235 y-66 x-65)))
          (if (py-test (py-is result-1241 py-NotImplemented))
              (py-eq-fallback:default x-65 y-66)
              result-1241)))))

(define (py-eq-fallback:default x-65 y-66) (py-is x-65 y-66))

(define (py-ne-fallback:normal x-67 y-68)
  (letrec* ((magic_method-1273 (getattribute-from-obj-mro x-67 (&& "__ne__"))))
    (if (py-test (py-is magic_method-1273 py-absent))
        (py-ne-fallback:reflected x-67 y-68)
        (letrec* ((result-1279 (py-call magic_method-1273 x-67 y-68)))
          (if (py-test (py-is result-1279 py-NotImplemented))
              (py-ne-fallback:reflected x-67 y-68)
              result-1279)))))

(define (py-ne-fallback:reflected x-67 y-68)
  (letrec* ((magic_method-1263 (getattribute-from-obj-mro y-68 (&& "__ne__"))))
    (if (py-test (py-is magic_method-1263 py-absent))
        (py-ne-fallback:default x-67 y-68)
        (letrec* ((result-1269 (py-call magic_method-1263 y-68 x-67)))
          (if (py-test (py-is result-1269 py-NotImplemented))
              (py-ne-fallback:default x-67 y-68)
              result-1269)))))

(define (py-ne-fallback:default x-67 y-68) (py-isnot x-67 y-68))

(define (py-getattribute-fallback obj-69 attr-70)
  (letrec* ((__getattribute__-1283
             (getattribute-from-obj-mro obj-69 (&& "__getattribute__"))))
    (with-handler
     (lambda ($%exc_0)
       (cond ((py-isinstance? $%exc_0 py-builtin-AttributeError)
              (letrec* ((__getattr__-1289
                         (getattribute-from-obj-mro
                          obj-69
                          (&& "__getattr__"))))
                (if (py-test (py-is __getattr__-1289 py-absent))
                    (py-throw $%exc_0)
                    (py-call __getattr__-1289 obj-69 attr-70))))
             (else (raise $%exc_0))))
     (py-call __getattribute__-1283 obj-69 attr-70))))

(define (py-setattribute-fallback obj-71 attr-72 val-73)
  (letrec* ((__setattr__-1292
             (getattribute-from-obj-mro obj-71 (&& "__setattr__"))))
    (py-call __setattr__-1292 obj-71 attr-72 val-73)))

(define (py-getitem-fallback obj-74 index-75)
  (letrec* ((__getitem__-1298
             (getattribute-from-obj-mro obj-74 (&& "__getitem__"))))
    (if (py-test (py-is __getitem__-1298 py-absent))
        (py-throw
         (py-call py-builtin-TypeError (&& "object is not subscriptable")))
        (py-call __getitem__-1298 obj-74 index-75))))

(define (py-setitem-fallback obj-76 index-77 value-78)
  (letrec* ((__setitem__-1305
             (getattribute-from-obj-mro obj-76 (&& "__setitem__"))))
    (if (py-test (py-is __setitem__-1305 py-absent))
        (py-throw
         (py-call py-builtin-TypeError
                  (&& "object does not support item assignment")))
        (py-call __setitem__-1305 obj-76 index-77 value-78))))

(define (py-delitem-fallback obj-79 index-80)
  (letrec* ((__delitem__-1313
             (getattribute-from-obj-mro obj-79 (&& "__delitem__"))))
    (if (py-test (py-is __delitem__-1313 py-absent))
        (py-throw
         (py-call py-builtin-TypeError
                  (&& "object does not support item deletion")))
        (py-call __delitem__-1313 obj-79 index-80))))

(define (py-enter-fallback obj-81)
  (letrec* ((__enter__-1320
             (getattribute-from-obj-mro obj-81 (&& "__enter__"))))
    (if (py-test (py-is __enter__-1320 py-absent))
        (py-throw (py-call py-builtin-AttributeError (&& "__enter__")))
        (py-call __enter__-1320 obj-81))))

(define (py-exit-fallback obj-82 exc-83)
  (letrec* ((__exit__-1326 (getattribute-from-obj-mro obj-82 (&& "__exit__"))))
    (if (py-test (py-is __exit__-1326 py-absent))
        (py-throw (py-call py-builtin-AttributeError (&& "__exit__")))
        (if (py-test (py-is exc-83 py-None))
            (py-call __exit__-1326 obj-82 py-None py-None py-None)
            (letrec* ((exit_result-1333
                       (py-call __exit__-1326
                                obj-82
                                (py-call py-builtin-type exc-83)
                                exc-83
                                py-None)))
              (if (py-test exit_result-1333) py-None (py-throw exc-83)))))))

