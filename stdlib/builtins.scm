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
     (& "range")
     (let (($%cls_0 (py-uninit)))
       (letrec* ((start153 (py-uninit))
                 (stop154 (py-uninit))
                 (step155 (py-uninit))
                 (__init__156 (py-uninit))
                 (__len__157 (py-uninit))
                 (__contains__158 (py-uninit)))
         (begin
           (set! __init__156
                 (procedure->py-function
                  (lambda (self3 arg14 arg25 arg36)
                    (begin
                      (if (py-test (py-isnot
                                    arg36
                                    (global-get
                                     %global
                                     (& "_absent")
                                     (vector-ref %caches 110))
                                    (vector-ref %caches 111)))
                          (begin
                            (object-put!
                             self3
                             (& "start")
                             arg14
                             (vector-ref %caches 112))
                            (object-put!
                             self3
                             (& "stop")
                             arg25
                             (vector-ref %caches 113))
                            (object-put!
                             self3
                             (& "step")
                             arg36
                             (vector-ref %caches 114)))
                          (begin
                            (if (py-test (py-isnot
                                          arg25
                                          (global-get
                                           %global
                                           (& "_absent")
                                           (vector-ref %caches 115))
                                          (vector-ref %caches 116)))
                                (begin
                                  (object-put!
                                   self3
                                   (& "start")
                                   arg14
                                   (vector-ref %caches 117))
                                  (object-put!
                                   self3
                                   (& "stop")
                                   arg25
                                   (vector-ref %caches 118))
                                  (object-put!
                                   self3
                                   (& "step")
                                   (py-int-from-scheme 1)
                                   (vector-ref %caches 119)))
                                (begin
                                  (object-put!
                                   self3
                                   (& "start")
                                   (py-int-from-scheme 0)
                                   (vector-ref %caches 120))
                                  (object-put!
                                   self3
                                   (& "stop")
                                   arg14
                                   (vector-ref %caches 121))
                                  (object-put!
                                   self3
                                   (& "step")
                                   (py-int-from-scheme 1)
                                   (vector-ref %caches 122))))))))
                  (vector #()
                          #(self arg1 arg2 arg3)
                          #f
                          #()
                          (vector)
                          #f
                          (vector (global-get
                                   %global
                                   (& "_absent")
                                   (vector-ref %caches 108))
                                  (global-get
                                   %global
                                   (& "_absent")
                                   (vector-ref %caches 109))))))
           (set! __len__157
                 (procedure->py-function
                  (lambda (self8)
                    (begin
                      (py-floordiv
                       (py-sub (object-get
                                self8
                                (& "stop")
                                (vector-ref %caches 123))
                               (object-get
                                self8
                                (& "start")
                                (vector-ref %caches 124))
                               (vector-ref %caches 125))
                       (object-get self8 (& "step") (vector-ref %caches 126))
                       (vector-ref %caches 127))))
                  (vector #(self) #() #f #() (vector) #f (vector))))
           (set! __contains__158
                 (procedure->py-function
                  (lambda (self10 item11)
                    (begin
                      (set! start153
                            (object-get
                             self10
                             (& "start")
                             (vector-ref %caches 128)))
                      (set! stop154
                            (object-get
                             self10
                             (& "stop")
                             (vector-ref %caches 129)))
                      (set! step155
                            (object-get
                             self10
                             (& "step")
                             (vector-ref %caches 130)))
                      (if (py-test (py-lt (object-get
                                           self10
                                           (& "step")
                                           (vector-ref %caches 131))
                                          (py-int-from-scheme 0)
                                          (vector-ref %caches 132)))
                          (begin
                            (if (py-test (py-not (py-lt stop154
                                                        item11
                                                        (vector-ref
                                                         %caches
                                                         133))
                                                 (vector-ref %caches 134)))
                                (begin
                                  (if (py-test (py-not (py-le item11
                                                              start153
                                                              (vector-ref
                                                               %caches
                                                               135))
                                                       (vector-ref
                                                        %caches
                                                        136)))
                                      (begin
                                        (return (scheme (PycReturn-val this)
                                                        conf)))
                                      #f))
                                #f))
                          (begin
                            (if (py-test (py-not (py-le start153
                                                        item11
                                                        (vector-ref
                                                         %caches
                                                         137))
                                                 (vector-ref %caches 138)))
                                (begin
                                  (if (py-test (py-not (py-lt item11
                                                              stop154
                                                              (vector-ref
                                                               %caches
                                                               139))
                                                       (vector-ref
                                                        %caches
                                                        140)))
                                      (begin
                                        (return (scheme (PycReturn-val this)
                                                        conf)))
                                      #f))
                                #f)))
                      (py-eq (py-mod (py-sub item11
                                             start153
                                             (vector-ref %caches 141))
                                     step155
                                     (vector-ref %caches 142))
                             (py-int-from-scheme 0)
                             (vector-ref %caches 143))))
                  (vector #(self item) #() #f #() (vector) #f (vector)))))
         (begin
           (set! $%cls_0
                 (py-make-class
                  (& "range")
                  (& "__main__")
                  (list)
                  (& "start")
                  start153
                  (& "stop")
                  stop154
                  (& "step")
                  step155
                  (& "__init__")
                  __init__156
                  (& "__len__")
                  __len__157
                  (& "__contains__")
                  __contains__158))
           $%cls_0)))
     (vector-ref %caches 144))
    (global-put!
     %global
     (& "repr")
     (global-get %global (& "__base_repr") (vector-ref %caches 145))
     (vector-ref %caches 146))
    (global-put!
     %global
     (& "reversed")
     (global-get %global (& "__base_reversed") (vector-ref %caches 147))
     (vector-ref %caches 148))
    (global-put!
     %global
     (& "round")
     (global-get %global (& "__base_round") (vector-ref %caches 149))
     (vector-ref %caches 150))
    (global-put!
     %global
     (& "set")
     (global-get %global (& "__base_set") (vector-ref %caches 151))
     (vector-ref %caches 152))
    (global-put!
     %global
     (& "setattr")
     (global-get %global (& "__base_setattr") (vector-ref %caches 153))
     (vector-ref %caches 154))
    (global-put!
     %global
     (& "slice")
     (global-get %global (& "__base_slice") (vector-ref %caches 155))
     (vector-ref %caches 156))
    (global-put!
     %global
     (& "sorted")
     (global-get %global (& "__base_sorted") (vector-ref %caches 157))
     (vector-ref %caches 158))
    (global-put!
     %global
     (& "staticmethod")
     (global-get %global (& "__base_staticmethod") (vector-ref %caches 159))
     (vector-ref %caches 160))
    (global-put!
     %global
     (& "str")
     (global-get %global (& "__base_str") (vector-ref %caches 161))
     (vector-ref %caches 162))
    (global-put!
     %global
     (& "sum")
     (global-get %global (& "__base_sum") (vector-ref %caches 163))
     (vector-ref %caches 164))
    (global-put!
     %global
     (& "super")
     (global-get %global (& "__base_super") (vector-ref %caches 165))
     (vector-ref %caches 166))
    (global-put!
     %global
     (& "tuple")
     (global-get %global (& "__base_tuple") (vector-ref %caches 167))
     (vector-ref %caches 168))
    (global-put!
     %global
     (& "type")
     (global-get %global (& "__base_type") (vector-ref %caches 169))
     (vector-ref %caches 170))
    (global-put!
     %global
     (& "vars")
     (global-get %global (& "__base_vars") (vector-ref %caches 171))
     (vector-ref %caches 172))
    (global-put!
     %global
     (& "zip")
     (global-get %global (& "__base_zip") (vector-ref %caches 173))
     (vector-ref %caches 174))
    (global-put!
     %global
     (& "NotImplemented")
     (global-get %global (& "NotImplemented") (vector-ref %caches 175))
     (vector-ref %caches 176))
    (global-put!
     %global
     (& "BaseException")
     (global-get %global (& "BaseException") (vector-ref %caches 177))
     (vector-ref %caches 178))
    (global-put!
     %global
     (& "Exception")
     (let (($%cls_1 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_1
                 (py-make-class
                  (& "Exception")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "BaseException")
                         (vector-ref %caches 179)))))
           $%cls_1)))
     (vector-ref %caches 180))
    (global-put!
     %global
     (& "GeneratorExit")
     (let (($%cls_2 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_2
                 (py-make-class
                  (& "GeneratorExit")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "BaseException")
                         (vector-ref %caches 181)))))
           $%cls_2)))
     (vector-ref %caches 182))
    (global-put!
     %global
     (& "KeyboardInterrupt")
     (let (($%cls_3 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_3
                 (py-make-class
                  (& "KeyboardInterrupt")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "BaseException")
                         (vector-ref %caches 183)))))
           $%cls_3)))
     (vector-ref %caches 184))
    (global-put!
     %global
     (& "SystemExit")
     (let (($%cls_4 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_4
                 (py-make-class
                  (& "SystemExit")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "BaseException")
                         (vector-ref %caches 185)))))
           $%cls_4)))
     (vector-ref %caches 186))
    (global-put!
     %global
     (& "ArithmeticError")
     (let (($%cls_5 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_5
                 (py-make-class
                  (& "ArithmeticError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 187)))))
           $%cls_5)))
     (vector-ref %caches 188))
    (global-put!
     %global
     (& "AssertionError")
     (let (($%cls_6 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_6
                 (py-make-class
                  (& "AssertionError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 189)))))
           $%cls_6)))
     (vector-ref %caches 190))
    (global-put!
     %global
     (& "AttributeError")
     (let (($%cls_7 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_7
                 (py-make-class
                  (& "AttributeError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 191)))))
           $%cls_7)))
     (vector-ref %caches 192))
    (global-put!
     %global
     (& "BufferError")
     (let (($%cls_8 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_8
                 (py-make-class
                  (& "BufferError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 193)))))
           $%cls_8)))
     (vector-ref %caches 194))
    (global-put!
     %global
     (& "EOFError")
     (let (($%cls_9 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_9
                 (py-make-class
                  (& "EOFError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 195)))))
           $%cls_9)))
     (vector-ref %caches 196))
    (global-put!
     %global
     (& "ImportError")
     (let (($%cls_10 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_10
                 (py-make-class
                  (& "ImportError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 197)))))
           $%cls_10)))
     (vector-ref %caches 198))
    (global-put!
     %global
     (& "LookupError")
     (let (($%cls_11 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_11
                 (py-make-class
                  (& "LookupError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 199)))))
           $%cls_11)))
     (vector-ref %caches 200))
    (global-put!
     %global
     (& "MemoryError")
     (let (($%cls_12 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_12
                 (py-make-class
                  (& "MemoryError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 201)))))
           $%cls_12)))
     (vector-ref %caches 202))
    (global-put!
     %global
     (& "NameError")
     (let (($%cls_13 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_13
                 (py-make-class
                  (& "NameError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 203)))))
           $%cls_13)))
     (vector-ref %caches 204))
    (global-put!
     %global
     (& "EnvironmentError")
     (let (($%cls_14 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_14
                 (py-make-class
                  (& "EnvironmentError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 205)))))
           $%cls_14)))
     (vector-ref %caches 206))
    (global-put!
     %global
     (& "IOError")
     (let (($%cls_15 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_15
                 (py-make-class
                  (& "IOError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 207)))))
           $%cls_15)))
     (vector-ref %caches 208))
    (global-put!
     %global
     (& "OSError")
     (let (($%cls_16 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_16
                 (py-make-class
                  (& "OSError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 209)))))
           $%cls_16)))
     (vector-ref %caches 210))
    (global-put!
     %global
     (& "WindowsError")
     (let (($%cls_17 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_17
                 (py-make-class
                  (& "WindowsError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 211)))))
           $%cls_17)))
     (vector-ref %caches 212))
    (global-put!
     %global
     (& "ReferenceError")
     (let (($%cls_18 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_18
                 (py-make-class
                  (& "ReferenceError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 213)))))
           $%cls_18)))
     (vector-ref %caches 214))
    (global-put!
     %global
     (& "RuntimeError")
     (let (($%cls_19 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_19
                 (py-make-class
                  (& "RuntimeError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 215)))))
           $%cls_19)))
     (vector-ref %caches 216))
    (global-put!
     %global
     (& "StopAsyncIteration")
     (let (($%cls_20 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_20
                 (py-make-class
                  (& "StopAsyncIteration")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 217)))))
           $%cls_20)))
     (vector-ref %caches 218))
    (global-put!
     %global
     (& "StopIteration")
     (let (($%cls_21 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_21
                 (py-make-class
                  (& "StopIteration")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 219)))))
           $%cls_21)))
     (vector-ref %caches 220))
    (global-put!
     %global
     (& "SyntaxError")
     (let (($%cls_22 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_22
                 (py-make-class
                  (& "SyntaxError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 221)))))
           $%cls_22)))
     (vector-ref %caches 222))
    (global-put!
     %global
     (& "SystemError")
     (let (($%cls_23 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_23
                 (py-make-class
                  (& "SystemError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 223)))))
           $%cls_23)))
     (vector-ref %caches 224))
    (global-put!
     %global
     (& "TypeError")
     (let (($%cls_24 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_24
                 (py-make-class
                  (& "TypeError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 225)))))
           $%cls_24)))
     (vector-ref %caches 226))
    (global-put!
     %global
     (& "ValueError")
     (let (($%cls_25 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_25
                 (py-make-class
                  (& "ValueError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 227)))))
           $%cls_25)))
     (vector-ref %caches 228))
    (global-put!
     %global
     (& "Warning")
     (let (($%cls_26 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_26
                 (py-make-class
                  (& "Warning")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Exception")
                         (vector-ref %caches 229)))))
           $%cls_26)))
     (vector-ref %caches 230))
    (global-put!
     %global
     (& "FloatingPointError")
     (let (($%cls_27 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_27
                 (py-make-class
                  (& "FloatingPointError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "ArithmeticError")
                         (vector-ref %caches 231)))))
           $%cls_27)))
     (vector-ref %caches 232))
    (global-put!
     %global
     (& "OverflowError")
     (let (($%cls_28 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_28
                 (py-make-class
                  (& "OverflowError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "ArithmeticError")
                         (vector-ref %caches 233)))))
           $%cls_28)))
     (vector-ref %caches 234))
    (global-put!
     %global
     (& "ZeroDivisionError")
     (let (($%cls_29 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_29
                 (py-make-class
                  (& "ZeroDivisionError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "ArithmeticError")
                         (vector-ref %caches 235)))))
           $%cls_29)))
     (vector-ref %caches 236))
    (global-put!
     %global
     (& "ModuleNotFoundError")
     (let (($%cls_30 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_30
                 (py-make-class
                  (& "ModuleNotFoundError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "ImportError")
                         (vector-ref %caches 237)))))
           $%cls_30)))
     (vector-ref %caches 238))
    (global-put!
     %global
     (& "IndexError")
     (let (($%cls_31 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_31
                 (py-make-class
                  (& "IndexError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "LookupError")
                         (vector-ref %caches 239)))))
           $%cls_31)))
     (vector-ref %caches 240))
    (global-put!
     %global
     (& "KeyError")
     (let (($%cls_32 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_32
                 (py-make-class
                  (& "KeyError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "LookupError")
                         (vector-ref %caches 241)))))
           $%cls_32)))
     (vector-ref %caches 242))
    (global-put!
     %global
     (& "UnboundLocalError")
     (let (($%cls_33 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_33
                 (py-make-class
                  (& "UnboundLocalError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "NameError")
                         (vector-ref %caches 243)))))
           $%cls_33)))
     (vector-ref %caches 244))
    (global-put!
     %global
     (& "BlockingIOError")
     (let (($%cls_34 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_34
                 (py-make-class
                  (& "BlockingIOError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "OSError")
                         (vector-ref %caches 245)))))
           $%cls_34)))
     (vector-ref %caches 246))
    (global-put!
     %global
     (& "ChildProcessError")
     (let (($%cls_35 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_35
                 (py-make-class
                  (& "ChildProcessError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "OSError")
                         (vector-ref %caches 247)))))
           $%cls_35)))
     (vector-ref %caches 248))
    (global-put!
     %global
     (& "ConnectionError")
     (let (($%cls_36 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_36
                 (py-make-class
                  (& "ConnectionError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "OSError")
                         (vector-ref %caches 249)))))
           $%cls_36)))
     (vector-ref %caches 250))
    (global-put!
     %global
     (& "FileExistsError")
     (let (($%cls_37 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_37
                 (py-make-class
                  (& "FileExistsError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "OSError")
                         (vector-ref %caches 251)))))
           $%cls_37)))
     (vector-ref %caches 252))
    (global-put!
     %global
     (& "FileNotFoundError")
     (let (($%cls_38 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_38
                 (py-make-class
                  (& "FileNotFoundError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "OSError")
                         (vector-ref %caches 253)))))
           $%cls_38)))
     (vector-ref %caches 254))
    (global-put!
     %global
     (& "InterruptedError")
     (let (($%cls_39 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_39
                 (py-make-class
                  (& "InterruptedError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "OSError")
                         (vector-ref %caches 255)))))
           $%cls_39)))
     (vector-ref %caches 256))
    (global-put!
     %global
     (& "IsADirectoryError")
     (let (($%cls_40 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_40
                 (py-make-class
                  (& "IsADirectoryError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "OSError")
                         (vector-ref %caches 257)))))
           $%cls_40)))
     (vector-ref %caches 258))
    (global-put!
     %global
     (& "NotADirectoryError")
     (let (($%cls_41 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_41
                 (py-make-class
                  (& "NotADirectoryError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "OSError")
                         (vector-ref %caches 259)))))
           $%cls_41)))
     (vector-ref %caches 260))
    (global-put!
     %global
     (& "PermissionError")
     (let (($%cls_42 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_42
                 (py-make-class
                  (& "PermissionError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "OSError")
                         (vector-ref %caches 261)))))
           $%cls_42)))
     (vector-ref %caches 262))
    (global-put!
     %global
     (& "ProcessLookupError")
     (let (($%cls_43 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_43
                 (py-make-class
                  (& "ProcessLookupError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "OSError")
                         (vector-ref %caches 263)))))
           $%cls_43)))
     (vector-ref %caches 264))
    (global-put!
     %global
     (& "TimeoutError")
     (let (($%cls_44 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_44
                 (py-make-class
                  (& "TimeoutError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "OSError")
                         (vector-ref %caches 265)))))
           $%cls_44)))
     (vector-ref %caches 266))
    (global-put!
     %global
     (& "NotImplementedError")
     (let (($%cls_45 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_45
                 (py-make-class
                  (& "NotImplementedError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "RuntimeError")
                         (vector-ref %caches 267)))))
           $%cls_45)))
     (vector-ref %caches 268))
    (global-put!
     %global
     (& "RecursionError")
     (let (($%cls_46 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_46
                 (py-make-class
                  (& "RecursionError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "RuntimeError")
                         (vector-ref %caches 269)))))
           $%cls_46)))
     (vector-ref %caches 270))
    (global-put!
     %global
     (& "IndentationError")
     (let (($%cls_47 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_47
                 (py-make-class
                  (& "IndentationError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "SyntaxError")
                         (vector-ref %caches 271)))))
           $%cls_47)))
     (vector-ref %caches 272))
    (global-put!
     %global
     (& "UnicodeError")
     (let (($%cls_48 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_48
                 (py-make-class
                  (& "UnicodeError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "ValueError")
                         (vector-ref %caches 273)))))
           $%cls_48)))
     (vector-ref %caches 274))
    (global-put!
     %global
     (& "BytesWarning")
     (let (($%cls_49 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_49
                 (py-make-class
                  (& "BytesWarning")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Warning")
                         (vector-ref %caches 275)))))
           $%cls_49)))
     (vector-ref %caches 276))
    (global-put!
     %global
     (& "DeprecationWarning")
     (let (($%cls_50 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_50
                 (py-make-class
                  (& "DeprecationWarning")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Warning")
                         (vector-ref %caches 277)))))
           $%cls_50)))
     (vector-ref %caches 278))
    (global-put!
     %global
     (& "FutureWarning")
     (let (($%cls_51 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_51
                 (py-make-class
                  (& "FutureWarning")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Warning")
                         (vector-ref %caches 279)))))
           $%cls_51)))
     (vector-ref %caches 280))
    (global-put!
     %global
     (& "ImportWarning")
     (let (($%cls_52 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_52
                 (py-make-class
                  (& "ImportWarning")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Warning")
                         (vector-ref %caches 281)))))
           $%cls_52)))
     (vector-ref %caches 282))
    (global-put!
     %global
     (& "PendingDeprecationWarning")
     (let (($%cls_53 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_53
                 (py-make-class
                  (& "PendingDeprecationWarning")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Warning")
                         (vector-ref %caches 283)))))
           $%cls_53)))
     (vector-ref %caches 284))
    (global-put!
     %global
     (& "ResourceWarning")
     (let (($%cls_54 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_54
                 (py-make-class
                  (& "ResourceWarning")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Warning")
                         (vector-ref %caches 285)))))
           $%cls_54)))
     (vector-ref %caches 286))
    (global-put!
     %global
     (& "RuntimeWarning")
     (let (($%cls_55 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_55
                 (py-make-class
                  (& "RuntimeWarning")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Warning")
                         (vector-ref %caches 287)))))
           $%cls_55)))
     (vector-ref %caches 288))
    (global-put!
     %global
     (& "SyntaxWarning")
     (let (($%cls_56 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_56
                 (py-make-class
                  (& "SyntaxWarning")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Warning")
                         (vector-ref %caches 289)))))
           $%cls_56)))
     (vector-ref %caches 290))
    (global-put!
     %global
     (& "UnicodeWarning")
     (let (($%cls_57 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_57
                 (py-make-class
                  (& "UnicodeWarning")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Warning")
                         (vector-ref %caches 291)))))
           $%cls_57)))
     (vector-ref %caches 292))
    (global-put!
     %global
     (& "UserWarning")
     (let (($%cls_58 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_58
                 (py-make-class
                  (& "UserWarning")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "Warning")
                         (vector-ref %caches 293)))))
           $%cls_58)))
     (vector-ref %caches 294))
    (global-put!
     %global
     (& "BrokenPipeError")
     (let (($%cls_59 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_59
                 (py-make-class
                  (& "BrokenPipeError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "ConnectionError")
                         (vector-ref %caches 295)))))
           $%cls_59)))
     (vector-ref %caches 296))
    (global-put!
     %global
     (& "ConnectionAbortedError")
     (let (($%cls_60 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_60
                 (py-make-class
                  (& "ConnectionAbortedError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "ConnectionError")
                         (vector-ref %caches 297)))))
           $%cls_60)))
     (vector-ref %caches 298))
    (global-put!
     %global
     (& "ConnectionRefusedError")
     (let (($%cls_61 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_61
                 (py-make-class
                  (& "ConnectionRefusedError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "ConnectionError")
                         (vector-ref %caches 299)))))
           $%cls_61)))
     (vector-ref %caches 300))
    (global-put!
     %global
     (& "ConnectionResetError")
     (let (($%cls_62 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_62
                 (py-make-class
                  (& "ConnectionResetError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "ConnectionError")
                         (vector-ref %caches 301)))))
           $%cls_62)))
     (vector-ref %caches 302))
    (global-put!
     %global
     (& "TabError")
     (let (($%cls_63 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_63
                 (py-make-class
                  (& "TabError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "IndentationError")
                         (vector-ref %caches 303)))))
           $%cls_63)))
     (vector-ref %caches 304))
    (global-put!
     %global
     (& "UnicodeDecodeError")
     (let (($%cls_64 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_64
                 (py-make-class
                  (& "UnicodeDecodeError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "UnicodeError")
                         (vector-ref %caches 305)))))
           $%cls_64)))
     (vector-ref %caches 306))
    (global-put!
     %global
     (& "UnicodeEncodeError")
     (let (($%cls_65 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_65
                 (py-make-class
                  (& "UnicodeEncodeError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "UnicodeError")
                         (vector-ref %caches 307)))))
           $%cls_65)))
     (vector-ref %caches 308))
    (global-put!
     %global
     (& "UnicodeTranslateError")
     (let (($%cls_66 (py-uninit)))
       (begin
         (begin #f)
         (begin
           (set! $%cls_66
                 (py-make-class
                  (& "UnicodeTranslateError")
                  (& "__main__")
                  (list (global-get
                         %global
                         (& "UnicodeError")
                         (vector-ref %caches 309)))))
           $%cls_66)))
     (vector-ref %caches 310))))
(lambda ()
  (let ((global (py-make-base-global)) (caches (py-make-caches 311)))
    (py-module global caches)
    global))
