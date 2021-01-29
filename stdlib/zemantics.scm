(define-macro (py-add-fallback x-2 y-3)
  `(let ((x-2 ,x-2) (y-3 ,y-3)) (py-add-fallback:normal x-2 y-3)))

(define-macro (py-bitand-fallback x-8 y-9)
  `(let ((x-8 ,x-8) (y-9 ,y-9)) (py-bitand-fallback:normal x-8 y-9)))

(define-macro (py-bitor-fallback x-14 y-15)
  `(let ((x-14 ,x-14) (y-15 ,y-15)) (py-bitor-fallback:normal x-14 y-15)))

(define-macro (py-floordiv-fallback x-20 y-21)
  `(let ((x-20 ,x-20) (y-21 ,y-21)) (py-floordiv-fallback:normal x-20 y-21)))

(define-macro (py-lshift-fallback x-26 y-27)
  `(let ((x-26 ,x-26) (y-27 ,y-27)) (py-lshift-fallback:normal x-26 y-27)))

(define-macro (py-matmul-fallback x-32 y-33)
  `(let ((x-32 ,x-32) (y-33 ,y-33)) (py-matmul-fallback:normal x-32 y-33)))

(define-macro (py-mod-fallback x-38 y-39)
  `(let ((x-38 ,x-38) (y-39 ,y-39)) (py-mod-fallback:normal x-38 y-39)))

(define-macro (py-mul-fallback x-44 y-45)
  `(let ((x-44 ,x-44) (y-45 ,y-45)) (py-mul-fallback:normal x-44 y-45)))

(define-macro (py-pow-fallback x-50 y-51)
  `(let ((x-50 ,x-50) (y-51 ,y-51)) (py-pow-fallback:normal x-50 y-51)))

(define-macro (py-rshift-fallback x-56 y-57)
  `(let ((x-56 ,x-56) (y-57 ,y-57)) (py-rshift-fallback:normal x-56 y-57)))

(define-macro (py-sub-fallback x-62 y-63)
  `(let ((x-62 ,x-62) (y-63 ,y-63)) (py-sub-fallback:normal x-62 y-63)))

(define-macro (py-truediv-fallback x-68 y-69)
  `(let ((x-68 ,x-68) (y-69 ,y-69)) (py-truediv-fallback:normal x-68 y-69)))

(define-macro (py-xor-fallback x-74 y-75)
  `(let ((x-74 ,x-74) (y-75 ,y-75)) (py-xor-fallback:normal x-74 y-75)))

(define-macro (py-iadd-fallback x-80 y-81)
  `(let ((x-80 ,x-80) (y-81 ,y-81)) (py-iadd-fallback:inplace x-80 y-81)))

(define-macro (py-ibitand-fallback x-87 y-88)
  `(let ((x-87 ,x-87) (y-88 ,y-88)) (py-ibitand-fallback:inplace x-87 y-88)))

(define-macro (py-ibitor-fallback x-94 y-95)
  `(let ((x-94 ,x-94) (y-95 ,y-95)) (py-ibitor-fallback:inplace x-94 y-95)))

(define-macro (py-ifloordiv-fallback x-101 y-102)
  `(let ((x-101 ,x-101) (y-102 ,y-102))
     (py-ifloordiv-fallback:inplace x-101 y-102)))

(define-macro (py-ilshift-fallback x-108 y-109)
  `(let ((x-108 ,x-108) (y-109 ,y-109))
     (py-ilshift-fallback:inplace x-108 y-109)))

(define-macro (py-imatmul-fallback x-115 y-116)
  `(let ((x-115 ,x-115) (y-116 ,y-116))
     (py-imatmul-fallback:inplace x-115 y-116)))

(define-macro (py-imod-fallback x-122 y-123)
  `(let ((x-122 ,x-122) (y-123 ,y-123))
     (py-imod-fallback:inplace x-122 y-123)))

(define-macro (py-imul-fallback x-129 y-130)
  `(let ((x-129 ,x-129) (y-130 ,y-130))
     (py-imul-fallback:inplace x-129 y-130)))

(define-macro (py-ipow-fallback x-136 y-137)
  `(let ((x-136 ,x-136) (y-137 ,y-137))
     (py-ipow-fallback:inplace x-136 y-137)))

(define-macro (py-irshift-fallback x-143 y-144)
  `(let ((x-143 ,x-143) (y-144 ,y-144))
     (py-irshift-fallback:inplace x-143 y-144)))

(define-macro (py-isub-fallback x-150 y-151)
  `(let ((x-150 ,x-150) (y-151 ,y-151))
     (py-isub-fallback:inplace x-150 y-151)))

(define-macro (py-itruediv-fallback x-157 y-158)
  `(let ((x-157 ,x-157) (y-158 ,y-158))
     (py-itruediv-fallback:inplace x-157 y-158)))

(define-macro (py-ixor-fallback x-164 y-165)
  `(let ((x-164 ,x-164) (y-165 ,y-165))
     (py-ixor-fallback:inplace x-164 y-165)))

(define-macro (py-pos-fallback x-171)
  `(let ((x-171 ,x-171)) (py-pos-fallback:normal x-171)))

(define-macro (py-neg-fallback x-175)
  `(let ((x-175 ,x-175)) (py-neg-fallback:normal x-175)))

(define-macro (py-invert-fallback x-179)
  `(let ((x-179 ,x-179)) (py-invert-fallback:normal x-179)))

(define-macro (py-ge-fallback x-183 y-184)
  `(let ((x-183 ,x-183) (y-184 ,y-184)) (py-ge-fallback:normal x-183 y-184)))

(define-macro (py-gt-fallback x-189 y-190)
  `(let ((x-189 ,x-189) (y-190 ,y-190)) (py-gt-fallback:normal x-189 y-190)))

(define-macro (py-le-fallback x-195 y-196)
  `(let ((x-195 ,x-195) (y-196 ,y-196)) (py-le-fallback:normal x-195 y-196)))

(define-macro (py-lt-fallback x-201 y-202)
  `(let ((x-201 ,x-201) (y-202 ,y-202)) (py-lt-fallback:normal x-201 y-202)))

(define-macro (py-eq-fallback x-207 y-208)
  `(let ((x-207 ,x-207) (y-208 ,y-208)) (py-eq-fallback:normal x-207 y-208)))

