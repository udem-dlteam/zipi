(define-macro (py-add-floatX-floatY-inline x-2 y-3)
  `(let ((x-2 ,x-2) (y-3 ,y-3))
     (py-float-from-scheme
      (py+ (py-float-to-scheme x-2) (py-float-to-scheme y-3)))))

(define-macro (py-add-floatX-boolY-inline x-5 y-6)
  `(py-add-floatX-boolY-fallback ,x-5 ,y-6))

(define-macro (py-add-floatX-sintY-inline x-8 y-9)
  `(let ((x-8 ,x-8) (y-9 ,y-9))
     (py-float-from-scheme
      (py+ (py-float-to-scheme x-8) (py-sint-to-scheme y-9)))))

(define-macro (py-add-floatX-bintY-inline x-11 y-12)
  `(py-add-floatX-bintY-fallback ,x-11 ,y-12))

(define-macro (py-add-boolX-floatY-inline x-14 y-15)
  `(py-add-boolX-floatY-fallback ,x-14 ,y-15))

(define-macro (py-add-boolX-boolY-inline x-17 y-18)
  `(py-add-boolX-boolY-fallback ,x-17 ,y-18))

(define-macro (py-add-boolX-sintY-inline x-20 y-21)
  `(py-add-boolX-sintY-fallback ,x-20 ,y-21))

(define-macro (py-add-boolX-bintY-inline x-23 y-24)
  `(py-add-boolX-bintY-fallback ,x-23 ,y-24))

(define-macro (py-add-sintX-floatY-inline x-26 y-27)
  `(let ((x-26 ,x-26) (y-27 ,y-27))
     (py-float-from-scheme
      (py+ (py-sint-to-scheme x-26) (py-float-to-scheme y-27)))))

(define-macro (py-add-sintX-boolY-inline x-29 y-30)
  `(py-add-sintX-boolY-fallback ,x-29 ,y-30))

(define-macro (py-add-sintX-sintY-inline x-32 y-33)
  `(let ((x-32 ,x-32) (y-33 ,y-33))
     (py-int-from-scheme
      (py+ (py-sint-to-scheme x-32) (py-sint-to-scheme y-33)))))

(define-macro (py-add-sintX-bintY-inline x-35 y-36)
  `(py-add-sintX-bintY-fallback ,x-35 ,y-36))

(define-macro (py-add-bintX-floatY-inline x-38 y-39)
  `(py-add-bintX-floatY-fallback ,x-38 ,y-39))

(define-macro (py-add-bintX-boolY-inline x-41 y-42)
  `(py-add-bintX-boolY-fallback ,x-41 ,y-42))

(define-macro (py-add-bintX-sintY-inline x-44 y-45)
  `(py-add-bintX-sintY-fallback ,x-44 ,y-45))

(define-macro (py-add-bintX-bintY-inline x-47 y-48)
  `(py-add-bintX-bintY-fallback ,x-47 ,y-48))

(define-macro (py-bitand-floatX-floatY-inline x-50 y-51)
  `(let ((x-50 ,x-50) (y-51 ,y-51))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for &: 'float' and 'float'")))))

(define-macro (py-bitand-floatX-boolY-inline x-53 y-54)
  `(py-bitand-floatX-boolY-fallback ,x-53 ,y-54))

(define-macro (py-bitand-floatX-sintY-inline x-56 y-57)
  `(let ((x-56 ,x-56) (y-57 ,y-57))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for &: 'float' and 'int'")))))

(define-macro (py-bitand-floatX-bintY-inline x-59 y-60)
  `(py-bitand-floatX-bintY-fallback ,x-59 ,y-60))

(define-macro (py-bitand-boolX-floatY-inline x-62 y-63)
  `(py-bitand-boolX-floatY-fallback ,x-62 ,y-63))

(define-macro (py-bitand-boolX-boolY-inline x-65 y-66)
  `(py-bitand-boolX-boolY-fallback ,x-65 ,y-66))

(define-macro (py-bitand-boolX-sintY-inline x-68 y-69)
  `(py-bitand-boolX-sintY-fallback ,x-68 ,y-69))

(define-macro (py-bitand-boolX-bintY-inline x-71 y-72)
  `(py-bitand-boolX-bintY-fallback ,x-71 ,y-72))

(define-macro (py-bitand-sintX-floatY-inline x-74 y-75)
  `(let ((x-74 ,x-74) (y-75 ,y-75))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for &: 'int' and 'float'")))))

(define-macro (py-bitand-sintX-boolY-inline x-77 y-78)
  `(py-bitand-sintX-boolY-fallback ,x-77 ,y-78))

(define-macro (py-bitand-sintX-sintY-inline x-80 y-81)
  `(let ((x-80 ,x-80) (y-81 ,y-81))
     (py-int-from-scheme
      (py& (py-sint-to-scheme x-80) (py-sint-to-scheme y-81)))))

(define-macro (py-bitand-sintX-bintY-inline x-83 y-84)
  `(py-bitand-sintX-bintY-fallback ,x-83 ,y-84))

(define-macro (py-bitand-bintX-floatY-inline x-86 y-87)
  `(py-bitand-bintX-floatY-fallback ,x-86 ,y-87))

(define-macro (py-bitand-bintX-boolY-inline x-89 y-90)
  `(py-bitand-bintX-boolY-fallback ,x-89 ,y-90))

(define-macro (py-bitand-bintX-sintY-inline x-92 y-93)
  `(py-bitand-bintX-sintY-fallback ,x-92 ,y-93))

(define-macro (py-bitand-bintX-bintY-inline x-95 y-96)
  `(py-bitand-bintX-bintY-fallback ,x-95 ,y-96))

(define-macro (py-bitor-floatX-floatY-inline x-98 y-99)
  `(let ((x-98 ,x-98) (y-99 ,y-99))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for |: 'float' and 'float'")))))

(define-macro (py-bitor-floatX-boolY-inline x-101 y-102)
  `(py-bitor-floatX-boolY-fallback ,x-101 ,y-102))

(define-macro (py-bitor-floatX-sintY-inline x-104 y-105)
  `(let ((x-104 ,x-104) (y-105 ,y-105))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for |: 'float' and 'int'")))))

(define-macro (py-bitor-floatX-bintY-inline x-107 y-108)
  `(py-bitor-floatX-bintY-fallback ,x-107 ,y-108))

(define-macro (py-bitor-boolX-floatY-inline x-110 y-111)
  `(py-bitor-boolX-floatY-fallback ,x-110 ,y-111))

(define-macro (py-bitor-boolX-boolY-inline x-113 y-114)
  `(py-bitor-boolX-boolY-fallback ,x-113 ,y-114))

(define-macro (py-bitor-boolX-sintY-inline x-116 y-117)
  `(py-bitor-boolX-sintY-fallback ,x-116 ,y-117))

(define-macro (py-bitor-boolX-bintY-inline x-119 y-120)
  `(py-bitor-boolX-bintY-fallback ,x-119 ,y-120))

(define-macro (py-bitor-sintX-floatY-inline x-122 y-123)
  `(let ((x-122 ,x-122) (y-123 ,y-123))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for |: 'int' and 'float'")))))

(define-macro (py-bitor-sintX-boolY-inline x-125 y-126)
  `(py-bitor-sintX-boolY-fallback ,x-125 ,y-126))

(define-macro (py-bitor-sintX-sintY-inline x-128 y-129)
  `(let ((x-128 ,x-128) (y-129 ,y-129))
     (py-int-from-scheme
      (py+b (py-sint-to-scheme x-128) (py-sint-to-scheme y-129)))))

(define-macro (py-bitor-sintX-bintY-inline x-131 y-132)
  `(py-bitor-sintX-bintY-fallback ,x-131 ,y-132))

(define-macro (py-bitor-bintX-floatY-inline x-134 y-135)
  `(py-bitor-bintX-floatY-fallback ,x-134 ,y-135))

(define-macro (py-bitor-bintX-boolY-inline x-137 y-138)
  `(py-bitor-bintX-boolY-fallback ,x-137 ,y-138))

(define-macro (py-bitor-bintX-sintY-inline x-140 y-141)
  `(py-bitor-bintX-sintY-fallback ,x-140 ,y-141))

(define-macro (py-bitor-bintX-bintY-inline x-143 y-144)
  `(py-bitor-bintX-bintY-fallback ,x-143 ,y-144))

(define-macro (py-floordiv-floatX-floatY-inline x-146 y-147)
  `(let ((x-146 ,x-146) (y-147 ,y-147))
     (if (py-test (py-ne y-147 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py// (py-float-to-scheme x-146) (py-float-to-scheme y-147)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-floordiv-floatX-boolY-inline x-149 y-150)
  `(py-floordiv-floatX-boolY-fallback ,x-149 ,y-150))

(define-macro (py-floordiv-floatX-sintY-inline x-152 y-153)
  `(let ((x-152 ,x-152) (y-153 ,y-153))
     (if (py-test (py-ne y-153 (py-int-from-scheme 0)))
         (py-float-from-scheme
          (py// (py-float-to-scheme x-152) (py-sint-to-scheme y-153)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-floordiv-floatX-bintY-inline x-155 y-156)
  `(py-floordiv-floatX-bintY-fallback ,x-155 ,y-156))

(define-macro (py-floordiv-boolX-floatY-inline x-158 y-159)
  `(py-floordiv-boolX-floatY-fallback ,x-158 ,y-159))

(define-macro (py-floordiv-boolX-boolY-inline x-161 y-162)
  `(py-floordiv-boolX-boolY-fallback ,x-161 ,y-162))

(define-macro (py-floordiv-boolX-sintY-inline x-164 y-165)
  `(py-floordiv-boolX-sintY-fallback ,x-164 ,y-165))

(define-macro (py-floordiv-boolX-bintY-inline x-167 y-168)
  `(py-floordiv-boolX-bintY-fallback ,x-167 ,y-168))

(define-macro (py-floordiv-sintX-floatY-inline x-170 y-171)
  `(let ((x-170 ,x-170) (y-171 ,y-171))
     (if (py-test (py-ne y-171 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py// (py-sint-to-scheme x-170) (py-float-to-scheme y-171)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-floordiv-sintX-boolY-inline x-173 y-174)
  `(py-floordiv-sintX-boolY-fallback ,x-173 ,y-174))

(define-macro (py-floordiv-sintX-sintY-inline x-176 y-177)
  `(let ((x-176 ,x-176) (y-177 ,y-177))
     (if (py-test (py-ne y-177 (py-int-from-scheme 0)))
         (py-int-from-scheme
          (py// (py-sint-to-scheme x-176) (py-sint-to-scheme y-177)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "integer division by zero"))))))

(define-macro (py-floordiv-sintX-bintY-inline x-179 y-180)
  `(py-floordiv-sintX-bintY-fallback ,x-179 ,y-180))

(define-macro (py-floordiv-bintX-floatY-inline x-182 y-183)
  `(py-floordiv-bintX-floatY-fallback ,x-182 ,y-183))

(define-macro (py-floordiv-bintX-boolY-inline x-185 y-186)
  `(py-floordiv-bintX-boolY-fallback ,x-185 ,y-186))

(define-macro (py-floordiv-bintX-sintY-inline x-188 y-189)
  `(py-floordiv-bintX-sintY-fallback ,x-188 ,y-189))

(define-macro (py-floordiv-bintX-bintY-inline x-191 y-192)
  `(py-floordiv-bintX-bintY-fallback ,x-191 ,y-192))

(define-macro (py-lshift-floatX-floatY-inline x-194 y-195)
  `(let ((x-194 ,x-194) (y-195 ,y-195))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for <<: 'float' and 'float'")))))

(define-macro (py-lshift-floatX-boolY-inline x-197 y-198)
  `(py-lshift-floatX-boolY-fallback ,x-197 ,y-198))

(define-macro (py-lshift-floatX-sintY-inline x-200 y-201)
  `(let ((x-200 ,x-200) (y-201 ,y-201))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for <<: 'float' and 'int'")))))

(define-macro (py-lshift-floatX-bintY-inline x-203 y-204)
  `(py-lshift-floatX-bintY-fallback ,x-203 ,y-204))

(define-macro (py-lshift-boolX-floatY-inline x-206 y-207)
  `(py-lshift-boolX-floatY-fallback ,x-206 ,y-207))

(define-macro (py-lshift-boolX-boolY-inline x-209 y-210)
  `(py-lshift-boolX-boolY-fallback ,x-209 ,y-210))

(define-macro (py-lshift-boolX-sintY-inline x-212 y-213)
  `(py-lshift-boolX-sintY-fallback ,x-212 ,y-213))

(define-macro (py-lshift-boolX-bintY-inline x-215 y-216)
  `(py-lshift-boolX-bintY-fallback ,x-215 ,y-216))

(define-macro (py-lshift-sintX-floatY-inline x-218 y-219)
  `(let ((x-218 ,x-218) (y-219 ,y-219))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for <<: 'int' and 'float'")))))

(define-macro (py-lshift-sintX-boolY-inline x-221 y-222)
  `(py-lshift-sintX-boolY-fallback ,x-221 ,y-222))

(define-macro (py-lshift-sintX-sintY-inline x-224 y-225)
  `(let ((x-224 ,x-224) (y-225 ,y-225))
     (if (py-test (py-ge y-225 (py-int-from-scheme 0)))
         (py-int-from-scheme
          (py<< (py-sint-to-scheme x-224) (py-sint-to-scheme y-225)))
         (py-throw
          (py-call py-builtin-ValueError (&& "negative shift count"))))))

(define-macro (py-lshift-sintX-bintY-inline x-227 y-228)
  `(py-lshift-sintX-bintY-fallback ,x-227 ,y-228))

(define-macro (py-lshift-bintX-floatY-inline x-230 y-231)
  `(py-lshift-bintX-floatY-fallback ,x-230 ,y-231))

(define-macro (py-lshift-bintX-boolY-inline x-233 y-234)
  `(py-lshift-bintX-boolY-fallback ,x-233 ,y-234))

(define-macro (py-lshift-bintX-sintY-inline x-236 y-237)
  `(py-lshift-bintX-sintY-fallback ,x-236 ,y-237))

(define-macro (py-lshift-bintX-bintY-inline x-239 y-240)
  `(py-lshift-bintX-bintY-fallback ,x-239 ,y-240))

(define-macro (py-matmul-floatX-floatY-inline x-242 y-243)
  `(let ((x-242 ,x-242) (y-243 ,y-243))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @: 'float' and 'float'")))))

(define-macro (py-matmul-floatX-boolY-inline x-245 y-246)
  `(py-matmul-floatX-boolY-fallback ,x-245 ,y-246))

(define-macro (py-matmul-floatX-sintY-inline x-248 y-249)
  `(let ((x-248 ,x-248) (y-249 ,y-249))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @: 'float' and 'int'")))))

(define-macro (py-matmul-floatX-bintY-inline x-251 y-252)
  `(py-matmul-floatX-bintY-fallback ,x-251 ,y-252))

(define-macro (py-matmul-boolX-floatY-inline x-254 y-255)
  `(py-matmul-boolX-floatY-fallback ,x-254 ,y-255))

(define-macro (py-matmul-boolX-boolY-inline x-257 y-258)
  `(py-matmul-boolX-boolY-fallback ,x-257 ,y-258))

(define-macro (py-matmul-boolX-sintY-inline x-260 y-261)
  `(py-matmul-boolX-sintY-fallback ,x-260 ,y-261))

(define-macro (py-matmul-boolX-bintY-inline x-263 y-264)
  `(py-matmul-boolX-bintY-fallback ,x-263 ,y-264))

(define-macro (py-matmul-sintX-floatY-inline x-266 y-267)
  `(let ((x-266 ,x-266) (y-267 ,y-267))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @: 'int' and 'float'")))))

(define-macro (py-matmul-sintX-boolY-inline x-269 y-270)
  `(py-matmul-sintX-boolY-fallback ,x-269 ,y-270))

(define-macro (py-matmul-sintX-sintY-inline x-272 y-273)
  `(let ((x-272 ,x-272) (y-273 ,y-273))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @: 'int' and 'int'")))))

(define-macro (py-matmul-sintX-bintY-inline x-275 y-276)
  `(py-matmul-sintX-bintY-fallback ,x-275 ,y-276))

(define-macro (py-matmul-bintX-floatY-inline x-278 y-279)
  `(py-matmul-bintX-floatY-fallback ,x-278 ,y-279))

(define-macro (py-matmul-bintX-boolY-inline x-281 y-282)
  `(py-matmul-bintX-boolY-fallback ,x-281 ,y-282))

(define-macro (py-matmul-bintX-sintY-inline x-284 y-285)
  `(py-matmul-bintX-sintY-fallback ,x-284 ,y-285))

(define-macro (py-matmul-bintX-bintY-inline x-287 y-288)
  `(py-matmul-bintX-bintY-fallback ,x-287 ,y-288))

(define-macro (py-mod-floatX-floatY-inline x-290 y-291)
  `(let ((x-290 ,x-290) (y-291 ,y-291))
     (if (py-test (py-ne y-291 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py% (py-float-to-scheme x-290) (py-float-to-scheme y-291)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float modulo by zero"))))))

(define-macro (py-mod-floatX-boolY-inline x-293 y-294)
  `(py-mod-floatX-boolY-fallback ,x-293 ,y-294))

(define-macro (py-mod-floatX-sintY-inline x-296 y-297)
  `(let ((x-296 ,x-296) (y-297 ,y-297))
     (if (py-test (py-ne y-297 (py-int-from-scheme 0)))
         (py-float-from-scheme
          (py% (py-float-to-scheme x-296) (py-sint-to-scheme y-297)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float modulo by zero"))))))

(define-macro (py-mod-floatX-bintY-inline x-299 y-300)
  `(py-mod-floatX-bintY-fallback ,x-299 ,y-300))

(define-macro (py-mod-boolX-floatY-inline x-302 y-303)
  `(py-mod-boolX-floatY-fallback ,x-302 ,y-303))

(define-macro (py-mod-boolX-boolY-inline x-305 y-306)
  `(py-mod-boolX-boolY-fallback ,x-305 ,y-306))

(define-macro (py-mod-boolX-sintY-inline x-308 y-309)
  `(py-mod-boolX-sintY-fallback ,x-308 ,y-309))

(define-macro (py-mod-boolX-bintY-inline x-311 y-312)
  `(py-mod-boolX-bintY-fallback ,x-311 ,y-312))

(define-macro (py-mod-sintX-floatY-inline x-314 y-315)
  `(let ((x-314 ,x-314) (y-315 ,y-315))
     (if (py-test (py-ne y-315 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py% (py-sint-to-scheme x-314) (py-float-to-scheme y-315)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float modulo by zero"))))))

(define-macro (py-mod-sintX-boolY-inline x-317 y-318)
  `(py-mod-sintX-boolY-fallback ,x-317 ,y-318))

(define-macro (py-mod-sintX-sintY-inline x-320 y-321)
  `(let ((x-320 ,x-320) (y-321 ,y-321))
     (if (py-test (py-ne y-321 (py-int-from-scheme 0)))
         (py-int-from-scheme
          (py% (py-sint-to-scheme x-320) (py-sint-to-scheme y-321)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError (&& "modulo by zero"))))))

(define-macro (py-mod-sintX-bintY-inline x-323 y-324)
  `(py-mod-sintX-bintY-fallback ,x-323 ,y-324))

(define-macro (py-mod-bintX-floatY-inline x-326 y-327)
  `(py-mod-bintX-floatY-fallback ,x-326 ,y-327))

(define-macro (py-mod-bintX-boolY-inline x-329 y-330)
  `(py-mod-bintX-boolY-fallback ,x-329 ,y-330))

(define-macro (py-mod-bintX-sintY-inline x-332 y-333)
  `(py-mod-bintX-sintY-fallback ,x-332 ,y-333))

(define-macro (py-mod-bintX-bintY-inline x-335 y-336)
  `(py-mod-bintX-bintY-fallback ,x-335 ,y-336))

(define-macro (py-mul-floatX-floatY-inline x-338 y-339)
  `(let ((x-338 ,x-338) (y-339 ,y-339))
     (py-float-from-scheme
      (py* (py-float-to-scheme x-338) (py-float-to-scheme y-339)))))

(define-macro (py-mul-floatX-boolY-inline x-341 y-342)
  `(py-mul-floatX-boolY-fallback ,x-341 ,y-342))

(define-macro (py-mul-floatX-sintY-inline x-344 y-345)
  `(let ((x-344 ,x-344) (y-345 ,y-345))
     (py-float-from-scheme
      (py* (py-float-to-scheme x-344) (py-sint-to-scheme y-345)))))

(define-macro (py-mul-floatX-bintY-inline x-347 y-348)
  `(py-mul-floatX-bintY-fallback ,x-347 ,y-348))

(define-macro (py-mul-boolX-floatY-inline x-350 y-351)
  `(py-mul-boolX-floatY-fallback ,x-350 ,y-351))

(define-macro (py-mul-boolX-boolY-inline x-353 y-354)
  `(py-mul-boolX-boolY-fallback ,x-353 ,y-354))

(define-macro (py-mul-boolX-sintY-inline x-356 y-357)
  `(py-mul-boolX-sintY-fallback ,x-356 ,y-357))

(define-macro (py-mul-boolX-bintY-inline x-359 y-360)
  `(py-mul-boolX-bintY-fallback ,x-359 ,y-360))

(define-macro (py-mul-sintX-floatY-inline x-362 y-363)
  `(let ((x-362 ,x-362) (y-363 ,y-363))
     (py-float-from-scheme
      (py* (py-sint-to-scheme x-362) (py-float-to-scheme y-363)))))

(define-macro (py-mul-sintX-boolY-inline x-365 y-366)
  `(py-mul-sintX-boolY-fallback ,x-365 ,y-366))

(define-macro (py-mul-sintX-sintY-inline x-368 y-369)
  `(let ((x-368 ,x-368) (y-369 ,y-369))
     (py-int-from-scheme
      (py* (py-sint-to-scheme x-368) (py-sint-to-scheme y-369)))))

(define-macro (py-mul-sintX-bintY-inline x-371 y-372)
  `(py-mul-sintX-bintY-fallback ,x-371 ,y-372))

(define-macro (py-mul-bintX-floatY-inline x-374 y-375)
  `(py-mul-bintX-floatY-fallback ,x-374 ,y-375))

(define-macro (py-mul-bintX-boolY-inline x-377 y-378)
  `(py-mul-bintX-boolY-fallback ,x-377 ,y-378))

(define-macro (py-mul-bintX-sintY-inline x-380 y-381)
  `(py-mul-bintX-sintY-fallback ,x-380 ,y-381))

(define-macro (py-mul-bintX-bintY-inline x-383 y-384)
  `(py-mul-bintX-bintY-fallback ,x-383 ,y-384))

(define-macro (py-pow-floatX-floatY-inline x-386 y-387)
  `(let ((x-386 ,x-386) (y-387 ,y-387))
     (py-float-from-scheme
      (py** (py-float-to-scheme x-386) (py-float-to-scheme y-387)))))

(define-macro (py-pow-floatX-boolY-inline x-389 y-390)
  `(py-pow-floatX-boolY-fallback ,x-389 ,y-390))

(define-macro (py-pow-floatX-sintY-inline x-392 y-393)
  `(let ((x-392 ,x-392) (y-393 ,y-393))
     (py-float-from-scheme
      (py** (py-float-to-scheme x-392) (py-sint-to-scheme y-393)))))

(define-macro (py-pow-floatX-bintY-inline x-395 y-396)
  `(py-pow-floatX-bintY-fallback ,x-395 ,y-396))

(define-macro (py-pow-boolX-floatY-inline x-398 y-399)
  `(py-pow-boolX-floatY-fallback ,x-398 ,y-399))

(define-macro (py-pow-boolX-boolY-inline x-401 y-402)
  `(py-pow-boolX-boolY-fallback ,x-401 ,y-402))

(define-macro (py-pow-boolX-sintY-inline x-404 y-405)
  `(py-pow-boolX-sintY-fallback ,x-404 ,y-405))

(define-macro (py-pow-boolX-bintY-inline x-407 y-408)
  `(py-pow-boolX-bintY-fallback ,x-407 ,y-408))

(define-macro (py-pow-sintX-floatY-inline x-410 y-411)
  `(let ((x-410 ,x-410) (y-411 ,y-411))
     (py-float-from-scheme
      (py** (py-sint-to-scheme x-410) (py-float-to-scheme y-411)))))

(define-macro (py-pow-sintX-boolY-inline x-413 y-414)
  `(py-pow-sintX-boolY-fallback ,x-413 ,y-414))

(define-macro (py-pow-sintX-sintY-inline x-416 y-417)
  `(let ((x-416 ,x-416) (y-417 ,y-417))
     (py-int-from-scheme
      (py** (py-sint-to-scheme x-416) (py-sint-to-scheme y-417)))))

(define-macro (py-pow-sintX-bintY-inline x-419 y-420)
  `(py-pow-sintX-bintY-fallback ,x-419 ,y-420))

(define-macro (py-pow-bintX-floatY-inline x-422 y-423)
  `(py-pow-bintX-floatY-fallback ,x-422 ,y-423))

(define-macro (py-pow-bintX-boolY-inline x-425 y-426)
  `(py-pow-bintX-boolY-fallback ,x-425 ,y-426))

(define-macro (py-pow-bintX-sintY-inline x-428 y-429)
  `(py-pow-bintX-sintY-fallback ,x-428 ,y-429))

(define-macro (py-pow-bintX-bintY-inline x-431 y-432)
  `(py-pow-bintX-bintY-fallback ,x-431 ,y-432))

(define-macro (py-rshift-floatX-floatY-inline x-434 y-435)
  `(let ((x-434 ,x-434) (y-435 ,y-435))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for >>: 'float' and 'float'")))))

(define-macro (py-rshift-floatX-boolY-inline x-437 y-438)
  `(py-rshift-floatX-boolY-fallback ,x-437 ,y-438))

(define-macro (py-rshift-floatX-sintY-inline x-440 y-441)
  `(let ((x-440 ,x-440) (y-441 ,y-441))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for >>: 'float' and 'int'")))))

(define-macro (py-rshift-floatX-bintY-inline x-443 y-444)
  `(py-rshift-floatX-bintY-fallback ,x-443 ,y-444))

(define-macro (py-rshift-boolX-floatY-inline x-446 y-447)
  `(py-rshift-boolX-floatY-fallback ,x-446 ,y-447))

(define-macro (py-rshift-boolX-boolY-inline x-449 y-450)
  `(py-rshift-boolX-boolY-fallback ,x-449 ,y-450))

(define-macro (py-rshift-boolX-sintY-inline x-452 y-453)
  `(py-rshift-boolX-sintY-fallback ,x-452 ,y-453))

(define-macro (py-rshift-boolX-bintY-inline x-455 y-456)
  `(py-rshift-boolX-bintY-fallback ,x-455 ,y-456))

