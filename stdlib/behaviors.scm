(define-macro (py-add-floatX-floatY-inline x-2 y-3)
  `(let ((x-2 ,x-2) (y-3 ,y-3))
     (py-float-from-scheme
      (py+ (py-float-to-scheme x-2) (py-float-to-scheme y-3)))))

(define-macro (py-add-floatX-boolY-inline x-4 y-5)
  `(py-add-floatX-boolY-fallback ,x-4 ,y-5))

(define-macro (py-add-floatX-strY-inline x-6 y-7)
  `(py-add-floatX-strY-fallback ,x-6 ,y-7))

(define-macro (py-add-floatX-sintY-inline x-8 y-9)
  `(let ((x-8 ,x-8) (y-9 ,y-9))
     (py-float-from-scheme
      (py+ (py-float-to-scheme x-8) (py-sint-to-scheme y-9)))))

(define-macro (py-add-floatX-bintY-inline x-10 y-11)
  `(py-add-floatX-bintY-fallback ,x-10 ,y-11))

(define-macro (py-add-boolX-floatY-inline x-12 y-13)
  `(py-add-boolX-floatY-fallback ,x-12 ,y-13))

(define-macro (py-add-boolX-boolY-inline x-14 y-15)
  `(py-add-boolX-boolY-fallback ,x-14 ,y-15))

(define-macro (py-add-boolX-strY-inline x-16 y-17)
  `(py-add-boolX-strY-fallback ,x-16 ,y-17))

(define-macro (py-add-boolX-sintY-inline x-18 y-19)
  `(py-add-boolX-sintY-fallback ,x-18 ,y-19))

(define-macro (py-add-boolX-bintY-inline x-20 y-21)
  `(py-add-boolX-bintY-fallback ,x-20 ,y-21))

(define-macro (py-add-strX-floatY-inline x-22 y-23)
  `(py-add-strX-floatY-fallback ,x-22 ,y-23))

(define-macro (py-add-strX-boolY-inline x-24 y-25)
  `(py-add-strX-boolY-fallback ,x-24 ,y-25))

(define-macro (py-add-strX-strY-inline x-26 y-27)
  `(py-add-strX-strY-fallback ,x-26 ,y-27))

(define-macro (py-add-strX-sintY-inline x-28 y-29)
  `(py-add-strX-sintY-fallback ,x-28 ,y-29))

(define-macro (py-add-strX-bintY-inline x-30 y-31)
  `(py-add-strX-bintY-fallback ,x-30 ,y-31))

(define-macro (py-add-sintX-floatY-inline x-32 y-33)
  `(let ((x-32 ,x-32) (y-33 ,y-33))
     (py-float-from-scheme
      (py+ (py-sint-to-scheme x-32) (py-float-to-scheme y-33)))))

(define-macro (py-add-sintX-boolY-inline x-34 y-35)
  `(py-add-sintX-boolY-fallback ,x-34 ,y-35))

(define-macro (py-add-sintX-strY-inline x-36 y-37)
  `(py-add-sintX-strY-fallback ,x-36 ,y-37))

(define-macro (py-add-sintX-sintY-inline x-38 y-39)
  `(let ((x-38 ,x-38) (y-39 ,y-39))
     (py-int-from-scheme
      (py+ (py-sint-to-scheme x-38) (py-sint-to-scheme y-39)))))

(define-macro (py-add-sintX-bintY-inline x-40 y-41)
  `(py-add-sintX-bintY-fallback ,x-40 ,y-41))

(define-macro (py-add-bintX-floatY-inline x-42 y-43)
  `(py-add-bintX-floatY-fallback ,x-42 ,y-43))

(define-macro (py-add-bintX-boolY-inline x-44 y-45)
  `(py-add-bintX-boolY-fallback ,x-44 ,y-45))

(define-macro (py-add-bintX-strY-inline x-46 y-47)
  `(py-add-bintX-strY-fallback ,x-46 ,y-47))

(define-macro (py-add-bintX-sintY-inline x-48 y-49)
  `(py-add-bintX-sintY-fallback ,x-48 ,y-49))

