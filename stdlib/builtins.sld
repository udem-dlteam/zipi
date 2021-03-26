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
         &py-builtin-NotImplementedError
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
         &py-builtin-__merge_many
         &py-builtin-__merge
         &py-builtin-range
         &py-builtin-StopIteration
         &py-builtin-range_iterator
         &py-builtin-str
         &py-builtin-float
         &py-builtin-convert_to_float
         &py-builtin-bool
         &py-builtin-ZeroDivisionError
         &py-builtin-ValueError
         &py-builtin-int
         &py-builtin-convert_to_int
         &py-builtin-classmethod
         &py-builtin-TypeError
         &py-builtin-method)
 (import (gambit) (zipi rts))
 (begin
   (py-begin-module)
   (define procedure:&py-builtin-convert_to_int
     (lambda (obj-13)
       (letrec* ((trunc_conversion-363 #f)
                 (index_conversion-360 #f)
                 (int_conversion-355 #f))
         (begin
           (set! int_conversion-355 (py-maybe-to-int obj-13))
           (if (py-test (py-is int_conversion-355 py-absent))
               (begin
                 (set! index_conversion-360 (py-maybe-index obj-13))
                 (if (py-test (py-is index_conversion-360 py-absent))
                     (begin
                       (set! trunc_conversion-363 (py-maybe-trunc obj-13))
                       (if (py-test (py-is trunc_conversion-363 py-absent))
                           (py-throw
                            (py-call &py-builtin-TypeError
                                     (py-add (py-add (&& "int() argument must be a string, a bytes-like object or a number, not '")
                                                     (py-getattribute
                                                      (py-obj-cls obj-13)
                                                      (& "__name__")))
                                             (&& "'"))))
                           trunc_conversion-363))
                     index_conversion-360))
               int_conversion-355)))))
   (define procedure:&py-builtin-convert_to_float
     (lambda (obj-121)
       (letrec* ((float_conversion-997 #f))
         (begin
           (set! float_conversion-997 (py-maybe-to-float obj-121))
           (if (py-test (py-is float_conversion-997 py-absent))
               (py-throw
                (py-call &py-builtin-TypeError
                         (py-add (py-add (&& "float() argument must be a string or a number, not '")
                                         (py-getattribute
                                          (py-obj-cls obj-121)
                                          (& "__name__")))
                                 (&& "'"))))
               float_conversion-997)))))
   (define procedure:&py-builtin-__merge
     (lambda (l1-213 l2-214)
       (letrec* ((output-1582 #f) (i-1580 #f) (j-1578 #f))
         (begin
           (&& "\n    Merge all items from two sorted list into one sorted list.\n    Time complexity: O(n) where n is the total number of elements\n    ")
           (letrec* ((%tmp0-215 (py-int-from-scheme 0)))
             (begin
               (set! j-1578
                     (or %tmp0-215
                         (py-throw-exception-with-message
                          py-builtin-UnboundLocalError
                          "local variable '%tmp0' referenced before assignment")))
               (set! i-1580
                     (or %tmp0-215
                         (py-throw-exception-with-message
                          py-builtin-UnboundLocalError
                          "local variable '%tmp0' referenced before assignment")))))
           (set! output-1582 (py-make-list))
           (let $%while_77 ()
             (when (and
                    (py-test (py-lt (or i-1580
                                        (py-throw-exception-with-message
                                         py-builtin-UnboundLocalError
                                         "local variable 'i' referenced before assignment"))
                                    (py-call (global-get
                                              %global
                                              (& "len")
                                              (vector-ref %caches 574))
                                             l1-213)))
                    (py-test (py-lt (or j-1578
                                        (py-throw-exception-with-message
                                         py-builtin-UnboundLocalError
                                         "local variable 'j' referenced before assignment"))
                                    (py-call (global-get
                                              %global
                                              (& "len")
                                              (vector-ref %caches 575))
                                             l2-214))))
               (if (py-test (py-le (py-getitem
                                    l1-213
                                    (or i-1580
                                        (py-throw-exception-with-message
                                         py-builtin-UnboundLocalError
                                         "local variable 'i' referenced before assignment")))
                                   (py-getitem
                                    l2-214
                                    (or j-1578
                                        (py-throw-exception-with-message
                                         py-builtin-UnboundLocalError
                                         "local variable 'j' referenced before assignment")))))
                   (begin
                     (py-call (py-getattribute output-1582 (& "append"))
                              (py-getitem
                               l1-213
                               (or i-1580
                                   (py-throw-exception-with-message
                                    py-builtin-UnboundLocalError
                                    "local variable 'i' referenced before assignment"))))
                     (set! i-1580
                           (py-iadd (or i-1580
                                        (py-throw-exception-with-message
                                         py-builtin-UnboundLocalError
                                         "local variable 'i' referenced before assignment"))
                                    (py-int-from-scheme 1))))
                   (begin
                     (py-call (py-getattribute output-1582 (& "append"))
                              (py-getitem
                               l2-214
                               (or j-1578
                                   (py-throw-exception-with-message
                                    py-builtin-UnboundLocalError
                                    "local variable 'j' referenced before assignment"))))
                     (set! j-1578
                           (py-iadd (or j-1578
                                        (py-throw-exception-with-message
                                         py-builtin-UnboundLocalError
                                         "local variable 'j' referenced before assignment"))
                                    (py-int-from-scheme 1)))))
               ($%while_77)))
           (py-call (py-getattribute output-1582 (& "extend"))
                    (py-add (py-getitem
                             l1-213
                             (py-slice-from-scheme
                              (or i-1580
                                  (py-throw-exception-with-message
                                   py-builtin-UnboundLocalError
                                   "local variable 'i' referenced before assignment"))
                              py-None
                              py-None))
                            (py-getitem
                             l2-214
                             (py-slice-from-scheme
                              (or j-1578
                                  (py-throw-exception-with-message
                                   py-builtin-UnboundLocalError
                                   "local variable 'j' referenced before assignment"))
                              py-None
                              py-None))))
           output-1582))))
   (define procedure:&py-builtin-__merge_many
     (lambda (lsts-216)
       (letrec* ((right-1592 #f) (left-1590 #f))
         (begin
           (&& "\n    Merge all items from k lists into one sorted list.\n    Time complexity: O(n log(k)) where n is the total number of elements and k the number of lists\n    ")
           (if (py-test (py-not lsts-216))
               (py-make-list)
               (if (py-test (py-eq (py-call (global-get
                                             %global
                                             (& "len")
                                             (vector-ref %caches 583))
                                            lsts-216)
                                   (py-int-from-scheme 1)))
                   (py-getitem
                    (py-getitem lsts-216 (py-int-from-scheme 0))
                    (py-slice-from-scheme py-None py-None py-None))
                   (if (py-test (py-eq (py-call (global-get
                                                 %global
                                                 (& "len")
                                                 (vector-ref %caches 584))
                                                lsts-216)
                                       (py-int-from-scheme 2)))
                       (procedure:&py-builtin-__merge
                        (py-getitem lsts-216 (py-int-from-scheme 0))
                        (py-getitem lsts-216 (py-int-from-scheme 1)))
                       (begin
                         (set! left-1590
                               (py-getitem
                                lsts-216
                                (py-slice-from-scheme
                                 (py-floordiv
                                  (py-call (global-get
                                            %global
                                            (& "len")
                                            (vector-ref %caches 586))
                                           lsts-216)
                                  (py-int-from-scheme 2))
                                 py-None
                                 py-None)))
                         (set! right-1592
                               (py-getitem
                                lsts-216
                                (py-slice-from-scheme
                                 py-None
                                 (py-floordiv
                                  (py-call (global-get
                                            %global
                                            (& "len")
                                            (vector-ref %caches 587))
                                           lsts-216)
                                  (py-int-from-scheme 2))
                                 py-None)))
                         (procedure:&py-builtin-__merge
                          (procedure:&py-builtin-__merge_many left-1590)
                          (procedure:&py-builtin-__merge_many
                           right-1592))))))))))
   (define procedure:&py-builtin-sorted
     (lambda (lst-217 key-218 reversed-219)
       (letrec* ((i-1597 #f) (sublsts-1595 #f))
         (begin
           (&& "\n    Timsort is an improved version of Merge Sort which splits the list into monotonic sub-lists before merging them\n    into a sorted list.\n    Worst case time complexity: O(n log(n))\n    Best cast time complexity:  O(n) when the list is almost sorted\n        where n is the number of elements in the list\n    ")
           (set! sublsts-1595 (py-make-list))
           (set! i-1597 (py-int-from-scheme 0))
           (let $%while_78 ()
             (when (py-test
                    (py-lt i-1597
                           (py-call (global-get
                                     %global
                                     (& "len")
                                     (vector-ref %caches 592))
                                    lst-217)))
               (begin
                 (py-call (py-getattribute sublsts-1595 (& "append"))
                          (py-make-list (py-getitem lst-217 i-1597)))
                 (set! i-1597
                       (py-iadd (or i-1597
                                    (py-throw-exception-with-message
                                     py-builtin-UnboundLocalError
                                     "local variable 'i' referenced before assignment"))
                                (py-int-from-scheme 1)))
                 (if (and (py-test (py-lt i-1597
                                          (py-call (global-get
                                                    %global
                                                    (& "len")
                                                    (vector-ref %caches 595))
                                                   lst-217)))
                          (py-test (py-ge (py-getitem lst-217 i-1597)
                                          (py-getitem
                                           lst-217
                                           (py-sub i-1597
                                                   (py-int-from-scheme 1))))))
                     (let $%while_79 ()
                       (when (and
                              (py-test (py-lt i-1597
                                              (py-call (global-get
                                                        %global
                                                        (& "len")
                                                        (vector-ref
                                                         %caches
                                                         596))
                                                       lst-217)))
                              (py-test (py-ge (py-getitem lst-217 i-1597)
                                              (py-getitem
                                               lst-217
                                               (py-sub i-1597
                                                       (py-int-from-scheme
                                                        1))))))
                         (begin
                           (py-call (py-getattribute
                                     (py-getitem
                                      sublsts-1595
                                      (py-neg (py-int-from-scheme 1)))
                                     (& "append"))
                                    (py-getitem lst-217 i-1597))
                           (set! i-1597
                                 (py-iadd (or i-1597
                                              (py-throw-exception-with-message
                                               py-builtin-UnboundLocalError
                                               "local variable 'i' referenced before assignment"))
                                          (py-int-from-scheme 1))))
                         ($%while_79)))
                     (if (py-test (py-lt i-1597
                                         (py-call (global-get
                                                   %global
                                                   (& "len")
                                                   (vector-ref %caches 600))
                                                  lst-217)))
                         (begin
                           (let $%while_80 ()
                             (when (and
                                    (py-test (py-lt i-1597
                                                    (py-call (global-get
                                                              %global
                                                              (& "len")
                                                              (vector-ref
                                                               %caches
                                                               601))
                                                             lst-217)))
                                    (py-test (py-lt (py-getitem lst-217 i-1597)
                                                    (py-getitem
                                                     lst-217
                                                     (py-sub i-1597
                                                             (py-int-from-scheme
                                                              1))))))
                               (begin
                                 (py-call (py-getattribute
                                           (py-getitem
                                            sublsts-1595
                                            (py-neg (py-int-from-scheme 1)))
                                           (& "append"))
                                          (py-getitem lst-217 i-1597))
                                 (set! i-1597
                                       (py-iadd (or i-1597
                                                    (py-throw-exception-with-message
                                                     py-builtin-UnboundLocalError
                                                     "local variable 'i' referenced before assignment"))
                                                (py-int-from-scheme 1))))
                               ($%while_80)))
                           (py-setitem
                            (or sublsts-1595
                                (py-throw-exception-with-message
                                 py-builtin-UnboundLocalError
                                 "local variable 'sublsts' referenced before assignment"))
                            (py-neg (py-int-from-scheme 1))
                            (py-getitem
                             (py-getitem
                              (or sublsts-1595
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
           (procedure:&py-builtin-__merge_many sublsts-1595)))))
   (declare (separate))
   (define %global #f)
   (define %caches #f)
   (define init:&py-builtin-convert_to_int '%uninit)
   (define init:&py-builtin-convert_to_float '%uninit)
   (define init:&py-builtin-__merge '%uninit)
   (define init:&py-builtin-__merge_many '%uninit)
   (define init:&py-builtin-sorted '%uninit)
   (define &py-builtin-UnicodeTranslateError #f)
   (define &py-builtin-UnicodeEncodeError #f)
   (define &py-builtin-UnicodeDecodeError #f)
   (define &py-builtin-TabError #f)
   (define &py-builtin-ConnectionResetError #f)
   (define &py-builtin-ConnectionRefusedError #f)
   (define &py-builtin-ConnectionAbortedError #f)
   (define &py-builtin-BrokenPipeError #f)
   (define &py-builtin-UserWarning #f)
   (define &py-builtin-UnicodeWarning #f)
   (define &py-builtin-SyntaxWarning #f)
   (define &py-builtin-RuntimeWarning #f)
   (define &py-builtin-ResourceWarning #f)
   (define &py-builtin-PendingDeprecationWarning #f)
   (define &py-builtin-ImportWarning #f)
   (define &py-builtin-FutureWarning #f)
   (define &py-builtin-DeprecationWarning #f)
   (define &py-builtin-BytesWarning #f)
   (define &py-builtin-UnicodeError #f)
   (define &py-builtin-IndentationError #f)
   (define &py-builtin-RecursionError #f)
   (define &py-builtin-NotImplementedError #f)
   (define &py-builtin-TimeoutError #f)
   (define &py-builtin-ProcessLookupError #f)
   (define &py-builtin-PermissionError #f)
   (define &py-builtin-NotADirectoryError #f)
   (define &py-builtin-IsADirectoryError #f)
   (define &py-builtin-InterruptedError #f)
   (define &py-builtin-FileNotFoundError #f)
   (define &py-builtin-FileExistsError #f)
   (define &py-builtin-ConnectionError #f)
   (define &py-builtin-ChildProcessError #f)
   (define &py-builtin-BlockingIOError #f)
   (define &py-builtin-UnboundLocalError #f)
   (define &py-builtin-KeyError #f)
   (define &py-builtin-IndexError #f)
   (define &py-builtin-ModuleNotFoundError #f)
   (define &py-builtin-OverflowError #f)
   (define &py-builtin-FloatingPointError #f)
   (define &py-builtin-Warning #f)
   (define &py-builtin-SystemError #f)
   (define &py-builtin-SyntaxError #f)
   (define &py-builtin-StopAsyncIteration #f)
   (define &py-builtin-RuntimeError #f)
   (define &py-builtin-ReferenceError #f)
   (define &py-builtin-WindowsError #f)
   (define &py-builtin-OSError #f)
   (define &py-builtin-IOError #f)
   (define &py-builtin-EnvironmentError #f)
   (define &py-builtin-NameError #f)
   (define &py-builtin-MemoryError #f)
   (define &py-builtin-LookupError #f)
   (define &py-builtin-ImportError #f)
   (define &py-builtin-EOFError #f)
   (define &py-builtin-BufferError #f)
   (define &py-builtin-AttributeError #f)
   (define &py-builtin-AssertionError #f)
   (define &py-builtin-ArithmeticError #f)
   (define &py-builtin-SystemExit #f)
   (define &py-builtin-KeyboardInterrupt #f)
   (define &py-builtin-GeneratorExit #f)
   (define &py-builtin-Exception #f)
   (define &py-builtin-BaseException #f)
   (define &py-builtin-sorted #f)
   (define &py-builtin-__merge_many #f)
   (define &py-builtin-__merge #f)
   (define &py-builtin-range #f)
   (define &py-builtin-StopIteration #f)
   (define &py-builtin-range_iterator #f)
   (define &py-builtin-str #f)
   (define &py-builtin-float #f)
   (define &py-builtin-convert_to_float #f)
   (define &py-builtin-bool #f)
   (define &py-builtin-ZeroDivisionError #f)
   (define &py-builtin-ValueError #f)
   (define &py-builtin-int #f)
   (define &py-builtin-convert_to_int #f)
   (define &py-builtin-classmethod #f)
   (define &py-builtin-TypeError #f)
   (define &py-builtin-method #f)
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
      (& "NotImplementedError")
      (lambda () &py-builtin-NotImplementedError)
      (lambda (v) (set! &py-builtin-NotImplementedError v)))
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
      (& "int")
      (lambda () &py-builtin-int)
      (lambda (v) (set! &py-builtin-int v)))
     (global-register!
      %global
      (& "classmethod")
      (lambda () &py-builtin-classmethod)
      (lambda (v) (set! &py-builtin-classmethod v)))
     (global-register!
      %global
      (& "TypeError")
      (lambda () &py-builtin-TypeError)
      (lambda (v) (set! &py-builtin-TypeError v)))
     (set! &py-builtin-method
           (let (($%cls_0 py-absent))
             (letrec* ((__call__-325 #f) (__new__-323 #f))
               (begin
                 (set! __new__-323
                       (procedure->py-function
                        (lambda (cls-2 method_-3 self-4)
                          (letrec* ()
                            (begin
                              (if (py-test (py-is cls-2 &py-builtin-method))
                                  (make-PyObjectMethod
                                   py-method-hclass-of-instances
                                   '#()
                                   py-method-class
                                   self-4
                                   method_-3)
                                  (py-throw
                                   (py-call &py-builtin-TypeError
                                            (&& "method.__new__ expected a subtype of 'method' as first argument"))))
                              py-None)))
                        (make-signature args: (cls method_ self))))
                 (set! __call__-325
                       (procedure->py-function
                        (lambda (self-5 args-6 kwargs-7)
                          (letrec* ()
                            (py-call (PyObjectMethod-method self-5)
                                     (PyObjectMethod-self self-5)
                                     *:
                                     args-6
                                     **:
                                     kwargs-7)))
                        (make-signature
                         args:
                         (self)
                         vararg:
                         args
                         kwarg:
                         kwargs))))
               (begin
                 (set! $%cls_0
                       (py-make-builtin-class
                        (&& "method")
                        (&& "__main__")
                        (list)
                        (& "__call__")
                        __call__-325
                        (& "__new__")
                        __new__-323))
                 $%cls_0))))
     (set! &py-builtin-classmethod
           (let (($%cls_1 py-absent))
             (letrec* ((__get__-338 #f) (__new__-336 #f))
               (begin
                 (set! __new__-336
                       (procedure->py-function
                        (lambda (cls-8 obj-9)
                          (letrec* ()
                            (if (py-test (py-is cls-8 &py-builtin-classmethod))
                                (make-PyObjectMethodWrapper
                                 py-object-hclass-of-instances
                                 '#()
                                 py-builtin-classmethod
                                 obj-9)
                                (if (py-isinstance?
                                     cls-8
                                     &py-builtin-classmethod)
                                    (make-PyObjectMethodWrapper
                                     py-object-hclass-of-instances
                                     '#()
                                     cls-8
                                     obj-9)
                                    (py-throw
                                     (py-call &py-builtin-TypeError
                                              (&& "classmethod.__new__ expected a subtype of 'classmethod' as first argument")))))))
                        (make-signature args: (cls obj))))
                 (set! __get__-338
                       (procedure->py-function
                        (lambda (self-10 instance-11 owner-12)
                          (letrec* ()
                            (if (py-isinstance?
                                 self-10
                                 &py-builtin-classmethod)
                                (if (py-test (py-is owner-12 py-None))
                                    (make-PyObjectMethod
                                     py-method-hclass-of-instances
                                     '#()
                                     py-method-class
                                     (py-obj-cls instance-11)
                                     (PyObjectMethodWrapper-method self-10))
                                    (make-PyObjectMethod
                                     py-method-hclass-of-instances
                                     '#()
                                     py-method-class
                                     owner-12
                                     (PyObjectMethodWrapper-method self-10)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__get__' requires a 'classmethod' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-10)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature
                         args:
                         (self instance owner)
                         defaults:
                         (vector py-None)))))
               (begin
                 (set! $%cls_1
                       (py-make-builtin-class
                        (&& "classmethod")
                        (&& "__main__")
                        (list)
                        (& "__get__")
                        __get__-338
                        (& "__new__")
                        __new__-336))
                 $%cls_1))))
     (let (($fun-obj
            (procedure->py-function
             procedure:&py-builtin-convert_to_int
             (make-signature args: (obj)))))
       (set! &py-builtin-convert_to_int $fun-obj)
       (set! init:&py-builtin-convert_to_int $fun-obj))
     (set! &py-builtin-int
           (let (($%cls_2 py-absent))
             (letrec* ((__lt__-465 #f)
                       (__le__-463 #f)
                       (__gt__-461 #f)
                       (__ge__-459 #f)
                       (__ne__-457 #f)
                       (__eq__-455 #f)
                       (__imod__-453 #f)
                       (__rmod__-451 #f)
                       (__mod__-449 #f)
                       (__itruediv__-447 #f)
                       (__rtruediv__-445 #f)
                       (__truediv__-443 #f)
                       (__ifloordiv__-441 #f)
                       (__rfloordiv__-439 #f)
                       (__floordiv__-437 #f)
                       (__invert__-435 #f)
                       (__neg__-433 #f)
                       (__pos__-431 #f)
                       (__irshift__-429 #f)
                       (__rrshift__-427 #f)
                       (__rshift__-425 #f)
                       (__ilshift__-423 #f)
                       (__rlshift__-421 #f)
                       (__lshift__-419 #f)
                       (__ixor__-417 #f)
                       (__rxor__-415 #f)
                       (__xor__-413 #f)
                       (__isub__-411 #f)
                       (__rsub__-409 #f)
                       (__sub__-407 #f)
                       (__ipow__-405 #f)
                       (__rpow__-403 #f)
                       (__pow__-401 #f)
                       (__imul__-399 #f)
                       (__rmul__-397 #f)
                       (__mul__-395 #f)
                       (__ior__-393 #f)
                       (__ror__-391 #f)
                       (__or__-389 #f)
                       (__iand__-387 #f)
                       (__rand__-385 #f)
                       (__and__-383 #f)
                       (__iadd__-381 #f)
                       (__radd__-379 #f)
                       (__add__-377 #f)
                       (__abs__-375 #f)
                       (__index__-373 #f)
                       (__bool__-371 #f)
                       (__new__-368 #f))
               (begin
                 (set! __new__-368
                       (procedure->py-function
                        (lambda (cls-14 val-15)
                          (letrec* ()
                            (if (py-test (py-is cls-14 &py-builtin-int))
                                (if (py-test (py-is val-15 py-absent))
                                    (py-int-from-scheme 0)
                                    (procedure:&py-builtin-convert_to_int
                                     val-15))
                                (if (and (py-isinstance?
                                          cls-14
                                          (global-get
                                           %global
                                           (& "type")
                                           (vector-ref %caches 16)))
                                         (py-test (py-call (global-get
                                                            %global
                                                            (& "issubclass")
                                                            (vector-ref
                                                             %caches
                                                             17))
                                                           cls-14
                                                           &py-builtin-int)))
                                    (if (py-test (py-is val-15 py-absent))
                                        (make-PyObjectInt
                                         py-int-hclass-of-instances
                                         '#()
                                         cls-14
                                         0)
                                        (make-PyObjectInt
                                         py-int-hclass-of-instances
                                         '#()
                                         cls-14
                                         (py-int-to-scheme
                                          (procedure:&py-builtin-convert_to_int
                                           val-15))))
                                    (py-throw
                                     (py-call &py-builtin-TypeError
                                              (&& "int.__new__ expected a subtype of 'int' as first argument")))))))
                        (make-signature
                         args:
                         (cls val)
                         defaults:
                         (vector py-absent))))
                 (set! __bool__-371
                       (procedure->py-function
                        (lambda (self-16)
                          (letrec* ()
                            (if (py-isinstance? self-16 &py-builtin-int)
                                (py-ne self-16 (py-int-from-scheme 0))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__bool__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-16)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __index__-373
                       (procedure->py-function
                        (lambda (self-17)
                          (letrec* ()
                            (if (py-isinstance? self-17 &py-builtin-int)
                                (py-int-from-scheme (py-int-to-scheme self-17))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__index__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-17)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __abs__-375
                       (procedure->py-function
                        (lambda (self-18)
                          (letrec* ()
                            (if (py-isinstance? self-18 &py-builtin-int)
                                (if (py-test (py-lt self-18
                                                    (py-int-from-scheme 0)))
                                    (py-int-from-scheme
                                     (pyneg (py-int-to-scheme self-18)))
                                    (py-int-from-scheme
                                     (py-int-to-scheme self-18)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__abs__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-18)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __add__-377
                       (procedure->py-function
                        (lambda (self-19 other-20)
                          (letrec* ()
                            (if (py-isinstance? self-19 &py-builtin-int)
                                (if (py-isinstance? other-20 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py+ (py-int-to-scheme self-19)
                                          (py-int-to-scheme other-20)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 33)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__add__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-19)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __radd__-379
                       (procedure->py-function
                        (lambda (self-21 other-22)
                          (letrec* ()
                            (if (py-isinstance? self-21 &py-builtin-int)
                                (if (py-isinstance? other-22 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py+ (py-int-to-scheme other-22)
                                          (py-int-to-scheme self-21)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 38)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__radd__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-21)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __iadd__-381
                       (procedure->py-function
                        (lambda (self-23 other-24)
                          (letrec* ()
                            (if (py-isinstance? self-23 &py-builtin-int)
                                (if (py-isinstance? other-24 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py+ (py-int-to-scheme self-23)
                                          (py-int-to-scheme other-24)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 43)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__iadd__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-23)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __and__-383
                       (procedure->py-function
                        (lambda (self-25 other-26)
                          (letrec* ()
                            (if (py-isinstance? self-25 &py-builtin-int)
                                (if (py-isinstance? other-26 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py& (py-int-to-scheme self-25)
                                          (py-int-to-scheme other-26)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 48)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__and__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-25)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rand__-385
                       (procedure->py-function
                        (lambda (self-27 other-28)
                          (letrec* ()
                            (if (py-isinstance? self-27 &py-builtin-int)
                                (if (py-isinstance? other-28 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py& (py-int-to-scheme other-28)
                                          (py-int-to-scheme self-27)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 53)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rand__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-27)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __iand__-387
                       (procedure->py-function
                        (lambda (self-29 other-30)
                          (letrec* ()
                            (if (py-isinstance? self-29 &py-builtin-int)
                                (if (py-isinstance? other-30 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py& (py-int-to-scheme self-29)
                                          (py-int-to-scheme other-30)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 58)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__iand__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-29)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __or__-389
                       (procedure->py-function
                        (lambda (self-31 other-32)
                          (letrec* ()
                            (if (py-isinstance? self-31 &py-builtin-int)
                                (if (py-isinstance? other-32 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py+b (py-int-to-scheme self-31)
                                           (py-int-to-scheme other-32)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 63)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__or__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-31)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ror__-391
                       (procedure->py-function
                        (lambda (self-33 other-34)
                          (letrec* ()
                            (if (py-isinstance? self-33 &py-builtin-int)
                                (if (py-isinstance? other-34 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py+b (py-int-to-scheme other-34)
                                           (py-int-to-scheme self-33)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 68)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ror__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-33)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ior__-393
                       (procedure->py-function
                        (lambda (self-35 other-36)
                          (letrec* ()
                            (if (py-isinstance? self-35 &py-builtin-int)
                                (if (py-isinstance? other-36 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py+b (py-int-to-scheme self-35)
                                           (py-int-to-scheme other-36)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 73)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ior__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-35)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __mul__-395
                       (procedure->py-function
                        (lambda (self-37 other-38)
                          (letrec* ()
                            (if (py-isinstance? self-37 &py-builtin-int)
                                (if (py-isinstance? other-38 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py* (py-int-to-scheme self-37)
                                          (py-int-to-scheme other-38)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 78)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__mul__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-37)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rmul__-397
                       (procedure->py-function
                        (lambda (self-39 other-40)
                          (letrec* ()
                            (if (py-isinstance? self-39 &py-builtin-int)
                                (if (py-isinstance? other-40 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py* (py-int-to-scheme other-40)
                                          (py-int-to-scheme self-39)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 83)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rmul__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-39)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __imul__-399
                       (procedure->py-function
                        (lambda (self-41 other-42)
                          (letrec* ()
                            (if (py-isinstance? self-41 &py-builtin-int)
                                (if (py-isinstance? other-42 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py* (py-int-to-scheme self-41)
                                          (py-int-to-scheme other-42)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 88)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__imul__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-41)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __pow__-401
                       (procedure->py-function
                        (lambda (self-43 other-44)
                          (letrec* ()
                            (if (py-isinstance? self-43 &py-builtin-int)
                                (if (py-isinstance? other-44 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py** (py-int-to-scheme self-43)
                                           (py-int-to-scheme other-44)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 93)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__pow__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-43)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rpow__-403
                       (procedure->py-function
                        (lambda (self-45 other-46)
                          (letrec* ()
                            (if (py-isinstance? self-45 &py-builtin-int)
                                (if (py-isinstance? other-46 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py** (py-int-to-scheme other-46)
                                           (py-int-to-scheme self-45)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 98)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rpow__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-45)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ipow__-405
                       (procedure->py-function
                        (lambda (self-47 other-48)
                          (letrec* ()
                            (if (py-isinstance? self-47 &py-builtin-int)
                                (if (py-isinstance? other-48 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py** (py-int-to-scheme self-47)
                                           (py-int-to-scheme other-48)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 103)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ipow__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-47)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __sub__-407
                       (procedure->py-function
                        (lambda (self-49 other-50)
                          (letrec* ()
                            (if (py-isinstance? self-49 &py-builtin-int)
                                (if (py-isinstance? other-50 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py- (py-int-to-scheme self-49)
                                          (py-int-to-scheme other-50)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 108)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__sub__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-49)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rsub__-409
                       (procedure->py-function
                        (lambda (self-51 other-52)
                          (letrec* ()
                            (if (py-isinstance? self-51 &py-builtin-int)
                                (if (py-isinstance? other-52 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py- (py-int-to-scheme other-52)
                                          (py-int-to-scheme self-51)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 113)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rsub__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-51)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __isub__-411
                       (procedure->py-function
                        (lambda (self-53 other-54)
                          (letrec* ()
                            (if (py-isinstance? self-53 &py-builtin-int)
                                (if (py-isinstance? other-54 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py- (py-int-to-scheme self-53)
                                          (py-int-to-scheme other-54)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 118)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__isub__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-53)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __xor__-413
                       (procedure->py-function
                        (lambda (self-55 other-56)
                          (letrec* ()
                            (if (py-isinstance? self-55 &py-builtin-int)
                                (if (py-isinstance? other-56 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py^ (py-int-to-scheme self-55)
                                          (py-int-to-scheme other-56)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 123)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__xor__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-55)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rxor__-415
                       (procedure->py-function
                        (lambda (self-57 other-58)
                          (letrec* ()
                            (if (py-isinstance? self-57 &py-builtin-int)
                                (if (py-isinstance? other-58 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py^ (py-int-to-scheme other-58)
                                          (py-int-to-scheme self-57)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 128)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rxor__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-57)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ixor__-417
                       (procedure->py-function
                        (lambda (self-59 other-60)
                          (letrec* ()
                            (if (py-isinstance? self-59 &py-builtin-int)
                                (if (py-isinstance? other-60 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py^ (py-int-to-scheme self-59)
                                          (py-int-to-scheme other-60)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 133)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ixor__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-59)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __lshift__-419
                       (procedure->py-function
                        (lambda (self-61 other-62)
                          (letrec* ()
                            (if (py-isinstance? self-61 &py-builtin-int)
                                (if (py-isinstance? other-62 &py-builtin-int)
                                    (if (py-test (py-ge other-62
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py<< (py-int-to-scheme self-61)
                                               (py-int-to-scheme other-62)))
                                        (py-throw
                                         (py-call &py-builtin-ValueError
                                                  (&& "negative shift count"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 139)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__lshift__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-61)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rlshift__-421
                       (procedure->py-function
                        (lambda (self-63 other-64)
                          (letrec* ()
                            (if (py-isinstance? self-63 &py-builtin-int)
                                (if (py-isinstance? other-64 &py-builtin-int)
                                    (if (py-test (py-ge self-63
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py<< (py-int-to-scheme self-63)
                                               (py-int-to-scheme other-64)))
                                        (py-throw
                                         (py-call &py-builtin-ValueError
                                                  (&& "negative shift count"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 145)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rlshift__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-63)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ilshift__-423
                       (procedure->py-function
                        (lambda (self-65 other-66)
                          (letrec* ()
                            (if (py-isinstance? self-65 &py-builtin-int)
                                (if (py-isinstance? other-66 &py-builtin-int)
                                    (if (py-test (py-ge other-66
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py<< (py-int-to-scheme self-65)
                                               (py-int-to-scheme other-66)))
                                        (py-throw
                                         (py-call &py-builtin-ValueError
                                                  (&& "negative shift count"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 151)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ilshift__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-65)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rshift__-425
                       (procedure->py-function
                        (lambda (self-67 other-68)
                          (letrec* ()
                            (if (py-isinstance? self-67 &py-builtin-int)
                                (if (py-isinstance? other-68 &py-builtin-int)
                                    (if (py-test (py-ge other-68
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py>> (py-int-to-scheme self-67)
                                               (py-int-to-scheme other-68)))
                                        (py-throw
                                         (py-call &py-builtin-ValueError
                                                  (&& "negative shift count"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 157)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rshift__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-67)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rrshift__-427
                       (procedure->py-function
                        (lambda (self-69 other-70)
                          (letrec* ()
                            (if (py-isinstance? self-69 &py-builtin-int)
                                (if (py-isinstance? other-70 &py-builtin-int)
                                    (if (py-test (py-ge self-69
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py>> (py-int-to-scheme self-69)
                                               (py-int-to-scheme other-70)))
                                        (py-throw
                                         (py-call &py-builtin-ValueError
                                                  (&& "negative shift count"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 163)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rrshift__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-69)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __irshift__-429
                       (procedure->py-function
                        (lambda (self-71 other-72)
                          (letrec* ()
                            (if (py-isinstance? self-71 &py-builtin-int)
                                (if (py-isinstance? other-72 &py-builtin-int)
                                    (if (py-test (py-ge other-72
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py>> (py-int-to-scheme self-71)
                                               (py-int-to-scheme other-72)))
                                        (py-throw
                                         (py-call &py-builtin-ValueError
                                                  (&& "negative shift count"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 169)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__irshift__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-71)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __pos__-431
                       (procedure->py-function
                        (lambda (self-73)
                          (letrec* ()
                            (if (py-isinstance? self-73 &py-builtin-int)
                                (py-int-from-scheme (py-int-to-scheme self-73))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__pos__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-73)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __neg__-433
                       (procedure->py-function
                        (lambda (self-74)
                          (letrec* ()
                            (if (py-isinstance? self-74 &py-builtin-int)
                                (py-int-from-scheme
                                 (pyneg (py-int-to-scheme self-74)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__neg__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-74)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __invert__-435
                       (procedure->py-function
                        (lambda (self-75)
                          (letrec* ()
                            (if (py-isinstance? self-75 &py-builtin-int)
                                (py-int-from-scheme
                                 (pyinvert (py-int-to-scheme self-75)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__invert__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-75)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __floordiv__-437
                       (procedure->py-function
                        (lambda (self-76 other-77)
                          (letrec* ()
                            (if (py-isinstance? self-76 &py-builtin-int)
                                (if (py-isinstance? other-77 &py-builtin-int)
                                    (if (py-test (py-ne other-77
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py// (py-int-to-scheme self-76)
                                               (py-int-to-scheme other-77)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "integer division by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 186)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__floordiv__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-76)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rfloordiv__-439
                       (procedure->py-function
                        (lambda (self-78 other-79)
                          (letrec* ()
                            (if (py-isinstance? self-78 &py-builtin-int)
                                (if (py-isinstance? other-79 &py-builtin-int)
                                    (if (py-test (py-ne self-78
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py// (py-int-to-scheme other-79)
                                               (py-int-to-scheme self-78)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "integer division by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 192)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rfloordiv__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-78)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ifloordiv__-441
                       (procedure->py-function
                        (lambda (self-80 other-81)
                          (letrec* ()
                            (if (py-isinstance? self-80 &py-builtin-int)
                                (if (py-isinstance? other-81 &py-builtin-int)
                                    (if (py-test (py-ne other-81
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py// (py-int-to-scheme self-80)
                                               (py-int-to-scheme other-81)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "integer division by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 198)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ifloordiv__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-80)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __truediv__-443
                       (procedure->py-function
                        (lambda (self-82 other-83)
                          (letrec* ()
                            (if (py-isinstance? self-82 &py-builtin-int)
                                (if (py-isinstance? other-83 &py-builtin-int)
                                    (if (py-test (py-ne other-83
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-float-from-scheme
                                         (py/ (py-int-to-scheme self-82)
                                              (py-int-to-scheme other-83)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "division by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 204)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__truediv__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-82)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rtruediv__-445
                       (procedure->py-function
                        (lambda (self-84 other-85)
                          (letrec* ()
                            (if (py-isinstance? self-84 &py-builtin-int)
                                (if (py-isinstance? other-85 &py-builtin-int)
                                    (if (py-test (py-ne self-84
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-float-from-scheme
                                         (py/ (py-int-to-scheme other-85)
                                              (py-int-to-scheme self-84)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "division by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 210)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rtruediv__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-84)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __itruediv__-447
                       (procedure->py-function
                        (lambda (self-86 other-87)
                          (letrec* ()
                            (if (py-isinstance? self-86 &py-builtin-int)
                                (if (py-isinstance? other-87 &py-builtin-int)
                                    (if (py-test (py-ne other-87
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-float-from-scheme
                                         (py/ (py-int-to-scheme self-86)
                                              (py-int-to-scheme other-87)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "division by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 216)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__itruediv__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-86)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __mod__-449
                       (procedure->py-function
                        (lambda (self-88 other-89)
                          (letrec* ()
                            (if (py-isinstance? self-88 &py-builtin-int)
                                (if (py-isinstance? other-89 &py-builtin-int)
                                    (if (py-test (py-ne other-89
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py% (py-int-to-scheme self-88)
                                              (py-int-to-scheme other-89)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "modulo by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 222)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__mod__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-88)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rmod__-451
                       (procedure->py-function
                        (lambda (self-90 other-91)
                          (letrec* ()
                            (if (py-isinstance? self-90 &py-builtin-int)
                                (if (py-isinstance? other-91 &py-builtin-int)
                                    (if (py-test (py-ne self-90
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py% (py-int-to-scheme other-91)
                                              (py-int-to-scheme self-90)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "modulo by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 228)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rmod__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-90)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __imod__-453
                       (procedure->py-function
                        (lambda (self-92 other-93)
                          (letrec* ()
                            (if (py-isinstance? self-92 &py-builtin-int)
                                (if (py-isinstance? other-93 &py-builtin-int)
                                    (if (py-test (py-ne other-93
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py% (py-int-to-scheme self-92)
                                              (py-int-to-scheme other-93)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "modulo by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 234)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__imod__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-92)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __eq__-455
                       (procedure->py-function
                        (lambda (self-94 other-95)
                          (letrec* ()
                            (if (py-isinstance? self-94 &py-builtin-int)
                                (if (py-isinstance? other-95 &py-builtin-int)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py== (py-int-to-scheme self-94)
                                            (py-int-to-scheme other-95))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 239)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__eq__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-94)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ne__-457
                       (procedure->py-function
                        (lambda (self-96 other-97)
                          (letrec* ()
                            (if (py-isinstance? self-96 &py-builtin-int)
                                (if (py-isinstance? other-97 &py-builtin-int)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py!= (py-int-to-scheme self-96)
                                            (py-int-to-scheme other-97))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 244)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ne__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-96)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ge__-459
                       (procedure->py-function
                        (lambda (self-98 other-99)
                          (letrec* ()
                            (if (py-isinstance? self-98 &py-builtin-int)
                                (if (py-isinstance? other-99 &py-builtin-int)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py>= (py-int-to-scheme self-98)
                                            (py-int-to-scheme other-99))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 249)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ge__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-98)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __gt__-461
                       (procedure->py-function
                        (lambda (self-100 other-101)
                          (letrec* ()
                            (if (py-isinstance? self-100 &py-builtin-int)
                                (if (py-isinstance? other-101 &py-builtin-int)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py> (py-int-to-scheme self-100)
                                           (py-int-to-scheme other-101))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 254)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__gt__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-100)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __le__-463
                       (procedure->py-function
                        (lambda (self-102 other-103)
                          (letrec* ()
                            (if (py-isinstance? self-102 &py-builtin-int)
                                (if (py-isinstance? other-103 &py-builtin-int)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py<= (py-int-to-scheme self-102)
                                            (py-int-to-scheme other-103))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 259)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__le__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-102)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __lt__-465
                       (procedure->py-function
                        (lambda (self-104 other-105)
                          (letrec* ()
                            (if (py-isinstance? self-104 &py-builtin-int)
                                (if (py-isinstance? other-105 &py-builtin-int)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py< (py-int-to-scheme self-104)
                                           (py-int-to-scheme other-105))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 264)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__lt__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-104)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other)))))
               (begin
                 (set! $%cls_2
                       (py-make-builtin-class
                        (&& "int")
                        (&& "__main__")
                        (list)
                        (& "__lt__")
                        __lt__-465
                        (& "__le__")
                        __le__-463
                        (& "__gt__")
                        __gt__-461
                        (& "__ge__")
                        __ge__-459
                        (& "__ne__")
                        __ne__-457
                        (& "__eq__")
                        __eq__-455
                        (& "__imod__")
                        __imod__-453
                        (& "__rmod__")
                        __rmod__-451
                        (& "__mod__")
                        __mod__-449
                        (& "__itruediv__")
                        __itruediv__-447
                        (& "__rtruediv__")
                        __rtruediv__-445
                        (& "__truediv__")
                        __truediv__-443
                        (& "__ifloordiv__")
                        __ifloordiv__-441
                        (& "__rfloordiv__")
                        __rfloordiv__-439
                        (& "__floordiv__")
                        __floordiv__-437
                        (& "__invert__")
                        __invert__-435
                        (& "__neg__")
                        __neg__-433
                        (& "__pos__")
                        __pos__-431
                        (& "__irshift__")
                        __irshift__-429
                        (& "__rrshift__")
                        __rrshift__-427
                        (& "__rshift__")
                        __rshift__-425
                        (& "__ilshift__")
                        __ilshift__-423
                        (& "__rlshift__")
                        __rlshift__-421
                        (& "__lshift__")
                        __lshift__-419
                        (& "__ixor__")
                        __ixor__-417
                        (& "__rxor__")
                        __rxor__-415
                        (& "__xor__")
                        __xor__-413
                        (& "__isub__")
                        __isub__-411
                        (& "__rsub__")
                        __rsub__-409
                        (& "__sub__")
                        __sub__-407
                        (& "__ipow__")
                        __ipow__-405
                        (& "__rpow__")
                        __rpow__-403
                        (& "__pow__")
                        __pow__-401
                        (& "__imul__")
                        __imul__-399
                        (& "__rmul__")
                        __rmul__-397
                        (& "__mul__")
                        __mul__-395
                        (& "__ior__")
                        __ior__-393
                        (& "__ror__")
                        __ror__-391
                        (& "__or__")
                        __or__-389
                        (& "__iand__")
                        __iand__-387
                        (& "__rand__")
                        __rand__-385
                        (& "__and__")
                        __and__-383
                        (& "__iadd__")
                        __iadd__-381
                        (& "__radd__")
                        __radd__-379
                        (& "__add__")
                        __add__-377
                        (& "__abs__")
                        __abs__-375
                        (& "__index__")
                        __index__-373
                        (& "__bool__")
                        __bool__-371
                        (& "__new__")
                        __new__-368))
                 $%cls_2))))
     (set! &py-builtin-bool
           (let (($%cls_3 py-absent))
             (letrec* ((__rxor__-926 #f)
                       (__xor__-924 #f)
                       (__ror__-922 #f)
                       (__or__-920 #f)
                       (__rand__-918 #f)
                       (__and__-916 #f)
                       (__repr__-914 #f)
                       (__new__-911 #f))
               (begin
                 (set! __new__-911
                       (procedure->py-function
                        (lambda (cls-106 val-107)
                          (letrec* ()
                            (if (py-test (py-is cls-106 &py-builtin-bool))
                                (if (py-test (py-is val-107 py-absent))
                                    py-False
                                    (py-truth val-107))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (&& "bool.__new__ expected a subtype of 'bool' as first argument"))))))
                        (make-signature
                         args:
                         (cls val)
                         defaults:
                         (vector py-absent))))
                 (set! __repr__-914
                       (procedure->py-function
                        (lambda (self-108)
                          (letrec* ()
                            (if (py-test (py-is self-108 py-True))
                                (&& "True")
                                (if (py-test (py-is self-108 py-False))
                                    (&& "False")
                                    (py-throw
                                     (py-call &py-builtin-TypeError
                                              (py-add (py-add (&& "descriptor '__repr__' requires a 'bool' object but received a '")
                                                              (py-getattribute
                                                               (py-obj-cls
                                                                self-108)
                                                               (& "__name__")))
                                                      (&& "'"))))))))
                        (make-signature args: (self))))
                 (set! __and__-916
                       (procedure->py-function
                        (lambda (self-109 other-110)
                          (letrec* ()
                            (if (py-test (py-is (py-obj-cls self-109)
                                                &py-builtin-bool))
                                (if (py-test (py-is (py-obj-cls other-110)
                                                    &py-builtin-bool))
                                    (if (py-test (py-is self-109 py-True))
                                        other-110
                                        py-False)
                                    (if (py-isinstance?
                                         other-110
                                         &py-builtin-int)
                                        (py-int-from-scheme
                                         (py& (py-int-to-scheme self-109)
                                              (py-int-to-scheme other-110)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 275))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__and__' requires a 'bool' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-109)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rand__-918
                       (procedure->py-function
                        (lambda (self-111 other-112)
                          (letrec* ()
                            (if (py-test (py-is (py-obj-cls self-111)
                                                &py-builtin-bool))
                                (if (py-test (py-is (py-obj-cls other-112)
                                                    &py-builtin-bool))
                                    (if (py-test (py-is self-111 py-True))
                                        other-112
                                        py-False)
                                    (if (py-isinstance?
                                         other-112
                                         &py-builtin-int)
                                        (py-int-from-scheme
                                         (py& (py-int-to-scheme other-112)
                                              (py-int-to-scheme self-111)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 281))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rand__' requires a 'bool' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-111)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __or__-920
                       (procedure->py-function
                        (lambda (self-113 other-114)
                          (letrec* ()
                            (if (py-test (py-is (py-obj-cls self-113)
                                                &py-builtin-bool))
                                (if (py-test (py-is (py-obj-cls other-114)
                                                    &py-builtin-bool))
                                    (if (py-test (py-is self-113 py-True))
                                        py-True
                                        other-114)
                                    (if (py-isinstance?
                                         other-114
                                         &py-builtin-int)
                                        (py-int-from-scheme
                                         (py+b (py-int-to-scheme self-113)
                                               (py-int-to-scheme other-114)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 287))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__or__' requires a 'bool' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-113)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ror__-922
                       (procedure->py-function
                        (lambda (self-115 other-116)
                          (letrec* ()
                            (if (py-test (py-is (py-obj-cls self-115)
                                                &py-builtin-bool))
                                (if (py-test (py-is (py-obj-cls other-116)
                                                    &py-builtin-bool))
                                    (if (py-test (py-is self-115 py-True))
                                        py-True
                                        other-116)
                                    (if (py-isinstance?
                                         other-116
                                         &py-builtin-int)
                                        (py-int-from-scheme
                                         (py+b (py-int-to-scheme other-116)
                                               (py-int-to-scheme self-115)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 293))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ror__' requires a 'bool' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-115)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __xor__-924
                       (procedure->py-function
                        (lambda (self-117 other-118)
                          (letrec* ()
                            (if (py-test (py-is (py-obj-cls self-117)
                                                &py-builtin-bool))
                                (if (py-test (py-is (py-obj-cls other-118)
                                                    &py-builtin-bool))
                                    (py-isnot self-117 other-118)
                                    (if (py-isinstance?
                                         other-118
                                         &py-builtin-int)
                                        (py-int-from-scheme
                                         (py^ (py-int-to-scheme self-117)
                                              (py-int-to-scheme other-118)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 299))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__xor__' requires a 'bool' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-117)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rxor__-926
                       (procedure->py-function
                        (lambda (self-119 other-120)
                          (letrec* ()
                            (if (py-test (py-is (py-obj-cls self-119)
                                                &py-builtin-bool))
                                (if (py-test (py-is (py-obj-cls other-120)
                                                    &py-builtin-bool))
                                    (py-isnot self-119 other-120)
                                    (if (py-isinstance?
                                         other-120
                                         &py-builtin-int)
                                        (py-int-from-scheme
                                         (py^ (py-int-to-scheme other-120)
                                              (py-int-to-scheme self-119)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 305))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rxor__' requires a 'bool' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-119)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other)))))
               (begin
                 (set! $%cls_3
                       (py-make-builtin-class
                        (&& "bool")
                        (&& "__main__")
                        (list &py-builtin-int)
                        (& "__rxor__")
                        __rxor__-926
                        (& "__xor__")
                        __xor__-924
                        (& "__ror__")
                        __ror__-922
                        (& "__or__")
                        __or__-920
                        (& "__rand__")
                        __rand__-918
                        (& "__and__")
                        __and__-916
                        (& "__repr__")
                        __repr__-914
                        (& "__new__")
                        __new__-911))
                 $%cls_3))))
     (let (($fun-obj
            (procedure->py-function
             procedure:&py-builtin-convert_to_float
             (make-signature args: (obj)))))
       (set! &py-builtin-convert_to_float $fun-obj)
       (set! init:&py-builtin-convert_to_float $fun-obj))
     (set! &py-builtin-float
           (let (($%cls_4 py-absent))
             (letrec* ((__lt__-1067 #f)
                       (__le__-1065 #f)
                       (__gt__-1063 #f)
                       (__ge__-1061 #f)
                       (__ne__-1059 #f)
                       (__eq__-1057 #f)
                       (__imod__-1055 #f)
                       (__rmod__-1053 #f)
                       (__mod__-1051 #f)
                       (__itruediv__-1049 #f)
                       (__rtruediv__-1047 #f)
                       (__truediv__-1045 #f)
                       (__ifloordiv__-1043 #f)
                       (__rfloordiv__-1041 #f)
                       (__floordiv__-1039 #f)
                       (__neg__-1037 #f)
                       (__pos__-1035 #f)
                       (__isub__-1033 #f)
                       (__rsub__-1031 #f)
                       (__sub__-1029 #f)
                       (__ipow__-1027 #f)
                       (__rpow__-1025 #f)
                       (__pow__-1023 #f)
                       (__imul__-1021 #f)
                       (__rmul__-1019 #f)
                       (__mul__-1017 #f)
                       (__iadd__-1015 #f)
                       (__radd__-1013 #f)
                       (__add__-1011 #f)
                       (__bool__-1009 #f)
                       (__float__-1007 #f)
                       (__new__-1004 #f))
               (begin
                 (set! __new__-1004
                       (procedure->py-function
                        (lambda (cls-122 val-123)
                          (letrec* ()
                            (if (py-test (py-is cls-122 &py-builtin-float))
                                (if (py-test (py-is val-123 py-absent))
                                    (py-float-from-scheme 0.)
                                    (py-throw
                                     (procedure:&py-builtin-convert_to_float
                                      val-123)))
                                (if (and (py-isinstance?
                                          cls-122
                                          (global-get
                                           %global
                                           (& "type")
                                           (vector-ref %caches 315)))
                                         (py-test (py-call (global-get
                                                            %global
                                                            (& "issubclass")
                                                            (vector-ref
                                                             %caches
                                                             316))
                                                           cls-122
                                                           &py-builtin-float)))
                                    (if (py-test (py-is val-123 py-absent))
                                        (make-PyObjectFloat
                                         py-float-hclass-of-instances
                                         '#()
                                         cls-122
                                         0.)
                                        (make-PyObjectFloat
                                         py-float-hclass-of-instances
                                         '#()
                                         cls-122
                                         (py-float-to-scheme
                                          (procedure:&py-builtin-convert_to_float
                                           val-123))))
                                    (py-throw
                                     (py-call &py-builtin-TypeError
                                              (&& "float.__new__ expected a subtype of 'float' as first argument")))))))
                        (make-signature
                         args:
                         (cls val)
                         defaults:
                         (vector py-absent))))
                 (set! __float__-1007
                       (procedure->py-function
                        (lambda (self-124)
                          (letrec* ()
                            (if (py-isinstance? self-124 &py-builtin-float)
                                (py-float-from-scheme
                                 (py-float-to-scheme self-124))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__float__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-124)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __bool__-1009
                       (procedure->py-function
                        (lambda (self-125)
                          (letrec* ()
                            (if (py-isinstance? self-125 &py-builtin-float)
                                (py-ne self-125 (py-float-from-scheme 0.))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__bool__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-125)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __add__-1011
                       (procedure->py-function
                        (lambda (self-126 other-127)
                          (letrec* ()
                            (if (py-isinstance? self-126 &py-builtin-float)
                                (if (py-isinstance?
                                     other-127
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py+ (py-float-to-scheme self-126)
                                          (py-float-to-scheme other-127)))
                                    (if (py-isinstance?
                                         other-127
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py+ (py-float-to-scheme self-126)
                                              (py-int-to-scheme other-127)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 329))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__add__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-126)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __radd__-1013
                       (procedure->py-function
                        (lambda (self-128 other-129)
                          (letrec* ()
                            (if (py-isinstance? self-128 &py-builtin-float)
                                (if (py-isinstance?
                                     other-129
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py+ (py-float-to-scheme other-129)
                                          (py-float-to-scheme self-128)))
                                    (if (py-isinstance?
                                         other-129
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py+ (py-int-to-scheme other-129)
                                              (py-float-to-scheme self-128)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 335))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__radd__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-128)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __iadd__-1015
                       (procedure->py-function
                        (lambda (self-130 other-131)
                          (letrec* ()
                            (if (py-isinstance? self-130 &py-builtin-float)
                                (if (py-isinstance?
                                     other-131
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py+ (py-float-to-scheme self-130)
                                          (py-float-to-scheme other-131)))
                                    (if (py-isinstance?
                                         self-130
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py+ (py-float-to-scheme self-130)
                                              (py-int-to-scheme other-131)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 341))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__iadd__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-130)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __mul__-1017
                       (procedure->py-function
                        (lambda (self-132 other-133)
                          (letrec* ()
                            (if (py-isinstance? self-132 &py-builtin-float)
                                (if (py-isinstance?
                                     other-133
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py* (py-float-to-scheme self-132)
                                          (py-float-to-scheme other-133)))
                                    (if (py-isinstance?
                                         other-133
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py* (py-float-to-scheme self-132)
                                              (py-int-to-scheme other-133)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 347))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__mul__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-132)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rmul__-1019
                       (procedure->py-function
                        (lambda (self-134 other-135)
                          (letrec* ()
                            (if (py-isinstance? self-134 &py-builtin-float)
                                (if (py-isinstance?
                                     other-135
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py* (py-float-to-scheme other-135)
                                          (py-float-to-scheme self-134)))
                                    (if (py-isinstance?
                                         other-135
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py* (py-int-to-scheme other-135)
                                              (py-float-to-scheme self-134)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 353))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rmul__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-134)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __imul__-1021
                       (procedure->py-function
                        (lambda (self-136 other-137)
                          (letrec* ()
                            (if (py-isinstance? self-136 &py-builtin-float)
                                (if (py-isinstance?
                                     other-137
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py* (py-float-to-scheme self-136)
                                          (py-float-to-scheme other-137)))
                                    (if (py-isinstance?
                                         self-136
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py* (py-float-to-scheme self-136)
                                              (py-int-to-scheme other-137)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 359))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__imul__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-136)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __pow__-1023
                       (procedure->py-function
                        (lambda (self-138 other-139)
                          (letrec* ()
                            (if (py-isinstance? self-138 &py-builtin-float)
                                (if (py-isinstance?
                                     other-139
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py** (py-float-to-scheme self-138)
                                           (py-float-to-scheme other-139)))
                                    (if (py-isinstance?
                                         other-139
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py** (py-float-to-scheme self-138)
                                               (py-int-to-scheme other-139)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 365))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__pow__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-138)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rpow__-1025
                       (procedure->py-function
                        (lambda (self-140 other-141)
                          (letrec* ()
                            (if (py-isinstance? self-140 &py-builtin-float)
                                (if (py-isinstance?
                                     other-141
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py** (py-float-to-scheme other-141)
                                           (py-float-to-scheme self-140)))
                                    (if (py-isinstance?
                                         other-141
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py** (py-int-to-scheme other-141)
                                               (py-float-to-scheme self-140)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 371))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rpow__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-140)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ipow__-1027
                       (procedure->py-function
                        (lambda (self-142 other-143)
                          (letrec* ()
                            (if (py-isinstance? self-142 &py-builtin-float)
                                (if (py-isinstance?
                                     other-143
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py** (py-float-to-scheme self-142)
                                           (py-float-to-scheme other-143)))
                                    (if (py-isinstance?
                                         self-142
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py** (py-float-to-scheme self-142)
                                               (py-int-to-scheme other-143)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 377))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ipow__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-142)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __sub__-1029
                       (procedure->py-function
                        (lambda (self-144 other-145)
                          (letrec* ()
                            (if (py-isinstance? self-144 &py-builtin-float)
                                (if (py-isinstance?
                                     other-145
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py- (py-float-to-scheme self-144)
                                          (py-float-to-scheme other-145)))
                                    (if (py-isinstance?
                                         other-145
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py- (py-float-to-scheme self-144)
                                              (py-int-to-scheme other-145)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 383))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__sub__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-144)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rsub__-1031
                       (procedure->py-function
                        (lambda (self-146 other-147)
                          (letrec* ()
                            (if (py-isinstance? self-146 &py-builtin-float)
                                (if (py-isinstance?
                                     other-147
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py- (py-float-to-scheme other-147)
                                          (py-float-to-scheme self-146)))
                                    (if (py-isinstance?
                                         other-147
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py- (py-int-to-scheme other-147)
                                              (py-float-to-scheme self-146)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 389))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rsub__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-146)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __isub__-1033
                       (procedure->py-function
                        (lambda (self-148 other-149)
                          (letrec* ()
                            (if (py-isinstance? self-148 &py-builtin-float)
                                (if (py-isinstance?
                                     other-149
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py- (py-float-to-scheme self-148)
                                          (py-float-to-scheme other-149)))
                                    (if (py-isinstance?
                                         self-148
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py- (py-float-to-scheme self-148)
                                              (py-int-to-scheme other-149)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 395))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__isub__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-148)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __pos__-1035
                       (procedure->py-function
                        (lambda (self-150)
                          (letrec* ()
                            (if (py-isinstance? self-150 &py-builtin-float)
                                self-150
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__pos__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-150)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __neg__-1037
                       (procedure->py-function
                        (lambda (self-151)
                          (letrec* ()
                            (if (py-isinstance? self-151 &py-builtin-float)
                                (py-float-from-scheme
                                 (pyneg (py-float-to-scheme self-151)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__neg__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-151)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __floordiv__-1039
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
                                         (py// (py-float-to-scheme self-152)
                                               (py-float-to-scheme other-153)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float division by zero"))))
                                    (if (py-isinstance?
                                         other-153
                                         &py-builtin-int)
                                        (if (py-test (py-ne other-153
                                                            (py-int-from-scheme
                                                             0)))
                                            (py-float-from-scheme
                                             (py// (py-float-to-scheme
                                                    self-152)
                                                   (py-int-to-scheme
                                                    other-153)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float division by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 410))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__floordiv__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-152)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rfloordiv__-1041
                       (procedure->py-function
                        (lambda (self-154 other-155)
                          (letrec* ()
                            (if (py-isinstance? self-154 &py-builtin-float)
                                (if (py-isinstance?
                                     other-155
                                     &py-builtin-float)
                                    (if (py-test (py-ne self-154
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py// (py-float-to-scheme other-155)
                                               (py-float-to-scheme self-154)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float division by zero"))))
                                    (if (py-isinstance?
                                         other-155
                                         &py-builtin-int)
                                        (if (py-test (py-ne self-154
                                                            (py-float-from-scheme
                                                             0.)))
                                            (py-float-from-scheme
                                             (py// (py-int-to-scheme other-155)
                                                   (py-float-to-scheme
                                                    self-154)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float division by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 418))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rfloordiv__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-154)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ifloordiv__-1043
                       (procedure->py-function
                        (lambda (self-156 other-157)
                          (letrec* ()
                            (if (py-isinstance? self-156 &py-builtin-float)
                                (if (py-isinstance?
                                     other-157
                                     &py-builtin-float)
                                    (if (py-test (py-ne other-157
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py// (py-float-to-scheme self-156)
                                               (py-float-to-scheme other-157)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float division by zero"))))
                                    (if (py-isinstance?
                                         other-157
                                         &py-builtin-int)
                                        (if (py-test (py-ne other-157
                                                            (py-int-from-scheme
                                                             0)))
                                            (py-float-from-scheme
                                             (py// (py-float-to-scheme
                                                    self-156)
                                                   (py-int-to-scheme
                                                    other-157)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float division by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 426))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ifloordiv__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-156)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __truediv__-1045
                       (procedure->py-function
                        (lambda (self-158 other-159)
                          (letrec* ()
                            (if (py-isinstance? self-158 &py-builtin-float)
                                (if (py-isinstance?
                                     other-159
                                     &py-builtin-float)
                                    (if (py-test (py-ne other-159
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py/ (py-float-to-scheme self-158)
                                              (py-float-to-scheme other-159)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float division by zero"))))
                                    (if (py-isinstance?
                                         other-159
                                         &py-builtin-int)
                                        (if (py-test (py-ne other-159
                                                            (py-int-from-scheme
                                                             0)))
                                            (py-float-from-scheme
                                             (py/ (py-float-to-scheme self-158)
                                                  (py-int-to-scheme
                                                   other-159)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float division by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 434))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__truediv__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-158)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rtruediv__-1047
                       (procedure->py-function
                        (lambda (self-160 other-161)
                          (letrec* ()
                            (if (py-isinstance? self-160 &py-builtin-float)
                                (if (py-isinstance?
                                     other-161
                                     &py-builtin-float)
                                    (if (py-test (py-ne self-160
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py/ (py-float-to-scheme other-161)
                                              (py-float-to-scheme self-160)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float division by zero"))))
                                    (if (py-isinstance?
                                         other-161
                                         &py-builtin-int)
                                        (if (py-test (py-ne self-160
                                                            (py-float-from-scheme
                                                             0.)))
                                            (py-float-from-scheme
                                             (py/ (py-int-to-scheme other-161)
                                                  (py-float-to-scheme
                                                   self-160)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float division by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 442))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rtruediv__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-160)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __itruediv__-1049
                       (procedure->py-function
                        (lambda (self-162 other-163)
                          (letrec* ()
                            (if (py-isinstance? self-162 &py-builtin-float)
                                (if (py-isinstance?
                                     other-163
                                     &py-builtin-float)
                                    (if (py-test (py-ne other-163
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py/ (py-float-to-scheme self-162)
                                              (py-float-to-scheme other-163)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float division by zero"))))
                                    (if (py-isinstance?
                                         other-163
                                         &py-builtin-int)
                                        (if (py-test (py-ne other-163
                                                            (py-int-from-scheme
                                                             0)))
                                            (py-float-from-scheme
                                             (py/ (py-float-to-scheme self-162)
                                                  (py-int-to-scheme
                                                   other-163)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float division by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 450))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__itruediv__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-162)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __mod__-1051
                       (procedure->py-function
                        (lambda (self-164 other-165)
                          (letrec* ()
                            (if (py-isinstance? self-164 &py-builtin-float)
                                (if (py-isinstance?
                                     other-165
                                     &py-builtin-float)
                                    (if (py-test (py-ne other-165
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py% (py-float-to-scheme self-164)
                                              (py-float-to-scheme other-165)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float modulo by zero"))))
                                    (if (py-isinstance?
                                         other-165
                                         &py-builtin-int)
                                        (if (py-test (py-ne other-165
                                                            (py-int-from-scheme
                                                             0)))
                                            (py-float-from-scheme
                                             (py% (py-float-to-scheme self-164)
                                                  (py-int-to-scheme
                                                   other-165)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float modulo by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 458))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__mod__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-164)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rmod__-1053
                       (procedure->py-function
                        (lambda (self-166 other-167)
                          (letrec* ()
                            (if (py-isinstance? self-166 &py-builtin-float)
                                (if (py-isinstance?
                                     other-167
                                     &py-builtin-float)
                                    (if (py-test (py-ne self-166
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py% (py-float-to-scheme other-167)
                                              (py-float-to-scheme self-166)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float modulo by zero"))))
                                    (if (py-isinstance?
                                         other-167
                                         &py-builtin-int)
                                        (if (py-test (py-ne self-166
                                                            (py-float-from-scheme
                                                             0.)))
                                            (py-float-from-scheme
                                             (py% (py-int-to-scheme other-167)
                                                  (py-float-to-scheme
                                                   self-166)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float modulo by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 466))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rmod__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-166)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __imod__-1055
                       (procedure->py-function
                        (lambda (self-168 other-169)
                          (letrec* ()
                            (if (py-isinstance? self-168 &py-builtin-float)
                                (if (py-isinstance?
                                     other-169
                                     &py-builtin-float)
                                    (if (py-test (py-ne other-169
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py% (py-float-to-scheme self-168)
                                              (py-float-to-scheme other-169)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float modulo by zero"))))
                                    (if (py-isinstance?
                                         other-169
                                         &py-builtin-int)
                                        (if (py-test (py-ne other-169
                                                            (py-int-from-scheme
                                                             0)))
                                            (py-float-from-scheme
                                             (py% (py-float-to-scheme self-168)
                                                  (py-int-to-scheme
                                                   other-169)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float modulo by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 474))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__imod__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-168)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __eq__-1057
                       (procedure->py-function
                        (lambda (self-170 other-171)
                          (letrec* ()
                            (if (py-isinstance? self-170 &py-builtin-float)
                                (if (py-isinstance?
                                     other-171
                                     &py-builtin-float)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py== (py-float-to-scheme self-170)
                                            (py-float-to-scheme other-171))))
                                    (if (py-isinstance?
                                         other-171
                                         &py-builtin-int)
                                        (py-bool-from-scheme-bool
                                         (py-test-from-scheme
                                          (py== (py-float-to-scheme self-170)
                                                (py-int-to-scheme other-171))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 480))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__eq__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-170)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ne__-1059
                       (procedure->py-function
                        (lambda (self-172 other-173)
                          (letrec* ()
                            (if (py-isinstance? self-172 &py-builtin-float)
                                (if (py-isinstance?
                                     other-173
                                     &py-builtin-float)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py!= (py-float-to-scheme self-172)
                                            (py-float-to-scheme other-173))))
                                    (if (py-isinstance?
                                         other-173
                                         &py-builtin-int)
                                        (py-bool-from-scheme-bool
                                         (py-test-from-scheme
                                          (py!= (py-float-to-scheme self-172)
                                                (py-int-to-scheme other-173))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 486))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ne__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-172)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ge__-1061
                       (procedure->py-function
                        (lambda (self-174 other-175)
                          (letrec* ()
                            (if (py-isinstance? self-174 &py-builtin-float)
                                (if (py-isinstance?
                                     other-175
                                     &py-builtin-float)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py>= (py-float-to-scheme self-174)
                                            (py-float-to-scheme other-175))))
                                    (if (py-isinstance?
                                         other-175
                                         &py-builtin-int)
                                        (py-bool-from-scheme-bool
                                         (py-test-from-scheme
                                          (py>= (py-float-to-scheme self-174)
                                                (py-int-to-scheme other-175))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 492))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ge__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-174)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __gt__-1063
                       (procedure->py-function
                        (lambda (self-176 other-177)
                          (letrec* ()
                            (if (py-isinstance? self-176 &py-builtin-float)
                                (if (py-isinstance?
                                     other-177
                                     &py-builtin-float)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py> (py-float-to-scheme self-176)
                                           (py-float-to-scheme other-177))))
                                    (if (py-isinstance?
                                         other-177
                                         &py-builtin-int)
                                        (py-bool-from-scheme-bool
                                         (py-test-from-scheme
                                          (py> (py-float-to-scheme self-176)
                                               (py-int-to-scheme other-177))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 498))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__gt__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-176)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __le__-1065
                       (procedure->py-function
                        (lambda (self-178 other-179)
                          (letrec* ()
                            (if (py-isinstance? self-178 &py-builtin-float)
                                (if (py-isinstance?
                                     other-179
                                     &py-builtin-float)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py<= (py-float-to-scheme self-178)
                                            (py-float-to-scheme other-179))))
                                    (if (py-isinstance?
                                         other-179
                                         &py-builtin-int)
                                        (py-bool-from-scheme-bool
                                         (py-test-from-scheme
                                          (py<= (py-float-to-scheme self-178)
                                                (py-int-to-scheme other-179))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 504))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__le__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-178)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __lt__-1067
                       (procedure->py-function
                        (lambda (self-180 other-181)
                          (letrec* ()
                            (if (py-isinstance? self-180 &py-builtin-float)
                                (if (py-isinstance?
                                     other-181
                                     &py-builtin-float)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py< (py-float-to-scheme self-180)
                                           (py-float-to-scheme other-181))))
                                    (if (py-isinstance?
                                         other-181
                                         &py-builtin-int)
                                        (py-bool-from-scheme-bool
                                         (py-test-from-scheme
                                          (py< (py-float-to-scheme self-180)
                                               (py-int-to-scheme other-181))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 510))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__lt__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-180)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other)))))
               (begin
                 (set! $%cls_4
                       (py-make-builtin-class
                        (&& "float")
                        (&& "__main__")
                        (list)
                        (& "__lt__")
                        __lt__-1067
                        (& "__le__")
                        __le__-1065
                        (& "__gt__")
                        __gt__-1063
                        (& "__ge__")
                        __ge__-1061
                        (& "__ne__")
                        __ne__-1059
                        (& "__eq__")
                        __eq__-1057
                        (& "__imod__")
                        __imod__-1055
                        (& "__rmod__")
                        __rmod__-1053
                        (& "__mod__")
                        __mod__-1051
                        (& "__itruediv__")
                        __itruediv__-1049
                        (& "__rtruediv__")
                        __rtruediv__-1047
                        (& "__truediv__")
                        __truediv__-1045
                        (& "__ifloordiv__")
                        __ifloordiv__-1043
                        (& "__rfloordiv__")
                        __rfloordiv__-1041
                        (& "__floordiv__")
                        __floordiv__-1039
                        (& "__neg__")
                        __neg__-1037
                        (& "__pos__")
                        __pos__-1035
                        (& "__isub__")
                        __isub__-1033
                        (& "__rsub__")
                        __rsub__-1031
                        (& "__sub__")
                        __sub__-1029
                        (& "__ipow__")
                        __ipow__-1027
                        (& "__rpow__")
                        __rpow__-1025
                        (& "__pow__")
                        __pow__-1023
                        (& "__imul__")
                        __imul__-1021
                        (& "__rmul__")
                        __rmul__-1019
                        (& "__mul__")
                        __mul__-1017
                        (& "__iadd__")
                        __iadd__-1015
                        (& "__radd__")
                        __radd__-1013
                        (& "__add__")
                        __add__-1011
                        (& "__bool__")
                        __bool__-1009
                        (& "__float__")
                        __float__-1007
                        (& "__new__")
                        __new__-1004))
                 $%cls_4))))
     (set! &py-builtin-str
           (let (($%cls_5 py-absent))
             (letrec* ((__lt__-1428 #f)
                       (__le__-1426 #f)
                       (__gt__-1424 #f)
                       (__ge__-1422 #f)
                       (__ne__-1420 #f)
                       (__eq__-1418 #f)
                       (__rmul__-1416 #f)
                       (__mul__-1414 #f)
                       (__add__-1412 #f)
                       (__len__-1410 #f))
               (begin
                 (set! __len__-1410
                       (procedure->py-function
                        (lambda (self-182)
                          (letrec* ()
                            (if (py-isinstance? self-182 &py-builtin-str)
                                (py-int-from-scheme
                                 (py-str-len-to-scheme self-182))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__len__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-182)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __add__-1412
                       (procedure->py-function
                        (lambda (self-183 other-184)
                          (letrec* ()
                            (if (py-isinstance? self-183 &py-builtin-str)
                                (if (py-isinstance? other-184 &py-builtin-str)
                                    (py-str-from-scheme
                                     (py+ (py-str-to-scheme self-183)
                                          (py-str-to-scheme other-184)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 519)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__add__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-183)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __mul__-1414
                       (procedure->py-function
                        (lambda (self-185 other-186)
                          (letrec* ()
                            (if (py-isinstance? self-185 &py-builtin-str)
                                (if (py-isinstance? other-186 &py-builtin-int)
                                    (py-str-from-scheme
                                     (py* (py-str-to-scheme self-185)
                                          (py-int-to-scheme other-186)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 524)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__mul__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-185)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rmul__-1416
                       (procedure->py-function
                        (lambda (self-187 other-188)
                          (letrec* ()
                            (if (py-isinstance? self-187 &py-builtin-str)
                                (if (py-isinstance? other-188 &py-builtin-int)
                                    (py-str-from-scheme
                                     (py* (py-str-to-scheme self-187)
                                          (py-int-to-scheme other-188)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 529)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rmul__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-187)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __eq__-1418
                       (procedure->py-function
                        (lambda (self-189 other-190)
                          (letrec* ()
                            (if (py-isinstance? self-189 &py-builtin-str)
                                (if (py-isinstance? other-190 &py-builtin-str)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py== (py-str-to-scheme self-189)
                                            (py-str-to-scheme other-190))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 534)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__eq__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-189)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ne__-1420
                       (procedure->py-function
                        (lambda (self-191 other-192)
                          (letrec* ()
                            (if (py-isinstance? self-191 &py-builtin-str)
                                (if (py-isinstance? other-192 &py-builtin-str)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py!= (py-str-to-scheme self-191)
                                            (py-str-to-scheme other-192))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 539)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ne__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-191)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ge__-1422
                       (procedure->py-function
                        (lambda (self-193 other-194)
                          (letrec* ()
                            (if (py-isinstance? self-193 &py-builtin-str)
                                (if (py-isinstance? other-194 &py-builtin-str)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py>= (py-str-to-scheme self-193)
                                            (py-str-to-scheme other-194))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 544)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ge__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-193)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __gt__-1424
                       (procedure->py-function
                        (lambda (self-195 other-196)
                          (letrec* ()
                            (if (py-isinstance? self-195 &py-builtin-str)
                                (if (py-isinstance? other-196 &py-builtin-str)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py> (py-str-to-scheme self-195)
                                           (py-str-to-scheme other-196))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 549)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__gt__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-195)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __le__-1426
                       (procedure->py-function
                        (lambda (self-197 other-198)
                          (letrec* ()
                            (if (py-isinstance? self-197 &py-builtin-str)
                                (if (py-isinstance? other-198 &py-builtin-str)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py<= (py-str-to-scheme self-197)
                                            (py-str-to-scheme other-198))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 554)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__le__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-197)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __lt__-1428
                       (procedure->py-function
                        (lambda (self-199 other-200)
                          (letrec* ()
                            (if (py-isinstance? self-199 &py-builtin-str)
                                (if (py-isinstance? other-200 &py-builtin-str)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py< (py-str-to-scheme self-199)
                                           (py-str-to-scheme other-200))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 559)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__lt__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-199)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other)))))
               (begin
                 (set! $%cls_5
                       (py-make-builtin-class
                        (&& "str")
                        (&& "__main__")
                        (list)
                        (& "__lt__")
                        __lt__-1428
                        (& "__le__")
                        __le__-1426
                        (& "__gt__")
                        __gt__-1424
                        (& "__ge__")
                        __ge__-1422
                        (& "__ne__")
                        __ne__-1420
                        (& "__eq__")
                        __eq__-1418
                        (& "__rmul__")
                        __rmul__-1416
                        (& "__mul__")
                        __mul__-1414
                        (& "__add__")
                        __add__-1412
                        (& "__len__")
                        __len__-1410))
                 $%cls_5))))
     (set! &py-builtin-range_iterator
           (let (($%cls_6 py-absent))
             (letrec* ((__next__-1526 #f) (__iter__-1524 #f) (__new__-1522 #f))
               (begin
                 (set! __new__-1522
                       (procedure->py-function
                        (lambda (args-201)
                          (letrec* ()
                            (py-throw
                             (py-call &py-builtin-ValueError
                                      (&& "cannot create 'range_iterator' instances")))))
                        (make-signature vararg: args)))
                 (set! __iter__-1524
                       (procedure->py-function
                        (lambda (self-202) (letrec* () self-202))
                        (make-signature posonlyargs: (self))))
                 (set! __next__-1526
                       (procedure->py-function
                        (lambda (self-203)
                          (bind-exit
                           ($%return_75)
                           (letrec* ((step-1533 #f)
                                     (stop-1531 #f)
                                     (start-1528 #f))
                             (begin
                               (set! start-1528
                                     (PyObjectRangeIterator-start self-203))
                               (set! stop-1531
                                     (PyObjectRangeIterator-stop self-203))
                               (set! step-1533
                                     (PyObjectRangeIterator-step self-203))
                               (if (py-test (py-lt step-1533
                                                   (py-int-from-scheme 0)))
                                   (if (py-test (py-gt start-1528 stop-1531))
                                       (begin
                                         (PyObjectRangeIterator-start-set!
                                          self-203
                                          (py-add start-1528 step-1533))
                                         ($%return_75 start-1528))
                                       #f)
                                   (if (py-test (py-lt start-1528 stop-1531))
                                       (begin
                                         (PyObjectRangeIterator-start-set!
                                          self-203
                                          (py-add start-1528 step-1533))
                                         ($%return_75 start-1528))
                                       #f))
                               (py-throw &py-builtin-StopIteration)))))
                        (make-signature posonlyargs: (self)))))
               (begin
                 (set! $%cls_6
                       (py-make-builtin-class
                        (&& "range_iterator")
                        (&& "__main__")
                        (list)
                        (& "__next__")
                        __next__-1526
                        (& "__iter__")
                        __iter__-1524
                        (& "__new__")
                        __new__-1522))
                 $%cls_6))))
     (set! &py-builtin-range
           (let (($%cls_7 py-absent))
             (letrec* ((__repr__-1547 #f)
                       (__iter__-1545 #f)
                       (__contains__-1543 #f)
                       (__len__-1541 #f)
                       (__new__-1538 #f))
               (begin
                 (set! __new__-1538
                       (procedure->py-function
                        (lambda (cls-204 arg1-205 arg2-206 arg3-207)
                          (letrec* ()
                            (if (py-test (py-is cls-204 &py-builtin-range))
                                (if (py-test (py-isnot arg3-207 py-absent))
                                    (make-PyObjectRange
                                     py-range-hclass-of-instances
                                     '#()
                                     py-builtin-range
                                     (py-big-index arg1-205)
                                     (py-big-index arg2-206)
                                     (py-big-index arg3-207))
                                    (if (py-test (py-isnot arg2-206 py-absent))
                                        (make-PyObjectRange
                                         py-range-hclass-of-instances
                                         '#()
                                         py-builtin-range
                                         (py-big-index arg1-205)
                                         (py-big-index arg2-206)
                                         (py-int-from-scheme 1))
                                        (make-PyObjectRange
                                         py-range-hclass-of-instances
                                         '#()
                                         py-builtin-range
                                         (py-int-from-scheme 0)
                                         (py-big-index arg1-205)
                                         (py-int-from-scheme 1))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (&& "range.__new__ expected a subtype of 'range' as first argument"))))))
                        (make-signature
                         posonlyargs:
                         (cls arg1 arg2 arg3)
                         defaults:
                         (vector py-absent py-absent))))
                 (set! __len__-1541
                       (procedure->py-function
                        (lambda (self-208)
                          (letrec* ()
                            (py-floordiv
                             (py-sub (PyObjectRange-stop self-208)
                                     (PyObjectRange-start self-208))
                             (PyObjectRange-step self-208))))
                        (make-signature posonlyargs: (self))))
                 (set! __contains__-1543
                       (procedure->py-function
                        (lambda (self-209 item-210)
                          (bind-exit
                           ($%return_76)
                           (letrec* ((step-1565 #f)
                                     (stop-1563 #f)
                                     (start-1560 #f))
                             (begin
                               (set! start-1560 (PyObjectRange-start self-209))
                               (set! stop-1563 (PyObjectRange-stop self-209))
                               (set! step-1565 (PyObjectRange-step self-209))
                               (if (py-test (py-lt step-1565
                                                   (py-int-from-scheme 0)))
                                   (if (or (py-test (py-ge stop-1563 item-210))
                                           (py-test (py-gt item-210
                                                           start-1560)))
                                       ($%return_76 py-False)
                                       #f)
                                   (if (or (py-test (py-gt start-1560
                                                           item-210))
                                           (py-test (py-ge item-210
                                                           stop-1563)))
                                       ($%return_76 py-False)
                                       #f))
                               (py-eq (py-mod (py-sub item-210 start-1560)
                                              step-1565)
                                      (py-int-from-scheme 0))))))
                        (make-signature posonlyargs: (self item))))
                 (set! __iter__-1545
                       (procedure->py-function
                        (lambda (self-211)
                          (letrec* ()
                            (make-PyObjectRangeIterator
                             py-range_iterator-hclass-of-instances
                             '#()
                             py-builtin-range_iterator
                             (PyObjectRange-start self-211)
                             (PyObjectRange-stop self-211)
                             (PyObjectRange-step self-211))))
                        (make-signature posonlyargs: (self))))
                 (set! __repr__-1547
                       (procedure->py-function
                        (lambda (self-212)
                          (letrec* ((step-1554 #f)
                                    (stop-1552 #f)
                                    (start-1549 #f))
                            (begin
                              (set! start-1549 (PyObjectRange-start self-212))
                              (set! stop-1552 (PyObjectRange-stop self-212))
                              (set! step-1554 (PyObjectRange-step self-212))
                              (if (py-test (py-eq step-1554
                                                  (py-int-from-scheme 1)))
                                  (py-add (py-add (py-add (py-add (&& "range(")
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                          (py-call &py-builtin-str start-1549))
                  (&& ", "))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                  (py-call &py-builtin-str
                                                           stop-1552))
                                          (&& ")"))
                                  (py-add (py-add (py-add (py-add (py-add (py-add (&& "range(")
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                                          (py-call &py-builtin-str start-1549))
                                  (&& ", "))
                          (py-call &py-builtin-str stop-1552))
                  (&& ", "))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                  (py-call &py-builtin-str
                                                           step-1554))
                                          (&& ")"))))))
                        (make-signature args: (self)))))
               (begin
                 (set! $%cls_7
                       (py-make-builtin-class
                        (&& "range")
                        (&& "__main__")
                        (list)
                        (& "__repr__")
                        __repr__-1547
                        (& "__iter__")
                        __iter__-1545
                        (& "__contains__")
                        __contains__-1543
                        (& "__len__")
                        __len__-1541
                        (& "__new__")
                        __new__-1538))
                 $%cls_7))))
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
           (let (($%cls_8 py-absent))
             (letrec* ((__str__-1604 #f) (__init__-1602 #f))
               (begin
                 (set! __init__-1602
                       (procedure->py-function
                        (lambda (self-220 args-221)
                          (letrec* ()
                            (begin
                              (py-setattribute
                               (or self-220
                                   (py-throw-exception-with-message
                                    py-builtin-UnboundLocalError
                                    "local variable 'self' referenced before assignment"))
                               (& "args")
                               (or args-221
                                   (py-throw-exception-with-message
                                    py-builtin-UnboundLocalError
                                    "local variable 'args' referenced before assignment")))
                              py-None)))
                        (make-signature args: (self) vararg: args)))
                 (set! __str__-1604
                       (procedure->py-function
                        (lambda (self-222)
                          (letrec* ((args_len-1609 #f) (args-1606 #f))
                            (begin
                              (set! args-1606
                                    (py-getattribute self-222 (& "args")))
                              (set! args_len-1609
                                    (py-call (global-get
                                              %global
                                              (& "len")
                                              (vector-ref %caches 612))
                                             (py-getattribute
                                              self-222
                                              (& "args"))))
                              (if (py-test (py-eq args_len-1609
                                                  (py-int-from-scheme 0)))
                                  (&& "")
                                  (if (py-test (py-eq args_len-1609
                                                      (py-int-from-scheme 1)))
                                      (py-call &py-builtin-str
                                               (py-getitem
                                                args-1606
                                                (py-int-from-scheme 0)))
                                      (py-call &py-builtin-str args-1606))))))
                        (make-signature args: (self)))))
               (begin
                 (set! $%cls_8
                       (py-make-builtin-class
                        (&& "BaseException")
                        (&& "__main__")
                        (list)
                        (& "__str__")
                        __str__-1604
                        (& "__init__")
                        __init__-1602))
                 $%cls_8))))
     (set! &py-builtin-Exception
           (let (($%cls_9 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_9
                       (py-make-builtin-class
                        (&& "Exception")
                        (&& "__main__")
                        (list &py-builtin-BaseException)))
                 $%cls_9))))
     (set! &py-builtin-GeneratorExit
           (let (($%cls_10 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_10
                       (py-make-builtin-class
                        (&& "GeneratorExit")
                        (&& "__main__")
                        (list &py-builtin-BaseException)))
                 $%cls_10))))
     (set! &py-builtin-KeyboardInterrupt
           (let (($%cls_11 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_11
                       (py-make-builtin-class
                        (&& "KeyboardInterrupt")
                        (&& "__main__")
                        (list &py-builtin-BaseException)))
                 $%cls_11))))
     (set! &py-builtin-SystemExit
           (let (($%cls_12 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_12
                       (py-make-builtin-class
                        (&& "SystemExit")
                        (&& "__main__")
                        (list &py-builtin-BaseException)))
                 $%cls_12))))
     (set! &py-builtin-ArithmeticError
           (let (($%cls_13 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_13
                       (py-make-builtin-class
                        (&& "ArithmeticError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_13))))
     (set! &py-builtin-AssertionError
           (let (($%cls_14 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_14
                       (py-make-builtin-class
                        (&& "AssertionError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_14))))
     (set! &py-builtin-AttributeError
           (let (($%cls_15 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_15
                       (py-make-builtin-class
                        (&& "AttributeError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_15))))
     (set! &py-builtin-BufferError
           (let (($%cls_16 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_16
                       (py-make-builtin-class
                        (&& "BufferError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_16))))
     (set! &py-builtin-EOFError
           (let (($%cls_17 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_17
                       (py-make-builtin-class
                        (&& "EOFError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_17))))
     (set! &py-builtin-ImportError
           (let (($%cls_18 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_18
                       (py-make-builtin-class
                        (&& "ImportError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_18))))
     (set! &py-builtin-LookupError
           (let (($%cls_19 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_19
                       (py-make-builtin-class
                        (&& "LookupError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_19))))
     (set! &py-builtin-MemoryError
           (let (($%cls_20 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_20
                       (py-make-builtin-class
                        (&& "MemoryError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_20))))
     (set! &py-builtin-NameError
           (let (($%cls_21 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_21
                       (py-make-builtin-class
                        (&& "NameError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_21))))
     (set! &py-builtin-EnvironmentError
           (let (($%cls_22 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_22
                       (py-make-builtin-class
                        (&& "EnvironmentError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_22))))
     (set! &py-builtin-IOError
           (let (($%cls_23 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_23
                       (py-make-builtin-class
                        (&& "IOError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_23))))
     (set! &py-builtin-OSError
           (let (($%cls_24 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_24
                       (py-make-builtin-class
                        (&& "OSError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_24))))
     (set! &py-builtin-WindowsError
           (let (($%cls_25 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_25
                       (py-make-builtin-class
                        (&& "WindowsError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_25))))
     (set! &py-builtin-ReferenceError
           (let (($%cls_26 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_26
                       (py-make-builtin-class
                        (&& "ReferenceError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_26))))
     (set! &py-builtin-RuntimeError
           (let (($%cls_27 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_27
                       (py-make-builtin-class
                        (&& "RuntimeError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_27))))
     (set! &py-builtin-StopAsyncIteration
           (let (($%cls_28 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_28
                       (py-make-builtin-class
                        (&& "StopAsyncIteration")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_28))))
     (set! &py-builtin-StopIteration
           (let (($%cls_29 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_29
                       (py-make-builtin-class
                        (&& "StopIteration")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_29))))
     (set! &py-builtin-SyntaxError
           (let (($%cls_30 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_30
                       (py-make-builtin-class
                        (&& "SyntaxError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_30))))
     (set! &py-builtin-SystemError
           (let (($%cls_31 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_31
                       (py-make-builtin-class
                        (&& "SystemError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_31))))
     (set! &py-builtin-TypeError
           (let (($%cls_32 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_32
                       (py-make-builtin-class
                        (&& "TypeError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_32))))
     (set! &py-builtin-ValueError
           (let (($%cls_33 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_33
                       (py-make-builtin-class
                        (&& "ValueError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_33))))
     (set! &py-builtin-Warning
           (let (($%cls_34 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_34
                       (py-make-builtin-class
                        (&& "Warning")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_34))))
     (set! &py-builtin-FloatingPointError
           (let (($%cls_35 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_35
                       (py-make-builtin-class
                        (&& "FloatingPointError")
                        (&& "__main__")
                        (list &py-builtin-ArithmeticError)))
                 $%cls_35))))
     (set! &py-builtin-OverflowError
           (let (($%cls_36 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_36
                       (py-make-builtin-class
                        (&& "OverflowError")
                        (&& "__main__")
                        (list &py-builtin-ArithmeticError)))
                 $%cls_36))))
     (set! &py-builtin-ZeroDivisionError
           (let (($%cls_37 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_37
                       (py-make-builtin-class
                        (&& "ZeroDivisionError")
                        (&& "__main__")
                        (list &py-builtin-ArithmeticError)))
                 $%cls_37))))
     (set! &py-builtin-ModuleNotFoundError
           (let (($%cls_38 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_38
                       (py-make-builtin-class
                        (&& "ModuleNotFoundError")
                        (&& "__main__")
                        (list &py-builtin-ImportError)))
                 $%cls_38))))
     (set! &py-builtin-IndexError
           (let (($%cls_39 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_39
                       (py-make-builtin-class
                        (&& "IndexError")
                        (&& "__main__")
                        (list &py-builtin-LookupError)))
                 $%cls_39))))
     (set! &py-builtin-KeyError
           (let (($%cls_40 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_40
                       (py-make-builtin-class
                        (&& "KeyError")
                        (&& "__main__")
                        (list &py-builtin-LookupError)))
                 $%cls_40))))
     (set! &py-builtin-UnboundLocalError
           (let (($%cls_41 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_41
                       (py-make-builtin-class
                        (&& "UnboundLocalError")
                        (&& "__main__")
                        (list &py-builtin-NameError)))
                 $%cls_41))))
     (set! &py-builtin-BlockingIOError
           (let (($%cls_42 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_42
                       (py-make-builtin-class
                        (&& "BlockingIOError")
                        (&& "__main__")
                        (list &py-builtin-OSError)))
                 $%cls_42))))
     (set! &py-builtin-ChildProcessError
           (let (($%cls_43 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_43
                       (py-make-builtin-class
                        (&& "ChildProcessError")
                        (&& "__main__")
                        (list &py-builtin-OSError)))
                 $%cls_43))))
     (set! &py-builtin-ConnectionError
           (let (($%cls_44 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_44
                       (py-make-builtin-class
                        (&& "ConnectionError")
                        (&& "__main__")
                        (list &py-builtin-OSError)))
                 $%cls_44))))
     (set! &py-builtin-FileExistsError
           (let (($%cls_45 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_45
                       (py-make-builtin-class
                        (&& "FileExistsError")
                        (&& "__main__")
                        (list &py-builtin-OSError)))
                 $%cls_45))))
     (set! &py-builtin-FileNotFoundError
           (let (($%cls_46 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_46
                       (py-make-builtin-class
                        (&& "FileNotFoundError")
                        (&& "__main__")
                        (list &py-builtin-OSError)))
                 $%cls_46))))
     (set! &py-builtin-InterruptedError
           (let (($%cls_47 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_47
                       (py-make-builtin-class
                        (&& "InterruptedError")
                        (&& "__main__")
                        (list &py-builtin-OSError)))
                 $%cls_47))))
     (set! &py-builtin-IsADirectoryError
           (let (($%cls_48 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_48
                       (py-make-builtin-class
                        (&& "IsADirectoryError")
                        (&& "__main__")
                        (list &py-builtin-OSError)))
                 $%cls_48))))
     (set! &py-builtin-NotADirectoryError
           (let (($%cls_49 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_49
                       (py-make-builtin-class
                        (&& "NotADirectoryError")
                        (&& "__main__")
                        (list &py-builtin-OSError)))
                 $%cls_49))))
     (set! &py-builtin-PermissionError
           (let (($%cls_50 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_50
                       (py-make-builtin-class
                        (&& "PermissionError")
                        (&& "__main__")
                        (list &py-builtin-OSError)))
                 $%cls_50))))
     (set! &py-builtin-ProcessLookupError
           (let (($%cls_51 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_51
                       (py-make-builtin-class
                        (&& "ProcessLookupError")
                        (&& "__main__")
                        (list &py-builtin-OSError)))
                 $%cls_51))))
     (set! &py-builtin-TimeoutError
           (let (($%cls_52 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_52
                       (py-make-builtin-class
                        (&& "TimeoutError")
                        (&& "__main__")
                        (list &py-builtin-OSError)))
                 $%cls_52))))
     (set! &py-builtin-NotImplementedError
           (let (($%cls_53 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_53
                       (py-make-builtin-class
                        (&& "NotImplementedError")
                        (&& "__main__")
                        (list &py-builtin-RuntimeError)))
                 $%cls_53))))
     (set! &py-builtin-RecursionError
           (let (($%cls_54 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_54
                       (py-make-builtin-class
                        (&& "RecursionError")
                        (&& "__main__")
                        (list &py-builtin-RuntimeError)))
                 $%cls_54))))
     (set! &py-builtin-IndentationError
           (let (($%cls_55 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_55
                       (py-make-builtin-class
                        (&& "IndentationError")
                        (&& "__main__")
                        (list &py-builtin-SyntaxError)))
                 $%cls_55))))
     (set! &py-builtin-UnicodeError
           (let (($%cls_56 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_56
                       (py-make-builtin-class
                        (&& "UnicodeError")
                        (&& "__main__")
                        (list &py-builtin-ValueError)))
                 $%cls_56))))
     (set! &py-builtin-BytesWarning
           (let (($%cls_57 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_57
                       (py-make-builtin-class
                        (&& "BytesWarning")
                        (&& "__main__")
                        (list &py-builtin-Warning)))
                 $%cls_57))))
     (set! &py-builtin-DeprecationWarning
           (let (($%cls_58 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_58
                       (py-make-builtin-class
                        (&& "DeprecationWarning")
                        (&& "__main__")
                        (list &py-builtin-Warning)))
                 $%cls_58))))
     (set! &py-builtin-FutureWarning
           (let (($%cls_59 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_59
                       (py-make-builtin-class
                        (&& "FutureWarning")
                        (&& "__main__")
                        (list &py-builtin-Warning)))
                 $%cls_59))))
     (set! &py-builtin-ImportWarning
           (let (($%cls_60 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_60
                       (py-make-builtin-class
                        (&& "ImportWarning")
                        (&& "__main__")
                        (list &py-builtin-Warning)))
                 $%cls_60))))
     (set! &py-builtin-PendingDeprecationWarning
           (let (($%cls_61 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_61
                       (py-make-builtin-class
                        (&& "PendingDeprecationWarning")
                        (&& "__main__")
                        (list &py-builtin-Warning)))
                 $%cls_61))))
     (set! &py-builtin-ResourceWarning
           (let (($%cls_62 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_62
                       (py-make-builtin-class
                        (&& "ResourceWarning")
                        (&& "__main__")
                        (list &py-builtin-Warning)))
                 $%cls_62))))
     (set! &py-builtin-RuntimeWarning
           (let (($%cls_63 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_63
                       (py-make-builtin-class
                        (&& "RuntimeWarning")
                        (&& "__main__")
                        (list &py-builtin-Warning)))
                 $%cls_63))))
     (set! &py-builtin-SyntaxWarning
           (let (($%cls_64 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_64
                       (py-make-builtin-class
                        (&& "SyntaxWarning")
                        (&& "__main__")
                        (list &py-builtin-Warning)))
                 $%cls_64))))
     (set! &py-builtin-UnicodeWarning
           (let (($%cls_65 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_65
                       (py-make-builtin-class
                        (&& "UnicodeWarning")
                        (&& "__main__")
                        (list &py-builtin-Warning)))
                 $%cls_65))))
     (set! &py-builtin-UserWarning
           (let (($%cls_66 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_66
                       (py-make-builtin-class
                        (&& "UserWarning")
                        (&& "__main__")
                        (list &py-builtin-Warning)))
                 $%cls_66))))
     (set! &py-builtin-BrokenPipeError
           (let (($%cls_67 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_67
                       (py-make-builtin-class
                        (&& "BrokenPipeError")
                        (&& "__main__")
                        (list &py-builtin-ConnectionError)))
                 $%cls_67))))
     (set! &py-builtin-ConnectionAbortedError
           (let (($%cls_68 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_68
                       (py-make-builtin-class
                        (&& "ConnectionAbortedError")
                        (&& "__main__")
                        (list &py-builtin-ConnectionError)))
                 $%cls_68))))
     (set! &py-builtin-ConnectionRefusedError
           (let (($%cls_69 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_69
                       (py-make-builtin-class
                        (&& "ConnectionRefusedError")
                        (&& "__main__")
                        (list &py-builtin-ConnectionError)))
                 $%cls_69))))
     (set! &py-builtin-ConnectionResetError
           (let (($%cls_70 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_70
                       (py-make-builtin-class
                        (&& "ConnectionResetError")
                        (&& "__main__")
                        (list &py-builtin-ConnectionError)))
                 $%cls_70))))
     (set! &py-builtin-TabError
           (let (($%cls_71 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_71
                       (py-make-builtin-class
                        (&& "TabError")
                        (&& "__main__")
                        (list &py-builtin-IndentationError)))
                 $%cls_71))))
     (set! &py-builtin-UnicodeDecodeError
           (let (($%cls_72 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_72
                       (py-make-builtin-class
                        (&& "UnicodeDecodeError")
                        (&& "__main__")
                        (list &py-builtin-UnicodeError)))
                 $%cls_72))))
     (set! &py-builtin-UnicodeEncodeError
           (let (($%cls_73 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_73
                       (py-make-builtin-class
                        (&& "UnicodeEncodeError")
                        (&& "__main__")
                        (list &py-builtin-UnicodeError)))
                 $%cls_73))))
     (set! &py-builtin-UnicodeTranslateError
           (let (($%cls_74 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_74
                       (py-make-builtin-class
                        (&& "UnicodeTranslateError")
                        (&& "__main__")
                        (list &py-builtin-UnicodeError)))
                 $%cls_74)))))
   (define (init name package __path__) builtins-mod)
   (define (init-builtin-module name package __path__)
     (py-init-module)
     (let ((caches (py-make-caches 748))
           (module (py-make-module name package __path__)))
       (begin)
       (py-module module caches)
       module))
   (py-end-module)))