(define-macro (py-rshift-sintX-floatY-inline x-458 y-459)
  `(let ((x-458 ,x-458) (y-459 ,y-459))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for >>: 'int' and 'float'")))))

(define-macro (py-rshift-sintX-boolY-inline x-461 y-462)
  `(py-rshift-sintX-boolY-fallback ,x-461 ,y-462))

(define-macro (py-rshift-sintX-sintY-inline x-464 y-465)
  `(let ((x-464 ,x-464) (y-465 ,y-465))
     (if (py-test (py-ge y-465 (py-int-from-scheme 0)))
         (py-int-from-scheme
          (py>> (py-sint-to-scheme x-464) (py-sint-to-scheme y-465)))
         (py-throw
          (py-call py-builtin-ValueError (&& "negative shift count"))))))

(define-macro (py-rshift-sintX-bintY-inline x-467 y-468)
  `(py-rshift-sintX-bintY-fallback ,x-467 ,y-468))

(define-macro (py-rshift-bintX-floatY-inline x-470 y-471)
  `(py-rshift-bintX-floatY-fallback ,x-470 ,y-471))

(define-macro (py-rshift-bintX-boolY-inline x-473 y-474)
  `(py-rshift-bintX-boolY-fallback ,x-473 ,y-474))

(define-macro (py-rshift-bintX-sintY-inline x-476 y-477)
  `(py-rshift-bintX-sintY-fallback ,x-476 ,y-477))

(define-macro (py-rshift-bintX-bintY-inline x-479 y-480)
  `(py-rshift-bintX-bintY-fallback ,x-479 ,y-480))

(define-macro (py-sub-floatX-floatY-inline x-482 y-483)
  `(let ((x-482 ,x-482) (y-483 ,y-483))
     (py-float-from-scheme
      (py- (py-float-to-scheme x-482) (py-float-to-scheme y-483)))))

(define-macro (py-sub-floatX-boolY-inline x-485 y-486)
  `(py-sub-floatX-boolY-fallback ,x-485 ,y-486))

(define-macro (py-sub-floatX-sintY-inline x-488 y-489)
  `(let ((x-488 ,x-488) (y-489 ,y-489))
     (py-float-from-scheme
      (py- (py-float-to-scheme x-488) (py-sint-to-scheme y-489)))))

(define-macro (py-sub-floatX-bintY-inline x-491 y-492)
  `(py-sub-floatX-bintY-fallback ,x-491 ,y-492))

(define-macro (py-sub-boolX-floatY-inline x-494 y-495)
  `(py-sub-boolX-floatY-fallback ,x-494 ,y-495))

(define-macro (py-sub-boolX-boolY-inline x-497 y-498)
  `(py-sub-boolX-boolY-fallback ,x-497 ,y-498))

(define-macro (py-sub-boolX-sintY-inline x-500 y-501)
  `(py-sub-boolX-sintY-fallback ,x-500 ,y-501))

(define-macro (py-sub-boolX-bintY-inline x-503 y-504)
  `(py-sub-boolX-bintY-fallback ,x-503 ,y-504))

(define-macro (py-sub-sintX-floatY-inline x-506 y-507)
  `(let ((x-506 ,x-506) (y-507 ,y-507))
     (py-float-from-scheme
      (py- (py-sint-to-scheme x-506) (py-float-to-scheme y-507)))))

(define-macro (py-sub-sintX-boolY-inline x-509 y-510)
  `(py-sub-sintX-boolY-fallback ,x-509 ,y-510))

(define-macro (py-sub-sintX-sintY-inline x-512 y-513)
  `(let ((x-512 ,x-512) (y-513 ,y-513))
     (py-int-from-scheme
      (py- (py-sint-to-scheme x-512) (py-sint-to-scheme y-513)))))

(define-macro (py-sub-sintX-bintY-inline x-515 y-516)
  `(py-sub-sintX-bintY-fallback ,x-515 ,y-516))

(define-macro (py-sub-bintX-floatY-inline x-518 y-519)
  `(py-sub-bintX-floatY-fallback ,x-518 ,y-519))

(define-macro (py-sub-bintX-boolY-inline x-521 y-522)
  `(py-sub-bintX-boolY-fallback ,x-521 ,y-522))

(define-macro (py-sub-bintX-sintY-inline x-524 y-525)
  `(py-sub-bintX-sintY-fallback ,x-524 ,y-525))

(define-macro (py-sub-bintX-bintY-inline x-527 y-528)
  `(py-sub-bintX-bintY-fallback ,x-527 ,y-528))

(define-macro (py-truediv-floatX-floatY-inline x-530 y-531)
  `(let ((x-530 ,x-530) (y-531 ,y-531))
     (if (py-test (py-ne y-531 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py/ (py-float-to-scheme x-530) (py-float-to-scheme y-531)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-truediv-floatX-boolY-inline x-533 y-534)
  `(py-truediv-floatX-boolY-fallback ,x-533 ,y-534))

(define-macro (py-truediv-floatX-sintY-inline x-536 y-537)
  `(let ((x-536 ,x-536) (y-537 ,y-537))
     (if (py-test (py-ne y-537 (py-int-from-scheme 0)))
         (py-float-from-scheme
          (py/ (py-float-to-scheme x-536) (py-sint-to-scheme y-537)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-truediv-floatX-bintY-inline x-539 y-540)
  `(py-truediv-floatX-bintY-fallback ,x-539 ,y-540))

(define-macro (py-truediv-boolX-floatY-inline x-542 y-543)
  `(py-truediv-boolX-floatY-fallback ,x-542 ,y-543))

(define-macro (py-truediv-boolX-boolY-inline x-545 y-546)
  `(py-truediv-boolX-boolY-fallback ,x-545 ,y-546))

(define-macro (py-truediv-boolX-sintY-inline x-548 y-549)
  `(py-truediv-boolX-sintY-fallback ,x-548 ,y-549))

(define-macro (py-truediv-boolX-bintY-inline x-551 y-552)
  `(py-truediv-boolX-bintY-fallback ,x-551 ,y-552))

(define-macro (py-truediv-sintX-floatY-inline x-554 y-555)
  `(let ((x-554 ,x-554) (y-555 ,y-555))
     (if (py-test (py-ne y-555 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py/ (py-sint-to-scheme x-554) (py-float-to-scheme y-555)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-truediv-sintX-boolY-inline x-557 y-558)
  `(py-truediv-sintX-boolY-fallback ,x-557 ,y-558))

(define-macro (py-truediv-sintX-sintY-inline x-560 y-561)
  `(let ((x-560 ,x-560) (y-561 ,y-561))
     (if (py-test (py-ne y-561 (py-int-from-scheme 0)))
         (py-float-from-scheme
          (py/ (py-sint-to-scheme x-560) (py-sint-to-scheme y-561)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError (&& "division by zero"))))))

(define-macro (py-truediv-sintX-bintY-inline x-563 y-564)
  `(py-truediv-sintX-bintY-fallback ,x-563 ,y-564))

(define-macro (py-truediv-bintX-floatY-inline x-566 y-567)
  `(py-truediv-bintX-floatY-fallback ,x-566 ,y-567))

(define-macro (py-truediv-bintX-boolY-inline x-569 y-570)
  `(py-truediv-bintX-boolY-fallback ,x-569 ,y-570))

(define-macro (py-truediv-bintX-sintY-inline x-572 y-573)
  `(py-truediv-bintX-sintY-fallback ,x-572 ,y-573))

(define-macro (py-truediv-bintX-bintY-inline x-575 y-576)
  `(py-truediv-bintX-bintY-fallback ,x-575 ,y-576))

(define-macro (py-xor-floatX-floatY-inline x-578 y-579)
  `(let ((x-578 ,x-578) (y-579 ,y-579))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for ^: 'float' and 'float'")))))

(define-macro (py-xor-floatX-boolY-inline x-581 y-582)
  `(py-xor-floatX-boolY-fallback ,x-581 ,y-582))

(define-macro (py-xor-floatX-sintY-inline x-584 y-585)
  `(let ((x-584 ,x-584) (y-585 ,y-585))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for ^: 'float' and 'int'")))))

(define-macro (py-xor-floatX-bintY-inline x-587 y-588)
  `(py-xor-floatX-bintY-fallback ,x-587 ,y-588))

(define-macro (py-xor-boolX-floatY-inline x-590 y-591)
  `(py-xor-boolX-floatY-fallback ,x-590 ,y-591))

(define-macro (py-xor-boolX-boolY-inline x-593 y-594)
  `(py-xor-boolX-boolY-fallback ,x-593 ,y-594))

(define-macro (py-xor-boolX-sintY-inline x-596 y-597)
  `(py-xor-boolX-sintY-fallback ,x-596 ,y-597))

(define-macro (py-xor-boolX-bintY-inline x-599 y-600)
  `(py-xor-boolX-bintY-fallback ,x-599 ,y-600))

(define-macro (py-xor-sintX-floatY-inline x-602 y-603)
  `(let ((x-602 ,x-602) (y-603 ,y-603))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for ^: 'int' and 'float'")))))

(define-macro (py-xor-sintX-boolY-inline x-605 y-606)
  `(py-xor-sintX-boolY-fallback ,x-605 ,y-606))

(define-macro (py-xor-sintX-sintY-inline x-608 y-609)
  `(let ((x-608 ,x-608) (y-609 ,y-609))
     (py-int-from-scheme
      (py^ (py-sint-to-scheme x-608) (py-sint-to-scheme y-609)))))

(define-macro (py-xor-sintX-bintY-inline x-611 y-612)
  `(py-xor-sintX-bintY-fallback ,x-611 ,y-612))

(define-macro (py-xor-bintX-floatY-inline x-614 y-615)
  `(py-xor-bintX-floatY-fallback ,x-614 ,y-615))

(define-macro (py-xor-bintX-boolY-inline x-617 y-618)
  `(py-xor-bintX-boolY-fallback ,x-617 ,y-618))

(define-macro (py-xor-bintX-sintY-inline x-620 y-621)
  `(py-xor-bintX-sintY-fallback ,x-620 ,y-621))

(define-macro (py-xor-bintX-bintY-inline x-623 y-624)
  `(py-xor-bintX-bintY-fallback ,x-623 ,y-624))

(define-macro (py-iadd-floatX-floatY-inline x-626 y-627)
  `(let ((x-626 ,x-626) (y-627 ,y-627))
     (py-float-from-scheme
      (py+ (py-float-to-scheme x-626) (py-float-to-scheme y-627)))))

(define-macro (py-iadd-floatX-boolY-inline x-629 y-630)
  `(py-iadd-floatX-boolY-fallback ,x-629 ,y-630))

(define-macro (py-iadd-floatX-sintY-inline x-632 y-633)
  `(let ((x-632 ,x-632) (y-633 ,y-633))
     (py-float-from-scheme
      (py+ (py-float-to-scheme x-632) (py-sint-to-scheme y-633)))))

(define-macro (py-iadd-floatX-bintY-inline x-635 y-636)
  `(py-iadd-floatX-bintY-fallback ,x-635 ,y-636))

(define-macro (py-iadd-boolX-floatY-inline x-638 y-639)
  `(py-iadd-boolX-floatY-fallback ,x-638 ,y-639))

(define-macro (py-iadd-boolX-boolY-inline x-641 y-642)
  `(py-iadd-boolX-boolY-fallback ,x-641 ,y-642))

(define-macro (py-iadd-boolX-sintY-inline x-644 y-645)
  `(py-iadd-boolX-sintY-fallback ,x-644 ,y-645))

(define-macro (py-iadd-boolX-bintY-inline x-647 y-648)
  `(py-iadd-boolX-bintY-fallback ,x-647 ,y-648))

(define-macro (py-iadd-sintX-floatY-inline x-650 y-651)
  `(let ((x-650 ,x-650) (y-651 ,y-651))
     (py-float-from-scheme
      (py+ (py-sint-to-scheme x-650) (py-float-to-scheme y-651)))))

(define-macro (py-iadd-sintX-boolY-inline x-653 y-654)
  `(py-iadd-sintX-boolY-fallback ,x-653 ,y-654))

(define-macro (py-iadd-sintX-sintY-inline x-656 y-657)
  `(let ((x-656 ,x-656) (y-657 ,y-657))
     (py-int-from-scheme
      (py+ (py-sint-to-scheme x-656) (py-sint-to-scheme y-657)))))

(define-macro (py-iadd-sintX-bintY-inline x-659 y-660)
  `(py-iadd-sintX-bintY-fallback ,x-659 ,y-660))

(define-macro (py-iadd-bintX-floatY-inline x-662 y-663)
  `(py-iadd-bintX-floatY-fallback ,x-662 ,y-663))

(define-macro (py-iadd-bintX-boolY-inline x-665 y-666)
  `(py-iadd-bintX-boolY-fallback ,x-665 ,y-666))

(define-macro (py-iadd-bintX-sintY-inline x-668 y-669)
  `(py-iadd-bintX-sintY-fallback ,x-668 ,y-669))

(define-macro (py-iadd-bintX-bintY-inline x-671 y-672)
  `(py-iadd-bintX-bintY-fallback ,x-671 ,y-672))

(define-macro (py-ibitand-floatX-floatY-inline x-674 y-675)
  `(let ((x-674 ,x-674) (y-675 ,y-675))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for &=: 'float' and 'float'")))))

(define-macro (py-ibitand-floatX-boolY-inline x-677 y-678)
  `(py-ibitand-floatX-boolY-fallback ,x-677 ,y-678))

(define-macro (py-ibitand-floatX-sintY-inline x-680 y-681)
  `(let ((x-680 ,x-680) (y-681 ,y-681))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for &=: 'float' and 'int'")))))

(define-macro (py-ibitand-floatX-bintY-inline x-683 y-684)
  `(py-ibitand-floatX-bintY-fallback ,x-683 ,y-684))

(define-macro (py-ibitand-boolX-floatY-inline x-686 y-687)
  `(py-ibitand-boolX-floatY-fallback ,x-686 ,y-687))

(define-macro (py-ibitand-boolX-boolY-inline x-689 y-690)
  `(py-ibitand-boolX-boolY-fallback ,x-689 ,y-690))

(define-macro (py-ibitand-boolX-sintY-inline x-692 y-693)
  `(py-ibitand-boolX-sintY-fallback ,x-692 ,y-693))

(define-macro (py-ibitand-boolX-bintY-inline x-695 y-696)
  `(py-ibitand-boolX-bintY-fallback ,x-695 ,y-696))

(define-macro (py-ibitand-sintX-floatY-inline x-698 y-699)
  `(let ((x-698 ,x-698) (y-699 ,y-699))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for &=: 'int' and 'float'")))))

(define-macro (py-ibitand-sintX-boolY-inline x-701 y-702)
  `(py-ibitand-sintX-boolY-fallback ,x-701 ,y-702))

(define-macro (py-ibitand-sintX-sintY-inline x-704 y-705)
  `(let ((x-704 ,x-704) (y-705 ,y-705))
     (py-int-from-scheme
      (py& (py-sint-to-scheme x-704) (py-sint-to-scheme y-705)))))

(define-macro (py-ibitand-sintX-bintY-inline x-707 y-708)
  `(py-ibitand-sintX-bintY-fallback ,x-707 ,y-708))

(define-macro (py-ibitand-bintX-floatY-inline x-710 y-711)
  `(py-ibitand-bintX-floatY-fallback ,x-710 ,y-711))

(define-macro (py-ibitand-bintX-boolY-inline x-713 y-714)
  `(py-ibitand-bintX-boolY-fallback ,x-713 ,y-714))

(define-macro (py-ibitand-bintX-sintY-inline x-716 y-717)
  `(py-ibitand-bintX-sintY-fallback ,x-716 ,y-717))

(define-macro (py-ibitand-bintX-bintY-inline x-719 y-720)
  `(py-ibitand-bintX-bintY-fallback ,x-719 ,y-720))

(define-macro (py-ibitor-floatX-floatY-inline x-722 y-723)
  `(let ((x-722 ,x-722) (y-723 ,y-723))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for |=: 'float' and 'float'")))))

(define-macro (py-ibitor-floatX-boolY-inline x-725 y-726)
  `(py-ibitor-floatX-boolY-fallback ,x-725 ,y-726))

(define-macro (py-ibitor-floatX-sintY-inline x-728 y-729)
  `(let ((x-728 ,x-728) (y-729 ,y-729))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for |=: 'float' and 'int'")))))

(define-macro (py-ibitor-floatX-bintY-inline x-731 y-732)
  `(py-ibitor-floatX-bintY-fallback ,x-731 ,y-732))

(define-macro (py-ibitor-boolX-floatY-inline x-734 y-735)
  `(py-ibitor-boolX-floatY-fallback ,x-734 ,y-735))

(define-macro (py-ibitor-boolX-boolY-inline x-737 y-738)
  `(py-ibitor-boolX-boolY-fallback ,x-737 ,y-738))

(define-macro (py-ibitor-boolX-sintY-inline x-740 y-741)
  `(py-ibitor-boolX-sintY-fallback ,x-740 ,y-741))

(define-macro (py-ibitor-boolX-bintY-inline x-743 y-744)
  `(py-ibitor-boolX-bintY-fallback ,x-743 ,y-744))

(define-macro (py-ibitor-sintX-floatY-inline x-746 y-747)
  `(let ((x-746 ,x-746) (y-747 ,y-747))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for |=: 'int' and 'float'")))))

(define-macro (py-ibitor-sintX-boolY-inline x-749 y-750)
  `(py-ibitor-sintX-boolY-fallback ,x-749 ,y-750))

(define-macro (py-ibitor-sintX-sintY-inline x-752 y-753)
  `(let ((x-752 ,x-752) (y-753 ,y-753))
     (py-int-from-scheme
      (py+b (py-sint-to-scheme x-752) (py-sint-to-scheme y-753)))))

(define-macro (py-ibitor-sintX-bintY-inline x-755 y-756)
  `(py-ibitor-sintX-bintY-fallback ,x-755 ,y-756))

(define-macro (py-ibitor-bintX-floatY-inline x-758 y-759)
  `(py-ibitor-bintX-floatY-fallback ,x-758 ,y-759))

(define-macro (py-ibitor-bintX-boolY-inline x-761 y-762)
  `(py-ibitor-bintX-boolY-fallback ,x-761 ,y-762))

(define-macro (py-ibitor-bintX-sintY-inline x-764 y-765)
  `(py-ibitor-bintX-sintY-fallback ,x-764 ,y-765))

(define-macro (py-ibitor-bintX-bintY-inline x-767 y-768)
  `(py-ibitor-bintX-bintY-fallback ,x-767 ,y-768))

(define-macro (py-ifloordiv-floatX-floatY-inline x-770 y-771)
  `(let ((x-770 ,x-770) (y-771 ,y-771))
     (if (py-test (py-ne y-771 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py// (py-float-to-scheme x-770) (py-float-to-scheme y-771)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-ifloordiv-floatX-boolY-inline x-773 y-774)
  `(py-ifloordiv-floatX-boolY-fallback ,x-773 ,y-774))

(define-macro (py-ifloordiv-floatX-sintY-inline x-776 y-777)
  `(let ((x-776 ,x-776) (y-777 ,y-777))
     (if (py-test (py-ne y-777 (py-int-from-scheme 0)))
         (py-float-from-scheme
          (py// (py-float-to-scheme x-776) (py-sint-to-scheme y-777)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-ifloordiv-floatX-bintY-inline x-779 y-780)
  `(py-ifloordiv-floatX-bintY-fallback ,x-779 ,y-780))

(define-macro (py-ifloordiv-boolX-floatY-inline x-782 y-783)
  `(py-ifloordiv-boolX-floatY-fallback ,x-782 ,y-783))

(define-macro (py-ifloordiv-boolX-boolY-inline x-785 y-786)
  `(py-ifloordiv-boolX-boolY-fallback ,x-785 ,y-786))

(define-macro (py-ifloordiv-boolX-sintY-inline x-788 y-789)
  `(py-ifloordiv-boolX-sintY-fallback ,x-788 ,y-789))

(define-macro (py-ifloordiv-boolX-bintY-inline x-791 y-792)
  `(py-ifloordiv-boolX-bintY-fallback ,x-791 ,y-792))

(define-macro (py-ifloordiv-sintX-floatY-inline x-794 y-795)
  `(let ((x-794 ,x-794) (y-795 ,y-795))
     (if (py-test (py-ne y-795 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py// (py-sint-to-scheme x-794) (py-float-to-scheme y-795)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-ifloordiv-sintX-boolY-inline x-797 y-798)
  `(py-ifloordiv-sintX-boolY-fallback ,x-797 ,y-798))

(define-macro (py-ifloordiv-sintX-sintY-inline x-800 y-801)
  `(let ((x-800 ,x-800) (y-801 ,y-801))
     (if (py-test (py-ne y-801 (py-int-from-scheme 0)))
         (py-int-from-scheme
          (py// (py-sint-to-scheme x-800) (py-sint-to-scheme y-801)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "integer division by zero"))))))

(define-macro (py-ifloordiv-sintX-bintY-inline x-803 y-804)
  `(py-ifloordiv-sintX-bintY-fallback ,x-803 ,y-804))

(define-macro (py-ifloordiv-bintX-floatY-inline x-806 y-807)
  `(py-ifloordiv-bintX-floatY-fallback ,x-806 ,y-807))

(define-macro (py-ifloordiv-bintX-boolY-inline x-809 y-810)
  `(py-ifloordiv-bintX-boolY-fallback ,x-809 ,y-810))

(define-macro (py-ifloordiv-bintX-sintY-inline x-812 y-813)
  `(py-ifloordiv-bintX-sintY-fallback ,x-812 ,y-813))

(define-macro (py-ifloordiv-bintX-bintY-inline x-815 y-816)
  `(py-ifloordiv-bintX-bintY-fallback ,x-815 ,y-816))

(define-macro (py-ilshift-floatX-floatY-inline x-818 y-819)
  `(let ((x-818 ,x-818) (y-819 ,y-819))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for <<=: 'float' and 'float'")))))

(define-macro (py-ilshift-floatX-boolY-inline x-821 y-822)
  `(py-ilshift-floatX-boolY-fallback ,x-821 ,y-822))

(define-macro (py-ilshift-floatX-sintY-inline x-824 y-825)
  `(let ((x-824 ,x-824) (y-825 ,y-825))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for <<=: 'float' and 'int'")))))

(define-macro (py-ilshift-floatX-bintY-inline x-827 y-828)
  `(py-ilshift-floatX-bintY-fallback ,x-827 ,y-828))

(define-macro (py-ilshift-boolX-floatY-inline x-830 y-831)
  `(py-ilshift-boolX-floatY-fallback ,x-830 ,y-831))

(define-macro (py-ilshift-boolX-boolY-inline x-833 y-834)
  `(py-ilshift-boolX-boolY-fallback ,x-833 ,y-834))

(define-macro (py-ilshift-boolX-sintY-inline x-836 y-837)
  `(py-ilshift-boolX-sintY-fallback ,x-836 ,y-837))

(define-macro (py-ilshift-boolX-bintY-inline x-839 y-840)
  `(py-ilshift-boolX-bintY-fallback ,x-839 ,y-840))

(define-macro (py-ilshift-sintX-floatY-inline x-842 y-843)
  `(let ((x-842 ,x-842) (y-843 ,y-843))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for <<=: 'int' and 'float'")))))

(define-macro (py-ilshift-sintX-boolY-inline x-845 y-846)
  `(py-ilshift-sintX-boolY-fallback ,x-845 ,y-846))

(define-macro (py-ilshift-sintX-sintY-inline x-848 y-849)
  `(let ((x-848 ,x-848) (y-849 ,y-849))
     (if (py-test (py-ge y-849 (py-int-from-scheme 0)))
         (py-int-from-scheme
          (py<< (py-sint-to-scheme x-848) (py-sint-to-scheme y-849)))
         (py-throw
          (py-call py-builtin-ValueError (&& "negative shift count"))))))

(define-macro (py-ilshift-sintX-bintY-inline x-851 y-852)
  `(py-ilshift-sintX-bintY-fallback ,x-851 ,y-852))

(define-macro (py-ilshift-bintX-floatY-inline x-854 y-855)
  `(py-ilshift-bintX-floatY-fallback ,x-854 ,y-855))

(define-macro (py-ilshift-bintX-boolY-inline x-857 y-858)
  `(py-ilshift-bintX-boolY-fallback ,x-857 ,y-858))

(define-macro (py-ilshift-bintX-sintY-inline x-860 y-861)
  `(py-ilshift-bintX-sintY-fallback ,x-860 ,y-861))

(define-macro (py-ilshift-bintX-bintY-inline x-863 y-864)
  `(py-ilshift-bintX-bintY-fallback ,x-863 ,y-864))

(define-macro (py-imatmul-floatX-floatY-inline x-866 y-867)
  `(let ((x-866 ,x-866) (y-867 ,y-867))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @=: 'float' and 'float'")))))

(define-macro (py-imatmul-floatX-boolY-inline x-869 y-870)
  `(py-imatmul-floatX-boolY-fallback ,x-869 ,y-870))

(define-macro (py-imatmul-floatX-sintY-inline x-872 y-873)
  `(let ((x-872 ,x-872) (y-873 ,y-873))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @=: 'float' and 'int'")))))

(define-macro (py-imatmul-floatX-bintY-inline x-875 y-876)
  `(py-imatmul-floatX-bintY-fallback ,x-875 ,y-876))

(define-macro (py-imatmul-boolX-floatY-inline x-878 y-879)
  `(py-imatmul-boolX-floatY-fallback ,x-878 ,y-879))

(define-macro (py-imatmul-boolX-boolY-inline x-881 y-882)
  `(py-imatmul-boolX-boolY-fallback ,x-881 ,y-882))

(define-macro (py-imatmul-boolX-sintY-inline x-884 y-885)
  `(py-imatmul-boolX-sintY-fallback ,x-884 ,y-885))

(define-macro (py-imatmul-boolX-bintY-inline x-887 y-888)
  `(py-imatmul-boolX-bintY-fallback ,x-887 ,y-888))

(define-macro (py-imatmul-sintX-floatY-inline x-890 y-891)
  `(let ((x-890 ,x-890) (y-891 ,y-891))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @=: 'int' and 'float'")))))

(define-macro (py-imatmul-sintX-boolY-inline x-893 y-894)
  `(py-imatmul-sintX-boolY-fallback ,x-893 ,y-894))

(define-macro (py-imatmul-sintX-sintY-inline x-896 y-897)
  `(let ((x-896 ,x-896) (y-897 ,y-897))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @=: 'int' and 'int'")))))

(define-macro (py-imatmul-sintX-bintY-inline x-899 y-900)
  `(py-imatmul-sintX-bintY-fallback ,x-899 ,y-900))

