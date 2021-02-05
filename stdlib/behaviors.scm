(define-macro (py-add-floatX-floatY-inline x-2 y-3)
  `(let ((x-2 ,x-2) (y-3 ,y-3))
     (py-float-from-scheme
      (py+ (py-float-to-scheme x-2) (py-float-to-scheme y-3)))))

(define-macro (py-add-floatX-boolY-inline x-5 y-6)
  `(py-add-floatX-boolY-fallback ,x-5 ,y-6))

(define-macro (py-add-floatX-strY-inline x-8 y-9)
  `(py-add-floatX-strY-fallback ,x-8 ,y-9))

(define-macro (py-add-floatX-sintY-inline x-11 y-12)
  `(let ((x-11 ,x-11) (y-12 ,y-12))
     (py-float-from-scheme
      (py+ (py-float-to-scheme x-11) (py-sint-to-scheme y-12)))))

(define-macro (py-add-floatX-bintY-inline x-14 y-15)
  `(py-add-floatX-bintY-fallback ,x-14 ,y-15))

(define-macro (py-add-boolX-floatY-inline x-17 y-18)
  `(py-add-boolX-floatY-fallback ,x-17 ,y-18))

(define-macro (py-add-boolX-boolY-inline x-20 y-21)
  `(py-add-boolX-boolY-fallback ,x-20 ,y-21))

(define-macro (py-add-boolX-strY-inline x-23 y-24)
  `(py-add-boolX-strY-fallback ,x-23 ,y-24))

(define-macro (py-add-boolX-sintY-inline x-26 y-27)
  `(py-add-boolX-sintY-fallback ,x-26 ,y-27))

(define-macro (py-add-boolX-bintY-inline x-29 y-30)
  `(py-add-boolX-bintY-fallback ,x-29 ,y-30))

(define-macro (py-add-strX-floatY-inline x-32 y-33)
  `(py-add-strX-floatY-fallback ,x-32 ,y-33))

(define-macro (py-add-strX-boolY-inline x-35 y-36)
  `(py-add-strX-boolY-fallback ,x-35 ,y-36))

(define-macro (py-add-strX-strY-inline x-38 y-39)
  `(py-add-strX-strY-fallback ,x-38 ,y-39))

(define-macro (py-add-strX-sintY-inline x-41 y-42)
  `(py-add-strX-sintY-fallback ,x-41 ,y-42))

(define-macro (py-add-strX-bintY-inline x-44 y-45)
  `(py-add-strX-bintY-fallback ,x-44 ,y-45))

(define-macro (py-add-sintX-floatY-inline x-47 y-48)
  `(let ((x-47 ,x-47) (y-48 ,y-48))
     (py-float-from-scheme
      (py+ (py-sint-to-scheme x-47) (py-float-to-scheme y-48)))))

(define-macro (py-add-sintX-boolY-inline x-50 y-51)
  `(py-add-sintX-boolY-fallback ,x-50 ,y-51))

(define-macro (py-add-sintX-strY-inline x-53 y-54)
  `(py-add-sintX-strY-fallback ,x-53 ,y-54))

(define-macro (py-add-sintX-sintY-inline x-56 y-57)
  `(let ((x-56 ,x-56) (y-57 ,y-57))
     (py-int-from-scheme
      (py+ (py-sint-to-scheme x-56) (py-sint-to-scheme y-57)))))

(define-macro (py-add-sintX-bintY-inline x-59 y-60)
  `(py-add-sintX-bintY-fallback ,x-59 ,y-60))

(define-macro (py-add-bintX-floatY-inline x-62 y-63)
  `(py-add-bintX-floatY-fallback ,x-62 ,y-63))

(define-macro (py-add-bintX-boolY-inline x-65 y-66)
  `(py-add-bintX-boolY-fallback ,x-65 ,y-66))

(define-macro (py-add-bintX-strY-inline x-68 y-69)
  `(py-add-bintX-strY-fallback ,x-68 ,y-69))

(define-macro (py-add-bintX-sintY-inline x-71 y-72)
  `(py-add-bintX-sintY-fallback ,x-71 ,y-72))