(define-macro (py-ne-fallback x-213 y-214)
  `(let ((x-213 ,x-213) (y-214 ,y-214)) (py-ne-fallback:normal x-213 y-214)))

(define (py-add-fallback:normal x-237 y-238)
  (letrec* ((magic_method-463
             (getattribute-from-obj-mro x-237 (&& "__add__"))))
    (if (py-test (py-is magic_method-463 py-absent))
        (py-add-fallback:reflected x-237 y-238)
        (letrec* ((result-464 (py-call magic_method-463 x-237 y-238)))
          (if (py-test (py-is result-464 py-NotImplemented))
              (py-add-fallback:reflected x-237 y-238)
              result-464)))))

(define (py-add-fallback:reflected x-239 y-240)
  (letrec* ((magic_method-467
             (getattribute-from-obj-mro y-240 (&& "__radd__"))))
    (if (py-test (py-is magic_method-467 py-absent))
        (py-add-fallback:err x-239 y-240)
        (letrec* ((result-468 (py-call magic_method-467 y-240 x-239)))
          (if (py-test (py-is result-468 py-NotImplemented))
              (py-add-fallback:err x-239 y-240)
              result-468)))))

(define (py-add-fallback:err x-241 y-242)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for +: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-241)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-242)
                             (& "__name__")))
                    (&& "'")))))

(define (py-bitand-fallback:normal x-243 y-244)
  (letrec* ((magic_method-471
             (getattribute-from-obj-mro x-243 (&& "__and__"))))
    (if (py-test (py-is magic_method-471 py-absent))
        (py-bitand-fallback:reflected x-243 y-244)
        (letrec* ((result-472 (py-call magic_method-471 x-243 y-244)))
          (if (py-test (py-is result-472 py-NotImplemented))
              (py-bitand-fallback:reflected x-243 y-244)
              result-472)))))

(define (py-bitand-fallback:reflected x-245 y-246)
  (letrec* ((magic_method-475
             (getattribute-from-obj-mro y-246 (&& "__rand__"))))
    (if (py-test (py-is magic_method-475 py-absent))
        (py-bitand-fallback:err x-245 y-246)
        (letrec* ((result-476 (py-call magic_method-475 y-246 x-245)))
          (if (py-test (py-is result-476 py-NotImplemented))
              (py-bitand-fallback:err x-245 y-246)
              result-476)))))

(define (py-bitand-fallback:err x-247 y-248)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for &: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-247)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-248)
                             (& "__name__")))
                    (&& "'")))))

(define (py-bitor-fallback:normal x-249 y-250)
  (letrec* ((magic_method-479 (getattribute-from-obj-mro x-249 (&& "__or__"))))
    (if (py-test (py-is magic_method-479 py-absent))
        (py-bitor-fallback:reflected x-249 y-250)
        (letrec* ((result-480 (py-call magic_method-479 x-249 y-250)))
          (if (py-test (py-is result-480 py-NotImplemented))
              (py-bitor-fallback:reflected x-249 y-250)
              result-480)))))

(define (py-bitor-fallback:reflected x-251 y-252)
  (letrec* ((magic_method-483
             (getattribute-from-obj-mro y-252 (&& "__ror__"))))
    (if (py-test (py-is magic_method-483 py-absent))
        (py-bitor-fallback:err x-251 y-252)
        (letrec* ((result-484 (py-call magic_method-483 y-252 x-251)))
          (if (py-test (py-is result-484 py-NotImplemented))
              (py-bitor-fallback:err x-251 y-252)
              result-484)))))

(define (py-bitor-fallback:err x-253 y-254)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for |: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-253)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-254)
                             (& "__name__")))
                    (&& "'")))))

(define (py-floordiv-fallback:normal x-255 y-256)
  (letrec* ((magic_method-487
             (getattribute-from-obj-mro x-255 (&& "__floordiv__"))))
    (if (py-test (py-is magic_method-487 py-absent))
        (py-floordiv-fallback:reflected x-255 y-256)
        (letrec* ((result-488 (py-call magic_method-487 x-255 y-256)))
          (if (py-test (py-is result-488 py-NotImplemented))
              (py-floordiv-fallback:reflected x-255 y-256)
              result-488)))))

(define (py-floordiv-fallback:reflected x-257 y-258)
  (letrec* ((magic_method-491
             (getattribute-from-obj-mro y-258 (&& "__rfloordiv__"))))
    (if (py-test (py-is magic_method-491 py-absent))
        (py-floordiv-fallback:err x-257 y-258)
        (letrec* ((result-492 (py-call magic_method-491 y-258 x-257)))
          (if (py-test (py-is result-492 py-NotImplemented))
              (py-floordiv-fallback:err x-257 y-258)
              result-492)))))

(define (py-floordiv-fallback:err x-259 y-260)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for //: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-259)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-260)
                             (& "__name__")))
                    (&& "'")))))

(define (py-lshift-fallback:normal x-261 y-262)
  (letrec* ((magic_method-495
             (getattribute-from-obj-mro x-261 (&& "__lshift__"))))
    (if (py-test (py-is magic_method-495 py-absent))
        (py-lshift-fallback:reflected x-261 y-262)
        (letrec* ((result-496 (py-call magic_method-495 x-261 y-262)))
          (if (py-test (py-is result-496 py-NotImplemented))
              (py-lshift-fallback:reflected x-261 y-262)
              result-496)))))

(define (py-lshift-fallback:reflected x-263 y-264)
  (letrec* ((magic_method-499
             (getattribute-from-obj-mro y-264 (&& "__rlshift__"))))
    (if (py-test (py-is magic_method-499 py-absent))
        (py-lshift-fallback:err x-263 y-264)
        (letrec* ((result-500 (py-call magic_method-499 y-264 x-263)))
          (if (py-test (py-is result-500 py-NotImplemented))
              (py-lshift-fallback:err x-263 y-264)
              result-500)))))

(define (py-lshift-fallback:err x-265 y-266)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for <<: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-265)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-266)
                             (& "__name__")))
                    (&& "'")))))

(define (py-matmul-fallback:normal x-267 y-268)
  (letrec* ((magic_method-503
             (getattribute-from-obj-mro x-267 (&& "__matmul__"))))
    (if (py-test (py-is magic_method-503 py-absent))
        (py-matmul-fallback:reflected x-267 y-268)
        (letrec* ((result-504 (py-call magic_method-503 x-267 y-268)))
          (if (py-test (py-is result-504 py-NotImplemented))
              (py-matmul-fallback:reflected x-267 y-268)
              result-504)))))

(define (py-matmul-fallback:reflected x-269 y-270)
  (letrec* ((magic_method-507
             (getattribute-from-obj-mro y-270 (&& "__rmatmul__"))))
    (if (py-test (py-is magic_method-507 py-absent))
        (py-matmul-fallback:err x-269 y-270)
        (letrec* ((result-508 (py-call magic_method-507 y-270 x-269)))
          (if (py-test (py-is result-508 py-NotImplemented))
              (py-matmul-fallback:err x-269 y-270)
              result-508)))))

(define (py-matmul-fallback:err x-271 y-272)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for @: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-271)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-272)
                             (& "__name__")))
                    (&& "'")))))

(define (py-mod-fallback:normal x-273 y-274)
  (letrec* ((magic_method-511
             (getattribute-from-obj-mro x-273 (&& "__mod__"))))
    (if (py-test (py-is magic_method-511 py-absent))
        (py-mod-fallback:reflected x-273 y-274)
        (letrec* ((result-512 (py-call magic_method-511 x-273 y-274)))
          (if (py-test (py-is result-512 py-NotImplemented))
              (py-mod-fallback:reflected x-273 y-274)
              result-512)))))

(define (py-mod-fallback:reflected x-275 y-276)
  (letrec* ((magic_method-515
             (getattribute-from-obj-mro y-276 (&& "__rmod__"))))
    (if (py-test (py-is magic_method-515 py-absent))
        (py-mod-fallback:err x-275 y-276)
        (letrec* ((result-516 (py-call magic_method-515 y-276 x-275)))
          (if (py-test (py-is result-516 py-NotImplemented))
              (py-mod-fallback:err x-275 y-276)
              result-516)))))

(define (py-mod-fallback:err x-277 y-278)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for %: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-277)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-278)
                             (& "__name__")))
                    (&& "'")))))

(define (py-mul-fallback:normal x-279 y-280)
  (letrec* ((magic_method-519
             (getattribute-from-obj-mro x-279 (&& "__mul__"))))
    (if (py-test (py-is magic_method-519 py-absent))
        (py-mul-fallback:reflected x-279 y-280)
        (letrec* ((result-520 (py-call magic_method-519 x-279 y-280)))
          (if (py-test (py-is result-520 py-NotImplemented))
              (py-mul-fallback:reflected x-279 y-280)
              result-520)))))

(define (py-mul-fallback:reflected x-281 y-282)
  (letrec* ((magic_method-523
             (getattribute-from-obj-mro y-282 (&& "__rmul__"))))
    (if (py-test (py-is magic_method-523 py-absent))
        (py-mul-fallback:err x-281 y-282)
        (letrec* ((result-524 (py-call magic_method-523 y-282 x-281)))
          (if (py-test (py-is result-524 py-NotImplemented))
              (py-mul-fallback:err x-281 y-282)
              result-524)))))

(define (py-mul-fallback:err x-283 y-284)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for *: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-283)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-284)
                             (& "__name__")))
                    (&& "'")))))

(define (py-pow-fallback:normal x-285 y-286)
  (letrec* ((magic_method-527
             (getattribute-from-obj-mro x-285 (&& "__pow__"))))
    (if (py-test (py-is magic_method-527 py-absent))
        (py-pow-fallback:reflected x-285 y-286)
        (letrec* ((result-528 (py-call magic_method-527 x-285 y-286)))
          (if (py-test (py-is result-528 py-NotImplemented))
              (py-pow-fallback:reflected x-285 y-286)
              result-528)))))

(define (py-pow-fallback:reflected x-287 y-288)
  (letrec* ((magic_method-531
             (getattribute-from-obj-mro y-288 (&& "__rpow__"))))
    (if (py-test (py-is magic_method-531 py-absent))
        (py-pow-fallback:err x-287 y-288)
        (letrec* ((result-532 (py-call magic_method-531 y-288 x-287)))
          (if (py-test (py-is result-532 py-NotImplemented))
              (py-pow-fallback:err x-287 y-288)
              result-532)))))

(define (py-pow-fallback:err x-289 y-290)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for **: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-289)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-290)
                             (& "__name__")))
                    (&& "'")))))

(define (py-rshift-fallback:normal x-291 y-292)
  (letrec* ((magic_method-535
             (getattribute-from-obj-mro x-291 (&& "__rshift__"))))
    (if (py-test (py-is magic_method-535 py-absent))
        (py-rshift-fallback:reflected x-291 y-292)
        (letrec* ((result-536 (py-call magic_method-535 x-291 y-292)))
          (if (py-test (py-is result-536 py-NotImplemented))
              (py-rshift-fallback:reflected x-291 y-292)
              result-536)))))

(define (py-rshift-fallback:reflected x-293 y-294)
  (letrec* ((magic_method-539
             (getattribute-from-obj-mro y-294 (&& "__rrshift__"))))
    (if (py-test (py-is magic_method-539 py-absent))
        (py-rshift-fallback:err x-293 y-294)
        (letrec* ((result-540 (py-call magic_method-539 y-294 x-293)))
          (if (py-test (py-is result-540 py-NotImplemented))
              (py-rshift-fallback:err x-293 y-294)
              result-540)))))

(define (py-rshift-fallback:err x-295 y-296)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for >>: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-295)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-296)
                             (& "__name__")))
                    (&& "'")))))

(define (py-sub-fallback:normal x-297 y-298)
  (letrec* ((magic_method-543
             (getattribute-from-obj-mro x-297 (&& "__sub__"))))
    (if (py-test (py-is magic_method-543 py-absent))
        (py-sub-fallback:reflected x-297 y-298)
        (letrec* ((result-544 (py-call magic_method-543 x-297 y-298)))
          (if (py-test (py-is result-544 py-NotImplemented))
              (py-sub-fallback:reflected x-297 y-298)
              result-544)))))

(define (py-sub-fallback:reflected x-299 y-300)
  (letrec* ((magic_method-547
             (getattribute-from-obj-mro y-300 (&& "__rsub__"))))
    (if (py-test (py-is magic_method-547 py-absent))
        (py-sub-fallback:err x-299 y-300)
        (letrec* ((result-548 (py-call magic_method-547 y-300 x-299)))
          (if (py-test (py-is result-548 py-NotImplemented))
              (py-sub-fallback:err x-299 y-300)
              result-548)))))

(define (py-sub-fallback:err x-301 y-302)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for -: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-301)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-302)
                             (& "__name__")))
                    (&& "'")))))

(define (py-truediv-fallback:normal x-303 y-304)
  (letrec* ((magic_method-551
             (getattribute-from-obj-mro x-303 (&& "__truediv__"))))
    (if (py-test (py-is magic_method-551 py-absent))
        (py-truediv-fallback:reflected x-303 y-304)
        (letrec* ((result-552 (py-call magic_method-551 x-303 y-304)))
          (if (py-test (py-is result-552 py-NotImplemented))
              (py-truediv-fallback:reflected x-303 y-304)
              result-552)))))

(define (py-truediv-fallback:reflected x-305 y-306)
  (letrec* ((magic_method-555
             (getattribute-from-obj-mro y-306 (&& "__rtruediv__"))))
    (if (py-test (py-is magic_method-555 py-absent))
        (py-truediv-fallback:err x-305 y-306)
        (letrec* ((result-556 (py-call magic_method-555 y-306 x-305)))
          (if (py-test (py-is result-556 py-NotImplemented))
              (py-truediv-fallback:err x-305 y-306)
              result-556)))))

(define (py-truediv-fallback:err x-307 y-308)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for /: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-307)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-308)
                             (& "__name__")))
                    (&& "'")))))

(define (py-xor-fallback:normal x-309 y-310)
  (letrec* ((magic_method-559
             (getattribute-from-obj-mro x-309 (&& "__xor__"))))
    (if (py-test (py-is magic_method-559 py-absent))
        (py-xor-fallback:reflected x-309 y-310)
        (letrec* ((result-560 (py-call magic_method-559 x-309 y-310)))
          (if (py-test (py-is result-560 py-NotImplemented))
              (py-xor-fallback:reflected x-309 y-310)
              result-560)))))

(define (py-xor-fallback:reflected x-311 y-312)
  (letrec* ((magic_method-563
             (getattribute-from-obj-mro y-312 (&& "__rxor__"))))
    (if (py-test (py-is magic_method-563 py-absent))
        (py-xor-fallback:err x-311 y-312)
        (letrec* ((result-564 (py-call magic_method-563 y-312 x-311)))
          (if (py-test (py-is result-564 py-NotImplemented))
              (py-xor-fallback:err x-311 y-312)
              result-564)))))

(define (py-xor-fallback:err x-313 y-314)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for ^: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-313)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-314)
                             (& "__name__")))
                    (&& "'")))))

(define (py-iadd-fallback:inplace x-315 y-316)
  (letrec* ((magic_method-567
             (getattribute-from-obj-mro x-315 (&& "__iadd__"))))
    (if (py-test (py-is magic_method-567 py-absent))
        (py-iadd-fallback:normal x-315 y-316)
        (letrec* ((result-568 (py-call magic_method-567 x-315 y-316)))
          (if (py-test (py-is result-568 py-NotImplemented))
              (py-iadd-fallback:normal x-315 y-316)
              result-568)))))

(define (py-iadd-fallback:normal x-317 y-318)
  (letrec* ((magic_method-571
             (getattribute-from-obj-mro x-317 (&& "__add__"))))
    (if (py-test (py-is magic_method-571 py-absent))
        (py-iadd-fallback:reflected x-317 y-318)
        (letrec* ((result-572 (py-call magic_method-571 x-317 y-318)))
          (if (py-test (py-is result-572 py-NotImplemented))
              (py-iadd-fallback:reflected x-317 y-318)
              result-572)))))

(define (py-iadd-fallback:reflected x-319 y-320)
  (letrec* ((magic_method-575
             (getattribute-from-obj-mro y-320 (&& "__radd__"))))
    (if (py-test (py-is magic_method-575 py-absent))
        (py-iadd-fallback:err x-319 y-320)
        (letrec* ((result-576 (py-call magic_method-575 y-320 x-319)))
          (if (py-test (py-is result-576 py-NotImplemented))
              (py-iadd-fallback:err x-319 y-320)
              result-576)))))

(define (py-iadd-fallback:err x-321 y-322)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for +=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-321)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-322)
                             (& "__name__")))
                    (&& "'")))))

(define (py-ibitand-fallback:inplace x-323 y-324)
  (letrec* ((magic_method-579
             (getattribute-from-obj-mro x-323 (&& "__iand__"))))
    (if (py-test (py-is magic_method-579 py-absent))
        (py-ibitand-fallback:normal x-323 y-324)
        (letrec* ((result-580 (py-call magic_method-579 x-323 y-324)))
          (if (py-test (py-is result-580 py-NotImplemented))
              (py-ibitand-fallback:normal x-323 y-324)
              result-580)))))

(define (py-ibitand-fallback:normal x-325 y-326)
  (letrec* ((magic_method-583
             (getattribute-from-obj-mro x-325 (&& "__and__"))))
    (if (py-test (py-is magic_method-583 py-absent))
        (py-ibitand-fallback:reflected x-325 y-326)
        (letrec* ((result-584 (py-call magic_method-583 x-325 y-326)))
          (if (py-test (py-is result-584 py-NotImplemented))
              (py-ibitand-fallback:reflected x-325 y-326)
              result-584)))))

(define (py-ibitand-fallback:reflected x-327 y-328)
  (letrec* ((magic_method-587
             (getattribute-from-obj-mro y-328 (&& "__rand__"))))
    (if (py-test (py-is magic_method-587 py-absent))
        (py-ibitand-fallback:err x-327 y-328)
        (letrec* ((result-588 (py-call magic_method-587 y-328 x-327)))
          (if (py-test (py-is result-588 py-NotImplemented))
              (py-ibitand-fallback:err x-327 y-328)
              result-588)))))

(define (py-ibitand-fallback:err x-329 y-330)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for &=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-329)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-330)
                             (& "__name__")))
                    (&& "'")))))

(define (py-ibitor-fallback:inplace x-331 y-332)
  (letrec* ((magic_method-591
             (getattribute-from-obj-mro x-331 (&& "__ior__"))))
    (if (py-test (py-is magic_method-591 py-absent))
        (py-ibitor-fallback:normal x-331 y-332)
        (letrec* ((result-592 (py-call magic_method-591 x-331 y-332)))
          (if (py-test (py-is result-592 py-NotImplemented))
              (py-ibitor-fallback:normal x-331 y-332)
              result-592)))))

(define (py-ibitor-fallback:normal x-333 y-334)
  (letrec* ((magic_method-595 (getattribute-from-obj-mro x-333 (&& "__or__"))))
    (if (py-test (py-is magic_method-595 py-absent))
        (py-ibitor-fallback:reflected x-333 y-334)
        (letrec* ((result-596 (py-call magic_method-595 x-333 y-334)))
          (if (py-test (py-is result-596 py-NotImplemented))
              (py-ibitor-fallback:reflected x-333 y-334)
              result-596)))))

(define (py-ibitor-fallback:reflected x-335 y-336)
  (letrec* ((magic_method-599
             (getattribute-from-obj-mro y-336 (&& "__ror__"))))
    (if (py-test (py-is magic_method-599 py-absent))
        (py-ibitor-fallback:err x-335 y-336)
        (letrec* ((result-600 (py-call magic_method-599 y-336 x-335)))
          (if (py-test (py-is result-600 py-NotImplemented))
              (py-ibitor-fallback:err x-335 y-336)
              result-600)))))

(define (py-ibitor-fallback:err x-337 y-338)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for |=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-337)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-338)
                             (& "__name__")))
                    (&& "'")))))

(define (py-ifloordiv-fallback:inplace x-339 y-340)
  (letrec* ((magic_method-603
             (getattribute-from-obj-mro x-339 (&& "__ifloordiv__"))))
    (if (py-test (py-is magic_method-603 py-absent))
        (py-ifloordiv-fallback:normal x-339 y-340)
        (letrec* ((result-604 (py-call magic_method-603 x-339 y-340)))
          (if (py-test (py-is result-604 py-NotImplemented))
              (py-ifloordiv-fallback:normal x-339 y-340)
              result-604)))))

(define (py-ifloordiv-fallback:normal x-341 y-342)
  (letrec* ((magic_method-607
             (getattribute-from-obj-mro x-341 (&& "__floordiv__"))))
    (if (py-test (py-is magic_method-607 py-absent))
        (py-ifloordiv-fallback:reflected x-341 y-342)
        (letrec* ((result-608 (py-call magic_method-607 x-341 y-342)))
          (if (py-test (py-is result-608 py-NotImplemented))
              (py-ifloordiv-fallback:reflected x-341 y-342)
              result-608)))))

(define (py-ifloordiv-fallback:reflected x-343 y-344)
  (letrec* ((magic_method-611
             (getattribute-from-obj-mro y-344 (&& "__rfloordiv__"))))
    (if (py-test (py-is magic_method-611 py-absent))
        (py-ifloordiv-fallback:err x-343 y-344)
        (letrec* ((result-612 (py-call magic_method-611 y-344 x-343)))
          (if (py-test (py-is result-612 py-NotImplemented))
              (py-ifloordiv-fallback:err x-343 y-344)
              result-612)))))

(define (py-ifloordiv-fallback:err x-345 y-346)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for //=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-345)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-346)
                             (& "__name__")))
                    (&& "'")))))

(define (py-ilshift-fallback:inplace x-347 y-348)
  (letrec* ((magic_method-615
             (getattribute-from-obj-mro x-347 (&& "__ilshift__"))))
    (if (py-test (py-is magic_method-615 py-absent))
        (py-ilshift-fallback:normal x-347 y-348)
        (letrec* ((result-616 (py-call magic_method-615 x-347 y-348)))
          (if (py-test (py-is result-616 py-NotImplemented))
              (py-ilshift-fallback:normal x-347 y-348)
              result-616)))))

(define (py-ilshift-fallback:normal x-349 y-350)
  (letrec* ((magic_method-619
             (getattribute-from-obj-mro x-349 (&& "__lshift__"))))
    (if (py-test (py-is magic_method-619 py-absent))
        (py-ilshift-fallback:reflected x-349 y-350)
        (letrec* ((result-620 (py-call magic_method-619 x-349 y-350)))
          (if (py-test (py-is result-620 py-NotImplemented))
              (py-ilshift-fallback:reflected x-349 y-350)
              result-620)))))

(define (py-ilshift-fallback:reflected x-351 y-352)
  (letrec* ((magic_method-623
             (getattribute-from-obj-mro y-352 (&& "__rlshift__"))))
    (if (py-test (py-is magic_method-623 py-absent))
        (py-ilshift-fallback:err x-351 y-352)
        (letrec* ((result-624 (py-call magic_method-623 y-352 x-351)))
          (if (py-test (py-is result-624 py-NotImplemented))
              (py-ilshift-fallback:err x-351 y-352)
              result-624)))))

(define (py-ilshift-fallback:err x-353 y-354)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for <<=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-353)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-354)
                             (& "__name__")))
                    (&& "'")))))

(define (py-imatmul-fallback:inplace x-355 y-356)
  (letrec* ((magic_method-627
             (getattribute-from-obj-mro x-355 (&& "__imatmul__"))))
    (if (py-test (py-is magic_method-627 py-absent))
        (py-imatmul-fallback:normal x-355 y-356)
        (letrec* ((result-628 (py-call magic_method-627 x-355 y-356)))
          (if (py-test (py-is result-628 py-NotImplemented))
              (py-imatmul-fallback:normal x-355 y-356)
              result-628)))))

(define (py-imatmul-fallback:normal x-357 y-358)
  (letrec* ((magic_method-631
             (getattribute-from-obj-mro x-357 (&& "__matmul__"))))
    (if (py-test (py-is magic_method-631 py-absent))
        (py-imatmul-fallback:reflected x-357 y-358)
        (letrec* ((result-632 (py-call magic_method-631 x-357 y-358)))
          (if (py-test (py-is result-632 py-NotImplemented))
              (py-imatmul-fallback:reflected x-357 y-358)
              result-632)))))

(define (py-imatmul-fallback:reflected x-359 y-360)
  (letrec* ((magic_method-635
             (getattribute-from-obj-mro y-360 (&& "__rmatmul__"))))
    (if (py-test (py-is magic_method-635 py-absent))
        (py-imatmul-fallback:err x-359 y-360)
        (letrec* ((result-636 (py-call magic_method-635 y-360 x-359)))
          (if (py-test (py-is result-636 py-NotImplemented))
              (py-imatmul-fallback:err x-359 y-360)
              result-636)))))

(define (py-imatmul-fallback:err x-361 y-362)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for @=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-361)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-362)
                             (& "__name__")))
                    (&& "'")))))

(define (py-imod-fallback:inplace x-363 y-364)
  (letrec* ((magic_method-639
             (getattribute-from-obj-mro x-363 (&& "__imod__"))))
    (if (py-test (py-is magic_method-639 py-absent))
        (py-imod-fallback:normal x-363 y-364)
        (letrec* ((result-640 (py-call magic_method-639 x-363 y-364)))
          (if (py-test (py-is result-640 py-NotImplemented))
              (py-imod-fallback:normal x-363 y-364)
              result-640)))))

(define (py-imod-fallback:normal x-365 y-366)
  (letrec* ((magic_method-643
             (getattribute-from-obj-mro x-365 (&& "__mod__"))))
    (if (py-test (py-is magic_method-643 py-absent))
        (py-imod-fallback:reflected x-365 y-366)
        (letrec* ((result-644 (py-call magic_method-643 x-365 y-366)))
          (if (py-test (py-is result-644 py-NotImplemented))
              (py-imod-fallback:reflected x-365 y-366)
              result-644)))))

(define (py-imod-fallback:reflected x-367 y-368)
  (letrec* ((magic_method-647
             (getattribute-from-obj-mro y-368 (&& "__rmod__"))))
    (if (py-test (py-is magic_method-647 py-absent))
        (py-imod-fallback:err x-367 y-368)
        (letrec* ((result-648 (py-call magic_method-647 y-368 x-367)))
          (if (py-test (py-is result-648 py-NotImplemented))
              (py-imod-fallback:err x-367 y-368)
              result-648)))))

(define (py-imod-fallback:err x-369 y-370)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for %=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-369)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-370)
                             (& "__name__")))
                    (&& "'")))))

(define (py-imul-fallback:inplace x-371 y-372)
  (letrec* ((magic_method-651
             (getattribute-from-obj-mro x-371 (&& "__imul__"))))
    (if (py-test (py-is magic_method-651 py-absent))
        (py-imul-fallback:normal x-371 y-372)
        (letrec* ((result-652 (py-call magic_method-651 x-371 y-372)))
          (if (py-test (py-is result-652 py-NotImplemented))
              (py-imul-fallback:normal x-371 y-372)
              result-652)))))

(define (py-imul-fallback:normal x-373 y-374)
  (letrec* ((magic_method-655
             (getattribute-from-obj-mro x-373 (&& "__mul__"))))
    (if (py-test (py-is magic_method-655 py-absent))
        (py-imul-fallback:reflected x-373 y-374)
        (letrec* ((result-656 (py-call magic_method-655 x-373 y-374)))
          (if (py-test (py-is result-656 py-NotImplemented))
              (py-imul-fallback:reflected x-373 y-374)
              result-656)))))

(define (py-imul-fallback:reflected x-375 y-376)
  (letrec* ((magic_method-659
             (getattribute-from-obj-mro y-376 (&& "__rmul__"))))
    (if (py-test (py-is magic_method-659 py-absent))
        (py-imul-fallback:err x-375 y-376)
        (letrec* ((result-660 (py-call magic_method-659 y-376 x-375)))
          (if (py-test (py-is result-660 py-NotImplemented))
              (py-imul-fallback:err x-375 y-376)
              result-660)))))

(define (py-imul-fallback:err x-377 y-378)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for *=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-377)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-378)
                             (& "__name__")))
                    (&& "'")))))

(define (py-ipow-fallback:inplace x-379 y-380)
  (letrec* ((magic_method-663
             (getattribute-from-obj-mro x-379 (&& "__ipow__"))))
    (if (py-test (py-is magic_method-663 py-absent))
        (py-ipow-fallback:normal x-379 y-380)
        (letrec* ((result-664 (py-call magic_method-663 x-379 y-380)))
          (if (py-test (py-is result-664 py-NotImplemented))
              (py-ipow-fallback:normal x-379 y-380)
              result-664)))))

(define (py-ipow-fallback:normal x-381 y-382)
  (letrec* ((magic_method-667
             (getattribute-from-obj-mro x-381 (&& "__pow__"))))
    (if (py-test (py-is magic_method-667 py-absent))
        (py-ipow-fallback:reflected x-381 y-382)
        (letrec* ((result-668 (py-call magic_method-667 x-381 y-382)))
          (if (py-test (py-is result-668 py-NotImplemented))
              (py-ipow-fallback:reflected x-381 y-382)
              result-668)))))

(define (py-ipow-fallback:reflected x-383 y-384)
  (letrec* ((magic_method-671
             (getattribute-from-obj-mro y-384 (&& "__rpow__"))))
    (if (py-test (py-is magic_method-671 py-absent))
        (py-ipow-fallback:err x-383 y-384)
        (letrec* ((result-672 (py-call magic_method-671 y-384 x-383)))
          (if (py-test (py-is result-672 py-NotImplemented))
              (py-ipow-fallback:err x-383 y-384)
              result-672)))))

(define (py-ipow-fallback:err x-385 y-386)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for **=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-385)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-386)
                             (& "__name__")))
                    (&& "'")))))

(define (py-irshift-fallback:inplace x-387 y-388)
  (letrec* ((magic_method-675
             (getattribute-from-obj-mro x-387 (&& "__irshift__"))))
    (if (py-test (py-is magic_method-675 py-absent))
        (py-irshift-fallback:normal x-387 y-388)
        (letrec* ((result-676 (py-call magic_method-675 x-387 y-388)))
          (if (py-test (py-is result-676 py-NotImplemented))
              (py-irshift-fallback:normal x-387 y-388)
              result-676)))))

(define (py-irshift-fallback:normal x-389 y-390)
  (letrec* ((magic_method-679
             (getattribute-from-obj-mro x-389 (&& "__rshift__"))))
    (if (py-test (py-is magic_method-679 py-absent))
        (py-irshift-fallback:reflected x-389 y-390)
        (letrec* ((result-680 (py-call magic_method-679 x-389 y-390)))
          (if (py-test (py-is result-680 py-NotImplemented))
              (py-irshift-fallback:reflected x-389 y-390)
              result-680)))))

(define (py-irshift-fallback:reflected x-391 y-392)
  (letrec* ((magic_method-683
             (getattribute-from-obj-mro y-392 (&& "__rrshift__"))))
    (if (py-test (py-is magic_method-683 py-absent))
        (py-irshift-fallback:err x-391 y-392)
        (letrec* ((result-684 (py-call magic_method-683 y-392 x-391)))
          (if (py-test (py-is result-684 py-NotImplemented))
              (py-irshift-fallback:err x-391 y-392)
              result-684)))))

(define (py-irshift-fallback:err x-393 y-394)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for >>=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-393)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-394)
                             (& "__name__")))
                    (&& "'")))))

(define (py-isub-fallback:inplace x-395 y-396)
  (letrec* ((magic_method-687
             (getattribute-from-obj-mro x-395 (&& "__isub__"))))
    (if (py-test (py-is magic_method-687 py-absent))
        (py-isub-fallback:normal x-395 y-396)
        (letrec* ((result-688 (py-call magic_method-687 x-395 y-396)))
          (if (py-test (py-is result-688 py-NotImplemented))
              (py-isub-fallback:normal x-395 y-396)
              result-688)))))

(define (py-isub-fallback:normal x-397 y-398)
  (letrec* ((magic_method-691
             (getattribute-from-obj-mro x-397 (&& "__sub__"))))
    (if (py-test (py-is magic_method-691 py-absent))
        (py-isub-fallback:reflected x-397 y-398)
        (letrec* ((result-692 (py-call magic_method-691 x-397 y-398)))
          (if (py-test (py-is result-692 py-NotImplemented))
              (py-isub-fallback:reflected x-397 y-398)
              result-692)))))

(define (py-isub-fallback:reflected x-399 y-400)
  (letrec* ((magic_method-695
             (getattribute-from-obj-mro y-400 (&& "__rsub__"))))
    (if (py-test (py-is magic_method-695 py-absent))
        (py-isub-fallback:err x-399 y-400)
        (letrec* ((result-696 (py-call magic_method-695 y-400 x-399)))
          (if (py-test (py-is result-696 py-NotImplemented))
              (py-isub-fallback:err x-399 y-400)
              result-696)))))

(define (py-isub-fallback:err x-401 y-402)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for -=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-401)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-402)
                             (& "__name__")))
                    (&& "'")))))

(define (py-itruediv-fallback:inplace x-403 y-404)
  (letrec* ((magic_method-699
             (getattribute-from-obj-mro x-403 (&& "__itruediv__"))))
    (if (py-test (py-is magic_method-699 py-absent))
        (py-itruediv-fallback:normal x-403 y-404)
        (letrec* ((result-700 (py-call magic_method-699 x-403 y-404)))
          (if (py-test (py-is result-700 py-NotImplemented))
              (py-itruediv-fallback:normal x-403 y-404)
              result-700)))))

(define (py-itruediv-fallback:normal x-405 y-406)
  (letrec* ((magic_method-703
             (getattribute-from-obj-mro x-405 (&& "__truediv__"))))
    (if (py-test (py-is magic_method-703 py-absent))
        (py-itruediv-fallback:reflected x-405 y-406)
        (letrec* ((result-704 (py-call magic_method-703 x-405 y-406)))
          (if (py-test (py-is result-704 py-NotImplemented))
              (py-itruediv-fallback:reflected x-405 y-406)
              result-704)))))

(define (py-itruediv-fallback:reflected x-407 y-408)
  (letrec* ((magic_method-707
             (getattribute-from-obj-mro y-408 (&& "__rtruediv__"))))
    (if (py-test (py-is magic_method-707 py-absent))
        (py-itruediv-fallback:err x-407 y-408)
        (letrec* ((result-708 (py-call magic_method-707 y-408 x-407)))
          (if (py-test (py-is result-708 py-NotImplemented))
              (py-itruediv-fallback:err x-407 y-408)
              result-708)))))

(define (py-itruediv-fallback:err x-409 y-410)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for /=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-409)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-410)
                             (& "__name__")))
                    (&& "'")))))

(define (py-ixor-fallback:inplace x-411 y-412)
  (letrec* ((magic_method-711
             (getattribute-from-obj-mro x-411 (&& "__ixor__"))))
    (if (py-test (py-is magic_method-711 py-absent))
        (py-ixor-fallback:normal x-411 y-412)
        (letrec* ((result-712 (py-call magic_method-711 x-411 y-412)))
          (if (py-test (py-is result-712 py-NotImplemented))
              (py-ixor-fallback:normal x-411 y-412)
              result-712)))))

(define (py-ixor-fallback:normal x-413 y-414)
  (letrec* ((magic_method-715
             (getattribute-from-obj-mro x-413 (&& "__xor__"))))
    (if (py-test (py-is magic_method-715 py-absent))
        (py-ixor-fallback:reflected x-413 y-414)
        (letrec* ((result-716 (py-call magic_method-715 x-413 y-414)))
          (if (py-test (py-is result-716 py-NotImplemented))
              (py-ixor-fallback:reflected x-413 y-414)
              result-716)))))

(define (py-ixor-fallback:reflected x-415 y-416)
  (letrec* ((magic_method-719
             (getattribute-from-obj-mro y-416 (&& "__rxor__"))))
    (if (py-test (py-is magic_method-719 py-absent))
        (py-ixor-fallback:err x-415 y-416)
        (letrec* ((result-720 (py-call magic_method-719 y-416 x-415)))
          (if (py-test (py-is result-720 py-NotImplemented))
              (py-ixor-fallback:err x-415 y-416)
              result-720)))))

(define (py-ixor-fallback:err x-417 y-418)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "unsupported operand type(s) for ^=: '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-417)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-418)
                             (& "__name__")))
                    (&& "'")))))

(define (py-pos-fallback:normal x-419)
  (letrec* ((magic_method-722
             (getattribute-from-obj-mro x-419 (&& "__pos__"))))
    (if (py-test (py-is magic_method-722 py-absent))
        (py-pos-fallback:err x-419)
        (py-call magic_method-722 x-419))))

(define (py-pos-fallback:err x-420)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (&& "bad operand type for unary +: '")
                            (py-getattribute
                             (py-call py-builtin-type x-420)
                             (& "__name__")))
                    (&& "'")))))

(define (py-neg-fallback:normal x-421)
  (letrec* ((magic_method-724
             (getattribute-from-obj-mro x-421 (&& "__neg__"))))
    (if (py-test (py-is magic_method-724 py-absent))
        (py-neg-fallback:err x-421)
        (py-call magic_method-724 x-421))))

(define (py-neg-fallback:err x-422)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (&& "bad operand type for unary -: '")
                            (py-getattribute
                             (py-call py-builtin-type x-422)
                             (& "__name__")))
                    (&& "'")))))

(define (py-invert-fallback:normal x-423)
  (letrec* ((magic_method-726
             (getattribute-from-obj-mro x-423 (&& "__invert__"))))
    (if (py-test (py-is magic_method-726 py-absent))
        (py-invert-fallback:err x-423)
        (py-call magic_method-726 x-423))))

(define (py-invert-fallback:err x-424)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (&& "bad operand type for unary ~: '")
                            (py-getattribute
                             (py-call py-builtin-type x-424)
                             (& "__name__")))
                    (&& "'")))))

(define (py-ge-fallback:normal x-425 y-426)
  (letrec* ((magic_method-729 (getattribute-from-obj-mro x-425 (&& "__ge__"))))
    (if (py-test (py-is magic_method-729 py-absent))
        (py-ge-fallback:reflected x-425 y-426)
        (letrec* ((result-730 (py-call magic_method-729 x-425 y-426)))
          (if (py-test (py-is result-730 py-NotImplemented))
              (py-ge-fallback:reflected x-425 y-426)
              result-730)))))

(define (py-ge-fallback:reflected x-427 y-428)
  (letrec* ((magic_method-733 (getattribute-from-obj-mro y-428 (&& "__le__"))))
    (if (py-test (py-is magic_method-733 py-absent))
        (py-ge-fallback:err x-427 y-428)
        (letrec* ((result-734 (py-call magic_method-733 y-428 x-427)))
          (if (py-test (py-is result-734 py-NotImplemented))
              (py-ge-fallback:err x-427 y-428)
              result-734)))))

(define (py-ge-fallback:err x-429 y-430)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "'>=' not supported between instances of '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-429)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-430)
                             (& "__name__")))
                    (&& "'")))))

(define (py-gt-fallback:normal x-431 y-432)
  (letrec* ((magic_method-737 (getattribute-from-obj-mro x-431 (&& "__gt__"))))
    (if (py-test (py-is magic_method-737 py-absent))
        (py-gt-fallback:reflected x-431 y-432)
        (letrec* ((result-738 (py-call magic_method-737 x-431 y-432)))
          (if (py-test (py-is result-738 py-NotImplemented))
              (py-gt-fallback:reflected x-431 y-432)
              result-738)))))

(define (py-gt-fallback:reflected x-433 y-434)
  (letrec* ((magic_method-741 (getattribute-from-obj-mro y-434 (&& "__lt__"))))
    (if (py-test (py-is magic_method-741 py-absent))
        (py-gt-fallback:err x-433 y-434)
        (letrec* ((result-742 (py-call magic_method-741 y-434 x-433)))
          (if (py-test (py-is result-742 py-NotImplemented))
              (py-gt-fallback:err x-433 y-434)
              result-742)))))

(define (py-gt-fallback:err x-435 y-436)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "'>' not supported between instances of '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-435)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-436)
                             (& "__name__")))
                    (&& "'")))))

(define (py-le-fallback:normal x-437 y-438)
  (letrec* ((magic_method-745 (getattribute-from-obj-mro x-437 (&& "__le__"))))
    (if (py-test (py-is magic_method-745 py-absent))
        (py-le-fallback:reflected x-437 y-438)
        (letrec* ((result-746 (py-call magic_method-745 x-437 y-438)))
          (if (py-test (py-is result-746 py-NotImplemented))
              (py-le-fallback:reflected x-437 y-438)
              result-746)))))

(define (py-le-fallback:reflected x-439 y-440)
  (letrec* ((magic_method-749 (getattribute-from-obj-mro y-440 (&& "__ge__"))))
    (if (py-test (py-is magic_method-749 py-absent))
        (py-le-fallback:err x-439 y-440)
        (letrec* ((result-750 (py-call magic_method-749 y-440 x-439)))
          (if (py-test (py-is result-750 py-NotImplemented))
              (py-le-fallback:err x-439 y-440)
              result-750)))))

(define (py-le-fallback:err x-441 y-442)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "'<=' not supported between instances of '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-441)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-442)
                             (& "__name__")))
                    (&& "'")))))

(define (py-lt-fallback:normal x-443 y-444)
  (letrec* ((magic_method-753 (getattribute-from-obj-mro x-443 (&& "__lt__"))))
    (if (py-test (py-is magic_method-753 py-absent))
        (py-lt-fallback:reflected x-443 y-444)
        (letrec* ((result-754 (py-call magic_method-753 x-443 y-444)))
          (if (py-test (py-is result-754 py-NotImplemented))
              (py-lt-fallback:reflected x-443 y-444)
              result-754)))))

(define (py-lt-fallback:reflected x-445 y-446)
  (letrec* ((magic_method-757 (getattribute-from-obj-mro y-446 (&& "__gt__"))))
    (if (py-test (py-is magic_method-757 py-absent))
        (py-lt-fallback:err x-445 y-446)
        (letrec* ((result-758 (py-call magic_method-757 y-446 x-445)))
          (if (py-test (py-is result-758 py-NotImplemented))
              (py-lt-fallback:err x-445 y-446)
              result-758)))))

(define (py-lt-fallback:err x-447 y-448)
  (py-throw
   (py-call py-builtin-TypeError
            (py-add (py-add (py-add (py-add (&& "'<' not supported between instances of '")
                                            (py-getattribute
                                             (py-call py-builtin-type x-447)
                                             (& "__name__")))
                                    (&& "' and '"))
                            (py-getattribute
                             (py-call py-builtin-type y-448)
                             (& "__name__")))
                    (&& "'")))))

(define (py-eq-fallback:normal x-449 y-450)
  (letrec* ((magic_method-761 (getattribute-from-obj-mro x-449 (&& "__eq__"))))
    (if (py-test (py-is magic_method-761 py-absent))
        (py-eq-fallback:reflected x-449 y-450)
        (letrec* ((result-762 (py-call magic_method-761 x-449 y-450)))
          (if (py-test (py-is result-762 py-NotImplemented))
              (py-eq-fallback:reflected x-449 y-450)
              result-762)))))

(define (py-eq-fallback:reflected x-451 y-452)
  (letrec* ((magic_method-765 (getattribute-from-obj-mro y-452 (&& "__eq__"))))
    (if (py-test (py-is magic_method-765 py-absent))
        (py-eq-fallback:default x-451 y-452)
        (letrec* ((result-766 (py-call magic_method-765 y-452 x-451)))
          (if (py-test (py-is result-766 py-NotImplemented))
              (py-eq-fallback:default x-451 y-452)
              result-766)))))

(define (py-eq-fallback:default x-453 y-454) (py-is x-453 y-454))

(define (py-ne-fallback:normal x-455 y-456)
  (letrec* ((magic_method-769 (getattribute-from-obj-mro x-455 (&& "__ne__"))))
    (if (py-test (py-is magic_method-769 py-absent))
        (py-ne-fallback:reflected x-455 y-456)
        (letrec* ((result-770 (py-call magic_method-769 x-455 y-456)))
          (if (py-test (py-is result-770 py-NotImplemented))
              (py-ne-fallback:reflected x-455 y-456)
              result-770)))))

(define (py-ne-fallback:reflected x-457 y-458)
  (letrec* ((magic_method-773 (getattribute-from-obj-mro y-458 (&& "__ne__"))))
    (if (py-test (py-is magic_method-773 py-absent))
        (py-ne-fallback:default x-457 y-458)
        (letrec* ((result-774 (py-call magic_method-773 y-458 x-457)))
          (if (py-test (py-is result-774 py-NotImplemented))
              (py-ne-fallback:default x-457 y-458)
              result-774)))))

(define (py-ne-fallback:default x-459 y-460) (py-isnot x-459 y-460))

(define (py-getattribute-fallback obj-219 attr-220)
  (letrec* ((__getattribute__-777
             (getattribute-from-obj-mro obj-219 (&& "__getattribute__"))))
    (with-handler
     (lambda ($%exc_0)
       (cond ((py-isinstance? $%exc_0 py-builtin-AttributeError)
              (letrec* ((__getattr__-778
                         (getattribute-from-obj-mro
                          obj-219
                          (&& "__getattr__"))))
                (if (py-test (py-is __getattr__-778 py-absent))
                    (py-throw $%exc_0)
                    (py-call __getattr__-778 obj-219 attr-220))))
             (else (raise $%exc_0))))
     (py-call __getattribute__-777 obj-219 attr-220))))

(define (py-getitem-fallback obj-222 index-223)
  (letrec* ((__getitem__-780
             (getattribute-from-obj-mro obj-222 (&& "__getitem__"))))
    (if (py-test (py-is __getitem__-780 py-absent))
        (py-throw
         (py-call py-builtin-TypeError (&& "object is not subscriptable")))
        (py-call __getitem__-780 obj-222 index-223))))

(define (py-setitem-fallback obj-225 index-226 value-227)
  (letrec* ((__setitem__-782
             (getattribute-from-obj-mro obj-225 (&& "__setitem__"))))
    (if (py-test (py-is __setitem__-782 py-absent))
        (py-throw
         (py-call py-builtin-TypeError
                  (&& "object does not support item assignment")))
        (py-call __setitem__-782 obj-225 index-226 value-227))))

(define (py-delitem-fallback obj-229 index-230)
  (letrec* ((__delitem__-784
             (getattribute-from-obj-mro obj-229 (&& "__delitem__"))))
    (if (py-test (py-is __delitem__-784 py-absent))
        (py-throw
         (py-call py-builtin-TypeError
                  (&& "object does not support item deletion")))
        (py-call __delitem__-784 obj-229 index-230))))

(define (py-enter-fallback obj-232)
  (letrec* ((__enter__-786
             (getattribute-from-obj-mro obj-232 (&& "__enter__"))))
    (if (py-test (py-is __enter__-786 py-absent))
        (py-throw (py-call py-builtin-AttributeError (&& "__enter__")))
        (py-call __enter__-786 obj-232))))

(define (py-exit-fallback obj-234 exc-235)
  (letrec* ((__exit__-789 (getattribute-from-obj-mro obj-234 (&& "__exit__"))))
    (if (py-test (py-is __exit__-789 py-absent))
        (py-throw (py-call py-builtin-AttributeError (&& "__exit__")))
        (if (py-test (py-is exc-235 py-None))
            (py-call __exit__-789 obj-234 py-None py-None py-None)
            (letrec* ((exit_result-790
                       (py-call __exit__-789
                                obj-234
                                (py-call py-builtin-type exc-235)
                                exc-235
                                py-None)))
              (if (py-test exit_result-790) py-None (py-throw exc-235)))))))