(define-macro (py-imatmul-bintX-floatY-inline x-902 y-903)
  `(py-imatmul-bintX-floatY-fallback ,x-902 ,y-903))

(define-macro (py-imatmul-bintX-boolY-inline x-905 y-906)
  `(py-imatmul-bintX-boolY-fallback ,x-905 ,y-906))

(define-macro (py-imatmul-bintX-sintY-inline x-908 y-909)
  `(py-imatmul-bintX-sintY-fallback ,x-908 ,y-909))

(define-macro (py-imatmul-bintX-bintY-inline x-911 y-912)
  `(py-imatmul-bintX-bintY-fallback ,x-911 ,y-912))

(define-macro (py-imod-floatX-floatY-inline x-914 y-915)
  `(let ((x-914 ,x-914) (y-915 ,y-915))
     (if (py-test (py-ne y-915 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py% (py-float-to-scheme x-914) (py-float-to-scheme y-915)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float modulo by zero"))))))

(define-macro (py-imod-floatX-boolY-inline x-917 y-918)
  `(py-imod-floatX-boolY-fallback ,x-917 ,y-918))

(define-macro (py-imod-floatX-sintY-inline x-920 y-921)
  `(let ((x-920 ,x-920) (y-921 ,y-921))
     (if (py-test (py-ne y-921 (py-int-from-scheme 0)))
         (py-float-from-scheme
          (py% (py-float-to-scheme x-920) (py-sint-to-scheme y-921)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float modulo by zero"))))))

(define-macro (py-imod-floatX-bintY-inline x-923 y-924)
  `(py-imod-floatX-bintY-fallback ,x-923 ,y-924))

(define-macro (py-imod-boolX-floatY-inline x-926 y-927)
  `(py-imod-boolX-floatY-fallback ,x-926 ,y-927))

(define-macro (py-imod-boolX-boolY-inline x-929 y-930)
  `(py-imod-boolX-boolY-fallback ,x-929 ,y-930))

(define-macro (py-imod-boolX-sintY-inline x-932 y-933)
  `(py-imod-boolX-sintY-fallback ,x-932 ,y-933))

(define-macro (py-imod-boolX-bintY-inline x-935 y-936)
  `(py-imod-boolX-bintY-fallback ,x-935 ,y-936))

(define-macro (py-imod-sintX-floatY-inline x-938 y-939)
  `(let ((x-938 ,x-938) (y-939 ,y-939))
     (if (py-test (py-ne y-939 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py% (py-sint-to-scheme x-938) (py-float-to-scheme y-939)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float modulo by zero"))))))

(define-macro (py-imod-sintX-boolY-inline x-941 y-942)
  `(py-imod-sintX-boolY-fallback ,x-941 ,y-942))

(define-macro (py-imod-sintX-sintY-inline x-944 y-945)
  `(let ((x-944 ,x-944) (y-945 ,y-945))
     (if (py-test (py-ne y-945 (py-int-from-scheme 0)))
         (py-int-from-scheme
          (py% (py-sint-to-scheme x-944) (py-sint-to-scheme y-945)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError (&& "modulo by zero"))))))

(define-macro (py-imod-sintX-bintY-inline x-947 y-948)
  `(py-imod-sintX-bintY-fallback ,x-947 ,y-948))

(define-macro (py-imod-bintX-floatY-inline x-950 y-951)
  `(py-imod-bintX-floatY-fallback ,x-950 ,y-951))

(define-macro (py-imod-bintX-boolY-inline x-953 y-954)
  `(py-imod-bintX-boolY-fallback ,x-953 ,y-954))

(define-macro (py-imod-bintX-sintY-inline x-956 y-957)
  `(py-imod-bintX-sintY-fallback ,x-956 ,y-957))

(define-macro (py-imod-bintX-bintY-inline x-959 y-960)
  `(py-imod-bintX-bintY-fallback ,x-959 ,y-960))

(define-macro (py-imul-floatX-floatY-inline x-962 y-963)
  `(let ((x-962 ,x-962) (y-963 ,y-963))
     (py-float-from-scheme
      (py* (py-float-to-scheme x-962) (py-float-to-scheme y-963)))))

(define-macro (py-imul-floatX-boolY-inline x-965 y-966)
  `(py-imul-floatX-boolY-fallback ,x-965 ,y-966))

(define-macro (py-imul-floatX-sintY-inline x-968 y-969)
  `(let ((x-968 ,x-968) (y-969 ,y-969))
     (py-float-from-scheme
      (py* (py-float-to-scheme x-968) (py-sint-to-scheme y-969)))))

(define-macro (py-imul-floatX-bintY-inline x-971 y-972)
  `(py-imul-floatX-bintY-fallback ,x-971 ,y-972))

(define-macro (py-imul-boolX-floatY-inline x-974 y-975)
  `(py-imul-boolX-floatY-fallback ,x-974 ,y-975))

(define-macro (py-imul-boolX-boolY-inline x-977 y-978)
  `(py-imul-boolX-boolY-fallback ,x-977 ,y-978))

(define-macro (py-imul-boolX-sintY-inline x-980 y-981)
  `(py-imul-boolX-sintY-fallback ,x-980 ,y-981))

(define-macro (py-imul-boolX-bintY-inline x-983 y-984)
  `(py-imul-boolX-bintY-fallback ,x-983 ,y-984))

(define-macro (py-imul-sintX-floatY-inline x-986 y-987)
  `(let ((x-986 ,x-986) (y-987 ,y-987))
     (py-float-from-scheme
      (py* (py-sint-to-scheme x-986) (py-float-to-scheme y-987)))))

(define-macro (py-imul-sintX-boolY-inline x-989 y-990)
  `(py-imul-sintX-boolY-fallback ,x-989 ,y-990))

(define-macro (py-imul-sintX-sintY-inline x-992 y-993)
  `(let ((x-992 ,x-992) (y-993 ,y-993))
     (py-int-from-scheme
      (py* (py-sint-to-scheme x-992) (py-sint-to-scheme y-993)))))

(define-macro (py-imul-sintX-bintY-inline x-995 y-996)
  `(py-imul-sintX-bintY-fallback ,x-995 ,y-996))

(define-macro (py-imul-bintX-floatY-inline x-998 y-999)
  `(py-imul-bintX-floatY-fallback ,x-998 ,y-999))

(define-macro (py-imul-bintX-boolY-inline x-1001 y-1002)
  `(py-imul-bintX-boolY-fallback ,x-1001 ,y-1002))

(define-macro (py-imul-bintX-sintY-inline x-1004 y-1005)
  `(py-imul-bintX-sintY-fallback ,x-1004 ,y-1005))

(define-macro (py-imul-bintX-bintY-inline x-1007 y-1008)
  `(py-imul-bintX-bintY-fallback ,x-1007 ,y-1008))

(define-macro (py-ipow-floatX-floatY-inline x-1010 y-1011)
  `(let ((x-1010 ,x-1010) (y-1011 ,y-1011))
     (py-float-from-scheme
      (py** (py-float-to-scheme x-1010) (py-float-to-scheme y-1011)))))

(define-macro (py-ipow-floatX-boolY-inline x-1013 y-1014)
  `(py-ipow-floatX-boolY-fallback ,x-1013 ,y-1014))

(define-macro (py-ipow-floatX-sintY-inline x-1016 y-1017)
  `(let ((x-1016 ,x-1016) (y-1017 ,y-1017))
     (py-float-from-scheme
      (py** (py-float-to-scheme x-1016) (py-sint-to-scheme y-1017)))))

(define-macro (py-ipow-floatX-bintY-inline x-1019 y-1020)
  `(py-ipow-floatX-bintY-fallback ,x-1019 ,y-1020))

(define-macro (py-ipow-boolX-floatY-inline x-1022 y-1023)
  `(py-ipow-boolX-floatY-fallback ,x-1022 ,y-1023))

(define-macro (py-ipow-boolX-boolY-inline x-1025 y-1026)
  `(py-ipow-boolX-boolY-fallback ,x-1025 ,y-1026))

(define-macro (py-ipow-boolX-sintY-inline x-1028 y-1029)
  `(py-ipow-boolX-sintY-fallback ,x-1028 ,y-1029))

(define-macro (py-ipow-boolX-bintY-inline x-1031 y-1032)
  `(py-ipow-boolX-bintY-fallback ,x-1031 ,y-1032))

(define-macro (py-ipow-sintX-floatY-inline x-1034 y-1035)
  `(let ((x-1034 ,x-1034) (y-1035 ,y-1035))
     (py-float-from-scheme
      (py** (py-sint-to-scheme x-1034) (py-float-to-scheme y-1035)))))

(define-macro (py-ipow-sintX-boolY-inline x-1037 y-1038)
  `(py-ipow-sintX-boolY-fallback ,x-1037 ,y-1038))

(define-macro (py-ipow-sintX-sintY-inline x-1040 y-1041)
  `(let ((x-1040 ,x-1040) (y-1041 ,y-1041))
     (py-int-from-scheme
      (py** (py-sint-to-scheme x-1040) (py-sint-to-scheme y-1041)))))

(define-macro (py-ipow-sintX-bintY-inline x-1043 y-1044)
  `(py-ipow-sintX-bintY-fallback ,x-1043 ,y-1044))

(define-macro (py-ipow-bintX-floatY-inline x-1046 y-1047)
  `(py-ipow-bintX-floatY-fallback ,x-1046 ,y-1047))

(define-macro (py-ipow-bintX-boolY-inline x-1049 y-1050)
  `(py-ipow-bintX-boolY-fallback ,x-1049 ,y-1050))

(define-macro (py-ipow-bintX-sintY-inline x-1052 y-1053)
  `(py-ipow-bintX-sintY-fallback ,x-1052 ,y-1053))

(define-macro (py-ipow-bintX-bintY-inline x-1055 y-1056)
  `(py-ipow-bintX-bintY-fallback ,x-1055 ,y-1056))

(define-macro (py-irshift-floatX-floatY-inline x-1058 y-1059)
  `(let ((x-1058 ,x-1058) (y-1059 ,y-1059))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for >>=: 'float' and 'float'")))))

(define-macro (py-irshift-floatX-boolY-inline x-1061 y-1062)
  `(py-irshift-floatX-boolY-fallback ,x-1061 ,y-1062))

(define-macro (py-irshift-floatX-sintY-inline x-1064 y-1065)
  `(let ((x-1064 ,x-1064) (y-1065 ,y-1065))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for >>=: 'float' and 'int'")))))

(define-macro (py-irshift-floatX-bintY-inline x-1067 y-1068)
  `(py-irshift-floatX-bintY-fallback ,x-1067 ,y-1068))

(define-macro (py-irshift-boolX-floatY-inline x-1070 y-1071)
  `(py-irshift-boolX-floatY-fallback ,x-1070 ,y-1071))

(define-macro (py-irshift-boolX-boolY-inline x-1073 y-1074)
  `(py-irshift-boolX-boolY-fallback ,x-1073 ,y-1074))

(define-macro (py-irshift-boolX-sintY-inline x-1076 y-1077)
  `(py-irshift-boolX-sintY-fallback ,x-1076 ,y-1077))

(define-macro (py-irshift-boolX-bintY-inline x-1079 y-1080)
  `(py-irshift-boolX-bintY-fallback ,x-1079 ,y-1080))

(define-macro (py-irshift-sintX-floatY-inline x-1082 y-1083)
  `(let ((x-1082 ,x-1082) (y-1083 ,y-1083))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for >>=: 'int' and 'float'")))))

(define-macro (py-irshift-sintX-boolY-inline x-1085 y-1086)
  `(py-irshift-sintX-boolY-fallback ,x-1085 ,y-1086))

(define-macro (py-irshift-sintX-sintY-inline x-1088 y-1089)
  `(let ((x-1088 ,x-1088) (y-1089 ,y-1089))
     (if (py-test (py-ge y-1089 (py-int-from-scheme 0)))
         (py-int-from-scheme
          (py>> (py-sint-to-scheme x-1088) (py-sint-to-scheme y-1089)))
         (py-throw
          (py-call py-builtin-ValueError (&& "negative shift count"))))))

(define-macro (py-irshift-sintX-bintY-inline x-1091 y-1092)
  `(py-irshift-sintX-bintY-fallback ,x-1091 ,y-1092))

(define-macro (py-irshift-bintX-floatY-inline x-1094 y-1095)
  `(py-irshift-bintX-floatY-fallback ,x-1094 ,y-1095))

(define-macro (py-irshift-bintX-boolY-inline x-1097 y-1098)
  `(py-irshift-bintX-boolY-fallback ,x-1097 ,y-1098))

(define-macro (py-irshift-bintX-sintY-inline x-1100 y-1101)
  `(py-irshift-bintX-sintY-fallback ,x-1100 ,y-1101))

(define-macro (py-irshift-bintX-bintY-inline x-1103 y-1104)
  `(py-irshift-bintX-bintY-fallback ,x-1103 ,y-1104))

(define-macro (py-isub-floatX-floatY-inline x-1106 y-1107)
  `(let ((x-1106 ,x-1106) (y-1107 ,y-1107))
     (py-float-from-scheme
      (py- (py-float-to-scheme x-1106) (py-float-to-scheme y-1107)))))

(define-macro (py-isub-floatX-boolY-inline x-1109 y-1110)
  `(py-isub-floatX-boolY-fallback ,x-1109 ,y-1110))

(define-macro (py-isub-floatX-sintY-inline x-1112 y-1113)
  `(let ((x-1112 ,x-1112) (y-1113 ,y-1113))
     (py-float-from-scheme
      (py- (py-float-to-scheme x-1112) (py-sint-to-scheme y-1113)))))

(define-macro (py-isub-floatX-bintY-inline x-1115 y-1116)
  `(py-isub-floatX-bintY-fallback ,x-1115 ,y-1116))

(define-macro (py-isub-boolX-floatY-inline x-1118 y-1119)
  `(py-isub-boolX-floatY-fallback ,x-1118 ,y-1119))

(define-macro (py-isub-boolX-boolY-inline x-1121 y-1122)
  `(py-isub-boolX-boolY-fallback ,x-1121 ,y-1122))

(define-macro (py-isub-boolX-sintY-inline x-1124 y-1125)
  `(py-isub-boolX-sintY-fallback ,x-1124 ,y-1125))

(define-macro (py-isub-boolX-bintY-inline x-1127 y-1128)
  `(py-isub-boolX-bintY-fallback ,x-1127 ,y-1128))

(define-macro (py-isub-sintX-floatY-inline x-1130 y-1131)
  `(let ((x-1130 ,x-1130) (y-1131 ,y-1131))
     (py-float-from-scheme
      (py- (py-sint-to-scheme x-1130) (py-float-to-scheme y-1131)))))

(define-macro (py-isub-sintX-boolY-inline x-1133 y-1134)
  `(py-isub-sintX-boolY-fallback ,x-1133 ,y-1134))

(define-macro (py-isub-sintX-sintY-inline x-1136 y-1137)
  `(let ((x-1136 ,x-1136) (y-1137 ,y-1137))
     (py-int-from-scheme
      (py- (py-sint-to-scheme x-1136) (py-sint-to-scheme y-1137)))))

(define-macro (py-isub-sintX-bintY-inline x-1139 y-1140)
  `(py-isub-sintX-bintY-fallback ,x-1139 ,y-1140))

(define-macro (py-isub-bintX-floatY-inline x-1142 y-1143)
  `(py-isub-bintX-floatY-fallback ,x-1142 ,y-1143))

(define-macro (py-isub-bintX-boolY-inline x-1145 y-1146)
  `(py-isub-bintX-boolY-fallback ,x-1145 ,y-1146))

(define-macro (py-isub-bintX-sintY-inline x-1148 y-1149)
  `(py-isub-bintX-sintY-fallback ,x-1148 ,y-1149))

(define-macro (py-isub-bintX-bintY-inline x-1151 y-1152)
  `(py-isub-bintX-bintY-fallback ,x-1151 ,y-1152))

(define-macro (py-itruediv-floatX-floatY-inline x-1154 y-1155)
  `(let ((x-1154 ,x-1154) (y-1155 ,y-1155))
     (if (py-test (py-ne y-1155 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py/ (py-float-to-scheme x-1154) (py-float-to-scheme y-1155)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-itruediv-floatX-boolY-inline x-1157 y-1158)
  `(py-itruediv-floatX-boolY-fallback ,x-1157 ,y-1158))

(define-macro (py-itruediv-floatX-sintY-inline x-1160 y-1161)
  `(let ((x-1160 ,x-1160) (y-1161 ,y-1161))
     (if (py-test (py-ne y-1161 (py-int-from-scheme 0)))
         (py-float-from-scheme
          (py/ (py-float-to-scheme x-1160) (py-sint-to-scheme y-1161)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-itruediv-floatX-bintY-inline x-1163 y-1164)
  `(py-itruediv-floatX-bintY-fallback ,x-1163 ,y-1164))

(define-macro (py-itruediv-boolX-floatY-inline x-1166 y-1167)
  `(py-itruediv-boolX-floatY-fallback ,x-1166 ,y-1167))

(define-macro (py-itruediv-boolX-boolY-inline x-1169 y-1170)
  `(py-itruediv-boolX-boolY-fallback ,x-1169 ,y-1170))

(define-macro (py-itruediv-boolX-sintY-inline x-1172 y-1173)
  `(py-itruediv-boolX-sintY-fallback ,x-1172 ,y-1173))

(define-macro (py-itruediv-boolX-bintY-inline x-1175 y-1176)
  `(py-itruediv-boolX-bintY-fallback ,x-1175 ,y-1176))

(define-macro (py-itruediv-sintX-floatY-inline x-1178 y-1179)
  `(let ((x-1178 ,x-1178) (y-1179 ,y-1179))
     (if (py-test (py-ne y-1179 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py/ (py-sint-to-scheme x-1178) (py-float-to-scheme y-1179)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-itruediv-sintX-boolY-inline x-1181 y-1182)
  `(py-itruediv-sintX-boolY-fallback ,x-1181 ,y-1182))

(define-macro (py-itruediv-sintX-sintY-inline x-1184 y-1185)
  `(let ((x-1184 ,x-1184) (y-1185 ,y-1185))
     (if (py-test (py-ne y-1185 (py-int-from-scheme 0)))
         (py-float-from-scheme
          (py/ (py-sint-to-scheme x-1184) (py-sint-to-scheme y-1185)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError (&& "division by zero"))))))

(define-macro (py-itruediv-sintX-bintY-inline x-1187 y-1188)
  `(py-itruediv-sintX-bintY-fallback ,x-1187 ,y-1188))

(define-macro (py-itruediv-bintX-floatY-inline x-1190 y-1191)
  `(py-itruediv-bintX-floatY-fallback ,x-1190 ,y-1191))

(define-macro (py-itruediv-bintX-boolY-inline x-1193 y-1194)
  `(py-itruediv-bintX-boolY-fallback ,x-1193 ,y-1194))

(define-macro (py-itruediv-bintX-sintY-inline x-1196 y-1197)
  `(py-itruediv-bintX-sintY-fallback ,x-1196 ,y-1197))

(define-macro (py-itruediv-bintX-bintY-inline x-1199 y-1200)
  `(py-itruediv-bintX-bintY-fallback ,x-1199 ,y-1200))

(define-macro (py-ixor-floatX-floatY-inline x-1202 y-1203)
  `(let ((x-1202 ,x-1202) (y-1203 ,y-1203))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for ^=: 'float' and 'float'")))))

(define-macro (py-ixor-floatX-boolY-inline x-1205 y-1206)
  `(py-ixor-floatX-boolY-fallback ,x-1205 ,y-1206))

(define-macro (py-ixor-floatX-sintY-inline x-1208 y-1209)
  `(let ((x-1208 ,x-1208) (y-1209 ,y-1209))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for ^=: 'float' and 'int'")))))

(define-macro (py-ixor-floatX-bintY-inline x-1211 y-1212)
  `(py-ixor-floatX-bintY-fallback ,x-1211 ,y-1212))

(define-macro (py-ixor-boolX-floatY-inline x-1214 y-1215)
  `(py-ixor-boolX-floatY-fallback ,x-1214 ,y-1215))

(define-macro (py-ixor-boolX-boolY-inline x-1217 y-1218)
  `(py-ixor-boolX-boolY-fallback ,x-1217 ,y-1218))

(define-macro (py-ixor-boolX-sintY-inline x-1220 y-1221)
  `(py-ixor-boolX-sintY-fallback ,x-1220 ,y-1221))

(define-macro (py-ixor-boolX-bintY-inline x-1223 y-1224)
  `(py-ixor-boolX-bintY-fallback ,x-1223 ,y-1224))

(define-macro (py-ixor-sintX-floatY-inline x-1226 y-1227)
  `(let ((x-1226 ,x-1226) (y-1227 ,y-1227))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for ^=: 'int' and 'float'")))))

(define-macro (py-ixor-sintX-boolY-inline x-1229 y-1230)
  `(py-ixor-sintX-boolY-fallback ,x-1229 ,y-1230))

(define-macro (py-ixor-sintX-sintY-inline x-1232 y-1233)
  `(let ((x-1232 ,x-1232) (y-1233 ,y-1233))
     (py-int-from-scheme
      (py^ (py-sint-to-scheme x-1232) (py-sint-to-scheme y-1233)))))

(define-macro (py-ixor-sintX-bintY-inline x-1235 y-1236)
  `(py-ixor-sintX-bintY-fallback ,x-1235 ,y-1236))

(define-macro (py-ixor-bintX-floatY-inline x-1238 y-1239)
  `(py-ixor-bintX-floatY-fallback ,x-1238 ,y-1239))

(define-macro (py-ixor-bintX-boolY-inline x-1241 y-1242)
  `(py-ixor-bintX-boolY-fallback ,x-1241 ,y-1242))

(define-macro (py-ixor-bintX-sintY-inline x-1244 y-1245)
  `(py-ixor-bintX-sintY-fallback ,x-1244 ,y-1245))

(define-macro (py-ixor-bintX-bintY-inline x-1247 y-1248)
  `(py-ixor-bintX-bintY-fallback ,x-1247 ,y-1248))

(define-macro (py-ge-floatX-floatY-inline x-1250 y-1251)
  `(let ((x-1250 ,x-1250) (y-1251 ,y-1251))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py>= (py-float-to-scheme x-1250) (py-float-to-scheme y-1251))))))

(define-macro (py-test-ge-floatX-floatY-inline x-1253 y-1254)
  `(let ((x-1253 ,x-1253) (y-1254 ,y-1254))
     (py-test-from-scheme
      (py>= (py-float-to-scheme x-1253) (py-float-to-scheme y-1254)))))

(define-macro (py-ge-floatX-boolY-inline x-1256 y-1257)
  `(py-ge-floatX-boolY-fallback ,x-1256 ,y-1257))

(define-macro (py-test-ge-floatX-boolY-inline x-1259 y-1260)
  `(py-test-ge-floatX-boolY-fallback ,x-1259 ,y-1260))

(define-macro (py-ge-floatX-sintY-inline x-1262 y-1263)
  `(let ((x-1262 ,x-1262) (y-1263 ,y-1263))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py>= (py-float-to-scheme x-1262) (py-sint-to-scheme y-1263))))))

(define-macro (py-test-ge-floatX-sintY-inline x-1265 y-1266)
  `(let ((x-1265 ,x-1265) (y-1266 ,y-1266))
     (py-test-from-scheme
      (py>= (py-float-to-scheme x-1265) (py-sint-to-scheme y-1266)))))

(define-macro (py-ge-floatX-bintY-inline x-1268 y-1269)
  `(py-ge-floatX-bintY-fallback ,x-1268 ,y-1269))

(define-macro (py-test-ge-floatX-bintY-inline x-1271 y-1272)
  `(py-test-ge-floatX-bintY-fallback ,x-1271 ,y-1272))

(define-macro (py-ge-boolX-floatY-inline x-1274 y-1275)
  `(py-ge-boolX-floatY-fallback ,x-1274 ,y-1275))

(define-macro (py-test-ge-boolX-floatY-inline x-1277 y-1278)
  `(py-test-ge-boolX-floatY-fallback ,x-1277 ,y-1278))

(define-macro (py-ge-boolX-boolY-inline x-1280 y-1281)
  `(py-ge-boolX-boolY-fallback ,x-1280 ,y-1281))

(define-macro (py-test-ge-boolX-boolY-inline x-1283 y-1284)
  `(py-test-ge-boolX-boolY-fallback ,x-1283 ,y-1284))

(define-macro (py-ge-boolX-sintY-inline x-1286 y-1287)
  `(py-ge-boolX-sintY-fallback ,x-1286 ,y-1287))

(define-macro (py-test-ge-boolX-sintY-inline x-1289 y-1290)
  `(py-test-ge-boolX-sintY-fallback ,x-1289 ,y-1290))

(define-macro (py-ge-boolX-bintY-inline x-1292 y-1293)
  `(py-ge-boolX-bintY-fallback ,x-1292 ,y-1293))

(define-macro (py-test-ge-boolX-bintY-inline x-1295 y-1296)
  `(py-test-ge-boolX-bintY-fallback ,x-1295 ,y-1296))

(define-macro (py-ge-sintX-floatY-inline x-1298 y-1299)
  `(let ((x-1298 ,x-1298) (y-1299 ,y-1299))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py<= (py-float-to-scheme y-1299) (py-sint-to-scheme x-1298))))))

(define-macro (py-test-ge-sintX-floatY-inline x-1301 y-1302)
  `(let ((x-1301 ,x-1301) (y-1302 ,y-1302))
     (py-test-from-scheme
      (py<= (py-float-to-scheme y-1302) (py-sint-to-scheme x-1301)))))

(define-macro (py-ge-sintX-boolY-inline x-1304 y-1305)
  `(py-ge-sintX-boolY-fallback ,x-1304 ,y-1305))

(define-macro (py-test-ge-sintX-boolY-inline x-1307 y-1308)
  `(py-test-ge-sintX-boolY-fallback ,x-1307 ,y-1308))

(define-macro (py-ge-sintX-sintY-inline x-1310 y-1311)
  `(let ((x-1310 ,x-1310) (y-1311 ,y-1311))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py>= (py-sint-to-scheme x-1310) (py-sint-to-scheme y-1311))))))

(define-macro (py-test-ge-sintX-sintY-inline x-1313 y-1314)
  `(let ((x-1313 ,x-1313) (y-1314 ,y-1314))
     (py-test-from-scheme
      (py>= (py-sint-to-scheme x-1313) (py-sint-to-scheme y-1314)))))

