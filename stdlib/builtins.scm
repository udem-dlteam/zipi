(##import bigloo)
(##include "/home/olivier/udem-dlteam/zipi/etc/../rts/hclass.bgl")
(##include "/home/olivier/udem-dlteam/zipi/etc/../rts/hclass.scm")
(##include "/home/olivier/udem-dlteam/zipi/etc/../rts/object.bgl")
(##include "/home/olivier/udem-dlteam/zipi/etc/../rts/object.scm")
(##include "/home/olivier/udem-dlteam/zipi/etc/../rts/iterator.bgl")
(##include "/home/olivier/udem-dlteam/zipi/etc/../rts/iterator.scm")
(##include "/home/olivier/udem-dlteam/zipi/etc/../rts/import.bgl")
(##include "/home/olivier/udem-dlteam/zipi/etc/../rts/import.scm")
(define py-module
  (lambda (%global %caches)
    (set! py-import-root "../")
    (global-put!
     %global
     (& "__name__")
     (py-str-from-scheme "builtins")
     (vector-ref %caches 0))
    (global-put!
     %global
     (& "__file__")
     (py-str-from-scheme "./builtins.py")
     (vector-ref %caches 1))
    (global-put!
     %global
     (& "__import__")
     (global-get %global (& "__base___import__") (vector-ref %caches 2))
     (vector-ref %caches 3))
    (global-put!
     %global
     (& "abs")
     (global-get %global (& "__base_abs") (vector-ref %caches 4))
     (vector-ref %caches 5))
    (global-put!
     %global
     (& "all")
     (global-get %global (& "__base_all") (vector-ref %caches 6))
     (vector-ref %caches 7))
    (global-put!
     %global
     (& "any")
     (global-get %global (& "__base_any") (vector-ref %caches 8))
     (vector-ref %caches 9))
    (global-put!
     %global
     (& "ascii")
     (global-get %global (& "__base_ascii") (vector-ref %caches 10))
     (vector-ref %caches 11))
    (global-put!
     %global
     (& "bin")
     (global-get %global (& "__base_bin") (vector-ref %caches 12))
     (vector-ref %caches 13))
    (global-put!
     %global
     (& "bool")
     (global-get %global (& "__base_bool") (vector-ref %caches 14))
     (vector-ref %caches 15))
    (global-put!
     %global
     (& "breakpoint")
     (global-get %global (& "__base_breakpoint") (vector-ref %caches 16))
     (vector-ref %caches 17))
    (global-put!
     %global
     (& "bytearray")
     (global-get %global (& "__base_bytearray") (vector-ref %caches 18))
     (vector-ref %caches 19))
    (global-put!
     %global
     (& "bytes")
     (global-get %global (& "__base_bytes") (vector-ref %caches 20))
     (vector-ref %caches 21))
    (global-put!
     %global
     (& "callable")
     (global-get %global (& "__base_callable") (vector-ref %caches 22))
     (vector-ref %caches 23))
    (global-put!
     %global
     (& "chr")
     (global-get %global (& "__base_chr") (vector-ref %caches 24))
     (vector-ref %caches 25))
    (global-put!
     %global
     (& "classmethod")
     (global-get %global (& "__base_classmethod") (vector-ref %caches 26))
     (vector-ref %caches 27))
    (global-put!
     %global
     (& "compile")
     (global-get %global (& "__base_compile") (vector-ref %caches 28))
     (vector-ref %caches 29))
    (global-put!
     %global
     (& "complex")
     (global-get %global (& "__base_complex") (vector-ref %caches 30))
     (vector-ref %caches 31))
    (global-put!
     %global
     (& "delattr")
     (global-get %global (& "__base_delattr") (vector-ref %caches 32))
     (vector-ref %caches 33))
    (global-put!
     %global
     (& "dict")
     (global-get %global (& "__base_dict") (vector-ref %caches 34))
     (vector-ref %caches 35))
    (global-put!
     %global
     (& "dir")
     (global-get %global (& "__base_dir") (vector-ref %caches 36))
     (vector-ref %caches 37))
    (global-put!
     %global
     (& "divmod")
     (global-get %global (& "__base_divmod") (vector-ref %caches 38))
     (vector-ref %caches 39))
    (global-put!
     %global
     (& "enumerate")
     (global-get %global (& "__base_enumerate") (vector-ref %caches 40))
     (vector-ref %caches 41))
    (global-put!
     %global
     (& "eval")
     (global-get %global (& "__base_eval") (vector-ref %caches 42))
     (vector-ref %caches 43))
    (global-put!
     %global
     (& "exec")
     (global-get %global (& "__base_exec") (vector-ref %caches 44))
     (vector-ref %caches 45))
    (global-put!
     %global
     (& "filter")
     (global-get %global (& "__base_filter") (vector-ref %caches 46))
     (vector-ref %caches 47))
    (global-put!
     %global
     (& "float")
     (global-get %global (& "__base_float") (vector-ref %caches 48))
     (vector-ref %caches 49))
    (global-put!
     %global
     (& "format")
     (global-get %global (& "__base_format") (vector-ref %caches 50))
     (vector-ref %caches 51))
    (global-put!
     %global
     (& "frozenset")
     (global-get %global (& "__base_frozenset") (vector-ref %caches 52))
     (vector-ref %caches 53))
    (global-put!
     %global
     (& "getattr")
     (global-get %global (& "__base_getattr") (vector-ref %caches 54))
     (vector-ref %caches 55))
    (global-put!
     %global
     (& "globals")
     (global-get %global (& "__base_globals") (vector-ref %caches 56))
     (vector-ref %caches 57))
    (global-put!
     %global
     (& "hasattr")
     (global-get %global (& "__base_hasattr") (vector-ref %caches 58))
     (vector-ref %caches 59))
    (global-put!
     %global
     (& "hash")
     (global-get %global (& "__base_hash") (vector-ref %caches 60))
     (vector-ref %caches 61))
    (global-put!
     %global
     (& "help")
     (global-get %global (& "__base_help") (vector-ref %caches 62))
     (vector-ref %caches 63))
    (global-put!
     %global
     (& "hex")
     (global-get %global (& "__base_hex") (vector-ref %caches 64))
     (vector-ref %caches 65))
    (global-put!
     %global
     (& "id")
     (global-get %global (& "__base_id") (vector-ref %caches 66))
     (vector-ref %caches 67))
    (global-put!
     %global
     (& "input")
     (global-get %global (& "__base_input") (vector-ref %caches 68))
     (vector-ref %caches 69))
    (global-put!
     %global
     (& "int")
     (global-get %global (& "__base_int") (vector-ref %caches 70))
     (vector-ref %caches 71))
    (global-put!
     %global
     (& "isinstance")
     (global-get %global (& "__base_isinstance") (vector-ref %caches 72))
     (vector-ref %caches 73))
    (global-put!
     %global
     (& "issubclass")
     (global-get %global (& "__base_issubclass") (vector-ref %caches 74))
     (vector-ref %caches 75))
    (global-put!
     %global
     (& "iter")
     (global-get %global (& "__base_iter") (vector-ref %caches 76))
     (vector-ref %caches 77))
    (global-put!
     %global
     (& "len")
     (global-get %global (& "__base_len") (vector-ref %caches 78))
     (vector-ref %caches 79))
    (global-put!
     %global
     (& "list")
     (global-get %global (& "__base_list") (vector-ref %caches 80))
     (vector-ref %caches 81))
    (global-put!
     %global
     (& "locals")
     (global-get %global (& "__base_locals") (vector-ref %caches 82))
     (vector-ref %caches 83))
    (global-put!
     %global
     (& "map")
     (global-get %global (& "__base_map") (vector-ref %caches 84))
     (vector-ref %caches 85))
    (global-put!
     %global
     (& "max")
     (global-get %global (& "__base_max") (vector-ref %caches 86))
     (vector-ref %caches 87))
    (global-put!
     %global
     (& "memoryview")
     (global-get %global (& "__base_memoryview") (vector-ref %caches 88))
     (vector-ref %caches 89))
    (global-put!
     %global
     (& "min")
     (global-get %global (& "__base_min") (vector-ref %caches 90))
     (vector-ref %caches 91))
    (global-put!
     %global
     (& "next")
     (global-get %global (& "__base_next") (vector-ref %caches 92))
     (vector-ref %caches 93))
    (global-put!
     %global
     (& "object")
     (global-get %global (& "__base_object") (vector-ref %caches 94))
     (vector-ref %caches 95))
    (global-put!
     %global
     (& "oct")
     (global-get %global (& "__base_oct") (vector-ref %caches 96))
     (vector-ref %caches 97))
    (global-put!
     %global
     (& "open")
     (global-get %global (& "__base_open") (vector-ref %caches 98))
     (vector-ref %caches 99))
    (global-put!
     %global
     (& "ord")
     (global-get %global (& "__base_ord") (vector-ref %caches 100))
     (vector-ref %caches 101))
    (global-put!
     %global
     (& "pow")
     (global-get %global (& "__base_pow") (vector-ref %caches 102))
     (vector-ref %caches 103))
    (global-put!
     %global
     (& "print")
     (global-get %global (& "__base_print") (vector-ref %caches 104))
     (vector-ref %caches 105))
    (global-put!
     %global
     (& "property")
     (global-get %global (& "__base_property") (vector-ref %caches 106))
     (vector-ref %caches 107))
    (global-put!
     %global
     (& "range_iterator")
     (let (($%cls_0 (py-uninit)))
       (letrec* ((start165 (py-uninit))
                 (stop166 (py-uninit))
                 (step167 (py-uninit))
                 (__init__168 (py-uninit))
                 (__iter__169 (py-uninit))
                 (__next__170 (py-uninit)))
         (begin
           (set! __init__168
                 (procedure->py-function
                  (lambda (self3 start4 stop5 step6)
                    (begin
                      (object-put!
                       self3
                       (& "start")
                       start4
                       (vector-ref %caches 108))
                      (object-put!
                       self3
                       (& "stop")
                       stop5
                       (vector-ref %caches 109))
                      (object-put!
                       self3
                       (& "step")
                       step6
                       (vector-ref %caches 110))))
                  (vector #(self start stop step)
                          #()
                          #f
                          #()
                          (vector)
                          #f
                          (vector))))
           (set! __iter__169
                 (procedure->py-function
                  (lambda (self8) (begin self8))
                  (vector #(self) #() #f #() (vector) #f (vector))))
           (set! __next__170
                 (procedure->py-function
                  (lambda (self10)
                    (bind-exit
                     (return)
                     (begin
                       (set! start165
                             (object-get
                              self10
                              (& "start")
                              (vector-ref %caches 111)))
                       (set! stop166
                             (object-get
                              self10
                              (& "stop")
                              (vector-ref %caches 112)))
                       (set! step167
                             (object-get
                              self10
                              (& "step")
                              (vector-ref %caches 113)))
                       (if (py-test (py-lt step167
                                           (py-int-from-scheme 0)
                                           (vector-ref %caches 114)))
                           (begin
                             (if (py-test (py-gt start165
                                                 stop166
                                                 (vector-ref %caches 115)))
                                 (begin
                                   (object-put!
                                    self10
                                    (& "start")
                                    (py-add start165
                                            step167
                                            (vector-ref %caches 117))
                                    (vector-ref %caches 116))
                                   (return start165))
                                 #f))
                           (begin
                             (if (py-test (py-lt start165
                                                 stop166
                                                 (vector-ref %caches 118)))
                                 (begin
                                   (object-put!
                                    self10
                                    (& "start")
                                    (py-add start165
                                            step167
                                            (vector-ref %caches 120))
                                    (vector-ref %caches 119))
                                   (return start165))
                                 #f)))
                       (py-throw
                        (global-get
                         %global
                         (& "StopIteration")
                         (vector-ref %caches 121))))))
                  (vector #(self) #() #f #() (vector) #f (vector)))))
         (begin
           (set! $%cls_0
                 (py-make-class
                  (& "range_iterator")
                  (& "__main__")
                  (list)
                  (& "start")
                  start165
                  (& "stop")
                  stop166
                  (& "step")
                  step167
                  (& "__init__")
                  __init__168
                  (& "__iter__")
                  __iter__169
                  (& "__next__")
                  __next__170))
           $%cls_0)))
     (vector-ref %caches 122))
    (global-put!
     %global
     (& "range")
     (let (($%cls_1 (py-uninit)))
       (letrec* ((start174 (py-uninit))
                 (stop175 (py-uninit))
                 (step176 (py-uninit))
                 (__init__177 (py-uninit))
                 (__len__178 (py-uninit))
                 (__contains__179 (py-uninit))
                 (__iter__180 (py-uninit)))
         (begin
           (set! __init__177
                 (procedure->py-function
                  (lambda (self12 arg113 arg214 arg315)
                    (begin
                      (if (py-test (py-isnot
                                    arg315
                                    (global-get
                                     %global
                                     (& "_absent")
                                     (vector-ref %caches 125))
                                    (vector-ref %caches 126)))
                          (begin
                            (object-put!
                             self12
                             (& "start")
                             arg113
                             (vector-ref %caches 127))
                            (object-put!
                             self12
                             (& "stop")
                             arg214
                             (vector-ref %caches 128))
                            (object-put!
                             self12
                             (& "step")
                             arg315
                             (vector-ref %caches 129)))
                          (begin
                            (if (py-test (py-isnot
                                          arg214
                                          (global-get
                                           %global
                                           (& "_absent")
                                           (vector-ref %caches 130))
                                          (vector-ref %caches 131)))
                                (begin
                                  (object-put!
                                   self12
                                   (& "start")
                                   arg113
                                   (vector-ref %caches 132))
                                  (object-put!
                                   self12
                                   (& "stop")
                                   arg214
                                   (vector-ref %caches 133))
                                  (object-put!
                                   self12
                                   (& "step")
                                   (py-int-from-scheme 1)
                                   (vector-ref %caches 134)))
                                (begin
                                  (object-put!
                                   self12
                                   (& "start")
                                   (py-int-from-scheme 0)
                                   (vector-ref %caches 135))
                                  (object-put!
                                   self12
                                   (& "stop")
                                   arg113
                                   (vector-ref %caches 136))
                                  (object-put!
                                   self12
                                   (& "step")
                                   (py-int-from-scheme 1)
                                   (vector-ref %caches 137))))))))
                  (vector #()
                          #(self arg1 arg2 arg3)
                          #f
                          #()
                          (vector)
                          #f
                          (vector (global-get
                                   %global
                                   (& "_absent")
                                   (vector-ref %caches 123))
                                  (global-get
                                   %global
                                   (& "_absent")
                                   (vector-ref %caches 124))))))
           (set! __len__178
                 (procedure->py-function
                  (lambda (self17)
                    (begin
                      (py-floordiv
                       (py-sub (object-get
                                self17
                                (& "stop")
                                (vector-ref %caches 138))
                               (object-get
                                self17
                                (& "start")
                                (vector-ref %caches 139))
                               (vector-ref %caches 140))
                       (object-get self17 (& "step") (vector-ref %caches 141))
                       (vector-ref %caches 142))))
                  (vector #(self) #() #f #() (vector) #f (vector))))
           (set! __contains__179
                 (procedure->py-function
                  (lambda (self19 item20)
                    (bind-exit
                     (return)
                     (begin
                       (set! start174
                             (object-get
                              self19
                              (& "start")
                              (vector-ref %caches 143)))
                       (set! stop175
                             (object-get
                              self19
                              (& "stop")
                              (vector-ref %caches 144)))
                       (set! step176
                             (object-get
                              self19
                              (& "step")
                              (vector-ref %caches 145)))
                       (if (py-test (py-lt (object-get
                                            self19
                                            (& "step")
                                            (vector-ref %caches 146))
                                           (py-int-from-scheme 0)
                                           (vector-ref %caches 147)))
                           (begin
                             (if (py-test (py-not (py-lt stop175
                                                         item20
                                                         (vector-ref
                                                          %caches
                                                          148))
                                                  (vector-ref %caches 149)))
                                 (begin
                                   (if (py-test (py-not (py-le item20
                                                               start174
                                                               (vector-ref
                                                                %caches
                                                                150))
                                                        (vector-ref
                                                         %caches
                                                         151)))
                                       (begin (return py-False))
                                       #f))
                                 #f))
                           (begin
                             (if (py-test (py-not (py-le start174
                                                         item20
                                                         (vector-ref
                                                          %caches
                                                          152))
                                                  (vector-ref %caches 153)))
                                 (begin
                                   (if (py-test (py-not (py-lt item20
                                                               stop175
                                                               (vector-ref
                                                                %caches
                                                                154))
                                                        (vector-ref
                                                         %caches
                                                         155)))
                                       (begin (return py-False))
                                       #f))
                                 #f)))
                       (py-eq (py-mod (py-sub item20
                                              start174
                                              (vector-ref %caches 156))
                                      step176
                                      (vector-ref %caches 157))
                              (py-int-from-scheme 0)
                              (vector-ref %caches 158)))))
                  (vector #(self item) #() #f #() (vector) #f (vector))))
           (set! __iter__180
                 (procedure->py-function
                  (lambda (self22)
                    (begin
                      (py-call3
                       (global-get
                        %global
                        (& "range_iterator")
                        (vector-ref %caches 159))
                       (object-get self22 (& "start") (vector-ref %caches 160))
                       (object-get self22 (& "stop") (vector-ref %caches 161))
                       (object-get
                        self22
                        (& "step")
                        (vector-ref %caches 162)))))
                  (vector #(self) #() #f #() (vector) #f (vector)))))
         (begin
           (set! $%cls_1
                 (py-make-class
                  (& "range")
                  (& "__main__")
                  (list)
                  (& "start")
                  start174
                  (& "stop")
                  stop175
                  (& "step")
                  step176
                  (& "__init__")
                  __init__177
                  (& "__len__")
                  __len__178
                  (& "__contains__")
                  __contains__179
                  (& "__iter__")
                  __iter__180))
           $%cls_1)))
     (vector-ref %caches 163))
    (global-put!
     %global
     (& "repr")
     (global-get %global (& "__base_repr") (vector-ref %caches 164))
     (vector-ref %caches 165))
    (global-put!
     %global
     (& "reversed")
     (global-get %global (& "__base_reversed") (vector-ref %caches 166))
     (vector-ref %caches 167))
    (global-put!
     %global
     (& "round")
     (global-get %global (& "__base_round") (vector-ref %caches 168))
     (vector-ref %caches 169))
    (global-put!
     %global
     (& "set")
     (global-get %global (& "__base_set") (vector-ref %caches 170))
     (vector-ref %caches 171))
    (global-put!
     %global
     (& "setattr")
     (global-get %global (& "__base_setattr") (vector-ref %caches 172))
     (vector-ref %caches 173))
    (global-put!
     %global
     (& "slice")
     (global-get %global (& "__base_slice") (vector-ref %caches 174))
     (vector-ref %caches 175))
    (global-put!
     %global
     (& "sorted")
     (global-get %global (& "__base_sorted") (vector-ref %caches 176))
     (vector-ref %caches 177))
    (global-put!
     %global
     (& "staticmethod")
     (global-get %global (& "__base_staticmethod") (vector-ref %caches 178))
     (vector-ref %caches 179))
    (global-put!
     %global
     (& "str")
     (global-get %global (& "__base_str") (vector-ref %caches 180))
     (vector-ref %caches 181))
    (global-put!
     %global
     (& "sum")
     (global-get %global (& "__base_sum") (vector-ref %caches 182))
     (vector-ref %caches 183))
    (global-put!
     %global
     (& "super")
     (global-get %global (& "__base_super") (vector-ref %caches 184))
     (vector-ref %caches 185))
    (global-put!
     %global
     (& "tuple")
     (global-get %global (& "__base_tuple") (vector-ref %caches 186))
     (vector-ref %caches 187))
    (global-put!
     %global
     (& "type")
     (global-get %global (& "__base_type") (vector-ref %caches 188))
     (vector-ref %caches 189))
    (global-put!
     %global
     (& "vars")
     (global-get %global (& "__base_vars") (vector-ref %caches 190))
     (vector-ref %caches 191))
    (global-put!
     %global
     (& "zip")
     (global-get %global (& "__base_zip") (vector-ref %caches 192))
     (vector-ref %caches 193))
    (global-put!
     %global
     (& "NotImplemented")
     (global-get %global (& "NotImplemented") (vector-ref %caches 194))
     (vector-ref %caches 195))
    (global-put!
     %global
     (& "BaseException")
     (global-get %global (& "BaseException") (vector-ref %caches 196))
     (vector-ref %caches 197))
    (global-put!
     %global
     (& "Exception")
     (let (($%cls_2 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_2
                 (py-make-class
                  (& "Exception")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "BaseException")
                         (vector-ref %caches 198)))))
           $%cls_2)))
     (vector-ref %caches 199))
    (global-put!
     %global
     (& "GeneratorExit")
     (let (($%cls_3 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_3
                 (py-make-class
                  (& "GeneratorExit")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "BaseException")
                         (vector-ref %caches 200)))))
           $%cls_3)))
     (vector-ref %caches 201))
    (global-put!
     %global
     (& "KeyboardInterrupt")
     (let (($%cls_4 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_4
                 (py-make-class
                  (& "KeyboardInterrupt")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "BaseException")
                         (vector-ref %caches 202)))))
           $%cls_4)))
     (vector-ref %caches 203))
    (global-put!
     %global
     (& "SystemExit")
     (let (($%cls_5 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_5
                 (py-make-class
                  (& "SystemExit")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "BaseException")
                         (vector-ref %caches 204)))))
           $%cls_5)))
     (vector-ref %caches 205))
    (global-put!
     %global
     (& "ArithmeticError")
     (let (($%cls_6 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_6
                 (py-make-class
                  (& "ArithmeticError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 206)))))
           $%cls_6)))
     (vector-ref %caches 207))
    (global-put!
     %global
     (& "AssertionError")
     (let (($%cls_7 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_7
                 (py-make-class
                  (& "AssertionError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 208)))))
           $%cls_7)))
     (vector-ref %caches 209))
    (global-put!
     %global
     (& "AttributeError")
     (let (($%cls_8 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_8
                 (py-make-class
                  (& "AttributeError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 210)))))
           $%cls_8)))
     (vector-ref %caches 211))
    (global-put!
     %global
     (& "BufferError")
     (let (($%cls_9 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_9
                 (py-make-class
                  (& "BufferError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 212)))))
           $%cls_9)))
     (vector-ref %caches 213))
    (global-put!
     %global
     (& "EOFError")
     (let (($%cls_10 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_10
                 (py-make-class
                  (& "EOFError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 214)))))
           $%cls_10)))
     (vector-ref %caches 215))
    (global-put!
     %global
     (& "ImportError")
     (let (($%cls_11 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_11
                 (py-make-class
                  (& "ImportError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 216)))))
           $%cls_11)))
     (vector-ref %caches 217))
    (global-put!
     %global
     (& "LookupError")
     (let (($%cls_12 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_12
                 (py-make-class
                  (& "LookupError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 218)))))
           $%cls_12)))
     (vector-ref %caches 219))
    (global-put!
     %global
     (& "MemoryError")
     (let (($%cls_13 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_13
                 (py-make-class
                  (& "MemoryError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 220)))))
           $%cls_13)))
     (vector-ref %caches 221))
    (global-put!
     %global
     (& "NameError")
     (let (($%cls_14 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_14
                 (py-make-class
                  (& "NameError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 222)))))
           $%cls_14)))
     (vector-ref %caches 223))
    (global-put!
     %global
     (& "EnvironmentError")
     (let (($%cls_15 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_15
                 (py-make-class
                  (& "EnvironmentError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 224)))))
           $%cls_15)))
     (vector-ref %caches 225))
    (global-put!
     %global
     (& "IOError")
     (let (($%cls_16 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_16
                 (py-make-class
                  (& "IOError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 226)))))
           $%cls_16)))
     (vector-ref %caches 227))
    (global-put!
     %global
     (& "OSError")
     (let (($%cls_17 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_17
                 (py-make-class
                  (& "OSError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 228)))))
           $%cls_17)))
     (vector-ref %caches 229))
    (global-put!
     %global
     (& "WindowsError")
     (let (($%cls_18 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_18
                 (py-make-class
                  (& "WindowsError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 230)))))
           $%cls_18)))
     (vector-ref %caches 231))
    (global-put!
     %global
     (& "ReferenceError")
     (let (($%cls_19 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_19
                 (py-make-class
                  (& "ReferenceError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 232)))))
           $%cls_19)))
     (vector-ref %caches 233))
    (global-put!
     %global
     (& "RuntimeError")
     (let (($%cls_20 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_20
                 (py-make-class
                  (& "RuntimeError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 234)))))
           $%cls_20)))
     (vector-ref %caches 235))
    (global-put!
     %global
     (& "StopAsyncIteration")
     (let (($%cls_21 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_21
                 (py-make-class
                  (& "StopAsyncIteration")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 236)))))
           $%cls_21)))
     (vector-ref %caches 237))
    (global-put!
     %global
     (& "StopIteration")
     (let (($%cls_22 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_22
                 (py-make-class
                  (& "StopIteration")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 238)))))
           $%cls_22)))
     (vector-ref %caches 239))
    (global-put!
     %global
     (& "SyntaxError")
     (let (($%cls_23 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_23
                 (py-make-class
                  (& "SyntaxError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 240)))))
           $%cls_23)))
     (vector-ref %caches 241))
    (global-put!
     %global
     (& "SystemError")
     (let (($%cls_24 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_24
                 (py-make-class
                  (& "SystemError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 242)))))
           $%cls_24)))
     (vector-ref %caches 243))
    (global-put!
     %global
     (& "TypeError")
     (let (($%cls_25 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_25
                 (py-make-class
                  (& "TypeError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 244)))))
           $%cls_25)))
     (vector-ref %caches 245))
    (global-put!
     %global
     (& "ValueError")
     (let (($%cls_26 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_26
                 (py-make-class
                  (& "ValueError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 246)))))
           $%cls_26)))
     (vector-ref %caches 247))
    (global-put!
     %global
     (& "Warning")
     (let (($%cls_27 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_27
                 (py-make-class
                  (& "Warning")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 248)))))
           $%cls_27)))
     (vector-ref %caches 249))
    (global-put!
     %global
     (& "FloatingPointError")
     (let (($%cls_28 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_28
                 (py-make-class
                  (& "FloatingPointError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "ArithmeticError")
                         (vector-ref %caches 250)))))
           $%cls_28)))
     (vector-ref %caches 251))
    (global-put!
     %global
     (& "OverflowError")
     (let (($%cls_29 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_29
                 (py-make-class
                  (& "OverflowError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "ArithmeticError")
                         (vector-ref %caches 252)))))
           $%cls_29)))
     (vector-ref %caches 253))
    (global-put!
     %global
     (& "ZeroDivisionError")
     (let (($%cls_30 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_30
                 (py-make-class
                  (& "ZeroDivisionError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "ArithmeticError")
                         (vector-ref %caches 254)))))
           $%cls_30)))
     (vector-ref %caches 255))
    (global-put!
     %global
     (& "ModuleNotFoundError")
     (let (($%cls_31 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_31
                 (py-make-class
                  (& "ModuleNotFoundError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "ImportError")
                         (vector-ref %caches 256)))))
           $%cls_31)))
     (vector-ref %caches 257))
    (global-put!
     %global
     (& "IndexError")
     (let (($%cls_32 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_32
                 (py-make-class
                  (& "IndexError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "LookupError")
                         (vector-ref %caches 258)))))
           $%cls_32)))
     (vector-ref %caches 259))
    (global-put!
     %global
     (& "KeyError")
     (let (($%cls_33 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_33
                 (py-make-class
                  (& "KeyError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "LookupError")
                         (vector-ref %caches 260)))))
           $%cls_33)))
     (vector-ref %caches 261))
    (global-put!
     %global
     (& "UnboundLocalError")
     (let (($%cls_34 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_34
                 (py-make-class
                  (& "UnboundLocalError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "NameError")
                         (vector-ref %caches 262)))))
           $%cls_34)))
     (vector-ref %caches 263))
    (global-put!
     %global
     (& "BlockingIOError")
     (let (($%cls_35 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_35
                 (py-make-class
                  (& "BlockingIOError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "OSError")
                         (vector-ref %caches 264)))))
           $%cls_35)))
     (vector-ref %caches 265))
    (global-put!
     %global
     (& "ChildProcessError")
     (let (($%cls_36 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_36
                 (py-make-class
                  (& "ChildProcessError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "OSError")
                         (vector-ref %caches 266)))))
           $%cls_36)))
     (vector-ref %caches 267))
    (global-put!
     %global
     (& "ConnectionError")
     (let (($%cls_37 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_37
                 (py-make-class
                  (& "ConnectionError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "OSError")
                         (vector-ref %caches 268)))))
           $%cls_37)))
     (vector-ref %caches 269))
    (global-put!
     %global
     (& "FileExistsError")
     (let (($%cls_38 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_38
                 (py-make-class
                  (& "FileExistsError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "OSError")
                         (vector-ref %caches 270)))))
           $%cls_38)))
     (vector-ref %caches 271))
    (global-put!
     %global
     (& "FileNotFoundError")
     (let (($%cls_39 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_39
                 (py-make-class
                  (& "FileNotFoundError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "OSError")
                         (vector-ref %caches 272)))))
           $%cls_39)))
     (vector-ref %caches 273))
    (global-put!
     %global
     (& "InterruptedError")
     (let (($%cls_40 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_40
                 (py-make-class
                  (& "InterruptedError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "OSError")
                         (vector-ref %caches 274)))))
           $%cls_40)))
     (vector-ref %caches 275))
    (global-put!
     %global
     (& "IsADirectoryError")
     (let (($%cls_41 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_41
                 (py-make-class
                  (& "IsADirectoryError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "OSError")
                         (vector-ref %caches 276)))))
           $%cls_41)))
     (vector-ref %caches 277))
    (global-put!
     %global
     (& "NotADirectoryError")
     (let (($%cls_42 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_42
                 (py-make-class
                  (& "NotADirectoryError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "OSError")
                         (vector-ref %caches 278)))))
           $%cls_42)))
     (vector-ref %caches 279))
    (global-put!
     %global
     (& "PermissionError")
     (let (($%cls_43 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_43
                 (py-make-class
                  (& "PermissionError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "OSError")
                         (vector-ref %caches 280)))))
           $%cls_43)))
     (vector-ref %caches 281))
    (global-put!
     %global
     (& "ProcessLookupError")
     (let (($%cls_44 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_44
                 (py-make-class
                  (& "ProcessLookupError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "OSError")
                         (vector-ref %caches 282)))))
           $%cls_44)))
     (vector-ref %caches 283))
    (global-put!
     %global
     (& "TimeoutError")
     (let (($%cls_45 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_45
                 (py-make-class
                  (& "TimeoutError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "OSError")
                         (vector-ref %caches 284)))))
           $%cls_45)))
     (vector-ref %caches 285))
    (global-put!
     %global
     (& "NotImplementedError")
     (let (($%cls_46 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_46
                 (py-make-class
                  (& "NotImplementedError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "RuntimeError")
                         (vector-ref %caches 286)))))
           $%cls_46)))
     (vector-ref %caches 287))
    (global-put!
     %global
     (& "RecursionError")
     (let (($%cls_47 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_47
                 (py-make-class
                  (& "RecursionError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "RuntimeError")
                         (vector-ref %caches 288)))))
           $%cls_47)))
     (vector-ref %caches 289))
    (global-put!
     %global
     (& "IndentationError")
     (let (($%cls_48 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_48
                 (py-make-class
                  (& "IndentationError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "SyntaxError")
                         (vector-ref %caches 290)))))
           $%cls_48)))
     (vector-ref %caches 291))
    (global-put!
     %global
     (& "UnicodeError")
     (let (($%cls_49 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_49
                 (py-make-class
                  (& "UnicodeError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "ValueError")
                         (vector-ref %caches 292)))))
           $%cls_49)))
     (vector-ref %caches 293))
    (global-put!
     %global
     (& "BytesWarning")
     (let (($%cls_50 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_50
                 (py-make-class
                  (& "BytesWarning")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Warning")
                         (vector-ref %caches 294)))))
           $%cls_50)))
     (vector-ref %caches 295))
    (global-put!
     %global
     (& "DeprecationWarning")
     (let (($%cls_51 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_51
                 (py-make-class
                  (& "DeprecationWarning")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Warning")
                         (vector-ref %caches 296)))))
           $%cls_51)))
     (vector-ref %caches 297))
    (global-put!
     %global
     (& "FutureWarning")
     (let (($%cls_52 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_52
                 (py-make-class
                  (& "FutureWarning")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Warning")
                         (vector-ref %caches 298)))))
           $%cls_52)))
     (vector-ref %caches 299))
    (global-put!
     %global
     (& "ImportWarning")
     (let (($%cls_53 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_53
                 (py-make-class
                  (& "ImportWarning")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Warning")
                         (vector-ref %caches 300)))))
           $%cls_53)))
     (vector-ref %caches 301))
    (global-put!
     %global
     (& "PendingDeprecationWarning")
     (let (($%cls_54 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_54
                 (py-make-class
                  (& "PendingDeprecationWarning")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Warning")
                         (vector-ref %caches 302)))))
           $%cls_54)))
     (vector-ref %caches 303))
    (global-put!
     %global
     (& "ResourceWarning")
     (let (($%cls_55 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_55
                 (py-make-class
                  (& "ResourceWarning")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Warning")
                         (vector-ref %caches 304)))))
           $%cls_55)))
     (vector-ref %caches 305))
    (global-put!
     %global
     (& "RuntimeWarning")
     (let (($%cls_56 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_56
                 (py-make-class
                  (& "RuntimeWarning")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Warning")
                         (vector-ref %caches 306)))))
           $%cls_56)))
     (vector-ref %caches 307))
    (global-put!
     %global
     (& "SyntaxWarning")
     (let (($%cls_57 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_57
                 (py-make-class
                  (& "SyntaxWarning")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Warning")
                         (vector-ref %caches 308)))))
           $%cls_57)))
     (vector-ref %caches 309))
    (global-put!
     %global
     (& "UnicodeWarning")
     (let (($%cls_58 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_58
                 (py-make-class
                  (& "UnicodeWarning")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Warning")
                         (vector-ref %caches 310)))))
           $%cls_58)))
     (vector-ref %caches 311))
    (global-put!
     %global
     (& "UserWarning")
     (let (($%cls_59 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_59
                 (py-make-class
                  (& "UserWarning")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Warning")
                         (vector-ref %caches 312)))))
           $%cls_59)))
     (vector-ref %caches 313))
    (global-put!
     %global
     (& "BrokenPipeError")
     (let (($%cls_60 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_60
                 (py-make-class
                  (& "BrokenPipeError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "ConnectionError")
                         (vector-ref %caches 314)))))
           $%cls_60)))
     (vector-ref %caches 315))
    (global-put!
     %global
     (& "ConnectionAbortedError")
     (let (($%cls_61 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_61
                 (py-make-class
                  (& "ConnectionAbortedError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "ConnectionError")
                         (vector-ref %caches 316)))))
           $%cls_61)))
     (vector-ref %caches 317))
    (global-put!
     %global
     (& "ConnectionRefusedError")
     (let (($%cls_62 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_62
                 (py-make-class
                  (& "ConnectionRefusedError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "ConnectionError")
                         (vector-ref %caches 318)))))
           $%cls_62)))
     (vector-ref %caches 319))
    (global-put!
     %global
     (& "ConnectionResetError")
     (let (($%cls_63 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_63
                 (py-make-class
                  (& "ConnectionResetError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "ConnectionError")
                         (vector-ref %caches 320)))))
           $%cls_63)))
     (vector-ref %caches 321))
    (global-put!
     %global
     (& "TabError")
     (let (($%cls_64 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_64
                 (py-make-class
                  (& "TabError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "IndentationError")
                         (vector-ref %caches 322)))))
           $%cls_64)))
     (vector-ref %caches 323))
    (global-put!
     %global
     (& "UnicodeDecodeError")
     (let (($%cls_65 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_65
                 (py-make-class
                  (& "UnicodeDecodeError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "UnicodeError")
                         (vector-ref %caches 324)))))
           $%cls_65)))
     (vector-ref %caches 325))
    (global-put!
     %global
     (& "UnicodeEncodeError")
     (let (($%cls_66 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_66
                 (py-make-class
                  (& "UnicodeEncodeError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "UnicodeError")
                         (vector-ref %caches 326)))))
           $%cls_66)))
     (vector-ref %caches 327))
    (global-put!
     %global
     (& "UnicodeTranslateError")
     (let (($%cls_67 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_67
                 (py-make-class
                  (& "UnicodeTranslateError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "UnicodeError")
                         (vector-ref %caches 328)))))
           $%cls_67)))
     (vector-ref %caches 329))))
(lambda ()
  (let ((global (py-make-base-global)) (caches (py-make-caches 330)))
    (py-module global caches)
    global))
