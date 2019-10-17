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
     (& "print")
     (make-PyFunction
      (PyFunction-default-hclass)
      '#()
      (lambda (obj3)
        (begin
          (py-call1
           (global-get %global (& "__base_print") (vector-ref %caches 2))
           obj3))))
     (vector-ref %caches 3))
    (global-put!
     %global
     (& "f")
     (make-PyFunction (PyFunction-default-hclass) '#() (lambda () (begin #f)))
     (vector-ref %caches 4))
    (global-put!
     %global
     (& "BaseException")
     (global-get %global (& "BaseException") (vector-ref %caches 5))
     (vector-ref %caches 6))
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
               (vector-ref %caches 7)))))
     (vector-ref %caches 8))
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
               (vector-ref %caches 9)))))
     (vector-ref %caches 10))
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
               (vector-ref %caches 11)))))
     (vector-ref %caches 12))
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
               (vector-ref %caches 13)))))
     (vector-ref %caches 14))
    (global-put!
     %global
     (& "ArithmeticError")
     (begin
       (begin #f)
       (py-make-class
        (& "ArithmeticError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 15)))))
     (vector-ref %caches 16))
    (global-put!
     %global
     (& "AssertionError")
     (begin
       (begin #f)
       (py-make-class
        (& "AssertionError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 17)))))
     (vector-ref %caches 18))
    (global-put!
     %global
     (& "AttributeError")
     (begin
       (begin #f)
       (py-make-class
        (& "AttributeError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 19)))))
     (vector-ref %caches 20))
    (global-put!
     %global
     (& "BufferError")
     (begin
       (begin #f)
       (py-make-class
        (& "BufferError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 21)))))
     (vector-ref %caches 22))
    (global-put!
     %global
     (& "EOFError")
     (begin
       (begin #f)
       (py-make-class
        (& "EOFError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 23)))))
     (vector-ref %caches 24))
    (global-put!
     %global
     (& "ImportError")
     (begin
       (begin #f)
       (py-make-class
        (& "ImportError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 25)))))
     (vector-ref %caches 26))
    (global-put!
     %global
     (& "LookupError")
     (begin
       (begin #f)
       (py-make-class
        (& "LookupError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 27)))))
     (vector-ref %caches 28))
    (global-put!
     %global
     (& "MemoryError")
     (begin
       (begin #f)
       (py-make-class
        (& "MemoryError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 29)))))
     (vector-ref %caches 30))
    (global-put!
     %global
     (& "NameError")
     (begin
       (begin #f)
       (py-make-class
        (& "NameError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 31)))))
     (vector-ref %caches 32))
    (global-put!
     %global
     (& "EnvironmentError")
     (begin
       (begin #f)
       (py-make-class
        (& "EnvironmentError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 33)))))
     (vector-ref %caches 34))
    (global-put!
     %global
     (& "IOError")
     (begin
       (begin #f)
       (py-make-class
        (& "IOError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 35)))))
     (vector-ref %caches 36))
    (global-put!
     %global
     (& "OSError")
     (begin
       (begin #f)
       (py-make-class
        (& "OSError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 37)))))
     (vector-ref %caches 38))
    (global-put!
     %global
     (& "WindowsError")
     (begin
       (begin #f)
       (py-make-class
        (& "WindowsError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 39)))))
     (vector-ref %caches 40))
    (global-put!
     %global
     (& "ReferenceError")
     (begin
       (begin #f)
       (py-make-class
        (& "ReferenceError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 41)))))
     (vector-ref %caches 42))
    (global-put!
     %global
     (& "RuntimeError")
     (begin
       (begin #f)
       (py-make-class
        (& "RuntimeError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 43)))))
     (vector-ref %caches 44))
    (global-put!
     %global
     (& "StopAsyncIteration")
     (begin
       (begin #f)
       (py-make-class
        (& "StopAsyncIteration")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 45)))))
     (vector-ref %caches 46))
    (global-put!
     %global
     (& "StopIteration")
     (begin
       (begin #f)
       (py-make-class
        (& "StopIteration")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 47)))))
     (vector-ref %caches 48))
    (global-put!
     %global
     (& "SyntaxError")
     (begin
       (begin #f)
       (py-make-class
        (& "SyntaxError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 49)))))
     (vector-ref %caches 50))
    (global-put!
     %global
     (& "SystemError")
     (begin
       (begin #f)
       (py-make-class
        (& "SystemError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 51)))))
     (vector-ref %caches 52))
    (global-put!
     %global
     (& "TypeError")
     (begin
       (begin #f)
       (py-make-class
        (& "TypeError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 53)))))
     (vector-ref %caches 54))
    (global-put!
     %global
     (& "ValueError")
     (begin
       (begin #f)
       (py-make-class
        (& "ValueError")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 55)))))
     (vector-ref %caches 56))
    (global-put!
     %global
     (& "Warning")
     (begin
       (begin #f)
       (py-make-class
        (& "Warning")
        (& "__main__")
        (list (global-get %global (& "Exception") (vector-ref %caches 57)))))
     (vector-ref %caches 58))
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
               (vector-ref %caches 59)))))
     (vector-ref %caches 60))
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
               (vector-ref %caches 61)))))
     (vector-ref %caches 62))
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
               (vector-ref %caches 63)))))
     (vector-ref %caches 64))
    (global-put!
     %global
     (& "ModuleNotFoundError")
     (begin
       (begin #f)
       (py-make-class
        (& "ModuleNotFoundError")
        (& "__main__")
        (list (global-get %global (& "ImportError") (vector-ref %caches 65)))))
     (vector-ref %caches 66))
    (global-put!
     %global
     (& "IndexError")
     (begin
       (begin #f)
       (py-make-class
        (& "IndexError")
        (& "__main__")
        (list (global-get %global (& "LookupError") (vector-ref %caches 67)))))
     (vector-ref %caches 68))
    (global-put!
     %global
     (& "KeyError")
     (begin
       (begin #f)
       (py-make-class
        (& "KeyError")
        (& "__main__")
        (list (global-get %global (& "LookupError") (vector-ref %caches 69)))))
     (vector-ref %caches 70))
    (global-put!
     %global
     (& "UnboundLocalError")
     (begin
       (begin #f)
       (py-make-class
        (& "UnboundLocalError")
        (& "__main__")
        (list (global-get %global (& "NameError") (vector-ref %caches 71)))))
     (vector-ref %caches 72))
    (global-put!
     %global
     (& "BlockingIOError")
     (begin
       (begin #f)
       (py-make-class
        (& "BlockingIOError")
        (& "__main__")
        (list (global-get %global (& "OSError") (vector-ref %caches 73)))))
     (vector-ref %caches 74))
    (global-put!
     %global
     (& "ChildProcessError")
     (begin
       (begin #f)
       (py-make-class
        (& "ChildProcessError")
        (& "__main__")
        (list (global-get %global (& "OSError") (vector-ref %caches 75)))))
     (vector-ref %caches 76))
    (global-put!
     %global
     (& "ConnectionError")
     (begin
       (begin #f)
       (py-make-class
        (& "ConnectionError")
        (& "__main__")
        (list (global-get %global (& "OSError") (vector-ref %caches 77)))))
     (vector-ref %caches 78))
    (global-put!
     %global
     (& "FileExistsError")
     (begin
       (begin #f)
       (py-make-class
        (& "FileExistsError")
        (& "__main__")
        (list (global-get %global (& "OSError") (vector-ref %caches 79)))))
     (vector-ref %caches 80))
    (global-put!
     %global
     (& "FileNotFoundError")
     (begin
       (begin #f)
       (py-make-class
        (& "FileNotFoundError")
        (& "__main__")
        (list (global-get %global (& "OSError") (vector-ref %caches 81)))))
     (vector-ref %caches 82))
    (global-put!
     %global
     (& "InterruptedError")
     (begin
       (begin #f)
       (py-make-class
        (& "InterruptedError")
        (& "__main__")
        (list (global-get %global (& "OSError") (vector-ref %caches 83)))))
     (vector-ref %caches 84))
    (global-put!
     %global
     (& "IsADirectoryError")
     (begin
       (begin #f)
       (py-make-class
        (& "IsADirectoryError")
        (& "__main__")
        (list (global-get %global (& "OSError") (vector-ref %caches 85)))))
     (vector-ref %caches 86))
    (global-put!
     %global
     (& "NotADirectoryError")
     (begin
       (begin #f)
       (py-make-class
        (& "NotADirectoryError")
        (& "__main__")
        (list (global-get %global (& "OSError") (vector-ref %caches 87)))))
     (vector-ref %caches 88))
    (global-put!
     %global
     (& "PermissionError")
     (begin
       (begin #f)
       (py-make-class
        (& "PermissionError")
        (& "__main__")
        (list (global-get %global (& "OSError") (vector-ref %caches 89)))))
     (vector-ref %caches 90))
    (global-put!
     %global
     (& "ProcessLookupError")
     (begin
       (begin #f)
       (py-make-class
        (& "ProcessLookupError")
        (& "__main__")
        (list (global-get %global (& "OSError") (vector-ref %caches 91)))))
     (vector-ref %caches 92))
    (global-put!
     %global
     (& "TimeoutError")
     (begin
       (begin #f)
       (py-make-class
        (& "TimeoutError")
        (& "__main__")
        (list (global-get %global (& "OSError") (vector-ref %caches 93)))))
     (vector-ref %caches 94))
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
               (vector-ref %caches 95)))))
     (vector-ref %caches 96))
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
               (vector-ref %caches 97)))))
     (vector-ref %caches 98))
    (global-put!
     %global
     (& "IndentationError")
     (begin
       (begin #f)
       (py-make-class
        (& "IndentationError")
        (& "__main__")
        (list (global-get %global (& "SyntaxError") (vector-ref %caches 99)))))
     (vector-ref %caches 100))
    (global-put!
     %global
     (& "UnicodeError")
     (begin
       (begin #f)
       (py-make-class
        (& "UnicodeError")
        (& "__main__")
        (list (global-get %global (& "ValueError") (vector-ref %caches 101)))))
     (vector-ref %caches 102))
    (global-put!
     %global
     (& "BytesWarning")
     (begin
       (begin #f)
       (py-make-class
        (& "BytesWarning")
        (& "__main__")
        (list (global-get %global (& "Warning") (vector-ref %caches 103)))))
     (vector-ref %caches 104))
    (global-put!
     %global
     (& "DeprecationWarning")
     (begin
       (begin #f)
       (py-make-class
        (& "DeprecationWarning")
        (& "__main__")
        (list (global-get %global (& "Warning") (vector-ref %caches 105)))))
     (vector-ref %caches 106))
    (global-put!
     %global
     (& "FutureWarning")
     (begin
       (begin #f)
       (py-make-class
        (& "FutureWarning")
        (& "__main__")
        (list (global-get %global (& "Warning") (vector-ref %caches 107)))))
     (vector-ref %caches 108))
    (global-put!
     %global
     (& "ImportWarning")
     (begin
       (begin #f)
       (py-make-class
        (& "ImportWarning")
        (& "__main__")
        (list (global-get %global (& "Warning") (vector-ref %caches 109)))))
     (vector-ref %caches 110))
    (global-put!
     %global
     (& "PendingDeprecationWarning")
     (begin
       (begin #f)
       (py-make-class
        (& "PendingDeprecationWarning")
        (& "__main__")
        (list (global-get %global (& "Warning") (vector-ref %caches 111)))))
     (vector-ref %caches 112))
    (global-put!
     %global
     (& "ResourceWarning")
     (begin
       (begin #f)
       (py-make-class
        (& "ResourceWarning")
        (& "__main__")
        (list (global-get %global (& "Warning") (vector-ref %caches 113)))))
     (vector-ref %caches 114))
    (global-put!
     %global
     (& "RuntimeWarning")
     (begin
       (begin #f)
       (py-make-class
        (& "RuntimeWarning")
        (& "__main__")
        (list (global-get %global (& "Warning") (vector-ref %caches 115)))))
     (vector-ref %caches 116))
    (global-put!
     %global
     (& "SyntaxWarning")
     (begin
       (begin #f)
       (py-make-class
        (& "SyntaxWarning")
        (& "__main__")
        (list (global-get %global (& "Warning") (vector-ref %caches 117)))))
     (vector-ref %caches 118))
    (global-put!
     %global
     (& "UnicodeWarning")
     (begin
       (begin #f)
       (py-make-class
        (& "UnicodeWarning")
        (& "__main__")
        (list (global-get %global (& "Warning") (vector-ref %caches 119)))))
     (vector-ref %caches 120))
    (global-put!
     %global
     (& "UserWarning")
     (begin
       (begin #f)
       (py-make-class
        (& "UserWarning")
        (& "__main__")
        (list (global-get %global (& "Warning") (vector-ref %caches 121)))))
     (vector-ref %caches 122))
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
               (vector-ref %caches 123)))))
     (vector-ref %caches 124))
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
               (vector-ref %caches 125)))))
     (vector-ref %caches 126))
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
               (vector-ref %caches 127)))))
     (vector-ref %caches 128))
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
               (vector-ref %caches 129)))))
     (vector-ref %caches 130))
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
               (vector-ref %caches 131)))))
     (vector-ref %caches 132))
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
               (vector-ref %caches 133)))))
     (vector-ref %caches 134))
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
               (vector-ref %caches 135)))))
     (vector-ref %caches 136))
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
               (vector-ref %caches 137)))))
     (vector-ref %caches 138))))
(lambda ()
  (let ((global (py-make-base-global)) (caches (py-make-caches 139)))
    (py-module global caches)
    global))