(define-macro (py-ge-sintX-bintY-inline x-1316 y-1317)
  `(py-ge-sintX-bintY-fallback ,x-1316 ,y-1317))

(define-macro (py-test-ge-sintX-bintY-inline x-1319 y-1320)
  `(py-test-ge-sintX-bintY-fallback ,x-1319 ,y-1320))

(define-macro (py-ge-bintX-floatY-inline x-1322 y-1323)
  `(py-ge-bintX-floatY-fallback ,x-1322 ,y-1323))

(define-macro (py-test-ge-bintX-floatY-inline x-1325 y-1326)
  `(py-test-ge-bintX-floatY-fallback ,x-1325 ,y-1326))

(define-macro (py-ge-bintX-boolY-inline x-1328 y-1329)
  `(py-ge-bintX-boolY-fallback ,x-1328 ,y-1329))

(define-macro (py-test-ge-bintX-boolY-inline x-1331 y-1332)
  `(py-test-ge-bintX-boolY-fallback ,x-1331 ,y-1332))

(define-macro (py-ge-bintX-sintY-inline x-1334 y-1335)
  `(py-ge-bintX-sintY-fallback ,x-1334 ,y-1335))

(define-macro (py-test-ge-bintX-sintY-inline x-1337 y-1338)
  `(py-test-ge-bintX-sintY-fallback ,x-1337 ,y-1338))

(define-macro (py-ge-bintX-bintY-inline x-1340 y-1341)
  `(py-ge-bintX-bintY-fallback ,x-1340 ,y-1341))

(define-macro (py-test-ge-bintX-bintY-inline x-1343 y-1344)
  `(py-test-ge-bintX-bintY-fallback ,x-1343 ,y-1344))

(define-macro (py-gt-floatX-floatY-inline x-1346 y-1347)
  `(let ((x-1346 ,x-1346) (y-1347 ,y-1347))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py> (py-float-to-scheme x-1346) (py-float-to-scheme y-1347))))))

(define-macro (py-test-gt-floatX-floatY-inline x-1349 y-1350)
  `(let ((x-1349 ,x-1349) (y-1350 ,y-1350))
     (py-test-from-scheme
      (py> (py-float-to-scheme x-1349) (py-float-to-scheme y-1350)))))

(define-macro (py-gt-floatX-boolY-inline x-1352 y-1353)
  `(py-gt-floatX-boolY-fallback ,x-1352 ,y-1353))

(define-macro (py-test-gt-floatX-boolY-inline x-1355 y-1356)
  `(py-test-gt-floatX-boolY-fallback ,x-1355 ,y-1356))

(define-macro (py-gt-floatX-sintY-inline x-1358 y-1359)
  `(let ((x-1358 ,x-1358) (y-1359 ,y-1359))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py> (py-float-to-scheme x-1358) (py-sint-to-scheme y-1359))))))

(define-macro (py-test-gt-floatX-sintY-inline x-1361 y-1362)
  `(let ((x-1361 ,x-1361) (y-1362 ,y-1362))
     (py-test-from-scheme
      (py> (py-float-to-scheme x-1361) (py-sint-to-scheme y-1362)))))

(define-macro (py-gt-floatX-bintY-inline x-1364 y-1365)
  `(py-gt-floatX-bintY-fallback ,x-1364 ,y-1365))

(define-macro (py-test-gt-floatX-bintY-inline x-1367 y-1368)
  `(py-test-gt-floatX-bintY-fallback ,x-1367 ,y-1368))

(define-macro (py-gt-boolX-floatY-inline x-1370 y-1371)
  `(py-gt-boolX-floatY-fallback ,x-1370 ,y-1371))

(define-macro (py-test-gt-boolX-floatY-inline x-1373 y-1374)
  `(py-test-gt-boolX-floatY-fallback ,x-1373 ,y-1374))

(define-macro (py-gt-boolX-boolY-inline x-1376 y-1377)
  `(py-gt-boolX-boolY-fallback ,x-1376 ,y-1377))

(define-macro (py-test-gt-boolX-boolY-inline x-1379 y-1380)
  `(py-test-gt-boolX-boolY-fallback ,x-1379 ,y-1380))

(define-macro (py-gt-boolX-sintY-inline x-1382 y-1383)
  `(py-gt-boolX-sintY-fallback ,x-1382 ,y-1383))

(define-macro (py-test-gt-boolX-sintY-inline x-1385 y-1386)
  `(py-test-gt-boolX-sintY-fallback ,x-1385 ,y-1386))

(define-macro (py-gt-boolX-bintY-inline x-1388 y-1389)
  `(py-gt-boolX-bintY-fallback ,x-1388 ,y-1389))

(define-macro (py-test-gt-boolX-bintY-inline x-1391 y-1392)
  `(py-test-gt-boolX-bintY-fallback ,x-1391 ,y-1392))

(define-macro (py-gt-sintX-floatY-inline x-1394 y-1395)
  `(let ((x-1394 ,x-1394) (y-1395 ,y-1395))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py< (py-float-to-scheme y-1395) (py-sint-to-scheme x-1394))))))

(define-macro (py-test-gt-sintX-floatY-inline x-1397 y-1398)
  `(let ((x-1397 ,x-1397) (y-1398 ,y-1398))
     (py-test-from-scheme
      (py< (py-float-to-scheme y-1398) (py-sint-to-scheme x-1397)))))

(define-macro (py-gt-sintX-boolY-inline x-1400 y-1401)
  `(py-gt-sintX-boolY-fallback ,x-1400 ,y-1401))

(define-macro (py-test-gt-sintX-boolY-inline x-1403 y-1404)
  `(py-test-gt-sintX-boolY-fallback ,x-1403 ,y-1404))

(define-macro (py-gt-sintX-sintY-inline x-1406 y-1407)
  `(let ((x-1406 ,x-1406) (y-1407 ,y-1407))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py> (py-sint-to-scheme x-1406) (py-sint-to-scheme y-1407))))))

(define-macro (py-test-gt-sintX-sintY-inline x-1409 y-1410)
  `(let ((x-1409 ,x-1409) (y-1410 ,y-1410))
     (py-test-from-scheme
      (py> (py-sint-to-scheme x-1409) (py-sint-to-scheme y-1410)))))

(define-macro (py-gt-sintX-bintY-inline x-1412 y-1413)
  `(py-gt-sintX-bintY-fallback ,x-1412 ,y-1413))

(define-macro (py-test-gt-sintX-bintY-inline x-1415 y-1416)
  `(py-test-gt-sintX-bintY-fallback ,x-1415 ,y-1416))

(define-macro (py-gt-bintX-floatY-inline x-1418 y-1419)
  `(py-gt-bintX-floatY-fallback ,x-1418 ,y-1419))

(define-macro (py-test-gt-bintX-floatY-inline x-1421 y-1422)
  `(py-test-gt-bintX-floatY-fallback ,x-1421 ,y-1422))

(define-macro (py-gt-bintX-boolY-inline x-1424 y-1425)
  `(py-gt-bintX-boolY-fallback ,x-1424 ,y-1425))

(define-macro (py-test-gt-bintX-boolY-inline x-1427 y-1428)
  `(py-test-gt-bintX-boolY-fallback ,x-1427 ,y-1428))

(define-macro (py-gt-bintX-sintY-inline x-1430 y-1431)
  `(py-gt-bintX-sintY-fallback ,x-1430 ,y-1431))

(define-macro (py-test-gt-bintX-sintY-inline x-1433 y-1434)
  `(py-test-gt-bintX-sintY-fallback ,x-1433 ,y-1434))

(define-macro (py-gt-bintX-bintY-inline x-1436 y-1437)
  `(py-gt-bintX-bintY-fallback ,x-1436 ,y-1437))

(define-macro (py-test-gt-bintX-bintY-inline x-1439 y-1440)
  `(py-test-gt-bintX-bintY-fallback ,x-1439 ,y-1440))

(define-macro (py-le-floatX-floatY-inline x-1442 y-1443)
  `(let ((x-1442 ,x-1442) (y-1443 ,y-1443))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py<= (py-float-to-scheme x-1442) (py-float-to-scheme y-1443))))))

(define-macro (py-test-le-floatX-floatY-inline x-1445 y-1446)
  `(let ((x-1445 ,x-1445) (y-1446 ,y-1446))
     (py-test-from-scheme
      (py<= (py-float-to-scheme x-1445) (py-float-to-scheme y-1446)))))

(define-macro (py-le-floatX-boolY-inline x-1448 y-1449)
  `(py-le-floatX-boolY-fallback ,x-1448 ,y-1449))

(define-macro (py-test-le-floatX-boolY-inline x-1451 y-1452)
  `(py-test-le-floatX-boolY-fallback ,x-1451 ,y-1452))

(define-macro (py-le-floatX-sintY-inline x-1454 y-1455)
  `(let ((x-1454 ,x-1454) (y-1455 ,y-1455))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py<= (py-float-to-scheme x-1454) (py-sint-to-scheme y-1455))))))

(define-macro (py-test-le-floatX-sintY-inline x-1457 y-1458)
  `(let ((x-1457 ,x-1457) (y-1458 ,y-1458))
     (py-test-from-scheme
      (py<= (py-float-to-scheme x-1457) (py-sint-to-scheme y-1458)))))

(define-macro (py-le-floatX-bintY-inline x-1460 y-1461)
  `(py-le-floatX-bintY-fallback ,x-1460 ,y-1461))

(define-macro (py-test-le-floatX-bintY-inline x-1463 y-1464)
  `(py-test-le-floatX-bintY-fallback ,x-1463 ,y-1464))

(define-macro (py-le-boolX-floatY-inline x-1466 y-1467)
  `(py-le-boolX-floatY-fallback ,x-1466 ,y-1467))

(define-macro (py-test-le-boolX-floatY-inline x-1469 y-1470)
  `(py-test-le-boolX-floatY-fallback ,x-1469 ,y-1470))

(define-macro (py-le-boolX-boolY-inline x-1472 y-1473)
  `(py-le-boolX-boolY-fallback ,x-1472 ,y-1473))

(define-macro (py-test-le-boolX-boolY-inline x-1475 y-1476)
  `(py-test-le-boolX-boolY-fallback ,x-1475 ,y-1476))

(define-macro (py-le-boolX-sintY-inline x-1478 y-1479)
  `(py-le-boolX-sintY-fallback ,x-1478 ,y-1479))

(define-macro (py-test-le-boolX-sintY-inline x-1481 y-1482)
  `(py-test-le-boolX-sintY-fallback ,x-1481 ,y-1482))

(define-macro (py-le-boolX-bintY-inline x-1484 y-1485)
  `(py-le-boolX-bintY-fallback ,x-1484 ,y-1485))

(define-macro (py-test-le-boolX-bintY-inline x-1487 y-1488)
  `(py-test-le-boolX-bintY-fallback ,x-1487 ,y-1488))

(define-macro (py-le-sintX-floatY-inline x-1490 y-1491)
  `(let ((x-1490 ,x-1490) (y-1491 ,y-1491))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py>= (py-float-to-scheme y-1491) (py-sint-to-scheme x-1490))))))

(define-macro (py-test-le-sintX-floatY-inline x-1493 y-1494)
  `(let ((x-1493 ,x-1493) (y-1494 ,y-1494))
     (py-test-from-scheme
      (py>= (py-float-to-scheme y-1494) (py-sint-to-scheme x-1493)))))

(define-macro (py-le-sintX-boolY-inline x-1496 y-1497)
  `(py-le-sintX-boolY-fallback ,x-1496 ,y-1497))

(define-macro (py-test-le-sintX-boolY-inline x-1499 y-1500)
  `(py-test-le-sintX-boolY-fallback ,x-1499 ,y-1500))

(define-macro (py-le-sintX-sintY-inline x-1502 y-1503)
  `(let ((x-1502 ,x-1502) (y-1503 ,y-1503))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py<= (py-sint-to-scheme x-1502) (py-sint-to-scheme y-1503))))))

(define-macro (py-test-le-sintX-sintY-inline x-1505 y-1506)
  `(let ((x-1505 ,x-1505) (y-1506 ,y-1506))
     (py-test-from-scheme
      (py<= (py-sint-to-scheme x-1505) (py-sint-to-scheme y-1506)))))

(define-macro (py-le-sintX-bintY-inline x-1508 y-1509)
  `(py-le-sintX-bintY-fallback ,x-1508 ,y-1509))

(define-macro (py-test-le-sintX-bintY-inline x-1511 y-1512)
  `(py-test-le-sintX-bintY-fallback ,x-1511 ,y-1512))

(define-macro (py-le-bintX-floatY-inline x-1514 y-1515)
  `(py-le-bintX-floatY-fallback ,x-1514 ,y-1515))

(define-macro (py-test-le-bintX-floatY-inline x-1517 y-1518)
  `(py-test-le-bintX-floatY-fallback ,x-1517 ,y-1518))

(define-macro (py-le-bintX-boolY-inline x-1520 y-1521)
  `(py-le-bintX-boolY-fallback ,x-1520 ,y-1521))

(define-macro (py-test-le-bintX-boolY-inline x-1523 y-1524)
  `(py-test-le-bintX-boolY-fallback ,x-1523 ,y-1524))

(define-macro (py-le-bintX-sintY-inline x-1526 y-1527)
  `(py-le-bintX-sintY-fallback ,x-1526 ,y-1527))

(define-macro (py-test-le-bintX-sintY-inline x-1529 y-1530)
  `(py-test-le-bintX-sintY-fallback ,x-1529 ,y-1530))

(define-macro (py-le-bintX-bintY-inline x-1532 y-1533)
  `(py-le-bintX-bintY-fallback ,x-1532 ,y-1533))

(define-macro (py-test-le-bintX-bintY-inline x-1535 y-1536)
  `(py-test-le-bintX-bintY-fallback ,x-1535 ,y-1536))

(define-macro (py-lt-floatX-floatY-inline x-1538 y-1539)
  `(let ((x-1538 ,x-1538) (y-1539 ,y-1539))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py< (py-float-to-scheme x-1538) (py-float-to-scheme y-1539))))))

(define-macro (py-test-lt-floatX-floatY-inline x-1541 y-1542)
  `(let ((x-1541 ,x-1541) (y-1542 ,y-1542))
     (py-test-from-scheme
      (py< (py-float-to-scheme x-1541) (py-float-to-scheme y-1542)))))

(define-macro (py-lt-floatX-boolY-inline x-1544 y-1545)
  `(py-lt-floatX-boolY-fallback ,x-1544 ,y-1545))

(define-macro (py-test-lt-floatX-boolY-inline x-1547 y-1548)
  `(py-test-lt-floatX-boolY-fallback ,x-1547 ,y-1548))

(define-macro (py-lt-floatX-sintY-inline x-1550 y-1551)
  `(let ((x-1550 ,x-1550) (y-1551 ,y-1551))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py< (py-float-to-scheme x-1550) (py-sint-to-scheme y-1551))))))

(define-macro (py-test-lt-floatX-sintY-inline x-1553 y-1554)
  `(let ((x-1553 ,x-1553) (y-1554 ,y-1554))
     (py-test-from-scheme
      (py< (py-float-to-scheme x-1553) (py-sint-to-scheme y-1554)))))

(define-macro (py-lt-floatX-bintY-inline x-1556 y-1557)
  `(py-lt-floatX-bintY-fallback ,x-1556 ,y-1557))

(define-macro (py-test-lt-floatX-bintY-inline x-1559 y-1560)
  `(py-test-lt-floatX-bintY-fallback ,x-1559 ,y-1560))

(define-macro (py-lt-boolX-floatY-inline x-1562 y-1563)
  `(py-lt-boolX-floatY-fallback ,x-1562 ,y-1563))

(define-macro (py-test-lt-boolX-floatY-inline x-1565 y-1566)
  `(py-test-lt-boolX-floatY-fallback ,x-1565 ,y-1566))

(define-macro (py-lt-boolX-boolY-inline x-1568 y-1569)
  `(py-lt-boolX-boolY-fallback ,x-1568 ,y-1569))

(define-macro (py-test-lt-boolX-boolY-inline x-1571 y-1572)
  `(py-test-lt-boolX-boolY-fallback ,x-1571 ,y-1572))

(define-macro (py-lt-boolX-sintY-inline x-1574 y-1575)
  `(py-lt-boolX-sintY-fallback ,x-1574 ,y-1575))

(define-macro (py-test-lt-boolX-sintY-inline x-1577 y-1578)
  `(py-test-lt-boolX-sintY-fallback ,x-1577 ,y-1578))

(define-macro (py-lt-boolX-bintY-inline x-1580 y-1581)
  `(py-lt-boolX-bintY-fallback ,x-1580 ,y-1581))

(define-macro (py-test-lt-boolX-bintY-inline x-1583 y-1584)
  `(py-test-lt-boolX-bintY-fallback ,x-1583 ,y-1584))

(define-macro (py-lt-sintX-floatY-inline x-1586 y-1587)
  `(let ((x-1586 ,x-1586) (y-1587 ,y-1587))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py> (py-float-to-scheme y-1587) (py-sint-to-scheme x-1586))))))

(define-macro (py-test-lt-sintX-floatY-inline x-1589 y-1590)
  `(let ((x-1589 ,x-1589) (y-1590 ,y-1590))
     (py-test-from-scheme
      (py> (py-float-to-scheme y-1590) (py-sint-to-scheme x-1589)))))

(define-macro (py-lt-sintX-boolY-inline x-1592 y-1593)
  `(py-lt-sintX-boolY-fallback ,x-1592 ,y-1593))

(define-macro (py-test-lt-sintX-boolY-inline x-1595 y-1596)
  `(py-test-lt-sintX-boolY-fallback ,x-1595 ,y-1596))

(define-macro (py-lt-sintX-sintY-inline x-1598 y-1599)
  `(let ((x-1598 ,x-1598) (y-1599 ,y-1599))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py< (py-sint-to-scheme x-1598) (py-sint-to-scheme y-1599))))))

(define-macro (py-test-lt-sintX-sintY-inline x-1601 y-1602)
  `(let ((x-1601 ,x-1601) (y-1602 ,y-1602))
     (py-test-from-scheme
      (py< (py-sint-to-scheme x-1601) (py-sint-to-scheme y-1602)))))

(define-macro (py-lt-sintX-bintY-inline x-1604 y-1605)
  `(py-lt-sintX-bintY-fallback ,x-1604 ,y-1605))

(define-macro (py-test-lt-sintX-bintY-inline x-1607 y-1608)
  `(py-test-lt-sintX-bintY-fallback ,x-1607 ,y-1608))

(define-macro (py-lt-bintX-floatY-inline x-1610 y-1611)
  `(py-lt-bintX-floatY-fallback ,x-1610 ,y-1611))

(define-macro (py-test-lt-bintX-floatY-inline x-1613 y-1614)
  `(py-test-lt-bintX-floatY-fallback ,x-1613 ,y-1614))

(define-macro (py-lt-bintX-boolY-inline x-1616 y-1617)
  `(py-lt-bintX-boolY-fallback ,x-1616 ,y-1617))

(define-macro (py-test-lt-bintX-boolY-inline x-1619 y-1620)
  `(py-test-lt-bintX-boolY-fallback ,x-1619 ,y-1620))

(define-macro (py-lt-bintX-sintY-inline x-1622 y-1623)
  `(py-lt-bintX-sintY-fallback ,x-1622 ,y-1623))

(define-macro (py-test-lt-bintX-sintY-inline x-1625 y-1626)
  `(py-test-lt-bintX-sintY-fallback ,x-1625 ,y-1626))

(define-macro (py-lt-bintX-bintY-inline x-1628 y-1629)
  `(py-lt-bintX-bintY-fallback ,x-1628 ,y-1629))

(define-macro (py-test-lt-bintX-bintY-inline x-1631 y-1632)
  `(py-test-lt-bintX-bintY-fallback ,x-1631 ,y-1632))

(define-macro (py-eq-floatX-floatY-inline x-1634 y-1635)
  `(let ((x-1634 ,x-1634) (y-1635 ,y-1635))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py== (py-float-to-scheme x-1634) (py-float-to-scheme y-1635))))))

(define-macro (py-test-eq-floatX-floatY-inline x-1637 y-1638)
  `(let ((x-1637 ,x-1637) (y-1638 ,y-1638))
     (py-test-from-scheme
      (py== (py-float-to-scheme x-1637) (py-float-to-scheme y-1638)))))

(define-macro (py-eq-floatX-boolY-inline x-1640 y-1641)
  `(py-eq-floatX-boolY-fallback ,x-1640 ,y-1641))

(define-macro (py-test-eq-floatX-boolY-inline x-1643 y-1644)
  `(py-test-eq-floatX-boolY-fallback ,x-1643 ,y-1644))

(define-macro (py-eq-floatX-sintY-inline x-1646 y-1647)
  `(let ((x-1646 ,x-1646) (y-1647 ,y-1647))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py== (py-float-to-scheme x-1646) (py-sint-to-scheme y-1647))))))

(define-macro (py-test-eq-floatX-sintY-inline x-1649 y-1650)
  `(let ((x-1649 ,x-1649) (y-1650 ,y-1650))
     (py-test-from-scheme
      (py== (py-float-to-scheme x-1649) (py-sint-to-scheme y-1650)))))

(define-macro (py-eq-floatX-bintY-inline x-1652 y-1653)
  `(py-eq-floatX-bintY-fallback ,x-1652 ,y-1653))

(define-macro (py-test-eq-floatX-bintY-inline x-1655 y-1656)
  `(py-test-eq-floatX-bintY-fallback ,x-1655 ,y-1656))

(define-macro (py-eq-boolX-floatY-inline x-1658 y-1659)
  `(py-eq-boolX-floatY-fallback ,x-1658 ,y-1659))

(define-macro (py-test-eq-boolX-floatY-inline x-1661 y-1662)
  `(py-test-eq-boolX-floatY-fallback ,x-1661 ,y-1662))

(define-macro (py-eq-boolX-boolY-inline x-1664 y-1665)
  `(py-eq-boolX-boolY-fallback ,x-1664 ,y-1665))

(define-macro (py-test-eq-boolX-boolY-inline x-1667 y-1668)
  `(py-test-eq-boolX-boolY-fallback ,x-1667 ,y-1668))

(define-macro (py-eq-boolX-sintY-inline x-1670 y-1671)
  `(py-eq-boolX-sintY-fallback ,x-1670 ,y-1671))

(define-macro (py-test-eq-boolX-sintY-inline x-1673 y-1674)
  `(py-test-eq-boolX-sintY-fallback ,x-1673 ,y-1674))

(define-macro (py-eq-boolX-bintY-inline x-1676 y-1677)
  `(py-eq-boolX-bintY-fallback ,x-1676 ,y-1677))

(define-macro (py-test-eq-boolX-bintY-inline x-1679 y-1680)
  `(py-test-eq-boolX-bintY-fallback ,x-1679 ,y-1680))

(define-macro (py-eq-sintX-floatY-inline x-1682 y-1683)
  `(let ((x-1682 ,x-1682) (y-1683 ,y-1683))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py== (py-float-to-scheme y-1683) (py-sint-to-scheme x-1682))))))

(define-macro (py-test-eq-sintX-floatY-inline x-1685 y-1686)
  `(let ((x-1685 ,x-1685) (y-1686 ,y-1686))
     (py-test-from-scheme
      (py== (py-float-to-scheme y-1686) (py-sint-to-scheme x-1685)))))

(define-macro (py-eq-sintX-boolY-inline x-1688 y-1689)
  `(py-eq-sintX-boolY-fallback ,x-1688 ,y-1689))

(define-macro (py-test-eq-sintX-boolY-inline x-1691 y-1692)
  `(py-test-eq-sintX-boolY-fallback ,x-1691 ,y-1692))

(define-macro (py-eq-sintX-sintY-inline x-1694 y-1695)
  `(let ((x-1694 ,x-1694) (y-1695 ,y-1695))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py== (py-sint-to-scheme x-1694) (py-sint-to-scheme y-1695))))))

(define-macro (py-test-eq-sintX-sintY-inline x-1697 y-1698)
  `(let ((x-1697 ,x-1697) (y-1698 ,y-1698))
     (py-test-from-scheme
      (py== (py-sint-to-scheme x-1697) (py-sint-to-scheme y-1698)))))

(define-macro (py-eq-sintX-bintY-inline x-1700 y-1701)
  `(py-eq-sintX-bintY-fallback ,x-1700 ,y-1701))

(define-macro (py-test-eq-sintX-bintY-inline x-1703 y-1704)
  `(py-test-eq-sintX-bintY-fallback ,x-1703 ,y-1704))

(define-macro (py-eq-bintX-floatY-inline x-1706 y-1707)
  `(py-eq-bintX-floatY-fallback ,x-1706 ,y-1707))

(define-macro (py-test-eq-bintX-floatY-inline x-1709 y-1710)
  `(py-test-eq-bintX-floatY-fallback ,x-1709 ,y-1710))

(define-macro (py-eq-bintX-boolY-inline x-1712 y-1713)
  `(py-eq-bintX-boolY-fallback ,x-1712 ,y-1713))

(define-macro (py-test-eq-bintX-boolY-inline x-1715 y-1716)
  `(py-test-eq-bintX-boolY-fallback ,x-1715 ,y-1716))

(define-macro (py-eq-bintX-sintY-inline x-1718 y-1719)
  `(py-eq-bintX-sintY-fallback ,x-1718 ,y-1719))

(define-macro (py-test-eq-bintX-sintY-inline x-1721 y-1722)
  `(py-test-eq-bintX-sintY-fallback ,x-1721 ,y-1722))

(define-macro (py-eq-bintX-bintY-inline x-1724 y-1725)
  `(py-eq-bintX-bintY-fallback ,x-1724 ,y-1725))

(define-macro (py-test-eq-bintX-bintY-inline x-1727 y-1728)
  `(py-test-eq-bintX-bintY-fallback ,x-1727 ,y-1728))

(define-macro (py-ne-floatX-floatY-inline x-1730 y-1731)
  `(let ((x-1730 ,x-1730) (y-1731 ,y-1731))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py!= (py-float-to-scheme x-1730) (py-float-to-scheme y-1731))))))

(define-macro (py-test-ne-floatX-floatY-inline x-1733 y-1734)
  `(let ((x-1733 ,x-1733) (y-1734 ,y-1734))
     (py-test-from-scheme
      (py!= (py-float-to-scheme x-1733) (py-float-to-scheme y-1734)))))

(define-macro (py-ne-floatX-boolY-inline x-1736 y-1737)
  `(py-ne-floatX-boolY-fallback ,x-1736 ,y-1737))

(define-macro (py-test-ne-floatX-boolY-inline x-1739 y-1740)
  `(py-test-ne-floatX-boolY-fallback ,x-1739 ,y-1740))