(define-macro (py-add-bintX-bintY-inline x-74 y-75)
  `(py-add-bintX-bintY-fallback ,x-74 ,y-75))

(define-macro (py-bitand-floatX-floatY-inline x-77 y-78)
  `(let ((x-77 ,x-77) (y-78 ,y-78))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for &: 'float' and 'float'")))))

(define-macro (py-bitand-floatX-boolY-inline x-80 y-81)
  `(py-bitand-floatX-boolY-fallback ,x-80 ,y-81))

(define-macro (py-bitand-floatX-strY-inline x-83 y-84)
  `(py-bitand-floatX-strY-fallback ,x-83 ,y-84))

(define-macro (py-bitand-floatX-sintY-inline x-86 y-87)
  `(let ((x-86 ,x-86) (y-87 ,y-87))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for &: 'float' and 'int'")))))

(define-macro (py-bitand-floatX-bintY-inline x-89 y-90)
  `(py-bitand-floatX-bintY-fallback ,x-89 ,y-90))

(define-macro (py-bitand-boolX-floatY-inline x-92 y-93)
  `(py-bitand-boolX-floatY-fallback ,x-92 ,y-93))

(define-macro (py-bitand-boolX-boolY-inline x-95 y-96)
  `(py-bitand-boolX-boolY-fallback ,x-95 ,y-96))

(define-macro (py-bitand-boolX-strY-inline x-98 y-99)
  `(py-bitand-boolX-strY-fallback ,x-98 ,y-99))

(define-macro (py-bitand-boolX-sintY-inline x-101 y-102)
  `(py-bitand-boolX-sintY-fallback ,x-101 ,y-102))

(define-macro (py-bitand-boolX-bintY-inline x-104 y-105)
  `(py-bitand-boolX-bintY-fallback ,x-104 ,y-105))

(define-macro (py-bitand-strX-floatY-inline x-107 y-108)
  `(py-bitand-strX-floatY-fallback ,x-107 ,y-108))

(define-macro (py-bitand-strX-boolY-inline x-110 y-111)
  `(py-bitand-strX-boolY-fallback ,x-110 ,y-111))

(define-macro (py-bitand-strX-strY-inline x-113 y-114)
  `(py-bitand-strX-strY-fallback ,x-113 ,y-114))

(define-macro (py-bitand-strX-sintY-inline x-116 y-117)
  `(py-bitand-strX-sintY-fallback ,x-116 ,y-117))

(define-macro (py-bitand-strX-bintY-inline x-119 y-120)
  `(py-bitand-strX-bintY-fallback ,x-119 ,y-120))

(define-macro (py-bitand-sintX-floatY-inline x-122 y-123)
  `(let ((x-122 ,x-122) (y-123 ,y-123))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for &: 'int' and 'float'")))))

(define-macro (py-bitand-sintX-boolY-inline x-125 y-126)
  `(py-bitand-sintX-boolY-fallback ,x-125 ,y-126))

(define-macro (py-bitand-sintX-strY-inline x-128 y-129)
  `(py-bitand-sintX-strY-fallback ,x-128 ,y-129))

(define-macro (py-bitand-sintX-sintY-inline x-131 y-132)
  `(let ((x-131 ,x-131) (y-132 ,y-132))
     (py-int-from-scheme
      (py& (py-sint-to-scheme x-131) (py-sint-to-scheme y-132)))))

(define-macro (py-bitand-sintX-bintY-inline x-134 y-135)
  `(py-bitand-sintX-bintY-fallback ,x-134 ,y-135))

(define-macro (py-bitand-bintX-floatY-inline x-137 y-138)
  `(py-bitand-bintX-floatY-fallback ,x-137 ,y-138))

(define-macro (py-bitand-bintX-boolY-inline x-140 y-141)
  `(py-bitand-bintX-boolY-fallback ,x-140 ,y-141))

(define-macro (py-bitand-bintX-strY-inline x-143 y-144)
  `(py-bitand-bintX-strY-fallback ,x-143 ,y-144))

(define-macro (py-bitand-bintX-sintY-inline x-146 y-147)
  `(py-bitand-bintX-sintY-fallback ,x-146 ,y-147))

(define-macro (py-bitand-bintX-bintY-inline x-149 y-150)
  `(py-bitand-bintX-bintY-fallback ,x-149 ,y-150))

(define-macro (py-bitor-floatX-floatY-inline x-152 y-153)
  `(let ((x-152 ,x-152) (y-153 ,y-153))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for |: 'float' and 'float'")))))

(define-macro (py-bitor-floatX-boolY-inline x-155 y-156)
  `(py-bitor-floatX-boolY-fallback ,x-155 ,y-156))

(define-macro (py-bitor-floatX-strY-inline x-158 y-159)
  `(py-bitor-floatX-strY-fallback ,x-158 ,y-159))

(define-macro (py-bitor-floatX-sintY-inline x-161 y-162)
  `(let ((x-161 ,x-161) (y-162 ,y-162))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for |: 'float' and 'int'")))))

(define-macro (py-bitor-floatX-bintY-inline x-164 y-165)
  `(py-bitor-floatX-bintY-fallback ,x-164 ,y-165))

(define-macro (py-bitor-boolX-floatY-inline x-167 y-168)
  `(py-bitor-boolX-floatY-fallback ,x-167 ,y-168))

(define-macro (py-bitor-boolX-boolY-inline x-170 y-171)
  `(py-bitor-boolX-boolY-fallback ,x-170 ,y-171))

(define-macro (py-bitor-boolX-strY-inline x-173 y-174)
  `(py-bitor-boolX-strY-fallback ,x-173 ,y-174))

(define-macro (py-bitor-boolX-sintY-inline x-176 y-177)
  `(py-bitor-boolX-sintY-fallback ,x-176 ,y-177))

(define-macro (py-bitor-boolX-bintY-inline x-179 y-180)
  `(py-bitor-boolX-bintY-fallback ,x-179 ,y-180))

(define-macro (py-bitor-strX-floatY-inline x-182 y-183)
  `(py-bitor-strX-floatY-fallback ,x-182 ,y-183))

(define-macro (py-bitor-strX-boolY-inline x-185 y-186)
  `(py-bitor-strX-boolY-fallback ,x-185 ,y-186))

(define-macro (py-bitor-strX-strY-inline x-188 y-189)
  `(py-bitor-strX-strY-fallback ,x-188 ,y-189))

(define-macro (py-bitor-strX-sintY-inline x-191 y-192)
  `(py-bitor-strX-sintY-fallback ,x-191 ,y-192))

(define-macro (py-bitor-strX-bintY-inline x-194 y-195)
  `(py-bitor-strX-bintY-fallback ,x-194 ,y-195))

(define-macro (py-bitor-sintX-floatY-inline x-197 y-198)
  `(let ((x-197 ,x-197) (y-198 ,y-198))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for |: 'int' and 'float'")))))

(define-macro (py-bitor-sintX-boolY-inline x-200 y-201)
  `(py-bitor-sintX-boolY-fallback ,x-200 ,y-201))

(define-macro (py-bitor-sintX-strY-inline x-203 y-204)
  `(py-bitor-sintX-strY-fallback ,x-203 ,y-204))

(define-macro (py-bitor-sintX-sintY-inline x-206 y-207)
  `(let ((x-206 ,x-206) (y-207 ,y-207))
     (py-int-from-scheme
      (py+b (py-sint-to-scheme x-206) (py-sint-to-scheme y-207)))))

(define-macro (py-bitor-sintX-bintY-inline x-209 y-210)
  `(py-bitor-sintX-bintY-fallback ,x-209 ,y-210))

(define-macro (py-bitor-bintX-floatY-inline x-212 y-213)
  `(py-bitor-bintX-floatY-fallback ,x-212 ,y-213))

(define-macro (py-bitor-bintX-boolY-inline x-215 y-216)
  `(py-bitor-bintX-boolY-fallback ,x-215 ,y-216))

(define-macro (py-bitor-bintX-strY-inline x-218 y-219)
  `(py-bitor-bintX-strY-fallback ,x-218 ,y-219))

(define-macro (py-bitor-bintX-sintY-inline x-221 y-222)
  `(py-bitor-bintX-sintY-fallback ,x-221 ,y-222))

(define-macro (py-bitor-bintX-bintY-inline x-224 y-225)
  `(py-bitor-bintX-bintY-fallback ,x-224 ,y-225))

(define-macro (py-floordiv-floatX-floatY-inline x-227 y-228)
  `(let ((x-227 ,x-227) (y-228 ,y-228))
     (if (py-test (py-ne y-228 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py// (py-float-to-scheme x-227) (py-float-to-scheme y-228)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-floordiv-floatX-boolY-inline x-230 y-231)
  `(py-floordiv-floatX-boolY-fallback ,x-230 ,y-231))

(define-macro (py-floordiv-floatX-strY-inline x-233 y-234)
  `(py-floordiv-floatX-strY-fallback ,x-233 ,y-234))

(define-macro (py-floordiv-floatX-sintY-inline x-236 y-237)
  `(let ((x-236 ,x-236) (y-237 ,y-237))
     (if (py-test (py-ne y-237 (py-int-from-scheme 0)))
         (py-float-from-scheme
          (py// (py-float-to-scheme x-236) (py-sint-to-scheme y-237)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-floordiv-floatX-bintY-inline x-239 y-240)
  `(py-floordiv-floatX-bintY-fallback ,x-239 ,y-240))

(define-macro (py-floordiv-boolX-floatY-inline x-242 y-243)
  `(py-floordiv-boolX-floatY-fallback ,x-242 ,y-243))

(define-macro (py-floordiv-boolX-boolY-inline x-245 y-246)
  `(py-floordiv-boolX-boolY-fallback ,x-245 ,y-246))

(define-macro (py-floordiv-boolX-strY-inline x-248 y-249)
  `(py-floordiv-boolX-strY-fallback ,x-248 ,y-249))

(define-macro (py-floordiv-boolX-sintY-inline x-251 y-252)
  `(py-floordiv-boolX-sintY-fallback ,x-251 ,y-252))

(define-macro (py-floordiv-boolX-bintY-inline x-254 y-255)
  `(py-floordiv-boolX-bintY-fallback ,x-254 ,y-255))

(define-macro (py-floordiv-strX-floatY-inline x-257 y-258)
  `(py-floordiv-strX-floatY-fallback ,x-257 ,y-258))

(define-macro (py-floordiv-strX-boolY-inline x-260 y-261)
  `(py-floordiv-strX-boolY-fallback ,x-260 ,y-261))

(define-macro (py-floordiv-strX-strY-inline x-263 y-264)
  `(py-floordiv-strX-strY-fallback ,x-263 ,y-264))

(define-macro (py-floordiv-strX-sintY-inline x-266 y-267)
  `(py-floordiv-strX-sintY-fallback ,x-266 ,y-267))

(define-macro (py-floordiv-strX-bintY-inline x-269 y-270)
  `(py-floordiv-strX-bintY-fallback ,x-269 ,y-270))

(define-macro (py-floordiv-sintX-floatY-inline x-272 y-273)
  `(let ((x-272 ,x-272) (y-273 ,y-273))
     (if (py-test (py-ne y-273 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py// (py-sint-to-scheme x-272) (py-float-to-scheme y-273)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-floordiv-sintX-boolY-inline x-275 y-276)
  `(py-floordiv-sintX-boolY-fallback ,x-275 ,y-276))

(define-macro (py-floordiv-sintX-strY-inline x-278 y-279)
  `(py-floordiv-sintX-strY-fallback ,x-278 ,y-279))

(define-macro (py-floordiv-sintX-sintY-inline x-281 y-282)
  `(let ((x-281 ,x-281) (y-282 ,y-282))
     (if (py-test (py-ne y-282 (py-int-from-scheme 0)))
         (py-int-from-scheme
          (py// (py-sint-to-scheme x-281) (py-sint-to-scheme y-282)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "integer division by zero"))))))

(define-macro (py-floordiv-sintX-bintY-inline x-284 y-285)
  `(py-floordiv-sintX-bintY-fallback ,x-284 ,y-285))

(define-macro (py-floordiv-bintX-floatY-inline x-287 y-288)
  `(py-floordiv-bintX-floatY-fallback ,x-287 ,y-288))

(define-macro (py-floordiv-bintX-boolY-inline x-290 y-291)
  `(py-floordiv-bintX-boolY-fallback ,x-290 ,y-291))

(define-macro (py-floordiv-bintX-strY-inline x-293 y-294)
  `(py-floordiv-bintX-strY-fallback ,x-293 ,y-294))

(define-macro (py-floordiv-bintX-sintY-inline x-296 y-297)
  `(py-floordiv-bintX-sintY-fallback ,x-296 ,y-297))

(define-macro (py-floordiv-bintX-bintY-inline x-299 y-300)
  `(py-floordiv-bintX-bintY-fallback ,x-299 ,y-300))

(define-macro (py-lshift-floatX-floatY-inline x-302 y-303)
  `(let ((x-302 ,x-302) (y-303 ,y-303))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for <<: 'float' and 'float'")))))

(define-macro (py-lshift-floatX-boolY-inline x-305 y-306)
  `(py-lshift-floatX-boolY-fallback ,x-305 ,y-306))

(define-macro (py-lshift-floatX-strY-inline x-308 y-309)
  `(py-lshift-floatX-strY-fallback ,x-308 ,y-309))

(define-macro (py-lshift-floatX-sintY-inline x-311 y-312)
  `(let ((x-311 ,x-311) (y-312 ,y-312))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for <<: 'float' and 'int'")))))

(define-macro (py-lshift-floatX-bintY-inline x-314 y-315)
  `(py-lshift-floatX-bintY-fallback ,x-314 ,y-315))

(define-macro (py-lshift-boolX-floatY-inline x-317 y-318)
  `(py-lshift-boolX-floatY-fallback ,x-317 ,y-318))

(define-macro (py-lshift-boolX-boolY-inline x-320 y-321)
  `(py-lshift-boolX-boolY-fallback ,x-320 ,y-321))

(define-macro (py-lshift-boolX-strY-inline x-323 y-324)
  `(py-lshift-boolX-strY-fallback ,x-323 ,y-324))

(define-macro (py-lshift-boolX-sintY-inline x-326 y-327)
  `(py-lshift-boolX-sintY-fallback ,x-326 ,y-327))

(define-macro (py-lshift-boolX-bintY-inline x-329 y-330)
  `(py-lshift-boolX-bintY-fallback ,x-329 ,y-330))

(define-macro (py-lshift-strX-floatY-inline x-332 y-333)
  `(py-lshift-strX-floatY-fallback ,x-332 ,y-333))

(define-macro (py-lshift-strX-boolY-inline x-335 y-336)
  `(py-lshift-strX-boolY-fallback ,x-335 ,y-336))

(define-macro (py-lshift-strX-strY-inline x-338 y-339)
  `(py-lshift-strX-strY-fallback ,x-338 ,y-339))

(define-macro (py-lshift-strX-sintY-inline x-341 y-342)
  `(py-lshift-strX-sintY-fallback ,x-341 ,y-342))

(define-macro (py-lshift-strX-bintY-inline x-344 y-345)
  `(py-lshift-strX-bintY-fallback ,x-344 ,y-345))

(define-macro (py-lshift-sintX-floatY-inline x-347 y-348)
  `(let ((x-347 ,x-347) (y-348 ,y-348))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for <<: 'int' and 'float'")))))

(define-macro (py-lshift-sintX-boolY-inline x-350 y-351)
  `(py-lshift-sintX-boolY-fallback ,x-350 ,y-351))

(define-macro (py-lshift-sintX-strY-inline x-353 y-354)
  `(py-lshift-sintX-strY-fallback ,x-353 ,y-354))

(define-macro (py-lshift-sintX-sintY-inline x-356 y-357)
  `(let ((x-356 ,x-356) (y-357 ,y-357))
     (if (py-test (py-ge y-357 (py-int-from-scheme 0)))
         (py-int-from-scheme
          (py<< (py-sint-to-scheme x-356) (py-sint-to-scheme y-357)))
         (py-throw
          (py-call py-builtin-ValueError (&& "negative shift count"))))))

(define-macro (py-lshift-sintX-bintY-inline x-359 y-360)
  `(py-lshift-sintX-bintY-fallback ,x-359 ,y-360))

(define-macro (py-lshift-bintX-floatY-inline x-362 y-363)
  `(py-lshift-bintX-floatY-fallback ,x-362 ,y-363))

(define-macro (py-lshift-bintX-boolY-inline x-365 y-366)
  `(py-lshift-bintX-boolY-fallback ,x-365 ,y-366))

(define-macro (py-lshift-bintX-strY-inline x-368 y-369)
  `(py-lshift-bintX-strY-fallback ,x-368 ,y-369))

(define-macro (py-lshift-bintX-sintY-inline x-371 y-372)
  `(py-lshift-bintX-sintY-fallback ,x-371 ,y-372))

(define-macro (py-lshift-bintX-bintY-inline x-374 y-375)
  `(py-lshift-bintX-bintY-fallback ,x-374 ,y-375))

(define-macro (py-matmul-floatX-floatY-inline x-377 y-378)
  `(let ((x-377 ,x-377) (y-378 ,y-378))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @: 'float' and 'float'")))))

(define-macro (py-matmul-floatX-boolY-inline x-380 y-381)
  `(py-matmul-floatX-boolY-fallback ,x-380 ,y-381))

(define-macro (py-matmul-floatX-strY-inline x-383 y-384)
  `(py-matmul-floatX-strY-fallback ,x-383 ,y-384))

(define-macro (py-matmul-floatX-sintY-inline x-386 y-387)
  `(let ((x-386 ,x-386) (y-387 ,y-387))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @: 'float' and 'int'")))))

(define-macro (py-matmul-floatX-bintY-inline x-389 y-390)
  `(py-matmul-floatX-bintY-fallback ,x-389 ,y-390))

(define-macro (py-matmul-boolX-floatY-inline x-392 y-393)
  `(py-matmul-boolX-floatY-fallback ,x-392 ,y-393))

(define-macro (py-matmul-boolX-boolY-inline x-395 y-396)
  `(py-matmul-boolX-boolY-fallback ,x-395 ,y-396))

(define-macro (py-matmul-boolX-strY-inline x-398 y-399)
  `(py-matmul-boolX-strY-fallback ,x-398 ,y-399))

(define-macro (py-matmul-boolX-sintY-inline x-401 y-402)
  `(py-matmul-boolX-sintY-fallback ,x-401 ,y-402))

(define-macro (py-matmul-boolX-bintY-inline x-404 y-405)
  `(py-matmul-boolX-bintY-fallback ,x-404 ,y-405))

(define-macro (py-matmul-strX-floatY-inline x-407 y-408)
  `(py-matmul-strX-floatY-fallback ,x-407 ,y-408))

(define-macro (py-matmul-strX-boolY-inline x-410 y-411)
  `(py-matmul-strX-boolY-fallback ,x-410 ,y-411))

(define-macro (py-matmul-strX-strY-inline x-413 y-414)
  `(py-matmul-strX-strY-fallback ,x-413 ,y-414))

(define-macro (py-matmul-strX-sintY-inline x-416 y-417)
  `(py-matmul-strX-sintY-fallback ,x-416 ,y-417))

(define-macro (py-matmul-strX-bintY-inline x-419 y-420)
  `(py-matmul-strX-bintY-fallback ,x-419 ,y-420))

(define-macro (py-matmul-sintX-floatY-inline x-422 y-423)
  `(let ((x-422 ,x-422) (y-423 ,y-423))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @: 'int' and 'float'")))))

(define-macro (py-matmul-sintX-boolY-inline x-425 y-426)
  `(py-matmul-sintX-boolY-fallback ,x-425 ,y-426))

(define-macro (py-matmul-sintX-strY-inline x-428 y-429)
  `(py-matmul-sintX-strY-fallback ,x-428 ,y-429))

(define-macro (py-matmul-sintX-sintY-inline x-431 y-432)
  `(let ((x-431 ,x-431) (y-432 ,y-432))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @: 'int' and 'int'")))))

(define-macro (py-matmul-sintX-bintY-inline x-434 y-435)
  `(py-matmul-sintX-bintY-fallback ,x-434 ,y-435))

(define-macro (py-matmul-bintX-floatY-inline x-437 y-438)
  `(py-matmul-bintX-floatY-fallback ,x-437 ,y-438))

(define-macro (py-matmul-bintX-boolY-inline x-440 y-441)
  `(py-matmul-bintX-boolY-fallback ,x-440 ,y-441))

(define-macro (py-matmul-bintX-strY-inline x-443 y-444)
  `(py-matmul-bintX-strY-fallback ,x-443 ,y-444))

(define-macro (py-matmul-bintX-sintY-inline x-446 y-447)
  `(py-matmul-bintX-sintY-fallback ,x-446 ,y-447))

(define-macro (py-matmul-bintX-bintY-inline x-449 y-450)
  `(py-matmul-bintX-bintY-fallback ,x-449 ,y-450))

(define-macro (py-mod-floatX-floatY-inline x-452 y-453)
  `(let ((x-452 ,x-452) (y-453 ,y-453))
     (if (py-test (py-ne y-453 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py% (py-float-to-scheme x-452) (py-float-to-scheme y-453)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float modulo by zero"))))))

(define-macro (py-mod-floatX-boolY-inline x-455 y-456)
  `(py-mod-floatX-boolY-fallback ,x-455 ,y-456))

(define-macro (py-mod-floatX-strY-inline x-458 y-459)
  `(py-mod-floatX-strY-fallback ,x-458 ,y-459))

(define-macro (py-mod-floatX-sintY-inline x-461 y-462)
  `(let ((x-461 ,x-461) (y-462 ,y-462))
     (if (py-test (py-ne y-462 (py-int-from-scheme 0)))
         (py-float-from-scheme
          (py% (py-float-to-scheme x-461) (py-sint-to-scheme y-462)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float modulo by zero"))))))

(define-macro (py-mod-floatX-bintY-inline x-464 y-465)
  `(py-mod-floatX-bintY-fallback ,x-464 ,y-465))

(define-macro (py-mod-boolX-floatY-inline x-467 y-468)
  `(py-mod-boolX-floatY-fallback ,x-467 ,y-468))

(define-macro (py-mod-boolX-boolY-inline x-470 y-471)
  `(py-mod-boolX-boolY-fallback ,x-470 ,y-471))

(define-macro (py-mod-boolX-strY-inline x-473 y-474)
  `(py-mod-boolX-strY-fallback ,x-473 ,y-474))

(define-macro (py-mod-boolX-sintY-inline x-476 y-477)
  `(py-mod-boolX-sintY-fallback ,x-476 ,y-477))

(define-macro (py-mod-boolX-bintY-inline x-479 y-480)
  `(py-mod-boolX-bintY-fallback ,x-479 ,y-480))

(define-macro (py-mod-strX-floatY-inline x-482 y-483)
  `(py-mod-strX-floatY-fallback ,x-482 ,y-483))

(define-macro (py-mod-strX-boolY-inline x-485 y-486)
  `(py-mod-strX-boolY-fallback ,x-485 ,y-486))

(define-macro (py-mod-strX-strY-inline x-488 y-489)
  `(py-mod-strX-strY-fallback ,x-488 ,y-489))

(define-macro (py-mod-strX-sintY-inline x-491 y-492)
  `(py-mod-strX-sintY-fallback ,x-491 ,y-492))

(define-macro (py-mod-strX-bintY-inline x-494 y-495)
  `(py-mod-strX-bintY-fallback ,x-494 ,y-495))

(define-macro (py-mod-sintX-floatY-inline x-497 y-498)
  `(let ((x-497 ,x-497) (y-498 ,y-498))
     (if (py-test (py-ne y-498 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py% (py-sint-to-scheme x-497) (py-float-to-scheme y-498)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float modulo by zero"))))))

(define-macro (py-mod-sintX-boolY-inline x-500 y-501)
  `(py-mod-sintX-boolY-fallback ,x-500 ,y-501))

(define-macro (py-mod-sintX-strY-inline x-503 y-504)
  `(py-mod-sintX-strY-fallback ,x-503 ,y-504))

(define-macro (py-mod-sintX-sintY-inline x-506 y-507)
  `(let ((x-506 ,x-506) (y-507 ,y-507))
     (if (py-test (py-ne y-507 (py-int-from-scheme 0)))
         (py-int-from-scheme
          (py% (py-sint-to-scheme x-506) (py-sint-to-scheme y-507)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError (&& "modulo by zero"))))))

(define-macro (py-mod-sintX-bintY-inline x-509 y-510)
  `(py-mod-sintX-bintY-fallback ,x-509 ,y-510))

(define-macro (py-mod-bintX-floatY-inline x-512 y-513)
  `(py-mod-bintX-floatY-fallback ,x-512 ,y-513))

(define-macro (py-mod-bintX-boolY-inline x-515 y-516)
  `(py-mod-bintX-boolY-fallback ,x-515 ,y-516))

(define-macro (py-mod-bintX-strY-inline x-518 y-519)
  `(py-mod-bintX-strY-fallback ,x-518 ,y-519))

(define-macro (py-mod-bintX-sintY-inline x-521 y-522)
  `(py-mod-bintX-sintY-fallback ,x-521 ,y-522))

(define-macro (py-mod-bintX-bintY-inline x-524 y-525)
  `(py-mod-bintX-bintY-fallback ,x-524 ,y-525))

(define-macro (py-mul-floatX-floatY-inline x-527 y-528)
  `(let ((x-527 ,x-527) (y-528 ,y-528))
     (py-float-from-scheme
      (py* (py-float-to-scheme x-527) (py-float-to-scheme y-528)))))

(define-macro (py-mul-floatX-boolY-inline x-530 y-531)
  `(py-mul-floatX-boolY-fallback ,x-530 ,y-531))

(define-macro (py-mul-floatX-strY-inline x-533 y-534)
  `(py-mul-floatX-strY-fallback ,x-533 ,y-534))

(define-macro (py-mul-floatX-sintY-inline x-536 y-537)
  `(let ((x-536 ,x-536) (y-537 ,y-537))
     (py-float-from-scheme
      (py* (py-float-to-scheme x-536) (py-sint-to-scheme y-537)))))

(define-macro (py-mul-floatX-bintY-inline x-539 y-540)
  `(py-mul-floatX-bintY-fallback ,x-539 ,y-540))

(define-macro (py-mul-boolX-floatY-inline x-542 y-543)
  `(py-mul-boolX-floatY-fallback ,x-542 ,y-543))

(define-macro (py-mul-boolX-boolY-inline x-545 y-546)
  `(py-mul-boolX-boolY-fallback ,x-545 ,y-546))

(define-macro (py-mul-boolX-strY-inline x-548 y-549)
  `(py-mul-boolX-strY-fallback ,x-548 ,y-549))

(define-macro (py-mul-boolX-sintY-inline x-551 y-552)
  `(py-mul-boolX-sintY-fallback ,x-551 ,y-552))

(define-macro (py-mul-boolX-bintY-inline x-554 y-555)
  `(py-mul-boolX-bintY-fallback ,x-554 ,y-555))

(define-macro (py-mul-strX-floatY-inline x-557 y-558)
  `(py-mul-strX-floatY-fallback ,x-557 ,y-558))

(define-macro (py-mul-strX-boolY-inline x-560 y-561)
  `(py-mul-strX-boolY-fallback ,x-560 ,y-561))

(define-macro (py-mul-strX-strY-inline x-563 y-564)
  `(py-mul-strX-strY-fallback ,x-563 ,y-564))

(define-macro (py-mul-strX-sintY-inline x-566 y-567)
  `(py-mul-strX-sintY-fallback ,x-566 ,y-567))

(define-macro (py-mul-strX-bintY-inline x-569 y-570)
  `(py-mul-strX-bintY-fallback ,x-569 ,y-570))

(define-macro (py-mul-sintX-floatY-inline x-572 y-573)
  `(let ((x-572 ,x-572) (y-573 ,y-573))
     (py-float-from-scheme
      (py* (py-sint-to-scheme x-572) (py-float-to-scheme y-573)))))

(define-macro (py-mul-sintX-boolY-inline x-575 y-576)
  `(py-mul-sintX-boolY-fallback ,x-575 ,y-576))

(define-macro (py-mul-sintX-strY-inline x-578 y-579)
  `(py-mul-sintX-strY-fallback ,x-578 ,y-579))

(define-macro (py-mul-sintX-sintY-inline x-581 y-582)
  `(let ((x-581 ,x-581) (y-582 ,y-582))
     (py-int-from-scheme
      (py* (py-sint-to-scheme x-581) (py-sint-to-scheme y-582)))))

(define-macro (py-mul-sintX-bintY-inline x-584 y-585)
  `(py-mul-sintX-bintY-fallback ,x-584 ,y-585))

(define-macro (py-mul-bintX-floatY-inline x-587 y-588)
  `(py-mul-bintX-floatY-fallback ,x-587 ,y-588))

(define-macro (py-mul-bintX-boolY-inline x-590 y-591)
  `(py-mul-bintX-boolY-fallback ,x-590 ,y-591))

(define-macro (py-mul-bintX-strY-inline x-593 y-594)
  `(py-mul-bintX-strY-fallback ,x-593 ,y-594))

(define-macro (py-mul-bintX-sintY-inline x-596 y-597)
  `(py-mul-bintX-sintY-fallback ,x-596 ,y-597))

(define-macro (py-mul-bintX-bintY-inline x-599 y-600)
  `(py-mul-bintX-bintY-fallback ,x-599 ,y-600))

(define-macro (py-pow-floatX-floatY-inline x-602 y-603)
  `(let ((x-602 ,x-602) (y-603 ,y-603))
     (py-float-from-scheme
      (py** (py-float-to-scheme x-602) (py-float-to-scheme y-603)))))

(define-macro (py-pow-floatX-boolY-inline x-605 y-606)
  `(py-pow-floatX-boolY-fallback ,x-605 ,y-606))

(define-macro (py-pow-floatX-strY-inline x-608 y-609)
  `(py-pow-floatX-strY-fallback ,x-608 ,y-609))

(define-macro (py-pow-floatX-sintY-inline x-611 y-612)
  `(let ((x-611 ,x-611) (y-612 ,y-612))
     (py-float-from-scheme
      (py** (py-float-to-scheme x-611) (py-sint-to-scheme y-612)))))

(define-macro (py-pow-floatX-bintY-inline x-614 y-615)
  `(py-pow-floatX-bintY-fallback ,x-614 ,y-615))

(define-macro (py-pow-boolX-floatY-inline x-617 y-618)
  `(py-pow-boolX-floatY-fallback ,x-617 ,y-618))

(define-macro (py-pow-boolX-boolY-inline x-620 y-621)
  `(py-pow-boolX-boolY-fallback ,x-620 ,y-621))

(define-macro (py-pow-boolX-strY-inline x-623 y-624)
  `(py-pow-boolX-strY-fallback ,x-623 ,y-624))

(define-macro (py-pow-boolX-sintY-inline x-626 y-627)
  `(py-pow-boolX-sintY-fallback ,x-626 ,y-627))

(define-macro (py-pow-boolX-bintY-inline x-629 y-630)
  `(py-pow-boolX-bintY-fallback ,x-629 ,y-630))

(define-macro (py-pow-strX-floatY-inline x-632 y-633)
  `(py-pow-strX-floatY-fallback ,x-632 ,y-633))

(define-macro (py-pow-strX-boolY-inline x-635 y-636)
  `(py-pow-strX-boolY-fallback ,x-635 ,y-636))

(define-macro (py-pow-strX-strY-inline x-638 y-639)
  `(py-pow-strX-strY-fallback ,x-638 ,y-639))

(define-macro (py-pow-strX-sintY-inline x-641 y-642)
  `(py-pow-strX-sintY-fallback ,x-641 ,y-642))

(define-macro (py-pow-strX-bintY-inline x-644 y-645)
  `(py-pow-strX-bintY-fallback ,x-644 ,y-645))

(define-macro (py-pow-sintX-floatY-inline x-647 y-648)
  `(let ((x-647 ,x-647) (y-648 ,y-648))
     (py-float-from-scheme
      (py** (py-sint-to-scheme x-647) (py-float-to-scheme y-648)))))

(define-macro (py-pow-sintX-boolY-inline x-650 y-651)
  `(py-pow-sintX-boolY-fallback ,x-650 ,y-651))

(define-macro (py-pow-sintX-strY-inline x-653 y-654)
  `(py-pow-sintX-strY-fallback ,x-653 ,y-654))

(define-macro (py-pow-sintX-sintY-inline x-656 y-657)
  `(let ((x-656 ,x-656) (y-657 ,y-657))
     (py-int-from-scheme
      (py** (py-sint-to-scheme x-656) (py-sint-to-scheme y-657)))))

(define-macro (py-pow-sintX-bintY-inline x-659 y-660)
  `(py-pow-sintX-bintY-fallback ,x-659 ,y-660))

(define-macro (py-pow-bintX-floatY-inline x-662 y-663)
  `(py-pow-bintX-floatY-fallback ,x-662 ,y-663))

(define-macro (py-pow-bintX-boolY-inline x-665 y-666)
  `(py-pow-bintX-boolY-fallback ,x-665 ,y-666))

(define-macro (py-pow-bintX-strY-inline x-668 y-669)
  `(py-pow-bintX-strY-fallback ,x-668 ,y-669))

(define-macro (py-pow-bintX-sintY-inline x-671 y-672)
  `(py-pow-bintX-sintY-fallback ,x-671 ,y-672))

(define-macro (py-pow-bintX-bintY-inline x-674 y-675)
  `(py-pow-bintX-bintY-fallback ,x-674 ,y-675))

(define-macro (py-rshift-floatX-floatY-inline x-677 y-678)
  `(let ((x-677 ,x-677) (y-678 ,y-678))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for >>: 'float' and 'float'")))))

(define-macro (py-rshift-floatX-boolY-inline x-680 y-681)
  `(py-rshift-floatX-boolY-fallback ,x-680 ,y-681))

(define-macro (py-rshift-floatX-strY-inline x-683 y-684)
  `(py-rshift-floatX-strY-fallback ,x-683 ,y-684))

(define-macro (py-rshift-floatX-sintY-inline x-686 y-687)
  `(let ((x-686 ,x-686) (y-687 ,y-687))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for >>: 'float' and 'int'")))))

(define-macro (py-rshift-floatX-bintY-inline x-689 y-690)
  `(py-rshift-floatX-bintY-fallback ,x-689 ,y-690))

(define-macro (py-rshift-boolX-floatY-inline x-692 y-693)
  `(py-rshift-boolX-floatY-fallback ,x-692 ,y-693))

(define-macro (py-rshift-boolX-boolY-inline x-695 y-696)
  `(py-rshift-boolX-boolY-fallback ,x-695 ,y-696))

(define-macro (py-rshift-boolX-strY-inline x-698 y-699)
  `(py-rshift-boolX-strY-fallback ,x-698 ,y-699))

(define-macro (py-rshift-boolX-sintY-inline x-701 y-702)
  `(py-rshift-boolX-sintY-fallback ,x-701 ,y-702))

(define-macro (py-rshift-boolX-bintY-inline x-704 y-705)
  `(py-rshift-boolX-bintY-fallback ,x-704 ,y-705))

(define-macro (py-rshift-strX-floatY-inline x-707 y-708)
  `(py-rshift-strX-floatY-fallback ,x-707 ,y-708))

(define-macro (py-rshift-strX-boolY-inline x-710 y-711)
  `(py-rshift-strX-boolY-fallback ,x-710 ,y-711))

(define-macro (py-rshift-strX-strY-inline x-713 y-714)
  `(py-rshift-strX-strY-fallback ,x-713 ,y-714))

(define-macro (py-rshift-strX-sintY-inline x-716 y-717)
  `(py-rshift-strX-sintY-fallback ,x-716 ,y-717))

(define-macro (py-rshift-strX-bintY-inline x-719 y-720)
  `(py-rshift-strX-bintY-fallback ,x-719 ,y-720))

(define-macro (py-rshift-sintX-floatY-inline x-722 y-723)
  `(let ((x-722 ,x-722) (y-723 ,y-723))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for >>: 'int' and 'float'")))))

(define-macro (py-rshift-sintX-boolY-inline x-725 y-726)
  `(py-rshift-sintX-boolY-fallback ,x-725 ,y-726))

(define-macro (py-rshift-sintX-strY-inline x-728 y-729)
  `(py-rshift-sintX-strY-fallback ,x-728 ,y-729))

(define-macro (py-rshift-sintX-sintY-inline x-731 y-732)
  `(let ((x-731 ,x-731) (y-732 ,y-732))
     (if (py-test (py-ge y-732 (py-int-from-scheme 0)))
         (py-int-from-scheme
          (py>> (py-sint-to-scheme x-731) (py-sint-to-scheme y-732)))
         (py-throw
          (py-call py-builtin-ValueError (&& "negative shift count"))))))

(define-macro (py-rshift-sintX-bintY-inline x-734 y-735)
  `(py-rshift-sintX-bintY-fallback ,x-734 ,y-735))

(define-macro (py-rshift-bintX-floatY-inline x-737 y-738)
  `(py-rshift-bintX-floatY-fallback ,x-737 ,y-738))

(define-macro (py-rshift-bintX-boolY-inline x-740 y-741)
  `(py-rshift-bintX-boolY-fallback ,x-740 ,y-741))

(define-macro (py-rshift-bintX-strY-inline x-743 y-744)
  `(py-rshift-bintX-strY-fallback ,x-743 ,y-744))

(define-macro (py-rshift-bintX-sintY-inline x-746 y-747)
  `(py-rshift-bintX-sintY-fallback ,x-746 ,y-747))

(define-macro (py-rshift-bintX-bintY-inline x-749 y-750)
  `(py-rshift-bintX-bintY-fallback ,x-749 ,y-750))

(define-macro (py-sub-floatX-floatY-inline x-752 y-753)
  `(let ((x-752 ,x-752) (y-753 ,y-753))
     (py-float-from-scheme
      (py- (py-float-to-scheme x-752) (py-float-to-scheme y-753)))))

(define-macro (py-sub-floatX-boolY-inline x-755 y-756)
  `(py-sub-floatX-boolY-fallback ,x-755 ,y-756))

(define-macro (py-sub-floatX-strY-inline x-758 y-759)
  `(py-sub-floatX-strY-fallback ,x-758 ,y-759))

(define-macro (py-sub-floatX-sintY-inline x-761 y-762)
  `(let ((x-761 ,x-761) (y-762 ,y-762))
     (py-float-from-scheme
      (py- (py-float-to-scheme x-761) (py-sint-to-scheme y-762)))))

(define-macro (py-sub-floatX-bintY-inline x-764 y-765)
  `(py-sub-floatX-bintY-fallback ,x-764 ,y-765))

(define-macro (py-sub-boolX-floatY-inline x-767 y-768)
  `(py-sub-boolX-floatY-fallback ,x-767 ,y-768))

(define-macro (py-sub-boolX-boolY-inline x-770 y-771)
  `(py-sub-boolX-boolY-fallback ,x-770 ,y-771))

(define-macro (py-sub-boolX-strY-inline x-773 y-774)
  `(py-sub-boolX-strY-fallback ,x-773 ,y-774))

(define-macro (py-sub-boolX-sintY-inline x-776 y-777)
  `(py-sub-boolX-sintY-fallback ,x-776 ,y-777))

(define-macro (py-sub-boolX-bintY-inline x-779 y-780)
  `(py-sub-boolX-bintY-fallback ,x-779 ,y-780))

(define-macro (py-sub-strX-floatY-inline x-782 y-783)
  `(py-sub-strX-floatY-fallback ,x-782 ,y-783))

(define-macro (py-sub-strX-boolY-inline x-785 y-786)
  `(py-sub-strX-boolY-fallback ,x-785 ,y-786))

(define-macro (py-sub-strX-strY-inline x-788 y-789)
  `(py-sub-strX-strY-fallback ,x-788 ,y-789))

(define-macro (py-sub-strX-sintY-inline x-791 y-792)
  `(py-sub-strX-sintY-fallback ,x-791 ,y-792))

(define-macro (py-sub-strX-bintY-inline x-794 y-795)
  `(py-sub-strX-bintY-fallback ,x-794 ,y-795))

(define-macro (py-sub-sintX-floatY-inline x-797 y-798)
  `(let ((x-797 ,x-797) (y-798 ,y-798))
     (py-float-from-scheme
      (py- (py-sint-to-scheme x-797) (py-float-to-scheme y-798)))))

(define-macro (py-sub-sintX-boolY-inline x-800 y-801)
  `(py-sub-sintX-boolY-fallback ,x-800 ,y-801))

(define-macro (py-sub-sintX-strY-inline x-803 y-804)
  `(py-sub-sintX-strY-fallback ,x-803 ,y-804))

(define-macro (py-sub-sintX-sintY-inline x-806 y-807)
  `(let ((x-806 ,x-806) (y-807 ,y-807))
     (py-int-from-scheme
      (py- (py-sint-to-scheme x-806) (py-sint-to-scheme y-807)))))

(define-macro (py-sub-sintX-bintY-inline x-809 y-810)
  `(py-sub-sintX-bintY-fallback ,x-809 ,y-810))

(define-macro (py-sub-bintX-floatY-inline x-812 y-813)
  `(py-sub-bintX-floatY-fallback ,x-812 ,y-813))

(define-macro (py-sub-bintX-boolY-inline x-815 y-816)
  `(py-sub-bintX-boolY-fallback ,x-815 ,y-816))

(define-macro (py-sub-bintX-strY-inline x-818 y-819)
  `(py-sub-bintX-strY-fallback ,x-818 ,y-819))

(define-macro (py-sub-bintX-sintY-inline x-821 y-822)
  `(py-sub-bintX-sintY-fallback ,x-821 ,y-822))

(define-macro (py-sub-bintX-bintY-inline x-824 y-825)
  `(py-sub-bintX-bintY-fallback ,x-824 ,y-825))

(define-macro (py-truediv-floatX-floatY-inline x-827 y-828)
  `(let ((x-827 ,x-827) (y-828 ,y-828))
     (if (py-test (py-ne y-828 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py/ (py-float-to-scheme x-827) (py-float-to-scheme y-828)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-truediv-floatX-boolY-inline x-830 y-831)
  `(py-truediv-floatX-boolY-fallback ,x-830 ,y-831))

(define-macro (py-truediv-floatX-strY-inline x-833 y-834)
  `(py-truediv-floatX-strY-fallback ,x-833 ,y-834))

(define-macro (py-truediv-floatX-sintY-inline x-836 y-837)
  `(let ((x-836 ,x-836) (y-837 ,y-837))
     (if (py-test (py-ne y-837 (py-int-from-scheme 0)))
         (py-float-from-scheme
          (py/ (py-float-to-scheme x-836) (py-sint-to-scheme y-837)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-truediv-floatX-bintY-inline x-839 y-840)
  `(py-truediv-floatX-bintY-fallback ,x-839 ,y-840))

(define-macro (py-truediv-boolX-floatY-inline x-842 y-843)
  `(py-truediv-boolX-floatY-fallback ,x-842 ,y-843))

(define-macro (py-truediv-boolX-boolY-inline x-845 y-846)
  `(py-truediv-boolX-boolY-fallback ,x-845 ,y-846))

(define-macro (py-truediv-boolX-strY-inline x-848 y-849)
  `(py-truediv-boolX-strY-fallback ,x-848 ,y-849))

(define-macro (py-truediv-boolX-sintY-inline x-851 y-852)
  `(py-truediv-boolX-sintY-fallback ,x-851 ,y-852))

(define-macro (py-truediv-boolX-bintY-inline x-854 y-855)
  `(py-truediv-boolX-bintY-fallback ,x-854 ,y-855))

(define-macro (py-truediv-strX-floatY-inline x-857 y-858)
  `(py-truediv-strX-floatY-fallback ,x-857 ,y-858))

(define-macro (py-truediv-strX-boolY-inline x-860 y-861)
  `(py-truediv-strX-boolY-fallback ,x-860 ,y-861))

(define-macro (py-truediv-strX-strY-inline x-863 y-864)
  `(py-truediv-strX-strY-fallback ,x-863 ,y-864))

(define-macro (py-truediv-strX-sintY-inline x-866 y-867)
  `(py-truediv-strX-sintY-fallback ,x-866 ,y-867))

(define-macro (py-truediv-strX-bintY-inline x-869 y-870)
  `(py-truediv-strX-bintY-fallback ,x-869 ,y-870))

(define-macro (py-truediv-sintX-floatY-inline x-872 y-873)
  `(let ((x-872 ,x-872) (y-873 ,y-873))
     (if (py-test (py-ne y-873 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py/ (py-sint-to-scheme x-872) (py-float-to-scheme y-873)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-truediv-sintX-boolY-inline x-875 y-876)
  `(py-truediv-sintX-boolY-fallback ,x-875 ,y-876))

(define-macro (py-truediv-sintX-strY-inline x-878 y-879)
  `(py-truediv-sintX-strY-fallback ,x-878 ,y-879))

(define-macro (py-truediv-sintX-sintY-inline x-881 y-882)
  `(let ((x-881 ,x-881) (y-882 ,y-882))
     (if (py-test (py-ne y-882 (py-int-from-scheme 0)))
         (py-float-from-scheme
          (py/ (py-sint-to-scheme x-881) (py-sint-to-scheme y-882)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError (&& "division by zero"))))))

(define-macro (py-truediv-sintX-bintY-inline x-884 y-885)
  `(py-truediv-sintX-bintY-fallback ,x-884 ,y-885))

(define-macro (py-truediv-bintX-floatY-inline x-887 y-888)
  `(py-truediv-bintX-floatY-fallback ,x-887 ,y-888))

(define-macro (py-truediv-bintX-boolY-inline x-890 y-891)
  `(py-truediv-bintX-boolY-fallback ,x-890 ,y-891))

(define-macro (py-truediv-bintX-strY-inline x-893 y-894)
  `(py-truediv-bintX-strY-fallback ,x-893 ,y-894))

(define-macro (py-truediv-bintX-sintY-inline x-896 y-897)
  `(py-truediv-bintX-sintY-fallback ,x-896 ,y-897))

(define-macro (py-truediv-bintX-bintY-inline x-899 y-900)
  `(py-truediv-bintX-bintY-fallback ,x-899 ,y-900))

(define-macro (py-xor-floatX-floatY-inline x-902 y-903)
  `(let ((x-902 ,x-902) (y-903 ,y-903))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for ^: 'float' and 'float'")))))

(define-macro (py-xor-floatX-boolY-inline x-905 y-906)
  `(py-xor-floatX-boolY-fallback ,x-905 ,y-906))

(define-macro (py-xor-floatX-strY-inline x-908 y-909)
  `(py-xor-floatX-strY-fallback ,x-908 ,y-909))

(define-macro (py-xor-floatX-sintY-inline x-911 y-912)
  `(let ((x-911 ,x-911) (y-912 ,y-912))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for ^: 'float' and 'int'")))))

(define-macro (py-xor-floatX-bintY-inline x-914 y-915)
  `(py-xor-floatX-bintY-fallback ,x-914 ,y-915))

(define-macro (py-xor-boolX-floatY-inline x-917 y-918)
  `(py-xor-boolX-floatY-fallback ,x-917 ,y-918))

(define-macro (py-xor-boolX-boolY-inline x-920 y-921)
  `(py-xor-boolX-boolY-fallback ,x-920 ,y-921))

(define-macro (py-xor-boolX-strY-inline x-923 y-924)
  `(py-xor-boolX-strY-fallback ,x-923 ,y-924))

(define-macro (py-xor-boolX-sintY-inline x-926 y-927)
  `(py-xor-boolX-sintY-fallback ,x-926 ,y-927))

(define-macro (py-xor-boolX-bintY-inline x-929 y-930)
  `(py-xor-boolX-bintY-fallback ,x-929 ,y-930))

(define-macro (py-xor-strX-floatY-inline x-932 y-933)
  `(py-xor-strX-floatY-fallback ,x-932 ,y-933))

(define-macro (py-xor-strX-boolY-inline x-935 y-936)
  `(py-xor-strX-boolY-fallback ,x-935 ,y-936))

(define-macro (py-xor-strX-strY-inline x-938 y-939)
  `(py-xor-strX-strY-fallback ,x-938 ,y-939))

(define-macro (py-xor-strX-sintY-inline x-941 y-942)
  `(py-xor-strX-sintY-fallback ,x-941 ,y-942))

(define-macro (py-xor-strX-bintY-inline x-944 y-945)
  `(py-xor-strX-bintY-fallback ,x-944 ,y-945))

(define-macro (py-xor-sintX-floatY-inline x-947 y-948)
  `(let ((x-947 ,x-947) (y-948 ,y-948))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for ^: 'int' and 'float'")))))

(define-macro (py-xor-sintX-boolY-inline x-950 y-951)
  `(py-xor-sintX-boolY-fallback ,x-950 ,y-951))

(define-macro (py-xor-sintX-strY-inline x-953 y-954)
  `(py-xor-sintX-strY-fallback ,x-953 ,y-954))

(define-macro (py-xor-sintX-sintY-inline x-956 y-957)
  `(let ((x-956 ,x-956) (y-957 ,y-957))
     (py-int-from-scheme
      (py^ (py-sint-to-scheme x-956) (py-sint-to-scheme y-957)))))

(define-macro (py-xor-sintX-bintY-inline x-959 y-960)
  `(py-xor-sintX-bintY-fallback ,x-959 ,y-960))

(define-macro (py-xor-bintX-floatY-inline x-962 y-963)
  `(py-xor-bintX-floatY-fallback ,x-962 ,y-963))

(define-macro (py-xor-bintX-boolY-inline x-965 y-966)
  `(py-xor-bintX-boolY-fallback ,x-965 ,y-966))

(define-macro (py-xor-bintX-strY-inline x-968 y-969)
  `(py-xor-bintX-strY-fallback ,x-968 ,y-969))

(define-macro (py-xor-bintX-sintY-inline x-971 y-972)
  `(py-xor-bintX-sintY-fallback ,x-971 ,y-972))

(define-macro (py-xor-bintX-bintY-inline x-974 y-975)
  `(py-xor-bintX-bintY-fallback ,x-974 ,y-975))

(define-macro (py-iadd-floatX-floatY-inline x-977 y-978)
  `(let ((x-977 ,x-977) (y-978 ,y-978))
     (py-float-from-scheme
      (py+ (py-float-to-scheme x-977) (py-float-to-scheme y-978)))))

(define-macro (py-iadd-floatX-boolY-inline x-980 y-981)
  `(py-iadd-floatX-boolY-fallback ,x-980 ,y-981))

(define-macro (py-iadd-floatX-strY-inline x-983 y-984)
  `(py-iadd-floatX-strY-fallback ,x-983 ,y-984))

(define-macro (py-iadd-floatX-sintY-inline x-986 y-987)
  `(let ((x-986 ,x-986) (y-987 ,y-987))
     (py-float-from-scheme
      (py+ (py-float-to-scheme x-986) (py-sint-to-scheme y-987)))))

(define-macro (py-iadd-floatX-bintY-inline x-989 y-990)
  `(py-iadd-floatX-bintY-fallback ,x-989 ,y-990))

(define-macro (py-iadd-boolX-floatY-inline x-992 y-993)
  `(py-iadd-boolX-floatY-fallback ,x-992 ,y-993))

(define-macro (py-iadd-boolX-boolY-inline x-995 y-996)
  `(py-iadd-boolX-boolY-fallback ,x-995 ,y-996))

(define-macro (py-iadd-boolX-strY-inline x-998 y-999)
  `(py-iadd-boolX-strY-fallback ,x-998 ,y-999))

(define-macro (py-iadd-boolX-sintY-inline x-1001 y-1002)
  `(py-iadd-boolX-sintY-fallback ,x-1001 ,y-1002))

(define-macro (py-iadd-boolX-bintY-inline x-1004 y-1005)
  `(py-iadd-boolX-bintY-fallback ,x-1004 ,y-1005))

(define-macro (py-iadd-strX-floatY-inline x-1007 y-1008)
  `(py-iadd-strX-floatY-fallback ,x-1007 ,y-1008))

(define-macro (py-iadd-strX-boolY-inline x-1010 y-1011)
  `(py-iadd-strX-boolY-fallback ,x-1010 ,y-1011))

(define-macro (py-iadd-strX-strY-inline x-1013 y-1014)
  `(py-iadd-strX-strY-fallback ,x-1013 ,y-1014))

(define-macro (py-iadd-strX-sintY-inline x-1016 y-1017)
  `(py-iadd-strX-sintY-fallback ,x-1016 ,y-1017))

(define-macro (py-iadd-strX-bintY-inline x-1019 y-1020)
  `(py-iadd-strX-bintY-fallback ,x-1019 ,y-1020))

(define-macro (py-iadd-sintX-floatY-inline x-1022 y-1023)
  `(let ((x-1022 ,x-1022) (y-1023 ,y-1023))
     (py-float-from-scheme
      (py+ (py-sint-to-scheme x-1022) (py-float-to-scheme y-1023)))))

(define-macro (py-iadd-sintX-boolY-inline x-1025 y-1026)
  `(py-iadd-sintX-boolY-fallback ,x-1025 ,y-1026))

(define-macro (py-iadd-sintX-strY-inline x-1028 y-1029)
  `(py-iadd-sintX-strY-fallback ,x-1028 ,y-1029))

(define-macro (py-iadd-sintX-sintY-inline x-1031 y-1032)
  `(let ((x-1031 ,x-1031) (y-1032 ,y-1032))
     (py-int-from-scheme
      (py+ (py-sint-to-scheme x-1031) (py-sint-to-scheme y-1032)))))

(define-macro (py-iadd-sintX-bintY-inline x-1034 y-1035)
  `(py-iadd-sintX-bintY-fallback ,x-1034 ,y-1035))

(define-macro (py-iadd-bintX-floatY-inline x-1037 y-1038)
  `(py-iadd-bintX-floatY-fallback ,x-1037 ,y-1038))

(define-macro (py-iadd-bintX-boolY-inline x-1040 y-1041)
  `(py-iadd-bintX-boolY-fallback ,x-1040 ,y-1041))

(define-macro (py-iadd-bintX-strY-inline x-1043 y-1044)
  `(py-iadd-bintX-strY-fallback ,x-1043 ,y-1044))

(define-macro (py-iadd-bintX-sintY-inline x-1046 y-1047)
  `(py-iadd-bintX-sintY-fallback ,x-1046 ,y-1047))

(define-macro (py-iadd-bintX-bintY-inline x-1049 y-1050)
  `(py-iadd-bintX-bintY-fallback ,x-1049 ,y-1050))

(define-macro (py-ibitand-floatX-floatY-inline x-1052 y-1053)
  `(let ((x-1052 ,x-1052) (y-1053 ,y-1053))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for &=: 'float' and 'float'")))))

(define-macro (py-ibitand-floatX-boolY-inline x-1055 y-1056)
  `(py-ibitand-floatX-boolY-fallback ,x-1055 ,y-1056))

(define-macro (py-ibitand-floatX-strY-inline x-1058 y-1059)
  `(py-ibitand-floatX-strY-fallback ,x-1058 ,y-1059))

(define-macro (py-ibitand-floatX-sintY-inline x-1061 y-1062)
  `(let ((x-1061 ,x-1061) (y-1062 ,y-1062))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for &=: 'float' and 'int'")))))

(define-macro (py-ibitand-floatX-bintY-inline x-1064 y-1065)
  `(py-ibitand-floatX-bintY-fallback ,x-1064 ,y-1065))

(define-macro (py-ibitand-boolX-floatY-inline x-1067 y-1068)
  `(py-ibitand-boolX-floatY-fallback ,x-1067 ,y-1068))

(define-macro (py-ibitand-boolX-boolY-inline x-1070 y-1071)
  `(py-ibitand-boolX-boolY-fallback ,x-1070 ,y-1071))

(define-macro (py-ibitand-boolX-strY-inline x-1073 y-1074)
  `(py-ibitand-boolX-strY-fallback ,x-1073 ,y-1074))

(define-macro (py-ibitand-boolX-sintY-inline x-1076 y-1077)
  `(py-ibitand-boolX-sintY-fallback ,x-1076 ,y-1077))

(define-macro (py-ibitand-boolX-bintY-inline x-1079 y-1080)
  `(py-ibitand-boolX-bintY-fallback ,x-1079 ,y-1080))

(define-macro (py-ibitand-strX-floatY-inline x-1082 y-1083)
  `(py-ibitand-strX-floatY-fallback ,x-1082 ,y-1083))

(define-macro (py-ibitand-strX-boolY-inline x-1085 y-1086)
  `(py-ibitand-strX-boolY-fallback ,x-1085 ,y-1086))

(define-macro (py-ibitand-strX-strY-inline x-1088 y-1089)
  `(py-ibitand-strX-strY-fallback ,x-1088 ,y-1089))

(define-macro (py-ibitand-strX-sintY-inline x-1091 y-1092)
  `(py-ibitand-strX-sintY-fallback ,x-1091 ,y-1092))

(define-macro (py-ibitand-strX-bintY-inline x-1094 y-1095)
  `(py-ibitand-strX-bintY-fallback ,x-1094 ,y-1095))

(define-macro (py-ibitand-sintX-floatY-inline x-1097 y-1098)
  `(let ((x-1097 ,x-1097) (y-1098 ,y-1098))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for &=: 'int' and 'float'")))))

(define-macro (py-ibitand-sintX-boolY-inline x-1100 y-1101)
  `(py-ibitand-sintX-boolY-fallback ,x-1100 ,y-1101))

(define-macro (py-ibitand-sintX-strY-inline x-1103 y-1104)
  `(py-ibitand-sintX-strY-fallback ,x-1103 ,y-1104))

(define-macro (py-ibitand-sintX-sintY-inline x-1106 y-1107)
  `(let ((x-1106 ,x-1106) (y-1107 ,y-1107))
     (py-int-from-scheme
      (py& (py-sint-to-scheme x-1106) (py-sint-to-scheme y-1107)))))

(define-macro (py-ibitand-sintX-bintY-inline x-1109 y-1110)
  `(py-ibitand-sintX-bintY-fallback ,x-1109 ,y-1110))

(define-macro (py-ibitand-bintX-floatY-inline x-1112 y-1113)
  `(py-ibitand-bintX-floatY-fallback ,x-1112 ,y-1113))

(define-macro (py-ibitand-bintX-boolY-inline x-1115 y-1116)
  `(py-ibitand-bintX-boolY-fallback ,x-1115 ,y-1116))

(define-macro (py-ibitand-bintX-strY-inline x-1118 y-1119)
  `(py-ibitand-bintX-strY-fallback ,x-1118 ,y-1119))

(define-macro (py-ibitand-bintX-sintY-inline x-1121 y-1122)
  `(py-ibitand-bintX-sintY-fallback ,x-1121 ,y-1122))

(define-macro (py-ibitand-bintX-bintY-inline x-1124 y-1125)
  `(py-ibitand-bintX-bintY-fallback ,x-1124 ,y-1125))

(define-macro (py-ibitor-floatX-floatY-inline x-1127 y-1128)
  `(let ((x-1127 ,x-1127) (y-1128 ,y-1128))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for |=: 'float' and 'float'")))))

(define-macro (py-ibitor-floatX-boolY-inline x-1130 y-1131)
  `(py-ibitor-floatX-boolY-fallback ,x-1130 ,y-1131))

(define-macro (py-ibitor-floatX-strY-inline x-1133 y-1134)
  `(py-ibitor-floatX-strY-fallback ,x-1133 ,y-1134))

(define-macro (py-ibitor-floatX-sintY-inline x-1136 y-1137)
  `(let ((x-1136 ,x-1136) (y-1137 ,y-1137))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for |=: 'float' and 'int'")))))

(define-macro (py-ibitor-floatX-bintY-inline x-1139 y-1140)
  `(py-ibitor-floatX-bintY-fallback ,x-1139 ,y-1140))

(define-macro (py-ibitor-boolX-floatY-inline x-1142 y-1143)
  `(py-ibitor-boolX-floatY-fallback ,x-1142 ,y-1143))

(define-macro (py-ibitor-boolX-boolY-inline x-1145 y-1146)
  `(py-ibitor-boolX-boolY-fallback ,x-1145 ,y-1146))

(define-macro (py-ibitor-boolX-strY-inline x-1148 y-1149)
  `(py-ibitor-boolX-strY-fallback ,x-1148 ,y-1149))

(define-macro (py-ibitor-boolX-sintY-inline x-1151 y-1152)
  `(py-ibitor-boolX-sintY-fallback ,x-1151 ,y-1152))

(define-macro (py-ibitor-boolX-bintY-inline x-1154 y-1155)
  `(py-ibitor-boolX-bintY-fallback ,x-1154 ,y-1155))

(define-macro (py-ibitor-strX-floatY-inline x-1157 y-1158)
  `(py-ibitor-strX-floatY-fallback ,x-1157 ,y-1158))

(define-macro (py-ibitor-strX-boolY-inline x-1160 y-1161)
  `(py-ibitor-strX-boolY-fallback ,x-1160 ,y-1161))

(define-macro (py-ibitor-strX-strY-inline x-1163 y-1164)
  `(py-ibitor-strX-strY-fallback ,x-1163 ,y-1164))

(define-macro (py-ibitor-strX-sintY-inline x-1166 y-1167)
  `(py-ibitor-strX-sintY-fallback ,x-1166 ,y-1167))

(define-macro (py-ibitor-strX-bintY-inline x-1169 y-1170)
  `(py-ibitor-strX-bintY-fallback ,x-1169 ,y-1170))

(define-macro (py-ibitor-sintX-floatY-inline x-1172 y-1173)
  `(let ((x-1172 ,x-1172) (y-1173 ,y-1173))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for |=: 'int' and 'float'")))))

(define-macro (py-ibitor-sintX-boolY-inline x-1175 y-1176)
  `(py-ibitor-sintX-boolY-fallback ,x-1175 ,y-1176))

(define-macro (py-ibitor-sintX-strY-inline x-1178 y-1179)
  `(py-ibitor-sintX-strY-fallback ,x-1178 ,y-1179))

(define-macro (py-ibitor-sintX-sintY-inline x-1181 y-1182)
  `(let ((x-1181 ,x-1181) (y-1182 ,y-1182))
     (py-int-from-scheme
      (py+b (py-sint-to-scheme x-1181) (py-sint-to-scheme y-1182)))))

(define-macro (py-ibitor-sintX-bintY-inline x-1184 y-1185)
  `(py-ibitor-sintX-bintY-fallback ,x-1184 ,y-1185))

(define-macro (py-ibitor-bintX-floatY-inline x-1187 y-1188)
  `(py-ibitor-bintX-floatY-fallback ,x-1187 ,y-1188))

(define-macro (py-ibitor-bintX-boolY-inline x-1190 y-1191)
  `(py-ibitor-bintX-boolY-fallback ,x-1190 ,y-1191))

(define-macro (py-ibitor-bintX-strY-inline x-1193 y-1194)
  `(py-ibitor-bintX-strY-fallback ,x-1193 ,y-1194))

(define-macro (py-ibitor-bintX-sintY-inline x-1196 y-1197)
  `(py-ibitor-bintX-sintY-fallback ,x-1196 ,y-1197))

(define-macro (py-ibitor-bintX-bintY-inline x-1199 y-1200)
  `(py-ibitor-bintX-bintY-fallback ,x-1199 ,y-1200))

(define-macro (py-ifloordiv-floatX-floatY-inline x-1202 y-1203)
  `(let ((x-1202 ,x-1202) (y-1203 ,y-1203))
     (if (py-test (py-ne y-1203 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py// (py-float-to-scheme x-1202) (py-float-to-scheme y-1203)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-ifloordiv-floatX-boolY-inline x-1205 y-1206)
  `(py-ifloordiv-floatX-boolY-fallback ,x-1205 ,y-1206))

(define-macro (py-ifloordiv-floatX-strY-inline x-1208 y-1209)
  `(py-ifloordiv-floatX-strY-fallback ,x-1208 ,y-1209))

(define-macro (py-ifloordiv-floatX-sintY-inline x-1211 y-1212)
  `(let ((x-1211 ,x-1211) (y-1212 ,y-1212))
     (if (py-test (py-ne y-1212 (py-int-from-scheme 0)))
         (py-float-from-scheme
          (py// (py-float-to-scheme x-1211) (py-sint-to-scheme y-1212)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-ifloordiv-floatX-bintY-inline x-1214 y-1215)
  `(py-ifloordiv-floatX-bintY-fallback ,x-1214 ,y-1215))

(define-macro (py-ifloordiv-boolX-floatY-inline x-1217 y-1218)
  `(py-ifloordiv-boolX-floatY-fallback ,x-1217 ,y-1218))

(define-macro (py-ifloordiv-boolX-boolY-inline x-1220 y-1221)
  `(py-ifloordiv-boolX-boolY-fallback ,x-1220 ,y-1221))

(define-macro (py-ifloordiv-boolX-strY-inline x-1223 y-1224)
  `(py-ifloordiv-boolX-strY-fallback ,x-1223 ,y-1224))

(define-macro (py-ifloordiv-boolX-sintY-inline x-1226 y-1227)
  `(py-ifloordiv-boolX-sintY-fallback ,x-1226 ,y-1227))

(define-macro (py-ifloordiv-boolX-bintY-inline x-1229 y-1230)
  `(py-ifloordiv-boolX-bintY-fallback ,x-1229 ,y-1230))

(define-macro (py-ifloordiv-strX-floatY-inline x-1232 y-1233)
  `(py-ifloordiv-strX-floatY-fallback ,x-1232 ,y-1233))

(define-macro (py-ifloordiv-strX-boolY-inline x-1235 y-1236)
  `(py-ifloordiv-strX-boolY-fallback ,x-1235 ,y-1236))

(define-macro (py-ifloordiv-strX-strY-inline x-1238 y-1239)
  `(py-ifloordiv-strX-strY-fallback ,x-1238 ,y-1239))

(define-macro (py-ifloordiv-strX-sintY-inline x-1241 y-1242)
  `(py-ifloordiv-strX-sintY-fallback ,x-1241 ,y-1242))

(define-macro (py-ifloordiv-strX-bintY-inline x-1244 y-1245)
  `(py-ifloordiv-strX-bintY-fallback ,x-1244 ,y-1245))

(define-macro (py-ifloordiv-sintX-floatY-inline x-1247 y-1248)
  `(let ((x-1247 ,x-1247) (y-1248 ,y-1248))
     (if (py-test (py-ne y-1248 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py// (py-sint-to-scheme x-1247) (py-float-to-scheme y-1248)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-ifloordiv-sintX-boolY-inline x-1250 y-1251)
  `(py-ifloordiv-sintX-boolY-fallback ,x-1250 ,y-1251))

(define-macro (py-ifloordiv-sintX-strY-inline x-1253 y-1254)
  `(py-ifloordiv-sintX-strY-fallback ,x-1253 ,y-1254))

(define-macro (py-ifloordiv-sintX-sintY-inline x-1256 y-1257)
  `(let ((x-1256 ,x-1256) (y-1257 ,y-1257))
     (if (py-test (py-ne y-1257 (py-int-from-scheme 0)))
         (py-int-from-scheme
          (py// (py-sint-to-scheme x-1256) (py-sint-to-scheme y-1257)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "integer division by zero"))))))

(define-macro (py-ifloordiv-sintX-bintY-inline x-1259 y-1260)
  `(py-ifloordiv-sintX-bintY-fallback ,x-1259 ,y-1260))

(define-macro (py-ifloordiv-bintX-floatY-inline x-1262 y-1263)
  `(py-ifloordiv-bintX-floatY-fallback ,x-1262 ,y-1263))

(define-macro (py-ifloordiv-bintX-boolY-inline x-1265 y-1266)
  `(py-ifloordiv-bintX-boolY-fallback ,x-1265 ,y-1266))

(define-macro (py-ifloordiv-bintX-strY-inline x-1268 y-1269)
  `(py-ifloordiv-bintX-strY-fallback ,x-1268 ,y-1269))

(define-macro (py-ifloordiv-bintX-sintY-inline x-1271 y-1272)
  `(py-ifloordiv-bintX-sintY-fallback ,x-1271 ,y-1272))

(define-macro (py-ifloordiv-bintX-bintY-inline x-1274 y-1275)
  `(py-ifloordiv-bintX-bintY-fallback ,x-1274 ,y-1275))

(define-macro (py-ilshift-floatX-floatY-inline x-1277 y-1278)
  `(let ((x-1277 ,x-1277) (y-1278 ,y-1278))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for <<=: 'float' and 'float'")))))

(define-macro (py-ilshift-floatX-boolY-inline x-1280 y-1281)
  `(py-ilshift-floatX-boolY-fallback ,x-1280 ,y-1281))

(define-macro (py-ilshift-floatX-strY-inline x-1283 y-1284)
  `(py-ilshift-floatX-strY-fallback ,x-1283 ,y-1284))

(define-macro (py-ilshift-floatX-sintY-inline x-1286 y-1287)
  `(let ((x-1286 ,x-1286) (y-1287 ,y-1287))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for <<=: 'float' and 'int'")))))

(define-macro (py-ilshift-floatX-bintY-inline x-1289 y-1290)
  `(py-ilshift-floatX-bintY-fallback ,x-1289 ,y-1290))

(define-macro (py-ilshift-boolX-floatY-inline x-1292 y-1293)
  `(py-ilshift-boolX-floatY-fallback ,x-1292 ,y-1293))

(define-macro (py-ilshift-boolX-boolY-inline x-1295 y-1296)
  `(py-ilshift-boolX-boolY-fallback ,x-1295 ,y-1296))

(define-macro (py-ilshift-boolX-strY-inline x-1298 y-1299)
  `(py-ilshift-boolX-strY-fallback ,x-1298 ,y-1299))

(define-macro (py-ilshift-boolX-sintY-inline x-1301 y-1302)
  `(py-ilshift-boolX-sintY-fallback ,x-1301 ,y-1302))

(define-macro (py-ilshift-boolX-bintY-inline x-1304 y-1305)
  `(py-ilshift-boolX-bintY-fallback ,x-1304 ,y-1305))

(define-macro (py-ilshift-strX-floatY-inline x-1307 y-1308)
  `(py-ilshift-strX-floatY-fallback ,x-1307 ,y-1308))

(define-macro (py-ilshift-strX-boolY-inline x-1310 y-1311)
  `(py-ilshift-strX-boolY-fallback ,x-1310 ,y-1311))

(define-macro (py-ilshift-strX-strY-inline x-1313 y-1314)
  `(py-ilshift-strX-strY-fallback ,x-1313 ,y-1314))

(define-macro (py-ilshift-strX-sintY-inline x-1316 y-1317)
  `(py-ilshift-strX-sintY-fallback ,x-1316 ,y-1317))

(define-macro (py-ilshift-strX-bintY-inline x-1319 y-1320)
  `(py-ilshift-strX-bintY-fallback ,x-1319 ,y-1320))

(define-macro (py-ilshift-sintX-floatY-inline x-1322 y-1323)
  `(let ((x-1322 ,x-1322) (y-1323 ,y-1323))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for <<=: 'int' and 'float'")))))

(define-macro (py-ilshift-sintX-boolY-inline x-1325 y-1326)
  `(py-ilshift-sintX-boolY-fallback ,x-1325 ,y-1326))

(define-macro (py-ilshift-sintX-strY-inline x-1328 y-1329)
  `(py-ilshift-sintX-strY-fallback ,x-1328 ,y-1329))

(define-macro (py-ilshift-sintX-sintY-inline x-1331 y-1332)
  `(let ((x-1331 ,x-1331) (y-1332 ,y-1332))
     (if (py-test (py-ge y-1332 (py-int-from-scheme 0)))
         (py-int-from-scheme
          (py<< (py-sint-to-scheme x-1331) (py-sint-to-scheme y-1332)))
         (py-throw
          (py-call py-builtin-ValueError (&& "negative shift count"))))))

(define-macro (py-ilshift-sintX-bintY-inline x-1334 y-1335)
  `(py-ilshift-sintX-bintY-fallback ,x-1334 ,y-1335))

(define-macro (py-ilshift-bintX-floatY-inline x-1337 y-1338)
  `(py-ilshift-bintX-floatY-fallback ,x-1337 ,y-1338))

(define-macro (py-ilshift-bintX-boolY-inline x-1340 y-1341)
  `(py-ilshift-bintX-boolY-fallback ,x-1340 ,y-1341))

(define-macro (py-ilshift-bintX-strY-inline x-1343 y-1344)
  `(py-ilshift-bintX-strY-fallback ,x-1343 ,y-1344))

(define-macro (py-ilshift-bintX-sintY-inline x-1346 y-1347)
  `(py-ilshift-bintX-sintY-fallback ,x-1346 ,y-1347))

(define-macro (py-ilshift-bintX-bintY-inline x-1349 y-1350)
  `(py-ilshift-bintX-bintY-fallback ,x-1349 ,y-1350))

(define-macro (py-imatmul-floatX-floatY-inline x-1352 y-1353)
  `(let ((x-1352 ,x-1352) (y-1353 ,y-1353))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @=: 'float' and 'float'")))))

(define-macro (py-imatmul-floatX-boolY-inline x-1355 y-1356)
  `(py-imatmul-floatX-boolY-fallback ,x-1355 ,y-1356))

(define-macro (py-imatmul-floatX-strY-inline x-1358 y-1359)
  `(py-imatmul-floatX-strY-fallback ,x-1358 ,y-1359))

(define-macro (py-imatmul-floatX-sintY-inline x-1361 y-1362)
  `(let ((x-1361 ,x-1361) (y-1362 ,y-1362))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @=: 'float' and 'int'")))))

(define-macro (py-imatmul-floatX-bintY-inline x-1364 y-1365)
  `(py-imatmul-floatX-bintY-fallback ,x-1364 ,y-1365))

(define-macro (py-imatmul-boolX-floatY-inline x-1367 y-1368)
  `(py-imatmul-boolX-floatY-fallback ,x-1367 ,y-1368))

(define-macro (py-imatmul-boolX-boolY-inline x-1370 y-1371)
  `(py-imatmul-boolX-boolY-fallback ,x-1370 ,y-1371))

(define-macro (py-imatmul-boolX-strY-inline x-1373 y-1374)
  `(py-imatmul-boolX-strY-fallback ,x-1373 ,y-1374))

(define-macro (py-imatmul-boolX-sintY-inline x-1376 y-1377)
  `(py-imatmul-boolX-sintY-fallback ,x-1376 ,y-1377))

(define-macro (py-imatmul-boolX-bintY-inline x-1379 y-1380)
  `(py-imatmul-boolX-bintY-fallback ,x-1379 ,y-1380))

(define-macro (py-imatmul-strX-floatY-inline x-1382 y-1383)
  `(py-imatmul-strX-floatY-fallback ,x-1382 ,y-1383))

(define-macro (py-imatmul-strX-boolY-inline x-1385 y-1386)
  `(py-imatmul-strX-boolY-fallback ,x-1385 ,y-1386))

(define-macro (py-imatmul-strX-strY-inline x-1388 y-1389)
  `(py-imatmul-strX-strY-fallback ,x-1388 ,y-1389))

(define-macro (py-imatmul-strX-sintY-inline x-1391 y-1392)
  `(py-imatmul-strX-sintY-fallback ,x-1391 ,y-1392))

(define-macro (py-imatmul-strX-bintY-inline x-1394 y-1395)
  `(py-imatmul-strX-bintY-fallback ,x-1394 ,y-1395))

(define-macro (py-imatmul-sintX-floatY-inline x-1397 y-1398)
  `(let ((x-1397 ,x-1397) (y-1398 ,y-1398))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @=: 'int' and 'float'")))))

(define-macro (py-imatmul-sintX-boolY-inline x-1400 y-1401)
  `(py-imatmul-sintX-boolY-fallback ,x-1400 ,y-1401))

(define-macro (py-imatmul-sintX-strY-inline x-1403 y-1404)
  `(py-imatmul-sintX-strY-fallback ,x-1403 ,y-1404))

(define-macro (py-imatmul-sintX-sintY-inline x-1406 y-1407)
  `(let ((x-1406 ,x-1406) (y-1407 ,y-1407))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @=: 'int' and 'int'")))))

(define-macro (py-imatmul-sintX-bintY-inline x-1409 y-1410)
  `(py-imatmul-sintX-bintY-fallback ,x-1409 ,y-1410))

(define-macro (py-imatmul-bintX-floatY-inline x-1412 y-1413)
  `(py-imatmul-bintX-floatY-fallback ,x-1412 ,y-1413))

(define-macro (py-imatmul-bintX-boolY-inline x-1415 y-1416)
  `(py-imatmul-bintX-boolY-fallback ,x-1415 ,y-1416))

(define-macro (py-imatmul-bintX-strY-inline x-1418 y-1419)
  `(py-imatmul-bintX-strY-fallback ,x-1418 ,y-1419))

(define-macro (py-imatmul-bintX-sintY-inline x-1421 y-1422)
  `(py-imatmul-bintX-sintY-fallback ,x-1421 ,y-1422))

(define-macro (py-imatmul-bintX-bintY-inline x-1424 y-1425)
  `(py-imatmul-bintX-bintY-fallback ,x-1424 ,y-1425))

(define-macro (py-imod-floatX-floatY-inline x-1427 y-1428)
  `(let ((x-1427 ,x-1427) (y-1428 ,y-1428))
     (if (py-test (py-ne y-1428 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py% (py-float-to-scheme x-1427) (py-float-to-scheme y-1428)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float modulo by zero"))))))

(define-macro (py-imod-floatX-boolY-inline x-1430 y-1431)
  `(py-imod-floatX-boolY-fallback ,x-1430 ,y-1431))

(define-macro (py-imod-floatX-strY-inline x-1433 y-1434)
  `(py-imod-floatX-strY-fallback ,x-1433 ,y-1434))

(define-macro (py-imod-floatX-sintY-inline x-1436 y-1437)
  `(let ((x-1436 ,x-1436) (y-1437 ,y-1437))
     (if (py-test (py-ne y-1437 (py-int-from-scheme 0)))
         (py-float-from-scheme
          (py% (py-float-to-scheme x-1436) (py-sint-to-scheme y-1437)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float modulo by zero"))))))

(define-macro (py-imod-floatX-bintY-inline x-1439 y-1440)
  `(py-imod-floatX-bintY-fallback ,x-1439 ,y-1440))

(define-macro (py-imod-boolX-floatY-inline x-1442 y-1443)
  `(py-imod-boolX-floatY-fallback ,x-1442 ,y-1443))

(define-macro (py-imod-boolX-boolY-inline x-1445 y-1446)
  `(py-imod-boolX-boolY-fallback ,x-1445 ,y-1446))

(define-macro (py-imod-boolX-strY-inline x-1448 y-1449)
  `(py-imod-boolX-strY-fallback ,x-1448 ,y-1449))

(define-macro (py-imod-boolX-sintY-inline x-1451 y-1452)
  `(py-imod-boolX-sintY-fallback ,x-1451 ,y-1452))

(define-macro (py-imod-boolX-bintY-inline x-1454 y-1455)
  `(py-imod-boolX-bintY-fallback ,x-1454 ,y-1455))

(define-macro (py-imod-strX-floatY-inline x-1457 y-1458)
  `(py-imod-strX-floatY-fallback ,x-1457 ,y-1458))

(define-macro (py-imod-strX-boolY-inline x-1460 y-1461)
  `(py-imod-strX-boolY-fallback ,x-1460 ,y-1461))

(define-macro (py-imod-strX-strY-inline x-1463 y-1464)
  `(py-imod-strX-strY-fallback ,x-1463 ,y-1464))

(define-macro (py-imod-strX-sintY-inline x-1466 y-1467)
  `(py-imod-strX-sintY-fallback ,x-1466 ,y-1467))

(define-macro (py-imod-strX-bintY-inline x-1469 y-1470)
  `(py-imod-strX-bintY-fallback ,x-1469 ,y-1470))

(define-macro (py-imod-sintX-floatY-inline x-1472 y-1473)
  `(let ((x-1472 ,x-1472) (y-1473 ,y-1473))
     (if (py-test (py-ne y-1473 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py% (py-sint-to-scheme x-1472) (py-float-to-scheme y-1473)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float modulo by zero"))))))

(define-macro (py-imod-sintX-boolY-inline x-1475 y-1476)
  `(py-imod-sintX-boolY-fallback ,x-1475 ,y-1476))

(define-macro (py-imod-sintX-strY-inline x-1478 y-1479)
  `(py-imod-sintX-strY-fallback ,x-1478 ,y-1479))

(define-macro (py-imod-sintX-sintY-inline x-1481 y-1482)
  `(let ((x-1481 ,x-1481) (y-1482 ,y-1482))
     (if (py-test (py-ne y-1482 (py-int-from-scheme 0)))
         (py-int-from-scheme
          (py% (py-sint-to-scheme x-1481) (py-sint-to-scheme y-1482)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError (&& "modulo by zero"))))))

(define-macro (py-imod-sintX-bintY-inline x-1484 y-1485)
  `(py-imod-sintX-bintY-fallback ,x-1484 ,y-1485))

(define-macro (py-imod-bintX-floatY-inline x-1487 y-1488)
  `(py-imod-bintX-floatY-fallback ,x-1487 ,y-1488))

(define-macro (py-imod-bintX-boolY-inline x-1490 y-1491)
  `(py-imod-bintX-boolY-fallback ,x-1490 ,y-1491))

(define-macro (py-imod-bintX-strY-inline x-1493 y-1494)
  `(py-imod-bintX-strY-fallback ,x-1493 ,y-1494))

(define-macro (py-imod-bintX-sintY-inline x-1496 y-1497)
  `(py-imod-bintX-sintY-fallback ,x-1496 ,y-1497))

(define-macro (py-imod-bintX-bintY-inline x-1499 y-1500)
  `(py-imod-bintX-bintY-fallback ,x-1499 ,y-1500))

(define-macro (py-imul-floatX-floatY-inline x-1502 y-1503)
  `(let ((x-1502 ,x-1502) (y-1503 ,y-1503))
     (py-float-from-scheme
      (py* (py-float-to-scheme x-1502) (py-float-to-scheme y-1503)))))

(define-macro (py-imul-floatX-boolY-inline x-1505 y-1506)
  `(py-imul-floatX-boolY-fallback ,x-1505 ,y-1506))

(define-macro (py-imul-floatX-strY-inline x-1508 y-1509)
  `(py-imul-floatX-strY-fallback ,x-1508 ,y-1509))

(define-macro (py-imul-floatX-sintY-inline x-1511 y-1512)
  `(let ((x-1511 ,x-1511) (y-1512 ,y-1512))
     (py-float-from-scheme
      (py* (py-float-to-scheme x-1511) (py-sint-to-scheme y-1512)))))

(define-macro (py-imul-floatX-bintY-inline x-1514 y-1515)
  `(py-imul-floatX-bintY-fallback ,x-1514 ,y-1515))

(define-macro (py-imul-boolX-floatY-inline x-1517 y-1518)
  `(py-imul-boolX-floatY-fallback ,x-1517 ,y-1518))

(define-macro (py-imul-boolX-boolY-inline x-1520 y-1521)
  `(py-imul-boolX-boolY-fallback ,x-1520 ,y-1521))

(define-macro (py-imul-boolX-strY-inline x-1523 y-1524)
  `(py-imul-boolX-strY-fallback ,x-1523 ,y-1524))

(define-macro (py-imul-boolX-sintY-inline x-1526 y-1527)
  `(py-imul-boolX-sintY-fallback ,x-1526 ,y-1527))

(define-macro (py-imul-boolX-bintY-inline x-1529 y-1530)
  `(py-imul-boolX-bintY-fallback ,x-1529 ,y-1530))

(define-macro (py-imul-strX-floatY-inline x-1532 y-1533)
  `(py-imul-strX-floatY-fallback ,x-1532 ,y-1533))

(define-macro (py-imul-strX-boolY-inline x-1535 y-1536)
  `(py-imul-strX-boolY-fallback ,x-1535 ,y-1536))

(define-macro (py-imul-strX-strY-inline x-1538 y-1539)
  `(py-imul-strX-strY-fallback ,x-1538 ,y-1539))

(define-macro (py-imul-strX-sintY-inline x-1541 y-1542)
  `(py-imul-strX-sintY-fallback ,x-1541 ,y-1542))

(define-macro (py-imul-strX-bintY-inline x-1544 y-1545)
  `(py-imul-strX-bintY-fallback ,x-1544 ,y-1545))

(define-macro (py-imul-sintX-floatY-inline x-1547 y-1548)
  `(let ((x-1547 ,x-1547) (y-1548 ,y-1548))
     (py-float-from-scheme
      (py* (py-sint-to-scheme x-1547) (py-float-to-scheme y-1548)))))

(define-macro (py-imul-sintX-boolY-inline x-1550 y-1551)
  `(py-imul-sintX-boolY-fallback ,x-1550 ,y-1551))

(define-macro (py-imul-sintX-strY-inline x-1553 y-1554)
  `(py-imul-sintX-strY-fallback ,x-1553 ,y-1554))

(define-macro (py-imul-sintX-sintY-inline x-1556 y-1557)
  `(let ((x-1556 ,x-1556) (y-1557 ,y-1557))
     (py-int-from-scheme
      (py* (py-sint-to-scheme x-1556) (py-sint-to-scheme y-1557)))))

(define-macro (py-imul-sintX-bintY-inline x-1559 y-1560)
  `(py-imul-sintX-bintY-fallback ,x-1559 ,y-1560))

(define-macro (py-imul-bintX-floatY-inline x-1562 y-1563)
  `(py-imul-bintX-floatY-fallback ,x-1562 ,y-1563))

(define-macro (py-imul-bintX-boolY-inline x-1565 y-1566)
  `(py-imul-bintX-boolY-fallback ,x-1565 ,y-1566))

(define-macro (py-imul-bintX-strY-inline x-1568 y-1569)
  `(py-imul-bintX-strY-fallback ,x-1568 ,y-1569))

(define-macro (py-imul-bintX-sintY-inline x-1571 y-1572)
  `(py-imul-bintX-sintY-fallback ,x-1571 ,y-1572))

(define-macro (py-imul-bintX-bintY-inline x-1574 y-1575)
  `(py-imul-bintX-bintY-fallback ,x-1574 ,y-1575))

(define-macro (py-ipow-floatX-floatY-inline x-1577 y-1578)
  `(let ((x-1577 ,x-1577) (y-1578 ,y-1578))
     (py-float-from-scheme
      (py** (py-float-to-scheme x-1577) (py-float-to-scheme y-1578)))))

(define-macro (py-ipow-floatX-boolY-inline x-1580 y-1581)
  `(py-ipow-floatX-boolY-fallback ,x-1580 ,y-1581))

(define-macro (py-ipow-floatX-strY-inline x-1583 y-1584)
  `(py-ipow-floatX-strY-fallback ,x-1583 ,y-1584))

(define-macro (py-ipow-floatX-sintY-inline x-1586 y-1587)
  `(let ((x-1586 ,x-1586) (y-1587 ,y-1587))
     (py-float-from-scheme
      (py** (py-float-to-scheme x-1586) (py-sint-to-scheme y-1587)))))

(define-macro (py-ipow-floatX-bintY-inline x-1589 y-1590)
  `(py-ipow-floatX-bintY-fallback ,x-1589 ,y-1590))

(define-macro (py-ipow-boolX-floatY-inline x-1592 y-1593)
  `(py-ipow-boolX-floatY-fallback ,x-1592 ,y-1593))

(define-macro (py-ipow-boolX-boolY-inline x-1595 y-1596)
  `(py-ipow-boolX-boolY-fallback ,x-1595 ,y-1596))

(define-macro (py-ipow-boolX-strY-inline x-1598 y-1599)
  `(py-ipow-boolX-strY-fallback ,x-1598 ,y-1599))

(define-macro (py-ipow-boolX-sintY-inline x-1601 y-1602)
  `(py-ipow-boolX-sintY-fallback ,x-1601 ,y-1602))

(define-macro (py-ipow-boolX-bintY-inline x-1604 y-1605)
  `(py-ipow-boolX-bintY-fallback ,x-1604 ,y-1605))

(define-macro (py-ipow-strX-floatY-inline x-1607 y-1608)
  `(py-ipow-strX-floatY-fallback ,x-1607 ,y-1608))

(define-macro (py-ipow-strX-boolY-inline x-1610 y-1611)
  `(py-ipow-strX-boolY-fallback ,x-1610 ,y-1611))

(define-macro (py-ipow-strX-strY-inline x-1613 y-1614)
  `(py-ipow-strX-strY-fallback ,x-1613 ,y-1614))

(define-macro (py-ipow-strX-sintY-inline x-1616 y-1617)
  `(py-ipow-strX-sintY-fallback ,x-1616 ,y-1617))

(define-macro (py-ipow-strX-bintY-inline x-1619 y-1620)
  `(py-ipow-strX-bintY-fallback ,x-1619 ,y-1620))

(define-macro (py-ipow-sintX-floatY-inline x-1622 y-1623)
  `(let ((x-1622 ,x-1622) (y-1623 ,y-1623))
     (py-float-from-scheme
      (py** (py-sint-to-scheme x-1622) (py-float-to-scheme y-1623)))))

(define-macro (py-ipow-sintX-boolY-inline x-1625 y-1626)
  `(py-ipow-sintX-boolY-fallback ,x-1625 ,y-1626))

(define-macro (py-ipow-sintX-strY-inline x-1628 y-1629)
  `(py-ipow-sintX-strY-fallback ,x-1628 ,y-1629))

(define-macro (py-ipow-sintX-sintY-inline x-1631 y-1632)
  `(let ((x-1631 ,x-1631) (y-1632 ,y-1632))
     (py-int-from-scheme
      (py** (py-sint-to-scheme x-1631) (py-sint-to-scheme y-1632)))))

(define-macro (py-ipow-sintX-bintY-inline x-1634 y-1635)
  `(py-ipow-sintX-bintY-fallback ,x-1634 ,y-1635))

(define-macro (py-ipow-bintX-floatY-inline x-1637 y-1638)
  `(py-ipow-bintX-floatY-fallback ,x-1637 ,y-1638))

(define-macro (py-ipow-bintX-boolY-inline x-1640 y-1641)
  `(py-ipow-bintX-boolY-fallback ,x-1640 ,y-1641))

(define-macro (py-ipow-bintX-strY-inline x-1643 y-1644)
  `(py-ipow-bintX-strY-fallback ,x-1643 ,y-1644))

(define-macro (py-ipow-bintX-sintY-inline x-1646 y-1647)
  `(py-ipow-bintX-sintY-fallback ,x-1646 ,y-1647))

(define-macro (py-ipow-bintX-bintY-inline x-1649 y-1650)
  `(py-ipow-bintX-bintY-fallback ,x-1649 ,y-1650))

(define-macro (py-irshift-floatX-floatY-inline x-1652 y-1653)
  `(let ((x-1652 ,x-1652) (y-1653 ,y-1653))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for >>=: 'float' and 'float'")))))

(define-macro (py-irshift-floatX-boolY-inline x-1655 y-1656)
  `(py-irshift-floatX-boolY-fallback ,x-1655 ,y-1656))

(define-macro (py-irshift-floatX-strY-inline x-1658 y-1659)
  `(py-irshift-floatX-strY-fallback ,x-1658 ,y-1659))

(define-macro (py-irshift-floatX-sintY-inline x-1661 y-1662)
  `(let ((x-1661 ,x-1661) (y-1662 ,y-1662))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for >>=: 'float' and 'int'")))))

(define-macro (py-irshift-floatX-bintY-inline x-1664 y-1665)
  `(py-irshift-floatX-bintY-fallback ,x-1664 ,y-1665))

(define-macro (py-irshift-boolX-floatY-inline x-1667 y-1668)
  `(py-irshift-boolX-floatY-fallback ,x-1667 ,y-1668))

(define-macro (py-irshift-boolX-boolY-inline x-1670 y-1671)
  `(py-irshift-boolX-boolY-fallback ,x-1670 ,y-1671))

(define-macro (py-irshift-boolX-strY-inline x-1673 y-1674)
  `(py-irshift-boolX-strY-fallback ,x-1673 ,y-1674))

(define-macro (py-irshift-boolX-sintY-inline x-1676 y-1677)
  `(py-irshift-boolX-sintY-fallback ,x-1676 ,y-1677))

(define-macro (py-irshift-boolX-bintY-inline x-1679 y-1680)
  `(py-irshift-boolX-bintY-fallback ,x-1679 ,y-1680))

(define-macro (py-irshift-strX-floatY-inline x-1682 y-1683)
  `(py-irshift-strX-floatY-fallback ,x-1682 ,y-1683))

(define-macro (py-irshift-strX-boolY-inline x-1685 y-1686)
  `(py-irshift-strX-boolY-fallback ,x-1685 ,y-1686))

(define-macro (py-irshift-strX-strY-inline x-1688 y-1689)
  `(py-irshift-strX-strY-fallback ,x-1688 ,y-1689))

(define-macro (py-irshift-strX-sintY-inline x-1691 y-1692)
  `(py-irshift-strX-sintY-fallback ,x-1691 ,y-1692))

(define-macro (py-irshift-strX-bintY-inline x-1694 y-1695)
  `(py-irshift-strX-bintY-fallback ,x-1694 ,y-1695))

(define-macro (py-irshift-sintX-floatY-inline x-1697 y-1698)
  `(let ((x-1697 ,x-1697) (y-1698 ,y-1698))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for >>=: 'int' and 'float'")))))

(define-macro (py-irshift-sintX-boolY-inline x-1700 y-1701)
  `(py-irshift-sintX-boolY-fallback ,x-1700 ,y-1701))

(define-macro (py-irshift-sintX-strY-inline x-1703 y-1704)
  `(py-irshift-sintX-strY-fallback ,x-1703 ,y-1704))

(define-macro (py-irshift-sintX-sintY-inline x-1706 y-1707)
  `(let ((x-1706 ,x-1706) (y-1707 ,y-1707))
     (if (py-test (py-ge y-1707 (py-int-from-scheme 0)))
         (py-int-from-scheme
          (py>> (py-sint-to-scheme x-1706) (py-sint-to-scheme y-1707)))
         (py-throw
          (py-call py-builtin-ValueError (&& "negative shift count"))))))

(define-macro (py-irshift-sintX-bintY-inline x-1709 y-1710)
  `(py-irshift-sintX-bintY-fallback ,x-1709 ,y-1710))

(define-macro (py-irshift-bintX-floatY-inline x-1712 y-1713)
  `(py-irshift-bintX-floatY-fallback ,x-1712 ,y-1713))

(define-macro (py-irshift-bintX-boolY-inline x-1715 y-1716)
  `(py-irshift-bintX-boolY-fallback ,x-1715 ,y-1716))

(define-macro (py-irshift-bintX-strY-inline x-1718 y-1719)
  `(py-irshift-bintX-strY-fallback ,x-1718 ,y-1719))

(define-macro (py-irshift-bintX-sintY-inline x-1721 y-1722)
  `(py-irshift-bintX-sintY-fallback ,x-1721 ,y-1722))

(define-macro (py-irshift-bintX-bintY-inline x-1724 y-1725)
  `(py-irshift-bintX-bintY-fallback ,x-1724 ,y-1725))

(define-macro (py-isub-floatX-floatY-inline x-1727 y-1728)
  `(let ((x-1727 ,x-1727) (y-1728 ,y-1728))
     (py-float-from-scheme
      (py- (py-float-to-scheme x-1727) (py-float-to-scheme y-1728)))))

(define-macro (py-isub-floatX-boolY-inline x-1730 y-1731)
  `(py-isub-floatX-boolY-fallback ,x-1730 ,y-1731))

(define-macro (py-isub-floatX-strY-inline x-1733 y-1734)
  `(py-isub-floatX-strY-fallback ,x-1733 ,y-1734))

(define-macro (py-isub-floatX-sintY-inline x-1736 y-1737)
  `(let ((x-1736 ,x-1736) (y-1737 ,y-1737))
     (py-float-from-scheme
      (py- (py-float-to-scheme x-1736) (py-sint-to-scheme y-1737)))))

(define-macro (py-isub-floatX-bintY-inline x-1739 y-1740)
  `(py-isub-floatX-bintY-fallback ,x-1739 ,y-1740))

(define-macro (py-isub-boolX-floatY-inline x-1742 y-1743)
  `(py-isub-boolX-floatY-fallback ,x-1742 ,y-1743))

(define-macro (py-isub-boolX-boolY-inline x-1745 y-1746)
  `(py-isub-boolX-boolY-fallback ,x-1745 ,y-1746))

(define-macro (py-isub-boolX-strY-inline x-1748 y-1749)
  `(py-isub-boolX-strY-fallback ,x-1748 ,y-1749))

(define-macro (py-isub-boolX-sintY-inline x-1751 y-1752)
  `(py-isub-boolX-sintY-fallback ,x-1751 ,y-1752))

(define-macro (py-isub-boolX-bintY-inline x-1754 y-1755)
  `(py-isub-boolX-bintY-fallback ,x-1754 ,y-1755))

(define-macro (py-isub-strX-floatY-inline x-1757 y-1758)
  `(py-isub-strX-floatY-fallback ,x-1757 ,y-1758))

(define-macro (py-isub-strX-boolY-inline x-1760 y-1761)
  `(py-isub-strX-boolY-fallback ,x-1760 ,y-1761))

(define-macro (py-isub-strX-strY-inline x-1763 y-1764)
  `(py-isub-strX-strY-fallback ,x-1763 ,y-1764))

(define-macro (py-isub-strX-sintY-inline x-1766 y-1767)
  `(py-isub-strX-sintY-fallback ,x-1766 ,y-1767))

(define-macro (py-isub-strX-bintY-inline x-1769 y-1770)
  `(py-isub-strX-bintY-fallback ,x-1769 ,y-1770))

(define-macro (py-isub-sintX-floatY-inline x-1772 y-1773)
  `(let ((x-1772 ,x-1772) (y-1773 ,y-1773))
     (py-float-from-scheme
      (py- (py-sint-to-scheme x-1772) (py-float-to-scheme y-1773)))))

(define-macro (py-isub-sintX-boolY-inline x-1775 y-1776)
  `(py-isub-sintX-boolY-fallback ,x-1775 ,y-1776))

(define-macro (py-isub-sintX-strY-inline x-1778 y-1779)
  `(py-isub-sintX-strY-fallback ,x-1778 ,y-1779))

(define-macro (py-isub-sintX-sintY-inline x-1781 y-1782)
  `(let ((x-1781 ,x-1781) (y-1782 ,y-1782))
     (py-int-from-scheme
      (py- (py-sint-to-scheme x-1781) (py-sint-to-scheme y-1782)))))

(define-macro (py-isub-sintX-bintY-inline x-1784 y-1785)
  `(py-isub-sintX-bintY-fallback ,x-1784 ,y-1785))

(define-macro (py-isub-bintX-floatY-inline x-1787 y-1788)
  `(py-isub-bintX-floatY-fallback ,x-1787 ,y-1788))

(define-macro (py-isub-bintX-boolY-inline x-1790 y-1791)
  `(py-isub-bintX-boolY-fallback ,x-1790 ,y-1791))

(define-macro (py-isub-bintX-strY-inline x-1793 y-1794)
  `(py-isub-bintX-strY-fallback ,x-1793 ,y-1794))

(define-macro (py-isub-bintX-sintY-inline x-1796 y-1797)
  `(py-isub-bintX-sintY-fallback ,x-1796 ,y-1797))

(define-macro (py-isub-bintX-bintY-inline x-1799 y-1800)
  `(py-isub-bintX-bintY-fallback ,x-1799 ,y-1800))

(define-macro (py-itruediv-floatX-floatY-inline x-1802 y-1803)
  `(let ((x-1802 ,x-1802) (y-1803 ,y-1803))
     (if (py-test (py-ne y-1803 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py/ (py-float-to-scheme x-1802) (py-float-to-scheme y-1803)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-itruediv-floatX-boolY-inline x-1805 y-1806)
  `(py-itruediv-floatX-boolY-fallback ,x-1805 ,y-1806))

(define-macro (py-itruediv-floatX-strY-inline x-1808 y-1809)
  `(py-itruediv-floatX-strY-fallback ,x-1808 ,y-1809))

(define-macro (py-itruediv-floatX-sintY-inline x-1811 y-1812)
  `(let ((x-1811 ,x-1811) (y-1812 ,y-1812))
     (if (py-test (py-ne y-1812 (py-int-from-scheme 0)))
         (py-float-from-scheme
          (py/ (py-float-to-scheme x-1811) (py-sint-to-scheme y-1812)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-itruediv-floatX-bintY-inline x-1814 y-1815)
  `(py-itruediv-floatX-bintY-fallback ,x-1814 ,y-1815))

(define-macro (py-itruediv-boolX-floatY-inline x-1817 y-1818)
  `(py-itruediv-boolX-floatY-fallback ,x-1817 ,y-1818))

(define-macro (py-itruediv-boolX-boolY-inline x-1820 y-1821)
  `(py-itruediv-boolX-boolY-fallback ,x-1820 ,y-1821))

(define-macro (py-itruediv-boolX-strY-inline x-1823 y-1824)
  `(py-itruediv-boolX-strY-fallback ,x-1823 ,y-1824))

(define-macro (py-itruediv-boolX-sintY-inline x-1826 y-1827)
  `(py-itruediv-boolX-sintY-fallback ,x-1826 ,y-1827))

(define-macro (py-itruediv-boolX-bintY-inline x-1829 y-1830)
  `(py-itruediv-boolX-bintY-fallback ,x-1829 ,y-1830))

(define-macro (py-itruediv-strX-floatY-inline x-1832 y-1833)
  `(py-itruediv-strX-floatY-fallback ,x-1832 ,y-1833))

(define-macro (py-itruediv-strX-boolY-inline x-1835 y-1836)
  `(py-itruediv-strX-boolY-fallback ,x-1835 ,y-1836))

(define-macro (py-itruediv-strX-strY-inline x-1838 y-1839)
  `(py-itruediv-strX-strY-fallback ,x-1838 ,y-1839))

(define-macro (py-itruediv-strX-sintY-inline x-1841 y-1842)
  `(py-itruediv-strX-sintY-fallback ,x-1841 ,y-1842))

(define-macro (py-itruediv-strX-bintY-inline x-1844 y-1845)
  `(py-itruediv-strX-bintY-fallback ,x-1844 ,y-1845))

(define-macro (py-itruediv-sintX-floatY-inline x-1847 y-1848)
  `(let ((x-1847 ,x-1847) (y-1848 ,y-1848))
     (if (py-test (py-ne y-1848 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py/ (py-sint-to-scheme x-1847) (py-float-to-scheme y-1848)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-itruediv-sintX-boolY-inline x-1850 y-1851)
  `(py-itruediv-sintX-boolY-fallback ,x-1850 ,y-1851))

(define-macro (py-itruediv-sintX-strY-inline x-1853 y-1854)
  `(py-itruediv-sintX-strY-fallback ,x-1853 ,y-1854))

(define-macro (py-itruediv-sintX-sintY-inline x-1856 y-1857)
  `(let ((x-1856 ,x-1856) (y-1857 ,y-1857))
     (if (py-test (py-ne y-1857 (py-int-from-scheme 0)))
         (py-float-from-scheme
          (py/ (py-sint-to-scheme x-1856) (py-sint-to-scheme y-1857)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError (&& "division by zero"))))))

(define-macro (py-itruediv-sintX-bintY-inline x-1859 y-1860)
  `(py-itruediv-sintX-bintY-fallback ,x-1859 ,y-1860))

(define-macro (py-itruediv-bintX-floatY-inline x-1862 y-1863)
  `(py-itruediv-bintX-floatY-fallback ,x-1862 ,y-1863))

(define-macro (py-itruediv-bintX-boolY-inline x-1865 y-1866)
  `(py-itruediv-bintX-boolY-fallback ,x-1865 ,y-1866))

(define-macro (py-itruediv-bintX-strY-inline x-1868 y-1869)
  `(py-itruediv-bintX-strY-fallback ,x-1868 ,y-1869))

(define-macro (py-itruediv-bintX-sintY-inline x-1871 y-1872)
  `(py-itruediv-bintX-sintY-fallback ,x-1871 ,y-1872))

(define-macro (py-itruediv-bintX-bintY-inline x-1874 y-1875)
  `(py-itruediv-bintX-bintY-fallback ,x-1874 ,y-1875))

(define-macro (py-ixor-floatX-floatY-inline x-1877 y-1878)
  `(let ((x-1877 ,x-1877) (y-1878 ,y-1878))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for ^=: 'float' and 'float'")))))

(define-macro (py-ixor-floatX-boolY-inline x-1880 y-1881)
  `(py-ixor-floatX-boolY-fallback ,x-1880 ,y-1881))

(define-macro (py-ixor-floatX-strY-inline x-1883 y-1884)
  `(py-ixor-floatX-strY-fallback ,x-1883 ,y-1884))

(define-macro (py-ixor-floatX-sintY-inline x-1886 y-1887)
  `(let ((x-1886 ,x-1886) (y-1887 ,y-1887))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for ^=: 'float' and 'int'")))))

(define-macro (py-ixor-floatX-bintY-inline x-1889 y-1890)
  `(py-ixor-floatX-bintY-fallback ,x-1889 ,y-1890))

(define-macro (py-ixor-boolX-floatY-inline x-1892 y-1893)
  `(py-ixor-boolX-floatY-fallback ,x-1892 ,y-1893))

(define-macro (py-ixor-boolX-boolY-inline x-1895 y-1896)
  `(py-ixor-boolX-boolY-fallback ,x-1895 ,y-1896))

(define-macro (py-ixor-boolX-strY-inline x-1898 y-1899)
  `(py-ixor-boolX-strY-fallback ,x-1898 ,y-1899))

(define-macro (py-ixor-boolX-sintY-inline x-1901 y-1902)
  `(py-ixor-boolX-sintY-fallback ,x-1901 ,y-1902))

(define-macro (py-ixor-boolX-bintY-inline x-1904 y-1905)
  `(py-ixor-boolX-bintY-fallback ,x-1904 ,y-1905))

(define-macro (py-ixor-strX-floatY-inline x-1907 y-1908)
  `(py-ixor-strX-floatY-fallback ,x-1907 ,y-1908))

(define-macro (py-ixor-strX-boolY-inline x-1910 y-1911)
  `(py-ixor-strX-boolY-fallback ,x-1910 ,y-1911))

(define-macro (py-ixor-strX-strY-inline x-1913 y-1914)
  `(py-ixor-strX-strY-fallback ,x-1913 ,y-1914))

(define-macro (py-ixor-strX-sintY-inline x-1916 y-1917)
  `(py-ixor-strX-sintY-fallback ,x-1916 ,y-1917))

(define-macro (py-ixor-strX-bintY-inline x-1919 y-1920)
  `(py-ixor-strX-bintY-fallback ,x-1919 ,y-1920))

(define-macro (py-ixor-sintX-floatY-inline x-1922 y-1923)
  `(let ((x-1922 ,x-1922) (y-1923 ,y-1923))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for ^=: 'int' and 'float'")))))

(define-macro (py-ixor-sintX-boolY-inline x-1925 y-1926)
  `(py-ixor-sintX-boolY-fallback ,x-1925 ,y-1926))

(define-macro (py-ixor-sintX-strY-inline x-1928 y-1929)
  `(py-ixor-sintX-strY-fallback ,x-1928 ,y-1929))

(define-macro (py-ixor-sintX-sintY-inline x-1931 y-1932)
  `(let ((x-1931 ,x-1931) (y-1932 ,y-1932))
     (py-int-from-scheme
      (py^ (py-sint-to-scheme x-1931) (py-sint-to-scheme y-1932)))))

(define-macro (py-ixor-sintX-bintY-inline x-1934 y-1935)
  `(py-ixor-sintX-bintY-fallback ,x-1934 ,y-1935))

(define-macro (py-ixor-bintX-floatY-inline x-1937 y-1938)
  `(py-ixor-bintX-floatY-fallback ,x-1937 ,y-1938))

(define-macro (py-ixor-bintX-boolY-inline x-1940 y-1941)
  `(py-ixor-bintX-boolY-fallback ,x-1940 ,y-1941))

(define-macro (py-ixor-bintX-strY-inline x-1943 y-1944)
  `(py-ixor-bintX-strY-fallback ,x-1943 ,y-1944))

(define-macro (py-ixor-bintX-sintY-inline x-1946 y-1947)
  `(py-ixor-bintX-sintY-fallback ,x-1946 ,y-1947))

(define-macro (py-ixor-bintX-bintY-inline x-1949 y-1950)
  `(py-ixor-bintX-bintY-fallback ,x-1949 ,y-1950))

(define-macro (py-ge-floatX-floatY-inline x-1952 y-1953)
  `(let ((x-1952 ,x-1952) (y-1953 ,y-1953))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py>= (py-float-to-scheme x-1952) (py-float-to-scheme y-1953))))))

(define-macro (py-test-ge-floatX-floatY-inline x-1955 y-1956)
  `(let ((x-1955 ,x-1955) (y-1956 ,y-1956))
     (py-test-from-scheme
      (py>= (py-float-to-scheme x-1955) (py-float-to-scheme y-1956)))))

(define-macro (py-ge-floatX-boolY-inline x-1958 y-1959)
  `(py-ge-floatX-boolY-fallback ,x-1958 ,y-1959))

(define-macro (py-test-ge-floatX-boolY-inline x-1961 y-1962)
  `(py-test-ge-floatX-boolY-fallback ,x-1961 ,y-1962))

(define-macro (py-ge-floatX-strY-inline x-1964 y-1965)
  `(py-ge-floatX-strY-fallback ,x-1964 ,y-1965))

(define-macro (py-test-ge-floatX-strY-inline x-1967 y-1968)
  `(py-test-ge-floatX-strY-fallback ,x-1967 ,y-1968))

(define-macro (py-ge-floatX-sintY-inline x-1970 y-1971)
  `(let ((x-1970 ,x-1970) (y-1971 ,y-1971))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py>= (py-float-to-scheme x-1970) (py-sint-to-scheme y-1971))))))

(define-macro (py-test-ge-floatX-sintY-inline x-1973 y-1974)
  `(let ((x-1973 ,x-1973) (y-1974 ,y-1974))
     (py-test-from-scheme
      (py>= (py-float-to-scheme x-1973) (py-sint-to-scheme y-1974)))))

(define-macro (py-ge-floatX-bintY-inline x-1976 y-1977)
  `(py-ge-floatX-bintY-fallback ,x-1976 ,y-1977))

(define-macro (py-test-ge-floatX-bintY-inline x-1979 y-1980)
  `(py-test-ge-floatX-bintY-fallback ,x-1979 ,y-1980))

(define-macro (py-ge-boolX-floatY-inline x-1982 y-1983)
  `(py-ge-boolX-floatY-fallback ,x-1982 ,y-1983))

(define-macro (py-test-ge-boolX-floatY-inline x-1985 y-1986)
  `(py-test-ge-boolX-floatY-fallback ,x-1985 ,y-1986))

(define-macro (py-ge-boolX-boolY-inline x-1988 y-1989)
  `(py-ge-boolX-boolY-fallback ,x-1988 ,y-1989))

(define-macro (py-test-ge-boolX-boolY-inline x-1991 y-1992)
  `(py-test-ge-boolX-boolY-fallback ,x-1991 ,y-1992))

(define-macro (py-ge-boolX-strY-inline x-1994 y-1995)
  `(py-ge-boolX-strY-fallback ,x-1994 ,y-1995))

(define-macro (py-test-ge-boolX-strY-inline x-1997 y-1998)
  `(py-test-ge-boolX-strY-fallback ,x-1997 ,y-1998))

(define-macro (py-ge-boolX-sintY-inline x-2000 y-2001)
  `(py-ge-boolX-sintY-fallback ,x-2000 ,y-2001))

(define-macro (py-test-ge-boolX-sintY-inline x-2003 y-2004)
  `(py-test-ge-boolX-sintY-fallback ,x-2003 ,y-2004))

(define-macro (py-ge-boolX-bintY-inline x-2006 y-2007)
  `(py-ge-boolX-bintY-fallback ,x-2006 ,y-2007))

(define-macro (py-test-ge-boolX-bintY-inline x-2009 y-2010)
  `(py-test-ge-boolX-bintY-fallback ,x-2009 ,y-2010))

(define-macro (py-ge-strX-floatY-inline x-2012 y-2013)
  `(py-ge-strX-floatY-fallback ,x-2012 ,y-2013))

(define-macro (py-test-ge-strX-floatY-inline x-2015 y-2016)
  `(py-test-ge-strX-floatY-fallback ,x-2015 ,y-2016))

(define-macro (py-ge-strX-boolY-inline x-2018 y-2019)
  `(py-ge-strX-boolY-fallback ,x-2018 ,y-2019))

(define-macro (py-test-ge-strX-boolY-inline x-2021 y-2022)
  `(py-test-ge-strX-boolY-fallback ,x-2021 ,y-2022))

(define-macro (py-ge-strX-strY-inline x-2024 y-2025)
  `(py-ge-strX-strY-fallback ,x-2024 ,y-2025))

(define-macro (py-test-ge-strX-strY-inline x-2027 y-2028)
  `(py-test-ge-strX-strY-fallback ,x-2027 ,y-2028))

(define-macro (py-ge-strX-sintY-inline x-2030 y-2031)
  `(py-ge-strX-sintY-fallback ,x-2030 ,y-2031))

(define-macro (py-test-ge-strX-sintY-inline x-2033 y-2034)
  `(py-test-ge-strX-sintY-fallback ,x-2033 ,y-2034))

(define-macro (py-ge-strX-bintY-inline x-2036 y-2037)
  `(py-ge-strX-bintY-fallback ,x-2036 ,y-2037))

(define-macro (py-test-ge-strX-bintY-inline x-2039 y-2040)
  `(py-test-ge-strX-bintY-fallback ,x-2039 ,y-2040))

(define-macro (py-ge-sintX-floatY-inline x-2042 y-2043)
  `(let ((x-2042 ,x-2042) (y-2043 ,y-2043))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py<= (py-float-to-scheme y-2043) (py-sint-to-scheme x-2042))))))

(define-macro (py-test-ge-sintX-floatY-inline x-2045 y-2046)
  `(let ((x-2045 ,x-2045) (y-2046 ,y-2046))
     (py-test-from-scheme
      (py<= (py-float-to-scheme y-2046) (py-sint-to-scheme x-2045)))))

(define-macro (py-ge-sintX-boolY-inline x-2048 y-2049)
  `(py-ge-sintX-boolY-fallback ,x-2048 ,y-2049))

(define-macro (py-test-ge-sintX-boolY-inline x-2051 y-2052)
  `(py-test-ge-sintX-boolY-fallback ,x-2051 ,y-2052))

(define-macro (py-ge-sintX-strY-inline x-2054 y-2055)
  `(py-ge-sintX-strY-fallback ,x-2054 ,y-2055))

(define-macro (py-test-ge-sintX-strY-inline x-2057 y-2058)
  `(py-test-ge-sintX-strY-fallback ,x-2057 ,y-2058))

(define-macro (py-ge-sintX-sintY-inline x-2060 y-2061)
  `(let ((x-2060 ,x-2060) (y-2061 ,y-2061))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py>= (py-sint-to-scheme x-2060) (py-sint-to-scheme y-2061))))))

(define-macro (py-test-ge-sintX-sintY-inline x-2063 y-2064)
  `(let ((x-2063 ,x-2063) (y-2064 ,y-2064))
     (py-test-from-scheme
      (py>= (py-sint-to-scheme x-2063) (py-sint-to-scheme y-2064)))))

(define-macro (py-ge-sintX-bintY-inline x-2066 y-2067)
  `(py-ge-sintX-bintY-fallback ,x-2066 ,y-2067))

(define-macro (py-test-ge-sintX-bintY-inline x-2069 y-2070)
  `(py-test-ge-sintX-bintY-fallback ,x-2069 ,y-2070))

(define-macro (py-ge-bintX-floatY-inline x-2072 y-2073)
  `(py-ge-bintX-floatY-fallback ,x-2072 ,y-2073))

(define-macro (py-test-ge-bintX-floatY-inline x-2075 y-2076)
  `(py-test-ge-bintX-floatY-fallback ,x-2075 ,y-2076))

(define-macro (py-ge-bintX-boolY-inline x-2078 y-2079)
  `(py-ge-bintX-boolY-fallback ,x-2078 ,y-2079))

(define-macro (py-test-ge-bintX-boolY-inline x-2081 y-2082)
  `(py-test-ge-bintX-boolY-fallback ,x-2081 ,y-2082))

(define-macro (py-ge-bintX-strY-inline x-2084 y-2085)
  `(py-ge-bintX-strY-fallback ,x-2084 ,y-2085))

(define-macro (py-test-ge-bintX-strY-inline x-2087 y-2088)
  `(py-test-ge-bintX-strY-fallback ,x-2087 ,y-2088))

(define-macro (py-ge-bintX-sintY-inline x-2090 y-2091)
  `(py-ge-bintX-sintY-fallback ,x-2090 ,y-2091))

(define-macro (py-test-ge-bintX-sintY-inline x-2093 y-2094)
  `(py-test-ge-bintX-sintY-fallback ,x-2093 ,y-2094))

(define-macro (py-ge-bintX-bintY-inline x-2096 y-2097)
  `(py-ge-bintX-bintY-fallback ,x-2096 ,y-2097))

(define-macro (py-test-ge-bintX-bintY-inline x-2099 y-2100)
  `(py-test-ge-bintX-bintY-fallback ,x-2099 ,y-2100))

(define-macro (py-gt-floatX-floatY-inline x-2102 y-2103)
  `(let ((x-2102 ,x-2102) (y-2103 ,y-2103))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py> (py-float-to-scheme x-2102) (py-float-to-scheme y-2103))))))

(define-macro (py-test-gt-floatX-floatY-inline x-2105 y-2106)
  `(let ((x-2105 ,x-2105) (y-2106 ,y-2106))
     (py-test-from-scheme
      (py> (py-float-to-scheme x-2105) (py-float-to-scheme y-2106)))))

(define-macro (py-gt-floatX-boolY-inline x-2108 y-2109)
  `(py-gt-floatX-boolY-fallback ,x-2108 ,y-2109))

(define-macro (py-test-gt-floatX-boolY-inline x-2111 y-2112)
  `(py-test-gt-floatX-boolY-fallback ,x-2111 ,y-2112))

(define-macro (py-gt-floatX-strY-inline x-2114 y-2115)
  `(py-gt-floatX-strY-fallback ,x-2114 ,y-2115))

(define-macro (py-test-gt-floatX-strY-inline x-2117 y-2118)
  `(py-test-gt-floatX-strY-fallback ,x-2117 ,y-2118))

(define-macro (py-gt-floatX-sintY-inline x-2120 y-2121)
  `(let ((x-2120 ,x-2120) (y-2121 ,y-2121))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py> (py-float-to-scheme x-2120) (py-sint-to-scheme y-2121))))))

(define-macro (py-test-gt-floatX-sintY-inline x-2123 y-2124)
  `(let ((x-2123 ,x-2123) (y-2124 ,y-2124))
     (py-test-from-scheme
      (py> (py-float-to-scheme x-2123) (py-sint-to-scheme y-2124)))))

(define-macro (py-gt-floatX-bintY-inline x-2126 y-2127)
  `(py-gt-floatX-bintY-fallback ,x-2126 ,y-2127))

(define-macro (py-test-gt-floatX-bintY-inline x-2129 y-2130)
  `(py-test-gt-floatX-bintY-fallback ,x-2129 ,y-2130))

(define-macro (py-gt-boolX-floatY-inline x-2132 y-2133)
  `(py-gt-boolX-floatY-fallback ,x-2132 ,y-2133))

(define-macro (py-test-gt-boolX-floatY-inline x-2135 y-2136)
  `(py-test-gt-boolX-floatY-fallback ,x-2135 ,y-2136))

(define-macro (py-gt-boolX-boolY-inline x-2138 y-2139)
  `(py-gt-boolX-boolY-fallback ,x-2138 ,y-2139))

(define-macro (py-test-gt-boolX-boolY-inline x-2141 y-2142)
  `(py-test-gt-boolX-boolY-fallback ,x-2141 ,y-2142))

(define-macro (py-gt-boolX-strY-inline x-2144 y-2145)
  `(py-gt-boolX-strY-fallback ,x-2144 ,y-2145))

(define-macro (py-test-gt-boolX-strY-inline x-2147 y-2148)
  `(py-test-gt-boolX-strY-fallback ,x-2147 ,y-2148))

(define-macro (py-gt-boolX-sintY-inline x-2150 y-2151)
  `(py-gt-boolX-sintY-fallback ,x-2150 ,y-2151))

(define-macro (py-test-gt-boolX-sintY-inline x-2153 y-2154)
  `(py-test-gt-boolX-sintY-fallback ,x-2153 ,y-2154))

(define-macro (py-gt-boolX-bintY-inline x-2156 y-2157)
  `(py-gt-boolX-bintY-fallback ,x-2156 ,y-2157))

(define-macro (py-test-gt-boolX-bintY-inline x-2159 y-2160)
  `(py-test-gt-boolX-bintY-fallback ,x-2159 ,y-2160))

(define-macro (py-gt-strX-floatY-inline x-2162 y-2163)
  `(py-gt-strX-floatY-fallback ,x-2162 ,y-2163))

(define-macro (py-test-gt-strX-floatY-inline x-2165 y-2166)
  `(py-test-gt-strX-floatY-fallback ,x-2165 ,y-2166))

(define-macro (py-gt-strX-boolY-inline x-2168 y-2169)
  `(py-gt-strX-boolY-fallback ,x-2168 ,y-2169))

(define-macro (py-test-gt-strX-boolY-inline x-2171 y-2172)
  `(py-test-gt-strX-boolY-fallback ,x-2171 ,y-2172))

(define-macro (py-gt-strX-strY-inline x-2174 y-2175)
  `(py-gt-strX-strY-fallback ,x-2174 ,y-2175))

(define-macro (py-test-gt-strX-strY-inline x-2177 y-2178)
  `(py-test-gt-strX-strY-fallback ,x-2177 ,y-2178))

(define-macro (py-gt-strX-sintY-inline x-2180 y-2181)
  `(py-gt-strX-sintY-fallback ,x-2180 ,y-2181))

(define-macro (py-test-gt-strX-sintY-inline x-2183 y-2184)
  `(py-test-gt-strX-sintY-fallback ,x-2183 ,y-2184))

(define-macro (py-gt-strX-bintY-inline x-2186 y-2187)
  `(py-gt-strX-bintY-fallback ,x-2186 ,y-2187))

(define-macro (py-test-gt-strX-bintY-inline x-2189 y-2190)
  `(py-test-gt-strX-bintY-fallback ,x-2189 ,y-2190))

(define-macro (py-gt-sintX-floatY-inline x-2192 y-2193)
  `(let ((x-2192 ,x-2192) (y-2193 ,y-2193))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py< (py-float-to-scheme y-2193) (py-sint-to-scheme x-2192))))))

(define-macro (py-test-gt-sintX-floatY-inline x-2195 y-2196)
  `(let ((x-2195 ,x-2195) (y-2196 ,y-2196))
     (py-test-from-scheme
      (py< (py-float-to-scheme y-2196) (py-sint-to-scheme x-2195)))))

(define-macro (py-gt-sintX-boolY-inline x-2198 y-2199)
  `(py-gt-sintX-boolY-fallback ,x-2198 ,y-2199))

(define-macro (py-test-gt-sintX-boolY-inline x-2201 y-2202)
  `(py-test-gt-sintX-boolY-fallback ,x-2201 ,y-2202))

(define-macro (py-gt-sintX-strY-inline x-2204 y-2205)
  `(py-gt-sintX-strY-fallback ,x-2204 ,y-2205))

(define-macro (py-test-gt-sintX-strY-inline x-2207 y-2208)
  `(py-test-gt-sintX-strY-fallback ,x-2207 ,y-2208))

(define-macro (py-gt-sintX-sintY-inline x-2210 y-2211)
  `(let ((x-2210 ,x-2210) (y-2211 ,y-2211))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py> (py-sint-to-scheme x-2210) (py-sint-to-scheme y-2211))))))

(define-macro (py-test-gt-sintX-sintY-inline x-2213 y-2214)
  `(let ((x-2213 ,x-2213) (y-2214 ,y-2214))
     (py-test-from-scheme
      (py> (py-sint-to-scheme x-2213) (py-sint-to-scheme y-2214)))))

(define-macro (py-gt-sintX-bintY-inline x-2216 y-2217)
  `(py-gt-sintX-bintY-fallback ,x-2216 ,y-2217))

(define-macro (py-test-gt-sintX-bintY-inline x-2219 y-2220)
  `(py-test-gt-sintX-bintY-fallback ,x-2219 ,y-2220))

(define-macro (py-gt-bintX-floatY-inline x-2222 y-2223)
  `(py-gt-bintX-floatY-fallback ,x-2222 ,y-2223))

(define-macro (py-test-gt-bintX-floatY-inline x-2225 y-2226)
  `(py-test-gt-bintX-floatY-fallback ,x-2225 ,y-2226))

(define-macro (py-gt-bintX-boolY-inline x-2228 y-2229)
  `(py-gt-bintX-boolY-fallback ,x-2228 ,y-2229))

(define-macro (py-test-gt-bintX-boolY-inline x-2231 y-2232)
  `(py-test-gt-bintX-boolY-fallback ,x-2231 ,y-2232))

(define-macro (py-gt-bintX-strY-inline x-2234 y-2235)
  `(py-gt-bintX-strY-fallback ,x-2234 ,y-2235))

(define-macro (py-test-gt-bintX-strY-inline x-2237 y-2238)
  `(py-test-gt-bintX-strY-fallback ,x-2237 ,y-2238))

(define-macro (py-gt-bintX-sintY-inline x-2240 y-2241)
  `(py-gt-bintX-sintY-fallback ,x-2240 ,y-2241))

(define-macro (py-test-gt-bintX-sintY-inline x-2243 y-2244)
  `(py-test-gt-bintX-sintY-fallback ,x-2243 ,y-2244))

(define-macro (py-gt-bintX-bintY-inline x-2246 y-2247)
  `(py-gt-bintX-bintY-fallback ,x-2246 ,y-2247))

(define-macro (py-test-gt-bintX-bintY-inline x-2249 y-2250)
  `(py-test-gt-bintX-bintY-fallback ,x-2249 ,y-2250))

(define-macro (py-le-floatX-floatY-inline x-2252 y-2253)
  `(let ((x-2252 ,x-2252) (y-2253 ,y-2253))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py<= (py-float-to-scheme x-2252) (py-float-to-scheme y-2253))))))

(define-macro (py-test-le-floatX-floatY-inline x-2255 y-2256)
  `(let ((x-2255 ,x-2255) (y-2256 ,y-2256))
     (py-test-from-scheme
      (py<= (py-float-to-scheme x-2255) (py-float-to-scheme y-2256)))))

(define-macro (py-le-floatX-boolY-inline x-2258 y-2259)
  `(py-le-floatX-boolY-fallback ,x-2258 ,y-2259))

(define-macro (py-test-le-floatX-boolY-inline x-2261 y-2262)
  `(py-test-le-floatX-boolY-fallback ,x-2261 ,y-2262))

(define-macro (py-le-floatX-strY-inline x-2264 y-2265)
  `(py-le-floatX-strY-fallback ,x-2264 ,y-2265))

(define-macro (py-test-le-floatX-strY-inline x-2267 y-2268)
  `(py-test-le-floatX-strY-fallback ,x-2267 ,y-2268))

(define-macro (py-le-floatX-sintY-inline x-2270 y-2271)
  `(let ((x-2270 ,x-2270) (y-2271 ,y-2271))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py<= (py-float-to-scheme x-2270) (py-sint-to-scheme y-2271))))))

(define-macro (py-test-le-floatX-sintY-inline x-2273 y-2274)
  `(let ((x-2273 ,x-2273) (y-2274 ,y-2274))
     (py-test-from-scheme
      (py<= (py-float-to-scheme x-2273) (py-sint-to-scheme y-2274)))))

(define-macro (py-le-floatX-bintY-inline x-2276 y-2277)
  `(py-le-floatX-bintY-fallback ,x-2276 ,y-2277))

(define-macro (py-test-le-floatX-bintY-inline x-2279 y-2280)
  `(py-test-le-floatX-bintY-fallback ,x-2279 ,y-2280))

(define-macro (py-le-boolX-floatY-inline x-2282 y-2283)
  `(py-le-boolX-floatY-fallback ,x-2282 ,y-2283))

(define-macro (py-test-le-boolX-floatY-inline x-2285 y-2286)
  `(py-test-le-boolX-floatY-fallback ,x-2285 ,y-2286))

(define-macro (py-le-boolX-boolY-inline x-2288 y-2289)
  `(py-le-boolX-boolY-fallback ,x-2288 ,y-2289))

(define-macro (py-test-le-boolX-boolY-inline x-2291 y-2292)
  `(py-test-le-boolX-boolY-fallback ,x-2291 ,y-2292))

(define-macro (py-le-boolX-strY-inline x-2294 y-2295)
  `(py-le-boolX-strY-fallback ,x-2294 ,y-2295))

(define-macro (py-test-le-boolX-strY-inline x-2297 y-2298)
  `(py-test-le-boolX-strY-fallback ,x-2297 ,y-2298))

(define-macro (py-le-boolX-sintY-inline x-2300 y-2301)
  `(py-le-boolX-sintY-fallback ,x-2300 ,y-2301))

(define-macro (py-test-le-boolX-sintY-inline x-2303 y-2304)
  `(py-test-le-boolX-sintY-fallback ,x-2303 ,y-2304))

(define-macro (py-le-boolX-bintY-inline x-2306 y-2307)
  `(py-le-boolX-bintY-fallback ,x-2306 ,y-2307))

(define-macro (py-test-le-boolX-bintY-inline x-2309 y-2310)
  `(py-test-le-boolX-bintY-fallback ,x-2309 ,y-2310))

(define-macro (py-le-strX-floatY-inline x-2312 y-2313)
  `(py-le-strX-floatY-fallback ,x-2312 ,y-2313))

(define-macro (py-test-le-strX-floatY-inline x-2315 y-2316)
  `(py-test-le-strX-floatY-fallback ,x-2315 ,y-2316))

(define-macro (py-le-strX-boolY-inline x-2318 y-2319)
  `(py-le-strX-boolY-fallback ,x-2318 ,y-2319))

(define-macro (py-test-le-strX-boolY-inline x-2321 y-2322)
  `(py-test-le-strX-boolY-fallback ,x-2321 ,y-2322))

(define-macro (py-le-strX-strY-inline x-2324 y-2325)
  `(py-le-strX-strY-fallback ,x-2324 ,y-2325))

(define-macro (py-test-le-strX-strY-inline x-2327 y-2328)
  `(py-test-le-strX-strY-fallback ,x-2327 ,y-2328))

(define-macro (py-le-strX-sintY-inline x-2330 y-2331)
  `(py-le-strX-sintY-fallback ,x-2330 ,y-2331))

(define-macro (py-test-le-strX-sintY-inline x-2333 y-2334)
  `(py-test-le-strX-sintY-fallback ,x-2333 ,y-2334))

(define-macro (py-le-strX-bintY-inline x-2336 y-2337)
  `(py-le-strX-bintY-fallback ,x-2336 ,y-2337))

(define-macro (py-test-le-strX-bintY-inline x-2339 y-2340)
  `(py-test-le-strX-bintY-fallback ,x-2339 ,y-2340))

(define-macro (py-le-sintX-floatY-inline x-2342 y-2343)
  `(let ((x-2342 ,x-2342) (y-2343 ,y-2343))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py>= (py-float-to-scheme y-2343) (py-sint-to-scheme x-2342))))))

(define-macro (py-test-le-sintX-floatY-inline x-2345 y-2346)
  `(let ((x-2345 ,x-2345) (y-2346 ,y-2346))
     (py-test-from-scheme
      (py>= (py-float-to-scheme y-2346) (py-sint-to-scheme x-2345)))))

(define-macro (py-le-sintX-boolY-inline x-2348 y-2349)
  `(py-le-sintX-boolY-fallback ,x-2348 ,y-2349))

(define-macro (py-test-le-sintX-boolY-inline x-2351 y-2352)
  `(py-test-le-sintX-boolY-fallback ,x-2351 ,y-2352))

(define-macro (py-le-sintX-strY-inline x-2354 y-2355)
  `(py-le-sintX-strY-fallback ,x-2354 ,y-2355))

(define-macro (py-test-le-sintX-strY-inline x-2357 y-2358)
  `(py-test-le-sintX-strY-fallback ,x-2357 ,y-2358))

(define-macro (py-le-sintX-sintY-inline x-2360 y-2361)
  `(let ((x-2360 ,x-2360) (y-2361 ,y-2361))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py<= (py-sint-to-scheme x-2360) (py-sint-to-scheme y-2361))))))

(define-macro (py-test-le-sintX-sintY-inline x-2363 y-2364)
  `(let ((x-2363 ,x-2363) (y-2364 ,y-2364))
     (py-test-from-scheme
      (py<= (py-sint-to-scheme x-2363) (py-sint-to-scheme y-2364)))))

(define-macro (py-le-sintX-bintY-inline x-2366 y-2367)
  `(py-le-sintX-bintY-fallback ,x-2366 ,y-2367))

(define-macro (py-test-le-sintX-bintY-inline x-2369 y-2370)
  `(py-test-le-sintX-bintY-fallback ,x-2369 ,y-2370))

(define-macro (py-le-bintX-floatY-inline x-2372 y-2373)
  `(py-le-bintX-floatY-fallback ,x-2372 ,y-2373))

(define-macro (py-test-le-bintX-floatY-inline x-2375 y-2376)
  `(py-test-le-bintX-floatY-fallback ,x-2375 ,y-2376))

(define-macro (py-le-bintX-boolY-inline x-2378 y-2379)
  `(py-le-bintX-boolY-fallback ,x-2378 ,y-2379))

(define-macro (py-test-le-bintX-boolY-inline x-2381 y-2382)
  `(py-test-le-bintX-boolY-fallback ,x-2381 ,y-2382))

(define-macro (py-le-bintX-strY-inline x-2384 y-2385)
  `(py-le-bintX-strY-fallback ,x-2384 ,y-2385))

(define-macro (py-test-le-bintX-strY-inline x-2387 y-2388)
  `(py-test-le-bintX-strY-fallback ,x-2387 ,y-2388))

(define-macro (py-le-bintX-sintY-inline x-2390 y-2391)
  `(py-le-bintX-sintY-fallback ,x-2390 ,y-2391))

(define-macro (py-test-le-bintX-sintY-inline x-2393 y-2394)
  `(py-test-le-bintX-sintY-fallback ,x-2393 ,y-2394))

(define-macro (py-le-bintX-bintY-inline x-2396 y-2397)
  `(py-le-bintX-bintY-fallback ,x-2396 ,y-2397))

(define-macro (py-test-le-bintX-bintY-inline x-2399 y-2400)
  `(py-test-le-bintX-bintY-fallback ,x-2399 ,y-2400))

(define-macro (py-lt-floatX-floatY-inline x-2402 y-2403)
  `(let ((x-2402 ,x-2402) (y-2403 ,y-2403))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py< (py-float-to-scheme x-2402) (py-float-to-scheme y-2403))))))

(define-macro (py-test-lt-floatX-floatY-inline x-2405 y-2406)
  `(let ((x-2405 ,x-2405) (y-2406 ,y-2406))
     (py-test-from-scheme
      (py< (py-float-to-scheme x-2405) (py-float-to-scheme y-2406)))))

(define-macro (py-lt-floatX-boolY-inline x-2408 y-2409)
  `(py-lt-floatX-boolY-fallback ,x-2408 ,y-2409))

(define-macro (py-test-lt-floatX-boolY-inline x-2411 y-2412)
  `(py-test-lt-floatX-boolY-fallback ,x-2411 ,y-2412))

(define-macro (py-lt-floatX-strY-inline x-2414 y-2415)
  `(py-lt-floatX-strY-fallback ,x-2414 ,y-2415))

(define-macro (py-test-lt-floatX-strY-inline x-2417 y-2418)
  `(py-test-lt-floatX-strY-fallback ,x-2417 ,y-2418))

(define-macro (py-lt-floatX-sintY-inline x-2420 y-2421)
  `(let ((x-2420 ,x-2420) (y-2421 ,y-2421))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py< (py-float-to-scheme x-2420) (py-sint-to-scheme y-2421))))))

(define-macro (py-test-lt-floatX-sintY-inline x-2423 y-2424)
  `(let ((x-2423 ,x-2423) (y-2424 ,y-2424))
     (py-test-from-scheme
      (py< (py-float-to-scheme x-2423) (py-sint-to-scheme y-2424)))))

(define-macro (py-lt-floatX-bintY-inline x-2426 y-2427)
  `(py-lt-floatX-bintY-fallback ,x-2426 ,y-2427))

(define-macro (py-test-lt-floatX-bintY-inline x-2429 y-2430)
  `(py-test-lt-floatX-bintY-fallback ,x-2429 ,y-2430))

(define-macro (py-lt-boolX-floatY-inline x-2432 y-2433)
  `(py-lt-boolX-floatY-fallback ,x-2432 ,y-2433))

(define-macro (py-test-lt-boolX-floatY-inline x-2435 y-2436)
  `(py-test-lt-boolX-floatY-fallback ,x-2435 ,y-2436))

(define-macro (py-lt-boolX-boolY-inline x-2438 y-2439)
  `(py-lt-boolX-boolY-fallback ,x-2438 ,y-2439))

(define-macro (py-test-lt-boolX-boolY-inline x-2441 y-2442)
  `(py-test-lt-boolX-boolY-fallback ,x-2441 ,y-2442))

(define-macro (py-lt-boolX-strY-inline x-2444 y-2445)
  `(py-lt-boolX-strY-fallback ,x-2444 ,y-2445))

(define-macro (py-test-lt-boolX-strY-inline x-2447 y-2448)
  `(py-test-lt-boolX-strY-fallback ,x-2447 ,y-2448))

(define-macro (py-lt-boolX-sintY-inline x-2450 y-2451)
  `(py-lt-boolX-sintY-fallback ,x-2450 ,y-2451))

(define-macro (py-test-lt-boolX-sintY-inline x-2453 y-2454)
  `(py-test-lt-boolX-sintY-fallback ,x-2453 ,y-2454))

(define-macro (py-lt-boolX-bintY-inline x-2456 y-2457)
  `(py-lt-boolX-bintY-fallback ,x-2456 ,y-2457))

(define-macro (py-test-lt-boolX-bintY-inline x-2459 y-2460)
  `(py-test-lt-boolX-bintY-fallback ,x-2459 ,y-2460))

(define-macro (py-lt-strX-floatY-inline x-2462 y-2463)
  `(py-lt-strX-floatY-fallback ,x-2462 ,y-2463))

(define-macro (py-test-lt-strX-floatY-inline x-2465 y-2466)
  `(py-test-lt-strX-floatY-fallback ,x-2465 ,y-2466))

(define-macro (py-lt-strX-boolY-inline x-2468 y-2469)
  `(py-lt-strX-boolY-fallback ,x-2468 ,y-2469))

(define-macro (py-test-lt-strX-boolY-inline x-2471 y-2472)
  `(py-test-lt-strX-boolY-fallback ,x-2471 ,y-2472))

(define-macro (py-lt-strX-strY-inline x-2474 y-2475)
  `(py-lt-strX-strY-fallback ,x-2474 ,y-2475))

(define-macro (py-test-lt-strX-strY-inline x-2477 y-2478)
  `(py-test-lt-strX-strY-fallback ,x-2477 ,y-2478))

(define-macro (py-lt-strX-sintY-inline x-2480 y-2481)
  `(py-lt-strX-sintY-fallback ,x-2480 ,y-2481))

(define-macro (py-test-lt-strX-sintY-inline x-2483 y-2484)
  `(py-test-lt-strX-sintY-fallback ,x-2483 ,y-2484))

(define-macro (py-lt-strX-bintY-inline x-2486 y-2487)
  `(py-lt-strX-bintY-fallback ,x-2486 ,y-2487))

(define-macro (py-test-lt-strX-bintY-inline x-2489 y-2490)
  `(py-test-lt-strX-bintY-fallback ,x-2489 ,y-2490))

(define-macro (py-lt-sintX-floatY-inline x-2492 y-2493)
  `(let ((x-2492 ,x-2492) (y-2493 ,y-2493))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py> (py-float-to-scheme y-2493) (py-sint-to-scheme x-2492))))))

(define-macro (py-test-lt-sintX-floatY-inline x-2495 y-2496)
  `(let ((x-2495 ,x-2495) (y-2496 ,y-2496))
     (py-test-from-scheme
      (py> (py-float-to-scheme y-2496) (py-sint-to-scheme x-2495)))))

(define-macro (py-lt-sintX-boolY-inline x-2498 y-2499)
  `(py-lt-sintX-boolY-fallback ,x-2498 ,y-2499))

(define-macro (py-test-lt-sintX-boolY-inline x-2501 y-2502)
  `(py-test-lt-sintX-boolY-fallback ,x-2501 ,y-2502))

(define-macro (py-lt-sintX-strY-inline x-2504 y-2505)
  `(py-lt-sintX-strY-fallback ,x-2504 ,y-2505))

(define-macro (py-test-lt-sintX-strY-inline x-2507 y-2508)
  `(py-test-lt-sintX-strY-fallback ,x-2507 ,y-2508))

(define-macro (py-lt-sintX-sintY-inline x-2510 y-2511)
  `(let ((x-2510 ,x-2510) (y-2511 ,y-2511))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py< (py-sint-to-scheme x-2510) (py-sint-to-scheme y-2511))))))

(define-macro (py-test-lt-sintX-sintY-inline x-2513 y-2514)
  `(let ((x-2513 ,x-2513) (y-2514 ,y-2514))
     (py-test-from-scheme
      (py< (py-sint-to-scheme x-2513) (py-sint-to-scheme y-2514)))))

(define-macro (py-lt-sintX-bintY-inline x-2516 y-2517)
  `(py-lt-sintX-bintY-fallback ,x-2516 ,y-2517))

(define-macro (py-test-lt-sintX-bintY-inline x-2519 y-2520)
  `(py-test-lt-sintX-bintY-fallback ,x-2519 ,y-2520))

(define-macro (py-lt-bintX-floatY-inline x-2522 y-2523)
  `(py-lt-bintX-floatY-fallback ,x-2522 ,y-2523))

(define-macro (py-test-lt-bintX-floatY-inline x-2525 y-2526)
  `(py-test-lt-bintX-floatY-fallback ,x-2525 ,y-2526))

(define-macro (py-lt-bintX-boolY-inline x-2528 y-2529)
  `(py-lt-bintX-boolY-fallback ,x-2528 ,y-2529))

(define-macro (py-test-lt-bintX-boolY-inline x-2531 y-2532)
  `(py-test-lt-bintX-boolY-fallback ,x-2531 ,y-2532))

(define-macro (py-lt-bintX-strY-inline x-2534 y-2535)
  `(py-lt-bintX-strY-fallback ,x-2534 ,y-2535))

(define-macro (py-test-lt-bintX-strY-inline x-2537 y-2538)
  `(py-test-lt-bintX-strY-fallback ,x-2537 ,y-2538))

(define-macro (py-lt-bintX-sintY-inline x-2540 y-2541)
  `(py-lt-bintX-sintY-fallback ,x-2540 ,y-2541))

(define-macro (py-test-lt-bintX-sintY-inline x-2543 y-2544)
  `(py-test-lt-bintX-sintY-fallback ,x-2543 ,y-2544))

(define-macro (py-lt-bintX-bintY-inline x-2546 y-2547)
  `(py-lt-bintX-bintY-fallback ,x-2546 ,y-2547))

(define-macro (py-test-lt-bintX-bintY-inline x-2549 y-2550)
  `(py-test-lt-bintX-bintY-fallback ,x-2549 ,y-2550))

(define-macro (py-eq-floatX-floatY-inline x-2552 y-2553)
  `(let ((x-2552 ,x-2552) (y-2553 ,y-2553))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py== (py-float-to-scheme x-2552) (py-float-to-scheme y-2553))))))

(define-macro (py-test-eq-floatX-floatY-inline x-2555 y-2556)
  `(let ((x-2555 ,x-2555) (y-2556 ,y-2556))
     (py-test-from-scheme
      (py== (py-float-to-scheme x-2555) (py-float-to-scheme y-2556)))))

(define-macro (py-eq-floatX-boolY-inline x-2558 y-2559)
  `(py-eq-floatX-boolY-fallback ,x-2558 ,y-2559))

(define-macro (py-test-eq-floatX-boolY-inline x-2561 y-2562)
  `(py-test-eq-floatX-boolY-fallback ,x-2561 ,y-2562))

(define-macro (py-eq-floatX-strY-inline x-2564 y-2565)
  `(py-eq-floatX-strY-fallback ,x-2564 ,y-2565))

(define-macro (py-test-eq-floatX-strY-inline x-2567 y-2568)
  `(py-test-eq-floatX-strY-fallback ,x-2567 ,y-2568))

(define-macro (py-eq-floatX-sintY-inline x-2570 y-2571)
  `(let ((x-2570 ,x-2570) (y-2571 ,y-2571))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py== (py-float-to-scheme x-2570) (py-sint-to-scheme y-2571))))))

(define-macro (py-test-eq-floatX-sintY-inline x-2573 y-2574)
  `(let ((x-2573 ,x-2573) (y-2574 ,y-2574))
     (py-test-from-scheme
      (py== (py-float-to-scheme x-2573) (py-sint-to-scheme y-2574)))))

(define-macro (py-eq-floatX-bintY-inline x-2576 y-2577)
  `(py-eq-floatX-bintY-fallback ,x-2576 ,y-2577))

(define-macro (py-test-eq-floatX-bintY-inline x-2579 y-2580)
  `(py-test-eq-floatX-bintY-fallback ,x-2579 ,y-2580))

(define-macro (py-eq-boolX-floatY-inline x-2582 y-2583)
  `(py-eq-boolX-floatY-fallback ,x-2582 ,y-2583))

(define-macro (py-test-eq-boolX-floatY-inline x-2585 y-2586)
  `(py-test-eq-boolX-floatY-fallback ,x-2585 ,y-2586))

(define-macro (py-eq-boolX-boolY-inline x-2588 y-2589)
  `(py-eq-boolX-boolY-fallback ,x-2588 ,y-2589))

(define-macro (py-test-eq-boolX-boolY-inline x-2591 y-2592)
  `(py-test-eq-boolX-boolY-fallback ,x-2591 ,y-2592))

(define-macro (py-eq-boolX-strY-inline x-2594 y-2595)
  `(py-eq-boolX-strY-fallback ,x-2594 ,y-2595))

(define-macro (py-test-eq-boolX-strY-inline x-2597 y-2598)
  `(py-test-eq-boolX-strY-fallback ,x-2597 ,y-2598))

(define-macro (py-eq-boolX-sintY-inline x-2600 y-2601)
  `(py-eq-boolX-sintY-fallback ,x-2600 ,y-2601))

(define-macro (py-test-eq-boolX-sintY-inline x-2603 y-2604)
  `(py-test-eq-boolX-sintY-fallback ,x-2603 ,y-2604))

(define-macro (py-eq-boolX-bintY-inline x-2606 y-2607)
  `(py-eq-boolX-bintY-fallback ,x-2606 ,y-2607))

(define-macro (py-test-eq-boolX-bintY-inline x-2609 y-2610)
  `(py-test-eq-boolX-bintY-fallback ,x-2609 ,y-2610))

(define-macro (py-eq-strX-floatY-inline x-2612 y-2613)
  `(py-eq-strX-floatY-fallback ,x-2612 ,y-2613))

(define-macro (py-test-eq-strX-floatY-inline x-2615 y-2616)
  `(py-test-eq-strX-floatY-fallback ,x-2615 ,y-2616))

(define-macro (py-eq-strX-boolY-inline x-2618 y-2619)
  `(py-eq-strX-boolY-fallback ,x-2618 ,y-2619))

(define-macro (py-test-eq-strX-boolY-inline x-2621 y-2622)
  `(py-test-eq-strX-boolY-fallback ,x-2621 ,y-2622))

(define-macro (py-eq-strX-strY-inline x-2624 y-2625)
  `(py-eq-strX-strY-fallback ,x-2624 ,y-2625))

(define-macro (py-test-eq-strX-strY-inline x-2627 y-2628)
  `(py-test-eq-strX-strY-fallback ,x-2627 ,y-2628))

(define-macro (py-eq-strX-sintY-inline x-2630 y-2631)
  `(py-eq-strX-sintY-fallback ,x-2630 ,y-2631))

(define-macro (py-test-eq-strX-sintY-inline x-2633 y-2634)
  `(py-test-eq-strX-sintY-fallback ,x-2633 ,y-2634))

(define-macro (py-eq-strX-bintY-inline x-2636 y-2637)
  `(py-eq-strX-bintY-fallback ,x-2636 ,y-2637))

(define-macro (py-test-eq-strX-bintY-inline x-2639 y-2640)
  `(py-test-eq-strX-bintY-fallback ,x-2639 ,y-2640))

(define-macro (py-eq-sintX-floatY-inline x-2642 y-2643)
  `(let ((x-2642 ,x-2642) (y-2643 ,y-2643))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py== (py-float-to-scheme y-2643) (py-sint-to-scheme x-2642))))))

(define-macro (py-test-eq-sintX-floatY-inline x-2645 y-2646)
  `(let ((x-2645 ,x-2645) (y-2646 ,y-2646))
     (py-test-from-scheme
      (py== (py-float-to-scheme y-2646) (py-sint-to-scheme x-2645)))))

(define-macro (py-eq-sintX-boolY-inline x-2648 y-2649)
  `(py-eq-sintX-boolY-fallback ,x-2648 ,y-2649))

(define-macro (py-test-eq-sintX-boolY-inline x-2651 y-2652)
  `(py-test-eq-sintX-boolY-fallback ,x-2651 ,y-2652))

(define-macro (py-eq-sintX-strY-inline x-2654 y-2655)
  `(py-eq-sintX-strY-fallback ,x-2654 ,y-2655))

(define-macro (py-test-eq-sintX-strY-inline x-2657 y-2658)
  `(py-test-eq-sintX-strY-fallback ,x-2657 ,y-2658))

(define-macro (py-eq-sintX-sintY-inline x-2660 y-2661)
  `(let ((x-2660 ,x-2660) (y-2661 ,y-2661))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py== (py-sint-to-scheme x-2660) (py-sint-to-scheme y-2661))))))

(define-macro (py-test-eq-sintX-sintY-inline x-2663 y-2664)
  `(let ((x-2663 ,x-2663) (y-2664 ,y-2664))
     (py-test-from-scheme
      (py== (py-sint-to-scheme x-2663) (py-sint-to-scheme y-2664)))))

(define-macro (py-eq-sintX-bintY-inline x-2666 y-2667)
  `(py-eq-sintX-bintY-fallback ,x-2666 ,y-2667))

(define-macro (py-test-eq-sintX-bintY-inline x-2669 y-2670)
  `(py-test-eq-sintX-bintY-fallback ,x-2669 ,y-2670))

(define-macro (py-eq-bintX-floatY-inline x-2672 y-2673)
  `(py-eq-bintX-floatY-fallback ,x-2672 ,y-2673))

(define-macro (py-test-eq-bintX-floatY-inline x-2675 y-2676)
  `(py-test-eq-bintX-floatY-fallback ,x-2675 ,y-2676))

(define-macro (py-eq-bintX-boolY-inline x-2678 y-2679)
  `(py-eq-bintX-boolY-fallback ,x-2678 ,y-2679))

(define-macro (py-test-eq-bintX-boolY-inline x-2681 y-2682)
  `(py-test-eq-bintX-boolY-fallback ,x-2681 ,y-2682))

(define-macro (py-eq-bintX-strY-inline x-2684 y-2685)
  `(py-eq-bintX-strY-fallback ,x-2684 ,y-2685))

(define-macro (py-test-eq-bintX-strY-inline x-2687 y-2688)
  `(py-test-eq-bintX-strY-fallback ,x-2687 ,y-2688))

(define-macro (py-eq-bintX-sintY-inline x-2690 y-2691)
  `(py-eq-bintX-sintY-fallback ,x-2690 ,y-2691))

(define-macro (py-test-eq-bintX-sintY-inline x-2693 y-2694)
  `(py-test-eq-bintX-sintY-fallback ,x-2693 ,y-2694))

(define-macro (py-eq-bintX-bintY-inline x-2696 y-2697)
  `(py-eq-bintX-bintY-fallback ,x-2696 ,y-2697))

(define-macro (py-test-eq-bintX-bintY-inline x-2699 y-2700)
  `(py-test-eq-bintX-bintY-fallback ,x-2699 ,y-2700))

(define-macro (py-ne-floatX-floatY-inline x-2702 y-2703)
  `(let ((x-2702 ,x-2702) (y-2703 ,y-2703))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py!= (py-float-to-scheme x-2702) (py-float-to-scheme y-2703))))))

(define-macro (py-test-ne-floatX-floatY-inline x-2705 y-2706)
  `(let ((x-2705 ,x-2705) (y-2706 ,y-2706))
     (py-test-from-scheme
      (py!= (py-float-to-scheme x-2705) (py-float-to-scheme y-2706)))))

(define-macro (py-ne-floatX-boolY-inline x-2708 y-2709)
  `(py-ne-floatX-boolY-fallback ,x-2708 ,y-2709))

(define-macro (py-test-ne-floatX-boolY-inline x-2711 y-2712)
  `(py-test-ne-floatX-boolY-fallback ,x-2711 ,y-2712))

(define-macro (py-ne-floatX-strY-inline x-2714 y-2715)
  `(py-ne-floatX-strY-fallback ,x-2714 ,y-2715))

(define-macro (py-test-ne-floatX-strY-inline x-2717 y-2718)
  `(py-test-ne-floatX-strY-fallback ,x-2717 ,y-2718))

(define-macro (py-ne-floatX-sintY-inline x-2720 y-2721)
  `(let ((x-2720 ,x-2720) (y-2721 ,y-2721))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py!= (py-float-to-scheme x-2720) (py-sint-to-scheme y-2721))))))

(define-macro (py-test-ne-floatX-sintY-inline x-2723 y-2724)
  `(let ((x-2723 ,x-2723) (y-2724 ,y-2724))
     (py-test-from-scheme
      (py!= (py-float-to-scheme x-2723) (py-sint-to-scheme y-2724)))))

(define-macro (py-ne-floatX-bintY-inline x-2726 y-2727)
  `(py-ne-floatX-bintY-fallback ,x-2726 ,y-2727))

(define-macro (py-test-ne-floatX-bintY-inline x-2729 y-2730)
  `(py-test-ne-floatX-bintY-fallback ,x-2729 ,y-2730))

(define-macro (py-ne-boolX-floatY-inline x-2732 y-2733)
  `(py-ne-boolX-floatY-fallback ,x-2732 ,y-2733))

(define-macro (py-test-ne-boolX-floatY-inline x-2735 y-2736)
  `(py-test-ne-boolX-floatY-fallback ,x-2735 ,y-2736))

(define-macro (py-ne-boolX-boolY-inline x-2738 y-2739)
  `(py-ne-boolX-boolY-fallback ,x-2738 ,y-2739))

(define-macro (py-test-ne-boolX-boolY-inline x-2741 y-2742)
  `(py-test-ne-boolX-boolY-fallback ,x-2741 ,y-2742))

(define-macro (py-ne-boolX-strY-inline x-2744 y-2745)
  `(py-ne-boolX-strY-fallback ,x-2744 ,y-2745))

(define-macro (py-test-ne-boolX-strY-inline x-2747 y-2748)
  `(py-test-ne-boolX-strY-fallback ,x-2747 ,y-2748))

(define-macro (py-ne-boolX-sintY-inline x-2750 y-2751)
  `(py-ne-boolX-sintY-fallback ,x-2750 ,y-2751))

(define-macro (py-test-ne-boolX-sintY-inline x-2753 y-2754)
  `(py-test-ne-boolX-sintY-fallback ,x-2753 ,y-2754))

(define-macro (py-ne-boolX-bintY-inline x-2756 y-2757)
  `(py-ne-boolX-bintY-fallback ,x-2756 ,y-2757))

(define-macro (py-test-ne-boolX-bintY-inline x-2759 y-2760)
  `(py-test-ne-boolX-bintY-fallback ,x-2759 ,y-2760))

(define-macro (py-ne-strX-floatY-inline x-2762 y-2763)
  `(py-ne-strX-floatY-fallback ,x-2762 ,y-2763))

(define-macro (py-test-ne-strX-floatY-inline x-2765 y-2766)
  `(py-test-ne-strX-floatY-fallback ,x-2765 ,y-2766))

(define-macro (py-ne-strX-boolY-inline x-2768 y-2769)
  `(py-ne-strX-boolY-fallback ,x-2768 ,y-2769))

(define-macro (py-test-ne-strX-boolY-inline x-2771 y-2772)
  `(py-test-ne-strX-boolY-fallback ,x-2771 ,y-2772))

(define-macro (py-ne-strX-strY-inline x-2774 y-2775)
  `(py-ne-strX-strY-fallback ,x-2774 ,y-2775))

(define-macro (py-test-ne-strX-strY-inline x-2777 y-2778)
  `(py-test-ne-strX-strY-fallback ,x-2777 ,y-2778))

(define-macro (py-ne-strX-sintY-inline x-2780 y-2781)
  `(py-ne-strX-sintY-fallback ,x-2780 ,y-2781))

(define-macro (py-test-ne-strX-sintY-inline x-2783 y-2784)
  `(py-test-ne-strX-sintY-fallback ,x-2783 ,y-2784))

(define-macro (py-ne-strX-bintY-inline x-2786 y-2787)
  `(py-ne-strX-bintY-fallback ,x-2786 ,y-2787))

(define-macro (py-test-ne-strX-bintY-inline x-2789 y-2790)
  `(py-test-ne-strX-bintY-fallback ,x-2789 ,y-2790))

(define-macro (py-ne-sintX-floatY-inline x-2792 y-2793)
  `(let ((x-2792 ,x-2792) (y-2793 ,y-2793))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py!= (py-float-to-scheme y-2793) (py-sint-to-scheme x-2792))))))

(define-macro (py-test-ne-sintX-floatY-inline x-2795 y-2796)
  `(let ((x-2795 ,x-2795) (y-2796 ,y-2796))
     (py-test-from-scheme
      (py!= (py-float-to-scheme y-2796) (py-sint-to-scheme x-2795)))))

(define-macro (py-ne-sintX-boolY-inline x-2798 y-2799)
  `(py-ne-sintX-boolY-fallback ,x-2798 ,y-2799))

(define-macro (py-test-ne-sintX-boolY-inline x-2801 y-2802)
  `(py-test-ne-sintX-boolY-fallback ,x-2801 ,y-2802))

(define-macro (py-ne-sintX-strY-inline x-2804 y-2805)
  `(py-ne-sintX-strY-fallback ,x-2804 ,y-2805))

(define-macro (py-test-ne-sintX-strY-inline x-2807 y-2808)
  `(py-test-ne-sintX-strY-fallback ,x-2807 ,y-2808))

(define-macro (py-ne-sintX-sintY-inline x-2810 y-2811)
  `(let ((x-2810 ,x-2810) (y-2811 ,y-2811))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py!= (py-sint-to-scheme x-2810) (py-sint-to-scheme y-2811))))))

(define-macro (py-test-ne-sintX-sintY-inline x-2813 y-2814)
  `(let ((x-2813 ,x-2813) (y-2814 ,y-2814))
     (py-test-from-scheme
      (py!= (py-sint-to-scheme x-2813) (py-sint-to-scheme y-2814)))))

(define-macro (py-ne-sintX-bintY-inline x-2816 y-2817)
  `(py-ne-sintX-bintY-fallback ,x-2816 ,y-2817))

(define-macro (py-test-ne-sintX-bintY-inline x-2819 y-2820)
  `(py-test-ne-sintX-bintY-fallback ,x-2819 ,y-2820))

(define-macro (py-ne-bintX-floatY-inline x-2822 y-2823)
  `(py-ne-bintX-floatY-fallback ,x-2822 ,y-2823))

(define-macro (py-test-ne-bintX-floatY-inline x-2825 y-2826)
  `(py-test-ne-bintX-floatY-fallback ,x-2825 ,y-2826))

(define-macro (py-ne-bintX-boolY-inline x-2828 y-2829)
  `(py-ne-bintX-boolY-fallback ,x-2828 ,y-2829))

(define-macro (py-test-ne-bintX-boolY-inline x-2831 y-2832)
  `(py-test-ne-bintX-boolY-fallback ,x-2831 ,y-2832))

(define-macro (py-ne-bintX-strY-inline x-2834 y-2835)
  `(py-ne-bintX-strY-fallback ,x-2834 ,y-2835))

(define-macro (py-test-ne-bintX-strY-inline x-2837 y-2838)
  `(py-test-ne-bintX-strY-fallback ,x-2837 ,y-2838))

(define-macro (py-ne-bintX-sintY-inline x-2840 y-2841)
  `(py-ne-bintX-sintY-fallback ,x-2840 ,y-2841))

(define-macro (py-test-ne-bintX-sintY-inline x-2843 y-2844)
  `(py-test-ne-bintX-sintY-fallback ,x-2843 ,y-2844))

(define-macro (py-ne-bintX-bintY-inline x-2846 y-2847)
  `(py-ne-bintX-bintY-fallback ,x-2846 ,y-2847))

(define-macro (py-test-ne-bintX-bintY-inline x-2849 y-2850)
  `(py-test-ne-bintX-bintY-fallback ,x-2849 ,y-2850))

(define-macro (py-pos-floatX-inline x-2852) `(let ((x-2852 ,x-2852)) x-2852))

(define-macro (py-pos-boolX-inline x-2854) `(py-pos-boolX-fallback ,x-2854))

(define-macro (py-pos-strX-inline x-2856) `(py-pos-strX-fallback ,x-2856))

(define-macro (py-pos-sintX-inline x-2858) `(let ((x-2858 ,x-2858)) x-2858))

(define-macro (py-pos-bintX-inline x-2860) `(py-pos-bintX-fallback ,x-2860))

(define-macro (py-neg-floatX-inline x-2862)
  `(let ((x-2862 ,x-2862))
     (py-float-from-scheme (pyneg (py-float-to-scheme x-2862)))))

(define-macro (py-neg-boolX-inline x-2864) `(py-neg-boolX-fallback ,x-2864))

(define-macro (py-neg-strX-inline x-2866) `(py-neg-strX-fallback ,x-2866))

(define-macro (py-neg-sintX-inline x-2868)
  `(let ((x-2868 ,x-2868))
     (py-int-from-scheme (pyneg (py-sint-to-scheme x-2868)))))

(define-macro (py-neg-bintX-inline x-2870) `(py-neg-bintX-fallback ,x-2870))

(define-macro (py-invert-floatX-inline x-2872)
  `(let ((x-2872 ,x-2872))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "bad operand type for unary ~: 'float'")))))

(define-macro (py-invert-boolX-inline x-2874)
  `(py-invert-boolX-fallback ,x-2874))

(define-macro (py-invert-strX-inline x-2876)
  `(py-invert-strX-fallback ,x-2876))

(define-macro (py-invert-sintX-inline x-2878)
  `(let ((x-2878 ,x-2878))
     (py-int-from-scheme (pyinvert (py-sint-to-scheme x-2878)))))

(define-macro (py-invert-bintX-inline x-2880)
  `(py-invert-bintX-fallback ,x-2880))

(define (py-add-floatX-floatY-fallback x-2 y-3)
  (py-float-from-scheme
   (py+ (py-float-to-scheme x-2) (py-float-to-scheme y-3))))

(define (py-add-floatX-boolY-fallback x-5 y-6)
  (py-float-from-scheme
   (py+ (py-float-to-scheme x-5) (py-bool-to-scheme-int y-6))))

(define (py-add-floatX-strY-fallback x-8 y-9)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for +: 'float' and 'str'"))))

(define (py-add-floatX-sintY-fallback x-11 y-12)
  (py-float-from-scheme
   (py+ (py-float-to-scheme x-11) (py-sint-to-scheme y-12))))

(define (py-add-floatX-bintY-fallback x-14 y-15)
  (py-float-from-scheme
   (py+ (py-float-to-scheme x-14) (py-bint-to-scheme y-15))))

(define (py-add-boolX-floatY-fallback x-17 y-18)
  (py-float-from-scheme
   (py+ (py-bool-to-scheme-int x-17) (py-float-to-scheme y-18))))

(define (py-add-boolX-boolY-fallback x-20 y-21)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme-int x-20) (py-bool-to-scheme-int y-21))))

(define (py-add-boolX-strY-fallback x-23 y-24)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for +: 'bool' and 'str'"))))

(define (py-add-boolX-sintY-fallback x-26 y-27)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme-int x-26) (py-sint-to-scheme y-27))))

(define (py-add-boolX-bintY-fallback x-29 y-30)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme-int x-29) (py-bint-to-scheme y-30))))

(define (py-add-strX-floatY-fallback x-32 y-33)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for +: 'str' and 'float'"))))

(define (py-add-strX-boolY-fallback x-35 y-36)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for +: 'str' and 'bool'"))))

(define (py-add-strX-strY-fallback x-38 y-39)
  (py-str-from-scheme (py+ (py-str-to-scheme x-38) (py-str-to-scheme y-39))))

(define (py-add-strX-sintY-fallback x-41 y-42)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for +: 'str' and 'int'"))))

(define (py-add-strX-bintY-fallback x-44 y-45)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for +: 'str' and 'int'"))))

(define (py-add-sintX-floatY-fallback x-47 y-48)
  (py-float-from-scheme
   (py+ (py-sint-to-scheme x-47) (py-float-to-scheme y-48))))

(define (py-add-sintX-boolY-fallback x-50 y-51)
  (py-int-from-scheme
   (py+ (py-sint-to-scheme x-50) (py-bool-to-scheme-int y-51))))

(define (py-add-sintX-strY-fallback x-53 y-54)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for +: 'int' and 'str'"))))

(define (py-add-sintX-sintY-fallback x-56 y-57)
  (py-int-from-scheme (py+ (py-sint-to-scheme x-56) (py-sint-to-scheme y-57))))

(define (py-add-sintX-bintY-fallback x-59 y-60)
  (py-int-from-scheme (py+ (py-sint-to-scheme x-59) (py-bint-to-scheme y-60))))

(define (py-add-bintX-floatY-fallback x-62 y-63)
  (py-float-from-scheme
   (py+ (py-bint-to-scheme x-62) (py-float-to-scheme y-63))))

(define (py-add-bintX-boolY-fallback x-65 y-66)
  (py-int-from-scheme
   (py+ (py-bint-to-scheme x-65) (py-bool-to-scheme-int y-66))))

(define (py-add-bintX-strY-fallback x-68 y-69)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for +: 'int' and 'str'"))))

(define (py-add-bintX-sintY-fallback x-71 y-72)
  (py-int-from-scheme (py+ (py-bint-to-scheme x-71) (py-sint-to-scheme y-72))))

(define (py-add-bintX-bintY-fallback x-74 y-75)
  (py-int-from-scheme (py+ (py-bint-to-scheme x-74) (py-bint-to-scheme y-75))))

(define (py-bitand-floatX-floatY-fallback x-77 y-78)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'float'"))))

(define (py-bitand-floatX-boolY-fallback x-80 y-81)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'bool'"))))

(define (py-bitand-floatX-strY-fallback x-83 y-84)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'str'"))))

(define (py-bitand-floatX-sintY-fallback x-86 y-87)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'int'"))))

(define (py-bitand-floatX-bintY-fallback x-89 y-90)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'int'"))))

(define (py-bitand-boolX-floatY-fallback x-92 y-93)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'bool' and 'float'"))))

(define (py-bitand-boolX-boolY-fallback x-95 y-96)
  (if (py-test (py-is x-95 py-True)) y-96 py-False))

(define (py-bitand-boolX-strY-fallback x-98 y-99)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'bool' and 'str'"))))

(define (py-bitand-boolX-sintY-fallback x-101 y-102)
  (py-int-from-scheme
   (py& (py-bool-to-scheme-int x-101) (py-sint-to-scheme y-102))))

(define (py-bitand-boolX-bintY-fallback x-104 y-105)
  (py-int-from-scheme
   (py& (py-bool-to-scheme-int x-104) (py-bint-to-scheme y-105))))

(define (py-bitand-strX-floatY-fallback x-107 y-108)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'str' and 'float'"))))

(define (py-bitand-strX-boolY-fallback x-110 y-111)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'str' and 'bool'"))))

(define (py-bitand-strX-strY-fallback x-113 y-114)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'str' and 'str'"))))

(define (py-bitand-strX-sintY-fallback x-116 y-117)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'str' and 'int'"))))

(define (py-bitand-strX-bintY-fallback x-119 y-120)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'str' and 'int'"))))

(define (py-bitand-sintX-floatY-fallback x-122 y-123)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'int' and 'float'"))))

(define (py-bitand-sintX-boolY-fallback x-125 y-126)
  (py-int-from-scheme
   (py& (py-sint-to-scheme x-125) (py-bool-to-scheme-int y-126))))

(define (py-bitand-sintX-strY-fallback x-128 y-129)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'int' and 'str'"))))

(define (py-bitand-sintX-sintY-fallback x-131 y-132)
  (py-int-from-scheme
   (py& (py-sint-to-scheme x-131) (py-sint-to-scheme y-132))))

(define (py-bitand-sintX-bintY-fallback x-134 y-135)
  (py-int-from-scheme
   (py& (py-sint-to-scheme x-134) (py-bint-to-scheme y-135))))

(define (py-bitand-bintX-floatY-fallback x-137 y-138)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'int' and 'float'"))))

(define (py-bitand-bintX-boolY-fallback x-140 y-141)
  (py-int-from-scheme
   (py& (py-bint-to-scheme x-140) (py-bool-to-scheme-int y-141))))

(define (py-bitand-bintX-strY-fallback x-143 y-144)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'int' and 'str'"))))

(define (py-bitand-bintX-sintY-fallback x-146 y-147)
  (py-int-from-scheme
   (py& (py-bint-to-scheme x-146) (py-sint-to-scheme y-147))))

(define (py-bitand-bintX-bintY-fallback x-149 y-150)
  (py-int-from-scheme
   (py& (py-bint-to-scheme x-149) (py-bint-to-scheme y-150))))

(define (py-bitor-floatX-floatY-fallback x-152 y-153)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'float'"))))

(define (py-bitor-floatX-boolY-fallback x-155 y-156)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'bool'"))))

(define (py-bitor-floatX-strY-fallback x-158 y-159)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'str'"))))

(define (py-bitor-floatX-sintY-fallback x-161 y-162)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'int'"))))

(define (py-bitor-floatX-bintY-fallback x-164 y-165)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'int'"))))

(define (py-bitor-boolX-floatY-fallback x-167 y-168)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'bool' and 'float'"))))

(define (py-bitor-boolX-boolY-fallback x-170 y-171)
  (if (py-test (py-is x-170 py-True)) py-True y-171))

(define (py-bitor-boolX-strY-fallback x-173 y-174)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'bool' and 'str'"))))

(define (py-bitor-boolX-sintY-fallback x-176 y-177)
  (py-int-from-scheme
   (py+b (py-bool-to-scheme-int x-176) (py-sint-to-scheme y-177))))

(define (py-bitor-boolX-bintY-fallback x-179 y-180)
  (py-int-from-scheme
   (py+b (py-bool-to-scheme-int x-179) (py-bint-to-scheme y-180))))

(define (py-bitor-strX-floatY-fallback x-182 y-183)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'str' and 'float'"))))

(define (py-bitor-strX-boolY-fallback x-185 y-186)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'str' and 'bool'"))))

(define (py-bitor-strX-strY-fallback x-188 y-189)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'str' and 'str'"))))

(define (py-bitor-strX-sintY-fallback x-191 y-192)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'str' and 'int'"))))

(define (py-bitor-strX-bintY-fallback x-194 y-195)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'str' and 'int'"))))

(define (py-bitor-sintX-floatY-fallback x-197 y-198)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'int' and 'float'"))))

(define (py-bitor-sintX-boolY-fallback x-200 y-201)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme x-200) (py-bool-to-scheme-int y-201))))

(define (py-bitor-sintX-strY-fallback x-203 y-204)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'int' and 'str'"))))

(define (py-bitor-sintX-sintY-fallback x-206 y-207)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme x-206) (py-sint-to-scheme y-207))))

(define (py-bitor-sintX-bintY-fallback x-209 y-210)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme x-209) (py-bint-to-scheme y-210))))

(define (py-bitor-bintX-floatY-fallback x-212 y-213)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'int' and 'float'"))))

(define (py-bitor-bintX-boolY-fallback x-215 y-216)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme x-215) (py-bool-to-scheme-int y-216))))

(define (py-bitor-bintX-strY-fallback x-218 y-219)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'int' and 'str'"))))

(define (py-bitor-bintX-sintY-fallback x-221 y-222)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme x-221) (py-sint-to-scheme y-222))))

(define (py-bitor-bintX-bintY-fallback x-224 y-225)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme x-224) (py-bint-to-scheme y-225))))

(define (py-floordiv-floatX-floatY-fallback x-227 y-228)
  (if (py-test (py-ne y-228 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-float-to-scheme x-227) (py-float-to-scheme y-228)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-floatX-boolY-fallback x-230 y-231)
  (if (py-test (py-ne y-231 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py// (py-float-to-scheme x-230) (py-bool-to-scheme-int y-231)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-floatX-strY-fallback x-233 y-234)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //: 'float' and 'str'"))))

(define (py-floordiv-floatX-sintY-fallback x-236 y-237)
  (if (py-test (py-ne y-237 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py// (py-float-to-scheme x-236) (py-sint-to-scheme y-237)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-floatX-bintY-fallback x-239 y-240)
  (py-float-from-scheme
   (py// (py-float-to-scheme x-239) (py-bint-to-scheme y-240))))

(define (py-floordiv-boolX-floatY-fallback x-242 y-243)
  (if (py-test (py-ne y-243 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-bool-to-scheme-int x-242) (py-float-to-scheme y-243)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-boolX-boolY-fallback x-245 y-246)
  (if (py-test (py-ne y-246 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bool-to-scheme-int x-245) (py-bool-to-scheme-int y-246)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-boolX-strY-fallback x-248 y-249)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //: 'bool' and 'str'"))))

(define (py-floordiv-boolX-sintY-fallback x-251 y-252)
  (if (py-test (py-ne y-252 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bool-to-scheme-int x-251) (py-sint-to-scheme y-252)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-boolX-bintY-fallback x-254 y-255)
  (py-int-from-scheme
   (py// (py-bool-to-scheme-int x-254) (py-bint-to-scheme y-255))))

(define (py-floordiv-strX-floatY-fallback x-257 y-258)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //: 'str' and 'float'"))))

(define (py-floordiv-strX-boolY-fallback x-260 y-261)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //: 'str' and 'bool'"))))

(define (py-floordiv-strX-strY-fallback x-263 y-264)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //: 'str' and 'str'"))))

(define (py-floordiv-strX-sintY-fallback x-266 y-267)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //: 'str' and 'int'"))))

(define (py-floordiv-strX-bintY-fallback x-269 y-270)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //: 'str' and 'int'"))))

(define (py-floordiv-sintX-floatY-fallback x-272 y-273)
  (if (py-test (py-ne y-273 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-sint-to-scheme x-272) (py-float-to-scheme y-273)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-sintX-boolY-fallback x-275 y-276)
  (if (py-test (py-ne y-276 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-sint-to-scheme x-275) (py-bool-to-scheme-int y-276)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-sintX-strY-fallback x-278 y-279)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //: 'int' and 'str'"))))

(define (py-floordiv-sintX-sintY-fallback x-281 y-282)
  (if (py-test (py-ne y-282 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-sint-to-scheme x-281) (py-sint-to-scheme y-282)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-sintX-bintY-fallback x-284 y-285)
  (py-int-from-scheme
   (py// (py-sint-to-scheme x-284) (py-bint-to-scheme y-285))))

(define (py-floordiv-bintX-floatY-fallback x-287 y-288)
  (if (py-test (py-ne y-288 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-bint-to-scheme x-287) (py-float-to-scheme y-288)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-bintX-boolY-fallback x-290 y-291)
  (if (py-test (py-ne y-291 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bint-to-scheme x-290) (py-bool-to-scheme-int y-291)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-bintX-strY-fallback x-293 y-294)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //: 'int' and 'str'"))))

(define (py-floordiv-bintX-sintY-fallback x-296 y-297)
  (if (py-test (py-ne y-297 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bint-to-scheme x-296) (py-sint-to-scheme y-297)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-bintX-bintY-fallback x-299 y-300)
  (py-int-from-scheme
   (py// (py-bint-to-scheme x-299) (py-bint-to-scheme y-300))))

(define (py-lshift-floatX-floatY-fallback x-302 y-303)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'float'"))))

(define (py-lshift-floatX-boolY-fallback x-305 y-306)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'bool'"))))

(define (py-lshift-floatX-strY-fallback x-308 y-309)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'str'"))))

(define (py-lshift-floatX-sintY-fallback x-311 y-312)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'int'"))))

(define (py-lshift-floatX-bintY-fallback x-314 y-315)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'int'"))))

(define (py-lshift-boolX-floatY-fallback x-317 y-318)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'bool' and 'float'"))))

(define (py-lshift-boolX-boolY-fallback x-320 y-321)
  (if (py-test (py-ge y-321 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bool-to-scheme-int x-320) (py-bool-to-scheme-int y-321)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-boolX-strY-fallback x-323 y-324)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'bool' and 'str'"))))

(define (py-lshift-boolX-sintY-fallback x-326 y-327)
  (if (py-test (py-ge y-327 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bool-to-scheme-int x-326) (py-sint-to-scheme y-327)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-boolX-bintY-fallback x-329 y-330)
  (if (py-test (py-ge y-330 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bool-to-scheme-int x-329) (py-bint-to-scheme y-330)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-strX-floatY-fallback x-332 y-333)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'str' and 'float'"))))

(define (py-lshift-strX-boolY-fallback x-335 y-336)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'str' and 'bool'"))))

(define (py-lshift-strX-strY-fallback x-338 y-339)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'str' and 'str'"))))

(define (py-lshift-strX-sintY-fallback x-341 y-342)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'str' and 'int'"))))

(define (py-lshift-strX-bintY-fallback x-344 y-345)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'str' and 'int'"))))

(define (py-lshift-sintX-floatY-fallback x-347 y-348)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'int' and 'float'"))))

(define (py-lshift-sintX-boolY-fallback x-350 y-351)
  (if (py-test (py-ge y-351 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-sint-to-scheme x-350) (py-bool-to-scheme-int y-351)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-sintX-strY-fallback x-353 y-354)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'int' and 'str'"))))

(define (py-lshift-sintX-sintY-fallback x-356 y-357)
  (if (py-test (py-ge y-357 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-sint-to-scheme x-356) (py-sint-to-scheme y-357)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-sintX-bintY-fallback x-359 y-360)
  (if (py-test (py-ge y-360 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-sint-to-scheme x-359) (py-bint-to-scheme y-360)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-bintX-floatY-fallback x-362 y-363)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'int' and 'float'"))))

(define (py-lshift-bintX-boolY-fallback x-365 y-366)
  (if (py-test (py-ge y-366 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bint-to-scheme x-365) (py-bool-to-scheme-int y-366)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-bintX-strY-fallback x-368 y-369)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'int' and 'str'"))))

(define (py-lshift-bintX-sintY-fallback x-371 y-372)
  (if (py-test (py-ge y-372 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bint-to-scheme x-371) (py-sint-to-scheme y-372)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-bintX-bintY-fallback x-374 y-375)
  (if (py-test (py-ge y-375 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bint-to-scheme x-374) (py-bint-to-scheme y-375)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-matmul-floatX-floatY-fallback x-377 y-378)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'float'"))))

(define (py-matmul-floatX-boolY-fallback x-380 y-381)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'bool'"))))

(define (py-matmul-floatX-strY-fallback x-383 y-384)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'str'"))))

(define (py-matmul-floatX-sintY-fallback x-386 y-387)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'int'"))))

(define (py-matmul-floatX-bintY-fallback x-389 y-390)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'int'"))))

(define (py-matmul-boolX-floatY-fallback x-392 y-393)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'float'"))))

(define (py-matmul-boolX-boolY-fallback x-395 y-396)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'bool'"))))

(define (py-matmul-boolX-strY-fallback x-398 y-399)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'str'"))))

(define (py-matmul-boolX-sintY-fallback x-401 y-402)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'int'"))))

(define (py-matmul-boolX-bintY-fallback x-404 y-405)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'int'"))))

(define (py-matmul-strX-floatY-fallback x-407 y-408)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'str' and 'float'"))))

(define (py-matmul-strX-boolY-fallback x-410 y-411)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'str' and 'bool'"))))

(define (py-matmul-strX-strY-fallback x-413 y-414)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'str' and 'str'"))))

(define (py-matmul-strX-sintY-fallback x-416 y-417)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'str' and 'int'"))))

(define (py-matmul-strX-bintY-fallback x-419 y-420)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'str' and 'int'"))))

(define (py-matmul-sintX-floatY-fallback x-422 y-423)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'float'"))))

(define (py-matmul-sintX-boolY-fallback x-425 y-426)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'bool'"))))

(define (py-matmul-sintX-strY-fallback x-428 y-429)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'str'"))))

(define (py-matmul-sintX-sintY-fallback x-431 y-432)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-matmul-sintX-bintY-fallback x-434 y-435)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-matmul-bintX-floatY-fallback x-437 y-438)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'float'"))))

(define (py-matmul-bintX-boolY-fallback x-440 y-441)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'bool'"))))

(define (py-matmul-bintX-strY-fallback x-443 y-444)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'str'"))))

(define (py-matmul-bintX-sintY-fallback x-446 y-447)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-matmul-bintX-bintY-fallback x-449 y-450)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-mod-floatX-floatY-fallback x-452 y-453)
  (if (py-test (py-ne y-453 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-float-to-scheme x-452) (py-float-to-scheme y-453)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-floatX-boolY-fallback x-455 y-456)
  (if (py-test (py-ne y-456 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py% (py-float-to-scheme x-455) (py-bool-to-scheme-int y-456)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-floatX-strY-fallback x-458 y-459)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %: 'float' and 'str'"))))

(define (py-mod-floatX-sintY-fallback x-461 y-462)
  (if (py-test (py-ne y-462 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py% (py-float-to-scheme x-461) (py-sint-to-scheme y-462)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-floatX-bintY-fallback x-464 y-465)
  (py-float-from-scheme
   (py% (py-float-to-scheme x-464) (py-bint-to-scheme y-465))))

(define (py-mod-boolX-floatY-fallback x-467 y-468)
  (if (py-test (py-ne y-468 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-bool-to-scheme-int x-467) (py-float-to-scheme y-468)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-boolX-boolY-fallback x-470 y-471)
  (if (py-test (py-ne y-471 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bool-to-scheme-int x-470) (py-bool-to-scheme-int y-471)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-boolX-strY-fallback x-473 y-474)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %: 'bool' and 'str'"))))

(define (py-mod-boolX-sintY-fallback x-476 y-477)
  (if (py-test (py-ne y-477 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bool-to-scheme-int x-476) (py-sint-to-scheme y-477)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-boolX-bintY-fallback x-479 y-480)
  (py-int-from-scheme
   (py% (py-bool-to-scheme-int x-479) (py-bint-to-scheme y-480))))

(define (py-mod-strX-floatY-fallback x-482 y-483)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %: 'str' and 'float'"))))

(define (py-mod-strX-boolY-fallback x-485 y-486)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %: 'str' and 'bool'"))))

(define (py-mod-strX-strY-fallback x-488 y-489)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %: 'str' and 'str'"))))

(define (py-mod-strX-sintY-fallback x-491 y-492)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %: 'str' and 'int'"))))

(define (py-mod-strX-bintY-fallback x-494 y-495)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %: 'str' and 'int'"))))

(define (py-mod-sintX-floatY-fallback x-497 y-498)
  (if (py-test (py-ne y-498 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-sint-to-scheme x-497) (py-float-to-scheme y-498)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-sintX-boolY-fallback x-500 y-501)
  (if (py-test (py-ne y-501 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-sint-to-scheme x-500) (py-bool-to-scheme-int y-501)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-sintX-strY-fallback x-503 y-504)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %: 'int' and 'str'"))))

(define (py-mod-sintX-sintY-fallback x-506 y-507)
  (if (py-test (py-ne y-507 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-sint-to-scheme x-506) (py-sint-to-scheme y-507)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-sintX-bintY-fallback x-509 y-510)
  (py-int-from-scheme
   (py% (py-sint-to-scheme x-509) (py-bint-to-scheme y-510))))

(define (py-mod-bintX-floatY-fallback x-512 y-513)
  (if (py-test (py-ne y-513 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-bint-to-scheme x-512) (py-float-to-scheme y-513)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-bintX-boolY-fallback x-515 y-516)
  (if (py-test (py-ne y-516 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bint-to-scheme x-515) (py-bool-to-scheme-int y-516)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-bintX-strY-fallback x-518 y-519)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %: 'int' and 'str'"))))

(define (py-mod-bintX-sintY-fallback x-521 y-522)
  (if (py-test (py-ne y-522 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bint-to-scheme x-521) (py-sint-to-scheme y-522)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-bintX-bintY-fallback x-524 y-525)
  (py-int-from-scheme
   (py% (py-bint-to-scheme x-524) (py-bint-to-scheme y-525))))

(define (py-mul-floatX-floatY-fallback x-527 y-528)
  (py-float-from-scheme
   (py* (py-float-to-scheme x-527) (py-float-to-scheme y-528))))

(define (py-mul-floatX-boolY-fallback x-530 y-531)
  (py-float-from-scheme
   (py* (py-float-to-scheme x-530) (py-bool-to-scheme-int y-531))))

(define (py-mul-floatX-strY-fallback x-533 y-534)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for *: 'float' and 'str'"))))

(define (py-mul-floatX-sintY-fallback x-536 y-537)
  (py-float-from-scheme
   (py* (py-float-to-scheme x-536) (py-sint-to-scheme y-537))))

(define (py-mul-floatX-bintY-fallback x-539 y-540)
  (py-float-from-scheme
   (py* (py-float-to-scheme x-539) (py-bint-to-scheme y-540))))

(define (py-mul-boolX-floatY-fallback x-542 y-543)
  (py-float-from-scheme
   (py* (py-bool-to-scheme-int x-542) (py-float-to-scheme y-543))))

(define (py-mul-boolX-boolY-fallback x-545 y-546)
  (py-int-from-scheme
   (py* (py-bool-to-scheme-int x-545) (py-bool-to-scheme-int y-546))))

(define (py-mul-boolX-strY-fallback x-548 y-549)
  (py-str-from-scheme
   (py* (py-str-to-scheme y-549) (py-bool-to-scheme-int x-548))))

(define (py-mul-boolX-sintY-fallback x-551 y-552)
  (py-int-from-scheme
   (py* (py-bool-to-scheme-int x-551) (py-sint-to-scheme y-552))))

(define (py-mul-boolX-bintY-fallback x-554 y-555)
  (py-int-from-scheme
   (py* (py-bool-to-scheme-int x-554) (py-bint-to-scheme y-555))))

(define (py-mul-strX-floatY-fallback x-557 y-558)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for *: 'str' and 'float'"))))

(define (py-mul-strX-boolY-fallback x-560 y-561)
  (py-str-from-scheme
   (py* (py-str-to-scheme x-560) (py-bool-to-scheme-int y-561))))

(define (py-mul-strX-strY-fallback x-563 y-564)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for *: 'str' and 'str'"))))

(define (py-mul-strX-sintY-fallback x-566 y-567)
  (py-str-from-scheme
   (py* (py-str-to-scheme x-566) (py-sint-to-scheme y-567))))

(define (py-mul-strX-bintY-fallback x-569 y-570)
  (py-str-from-scheme
   (py* (py-str-to-scheme x-569) (py-bint-to-scheme y-570))))

(define (py-mul-sintX-floatY-fallback x-572 y-573)
  (py-float-from-scheme
   (py* (py-sint-to-scheme x-572) (py-float-to-scheme y-573))))

(define (py-mul-sintX-boolY-fallback x-575 y-576)
  (py-int-from-scheme
   (py* (py-sint-to-scheme x-575) (py-bool-to-scheme-int y-576))))

(define (py-mul-sintX-strY-fallback x-578 y-579)
  (py-str-from-scheme
   (py* (py-str-to-scheme y-579) (py-sint-to-scheme x-578))))

(define (py-mul-sintX-sintY-fallback x-581 y-582)
  (py-int-from-scheme
   (py* (py-sint-to-scheme x-581) (py-sint-to-scheme y-582))))

(define (py-mul-sintX-bintY-fallback x-584 y-585)
  (py-int-from-scheme
   (py* (py-sint-to-scheme x-584) (py-bint-to-scheme y-585))))

(define (py-mul-bintX-floatY-fallback x-587 y-588)
  (py-float-from-scheme
   (py* (py-bint-to-scheme x-587) (py-float-to-scheme y-588))))

(define (py-mul-bintX-boolY-fallback x-590 y-591)
  (py-int-from-scheme
   (py* (py-bint-to-scheme x-590) (py-bool-to-scheme-int y-591))))

(define (py-mul-bintX-strY-fallback x-593 y-594)
  (py-str-from-scheme
   (py* (py-str-to-scheme y-594) (py-bint-to-scheme x-593))))

(define (py-mul-bintX-sintY-fallback x-596 y-597)
  (py-int-from-scheme
   (py* (py-bint-to-scheme x-596) (py-sint-to-scheme y-597))))

(define (py-mul-bintX-bintY-fallback x-599 y-600)
  (py-int-from-scheme
   (py* (py-bint-to-scheme x-599) (py-bint-to-scheme y-600))))

(define (py-pow-floatX-floatY-fallback x-602 y-603)
  (py-float-from-scheme
   (py** (py-float-to-scheme x-602) (py-float-to-scheme y-603))))

(define (py-pow-floatX-boolY-fallback x-605 y-606)
  (py-float-from-scheme
   (py** (py-float-to-scheme x-605) (py-bool-to-scheme-int y-606))))

(define (py-pow-floatX-strY-fallback x-608 y-609)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **: 'float' and 'str'"))))

(define (py-pow-floatX-sintY-fallback x-611 y-612)
  (py-float-from-scheme
   (py** (py-float-to-scheme x-611) (py-sint-to-scheme y-612))))

(define (py-pow-floatX-bintY-fallback x-614 y-615)
  (py-float-from-scheme
   (py** (py-float-to-scheme x-614) (py-bint-to-scheme y-615))))

(define (py-pow-boolX-floatY-fallback x-617 y-618)
  (py-float-from-scheme
   (py** (py-bool-to-scheme-int x-617) (py-float-to-scheme y-618))))

(define (py-pow-boolX-boolY-fallback x-620 y-621)
  (py-int-from-scheme
   (py** (py-bool-to-scheme-int x-620) (py-bool-to-scheme-int y-621))))

(define (py-pow-boolX-strY-fallback x-623 y-624)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **: 'bool' and 'str'"))))

(define (py-pow-boolX-sintY-fallback x-626 y-627)
  (py-int-from-scheme
   (py** (py-bool-to-scheme-int x-626) (py-sint-to-scheme y-627))))

(define (py-pow-boolX-bintY-fallback x-629 y-630)
  (py-int-from-scheme
   (py** (py-bool-to-scheme-int x-629) (py-bint-to-scheme y-630))))

(define (py-pow-strX-floatY-fallback x-632 y-633)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **: 'str' and 'float'"))))

(define (py-pow-strX-boolY-fallback x-635 y-636)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **: 'str' and 'bool'"))))

(define (py-pow-strX-strY-fallback x-638 y-639)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **: 'str' and 'str'"))))

(define (py-pow-strX-sintY-fallback x-641 y-642)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **: 'str' and 'int'"))))

(define (py-pow-strX-bintY-fallback x-644 y-645)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **: 'str' and 'int'"))))

(define (py-pow-sintX-floatY-fallback x-647 y-648)
  (py-float-from-scheme
   (py** (py-sint-to-scheme x-647) (py-float-to-scheme y-648))))

(define (py-pow-sintX-boolY-fallback x-650 y-651)
  (py-int-from-scheme
   (py** (py-sint-to-scheme x-650) (py-bool-to-scheme-int y-651))))

(define (py-pow-sintX-strY-fallback x-653 y-654)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **: 'int' and 'str'"))))

(define (py-pow-sintX-sintY-fallback x-656 y-657)
  (py-int-from-scheme
   (py** (py-sint-to-scheme x-656) (py-sint-to-scheme y-657))))

(define (py-pow-sintX-bintY-fallback x-659 y-660)
  (py-int-from-scheme
   (py** (py-sint-to-scheme x-659) (py-bint-to-scheme y-660))))

(define (py-pow-bintX-floatY-fallback x-662 y-663)
  (py-float-from-scheme
   (py** (py-bint-to-scheme x-662) (py-float-to-scheme y-663))))

(define (py-pow-bintX-boolY-fallback x-665 y-666)
  (py-int-from-scheme
   (py** (py-bint-to-scheme x-665) (py-bool-to-scheme-int y-666))))

(define (py-pow-bintX-strY-fallback x-668 y-669)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **: 'int' and 'str'"))))

(define (py-pow-bintX-sintY-fallback x-671 y-672)
  (py-int-from-scheme
   (py** (py-bint-to-scheme x-671) (py-sint-to-scheme y-672))))

(define (py-pow-bintX-bintY-fallback x-674 y-675)
  (py-int-from-scheme
   (py** (py-bint-to-scheme x-674) (py-bint-to-scheme y-675))))

(define (py-rshift-floatX-floatY-fallback x-677 y-678)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'float'"))))

(define (py-rshift-floatX-boolY-fallback x-680 y-681)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'bool'"))))

(define (py-rshift-floatX-strY-fallback x-683 y-684)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'str'"))))

(define (py-rshift-floatX-sintY-fallback x-686 y-687)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'int'"))))

(define (py-rshift-floatX-bintY-fallback x-689 y-690)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'int'"))))

(define (py-rshift-boolX-floatY-fallback x-692 y-693)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'bool' and 'float'"))))

(define (py-rshift-boolX-boolY-fallback x-695 y-696)
  (if (py-test (py-ge y-696 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bool-to-scheme-int x-695) (py-bool-to-scheme-int y-696)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-boolX-strY-fallback x-698 y-699)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'bool' and 'str'"))))

(define (py-rshift-boolX-sintY-fallback x-701 y-702)
  (if (py-test (py-ge y-702 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bool-to-scheme-int x-701) (py-sint-to-scheme y-702)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-boolX-bintY-fallback x-704 y-705)
  (if (py-test (py-ge y-705 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bool-to-scheme-int x-704) (py-bint-to-scheme y-705)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-strX-floatY-fallback x-707 y-708)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'str' and 'float'"))))

(define (py-rshift-strX-boolY-fallback x-710 y-711)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'str' and 'bool'"))))

(define (py-rshift-strX-strY-fallback x-713 y-714)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'str' and 'str'"))))

(define (py-rshift-strX-sintY-fallback x-716 y-717)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'str' and 'int'"))))

(define (py-rshift-strX-bintY-fallback x-719 y-720)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'str' and 'int'"))))

(define (py-rshift-sintX-floatY-fallback x-722 y-723)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'int' and 'float'"))))

(define (py-rshift-sintX-boolY-fallback x-725 y-726)
  (if (py-test (py-ge y-726 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-sint-to-scheme x-725) (py-bool-to-scheme-int y-726)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-sintX-strY-fallback x-728 y-729)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'int' and 'str'"))))

(define (py-rshift-sintX-sintY-fallback x-731 y-732)
  (if (py-test (py-ge y-732 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-sint-to-scheme x-731) (py-sint-to-scheme y-732)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-sintX-bintY-fallback x-734 y-735)
  (if (py-test (py-ge y-735 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-sint-to-scheme x-734) (py-bint-to-scheme y-735)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-bintX-floatY-fallback x-737 y-738)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'int' and 'float'"))))

(define (py-rshift-bintX-boolY-fallback x-740 y-741)
  (if (py-test (py-ge y-741 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bint-to-scheme x-740) (py-bool-to-scheme-int y-741)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-bintX-strY-fallback x-743 y-744)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'int' and 'str'"))))

(define (py-rshift-bintX-sintY-fallback x-746 y-747)
  (if (py-test (py-ge y-747 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bint-to-scheme x-746) (py-sint-to-scheme y-747)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-bintX-bintY-fallback x-749 y-750)
  (if (py-test (py-ge y-750 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bint-to-scheme x-749) (py-bint-to-scheme y-750)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-sub-floatX-floatY-fallback x-752 y-753)
  (py-float-from-scheme
   (py- (py-float-to-scheme x-752) (py-float-to-scheme y-753))))

(define (py-sub-floatX-boolY-fallback x-755 y-756)
  (py-float-from-scheme
   (py- (py-float-to-scheme x-755) (py-bool-to-scheme-int y-756))))

(define (py-sub-floatX-strY-fallback x-758 y-759)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -: 'float' and 'str'"))))

(define (py-sub-floatX-sintY-fallback x-761 y-762)
  (py-float-from-scheme
   (py- (py-float-to-scheme x-761) (py-sint-to-scheme y-762))))

(define (py-sub-floatX-bintY-fallback x-764 y-765)
  (py-float-from-scheme
   (py- (py-float-to-scheme x-764) (py-bint-to-scheme y-765))))

(define (py-sub-boolX-floatY-fallback x-767 y-768)
  (py-float-from-scheme
   (py- (py-bool-to-scheme-int x-767) (py-float-to-scheme y-768))))

(define (py-sub-boolX-boolY-fallback x-770 y-771)
  (py-int-from-scheme
   (py- (py-bool-to-scheme-int x-770) (py-bool-to-scheme-int y-771))))

(define (py-sub-boolX-strY-fallback x-773 y-774)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -: 'bool' and 'str'"))))

(define (py-sub-boolX-sintY-fallback x-776 y-777)
  (py-int-from-scheme
   (py- (py-bool-to-scheme-int x-776) (py-sint-to-scheme y-777))))

(define (py-sub-boolX-bintY-fallback x-779 y-780)
  (py-int-from-scheme
   (py- (py-bool-to-scheme-int x-779) (py-bint-to-scheme y-780))))

(define (py-sub-strX-floatY-fallback x-782 y-783)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -: 'str' and 'float'"))))

(define (py-sub-strX-boolY-fallback x-785 y-786)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -: 'str' and 'bool'"))))

(define (py-sub-strX-strY-fallback x-788 y-789)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -: 'str' and 'str'"))))

(define (py-sub-strX-sintY-fallback x-791 y-792)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -: 'str' and 'int'"))))

(define (py-sub-strX-bintY-fallback x-794 y-795)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -: 'str' and 'int'"))))

(define (py-sub-sintX-floatY-fallback x-797 y-798)
  (py-float-from-scheme
   (py- (py-sint-to-scheme x-797) (py-float-to-scheme y-798))))

(define (py-sub-sintX-boolY-fallback x-800 y-801)
  (py-int-from-scheme
   (py- (py-sint-to-scheme x-800) (py-bool-to-scheme-int y-801))))

(define (py-sub-sintX-strY-fallback x-803 y-804)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -: 'int' and 'str'"))))

(define (py-sub-sintX-sintY-fallback x-806 y-807)
  (py-int-from-scheme
   (py- (py-sint-to-scheme x-806) (py-sint-to-scheme y-807))))

(define (py-sub-sintX-bintY-fallback x-809 y-810)
  (py-int-from-scheme
   (py- (py-sint-to-scheme x-809) (py-bint-to-scheme y-810))))

(define (py-sub-bintX-floatY-fallback x-812 y-813)
  (py-float-from-scheme
   (py- (py-bint-to-scheme x-812) (py-float-to-scheme y-813))))

(define (py-sub-bintX-boolY-fallback x-815 y-816)
  (py-int-from-scheme
   (py- (py-bint-to-scheme x-815) (py-bool-to-scheme-int y-816))))

(define (py-sub-bintX-strY-fallback x-818 y-819)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -: 'int' and 'str'"))))

(define (py-sub-bintX-sintY-fallback x-821 y-822)
  (py-int-from-scheme
   (py- (py-bint-to-scheme x-821) (py-sint-to-scheme y-822))))

(define (py-sub-bintX-bintY-fallback x-824 y-825)
  (py-int-from-scheme
   (py- (py-bint-to-scheme x-824) (py-bint-to-scheme y-825))))

(define (py-truediv-floatX-floatY-fallback x-827 y-828)
  (if (py-test (py-ne y-828 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme x-827) (py-float-to-scheme y-828)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-floatX-boolY-fallback x-830 y-831)
  (if (py-test (py-ne y-831 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme x-830) (py-bool-to-scheme-int y-831)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-floatX-strY-fallback x-833 y-834)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /: 'float' and 'str'"))))

(define (py-truediv-floatX-sintY-fallback x-836 y-837)
  (if (py-test (py-ne y-837 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme x-836) (py-sint-to-scheme y-837)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-floatX-bintY-fallback x-839 y-840)
  (py-float-from-scheme
   (py/ (py-float-to-scheme x-839) (py-bint-to-scheme y-840))))

(define (py-truediv-boolX-floatY-fallback x-842 y-843)
  (if (py-test (py-ne y-843 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme-int x-842) (py-float-to-scheme y-843)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-boolX-boolY-fallback x-845 y-846)
  (if (py-test (py-ne y-846 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme-int x-845) (py-bool-to-scheme-int y-846)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-boolX-strY-fallback x-848 y-849)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /: 'bool' and 'str'"))))

(define (py-truediv-boolX-sintY-fallback x-851 y-852)
  (if (py-test (py-ne y-852 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme-int x-851) (py-sint-to-scheme y-852)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-boolX-bintY-fallback x-854 y-855)
  (py-float-from-scheme
   (py/ (py-bool-to-scheme-int x-854) (py-bint-to-scheme y-855))))

(define (py-truediv-strX-floatY-fallback x-857 y-858)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /: 'str' and 'float'"))))

(define (py-truediv-strX-boolY-fallback x-860 y-861)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /: 'str' and 'bool'"))))

(define (py-truediv-strX-strY-fallback x-863 y-864)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /: 'str' and 'str'"))))

(define (py-truediv-strX-sintY-fallback x-866 y-867)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /: 'str' and 'int'"))))

(define (py-truediv-strX-bintY-fallback x-869 y-870)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /: 'str' and 'int'"))))

(define (py-truediv-sintX-floatY-fallback x-872 y-873)
  (if (py-test (py-ne y-873 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme x-872) (py-float-to-scheme y-873)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-sintX-boolY-fallback x-875 y-876)
  (if (py-test (py-ne y-876 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme x-875) (py-bool-to-scheme-int y-876)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-sintX-strY-fallback x-878 y-879)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /: 'int' and 'str'"))))

(define (py-truediv-sintX-sintY-fallback x-881 y-882)
  (if (py-test (py-ne y-882 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme x-881) (py-sint-to-scheme y-882)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-sintX-bintY-fallback x-884 y-885)
  (py-float-from-scheme
   (py/ (py-sint-to-scheme x-884) (py-bint-to-scheme y-885))))

(define (py-truediv-bintX-floatY-fallback x-887 y-888)
  (if (py-test (py-ne y-888 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme x-887) (py-float-to-scheme y-888)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-bintX-boolY-fallback x-890 y-891)
  (if (py-test (py-ne y-891 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme x-890) (py-bool-to-scheme-int y-891)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-bintX-strY-fallback x-893 y-894)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /: 'int' and 'str'"))))

(define (py-truediv-bintX-sintY-fallback x-896 y-897)
  (if (py-test (py-ne y-897 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme x-896) (py-sint-to-scheme y-897)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-bintX-bintY-fallback x-899 y-900)
  (py-float-from-scheme
   (py/ (py-bint-to-scheme x-899) (py-bint-to-scheme y-900))))

(define (py-xor-floatX-floatY-fallback x-902 y-903)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'float'"))))

(define (py-xor-floatX-boolY-fallback x-905 y-906)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'bool'"))))

(define (py-xor-floatX-strY-fallback x-908 y-909)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'str'"))))

(define (py-xor-floatX-sintY-fallback x-911 y-912)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'int'"))))

(define (py-xor-floatX-bintY-fallback x-914 y-915)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'int'"))))

(define (py-xor-boolX-floatY-fallback x-917 y-918)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'bool' and 'float'"))))

(define (py-xor-boolX-boolY-fallback x-920 y-921) (py-isnot x-920 y-921))

(define (py-xor-boolX-strY-fallback x-923 y-924)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'bool' and 'str'"))))

(define (py-xor-boolX-sintY-fallback x-926 y-927)
  (py-int-from-scheme
   (py^ (py-bool-to-scheme-int x-926) (py-sint-to-scheme y-927))))

(define (py-xor-boolX-bintY-fallback x-929 y-930)
  (py-int-from-scheme
   (py^ (py-bool-to-scheme-int x-929) (py-bint-to-scheme y-930))))

(define (py-xor-strX-floatY-fallback x-932 y-933)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'str' and 'float'"))))

(define (py-xor-strX-boolY-fallback x-935 y-936)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'str' and 'bool'"))))

(define (py-xor-strX-strY-fallback x-938 y-939)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'str' and 'str'"))))

(define (py-xor-strX-sintY-fallback x-941 y-942)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'str' and 'int'"))))

(define (py-xor-strX-bintY-fallback x-944 y-945)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'str' and 'int'"))))

(define (py-xor-sintX-floatY-fallback x-947 y-948)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'int' and 'float'"))))

(define (py-xor-sintX-boolY-fallback x-950 y-951)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme x-950) (py-bool-to-scheme-int y-951))))

(define (py-xor-sintX-strY-fallback x-953 y-954)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'int' and 'str'"))))

(define (py-xor-sintX-sintY-fallback x-956 y-957)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme x-956) (py-sint-to-scheme y-957))))

(define (py-xor-sintX-bintY-fallback x-959 y-960)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme x-959) (py-bint-to-scheme y-960))))

(define (py-xor-bintX-floatY-fallback x-962 y-963)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'int' and 'float'"))))

(define (py-xor-bintX-boolY-fallback x-965 y-966)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme x-965) (py-bool-to-scheme-int y-966))))

(define (py-xor-bintX-strY-fallback x-968 y-969)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'int' and 'str'"))))

(define (py-xor-bintX-sintY-fallback x-971 y-972)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme x-971) (py-sint-to-scheme y-972))))

(define (py-xor-bintX-bintY-fallback x-974 y-975)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme x-974) (py-bint-to-scheme y-975))))

(define (py-iadd-floatX-floatY-fallback x-977 y-978)
  (py-float-from-scheme
   (py+ (py-float-to-scheme x-977) (py-float-to-scheme y-978))))

(define (py-iadd-floatX-boolY-fallback x-980 y-981)
  (py-float-from-scheme
   (py+ (py-float-to-scheme x-980) (py-bool-to-scheme-int y-981))))

(define (py-iadd-floatX-strY-fallback x-983 y-984)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for +=: 'float' and 'str'"))))

(define (py-iadd-floatX-sintY-fallback x-986 y-987)
  (py-float-from-scheme
   (py+ (py-float-to-scheme x-986) (py-sint-to-scheme y-987))))

(define (py-iadd-floatX-bintY-fallback x-989 y-990)
  (py-float-from-scheme
   (py+ (py-float-to-scheme x-989) (py-bint-to-scheme y-990))))

(define (py-iadd-boolX-floatY-fallback x-992 y-993)
  (py-float-from-scheme
   (py+ (py-bool-to-scheme-int x-992) (py-float-to-scheme y-993))))

(define (py-iadd-boolX-boolY-fallback x-995 y-996)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme-int x-995) (py-bool-to-scheme-int y-996))))

(define (py-iadd-boolX-strY-fallback x-998 y-999)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for +=: 'bool' and 'str'"))))

(define (py-iadd-boolX-sintY-fallback x-1001 y-1002)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme-int x-1001) (py-sint-to-scheme y-1002))))

(define (py-iadd-boolX-bintY-fallback x-1004 y-1005)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme-int x-1004) (py-bint-to-scheme y-1005))))

(define (py-iadd-strX-floatY-fallback x-1007 y-1008)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for +=: 'str' and 'float'"))))

(define (py-iadd-strX-boolY-fallback x-1010 y-1011)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for +=: 'str' and 'bool'"))))

(define (py-iadd-strX-strY-fallback x-1013 y-1014)
  (py-str-from-scheme
   (py+ (py-str-to-scheme x-1013) (py-str-to-scheme y-1014))))

(define (py-iadd-strX-sintY-fallback x-1016 y-1017)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for +=: 'str' and 'int'"))))

(define (py-iadd-strX-bintY-fallback x-1019 y-1020)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for +=: 'str' and 'int'"))))

(define (py-iadd-sintX-floatY-fallback x-1022 y-1023)
  (py-float-from-scheme
   (py+ (py-sint-to-scheme x-1022) (py-float-to-scheme y-1023))))

(define (py-iadd-sintX-boolY-fallback x-1025 y-1026)
  (py-int-from-scheme
   (py+ (py-sint-to-scheme x-1025) (py-bool-to-scheme-int y-1026))))

(define (py-iadd-sintX-strY-fallback x-1028 y-1029)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for +=: 'int' and 'str'"))))

(define (py-iadd-sintX-sintY-fallback x-1031 y-1032)
  (py-int-from-scheme
   (py+ (py-sint-to-scheme x-1031) (py-sint-to-scheme y-1032))))

(define (py-iadd-sintX-bintY-fallback x-1034 y-1035)
  (py-int-from-scheme
   (py+ (py-sint-to-scheme x-1034) (py-bint-to-scheme y-1035))))

(define (py-iadd-bintX-floatY-fallback x-1037 y-1038)
  (py-float-from-scheme
   (py+ (py-bint-to-scheme x-1037) (py-float-to-scheme y-1038))))

(define (py-iadd-bintX-boolY-fallback x-1040 y-1041)
  (py-int-from-scheme
   (py+ (py-bint-to-scheme x-1040) (py-bool-to-scheme-int y-1041))))

(define (py-iadd-bintX-strY-fallback x-1043 y-1044)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for +=: 'int' and 'str'"))))

(define (py-iadd-bintX-sintY-fallback x-1046 y-1047)
  (py-int-from-scheme
   (py+ (py-bint-to-scheme x-1046) (py-sint-to-scheme y-1047))))

(define (py-iadd-bintX-bintY-fallback x-1049 y-1050)
  (py-int-from-scheme
   (py+ (py-bint-to-scheme x-1049) (py-bint-to-scheme y-1050))))

(define (py-ibitand-floatX-floatY-fallback x-1052 y-1053)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'float' and 'float'"))))

(define (py-ibitand-floatX-boolY-fallback x-1055 y-1056)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'float' and 'bool'"))))

(define (py-ibitand-floatX-strY-fallback x-1058 y-1059)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'float' and 'str'"))))

(define (py-ibitand-floatX-sintY-fallback x-1061 y-1062)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'float' and 'int'"))))

(define (py-ibitand-floatX-bintY-fallback x-1064 y-1065)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'float' and 'int'"))))

(define (py-ibitand-boolX-floatY-fallback x-1067 y-1068)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'bool' and 'float'"))))

(define (py-ibitand-boolX-boolY-fallback x-1070 y-1071)
  (py-int-from-scheme
   (py& (py-bool-to-scheme-int x-1070) (py-bool-to-scheme-int y-1071))))

(define (py-ibitand-boolX-strY-fallback x-1073 y-1074)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'bool' and 'str'"))))

(define (py-ibitand-boolX-sintY-fallback x-1076 y-1077)
  (py-int-from-scheme
   (py& (py-bool-to-scheme-int x-1076) (py-sint-to-scheme y-1077))))

(define (py-ibitand-boolX-bintY-fallback x-1079 y-1080)
  (py-int-from-scheme
   (py& (py-bool-to-scheme-int x-1079) (py-bint-to-scheme y-1080))))

(define (py-ibitand-strX-floatY-fallback x-1082 y-1083)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'str' and 'float'"))))

(define (py-ibitand-strX-boolY-fallback x-1085 y-1086)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'str' and 'bool'"))))

(define (py-ibitand-strX-strY-fallback x-1088 y-1089)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'str' and 'str'"))))

(define (py-ibitand-strX-sintY-fallback x-1091 y-1092)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'str' and 'int'"))))

(define (py-ibitand-strX-bintY-fallback x-1094 y-1095)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'str' and 'int'"))))

(define (py-ibitand-sintX-floatY-fallback x-1097 y-1098)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'int' and 'float'"))))

(define (py-ibitand-sintX-boolY-fallback x-1100 y-1101)
  (py-int-from-scheme
   (py& (py-sint-to-scheme x-1100) (py-bool-to-scheme-int y-1101))))

(define (py-ibitand-sintX-strY-fallback x-1103 y-1104)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'int' and 'str'"))))

(define (py-ibitand-sintX-sintY-fallback x-1106 y-1107)
  (py-int-from-scheme
   (py& (py-sint-to-scheme x-1106) (py-sint-to-scheme y-1107))))

(define (py-ibitand-sintX-bintY-fallback x-1109 y-1110)
  (py-int-from-scheme
   (py& (py-sint-to-scheme x-1109) (py-bint-to-scheme y-1110))))

(define (py-ibitand-bintX-floatY-fallback x-1112 y-1113)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'int' and 'float'"))))

(define (py-ibitand-bintX-boolY-fallback x-1115 y-1116)
  (py-int-from-scheme
   (py& (py-bint-to-scheme x-1115) (py-bool-to-scheme-int y-1116))))

(define (py-ibitand-bintX-strY-fallback x-1118 y-1119)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'int' and 'str'"))))

(define (py-ibitand-bintX-sintY-fallback x-1121 y-1122)
  (py-int-from-scheme
   (py& (py-bint-to-scheme x-1121) (py-sint-to-scheme y-1122))))

(define (py-ibitand-bintX-bintY-fallback x-1124 y-1125)
  (py-int-from-scheme
   (py& (py-bint-to-scheme x-1124) (py-bint-to-scheme y-1125))))

(define (py-ibitor-floatX-floatY-fallback x-1127 y-1128)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'float' and 'float'"))))

(define (py-ibitor-floatX-boolY-fallback x-1130 y-1131)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'float' and 'bool'"))))

(define (py-ibitor-floatX-strY-fallback x-1133 y-1134)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'float' and 'str'"))))

(define (py-ibitor-floatX-sintY-fallback x-1136 y-1137)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'float' and 'int'"))))

(define (py-ibitor-floatX-bintY-fallback x-1139 y-1140)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'float' and 'int'"))))

(define (py-ibitor-boolX-floatY-fallback x-1142 y-1143)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'bool' and 'float'"))))

(define (py-ibitor-boolX-boolY-fallback x-1145 y-1146)
  (py-int-from-scheme
   (py+b (py-bool-to-scheme-int x-1145) (py-bool-to-scheme-int y-1146))))

(define (py-ibitor-boolX-strY-fallback x-1148 y-1149)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'bool' and 'str'"))))

(define (py-ibitor-boolX-sintY-fallback x-1151 y-1152)
  (py-int-from-scheme
   (py+b (py-bool-to-scheme-int x-1151) (py-sint-to-scheme y-1152))))

(define (py-ibitor-boolX-bintY-fallback x-1154 y-1155)
  (py-int-from-scheme
   (py+b (py-bool-to-scheme-int x-1154) (py-bint-to-scheme y-1155))))

(define (py-ibitor-strX-floatY-fallback x-1157 y-1158)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'str' and 'float'"))))

(define (py-ibitor-strX-boolY-fallback x-1160 y-1161)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'str' and 'bool'"))))

(define (py-ibitor-strX-strY-fallback x-1163 y-1164)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'str' and 'str'"))))

(define (py-ibitor-strX-sintY-fallback x-1166 y-1167)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'str' and 'int'"))))

(define (py-ibitor-strX-bintY-fallback x-1169 y-1170)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'str' and 'int'"))))

(define (py-ibitor-sintX-floatY-fallback x-1172 y-1173)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'int' and 'float'"))))

(define (py-ibitor-sintX-boolY-fallback x-1175 y-1176)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme x-1175) (py-bool-to-scheme-int y-1176))))

(define (py-ibitor-sintX-strY-fallback x-1178 y-1179)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'int' and 'str'"))))

(define (py-ibitor-sintX-sintY-fallback x-1181 y-1182)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme x-1181) (py-sint-to-scheme y-1182))))

(define (py-ibitor-sintX-bintY-fallback x-1184 y-1185)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme x-1184) (py-bint-to-scheme y-1185))))

(define (py-ibitor-bintX-floatY-fallback x-1187 y-1188)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'int' and 'float'"))))

(define (py-ibitor-bintX-boolY-fallback x-1190 y-1191)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme x-1190) (py-bool-to-scheme-int y-1191))))

(define (py-ibitor-bintX-strY-fallback x-1193 y-1194)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'int' and 'str'"))))

(define (py-ibitor-bintX-sintY-fallback x-1196 y-1197)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme x-1196) (py-sint-to-scheme y-1197))))

(define (py-ibitor-bintX-bintY-fallback x-1199 y-1200)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme x-1199) (py-bint-to-scheme y-1200))))

(define (py-ifloordiv-floatX-floatY-fallback x-1202 y-1203)
  (if (py-test (py-ne y-1203 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-float-to-scheme x-1202) (py-float-to-scheme y-1203)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-floatX-boolY-fallback x-1205 y-1206)
  (if (py-test (py-ne y-1206 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py// (py-float-to-scheme x-1205) (py-bool-to-scheme-int y-1206)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-floatX-strY-fallback x-1208 y-1209)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //=: 'float' and 'str'"))))

(define (py-ifloordiv-floatX-sintY-fallback x-1211 y-1212)
  (if (py-test (py-ne y-1212 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py// (py-float-to-scheme x-1211) (py-sint-to-scheme y-1212)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-floatX-bintY-fallback x-1214 y-1215)
  (py-float-from-scheme
   (py// (py-float-to-scheme x-1214) (py-bint-to-scheme y-1215))))

(define (py-ifloordiv-boolX-floatY-fallback x-1217 y-1218)
  (if (py-test (py-ne y-1218 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-bool-to-scheme-int x-1217) (py-float-to-scheme y-1218)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-boolX-boolY-fallback x-1220 y-1221)
  (if (py-test (py-ne y-1221 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bool-to-scheme-int x-1220) (py-bool-to-scheme-int y-1221)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-boolX-strY-fallback x-1223 y-1224)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //=: 'bool' and 'str'"))))

(define (py-ifloordiv-boolX-sintY-fallback x-1226 y-1227)
  (if (py-test (py-ne y-1227 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bool-to-scheme-int x-1226) (py-sint-to-scheme y-1227)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-boolX-bintY-fallback x-1229 y-1230)
  (py-int-from-scheme
   (py// (py-bool-to-scheme-int x-1229) (py-bint-to-scheme y-1230))))

(define (py-ifloordiv-strX-floatY-fallback x-1232 y-1233)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //=: 'str' and 'float'"))))

(define (py-ifloordiv-strX-boolY-fallback x-1235 y-1236)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //=: 'str' and 'bool'"))))

(define (py-ifloordiv-strX-strY-fallback x-1238 y-1239)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //=: 'str' and 'str'"))))

(define (py-ifloordiv-strX-sintY-fallback x-1241 y-1242)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //=: 'str' and 'int'"))))

(define (py-ifloordiv-strX-bintY-fallback x-1244 y-1245)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //=: 'str' and 'int'"))))

(define (py-ifloordiv-sintX-floatY-fallback x-1247 y-1248)
  (if (py-test (py-ne y-1248 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-sint-to-scheme x-1247) (py-float-to-scheme y-1248)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-sintX-boolY-fallback x-1250 y-1251)
  (if (py-test (py-ne y-1251 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-sint-to-scheme x-1250) (py-bool-to-scheme-int y-1251)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-sintX-strY-fallback x-1253 y-1254)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //=: 'int' and 'str'"))))

(define (py-ifloordiv-sintX-sintY-fallback x-1256 y-1257)
  (if (py-test (py-ne y-1257 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-sint-to-scheme x-1256) (py-sint-to-scheme y-1257)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-sintX-bintY-fallback x-1259 y-1260)
  (py-int-from-scheme
   (py// (py-sint-to-scheme x-1259) (py-bint-to-scheme y-1260))))

(define (py-ifloordiv-bintX-floatY-fallback x-1262 y-1263)
  (if (py-test (py-ne y-1263 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-bint-to-scheme x-1262) (py-float-to-scheme y-1263)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-bintX-boolY-fallback x-1265 y-1266)
  (if (py-test (py-ne y-1266 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bint-to-scheme x-1265) (py-bool-to-scheme-int y-1266)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-bintX-strY-fallback x-1268 y-1269)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //=: 'int' and 'str'"))))

(define (py-ifloordiv-bintX-sintY-fallback x-1271 y-1272)
  (if (py-test (py-ne y-1272 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bint-to-scheme x-1271) (py-sint-to-scheme y-1272)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-bintX-bintY-fallback x-1274 y-1275)
  (py-int-from-scheme
   (py// (py-bint-to-scheme x-1274) (py-bint-to-scheme y-1275))))

(define (py-ilshift-floatX-floatY-fallback x-1277 y-1278)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'float' and 'float'"))))

(define (py-ilshift-floatX-boolY-fallback x-1280 y-1281)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'float' and 'bool'"))))

(define (py-ilshift-floatX-strY-fallback x-1283 y-1284)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'float' and 'str'"))))

(define (py-ilshift-floatX-sintY-fallback x-1286 y-1287)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'float' and 'int'"))))

(define (py-ilshift-floatX-bintY-fallback x-1289 y-1290)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'float' and 'int'"))))

(define (py-ilshift-boolX-floatY-fallback x-1292 y-1293)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'bool' and 'float'"))))

(define (py-ilshift-boolX-boolY-fallback x-1295 y-1296)
  (if (py-test (py-ge y-1296 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bool-to-scheme-int x-1295) (py-bool-to-scheme-int y-1296)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-boolX-strY-fallback x-1298 y-1299)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'bool' and 'str'"))))

(define (py-ilshift-boolX-sintY-fallback x-1301 y-1302)
  (if (py-test (py-ge y-1302 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bool-to-scheme-int x-1301) (py-sint-to-scheme y-1302)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-boolX-bintY-fallback x-1304 y-1305)
  (if (py-test (py-ge y-1305 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bool-to-scheme-int x-1304) (py-bint-to-scheme y-1305)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-strX-floatY-fallback x-1307 y-1308)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'str' and 'float'"))))

(define (py-ilshift-strX-boolY-fallback x-1310 y-1311)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'str' and 'bool'"))))

(define (py-ilshift-strX-strY-fallback x-1313 y-1314)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'str' and 'str'"))))

(define (py-ilshift-strX-sintY-fallback x-1316 y-1317)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'str' and 'int'"))))

(define (py-ilshift-strX-bintY-fallback x-1319 y-1320)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'str' and 'int'"))))

(define (py-ilshift-sintX-floatY-fallback x-1322 y-1323)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'int' and 'float'"))))

(define (py-ilshift-sintX-boolY-fallback x-1325 y-1326)
  (if (py-test (py-ge y-1326 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-sint-to-scheme x-1325) (py-bool-to-scheme-int y-1326)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-sintX-strY-fallback x-1328 y-1329)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'int' and 'str'"))))

(define (py-ilshift-sintX-sintY-fallback x-1331 y-1332)
  (if (py-test (py-ge y-1332 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-sint-to-scheme x-1331) (py-sint-to-scheme y-1332)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-sintX-bintY-fallback x-1334 y-1335)
  (if (py-test (py-ge y-1335 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-sint-to-scheme x-1334) (py-bint-to-scheme y-1335)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-bintX-floatY-fallback x-1337 y-1338)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'int' and 'float'"))))

(define (py-ilshift-bintX-boolY-fallback x-1340 y-1341)
  (if (py-test (py-ge y-1341 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bint-to-scheme x-1340) (py-bool-to-scheme-int y-1341)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-bintX-strY-fallback x-1343 y-1344)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'int' and 'str'"))))

(define (py-ilshift-bintX-sintY-fallback x-1346 y-1347)
  (if (py-test (py-ge y-1347 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bint-to-scheme x-1346) (py-sint-to-scheme y-1347)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-bintX-bintY-fallback x-1349 y-1350)
  (if (py-test (py-ge y-1350 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bint-to-scheme x-1349) (py-bint-to-scheme y-1350)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-imatmul-floatX-floatY-fallback x-1352 y-1353)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'float' and 'float'"))))

(define (py-imatmul-floatX-boolY-fallback x-1355 y-1356)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'float' and 'bool'"))))

(define (py-imatmul-floatX-strY-fallback x-1358 y-1359)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'float' and 'str'"))))

(define (py-imatmul-floatX-sintY-fallback x-1361 y-1362)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'float' and 'int'"))))

(define (py-imatmul-floatX-bintY-fallback x-1364 y-1365)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'float' and 'int'"))))

(define (py-imatmul-boolX-floatY-fallback x-1367 y-1368)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'bool' and 'float'"))))

(define (py-imatmul-boolX-boolY-fallback x-1370 y-1371)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'bool' and 'bool'"))))

(define (py-imatmul-boolX-strY-fallback x-1373 y-1374)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'bool' and 'str'"))))

(define (py-imatmul-boolX-sintY-fallback x-1376 y-1377)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'bool' and 'int'"))))

(define (py-imatmul-boolX-bintY-fallback x-1379 y-1380)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'bool' and 'int'"))))

(define (py-imatmul-strX-floatY-fallback x-1382 y-1383)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'str' and 'float'"))))

(define (py-imatmul-strX-boolY-fallback x-1385 y-1386)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'str' and 'bool'"))))

(define (py-imatmul-strX-strY-fallback x-1388 y-1389)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'str' and 'str'"))))

(define (py-imatmul-strX-sintY-fallback x-1391 y-1392)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'str' and 'int'"))))

(define (py-imatmul-strX-bintY-fallback x-1394 y-1395)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'str' and 'int'"))))

(define (py-imatmul-sintX-floatY-fallback x-1397 y-1398)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'float'"))))

(define (py-imatmul-sintX-boolY-fallback x-1400 y-1401)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'bool'"))))

(define (py-imatmul-sintX-strY-fallback x-1403 y-1404)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'str'"))))

(define (py-imatmul-sintX-sintY-fallback x-1406 y-1407)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'int'"))))

(define (py-imatmul-sintX-bintY-fallback x-1409 y-1410)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'int'"))))

(define (py-imatmul-bintX-floatY-fallback x-1412 y-1413)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'float'"))))

(define (py-imatmul-bintX-boolY-fallback x-1415 y-1416)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'bool'"))))

(define (py-imatmul-bintX-strY-fallback x-1418 y-1419)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'str'"))))

(define (py-imatmul-bintX-sintY-fallback x-1421 y-1422)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'int'"))))

(define (py-imatmul-bintX-bintY-fallback x-1424 y-1425)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'int'"))))

(define (py-imod-floatX-floatY-fallback x-1427 y-1428)
  (if (py-test (py-ne y-1428 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-float-to-scheme x-1427) (py-float-to-scheme y-1428)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-floatX-boolY-fallback x-1430 y-1431)
  (if (py-test (py-ne y-1431 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py% (py-float-to-scheme x-1430) (py-bool-to-scheme-int y-1431)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-floatX-strY-fallback x-1433 y-1434)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %=: 'float' and 'str'"))))

(define (py-imod-floatX-sintY-fallback x-1436 y-1437)
  (if (py-test (py-ne y-1437 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py% (py-float-to-scheme x-1436) (py-sint-to-scheme y-1437)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-floatX-bintY-fallback x-1439 y-1440)
  (py-float-from-scheme
   (py% (py-float-to-scheme x-1439) (py-bint-to-scheme y-1440))))

(define (py-imod-boolX-floatY-fallback x-1442 y-1443)
  (if (py-test (py-ne y-1443 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-bool-to-scheme-int x-1442) (py-float-to-scheme y-1443)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-boolX-boolY-fallback x-1445 y-1446)
  (if (py-test (py-ne y-1446 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bool-to-scheme-int x-1445) (py-bool-to-scheme-int y-1446)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-boolX-strY-fallback x-1448 y-1449)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %=: 'bool' and 'str'"))))

(define (py-imod-boolX-sintY-fallback x-1451 y-1452)
  (if (py-test (py-ne y-1452 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bool-to-scheme-int x-1451) (py-sint-to-scheme y-1452)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-boolX-bintY-fallback x-1454 y-1455)
  (py-int-from-scheme
   (py% (py-bool-to-scheme-int x-1454) (py-bint-to-scheme y-1455))))

(define (py-imod-strX-floatY-fallback x-1457 y-1458)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %=: 'str' and 'float'"))))

(define (py-imod-strX-boolY-fallback x-1460 y-1461)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %=: 'str' and 'bool'"))))

(define (py-imod-strX-strY-fallback x-1463 y-1464)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %=: 'str' and 'str'"))))

(define (py-imod-strX-sintY-fallback x-1466 y-1467)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %=: 'str' and 'int'"))))

(define (py-imod-strX-bintY-fallback x-1469 y-1470)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %=: 'str' and 'int'"))))

(define (py-imod-sintX-floatY-fallback x-1472 y-1473)
  (if (py-test (py-ne y-1473 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-sint-to-scheme x-1472) (py-float-to-scheme y-1473)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-sintX-boolY-fallback x-1475 y-1476)
  (if (py-test (py-ne y-1476 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-sint-to-scheme x-1475) (py-bool-to-scheme-int y-1476)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-sintX-strY-fallback x-1478 y-1479)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %=: 'int' and 'str'"))))

(define (py-imod-sintX-sintY-fallback x-1481 y-1482)
  (if (py-test (py-ne y-1482 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-sint-to-scheme x-1481) (py-sint-to-scheme y-1482)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-sintX-bintY-fallback x-1484 y-1485)
  (py-int-from-scheme
   (py% (py-sint-to-scheme x-1484) (py-bint-to-scheme y-1485))))

(define (py-imod-bintX-floatY-fallback x-1487 y-1488)
  (if (py-test (py-ne y-1488 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-bint-to-scheme x-1487) (py-float-to-scheme y-1488)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-bintX-boolY-fallback x-1490 y-1491)
  (if (py-test (py-ne y-1491 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bint-to-scheme x-1490) (py-bool-to-scheme-int y-1491)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-bintX-strY-fallback x-1493 y-1494)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %=: 'int' and 'str'"))))

(define (py-imod-bintX-sintY-fallback x-1496 y-1497)
  (if (py-test (py-ne y-1497 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bint-to-scheme x-1496) (py-sint-to-scheme y-1497)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-bintX-bintY-fallback x-1499 y-1500)
  (py-int-from-scheme
   (py% (py-bint-to-scheme x-1499) (py-bint-to-scheme y-1500))))

(define (py-imul-floatX-floatY-fallback x-1502 y-1503)
  (py-float-from-scheme
   (py* (py-float-to-scheme x-1502) (py-float-to-scheme y-1503))))

(define (py-imul-floatX-boolY-fallback x-1505 y-1506)
  (py-float-from-scheme
   (py* (py-float-to-scheme x-1505) (py-bool-to-scheme-int y-1506))))

(define (py-imul-floatX-strY-fallback x-1508 y-1509)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for *=: 'float' and 'str'"))))

(define (py-imul-floatX-sintY-fallback x-1511 y-1512)
  (py-float-from-scheme
   (py* (py-float-to-scheme x-1511) (py-sint-to-scheme y-1512))))

(define (py-imul-floatX-bintY-fallback x-1514 y-1515)
  (py-float-from-scheme
   (py* (py-float-to-scheme x-1514) (py-bint-to-scheme y-1515))))

(define (py-imul-boolX-floatY-fallback x-1517 y-1518)
  (py-float-from-scheme
   (py* (py-bool-to-scheme-int x-1517) (py-float-to-scheme y-1518))))

(define (py-imul-boolX-boolY-fallback x-1520 y-1521)
  (py-int-from-scheme
   (py* (py-bool-to-scheme-int x-1520) (py-bool-to-scheme-int y-1521))))

(define (py-imul-boolX-strY-fallback x-1523 y-1524)
  (py-str-from-scheme
   (py* (py-str-to-scheme y-1524) (py-bool-to-scheme-int x-1523))))

(define (py-imul-boolX-sintY-fallback x-1526 y-1527)
  (py-int-from-scheme
   (py* (py-bool-to-scheme-int x-1526) (py-sint-to-scheme y-1527))))

(define (py-imul-boolX-bintY-fallback x-1529 y-1530)
  (py-int-from-scheme
   (py* (py-bool-to-scheme-int x-1529) (py-bint-to-scheme y-1530))))

(define (py-imul-strX-floatY-fallback x-1532 y-1533)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for *=: 'str' and 'float'"))))

(define (py-imul-strX-boolY-fallback x-1535 y-1536)
  (py-str-from-scheme
   (py* (py-str-to-scheme x-1535) (py-bool-to-scheme-int y-1536))))

(define (py-imul-strX-strY-fallback x-1538 y-1539)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for *=: 'str' and 'str'"))))

(define (py-imul-strX-sintY-fallback x-1541 y-1542)
  (py-str-from-scheme
   (py* (py-str-to-scheme x-1541) (py-sint-to-scheme y-1542))))

(define (py-imul-strX-bintY-fallback x-1544 y-1545)
  (py-str-from-scheme
   (py* (py-str-to-scheme x-1544) (py-bint-to-scheme y-1545))))

(define (py-imul-sintX-floatY-fallback x-1547 y-1548)
  (py-float-from-scheme
   (py* (py-sint-to-scheme x-1547) (py-float-to-scheme y-1548))))

(define (py-imul-sintX-boolY-fallback x-1550 y-1551)
  (py-int-from-scheme
   (py* (py-sint-to-scheme x-1550) (py-bool-to-scheme-int y-1551))))

(define (py-imul-sintX-strY-fallback x-1553 y-1554)
  (py-str-from-scheme
   (py* (py-str-to-scheme y-1554) (py-sint-to-scheme x-1553))))

(define (py-imul-sintX-sintY-fallback x-1556 y-1557)
  (py-int-from-scheme
   (py* (py-sint-to-scheme x-1556) (py-sint-to-scheme y-1557))))

(define (py-imul-sintX-bintY-fallback x-1559 y-1560)
  (py-int-from-scheme
   (py* (py-sint-to-scheme x-1559) (py-bint-to-scheme y-1560))))

(define (py-imul-bintX-floatY-fallback x-1562 y-1563)
  (py-float-from-scheme
   (py* (py-bint-to-scheme x-1562) (py-float-to-scheme y-1563))))

(define (py-imul-bintX-boolY-fallback x-1565 y-1566)
  (py-int-from-scheme
   (py* (py-bint-to-scheme x-1565) (py-bool-to-scheme-int y-1566))))

(define (py-imul-bintX-strY-fallback x-1568 y-1569)
  (py-str-from-scheme
   (py* (py-str-to-scheme y-1569) (py-bint-to-scheme x-1568))))

(define (py-imul-bintX-sintY-fallback x-1571 y-1572)
  (py-int-from-scheme
   (py* (py-bint-to-scheme x-1571) (py-sint-to-scheme y-1572))))

(define (py-imul-bintX-bintY-fallback x-1574 y-1575)
  (py-int-from-scheme
   (py* (py-bint-to-scheme x-1574) (py-bint-to-scheme y-1575))))

(define (py-ipow-floatX-floatY-fallback x-1577 y-1578)
  (py-float-from-scheme
   (py** (py-float-to-scheme x-1577) (py-float-to-scheme y-1578))))

(define (py-ipow-floatX-boolY-fallback x-1580 y-1581)
  (py-float-from-scheme
   (py** (py-float-to-scheme x-1580) (py-bool-to-scheme-int y-1581))))

(define (py-ipow-floatX-strY-fallback x-1583 y-1584)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **=: 'float' and 'str'"))))

(define (py-ipow-floatX-sintY-fallback x-1586 y-1587)
  (py-float-from-scheme
   (py** (py-float-to-scheme x-1586) (py-sint-to-scheme y-1587))))

(define (py-ipow-floatX-bintY-fallback x-1589 y-1590)
  (py-float-from-scheme
   (py** (py-float-to-scheme x-1589) (py-bint-to-scheme y-1590))))

(define (py-ipow-boolX-floatY-fallback x-1592 y-1593)
  (py-float-from-scheme
   (py** (py-bool-to-scheme-int x-1592) (py-float-to-scheme y-1593))))

(define (py-ipow-boolX-boolY-fallback x-1595 y-1596)
  (py-int-from-scheme
   (py** (py-bool-to-scheme-int x-1595) (py-bool-to-scheme-int y-1596))))

(define (py-ipow-boolX-strY-fallback x-1598 y-1599)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **=: 'bool' and 'str'"))))

(define (py-ipow-boolX-sintY-fallback x-1601 y-1602)
  (py-int-from-scheme
   (py** (py-bool-to-scheme-int x-1601) (py-sint-to-scheme y-1602))))

(define (py-ipow-boolX-bintY-fallback x-1604 y-1605)
  (py-int-from-scheme
   (py** (py-bool-to-scheme-int x-1604) (py-bint-to-scheme y-1605))))

(define (py-ipow-strX-floatY-fallback x-1607 y-1608)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **=: 'str' and 'float'"))))

(define (py-ipow-strX-boolY-fallback x-1610 y-1611)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **=: 'str' and 'bool'"))))

(define (py-ipow-strX-strY-fallback x-1613 y-1614)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **=: 'str' and 'str'"))))

(define (py-ipow-strX-sintY-fallback x-1616 y-1617)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **=: 'str' and 'int'"))))

(define (py-ipow-strX-bintY-fallback x-1619 y-1620)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **=: 'str' and 'int'"))))

(define (py-ipow-sintX-floatY-fallback x-1622 y-1623)
  (py-float-from-scheme
   (py** (py-sint-to-scheme x-1622) (py-float-to-scheme y-1623))))

(define (py-ipow-sintX-boolY-fallback x-1625 y-1626)
  (py-int-from-scheme
   (py** (py-sint-to-scheme x-1625) (py-bool-to-scheme-int y-1626))))

(define (py-ipow-sintX-strY-fallback x-1628 y-1629)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **=: 'int' and 'str'"))))

(define (py-ipow-sintX-sintY-fallback x-1631 y-1632)
  (py-int-from-scheme
   (py** (py-sint-to-scheme x-1631) (py-sint-to-scheme y-1632))))

(define (py-ipow-sintX-bintY-fallback x-1634 y-1635)
  (py-int-from-scheme
   (py** (py-sint-to-scheme x-1634) (py-bint-to-scheme y-1635))))

(define (py-ipow-bintX-floatY-fallback x-1637 y-1638)
  (py-float-from-scheme
   (py** (py-bint-to-scheme x-1637) (py-float-to-scheme y-1638))))

(define (py-ipow-bintX-boolY-fallback x-1640 y-1641)
  (py-int-from-scheme
   (py** (py-bint-to-scheme x-1640) (py-bool-to-scheme-int y-1641))))

(define (py-ipow-bintX-strY-fallback x-1643 y-1644)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **=: 'int' and 'str'"))))

(define (py-ipow-bintX-sintY-fallback x-1646 y-1647)
  (py-int-from-scheme
   (py** (py-bint-to-scheme x-1646) (py-sint-to-scheme y-1647))))

(define (py-ipow-bintX-bintY-fallback x-1649 y-1650)
  (py-int-from-scheme
   (py** (py-bint-to-scheme x-1649) (py-bint-to-scheme y-1650))))

(define (py-irshift-floatX-floatY-fallback x-1652 y-1653)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'float' and 'float'"))))

(define (py-irshift-floatX-boolY-fallback x-1655 y-1656)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'float' and 'bool'"))))

(define (py-irshift-floatX-strY-fallback x-1658 y-1659)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'float' and 'str'"))))

(define (py-irshift-floatX-sintY-fallback x-1661 y-1662)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'float' and 'int'"))))

(define (py-irshift-floatX-bintY-fallback x-1664 y-1665)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'float' and 'int'"))))

(define (py-irshift-boolX-floatY-fallback x-1667 y-1668)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'bool' and 'float'"))))

(define (py-irshift-boolX-boolY-fallback x-1670 y-1671)
  (if (py-test (py-ge y-1671 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bool-to-scheme-int x-1670) (py-bool-to-scheme-int y-1671)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-boolX-strY-fallback x-1673 y-1674)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'bool' and 'str'"))))

(define (py-irshift-boolX-sintY-fallback x-1676 y-1677)
  (if (py-test (py-ge y-1677 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bool-to-scheme-int x-1676) (py-sint-to-scheme y-1677)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-boolX-bintY-fallback x-1679 y-1680)
  (if (py-test (py-ge y-1680 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bool-to-scheme-int x-1679) (py-bint-to-scheme y-1680)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-strX-floatY-fallback x-1682 y-1683)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'str' and 'float'"))))

(define (py-irshift-strX-boolY-fallback x-1685 y-1686)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'str' and 'bool'"))))

(define (py-irshift-strX-strY-fallback x-1688 y-1689)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'str' and 'str'"))))

(define (py-irshift-strX-sintY-fallback x-1691 y-1692)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'str' and 'int'"))))

(define (py-irshift-strX-bintY-fallback x-1694 y-1695)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'str' and 'int'"))))

(define (py-irshift-sintX-floatY-fallback x-1697 y-1698)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'int' and 'float'"))))

(define (py-irshift-sintX-boolY-fallback x-1700 y-1701)
  (if (py-test (py-ge y-1701 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-sint-to-scheme x-1700) (py-bool-to-scheme-int y-1701)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-sintX-strY-fallback x-1703 y-1704)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'int' and 'str'"))))

(define (py-irshift-sintX-sintY-fallback x-1706 y-1707)
  (if (py-test (py-ge y-1707 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-sint-to-scheme x-1706) (py-sint-to-scheme y-1707)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-sintX-bintY-fallback x-1709 y-1710)
  (if (py-test (py-ge y-1710 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-sint-to-scheme x-1709) (py-bint-to-scheme y-1710)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-bintX-floatY-fallback x-1712 y-1713)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'int' and 'float'"))))

(define (py-irshift-bintX-boolY-fallback x-1715 y-1716)
  (if (py-test (py-ge y-1716 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bint-to-scheme x-1715) (py-bool-to-scheme-int y-1716)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-bintX-strY-fallback x-1718 y-1719)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'int' and 'str'"))))

(define (py-irshift-bintX-sintY-fallback x-1721 y-1722)
  (if (py-test (py-ge y-1722 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bint-to-scheme x-1721) (py-sint-to-scheme y-1722)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-bintX-bintY-fallback x-1724 y-1725)
  (if (py-test (py-ge y-1725 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bint-to-scheme x-1724) (py-bint-to-scheme y-1725)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-isub-floatX-floatY-fallback x-1727 y-1728)
  (py-float-from-scheme
   (py- (py-float-to-scheme x-1727) (py-float-to-scheme y-1728))))

(define (py-isub-floatX-boolY-fallback x-1730 y-1731)
  (py-float-from-scheme
   (py- (py-float-to-scheme x-1730) (py-bool-to-scheme-int y-1731))))

(define (py-isub-floatX-strY-fallback x-1733 y-1734)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -=: 'float' and 'str'"))))

(define (py-isub-floatX-sintY-fallback x-1736 y-1737)
  (py-float-from-scheme
   (py- (py-float-to-scheme x-1736) (py-sint-to-scheme y-1737))))

(define (py-isub-floatX-bintY-fallback x-1739 y-1740)
  (py-float-from-scheme
   (py- (py-float-to-scheme x-1739) (py-bint-to-scheme y-1740))))

(define (py-isub-boolX-floatY-fallback x-1742 y-1743)
  (py-float-from-scheme
   (py- (py-bool-to-scheme-int x-1742) (py-float-to-scheme y-1743))))

(define (py-isub-boolX-boolY-fallback x-1745 y-1746)
  (py-int-from-scheme
   (py- (py-bool-to-scheme-int x-1745) (py-bool-to-scheme-int y-1746))))

(define (py-isub-boolX-strY-fallback x-1748 y-1749)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -=: 'bool' and 'str'"))))

(define (py-isub-boolX-sintY-fallback x-1751 y-1752)
  (py-int-from-scheme
   (py- (py-bool-to-scheme-int x-1751) (py-sint-to-scheme y-1752))))

(define (py-isub-boolX-bintY-fallback x-1754 y-1755)
  (py-int-from-scheme
   (py- (py-bool-to-scheme-int x-1754) (py-bint-to-scheme y-1755))))

(define (py-isub-strX-floatY-fallback x-1757 y-1758)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -=: 'str' and 'float'"))))

(define (py-isub-strX-boolY-fallback x-1760 y-1761)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -=: 'str' and 'bool'"))))

(define (py-isub-strX-strY-fallback x-1763 y-1764)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -=: 'str' and 'str'"))))

(define (py-isub-strX-sintY-fallback x-1766 y-1767)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -=: 'str' and 'int'"))))

(define (py-isub-strX-bintY-fallback x-1769 y-1770)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -=: 'str' and 'int'"))))

(define (py-isub-sintX-floatY-fallback x-1772 y-1773)
  (py-float-from-scheme
   (py- (py-sint-to-scheme x-1772) (py-float-to-scheme y-1773))))

(define (py-isub-sintX-boolY-fallback x-1775 y-1776)
  (py-int-from-scheme
   (py- (py-sint-to-scheme x-1775) (py-bool-to-scheme-int y-1776))))

(define (py-isub-sintX-strY-fallback x-1778 y-1779)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -=: 'int' and 'str'"))))

(define (py-isub-sintX-sintY-fallback x-1781 y-1782)
  (py-int-from-scheme
   (py- (py-sint-to-scheme x-1781) (py-sint-to-scheme y-1782))))

(define (py-isub-sintX-bintY-fallback x-1784 y-1785)
  (py-int-from-scheme
   (py- (py-sint-to-scheme x-1784) (py-bint-to-scheme y-1785))))

(define (py-isub-bintX-floatY-fallback x-1787 y-1788)
  (py-float-from-scheme
   (py- (py-bint-to-scheme x-1787) (py-float-to-scheme y-1788))))

(define (py-isub-bintX-boolY-fallback x-1790 y-1791)
  (py-int-from-scheme
   (py- (py-bint-to-scheme x-1790) (py-bool-to-scheme-int y-1791))))

(define (py-isub-bintX-strY-fallback x-1793 y-1794)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -=: 'int' and 'str'"))))

(define (py-isub-bintX-sintY-fallback x-1796 y-1797)
  (py-int-from-scheme
   (py- (py-bint-to-scheme x-1796) (py-sint-to-scheme y-1797))))

(define (py-isub-bintX-bintY-fallback x-1799 y-1800)
  (py-int-from-scheme
   (py- (py-bint-to-scheme x-1799) (py-bint-to-scheme y-1800))))

(define (py-itruediv-floatX-floatY-fallback x-1802 y-1803)
  (if (py-test (py-ne y-1803 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme x-1802) (py-float-to-scheme y-1803)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-floatX-boolY-fallback x-1805 y-1806)
  (if (py-test (py-ne y-1806 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme x-1805) (py-bool-to-scheme-int y-1806)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-floatX-strY-fallback x-1808 y-1809)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /=: 'float' and 'str'"))))

(define (py-itruediv-floatX-sintY-fallback x-1811 y-1812)
  (if (py-test (py-ne y-1812 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme x-1811) (py-sint-to-scheme y-1812)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-floatX-bintY-fallback x-1814 y-1815)
  (py-float-from-scheme
   (py/ (py-float-to-scheme x-1814) (py-bint-to-scheme y-1815))))

(define (py-itruediv-boolX-floatY-fallback x-1817 y-1818)
  (if (py-test (py-ne y-1818 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme-int x-1817) (py-float-to-scheme y-1818)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-boolX-boolY-fallback x-1820 y-1821)
  (if (py-test (py-ne y-1821 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme-int x-1820) (py-bool-to-scheme-int y-1821)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-boolX-strY-fallback x-1823 y-1824)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /=: 'bool' and 'str'"))))

(define (py-itruediv-boolX-sintY-fallback x-1826 y-1827)
  (if (py-test (py-ne y-1827 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme-int x-1826) (py-sint-to-scheme y-1827)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-boolX-bintY-fallback x-1829 y-1830)
  (py-float-from-scheme
   (py/ (py-bool-to-scheme-int x-1829) (py-bint-to-scheme y-1830))))

(define (py-itruediv-strX-floatY-fallback x-1832 y-1833)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /=: 'str' and 'float'"))))

(define (py-itruediv-strX-boolY-fallback x-1835 y-1836)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /=: 'str' and 'bool'"))))

(define (py-itruediv-strX-strY-fallback x-1838 y-1839)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /=: 'str' and 'str'"))))

(define (py-itruediv-strX-sintY-fallback x-1841 y-1842)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /=: 'str' and 'int'"))))

(define (py-itruediv-strX-bintY-fallback x-1844 y-1845)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /=: 'str' and 'int'"))))

(define (py-itruediv-sintX-floatY-fallback x-1847 y-1848)
  (if (py-test (py-ne y-1848 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme x-1847) (py-float-to-scheme y-1848)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-sintX-boolY-fallback x-1850 y-1851)
  (if (py-test (py-ne y-1851 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme x-1850) (py-bool-to-scheme-int y-1851)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-sintX-strY-fallback x-1853 y-1854)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /=: 'int' and 'str'"))))

(define (py-itruediv-sintX-sintY-fallback x-1856 y-1857)
  (if (py-test (py-ne y-1857 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme x-1856) (py-sint-to-scheme y-1857)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-sintX-bintY-fallback x-1859 y-1860)
  (py-float-from-scheme
   (py/ (py-sint-to-scheme x-1859) (py-bint-to-scheme y-1860))))

(define (py-itruediv-bintX-floatY-fallback x-1862 y-1863)
  (if (py-test (py-ne y-1863 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme x-1862) (py-float-to-scheme y-1863)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-bintX-boolY-fallback x-1865 y-1866)
  (if (py-test (py-ne y-1866 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme x-1865) (py-bool-to-scheme-int y-1866)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-bintX-strY-fallback x-1868 y-1869)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /=: 'int' and 'str'"))))

(define (py-itruediv-bintX-sintY-fallback x-1871 y-1872)
  (if (py-test (py-ne y-1872 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme x-1871) (py-sint-to-scheme y-1872)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-bintX-bintY-fallback x-1874 y-1875)
  (py-float-from-scheme
   (py/ (py-bint-to-scheme x-1874) (py-bint-to-scheme y-1875))))

(define (py-ixor-floatX-floatY-fallback x-1877 y-1878)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'float' and 'float'"))))

(define (py-ixor-floatX-boolY-fallback x-1880 y-1881)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'float' and 'bool'"))))

(define (py-ixor-floatX-strY-fallback x-1883 y-1884)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'float' and 'str'"))))

(define (py-ixor-floatX-sintY-fallback x-1886 y-1887)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'float' and 'int'"))))

(define (py-ixor-floatX-bintY-fallback x-1889 y-1890)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'float' and 'int'"))))

(define (py-ixor-boolX-floatY-fallback x-1892 y-1893)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'bool' and 'float'"))))

(define (py-ixor-boolX-boolY-fallback x-1895 y-1896)
  (py-int-from-scheme
   (py^ (py-bool-to-scheme-int x-1895) (py-bool-to-scheme-int y-1896))))

(define (py-ixor-boolX-strY-fallback x-1898 y-1899)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'bool' and 'str'"))))

(define (py-ixor-boolX-sintY-fallback x-1901 y-1902)
  (py-int-from-scheme
   (py^ (py-bool-to-scheme-int x-1901) (py-sint-to-scheme y-1902))))

(define (py-ixor-boolX-bintY-fallback x-1904 y-1905)
  (py-int-from-scheme
   (py^ (py-bool-to-scheme-int x-1904) (py-bint-to-scheme y-1905))))

(define (py-ixor-strX-floatY-fallback x-1907 y-1908)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'str' and 'float'"))))

(define (py-ixor-strX-boolY-fallback x-1910 y-1911)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'str' and 'bool'"))))

(define (py-ixor-strX-strY-fallback x-1913 y-1914)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'str' and 'str'"))))

(define (py-ixor-strX-sintY-fallback x-1916 y-1917)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'str' and 'int'"))))

(define (py-ixor-strX-bintY-fallback x-1919 y-1920)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'str' and 'int'"))))

(define (py-ixor-sintX-floatY-fallback x-1922 y-1923)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'int' and 'float'"))))

(define (py-ixor-sintX-boolY-fallback x-1925 y-1926)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme x-1925) (py-bool-to-scheme-int y-1926))))

(define (py-ixor-sintX-strY-fallback x-1928 y-1929)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'int' and 'str'"))))

(define (py-ixor-sintX-sintY-fallback x-1931 y-1932)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme x-1931) (py-sint-to-scheme y-1932))))

(define (py-ixor-sintX-bintY-fallback x-1934 y-1935)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme x-1934) (py-bint-to-scheme y-1935))))

(define (py-ixor-bintX-floatY-fallback x-1937 y-1938)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'int' and 'float'"))))

(define (py-ixor-bintX-boolY-fallback x-1940 y-1941)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme x-1940) (py-bool-to-scheme-int y-1941))))

(define (py-ixor-bintX-strY-fallback x-1943 y-1944)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'int' and 'str'"))))

(define (py-ixor-bintX-sintY-fallback x-1946 y-1947)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme x-1946) (py-sint-to-scheme y-1947))))

(define (py-ixor-bintX-bintY-fallback x-1949 y-1950)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme x-1949) (py-bint-to-scheme y-1950))))

(define (py-ge-floatX-floatY-fallback x-1952 y-1953)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-float-to-scheme x-1952) (py-float-to-scheme y-1953)))))

(define (py-test-ge-floatX-floatY-fallback x-1955 y-1956)
  (py-test-from-scheme
   (py>= (py-float-to-scheme x-1955) (py-float-to-scheme y-1956))))

(define (py-ge-floatX-boolY-fallback x-1958 y-1959)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-float-to-scheme x-1958) (py-bool-to-scheme-int y-1959)))))

(define (py-test-ge-floatX-boolY-fallback x-1961 y-1962)
  (py-test-from-scheme
   (py>= (py-float-to-scheme x-1961) (py-bool-to-scheme-int y-1962))))

(define (py-ge-floatX-strY-fallback x-1964 y-1965)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>=' not supported between instances of 'float' and 'str'"))))

(define (py-test-ge-floatX-strY-fallback x-1967 y-1968)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>=' not supported between instances of 'float' and 'str'"))))

(define (py-ge-floatX-sintY-fallback x-1970 y-1971)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-float-to-scheme x-1970) (py-sint-to-scheme y-1971)))))

(define (py-test-ge-floatX-sintY-fallback x-1973 y-1974)
  (py-test-from-scheme
   (py>= (py-float-to-scheme x-1973) (py-sint-to-scheme y-1974))))

(define (py-ge-floatX-bintY-fallback x-1976 y-1977)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-float-to-scheme x-1976) (py-bint-to-scheme y-1977)))))

(define (py-test-ge-floatX-bintY-fallback x-1979 y-1980)
  (py-test-from-scheme
   (py>= (py-float-to-scheme x-1979) (py-bint-to-scheme y-1980))))

(define (py-ge-boolX-floatY-fallback x-1982 y-1983)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-float-to-scheme y-1983) (py-bool-to-scheme-int x-1982)))))

(define (py-test-ge-boolX-floatY-fallback x-1985 y-1986)
  (py-test-from-scheme
   (py<= (py-float-to-scheme y-1986) (py-bool-to-scheme-int x-1985))))

(define (py-ge-boolX-boolY-fallback x-1988 y-1989)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-bool-to-scheme-int x-1988) (py-bool-to-scheme-int y-1989)))))

(define (py-test-ge-boolX-boolY-fallback x-1991 y-1992)
  (py-test-from-scheme
   (py>= (py-bool-to-scheme-int x-1991) (py-bool-to-scheme-int y-1992))))

(define (py-ge-boolX-strY-fallback x-1994 y-1995)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>=' not supported between instances of 'bool' and 'str'"))))

(define (py-test-ge-boolX-strY-fallback x-1997 y-1998)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>=' not supported between instances of 'bool' and 'str'"))))

(define (py-ge-boolX-sintY-fallback x-2000 y-2001)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-bool-to-scheme-int x-2000) (py-sint-to-scheme y-2001)))))

(define (py-test-ge-boolX-sintY-fallback x-2003 y-2004)
  (py-test-from-scheme
   (py>= (py-bool-to-scheme-int x-2003) (py-sint-to-scheme y-2004))))

(define (py-ge-boolX-bintY-fallback x-2006 y-2007)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-bool-to-scheme-int x-2006) (py-bint-to-scheme y-2007)))))

(define (py-test-ge-boolX-bintY-fallback x-2009 y-2010)
  (py-test-from-scheme
   (py>= (py-bool-to-scheme-int x-2009) (py-bint-to-scheme y-2010))))

(define (py-ge-strX-floatY-fallback x-2012 y-2013)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>=' not supported between instances of 'str' and 'float'"))))

(define (py-test-ge-strX-floatY-fallback x-2015 y-2016)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>=' not supported between instances of 'str' and 'float'"))))

(define (py-ge-strX-boolY-fallback x-2018 y-2019)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>=' not supported between instances of 'str' and 'bool'"))))

(define (py-test-ge-strX-boolY-fallback x-2021 y-2022)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>=' not supported between instances of 'str' and 'bool'"))))

(define (py-ge-strX-strY-fallback x-2024 y-2025)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-str-to-scheme x-2024) (py-str-to-scheme y-2025)))))

(define (py-test-ge-strX-strY-fallback x-2027 y-2028)
  (py-test-from-scheme
   (py>= (py-str-to-scheme x-2027) (py-str-to-scheme y-2028))))

(define (py-ge-strX-sintY-fallback x-2030 y-2031)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>=' not supported between instances of 'str' and 'int'"))))

(define (py-test-ge-strX-sintY-fallback x-2033 y-2034)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>=' not supported between instances of 'str' and 'int'"))))

(define (py-ge-strX-bintY-fallback x-2036 y-2037)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>=' not supported between instances of 'str' and 'int'"))))

(define (py-test-ge-strX-bintY-fallback x-2039 y-2040)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>=' not supported between instances of 'str' and 'int'"))))

(define (py-ge-sintX-floatY-fallback x-2042 y-2043)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-float-to-scheme y-2043) (py-sint-to-scheme x-2042)))))

(define (py-test-ge-sintX-floatY-fallback x-2045 y-2046)
  (py-test-from-scheme
   (py<= (py-float-to-scheme y-2046) (py-sint-to-scheme x-2045))))

(define (py-ge-sintX-boolY-fallback x-2048 y-2049)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-sint-to-scheme x-2048) (py-bool-to-scheme-int y-2049)))))

(define (py-test-ge-sintX-boolY-fallback x-2051 y-2052)
  (py-test-from-scheme
   (py>= (py-sint-to-scheme x-2051) (py-bool-to-scheme-int y-2052))))

(define (py-ge-sintX-strY-fallback x-2054 y-2055)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>=' not supported between instances of 'int' and 'str'"))))

(define (py-test-ge-sintX-strY-fallback x-2057 y-2058)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>=' not supported between instances of 'int' and 'str'"))))

(define (py-ge-sintX-sintY-fallback x-2060 y-2061)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-sint-to-scheme x-2060) (py-sint-to-scheme y-2061)))))

(define (py-test-ge-sintX-sintY-fallback x-2063 y-2064)
  (py-test-from-scheme
   (py>= (py-sint-to-scheme x-2063) (py-sint-to-scheme y-2064))))

(define (py-ge-sintX-bintY-fallback x-2066 y-2067)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-sint-to-scheme x-2066) (py-bint-to-scheme y-2067)))))

(define (py-test-ge-sintX-bintY-fallback x-2069 y-2070)
  (py-test-from-scheme
   (py>= (py-sint-to-scheme x-2069) (py-bint-to-scheme y-2070))))

(define (py-ge-bintX-floatY-fallback x-2072 y-2073)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-float-to-scheme y-2073) (py-bint-to-scheme x-2072)))))

(define (py-test-ge-bintX-floatY-fallback x-2075 y-2076)
  (py-test-from-scheme
   (py<= (py-float-to-scheme y-2076) (py-bint-to-scheme x-2075))))

(define (py-ge-bintX-boolY-fallback x-2078 y-2079)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-bint-to-scheme x-2078) (py-bool-to-scheme-int y-2079)))))

(define (py-test-ge-bintX-boolY-fallback x-2081 y-2082)
  (py-test-from-scheme
   (py>= (py-bint-to-scheme x-2081) (py-bool-to-scheme-int y-2082))))

(define (py-ge-bintX-strY-fallback x-2084 y-2085)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>=' not supported between instances of 'int' and 'str'"))))

(define (py-test-ge-bintX-strY-fallback x-2087 y-2088)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>=' not supported between instances of 'int' and 'str'"))))

(define (py-ge-bintX-sintY-fallback x-2090 y-2091)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-bint-to-scheme x-2090) (py-sint-to-scheme y-2091)))))

(define (py-test-ge-bintX-sintY-fallback x-2093 y-2094)
  (py-test-from-scheme
   (py>= (py-bint-to-scheme x-2093) (py-sint-to-scheme y-2094))))

(define (py-ge-bintX-bintY-fallback x-2096 y-2097)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-bint-to-scheme x-2096) (py-bint-to-scheme y-2097)))))

(define (py-test-ge-bintX-bintY-fallback x-2099 y-2100)
  (py-test-from-scheme
   (py>= (py-bint-to-scheme x-2099) (py-bint-to-scheme y-2100))))

(define (py-gt-floatX-floatY-fallback x-2102 y-2103)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-float-to-scheme x-2102) (py-float-to-scheme y-2103)))))

(define (py-test-gt-floatX-floatY-fallback x-2105 y-2106)
  (py-test-from-scheme
   (py> (py-float-to-scheme x-2105) (py-float-to-scheme y-2106))))

(define (py-gt-floatX-boolY-fallback x-2108 y-2109)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-float-to-scheme x-2108) (py-bool-to-scheme-int y-2109)))))

(define (py-test-gt-floatX-boolY-fallback x-2111 y-2112)
  (py-test-from-scheme
   (py> (py-float-to-scheme x-2111) (py-bool-to-scheme-int y-2112))))

(define (py-gt-floatX-strY-fallback x-2114 y-2115)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>' not supported between instances of 'float' and 'str'"))))

(define (py-test-gt-floatX-strY-fallback x-2117 y-2118)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>' not supported between instances of 'float' and 'str'"))))

(define (py-gt-floatX-sintY-fallback x-2120 y-2121)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-float-to-scheme x-2120) (py-sint-to-scheme y-2121)))))

(define (py-test-gt-floatX-sintY-fallback x-2123 y-2124)
  (py-test-from-scheme
   (py> (py-float-to-scheme x-2123) (py-sint-to-scheme y-2124))))

(define (py-gt-floatX-bintY-fallback x-2126 y-2127)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-float-to-scheme x-2126) (py-bint-to-scheme y-2127)))))

(define (py-test-gt-floatX-bintY-fallback x-2129 y-2130)
  (py-test-from-scheme
   (py> (py-float-to-scheme x-2129) (py-bint-to-scheme y-2130))))

(define (py-gt-boolX-floatY-fallback x-2132 y-2133)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-float-to-scheme y-2133) (py-bool-to-scheme-int x-2132)))))

(define (py-test-gt-boolX-floatY-fallback x-2135 y-2136)
  (py-test-from-scheme
   (py< (py-float-to-scheme y-2136) (py-bool-to-scheme-int x-2135))))

(define (py-gt-boolX-boolY-fallback x-2138 y-2139)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-bool-to-scheme-int x-2138) (py-bool-to-scheme-int y-2139)))))

(define (py-test-gt-boolX-boolY-fallback x-2141 y-2142)
  (py-test-from-scheme
   (py> (py-bool-to-scheme-int x-2141) (py-bool-to-scheme-int y-2142))))

(define (py-gt-boolX-strY-fallback x-2144 y-2145)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>' not supported between instances of 'bool' and 'str'"))))

(define (py-test-gt-boolX-strY-fallback x-2147 y-2148)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>' not supported between instances of 'bool' and 'str'"))))

(define (py-gt-boolX-sintY-fallback x-2150 y-2151)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-bool-to-scheme-int x-2150) (py-sint-to-scheme y-2151)))))

(define (py-test-gt-boolX-sintY-fallback x-2153 y-2154)
  (py-test-from-scheme
   (py> (py-bool-to-scheme-int x-2153) (py-sint-to-scheme y-2154))))

(define (py-gt-boolX-bintY-fallback x-2156 y-2157)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-bool-to-scheme-int x-2156) (py-bint-to-scheme y-2157)))))

(define (py-test-gt-boolX-bintY-fallback x-2159 y-2160)
  (py-test-from-scheme
   (py> (py-bool-to-scheme-int x-2159) (py-bint-to-scheme y-2160))))

(define (py-gt-strX-floatY-fallback x-2162 y-2163)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>' not supported between instances of 'str' and 'float'"))))

(define (py-test-gt-strX-floatY-fallback x-2165 y-2166)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>' not supported between instances of 'str' and 'float'"))))

(define (py-gt-strX-boolY-fallback x-2168 y-2169)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>' not supported between instances of 'str' and 'bool'"))))

(define (py-test-gt-strX-boolY-fallback x-2171 y-2172)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>' not supported between instances of 'str' and 'bool'"))))

(define (py-gt-strX-strY-fallback x-2174 y-2175)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-str-to-scheme x-2174) (py-str-to-scheme y-2175)))))

(define (py-test-gt-strX-strY-fallback x-2177 y-2178)
  (py-test-from-scheme
   (py> (py-str-to-scheme x-2177) (py-str-to-scheme y-2178))))

(define (py-gt-strX-sintY-fallback x-2180 y-2181)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>' not supported between instances of 'str' and 'int'"))))

(define (py-test-gt-strX-sintY-fallback x-2183 y-2184)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>' not supported between instances of 'str' and 'int'"))))

(define (py-gt-strX-bintY-fallback x-2186 y-2187)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>' not supported between instances of 'str' and 'int'"))))

(define (py-test-gt-strX-bintY-fallback x-2189 y-2190)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>' not supported between instances of 'str' and 'int'"))))

(define (py-gt-sintX-floatY-fallback x-2192 y-2193)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-float-to-scheme y-2193) (py-sint-to-scheme x-2192)))))

(define (py-test-gt-sintX-floatY-fallback x-2195 y-2196)
  (py-test-from-scheme
   (py< (py-float-to-scheme y-2196) (py-sint-to-scheme x-2195))))

(define (py-gt-sintX-boolY-fallback x-2198 y-2199)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-sint-to-scheme x-2198) (py-bool-to-scheme-int y-2199)))))

(define (py-test-gt-sintX-boolY-fallback x-2201 y-2202)
  (py-test-from-scheme
   (py> (py-sint-to-scheme x-2201) (py-bool-to-scheme-int y-2202))))

(define (py-gt-sintX-strY-fallback x-2204 y-2205)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>' not supported between instances of 'int' and 'str'"))))

(define (py-test-gt-sintX-strY-fallback x-2207 y-2208)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>' not supported between instances of 'int' and 'str'"))))

(define (py-gt-sintX-sintY-fallback x-2210 y-2211)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-sint-to-scheme x-2210) (py-sint-to-scheme y-2211)))))

(define (py-test-gt-sintX-sintY-fallback x-2213 y-2214)
  (py-test-from-scheme
   (py> (py-sint-to-scheme x-2213) (py-sint-to-scheme y-2214))))

(define (py-gt-sintX-bintY-fallback x-2216 y-2217)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-sint-to-scheme x-2216) (py-bint-to-scheme y-2217)))))

(define (py-test-gt-sintX-bintY-fallback x-2219 y-2220)
  (py-test-from-scheme
   (py> (py-sint-to-scheme x-2219) (py-bint-to-scheme y-2220))))

(define (py-gt-bintX-floatY-fallback x-2222 y-2223)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-float-to-scheme y-2223) (py-bint-to-scheme x-2222)))))

(define (py-test-gt-bintX-floatY-fallback x-2225 y-2226)
  (py-test-from-scheme
   (py< (py-float-to-scheme y-2226) (py-bint-to-scheme x-2225))))

(define (py-gt-bintX-boolY-fallback x-2228 y-2229)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-bint-to-scheme x-2228) (py-bool-to-scheme-int y-2229)))))

(define (py-test-gt-bintX-boolY-fallback x-2231 y-2232)
  (py-test-from-scheme
   (py> (py-bint-to-scheme x-2231) (py-bool-to-scheme-int y-2232))))

(define (py-gt-bintX-strY-fallback x-2234 y-2235)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>' not supported between instances of 'int' and 'str'"))))

(define (py-test-gt-bintX-strY-fallback x-2237 y-2238)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>' not supported between instances of 'int' and 'str'"))))

(define (py-gt-bintX-sintY-fallback x-2240 y-2241)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-bint-to-scheme x-2240) (py-sint-to-scheme y-2241)))))

(define (py-test-gt-bintX-sintY-fallback x-2243 y-2244)
  (py-test-from-scheme
   (py> (py-bint-to-scheme x-2243) (py-sint-to-scheme y-2244))))

(define (py-gt-bintX-bintY-fallback x-2246 y-2247)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-bint-to-scheme x-2246) (py-bint-to-scheme y-2247)))))

(define (py-test-gt-bintX-bintY-fallback x-2249 y-2250)
  (py-test-from-scheme
   (py> (py-bint-to-scheme x-2249) (py-bint-to-scheme y-2250))))

(define (py-le-floatX-floatY-fallback x-2252 y-2253)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-float-to-scheme x-2252) (py-float-to-scheme y-2253)))))

(define (py-test-le-floatX-floatY-fallback x-2255 y-2256)
  (py-test-from-scheme
   (py<= (py-float-to-scheme x-2255) (py-float-to-scheme y-2256))))

(define (py-le-floatX-boolY-fallback x-2258 y-2259)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-float-to-scheme x-2258) (py-bool-to-scheme-int y-2259)))))

(define (py-test-le-floatX-boolY-fallback x-2261 y-2262)
  (py-test-from-scheme
   (py<= (py-float-to-scheme x-2261) (py-bool-to-scheme-int y-2262))))

(define (py-le-floatX-strY-fallback x-2264 y-2265)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<=' not supported between instances of 'float' and 'str'"))))

(define (py-test-le-floatX-strY-fallback x-2267 y-2268)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<=' not supported between instances of 'float' and 'str'"))))

(define (py-le-floatX-sintY-fallback x-2270 y-2271)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-float-to-scheme x-2270) (py-sint-to-scheme y-2271)))))

(define (py-test-le-floatX-sintY-fallback x-2273 y-2274)
  (py-test-from-scheme
   (py<= (py-float-to-scheme x-2273) (py-sint-to-scheme y-2274))))

(define (py-le-floatX-bintY-fallback x-2276 y-2277)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-float-to-scheme x-2276) (py-bint-to-scheme y-2277)))))

(define (py-test-le-floatX-bintY-fallback x-2279 y-2280)
  (py-test-from-scheme
   (py<= (py-float-to-scheme x-2279) (py-bint-to-scheme y-2280))))

(define (py-le-boolX-floatY-fallback x-2282 y-2283)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-float-to-scheme y-2283) (py-bool-to-scheme-int x-2282)))))

(define (py-test-le-boolX-floatY-fallback x-2285 y-2286)
  (py-test-from-scheme
   (py>= (py-float-to-scheme y-2286) (py-bool-to-scheme-int x-2285))))

(define (py-le-boolX-boolY-fallback x-2288 y-2289)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-bool-to-scheme-int x-2288) (py-bool-to-scheme-int y-2289)))))

(define (py-test-le-boolX-boolY-fallback x-2291 y-2292)
  (py-test-from-scheme
   (py<= (py-bool-to-scheme-int x-2291) (py-bool-to-scheme-int y-2292))))

(define (py-le-boolX-strY-fallback x-2294 y-2295)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<=' not supported between instances of 'bool' and 'str'"))))

(define (py-test-le-boolX-strY-fallback x-2297 y-2298)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<=' not supported between instances of 'bool' and 'str'"))))

(define (py-le-boolX-sintY-fallback x-2300 y-2301)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-bool-to-scheme-int x-2300) (py-sint-to-scheme y-2301)))))

(define (py-test-le-boolX-sintY-fallback x-2303 y-2304)
  (py-test-from-scheme
   (py<= (py-bool-to-scheme-int x-2303) (py-sint-to-scheme y-2304))))

(define (py-le-boolX-bintY-fallback x-2306 y-2307)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-bool-to-scheme-int x-2306) (py-bint-to-scheme y-2307)))))

(define (py-test-le-boolX-bintY-fallback x-2309 y-2310)
  (py-test-from-scheme
   (py<= (py-bool-to-scheme-int x-2309) (py-bint-to-scheme y-2310))))

(define (py-le-strX-floatY-fallback x-2312 y-2313)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<=' not supported between instances of 'str' and 'float'"))))

(define (py-test-le-strX-floatY-fallback x-2315 y-2316)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<=' not supported between instances of 'str' and 'float'"))))

(define (py-le-strX-boolY-fallback x-2318 y-2319)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<=' not supported between instances of 'str' and 'bool'"))))

(define (py-test-le-strX-boolY-fallback x-2321 y-2322)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<=' not supported between instances of 'str' and 'bool'"))))

(define (py-le-strX-strY-fallback x-2324 y-2325)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-str-to-scheme x-2324) (py-str-to-scheme y-2325)))))

(define (py-test-le-strX-strY-fallback x-2327 y-2328)
  (py-test-from-scheme
   (py<= (py-str-to-scheme x-2327) (py-str-to-scheme y-2328))))

(define (py-le-strX-sintY-fallback x-2330 y-2331)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<=' not supported between instances of 'str' and 'int'"))))

(define (py-test-le-strX-sintY-fallback x-2333 y-2334)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<=' not supported between instances of 'str' and 'int'"))))

(define (py-le-strX-bintY-fallback x-2336 y-2337)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<=' not supported between instances of 'str' and 'int'"))))

(define (py-test-le-strX-bintY-fallback x-2339 y-2340)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<=' not supported between instances of 'str' and 'int'"))))

(define (py-le-sintX-floatY-fallback x-2342 y-2343)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-float-to-scheme y-2343) (py-sint-to-scheme x-2342)))))

(define (py-test-le-sintX-floatY-fallback x-2345 y-2346)
  (py-test-from-scheme
   (py>= (py-float-to-scheme y-2346) (py-sint-to-scheme x-2345))))

(define (py-le-sintX-boolY-fallback x-2348 y-2349)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-sint-to-scheme x-2348) (py-bool-to-scheme-int y-2349)))))

(define (py-test-le-sintX-boolY-fallback x-2351 y-2352)
  (py-test-from-scheme
   (py<= (py-sint-to-scheme x-2351) (py-bool-to-scheme-int y-2352))))

(define (py-le-sintX-strY-fallback x-2354 y-2355)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<=' not supported between instances of 'int' and 'str'"))))

(define (py-test-le-sintX-strY-fallback x-2357 y-2358)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<=' not supported between instances of 'int' and 'str'"))))

(define (py-le-sintX-sintY-fallback x-2360 y-2361)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-sint-to-scheme x-2360) (py-sint-to-scheme y-2361)))))

(define (py-test-le-sintX-sintY-fallback x-2363 y-2364)
  (py-test-from-scheme
   (py<= (py-sint-to-scheme x-2363) (py-sint-to-scheme y-2364))))

(define (py-le-sintX-bintY-fallback x-2366 y-2367)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-sint-to-scheme x-2366) (py-bint-to-scheme y-2367)))))

(define (py-test-le-sintX-bintY-fallback x-2369 y-2370)
  (py-test-from-scheme
   (py<= (py-sint-to-scheme x-2369) (py-bint-to-scheme y-2370))))

(define (py-le-bintX-floatY-fallback x-2372 y-2373)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-float-to-scheme y-2373) (py-bint-to-scheme x-2372)))))

(define (py-test-le-bintX-floatY-fallback x-2375 y-2376)
  (py-test-from-scheme
   (py>= (py-float-to-scheme y-2376) (py-bint-to-scheme x-2375))))

(define (py-le-bintX-boolY-fallback x-2378 y-2379)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-bint-to-scheme x-2378) (py-bool-to-scheme-int y-2379)))))

(define (py-test-le-bintX-boolY-fallback x-2381 y-2382)
  (py-test-from-scheme
   (py<= (py-bint-to-scheme x-2381) (py-bool-to-scheme-int y-2382))))

(define (py-le-bintX-strY-fallback x-2384 y-2385)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<=' not supported between instances of 'int' and 'str'"))))

(define (py-test-le-bintX-strY-fallback x-2387 y-2388)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<=' not supported between instances of 'int' and 'str'"))))

(define (py-le-bintX-sintY-fallback x-2390 y-2391)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-bint-to-scheme x-2390) (py-sint-to-scheme y-2391)))))

(define (py-test-le-bintX-sintY-fallback x-2393 y-2394)
  (py-test-from-scheme
   (py<= (py-bint-to-scheme x-2393) (py-sint-to-scheme y-2394))))

(define (py-le-bintX-bintY-fallback x-2396 y-2397)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-bint-to-scheme x-2396) (py-bint-to-scheme y-2397)))))

(define (py-test-le-bintX-bintY-fallback x-2399 y-2400)
  (py-test-from-scheme
   (py<= (py-bint-to-scheme x-2399) (py-bint-to-scheme y-2400))))

(define (py-lt-floatX-floatY-fallback x-2402 y-2403)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-float-to-scheme x-2402) (py-float-to-scheme y-2403)))))

(define (py-test-lt-floatX-floatY-fallback x-2405 y-2406)
  (py-test-from-scheme
   (py< (py-float-to-scheme x-2405) (py-float-to-scheme y-2406))))

(define (py-lt-floatX-boolY-fallback x-2408 y-2409)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-float-to-scheme x-2408) (py-bool-to-scheme-int y-2409)))))

(define (py-test-lt-floatX-boolY-fallback x-2411 y-2412)
  (py-test-from-scheme
   (py< (py-float-to-scheme x-2411) (py-bool-to-scheme-int y-2412))))

(define (py-lt-floatX-strY-fallback x-2414 y-2415)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<' not supported between instances of 'float' and 'str'"))))

(define (py-test-lt-floatX-strY-fallback x-2417 y-2418)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<' not supported between instances of 'float' and 'str'"))))

(define (py-lt-floatX-sintY-fallback x-2420 y-2421)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-float-to-scheme x-2420) (py-sint-to-scheme y-2421)))))

(define (py-test-lt-floatX-sintY-fallback x-2423 y-2424)
  (py-test-from-scheme
   (py< (py-float-to-scheme x-2423) (py-sint-to-scheme y-2424))))

(define (py-lt-floatX-bintY-fallback x-2426 y-2427)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-float-to-scheme x-2426) (py-bint-to-scheme y-2427)))))

(define (py-test-lt-floatX-bintY-fallback x-2429 y-2430)
  (py-test-from-scheme
   (py< (py-float-to-scheme x-2429) (py-bint-to-scheme y-2430))))

(define (py-lt-boolX-floatY-fallback x-2432 y-2433)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-float-to-scheme y-2433) (py-bool-to-scheme-int x-2432)))))

(define (py-test-lt-boolX-floatY-fallback x-2435 y-2436)
  (py-test-from-scheme
   (py> (py-float-to-scheme y-2436) (py-bool-to-scheme-int x-2435))))

(define (py-lt-boolX-boolY-fallback x-2438 y-2439)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-bool-to-scheme-int x-2438) (py-bool-to-scheme-int y-2439)))))

(define (py-test-lt-boolX-boolY-fallback x-2441 y-2442)
  (py-test-from-scheme
   (py< (py-bool-to-scheme-int x-2441) (py-bool-to-scheme-int y-2442))))

(define (py-lt-boolX-strY-fallback x-2444 y-2445)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<' not supported between instances of 'bool' and 'str'"))))

(define (py-test-lt-boolX-strY-fallback x-2447 y-2448)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<' not supported between instances of 'bool' and 'str'"))))

(define (py-lt-boolX-sintY-fallback x-2450 y-2451)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-bool-to-scheme-int x-2450) (py-sint-to-scheme y-2451)))))

(define (py-test-lt-boolX-sintY-fallback x-2453 y-2454)
  (py-test-from-scheme
   (py< (py-bool-to-scheme-int x-2453) (py-sint-to-scheme y-2454))))

(define (py-lt-boolX-bintY-fallback x-2456 y-2457)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-bool-to-scheme-int x-2456) (py-bint-to-scheme y-2457)))))

(define (py-test-lt-boolX-bintY-fallback x-2459 y-2460)
  (py-test-from-scheme
   (py< (py-bool-to-scheme-int x-2459) (py-bint-to-scheme y-2460))))

(define (py-lt-strX-floatY-fallback x-2462 y-2463)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<' not supported between instances of 'str' and 'float'"))))

(define (py-test-lt-strX-floatY-fallback x-2465 y-2466)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<' not supported between instances of 'str' and 'float'"))))

(define (py-lt-strX-boolY-fallback x-2468 y-2469)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<' not supported between instances of 'str' and 'bool'"))))

(define (py-test-lt-strX-boolY-fallback x-2471 y-2472)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<' not supported between instances of 'str' and 'bool'"))))

(define (py-lt-strX-strY-fallback x-2474 y-2475)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-str-to-scheme x-2474) (py-str-to-scheme y-2475)))))

(define (py-test-lt-strX-strY-fallback x-2477 y-2478)
  (py-test-from-scheme
   (py< (py-str-to-scheme x-2477) (py-str-to-scheme y-2478))))

(define (py-lt-strX-sintY-fallback x-2480 y-2481)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<' not supported between instances of 'str' and 'int'"))))

(define (py-test-lt-strX-sintY-fallback x-2483 y-2484)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<' not supported between instances of 'str' and 'int'"))))

(define (py-lt-strX-bintY-fallback x-2486 y-2487)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<' not supported between instances of 'str' and 'int'"))))

(define (py-test-lt-strX-bintY-fallback x-2489 y-2490)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<' not supported between instances of 'str' and 'int'"))))

(define (py-lt-sintX-floatY-fallback x-2492 y-2493)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-float-to-scheme y-2493) (py-sint-to-scheme x-2492)))))

(define (py-test-lt-sintX-floatY-fallback x-2495 y-2496)
  (py-test-from-scheme
   (py> (py-float-to-scheme y-2496) (py-sint-to-scheme x-2495))))

(define (py-lt-sintX-boolY-fallback x-2498 y-2499)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-sint-to-scheme x-2498) (py-bool-to-scheme-int y-2499)))))

(define (py-test-lt-sintX-boolY-fallback x-2501 y-2502)
  (py-test-from-scheme
   (py< (py-sint-to-scheme x-2501) (py-bool-to-scheme-int y-2502))))

(define (py-lt-sintX-strY-fallback x-2504 y-2505)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<' not supported between instances of 'int' and 'str'"))))

(define (py-test-lt-sintX-strY-fallback x-2507 y-2508)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<' not supported between instances of 'int' and 'str'"))))

(define (py-lt-sintX-sintY-fallback x-2510 y-2511)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-sint-to-scheme x-2510) (py-sint-to-scheme y-2511)))))

(define (py-test-lt-sintX-sintY-fallback x-2513 y-2514)
  (py-test-from-scheme
   (py< (py-sint-to-scheme x-2513) (py-sint-to-scheme y-2514))))

(define (py-lt-sintX-bintY-fallback x-2516 y-2517)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-sint-to-scheme x-2516) (py-bint-to-scheme y-2517)))))

(define (py-test-lt-sintX-bintY-fallback x-2519 y-2520)
  (py-test-from-scheme
   (py< (py-sint-to-scheme x-2519) (py-bint-to-scheme y-2520))))

(define (py-lt-bintX-floatY-fallback x-2522 y-2523)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-float-to-scheme y-2523) (py-bint-to-scheme x-2522)))))

(define (py-test-lt-bintX-floatY-fallback x-2525 y-2526)
  (py-test-from-scheme
   (py> (py-float-to-scheme y-2526) (py-bint-to-scheme x-2525))))

(define (py-lt-bintX-boolY-fallback x-2528 y-2529)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-bint-to-scheme x-2528) (py-bool-to-scheme-int y-2529)))))

(define (py-test-lt-bintX-boolY-fallback x-2531 y-2532)
  (py-test-from-scheme
   (py< (py-bint-to-scheme x-2531) (py-bool-to-scheme-int y-2532))))

(define (py-lt-bintX-strY-fallback x-2534 y-2535)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<' not supported between instances of 'int' and 'str'"))))

(define (py-test-lt-bintX-strY-fallback x-2537 y-2538)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<' not supported between instances of 'int' and 'str'"))))

(define (py-lt-bintX-sintY-fallback x-2540 y-2541)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-bint-to-scheme x-2540) (py-sint-to-scheme y-2541)))))

(define (py-test-lt-bintX-sintY-fallback x-2543 y-2544)
  (py-test-from-scheme
   (py< (py-bint-to-scheme x-2543) (py-sint-to-scheme y-2544))))

(define (py-lt-bintX-bintY-fallback x-2546 y-2547)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-bint-to-scheme x-2546) (py-bint-to-scheme y-2547)))))

(define (py-test-lt-bintX-bintY-fallback x-2549 y-2550)
  (py-test-from-scheme
   (py< (py-bint-to-scheme x-2549) (py-bint-to-scheme y-2550))))

(define (py-eq-floatX-floatY-fallback x-2552 y-2553)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-float-to-scheme x-2552) (py-float-to-scheme y-2553)))))

(define (py-test-eq-floatX-floatY-fallback x-2555 y-2556)
  (py-test-from-scheme
   (py== (py-float-to-scheme x-2555) (py-float-to-scheme y-2556))))

(define (py-eq-floatX-boolY-fallback x-2558 y-2559)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-float-to-scheme x-2558) (py-bool-to-scheme-int y-2559)))))

(define (py-test-eq-floatX-boolY-fallback x-2561 y-2562)
  (py-test-from-scheme
   (py== (py-float-to-scheme x-2561) (py-bool-to-scheme-int y-2562))))

(define (py-eq-floatX-strY-fallback x-2564 y-2565) py-False)

(define (py-test-eq-floatX-strY-fallback x-2567 y-2568)
  (py-bool-from-scheme-bool py-False))

(define (py-eq-floatX-sintY-fallback x-2570 y-2571)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-float-to-scheme x-2570) (py-sint-to-scheme y-2571)))))

(define (py-test-eq-floatX-sintY-fallback x-2573 y-2574)
  (py-test-from-scheme
   (py== (py-float-to-scheme x-2573) (py-sint-to-scheme y-2574))))

(define (py-eq-floatX-bintY-fallback x-2576 y-2577)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-float-to-scheme x-2576) (py-bint-to-scheme y-2577)))))

(define (py-test-eq-floatX-bintY-fallback x-2579 y-2580)
  (py-test-from-scheme
   (py== (py-float-to-scheme x-2579) (py-bint-to-scheme y-2580))))

(define (py-eq-boolX-floatY-fallback x-2582 y-2583)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-float-to-scheme y-2583) (py-bool-to-scheme-int x-2582)))))

(define (py-test-eq-boolX-floatY-fallback x-2585 y-2586)
  (py-test-from-scheme
   (py== (py-float-to-scheme y-2586) (py-bool-to-scheme-int x-2585))))

(define (py-eq-boolX-boolY-fallback x-2588 y-2589)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-bool-to-scheme-int x-2588) (py-bool-to-scheme-int y-2589)))))

(define (py-test-eq-boolX-boolY-fallback x-2591 y-2592)
  (py-test-from-scheme
   (py== (py-bool-to-scheme-int x-2591) (py-bool-to-scheme-int y-2592))))

(define (py-eq-boolX-strY-fallback x-2594 y-2595) py-False)

(define (py-test-eq-boolX-strY-fallback x-2597 y-2598)
  (py-bool-from-scheme-bool py-False))

(define (py-eq-boolX-sintY-fallback x-2600 y-2601)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-bool-to-scheme-int x-2600) (py-sint-to-scheme y-2601)))))

(define (py-test-eq-boolX-sintY-fallback x-2603 y-2604)
  (py-test-from-scheme
   (py== (py-bool-to-scheme-int x-2603) (py-sint-to-scheme y-2604))))

(define (py-eq-boolX-bintY-fallback x-2606 y-2607)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-bool-to-scheme-int x-2606) (py-bint-to-scheme y-2607)))))

(define (py-test-eq-boolX-bintY-fallback x-2609 y-2610)
  (py-test-from-scheme
   (py== (py-bool-to-scheme-int x-2609) (py-bint-to-scheme y-2610))))

(define (py-eq-strX-floatY-fallback x-2612 y-2613) py-False)

(define (py-test-eq-strX-floatY-fallback x-2615 y-2616)
  (py-bool-from-scheme-bool py-False))

(define (py-eq-strX-boolY-fallback x-2618 y-2619) py-False)

(define (py-test-eq-strX-boolY-fallback x-2621 y-2622)
  (py-bool-from-scheme-bool py-False))

(define (py-eq-strX-strY-fallback x-2624 y-2625)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-str-to-scheme x-2624) (py-str-to-scheme y-2625)))))

(define (py-test-eq-strX-strY-fallback x-2627 y-2628)
  (py-test-from-scheme
   (py== (py-str-to-scheme x-2627) (py-str-to-scheme y-2628))))

(define (py-eq-strX-sintY-fallback x-2630 y-2631) py-False)

(define (py-test-eq-strX-sintY-fallback x-2633 y-2634)
  (py-bool-from-scheme-bool py-False))

(define (py-eq-strX-bintY-fallback x-2636 y-2637) py-False)

(define (py-test-eq-strX-bintY-fallback x-2639 y-2640)
  (py-bool-from-scheme-bool py-False))

(define (py-eq-sintX-floatY-fallback x-2642 y-2643)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-float-to-scheme y-2643) (py-sint-to-scheme x-2642)))))

(define (py-test-eq-sintX-floatY-fallback x-2645 y-2646)
  (py-test-from-scheme
   (py== (py-float-to-scheme y-2646) (py-sint-to-scheme x-2645))))

(define (py-eq-sintX-boolY-fallback x-2648 y-2649)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-sint-to-scheme x-2648) (py-bool-to-scheme-int y-2649)))))

(define (py-test-eq-sintX-boolY-fallback x-2651 y-2652)
  (py-test-from-scheme
   (py== (py-sint-to-scheme x-2651) (py-bool-to-scheme-int y-2652))))

(define (py-eq-sintX-strY-fallback x-2654 y-2655) py-False)

(define (py-test-eq-sintX-strY-fallback x-2657 y-2658)
  (py-bool-from-scheme-bool py-False))

(define (py-eq-sintX-sintY-fallback x-2660 y-2661)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-sint-to-scheme x-2660) (py-sint-to-scheme y-2661)))))

(define (py-test-eq-sintX-sintY-fallback x-2663 y-2664)
  (py-test-from-scheme
   (py== (py-sint-to-scheme x-2663) (py-sint-to-scheme y-2664))))

(define (py-eq-sintX-bintY-fallback x-2666 y-2667)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-sint-to-scheme x-2666) (py-bint-to-scheme y-2667)))))

(define (py-test-eq-sintX-bintY-fallback x-2669 y-2670)
  (py-test-from-scheme
   (py== (py-sint-to-scheme x-2669) (py-bint-to-scheme y-2670))))

(define (py-eq-bintX-floatY-fallback x-2672 y-2673)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-float-to-scheme y-2673) (py-bint-to-scheme x-2672)))))

(define (py-test-eq-bintX-floatY-fallback x-2675 y-2676)
  (py-test-from-scheme
   (py== (py-float-to-scheme y-2676) (py-bint-to-scheme x-2675))))

(define (py-eq-bintX-boolY-fallback x-2678 y-2679)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-bint-to-scheme x-2678) (py-bool-to-scheme-int y-2679)))))

(define (py-test-eq-bintX-boolY-fallback x-2681 y-2682)
  (py-test-from-scheme
   (py== (py-bint-to-scheme x-2681) (py-bool-to-scheme-int y-2682))))

(define (py-eq-bintX-strY-fallback x-2684 y-2685) py-False)

(define (py-test-eq-bintX-strY-fallback x-2687 y-2688)
  (py-bool-from-scheme-bool py-False))

(define (py-eq-bintX-sintY-fallback x-2690 y-2691)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-bint-to-scheme x-2690) (py-sint-to-scheme y-2691)))))

(define (py-test-eq-bintX-sintY-fallback x-2693 y-2694)
  (py-test-from-scheme
   (py== (py-bint-to-scheme x-2693) (py-sint-to-scheme y-2694))))

(define (py-eq-bintX-bintY-fallback x-2696 y-2697)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-bint-to-scheme x-2696) (py-bint-to-scheme y-2697)))))

(define (py-test-eq-bintX-bintY-fallback x-2699 y-2700)
  (py-test-from-scheme
   (py== (py-bint-to-scheme x-2699) (py-bint-to-scheme y-2700))))

(define (py-ne-floatX-floatY-fallback x-2702 y-2703)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-float-to-scheme x-2702) (py-float-to-scheme y-2703)))))

(define (py-test-ne-floatX-floatY-fallback x-2705 y-2706)
  (py-test-from-scheme
   (py!= (py-float-to-scheme x-2705) (py-float-to-scheme y-2706))))

(define (py-ne-floatX-boolY-fallback x-2708 y-2709)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-float-to-scheme x-2708) (py-bool-to-scheme-int y-2709)))))

(define (py-test-ne-floatX-boolY-fallback x-2711 y-2712)
  (py-test-from-scheme
   (py!= (py-float-to-scheme x-2711) (py-bool-to-scheme-int y-2712))))

(define (py-ne-floatX-strY-fallback x-2714 y-2715) py-True)

(define (py-test-ne-floatX-strY-fallback x-2717 y-2718)
  (py-bool-from-scheme-bool py-True))

(define (py-ne-floatX-sintY-fallback x-2720 y-2721)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-float-to-scheme x-2720) (py-sint-to-scheme y-2721)))))

(define (py-test-ne-floatX-sintY-fallback x-2723 y-2724)
  (py-test-from-scheme
   (py!= (py-float-to-scheme x-2723) (py-sint-to-scheme y-2724))))

(define (py-ne-floatX-bintY-fallback x-2726 y-2727)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-float-to-scheme x-2726) (py-bint-to-scheme y-2727)))))

(define (py-test-ne-floatX-bintY-fallback x-2729 y-2730)
  (py-test-from-scheme
   (py!= (py-float-to-scheme x-2729) (py-bint-to-scheme y-2730))))

(define (py-ne-boolX-floatY-fallback x-2732 y-2733)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-float-to-scheme y-2733) (py-bool-to-scheme-int x-2732)))))

(define (py-test-ne-boolX-floatY-fallback x-2735 y-2736)
  (py-test-from-scheme
   (py!= (py-float-to-scheme y-2736) (py-bool-to-scheme-int x-2735))))

(define (py-ne-boolX-boolY-fallback x-2738 y-2739)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-bool-to-scheme-int x-2738) (py-bool-to-scheme-int y-2739)))))

(define (py-test-ne-boolX-boolY-fallback x-2741 y-2742)
  (py-test-from-scheme
   (py!= (py-bool-to-scheme-int x-2741) (py-bool-to-scheme-int y-2742))))

(define (py-ne-boolX-strY-fallback x-2744 y-2745) py-True)

(define (py-test-ne-boolX-strY-fallback x-2747 y-2748)
  (py-bool-from-scheme-bool py-True))

(define (py-ne-boolX-sintY-fallback x-2750 y-2751)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-bool-to-scheme-int x-2750) (py-sint-to-scheme y-2751)))))

(define (py-test-ne-boolX-sintY-fallback x-2753 y-2754)
  (py-test-from-scheme
   (py!= (py-bool-to-scheme-int x-2753) (py-sint-to-scheme y-2754))))

(define (py-ne-boolX-bintY-fallback x-2756 y-2757)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-bool-to-scheme-int x-2756) (py-bint-to-scheme y-2757)))))

(define (py-test-ne-boolX-bintY-fallback x-2759 y-2760)
  (py-test-from-scheme
   (py!= (py-bool-to-scheme-int x-2759) (py-bint-to-scheme y-2760))))

(define (py-ne-strX-floatY-fallback x-2762 y-2763) py-True)

(define (py-test-ne-strX-floatY-fallback x-2765 y-2766)
  (py-bool-from-scheme-bool py-True))

(define (py-ne-strX-boolY-fallback x-2768 y-2769) py-True)

(define (py-test-ne-strX-boolY-fallback x-2771 y-2772)
  (py-bool-from-scheme-bool py-True))

(define (py-ne-strX-strY-fallback x-2774 y-2775)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-str-to-scheme x-2774) (py-str-to-scheme y-2775)))))

(define (py-test-ne-strX-strY-fallback x-2777 y-2778)
  (py-test-from-scheme
   (py!= (py-str-to-scheme x-2777) (py-str-to-scheme y-2778))))

(define (py-ne-strX-sintY-fallback x-2780 y-2781) py-True)

(define (py-test-ne-strX-sintY-fallback x-2783 y-2784)
  (py-bool-from-scheme-bool py-True))

(define (py-ne-strX-bintY-fallback x-2786 y-2787) py-True)

(define (py-test-ne-strX-bintY-fallback x-2789 y-2790)
  (py-bool-from-scheme-bool py-True))

(define (py-ne-sintX-floatY-fallback x-2792 y-2793)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-float-to-scheme y-2793) (py-sint-to-scheme x-2792)))))

(define (py-test-ne-sintX-floatY-fallback x-2795 y-2796)
  (py-test-from-scheme
   (py!= (py-float-to-scheme y-2796) (py-sint-to-scheme x-2795))))

(define (py-ne-sintX-boolY-fallback x-2798 y-2799)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-sint-to-scheme x-2798) (py-bool-to-scheme-int y-2799)))))

(define (py-test-ne-sintX-boolY-fallback x-2801 y-2802)
  (py-test-from-scheme
   (py!= (py-sint-to-scheme x-2801) (py-bool-to-scheme-int y-2802))))

(define (py-ne-sintX-strY-fallback x-2804 y-2805) py-True)

(define (py-test-ne-sintX-strY-fallback x-2807 y-2808)
  (py-bool-from-scheme-bool py-True))

(define (py-ne-sintX-sintY-fallback x-2810 y-2811)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-sint-to-scheme x-2810) (py-sint-to-scheme y-2811)))))

(define (py-test-ne-sintX-sintY-fallback x-2813 y-2814)
  (py-test-from-scheme
   (py!= (py-sint-to-scheme x-2813) (py-sint-to-scheme y-2814))))

(define (py-ne-sintX-bintY-fallback x-2816 y-2817)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-sint-to-scheme x-2816) (py-bint-to-scheme y-2817)))))

(define (py-test-ne-sintX-bintY-fallback x-2819 y-2820)
  (py-test-from-scheme
   (py!= (py-sint-to-scheme x-2819) (py-bint-to-scheme y-2820))))

(define (py-ne-bintX-floatY-fallback x-2822 y-2823)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-float-to-scheme y-2823) (py-bint-to-scheme x-2822)))))

(define (py-test-ne-bintX-floatY-fallback x-2825 y-2826)
  (py-test-from-scheme
   (py!= (py-float-to-scheme y-2826) (py-bint-to-scheme x-2825))))

(define (py-ne-bintX-boolY-fallback x-2828 y-2829)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-bint-to-scheme x-2828) (py-bool-to-scheme-int y-2829)))))

(define (py-test-ne-bintX-boolY-fallback x-2831 y-2832)
  (py-test-from-scheme
   (py!= (py-bint-to-scheme x-2831) (py-bool-to-scheme-int y-2832))))

(define (py-ne-bintX-strY-fallback x-2834 y-2835) py-True)

(define (py-test-ne-bintX-strY-fallback x-2837 y-2838)
  (py-bool-from-scheme-bool py-True))

(define (py-ne-bintX-sintY-fallback x-2840 y-2841)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-bint-to-scheme x-2840) (py-sint-to-scheme y-2841)))))

(define (py-test-ne-bintX-sintY-fallback x-2843 y-2844)
  (py-test-from-scheme
   (py!= (py-bint-to-scheme x-2843) (py-sint-to-scheme y-2844))))

(define (py-ne-bintX-bintY-fallback x-2846 y-2847)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-bint-to-scheme x-2846) (py-bint-to-scheme y-2847)))))

(define (py-test-ne-bintX-bintY-fallback x-2849 y-2850)
  (py-test-from-scheme
   (py!= (py-bint-to-scheme x-2849) (py-bint-to-scheme y-2850))))

(define (py-pos-floatX-fallback x-2852) x-2852)

(define (py-pos-boolX-fallback x-2854) x-2854)

(define (py-pos-strX-fallback x-2856)
  (py-throw
   (py-call py-builtin-TypeError (&& "bad operand type for unary +: 'str'"))))

(define (py-pos-sintX-fallback x-2858) x-2858)

(define (py-pos-bintX-fallback x-2860) x-2860)

(define (py-neg-floatX-fallback x-2862)
  (py-float-from-scheme (pyneg (py-float-to-scheme x-2862))))

(define (py-neg-boolX-fallback x-2864)
  (py-int-from-scheme (pyneg (py-bool-to-scheme-int x-2864))))

(define (py-neg-strX-fallback x-2866)
  (py-throw
   (py-call py-builtin-TypeError (&& "bad operand type for unary -: 'str'"))))

(define (py-neg-sintX-fallback x-2868)
  (py-int-from-scheme (pyneg (py-sint-to-scheme x-2868))))

(define (py-neg-bintX-fallback x-2870)
  (py-int-from-scheme (pyneg (py-bint-to-scheme x-2870))))

(define (py-invert-floatX-fallback x-2872)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "bad operand type for unary ~: 'float'"))))

(define (py-invert-boolX-fallback x-2874)
  (py-int-from-scheme (pyinvert (py-bool-to-scheme-int x-2874))))

(define (py-invert-strX-fallback x-2876)
  (py-throw
   (py-call py-builtin-TypeError (&& "bad operand type for unary ~: 'str'"))))

(define (py-invert-sintX-fallback x-2878)
  (py-int-from-scheme (pyinvert (py-sint-to-scheme x-2878))))

(define (py-invert-bintX-fallback x-2880)
  (py-int-from-scheme (pyinvert (py-bint-to-scheme x-2880))))