(define-macro (py-add-bintX-bintY-inline x-50 y-51)
  `(py-add-bintX-bintY-fallback ,x-50 ,y-51))

(define-macro (py-bitand-floatX-floatY-inline x-52 y-53)
  `(let ((x-52 ,x-52) (y-53 ,y-53))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for &: 'float' and 'float'")))))

(define-macro (py-bitand-floatX-boolY-inline x-54 y-55)
  `(py-bitand-floatX-boolY-fallback ,x-54 ,y-55))

(define-macro (py-bitand-floatX-strY-inline x-56 y-57)
  `(py-bitand-floatX-strY-fallback ,x-56 ,y-57))

(define-macro (py-bitand-floatX-sintY-inline x-58 y-59)
  `(let ((x-58 ,x-58) (y-59 ,y-59))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for &: 'float' and 'int'")))))

(define-macro (py-bitand-floatX-bintY-inline x-60 y-61)
  `(py-bitand-floatX-bintY-fallback ,x-60 ,y-61))

(define-macro (py-bitand-boolX-floatY-inline x-62 y-63)
  `(py-bitand-boolX-floatY-fallback ,x-62 ,y-63))

(define-macro (py-bitand-boolX-boolY-inline x-64 y-65)
  `(py-bitand-boolX-boolY-fallback ,x-64 ,y-65))

(define-macro (py-bitand-boolX-strY-inline x-66 y-67)
  `(py-bitand-boolX-strY-fallback ,x-66 ,y-67))

(define-macro (py-bitand-boolX-sintY-inline x-68 y-69)
  `(py-bitand-boolX-sintY-fallback ,x-68 ,y-69))

(define-macro (py-bitand-boolX-bintY-inline x-70 y-71)
  `(py-bitand-boolX-bintY-fallback ,x-70 ,y-71))

(define-macro (py-bitand-strX-floatY-inline x-72 y-73)
  `(py-bitand-strX-floatY-fallback ,x-72 ,y-73))

(define-macro (py-bitand-strX-boolY-inline x-74 y-75)
  `(py-bitand-strX-boolY-fallback ,x-74 ,y-75))

(define-macro (py-bitand-strX-strY-inline x-76 y-77)
  `(py-bitand-strX-strY-fallback ,x-76 ,y-77))

(define-macro (py-bitand-strX-sintY-inline x-78 y-79)
  `(py-bitand-strX-sintY-fallback ,x-78 ,y-79))

(define-macro (py-bitand-strX-bintY-inline x-80 y-81)
  `(py-bitand-strX-bintY-fallback ,x-80 ,y-81))

(define-macro (py-bitand-sintX-floatY-inline x-82 y-83)
  `(let ((x-82 ,x-82) (y-83 ,y-83))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for &: 'int' and 'float'")))))

(define-macro (py-bitand-sintX-boolY-inline x-84 y-85)
  `(py-bitand-sintX-boolY-fallback ,x-84 ,y-85))

(define-macro (py-bitand-sintX-strY-inline x-86 y-87)
  `(py-bitand-sintX-strY-fallback ,x-86 ,y-87))

(define-macro (py-bitand-sintX-sintY-inline x-88 y-89)
  `(let ((x-88 ,x-88) (y-89 ,y-89))
     (py-int-from-scheme
      (py& (py-sint-to-scheme x-88) (py-sint-to-scheme y-89)))))

(define-macro (py-bitand-sintX-bintY-inline x-90 y-91)
  `(py-bitand-sintX-bintY-fallback ,x-90 ,y-91))

(define-macro (py-bitand-bintX-floatY-inline x-92 y-93)
  `(py-bitand-bintX-floatY-fallback ,x-92 ,y-93))

(define-macro (py-bitand-bintX-boolY-inline x-94 y-95)
  `(py-bitand-bintX-boolY-fallback ,x-94 ,y-95))

(define-macro (py-bitand-bintX-strY-inline x-96 y-97)
  `(py-bitand-bintX-strY-fallback ,x-96 ,y-97))

(define-macro (py-bitand-bintX-sintY-inline x-98 y-99)
  `(py-bitand-bintX-sintY-fallback ,x-98 ,y-99))

(define-macro (py-bitand-bintX-bintY-inline x-100 y-101)
  `(py-bitand-bintX-bintY-fallback ,x-100 ,y-101))

(define-macro (py-bitor-floatX-floatY-inline x-102 y-103)
  `(let ((x-102 ,x-102) (y-103 ,y-103))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for |: 'float' and 'float'")))))

(define-macro (py-bitor-floatX-boolY-inline x-104 y-105)
  `(py-bitor-floatX-boolY-fallback ,x-104 ,y-105))

(define-macro (py-bitor-floatX-strY-inline x-106 y-107)
  `(py-bitor-floatX-strY-fallback ,x-106 ,y-107))

(define-macro (py-bitor-floatX-sintY-inline x-108 y-109)
  `(let ((x-108 ,x-108) (y-109 ,y-109))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for |: 'float' and 'int'")))))

(define-macro (py-bitor-floatX-bintY-inline x-110 y-111)
  `(py-bitor-floatX-bintY-fallback ,x-110 ,y-111))

(define-macro (py-bitor-boolX-floatY-inline x-112 y-113)
  `(py-bitor-boolX-floatY-fallback ,x-112 ,y-113))

(define-macro (py-bitor-boolX-boolY-inline x-114 y-115)
  `(py-bitor-boolX-boolY-fallback ,x-114 ,y-115))

(define-macro (py-bitor-boolX-strY-inline x-116 y-117)
  `(py-bitor-boolX-strY-fallback ,x-116 ,y-117))

(define-macro (py-bitor-boolX-sintY-inline x-118 y-119)
  `(py-bitor-boolX-sintY-fallback ,x-118 ,y-119))

(define-macro (py-bitor-boolX-bintY-inline x-120 y-121)
  `(py-bitor-boolX-bintY-fallback ,x-120 ,y-121))

(define-macro (py-bitor-strX-floatY-inline x-122 y-123)
  `(py-bitor-strX-floatY-fallback ,x-122 ,y-123))

(define-macro (py-bitor-strX-boolY-inline x-124 y-125)
  `(py-bitor-strX-boolY-fallback ,x-124 ,y-125))

(define-macro (py-bitor-strX-strY-inline x-126 y-127)
  `(py-bitor-strX-strY-fallback ,x-126 ,y-127))

(define-macro (py-bitor-strX-sintY-inline x-128 y-129)
  `(py-bitor-strX-sintY-fallback ,x-128 ,y-129))

(define-macro (py-bitor-strX-bintY-inline x-130 y-131)
  `(py-bitor-strX-bintY-fallback ,x-130 ,y-131))

(define-macro (py-bitor-sintX-floatY-inline x-132 y-133)
  `(let ((x-132 ,x-132) (y-133 ,y-133))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for |: 'int' and 'float'")))))

(define-macro (py-bitor-sintX-boolY-inline x-134 y-135)
  `(py-bitor-sintX-boolY-fallback ,x-134 ,y-135))

(define-macro (py-bitor-sintX-strY-inline x-136 y-137)
  `(py-bitor-sintX-strY-fallback ,x-136 ,y-137))

(define-macro (py-bitor-sintX-sintY-inline x-138 y-139)
  `(let ((x-138 ,x-138) (y-139 ,y-139))
     (py-int-from-scheme
      (py+b (py-sint-to-scheme x-138) (py-sint-to-scheme y-139)))))

(define-macro (py-bitor-sintX-bintY-inline x-140 y-141)
  `(py-bitor-sintX-bintY-fallback ,x-140 ,y-141))

(define-macro (py-bitor-bintX-floatY-inline x-142 y-143)
  `(py-bitor-bintX-floatY-fallback ,x-142 ,y-143))

(define-macro (py-bitor-bintX-boolY-inline x-144 y-145)
  `(py-bitor-bintX-boolY-fallback ,x-144 ,y-145))

(define-macro (py-bitor-bintX-strY-inline x-146 y-147)
  `(py-bitor-bintX-strY-fallback ,x-146 ,y-147))

(define-macro (py-bitor-bintX-sintY-inline x-148 y-149)
  `(py-bitor-bintX-sintY-fallback ,x-148 ,y-149))

(define-macro (py-bitor-bintX-bintY-inline x-150 y-151)
  `(py-bitor-bintX-bintY-fallback ,x-150 ,y-151))

(define-macro (py-floordiv-floatX-floatY-inline x-152 y-153)
  `(let ((x-152 ,x-152) (y-153 ,y-153))
     (if (py-test (py-bool-from-scheme-bool
                   (py-test-from-scheme (py!= (py-float-to-scheme y-153) 0.))))
         (py-float-from-scheme
          (py// (py-float-to-scheme x-152) (py-float-to-scheme y-153)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-floordiv-floatX-boolY-inline x-154 y-155)
  `(py-floordiv-floatX-boolY-fallback ,x-154 ,y-155))

(define-macro (py-floordiv-floatX-strY-inline x-156 y-157)
  `(py-floordiv-floatX-strY-fallback ,x-156 ,y-157))

(define-macro (py-floordiv-floatX-sintY-inline x-158 y-159)
  `(let ((x-158 ,x-158) (y-159 ,y-159))
     (if (py-test (py-bool-from-scheme-bool
                   (py-test-from-scheme (py!= (py-sint-to-scheme y-159) 0))))
         (py-float-from-scheme
          (py// (py-float-to-scheme x-158) (py-sint-to-scheme y-159)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-floordiv-floatX-bintY-inline x-160 y-161)
  `(py-floordiv-floatX-bintY-fallback ,x-160 ,y-161))

(define-macro (py-floordiv-boolX-floatY-inline x-162 y-163)
  `(py-floordiv-boolX-floatY-fallback ,x-162 ,y-163))

(define-macro (py-floordiv-boolX-boolY-inline x-164 y-165)
  `(py-floordiv-boolX-boolY-fallback ,x-164 ,y-165))

(define-macro (py-floordiv-boolX-strY-inline x-166 y-167)
  `(py-floordiv-boolX-strY-fallback ,x-166 ,y-167))

(define-macro (py-floordiv-boolX-sintY-inline x-168 y-169)
  `(py-floordiv-boolX-sintY-fallback ,x-168 ,y-169))

(define-macro (py-floordiv-boolX-bintY-inline x-170 y-171)
  `(py-floordiv-boolX-bintY-fallback ,x-170 ,y-171))

(define-macro (py-floordiv-strX-floatY-inline x-172 y-173)
  `(py-floordiv-strX-floatY-fallback ,x-172 ,y-173))

(define-macro (py-floordiv-strX-boolY-inline x-174 y-175)
  `(py-floordiv-strX-boolY-fallback ,x-174 ,y-175))

(define-macro (py-floordiv-strX-strY-inline x-176 y-177)
  `(py-floordiv-strX-strY-fallback ,x-176 ,y-177))

(define-macro (py-floordiv-strX-sintY-inline x-178 y-179)
  `(py-floordiv-strX-sintY-fallback ,x-178 ,y-179))

(define-macro (py-floordiv-strX-bintY-inline x-180 y-181)
  `(py-floordiv-strX-bintY-fallback ,x-180 ,y-181))

(define-macro (py-floordiv-sintX-floatY-inline x-182 y-183)
  `(let ((x-182 ,x-182) (y-183 ,y-183))
     (if (py-test (py-bool-from-scheme-bool
                   (py-test-from-scheme (py!= (py-float-to-scheme y-183) 0.))))
         (py-float-from-scheme
          (py// (py-sint-to-scheme x-182) (py-float-to-scheme y-183)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-floordiv-sintX-boolY-inline x-184 y-185)
  `(py-floordiv-sintX-boolY-fallback ,x-184 ,y-185))

(define-macro (py-floordiv-sintX-strY-inline x-186 y-187)
  `(py-floordiv-sintX-strY-fallback ,x-186 ,y-187))

(define-macro (py-floordiv-sintX-sintY-inline x-188 y-189)
  `(let ((x-188 ,x-188) (y-189 ,y-189))
     (if (py-test (py-bool-from-scheme-bool
                   (py-test-from-scheme (py!= (py-sint-to-scheme y-189) 0))))
         (py-int-from-scheme
          (py// (py-sint-to-scheme x-188) (py-sint-to-scheme y-189)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "integer division by zero"))))))

(define-macro (py-floordiv-sintX-bintY-inline x-190 y-191)
  `(py-floordiv-sintX-bintY-fallback ,x-190 ,y-191))

(define-macro (py-floordiv-bintX-floatY-inline x-192 y-193)
  `(py-floordiv-bintX-floatY-fallback ,x-192 ,y-193))

(define-macro (py-floordiv-bintX-boolY-inline x-194 y-195)
  `(py-floordiv-bintX-boolY-fallback ,x-194 ,y-195))

(define-macro (py-floordiv-bintX-strY-inline x-196 y-197)
  `(py-floordiv-bintX-strY-fallback ,x-196 ,y-197))

(define-macro (py-floordiv-bintX-sintY-inline x-198 y-199)
  `(py-floordiv-bintX-sintY-fallback ,x-198 ,y-199))

(define-macro (py-floordiv-bintX-bintY-inline x-200 y-201)
  `(py-floordiv-bintX-bintY-fallback ,x-200 ,y-201))

(define-macro (py-lshift-floatX-floatY-inline x-202 y-203)
  `(let ((x-202 ,x-202) (y-203 ,y-203))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for <<: 'float' and 'float'")))))

(define-macro (py-lshift-floatX-boolY-inline x-204 y-205)
  `(py-lshift-floatX-boolY-fallback ,x-204 ,y-205))

(define-macro (py-lshift-floatX-strY-inline x-206 y-207)
  `(py-lshift-floatX-strY-fallback ,x-206 ,y-207))

(define-macro (py-lshift-floatX-sintY-inline x-208 y-209)
  `(let ((x-208 ,x-208) (y-209 ,y-209))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for <<: 'float' and 'int'")))))

(define-macro (py-lshift-floatX-bintY-inline x-210 y-211)
  `(py-lshift-floatX-bintY-fallback ,x-210 ,y-211))

(define-macro (py-lshift-boolX-floatY-inline x-212 y-213)
  `(py-lshift-boolX-floatY-fallback ,x-212 ,y-213))

(define-macro (py-lshift-boolX-boolY-inline x-214 y-215)
  `(py-lshift-boolX-boolY-fallback ,x-214 ,y-215))

(define-macro (py-lshift-boolX-strY-inline x-216 y-217)
  `(py-lshift-boolX-strY-fallback ,x-216 ,y-217))

(define-macro (py-lshift-boolX-sintY-inline x-218 y-219)
  `(py-lshift-boolX-sintY-fallback ,x-218 ,y-219))

(define-macro (py-lshift-boolX-bintY-inline x-220 y-221)
  `(py-lshift-boolX-bintY-fallback ,x-220 ,y-221))

(define-macro (py-lshift-strX-floatY-inline x-222 y-223)
  `(py-lshift-strX-floatY-fallback ,x-222 ,y-223))

(define-macro (py-lshift-strX-boolY-inline x-224 y-225)
  `(py-lshift-strX-boolY-fallback ,x-224 ,y-225))

(define-macro (py-lshift-strX-strY-inline x-226 y-227)
  `(py-lshift-strX-strY-fallback ,x-226 ,y-227))

(define-macro (py-lshift-strX-sintY-inline x-228 y-229)
  `(py-lshift-strX-sintY-fallback ,x-228 ,y-229))

(define-macro (py-lshift-strX-bintY-inline x-230 y-231)
  `(py-lshift-strX-bintY-fallback ,x-230 ,y-231))

(define-macro (py-lshift-sintX-floatY-inline x-232 y-233)
  `(let ((x-232 ,x-232) (y-233 ,y-233))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for <<: 'int' and 'float'")))))

(define-macro (py-lshift-sintX-boolY-inline x-234 y-235)
  `(py-lshift-sintX-boolY-fallback ,x-234 ,y-235))

(define-macro (py-lshift-sintX-strY-inline x-236 y-237)
  `(py-lshift-sintX-strY-fallback ,x-236 ,y-237))

(define-macro (py-lshift-sintX-sintY-inline x-238 y-239)
  `(let ((x-238 ,x-238) (y-239 ,y-239))
     (if (py-test (py-bool-from-scheme-bool
                   (py-test-from-scheme (py>= (py-sint-to-scheme y-239) 0))))
         (py-int-from-scheme
          (py<< (py-sint-to-scheme x-238) (py-sint-to-scheme y-239)))
         (py-throw
          (py-call py-builtin-ValueError (&& "negative shift count"))))))

(define-macro (py-lshift-sintX-bintY-inline x-240 y-241)
  `(py-lshift-sintX-bintY-fallback ,x-240 ,y-241))

(define-macro (py-lshift-bintX-floatY-inline x-242 y-243)
  `(py-lshift-bintX-floatY-fallback ,x-242 ,y-243))

(define-macro (py-lshift-bintX-boolY-inline x-244 y-245)
  `(py-lshift-bintX-boolY-fallback ,x-244 ,y-245))

(define-macro (py-lshift-bintX-strY-inline x-246 y-247)
  `(py-lshift-bintX-strY-fallback ,x-246 ,y-247))

(define-macro (py-lshift-bintX-sintY-inline x-248 y-249)
  `(py-lshift-bintX-sintY-fallback ,x-248 ,y-249))

(define-macro (py-lshift-bintX-bintY-inline x-250 y-251)
  `(py-lshift-bintX-bintY-fallback ,x-250 ,y-251))

(define-macro (py-matmul-floatX-floatY-inline x-252 y-253)
  `(let ((x-252 ,x-252) (y-253 ,y-253))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @: 'float' and 'float'")))))

(define-macro (py-matmul-floatX-boolY-inline x-254 y-255)
  `(py-matmul-floatX-boolY-fallback ,x-254 ,y-255))

(define-macro (py-matmul-floatX-strY-inline x-256 y-257)
  `(py-matmul-floatX-strY-fallback ,x-256 ,y-257))

(define-macro (py-matmul-floatX-sintY-inline x-258 y-259)
  `(let ((x-258 ,x-258) (y-259 ,y-259))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @: 'float' and 'int'")))))

(define-macro (py-matmul-floatX-bintY-inline x-260 y-261)
  `(py-matmul-floatX-bintY-fallback ,x-260 ,y-261))

(define-macro (py-matmul-boolX-floatY-inline x-262 y-263)
  `(py-matmul-boolX-floatY-fallback ,x-262 ,y-263))

(define-macro (py-matmul-boolX-boolY-inline x-264 y-265)
  `(py-matmul-boolX-boolY-fallback ,x-264 ,y-265))

(define-macro (py-matmul-boolX-strY-inline x-266 y-267)
  `(py-matmul-boolX-strY-fallback ,x-266 ,y-267))

(define-macro (py-matmul-boolX-sintY-inline x-268 y-269)
  `(py-matmul-boolX-sintY-fallback ,x-268 ,y-269))

(define-macro (py-matmul-boolX-bintY-inline x-270 y-271)
  `(py-matmul-boolX-bintY-fallback ,x-270 ,y-271))

(define-macro (py-matmul-strX-floatY-inline x-272 y-273)
  `(py-matmul-strX-floatY-fallback ,x-272 ,y-273))

(define-macro (py-matmul-strX-boolY-inline x-274 y-275)
  `(py-matmul-strX-boolY-fallback ,x-274 ,y-275))

(define-macro (py-matmul-strX-strY-inline x-276 y-277)
  `(py-matmul-strX-strY-fallback ,x-276 ,y-277))

(define-macro (py-matmul-strX-sintY-inline x-278 y-279)
  `(py-matmul-strX-sintY-fallback ,x-278 ,y-279))

(define-macro (py-matmul-strX-bintY-inline x-280 y-281)
  `(py-matmul-strX-bintY-fallback ,x-280 ,y-281))

(define-macro (py-matmul-sintX-floatY-inline x-282 y-283)
  `(let ((x-282 ,x-282) (y-283 ,y-283))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @: 'int' and 'float'")))))

(define-macro (py-matmul-sintX-boolY-inline x-284 y-285)
  `(py-matmul-sintX-boolY-fallback ,x-284 ,y-285))

(define-macro (py-matmul-sintX-strY-inline x-286 y-287)
  `(py-matmul-sintX-strY-fallback ,x-286 ,y-287))

(define-macro (py-matmul-sintX-sintY-inline x-288 y-289)
  `(let ((x-288 ,x-288) (y-289 ,y-289))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @: 'int' and 'int'")))))

(define-macro (py-matmul-sintX-bintY-inline x-290 y-291)
  `(py-matmul-sintX-bintY-fallback ,x-290 ,y-291))

(define-macro (py-matmul-bintX-floatY-inline x-292 y-293)
  `(py-matmul-bintX-floatY-fallback ,x-292 ,y-293))

(define-macro (py-matmul-bintX-boolY-inline x-294 y-295)
  `(py-matmul-bintX-boolY-fallback ,x-294 ,y-295))

(define-macro (py-matmul-bintX-strY-inline x-296 y-297)
  `(py-matmul-bintX-strY-fallback ,x-296 ,y-297))

(define-macro (py-matmul-bintX-sintY-inline x-298 y-299)
  `(py-matmul-bintX-sintY-fallback ,x-298 ,y-299))

(define-macro (py-matmul-bintX-bintY-inline x-300 y-301)
  `(py-matmul-bintX-bintY-fallback ,x-300 ,y-301))

(define-macro (py-mod-floatX-floatY-inline x-302 y-303)
  `(let ((x-302 ,x-302) (y-303 ,y-303))
     (if (py-test (py-bool-from-scheme-bool
                   (py-test-from-scheme (py!= (py-float-to-scheme y-303) 0.))))
         (py-float-from-scheme
          (py% (py-float-to-scheme x-302) (py-float-to-scheme y-303)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float modulo by zero"))))))

(define-macro (py-mod-floatX-boolY-inline x-304 y-305)
  `(py-mod-floatX-boolY-fallback ,x-304 ,y-305))

(define-macro (py-mod-floatX-strY-inline x-306 y-307)
  `(py-mod-floatX-strY-fallback ,x-306 ,y-307))

(define-macro (py-mod-floatX-sintY-inline x-308 y-309)
  `(let ((x-308 ,x-308) (y-309 ,y-309))
     (if (py-test (py-bool-from-scheme-bool
                   (py-test-from-scheme (py!= (py-sint-to-scheme y-309) 0))))
         (py-float-from-scheme
          (py% (py-float-to-scheme x-308) (py-sint-to-scheme y-309)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float modulo by zero"))))))

(define-macro (py-mod-floatX-bintY-inline x-310 y-311)
  `(py-mod-floatX-bintY-fallback ,x-310 ,y-311))

(define-macro (py-mod-boolX-floatY-inline x-312 y-313)
  `(py-mod-boolX-floatY-fallback ,x-312 ,y-313))

(define-macro (py-mod-boolX-boolY-inline x-314 y-315)
  `(py-mod-boolX-boolY-fallback ,x-314 ,y-315))

(define-macro (py-mod-boolX-strY-inline x-316 y-317)
  `(py-mod-boolX-strY-fallback ,x-316 ,y-317))

(define-macro (py-mod-boolX-sintY-inline x-318 y-319)
  `(py-mod-boolX-sintY-fallback ,x-318 ,y-319))

(define-macro (py-mod-boolX-bintY-inline x-320 y-321)
  `(py-mod-boolX-bintY-fallback ,x-320 ,y-321))

(define-macro (py-mod-strX-floatY-inline x-322 y-323)
  `(py-mod-strX-floatY-fallback ,x-322 ,y-323))

(define-macro (py-mod-strX-boolY-inline x-324 y-325)
  `(py-mod-strX-boolY-fallback ,x-324 ,y-325))

(define-macro (py-mod-strX-strY-inline x-326 y-327)
  `(py-mod-strX-strY-fallback ,x-326 ,y-327))

(define-macro (py-mod-strX-sintY-inline x-328 y-329)
  `(py-mod-strX-sintY-fallback ,x-328 ,y-329))

(define-macro (py-mod-strX-bintY-inline x-330 y-331)
  `(py-mod-strX-bintY-fallback ,x-330 ,y-331))

(define-macro (py-mod-sintX-floatY-inline x-332 y-333)
  `(let ((x-332 ,x-332) (y-333 ,y-333))
     (if (py-test (py-bool-from-scheme-bool
                   (py-test-from-scheme (py!= (py-float-to-scheme y-333) 0.))))
         (py-float-from-scheme
          (py% (py-sint-to-scheme x-332) (py-float-to-scheme y-333)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float modulo by zero"))))))

(define-macro (py-mod-sintX-boolY-inline x-334 y-335)
  `(py-mod-sintX-boolY-fallback ,x-334 ,y-335))

(define-macro (py-mod-sintX-strY-inline x-336 y-337)
  `(py-mod-sintX-strY-fallback ,x-336 ,y-337))

(define-macro (py-mod-sintX-sintY-inline x-338 y-339)
  `(let ((x-338 ,x-338) (y-339 ,y-339))
     (if (py-test (py-bool-from-scheme-bool
                   (py-test-from-scheme (py!= (py-sint-to-scheme y-339) 0))))
         (py-int-from-scheme
          (py% (py-sint-to-scheme x-338) (py-sint-to-scheme y-339)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError (&& "modulo by zero"))))))

(define-macro (py-mod-sintX-bintY-inline x-340 y-341)
  `(py-mod-sintX-bintY-fallback ,x-340 ,y-341))

(define-macro (py-mod-bintX-floatY-inline x-342 y-343)
  `(py-mod-bintX-floatY-fallback ,x-342 ,y-343))

(define-macro (py-mod-bintX-boolY-inline x-344 y-345)
  `(py-mod-bintX-boolY-fallback ,x-344 ,y-345))

(define-macro (py-mod-bintX-strY-inline x-346 y-347)
  `(py-mod-bintX-strY-fallback ,x-346 ,y-347))

(define-macro (py-mod-bintX-sintY-inline x-348 y-349)
  `(py-mod-bintX-sintY-fallback ,x-348 ,y-349))

(define-macro (py-mod-bintX-bintY-inline x-350 y-351)
  `(py-mod-bintX-bintY-fallback ,x-350 ,y-351))

(define-macro (py-mul-floatX-floatY-inline x-352 y-353)
  `(let ((x-352 ,x-352) (y-353 ,y-353))
     (py-float-from-scheme
      (py* (py-float-to-scheme x-352) (py-float-to-scheme y-353)))))

(define-macro (py-mul-floatX-boolY-inline x-354 y-355)
  `(py-mul-floatX-boolY-fallback ,x-354 ,y-355))

(define-macro (py-mul-floatX-strY-inline x-356 y-357)
  `(py-mul-floatX-strY-fallback ,x-356 ,y-357))

(define-macro (py-mul-floatX-sintY-inline x-358 y-359)
  `(let ((x-358 ,x-358) (y-359 ,y-359))
     (py-float-from-scheme
      (py* (py-float-to-scheme x-358) (py-sint-to-scheme y-359)))))

(define-macro (py-mul-floatX-bintY-inline x-360 y-361)
  `(py-mul-floatX-bintY-fallback ,x-360 ,y-361))

(define-macro (py-mul-boolX-floatY-inline x-362 y-363)
  `(py-mul-boolX-floatY-fallback ,x-362 ,y-363))

(define-macro (py-mul-boolX-boolY-inline x-364 y-365)
  `(py-mul-boolX-boolY-fallback ,x-364 ,y-365))

(define-macro (py-mul-boolX-strY-inline x-366 y-367)
  `(py-mul-boolX-strY-fallback ,x-366 ,y-367))

(define-macro (py-mul-boolX-sintY-inline x-368 y-369)
  `(py-mul-boolX-sintY-fallback ,x-368 ,y-369))

(define-macro (py-mul-boolX-bintY-inline x-370 y-371)
  `(py-mul-boolX-bintY-fallback ,x-370 ,y-371))

(define-macro (py-mul-strX-floatY-inline x-372 y-373)
  `(py-mul-strX-floatY-fallback ,x-372 ,y-373))

(define-macro (py-mul-strX-boolY-inline x-374 y-375)
  `(py-mul-strX-boolY-fallback ,x-374 ,y-375))

(define-macro (py-mul-strX-strY-inline x-376 y-377)
  `(py-mul-strX-strY-fallback ,x-376 ,y-377))

(define-macro (py-mul-strX-sintY-inline x-378 y-379)
  `(py-mul-strX-sintY-fallback ,x-378 ,y-379))

(define-macro (py-mul-strX-bintY-inline x-380 y-381)
  `(py-mul-strX-bintY-fallback ,x-380 ,y-381))

(define-macro (py-mul-sintX-floatY-inline x-382 y-383)
  `(let ((x-382 ,x-382) (y-383 ,y-383))
     (py-float-from-scheme
      (py* (py-sint-to-scheme x-382) (py-float-to-scheme y-383)))))

(define-macro (py-mul-sintX-boolY-inline x-384 y-385)
  `(py-mul-sintX-boolY-fallback ,x-384 ,y-385))

(define-macro (py-mul-sintX-strY-inline x-386 y-387)
  `(py-mul-sintX-strY-fallback ,x-386 ,y-387))

(define-macro (py-mul-sintX-sintY-inline x-388 y-389)
  `(let ((x-388 ,x-388) (y-389 ,y-389))
     (py-int-from-scheme
      (py* (py-sint-to-scheme x-388) (py-sint-to-scheme y-389)))))

(define-macro (py-mul-sintX-bintY-inline x-390 y-391)
  `(py-mul-sintX-bintY-fallback ,x-390 ,y-391))

(define-macro (py-mul-bintX-floatY-inline x-392 y-393)
  `(py-mul-bintX-floatY-fallback ,x-392 ,y-393))

(define-macro (py-mul-bintX-boolY-inline x-394 y-395)
  `(py-mul-bintX-boolY-fallback ,x-394 ,y-395))

(define-macro (py-mul-bintX-strY-inline x-396 y-397)
  `(py-mul-bintX-strY-fallback ,x-396 ,y-397))

(define-macro (py-mul-bintX-sintY-inline x-398 y-399)
  `(py-mul-bintX-sintY-fallback ,x-398 ,y-399))

(define-macro (py-mul-bintX-bintY-inline x-400 y-401)
  `(py-mul-bintX-bintY-fallback ,x-400 ,y-401))

(define-macro (py-pow-floatX-floatY-inline x-402 y-403)
  `(let ((x-402 ,x-402) (y-403 ,y-403))
     (py-float-from-scheme
      (py** (py-float-to-scheme x-402) (py-float-to-scheme y-403)))))

(define-macro (py-pow-floatX-boolY-inline x-404 y-405)
  `(py-pow-floatX-boolY-fallback ,x-404 ,y-405))

(define-macro (py-pow-floatX-strY-inline x-406 y-407)
  `(py-pow-floatX-strY-fallback ,x-406 ,y-407))

(define-macro (py-pow-floatX-sintY-inline x-408 y-409)
  `(let ((x-408 ,x-408) (y-409 ,y-409))
     (py-float-from-scheme
      (py** (py-float-to-scheme x-408) (py-sint-to-scheme y-409)))))

(define-macro (py-pow-floatX-bintY-inline x-410 y-411)
  `(py-pow-floatX-bintY-fallback ,x-410 ,y-411))

(define-macro (py-pow-boolX-floatY-inline x-412 y-413)
  `(py-pow-boolX-floatY-fallback ,x-412 ,y-413))

(define-macro (py-pow-boolX-boolY-inline x-414 y-415)
  `(py-pow-boolX-boolY-fallback ,x-414 ,y-415))

(define-macro (py-pow-boolX-strY-inline x-416 y-417)
  `(py-pow-boolX-strY-fallback ,x-416 ,y-417))

(define-macro (py-pow-boolX-sintY-inline x-418 y-419)
  `(py-pow-boolX-sintY-fallback ,x-418 ,y-419))

(define-macro (py-pow-boolX-bintY-inline x-420 y-421)
  `(py-pow-boolX-bintY-fallback ,x-420 ,y-421))

(define-macro (py-pow-strX-floatY-inline x-422 y-423)
  `(py-pow-strX-floatY-fallback ,x-422 ,y-423))

(define-macro (py-pow-strX-boolY-inline x-424 y-425)
  `(py-pow-strX-boolY-fallback ,x-424 ,y-425))

(define-macro (py-pow-strX-strY-inline x-426 y-427)
  `(py-pow-strX-strY-fallback ,x-426 ,y-427))

(define-macro (py-pow-strX-sintY-inline x-428 y-429)
  `(py-pow-strX-sintY-fallback ,x-428 ,y-429))

(define-macro (py-pow-strX-bintY-inline x-430 y-431)
  `(py-pow-strX-bintY-fallback ,x-430 ,y-431))

(define-macro (py-pow-sintX-floatY-inline x-432 y-433)
  `(let ((x-432 ,x-432) (y-433 ,y-433))
     (py-float-from-scheme
      (py** (py-sint-to-scheme x-432) (py-float-to-scheme y-433)))))

(define-macro (py-pow-sintX-boolY-inline x-434 y-435)
  `(py-pow-sintX-boolY-fallback ,x-434 ,y-435))

(define-macro (py-pow-sintX-strY-inline x-436 y-437)
  `(py-pow-sintX-strY-fallback ,x-436 ,y-437))

(define-macro (py-pow-sintX-sintY-inline x-438 y-439)
  `(let ((x-438 ,x-438) (y-439 ,y-439))
     (py-int-from-scheme
      (py** (py-sint-to-scheme x-438) (py-sint-to-scheme y-439)))))

(define-macro (py-pow-sintX-bintY-inline x-440 y-441)
  `(py-pow-sintX-bintY-fallback ,x-440 ,y-441))

(define-macro (py-pow-bintX-floatY-inline x-442 y-443)
  `(py-pow-bintX-floatY-fallback ,x-442 ,y-443))

(define-macro (py-pow-bintX-boolY-inline x-444 y-445)
  `(py-pow-bintX-boolY-fallback ,x-444 ,y-445))

(define-macro (py-pow-bintX-strY-inline x-446 y-447)
  `(py-pow-bintX-strY-fallback ,x-446 ,y-447))

(define-macro (py-pow-bintX-sintY-inline x-448 y-449)
  `(py-pow-bintX-sintY-fallback ,x-448 ,y-449))

(define-macro (py-pow-bintX-bintY-inline x-450 y-451)
  `(py-pow-bintX-bintY-fallback ,x-450 ,y-451))

(define-macro (py-rshift-floatX-floatY-inline x-452 y-453)
  `(let ((x-452 ,x-452) (y-453 ,y-453))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for >>: 'float' and 'float'")))))

(define-macro (py-rshift-floatX-boolY-inline x-454 y-455)
  `(py-rshift-floatX-boolY-fallback ,x-454 ,y-455))

(define-macro (py-rshift-floatX-strY-inline x-456 y-457)
  `(py-rshift-floatX-strY-fallback ,x-456 ,y-457))

(define-macro (py-rshift-floatX-sintY-inline x-458 y-459)
  `(let ((x-458 ,x-458) (y-459 ,y-459))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for >>: 'float' and 'int'")))))

(define-macro (py-rshift-floatX-bintY-inline x-460 y-461)
  `(py-rshift-floatX-bintY-fallback ,x-460 ,y-461))

(define-macro (py-rshift-boolX-floatY-inline x-462 y-463)
  `(py-rshift-boolX-floatY-fallback ,x-462 ,y-463))

(define-macro (py-rshift-boolX-boolY-inline x-464 y-465)
  `(py-rshift-boolX-boolY-fallback ,x-464 ,y-465))

(define-macro (py-rshift-boolX-strY-inline x-466 y-467)
  `(py-rshift-boolX-strY-fallback ,x-466 ,y-467))

(define-macro (py-rshift-boolX-sintY-inline x-468 y-469)
  `(py-rshift-boolX-sintY-fallback ,x-468 ,y-469))

(define-macro (py-rshift-boolX-bintY-inline x-470 y-471)
  `(py-rshift-boolX-bintY-fallback ,x-470 ,y-471))

(define-macro (py-rshift-strX-floatY-inline x-472 y-473)
  `(py-rshift-strX-floatY-fallback ,x-472 ,y-473))

(define-macro (py-rshift-strX-boolY-inline x-474 y-475)
  `(py-rshift-strX-boolY-fallback ,x-474 ,y-475))

(define-macro (py-rshift-strX-strY-inline x-476 y-477)
  `(py-rshift-strX-strY-fallback ,x-476 ,y-477))

(define-macro (py-rshift-strX-sintY-inline x-478 y-479)
  `(py-rshift-strX-sintY-fallback ,x-478 ,y-479))

(define-macro (py-rshift-strX-bintY-inline x-480 y-481)
  `(py-rshift-strX-bintY-fallback ,x-480 ,y-481))

(define-macro (py-rshift-sintX-floatY-inline x-482 y-483)
  `(let ((x-482 ,x-482) (y-483 ,y-483))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for >>: 'int' and 'float'")))))

(define-macro (py-rshift-sintX-boolY-inline x-484 y-485)
  `(py-rshift-sintX-boolY-fallback ,x-484 ,y-485))

(define-macro (py-rshift-sintX-strY-inline x-486 y-487)
  `(py-rshift-sintX-strY-fallback ,x-486 ,y-487))

(define-macro (py-rshift-sintX-sintY-inline x-488 y-489)
  `(let ((x-488 ,x-488) (y-489 ,y-489))
     (if (py-test (py-bool-from-scheme-bool
                   (py-test-from-scheme (py>= (py-sint-to-scheme y-489) 0))))
         (py-int-from-scheme
          (py>> (py-sint-to-scheme x-488) (py-sint-to-scheme y-489)))
         (py-throw
          (py-call py-builtin-ValueError (&& "negative shift count"))))))

(define-macro (py-rshift-sintX-bintY-inline x-490 y-491)
  `(py-rshift-sintX-bintY-fallback ,x-490 ,y-491))

(define-macro (py-rshift-bintX-floatY-inline x-492 y-493)
  `(py-rshift-bintX-floatY-fallback ,x-492 ,y-493))

(define-macro (py-rshift-bintX-boolY-inline x-494 y-495)
  `(py-rshift-bintX-boolY-fallback ,x-494 ,y-495))

(define-macro (py-rshift-bintX-strY-inline x-496 y-497)
  `(py-rshift-bintX-strY-fallback ,x-496 ,y-497))

(define-macro (py-rshift-bintX-sintY-inline x-498 y-499)
  `(py-rshift-bintX-sintY-fallback ,x-498 ,y-499))

(define-macro (py-rshift-bintX-bintY-inline x-500 y-501)
  `(py-rshift-bintX-bintY-fallback ,x-500 ,y-501))

(define-macro (py-sub-floatX-floatY-inline x-502 y-503)
  `(let ((x-502 ,x-502) (y-503 ,y-503))
     (py-float-from-scheme
      (py- (py-float-to-scheme x-502) (py-float-to-scheme y-503)))))

(define-macro (py-sub-floatX-boolY-inline x-504 y-505)
  `(py-sub-floatX-boolY-fallback ,x-504 ,y-505))

(define-macro (py-sub-floatX-strY-inline x-506 y-507)
  `(py-sub-floatX-strY-fallback ,x-506 ,y-507))

(define-macro (py-sub-floatX-sintY-inline x-508 y-509)
  `(let ((x-508 ,x-508) (y-509 ,y-509))
     (py-float-from-scheme
      (py- (py-float-to-scheme x-508) (py-sint-to-scheme y-509)))))

(define-macro (py-sub-floatX-bintY-inline x-510 y-511)
  `(py-sub-floatX-bintY-fallback ,x-510 ,y-511))

(define-macro (py-sub-boolX-floatY-inline x-512 y-513)
  `(py-sub-boolX-floatY-fallback ,x-512 ,y-513))

(define-macro (py-sub-boolX-boolY-inline x-514 y-515)
  `(py-sub-boolX-boolY-fallback ,x-514 ,y-515))

(define-macro (py-sub-boolX-strY-inline x-516 y-517)
  `(py-sub-boolX-strY-fallback ,x-516 ,y-517))

(define-macro (py-sub-boolX-sintY-inline x-518 y-519)
  `(py-sub-boolX-sintY-fallback ,x-518 ,y-519))

(define-macro (py-sub-boolX-bintY-inline x-520 y-521)
  `(py-sub-boolX-bintY-fallback ,x-520 ,y-521))

(define-macro (py-sub-strX-floatY-inline x-522 y-523)
  `(py-sub-strX-floatY-fallback ,x-522 ,y-523))

(define-macro (py-sub-strX-boolY-inline x-524 y-525)
  `(py-sub-strX-boolY-fallback ,x-524 ,y-525))

(define-macro (py-sub-strX-strY-inline x-526 y-527)
  `(py-sub-strX-strY-fallback ,x-526 ,y-527))

(define-macro (py-sub-strX-sintY-inline x-528 y-529)
  `(py-sub-strX-sintY-fallback ,x-528 ,y-529))

(define-macro (py-sub-strX-bintY-inline x-530 y-531)
  `(py-sub-strX-bintY-fallback ,x-530 ,y-531))

(define-macro (py-sub-sintX-floatY-inline x-532 y-533)
  `(let ((x-532 ,x-532) (y-533 ,y-533))
     (py-float-from-scheme
      (py- (py-sint-to-scheme x-532) (py-float-to-scheme y-533)))))

(define-macro (py-sub-sintX-boolY-inline x-534 y-535)
  `(py-sub-sintX-boolY-fallback ,x-534 ,y-535))

(define-macro (py-sub-sintX-strY-inline x-536 y-537)
  `(py-sub-sintX-strY-fallback ,x-536 ,y-537))

(define-macro (py-sub-sintX-sintY-inline x-538 y-539)
  `(let ((x-538 ,x-538) (y-539 ,y-539))
     (py-int-from-scheme
      (py- (py-sint-to-scheme x-538) (py-sint-to-scheme y-539)))))

(define-macro (py-sub-sintX-bintY-inline x-540 y-541)
  `(py-sub-sintX-bintY-fallback ,x-540 ,y-541))

(define-macro (py-sub-bintX-floatY-inline x-542 y-543)
  `(py-sub-bintX-floatY-fallback ,x-542 ,y-543))

(define-macro (py-sub-bintX-boolY-inline x-544 y-545)
  `(py-sub-bintX-boolY-fallback ,x-544 ,y-545))

(define-macro (py-sub-bintX-strY-inline x-546 y-547)
  `(py-sub-bintX-strY-fallback ,x-546 ,y-547))

(define-macro (py-sub-bintX-sintY-inline x-548 y-549)
  `(py-sub-bintX-sintY-fallback ,x-548 ,y-549))

(define-macro (py-sub-bintX-bintY-inline x-550 y-551)
  `(py-sub-bintX-bintY-fallback ,x-550 ,y-551))

(define-macro (py-truediv-floatX-floatY-inline x-552 y-553)
  `(let ((x-552 ,x-552) (y-553 ,y-553))
     (if (py-test (py-bool-from-scheme-bool
                   (py-test-from-scheme (py!= (py-float-to-scheme y-553) 0.))))
         (py-float-from-scheme
          (py/ (py-float-to-scheme x-552) (py-float-to-scheme y-553)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-truediv-floatX-boolY-inline x-554 y-555)
  `(py-truediv-floatX-boolY-fallback ,x-554 ,y-555))

(define-macro (py-truediv-floatX-strY-inline x-556 y-557)
  `(py-truediv-floatX-strY-fallback ,x-556 ,y-557))

(define-macro (py-truediv-floatX-sintY-inline x-558 y-559)
  `(let ((x-558 ,x-558) (y-559 ,y-559))
     (if (py-test (py-bool-from-scheme-bool
                   (py-test-from-scheme (py!= (py-sint-to-scheme y-559) 0))))
         (py-float-from-scheme
          (py/ (py-float-to-scheme x-558) (py-sint-to-scheme y-559)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-truediv-floatX-bintY-inline x-560 y-561)
  `(py-truediv-floatX-bintY-fallback ,x-560 ,y-561))

(define-macro (py-truediv-boolX-floatY-inline x-562 y-563)
  `(py-truediv-boolX-floatY-fallback ,x-562 ,y-563))

(define-macro (py-truediv-boolX-boolY-inline x-564 y-565)
  `(py-truediv-boolX-boolY-fallback ,x-564 ,y-565))

(define-macro (py-truediv-boolX-strY-inline x-566 y-567)
  `(py-truediv-boolX-strY-fallback ,x-566 ,y-567))

(define-macro (py-truediv-boolX-sintY-inline x-568 y-569)
  `(py-truediv-boolX-sintY-fallback ,x-568 ,y-569))

(define-macro (py-truediv-boolX-bintY-inline x-570 y-571)
  `(py-truediv-boolX-bintY-fallback ,x-570 ,y-571))

(define-macro (py-truediv-strX-floatY-inline x-572 y-573)
  `(py-truediv-strX-floatY-fallback ,x-572 ,y-573))

(define-macro (py-truediv-strX-boolY-inline x-574 y-575)
  `(py-truediv-strX-boolY-fallback ,x-574 ,y-575))

(define-macro (py-truediv-strX-strY-inline x-576 y-577)
  `(py-truediv-strX-strY-fallback ,x-576 ,y-577))

(define-macro (py-truediv-strX-sintY-inline x-578 y-579)
  `(py-truediv-strX-sintY-fallback ,x-578 ,y-579))

(define-macro (py-truediv-strX-bintY-inline x-580 y-581)
  `(py-truediv-strX-bintY-fallback ,x-580 ,y-581))

(define-macro (py-truediv-sintX-floatY-inline x-582 y-583)
  `(let ((x-582 ,x-582) (y-583 ,y-583))
     (if (py-test (py-bool-from-scheme-bool
                   (py-test-from-scheme (py!= (py-float-to-scheme y-583) 0.))))
         (py-float-from-scheme
          (py/ (py-sint-to-scheme x-582) (py-float-to-scheme y-583)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-truediv-sintX-boolY-inline x-584 y-585)
  `(py-truediv-sintX-boolY-fallback ,x-584 ,y-585))

(define-macro (py-truediv-sintX-strY-inline x-586 y-587)
  `(py-truediv-sintX-strY-fallback ,x-586 ,y-587))

(define-macro (py-truediv-sintX-sintY-inline x-588 y-589)
  `(let ((x-588 ,x-588) (y-589 ,y-589))
     (if (py-test (py-bool-from-scheme-bool
                   (py-test-from-scheme (py!= (py-sint-to-scheme y-589) 0))))
         (py-float-from-scheme
          (py/ (py-sint-to-scheme x-588) (py-sint-to-scheme y-589)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError (&& "division by zero"))))))

(define-macro (py-truediv-sintX-bintY-inline x-590 y-591)
  `(py-truediv-sintX-bintY-fallback ,x-590 ,y-591))

(define-macro (py-truediv-bintX-floatY-inline x-592 y-593)
  `(py-truediv-bintX-floatY-fallback ,x-592 ,y-593))

(define-macro (py-truediv-bintX-boolY-inline x-594 y-595)
  `(py-truediv-bintX-boolY-fallback ,x-594 ,y-595))

(define-macro (py-truediv-bintX-strY-inline x-596 y-597)
  `(py-truediv-bintX-strY-fallback ,x-596 ,y-597))

(define-macro (py-truediv-bintX-sintY-inline x-598 y-599)
  `(py-truediv-bintX-sintY-fallback ,x-598 ,y-599))

(define-macro (py-truediv-bintX-bintY-inline x-600 y-601)
  `(py-truediv-bintX-bintY-fallback ,x-600 ,y-601))

(define-macro (py-xor-floatX-floatY-inline x-602 y-603)
  `(let ((x-602 ,x-602) (y-603 ,y-603))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for ^: 'float' and 'float'")))))

(define-macro (py-xor-floatX-boolY-inline x-604 y-605)
  `(py-xor-floatX-boolY-fallback ,x-604 ,y-605))

(define-macro (py-xor-floatX-strY-inline x-606 y-607)
  `(py-xor-floatX-strY-fallback ,x-606 ,y-607))

(define-macro (py-xor-floatX-sintY-inline x-608 y-609)
  `(let ((x-608 ,x-608) (y-609 ,y-609))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for ^: 'float' and 'int'")))))

(define-macro (py-xor-floatX-bintY-inline x-610 y-611)
  `(py-xor-floatX-bintY-fallback ,x-610 ,y-611))

(define-macro (py-xor-boolX-floatY-inline x-612 y-613)
  `(py-xor-boolX-floatY-fallback ,x-612 ,y-613))

(define-macro (py-xor-boolX-boolY-inline x-614 y-615)
  `(py-xor-boolX-boolY-fallback ,x-614 ,y-615))

(define-macro (py-xor-boolX-strY-inline x-616 y-617)
  `(py-xor-boolX-strY-fallback ,x-616 ,y-617))

(define-macro (py-xor-boolX-sintY-inline x-618 y-619)
  `(py-xor-boolX-sintY-fallback ,x-618 ,y-619))

(define-macro (py-xor-boolX-bintY-inline x-620 y-621)
  `(py-xor-boolX-bintY-fallback ,x-620 ,y-621))

(define-macro (py-xor-strX-floatY-inline x-622 y-623)
  `(py-xor-strX-floatY-fallback ,x-622 ,y-623))

(define-macro (py-xor-strX-boolY-inline x-624 y-625)
  `(py-xor-strX-boolY-fallback ,x-624 ,y-625))

(define-macro (py-xor-strX-strY-inline x-626 y-627)
  `(py-xor-strX-strY-fallback ,x-626 ,y-627))

(define-macro (py-xor-strX-sintY-inline x-628 y-629)
  `(py-xor-strX-sintY-fallback ,x-628 ,y-629))

(define-macro (py-xor-strX-bintY-inline x-630 y-631)
  `(py-xor-strX-bintY-fallback ,x-630 ,y-631))

(define-macro (py-xor-sintX-floatY-inline x-632 y-633)
  `(let ((x-632 ,x-632) (y-633 ,y-633))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for ^: 'int' and 'float'")))))

(define-macro (py-xor-sintX-boolY-inline x-634 y-635)
  `(py-xor-sintX-boolY-fallback ,x-634 ,y-635))

(define-macro (py-xor-sintX-strY-inline x-636 y-637)
  `(py-xor-sintX-strY-fallback ,x-636 ,y-637))

(define-macro (py-xor-sintX-sintY-inline x-638 y-639)
  `(let ((x-638 ,x-638) (y-639 ,y-639))
     (py-int-from-scheme
      (py^ (py-sint-to-scheme x-638) (py-sint-to-scheme y-639)))))

(define-macro (py-xor-sintX-bintY-inline x-640 y-641)
  `(py-xor-sintX-bintY-fallback ,x-640 ,y-641))

(define-macro (py-xor-bintX-floatY-inline x-642 y-643)
  `(py-xor-bintX-floatY-fallback ,x-642 ,y-643))

(define-macro (py-xor-bintX-boolY-inline x-644 y-645)
  `(py-xor-bintX-boolY-fallback ,x-644 ,y-645))

(define-macro (py-xor-bintX-strY-inline x-646 y-647)
  `(py-xor-bintX-strY-fallback ,x-646 ,y-647))

(define-macro (py-xor-bintX-sintY-inline x-648 y-649)
  `(py-xor-bintX-sintY-fallback ,x-648 ,y-649))

(define-macro (py-xor-bintX-bintY-inline x-650 y-651)
  `(py-xor-bintX-bintY-fallback ,x-650 ,y-651))

(define-macro (py-iadd-floatX-floatY-inline x-652 y-653)
  `(let ((x-652 ,x-652) (y-653 ,y-653))
     (py-float-from-scheme
      (py+ (py-float-to-scheme x-652) (py-float-to-scheme y-653)))))

(define-macro (py-iadd-floatX-boolY-inline x-654 y-655)
  `(py-iadd-floatX-boolY-fallback ,x-654 ,y-655))

(define-macro (py-iadd-floatX-strY-inline x-656 y-657)
  `(py-iadd-floatX-strY-fallback ,x-656 ,y-657))

(define-macro (py-iadd-floatX-sintY-inline x-658 y-659)
  `(let ((x-658 ,x-658) (y-659 ,y-659))
     (py-float-from-scheme
      (py+ (py-float-to-scheme x-658) (py-sint-to-scheme y-659)))))

(define-macro (py-iadd-floatX-bintY-inline x-660 y-661)
  `(py-iadd-floatX-bintY-fallback ,x-660 ,y-661))

(define-macro (py-iadd-boolX-floatY-inline x-662 y-663)
  `(py-iadd-boolX-floatY-fallback ,x-662 ,y-663))

(define-macro (py-iadd-boolX-boolY-inline x-664 y-665)
  `(py-iadd-boolX-boolY-fallback ,x-664 ,y-665))

(define-macro (py-iadd-boolX-strY-inline x-666 y-667)
  `(py-iadd-boolX-strY-fallback ,x-666 ,y-667))

(define-macro (py-iadd-boolX-sintY-inline x-668 y-669)
  `(py-iadd-boolX-sintY-fallback ,x-668 ,y-669))

(define-macro (py-iadd-boolX-bintY-inline x-670 y-671)
  `(py-iadd-boolX-bintY-fallback ,x-670 ,y-671))

(define-macro (py-iadd-strX-floatY-inline x-672 y-673)
  `(py-iadd-strX-floatY-fallback ,x-672 ,y-673))

(define-macro (py-iadd-strX-boolY-inline x-674 y-675)
  `(py-iadd-strX-boolY-fallback ,x-674 ,y-675))

(define-macro (py-iadd-strX-strY-inline x-676 y-677)
  `(py-iadd-strX-strY-fallback ,x-676 ,y-677))

(define-macro (py-iadd-strX-sintY-inline x-678 y-679)
  `(py-iadd-strX-sintY-fallback ,x-678 ,y-679))

(define-macro (py-iadd-strX-bintY-inline x-680 y-681)
  `(py-iadd-strX-bintY-fallback ,x-680 ,y-681))

(define-macro (py-iadd-sintX-floatY-inline x-682 y-683)
  `(let ((x-682 ,x-682) (y-683 ,y-683))
     (py-float-from-scheme
      (py+ (py-sint-to-scheme x-682) (py-float-to-scheme y-683)))))

(define-macro (py-iadd-sintX-boolY-inline x-684 y-685)
  `(py-iadd-sintX-boolY-fallback ,x-684 ,y-685))

(define-macro (py-iadd-sintX-strY-inline x-686 y-687)
  `(py-iadd-sintX-strY-fallback ,x-686 ,y-687))

(define-macro (py-iadd-sintX-sintY-inline x-688 y-689)
  `(let ((x-688 ,x-688) (y-689 ,y-689))
     (py-int-from-scheme
      (py+ (py-sint-to-scheme x-688) (py-sint-to-scheme y-689)))))

(define-macro (py-iadd-sintX-bintY-inline x-690 y-691)
  `(py-iadd-sintX-bintY-fallback ,x-690 ,y-691))

(define-macro (py-iadd-bintX-floatY-inline x-692 y-693)
  `(py-iadd-bintX-floatY-fallback ,x-692 ,y-693))

(define-macro (py-iadd-bintX-boolY-inline x-694 y-695)
  `(py-iadd-bintX-boolY-fallback ,x-694 ,y-695))

(define-macro (py-iadd-bintX-strY-inline x-696 y-697)
  `(py-iadd-bintX-strY-fallback ,x-696 ,y-697))

(define-macro (py-iadd-bintX-sintY-inline x-698 y-699)
  `(py-iadd-bintX-sintY-fallback ,x-698 ,y-699))

(define-macro (py-iadd-bintX-bintY-inline x-700 y-701)
  `(py-iadd-bintX-bintY-fallback ,x-700 ,y-701))

(define-macro (py-ibitand-floatX-floatY-inline x-702 y-703)
  `(let ((x-702 ,x-702) (y-703 ,y-703))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for &=: 'float' and 'float'")))))

(define-macro (py-ibitand-floatX-boolY-inline x-704 y-705)
  `(py-ibitand-floatX-boolY-fallback ,x-704 ,y-705))

(define-macro (py-ibitand-floatX-strY-inline x-706 y-707)
  `(py-ibitand-floatX-strY-fallback ,x-706 ,y-707))

(define-macro (py-ibitand-floatX-sintY-inline x-708 y-709)
  `(let ((x-708 ,x-708) (y-709 ,y-709))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for &=: 'float' and 'int'")))))

(define-macro (py-ibitand-floatX-bintY-inline x-710 y-711)
  `(py-ibitand-floatX-bintY-fallback ,x-710 ,y-711))

(define-macro (py-ibitand-boolX-floatY-inline x-712 y-713)
  `(py-ibitand-boolX-floatY-fallback ,x-712 ,y-713))

(define-macro (py-ibitand-boolX-boolY-inline x-714 y-715)
  `(py-ibitand-boolX-boolY-fallback ,x-714 ,y-715))

(define-macro (py-ibitand-boolX-strY-inline x-716 y-717)
  `(py-ibitand-boolX-strY-fallback ,x-716 ,y-717))

(define-macro (py-ibitand-boolX-sintY-inline x-718 y-719)
  `(py-ibitand-boolX-sintY-fallback ,x-718 ,y-719))

(define-macro (py-ibitand-boolX-bintY-inline x-720 y-721)
  `(py-ibitand-boolX-bintY-fallback ,x-720 ,y-721))

(define-macro (py-ibitand-strX-floatY-inline x-722 y-723)
  `(py-ibitand-strX-floatY-fallback ,x-722 ,y-723))

(define-macro (py-ibitand-strX-boolY-inline x-724 y-725)
  `(py-ibitand-strX-boolY-fallback ,x-724 ,y-725))

(define-macro (py-ibitand-strX-strY-inline x-726 y-727)
  `(py-ibitand-strX-strY-fallback ,x-726 ,y-727))

(define-macro (py-ibitand-strX-sintY-inline x-728 y-729)
  `(py-ibitand-strX-sintY-fallback ,x-728 ,y-729))

(define-macro (py-ibitand-strX-bintY-inline x-730 y-731)
  `(py-ibitand-strX-bintY-fallback ,x-730 ,y-731))

(define-macro (py-ibitand-sintX-floatY-inline x-732 y-733)
  `(let ((x-732 ,x-732) (y-733 ,y-733))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for &=: 'int' and 'float'")))))

(define-macro (py-ibitand-sintX-boolY-inline x-734 y-735)
  `(py-ibitand-sintX-boolY-fallback ,x-734 ,y-735))

(define-macro (py-ibitand-sintX-strY-inline x-736 y-737)
  `(py-ibitand-sintX-strY-fallback ,x-736 ,y-737))

(define-macro (py-ibitand-sintX-sintY-inline x-738 y-739)
  `(let ((x-738 ,x-738) (y-739 ,y-739))
     (py-int-from-scheme
      (py& (py-sint-to-scheme x-738) (py-sint-to-scheme y-739)))))

(define-macro (py-ibitand-sintX-bintY-inline x-740 y-741)
  `(py-ibitand-sintX-bintY-fallback ,x-740 ,y-741))

(define-macro (py-ibitand-bintX-floatY-inline x-742 y-743)
  `(py-ibitand-bintX-floatY-fallback ,x-742 ,y-743))

(define-macro (py-ibitand-bintX-boolY-inline x-744 y-745)
  `(py-ibitand-bintX-boolY-fallback ,x-744 ,y-745))

(define-macro (py-ibitand-bintX-strY-inline x-746 y-747)
  `(py-ibitand-bintX-strY-fallback ,x-746 ,y-747))

(define-macro (py-ibitand-bintX-sintY-inline x-748 y-749)
  `(py-ibitand-bintX-sintY-fallback ,x-748 ,y-749))

(define-macro (py-ibitand-bintX-bintY-inline x-750 y-751)
  `(py-ibitand-bintX-bintY-fallback ,x-750 ,y-751))

(define-macro (py-ibitor-floatX-floatY-inline x-752 y-753)
  `(let ((x-752 ,x-752) (y-753 ,y-753))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for |=: 'float' and 'float'")))))

(define-macro (py-ibitor-floatX-boolY-inline x-754 y-755)
  `(py-ibitor-floatX-boolY-fallback ,x-754 ,y-755))

(define-macro (py-ibitor-floatX-strY-inline x-756 y-757)
  `(py-ibitor-floatX-strY-fallback ,x-756 ,y-757))

(define-macro (py-ibitor-floatX-sintY-inline x-758 y-759)
  `(let ((x-758 ,x-758) (y-759 ,y-759))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for |=: 'float' and 'int'")))))

(define-macro (py-ibitor-floatX-bintY-inline x-760 y-761)
  `(py-ibitor-floatX-bintY-fallback ,x-760 ,y-761))

(define-macro (py-ibitor-boolX-floatY-inline x-762 y-763)
  `(py-ibitor-boolX-floatY-fallback ,x-762 ,y-763))

(define-macro (py-ibitor-boolX-boolY-inline x-764 y-765)
  `(py-ibitor-boolX-boolY-fallback ,x-764 ,y-765))

(define-macro (py-ibitor-boolX-strY-inline x-766 y-767)
  `(py-ibitor-boolX-strY-fallback ,x-766 ,y-767))

(define-macro (py-ibitor-boolX-sintY-inline x-768 y-769)
  `(py-ibitor-boolX-sintY-fallback ,x-768 ,y-769))

(define-macro (py-ibitor-boolX-bintY-inline x-770 y-771)
  `(py-ibitor-boolX-bintY-fallback ,x-770 ,y-771))

(define-macro (py-ibitor-strX-floatY-inline x-772 y-773)
  `(py-ibitor-strX-floatY-fallback ,x-772 ,y-773))

(define-macro (py-ibitor-strX-boolY-inline x-774 y-775)
  `(py-ibitor-strX-boolY-fallback ,x-774 ,y-775))

(define-macro (py-ibitor-strX-strY-inline x-776 y-777)
  `(py-ibitor-strX-strY-fallback ,x-776 ,y-777))

(define-macro (py-ibitor-strX-sintY-inline x-778 y-779)
  `(py-ibitor-strX-sintY-fallback ,x-778 ,y-779))

(define-macro (py-ibitor-strX-bintY-inline x-780 y-781)
  `(py-ibitor-strX-bintY-fallback ,x-780 ,y-781))

(define-macro (py-ibitor-sintX-floatY-inline x-782 y-783)
  `(let ((x-782 ,x-782) (y-783 ,y-783))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for |=: 'int' and 'float'")))))

(define-macro (py-ibitor-sintX-boolY-inline x-784 y-785)
  `(py-ibitor-sintX-boolY-fallback ,x-784 ,y-785))

(define-macro (py-ibitor-sintX-strY-inline x-786 y-787)
  `(py-ibitor-sintX-strY-fallback ,x-786 ,y-787))

(define-macro (py-ibitor-sintX-sintY-inline x-788 y-789)
  `(let ((x-788 ,x-788) (y-789 ,y-789))
     (py-int-from-scheme
      (py+b (py-sint-to-scheme x-788) (py-sint-to-scheme y-789)))))

(define-macro (py-ibitor-sintX-bintY-inline x-790 y-791)
  `(py-ibitor-sintX-bintY-fallback ,x-790 ,y-791))

(define-macro (py-ibitor-bintX-floatY-inline x-792 y-793)
  `(py-ibitor-bintX-floatY-fallback ,x-792 ,y-793))

(define-macro (py-ibitor-bintX-boolY-inline x-794 y-795)
  `(py-ibitor-bintX-boolY-fallback ,x-794 ,y-795))

(define-macro (py-ibitor-bintX-strY-inline x-796 y-797)
  `(py-ibitor-bintX-strY-fallback ,x-796 ,y-797))

(define-macro (py-ibitor-bintX-sintY-inline x-798 y-799)
  `(py-ibitor-bintX-sintY-fallback ,x-798 ,y-799))

(define-macro (py-ibitor-bintX-bintY-inline x-800 y-801)
  `(py-ibitor-bintX-bintY-fallback ,x-800 ,y-801))

(define-macro (py-ifloordiv-floatX-floatY-inline x-802 y-803)
  `(let ((x-802 ,x-802) (y-803 ,y-803))
     (if (py-test (py-bool-from-scheme-bool
                   (py-test-from-scheme (py!= (py-float-to-scheme y-803) 0.))))
         (py-float-from-scheme
          (py// (py-float-to-scheme x-802) (py-float-to-scheme y-803)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-ifloordiv-floatX-boolY-inline x-804 y-805)
  `(py-ifloordiv-floatX-boolY-fallback ,x-804 ,y-805))

(define-macro (py-ifloordiv-floatX-strY-inline x-806 y-807)
  `(py-ifloordiv-floatX-strY-fallback ,x-806 ,y-807))

(define-macro (py-ifloordiv-floatX-sintY-inline x-808 y-809)
  `(let ((x-808 ,x-808) (y-809 ,y-809))
     (if (py-test (py-bool-from-scheme-bool
                   (py-test-from-scheme (py!= (py-sint-to-scheme y-809) 0))))
         (py-float-from-scheme
          (py// (py-float-to-scheme x-808) (py-sint-to-scheme y-809)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-ifloordiv-floatX-bintY-inline x-810 y-811)
  `(py-ifloordiv-floatX-bintY-fallback ,x-810 ,y-811))

(define-macro (py-ifloordiv-boolX-floatY-inline x-812 y-813)
  `(py-ifloordiv-boolX-floatY-fallback ,x-812 ,y-813))

(define-macro (py-ifloordiv-boolX-boolY-inline x-814 y-815)
  `(py-ifloordiv-boolX-boolY-fallback ,x-814 ,y-815))

(define-macro (py-ifloordiv-boolX-strY-inline x-816 y-817)
  `(py-ifloordiv-boolX-strY-fallback ,x-816 ,y-817))

(define-macro (py-ifloordiv-boolX-sintY-inline x-818 y-819)
  `(py-ifloordiv-boolX-sintY-fallback ,x-818 ,y-819))

(define-macro (py-ifloordiv-boolX-bintY-inline x-820 y-821)
  `(py-ifloordiv-boolX-bintY-fallback ,x-820 ,y-821))

(define-macro (py-ifloordiv-strX-floatY-inline x-822 y-823)
  `(py-ifloordiv-strX-floatY-fallback ,x-822 ,y-823))

(define-macro (py-ifloordiv-strX-boolY-inline x-824 y-825)
  `(py-ifloordiv-strX-boolY-fallback ,x-824 ,y-825))

(define-macro (py-ifloordiv-strX-strY-inline x-826 y-827)
  `(py-ifloordiv-strX-strY-fallback ,x-826 ,y-827))

(define-macro (py-ifloordiv-strX-sintY-inline x-828 y-829)
  `(py-ifloordiv-strX-sintY-fallback ,x-828 ,y-829))

(define-macro (py-ifloordiv-strX-bintY-inline x-830 y-831)
  `(py-ifloordiv-strX-bintY-fallback ,x-830 ,y-831))

(define-macro (py-ifloordiv-sintX-floatY-inline x-832 y-833)
  `(let ((x-832 ,x-832) (y-833 ,y-833))
     (if (py-test (py-bool-from-scheme-bool
                   (py-test-from-scheme (py!= (py-float-to-scheme y-833) 0.))))
         (py-float-from-scheme
          (py// (py-sint-to-scheme x-832) (py-float-to-scheme y-833)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-ifloordiv-sintX-boolY-inline x-834 y-835)
  `(py-ifloordiv-sintX-boolY-fallback ,x-834 ,y-835))

(define-macro (py-ifloordiv-sintX-strY-inline x-836 y-837)
  `(py-ifloordiv-sintX-strY-fallback ,x-836 ,y-837))

(define-macro (py-ifloordiv-sintX-sintY-inline x-838 y-839)
  `(let ((x-838 ,x-838) (y-839 ,y-839))
     (if (py-test (py-bool-from-scheme-bool
                   (py-test-from-scheme (py!= (py-sint-to-scheme y-839) 0))))
         (py-int-from-scheme
          (py// (py-sint-to-scheme x-838) (py-sint-to-scheme y-839)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "integer division by zero"))))))

(define-macro (py-ifloordiv-sintX-bintY-inline x-840 y-841)
  `(py-ifloordiv-sintX-bintY-fallback ,x-840 ,y-841))

(define-macro (py-ifloordiv-bintX-floatY-inline x-842 y-843)
  `(py-ifloordiv-bintX-floatY-fallback ,x-842 ,y-843))

(define-macro (py-ifloordiv-bintX-boolY-inline x-844 y-845)
  `(py-ifloordiv-bintX-boolY-fallback ,x-844 ,y-845))

(define-macro (py-ifloordiv-bintX-strY-inline x-846 y-847)
  `(py-ifloordiv-bintX-strY-fallback ,x-846 ,y-847))

(define-macro (py-ifloordiv-bintX-sintY-inline x-848 y-849)
  `(py-ifloordiv-bintX-sintY-fallback ,x-848 ,y-849))

(define-macro (py-ifloordiv-bintX-bintY-inline x-850 y-851)
  `(py-ifloordiv-bintX-bintY-fallback ,x-850 ,y-851))

(define-macro (py-ilshift-floatX-floatY-inline x-852 y-853)
  `(let ((x-852 ,x-852) (y-853 ,y-853))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for <<=: 'float' and 'float'")))))

(define-macro (py-ilshift-floatX-boolY-inline x-854 y-855)
  `(py-ilshift-floatX-boolY-fallback ,x-854 ,y-855))

(define-macro (py-ilshift-floatX-strY-inline x-856 y-857)
  `(py-ilshift-floatX-strY-fallback ,x-856 ,y-857))

(define-macro (py-ilshift-floatX-sintY-inline x-858 y-859)
  `(let ((x-858 ,x-858) (y-859 ,y-859))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for <<=: 'float' and 'int'")))))

(define-macro (py-ilshift-floatX-bintY-inline x-860 y-861)
  `(py-ilshift-floatX-bintY-fallback ,x-860 ,y-861))

(define-macro (py-ilshift-boolX-floatY-inline x-862 y-863)
  `(py-ilshift-boolX-floatY-fallback ,x-862 ,y-863))

(define-macro (py-ilshift-boolX-boolY-inline x-864 y-865)
  `(py-ilshift-boolX-boolY-fallback ,x-864 ,y-865))

(define-macro (py-ilshift-boolX-strY-inline x-866 y-867)
  `(py-ilshift-boolX-strY-fallback ,x-866 ,y-867))

(define-macro (py-ilshift-boolX-sintY-inline x-868 y-869)
  `(py-ilshift-boolX-sintY-fallback ,x-868 ,y-869))

(define-macro (py-ilshift-boolX-bintY-inline x-870 y-871)
  `(py-ilshift-boolX-bintY-fallback ,x-870 ,y-871))

(define-macro (py-ilshift-strX-floatY-inline x-872 y-873)
  `(py-ilshift-strX-floatY-fallback ,x-872 ,y-873))

(define-macro (py-ilshift-strX-boolY-inline x-874 y-875)
  `(py-ilshift-strX-boolY-fallback ,x-874 ,y-875))

(define-macro (py-ilshift-strX-strY-inline x-876 y-877)
  `(py-ilshift-strX-strY-fallback ,x-876 ,y-877))

(define-macro (py-ilshift-strX-sintY-inline x-878 y-879)
  `(py-ilshift-strX-sintY-fallback ,x-878 ,y-879))

(define-macro (py-ilshift-strX-bintY-inline x-880 y-881)
  `(py-ilshift-strX-bintY-fallback ,x-880 ,y-881))

(define-macro (py-ilshift-sintX-floatY-inline x-882 y-883)
  `(let ((x-882 ,x-882) (y-883 ,y-883))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for <<=: 'int' and 'float'")))))

(define-macro (py-ilshift-sintX-boolY-inline x-884 y-885)
  `(py-ilshift-sintX-boolY-fallback ,x-884 ,y-885))

(define-macro (py-ilshift-sintX-strY-inline x-886 y-887)
  `(py-ilshift-sintX-strY-fallback ,x-886 ,y-887))

(define-macro (py-ilshift-sintX-sintY-inline x-888 y-889)
  `(let ((x-888 ,x-888) (y-889 ,y-889))
     (if (py-test (py-bool-from-scheme-bool
                   (py-test-from-scheme (py>= (py-sint-to-scheme y-889) 0))))
         (py-int-from-scheme
          (py<< (py-sint-to-scheme x-888) (py-sint-to-scheme y-889)))
         (py-throw
          (py-call py-builtin-ValueError (&& "negative shift count"))))))

(define-macro (py-ilshift-sintX-bintY-inline x-890 y-891)
  `(py-ilshift-sintX-bintY-fallback ,x-890 ,y-891))

(define-macro (py-ilshift-bintX-floatY-inline x-892 y-893)
  `(py-ilshift-bintX-floatY-fallback ,x-892 ,y-893))

(define-macro (py-ilshift-bintX-boolY-inline x-894 y-895)
  `(py-ilshift-bintX-boolY-fallback ,x-894 ,y-895))

(define-macro (py-ilshift-bintX-strY-inline x-896 y-897)
  `(py-ilshift-bintX-strY-fallback ,x-896 ,y-897))

(define-macro (py-ilshift-bintX-sintY-inline x-898 y-899)
  `(py-ilshift-bintX-sintY-fallback ,x-898 ,y-899))

(define-macro (py-ilshift-bintX-bintY-inline x-900 y-901)
  `(py-ilshift-bintX-bintY-fallback ,x-900 ,y-901))

(define-macro (py-imatmul-floatX-floatY-inline x-902 y-903)
  `(let ((x-902 ,x-902) (y-903 ,y-903))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @=: 'float' and 'float'")))))

(define-macro (py-imatmul-floatX-boolY-inline x-904 y-905)
  `(py-imatmul-floatX-boolY-fallback ,x-904 ,y-905))

(define-macro (py-imatmul-floatX-strY-inline x-906 y-907)
  `(py-imatmul-floatX-strY-fallback ,x-906 ,y-907))

(define-macro (py-imatmul-floatX-sintY-inline x-908 y-909)
  `(let ((x-908 ,x-908) (y-909 ,y-909))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @=: 'float' and 'int'")))))

(define-macro (py-imatmul-floatX-bintY-inline x-910 y-911)
  `(py-imatmul-floatX-bintY-fallback ,x-910 ,y-911))

(define-macro (py-imatmul-boolX-floatY-inline x-912 y-913)
  `(py-imatmul-boolX-floatY-fallback ,x-912 ,y-913))

(define-macro (py-imatmul-boolX-boolY-inline x-914 y-915)
  `(py-imatmul-boolX-boolY-fallback ,x-914 ,y-915))

(define-macro (py-imatmul-boolX-strY-inline x-916 y-917)
  `(py-imatmul-boolX-strY-fallback ,x-916 ,y-917))

(define-macro (py-imatmul-boolX-sintY-inline x-918 y-919)
  `(py-imatmul-boolX-sintY-fallback ,x-918 ,y-919))

(define-macro (py-imatmul-boolX-bintY-inline x-920 y-921)
  `(py-imatmul-boolX-bintY-fallback ,x-920 ,y-921))

(define-macro (py-imatmul-strX-floatY-inline x-922 y-923)
  `(py-imatmul-strX-floatY-fallback ,x-922 ,y-923))

(define-macro (py-imatmul-strX-boolY-inline x-924 y-925)
  `(py-imatmul-strX-boolY-fallback ,x-924 ,y-925))

(define-macro (py-imatmul-strX-strY-inline x-926 y-927)
  `(py-imatmul-strX-strY-fallback ,x-926 ,y-927))

(define-macro (py-imatmul-strX-sintY-inline x-928 y-929)
  `(py-imatmul-strX-sintY-fallback ,x-928 ,y-929))

(define-macro (py-imatmul-strX-bintY-inline x-930 y-931)
  `(py-imatmul-strX-bintY-fallback ,x-930 ,y-931))

(define-macro (py-imatmul-sintX-floatY-inline x-932 y-933)
  `(let ((x-932 ,x-932) (y-933 ,y-933))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @=: 'int' and 'float'")))))

(define-macro (py-imatmul-sintX-boolY-inline x-934 y-935)
  `(py-imatmul-sintX-boolY-fallback ,x-934 ,y-935))

(define-macro (py-imatmul-sintX-strY-inline x-936 y-937)
  `(py-imatmul-sintX-strY-fallback ,x-936 ,y-937))

(define-macro (py-imatmul-sintX-sintY-inline x-938 y-939)
  `(let ((x-938 ,x-938) (y-939 ,y-939))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for @=: 'int' and 'int'")))))

(define-macro (py-imatmul-sintX-bintY-inline x-940 y-941)
  `(py-imatmul-sintX-bintY-fallback ,x-940 ,y-941))

(define-macro (py-imatmul-bintX-floatY-inline x-942 y-943)
  `(py-imatmul-bintX-floatY-fallback ,x-942 ,y-943))

(define-macro (py-imatmul-bintX-boolY-inline x-944 y-945)
  `(py-imatmul-bintX-boolY-fallback ,x-944 ,y-945))

(define-macro (py-imatmul-bintX-strY-inline x-946 y-947)
  `(py-imatmul-bintX-strY-fallback ,x-946 ,y-947))

(define-macro (py-imatmul-bintX-sintY-inline x-948 y-949)
  `(py-imatmul-bintX-sintY-fallback ,x-948 ,y-949))

(define-macro (py-imatmul-bintX-bintY-inline x-950 y-951)
  `(py-imatmul-bintX-bintY-fallback ,x-950 ,y-951))

(define-macro (py-imod-floatX-floatY-inline x-952 y-953)
  `(let ((x-952 ,x-952) (y-953 ,y-953))
     (if (py-test (py-bool-from-scheme-bool
                   (py-test-from-scheme (py!= (py-float-to-scheme y-953) 0.))))
         (py-float-from-scheme
          (py% (py-float-to-scheme x-952) (py-float-to-scheme y-953)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float modulo by zero"))))))

(define-macro (py-imod-floatX-boolY-inline x-954 y-955)
  `(py-imod-floatX-boolY-fallback ,x-954 ,y-955))

(define-macro (py-imod-floatX-strY-inline x-956 y-957)
  `(py-imod-floatX-strY-fallback ,x-956 ,y-957))

(define-macro (py-imod-floatX-sintY-inline x-958 y-959)
  `(let ((x-958 ,x-958) (y-959 ,y-959))
     (if (py-test (py-bool-from-scheme-bool
                   (py-test-from-scheme (py!= (py-sint-to-scheme y-959) 0))))
         (py-float-from-scheme
          (py% (py-float-to-scheme x-958) (py-sint-to-scheme y-959)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float modulo by zero"))))))

(define-macro (py-imod-floatX-bintY-inline x-960 y-961)
  `(py-imod-floatX-bintY-fallback ,x-960 ,y-961))

(define-macro (py-imod-boolX-floatY-inline x-962 y-963)
  `(py-imod-boolX-floatY-fallback ,x-962 ,y-963))

(define-macro (py-imod-boolX-boolY-inline x-964 y-965)
  `(py-imod-boolX-boolY-fallback ,x-964 ,y-965))

(define-macro (py-imod-boolX-strY-inline x-966 y-967)
  `(py-imod-boolX-strY-fallback ,x-966 ,y-967))

(define-macro (py-imod-boolX-sintY-inline x-968 y-969)
  `(py-imod-boolX-sintY-fallback ,x-968 ,y-969))

(define-macro (py-imod-boolX-bintY-inline x-970 y-971)
  `(py-imod-boolX-bintY-fallback ,x-970 ,y-971))

(define-macro (py-imod-strX-floatY-inline x-972 y-973)
  `(py-imod-strX-floatY-fallback ,x-972 ,y-973))

(define-macro (py-imod-strX-boolY-inline x-974 y-975)
  `(py-imod-strX-boolY-fallback ,x-974 ,y-975))

(define-macro (py-imod-strX-strY-inline x-976 y-977)
  `(py-imod-strX-strY-fallback ,x-976 ,y-977))

(define-macro (py-imod-strX-sintY-inline x-978 y-979)
  `(py-imod-strX-sintY-fallback ,x-978 ,y-979))

(define-macro (py-imod-strX-bintY-inline x-980 y-981)
  `(py-imod-strX-bintY-fallback ,x-980 ,y-981))

(define-macro (py-imod-sintX-floatY-inline x-982 y-983)
  `(let ((x-982 ,x-982) (y-983 ,y-983))
     (if (py-test (py-bool-from-scheme-bool
                   (py-test-from-scheme (py!= (py-float-to-scheme y-983) 0.))))
         (py-float-from-scheme
          (py% (py-sint-to-scheme x-982) (py-float-to-scheme y-983)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float modulo by zero"))))))

(define-macro (py-imod-sintX-boolY-inline x-984 y-985)
  `(py-imod-sintX-boolY-fallback ,x-984 ,y-985))

(define-macro (py-imod-sintX-strY-inline x-986 y-987)
  `(py-imod-sintX-strY-fallback ,x-986 ,y-987))

(define-macro (py-imod-sintX-sintY-inline x-988 y-989)
  `(let ((x-988 ,x-988) (y-989 ,y-989))
     (if (py-test (py-bool-from-scheme-bool
                   (py-test-from-scheme (py!= (py-sint-to-scheme y-989) 0))))
         (py-int-from-scheme
          (py% (py-sint-to-scheme x-988) (py-sint-to-scheme y-989)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError (&& "modulo by zero"))))))

(define-macro (py-imod-sintX-bintY-inline x-990 y-991)
  `(py-imod-sintX-bintY-fallback ,x-990 ,y-991))

(define-macro (py-imod-bintX-floatY-inline x-992 y-993)
  `(py-imod-bintX-floatY-fallback ,x-992 ,y-993))

(define-macro (py-imod-bintX-boolY-inline x-994 y-995)
  `(py-imod-bintX-boolY-fallback ,x-994 ,y-995))

(define-macro (py-imod-bintX-strY-inline x-996 y-997)
  `(py-imod-bintX-strY-fallback ,x-996 ,y-997))

(define-macro (py-imod-bintX-sintY-inline x-998 y-999)
  `(py-imod-bintX-sintY-fallback ,x-998 ,y-999))

(define-macro (py-imod-bintX-bintY-inline x-1000 y-1001)
  `(py-imod-bintX-bintY-fallback ,x-1000 ,y-1001))

(define-macro (py-imul-floatX-floatY-inline x-1002 y-1003)
  `(let ((x-1002 ,x-1002) (y-1003 ,y-1003))
     (py-float-from-scheme
      (py* (py-float-to-scheme x-1002) (py-float-to-scheme y-1003)))))

(define-macro (py-imul-floatX-boolY-inline x-1004 y-1005)
  `(py-imul-floatX-boolY-fallback ,x-1004 ,y-1005))

(define-macro (py-imul-floatX-strY-inline x-1006 y-1007)
  `(py-imul-floatX-strY-fallback ,x-1006 ,y-1007))

(define-macro (py-imul-floatX-sintY-inline x-1008 y-1009)
  `(let ((x-1008 ,x-1008) (y-1009 ,y-1009))
     (py-float-from-scheme
      (py* (py-float-to-scheme x-1008) (py-sint-to-scheme y-1009)))))

(define-macro (py-imul-floatX-bintY-inline x-1010 y-1011)
  `(py-imul-floatX-bintY-fallback ,x-1010 ,y-1011))

(define-macro (py-imul-boolX-floatY-inline x-1012 y-1013)
  `(py-imul-boolX-floatY-fallback ,x-1012 ,y-1013))

(define-macro (py-imul-boolX-boolY-inline x-1014 y-1015)
  `(py-imul-boolX-boolY-fallback ,x-1014 ,y-1015))

(define-macro (py-imul-boolX-strY-inline x-1016 y-1017)
  `(py-imul-boolX-strY-fallback ,x-1016 ,y-1017))

(define-macro (py-imul-boolX-sintY-inline x-1018 y-1019)
  `(py-imul-boolX-sintY-fallback ,x-1018 ,y-1019))

(define-macro (py-imul-boolX-bintY-inline x-1020 y-1021)
  `(py-imul-boolX-bintY-fallback ,x-1020 ,y-1021))

(define-macro (py-imul-strX-floatY-inline x-1022 y-1023)
  `(py-imul-strX-floatY-fallback ,x-1022 ,y-1023))

(define-macro (py-imul-strX-boolY-inline x-1024 y-1025)
  `(py-imul-strX-boolY-fallback ,x-1024 ,y-1025))

(define-macro (py-imul-strX-strY-inline x-1026 y-1027)
  `(py-imul-strX-strY-fallback ,x-1026 ,y-1027))

(define-macro (py-imul-strX-sintY-inline x-1028 y-1029)
  `(py-imul-strX-sintY-fallback ,x-1028 ,y-1029))

(define-macro (py-imul-strX-bintY-inline x-1030 y-1031)
  `(py-imul-strX-bintY-fallback ,x-1030 ,y-1031))

(define-macro (py-imul-sintX-floatY-inline x-1032 y-1033)
  `(let ((x-1032 ,x-1032) (y-1033 ,y-1033))
     (py-float-from-scheme
      (py* (py-sint-to-scheme x-1032) (py-float-to-scheme y-1033)))))

(define-macro (py-imul-sintX-boolY-inline x-1034 y-1035)
  `(py-imul-sintX-boolY-fallback ,x-1034 ,y-1035))

(define-macro (py-imul-sintX-strY-inline x-1036 y-1037)
  `(py-imul-sintX-strY-fallback ,x-1036 ,y-1037))

(define-macro (py-imul-sintX-sintY-inline x-1038 y-1039)
  `(let ((x-1038 ,x-1038) (y-1039 ,y-1039))
     (py-int-from-scheme
      (py* (py-sint-to-scheme x-1038) (py-sint-to-scheme y-1039)))))

(define-macro (py-imul-sintX-bintY-inline x-1040 y-1041)
  `(py-imul-sintX-bintY-fallback ,x-1040 ,y-1041))

(define-macro (py-imul-bintX-floatY-inline x-1042 y-1043)
  `(py-imul-bintX-floatY-fallback ,x-1042 ,y-1043))

(define-macro (py-imul-bintX-boolY-inline x-1044 y-1045)
  `(py-imul-bintX-boolY-fallback ,x-1044 ,y-1045))

(define-macro (py-imul-bintX-strY-inline x-1046 y-1047)
  `(py-imul-bintX-strY-fallback ,x-1046 ,y-1047))

(define-macro (py-imul-bintX-sintY-inline x-1048 y-1049)
  `(py-imul-bintX-sintY-fallback ,x-1048 ,y-1049))

(define-macro (py-imul-bintX-bintY-inline x-1050 y-1051)
  `(py-imul-bintX-bintY-fallback ,x-1050 ,y-1051))

(define-macro (py-ipow-floatX-floatY-inline x-1052 y-1053)
  `(let ((x-1052 ,x-1052) (y-1053 ,y-1053))
     (py-float-from-scheme
      (py** (py-float-to-scheme x-1052) (py-float-to-scheme y-1053)))))

(define-macro (py-ipow-floatX-boolY-inline x-1054 y-1055)
  `(py-ipow-floatX-boolY-fallback ,x-1054 ,y-1055))

(define-macro (py-ipow-floatX-strY-inline x-1056 y-1057)
  `(py-ipow-floatX-strY-fallback ,x-1056 ,y-1057))

(define-macro (py-ipow-floatX-sintY-inline x-1058 y-1059)
  `(let ((x-1058 ,x-1058) (y-1059 ,y-1059))
     (py-float-from-scheme
      (py** (py-float-to-scheme x-1058) (py-sint-to-scheme y-1059)))))

(define-macro (py-ipow-floatX-bintY-inline x-1060 y-1061)
  `(py-ipow-floatX-bintY-fallback ,x-1060 ,y-1061))

(define-macro (py-ipow-boolX-floatY-inline x-1062 y-1063)
  `(py-ipow-boolX-floatY-fallback ,x-1062 ,y-1063))

(define-macro (py-ipow-boolX-boolY-inline x-1064 y-1065)
  `(py-ipow-boolX-boolY-fallback ,x-1064 ,y-1065))

(define-macro (py-ipow-boolX-strY-inline x-1066 y-1067)
  `(py-ipow-boolX-strY-fallback ,x-1066 ,y-1067))

(define-macro (py-ipow-boolX-sintY-inline x-1068 y-1069)
  `(py-ipow-boolX-sintY-fallback ,x-1068 ,y-1069))

(define-macro (py-ipow-boolX-bintY-inline x-1070 y-1071)
  `(py-ipow-boolX-bintY-fallback ,x-1070 ,y-1071))

(define-macro (py-ipow-strX-floatY-inline x-1072 y-1073)
  `(py-ipow-strX-floatY-fallback ,x-1072 ,y-1073))

(define-macro (py-ipow-strX-boolY-inline x-1074 y-1075)
  `(py-ipow-strX-boolY-fallback ,x-1074 ,y-1075))

(define-macro (py-ipow-strX-strY-inline x-1076 y-1077)
  `(py-ipow-strX-strY-fallback ,x-1076 ,y-1077))

(define-macro (py-ipow-strX-sintY-inline x-1078 y-1079)
  `(py-ipow-strX-sintY-fallback ,x-1078 ,y-1079))

(define-macro (py-ipow-strX-bintY-inline x-1080 y-1081)
  `(py-ipow-strX-bintY-fallback ,x-1080 ,y-1081))

(define-macro (py-ipow-sintX-floatY-inline x-1082 y-1083)
  `(let ((x-1082 ,x-1082) (y-1083 ,y-1083))
     (py-float-from-scheme
      (py** (py-sint-to-scheme x-1082) (py-float-to-scheme y-1083)))))

(define-macro (py-ipow-sintX-boolY-inline x-1084 y-1085)
  `(py-ipow-sintX-boolY-fallback ,x-1084 ,y-1085))

(define-macro (py-ipow-sintX-strY-inline x-1086 y-1087)
  `(py-ipow-sintX-strY-fallback ,x-1086 ,y-1087))

(define-macro (py-ipow-sintX-sintY-inline x-1088 y-1089)
  `(let ((x-1088 ,x-1088) (y-1089 ,y-1089))
     (py-int-from-scheme
      (py** (py-sint-to-scheme x-1088) (py-sint-to-scheme y-1089)))))

(define-macro (py-ipow-sintX-bintY-inline x-1090 y-1091)
  `(py-ipow-sintX-bintY-fallback ,x-1090 ,y-1091))

(define-macro (py-ipow-bintX-floatY-inline x-1092 y-1093)
  `(py-ipow-bintX-floatY-fallback ,x-1092 ,y-1093))

(define-macro (py-ipow-bintX-boolY-inline x-1094 y-1095)
  `(py-ipow-bintX-boolY-fallback ,x-1094 ,y-1095))

(define-macro (py-ipow-bintX-strY-inline x-1096 y-1097)
  `(py-ipow-bintX-strY-fallback ,x-1096 ,y-1097))

(define-macro (py-ipow-bintX-sintY-inline x-1098 y-1099)
  `(py-ipow-bintX-sintY-fallback ,x-1098 ,y-1099))

(define-macro (py-ipow-bintX-bintY-inline x-1100 y-1101)
  `(py-ipow-bintX-bintY-fallback ,x-1100 ,y-1101))

(define-macro (py-irshift-floatX-floatY-inline x-1102 y-1103)
  `(let ((x-1102 ,x-1102) (y-1103 ,y-1103))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for >>=: 'float' and 'float'")))))

(define-macro (py-irshift-floatX-boolY-inline x-1104 y-1105)
  `(py-irshift-floatX-boolY-fallback ,x-1104 ,y-1105))

(define-macro (py-irshift-floatX-strY-inline x-1106 y-1107)
  `(py-irshift-floatX-strY-fallback ,x-1106 ,y-1107))

(define-macro (py-irshift-floatX-sintY-inline x-1108 y-1109)
  `(let ((x-1108 ,x-1108) (y-1109 ,y-1109))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for >>=: 'float' and 'int'")))))

(define-macro (py-irshift-floatX-bintY-inline x-1110 y-1111)
  `(py-irshift-floatX-bintY-fallback ,x-1110 ,y-1111))

(define-macro (py-irshift-boolX-floatY-inline x-1112 y-1113)
  `(py-irshift-boolX-floatY-fallback ,x-1112 ,y-1113))

(define-macro (py-irshift-boolX-boolY-inline x-1114 y-1115)
  `(py-irshift-boolX-boolY-fallback ,x-1114 ,y-1115))

(define-macro (py-irshift-boolX-strY-inline x-1116 y-1117)
  `(py-irshift-boolX-strY-fallback ,x-1116 ,y-1117))

(define-macro (py-irshift-boolX-sintY-inline x-1118 y-1119)
  `(py-irshift-boolX-sintY-fallback ,x-1118 ,y-1119))

(define-macro (py-irshift-boolX-bintY-inline x-1120 y-1121)
  `(py-irshift-boolX-bintY-fallback ,x-1120 ,y-1121))

(define-macro (py-irshift-strX-floatY-inline x-1122 y-1123)
  `(py-irshift-strX-floatY-fallback ,x-1122 ,y-1123))

(define-macro (py-irshift-strX-boolY-inline x-1124 y-1125)
  `(py-irshift-strX-boolY-fallback ,x-1124 ,y-1125))

(define-macro (py-irshift-strX-strY-inline x-1126 y-1127)
  `(py-irshift-strX-strY-fallback ,x-1126 ,y-1127))

(define-macro (py-irshift-strX-sintY-inline x-1128 y-1129)
  `(py-irshift-strX-sintY-fallback ,x-1128 ,y-1129))

(define-macro (py-irshift-strX-bintY-inline x-1130 y-1131)
  `(py-irshift-strX-bintY-fallback ,x-1130 ,y-1131))

(define-macro (py-irshift-sintX-floatY-inline x-1132 y-1133)
  `(let ((x-1132 ,x-1132) (y-1133 ,y-1133))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for >>=: 'int' and 'float'")))))

(define-macro (py-irshift-sintX-boolY-inline x-1134 y-1135)
  `(py-irshift-sintX-boolY-fallback ,x-1134 ,y-1135))

(define-macro (py-irshift-sintX-strY-inline x-1136 y-1137)
  `(py-irshift-sintX-strY-fallback ,x-1136 ,y-1137))

(define-macro (py-irshift-sintX-sintY-inline x-1138 y-1139)
  `(let ((x-1138 ,x-1138) (y-1139 ,y-1139))
     (if (py-test (py-bool-from-scheme-bool
                   (py-test-from-scheme (py>= (py-sint-to-scheme y-1139) 0))))
         (py-int-from-scheme
          (py>> (py-sint-to-scheme x-1138) (py-sint-to-scheme y-1139)))
         (py-throw
          (py-call py-builtin-ValueError (&& "negative shift count"))))))

(define-macro (py-irshift-sintX-bintY-inline x-1140 y-1141)
  `(py-irshift-sintX-bintY-fallback ,x-1140 ,y-1141))

(define-macro (py-irshift-bintX-floatY-inline x-1142 y-1143)
  `(py-irshift-bintX-floatY-fallback ,x-1142 ,y-1143))

(define-macro (py-irshift-bintX-boolY-inline x-1144 y-1145)
  `(py-irshift-bintX-boolY-fallback ,x-1144 ,y-1145))

(define-macro (py-irshift-bintX-strY-inline x-1146 y-1147)
  `(py-irshift-bintX-strY-fallback ,x-1146 ,y-1147))

(define-macro (py-irshift-bintX-sintY-inline x-1148 y-1149)
  `(py-irshift-bintX-sintY-fallback ,x-1148 ,y-1149))

(define-macro (py-irshift-bintX-bintY-inline x-1150 y-1151)
  `(py-irshift-bintX-bintY-fallback ,x-1150 ,y-1151))

(define-macro (py-isub-floatX-floatY-inline x-1152 y-1153)
  `(let ((x-1152 ,x-1152) (y-1153 ,y-1153))
     (py-float-from-scheme
      (py- (py-float-to-scheme x-1152) (py-float-to-scheme y-1153)))))

(define-macro (py-isub-floatX-boolY-inline x-1154 y-1155)
  `(py-isub-floatX-boolY-fallback ,x-1154 ,y-1155))

(define-macro (py-isub-floatX-strY-inline x-1156 y-1157)
  `(py-isub-floatX-strY-fallback ,x-1156 ,y-1157))

(define-macro (py-isub-floatX-sintY-inline x-1158 y-1159)
  `(let ((x-1158 ,x-1158) (y-1159 ,y-1159))
     (py-float-from-scheme
      (py- (py-float-to-scheme x-1158) (py-sint-to-scheme y-1159)))))

(define-macro (py-isub-floatX-bintY-inline x-1160 y-1161)
  `(py-isub-floatX-bintY-fallback ,x-1160 ,y-1161))

(define-macro (py-isub-boolX-floatY-inline x-1162 y-1163)
  `(py-isub-boolX-floatY-fallback ,x-1162 ,y-1163))

(define-macro (py-isub-boolX-boolY-inline x-1164 y-1165)
  `(py-isub-boolX-boolY-fallback ,x-1164 ,y-1165))

(define-macro (py-isub-boolX-strY-inline x-1166 y-1167)
  `(py-isub-boolX-strY-fallback ,x-1166 ,y-1167))

(define-macro (py-isub-boolX-sintY-inline x-1168 y-1169)
  `(py-isub-boolX-sintY-fallback ,x-1168 ,y-1169))

(define-macro (py-isub-boolX-bintY-inline x-1170 y-1171)
  `(py-isub-boolX-bintY-fallback ,x-1170 ,y-1171))

(define-macro (py-isub-strX-floatY-inline x-1172 y-1173)
  `(py-isub-strX-floatY-fallback ,x-1172 ,y-1173))

(define-macro (py-isub-strX-boolY-inline x-1174 y-1175)
  `(py-isub-strX-boolY-fallback ,x-1174 ,y-1175))

(define-macro (py-isub-strX-strY-inline x-1176 y-1177)
  `(py-isub-strX-strY-fallback ,x-1176 ,y-1177))

(define-macro (py-isub-strX-sintY-inline x-1178 y-1179)
  `(py-isub-strX-sintY-fallback ,x-1178 ,y-1179))

(define-macro (py-isub-strX-bintY-inline x-1180 y-1181)
  `(py-isub-strX-bintY-fallback ,x-1180 ,y-1181))

(define-macro (py-isub-sintX-floatY-inline x-1182 y-1183)
  `(let ((x-1182 ,x-1182) (y-1183 ,y-1183))
     (py-float-from-scheme
      (py- (py-sint-to-scheme x-1182) (py-float-to-scheme y-1183)))))

(define-macro (py-isub-sintX-boolY-inline x-1184 y-1185)
  `(py-isub-sintX-boolY-fallback ,x-1184 ,y-1185))

(define-macro (py-isub-sintX-strY-inline x-1186 y-1187)
  `(py-isub-sintX-strY-fallback ,x-1186 ,y-1187))

(define-macro (py-isub-sintX-sintY-inline x-1188 y-1189)
  `(let ((x-1188 ,x-1188) (y-1189 ,y-1189))
     (py-int-from-scheme
      (py- (py-sint-to-scheme x-1188) (py-sint-to-scheme y-1189)))))

(define-macro (py-isub-sintX-bintY-inline x-1190 y-1191)
  `(py-isub-sintX-bintY-fallback ,x-1190 ,y-1191))

(define-macro (py-isub-bintX-floatY-inline x-1192 y-1193)
  `(py-isub-bintX-floatY-fallback ,x-1192 ,y-1193))

(define-macro (py-isub-bintX-boolY-inline x-1194 y-1195)
  `(py-isub-bintX-boolY-fallback ,x-1194 ,y-1195))

(define-macro (py-isub-bintX-strY-inline x-1196 y-1197)
  `(py-isub-bintX-strY-fallback ,x-1196 ,y-1197))

(define-macro (py-isub-bintX-sintY-inline x-1198 y-1199)
  `(py-isub-bintX-sintY-fallback ,x-1198 ,y-1199))

(define-macro (py-isub-bintX-bintY-inline x-1200 y-1201)
  `(py-isub-bintX-bintY-fallback ,x-1200 ,y-1201))

(define-macro (py-itruediv-floatX-floatY-inline x-1202 y-1203)
  `(let ((x-1202 ,x-1202) (y-1203 ,y-1203))
     (if (py-test (py-bool-from-scheme-bool
                   (py-test-from-scheme
                    (py!= (py-float-to-scheme y-1203) 0.))))
         (py-float-from-scheme
          (py/ (py-float-to-scheme x-1202) (py-float-to-scheme y-1203)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-itruediv-floatX-boolY-inline x-1204 y-1205)
  `(py-itruediv-floatX-boolY-fallback ,x-1204 ,y-1205))

(define-macro (py-itruediv-floatX-strY-inline x-1206 y-1207)
  `(py-itruediv-floatX-strY-fallback ,x-1206 ,y-1207))

(define-macro (py-itruediv-floatX-sintY-inline x-1208 y-1209)
  `(let ((x-1208 ,x-1208) (y-1209 ,y-1209))
     (if (py-test (py-bool-from-scheme-bool
                   (py-test-from-scheme (py!= (py-sint-to-scheme y-1209) 0))))
         (py-float-from-scheme
          (py/ (py-float-to-scheme x-1208) (py-sint-to-scheme y-1209)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-itruediv-floatX-bintY-inline x-1210 y-1211)
  `(py-itruediv-floatX-bintY-fallback ,x-1210 ,y-1211))

(define-macro (py-itruediv-boolX-floatY-inline x-1212 y-1213)
  `(py-itruediv-boolX-floatY-fallback ,x-1212 ,y-1213))

(define-macro (py-itruediv-boolX-boolY-inline x-1214 y-1215)
  `(py-itruediv-boolX-boolY-fallback ,x-1214 ,y-1215))

(define-macro (py-itruediv-boolX-strY-inline x-1216 y-1217)
  `(py-itruediv-boolX-strY-fallback ,x-1216 ,y-1217))

(define-macro (py-itruediv-boolX-sintY-inline x-1218 y-1219)
  `(py-itruediv-boolX-sintY-fallback ,x-1218 ,y-1219))

(define-macro (py-itruediv-boolX-bintY-inline x-1220 y-1221)
  `(py-itruediv-boolX-bintY-fallback ,x-1220 ,y-1221))

(define-macro (py-itruediv-strX-floatY-inline x-1222 y-1223)
  `(py-itruediv-strX-floatY-fallback ,x-1222 ,y-1223))

(define-macro (py-itruediv-strX-boolY-inline x-1224 y-1225)
  `(py-itruediv-strX-boolY-fallback ,x-1224 ,y-1225))

(define-macro (py-itruediv-strX-strY-inline x-1226 y-1227)
  `(py-itruediv-strX-strY-fallback ,x-1226 ,y-1227))

(define-macro (py-itruediv-strX-sintY-inline x-1228 y-1229)
  `(py-itruediv-strX-sintY-fallback ,x-1228 ,y-1229))

(define-macro (py-itruediv-strX-bintY-inline x-1230 y-1231)
  `(py-itruediv-strX-bintY-fallback ,x-1230 ,y-1231))

(define-macro (py-itruediv-sintX-floatY-inline x-1232 y-1233)
  `(let ((x-1232 ,x-1232) (y-1233 ,y-1233))
     (if (py-test (py-bool-from-scheme-bool
                   (py-test-from-scheme
                    (py!= (py-float-to-scheme y-1233) 0.))))
         (py-float-from-scheme
          (py/ (py-sint-to-scheme x-1232) (py-float-to-scheme y-1233)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError
                   (&& "float division by zero"))))))

(define-macro (py-itruediv-sintX-boolY-inline x-1234 y-1235)
  `(py-itruediv-sintX-boolY-fallback ,x-1234 ,y-1235))

(define-macro (py-itruediv-sintX-strY-inline x-1236 y-1237)
  `(py-itruediv-sintX-strY-fallback ,x-1236 ,y-1237))

(define-macro (py-itruediv-sintX-sintY-inline x-1238 y-1239)
  `(let ((x-1238 ,x-1238) (y-1239 ,y-1239))
     (if (py-test (py-bool-from-scheme-bool
                   (py-test-from-scheme (py!= (py-sint-to-scheme y-1239) 0))))
         (py-float-from-scheme
          (py/ (py-sint-to-scheme x-1238) (py-sint-to-scheme y-1239)))
         (py-throw
          (py-call py-builtin-ZeroDivisionError (&& "division by zero"))))))

(define-macro (py-itruediv-sintX-bintY-inline x-1240 y-1241)
  `(py-itruediv-sintX-bintY-fallback ,x-1240 ,y-1241))

(define-macro (py-itruediv-bintX-floatY-inline x-1242 y-1243)
  `(py-itruediv-bintX-floatY-fallback ,x-1242 ,y-1243))

(define-macro (py-itruediv-bintX-boolY-inline x-1244 y-1245)
  `(py-itruediv-bintX-boolY-fallback ,x-1244 ,y-1245))

(define-macro (py-itruediv-bintX-strY-inline x-1246 y-1247)
  `(py-itruediv-bintX-strY-fallback ,x-1246 ,y-1247))

(define-macro (py-itruediv-bintX-sintY-inline x-1248 y-1249)
  `(py-itruediv-bintX-sintY-fallback ,x-1248 ,y-1249))

(define-macro (py-itruediv-bintX-bintY-inline x-1250 y-1251)
  `(py-itruediv-bintX-bintY-fallback ,x-1250 ,y-1251))

(define-macro (py-ixor-floatX-floatY-inline x-1252 y-1253)
  `(let ((x-1252 ,x-1252) (y-1253 ,y-1253))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for ^=: 'float' and 'float'")))))

(define-macro (py-ixor-floatX-boolY-inline x-1254 y-1255)
  `(py-ixor-floatX-boolY-fallback ,x-1254 ,y-1255))

(define-macro (py-ixor-floatX-strY-inline x-1256 y-1257)
  `(py-ixor-floatX-strY-fallback ,x-1256 ,y-1257))

(define-macro (py-ixor-floatX-sintY-inline x-1258 y-1259)
  `(let ((x-1258 ,x-1258) (y-1259 ,y-1259))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for ^=: 'float' and 'int'")))))

(define-macro (py-ixor-floatX-bintY-inline x-1260 y-1261)
  `(py-ixor-floatX-bintY-fallback ,x-1260 ,y-1261))

(define-macro (py-ixor-boolX-floatY-inline x-1262 y-1263)
  `(py-ixor-boolX-floatY-fallback ,x-1262 ,y-1263))

(define-macro (py-ixor-boolX-boolY-inline x-1264 y-1265)
  `(py-ixor-boolX-boolY-fallback ,x-1264 ,y-1265))

(define-macro (py-ixor-boolX-strY-inline x-1266 y-1267)
  `(py-ixor-boolX-strY-fallback ,x-1266 ,y-1267))

(define-macro (py-ixor-boolX-sintY-inline x-1268 y-1269)
  `(py-ixor-boolX-sintY-fallback ,x-1268 ,y-1269))

(define-macro (py-ixor-boolX-bintY-inline x-1270 y-1271)
  `(py-ixor-boolX-bintY-fallback ,x-1270 ,y-1271))

(define-macro (py-ixor-strX-floatY-inline x-1272 y-1273)
  `(py-ixor-strX-floatY-fallback ,x-1272 ,y-1273))

(define-macro (py-ixor-strX-boolY-inline x-1274 y-1275)
  `(py-ixor-strX-boolY-fallback ,x-1274 ,y-1275))

(define-macro (py-ixor-strX-strY-inline x-1276 y-1277)
  `(py-ixor-strX-strY-fallback ,x-1276 ,y-1277))

(define-macro (py-ixor-strX-sintY-inline x-1278 y-1279)
  `(py-ixor-strX-sintY-fallback ,x-1278 ,y-1279))

(define-macro (py-ixor-strX-bintY-inline x-1280 y-1281)
  `(py-ixor-strX-bintY-fallback ,x-1280 ,y-1281))

(define-macro (py-ixor-sintX-floatY-inline x-1282 y-1283)
  `(let ((x-1282 ,x-1282) (y-1283 ,y-1283))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "unsupported operand type(s) for ^=: 'int' and 'float'")))))

(define-macro (py-ixor-sintX-boolY-inline x-1284 y-1285)
  `(py-ixor-sintX-boolY-fallback ,x-1284 ,y-1285))

(define-macro (py-ixor-sintX-strY-inline x-1286 y-1287)
  `(py-ixor-sintX-strY-fallback ,x-1286 ,y-1287))

(define-macro (py-ixor-sintX-sintY-inline x-1288 y-1289)
  `(let ((x-1288 ,x-1288) (y-1289 ,y-1289))
     (py-int-from-scheme
      (py^ (py-sint-to-scheme x-1288) (py-sint-to-scheme y-1289)))))

(define-macro (py-ixor-sintX-bintY-inline x-1290 y-1291)
  `(py-ixor-sintX-bintY-fallback ,x-1290 ,y-1291))

(define-macro (py-ixor-bintX-floatY-inline x-1292 y-1293)
  `(py-ixor-bintX-floatY-fallback ,x-1292 ,y-1293))

(define-macro (py-ixor-bintX-boolY-inline x-1294 y-1295)
  `(py-ixor-bintX-boolY-fallback ,x-1294 ,y-1295))

(define-macro (py-ixor-bintX-strY-inline x-1296 y-1297)
  `(py-ixor-bintX-strY-fallback ,x-1296 ,y-1297))

(define-macro (py-ixor-bintX-sintY-inline x-1298 y-1299)
  `(py-ixor-bintX-sintY-fallback ,x-1298 ,y-1299))

(define-macro (py-ixor-bintX-bintY-inline x-1300 y-1301)
  `(py-ixor-bintX-bintY-fallback ,x-1300 ,y-1301))

(define-macro (py-ge-floatX-floatY-inline x-1302 y-1303)
  `(let ((x-1302 ,x-1302) (y-1303 ,y-1303))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py>= (py-float-to-scheme x-1302) (py-float-to-scheme y-1303))))))

(define-macro (py-test-ge-floatX-floatY-inline x-1304 y-1305)
  `(let ((x-1304 ,x-1304) (y-1305 ,y-1305))
     (py-test-from-scheme
      (py>= (py-float-to-scheme x-1304) (py-float-to-scheme y-1305)))))

(define-macro (py-ge-floatX-boolY-inline x-1306 y-1307)
  `(py-ge-floatX-boolY-fallback ,x-1306 ,y-1307))

(define-macro (py-test-ge-floatX-boolY-inline x-1308 y-1309)
  `(py-test-ge-floatX-boolY-fallback ,x-1308 ,y-1309))

(define-macro (py-ge-floatX-strY-inline x-1310 y-1311)
  `(py-ge-floatX-strY-fallback ,x-1310 ,y-1311))

(define-macro (py-test-ge-floatX-strY-inline x-1312 y-1313)
  `(py-test-ge-floatX-strY-fallback ,x-1312 ,y-1313))

(define-macro (py-ge-floatX-sintY-inline x-1314 y-1315)
  `(let ((x-1314 ,x-1314) (y-1315 ,y-1315))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py>= (py-float-to-scheme x-1314) (py-sint-to-scheme y-1315))))))

(define-macro (py-test-ge-floatX-sintY-inline x-1316 y-1317)
  `(let ((x-1316 ,x-1316) (y-1317 ,y-1317))
     (py-test-from-scheme
      (py>= (py-float-to-scheme x-1316) (py-sint-to-scheme y-1317)))))

(define-macro (py-ge-floatX-bintY-inline x-1318 y-1319)
  `(py-ge-floatX-bintY-fallback ,x-1318 ,y-1319))

(define-macro (py-test-ge-floatX-bintY-inline x-1320 y-1321)
  `(py-test-ge-floatX-bintY-fallback ,x-1320 ,y-1321))

(define-macro (py-ge-boolX-floatY-inline x-1322 y-1323)
  `(py-ge-boolX-floatY-fallback ,x-1322 ,y-1323))

(define-macro (py-test-ge-boolX-floatY-inline x-1324 y-1325)
  `(py-test-ge-boolX-floatY-fallback ,x-1324 ,y-1325))

(define-macro (py-ge-boolX-boolY-inline x-1326 y-1327)
  `(py-ge-boolX-boolY-fallback ,x-1326 ,y-1327))

(define-macro (py-test-ge-boolX-boolY-inline x-1328 y-1329)
  `(py-test-ge-boolX-boolY-fallback ,x-1328 ,y-1329))

(define-macro (py-ge-boolX-strY-inline x-1330 y-1331)
  `(py-ge-boolX-strY-fallback ,x-1330 ,y-1331))

(define-macro (py-test-ge-boolX-strY-inline x-1332 y-1333)
  `(py-test-ge-boolX-strY-fallback ,x-1332 ,y-1333))

(define-macro (py-ge-boolX-sintY-inline x-1334 y-1335)
  `(py-ge-boolX-sintY-fallback ,x-1334 ,y-1335))

(define-macro (py-test-ge-boolX-sintY-inline x-1336 y-1337)
  `(py-test-ge-boolX-sintY-fallback ,x-1336 ,y-1337))

(define-macro (py-ge-boolX-bintY-inline x-1338 y-1339)
  `(py-ge-boolX-bintY-fallback ,x-1338 ,y-1339))

(define-macro (py-test-ge-boolX-bintY-inline x-1340 y-1341)
  `(py-test-ge-boolX-bintY-fallback ,x-1340 ,y-1341))

(define-macro (py-ge-strX-floatY-inline x-1342 y-1343)
  `(py-ge-strX-floatY-fallback ,x-1342 ,y-1343))

(define-macro (py-test-ge-strX-floatY-inline x-1344 y-1345)
  `(py-test-ge-strX-floatY-fallback ,x-1344 ,y-1345))

(define-macro (py-ge-strX-boolY-inline x-1346 y-1347)
  `(py-ge-strX-boolY-fallback ,x-1346 ,y-1347))

(define-macro (py-test-ge-strX-boolY-inline x-1348 y-1349)
  `(py-test-ge-strX-boolY-fallback ,x-1348 ,y-1349))

(define-macro (py-ge-strX-strY-inline x-1350 y-1351)
  `(py-ge-strX-strY-fallback ,x-1350 ,y-1351))

(define-macro (py-test-ge-strX-strY-inline x-1352 y-1353)
  `(py-test-ge-strX-strY-fallback ,x-1352 ,y-1353))

(define-macro (py-ge-strX-sintY-inline x-1354 y-1355)
  `(py-ge-strX-sintY-fallback ,x-1354 ,y-1355))

(define-macro (py-test-ge-strX-sintY-inline x-1356 y-1357)
  `(py-test-ge-strX-sintY-fallback ,x-1356 ,y-1357))

(define-macro (py-ge-strX-bintY-inline x-1358 y-1359)
  `(py-ge-strX-bintY-fallback ,x-1358 ,y-1359))

(define-macro (py-test-ge-strX-bintY-inline x-1360 y-1361)
  `(py-test-ge-strX-bintY-fallback ,x-1360 ,y-1361))

(define-macro (py-ge-sintX-floatY-inline x-1362 y-1363)
  `(let ((x-1362 ,x-1362) (y-1363 ,y-1363))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py<= (py-float-to-scheme y-1363) (py-sint-to-scheme x-1362))))))

(define-macro (py-test-ge-sintX-floatY-inline x-1364 y-1365)
  `(let ((x-1364 ,x-1364) (y-1365 ,y-1365))
     (py-test-from-scheme
      (py<= (py-float-to-scheme y-1365) (py-sint-to-scheme x-1364)))))

(define-macro (py-ge-sintX-boolY-inline x-1366 y-1367)
  `(py-ge-sintX-boolY-fallback ,x-1366 ,y-1367))

(define-macro (py-test-ge-sintX-boolY-inline x-1368 y-1369)
  `(py-test-ge-sintX-boolY-fallback ,x-1368 ,y-1369))

(define-macro (py-ge-sintX-strY-inline x-1370 y-1371)
  `(py-ge-sintX-strY-fallback ,x-1370 ,y-1371))

(define-macro (py-test-ge-sintX-strY-inline x-1372 y-1373)
  `(py-test-ge-sintX-strY-fallback ,x-1372 ,y-1373))

(define-macro (py-ge-sintX-sintY-inline x-1374 y-1375)
  `(let ((x-1374 ,x-1374) (y-1375 ,y-1375))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py>= (py-sint-to-scheme x-1374) (py-sint-to-scheme y-1375))))))

(define-macro (py-test-ge-sintX-sintY-inline x-1376 y-1377)
  `(let ((x-1376 ,x-1376) (y-1377 ,y-1377))
     (py-test-from-scheme
      (py>= (py-sint-to-scheme x-1376) (py-sint-to-scheme y-1377)))))

(define-macro (py-ge-sintX-bintY-inline x-1378 y-1379)
  `(py-ge-sintX-bintY-fallback ,x-1378 ,y-1379))

(define-macro (py-test-ge-sintX-bintY-inline x-1380 y-1381)
  `(py-test-ge-sintX-bintY-fallback ,x-1380 ,y-1381))

(define-macro (py-ge-bintX-floatY-inline x-1382 y-1383)
  `(py-ge-bintX-floatY-fallback ,x-1382 ,y-1383))

(define-macro (py-test-ge-bintX-floatY-inline x-1384 y-1385)
  `(py-test-ge-bintX-floatY-fallback ,x-1384 ,y-1385))

(define-macro (py-ge-bintX-boolY-inline x-1386 y-1387)
  `(py-ge-bintX-boolY-fallback ,x-1386 ,y-1387))

(define-macro (py-test-ge-bintX-boolY-inline x-1388 y-1389)
  `(py-test-ge-bintX-boolY-fallback ,x-1388 ,y-1389))

(define-macro (py-ge-bintX-strY-inline x-1390 y-1391)
  `(py-ge-bintX-strY-fallback ,x-1390 ,y-1391))

(define-macro (py-test-ge-bintX-strY-inline x-1392 y-1393)
  `(py-test-ge-bintX-strY-fallback ,x-1392 ,y-1393))

(define-macro (py-ge-bintX-sintY-inline x-1394 y-1395)
  `(py-ge-bintX-sintY-fallback ,x-1394 ,y-1395))

(define-macro (py-test-ge-bintX-sintY-inline x-1396 y-1397)
  `(py-test-ge-bintX-sintY-fallback ,x-1396 ,y-1397))

(define-macro (py-ge-bintX-bintY-inline x-1398 y-1399)
  `(py-ge-bintX-bintY-fallback ,x-1398 ,y-1399))

(define-macro (py-test-ge-bintX-bintY-inline x-1400 y-1401)
  `(py-test-ge-bintX-bintY-fallback ,x-1400 ,y-1401))

(define-macro (py-gt-floatX-floatY-inline x-1402 y-1403)
  `(let ((x-1402 ,x-1402) (y-1403 ,y-1403))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py> (py-float-to-scheme x-1402) (py-float-to-scheme y-1403))))))

(define-macro (py-test-gt-floatX-floatY-inline x-1404 y-1405)
  `(let ((x-1404 ,x-1404) (y-1405 ,y-1405))
     (py-test-from-scheme
      (py> (py-float-to-scheme x-1404) (py-float-to-scheme y-1405)))))

(define-macro (py-gt-floatX-boolY-inline x-1406 y-1407)
  `(py-gt-floatX-boolY-fallback ,x-1406 ,y-1407))

(define-macro (py-test-gt-floatX-boolY-inline x-1408 y-1409)
  `(py-test-gt-floatX-boolY-fallback ,x-1408 ,y-1409))

(define-macro (py-gt-floatX-strY-inline x-1410 y-1411)
  `(py-gt-floatX-strY-fallback ,x-1410 ,y-1411))

(define-macro (py-test-gt-floatX-strY-inline x-1412 y-1413)
  `(py-test-gt-floatX-strY-fallback ,x-1412 ,y-1413))

(define-macro (py-gt-floatX-sintY-inline x-1414 y-1415)
  `(let ((x-1414 ,x-1414) (y-1415 ,y-1415))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py> (py-float-to-scheme x-1414) (py-sint-to-scheme y-1415))))))

(define-macro (py-test-gt-floatX-sintY-inline x-1416 y-1417)
  `(let ((x-1416 ,x-1416) (y-1417 ,y-1417))
     (py-test-from-scheme
      (py> (py-float-to-scheme x-1416) (py-sint-to-scheme y-1417)))))

(define-macro (py-gt-floatX-bintY-inline x-1418 y-1419)
  `(py-gt-floatX-bintY-fallback ,x-1418 ,y-1419))

(define-macro (py-test-gt-floatX-bintY-inline x-1420 y-1421)
  `(py-test-gt-floatX-bintY-fallback ,x-1420 ,y-1421))

(define-macro (py-gt-boolX-floatY-inline x-1422 y-1423)
  `(py-gt-boolX-floatY-fallback ,x-1422 ,y-1423))

(define-macro (py-test-gt-boolX-floatY-inline x-1424 y-1425)
  `(py-test-gt-boolX-floatY-fallback ,x-1424 ,y-1425))

(define-macro (py-gt-boolX-boolY-inline x-1426 y-1427)
  `(py-gt-boolX-boolY-fallback ,x-1426 ,y-1427))

(define-macro (py-test-gt-boolX-boolY-inline x-1428 y-1429)
  `(py-test-gt-boolX-boolY-fallback ,x-1428 ,y-1429))

(define-macro (py-gt-boolX-strY-inline x-1430 y-1431)
  `(py-gt-boolX-strY-fallback ,x-1430 ,y-1431))

(define-macro (py-test-gt-boolX-strY-inline x-1432 y-1433)
  `(py-test-gt-boolX-strY-fallback ,x-1432 ,y-1433))

(define-macro (py-gt-boolX-sintY-inline x-1434 y-1435)
  `(py-gt-boolX-sintY-fallback ,x-1434 ,y-1435))

(define-macro (py-test-gt-boolX-sintY-inline x-1436 y-1437)
  `(py-test-gt-boolX-sintY-fallback ,x-1436 ,y-1437))

(define-macro (py-gt-boolX-bintY-inline x-1438 y-1439)
  `(py-gt-boolX-bintY-fallback ,x-1438 ,y-1439))

(define-macro (py-test-gt-boolX-bintY-inline x-1440 y-1441)
  `(py-test-gt-boolX-bintY-fallback ,x-1440 ,y-1441))

(define-macro (py-gt-strX-floatY-inline x-1442 y-1443)
  `(py-gt-strX-floatY-fallback ,x-1442 ,y-1443))

(define-macro (py-test-gt-strX-floatY-inline x-1444 y-1445)
  `(py-test-gt-strX-floatY-fallback ,x-1444 ,y-1445))

(define-macro (py-gt-strX-boolY-inline x-1446 y-1447)
  `(py-gt-strX-boolY-fallback ,x-1446 ,y-1447))

(define-macro (py-test-gt-strX-boolY-inline x-1448 y-1449)
  `(py-test-gt-strX-boolY-fallback ,x-1448 ,y-1449))

(define-macro (py-gt-strX-strY-inline x-1450 y-1451)
  `(py-gt-strX-strY-fallback ,x-1450 ,y-1451))

(define-macro (py-test-gt-strX-strY-inline x-1452 y-1453)
  `(py-test-gt-strX-strY-fallback ,x-1452 ,y-1453))

(define-macro (py-gt-strX-sintY-inline x-1454 y-1455)
  `(py-gt-strX-sintY-fallback ,x-1454 ,y-1455))

(define-macro (py-test-gt-strX-sintY-inline x-1456 y-1457)
  `(py-test-gt-strX-sintY-fallback ,x-1456 ,y-1457))

(define-macro (py-gt-strX-bintY-inline x-1458 y-1459)
  `(py-gt-strX-bintY-fallback ,x-1458 ,y-1459))

(define-macro (py-test-gt-strX-bintY-inline x-1460 y-1461)
  `(py-test-gt-strX-bintY-fallback ,x-1460 ,y-1461))

(define-macro (py-gt-sintX-floatY-inline x-1462 y-1463)
  `(let ((x-1462 ,x-1462) (y-1463 ,y-1463))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py< (py-float-to-scheme y-1463) (py-sint-to-scheme x-1462))))))

(define-macro (py-test-gt-sintX-floatY-inline x-1464 y-1465)
  `(let ((x-1464 ,x-1464) (y-1465 ,y-1465))
     (py-test-from-scheme
      (py< (py-float-to-scheme y-1465) (py-sint-to-scheme x-1464)))))

(define-macro (py-gt-sintX-boolY-inline x-1466 y-1467)
  `(py-gt-sintX-boolY-fallback ,x-1466 ,y-1467))

(define-macro (py-test-gt-sintX-boolY-inline x-1468 y-1469)
  `(py-test-gt-sintX-boolY-fallback ,x-1468 ,y-1469))

(define-macro (py-gt-sintX-strY-inline x-1470 y-1471)
  `(py-gt-sintX-strY-fallback ,x-1470 ,y-1471))

(define-macro (py-test-gt-sintX-strY-inline x-1472 y-1473)
  `(py-test-gt-sintX-strY-fallback ,x-1472 ,y-1473))

(define-macro (py-gt-sintX-sintY-inline x-1474 y-1475)
  `(let ((x-1474 ,x-1474) (y-1475 ,y-1475))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py> (py-sint-to-scheme x-1474) (py-sint-to-scheme y-1475))))))

(define-macro (py-test-gt-sintX-sintY-inline x-1476 y-1477)
  `(let ((x-1476 ,x-1476) (y-1477 ,y-1477))
     (py-test-from-scheme
      (py> (py-sint-to-scheme x-1476) (py-sint-to-scheme y-1477)))))

(define-macro (py-gt-sintX-bintY-inline x-1478 y-1479)
  `(py-gt-sintX-bintY-fallback ,x-1478 ,y-1479))

(define-macro (py-test-gt-sintX-bintY-inline x-1480 y-1481)
  `(py-test-gt-sintX-bintY-fallback ,x-1480 ,y-1481))

(define-macro (py-gt-bintX-floatY-inline x-1482 y-1483)
  `(py-gt-bintX-floatY-fallback ,x-1482 ,y-1483))

(define-macro (py-test-gt-bintX-floatY-inline x-1484 y-1485)
  `(py-test-gt-bintX-floatY-fallback ,x-1484 ,y-1485))

(define-macro (py-gt-bintX-boolY-inline x-1486 y-1487)
  `(py-gt-bintX-boolY-fallback ,x-1486 ,y-1487))

(define-macro (py-test-gt-bintX-boolY-inline x-1488 y-1489)
  `(py-test-gt-bintX-boolY-fallback ,x-1488 ,y-1489))

(define-macro (py-gt-bintX-strY-inline x-1490 y-1491)
  `(py-gt-bintX-strY-fallback ,x-1490 ,y-1491))

(define-macro (py-test-gt-bintX-strY-inline x-1492 y-1493)
  `(py-test-gt-bintX-strY-fallback ,x-1492 ,y-1493))

(define-macro (py-gt-bintX-sintY-inline x-1494 y-1495)
  `(py-gt-bintX-sintY-fallback ,x-1494 ,y-1495))

(define-macro (py-test-gt-bintX-sintY-inline x-1496 y-1497)
  `(py-test-gt-bintX-sintY-fallback ,x-1496 ,y-1497))

(define-macro (py-gt-bintX-bintY-inline x-1498 y-1499)
  `(py-gt-bintX-bintY-fallback ,x-1498 ,y-1499))

(define-macro (py-test-gt-bintX-bintY-inline x-1500 y-1501)
  `(py-test-gt-bintX-bintY-fallback ,x-1500 ,y-1501))

(define-macro (py-le-floatX-floatY-inline x-1502 y-1503)
  `(let ((x-1502 ,x-1502) (y-1503 ,y-1503))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py<= (py-float-to-scheme x-1502) (py-float-to-scheme y-1503))))))

(define-macro (py-test-le-floatX-floatY-inline x-1504 y-1505)
  `(let ((x-1504 ,x-1504) (y-1505 ,y-1505))
     (py-test-from-scheme
      (py<= (py-float-to-scheme x-1504) (py-float-to-scheme y-1505)))))

(define-macro (py-le-floatX-boolY-inline x-1506 y-1507)
  `(py-le-floatX-boolY-fallback ,x-1506 ,y-1507))

(define-macro (py-test-le-floatX-boolY-inline x-1508 y-1509)
  `(py-test-le-floatX-boolY-fallback ,x-1508 ,y-1509))

(define-macro (py-le-floatX-strY-inline x-1510 y-1511)
  `(py-le-floatX-strY-fallback ,x-1510 ,y-1511))

(define-macro (py-test-le-floatX-strY-inline x-1512 y-1513)
  `(py-test-le-floatX-strY-fallback ,x-1512 ,y-1513))

(define-macro (py-le-floatX-sintY-inline x-1514 y-1515)
  `(let ((x-1514 ,x-1514) (y-1515 ,y-1515))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py<= (py-float-to-scheme x-1514) (py-sint-to-scheme y-1515))))))

(define-macro (py-test-le-floatX-sintY-inline x-1516 y-1517)
  `(let ((x-1516 ,x-1516) (y-1517 ,y-1517))
     (py-test-from-scheme
      (py<= (py-float-to-scheme x-1516) (py-sint-to-scheme y-1517)))))

(define-macro (py-le-floatX-bintY-inline x-1518 y-1519)
  `(py-le-floatX-bintY-fallback ,x-1518 ,y-1519))

(define-macro (py-test-le-floatX-bintY-inline x-1520 y-1521)
  `(py-test-le-floatX-bintY-fallback ,x-1520 ,y-1521))

(define-macro (py-le-boolX-floatY-inline x-1522 y-1523)
  `(py-le-boolX-floatY-fallback ,x-1522 ,y-1523))

(define-macro (py-test-le-boolX-floatY-inline x-1524 y-1525)
  `(py-test-le-boolX-floatY-fallback ,x-1524 ,y-1525))

(define-macro (py-le-boolX-boolY-inline x-1526 y-1527)
  `(py-le-boolX-boolY-fallback ,x-1526 ,y-1527))

(define-macro (py-test-le-boolX-boolY-inline x-1528 y-1529)
  `(py-test-le-boolX-boolY-fallback ,x-1528 ,y-1529))

(define-macro (py-le-boolX-strY-inline x-1530 y-1531)
  `(py-le-boolX-strY-fallback ,x-1530 ,y-1531))

(define-macro (py-test-le-boolX-strY-inline x-1532 y-1533)
  `(py-test-le-boolX-strY-fallback ,x-1532 ,y-1533))

(define-macro (py-le-boolX-sintY-inline x-1534 y-1535)
  `(py-le-boolX-sintY-fallback ,x-1534 ,y-1535))

(define-macro (py-test-le-boolX-sintY-inline x-1536 y-1537)
  `(py-test-le-boolX-sintY-fallback ,x-1536 ,y-1537))

(define-macro (py-le-boolX-bintY-inline x-1538 y-1539)
  `(py-le-boolX-bintY-fallback ,x-1538 ,y-1539))

(define-macro (py-test-le-boolX-bintY-inline x-1540 y-1541)
  `(py-test-le-boolX-bintY-fallback ,x-1540 ,y-1541))

(define-macro (py-le-strX-floatY-inline x-1542 y-1543)
  `(py-le-strX-floatY-fallback ,x-1542 ,y-1543))

(define-macro (py-test-le-strX-floatY-inline x-1544 y-1545)
  `(py-test-le-strX-floatY-fallback ,x-1544 ,y-1545))

(define-macro (py-le-strX-boolY-inline x-1546 y-1547)
  `(py-le-strX-boolY-fallback ,x-1546 ,y-1547))

(define-macro (py-test-le-strX-boolY-inline x-1548 y-1549)
  `(py-test-le-strX-boolY-fallback ,x-1548 ,y-1549))

(define-macro (py-le-strX-strY-inline x-1550 y-1551)
  `(py-le-strX-strY-fallback ,x-1550 ,y-1551))

(define-macro (py-test-le-strX-strY-inline x-1552 y-1553)
  `(py-test-le-strX-strY-fallback ,x-1552 ,y-1553))

(define-macro (py-le-strX-sintY-inline x-1554 y-1555)
  `(py-le-strX-sintY-fallback ,x-1554 ,y-1555))

(define-macro (py-test-le-strX-sintY-inline x-1556 y-1557)
  `(py-test-le-strX-sintY-fallback ,x-1556 ,y-1557))

(define-macro (py-le-strX-bintY-inline x-1558 y-1559)
  `(py-le-strX-bintY-fallback ,x-1558 ,y-1559))

(define-macro (py-test-le-strX-bintY-inline x-1560 y-1561)
  `(py-test-le-strX-bintY-fallback ,x-1560 ,y-1561))

(define-macro (py-le-sintX-floatY-inline x-1562 y-1563)
  `(let ((x-1562 ,x-1562) (y-1563 ,y-1563))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py>= (py-float-to-scheme y-1563) (py-sint-to-scheme x-1562))))))

(define-macro (py-test-le-sintX-floatY-inline x-1564 y-1565)
  `(let ((x-1564 ,x-1564) (y-1565 ,y-1565))
     (py-test-from-scheme
      (py>= (py-float-to-scheme y-1565) (py-sint-to-scheme x-1564)))))

(define-macro (py-le-sintX-boolY-inline x-1566 y-1567)
  `(py-le-sintX-boolY-fallback ,x-1566 ,y-1567))

(define-macro (py-test-le-sintX-boolY-inline x-1568 y-1569)
  `(py-test-le-sintX-boolY-fallback ,x-1568 ,y-1569))

(define-macro (py-le-sintX-strY-inline x-1570 y-1571)
  `(py-le-sintX-strY-fallback ,x-1570 ,y-1571))

(define-macro (py-test-le-sintX-strY-inline x-1572 y-1573)
  `(py-test-le-sintX-strY-fallback ,x-1572 ,y-1573))

(define-macro (py-le-sintX-sintY-inline x-1574 y-1575)
  `(let ((x-1574 ,x-1574) (y-1575 ,y-1575))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py<= (py-sint-to-scheme x-1574) (py-sint-to-scheme y-1575))))))

(define-macro (py-test-le-sintX-sintY-inline x-1576 y-1577)
  `(let ((x-1576 ,x-1576) (y-1577 ,y-1577))
     (py-test-from-scheme
      (py<= (py-sint-to-scheme x-1576) (py-sint-to-scheme y-1577)))))

(define-macro (py-le-sintX-bintY-inline x-1578 y-1579)
  `(py-le-sintX-bintY-fallback ,x-1578 ,y-1579))

(define-macro (py-test-le-sintX-bintY-inline x-1580 y-1581)
  `(py-test-le-sintX-bintY-fallback ,x-1580 ,y-1581))

(define-macro (py-le-bintX-floatY-inline x-1582 y-1583)
  `(py-le-bintX-floatY-fallback ,x-1582 ,y-1583))

(define-macro (py-test-le-bintX-floatY-inline x-1584 y-1585)
  `(py-test-le-bintX-floatY-fallback ,x-1584 ,y-1585))

(define-macro (py-le-bintX-boolY-inline x-1586 y-1587)
  `(py-le-bintX-boolY-fallback ,x-1586 ,y-1587))

(define-macro (py-test-le-bintX-boolY-inline x-1588 y-1589)
  `(py-test-le-bintX-boolY-fallback ,x-1588 ,y-1589))

(define-macro (py-le-bintX-strY-inline x-1590 y-1591)
  `(py-le-bintX-strY-fallback ,x-1590 ,y-1591))

(define-macro (py-test-le-bintX-strY-inline x-1592 y-1593)
  `(py-test-le-bintX-strY-fallback ,x-1592 ,y-1593))

(define-macro (py-le-bintX-sintY-inline x-1594 y-1595)
  `(py-le-bintX-sintY-fallback ,x-1594 ,y-1595))

(define-macro (py-test-le-bintX-sintY-inline x-1596 y-1597)
  `(py-test-le-bintX-sintY-fallback ,x-1596 ,y-1597))

(define-macro (py-le-bintX-bintY-inline x-1598 y-1599)
  `(py-le-bintX-bintY-fallback ,x-1598 ,y-1599))

(define-macro (py-test-le-bintX-bintY-inline x-1600 y-1601)
  `(py-test-le-bintX-bintY-fallback ,x-1600 ,y-1601))

(define-macro (py-lt-floatX-floatY-inline x-1602 y-1603)
  `(let ((x-1602 ,x-1602) (y-1603 ,y-1603))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py< (py-float-to-scheme x-1602) (py-float-to-scheme y-1603))))))

(define-macro (py-test-lt-floatX-floatY-inline x-1604 y-1605)
  `(let ((x-1604 ,x-1604) (y-1605 ,y-1605))
     (py-test-from-scheme
      (py< (py-float-to-scheme x-1604) (py-float-to-scheme y-1605)))))

(define-macro (py-lt-floatX-boolY-inline x-1606 y-1607)
  `(py-lt-floatX-boolY-fallback ,x-1606 ,y-1607))

(define-macro (py-test-lt-floatX-boolY-inline x-1608 y-1609)
  `(py-test-lt-floatX-boolY-fallback ,x-1608 ,y-1609))

(define-macro (py-lt-floatX-strY-inline x-1610 y-1611)
  `(py-lt-floatX-strY-fallback ,x-1610 ,y-1611))

(define-macro (py-test-lt-floatX-strY-inline x-1612 y-1613)
  `(py-test-lt-floatX-strY-fallback ,x-1612 ,y-1613))

(define-macro (py-lt-floatX-sintY-inline x-1614 y-1615)
  `(let ((x-1614 ,x-1614) (y-1615 ,y-1615))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py< (py-float-to-scheme x-1614) (py-sint-to-scheme y-1615))))))

(define-macro (py-test-lt-floatX-sintY-inline x-1616 y-1617)
  `(let ((x-1616 ,x-1616) (y-1617 ,y-1617))
     (py-test-from-scheme
      (py< (py-float-to-scheme x-1616) (py-sint-to-scheme y-1617)))))

(define-macro (py-lt-floatX-bintY-inline x-1618 y-1619)
  `(py-lt-floatX-bintY-fallback ,x-1618 ,y-1619))

(define-macro (py-test-lt-floatX-bintY-inline x-1620 y-1621)
  `(py-test-lt-floatX-bintY-fallback ,x-1620 ,y-1621))

(define-macro (py-lt-boolX-floatY-inline x-1622 y-1623)
  `(py-lt-boolX-floatY-fallback ,x-1622 ,y-1623))

(define-macro (py-test-lt-boolX-floatY-inline x-1624 y-1625)
  `(py-test-lt-boolX-floatY-fallback ,x-1624 ,y-1625))

(define-macro (py-lt-boolX-boolY-inline x-1626 y-1627)
  `(py-lt-boolX-boolY-fallback ,x-1626 ,y-1627))

(define-macro (py-test-lt-boolX-boolY-inline x-1628 y-1629)
  `(py-test-lt-boolX-boolY-fallback ,x-1628 ,y-1629))

(define-macro (py-lt-boolX-strY-inline x-1630 y-1631)
  `(py-lt-boolX-strY-fallback ,x-1630 ,y-1631))

(define-macro (py-test-lt-boolX-strY-inline x-1632 y-1633)
  `(py-test-lt-boolX-strY-fallback ,x-1632 ,y-1633))

(define-macro (py-lt-boolX-sintY-inline x-1634 y-1635)
  `(py-lt-boolX-sintY-fallback ,x-1634 ,y-1635))

(define-macro (py-test-lt-boolX-sintY-inline x-1636 y-1637)
  `(py-test-lt-boolX-sintY-fallback ,x-1636 ,y-1637))

(define-macro (py-lt-boolX-bintY-inline x-1638 y-1639)
  `(py-lt-boolX-bintY-fallback ,x-1638 ,y-1639))

(define-macro (py-test-lt-boolX-bintY-inline x-1640 y-1641)
  `(py-test-lt-boolX-bintY-fallback ,x-1640 ,y-1641))

(define-macro (py-lt-strX-floatY-inline x-1642 y-1643)
  `(py-lt-strX-floatY-fallback ,x-1642 ,y-1643))

(define-macro (py-test-lt-strX-floatY-inline x-1644 y-1645)
  `(py-test-lt-strX-floatY-fallback ,x-1644 ,y-1645))

(define-macro (py-lt-strX-boolY-inline x-1646 y-1647)
  `(py-lt-strX-boolY-fallback ,x-1646 ,y-1647))

(define-macro (py-test-lt-strX-boolY-inline x-1648 y-1649)
  `(py-test-lt-strX-boolY-fallback ,x-1648 ,y-1649))

(define-macro (py-lt-strX-strY-inline x-1650 y-1651)
  `(py-lt-strX-strY-fallback ,x-1650 ,y-1651))

(define-macro (py-test-lt-strX-strY-inline x-1652 y-1653)
  `(py-test-lt-strX-strY-fallback ,x-1652 ,y-1653))

(define-macro (py-lt-strX-sintY-inline x-1654 y-1655)
  `(py-lt-strX-sintY-fallback ,x-1654 ,y-1655))

(define-macro (py-test-lt-strX-sintY-inline x-1656 y-1657)
  `(py-test-lt-strX-sintY-fallback ,x-1656 ,y-1657))

(define-macro (py-lt-strX-bintY-inline x-1658 y-1659)
  `(py-lt-strX-bintY-fallback ,x-1658 ,y-1659))

(define-macro (py-test-lt-strX-bintY-inline x-1660 y-1661)
  `(py-test-lt-strX-bintY-fallback ,x-1660 ,y-1661))

(define-macro (py-lt-sintX-floatY-inline x-1662 y-1663)
  `(let ((x-1662 ,x-1662) (y-1663 ,y-1663))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py> (py-float-to-scheme y-1663) (py-sint-to-scheme x-1662))))))

(define-macro (py-test-lt-sintX-floatY-inline x-1664 y-1665)
  `(let ((x-1664 ,x-1664) (y-1665 ,y-1665))
     (py-test-from-scheme
      (py> (py-float-to-scheme y-1665) (py-sint-to-scheme x-1664)))))

(define-macro (py-lt-sintX-boolY-inline x-1666 y-1667)
  `(py-lt-sintX-boolY-fallback ,x-1666 ,y-1667))

(define-macro (py-test-lt-sintX-boolY-inline x-1668 y-1669)
  `(py-test-lt-sintX-boolY-fallback ,x-1668 ,y-1669))

(define-macro (py-lt-sintX-strY-inline x-1670 y-1671)
  `(py-lt-sintX-strY-fallback ,x-1670 ,y-1671))

(define-macro (py-test-lt-sintX-strY-inline x-1672 y-1673)
  `(py-test-lt-sintX-strY-fallback ,x-1672 ,y-1673))

(define-macro (py-lt-sintX-sintY-inline x-1674 y-1675)
  `(let ((x-1674 ,x-1674) (y-1675 ,y-1675))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py< (py-sint-to-scheme x-1674) (py-sint-to-scheme y-1675))))))

(define-macro (py-test-lt-sintX-sintY-inline x-1676 y-1677)
  `(let ((x-1676 ,x-1676) (y-1677 ,y-1677))
     (py-test-from-scheme
      (py< (py-sint-to-scheme x-1676) (py-sint-to-scheme y-1677)))))

(define-macro (py-lt-sintX-bintY-inline x-1678 y-1679)
  `(py-lt-sintX-bintY-fallback ,x-1678 ,y-1679))

(define-macro (py-test-lt-sintX-bintY-inline x-1680 y-1681)
  `(py-test-lt-sintX-bintY-fallback ,x-1680 ,y-1681))

(define-macro (py-lt-bintX-floatY-inline x-1682 y-1683)
  `(py-lt-bintX-floatY-fallback ,x-1682 ,y-1683))

(define-macro (py-test-lt-bintX-floatY-inline x-1684 y-1685)
  `(py-test-lt-bintX-floatY-fallback ,x-1684 ,y-1685))

(define-macro (py-lt-bintX-boolY-inline x-1686 y-1687)
  `(py-lt-bintX-boolY-fallback ,x-1686 ,y-1687))

(define-macro (py-test-lt-bintX-boolY-inline x-1688 y-1689)
  `(py-test-lt-bintX-boolY-fallback ,x-1688 ,y-1689))

(define-macro (py-lt-bintX-strY-inline x-1690 y-1691)
  `(py-lt-bintX-strY-fallback ,x-1690 ,y-1691))

(define-macro (py-test-lt-bintX-strY-inline x-1692 y-1693)
  `(py-test-lt-bintX-strY-fallback ,x-1692 ,y-1693))

(define-macro (py-lt-bintX-sintY-inline x-1694 y-1695)
  `(py-lt-bintX-sintY-fallback ,x-1694 ,y-1695))

(define-macro (py-test-lt-bintX-sintY-inline x-1696 y-1697)
  `(py-test-lt-bintX-sintY-fallback ,x-1696 ,y-1697))

(define-macro (py-lt-bintX-bintY-inline x-1698 y-1699)
  `(py-lt-bintX-bintY-fallback ,x-1698 ,y-1699))

(define-macro (py-test-lt-bintX-bintY-inline x-1700 y-1701)
  `(py-test-lt-bintX-bintY-fallback ,x-1700 ,y-1701))

(define-macro (py-eq-floatX-floatY-inline x-1702 y-1703)
  `(let ((x-1702 ,x-1702) (y-1703 ,y-1703))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py== (py-float-to-scheme x-1702) (py-float-to-scheme y-1703))))))

(define-macro (py-test-eq-floatX-floatY-inline x-1704 y-1705)
  `(let ((x-1704 ,x-1704) (y-1705 ,y-1705))
     (py-test-from-scheme
      (py== (py-float-to-scheme x-1704) (py-float-to-scheme y-1705)))))

(define-macro (py-eq-floatX-boolY-inline x-1706 y-1707)
  `(py-eq-floatX-boolY-fallback ,x-1706 ,y-1707))

(define-macro (py-test-eq-floatX-boolY-inline x-1708 y-1709)
  `(py-test-eq-floatX-boolY-fallback ,x-1708 ,y-1709))

(define-macro (py-eq-floatX-strY-inline x-1710 y-1711)
  `(py-eq-floatX-strY-fallback ,x-1710 ,y-1711))

(define-macro (py-test-eq-floatX-strY-inline x-1712 y-1713)
  `(py-test-eq-floatX-strY-fallback ,x-1712 ,y-1713))

(define-macro (py-eq-floatX-sintY-inline x-1714 y-1715)
  `(let ((x-1714 ,x-1714) (y-1715 ,y-1715))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py== (py-float-to-scheme x-1714) (py-sint-to-scheme y-1715))))))

(define-macro (py-test-eq-floatX-sintY-inline x-1716 y-1717)
  `(let ((x-1716 ,x-1716) (y-1717 ,y-1717))
     (py-test-from-scheme
      (py== (py-float-to-scheme x-1716) (py-sint-to-scheme y-1717)))))

(define-macro (py-eq-floatX-bintY-inline x-1718 y-1719)
  `(py-eq-floatX-bintY-fallback ,x-1718 ,y-1719))

(define-macro (py-test-eq-floatX-bintY-inline x-1720 y-1721)
  `(py-test-eq-floatX-bintY-fallback ,x-1720 ,y-1721))

(define-macro (py-eq-boolX-floatY-inline x-1722 y-1723)
  `(py-eq-boolX-floatY-fallback ,x-1722 ,y-1723))

(define-macro (py-test-eq-boolX-floatY-inline x-1724 y-1725)
  `(py-test-eq-boolX-floatY-fallback ,x-1724 ,y-1725))

(define-macro (py-eq-boolX-boolY-inline x-1726 y-1727)
  `(py-eq-boolX-boolY-fallback ,x-1726 ,y-1727))

(define-macro (py-test-eq-boolX-boolY-inline x-1728 y-1729)
  `(py-test-eq-boolX-boolY-fallback ,x-1728 ,y-1729))

(define-macro (py-eq-boolX-strY-inline x-1730 y-1731)
  `(py-eq-boolX-strY-fallback ,x-1730 ,y-1731))

(define-macro (py-test-eq-boolX-strY-inline x-1732 y-1733)
  `(py-test-eq-boolX-strY-fallback ,x-1732 ,y-1733))

(define-macro (py-eq-boolX-sintY-inline x-1734 y-1735)
  `(py-eq-boolX-sintY-fallback ,x-1734 ,y-1735))

(define-macro (py-test-eq-boolX-sintY-inline x-1736 y-1737)
  `(py-test-eq-boolX-sintY-fallback ,x-1736 ,y-1737))

(define-macro (py-eq-boolX-bintY-inline x-1738 y-1739)
  `(py-eq-boolX-bintY-fallback ,x-1738 ,y-1739))

(define-macro (py-test-eq-boolX-bintY-inline x-1740 y-1741)
  `(py-test-eq-boolX-bintY-fallback ,x-1740 ,y-1741))

(define-macro (py-eq-strX-floatY-inline x-1742 y-1743)
  `(py-eq-strX-floatY-fallback ,x-1742 ,y-1743))

(define-macro (py-test-eq-strX-floatY-inline x-1744 y-1745)
  `(py-test-eq-strX-floatY-fallback ,x-1744 ,y-1745))

(define-macro (py-eq-strX-boolY-inline x-1746 y-1747)
  `(py-eq-strX-boolY-fallback ,x-1746 ,y-1747))

(define-macro (py-test-eq-strX-boolY-inline x-1748 y-1749)
  `(py-test-eq-strX-boolY-fallback ,x-1748 ,y-1749))

(define-macro (py-eq-strX-strY-inline x-1750 y-1751)
  `(py-eq-strX-strY-fallback ,x-1750 ,y-1751))

(define-macro (py-test-eq-strX-strY-inline x-1752 y-1753)
  `(py-test-eq-strX-strY-fallback ,x-1752 ,y-1753))

(define-macro (py-eq-strX-sintY-inline x-1754 y-1755)
  `(py-eq-strX-sintY-fallback ,x-1754 ,y-1755))

(define-macro (py-test-eq-strX-sintY-inline x-1756 y-1757)
  `(py-test-eq-strX-sintY-fallback ,x-1756 ,y-1757))

(define-macro (py-eq-strX-bintY-inline x-1758 y-1759)
  `(py-eq-strX-bintY-fallback ,x-1758 ,y-1759))

(define-macro (py-test-eq-strX-bintY-inline x-1760 y-1761)
  `(py-test-eq-strX-bintY-fallback ,x-1760 ,y-1761))

(define-macro (py-eq-sintX-floatY-inline x-1762 y-1763)
  `(let ((x-1762 ,x-1762) (y-1763 ,y-1763))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py== (py-float-to-scheme y-1763) (py-sint-to-scheme x-1762))))))

(define-macro (py-test-eq-sintX-floatY-inline x-1764 y-1765)
  `(let ((x-1764 ,x-1764) (y-1765 ,y-1765))
     (py-test-from-scheme
      (py== (py-float-to-scheme y-1765) (py-sint-to-scheme x-1764)))))

(define-macro (py-eq-sintX-boolY-inline x-1766 y-1767)
  `(py-eq-sintX-boolY-fallback ,x-1766 ,y-1767))

(define-macro (py-test-eq-sintX-boolY-inline x-1768 y-1769)
  `(py-test-eq-sintX-boolY-fallback ,x-1768 ,y-1769))

(define-macro (py-eq-sintX-strY-inline x-1770 y-1771)
  `(py-eq-sintX-strY-fallback ,x-1770 ,y-1771))

(define-macro (py-test-eq-sintX-strY-inline x-1772 y-1773)
  `(py-test-eq-sintX-strY-fallback ,x-1772 ,y-1773))

(define-macro (py-eq-sintX-sintY-inline x-1774 y-1775)
  `(let ((x-1774 ,x-1774) (y-1775 ,y-1775))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py== (py-sint-to-scheme x-1774) (py-sint-to-scheme y-1775))))))

(define-macro (py-test-eq-sintX-sintY-inline x-1776 y-1777)
  `(let ((x-1776 ,x-1776) (y-1777 ,y-1777))
     (py-test-from-scheme
      (py== (py-sint-to-scheme x-1776) (py-sint-to-scheme y-1777)))))

(define-macro (py-eq-sintX-bintY-inline x-1778 y-1779)
  `(py-eq-sintX-bintY-fallback ,x-1778 ,y-1779))

(define-macro (py-test-eq-sintX-bintY-inline x-1780 y-1781)
  `(py-test-eq-sintX-bintY-fallback ,x-1780 ,y-1781))

(define-macro (py-eq-bintX-floatY-inline x-1782 y-1783)
  `(py-eq-bintX-floatY-fallback ,x-1782 ,y-1783))

(define-macro (py-test-eq-bintX-floatY-inline x-1784 y-1785)
  `(py-test-eq-bintX-floatY-fallback ,x-1784 ,y-1785))

(define-macro (py-eq-bintX-boolY-inline x-1786 y-1787)
  `(py-eq-bintX-boolY-fallback ,x-1786 ,y-1787))

(define-macro (py-test-eq-bintX-boolY-inline x-1788 y-1789)
  `(py-test-eq-bintX-boolY-fallback ,x-1788 ,y-1789))

(define-macro (py-eq-bintX-strY-inline x-1790 y-1791)
  `(py-eq-bintX-strY-fallback ,x-1790 ,y-1791))

(define-macro (py-test-eq-bintX-strY-inline x-1792 y-1793)
  `(py-test-eq-bintX-strY-fallback ,x-1792 ,y-1793))

(define-macro (py-eq-bintX-sintY-inline x-1794 y-1795)
  `(py-eq-bintX-sintY-fallback ,x-1794 ,y-1795))

(define-macro (py-test-eq-bintX-sintY-inline x-1796 y-1797)
  `(py-test-eq-bintX-sintY-fallback ,x-1796 ,y-1797))

(define-macro (py-eq-bintX-bintY-inline x-1798 y-1799)
  `(py-eq-bintX-bintY-fallback ,x-1798 ,y-1799))

(define-macro (py-test-eq-bintX-bintY-inline x-1800 y-1801)
  `(py-test-eq-bintX-bintY-fallback ,x-1800 ,y-1801))

(define-macro (py-ne-floatX-floatY-inline x-1802 y-1803)
  `(let ((x-1802 ,x-1802) (y-1803 ,y-1803))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py!= (py-float-to-scheme x-1802) (py-float-to-scheme y-1803))))))

(define-macro (py-test-ne-floatX-floatY-inline x-1804 y-1805)
  `(let ((x-1804 ,x-1804) (y-1805 ,y-1805))
     (py-test-from-scheme
      (py!= (py-float-to-scheme x-1804) (py-float-to-scheme y-1805)))))

(define-macro (py-ne-floatX-boolY-inline x-1806 y-1807)
  `(py-ne-floatX-boolY-fallback ,x-1806 ,y-1807))

(define-macro (py-test-ne-floatX-boolY-inline x-1808 y-1809)
  `(py-test-ne-floatX-boolY-fallback ,x-1808 ,y-1809))

(define-macro (py-ne-floatX-strY-inline x-1810 y-1811)
  `(py-ne-floatX-strY-fallback ,x-1810 ,y-1811))

(define-macro (py-test-ne-floatX-strY-inline x-1812 y-1813)
  `(py-test-ne-floatX-strY-fallback ,x-1812 ,y-1813))

(define-macro (py-ne-floatX-sintY-inline x-1814 y-1815)
  `(let ((x-1814 ,x-1814) (y-1815 ,y-1815))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py!= (py-float-to-scheme x-1814) (py-sint-to-scheme y-1815))))))

(define-macro (py-test-ne-floatX-sintY-inline x-1816 y-1817)
  `(let ((x-1816 ,x-1816) (y-1817 ,y-1817))
     (py-test-from-scheme
      (py!= (py-float-to-scheme x-1816) (py-sint-to-scheme y-1817)))))

(define-macro (py-ne-floatX-bintY-inline x-1818 y-1819)
  `(py-ne-floatX-bintY-fallback ,x-1818 ,y-1819))

(define-macro (py-test-ne-floatX-bintY-inline x-1820 y-1821)
  `(py-test-ne-floatX-bintY-fallback ,x-1820 ,y-1821))

(define-macro (py-ne-boolX-floatY-inline x-1822 y-1823)
  `(py-ne-boolX-floatY-fallback ,x-1822 ,y-1823))

(define-macro (py-test-ne-boolX-floatY-inline x-1824 y-1825)
  `(py-test-ne-boolX-floatY-fallback ,x-1824 ,y-1825))

(define-macro (py-ne-boolX-boolY-inline x-1826 y-1827)
  `(py-ne-boolX-boolY-fallback ,x-1826 ,y-1827))

(define-macro (py-test-ne-boolX-boolY-inline x-1828 y-1829)
  `(py-test-ne-boolX-boolY-fallback ,x-1828 ,y-1829))

(define-macro (py-ne-boolX-strY-inline x-1830 y-1831)
  `(py-ne-boolX-strY-fallback ,x-1830 ,y-1831))

(define-macro (py-test-ne-boolX-strY-inline x-1832 y-1833)
  `(py-test-ne-boolX-strY-fallback ,x-1832 ,y-1833))

(define-macro (py-ne-boolX-sintY-inline x-1834 y-1835)
  `(py-ne-boolX-sintY-fallback ,x-1834 ,y-1835))

(define-macro (py-test-ne-boolX-sintY-inline x-1836 y-1837)
  `(py-test-ne-boolX-sintY-fallback ,x-1836 ,y-1837))

(define-macro (py-ne-boolX-bintY-inline x-1838 y-1839)
  `(py-ne-boolX-bintY-fallback ,x-1838 ,y-1839))

(define-macro (py-test-ne-boolX-bintY-inline x-1840 y-1841)
  `(py-test-ne-boolX-bintY-fallback ,x-1840 ,y-1841))

(define-macro (py-ne-strX-floatY-inline x-1842 y-1843)
  `(py-ne-strX-floatY-fallback ,x-1842 ,y-1843))

(define-macro (py-test-ne-strX-floatY-inline x-1844 y-1845)
  `(py-test-ne-strX-floatY-fallback ,x-1844 ,y-1845))

(define-macro (py-ne-strX-boolY-inline x-1846 y-1847)
  `(py-ne-strX-boolY-fallback ,x-1846 ,y-1847))

(define-macro (py-test-ne-strX-boolY-inline x-1848 y-1849)
  `(py-test-ne-strX-boolY-fallback ,x-1848 ,y-1849))

(define-macro (py-ne-strX-strY-inline x-1850 y-1851)
  `(py-ne-strX-strY-fallback ,x-1850 ,y-1851))

(define-macro (py-test-ne-strX-strY-inline x-1852 y-1853)
  `(py-test-ne-strX-strY-fallback ,x-1852 ,y-1853))

(define-macro (py-ne-strX-sintY-inline x-1854 y-1855)
  `(py-ne-strX-sintY-fallback ,x-1854 ,y-1855))

(define-macro (py-test-ne-strX-sintY-inline x-1856 y-1857)
  `(py-test-ne-strX-sintY-fallback ,x-1856 ,y-1857))

(define-macro (py-ne-strX-bintY-inline x-1858 y-1859)
  `(py-ne-strX-bintY-fallback ,x-1858 ,y-1859))

(define-macro (py-test-ne-strX-bintY-inline x-1860 y-1861)
  `(py-test-ne-strX-bintY-fallback ,x-1860 ,y-1861))

(define-macro (py-ne-sintX-floatY-inline x-1862 y-1863)
  `(let ((x-1862 ,x-1862) (y-1863 ,y-1863))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py!= (py-float-to-scheme y-1863) (py-sint-to-scheme x-1862))))))

(define-macro (py-test-ne-sintX-floatY-inline x-1864 y-1865)
  `(let ((x-1864 ,x-1864) (y-1865 ,y-1865))
     (py-test-from-scheme
      (py!= (py-float-to-scheme y-1865) (py-sint-to-scheme x-1864)))))

(define-macro (py-ne-sintX-boolY-inline x-1866 y-1867)
  `(py-ne-sintX-boolY-fallback ,x-1866 ,y-1867))

(define-macro (py-test-ne-sintX-boolY-inline x-1868 y-1869)
  `(py-test-ne-sintX-boolY-fallback ,x-1868 ,y-1869))

(define-macro (py-ne-sintX-strY-inline x-1870 y-1871)
  `(py-ne-sintX-strY-fallback ,x-1870 ,y-1871))

(define-macro (py-test-ne-sintX-strY-inline x-1872 y-1873)
  `(py-test-ne-sintX-strY-fallback ,x-1872 ,y-1873))

(define-macro (py-ne-sintX-sintY-inline x-1874 y-1875)
  `(let ((x-1874 ,x-1874) (y-1875 ,y-1875))
     (py-bool-from-scheme-bool
      (py-test-from-scheme
       (py!= (py-sint-to-scheme x-1874) (py-sint-to-scheme y-1875))))))

(define-macro (py-test-ne-sintX-sintY-inline x-1876 y-1877)
  `(let ((x-1876 ,x-1876) (y-1877 ,y-1877))
     (py-test-from-scheme
      (py!= (py-sint-to-scheme x-1876) (py-sint-to-scheme y-1877)))))

(define-macro (py-ne-sintX-bintY-inline x-1878 y-1879)
  `(py-ne-sintX-bintY-fallback ,x-1878 ,y-1879))

(define-macro (py-test-ne-sintX-bintY-inline x-1880 y-1881)
  `(py-test-ne-sintX-bintY-fallback ,x-1880 ,y-1881))

(define-macro (py-ne-bintX-floatY-inline x-1882 y-1883)
  `(py-ne-bintX-floatY-fallback ,x-1882 ,y-1883))

(define-macro (py-test-ne-bintX-floatY-inline x-1884 y-1885)
  `(py-test-ne-bintX-floatY-fallback ,x-1884 ,y-1885))

(define-macro (py-ne-bintX-boolY-inline x-1886 y-1887)
  `(py-ne-bintX-boolY-fallback ,x-1886 ,y-1887))

(define-macro (py-test-ne-bintX-boolY-inline x-1888 y-1889)
  `(py-test-ne-bintX-boolY-fallback ,x-1888 ,y-1889))

(define-macro (py-ne-bintX-strY-inline x-1890 y-1891)
  `(py-ne-bintX-strY-fallback ,x-1890 ,y-1891))

(define-macro (py-test-ne-bintX-strY-inline x-1892 y-1893)
  `(py-test-ne-bintX-strY-fallback ,x-1892 ,y-1893))

(define-macro (py-ne-bintX-sintY-inline x-1894 y-1895)
  `(py-ne-bintX-sintY-fallback ,x-1894 ,y-1895))

(define-macro (py-test-ne-bintX-sintY-inline x-1896 y-1897)
  `(py-test-ne-bintX-sintY-fallback ,x-1896 ,y-1897))

(define-macro (py-ne-bintX-bintY-inline x-1898 y-1899)
  `(py-ne-bintX-bintY-fallback ,x-1898 ,y-1899))

(define-macro (py-test-ne-bintX-bintY-inline x-1900 y-1901)
  `(py-test-ne-bintX-bintY-fallback ,x-1900 ,y-1901))

(define-macro (py-pos-floatX-inline x-1902) `(let ((x-1902 ,x-1902)) x-1902))

(define-macro (py-pos-boolX-inline x-1903) `(py-pos-boolX-fallback ,x-1903))

(define-macro (py-pos-strX-inline x-1904) `(py-pos-strX-fallback ,x-1904))

(define-macro (py-pos-sintX-inline x-1905)
  `(let ((x-1905 ,x-1905)) (py-int-from-scheme (py-sint-to-scheme x-1905))))

(define-macro (py-pos-bintX-inline x-1906) `(py-pos-bintX-fallback ,x-1906))

(define-macro (py-neg-floatX-inline x-1907)
  `(let ((x-1907 ,x-1907))
     (py-float-from-scheme (pyneg (py-float-to-scheme x-1907)))))

(define-macro (py-neg-boolX-inline x-1908) `(py-neg-boolX-fallback ,x-1908))

(define-macro (py-neg-strX-inline x-1909) `(py-neg-strX-fallback ,x-1909))

(define-macro (py-neg-sintX-inline x-1910)
  `(let ((x-1910 ,x-1910))
     (py-int-from-scheme (pyneg (py-sint-to-scheme x-1910)))))

(define-macro (py-neg-bintX-inline x-1911) `(py-neg-bintX-fallback ,x-1911))

(define-macro (py-invert-floatX-inline x-1912)
  `(let ((x-1912 ,x-1912))
     (py-throw
      (py-call py-builtin-TypeError
               (&& "bad operand type for unary ~: 'float'")))))

(define-macro (py-invert-boolX-inline x-1913)
  `(py-invert-boolX-fallback ,x-1913))

(define-macro (py-invert-strX-inline x-1914)
  `(py-invert-strX-fallback ,x-1914))

(define-macro (py-invert-sintX-inline x-1915)
  `(let ((x-1915 ,x-1915))
     (py-int-from-scheme (pyinvert (py-sint-to-scheme x-1915)))))

(define-macro (py-invert-bintX-inline x-1916)
  `(py-invert-bintX-fallback ,x-1916))

(define-macro (py-truth-floatX-inline obj-1917)
  `(let ((obj-1917 ,obj-1917))
     (py-bool-from-scheme-bool
      (py-test-from-scheme (py!= (py-float-to-scheme obj-1917) 0.)))))

(define-macro (py-truth-boolX-inline obj-1918)
  `(py-truth-boolX-fallback ,obj-1918))

(define-macro (py-truth-strX-inline obj-1919)
  `(py-truth-strX-fallback ,obj-1919))

(define-macro (py-truth-sintX-inline obj-1920)
  `(let ((obj-1920 ,obj-1920))
     (py-bool-from-scheme-bool
      (py-test-from-scheme (py!= (py-sint-to-scheme obj-1920) 0)))))

(define-macro (py-truth-bintX-inline obj-1921)
  `(py-truth-bintX-fallback ,obj-1921))

(define-macro (py-test-floatX-inline obj-1922)
  `(let ((obj-1922 ,obj-1922))
     (py-test-from-scheme (py!= (py-float-to-scheme obj-1922) 0.))))

(define-macro (py-test-boolX-inline obj-1923)
  `(py-test-boolX-fallback ,obj-1923))

(define-macro (py-test-strX-inline obj-1924)
  `(py-test-strX-fallback ,obj-1924))

(define-macro (py-test-sintX-inline obj-1925)
  `(let ((obj-1925 ,obj-1925))
     (py-test-from-scheme (py!= (py-sint-to-scheme obj-1925) 0))))

(define-macro (py-test-bintX-inline obj-1926)
  `(py-test-bintX-fallback ,obj-1926))

(define (py-add-floatX-floatY-fallback x-2 y-3)
  (py-float-from-scheme
   (py+ (py-float-to-scheme x-2) (py-float-to-scheme y-3))))

(define (py-add-floatX-boolY-fallback x-4 y-5)
  (py-float-from-scheme
   (py+ (py-float-to-scheme x-4) (py-bool-to-scheme-int y-5))))

(define (py-add-floatX-strY-fallback x-6 y-7)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for +: 'float' and 'str'"))))

(define (py-add-floatX-sintY-fallback x-8 y-9)
  (py-float-from-scheme
   (py+ (py-float-to-scheme x-8) (py-sint-to-scheme y-9))))

(define (py-add-floatX-bintY-fallback x-10 y-11)
  (py-float-from-scheme
   (py+ (py-float-to-scheme x-10) (py-bint-to-scheme y-11))))

(define (py-add-boolX-floatY-fallback x-12 y-13)
  (py-float-from-scheme
   (py+ (py-bool-to-scheme-int x-12) (py-float-to-scheme y-13))))

(define (py-add-boolX-boolY-fallback x-14 y-15)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme-int x-14) (py-bool-to-scheme-int y-15))))

(define (py-add-boolX-strY-fallback x-16 y-17)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for +: 'bool' and 'str'"))))

(define (py-add-boolX-sintY-fallback x-18 y-19)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme-int x-18) (py-sint-to-scheme y-19))))

(define (py-add-boolX-bintY-fallback x-20 y-21)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme-int x-20) (py-bint-to-scheme y-21))))

(define (py-add-strX-floatY-fallback x-22 y-23)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for +: 'str' and 'float'"))))

(define (py-add-strX-boolY-fallback x-24 y-25)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for +: 'str' and 'bool'"))))

(define (py-add-strX-strY-fallback x-26 y-27)
  (py-str-from-scheme (py+ (py-str-to-scheme x-26) (py-str-to-scheme y-27))))

(define (py-add-strX-sintY-fallback x-28 y-29)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for +: 'str' and 'int'"))))

(define (py-add-strX-bintY-fallback x-30 y-31)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for +: 'str' and 'int'"))))

(define (py-add-sintX-floatY-fallback x-32 y-33)
  (py-float-from-scheme
   (py+ (py-sint-to-scheme x-32) (py-float-to-scheme y-33))))

(define (py-add-sintX-boolY-fallback x-34 y-35)
  (py-int-from-scheme
   (py+ (py-sint-to-scheme x-34) (py-bool-to-scheme-int y-35))))

(define (py-add-sintX-strY-fallback x-36 y-37)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for +: 'int' and 'str'"))))

(define (py-add-sintX-sintY-fallback x-38 y-39)
  (py-int-from-scheme (py+ (py-sint-to-scheme x-38) (py-sint-to-scheme y-39))))

(define (py-add-sintX-bintY-fallback x-40 y-41)
  (py-int-from-scheme (py+ (py-sint-to-scheme x-40) (py-bint-to-scheme y-41))))

(define (py-add-bintX-floatY-fallback x-42 y-43)
  (py-float-from-scheme
   (py+ (py-bint-to-scheme x-42) (py-float-to-scheme y-43))))

(define (py-add-bintX-boolY-fallback x-44 y-45)
  (py-int-from-scheme
   (py+ (py-bint-to-scheme x-44) (py-bool-to-scheme-int y-45))))

(define (py-add-bintX-strY-fallback x-46 y-47)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for +: 'int' and 'str'"))))

(define (py-add-bintX-sintY-fallback x-48 y-49)
  (py-int-from-scheme (py+ (py-bint-to-scheme x-48) (py-sint-to-scheme y-49))))

(define (py-add-bintX-bintY-fallback x-50 y-51)
  (py-int-from-scheme (py+ (py-bint-to-scheme x-50) (py-bint-to-scheme y-51))))

(define (py-bitand-floatX-floatY-fallback x-52 y-53)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'float'"))))

(define (py-bitand-floatX-boolY-fallback x-54 y-55)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'bool'"))))

(define (py-bitand-floatX-strY-fallback x-56 y-57)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'str'"))))

(define (py-bitand-floatX-sintY-fallback x-58 y-59)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'int'"))))

(define (py-bitand-floatX-bintY-fallback x-60 y-61)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'float' and 'int'"))))

(define (py-bitand-boolX-floatY-fallback x-62 y-63)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'bool' and 'float'"))))

(define (py-bitand-boolX-boolY-fallback x-64 y-65)
  (if (py-test (py-is x-64 py-True)) y-65 py-False))

(define (py-bitand-boolX-strY-fallback x-66 y-67)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'bool' and 'str'"))))

(define (py-bitand-boolX-sintY-fallback x-68 y-69)
  (py-int-from-scheme
   (py& (py-bool-to-scheme-int x-68) (py-sint-to-scheme y-69))))

(define (py-bitand-boolX-bintY-fallback x-70 y-71)
  (py-int-from-scheme
   (py& (py-bool-to-scheme-int x-70) (py-bint-to-scheme y-71))))

(define (py-bitand-strX-floatY-fallback x-72 y-73)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'str' and 'float'"))))

(define (py-bitand-strX-boolY-fallback x-74 y-75)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'str' and 'bool'"))))

(define (py-bitand-strX-strY-fallback x-76 y-77)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'str' and 'str'"))))

(define (py-bitand-strX-sintY-fallback x-78 y-79)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'str' and 'int'"))))

(define (py-bitand-strX-bintY-fallback x-80 y-81)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'str' and 'int'"))))

(define (py-bitand-sintX-floatY-fallback x-82 y-83)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'int' and 'float'"))))

(define (py-bitand-sintX-boolY-fallback x-84 y-85)
  (py-int-from-scheme
   (py& (py-sint-to-scheme x-84) (py-bool-to-scheme-int y-85))))

(define (py-bitand-sintX-strY-fallback x-86 y-87)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'int' and 'str'"))))

(define (py-bitand-sintX-sintY-fallback x-88 y-89)
  (py-int-from-scheme (py& (py-sint-to-scheme x-88) (py-sint-to-scheme y-89))))

(define (py-bitand-sintX-bintY-fallback x-90 y-91)
  (py-int-from-scheme (py& (py-sint-to-scheme x-90) (py-bint-to-scheme y-91))))

(define (py-bitand-bintX-floatY-fallback x-92 y-93)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'int' and 'float'"))))

(define (py-bitand-bintX-boolY-fallback x-94 y-95)
  (py-int-from-scheme
   (py& (py-bint-to-scheme x-94) (py-bool-to-scheme-int y-95))))

(define (py-bitand-bintX-strY-fallback x-96 y-97)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &: 'int' and 'str'"))))

(define (py-bitand-bintX-sintY-fallback x-98 y-99)
  (py-int-from-scheme (py& (py-bint-to-scheme x-98) (py-sint-to-scheme y-99))))

(define (py-bitand-bintX-bintY-fallback x-100 y-101)
  (py-int-from-scheme
   (py& (py-bint-to-scheme x-100) (py-bint-to-scheme y-101))))

(define (py-bitor-floatX-floatY-fallback x-102 y-103)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'float'"))))

(define (py-bitor-floatX-boolY-fallback x-104 y-105)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'bool'"))))

(define (py-bitor-floatX-strY-fallback x-106 y-107)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'str'"))))

(define (py-bitor-floatX-sintY-fallback x-108 y-109)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'int'"))))

(define (py-bitor-floatX-bintY-fallback x-110 y-111)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'float' and 'int'"))))

(define (py-bitor-boolX-floatY-fallback x-112 y-113)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'bool' and 'float'"))))

(define (py-bitor-boolX-boolY-fallback x-114 y-115)
  (if (py-test (py-is x-114 py-True)) py-True y-115))

(define (py-bitor-boolX-strY-fallback x-116 y-117)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'bool' and 'str'"))))

(define (py-bitor-boolX-sintY-fallback x-118 y-119)
  (py-int-from-scheme
   (py+b (py-bool-to-scheme-int x-118) (py-sint-to-scheme y-119))))

(define (py-bitor-boolX-bintY-fallback x-120 y-121)
  (py-int-from-scheme
   (py+b (py-bool-to-scheme-int x-120) (py-bint-to-scheme y-121))))

(define (py-bitor-strX-floatY-fallback x-122 y-123)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'str' and 'float'"))))

(define (py-bitor-strX-boolY-fallback x-124 y-125)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'str' and 'bool'"))))

(define (py-bitor-strX-strY-fallback x-126 y-127)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'str' and 'str'"))))

(define (py-bitor-strX-sintY-fallback x-128 y-129)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'str' and 'int'"))))

(define (py-bitor-strX-bintY-fallback x-130 y-131)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'str' and 'int'"))))

(define (py-bitor-sintX-floatY-fallback x-132 y-133)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'int' and 'float'"))))

(define (py-bitor-sintX-boolY-fallback x-134 y-135)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme x-134) (py-bool-to-scheme-int y-135))))

(define (py-bitor-sintX-strY-fallback x-136 y-137)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'int' and 'str'"))))

(define (py-bitor-sintX-sintY-fallback x-138 y-139)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme x-138) (py-sint-to-scheme y-139))))

(define (py-bitor-sintX-bintY-fallback x-140 y-141)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme x-140) (py-bint-to-scheme y-141))))

(define (py-bitor-bintX-floatY-fallback x-142 y-143)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'int' and 'float'"))))

(define (py-bitor-bintX-boolY-fallback x-144 y-145)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme x-144) (py-bool-to-scheme-int y-145))))

(define (py-bitor-bintX-strY-fallback x-146 y-147)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |: 'int' and 'str'"))))

(define (py-bitor-bintX-sintY-fallback x-148 y-149)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme x-148) (py-sint-to-scheme y-149))))

(define (py-bitor-bintX-bintY-fallback x-150 y-151)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme x-150) (py-bint-to-scheme y-151))))

(define (py-floordiv-floatX-floatY-fallback x-152 y-153)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-float-to-scheme y-153) 0.))))
      (py-float-from-scheme
       (py// (py-float-to-scheme x-152) (py-float-to-scheme y-153)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-floatX-boolY-fallback x-154 y-155)
  (if (py-test y-155)
      (py-float-from-scheme
       (py// (py-float-to-scheme x-154) (py-bool-to-scheme-int y-155)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-floatX-strY-fallback x-156 y-157)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //: 'float' and 'str'"))))

(define (py-floordiv-floatX-sintY-fallback x-158 y-159)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-sint-to-scheme y-159) 0))))
      (py-float-from-scheme
       (py// (py-float-to-scheme x-158) (py-sint-to-scheme y-159)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-floatX-bintY-fallback x-160 y-161)
  (py-float-from-scheme
   (py// (py-float-to-scheme x-160) (py-bint-to-scheme y-161))))

(define (py-floordiv-boolX-floatY-fallback x-162 y-163)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-float-to-scheme y-163) 0.))))
      (py-float-from-scheme
       (py// (py-bool-to-scheme-int x-162) (py-float-to-scheme y-163)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-boolX-boolY-fallback x-164 y-165)
  (if (py-test y-165)
      (py-int-from-scheme
       (py// (py-bool-to-scheme-int x-164) (py-bool-to-scheme-int y-165)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-boolX-strY-fallback x-166 y-167)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //: 'bool' and 'str'"))))

(define (py-floordiv-boolX-sintY-fallback x-168 y-169)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-sint-to-scheme y-169) 0))))
      (py-int-from-scheme
       (py// (py-bool-to-scheme-int x-168) (py-sint-to-scheme y-169)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-boolX-bintY-fallback x-170 y-171)
  (py-int-from-scheme
   (py// (py-bool-to-scheme-int x-170) (py-bint-to-scheme y-171))))

(define (py-floordiv-strX-floatY-fallback x-172 y-173)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //: 'str' and 'float'"))))

(define (py-floordiv-strX-boolY-fallback x-174 y-175)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //: 'str' and 'bool'"))))

(define (py-floordiv-strX-strY-fallback x-176 y-177)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //: 'str' and 'str'"))))

(define (py-floordiv-strX-sintY-fallback x-178 y-179)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //: 'str' and 'int'"))))

(define (py-floordiv-strX-bintY-fallback x-180 y-181)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //: 'str' and 'int'"))))

(define (py-floordiv-sintX-floatY-fallback x-182 y-183)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-float-to-scheme y-183) 0.))))
      (py-float-from-scheme
       (py// (py-sint-to-scheme x-182) (py-float-to-scheme y-183)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-sintX-boolY-fallback x-184 y-185)
  (if (py-test y-185)
      (py-int-from-scheme
       (py// (py-sint-to-scheme x-184) (py-bool-to-scheme-int y-185)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-sintX-strY-fallback x-186 y-187)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //: 'int' and 'str'"))))

(define (py-floordiv-sintX-sintY-fallback x-188 y-189)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-sint-to-scheme y-189) 0))))
      (py-int-from-scheme
       (py// (py-sint-to-scheme x-188) (py-sint-to-scheme y-189)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-sintX-bintY-fallback x-190 y-191)
  (py-int-from-scheme
   (py// (py-sint-to-scheme x-190) (py-bint-to-scheme y-191))))

(define (py-floordiv-bintX-floatY-fallback x-192 y-193)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-float-to-scheme y-193) 0.))))
      (py-float-from-scheme
       (py// (py-bint-to-scheme x-192) (py-float-to-scheme y-193)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-floordiv-bintX-boolY-fallback x-194 y-195)
  (if (py-test y-195)
      (py-int-from-scheme
       (py// (py-bint-to-scheme x-194) (py-bool-to-scheme-int y-195)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-bintX-strY-fallback x-196 y-197)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //: 'int' and 'str'"))))

(define (py-floordiv-bintX-sintY-fallback x-198 y-199)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-sint-to-scheme y-199) 0))))
      (py-int-from-scheme
       (py// (py-bint-to-scheme x-198) (py-sint-to-scheme y-199)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-floordiv-bintX-bintY-fallback x-200 y-201)
  (py-int-from-scheme
   (py// (py-bint-to-scheme x-200) (py-bint-to-scheme y-201))))

(define (py-lshift-floatX-floatY-fallback x-202 y-203)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'float'"))))

(define (py-lshift-floatX-boolY-fallback x-204 y-205)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'bool'"))))

(define (py-lshift-floatX-strY-fallback x-206 y-207)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'str'"))))

(define (py-lshift-floatX-sintY-fallback x-208 y-209)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'int'"))))

(define (py-lshift-floatX-bintY-fallback x-210 y-211)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'float' and 'int'"))))

(define (py-lshift-boolX-floatY-fallback x-212 y-213)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'bool' and 'float'"))))

(define (py-lshift-boolX-boolY-fallback x-214 y-215)
  (if (py-test (py-ge y-215 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bool-to-scheme-int x-214) (py-bool-to-scheme-int y-215)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-boolX-strY-fallback x-216 y-217)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'bool' and 'str'"))))

(define (py-lshift-boolX-sintY-fallback x-218 y-219)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py>= (py-sint-to-scheme y-219) 0))))
      (py-int-from-scheme
       (py<< (py-bool-to-scheme-int x-218) (py-sint-to-scheme y-219)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-boolX-bintY-fallback x-220 y-221)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py>= (py-bint-to-scheme y-221) 0))))
      (py-int-from-scheme
       (py<< (py-bool-to-scheme-int x-220) (py-bint-to-scheme y-221)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-strX-floatY-fallback x-222 y-223)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'str' and 'float'"))))

(define (py-lshift-strX-boolY-fallback x-224 y-225)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'str' and 'bool'"))))

(define (py-lshift-strX-strY-fallback x-226 y-227)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'str' and 'str'"))))

(define (py-lshift-strX-sintY-fallback x-228 y-229)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'str' and 'int'"))))

(define (py-lshift-strX-bintY-fallback x-230 y-231)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'str' and 'int'"))))

(define (py-lshift-sintX-floatY-fallback x-232 y-233)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'int' and 'float'"))))

(define (py-lshift-sintX-boolY-fallback x-234 y-235)
  (if (py-test (py-ge y-235 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-sint-to-scheme x-234) (py-bool-to-scheme-int y-235)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-sintX-strY-fallback x-236 y-237)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'int' and 'str'"))))

(define (py-lshift-sintX-sintY-fallback x-238 y-239)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py>= (py-sint-to-scheme y-239) 0))))
      (py-int-from-scheme
       (py<< (py-sint-to-scheme x-238) (py-sint-to-scheme y-239)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-sintX-bintY-fallback x-240 y-241)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py>= (py-bint-to-scheme y-241) 0))))
      (py-int-from-scheme
       (py<< (py-sint-to-scheme x-240) (py-bint-to-scheme y-241)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-bintX-floatY-fallback x-242 y-243)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'int' and 'float'"))))

(define (py-lshift-bintX-boolY-fallback x-244 y-245)
  (if (py-test (py-ge y-245 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bint-to-scheme x-244) (py-bool-to-scheme-int y-245)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-bintX-strY-fallback x-246 y-247)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<: 'int' and 'str'"))))

(define (py-lshift-bintX-sintY-fallback x-248 y-249)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py>= (py-sint-to-scheme y-249) 0))))
      (py-int-from-scheme
       (py<< (py-bint-to-scheme x-248) (py-sint-to-scheme y-249)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-lshift-bintX-bintY-fallback x-250 y-251)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py>= (py-bint-to-scheme y-251) 0))))
      (py-int-from-scheme
       (py<< (py-bint-to-scheme x-250) (py-bint-to-scheme y-251)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-matmul-floatX-floatY-fallback x-252 y-253)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'float'"))))

(define (py-matmul-floatX-boolY-fallback x-254 y-255)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'bool'"))))

(define (py-matmul-floatX-strY-fallback x-256 y-257)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'str'"))))

(define (py-matmul-floatX-sintY-fallback x-258 y-259)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'int'"))))

(define (py-matmul-floatX-bintY-fallback x-260 y-261)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'float' and 'int'"))))

(define (py-matmul-boolX-floatY-fallback x-262 y-263)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'float'"))))

(define (py-matmul-boolX-boolY-fallback x-264 y-265)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'bool'"))))

(define (py-matmul-boolX-strY-fallback x-266 y-267)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'str'"))))

(define (py-matmul-boolX-sintY-fallback x-268 y-269)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'int'"))))

(define (py-matmul-boolX-bintY-fallback x-270 y-271)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'bool' and 'int'"))))

(define (py-matmul-strX-floatY-fallback x-272 y-273)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'str' and 'float'"))))

(define (py-matmul-strX-boolY-fallback x-274 y-275)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'str' and 'bool'"))))

(define (py-matmul-strX-strY-fallback x-276 y-277)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'str' and 'str'"))))

(define (py-matmul-strX-sintY-fallback x-278 y-279)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'str' and 'int'"))))

(define (py-matmul-strX-bintY-fallback x-280 y-281)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'str' and 'int'"))))

(define (py-matmul-sintX-floatY-fallback x-282 y-283)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'float'"))))

(define (py-matmul-sintX-boolY-fallback x-284 y-285)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'bool'"))))

(define (py-matmul-sintX-strY-fallback x-286 y-287)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'str'"))))

(define (py-matmul-sintX-sintY-fallback x-288 y-289)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-matmul-sintX-bintY-fallback x-290 y-291)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-matmul-bintX-floatY-fallback x-292 y-293)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'float'"))))

(define (py-matmul-bintX-boolY-fallback x-294 y-295)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'bool'"))))

(define (py-matmul-bintX-strY-fallback x-296 y-297)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'str'"))))

(define (py-matmul-bintX-sintY-fallback x-298 y-299)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-matmul-bintX-bintY-fallback x-300 y-301)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @: 'int' and 'int'"))))

(define (py-mod-floatX-floatY-fallback x-302 y-303)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-float-to-scheme y-303) 0.))))
      (py-float-from-scheme
       (py% (py-float-to-scheme x-302) (py-float-to-scheme y-303)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-floatX-boolY-fallback x-304 y-305)
  (if (py-test y-305)
      (py-float-from-scheme
       (py% (py-float-to-scheme x-304) (py-bool-to-scheme-int y-305)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-floatX-strY-fallback x-306 y-307)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %: 'float' and 'str'"))))

(define (py-mod-floatX-sintY-fallback x-308 y-309)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-sint-to-scheme y-309) 0))))
      (py-float-from-scheme
       (py% (py-float-to-scheme x-308) (py-sint-to-scheme y-309)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-floatX-bintY-fallback x-310 y-311)
  (py-float-from-scheme
   (py% (py-float-to-scheme x-310) (py-bint-to-scheme y-311))))

(define (py-mod-boolX-floatY-fallback x-312 y-313)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-float-to-scheme y-313) 0.))))
      (py-float-from-scheme
       (py% (py-bool-to-scheme-int x-312) (py-float-to-scheme y-313)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-boolX-boolY-fallback x-314 y-315)
  (if (py-test y-315)
      (py-int-from-scheme
       (py% (py-bool-to-scheme-int x-314) (py-bool-to-scheme-int y-315)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-boolX-strY-fallback x-316 y-317)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %: 'bool' and 'str'"))))

(define (py-mod-boolX-sintY-fallback x-318 y-319)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-sint-to-scheme y-319) 0))))
      (py-int-from-scheme
       (py% (py-bool-to-scheme-int x-318) (py-sint-to-scheme y-319)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-boolX-bintY-fallback x-320 y-321)
  (py-int-from-scheme
   (py% (py-bool-to-scheme-int x-320) (py-bint-to-scheme y-321))))

(define (py-mod-strX-floatY-fallback x-322 y-323)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %: 'str' and 'float'"))))

(define (py-mod-strX-boolY-fallback x-324 y-325)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %: 'str' and 'bool'"))))

(define (py-mod-strX-strY-fallback x-326 y-327)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %: 'str' and 'str'"))))

(define (py-mod-strX-sintY-fallback x-328 y-329)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %: 'str' and 'int'"))))

(define (py-mod-strX-bintY-fallback x-330 y-331)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %: 'str' and 'int'"))))

(define (py-mod-sintX-floatY-fallback x-332 y-333)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-float-to-scheme y-333) 0.))))
      (py-float-from-scheme
       (py% (py-sint-to-scheme x-332) (py-float-to-scheme y-333)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-sintX-boolY-fallback x-334 y-335)
  (if (py-test y-335)
      (py-int-from-scheme
       (py% (py-sint-to-scheme x-334) (py-bool-to-scheme-int y-335)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-sintX-strY-fallback x-336 y-337)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %: 'int' and 'str'"))))

(define (py-mod-sintX-sintY-fallback x-338 y-339)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-sint-to-scheme y-339) 0))))
      (py-int-from-scheme
       (py% (py-sint-to-scheme x-338) (py-sint-to-scheme y-339)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-sintX-bintY-fallback x-340 y-341)
  (py-int-from-scheme
   (py% (py-sint-to-scheme x-340) (py-bint-to-scheme y-341))))

(define (py-mod-bintX-floatY-fallback x-342 y-343)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-float-to-scheme y-343) 0.))))
      (py-float-from-scheme
       (py% (py-bint-to-scheme x-342) (py-float-to-scheme y-343)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-mod-bintX-boolY-fallback x-344 y-345)
  (if (py-test y-345)
      (py-int-from-scheme
       (py% (py-bint-to-scheme x-344) (py-bool-to-scheme-int y-345)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-bintX-strY-fallback x-346 y-347)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %: 'int' and 'str'"))))

(define (py-mod-bintX-sintY-fallback x-348 y-349)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-sint-to-scheme y-349) 0))))
      (py-int-from-scheme
       (py% (py-bint-to-scheme x-348) (py-sint-to-scheme y-349)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-mod-bintX-bintY-fallback x-350 y-351)
  (py-int-from-scheme
   (py% (py-bint-to-scheme x-350) (py-bint-to-scheme y-351))))

(define (py-mul-floatX-floatY-fallback x-352 y-353)
  (py-float-from-scheme
   (py* (py-float-to-scheme x-352) (py-float-to-scheme y-353))))

(define (py-mul-floatX-boolY-fallback x-354 y-355)
  (py-float-from-scheme
   (py* (py-float-to-scheme x-354) (py-bool-to-scheme-int y-355))))

(define (py-mul-floatX-strY-fallback x-356 y-357)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for *: 'float' and 'str'"))))

(define (py-mul-floatX-sintY-fallback x-358 y-359)
  (py-float-from-scheme
   (py* (py-float-to-scheme x-358) (py-sint-to-scheme y-359))))

(define (py-mul-floatX-bintY-fallback x-360 y-361)
  (py-float-from-scheme
   (py* (py-float-to-scheme x-360) (py-bint-to-scheme y-361))))

(define (py-mul-boolX-floatY-fallback x-362 y-363)
  (py-float-from-scheme
   (py* (py-bool-to-scheme-int x-362) (py-float-to-scheme y-363))))

(define (py-mul-boolX-boolY-fallback x-364 y-365)
  (py-int-from-scheme
   (py* (py-bool-to-scheme-int x-364) (py-bool-to-scheme-int y-365))))

(define (py-mul-boolX-strY-fallback x-366 y-367)
  (py-str-from-scheme
   (py* (py-str-to-scheme y-367) (py-bool-to-scheme-int x-366))))

(define (py-mul-boolX-sintY-fallback x-368 y-369)
  (py-int-from-scheme
   (py* (py-bool-to-scheme-int x-368) (py-sint-to-scheme y-369))))

(define (py-mul-boolX-bintY-fallback x-370 y-371)
  (py-int-from-scheme
   (py* (py-bool-to-scheme-int x-370) (py-bint-to-scheme y-371))))

(define (py-mul-strX-floatY-fallback x-372 y-373)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for *: 'str' and 'float'"))))

(define (py-mul-strX-boolY-fallback x-374 y-375)
  (py-str-from-scheme
   (py* (py-str-to-scheme x-374) (py-bool-to-scheme-int y-375))))

(define (py-mul-strX-strY-fallback x-376 y-377)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for *: 'str' and 'str'"))))

(define (py-mul-strX-sintY-fallback x-378 y-379)
  (py-str-from-scheme
   (py* (py-str-to-scheme x-378) (py-sint-to-scheme y-379))))

(define (py-mul-strX-bintY-fallback x-380 y-381)
  (py-str-from-scheme
   (py* (py-str-to-scheme x-380) (py-bint-to-scheme y-381))))

(define (py-mul-sintX-floatY-fallback x-382 y-383)
  (py-float-from-scheme
   (py* (py-sint-to-scheme x-382) (py-float-to-scheme y-383))))

(define (py-mul-sintX-boolY-fallback x-384 y-385)
  (py-int-from-scheme
   (py* (py-sint-to-scheme x-384) (py-bool-to-scheme-int y-385))))

(define (py-mul-sintX-strY-fallback x-386 y-387)
  (py-str-from-scheme
   (py* (py-str-to-scheme y-387) (py-sint-to-scheme x-386))))

(define (py-mul-sintX-sintY-fallback x-388 y-389)
  (py-int-from-scheme
   (py* (py-sint-to-scheme x-388) (py-sint-to-scheme y-389))))

(define (py-mul-sintX-bintY-fallback x-390 y-391)
  (py-int-from-scheme
   (py* (py-sint-to-scheme x-390) (py-bint-to-scheme y-391))))

(define (py-mul-bintX-floatY-fallback x-392 y-393)
  (py-float-from-scheme
   (py* (py-bint-to-scheme x-392) (py-float-to-scheme y-393))))

(define (py-mul-bintX-boolY-fallback x-394 y-395)
  (py-int-from-scheme
   (py* (py-bint-to-scheme x-394) (py-bool-to-scheme-int y-395))))

(define (py-mul-bintX-strY-fallback x-396 y-397)
  (py-str-from-scheme
   (py* (py-str-to-scheme y-397) (py-bint-to-scheme x-396))))

(define (py-mul-bintX-sintY-fallback x-398 y-399)
  (py-int-from-scheme
   (py* (py-bint-to-scheme x-398) (py-sint-to-scheme y-399))))

(define (py-mul-bintX-bintY-fallback x-400 y-401)
  (py-int-from-scheme
   (py* (py-bint-to-scheme x-400) (py-bint-to-scheme y-401))))

(define (py-pow-floatX-floatY-fallback x-402 y-403)
  (py-float-from-scheme
   (py** (py-float-to-scheme x-402) (py-float-to-scheme y-403))))

(define (py-pow-floatX-boolY-fallback x-404 y-405)
  (py-float-from-scheme
   (py** (py-float-to-scheme x-404) (py-bool-to-scheme-int y-405))))

(define (py-pow-floatX-strY-fallback x-406 y-407)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **: 'float' and 'str'"))))

(define (py-pow-floatX-sintY-fallback x-408 y-409)
  (py-float-from-scheme
   (py** (py-float-to-scheme x-408) (py-sint-to-scheme y-409))))

(define (py-pow-floatX-bintY-fallback x-410 y-411)
  (py-float-from-scheme
   (py** (py-float-to-scheme x-410) (py-bint-to-scheme y-411))))

(define (py-pow-boolX-floatY-fallback x-412 y-413)
  (py-float-from-scheme
   (py** (py-bool-to-scheme-int x-412) (py-float-to-scheme y-413))))

(define (py-pow-boolX-boolY-fallback x-414 y-415)
  (py-int-from-scheme
   (py** (py-bool-to-scheme-int x-414) (py-bool-to-scheme-int y-415))))

(define (py-pow-boolX-strY-fallback x-416 y-417)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **: 'bool' and 'str'"))))

(define (py-pow-boolX-sintY-fallback x-418 y-419)
  (py-int-from-scheme
   (py** (py-bool-to-scheme-int x-418) (py-sint-to-scheme y-419))))

(define (py-pow-boolX-bintY-fallback x-420 y-421)
  (py-int-from-scheme
   (py** (py-bool-to-scheme-int x-420) (py-bint-to-scheme y-421))))

(define (py-pow-strX-floatY-fallback x-422 y-423)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **: 'str' and 'float'"))))

(define (py-pow-strX-boolY-fallback x-424 y-425)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **: 'str' and 'bool'"))))

(define (py-pow-strX-strY-fallback x-426 y-427)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **: 'str' and 'str'"))))

(define (py-pow-strX-sintY-fallback x-428 y-429)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **: 'str' and 'int'"))))

(define (py-pow-strX-bintY-fallback x-430 y-431)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **: 'str' and 'int'"))))

(define (py-pow-sintX-floatY-fallback x-432 y-433)
  (py-float-from-scheme
   (py** (py-sint-to-scheme x-432) (py-float-to-scheme y-433))))

(define (py-pow-sintX-boolY-fallback x-434 y-435)
  (py-int-from-scheme
   (py** (py-sint-to-scheme x-434) (py-bool-to-scheme-int y-435))))

(define (py-pow-sintX-strY-fallback x-436 y-437)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **: 'int' and 'str'"))))

(define (py-pow-sintX-sintY-fallback x-438 y-439)
  (py-int-from-scheme
   (py** (py-sint-to-scheme x-438) (py-sint-to-scheme y-439))))

(define (py-pow-sintX-bintY-fallback x-440 y-441)
  (py-int-from-scheme
   (py** (py-sint-to-scheme x-440) (py-bint-to-scheme y-441))))

(define (py-pow-bintX-floatY-fallback x-442 y-443)
  (py-float-from-scheme
   (py** (py-bint-to-scheme x-442) (py-float-to-scheme y-443))))

(define (py-pow-bintX-boolY-fallback x-444 y-445)
  (py-int-from-scheme
   (py** (py-bint-to-scheme x-444) (py-bool-to-scheme-int y-445))))

(define (py-pow-bintX-strY-fallback x-446 y-447)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **: 'int' and 'str'"))))

(define (py-pow-bintX-sintY-fallback x-448 y-449)
  (py-int-from-scheme
   (py** (py-bint-to-scheme x-448) (py-sint-to-scheme y-449))))

(define (py-pow-bintX-bintY-fallback x-450 y-451)
  (py-int-from-scheme
   (py** (py-bint-to-scheme x-450) (py-bint-to-scheme y-451))))

(define (py-rshift-floatX-floatY-fallback x-452 y-453)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'float'"))))

(define (py-rshift-floatX-boolY-fallback x-454 y-455)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'bool'"))))

(define (py-rshift-floatX-strY-fallback x-456 y-457)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'str'"))))

(define (py-rshift-floatX-sintY-fallback x-458 y-459)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'int'"))))

(define (py-rshift-floatX-bintY-fallback x-460 y-461)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'float' and 'int'"))))

(define (py-rshift-boolX-floatY-fallback x-462 y-463)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'bool' and 'float'"))))

(define (py-rshift-boolX-boolY-fallback x-464 y-465)
  (if (py-test (py-ge y-465 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bool-to-scheme-int x-464) (py-bool-to-scheme-int y-465)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-boolX-strY-fallback x-466 y-467)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'bool' and 'str'"))))

(define (py-rshift-boolX-sintY-fallback x-468 y-469)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py>= (py-sint-to-scheme y-469) 0))))
      (py-int-from-scheme
       (py>> (py-bool-to-scheme-int x-468) (py-sint-to-scheme y-469)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-boolX-bintY-fallback x-470 y-471)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py>= (py-bint-to-scheme y-471) 0))))
      (py-int-from-scheme
       (py>> (py-bool-to-scheme-int x-470) (py-bint-to-scheme y-471)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-strX-floatY-fallback x-472 y-473)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'str' and 'float'"))))

(define (py-rshift-strX-boolY-fallback x-474 y-475)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'str' and 'bool'"))))

(define (py-rshift-strX-strY-fallback x-476 y-477)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'str' and 'str'"))))

(define (py-rshift-strX-sintY-fallback x-478 y-479)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'str' and 'int'"))))

(define (py-rshift-strX-bintY-fallback x-480 y-481)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'str' and 'int'"))))

(define (py-rshift-sintX-floatY-fallback x-482 y-483)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'int' and 'float'"))))

(define (py-rshift-sintX-boolY-fallback x-484 y-485)
  (if (py-test (py-ge y-485 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-sint-to-scheme x-484) (py-bool-to-scheme-int y-485)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-sintX-strY-fallback x-486 y-487)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'int' and 'str'"))))

(define (py-rshift-sintX-sintY-fallback x-488 y-489)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py>= (py-sint-to-scheme y-489) 0))))
      (py-int-from-scheme
       (py>> (py-sint-to-scheme x-488) (py-sint-to-scheme y-489)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-sintX-bintY-fallback x-490 y-491)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py>= (py-bint-to-scheme y-491) 0))))
      (py-int-from-scheme
       (py>> (py-sint-to-scheme x-490) (py-bint-to-scheme y-491)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-bintX-floatY-fallback x-492 y-493)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'int' and 'float'"))))

(define (py-rshift-bintX-boolY-fallback x-494 y-495)
  (if (py-test (py-ge y-495 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bint-to-scheme x-494) (py-bool-to-scheme-int y-495)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-bintX-strY-fallback x-496 y-497)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>: 'int' and 'str'"))))

(define (py-rshift-bintX-sintY-fallback x-498 y-499)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py>= (py-sint-to-scheme y-499) 0))))
      (py-int-from-scheme
       (py>> (py-bint-to-scheme x-498) (py-sint-to-scheme y-499)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-rshift-bintX-bintY-fallback x-500 y-501)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py>= (py-bint-to-scheme y-501) 0))))
      (py-int-from-scheme
       (py>> (py-bint-to-scheme x-500) (py-bint-to-scheme y-501)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-sub-floatX-floatY-fallback x-502 y-503)
  (py-float-from-scheme
   (py- (py-float-to-scheme x-502) (py-float-to-scheme y-503))))

(define (py-sub-floatX-boolY-fallback x-504 y-505)
  (py-float-from-scheme
   (py- (py-float-to-scheme x-504) (py-bool-to-scheme-int y-505))))

(define (py-sub-floatX-strY-fallback x-506 y-507)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -: 'float' and 'str'"))))

(define (py-sub-floatX-sintY-fallback x-508 y-509)
  (py-float-from-scheme
   (py- (py-float-to-scheme x-508) (py-sint-to-scheme y-509))))

(define (py-sub-floatX-bintY-fallback x-510 y-511)
  (py-float-from-scheme
   (py- (py-float-to-scheme x-510) (py-bint-to-scheme y-511))))

(define (py-sub-boolX-floatY-fallback x-512 y-513)
  (py-float-from-scheme
   (py- (py-bool-to-scheme-int x-512) (py-float-to-scheme y-513))))

(define (py-sub-boolX-boolY-fallback x-514 y-515)
  (py-int-from-scheme
   (py- (py-bool-to-scheme-int x-514) (py-bool-to-scheme-int y-515))))

(define (py-sub-boolX-strY-fallback x-516 y-517)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -: 'bool' and 'str'"))))

(define (py-sub-boolX-sintY-fallback x-518 y-519)
  (py-int-from-scheme
   (py- (py-bool-to-scheme-int x-518) (py-sint-to-scheme y-519))))

(define (py-sub-boolX-bintY-fallback x-520 y-521)
  (py-int-from-scheme
   (py- (py-bool-to-scheme-int x-520) (py-bint-to-scheme y-521))))

(define (py-sub-strX-floatY-fallback x-522 y-523)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -: 'str' and 'float'"))))

(define (py-sub-strX-boolY-fallback x-524 y-525)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -: 'str' and 'bool'"))))

(define (py-sub-strX-strY-fallback x-526 y-527)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -: 'str' and 'str'"))))

(define (py-sub-strX-sintY-fallback x-528 y-529)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -: 'str' and 'int'"))))

(define (py-sub-strX-bintY-fallback x-530 y-531)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -: 'str' and 'int'"))))

(define (py-sub-sintX-floatY-fallback x-532 y-533)
  (py-float-from-scheme
   (py- (py-sint-to-scheme x-532) (py-float-to-scheme y-533))))

(define (py-sub-sintX-boolY-fallback x-534 y-535)
  (py-int-from-scheme
   (py- (py-sint-to-scheme x-534) (py-bool-to-scheme-int y-535))))

(define (py-sub-sintX-strY-fallback x-536 y-537)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -: 'int' and 'str'"))))

(define (py-sub-sintX-sintY-fallback x-538 y-539)
  (py-int-from-scheme
   (py- (py-sint-to-scheme x-538) (py-sint-to-scheme y-539))))

(define (py-sub-sintX-bintY-fallback x-540 y-541)
  (py-int-from-scheme
   (py- (py-sint-to-scheme x-540) (py-bint-to-scheme y-541))))

(define (py-sub-bintX-floatY-fallback x-542 y-543)
  (py-float-from-scheme
   (py- (py-bint-to-scheme x-542) (py-float-to-scheme y-543))))

(define (py-sub-bintX-boolY-fallback x-544 y-545)
  (py-int-from-scheme
   (py- (py-bint-to-scheme x-544) (py-bool-to-scheme-int y-545))))

(define (py-sub-bintX-strY-fallback x-546 y-547)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -: 'int' and 'str'"))))

(define (py-sub-bintX-sintY-fallback x-548 y-549)
  (py-int-from-scheme
   (py- (py-bint-to-scheme x-548) (py-sint-to-scheme y-549))))

(define (py-sub-bintX-bintY-fallback x-550 y-551)
  (py-int-from-scheme
   (py- (py-bint-to-scheme x-550) (py-bint-to-scheme y-551))))

(define (py-truediv-floatX-floatY-fallback x-552 y-553)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-float-to-scheme y-553) 0.))))
      (py-float-from-scheme
       (py/ (py-float-to-scheme x-552) (py-float-to-scheme y-553)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-floatX-boolY-fallback x-554 y-555)
  (if (py-test y-555)
      (py-float-from-scheme
       (py/ (py-float-to-scheme x-554) (py-bool-to-scheme-int y-555)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-floatX-strY-fallback x-556 y-557)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /: 'float' and 'str'"))))

(define (py-truediv-floatX-sintY-fallback x-558 y-559)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-sint-to-scheme y-559) 0))))
      (py-float-from-scheme
       (py/ (py-float-to-scheme x-558) (py-sint-to-scheme y-559)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-floatX-bintY-fallback x-560 y-561)
  (py-float-from-scheme
   (py/ (py-float-to-scheme x-560) (py-bint-to-scheme y-561))))

(define (py-truediv-boolX-floatY-fallback x-562 y-563)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-float-to-scheme y-563) 0.))))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme-int x-562) (py-float-to-scheme y-563)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-boolX-boolY-fallback x-564 y-565)
  (if (py-test y-565)
      (py-float-from-scheme
       (py/ (py-bool-to-scheme-int x-564) (py-bool-to-scheme-int y-565)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-boolX-strY-fallback x-566 y-567)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /: 'bool' and 'str'"))))

(define (py-truediv-boolX-sintY-fallback x-568 y-569)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-sint-to-scheme y-569) 0))))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme-int x-568) (py-sint-to-scheme y-569)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-boolX-bintY-fallback x-570 y-571)
  (py-float-from-scheme
   (py/ (py-bool-to-scheme-int x-570) (py-bint-to-scheme y-571))))

(define (py-truediv-strX-floatY-fallback x-572 y-573)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /: 'str' and 'float'"))))

(define (py-truediv-strX-boolY-fallback x-574 y-575)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /: 'str' and 'bool'"))))

(define (py-truediv-strX-strY-fallback x-576 y-577)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /: 'str' and 'str'"))))

(define (py-truediv-strX-sintY-fallback x-578 y-579)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /: 'str' and 'int'"))))

(define (py-truediv-strX-bintY-fallback x-580 y-581)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /: 'str' and 'int'"))))

(define (py-truediv-sintX-floatY-fallback x-582 y-583)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-float-to-scheme y-583) 0.))))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme x-582) (py-float-to-scheme y-583)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-sintX-boolY-fallback x-584 y-585)
  (if (py-test y-585)
      (py-float-from-scheme
       (py/ (py-sint-to-scheme x-584) (py-bool-to-scheme-int y-585)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-sintX-strY-fallback x-586 y-587)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /: 'int' and 'str'"))))

(define (py-truediv-sintX-sintY-fallback x-588 y-589)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-sint-to-scheme y-589) 0))))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme x-588) (py-sint-to-scheme y-589)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-sintX-bintY-fallback x-590 y-591)
  (py-float-from-scheme
   (py/ (py-sint-to-scheme x-590) (py-bint-to-scheme y-591))))

(define (py-truediv-bintX-floatY-fallback x-592 y-593)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-float-to-scheme y-593) 0.))))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme x-592) (py-float-to-scheme y-593)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-truediv-bintX-boolY-fallback x-594 y-595)
  (if (py-test y-595)
      (py-float-from-scheme
       (py/ (py-bint-to-scheme x-594) (py-bool-to-scheme-int y-595)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-bintX-strY-fallback x-596 y-597)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /: 'int' and 'str'"))))

(define (py-truediv-bintX-sintY-fallback x-598 y-599)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-sint-to-scheme y-599) 0))))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme x-598) (py-sint-to-scheme y-599)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-truediv-bintX-bintY-fallback x-600 y-601)
  (py-float-from-scheme
   (py/ (py-bint-to-scheme x-600) (py-bint-to-scheme y-601))))

(define (py-xor-floatX-floatY-fallback x-602 y-603)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'float'"))))

(define (py-xor-floatX-boolY-fallback x-604 y-605)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'bool'"))))

(define (py-xor-floatX-strY-fallback x-606 y-607)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'str'"))))

(define (py-xor-floatX-sintY-fallback x-608 y-609)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'int'"))))

(define (py-xor-floatX-bintY-fallback x-610 y-611)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'float' and 'int'"))))

(define (py-xor-boolX-floatY-fallback x-612 y-613)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'bool' and 'float'"))))

(define (py-xor-boolX-boolY-fallback x-614 y-615) (py-isnot x-614 y-615))

(define (py-xor-boolX-strY-fallback x-616 y-617)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'bool' and 'str'"))))

(define (py-xor-boolX-sintY-fallback x-618 y-619)
  (py-int-from-scheme
   (py^ (py-bool-to-scheme-int x-618) (py-sint-to-scheme y-619))))

(define (py-xor-boolX-bintY-fallback x-620 y-621)
  (py-int-from-scheme
   (py^ (py-bool-to-scheme-int x-620) (py-bint-to-scheme y-621))))

(define (py-xor-strX-floatY-fallback x-622 y-623)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'str' and 'float'"))))

(define (py-xor-strX-boolY-fallback x-624 y-625)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'str' and 'bool'"))))

(define (py-xor-strX-strY-fallback x-626 y-627)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'str' and 'str'"))))

(define (py-xor-strX-sintY-fallback x-628 y-629)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'str' and 'int'"))))

(define (py-xor-strX-bintY-fallback x-630 y-631)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'str' and 'int'"))))

(define (py-xor-sintX-floatY-fallback x-632 y-633)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'int' and 'float'"))))

(define (py-xor-sintX-boolY-fallback x-634 y-635)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme x-634) (py-bool-to-scheme-int y-635))))

(define (py-xor-sintX-strY-fallback x-636 y-637)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'int' and 'str'"))))

(define (py-xor-sintX-sintY-fallback x-638 y-639)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme x-638) (py-sint-to-scheme y-639))))

(define (py-xor-sintX-bintY-fallback x-640 y-641)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme x-640) (py-bint-to-scheme y-641))))

(define (py-xor-bintX-floatY-fallback x-642 y-643)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'int' and 'float'"))))

(define (py-xor-bintX-boolY-fallback x-644 y-645)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme x-644) (py-bool-to-scheme-int y-645))))

(define (py-xor-bintX-strY-fallback x-646 y-647)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^: 'int' and 'str'"))))

(define (py-xor-bintX-sintY-fallback x-648 y-649)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme x-648) (py-sint-to-scheme y-649))))

(define (py-xor-bintX-bintY-fallback x-650 y-651)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme x-650) (py-bint-to-scheme y-651))))

(define (py-iadd-floatX-floatY-fallback x-652 y-653)
  (py-float-from-scheme
   (py+ (py-float-to-scheme x-652) (py-float-to-scheme y-653))))

(define (py-iadd-floatX-boolY-fallback x-654 y-655)
  (py-float-from-scheme
   (py+ (py-float-to-scheme x-654) (py-bool-to-scheme-int y-655))))

(define (py-iadd-floatX-strY-fallback x-656 y-657)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for +=: 'float' and 'str'"))))

(define (py-iadd-floatX-sintY-fallback x-658 y-659)
  (py-float-from-scheme
   (py+ (py-float-to-scheme x-658) (py-sint-to-scheme y-659))))

(define (py-iadd-floatX-bintY-fallback x-660 y-661)
  (py-float-from-scheme
   (py+ (py-float-to-scheme x-660) (py-bint-to-scheme y-661))))

(define (py-iadd-boolX-floatY-fallback x-662 y-663)
  (py-float-from-scheme
   (py+ (py-bool-to-scheme-int x-662) (py-float-to-scheme y-663))))

(define (py-iadd-boolX-boolY-fallback x-664 y-665)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme-int x-664) (py-bool-to-scheme-int y-665))))

(define (py-iadd-boolX-strY-fallback x-666 y-667)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for +=: 'bool' and 'str'"))))

(define (py-iadd-boolX-sintY-fallback x-668 y-669)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme-int x-668) (py-sint-to-scheme y-669))))

(define (py-iadd-boolX-bintY-fallback x-670 y-671)
  (py-int-from-scheme
   (py+ (py-bool-to-scheme-int x-670) (py-bint-to-scheme y-671))))

(define (py-iadd-strX-floatY-fallback x-672 y-673)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for +=: 'str' and 'float'"))))

(define (py-iadd-strX-boolY-fallback x-674 y-675)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for +=: 'str' and 'bool'"))))

(define (py-iadd-strX-strY-fallback x-676 y-677)
  (py-str-from-scheme (py+ (py-str-to-scheme x-676) (py-str-to-scheme y-677))))

(define (py-iadd-strX-sintY-fallback x-678 y-679)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for +=: 'str' and 'int'"))))

(define (py-iadd-strX-bintY-fallback x-680 y-681)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for +=: 'str' and 'int'"))))

(define (py-iadd-sintX-floatY-fallback x-682 y-683)
  (py-float-from-scheme
   (py+ (py-sint-to-scheme x-682) (py-float-to-scheme y-683))))

(define (py-iadd-sintX-boolY-fallback x-684 y-685)
  (py-int-from-scheme
   (py+ (py-sint-to-scheme x-684) (py-bool-to-scheme-int y-685))))

(define (py-iadd-sintX-strY-fallback x-686 y-687)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for +=: 'int' and 'str'"))))

(define (py-iadd-sintX-sintY-fallback x-688 y-689)
  (py-int-from-scheme
   (py+ (py-sint-to-scheme x-688) (py-sint-to-scheme y-689))))

(define (py-iadd-sintX-bintY-fallback x-690 y-691)
  (py-int-from-scheme
   (py+ (py-sint-to-scheme x-690) (py-bint-to-scheme y-691))))

(define (py-iadd-bintX-floatY-fallback x-692 y-693)
  (py-float-from-scheme
   (py+ (py-bint-to-scheme x-692) (py-float-to-scheme y-693))))

(define (py-iadd-bintX-boolY-fallback x-694 y-695)
  (py-int-from-scheme
   (py+ (py-bint-to-scheme x-694) (py-bool-to-scheme-int y-695))))

(define (py-iadd-bintX-strY-fallback x-696 y-697)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for +=: 'int' and 'str'"))))

(define (py-iadd-bintX-sintY-fallback x-698 y-699)
  (py-int-from-scheme
   (py+ (py-bint-to-scheme x-698) (py-sint-to-scheme y-699))))

(define (py-iadd-bintX-bintY-fallback x-700 y-701)
  (py-int-from-scheme
   (py+ (py-bint-to-scheme x-700) (py-bint-to-scheme y-701))))

(define (py-ibitand-floatX-floatY-fallback x-702 y-703)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'float' and 'float'"))))

(define (py-ibitand-floatX-boolY-fallback x-704 y-705)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'float' and 'bool'"))))

(define (py-ibitand-floatX-strY-fallback x-706 y-707)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'float' and 'str'"))))

(define (py-ibitand-floatX-sintY-fallback x-708 y-709)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'float' and 'int'"))))

(define (py-ibitand-floatX-bintY-fallback x-710 y-711)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'float' and 'int'"))))

(define (py-ibitand-boolX-floatY-fallback x-712 y-713)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'bool' and 'float'"))))

(define (py-ibitand-boolX-boolY-fallback x-714 y-715)
  (py-int-from-scheme
   (py& (py-bool-to-scheme-int x-714) (py-bool-to-scheme-int y-715))))

(define (py-ibitand-boolX-strY-fallback x-716 y-717)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'bool' and 'str'"))))

(define (py-ibitand-boolX-sintY-fallback x-718 y-719)
  (py-int-from-scheme
   (py& (py-bool-to-scheme-int x-718) (py-sint-to-scheme y-719))))

(define (py-ibitand-boolX-bintY-fallback x-720 y-721)
  (py-int-from-scheme
   (py& (py-bool-to-scheme-int x-720) (py-bint-to-scheme y-721))))

(define (py-ibitand-strX-floatY-fallback x-722 y-723)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'str' and 'float'"))))

(define (py-ibitand-strX-boolY-fallback x-724 y-725)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'str' and 'bool'"))))

(define (py-ibitand-strX-strY-fallback x-726 y-727)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'str' and 'str'"))))

(define (py-ibitand-strX-sintY-fallback x-728 y-729)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'str' and 'int'"))))

(define (py-ibitand-strX-bintY-fallback x-730 y-731)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'str' and 'int'"))))

(define (py-ibitand-sintX-floatY-fallback x-732 y-733)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'int' and 'float'"))))

(define (py-ibitand-sintX-boolY-fallback x-734 y-735)
  (py-int-from-scheme
   (py& (py-sint-to-scheme x-734) (py-bool-to-scheme-int y-735))))

(define (py-ibitand-sintX-strY-fallback x-736 y-737)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'int' and 'str'"))))

(define (py-ibitand-sintX-sintY-fallback x-738 y-739)
  (py-int-from-scheme
   (py& (py-sint-to-scheme x-738) (py-sint-to-scheme y-739))))

(define (py-ibitand-sintX-bintY-fallback x-740 y-741)
  (py-int-from-scheme
   (py& (py-sint-to-scheme x-740) (py-bint-to-scheme y-741))))

(define (py-ibitand-bintX-floatY-fallback x-742 y-743)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'int' and 'float'"))))

(define (py-ibitand-bintX-boolY-fallback x-744 y-745)
  (py-int-from-scheme
   (py& (py-bint-to-scheme x-744) (py-bool-to-scheme-int y-745))))

(define (py-ibitand-bintX-strY-fallback x-746 y-747)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for &=: 'int' and 'str'"))))

(define (py-ibitand-bintX-sintY-fallback x-748 y-749)
  (py-int-from-scheme
   (py& (py-bint-to-scheme x-748) (py-sint-to-scheme y-749))))

(define (py-ibitand-bintX-bintY-fallback x-750 y-751)
  (py-int-from-scheme
   (py& (py-bint-to-scheme x-750) (py-bint-to-scheme y-751))))

(define (py-ibitor-floatX-floatY-fallback x-752 y-753)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'float' and 'float'"))))

(define (py-ibitor-floatX-boolY-fallback x-754 y-755)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'float' and 'bool'"))))

(define (py-ibitor-floatX-strY-fallback x-756 y-757)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'float' and 'str'"))))

(define (py-ibitor-floatX-sintY-fallback x-758 y-759)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'float' and 'int'"))))

(define (py-ibitor-floatX-bintY-fallback x-760 y-761)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'float' and 'int'"))))

(define (py-ibitor-boolX-floatY-fallback x-762 y-763)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'bool' and 'float'"))))

(define (py-ibitor-boolX-boolY-fallback x-764 y-765)
  (py-int-from-scheme
   (py+b (py-bool-to-scheme-int x-764) (py-bool-to-scheme-int y-765))))

(define (py-ibitor-boolX-strY-fallback x-766 y-767)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'bool' and 'str'"))))

(define (py-ibitor-boolX-sintY-fallback x-768 y-769)
  (py-int-from-scheme
   (py+b (py-bool-to-scheme-int x-768) (py-sint-to-scheme y-769))))

(define (py-ibitor-boolX-bintY-fallback x-770 y-771)
  (py-int-from-scheme
   (py+b (py-bool-to-scheme-int x-770) (py-bint-to-scheme y-771))))

(define (py-ibitor-strX-floatY-fallback x-772 y-773)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'str' and 'float'"))))

(define (py-ibitor-strX-boolY-fallback x-774 y-775)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'str' and 'bool'"))))

(define (py-ibitor-strX-strY-fallback x-776 y-777)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'str' and 'str'"))))

(define (py-ibitor-strX-sintY-fallback x-778 y-779)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'str' and 'int'"))))

(define (py-ibitor-strX-bintY-fallback x-780 y-781)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'str' and 'int'"))))

(define (py-ibitor-sintX-floatY-fallback x-782 y-783)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'int' and 'float'"))))

(define (py-ibitor-sintX-boolY-fallback x-784 y-785)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme x-784) (py-bool-to-scheme-int y-785))))

(define (py-ibitor-sintX-strY-fallback x-786 y-787)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'int' and 'str'"))))

(define (py-ibitor-sintX-sintY-fallback x-788 y-789)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme x-788) (py-sint-to-scheme y-789))))

(define (py-ibitor-sintX-bintY-fallback x-790 y-791)
  (py-int-from-scheme
   (py+b (py-sint-to-scheme x-790) (py-bint-to-scheme y-791))))

(define (py-ibitor-bintX-floatY-fallback x-792 y-793)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'int' and 'float'"))))

(define (py-ibitor-bintX-boolY-fallback x-794 y-795)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme x-794) (py-bool-to-scheme-int y-795))))

(define (py-ibitor-bintX-strY-fallback x-796 y-797)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for |=: 'int' and 'str'"))))

(define (py-ibitor-bintX-sintY-fallback x-798 y-799)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme x-798) (py-sint-to-scheme y-799))))

(define (py-ibitor-bintX-bintY-fallback x-800 y-801)
  (py-int-from-scheme
   (py+b (py-bint-to-scheme x-800) (py-bint-to-scheme y-801))))

(define (py-ifloordiv-floatX-floatY-fallback x-802 y-803)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-float-to-scheme y-803) 0.))))
      (py-float-from-scheme
       (py// (py-float-to-scheme x-802) (py-float-to-scheme y-803)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-floatX-boolY-fallback x-804 y-805)
  (if (py-test y-805)
      (py-float-from-scheme
       (py// (py-float-to-scheme x-804) (py-bool-to-scheme-int y-805)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-floatX-strY-fallback x-806 y-807)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //=: 'float' and 'str'"))))

(define (py-ifloordiv-floatX-sintY-fallback x-808 y-809)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-sint-to-scheme y-809) 0))))
      (py-float-from-scheme
       (py// (py-float-to-scheme x-808) (py-sint-to-scheme y-809)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-floatX-bintY-fallback x-810 y-811)
  (py-float-from-scheme
   (py// (py-float-to-scheme x-810) (py-bint-to-scheme y-811))))

(define (py-ifloordiv-boolX-floatY-fallback x-812 y-813)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-float-to-scheme y-813) 0.))))
      (py-float-from-scheme
       (py// (py-bool-to-scheme-int x-812) (py-float-to-scheme y-813)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-boolX-boolY-fallback x-814 y-815)
  (if (py-test y-815)
      (py-int-from-scheme
       (py// (py-bool-to-scheme-int x-814) (py-bool-to-scheme-int y-815)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-boolX-strY-fallback x-816 y-817)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //=: 'bool' and 'str'"))))

(define (py-ifloordiv-boolX-sintY-fallback x-818 y-819)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-sint-to-scheme y-819) 0))))
      (py-int-from-scheme
       (py// (py-bool-to-scheme-int x-818) (py-sint-to-scheme y-819)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-boolX-bintY-fallback x-820 y-821)
  (py-int-from-scheme
   (py// (py-bool-to-scheme-int x-820) (py-bint-to-scheme y-821))))

(define (py-ifloordiv-strX-floatY-fallback x-822 y-823)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //=: 'str' and 'float'"))))

(define (py-ifloordiv-strX-boolY-fallback x-824 y-825)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //=: 'str' and 'bool'"))))

(define (py-ifloordiv-strX-strY-fallback x-826 y-827)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //=: 'str' and 'str'"))))

(define (py-ifloordiv-strX-sintY-fallback x-828 y-829)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //=: 'str' and 'int'"))))

(define (py-ifloordiv-strX-bintY-fallback x-830 y-831)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //=: 'str' and 'int'"))))

(define (py-ifloordiv-sintX-floatY-fallback x-832 y-833)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-float-to-scheme y-833) 0.))))
      (py-float-from-scheme
       (py// (py-sint-to-scheme x-832) (py-float-to-scheme y-833)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-sintX-boolY-fallback x-834 y-835)
  (if (py-test y-835)
      (py-int-from-scheme
       (py// (py-sint-to-scheme x-834) (py-bool-to-scheme-int y-835)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-sintX-strY-fallback x-836 y-837)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //=: 'int' and 'str'"))))

(define (py-ifloordiv-sintX-sintY-fallback x-838 y-839)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-sint-to-scheme y-839) 0))))
      (py-int-from-scheme
       (py// (py-sint-to-scheme x-838) (py-sint-to-scheme y-839)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-sintX-bintY-fallback x-840 y-841)
  (py-int-from-scheme
   (py// (py-sint-to-scheme x-840) (py-bint-to-scheme y-841))))

(define (py-ifloordiv-bintX-floatY-fallback x-842 y-843)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-float-to-scheme y-843) 0.))))
      (py-float-from-scheme
       (py// (py-bint-to-scheme x-842) (py-float-to-scheme y-843)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-ifloordiv-bintX-boolY-fallback x-844 y-845)
  (if (py-test y-845)
      (py-int-from-scheme
       (py// (py-bint-to-scheme x-844) (py-bool-to-scheme-int y-845)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-bintX-strY-fallback x-846 y-847)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for //=: 'int' and 'str'"))))

(define (py-ifloordiv-bintX-sintY-fallback x-848 y-849)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-sint-to-scheme y-849) 0))))
      (py-int-from-scheme
       (py// (py-bint-to-scheme x-848) (py-sint-to-scheme y-849)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError
                (&& "integer division by zero")))))

(define (py-ifloordiv-bintX-bintY-fallback x-850 y-851)
  (py-int-from-scheme
   (py// (py-bint-to-scheme x-850) (py-bint-to-scheme y-851))))

(define (py-ilshift-floatX-floatY-fallback x-852 y-853)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'float' and 'float'"))))

(define (py-ilshift-floatX-boolY-fallback x-854 y-855)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'float' and 'bool'"))))

(define (py-ilshift-floatX-strY-fallback x-856 y-857)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'float' and 'str'"))))

(define (py-ilshift-floatX-sintY-fallback x-858 y-859)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'float' and 'int'"))))

(define (py-ilshift-floatX-bintY-fallback x-860 y-861)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'float' and 'int'"))))

(define (py-ilshift-boolX-floatY-fallback x-862 y-863)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'bool' and 'float'"))))

(define (py-ilshift-boolX-boolY-fallback x-864 y-865)
  (if (py-test (py-ge y-865 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bool-to-scheme-int x-864) (py-bool-to-scheme-int y-865)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-boolX-strY-fallback x-866 y-867)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'bool' and 'str'"))))

(define (py-ilshift-boolX-sintY-fallback x-868 y-869)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py>= (py-sint-to-scheme y-869) 0))))
      (py-int-from-scheme
       (py<< (py-bool-to-scheme-int x-868) (py-sint-to-scheme y-869)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-boolX-bintY-fallback x-870 y-871)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py>= (py-bint-to-scheme y-871) 0))))
      (py-int-from-scheme
       (py<< (py-bool-to-scheme-int x-870) (py-bint-to-scheme y-871)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-strX-floatY-fallback x-872 y-873)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'str' and 'float'"))))

(define (py-ilshift-strX-boolY-fallback x-874 y-875)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'str' and 'bool'"))))

(define (py-ilshift-strX-strY-fallback x-876 y-877)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'str' and 'str'"))))

(define (py-ilshift-strX-sintY-fallback x-878 y-879)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'str' and 'int'"))))

(define (py-ilshift-strX-bintY-fallback x-880 y-881)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'str' and 'int'"))))

(define (py-ilshift-sintX-floatY-fallback x-882 y-883)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'int' and 'float'"))))

(define (py-ilshift-sintX-boolY-fallback x-884 y-885)
  (if (py-test (py-ge y-885 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-sint-to-scheme x-884) (py-bool-to-scheme-int y-885)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-sintX-strY-fallback x-886 y-887)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'int' and 'str'"))))

(define (py-ilshift-sintX-sintY-fallback x-888 y-889)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py>= (py-sint-to-scheme y-889) 0))))
      (py-int-from-scheme
       (py<< (py-sint-to-scheme x-888) (py-sint-to-scheme y-889)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-sintX-bintY-fallback x-890 y-891)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py>= (py-bint-to-scheme y-891) 0))))
      (py-int-from-scheme
       (py<< (py-sint-to-scheme x-890) (py-bint-to-scheme y-891)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-bintX-floatY-fallback x-892 y-893)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'int' and 'float'"))))

(define (py-ilshift-bintX-boolY-fallback x-894 y-895)
  (if (py-test (py-ge y-895 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py<< (py-bint-to-scheme x-894) (py-bool-to-scheme-int y-895)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-bintX-strY-fallback x-896 y-897)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for <<=: 'int' and 'str'"))))

(define (py-ilshift-bintX-sintY-fallback x-898 y-899)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py>= (py-sint-to-scheme y-899) 0))))
      (py-int-from-scheme
       (py<< (py-bint-to-scheme x-898) (py-sint-to-scheme y-899)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-ilshift-bintX-bintY-fallback x-900 y-901)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py>= (py-bint-to-scheme y-901) 0))))
      (py-int-from-scheme
       (py<< (py-bint-to-scheme x-900) (py-bint-to-scheme y-901)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-imatmul-floatX-floatY-fallback x-902 y-903)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'float' and 'float'"))))

(define (py-imatmul-floatX-boolY-fallback x-904 y-905)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'float' and 'bool'"))))

(define (py-imatmul-floatX-strY-fallback x-906 y-907)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'float' and 'str'"))))

(define (py-imatmul-floatX-sintY-fallback x-908 y-909)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'float' and 'int'"))))

(define (py-imatmul-floatX-bintY-fallback x-910 y-911)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'float' and 'int'"))))

(define (py-imatmul-boolX-floatY-fallback x-912 y-913)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'bool' and 'float'"))))

(define (py-imatmul-boolX-boolY-fallback x-914 y-915)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'bool' and 'bool'"))))

(define (py-imatmul-boolX-strY-fallback x-916 y-917)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'bool' and 'str'"))))

(define (py-imatmul-boolX-sintY-fallback x-918 y-919)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'bool' and 'int'"))))

(define (py-imatmul-boolX-bintY-fallback x-920 y-921)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'bool' and 'int'"))))

(define (py-imatmul-strX-floatY-fallback x-922 y-923)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'str' and 'float'"))))

(define (py-imatmul-strX-boolY-fallback x-924 y-925)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'str' and 'bool'"))))

(define (py-imatmul-strX-strY-fallback x-926 y-927)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'str' and 'str'"))))

(define (py-imatmul-strX-sintY-fallback x-928 y-929)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'str' and 'int'"))))

(define (py-imatmul-strX-bintY-fallback x-930 y-931)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'str' and 'int'"))))

(define (py-imatmul-sintX-floatY-fallback x-932 y-933)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'float'"))))

(define (py-imatmul-sintX-boolY-fallback x-934 y-935)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'bool'"))))

(define (py-imatmul-sintX-strY-fallback x-936 y-937)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'str'"))))

(define (py-imatmul-sintX-sintY-fallback x-938 y-939)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'int'"))))

(define (py-imatmul-sintX-bintY-fallback x-940 y-941)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'int'"))))

(define (py-imatmul-bintX-floatY-fallback x-942 y-943)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'float'"))))

(define (py-imatmul-bintX-boolY-fallback x-944 y-945)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'bool'"))))

(define (py-imatmul-bintX-strY-fallback x-946 y-947)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'str'"))))

(define (py-imatmul-bintX-sintY-fallback x-948 y-949)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'int'"))))

(define (py-imatmul-bintX-bintY-fallback x-950 y-951)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for @=: 'int' and 'int'"))))

(define (py-imod-floatX-floatY-fallback x-952 y-953)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-float-to-scheme y-953) 0.))))
      (py-float-from-scheme
       (py% (py-float-to-scheme x-952) (py-float-to-scheme y-953)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-floatX-boolY-fallback x-954 y-955)
  (if (py-test y-955)
      (py-float-from-scheme
       (py% (py-float-to-scheme x-954) (py-bool-to-scheme-int y-955)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-floatX-strY-fallback x-956 y-957)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %=: 'float' and 'str'"))))

(define (py-imod-floatX-sintY-fallback x-958 y-959)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-sint-to-scheme y-959) 0))))
      (py-float-from-scheme
       (py% (py-float-to-scheme x-958) (py-sint-to-scheme y-959)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-floatX-bintY-fallback x-960 y-961)
  (py-float-from-scheme
   (py% (py-float-to-scheme x-960) (py-bint-to-scheme y-961))))

(define (py-imod-boolX-floatY-fallback x-962 y-963)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-float-to-scheme y-963) 0.))))
      (py-float-from-scheme
       (py% (py-bool-to-scheme-int x-962) (py-float-to-scheme y-963)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-boolX-boolY-fallback x-964 y-965)
  (if (py-test y-965)
      (py-int-from-scheme
       (py% (py-bool-to-scheme-int x-964) (py-bool-to-scheme-int y-965)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-boolX-strY-fallback x-966 y-967)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %=: 'bool' and 'str'"))))

(define (py-imod-boolX-sintY-fallback x-968 y-969)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-sint-to-scheme y-969) 0))))
      (py-int-from-scheme
       (py% (py-bool-to-scheme-int x-968) (py-sint-to-scheme y-969)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-boolX-bintY-fallback x-970 y-971)
  (py-int-from-scheme
   (py% (py-bool-to-scheme-int x-970) (py-bint-to-scheme y-971))))

(define (py-imod-strX-floatY-fallback x-972 y-973)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %=: 'str' and 'float'"))))

(define (py-imod-strX-boolY-fallback x-974 y-975)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %=: 'str' and 'bool'"))))

(define (py-imod-strX-strY-fallback x-976 y-977)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %=: 'str' and 'str'"))))

(define (py-imod-strX-sintY-fallback x-978 y-979)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %=: 'str' and 'int'"))))

(define (py-imod-strX-bintY-fallback x-980 y-981)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %=: 'str' and 'int'"))))

(define (py-imod-sintX-floatY-fallback x-982 y-983)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-float-to-scheme y-983) 0.))))
      (py-float-from-scheme
       (py% (py-sint-to-scheme x-982) (py-float-to-scheme y-983)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-sintX-boolY-fallback x-984 y-985)
  (if (py-test y-985)
      (py-int-from-scheme
       (py% (py-sint-to-scheme x-984) (py-bool-to-scheme-int y-985)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-sintX-strY-fallback x-986 y-987)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %=: 'int' and 'str'"))))

(define (py-imod-sintX-sintY-fallback x-988 y-989)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-sint-to-scheme y-989) 0))))
      (py-int-from-scheme
       (py% (py-sint-to-scheme x-988) (py-sint-to-scheme y-989)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-sintX-bintY-fallback x-990 y-991)
  (py-int-from-scheme
   (py% (py-sint-to-scheme x-990) (py-bint-to-scheme y-991))))

(define (py-imod-bintX-floatY-fallback x-992 y-993)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-float-to-scheme y-993) 0.))))
      (py-float-from-scheme
       (py% (py-bint-to-scheme x-992) (py-float-to-scheme y-993)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float modulo by zero")))))

(define (py-imod-bintX-boolY-fallback x-994 y-995)
  (if (py-test y-995)
      (py-int-from-scheme
       (py% (py-bint-to-scheme x-994) (py-bool-to-scheme-int y-995)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-bintX-strY-fallback x-996 y-997)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for %=: 'int' and 'str'"))))

(define (py-imod-bintX-sintY-fallback x-998 y-999)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-sint-to-scheme y-999) 0))))
      (py-int-from-scheme
       (py% (py-bint-to-scheme x-998) (py-sint-to-scheme y-999)))
      (py-throw (py-call py-builtin-ZeroDivisionError (&& "modulo by zero")))))

(define (py-imod-bintX-bintY-fallback x-1000 y-1001)
  (py-int-from-scheme
   (py% (py-bint-to-scheme x-1000) (py-bint-to-scheme y-1001))))

(define (py-imul-floatX-floatY-fallback x-1002 y-1003)
  (py-float-from-scheme
   (py* (py-float-to-scheme x-1002) (py-float-to-scheme y-1003))))

(define (py-imul-floatX-boolY-fallback x-1004 y-1005)
  (py-float-from-scheme
   (py* (py-float-to-scheme x-1004) (py-bool-to-scheme-int y-1005))))

(define (py-imul-floatX-strY-fallback x-1006 y-1007)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for *=: 'float' and 'str'"))))

(define (py-imul-floatX-sintY-fallback x-1008 y-1009)
  (py-float-from-scheme
   (py* (py-float-to-scheme x-1008) (py-sint-to-scheme y-1009))))

(define (py-imul-floatX-bintY-fallback x-1010 y-1011)
  (py-float-from-scheme
   (py* (py-float-to-scheme x-1010) (py-bint-to-scheme y-1011))))

(define (py-imul-boolX-floatY-fallback x-1012 y-1013)
  (py-float-from-scheme
   (py* (py-bool-to-scheme-int x-1012) (py-float-to-scheme y-1013))))

(define (py-imul-boolX-boolY-fallback x-1014 y-1015)
  (py-int-from-scheme
   (py* (py-bool-to-scheme-int x-1014) (py-bool-to-scheme-int y-1015))))

(define (py-imul-boolX-strY-fallback x-1016 y-1017)
  (py-str-from-scheme
   (py* (py-str-to-scheme y-1017) (py-bool-to-scheme-int x-1016))))

(define (py-imul-boolX-sintY-fallback x-1018 y-1019)
  (py-int-from-scheme
   (py* (py-bool-to-scheme-int x-1018) (py-sint-to-scheme y-1019))))

(define (py-imul-boolX-bintY-fallback x-1020 y-1021)
  (py-int-from-scheme
   (py* (py-bool-to-scheme-int x-1020) (py-bint-to-scheme y-1021))))

(define (py-imul-strX-floatY-fallback x-1022 y-1023)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for *=: 'str' and 'float'"))))

(define (py-imul-strX-boolY-fallback x-1024 y-1025)
  (py-str-from-scheme
   (py* (py-str-to-scheme x-1024) (py-bool-to-scheme-int y-1025))))

(define (py-imul-strX-strY-fallback x-1026 y-1027)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for *=: 'str' and 'str'"))))

(define (py-imul-strX-sintY-fallback x-1028 y-1029)
  (py-str-from-scheme
   (py* (py-str-to-scheme x-1028) (py-sint-to-scheme y-1029))))

(define (py-imul-strX-bintY-fallback x-1030 y-1031)
  (py-str-from-scheme
   (py* (py-str-to-scheme x-1030) (py-bint-to-scheme y-1031))))

(define (py-imul-sintX-floatY-fallback x-1032 y-1033)
  (py-float-from-scheme
   (py* (py-sint-to-scheme x-1032) (py-float-to-scheme y-1033))))

(define (py-imul-sintX-boolY-fallback x-1034 y-1035)
  (py-int-from-scheme
   (py* (py-sint-to-scheme x-1034) (py-bool-to-scheme-int y-1035))))

(define (py-imul-sintX-strY-fallback x-1036 y-1037)
  (py-str-from-scheme
   (py* (py-str-to-scheme y-1037) (py-sint-to-scheme x-1036))))

(define (py-imul-sintX-sintY-fallback x-1038 y-1039)
  (py-int-from-scheme
   (py* (py-sint-to-scheme x-1038) (py-sint-to-scheme y-1039))))

(define (py-imul-sintX-bintY-fallback x-1040 y-1041)
  (py-int-from-scheme
   (py* (py-sint-to-scheme x-1040) (py-bint-to-scheme y-1041))))

(define (py-imul-bintX-floatY-fallback x-1042 y-1043)
  (py-float-from-scheme
   (py* (py-bint-to-scheme x-1042) (py-float-to-scheme y-1043))))

(define (py-imul-bintX-boolY-fallback x-1044 y-1045)
  (py-int-from-scheme
   (py* (py-bint-to-scheme x-1044) (py-bool-to-scheme-int y-1045))))

(define (py-imul-bintX-strY-fallback x-1046 y-1047)
  (py-str-from-scheme
   (py* (py-str-to-scheme y-1047) (py-bint-to-scheme x-1046))))

(define (py-imul-bintX-sintY-fallback x-1048 y-1049)
  (py-int-from-scheme
   (py* (py-bint-to-scheme x-1048) (py-sint-to-scheme y-1049))))

(define (py-imul-bintX-bintY-fallback x-1050 y-1051)
  (py-int-from-scheme
   (py* (py-bint-to-scheme x-1050) (py-bint-to-scheme y-1051))))

(define (py-ipow-floatX-floatY-fallback x-1052 y-1053)
  (py-float-from-scheme
   (py** (py-float-to-scheme x-1052) (py-float-to-scheme y-1053))))

(define (py-ipow-floatX-boolY-fallback x-1054 y-1055)
  (py-float-from-scheme
   (py** (py-float-to-scheme x-1054) (py-bool-to-scheme-int y-1055))))

(define (py-ipow-floatX-strY-fallback x-1056 y-1057)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **=: 'float' and 'str'"))))

(define (py-ipow-floatX-sintY-fallback x-1058 y-1059)
  (py-float-from-scheme
   (py** (py-float-to-scheme x-1058) (py-sint-to-scheme y-1059))))

(define (py-ipow-floatX-bintY-fallback x-1060 y-1061)
  (py-float-from-scheme
   (py** (py-float-to-scheme x-1060) (py-bint-to-scheme y-1061))))

(define (py-ipow-boolX-floatY-fallback x-1062 y-1063)
  (py-float-from-scheme
   (py** (py-bool-to-scheme-int x-1062) (py-float-to-scheme y-1063))))

(define (py-ipow-boolX-boolY-fallback x-1064 y-1065)
  (py-int-from-scheme
   (py** (py-bool-to-scheme-int x-1064) (py-bool-to-scheme-int y-1065))))

(define (py-ipow-boolX-strY-fallback x-1066 y-1067)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **=: 'bool' and 'str'"))))

(define (py-ipow-boolX-sintY-fallback x-1068 y-1069)
  (py-int-from-scheme
   (py** (py-bool-to-scheme-int x-1068) (py-sint-to-scheme y-1069))))

(define (py-ipow-boolX-bintY-fallback x-1070 y-1071)
  (py-int-from-scheme
   (py** (py-bool-to-scheme-int x-1070) (py-bint-to-scheme y-1071))))

(define (py-ipow-strX-floatY-fallback x-1072 y-1073)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **=: 'str' and 'float'"))))

(define (py-ipow-strX-boolY-fallback x-1074 y-1075)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **=: 'str' and 'bool'"))))

(define (py-ipow-strX-strY-fallback x-1076 y-1077)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **=: 'str' and 'str'"))))

(define (py-ipow-strX-sintY-fallback x-1078 y-1079)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **=: 'str' and 'int'"))))

(define (py-ipow-strX-bintY-fallback x-1080 y-1081)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **=: 'str' and 'int'"))))

(define (py-ipow-sintX-floatY-fallback x-1082 y-1083)
  (py-float-from-scheme
   (py** (py-sint-to-scheme x-1082) (py-float-to-scheme y-1083))))

(define (py-ipow-sintX-boolY-fallback x-1084 y-1085)
  (py-int-from-scheme
   (py** (py-sint-to-scheme x-1084) (py-bool-to-scheme-int y-1085))))

(define (py-ipow-sintX-strY-fallback x-1086 y-1087)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **=: 'int' and 'str'"))))

(define (py-ipow-sintX-sintY-fallback x-1088 y-1089)
  (py-int-from-scheme
   (py** (py-sint-to-scheme x-1088) (py-sint-to-scheme y-1089))))

(define (py-ipow-sintX-bintY-fallback x-1090 y-1091)
  (py-int-from-scheme
   (py** (py-sint-to-scheme x-1090) (py-bint-to-scheme y-1091))))

(define (py-ipow-bintX-floatY-fallback x-1092 y-1093)
  (py-float-from-scheme
   (py** (py-bint-to-scheme x-1092) (py-float-to-scheme y-1093))))

(define (py-ipow-bintX-boolY-fallback x-1094 y-1095)
  (py-int-from-scheme
   (py** (py-bint-to-scheme x-1094) (py-bool-to-scheme-int y-1095))))

(define (py-ipow-bintX-strY-fallback x-1096 y-1097)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for **=: 'int' and 'str'"))))

(define (py-ipow-bintX-sintY-fallback x-1098 y-1099)
  (py-int-from-scheme
   (py** (py-bint-to-scheme x-1098) (py-sint-to-scheme y-1099))))

(define (py-ipow-bintX-bintY-fallback x-1100 y-1101)
  (py-int-from-scheme
   (py** (py-bint-to-scheme x-1100) (py-bint-to-scheme y-1101))))

(define (py-irshift-floatX-floatY-fallback x-1102 y-1103)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'float' and 'float'"))))

(define (py-irshift-floatX-boolY-fallback x-1104 y-1105)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'float' and 'bool'"))))

(define (py-irshift-floatX-strY-fallback x-1106 y-1107)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'float' and 'str'"))))

(define (py-irshift-floatX-sintY-fallback x-1108 y-1109)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'float' and 'int'"))))

(define (py-irshift-floatX-bintY-fallback x-1110 y-1111)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'float' and 'int'"))))

(define (py-irshift-boolX-floatY-fallback x-1112 y-1113)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'bool' and 'float'"))))

(define (py-irshift-boolX-boolY-fallback x-1114 y-1115)
  (if (py-test (py-ge y-1115 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bool-to-scheme-int x-1114) (py-bool-to-scheme-int y-1115)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-boolX-strY-fallback x-1116 y-1117)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'bool' and 'str'"))))

(define (py-irshift-boolX-sintY-fallback x-1118 y-1119)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py>= (py-sint-to-scheme y-1119) 0))))
      (py-int-from-scheme
       (py>> (py-bool-to-scheme-int x-1118) (py-sint-to-scheme y-1119)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-boolX-bintY-fallback x-1120 y-1121)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py>= (py-bint-to-scheme y-1121) 0))))
      (py-int-from-scheme
       (py>> (py-bool-to-scheme-int x-1120) (py-bint-to-scheme y-1121)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-strX-floatY-fallback x-1122 y-1123)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'str' and 'float'"))))

(define (py-irshift-strX-boolY-fallback x-1124 y-1125)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'str' and 'bool'"))))

(define (py-irshift-strX-strY-fallback x-1126 y-1127)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'str' and 'str'"))))

(define (py-irshift-strX-sintY-fallback x-1128 y-1129)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'str' and 'int'"))))

(define (py-irshift-strX-bintY-fallback x-1130 y-1131)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'str' and 'int'"))))

(define (py-irshift-sintX-floatY-fallback x-1132 y-1133)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'int' and 'float'"))))

(define (py-irshift-sintX-boolY-fallback x-1134 y-1135)
  (if (py-test (py-ge y-1135 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-sint-to-scheme x-1134) (py-bool-to-scheme-int y-1135)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-sintX-strY-fallback x-1136 y-1137)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'int' and 'str'"))))

(define (py-irshift-sintX-sintY-fallback x-1138 y-1139)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py>= (py-sint-to-scheme y-1139) 0))))
      (py-int-from-scheme
       (py>> (py-sint-to-scheme x-1138) (py-sint-to-scheme y-1139)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-sintX-bintY-fallback x-1140 y-1141)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py>= (py-bint-to-scheme y-1141) 0))))
      (py-int-from-scheme
       (py>> (py-sint-to-scheme x-1140) (py-bint-to-scheme y-1141)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-bintX-floatY-fallback x-1142 y-1143)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'int' and 'float'"))))

(define (py-irshift-bintX-boolY-fallback x-1144 y-1145)
  (if (py-test (py-ge y-1145 (py-int-from-scheme 0)))
      (py-int-from-scheme
       (py>> (py-bint-to-scheme x-1144) (py-bool-to-scheme-int y-1145)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-bintX-strY-fallback x-1146 y-1147)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for >>=: 'int' and 'str'"))))

(define (py-irshift-bintX-sintY-fallback x-1148 y-1149)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py>= (py-sint-to-scheme y-1149) 0))))
      (py-int-from-scheme
       (py>> (py-bint-to-scheme x-1148) (py-sint-to-scheme y-1149)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-irshift-bintX-bintY-fallback x-1150 y-1151)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py>= (py-bint-to-scheme y-1151) 0))))
      (py-int-from-scheme
       (py>> (py-bint-to-scheme x-1150) (py-bint-to-scheme y-1151)))
      (py-throw (py-call py-builtin-ValueError (&& "negative shift count")))))

(define (py-isub-floatX-floatY-fallback x-1152 y-1153)
  (py-float-from-scheme
   (py- (py-float-to-scheme x-1152) (py-float-to-scheme y-1153))))

(define (py-isub-floatX-boolY-fallback x-1154 y-1155)
  (py-float-from-scheme
   (py- (py-float-to-scheme x-1154) (py-bool-to-scheme-int y-1155))))

(define (py-isub-floatX-strY-fallback x-1156 y-1157)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -=: 'float' and 'str'"))))

(define (py-isub-floatX-sintY-fallback x-1158 y-1159)
  (py-float-from-scheme
   (py- (py-float-to-scheme x-1158) (py-sint-to-scheme y-1159))))

(define (py-isub-floatX-bintY-fallback x-1160 y-1161)
  (py-float-from-scheme
   (py- (py-float-to-scheme x-1160) (py-bint-to-scheme y-1161))))

(define (py-isub-boolX-floatY-fallback x-1162 y-1163)
  (py-float-from-scheme
   (py- (py-bool-to-scheme-int x-1162) (py-float-to-scheme y-1163))))

(define (py-isub-boolX-boolY-fallback x-1164 y-1165)
  (py-int-from-scheme
   (py- (py-bool-to-scheme-int x-1164) (py-bool-to-scheme-int y-1165))))

(define (py-isub-boolX-strY-fallback x-1166 y-1167)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -=: 'bool' and 'str'"))))

(define (py-isub-boolX-sintY-fallback x-1168 y-1169)
  (py-int-from-scheme
   (py- (py-bool-to-scheme-int x-1168) (py-sint-to-scheme y-1169))))

(define (py-isub-boolX-bintY-fallback x-1170 y-1171)
  (py-int-from-scheme
   (py- (py-bool-to-scheme-int x-1170) (py-bint-to-scheme y-1171))))

(define (py-isub-strX-floatY-fallback x-1172 y-1173)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -=: 'str' and 'float'"))))

(define (py-isub-strX-boolY-fallback x-1174 y-1175)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -=: 'str' and 'bool'"))))

(define (py-isub-strX-strY-fallback x-1176 y-1177)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -=: 'str' and 'str'"))))

(define (py-isub-strX-sintY-fallback x-1178 y-1179)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -=: 'str' and 'int'"))))

(define (py-isub-strX-bintY-fallback x-1180 y-1181)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -=: 'str' and 'int'"))))

(define (py-isub-sintX-floatY-fallback x-1182 y-1183)
  (py-float-from-scheme
   (py- (py-sint-to-scheme x-1182) (py-float-to-scheme y-1183))))

(define (py-isub-sintX-boolY-fallback x-1184 y-1185)
  (py-int-from-scheme
   (py- (py-sint-to-scheme x-1184) (py-bool-to-scheme-int y-1185))))

(define (py-isub-sintX-strY-fallback x-1186 y-1187)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -=: 'int' and 'str'"))))

(define (py-isub-sintX-sintY-fallback x-1188 y-1189)
  (py-int-from-scheme
   (py- (py-sint-to-scheme x-1188) (py-sint-to-scheme y-1189))))

(define (py-isub-sintX-bintY-fallback x-1190 y-1191)
  (py-int-from-scheme
   (py- (py-sint-to-scheme x-1190) (py-bint-to-scheme y-1191))))

(define (py-isub-bintX-floatY-fallback x-1192 y-1193)
  (py-float-from-scheme
   (py- (py-bint-to-scheme x-1192) (py-float-to-scheme y-1193))))

(define (py-isub-bintX-boolY-fallback x-1194 y-1195)
  (py-int-from-scheme
   (py- (py-bint-to-scheme x-1194) (py-bool-to-scheme-int y-1195))))

(define (py-isub-bintX-strY-fallback x-1196 y-1197)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for -=: 'int' and 'str'"))))

(define (py-isub-bintX-sintY-fallback x-1198 y-1199)
  (py-int-from-scheme
   (py- (py-bint-to-scheme x-1198) (py-sint-to-scheme y-1199))))

(define (py-isub-bintX-bintY-fallback x-1200 y-1201)
  (py-int-from-scheme
   (py- (py-bint-to-scheme x-1200) (py-bint-to-scheme y-1201))))

(define (py-itruediv-floatX-floatY-fallback x-1202 y-1203)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-float-to-scheme y-1203) 0.))))
      (py-float-from-scheme
       (py/ (py-float-to-scheme x-1202) (py-float-to-scheme y-1203)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-floatX-boolY-fallback x-1204 y-1205)
  (if (py-test y-1205)
      (py-float-from-scheme
       (py/ (py-float-to-scheme x-1204) (py-bool-to-scheme-int y-1205)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-floatX-strY-fallback x-1206 y-1207)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /=: 'float' and 'str'"))))

(define (py-itruediv-floatX-sintY-fallback x-1208 y-1209)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-sint-to-scheme y-1209) 0))))
      (py-float-from-scheme
       (py/ (py-float-to-scheme x-1208) (py-sint-to-scheme y-1209)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-floatX-bintY-fallback x-1210 y-1211)
  (py-float-from-scheme
   (py/ (py-float-to-scheme x-1210) (py-bint-to-scheme y-1211))))

(define (py-itruediv-boolX-floatY-fallback x-1212 y-1213)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-float-to-scheme y-1213) 0.))))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme-int x-1212) (py-float-to-scheme y-1213)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-boolX-boolY-fallback x-1214 y-1215)
  (if (py-test y-1215)
      (py-float-from-scheme
       (py/ (py-bool-to-scheme-int x-1214) (py-bool-to-scheme-int y-1215)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-boolX-strY-fallback x-1216 y-1217)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /=: 'bool' and 'str'"))))

(define (py-itruediv-boolX-sintY-fallback x-1218 y-1219)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-sint-to-scheme y-1219) 0))))
      (py-float-from-scheme
       (py/ (py-bool-to-scheme-int x-1218) (py-sint-to-scheme y-1219)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-boolX-bintY-fallback x-1220 y-1221)
  (py-float-from-scheme
   (py/ (py-bool-to-scheme-int x-1220) (py-bint-to-scheme y-1221))))

(define (py-itruediv-strX-floatY-fallback x-1222 y-1223)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /=: 'str' and 'float'"))))

(define (py-itruediv-strX-boolY-fallback x-1224 y-1225)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /=: 'str' and 'bool'"))))

(define (py-itruediv-strX-strY-fallback x-1226 y-1227)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /=: 'str' and 'str'"))))

(define (py-itruediv-strX-sintY-fallback x-1228 y-1229)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /=: 'str' and 'int'"))))

(define (py-itruediv-strX-bintY-fallback x-1230 y-1231)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /=: 'str' and 'int'"))))

(define (py-itruediv-sintX-floatY-fallback x-1232 y-1233)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-float-to-scheme y-1233) 0.))))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme x-1232) (py-float-to-scheme y-1233)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-sintX-boolY-fallback x-1234 y-1235)
  (if (py-test y-1235)
      (py-float-from-scheme
       (py/ (py-sint-to-scheme x-1234) (py-bool-to-scheme-int y-1235)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-sintX-strY-fallback x-1236 y-1237)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /=: 'int' and 'str'"))))

(define (py-itruediv-sintX-sintY-fallback x-1238 y-1239)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-sint-to-scheme y-1239) 0))))
      (py-float-from-scheme
       (py/ (py-sint-to-scheme x-1238) (py-sint-to-scheme y-1239)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-sintX-bintY-fallback x-1240 y-1241)
  (py-float-from-scheme
   (py/ (py-sint-to-scheme x-1240) (py-bint-to-scheme y-1241))))

(define (py-itruediv-bintX-floatY-fallback x-1242 y-1243)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-float-to-scheme y-1243) 0.))))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme x-1242) (py-float-to-scheme y-1243)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "float division by zero")))))

(define (py-itruediv-bintX-boolY-fallback x-1244 y-1245)
  (if (py-test y-1245)
      (py-float-from-scheme
       (py/ (py-bint-to-scheme x-1244) (py-bool-to-scheme-int y-1245)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-bintX-strY-fallback x-1246 y-1247)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for /=: 'int' and 'str'"))))

(define (py-itruediv-bintX-sintY-fallback x-1248 y-1249)
  (if (py-test (py-bool-from-scheme-bool
                (py-test-from-scheme (py!= (py-sint-to-scheme y-1249) 0))))
      (py-float-from-scheme
       (py/ (py-bint-to-scheme x-1248) (py-sint-to-scheme y-1249)))
      (py-throw
       (py-call py-builtin-ZeroDivisionError (&& "division by zero")))))

(define (py-itruediv-bintX-bintY-fallback x-1250 y-1251)
  (py-float-from-scheme
   (py/ (py-bint-to-scheme x-1250) (py-bint-to-scheme y-1251))))

(define (py-ixor-floatX-floatY-fallback x-1252 y-1253)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'float' and 'float'"))))

(define (py-ixor-floatX-boolY-fallback x-1254 y-1255)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'float' and 'bool'"))))

(define (py-ixor-floatX-strY-fallback x-1256 y-1257)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'float' and 'str'"))))

(define (py-ixor-floatX-sintY-fallback x-1258 y-1259)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'float' and 'int'"))))

(define (py-ixor-floatX-bintY-fallback x-1260 y-1261)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'float' and 'int'"))))

(define (py-ixor-boolX-floatY-fallback x-1262 y-1263)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'bool' and 'float'"))))

(define (py-ixor-boolX-boolY-fallback x-1264 y-1265)
  (py-int-from-scheme
   (py^ (py-bool-to-scheme-int x-1264) (py-bool-to-scheme-int y-1265))))

(define (py-ixor-boolX-strY-fallback x-1266 y-1267)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'bool' and 'str'"))))

(define (py-ixor-boolX-sintY-fallback x-1268 y-1269)
  (py-int-from-scheme
   (py^ (py-bool-to-scheme-int x-1268) (py-sint-to-scheme y-1269))))

(define (py-ixor-boolX-bintY-fallback x-1270 y-1271)
  (py-int-from-scheme
   (py^ (py-bool-to-scheme-int x-1270) (py-bint-to-scheme y-1271))))

(define (py-ixor-strX-floatY-fallback x-1272 y-1273)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'str' and 'float'"))))

(define (py-ixor-strX-boolY-fallback x-1274 y-1275)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'str' and 'bool'"))))

(define (py-ixor-strX-strY-fallback x-1276 y-1277)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'str' and 'str'"))))

(define (py-ixor-strX-sintY-fallback x-1278 y-1279)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'str' and 'int'"))))

(define (py-ixor-strX-bintY-fallback x-1280 y-1281)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'str' and 'int'"))))

(define (py-ixor-sintX-floatY-fallback x-1282 y-1283)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'int' and 'float'"))))

(define (py-ixor-sintX-boolY-fallback x-1284 y-1285)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme x-1284) (py-bool-to-scheme-int y-1285))))

(define (py-ixor-sintX-strY-fallback x-1286 y-1287)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'int' and 'str'"))))

(define (py-ixor-sintX-sintY-fallback x-1288 y-1289)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme x-1288) (py-sint-to-scheme y-1289))))

(define (py-ixor-sintX-bintY-fallback x-1290 y-1291)
  (py-int-from-scheme
   (py^ (py-sint-to-scheme x-1290) (py-bint-to-scheme y-1291))))

(define (py-ixor-bintX-floatY-fallback x-1292 y-1293)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'int' and 'float'"))))

(define (py-ixor-bintX-boolY-fallback x-1294 y-1295)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme x-1294) (py-bool-to-scheme-int y-1295))))

(define (py-ixor-bintX-strY-fallback x-1296 y-1297)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "unsupported operand type(s) for ^=: 'int' and 'str'"))))

(define (py-ixor-bintX-sintY-fallback x-1298 y-1299)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme x-1298) (py-sint-to-scheme y-1299))))

(define (py-ixor-bintX-bintY-fallback x-1300 y-1301)
  (py-int-from-scheme
   (py^ (py-bint-to-scheme x-1300) (py-bint-to-scheme y-1301))))

(define (py-ge-floatX-floatY-fallback x-1302 y-1303)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-float-to-scheme x-1302) (py-float-to-scheme y-1303)))))

(define (py-test-ge-floatX-floatY-fallback x-1304 y-1305)
  (py-test-from-scheme
   (py>= (py-float-to-scheme x-1304) (py-float-to-scheme y-1305))))

(define (py-ge-floatX-boolY-fallback x-1306 y-1307)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-float-to-scheme x-1306) (py-bool-to-scheme-int y-1307)))))

(define (py-test-ge-floatX-boolY-fallback x-1308 y-1309)
  (py-test-from-scheme
   (py>= (py-float-to-scheme x-1308) (py-bool-to-scheme-int y-1309))))

(define (py-ge-floatX-strY-fallback x-1310 y-1311)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>=' not supported between instances of 'float' and 'str'"))))

(define (py-test-ge-floatX-strY-fallback x-1312 y-1313)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>=' not supported between instances of 'float' and 'str'"))))

(define (py-ge-floatX-sintY-fallback x-1314 y-1315)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-float-to-scheme x-1314) (py-sint-to-scheme y-1315)))))

(define (py-test-ge-floatX-sintY-fallback x-1316 y-1317)
  (py-test-from-scheme
   (py>= (py-float-to-scheme x-1316) (py-sint-to-scheme y-1317))))

(define (py-ge-floatX-bintY-fallback x-1318 y-1319)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-float-to-scheme x-1318) (py-bint-to-scheme y-1319)))))

(define (py-test-ge-floatX-bintY-fallback x-1320 y-1321)
  (py-test-from-scheme
   (py>= (py-float-to-scheme x-1320) (py-bint-to-scheme y-1321))))

(define (py-ge-boolX-floatY-fallback x-1322 y-1323)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-float-to-scheme y-1323) (py-bool-to-scheme-int x-1322)))))

(define (py-test-ge-boolX-floatY-fallback x-1324 y-1325)
  (py-test-from-scheme
   (py<= (py-float-to-scheme y-1325) (py-bool-to-scheme-int x-1324))))

(define (py-ge-boolX-boolY-fallback x-1326 y-1327)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-bool-to-scheme-int x-1326) (py-bool-to-scheme-int y-1327)))))

(define (py-test-ge-boolX-boolY-fallback x-1328 y-1329)
  (py-test-from-scheme
   (py>= (py-bool-to-scheme-int x-1328) (py-bool-to-scheme-int y-1329))))

(define (py-ge-boolX-strY-fallback x-1330 y-1331)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>=' not supported between instances of 'bool' and 'str'"))))

(define (py-test-ge-boolX-strY-fallback x-1332 y-1333)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>=' not supported between instances of 'bool' and 'str'"))))

(define (py-ge-boolX-sintY-fallback x-1334 y-1335)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-bool-to-scheme-int x-1334) (py-sint-to-scheme y-1335)))))

(define (py-test-ge-boolX-sintY-fallback x-1336 y-1337)
  (py-test-from-scheme
   (py>= (py-bool-to-scheme-int x-1336) (py-sint-to-scheme y-1337))))

(define (py-ge-boolX-bintY-fallback x-1338 y-1339)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-bool-to-scheme-int x-1338) (py-bint-to-scheme y-1339)))))

(define (py-test-ge-boolX-bintY-fallback x-1340 y-1341)
  (py-test-from-scheme
   (py>= (py-bool-to-scheme-int x-1340) (py-bint-to-scheme y-1341))))

(define (py-ge-strX-floatY-fallback x-1342 y-1343)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>=' not supported between instances of 'str' and 'float'"))))

(define (py-test-ge-strX-floatY-fallback x-1344 y-1345)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>=' not supported between instances of 'str' and 'float'"))))

(define (py-ge-strX-boolY-fallback x-1346 y-1347)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>=' not supported between instances of 'str' and 'bool'"))))

(define (py-test-ge-strX-boolY-fallback x-1348 y-1349)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>=' not supported between instances of 'str' and 'bool'"))))

(define (py-ge-strX-strY-fallback x-1350 y-1351)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-str-to-scheme x-1350) (py-str-to-scheme y-1351)))))

(define (py-test-ge-strX-strY-fallback x-1352 y-1353)
  (py-test-from-scheme
   (py>= (py-str-to-scheme x-1352) (py-str-to-scheme y-1353))))

(define (py-ge-strX-sintY-fallback x-1354 y-1355)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>=' not supported between instances of 'str' and 'int'"))))

(define (py-test-ge-strX-sintY-fallback x-1356 y-1357)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>=' not supported between instances of 'str' and 'int'"))))

(define (py-ge-strX-bintY-fallback x-1358 y-1359)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>=' not supported between instances of 'str' and 'int'"))))

(define (py-test-ge-strX-bintY-fallback x-1360 y-1361)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>=' not supported between instances of 'str' and 'int'"))))

(define (py-ge-sintX-floatY-fallback x-1362 y-1363)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-float-to-scheme y-1363) (py-sint-to-scheme x-1362)))))

(define (py-test-ge-sintX-floatY-fallback x-1364 y-1365)
  (py-test-from-scheme
   (py<= (py-float-to-scheme y-1365) (py-sint-to-scheme x-1364))))

(define (py-ge-sintX-boolY-fallback x-1366 y-1367)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-sint-to-scheme x-1366) (py-bool-to-scheme-int y-1367)))))

(define (py-test-ge-sintX-boolY-fallback x-1368 y-1369)
  (py-test-from-scheme
   (py>= (py-sint-to-scheme x-1368) (py-bool-to-scheme-int y-1369))))

(define (py-ge-sintX-strY-fallback x-1370 y-1371)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>=' not supported between instances of 'int' and 'str'"))))

(define (py-test-ge-sintX-strY-fallback x-1372 y-1373)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>=' not supported between instances of 'int' and 'str'"))))

(define (py-ge-sintX-sintY-fallback x-1374 y-1375)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-sint-to-scheme x-1374) (py-sint-to-scheme y-1375)))))

(define (py-test-ge-sintX-sintY-fallback x-1376 y-1377)
  (py-test-from-scheme
   (py>= (py-sint-to-scheme x-1376) (py-sint-to-scheme y-1377))))

(define (py-ge-sintX-bintY-fallback x-1378 y-1379)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-sint-to-scheme x-1378) (py-bint-to-scheme y-1379)))))

(define (py-test-ge-sintX-bintY-fallback x-1380 y-1381)
  (py-test-from-scheme
   (py>= (py-sint-to-scheme x-1380) (py-bint-to-scheme y-1381))))

(define (py-ge-bintX-floatY-fallback x-1382 y-1383)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-float-to-scheme y-1383) (py-bint-to-scheme x-1382)))))

(define (py-test-ge-bintX-floatY-fallback x-1384 y-1385)
  (py-test-from-scheme
   (py<= (py-float-to-scheme y-1385) (py-bint-to-scheme x-1384))))

(define (py-ge-bintX-boolY-fallback x-1386 y-1387)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-bint-to-scheme x-1386) (py-bool-to-scheme-int y-1387)))))

(define (py-test-ge-bintX-boolY-fallback x-1388 y-1389)
  (py-test-from-scheme
   (py>= (py-bint-to-scheme x-1388) (py-bool-to-scheme-int y-1389))))

(define (py-ge-bintX-strY-fallback x-1390 y-1391)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>=' not supported between instances of 'int' and 'str'"))))

(define (py-test-ge-bintX-strY-fallback x-1392 y-1393)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>=' not supported between instances of 'int' and 'str'"))))

(define (py-ge-bintX-sintY-fallback x-1394 y-1395)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-bint-to-scheme x-1394) (py-sint-to-scheme y-1395)))))

(define (py-test-ge-bintX-sintY-fallback x-1396 y-1397)
  (py-test-from-scheme
   (py>= (py-bint-to-scheme x-1396) (py-sint-to-scheme y-1397))))

(define (py-ge-bintX-bintY-fallback x-1398 y-1399)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-bint-to-scheme x-1398) (py-bint-to-scheme y-1399)))))

(define (py-test-ge-bintX-bintY-fallback x-1400 y-1401)
  (py-test-from-scheme
   (py>= (py-bint-to-scheme x-1400) (py-bint-to-scheme y-1401))))

(define (py-gt-floatX-floatY-fallback x-1402 y-1403)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-float-to-scheme x-1402) (py-float-to-scheme y-1403)))))

(define (py-test-gt-floatX-floatY-fallback x-1404 y-1405)
  (py-test-from-scheme
   (py> (py-float-to-scheme x-1404) (py-float-to-scheme y-1405))))

(define (py-gt-floatX-boolY-fallback x-1406 y-1407)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-float-to-scheme x-1406) (py-bool-to-scheme-int y-1407)))))

(define (py-test-gt-floatX-boolY-fallback x-1408 y-1409)
  (py-test-from-scheme
   (py> (py-float-to-scheme x-1408) (py-bool-to-scheme-int y-1409))))

(define (py-gt-floatX-strY-fallback x-1410 y-1411)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>' not supported between instances of 'float' and 'str'"))))

(define (py-test-gt-floatX-strY-fallback x-1412 y-1413)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>' not supported between instances of 'float' and 'str'"))))

(define (py-gt-floatX-sintY-fallback x-1414 y-1415)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-float-to-scheme x-1414) (py-sint-to-scheme y-1415)))))

(define (py-test-gt-floatX-sintY-fallback x-1416 y-1417)
  (py-test-from-scheme
   (py> (py-float-to-scheme x-1416) (py-sint-to-scheme y-1417))))

(define (py-gt-floatX-bintY-fallback x-1418 y-1419)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-float-to-scheme x-1418) (py-bint-to-scheme y-1419)))))

(define (py-test-gt-floatX-bintY-fallback x-1420 y-1421)
  (py-test-from-scheme
   (py> (py-float-to-scheme x-1420) (py-bint-to-scheme y-1421))))

(define (py-gt-boolX-floatY-fallback x-1422 y-1423)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-float-to-scheme y-1423) (py-bool-to-scheme-int x-1422)))))

(define (py-test-gt-boolX-floatY-fallback x-1424 y-1425)
  (py-test-from-scheme
   (py< (py-float-to-scheme y-1425) (py-bool-to-scheme-int x-1424))))

(define (py-gt-boolX-boolY-fallback x-1426 y-1427)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-bool-to-scheme-int x-1426) (py-bool-to-scheme-int y-1427)))))

(define (py-test-gt-boolX-boolY-fallback x-1428 y-1429)
  (py-test-from-scheme
   (py> (py-bool-to-scheme-int x-1428) (py-bool-to-scheme-int y-1429))))

(define (py-gt-boolX-strY-fallback x-1430 y-1431)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>' not supported between instances of 'bool' and 'str'"))))

(define (py-test-gt-boolX-strY-fallback x-1432 y-1433)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>' not supported between instances of 'bool' and 'str'"))))

(define (py-gt-boolX-sintY-fallback x-1434 y-1435)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-bool-to-scheme-int x-1434) (py-sint-to-scheme y-1435)))))

(define (py-test-gt-boolX-sintY-fallback x-1436 y-1437)
  (py-test-from-scheme
   (py> (py-bool-to-scheme-int x-1436) (py-sint-to-scheme y-1437))))

(define (py-gt-boolX-bintY-fallback x-1438 y-1439)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-bool-to-scheme-int x-1438) (py-bint-to-scheme y-1439)))))

(define (py-test-gt-boolX-bintY-fallback x-1440 y-1441)
  (py-test-from-scheme
   (py> (py-bool-to-scheme-int x-1440) (py-bint-to-scheme y-1441))))

(define (py-gt-strX-floatY-fallback x-1442 y-1443)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>' not supported between instances of 'str' and 'float'"))))

(define (py-test-gt-strX-floatY-fallback x-1444 y-1445)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>' not supported between instances of 'str' and 'float'"))))

(define (py-gt-strX-boolY-fallback x-1446 y-1447)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>' not supported between instances of 'str' and 'bool'"))))

(define (py-test-gt-strX-boolY-fallback x-1448 y-1449)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>' not supported between instances of 'str' and 'bool'"))))

(define (py-gt-strX-strY-fallback x-1450 y-1451)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-str-to-scheme x-1450) (py-str-to-scheme y-1451)))))

(define (py-test-gt-strX-strY-fallback x-1452 y-1453)
  (py-test-from-scheme
   (py> (py-str-to-scheme x-1452) (py-str-to-scheme y-1453))))

(define (py-gt-strX-sintY-fallback x-1454 y-1455)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>' not supported between instances of 'str' and 'int'"))))

(define (py-test-gt-strX-sintY-fallback x-1456 y-1457)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>' not supported between instances of 'str' and 'int'"))))

(define (py-gt-strX-bintY-fallback x-1458 y-1459)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>' not supported between instances of 'str' and 'int'"))))

(define (py-test-gt-strX-bintY-fallback x-1460 y-1461)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>' not supported between instances of 'str' and 'int'"))))

(define (py-gt-sintX-floatY-fallback x-1462 y-1463)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-float-to-scheme y-1463) (py-sint-to-scheme x-1462)))))

(define (py-test-gt-sintX-floatY-fallback x-1464 y-1465)
  (py-test-from-scheme
   (py< (py-float-to-scheme y-1465) (py-sint-to-scheme x-1464))))

(define (py-gt-sintX-boolY-fallback x-1466 y-1467)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-sint-to-scheme x-1466) (py-bool-to-scheme-int y-1467)))))

(define (py-test-gt-sintX-boolY-fallback x-1468 y-1469)
  (py-test-from-scheme
   (py> (py-sint-to-scheme x-1468) (py-bool-to-scheme-int y-1469))))

(define (py-gt-sintX-strY-fallback x-1470 y-1471)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>' not supported between instances of 'int' and 'str'"))))

(define (py-test-gt-sintX-strY-fallback x-1472 y-1473)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>' not supported between instances of 'int' and 'str'"))))

(define (py-gt-sintX-sintY-fallback x-1474 y-1475)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-sint-to-scheme x-1474) (py-sint-to-scheme y-1475)))))

(define (py-test-gt-sintX-sintY-fallback x-1476 y-1477)
  (py-test-from-scheme
   (py> (py-sint-to-scheme x-1476) (py-sint-to-scheme y-1477))))

(define (py-gt-sintX-bintY-fallback x-1478 y-1479)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-sint-to-scheme x-1478) (py-bint-to-scheme y-1479)))))

(define (py-test-gt-sintX-bintY-fallback x-1480 y-1481)
  (py-test-from-scheme
   (py> (py-sint-to-scheme x-1480) (py-bint-to-scheme y-1481))))

(define (py-gt-bintX-floatY-fallback x-1482 y-1483)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-float-to-scheme y-1483) (py-bint-to-scheme x-1482)))))

(define (py-test-gt-bintX-floatY-fallback x-1484 y-1485)
  (py-test-from-scheme
   (py< (py-float-to-scheme y-1485) (py-bint-to-scheme x-1484))))

(define (py-gt-bintX-boolY-fallback x-1486 y-1487)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-bint-to-scheme x-1486) (py-bool-to-scheme-int y-1487)))))

(define (py-test-gt-bintX-boolY-fallback x-1488 y-1489)
  (py-test-from-scheme
   (py> (py-bint-to-scheme x-1488) (py-bool-to-scheme-int y-1489))))

(define (py-gt-bintX-strY-fallback x-1490 y-1491)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>' not supported between instances of 'int' and 'str'"))))

(define (py-test-gt-bintX-strY-fallback x-1492 y-1493)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'>' not supported between instances of 'int' and 'str'"))))

(define (py-gt-bintX-sintY-fallback x-1494 y-1495)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-bint-to-scheme x-1494) (py-sint-to-scheme y-1495)))))

(define (py-test-gt-bintX-sintY-fallback x-1496 y-1497)
  (py-test-from-scheme
   (py> (py-bint-to-scheme x-1496) (py-sint-to-scheme y-1497))))

(define (py-gt-bintX-bintY-fallback x-1498 y-1499)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-bint-to-scheme x-1498) (py-bint-to-scheme y-1499)))))

(define (py-test-gt-bintX-bintY-fallback x-1500 y-1501)
  (py-test-from-scheme
   (py> (py-bint-to-scheme x-1500) (py-bint-to-scheme y-1501))))

(define (py-le-floatX-floatY-fallback x-1502 y-1503)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-float-to-scheme x-1502) (py-float-to-scheme y-1503)))))

(define (py-test-le-floatX-floatY-fallback x-1504 y-1505)
  (py-test-from-scheme
   (py<= (py-float-to-scheme x-1504) (py-float-to-scheme y-1505))))

(define (py-le-floatX-boolY-fallback x-1506 y-1507)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-float-to-scheme x-1506) (py-bool-to-scheme-int y-1507)))))

(define (py-test-le-floatX-boolY-fallback x-1508 y-1509)
  (py-test-from-scheme
   (py<= (py-float-to-scheme x-1508) (py-bool-to-scheme-int y-1509))))

(define (py-le-floatX-strY-fallback x-1510 y-1511)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<=' not supported between instances of 'float' and 'str'"))))

(define (py-test-le-floatX-strY-fallback x-1512 y-1513)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<=' not supported between instances of 'float' and 'str'"))))

(define (py-le-floatX-sintY-fallback x-1514 y-1515)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-float-to-scheme x-1514) (py-sint-to-scheme y-1515)))))

(define (py-test-le-floatX-sintY-fallback x-1516 y-1517)
  (py-test-from-scheme
   (py<= (py-float-to-scheme x-1516) (py-sint-to-scheme y-1517))))

(define (py-le-floatX-bintY-fallback x-1518 y-1519)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-float-to-scheme x-1518) (py-bint-to-scheme y-1519)))))

(define (py-test-le-floatX-bintY-fallback x-1520 y-1521)
  (py-test-from-scheme
   (py<= (py-float-to-scheme x-1520) (py-bint-to-scheme y-1521))))

(define (py-le-boolX-floatY-fallback x-1522 y-1523)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-float-to-scheme y-1523) (py-bool-to-scheme-int x-1522)))))

(define (py-test-le-boolX-floatY-fallback x-1524 y-1525)
  (py-test-from-scheme
   (py>= (py-float-to-scheme y-1525) (py-bool-to-scheme-int x-1524))))

(define (py-le-boolX-boolY-fallback x-1526 y-1527)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-bool-to-scheme-int x-1526) (py-bool-to-scheme-int y-1527)))))

(define (py-test-le-boolX-boolY-fallback x-1528 y-1529)
  (py-test-from-scheme
   (py<= (py-bool-to-scheme-int x-1528) (py-bool-to-scheme-int y-1529))))

(define (py-le-boolX-strY-fallback x-1530 y-1531)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<=' not supported between instances of 'bool' and 'str'"))))

(define (py-test-le-boolX-strY-fallback x-1532 y-1533)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<=' not supported between instances of 'bool' and 'str'"))))

(define (py-le-boolX-sintY-fallback x-1534 y-1535)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-bool-to-scheme-int x-1534) (py-sint-to-scheme y-1535)))))

(define (py-test-le-boolX-sintY-fallback x-1536 y-1537)
  (py-test-from-scheme
   (py<= (py-bool-to-scheme-int x-1536) (py-sint-to-scheme y-1537))))

(define (py-le-boolX-bintY-fallback x-1538 y-1539)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-bool-to-scheme-int x-1538) (py-bint-to-scheme y-1539)))))

(define (py-test-le-boolX-bintY-fallback x-1540 y-1541)
  (py-test-from-scheme
   (py<= (py-bool-to-scheme-int x-1540) (py-bint-to-scheme y-1541))))

(define (py-le-strX-floatY-fallback x-1542 y-1543)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<=' not supported between instances of 'str' and 'float'"))))

(define (py-test-le-strX-floatY-fallback x-1544 y-1545)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<=' not supported between instances of 'str' and 'float'"))))

(define (py-le-strX-boolY-fallback x-1546 y-1547)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<=' not supported between instances of 'str' and 'bool'"))))

(define (py-test-le-strX-boolY-fallback x-1548 y-1549)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<=' not supported between instances of 'str' and 'bool'"))))

(define (py-le-strX-strY-fallback x-1550 y-1551)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-str-to-scheme x-1550) (py-str-to-scheme y-1551)))))

(define (py-test-le-strX-strY-fallback x-1552 y-1553)
  (py-test-from-scheme
   (py<= (py-str-to-scheme x-1552) (py-str-to-scheme y-1553))))

(define (py-le-strX-sintY-fallback x-1554 y-1555)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<=' not supported between instances of 'str' and 'int'"))))

(define (py-test-le-strX-sintY-fallback x-1556 y-1557)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<=' not supported between instances of 'str' and 'int'"))))

(define (py-le-strX-bintY-fallback x-1558 y-1559)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<=' not supported between instances of 'str' and 'int'"))))

(define (py-test-le-strX-bintY-fallback x-1560 y-1561)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<=' not supported between instances of 'str' and 'int'"))))

(define (py-le-sintX-floatY-fallback x-1562 y-1563)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-float-to-scheme y-1563) (py-sint-to-scheme x-1562)))))

(define (py-test-le-sintX-floatY-fallback x-1564 y-1565)
  (py-test-from-scheme
   (py>= (py-float-to-scheme y-1565) (py-sint-to-scheme x-1564))))

(define (py-le-sintX-boolY-fallback x-1566 y-1567)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-sint-to-scheme x-1566) (py-bool-to-scheme-int y-1567)))))

(define (py-test-le-sintX-boolY-fallback x-1568 y-1569)
  (py-test-from-scheme
   (py<= (py-sint-to-scheme x-1568) (py-bool-to-scheme-int y-1569))))

(define (py-le-sintX-strY-fallback x-1570 y-1571)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<=' not supported between instances of 'int' and 'str'"))))

(define (py-test-le-sintX-strY-fallback x-1572 y-1573)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<=' not supported between instances of 'int' and 'str'"))))

(define (py-le-sintX-sintY-fallback x-1574 y-1575)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-sint-to-scheme x-1574) (py-sint-to-scheme y-1575)))))

(define (py-test-le-sintX-sintY-fallback x-1576 y-1577)
  (py-test-from-scheme
   (py<= (py-sint-to-scheme x-1576) (py-sint-to-scheme y-1577))))

(define (py-le-sintX-bintY-fallback x-1578 y-1579)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-sint-to-scheme x-1578) (py-bint-to-scheme y-1579)))))

(define (py-test-le-sintX-bintY-fallback x-1580 y-1581)
  (py-test-from-scheme
   (py<= (py-sint-to-scheme x-1580) (py-bint-to-scheme y-1581))))

(define (py-le-bintX-floatY-fallback x-1582 y-1583)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py>= (py-float-to-scheme y-1583) (py-bint-to-scheme x-1582)))))

(define (py-test-le-bintX-floatY-fallback x-1584 y-1585)
  (py-test-from-scheme
   (py>= (py-float-to-scheme y-1585) (py-bint-to-scheme x-1584))))

(define (py-le-bintX-boolY-fallback x-1586 y-1587)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-bint-to-scheme x-1586) (py-bool-to-scheme-int y-1587)))))

(define (py-test-le-bintX-boolY-fallback x-1588 y-1589)
  (py-test-from-scheme
   (py<= (py-bint-to-scheme x-1588) (py-bool-to-scheme-int y-1589))))

(define (py-le-bintX-strY-fallback x-1590 y-1591)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<=' not supported between instances of 'int' and 'str'"))))

(define (py-test-le-bintX-strY-fallback x-1592 y-1593)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<=' not supported between instances of 'int' and 'str'"))))

(define (py-le-bintX-sintY-fallback x-1594 y-1595)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-bint-to-scheme x-1594) (py-sint-to-scheme y-1595)))))

(define (py-test-le-bintX-sintY-fallback x-1596 y-1597)
  (py-test-from-scheme
   (py<= (py-bint-to-scheme x-1596) (py-sint-to-scheme y-1597))))

(define (py-le-bintX-bintY-fallback x-1598 y-1599)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py<= (py-bint-to-scheme x-1598) (py-bint-to-scheme y-1599)))))

(define (py-test-le-bintX-bintY-fallback x-1600 y-1601)
  (py-test-from-scheme
   (py<= (py-bint-to-scheme x-1600) (py-bint-to-scheme y-1601))))

(define (py-lt-floatX-floatY-fallback x-1602 y-1603)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-float-to-scheme x-1602) (py-float-to-scheme y-1603)))))

(define (py-test-lt-floatX-floatY-fallback x-1604 y-1605)
  (py-test-from-scheme
   (py< (py-float-to-scheme x-1604) (py-float-to-scheme y-1605))))

(define (py-lt-floatX-boolY-fallback x-1606 y-1607)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-float-to-scheme x-1606) (py-bool-to-scheme-int y-1607)))))

(define (py-test-lt-floatX-boolY-fallback x-1608 y-1609)
  (py-test-from-scheme
   (py< (py-float-to-scheme x-1608) (py-bool-to-scheme-int y-1609))))

(define (py-lt-floatX-strY-fallback x-1610 y-1611)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<' not supported between instances of 'float' and 'str'"))))

(define (py-test-lt-floatX-strY-fallback x-1612 y-1613)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<' not supported between instances of 'float' and 'str'"))))

(define (py-lt-floatX-sintY-fallback x-1614 y-1615)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-float-to-scheme x-1614) (py-sint-to-scheme y-1615)))))

(define (py-test-lt-floatX-sintY-fallback x-1616 y-1617)
  (py-test-from-scheme
   (py< (py-float-to-scheme x-1616) (py-sint-to-scheme y-1617))))

(define (py-lt-floatX-bintY-fallback x-1618 y-1619)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-float-to-scheme x-1618) (py-bint-to-scheme y-1619)))))

(define (py-test-lt-floatX-bintY-fallback x-1620 y-1621)
  (py-test-from-scheme
   (py< (py-float-to-scheme x-1620) (py-bint-to-scheme y-1621))))

(define (py-lt-boolX-floatY-fallback x-1622 y-1623)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-float-to-scheme y-1623) (py-bool-to-scheme-int x-1622)))))

(define (py-test-lt-boolX-floatY-fallback x-1624 y-1625)
  (py-test-from-scheme
   (py> (py-float-to-scheme y-1625) (py-bool-to-scheme-int x-1624))))

(define (py-lt-boolX-boolY-fallback x-1626 y-1627)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-bool-to-scheme-int x-1626) (py-bool-to-scheme-int y-1627)))))

(define (py-test-lt-boolX-boolY-fallback x-1628 y-1629)
  (py-test-from-scheme
   (py< (py-bool-to-scheme-int x-1628) (py-bool-to-scheme-int y-1629))))

(define (py-lt-boolX-strY-fallback x-1630 y-1631)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<' not supported between instances of 'bool' and 'str'"))))

(define (py-test-lt-boolX-strY-fallback x-1632 y-1633)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<' not supported between instances of 'bool' and 'str'"))))

(define (py-lt-boolX-sintY-fallback x-1634 y-1635)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-bool-to-scheme-int x-1634) (py-sint-to-scheme y-1635)))))

(define (py-test-lt-boolX-sintY-fallback x-1636 y-1637)
  (py-test-from-scheme
   (py< (py-bool-to-scheme-int x-1636) (py-sint-to-scheme y-1637))))

(define (py-lt-boolX-bintY-fallback x-1638 y-1639)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-bool-to-scheme-int x-1638) (py-bint-to-scheme y-1639)))))

(define (py-test-lt-boolX-bintY-fallback x-1640 y-1641)
  (py-test-from-scheme
   (py< (py-bool-to-scheme-int x-1640) (py-bint-to-scheme y-1641))))

(define (py-lt-strX-floatY-fallback x-1642 y-1643)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<' not supported between instances of 'str' and 'float'"))))

(define (py-test-lt-strX-floatY-fallback x-1644 y-1645)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<' not supported between instances of 'str' and 'float'"))))

(define (py-lt-strX-boolY-fallback x-1646 y-1647)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<' not supported between instances of 'str' and 'bool'"))))

(define (py-test-lt-strX-boolY-fallback x-1648 y-1649)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<' not supported between instances of 'str' and 'bool'"))))

(define (py-lt-strX-strY-fallback x-1650 y-1651)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-str-to-scheme x-1650) (py-str-to-scheme y-1651)))))

(define (py-test-lt-strX-strY-fallback x-1652 y-1653)
  (py-test-from-scheme
   (py< (py-str-to-scheme x-1652) (py-str-to-scheme y-1653))))

(define (py-lt-strX-sintY-fallback x-1654 y-1655)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<' not supported between instances of 'str' and 'int'"))))

(define (py-test-lt-strX-sintY-fallback x-1656 y-1657)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<' not supported between instances of 'str' and 'int'"))))

(define (py-lt-strX-bintY-fallback x-1658 y-1659)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<' not supported between instances of 'str' and 'int'"))))

(define (py-test-lt-strX-bintY-fallback x-1660 y-1661)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<' not supported between instances of 'str' and 'int'"))))

(define (py-lt-sintX-floatY-fallback x-1662 y-1663)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-float-to-scheme y-1663) (py-sint-to-scheme x-1662)))))

(define (py-test-lt-sintX-floatY-fallback x-1664 y-1665)
  (py-test-from-scheme
   (py> (py-float-to-scheme y-1665) (py-sint-to-scheme x-1664))))

(define (py-lt-sintX-boolY-fallback x-1666 y-1667)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-sint-to-scheme x-1666) (py-bool-to-scheme-int y-1667)))))

(define (py-test-lt-sintX-boolY-fallback x-1668 y-1669)
  (py-test-from-scheme
   (py< (py-sint-to-scheme x-1668) (py-bool-to-scheme-int y-1669))))

(define (py-lt-sintX-strY-fallback x-1670 y-1671)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<' not supported between instances of 'int' and 'str'"))))

(define (py-test-lt-sintX-strY-fallback x-1672 y-1673)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<' not supported between instances of 'int' and 'str'"))))

(define (py-lt-sintX-sintY-fallback x-1674 y-1675)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-sint-to-scheme x-1674) (py-sint-to-scheme y-1675)))))

(define (py-test-lt-sintX-sintY-fallback x-1676 y-1677)
  (py-test-from-scheme
   (py< (py-sint-to-scheme x-1676) (py-sint-to-scheme y-1677))))

(define (py-lt-sintX-bintY-fallback x-1678 y-1679)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-sint-to-scheme x-1678) (py-bint-to-scheme y-1679)))))

(define (py-test-lt-sintX-bintY-fallback x-1680 y-1681)
  (py-test-from-scheme
   (py< (py-sint-to-scheme x-1680) (py-bint-to-scheme y-1681))))

(define (py-lt-bintX-floatY-fallback x-1682 y-1683)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py> (py-float-to-scheme y-1683) (py-bint-to-scheme x-1682)))))

(define (py-test-lt-bintX-floatY-fallback x-1684 y-1685)
  (py-test-from-scheme
   (py> (py-float-to-scheme y-1685) (py-bint-to-scheme x-1684))))

(define (py-lt-bintX-boolY-fallback x-1686 y-1687)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-bint-to-scheme x-1686) (py-bool-to-scheme-int y-1687)))))

(define (py-test-lt-bintX-boolY-fallback x-1688 y-1689)
  (py-test-from-scheme
   (py< (py-bint-to-scheme x-1688) (py-bool-to-scheme-int y-1689))))

(define (py-lt-bintX-strY-fallback x-1690 y-1691)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<' not supported between instances of 'int' and 'str'"))))

(define (py-test-lt-bintX-strY-fallback x-1692 y-1693)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "'<' not supported between instances of 'int' and 'str'"))))

(define (py-lt-bintX-sintY-fallback x-1694 y-1695)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-bint-to-scheme x-1694) (py-sint-to-scheme y-1695)))))

(define (py-test-lt-bintX-sintY-fallback x-1696 y-1697)
  (py-test-from-scheme
   (py< (py-bint-to-scheme x-1696) (py-sint-to-scheme y-1697))))

(define (py-lt-bintX-bintY-fallback x-1698 y-1699)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py< (py-bint-to-scheme x-1698) (py-bint-to-scheme y-1699)))))

(define (py-test-lt-bintX-bintY-fallback x-1700 y-1701)
  (py-test-from-scheme
   (py< (py-bint-to-scheme x-1700) (py-bint-to-scheme y-1701))))

(define (py-eq-floatX-floatY-fallback x-1702 y-1703)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-float-to-scheme x-1702) (py-float-to-scheme y-1703)))))

(define (py-test-eq-floatX-floatY-fallback x-1704 y-1705)
  (py-test-from-scheme
   (py== (py-float-to-scheme x-1704) (py-float-to-scheme y-1705))))

(define (py-eq-floatX-boolY-fallback x-1706 y-1707)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-float-to-scheme x-1706) (py-bool-to-scheme-int y-1707)))))

(define (py-test-eq-floatX-boolY-fallback x-1708 y-1709)
  (py-test-from-scheme
   (py== (py-float-to-scheme x-1708) (py-bool-to-scheme-int y-1709))))

(define (py-eq-floatX-strY-fallback x-1710 y-1711) py-False)

(define (py-test-eq-floatX-strY-fallback x-1712 y-1713)
  (py-bool-to-scheme-bool py-False))

(define (py-eq-floatX-sintY-fallback x-1714 y-1715)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-float-to-scheme x-1714) (py-sint-to-scheme y-1715)))))

(define (py-test-eq-floatX-sintY-fallback x-1716 y-1717)
  (py-test-from-scheme
   (py== (py-float-to-scheme x-1716) (py-sint-to-scheme y-1717))))

(define (py-eq-floatX-bintY-fallback x-1718 y-1719)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-float-to-scheme x-1718) (py-bint-to-scheme y-1719)))))

(define (py-test-eq-floatX-bintY-fallback x-1720 y-1721)
  (py-test-from-scheme
   (py== (py-float-to-scheme x-1720) (py-bint-to-scheme y-1721))))

(define (py-eq-boolX-floatY-fallback x-1722 y-1723)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-float-to-scheme y-1723) (py-bool-to-scheme-int x-1722)))))

(define (py-test-eq-boolX-floatY-fallback x-1724 y-1725)
  (py-test-from-scheme
   (py== (py-float-to-scheme y-1725) (py-bool-to-scheme-int x-1724))))

(define (py-eq-boolX-boolY-fallback x-1726 y-1727)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-bool-to-scheme-int x-1726) (py-bool-to-scheme-int y-1727)))))

(define (py-test-eq-boolX-boolY-fallback x-1728 y-1729)
  (py-test-from-scheme
   (py== (py-bool-to-scheme-int x-1728) (py-bool-to-scheme-int y-1729))))

(define (py-eq-boolX-strY-fallback x-1730 y-1731) py-False)

(define (py-test-eq-boolX-strY-fallback x-1732 y-1733)
  (py-bool-to-scheme-bool py-False))

(define (py-eq-boolX-sintY-fallback x-1734 y-1735)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-bool-to-scheme-int x-1734) (py-sint-to-scheme y-1735)))))

(define (py-test-eq-boolX-sintY-fallback x-1736 y-1737)
  (py-test-from-scheme
   (py== (py-bool-to-scheme-int x-1736) (py-sint-to-scheme y-1737))))

(define (py-eq-boolX-bintY-fallback x-1738 y-1739)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-bool-to-scheme-int x-1738) (py-bint-to-scheme y-1739)))))

(define (py-test-eq-boolX-bintY-fallback x-1740 y-1741)
  (py-test-from-scheme
   (py== (py-bool-to-scheme-int x-1740) (py-bint-to-scheme y-1741))))

(define (py-eq-strX-floatY-fallback x-1742 y-1743) py-False)

(define (py-test-eq-strX-floatY-fallback x-1744 y-1745)
  (py-bool-to-scheme-bool py-False))

(define (py-eq-strX-boolY-fallback x-1746 y-1747) py-False)

(define (py-test-eq-strX-boolY-fallback x-1748 y-1749)
  (py-bool-to-scheme-bool py-False))

(define (py-eq-strX-strY-fallback x-1750 y-1751)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-str-to-scheme x-1750) (py-str-to-scheme y-1751)))))

(define (py-test-eq-strX-strY-fallback x-1752 y-1753)
  (py-test-from-scheme
   (py== (py-str-to-scheme x-1752) (py-str-to-scheme y-1753))))

(define (py-eq-strX-sintY-fallback x-1754 y-1755) py-False)

(define (py-test-eq-strX-sintY-fallback x-1756 y-1757)
  (py-bool-to-scheme-bool py-False))

(define (py-eq-strX-bintY-fallback x-1758 y-1759) py-False)

(define (py-test-eq-strX-bintY-fallback x-1760 y-1761)
  (py-bool-to-scheme-bool py-False))

(define (py-eq-sintX-floatY-fallback x-1762 y-1763)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-float-to-scheme y-1763) (py-sint-to-scheme x-1762)))))

(define (py-test-eq-sintX-floatY-fallback x-1764 y-1765)
  (py-test-from-scheme
   (py== (py-float-to-scheme y-1765) (py-sint-to-scheme x-1764))))

(define (py-eq-sintX-boolY-fallback x-1766 y-1767)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-sint-to-scheme x-1766) (py-bool-to-scheme-int y-1767)))))

(define (py-test-eq-sintX-boolY-fallback x-1768 y-1769)
  (py-test-from-scheme
   (py== (py-sint-to-scheme x-1768) (py-bool-to-scheme-int y-1769))))

(define (py-eq-sintX-strY-fallback x-1770 y-1771) py-False)

(define (py-test-eq-sintX-strY-fallback x-1772 y-1773)
  (py-bool-to-scheme-bool py-False))

(define (py-eq-sintX-sintY-fallback x-1774 y-1775)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-sint-to-scheme x-1774) (py-sint-to-scheme y-1775)))))

(define (py-test-eq-sintX-sintY-fallback x-1776 y-1777)
  (py-test-from-scheme
   (py== (py-sint-to-scheme x-1776) (py-sint-to-scheme y-1777))))

(define (py-eq-sintX-bintY-fallback x-1778 y-1779)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-sint-to-scheme x-1778) (py-bint-to-scheme y-1779)))))

(define (py-test-eq-sintX-bintY-fallback x-1780 y-1781)
  (py-test-from-scheme
   (py== (py-sint-to-scheme x-1780) (py-bint-to-scheme y-1781))))

(define (py-eq-bintX-floatY-fallback x-1782 y-1783)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-float-to-scheme y-1783) (py-bint-to-scheme x-1782)))))

(define (py-test-eq-bintX-floatY-fallback x-1784 y-1785)
  (py-test-from-scheme
   (py== (py-float-to-scheme y-1785) (py-bint-to-scheme x-1784))))

(define (py-eq-bintX-boolY-fallback x-1786 y-1787)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-bint-to-scheme x-1786) (py-bool-to-scheme-int y-1787)))))

(define (py-test-eq-bintX-boolY-fallback x-1788 y-1789)
  (py-test-from-scheme
   (py== (py-bint-to-scheme x-1788) (py-bool-to-scheme-int y-1789))))

(define (py-eq-bintX-strY-fallback x-1790 y-1791) py-False)

(define (py-test-eq-bintX-strY-fallback x-1792 y-1793)
  (py-bool-to-scheme-bool py-False))

(define (py-eq-bintX-sintY-fallback x-1794 y-1795)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-bint-to-scheme x-1794) (py-sint-to-scheme y-1795)))))

(define (py-test-eq-bintX-sintY-fallback x-1796 y-1797)
  (py-test-from-scheme
   (py== (py-bint-to-scheme x-1796) (py-sint-to-scheme y-1797))))

(define (py-eq-bintX-bintY-fallback x-1798 y-1799)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py== (py-bint-to-scheme x-1798) (py-bint-to-scheme y-1799)))))

(define (py-test-eq-bintX-bintY-fallback x-1800 y-1801)
  (py-test-from-scheme
   (py== (py-bint-to-scheme x-1800) (py-bint-to-scheme y-1801))))

(define (py-ne-floatX-floatY-fallback x-1802 y-1803)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-float-to-scheme x-1802) (py-float-to-scheme y-1803)))))

(define (py-test-ne-floatX-floatY-fallback x-1804 y-1805)
  (py-test-from-scheme
   (py!= (py-float-to-scheme x-1804) (py-float-to-scheme y-1805))))

(define (py-ne-floatX-boolY-fallback x-1806 y-1807)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-float-to-scheme x-1806) (py-bool-to-scheme-int y-1807)))))

(define (py-test-ne-floatX-boolY-fallback x-1808 y-1809)
  (py-test-from-scheme
   (py!= (py-float-to-scheme x-1808) (py-bool-to-scheme-int y-1809))))

(define (py-ne-floatX-strY-fallback x-1810 y-1811) py-True)

(define (py-test-ne-floatX-strY-fallback x-1812 y-1813)
  (py-bool-to-scheme-bool py-True))

(define (py-ne-floatX-sintY-fallback x-1814 y-1815)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-float-to-scheme x-1814) (py-sint-to-scheme y-1815)))))

(define (py-test-ne-floatX-sintY-fallback x-1816 y-1817)
  (py-test-from-scheme
   (py!= (py-float-to-scheme x-1816) (py-sint-to-scheme y-1817))))

(define (py-ne-floatX-bintY-fallback x-1818 y-1819)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-float-to-scheme x-1818) (py-bint-to-scheme y-1819)))))

(define (py-test-ne-floatX-bintY-fallback x-1820 y-1821)
  (py-test-from-scheme
   (py!= (py-float-to-scheme x-1820) (py-bint-to-scheme y-1821))))

(define (py-ne-boolX-floatY-fallback x-1822 y-1823)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-float-to-scheme y-1823) (py-bool-to-scheme-int x-1822)))))

(define (py-test-ne-boolX-floatY-fallback x-1824 y-1825)
  (py-test-from-scheme
   (py!= (py-float-to-scheme y-1825) (py-bool-to-scheme-int x-1824))))

(define (py-ne-boolX-boolY-fallback x-1826 y-1827)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-bool-to-scheme-int x-1826) (py-bool-to-scheme-int y-1827)))))

(define (py-test-ne-boolX-boolY-fallback x-1828 y-1829)
  (py-test-from-scheme
   (py!= (py-bool-to-scheme-int x-1828) (py-bool-to-scheme-int y-1829))))

(define (py-ne-boolX-strY-fallback x-1830 y-1831) py-True)

(define (py-test-ne-boolX-strY-fallback x-1832 y-1833)
  (py-bool-to-scheme-bool py-True))

(define (py-ne-boolX-sintY-fallback x-1834 y-1835)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-bool-to-scheme-int x-1834) (py-sint-to-scheme y-1835)))))

(define (py-test-ne-boolX-sintY-fallback x-1836 y-1837)
  (py-test-from-scheme
   (py!= (py-bool-to-scheme-int x-1836) (py-sint-to-scheme y-1837))))

(define (py-ne-boolX-bintY-fallback x-1838 y-1839)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-bool-to-scheme-int x-1838) (py-bint-to-scheme y-1839)))))

(define (py-test-ne-boolX-bintY-fallback x-1840 y-1841)
  (py-test-from-scheme
   (py!= (py-bool-to-scheme-int x-1840) (py-bint-to-scheme y-1841))))

(define (py-ne-strX-floatY-fallback x-1842 y-1843) py-True)

(define (py-test-ne-strX-floatY-fallback x-1844 y-1845)
  (py-bool-to-scheme-bool py-True))

(define (py-ne-strX-boolY-fallback x-1846 y-1847) py-True)

(define (py-test-ne-strX-boolY-fallback x-1848 y-1849)
  (py-bool-to-scheme-bool py-True))

(define (py-ne-strX-strY-fallback x-1850 y-1851)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-str-to-scheme x-1850) (py-str-to-scheme y-1851)))))

(define (py-test-ne-strX-strY-fallback x-1852 y-1853)
  (py-test-from-scheme
   (py!= (py-str-to-scheme x-1852) (py-str-to-scheme y-1853))))

(define (py-ne-strX-sintY-fallback x-1854 y-1855) py-True)

(define (py-test-ne-strX-sintY-fallback x-1856 y-1857)
  (py-bool-to-scheme-bool py-True))

(define (py-ne-strX-bintY-fallback x-1858 y-1859) py-True)

(define (py-test-ne-strX-bintY-fallback x-1860 y-1861)
  (py-bool-to-scheme-bool py-True))

(define (py-ne-sintX-floatY-fallback x-1862 y-1863)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-float-to-scheme y-1863) (py-sint-to-scheme x-1862)))))

(define (py-test-ne-sintX-floatY-fallback x-1864 y-1865)
  (py-test-from-scheme
   (py!= (py-float-to-scheme y-1865) (py-sint-to-scheme x-1864))))

(define (py-ne-sintX-boolY-fallback x-1866 y-1867)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-sint-to-scheme x-1866) (py-bool-to-scheme-int y-1867)))))

(define (py-test-ne-sintX-boolY-fallback x-1868 y-1869)
  (py-test-from-scheme
   (py!= (py-sint-to-scheme x-1868) (py-bool-to-scheme-int y-1869))))

(define (py-ne-sintX-strY-fallback x-1870 y-1871) py-True)

(define (py-test-ne-sintX-strY-fallback x-1872 y-1873)
  (py-bool-to-scheme-bool py-True))

(define (py-ne-sintX-sintY-fallback x-1874 y-1875)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-sint-to-scheme x-1874) (py-sint-to-scheme y-1875)))))

(define (py-test-ne-sintX-sintY-fallback x-1876 y-1877)
  (py-test-from-scheme
   (py!= (py-sint-to-scheme x-1876) (py-sint-to-scheme y-1877))))

(define (py-ne-sintX-bintY-fallback x-1878 y-1879)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-sint-to-scheme x-1878) (py-bint-to-scheme y-1879)))))

(define (py-test-ne-sintX-bintY-fallback x-1880 y-1881)
  (py-test-from-scheme
   (py!= (py-sint-to-scheme x-1880) (py-bint-to-scheme y-1881))))

(define (py-ne-bintX-floatY-fallback x-1882 y-1883)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-float-to-scheme y-1883) (py-bint-to-scheme x-1882)))))

(define (py-test-ne-bintX-floatY-fallback x-1884 y-1885)
  (py-test-from-scheme
   (py!= (py-float-to-scheme y-1885) (py-bint-to-scheme x-1884))))

(define (py-ne-bintX-boolY-fallback x-1886 y-1887)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-bint-to-scheme x-1886) (py-bool-to-scheme-int y-1887)))))

(define (py-test-ne-bintX-boolY-fallback x-1888 y-1889)
  (py-test-from-scheme
   (py!= (py-bint-to-scheme x-1888) (py-bool-to-scheme-int y-1889))))

(define (py-ne-bintX-strY-fallback x-1890 y-1891) py-True)

(define (py-test-ne-bintX-strY-fallback x-1892 y-1893)
  (py-bool-to-scheme-bool py-True))

(define (py-ne-bintX-sintY-fallback x-1894 y-1895)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-bint-to-scheme x-1894) (py-sint-to-scheme y-1895)))))

(define (py-test-ne-bintX-sintY-fallback x-1896 y-1897)
  (py-test-from-scheme
   (py!= (py-bint-to-scheme x-1896) (py-sint-to-scheme y-1897))))

(define (py-ne-bintX-bintY-fallback x-1898 y-1899)
  (py-bool-from-scheme-bool
   (py-test-from-scheme
    (py!= (py-bint-to-scheme x-1898) (py-bint-to-scheme y-1899)))))

(define (py-test-ne-bintX-bintY-fallback x-1900 y-1901)
  (py-test-from-scheme
   (py!= (py-bint-to-scheme x-1900) (py-bint-to-scheme y-1901))))

(define (py-pos-floatX-fallback x-1902) x-1902)

(define (py-pos-boolX-fallback x-1903)
  (py-int-from-scheme (py-bool-to-scheme-int x-1903)))

(define (py-pos-strX-fallback x-1904)
  (py-throw
   (py-call py-builtin-TypeError (&& "bad operand type for unary +: 'str'"))))

(define (py-pos-sintX-fallback x-1905)
  (py-int-from-scheme (py-sint-to-scheme x-1905)))

(define (py-pos-bintX-fallback x-1906)
  (py-int-from-scheme (py-bint-to-scheme x-1906)))

(define (py-neg-floatX-fallback x-1907)
  (py-float-from-scheme (pyneg (py-float-to-scheme x-1907))))

(define (py-neg-boolX-fallback x-1908)
  (py-int-from-scheme (pyneg (py-bool-to-scheme-int x-1908))))

(define (py-neg-strX-fallback x-1909)
  (py-throw
   (py-call py-builtin-TypeError (&& "bad operand type for unary -: 'str'"))))

(define (py-neg-sintX-fallback x-1910)
  (py-int-from-scheme (pyneg (py-sint-to-scheme x-1910))))

(define (py-neg-bintX-fallback x-1911)
  (py-int-from-scheme (pyneg (py-bint-to-scheme x-1911))))

(define (py-invert-floatX-fallback x-1912)
  (py-throw
   (py-call py-builtin-TypeError
            (&& "bad operand type for unary ~: 'float'"))))

(define (py-invert-boolX-fallback x-1913)
  (py-int-from-scheme (pyinvert (py-bool-to-scheme-int x-1913))))

(define (py-invert-strX-fallback x-1914)
  (py-throw
   (py-call py-builtin-TypeError (&& "bad operand type for unary ~: 'str'"))))

(define (py-invert-sintX-fallback x-1915)
  (py-int-from-scheme (pyinvert (py-sint-to-scheme x-1915))))

(define (py-invert-bintX-fallback x-1916)
  (py-int-from-scheme (pyinvert (py-bint-to-scheme x-1916))))

(define (py-truth-floatX-fallback obj-1917)
  (py-bool-from-scheme-bool
   (py-test-from-scheme (py!= (py-float-to-scheme obj-1917) 0.))))

(define (py-truth-boolX-fallback obj-1918) obj-1918)

(define (py-truth-strX-fallback obj-1919)
  (py-bool-from-scheme-bool
   (py-test-from-scheme (py!= (py-str-len-to-scheme obj-1919) 0))))

(define (py-truth-sintX-fallback obj-1920)
  (py-bool-from-scheme-bool
   (py-test-from-scheme (py!= (py-sint-to-scheme obj-1920) 0))))

(define (py-truth-bintX-fallback obj-1921) py-True)

(define (py-test-floatX-fallback obj-1922)
  (py-test-from-scheme (py!= (py-float-to-scheme obj-1922) 0.)))

(define (py-test-boolX-fallback obj-1923) (py-bool-to-scheme-bool obj-1923))

(define (py-test-strX-fallback obj-1924)
  (py-test-from-scheme (py!= (py-str-len-to-scheme obj-1924) 0)))

(define (py-test-sintX-fallback obj-1925)
  (py-test-from-scheme (py!= (py-sint-to-scheme obj-1925) 0)))

(define (py-test-bintX-fallback obj-1926) (py-bool-to-scheme-bool py-True))