(define-macro (py-ne-floatX-sintY-inline x-1742 y-1743)
  `(let ((x-1742 ,x-1742) (y-1743 ,y-1743))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py!= (py-float-to-scheme x-1742) (py-sint-to-scheme y-1743))))))

(define-macro (py-test-ne-floatX-sintY-inline x-1745 y-1746)
  `(let ((x-1745 ,x-1745) (y-1746 ,y-1746))
     (py-test-from-scheme
      (py!= (py-float-to-scheme x-1745) (py-sint-to-scheme y-1746)))))

(define-macro (py-ne-floatX-bintY-inline x-1748 y-1749)
  `(py-ne-floatX-bintY-fallback ,x-1748 ,y-1749))

(define-macro (py-test-ne-floatX-bintY-inline x-1751 y-1752)
  `(py-test-ne-floatX-bintY-fallback ,x-1751 ,y-1752))

(define-macro (py-ne-boolX-floatY-inline x-1754 y-1755)
  `(py-ne-boolX-floatY-fallback ,x-1754 ,y-1755))

(define-macro (py-test-ne-boolX-floatY-inline x-1757 y-1758)
  `(py-test-ne-boolX-floatY-fallback ,x-1757 ,y-1758))

(define-macro (py-ne-boolX-boolY-inline x-1760 y-1761)
  `(py-ne-boolX-boolY-fallback ,x-1760 ,y-1761))

(define-macro (py-test-ne-boolX-boolY-inline x-1763 y-1764)
  `(py-test-ne-boolX-boolY-fallback ,x-1763 ,y-1764))

(define-macro (py-ne-boolX-sintY-inline x-1766 y-1767)
  `(py-ne-boolX-sintY-fallback ,x-1766 ,y-1767))

(define-macro (py-test-ne-boolX-sintY-inline x-1769 y-1770)
  `(py-test-ne-boolX-sintY-fallback ,x-1769 ,y-1770))

(define-macro (py-ne-boolX-bintY-inline x-1772 y-1773)
  `(py-ne-boolX-bintY-fallback ,x-1772 ,y-1773))

(define-macro (py-test-ne-boolX-bintY-inline x-1775 y-1776)
  `(py-test-ne-boolX-bintY-fallback ,x-1775 ,y-1776))

(define-macro (py-ne-sintX-floatY-inline x-1778 y-1779)
  `(let ((x-1778 ,x-1778) (y-1779 ,y-1779))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py!= (py-float-to-scheme y-1779) (py-sint-to-scheme x-1778))))))

(define-macro (py-test-ne-sintX-floatY-inline x-1781 y-1782)
  `(let ((x-1781 ,x-1781) (y-1782 ,y-1782))
     (py-test-from-scheme
      (py!= (py-float-to-scheme y-1782) (py-sint-to-scheme x-1781)))))

(define-macro (py-ne-sintX-boolY-inline x-1784 y-1785)
  `(py-ne-sintX-boolY-fallback ,x-1784 ,y-1785))

(define-macro (py-test-ne-sintX-boolY-inline x-1787 y-1788)
  `(py-test-ne-sintX-boolY-fallback ,x-1787 ,y-1788))

(define-macro (py-ne-sintX-sintY-inline x-1790 y-1791)
  `(let ((x-1790 ,x-1790) (y-1791 ,y-1791))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py!= (py-sint-to-scheme x-1790) (py-sint-to-scheme y-1791))))))

(define-macro (py-test-ne-sintX-sintY-inline x-1793 y-1794)
  `(let ((x-1793 ,x-1793) (y-1794 ,y-1794))
     (py-test-from-scheme
      (py!= (py-sint-to-scheme x-1793) (py-sint-to-scheme y-1794)))))

(define-macro (py-ne-sintX-bintY-inline x-1796 y-1797)
  `(py-ne-sintX-bintY-fallback ,x-1796 ,y-1797))

(define-macro (py-test-ne-sintX-bintY-inline x-1799 y-1800)
  `(py-test-ne-sintX-bintY-fallback ,x-1799 ,y-1800))

(define-macro (py-ne-bintX-floatY-inline x-1802 y-1803)
  `(py-ne-bintX-floatY-fallback ,x-1802 ,y-1803))

(define-macro (py-test-ne-bintX-floatY-inline x-1805 y-1806)
  `(py-test-ne-bintX-floatY-fallback ,x-1805 ,y-1806))

(define-macro (py-ne-bintX-boolY-inline x-1808 y-1809)
  `(py-ne-bintX-boolY-fallback ,x-1808 ,y-1809))

(define-macro (py-test-ne-bintX-boolY-inline x-1811 y-1812)
  `(py-test-ne-bintX-boolY-fallback ,x-1811 ,y-1812))

(define-macro (py-ne-bintX-sintY-inline x-1814 y-1815)
  `(py-ne-bintX-sintY-fallback ,x-1814 ,y-1815))

(define-macro (py-test-ne-bintX-sintY-inline x-1817 y-1818)
  `(py-test-ne-bintX-sintY-fallback ,x-1817 ,y-1818))

(define-macro (py-ne-bintX-bintY-inline x-1820 y-1821)
  `(py-ne-bintX-bintY-fallback ,x-1820 ,y-1821))

(define-macro (py-test-ne-bintX-bintY-inline x-1823 y-1824)
  `(py-test-ne-bintX-bintY-fallback ,x-1823 ,y-1824))

(define-macro (py-pos-floatX-inline x-1826) `(let ((x-1826 ,x-1826)) x-1826))

(define-macro (py-pos-boolX-inline x-1828) `(py-pos-boolX-fallback ,x-1828))

(define-macro (py-pos-sintX-inline x-1830) `(let ((x-1830 ,x-1830)) x-1830))

(define-macro (py-pos-bintX-inline x-1832) `(py-pos-bintX-fallback ,x-1832))

(define-macro (py-neg-floatX-inline x-1834)
  `(let ((x-1834 ,x-1834))
     (py-float-from-scheme (pyneg (py-float-to-scheme x-1834)))))

(define-macro (py-neg-boolX-inline x-1836) `(py-neg-boolX-fallback ,x-1836))

(define-macro (py-neg-sintX-inline x-1838)
  `(let ((x-1838 ,x-1838))
     (py-int-from-scheme (pyneg (py-sint-to-scheme x-1838)))))

(define-macro (py-neg-bintX-inline x-1840) `(py-neg-bintX-fallback ,x-1840))

(define-macro (py-invert-floatX-inline x-1842)
  `(let ((x-1842 ,x-1842))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "bad operand type for unary ~: 'float'")))))

(define-macro (py-invert-boolX-inline x-1844)
  `(py-invert-boolX-fallback ,x-1844))

(define-macro (py-invert-sintX-inline x-1846)
  `(let ((x-1846 ,x-1846))
     (py-int-from-scheme (pyinvert (py-sint-to-scheme x-1846)))))

(define-macro (py-invert-bintX-inline x-1848)
  `(py-invert-bintX-fallback ,x-1848))

(define (py-add-floatX-floatY-fallback x-2 y-3)
  (py-float-from-scheme
   (py+ (py-float-to-scheme x-2) (py-float-to-scheme y-3))))

(define (py-add-floatX-boolY-fallback x-5 y-6)
  (py-float-from-scheme
   (py+ (py-float-to-scheme x-5) (py-bool-to-scheme-int y-6))))

(define (py-add-floatX-sintY-fallback x-8 y-9)
  (py-float-from-scheme
   (py+ (py-float-to-scheme x-8) (py-sint-to-scheme y-9))))

(define (py-add-floatX-bintY-fallback x-11 y-12)
  (py-float-from-scheme
   (py+ (py-float-to-scheme x-11) (py-bint-to-scheme y-12))))

(define (py-add-boolX-floatY-fallback x-14 y-15)
  (py-float-from-scheme
   (py+ (py-bool-to-scheme-int x-14) (py-float-to-scheme y-15))))

(define (py-add-boolX-boolY-fallback x-17 y-18)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme-int x-17) (py-bool-to-scheme-int y-18))))

(define (py-add-boolX-sintY-fallback x-20 y-21)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme-int x-20) (py-sint-to-scheme y-21))))

(define (py-add-boolX-bintY-fallback x-23 y-24)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme-int x-23) (py-bint-to-scheme y-24))))

(define (py-add-sintX-floatY-fallback x-26 y-27)
  (py-float-from-scheme
   (py+ (py-sint-to-scheme x-26) (py-float-to-scheme y-27))))

(define (py-add-sintX-boolY-fallback x-29 y-30)
  (py-int-from-scheme
   (py+ (py-sint-to-scheme x-29) (py-bool-to-scheme-int y-30))))

(define (py-add-sintX-sintY-fallback x-32 y-33)
  (py-int-from-scheme (py+ (py-sint-to-scheme x-32) (py-sint-to-scheme y-33))))

(define (py-add-sintX-bintY-fallback x-35 y-36)
  (py-int-from-scheme (py+ (py-sint-to-scheme x-35) (py-bint-to-scheme y-36))))

(define (py-add-bintX-floatY-fallback x-38 y-39)
  (py-float-from-scheme
   (py+ (py-bint-to-scheme x-38) (py-float-to-scheme y-39))))

(define (py-add-bintX-boolY-fallback x-41 y-42)
  (py-int-from-scheme
   (py+ (py-bint-to-scheme x-41) (py-bool-to-scheme-int y-42))))

(define (py-add-bintX-sintY-fallback x-44 y-45)
  (py-int-from-scheme (py+ (py-bint-to-scheme x-44) (py-sint-to-scheme y-45))))

(define (py-add-bintX-bintY-fallback x-47 y-48)
  (py-int-from-scheme (py+ (py-bint-to-scheme x-47) (py-bint-to-scheme y-48))))

(define (py-bitand-floatX-floatY-fallback x-50 y-51)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'float'"))))

(define (py-bitand-floatX-boolY-fallback x-53 y-54)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'bool'"))))

(define (py-bitand-floatX-sintY-fallback x-56 y-57)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'int'"))))

(define (py-bitand-floatX-bintY-fallback x-59 y-60)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'int'"))))

(define (py-bitand-boolX-floatY-fallback x-62 y-63)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'bool' and 'float'"))))

(define (py-bitand-boolX-boolY-fallback x-65 y-66)
  (if (py-test (py-is x-65 py-True)) y-66 py-False))

(define (py-bitand-boolX-sintY-fallback x-68 y-69)
  (py-int-from-scheme
   (py& (py-bool-to-scheme-int x-68) (py-sint-to-scheme y-69))))

(define (py-bitand-boolX-bintY-fallback x-71 y-72)
  (py-int-from-scheme
   (py& (py-bool-to-scheme-int x-71) (py-bint-to-scheme y-72))))

(define (py-bitand-sintX-floatY-fallback x-74 y-75)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'int' and 'float'"))))

(define (py-bitand-sintX-boolY-fallback x-77 y-78)
  (py-int-from-scheme
   (py& (py-sint-to-scheme x-77) (py-bool-to-scheme-int y-78))))

(define (py-bitand-sintX-sintY-fallback x-80 y-81)
  (py-int-from-scheme (py& (py-sint-to-scheme x-80) (py-sint-to-scheme y-81))))

(define (py-bitand-sintX-bintY-fallback x-83 y-84)
  (py-int-from-scheme (py& (py-sint-to-scheme x-83) (py-bint-to-scheme y-84))))

(define (py-bitand-bintX-floatY-fallback x-86 y-87)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'int' and 'float'"))))

(define (py-bitand-bintX-boolY-fallback x-89 y-90)
  (py-int-from-scheme
   (py& (py-bint-to-scheme x-89) (py-bool-to-scheme-int y-90))))

(define (py-bitand-bintX-sintY-fallback x-92 y-93)
  (py-int-from-scheme (py& (py-bint-to-scheme x-92) (py-sint-to-scheme y-93))))

(define (py-bitand-bintX-bintY-fallback x-95 y-96)
  (py-int-from-scheme (py& (py-bint-to-scheme x-95) (py-bint-to-scheme y-96))))

(define (py-bitor-floatX-floatY-fallback x-98 y-99)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'float'"))))

(define (py-bitor-floatX-boolY-fallback x-101 y-102)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'bool'"))))

(define (py-bitor-floatX-sintY-fallback x-104 y-105)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'int'"))))

(define (py-bitor-floatX-bintY-fallback x-107 y-108)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'int'"))))

(define (py-bitor-boolX-floatY-fallback x-110 y-111)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'bool' and 'float'"))))

(define (py-bitor-boolX-boolY-fallback x-113 y-114)
  (if (py-test (py-is x-113 py-True)) py-True y-114))

(define (py-bitor-boolX-sintY-fallback x-116 y-117)
  (py-int-from-scheme
   (py+b (py-bool-to-scheme-int x-116) (py-sint-to-scheme y-117))))

(define (py-bitor-boolX-bintY-fallback x-119 y-120)
  (py-int-from-scheme
   (py+b (py-bool-to-scheme-int x-119) (py-bint-to-scheme y-120))))

(define (py-bitor-sintX-floatY-fallback x-122 y-123)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'int' and 'float'"))))

(define (py-bitor-sintX-boolY-fallback x-125 y-126)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme x-125) (py-bool-to-scheme-int y-126))))

(define (py-bitor-sintX-sintY-fallback x-128 y-129)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme x-128) (py-sint-to-scheme y-129))))

(define (py-bitor-sintX-bintY-fallback x-131 y-132)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme x-131) (py-bint-to-scheme y-132))))

(define (py-bitor-bintX-floatY-fallback x-134 y-135)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'int' and 'float'"))))

(define (py-bitor-bintX-boolY-fallback x-137 y-138)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme x-137) (py-bool-to-scheme-int y-138))))

(define (py-bitor-bintX-sintY-fallback x-140 y-141)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme x-140) (py-sint-to-scheme y-141))))

(define (py-bitor-bintX-bintY-fallback x-143 y-144)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme x-143) (py-bint-to-scheme y-144))))

