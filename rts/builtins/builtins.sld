(define-library
 (builtins)
 (export init
         init-builtin-module
         &py-builtin-UnicodeTranslateError
         &py-builtin-UnicodeEncodeError
         &py-builtin-UnicodeDecodeError
         &py-builtin-TabError
         &py-builtin-ConnectionResetError
         &py-builtin-ConnectionRefusedError
         &py-builtin-ConnectionAbortedError
         &py-builtin-BrokenPipeError
         &py-builtin-UserWarning
         &py-builtin-UnicodeWarning
         &py-builtin-SyntaxWarning
         &py-builtin-RuntimeWarning
         &py-builtin-ResourceWarning
         &py-builtin-PendingDeprecationWarning
         &py-builtin-ImportWarning
         &py-builtin-FutureWarning
         &py-builtin-DeprecationWarning
         &py-builtin-BytesWarning
         &py-builtin-UnicodeError
         &py-builtin-IndentationError
         &py-builtin-RecursionError
         &py-builtin-TimeoutError
         &py-builtin-ProcessLookupError
         &py-builtin-PermissionError
         &py-builtin-NotADirectoryError
         &py-builtin-IsADirectoryError
         &py-builtin-InterruptedError
         &py-builtin-FileNotFoundError
         &py-builtin-FileExistsError
         &py-builtin-ConnectionError
         &py-builtin-ChildProcessError
         &py-builtin-BlockingIOError
         &py-builtin-UnboundLocalError
         &py-builtin-KeyError
         &py-builtin-IndexError
         &py-builtin-ModuleNotFoundError
         &py-builtin-OverflowError
         &py-builtin-FloatingPointError
         &py-builtin-Warning
         &py-builtin-SystemError
         &py-builtin-SyntaxError
         &py-builtin-StopAsyncIteration
         &py-builtin-RuntimeError
         &py-builtin-ReferenceError
         &py-builtin-WindowsError
         &py-builtin-OSError
         &py-builtin-IOError
         &py-builtin-EnvironmentError
         &py-builtin-NameError
         &py-builtin-MemoryError
         &py-builtin-LookupError
         &py-builtin-ImportError
         &py-builtin-EOFError
         &py-builtin-BufferError
         &py-builtin-AttributeError
         &py-builtin-AssertionError
         &py-builtin-ArithmeticError
         &py-builtin-SystemExit
         &py-builtin-KeyboardInterrupt
         &py-builtin-GeneratorExit
         &py-builtin-Exception
         &py-builtin-BaseException
         &py-builtin-sorted
         &py-builtin-range
         &py-builtin-StopIteration
         &py-builtin-str
         &py-builtin-float
         &py-builtin-bool
         &py-builtin-ZeroDivisionError
         &py-builtin-ValueError
         &py-builtin-TypeError
         &py-builtin-NotImplementedError
         &py-builtin-int)
 (import (gambit) (zipi rts))
 (begin
   (py-begin-module)
   (define procedure:&py-builtin-__merge
     (lambda (l1-196 l2-197)
       (letrec* ((output-1470 #f) (i-1468 #f) (j-1466 #f))
         (begin
           (&& "\n    Merge all items from two sorted list into one sorted list.\n    Time complexity: O(n) where n is the total number of elements\n    ")
           (letrec* ((%tmp0-198 (py-int-from-scheme 0)))
             (begin
               (set! j-1466
                     (or %tmp0-198
                         (py-throw-exception-with-message
                          py-builtin-UnboundLocalError
                          "local variable '%tmp0' referenced before assignment")))
               (set! i-1468
                     (or %tmp0-198
                         (py-throw-exception-with-message
                          py-builtin-UnboundLocalError
                          "local variable '%tmp0' referenced before assignment")))))
           (set! output-1470 (py-make-list))
           (let $%while_77 ()
             (when (and
                    (py-test (py-lt (or i-1468
                                        (py-throw-exception-with-message
                                         py-builtin-UnboundLocalError
                                         "local variable 'i' referenced before assignment"))
                                    (py-call (global-get
                                              %global
                                              (& "len")
                                              (vector-ref %caches 544))
                                             l1-196)))
                    (py-test (py-lt (or j-1466
                                        (py-throw-exception-with-message
                                         py-builtin-UnboundLocalError
                                         "local variable 'j' referenced before assignment"))
                                    (py-call (global-get
                                              %global
                                              (& "len")
                                              (vector-ref %caches 545))
                                             l2-197))))
               (if (py-test (py-le (py-getitem
                                    l1-196
                                    (or i-1468
                                        (py-throw-exception-with-message
                                         py-builtin-UnboundLocalError
                                         "local variable 'i' referenced before assignment")))
                                   (py-getitem
                                    l2-197
                                    (or j-1466
                                        (py-throw-exception-with-message
                                         py-builtin-UnboundLocalError
                                         "local variable 'j' referenced before assignment")))))
                   (begin
                     (py-call (py-getattribute output-1470 (& "append"))
                              (py-getitem
                               l1-196
                               (or i-1468
                                   (py-throw-exception-with-message
                                    py-builtin-UnboundLocalError
                                    "local variable 'i' referenced before assignment"))))
                     (set! i-1468
                           (py-iadd (or i-1468
                                        (py-throw-exception-with-message
                                         py-builtin-UnboundLocalError
                                         "local variable 'i' referenced before assignment"))
                                    (py-int-from-scheme 1))))
                   (begin
                     (py-call (py-getattribute output-1470 (& "append"))
                              (py-getitem
                               l2-197
                               (or j-1466
                                   (py-throw-exception-with-message
                                    py-builtin-UnboundLocalError
                                    "local variable 'j' referenced before assignment"))))
                     (set! j-1466
                           (py-iadd (or j-1466
                                        (py-throw-exception-with-message
                                         py-builtin-UnboundLocalError
                                         "local variable 'j' referenced before assignment"))
                                    (py-int-from-scheme 1)))))
               ($%while_77)))
           (py-call (py-getattribute output-1470 (& "extend"))
                    (py-add (py-getitem
                             l1-196
                             (py-slice-from-scheme
                              (or i-1468
                                  (py-throw-exception-with-message
                                   py-builtin-UnboundLocalError
                                   "local variable 'i' referenced before assignment"))
                              py-None
                              py-None))
                            (py-getitem
                             l2-197
                             (py-slice-from-scheme
                              (or j-1466
                                  (py-throw-exception-with-message
                                   py-builtin-UnboundLocalError
                                   "local variable 'j' referenced before assignment"))
                              py-None
                              py-None))))
           output-1470))))
   (define procedure:&py-builtin-__merge_many
     (lambda (lsts-199)
       (letrec* ((right-1480 #f) (left-1478 #f))
         (begin
           (&& "\n    Merge all items from k lists into one sorted list.\n    Time complexity: O(n log(k)) where n is the total number of elements and k the number of lists\n    ")
           (if (py-test (py-not lsts-199))
               (py-make-list)
               (if (py-test (py-eq (py-call (global-get
                                             %global
                                             (& "len")
                                             (vector-ref %caches 553))
                                            lsts-199)
                                   (py-int-from-scheme 1)))
                   (py-getitem
                    (py-getitem lsts-199 (py-int-from-scheme 0))
                    (py-slice-from-scheme py-None py-None py-None))
                   (if (py-test (py-eq (py-call (global-get
                                                 %global
                                                 (& "len")
                                                 (vector-ref %caches 554))
                                                lsts-199)
                                       (py-int-from-scheme 2)))
                       (procedure:&py-builtin-__merge
                        (py-getitem lsts-199 (py-int-from-scheme 0))
                        (py-getitem lsts-199 (py-int-from-scheme 1)))
                       (begin
                         (set! left-1478
                               (py-getitem
                                lsts-199
                                (py-slice-from-scheme
                                 (py-floordiv
                                  (py-call (global-get
                                            %global
                                            (& "len")
                                            (vector-ref %caches 556))
                                           lsts-199)
                                  (py-int-from-scheme 2))
                                 py-None
                                 py-None)))
                         (set! right-1480
                               (py-getitem
                                lsts-199
                                (py-slice-from-scheme
                                 py-None
                                 (py-floordiv
                                  (py-call (global-get
                                            %global
                                            (& "len")
                                            (vector-ref %caches 557))
                                           lsts-199)
                                  (py-int-from-scheme 2))
                                 py-None)))
                         (procedure:&py-builtin-__merge
                          (procedure:&py-builtin-__merge_many left-1478)
                          (procedure:&py-builtin-__merge_many
                           right-1480))))))))))
   (define procedure:&py-builtin-sorted
     (lambda (lst-200 key-201 reversed-202)
       (letrec* ((i-1485 #f) (sublsts-1483 #f))
         (begin
           (&& "\n    Timsort is an improved version of Merge Sort which splits the list into monotonic sub-lists before merging them\n    into a sorted list.\n    Worst case time complexity: O(n log(n))\n    Best cast time complexity:  O(n) when the list is almost sorted\n        where n is the number of elements in the list\n    ")
           (set! sublsts-1483 (py-make-list))
           (set! i-1485 (py-int-from-scheme 0))
           (let $%while_78 ()
             (when (py-test
                    (py-lt i-1485
                           (py-call (global-get
                                     %global
                                     (& "len")
                                     (vector-ref %caches 562))
                                    lst-200)))
               (begin
                 (py-call (py-getattribute sublsts-1483 (& "append"))
                          (py-make-list (py-getitem lst-200 i-1485)))
                 (set! i-1485
                       (py-iadd (or i-1485
                                    (py-throw-exception-with-message
                                     py-builtin-UnboundLocalError
                                     "local variable 'i' referenced before assignment"))
                                (py-int-from-scheme 1)))
                 (if (and (py-test (py-lt i-1485
                                          (py-call (global-get
                                                    %global
                                                    (& "len")
                                                    (vector-ref %caches 565))
                                                   lst-200)))
                          (py-test (py-ge (py-getitem lst-200 i-1485)
                                          (py-getitem
                                           lst-200
                                           (py-sub i-1485
                                                   (py-int-from-scheme 1))))))
                     (let $%while_79 ()
                       (when (and
                              (py-test (py-lt i-1485
                                              (py-call (global-get
                                                        %global
                                                        (& "len")
                                                        (vector-ref
                                                         %caches
                                                         566))
                                                       lst-200)))
                              (py-test (py-ge (py-getitem lst-200 i-1485)
                                              (py-getitem
                                               lst-200
                                               (py-sub i-1485
                                                       (py-int-from-scheme
                                                        1))))))
                         (begin
                           (py-call (py-getattribute
                                     (py-getitem
                                      sublsts-1483
                                      (py-neg (py-int-from-scheme 1)))
                                     (& "append"))
                                    (py-getitem lst-200 i-1485))
                           (set! i-1485
                                 (py-iadd (or i-1485
                                              (py-throw-exception-with-message
                                               py-builtin-UnboundLocalError
                                               "local variable 'i' referenced before assignment"))
                                          (py-int-from-scheme 1))))
                         ($%while_79)))
                     (if (py-test (py-lt i-1485
                                         (py-call (global-get
                                                   %global
                                                   (& "len")
                                                   (vector-ref %caches 570))
                                                  lst-200)))
                         (begin
                           (let $%while_80 ()
                             (when (and
                                    (py-test (py-lt i-1485
                                                    (py-call (global-get
                                                              %global
                                                              (& "len")
                                                              (vector-ref
                                                               %caches
                                                               571))
                                                             lst-200)))
                                    (py-test (py-lt (py-getitem lst-200 i-1485)
                                                    (py-getitem
                                                     lst-200
                                                     (py-sub i-1485
                                                             (py-int-from-scheme
                                                              1))))))
                               (begin
                                 (py-call (py-getattribute
                                           (py-getitem
                                            sublsts-1483
                                            (py-neg (py-int-from-scheme 1)))
                                           (& "append"))
                                          (py-getitem lst-200 i-1485))
                                 (set! i-1485
                                       (py-iadd (or i-1485
                                                    (py-throw-exception-with-message
                                                     py-builtin-UnboundLocalError
                                                     "local variable 'i' referenced before assignment"))
                                                (py-int-from-scheme 1))))
                               ($%while_80)))
                           (py-setitem
                            (or sublsts-1483
                                (py-throw-exception-with-message
                                 py-builtin-UnboundLocalError
                                 "local variable 'sublsts' referenced before assignment"))
                            (py-neg (py-int-from-scheme 1))
                            (py-getitem
                             (py-getitem
                              (or sublsts-1483
                                  (py-throw-exception-with-message
                                   py-builtin-UnboundLocalError
                                   "local variable 'sublsts' referenced before assignment"))
                              (py-neg (py-int-from-scheme 1)))
                             (py-slice-from-scheme
                              py-None
                              py-None
                              (py-neg (py-int-from-scheme 1))))))
                         #f)))
               ($%while_78)))
           (procedure:&py-builtin-__merge_many sublsts-1483)))))
   (declare (separate))
   (define %global #f)
   (define %caches #f)
   (define init:&py-builtin-__merge #f)
   (define init:&py-builtin-__merge_many #f)
   (define init:&py-builtin-sorted #f)
   (define &py-builtin-UnicodeTranslateError py-absent)
   (define &py-builtin-UnicodeEncodeError py-absent)
   (define &py-builtin-UnicodeDecodeError py-absent)
   (define &py-builtin-TabError py-absent)
   (define &py-builtin-ConnectionResetError py-absent)
   (define &py-builtin-ConnectionRefusedError py-absent)
   (define &py-builtin-ConnectionAbortedError py-absent)
   (define &py-builtin-BrokenPipeError py-absent)
   (define &py-builtin-UserWarning py-absent)
   (define &py-builtin-UnicodeWarning py-absent)
   (define &py-builtin-SyntaxWarning py-absent)
   (define &py-builtin-RuntimeWarning py-absent)
   (define &py-builtin-ResourceWarning py-absent)
   (define &py-builtin-PendingDeprecationWarning py-absent)
   (define &py-builtin-ImportWarning py-absent)
   (define &py-builtin-FutureWarning py-absent)
   (define &py-builtin-DeprecationWarning py-absent)
   (define &py-builtin-BytesWarning py-absent)
   (define &py-builtin-UnicodeError py-absent)
   (define &py-builtin-IndentationError py-absent)
   (define &py-builtin-RecursionError py-absent)
   (define &py-builtin-TimeoutError py-absent)
   (define &py-builtin-ProcessLookupError py-absent)
   (define &py-builtin-PermissionError py-absent)
   (define &py-builtin-NotADirectoryError py-absent)
   (define &py-builtin-IsADirectoryError py-absent)
   (define &py-builtin-InterruptedError py-absent)
   (define &py-builtin-FileNotFoundError py-absent)
   (define &py-builtin-FileExistsError py-absent)
   (define &py-builtin-ConnectionError py-absent)
   (define &py-builtin-ChildProcessError py-absent)
   (define &py-builtin-BlockingIOError py-absent)
   (define &py-builtin-UnboundLocalError py-absent)
   (define &py-builtin-KeyError py-absent)
   (define &py-builtin-IndexError py-absent)
   (define &py-builtin-ModuleNotFoundError py-absent)
   (define &py-builtin-OverflowError py-absent)
   (define &py-builtin-FloatingPointError py-absent)
   (define &py-builtin-Warning py-absent)
   (define &py-builtin-SystemError py-absent)
   (define &py-builtin-SyntaxError py-absent)
   (define &py-builtin-StopAsyncIteration py-absent)
   (define &py-builtin-RuntimeError py-absent)
   (define &py-builtin-ReferenceError py-absent)
   (define &py-builtin-WindowsError py-absent)
   (define &py-builtin-OSError py-absent)
   (define &py-builtin-IOError py-absent)
   (define &py-builtin-EnvironmentError py-absent)
   (define &py-builtin-NameError py-absent)
   (define &py-builtin-MemoryError py-absent)
   (define &py-builtin-LookupError py-absent)
   (define &py-builtin-ImportError py-absent)
   (define &py-builtin-EOFError py-absent)
   (define &py-builtin-BufferError py-absent)
   (define &py-builtin-AttributeError py-absent)
   (define &py-builtin-AssertionError py-absent)
   (define &py-builtin-ArithmeticError py-absent)
   (define &py-builtin-SystemExit py-absent)
   (define &py-builtin-KeyboardInterrupt py-absent)
   (define &py-builtin-GeneratorExit py-absent)
   (define &py-builtin-Exception py-absent)
   (define &py-builtin-BaseException py-absent)
   (define &py-builtin-sorted py-absent)
   (define &py-builtin-__merge_many py-absent)
   (define &py-builtin-__merge py-absent)
   (define &py-builtin-range py-absent)
   (define &py-builtin-StopIteration py-absent)
   (define &py-builtin-range_iterator py-absent)
   (define &py-builtin-str py-absent)
   (define &py-builtin-float py-absent)
   (define &py-builtin-bool py-absent)
   (define &py-builtin-ZeroDivisionError py-absent)
   (define &py-builtin-ValueError py-absent)
   (define &py-builtin-TypeError py-absent)
   (define &py-builtin-NotImplementedError py-absent)
   (define &py-builtin-int py-absent)
   (declare (block))
   (define (py-module global caches)
     (set! %global global)
     (set! %caches caches)
     (global-register!
      %global
      (& "UnicodeTranslateError")
      (lambda () &py-builtin-UnicodeTranslateError)
      (lambda (v) (set! &py-builtin-UnicodeTranslateError v)))
     (global-register!
      %global
      (& "UnicodeEncodeError")
      (lambda () &py-builtin-UnicodeEncodeError)
      (lambda (v) (set! &py-builtin-UnicodeEncodeError v)))
     (global-register!
      %global
      (& "UnicodeDecodeError")
      (lambda () &py-builtin-UnicodeDecodeError)
      (lambda (v) (set! &py-builtin-UnicodeDecodeError v)))
     (global-register!
      %global
      (& "TabError")
      (lambda () &py-builtin-TabError)
      (lambda (v) (set! &py-builtin-TabError v)))
     (global-register!
      %global
      (& "ConnectionResetError")
      (lambda () &py-builtin-ConnectionResetError)
      (lambda (v) (set! &py-builtin-ConnectionResetError v)))
     (global-register!
      %global
      (& "ConnectionRefusedError")
      (lambda () &py-builtin-ConnectionRefusedError)
      (lambda (v) (set! &py-builtin-ConnectionRefusedError v)))
     (global-register!
      %global
      (& "ConnectionAbortedError")
      (lambda () &py-builtin-ConnectionAbortedError)
      (lambda (v) (set! &py-builtin-ConnectionAbortedError v)))
     (global-register!
      %global
      (& "BrokenPipeError")
      (lambda () &py-builtin-BrokenPipeError)
      (lambda (v) (set! &py-builtin-BrokenPipeError v)))
     (global-register!
      %global
      (& "UserWarning")
      (lambda () &py-builtin-UserWarning)
      (lambda (v) (set! &py-builtin-UserWarning v)))
     (global-register!
      %global
      (& "UnicodeWarning")
      (lambda () &py-builtin-UnicodeWarning)
      (lambda (v) (set! &py-builtin-UnicodeWarning v)))
     (global-register!
      %global
      (& "SyntaxWarning")
      (lambda () &py-builtin-SyntaxWarning)
      (lambda (v) (set! &py-builtin-SyntaxWarning v)))
     (global-register!
      %global
      (& "RuntimeWarning")
      (lambda () &py-builtin-RuntimeWarning)
      (lambda (v) (set! &py-builtin-RuntimeWarning v)))
     (global-register!
      %global
      (& "ResourceWarning")
      (lambda () &py-builtin-ResourceWarning)
      (lambda (v) (set! &py-builtin-ResourceWarning v)))
     (global-register!
      %global
      (& "PendingDeprecationWarning")
      (lambda () &py-builtin-PendingDeprecationWarning)
      (lambda (v) (set! &py-builtin-PendingDeprecationWarning v)))
     (global-register!
      %global
      (& "ImportWarning")
      (lambda () &py-builtin-ImportWarning)
      (lambda (v) (set! &py-builtin-ImportWarning v)))
     (global-register!
      %global
      (& "FutureWarning")
      (lambda () &py-builtin-FutureWarning)
      (lambda (v) (set! &py-builtin-FutureWarning v)))
     (global-register!
      %global
      (& "DeprecationWarning")
      (lambda () &py-builtin-DeprecationWarning)
      (lambda (v) (set! &py-builtin-DeprecationWarning v)))
     (global-register!
      %global
      (& "BytesWarning")
      (lambda () &py-builtin-BytesWarning)
      (lambda (v) (set! &py-builtin-BytesWarning v)))
     (global-register!
      %global
      (& "UnicodeError")
      (lambda () &py-builtin-UnicodeError)
      (lambda (v) (set! &py-builtin-UnicodeError v)))
     (global-register!
      %global
      (& "IndentationError")
      (lambda () &py-builtin-IndentationError)
      (lambda (v) (set! &py-builtin-IndentationError v)))
     (global-register!
      %global
      (& "RecursionError")
      (lambda () &py-builtin-RecursionError)
      (lambda (v) (set! &py-builtin-RecursionError v)))
     (global-register!
      %global
      (& "TimeoutError")
      (lambda () &py-builtin-TimeoutError)
      (lambda (v) (set! &py-builtin-TimeoutError v)))
     (global-register!
      %global
      (& "ProcessLookupError")
      (lambda () &py-builtin-ProcessLookupError)
      (lambda (v) (set! &py-builtin-ProcessLookupError v)))
     (global-register!
      %global
      (& "PermissionError")
      (lambda () &py-builtin-PermissionError)
      (lambda (v) (set! &py-builtin-PermissionError v)))
     (global-register!
      %global
      (& "NotADirectoryError")
      (lambda () &py-builtin-NotADirectoryError)
      (lambda (v) (set! &py-builtin-NotADirectoryError v)))
     (global-register!
      %global
      (& "IsADirectoryError")
      (lambda () &py-builtin-IsADirectoryError)
      (lambda (v) (set! &py-builtin-IsADirectoryError v)))
     (global-register!
      %global
      (& "InterruptedError")
      (lambda () &py-builtin-InterruptedError)
      (lambda (v) (set! &py-builtin-InterruptedError v)))
     (global-register!
      %global
      (& "FileNotFoundError")
      (lambda () &py-builtin-FileNotFoundError)
      (lambda (v) (set! &py-builtin-FileNotFoundError v)))
     (global-register!
      %global
      (& "FileExistsError")
      (lambda () &py-builtin-FileExistsError)
      (lambda (v) (set! &py-builtin-FileExistsError v)))
     (global-register!
      %global
      (& "ConnectionError")
      (lambda () &py-builtin-ConnectionError)
      (lambda (v) (set! &py-builtin-ConnectionError v)))
     (global-register!
      %global
      (& "ChildProcessError")
      (lambda () &py-builtin-ChildProcessError)
      (lambda (v) (set! &py-builtin-ChildProcessError v)))
     (global-register!
      %global
      (& "BlockingIOError")
      (lambda () &py-builtin-BlockingIOError)
      (lambda (v) (set! &py-builtin-BlockingIOError v)))
     (global-register!
      %global
      (& "UnboundLocalError")
      (lambda () &py-builtin-UnboundLocalError)
      (lambda (v) (set! &py-builtin-UnboundLocalError v)))
     (global-register!
      %global
      (& "KeyError")
      (lambda () &py-builtin-KeyError)
      (lambda (v) (set! &py-builtin-KeyError v)))
     (global-register!
      %global
      (& "IndexError")
      (lambda () &py-builtin-IndexError)
      (lambda (v) (set! &py-builtin-IndexError v)))
     (global-register!
      %global
      (& "ModuleNotFoundError")
      (lambda () &py-builtin-ModuleNotFoundError)
      (lambda (v) (set! &py-builtin-ModuleNotFoundError v)))
     (global-register!
      %global
      (& "OverflowError")
      (lambda () &py-builtin-OverflowError)
      (lambda (v) (set! &py-builtin-OverflowError v)))
     (global-register!
      %global
      (& "FloatingPointError")
      (lambda () &py-builtin-FloatingPointError)
      (lambda (v) (set! &py-builtin-FloatingPointError v)))
     (global-register!
      %global
      (& "Warning")
      (lambda () &py-builtin-Warning)
      (lambda (v) (set! &py-builtin-Warning v)))
     (global-register!
      %global
      (& "SystemError")
      (lambda () &py-builtin-SystemError)
      (lambda (v) (set! &py-builtin-SystemError v)))
     (global-register!
      %global
      (& "SyntaxError")
      (lambda () &py-builtin-SyntaxError)
      (lambda (v) (set! &py-builtin-SyntaxError v)))
     (global-register!
      %global
      (& "StopAsyncIteration")
      (lambda () &py-builtin-StopAsyncIteration)
      (lambda (v) (set! &py-builtin-StopAsyncIteration v)))
     (global-register!
      %global
      (& "RuntimeError")
      (lambda () &py-builtin-RuntimeError)
      (lambda (v) (set! &py-builtin-RuntimeError v)))
     (global-register!
      %global
      (& "ReferenceError")
      (lambda () &py-builtin-ReferenceError)
      (lambda (v) (set! &py-builtin-ReferenceError v)))
     (global-register!
      %global
      (& "WindowsError")
      (lambda () &py-builtin-WindowsError)
      (lambda (v) (set! &py-builtin-WindowsError v)))
     (global-register!
      %global
      (& "OSError")
      (lambda () &py-builtin-OSError)
      (lambda (v) (set! &py-builtin-OSError v)))
     (global-register!
      %global
      (& "IOError")
      (lambda () &py-builtin-IOError)
      (lambda (v) (set! &py-builtin-IOError v)))
     (global-register!
      %global
      (& "EnvironmentError")
      (lambda () &py-builtin-EnvironmentError)
      (lambda (v) (set! &py-builtin-EnvironmentError v)))
     (global-register!
      %global
      (& "NameError")
      (lambda () &py-builtin-NameError)
      (lambda (v) (set! &py-builtin-NameError v)))
     (global-register!
      %global
      (& "MemoryError")
      (lambda () &py-builtin-MemoryError)
      (lambda (v) (set! &py-builtin-MemoryError v)))
     (global-register!
      %global
      (& "LookupError")
      (lambda () &py-builtin-LookupError)
      (lambda (v) (set! &py-builtin-LookupError v)))
     (global-register!
      %global
      (& "ImportError")
      (lambda () &py-builtin-ImportError)
      (lambda (v) (set! &py-builtin-ImportError v)))
     (global-register!
      %global
      (& "EOFError")
      (lambda () &py-builtin-EOFError)
      (lambda (v) (set! &py-builtin-EOFError v)))
     (global-register!
      %global
      (& "BufferError")
      (lambda () &py-builtin-BufferError)
      (lambda (v) (set! &py-builtin-BufferError v)))
     (global-register!
      %global
      (& "AttributeError")
      (lambda () &py-builtin-AttributeError)
      (lambda (v) (set! &py-builtin-AttributeError v)))
     (global-register!
      %global
      (& "AssertionError")
      (lambda () &py-builtin-AssertionError)
      (lambda (v) (set! &py-builtin-AssertionError v)))
     (global-register!
      %global
      (& "ArithmeticError")
      (lambda () &py-builtin-ArithmeticError)
      (lambda (v) (set! &py-builtin-ArithmeticError v)))
     (global-register!
      %global
      (& "SystemExit")
      (lambda () &py-builtin-SystemExit)
      (lambda (v) (set! &py-builtin-SystemExit v)))
     (global-register!
      %global
      (& "KeyboardInterrupt")
      (lambda () &py-builtin-KeyboardInterrupt)
      (lambda (v) (set! &py-builtin-KeyboardInterrupt v)))
     (global-register!
      %global
      (& "GeneratorExit")
      (lambda () &py-builtin-GeneratorExit)
      (lambda (v) (set! &py-builtin-GeneratorExit v)))
     (global-register!
      %global
      (& "Exception")
      (lambda () &py-builtin-Exception)
      (lambda (v) (set! &py-builtin-Exception v)))
     (global-register!
      %global
      (& "BaseException")
      (lambda () &py-builtin-BaseException)
      (lambda (v) (set! &py-builtin-BaseException v)))
     (global-register!
      %global
      (& "sorted")
      (lambda () &py-builtin-sorted)
      (lambda (v) (set! &py-builtin-sorted v)))
     (global-register!
      %global
      (& "range")
      (lambda () &py-builtin-range)
      (lambda (v) (set! &py-builtin-range v)))
     (global-register!
      %global
      (& "StopIteration")
      (lambda () &py-builtin-StopIteration)
      (lambda (v) (set! &py-builtin-StopIteration v)))
     (global-register!
      %global
      (& "str")
      (lambda () &py-builtin-str)
      (lambda (v) (set! &py-builtin-str v)))
     (global-register!
      %global
      (& "float")
      (lambda () &py-builtin-float)
      (lambda (v) (set! &py-builtin-float v)))
     (global-register!
      %global
      (& "bool")
      (lambda () &py-builtin-bool)
      (lambda (v) (set! &py-builtin-bool v)))
     (global-register!
      %global
      (& "ZeroDivisionError")
      (lambda () &py-builtin-ZeroDivisionError)
      (lambda (v) (set! &py-builtin-ZeroDivisionError v)))
     (global-register!
      %global
      (& "ValueError")
      (lambda () &py-builtin-ValueError)
      (lambda (v) (set! &py-builtin-ValueError v)))
     (global-register!
      %global
      (& "TypeError")
      (lambda () &py-builtin-TypeError)
      (lambda (v) (set! &py-builtin-TypeError v)))
     (global-register!
      %global
      (& "NotImplementedError")
      (lambda () &py-builtin-NotImplementedError)
      (lambda (v) (set! &py-builtin-NotImplementedError v)))
     (global-register!
      %global
      (& "int")
      (lambda () &py-builtin-int)
      (lambda (v) (set! &py-builtin-int v)))
     (set! &py-builtin-int
           (let (($%cls_0 py-absent))
             (letrec* ((__lt__-392 #f)
                       (__le__-390 #f)
                       (__gt__-388 #f)
                       (__ge__-386 #f)
                       (__ne__-384 #f)
                       (__eq__-382 #f)
                       (__imod__-380 #f)
                       (__rmod__-378 #f)
                       (__mod__-376 #f)
                       (__itruediv__-374 #f)
                       (__rtruediv__-372 #f)
                       (__truediv__-370 #f)
                       (__ifloordiv__-368 #f)
                       (__rfloordiv__-366 #f)
                       (__floordiv__-364 #f)
                       (__invert__-362 #f)
                       (__neg__-360 #f)
                       (__pos__-358 #f)
                       (__irshift__-356 #f)
                       (__rrshift__-354 #f)
                       (__rshift__-352 #f)
                       (__ilshift__-350 #f)
                       (__rlshift__-348 #f)
                       (__lshift__-346 #f)
                       (__ixor__-344 #f)
                       (__rxor__-342 #f)
                       (__xor__-340 #f)
                       (__isub__-338 #f)
                       (__rsub__-336 #f)
                       (__sub__-334 #f)
                       (__ipow__-332 #f)
                       (__rpow__-330 #f)
                       (__pow__-328 #f)
                       (__imul__-326 #f)
                       (__rmul__-324 #f)
                       (__mul__-322 #f)
                       (__ior__-320 #f)
                       (__ror__-318 #f)
                       (__or__-316 #f)
                       (__iand__-314 #f)
                       (__rand__-312 #f)
                       (__and__-310 #f)
                       (__iadd__-308 #f)
                       (__radd__-306 #f)
                       (__add__-304 #f)
                       (__index__-302 #f)
                       (__bool__-300 #f)
                       (__new__-296 #f))
               (begin
                 (set! __new__-296
                       (py-call (global-get
                                 %global
                                 (& "staticmethod")
                                 (vector-ref %caches 5))
                                (procedure->py-function
                                 (lambda (cls-2 val-3)
                                   (bind-exit
                                    ($%return_73)
                                    (letrec* ()
                                      (if (py-test (py-is cls-2
                                                          &py-builtin-int))
                                          (begin
                                            (if (py-test (py-is val-3
                                                                py-absent))
                                                ($%return_73
                                                 (py-int-from-scheme 0))
                                                #f)
                                            (if (py-isinstance?
                                                 val-3
                                                 &py-builtin-int)
                                                (py-int-from-scheme
                                                 (py-int-to-scheme val-3))
                                                (py-throw
                                                 &py-builtin-NotImplementedError)))
                                          (py-throw
                                           &py-builtin-NotImplementedError)))))
                                 (make-signature
                                  args:
                                  (cls val)
                                  defaults:
                                  (vector py-absent)))))
                 (set! __bool__-300
                       (procedure->py-function
                        (lambda (self-4)
                          (letrec* ()
                            (if (py-isinstance? self-4 &py-builtin-int)
                                (py-ne self-4 (py-int-from-scheme 0))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__bool__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-4)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __index__-302
                       (procedure->py-function
                        (lambda (self-5)
                          (letrec* ()
                            (if (py-isinstance? self-5 &py-builtin-int)
                                (py-int-from-scheme (py-int-to-scheme self-5))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__index__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-5)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __add__-304
                       (procedure->py-function
                        (lambda (self-6 other-7)
                          (letrec* ()
                            (if (py-isinstance? self-6 &py-builtin-int)
                                (if (py-isinstance? other-7 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py+ (py-int-to-scheme self-6)
                                          (py-int-to-scheme other-7)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 14)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__add__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-6)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __radd__-306
                       (procedure->py-function
                        (lambda (self-8 other-9)
                          (letrec* ()
                            (if (py-isinstance? self-8 &py-builtin-int)
                                (if (py-isinstance? other-9 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py+ (py-int-to-scheme other-9)
                                          (py-int-to-scheme self-8)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 19)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__radd__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-8)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __iadd__-308
                       (procedure->py-function
                        (lambda (self-10 other-11)
                          (letrec* ()
                            (if (py-isinstance? self-10 &py-builtin-int)
                                (if (py-isinstance? other-11 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py+ (py-int-to-scheme self-10)
                                          (py-int-to-scheme other-11)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 24)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__iadd__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-10)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __and__-310
                       (procedure->py-function
                        (lambda (self-12 other-13)
                          (letrec* ()
                            (if (py-isinstance? self-12 &py-builtin-int)
                                (if (py-isinstance? other-13 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py& (py-int-to-scheme self-12)
                                          (py-int-to-scheme other-13)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 29)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__and__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-12)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rand__-312
                       (procedure->py-function
                        (lambda (self-14 other-15)
                          (letrec* ()
                            (if (py-isinstance? self-14 &py-builtin-int)
                                (if (py-isinstance? other-15 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py& (py-int-to-scheme other-15)
                                          (py-int-to-scheme self-14)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 34)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rand__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-14)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __iand__-314
                       (procedure->py-function
                        (lambda (self-16 other-17)
                          (letrec* ()
                            (if (py-isinstance? self-16 &py-builtin-int)
                                (if (py-isinstance? other-17 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py& (py-int-to-scheme self-16)
                                          (py-int-to-scheme other-17)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 39)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__iand__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-16)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __or__-316
                       (procedure->py-function
                        (lambda (self-18 other-19)
                          (letrec* ()
                            (if (py-isinstance? self-18 &py-builtin-int)
                                (if (py-isinstance? other-19 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py+b (py-int-to-scheme self-18)
                                           (py-int-to-scheme other-19)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 44)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__or__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-18)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ror__-318
                       (procedure->py-function
                        (lambda (self-20 other-21)
                          (letrec* ()
                            (if (py-isinstance? self-20 &py-builtin-int)
                                (if (py-isinstance? other-21 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py+b (py-int-to-scheme other-21)
                                           (py-int-to-scheme self-20)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 49)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ror__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-20)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ior__-320
                       (procedure->py-function
                        (lambda (self-22 other-23)
                          (letrec* ()
                            (if (py-isinstance? self-22 &py-builtin-int)
                                (if (py-isinstance? other-23 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py+b (py-int-to-scheme self-22)
                                           (py-int-to-scheme other-23)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 54)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ior__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-22)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __mul__-322
                       (procedure->py-function
                        (lambda (self-24 other-25)
                          (letrec* ()
                            (if (py-isinstance? self-24 &py-builtin-int)
                                (if (py-isinstance? other-25 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py* (py-int-to-scheme self-24)
                                          (py-int-to-scheme other-25)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 59)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__mul__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-24)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rmul__-324
                       (procedure->py-function
                        (lambda (self-26 other-27)
                          (letrec* ()
                            (if (py-isinstance? self-26 &py-builtin-int)
                                (if (py-isinstance? other-27 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py* (py-int-to-scheme other-27)
                                          (py-int-to-scheme self-26)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 64)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rmul__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-26)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __imul__-326
                       (procedure->py-function
                        (lambda (self-28 other-29)
                          (letrec* ()
                            (if (py-isinstance? self-28 &py-builtin-int)
                                (if (py-isinstance? other-29 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py* (py-int-to-scheme self-28)
                                          (py-int-to-scheme other-29)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 69)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__imul__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-28)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __pow__-328
                       (procedure->py-function
                        (lambda (self-30 other-31)
                          (letrec* ()
                            (if (py-isinstance? self-30 &py-builtin-int)
                                (if (py-isinstance? other-31 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py** (py-int-to-scheme self-30)
                                           (py-int-to-scheme other-31)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 74)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__pow__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-30)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rpow__-330
                       (procedure->py-function
                        (lambda (self-32 other-33)
                          (letrec* ()
                            (if (py-isinstance? self-32 &py-builtin-int)
                                (if (py-isinstance? other-33 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py** (py-int-to-scheme other-33)
                                           (py-int-to-scheme self-32)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 79)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rpow__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-32)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ipow__-332
                       (procedure->py-function
                        (lambda (self-34 other-35)
                          (letrec* ()
                            (if (py-isinstance? self-34 &py-builtin-int)
                                (if (py-isinstance? other-35 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py** (py-int-to-scheme self-34)
                                           (py-int-to-scheme other-35)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 84)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ipow__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-34)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __sub__-334
                       (procedure->py-function
                        (lambda (self-36 other-37)
                          (letrec* ()
                            (if (py-isinstance? self-36 &py-builtin-int)
                                (if (py-isinstance? other-37 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py- (py-int-to-scheme self-36)
                                          (py-int-to-scheme other-37)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 89)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__sub__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-36)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rsub__-336
                       (procedure->py-function
                        (lambda (self-38 other-39)
                          (letrec* ()
                            (if (py-isinstance? self-38 &py-builtin-int)
                                (if (py-isinstance? other-39 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py- (py-int-to-scheme other-39)
                                          (py-int-to-scheme self-38)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 94)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rsub__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-38)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __isub__-338
                       (procedure->py-function
                        (lambda (self-40 other-41)
                          (letrec* ()
                            (if (py-isinstance? self-40 &py-builtin-int)
                                (if (py-isinstance? other-41 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py- (py-int-to-scheme self-40)
                                          (py-int-to-scheme other-41)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 99)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__isub__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-40)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __xor__-340
                       (procedure->py-function
                        (lambda (self-42 other-43)
                          (letrec* ()
                            (if (py-isinstance? self-42 &py-builtin-int)
                                (if (py-isinstance? other-43 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py^ (py-int-to-scheme self-42)
                                          (py-int-to-scheme other-43)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 104)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__xor__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-42)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rxor__-342
                       (procedure->py-function
                        (lambda (self-44 other-45)
                          (letrec* ()
                            (if (py-isinstance? self-44 &py-builtin-int)
                                (if (py-isinstance? other-45 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py^ (py-int-to-scheme other-45)
                                          (py-int-to-scheme self-44)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 109)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rxor__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-44)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ixor__-344
                       (procedure->py-function
                        (lambda (self-46 other-47)
                          (letrec* ()
                            (if (py-isinstance? self-46 &py-builtin-int)
                                (if (py-isinstance? other-47 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py^ (py-int-to-scheme self-46)
                                          (py-int-to-scheme other-47)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 114)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ixor__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-46)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __lshift__-346
                       (procedure->py-function
                        (lambda (self-48 other-49)
                          (letrec* ()
                            (if (py-isinstance? self-48 &py-builtin-int)
                                (if (py-isinstance? other-49 &py-builtin-int)
                                    (if (py-test (py-ge other-49
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py<< (py-int-to-scheme self-48)
                                               (py-int-to-scheme other-49)))
                                        (py-throw
                                         (py-call &py-builtin-ValueError
                                                  (&& "negative shift count"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 120)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__lshift__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-48)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rlshift__-348
                       (procedure->py-function
                        (lambda (self-50 other-51)
                          (letrec* ()
                            (if (py-isinstance? self-50 &py-builtin-int)
                                (if (py-isinstance? other-51 &py-builtin-int)
                                    (if (py-test (py-ge self-50
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py<< (py-int-to-scheme self-50)
                                               (py-int-to-scheme other-51)))
                                        (py-throw
                                         (py-call &py-builtin-ValueError
                                                  (&& "negative shift count"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 126)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rlshift__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-50)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ilshift__-350
                       (procedure->py-function
                        (lambda (self-52 other-53)
                          (letrec* ()
                            (if (py-isinstance? self-52 &py-builtin-int)
                                (if (py-isinstance? other-53 &py-builtin-int)
                                    (if (py-test (py-ge other-53
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py<< (py-int-to-scheme self-52)
                                               (py-int-to-scheme other-53)))
                                        (py-throw
                                         (py-call &py-builtin-ValueError
                                                  (&& "negative shift count"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 132)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ilshift__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-52)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rshift__-352
                       (procedure->py-function
                        (lambda (self-54 other-55)
                          (letrec* ()
                            (if (py-isinstance? self-54 &py-builtin-int)
                                (if (py-isinstance? other-55 &py-builtin-int)
                                    (if (py-test (py-ge other-55
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py>> (py-int-to-scheme self-54)
                                               (py-int-to-scheme other-55)))
                                        (py-throw
                                         (py-call &py-builtin-ValueError
                                                  (&& "negative shift count"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 138)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rshift__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-54)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rrshift__-354
                       (procedure->py-function
                        (lambda (self-56 other-57)
                          (letrec* ()
                            (if (py-isinstance? self-56 &py-builtin-int)
                                (if (py-isinstance? other-57 &py-builtin-int)
                                    (if (py-test (py-ge self-56
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py>> (py-int-to-scheme self-56)
                                               (py-int-to-scheme other-57)))
                                        (py-throw
                                         (py-call &py-builtin-ValueError
                                                  (&& "negative shift count"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 144)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rrshift__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-56)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __irshift__-356
                       (procedure->py-function
                        (lambda (self-58 other-59)
                          (letrec* ()
                            (if (py-isinstance? self-58 &py-builtin-int)
                                (if (py-isinstance? other-59 &py-builtin-int)
                                    (if (py-test (py-ge other-59
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py>> (py-int-to-scheme self-58)
                                               (py-int-to-scheme other-59)))
                                        (py-throw
                                         (py-call &py-builtin-ValueError
                                                  (&& "negative shift count"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 150)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__irshift__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-58)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __pos__-358
                       (procedure->py-function
                        (lambda (self-60)
                          (letrec* ()
                            (if (py-isinstance? self-60 &py-builtin-int)
                                (py-int-from-scheme (py-int-to-scheme self-60))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__pos__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-60)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __neg__-360
                       (procedure->py-function
                        (lambda (self-61)
                          (letrec* ()
                            (if (py-isinstance? self-61 &py-builtin-int)
                                (py-int-from-scheme
                                 (pyneg (py-int-to-scheme self-61)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__neg__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-61)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __invert__-362
                       (procedure->py-function
                        (lambda (self-62)
                          (letrec* ()
                            (if (py-isinstance? self-62 &py-builtin-int)
                                (py-int-from-scheme
                                 (pyinvert (py-int-to-scheme self-62)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__invert__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-62)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __floordiv__-364
                       (procedure->py-function
                        (lambda (self-63 other-64)
                          (letrec* ()
                            (if (py-isinstance? self-63 &py-builtin-int)
                                (if (py-isinstance? other-64 &py-builtin-int)
                                    (if (py-test (py-ne other-64
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py// (py-int-to-scheme self-63)
                                               (py-int-to-scheme other-64)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "integer division by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 167)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__floordiv__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-63)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rfloordiv__-366
                       (procedure->py-function
                        (lambda (self-65 other-66)
                          (letrec* ()
                            (if (py-isinstance? self-65 &py-builtin-int)
                                (if (py-isinstance? other-66 &py-builtin-int)
                                    (if (py-test (py-ne self-65
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py// (py-int-to-scheme other-66)
                                               (py-int-to-scheme self-65)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "integer division by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 173)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rfloordiv__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-65)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ifloordiv__-368
                       (procedure->py-function
                        (lambda (self-67 other-68)
                          (letrec* ()
                            (if (py-isinstance? self-67 &py-builtin-int)
                                (if (py-isinstance? other-68 &py-builtin-int)
                                    (if (py-test (py-ne other-68
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py// (py-int-to-scheme self-67)
                                               (py-int-to-scheme other-68)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "integer division by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 179)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ifloordiv__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-67)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __truediv__-370
                       (procedure->py-function
                        (lambda (self-69 other-70)
                          (letrec* ()
                            (if (py-isinstance? self-69 &py-builtin-int)
                                (if (py-isinstance? other-70 &py-builtin-int)
                                    (if (py-test (py-ne other-70
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-float-from-scheme
                                         (py/ (py-int-to-scheme self-69)
                                              (py-int-to-scheme other-70)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "division by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 185)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__truediv__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-69)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rtruediv__-372
                       (procedure->py-function
                        (lambda (self-71 other-72)
                          (letrec* ()
                            (if (py-isinstance? self-71 &py-builtin-int)
                                (if (py-isinstance? other-72 &py-builtin-int)
                                    (if (py-test (py-ne self-71
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-float-from-scheme
                                         (py/ (py-int-to-scheme other-72)
                                              (py-int-to-scheme self-71)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "division by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 191)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rtruediv__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-71)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __itruediv__-374
                       (procedure->py-function
                        (lambda (self-73 other-74)
                          (letrec* ()
                            (if (py-isinstance? self-73 &py-builtin-int)
                                (if (py-isinstance? other-74 &py-builtin-int)
                                    (if (py-test (py-ne other-74
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-float-from-scheme
                                         (py/ (py-int-to-scheme self-73)
                                              (py-int-to-scheme other-74)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "division by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 197)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__itruediv__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-73)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __mod__-376
                       (procedure->py-function
                        (lambda (self-75 other-76)
                          (letrec* ()
                            (if (py-isinstance? self-75 &py-builtin-int)
                                (if (py-isinstance? other-76 &py-builtin-int)
                                    (if (py-test (py-ne other-76
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py% (py-int-to-scheme self-75)
                                              (py-int-to-scheme other-76)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "modulo by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 203)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__mod__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-75)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rmod__-378
                       (procedure->py-function
                        (lambda (self-77 other-78)
                          (letrec* ()
                            (if (py-isinstance? self-77 &py-builtin-int)
                                (if (py-isinstance? other-78 &py-builtin-int)
                                    (if (py-test (py-ne self-77
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py% (py-int-to-scheme other-78)
                                              (py-int-to-scheme self-77)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "modulo by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 209)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rmod__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-77)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __imod__-380
                       (procedure->py-function
                        (lambda (self-79 other-80)
                          (letrec* ()
                            (if (py-isinstance? self-79 &py-builtin-int)
                                (if (py-isinstance? other-80 &py-builtin-int)
                                    (if (py-test (py-ne other-80
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py% (py-int-to-scheme self-79)
                                              (py-int-to-scheme other-80)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "modulo by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 215)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__imod__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-79)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __eq__-382
                       (procedure->py-function
                        (lambda (self-81 other-82)
                          (letrec* ()
                            (if (py-isinstance? self-81 &py-builtin-int)
                                (if (py-isinstance? other-82 &py-builtin-int)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py== (py-int-to-scheme self-81)
                                            (py-int-to-scheme other-82))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 220)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__eq__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-81)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ne__-384
                       (procedure->py-function
                        (lambda (self-83 other-84)
                          (letrec* ()
                            (if (py-isinstance? self-83 &py-builtin-int)
                                (if (py-isinstance? other-84 &py-builtin-int)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py!= (py-int-to-scheme self-83)
                                            (py-int-to-scheme other-84))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 225)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ne__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-83)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ge__-386
                       (procedure->py-function
                        (lambda (self-85 other-86)
                          (letrec* ()
                            (if (py-isinstance? self-85 &py-builtin-int)
                                (if (py-isinstance? other-86 &py-builtin-int)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py>= (py-int-to-scheme self-85)
                                            (py-int-to-scheme other-86))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 230)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ge__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-85)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __gt__-388
                       (procedure->py-function
                        (lambda (self-87 other-88)
                          (letrec* ()
                            (if (py-isinstance? self-87 &py-builtin-int)
                                (if (py-isinstance? other-88 &py-builtin-int)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py> (py-int-to-scheme self-87)
                                           (py-int-to-scheme other-88))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 235)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__gt__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-87)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __le__-390
                       (procedure->py-function
                        (lambda (self-89 other-90)
                          (letrec* ()
                            (if (py-isinstance? self-89 &py-builtin-int)
                                (if (py-isinstance? other-90 &py-builtin-int)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py<= (py-int-to-scheme self-89)
                                            (py-int-to-scheme other-90))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 240)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__le__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-89)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __lt__-392
                       (procedure->py-function
                        (lambda (self-91 other-92)
                          (letrec* ()
                            (if (py-isinstance? self-91 &py-builtin-int)
                                (if (py-isinstance? other-92 &py-builtin-int)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py< (py-int-to-scheme self-91)
                                           (py-int-to-scheme other-92))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 245)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__lt__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-91)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other)))))
               (begin
                 (set! $%cls_0
                       (py-make-builtin-class
                        (&& "int")
                        (&& "__main__")
                        (list)
                        (& "__lt__")
                        __lt__-392
                        (& "__le__")
                        __le__-390
                        (& "__gt__")
                        __gt__-388
                        (& "__ge__")
                        __ge__-386
                        (& "__ne__")
                        __ne__-384
                        (& "__eq__")
                        __eq__-382
                        (& "__imod__")
                        __imod__-380
                        (& "__rmod__")
                        __rmod__-378
                        (& "__mod__")
                        __mod__-376
                        (& "__itruediv__")
                        __itruediv__-374
                        (& "__rtruediv__")
                        __rtruediv__-372
                        (& "__truediv__")
                        __truediv__-370
                        (& "__ifloordiv__")
                        __ifloordiv__-368
                        (& "__rfloordiv__")
                        __rfloordiv__-366
                        (& "__floordiv__")
                        __floordiv__-364
                        (& "__invert__")
                        __invert__-362
                        (& "__neg__")
                        __neg__-360
                        (& "__pos__")
                        __pos__-358
                        (& "__irshift__")
                        __irshift__-356
                        (& "__rrshift__")
                        __rrshift__-354
                        (& "__rshift__")
                        __rshift__-352
                        (& "__ilshift__")
                        __ilshift__-350
                        (& "__rlshift__")
                        __rlshift__-348
                        (& "__lshift__")
                        __lshift__-346
                        (& "__ixor__")
                        __ixor__-344
                        (& "__rxor__")
                        __rxor__-342
                        (& "__xor__")
                        __xor__-340
                        (& "__isub__")
                        __isub__-338
                        (& "__rsub__")
                        __rsub__-336
                        (& "__sub__")
                        __sub__-334
                        (& "__ipow__")
                        __ipow__-332
                        (& "__rpow__")
                        __rpow__-330
                        (& "__pow__")
                        __pow__-328
                        (& "__imul__")
                        __imul__-326
                        (& "__rmul__")
                        __rmul__-324
                        (& "__mul__")
                        __mul__-322
                        (& "__ior__")
                        __ior__-320
                        (& "__ror__")
                        __ror__-318
                        (& "__or__")
                        __or__-316
                        (& "__iand__")
                        __iand__-314
                        (& "__rand__")
                        __rand__-312
                        (& "__and__")
                        __and__-310
                        (& "__iadd__")
                        __iadd__-308
                        (& "__radd__")
                        __radd__-306
                        (& "__add__")
                        __add__-304
                        (& "__index__")
                        __index__-302
                        (& "__bool__")
                        __bool__-300
                        (& "__new__")
                        __new__-296))
                 $%cls_0))))
     (set! &py-builtin-bool
           (let (($%cls_1 py-absent))
             (letrec* ((__rxor__-842 #f)
                       (__xor__-840 #f)
                       (__ror__-838 #f)
                       (__or__-836 #f)
                       (__rand__-834 #f)
                       (__and__-832 #f)
                       (__new__-828 #f))
               (begin
                 (set! __new__-828
                       (py-call (global-get
                                 %global
                                 (& "staticmethod")
                                 (vector-ref %caches 251))
                                (procedure->py-function
                                 (lambda (cls-93 val-94)
                                   (letrec* ()
                                     (if (py-test (py-is cls-93
                                                         &py-builtin-int))
                                         (if (py-test (py-is val-94 py-absent))
                                             py-False
                                             (if (py-test val-94)
                                                 py-True
                                                 py-False))
                                         (py-throw
                                          &py-builtin-NotImplementedError))))
                                 (make-signature
                                  args:
                                  (cls val)
                                  defaults:
                                  (vector py-absent)))))
                 (set! __and__-832
                       (procedure->py-function
                        (lambda (self-95 other-96)
                          (letrec* ()
                            (if (py-test (py-is (py-obj-cls self-95)
                                                &py-builtin-bool))
                                (if (py-test (py-is (py-obj-cls other-96)
                                                    &py-builtin-bool))
                                    (if (py-test (py-is self-95 py-True))
                                        other-96
                                        py-False)
                                    (if (py-isinstance?
                                         other-96
                                         &py-builtin-int)
                                        (py-int-from-scheme
                                         (py& (py-int-to-scheme self-95)
                                              (py-int-to-scheme other-96)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 255))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__and__' requires a 'bool' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-95)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rand__-834
                       (procedure->py-function
                        (lambda (self-97 other-98)
                          (letrec* ()
                            (if (py-test (py-is (py-obj-cls self-97)
                                                &py-builtin-bool))
                                (if (py-test (py-is (py-obj-cls other-98)
                                                    &py-builtin-bool))
                                    (if (py-test (py-is self-97 py-True))
                                        other-98
                                        py-False)
                                    (if (py-isinstance?
                                         other-98
                                         &py-builtin-int)
                                        (py-int-from-scheme
                                         (py& (py-int-to-scheme other-98)
                                              (py-int-to-scheme self-97)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 261))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rand__' requires a 'bool' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-97)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __or__-836
                       (procedure->py-function
                        (lambda (self-99 other-100)
                          (letrec* ()
                            (if (py-test (py-is (py-obj-cls self-99)
                                                &py-builtin-bool))
                                (if (py-test (py-is (py-obj-cls other-100)
                                                    &py-builtin-bool))
                                    (if (py-test (py-is self-99 py-True))
                                        py-True
                                        other-100)
                                    (if (py-isinstance?
                                         other-100
                                         &py-builtin-int)
                                        (py-int-from-scheme
                                         (py+b (py-int-to-scheme self-99)
                                               (py-int-to-scheme other-100)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 267))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__or__' requires a 'bool' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-99)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ror__-838
                       (procedure->py-function
                        (lambda (self-101 other-102)
                          (letrec* ()
                            (if (py-test (py-is (py-obj-cls self-101)
                                                &py-builtin-bool))
                                (if (py-test (py-is (py-obj-cls other-102)
                                                    &py-builtin-bool))
                                    (if (py-test (py-is self-101 py-True))
                                        py-True
                                        other-102)
                                    (if (py-isinstance?
                                         other-102
                                         &py-builtin-int)
                                        (py-int-from-scheme
                                         (py+b (py-int-to-scheme other-102)
                                               (py-int-to-scheme self-101)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 273))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ror__' requires a 'bool' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-101)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __xor__-840
                       (procedure->py-function
                        (lambda (self-103 other-104)
                          (letrec* ()
                            (if (py-test (py-is (py-obj-cls self-103)
                                                &py-builtin-bool))
                                (if (py-test (py-is (py-obj-cls other-104)
                                                    &py-builtin-bool))
                                    (py-isnot self-103 other-104)
                                    (if (py-isinstance?
                                         other-104
                                         &py-builtin-int)
                                        (py-int-from-scheme
                                         (py^ (py-int-to-scheme self-103)
                                              (py-int-to-scheme other-104)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 279))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__xor__' requires a 'bool' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-103)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rxor__-842
                       (procedure->py-function
                        (lambda (self-105 other-106)
                          (letrec* ()
                            (if (py-test (py-is (py-obj-cls self-105)
                                                &py-builtin-bool))
                                (if (py-test (py-is (py-obj-cls other-106)
                                                    &py-builtin-bool))
                                    (py-isnot self-105 other-106)
                                    (if (py-isinstance?
                                         other-106
                                         &py-builtin-int)
                                        (py-int-from-scheme
                                         (py^ (py-int-to-scheme other-106)
                                              (py-int-to-scheme self-105)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 285))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rxor__' requires a 'bool' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-105)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other)))))
               (begin
                 (set! $%cls_1
                       (py-make-builtin-class
                        (&& "bool")
                        (&& "__main__")
                        (list &py-builtin-int)
                        (& "__rxor__")
                        __rxor__-842
                        (& "__xor__")
                        __xor__-840
                        (& "__ror__")
                        __ror__-838
                        (& "__or__")
                        __or__-836
                        (& "__rand__")
                        __rand__-834
                        (& "__and__")
                        __and__-832
                        (& "__new__")
                        __new__-828))
                 $%cls_1))))
     (set! &py-builtin-float
           (let (($%cls_2 py-absent))
             (letrec* ((__lt__-971 #f)
                       (__le__-969 #f)
                       (__gt__-967 #f)
                       (__ge__-965 #f)
                       (__ne__-963 #f)
                       (__eq__-961 #f)
                       (__imod__-959 #f)
                       (__rmod__-957 #f)
                       (__mod__-955 #f)
                       (__itruediv__-953 #f)
                       (__rtruediv__-951 #f)
                       (__truediv__-949 #f)
                       (__ifloordiv__-947 #f)
                       (__rfloordiv__-945 #f)
                       (__floordiv__-943 #f)
                       (__neg__-941 #f)
                       (__pos__-939 #f)
                       (__isub__-937 #f)
                       (__rsub__-935 #f)
                       (__sub__-933 #f)
                       (__ipow__-931 #f)
                       (__rpow__-929 #f)
                       (__pow__-927 #f)
                       (__imul__-925 #f)
                       (__rmul__-923 #f)
                       (__mul__-921 #f)
                       (__iadd__-919 #f)
                       (__radd__-917 #f)
                       (__add__-915 #f)
                       (__bool__-913 #f)
                       (__new__-909 #f))
               (begin
                 (set! __new__-909
                       (py-call (global-get
                                 %global
                                 (& "staticmethod")
                                 (vector-ref %caches 294))
                                (procedure->py-function
                                 (lambda (cls-107 val-108)
                                   (bind-exit
                                    ($%return_74)
                                    (letrec* ()
                                      (if (py-test (py-is cls-107
                                                          &py-builtin-int))
                                          (begin
                                            (if (py-test (py-is val-108
                                                                py-absent))
                                                ($%return_74
                                                 (py-float-from-scheme 0.))
                                                #f)
                                            (if (py-isinstance?
                                                 val-108
                                                 &py-builtin-float)
                                                (py-float-from-scheme
                                                 (py-float-to-scheme val-108))
                                                (py-throw
                                                 &py-builtin-NotImplementedError)))
                                          (py-throw
                                           &py-builtin-NotImplementedError)))))
                                 (make-signature
                                  args:
                                  (cls val)
                                  defaults:
                                  (vector py-absent)))))
                 (set! __bool__-913
                       (procedure->py-function
                        (lambda (self-109)
                          (letrec* ()
                            (if (py-isinstance? self-109 &py-builtin-float)
                                (py-ne self-109 (py-float-from-scheme 0.))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__bool__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-109)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __add__-915
                       (procedure->py-function
                        (lambda (self-110 other-111)
                          (letrec* ()
                            (if (py-isinstance? self-110 &py-builtin-float)
                                (if (py-isinstance?
                                     other-111
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py+ (py-float-to-scheme self-110)
                                          (py-float-to-scheme other-111)))
                                    (if (py-isinstance?
                                         other-111
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py+ (py-float-to-scheme self-110)
                                              (py-int-to-scheme other-111)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 301))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__add__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-110)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __radd__-917
                       (procedure->py-function
                        (lambda (self-112 other-113)
                          (letrec* ()
                            (if (py-isinstance? self-112 &py-builtin-float)
                                (if (py-isinstance?
                                     other-113
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py+ (py-float-to-scheme other-113)
                                          (py-float-to-scheme self-112)))
                                    (if (py-isinstance?
                                         other-113
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py+ (py-int-to-scheme other-113)
                                              (py-float-to-scheme self-112)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 307))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__radd__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-112)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __iadd__-919
                       (procedure->py-function
                        (lambda (self-114 other-115)
                          (letrec* ()
                            (if (py-isinstance? self-114 &py-builtin-float)
                                (if (py-isinstance?
                                     other-115
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py+ (py-float-to-scheme self-114)
                                          (py-float-to-scheme other-115)))
                                    (if (py-isinstance?
                                         self-114
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py+ (py-float-to-scheme self-114)
                                              (py-int-to-scheme other-115)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 313))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__iadd__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-114)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __mul__-921
                       (procedure->py-function
                        (lambda (self-116 other-117)
                          (letrec* ()
                            (if (py-isinstance? self-116 &py-builtin-float)
                                (if (py-isinstance?
                                     other-117
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py* (py-float-to-scheme self-116)
                                          (py-float-to-scheme other-117)))
                                    (if (py-isinstance?
                                         other-117
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py* (py-float-to-scheme self-116)
                                              (py-int-to-scheme other-117)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 319))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__mul__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-116)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rmul__-923
                       (procedure->py-function
                        (lambda (self-118 other-119)
                          (letrec* ()
                            (if (py-isinstance? self-118 &py-builtin-float)
                                (if (py-isinstance?
                                     other-119
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py* (py-float-to-scheme other-119)
                                          (py-float-to-scheme self-118)))
                                    (if (py-isinstance?
                                         other-119
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py* (py-int-to-scheme other-119)
                                              (py-float-to-scheme self-118)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 325))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rmul__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-118)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __imul__-925
                       (procedure->py-function
                        (lambda (self-120 other-121)
                          (letrec* ()
                            (if (py-isinstance? self-120 &py-builtin-float)
                                (if (py-isinstance?
                                     other-121
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py* (py-float-to-scheme self-120)
                                          (py-float-to-scheme other-121)))
                                    (if (py-isinstance?
                                         self-120
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py* (py-float-to-scheme self-120)
                                              (py-int-to-scheme other-121)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 331))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__imul__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-120)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __pow__-927
                       (procedure->py-function
                        (lambda (self-122 other-123)
                          (letrec* ()
                            (if (py-isinstance? self-122 &py-builtin-float)
                                (if (py-isinstance?
                                     other-123
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py** (py-float-to-scheme self-122)
                                           (py-float-to-scheme other-123)))
                                    (if (py-isinstance?
                                         other-123
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py** (py-float-to-scheme self-122)
                                               (py-int-to-scheme other-123)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 337))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__pow__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-122)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rpow__-929
                       (procedure->py-function
                        (lambda (self-124 other-125)
                          (letrec* ()
                            (if (py-isinstance? self-124 &py-builtin-float)
                                (if (py-isinstance?
                                     other-125
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py** (py-float-to-scheme other-125)
                                           (py-float-to-scheme self-124)))
                                    (if (py-isinstance?
                                         other-125
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py** (py-int-to-scheme other-125)
                                               (py-float-to-scheme self-124)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 343))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rpow__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-124)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ipow__-931
                       (procedure->py-function
                        (lambda (self-126 other-127)
                          (letrec* ()
                            (if (py-isinstance? self-126 &py-builtin-float)
                                (if (py-isinstance?
                                     other-127
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py** (py-float-to-scheme self-126)
                                           (py-float-to-scheme other-127)))
                                    (if (py-isinstance?
                                         self-126
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py** (py-float-to-scheme self-126)
                                               (py-int-to-scheme other-127)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 349))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ipow__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-126)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __sub__-933
                       (procedure->py-function
                        (lambda (self-128 other-129)
                          (letrec* ()
                            (if (py-isinstance? self-128 &py-builtin-float)
                                (if (py-isinstance?
                                     other-129
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py- (py-float-to-scheme self-128)
                                          (py-float-to-scheme other-129)))
                                    (if (py-isinstance?
                                         other-129
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py- (py-float-to-scheme self-128)
                                              (py-int-to-scheme other-129)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 355))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__sub__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-128)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rsub__-935
                       (procedure->py-function
                        (lambda (self-130 other-131)
                          (letrec* ()
                            (if (py-isinstance? self-130 &py-builtin-float)
                                (if (py-isinstance?
                                     other-131
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py- (py-float-to-scheme other-131)
                                          (py-float-to-scheme self-130)))
                                    (if (py-isinstance?
                                         other-131
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py- (py-int-to-scheme other-131)
                                              (py-float-to-scheme self-130)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 361))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rsub__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-130)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __isub__-937
                       (procedure->py-function
                        (lambda (self-132 other-133)
                          (letrec* ()
                            (if (py-isinstance? self-132 &py-builtin-float)
                                (if (py-isinstance?
                                     other-133
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py- (py-float-to-scheme self-132)
                                          (py-float-to-scheme other-133)))
                                    (if (py-isinstance?
                                         self-132
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py- (py-float-to-scheme self-132)
                                              (py-int-to-scheme other-133)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 367))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__isub__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-132)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __pos__-939
                       (procedure->py-function
                        (lambda (self-134)
                          (letrec* ()
                            (if (py-isinstance? self-134 &py-builtin-float)
                                self-134
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__pos__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-134)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __neg__-941
                       (procedure->py-function
                        (lambda (self-135)
                          (letrec* ()
                            (if (py-isinstance? self-135 &py-builtin-float)
                                (py-float-from-scheme
                                 (pyneg (py-float-to-scheme self-135)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__neg__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-135)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __floordiv__-943
                       (procedure->py-function
                        (lambda (self-136 other-137)
                          (letrec* ()
                            (if (py-isinstance? self-136 &py-builtin-float)
                                (if (py-isinstance?
                                     other-137
                                     &py-builtin-float)
                                    (if (py-test (py-ne other-137
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py// (py-float-to-scheme self-136)
                                               (py-float-to-scheme other-137)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float division by zero"))))
                                    (if (py-isinstance?
                                         other-137
                                         &py-builtin-int)
                                        (if (py-test (py-ne other-137
                                                            (py-int-from-scheme
                                                             0)))
                                            (py-float-from-scheme
                                             (py// (py-float-to-scheme
                                                    self-136)
                                                   (py-int-to-scheme
                                                    other-137)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float division by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 382))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__floordiv__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-136)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rfloordiv__-945
                       (procedure->py-function
                        (lambda (self-138 other-139)
                          (letrec* ()
                            (if (py-isinstance? self-138 &py-builtin-float)
                                (if (py-isinstance?
                                     other-139
                                     &py-builtin-float)
                                    (if (py-test (py-ne self-138
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py// (py-float-to-scheme other-139)
                                               (py-float-to-scheme self-138)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float division by zero"))))
                                    (if (py-isinstance?
                                         other-139
                                         &py-builtin-int)
                                        (if (py-test (py-ne self-138
                                                            (py-float-from-scheme
                                                             0.)))
                                            (py-float-from-scheme
                                             (py// (py-int-to-scheme other-139)
                                                   (py-float-to-scheme
                                                    self-138)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float division by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 390))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rfloordiv__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-138)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ifloordiv__-947
                       (procedure->py-function
                        (lambda (self-140 other-141)
                          (letrec* ()
                            (if (py-isinstance? self-140 &py-builtin-float)
                                (if (py-isinstance?
                                     other-141
                                     &py-builtin-float)
                                    (if (py-test (py-ne other-141
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py// (py-float-to-scheme self-140)
                                               (py-float-to-scheme other-141)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float division by zero"))))
                                    (if (py-isinstance?
                                         other-141
                                         &py-builtin-int)
                                        (if (py-test (py-ne other-141
                                                            (py-int-from-scheme
                                                             0)))
                                            (py-float-from-scheme
                                             (py// (py-float-to-scheme
                                                    self-140)
                                                   (py-int-to-scheme
                                                    other-141)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float division by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 398))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ifloordiv__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-140)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __truediv__-949
                       (procedure->py-function
                        (lambda (self-142 other-143)
                          (letrec* ()
                            (if (py-isinstance? self-142 &py-builtin-float)
                                (if (py-isinstance?
                                     other-143
                                     &py-builtin-float)
                                    (if (py-test (py-ne other-143
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py/ (py-float-to-scheme self-142)
                                              (py-float-to-scheme other-143)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float division by zero"))))
                                    (if (py-isinstance?
                                         other-143
                                         &py-builtin-int)
                                        (if (py-test (py-ne other-143
                                                            (py-int-from-scheme
                                                             0)))
                                            (py-float-from-scheme
                                             (py/ (py-float-to-scheme self-142)
                                                  (py-int-to-scheme
                                                   other-143)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float division by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 406))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__truediv__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-142)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rtruediv__-951
                       (procedure->py-function
                        (lambda (self-144 other-145)
                          (letrec* ()
                            (if (py-isinstance? self-144 &py-builtin-float)
                                (if (py-isinstance?
                                     other-145
                                     &py-builtin-float)
                                    (if (py-test (py-ne self-144
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py/ (py-float-to-scheme other-145)
                                              (py-float-to-scheme self-144)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float division by zero"))))
                                    (if (py-isinstance?
                                         other-145
                                         &py-builtin-int)
                                        (if (py-test (py-ne self-144
                                                            (py-float-from-scheme
                                                             0.)))
                                            (py-float-from-scheme
                                             (py/ (py-int-to-scheme other-145)
                                                  (py-float-to-scheme
                                                   self-144)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float division by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 414))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rtruediv__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-144)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __itruediv__-953
                       (procedure->py-function
                        (lambda (self-146 other-147)
                          (letrec* ()
                            (if (py-isinstance? self-146 &py-builtin-float)
                                (if (py-isinstance?
                                     other-147
                                     &py-builtin-float)
                                    (if (py-test (py-ne other-147
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py/ (py-float-to-scheme self-146)
                                              (py-float-to-scheme other-147)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float division by zero"))))
                                    (if (py-isinstance?
                                         other-147
                                         &py-builtin-int)
                                        (if (py-test (py-ne other-147
                                                            (py-int-from-scheme
                                                             0)))
                                            (py-float-from-scheme
                                             (py/ (py-float-to-scheme self-146)
                                                  (py-int-to-scheme
                                                   other-147)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float division by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 422))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__itruediv__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-146)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __mod__-955
                       (procedure->py-function
                        (lambda (self-148 other-149)
                          (letrec* ()
                            (if (py-isinstance? self-148 &py-builtin-float)
                                (if (py-isinstance?
                                     other-149
                                     &py-builtin-float)
                                    (if (py-test (py-ne other-149
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py% (py-float-to-scheme self-148)
                                              (py-float-to-scheme other-149)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float modulo by zero"))))
                                    (if (py-isinstance?
                                         other-149
                                         &py-builtin-int)
                                        (if (py-test (py-ne other-149
                                                            (py-int-from-scheme
                                                             0)))
                                            (py-float-from-scheme
                                             (py% (py-float-to-scheme self-148)
                                                  (py-int-to-scheme
                                                   other-149)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float modulo by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 430))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__mod__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-148)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rmod__-957
                       (procedure->py-function
                        (lambda (self-150 other-151)
                          (letrec* ()
                            (if (py-isinstance? self-150 &py-builtin-float)
                                (if (py-isinstance?
                                     other-151
                                     &py-builtin-float)
                                    (if (py-test (py-ne self-150
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py% (py-float-to-scheme other-151)
                                              (py-float-to-scheme self-150)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float modulo by zero"))))
                                    (if (py-isinstance?
                                         other-151
                                         &py-builtin-int)
                                        (if (py-test (py-ne self-150
                                                            (py-float-from-scheme
                                                             0.)))
                                            (py-float-from-scheme
                                             (py% (py-int-to-scheme other-151)
                                                  (py-float-to-scheme
                                                   self-150)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float modulo by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 438))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rmod__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-150)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __imod__-959
                       (procedure->py-function
                        (lambda (self-152 other-153)
                          (letrec* ()
                            (if (py-isinstance? self-152 &py-builtin-float)
                                (if (py-isinstance?
                                     other-153
                                     &py-builtin-float)
                                    (if (py-test (py-ne other-153
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py% (py-float-to-scheme self-152)
                                              (py-float-to-scheme other-153)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float modulo by zero"))))
                                    (if (py-isinstance?
                                         other-153
                                         &py-builtin-int)
                                        (if (py-test (py-ne other-153
                                                            (py-int-from-scheme
                                                             0)))
                                            (py-float-from-scheme
                                             (py% (py-float-to-scheme self-152)
                                                  (py-int-to-scheme
                                                   other-153)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float modulo by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 446))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__imod__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-152)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __eq__-961
                       (procedure->py-function
                        (lambda (self-154 other-155)
                          (letrec* ()
                            (if (py-isinstance? self-154 &py-builtin-float)
                                (if (py-isinstance?
                                     other-155
                                     &py-builtin-float)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py== (py-float-to-scheme self-154)
                                            (py-float-to-scheme other-155))))
                                    (if (py-isinstance?
                                         other-155
                                         &py-builtin-int)
                                        (py-bool-from-scheme-bool
                                         (py-test-from-scheme
                                          (py== (py-float-to-scheme self-154)
                                                (py-int-to-scheme other-155))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 452))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__eq__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-154)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ne__-963
                       (procedure->py-function
                        (lambda (self-156 other-157)
                          (letrec* ()
                            (if (py-isinstance? self-156 &py-builtin-float)
                                (if (py-isinstance?
                                     other-157
                                     &py-builtin-float)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py!= (py-float-to-scheme self-156)
                                            (py-float-to-scheme other-157))))
                                    (if (py-isinstance?
                                         other-157
                                         &py-builtin-int)
                                        (py-bool-from-scheme-bool
                                         (py-test-from-scheme
                                          (py!= (py-float-to-scheme self-156)
                                                (py-int-to-scheme other-157))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 458))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ne__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-156)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ge__-965
                       (procedure->py-function
                        (lambda (self-158 other-159)
                          (letrec* ()
                            (if (py-isinstance? self-158 &py-builtin-float)
                                (if (py-isinstance?
                                     other-159
                                     &py-builtin-float)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py>= (py-float-to-scheme self-158)
                                            (py-float-to-scheme other-159))))
                                    (if (py-isinstance?
                                         other-159
                                         &py-builtin-int)
                                        (py-bool-from-scheme-bool
                                         (py-test-from-scheme
                                          (py>= (py-float-to-scheme self-158)
                                                (py-int-to-scheme other-159))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 464))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ge__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-158)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __gt__-967
                       (procedure->py-function
                        (lambda (self-160 other-161)
                          (letrec* ()
                            (if (py-isinstance? self-160 &py-builtin-float)
                                (if (py-isinstance?
                                     other-161
                                     &py-builtin-float)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py> (py-float-to-scheme self-160)
                                           (py-float-to-scheme other-161))))
                                    (if (py-isinstance?
                                         other-161
                                         &py-builtin-int)
                                        (py-bool-from-scheme-bool
                                         (py-test-from-scheme
                                          (py> (py-float-to-scheme self-160)
                                               (py-int-to-scheme other-161))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 470))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__gt__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-160)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __le__-969
                       (procedure->py-function
                        (lambda (self-162 other-163)
                          (letrec* ()
                            (if (py-isinstance? self-162 &py-builtin-float)
                                (if (py-isinstance?
                                     other-163
                                     &py-builtin-float)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py<= (py-float-to-scheme self-162)
                                            (py-float-to-scheme other-163))))
                                    (if (py-isinstance?
                                         other-163
                                         &py-builtin-int)
                                        (py-bool-from-scheme-bool
                                         (py-test-from-scheme
                                          (py<= (py-float-to-scheme self-162)
                                                (py-int-to-scheme other-163))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 476))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__le__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-162)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __lt__-971
                       (procedure->py-function
                        (lambda (self-164 other-165)
                          (letrec* ()
                            (if (py-isinstance? self-164 &py-builtin-float)
                                (if (py-isinstance?
                                     other-165
                                     &py-builtin-float)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py< (py-float-to-scheme self-164)
                                           (py-float-to-scheme other-165))))
                                    (if (py-isinstance?
                                         other-165
                                         &py-builtin-int)
                                        (py-bool-from-scheme-bool
                                         (py-test-from-scheme
                                          (py< (py-float-to-scheme self-164)
                                               (py-int-to-scheme other-165))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 482))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__lt__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-164)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other)))))
               (begin
                 (set! $%cls_2
                       (py-make-builtin-class
                        (&& "float")
                        (&& "__main__")
                        (list)
                        (& "__lt__")
                        __lt__-971
                        (& "__le__")
                        __le__-969
                        (& "__gt__")
                        __gt__-967
                        (& "__ge__")
                        __ge__-965
                        (& "__ne__")
                        __ne__-963
                        (& "__eq__")
                        __eq__-961
                        (& "__imod__")
                        __imod__-959
                        (& "__rmod__")
                        __rmod__-957
                        (& "__mod__")
                        __mod__-955
                        (& "__itruediv__")
                        __itruediv__-953
                        (& "__rtruediv__")
                        __rtruediv__-951
                        (& "__truediv__")
                        __truediv__-949
                        (& "__ifloordiv__")
                        __ifloordiv__-947
                        (& "__rfloordiv__")
                        __rfloordiv__-945
                        (& "__floordiv__")
                        __floordiv__-943
                        (& "__neg__")
                        __neg__-941
                        (& "__pos__")
                        __pos__-939
                        (& "__isub__")
                        __isub__-937
                        (& "__rsub__")
                        __rsub__-935
                        (& "__sub__")
                        __sub__-933
                        (& "__ipow__")
                        __ipow__-931
                        (& "__rpow__")
                        __rpow__-929
                        (& "__pow__")
                        __pow__-927
                        (& "__imul__")
                        __imul__-925
                        (& "__rmul__")
                        __rmul__-923
                        (& "__mul__")
                        __mul__-921
                        (& "__iadd__")
                        __iadd__-919
                        (& "__radd__")
                        __radd__-917
                        (& "__add__")
                        __add__-915
                        (& "__bool__")
                        __bool__-913
                        (& "__new__")
                        __new__-909))
                 $%cls_2))))
     (set! &py-builtin-str
           (let (($%cls_3 py-absent))
             (letrec* ((__lt__-1323 #f)
                       (__le__-1321 #f)
                       (__gt__-1319 #f)
                       (__ge__-1317 #f)
                       (__ne__-1315 #f)
                       (__eq__-1313 #f)
                       (__rmul__-1311 #f)
                       (__mul__-1309 #f)
                       (__add__-1307 #f)
                       (__len__-1305 #f))
               (begin
                 (set! __len__-1305
                       (procedure->py-function
                        (lambda (self-166)
                          (letrec* ()
                            (if (py-isinstance? self-166 &py-builtin-str)
                                (py-int-from-scheme
                                 (py-str-len-to-scheme self-166))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__len__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-166)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __add__-1307
                       (procedure->py-function
                        (lambda (self-167 other-168)
                          (letrec* ()
                            (if (py-isinstance? self-167 &py-builtin-str)
                                (if (py-isinstance? other-168 &py-builtin-str)
                                    (py-str-from-scheme
                                     (py+ (py-str-to-scheme self-167)
                                          (py-str-to-scheme other-168)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 491)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__add__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-167)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __mul__-1309
                       (procedure->py-function
                        (lambda (self-169 other-170)
                          (letrec* ()
                            (if (py-isinstance? self-169 &py-builtin-str)
                                (if (py-isinstance? other-170 &py-builtin-int)
                                    (py-str-from-scheme
                                     (py* (py-str-to-scheme self-169)
                                          (py-int-to-scheme other-170)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 496)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__mul__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-169)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rmul__-1311
                       (procedure->py-function
                        (lambda (self-171 other-172)
                          (letrec* ()
                            (if (py-isinstance? self-171 &py-builtin-str)
                                (if (py-isinstance? other-172 &py-builtin-int)
                                    (py-str-from-scheme
                                     (py* (py-str-to-scheme self-171)
                                          (py-int-to-scheme other-172)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 501)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rmul__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-171)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __eq__-1313
                       (procedure->py-function
                        (lambda (self-173 other-174)
                          (letrec* ()
                            (if (py-isinstance? self-173 &py-builtin-str)
                                (if (py-isinstance? other-174 &py-builtin-str)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py== (py-str-to-scheme self-173)
                                            (py-str-to-scheme other-174))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 506)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__eq__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-173)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ne__-1315
                       (procedure->py-function
                        (lambda (self-175 other-176)
                          (letrec* ()
                            (if (py-isinstance? self-175 &py-builtin-str)
                                (if (py-isinstance? other-176 &py-builtin-str)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py!= (py-str-to-scheme self-175)
                                            (py-str-to-scheme other-176))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 511)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ne__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-175)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ge__-1317
                       (procedure->py-function
                        (lambda (self-177 other-178)
                          (letrec* ()
                            (if (py-isinstance? self-177 &py-builtin-str)
                                (if (py-isinstance? other-178 &py-builtin-str)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py>= (py-str-to-scheme self-177)
                                            (py-str-to-scheme other-178))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 516)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ge__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-177)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __gt__-1319
                       (procedure->py-function
                        (lambda (self-179 other-180)
                          (letrec* ()
                            (if (py-isinstance? self-179 &py-builtin-str)
                                (if (py-isinstance? other-180 &py-builtin-str)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py> (py-str-to-scheme self-179)
                                           (py-str-to-scheme other-180))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 521)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__gt__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-179)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __le__-1321
                       (procedure->py-function
                        (lambda (self-181 other-182)
                          (letrec* ()
                            (if (py-isinstance? self-181 &py-builtin-str)
                                (if (py-isinstance? other-182 &py-builtin-str)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py<= (py-str-to-scheme self-181)
                                            (py-str-to-scheme other-182))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 526)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__le__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-181)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __lt__-1323
                       (procedure->py-function
                        (lambda (self-183 other-184)
                          (letrec* ()
                            (if (py-isinstance? self-183 &py-builtin-str)
                                (if (py-isinstance? other-184 &py-builtin-str)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py< (py-str-to-scheme self-183)
                                           (py-str-to-scheme other-184))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 531)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__lt__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-183)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other)))))
               (begin
                 (set! $%cls_3
                       (py-make-builtin-class
                        (&& "str")
                        (&& "__main__")
                        (list)
                        (& "__lt__")
                        __lt__-1323
                        (& "__le__")
                        __le__-1321
                        (& "__gt__")
                        __gt__-1319
                        (& "__ge__")
                        __ge__-1317
                        (& "__ne__")
                        __ne__-1315
                        (& "__eq__")
                        __eq__-1313
                        (& "__rmul__")
                        __rmul__-1311
                        (& "__mul__")
                        __mul__-1309
                        (& "__add__")
                        __add__-1307
                        (& "__len__")
                        __len__-1305))
                 $%cls_3))))
     (set! &py-builtin-range_iterator
           (let (($%cls_4 py-absent))
             (letrec* ((__next__-1419 #f) (__iter__-1417 #f))
               (begin
                 (set! __iter__-1417
                       (procedure->py-function
                        (lambda (self-185) (letrec* () self-185))
                        (make-signature posonlyargs: (self))))
                 (set! __next__-1419
                       (procedure->py-function
                        (lambda (self-186)
                          (bind-exit
                           ($%return_75)
                           (letrec* ((step-1426 #f)
                                     (stop-1424 #f)
                                     (start-1421 #f))
                             (begin
                               (set! start-1421
                                     (PyObjectRangeIterator-start self-186))
                               (set! stop-1424
                                     (PyObjectRangeIterator-stop self-186))
                               (set! step-1426
                                     (PyObjectRangeIterator-step self-186))
                               (if (py-test (py-lt step-1426
                                                   (py-int-from-scheme 0)))
                                   (if (py-test (py-gt start-1421 stop-1424))
                                       (begin
                                         (PyObjectRangeIterator-start-set!
                                          self-186
                                          (py-add start-1421 step-1426))
                                         ($%return_75 start-1421))
                                       #f)
                                   (if (py-test (py-lt start-1421 stop-1424))
                                       (begin
                                         (PyObjectRangeIterator-start-set!
                                          self-186
                                          (py-add start-1421 step-1426))
                                         ($%return_75 start-1421))
                                       #f))
                               (py-throw &py-builtin-StopIteration)))))
                        (make-signature posonlyargs: (self)))))
               (begin
                 (set! $%cls_4
                       (py-make-builtin-class
                        (&& "range_iterator")
                        (&& "__main__")
                        (list)
                        (& "__next__")
                        __next__-1419
                        (& "__iter__")
                        __iter__-1417))
                 $%cls_4))))
     (set! &py-builtin-range
           (let (($%cls_5 py-absent))
             (letrec* ((__repr__-1439 #f)
                       (__iter__-1437 #f)
                       (__contains__-1435 #f)
                       (__len__-1433 #f)
                       (__new__-1430 #f))
               (begin
                 (set! __new__-1430
                       (procedure->py-function
                        (lambda (cls-187 arg1-188 arg2-189 arg3-190)
                          (letrec* ()
                            (if (py-test (py-isnot arg3-190 py-absent))
                                (make-PyObjectRange
                                 py-range-hclass-of-instances
                                 '#()
                                 py-builtin-range
                                 arg1-188
                                 arg2-189
                                 arg3-190)
                                (if (py-test (py-isnot arg2-189 py-absent))
                                    (make-PyObjectRange
                                     py-range-hclass-of-instances
                                     '#()
                                     py-builtin-range
                                     arg1-188
                                     arg2-189
                                     (py-int-from-scheme 1))
                                    (make-PyObjectRange
                                     py-range-hclass-of-instances
                                     '#()
                                     py-builtin-range
                                     (py-int-from-scheme 0)
                                     arg1-188
                                     (py-int-from-scheme 1))))))
                        (make-signature
                         posonlyargs:
                         (cls arg1 arg2 arg3)
                         defaults:
                         (vector py-absent py-absent))))
                 (set! __len__-1433
                       (procedure->py-function
                        (lambda (self-191)
                          (letrec* ()
                            (py-floordiv
                             (py-sub (PyObjectRange-stop self-191)
                                     (PyObjectRange-start self-191))
                             (PyObjectRange-step self-191))))
                        (make-signature posonlyargs: (self))))
                 (set! __contains__-1435
                       (procedure->py-function
                        (lambda (self-192 item-193)
                          (bind-exit
                           ($%return_76)
                           (letrec* ((step-1456 #f)
                                     (stop-1454 #f)
                                     (start-1451 #f))
                             (begin
                               (set! start-1451 (PyObjectRange-start self-192))
                               (set! stop-1454 (PyObjectRange-stop self-192))
                               (set! step-1456 (PyObjectRange-step self-192))
                               (if (py-test (py-lt step-1456
                                                   (py-int-from-scheme 0)))
                                   (if (or (py-test (py-ge stop-1454 item-193))
                                           (py-test (py-gt item-193
                                                           start-1451)))
                                       ($%return_76 py-False)
                                       #f)
                                   (if (or (py-test (py-gt start-1451
                                                           item-193))
                                           (py-test (py-ge item-193
                                                           stop-1454)))
                                       ($%return_76 py-False)
                                       #f))
                               (py-eq (py-mod (py-sub item-193 start-1451)
                                              step-1456)
                                      (py-int-from-scheme 0))))))
                        (make-signature posonlyargs: (self item))))
                 (set! __iter__-1437
                       (procedure->py-function
                        (lambda (self-194)
                          (letrec* ()
                            (py-call &py-builtin-range_iterator
                                     (PyObjectRange-start self-194)
                                     (PyObjectRange-stop self-194)
                                     (PyObjectRange-step self-194))))
                        (make-signature posonlyargs: (self))))
                 (set! __repr__-1439
                       (procedure->py-function
                        (lambda (self-195)
                          (letrec* ((step-1446 #f)
                                    (stop-1444 #f)
                                    (start-1441 #f))
                            (begin
                              (set! start-1441 (PyObjectRange-start self-195))
                              (set! stop-1444 (PyObjectRange-stop self-195))
                              (set! step-1446 (PyObjectRange-step self-195))
                              (if (py-test (py-eq step-1446
                                                  (py-int-from-scheme 1)))
                                  (py-add (py-add (py-add (py-add (&& "range(")
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                          (py-call &py-builtin-str start-1441))
                  (&& ", "))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                  (py-call &py-builtin-str
                                                           stop-1444))
                                          (&& ")"))
                                  (py-add (py-add (py-add (py-add (py-add (py-add (&& "range(")
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                                          (py-call &py-builtin-str start-1441))
                                  (&& ", "))
                          (py-call &py-builtin-str stop-1444))
                  (&& ", "))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                  (py-call &py-builtin-str
                                                           step-1446))
                                          (&& ")"))))))
                        (make-signature args: (self)))))
               (begin
                 (set! $%cls_5
                       (py-make-builtin-class
                        (&& "range")
                        (&& "__main__")
                        (list)
                        (& "__repr__")
                        __repr__-1439
                        (& "__iter__")
                        __iter__-1437
                        (& "__contains__")
                        __contains__-1435
                        (& "__len__")
                        __len__-1433
                        (& "__new__")
                        __new__-1430))
                 $%cls_5))))
     (let (($fun-obj
            (procedure->py-function
             procedure:&py-builtin-__merge
             (make-signature args: (l1 l2)))))
       (set! &py-builtin-__merge $fun-obj)
       (set! init:&py-builtin-__merge $fun-obj))
     (let (($fun-obj
            (procedure->py-function
             procedure:&py-builtin-__merge_many
             (make-signature args: (lsts)))))
       (set! &py-builtin-__merge_many $fun-obj)
       (set! init:&py-builtin-__merge_many $fun-obj))
     (let (($fun-obj
            (procedure->py-function
             procedure:&py-builtin-sorted
             (make-signature
              args:
              (lst key reversed)
              defaults:
              (vector py-None py-False)))))
       (set! &py-builtin-sorted $fun-obj)
       (set! init:&py-builtin-sorted $fun-obj))
     (set! &py-builtin-BaseException
           (let (($%cls_6 py-absent))
             (letrec* ((__str__-1492 #f) (__init__-1490 #f))
               (begin
                 (set! __init__-1490
                       (procedure->py-function
                        (lambda (self-203 args-204)
                          (letrec* ()
                            (begin
                              (py-setattribute
                               (or self-203
                                   (py-throw-exception-with-message
                                    py-builtin-UnboundLocalError
                                    "local variable 'self' referenced before assignment"))
                               (& "args")
                               (or args-204
                                   (py-throw-exception-with-message
                                    py-builtin-UnboundLocalError
                                    "local variable 'args' referenced before assignment")))
                              py-None)))
                        (make-signature args: (self) vararg: args)))
                 (set! __str__-1492
                       (procedure->py-function
                        (lambda (self-205)
                          (letrec* ((args_len-1497 #f) (args-1494 #f))
                            (begin
                              (set! args-1494
                                    (py-getattribute self-205 (& "args")))
                              (set! args_len-1497
                                    (py-call (global-get
                                              %global
                                              (& "len")
                                              (vector-ref %caches 582))
                                             (py-getattribute
                                              self-205
                                              (& "args"))))
                              (if (py-test (py-eq args_len-1497
                                                  (py-int-from-scheme 0)))
                                  (&& "")
                                  (if (py-test (py-eq args_len-1497
                                                      (py-int-from-scheme 1)))
                                      (py-call &py-builtin-str
                                               (py-getitem
                                                args-1494
                                                (py-int-from-scheme 0)))
                                      (py-call &py-builtin-str args-1494))))))
                        (make-signature args: (self)))))
               (begin
                 (set! $%cls_6
                       (py-make-builtin-class
                        (&& "BaseException")
                        (&& "__main__")
                        (list)
                        (& "__str__")
                        __str__-1492
                        (& "__init__")
                        __init__-1490))
                 $%cls_6))))
     (set! &py-builtin-Exception
           (let (($%cls_7 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_7
                       (py-make-builtin-class
                        (&& "Exception")
                        (&& "__main__")
                        (list &py-builtin-BaseException)))
                 $%cls_7))))
     (set! &py-builtin-GeneratorExit
           (let (($%cls_8 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_8
                       (py-make-builtin-class
                        (&& "GeneratorExit")
                        (&& "__main__")
                        (list &py-builtin-BaseException)))
                 $%cls_8))))
     (set! &py-builtin-KeyboardInterrupt
           (let (($%cls_9 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_9
                       (py-make-builtin-class
                        (&& "KeyboardInterrupt")
                        (&& "__main__")
                        (list &py-builtin-BaseException)))
                 $%cls_9))))
     (set! &py-builtin-SystemExit
           (let (($%cls_10 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_10
                       (py-make-builtin-class
                        (&& "SystemExit")
                        (&& "__main__")
                        (list &py-builtin-BaseException)))
                 $%cls_10))))
     (set! &py-builtin-ArithmeticError
           (let (($%cls_11 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_11
                       (py-make-builtin-class
                        (&& "ArithmeticError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_11))))
     (set! &py-builtin-AssertionError
           (let (($%cls_12 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_12
                       (py-make-builtin-class
                        (&& "AssertionError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_12))))
     (set! &py-builtin-AttributeError
           (let (($%cls_13 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_13
                       (py-make-builtin-class
                        (&& "AttributeError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_13))))
     (set! &py-builtin-BufferError
           (let (($%cls_14 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_14
                       (py-make-builtin-class
                        (&& "BufferError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_14))))
     (set! &py-builtin-EOFError
           (let (($%cls_15 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_15
                       (py-make-builtin-class
                        (&& "EOFError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_15))))
     (set! &py-builtin-ImportError
           (let (($%cls_16 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_16
                       (py-make-builtin-class
                        (&& "ImportError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_16))))
     (set! &py-builtin-LookupError
           (let (($%cls_17 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_17
                       (py-make-builtin-class
                        (&& "LookupError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_17))))
     (set! &py-builtin-MemoryError
           (let (($%cls_18 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_18
                       (py-make-builtin-class
                        (&& "MemoryError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_18))))
     (set! &py-builtin-NameError
           (let (($%cls_19 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_19
                       (py-make-builtin-class
                        (&& "NameError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_19))))
     (set! &py-builtin-EnvironmentError
           (let (($%cls_20 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_20
                       (py-make-builtin-class
                        (&& "EnvironmentError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_20))))
     (set! &py-builtin-IOError
           (let (($%cls_21 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_21
                       (py-make-builtin-class
                        (&& "IOError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_21))))
     (set! &py-builtin-OSError
           (let (($%cls_22 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_22
                       (py-make-builtin-class
                        (&& "OSError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_22))))
     (set! &py-builtin-WindowsError
           (let (($%cls_23 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_23
                       (py-make-builtin-class
                        (&& "WindowsError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_23))))
     (set! &py-builtin-ReferenceError
           (let (($%cls_24 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_24
                       (py-make-builtin-class
                        (&& "ReferenceError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_24))))
     (set! &py-builtin-RuntimeError
           (let (($%cls_25 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_25
                       (py-make-builtin-class
                        (&& "RuntimeError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_25))))
     (set! &py-builtin-StopAsyncIteration
           (let (($%cls_26 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_26
                       (py-make-builtin-class
                        (&& "StopAsyncIteration")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_26))))
     (set! &py-builtin-StopIteration
           (let (($%cls_27 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_27
                       (py-make-builtin-class
                        (&& "StopIteration")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_27))))
     (set! &py-builtin-SyntaxError
           (let (($%cls_28 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_28
                       (py-make-builtin-class
                        (&& "SyntaxError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_28))))
     (set! &py-builtin-SystemError
           (let (($%cls_29 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_29
                       (py-make-builtin-class
                        (&& "SystemError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_29))))
     (set! &py-builtin-TypeError
           (let (($%cls_30 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_30
                       (py-make-builtin-class
                        (&& "TypeError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_30))))
     (set! &py-builtin-ValueError
           (let (($%cls_31 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_31
                       (py-make-builtin-class
                        (&& "ValueError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_31))))
     (set! &py-builtin-Warning
           (let (($%cls_32 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_32
                       (py-make-builtin-class
                        (&& "Warning")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_32))))
     (set! &py-builtin-FloatingPointError
           (let (($%cls_33 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_33
                       (py-make-builtin-class
                        (&& "FloatingPointError")
                        (&& "__main__")
                        (list &py-builtin-ArithmeticError)))
                 $%cls_33))))
     (set! &py-builtin-OverflowError
           (let (($%cls_34 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_34
                       (py-make-builtin-class
                        (&& "OverflowError")
                        (&& "__main__")
                        (list &py-builtin-ArithmeticError)))
                 $%cls_34))))
     (set! &py-builtin-ZeroDivisionError
           (let (($%cls_35 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_35
                       (py-make-builtin-class
                        (&& "ZeroDivisionError")
                        (&& "__main__")
                        (list &py-builtin-ArithmeticError)))
                 $%cls_35))))
     (set! &py-builtin-ModuleNotFoundError
           (let (($%cls_36 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_36
                       (py-make-builtin-class
                        (&& "ModuleNotFoundError")
                        (&& "__main__")
                        (list &py-builtin-ImportError)))
                 $%cls_36))))
     (set! &py-builtin-IndexError
           (let (($%cls_37 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_37
                       (py-make-builtin-class
                        (&& "IndexError")
                        (&& "__main__")
                        (list &py-builtin-LookupError)))
                 $%cls_37))))
     (set! &py-builtin-KeyError
           (let (($%cls_38 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_38
                       (py-make-builtin-class
                        (&& "KeyError")
                        (&& "__main__")
                        (list &py-builtin-LookupError)))
                 $%cls_38))))
     (set! &py-builtin-UnboundLocalError
           (let (($%cls_39 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_39
                       (py-make-builtin-class
                        (&& "UnboundLocalError")
                        (&& "__main__")
                        (list &py-builtin-NameError)))
                 $%cls_39))))
     (set! &py-builtin-BlockingIOError
           (let (($%cls_40 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_40
                       (py-make-builtin-class
                        (&& "BlockingIOError")
                        (&& "__main__")
                        (list &py-builtin-OSError)))
                 $%cls_40))))
     (set! &py-builtin-ChildProcessError
           (let (($%cls_41 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_41
                       (py-make-builtin-class
                        (&& "ChildProcessError")
                        (&& "__main__")
                        (list &py-builtin-OSError)))
                 $%cls_41))))
     (set! &py-builtin-ConnectionError
           (let (($%cls_42 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_42
                       (py-make-builtin-class
                        (&& "ConnectionError")
                        (&& "__main__")
                        (list &py-builtin-OSError)))
                 $%cls_42))))
     (set! &py-builtin-FileExistsError
           (let (($%cls_43 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_43
                       (py-make-builtin-class
                        (&& "FileExistsError")
                        (&& "__main__")
                        (list &py-builtin-OSError)))
                 $%cls_43))))
     (set! &py-builtin-FileNotFoundError
           (let (($%cls_44 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_44
                       (py-make-builtin-class
                        (&& "FileNotFoundError")
                        (&& "__main__")
                        (list &py-builtin-OSError)))
                 $%cls_44))))
     (set! &py-builtin-InterruptedError
           (let (($%cls_45 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_45
                       (py-make-builtin-class
                        (&& "InterruptedError")
                        (&& "__main__")
                        (list &py-builtin-OSError)))
                 $%cls_45))))
     (set! &py-builtin-IsADirectoryError
           (let (($%cls_46 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_46
                       (py-make-builtin-class
                        (&& "IsADirectoryError")
                        (&& "__main__")
                        (list &py-builtin-OSError)))
                 $%cls_46))))
     (set! &py-builtin-NotADirectoryError
           (let (($%cls_47 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_47
                       (py-make-builtin-class
                        (&& "NotADirectoryError")
                        (&& "__main__")
                        (list &py-builtin-OSError)))
                 $%cls_47))))
     (set! &py-builtin-PermissionError
           (let (($%cls_48 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_48
                       (py-make-builtin-class
                        (&& "PermissionError")
                        (&& "__main__")
                        (list &py-builtin-OSError)))
                 $%cls_48))))
     (set! &py-builtin-ProcessLookupError
           (let (($%cls_49 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_49
                       (py-make-builtin-class
                        (&& "ProcessLookupError")
                        (&& "__main__")
                        (list &py-builtin-OSError)))
                 $%cls_49))))
     (set! &py-builtin-TimeoutError
           (let (($%cls_50 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_50
                       (py-make-builtin-class
                        (&& "TimeoutError")
                        (&& "__main__")
                        (list &py-builtin-OSError)))
                 $%cls_50))))
     (set! &py-builtin-NotImplementedError
           (let (($%cls_51 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_51
                       (py-make-builtin-class
                        (&& "NotImplementedError")
                        (&& "__main__")
                        (list &py-builtin-RuntimeError)))
                 $%cls_51))))
     (set! &py-builtin-RecursionError
           (let (($%cls_52 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_52
                       (py-make-builtin-class
                        (&& "RecursionError")
                        (&& "__main__")
                        (list &py-builtin-RuntimeError)))
                 $%cls_52))))
     (set! &py-builtin-IndentationError
           (let (($%cls_53 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_53
                       (py-make-builtin-class
                        (&& "IndentationError")
                        (&& "__main__")
                        (list &py-builtin-SyntaxError)))
                 $%cls_53))))
     (set! &py-builtin-UnicodeError
           (let (($%cls_54 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_54
                       (py-make-builtin-class
                        (&& "UnicodeError")
                        (&& "__main__")
                        (list &py-builtin-ValueError)))
                 $%cls_54))))
     (set! &py-builtin-BytesWarning
           (let (($%cls_55 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_55
                       (py-make-builtin-class
                        (&& "BytesWarning")
                        (&& "__main__")
                        (list &py-builtin-Warning)))
                 $%cls_55))))
     (set! &py-builtin-DeprecationWarning
           (let (($%cls_56 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_56
                       (py-make-builtin-class
                        (&& "DeprecationWarning")
                        (&& "__main__")
                        (list &py-builtin-Warning)))
                 $%cls_56))))
     (set! &py-builtin-FutureWarning
           (let (($%cls_57 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_57
                       (py-make-builtin-class
                        (&& "FutureWarning")
                        (&& "__main__")
                        (list &py-builtin-Warning)))
                 $%cls_57))))
     (set! &py-builtin-ImportWarning
           (let (($%cls_58 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_58
                       (py-make-builtin-class
                        (&& "ImportWarning")
                        (&& "__main__")
                        (list &py-builtin-Warning)))
                 $%cls_58))))
     (set! &py-builtin-PendingDeprecationWarning
           (let (($%cls_59 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_59
                       (py-make-builtin-class
                        (&& "PendingDeprecationWarning")
                        (&& "__main__")
                        (list &py-builtin-Warning)))
                 $%cls_59))))
     (set! &py-builtin-ResourceWarning
           (let (($%cls_60 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_60
                       (py-make-builtin-class
                        (&& "ResourceWarning")
                        (&& "__main__")
                        (list &py-builtin-Warning)))
                 $%cls_60))))
     (set! &py-builtin-RuntimeWarning
           (let (($%cls_61 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_61
                       (py-make-builtin-class
                        (&& "RuntimeWarning")
                        (&& "__main__")
                        (list &py-builtin-Warning)))
                 $%cls_61))))
     (set! &py-builtin-SyntaxWarning
           (let (($%cls_62 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_62
                       (py-make-builtin-class
                        (&& "SyntaxWarning")
                        (&& "__main__")
                        (list &py-builtin-Warning)))
                 $%cls_62))))
     (set! &py-builtin-UnicodeWarning
           (let (($%cls_63 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_63
                       (py-make-builtin-class
                        (&& "UnicodeWarning")
                        (&& "__main__")
                        (list &py-builtin-Warning)))
                 $%cls_63))))
     (set! &py-builtin-UserWarning
           (let (($%cls_64 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_64
                       (py-make-builtin-class
                        (&& "UserWarning")
                        (&& "__main__")
                        (list &py-builtin-Warning)))
                 $%cls_64))))
     (set! &py-builtin-BrokenPipeError
           (let (($%cls_65 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_65
                       (py-make-builtin-class
                        (&& "BrokenPipeError")
                        (&& "__main__")
                        (list &py-builtin-ConnectionError)))
                 $%cls_65))))
     (set! &py-builtin-ConnectionAbortedError
           (let (($%cls_66 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_66
                       (py-make-builtin-class
                        (&& "ConnectionAbortedError")
                        (&& "__main__")
                        (list &py-builtin-ConnectionError)))
                 $%cls_66))))
     (set! &py-builtin-ConnectionRefusedError
           (let (($%cls_67 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_67
                       (py-make-builtin-class
                        (&& "ConnectionRefusedError")
                        (&& "__main__")
                        (list &py-builtin-ConnectionError)))
                 $%cls_67))))
     (set! &py-builtin-ConnectionResetError
           (let (($%cls_68 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_68
                       (py-make-builtin-class
                        (&& "ConnectionResetError")
                        (&& "__main__")
                        (list &py-builtin-ConnectionError)))
                 $%cls_68))))
     (set! &py-builtin-TabError
           (let (($%cls_69 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_69
                       (py-make-builtin-class
                        (&& "TabError")
                        (&& "__main__")
                        (list &py-builtin-IndentationError)))
                 $%cls_69))))
     (set! &py-builtin-UnicodeDecodeError
           (let (($%cls_70 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_70
                       (py-make-builtin-class
                        (&& "UnicodeDecodeError")
                        (&& "__main__")
                        (list &py-builtin-UnicodeError)))
                 $%cls_70))))
     (set! &py-builtin-UnicodeEncodeError
           (let (($%cls_71 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_71
                       (py-make-builtin-class
                        (&& "UnicodeEncodeError")
                        (&& "__main__")
                        (list &py-builtin-UnicodeError)))
                 $%cls_71))))
     (set! &py-builtin-UnicodeTranslateError
           (let (($%cls_72 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_72
                       (py-make-builtin-class
                        (&& "UnicodeTranslateError")
                        (&& "__main__")
                        (list &py-builtin-UnicodeError)))
                 $%cls_72)))))
   (define (init name package __path__) builtins-mod)
   (define (init-builtin-module name package __path__)
     (py-init-module)
     (let ((caches (py-make-caches 718))
           (module (py-make-module name package __path__)))
       (begin)
       (py-module module caches)
       module))
   (py-end-module)))
