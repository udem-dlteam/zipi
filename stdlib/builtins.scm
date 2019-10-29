(define py-module
  (lambda (%global %caches)
    (set! py-import-root "/home/olivier/udem-dlteam/zipi/")
    (global-put!
     %global
     (& "__name__")
     (py-str-from-scheme "builtins")
     (vector-ref %caches 0))
    (global-put!
     %global
     (& "__file__")
     (py-str-from-scheme "/home/olivier/udem-dlteam/zipi/stdlib/builtins.py")
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
     (global-get %global (& "__base_range") (vector-ref %caches 108))
     (vector-ref %caches 109))
    (global-put!
     %global
     (& "repr")
     (global-get %global (& "__base_repr") (vector-ref %caches 110))
     (vector-ref %caches 111))
    (global-put!
     %global
     (& "reversed")
     (global-get %global (& "__base_reversed") (vector-ref %caches 112))
     (vector-ref %caches 113))
    (global-put!
     %global
     (& "round")
     (global-get %global (& "__base_round") (vector-ref %caches 114))
     (vector-ref %caches 115))
    (global-put!
     %global
     (& "set")
     (global-get %global (& "__base_set") (vector-ref %caches 116))
     (vector-ref %caches 117))
    (global-put!
     %global
     (& "setattr")
     (global-get %global (& "__base_setattr") (vector-ref %caches 118))
     (vector-ref %caches 119))
    (global-put!
     %global
     (& "slice")
     (global-get %global (& "__base_slice") (vector-ref %caches 120))
     (vector-ref %caches 121))
    (global-put!
     %global
     (& "sorted")
     (global-get %global (& "__base_sorted") (vector-ref %caches 122))
     (vector-ref %caches 123))
    (global-put!
     %global
     (& "staticmethod")
     (global-get %global (& "__base_staticmethod") (vector-ref %caches 124))
     (vector-ref %caches 125))
    (global-put!
     %global
     (& "str")
     (global-get %global (& "__base_str") (vector-ref %caches 126))
     (vector-ref %caches 127))
    (global-put!
     %global
     (& "sum")
     (global-get %global (& "__base_sum") (vector-ref %caches 128))
     (vector-ref %caches 129))
    (global-put!
     %global
     (& "super")
     (global-get %global (& "__base_super") (vector-ref %caches 130))
     (vector-ref %caches 131))
    (global-put!
     %global
     (& "tuple")
     (global-get %global (& "__base_tuple") (vector-ref %caches 132))
     (vector-ref %caches 133))
    (global-put!
     %global
     (& "type")
     (global-get %global (& "__base_type") (vector-ref %caches 134))
     (vector-ref %caches 135))
    (global-put!
     %global
     (& "vars")
     (global-get %global (& "__base_vars") (vector-ref %caches 136))
     (vector-ref %caches 137))
    (global-put!
     %global
     (& "zip")
     (global-get %global (& "__base_zip") (vector-ref %caches 138))
     (vector-ref %caches 139))
    (global-put!
     %global
     (& "BaseException")
     (global-get %global (& "BaseException") (vector-ref %caches 140))
     (vector-ref %caches 141))
    (global-put!
     %global
     (& "Exception")
     (begin
       (begin #f)
       (py-make-class
        (& "Exception")
        (& "__main__")
        (list (global-get
               %global
               (& "BaseException")
               (vector-ref %caches 142)))))
     (vector-ref %caches 143))
    (global-put!
     %global
     (& "GeneratorExit")
     (begin
       (begin #f)
       (py-make-class
        (& "GeneratorExit")
        (& "__main__")
        (list (global-get
               %global
               (& "BaseException")
               (vector-ref %caches 144)))))
     (vector-ref %caches 145))
    (global-put!
     %global
     (& "KeyboardInterrupt")
     (begin
       (begin #f)
       (py-make-class
        (& "KeyboardInterrupt")
        (& "__main__")
        (list (global-get
               %global
               (& "BaseException")
               (vector-ref %caches 146)))))
     (vector-ref %caches 147))
    (global-put!
     %global
     (& "SystemExit")
     (begin
       (begin #f)
       (py-make-class
        (& "SystemExit")
        (& "__main__")
        (list (global-get
               %global
               (& "BaseException")
               (vector-ref %caches 148)))))
     (vector-ref %caches 149))
    (global-put!
     %global
     (& "ArithmeticError")
     (begin
       (begin #f)
       (py-make-class
        (& "ArithmeticError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 150)))))
     (vector-ref %caches 151))
    (global-put!
     %global
     (& "AssertionError")
     (begin
       (begin #f)
       (py-make-class
        (& "AssertionError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 152)))))
     (vector-ref %caches 153))
    (global-put!
     %global
     (& "AttributeError")
     (begin
       (begin #f)
       (py-make-class
        (& "AttributeError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 154)))))
     (vector-ref %caches 155))
    (global-put!
     %global
     (& "BufferError")
     (begin
       (begin #f)
       (py-make-class
        (& "BufferError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 156)))))
     (vector-ref %caches 157))
    (global-put!
     %global
     (& "EOFError")
     (begin
       (begin #f)
       (py-make-class
        (& "EOFError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 158)))))
     (vector-ref %caches 159))
    (global-put!
     %global
     (& "ImportError")
     (begin
       (begin #f)
       (py-make-class
        (& "ImportError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 160)))))
     (vector-ref %caches 161))
    (global-put!
     %global
     (& "LookupError")
     (begin
       (begin #f)
       (py-make-class
        (& "LookupError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 162)))))
     (vector-ref %caches 163))
    (global-put!
     %global
     (& "MemoryError")
     (begin
       (begin #f)
       (py-make-class
        (& "MemoryError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 164)))))
     (vector-ref %caches 165))
    (global-put!
     %global
     (& "NameError")
     (begin
       (begin #f)
       (py-make-class
        (& "NameError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 166)))))
     (vector-ref %caches 167))
    (global-put!
     %global
     (& "EnvironmentError")
     (begin
       (begin #f)
       (py-make-class
        (& "EnvironmentError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 168)))))
     (vector-ref %caches 169))
    (global-put!
     %global
     (& "IOError")
     (begin
       (begin #f)
       (py-make-class
        (& "IOError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 170)))))
     (vector-ref %caches 171))
    (global-put!
     %global
     (& "OSError")
     (begin
       (begin #f)
       (py-make-class
        (& "OSError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 172)))))
     (vector-ref %caches 173))
    (global-put!
     %global
     (& "WindowsError")
     (begin
       (begin #f)
       (py-make-class
        (& "WindowsError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 174)))))
     (vector-ref %caches 175))
    (global-put!
     %global
     (& "ReferenceError")
     (begin
       (begin #f)
       (py-make-class
        (& "ReferenceError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 176)))))
     (vector-ref %caches 177))
    (global-put!
     %global
     (& "RuntimeError")
     (begin
       (begin #f)
       (py-make-class
        (& "RuntimeError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 178)))))
     (vector-ref %caches 179))
    (global-put!
     %global
     (& "StopAsyncIteration")
     (begin
       (begin #f)
       (py-make-class
        (& "StopAsyncIteration")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 180)))))
     (vector-ref %caches 181))
    (global-put!
     %global
     (& "StopIteration")
     (begin
       (begin #f)
       (py-make-class
        (& "StopIteration")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 182)))))
     (vector-ref %caches 183))
    (global-put!
     %global
     (& "SyntaxError")
     (begin
       (begin #f)
       (py-make-class
        (& "SyntaxError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 184)))))
     (vector-ref %caches 185))
    (global-put!
     %global
     (& "SystemError")
     (begin
       (begin #f)
       (py-make-class
        (& "SystemError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 186)))))
     (vector-ref %caches 187))
    (global-put!
     %global
     (& "TypeError")
     (begin
       (begin #f)
       (py-make-class
        (& "TypeError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 188)))))
     (vector-ref %caches 189))
    (global-put!
     %global
     (& "ValueError")
     (begin
       (begin #f)
       (py-make-class
        (& "ValueError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 190)))))
     (vector-ref %caches 191))
    (global-put!
     %global
     (& "Warning")
     (begin
       (begin #f)
       (py-make-class
        (& "Warning")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 192)))))
     (vector-ref %caches 193))
    (global-put!
     %global
     (& "FloatingPointError")
     (begin
       (begin #f)
       (py-make-class
        (& "FloatingPointError")
        (& "__main__")
        (list (global-get
               %global
               (& "ArithmeticError")
               (vector-ref %caches 194)))))
     (vector-ref %caches 195))
    (global-put!
     %global
     (& "OverflowError")
     (begin
       (begin #f)
       (py-make-class
        (& "OverflowError")
        (& "__main__")
        (list (global-get
               %global
               (& "ArithmeticError")
               (vector-ref %caches 196)))))
     (vector-ref %caches 197))
    (global-put!
     %global
     (& "ZeroDivisionError")
     (begin
       (begin #f)
       (py-make-class
        (& "ZeroDivisionError")
        (& "__main__")
        (list (global-get
               %global
               (& "ArithmeticError")
               (vector-ref %caches 198)))))
     (vector-ref %caches 199))
    (global-put!
     %global
     (& "ModuleNotFoundError")
     (begin
       (begin #f)
       (py-make-class
        (& "ModuleNotFoundError")
        (& "__main__")
        (list (global-get
               %global
               (& "ImportError")
               (vector-ref %caches 200)))))
     (vector-ref %caches 201))
    (global-put!
     %global
     (& "IndexError")
     (begin
       (begin #f)
       (py-make-class
        (& "IndexError")
        (& "__main__")
        (list (global-get
               %global
               (& "LookupError")
               (vector-ref %caches 202)))))
     (vector-ref %caches 203))
    (global-put!
     %global
     (& "KeyError")
     (begin
       (begin #f)
       (py-make-class
        (& "KeyError")
        (& "__main__")
        (list (global-get
               %global
               (& "LookupError")
               (vector-ref %caches 204)))))
     (vector-ref %caches 205))
    (global-put!
     %global
     (& "UnboundLocalError")
     (begin
       (begin #f)
       (py-make-class
        (& "UnboundLocalError")
        (& "__main__")
        (list (global-get %global (& "NameError") (vector-ref %caches 206)))))
     (vector-ref %caches 207))
    (global-put!
     %global
     (& "BlockingIOError")
     (begin
       (begin #f)
       (py-make-class
        (& "BlockingIOError")
        (& "__main__")
        (list (global-get %global (& "OSError") (vector-ref %caches 208)))))
     (vector-ref %caches 209))
    (global-put!
     %global
     (& "ChildProcessError")
     (begin
       (begin #f)
       (py-make-class
        (& "ChildProcessError")
        (& "__main__")
        (list (global-get %global (& "OSError") (vector-ref %caches 210)))))
     (vector-ref %caches 211))
    (global-put!
     %global
     (& "ConnectionError")
     (begin
       (begin #f)
       (py-make-class
        (& "ConnectionError")
        (& "__main__")
        (list (global-get %global (& "OSError") (vector-ref %caches 212)))))
     (vector-ref %caches 213))
    (global-put!
     %global
     (& "FileExistsError")
     (begin
       (begin #f)
       (py-make-class
        (& "FileExistsError")
        (& "__main__")
        (list (global-get %global (& "OSError") (vector-ref %caches 214)))))
     (vector-ref %caches 215))
    (global-put!
     %global
     (& "FileNotFoundError")
     (begin
       (begin #f)
       (py-make-class
        (& "FileNotFoundError")
        (& "__main__")
        (list (global-get %global (& "OSError") (vector-ref %caches 216)))))
     (vector-ref %caches 217))
    (global-put!
     %global
     (& "InterruptedError")
     (begin
       (begin #f)
       (py-make-class
        (& "InterruptedError")
        (& "__main__")
        (list (global-get %global (& "OSError") (vector-ref %caches 218)))))
     (vector-ref %caches 219))
    (global-put!
     %global
     (& "IsADirectoryError")
     (begin
       (begin #f)
       (py-make-class
        (& "IsADirectoryError")
        (& "__main__")
        (list (global-get %global (& "OSError") (vector-ref %caches 220)))))
     (vector-ref %caches 221))
    (global-put!
     %global
     (& "NotADirectoryError")
     (begin
       (begin #f)
       (py-make-class
        (& "NotADirectoryError")
        (& "__main__")
        (list (global-get %global (& "OSError") (vector-ref %caches 222)))))
     (vector-ref %caches 223))
    (global-put!
     %global
     (& "PermissionError")
     (begin
       (begin #f)
       (py-make-class
        (& "PermissionError")
        (& "__main__")
        (list (global-get %global (& "OSError") (vector-ref %caches 224)))))
     (vector-ref %caches 225))
    (global-put!
     %global
     (& "ProcessLookupError")
     (begin
       (begin #f)
       (py-make-class
        (& "ProcessLookupError")
        (& "__main__")
        (list (global-get %global (& "OSError") (vector-ref %caches 226)))))
     (vector-ref %caches 227))
    (global-put!
     %global
     (& "TimeoutError")
     (begin
       (begin #f)
       (py-make-class
        (& "TimeoutError")
        (& "__main__")
        (list (global-get %global (& "OSError") (vector-ref %caches 228)))))
     (vector-ref %caches 229))
    (global-put!
     %global
     (& "NotImplementedError")
     (begin
       (begin #f)
       (py-make-class
        (& "NotImplementedError")
        (& "__main__")
        (list (global-get
               %global
               (& "RuntimeError")
               (vector-ref %caches 230)))))
     (vector-ref %caches 231))
    (global-put!
     %global
     (& "RecursionError")
     (begin
       (begin #f)
       (py-make-class
        (& "RecursionError")
        (& "__main__")
        (list (global-get
               %global
               (& "RuntimeError")
               (vector-ref %caches 232)))))
     (vector-ref %caches 233))
    (global-put!
     %global
     (& "IndentationError")
     (begin
       (begin #f)
       (py-make-class
        (& "IndentationError")
        (& "__main__")
        (list (global-get
               %global
               (& "SyntaxError")
               (vector-ref %caches 234)))))
     (vector-ref %caches 235))
    (global-put!
     %global
     (& "UnicodeError")
     (begin
       (begin #f)
       (py-make-class
        (& "UnicodeError")
        (& "__main__")
        (list (global-get %global (& "ValueError") (vector-ref %caches 236)))))
     (vector-ref %caches 237))
    (global-put!
     %global
     (& "BytesWarning")
     (begin
       (begin #f)
       (py-make-class
        (& "BytesWarning")
        (& "__main__")
        (list (global-get %global (& "Warning") (vector-ref %caches 238)))))
     (vector-ref %caches 239))
    (global-put!
     %global
     (& "DeprecationWarning")
     (begin
       (begin #f)
       (py-make-class
        (& "DeprecationWarning")
        (& "__main__")
        (list (global-get %global (& "Warning") (vector-ref %caches 240)))))
     (vector-ref %caches 241))
    (global-put!
     %global
     (& "FutureWarning")
     (begin
       (begin #f)
       (py-make-class
        (& "FutureWarning")
        (& "__main__")
        (list (global-get %global (& "Warning") (vector-ref %caches 242)))))
     (vector-ref %caches 243))
    (global-put!
     %global
     (& "ImportWarning")
     (begin
       (begin #f)
       (py-make-class
        (& "ImportWarning")
        (& "__main__")
        (list (global-get %global (& "Warning") (vector-ref %caches 244)))))
     (vector-ref %caches 245))
    (global-put!
     %global
     (& "PendingDeprecationWarning")
     (begin
       (begin #f)
       (py-make-class
        (& "PendingDeprecationWarning")
        (& "__main__")
        (list (global-get %global (& "Warning") (vector-ref %caches 246)))))
     (vector-ref %caches 247))
    (global-put!
     %global
     (& "ResourceWarning")
     (begin
       (begin #f)
       (py-make-class
        (& "ResourceWarning")
        (& "__main__")
        (list (global-get %global (& "Warning") (vector-ref %caches 248)))))
     (vector-ref %caches 249))
    (global-put!
     %global
     (& "RuntimeWarning")
     (begin
       (begin #f)
       (py-make-class
        (& "RuntimeWarning")
        (& "__main__")
        (list (global-get %global (& "Warning") (vector-ref %caches 250)))))
     (vector-ref %caches 251))
    (global-put!
     %global
     (& "SyntaxWarning")
     (begin
       (begin #f)
       (py-make-class
        (& "SyntaxWarning")
        (& "__main__")
        (list (global-get %global (& "Warning") (vector-ref %caches 252)))))
     (vector-ref %caches 253))
    (global-put!
     %global
     (& "UnicodeWarning")
     (begin
       (begin #f)
       (py-make-class
        (& "UnicodeWarning")
        (& "__main__")
        (list (global-get %global (& "Warning") (vector-ref %caches 254)))))
     (vector-ref %caches 255))
    (global-put!
     %global
     (& "UserWarning")
     (begin
       (begin #f)
       (py-make-class
        (& "UserWarning")
        (& "__main__")
        (list (global-get %global (& "Warning") (vector-ref %caches 256)))))
     (vector-ref %caches 257))
    (global-put!
     %global
     (& "BrokenPipeError")
     (begin
       (begin #f)
       (py-make-class
        (& "BrokenPipeError")
        (& "__main__")
        (list (global-get
               %global
               (& "ConnectionError")
               (vector-ref %caches 258)))))
     (vector-ref %caches 259))
    (global-put!
     %global
     (& "ConnectionAbortedError")
     (begin
       (begin #f)
       (py-make-class
        (& "ConnectionAbortedError")
        (& "__main__")
        (list (global-get
               %global
               (& "ConnectionError")
               (vector-ref %caches 260)))))
     (vector-ref %caches 261))
    (global-put!
     %global
     (& "ConnectionRefusedError")
     (begin
       (begin #f)
       (py-make-class
        (& "ConnectionRefusedError")
        (& "__main__")
        (list (global-get
               %global
               (& "ConnectionError")
               (vector-ref %caches 262)))))
     (vector-ref %caches 263))
    (global-put!
     %global
     (& "ConnectionResetError")
     (begin
       (begin #f)
       (py-make-class
        (& "ConnectionResetError")
        (& "__main__")
        (list (global-get
               %global
               (& "ConnectionError")
               (vector-ref %caches 264)))))
     (vector-ref %caches 265))
    (global-put!
     %global
     (& "TabError")
     (begin
       (begin #f)
       (py-make-class
        (& "TabError")
        (& "__main__")
        (list (global-get
               %global
               (& "IndentationError")
               (vector-ref %caches 266)))))
     (vector-ref %caches 267))
    (global-put!
     %global
     (& "UnicodeDecodeError")
     (begin
       (begin #f)
       (py-make-class
        (& "UnicodeDecodeError")
        (& "__main__")
        (list (global-get
               %global
               (& "UnicodeError")
               (vector-ref %caches 268)))))
     (vector-ref %caches 269))
    (global-put!
     %global
     (& "UnicodeEncodeError")
     (begin
       (begin #f)
       (py-make-class
        (& "UnicodeEncodeError")
        (& "__main__")
        (list (global-get
               %global
               (& "UnicodeError")
               (vector-ref %caches 270)))))
     (vector-ref %caches 271))
    (global-put!
     %global
     (& "UnicodeTranslateError")
     (begin
       (begin #f)
       (py-make-class
        (& "UnicodeTranslateError")
        (& "__main__")
        (list (global-get
               %global
               (& "UnicodeError")
               (vector-ref %caches 272)))))
     (vector-ref %caches 273))))
(lambda ()
  (let ((global (py-make-base-global)) (caches (py-make-caches 274)))
    (py-module global caches)
    global))