(define (py-floordiv-floatX-floatY-fallback x-146 y-147)
  (if (py-test (py-ne y-147 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-float-to-scheme x-146) (py-float-to-scheme y-147)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-floatX-boolY-fallback x-149 y-150)
  (if (py-test (py-ne y-150 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py// (py-float-to-scheme x-149) (py-bool-to-scheme-int y-150)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-floatX-sintY-fallback x-152 y-153)
  (if (py-test (py-ne y-153 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py// (py-float-to-scheme x-152) (py-sint-to-scheme y-153)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-floatX-bintY-fallback x-155 y-156)
  (py-float-from-scheme
   (py// (py-float-to-scheme x-155) (py-bint-to-scheme y-156))))

(define (py-floordiv-boolX-floatY-fallback x-158 y-159)
  (if (py-test (py-ne y-159 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-bool-to-scheme-int x-158) (py-float-to-scheme y-159)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-boolX-boolY-fallback x-161 y-162)
  (if (py-test (py-ne y-162 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bool-to-scheme-int x-161) (py-bool-to-scheme-int y-162)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-boolX-sintY-fallback x-164 y-165)
  (if (py-test (py-ne y-165 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bool-to-scheme-int x-164) (py-sint-to-scheme y-165)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-boolX-bintY-fallback x-167 y-168)
  (py-int-from-scheme
   (py// (py-bool-to-scheme-int x-167) (py-bint-to-scheme y-168))))

(define (py-floordiv-sintX-floatY-fallback x-170 y-171)
  (if (py-test (py-ne y-171 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-sint-to-scheme x-170) (py-float-to-scheme y-171)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-sintX-boolY-fallback x-173 y-174)
  (if (py-test (py-ne y-174 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-sint-to-scheme x-173) (py-bool-to-scheme-int y-174)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-sintX-sintY-fallback x-176 y-177)
  (if (py-test (py-ne y-177 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-sint-to-scheme x-176) (py-sint-to-scheme y-177)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-sintX-bintY-fallback x-179 y-180)
  (py-int-from-scheme
   (py// (py-sint-to-scheme x-179) (py-bint-to-scheme y-180))))

(define (py-floordiv-bintX-floatY-fallback x-182 y-183)
  (if (py-test (py-ne y-183 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-bint-to-scheme x-182) (py-float-to-scheme y-183)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-bintX-boolY-fallback x-185 y-186)
  (if (py-test (py-ne y-186 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bint-to-scheme x-185) (py-bool-to-scheme-int y-186)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-bintX-sintY-fallback x-188 y-189)
  (if (py-test (py-ne y-189 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bint-to-scheme x-188) (py-sint-to-scheme y-189)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-bintX-bintY-fallback x-191 y-192)
  (py-int-from-scheme
   (py// (py-bint-to-scheme x-191) (py-bint-to-scheme y-192))))

(define (py-lshift-floatX-floatY-fallback x-194 y-195)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'float'"))))

(define (py-lshift-floatX-boolY-fallback x-197 y-198)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'bool'"))))

(define (py-lshift-floatX-sintY-fallback x-200 y-201)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'int'"))))

(define (py-lshift-floatX-bintY-fallback x-203 y-204)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'int'"))))

(define (py-lshift-boolX-floatY-fallback x-206 y-207)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'bool' and 'float'"))))

(define (py-lshift-boolX-boolY-fallback x-209 y-210)
  (if (py-test (py-ge y-210 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bool-to-scheme-int x-209) (py-bool-to-scheme-int y-210)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-boolX-sintY-fallback x-212 y-213)
  (if (py-test (py-ge y-213 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bool-to-scheme-int x-212) (py-sint-to-scheme y-213)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-boolX-bintY-fallback x-215 y-216)
  (if (py-test (py-ge y-216 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bool-to-scheme-int x-215) (py-bint-to-scheme y-216)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-sintX-floatY-fallback x-218 y-219)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'int' and 'float'"))))

(define (py-lshift-sintX-boolY-fallback x-221 y-222)
  (if (py-test (py-ge y-222 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-sint-to-scheme x-221) (py-bool-to-scheme-int y-222)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-sintX-sintY-fallback x-224 y-225)
  (if (py-test (py-ge y-225 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-sint-to-scheme x-224) (py-sint-to-scheme y-225)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-sintX-bintY-fallback x-227 y-228)
  (if (py-test (py-ge y-228 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-sint-to-scheme x-227) (py-bint-to-scheme y-228)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-bintX-floatY-fallback x-230 y-231)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'int' and 'float'"))))

(define (py-lshift-bintX-boolY-fallback x-233 y-234)
  (if (py-test (py-ge y-234 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bint-to-scheme x-233) (py-bool-to-scheme-int y-234)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-bintX-sintY-fallback x-236 y-237)
  (if (py-test (py-ge y-237 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bint-to-scheme x-236) (py-sint-to-scheme y-237)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-bintX-bintY-fallback x-239 y-240)
  (if (py-test (py-ge y-240 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bint-to-scheme x-239) (py-bint-to-scheme y-240)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-matmul-floatX-floatY-fallback x-242 y-243)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'float'"))))

(define (py-matmul-floatX-boolY-fallback x-245 y-246)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'bool'"))))

(define (py-matmul-floatX-sintY-fallback x-248 y-249)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'int'"))))

(define (py-matmul-floatX-bintY-fallback x-251 y-252)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'int'"))))

(define (py-matmul-boolX-floatY-fallback x-254 y-255)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'float'"))))

(define (py-matmul-boolX-boolY-fallback x-257 y-258)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'bool'"))))

(define (py-matmul-boolX-sintY-fallback x-260 y-261)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'int'"))))

(define (py-matmul-boolX-bintY-fallback x-263 y-264)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'int'"))))

(define (py-matmul-sintX-floatY-fallback x-266 y-267)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'float'"))))

(define (py-matmul-sintX-boolY-fallback x-269 y-270)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'bool'"))))

(define (py-matmul-sintX-sintY-fallback x-272 y-273)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-matmul-sintX-bintY-fallback x-275 y-276)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-matmul-bintX-floatY-fallback x-278 y-279)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'float'"))))

(define (py-matmul-bintX-boolY-fallback x-281 y-282)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'bool'"))))

(define (py-matmul-bintX-sintY-fallback x-284 y-285)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-matmul-bintX-bintY-fallback x-287 y-288)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-mod-floatX-floatY-fallback x-290 y-291)
  (if (py-test (py-ne y-291 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-float-to-scheme x-290) (py-float-to-scheme y-291)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-floatX-boolY-fallback x-293 y-294)
  (if (py-test (py-ne y-294 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py% (py-float-to-scheme x-293) (py-bool-to-scheme-int y-294)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-floatX-sintY-fallback x-296 y-297)
  (if (py-test (py-ne y-297 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py% (py-float-to-scheme x-296) (py-sint-to-scheme y-297)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-floatX-bintY-fallback x-299 y-300)
  (py-float-from-scheme
   (py% (py-float-to-scheme x-299) (py-bint-to-scheme y-300))))

(define (py-mod-boolX-floatY-fallback x-302 y-303)
  (if (py-test (py-ne y-303 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-bool-to-scheme-int x-302) (py-float-to-scheme y-303)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-boolX-boolY-fallback x-305 y-306)
  (if (py-test (py-ne y-306 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bool-to-scheme-int x-305) (py-bool-to-scheme-int y-306)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-boolX-sintY-fallback x-308 y-309)
  (if (py-test (py-ne y-309 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bool-to-scheme-int x-308) (py-sint-to-scheme y-309)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-boolX-bintY-fallback x-311 y-312)
  (py-int-from-scheme
   (py% (py-bool-to-scheme-int x-311) (py-bint-to-scheme y-312))))

(define (py-mod-sintX-floatY-fallback x-314 y-315)
  (if (py-test (py-ne y-315 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-sint-to-scheme x-314) (py-float-to-scheme y-315)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-sintX-boolY-fallback x-317 y-318)
  (if (py-test (py-ne y-318 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-sint-to-scheme x-317) (py-bool-to-scheme-int y-318)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-sintX-sintY-fallback x-320 y-321)
  (if (py-test (py-ne y-321 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-sint-to-scheme x-320) (py-sint-to-scheme y-321)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-sintX-bintY-fallback x-323 y-324)
  (py-int-from-scheme
   (py% (py-sint-to-scheme x-323) (py-bint-to-scheme y-324))))

(define (py-mod-bintX-floatY-fallback x-326 y-327)
  (if (py-test (py-ne y-327 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-bint-to-scheme x-326) (py-float-to-scheme y-327)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-bintX-boolY-fallback x-329 y-330)
  (if (py-test (py-ne y-330 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bint-to-scheme x-329) (py-bool-to-scheme-int y-330)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-bintX-sintY-fallback x-332 y-333)
  (if (py-test (py-ne y-333 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bint-to-scheme x-332) (py-sint-to-scheme y-333)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-bintX-bintY-fallback x-335 y-336)
  (py-int-from-scheme
   (py% (py-bint-to-scheme x-335) (py-bint-to-scheme y-336))))

(define (py-mul-floatX-floatY-fallback x-338 y-339)
  (py-float-from-scheme
   (py* (py-float-to-scheme x-338) (py-float-to-scheme y-339))))

(define (py-mul-floatX-boolY-fallback x-341 y-342)
  (py-float-from-scheme
   (py* (py-float-to-scheme x-341) (py-bool-to-scheme-int y-342))))

(define (py-mul-floatX-sintY-fallback x-344 y-345)
  (py-float-from-scheme
   (py* (py-float-to-scheme x-344) (py-sint-to-scheme y-345))))

(define (py-mul-floatX-bintY-fallback x-347 y-348)
  (py-float-from-scheme
   (py* (py-float-to-scheme x-347) (py-bint-to-scheme y-348))))

(define (py-mul-boolX-floatY-fallback x-350 y-351)
  (py-float-from-scheme
   (py* (py-bool-to-scheme-int x-350) (py-float-to-scheme y-351))))

(define (py-mul-boolX-boolY-fallback x-353 y-354)
  (py-int-from-scheme
   (py* (py-bool-to-scheme-int x-353) (py-bool-to-scheme-int y-354))))

(define (py-mul-boolX-sintY-fallback x-356 y-357)
  (py-int-from-scheme
   (py* (py-bool-to-scheme-int x-356) (py-sint-to-scheme y-357))))

(define (py-mul-boolX-bintY-fallback x-359 y-360)
  (py-int-from-scheme
   (py* (py-bool-to-scheme-int x-359) (py-bint-to-scheme y-360))))

(define (py-mul-sintX-floatY-fallback x-362 y-363)
  (py-float-from-scheme
   (py* (py-sint-to-scheme x-362) (py-float-to-scheme y-363))))

(define (py-mul-sintX-boolY-fallback x-365 y-366)
  (py-int-from-scheme
   (py* (py-sint-to-scheme x-365) (py-bool-to-scheme-int y-366))))

(define (py-mul-sintX-sintY-fallback x-368 y-369)
  (py-int-from-scheme
   (py* (py-sint-to-scheme x-368) (py-sint-to-scheme y-369))))

(define (py-mul-sintX-bintY-fallback x-371 y-372)
  (py-int-from-scheme
   (py* (py-sint-to-scheme x-371) (py-bint-to-scheme y-372))))

(define (py-mul-bintX-floatY-fallback x-374 y-375)
  (py-float-from-scheme
   (py* (py-bint-to-scheme x-374) (py-float-to-scheme y-375))))

(define (py-mul-bintX-boolY-fallback x-377 y-378)
  (py-int-from-scheme
   (py* (py-bint-to-scheme x-377) (py-bool-to-scheme-int y-378))))

(define (py-mul-bintX-sintY-fallback x-380 y-381)
  (py-int-from-scheme
   (py* (py-bint-to-scheme x-380) (py-sint-to-scheme y-381))))

(define (py-mul-bintX-bintY-fallback x-383 y-384)
  (py-int-from-scheme
   (py* (py-bint-to-scheme x-383) (py-bint-to-scheme y-384))))

(define (py-pow-floatX-floatY-fallback x-386 y-387)
  (py-float-from-scheme
   (py** (py-float-to-scheme x-386) (py-float-to-scheme y-387))))

(define (py-pow-floatX-boolY-fallback x-389 y-390)
  (py-float-from-scheme
   (py** (py-float-to-scheme x-389) (py-bool-to-scheme-int y-390))))

(define (py-pow-floatX-sintY-fallback x-392 y-393)
  (py-float-from-scheme
   (py** (py-float-to-scheme x-392) (py-sint-to-scheme y-393))))

(define (py-pow-floatX-bintY-fallback x-395 y-396)
  (py-float-from-scheme
   (py** (py-float-to-scheme x-395) (py-bint-to-scheme y-396))))

(define (py-pow-boolX-floatY-fallback x-398 y-399)
  (py-float-from-scheme
   (py** (py-bool-to-scheme-int x-398) (py-float-to-scheme y-399))))

(define (py-pow-boolX-boolY-fallback x-401 y-402)
  (py-int-from-scheme
   (py** (py-bool-to-scheme-int x-401) (py-bool-to-scheme-int y-402))))

(define (py-pow-boolX-sintY-fallback x-404 y-405)
  (py-int-from-scheme
   (py** (py-bool-to-scheme-int x-404) (py-sint-to-scheme y-405))))

(define (py-pow-boolX-bintY-fallback x-407 y-408)
  (py-int-from-scheme
   (py** (py-bool-to-scheme-int x-407) (py-bint-to-scheme y-408))))

(define (py-pow-sintX-floatY-fallback x-410 y-411)
  (py-float-from-scheme
   (py** (py-sint-to-scheme x-410) (py-float-to-scheme y-411))))

(define (py-pow-sintX-boolY-fallback x-413 y-414)
  (py-int-from-scheme
   (py** (py-sint-to-scheme x-413) (py-bool-to-scheme-int y-414))))

(define (py-pow-sintX-sintY-fallback x-416 y-417)
  (py-int-from-scheme
   (py** (py-sint-to-scheme x-416) (py-sint-to-scheme y-417))))

(define (py-pow-sintX-bintY-fallback x-419 y-420)
  (py-int-from-scheme
   (py** (py-sint-to-scheme x-419) (py-bint-to-scheme y-420))))

(define (py-pow-bintX-floatY-fallback x-422 y-423)
  (py-float-from-scheme
   (py** (py-bint-to-scheme x-422) (py-float-to-scheme y-423))))

(define (py-pow-bintX-boolY-fallback x-425 y-426)
  (py-int-from-scheme
   (py** (py-bint-to-scheme x-425) (py-bool-to-scheme-int y-426))))

(define (py-pow-bintX-sintY-fallback x-428 y-429)
  (py-int-from-scheme
   (py** (py-bint-to-scheme x-428) (py-sint-to-scheme y-429))))

(define (py-pow-bintX-bintY-fallback x-431 y-432)
  (py-int-from-scheme
   (py** (py-bint-to-scheme x-431) (py-bint-to-scheme y-432))))

(define (py-rshift-floatX-floatY-fallback x-434 y-435)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'float'"))))

(define (py-rshift-floatX-boolY-fallback x-437 y-438)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'bool'"))))

(define (py-rshift-floatX-sintY-fallback x-440 y-441)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'int'"))))

(define (py-rshift-floatX-bintY-fallback x-443 y-444)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'int'"))))

(define (py-rshift-boolX-floatY-fallback x-446 y-447)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'bool' and 'float'"))))

(define (py-rshift-boolX-boolY-fallback x-449 y-450)
  (if (py-test (py-ge y-450 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bool-to-scheme-int x-449) (py-bool-to-scheme-int y-450)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-boolX-sintY-fallback x-452 y-453)
  (if (py-test (py-ge y-453 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bool-to-scheme-int x-452) (py-sint-to-scheme y-453)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-boolX-bintY-fallback x-455 y-456)
  (if (py-test (py-ge y-456 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bool-to-scheme-int x-455) (py-bint-to-scheme y-456)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-sintX-floatY-fallback x-458 y-459)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'int' and 'float'"))))

(define (py-rshift-sintX-boolY-fallback x-461 y-462)
  (if (py-test (py-ge y-462 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-sint-to-scheme x-461) (py-bool-to-scheme-int y-462)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-sintX-sintY-fallback x-464 y-465)
  (if (py-test (py-ge y-465 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-sint-to-scheme x-464) (py-sint-to-scheme y-465)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-sintX-bintY-fallback x-467 y-468)
  (if (py-test (py-ge y-468 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-sint-to-scheme x-467) (py-bint-to-scheme y-468)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-bintX-floatY-fallback x-470 y-471)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'int' and 'float'"))))

(define (py-rshift-bintX-boolY-fallback x-473 y-474)
  (if (py-test (py-ge y-474 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bint-to-scheme x-473) (py-bool-to-scheme-int y-474)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-bintX-sintY-fallback x-476 y-477)
  (if (py-test (py-ge y-477 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bint-to-scheme x-476) (py-sint-to-scheme y-477)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-bintX-bintY-fallback x-479 y-480)
  (if (py-test (py-ge y-480 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bint-to-scheme x-479) (py-bint-to-scheme y-480)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-sub-floatX-floatY-fallback x-482 y-483)
  (py-float-from-scheme
   (py- (py-float-to-scheme x-482) (py-float-to-scheme y-483))))

(define (py-sub-floatX-boolY-fallback x-485 y-486)
  (py-float-from-scheme
   (py- (py-float-to-scheme x-485) (py-bool-to-scheme-int y-486))))

(define (py-sub-floatX-sintY-fallback x-488 y-489)
  (py-float-from-scheme
   (py- (py-float-to-scheme x-488) (py-sint-to-scheme y-489))))

(define (py-sub-floatX-bintY-fallback x-491 y-492)
  (py-float-from-scheme
   (py- (py-float-to-scheme x-491) (py-bint-to-scheme y-492))))

(define (py-sub-boolX-floatY-fallback x-494 y-495)
  (py-float-from-scheme
   (py- (py-bool-to-scheme-int x-494) (py-float-to-scheme y-495))))

(define (py-sub-boolX-boolY-fallback x-497 y-498)
  (py-int-from-scheme
   (py- (py-bool-to-scheme-int x-497) (py-bool-to-scheme-int y-498))))

(define (py-sub-boolX-sintY-fallback x-500 y-501)
  (py-int-from-scheme
   (py- (py-bool-to-scheme-int x-500) (py-sint-to-scheme y-501))))

(define (py-sub-boolX-bintY-fallback x-503 y-504)
  (py-int-from-scheme
   (py- (py-bool-to-scheme-int x-503) (py-bint-to-scheme y-504))))

(define (py-sub-sintX-floatY-fallback x-506 y-507)
  (py-float-from-scheme
   (py- (py-sint-to-scheme x-506) (py-float-to-scheme y-507))))

(define (py-sub-sintX-boolY-fallback x-509 y-510)
  (py-int-from-scheme
   (py- (py-sint-to-scheme x-509) (py-bool-to-scheme-int y-510))))

(define (py-sub-sintX-sintY-fallback x-512 y-513)
  (py-int-from-scheme
   (py- (py-sint-to-scheme x-512) (py-sint-to-scheme y-513))))

(define (py-sub-sintX-bintY-fallback x-515 y-516)
  (py-int-from-scheme
   (py- (py-sint-to-scheme x-515) (py-bint-to-scheme y-516))))

(define (py-sub-bintX-floatY-fallback x-518 y-519)
  (py-float-from-scheme
   (py- (py-bint-to-scheme x-518) (py-float-to-scheme y-519))))

(define (py-sub-bintX-boolY-fallback x-521 y-522)
  (py-int-from-scheme
   (py- (py-bint-to-scheme x-521) (py-bool-to-scheme-int y-522))))

(define (py-sub-bintX-sintY-fallback x-524 y-525)
  (py-int-from-scheme
   (py- (py-bint-to-scheme x-524) (py-sint-to-scheme y-525))))

(define (py-sub-bintX-bintY-fallback x-527 y-528)
  (py-int-from-scheme
   (py- (py-bint-to-scheme x-527) (py-bint-to-scheme y-528))))

(define (py-truediv-floatX-floatY-fallback x-530 y-531)
  (if (py-test (py-ne y-531 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme x-530) (py-float-to-scheme y-531)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-floatX-boolY-fallback x-533 y-534)
  (if (py-test (py-ne y-534 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme x-533) (py-bool-to-scheme-int y-534)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-floatX-sintY-fallback x-536 y-537)
  (if (py-test (py-ne y-537 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme x-536) (py-sint-to-scheme y-537)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-floatX-bintY-fallback x-539 y-540)
  (py-float-from-scheme
   (py/ (py-float-to-scheme x-539) (py-bint-to-scheme y-540))))

(define (py-truediv-boolX-floatY-fallback x-542 y-543)
  (if (py-test (py-ne y-543 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme-int x-542) (py-float-to-scheme y-543)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-boolX-boolY-fallback x-545 y-546)
  (if (py-test (py-ne y-546 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme-int x-545) (py-bool-to-scheme-int y-546)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-boolX-sintY-fallback x-548 y-549)
  (if (py-test (py-ne y-549 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme-int x-548) (py-sint-to-scheme y-549)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-boolX-bintY-fallback x-551 y-552)
  (py-float-from-scheme
   (py/ (py-bool-to-scheme-int x-551) (py-bint-to-scheme y-552))))

(define (py-truediv-sintX-floatY-fallback x-554 y-555)
  (if (py-test (py-ne y-555 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme x-554) (py-float-to-scheme y-555)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-sintX-boolY-fallback x-557 y-558)
  (if (py-test (py-ne y-558 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme x-557) (py-bool-to-scheme-int y-558)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-sintX-sintY-fallback x-560 y-561)
  (if (py-test (py-ne y-561 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme x-560) (py-sint-to-scheme y-561)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-sintX-bintY-fallback x-563 y-564)
  (py-float-from-scheme
   (py/ (py-sint-to-scheme x-563) (py-bint-to-scheme y-564))))

(define (py-truediv-bintX-floatY-fallback x-566 y-567)
  (if (py-test (py-ne y-567 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme x-566) (py-float-to-scheme y-567)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-bintX-boolY-fallback x-569 y-570)
  (if (py-test (py-ne y-570 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme x-569) (py-bool-to-scheme-int y-570)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-bintX-sintY-fallback x-572 y-573)
  (if (py-test (py-ne y-573 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme x-572) (py-sint-to-scheme y-573)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-bintX-bintY-fallback x-575 y-576)
  (py-float-from-scheme
   (py/ (py-bint-to-scheme x-575) (py-bint-to-scheme y-576))))

(define (py-xor-floatX-floatY-fallback x-578 y-579)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'float'"))))

(define (py-xor-floatX-boolY-fallback x-581 y-582)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'bool'"))))

(define (py-xor-floatX-sintY-fallback x-584 y-585)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'int'"))))

(define (py-xor-floatX-bintY-fallback x-587 y-588)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'int'"))))

(define (py-xor-boolX-floatY-fallback x-590 y-591)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'bool' and 'float'"))))

(define (py-xor-boolX-boolY-fallback x-593 y-594) (py-isnot x-593 y-594))

(define (py-xor-boolX-sintY-fallback x-596 y-597)
  (py-int-from-scheme
   (py^ (py-bool-to-scheme-int x-596) (py-sint-to-scheme y-597))))

(define (py-xor-boolX-bintY-fallback x-599 y-600)
  (py-int-from-scheme
   (py^ (py-bool-to-scheme-int x-599) (py-bint-to-scheme y-600))))

(define (py-xor-sintX-floatY-fallback x-602 y-603)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'int' and 'float'"))))

(define (py-xor-sintX-boolY-fallback x-605 y-606)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme x-605) (py-bool-to-scheme-int y-606))))

(define (py-xor-sintX-sintY-fallback x-608 y-609)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme x-608) (py-sint-to-scheme y-609))))

(define (py-xor-sintX-bintY-fallback x-611 y-612)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme x-611) (py-bint-to-scheme y-612))))

(define (py-xor-bintX-floatY-fallback x-614 y-615)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'int' and 'float'"))))

(define (py-xor-bintX-boolY-fallback x-617 y-618)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme x-617) (py-bool-to-scheme-int y-618))))

(define (py-xor-bintX-sintY-fallback x-620 y-621)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme x-620) (py-sint-to-scheme y-621))))

(define (py-xor-bintX-bintY-fallback x-623 y-624)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme x-623) (py-bint-to-scheme y-624))))

(define (py-iadd-floatX-floatY-fallback x-626 y-627)
  (py-float-from-scheme
   (py+ (py-float-to-scheme x-626) (py-float-to-scheme y-627))))

(define (py-iadd-floatX-boolY-fallback x-629 y-630)
  (py-float-from-scheme
   (py+ (py-float-to-scheme x-629) (py-bool-to-scheme-int y-630))))

(define (py-iadd-floatX-sintY-fallback x-632 y-633)
  (py-float-from-scheme
   (py+ (py-float-to-scheme x-632) (py-sint-to-scheme y-633))))

(define (py-iadd-floatX-bintY-fallback x-635 y-636)
  (py-float-from-scheme
   (py+ (py-float-to-scheme x-635) (py-bint-to-scheme y-636))))

(define (py-iadd-boolX-floatY-fallback x-638 y-639)
  (py-float-from-scheme
   (py+ (py-bool-to-scheme-int x-638) (py-float-to-scheme y-639))))

(define (py-iadd-boolX-boolY-fallback x-641 y-642)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme-int x-641) (py-bool-to-scheme-int y-642))))

(define (py-iadd-boolX-sintY-fallback x-644 y-645)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme-int x-644) (py-sint-to-scheme y-645))))

(define (py-iadd-boolX-bintY-fallback x-647 y-648)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme-int x-647) (py-bint-to-scheme y-648))))

(define (py-iadd-sintX-floatY-fallback x-650 y-651)
  (py-float-from-scheme
   (py+ (py-sint-to-scheme x-650) (py-float-to-scheme y-651))))

(define (py-iadd-sintX-boolY-fallback x-653 y-654)
  (py-int-from-scheme
   (py+ (py-sint-to-scheme x-653) (py-bool-to-scheme-int y-654))))

(define (py-iadd-sintX-sintY-fallback x-656 y-657)
  (py-int-from-scheme
   (py+ (py-sint-to-scheme x-656) (py-sint-to-scheme y-657))))

(define (py-iadd-sintX-bintY-fallback x-659 y-660)
  (py-int-from-scheme
   (py+ (py-sint-to-scheme x-659) (py-bint-to-scheme y-660))))

(define (py-iadd-bintX-floatY-fallback x-662 y-663)
  (py-float-from-scheme
   (py+ (py-bint-to-scheme x-662) (py-float-to-scheme y-663))))

(define (py-iadd-bintX-boolY-fallback x-665 y-666)
  (py-int-from-scheme
   (py+ (py-bint-to-scheme x-665) (py-bool-to-scheme-int y-666))))

(define (py-iadd-bintX-sintY-fallback x-668 y-669)
  (py-int-from-scheme
   (py+ (py-bint-to-scheme x-668) (py-sint-to-scheme y-669))))

(define (py-iadd-bintX-bintY-fallback x-671 y-672)
  (py-int-from-scheme
   (py+ (py-bint-to-scheme x-671) (py-bint-to-scheme y-672))))

(define (py-ibitand-floatX-floatY-fallback x-674 y-675)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'float' and 'float'"))))

(define (py-ibitand-floatX-boolY-fallback x-677 y-678)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'float' and 'bool'"))))

(define (py-ibitand-floatX-sintY-fallback x-680 y-681)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'float' and 'int'"))))

(define (py-ibitand-floatX-bintY-fallback x-683 y-684)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'float' and 'int'"))))

(define (py-ibitand-boolX-floatY-fallback x-686 y-687)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'bool' and 'float'"))))

(define (py-ibitand-boolX-boolY-fallback x-689 y-690)
  (py-int-from-scheme
   (py& (py-bool-to-scheme-int x-689) (py-bool-to-scheme-int y-690))))

(define (py-ibitand-boolX-sintY-fallback x-692 y-693)
  (py-int-from-scheme
   (py& (py-bool-to-scheme-int x-692) (py-sint-to-scheme y-693))))

(define (py-ibitand-boolX-bintY-fallback x-695 y-696)
  (py-int-from-scheme
   (py& (py-bool-to-scheme-int x-695) (py-bint-to-scheme y-696))))

(define (py-ibitand-sintX-floatY-fallback x-698 y-699)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'int' and 'float'"))))

(define (py-ibitand-sintX-boolY-fallback x-701 y-702)
  (py-int-from-scheme
   (py& (py-sint-to-scheme x-701) (py-bool-to-scheme-int y-702))))

(define (py-ibitand-sintX-sintY-fallback x-704 y-705)
  (py-int-from-scheme
   (py& (py-sint-to-scheme x-704) (py-sint-to-scheme y-705))))

(define (py-ibitand-sintX-bintY-fallback x-707 y-708)
  (py-int-from-scheme
   (py& (py-sint-to-scheme x-707) (py-bint-to-scheme y-708))))

(define (py-ibitand-bintX-floatY-fallback x-710 y-711)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'int' and 'float'"))))

(define (py-ibitand-bintX-boolY-fallback x-713 y-714)
  (py-int-from-scheme
   (py& (py-bint-to-scheme x-713) (py-bool-to-scheme-int y-714))))

(define (py-ibitand-bintX-sintY-fallback x-716 y-717)
  (py-int-from-scheme
   (py& (py-bint-to-scheme x-716) (py-sint-to-scheme y-717))))

(define (py-ibitand-bintX-bintY-fallback x-719 y-720)
  (py-int-from-scheme
   (py& (py-bint-to-scheme x-719) (py-bint-to-scheme y-720))))

(define (py-ibitor-floatX-floatY-fallback x-722 y-723)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'float' and 'float'"))))

(define (py-ibitor-floatX-boolY-fallback x-725 y-726)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'float' and 'bool'"))))

(define (py-ibitor-floatX-sintY-fallback x-728 y-729)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'float' and 'int'"))))

(define (py-ibitor-floatX-bintY-fallback x-731 y-732)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'float' and 'int'"))))

(define (py-ibitor-boolX-floatY-fallback x-734 y-735)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'bool' and 'float'"))))

(define (py-ibitor-boolX-boolY-fallback x-737 y-738)
  (py-int-from-scheme
   (py+b (py-bool-to-scheme-int x-737) (py-bool-to-scheme-int y-738))))

(define (py-ibitor-boolX-sintY-fallback x-740 y-741)
  (py-int-from-scheme
   (py+b (py-bool-to-scheme-int x-740) (py-sint-to-scheme y-741))))

(define (py-ibitor-boolX-bintY-fallback x-743 y-744)
  (py-int-from-scheme
   (py+b (py-bool-to-scheme-int x-743) (py-bint-to-scheme y-744))))

(define (py-ibitor-sintX-floatY-fallback x-746 y-747)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'int' and 'float'"))))

(define (py-ibitor-sintX-boolY-fallback x-749 y-750)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme x-749) (py-bool-to-scheme-int y-750))))

(define (py-ibitor-sintX-sintY-fallback x-752 y-753)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme x-752) (py-sint-to-scheme y-753))))

(define (py-ibitor-sintX-bintY-fallback x-755 y-756)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme x-755) (py-bint-to-scheme y-756))))

(define (py-ibitor-bintX-floatY-fallback x-758 y-759)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'int' and 'float'"))))

(define (py-ibitor-bintX-boolY-fallback x-761 y-762)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme x-761) (py-bool-to-scheme-int y-762))))

(define (py-ibitor-bintX-sintY-fallback x-764 y-765)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme x-764) (py-sint-to-scheme y-765))))

(define (py-ibitor-bintX-bintY-fallback x-767 y-768)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme x-767) (py-bint-to-scheme y-768))))

(define (py-ifloordiv-floatX-floatY-fallback x-770 y-771)
  (if (py-test (py-ne y-771 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-float-to-scheme x-770) (py-float-to-scheme y-771)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-floatX-boolY-fallback x-773 y-774)
  (if (py-test (py-ne y-774 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py// (py-float-to-scheme x-773) (py-bool-to-scheme-int y-774)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-floatX-sintY-fallback x-776 y-777)
  (if (py-test (py-ne y-777 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py// (py-float-to-scheme x-776) (py-sint-to-scheme y-777)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-floatX-bintY-fallback x-779 y-780)
  (py-float-from-scheme
   (py// (py-float-to-scheme x-779) (py-bint-to-scheme y-780))))

(define (py-ifloordiv-boolX-floatY-fallback x-782 y-783)
  (if (py-test (py-ne y-783 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-bool-to-scheme-int x-782) (py-float-to-scheme y-783)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-boolX-boolY-fallback x-785 y-786)
  (if (py-test (py-ne y-786 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bool-to-scheme-int x-785) (py-bool-to-scheme-int y-786)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-boolX-sintY-fallback x-788 y-789)
  (if (py-test (py-ne y-789 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bool-to-scheme-int x-788) (py-sint-to-scheme y-789)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-boolX-bintY-fallback x-791 y-792)
  (py-int-from-scheme
   (py// (py-bool-to-scheme-int x-791) (py-bint-to-scheme y-792))))

(define (py-ifloordiv-sintX-floatY-fallback x-794 y-795)
  (if (py-test (py-ne y-795 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-sint-to-scheme x-794) (py-float-to-scheme y-795)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-sintX-boolY-fallback x-797 y-798)
  (if (py-test (py-ne y-798 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-sint-to-scheme x-797) (py-bool-to-scheme-int y-798)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-sintX-sintY-fallback x-800 y-801)
  (if (py-test (py-ne y-801 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-sint-to-scheme x-800) (py-sint-to-scheme y-801)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-sintX-bintY-fallback x-803 y-804)
  (py-int-from-scheme
   (py// (py-sint-to-scheme x-803) (py-bint-to-scheme y-804))))

(define (py-ifloordiv-bintX-floatY-fallback x-806 y-807)
  (if (py-test (py-ne y-807 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-bint-to-scheme x-806) (py-float-to-scheme y-807)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-bintX-boolY-fallback x-809 y-810)
  (if (py-test (py-ne y-810 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bint-to-scheme x-809) (py-bool-to-scheme-int y-810)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-bintX-sintY-fallback x-812 y-813)
  (if (py-test (py-ne y-813 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bint-to-scheme x-812) (py-sint-to-scheme y-813)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-bintX-bintY-fallback x-815 y-816)
  (py-int-from-scheme
   (py// (py-bint-to-scheme x-815) (py-bint-to-scheme y-816))))

(define (py-ilshift-floatX-floatY-fallback x-818 y-819)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'float' and 'float'"))))

(define (py-ilshift-floatX-boolY-fallback x-821 y-822)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'float' and 'bool'"))))

(define (py-ilshift-floatX-sintY-fallback x-824 y-825)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'float' and 'int'"))))

(define (py-ilshift-floatX-bintY-fallback x-827 y-828)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'float' and 'int'"))))

(define (py-ilshift-boolX-floatY-fallback x-830 y-831)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'bool' and 'float'"))))

(define (py-ilshift-boolX-boolY-fallback x-833 y-834)
  (if (py-test (py-ge y-834 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bool-to-scheme-int x-833) (py-bool-to-scheme-int y-834)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-boolX-sintY-fallback x-836 y-837)
  (if (py-test (py-ge y-837 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bool-to-scheme-int x-836) (py-sint-to-scheme y-837)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-boolX-bintY-fallback x-839 y-840)
  (if (py-test (py-ge y-840 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bool-to-scheme-int x-839) (py-bint-to-scheme y-840)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-sintX-floatY-fallback x-842 y-843)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'int' and 'float'"))))

(define (py-ilshift-sintX-boolY-fallback x-845 y-846)
  (if (py-test (py-ge y-846 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-sint-to-scheme x-845) (py-bool-to-scheme-int y-846)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-sintX-sintY-fallback x-848 y-849)
  (if (py-test (py-ge y-849 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-sint-to-scheme x-848) (py-sint-to-scheme y-849)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-sintX-bintY-fallback x-851 y-852)
  (if (py-test (py-ge y-852 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-sint-to-scheme x-851) (py-bint-to-scheme y-852)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-bintX-floatY-fallback x-854 y-855)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'int' and 'float'"))))

(define (py-ilshift-bintX-boolY-fallback x-857 y-858)
  (if (py-test (py-ge y-858 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bint-to-scheme x-857) (py-bool-to-scheme-int y-858)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-bintX-sintY-fallback x-860 y-861)
  (if (py-test (py-ge y-861 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bint-to-scheme x-860) (py-sint-to-scheme y-861)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-bintX-bintY-fallback x-863 y-864)
  (if (py-test (py-ge y-864 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bint-to-scheme x-863) (py-bint-to-scheme y-864)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-imatmul-floatX-floatY-fallback x-866 y-867)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'float' and 'float'"))))

(define (py-imatmul-floatX-boolY-fallback x-869 y-870)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'float' and 'bool'"))))

(define (py-imatmul-floatX-sintY-fallback x-872 y-873)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'float' and 'int'"))))

(define (py-imatmul-floatX-bintY-fallback x-875 y-876)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'float' and 'int'"))))

(define (py-imatmul-boolX-floatY-fallback x-878 y-879)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'bool' and 'float'"))))

(define (py-imatmul-boolX-boolY-fallback x-881 y-882)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'bool' and 'bool'"))))

(define (py-imatmul-boolX-sintY-fallback x-884 y-885)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'bool' and 'int'"))))

(define (py-imatmul-boolX-bintY-fallback x-887 y-888)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'bool' and 'int'"))))

(define (py-imatmul-sintX-floatY-fallback x-890 y-891)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'float'"))))

(define (py-imatmul-sintX-boolY-fallback x-893 y-894)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'bool'"))))

(define (py-imatmul-sintX-sintY-fallback x-896 y-897)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'int'"))))

(define (py-imatmul-sintX-bintY-fallback x-899 y-900)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'int'"))))

(define (py-imatmul-bintX-floatY-fallback x-902 y-903)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'float'"))))

(define (py-imatmul-bintX-boolY-fallback x-905 y-906)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'bool'"))))

(define (py-imatmul-bintX-sintY-fallback x-908 y-909)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'int'"))))

(define (py-imatmul-bintX-bintY-fallback x-911 y-912)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'int'"))))

(define (py-imod-floatX-floatY-fallback x-914 y-915)
  (if (py-test (py-ne y-915 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-float-to-scheme x-914) (py-float-to-scheme y-915)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-floatX-boolY-fallback x-917 y-918)
  (if (py-test (py-ne y-918 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py% (py-float-to-scheme x-917) (py-bool-to-scheme-int y-918)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-floatX-sintY-fallback x-920 y-921)
  (if (py-test (py-ne y-921 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py% (py-float-to-scheme x-920) (py-sint-to-scheme y-921)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-floatX-bintY-fallback x-923 y-924)
  (py-float-from-scheme
   (py% (py-float-to-scheme x-923) (py-bint-to-scheme y-924))))

(define (py-imod-boolX-floatY-fallback x-926 y-927)
  (if (py-test (py-ne y-927 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-bool-to-scheme-int x-926) (py-float-to-scheme y-927)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-boolX-boolY-fallback x-929 y-930)
  (if (py-test (py-ne y-930 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bool-to-scheme-int x-929) (py-bool-to-scheme-int y-930)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-boolX-sintY-fallback x-932 y-933)
  (if (py-test (py-ne y-933 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bool-to-scheme-int x-932) (py-sint-to-scheme y-933)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-boolX-bintY-fallback x-935 y-936)
  (py-int-from-scheme
   (py% (py-bool-to-scheme-int x-935) (py-bint-to-scheme y-936))))

(define (py-imod-sintX-floatY-fallback x-938 y-939)
  (if (py-test (py-ne y-939 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-sint-to-scheme x-938) (py-float-to-scheme y-939)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-sintX-boolY-fallback x-941 y-942)
  (if (py-test (py-ne y-942 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-sint-to-scheme x-941) (py-bool-to-scheme-int y-942)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-sintX-sintY-fallback x-944 y-945)
  (if (py-test (py-ne y-945 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-sint-to-scheme x-944) (py-sint-to-scheme y-945)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-sintX-bintY-fallback x-947 y-948)
  (py-int-from-scheme
   (py% (py-sint-to-scheme x-947) (py-bint-to-scheme y-948))))

(define (py-imod-bintX-floatY-fallback x-950 y-951)
  (if (py-test (py-ne y-951 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-bint-to-scheme x-950) (py-float-to-scheme y-951)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-bintX-boolY-fallback x-953 y-954)
  (if (py-test (py-ne y-954 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bint-to-scheme x-953) (py-bool-to-scheme-int y-954)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-bintX-sintY-fallback x-956 y-957)
  (if (py-test (py-ne y-957 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bint-to-scheme x-956) (py-sint-to-scheme y-957)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-bintX-bintY-fallback x-959 y-960)
  (py-int-from-scheme
   (py% (py-bint-to-scheme x-959) (py-bint-to-scheme y-960))))

(define (py-imul-floatX-floatY-fallback x-962 y-963)
  (py-float-from-scheme
   (py* (py-float-to-scheme x-962) (py-float-to-scheme y-963))))

(define (py-imul-floatX-boolY-fallback x-965 y-966)
  (py-float-from-scheme
   (py* (py-float-to-scheme x-965) (py-bool-to-scheme-int y-966))))

(define (py-imul-floatX-sintY-fallback x-968 y-969)
  (py-float-from-scheme
   (py* (py-float-to-scheme x-968) (py-sint-to-scheme y-969))))

(define (py-imul-floatX-bintY-fallback x-971 y-972)
  (py-float-from-scheme
   (py* (py-float-to-scheme x-971) (py-bint-to-scheme y-972))))

(define (py-imul-boolX-floatY-fallback x-974 y-975)
  (py-float-from-scheme
   (py* (py-bool-to-scheme-int x-974) (py-float-to-scheme y-975))))

(define (py-imul-boolX-boolY-fallback x-977 y-978)
  (py-int-from-scheme
   (py* (py-bool-to-scheme-int x-977) (py-bool-to-scheme-int y-978))))

(define (py-imul-boolX-sintY-fallback x-980 y-981)
  (py-int-from-scheme
   (py* (py-bool-to-scheme-int x-980) (py-sint-to-scheme y-981))))

(define (py-imul-boolX-bintY-fallback x-983 y-984)
  (py-int-from-scheme
   (py* (py-bool-to-scheme-int x-983) (py-bint-to-scheme y-984))))

(define (py-imul-sintX-floatY-fallback x-986 y-987)
  (py-float-from-scheme
   (py* (py-sint-to-scheme x-986) (py-float-to-scheme y-987))))

(define (py-imul-sintX-boolY-fallback x-989 y-990)
  (py-int-from-scheme
   (py* (py-sint-to-scheme x-989) (py-bool-to-scheme-int y-990))))

(define (py-imul-sintX-sintY-fallback x-992 y-993)
  (py-int-from-scheme
   (py* (py-sint-to-scheme x-992) (py-sint-to-scheme y-993))))

(define (py-imul-sintX-bintY-fallback x-995 y-996)
  (py-int-from-scheme
   (py* (py-sint-to-scheme x-995) (py-bint-to-scheme y-996))))

(define (py-imul-bintX-floatY-fallback x-998 y-999)
  (py-float-from-scheme
   (py* (py-bint-to-scheme x-998) (py-float-to-scheme y-999))))

(define (py-imul-bintX-boolY-fallback x-1001 y-1002)
  (py-int-from-scheme
   (py* (py-bint-to-scheme x-1001) (py-bool-to-scheme-int y-1002))))

(define (py-imul-bintX-sintY-fallback x-1004 y-1005)
  (py-int-from-scheme
   (py* (py-bint-to-scheme x-1004) (py-sint-to-scheme y-1005))))

(define (py-imul-bintX-bintY-fallback x-1007 y-1008)
  (py-int-from-scheme
   (py* (py-bint-to-scheme x-1007) (py-bint-to-scheme y-1008))))

(define (py-ipow-floatX-floatY-fallback x-1010 y-1011)
  (py-float-from-scheme
   (py** (py-float-to-scheme x-1010) (py-float-to-scheme y-1011))))

(define (py-ipow-floatX-boolY-fallback x-1013 y-1014)
  (py-float-from-scheme
   (py** (py-float-to-scheme x-1013) (py-bool-to-scheme-int y-1014))))

(define (py-ipow-floatX-sintY-fallback x-1016 y-1017)
  (py-float-from-scheme
   (py** (py-float-to-scheme x-1016) (py-sint-to-scheme y-1017))))

(define (py-ipow-floatX-bintY-fallback x-1019 y-1020)
  (py-float-from-scheme
   (py** (py-float-to-scheme x-1019) (py-bint-to-scheme y-1020))))

(define (py-ipow-boolX-floatY-fallback x-1022 y-1023)
  (py-float-from-scheme
   (py** (py-bool-to-scheme-int x-1022) (py-float-to-scheme y-1023))))

(define (py-ipow-boolX-boolY-fallback x-1025 y-1026)
  (py-int-from-scheme
   (py** (py-bool-to-scheme-int x-1025) (py-bool-to-scheme-int y-1026))))

(define (py-ipow-boolX-sintY-fallback x-1028 y-1029)
  (py-int-from-scheme
   (py** (py-bool-to-scheme-int x-1028) (py-sint-to-scheme y-1029))))

(define (py-ipow-boolX-bintY-fallback x-1031 y-1032)
  (py-int-from-scheme
   (py** (py-bool-to-scheme-int x-1031) (py-bint-to-scheme y-1032))))

(define (py-ipow-sintX-floatY-fallback x-1034 y-1035)
  (py-float-from-scheme
   (py** (py-sint-to-scheme x-1034) (py-float-to-scheme y-1035))))

(define (py-ipow-sintX-boolY-fallback x-1037 y-1038)
  (py-int-from-scheme
   (py** (py-sint-to-scheme x-1037) (py-bool-to-scheme-int y-1038))))

(define (py-ipow-sintX-sintY-fallback x-1040 y-1041)
  (py-int-from-scheme
   (py** (py-sint-to-scheme x-1040) (py-sint-to-scheme y-1041))))

(define (py-ipow-sintX-bintY-fallback x-1043 y-1044)
  (py-int-from-scheme
   (py** (py-sint-to-scheme x-1043) (py-bint-to-scheme y-1044))))

(define (py-ipow-bintX-floatY-fallback x-1046 y-1047)
  (py-float-from-scheme
   (py** (py-bint-to-scheme x-1046) (py-float-to-scheme y-1047))))

(define (py-ipow-bintX-boolY-fallback x-1049 y-1050)
  (py-int-from-scheme
   (py** (py-bint-to-scheme x-1049) (py-bool-to-scheme-int y-1050))))

(define (py-ipow-bintX-sintY-fallback x-1052 y-1053)
  (py-int-from-scheme
   (py** (py-bint-to-scheme x-1052) (py-sint-to-scheme y-1053))))

(define (py-ipow-bintX-bintY-fallback x-1055 y-1056)
  (py-int-from-scheme
   (py** (py-bint-to-scheme x-1055) (py-bint-to-scheme y-1056))))

(define (py-irshift-floatX-floatY-fallback x-1058 y-1059)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'float' and 'float'"))))

(define (py-irshift-floatX-boolY-fallback x-1061 y-1062)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'float' and 'bool'"))))

(define (py-irshift-floatX-sintY-fallback x-1064 y-1065)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'float' and 'int'"))))

(define (py-irshift-floatX-bintY-fallback x-1067 y-1068)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'float' and 'int'"))))

(define (py-irshift-boolX-floatY-fallback x-1070 y-1071)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'bool' and 'float'"))))

(define (py-irshift-boolX-boolY-fallback x-1073 y-1074)
  (if (py-test (py-ge y-1074 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bool-to-scheme-int x-1073) (py-bool-to-scheme-int y-1074)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-boolX-sintY-fallback x-1076 y-1077)
  (if (py-test (py-ge y-1077 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bool-to-scheme-int x-1076) (py-sint-to-scheme y-1077)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-boolX-bintY-fallback x-1079 y-1080)
  (if (py-test (py-ge y-1080 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bool-to-scheme-int x-1079) (py-bint-to-scheme y-1080)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-sintX-floatY-fallback x-1082 y-1083)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'int' and 'float'"))))

(define (py-irshift-sintX-boolY-fallback x-1085 y-1086)
  (if (py-test (py-ge y-1086 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-sint-to-scheme x-1085) (py-bool-to-scheme-int y-1086)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-sintX-sintY-fallback x-1088 y-1089)
  (if (py-test (py-ge y-1089 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-sint-to-scheme x-1088) (py-sint-to-scheme y-1089)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-sintX-bintY-fallback x-1091 y-1092)
  (if (py-test (py-ge y-1092 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-sint-to-scheme x-1091) (py-bint-to-scheme y-1092)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-bintX-floatY-fallback x-1094 y-1095)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'int' and 'float'"))))

(define (py-irshift-bintX-boolY-fallback x-1097 y-1098)
  (if (py-test (py-ge y-1098 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bint-to-scheme x-1097) (py-bool-to-scheme-int y-1098)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-bintX-sintY-fallback x-1100 y-1101)
  (if (py-test (py-ge y-1101 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bint-to-scheme x-1100) (py-sint-to-scheme y-1101)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-bintX-bintY-fallback x-1103 y-1104)
  (if (py-test (py-ge y-1104 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bint-to-scheme x-1103) (py-bint-to-scheme y-1104)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-isub-floatX-floatY-fallback x-1106 y-1107)
  (py-float-from-scheme
   (py- (py-float-to-scheme x-1106) (py-float-to-scheme y-1107))))

(define (py-isub-floatX-boolY-fallback x-1109 y-1110)
  (py-float-from-scheme
   (py- (py-float-to-scheme x-1109) (py-bool-to-scheme-int y-1110))))

(define (py-isub-floatX-sintY-fallback x-1112 y-1113)
  (py-float-from-scheme
   (py- (py-float-to-scheme x-1112) (py-sint-to-scheme y-1113))))

(define (py-isub-floatX-bintY-fallback x-1115 y-1116)
  (py-float-from-scheme
   (py- (py-float-to-scheme x-1115) (py-bint-to-scheme y-1116))))

(define (py-isub-boolX-floatY-fallback x-1118 y-1119)
  (py-float-from-scheme
   (py- (py-bool-to-scheme-int x-1118) (py-float-to-scheme y-1119))))

(define (py-isub-boolX-boolY-fallback x-1121 y-1122)
  (py-int-from-scheme
   (py- (py-bool-to-scheme-int x-1121) (py-bool-to-scheme-int y-1122))))

(define (py-isub-boolX-sintY-fallback x-1124 y-1125)
  (py-int-from-scheme
   (py- (py-bool-to-scheme-int x-1124) (py-sint-to-scheme y-1125))))

(define (py-isub-boolX-bintY-fallback x-1127 y-1128)
  (py-int-from-scheme
   (py- (py-bool-to-scheme-int x-1127) (py-bint-to-scheme y-1128))))

(define (py-isub-sintX-floatY-fallback x-1130 y-1131)
  (py-float-from-scheme
   (py- (py-sint-to-scheme x-1130) (py-float-to-scheme y-1131))))

(define (py-isub-sintX-boolY-fallback x-1133 y-1134)
  (py-int-from-scheme
   (py- (py-sint-to-scheme x-1133) (py-bool-to-scheme-int y-1134))))

(define (py-isub-sintX-sintY-fallback x-1136 y-1137)
  (py-int-from-scheme
   (py- (py-sint-to-scheme x-1136) (py-sint-to-scheme y-1137))))

(define (py-isub-sintX-bintY-fallback x-1139 y-1140)
  (py-int-from-scheme
   (py- (py-sint-to-scheme x-1139) (py-bint-to-scheme y-1140))))

(define (py-isub-bintX-floatY-fallback x-1142 y-1143)
  (py-float-from-scheme
   (py- (py-bint-to-scheme x-1142) (py-float-to-scheme y-1143))))

(define (py-isub-bintX-boolY-fallback x-1145 y-1146)
  (py-int-from-scheme
   (py- (py-bint-to-scheme x-1145) (py-bool-to-scheme-int y-1146))))

(define (py-isub-bintX-sintY-fallback x-1148 y-1149)
  (py-int-from-scheme
   (py- (py-bint-to-scheme x-1148) (py-sint-to-scheme y-1149))))

(define (py-isub-bintX-bintY-fallback x-1151 y-1152)
  (py-int-from-scheme
   (py- (py-bint-to-scheme x-1151) (py-bint-to-scheme y-1152))))

(define (py-itruediv-floatX-floatY-fallback x-1154 y-1155)
  (if (py-test (py-ne y-1155 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme x-1154) (py-float-to-scheme y-1155)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-floatX-boolY-fallback x-1157 y-1158)
  (if (py-test (py-ne y-1158 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme x-1157) (py-bool-to-scheme-int y-1158)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-floatX-sintY-fallback x-1160 y-1161)
  (if (py-test (py-ne y-1161 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme x-1160) (py-sint-to-scheme y-1161)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-floatX-bintY-fallback x-1163 y-1164)
  (py-float-from-scheme
   (py/ (py-float-to-scheme x-1163) (py-bint-to-scheme y-1164))))

(define (py-itruediv-boolX-floatY-fallback x-1166 y-1167)
  (if (py-test (py-ne y-1167 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme-int x-1166) (py-float-to-scheme y-1167)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-boolX-boolY-fallback x-1169 y-1170)
  (if (py-test (py-ne y-1170 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme-int x-1169) (py-bool-to-scheme-int y-1170)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-boolX-sintY-fallback x-1172 y-1173)
  (if (py-test (py-ne y-1173 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme-int x-1172) (py-sint-to-scheme y-1173)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-boolX-bintY-fallback x-1175 y-1176)
  (py-float-from-scheme
   (py/ (py-bool-to-scheme-int x-1175) (py-bint-to-scheme y-1176))))

(define (py-itruediv-sintX-floatY-fallback x-1178 y-1179)
  (if (py-test (py-ne y-1179 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme x-1178) (py-float-to-scheme y-1179)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-sintX-boolY-fallback x-1181 y-1182)
  (if (py-test (py-ne y-1182 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme x-1181) (py-bool-to-scheme-int y-1182)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-sintX-sintY-fallback x-1184 y-1185)
  (if (py-test (py-ne y-1185 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme x-1184) (py-sint-to-scheme y-1185)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-sintX-bintY-fallback x-1187 y-1188)
  (py-float-from-scheme
   (py/ (py-sint-to-scheme x-1187) (py-bint-to-scheme y-1188))))

(define (py-itruediv-bintX-floatY-fallback x-1190 y-1191)
  (if (py-test (py-ne y-1191 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme x-1190) (py-float-to-scheme y-1191)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-bintX-boolY-fallback x-1193 y-1194)
  (if (py-test (py-ne y-1194 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme x-1193) (py-bool-to-scheme-int y-1194)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-bintX-sintY-fallback x-1196 y-1197)
  (if (py-test (py-ne y-1197 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme x-1196) (py-sint-to-scheme y-1197)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-bintX-bintY-fallback x-1199 y-1200)
  (py-float-from-scheme
   (py/ (py-bint-to-scheme x-1199) (py-bint-to-scheme y-1200))))

(define (py-ixor-floatX-floatY-fallback x-1202 y-1203)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'float' and 'float'"))))

(define (py-ixor-floatX-boolY-fallback x-1205 y-1206)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'float' and 'bool'"))))

(define (py-ixor-floatX-sintY-fallback x-1208 y-1209)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'float' and 'int'"))))

(define (py-ixor-floatX-bintY-fallback x-1211 y-1212)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'float' and 'int'"))))

(define (py-ixor-boolX-floatY-fallback x-1214 y-1215)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'bool' and 'float'"))))

(define (py-ixor-boolX-boolY-fallback x-1217 y-1218)
  (py-int-from-scheme
   (py^ (py-bool-to-scheme-int x-1217) (py-bool-to-scheme-int y-1218))))

(define (py-ixor-boolX-sintY-fallback x-1220 y-1221)
  (py-int-from-scheme
   (py^ (py-bool-to-scheme-int x-1220) (py-sint-to-scheme y-1221))))

(define (py-ixor-boolX-bintY-fallback x-1223 y-1224)
  (py-int-from-scheme
   (py^ (py-bool-to-scheme-int x-1223) (py-bint-to-scheme y-1224))))

(define (py-ixor-sintX-floatY-fallback x-1226 y-1227)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'int' and 'float'"))))

(define (py-ixor-sintX-boolY-fallback x-1229 y-1230)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme x-1229) (py-bool-to-scheme-int y-1230))))

(define (py-ixor-sintX-sintY-fallback x-1232 y-1233)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme x-1232) (py-sint-to-scheme y-1233))))

(define (py-ixor-sintX-bintY-fallback x-1235 y-1236)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme x-1235) (py-bint-to-scheme y-1236))))

(define (py-ixor-bintX-floatY-fallback x-1238 y-1239)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'int' and 'float'"))))

(define (py-ixor-bintX-boolY-fallback x-1241 y-1242)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme x-1241) (py-bool-to-scheme-int y-1242))))

(define (py-ixor-bintX-sintY-fallback x-1244 y-1245)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme x-1244) (py-sint-to-scheme y-1245))))

(define (py-ixor-bintX-bintY-fallback x-1247 y-1248)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme x-1247) (py-bint-to-scheme y-1248))))

(define (py-ge-floatX-floatY-fallback x-1250 y-1251)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-float-to-scheme x-1250) (py-float-to-scheme y-1251)))))

(define (py-test-ge-floatX-floatY-fallback x-1253 y-1254)
  (py-test-from-scheme
   (py>= (py-float-to-scheme x-1253) (py-float-to-scheme y-1254))))

(define (py-ge-floatX-boolY-fallback x-1256 y-1257)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-float-to-scheme x-1256) (py-bool-to-scheme-int y-1257)))))

(define (py-test-ge-floatX-boolY-fallback x-1259 y-1260)
  (py-test-from-scheme
   (py>= (py-float-to-scheme x-1259) (py-bool-to-scheme-int y-1260))))

(define (py-ge-floatX-sintY-fallback x-1262 y-1263)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-float-to-scheme x-1262) (py-sint-to-scheme y-1263)))))

(define (py-test-ge-floatX-sintY-fallback x-1265 y-1266)
  (py-test-from-scheme
   (py>= (py-float-to-scheme x-1265) (py-sint-to-scheme y-1266))))

(define (py-ge-floatX-bintY-fallback x-1268 y-1269)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-float-to-scheme x-1268) (py-bint-to-scheme y-1269)))))

(define (py-test-ge-floatX-bintY-fallback x-1271 y-1272)
  (py-test-from-scheme
   (py>= (py-float-to-scheme x-1271) (py-bint-to-scheme y-1272))))

(define (py-ge-boolX-floatY-fallback x-1274 y-1275)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-float-to-scheme y-1275) (py-bool-to-scheme-int x-1274)))))

(define (py-test-ge-boolX-floatY-fallback x-1277 y-1278)
  (py-test-from-scheme
   (py<= (py-float-to-scheme y-1278) (py-bool-to-scheme-int x-1277))))

(define (py-ge-boolX-boolY-fallback x-1280 y-1281)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-bool-to-scheme-int x-1280) (py-bool-to-scheme-int y-1281)))))

(define (py-test-ge-boolX-boolY-fallback x-1283 y-1284)
  (py-test-from-scheme
   (py>= (py-bool-to-scheme-int x-1283) (py-bool-to-scheme-int y-1284))))

(define (py-ge-boolX-sintY-fallback x-1286 y-1287)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-bool-to-scheme-int x-1286) (py-sint-to-scheme y-1287)))))

(define (py-test-ge-boolX-sintY-fallback x-1289 y-1290)
  (py-test-from-scheme
   (py>= (py-bool-to-scheme-int x-1289) (py-sint-to-scheme y-1290))))

(define (py-ge-boolX-bintY-fallback x-1292 y-1293)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-bool-to-scheme-int x-1292) (py-bint-to-scheme y-1293)))))

(define (py-test-ge-boolX-bintY-fallback x-1295 y-1296)
  (py-test-from-scheme
   (py>= (py-bool-to-scheme-int x-1295) (py-bint-to-scheme y-1296))))

(define (py-ge-sintX-floatY-fallback x-1298 y-1299)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-float-to-scheme y-1299) (py-sint-to-scheme x-1298)))))

(define (py-test-ge-sintX-floatY-fallback x-1301 y-1302)
  (py-test-from-scheme
   (py<= (py-float-to-scheme y-1302) (py-sint-to-scheme x-1301))))

(define (py-ge-sintX-boolY-fallback x-1304 y-1305)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-sint-to-scheme x-1304) (py-bool-to-scheme-int y-1305)))))

(define (py-test-ge-sintX-boolY-fallback x-1307 y-1308)
  (py-test-from-scheme
   (py>= (py-sint-to-scheme x-1307) (py-bool-to-scheme-int y-1308))))

(define (py-ge-sintX-sintY-fallback x-1310 y-1311)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-sint-to-scheme x-1310) (py-sint-to-scheme y-1311)))))

(define (py-test-ge-sintX-sintY-fallback x-1313 y-1314)
  (py-test-from-scheme
   (py>= (py-sint-to-scheme x-1313) (py-sint-to-scheme y-1314))))

(define (py-ge-sintX-bintY-fallback x-1316 y-1317)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-sint-to-scheme x-1316) (py-bint-to-scheme y-1317)))))

(define (py-test-ge-sintX-bintY-fallback x-1319 y-1320)
  (py-test-from-scheme
   (py>= (py-sint-to-scheme x-1319) (py-bint-to-scheme y-1320))))

(define (py-ge-bintX-floatY-fallback x-1322 y-1323)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-float-to-scheme y-1323) (py-bint-to-scheme x-1322)))))

(define (py-test-ge-bintX-floatY-fallback x-1325 y-1326)
  (py-test-from-scheme
   (py<= (py-float-to-scheme y-1326) (py-bint-to-scheme x-1325))))

(define (py-ge-bintX-boolY-fallback x-1328 y-1329)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-bint-to-scheme x-1328) (py-bool-to-scheme-int y-1329)))))

(define (py-test-ge-bintX-boolY-fallback x-1331 y-1332)
  (py-test-from-scheme
   (py>= (py-bint-to-scheme x-1331) (py-bool-to-scheme-int y-1332))))

(define (py-ge-bintX-sintY-fallback x-1334 y-1335)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-bint-to-scheme x-1334) (py-sint-to-scheme y-1335)))))

(define (py-test-ge-bintX-sintY-fallback x-1337 y-1338)
  (py-test-from-scheme
   (py>= (py-bint-to-scheme x-1337) (py-sint-to-scheme y-1338))))

(define (py-ge-bintX-bintY-fallback x-1340 y-1341)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-bint-to-scheme x-1340) (py-bint-to-scheme y-1341)))))

(define (py-test-ge-bintX-bintY-fallback x-1343 y-1344)
  (py-test-from-scheme
   (py>= (py-bint-to-scheme x-1343) (py-bint-to-scheme y-1344))))

(define (py-gt-floatX-floatY-fallback x-1346 y-1347)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-float-to-scheme x-1346) (py-float-to-scheme y-1347)))))

(define (py-test-gt-floatX-floatY-fallback x-1349 y-1350)
  (py-test-from-scheme
   (py> (py-float-to-scheme x-1349) (py-float-to-scheme y-1350))))

(define (py-gt-floatX-boolY-fallback x-1352 y-1353)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-float-to-scheme x-1352) (py-bool-to-scheme-int y-1353)))))

(define (py-test-gt-floatX-boolY-fallback x-1355 y-1356)
  (py-test-from-scheme
   (py> (py-float-to-scheme x-1355) (py-bool-to-scheme-int y-1356))))

(define (py-gt-floatX-sintY-fallback x-1358 y-1359)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-float-to-scheme x-1358) (py-sint-to-scheme y-1359)))))

(define (py-test-gt-floatX-sintY-fallback x-1361 y-1362)
  (py-test-from-scheme
   (py> (py-float-to-scheme x-1361) (py-sint-to-scheme y-1362))))

(define (py-gt-floatX-bintY-fallback x-1364 y-1365)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-float-to-scheme x-1364) (py-bint-to-scheme y-1365)))))

(define (py-test-gt-floatX-bintY-fallback x-1367 y-1368)
  (py-test-from-scheme
   (py> (py-float-to-scheme x-1367) (py-bint-to-scheme y-1368))))

(define (py-gt-boolX-floatY-fallback x-1370 y-1371)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-float-to-scheme y-1371) (py-bool-to-scheme-int x-1370)))))

(define (py-test-gt-boolX-floatY-fallback x-1373 y-1374)
  (py-test-from-scheme
   (py< (py-float-to-scheme y-1374) (py-bool-to-scheme-int x-1373))))

(define (py-gt-boolX-boolY-fallback x-1376 y-1377)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-bool-to-scheme-int x-1376) (py-bool-to-scheme-int y-1377)))))

(define (py-test-gt-boolX-boolY-fallback x-1379 y-1380)
  (py-test-from-scheme
   (py> (py-bool-to-scheme-int x-1379) (py-bool-to-scheme-int y-1380))))

(define (py-gt-boolX-sintY-fallback x-1382 y-1383)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-bool-to-scheme-int x-1382) (py-sint-to-scheme y-1383)))))

(define (py-test-gt-boolX-sintY-fallback x-1385 y-1386)
  (py-test-from-scheme
   (py> (py-bool-to-scheme-int x-1385) (py-sint-to-scheme y-1386))))

(define (py-gt-boolX-bintY-fallback x-1388 y-1389)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-bool-to-scheme-int x-1388) (py-bint-to-scheme y-1389)))))

(define (py-test-gt-boolX-bintY-fallback x-1391 y-1392)
  (py-test-from-scheme
   (py> (py-bool-to-scheme-int x-1391) (py-bint-to-scheme y-1392))))

(define (py-gt-sintX-floatY-fallback x-1394 y-1395)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-float-to-scheme y-1395) (py-sint-to-scheme x-1394)))))

(define (py-test-gt-sintX-floatY-fallback x-1397 y-1398)
  (py-test-from-scheme
   (py< (py-float-to-scheme y-1398) (py-sint-to-scheme x-1397))))

(define (py-gt-sintX-boolY-fallback x-1400 y-1401)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-sint-to-scheme x-1400) (py-bool-to-scheme-int y-1401)))))

(define (py-test-gt-sintX-boolY-fallback x-1403 y-1404)
  (py-test-from-scheme
   (py> (py-sint-to-scheme x-1403) (py-bool-to-scheme-int y-1404))))

(define (py-gt-sintX-sintY-fallback x-1406 y-1407)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-sint-to-scheme x-1406) (py-sint-to-scheme y-1407)))))

(define (py-test-gt-sintX-sintY-fallback x-1409 y-1410)
  (py-test-from-scheme
   (py> (py-sint-to-scheme x-1409) (py-sint-to-scheme y-1410))))

(define (py-gt-sintX-bintY-fallback x-1412 y-1413)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-sint-to-scheme x-1412) (py-bint-to-scheme y-1413)))))

(define (py-test-gt-sintX-bintY-fallback x-1415 y-1416)
  (py-test-from-scheme
   (py> (py-sint-to-scheme x-1415) (py-bint-to-scheme y-1416))))

(define (py-gt-bintX-floatY-fallback x-1418 y-1419)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-float-to-scheme y-1419) (py-bint-to-scheme x-1418)))))

(define (py-test-gt-bintX-floatY-fallback x-1421 y-1422)
  (py-test-from-scheme
   (py< (py-float-to-scheme y-1422) (py-bint-to-scheme x-1421))))

(define (py-gt-bintX-boolY-fallback x-1424 y-1425)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-bint-to-scheme x-1424) (py-bool-to-scheme-int y-1425)))))

(define (py-test-gt-bintX-boolY-fallback x-1427 y-1428)
  (py-test-from-scheme
   (py> (py-bint-to-scheme x-1427) (py-bool-to-scheme-int y-1428))))

(define (py-gt-bintX-sintY-fallback x-1430 y-1431)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-bint-to-scheme x-1430) (py-sint-to-scheme y-1431)))))

(define (py-test-gt-bintX-sintY-fallback x-1433 y-1434)
  (py-test-from-scheme
   (py> (py-bint-to-scheme x-1433) (py-sint-to-scheme y-1434))))

(define (py-gt-bintX-bintY-fallback x-1436 y-1437)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-bint-to-scheme x-1436) (py-bint-to-scheme y-1437)))))

(define (py-test-gt-bintX-bintY-fallback x-1439 y-1440)
  (py-test-from-scheme
   (py> (py-bint-to-scheme x-1439) (py-bint-to-scheme y-1440))))

(define (py-le-floatX-floatY-fallback x-1442 y-1443)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-float-to-scheme x-1442) (py-float-to-scheme y-1443)))))

(define (py-test-le-floatX-floatY-fallback x-1445 y-1446)
  (py-test-from-scheme
   (py<= (py-float-to-scheme x-1445) (py-float-to-scheme y-1446))))

(define (py-le-floatX-boolY-fallback x-1448 y-1449)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-float-to-scheme x-1448) (py-bool-to-scheme-int y-1449)))))

(define (py-test-le-floatX-boolY-fallback x-1451 y-1452)
  (py-test-from-scheme
   (py<= (py-float-to-scheme x-1451) (py-bool-to-scheme-int y-1452))))

(define (py-le-floatX-sintY-fallback x-1454 y-1455)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-float-to-scheme x-1454) (py-sint-to-scheme y-1455)))))

(define (py-test-le-floatX-sintY-fallback x-1457 y-1458)
  (py-test-from-scheme
   (py<= (py-float-to-scheme x-1457) (py-sint-to-scheme y-1458))))

(define (py-le-floatX-bintY-fallback x-1460 y-1461)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-float-to-scheme x-1460) (py-bint-to-scheme y-1461)))))

(define (py-test-le-floatX-bintY-fallback x-1463 y-1464)
  (py-test-from-scheme
   (py<= (py-float-to-scheme x-1463) (py-bint-to-scheme y-1464))))

(define (py-le-boolX-floatY-fallback x-1466 y-1467)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-float-to-scheme y-1467) (py-bool-to-scheme-int x-1466)))))

(define (py-test-le-boolX-floatY-fallback x-1469 y-1470)
  (py-test-from-scheme
   (py>= (py-float-to-scheme y-1470) (py-bool-to-scheme-int x-1469))))

(define (py-le-boolX-boolY-fallback x-1472 y-1473)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-bool-to-scheme-int x-1472) (py-bool-to-scheme-int y-1473)))))

(define (py-test-le-boolX-boolY-fallback x-1475 y-1476)
  (py-test-from-scheme
   (py<= (py-bool-to-scheme-int x-1475) (py-bool-to-scheme-int y-1476))))

(define (py-le-boolX-sintY-fallback x-1478 y-1479)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-bool-to-scheme-int x-1478) (py-sint-to-scheme y-1479)))))

(define (py-test-le-boolX-sintY-fallback x-1481 y-1482)
  (py-test-from-scheme
   (py<= (py-bool-to-scheme-int x-1481) (py-sint-to-scheme y-1482))))

(define (py-le-boolX-bintY-fallback x-1484 y-1485)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-bool-to-scheme-int x-1484) (py-bint-to-scheme y-1485)))))

(define (py-test-le-boolX-bintY-fallback x-1487 y-1488)
  (py-test-from-scheme
   (py<= (py-bool-to-scheme-int x-1487) (py-bint-to-scheme y-1488))))

(define (py-le-sintX-floatY-fallback x-1490 y-1491)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-float-to-scheme y-1491) (py-sint-to-scheme x-1490)))))

