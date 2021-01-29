(define-macro (py-add-intX-intY-inline self-2 other-3)
  `(py-add-intX-intY-fallback ,self-2 ,other-3))

(define-macro (py-add-intX-floatY-inline other-5 self-6)
  `(py-add-intX-floatY-fallback ,other-5 ,self-6))

(define-macro (py-add-intX-boolY-inline self-8 other-9)
  `(py-add-intX-boolY-fallback ,self-8 ,other-9))

(define-macro (py-add-intX-sintY-inline self-11 other-12)
  `(py-add-intX-sintY-fallback ,self-11 ,other-12))

(define-macro (py-add-intX-bintY-inline self-14 other-15)
  `(py-add-intX-bintY-fallback ,self-14 ,other-15))

(define-macro (py-add-floatX-intY-inline self-17 other-18)
  `(py-add-floatX-intY-fallback ,self-17 ,other-18))

(define-macro (py-add-floatX-floatY-inline self-20 other-21)
  `(let ((self-20 ,self-20) (other-21 ,other-21))
     (py-float-from-scheme
      (py+ (py-float-to-scheme self-20) (py-float-to-scheme other-21)))))

(define-macro (py-add-floatX-boolY-inline self-23 other-24)
  `(py-add-floatX-boolY-fallback ,self-23 ,other-24))

(define-macro (py-add-floatX-sintY-inline self-26 other-27)
  `(let ((self-26 ,self-26) (other-27 ,other-27))
     (py-float-from-scheme
      (py+ (py-float-to-scheme self-26) (py-sint-to-scheme other-27)))))

(define-macro (py-add-floatX-bintY-inline self-29 other-30)
  `(py-add-floatX-bintY-fallback ,self-29 ,other-30))

(define-macro (py-add-boolX-intY-inline self-32 other-33)
  `(py-add-boolX-intY-fallback ,self-32 ,other-33))

(define-macro (py-add-boolX-floatY-inline other-35 self-36)
  `(py-add-boolX-floatY-fallback ,other-35 ,self-36))

(define-macro (py-add-boolX-boolY-inline self-38 other-39)
  `(py-add-boolX-boolY-fallback ,self-38 ,other-39))

(define-macro (py-add-boolX-sintY-inline self-41 other-42)
  `(py-add-boolX-sintY-fallback ,self-41 ,other-42))

(define-macro (py-add-boolX-bintY-inline self-44 other-45)
  `(py-add-boolX-bintY-fallback ,self-44 ,other-45))

(define-macro (py-add-sintX-intY-inline self-47 other-48)
  `(py-add-sintX-intY-fallback ,self-47 ,other-48))

(define-macro (py-add-sintX-floatY-inline other-50 self-51)
  `(let ((other-50 ,other-50) (self-51 ,self-51))
     (py-float-from-scheme
      (py+ (py-sint-to-scheme other-50) (py-float-to-scheme self-51)))))

(define-macro (py-add-sintX-boolY-inline self-53 other-54)
  `(py-add-sintX-boolY-fallback ,self-53 ,other-54))

(define-macro (py-add-sintX-sintY-inline self-56 other-57)
  `(let ((self-56 ,self-56) (other-57 ,other-57))
     (py-int-from-scheme
      (py+ (py-sint-to-scheme self-56) (py-sint-to-scheme other-57)))))

(define-macro (py-add-sintX-bintY-inline self-59 other-60)
  `(py-add-sintX-bintY-fallback ,self-59 ,other-60))

(define-macro (py-add-bintX-intY-inline self-62 other-63)
  `(py-add-bintX-intY-fallback ,self-62 ,other-63))

(define-macro (py-add-bintX-floatY-inline other-65 self-66)
  `(py-add-bintX-floatY-fallback ,other-65 ,self-66))

(define-macro (py-add-bintX-boolY-inline self-68 other-69)
  `(py-add-bintX-boolY-fallback ,self-68 ,other-69))

(define-macro (py-add-bintX-sintY-inline self-71 other-72)
  `(py-add-bintX-sintY-fallback ,self-71 ,other-72))

(define-macro (py-add-bintX-bintY-inline self-74 other-75)
  `(py-add-bintX-bintY-fallback ,self-74 ,other-75))

(define-macro (py-bitand-intX-intY-inline self-77 other-78)
  `(py-bitand-intX-intY-fallback ,self-77 ,other-78))

(define-macro (py-bitand-intX-floatY-inline self-80 other-81)
  `(py-bitand-intX-floatY-fallback ,self-80 ,other-81))

(define-macro (py-bitand-intX-boolY-inline self-83 other-84)
  `(py-bitand-intX-boolY-fallback ,self-83 ,other-84))

(define-macro (py-bitand-intX-sintY-inline self-86 other-87)
  `(py-bitand-intX-sintY-fallback ,self-86 ,other-87))

(define-macro (py-bitand-intX-bintY-inline self-89 other-90)
  `(py-bitand-intX-bintY-fallback ,self-89 ,other-90))

(define-macro (py-bitand-floatX-intY-inline self-92 other-93)
  `(py-bitand-floatX-intY-fallback ,self-92 ,other-93))

(define-macro (py-bitand-floatX-floatY-inline self-95 other-96)
  `(let ((self-95 ,self-95) (other-96 ,other-96))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for &: 'float' and 'float'")))))

(define-macro (py-bitand-floatX-boolY-inline self-98 other-99)
  `(py-bitand-floatX-boolY-fallback ,self-98 ,other-99))

(define-macro (py-bitand-floatX-sintY-inline self-101 other-102)
  `(let ((self-101 ,self-101) (other-102 ,other-102))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for &: 'float' and 'int'")))))

(define-macro (py-bitand-floatX-bintY-inline self-104 other-105)
  `(py-bitand-floatX-bintY-fallback ,self-104 ,other-105))

(define-macro (py-bitand-boolX-intY-inline self-107 other-108)
  `(py-bitand-boolX-intY-fallback ,self-107 ,other-108))

(define-macro (py-bitand-boolX-floatY-inline self-110 other-111)
  `(py-bitand-boolX-floatY-fallback ,self-110 ,other-111))

(define-macro (py-bitand-boolX-boolY-inline self-113 other-114)
  `(py-bitand-boolX-boolY-fallback ,self-113 ,other-114))

(define-macro (py-bitand-boolX-sintY-inline self-116 other-117)
  `(py-bitand-boolX-sintY-fallback ,self-116 ,other-117))

(define-macro (py-bitand-boolX-bintY-inline self-119 other-120)
  `(py-bitand-boolX-bintY-fallback ,self-119 ,other-120))

(define-macro (py-bitand-sintX-intY-inline self-122 other-123)
  `(py-bitand-sintX-intY-fallback ,self-122 ,other-123))

(define-macro (py-bitand-sintX-floatY-inline self-125 other-126)
  `(let ((self-125 ,self-125) (other-126 ,other-126))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for &: 'int' and 'float'")))))

(define-macro (py-bitand-sintX-boolY-inline self-128 other-129)
  `(py-bitand-sintX-boolY-fallback ,self-128 ,other-129))

(define-macro (py-bitand-sintX-sintY-inline self-131 other-132)
  `(let ((self-131 ,self-131) (other-132 ,other-132))
     (py-int-from-scheme
      (py& (py-sint-to-scheme self-131) (py-sint-to-scheme other-132)))))

(define-macro (py-bitand-sintX-bintY-inline self-134 other-135)
  `(py-bitand-sintX-bintY-fallback ,self-134 ,other-135))

(define-macro (py-bitand-bintX-intY-inline self-137 other-138)
  `(py-bitand-bintX-intY-fallback ,self-137 ,other-138))

(define-macro (py-bitand-bintX-floatY-inline self-140 other-141)
  `(py-bitand-bintX-floatY-fallback ,self-140 ,other-141))

(define-macro (py-bitand-bintX-boolY-inline self-143 other-144)
  `(py-bitand-bintX-boolY-fallback ,self-143 ,other-144))

(define-macro (py-bitand-bintX-sintY-inline self-146 other-147)
  `(py-bitand-bintX-sintY-fallback ,self-146 ,other-147))

(define-macro (py-bitand-bintX-bintY-inline self-149 other-150)
  `(py-bitand-bintX-bintY-fallback ,self-149 ,other-150))

(define-macro (py-bitor-intX-intY-inline self-152 other-153)
  `(py-bitor-intX-intY-fallback ,self-152 ,other-153))

(define-macro (py-bitor-intX-floatY-inline self-155 other-156)
  `(py-bitor-intX-floatY-fallback ,self-155 ,other-156))

(define-macro (py-bitor-intX-boolY-inline self-158 other-159)
  `(py-bitor-intX-boolY-fallback ,self-158 ,other-159))

(define-macro (py-bitor-intX-sintY-inline self-161 other-162)
  `(py-bitor-intX-sintY-fallback ,self-161 ,other-162))

(define-macro (py-bitor-intX-bintY-inline self-164 other-165)
  `(py-bitor-intX-bintY-fallback ,self-164 ,other-165))

(define-macro (py-bitor-floatX-intY-inline self-167 other-168)
  `(py-bitor-floatX-intY-fallback ,self-167 ,other-168))

(define-macro (py-bitor-floatX-floatY-inline self-170 other-171)
  `(let ((self-170 ,self-170) (other-171 ,other-171))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for |: 'float' and 'float'")))))

(define-macro (py-bitor-floatX-boolY-inline self-173 other-174)
  `(py-bitor-floatX-boolY-fallback ,self-173 ,other-174))

(define-macro (py-bitor-floatX-sintY-inline self-176 other-177)
  `(let ((self-176 ,self-176) (other-177 ,other-177))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for |: 'float' and 'int'")))))

(define-macro (py-bitor-floatX-bintY-inline self-179 other-180)
  `(py-bitor-floatX-bintY-fallback ,self-179 ,other-180))

(define-macro (py-bitor-boolX-intY-inline self-182 other-183)
  `(py-bitor-boolX-intY-fallback ,self-182 ,other-183))

(define-macro (py-bitor-boolX-floatY-inline self-185 other-186)
  `(py-bitor-boolX-floatY-fallback ,self-185 ,other-186))

(define-macro (py-bitor-boolX-boolY-inline self-188 other-189)
  `(py-bitor-boolX-boolY-fallback ,self-188 ,other-189))

(define-macro (py-bitor-boolX-sintY-inline self-191 other-192)
  `(py-bitor-boolX-sintY-fallback ,self-191 ,other-192))

(define-macro (py-bitor-boolX-bintY-inline self-194 other-195)
  `(py-bitor-boolX-bintY-fallback ,self-194 ,other-195))

(define-macro (py-bitor-sintX-intY-inline self-197 other-198)
  `(py-bitor-sintX-intY-fallback ,self-197 ,other-198))

(define-macro (py-bitor-sintX-floatY-inline self-200 other-201)
  `(let ((self-200 ,self-200) (other-201 ,other-201))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for |: 'int' and 'float'")))))

(define-macro (py-bitor-sintX-boolY-inline self-203 other-204)
  `(py-bitor-sintX-boolY-fallback ,self-203 ,other-204))

(define-macro (py-bitor-sintX-sintY-inline self-206 other-207)
  `(let ((self-206 ,self-206) (other-207 ,other-207))
     (py-int-from-scheme
      (py+b (py-sint-to-scheme self-206) (py-sint-to-scheme other-207)))))

(define-macro (py-bitor-sintX-bintY-inline self-209 other-210)
  `(py-bitor-sintX-bintY-fallback ,self-209 ,other-210))

(define-macro (py-bitor-bintX-intY-inline self-212 other-213)
  `(py-bitor-bintX-intY-fallback ,self-212 ,other-213))

(define-macro (py-bitor-bintX-floatY-inline self-215 other-216)
  `(py-bitor-bintX-floatY-fallback ,self-215 ,other-216))

(define-macro (py-bitor-bintX-boolY-inline self-218 other-219)
  `(py-bitor-bintX-boolY-fallback ,self-218 ,other-219))

(define-macro (py-bitor-bintX-sintY-inline self-221 other-222)
  `(py-bitor-bintX-sintY-fallback ,self-221 ,other-222))

(define-macro (py-bitor-bintX-bintY-inline self-224 other-225)
  `(py-bitor-bintX-bintY-fallback ,self-224 ,other-225))

(define-macro (py-floordiv-intX-intY-inline self-227 other-228)
  `(py-floordiv-intX-intY-fallback ,self-227 ,other-228))

(define-macro (py-floordiv-intX-floatY-inline other-230 self-231)
  `(py-floordiv-intX-floatY-fallback ,other-230 ,self-231))

(define-macro (py-floordiv-intX-boolY-inline self-233 other-234)
  `(py-floordiv-intX-boolY-fallback ,self-233 ,other-234))

(define-macro (py-floordiv-intX-sintY-inline self-236 other-237)
  `(py-floordiv-intX-sintY-fallback ,self-236 ,other-237))

(define-macro (py-floordiv-intX-bintY-inline self-239 other-240)
  `(py-floordiv-intX-bintY-fallback ,self-239 ,other-240))

(define-macro (py-floordiv-floatX-intY-inline self-242 other-243)
  `(py-floordiv-floatX-intY-fallback ,self-242 ,other-243))

(define-macro (py-floordiv-floatX-floatY-inline self-245 other-246)
  `(let ((self-245 ,self-245) (other-246 ,other-246))
     (if (py-test (py-ne other-246 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py// (py-float-to-scheme self-245) (py-float-to-scheme other-246)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-floordiv-floatX-boolY-inline self-248 other-249)
  `(py-floordiv-floatX-boolY-fallback ,self-248 ,other-249))

(define-macro (py-floordiv-floatX-sintY-inline self-251 other-252)
  `(let ((self-251 ,self-251) (other-252 ,other-252))
     (if (py-test (py-ne other-252 (py-int-from-scheme 0)))
         (py-float-from-scheme
          (py// (py-float-to-scheme self-251) (py-sint-to-scheme other-252)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-floordiv-floatX-bintY-inline self-254 other-255)
  `(py-floordiv-floatX-bintY-fallback ,self-254 ,other-255))

(define-macro (py-floordiv-boolX-intY-inline self-257 other-258)
  `(py-floordiv-boolX-intY-fallback ,self-257 ,other-258))

(define-macro (py-floordiv-boolX-floatY-inline other-260 self-261)
  `(py-floordiv-boolX-floatY-fallback ,other-260 ,self-261))

(define-macro (py-floordiv-boolX-boolY-inline self-263 other-264)
  `(py-floordiv-boolX-boolY-fallback ,self-263 ,other-264))

(define-macro (py-floordiv-boolX-sintY-inline self-266 other-267)
  `(py-floordiv-boolX-sintY-fallback ,self-266 ,other-267))

(define-macro (py-floordiv-boolX-bintY-inline self-269 other-270)
  `(py-floordiv-boolX-bintY-fallback ,self-269 ,other-270))

(define-macro (py-floordiv-sintX-intY-inline self-272 other-273)
  `(py-floordiv-sintX-intY-fallback ,self-272 ,other-273))

(define-macro (py-floordiv-sintX-floatY-inline other-275 self-276)
  `(let ((other-275 ,other-275) (self-276 ,self-276))
     (if (py-test (py-ne self-276 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py// (py-sint-to-scheme other-275) (py-float-to-scheme self-276)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-floordiv-sintX-boolY-inline self-278 other-279)
  `(py-floordiv-sintX-boolY-fallback ,self-278 ,other-279))

(define-macro (py-floordiv-sintX-sintY-inline self-281 other-282)
  `(let ((self-281 ,self-281) (other-282 ,other-282))
     (if (py-test (py-ne other-282 (py-int-from-scheme 0)))
         (py-int-from-scheme
          (py// (py-sint-to-scheme self-281) (py-sint-to-scheme other-282)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "integer division by zero"))))))

(define-macro (py-floordiv-sintX-bintY-inline self-284 other-285)
  `(py-floordiv-sintX-bintY-fallback ,self-284 ,other-285))

(define-macro (py-floordiv-bintX-intY-inline self-287 other-288)
  `(py-floordiv-bintX-intY-fallback ,self-287 ,other-288))

(define-macro (py-floordiv-bintX-floatY-inline other-290 self-291)
  `(py-floordiv-bintX-floatY-fallback ,other-290 ,self-291))

(define-macro (py-floordiv-bintX-boolY-inline self-293 other-294)
  `(py-floordiv-bintX-boolY-fallback ,self-293 ,other-294))

(define-macro (py-floordiv-bintX-sintY-inline self-296 other-297)
  `(py-floordiv-bintX-sintY-fallback ,self-296 ,other-297))

(define-macro (py-floordiv-bintX-bintY-inline self-299 other-300)
  `(py-floordiv-bintX-bintY-fallback ,self-299 ,other-300))

(define-macro (py-lshift-intX-intY-inline self-302 other-303)
  `(py-lshift-intX-intY-fallback ,self-302 ,other-303))

(define-macro (py-lshift-intX-floatY-inline self-305 other-306)
  `(py-lshift-intX-floatY-fallback ,self-305 ,other-306))

(define-macro (py-lshift-intX-boolY-inline self-308 other-309)
  `(py-lshift-intX-boolY-fallback ,self-308 ,other-309))

(define-macro (py-lshift-intX-sintY-inline self-311 other-312)
  `(py-lshift-intX-sintY-fallback ,self-311 ,other-312))

(define-macro (py-lshift-intX-bintY-inline self-314 other-315)
  `(py-lshift-intX-bintY-fallback ,self-314 ,other-315))

(define-macro (py-lshift-floatX-intY-inline self-317 other-318)
  `(py-lshift-floatX-intY-fallback ,self-317 ,other-318))

(define-macro (py-lshift-floatX-floatY-inline self-320 other-321)
  `(let ((self-320 ,self-320) (other-321 ,other-321))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for <<: 'float' and 'float'")))))

(define-macro (py-lshift-floatX-boolY-inline self-323 other-324)
  `(py-lshift-floatX-boolY-fallback ,self-323 ,other-324))

(define-macro (py-lshift-floatX-sintY-inline self-326 other-327)
  `(let ((self-326 ,self-326) (other-327 ,other-327))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for <<: 'float' and 'int'")))))

(define-macro (py-lshift-floatX-bintY-inline self-329 other-330)
  `(py-lshift-floatX-bintY-fallback ,self-329 ,other-330))

(define-macro (py-lshift-boolX-intY-inline self-332 other-333)
  `(py-lshift-boolX-intY-fallback ,self-332 ,other-333))

(define-macro (py-lshift-boolX-floatY-inline self-335 other-336)
  `(py-lshift-boolX-floatY-fallback ,self-335 ,other-336))

(define-macro (py-lshift-boolX-boolY-inline self-338 other-339)
  `(py-lshift-boolX-boolY-fallback ,self-338 ,other-339))

(define-macro (py-lshift-boolX-sintY-inline self-341 other-342)
  `(py-lshift-boolX-sintY-fallback ,self-341 ,other-342))

(define-macro (py-lshift-boolX-bintY-inline self-344 other-345)
  `(py-lshift-boolX-bintY-fallback ,self-344 ,other-345))

(define-macro (py-lshift-sintX-intY-inline self-347 other-348)
  `(py-lshift-sintX-intY-fallback ,self-347 ,other-348))

(define-macro (py-lshift-sintX-floatY-inline self-350 other-351)
  `(let ((self-350 ,self-350) (other-351 ,other-351))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for <<: 'int' and 'float'")))))

(define-macro (py-lshift-sintX-boolY-inline self-353 other-354)
  `(py-lshift-sintX-boolY-fallback ,self-353 ,other-354))

(define-macro (py-lshift-sintX-sintY-inline self-356 other-357)
  `(let ((self-356 ,self-356) (other-357 ,other-357))
     (if (py-test (py-ge other-357 (py-int-from-scheme 0)))
         (py-int-from-scheme
          (py<< (py-sint-to-scheme self-356) (py-sint-to-scheme other-357)))
         (py-throw
          (py-call py-builtin-ValueError (&& "negative shift count"))))))

(define-macro (py-lshift-sintX-bintY-inline self-359 other-360)
  `(py-lshift-sintX-bintY-fallback ,self-359 ,other-360))

(define-macro (py-lshift-bintX-intY-inline self-362 other-363)
  `(py-lshift-bintX-intY-fallback ,self-362 ,other-363))

(define-macro (py-lshift-bintX-floatY-inline self-365 other-366)
  `(py-lshift-bintX-floatY-fallback ,self-365 ,other-366))

(define-macro (py-lshift-bintX-boolY-inline self-368 other-369)
  `(py-lshift-bintX-boolY-fallback ,self-368 ,other-369))

(define-macro (py-lshift-bintX-sintY-inline self-371 other-372)
  `(py-lshift-bintX-sintY-fallback ,self-371 ,other-372))

(define-macro (py-lshift-bintX-bintY-inline self-374 other-375)
  `(py-lshift-bintX-bintY-fallback ,self-374 ,other-375))

(define-macro (py-matmul-intX-intY-inline self-377 other-378)
  `(py-matmul-intX-intY-fallback ,self-377 ,other-378))

(define-macro (py-matmul-intX-floatY-inline self-380 other-381)
  `(py-matmul-intX-floatY-fallback ,self-380 ,other-381))

(define-macro (py-matmul-intX-boolY-inline self-383 other-384)
  `(py-matmul-intX-boolY-fallback ,self-383 ,other-384))

(define-macro (py-matmul-intX-sintY-inline self-386 other-387)
  `(py-matmul-intX-sintY-fallback ,self-386 ,other-387))

(define-macro (py-matmul-intX-bintY-inline self-389 other-390)
  `(py-matmul-intX-bintY-fallback ,self-389 ,other-390))

(define-macro (py-matmul-floatX-intY-inline self-392 other-393)
  `(py-matmul-floatX-intY-fallback ,self-392 ,other-393))

(define-macro (py-matmul-floatX-floatY-inline self-395 other-396)
  `(let ((self-395 ,self-395) (other-396 ,other-396))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @: 'float' and 'float'")))))

(define-macro (py-matmul-floatX-boolY-inline self-398 other-399)
  `(py-matmul-floatX-boolY-fallback ,self-398 ,other-399))

(define-macro (py-matmul-floatX-sintY-inline self-401 other-402)
  `(let ((self-401 ,self-401) (other-402 ,other-402))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @: 'float' and 'int'")))))

(define-macro (py-matmul-floatX-bintY-inline self-404 other-405)
  `(py-matmul-floatX-bintY-fallback ,self-404 ,other-405))

(define-macro (py-matmul-boolX-intY-inline self-407 other-408)
  `(py-matmul-boolX-intY-fallback ,self-407 ,other-408))

(define-macro (py-matmul-boolX-floatY-inline self-410 other-411)
  `(py-matmul-boolX-floatY-fallback ,self-410 ,other-411))

(define-macro (py-matmul-boolX-boolY-inline self-413 other-414)
  `(py-matmul-boolX-boolY-fallback ,self-413 ,other-414))

(define-macro (py-matmul-boolX-sintY-inline self-416 other-417)
  `(py-matmul-boolX-sintY-fallback ,self-416 ,other-417))

(define-macro (py-matmul-boolX-bintY-inline self-419 other-420)
  `(py-matmul-boolX-bintY-fallback ,self-419 ,other-420))

(define-macro (py-matmul-sintX-intY-inline self-422 other-423)
  `(py-matmul-sintX-intY-fallback ,self-422 ,other-423))

(define-macro (py-matmul-sintX-floatY-inline self-425 other-426)
  `(let ((self-425 ,self-425) (other-426 ,other-426))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @: 'int' and 'float'")))))

(define-macro (py-matmul-sintX-boolY-inline self-428 other-429)
  `(py-matmul-sintX-boolY-fallback ,self-428 ,other-429))

(define-macro (py-matmul-sintX-sintY-inline self-431 other-432)
  `(let ((self-431 ,self-431) (other-432 ,other-432))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @: 'int' and 'int'")))))

(define-macro (py-matmul-sintX-bintY-inline self-434 other-435)
  `(py-matmul-sintX-bintY-fallback ,self-434 ,other-435))

(define-macro (py-matmul-bintX-intY-inline self-437 other-438)
  `(py-matmul-bintX-intY-fallback ,self-437 ,other-438))

(define-macro (py-matmul-bintX-floatY-inline self-440 other-441)
  `(py-matmul-bintX-floatY-fallback ,self-440 ,other-441))

(define-macro (py-matmul-bintX-boolY-inline self-443 other-444)
  `(py-matmul-bintX-boolY-fallback ,self-443 ,other-444))

(define-macro (py-matmul-bintX-sintY-inline self-446 other-447)
  `(py-matmul-bintX-sintY-fallback ,self-446 ,other-447))

(define-macro (py-matmul-bintX-bintY-inline self-449 other-450)
  `(py-matmul-bintX-bintY-fallback ,self-449 ,other-450))

(define-macro (py-mod-intX-intY-inline self-452 other-453)
  `(py-mod-intX-intY-fallback ,self-452 ,other-453))

(define-macro (py-mod-intX-floatY-inline other-455 self-456)
  `(py-mod-intX-floatY-fallback ,other-455 ,self-456))

(define-macro (py-mod-intX-boolY-inline self-458 other-459)
  `(py-mod-intX-boolY-fallback ,self-458 ,other-459))

(define-macro (py-mod-intX-sintY-inline self-461 other-462)
  `(py-mod-intX-sintY-fallback ,self-461 ,other-462))

(define-macro (py-mod-intX-bintY-inline self-464 other-465)
  `(py-mod-intX-bintY-fallback ,self-464 ,other-465))

(define-macro (py-mod-floatX-intY-inline self-467 other-468)
  `(py-mod-floatX-intY-fallback ,self-467 ,other-468))

(define-macro (py-mod-floatX-floatY-inline self-470 other-471)
  `(let ((self-470 ,self-470) (other-471 ,other-471))
     (if (py-test (py-ne other-471 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py% (py-float-to-scheme self-470) (py-float-to-scheme other-471)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float modulo by zero"))))))

(define-macro (py-mod-floatX-boolY-inline self-473 other-474)
  `(py-mod-floatX-boolY-fallback ,self-473 ,other-474))

(define-macro (py-mod-floatX-sintY-inline self-476 other-477)
  `(let ((self-476 ,self-476) (other-477 ,other-477))
     (if (py-test (py-ne other-477 (py-int-from-scheme 0)))
         (py-float-from-scheme
          (py% (py-float-to-scheme self-476) (py-sint-to-scheme other-477)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float modulo by zero"))))))

(define-macro (py-mod-floatX-bintY-inline self-479 other-480)
  `(py-mod-floatX-bintY-fallback ,self-479 ,other-480))

(define-macro (py-mod-boolX-intY-inline self-482 other-483)
  `(py-mod-boolX-intY-fallback ,self-482 ,other-483))

(define-macro (py-mod-boolX-floatY-inline other-485 self-486)
  `(py-mod-boolX-floatY-fallback ,other-485 ,self-486))

(define-macro (py-mod-boolX-boolY-inline self-488 other-489)
  `(py-mod-boolX-boolY-fallback ,self-488 ,other-489))

(define-macro (py-mod-boolX-sintY-inline self-491 other-492)
  `(py-mod-boolX-sintY-fallback ,self-491 ,other-492))

(define-macro (py-mod-boolX-bintY-inline self-494 other-495)
  `(py-mod-boolX-bintY-fallback ,self-494 ,other-495))

(define-macro (py-mod-sintX-intY-inline self-497 other-498)
  `(py-mod-sintX-intY-fallback ,self-497 ,other-498))

(define-macro (py-mod-sintX-floatY-inline other-500 self-501)
  `(let ((other-500 ,other-500) (self-501 ,self-501))
     (if (py-test (py-ne self-501 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py% (py-sint-to-scheme other-500) (py-float-to-scheme self-501)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float modulo by zero"))))))

(define-macro (py-mod-sintX-boolY-inline self-503 other-504)
  `(py-mod-sintX-boolY-fallback ,self-503 ,other-504))

(define-macro (py-mod-sintX-sintY-inline self-506 other-507)
  `(let ((self-506 ,self-506) (other-507 ,other-507))
     (if (py-test (py-ne other-507 (py-int-from-scheme 0)))
         (py-int-from-scheme
          (py% (py-sint-to-scheme self-506) (py-sint-to-scheme other-507)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError (&& "modulo by zero"))))))

(define-macro (py-mod-sintX-bintY-inline self-509 other-510)
  `(py-mod-sintX-bintY-fallback ,self-509 ,other-510))

(define-macro (py-mod-bintX-intY-inline self-512 other-513)
  `(py-mod-bintX-intY-fallback ,self-512 ,other-513))

(define-macro (py-mod-bintX-floatY-inline other-515 self-516)
  `(py-mod-bintX-floatY-fallback ,other-515 ,self-516))

(define-macro (py-mod-bintX-boolY-inline self-518 other-519)
  `(py-mod-bintX-boolY-fallback ,self-518 ,other-519))

(define-macro (py-mod-bintX-sintY-inline self-521 other-522)
  `(py-mod-bintX-sintY-fallback ,self-521 ,other-522))

(define-macro (py-mod-bintX-bintY-inline self-524 other-525)
  `(py-mod-bintX-bintY-fallback ,self-524 ,other-525))

(define-macro (py-mul-intX-intY-inline self-527 other-528)
  `(py-mul-intX-intY-fallback ,self-527 ,other-528))

(define-macro (py-mul-intX-floatY-inline other-530 self-531)
  `(py-mul-intX-floatY-fallback ,other-530 ,self-531))

(define-macro (py-mul-intX-boolY-inline self-533 other-534)
  `(py-mul-intX-boolY-fallback ,self-533 ,other-534))

(define-macro (py-mul-intX-sintY-inline self-536 other-537)
  `(py-mul-intX-sintY-fallback ,self-536 ,other-537))

(define-macro (py-mul-intX-bintY-inline self-539 other-540)
  `(py-mul-intX-bintY-fallback ,self-539 ,other-540))

(define-macro (py-mul-floatX-intY-inline self-542 other-543)
  `(py-mul-floatX-intY-fallback ,self-542 ,other-543))

(define-macro (py-mul-floatX-floatY-inline self-545 other-546)
  `(let ((self-545 ,self-545) (other-546 ,other-546))
     (py-float-from-scheme
      (py* (py-float-to-scheme self-545) (py-float-to-scheme other-546)))))

(define-macro (py-mul-floatX-boolY-inline self-548 other-549)
  `(py-mul-floatX-boolY-fallback ,self-548 ,other-549))

(define-macro (py-mul-floatX-sintY-inline self-551 other-552)
  `(let ((self-551 ,self-551) (other-552 ,other-552))
     (py-float-from-scheme
      (py* (py-float-to-scheme self-551) (py-sint-to-scheme other-552)))))

(define-macro (py-mul-floatX-bintY-inline self-554 other-555)
  `(py-mul-floatX-bintY-fallback ,self-554 ,other-555))

(define-macro (py-mul-boolX-intY-inline self-557 other-558)
  `(py-mul-boolX-intY-fallback ,self-557 ,other-558))

(define-macro (py-mul-boolX-floatY-inline other-560 self-561)
  `(py-mul-boolX-floatY-fallback ,other-560 ,self-561))

(define-macro (py-mul-boolX-boolY-inline self-563 other-564)
  `(py-mul-boolX-boolY-fallback ,self-563 ,other-564))

(define-macro (py-mul-boolX-sintY-inline self-566 other-567)
  `(py-mul-boolX-sintY-fallback ,self-566 ,other-567))

(define-macro (py-mul-boolX-bintY-inline self-569 other-570)
  `(py-mul-boolX-bintY-fallback ,self-569 ,other-570))

(define-macro (py-mul-sintX-intY-inline self-572 other-573)
  `(py-mul-sintX-intY-fallback ,self-572 ,other-573))

(define-macro (py-mul-sintX-floatY-inline other-575 self-576)
  `(let ((other-575 ,other-575) (self-576 ,self-576))
     (py-float-from-scheme
      (py* (py-sint-to-scheme other-575) (py-float-to-scheme self-576)))))

(define-macro (py-mul-sintX-boolY-inline self-578 other-579)
  `(py-mul-sintX-boolY-fallback ,self-578 ,other-579))

(define-macro (py-mul-sintX-sintY-inline self-581 other-582)
  `(let ((self-581 ,self-581) (other-582 ,other-582))
     (py-int-from-scheme
      (py* (py-sint-to-scheme self-581) (py-sint-to-scheme other-582)))))

(define-macro (py-mul-sintX-bintY-inline self-584 other-585)
  `(py-mul-sintX-bintY-fallback ,self-584 ,other-585))

(define-macro (py-mul-bintX-intY-inline self-587 other-588)
  `(py-mul-bintX-intY-fallback ,self-587 ,other-588))

(define-macro (py-mul-bintX-floatY-inline other-590 self-591)
  `(py-mul-bintX-floatY-fallback ,other-590 ,self-591))

(define-macro (py-mul-bintX-boolY-inline self-593 other-594)
  `(py-mul-bintX-boolY-fallback ,self-593 ,other-594))

(define-macro (py-mul-bintX-sintY-inline self-596 other-597)
  `(py-mul-bintX-sintY-fallback ,self-596 ,other-597))

(define-macro (py-mul-bintX-bintY-inline self-599 other-600)
  `(py-mul-bintX-bintY-fallback ,self-599 ,other-600))

(define-macro (py-pow-intX-intY-inline self-602 other-603)
  `(py-pow-intX-intY-fallback ,self-602 ,other-603))

(define-macro (py-pow-intX-floatY-inline other-605 self-606)
  `(py-pow-intX-floatY-fallback ,other-605 ,self-606))

(define-macro (py-pow-intX-boolY-inline self-608 other-609)
  `(py-pow-intX-boolY-fallback ,self-608 ,other-609))

(define-macro (py-pow-intX-sintY-inline self-611 other-612)
  `(py-pow-intX-sintY-fallback ,self-611 ,other-612))

(define-macro (py-pow-intX-bintY-inline self-614 other-615)
  `(py-pow-intX-bintY-fallback ,self-614 ,other-615))

(define-macro (py-pow-floatX-intY-inline self-617 other-618)
  `(py-pow-floatX-intY-fallback ,self-617 ,other-618))

(define-macro (py-pow-floatX-floatY-inline self-620 other-621)
  `(let ((self-620 ,self-620) (other-621 ,other-621))
     (py-float-from-scheme
      (py** (py-float-to-scheme self-620) (py-float-to-scheme other-621)))))

(define-macro (py-pow-floatX-boolY-inline self-623 other-624)
  `(py-pow-floatX-boolY-fallback ,self-623 ,other-624))

(define-macro (py-pow-floatX-sintY-inline self-626 other-627)
  `(let ((self-626 ,self-626) (other-627 ,other-627))
     (py-float-from-scheme
      (py** (py-float-to-scheme self-626) (py-sint-to-scheme other-627)))))

(define-macro (py-pow-floatX-bintY-inline self-629 other-630)
  `(py-pow-floatX-bintY-fallback ,self-629 ,other-630))

(define-macro (py-pow-boolX-intY-inline self-632 other-633)
  `(py-pow-boolX-intY-fallback ,self-632 ,other-633))

(define-macro (py-pow-boolX-floatY-inline other-635 self-636)
  `(py-pow-boolX-floatY-fallback ,other-635 ,self-636))

(define-macro (py-pow-boolX-boolY-inline self-638 other-639)
  `(py-pow-boolX-boolY-fallback ,self-638 ,other-639))

(define-macro (py-pow-boolX-sintY-inline self-641 other-642)
  `(py-pow-boolX-sintY-fallback ,self-641 ,other-642))

(define-macro (py-pow-boolX-bintY-inline self-644 other-645)
  `(py-pow-boolX-bintY-fallback ,self-644 ,other-645))

(define-macro (py-pow-sintX-intY-inline self-647 other-648)
  `(py-pow-sintX-intY-fallback ,self-647 ,other-648))

(define-macro (py-pow-sintX-floatY-inline other-650 self-651)
  `(let ((other-650 ,other-650) (self-651 ,self-651))
     (py-float-from-scheme
      (py** (py-sint-to-scheme other-650) (py-float-to-scheme self-651)))))

(define-macro (py-pow-sintX-boolY-inline self-653 other-654)
  `(py-pow-sintX-boolY-fallback ,self-653 ,other-654))

(define-macro (py-pow-sintX-sintY-inline self-656 other-657)
  `(let ((self-656 ,self-656) (other-657 ,other-657))
     (py-int-from-scheme
      (py** (py-sint-to-scheme self-656) (py-sint-to-scheme other-657)))))

(define-macro (py-pow-sintX-bintY-inline self-659 other-660)
  `(py-pow-sintX-bintY-fallback ,self-659 ,other-660))

(define-macro (py-pow-bintX-intY-inline self-662 other-663)
  `(py-pow-bintX-intY-fallback ,self-662 ,other-663))

(define-macro (py-pow-bintX-floatY-inline other-665 self-666)
  `(py-pow-bintX-floatY-fallback ,other-665 ,self-666))

(define-macro (py-pow-bintX-boolY-inline self-668 other-669)
  `(py-pow-bintX-boolY-fallback ,self-668 ,other-669))

(define-macro (py-pow-bintX-sintY-inline self-671 other-672)
  `(py-pow-bintX-sintY-fallback ,self-671 ,other-672))

(define-macro (py-pow-bintX-bintY-inline self-674 other-675)
  `(py-pow-bintX-bintY-fallback ,self-674 ,other-675))

(define-macro (py-rshift-intX-intY-inline self-677 other-678)
  `(py-rshift-intX-intY-fallback ,self-677 ,other-678))

(define-macro (py-rshift-intX-floatY-inline self-680 other-681)
  `(py-rshift-intX-floatY-fallback ,self-680 ,other-681))

(define-macro (py-rshift-intX-boolY-inline self-683 other-684)
  `(py-rshift-intX-boolY-fallback ,self-683 ,other-684))

(define-macro (py-rshift-intX-sintY-inline self-686 other-687)
  `(py-rshift-intX-sintY-fallback ,self-686 ,other-687))

(define-macro (py-rshift-intX-bintY-inline self-689 other-690)
  `(py-rshift-intX-bintY-fallback ,self-689 ,other-690))

(define-macro (py-rshift-floatX-intY-inline self-692 other-693)
  `(py-rshift-floatX-intY-fallback ,self-692 ,other-693))

(define-macro (py-rshift-floatX-floatY-inline self-695 other-696)
  `(let ((self-695 ,self-695) (other-696 ,other-696))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for >>: 'float' and 'float'")))))

(define-macro (py-rshift-floatX-boolY-inline self-698 other-699)
  `(py-rshift-floatX-boolY-fallback ,self-698 ,other-699))

(define-macro (py-rshift-floatX-sintY-inline self-701 other-702)
  `(let ((self-701 ,self-701) (other-702 ,other-702))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for >>: 'float' and 'int'")))))

(define-macro (py-rshift-floatX-bintY-inline self-704 other-705)
  `(py-rshift-floatX-bintY-fallback ,self-704 ,other-705))

(define-macro (py-rshift-boolX-intY-inline self-707 other-708)
  `(py-rshift-boolX-intY-fallback ,self-707 ,other-708))

(define-macro (py-rshift-boolX-floatY-inline self-710 other-711)
  `(py-rshift-boolX-floatY-fallback ,self-710 ,other-711))

(define-macro (py-rshift-boolX-boolY-inline self-713 other-714)
  `(py-rshift-boolX-boolY-fallback ,self-713 ,other-714))

(define-macro (py-rshift-boolX-sintY-inline self-716 other-717)
  `(py-rshift-boolX-sintY-fallback ,self-716 ,other-717))

(define-macro (py-rshift-boolX-bintY-inline self-719 other-720)
  `(py-rshift-boolX-bintY-fallback ,self-719 ,other-720))

(define-macro (py-rshift-sintX-intY-inline self-722 other-723)
  `(py-rshift-sintX-intY-fallback ,self-722 ,other-723))

(define-macro (py-rshift-sintX-floatY-inline self-725 other-726)
  `(let ((self-725 ,self-725) (other-726 ,other-726))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for >>: 'int' and 'float'")))))

(define-macro (py-rshift-sintX-boolY-inline self-728 other-729)
  `(py-rshift-sintX-boolY-fallback ,self-728 ,other-729))

(define-macro (py-rshift-sintX-sintY-inline self-731 other-732)
  `(let ((self-731 ,self-731) (other-732 ,other-732))
     (if (py-test (py-ge other-732 (py-int-from-scheme 0)))
         (py-int-from-scheme
          (py>> (py-sint-to-scheme self-731) (py-sint-to-scheme other-732)))
         (py-throw
          (py-call py-builtin-ValueError (&& "negative shift count"))))))

(define-macro (py-rshift-sintX-bintY-inline self-734 other-735)
  `(py-rshift-sintX-bintY-fallback ,self-734 ,other-735))

(define-macro (py-rshift-bintX-intY-inline self-737 other-738)
  `(py-rshift-bintX-intY-fallback ,self-737 ,other-738))

(define-macro (py-rshift-bintX-floatY-inline self-740 other-741)
  `(py-rshift-bintX-floatY-fallback ,self-740 ,other-741))

(define-macro (py-rshift-bintX-boolY-inline self-743 other-744)
  `(py-rshift-bintX-boolY-fallback ,self-743 ,other-744))

(define-macro (py-rshift-bintX-sintY-inline self-746 other-747)
  `(py-rshift-bintX-sintY-fallback ,self-746 ,other-747))

(define-macro (py-rshift-bintX-bintY-inline self-749 other-750)
  `(py-rshift-bintX-bintY-fallback ,self-749 ,other-750))

(define-macro (py-sub-intX-intY-inline self-752 other-753)
  `(py-sub-intX-intY-fallback ,self-752 ,other-753))

(define-macro (py-sub-intX-floatY-inline other-755 self-756)
  `(py-sub-intX-floatY-fallback ,other-755 ,self-756))

(define-macro (py-sub-intX-boolY-inline self-758 other-759)
  `(py-sub-intX-boolY-fallback ,self-758 ,other-759))

(define-macro (py-sub-intX-sintY-inline self-761 other-762)
  `(py-sub-intX-sintY-fallback ,self-761 ,other-762))

(define-macro (py-sub-intX-bintY-inline self-764 other-765)
  `(py-sub-intX-bintY-fallback ,self-764 ,other-765))

(define-macro (py-sub-floatX-intY-inline self-767 other-768)
  `(py-sub-floatX-intY-fallback ,self-767 ,other-768))

(define-macro (py-sub-floatX-floatY-inline self-770 other-771)
  `(let ((self-770 ,self-770) (other-771 ,other-771))
     (py-float-from-scheme
      (py- (py-float-to-scheme self-770) (py-float-to-scheme other-771)))))

(define-macro (py-sub-floatX-boolY-inline self-773 other-774)
  `(py-sub-floatX-boolY-fallback ,self-773 ,other-774))

(define-macro (py-sub-floatX-sintY-inline self-776 other-777)
  `(let ((self-776 ,self-776) (other-777 ,other-777))
     (py-float-from-scheme
      (py- (py-float-to-scheme self-776) (py-sint-to-scheme other-777)))))

(define-macro (py-sub-floatX-bintY-inline self-779 other-780)
  `(py-sub-floatX-bintY-fallback ,self-779 ,other-780))

(define-macro (py-sub-boolX-intY-inline self-782 other-783)
  `(py-sub-boolX-intY-fallback ,self-782 ,other-783))

(define-macro (py-sub-boolX-floatY-inline other-785 self-786)
  `(py-sub-boolX-floatY-fallback ,other-785 ,self-786))

(define-macro (py-sub-boolX-boolY-inline self-788 other-789)
  `(py-sub-boolX-boolY-fallback ,self-788 ,other-789))

(define-macro (py-sub-boolX-sintY-inline self-791 other-792)
  `(py-sub-boolX-sintY-fallback ,self-791 ,other-792))

(define-macro (py-sub-boolX-bintY-inline self-794 other-795)
  `(py-sub-boolX-bintY-fallback ,self-794 ,other-795))

(define-macro (py-sub-sintX-intY-inline self-797 other-798)
  `(py-sub-sintX-intY-fallback ,self-797 ,other-798))

(define-macro (py-sub-sintX-floatY-inline other-800 self-801)
  `(let ((other-800 ,other-800) (self-801 ,self-801))
     (py-float-from-scheme
      (py- (py-sint-to-scheme other-800) (py-float-to-scheme self-801)))))

(define-macro (py-sub-sintX-boolY-inline self-803 other-804)
  `(py-sub-sintX-boolY-fallback ,self-803 ,other-804))

(define-macro (py-sub-sintX-sintY-inline self-806 other-807)
  `(let ((self-806 ,self-806) (other-807 ,other-807))
     (py-int-from-scheme
      (py- (py-sint-to-scheme self-806) (py-sint-to-scheme other-807)))))

(define-macro (py-sub-sintX-bintY-inline self-809 other-810)
  `(py-sub-sintX-bintY-fallback ,self-809 ,other-810))

(define-macro (py-sub-bintX-intY-inline self-812 other-813)
  `(py-sub-bintX-intY-fallback ,self-812 ,other-813))

(define-macro (py-sub-bintX-floatY-inline other-815 self-816)
  `(py-sub-bintX-floatY-fallback ,other-815 ,self-816))

(define-macro (py-sub-bintX-boolY-inline self-818 other-819)
  `(py-sub-bintX-boolY-fallback ,self-818 ,other-819))

(define-macro (py-sub-bintX-sintY-inline self-821 other-822)
  `(py-sub-bintX-sintY-fallback ,self-821 ,other-822))

(define-macro (py-sub-bintX-bintY-inline self-824 other-825)
  `(py-sub-bintX-bintY-fallback ,self-824 ,other-825))

(define-macro (py-truediv-intX-intY-inline self-827 other-828)
  `(py-truediv-intX-intY-fallback ,self-827 ,other-828))

(define-macro (py-truediv-intX-floatY-inline other-830 self-831)
  `(py-truediv-intX-floatY-fallback ,other-830 ,self-831))

(define-macro (py-truediv-intX-boolY-inline self-833 other-834)
  `(py-truediv-intX-boolY-fallback ,self-833 ,other-834))

(define-macro (py-truediv-intX-sintY-inline self-836 other-837)
  `(py-truediv-intX-sintY-fallback ,self-836 ,other-837))

(define-macro (py-truediv-intX-bintY-inline self-839 other-840)
  `(py-truediv-intX-bintY-fallback ,self-839 ,other-840))

(define-macro (py-truediv-floatX-intY-inline self-842 other-843)
  `(py-truediv-floatX-intY-fallback ,self-842 ,other-843))

(define-macro (py-truediv-floatX-floatY-inline self-845 other-846)
  `(let ((self-845 ,self-845) (other-846 ,other-846))
     (if (py-test (py-ne other-846 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py/ (py-float-to-scheme self-845) (py-float-to-scheme other-846)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-truediv-floatX-boolY-inline self-848 other-849)
  `(py-truediv-floatX-boolY-fallback ,self-848 ,other-849))

(define-macro (py-truediv-floatX-sintY-inline self-851 other-852)
  `(let ((self-851 ,self-851) (other-852 ,other-852))
     (if (py-test (py-ne other-852 (py-int-from-scheme 0)))
         (py-float-from-scheme
          (py/ (py-float-to-scheme self-851) (py-sint-to-scheme other-852)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-truediv-floatX-bintY-inline self-854 other-855)
  `(py-truediv-floatX-bintY-fallback ,self-854 ,other-855))

(define-macro (py-truediv-boolX-intY-inline self-857 other-858)
  `(py-truediv-boolX-intY-fallback ,self-857 ,other-858))

(define-macro (py-truediv-boolX-floatY-inline other-860 self-861)
  `(py-truediv-boolX-floatY-fallback ,other-860 ,self-861))

(define-macro (py-truediv-boolX-boolY-inline self-863 other-864)
  `(py-truediv-boolX-boolY-fallback ,self-863 ,other-864))

(define-macro (py-truediv-boolX-sintY-inline self-866 other-867)
  `(py-truediv-boolX-sintY-fallback ,self-866 ,other-867))

(define-macro (py-truediv-boolX-bintY-inline self-869 other-870)
  `(py-truediv-boolX-bintY-fallback ,self-869 ,other-870))

(define-macro (py-truediv-sintX-intY-inline self-872 other-873)
  `(py-truediv-sintX-intY-fallback ,self-872 ,other-873))

(define-macro (py-truediv-sintX-floatY-inline other-875 self-876)
  `(let ((other-875 ,other-875) (self-876 ,self-876))
     (if (py-test (py-ne self-876 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py/ (py-sint-to-scheme other-875) (py-float-to-scheme self-876)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-truediv-sintX-boolY-inline self-878 other-879)
  `(py-truediv-sintX-boolY-fallback ,self-878 ,other-879))

(define-macro (py-truediv-sintX-sintY-inline self-881 other-882)
  `(let ((self-881 ,self-881) (other-882 ,other-882))
     (if (py-test (py-ne other-882 (py-int-from-scheme 0)))
         (py-float-from-scheme
          (py/ (py-sint-to-scheme self-881) (py-sint-to-scheme other-882)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError (&& "division by zero"))))))

(define-macro (py-truediv-sintX-bintY-inline self-884 other-885)
  `(py-truediv-sintX-bintY-fallback ,self-884 ,other-885))

(define-macro (py-truediv-bintX-intY-inline self-887 other-888)
  `(py-truediv-bintX-intY-fallback ,self-887 ,other-888))

(define-macro (py-truediv-bintX-floatY-inline other-890 self-891)
  `(py-truediv-bintX-floatY-fallback ,other-890 ,self-891))

(define-macro (py-truediv-bintX-boolY-inline self-893 other-894)
  `(py-truediv-bintX-boolY-fallback ,self-893 ,other-894))

(define-macro (py-truediv-bintX-sintY-inline self-896 other-897)
  `(py-truediv-bintX-sintY-fallback ,self-896 ,other-897))

(define-macro (py-truediv-bintX-bintY-inline self-899 other-900)
  `(py-truediv-bintX-bintY-fallback ,self-899 ,other-900))

(define-macro (py-xor-intX-intY-inline self-902 other-903)
  `(py-xor-intX-intY-fallback ,self-902 ,other-903))

(define-macro (py-xor-intX-floatY-inline self-905 other-906)
  `(py-xor-intX-floatY-fallback ,self-905 ,other-906))

(define-macro (py-xor-intX-boolY-inline self-908 other-909)
  `(py-xor-intX-boolY-fallback ,self-908 ,other-909))

(define-macro (py-xor-intX-sintY-inline self-911 other-912)
  `(py-xor-intX-sintY-fallback ,self-911 ,other-912))

(define-macro (py-xor-intX-bintY-inline self-914 other-915)
  `(py-xor-intX-bintY-fallback ,self-914 ,other-915))

(define-macro (py-xor-floatX-intY-inline self-917 other-918)
  `(py-xor-floatX-intY-fallback ,self-917 ,other-918))

(define-macro (py-xor-floatX-floatY-inline self-920 other-921)
  `(let ((self-920 ,self-920) (other-921 ,other-921))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for ^: 'float' and 'float'")))))

(define-macro (py-xor-floatX-boolY-inline self-923 other-924)
  `(py-xor-floatX-boolY-fallback ,self-923 ,other-924))

(define-macro (py-xor-floatX-sintY-inline self-926 other-927)
  `(let ((self-926 ,self-926) (other-927 ,other-927))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for ^: 'float' and 'int'")))))

(define-macro (py-xor-floatX-bintY-inline self-929 other-930)
  `(py-xor-floatX-bintY-fallback ,self-929 ,other-930))

(define-macro (py-xor-boolX-intY-inline self-932 other-933)
  `(py-xor-boolX-intY-fallback ,self-932 ,other-933))

(define-macro (py-xor-boolX-floatY-inline self-935 other-936)
  `(py-xor-boolX-floatY-fallback ,self-935 ,other-936))

(define-macro (py-xor-boolX-boolY-inline self-938 other-939)
  `(py-xor-boolX-boolY-fallback ,self-938 ,other-939))

(define-macro (py-xor-boolX-sintY-inline self-941 other-942)
  `(py-xor-boolX-sintY-fallback ,self-941 ,other-942))

(define-macro (py-xor-boolX-bintY-inline self-944 other-945)
  `(py-xor-boolX-bintY-fallback ,self-944 ,other-945))

(define-macro (py-xor-sintX-intY-inline self-947 other-948)
  `(py-xor-sintX-intY-fallback ,self-947 ,other-948))

(define-macro (py-xor-sintX-floatY-inline self-950 other-951)
  `(let ((self-950 ,self-950) (other-951 ,other-951))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for ^: 'int' and 'float'")))))

(define-macro (py-xor-sintX-boolY-inline self-953 other-954)
  `(py-xor-sintX-boolY-fallback ,self-953 ,other-954))

(define-macro (py-xor-sintX-sintY-inline self-956 other-957)
  `(let ((self-956 ,self-956) (other-957 ,other-957))
     (py-int-from-scheme
      (py^ (py-sint-to-scheme self-956) (py-sint-to-scheme other-957)))))

(define-macro (py-xor-sintX-bintY-inline self-959 other-960)
  `(py-xor-sintX-bintY-fallback ,self-959 ,other-960))

(define-macro (py-xor-bintX-intY-inline self-962 other-963)
  `(py-xor-bintX-intY-fallback ,self-962 ,other-963))

(define-macro (py-xor-bintX-floatY-inline self-965 other-966)
  `(py-xor-bintX-floatY-fallback ,self-965 ,other-966))

(define-macro (py-xor-bintX-boolY-inline self-968 other-969)
  `(py-xor-bintX-boolY-fallback ,self-968 ,other-969))

(define-macro (py-xor-bintX-sintY-inline self-971 other-972)
  `(py-xor-bintX-sintY-fallback ,self-971 ,other-972))

(define-macro (py-xor-bintX-bintY-inline self-974 other-975)
  `(py-xor-bintX-bintY-fallback ,self-974 ,other-975))

(define-macro (py-iadd-intX-intY-inline self-977 other-978)
  `(py-iadd-intX-intY-fallback ,self-977 ,other-978))

(define-macro (py-iadd-intX-floatY-inline other-980 self-981)
  `(py-iadd-intX-floatY-fallback ,other-980 ,self-981))

(define-macro (py-iadd-intX-boolY-inline self-983 other-984)
  `(py-iadd-intX-boolY-fallback ,self-983 ,other-984))

(define-macro (py-iadd-intX-sintY-inline self-986 other-987)
  `(py-iadd-intX-sintY-fallback ,self-986 ,other-987))

(define-macro (py-iadd-intX-bintY-inline self-989 other-990)
  `(py-iadd-intX-bintY-fallback ,self-989 ,other-990))

(define-macro (py-iadd-floatX-intY-inline self-992 other-993)
  `(py-iadd-floatX-intY-fallback ,self-992 ,other-993))

(define-macro (py-iadd-floatX-floatY-inline self-995 other-996)
  `(let ((self-995 ,self-995) (other-996 ,other-996))
     (py-float-from-scheme
      (py+ (py-float-to-scheme self-995) (py-float-to-scheme other-996)))))

(define-macro (py-iadd-floatX-boolY-inline self-998 other-999)
  `(py-iadd-floatX-boolY-fallback ,self-998 ,other-999))

(define-macro (py-iadd-floatX-sintY-inline self-1001 other-1002)
  `(let ((self-1001 ,self-1001) (other-1002 ,other-1002))
     (py-float-from-scheme
      (py+ (py-float-to-scheme self-1001) (py-sint-to-scheme other-1002)))))

(define-macro (py-iadd-floatX-bintY-inline self-1004 other-1005)
  `(py-iadd-floatX-bintY-fallback ,self-1004 ,other-1005))

(define-macro (py-iadd-boolX-intY-inline self-1007 other-1008)
  `(py-iadd-boolX-intY-fallback ,self-1007 ,other-1008))

(define-macro (py-iadd-boolX-floatY-inline other-1010 self-1011)
  `(py-iadd-boolX-floatY-fallback ,other-1010 ,self-1011))

(define-macro (py-iadd-boolX-boolY-inline self-1013 other-1014)
  `(py-iadd-boolX-boolY-fallback ,self-1013 ,other-1014))

(define-macro (py-iadd-boolX-sintY-inline self-1016 other-1017)
  `(py-iadd-boolX-sintY-fallback ,self-1016 ,other-1017))

(define-macro (py-iadd-boolX-bintY-inline self-1019 other-1020)
  `(py-iadd-boolX-bintY-fallback ,self-1019 ,other-1020))

(define-macro (py-iadd-sintX-intY-inline self-1022 other-1023)
  `(py-iadd-sintX-intY-fallback ,self-1022 ,other-1023))

(define-macro (py-iadd-sintX-floatY-inline other-1025 self-1026)
  `(let ((other-1025 ,other-1025) (self-1026 ,self-1026))
     (py-float-from-scheme
      (py+ (py-sint-to-scheme other-1025) (py-float-to-scheme self-1026)))))

(define-macro (py-iadd-sintX-boolY-inline self-1028 other-1029)
  `(py-iadd-sintX-boolY-fallback ,self-1028 ,other-1029))

(define-macro (py-iadd-sintX-sintY-inline self-1031 other-1032)
  `(let ((self-1031 ,self-1031) (other-1032 ,other-1032))
     (py-int-from-scheme
      (py+ (py-sint-to-scheme self-1031) (py-sint-to-scheme other-1032)))))

(define-macro (py-iadd-sintX-bintY-inline self-1034 other-1035)
  `(py-iadd-sintX-bintY-fallback ,self-1034 ,other-1035))

(define-macro (py-iadd-bintX-intY-inline self-1037 other-1038)
  `(py-iadd-bintX-intY-fallback ,self-1037 ,other-1038))

(define-macro (py-iadd-bintX-floatY-inline other-1040 self-1041)
  `(py-iadd-bintX-floatY-fallback ,other-1040 ,self-1041))

(define-macro (py-iadd-bintX-boolY-inline self-1043 other-1044)
  `(py-iadd-bintX-boolY-fallback ,self-1043 ,other-1044))

(define-macro (py-iadd-bintX-sintY-inline self-1046 other-1047)
  `(py-iadd-bintX-sintY-fallback ,self-1046 ,other-1047))

(define-macro (py-iadd-bintX-bintY-inline self-1049 other-1050)
  `(py-iadd-bintX-bintY-fallback ,self-1049 ,other-1050))

(define-macro (py-ibitand-intX-intY-inline self-1052 other-1053)
  `(py-ibitand-intX-intY-fallback ,self-1052 ,other-1053))

(define-macro (py-ibitand-intX-floatY-inline self-1055 other-1056)
  `(py-ibitand-intX-floatY-fallback ,self-1055 ,other-1056))

(define-macro (py-ibitand-intX-boolY-inline self-1058 other-1059)
  `(py-ibitand-intX-boolY-fallback ,self-1058 ,other-1059))

(define-macro (py-ibitand-intX-sintY-inline self-1061 other-1062)
  `(py-ibitand-intX-sintY-fallback ,self-1061 ,other-1062))

(define-macro (py-ibitand-intX-bintY-inline self-1064 other-1065)
  `(py-ibitand-intX-bintY-fallback ,self-1064 ,other-1065))

(define-macro (py-ibitand-floatX-intY-inline self-1067 other-1068)
  `(py-ibitand-floatX-intY-fallback ,self-1067 ,other-1068))

(define-macro (py-ibitand-floatX-floatY-inline self-1070 other-1071)
  `(let ((self-1070 ,self-1070) (other-1071 ,other-1071))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for &=: 'float' and 'float'")))))

(define-macro (py-ibitand-floatX-boolY-inline self-1073 other-1074)
  `(py-ibitand-floatX-boolY-fallback ,self-1073 ,other-1074))

(define-macro (py-ibitand-floatX-sintY-inline self-1076 other-1077)
  `(let ((self-1076 ,self-1076) (other-1077 ,other-1077))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for &=: 'float' and 'int'")))))

(define-macro (py-ibitand-floatX-bintY-inline self-1079 other-1080)
  `(py-ibitand-floatX-bintY-fallback ,self-1079 ,other-1080))

(define-macro (py-ibitand-boolX-intY-inline self-1082 other-1083)
  `(py-ibitand-boolX-intY-fallback ,self-1082 ,other-1083))

(define-macro (py-ibitand-boolX-floatY-inline self-1085 other-1086)
  `(py-ibitand-boolX-floatY-fallback ,self-1085 ,other-1086))

(define-macro (py-ibitand-boolX-boolY-inline self-1088 other-1089)
  `(py-ibitand-boolX-boolY-fallback ,self-1088 ,other-1089))

(define-macro (py-ibitand-boolX-sintY-inline self-1091 other-1092)
  `(py-ibitand-boolX-sintY-fallback ,self-1091 ,other-1092))

(define-macro (py-ibitand-boolX-bintY-inline self-1094 other-1095)
  `(py-ibitand-boolX-bintY-fallback ,self-1094 ,other-1095))

(define-macro (py-ibitand-sintX-intY-inline self-1097 other-1098)
  `(py-ibitand-sintX-intY-fallback ,self-1097 ,other-1098))

(define-macro (py-ibitand-sintX-floatY-inline self-1100 other-1101)
  `(let ((self-1100 ,self-1100) (other-1101 ,other-1101))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for &=: 'int' and 'float'")))))

(define-macro (py-ibitand-sintX-boolY-inline self-1103 other-1104)
  `(py-ibitand-sintX-boolY-fallback ,self-1103 ,other-1104))

(define-macro (py-ibitand-sintX-sintY-inline self-1106 other-1107)
  `(let ((self-1106 ,self-1106) (other-1107 ,other-1107))
     (py-int-from-scheme
      (py& (py-sint-to-scheme self-1106) (py-sint-to-scheme other-1107)))))

(define-macro (py-ibitand-sintX-bintY-inline self-1109 other-1110)
  `(py-ibitand-sintX-bintY-fallback ,self-1109 ,other-1110))

(define-macro (py-ibitand-bintX-intY-inline self-1112 other-1113)
  `(py-ibitand-bintX-intY-fallback ,self-1112 ,other-1113))

(define-macro (py-ibitand-bintX-floatY-inline self-1115 other-1116)
  `(py-ibitand-bintX-floatY-fallback ,self-1115 ,other-1116))

(define-macro (py-ibitand-bintX-boolY-inline self-1118 other-1119)
  `(py-ibitand-bintX-boolY-fallback ,self-1118 ,other-1119))

(define-macro (py-ibitand-bintX-sintY-inline self-1121 other-1122)
  `(py-ibitand-bintX-sintY-fallback ,self-1121 ,other-1122))

(define-macro (py-ibitand-bintX-bintY-inline self-1124 other-1125)
  `(py-ibitand-bintX-bintY-fallback ,self-1124 ,other-1125))

(define-macro (py-ibitor-intX-intY-inline self-1127 other-1128)
  `(py-ibitor-intX-intY-fallback ,self-1127 ,other-1128))

(define-macro (py-ibitor-intX-floatY-inline self-1130 other-1131)
  `(py-ibitor-intX-floatY-fallback ,self-1130 ,other-1131))

(define-macro (py-ibitor-intX-boolY-inline self-1133 other-1134)
  `(py-ibitor-intX-boolY-fallback ,self-1133 ,other-1134))

(define-macro (py-ibitor-intX-sintY-inline self-1136 other-1137)
  `(py-ibitor-intX-sintY-fallback ,self-1136 ,other-1137))

(define-macro (py-ibitor-intX-bintY-inline self-1139 other-1140)
  `(py-ibitor-intX-bintY-fallback ,self-1139 ,other-1140))

(define-macro (py-ibitor-floatX-intY-inline self-1142 other-1143)
  `(py-ibitor-floatX-intY-fallback ,self-1142 ,other-1143))

(define-macro (py-ibitor-floatX-floatY-inline self-1145 other-1146)
  `(let ((self-1145 ,self-1145) (other-1146 ,other-1146))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for |=: 'float' and 'float'")))))

(define-macro (py-ibitor-floatX-boolY-inline self-1148 other-1149)
  `(py-ibitor-floatX-boolY-fallback ,self-1148 ,other-1149))

(define-macro (py-ibitor-floatX-sintY-inline self-1151 other-1152)
  `(let ((self-1151 ,self-1151) (other-1152 ,other-1152))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for |=: 'float' and 'int'")))))

(define-macro (py-ibitor-floatX-bintY-inline self-1154 other-1155)
  `(py-ibitor-floatX-bintY-fallback ,self-1154 ,other-1155))

(define-macro (py-ibitor-boolX-intY-inline self-1157 other-1158)
  `(py-ibitor-boolX-intY-fallback ,self-1157 ,other-1158))

(define-macro (py-ibitor-boolX-floatY-inline self-1160 other-1161)
  `(py-ibitor-boolX-floatY-fallback ,self-1160 ,other-1161))

(define-macro (py-ibitor-boolX-boolY-inline self-1163 other-1164)
  `(py-ibitor-boolX-boolY-fallback ,self-1163 ,other-1164))

(define-macro (py-ibitor-boolX-sintY-inline self-1166 other-1167)
  `(py-ibitor-boolX-sintY-fallback ,self-1166 ,other-1167))

(define-macro (py-ibitor-boolX-bintY-inline self-1169 other-1170)
  `(py-ibitor-boolX-bintY-fallback ,self-1169 ,other-1170))

(define-macro (py-ibitor-sintX-intY-inline self-1172 other-1173)
  `(py-ibitor-sintX-intY-fallback ,self-1172 ,other-1173))

(define-macro (py-ibitor-sintX-floatY-inline self-1175 other-1176)
  `(let ((self-1175 ,self-1175) (other-1176 ,other-1176))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for |=: 'int' and 'float'")))))

(define-macro (py-ibitor-sintX-boolY-inline self-1178 other-1179)
  `(py-ibitor-sintX-boolY-fallback ,self-1178 ,other-1179))

(define-macro (py-ibitor-sintX-sintY-inline self-1181 other-1182)
  `(let ((self-1181 ,self-1181) (other-1182 ,other-1182))
     (py-int-from-scheme
      (py+b (py-sint-to-scheme self-1181) (py-sint-to-scheme other-1182)))))

(define-macro (py-ibitor-sintX-bintY-inline self-1184 other-1185)
  `(py-ibitor-sintX-bintY-fallback ,self-1184 ,other-1185))

(define-macro (py-ibitor-bintX-intY-inline self-1187 other-1188)
  `(py-ibitor-bintX-intY-fallback ,self-1187 ,other-1188))

(define-macro (py-ibitor-bintX-floatY-inline self-1190 other-1191)
  `(py-ibitor-bintX-floatY-fallback ,self-1190 ,other-1191))

(define-macro (py-ibitor-bintX-boolY-inline self-1193 other-1194)
  `(py-ibitor-bintX-boolY-fallback ,self-1193 ,other-1194))

(define-macro (py-ibitor-bintX-sintY-inline self-1196 other-1197)
  `(py-ibitor-bintX-sintY-fallback ,self-1196 ,other-1197))

(define-macro (py-ibitor-bintX-bintY-inline self-1199 other-1200)
  `(py-ibitor-bintX-bintY-fallback ,self-1199 ,other-1200))

(define-macro (py-ifloordiv-intX-intY-inline self-1202 other-1203)
  `(py-ifloordiv-intX-intY-fallback ,self-1202 ,other-1203))

(define-macro (py-ifloordiv-intX-floatY-inline other-1205 self-1206)
  `(py-ifloordiv-intX-floatY-fallback ,other-1205 ,self-1206))

(define-macro (py-ifloordiv-intX-boolY-inline self-1208 other-1209)
  `(py-ifloordiv-intX-boolY-fallback ,self-1208 ,other-1209))

(define-macro (py-ifloordiv-intX-sintY-inline self-1211 other-1212)
  `(py-ifloordiv-intX-sintY-fallback ,self-1211 ,other-1212))

(define-macro (py-ifloordiv-intX-bintY-inline self-1214 other-1215)
  `(py-ifloordiv-intX-bintY-fallback ,self-1214 ,other-1215))

(define-macro (py-ifloordiv-floatX-intY-inline self-1217 other-1218)
  `(py-ifloordiv-floatX-intY-fallback ,self-1217 ,other-1218))

(define-macro (py-ifloordiv-floatX-floatY-inline self-1220 other-1221)
  `(let ((self-1220 ,self-1220) (other-1221 ,other-1221))
     (if (py-test (py-ne other-1221 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py// (py-float-to-scheme self-1220)
                (py-float-to-scheme other-1221)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-ifloordiv-floatX-boolY-inline self-1223 other-1224)
  `(py-ifloordiv-floatX-boolY-fallback ,self-1223 ,other-1224))

(define-macro (py-ifloordiv-floatX-sintY-inline self-1226 other-1227)
  `(let ((self-1226 ,self-1226) (other-1227 ,other-1227))
     (if (py-test (py-ne other-1227 (py-int-from-scheme 0)))
         (py-float-from-scheme
          (py// (py-float-to-scheme self-1226) (py-sint-to-scheme other-1227)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-ifloordiv-floatX-bintY-inline self-1229 other-1230)
  `(py-ifloordiv-floatX-bintY-fallback ,self-1229 ,other-1230))

(define-macro (py-ifloordiv-boolX-intY-inline self-1232 other-1233)
  `(py-ifloordiv-boolX-intY-fallback ,self-1232 ,other-1233))

(define-macro (py-ifloordiv-boolX-floatY-inline other-1235 self-1236)
  `(py-ifloordiv-boolX-floatY-fallback ,other-1235 ,self-1236))

(define-macro (py-ifloordiv-boolX-boolY-inline self-1238 other-1239)
  `(py-ifloordiv-boolX-boolY-fallback ,self-1238 ,other-1239))

(define-macro (py-ifloordiv-boolX-sintY-inline self-1241 other-1242)
  `(py-ifloordiv-boolX-sintY-fallback ,self-1241 ,other-1242))

(define-macro (py-ifloordiv-boolX-bintY-inline self-1244 other-1245)
  `(py-ifloordiv-boolX-bintY-fallback ,self-1244 ,other-1245))

(define-macro (py-ifloordiv-sintX-intY-inline self-1247 other-1248)
  `(py-ifloordiv-sintX-intY-fallback ,self-1247 ,other-1248))

(define-macro (py-ifloordiv-sintX-floatY-inline other-1250 self-1251)
  `(let ((other-1250 ,other-1250) (self-1251 ,self-1251))
     (if (py-test (py-ne self-1251 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py// (py-sint-to-scheme other-1250) (py-float-to-scheme self-1251)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-ifloordiv-sintX-boolY-inline self-1253 other-1254)
  `(py-ifloordiv-sintX-boolY-fallback ,self-1253 ,other-1254))

(define-macro (py-ifloordiv-sintX-sintY-inline self-1256 other-1257)
  `(let ((self-1256 ,self-1256) (other-1257 ,other-1257))
     (if (py-test (py-ne other-1257 (py-int-from-scheme 0)))
         (py-int-from-scheme
          (py// (py-sint-to-scheme self-1256) (py-sint-to-scheme other-1257)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "integer division by zero"))))))

(define-macro (py-ifloordiv-sintX-bintY-inline self-1259 other-1260)
  `(py-ifloordiv-sintX-bintY-fallback ,self-1259 ,other-1260))

(define-macro (py-ifloordiv-bintX-intY-inline self-1262 other-1263)
  `(py-ifloordiv-bintX-intY-fallback ,self-1262 ,other-1263))

(define-macro (py-ifloordiv-bintX-floatY-inline other-1265 self-1266)
  `(py-ifloordiv-bintX-floatY-fallback ,other-1265 ,self-1266))

(define-macro (py-ifloordiv-bintX-boolY-inline self-1268 other-1269)
  `(py-ifloordiv-bintX-boolY-fallback ,self-1268 ,other-1269))

(define-macro (py-ifloordiv-bintX-sintY-inline self-1271 other-1272)
  `(py-ifloordiv-bintX-sintY-fallback ,self-1271 ,other-1272))

(define-macro (py-ifloordiv-bintX-bintY-inline self-1274 other-1275)
  `(py-ifloordiv-bintX-bintY-fallback ,self-1274 ,other-1275))

(define-macro (py-ilshift-intX-intY-inline self-1277 other-1278)
  `(py-ilshift-intX-intY-fallback ,self-1277 ,other-1278))

(define-macro (py-ilshift-intX-floatY-inline self-1280 other-1281)
  `(py-ilshift-intX-floatY-fallback ,self-1280 ,other-1281))

(define-macro (py-ilshift-intX-boolY-inline self-1283 other-1284)
  `(py-ilshift-intX-boolY-fallback ,self-1283 ,other-1284))

(define-macro (py-ilshift-intX-sintY-inline self-1286 other-1287)
  `(py-ilshift-intX-sintY-fallback ,self-1286 ,other-1287))

(define-macro (py-ilshift-intX-bintY-inline self-1289 other-1290)
  `(py-ilshift-intX-bintY-fallback ,self-1289 ,other-1290))

(define-macro (py-ilshift-floatX-intY-inline self-1292 other-1293)
  `(py-ilshift-floatX-intY-fallback ,self-1292 ,other-1293))

(define-macro (py-ilshift-floatX-floatY-inline self-1295 other-1296)
  `(let ((self-1295 ,self-1295) (other-1296 ,other-1296))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for <<=: 'float' and 'float'")))))

(define-macro (py-ilshift-floatX-boolY-inline self-1298 other-1299)
  `(py-ilshift-floatX-boolY-fallback ,self-1298 ,other-1299))

(define-macro (py-ilshift-floatX-sintY-inline self-1301 other-1302)
  `(let ((self-1301 ,self-1301) (other-1302 ,other-1302))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for <<=: 'float' and 'int'")))))

(define-macro (py-ilshift-floatX-bintY-inline self-1304 other-1305)
  `(py-ilshift-floatX-bintY-fallback ,self-1304 ,other-1305))

(define-macro (py-ilshift-boolX-intY-inline self-1307 other-1308)
  `(py-ilshift-boolX-intY-fallback ,self-1307 ,other-1308))

(define-macro (py-ilshift-boolX-floatY-inline self-1310 other-1311)
  `(py-ilshift-boolX-floatY-fallback ,self-1310 ,other-1311))

(define-macro (py-ilshift-boolX-boolY-inline self-1313 other-1314)
  `(py-ilshift-boolX-boolY-fallback ,self-1313 ,other-1314))

(define-macro (py-ilshift-boolX-sintY-inline self-1316 other-1317)
  `(py-ilshift-boolX-sintY-fallback ,self-1316 ,other-1317))

(define-macro (py-ilshift-boolX-bintY-inline self-1319 other-1320)
  `(py-ilshift-boolX-bintY-fallback ,self-1319 ,other-1320))

(define-macro (py-ilshift-sintX-intY-inline self-1322 other-1323)
  `(py-ilshift-sintX-intY-fallback ,self-1322 ,other-1323))

(define-macro (py-ilshift-sintX-floatY-inline self-1325 other-1326)
  `(let ((self-1325 ,self-1325) (other-1326 ,other-1326))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for <<=: 'int' and 'float'")))))

(define-macro (py-ilshift-sintX-boolY-inline self-1328 other-1329)
  `(py-ilshift-sintX-boolY-fallback ,self-1328 ,other-1329))

(define-macro (py-ilshift-sintX-sintY-inline self-1331 other-1332)
  `(let ((self-1331 ,self-1331) (other-1332 ,other-1332))
     (if (py-test (py-ge other-1332 (py-int-from-scheme 0)))
         (py-int-from-scheme
          (py<< (py-sint-to-scheme self-1331) (py-sint-to-scheme other-1332)))
         (py-throw
          (py-call py-builtin-ValueError (&& "negative shift count"))))))

(define-macro (py-ilshift-sintX-bintY-inline self-1334 other-1335)
  `(py-ilshift-sintX-bintY-fallback ,self-1334 ,other-1335))

(define-macro (py-ilshift-bintX-intY-inline self-1337 other-1338)
  `(py-ilshift-bintX-intY-fallback ,self-1337 ,other-1338))

(define-macro (py-ilshift-bintX-floatY-inline self-1340 other-1341)
  `(py-ilshift-bintX-floatY-fallback ,self-1340 ,other-1341))

(define-macro (py-ilshift-bintX-boolY-inline self-1343 other-1344)
  `(py-ilshift-bintX-boolY-fallback ,self-1343 ,other-1344))

(define-macro (py-ilshift-bintX-sintY-inline self-1346 other-1347)
  `(py-ilshift-bintX-sintY-fallback ,self-1346 ,other-1347))

(define-macro (py-ilshift-bintX-bintY-inline self-1349 other-1350)
  `(py-ilshift-bintX-bintY-fallback ,self-1349 ,other-1350))

(define-macro (py-imatmul-intX-intY-inline self-1352 other-1353)
  `(py-imatmul-intX-intY-fallback ,self-1352 ,other-1353))

(define-macro (py-imatmul-intX-floatY-inline self-1355 other-1356)
  `(py-imatmul-intX-floatY-fallback ,self-1355 ,other-1356))

(define-macro (py-imatmul-intX-boolY-inline self-1358 other-1359)
  `(py-imatmul-intX-boolY-fallback ,self-1358 ,other-1359))

(define-macro (py-imatmul-intX-sintY-inline self-1361 other-1362)
  `(py-imatmul-intX-sintY-fallback ,self-1361 ,other-1362))

(define-macro (py-imatmul-intX-bintY-inline self-1364 other-1365)
  `(py-imatmul-intX-bintY-fallback ,self-1364 ,other-1365))

(define-macro (py-imatmul-floatX-intY-inline self-1367 other-1368)
  `(py-imatmul-floatX-intY-fallback ,self-1367 ,other-1368))

(define-macro (py-imatmul-floatX-floatY-inline self-1370 other-1371)
  `(let ((self-1370 ,self-1370) (other-1371 ,other-1371))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @=: 'float' and 'float'")))))

(define-macro (py-imatmul-floatX-boolY-inline self-1373 other-1374)
  `(py-imatmul-floatX-boolY-fallback ,self-1373 ,other-1374))

(define-macro (py-imatmul-floatX-sintY-inline self-1376 other-1377)
  `(let ((self-1376 ,self-1376) (other-1377 ,other-1377))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @=: 'float' and 'int'")))))

(define-macro (py-imatmul-floatX-bintY-inline self-1379 other-1380)
  `(py-imatmul-floatX-bintY-fallback ,self-1379 ,other-1380))

(define-macro (py-imatmul-boolX-intY-inline self-1382 other-1383)
  `(py-imatmul-boolX-intY-fallback ,self-1382 ,other-1383))

(define-macro (py-imatmul-boolX-floatY-inline self-1385 other-1386)
  `(py-imatmul-boolX-floatY-fallback ,self-1385 ,other-1386))

(define-macro (py-imatmul-boolX-boolY-inline self-1388 other-1389)
  `(py-imatmul-boolX-boolY-fallback ,self-1388 ,other-1389))

(define-macro (py-imatmul-boolX-sintY-inline self-1391 other-1392)
  `(py-imatmul-boolX-sintY-fallback ,self-1391 ,other-1392))

(define-macro (py-imatmul-boolX-bintY-inline self-1394 other-1395)
  `(py-imatmul-boolX-bintY-fallback ,self-1394 ,other-1395))

(define-macro (py-imatmul-sintX-intY-inline self-1397 other-1398)
  `(py-imatmul-sintX-intY-fallback ,self-1397 ,other-1398))

(define-macro (py-imatmul-sintX-floatY-inline self-1400 other-1401)
  `(let ((self-1400 ,self-1400) (other-1401 ,other-1401))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @=: 'int' and 'float'")))))

(define-macro (py-imatmul-sintX-boolY-inline self-1403 other-1404)
  `(py-imatmul-sintX-boolY-fallback ,self-1403 ,other-1404))

(define-macro (py-imatmul-sintX-sintY-inline self-1406 other-1407)
  `(let ((self-1406 ,self-1406) (other-1407 ,other-1407))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @=: 'int' and 'int'")))))

(define-macro (py-imatmul-sintX-bintY-inline self-1409 other-1410)
  `(py-imatmul-sintX-bintY-fallback ,self-1409 ,other-1410))

(define-macro (py-imatmul-bintX-intY-inline self-1412 other-1413)
  `(py-imatmul-bintX-intY-fallback ,self-1412 ,other-1413))

(define-macro (py-imatmul-bintX-floatY-inline self-1415 other-1416)
  `(py-imatmul-bintX-floatY-fallback ,self-1415 ,other-1416))

(define-macro (py-imatmul-bintX-boolY-inline self-1418 other-1419)
  `(py-imatmul-bintX-boolY-fallback ,self-1418 ,other-1419))

(define-macro (py-imatmul-bintX-sintY-inline self-1421 other-1422)
  `(py-imatmul-bintX-sintY-fallback ,self-1421 ,other-1422))

(define-macro (py-imatmul-bintX-bintY-inline self-1424 other-1425)
  `(py-imatmul-bintX-bintY-fallback ,self-1424 ,other-1425))

(define-macro (py-imod-intX-intY-inline self-1427 other-1428)
  `(py-imod-intX-intY-fallback ,self-1427 ,other-1428))

(define-macro (py-imod-intX-floatY-inline other-1430 self-1431)
  `(py-imod-intX-floatY-fallback ,other-1430 ,self-1431))

(define-macro (py-imod-intX-boolY-inline self-1433 other-1434)
  `(py-imod-intX-boolY-fallback ,self-1433 ,other-1434))

(define-macro (py-imod-intX-sintY-inline self-1436 other-1437)
  `(py-imod-intX-sintY-fallback ,self-1436 ,other-1437))

(define-macro (py-imod-intX-bintY-inline self-1439 other-1440)
  `(py-imod-intX-bintY-fallback ,self-1439 ,other-1440))

(define-macro (py-imod-floatX-intY-inline self-1442 other-1443)
  `(py-imod-floatX-intY-fallback ,self-1442 ,other-1443))

(define-macro (py-imod-floatX-floatY-inline self-1445 other-1446)
  `(let ((self-1445 ,self-1445) (other-1446 ,other-1446))
     (if (py-test (py-ne other-1446 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py% (py-float-to-scheme self-1445) (py-float-to-scheme other-1446)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float modulo by zero"))))))

(define-macro (py-imod-floatX-boolY-inline self-1448 other-1449)
  `(py-imod-floatX-boolY-fallback ,self-1448 ,other-1449))

(define-macro (py-imod-floatX-sintY-inline self-1451 other-1452)
  `(let ((self-1451 ,self-1451) (other-1452 ,other-1452))
     (if (py-test (py-ne other-1452 (py-int-from-scheme 0)))
         (py-float-from-scheme
          (py% (py-float-to-scheme self-1451) (py-sint-to-scheme other-1452)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float modulo by zero"))))))

(define-macro (py-imod-floatX-bintY-inline self-1454 other-1455)
  `(py-imod-floatX-bintY-fallback ,self-1454 ,other-1455))

(define-macro (py-imod-boolX-intY-inline self-1457 other-1458)
  `(py-imod-boolX-intY-fallback ,self-1457 ,other-1458))

(define-macro (py-imod-boolX-floatY-inline other-1460 self-1461)
  `(py-imod-boolX-floatY-fallback ,other-1460 ,self-1461))

(define-macro (py-imod-boolX-boolY-inline self-1463 other-1464)
  `(py-imod-boolX-boolY-fallback ,self-1463 ,other-1464))

(define-macro (py-imod-boolX-sintY-inline self-1466 other-1467)
  `(py-imod-boolX-sintY-fallback ,self-1466 ,other-1467))

(define-macro (py-imod-boolX-bintY-inline self-1469 other-1470)
  `(py-imod-boolX-bintY-fallback ,self-1469 ,other-1470))

(define-macro (py-imod-sintX-intY-inline self-1472 other-1473)
  `(py-imod-sintX-intY-fallback ,self-1472 ,other-1473))

(define-macro (py-imod-sintX-floatY-inline other-1475 self-1476)
  `(let ((other-1475 ,other-1475) (self-1476 ,self-1476))
     (if (py-test (py-ne self-1476 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py% (py-sint-to-scheme other-1475) (py-float-to-scheme self-1476)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float modulo by zero"))))))

(define-macro (py-imod-sintX-boolY-inline self-1478 other-1479)
  `(py-imod-sintX-boolY-fallback ,self-1478 ,other-1479))

(define-macro (py-imod-sintX-sintY-inline self-1481 other-1482)
  `(let ((self-1481 ,self-1481) (other-1482 ,other-1482))
     (if (py-test (py-ne other-1482 (py-int-from-scheme 0)))
         (py-int-from-scheme
          (py% (py-sint-to-scheme self-1481) (py-sint-to-scheme other-1482)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError (&& "modulo by zero"))))))

(define-macro (py-imod-sintX-bintY-inline self-1484 other-1485)
  `(py-imod-sintX-bintY-fallback ,self-1484 ,other-1485))

(define-macro (py-imod-bintX-intY-inline self-1487 other-1488)
  `(py-imod-bintX-intY-fallback ,self-1487 ,other-1488))

(define-macro (py-imod-bintX-floatY-inline other-1490 self-1491)
  `(py-imod-bintX-floatY-fallback ,other-1490 ,self-1491))

(define-macro (py-imod-bintX-boolY-inline self-1493 other-1494)
  `(py-imod-bintX-boolY-fallback ,self-1493 ,other-1494))

(define-macro (py-imod-bintX-sintY-inline self-1496 other-1497)
  `(py-imod-bintX-sintY-fallback ,self-1496 ,other-1497))

(define-macro (py-imod-bintX-bintY-inline self-1499 other-1500)
  `(py-imod-bintX-bintY-fallback ,self-1499 ,other-1500))

(define-macro (py-imul-intX-intY-inline self-1502 other-1503)
  `(py-imul-intX-intY-fallback ,self-1502 ,other-1503))

(define-macro (py-imul-intX-floatY-inline other-1505 self-1506)
  `(py-imul-intX-floatY-fallback ,other-1505 ,self-1506))

(define-macro (py-imul-intX-boolY-inline self-1508 other-1509)
  `(py-imul-intX-boolY-fallback ,self-1508 ,other-1509))

(define-macro (py-imul-intX-sintY-inline self-1511 other-1512)
  `(py-imul-intX-sintY-fallback ,self-1511 ,other-1512))

(define-macro (py-imul-intX-bintY-inline self-1514 other-1515)
  `(py-imul-intX-bintY-fallback ,self-1514 ,other-1515))

(define-macro (py-imul-floatX-intY-inline self-1517 other-1518)
  `(py-imul-floatX-intY-fallback ,self-1517 ,other-1518))

(define-macro (py-imul-floatX-floatY-inline self-1520 other-1521)
  `(let ((self-1520 ,self-1520) (other-1521 ,other-1521))
     (py-float-from-scheme
      (py* (py-float-to-scheme self-1520) (py-float-to-scheme other-1521)))))

(define-macro (py-imul-floatX-boolY-inline self-1523 other-1524)
  `(py-imul-floatX-boolY-fallback ,self-1523 ,other-1524))

(define-macro (py-imul-floatX-sintY-inline self-1526 other-1527)
  `(let ((self-1526 ,self-1526) (other-1527 ,other-1527))
     (py-float-from-scheme
      (py* (py-float-to-scheme self-1526) (py-sint-to-scheme other-1527)))))

(define-macro (py-imul-floatX-bintY-inline self-1529 other-1530)
  `(py-imul-floatX-bintY-fallback ,self-1529 ,other-1530))

(define-macro (py-imul-boolX-intY-inline self-1532 other-1533)
  `(py-imul-boolX-intY-fallback ,self-1532 ,other-1533))

(define-macro (py-imul-boolX-floatY-inline other-1535 self-1536)
  `(py-imul-boolX-floatY-fallback ,other-1535 ,self-1536))

(define-macro (py-imul-boolX-boolY-inline self-1538 other-1539)
  `(py-imul-boolX-boolY-fallback ,self-1538 ,other-1539))

(define-macro (py-imul-boolX-sintY-inline self-1541 other-1542)
  `(py-imul-boolX-sintY-fallback ,self-1541 ,other-1542))

(define-macro (py-imul-boolX-bintY-inline self-1544 other-1545)
  `(py-imul-boolX-bintY-fallback ,self-1544 ,other-1545))

(define-macro (py-imul-sintX-intY-inline self-1547 other-1548)
  `(py-imul-sintX-intY-fallback ,self-1547 ,other-1548))

(define-macro (py-imul-sintX-floatY-inline other-1550 self-1551)
  `(let ((other-1550 ,other-1550) (self-1551 ,self-1551))
     (py-float-from-scheme
      (py* (py-sint-to-scheme other-1550) (py-float-to-scheme self-1551)))))

(define-macro (py-imul-sintX-boolY-inline self-1553 other-1554)
  `(py-imul-sintX-boolY-fallback ,self-1553 ,other-1554))

(define-macro (py-imul-sintX-sintY-inline self-1556 other-1557)
  `(let ((self-1556 ,self-1556) (other-1557 ,other-1557))
     (py-int-from-scheme
      (py* (py-sint-to-scheme self-1556) (py-sint-to-scheme other-1557)))))

(define-macro (py-imul-sintX-bintY-inline self-1559 other-1560)
  `(py-imul-sintX-bintY-fallback ,self-1559 ,other-1560))

(define-macro (py-imul-bintX-intY-inline self-1562 other-1563)
  `(py-imul-bintX-intY-fallback ,self-1562 ,other-1563))

(define-macro (py-imul-bintX-floatY-inline other-1565 self-1566)
  `(py-imul-bintX-floatY-fallback ,other-1565 ,self-1566))

(define-macro (py-imul-bintX-boolY-inline self-1568 other-1569)
  `(py-imul-bintX-boolY-fallback ,self-1568 ,other-1569))

(define-macro (py-imul-bintX-sintY-inline self-1571 other-1572)
  `(py-imul-bintX-sintY-fallback ,self-1571 ,other-1572))

(define-macro (py-imul-bintX-bintY-inline self-1574 other-1575)
  `(py-imul-bintX-bintY-fallback ,self-1574 ,other-1575))

(define-macro (py-ipow-intX-intY-inline self-1577 other-1578)
  `(py-ipow-intX-intY-fallback ,self-1577 ,other-1578))

(define-macro (py-ipow-intX-floatY-inline other-1580 self-1581)
  `(py-ipow-intX-floatY-fallback ,other-1580 ,self-1581))

(define-macro (py-ipow-intX-boolY-inline self-1583 other-1584)
  `(py-ipow-intX-boolY-fallback ,self-1583 ,other-1584))

(define-macro (py-ipow-intX-sintY-inline self-1586 other-1587)
  `(py-ipow-intX-sintY-fallback ,self-1586 ,other-1587))

(define-macro (py-ipow-intX-bintY-inline self-1589 other-1590)
  `(py-ipow-intX-bintY-fallback ,self-1589 ,other-1590))

(define-macro (py-ipow-floatX-intY-inline self-1592 other-1593)
  `(py-ipow-floatX-intY-fallback ,self-1592 ,other-1593))

(define-macro (py-ipow-floatX-floatY-inline self-1595 other-1596)
  `(let ((self-1595 ,self-1595) (other-1596 ,other-1596))
     (py-float-from-scheme
      (py** (py-float-to-scheme self-1595) (py-float-to-scheme other-1596)))))

(define-macro (py-ipow-floatX-boolY-inline self-1598 other-1599)
  `(py-ipow-floatX-boolY-fallback ,self-1598 ,other-1599))

(define-macro (py-ipow-floatX-sintY-inline self-1601 other-1602)
  `(let ((self-1601 ,self-1601) (other-1602 ,other-1602))
     (py-float-from-scheme
      (py** (py-float-to-scheme self-1601) (py-sint-to-scheme other-1602)))))

(define-macro (py-ipow-floatX-bintY-inline self-1604 other-1605)
  `(py-ipow-floatX-bintY-fallback ,self-1604 ,other-1605))

(define-macro (py-ipow-boolX-intY-inline self-1607 other-1608)
  `(py-ipow-boolX-intY-fallback ,self-1607 ,other-1608))

(define-macro (py-ipow-boolX-floatY-inline other-1610 self-1611)
  `(py-ipow-boolX-floatY-fallback ,other-1610 ,self-1611))

(define-macro (py-ipow-boolX-boolY-inline self-1613 other-1614)
  `(py-ipow-boolX-boolY-fallback ,self-1613 ,other-1614))

(define-macro (py-ipow-boolX-sintY-inline self-1616 other-1617)
  `(py-ipow-boolX-sintY-fallback ,self-1616 ,other-1617))

(define-macro (py-ipow-boolX-bintY-inline self-1619 other-1620)
  `(py-ipow-boolX-bintY-fallback ,self-1619 ,other-1620))

(define-macro (py-ipow-sintX-intY-inline self-1622 other-1623)
  `(py-ipow-sintX-intY-fallback ,self-1622 ,other-1623))

(define-macro (py-ipow-sintX-floatY-inline other-1625 self-1626)
  `(let ((other-1625 ,other-1625) (self-1626 ,self-1626))
     (py-float-from-scheme
      (py** (py-sint-to-scheme other-1625) (py-float-to-scheme self-1626)))))

(define-macro (py-ipow-sintX-boolY-inline self-1628 other-1629)
  `(py-ipow-sintX-boolY-fallback ,self-1628 ,other-1629))

(define-macro (py-ipow-sintX-sintY-inline self-1631 other-1632)
  `(let ((self-1631 ,self-1631) (other-1632 ,other-1632))
     (py-int-from-scheme
      (py** (py-sint-to-scheme self-1631) (py-sint-to-scheme other-1632)))))

(define-macro (py-ipow-sintX-bintY-inline self-1634 other-1635)
  `(py-ipow-sintX-bintY-fallback ,self-1634 ,other-1635))

(define-macro (py-ipow-bintX-intY-inline self-1637 other-1638)
  `(py-ipow-bintX-intY-fallback ,self-1637 ,other-1638))

(define-macro (py-ipow-bintX-floatY-inline other-1640 self-1641)
  `(py-ipow-bintX-floatY-fallback ,other-1640 ,self-1641))

(define-macro (py-ipow-bintX-boolY-inline self-1643 other-1644)
  `(py-ipow-bintX-boolY-fallback ,self-1643 ,other-1644))

(define-macro (py-ipow-bintX-sintY-inline self-1646 other-1647)
  `(py-ipow-bintX-sintY-fallback ,self-1646 ,other-1647))

(define-macro (py-ipow-bintX-bintY-inline self-1649 other-1650)
  `(py-ipow-bintX-bintY-fallback ,self-1649 ,other-1650))

(define-macro (py-irshift-intX-intY-inline self-1652 other-1653)
  `(py-irshift-intX-intY-fallback ,self-1652 ,other-1653))

(define-macro (py-irshift-intX-floatY-inline self-1655 other-1656)
  `(py-irshift-intX-floatY-fallback ,self-1655 ,other-1656))

(define-macro (py-irshift-intX-boolY-inline self-1658 other-1659)
  `(py-irshift-intX-boolY-fallback ,self-1658 ,other-1659))

(define-macro (py-irshift-intX-sintY-inline self-1661 other-1662)
  `(py-irshift-intX-sintY-fallback ,self-1661 ,other-1662))

(define-macro (py-irshift-intX-bintY-inline self-1664 other-1665)
  `(py-irshift-intX-bintY-fallback ,self-1664 ,other-1665))

(define-macro (py-irshift-floatX-intY-inline self-1667 other-1668)
  `(py-irshift-floatX-intY-fallback ,self-1667 ,other-1668))

(define-macro (py-irshift-floatX-floatY-inline self-1670 other-1671)
  `(let ((self-1670 ,self-1670) (other-1671 ,other-1671))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for >>=: 'float' and 'float'")))))

(define-macro (py-irshift-floatX-boolY-inline self-1673 other-1674)
  `(py-irshift-floatX-boolY-fallback ,self-1673 ,other-1674))

(define-macro (py-irshift-floatX-sintY-inline self-1676 other-1677)
  `(let ((self-1676 ,self-1676) (other-1677 ,other-1677))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for >>=: 'float' and 'int'")))))

(define-macro (py-irshift-floatX-bintY-inline self-1679 other-1680)
  `(py-irshift-floatX-bintY-fallback ,self-1679 ,other-1680))

(define-macro (py-irshift-boolX-intY-inline self-1682 other-1683)
  `(py-irshift-boolX-intY-fallback ,self-1682 ,other-1683))

(define-macro (py-irshift-boolX-floatY-inline self-1685 other-1686)
  `(py-irshift-boolX-floatY-fallback ,self-1685 ,other-1686))

(define-macro (py-irshift-boolX-boolY-inline self-1688 other-1689)
  `(py-irshift-boolX-boolY-fallback ,self-1688 ,other-1689))

(define-macro (py-irshift-boolX-sintY-inline self-1691 other-1692)
  `(py-irshift-boolX-sintY-fallback ,self-1691 ,other-1692))

(define-macro (py-irshift-boolX-bintY-inline self-1694 other-1695)
  `(py-irshift-boolX-bintY-fallback ,self-1694 ,other-1695))

(define-macro (py-irshift-sintX-intY-inline self-1697 other-1698)
  `(py-irshift-sintX-intY-fallback ,self-1697 ,other-1698))

(define-macro (py-irshift-sintX-floatY-inline self-1700 other-1701)
  `(let ((self-1700 ,self-1700) (other-1701 ,other-1701))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for >>=: 'int' and 'float'")))))

(define-macro (py-irshift-sintX-boolY-inline self-1703 other-1704)
  `(py-irshift-sintX-boolY-fallback ,self-1703 ,other-1704))

(define-macro (py-irshift-sintX-sintY-inline self-1706 other-1707)
  `(let ((self-1706 ,self-1706) (other-1707 ,other-1707))
     (if (py-test (py-ge other-1707 (py-int-from-scheme 0)))
         (py-int-from-scheme
          (py>> (py-sint-to-scheme self-1706) (py-sint-to-scheme other-1707)))
         (py-throw
          (py-call py-builtin-ValueError (&& "negative shift count"))))))

(define-macro (py-irshift-sintX-bintY-inline self-1709 other-1710)
  `(py-irshift-sintX-bintY-fallback ,self-1709 ,other-1710))

(define-macro (py-irshift-bintX-intY-inline self-1712 other-1713)
  `(py-irshift-bintX-intY-fallback ,self-1712 ,other-1713))

(define-macro (py-irshift-bintX-floatY-inline self-1715 other-1716)
  `(py-irshift-bintX-floatY-fallback ,self-1715 ,other-1716))

(define-macro (py-irshift-bintX-boolY-inline self-1718 other-1719)
  `(py-irshift-bintX-boolY-fallback ,self-1718 ,other-1719))

(define-macro (py-irshift-bintX-sintY-inline self-1721 other-1722)
  `(py-irshift-bintX-sintY-fallback ,self-1721 ,other-1722))

(define-macro (py-irshift-bintX-bintY-inline self-1724 other-1725)
  `(py-irshift-bintX-bintY-fallback ,self-1724 ,other-1725))

(define-macro (py-isub-intX-intY-inline self-1727 other-1728)
  `(py-isub-intX-intY-fallback ,self-1727 ,other-1728))

(define-macro (py-isub-intX-floatY-inline other-1730 self-1731)
  `(py-isub-intX-floatY-fallback ,other-1730 ,self-1731))

(define-macro (py-isub-intX-boolY-inline self-1733 other-1734)
  `(py-isub-intX-boolY-fallback ,self-1733 ,other-1734))

(define-macro (py-isub-intX-sintY-inline self-1736 other-1737)
  `(py-isub-intX-sintY-fallback ,self-1736 ,other-1737))

(define-macro (py-isub-intX-bintY-inline self-1739 other-1740)
  `(py-isub-intX-bintY-fallback ,self-1739 ,other-1740))

(define-macro (py-isub-floatX-intY-inline self-1742 other-1743)
  `(py-isub-floatX-intY-fallback ,self-1742 ,other-1743))

(define-macro (py-isub-floatX-floatY-inline self-1745 other-1746)
  `(let ((self-1745 ,self-1745) (other-1746 ,other-1746))
     (py-float-from-scheme
      (py- (py-float-to-scheme self-1745) (py-float-to-scheme other-1746)))))

(define-macro (py-isub-floatX-boolY-inline self-1748 other-1749)
  `(py-isub-floatX-boolY-fallback ,self-1748 ,other-1749))

(define-macro (py-isub-floatX-sintY-inline self-1751 other-1752)
  `(let ((self-1751 ,self-1751) (other-1752 ,other-1752))
     (py-float-from-scheme
      (py- (py-float-to-scheme self-1751) (py-sint-to-scheme other-1752)))))

(define-macro (py-isub-floatX-bintY-inline self-1754 other-1755)
  `(py-isub-floatX-bintY-fallback ,self-1754 ,other-1755))

(define-macro (py-isub-boolX-intY-inline self-1757 other-1758)
  `(py-isub-boolX-intY-fallback ,self-1757 ,other-1758))

(define-macro (py-isub-boolX-floatY-inline other-1760 self-1761)
  `(py-isub-boolX-floatY-fallback ,other-1760 ,self-1761))

(define-macro (py-isub-boolX-boolY-inline self-1763 other-1764)
  `(py-isub-boolX-boolY-fallback ,self-1763 ,other-1764))

(define-macro (py-isub-boolX-sintY-inline self-1766 other-1767)
  `(py-isub-boolX-sintY-fallback ,self-1766 ,other-1767))

(define-macro (py-isub-boolX-bintY-inline self-1769 other-1770)
  `(py-isub-boolX-bintY-fallback ,self-1769 ,other-1770))

(define-macro (py-isub-sintX-intY-inline self-1772 other-1773)
  `(py-isub-sintX-intY-fallback ,self-1772 ,other-1773))

(define-macro (py-isub-sintX-floatY-inline other-1775 self-1776)
  `(let ((other-1775 ,other-1775) (self-1776 ,self-1776))
     (py-float-from-scheme
      (py- (py-sint-to-scheme other-1775) (py-float-to-scheme self-1776)))))

(define-macro (py-isub-sintX-boolY-inline self-1778 other-1779)
  `(py-isub-sintX-boolY-fallback ,self-1778 ,other-1779))

(define-macro (py-isub-sintX-sintY-inline self-1781 other-1782)
  `(let ((self-1781 ,self-1781) (other-1782 ,other-1782))
     (py-int-from-scheme
      (py- (py-sint-to-scheme self-1781) (py-sint-to-scheme other-1782)))))

(define-macro (py-isub-sintX-bintY-inline self-1784 other-1785)
  `(py-isub-sintX-bintY-fallback ,self-1784 ,other-1785))

(define-macro (py-isub-bintX-intY-inline self-1787 other-1788)
  `(py-isub-bintX-intY-fallback ,self-1787 ,other-1788))

(define-macro (py-isub-bintX-floatY-inline other-1790 self-1791)
  `(py-isub-bintX-floatY-fallback ,other-1790 ,self-1791))

(define-macro (py-isub-bintX-boolY-inline self-1793 other-1794)
  `(py-isub-bintX-boolY-fallback ,self-1793 ,other-1794))

(define-macro (py-isub-bintX-sintY-inline self-1796 other-1797)
  `(py-isub-bintX-sintY-fallback ,self-1796 ,other-1797))

(define-macro (py-isub-bintX-bintY-inline self-1799 other-1800)
  `(py-isub-bintX-bintY-fallback ,self-1799 ,other-1800))

(define-macro (py-itruediv-intX-intY-inline self-1802 other-1803)
  `(py-itruediv-intX-intY-fallback ,self-1802 ,other-1803))

(define-macro (py-itruediv-intX-floatY-inline other-1805 self-1806)
  `(py-itruediv-intX-floatY-fallback ,other-1805 ,self-1806))

(define-macro (py-itruediv-intX-boolY-inline self-1808 other-1809)
  `(py-itruediv-intX-boolY-fallback ,self-1808 ,other-1809))

(define-macro (py-itruediv-intX-sintY-inline self-1811 other-1812)
  `(py-itruediv-intX-sintY-fallback ,self-1811 ,other-1812))

(define-macro (py-itruediv-intX-bintY-inline self-1814 other-1815)
  `(py-itruediv-intX-bintY-fallback ,self-1814 ,other-1815))

(define-macro (py-itruediv-floatX-intY-inline self-1817 other-1818)
  `(py-itruediv-floatX-intY-fallback ,self-1817 ,other-1818))

(define-macro (py-itruediv-floatX-floatY-inline self-1820 other-1821)
  `(let ((self-1820 ,self-1820) (other-1821 ,other-1821))
     (if (py-test (py-ne other-1821 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py/ (py-float-to-scheme self-1820) (py-float-to-scheme other-1821)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-itruediv-floatX-boolY-inline self-1823 other-1824)
  `(py-itruediv-floatX-boolY-fallback ,self-1823 ,other-1824))

(define-macro (py-itruediv-floatX-sintY-inline self-1826 other-1827)
  `(let ((self-1826 ,self-1826) (other-1827 ,other-1827))
     (if (py-test (py-ne other-1827 (py-int-from-scheme 0)))
         (py-float-from-scheme
          (py/ (py-float-to-scheme self-1826) (py-sint-to-scheme other-1827)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-itruediv-floatX-bintY-inline self-1829 other-1830)
  `(py-itruediv-floatX-bintY-fallback ,self-1829 ,other-1830))

(define-macro (py-itruediv-boolX-intY-inline self-1832 other-1833)
  `(py-itruediv-boolX-intY-fallback ,self-1832 ,other-1833))

(define-macro (py-itruediv-boolX-floatY-inline other-1835 self-1836)
  `(py-itruediv-boolX-floatY-fallback ,other-1835 ,self-1836))

(define-macro (py-itruediv-boolX-boolY-inline self-1838 other-1839)
  `(py-itruediv-boolX-boolY-fallback ,self-1838 ,other-1839))

(define-macro (py-itruediv-boolX-sintY-inline self-1841 other-1842)
  `(py-itruediv-boolX-sintY-fallback ,self-1841 ,other-1842))

(define-macro (py-itruediv-boolX-bintY-inline self-1844 other-1845)
  `(py-itruediv-boolX-bintY-fallback ,self-1844 ,other-1845))

(define-macro (py-itruediv-sintX-intY-inline self-1847 other-1848)
  `(py-itruediv-sintX-intY-fallback ,self-1847 ,other-1848))

(define-macro (py-itruediv-sintX-floatY-inline other-1850 self-1851)
  `(let ((other-1850 ,other-1850) (self-1851 ,self-1851))
     (if (py-test (py-ne self-1851 (py-float-from-scheme 0.)))
         (py-float-from-scheme
          (py/ (py-sint-to-scheme other-1850) (py-float-to-scheme self-1851)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-itruediv-sintX-boolY-inline self-1853 other-1854)
  `(py-itruediv-sintX-boolY-fallback ,self-1853 ,other-1854))

(define-macro (py-itruediv-sintX-sintY-inline self-1856 other-1857)
  `(let ((self-1856 ,self-1856) (other-1857 ,other-1857))
     (if (py-test (py-ne other-1857 (py-int-from-scheme 0)))
         (py-float-from-scheme
          (py/ (py-sint-to-scheme self-1856) (py-sint-to-scheme other-1857)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError (&& "division by zero"))))))

(define-macro (py-itruediv-sintX-bintY-inline self-1859 other-1860)
  `(py-itruediv-sintX-bintY-fallback ,self-1859 ,other-1860))

(define-macro (py-itruediv-bintX-intY-inline self-1862 other-1863)
  `(py-itruediv-bintX-intY-fallback ,self-1862 ,other-1863))

(define-macro (py-itruediv-bintX-floatY-inline other-1865 self-1866)
  `(py-itruediv-bintX-floatY-fallback ,other-1865 ,self-1866))

(define-macro (py-itruediv-bintX-boolY-inline self-1868 other-1869)
  `(py-itruediv-bintX-boolY-fallback ,self-1868 ,other-1869))

(define-macro (py-itruediv-bintX-sintY-inline self-1871 other-1872)
  `(py-itruediv-bintX-sintY-fallback ,self-1871 ,other-1872))

(define-macro (py-itruediv-bintX-bintY-inline self-1874 other-1875)
  `(py-itruediv-bintX-bintY-fallback ,self-1874 ,other-1875))

(define-macro (py-ixor-intX-intY-inline self-1877 other-1878)
  `(py-ixor-intX-intY-fallback ,self-1877 ,other-1878))

(define-macro (py-ixor-intX-floatY-inline self-1880 other-1881)
  `(py-ixor-intX-floatY-fallback ,self-1880 ,other-1881))

(define-macro (py-ixor-intX-boolY-inline self-1883 other-1884)
  `(py-ixor-intX-boolY-fallback ,self-1883 ,other-1884))

(define-macro (py-ixor-intX-sintY-inline self-1886 other-1887)
  `(py-ixor-intX-sintY-fallback ,self-1886 ,other-1887))

(define-macro (py-ixor-intX-bintY-inline self-1889 other-1890)
  `(py-ixor-intX-bintY-fallback ,self-1889 ,other-1890))

(define-macro (py-ixor-floatX-intY-inline self-1892 other-1893)
  `(py-ixor-floatX-intY-fallback ,self-1892 ,other-1893))

(define-macro (py-ixor-floatX-floatY-inline self-1895 other-1896)
  `(let ((self-1895 ,self-1895) (other-1896 ,other-1896))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for ^=: 'float' and 'float'")))))

(define-macro (py-ixor-floatX-boolY-inline self-1898 other-1899)
  `(py-ixor-floatX-boolY-fallback ,self-1898 ,other-1899))

(define-macro (py-ixor-floatX-sintY-inline self-1901 other-1902)
  `(let ((self-1901 ,self-1901) (other-1902 ,other-1902))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for ^=: 'float' and 'int'")))))

(define-macro (py-ixor-floatX-bintY-inline self-1904 other-1905)
  `(py-ixor-floatX-bintY-fallback ,self-1904 ,other-1905))

(define-macro (py-ixor-boolX-intY-inline self-1907 other-1908)
  `(py-ixor-boolX-intY-fallback ,self-1907 ,other-1908))

(define-macro (py-ixor-boolX-floatY-inline self-1910 other-1911)
  `(py-ixor-boolX-floatY-fallback ,self-1910 ,other-1911))

(define-macro (py-ixor-boolX-boolY-inline self-1913 other-1914)
  `(py-ixor-boolX-boolY-fallback ,self-1913 ,other-1914))

(define-macro (py-ixor-boolX-sintY-inline self-1916 other-1917)
  `(py-ixor-boolX-sintY-fallback ,self-1916 ,other-1917))

(define-macro (py-ixor-boolX-bintY-inline self-1919 other-1920)
  `(py-ixor-boolX-bintY-fallback ,self-1919 ,other-1920))

(define-macro (py-ixor-sintX-intY-inline self-1922 other-1923)
  `(py-ixor-sintX-intY-fallback ,self-1922 ,other-1923))

(define-macro (py-ixor-sintX-floatY-inline self-1925 other-1926)
  `(let ((self-1925 ,self-1925) (other-1926 ,other-1926))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for ^=: 'int' and 'float'")))))

(define-macro (py-ixor-sintX-boolY-inline self-1928 other-1929)
  `(py-ixor-sintX-boolY-fallback ,self-1928 ,other-1929))

(define-macro (py-ixor-sintX-sintY-inline self-1931 other-1932)
  `(let ((self-1931 ,self-1931) (other-1932 ,other-1932))
     (py-int-from-scheme
      (py^ (py-sint-to-scheme self-1931) (py-sint-to-scheme other-1932)))))

(define-macro (py-ixor-sintX-bintY-inline self-1934 other-1935)
  `(py-ixor-sintX-bintY-fallback ,self-1934 ,other-1935))

(define-macro (py-ixor-bintX-intY-inline self-1937 other-1938)
  `(py-ixor-bintX-intY-fallback ,self-1937 ,other-1938))

(define-macro (py-ixor-bintX-floatY-inline self-1940 other-1941)
  `(py-ixor-bintX-floatY-fallback ,self-1940 ,other-1941))

(define-macro (py-ixor-bintX-boolY-inline self-1943 other-1944)
  `(py-ixor-bintX-boolY-fallback ,self-1943 ,other-1944))

(define-macro (py-ixor-bintX-sintY-inline self-1946 other-1947)
  `(py-ixor-bintX-sintY-fallback ,self-1946 ,other-1947))

(define-macro (py-ixor-bintX-bintY-inline self-1949 other-1950)
  `(py-ixor-bintX-bintY-fallback ,self-1949 ,other-1950))

(define-macro (py-pos-intX-inline self-1952)
  `(py-pos-intX-fallback ,self-1952))

(define-macro (py-pos-floatX-inline self-1954)
  `(py-pos-floatX-fallback ,self-1954))

(define-macro (py-pos-boolX-inline self-1956)
  `(py-pos-boolX-fallback ,self-1956))

(define-macro (py-pos-sintX-inline self-1958)
  `(py-pos-sintX-fallback ,self-1958))

(define-macro (py-pos-bintX-inline self-1960)
  `(py-pos-bintX-fallback ,self-1960))

(define-macro (py-neg-intX-inline self-1962)
  `(py-neg-intX-fallback ,self-1962))

(define-macro (py-neg-floatX-inline self-1964)
  `(py-neg-floatX-fallback ,self-1964))

(define-macro (py-neg-boolX-inline self-1966)
  `(py-neg-boolX-fallback ,self-1966))

(define-macro (py-neg-sintX-inline self-1968)
  `(py-neg-sintX-fallback ,self-1968))

(define-macro (py-neg-bintX-inline self-1970)
  `(py-neg-bintX-fallback ,self-1970))

(define-macro (py-invert-intX-inline self-1972)
  `(py-invert-intX-fallback ,self-1972))

(define-macro (py-invert-floatX-inline self-1974)
  `(py-invert-floatX-fallback ,self-1974))

(define-macro (py-invert-boolX-inline self-1976)
  `(py-invert-boolX-fallback ,self-1976))

(define-macro (py-invert-sintX-inline self-1978)
  `(py-invert-sintX-fallback ,self-1978))

(define-macro (py-invert-bintX-inline self-1980)
  `(py-invert-bintX-fallback ,self-1980))

(define-macro (py-ge-intX-intY-inline self-1982 other-1983)
  `(py-ge-intX-intY-fallback ,self-1982 ,other-1983))

(define-macro (py-test-ge-intX-intY-inline self-1985 other-1986)
  `(py-test-ge-intX-intY-fallback ,self-1985 ,other-1986))

(define-macro (py-ge-intX-floatY-inline other-1988 self-1989)
  `(py-ge-intX-floatY-fallback ,other-1988 ,self-1989))

(define-macro (py-test-ge-intX-floatY-inline other-1991 self-1992)
  `(py-test-ge-intX-floatY-fallback ,other-1991 ,self-1992))

(define-macro (py-ge-intX-boolY-inline self-1994 other-1995)
  `(py-ge-intX-boolY-fallback ,self-1994 ,other-1995))

(define-macro (py-test-ge-intX-boolY-inline self-1997 other-1998)
  `(py-test-ge-intX-boolY-fallback ,self-1997 ,other-1998))

(define-macro (py-ge-intX-sintY-inline self-2000 other-2001)
  `(py-ge-intX-sintY-fallback ,self-2000 ,other-2001))

(define-macro (py-test-ge-intX-sintY-inline self-2003 other-2004)
  `(py-test-ge-intX-sintY-fallback ,self-2003 ,other-2004))

(define-macro (py-ge-intX-bintY-inline self-2006 other-2007)
  `(py-ge-intX-bintY-fallback ,self-2006 ,other-2007))

(define-macro (py-test-ge-intX-bintY-inline self-2009 other-2010)
  `(py-test-ge-intX-bintY-fallback ,self-2009 ,other-2010))

(define-macro (py-ge-floatX-intY-inline self-2012 other-2013)
  `(py-ge-floatX-intY-fallback ,self-2012 ,other-2013))

(define-macro (py-test-ge-floatX-intY-inline self-2015 other-2016)
  `(py-test-ge-floatX-intY-fallback ,self-2015 ,other-2016))

(define-macro (py-ge-floatX-floatY-inline self-2018 other-2019)
  `(let ((self-2018 ,self-2018) (other-2019 ,other-2019))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py>= (py-float-to-scheme self-2018)
             (py-float-to-scheme other-2019))))))

(define-macro (py-test-ge-floatX-floatY-inline self-2021 other-2022)
  `(let ((self-2021 ,self-2021) (other-2022 ,other-2022))
     (py-test-from-scheme
      (py>= (py-float-to-scheme self-2021) (py-float-to-scheme other-2022)))))

(define-macro (py-ge-floatX-boolY-inline self-2024 other-2025)
  `(py-ge-floatX-boolY-fallback ,self-2024 ,other-2025))

(define-macro (py-test-ge-floatX-boolY-inline self-2027 other-2028)
  `(py-test-ge-floatX-boolY-fallback ,self-2027 ,other-2028))

(define-macro (py-ge-floatX-sintY-inline self-2030 other-2031)
  `(let ((self-2030 ,self-2030) (other-2031 ,other-2031))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py>= (py-float-to-scheme self-2030) (py-sint-to-scheme other-2031))))))

(define-macro (py-test-ge-floatX-sintY-inline self-2033 other-2034)
  `(let ((self-2033 ,self-2033) (other-2034 ,other-2034))
     (py-test-from-scheme
      (py>= (py-float-to-scheme self-2033) (py-sint-to-scheme other-2034)))))

(define-macro (py-ge-floatX-bintY-inline self-2036 other-2037)
  `(py-ge-floatX-bintY-fallback ,self-2036 ,other-2037))

(define-macro (py-test-ge-floatX-bintY-inline self-2039 other-2040)
  `(py-test-ge-floatX-bintY-fallback ,self-2039 ,other-2040))

(define-macro (py-ge-boolX-intY-inline self-2042 other-2043)
  `(py-ge-boolX-intY-fallback ,self-2042 ,other-2043))

(define-macro (py-test-ge-boolX-intY-inline self-2045 other-2046)
  `(py-test-ge-boolX-intY-fallback ,self-2045 ,other-2046))

(define-macro (py-ge-boolX-floatY-inline other-2048 self-2049)
  `(py-ge-boolX-floatY-fallback ,other-2048 ,self-2049))

(define-macro (py-test-ge-boolX-floatY-inline other-2051 self-2052)
  `(py-test-ge-boolX-floatY-fallback ,other-2051 ,self-2052))

(define-macro (py-ge-boolX-boolY-inline self-2054 other-2055)
  `(py-ge-boolX-boolY-fallback ,self-2054 ,other-2055))

(define-macro (py-test-ge-boolX-boolY-inline self-2057 other-2058)
  `(py-test-ge-boolX-boolY-fallback ,self-2057 ,other-2058))

(define-macro (py-ge-boolX-sintY-inline self-2060 other-2061)
  `(py-ge-boolX-sintY-fallback ,self-2060 ,other-2061))

(define-macro (py-test-ge-boolX-sintY-inline self-2063 other-2064)
  `(py-test-ge-boolX-sintY-fallback ,self-2063 ,other-2064))

(define-macro (py-ge-boolX-bintY-inline self-2066 other-2067)
  `(py-ge-boolX-bintY-fallback ,self-2066 ,other-2067))

(define-macro (py-test-ge-boolX-bintY-inline self-2069 other-2070)
  `(py-test-ge-boolX-bintY-fallback ,self-2069 ,other-2070))

(define-macro (py-ge-sintX-intY-inline self-2072 other-2073)
  `(py-ge-sintX-intY-fallback ,self-2072 ,other-2073))

(define-macro (py-test-ge-sintX-intY-inline self-2075 other-2076)
  `(py-test-ge-sintX-intY-fallback ,self-2075 ,other-2076))

(define-macro (py-ge-sintX-floatY-inline other-2078 self-2079)
  `(let ((other-2078 ,other-2078) (self-2079 ,self-2079))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py<= (py-float-to-scheme self-2079) (py-sint-to-scheme other-2078))))))

(define-macro (py-test-ge-sintX-floatY-inline other-2081 self-2082)
  `(let ((other-2081 ,other-2081) (self-2082 ,self-2082))
     (py-test-from-scheme
      (py<= (py-float-to-scheme self-2082) (py-sint-to-scheme other-2081)))))

(define-macro (py-ge-sintX-boolY-inline self-2084 other-2085)
  `(py-ge-sintX-boolY-fallback ,self-2084 ,other-2085))

(define-macro (py-test-ge-sintX-boolY-inline self-2087 other-2088)
  `(py-test-ge-sintX-boolY-fallback ,self-2087 ,other-2088))

(define-macro (py-ge-sintX-sintY-inline self-2090 other-2091)
  `(let ((self-2090 ,self-2090) (other-2091 ,other-2091))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py>= (py-sint-to-scheme self-2090) (py-sint-to-scheme other-2091))))))

(define-macro (py-test-ge-sintX-sintY-inline self-2093 other-2094)
  `(let ((self-2093 ,self-2093) (other-2094 ,other-2094))
     (py-test-from-scheme
      (py>= (py-sint-to-scheme self-2093) (py-sint-to-scheme other-2094)))))

(define-macro (py-ge-sintX-bintY-inline self-2096 other-2097)
  `(py-ge-sintX-bintY-fallback ,self-2096 ,other-2097))

(define-macro (py-test-ge-sintX-bintY-inline self-2099 other-2100)
  `(py-test-ge-sintX-bintY-fallback ,self-2099 ,other-2100))

(define-macro (py-ge-bintX-intY-inline self-2102 other-2103)
  `(py-ge-bintX-intY-fallback ,self-2102 ,other-2103))

(define-macro (py-test-ge-bintX-intY-inline self-2105 other-2106)
  `(py-test-ge-bintX-intY-fallback ,self-2105 ,other-2106))

(define-macro (py-ge-bintX-floatY-inline other-2108 self-2109)
  `(py-ge-bintX-floatY-fallback ,other-2108 ,self-2109))

(define-macro (py-test-ge-bintX-floatY-inline other-2111 self-2112)
  `(py-test-ge-bintX-floatY-fallback ,other-2111 ,self-2112))

(define-macro (py-ge-bintX-boolY-inline self-2114 other-2115)
  `(py-ge-bintX-boolY-fallback ,self-2114 ,other-2115))

(define-macro (py-test-ge-bintX-boolY-inline self-2117 other-2118)
  `(py-test-ge-bintX-boolY-fallback ,self-2117 ,other-2118))

(define-macro (py-ge-bintX-sintY-inline self-2120 other-2121)
  `(py-ge-bintX-sintY-fallback ,self-2120 ,other-2121))

(define-macro (py-test-ge-bintX-sintY-inline self-2123 other-2124)
  `(py-test-ge-bintX-sintY-fallback ,self-2123 ,other-2124))

(define-macro (py-ge-bintX-bintY-inline self-2126 other-2127)
  `(py-ge-bintX-bintY-fallback ,self-2126 ,other-2127))

(define-macro (py-test-ge-bintX-bintY-inline self-2129 other-2130)
  `(py-test-ge-bintX-bintY-fallback ,self-2129 ,other-2130))

(define-macro (py-gt-intX-intY-inline self-2132 other-2133)
  `(py-gt-intX-intY-fallback ,self-2132 ,other-2133))

(define-macro (py-test-gt-intX-intY-inline self-2135 other-2136)
  `(py-test-gt-intX-intY-fallback ,self-2135 ,other-2136))

(define-macro (py-gt-intX-floatY-inline other-2138 self-2139)
  `(py-gt-intX-floatY-fallback ,other-2138 ,self-2139))

(define-macro (py-test-gt-intX-floatY-inline other-2141 self-2142)
  `(py-test-gt-intX-floatY-fallback ,other-2141 ,self-2142))

(define-macro (py-gt-intX-boolY-inline self-2144 other-2145)
  `(py-gt-intX-boolY-fallback ,self-2144 ,other-2145))

(define-macro (py-test-gt-intX-boolY-inline self-2147 other-2148)
  `(py-test-gt-intX-boolY-fallback ,self-2147 ,other-2148))

(define-macro (py-gt-intX-sintY-inline self-2150 other-2151)
  `(py-gt-intX-sintY-fallback ,self-2150 ,other-2151))

(define-macro (py-test-gt-intX-sintY-inline self-2153 other-2154)
  `(py-test-gt-intX-sintY-fallback ,self-2153 ,other-2154))

(define-macro (py-gt-intX-bintY-inline self-2156 other-2157)
  `(py-gt-intX-bintY-fallback ,self-2156 ,other-2157))

(define-macro (py-test-gt-intX-bintY-inline self-2159 other-2160)
  `(py-test-gt-intX-bintY-fallback ,self-2159 ,other-2160))

(define-macro (py-gt-floatX-intY-inline self-2162 other-2163)
  `(py-gt-floatX-intY-fallback ,self-2162 ,other-2163))

(define-macro (py-test-gt-floatX-intY-inline self-2165 other-2166)
  `(py-test-gt-floatX-intY-fallback ,self-2165 ,other-2166))

(define-macro (py-gt-floatX-floatY-inline self-2168 other-2169)
  `(let ((self-2168 ,self-2168) (other-2169 ,other-2169))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py> (py-float-to-scheme self-2168) (py-float-to-scheme other-2169))))))

(define-macro (py-test-gt-floatX-floatY-inline self-2171 other-2172)
  `(let ((self-2171 ,self-2171) (other-2172 ,other-2172))
     (py-test-from-scheme
      (py> (py-float-to-scheme self-2171) (py-float-to-scheme other-2172)))))

(define-macro (py-gt-floatX-boolY-inline self-2174 other-2175)
  `(py-gt-floatX-boolY-fallback ,self-2174 ,other-2175))

(define-macro (py-test-gt-floatX-boolY-inline self-2177 other-2178)
  `(py-test-gt-floatX-boolY-fallback ,self-2177 ,other-2178))

(define-macro (py-gt-floatX-sintY-inline self-2180 other-2181)
  `(let ((self-2180 ,self-2180) (other-2181 ,other-2181))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py> (py-float-to-scheme self-2180) (py-sint-to-scheme other-2181))))))

(define-macro (py-test-gt-floatX-sintY-inline self-2183 other-2184)
  `(let ((self-2183 ,self-2183) (other-2184 ,other-2184))
     (py-test-from-scheme
      (py> (py-float-to-scheme self-2183) (py-sint-to-scheme other-2184)))))

(define-macro (py-gt-floatX-bintY-inline self-2186 other-2187)
  `(py-gt-floatX-bintY-fallback ,self-2186 ,other-2187))

(define-macro (py-test-gt-floatX-bintY-inline self-2189 other-2190)
  `(py-test-gt-floatX-bintY-fallback ,self-2189 ,other-2190))

(define-macro (py-gt-boolX-intY-inline self-2192 other-2193)
  `(py-gt-boolX-intY-fallback ,self-2192 ,other-2193))

(define-macro (py-test-gt-boolX-intY-inline self-2195 other-2196)
  `(py-test-gt-boolX-intY-fallback ,self-2195 ,other-2196))

(define-macro (py-gt-boolX-floatY-inline other-2198 self-2199)
  `(py-gt-boolX-floatY-fallback ,other-2198 ,self-2199))

(define-macro (py-test-gt-boolX-floatY-inline other-2201 self-2202)
  `(py-test-gt-boolX-floatY-fallback ,other-2201 ,self-2202))

(define-macro (py-gt-boolX-boolY-inline self-2204 other-2205)
  `(py-gt-boolX-boolY-fallback ,self-2204 ,other-2205))

(define-macro (py-test-gt-boolX-boolY-inline self-2207 other-2208)
  `(py-test-gt-boolX-boolY-fallback ,self-2207 ,other-2208))

(define-macro (py-gt-boolX-sintY-inline self-2210 other-2211)
  `(py-gt-boolX-sintY-fallback ,self-2210 ,other-2211))

(define-macro (py-test-gt-boolX-sintY-inline self-2213 other-2214)
  `(py-test-gt-boolX-sintY-fallback ,self-2213 ,other-2214))

(define-macro (py-gt-boolX-bintY-inline self-2216 other-2217)
  `(py-gt-boolX-bintY-fallback ,self-2216 ,other-2217))

(define-macro (py-test-gt-boolX-bintY-inline self-2219 other-2220)
  `(py-test-gt-boolX-bintY-fallback ,self-2219 ,other-2220))

(define-macro (py-gt-sintX-intY-inline self-2222 other-2223)
  `(py-gt-sintX-intY-fallback ,self-2222 ,other-2223))

(define-macro (py-test-gt-sintX-intY-inline self-2225 other-2226)
  `(py-test-gt-sintX-intY-fallback ,self-2225 ,other-2226))

(define-macro (py-gt-sintX-floatY-inline other-2228 self-2229)
  `(let ((other-2228 ,other-2228) (self-2229 ,self-2229))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py< (py-float-to-scheme self-2229) (py-sint-to-scheme other-2228))))))

(define-macro (py-test-gt-sintX-floatY-inline other-2231 self-2232)
  `(let ((other-2231 ,other-2231) (self-2232 ,self-2232))
     (py-test-from-scheme
      (py< (py-float-to-scheme self-2232) (py-sint-to-scheme other-2231)))))

(define-macro (py-gt-sintX-boolY-inline self-2234 other-2235)
  `(py-gt-sintX-boolY-fallback ,self-2234 ,other-2235))

(define-macro (py-test-gt-sintX-boolY-inline self-2237 other-2238)
  `(py-test-gt-sintX-boolY-fallback ,self-2237 ,other-2238))

(define-macro (py-gt-sintX-sintY-inline self-2240 other-2241)
  `(let ((self-2240 ,self-2240) (other-2241 ,other-2241))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py> (py-sint-to-scheme self-2240) (py-sint-to-scheme other-2241))))))

(define-macro (py-test-gt-sintX-sintY-inline self-2243 other-2244)
  `(let ((self-2243 ,self-2243) (other-2244 ,other-2244))
     (py-test-from-scheme
      (py> (py-sint-to-scheme self-2243) (py-sint-to-scheme other-2244)))))

(define-macro (py-gt-sintX-bintY-inline self-2246 other-2247)
  `(py-gt-sintX-bintY-fallback ,self-2246 ,other-2247))

(define-macro (py-test-gt-sintX-bintY-inline self-2249 other-2250)
  `(py-test-gt-sintX-bintY-fallback ,self-2249 ,other-2250))

(define-macro (py-gt-bintX-intY-inline self-2252 other-2253)
  `(py-gt-bintX-intY-fallback ,self-2252 ,other-2253))

(define-macro (py-test-gt-bintX-intY-inline self-2255 other-2256)
  `(py-test-gt-bintX-intY-fallback ,self-2255 ,other-2256))

(define-macro (py-gt-bintX-floatY-inline other-2258 self-2259)
  `(py-gt-bintX-floatY-fallback ,other-2258 ,self-2259))

(define-macro (py-test-gt-bintX-floatY-inline other-2261 self-2262)
  `(py-test-gt-bintX-floatY-fallback ,other-2261 ,self-2262))

(define-macro (py-gt-bintX-boolY-inline self-2264 other-2265)
  `(py-gt-bintX-boolY-fallback ,self-2264 ,other-2265))

(define-macro (py-test-gt-bintX-boolY-inline self-2267 other-2268)
  `(py-test-gt-bintX-boolY-fallback ,self-2267 ,other-2268))

(define-macro (py-gt-bintX-sintY-inline self-2270 other-2271)
  `(py-gt-bintX-sintY-fallback ,self-2270 ,other-2271))

(define-macro (py-test-gt-bintX-sintY-inline self-2273 other-2274)
  `(py-test-gt-bintX-sintY-fallback ,self-2273 ,other-2274))

(define-macro (py-gt-bintX-bintY-inline self-2276 other-2277)
  `(py-gt-bintX-bintY-fallback ,self-2276 ,other-2277))

(define-macro (py-test-gt-bintX-bintY-inline self-2279 other-2280)
  `(py-test-gt-bintX-bintY-fallback ,self-2279 ,other-2280))

(define-macro (py-le-intX-intY-inline self-2282 other-2283)
  `(py-le-intX-intY-fallback ,self-2282 ,other-2283))

(define-macro (py-test-le-intX-intY-inline self-2285 other-2286)
  `(py-test-le-intX-intY-fallback ,self-2285 ,other-2286))

(define-macro (py-le-intX-floatY-inline other-2288 self-2289)
  `(py-le-intX-floatY-fallback ,other-2288 ,self-2289))

(define-macro (py-test-le-intX-floatY-inline other-2291 self-2292)
  `(py-test-le-intX-floatY-fallback ,other-2291 ,self-2292))

(define-macro (py-le-intX-boolY-inline self-2294 other-2295)
  `(py-le-intX-boolY-fallback ,self-2294 ,other-2295))

(define-macro (py-test-le-intX-boolY-inline self-2297 other-2298)
  `(py-test-le-intX-boolY-fallback ,self-2297 ,other-2298))

(define-macro (py-le-intX-sintY-inline self-2300 other-2301)
  `(py-le-intX-sintY-fallback ,self-2300 ,other-2301))

(define-macro (py-test-le-intX-sintY-inline self-2303 other-2304)
  `(py-test-le-intX-sintY-fallback ,self-2303 ,other-2304))

(define-macro (py-le-intX-bintY-inline self-2306 other-2307)
  `(py-le-intX-bintY-fallback ,self-2306 ,other-2307))

(define-macro (py-test-le-intX-bintY-inline self-2309 other-2310)
  `(py-test-le-intX-bintY-fallback ,self-2309 ,other-2310))

(define-macro (py-le-floatX-intY-inline self-2312 other-2313)
  `(py-le-floatX-intY-fallback ,self-2312 ,other-2313))

(define-macro (py-test-le-floatX-intY-inline self-2315 other-2316)
  `(py-test-le-floatX-intY-fallback ,self-2315 ,other-2316))

(define-macro (py-le-floatX-floatY-inline self-2318 other-2319)
  `(let ((self-2318 ,self-2318) (other-2319 ,other-2319))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py<= (py-float-to-scheme self-2318)
             (py-float-to-scheme other-2319))))))

(define-macro (py-test-le-floatX-floatY-inline self-2321 other-2322)
  `(let ((self-2321 ,self-2321) (other-2322 ,other-2322))
     (py-test-from-scheme
      (py<= (py-float-to-scheme self-2321) (py-float-to-scheme other-2322)))))

(define-macro (py-le-floatX-boolY-inline self-2324 other-2325)
  `(py-le-floatX-boolY-fallback ,self-2324 ,other-2325))

(define-macro (py-test-le-floatX-boolY-inline self-2327 other-2328)
  `(py-test-le-floatX-boolY-fallback ,self-2327 ,other-2328))

(define-macro (py-le-floatX-sintY-inline self-2330 other-2331)
  `(let ((self-2330 ,self-2330) (other-2331 ,other-2331))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py<= (py-float-to-scheme self-2330) (py-sint-to-scheme other-2331))))))

(define-macro (py-test-le-floatX-sintY-inline self-2333 other-2334)
  `(let ((self-2333 ,self-2333) (other-2334 ,other-2334))
     (py-test-from-scheme
      (py<= (py-float-to-scheme self-2333) (py-sint-to-scheme other-2334)))))

(define-macro (py-le-floatX-bintY-inline self-2336 other-2337)
  `(py-le-floatX-bintY-fallback ,self-2336 ,other-2337))

(define-macro (py-test-le-floatX-bintY-inline self-2339 other-2340)
  `(py-test-le-floatX-bintY-fallback ,self-2339 ,other-2340))

(define-macro (py-le-boolX-intY-inline self-2342 other-2343)
  `(py-le-boolX-intY-fallback ,self-2342 ,other-2343))

(define-macro (py-test-le-boolX-intY-inline self-2345 other-2346)
  `(py-test-le-boolX-intY-fallback ,self-2345 ,other-2346))

(define-macro (py-le-boolX-floatY-inline other-2348 self-2349)
  `(py-le-boolX-floatY-fallback ,other-2348 ,self-2349))

(define-macro (py-test-le-boolX-floatY-inline other-2351 self-2352)
  `(py-test-le-boolX-floatY-fallback ,other-2351 ,self-2352))

(define-macro (py-le-boolX-boolY-inline self-2354 other-2355)
  `(py-le-boolX-boolY-fallback ,self-2354 ,other-2355))

(define-macro (py-test-le-boolX-boolY-inline self-2357 other-2358)
  `(py-test-le-boolX-boolY-fallback ,self-2357 ,other-2358))

(define-macro (py-le-boolX-sintY-inline self-2360 other-2361)
  `(py-le-boolX-sintY-fallback ,self-2360 ,other-2361))

(define-macro (py-test-le-boolX-sintY-inline self-2363 other-2364)
  `(py-test-le-boolX-sintY-fallback ,self-2363 ,other-2364))

(define-macro (py-le-boolX-bintY-inline self-2366 other-2367)
  `(py-le-boolX-bintY-fallback ,self-2366 ,other-2367))

(define-macro (py-test-le-boolX-bintY-inline self-2369 other-2370)
  `(py-test-le-boolX-bintY-fallback ,self-2369 ,other-2370))

(define-macro (py-le-sintX-intY-inline self-2372 other-2373)
  `(py-le-sintX-intY-fallback ,self-2372 ,other-2373))

(define-macro (py-test-le-sintX-intY-inline self-2375 other-2376)
  `(py-test-le-sintX-intY-fallback ,self-2375 ,other-2376))

(define-macro (py-le-sintX-floatY-inline other-2378 self-2379)
  `(let ((other-2378 ,other-2378) (self-2379 ,self-2379))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py>= (py-float-to-scheme self-2379) (py-sint-to-scheme other-2378))))))

(define-macro (py-test-le-sintX-floatY-inline other-2381 self-2382)
  `(let ((other-2381 ,other-2381) (self-2382 ,self-2382))
     (py-test-from-scheme
      (py>= (py-float-to-scheme self-2382) (py-sint-to-scheme other-2381)))))

(define-macro (py-le-sintX-boolY-inline self-2384 other-2385)
  `(py-le-sintX-boolY-fallback ,self-2384 ,other-2385))

(define-macro (py-test-le-sintX-boolY-inline self-2387 other-2388)
  `(py-test-le-sintX-boolY-fallback ,self-2387 ,other-2388))

(define-macro (py-le-sintX-sintY-inline self-2390 other-2391)
  `(let ((self-2390 ,self-2390) (other-2391 ,other-2391))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py<= (py-sint-to-scheme self-2390) (py-sint-to-scheme other-2391))))))

(define-macro (py-test-le-sintX-sintY-inline self-2393 other-2394)
  `(let ((self-2393 ,self-2393) (other-2394 ,other-2394))
     (py-test-from-scheme
      (py<= (py-sint-to-scheme self-2393) (py-sint-to-scheme other-2394)))))

(define-macro (py-le-sintX-bintY-inline self-2396 other-2397)
  `(py-le-sintX-bintY-fallback ,self-2396 ,other-2397))

(define-macro (py-test-le-sintX-bintY-inline self-2399 other-2400)
  `(py-test-le-sintX-bintY-fallback ,self-2399 ,other-2400))

(define-macro (py-le-bintX-intY-inline self-2402 other-2403)
  `(py-le-bintX-intY-fallback ,self-2402 ,other-2403))

(define-macro (py-test-le-bintX-intY-inline self-2405 other-2406)
  `(py-test-le-bintX-intY-fallback ,self-2405 ,other-2406))

(define-macro (py-le-bintX-floatY-inline other-2408 self-2409)
  `(py-le-bintX-floatY-fallback ,other-2408 ,self-2409))

(define-macro (py-test-le-bintX-floatY-inline other-2411 self-2412)
  `(py-test-le-bintX-floatY-fallback ,other-2411 ,self-2412))

(define-macro (py-le-bintX-boolY-inline self-2414 other-2415)
  `(py-le-bintX-boolY-fallback ,self-2414 ,other-2415))

(define-macro (py-test-le-bintX-boolY-inline self-2417 other-2418)
  `(py-test-le-bintX-boolY-fallback ,self-2417 ,other-2418))

(define-macro (py-le-bintX-sintY-inline self-2420 other-2421)
  `(py-le-bintX-sintY-fallback ,self-2420 ,other-2421))

(define-macro (py-test-le-bintX-sintY-inline self-2423 other-2424)
  `(py-test-le-bintX-sintY-fallback ,self-2423 ,other-2424))

(define-macro (py-le-bintX-bintY-inline self-2426 other-2427)
  `(py-le-bintX-bintY-fallback ,self-2426 ,other-2427))

(define-macro (py-test-le-bintX-bintY-inline self-2429 other-2430)
  `(py-test-le-bintX-bintY-fallback ,self-2429 ,other-2430))

(define-macro (py-lt-intX-intY-inline self-2432 other-2433)
  `(py-lt-intX-intY-fallback ,self-2432 ,other-2433))

(define-macro (py-test-lt-intX-intY-inline self-2435 other-2436)
  `(py-test-lt-intX-intY-fallback ,self-2435 ,other-2436))

(define-macro (py-lt-intX-floatY-inline other-2438 self-2439)
  `(py-lt-intX-floatY-fallback ,other-2438 ,self-2439))

(define-macro (py-test-lt-intX-floatY-inline other-2441 self-2442)
  `(py-test-lt-intX-floatY-fallback ,other-2441 ,self-2442))

(define-macro (py-lt-intX-boolY-inline self-2444 other-2445)
  `(py-lt-intX-boolY-fallback ,self-2444 ,other-2445))

(define-macro (py-test-lt-intX-boolY-inline self-2447 other-2448)
  `(py-test-lt-intX-boolY-fallback ,self-2447 ,other-2448))

(define-macro (py-lt-intX-sintY-inline self-2450 other-2451)
  `(py-lt-intX-sintY-fallback ,self-2450 ,other-2451))

(define-macro (py-test-lt-intX-sintY-inline self-2453 other-2454)
  `(py-test-lt-intX-sintY-fallback ,self-2453 ,other-2454))

(define-macro (py-lt-intX-bintY-inline self-2456 other-2457)
  `(py-lt-intX-bintY-fallback ,self-2456 ,other-2457))

(define-macro (py-test-lt-intX-bintY-inline self-2459 other-2460)
  `(py-test-lt-intX-bintY-fallback ,self-2459 ,other-2460))

(define-macro (py-lt-floatX-intY-inline self-2462 other-2463)
  `(py-lt-floatX-intY-fallback ,self-2462 ,other-2463))

(define-macro (py-test-lt-floatX-intY-inline self-2465 other-2466)
  `(py-test-lt-floatX-intY-fallback ,self-2465 ,other-2466))

(define-macro (py-lt-floatX-floatY-inline self-2468 other-2469)
  `(let ((self-2468 ,self-2468) (other-2469 ,other-2469))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py< (py-float-to-scheme self-2468) (py-float-to-scheme other-2469))))))

(define-macro (py-test-lt-floatX-floatY-inline self-2471 other-2472)
  `(let ((self-2471 ,self-2471) (other-2472 ,other-2472))
     (py-test-from-scheme
      (py< (py-float-to-scheme self-2471) (py-float-to-scheme other-2472)))))

(define-macro (py-lt-floatX-boolY-inline self-2474 other-2475)
  `(py-lt-floatX-boolY-fallback ,self-2474 ,other-2475))

(define-macro (py-test-lt-floatX-boolY-inline self-2477 other-2478)
  `(py-test-lt-floatX-boolY-fallback ,self-2477 ,other-2478))

(define-macro (py-lt-floatX-sintY-inline self-2480 other-2481)
  `(let ((self-2480 ,self-2480) (other-2481 ,other-2481))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py< (py-float-to-scheme self-2480) (py-sint-to-scheme other-2481))))))

(define-macro (py-test-lt-floatX-sintY-inline self-2483 other-2484)
  `(let ((self-2483 ,self-2483) (other-2484 ,other-2484))
     (py-test-from-scheme
      (py< (py-float-to-scheme self-2483) (py-sint-to-scheme other-2484)))))

(define-macro (py-lt-floatX-bintY-inline self-2486 other-2487)
  `(py-lt-floatX-bintY-fallback ,self-2486 ,other-2487))

(define-macro (py-test-lt-floatX-bintY-inline self-2489 other-2490)
  `(py-test-lt-floatX-bintY-fallback ,self-2489 ,other-2490))

(define-macro (py-lt-boolX-intY-inline self-2492 other-2493)
  `(py-lt-boolX-intY-fallback ,self-2492 ,other-2493))

(define-macro (py-test-lt-boolX-intY-inline self-2495 other-2496)
  `(py-test-lt-boolX-intY-fallback ,self-2495 ,other-2496))

(define-macro (py-lt-boolX-floatY-inline other-2498 self-2499)
  `(py-lt-boolX-floatY-fallback ,other-2498 ,self-2499))

(define-macro (py-test-lt-boolX-floatY-inline other-2501 self-2502)
  `(py-test-lt-boolX-floatY-fallback ,other-2501 ,self-2502))

(define-macro (py-lt-boolX-boolY-inline self-2504 other-2505)
  `(py-lt-boolX-boolY-fallback ,self-2504 ,other-2505))

(define-macro (py-test-lt-boolX-boolY-inline self-2507 other-2508)
  `(py-test-lt-boolX-boolY-fallback ,self-2507 ,other-2508))

(define-macro (py-lt-boolX-sintY-inline self-2510 other-2511)
  `(py-lt-boolX-sintY-fallback ,self-2510 ,other-2511))

(define-macro (py-test-lt-boolX-sintY-inline self-2513 other-2514)
  `(py-test-lt-boolX-sintY-fallback ,self-2513 ,other-2514))

(define-macro (py-lt-boolX-bintY-inline self-2516 other-2517)
  `(py-lt-boolX-bintY-fallback ,self-2516 ,other-2517))

(define-macro (py-test-lt-boolX-bintY-inline self-2519 other-2520)
  `(py-test-lt-boolX-bintY-fallback ,self-2519 ,other-2520))

(define-macro (py-lt-sintX-intY-inline self-2522 other-2523)
  `(py-lt-sintX-intY-fallback ,self-2522 ,other-2523))

(define-macro (py-test-lt-sintX-intY-inline self-2525 other-2526)
  `(py-test-lt-sintX-intY-fallback ,self-2525 ,other-2526))

(define-macro (py-lt-sintX-floatY-inline other-2528 self-2529)
  `(let ((other-2528 ,other-2528) (self-2529 ,self-2529))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py> (py-float-to-scheme self-2529) (py-sint-to-scheme other-2528))))))

(define-macro (py-test-lt-sintX-floatY-inline other-2531 self-2532)
  `(let ((other-2531 ,other-2531) (self-2532 ,self-2532))
     (py-test-from-scheme
      (py> (py-float-to-scheme self-2532) (py-sint-to-scheme other-2531)))))

(define-macro (py-lt-sintX-boolY-inline self-2534 other-2535)
  `(py-lt-sintX-boolY-fallback ,self-2534 ,other-2535))

(define-macro (py-test-lt-sintX-boolY-inline self-2537 other-2538)
  `(py-test-lt-sintX-boolY-fallback ,self-2537 ,other-2538))

(define-macro (py-lt-sintX-sintY-inline self-2540 other-2541)
  `(let ((self-2540 ,self-2540) (other-2541 ,other-2541))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py< (py-sint-to-scheme self-2540) (py-sint-to-scheme other-2541))))))

(define-macro (py-test-lt-sintX-sintY-inline self-2543 other-2544)
  `(let ((self-2543 ,self-2543) (other-2544 ,other-2544))
     (py-test-from-scheme
      (py< (py-sint-to-scheme self-2543) (py-sint-to-scheme other-2544)))))

(define-macro (py-lt-sintX-bintY-inline self-2546 other-2547)
  `(py-lt-sintX-bintY-fallback ,self-2546 ,other-2547))

(define-macro (py-test-lt-sintX-bintY-inline self-2549 other-2550)
  `(py-test-lt-sintX-bintY-fallback ,self-2549 ,other-2550))

(define-macro (py-lt-bintX-intY-inline self-2552 other-2553)
  `(py-lt-bintX-intY-fallback ,self-2552 ,other-2553))

(define-macro (py-test-lt-bintX-intY-inline self-2555 other-2556)
  `(py-test-lt-bintX-intY-fallback ,self-2555 ,other-2556))

(define-macro (py-lt-bintX-floatY-inline other-2558 self-2559)
  `(py-lt-bintX-floatY-fallback ,other-2558 ,self-2559))

(define-macro (py-test-lt-bintX-floatY-inline other-2561 self-2562)
  `(py-test-lt-bintX-floatY-fallback ,other-2561 ,self-2562))

(define-macro (py-lt-bintX-boolY-inline self-2564 other-2565)
  `(py-lt-bintX-boolY-fallback ,self-2564 ,other-2565))

(define-macro (py-test-lt-bintX-boolY-inline self-2567 other-2568)
  `(py-test-lt-bintX-boolY-fallback ,self-2567 ,other-2568))

(define-macro (py-lt-bintX-sintY-inline self-2570 other-2571)
  `(py-lt-bintX-sintY-fallback ,self-2570 ,other-2571))

(define-macro (py-test-lt-bintX-sintY-inline self-2573 other-2574)
  `(py-test-lt-bintX-sintY-fallback ,self-2573 ,other-2574))

(define-macro (py-lt-bintX-bintY-inline self-2576 other-2577)
  `(py-lt-bintX-bintY-fallback ,self-2576 ,other-2577))

(define-macro (py-test-lt-bintX-bintY-inline self-2579 other-2580)
  `(py-test-lt-bintX-bintY-fallback ,self-2579 ,other-2580))

(define-macro (py-eq-intX-intY-inline self-2582 other-2583)
  `(py-eq-intX-intY-fallback ,self-2582 ,other-2583))

(define-macro (py-test-eq-intX-intY-inline self-2585 other-2586)
  `(py-test-eq-intX-intY-fallback ,self-2585 ,other-2586))

(define-macro (py-eq-intX-floatY-inline other-2588 self-2589)
  `(py-eq-intX-floatY-fallback ,other-2588 ,self-2589))

(define-macro (py-test-eq-intX-floatY-inline other-2591 self-2592)
  `(py-test-eq-intX-floatY-fallback ,other-2591 ,self-2592))

(define-macro (py-eq-intX-boolY-inline self-2594 other-2595)
  `(py-eq-intX-boolY-fallback ,self-2594 ,other-2595))

(define-macro (py-test-eq-intX-boolY-inline self-2597 other-2598)
  `(py-test-eq-intX-boolY-fallback ,self-2597 ,other-2598))

(define-macro (py-eq-intX-sintY-inline self-2600 other-2601)
  `(py-eq-intX-sintY-fallback ,self-2600 ,other-2601))

(define-macro (py-test-eq-intX-sintY-inline self-2603 other-2604)
  `(py-test-eq-intX-sintY-fallback ,self-2603 ,other-2604))

(define-macro (py-eq-intX-bintY-inline self-2606 other-2607)
  `(py-eq-intX-bintY-fallback ,self-2606 ,other-2607))

(define-macro (py-test-eq-intX-bintY-inline self-2609 other-2610)
  `(py-test-eq-intX-bintY-fallback ,self-2609 ,other-2610))

(define-macro (py-eq-floatX-intY-inline self-2612 other-2613)
  `(py-eq-floatX-intY-fallback ,self-2612 ,other-2613))

(define-macro (py-test-eq-floatX-intY-inline self-2615 other-2616)
  `(py-test-eq-floatX-intY-fallback ,self-2615 ,other-2616))

(define-macro (py-eq-floatX-floatY-inline self-2618 other-2619)
  `(let ((self-2618 ,self-2618) (other-2619 ,other-2619))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py== (py-float-to-scheme self-2618)
             (py-float-to-scheme other-2619))))))

(define-macro (py-test-eq-floatX-floatY-inline self-2621 other-2622)
  `(let ((self-2621 ,self-2621) (other-2622 ,other-2622))
     (py-test-from-scheme
      (py== (py-float-to-scheme self-2621) (py-float-to-scheme other-2622)))))

(define-macro (py-eq-floatX-boolY-inline self-2624 other-2625)
  `(py-eq-floatX-boolY-fallback ,self-2624 ,other-2625))

(define-macro (py-test-eq-floatX-boolY-inline self-2627 other-2628)
  `(py-test-eq-floatX-boolY-fallback ,self-2627 ,other-2628))

(define-macro (py-eq-floatX-sintY-inline self-2630 other-2631)
  `(let ((self-2630 ,self-2630) (other-2631 ,other-2631))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py== (py-float-to-scheme self-2630) (py-sint-to-scheme other-2631))))))

(define-macro (py-test-eq-floatX-sintY-inline self-2633 other-2634)
  `(let ((self-2633 ,self-2633) (other-2634 ,other-2634))
     (py-test-from-scheme
      (py== (py-float-to-scheme self-2633) (py-sint-to-scheme other-2634)))))

(define-macro (py-eq-floatX-bintY-inline self-2636 other-2637)
  `(py-eq-floatX-bintY-fallback ,self-2636 ,other-2637))

(define-macro (py-test-eq-floatX-bintY-inline self-2639 other-2640)
  `(py-test-eq-floatX-bintY-fallback ,self-2639 ,other-2640))

(define-macro (py-eq-boolX-intY-inline self-2642 other-2643)
  `(py-eq-boolX-intY-fallback ,self-2642 ,other-2643))

(define-macro (py-test-eq-boolX-intY-inline self-2645 other-2646)
  `(py-test-eq-boolX-intY-fallback ,self-2645 ,other-2646))

(define-macro (py-eq-boolX-floatY-inline other-2648 self-2649)
  `(py-eq-boolX-floatY-fallback ,other-2648 ,self-2649))

(define-macro (py-test-eq-boolX-floatY-inline other-2651 self-2652)
  `(py-test-eq-boolX-floatY-fallback ,other-2651 ,self-2652))

(define-macro (py-eq-boolX-boolY-inline self-2654 other-2655)
  `(py-eq-boolX-boolY-fallback ,self-2654 ,other-2655))

(define-macro (py-test-eq-boolX-boolY-inline self-2657 other-2658)
  `(py-test-eq-boolX-boolY-fallback ,self-2657 ,other-2658))

(define-macro (py-eq-boolX-sintY-inline self-2660 other-2661)
  `(py-eq-boolX-sintY-fallback ,self-2660 ,other-2661))

(define-macro (py-test-eq-boolX-sintY-inline self-2663 other-2664)
  `(py-test-eq-boolX-sintY-fallback ,self-2663 ,other-2664))

(define-macro (py-eq-boolX-bintY-inline self-2666 other-2667)
  `(py-eq-boolX-bintY-fallback ,self-2666 ,other-2667))

(define-macro (py-test-eq-boolX-bintY-inline self-2669 other-2670)
  `(py-test-eq-boolX-bintY-fallback ,self-2669 ,other-2670))

(define-macro (py-eq-sintX-intY-inline self-2672 other-2673)
  `(py-eq-sintX-intY-fallback ,self-2672 ,other-2673))

(define-macro (py-test-eq-sintX-intY-inline self-2675 other-2676)
  `(py-test-eq-sintX-intY-fallback ,self-2675 ,other-2676))

(define-macro (py-eq-sintX-floatY-inline other-2678 self-2679)
  `(let ((other-2678 ,other-2678) (self-2679 ,self-2679))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py== (py-float-to-scheme self-2679) (py-sint-to-scheme other-2678))))))

(define-macro (py-test-eq-sintX-floatY-inline other-2681 self-2682)
  `(let ((other-2681 ,other-2681) (self-2682 ,self-2682))
     (py-test-from-scheme
      (py== (py-float-to-scheme self-2682) (py-sint-to-scheme other-2681)))))

(define-macro (py-eq-sintX-boolY-inline self-2684 other-2685)
  `(py-eq-sintX-boolY-fallback ,self-2684 ,other-2685))

(define-macro (py-test-eq-sintX-boolY-inline self-2687 other-2688)
  `(py-test-eq-sintX-boolY-fallback ,self-2687 ,other-2688))

(define-macro (py-eq-sintX-sintY-inline self-2690 other-2691)
  `(let ((self-2690 ,self-2690) (other-2691 ,other-2691))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py== (py-sint-to-scheme self-2690) (py-sint-to-scheme other-2691))))))

(define-macro (py-test-eq-sintX-sintY-inline self-2693 other-2694)
  `(let ((self-2693 ,self-2693) (other-2694 ,other-2694))
     (py-test-from-scheme
      (py== (py-sint-to-scheme self-2693) (py-sint-to-scheme other-2694)))))

(define-macro (py-eq-sintX-bintY-inline self-2696 other-2697)
  `(py-eq-sintX-bintY-fallback ,self-2696 ,other-2697))

(define-macro (py-test-eq-sintX-bintY-inline self-2699 other-2700)
  `(py-test-eq-sintX-bintY-fallback ,self-2699 ,other-2700))

(define-macro (py-eq-bintX-intY-inline self-2702 other-2703)
  `(py-eq-bintX-intY-fallback ,self-2702 ,other-2703))

(define-macro (py-test-eq-bintX-intY-inline self-2705 other-2706)
  `(py-test-eq-bintX-intY-fallback ,self-2705 ,other-2706))

(define-macro (py-eq-bintX-floatY-inline other-2708 self-2709)
  `(py-eq-bintX-floatY-fallback ,other-2708 ,self-2709))

(define-macro (py-test-eq-bintX-floatY-inline other-2711 self-2712)
  `(py-test-eq-bintX-floatY-fallback ,other-2711 ,self-2712))

(define-macro (py-eq-bintX-boolY-inline self-2714 other-2715)
  `(py-eq-bintX-boolY-fallback ,self-2714 ,other-2715))

(define-macro (py-test-eq-bintX-boolY-inline self-2717 other-2718)
  `(py-test-eq-bintX-boolY-fallback ,self-2717 ,other-2718))

(define-macro (py-eq-bintX-sintY-inline self-2720 other-2721)
  `(py-eq-bintX-sintY-fallback ,self-2720 ,other-2721))

(define-macro (py-test-eq-bintX-sintY-inline self-2723 other-2724)
  `(py-test-eq-bintX-sintY-fallback ,self-2723 ,other-2724))

(define-macro (py-eq-bintX-bintY-inline self-2726 other-2727)
  `(py-eq-bintX-bintY-fallback ,self-2726 ,other-2727))

(define-macro (py-test-eq-bintX-bintY-inline self-2729 other-2730)
  `(py-test-eq-bintX-bintY-fallback ,self-2729 ,other-2730))

(define-macro (py-ne-intX-intY-inline self-2732 other-2733)
  `(py-ne-intX-intY-fallback ,self-2732 ,other-2733))

(define-macro (py-test-ne-intX-intY-inline self-2735 other-2736)
  `(py-test-ne-intX-intY-fallback ,self-2735 ,other-2736))

(define-macro (py-ne-intX-floatY-inline other-2738 self-2739)
  `(py-ne-intX-floatY-fallback ,other-2738 ,self-2739))

(define-macro (py-test-ne-intX-floatY-inline other-2741 self-2742)
  `(py-test-ne-intX-floatY-fallback ,other-2741 ,self-2742))

(define-macro (py-ne-intX-boolY-inline self-2744 other-2745)
  `(py-ne-intX-boolY-fallback ,self-2744 ,other-2745))

(define-macro (py-test-ne-intX-boolY-inline self-2747 other-2748)
  `(py-test-ne-intX-boolY-fallback ,self-2747 ,other-2748))

(define-macro (py-ne-intX-sintY-inline self-2750 other-2751)
  `(py-ne-intX-sintY-fallback ,self-2750 ,other-2751))

(define-macro (py-test-ne-intX-sintY-inline self-2753 other-2754)
  `(py-test-ne-intX-sintY-fallback ,self-2753 ,other-2754))

(define-macro (py-ne-intX-bintY-inline self-2756 other-2757)
  `(py-ne-intX-bintY-fallback ,self-2756 ,other-2757))

(define-macro (py-test-ne-intX-bintY-inline self-2759 other-2760)
  `(py-test-ne-intX-bintY-fallback ,self-2759 ,other-2760))

(define-macro (py-ne-floatX-intY-inline self-2762 other-2763)
  `(py-ne-floatX-intY-fallback ,self-2762 ,other-2763))

(define-macro (py-test-ne-floatX-intY-inline self-2765 other-2766)
  `(py-test-ne-floatX-intY-fallback ,self-2765 ,other-2766))

(define-macro (py-ne-floatX-floatY-inline self-2768 other-2769)
  `(let ((self-2768 ,self-2768) (other-2769 ,other-2769))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py!= (py-float-to-scheme self-2768)
             (py-float-to-scheme other-2769))))))

(define-macro (py-test-ne-floatX-floatY-inline self-2771 other-2772)
  `(let ((self-2771 ,self-2771) (other-2772 ,other-2772))
     (py-test-from-scheme
      (py!= (py-float-to-scheme self-2771) (py-float-to-scheme other-2772)))))

(define-macro (py-ne-floatX-boolY-inline self-2774 other-2775)
  `(py-ne-floatX-boolY-fallback ,self-2774 ,other-2775))

(define-macro (py-test-ne-floatX-boolY-inline self-2777 other-2778)
  `(py-test-ne-floatX-boolY-fallback ,self-2777 ,other-2778))

(define-macro (py-ne-floatX-sintY-inline self-2780 other-2781)
  `(let ((self-2780 ,self-2780) (other-2781 ,other-2781))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py!= (py-float-to-scheme self-2780) (py-sint-to-scheme other-2781))))))

(define-macro (py-test-ne-floatX-sintY-inline self-2783 other-2784)
  `(let ((self-2783 ,self-2783) (other-2784 ,other-2784))
     (py-test-from-scheme
      (py!= (py-float-to-scheme self-2783) (py-sint-to-scheme other-2784)))))

(define-macro (py-ne-floatX-bintY-inline self-2786 other-2787)
  `(py-ne-floatX-bintY-fallback ,self-2786 ,other-2787))

(define-macro (py-test-ne-floatX-bintY-inline self-2789 other-2790)
  `(py-test-ne-floatX-bintY-fallback ,self-2789 ,other-2790))

(define-macro (py-ne-boolX-intY-inline self-2792 other-2793)
  `(py-ne-boolX-intY-fallback ,self-2792 ,other-2793))

(define-macro (py-test-ne-boolX-intY-inline self-2795 other-2796)
  `(py-test-ne-boolX-intY-fallback ,self-2795 ,other-2796))

(define-macro (py-ne-boolX-floatY-inline other-2798 self-2799)
  `(py-ne-boolX-floatY-fallback ,other-2798 ,self-2799))

(define-macro (py-test-ne-boolX-floatY-inline other-2801 self-2802)
  `(py-test-ne-boolX-floatY-fallback ,other-2801 ,self-2802))

(define-macro (py-ne-boolX-boolY-inline self-2804 other-2805)
  `(py-ne-boolX-boolY-fallback ,self-2804 ,other-2805))

(define-macro (py-test-ne-boolX-boolY-inline self-2807 other-2808)
  `(py-test-ne-boolX-boolY-fallback ,self-2807 ,other-2808))

(define-macro (py-ne-boolX-sintY-inline self-2810 other-2811)
  `(py-ne-boolX-sintY-fallback ,self-2810 ,other-2811))

(define-macro (py-test-ne-boolX-sintY-inline self-2813 other-2814)
  `(py-test-ne-boolX-sintY-fallback ,self-2813 ,other-2814))

(define-macro (py-ne-boolX-bintY-inline self-2816 other-2817)
  `(py-ne-boolX-bintY-fallback ,self-2816 ,other-2817))

(define-macro (py-test-ne-boolX-bintY-inline self-2819 other-2820)
  `(py-test-ne-boolX-bintY-fallback ,self-2819 ,other-2820))

(define-macro (py-ne-sintX-intY-inline self-2822 other-2823)
  `(py-ne-sintX-intY-fallback ,self-2822 ,other-2823))

(define-macro (py-test-ne-sintX-intY-inline self-2825 other-2826)
  `(py-test-ne-sintX-intY-fallback ,self-2825 ,other-2826))

(define-macro (py-ne-sintX-floatY-inline other-2828 self-2829)
  `(let ((other-2828 ,other-2828) (self-2829 ,self-2829))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py!= (py-float-to-scheme self-2829) (py-sint-to-scheme other-2828))))))

(define-macro (py-test-ne-sintX-floatY-inline other-2831 self-2832)
  `(let ((other-2831 ,other-2831) (self-2832 ,self-2832))
     (py-test-from-scheme
      (py!= (py-float-to-scheme self-2832) (py-sint-to-scheme other-2831)))))

(define-macro (py-ne-sintX-boolY-inline self-2834 other-2835)
  `(py-ne-sintX-boolY-fallback ,self-2834 ,other-2835))

(define-macro (py-test-ne-sintX-boolY-inline self-2837 other-2838)
  `(py-test-ne-sintX-boolY-fallback ,self-2837 ,other-2838))

(define-macro (py-ne-sintX-sintY-inline self-2840 other-2841)
  `(let ((self-2840 ,self-2840) (other-2841 ,other-2841))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py!= (py-sint-to-scheme self-2840) (py-sint-to-scheme other-2841))))))

(define-macro (py-test-ne-sintX-sintY-inline self-2843 other-2844)
  `(let ((self-2843 ,self-2843) (other-2844 ,other-2844))
     (py-test-from-scheme
      (py!= (py-sint-to-scheme self-2843) (py-sint-to-scheme other-2844)))))

(define-macro (py-ne-sintX-bintY-inline self-2846 other-2847)
  `(py-ne-sintX-bintY-fallback ,self-2846 ,other-2847))

(define-macro (py-test-ne-sintX-bintY-inline self-2849 other-2850)
  `(py-test-ne-sintX-bintY-fallback ,self-2849 ,other-2850))

(define-macro (py-ne-bintX-intY-inline self-2852 other-2853)
  `(py-ne-bintX-intY-fallback ,self-2852 ,other-2853))

(define-macro (py-test-ne-bintX-intY-inline self-2855 other-2856)
  `(py-test-ne-bintX-intY-fallback ,self-2855 ,other-2856))

(define-macro (py-ne-bintX-floatY-inline other-2858 self-2859)
  `(py-ne-bintX-floatY-fallback ,other-2858 ,self-2859))

(define-macro (py-test-ne-bintX-floatY-inline other-2861 self-2862)
  `(py-test-ne-bintX-floatY-fallback ,other-2861 ,self-2862))

(define-macro (py-ne-bintX-boolY-inline self-2864 other-2865)
  `(py-ne-bintX-boolY-fallback ,self-2864 ,other-2865))

(define-macro (py-test-ne-bintX-boolY-inline self-2867 other-2868)
  `(py-test-ne-bintX-boolY-fallback ,self-2867 ,other-2868))

(define-macro (py-ne-bintX-sintY-inline self-2870 other-2871)
  `(py-ne-bintX-sintY-fallback ,self-2870 ,other-2871))

(define-macro (py-test-ne-bintX-sintY-inline self-2873 other-2874)
  `(py-test-ne-bintX-sintY-fallback ,self-2873 ,other-2874))

(define-macro (py-ne-bintX-bintY-inline self-2876 other-2877)
  `(py-ne-bintX-bintY-fallback ,self-2876 ,other-2877))

(define-macro (py-test-ne-bintX-bintY-inline self-2879 other-2880)
  `(py-test-ne-bintX-bintY-fallback ,self-2879 ,other-2880))

(define (py-add-intX-intY-fallback self-2 other-3)
  (py-int-from-scheme
   (py+ (py-int-to-scheme self-2) (py-int-to-scheme other-3))))

(define (py-add-intX-floatY-fallback other-5 self-6)
  (py-float-from-scheme
   (py+ (py-int-to-scheme other-5) (py-float-to-scheme self-6))))

(define (py-add-intX-boolY-fallback self-8 other-9)
  (py-int-from-scheme
   (py+ (py-int-to-scheme self-8) (py-bool-to-scheme-int other-9))))

(define (py-add-intX-sintY-fallback self-11 other-12)
  (py-int-from-scheme
   (py+ (py-int-to-scheme self-11) (py-sint-to-scheme other-12))))

(define (py-add-intX-bintY-fallback self-14 other-15)
  (py-int-from-scheme
   (py+ (py-int-to-scheme self-14) (py-bint-to-scheme other-15))))

(define (py-add-floatX-intY-fallback self-17 other-18)
  (py-float-from-scheme
   (py+ (py-float-to-scheme self-17) (py-int-to-scheme other-18))))

(define (py-add-floatX-floatY-fallback self-20 other-21)
  (py-float-from-scheme
   (py+ (py-float-to-scheme self-20) (py-float-to-scheme other-21))))

(define (py-add-floatX-boolY-fallback self-23 other-24)
  (py-float-from-scheme
   (py+ (py-float-to-scheme self-23) (py-bool-to-scheme-int other-24))))

(define (py-add-floatX-sintY-fallback self-26 other-27)
  (py-float-from-scheme
   (py+ (py-float-to-scheme self-26) (py-sint-to-scheme other-27))))

(define (py-add-floatX-bintY-fallback self-29 other-30)
  (py-float-from-scheme
   (py+ (py-float-to-scheme self-29) (py-bint-to-scheme other-30))))

(define (py-add-boolX-intY-fallback self-32 other-33)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme-int self-32) (py-int-to-scheme other-33))))

(define (py-add-boolX-floatY-fallback other-35 self-36)
  (py-float-from-scheme
   (py+ (py-bool-to-scheme-int other-35) (py-float-to-scheme self-36))))

(define (py-add-boolX-boolY-fallback self-38 other-39)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme-int self-38) (py-bool-to-scheme-int other-39))))

(define (py-add-boolX-sintY-fallback self-41 other-42)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme-int self-41) (py-sint-to-scheme other-42))))

(define (py-add-boolX-bintY-fallback self-44 other-45)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme-int self-44) (py-bint-to-scheme other-45))))

(define (py-add-sintX-intY-fallback self-47 other-48)
  (py-int-from-scheme
   (py+ (py-sint-to-scheme self-47) (py-int-to-scheme other-48))))

(define (py-add-sintX-floatY-fallback other-50 self-51)
  (py-float-from-scheme
   (py+ (py-sint-to-scheme other-50) (py-float-to-scheme self-51))))

(define (py-add-sintX-boolY-fallback self-53 other-54)
  (py-int-from-scheme
   (py+ (py-sint-to-scheme self-53) (py-bool-to-scheme-int other-54))))

(define (py-add-sintX-sintY-fallback self-56 other-57)
  (py-int-from-scheme
   (py+ (py-sint-to-scheme self-56) (py-sint-to-scheme other-57))))

(define (py-add-sintX-bintY-fallback self-59 other-60)
  (py-int-from-scheme
   (py+ (py-sint-to-scheme self-59) (py-bint-to-scheme other-60))))

(define (py-add-bintX-intY-fallback self-62 other-63)
  (py-int-from-scheme
   (py+ (py-bint-to-scheme self-62) (py-int-to-scheme other-63))))

(define (py-add-bintX-floatY-fallback other-65 self-66)
  (py-float-from-scheme
   (py+ (py-bint-to-scheme other-65) (py-float-to-scheme self-66))))

(define (py-add-bintX-boolY-fallback self-68 other-69)
  (py-int-from-scheme
   (py+ (py-bint-to-scheme self-68) (py-bool-to-scheme-int other-69))))

(define (py-add-bintX-sintY-fallback self-71 other-72)
  (py-int-from-scheme
   (py+ (py-bint-to-scheme self-71) (py-sint-to-scheme other-72))))

(define (py-add-bintX-bintY-fallback self-74 other-75)
  (py-int-from-scheme
   (py+ (py-bint-to-scheme self-74) (py-bint-to-scheme other-75))))

(define (py-bitand-intX-intY-fallback self-77 other-78)
  (py-int-from-scheme
   (py& (py-int-to-scheme self-77) (py-int-to-scheme other-78))))

(define (py-bitand-intX-floatY-fallback self-80 other-81)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'int' and 'float'"))))

(define (py-bitand-intX-boolY-fallback self-83 other-84)
  (py-int-from-scheme
   (py& (py-int-to-scheme self-83) (py-bool-to-scheme-int other-84))))

(define (py-bitand-intX-sintY-fallback self-86 other-87)
  (py-int-from-scheme
   (py& (py-int-to-scheme self-86) (py-sint-to-scheme other-87))))

(define (py-bitand-intX-bintY-fallback self-89 other-90)
  (py-int-from-scheme
   (py& (py-int-to-scheme self-89) (py-bint-to-scheme other-90))))

(define (py-bitand-floatX-intY-fallback self-92 other-93)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'int'"))))

(define (py-bitand-floatX-floatY-fallback self-95 other-96)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'float'"))))

(define (py-bitand-floatX-boolY-fallback self-98 other-99)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'bool'"))))

(define (py-bitand-floatX-sintY-fallback self-101 other-102)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'int'"))))

(define (py-bitand-floatX-bintY-fallback self-104 other-105)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'int'"))))

(define (py-bitand-boolX-intY-fallback self-107 other-108)
  (py-int-from-scheme
   (py& (py-bool-to-scheme-int self-107) (py-int-to-scheme other-108))))

(define (py-bitand-boolX-floatY-fallback self-110 other-111)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'bool' and 'float'"))))

(define (py-bitand-boolX-boolY-fallback self-113 other-114)
  (if (py-test (py-is self-113 py-True)) other-114 py-False))

(define (py-bitand-boolX-sintY-fallback self-116 other-117)
  (py-int-from-scheme
   (py& (py-bool-to-scheme-int self-116) (py-sint-to-scheme other-117))))

(define (py-bitand-boolX-bintY-fallback self-119 other-120)
  (py-int-from-scheme
   (py& (py-bool-to-scheme-int self-119) (py-bint-to-scheme other-120))))

(define (py-bitand-sintX-intY-fallback self-122 other-123)
  (py-int-from-scheme
   (py& (py-sint-to-scheme self-122) (py-int-to-scheme other-123))))

(define (py-bitand-sintX-floatY-fallback self-125 other-126)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'int' and 'float'"))))

(define (py-bitand-sintX-boolY-fallback self-128 other-129)
  (py-int-from-scheme
   (py& (py-sint-to-scheme self-128) (py-bool-to-scheme-int other-129))))

(define (py-bitand-sintX-sintY-fallback self-131 other-132)
  (py-int-from-scheme
   (py& (py-sint-to-scheme self-131) (py-sint-to-scheme other-132))))

(define (py-bitand-sintX-bintY-fallback self-134 other-135)
  (py-int-from-scheme
   (py& (py-sint-to-scheme self-134) (py-bint-to-scheme other-135))))

(define (py-bitand-bintX-intY-fallback self-137 other-138)
  (py-int-from-scheme
   (py& (py-bint-to-scheme self-137) (py-int-to-scheme other-138))))

(define (py-bitand-bintX-floatY-fallback self-140 other-141)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'int' and 'float'"))))

(define (py-bitand-bintX-boolY-fallback self-143 other-144)
  (py-int-from-scheme
   (py& (py-bint-to-scheme self-143) (py-bool-to-scheme-int other-144))))

(define (py-bitand-bintX-sintY-fallback self-146 other-147)
  (py-int-from-scheme
   (py& (py-bint-to-scheme self-146) (py-sint-to-scheme other-147))))

(define (py-bitand-bintX-bintY-fallback self-149 other-150)
  (py-int-from-scheme
   (py& (py-bint-to-scheme self-149) (py-bint-to-scheme other-150))))

(define (py-bitor-intX-intY-fallback self-152 other-153)
  (py-int-from-scheme
   (py+b (py-int-to-scheme self-152) (py-int-to-scheme other-153))))

(define (py-bitor-intX-floatY-fallback self-155 other-156)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'int' and 'float'"))))

(define (py-bitor-intX-boolY-fallback self-158 other-159)
  (py-int-from-scheme
   (py+b (py-int-to-scheme self-158) (py-bool-to-scheme-int other-159))))

(define (py-bitor-intX-sintY-fallback self-161 other-162)
  (py-int-from-scheme
   (py+b (py-int-to-scheme self-161) (py-sint-to-scheme other-162))))

(define (py-bitor-intX-bintY-fallback self-164 other-165)
  (py-int-from-scheme
   (py+b (py-int-to-scheme self-164) (py-bint-to-scheme other-165))))

(define (py-bitor-floatX-intY-fallback self-167 other-168)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'int'"))))

(define (py-bitor-floatX-floatY-fallback self-170 other-171)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'float'"))))

(define (py-bitor-floatX-boolY-fallback self-173 other-174)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'bool'"))))

(define (py-bitor-floatX-sintY-fallback self-176 other-177)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'int'"))))

(define (py-bitor-floatX-bintY-fallback self-179 other-180)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'int'"))))

(define (py-bitor-boolX-intY-fallback self-182 other-183)
  (py-int-from-scheme
   (py+b (py-bool-to-scheme-int self-182) (py-int-to-scheme other-183))))

(define (py-bitor-boolX-floatY-fallback self-185 other-186)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'bool' and 'float'"))))

(define (py-bitor-boolX-boolY-fallback self-188 other-189)
  (if (py-test (py-is self-188 py-True)) py-True other-189))

(define (py-bitor-boolX-sintY-fallback self-191 other-192)
  (py-int-from-scheme
   (py+b (py-bool-to-scheme-int self-191) (py-sint-to-scheme other-192))))

(define (py-bitor-boolX-bintY-fallback self-194 other-195)
  (py-int-from-scheme
   (py+b (py-bool-to-scheme-int self-194) (py-bint-to-scheme other-195))))

(define (py-bitor-sintX-intY-fallback self-197 other-198)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme self-197) (py-int-to-scheme other-198))))

(define (py-bitor-sintX-floatY-fallback self-200 other-201)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'int' and 'float'"))))

(define (py-bitor-sintX-boolY-fallback self-203 other-204)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme self-203) (py-bool-to-scheme-int other-204))))

(define (py-bitor-sintX-sintY-fallback self-206 other-207)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme self-206) (py-sint-to-scheme other-207))))

(define (py-bitor-sintX-bintY-fallback self-209 other-210)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme self-209) (py-bint-to-scheme other-210))))

(define (py-bitor-bintX-intY-fallback self-212 other-213)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme self-212) (py-int-to-scheme other-213))))

(define (py-bitor-bintX-floatY-fallback self-215 other-216)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'int' and 'float'"))))

(define (py-bitor-bintX-boolY-fallback self-218 other-219)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme self-218) (py-bool-to-scheme-int other-219))))

(define (py-bitor-bintX-sintY-fallback self-221 other-222)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme self-221) (py-sint-to-scheme other-222))))

(define (py-bitor-bintX-bintY-fallback self-224 other-225)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme self-224) (py-bint-to-scheme other-225))))

(define (py-floordiv-intX-intY-fallback self-227 other-228)
  (if (py-test (py-ne other-228 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-int-to-scheme self-227) (py-int-to-scheme other-228)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-intX-floatY-fallback other-230 self-231)
  (if (py-test (py-ne self-231 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-int-to-scheme other-230) (py-float-to-scheme self-231)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-intX-boolY-fallback self-233 other-234)
  (if (py-test (py-ne other-234 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-int-to-scheme self-233) (py-bool-to-scheme-int other-234)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-intX-sintY-fallback self-236 other-237)
  (if (py-test (py-ne other-237 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-int-to-scheme self-236) (py-sint-to-scheme other-237)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-intX-bintY-fallback self-239 other-240)
  (py-int-from-scheme
   (py// (py-int-to-scheme self-239) (py-bint-to-scheme other-240))))

(define (py-floordiv-floatX-intY-fallback self-242 other-243)
  (if (py-test (py-ne other-243 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py// (py-float-to-scheme self-242) (py-int-to-scheme other-243)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-floatX-floatY-fallback self-245 other-246)
  (if (py-test (py-ne other-246 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-float-to-scheme self-245) (py-float-to-scheme other-246)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-floatX-boolY-fallback self-248 other-249)
  (if (py-test (py-ne other-249 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py// (py-float-to-scheme self-248) (py-bool-to-scheme-int other-249)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-floatX-sintY-fallback self-251 other-252)
  (if (py-test (py-ne other-252 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py// (py-float-to-scheme self-251) (py-sint-to-scheme other-252)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-floatX-bintY-fallback self-254 other-255)
  (py-float-from-scheme
   (py// (py-float-to-scheme self-254) (py-bint-to-scheme other-255))))

(define (py-floordiv-boolX-intY-fallback self-257 other-258)
  (if (py-test (py-ne other-258 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bool-to-scheme-int self-257) (py-int-to-scheme other-258)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-boolX-floatY-fallback other-260 self-261)
  (if (py-test (py-ne self-261 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-bool-to-scheme-int other-260) (py-float-to-scheme self-261)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-boolX-boolY-fallback self-263 other-264)
  (if (py-test (py-ne other-264 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bool-to-scheme-int self-263)
             (py-bool-to-scheme-int other-264)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-boolX-sintY-fallback self-266 other-267)
  (if (py-test (py-ne other-267 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bool-to-scheme-int self-266) (py-sint-to-scheme other-267)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-boolX-bintY-fallback self-269 other-270)
  (py-int-from-scheme
   (py// (py-bool-to-scheme-int self-269) (py-bint-to-scheme other-270))))

(define (py-floordiv-sintX-intY-fallback self-272 other-273)
  (if (py-test (py-ne other-273 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-sint-to-scheme self-272) (py-int-to-scheme other-273)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-sintX-floatY-fallback other-275 self-276)
  (if (py-test (py-ne self-276 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-sint-to-scheme other-275) (py-float-to-scheme self-276)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-sintX-boolY-fallback self-278 other-279)
  (if (py-test (py-ne other-279 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-sint-to-scheme self-278) (py-bool-to-scheme-int other-279)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-sintX-sintY-fallback self-281 other-282)
  (if (py-test (py-ne other-282 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-sint-to-scheme self-281) (py-sint-to-scheme other-282)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-sintX-bintY-fallback self-284 other-285)
  (py-int-from-scheme
   (py// (py-sint-to-scheme self-284) (py-bint-to-scheme other-285))))

(define (py-floordiv-bintX-intY-fallback self-287 other-288)
  (if (py-test (py-ne other-288 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bint-to-scheme self-287) (py-int-to-scheme other-288)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-bintX-floatY-fallback other-290 self-291)
  (if (py-test (py-ne self-291 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-bint-to-scheme other-290) (py-float-to-scheme self-291)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-bintX-boolY-fallback self-293 other-294)
  (if (py-test (py-ne other-294 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bint-to-scheme self-293) (py-bool-to-scheme-int other-294)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-bintX-sintY-fallback self-296 other-297)
  (if (py-test (py-ne other-297 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bint-to-scheme self-296) (py-sint-to-scheme other-297)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-bintX-bintY-fallback self-299 other-300)
  (py-int-from-scheme
   (py// (py-bint-to-scheme self-299) (py-bint-to-scheme other-300))))

(define (py-lshift-intX-intY-fallback self-302 other-303)
  (if (py-test (py-ge other-303 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-int-to-scheme self-302) (py-int-to-scheme other-303)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-intX-floatY-fallback self-305 other-306)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'int' and 'float'"))))

(define (py-lshift-intX-boolY-fallback self-308 other-309)
  (if (py-test (py-ge other-309 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-int-to-scheme self-308) (py-bool-to-scheme-int other-309)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-intX-sintY-fallback self-311 other-312)
  (if (py-test (py-ge other-312 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-int-to-scheme self-311) (py-sint-to-scheme other-312)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-intX-bintY-fallback self-314 other-315)
  (if (py-test (py-ge other-315 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-int-to-scheme self-314) (py-bint-to-scheme other-315)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-floatX-intY-fallback self-317 other-318)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'int'"))))

(define (py-lshift-floatX-floatY-fallback self-320 other-321)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'float'"))))

(define (py-lshift-floatX-boolY-fallback self-323 other-324)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'bool'"))))

(define (py-lshift-floatX-sintY-fallback self-326 other-327)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'int'"))))

(define (py-lshift-floatX-bintY-fallback self-329 other-330)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'int'"))))

(define (py-lshift-boolX-intY-fallback self-332 other-333)
  (if (py-test (py-ge other-333 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bool-to-scheme-int self-332) (py-int-to-scheme other-333)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-boolX-floatY-fallback self-335 other-336)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'bool' and 'float'"))))

(define (py-lshift-boolX-boolY-fallback self-338 other-339)
  (if (py-test (py-ge other-339 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bool-to-scheme-int self-338)
             (py-bool-to-scheme-int other-339)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-boolX-sintY-fallback self-341 other-342)
  (if (py-test (py-ge other-342 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bool-to-scheme-int self-341) (py-sint-to-scheme other-342)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-boolX-bintY-fallback self-344 other-345)
  (if (py-test (py-ge other-345 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bool-to-scheme-int self-344) (py-bint-to-scheme other-345)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-sintX-intY-fallback self-347 other-348)
  (if (py-test (py-ge other-348 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-sint-to-scheme self-347) (py-int-to-scheme other-348)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-sintX-floatY-fallback self-350 other-351)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'int' and 'float'"))))

(define (py-lshift-sintX-boolY-fallback self-353 other-354)
  (if (py-test (py-ge other-354 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-sint-to-scheme self-353) (py-bool-to-scheme-int other-354)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-sintX-sintY-fallback self-356 other-357)
  (if (py-test (py-ge other-357 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-sint-to-scheme self-356) (py-sint-to-scheme other-357)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-sintX-bintY-fallback self-359 other-360)
  (if (py-test (py-ge other-360 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-sint-to-scheme self-359) (py-bint-to-scheme other-360)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-bintX-intY-fallback self-362 other-363)
  (if (py-test (py-ge other-363 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bint-to-scheme self-362) (py-int-to-scheme other-363)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-bintX-floatY-fallback self-365 other-366)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'int' and 'float'"))))

(define (py-lshift-bintX-boolY-fallback self-368 other-369)
  (if (py-test (py-ge other-369 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bint-to-scheme self-368) (py-bool-to-scheme-int other-369)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-bintX-sintY-fallback self-371 other-372)
  (if (py-test (py-ge other-372 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bint-to-scheme self-371) (py-sint-to-scheme other-372)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-bintX-bintY-fallback self-374 other-375)
  (if (py-test (py-ge other-375 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bint-to-scheme self-374) (py-bint-to-scheme other-375)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-matmul-intX-intY-fallback self-377 other-378)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-matmul-intX-floatY-fallback self-380 other-381)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'float'"))))

(define (py-matmul-intX-boolY-fallback self-383 other-384)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'bool'"))))

(define (py-matmul-intX-sintY-fallback self-386 other-387)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-matmul-intX-bintY-fallback self-389 other-390)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-matmul-floatX-intY-fallback self-392 other-393)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'int'"))))

(define (py-matmul-floatX-floatY-fallback self-395 other-396)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'float'"))))

(define (py-matmul-floatX-boolY-fallback self-398 other-399)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'bool'"))))

(define (py-matmul-floatX-sintY-fallback self-401 other-402)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'int'"))))

(define (py-matmul-floatX-bintY-fallback self-404 other-405)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'int'"))))

(define (py-matmul-boolX-intY-fallback self-407 other-408)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'int'"))))

(define (py-matmul-boolX-floatY-fallback self-410 other-411)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'float'"))))

(define (py-matmul-boolX-boolY-fallback self-413 other-414)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'bool'"))))

(define (py-matmul-boolX-sintY-fallback self-416 other-417)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'int'"))))

(define (py-matmul-boolX-bintY-fallback self-419 other-420)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'int'"))))

(define (py-matmul-sintX-intY-fallback self-422 other-423)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-matmul-sintX-floatY-fallback self-425 other-426)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'float'"))))

(define (py-matmul-sintX-boolY-fallback self-428 other-429)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'bool'"))))

(define (py-matmul-sintX-sintY-fallback self-431 other-432)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-matmul-sintX-bintY-fallback self-434 other-435)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-matmul-bintX-intY-fallback self-437 other-438)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-matmul-bintX-floatY-fallback self-440 other-441)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'float'"))))

(define (py-matmul-bintX-boolY-fallback self-443 other-444)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'bool'"))))

(define (py-matmul-bintX-sintY-fallback self-446 other-447)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-matmul-bintX-bintY-fallback self-449 other-450)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-mod-intX-intY-fallback self-452 other-453)
  (if (py-test (py-ne other-453 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-int-to-scheme self-452) (py-int-to-scheme other-453)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-intX-floatY-fallback other-455 self-456)
  (if (py-test (py-ne self-456 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-int-to-scheme other-455) (py-float-to-scheme self-456)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-intX-boolY-fallback self-458 other-459)
  (if (py-test (py-ne other-459 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-int-to-scheme self-458) (py-bool-to-scheme-int other-459)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-intX-sintY-fallback self-461 other-462)
  (if (py-test (py-ne other-462 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-int-to-scheme self-461) (py-sint-to-scheme other-462)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-intX-bintY-fallback self-464 other-465)
  (py-int-from-scheme
   (py% (py-int-to-scheme self-464) (py-bint-to-scheme other-465))))

(define (py-mod-floatX-intY-fallback self-467 other-468)
  (if (py-test (py-ne other-468 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py% (py-float-to-scheme self-467) (py-int-to-scheme other-468)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-floatX-floatY-fallback self-470 other-471)
  (if (py-test (py-ne other-471 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-float-to-scheme self-470) (py-float-to-scheme other-471)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-floatX-boolY-fallback self-473 other-474)
  (if (py-test (py-ne other-474 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py% (py-float-to-scheme self-473) (py-bool-to-scheme-int other-474)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-floatX-sintY-fallback self-476 other-477)
  (if (py-test (py-ne other-477 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py% (py-float-to-scheme self-476) (py-sint-to-scheme other-477)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-floatX-bintY-fallback self-479 other-480)
  (py-float-from-scheme
   (py% (py-float-to-scheme self-479) (py-bint-to-scheme other-480))))

(define (py-mod-boolX-intY-fallback self-482 other-483)
  (if (py-test (py-ne other-483 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bool-to-scheme-int self-482) (py-int-to-scheme other-483)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-boolX-floatY-fallback other-485 self-486)
  (if (py-test (py-ne self-486 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-bool-to-scheme-int other-485) (py-float-to-scheme self-486)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-boolX-boolY-fallback self-488 other-489)
  (if (py-test (py-ne other-489 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bool-to-scheme-int self-488)
            (py-bool-to-scheme-int other-489)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-boolX-sintY-fallback self-491 other-492)
  (if (py-test (py-ne other-492 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bool-to-scheme-int self-491) (py-sint-to-scheme other-492)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-boolX-bintY-fallback self-494 other-495)
  (py-int-from-scheme
   (py% (py-bool-to-scheme-int self-494) (py-bint-to-scheme other-495))))

(define (py-mod-sintX-intY-fallback self-497 other-498)
  (if (py-test (py-ne other-498 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-sint-to-scheme self-497) (py-int-to-scheme other-498)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-sintX-floatY-fallback other-500 self-501)
  (if (py-test (py-ne self-501 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-sint-to-scheme other-500) (py-float-to-scheme self-501)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-sintX-boolY-fallback self-503 other-504)
  (if (py-test (py-ne other-504 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-sint-to-scheme self-503) (py-bool-to-scheme-int other-504)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-sintX-sintY-fallback self-506 other-507)
  (if (py-test (py-ne other-507 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-sint-to-scheme self-506) (py-sint-to-scheme other-507)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-sintX-bintY-fallback self-509 other-510)
  (py-int-from-scheme
   (py% (py-sint-to-scheme self-509) (py-bint-to-scheme other-510))))

(define (py-mod-bintX-intY-fallback self-512 other-513)
  (if (py-test (py-ne other-513 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bint-to-scheme self-512) (py-int-to-scheme other-513)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-bintX-floatY-fallback other-515 self-516)
  (if (py-test (py-ne self-516 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-bint-to-scheme other-515) (py-float-to-scheme self-516)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-bintX-boolY-fallback self-518 other-519)
  (if (py-test (py-ne other-519 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bint-to-scheme self-518) (py-bool-to-scheme-int other-519)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-bintX-sintY-fallback self-521 other-522)
  (if (py-test (py-ne other-522 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bint-to-scheme self-521) (py-sint-to-scheme other-522)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-bintX-bintY-fallback self-524 other-525)
  (py-int-from-scheme
   (py% (py-bint-to-scheme self-524) (py-bint-to-scheme other-525))))

(define (py-mul-intX-intY-fallback self-527 other-528)
  (py-int-from-scheme
   (py* (py-int-to-scheme self-527) (py-int-to-scheme other-528))))

(define (py-mul-intX-floatY-fallback other-530 self-531)
  (py-float-from-scheme
   (py* (py-int-to-scheme other-530) (py-float-to-scheme self-531))))

(define (py-mul-intX-boolY-fallback self-533 other-534)
  (py-int-from-scheme
   (py* (py-int-to-scheme self-533) (py-bool-to-scheme-int other-534))))

(define (py-mul-intX-sintY-fallback self-536 other-537)
  (py-int-from-scheme
   (py* (py-int-to-scheme self-536) (py-sint-to-scheme other-537))))

(define (py-mul-intX-bintY-fallback self-539 other-540)
  (py-int-from-scheme
   (py* (py-int-to-scheme self-539) (py-bint-to-scheme other-540))))

(define (py-mul-floatX-intY-fallback self-542 other-543)
  (py-float-from-scheme
   (py* (py-float-to-scheme self-542) (py-int-to-scheme other-543))))

(define (py-mul-floatX-floatY-fallback self-545 other-546)
  (py-float-from-scheme
   (py* (py-float-to-scheme self-545) (py-float-to-scheme other-546))))

(define (py-mul-floatX-boolY-fallback self-548 other-549)
  (py-float-from-scheme
   (py* (py-float-to-scheme self-548) (py-bool-to-scheme-int other-549))))

(define (py-mul-floatX-sintY-fallback self-551 other-552)
  (py-float-from-scheme
   (py* (py-float-to-scheme self-551) (py-sint-to-scheme other-552))))

(define (py-mul-floatX-bintY-fallback self-554 other-555)
  (py-float-from-scheme
   (py* (py-float-to-scheme self-554) (py-bint-to-scheme other-555))))

(define (py-mul-boolX-intY-fallback self-557 other-558)
  (py-int-from-scheme
   (py* (py-bool-to-scheme-int self-557) (py-int-to-scheme other-558))))

(define (py-mul-boolX-floatY-fallback other-560 self-561)
  (py-float-from-scheme
   (py* (py-bool-to-scheme-int other-560) (py-float-to-scheme self-561))))

(define (py-mul-boolX-boolY-fallback self-563 other-564)
  (py-int-from-scheme
   (py* (py-bool-to-scheme-int self-563) (py-bool-to-scheme-int other-564))))

(define (py-mul-boolX-sintY-fallback self-566 other-567)
  (py-int-from-scheme
   (py* (py-bool-to-scheme-int self-566) (py-sint-to-scheme other-567))))

(define (py-mul-boolX-bintY-fallback self-569 other-570)
  (py-int-from-scheme
   (py* (py-bool-to-scheme-int self-569) (py-bint-to-scheme other-570))))

(define (py-mul-sintX-intY-fallback self-572 other-573)
  (py-int-from-scheme
   (py* (py-sint-to-scheme self-572) (py-int-to-scheme other-573))))

(define (py-mul-sintX-floatY-fallback other-575 self-576)
  (py-float-from-scheme
   (py* (py-sint-to-scheme other-575) (py-float-to-scheme self-576))))

(define (py-mul-sintX-boolY-fallback self-578 other-579)
  (py-int-from-scheme
   (py* (py-sint-to-scheme self-578) (py-bool-to-scheme-int other-579))))

(define (py-mul-sintX-sintY-fallback self-581 other-582)
  (py-int-from-scheme
   (py* (py-sint-to-scheme self-581) (py-sint-to-scheme other-582))))

(define (py-mul-sintX-bintY-fallback self-584 other-585)
  (py-int-from-scheme
   (py* (py-sint-to-scheme self-584) (py-bint-to-scheme other-585))))

(define (py-mul-bintX-intY-fallback self-587 other-588)
  (py-int-from-scheme
   (py* (py-bint-to-scheme self-587) (py-int-to-scheme other-588))))

(define (py-mul-bintX-floatY-fallback other-590 self-591)
  (py-float-from-scheme
   (py* (py-bint-to-scheme other-590) (py-float-to-scheme self-591))))

(define (py-mul-bintX-boolY-fallback self-593 other-594)
  (py-int-from-scheme
   (py* (py-bint-to-scheme self-593) (py-bool-to-scheme-int other-594))))

(define (py-mul-bintX-sintY-fallback self-596 other-597)
  (py-int-from-scheme
   (py* (py-bint-to-scheme self-596) (py-sint-to-scheme other-597))))

(define (py-mul-bintX-bintY-fallback self-599 other-600)
  (py-int-from-scheme
   (py* (py-bint-to-scheme self-599) (py-bint-to-scheme other-600))))

(define (py-pow-intX-intY-fallback self-602 other-603)
  (py-int-from-scheme
   (py** (py-int-to-scheme self-602) (py-int-to-scheme other-603))))

(define (py-pow-intX-floatY-fallback other-605 self-606)
  (py-float-from-scheme
   (py** (py-int-to-scheme other-605) (py-float-to-scheme self-606))))

(define (py-pow-intX-boolY-fallback self-608 other-609)
  (py-int-from-scheme
   (py** (py-int-to-scheme self-608) (py-bool-to-scheme-int other-609))))

(define (py-pow-intX-sintY-fallback self-611 other-612)
  (py-int-from-scheme
   (py** (py-int-to-scheme self-611) (py-sint-to-scheme other-612))))

(define (py-pow-intX-bintY-fallback self-614 other-615)
  (py-int-from-scheme
   (py** (py-int-to-scheme self-614) (py-bint-to-scheme other-615))))

(define (py-pow-floatX-intY-fallback self-617 other-618)
  (py-float-from-scheme
   (py** (py-float-to-scheme self-617) (py-int-to-scheme other-618))))

(define (py-pow-floatX-floatY-fallback self-620 other-621)
  (py-float-from-scheme
   (py** (py-float-to-scheme self-620) (py-float-to-scheme other-621))))

(define (py-pow-floatX-boolY-fallback self-623 other-624)
  (py-float-from-scheme
   (py** (py-float-to-scheme self-623) (py-bool-to-scheme-int other-624))))

(define (py-pow-floatX-sintY-fallback self-626 other-627)
  (py-float-from-scheme
   (py** (py-float-to-scheme self-626) (py-sint-to-scheme other-627))))

(define (py-pow-floatX-bintY-fallback self-629 other-630)
  (py-float-from-scheme
   (py** (py-float-to-scheme self-629) (py-bint-to-scheme other-630))))

(define (py-pow-boolX-intY-fallback self-632 other-633)
  (py-int-from-scheme
   (py** (py-bool-to-scheme-int self-632) (py-int-to-scheme other-633))))

(define (py-pow-boolX-floatY-fallback other-635 self-636)
  (py-float-from-scheme
   (py** (py-bool-to-scheme-int other-635) (py-float-to-scheme self-636))))

(define (py-pow-boolX-boolY-fallback self-638 other-639)
  (py-int-from-scheme
   (py** (py-bool-to-scheme-int self-638) (py-bool-to-scheme-int other-639))))

(define (py-pow-boolX-sintY-fallback self-641 other-642)
  (py-int-from-scheme
   (py** (py-bool-to-scheme-int self-641) (py-sint-to-scheme other-642))))

(define (py-pow-boolX-bintY-fallback self-644 other-645)
  (py-int-from-scheme
   (py** (py-bool-to-scheme-int self-644) (py-bint-to-scheme other-645))))

(define (py-pow-sintX-intY-fallback self-647 other-648)
  (py-int-from-scheme
   (py** (py-sint-to-scheme self-647) (py-int-to-scheme other-648))))

(define (py-pow-sintX-floatY-fallback other-650 self-651)
  (py-float-from-scheme
   (py** (py-sint-to-scheme other-650) (py-float-to-scheme self-651))))

(define (py-pow-sintX-boolY-fallback self-653 other-654)
  (py-int-from-scheme
   (py** (py-sint-to-scheme self-653) (py-bool-to-scheme-int other-654))))

(define (py-pow-sintX-sintY-fallback self-656 other-657)
  (py-int-from-scheme
   (py** (py-sint-to-scheme self-656) (py-sint-to-scheme other-657))))

(define (py-pow-sintX-bintY-fallback self-659 other-660)
  (py-int-from-scheme
   (py** (py-sint-to-scheme self-659) (py-bint-to-scheme other-660))))

(define (py-pow-bintX-intY-fallback self-662 other-663)
  (py-int-from-scheme
   (py** (py-bint-to-scheme self-662) (py-int-to-scheme other-663))))

(define (py-pow-bintX-floatY-fallback other-665 self-666)
  (py-float-from-scheme
   (py** (py-bint-to-scheme other-665) (py-float-to-scheme self-666))))

(define (py-pow-bintX-boolY-fallback self-668 other-669)
  (py-int-from-scheme
   (py** (py-bint-to-scheme self-668) (py-bool-to-scheme-int other-669))))

(define (py-pow-bintX-sintY-fallback self-671 other-672)
  (py-int-from-scheme
   (py** (py-bint-to-scheme self-671) (py-sint-to-scheme other-672))))

(define (py-pow-bintX-bintY-fallback self-674 other-675)
  (py-int-from-scheme
   (py** (py-bint-to-scheme self-674) (py-bint-to-scheme other-675))))

(define (py-rshift-intX-intY-fallback self-677 other-678)
  (if (py-test (py-ge other-678 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-int-to-scheme self-677) (py-int-to-scheme other-678)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-intX-floatY-fallback self-680 other-681)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'int' and 'float'"))))

(define (py-rshift-intX-boolY-fallback self-683 other-684)
  (if (py-test (py-ge other-684 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-int-to-scheme self-683) (py-bool-to-scheme-int other-684)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-intX-sintY-fallback self-686 other-687)
  (if (py-test (py-ge other-687 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-int-to-scheme self-686) (py-sint-to-scheme other-687)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-intX-bintY-fallback self-689 other-690)
  (if (py-test (py-ge other-690 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-int-to-scheme self-689) (py-bint-to-scheme other-690)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-floatX-intY-fallback self-692 other-693)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'int'"))))

(define (py-rshift-floatX-floatY-fallback self-695 other-696)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'float'"))))

(define (py-rshift-floatX-boolY-fallback self-698 other-699)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'bool'"))))

(define (py-rshift-floatX-sintY-fallback self-701 other-702)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'int'"))))

(define (py-rshift-floatX-bintY-fallback self-704 other-705)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'int'"))))

(define (py-rshift-boolX-intY-fallback self-707 other-708)
  (if (py-test (py-ge other-708 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bool-to-scheme-int self-707) (py-int-to-scheme other-708)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-boolX-floatY-fallback self-710 other-711)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'bool' and 'float'"))))

(define (py-rshift-boolX-boolY-fallback self-713 other-714)
  (if (py-test (py-ge other-714 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bool-to-scheme-int self-713)
             (py-bool-to-scheme-int other-714)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-boolX-sintY-fallback self-716 other-717)
  (if (py-test (py-ge other-717 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bool-to-scheme-int self-716) (py-sint-to-scheme other-717)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-boolX-bintY-fallback self-719 other-720)
  (if (py-test (py-ge other-720 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bool-to-scheme-int self-719) (py-bint-to-scheme other-720)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-sintX-intY-fallback self-722 other-723)
  (if (py-test (py-ge other-723 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-sint-to-scheme self-722) (py-int-to-scheme other-723)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-sintX-floatY-fallback self-725 other-726)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'int' and 'float'"))))

(define (py-rshift-sintX-boolY-fallback self-728 other-729)
  (if (py-test (py-ge other-729 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-sint-to-scheme self-728) (py-bool-to-scheme-int other-729)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-sintX-sintY-fallback self-731 other-732)
  (if (py-test (py-ge other-732 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-sint-to-scheme self-731) (py-sint-to-scheme other-732)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-sintX-bintY-fallback self-734 other-735)
  (if (py-test (py-ge other-735 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-sint-to-scheme self-734) (py-bint-to-scheme other-735)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-bintX-intY-fallback self-737 other-738)
  (if (py-test (py-ge other-738 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bint-to-scheme self-737) (py-int-to-scheme other-738)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-bintX-floatY-fallback self-740 other-741)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'int' and 'float'"))))

(define (py-rshift-bintX-boolY-fallback self-743 other-744)
  (if (py-test (py-ge other-744 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bint-to-scheme self-743) (py-bool-to-scheme-int other-744)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-bintX-sintY-fallback self-746 other-747)
  (if (py-test (py-ge other-747 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bint-to-scheme self-746) (py-sint-to-scheme other-747)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-bintX-bintY-fallback self-749 other-750)
  (if (py-test (py-ge other-750 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bint-to-scheme self-749) (py-bint-to-scheme other-750)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-sub-intX-intY-fallback self-752 other-753)
  (py-int-from-scheme
   (py- (py-int-to-scheme self-752) (py-int-to-scheme other-753))))

(define (py-sub-intX-floatY-fallback other-755 self-756)
  (py-float-from-scheme
   (py- (py-int-to-scheme other-755) (py-float-to-scheme self-756))))

(define (py-sub-intX-boolY-fallback self-758 other-759)
  (py-int-from-scheme
   (py- (py-int-to-scheme self-758) (py-bool-to-scheme-int other-759))))

(define (py-sub-intX-sintY-fallback self-761 other-762)
  (py-int-from-scheme
   (py- (py-int-to-scheme self-761) (py-sint-to-scheme other-762))))

(define (py-sub-intX-bintY-fallback self-764 other-765)
  (py-int-from-scheme
   (py- (py-int-to-scheme self-764) (py-bint-to-scheme other-765))))

(define (py-sub-floatX-intY-fallback self-767 other-768)
  (py-float-from-scheme
   (py- (py-float-to-scheme self-767) (py-int-to-scheme other-768))))

(define (py-sub-floatX-floatY-fallback self-770 other-771)
  (py-float-from-scheme
   (py- (py-float-to-scheme self-770) (py-float-to-scheme other-771))))

(define (py-sub-floatX-boolY-fallback self-773 other-774)
  (py-float-from-scheme
   (py- (py-float-to-scheme self-773) (py-bool-to-scheme-int other-774))))

(define (py-sub-floatX-sintY-fallback self-776 other-777)
  (py-float-from-scheme
   (py- (py-float-to-scheme self-776) (py-sint-to-scheme other-777))))

(define (py-sub-floatX-bintY-fallback self-779 other-780)
  (py-float-from-scheme
   (py- (py-float-to-scheme self-779) (py-bint-to-scheme other-780))))

(define (py-sub-boolX-intY-fallback self-782 other-783)
  (py-int-from-scheme
   (py- (py-bool-to-scheme-int self-782) (py-int-to-scheme other-783))))

(define (py-sub-boolX-floatY-fallback other-785 self-786)
  (py-float-from-scheme
   (py- (py-bool-to-scheme-int other-785) (py-float-to-scheme self-786))))

(define (py-sub-boolX-boolY-fallback self-788 other-789)
  (py-int-from-scheme
   (py- (py-bool-to-scheme-int self-788) (py-bool-to-scheme-int other-789))))

(define (py-sub-boolX-sintY-fallback self-791 other-792)
  (py-int-from-scheme
   (py- (py-bool-to-scheme-int self-791) (py-sint-to-scheme other-792))))

(define (py-sub-boolX-bintY-fallback self-794 other-795)
  (py-int-from-scheme
   (py- (py-bool-to-scheme-int self-794) (py-bint-to-scheme other-795))))

(define (py-sub-sintX-intY-fallback self-797 other-798)
  (py-int-from-scheme
   (py- (py-sint-to-scheme self-797) (py-int-to-scheme other-798))))

(define (py-sub-sintX-floatY-fallback other-800 self-801)
  (py-float-from-scheme
   (py- (py-sint-to-scheme other-800) (py-float-to-scheme self-801))))

(define (py-sub-sintX-boolY-fallback self-803 other-804)
  (py-int-from-scheme
   (py- (py-sint-to-scheme self-803) (py-bool-to-scheme-int other-804))))

(define (py-sub-sintX-sintY-fallback self-806 other-807)
  (py-int-from-scheme
   (py- (py-sint-to-scheme self-806) (py-sint-to-scheme other-807))))

(define (py-sub-sintX-bintY-fallback self-809 other-810)
  (py-int-from-scheme
   (py- (py-sint-to-scheme self-809) (py-bint-to-scheme other-810))))

(define (py-sub-bintX-intY-fallback self-812 other-813)
  (py-int-from-scheme
   (py- (py-bint-to-scheme self-812) (py-int-to-scheme other-813))))

(define (py-sub-bintX-floatY-fallback other-815 self-816)
  (py-float-from-scheme
   (py- (py-bint-to-scheme other-815) (py-float-to-scheme self-816))))

(define (py-sub-bintX-boolY-fallback self-818 other-819)
  (py-int-from-scheme
   (py- (py-bint-to-scheme self-818) (py-bool-to-scheme-int other-819))))

(define (py-sub-bintX-sintY-fallback self-821 other-822)
  (py-int-from-scheme
   (py- (py-bint-to-scheme self-821) (py-sint-to-scheme other-822))))

(define (py-sub-bintX-bintY-fallback self-824 other-825)
  (py-int-from-scheme
   (py- (py-bint-to-scheme self-824) (py-bint-to-scheme other-825))))

(define (py-truediv-intX-intY-fallback self-827 other-828)
  (if (py-test (py-ne other-828 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-int-to-scheme self-827) (py-int-to-scheme other-828)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-intX-floatY-fallback other-830 self-831)
  (if (py-test (py-ne self-831 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-int-to-scheme other-830) (py-float-to-scheme self-831)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-intX-boolY-fallback self-833 other-834)
  (if (py-test (py-ne other-834 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-int-to-scheme self-833) (py-bool-to-scheme-int other-834)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-intX-sintY-fallback self-836 other-837)
  (if (py-test (py-ne other-837 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-int-to-scheme self-836) (py-sint-to-scheme other-837)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-intX-bintY-fallback self-839 other-840)
  (py-float-from-scheme
   (py/ (py-int-to-scheme self-839) (py-bint-to-scheme other-840))))

(define (py-truediv-floatX-intY-fallback self-842 other-843)
  (if (py-test (py-ne other-843 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme self-842) (py-int-to-scheme other-843)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-floatX-floatY-fallback self-845 other-846)
  (if (py-test (py-ne other-846 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme self-845) (py-float-to-scheme other-846)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-floatX-boolY-fallback self-848 other-849)
  (if (py-test (py-ne other-849 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme self-848) (py-bool-to-scheme-int other-849)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-floatX-sintY-fallback self-851 other-852)
  (if (py-test (py-ne other-852 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme self-851) (py-sint-to-scheme other-852)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-floatX-bintY-fallback self-854 other-855)
  (py-float-from-scheme
   (py/ (py-float-to-scheme self-854) (py-bint-to-scheme other-855))))

(define (py-truediv-boolX-intY-fallback self-857 other-858)
  (if (py-test (py-ne other-858 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme-int self-857) (py-int-to-scheme other-858)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-boolX-floatY-fallback other-860 self-861)
  (if (py-test (py-ne self-861 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme-int other-860) (py-float-to-scheme self-861)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-boolX-boolY-fallback self-863 other-864)
  (if (py-test (py-ne other-864 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme-int self-863)
            (py-bool-to-scheme-int other-864)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-boolX-sintY-fallback self-866 other-867)
  (if (py-test (py-ne other-867 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme-int self-866) (py-sint-to-scheme other-867)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-boolX-bintY-fallback self-869 other-870)
  (py-float-from-scheme
   (py/ (py-bool-to-scheme-int self-869) (py-bint-to-scheme other-870))))

(define (py-truediv-sintX-intY-fallback self-872 other-873)
  (if (py-test (py-ne other-873 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme self-872) (py-int-to-scheme other-873)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-sintX-floatY-fallback other-875 self-876)
  (if (py-test (py-ne self-876 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme other-875) (py-float-to-scheme self-876)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-sintX-boolY-fallback self-878 other-879)
  (if (py-test (py-ne other-879 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme self-878) (py-bool-to-scheme-int other-879)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-sintX-sintY-fallback self-881 other-882)
  (if (py-test (py-ne other-882 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme self-881) (py-sint-to-scheme other-882)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-sintX-bintY-fallback self-884 other-885)
  (py-float-from-scheme
   (py/ (py-sint-to-scheme self-884) (py-bint-to-scheme other-885))))

(define (py-truediv-bintX-intY-fallback self-887 other-888)
  (if (py-test (py-ne other-888 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme self-887) (py-int-to-scheme other-888)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-bintX-floatY-fallback other-890 self-891)
  (if (py-test (py-ne self-891 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme other-890) (py-float-to-scheme self-891)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-bintX-boolY-fallback self-893 other-894)
  (if (py-test (py-ne other-894 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme self-893) (py-bool-to-scheme-int other-894)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-bintX-sintY-fallback self-896 other-897)
  (if (py-test (py-ne other-897 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme self-896) (py-sint-to-scheme other-897)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-bintX-bintY-fallback self-899 other-900)
  (py-float-from-scheme
   (py/ (py-bint-to-scheme self-899) (py-bint-to-scheme other-900))))

(define (py-xor-intX-intY-fallback self-902 other-903)
  (py-int-from-scheme
   (py^ (py-int-to-scheme self-902) (py-int-to-scheme other-903))))

(define (py-xor-intX-floatY-fallback self-905 other-906)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'int' and 'float'"))))

(define (py-xor-intX-boolY-fallback self-908 other-909)
  (py-int-from-scheme
   (py^ (py-int-to-scheme self-908) (py-bool-to-scheme-int other-909))))

(define (py-xor-intX-sintY-fallback self-911 other-912)
  (py-int-from-scheme
   (py^ (py-int-to-scheme self-911) (py-sint-to-scheme other-912))))

(define (py-xor-intX-bintY-fallback self-914 other-915)
  (py-int-from-scheme
   (py^ (py-int-to-scheme self-914) (py-bint-to-scheme other-915))))

(define (py-xor-floatX-intY-fallback self-917 other-918)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'int'"))))

(define (py-xor-floatX-floatY-fallback self-920 other-921)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'float'"))))

(define (py-xor-floatX-boolY-fallback self-923 other-924)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'bool'"))))

(define (py-xor-floatX-sintY-fallback self-926 other-927)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'int'"))))

(define (py-xor-floatX-bintY-fallback self-929 other-930)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'int'"))))

(define (py-xor-boolX-intY-fallback self-932 other-933)
  (py-int-from-scheme
   (py^ (py-bool-to-scheme-int self-932) (py-int-to-scheme other-933))))

(define (py-xor-boolX-floatY-fallback self-935 other-936)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'bool' and 'float'"))))

(define (py-xor-boolX-boolY-fallback self-938 other-939)
  (py-isnot self-938 other-939))

(define (py-xor-boolX-sintY-fallback self-941 other-942)
  (py-int-from-scheme
   (py^ (py-bool-to-scheme-int self-941) (py-sint-to-scheme other-942))))

(define (py-xor-boolX-bintY-fallback self-944 other-945)
  (py-int-from-scheme
   (py^ (py-bool-to-scheme-int self-944) (py-bint-to-scheme other-945))))

(define (py-xor-sintX-intY-fallback self-947 other-948)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme self-947) (py-int-to-scheme other-948))))

(define (py-xor-sintX-floatY-fallback self-950 other-951)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'int' and 'float'"))))

(define (py-xor-sintX-boolY-fallback self-953 other-954)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme self-953) (py-bool-to-scheme-int other-954))))

(define (py-xor-sintX-sintY-fallback self-956 other-957)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme self-956) (py-sint-to-scheme other-957))))

(define (py-xor-sintX-bintY-fallback self-959 other-960)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme self-959) (py-bint-to-scheme other-960))))

(define (py-xor-bintX-intY-fallback self-962 other-963)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme self-962) (py-int-to-scheme other-963))))

(define (py-xor-bintX-floatY-fallback self-965 other-966)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'int' and 'float'"))))

(define (py-xor-bintX-boolY-fallback self-968 other-969)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme self-968) (py-bool-to-scheme-int other-969))))

(define (py-xor-bintX-sintY-fallback self-971 other-972)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme self-971) (py-sint-to-scheme other-972))))

(define (py-xor-bintX-bintY-fallback self-974 other-975)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme self-974) (py-bint-to-scheme other-975))))

(define (py-iadd-intX-intY-fallback self-977 other-978)
  (py-int-from-scheme
   (py+ (py-int-to-scheme self-977) (py-int-to-scheme other-978))))

(define (py-iadd-intX-floatY-fallback other-980 self-981)
  (py-float-from-scheme
   (py+ (py-int-to-scheme other-980) (py-float-to-scheme self-981))))

(define (py-iadd-intX-boolY-fallback self-983 other-984)
  (py-int-from-scheme
   (py+ (py-int-to-scheme self-983) (py-bool-to-scheme-int other-984))))

(define (py-iadd-intX-sintY-fallback self-986 other-987)
  (py-int-from-scheme
   (py+ (py-int-to-scheme self-986) (py-sint-to-scheme other-987))))

(define (py-iadd-intX-bintY-fallback self-989 other-990)
  (py-int-from-scheme
   (py+ (py-int-to-scheme self-989) (py-bint-to-scheme other-990))))

(define (py-iadd-floatX-intY-fallback self-992 other-993)
  (py-float-from-scheme
   (py+ (py-float-to-scheme self-992) (py-int-to-scheme other-993))))

(define (py-iadd-floatX-floatY-fallback self-995 other-996)
  (py-float-from-scheme
   (py+ (py-float-to-scheme self-995) (py-float-to-scheme other-996))))

(define (py-iadd-floatX-boolY-fallback self-998 other-999)
  (py-float-from-scheme
   (py+ (py-float-to-scheme self-998) (py-bool-to-scheme-int other-999))))

(define (py-iadd-floatX-sintY-fallback self-1001 other-1002)
  (py-float-from-scheme
   (py+ (py-float-to-scheme self-1001) (py-sint-to-scheme other-1002))))

(define (py-iadd-floatX-bintY-fallback self-1004 other-1005)
  (py-float-from-scheme
   (py+ (py-float-to-scheme self-1004) (py-bint-to-scheme other-1005))))

(define (py-iadd-boolX-intY-fallback self-1007 other-1008)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme-int self-1007) (py-int-to-scheme other-1008))))

(define (py-iadd-boolX-floatY-fallback other-1010 self-1011)
  (py-float-from-scheme
   (py+ (py-bool-to-scheme-int other-1010) (py-float-to-scheme self-1011))))

(define (py-iadd-boolX-boolY-fallback self-1013 other-1014)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme-int self-1013) (py-bool-to-scheme-int other-1014))))

(define (py-iadd-boolX-sintY-fallback self-1016 other-1017)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme-int self-1016) (py-sint-to-scheme other-1017))))

(define (py-iadd-boolX-bintY-fallback self-1019 other-1020)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme-int self-1019) (py-bint-to-scheme other-1020))))

(define (py-iadd-sintX-intY-fallback self-1022 other-1023)
  (py-int-from-scheme
   (py+ (py-sint-to-scheme self-1022) (py-int-to-scheme other-1023))))

(define (py-iadd-sintX-floatY-fallback other-1025 self-1026)
  (py-float-from-scheme
   (py+ (py-sint-to-scheme other-1025) (py-float-to-scheme self-1026))))

(define (py-iadd-sintX-boolY-fallback self-1028 other-1029)
  (py-int-from-scheme
   (py+ (py-sint-to-scheme self-1028) (py-bool-to-scheme-int other-1029))))

(define (py-iadd-sintX-sintY-fallback self-1031 other-1032)
  (py-int-from-scheme
   (py+ (py-sint-to-scheme self-1031) (py-sint-to-scheme other-1032))))

(define (py-iadd-sintX-bintY-fallback self-1034 other-1035)
  (py-int-from-scheme
   (py+ (py-sint-to-scheme self-1034) (py-bint-to-scheme other-1035))))

(define (py-iadd-bintX-intY-fallback self-1037 other-1038)
  (py-int-from-scheme
   (py+ (py-bint-to-scheme self-1037) (py-int-to-scheme other-1038))))

(define (py-iadd-bintX-floatY-fallback other-1040 self-1041)
  (py-float-from-scheme
   (py+ (py-bint-to-scheme other-1040) (py-float-to-scheme self-1041))))

(define (py-iadd-bintX-boolY-fallback self-1043 other-1044)
  (py-int-from-scheme
   (py+ (py-bint-to-scheme self-1043) (py-bool-to-scheme-int other-1044))))

(define (py-iadd-bintX-sintY-fallback self-1046 other-1047)
  (py-int-from-scheme
   (py+ (py-bint-to-scheme self-1046) (py-sint-to-scheme other-1047))))

(define (py-iadd-bintX-bintY-fallback self-1049 other-1050)
  (py-int-from-scheme
   (py+ (py-bint-to-scheme self-1049) (py-bint-to-scheme other-1050))))

(define (py-ibitand-intX-intY-fallback self-1052 other-1053)
  (py-int-from-scheme
   (py& (py-int-to-scheme self-1052) (py-int-to-scheme other-1053))))

(define (py-ibitand-intX-floatY-fallback self-1055 other-1056)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'int' and 'float'"))))

(define (py-ibitand-intX-boolY-fallback self-1058 other-1059)
  (py-int-from-scheme
   (py& (py-int-to-scheme self-1058) (py-bool-to-scheme-int other-1059))))

(define (py-ibitand-intX-sintY-fallback self-1061 other-1062)
  (py-int-from-scheme
   (py& (py-int-to-scheme self-1061) (py-sint-to-scheme other-1062))))

(define (py-ibitand-intX-bintY-fallback self-1064 other-1065)
  (py-int-from-scheme
   (py& (py-int-to-scheme self-1064) (py-bint-to-scheme other-1065))))

(define (py-ibitand-floatX-intY-fallback self-1067 other-1068)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'float' and 'int'"))))

(define (py-ibitand-floatX-floatY-fallback self-1070 other-1071)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'float' and 'float'"))))

(define (py-ibitand-floatX-boolY-fallback self-1073 other-1074)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'float' and 'bool'"))))

(define (py-ibitand-floatX-sintY-fallback self-1076 other-1077)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'float' and 'int'"))))

(define (py-ibitand-floatX-bintY-fallback self-1079 other-1080)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'float' and 'int'"))))

(define (py-ibitand-boolX-intY-fallback self-1082 other-1083)
  (py-int-from-scheme
   (py& (py-bool-to-scheme-int self-1082) (py-int-to-scheme other-1083))))

(define (py-ibitand-boolX-floatY-fallback self-1085 other-1086)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'bool' and 'float'"))))

(define (py-ibitand-boolX-boolY-fallback self-1088 other-1089)
  (if (py-test (py-is self-1088 py-True)) other-1089 py-False))

(define (py-ibitand-boolX-sintY-fallback self-1091 other-1092)
  (py-int-from-scheme
   (py& (py-bool-to-scheme-int self-1091) (py-sint-to-scheme other-1092))))

(define (py-ibitand-boolX-bintY-fallback self-1094 other-1095)
  (py-int-from-scheme
   (py& (py-bool-to-scheme-int self-1094) (py-bint-to-scheme other-1095))))

(define (py-ibitand-sintX-intY-fallback self-1097 other-1098)
  (py-int-from-scheme
   (py& (py-sint-to-scheme self-1097) (py-int-to-scheme other-1098))))

(define (py-ibitand-sintX-floatY-fallback self-1100 other-1101)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'int' and 'float'"))))

(define (py-ibitand-sintX-boolY-fallback self-1103 other-1104)
  (py-int-from-scheme
   (py& (py-sint-to-scheme self-1103) (py-bool-to-scheme-int other-1104))))

(define (py-ibitand-sintX-sintY-fallback self-1106 other-1107)
  (py-int-from-scheme
   (py& (py-sint-to-scheme self-1106) (py-sint-to-scheme other-1107))))

(define (py-ibitand-sintX-bintY-fallback self-1109 other-1110)
  (py-int-from-scheme
   (py& (py-sint-to-scheme self-1109) (py-bint-to-scheme other-1110))))

(define (py-ibitand-bintX-intY-fallback self-1112 other-1113)
  (py-int-from-scheme
   (py& (py-bint-to-scheme self-1112) (py-int-to-scheme other-1113))))

(define (py-ibitand-bintX-floatY-fallback self-1115 other-1116)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'int' and 'float'"))))

(define (py-ibitand-bintX-boolY-fallback self-1118 other-1119)
  (py-int-from-scheme
   (py& (py-bint-to-scheme self-1118) (py-bool-to-scheme-int other-1119))))

(define (py-ibitand-bintX-sintY-fallback self-1121 other-1122)
  (py-int-from-scheme
   (py& (py-bint-to-scheme self-1121) (py-sint-to-scheme other-1122))))

(define (py-ibitand-bintX-bintY-fallback self-1124 other-1125)
  (py-int-from-scheme
   (py& (py-bint-to-scheme self-1124) (py-bint-to-scheme other-1125))))

(define (py-ibitor-intX-intY-fallback self-1127 other-1128)
  (py-int-from-scheme
   (py+b (py-int-to-scheme self-1127) (py-int-to-scheme other-1128))))

(define (py-ibitor-intX-floatY-fallback self-1130 other-1131)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'int' and 'float'"))))

(define (py-ibitor-intX-boolY-fallback self-1133 other-1134)
  (py-int-from-scheme
   (py+b (py-int-to-scheme self-1133) (py-bool-to-scheme-int other-1134))))

(define (py-ibitor-intX-sintY-fallback self-1136 other-1137)
  (py-int-from-scheme
   (py+b (py-int-to-scheme self-1136) (py-sint-to-scheme other-1137))))

(define (py-ibitor-intX-bintY-fallback self-1139 other-1140)
  (py-int-from-scheme
   (py+b (py-int-to-scheme self-1139) (py-bint-to-scheme other-1140))))

(define (py-ibitor-floatX-intY-fallback self-1142 other-1143)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'float' and 'int'"))))

(define (py-ibitor-floatX-floatY-fallback self-1145 other-1146)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'float' and 'float'"))))

(define (py-ibitor-floatX-boolY-fallback self-1148 other-1149)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'float' and 'bool'"))))

(define (py-ibitor-floatX-sintY-fallback self-1151 other-1152)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'float' and 'int'"))))

(define (py-ibitor-floatX-bintY-fallback self-1154 other-1155)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'float' and 'int'"))))

(define (py-ibitor-boolX-intY-fallback self-1157 other-1158)
  (py-int-from-scheme
   (py+b (py-bool-to-scheme-int self-1157) (py-int-to-scheme other-1158))))

(define (py-ibitor-boolX-floatY-fallback self-1160 other-1161)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'bool' and 'float'"))))

(define (py-ibitor-boolX-boolY-fallback self-1163 other-1164)
  (if (py-test (py-is self-1163 py-True)) py-True other-1164))

(define (py-ibitor-boolX-sintY-fallback self-1166 other-1167)
  (py-int-from-scheme
   (py+b (py-bool-to-scheme-int self-1166) (py-sint-to-scheme other-1167))))

(define (py-ibitor-boolX-bintY-fallback self-1169 other-1170)
  (py-int-from-scheme
   (py+b (py-bool-to-scheme-int self-1169) (py-bint-to-scheme other-1170))))

(define (py-ibitor-sintX-intY-fallback self-1172 other-1173)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme self-1172) (py-int-to-scheme other-1173))))

(define (py-ibitor-sintX-floatY-fallback self-1175 other-1176)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'int' and 'float'"))))

(define (py-ibitor-sintX-boolY-fallback self-1178 other-1179)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme self-1178) (py-bool-to-scheme-int other-1179))))

(define (py-ibitor-sintX-sintY-fallback self-1181 other-1182)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme self-1181) (py-sint-to-scheme other-1182))))

(define (py-ibitor-sintX-bintY-fallback self-1184 other-1185)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme self-1184) (py-bint-to-scheme other-1185))))

(define (py-ibitor-bintX-intY-fallback self-1187 other-1188)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme self-1187) (py-int-to-scheme other-1188))))

(define (py-ibitor-bintX-floatY-fallback self-1190 other-1191)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'int' and 'float'"))))

(define (py-ibitor-bintX-boolY-fallback self-1193 other-1194)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme self-1193) (py-bool-to-scheme-int other-1194))))

(define (py-ibitor-bintX-sintY-fallback self-1196 other-1197)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme self-1196) (py-sint-to-scheme other-1197))))

(define (py-ibitor-bintX-bintY-fallback self-1199 other-1200)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme self-1199) (py-bint-to-scheme other-1200))))

(define (py-ifloordiv-intX-intY-fallback self-1202 other-1203)
  (if (py-test (py-ne other-1203 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-int-to-scheme self-1202) (py-int-to-scheme other-1203)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-intX-floatY-fallback other-1205 self-1206)
  (if (py-test (py-ne self-1206 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-int-to-scheme other-1205) (py-float-to-scheme self-1206)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-intX-boolY-fallback self-1208 other-1209)
  (if (py-test (py-ne other-1209 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-int-to-scheme self-1208) (py-bool-to-scheme-int other-1209)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-intX-sintY-fallback self-1211 other-1212)
  (if (py-test (py-ne other-1212 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-int-to-scheme self-1211) (py-sint-to-scheme other-1212)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-intX-bintY-fallback self-1214 other-1215)
  (py-int-from-scheme
   (py// (py-int-to-scheme self-1214) (py-bint-to-scheme other-1215))))

(define (py-ifloordiv-floatX-intY-fallback self-1217 other-1218)
  (if (py-test (py-ne other-1218 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py// (py-float-to-scheme self-1217) (py-int-to-scheme other-1218)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-floatX-floatY-fallback self-1220 other-1221)
  (if (py-test (py-ne other-1221 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-float-to-scheme self-1220) (py-float-to-scheme other-1221)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-floatX-boolY-fallback self-1223 other-1224)
  (if (py-test (py-ne other-1224 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py// (py-float-to-scheme self-1223)
             (py-bool-to-scheme-int other-1224)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-floatX-sintY-fallback self-1226 other-1227)
  (if (py-test (py-ne other-1227 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py// (py-float-to-scheme self-1226) (py-sint-to-scheme other-1227)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-floatX-bintY-fallback self-1229 other-1230)
  (py-float-from-scheme
   (py// (py-float-to-scheme self-1229) (py-bint-to-scheme other-1230))))

(define (py-ifloordiv-boolX-intY-fallback self-1232 other-1233)
  (if (py-test (py-ne other-1233 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bool-to-scheme-int self-1232) (py-int-to-scheme other-1233)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-boolX-floatY-fallback other-1235 self-1236)
  (if (py-test (py-ne self-1236 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-bool-to-scheme-int other-1235)
             (py-float-to-scheme self-1236)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-boolX-boolY-fallback self-1238 other-1239)
  (if (py-test (py-ne other-1239 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bool-to-scheme-int self-1238)
             (py-bool-to-scheme-int other-1239)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-boolX-sintY-fallback self-1241 other-1242)
  (if (py-test (py-ne other-1242 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bool-to-scheme-int self-1241) (py-sint-to-scheme other-1242)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-boolX-bintY-fallback self-1244 other-1245)
  (py-int-from-scheme
   (py// (py-bool-to-scheme-int self-1244) (py-bint-to-scheme other-1245))))

(define (py-ifloordiv-sintX-intY-fallback self-1247 other-1248)
  (if (py-test (py-ne other-1248 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-sint-to-scheme self-1247) (py-int-to-scheme other-1248)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-sintX-floatY-fallback other-1250 self-1251)
  (if (py-test (py-ne self-1251 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-sint-to-scheme other-1250) (py-float-to-scheme self-1251)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-sintX-boolY-fallback self-1253 other-1254)
  (if (py-test (py-ne other-1254 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-sint-to-scheme self-1253) (py-bool-to-scheme-int other-1254)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-sintX-sintY-fallback self-1256 other-1257)
  (if (py-test (py-ne other-1257 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-sint-to-scheme self-1256) (py-sint-to-scheme other-1257)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-sintX-bintY-fallback self-1259 other-1260)
  (py-int-from-scheme
   (py// (py-sint-to-scheme self-1259) (py-bint-to-scheme other-1260))))

(define (py-ifloordiv-bintX-intY-fallback self-1262 other-1263)
  (if (py-test (py-ne other-1263 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bint-to-scheme self-1262) (py-int-to-scheme other-1263)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-bintX-floatY-fallback other-1265 self-1266)
  (if (py-test (py-ne self-1266 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py// (py-bint-to-scheme other-1265) (py-float-to-scheme self-1266)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-bintX-boolY-fallback self-1268 other-1269)
  (if (py-test (py-ne other-1269 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bint-to-scheme self-1268) (py-bool-to-scheme-int other-1269)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-bintX-sintY-fallback self-1271 other-1272)
  (if (py-test (py-ne other-1272 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py// (py-bint-to-scheme self-1271) (py-sint-to-scheme other-1272)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-bintX-bintY-fallback self-1274 other-1275)
  (py-int-from-scheme
   (py// (py-bint-to-scheme self-1274) (py-bint-to-scheme other-1275))))

(define (py-ilshift-intX-intY-fallback self-1277 other-1278)
  (if (py-test (py-ge other-1278 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-int-to-scheme self-1277) (py-int-to-scheme other-1278)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-intX-floatY-fallback self-1280 other-1281)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'int' and 'float'"))))

(define (py-ilshift-intX-boolY-fallback self-1283 other-1284)
  (if (py-test (py-ge other-1284 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-int-to-scheme self-1283) (py-bool-to-scheme-int other-1284)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-intX-sintY-fallback self-1286 other-1287)
  (if (py-test (py-ge other-1287 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-int-to-scheme self-1286) (py-sint-to-scheme other-1287)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-intX-bintY-fallback self-1289 other-1290)
  (if (py-test (py-ge other-1290 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-int-to-scheme self-1289) (py-bint-to-scheme other-1290)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-floatX-intY-fallback self-1292 other-1293)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'float' and 'int'"))))

(define (py-ilshift-floatX-floatY-fallback self-1295 other-1296)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'float' and 'float'"))))

(define (py-ilshift-floatX-boolY-fallback self-1298 other-1299)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'float' and 'bool'"))))

(define (py-ilshift-floatX-sintY-fallback self-1301 other-1302)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'float' and 'int'"))))

(define (py-ilshift-floatX-bintY-fallback self-1304 other-1305)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'float' and 'int'"))))

(define (py-ilshift-boolX-intY-fallback self-1307 other-1308)
  (if (py-test (py-ge other-1308 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bool-to-scheme-int self-1307) (py-int-to-scheme other-1308)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-boolX-floatY-fallback self-1310 other-1311)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'bool' and 'float'"))))

(define (py-ilshift-boolX-boolY-fallback self-1313 other-1314)
  (if (py-test (py-ge other-1314 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bool-to-scheme-int self-1313)
             (py-bool-to-scheme-int other-1314)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-boolX-sintY-fallback self-1316 other-1317)
  (if (py-test (py-ge other-1317 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bool-to-scheme-int self-1316) (py-sint-to-scheme other-1317)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-boolX-bintY-fallback self-1319 other-1320)
  (if (py-test (py-ge other-1320 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bool-to-scheme-int self-1319) (py-bint-to-scheme other-1320)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-sintX-intY-fallback self-1322 other-1323)
  (if (py-test (py-ge other-1323 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-sint-to-scheme self-1322) (py-int-to-scheme other-1323)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-sintX-floatY-fallback self-1325 other-1326)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'int' and 'float'"))))

(define (py-ilshift-sintX-boolY-fallback self-1328 other-1329)
  (if (py-test (py-ge other-1329 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-sint-to-scheme self-1328) (py-bool-to-scheme-int other-1329)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-sintX-sintY-fallback self-1331 other-1332)
  (if (py-test (py-ge other-1332 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-sint-to-scheme self-1331) (py-sint-to-scheme other-1332)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-sintX-bintY-fallback self-1334 other-1335)
  (if (py-test (py-ge other-1335 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-sint-to-scheme self-1334) (py-bint-to-scheme other-1335)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-bintX-intY-fallback self-1337 other-1338)
  (if (py-test (py-ge other-1338 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bint-to-scheme self-1337) (py-int-to-scheme other-1338)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-bintX-floatY-fallback self-1340 other-1341)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'int' and 'float'"))))

(define (py-ilshift-bintX-boolY-fallback self-1343 other-1344)
  (if (py-test (py-ge other-1344 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bint-to-scheme self-1343) (py-bool-to-scheme-int other-1344)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-bintX-sintY-fallback self-1346 other-1347)
  (if (py-test (py-ge other-1347 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bint-to-scheme self-1346) (py-sint-to-scheme other-1347)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-bintX-bintY-fallback self-1349 other-1350)
  (if (py-test (py-ge other-1350 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bint-to-scheme self-1349) (py-bint-to-scheme other-1350)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-imatmul-intX-intY-fallback self-1352 other-1353)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'int'"))))

(define (py-imatmul-intX-floatY-fallback self-1355 other-1356)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'float'"))))

(define (py-imatmul-intX-boolY-fallback self-1358 other-1359)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'bool'"))))

(define (py-imatmul-intX-sintY-fallback self-1361 other-1362)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'int'"))))

(define (py-imatmul-intX-bintY-fallback self-1364 other-1365)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'int'"))))

(define (py-imatmul-floatX-intY-fallback self-1367 other-1368)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'float' and 'int'"))))

(define (py-imatmul-floatX-floatY-fallback self-1370 other-1371)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'float' and 'float'"))))

(define (py-imatmul-floatX-boolY-fallback self-1373 other-1374)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'float' and 'bool'"))))

(define (py-imatmul-floatX-sintY-fallback self-1376 other-1377)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'float' and 'int'"))))

(define (py-imatmul-floatX-bintY-fallback self-1379 other-1380)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'float' and 'int'"))))

(define (py-imatmul-boolX-intY-fallback self-1382 other-1383)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'bool' and 'int'"))))

(define (py-imatmul-boolX-floatY-fallback self-1385 other-1386)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'bool' and 'float'"))))

(define (py-imatmul-boolX-boolY-fallback self-1388 other-1389)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'bool' and 'bool'"))))

(define (py-imatmul-boolX-sintY-fallback self-1391 other-1392)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'bool' and 'int'"))))

(define (py-imatmul-boolX-bintY-fallback self-1394 other-1395)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'bool' and 'int'"))))

(define (py-imatmul-sintX-intY-fallback self-1397 other-1398)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'int'"))))

(define (py-imatmul-sintX-floatY-fallback self-1400 other-1401)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'float'"))))

(define (py-imatmul-sintX-boolY-fallback self-1403 other-1404)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'bool'"))))

(define (py-imatmul-sintX-sintY-fallback self-1406 other-1407)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'int'"))))

(define (py-imatmul-sintX-bintY-fallback self-1409 other-1410)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'int'"))))

(define (py-imatmul-bintX-intY-fallback self-1412 other-1413)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'int'"))))

(define (py-imatmul-bintX-floatY-fallback self-1415 other-1416)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'float'"))))

(define (py-imatmul-bintX-boolY-fallback self-1418 other-1419)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'bool'"))))

(define (py-imatmul-bintX-sintY-fallback self-1421 other-1422)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'int'"))))

(define (py-imatmul-bintX-bintY-fallback self-1424 other-1425)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'int'"))))

(define (py-imod-intX-intY-fallback self-1427 other-1428)
  (if (py-test (py-ne other-1428 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-int-to-scheme self-1427) (py-int-to-scheme other-1428)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-intX-floatY-fallback other-1430 self-1431)
  (if (py-test (py-ne self-1431 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-int-to-scheme other-1430) (py-float-to-scheme self-1431)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-intX-boolY-fallback self-1433 other-1434)
  (if (py-test (py-ne other-1434 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-int-to-scheme self-1433) (py-bool-to-scheme-int other-1434)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-intX-sintY-fallback self-1436 other-1437)
  (if (py-test (py-ne other-1437 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-int-to-scheme self-1436) (py-sint-to-scheme other-1437)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-intX-bintY-fallback self-1439 other-1440)
  (py-int-from-scheme
   (py% (py-int-to-scheme self-1439) (py-bint-to-scheme other-1440))))

(define (py-imod-floatX-intY-fallback self-1442 other-1443)
  (if (py-test (py-ne other-1443 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py% (py-float-to-scheme self-1442) (py-int-to-scheme other-1443)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-floatX-floatY-fallback self-1445 other-1446)
  (if (py-test (py-ne other-1446 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-float-to-scheme self-1445) (py-float-to-scheme other-1446)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-floatX-boolY-fallback self-1448 other-1449)
  (if (py-test (py-ne other-1449 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py% (py-float-to-scheme self-1448) (py-bool-to-scheme-int other-1449)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-floatX-sintY-fallback self-1451 other-1452)
  (if (py-test (py-ne other-1452 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py% (py-float-to-scheme self-1451) (py-sint-to-scheme other-1452)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-floatX-bintY-fallback self-1454 other-1455)
  (py-float-from-scheme
   (py% (py-float-to-scheme self-1454) (py-bint-to-scheme other-1455))))

(define (py-imod-boolX-intY-fallback self-1457 other-1458)
  (if (py-test (py-ne other-1458 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bool-to-scheme-int self-1457) (py-int-to-scheme other-1458)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-boolX-floatY-fallback other-1460 self-1461)
  (if (py-test (py-ne self-1461 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-bool-to-scheme-int other-1460) (py-float-to-scheme self-1461)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-boolX-boolY-fallback self-1463 other-1464)
  (if (py-test (py-ne other-1464 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bool-to-scheme-int self-1463)
            (py-bool-to-scheme-int other-1464)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-boolX-sintY-fallback self-1466 other-1467)
  (if (py-test (py-ne other-1467 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bool-to-scheme-int self-1466) (py-sint-to-scheme other-1467)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-boolX-bintY-fallback self-1469 other-1470)
  (py-int-from-scheme
   (py% (py-bool-to-scheme-int self-1469) (py-bint-to-scheme other-1470))))

(define (py-imod-sintX-intY-fallback self-1472 other-1473)
  (if (py-test (py-ne other-1473 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-sint-to-scheme self-1472) (py-int-to-scheme other-1473)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-sintX-floatY-fallback other-1475 self-1476)
  (if (py-test (py-ne self-1476 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-sint-to-scheme other-1475) (py-float-to-scheme self-1476)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-sintX-boolY-fallback self-1478 other-1479)
  (if (py-test (py-ne other-1479 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-sint-to-scheme self-1478) (py-bool-to-scheme-int other-1479)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-sintX-sintY-fallback self-1481 other-1482)
  (if (py-test (py-ne other-1482 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-sint-to-scheme self-1481) (py-sint-to-scheme other-1482)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-sintX-bintY-fallback self-1484 other-1485)
  (py-int-from-scheme
   (py% (py-sint-to-scheme self-1484) (py-bint-to-scheme other-1485))))

(define (py-imod-bintX-intY-fallback self-1487 other-1488)
  (if (py-test (py-ne other-1488 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bint-to-scheme self-1487) (py-int-to-scheme other-1488)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-bintX-floatY-fallback other-1490 self-1491)
  (if (py-test (py-ne self-1491 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py% (py-bint-to-scheme other-1490) (py-float-to-scheme self-1491)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-bintX-boolY-fallback self-1493 other-1494)
  (if (py-test (py-ne other-1494 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bint-to-scheme self-1493) (py-bool-to-scheme-int other-1494)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-bintX-sintY-fallback self-1496 other-1497)
  (if (py-test (py-ne other-1497 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py% (py-bint-to-scheme self-1496) (py-sint-to-scheme other-1497)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-bintX-bintY-fallback self-1499 other-1500)
  (py-int-from-scheme
   (py% (py-bint-to-scheme self-1499) (py-bint-to-scheme other-1500))))

(define (py-imul-intX-intY-fallback self-1502 other-1503)
  (py-int-from-scheme
   (py* (py-int-to-scheme self-1502) (py-int-to-scheme other-1503))))

(define (py-imul-intX-floatY-fallback other-1505 self-1506)
  (py-float-from-scheme
   (py* (py-int-to-scheme other-1505) (py-float-to-scheme self-1506))))

(define (py-imul-intX-boolY-fallback self-1508 other-1509)
  (py-int-from-scheme
   (py* (py-int-to-scheme self-1508) (py-bool-to-scheme-int other-1509))))

(define (py-imul-intX-sintY-fallback self-1511 other-1512)
  (py-int-from-scheme
   (py* (py-int-to-scheme self-1511) (py-sint-to-scheme other-1512))))

(define (py-imul-intX-bintY-fallback self-1514 other-1515)
  (py-int-from-scheme
   (py* (py-int-to-scheme self-1514) (py-bint-to-scheme other-1515))))

(define (py-imul-floatX-intY-fallback self-1517 other-1518)
  (py-float-from-scheme
   (py* (py-float-to-scheme self-1517) (py-int-to-scheme other-1518))))

(define (py-imul-floatX-floatY-fallback self-1520 other-1521)
  (py-float-from-scheme
   (py* (py-float-to-scheme self-1520) (py-float-to-scheme other-1521))))

(define (py-imul-floatX-boolY-fallback self-1523 other-1524)
  (py-float-from-scheme
   (py* (py-float-to-scheme self-1523) (py-bool-to-scheme-int other-1524))))

(define (py-imul-floatX-sintY-fallback self-1526 other-1527)
  (py-float-from-scheme
   (py* (py-float-to-scheme self-1526) (py-sint-to-scheme other-1527))))

(define (py-imul-floatX-bintY-fallback self-1529 other-1530)
  (py-float-from-scheme
   (py* (py-float-to-scheme self-1529) (py-bint-to-scheme other-1530))))

(define (py-imul-boolX-intY-fallback self-1532 other-1533)
  (py-int-from-scheme
   (py* (py-bool-to-scheme-int self-1532) (py-int-to-scheme other-1533))))

(define (py-imul-boolX-floatY-fallback other-1535 self-1536)
  (py-float-from-scheme
   (py* (py-bool-to-scheme-int other-1535) (py-float-to-scheme self-1536))))

(define (py-imul-boolX-boolY-fallback self-1538 other-1539)
  (py-int-from-scheme
   (py* (py-bool-to-scheme-int self-1538) (py-bool-to-scheme-int other-1539))))

(define (py-imul-boolX-sintY-fallback self-1541 other-1542)
  (py-int-from-scheme
   (py* (py-bool-to-scheme-int self-1541) (py-sint-to-scheme other-1542))))

(define (py-imul-boolX-bintY-fallback self-1544 other-1545)
  (py-int-from-scheme
   (py* (py-bool-to-scheme-int self-1544) (py-bint-to-scheme other-1545))))

(define (py-imul-sintX-intY-fallback self-1547 other-1548)
  (py-int-from-scheme
   (py* (py-sint-to-scheme self-1547) (py-int-to-scheme other-1548))))

(define (py-imul-sintX-floatY-fallback other-1550 self-1551)
  (py-float-from-scheme
   (py* (py-sint-to-scheme other-1550) (py-float-to-scheme self-1551))))

(define (py-imul-sintX-boolY-fallback self-1553 other-1554)
  (py-int-from-scheme
   (py* (py-sint-to-scheme self-1553) (py-bool-to-scheme-int other-1554))))

(define (py-imul-sintX-sintY-fallback self-1556 other-1557)
  (py-int-from-scheme
   (py* (py-sint-to-scheme self-1556) (py-sint-to-scheme other-1557))))

(define (py-imul-sintX-bintY-fallback self-1559 other-1560)
  (py-int-from-scheme
   (py* (py-sint-to-scheme self-1559) (py-bint-to-scheme other-1560))))

(define (py-imul-bintX-intY-fallback self-1562 other-1563)
  (py-int-from-scheme
   (py* (py-bint-to-scheme self-1562) (py-int-to-scheme other-1563))))

(define (py-imul-bintX-floatY-fallback other-1565 self-1566)
  (py-float-from-scheme
   (py* (py-bint-to-scheme other-1565) (py-float-to-scheme self-1566))))

(define (py-imul-bintX-boolY-fallback self-1568 other-1569)
  (py-int-from-scheme
   (py* (py-bint-to-scheme self-1568) (py-bool-to-scheme-int other-1569))))

(define (py-imul-bintX-sintY-fallback self-1571 other-1572)
  (py-int-from-scheme
   (py* (py-bint-to-scheme self-1571) (py-sint-to-scheme other-1572))))

(define (py-imul-bintX-bintY-fallback self-1574 other-1575)
  (py-int-from-scheme
   (py* (py-bint-to-scheme self-1574) (py-bint-to-scheme other-1575))))

(define (py-ipow-intX-intY-fallback self-1577 other-1578)
  (py-int-from-scheme
   (py** (py-int-to-scheme self-1577) (py-int-to-scheme other-1578))))

(define (py-ipow-intX-floatY-fallback other-1580 self-1581)
  (py-float-from-scheme
   (py** (py-int-to-scheme other-1580) (py-float-to-scheme self-1581))))

(define (py-ipow-intX-boolY-fallback self-1583 other-1584)
  (py-int-from-scheme
   (py** (py-int-to-scheme self-1583) (py-bool-to-scheme-int other-1584))))

(define (py-ipow-intX-sintY-fallback self-1586 other-1587)
  (py-int-from-scheme
   (py** (py-int-to-scheme self-1586) (py-sint-to-scheme other-1587))))

(define (py-ipow-intX-bintY-fallback self-1589 other-1590)
  (py-int-from-scheme
   (py** (py-int-to-scheme self-1589) (py-bint-to-scheme other-1590))))

(define (py-ipow-floatX-intY-fallback self-1592 other-1593)
  (py-float-from-scheme
   (py** (py-float-to-scheme self-1592) (py-int-to-scheme other-1593))))

(define (py-ipow-floatX-floatY-fallback self-1595 other-1596)
  (py-float-from-scheme
   (py** (py-float-to-scheme self-1595) (py-float-to-scheme other-1596))))

(define (py-ipow-floatX-boolY-fallback self-1598 other-1599)
  (py-float-from-scheme
   (py** (py-float-to-scheme self-1598) (py-bool-to-scheme-int other-1599))))

(define (py-ipow-floatX-sintY-fallback self-1601 other-1602)
  (py-float-from-scheme
   (py** (py-float-to-scheme self-1601) (py-sint-to-scheme other-1602))))

(define (py-ipow-floatX-bintY-fallback self-1604 other-1605)
  (py-float-from-scheme
   (py** (py-float-to-scheme self-1604) (py-bint-to-scheme other-1605))))

(define (py-ipow-boolX-intY-fallback self-1607 other-1608)
  (py-int-from-scheme
   (py** (py-bool-to-scheme-int self-1607) (py-int-to-scheme other-1608))))

(define (py-ipow-boolX-floatY-fallback other-1610 self-1611)
  (py-float-from-scheme
   (py** (py-bool-to-scheme-int other-1610) (py-float-to-scheme self-1611))))

(define (py-ipow-boolX-boolY-fallback self-1613 other-1614)
  (py-int-from-scheme
   (py** (py-bool-to-scheme-int self-1613)
         (py-bool-to-scheme-int other-1614))))

(define (py-ipow-boolX-sintY-fallback self-1616 other-1617)
  (py-int-from-scheme
   (py** (py-bool-to-scheme-int self-1616) (py-sint-to-scheme other-1617))))

(define (py-ipow-boolX-bintY-fallback self-1619 other-1620)
  (py-int-from-scheme
   (py** (py-bool-to-scheme-int self-1619) (py-bint-to-scheme other-1620))))

(define (py-ipow-sintX-intY-fallback self-1622 other-1623)
  (py-int-from-scheme
   (py** (py-sint-to-scheme self-1622) (py-int-to-scheme other-1623))))

(define (py-ipow-sintX-floatY-fallback other-1625 self-1626)
  (py-float-from-scheme
   (py** (py-sint-to-scheme other-1625) (py-float-to-scheme self-1626))))

(define (py-ipow-sintX-boolY-fallback self-1628 other-1629)
  (py-int-from-scheme
   (py** (py-sint-to-scheme self-1628) (py-bool-to-scheme-int other-1629))))

(define (py-ipow-sintX-sintY-fallback self-1631 other-1632)
  (py-int-from-scheme
   (py** (py-sint-to-scheme self-1631) (py-sint-to-scheme other-1632))))

(define (py-ipow-sintX-bintY-fallback self-1634 other-1635)
  (py-int-from-scheme
   (py** (py-sint-to-scheme self-1634) (py-bint-to-scheme other-1635))))

(define (py-ipow-bintX-intY-fallback self-1637 other-1638)
  (py-int-from-scheme
   (py** (py-bint-to-scheme self-1637) (py-int-to-scheme other-1638))))

(define (py-ipow-bintX-floatY-fallback other-1640 self-1641)
  (py-float-from-scheme
   (py** (py-bint-to-scheme other-1640) (py-float-to-scheme self-1641))))

(define (py-ipow-bintX-boolY-fallback self-1643 other-1644)
  (py-int-from-scheme
   (py** (py-bint-to-scheme self-1643) (py-bool-to-scheme-int other-1644))))

(define (py-ipow-bintX-sintY-fallback self-1646 other-1647)
  (py-int-from-scheme
   (py** (py-bint-to-scheme self-1646) (py-sint-to-scheme other-1647))))

(define (py-ipow-bintX-bintY-fallback self-1649 other-1650)
  (py-int-from-scheme
   (py** (py-bint-to-scheme self-1649) (py-bint-to-scheme other-1650))))

(define (py-irshift-intX-intY-fallback self-1652 other-1653)
  (if (py-test (py-ge other-1653 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-int-to-scheme self-1652) (py-int-to-scheme other-1653)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-intX-floatY-fallback self-1655 other-1656)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'int' and 'float'"))))

(define (py-irshift-intX-boolY-fallback self-1658 other-1659)
  (if (py-test (py-ge other-1659 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-int-to-scheme self-1658) (py-bool-to-scheme-int other-1659)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-intX-sintY-fallback self-1661 other-1662)
  (if (py-test (py-ge other-1662 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-int-to-scheme self-1661) (py-sint-to-scheme other-1662)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-intX-bintY-fallback self-1664 other-1665)
  (if (py-test (py-ge other-1665 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-int-to-scheme self-1664) (py-bint-to-scheme other-1665)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-floatX-intY-fallback self-1667 other-1668)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'float' and 'int'"))))

(define (py-irshift-floatX-floatY-fallback self-1670 other-1671)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'float' and 'float'"))))

(define (py-irshift-floatX-boolY-fallback self-1673 other-1674)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'float' and 'bool'"))))

(define (py-irshift-floatX-sintY-fallback self-1676 other-1677)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'float' and 'int'"))))

(define (py-irshift-floatX-bintY-fallback self-1679 other-1680)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'float' and 'int'"))))

(define (py-irshift-boolX-intY-fallback self-1682 other-1683)
  (if (py-test (py-ge other-1683 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bool-to-scheme-int self-1682) (py-int-to-scheme other-1683)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-boolX-floatY-fallback self-1685 other-1686)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'bool' and 'float'"))))

(define (py-irshift-boolX-boolY-fallback self-1688 other-1689)
  (if (py-test (py-ge other-1689 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bool-to-scheme-int self-1688)
             (py-bool-to-scheme-int other-1689)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-boolX-sintY-fallback self-1691 other-1692)
  (if (py-test (py-ge other-1692 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bool-to-scheme-int self-1691) (py-sint-to-scheme other-1692)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-boolX-bintY-fallback self-1694 other-1695)
  (if (py-test (py-ge other-1695 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bool-to-scheme-int self-1694) (py-bint-to-scheme other-1695)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-sintX-intY-fallback self-1697 other-1698)
  (if (py-test (py-ge other-1698 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-sint-to-scheme self-1697) (py-int-to-scheme other-1698)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-sintX-floatY-fallback self-1700 other-1701)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'int' and 'float'"))))

(define (py-irshift-sintX-boolY-fallback self-1703 other-1704)
  (if (py-test (py-ge other-1704 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-sint-to-scheme self-1703) (py-bool-to-scheme-int other-1704)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-sintX-sintY-fallback self-1706 other-1707)
  (if (py-test (py-ge other-1707 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-sint-to-scheme self-1706) (py-sint-to-scheme other-1707)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-sintX-bintY-fallback self-1709 other-1710)
  (if (py-test (py-ge other-1710 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-sint-to-scheme self-1709) (py-bint-to-scheme other-1710)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-bintX-intY-fallback self-1712 other-1713)
  (if (py-test (py-ge other-1713 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bint-to-scheme self-1712) (py-int-to-scheme other-1713)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-bintX-floatY-fallback self-1715 other-1716)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'int' and 'float'"))))

(define (py-irshift-bintX-boolY-fallback self-1718 other-1719)
  (if (py-test (py-ge other-1719 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bint-to-scheme self-1718) (py-bool-to-scheme-int other-1719)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-bintX-sintY-fallback self-1721 other-1722)
  (if (py-test (py-ge other-1722 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bint-to-scheme self-1721) (py-sint-to-scheme other-1722)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-bintX-bintY-fallback self-1724 other-1725)
  (if (py-test (py-ge other-1725 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bint-to-scheme self-1724) (py-bint-to-scheme other-1725)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-isub-intX-intY-fallback self-1727 other-1728)
  (py-int-from-scheme
   (py- (py-int-to-scheme self-1727) (py-int-to-scheme other-1728))))

(define (py-isub-intX-floatY-fallback other-1730 self-1731)
  (py-float-from-scheme
   (py- (py-int-to-scheme other-1730) (py-float-to-scheme self-1731))))

(define (py-isub-intX-boolY-fallback self-1733 other-1734)
  (py-int-from-scheme
   (py- (py-int-to-scheme self-1733) (py-bool-to-scheme-int other-1734))))

(define (py-isub-intX-sintY-fallback self-1736 other-1737)
  (py-int-from-scheme
   (py- (py-int-to-scheme self-1736) (py-sint-to-scheme other-1737))))

(define (py-isub-intX-bintY-fallback self-1739 other-1740)
  (py-int-from-scheme
   (py- (py-int-to-scheme self-1739) (py-bint-to-scheme other-1740))))

(define (py-isub-floatX-intY-fallback self-1742 other-1743)
  (py-float-from-scheme
   (py- (py-float-to-scheme self-1742) (py-int-to-scheme other-1743))))

(define (py-isub-floatX-floatY-fallback self-1745 other-1746)
  (py-float-from-scheme
   (py- (py-float-to-scheme self-1745) (py-float-to-scheme other-1746))))

(define (py-isub-floatX-boolY-fallback self-1748 other-1749)
  (py-float-from-scheme
   (py- (py-float-to-scheme self-1748) (py-bool-to-scheme-int other-1749))))

(define (py-isub-floatX-sintY-fallback self-1751 other-1752)
  (py-float-from-scheme
   (py- (py-float-to-scheme self-1751) (py-sint-to-scheme other-1752))))

(define (py-isub-floatX-bintY-fallback self-1754 other-1755)
  (py-float-from-scheme
   (py- (py-float-to-scheme self-1754) (py-bint-to-scheme other-1755))))

(define (py-isub-boolX-intY-fallback self-1757 other-1758)
  (py-int-from-scheme
   (py- (py-bool-to-scheme-int self-1757) (py-int-to-scheme other-1758))))

(define (py-isub-boolX-floatY-fallback other-1760 self-1761)
  (py-float-from-scheme
   (py- (py-bool-to-scheme-int other-1760) (py-float-to-scheme self-1761))))

(define (py-isub-boolX-boolY-fallback self-1763 other-1764)
  (py-int-from-scheme
   (py- (py-bool-to-scheme-int self-1763) (py-bool-to-scheme-int other-1764))))

(define (py-isub-boolX-sintY-fallback self-1766 other-1767)
  (py-int-from-scheme
   (py- (py-bool-to-scheme-int self-1766) (py-sint-to-scheme other-1767))))

(define (py-isub-boolX-bintY-fallback self-1769 other-1770)
  (py-int-from-scheme
   (py- (py-bool-to-scheme-int self-1769) (py-bint-to-scheme other-1770))))

(define (py-isub-sintX-intY-fallback self-1772 other-1773)
  (py-int-from-scheme
   (py- (py-sint-to-scheme self-1772) (py-int-to-scheme other-1773))))

(define (py-isub-sintX-floatY-fallback other-1775 self-1776)
  (py-float-from-scheme
   (py- (py-sint-to-scheme other-1775) (py-float-to-scheme self-1776))))

(define (py-isub-sintX-boolY-fallback self-1778 other-1779)
  (py-int-from-scheme
   (py- (py-sint-to-scheme self-1778) (py-bool-to-scheme-int other-1779))))

(define (py-isub-sintX-sintY-fallback self-1781 other-1782)
  (py-int-from-scheme
   (py- (py-sint-to-scheme self-1781) (py-sint-to-scheme other-1782))))

(define (py-isub-sintX-bintY-fallback self-1784 other-1785)
  (py-int-from-scheme
   (py- (py-sint-to-scheme self-1784) (py-bint-to-scheme other-1785))))

(define (py-isub-bintX-intY-fallback self-1787 other-1788)
  (py-int-from-scheme
   (py- (py-bint-to-scheme self-1787) (py-int-to-scheme other-1788))))

(define (py-isub-bintX-floatY-fallback other-1790 self-1791)
  (py-float-from-scheme
   (py- (py-bint-to-scheme other-1790) (py-float-to-scheme self-1791))))

(define (py-isub-bintX-boolY-fallback self-1793 other-1794)
  (py-int-from-scheme
   (py- (py-bint-to-scheme self-1793) (py-bool-to-scheme-int other-1794))))

(define (py-isub-bintX-sintY-fallback self-1796 other-1797)
  (py-int-from-scheme
   (py- (py-bint-to-scheme self-1796) (py-sint-to-scheme other-1797))))

(define (py-isub-bintX-bintY-fallback self-1799 other-1800)
  (py-int-from-scheme
   (py- (py-bint-to-scheme self-1799) (py-bint-to-scheme other-1800))))

(define (py-itruediv-intX-intY-fallback self-1802 other-1803)
  (if (py-test (py-ne other-1803 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-int-to-scheme self-1802) (py-int-to-scheme other-1803)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-intX-floatY-fallback other-1805 self-1806)
  (if (py-test (py-ne self-1806 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-int-to-scheme other-1805) (py-float-to-scheme self-1806)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-intX-boolY-fallback self-1808 other-1809)
  (if (py-test (py-ne other-1809 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-int-to-scheme self-1808) (py-bool-to-scheme-int other-1809)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-intX-sintY-fallback self-1811 other-1812)
  (if (py-test (py-ne other-1812 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-int-to-scheme self-1811) (py-sint-to-scheme other-1812)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-intX-bintY-fallback self-1814 other-1815)
  (py-float-from-scheme
   (py/ (py-int-to-scheme self-1814) (py-bint-to-scheme other-1815))))

(define (py-itruediv-floatX-intY-fallback self-1817 other-1818)
  (if (py-test (py-ne other-1818 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme self-1817) (py-int-to-scheme other-1818)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-floatX-floatY-fallback self-1820 other-1821)
  (if (py-test (py-ne other-1821 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme self-1820) (py-float-to-scheme other-1821)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-floatX-boolY-fallback self-1823 other-1824)
  (if (py-test (py-ne other-1824 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme self-1823) (py-bool-to-scheme-int other-1824)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-floatX-sintY-fallback self-1826 other-1827)
  (if (py-test (py-ne other-1827 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-float-to-scheme self-1826) (py-sint-to-scheme other-1827)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-floatX-bintY-fallback self-1829 other-1830)
  (py-float-from-scheme
   (py/ (py-float-to-scheme self-1829) (py-bint-to-scheme other-1830))))

(define (py-itruediv-boolX-intY-fallback self-1832 other-1833)
  (if (py-test (py-ne other-1833 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme-int self-1832) (py-int-to-scheme other-1833)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-boolX-floatY-fallback other-1835 self-1836)
  (if (py-test (py-ne self-1836 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme-int other-1835) (py-float-to-scheme self-1836)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-boolX-boolY-fallback self-1838 other-1839)
  (if (py-test (py-ne other-1839 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme-int self-1838)
            (py-bool-to-scheme-int other-1839)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-boolX-sintY-fallback self-1841 other-1842)
  (if (py-test (py-ne other-1842 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme-int self-1841) (py-sint-to-scheme other-1842)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-boolX-bintY-fallback self-1844 other-1845)
  (py-float-from-scheme
   (py/ (py-bool-to-scheme-int self-1844) (py-bint-to-scheme other-1845))))

(define (py-itruediv-sintX-intY-fallback self-1847 other-1848)
  (if (py-test (py-ne other-1848 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme self-1847) (py-int-to-scheme other-1848)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-sintX-floatY-fallback other-1850 self-1851)
  (if (py-test (py-ne self-1851 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme other-1850) (py-float-to-scheme self-1851)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-sintX-boolY-fallback self-1853 other-1854)
  (if (py-test (py-ne other-1854 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme self-1853) (py-bool-to-scheme-int other-1854)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-sintX-sintY-fallback self-1856 other-1857)
  (if (py-test (py-ne other-1857 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme self-1856) (py-sint-to-scheme other-1857)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-sintX-bintY-fallback self-1859 other-1860)
  (py-float-from-scheme
   (py/ (py-sint-to-scheme self-1859) (py-bint-to-scheme other-1860))))

(define (py-itruediv-bintX-intY-fallback self-1862 other-1863)
  (if (py-test (py-ne other-1863 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme self-1862) (py-int-to-scheme other-1863)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-bintX-floatY-fallback other-1865 self-1866)
  (if (py-test (py-ne self-1866 (py-float-from-scheme 0.)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme other-1865) (py-float-to-scheme self-1866)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-bintX-boolY-fallback self-1868 other-1869)
  (if (py-test (py-ne other-1869 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme self-1868) (py-bool-to-scheme-int other-1869)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-bintX-sintY-fallback self-1871 other-1872)
  (if (py-test (py-ne other-1872 (py-int-from-scheme 0)))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme self-1871) (py-sint-to-scheme other-1872)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-bintX-bintY-fallback self-1874 other-1875)
  (py-float-from-scheme
   (py/ (py-bint-to-scheme self-1874) (py-bint-to-scheme other-1875))))

(define (py-ixor-intX-intY-fallback self-1877 other-1878)
  (py-int-from-scheme
   (py^ (py-int-to-scheme self-1877) (py-int-to-scheme other-1878))))

(define (py-ixor-intX-floatY-fallback self-1880 other-1881)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'int' and 'float'"))))

(define (py-ixor-intX-boolY-fallback self-1883 other-1884)
  (py-int-from-scheme
   (py^ (py-int-to-scheme self-1883) (py-bool-to-scheme-int other-1884))))

(define (py-ixor-intX-sintY-fallback self-1886 other-1887)
  (py-int-from-scheme
   (py^ (py-int-to-scheme self-1886) (py-sint-to-scheme other-1887))))

(define (py-ixor-intX-bintY-fallback self-1889 other-1890)
  (py-int-from-scheme
   (py^ (py-int-to-scheme self-1889) (py-bint-to-scheme other-1890))))

(define (py-ixor-floatX-intY-fallback self-1892 other-1893)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'float' and 'int'"))))

(define (py-ixor-floatX-floatY-fallback self-1895 other-1896)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'float' and 'float'"))))

(define (py-ixor-floatX-boolY-fallback self-1898 other-1899)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'float' and 'bool'"))))

(define (py-ixor-floatX-sintY-fallback self-1901 other-1902)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'float' and 'int'"))))

(define (py-ixor-floatX-bintY-fallback self-1904 other-1905)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'float' and 'int'"))))

(define (py-ixor-boolX-intY-fallback self-1907 other-1908)
  (py-int-from-scheme
   (py^ (py-bool-to-scheme-int self-1907) (py-int-to-scheme other-1908))))

(define (py-ixor-boolX-floatY-fallback self-1910 other-1911)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'bool' and 'float'"))))

(define (py-ixor-boolX-boolY-fallback self-1913 other-1914)
  (py-isnot self-1913 other-1914))

(define (py-ixor-boolX-sintY-fallback self-1916 other-1917)
  (py-int-from-scheme
   (py^ (py-bool-to-scheme-int self-1916) (py-sint-to-scheme other-1917))))

(define (py-ixor-boolX-bintY-fallback self-1919 other-1920)
  (py-int-from-scheme
   (py^ (py-bool-to-scheme-int self-1919) (py-bint-to-scheme other-1920))))

(define (py-ixor-sintX-intY-fallback self-1922 other-1923)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme self-1922) (py-int-to-scheme other-1923))))

(define (py-ixor-sintX-floatY-fallback self-1925 other-1926)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'int' and 'float'"))))

(define (py-ixor-sintX-boolY-fallback self-1928 other-1929)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme self-1928) (py-bool-to-scheme-int other-1929))))

(define (py-ixor-sintX-sintY-fallback self-1931 other-1932)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme self-1931) (py-sint-to-scheme other-1932))))

(define (py-ixor-sintX-bintY-fallback self-1934 other-1935)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme self-1934) (py-bint-to-scheme other-1935))))

(define (py-ixor-bintX-intY-fallback self-1937 other-1938)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme self-1937) (py-int-to-scheme other-1938))))

(define (py-ixor-bintX-floatY-fallback self-1940 other-1941)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'int' and 'float'"))))

(define (py-ixor-bintX-boolY-fallback self-1943 other-1944)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme self-1943) (py-bool-to-scheme-int other-1944))))

(define (py-ixor-bintX-sintY-fallback self-1946 other-1947)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme self-1946) (py-sint-to-scheme other-1947))))

(define (py-ixor-bintX-bintY-fallback self-1949 other-1950)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme self-1949) (py-bint-to-scheme other-1950))))

(define (py-pos-intX-fallback self-1952) self-1952)

(define (py-pos-floatX-fallback self-1954) self-1954)

(define (py-pos-boolX-fallback self-1956) self-1956)

(define (py-pos-sintX-fallback self-1958) self-1958)

(define (py-pos-bintX-fallback self-1960) self-1960)

(define (py-neg-intX-fallback self-1962)
  (py-int-from-scheme (pyneg (py-int-to-scheme self-1962))))

(define (py-neg-floatX-fallback self-1964)
  (py-float-from-scheme (pyneg (py-float-to-scheme self-1964))))

(define (py-neg-boolX-fallback self-1966)
  (py-int-from-scheme (pyneg (py-bool-to-scheme-int self-1966))))

(define (py-neg-sintX-fallback self-1968)
  (py-int-from-scheme (pyneg (py-sint-to-scheme self-1968))))

(define (py-neg-bintX-fallback self-1970)
  (py-int-from-scheme (pyneg (py-bint-to-scheme self-1970))))

(define (py-invert-intX-fallback self-1972)
  (py-int-from-scheme (pyinvert (py-int-to-scheme self-1972))))

(define (py-invert-floatX-fallback self-1974)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "bad operand type for unary ~: 'float'"))))

(define (py-invert-boolX-fallback self-1976)
  (py-int-from-scheme (pyinvert (py-bool-to-scheme-int self-1976))))

(define (py-invert-sintX-fallback self-1978)
  (py-int-from-scheme (pyinvert (py-sint-to-scheme self-1978))))

(define (py-invert-bintX-fallback self-1980)
  (py-int-from-scheme (pyinvert (py-bint-to-scheme self-1980))))

(define (py-ge-intX-intY-fallback self-1982 other-1983)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-int-to-scheme self-1982) (py-int-to-scheme other-1983)))))

(define (py-test-ge-intX-intY-fallback self-1985 other-1986)
  (py-test-from-scheme
   (py>= (py-int-to-scheme self-1985) (py-int-to-scheme other-1986))))

(define (py-ge-intX-floatY-fallback other-1988 self-1989)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-float-to-scheme self-1989) (py-int-to-scheme other-1988)))))

(define (py-test-ge-intX-floatY-fallback other-1991 self-1992)
  (py-test-from-scheme
   (py<= (py-float-to-scheme self-1992) (py-int-to-scheme other-1991))))

(define (py-ge-intX-boolY-fallback self-1994 other-1995)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-int-to-scheme self-1994) (py-bool-to-scheme-int other-1995)))))

(define (py-test-ge-intX-boolY-fallback self-1997 other-1998)
  (py-test-from-scheme
   (py>= (py-int-to-scheme self-1997) (py-bool-to-scheme-int other-1998))))

(define (py-ge-intX-sintY-fallback self-2000 other-2001)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-int-to-scheme self-2000) (py-sint-to-scheme other-2001)))))

(define (py-test-ge-intX-sintY-fallback self-2003 other-2004)
  (py-test-from-scheme
   (py>= (py-int-to-scheme self-2003) (py-sint-to-scheme other-2004))))

(define (py-ge-intX-bintY-fallback self-2006 other-2007)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-int-to-scheme self-2006) (py-bint-to-scheme other-2007)))))

(define (py-test-ge-intX-bintY-fallback self-2009 other-2010)
  (py-test-from-scheme
   (py>= (py-int-to-scheme self-2009) (py-bint-to-scheme other-2010))))

(define (py-ge-floatX-intY-fallback self-2012 other-2013)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-float-to-scheme self-2012) (py-int-to-scheme other-2013)))))

(define (py-test-ge-floatX-intY-fallback self-2015 other-2016)
  (py-test-from-scheme
   (py>= (py-float-to-scheme self-2015) (py-int-to-scheme other-2016))))

(define (py-ge-floatX-floatY-fallback self-2018 other-2019)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-float-to-scheme self-2018) (py-float-to-scheme other-2019)))))

(define (py-test-ge-floatX-floatY-fallback self-2021 other-2022)
  (py-test-from-scheme
   (py>= (py-float-to-scheme self-2021) (py-float-to-scheme other-2022))))

(define (py-ge-floatX-boolY-fallback self-2024 other-2025)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-float-to-scheme self-2024) (py-bool-to-scheme-int other-2025)))))

(define (py-test-ge-floatX-boolY-fallback self-2027 other-2028)
  (py-test-from-scheme
   (py>= (py-float-to-scheme self-2027) (py-bool-to-scheme-int other-2028))))

(define (py-ge-floatX-sintY-fallback self-2030 other-2031)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-float-to-scheme self-2030) (py-sint-to-scheme other-2031)))))

(define (py-test-ge-floatX-sintY-fallback self-2033 other-2034)
  (py-test-from-scheme
   (py>= (py-float-to-scheme self-2033) (py-sint-to-scheme other-2034))))

(define (py-ge-floatX-bintY-fallback self-2036 other-2037)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-float-to-scheme self-2036) (py-bint-to-scheme other-2037)))))

(define (py-test-ge-floatX-bintY-fallback self-2039 other-2040)
  (py-test-from-scheme
   (py>= (py-float-to-scheme self-2039) (py-bint-to-scheme other-2040))))

(define (py-ge-boolX-intY-fallback self-2042 other-2043)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-bool-to-scheme-int self-2042) (py-int-to-scheme other-2043)))))

(define (py-test-ge-boolX-intY-fallback self-2045 other-2046)
  (py-test-from-scheme
   (py>= (py-bool-to-scheme-int self-2045) (py-int-to-scheme other-2046))))

(define (py-ge-boolX-floatY-fallback other-2048 self-2049)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-float-to-scheme self-2049) (py-bool-to-scheme-int other-2048)))))

(define (py-test-ge-boolX-floatY-fallback other-2051 self-2052)
  (py-test-from-scheme
   (py<= (py-float-to-scheme self-2052) (py-bool-to-scheme-int other-2051))))

(define (py-ge-boolX-boolY-fallback self-2054 other-2055)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-bool-to-scheme-int self-2054)
          (py-bool-to-scheme-int other-2055)))))

(define (py-test-ge-boolX-boolY-fallback self-2057 other-2058)
  (py-test-from-scheme
   (py>= (py-bool-to-scheme-int self-2057)
         (py-bool-to-scheme-int other-2058))))

(define (py-ge-boolX-sintY-fallback self-2060 other-2061)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-bool-to-scheme-int self-2060) (py-sint-to-scheme other-2061)))))

(define (py-test-ge-boolX-sintY-fallback self-2063 other-2064)
  (py-test-from-scheme
   (py>= (py-bool-to-scheme-int self-2063) (py-sint-to-scheme other-2064))))

(define (py-ge-boolX-bintY-fallback self-2066 other-2067)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-bool-to-scheme-int self-2066) (py-bint-to-scheme other-2067)))))

(define (py-test-ge-boolX-bintY-fallback self-2069 other-2070)
  (py-test-from-scheme
   (py>= (py-bool-to-scheme-int self-2069) (py-bint-to-scheme other-2070))))

(define (py-ge-sintX-intY-fallback self-2072 other-2073)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-sint-to-scheme self-2072) (py-int-to-scheme other-2073)))))

(define (py-test-ge-sintX-intY-fallback self-2075 other-2076)
  (py-test-from-scheme
   (py>= (py-sint-to-scheme self-2075) (py-int-to-scheme other-2076))))

(define (py-ge-sintX-floatY-fallback other-2078 self-2079)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-float-to-scheme self-2079) (py-sint-to-scheme other-2078)))))

(define (py-test-ge-sintX-floatY-fallback other-2081 self-2082)
  (py-test-from-scheme
   (py<= (py-float-to-scheme self-2082) (py-sint-to-scheme other-2081))))

(define (py-ge-sintX-boolY-fallback self-2084 other-2085)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-sint-to-scheme self-2084) (py-bool-to-scheme-int other-2085)))))

(define (py-test-ge-sintX-boolY-fallback self-2087 other-2088)
  (py-test-from-scheme
   (py>= (py-sint-to-scheme self-2087) (py-bool-to-scheme-int other-2088))))

(define (py-ge-sintX-sintY-fallback self-2090 other-2091)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-sint-to-scheme self-2090) (py-sint-to-scheme other-2091)))))

(define (py-test-ge-sintX-sintY-fallback self-2093 other-2094)
  (py-test-from-scheme
   (py>= (py-sint-to-scheme self-2093) (py-sint-to-scheme other-2094))))

(define (py-ge-sintX-bintY-fallback self-2096 other-2097)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-sint-to-scheme self-2096) (py-bint-to-scheme other-2097)))))

(define (py-test-ge-sintX-bintY-fallback self-2099 other-2100)
  (py-test-from-scheme
   (py>= (py-sint-to-scheme self-2099) (py-bint-to-scheme other-2100))))

(define (py-ge-bintX-intY-fallback self-2102 other-2103)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-bint-to-scheme self-2102) (py-int-to-scheme other-2103)))))

(define (py-test-ge-bintX-intY-fallback self-2105 other-2106)
  (py-test-from-scheme
   (py>= (py-bint-to-scheme self-2105) (py-int-to-scheme other-2106))))

(define (py-ge-bintX-floatY-fallback other-2108 self-2109)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-float-to-scheme self-2109) (py-bint-to-scheme other-2108)))))

(define (py-test-ge-bintX-floatY-fallback other-2111 self-2112)
  (py-test-from-scheme
   (py<= (py-float-to-scheme self-2112) (py-bint-to-scheme other-2111))))

(define (py-ge-bintX-boolY-fallback self-2114 other-2115)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-bint-to-scheme self-2114) (py-bool-to-scheme-int other-2115)))))

(define (py-test-ge-bintX-boolY-fallback self-2117 other-2118)
  (py-test-from-scheme
   (py>= (py-bint-to-scheme self-2117) (py-bool-to-scheme-int other-2118))))

(define (py-ge-bintX-sintY-fallback self-2120 other-2121)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-bint-to-scheme self-2120) (py-sint-to-scheme other-2121)))))

(define (py-test-ge-bintX-sintY-fallback self-2123 other-2124)
  (py-test-from-scheme
   (py>= (py-bint-to-scheme self-2123) (py-sint-to-scheme other-2124))))

(define (py-ge-bintX-bintY-fallback self-2126 other-2127)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-bint-to-scheme self-2126) (py-bint-to-scheme other-2127)))))

(define (py-test-ge-bintX-bintY-fallback self-2129 other-2130)
  (py-test-from-scheme
   (py>= (py-bint-to-scheme self-2129) (py-bint-to-scheme other-2130))))

(define (py-gt-intX-intY-fallback self-2132 other-2133)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-int-to-scheme self-2132) (py-int-to-scheme other-2133)))))

(define (py-test-gt-intX-intY-fallback self-2135 other-2136)
  (py-test-from-scheme
   (py> (py-int-to-scheme self-2135) (py-int-to-scheme other-2136))))

(define (py-gt-intX-floatY-fallback other-2138 self-2139)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-float-to-scheme self-2139) (py-int-to-scheme other-2138)))))

(define (py-test-gt-intX-floatY-fallback other-2141 self-2142)
  (py-test-from-scheme
   (py< (py-float-to-scheme self-2142) (py-int-to-scheme other-2141))))

(define (py-gt-intX-boolY-fallback self-2144 other-2145)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-int-to-scheme self-2144) (py-bool-to-scheme-int other-2145)))))

(define (py-test-gt-intX-boolY-fallback self-2147 other-2148)
  (py-test-from-scheme
   (py> (py-int-to-scheme self-2147) (py-bool-to-scheme-int other-2148))))

(define (py-gt-intX-sintY-fallback self-2150 other-2151)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-int-to-scheme self-2150) (py-sint-to-scheme other-2151)))))

(define (py-test-gt-intX-sintY-fallback self-2153 other-2154)
  (py-test-from-scheme
   (py> (py-int-to-scheme self-2153) (py-sint-to-scheme other-2154))))

(define (py-gt-intX-bintY-fallback self-2156 other-2157)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-int-to-scheme self-2156) (py-bint-to-scheme other-2157)))))

(define (py-test-gt-intX-bintY-fallback self-2159 other-2160)
  (py-test-from-scheme
   (py> (py-int-to-scheme self-2159) (py-bint-to-scheme other-2160))))

(define (py-gt-floatX-intY-fallback self-2162 other-2163)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-float-to-scheme self-2162) (py-int-to-scheme other-2163)))))

(define (py-test-gt-floatX-intY-fallback self-2165 other-2166)
  (py-test-from-scheme
   (py> (py-float-to-scheme self-2165) (py-int-to-scheme other-2166))))

(define (py-gt-floatX-floatY-fallback self-2168 other-2169)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-float-to-scheme self-2168) (py-float-to-scheme other-2169)))))

(define (py-test-gt-floatX-floatY-fallback self-2171 other-2172)
  (py-test-from-scheme
   (py> (py-float-to-scheme self-2171) (py-float-to-scheme other-2172))))

(define (py-gt-floatX-boolY-fallback self-2174 other-2175)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-float-to-scheme self-2174) (py-bool-to-scheme-int other-2175)))))

(define (py-test-gt-floatX-boolY-fallback self-2177 other-2178)
  (py-test-from-scheme
   (py> (py-float-to-scheme self-2177) (py-bool-to-scheme-int other-2178))))

(define (py-gt-floatX-sintY-fallback self-2180 other-2181)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-float-to-scheme self-2180) (py-sint-to-scheme other-2181)))))

(define (py-test-gt-floatX-sintY-fallback self-2183 other-2184)
  (py-test-from-scheme
   (py> (py-float-to-scheme self-2183) (py-sint-to-scheme other-2184))))

(define (py-gt-floatX-bintY-fallback self-2186 other-2187)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-float-to-scheme self-2186) (py-bint-to-scheme other-2187)))))

(define (py-test-gt-floatX-bintY-fallback self-2189 other-2190)
  (py-test-from-scheme
   (py> (py-float-to-scheme self-2189) (py-bint-to-scheme other-2190))))

(define (py-gt-boolX-intY-fallback self-2192 other-2193)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-bool-to-scheme-int self-2192) (py-int-to-scheme other-2193)))))

(define (py-test-gt-boolX-intY-fallback self-2195 other-2196)
  (py-test-from-scheme
   (py> (py-bool-to-scheme-int self-2195) (py-int-to-scheme other-2196))))

(define (py-gt-boolX-floatY-fallback other-2198 self-2199)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-float-to-scheme self-2199) (py-bool-to-scheme-int other-2198)))))

(define (py-test-gt-boolX-floatY-fallback other-2201 self-2202)
  (py-test-from-scheme
   (py< (py-float-to-scheme self-2202) (py-bool-to-scheme-int other-2201))))

(define (py-gt-boolX-boolY-fallback self-2204 other-2205)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-bool-to-scheme-int self-2204)
         (py-bool-to-scheme-int other-2205)))))

(define (py-test-gt-boolX-boolY-fallback self-2207 other-2208)
  (py-test-from-scheme
   (py> (py-bool-to-scheme-int self-2207) (py-bool-to-scheme-int other-2208))))

(define (py-gt-boolX-sintY-fallback self-2210 other-2211)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-bool-to-scheme-int self-2210) (py-sint-to-scheme other-2211)))))

(define (py-test-gt-boolX-sintY-fallback self-2213 other-2214)
  (py-test-from-scheme
   (py> (py-bool-to-scheme-int self-2213) (py-sint-to-scheme other-2214))))

(define (py-gt-boolX-bintY-fallback self-2216 other-2217)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-bool-to-scheme-int self-2216) (py-bint-to-scheme other-2217)))))

(define (py-test-gt-boolX-bintY-fallback self-2219 other-2220)
  (py-test-from-scheme
   (py> (py-bool-to-scheme-int self-2219) (py-bint-to-scheme other-2220))))

(define (py-gt-sintX-intY-fallback self-2222 other-2223)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-sint-to-scheme self-2222) (py-int-to-scheme other-2223)))))

(define (py-test-gt-sintX-intY-fallback self-2225 other-2226)
  (py-test-from-scheme
   (py> (py-sint-to-scheme self-2225) (py-int-to-scheme other-2226))))

(define (py-gt-sintX-floatY-fallback other-2228 self-2229)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-float-to-scheme self-2229) (py-sint-to-scheme other-2228)))))

(define (py-test-gt-sintX-floatY-fallback other-2231 self-2232)
  (py-test-from-scheme
   (py< (py-float-to-scheme self-2232) (py-sint-to-scheme other-2231))))

(define (py-gt-sintX-boolY-fallback self-2234 other-2235)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-sint-to-scheme self-2234) (py-bool-to-scheme-int other-2235)))))

(define (py-test-gt-sintX-boolY-fallback self-2237 other-2238)
  (py-test-from-scheme
   (py> (py-sint-to-scheme self-2237) (py-bool-to-scheme-int other-2238))))

(define (py-gt-sintX-sintY-fallback self-2240 other-2241)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-sint-to-scheme self-2240) (py-sint-to-scheme other-2241)))))

(define (py-test-gt-sintX-sintY-fallback self-2243 other-2244)
  (py-test-from-scheme
   (py> (py-sint-to-scheme self-2243) (py-sint-to-scheme other-2244))))

(define (py-gt-sintX-bintY-fallback self-2246 other-2247)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-sint-to-scheme self-2246) (py-bint-to-scheme other-2247)))))

(define (py-test-gt-sintX-bintY-fallback self-2249 other-2250)
  (py-test-from-scheme
   (py> (py-sint-to-scheme self-2249) (py-bint-to-scheme other-2250))))

(define (py-gt-bintX-intY-fallback self-2252 other-2253)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-bint-to-scheme self-2252) (py-int-to-scheme other-2253)))))

(define (py-test-gt-bintX-intY-fallback self-2255 other-2256)
  (py-test-from-scheme
   (py> (py-bint-to-scheme self-2255) (py-int-to-scheme other-2256))))

(define (py-gt-bintX-floatY-fallback other-2258 self-2259)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-float-to-scheme self-2259) (py-bint-to-scheme other-2258)))))

(define (py-test-gt-bintX-floatY-fallback other-2261 self-2262)
  (py-test-from-scheme
   (py< (py-float-to-scheme self-2262) (py-bint-to-scheme other-2261))))

(define (py-gt-bintX-boolY-fallback self-2264 other-2265)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-bint-to-scheme self-2264) (py-bool-to-scheme-int other-2265)))))

(define (py-test-gt-bintX-boolY-fallback self-2267 other-2268)
  (py-test-from-scheme
   (py> (py-bint-to-scheme self-2267) (py-bool-to-scheme-int other-2268))))

(define (py-gt-bintX-sintY-fallback self-2270 other-2271)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-bint-to-scheme self-2270) (py-sint-to-scheme other-2271)))))

(define (py-test-gt-bintX-sintY-fallback self-2273 other-2274)
  (py-test-from-scheme
   (py> (py-bint-to-scheme self-2273) (py-sint-to-scheme other-2274))))

(define (py-gt-bintX-bintY-fallback self-2276 other-2277)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-bint-to-scheme self-2276) (py-bint-to-scheme other-2277)))))

(define (py-test-gt-bintX-bintY-fallback self-2279 other-2280)
  (py-test-from-scheme
   (py> (py-bint-to-scheme self-2279) (py-bint-to-scheme other-2280))))

(define (py-le-intX-intY-fallback self-2282 other-2283)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-int-to-scheme self-2282) (py-int-to-scheme other-2283)))))

(define (py-test-le-intX-intY-fallback self-2285 other-2286)
  (py-test-from-scheme
   (py<= (py-int-to-scheme self-2285) (py-int-to-scheme other-2286))))

(define (py-le-intX-floatY-fallback other-2288 self-2289)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-float-to-scheme self-2289) (py-int-to-scheme other-2288)))))

(define (py-test-le-intX-floatY-fallback other-2291 self-2292)
  (py-test-from-scheme
   (py>= (py-float-to-scheme self-2292) (py-int-to-scheme other-2291))))

(define (py-le-intX-boolY-fallback self-2294 other-2295)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-int-to-scheme self-2294) (py-bool-to-scheme-int other-2295)))))

(define (py-test-le-intX-boolY-fallback self-2297 other-2298)
  (py-test-from-scheme
   (py<= (py-int-to-scheme self-2297) (py-bool-to-scheme-int other-2298))))

(define (py-le-intX-sintY-fallback self-2300 other-2301)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-int-to-scheme self-2300) (py-sint-to-scheme other-2301)))))

(define (py-test-le-intX-sintY-fallback self-2303 other-2304)
  (py-test-from-scheme
   (py<= (py-int-to-scheme self-2303) (py-sint-to-scheme other-2304))))

(define (py-le-intX-bintY-fallback self-2306 other-2307)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-int-to-scheme self-2306) (py-bint-to-scheme other-2307)))))

(define (py-test-le-intX-bintY-fallback self-2309 other-2310)
  (py-test-from-scheme
   (py<= (py-int-to-scheme self-2309) (py-bint-to-scheme other-2310))))

(define (py-le-floatX-intY-fallback self-2312 other-2313)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-float-to-scheme self-2312) (py-int-to-scheme other-2313)))))

(define (py-test-le-floatX-intY-fallback self-2315 other-2316)
  (py-test-from-scheme
   (py<= (py-float-to-scheme self-2315) (py-int-to-scheme other-2316))))

(define (py-le-floatX-floatY-fallback self-2318 other-2319)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-float-to-scheme self-2318) (py-float-to-scheme other-2319)))))

(define (py-test-le-floatX-floatY-fallback self-2321 other-2322)
  (py-test-from-scheme
   (py<= (py-float-to-scheme self-2321) (py-float-to-scheme other-2322))))

(define (py-le-floatX-boolY-fallback self-2324 other-2325)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-float-to-scheme self-2324) (py-bool-to-scheme-int other-2325)))))

(define (py-test-le-floatX-boolY-fallback self-2327 other-2328)
  (py-test-from-scheme
   (py<= (py-float-to-scheme self-2327) (py-bool-to-scheme-int other-2328))))

(define (py-le-floatX-sintY-fallback self-2330 other-2331)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-float-to-scheme self-2330) (py-sint-to-scheme other-2331)))))

(define (py-test-le-floatX-sintY-fallback self-2333 other-2334)
  (py-test-from-scheme
   (py<= (py-float-to-scheme self-2333) (py-sint-to-scheme other-2334))))

(define (py-le-floatX-bintY-fallback self-2336 other-2337)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-float-to-scheme self-2336) (py-bint-to-scheme other-2337)))))

(define (py-test-le-floatX-bintY-fallback self-2339 other-2340)
  (py-test-from-scheme
   (py<= (py-float-to-scheme self-2339) (py-bint-to-scheme other-2340))))

(define (py-le-boolX-intY-fallback self-2342 other-2343)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-bool-to-scheme-int self-2342) (py-int-to-scheme other-2343)))))

(define (py-test-le-boolX-intY-fallback self-2345 other-2346)
  (py-test-from-scheme
   (py<= (py-bool-to-scheme-int self-2345) (py-int-to-scheme other-2346))))

(define (py-le-boolX-floatY-fallback other-2348 self-2349)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-float-to-scheme self-2349) (py-bool-to-scheme-int other-2348)))))

(define (py-test-le-boolX-floatY-fallback other-2351 self-2352)
  (py-test-from-scheme
   (py>= (py-float-to-scheme self-2352) (py-bool-to-scheme-int other-2351))))

(define (py-le-boolX-boolY-fallback self-2354 other-2355)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-bool-to-scheme-int self-2354)
          (py-bool-to-scheme-int other-2355)))))

(define (py-test-le-boolX-boolY-fallback self-2357 other-2358)
  (py-test-from-scheme
   (py<= (py-bool-to-scheme-int self-2357)
         (py-bool-to-scheme-int other-2358))))

(define (py-le-boolX-sintY-fallback self-2360 other-2361)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-bool-to-scheme-int self-2360) (py-sint-to-scheme other-2361)))))

(define (py-test-le-boolX-sintY-fallback self-2363 other-2364)
  (py-test-from-scheme
   (py<= (py-bool-to-scheme-int self-2363) (py-sint-to-scheme other-2364))))

(define (py-le-boolX-bintY-fallback self-2366 other-2367)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-bool-to-scheme-int self-2366) (py-bint-to-scheme other-2367)))))

(define (py-test-le-boolX-bintY-fallback self-2369 other-2370)
  (py-test-from-scheme
   (py<= (py-bool-to-scheme-int self-2369) (py-bint-to-scheme other-2370))))

(define (py-le-sintX-intY-fallback self-2372 other-2373)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-sint-to-scheme self-2372) (py-int-to-scheme other-2373)))))

(define (py-test-le-sintX-intY-fallback self-2375 other-2376)
  (py-test-from-scheme
   (py<= (py-sint-to-scheme self-2375) (py-int-to-scheme other-2376))))

(define (py-le-sintX-floatY-fallback other-2378 self-2379)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-float-to-scheme self-2379) (py-sint-to-scheme other-2378)))))

(define (py-test-le-sintX-floatY-fallback other-2381 self-2382)
  (py-test-from-scheme
   (py>= (py-float-to-scheme self-2382) (py-sint-to-scheme other-2381))))

(define (py-le-sintX-boolY-fallback self-2384 other-2385)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-sint-to-scheme self-2384) (py-bool-to-scheme-int other-2385)))))

(define (py-test-le-sintX-boolY-fallback self-2387 other-2388)
  (py-test-from-scheme
   (py<= (py-sint-to-scheme self-2387) (py-bool-to-scheme-int other-2388))))

(define (py-le-sintX-sintY-fallback self-2390 other-2391)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-sint-to-scheme self-2390) (py-sint-to-scheme other-2391)))))

(define (py-test-le-sintX-sintY-fallback self-2393 other-2394)
  (py-test-from-scheme
   (py<= (py-sint-to-scheme self-2393) (py-sint-to-scheme other-2394))))

(define (py-le-sintX-bintY-fallback self-2396 other-2397)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-sint-to-scheme self-2396) (py-bint-to-scheme other-2397)))))

(define (py-test-le-sintX-bintY-fallback self-2399 other-2400)
  (py-test-from-scheme
   (py<= (py-sint-to-scheme self-2399) (py-bint-to-scheme other-2400))))

(define (py-le-bintX-intY-fallback self-2402 other-2403)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-bint-to-scheme self-2402) (py-int-to-scheme other-2403)))))

(define (py-test-le-bintX-intY-fallback self-2405 other-2406)
  (py-test-from-scheme
   (py<= (py-bint-to-scheme self-2405) (py-int-to-scheme other-2406))))

(define (py-le-bintX-floatY-fallback other-2408 self-2409)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-float-to-scheme self-2409) (py-bint-to-scheme other-2408)))))

(define (py-test-le-bintX-floatY-fallback other-2411 self-2412)
  (py-test-from-scheme
   (py>= (py-float-to-scheme self-2412) (py-bint-to-scheme other-2411))))

(define (py-le-bintX-boolY-fallback self-2414 other-2415)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-bint-to-scheme self-2414) (py-bool-to-scheme-int other-2415)))))

(define (py-test-le-bintX-boolY-fallback self-2417 other-2418)
  (py-test-from-scheme
   (py<= (py-bint-to-scheme self-2417) (py-bool-to-scheme-int other-2418))))

(define (py-le-bintX-sintY-fallback self-2420 other-2421)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-bint-to-scheme self-2420) (py-sint-to-scheme other-2421)))))

(define (py-test-le-bintX-sintY-fallback self-2423 other-2424)
  (py-test-from-scheme
   (py<= (py-bint-to-scheme self-2423) (py-sint-to-scheme other-2424))))

(define (py-le-bintX-bintY-fallback self-2426 other-2427)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-bint-to-scheme self-2426) (py-bint-to-scheme other-2427)))))

(define (py-test-le-bintX-bintY-fallback self-2429 other-2430)
  (py-test-from-scheme
   (py<= (py-bint-to-scheme self-2429) (py-bint-to-scheme other-2430))))

(define (py-lt-intX-intY-fallback self-2432 other-2433)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-int-to-scheme self-2432) (py-int-to-scheme other-2433)))))

(define (py-test-lt-intX-intY-fallback self-2435 other-2436)
  (py-test-from-scheme
   (py< (py-int-to-scheme self-2435) (py-int-to-scheme other-2436))))

(define (py-lt-intX-floatY-fallback other-2438 self-2439)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-float-to-scheme self-2439) (py-int-to-scheme other-2438)))))

(define (py-test-lt-intX-floatY-fallback other-2441 self-2442)
  (py-test-from-scheme
   (py> (py-float-to-scheme self-2442) (py-int-to-scheme other-2441))))

(define (py-lt-intX-boolY-fallback self-2444 other-2445)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-int-to-scheme self-2444) (py-bool-to-scheme-int other-2445)))))

(define (py-test-lt-intX-boolY-fallback self-2447 other-2448)
  (py-test-from-scheme
   (py< (py-int-to-scheme self-2447) (py-bool-to-scheme-int other-2448))))

(define (py-lt-intX-sintY-fallback self-2450 other-2451)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-int-to-scheme self-2450) (py-sint-to-scheme other-2451)))))

(define (py-test-lt-intX-sintY-fallback self-2453 other-2454)
  (py-test-from-scheme
   (py< (py-int-to-scheme self-2453) (py-sint-to-scheme other-2454))))

(define (py-lt-intX-bintY-fallback self-2456 other-2457)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-int-to-scheme self-2456) (py-bint-to-scheme other-2457)))))

(define (py-test-lt-intX-bintY-fallback self-2459 other-2460)
  (py-test-from-scheme
   (py< (py-int-to-scheme self-2459) (py-bint-to-scheme other-2460))))

(define (py-lt-floatX-intY-fallback self-2462 other-2463)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-float-to-scheme self-2462) (py-int-to-scheme other-2463)))))

(define (py-test-lt-floatX-intY-fallback self-2465 other-2466)
  (py-test-from-scheme
   (py< (py-float-to-scheme self-2465) (py-int-to-scheme other-2466))))

(define (py-lt-floatX-floatY-fallback self-2468 other-2469)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-float-to-scheme self-2468) (py-float-to-scheme other-2469)))))

(define (py-test-lt-floatX-floatY-fallback self-2471 other-2472)
  (py-test-from-scheme
   (py< (py-float-to-scheme self-2471) (py-float-to-scheme other-2472))))

(define (py-lt-floatX-boolY-fallback self-2474 other-2475)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-float-to-scheme self-2474) (py-bool-to-scheme-int other-2475)))))

(define (py-test-lt-floatX-boolY-fallback self-2477 other-2478)
  (py-test-from-scheme
   (py< (py-float-to-scheme self-2477) (py-bool-to-scheme-int other-2478))))

(define (py-lt-floatX-sintY-fallback self-2480 other-2481)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-float-to-scheme self-2480) (py-sint-to-scheme other-2481)))))

(define (py-test-lt-floatX-sintY-fallback self-2483 other-2484)
  (py-test-from-scheme
   (py< (py-float-to-scheme self-2483) (py-sint-to-scheme other-2484))))

(define (py-lt-floatX-bintY-fallback self-2486 other-2487)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-float-to-scheme self-2486) (py-bint-to-scheme other-2487)))))

(define (py-test-lt-floatX-bintY-fallback self-2489 other-2490)
  (py-test-from-scheme
   (py< (py-float-to-scheme self-2489) (py-bint-to-scheme other-2490))))

(define (py-lt-boolX-intY-fallback self-2492 other-2493)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-bool-to-scheme-int self-2492) (py-int-to-scheme other-2493)))))

(define (py-test-lt-boolX-intY-fallback self-2495 other-2496)
  (py-test-from-scheme
   (py< (py-bool-to-scheme-int self-2495) (py-int-to-scheme other-2496))))

(define (py-lt-boolX-floatY-fallback other-2498 self-2499)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-float-to-scheme self-2499) (py-bool-to-scheme-int other-2498)))))

(define (py-test-lt-boolX-floatY-fallback other-2501 self-2502)
  (py-test-from-scheme
   (py> (py-float-to-scheme self-2502) (py-bool-to-scheme-int other-2501))))

(define (py-lt-boolX-boolY-fallback self-2504 other-2505)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-bool-to-scheme-int self-2504)
         (py-bool-to-scheme-int other-2505)))))

(define (py-test-lt-boolX-boolY-fallback self-2507 other-2508)
  (py-test-from-scheme
   (py< (py-bool-to-scheme-int self-2507) (py-bool-to-scheme-int other-2508))))

(define (py-lt-boolX-sintY-fallback self-2510 other-2511)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-bool-to-scheme-int self-2510) (py-sint-to-scheme other-2511)))))

(define (py-test-lt-boolX-sintY-fallback self-2513 other-2514)
  (py-test-from-scheme
   (py< (py-bool-to-scheme-int self-2513) (py-sint-to-scheme other-2514))))

(define (py-lt-boolX-bintY-fallback self-2516 other-2517)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-bool-to-scheme-int self-2516) (py-bint-to-scheme other-2517)))))

(define (py-test-lt-boolX-bintY-fallback self-2519 other-2520)
  (py-test-from-scheme
   (py< (py-bool-to-scheme-int self-2519) (py-bint-to-scheme other-2520))))

(define (py-lt-sintX-intY-fallback self-2522 other-2523)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-sint-to-scheme self-2522) (py-int-to-scheme other-2523)))))

(define (py-test-lt-sintX-intY-fallback self-2525 other-2526)
  (py-test-from-scheme
   (py< (py-sint-to-scheme self-2525) (py-int-to-scheme other-2526))))

(define (py-lt-sintX-floatY-fallback other-2528 self-2529)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-float-to-scheme self-2529) (py-sint-to-scheme other-2528)))))

(define (py-test-lt-sintX-floatY-fallback other-2531 self-2532)
  (py-test-from-scheme
   (py> (py-float-to-scheme self-2532) (py-sint-to-scheme other-2531))))

(define (py-lt-sintX-boolY-fallback self-2534 other-2535)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-sint-to-scheme self-2534) (py-bool-to-scheme-int other-2535)))))

(define (py-test-lt-sintX-boolY-fallback self-2537 other-2538)
  (py-test-from-scheme
   (py< (py-sint-to-scheme self-2537) (py-bool-to-scheme-int other-2538))))

(define (py-lt-sintX-sintY-fallback self-2540 other-2541)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-sint-to-scheme self-2540) (py-sint-to-scheme other-2541)))))

(define (py-test-lt-sintX-sintY-fallback self-2543 other-2544)
  (py-test-from-scheme
   (py< (py-sint-to-scheme self-2543) (py-sint-to-scheme other-2544))))

(define (py-lt-sintX-bintY-fallback self-2546 other-2547)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-sint-to-scheme self-2546) (py-bint-to-scheme other-2547)))))

(define (py-test-lt-sintX-bintY-fallback self-2549 other-2550)
  (py-test-from-scheme
   (py< (py-sint-to-scheme self-2549) (py-bint-to-scheme other-2550))))

(define (py-lt-bintX-intY-fallback self-2552 other-2553)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-bint-to-scheme self-2552) (py-int-to-scheme other-2553)))))

(define (py-test-lt-bintX-intY-fallback self-2555 other-2556)
  (py-test-from-scheme
   (py< (py-bint-to-scheme self-2555) (py-int-to-scheme other-2556))))

(define (py-lt-bintX-floatY-fallback other-2558 self-2559)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-float-to-scheme self-2559) (py-bint-to-scheme other-2558)))))

(define (py-test-lt-bintX-floatY-fallback other-2561 self-2562)
  (py-test-from-scheme
   (py> (py-float-to-scheme self-2562) (py-bint-to-scheme other-2561))))

(define (py-lt-bintX-boolY-fallback self-2564 other-2565)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-bint-to-scheme self-2564) (py-bool-to-scheme-int other-2565)))))

(define (py-test-lt-bintX-boolY-fallback self-2567 other-2568)
  (py-test-from-scheme
   (py< (py-bint-to-scheme self-2567) (py-bool-to-scheme-int other-2568))))

(define (py-lt-bintX-sintY-fallback self-2570 other-2571)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-bint-to-scheme self-2570) (py-sint-to-scheme other-2571)))))

(define (py-test-lt-bintX-sintY-fallback self-2573 other-2574)
  (py-test-from-scheme
   (py< (py-bint-to-scheme self-2573) (py-sint-to-scheme other-2574))))

(define (py-lt-bintX-bintY-fallback self-2576 other-2577)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-bint-to-scheme self-2576) (py-bint-to-scheme other-2577)))))

(define (py-test-lt-bintX-bintY-fallback self-2579 other-2580)
  (py-test-from-scheme
   (py< (py-bint-to-scheme self-2579) (py-bint-to-scheme other-2580))))

(define (py-eq-intX-intY-fallback self-2582 other-2583)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-int-to-scheme self-2582) (py-int-to-scheme other-2583)))))

(define (py-test-eq-intX-intY-fallback self-2585 other-2586)
  (py-test-from-scheme
   (py== (py-int-to-scheme self-2585) (py-int-to-scheme other-2586))))

(define (py-eq-intX-floatY-fallback other-2588 self-2589)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-float-to-scheme self-2589) (py-int-to-scheme other-2588)))))

(define (py-test-eq-intX-floatY-fallback other-2591 self-2592)
  (py-test-from-scheme
   (py== (py-float-to-scheme self-2592) (py-int-to-scheme other-2591))))

(define (py-eq-intX-boolY-fallback self-2594 other-2595)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-int-to-scheme self-2594) (py-bool-to-scheme-int other-2595)))))

(define (py-test-eq-intX-boolY-fallback self-2597 other-2598)
  (py-test-from-scheme
   (py== (py-int-to-scheme self-2597) (py-bool-to-scheme-int other-2598))))

(define (py-eq-intX-sintY-fallback self-2600 other-2601)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-int-to-scheme self-2600) (py-sint-to-scheme other-2601)))))

(define (py-test-eq-intX-sintY-fallback self-2603 other-2604)
  (py-test-from-scheme
   (py== (py-int-to-scheme self-2603) (py-sint-to-scheme other-2604))))

(define (py-eq-intX-bintY-fallback self-2606 other-2607)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-int-to-scheme self-2606) (py-bint-to-scheme other-2607)))))

(define (py-test-eq-intX-bintY-fallback self-2609 other-2610)
  (py-test-from-scheme
   (py== (py-int-to-scheme self-2609) (py-bint-to-scheme other-2610))))

(define (py-eq-floatX-intY-fallback self-2612 other-2613)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-float-to-scheme self-2612) (py-int-to-scheme other-2613)))))

(define (py-test-eq-floatX-intY-fallback self-2615 other-2616)
  (py-test-from-scheme
   (py== (py-float-to-scheme self-2615) (py-int-to-scheme other-2616))))

(define (py-eq-floatX-floatY-fallback self-2618 other-2619)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-float-to-scheme self-2618) (py-float-to-scheme other-2619)))))

(define (py-test-eq-floatX-floatY-fallback self-2621 other-2622)
  (py-test-from-scheme
   (py== (py-float-to-scheme self-2621) (py-float-to-scheme other-2622))))

(define (py-eq-floatX-boolY-fallback self-2624 other-2625)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-float-to-scheme self-2624) (py-bool-to-scheme-int other-2625)))))

(define (py-test-eq-floatX-boolY-fallback self-2627 other-2628)
  (py-test-from-scheme
   (py== (py-float-to-scheme self-2627) (py-bool-to-scheme-int other-2628))))

(define (py-eq-floatX-sintY-fallback self-2630 other-2631)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-float-to-scheme self-2630) (py-sint-to-scheme other-2631)))))

(define (py-test-eq-floatX-sintY-fallback self-2633 other-2634)
  (py-test-from-scheme
   (py== (py-float-to-scheme self-2633) (py-sint-to-scheme other-2634))))

(define (py-eq-floatX-bintY-fallback self-2636 other-2637)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-float-to-scheme self-2636) (py-bint-to-scheme other-2637)))))

(define (py-test-eq-floatX-bintY-fallback self-2639 other-2640)
  (py-test-from-scheme
   (py== (py-float-to-scheme self-2639) (py-bint-to-scheme other-2640))))

(define (py-eq-boolX-intY-fallback self-2642 other-2643)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-bool-to-scheme-int self-2642) (py-int-to-scheme other-2643)))))

(define (py-test-eq-boolX-intY-fallback self-2645 other-2646)
  (py-test-from-scheme
   (py== (py-bool-to-scheme-int self-2645) (py-int-to-scheme other-2646))))

(define (py-eq-boolX-floatY-fallback other-2648 self-2649)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-float-to-scheme self-2649) (py-bool-to-scheme-int other-2648)))))

(define (py-test-eq-boolX-floatY-fallback other-2651 self-2652)
  (py-test-from-scheme
   (py== (py-float-to-scheme self-2652) (py-bool-to-scheme-int other-2651))))

(define (py-eq-boolX-boolY-fallback self-2654 other-2655)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-bool-to-scheme-int self-2654)
          (py-bool-to-scheme-int other-2655)))))

(define (py-test-eq-boolX-boolY-fallback self-2657 other-2658)
  (py-test-from-scheme
   (py== (py-bool-to-scheme-int self-2657)
         (py-bool-to-scheme-int other-2658))))

(define (py-eq-boolX-sintY-fallback self-2660 other-2661)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-bool-to-scheme-int self-2660) (py-sint-to-scheme other-2661)))))

(define (py-test-eq-boolX-sintY-fallback self-2663 other-2664)
  (py-test-from-scheme
   (py== (py-bool-to-scheme-int self-2663) (py-sint-to-scheme other-2664))))

(define (py-eq-boolX-bintY-fallback self-2666 other-2667)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-bool-to-scheme-int self-2666) (py-bint-to-scheme other-2667)))))

(define (py-test-eq-boolX-bintY-fallback self-2669 other-2670)
  (py-test-from-scheme
   (py== (py-bool-to-scheme-int self-2669) (py-bint-to-scheme other-2670))))

(define (py-eq-sintX-intY-fallback self-2672 other-2673)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-sint-to-scheme self-2672) (py-int-to-scheme other-2673)))))

(define (py-test-eq-sintX-intY-fallback self-2675 other-2676)
  (py-test-from-scheme
   (py== (py-sint-to-scheme self-2675) (py-int-to-scheme other-2676))))

(define (py-eq-sintX-floatY-fallback other-2678 self-2679)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-float-to-scheme self-2679) (py-sint-to-scheme other-2678)))))

(define (py-test-eq-sintX-floatY-fallback other-2681 self-2682)
  (py-test-from-scheme
   (py== (py-float-to-scheme self-2682) (py-sint-to-scheme other-2681))))

(define (py-eq-sintX-boolY-fallback self-2684 other-2685)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-sint-to-scheme self-2684) (py-bool-to-scheme-int other-2685)))))

(define (py-test-eq-sintX-boolY-fallback self-2687 other-2688)
  (py-test-from-scheme
   (py== (py-sint-to-scheme self-2687) (py-bool-to-scheme-int other-2688))))

(define (py-eq-sintX-sintY-fallback self-2690 other-2691)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-sint-to-scheme self-2690) (py-sint-to-scheme other-2691)))))

(define (py-test-eq-sintX-sintY-fallback self-2693 other-2694)
  (py-test-from-scheme
   (py== (py-sint-to-scheme self-2693) (py-sint-to-scheme other-2694))))

(define (py-eq-sintX-bintY-fallback self-2696 other-2697)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-sint-to-scheme self-2696) (py-bint-to-scheme other-2697)))))

(define (py-test-eq-sintX-bintY-fallback self-2699 other-2700)
  (py-test-from-scheme
   (py== (py-sint-to-scheme self-2699) (py-bint-to-scheme other-2700))))

(define (py-eq-bintX-intY-fallback self-2702 other-2703)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-bint-to-scheme self-2702) (py-int-to-scheme other-2703)))))

(define (py-test-eq-bintX-intY-fallback self-2705 other-2706)
  (py-test-from-scheme
   (py== (py-bint-to-scheme self-2705) (py-int-to-scheme other-2706))))

(define (py-eq-bintX-floatY-fallback other-2708 self-2709)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-float-to-scheme self-2709) (py-bint-to-scheme other-2708)))))

(define (py-test-eq-bintX-floatY-fallback other-2711 self-2712)
  (py-test-from-scheme
   (py== (py-float-to-scheme self-2712) (py-bint-to-scheme other-2711))))

(define (py-eq-bintX-boolY-fallback self-2714 other-2715)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-bint-to-scheme self-2714) (py-bool-to-scheme-int other-2715)))))

(define (py-test-eq-bintX-boolY-fallback self-2717 other-2718)
  (py-test-from-scheme
   (py== (py-bint-to-scheme self-2717) (py-bool-to-scheme-int other-2718))))

(define (py-eq-bintX-sintY-fallback self-2720 other-2721)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-bint-to-scheme self-2720) (py-sint-to-scheme other-2721)))))

(define (py-test-eq-bintX-sintY-fallback self-2723 other-2724)
  (py-test-from-scheme
   (py== (py-bint-to-scheme self-2723) (py-sint-to-scheme other-2724))))

(define (py-eq-bintX-bintY-fallback self-2726 other-2727)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-bint-to-scheme self-2726) (py-bint-to-scheme other-2727)))))

(define (py-test-eq-bintX-bintY-fallback self-2729 other-2730)
  (py-test-from-scheme
   (py== (py-bint-to-scheme self-2729) (py-bint-to-scheme other-2730))))

(define (py-ne-intX-intY-fallback self-2732 other-2733)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-int-to-scheme self-2732) (py-int-to-scheme other-2733)))))

(define (py-test-ne-intX-intY-fallback self-2735 other-2736)
  (py-test-from-scheme
   (py!= (py-int-to-scheme self-2735) (py-int-to-scheme other-2736))))

(define (py-ne-intX-floatY-fallback other-2738 self-2739)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-float-to-scheme self-2739) (py-int-to-scheme other-2738)))))

(define (py-test-ne-intX-floatY-fallback other-2741 self-2742)
  (py-test-from-scheme
   (py!= (py-float-to-scheme self-2742) (py-int-to-scheme other-2741))))

(define (py-ne-intX-boolY-fallback self-2744 other-2745)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-int-to-scheme self-2744) (py-bool-to-scheme-int other-2745)))))

(define (py-test-ne-intX-boolY-fallback self-2747 other-2748)
  (py-test-from-scheme
   (py!= (py-int-to-scheme self-2747) (py-bool-to-scheme-int other-2748))))

(define (py-ne-intX-sintY-fallback self-2750 other-2751)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-int-to-scheme self-2750) (py-sint-to-scheme other-2751)))))

(define (py-test-ne-intX-sintY-fallback self-2753 other-2754)
  (py-test-from-scheme
   (py!= (py-int-to-scheme self-2753) (py-sint-to-scheme other-2754))))

(define (py-ne-intX-bintY-fallback self-2756 other-2757)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-int-to-scheme self-2756) (py-bint-to-scheme other-2757)))))

(define (py-test-ne-intX-bintY-fallback self-2759 other-2760)
  (py-test-from-scheme
   (py!= (py-int-to-scheme self-2759) (py-bint-to-scheme other-2760))))

(define (py-ne-floatX-intY-fallback self-2762 other-2763)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-float-to-scheme self-2762) (py-int-to-scheme other-2763)))))

(define (py-test-ne-floatX-intY-fallback self-2765 other-2766)
  (py-test-from-scheme
   (py!= (py-float-to-scheme self-2765) (py-int-to-scheme other-2766))))

(define (py-ne-floatX-floatY-fallback self-2768 other-2769)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-float-to-scheme self-2768) (py-float-to-scheme other-2769)))))

(define (py-test-ne-floatX-floatY-fallback self-2771 other-2772)
  (py-test-from-scheme
   (py!= (py-float-to-scheme self-2771) (py-float-to-scheme other-2772))))

(define (py-ne-floatX-boolY-fallback self-2774 other-2775)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-float-to-scheme self-2774) (py-bool-to-scheme-int other-2775)))))

(define (py-test-ne-floatX-boolY-fallback self-2777 other-2778)
  (py-test-from-scheme
   (py!= (py-float-to-scheme self-2777) (py-bool-to-scheme-int other-2778))))

(define (py-ne-floatX-sintY-fallback self-2780 other-2781)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-float-to-scheme self-2780) (py-sint-to-scheme other-2781)))))

(define (py-test-ne-floatX-sintY-fallback self-2783 other-2784)
  (py-test-from-scheme
   (py!= (py-float-to-scheme self-2783) (py-sint-to-scheme other-2784))))

(define (py-ne-floatX-bintY-fallback self-2786 other-2787)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-float-to-scheme self-2786) (py-bint-to-scheme other-2787)))))

(define (py-test-ne-floatX-bintY-fallback self-2789 other-2790)
  (py-test-from-scheme
   (py!= (py-float-to-scheme self-2789) (py-bint-to-scheme other-2790))))

(define (py-ne-boolX-intY-fallback self-2792 other-2793)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-bool-to-scheme-int self-2792) (py-int-to-scheme other-2793)))))

(define (py-test-ne-boolX-intY-fallback self-2795 other-2796)
  (py-test-from-scheme
   (py!= (py-bool-to-scheme-int self-2795) (py-int-to-scheme other-2796))))

(define (py-ne-boolX-floatY-fallback other-2798 self-2799)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-float-to-scheme self-2799) (py-bool-to-scheme-int other-2798)))))

(define (py-test-ne-boolX-floatY-fallback other-2801 self-2802)
  (py-test-from-scheme
   (py!= (py-float-to-scheme self-2802) (py-bool-to-scheme-int other-2801))))

(define (py-ne-boolX-boolY-fallback self-2804 other-2805)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-bool-to-scheme-int self-2804)
          (py-bool-to-scheme-int other-2805)))))

(define (py-test-ne-boolX-boolY-fallback self-2807 other-2808)
  (py-test-from-scheme
   (py!= (py-bool-to-scheme-int self-2807)
         (py-bool-to-scheme-int other-2808))))

(define (py-ne-boolX-sintY-fallback self-2810 other-2811)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-bool-to-scheme-int self-2810) (py-sint-to-scheme other-2811)))))

(define (py-test-ne-boolX-sintY-fallback self-2813 other-2814)
  (py-test-from-scheme
   (py!= (py-bool-to-scheme-int self-2813) (py-sint-to-scheme other-2814))))

(define (py-ne-boolX-bintY-fallback self-2816 other-2817)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-bool-to-scheme-int self-2816) (py-bint-to-scheme other-2817)))))

(define (py-test-ne-boolX-bintY-fallback self-2819 other-2820)
  (py-test-from-scheme
   (py!= (py-bool-to-scheme-int self-2819) (py-bint-to-scheme other-2820))))

(define (py-ne-sintX-intY-fallback self-2822 other-2823)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-sint-to-scheme self-2822) (py-int-to-scheme other-2823)))))

(define (py-test-ne-sintX-intY-fallback self-2825 other-2826)
  (py-test-from-scheme
   (py!= (py-sint-to-scheme self-2825) (py-int-to-scheme other-2826))))

(define (py-ne-sintX-floatY-fallback other-2828 self-2829)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-float-to-scheme self-2829) (py-sint-to-scheme other-2828)))))

(define (py-test-ne-sintX-floatY-fallback other-2831 self-2832)
  (py-test-from-scheme
   (py!= (py-float-to-scheme self-2832) (py-sint-to-scheme other-2831))))

(define (py-ne-sintX-boolY-fallback self-2834 other-2835)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-sint-to-scheme self-2834) (py-bool-to-scheme-int other-2835)))))

(define (py-test-ne-sintX-boolY-fallback self-2837 other-2838)
  (py-test-from-scheme
   (py!= (py-sint-to-scheme self-2837) (py-bool-to-scheme-int other-2838))))

(define (py-ne-sintX-sintY-fallback self-2840 other-2841)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-sint-to-scheme self-2840) (py-sint-to-scheme other-2841)))))

(define (py-test-ne-sintX-sintY-fallback self-2843 other-2844)
  (py-test-from-scheme
   (py!= (py-sint-to-scheme self-2843) (py-sint-to-scheme other-2844))))

(define (py-ne-sintX-bintY-fallback self-2846 other-2847)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-sint-to-scheme self-2846) (py-bint-to-scheme other-2847)))))

(define (py-test-ne-sintX-bintY-fallback self-2849 other-2850)
  (py-test-from-scheme
   (py!= (py-sint-to-scheme self-2849) (py-bint-to-scheme other-2850))))

(define (py-ne-bintX-intY-fallback self-2852 other-2853)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-bint-to-scheme self-2852) (py-int-to-scheme other-2853)))))

(define (py-test-ne-bintX-intY-fallback self-2855 other-2856)
  (py-test-from-scheme
   (py!= (py-bint-to-scheme self-2855) (py-int-to-scheme other-2856))))

(define (py-ne-bintX-floatY-fallback other-2858 self-2859)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-float-to-scheme self-2859) (py-bint-to-scheme other-2858)))))

(define (py-test-ne-bintX-floatY-fallback other-2861 self-2862)
  (py-test-from-scheme
   (py!= (py-float-to-scheme self-2862) (py-bint-to-scheme other-2861))))

(define (py-ne-bintX-boolY-fallback self-2864 other-2865)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-bint-to-scheme self-2864) (py-bool-to-scheme-int other-2865)))))

(define (py-test-ne-bintX-boolY-fallback self-2867 other-2868)
  (py-test-from-scheme
   (py!= (py-bint-to-scheme self-2867) (py-bool-to-scheme-int other-2868))))

(define (py-ne-bintX-sintY-fallback self-2870 other-2871)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-bint-to-scheme self-2870) (py-sint-to-scheme other-2871)))))

(define (py-test-ne-bintX-sintY-fallback self-2873 other-2874)
  (py-test-from-scheme
   (py!= (py-bint-to-scheme self-2873) (py-sint-to-scheme other-2874))))

(define (py-ne-bintX-bintY-fallback self-2876 other-2877)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-bint-to-scheme self-2876) (py-bint-to-scheme other-2877)))))

(define (py-test-ne-bintX-bintY-fallback self-2879 other-2880)
  (py-test-from-scheme
   (py!= (py-bint-to-scheme self-2879) (py-bint-to-scheme other-2880))))

