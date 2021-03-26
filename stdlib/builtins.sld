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
         &py-builtin-method
         &py-builtin-TypeError
         &py-builtin-staticmethod)
 (import (gambit) (zipi rts))
 (begin
   (py-begin-module)
   (define procedure:&py-builtin-convert_to_int
     (lambda (obj-18)
       (letrec* ((trunc_conversion-384 #f)
                 (index_conversion-381 #f)
                 (int_conversion-376 #f))
         (begin
           (set! int_conversion-376 (py-maybe-to-int obj-18))
           (if (py-test (py-is int_conversion-376 py-absent))
               (begin
                 (set! index_conversion-381 (py-maybe-index obj-18))
                 (if (py-test (py-is index_conversion-381 py-absent))
                     (begin
                       (set! trunc_conversion-384 (py-maybe-trunc obj-18))
                       (if (py-test (py-is trunc_conversion-384 py-absent))
                           (py-throw
                            (py-call &py-builtin-TypeError
                                     (py-add (py-add (&& "int() argument must be a string, a bytes-like object or a number, not '")
                                                     (py-getattribute
                                                      (py-obj-cls obj-18)
                                                      (& "__name__")))
                                             (&& "'"))))
                           trunc_conversion-384))
                     index_conversion-381))
               int_conversion-376)))))
   (define procedure:&py-builtin-convert_to_float
     (lambda (obj-126)
       (letrec* ((float_conversion-1018 #f))
         (begin
           (set! float_conversion-1018 (py-maybe-to-float obj-126))
           (if (py-test (py-is float_conversion-1018 py-absent))
               (py-throw
                (py-call &py-builtin-TypeError
                         (py-add (py-add (&& "float() argument must be a string or a number, not '")
                                         (py-getattribute
                                          (py-obj-cls obj-126)
                                          (& "__name__")))
                                 (&& "'"))))
               float_conversion-1018)))))
   (define procedure:&py-builtin-__merge
     (lambda (l1-218 l2-219)
       (letrec* ((output-1603 #f) (i-1601 #f) (j-1599 #f))
         (begin
           (&& "\n    Merge all items from two sorted list into one sorted list.\n    Time complexity: O(n) where n is the total number of elements\n    ")
           (letrec* ((%tmp0-220 (py-int-from-scheme 0)))
             (begin
               (set! j-1599
                     (or %tmp0-220
                         (py-throw-exception-with-message
                          py-builtin-UnboundLocalError
                          "local variable '%tmp0' referenced before assignment")))
               (set! i-1601
                     (or %tmp0-220
                         (py-throw-exception-with-message
                          py-builtin-UnboundLocalError
                          "local variable '%tmp0' referenced before assignment")))))
           (set! output-1603 (py-make-list))
           (let $%while_78 ()
             (when (and
                    (py-test (py-lt (or i-1601
                                        (py-throw-exception-with-message
                                         py-builtin-UnboundLocalError
                                         "local variable 'i' referenced before assignment"))
                                    (py-call (global-get
                                              %global
                                              (& "len")
                                              (vector-ref %caches 581))
                                             l1-218)))
                    (py-test (py-lt (or j-1599
                                        (py-throw-exception-with-message
                                         py-builtin-UnboundLocalError
                                         "local variable 'j' referenced before assignment"))
                                    (py-call (global-get
                                              %global
                                              (& "len")
                                              (vector-ref %caches 582))
                                             l2-219))))
               (if (py-test (py-le (py-getitem
                                    l1-218
                                    (or i-1601
                                        (py-throw-exception-with-message
                                         py-builtin-UnboundLocalError
                                         "local variable 'i' referenced before assignment")))
                                   (py-getitem
                                    l2-219
                                    (or j-1599
                                        (py-throw-exception-with-message
                                         py-builtin-UnboundLocalError
                                         "local variable 'j' referenced before assignment")))))
                   (begin
                     (py-call (py-getattribute output-1603 (& "append"))
                              (py-getitem
                               l1-218
                               (or i-1601
                                   (py-throw-exception-with-message
                                    py-builtin-UnboundLocalError
                                    "local variable 'i' referenced before assignment"))))
                     (set! i-1601
                           (py-iadd (or i-1601
                                        (py-throw-exception-with-message
                                         py-builtin-UnboundLocalError
                                         "local variable 'i' referenced before assignment"))
                                    (py-int-from-scheme 1))))
                   (begin
                     (py-call (py-getattribute output-1603 (& "append"))
                              (py-getitem
                               l2-219
                               (or j-1599
                                   (py-throw-exception-with-message
                                    py-builtin-UnboundLocalError
                                    "local variable 'j' referenced before assignment"))))
                     (set! j-1599
                           (py-iadd (or j-1599
                                        (py-throw-exception-with-message
                                         py-builtin-UnboundLocalError
                                         "local variable 'j' referenced before assignment"))
                                    (py-int-from-scheme 1)))))
               ($%while_78)))
           (py-call (py-getattribute output-1603 (& "extend"))
                    (py-add (py-getitem
                             l1-218
                             (py-slice-from-scheme
                              (or i-1601
                                  (py-throw-exception-with-message
                                   py-builtin-UnboundLocalError
                                   "local variable 'i' referenced before assignment"))
                              py-None
                              py-None))
                            (py-getitem
                             l2-219
                             (py-slice-from-scheme
                              (or j-1599
                                  (py-throw-exception-with-message
                                   py-builtin-UnboundLocalError
                                   "local variable 'j' referenced before assignment"))
                              py-None
                              py-None))))
           output-1603))))
   (define procedure:&py-builtin-__merge_many
     (lambda (lsts-221)
       (letrec* ((right-1613 #f) (left-1611 #f))
         (begin
           (&& "\n    Merge all items from k lists into one sorted list.\n    Time complexity: O(n log(k)) where n is the total number of elements and k the number of lists\n    ")
           (if (py-test (py-not lsts-221))
               (py-make-list)
               (if (py-test (py-eq (py-call (global-get
                                             %global
                                             (& "len")
                                             (vector-ref %caches 590))
                                            lsts-221)
                                   (py-int-from-scheme 1)))
                   (py-getitem
                    (py-getitem lsts-221 (py-int-from-scheme 0))
                    (py-slice-from-scheme py-None py-None py-None))
                   (if (py-test (py-eq (py-call (global-get
                                                 %global
                                                 (& "len")
                                                 (vector-ref %caches 591))
                                                lsts-221)
                                       (py-int-from-scheme 2)))
                       (procedure:&py-builtin-__merge
                        (py-getitem lsts-221 (py-int-from-scheme 0))
                        (py-getitem lsts-221 (py-int-from-scheme 1)))
                       (begin
                         (set! left-1611
                               (py-getitem
                                lsts-221
                                (py-slice-from-scheme
                                 (py-floordiv
                                  (py-call (global-get
                                            %global
                                            (& "len")
                                            (vector-ref %caches 593))
                                           lsts-221)
                                  (py-int-from-scheme 2))
                                 py-None
                                 py-None)))
                         (set! right-1613
                               (py-getitem
                                lsts-221
                                (py-slice-from-scheme
                                 py-None
                                 (py-floordiv
                                  (py-call (global-get
                                            %global
                                            (& "len")
                                            (vector-ref %caches 594))
                                           lsts-221)
                                  (py-int-from-scheme 2))
                                 py-None)))
                         (procedure:&py-builtin-__merge
                          (procedure:&py-builtin-__merge_many left-1611)
                          (procedure:&py-builtin-__merge_many
                           right-1613))))))))))
   (define procedure:&py-builtin-sorted
     (lambda (lst-222 key-223 reversed-224)
       (letrec* ((i-1618 #f) (sublsts-1616 #f))
         (begin
           (&& "\n    Timsort is an improved version of Merge Sort which splits the list into monotonic sub-lists before merging them\n    into a sorted list.\n    Worst case time complexity: O(n log(n))\n    Best cast time complexity:  O(n) when the list is almost sorted\n        where n is the number of elements in the list\n    ")
           (set! sublsts-1616 (py-make-list))
           (set! i-1618 (py-int-from-scheme 0))
           (let $%while_79 ()
             (when (py-test
                    (py-lt i-1618
                           (py-call (global-get
                                     %global
                                     (& "len")
                                     (vector-ref %caches 599))
                                    lst-222)))
               (begin
                 (py-call (py-getattribute sublsts-1616 (& "append"))
                          (py-make-list (py-getitem lst-222 i-1618)))
                 (set! i-1618
                       (py-iadd (or i-1618
                                    (py-throw-exception-with-message
                                     py-builtin-UnboundLocalError
                                     "local variable 'i' referenced before assignment"))
                                (py-int-from-scheme 1)))
                 (if (and (py-test (py-lt i-1618
                                          (py-call (global-get
                                                    %global
                                                    (& "len")
                                                    (vector-ref %caches 602))
                                                   lst-222)))
                          (py-test (py-ge (py-getitem lst-222 i-1618)
                                          (py-getitem
                                           lst-222
                                           (py-sub i-1618
                                                   (py-int-from-scheme 1))))))
                     (let $%while_80 ()
                       (when (and
                              (py-test (py-lt i-1618
                                              (py-call (global-get
                                                        %global
                                                        (& "len")
                                                        (vector-ref
                                                         %caches
                                                         603))
                                                       lst-222)))
                              (py-test (py-ge (py-getitem lst-222 i-1618)
                                              (py-getitem
                                               lst-222
                                               (py-sub i-1618
                                                       (py-int-from-scheme
                                                        1))))))
                         (begin
                           (py-call (py-getattribute
                                     (py-getitem
                                      sublsts-1616
                                      (py-neg (py-int-from-scheme 1)))
                                     (& "append"))
                                    (py-getitem lst-222 i-1618))
                           (set! i-1618
                                 (py-iadd (or i-1618
                                              (py-throw-exception-with-message
                                               py-builtin-UnboundLocalError
                                               "local variable 'i' referenced before assignment"))
                                          (py-int-from-scheme 1))))
                         ($%while_80)))
                     (if (py-test (py-lt i-1618
                                         (py-call (global-get
                                                   %global
                                                   (& "len")
                                                   (vector-ref %caches 607))
                                                  lst-222)))
                         (begin
                           (let $%while_81 ()
                             (when (and
                                    (py-test (py-lt i-1618
                                                    (py-call (global-get
                                                              %global
                                                              (& "len")
                                                              (vector-ref
                                                               %caches
                                                               608))
                                                             lst-222)))
                                    (py-test (py-lt (py-getitem lst-222 i-1618)
                                                    (py-getitem
                                                     lst-222
                                                     (py-sub i-1618
                                                             (py-int-from-scheme
                                                              1))))))
                               (begin
                                 (py-call (py-getattribute
                                           (py-getitem
                                            sublsts-1616
                                            (py-neg (py-int-from-scheme 1)))
                                           (& "append"))
                                          (py-getitem lst-222 i-1618))
                                 (set! i-1618
                                       (py-iadd (or i-1618
                                                    (py-throw-exception-with-message
                                                     py-builtin-UnboundLocalError
                                                     "local variable 'i' referenced before assignment"))
                                                (py-int-from-scheme 1))))
                               ($%while_81)))
                           (py-setitem
                            (or sublsts-1616
                                (py-throw-exception-with-message
                                 py-builtin-UnboundLocalError
                                 "local variable 'sublsts' referenced before assignment"))
                            (py-neg (py-int-from-scheme 1))
                            (py-getitem
                             (py-getitem
                              (or sublsts-1616
                                  (py-throw-exception-with-message
                                   py-builtin-UnboundLocalError
                                   "local variable 'sublsts' referenced before assignment"))
                              (py-neg (py-int-from-scheme 1)))
                             (py-slice-from-scheme
                              py-None
                              py-None
                              (py-neg (py-int-from-scheme 1))))))
                         #f)))
               ($%while_79)))
           (procedure:&py-builtin-__merge_many sublsts-1616)))))
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
   (define &py-builtin-method #f)
   (define &py-builtin-TypeError #f)
   (define &py-builtin-staticmethod #f)
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
     (global-register!
      %global
      (& "staticmethod")
      (lambda () &py-builtin-staticmethod)
      (lambda (v) (set! &py-builtin-staticmethod v)))
     (set! &py-builtin-staticmethod
           (let (($%cls_0 py-absent))
             (letrec* ((__get__-331 #f) (__new__-329 #f))
               (begin
                 (set! __new__-329
                       (procedure->py-function
                        (lambda (cls-2 obj-3)
                          (letrec* ()
                            (if (py-test (py-is cls-2
                                                &py-builtin-staticmethod))
                                (make-PyObjectMethodWrapper
                                 py-object-hclass-of-instances
                                 '#()
                                 py-builtin-staticmethod
                                 obj-3)
                                (if (py-isinstance?
                                     cls-2
                                     &py-builtin-staticmethod)
                                    (make-PyObjectMethodWrapper
                                     py-object-hclass-of-instances
                                     '#()
                                     cls-2
                                     obj-3)
                                    (py-throw
                                     (py-call &py-builtin-TypeError
                                              (&& "staticmethod.__new__ expected a subtype of 'staticmethod' as first argument")))))))
                        (make-signature args: (cls obj))))
                 (set! __get__-331
                       (procedure->py-function
                        (lambda (self-4 instance-5 owner-6)
                          (letrec* ()
                            (if (py-isinstance?
                                 self-4
                                 &py-builtin-staticmethod)
                                (PyObjectMethodWrapper-method self-4)
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__get__' requires a 'staticmethod' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-4)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature
                         args:
                         (self instance owner)
                         defaults:
                         (vector py-None)))))
               (begin
                 (set! $%cls_0
                       (py-make-builtin-class
                        (&& "staticmethod")
                        (&& "__main__")
                        (list)
                        (& "__get__")
                        __get__-331
                        (& "__new__")
                        __new__-329))
                 $%cls_0))))
     (set! &py-builtin-method
           (let (($%cls_1 py-absent))
             (letrec* ((__call__-346 #f) (__new__-344 #f))
               (begin
                 (set! __new__-344
                       (procedure->py-function
                        (lambda (cls-7 method_-8 self-9)
                          (letrec* ()
                            (begin
                              (if (py-test (py-is cls-7 &py-builtin-method))
                                  (make-PyObjectMethod
                                   py-method-hclass-of-instances
                                   '#()
                                   py-method-class
                                   self-9
                                   method_-8)
                                  (py-throw
                                   (py-call &py-builtin-TypeError
                                            (&& "method.__new__ expected a subtype of 'method' as first argument"))))
                              py-None)))
                        (make-signature args: (cls method_ self))))
                 (set! __call__-346
                       (procedure->py-function
                        (lambda (self-10 args-11 kwargs-12)
                          (letrec* ()
                            (py-call (PyObjectMethod-method self-10)
                                     (PyObjectMethod-self self-10)
                                     *:
                                     args-11
                                     **:
                                     kwargs-12)))
                        (make-signature
                         args:
                         (self)
                         vararg:
                         args
                         kwarg:
                         kwargs))))
               (begin
                 (set! $%cls_1
                       (py-make-builtin-class
                        (&& "method")
                        (&& "__main__")
                        (list)
                        (& "__call__")
                        __call__-346
                        (& "__new__")
                        __new__-344))
                 $%cls_1))))
     (set! &py-builtin-classmethod
           (let (($%cls_2 py-absent))
             (letrec* ((__get__-359 #f) (__new__-357 #f))
               (begin
                 (set! __new__-357
                       (procedure->py-function
                        (lambda (cls-13 obj-14)
                          (letrec* ()
                            (if (py-test (py-is cls-13
                                                &py-builtin-classmethod))
                                (make-PyObjectMethodWrapper
                                 py-object-hclass-of-instances
                                 '#()
                                 py-builtin-classmethod
                                 obj-14)
                                (if (py-isinstance?
                                     cls-13
                                     &py-builtin-classmethod)
                                    (make-PyObjectMethodWrapper
                                     py-object-hclass-of-instances
                                     '#()
                                     cls-13
                                     obj-14)
                                    (py-throw
                                     (py-call &py-builtin-TypeError
                                              (&& "classmethod.__new__ expected a subtype of 'classmethod' as first argument")))))))
                        (make-signature args: (cls obj))))
                 (set! __get__-359
                       (procedure->py-function
                        (lambda (self-15 instance-16 owner-17)
                          (letrec* ()
                            (if (py-isinstance?
                                 self-15
                                 &py-builtin-classmethod)
                                (if (py-test (py-is owner-17 py-None))
                                    (make-PyObjectMethod
                                     py-method-hclass-of-instances
                                     '#()
                                     py-method-class
                                     (py-obj-cls instance-16)
                                     (PyObjectMethodWrapper-method self-15))
                                    (make-PyObjectMethod
                                     py-method-hclass-of-instances
                                     '#()
                                     py-method-class
                                     owner-17
                                     (PyObjectMethodWrapper-method self-15)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__get__' requires a 'classmethod' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-15)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature
                         args:
                         (self instance owner)
                         defaults:
                         (vector py-None)))))
               (begin
                 (set! $%cls_2
                       (py-make-builtin-class
                        (&& "classmethod")
                        (&& "__main__")
                        (list)
                        (& "__get__")
                        __get__-359
                        (& "__new__")
                        __new__-357))
                 $%cls_2))))
     (let (($fun-obj
            (procedure->py-function
             procedure:&py-builtin-convert_to_int
             (make-signature args: (obj)))))
       (set! &py-builtin-convert_to_int $fun-obj)
       (set! init:&py-builtin-convert_to_int $fun-obj))
     (set! &py-builtin-int
           (let (($%cls_3 py-absent))
             (letrec* ((__lt__-486 #f)
                       (__le__-484 #f)
                       (__gt__-482 #f)
                       (__ge__-480 #f)
                       (__ne__-478 #f)
                       (__eq__-476 #f)
                       (__imod__-474 #f)
                       (__rmod__-472 #f)
                       (__mod__-470 #f)
                       (__itruediv__-468 #f)
                       (__rtruediv__-466 #f)
                       (__truediv__-464 #f)
                       (__ifloordiv__-462 #f)
                       (__rfloordiv__-460 #f)
                       (__floordiv__-458 #f)
                       (__invert__-456 #f)
                       (__neg__-454 #f)
                       (__pos__-452 #f)
                       (__irshift__-450 #f)
                       (__rrshift__-448 #f)
                       (__rshift__-446 #f)
                       (__ilshift__-444 #f)
                       (__rlshift__-442 #f)
                       (__lshift__-440 #f)
                       (__ixor__-438 #f)
                       (__rxor__-436 #f)
                       (__xor__-434 #f)
                       (__isub__-432 #f)
                       (__rsub__-430 #f)
                       (__sub__-428 #f)
                       (__ipow__-426 #f)
                       (__rpow__-424 #f)
                       (__pow__-422 #f)
                       (__imul__-420 #f)
                       (__rmul__-418 #f)
                       (__mul__-416 #f)
                       (__ior__-414 #f)
                       (__ror__-412 #f)
                       (__or__-410 #f)
                       (__iand__-408 #f)
                       (__rand__-406 #f)
                       (__and__-404 #f)
                       (__iadd__-402 #f)
                       (__radd__-400 #f)
                       (__add__-398 #f)
                       (__abs__-396 #f)
                       (__index__-394 #f)
                       (__bool__-392 #f)
                       (__new__-389 #f))
               (begin
                 (set! __new__-389
                       (procedure->py-function
                        (lambda (cls-19 val-20)
                          (letrec* ()
                            (if (py-test (py-is cls-19 &py-builtin-int))
                                (if (py-test (py-is val-20 py-absent))
                                    (py-int-from-scheme 0)
                                    (procedure:&py-builtin-convert_to_int
                                     val-20))
                                (if (and (py-isinstance?
                                          cls-19
                                          (global-get
                                           %global
                                           (& "type")
                                           (vector-ref %caches 23)))
                                         (py-test (py-call (global-get
                                                            %global
                                                            (& "issubclass")
                                                            (vector-ref
                                                             %caches
                                                             24))
                                                           cls-19
                                                           &py-builtin-int)))
                                    (if (py-test (py-is val-20 py-absent))
                                        (make-PyObjectInt
                                         py-int-hclass-of-instances
                                         '#()
                                         cls-19
                                         0)
                                        (make-PyObjectInt
                                         py-int-hclass-of-instances
                                         '#()
                                         cls-19
                                         (py-int-to-scheme
                                          (procedure:&py-builtin-convert_to_int
                                           val-20))))
                                    (py-throw
                                     (py-call &py-builtin-TypeError
                                              (&& "int.__new__ expected a subtype of 'int' as first argument")))))))
                        (make-signature
                         args:
                         (cls val)
                         defaults:
                         (vector py-absent))))
                 (set! __bool__-392
                       (procedure->py-function
                        (lambda (self-21)
                          (letrec* ()
                            (if (py-isinstance? self-21 &py-builtin-int)
                                (py-ne self-21 (py-int-from-scheme 0))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__bool__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-21)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __index__-394
                       (procedure->py-function
                        (lambda (self-22)
                          (letrec* ()
                            (if (py-isinstance? self-22 &py-builtin-int)
                                (py-int-from-scheme (py-int-to-scheme self-22))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__index__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-22)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __abs__-396
                       (procedure->py-function
                        (lambda (self-23)
                          (letrec* ()
                            (if (py-isinstance? self-23 &py-builtin-int)
                                (if (py-test (py-lt self-23
                                                    (py-int-from-scheme 0)))
                                    (py-int-from-scheme
                                     (pyneg (py-int-to-scheme self-23)))
                                    (py-int-from-scheme
                                     (py-int-to-scheme self-23)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__abs__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-23)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __add__-398
                       (procedure->py-function
                        (lambda (self-24 other-25)
                          (letrec* ()
                            (if (py-isinstance? self-24 &py-builtin-int)
                                (if (py-isinstance? other-25 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py+ (py-int-to-scheme self-24)
                                          (py-int-to-scheme other-25)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 40)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__add__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-24)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __radd__-400
                       (procedure->py-function
                        (lambda (self-26 other-27)
                          (letrec* ()
                            (if (py-isinstance? self-26 &py-builtin-int)
                                (if (py-isinstance? other-27 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py+ (py-int-to-scheme other-27)
                                          (py-int-to-scheme self-26)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 45)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__radd__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-26)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __iadd__-402
                       (procedure->py-function
                        (lambda (self-28 other-29)
                          (letrec* ()
                            (if (py-isinstance? self-28 &py-builtin-int)
                                (if (py-isinstance? other-29 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py+ (py-int-to-scheme self-28)
                                          (py-int-to-scheme other-29)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 50)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__iadd__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-28)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __and__-404
                       (procedure->py-function
                        (lambda (self-30 other-31)
                          (letrec* ()
                            (if (py-isinstance? self-30 &py-builtin-int)
                                (if (py-isinstance? other-31 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py& (py-int-to-scheme self-30)
                                          (py-int-to-scheme other-31)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 55)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__and__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-30)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rand__-406
                       (procedure->py-function
                        (lambda (self-32 other-33)
                          (letrec* ()
                            (if (py-isinstance? self-32 &py-builtin-int)
                                (if (py-isinstance? other-33 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py& (py-int-to-scheme other-33)
                                          (py-int-to-scheme self-32)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 60)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rand__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-32)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __iand__-408
                       (procedure->py-function
                        (lambda (self-34 other-35)
                          (letrec* ()
                            (if (py-isinstance? self-34 &py-builtin-int)
                                (if (py-isinstance? other-35 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py& (py-int-to-scheme self-34)
                                          (py-int-to-scheme other-35)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 65)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__iand__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-34)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __or__-410
                       (procedure->py-function
                        (lambda (self-36 other-37)
                          (letrec* ()
                            (if (py-isinstance? self-36 &py-builtin-int)
                                (if (py-isinstance? other-37 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py+b (py-int-to-scheme self-36)
                                           (py-int-to-scheme other-37)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 70)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__or__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-36)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ror__-412
                       (procedure->py-function
                        (lambda (self-38 other-39)
                          (letrec* ()
                            (if (py-isinstance? self-38 &py-builtin-int)
                                (if (py-isinstance? other-39 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py+b (py-int-to-scheme other-39)
                                           (py-int-to-scheme self-38)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 75)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ror__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-38)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ior__-414
                       (procedure->py-function
                        (lambda (self-40 other-41)
                          (letrec* ()
                            (if (py-isinstance? self-40 &py-builtin-int)
                                (if (py-isinstance? other-41 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py+b (py-int-to-scheme self-40)
                                           (py-int-to-scheme other-41)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 80)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ior__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-40)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __mul__-416
                       (procedure->py-function
                        (lambda (self-42 other-43)
                          (letrec* ()
                            (if (py-isinstance? self-42 &py-builtin-int)
                                (if (py-isinstance? other-43 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py* (py-int-to-scheme self-42)
                                          (py-int-to-scheme other-43)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 85)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__mul__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-42)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rmul__-418
                       (procedure->py-function
                        (lambda (self-44 other-45)
                          (letrec* ()
                            (if (py-isinstance? self-44 &py-builtin-int)
                                (if (py-isinstance? other-45 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py* (py-int-to-scheme other-45)
                                          (py-int-to-scheme self-44)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 90)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rmul__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-44)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __imul__-420
                       (procedure->py-function
                        (lambda (self-46 other-47)
                          (letrec* ()
                            (if (py-isinstance? self-46 &py-builtin-int)
                                (if (py-isinstance? other-47 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py* (py-int-to-scheme self-46)
                                          (py-int-to-scheme other-47)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 95)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__imul__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-46)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __pow__-422
                       (procedure->py-function
                        (lambda (self-48 other-49)
                          (letrec* ()
                            (if (py-isinstance? self-48 &py-builtin-int)
                                (if (py-isinstance? other-49 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py** (py-int-to-scheme self-48)
                                           (py-int-to-scheme other-49)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 100)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__pow__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-48)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rpow__-424
                       (procedure->py-function
                        (lambda (self-50 other-51)
                          (letrec* ()
                            (if (py-isinstance? self-50 &py-builtin-int)
                                (if (py-isinstance? other-51 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py** (py-int-to-scheme other-51)
                                           (py-int-to-scheme self-50)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 105)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rpow__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-50)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ipow__-426
                       (procedure->py-function
                        (lambda (self-52 other-53)
                          (letrec* ()
                            (if (py-isinstance? self-52 &py-builtin-int)
                                (if (py-isinstance? other-53 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py** (py-int-to-scheme self-52)
                                           (py-int-to-scheme other-53)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 110)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ipow__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-52)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __sub__-428
                       (procedure->py-function
                        (lambda (self-54 other-55)
                          (letrec* ()
                            (if (py-isinstance? self-54 &py-builtin-int)
                                (if (py-isinstance? other-55 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py- (py-int-to-scheme self-54)
                                          (py-int-to-scheme other-55)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 115)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__sub__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-54)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rsub__-430
                       (procedure->py-function
                        (lambda (self-56 other-57)
                          (letrec* ()
                            (if (py-isinstance? self-56 &py-builtin-int)
                                (if (py-isinstance? other-57 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py- (py-int-to-scheme other-57)
                                          (py-int-to-scheme self-56)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 120)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rsub__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-56)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __isub__-432
                       (procedure->py-function
                        (lambda (self-58 other-59)
                          (letrec* ()
                            (if (py-isinstance? self-58 &py-builtin-int)
                                (if (py-isinstance? other-59 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py- (py-int-to-scheme self-58)
                                          (py-int-to-scheme other-59)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 125)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__isub__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-58)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __xor__-434
                       (procedure->py-function
                        (lambda (self-60 other-61)
                          (letrec* ()
                            (if (py-isinstance? self-60 &py-builtin-int)
                                (if (py-isinstance? other-61 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py^ (py-int-to-scheme self-60)
                                          (py-int-to-scheme other-61)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 130)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__xor__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-60)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rxor__-436
                       (procedure->py-function
                        (lambda (self-62 other-63)
                          (letrec* ()
                            (if (py-isinstance? self-62 &py-builtin-int)
                                (if (py-isinstance? other-63 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py^ (py-int-to-scheme other-63)
                                          (py-int-to-scheme self-62)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 135)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rxor__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-62)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ixor__-438
                       (procedure->py-function
                        (lambda (self-64 other-65)
                          (letrec* ()
                            (if (py-isinstance? self-64 &py-builtin-int)
                                (if (py-isinstance? other-65 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py^ (py-int-to-scheme self-64)
                                          (py-int-to-scheme other-65)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 140)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ixor__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-64)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __lshift__-440
                       (procedure->py-function
                        (lambda (self-66 other-67)
                          (letrec* ()
                            (if (py-isinstance? self-66 &py-builtin-int)
                                (if (py-isinstance? other-67 &py-builtin-int)
                                    (if (py-test (py-ge other-67
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py<< (py-int-to-scheme self-66)
                                               (py-int-to-scheme other-67)))
                                        (py-throw
                                         (py-call &py-builtin-ValueError
                                                  (&& "negative shift count"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 146)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__lshift__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-66)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rlshift__-442
                       (procedure->py-function
                        (lambda (self-68 other-69)
                          (letrec* ()
                            (if (py-isinstance? self-68 &py-builtin-int)
                                (if (py-isinstance? other-69 &py-builtin-int)
                                    (if (py-test (py-ge self-68
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py<< (py-int-to-scheme self-68)
                                               (py-int-to-scheme other-69)))
                                        (py-throw
                                         (py-call &py-builtin-ValueError
                                                  (&& "negative shift count"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 152)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rlshift__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-68)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ilshift__-444
                       (procedure->py-function
                        (lambda (self-70 other-71)
                          (letrec* ()
                            (if (py-isinstance? self-70 &py-builtin-int)
                                (if (py-isinstance? other-71 &py-builtin-int)
                                    (if (py-test (py-ge other-71
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py<< (py-int-to-scheme self-70)
                                               (py-int-to-scheme other-71)))
                                        (py-throw
                                         (py-call &py-builtin-ValueError
                                                  (&& "negative shift count"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 158)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ilshift__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-70)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rshift__-446
                       (procedure->py-function
                        (lambda (self-72 other-73)
                          (letrec* ()
                            (if (py-isinstance? self-72 &py-builtin-int)
                                (if (py-isinstance? other-73 &py-builtin-int)
                                    (if (py-test (py-ge other-73
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py>> (py-int-to-scheme self-72)
                                               (py-int-to-scheme other-73)))
                                        (py-throw
                                         (py-call &py-builtin-ValueError
                                                  (&& "negative shift count"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 164)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rshift__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-72)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rrshift__-448
                       (procedure->py-function
                        (lambda (self-74 other-75)
                          (letrec* ()
                            (if (py-isinstance? self-74 &py-builtin-int)
                                (if (py-isinstance? other-75 &py-builtin-int)
                                    (if (py-test (py-ge self-74
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py>> (py-int-to-scheme self-74)
                                               (py-int-to-scheme other-75)))
                                        (py-throw
                                         (py-call &py-builtin-ValueError
                                                  (&& "negative shift count"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 170)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rrshift__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-74)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __irshift__-450
                       (procedure->py-function
                        (lambda (self-76 other-77)
                          (letrec* ()
                            (if (py-isinstance? self-76 &py-builtin-int)
                                (if (py-isinstance? other-77 &py-builtin-int)
                                    (if (py-test (py-ge other-77
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py>> (py-int-to-scheme self-76)
                                               (py-int-to-scheme other-77)))
                                        (py-throw
                                         (py-call &py-builtin-ValueError
                                                  (&& "negative shift count"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 176)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__irshift__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-76)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __pos__-452
                       (procedure->py-function
                        (lambda (self-78)
                          (letrec* ()
                            (if (py-isinstance? self-78 &py-builtin-int)
                                (py-int-from-scheme (py-int-to-scheme self-78))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__pos__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-78)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __neg__-454
                       (procedure->py-function
                        (lambda (self-79)
                          (letrec* ()
                            (if (py-isinstance? self-79 &py-builtin-int)
                                (py-int-from-scheme
                                 (pyneg (py-int-to-scheme self-79)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__neg__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-79)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __invert__-456
                       (procedure->py-function
                        (lambda (self-80)
                          (letrec* ()
                            (if (py-isinstance? self-80 &py-builtin-int)
                                (py-int-from-scheme
                                 (pyinvert (py-int-to-scheme self-80)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__invert__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-80)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __floordiv__-458
                       (procedure->py-function
                        (lambda (self-81 other-82)
                          (letrec* ()
                            (if (py-isinstance? self-81 &py-builtin-int)
                                (if (py-isinstance? other-82 &py-builtin-int)
                                    (if (py-test (py-ne other-82
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py// (py-int-to-scheme self-81)
                                               (py-int-to-scheme other-82)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "integer division by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 193)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__floordiv__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-81)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rfloordiv__-460
                       (procedure->py-function
                        (lambda (self-83 other-84)
                          (letrec* ()
                            (if (py-isinstance? self-83 &py-builtin-int)
                                (if (py-isinstance? other-84 &py-builtin-int)
                                    (if (py-test (py-ne self-83
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py// (py-int-to-scheme other-84)
                                               (py-int-to-scheme self-83)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "integer division by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 199)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rfloordiv__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-83)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ifloordiv__-462
                       (procedure->py-function
                        (lambda (self-85 other-86)
                          (letrec* ()
                            (if (py-isinstance? self-85 &py-builtin-int)
                                (if (py-isinstance? other-86 &py-builtin-int)
                                    (if (py-test (py-ne other-86
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py// (py-int-to-scheme self-85)
                                               (py-int-to-scheme other-86)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "integer division by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 205)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ifloordiv__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-85)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __truediv__-464
                       (procedure->py-function
                        (lambda (self-87 other-88)
                          (letrec* ()
                            (if (py-isinstance? self-87 &py-builtin-int)
                                (if (py-isinstance? other-88 &py-builtin-int)
                                    (if (py-test (py-ne other-88
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-float-from-scheme
                                         (py/ (py-int-to-scheme self-87)
                                              (py-int-to-scheme other-88)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "division by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 211)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__truediv__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-87)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rtruediv__-466
                       (procedure->py-function
                        (lambda (self-89 other-90)
                          (letrec* ()
                            (if (py-isinstance? self-89 &py-builtin-int)
                                (if (py-isinstance? other-90 &py-builtin-int)
                                    (if (py-test (py-ne self-89
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-float-from-scheme
                                         (py/ (py-int-to-scheme other-90)
                                              (py-int-to-scheme self-89)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "division by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 217)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rtruediv__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-89)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __itruediv__-468
                       (procedure->py-function
                        (lambda (self-91 other-92)
                          (letrec* ()
                            (if (py-isinstance? self-91 &py-builtin-int)
                                (if (py-isinstance? other-92 &py-builtin-int)
                                    (if (py-test (py-ne other-92
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-float-from-scheme
                                         (py/ (py-int-to-scheme self-91)
                                              (py-int-to-scheme other-92)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "division by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 223)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__itruediv__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-91)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __mod__-470
                       (procedure->py-function
                        (lambda (self-93 other-94)
                          (letrec* ()
                            (if (py-isinstance? self-93 &py-builtin-int)
                                (if (py-isinstance? other-94 &py-builtin-int)
                                    (if (py-test (py-ne other-94
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py% (py-int-to-scheme self-93)
                                              (py-int-to-scheme other-94)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "modulo by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 229)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__mod__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-93)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rmod__-472
                       (procedure->py-function
                        (lambda (self-95 other-96)
                          (letrec* ()
                            (if (py-isinstance? self-95 &py-builtin-int)
                                (if (py-isinstance? other-96 &py-builtin-int)
                                    (if (py-test (py-ne self-95
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py% (py-int-to-scheme other-96)
                                              (py-int-to-scheme self-95)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "modulo by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 235)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rmod__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-95)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __imod__-474
                       (procedure->py-function
                        (lambda (self-97 other-98)
                          (letrec* ()
                            (if (py-isinstance? self-97 &py-builtin-int)
                                (if (py-isinstance? other-98 &py-builtin-int)
                                    (if (py-test (py-ne other-98
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py% (py-int-to-scheme self-97)
                                              (py-int-to-scheme other-98)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "modulo by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 241)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__imod__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-97)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __eq__-476
                       (procedure->py-function
                        (lambda (self-99 other-100)
                          (letrec* ()
                            (if (py-isinstance? self-99 &py-builtin-int)
                                (if (py-isinstance? other-100 &py-builtin-int)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py== (py-int-to-scheme self-99)
                                            (py-int-to-scheme other-100))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 246)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__eq__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-99)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ne__-478
                       (procedure->py-function
                        (lambda (self-101 other-102)
                          (letrec* ()
                            (if (py-isinstance? self-101 &py-builtin-int)
                                (if (py-isinstance? other-102 &py-builtin-int)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py!= (py-int-to-scheme self-101)
                                            (py-int-to-scheme other-102))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 251)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ne__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-101)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ge__-480
                       (procedure->py-function
                        (lambda (self-103 other-104)
                          (letrec* ()
                            (if (py-isinstance? self-103 &py-builtin-int)
                                (if (py-isinstance? other-104 &py-builtin-int)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py>= (py-int-to-scheme self-103)
                                            (py-int-to-scheme other-104))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 256)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ge__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-103)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __gt__-482
                       (procedure->py-function
                        (lambda (self-105 other-106)
                          (letrec* ()
                            (if (py-isinstance? self-105 &py-builtin-int)
                                (if (py-isinstance? other-106 &py-builtin-int)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py> (py-int-to-scheme self-105)
                                           (py-int-to-scheme other-106))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 261)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__gt__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-105)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __le__-484
                       (procedure->py-function
                        (lambda (self-107 other-108)
                          (letrec* ()
                            (if (py-isinstance? self-107 &py-builtin-int)
                                (if (py-isinstance? other-108 &py-builtin-int)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py<= (py-int-to-scheme self-107)
                                            (py-int-to-scheme other-108))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 266)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__le__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-107)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __lt__-486
                       (procedure->py-function
                        (lambda (self-109 other-110)
                          (letrec* ()
                            (if (py-isinstance? self-109 &py-builtin-int)
                                (if (py-isinstance? other-110 &py-builtin-int)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py< (py-int-to-scheme self-109)
                                           (py-int-to-scheme other-110))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 271)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__lt__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-109)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other)))))
               (begin
                 (set! $%cls_3
                       (py-make-builtin-class
                        (&& "int")
                        (&& "__main__")
                        (list)
                        (& "__lt__")
                        __lt__-486
                        (& "__le__")
                        __le__-484
                        (& "__gt__")
                        __gt__-482
                        (& "__ge__")
                        __ge__-480
                        (& "__ne__")
                        __ne__-478
                        (& "__eq__")
                        __eq__-476
                        (& "__imod__")
                        __imod__-474
                        (& "__rmod__")
                        __rmod__-472
                        (& "__mod__")
                        __mod__-470
                        (& "__itruediv__")
                        __itruediv__-468
                        (& "__rtruediv__")
                        __rtruediv__-466
                        (& "__truediv__")
                        __truediv__-464
                        (& "__ifloordiv__")
                        __ifloordiv__-462
                        (& "__rfloordiv__")
                        __rfloordiv__-460
                        (& "__floordiv__")
                        __floordiv__-458
                        (& "__invert__")
                        __invert__-456
                        (& "__neg__")
                        __neg__-454
                        (& "__pos__")
                        __pos__-452
                        (& "__irshift__")
                        __irshift__-450
                        (& "__rrshift__")
                        __rrshift__-448
                        (& "__rshift__")
                        __rshift__-446
                        (& "__ilshift__")
                        __ilshift__-444
                        (& "__rlshift__")
                        __rlshift__-442
                        (& "__lshift__")
                        __lshift__-440
                        (& "__ixor__")
                        __ixor__-438
                        (& "__rxor__")
                        __rxor__-436
                        (& "__xor__")
                        __xor__-434
                        (& "__isub__")
                        __isub__-432
                        (& "__rsub__")
                        __rsub__-430
                        (& "__sub__")
                        __sub__-428
                        (& "__ipow__")
                        __ipow__-426
                        (& "__rpow__")
                        __rpow__-424
                        (& "__pow__")
                        __pow__-422
                        (& "__imul__")
                        __imul__-420
                        (& "__rmul__")
                        __rmul__-418
                        (& "__mul__")
                        __mul__-416
                        (& "__ior__")
                        __ior__-414
                        (& "__ror__")
                        __ror__-412
                        (& "__or__")
                        __or__-410
                        (& "__iand__")
                        __iand__-408
                        (& "__rand__")
                        __rand__-406
                        (& "__and__")
                        __and__-404
                        (& "__iadd__")
                        __iadd__-402
                        (& "__radd__")
                        __radd__-400
                        (& "__add__")
                        __add__-398
                        (& "__abs__")
                        __abs__-396
                        (& "__index__")
                        __index__-394
                        (& "__bool__")
                        __bool__-392
                        (& "__new__")
                        __new__-389))
                 $%cls_3))))
     (set! &py-builtin-bool
           (let (($%cls_4 py-absent))
             (letrec* ((__rxor__-947 #f)
                       (__xor__-945 #f)
                       (__ror__-943 #f)
                       (__or__-941 #f)
                       (__rand__-939 #f)
                       (__and__-937 #f)
                       (__repr__-935 #f)
                       (__new__-932 #f))
               (begin
                 (set! __new__-932
                       (procedure->py-function
                        (lambda (cls-111 val-112)
                          (letrec* ()
                            (if (py-test (py-is cls-111 &py-builtin-bool))
                                (if (py-test (py-is val-112 py-absent))
                                    py-False
                                    (py-truth val-112))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (&& "bool.__new__ expected a subtype of 'bool' as first argument"))))))
                        (make-signature
                         args:
                         (cls val)
                         defaults:
                         (vector py-absent))))
                 (set! __repr__-935
                       (procedure->py-function
                        (lambda (self-113)
                          (letrec* ()
                            (if (py-test (py-is self-113 py-True))
                                (&& "True")
                                (if (py-test (py-is self-113 py-False))
                                    (&& "False")
                                    (py-throw
                                     (py-call &py-builtin-TypeError
                                              (py-add (py-add (&& "descriptor '__repr__' requires a 'bool' object but received a '")
                                                              (py-getattribute
                                                               (py-obj-cls
                                                                self-113)
                                                               (& "__name__")))
                                                      (&& "'"))))))))
                        (make-signature args: (self))))
                 (set! __and__-937
                       (procedure->py-function
                        (lambda (self-114 other-115)
                          (letrec* ()
                            (if (py-test (py-is (py-obj-cls self-114)
                                                &py-builtin-bool))
                                (if (py-test (py-is (py-obj-cls other-115)
                                                    &py-builtin-bool))
                                    (if (py-test (py-is self-114 py-True))
                                        other-115
                                        py-False)
                                    (if (py-isinstance?
                                         other-115
                                         &py-builtin-int)
                                        (py-int-from-scheme
                                         (py& (py-int-to-scheme self-114)
                                              (py-int-to-scheme other-115)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 282))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__and__' requires a 'bool' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-114)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rand__-939
                       (procedure->py-function
                        (lambda (self-116 other-117)
                          (letrec* ()
                            (if (py-test (py-is (py-obj-cls self-116)
                                                &py-builtin-bool))
                                (if (py-test (py-is (py-obj-cls other-117)
                                                    &py-builtin-bool))
                                    (if (py-test (py-is self-116 py-True))
                                        other-117
                                        py-False)
                                    (if (py-isinstance?
                                         other-117
                                         &py-builtin-int)
                                        (py-int-from-scheme
                                         (py& (py-int-to-scheme other-117)
                                              (py-int-to-scheme self-116)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 288))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rand__' requires a 'bool' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-116)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __or__-941
                       (procedure->py-function
                        (lambda (self-118 other-119)
                          (letrec* ()
                            (if (py-test (py-is (py-obj-cls self-118)
                                                &py-builtin-bool))
                                (if (py-test (py-is (py-obj-cls other-119)
                                                    &py-builtin-bool))
                                    (if (py-test (py-is self-118 py-True))
                                        py-True
                                        other-119)
                                    (if (py-isinstance?
                                         other-119
                                         &py-builtin-int)
                                        (py-int-from-scheme
                                         (py+b (py-int-to-scheme self-118)
                                               (py-int-to-scheme other-119)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 294))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__or__' requires a 'bool' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-118)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ror__-943
                       (procedure->py-function
                        (lambda (self-120 other-121)
                          (letrec* ()
                            (if (py-test (py-is (py-obj-cls self-120)
                                                &py-builtin-bool))
                                (if (py-test (py-is (py-obj-cls other-121)
                                                    &py-builtin-bool))
                                    (if (py-test (py-is self-120 py-True))
                                        py-True
                                        other-121)
                                    (if (py-isinstance?
                                         other-121
                                         &py-builtin-int)
                                        (py-int-from-scheme
                                         (py+b (py-int-to-scheme other-121)
                                               (py-int-to-scheme self-120)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 300))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ror__' requires a 'bool' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-120)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __xor__-945
                       (procedure->py-function
                        (lambda (self-122 other-123)
                          (letrec* ()
                            (if (py-test (py-is (py-obj-cls self-122)
                                                &py-builtin-bool))
                                (if (py-test (py-is (py-obj-cls other-123)
                                                    &py-builtin-bool))
                                    (py-isnot self-122 other-123)
                                    (if (py-isinstance?
                                         other-123
                                         &py-builtin-int)
                                        (py-int-from-scheme
                                         (py^ (py-int-to-scheme self-122)
                                              (py-int-to-scheme other-123)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 306))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__xor__' requires a 'bool' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-122)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rxor__-947
                       (procedure->py-function
                        (lambda (self-124 other-125)
                          (letrec* ()
                            (if (py-test (py-is (py-obj-cls self-124)
                                                &py-builtin-bool))
                                (if (py-test (py-is (py-obj-cls other-125)
                                                    &py-builtin-bool))
                                    (py-isnot self-124 other-125)
                                    (if (py-isinstance?
                                         other-125
                                         &py-builtin-int)
                                        (py-int-from-scheme
                                         (py^ (py-int-to-scheme other-125)
                                              (py-int-to-scheme self-124)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 312))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rxor__' requires a 'bool' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-124)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other)))))
               (begin
                 (set! $%cls_4
                       (py-make-builtin-class
                        (&& "bool")
                        (&& "__main__")
                        (list &py-builtin-int)
                        (& "__rxor__")
                        __rxor__-947
                        (& "__xor__")
                        __xor__-945
                        (& "__ror__")
                        __ror__-943
                        (& "__or__")
                        __or__-941
                        (& "__rand__")
                        __rand__-939
                        (& "__and__")
                        __and__-937
                        (& "__repr__")
                        __repr__-935
                        (& "__new__")
                        __new__-932))
                 $%cls_4))))
     (let (($fun-obj
            (procedure->py-function
             procedure:&py-builtin-convert_to_float
             (make-signature args: (obj)))))
       (set! &py-builtin-convert_to_float $fun-obj)
       (set! init:&py-builtin-convert_to_float $fun-obj))
     (set! &py-builtin-float
           (let (($%cls_5 py-absent))
             (letrec* ((__lt__-1088 #f)
                       (__le__-1086 #f)
                       (__gt__-1084 #f)
                       (__ge__-1082 #f)
                       (__ne__-1080 #f)
                       (__eq__-1078 #f)
                       (__imod__-1076 #f)
                       (__rmod__-1074 #f)
                       (__mod__-1072 #f)
                       (__itruediv__-1070 #f)
                       (__rtruediv__-1068 #f)
                       (__truediv__-1066 #f)
                       (__ifloordiv__-1064 #f)
                       (__rfloordiv__-1062 #f)
                       (__floordiv__-1060 #f)
                       (__neg__-1058 #f)
                       (__pos__-1056 #f)
                       (__isub__-1054 #f)
                       (__rsub__-1052 #f)
                       (__sub__-1050 #f)
                       (__ipow__-1048 #f)
                       (__rpow__-1046 #f)
                       (__pow__-1044 #f)
                       (__imul__-1042 #f)
                       (__rmul__-1040 #f)
                       (__mul__-1038 #f)
                       (__iadd__-1036 #f)
                       (__radd__-1034 #f)
                       (__add__-1032 #f)
                       (__bool__-1030 #f)
                       (__float__-1028 #f)
                       (__new__-1025 #f))
               (begin
                 (set! __new__-1025
                       (procedure->py-function
                        (lambda (cls-127 val-128)
                          (letrec* ()
                            (if (py-test (py-is cls-127 &py-builtin-float))
                                (if (py-test (py-is val-128 py-absent))
                                    (py-float-from-scheme 0.)
                                    (py-throw
                                     (procedure:&py-builtin-convert_to_float
                                      val-128)))
                                (if (and (py-isinstance?
                                          cls-127
                                          (global-get
                                           %global
                                           (& "type")
                                           (vector-ref %caches 322)))
                                         (py-test (py-call (global-get
                                                            %global
                                                            (& "issubclass")
                                                            (vector-ref
                                                             %caches
                                                             323))
                                                           cls-127
                                                           &py-builtin-float)))
                                    (if (py-test (py-is val-128 py-absent))
                                        (make-PyObjectFloat
                                         py-float-hclass-of-instances
                                         '#()
                                         cls-127
                                         0.)
                                        (make-PyObjectFloat
                                         py-float-hclass-of-instances
                                         '#()
                                         cls-127
                                         (py-float-to-scheme
                                          (procedure:&py-builtin-convert_to_float
                                           val-128))))
                                    (py-throw
                                     (py-call &py-builtin-TypeError
                                              (&& "float.__new__ expected a subtype of 'float' as first argument")))))))
                        (make-signature
                         args:
                         (cls val)
                         defaults:
                         (vector py-absent))))
                 (set! __float__-1028
                       (procedure->py-function
                        (lambda (self-129)
                          (letrec* ()
                            (if (py-isinstance? self-129 &py-builtin-float)
                                (py-float-from-scheme
                                 (py-float-to-scheme self-129))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__float__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-129)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __bool__-1030
                       (procedure->py-function
                        (lambda (self-130)
                          (letrec* ()
                            (if (py-isinstance? self-130 &py-builtin-float)
                                (py-ne self-130 (py-float-from-scheme 0.))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__bool__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-130)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __add__-1032
                       (procedure->py-function
                        (lambda (self-131 other-132)
                          (letrec* ()
                            (if (py-isinstance? self-131 &py-builtin-float)
                                (if (py-isinstance?
                                     other-132
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py+ (py-float-to-scheme self-131)
                                          (py-float-to-scheme other-132)))
                                    (if (py-isinstance?
                                         other-132
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py+ (py-float-to-scheme self-131)
                                              (py-int-to-scheme other-132)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 336))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__add__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-131)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __radd__-1034
                       (procedure->py-function
                        (lambda (self-133 other-134)
                          (letrec* ()
                            (if (py-isinstance? self-133 &py-builtin-float)
                                (if (py-isinstance?
                                     other-134
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py+ (py-float-to-scheme other-134)
                                          (py-float-to-scheme self-133)))
                                    (if (py-isinstance?
                                         other-134
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py+ (py-int-to-scheme other-134)
                                              (py-float-to-scheme self-133)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 342))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__radd__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-133)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __iadd__-1036
                       (procedure->py-function
                        (lambda (self-135 other-136)
                          (letrec* ()
                            (if (py-isinstance? self-135 &py-builtin-float)
                                (if (py-isinstance?
                                     other-136
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py+ (py-float-to-scheme self-135)
                                          (py-float-to-scheme other-136)))
                                    (if (py-isinstance?
                                         self-135
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py+ (py-float-to-scheme self-135)
                                              (py-int-to-scheme other-136)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 348))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__iadd__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-135)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __mul__-1038
                       (procedure->py-function
                        (lambda (self-137 other-138)
                          (letrec* ()
                            (if (py-isinstance? self-137 &py-builtin-float)
                                (if (py-isinstance?
                                     other-138
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py* (py-float-to-scheme self-137)
                                          (py-float-to-scheme other-138)))
                                    (if (py-isinstance?
                                         other-138
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py* (py-float-to-scheme self-137)
                                              (py-int-to-scheme other-138)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 354))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__mul__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-137)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rmul__-1040
                       (procedure->py-function
                        (lambda (self-139 other-140)
                          (letrec* ()
                            (if (py-isinstance? self-139 &py-builtin-float)
                                (if (py-isinstance?
                                     other-140
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py* (py-float-to-scheme other-140)
                                          (py-float-to-scheme self-139)))
                                    (if (py-isinstance?
                                         other-140
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py* (py-int-to-scheme other-140)
                                              (py-float-to-scheme self-139)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 360))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rmul__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-139)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __imul__-1042
                       (procedure->py-function
                        (lambda (self-141 other-142)
                          (letrec* ()
                            (if (py-isinstance? self-141 &py-builtin-float)
                                (if (py-isinstance?
                                     other-142
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py* (py-float-to-scheme self-141)
                                          (py-float-to-scheme other-142)))
                                    (if (py-isinstance?
                                         self-141
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py* (py-float-to-scheme self-141)
                                              (py-int-to-scheme other-142)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 366))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__imul__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-141)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __pow__-1044
                       (procedure->py-function
                        (lambda (self-143 other-144)
                          (letrec* ()
                            (if (py-isinstance? self-143 &py-builtin-float)
                                (if (py-isinstance?
                                     other-144
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py** (py-float-to-scheme self-143)
                                           (py-float-to-scheme other-144)))
                                    (if (py-isinstance?
                                         other-144
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py** (py-float-to-scheme self-143)
                                               (py-int-to-scheme other-144)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 372))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__pow__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-143)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rpow__-1046
                       (procedure->py-function
                        (lambda (self-145 other-146)
                          (letrec* ()
                            (if (py-isinstance? self-145 &py-builtin-float)
                                (if (py-isinstance?
                                     other-146
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py** (py-float-to-scheme other-146)
                                           (py-float-to-scheme self-145)))
                                    (if (py-isinstance?
                                         other-146
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py** (py-int-to-scheme other-146)
                                               (py-float-to-scheme self-145)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 378))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rpow__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-145)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ipow__-1048
                       (procedure->py-function
                        (lambda (self-147 other-148)
                          (letrec* ()
                            (if (py-isinstance? self-147 &py-builtin-float)
                                (if (py-isinstance?
                                     other-148
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py** (py-float-to-scheme self-147)
                                           (py-float-to-scheme other-148)))
                                    (if (py-isinstance?
                                         self-147
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py** (py-float-to-scheme self-147)
                                               (py-int-to-scheme other-148)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 384))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ipow__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-147)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __sub__-1050
                       (procedure->py-function
                        (lambda (self-149 other-150)
                          (letrec* ()
                            (if (py-isinstance? self-149 &py-builtin-float)
                                (if (py-isinstance?
                                     other-150
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py- (py-float-to-scheme self-149)
                                          (py-float-to-scheme other-150)))
                                    (if (py-isinstance?
                                         other-150
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py- (py-float-to-scheme self-149)
                                              (py-int-to-scheme other-150)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 390))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__sub__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-149)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rsub__-1052
                       (procedure->py-function
                        (lambda (self-151 other-152)
                          (letrec* ()
                            (if (py-isinstance? self-151 &py-builtin-float)
                                (if (py-isinstance?
                                     other-152
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py- (py-float-to-scheme other-152)
                                          (py-float-to-scheme self-151)))
                                    (if (py-isinstance?
                                         other-152
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py- (py-int-to-scheme other-152)
                                              (py-float-to-scheme self-151)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 396))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rsub__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-151)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __isub__-1054
                       (procedure->py-function
                        (lambda (self-153 other-154)
                          (letrec* ()
                            (if (py-isinstance? self-153 &py-builtin-float)
                                (if (py-isinstance?
                                     other-154
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py- (py-float-to-scheme self-153)
                                          (py-float-to-scheme other-154)))
                                    (if (py-isinstance?
                                         self-153
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py- (py-float-to-scheme self-153)
                                              (py-int-to-scheme other-154)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 402))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__isub__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-153)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __pos__-1056
                       (procedure->py-function
                        (lambda (self-155)
                          (letrec* ()
                            (if (py-isinstance? self-155 &py-builtin-float)
                                self-155
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__pos__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-155)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __neg__-1058
                       (procedure->py-function
                        (lambda (self-156)
                          (letrec* ()
                            (if (py-isinstance? self-156 &py-builtin-float)
                                (py-float-from-scheme
                                 (pyneg (py-float-to-scheme self-156)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__neg__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-156)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __floordiv__-1060
                       (procedure->py-function
                        (lambda (self-157 other-158)
                          (letrec* ()
                            (if (py-isinstance? self-157 &py-builtin-float)
                                (if (py-isinstance?
                                     other-158
                                     &py-builtin-float)
                                    (if (py-test (py-ne other-158
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py// (py-float-to-scheme self-157)
                                               (py-float-to-scheme other-158)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float division by zero"))))
                                    (if (py-isinstance?
                                         other-158
                                         &py-builtin-int)
                                        (if (py-test (py-ne other-158
                                                            (py-int-from-scheme
                                                             0)))
                                            (py-float-from-scheme
                                             (py// (py-float-to-scheme
                                                    self-157)
                                                   (py-int-to-scheme
                                                    other-158)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float division by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 417))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__floordiv__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-157)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rfloordiv__-1062
                       (procedure->py-function
                        (lambda (self-159 other-160)
                          (letrec* ()
                            (if (py-isinstance? self-159 &py-builtin-float)
                                (if (py-isinstance?
                                     other-160
                                     &py-builtin-float)
                                    (if (py-test (py-ne self-159
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py// (py-float-to-scheme other-160)
                                               (py-float-to-scheme self-159)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float division by zero"))))
                                    (if (py-isinstance?
                                         other-160
                                         &py-builtin-int)
                                        (if (py-test (py-ne self-159
                                                            (py-float-from-scheme
                                                             0.)))
                                            (py-float-from-scheme
                                             (py// (py-int-to-scheme other-160)
                                                   (py-float-to-scheme
                                                    self-159)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float division by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 425))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rfloordiv__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-159)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ifloordiv__-1064
                       (procedure->py-function
                        (lambda (self-161 other-162)
                          (letrec* ()
                            (if (py-isinstance? self-161 &py-builtin-float)
                                (if (py-isinstance?
                                     other-162
                                     &py-builtin-float)
                                    (if (py-test (py-ne other-162
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py// (py-float-to-scheme self-161)
                                               (py-float-to-scheme other-162)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float division by zero"))))
                                    (if (py-isinstance?
                                         other-162
                                         &py-builtin-int)
                                        (if (py-test (py-ne other-162
                                                            (py-int-from-scheme
                                                             0)))
                                            (py-float-from-scheme
                                             (py// (py-float-to-scheme
                                                    self-161)
                                                   (py-int-to-scheme
                                                    other-162)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float division by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 433))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ifloordiv__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-161)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __truediv__-1066
                       (procedure->py-function
                        (lambda (self-163 other-164)
                          (letrec* ()
                            (if (py-isinstance? self-163 &py-builtin-float)
                                (if (py-isinstance?
                                     other-164
                                     &py-builtin-float)
                                    (if (py-test (py-ne other-164
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py/ (py-float-to-scheme self-163)
                                              (py-float-to-scheme other-164)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float division by zero"))))
                                    (if (py-isinstance?
                                         other-164
                                         &py-builtin-int)
                                        (if (py-test (py-ne other-164
                                                            (py-int-from-scheme
                                                             0)))
                                            (py-float-from-scheme
                                             (py/ (py-float-to-scheme self-163)
                                                  (py-int-to-scheme
                                                   other-164)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float division by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 441))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__truediv__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-163)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rtruediv__-1068
                       (procedure->py-function
                        (lambda (self-165 other-166)
                          (letrec* ()
                            (if (py-isinstance? self-165 &py-builtin-float)
                                (if (py-isinstance?
                                     other-166
                                     &py-builtin-float)
                                    (if (py-test (py-ne self-165
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py/ (py-float-to-scheme other-166)
                                              (py-float-to-scheme self-165)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float division by zero"))))
                                    (if (py-isinstance?
                                         other-166
                                         &py-builtin-int)
                                        (if (py-test (py-ne self-165
                                                            (py-float-from-scheme
                                                             0.)))
                                            (py-float-from-scheme
                                             (py/ (py-int-to-scheme other-166)
                                                  (py-float-to-scheme
                                                   self-165)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float division by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 449))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rtruediv__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-165)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __itruediv__-1070
                       (procedure->py-function
                        (lambda (self-167 other-168)
                          (letrec* ()
                            (if (py-isinstance? self-167 &py-builtin-float)
                                (if (py-isinstance?
                                     other-168
                                     &py-builtin-float)
                                    (if (py-test (py-ne other-168
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py/ (py-float-to-scheme self-167)
                                              (py-float-to-scheme other-168)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float division by zero"))))
                                    (if (py-isinstance?
                                         other-168
                                         &py-builtin-int)
                                        (if (py-test (py-ne other-168
                                                            (py-int-from-scheme
                                                             0)))
                                            (py-float-from-scheme
                                             (py/ (py-float-to-scheme self-167)
                                                  (py-int-to-scheme
                                                   other-168)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float division by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 457))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__itruediv__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-167)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __mod__-1072
                       (procedure->py-function
                        (lambda (self-169 other-170)
                          (letrec* ()
                            (if (py-isinstance? self-169 &py-builtin-float)
                                (if (py-isinstance?
                                     other-170
                                     &py-builtin-float)
                                    (if (py-test (py-ne other-170
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py% (py-float-to-scheme self-169)
                                              (py-float-to-scheme other-170)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float modulo by zero"))))
                                    (if (py-isinstance?
                                         other-170
                                         &py-builtin-int)
                                        (if (py-test (py-ne other-170
                                                            (py-int-from-scheme
                                                             0)))
                                            (py-float-from-scheme
                                             (py% (py-float-to-scheme self-169)
                                                  (py-int-to-scheme
                                                   other-170)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float modulo by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 465))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__mod__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-169)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rmod__-1074
                       (procedure->py-function
                        (lambda (self-171 other-172)
                          (letrec* ()
                            (if (py-isinstance? self-171 &py-builtin-float)
                                (if (py-isinstance?
                                     other-172
                                     &py-builtin-float)
                                    (if (py-test (py-ne self-171
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py% (py-float-to-scheme other-172)
                                              (py-float-to-scheme self-171)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float modulo by zero"))))
                                    (if (py-isinstance?
                                         other-172
                                         &py-builtin-int)
                                        (if (py-test (py-ne self-171
                                                            (py-float-from-scheme
                                                             0.)))
                                            (py-float-from-scheme
                                             (py% (py-int-to-scheme other-172)
                                                  (py-float-to-scheme
                                                   self-171)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float modulo by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 473))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rmod__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-171)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __imod__-1076
                       (procedure->py-function
                        (lambda (self-173 other-174)
                          (letrec* ()
                            (if (py-isinstance? self-173 &py-builtin-float)
                                (if (py-isinstance?
                                     other-174
                                     &py-builtin-float)
                                    (if (py-test (py-ne other-174
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py% (py-float-to-scheme self-173)
                                              (py-float-to-scheme other-174)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float modulo by zero"))))
                                    (if (py-isinstance?
                                         other-174
                                         &py-builtin-int)
                                        (if (py-test (py-ne other-174
                                                            (py-int-from-scheme
                                                             0)))
                                            (py-float-from-scheme
                                             (py% (py-float-to-scheme self-173)
                                                  (py-int-to-scheme
                                                   other-174)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float modulo by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 481))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__imod__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-173)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __eq__-1078
                       (procedure->py-function
                        (lambda (self-175 other-176)
                          (letrec* ()
                            (if (py-isinstance? self-175 &py-builtin-float)
                                (if (py-isinstance?
                                     other-176
                                     &py-builtin-float)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py== (py-float-to-scheme self-175)
                                            (py-float-to-scheme other-176))))
                                    (if (py-isinstance?
                                         other-176
                                         &py-builtin-int)
                                        (py-bool-from-scheme-bool
                                         (py-test-from-scheme
                                          (py== (py-float-to-scheme self-175)
                                                (py-int-to-scheme other-176))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 487))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__eq__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-175)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ne__-1080
                       (procedure->py-function
                        (lambda (self-177 other-178)
                          (letrec* ()
                            (if (py-isinstance? self-177 &py-builtin-float)
                                (if (py-isinstance?
                                     other-178
                                     &py-builtin-float)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py!= (py-float-to-scheme self-177)
                                            (py-float-to-scheme other-178))))
                                    (if (py-isinstance?
                                         other-178
                                         &py-builtin-int)
                                        (py-bool-from-scheme-bool
                                         (py-test-from-scheme
                                          (py!= (py-float-to-scheme self-177)
                                                (py-int-to-scheme other-178))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 493))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ne__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-177)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ge__-1082
                       (procedure->py-function
                        (lambda (self-179 other-180)
                          (letrec* ()
                            (if (py-isinstance? self-179 &py-builtin-float)
                                (if (py-isinstance?
                                     other-180
                                     &py-builtin-float)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py>= (py-float-to-scheme self-179)
                                            (py-float-to-scheme other-180))))
                                    (if (py-isinstance?
                                         other-180
                                         &py-builtin-int)
                                        (py-bool-from-scheme-bool
                                         (py-test-from-scheme
                                          (py>= (py-float-to-scheme self-179)
                                                (py-int-to-scheme other-180))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 499))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ge__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-179)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __gt__-1084
                       (procedure->py-function
                        (lambda (self-181 other-182)
                          (letrec* ()
                            (if (py-isinstance? self-181 &py-builtin-float)
                                (if (py-isinstance?
                                     other-182
                                     &py-builtin-float)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py> (py-float-to-scheme self-181)
                                           (py-float-to-scheme other-182))))
                                    (if (py-isinstance?
                                         other-182
                                         &py-builtin-int)
                                        (py-bool-from-scheme-bool
                                         (py-test-from-scheme
                                          (py> (py-float-to-scheme self-181)
                                               (py-int-to-scheme other-182))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 505))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__gt__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-181)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __le__-1086
                       (procedure->py-function
                        (lambda (self-183 other-184)
                          (letrec* ()
                            (if (py-isinstance? self-183 &py-builtin-float)
                                (if (py-isinstance?
                                     other-184
                                     &py-builtin-float)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py<= (py-float-to-scheme self-183)
                                            (py-float-to-scheme other-184))))
                                    (if (py-isinstance?
                                         other-184
                                         &py-builtin-int)
                                        (py-bool-from-scheme-bool
                                         (py-test-from-scheme
                                          (py<= (py-float-to-scheme self-183)
                                                (py-int-to-scheme other-184))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 511))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__le__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-183)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __lt__-1088
                       (procedure->py-function
                        (lambda (self-185 other-186)
                          (letrec* ()
                            (if (py-isinstance? self-185 &py-builtin-float)
                                (if (py-isinstance?
                                     other-186
                                     &py-builtin-float)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py< (py-float-to-scheme self-185)
                                           (py-float-to-scheme other-186))))
                                    (if (py-isinstance?
                                         other-186
                                         &py-builtin-int)
                                        (py-bool-from-scheme-bool
                                         (py-test-from-scheme
                                          (py< (py-float-to-scheme self-185)
                                               (py-int-to-scheme other-186))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 517))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__lt__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-185)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other)))))
               (begin
                 (set! $%cls_5
                       (py-make-builtin-class
                        (&& "float")
                        (&& "__main__")
                        (list)
                        (& "__lt__")
                        __lt__-1088
                        (& "__le__")
                        __le__-1086
                        (& "__gt__")
                        __gt__-1084
                        (& "__ge__")
                        __ge__-1082
                        (& "__ne__")
                        __ne__-1080
                        (& "__eq__")
                        __eq__-1078
                        (& "__imod__")
                        __imod__-1076
                        (& "__rmod__")
                        __rmod__-1074
                        (& "__mod__")
                        __mod__-1072
                        (& "__itruediv__")
                        __itruediv__-1070
                        (& "__rtruediv__")
                        __rtruediv__-1068
                        (& "__truediv__")
                        __truediv__-1066
                        (& "__ifloordiv__")
                        __ifloordiv__-1064
                        (& "__rfloordiv__")
                        __rfloordiv__-1062
                        (& "__floordiv__")
                        __floordiv__-1060
                        (& "__neg__")
                        __neg__-1058
                        (& "__pos__")
                        __pos__-1056
                        (& "__isub__")
                        __isub__-1054
                        (& "__rsub__")
                        __rsub__-1052
                        (& "__sub__")
                        __sub__-1050
                        (& "__ipow__")
                        __ipow__-1048
                        (& "__rpow__")
                        __rpow__-1046
                        (& "__pow__")
                        __pow__-1044
                        (& "__imul__")
                        __imul__-1042
                        (& "__rmul__")
                        __rmul__-1040
                        (& "__mul__")
                        __mul__-1038
                        (& "__iadd__")
                        __iadd__-1036
                        (& "__radd__")
                        __radd__-1034
                        (& "__add__")
                        __add__-1032
                        (& "__bool__")
                        __bool__-1030
                        (& "__float__")
                        __float__-1028
                        (& "__new__")
                        __new__-1025))
                 $%cls_5))))
     (set! &py-builtin-str
           (let (($%cls_6 py-absent))
             (letrec* ((__lt__-1449 #f)
                       (__le__-1447 #f)
                       (__gt__-1445 #f)
                       (__ge__-1443 #f)
                       (__ne__-1441 #f)
                       (__eq__-1439 #f)
                       (__rmul__-1437 #f)
                       (__mul__-1435 #f)
                       (__add__-1433 #f)
                       (__len__-1431 #f))
               (begin
                 (set! __len__-1431
                       (procedure->py-function
                        (lambda (self-187)
                          (letrec* ()
                            (if (py-isinstance? self-187 &py-builtin-str)
                                (py-int-from-scheme
                                 (py-str-len-to-scheme self-187))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__len__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-187)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __add__-1433
                       (procedure->py-function
                        (lambda (self-188 other-189)
                          (letrec* ()
                            (if (py-isinstance? self-188 &py-builtin-str)
                                (if (py-isinstance? other-189 &py-builtin-str)
                                    (py-str-from-scheme
                                     (py+ (py-str-to-scheme self-188)
                                          (py-str-to-scheme other-189)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 526)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__add__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-188)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __mul__-1435
                       (procedure->py-function
                        (lambda (self-190 other-191)
                          (letrec* ()
                            (if (py-isinstance? self-190 &py-builtin-str)
                                (if (py-isinstance? other-191 &py-builtin-int)
                                    (py-str-from-scheme
                                     (py* (py-str-to-scheme self-190)
                                          (py-int-to-scheme other-191)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 531)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__mul__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-190)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rmul__-1437
                       (procedure->py-function
                        (lambda (self-192 other-193)
                          (letrec* ()
                            (if (py-isinstance? self-192 &py-builtin-str)
                                (if (py-isinstance? other-193 &py-builtin-int)
                                    (py-str-from-scheme
                                     (py* (py-str-to-scheme self-192)
                                          (py-int-to-scheme other-193)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 536)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rmul__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-192)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __eq__-1439
                       (procedure->py-function
                        (lambda (self-194 other-195)
                          (letrec* ()
                            (if (py-isinstance? self-194 &py-builtin-str)
                                (if (py-isinstance? other-195 &py-builtin-str)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py== (py-str-to-scheme self-194)
                                            (py-str-to-scheme other-195))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 541)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__eq__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-194)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ne__-1441
                       (procedure->py-function
                        (lambda (self-196 other-197)
                          (letrec* ()
                            (if (py-isinstance? self-196 &py-builtin-str)
                                (if (py-isinstance? other-197 &py-builtin-str)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py!= (py-str-to-scheme self-196)
                                            (py-str-to-scheme other-197))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 546)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ne__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-196)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ge__-1443
                       (procedure->py-function
                        (lambda (self-198 other-199)
                          (letrec* ()
                            (if (py-isinstance? self-198 &py-builtin-str)
                                (if (py-isinstance? other-199 &py-builtin-str)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py>= (py-str-to-scheme self-198)
                                            (py-str-to-scheme other-199))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 551)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ge__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-198)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __gt__-1445
                       (procedure->py-function
                        (lambda (self-200 other-201)
                          (letrec* ()
                            (if (py-isinstance? self-200 &py-builtin-str)
                                (if (py-isinstance? other-201 &py-builtin-str)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py> (py-str-to-scheme self-200)
                                           (py-str-to-scheme other-201))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 556)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__gt__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-200)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __le__-1447
                       (procedure->py-function
                        (lambda (self-202 other-203)
                          (letrec* ()
                            (if (py-isinstance? self-202 &py-builtin-str)
                                (if (py-isinstance? other-203 &py-builtin-str)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py<= (py-str-to-scheme self-202)
                                            (py-str-to-scheme other-203))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 561)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__le__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-202)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __lt__-1449
                       (procedure->py-function
                        (lambda (self-204 other-205)
                          (letrec* ()
                            (if (py-isinstance? self-204 &py-builtin-str)
                                (if (py-isinstance? other-205 &py-builtin-str)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py< (py-str-to-scheme self-204)
                                           (py-str-to-scheme other-205))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 566)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__lt__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-204)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other)))))
               (begin
                 (set! $%cls_6
                       (py-make-builtin-class
                        (&& "str")
                        (&& "__main__")
                        (list)
                        (& "__lt__")
                        __lt__-1449
                        (& "__le__")
                        __le__-1447
                        (& "__gt__")
                        __gt__-1445
                        (& "__ge__")
                        __ge__-1443
                        (& "__ne__")
                        __ne__-1441
                        (& "__eq__")
                        __eq__-1439
                        (& "__rmul__")
                        __rmul__-1437
                        (& "__mul__")
                        __mul__-1435
                        (& "__add__")
                        __add__-1433
                        (& "__len__")
                        __len__-1431))
                 $%cls_6))))
     (set! &py-builtin-range_iterator
           (let (($%cls_7 py-absent))
             (letrec* ((__next__-1547 #f) (__iter__-1545 #f) (__new__-1543 #f))
               (begin
                 (set! __new__-1543
                       (procedure->py-function
                        (lambda (args-206)
                          (letrec* ()
                            (py-throw
                             (py-call &py-builtin-ValueError
                                      (&& "cannot create 'range_iterator' instances")))))
                        (make-signature vararg: args)))
                 (set! __iter__-1545
                       (procedure->py-function
                        (lambda (self-207) (letrec* () self-207))
                        (make-signature posonlyargs: (self))))
                 (set! __next__-1547
                       (procedure->py-function
                        (lambda (self-208)
                          (bind-exit
                           ($%return_76)
                           (letrec* ((step-1554 #f)
                                     (stop-1552 #f)
                                     (start-1549 #f))
                             (begin
                               (set! start-1549
                                     (PyObjectRangeIterator-start self-208))
                               (set! stop-1552
                                     (PyObjectRangeIterator-stop self-208))
                               (set! step-1554
                                     (PyObjectRangeIterator-step self-208))
                               (if (py-test (py-lt step-1554
                                                   (py-int-from-scheme 0)))
                                   (if (py-test (py-gt start-1549 stop-1552))
                                       (begin
                                         (PyObjectRangeIterator-start-set!
                                          self-208
                                          (py-add start-1549 step-1554))
                                         ($%return_76 start-1549))
                                       #f)
                                   (if (py-test (py-lt start-1549 stop-1552))
                                       (begin
                                         (PyObjectRangeIterator-start-set!
                                          self-208
                                          (py-add start-1549 step-1554))
                                         ($%return_76 start-1549))
                                       #f))
                               (py-throw &py-builtin-StopIteration)))))
                        (make-signature posonlyargs: (self)))))
               (begin
                 (set! $%cls_7
                       (py-make-builtin-class
                        (&& "range_iterator")
                        (&& "__main__")
                        (list)
                        (& "__next__")
                        __next__-1547
                        (& "__iter__")
                        __iter__-1545
                        (& "__new__")
                        __new__-1543))
                 $%cls_7))))
     (set! &py-builtin-range
           (let (($%cls_8 py-absent))
             (letrec* ((__repr__-1568 #f)
                       (__iter__-1566 #f)
                       (__contains__-1564 #f)
                       (__len__-1562 #f)
                       (__new__-1559 #f))
               (begin
                 (set! __new__-1559
                       (procedure->py-function
                        (lambda (cls-209 arg1-210 arg2-211 arg3-212)
                          (letrec* ()
                            (if (py-test (py-is cls-209 &py-builtin-range))
                                (if (py-test (py-isnot arg3-212 py-absent))
                                    (make-PyObjectRange
                                     py-range-hclass-of-instances
                                     '#()
                                     py-builtin-range
                                     (py-big-index arg1-210)
                                     (py-big-index arg2-211)
                                     (py-big-index arg3-212))
                                    (if (py-test (py-isnot arg2-211 py-absent))
                                        (make-PyObjectRange
                                         py-range-hclass-of-instances
                                         '#()
                                         py-builtin-range
                                         (py-big-index arg1-210)
                                         (py-big-index arg2-211)
                                         (py-int-from-scheme 1))
                                        (make-PyObjectRange
                                         py-range-hclass-of-instances
                                         '#()
                                         py-builtin-range
                                         (py-int-from-scheme 0)
                                         (py-big-index arg1-210)
                                         (py-int-from-scheme 1))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (&& "range.__new__ expected a subtype of 'range' as first argument"))))))
                        (make-signature
                         posonlyargs:
                         (cls arg1 arg2 arg3)
                         defaults:
                         (vector py-absent py-absent))))
                 (set! __len__-1562
                       (procedure->py-function
                        (lambda (self-213)
                          (letrec* ()
                            (py-floordiv
                             (py-sub (PyObjectRange-stop self-213)
                                     (PyObjectRange-start self-213))
                             (PyObjectRange-step self-213))))
                        (make-signature posonlyargs: (self))))
                 (set! __contains__-1564
                       (procedure->py-function
                        (lambda (self-214 item-215)
                          (bind-exit
                           ($%return_77)
                           (letrec* ((step-1586 #f)
                                     (stop-1584 #f)
                                     (start-1581 #f))
                             (begin
                               (set! start-1581 (PyObjectRange-start self-214))
                               (set! stop-1584 (PyObjectRange-stop self-214))
                               (set! step-1586 (PyObjectRange-step self-214))
                               (if (py-test (py-lt step-1586
                                                   (py-int-from-scheme 0)))
                                   (if (or (py-test (py-ge stop-1584 item-215))
                                           (py-test (py-gt item-215
                                                           start-1581)))
                                       ($%return_77 py-False)
                                       #f)
                                   (if (or (py-test (py-gt start-1581
                                                           item-215))
                                           (py-test (py-ge item-215
                                                           stop-1584)))
                                       ($%return_77 py-False)
                                       #f))
                               (py-eq (py-mod (py-sub item-215 start-1581)
                                              step-1586)
                                      (py-int-from-scheme 0))))))
                        (make-signature posonlyargs: (self item))))
                 (set! __iter__-1566
                       (procedure->py-function
                        (lambda (self-216)
                          (letrec* ()
                            (make-PyObjectRangeIterator
                             py-range_iterator-hclass-of-instances
                             '#()
                             py-builtin-range_iterator
                             (PyObjectRange-start self-216)
                             (PyObjectRange-stop self-216)
                             (PyObjectRange-step self-216))))
                        (make-signature posonlyargs: (self))))
                 (set! __repr__-1568
                       (procedure->py-function
                        (lambda (self-217)
                          (letrec* ((step-1575 #f)
                                    (stop-1573 #f)
                                    (start-1570 #f))
                            (begin
                              (set! start-1570 (PyObjectRange-start self-217))
                              (set! stop-1573 (PyObjectRange-stop self-217))
                              (set! step-1575 (PyObjectRange-step self-217))
                              (if (py-test (py-eq step-1575
                                                  (py-int-from-scheme 1)))
                                  (py-add (py-add (py-add (py-add (&& "range(")
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                          (py-call &py-builtin-str start-1570))
                  (&& ", "))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                  (py-call &py-builtin-str
                                                           stop-1573))
                                          (&& ")"))
                                  (py-add (py-add (py-add (py-add (py-add (py-add (&& "range(")
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                                          (py-call &py-builtin-str start-1570))
                                  (&& ", "))
                          (py-call &py-builtin-str stop-1573))
                  (&& ", "))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                  (py-call &py-builtin-str
                                                           step-1575))
                                          (&& ")"))))))
                        (make-signature args: (self)))))
               (begin
                 (set! $%cls_8
                       (py-make-builtin-class
                        (&& "range")
                        (&& "__main__")
                        (list)
                        (& "__repr__")
                        __repr__-1568
                        (& "__iter__")
                        __iter__-1566
                        (& "__contains__")
                        __contains__-1564
                        (& "__len__")
                        __len__-1562
                        (& "__new__")
                        __new__-1559))
                 $%cls_8))))
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
           (let (($%cls_9 py-absent))
             (letrec* ((__str__-1625 #f) (__init__-1623 #f))
               (begin
                 (set! __init__-1623
                       (procedure->py-function
                        (lambda (self-225 args-226)
                          (letrec* ()
                            (begin
                              (py-setattribute
                               (or self-225
                                   (py-throw-exception-with-message
                                    py-builtin-UnboundLocalError
                                    "local variable 'self' referenced before assignment"))
                               (& "args")
                               (or args-226
                                   (py-throw-exception-with-message
                                    py-builtin-UnboundLocalError
                                    "local variable 'args' referenced before assignment")))
                              py-None)))
                        (make-signature args: (self) vararg: args)))
                 (set! __str__-1625
                       (procedure->py-function
                        (lambda (self-227)
                          (letrec* ((args_len-1630 #f) (args-1627 #f))
                            (begin
                              (set! args-1627
                                    (py-getattribute self-227 (& "args")))
                              (set! args_len-1630
                                    (py-call (global-get
                                              %global
                                              (& "len")
                                              (vector-ref %caches 619))
                                             (py-getattribute
                                              self-227
                                              (& "args"))))
                              (if (py-test (py-eq args_len-1630
                                                  (py-int-from-scheme 0)))
                                  (&& "")
                                  (if (py-test (py-eq args_len-1630
                                                      (py-int-from-scheme 1)))
                                      (py-call &py-builtin-str
                                               (py-getitem
                                                args-1627
                                                (py-int-from-scheme 0)))
                                      (py-call &py-builtin-str args-1627))))))
                        (make-signature args: (self)))))
               (begin
                 (set! $%cls_9
                       (py-make-builtin-class
                        (&& "BaseException")
                        (&& "__main__")
                        (list)
                        (& "__str__")
                        __str__-1625
                        (& "__init__")
                        __init__-1623))
                 $%cls_9))))
     (set! &py-builtin-Exception
           (let (($%cls_10 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_10
                       (py-make-builtin-class
                        (&& "Exception")
                        (&& "__main__")
                        (list &py-builtin-BaseException)))
                 $%cls_10))))
     (set! &py-builtin-GeneratorExit
           (let (($%cls_11 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_11
                       (py-make-builtin-class
                        (&& "GeneratorExit")
                        (&& "__main__")
                        (list &py-builtin-BaseException)))
                 $%cls_11))))
     (set! &py-builtin-KeyboardInterrupt
           (let (($%cls_12 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_12
                       (py-make-builtin-class
                        (&& "KeyboardInterrupt")
                        (&& "__main__")
                        (list &py-builtin-BaseException)))
                 $%cls_12))))
     (set! &py-builtin-SystemExit
           (let (($%cls_13 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_13
                       (py-make-builtin-class
                        (&& "SystemExit")
                        (&& "__main__")
                        (list &py-builtin-BaseException)))
                 $%cls_13))))
     (set! &py-builtin-ArithmeticError
           (let (($%cls_14 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_14
                       (py-make-builtin-class
                        (&& "ArithmeticError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_14))))
     (set! &py-builtin-AssertionError
           (let (($%cls_15 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_15
                       (py-make-builtin-class
                        (&& "AssertionError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_15))))
     (set! &py-builtin-AttributeError
           (let (($%cls_16 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_16
                       (py-make-builtin-class
                        (&& "AttributeError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_16))))
     (set! &py-builtin-BufferError
           (let (($%cls_17 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_17
                       (py-make-builtin-class
                        (&& "BufferError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_17))))
     (set! &py-builtin-EOFError
           (let (($%cls_18 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_18
                       (py-make-builtin-class
                        (&& "EOFError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_18))))
     (set! &py-builtin-ImportError
           (let (($%cls_19 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_19
                       (py-make-builtin-class
                        (&& "ImportError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_19))))
     (set! &py-builtin-LookupError
           (let (($%cls_20 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_20
                       (py-make-builtin-class
                        (&& "LookupError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_20))))
     (set! &py-builtin-MemoryError
           (let (($%cls_21 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_21
                       (py-make-builtin-class
                        (&& "MemoryError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_21))))
     (set! &py-builtin-NameError
           (let (($%cls_22 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_22
                       (py-make-builtin-class
                        (&& "NameError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_22))))
     (set! &py-builtin-EnvironmentError
           (let (($%cls_23 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_23
                       (py-make-builtin-class
                        (&& "EnvironmentError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_23))))
     (set! &py-builtin-IOError
           (let (($%cls_24 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_24
                       (py-make-builtin-class
                        (&& "IOError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_24))))
     (set! &py-builtin-OSError
           (let (($%cls_25 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_25
                       (py-make-builtin-class
                        (&& "OSError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_25))))
     (set! &py-builtin-WindowsError
           (let (($%cls_26 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_26
                       (py-make-builtin-class
                        (&& "WindowsError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_26))))
     (set! &py-builtin-ReferenceError
           (let (($%cls_27 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_27
                       (py-make-builtin-class
                        (&& "ReferenceError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_27))))
     (set! &py-builtin-RuntimeError
           (let (($%cls_28 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_28
                       (py-make-builtin-class
                        (&& "RuntimeError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_28))))
     (set! &py-builtin-StopAsyncIteration
           (let (($%cls_29 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_29
                       (py-make-builtin-class
                        (&& "StopAsyncIteration")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_29))))
     (set! &py-builtin-StopIteration
           (let (($%cls_30 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_30
                       (py-make-builtin-class
                        (&& "StopIteration")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_30))))
     (set! &py-builtin-SyntaxError
           (let (($%cls_31 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_31
                       (py-make-builtin-class
                        (&& "SyntaxError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_31))))
     (set! &py-builtin-SystemError
           (let (($%cls_32 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_32
                       (py-make-builtin-class
                        (&& "SystemError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_32))))
     (set! &py-builtin-TypeError
           (let (($%cls_33 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_33
                       (py-make-builtin-class
                        (&& "TypeError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_33))))
     (set! &py-builtin-ValueError
           (let (($%cls_34 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_34
                       (py-make-builtin-class
                        (&& "ValueError")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_34))))
     (set! &py-builtin-Warning
           (let (($%cls_35 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_35
                       (py-make-builtin-class
                        (&& "Warning")
                        (&& "__main__")
                        (list &py-builtin-Exception)))
                 $%cls_35))))
     (set! &py-builtin-FloatingPointError
           (let (($%cls_36 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_36
                       (py-make-builtin-class
                        (&& "FloatingPointError")
                        (&& "__main__")
                        (list &py-builtin-ArithmeticError)))
                 $%cls_36))))
     (set! &py-builtin-OverflowError
           (let (($%cls_37 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_37
                       (py-make-builtin-class
                        (&& "OverflowError")
                        (&& "__main__")
                        (list &py-builtin-ArithmeticError)))
                 $%cls_37))))
     (set! &py-builtin-ZeroDivisionError
           (let (($%cls_38 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_38
                       (py-make-builtin-class
                        (&& "ZeroDivisionError")
                        (&& "__main__")
                        (list &py-builtin-ArithmeticError)))
                 $%cls_38))))
     (set! &py-builtin-ModuleNotFoundError
           (let (($%cls_39 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_39
                       (py-make-builtin-class
                        (&& "ModuleNotFoundError")
                        (&& "__main__")
                        (list &py-builtin-ImportError)))
                 $%cls_39))))
     (set! &py-builtin-IndexError
           (let (($%cls_40 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_40
                       (py-make-builtin-class
                        (&& "IndexError")
                        (&& "__main__")
                        (list &py-builtin-LookupError)))
                 $%cls_40))))
     (set! &py-builtin-KeyError
           (let (($%cls_41 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_41
                       (py-make-builtin-class
                        (&& "KeyError")
                        (&& "__main__")
                        (list &py-builtin-LookupError)))
                 $%cls_41))))
     (set! &py-builtin-UnboundLocalError
           (let (($%cls_42 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_42
                       (py-make-builtin-class
                        (&& "UnboundLocalError")
                        (&& "__main__")
                        (list &py-builtin-NameError)))
                 $%cls_42))))
     (set! &py-builtin-BlockingIOError
           (let (($%cls_43 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_43
                       (py-make-builtin-class
                        (&& "BlockingIOError")
                        (&& "__main__")
                        (list &py-builtin-OSError)))
                 $%cls_43))))
     (set! &py-builtin-ChildProcessError
           (let (($%cls_44 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_44
                       (py-make-builtin-class
                        (&& "ChildProcessError")
                        (&& "__main__")
                        (list &py-builtin-OSError)))
                 $%cls_44))))
     (set! &py-builtin-ConnectionError
           (let (($%cls_45 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_45
                       (py-make-builtin-class
                        (&& "ConnectionError")
                        (&& "__main__")
                        (list &py-builtin-OSError)))
                 $%cls_45))))
     (set! &py-builtin-FileExistsError
           (let (($%cls_46 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_46
                       (py-make-builtin-class
                        (&& "FileExistsError")
                        (&& "__main__")
                        (list &py-builtin-OSError)))
                 $%cls_46))))
     (set! &py-builtin-FileNotFoundError
           (let (($%cls_47 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_47
                       (py-make-builtin-class
                        (&& "FileNotFoundError")
                        (&& "__main__")
                        (list &py-builtin-OSError)))
                 $%cls_47))))
     (set! &py-builtin-InterruptedError
           (let (($%cls_48 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_48
                       (py-make-builtin-class
                        (&& "InterruptedError")
                        (&& "__main__")
                        (list &py-builtin-OSError)))
                 $%cls_48))))
     (set! &py-builtin-IsADirectoryError
           (let (($%cls_49 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_49
                       (py-make-builtin-class
                        (&& "IsADirectoryError")
                        (&& "__main__")
                        (list &py-builtin-OSError)))
                 $%cls_49))))
     (set! &py-builtin-NotADirectoryError
           (let (($%cls_50 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_50
                       (py-make-builtin-class
                        (&& "NotADirectoryError")
                        (&& "__main__")
                        (list &py-builtin-OSError)))
                 $%cls_50))))
     (set! &py-builtin-PermissionError
           (let (($%cls_51 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_51
                       (py-make-builtin-class
                        (&& "PermissionError")
                        (&& "__main__")
                        (list &py-builtin-OSError)))
                 $%cls_51))))
     (set! &py-builtin-ProcessLookupError
           (let (($%cls_52 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_52
                       (py-make-builtin-class
                        (&& "ProcessLookupError")
                        (&& "__main__")
                        (list &py-builtin-OSError)))
                 $%cls_52))))
     (set! &py-builtin-TimeoutError
           (let (($%cls_53 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_53
                       (py-make-builtin-class
                        (&& "TimeoutError")
                        (&& "__main__")
                        (list &py-builtin-OSError)))
                 $%cls_53))))
     (set! &py-builtin-NotImplementedError
           (let (($%cls_54 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_54
                       (py-make-builtin-class
                        (&& "NotImplementedError")
                        (&& "__main__")
                        (list &py-builtin-RuntimeError)))
                 $%cls_54))))
     (set! &py-builtin-RecursionError
           (let (($%cls_55 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_55
                       (py-make-builtin-class
                        (&& "RecursionError")
                        (&& "__main__")
                        (list &py-builtin-RuntimeError)))
                 $%cls_55))))
     (set! &py-builtin-IndentationError
           (let (($%cls_56 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_56
                       (py-make-builtin-class
                        (&& "IndentationError")
                        (&& "__main__")
                        (list &py-builtin-SyntaxError)))
                 $%cls_56))))
     (set! &py-builtin-UnicodeError
           (let (($%cls_57 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_57
                       (py-make-builtin-class
                        (&& "UnicodeError")
                        (&& "__main__")
                        (list &py-builtin-ValueError)))
                 $%cls_57))))
     (set! &py-builtin-BytesWarning
           (let (($%cls_58 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_58
                       (py-make-builtin-class
                        (&& "BytesWarning")
                        (&& "__main__")
                        (list &py-builtin-Warning)))
                 $%cls_58))))
     (set! &py-builtin-DeprecationWarning
           (let (($%cls_59 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_59
                       (py-make-builtin-class
                        (&& "DeprecationWarning")
                        (&& "__main__")
                        (list &py-builtin-Warning)))
                 $%cls_59))))
     (set! &py-builtin-FutureWarning
           (let (($%cls_60 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_60
                       (py-make-builtin-class
                        (&& "FutureWarning")
                        (&& "__main__")
                        (list &py-builtin-Warning)))
                 $%cls_60))))
     (set! &py-builtin-ImportWarning
           (let (($%cls_61 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_61
                       (py-make-builtin-class
                        (&& "ImportWarning")
                        (&& "__main__")
                        (list &py-builtin-Warning)))
                 $%cls_61))))
     (set! &py-builtin-PendingDeprecationWarning
           (let (($%cls_62 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_62
                       (py-make-builtin-class
                        (&& "PendingDeprecationWarning")
                        (&& "__main__")
                        (list &py-builtin-Warning)))
                 $%cls_62))))
     (set! &py-builtin-ResourceWarning
           (let (($%cls_63 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_63
                       (py-make-builtin-class
                        (&& "ResourceWarning")
                        (&& "__main__")
                        (list &py-builtin-Warning)))
                 $%cls_63))))
     (set! &py-builtin-RuntimeWarning
           (let (($%cls_64 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_64
                       (py-make-builtin-class
                        (&& "RuntimeWarning")
                        (&& "__main__")
                        (list &py-builtin-Warning)))
                 $%cls_64))))
     (set! &py-builtin-SyntaxWarning
           (let (($%cls_65 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_65
                       (py-make-builtin-class
                        (&& "SyntaxWarning")
                        (&& "__main__")
                        (list &py-builtin-Warning)))
                 $%cls_65))))
     (set! &py-builtin-UnicodeWarning
           (let (($%cls_66 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_66
                       (py-make-builtin-class
                        (&& "UnicodeWarning")
                        (&& "__main__")
                        (list &py-builtin-Warning)))
                 $%cls_66))))
     (set! &py-builtin-UserWarning
           (let (($%cls_67 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_67
                       (py-make-builtin-class
                        (&& "UserWarning")
                        (&& "__main__")
                        (list &py-builtin-Warning)))
                 $%cls_67))))
     (set! &py-builtin-BrokenPipeError
           (let (($%cls_68 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_68
                       (py-make-builtin-class
                        (&& "BrokenPipeError")
                        (&& "__main__")
                        (list &py-builtin-ConnectionError)))
                 $%cls_68))))
     (set! &py-builtin-ConnectionAbortedError
           (let (($%cls_69 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_69
                       (py-make-builtin-class
                        (&& "ConnectionAbortedError")
                        (&& "__main__")
                        (list &py-builtin-ConnectionError)))
                 $%cls_69))))
     (set! &py-builtin-ConnectionRefusedError
           (let (($%cls_70 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_70
                       (py-make-builtin-class
                        (&& "ConnectionRefusedError")
                        (&& "__main__")
                        (list &py-builtin-ConnectionError)))
                 $%cls_70))))
     (set! &py-builtin-ConnectionResetError
           (let (($%cls_71 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_71
                       (py-make-builtin-class
                        (&& "ConnectionResetError")
                        (&& "__main__")
                        (list &py-builtin-ConnectionError)))
                 $%cls_71))))
     (set! &py-builtin-TabError
           (let (($%cls_72 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_72
                       (py-make-builtin-class
                        (&& "TabError")
                        (&& "__main__")
                        (list &py-builtin-IndentationError)))
                 $%cls_72))))
     (set! &py-builtin-UnicodeDecodeError
           (let (($%cls_73 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_73
                       (py-make-builtin-class
                        (&& "UnicodeDecodeError")
                        (&& "__main__")
                        (list &py-builtin-UnicodeError)))
                 $%cls_73))))
     (set! &py-builtin-UnicodeEncodeError
           (let (($%cls_74 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_74
                       (py-make-builtin-class
                        (&& "UnicodeEncodeError")
                        (&& "__main__")
                        (list &py-builtin-UnicodeError)))
                 $%cls_74))))
     (set! &py-builtin-UnicodeTranslateError
           (let (($%cls_75 py-absent))
             (letrec* ()
               #f
               (begin
                 (set! $%cls_75
                       (py-make-builtin-class
                        (&& "UnicodeTranslateError")
                        (&& "__main__")
                        (list &py-builtin-UnicodeError)))
                 $%cls_75)))))
   (define (init name package __path__) builtins-mod)
   (define (init-builtin-module name package __path__)
     (py-init-module)
     (let ((caches (py-make-caches 755))
           (module (py-make-module name package __path__)))
       (begin)
       (py-module module caches)
       module))
   (py-end-module)))