(define (py-test-le-sintX-floatY-fallback x-1493 y-1494)
  (py-test-from-scheme
   (py>= (py-float-to-scheme y-1494) (py-sint-to-scheme x-1493))))

(define (py-le-sintX-boolY-fallback x-1496 y-1497)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-sint-to-scheme x-1496) (py-bool-to-scheme-int y-1497)))))

(define (py-test-le-sintX-boolY-fallback x-1499 y-1500)
  (py-test-from-scheme
   (py<= (py-sint-to-scheme x-1499) (py-bool-to-scheme-int y-1500))))

(define (py-le-sintX-sintY-fallback x-1502 y-1503)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-sint-to-scheme x-1502) (py-sint-to-scheme y-1503)))))

(define (py-test-le-sintX-sintY-fallback x-1505 y-1506)
  (py-test-from-scheme
   (py<= (py-sint-to-scheme x-1505) (py-sint-to-scheme y-1506))))

(define (py-le-sintX-bintY-fallback x-1508 y-1509)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-sint-to-scheme x-1508) (py-bint-to-scheme y-1509)))))

(define (py-test-le-sintX-bintY-fallback x-1511 y-1512)
  (py-test-from-scheme
   (py<= (py-sint-to-scheme x-1511) (py-bint-to-scheme y-1512))))

(define (py-le-bintX-floatY-fallback x-1514 y-1515)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-float-to-scheme y-1515) (py-bint-to-scheme x-1514)))))

(define (py-test-le-bintX-floatY-fallback x-1517 y-1518)
  (py-test-from-scheme
   (py>= (py-float-to-scheme y-1518) (py-bint-to-scheme x-1517))))

(define (py-le-bintX-boolY-fallback x-1520 y-1521)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-bint-to-scheme x-1520) (py-bool-to-scheme-int y-1521)))))

(define (py-test-le-bintX-boolY-fallback x-1523 y-1524)
  (py-test-from-scheme
   (py<= (py-bint-to-scheme x-1523) (py-bool-to-scheme-int y-1524))))

(define (py-le-bintX-sintY-fallback x-1526 y-1527)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-bint-to-scheme x-1526) (py-sint-to-scheme y-1527)))))

(define (py-test-le-bintX-sintY-fallback x-1529 y-1530)
  (py-test-from-scheme
   (py<= (py-bint-to-scheme x-1529) (py-sint-to-scheme y-1530))))

(define (py-le-bintX-bintY-fallback x-1532 y-1533)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-bint-to-scheme x-1532) (py-bint-to-scheme y-1533)))))

(define (py-test-le-bintX-bintY-fallback x-1535 y-1536)
  (py-test-from-scheme
   (py<= (py-bint-to-scheme x-1535) (py-bint-to-scheme y-1536))))

(define (py-lt-floatX-floatY-fallback x-1538 y-1539)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-float-to-scheme x-1538) (py-float-to-scheme y-1539)))))

(define (py-test-lt-floatX-floatY-fallback x-1541 y-1542)
  (py-test-from-scheme
   (py< (py-float-to-scheme x-1541) (py-float-to-scheme y-1542))))

(define (py-lt-floatX-boolY-fallback x-1544 y-1545)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-float-to-scheme x-1544) (py-bool-to-scheme-int y-1545)))))

(define (py-test-lt-floatX-boolY-fallback x-1547 y-1548)
  (py-test-from-scheme
   (py< (py-float-to-scheme x-1547) (py-bool-to-scheme-int y-1548))))

(define (py-lt-floatX-sintY-fallback x-1550 y-1551)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-float-to-scheme x-1550) (py-sint-to-scheme y-1551)))))

(define (py-test-lt-floatX-sintY-fallback x-1553 y-1554)
  (py-test-from-scheme
   (py< (py-float-to-scheme x-1553) (py-sint-to-scheme y-1554))))

(define (py-lt-floatX-bintY-fallback x-1556 y-1557)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-float-to-scheme x-1556) (py-bint-to-scheme y-1557)))))

(define (py-test-lt-floatX-bintY-fallback x-1559 y-1560)
  (py-test-from-scheme
   (py< (py-float-to-scheme x-1559) (py-bint-to-scheme y-1560))))

(define (py-lt-boolX-floatY-fallback x-1562 y-1563)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-float-to-scheme y-1563) (py-bool-to-scheme-int x-1562)))))

(define (py-test-lt-boolX-floatY-fallback x-1565 y-1566)
  (py-test-from-scheme
   (py> (py-float-to-scheme y-1566) (py-bool-to-scheme-int x-1565))))

(define (py-lt-boolX-boolY-fallback x-1568 y-1569)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-bool-to-scheme-int x-1568) (py-bool-to-scheme-int y-1569)))))

(define (py-test-lt-boolX-boolY-fallback x-1571 y-1572)
  (py-test-from-scheme
   (py< (py-bool-to-scheme-int x-1571) (py-bool-to-scheme-int y-1572))))

(define (py-lt-boolX-sintY-fallback x-1574 y-1575)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-bool-to-scheme-int x-1574) (py-sint-to-scheme y-1575)))))

(define (py-test-lt-boolX-sintY-fallback x-1577 y-1578)
  (py-test-from-scheme
   (py< (py-bool-to-scheme-int x-1577) (py-sint-to-scheme y-1578))))

(define (py-lt-boolX-bintY-fallback x-1580 y-1581)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-bool-to-scheme-int x-1580) (py-bint-to-scheme y-1581)))))

(define (py-test-lt-boolX-bintY-fallback x-1583 y-1584)
  (py-test-from-scheme
   (py< (py-bool-to-scheme-int x-1583) (py-bint-to-scheme y-1584))))

(define (py-lt-sintX-floatY-fallback x-1586 y-1587)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-float-to-scheme y-1587) (py-sint-to-scheme x-1586)))))

(define (py-test-lt-sintX-floatY-fallback x-1589 y-1590)
  (py-test-from-scheme
   (py> (py-float-to-scheme y-1590) (py-sint-to-scheme x-1589))))

(define (py-lt-sintX-boolY-fallback x-1592 y-1593)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-sint-to-scheme x-1592) (py-bool-to-scheme-int y-1593)))))

(define (py-test-lt-sintX-boolY-fallback x-1595 y-1596)
  (py-test-from-scheme
   (py< (py-sint-to-scheme x-1595) (py-bool-to-scheme-int y-1596))))

(define (py-lt-sintX-sintY-fallback x-1598 y-1599)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-sint-to-scheme x-1598) (py-sint-to-scheme y-1599)))))

(define (py-test-lt-sintX-sintY-fallback x-1601 y-1602)
  (py-test-from-scheme
   (py< (py-sint-to-scheme x-1601) (py-sint-to-scheme y-1602))))

(define (py-lt-sintX-bintY-fallback x-1604 y-1605)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-sint-to-scheme x-1604) (py-bint-to-scheme y-1605)))))

(define (py-test-lt-sintX-bintY-fallback x-1607 y-1608)
  (py-test-from-scheme
   (py< (py-sint-to-scheme x-1607) (py-bint-to-scheme y-1608))))

(define (py-lt-bintX-floatY-fallback x-1610 y-1611)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-float-to-scheme y-1611) (py-bint-to-scheme x-1610)))))

(define (py-test-lt-bintX-floatY-fallback x-1613 y-1614)
  (py-test-from-scheme
   (py> (py-float-to-scheme y-1614) (py-bint-to-scheme x-1613))))

(define (py-lt-bintX-boolY-fallback x-1616 y-1617)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-bint-to-scheme x-1616) (py-bool-to-scheme-int y-1617)))))

(define (py-test-lt-bintX-boolY-fallback x-1619 y-1620)
  (py-test-from-scheme
   (py< (py-bint-to-scheme x-1619) (py-bool-to-scheme-int y-1620))))

(define (py-lt-bintX-sintY-fallback x-1622 y-1623)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-bint-to-scheme x-1622) (py-sint-to-scheme y-1623)))))

(define (py-test-lt-bintX-sintY-fallback x-1625 y-1626)
  (py-test-from-scheme
   (py< (py-bint-to-scheme x-1625) (py-sint-to-scheme y-1626))))

(define (py-lt-bintX-bintY-fallback x-1628 y-1629)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-bint-to-scheme x-1628) (py-bint-to-scheme y-1629)))))

(define (py-test-lt-bintX-bintY-fallback x-1631 y-1632)
  (py-test-from-scheme
   (py< (py-bint-to-scheme x-1631) (py-bint-to-scheme y-1632))))

(define (py-eq-floatX-floatY-fallback x-1634 y-1635)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-float-to-scheme x-1634) (py-float-to-scheme y-1635)))))

(define (py-test-eq-floatX-floatY-fallback x-1637 y-1638)
  (py-test-from-scheme
   (py== (py-float-to-scheme x-1637) (py-float-to-scheme y-1638))))

(define (py-eq-floatX-boolY-fallback x-1640 y-1641)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-float-to-scheme x-1640) (py-bool-to-scheme-int y-1641)))))

(define (py-test-eq-floatX-boolY-fallback x-1643 y-1644)
  (py-test-from-scheme
   (py== (py-float-to-scheme x-1643) (py-bool-to-scheme-int y-1644))))

(define (py-eq-floatX-sintY-fallback x-1646 y-1647)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-float-to-scheme x-1646) (py-sint-to-scheme y-1647)))))

(define (py-test-eq-floatX-sintY-fallback x-1649 y-1650)
  (py-test-from-scheme
   (py== (py-float-to-scheme x-1649) (py-sint-to-scheme y-1650))))

(define (py-eq-floatX-bintY-fallback x-1652 y-1653)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-float-to-scheme x-1652) (py-bint-to-scheme y-1653)))))

(define (py-test-eq-floatX-bintY-fallback x-1655 y-1656)
  (py-test-from-scheme
   (py== (py-float-to-scheme x-1655) (py-bint-to-scheme y-1656))))

(define (py-eq-boolX-floatY-fallback x-1658 y-1659)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-float-to-scheme y-1659) (py-bool-to-scheme-int x-1658)))))

(define (py-test-eq-boolX-floatY-fallback x-1661 y-1662)
  (py-test-from-scheme
   (py== (py-float-to-scheme y-1662) (py-bool-to-scheme-int x-1661))))

(define (py-eq-boolX-boolY-fallback x-1664 y-1665)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-bool-to-scheme-int x-1664) (py-bool-to-scheme-int y-1665)))))

(define (py-test-eq-boolX-boolY-fallback x-1667 y-1668)
  (py-test-from-scheme
   (py== (py-bool-to-scheme-int x-1667) (py-bool-to-scheme-int y-1668))))

(define (py-eq-boolX-sintY-fallback x-1670 y-1671)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-bool-to-scheme-int x-1670) (py-sint-to-scheme y-1671)))))

(define (py-test-eq-boolX-sintY-fallback x-1673 y-1674)
  (py-test-from-scheme
   (py== (py-bool-to-scheme-int x-1673) (py-sint-to-scheme y-1674))))

(define (py-eq-boolX-bintY-fallback x-1676 y-1677)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-bool-to-scheme-int x-1676) (py-bint-to-scheme y-1677)))))

(define (py-test-eq-boolX-bintY-fallback x-1679 y-1680)
  (py-test-from-scheme
   (py== (py-bool-to-scheme-int x-1679) (py-bint-to-scheme y-1680))))

(define (py-eq-sintX-floatY-fallback x-1682 y-1683)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-float-to-scheme y-1683) (py-sint-to-scheme x-1682)))))

(define (py-test-eq-sintX-floatY-fallback x-1685 y-1686)
  (py-test-from-scheme
   (py== (py-float-to-scheme y-1686) (py-sint-to-scheme x-1685))))

(define (py-eq-sintX-boolY-fallback x-1688 y-1689)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-sint-to-scheme x-1688) (py-bool-to-scheme-int y-1689)))))

(define (py-test-eq-sintX-boolY-fallback x-1691 y-1692)
  (py-test-from-scheme
   (py== (py-sint-to-scheme x-1691) (py-bool-to-scheme-int y-1692))))

(define (py-eq-sintX-sintY-fallback x-1694 y-1695)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-sint-to-scheme x-1694) (py-sint-to-scheme y-1695)))))

(define (py-test-eq-sintX-sintY-fallback x-1697 y-1698)
  (py-test-from-scheme
   (py== (py-sint-to-scheme x-1697) (py-sint-to-scheme y-1698))))

(define (py-eq-sintX-bintY-fallback x-1700 y-1701)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-sint-to-scheme x-1700) (py-bint-to-scheme y-1701)))))

(define (py-test-eq-sintX-bintY-fallback x-1703 y-1704)
  (py-test-from-scheme
   (py== (py-sint-to-scheme x-1703) (py-bint-to-scheme y-1704))))

(define (py-eq-bintX-floatY-fallback x-1706 y-1707)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-float-to-scheme y-1707) (py-bint-to-scheme x-1706)))))

(define (py-test-eq-bintX-floatY-fallback x-1709 y-1710)
  (py-test-from-scheme
   (py== (py-float-to-scheme y-1710) (py-bint-to-scheme x-1709))))

(define (py-eq-bintX-boolY-fallback x-1712 y-1713)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-bint-to-scheme x-1712) (py-bool-to-scheme-int y-1713)))))

(define (py-test-eq-bintX-boolY-fallback x-1715 y-1716)
  (py-test-from-scheme
   (py== (py-bint-to-scheme x-1715) (py-bool-to-scheme-int y-1716))))

(define (py-eq-bintX-sintY-fallback x-1718 y-1719)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-bint-to-scheme x-1718) (py-sint-to-scheme y-1719)))))

(define (py-test-eq-bintX-sintY-fallback x-1721 y-1722)
  (py-test-from-scheme
   (py== (py-bint-to-scheme x-1721) (py-sint-to-scheme y-1722))))

(define (py-eq-bintX-bintY-fallback x-1724 y-1725)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-bint-to-scheme x-1724) (py-bint-to-scheme y-1725)))))

(define (py-test-eq-bintX-bintY-fallback x-1727 y-1728)
  (py-test-from-scheme
   (py== (py-bint-to-scheme x-1727) (py-bint-to-scheme y-1728))))

(define (py-ne-floatX-floatY-fallback x-1730 y-1731)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-float-to-scheme x-1730) (py-float-to-scheme y-1731)))))

(define (py-test-ne-floatX-floatY-fallback x-1733 y-1734)
  (py-test-from-scheme
   (py!= (py-float-to-scheme x-1733) (py-float-to-scheme y-1734))))

(define (py-ne-floatX-boolY-fallback x-1736 y-1737)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-float-to-scheme x-1736) (py-bool-to-scheme-int y-1737)))))

(define (py-test-ne-floatX-boolY-fallback x-1739 y-1740)
  (py-test-from-scheme
   (py!= (py-float-to-scheme x-1739) (py-bool-to-scheme-int y-1740))))

(define (py-ne-floatX-sintY-fallback x-1742 y-1743)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-float-to-scheme x-1742) (py-sint-to-scheme y-1743)))))

(define (py-test-ne-floatX-sintY-fallback x-1745 y-1746)
  (py-test-from-scheme
   (py!= (py-float-to-scheme x-1745) (py-sint-to-scheme y-1746))))

(define (py-ne-floatX-bintY-fallback x-1748 y-1749)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-float-to-scheme x-1748) (py-bint-to-scheme y-1749)))))

(define (py-test-ne-floatX-bintY-fallback x-1751 y-1752)
  (py-test-from-scheme
   (py!= (py-float-to-scheme x-1751) (py-bint-to-scheme y-1752))))

(define (py-ne-boolX-floatY-fallback x-1754 y-1755)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-float-to-scheme y-1755) (py-bool-to-scheme-int x-1754)))))

(define (py-test-ne-boolX-floatY-fallback x-1757 y-1758)
  (py-test-from-scheme
   (py!= (py-float-to-scheme y-1758) (py-bool-to-scheme-int x-1757))))

(define (py-ne-boolX-boolY-fallback x-1760 y-1761)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-bool-to-scheme-int x-1760) (py-bool-to-scheme-int y-1761)))))

(define (py-test-ne-boolX-boolY-fallback x-1763 y-1764)
  (py-test-from-scheme
   (py!= (py-bool-to-scheme-int x-1763) (py-bool-to-scheme-int y-1764))))

(define (py-ne-boolX-sintY-fallback x-1766 y-1767)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-bool-to-scheme-int x-1766) (py-sint-to-scheme y-1767)))))

(define (py-test-ne-boolX-sintY-fallback x-1769 y-1770)
  (py-test-from-scheme
   (py!= (py-bool-to-scheme-int x-1769) (py-sint-to-scheme y-1770))))

(define (py-ne-boolX-bintY-fallback x-1772 y-1773)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-bool-to-scheme-int x-1772) (py-bint-to-scheme y-1773)))))

(define (py-test-ne-boolX-bintY-fallback x-1775 y-1776)
  (py-test-from-scheme
   (py!= (py-bool-to-scheme-int x-1775) (py-bint-to-scheme y-1776))))

(define (py-ne-sintX-floatY-fallback x-1778 y-1779)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-float-to-scheme y-1779) (py-sint-to-scheme x-1778)))))

(define (py-test-ne-sintX-floatY-fallback x-1781 y-1782)
  (py-test-from-scheme
   (py!= (py-float-to-scheme y-1782) (py-sint-to-scheme x-1781))))

(define (py-ne-sintX-boolY-fallback x-1784 y-1785)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-sint-to-scheme x-1784) (py-bool-to-scheme-int y-1785)))))

(define (py-test-ne-sintX-boolY-fallback x-1787 y-1788)
  (py-test-from-scheme
   (py!= (py-sint-to-scheme x-1787) (py-bool-to-scheme-int y-1788))))

(define (py-ne-sintX-sintY-fallback x-1790 y-1791)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-sint-to-scheme x-1790) (py-sint-to-scheme y-1791)))))

(define (py-test-ne-sintX-sintY-fallback x-1793 y-1794)
  (py-test-from-scheme
   (py!= (py-sint-to-scheme x-1793) (py-sint-to-scheme y-1794))))

(define (py-ne-sintX-bintY-fallback x-1796 y-1797)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-sint-to-scheme x-1796) (py-bint-to-scheme y-1797)))))

(define (py-test-ne-sintX-bintY-fallback x-1799 y-1800)
  (py-test-from-scheme
   (py!= (py-sint-to-scheme x-1799) (py-bint-to-scheme y-1800))))

(define (py-ne-bintX-floatY-fallback x-1802 y-1803)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-float-to-scheme y-1803) (py-bint-to-scheme x-1802)))))

(define (py-test-ne-bintX-floatY-fallback x-1805 y-1806)
  (py-test-from-scheme
   (py!= (py-float-to-scheme y-1806) (py-bint-to-scheme x-1805))))

(define (py-ne-bintX-boolY-fallback x-1808 y-1809)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-bint-to-scheme x-1808) (py-bool-to-scheme-int y-1809)))))

(define (py-test-ne-bintX-boolY-fallback x-1811 y-1812)
  (py-test-from-scheme
   (py!= (py-bint-to-scheme x-1811) (py-bool-to-scheme-int y-1812))))

(define (py-ne-bintX-sintY-fallback x-1814 y-1815)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-bint-to-scheme x-1814) (py-sint-to-scheme y-1815)))))

(define (py-test-ne-bintX-sintY-fallback x-1817 y-1818)
  (py-test-from-scheme
   (py!= (py-bint-to-scheme x-1817) (py-sint-to-scheme y-1818))))

(define (py-ne-bintX-bintY-fallback x-1820 y-1821)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-bint-to-scheme x-1820) (py-bint-to-scheme y-1821)))))

(define (py-test-ne-bintX-bintY-fallback x-1823 y-1824)
  (py-test-from-scheme
   (py!= (py-bint-to-scheme x-1823) (py-bint-to-scheme y-1824))))

(define (py-pos-floatX-fallback x-1826) x-1826)

(define (py-pos-boolX-fallback x-1828) x-1828)

(define (py-pos-sintX-fallback x-1830) x-1830)

(define (py-pos-bintX-fallback x-1832) x-1832)

(define (py-neg-floatX-fallback x-1834)
  (py-float-from-scheme (pyneg (py-float-to-scheme x-1834))))

(define (py-neg-boolX-fallback x-1836)
  (py-int-from-scheme (pyneg (py-bool-to-scheme-int x-1836))))

(define (py-neg-sintX-fallback x-1838)
  (py-int-from-scheme (pyneg (py-sint-to-scheme x-1838))))

(define (py-neg-bintX-fallback x-1840)
  (py-int-from-scheme (pyneg (py-bint-to-scheme x-1840))))

(define (py-invert-floatX-fallback x-1842)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "bad operand type for unary ~: 'float'"))))

(define (py-invert-boolX-fallback x-1844)
  (py-int-from-scheme (pyinvert (py-bool-to-scheme-int x-1844))))

(define (py-invert-sintX-fallback x-1846)
  (py-int-from-scheme (pyinvert (py-sint-to-scheme x-1846))))

(define (py-invert-bintX-fallback x-1848)
  (py-int-from-scheme (pyinvert (py-bint-to-scheme x-1848))))

