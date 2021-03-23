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
         &py-builtin-__merge_many
         &py-builtin-__merge
         &py-builtin-range
         &py-builtin-StopIteration
         &py-builtin-range_iterator
         &py-builtin-str
         &py-builtin-NotImplementedError
         &py-builtin-float
         &py-builtin-bool
         &py-builtin-ZeroDivisionError
         &py-builtin-ValueError
         &py-builtin-int
         &py-builtin-TypeError
         &py-builtin-convert_to_int)
 (import (gambit) (zipi rts))
 (begin
   (py-begin-module)
   (define procedure:&py-builtin-convert_to_int
     (lambda (obj-2)
       (letrec* ((trunc_conversion-312 #f)
                 (index_conversion-309 #f)
                 (int_conversion-304 #f))
         (begin
           (set! int_conversion-304 (py-maybe-to-int obj-2))
           (if (py-test (py-is int_conversion-304 py-absent))
               (begin
                 (set! index_conversion-309 (py-maybe-index obj-2))
                 (if (py-test (py-is index_conversion-309 py-absent))
                     (begin
                       (set! trunc_conversion-312 (py-maybe-trunc obj-2))
                       (if (py-test (py-is trunc_conversion-312 py-absent))
                           (py-throw
                            (py-call &py-builtin-TypeError
                                     (py-add (py-add (&& "int() argument must be a string, a bytes-like object or a number, not '")
                                                     (py-getattribute
                                                      (py-obj-cls obj-2)
                                                      (& "__name__")))
                                             (&& "'"))))
                           trunc_conversion-312))
                     index_conversion-309))
               int_conversion-304)))))
   (define procedure:&py-builtin-__merge
     (lambda (l1-200 l2-201)
       (letrec* ((output-1517 #f) (i-1515 #f) (j-1513 #f))
         (begin
           (&& "\n    Merge all items from two sorted list into one sorted list.\n    Time complexity: O(n) where n is the total number of elements\n    ")
           (letrec* ((%tmp0-202 (py-int-from-scheme 0)))
             (begin
               (set! j-1513
                     (or %tmp0-202
                         (py-throw-exception-with-message
                          py-builtin-UnboundLocalError
                          "local variable '%tmp0' referenced before assignment")))
               (set! i-1515
                     (or %tmp0-202
                         (py-throw-exception-with-message
                          py-builtin-UnboundLocalError
                          "local variable '%tmp0' referenced before assignment")))))
           (set! output-1517 (py-make-list))
           (let $%while_76 ()
             (when (and
                    (py-test (py-lt (or i-1515
                                        (py-throw-exception-with-message
                                         py-builtin-UnboundLocalError
                                         "local variable 'i' referenced before assignment"))
                                    (py-call (global-get
                                              %global
                                              (& "len")
                                              (vector-ref %caches 563))
                                             l1-200)))
                    (py-test (py-lt (or j-1513
                                        (py-throw-exception-with-message
                                         py-builtin-UnboundLocalError
                                         "local variable 'j' referenced before assignment"))
                                    (py-call (global-get
                                              %global
                                              (& "len")
                                              (vector-ref %caches 564))
                                             l2-201))))
               (if (py-test (py-le (py-getitem
                                    l1-200
                                    (or i-1515
                                        (py-throw-exception-with-message
                                         py-builtin-UnboundLocalError
                                         "local variable 'i' referenced before assignment")))
                                   (py-getitem
                                    l2-201
                                    (or j-1513
                                        (py-throw-exception-with-message
                                         py-builtin-UnboundLocalError
                                         "local variable 'j' referenced before assignment")))))
                   (begin
                     (py-call (py-getattribute output-1517 (& "append"))
                              (py-getitem
                               l1-200
                               (or i-1515
                                   (py-throw-exception-with-message
                                    py-builtin-UnboundLocalError
                                    "local variable 'i' referenced before assignment"))))
                     (set! i-1515
                           (py-iadd (or i-1515
                                        (py-throw-exception-with-message
                                         py-builtin-UnboundLocalError
                                         "local variable 'i' referenced before assignment"))
                                    (py-int-from-scheme 1))))
                   (begin
                     (py-call (py-getattribute output-1517 (& "append"))
                              (py-getitem
                               l2-201
                               (or j-1513
                                   (py-throw-exception-with-message
                                    py-builtin-UnboundLocalError
                                    "local variable 'j' referenced before assignment"))))
                     (set! j-1513
                           (py-iadd (or j-1513
                                        (py-throw-exception-with-message
                                         py-builtin-UnboundLocalError
                                         "local variable 'j' referenced before assignment"))
                                    (py-int-from-scheme 1)))))
               ($%while_76)))
           (py-call (py-getattribute output-1517 (& "extend"))
                    (py-add (py-getitem
                             l1-200
                             (py-slice-from-scheme
                              (or i-1515
                                  (py-throw-exception-with-message
                                   py-builtin-UnboundLocalError
                                   "local variable 'i' referenced before assignment"))
                              py-None
                              py-None))
                            (py-getitem
                             l2-201
                             (py-slice-from-scheme
                              (or j-1513
                                  (py-throw-exception-with-message
                                   py-builtin-UnboundLocalError
                                   "local variable 'j' referenced before assignment"))
                              py-None
                              py-None))))
           output-1517))))
   (define procedure:&py-builtin-__merge_many
     (lambda (lsts-203)
       (letrec* ((right-1527 #f) (left-1525 #f))
         (begin
           (&& "\n    Merge all items from k lists into one sorted list.\n    Time complexity: O(n log(k)) where n is the total number of elements and k the number of lists\n    ")
           (if (py-test (py-not lsts-203))
               (py-make-list)
               (if (py-test (py-eq (py-call (global-get
                                             %global
                                             (& "len")
                                             (vector-ref %caches 572))
                                            lsts-203)
                                   (py-int-from-scheme 1)))
                   (py-getitem
                    (py-getitem lsts-203 (py-int-from-scheme 0))
                    (py-slice-from-scheme py-None py-None py-None))
                   (if (py-test (py-eq (py-call (global-get
                                                 %global
                                                 (& "len")
                                                 (vector-ref %caches 573))
                                                lsts-203)
                                       (py-int-from-scheme 2)))
                       (procedure:&py-builtin-__merge
                        (py-getitem lsts-203 (py-int-from-scheme 0))
                        (py-getitem lsts-203 (py-int-from-scheme 1)))
                       (begin
                         (set! left-1525
                               (py-getitem
                                lsts-203
                                (py-slice-from-scheme
                                 (py-floordiv
                                  (py-call (global-get
                                            %global
                                            (& "len")
                                            (vector-ref %caches 575))
                                           lsts-203)
                                  (py-int-from-scheme 2))
                                 py-None
                                 py-None)))
                         (set! right-1527
                               (py-getitem
                                lsts-203
                                (py-slice-from-scheme
                                 py-None
                                 (py-floordiv
                                  (py-call (global-get
                                            %global
                                            (& "len")
                                            (vector-ref %caches 576))
                                           lsts-203)
                                  (py-int-from-scheme 2))
                                 py-None)))
                         (procedure:&py-builtin-__merge
                          (procedure:&py-builtin-__merge_many left-1525)
                          (procedure:&py-builtin-__merge_many
                           right-1527))))))))))
   (define procedure:&py-builtin-sorted
     (lambda (lst-204 key-205 reversed-206)
       (letrec* ((i-1532 #f) (sublsts-1530 #f))
         (begin
           (&& "\n    Timsort is an improved version of Merge Sort which splits the list into monotonic sub-lists before merging them\n    into a sorted list.\n    Worst case time complexity: O(n log(n))\n    Best cast time complexity:  O(n) when the list is almost sorted\n        where n is the number of elements in the list\n    ")
           (set! sublsts-1530 (py-make-list))
           (set! i-1532 (py-int-from-scheme 0))
           (let $%while_77 ()
             (when (py-test
                    (py-lt i-1532
                           (py-call (global-get
                                     %global
                                     (& "len")
                                     (vector-ref %caches 581))
                                    lst-204)))
               (begin
                 (py-call (py-getattribute sublsts-1530 (& "append"))
                          (py-make-list (py-getitem lst-204 i-1532)))
                 (set! i-1532
                       (py-iadd (or i-1532
                                    (py-throw-exception-with-message
                                     py-builtin-UnboundLocalError
                                     "local variable 'i' referenced before assignment"))
                                (py-int-from-scheme 1)))
                 (if (and (py-test (py-lt i-1532
                                          (py-call (global-get
                                                    %global
                                                    (& "len")
                                                    (vector-ref %caches 584))
                                                   lst-204)))
                          (py-test (py-ge (py-getitem lst-204 i-1532)
                                          (py-getitem
                                           lst-204
                                           (py-sub i-1532
                                                   (py-int-from-scheme 1))))))
                     (let $%while_78 ()
                       (when (and
                              (py-test (py-lt i-1532
                                              (py-call (global-get
                                                        %global
                                                        (& "len")
                                                        (vector-ref
                                                         %caches
                                                         585))
                                                       lst-204)))
                              (py-test (py-ge (py-getitem lst-204 i-1532)
                                              (py-getitem
                                               lst-204
                                               (py-sub i-1532
                                                       (py-int-from-scheme
                                                        1))))))
                         (begin
                           (py-call (py-getattribute
                                     (py-getitem
                                      sublsts-1530
                                      (py-neg (py-int-from-scheme 1)))
                                     (& "append"))
                                    (py-getitem lst-204 i-1532))
                           (set! i-1532
                                 (py-iadd (or i-1532
                                              (py-throw-exception-with-message
                                               py-builtin-UnboundLocalError
                                               "local variable 'i' referenced before assignment"))
                                          (py-int-from-scheme 1))))
                         ($%while_78)))
                     (if (py-test (py-lt i-1532
                                         (py-call (global-get
                                                   %global
                                                   (& "len")
                                                   (vector-ref %caches 589))
                                                  lst-204)))
                         (begin
                           (let $%while_79 ()
                             (when (and
                                    (py-test (py-lt i-1532
                                                    (py-call (global-get
                                                              %global
                                                              (& "len")
                                                              (vector-ref
                                                               %caches
                                                               590))
                                                             lst-204)))
                                    (py-test (py-lt (py-getitem lst-204 i-1532)
                                                    (py-getitem
                                                     lst-204
                                                     (py-sub i-1532
                                                             (py-int-from-scheme
                                                              1))))))
                               (begin
                                 (py-call (py-getattribute
                                           (py-getitem
                                            sublsts-1530
                                            (py-neg (py-int-from-scheme 1)))
                                           (& "append"))
                                          (py-getitem lst-204 i-1532))
                                 (set! i-1532
                                       (py-iadd (or i-1532
                                                    (py-throw-exception-with-message
                                                     py-builtin-UnboundLocalError
                                                     "local variable 'i' referenced before assignment"))
                                                (py-int-from-scheme 1))))
                               ($%while_79)))
                           (py-setitem
                            (or sublsts-1530
                                (py-throw-exception-with-message
                                 py-builtin-UnboundLocalError
                                 "local variable 'sublsts' referenced before assignment"))
                            (py-neg (py-int-from-scheme 1))
                            (py-getitem
                             (py-getitem
                              (or sublsts-1530
                                  (py-throw-exception-with-message
                                   py-builtin-UnboundLocalError
                                   "local variable 'sublsts' referenced before assignment"))
                              (py-neg (py-int-from-scheme 1)))
                             (py-slice-from-scheme
                              py-None
                              py-None
                              (py-neg (py-int-from-scheme 1))))))
                         #f)))
               ($%while_77)))
           (procedure:&py-builtin-__merge_many sublsts-1530)))))
   (declare (separate))
   (define %global #f)
   (define %caches #f)
   (define init:&py-builtin-convert_to_int '%uninit)
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
   (define &py-builtin-NotImplementedError #f)
   (define &py-builtin-float #f)
   (define &py-builtin-bool #f)
   (define &py-builtin-ZeroDivisionError #f)
   (define &py-builtin-ValueError #f)
   (define &py-builtin-int #f)
   (define &py-builtin-TypeError #f)
   (define &py-builtin-convert_to_int #f)
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
      (& "NotImplementedError")
      (lambda () &py-builtin-NotImplementedError)
      (lambda (v) (set! &py-builtin-NotImplementedError v)))
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
      (& "TypeError")
      (lambda () &py-builtin-TypeError)
      (lambda (v) (set! &py-builtin-TypeError v)))
     (let (($fun-obj
            (procedure->py-function
             procedure:&py-builtin-convert_to_int
             (make-signature args: (obj)))))
       (set! &py-builtin-convert_to_int $fun-obj)
       (set! init:&py-builtin-convert_to_int $fun-obj))
     (set! &py-builtin-int
           (let (($%cls_0 py-absent))
             (letrec* ((__lt__-414 #f)
                       (__le__-412 #f)
                       (__gt__-410 #f)
                       (__ge__-408 #f)
                       (__ne__-406 #f)
                       (__eq__-404 #f)
                       (__imod__-402 #f)
                       (__rmod__-400 #f)
                       (__mod__-398 #f)
                       (__itruediv__-396 #f)
                       (__rtruediv__-394 #f)
                       (__truediv__-392 #f)
                       (__ifloordiv__-390 #f)
                       (__rfloordiv__-388 #f)
                       (__floordiv__-386 #f)
                       (__invert__-384 #f)
                       (__neg__-382 #f)
                       (__pos__-380 #f)
                       (__irshift__-378 #f)
                       (__rrshift__-376 #f)
                       (__rshift__-374 #f)
                       (__ilshift__-372 #f)
                       (__rlshift__-370 #f)
                       (__lshift__-368 #f)
                       (__ixor__-366 #f)
                       (__rxor__-364 #f)
                       (__xor__-362 #f)
                       (__isub__-360 #f)
                       (__rsub__-358 #f)
                       (__sub__-356 #f)
                       (__ipow__-354 #f)
                       (__rpow__-352 #f)
                       (__pow__-350 #f)
                       (__imul__-348 #f)
                       (__rmul__-346 #f)
                       (__mul__-344 #f)
                       (__ior__-342 #f)
                       (__ror__-340 #f)
                       (__or__-338 #f)
                       (__iand__-336 #f)
                       (__rand__-334 #f)
                       (__and__-332 #f)
                       (__iadd__-330 #f)
                       (__radd__-328 #f)
                       (__add__-326 #f)
                       (__abs__-324 #f)
                       (__index__-322 #f)
                       (__bool__-320 #f)
                       (__new__-317 #f))
               (begin
                 (set! __new__-317
                       (procedure->py-function
                        (lambda (cls-3 val-4)
                          (letrec* ()
                            (if (py-test (py-is cls-3 &py-builtin-int))
                                (if (py-test (py-is val-4 py-absent))
                                    (py-int-from-scheme 0)
                                    (procedure:&py-builtin-convert_to_int
                                     val-4))
                                (if (and (py-isinstance?
                                          cls-3
                                          (global-get
                                           %global
                                           (& "type")
                                           (vector-ref %caches 6)))
                                         (py-test (py-call (global-get
                                                            %global
                                                            (& "issubclass")
                                                            (vector-ref
                                                             %caches
                                                             7))
                                                           cls-3
                                                           &py-builtin-int)))
                                    (if (py-test (py-is val-4 py-absent))
                                        (make-PyObjectInt
                                         py-int-hclass-of-instances
                                         '#()
                                         cls-3
                                         0)
                                        (make-PyObjectInt
                                         py-int-hclass-of-instances
                                         '#()
                                         cls-3
                                         (py-int-to-scheme
                                          (procedure:&py-builtin-convert_to_int
                                           val-4))))
                                    (py-throw
                                     (py-call &py-builtin-TypeError
                                              (&& "int.__new__ expected a subtype of 'int' as first argument")))))))
                        (make-signature
                         args:
                         (cls val)
                         defaults:
                         (vector py-absent))))
                 (set! __bool__-320
                       (procedure->py-function
                        (lambda (self-5)
                          (letrec* ()
                            (if (py-isinstance? self-5 &py-builtin-int)
                                (py-ne self-5 (py-int-from-scheme 0))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__bool__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-5)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __index__-322
                       (procedure->py-function
                        (lambda (self-6)
                          (letrec* ()
                            (if (py-isinstance? self-6 &py-builtin-int)
                                (py-int-from-scheme (py-int-to-scheme self-6))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__index__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-6)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __abs__-324
                       (procedure->py-function
                        (lambda (self-7)
                          (letrec* ()
                            (if (py-isinstance? self-7 &py-builtin-int)
                                (if (py-test (py-lt self-7
                                                    (py-int-from-scheme 0)))
                                    (py-int-from-scheme
                                     (pyneg (py-int-to-scheme self-7)))
                                    (py-int-from-scheme
                                     (py-int-to-scheme self-7)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__abs__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-7)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __add__-326
                       (procedure->py-function
                        (lambda (self-8 other-9)
                          (letrec* ()
                            (if (py-isinstance? self-8 &py-builtin-int)
                                (if (py-isinstance? other-9 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py+ (py-int-to-scheme self-8)
                                          (py-int-to-scheme other-9)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 23)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__add__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-8)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __radd__-328
                       (procedure->py-function
                        (lambda (self-10 other-11)
                          (letrec* ()
                            (if (py-isinstance? self-10 &py-builtin-int)
                                (if (py-isinstance? other-11 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py+ (py-int-to-scheme other-11)
                                          (py-int-to-scheme self-10)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 28)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__radd__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-10)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __iadd__-330
                       (procedure->py-function
                        (lambda (self-12 other-13)
                          (letrec* ()
                            (if (py-isinstance? self-12 &py-builtin-int)
                                (if (py-isinstance? other-13 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py+ (py-int-to-scheme self-12)
                                          (py-int-to-scheme other-13)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 33)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__iadd__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-12)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __and__-332
                       (procedure->py-function
                        (lambda (self-14 other-15)
                          (letrec* ()
                            (if (py-isinstance? self-14 &py-builtin-int)
                                (if (py-isinstance? other-15 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py& (py-int-to-scheme self-14)
                                          (py-int-to-scheme other-15)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 38)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__and__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-14)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rand__-334
                       (procedure->py-function
                        (lambda (self-16 other-17)
                          (letrec* ()
                            (if (py-isinstance? self-16 &py-builtin-int)
                                (if (py-isinstance? other-17 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py& (py-int-to-scheme other-17)
                                          (py-int-to-scheme self-16)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 43)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rand__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-16)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __iand__-336
                       (procedure->py-function
                        (lambda (self-18 other-19)
                          (letrec* ()
                            (if (py-isinstance? self-18 &py-builtin-int)
                                (if (py-isinstance? other-19 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py& (py-int-to-scheme self-18)
                                          (py-int-to-scheme other-19)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 48)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__iand__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-18)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __or__-338
                       (procedure->py-function
                        (lambda (self-20 other-21)
                          (letrec* ()
                            (if (py-isinstance? self-20 &py-builtin-int)
                                (if (py-isinstance? other-21 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py+b (py-int-to-scheme self-20)
                                           (py-int-to-scheme other-21)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 53)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__or__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-20)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ror__-340
                       (procedure->py-function
                        (lambda (self-22 other-23)
                          (letrec* ()
                            (if (py-isinstance? self-22 &py-builtin-int)
                                (if (py-isinstance? other-23 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py+b (py-int-to-scheme other-23)
                                           (py-int-to-scheme self-22)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 58)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ror__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-22)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ior__-342
                       (procedure->py-function
                        (lambda (self-24 other-25)
                          (letrec* ()
                            (if (py-isinstance? self-24 &py-builtin-int)
                                (if (py-isinstance? other-25 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py+b (py-int-to-scheme self-24)
                                           (py-int-to-scheme other-25)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 63)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ior__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-24)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __mul__-344
                       (procedure->py-function
                        (lambda (self-26 other-27)
                          (letrec* ()
                            (if (py-isinstance? self-26 &py-builtin-int)
                                (if (py-isinstance? other-27 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py* (py-int-to-scheme self-26)
                                          (py-int-to-scheme other-27)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 68)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__mul__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-26)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rmul__-346
                       (procedure->py-function
                        (lambda (self-28 other-29)
                          (letrec* ()
                            (if (py-isinstance? self-28 &py-builtin-int)
                                (if (py-isinstance? other-29 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py* (py-int-to-scheme other-29)
                                          (py-int-to-scheme self-28)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 73)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rmul__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-28)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __imul__-348
                       (procedure->py-function
                        (lambda (self-30 other-31)
                          (letrec* ()
                            (if (py-isinstance? self-30 &py-builtin-int)
                                (if (py-isinstance? other-31 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py* (py-int-to-scheme self-30)
                                          (py-int-to-scheme other-31)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 78)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__imul__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-30)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __pow__-350
                       (procedure->py-function
                        (lambda (self-32 other-33)
                          (letrec* ()
                            (if (py-isinstance? self-32 &py-builtin-int)
                                (if (py-isinstance? other-33 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py** (py-int-to-scheme self-32)
                                           (py-int-to-scheme other-33)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 83)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__pow__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-32)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rpow__-352
                       (procedure->py-function
                        (lambda (self-34 other-35)
                          (letrec* ()
                            (if (py-isinstance? self-34 &py-builtin-int)
                                (if (py-isinstance? other-35 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py** (py-int-to-scheme other-35)
                                           (py-int-to-scheme self-34)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 88)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rpow__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-34)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ipow__-354
                       (procedure->py-function
                        (lambda (self-36 other-37)
                          (letrec* ()
                            (if (py-isinstance? self-36 &py-builtin-int)
                                (if (py-isinstance? other-37 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py** (py-int-to-scheme self-36)
                                           (py-int-to-scheme other-37)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 93)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ipow__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-36)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __sub__-356
                       (procedure->py-function
                        (lambda (self-38 other-39)
                          (letrec* ()
                            (if (py-isinstance? self-38 &py-builtin-int)
                                (if (py-isinstance? other-39 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py- (py-int-to-scheme self-38)
                                          (py-int-to-scheme other-39)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 98)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__sub__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-38)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rsub__-358
                       (procedure->py-function
                        (lambda (self-40 other-41)
                          (letrec* ()
                            (if (py-isinstance? self-40 &py-builtin-int)
                                (if (py-isinstance? other-41 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py- (py-int-to-scheme other-41)
                                          (py-int-to-scheme self-40)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 103)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rsub__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-40)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __isub__-360
                       (procedure->py-function
                        (lambda (self-42 other-43)
                          (letrec* ()
                            (if (py-isinstance? self-42 &py-builtin-int)
                                (if (py-isinstance? other-43 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py- (py-int-to-scheme self-42)
                                          (py-int-to-scheme other-43)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 108)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__isub__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-42)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __xor__-362
                       (procedure->py-function
                        (lambda (self-44 other-45)
                          (letrec* ()
                            (if (py-isinstance? self-44 &py-builtin-int)
                                (if (py-isinstance? other-45 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py^ (py-int-to-scheme self-44)
                                          (py-int-to-scheme other-45)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 113)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__xor__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-44)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rxor__-364
                       (procedure->py-function
                        (lambda (self-46 other-47)
                          (letrec* ()
                            (if (py-isinstance? self-46 &py-builtin-int)
                                (if (py-isinstance? other-47 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py^ (py-int-to-scheme other-47)
                                          (py-int-to-scheme self-46)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 118)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rxor__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-46)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ixor__-366
                       (procedure->py-function
                        (lambda (self-48 other-49)
                          (letrec* ()
                            (if (py-isinstance? self-48 &py-builtin-int)
                                (if (py-isinstance? other-49 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py^ (py-int-to-scheme self-48)
                                          (py-int-to-scheme other-49)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 123)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ixor__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-48)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __lshift__-368
                       (procedure->py-function
                        (lambda (self-50 other-51)
                          (letrec* ()
                            (if (py-isinstance? self-50 &py-builtin-int)
                                (if (py-isinstance? other-51 &py-builtin-int)
                                    (if (py-test (py-ge other-51
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
                                     (vector-ref %caches 129)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__lshift__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-50)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rlshift__-370
                       (procedure->py-function
                        (lambda (self-52 other-53)
                          (letrec* ()
                            (if (py-isinstance? self-52 &py-builtin-int)
                                (if (py-isinstance? other-53 &py-builtin-int)
                                    (if (py-test (py-ge self-52
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
                                     (vector-ref %caches 135)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rlshift__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-52)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ilshift__-372
                       (procedure->py-function
                        (lambda (self-54 other-55)
                          (letrec* ()
                            (if (py-isinstance? self-54 &py-builtin-int)
                                (if (py-isinstance? other-55 &py-builtin-int)
                                    (if (py-test (py-ge other-55
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py<< (py-int-to-scheme self-54)
                                               (py-int-to-scheme other-55)))
                                        (py-throw
                                         (py-call &py-builtin-ValueError
                                                  (&& "negative shift count"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 141)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ilshift__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-54)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rshift__-374
                       (procedure->py-function
                        (lambda (self-56 other-57)
                          (letrec* ()
                            (if (py-isinstance? self-56 &py-builtin-int)
                                (if (py-isinstance? other-57 &py-builtin-int)
                                    (if (py-test (py-ge other-57
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
                                     (vector-ref %caches 147)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rshift__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-56)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rrshift__-376
                       (procedure->py-function
                        (lambda (self-58 other-59)
                          (letrec* ()
                            (if (py-isinstance? self-58 &py-builtin-int)
                                (if (py-isinstance? other-59 &py-builtin-int)
                                    (if (py-test (py-ge self-58
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
                                     (vector-ref %caches 153)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rrshift__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-58)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __irshift__-378
                       (procedure->py-function
                        (lambda (self-60 other-61)
                          (letrec* ()
                            (if (py-isinstance? self-60 &py-builtin-int)
                                (if (py-isinstance? other-61 &py-builtin-int)
                                    (if (py-test (py-ge other-61
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py>> (py-int-to-scheme self-60)
                                               (py-int-to-scheme other-61)))
                                        (py-throw
                                         (py-call &py-builtin-ValueError
                                                  (&& "negative shift count"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 159)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__irshift__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-60)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __pos__-380
                       (procedure->py-function
                        (lambda (self-62)
                          (letrec* ()
                            (if (py-isinstance? self-62 &py-builtin-int)
                                (py-int-from-scheme (py-int-to-scheme self-62))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__pos__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-62)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __neg__-382
                       (procedure->py-function
                        (lambda (self-63)
                          (letrec* ()
                            (if (py-isinstance? self-63 &py-builtin-int)
                                (py-int-from-scheme
                                 (pyneg (py-int-to-scheme self-63)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__neg__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-63)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __invert__-384
                       (procedure->py-function
                        (lambda (self-64)
                          (letrec* ()
                            (if (py-isinstance? self-64 &py-builtin-int)
                                (py-int-from-scheme
                                 (pyinvert (py-int-to-scheme self-64)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__invert__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-64)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __floordiv__-386
                       (procedure->py-function
                        (lambda (self-65 other-66)
                          (letrec* ()
                            (if (py-isinstance? self-65 &py-builtin-int)
                                (if (py-isinstance? other-66 &py-builtin-int)
                                    (if (py-test (py-ne other-66
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py// (py-int-to-scheme self-65)
                                               (py-int-to-scheme other-66)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "integer division by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 176)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__floordiv__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-65)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rfloordiv__-388
                       (procedure->py-function
                        (lambda (self-67 other-68)
                          (letrec* ()
                            (if (py-isinstance? self-67 &py-builtin-int)
                                (if (py-isinstance? other-68 &py-builtin-int)
                                    (if (py-test (py-ne self-67
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py// (py-int-to-scheme other-68)
                                               (py-int-to-scheme self-67)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "integer division by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 182)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rfloordiv__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-67)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ifloordiv__-390
                       (procedure->py-function
                        (lambda (self-69 other-70)
                          (letrec* ()
                            (if (py-isinstance? self-69 &py-builtin-int)
                                (if (py-isinstance? other-70 &py-builtin-int)
                                    (if (py-test (py-ne other-70
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py// (py-int-to-scheme self-69)
                                               (py-int-to-scheme other-70)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "integer division by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 188)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ifloordiv__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-69)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __truediv__-392
                       (procedure->py-function
                        (lambda (self-71 other-72)
                          (letrec* ()
                            (if (py-isinstance? self-71 &py-builtin-int)
                                (if (py-isinstance? other-72 &py-builtin-int)
                                    (if (py-test (py-ne other-72
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-float-from-scheme
                                         (py/ (py-int-to-scheme self-71)
                                              (py-int-to-scheme other-72)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "division by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 194)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__truediv__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-71)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rtruediv__-394
                       (procedure->py-function
                        (lambda (self-73 other-74)
                          (letrec* ()
                            (if (py-isinstance? self-73 &py-builtin-int)
                                (if (py-isinstance? other-74 &py-builtin-int)
                                    (if (py-test (py-ne self-73
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-float-from-scheme
                                         (py/ (py-int-to-scheme other-74)
                                              (py-int-to-scheme self-73)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "division by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 200)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rtruediv__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-73)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __itruediv__-396
                       (procedure->py-function
                        (lambda (self-75 other-76)
                          (letrec* ()
                            (if (py-isinstance? self-75 &py-builtin-int)
                                (if (py-isinstance? other-76 &py-builtin-int)
                                    (if (py-test (py-ne other-76
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-float-from-scheme
                                         (py/ (py-int-to-scheme self-75)
                                              (py-int-to-scheme other-76)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "division by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 206)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__itruediv__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-75)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __mod__-398
                       (procedure->py-function
                        (lambda (self-77 other-78)
                          (letrec* ()
                            (if (py-isinstance? self-77 &py-builtin-int)
                                (if (py-isinstance? other-78 &py-builtin-int)
                                    (if (py-test (py-ne other-78
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py% (py-int-to-scheme self-77)
                                              (py-int-to-scheme other-78)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "modulo by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 212)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__mod__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-77)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rmod__-400
                       (procedure->py-function
                        (lambda (self-79 other-80)
                          (letrec* ()
                            (if (py-isinstance? self-79 &py-builtin-int)
                                (if (py-isinstance? other-80 &py-builtin-int)
                                    (if (py-test (py-ne self-79
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py% (py-int-to-scheme other-80)
                                              (py-int-to-scheme self-79)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "modulo by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 218)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rmod__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-79)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __imod__-402
                       (procedure->py-function
                        (lambda (self-81 other-82)
                          (letrec* ()
                            (if (py-isinstance? self-81 &py-builtin-int)
                                (if (py-isinstance? other-82 &py-builtin-int)
                                    (if (py-test (py-ne other-82
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py% (py-int-to-scheme self-81)
                                              (py-int-to-scheme other-82)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "modulo by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 224)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__imod__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-81)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __eq__-404
                       (procedure->py-function
                        (lambda (self-83 other-84)
                          (letrec* ()
                            (if (py-isinstance? self-83 &py-builtin-int)
                                (if (py-isinstance? other-84 &py-builtin-int)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py== (py-int-to-scheme self-83)
                                            (py-int-to-scheme other-84))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 229)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__eq__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-83)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ne__-406
                       (procedure->py-function
                        (lambda (self-85 other-86)
                          (letrec* ()
                            (if (py-isinstance? self-85 &py-builtin-int)
                                (if (py-isinstance? other-86 &py-builtin-int)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py!= (py-int-to-scheme self-85)
                                            (py-int-to-scheme other-86))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 234)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ne__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-85)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ge__-408
                       (procedure->py-function
                        (lambda (self-87 other-88)
                          (letrec* ()
                            (if (py-isinstance? self-87 &py-builtin-int)
                                (if (py-isinstance? other-88 &py-builtin-int)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py>= (py-int-to-scheme self-87)
                                            (py-int-to-scheme other-88))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 239)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ge__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-87)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __gt__-410
                       (procedure->py-function
                        (lambda (self-89 other-90)
                          (letrec* ()
                            (if (py-isinstance? self-89 &py-builtin-int)
                                (if (py-isinstance? other-90 &py-builtin-int)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py> (py-int-to-scheme self-89)
                                           (py-int-to-scheme other-90))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 244)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__gt__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-89)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __le__-412
                       (procedure->py-function
                        (lambda (self-91 other-92)
                          (letrec* ()
                            (if (py-isinstance? self-91 &py-builtin-int)
                                (if (py-isinstance? other-92 &py-builtin-int)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py<= (py-int-to-scheme self-91)
                                            (py-int-to-scheme other-92))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 249)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__le__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-91)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __lt__-414
                       (procedure->py-function
                        (lambda (self-93 other-94)
                          (letrec* ()
                            (if (py-isinstance? self-93 &py-builtin-int)
                                (if (py-isinstance? other-94 &py-builtin-int)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py< (py-int-to-scheme self-93)
                                           (py-int-to-scheme other-94))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 254)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__lt__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-93)
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
                        __lt__-414
                        (& "__le__")
                        __le__-412
                        (& "__gt__")
                        __gt__-410
                        (& "__ge__")
                        __ge__-408
                        (& "__ne__")
                        __ne__-406
                        (& "__eq__")
                        __eq__-404
                        (& "__imod__")
                        __imod__-402
                        (& "__rmod__")
                        __rmod__-400
                        (& "__mod__")
                        __mod__-398
                        (& "__itruediv__")
                        __itruediv__-396
                        (& "__rtruediv__")
                        __rtruediv__-394
                        (& "__truediv__")
                        __truediv__-392
                        (& "__ifloordiv__")
                        __ifloordiv__-390
                        (& "__rfloordiv__")
                        __rfloordiv__-388
                        (& "__floordiv__")
                        __floordiv__-386
                        (& "__invert__")
                        __invert__-384
                        (& "__neg__")
                        __neg__-382
                        (& "__pos__")
                        __pos__-380
                        (& "__irshift__")
                        __irshift__-378
                        (& "__rrshift__")
                        __rrshift__-376
                        (& "__rshift__")
                        __rshift__-374
                        (& "__ilshift__")
                        __ilshift__-372
                        (& "__rlshift__")
                        __rlshift__-370
                        (& "__lshift__")
                        __lshift__-368
                        (& "__ixor__")
                        __ixor__-366
                        (& "__rxor__")
                        __rxor__-364
                        (& "__xor__")
                        __xor__-362
                        (& "__isub__")
                        __isub__-360
                        (& "__rsub__")
                        __rsub__-358
                        (& "__sub__")
                        __sub__-356
                        (& "__ipow__")
                        __ipow__-354
                        (& "__rpow__")
                        __rpow__-352
                        (& "__pow__")
                        __pow__-350
                        (& "__imul__")
                        __imul__-348
                        (& "__rmul__")
                        __rmul__-346
                        (& "__mul__")
                        __mul__-344
                        (& "__ior__")
                        __ior__-342
                        (& "__ror__")
                        __ror__-340
                        (& "__or__")
                        __or__-338
                        (& "__iand__")
                        __iand__-336
                        (& "__rand__")
                        __rand__-334
                        (& "__and__")
                        __and__-332
                        (& "__iadd__")
                        __iadd__-330
                        (& "__radd__")
                        __radd__-328
                        (& "__add__")
                        __add__-326
                        (& "__abs__")
                        __abs__-324
                        (& "__index__")
                        __index__-322
                        (& "__bool__")
                        __bool__-320
                        (& "__new__")
                        __new__-317))
                 $%cls_0))))
     (set! &py-builtin-bool
           (let (($%cls_1 py-absent))
             (letrec* ((__rxor__-875 #f)
                       (__xor__-873 #f)
                       (__ror__-871 #f)
                       (__or__-869 #f)
                       (__rand__-867 #f)
                       (__and__-865 #f)
                       (__repr__-863 #f)
                       (__new__-860 #f))
               (begin
                 (set! __new__-860
                       (procedure->py-function
                        (lambda (cls-95 val-96)
                          (letrec* ()
                            (if (py-test (py-is cls-95 &py-builtin-bool))
                                (if (py-test (py-is val-96 py-absent))
                                    py-False
                                    (if (py-test val-96) py-True py-False))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (&& "bool.__new__ expected a subtype of 'bool' as first argument"))))))
                        (make-signature
                         args:
                         (cls val)
                         defaults:
                         (vector py-absent))))
                 (set! __repr__-863
                       (procedure->py-function
                        (lambda (self-97)
                          (letrec* ()
                            (if (py-test (py-is self-97 py-True))
                                (&& "True")
                                (if (py-test (py-is self-97 py-False))
                                    (&& "False")
                                    (py-throw
                                     (py-call &py-builtin-TypeError
                                              (py-add (py-add (&& "descriptor '__repr__' requires a 'bool' object but received a '")
                                                              (py-getattribute
                                                               (py-obj-cls
                                                                self-97)
                                                               (& "__name__")))
                                                      (&& "'"))))))))
                        (make-signature args: (self))))
                 (set! __and__-865
                       (procedure->py-function
                        (lambda (self-98 other-99)
                          (letrec* ()
                            (if (py-test (py-is (py-obj-cls self-98)
                                                &py-builtin-bool))
                                (if (py-test (py-is (py-obj-cls other-99)
                                                    &py-builtin-bool))
                                    (if (py-test (py-is self-98 py-True))
                                        other-99
                                        py-False)
                                    (if (py-isinstance?
                                         other-99
                                         &py-builtin-int)
                                        (py-int-from-scheme
                                         (py& (py-int-to-scheme self-98)
                                              (py-int-to-scheme other-99)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 265))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__and__' requires a 'bool' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-98)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rand__-867
                       (procedure->py-function
                        (lambda (self-100 other-101)
                          (letrec* ()
                            (if (py-test (py-is (py-obj-cls self-100)
                                                &py-builtin-bool))
                                (if (py-test (py-is (py-obj-cls other-101)
                                                    &py-builtin-bool))
                                    (if (py-test (py-is self-100 py-True))
                                        other-101
                                        py-False)
                                    (if (py-isinstance?
                                         other-101
                                         &py-builtin-int)
                                        (py-int-from-scheme
                                         (py& (py-int-to-scheme other-101)
                                              (py-int-to-scheme self-100)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 271))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rand__' requires a 'bool' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-100)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __or__-869
                       (procedure->py-function
                        (lambda (self-102 other-103)
                          (letrec* ()
                            (if (py-test (py-is (py-obj-cls self-102)
                                                &py-builtin-bool))
                                (if (py-test (py-is (py-obj-cls other-103)
                                                    &py-builtin-bool))
                                    (if (py-test (py-is self-102 py-True))
                                        py-True
                                        other-103)
                                    (if (py-isinstance?
                                         other-103
                                         &py-builtin-int)
                                        (py-int-from-scheme
                                         (py+b (py-int-to-scheme self-102)
                                               (py-int-to-scheme other-103)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 277))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__or__' requires a 'bool' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-102)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ror__-871
                       (procedure->py-function
                        (lambda (self-104 other-105)
                          (letrec* ()
                            (if (py-test (py-is (py-obj-cls self-104)
                                                &py-builtin-bool))
                                (if (py-test (py-is (py-obj-cls other-105)
                                                    &py-builtin-bool))
                                    (if (py-test (py-is self-104 py-True))
                                        py-True
                                        other-105)
                                    (if (py-isinstance?
                                         other-105
                                         &py-builtin-int)
                                        (py-int-from-scheme
                                         (py+b (py-int-to-scheme other-105)
                                               (py-int-to-scheme self-104)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 283))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ror__' requires a 'bool' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-104)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __xor__-873
                       (procedure->py-function
                        (lambda (self-106 other-107)
                          (letrec* ()
                            (if (py-test (py-is (py-obj-cls self-106)
                                                &py-builtin-bool))
                                (if (py-test (py-is (py-obj-cls other-107)
                                                    &py-builtin-bool))
                                    (py-isnot self-106 other-107)
                                    (if (py-isinstance?
                                         other-107
                                         &py-builtin-int)
                                        (py-int-from-scheme
                                         (py^ (py-int-to-scheme self-106)
                                              (py-int-to-scheme other-107)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 289))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__xor__' requires a 'bool' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-106)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rxor__-875
                       (procedure->py-function
                        (lambda (self-108 other-109)
                          (letrec* ()
                            (if (py-test (py-is (py-obj-cls self-108)
                                                &py-builtin-bool))
                                (if (py-test (py-is (py-obj-cls other-109)
                                                    &py-builtin-bool))
                                    (py-isnot self-108 other-109)
                                    (if (py-isinstance?
                                         other-109
                                         &py-builtin-int)
                                        (py-int-from-scheme
                                         (py^ (py-int-to-scheme other-109)
                                              (py-int-to-scheme self-108)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 295))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rxor__' requires a 'bool' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-108)
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
                        __rxor__-875
                        (& "__xor__")
                        __xor__-873
                        (& "__ror__")
                        __ror__-871
                        (& "__or__")
                        __or__-869
                        (& "__rand__")
                        __rand__-867
                        (& "__and__")
                        __and__-865
                        (& "__repr__")
                        __repr__-863
                        (& "__new__")
                        __new__-860))
                 $%cls_1))))
     (set! &py-builtin-float
           (let (($%cls_2 py-absent))
             (letrec* ((__lt__-1006 #f)
                       (__le__-1004 #f)
                       (__gt__-1002 #f)
                       (__ge__-1000 #f)
                       (__ne__-998 #f)
                       (__eq__-996 #f)
                       (__imod__-994 #f)
                       (__rmod__-992 #f)
                       (__mod__-990 #f)
                       (__itruediv__-988 #f)
                       (__rtruediv__-986 #f)
                       (__truediv__-984 #f)
                       (__ifloordiv__-982 #f)
                       (__rfloordiv__-980 #f)
                       (__floordiv__-978 #f)
                       (__neg__-976 #f)
                       (__pos__-974 #f)
                       (__isub__-972 #f)
                       (__rsub__-970 #f)
                       (__sub__-968 #f)
                       (__ipow__-966 #f)
                       (__rpow__-964 #f)
                       (__pow__-962 #f)
                       (__imul__-960 #f)
                       (__rmul__-958 #f)
                       (__mul__-956 #f)
                       (__iadd__-954 #f)
                       (__radd__-952 #f)
                       (__add__-950 #f)
                       (__bool__-948 #f)
                       (__new__-945 #f))
               (begin
                 (set! __new__-945
                       (procedure->py-function
                        (lambda (cls-110 val-111)
                          (bind-exit
                           ($%return_73)
                           (letrec* ()
                             (if (py-test (py-is cls-110 &py-builtin-float))
                                 (begin
                                   (if (py-test (py-is val-111 py-absent))
                                       ($%return_73 (py-float-from-scheme 0.))
                                       #f)
                                   (if (py-isinstance?
                                        val-111
                                        &py-builtin-float)
                                       (py-float-from-scheme
                                        (py-float-to-scheme val-111))
                                       (py-throw
                                        &py-builtin-NotImplementedError)))
                                 (if (and (py-isinstance?
                                           cls-110
                                           (global-get
                                            %global
                                            (& "type")
                                            (vector-ref %caches 303)))
                                          (py-test (py-call (global-get
                                                             %global
                                                             (& "issubclass")
                                                             (vector-ref
                                                              %caches
                                                              304))
                                                            cls-110
                                                            &py-builtin-float)))
                                     (py-throw &py-builtin-NotImplementedError)
                                     (py-throw
                                      (py-call &py-builtin-TypeError
                                               (&& "float.__new__ expected a subtype of 'float' as first argument"))))))))
                        (make-signature
                         args:
                         (cls val)
                         defaults:
                         (vector py-absent))))
                 (set! __bool__-948
                       (procedure->py-function
                        (lambda (self-112)
                          (letrec* ()
                            (if (py-isinstance? self-112 &py-builtin-float)
                                (py-ne self-112 (py-float-from-scheme 0.))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__bool__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-112)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __add__-950
                       (procedure->py-function
                        (lambda (self-113 other-114)
                          (letrec* ()
                            (if (py-isinstance? self-113 &py-builtin-float)
                                (if (py-isinstance?
                                     other-114
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py+ (py-float-to-scheme self-113)
                                          (py-float-to-scheme other-114)))
                                    (if (py-isinstance?
                                         other-114
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py+ (py-float-to-scheme self-113)
                                              (py-int-to-scheme other-114)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 314))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__add__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-113)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __radd__-952
                       (procedure->py-function
                        (lambda (self-115 other-116)
                          (letrec* ()
                            (if (py-isinstance? self-115 &py-builtin-float)
                                (if (py-isinstance?
                                     other-116
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py+ (py-float-to-scheme other-116)
                                          (py-float-to-scheme self-115)))
                                    (if (py-isinstance?
                                         other-116
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py+ (py-int-to-scheme other-116)
                                              (py-float-to-scheme self-115)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 320))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__radd__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-115)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __iadd__-954
                       (procedure->py-function
                        (lambda (self-117 other-118)
                          (letrec* ()
                            (if (py-isinstance? self-117 &py-builtin-float)
                                (if (py-isinstance?
                                     other-118
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py+ (py-float-to-scheme self-117)
                                          (py-float-to-scheme other-118)))
                                    (if (py-isinstance?
                                         self-117
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py+ (py-float-to-scheme self-117)
                                              (py-int-to-scheme other-118)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 326))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__iadd__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-117)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __mul__-956
                       (procedure->py-function
                        (lambda (self-119 other-120)
                          (letrec* ()
                            (if (py-isinstance? self-119 &py-builtin-float)
                                (if (py-isinstance?
                                     other-120
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py* (py-float-to-scheme self-119)
                                          (py-float-to-scheme other-120)))
                                    (if (py-isinstance?
                                         other-120
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py* (py-float-to-scheme self-119)
                                              (py-int-to-scheme other-120)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 332))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__mul__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-119)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rmul__-958
                       (procedure->py-function
                        (lambda (self-121 other-122)
                          (letrec* ()
                            (if (py-isinstance? self-121 &py-builtin-float)
                                (if (py-isinstance?
                                     other-122
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py* (py-float-to-scheme other-122)
                                          (py-float-to-scheme self-121)))
                                    (if (py-isinstance?
                                         other-122
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py* (py-int-to-scheme other-122)
                                              (py-float-to-scheme self-121)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 338))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rmul__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-121)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __imul__-960
                       (procedure->py-function
                        (lambda (self-123 other-124)
                          (letrec* ()
                            (if (py-isinstance? self-123 &py-builtin-float)
                                (if (py-isinstance?
                                     other-124
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py* (py-float-to-scheme self-123)
                                          (py-float-to-scheme other-124)))
                                    (if (py-isinstance?
                                         self-123
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py* (py-float-to-scheme self-123)
                                              (py-int-to-scheme other-124)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 344))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__imul__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-123)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __pow__-962
                       (procedure->py-function
                        (lambda (self-125 other-126)
                          (letrec* ()
                            (if (py-isinstance? self-125 &py-builtin-float)
                                (if (py-isinstance?
                                     other-126
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py** (py-float-to-scheme self-125)
                                           (py-float-to-scheme other-126)))
                                    (if (py-isinstance?
                                         other-126
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py** (py-float-to-scheme self-125)
                                               (py-int-to-scheme other-126)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 350))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__pow__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-125)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rpow__-964
                       (procedure->py-function
                        (lambda (self-127 other-128)
                          (letrec* ()
                            (if (py-isinstance? self-127 &py-builtin-float)
                                (if (py-isinstance?
                                     other-128
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py** (py-float-to-scheme other-128)
                                           (py-float-to-scheme self-127)))
                                    (if (py-isinstance?
                                         other-128
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py** (py-int-to-scheme other-128)
                                               (py-float-to-scheme self-127)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 356))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rpow__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-127)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ipow__-966
                       (procedure->py-function
                        (lambda (self-129 other-130)
                          (letrec* ()
                            (if (py-isinstance? self-129 &py-builtin-float)
                                (if (py-isinstance?
                                     other-130
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py** (py-float-to-scheme self-129)
                                           (py-float-to-scheme other-130)))
                                    (if (py-isinstance?
                                         self-129
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py** (py-float-to-scheme self-129)
                                               (py-int-to-scheme other-130)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 362))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ipow__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-129)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __sub__-968
                       (procedure->py-function
                        (lambda (self-131 other-132)
                          (letrec* ()
                            (if (py-isinstance? self-131 &py-builtin-float)
                                (if (py-isinstance?
                                     other-132
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py- (py-float-to-scheme self-131)
                                          (py-float-to-scheme other-132)))
                                    (if (py-isinstance?
                                         other-132
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py- (py-float-to-scheme self-131)
                                              (py-int-to-scheme other-132)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 368))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__sub__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-131)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rsub__-970
                       (procedure->py-function
                        (lambda (self-133 other-134)
                          (letrec* ()
                            (if (py-isinstance? self-133 &py-builtin-float)
                                (if (py-isinstance?
                                     other-134
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py- (py-float-to-scheme other-134)
                                          (py-float-to-scheme self-133)))
                                    (if (py-isinstance?
                                         other-134
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py- (py-int-to-scheme other-134)
                                              (py-float-to-scheme self-133)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 374))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rsub__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-133)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __isub__-972
                       (procedure->py-function
                        (lambda (self-135 other-136)
                          (letrec* ()
                            (if (py-isinstance? self-135 &py-builtin-float)
                                (if (py-isinstance?
                                     other-136
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py- (py-float-to-scheme self-135)
                                          (py-float-to-scheme other-136)))
                                    (if (py-isinstance?
                                         self-135
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py- (py-float-to-scheme self-135)
                                              (py-int-to-scheme other-136)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 380))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__isub__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-135)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __pos__-974
                       (procedure->py-function
                        (lambda (self-137)
                          (letrec* ()
                            (if (py-isinstance? self-137 &py-builtin-float)
                                self-137
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__pos__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-137)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __neg__-976
                       (procedure->py-function
                        (lambda (self-138)
                          (letrec* ()
                            (if (py-isinstance? self-138 &py-builtin-float)
                                (py-float-from-scheme
                                 (pyneg (py-float-to-scheme self-138)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__neg__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-138)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __floordiv__-978
                       (procedure->py-function
                        (lambda (self-139 other-140)
                          (letrec* ()
                            (if (py-isinstance? self-139 &py-builtin-float)
                                (if (py-isinstance?
                                     other-140
                                     &py-builtin-float)
                                    (if (py-test (py-ne other-140
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py// (py-float-to-scheme self-139)
                                               (py-float-to-scheme other-140)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float division by zero"))))
                                    (if (py-isinstance?
                                         other-140
                                         &py-builtin-int)
                                        (if (py-test (py-ne other-140
                                                            (py-int-from-scheme
                                                             0)))
                                            (py-float-from-scheme
                                             (py// (py-float-to-scheme
                                                    self-139)
                                                   (py-int-to-scheme
                                                    other-140)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float division by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 395))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__floordiv__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-139)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rfloordiv__-980
                       (procedure->py-function
                        (lambda (self-141 other-142)
                          (letrec* ()
                            (if (py-isinstance? self-141 &py-builtin-float)
                                (if (py-isinstance?
                                     other-142
                                     &py-builtin-float)
                                    (if (py-test (py-ne self-141
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py// (py-float-to-scheme other-142)
                                               (py-float-to-scheme self-141)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float division by zero"))))
                                    (if (py-isinstance?
                                         other-142
                                         &py-builtin-int)
                                        (if (py-test (py-ne self-141
                                                            (py-float-from-scheme
                                                             0.)))
                                            (py-float-from-scheme
                                             (py// (py-int-to-scheme other-142)
                                                   (py-float-to-scheme
                                                    self-141)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float division by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 403))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rfloordiv__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-141)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ifloordiv__-982
                       (procedure->py-function
                        (lambda (self-143 other-144)
                          (letrec* ()
                            (if (py-isinstance? self-143 &py-builtin-float)
                                (if (py-isinstance?
                                     other-144
                                     &py-builtin-float)
                                    (if (py-test (py-ne other-144
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py// (py-float-to-scheme self-143)
                                               (py-float-to-scheme other-144)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float division by zero"))))
                                    (if (py-isinstance?
                                         other-144
                                         &py-builtin-int)
                                        (if (py-test (py-ne other-144
                                                            (py-int-from-scheme
                                                             0)))
                                            (py-float-from-scheme
                                             (py// (py-float-to-scheme
                                                    self-143)
                                                   (py-int-to-scheme
                                                    other-144)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float division by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 411))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ifloordiv__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-143)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __truediv__-984
                       (procedure->py-function
                        (lambda (self-145 other-146)
                          (letrec* ()
                            (if (py-isinstance? self-145 &py-builtin-float)
                                (if (py-isinstance?
                                     other-146
                                     &py-builtin-float)
                                    (if (py-test (py-ne other-146
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py/ (py-float-to-scheme self-145)
                                              (py-float-to-scheme other-146)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float division by zero"))))
                                    (if (py-isinstance?
                                         other-146
                                         &py-builtin-int)
                                        (if (py-test (py-ne other-146
                                                            (py-int-from-scheme
                                                             0)))
                                            (py-float-from-scheme
                                             (py/ (py-float-to-scheme self-145)
                                                  (py-int-to-scheme
                                                   other-146)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float division by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 419))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__truediv__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-145)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rtruediv__-986
                       (procedure->py-function
                        (lambda (self-147 other-148)
                          (letrec* ()
                            (if (py-isinstance? self-147 &py-builtin-float)
                                (if (py-isinstance?
                                     other-148
                                     &py-builtin-float)
                                    (if (py-test (py-ne self-147
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py/ (py-float-to-scheme other-148)
                                              (py-float-to-scheme self-147)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float division by zero"))))
                                    (if (py-isinstance?
                                         other-148
                                         &py-builtin-int)
                                        (if (py-test (py-ne self-147
                                                            (py-float-from-scheme
                                                             0.)))
                                            (py-float-from-scheme
                                             (py/ (py-int-to-scheme other-148)
                                                  (py-float-to-scheme
                                                   self-147)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float division by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 427))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rtruediv__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-147)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __itruediv__-988
                       (procedure->py-function
                        (lambda (self-149 other-150)
                          (letrec* ()
                            (if (py-isinstance? self-149 &py-builtin-float)
                                (if (py-isinstance?
                                     other-150
                                     &py-builtin-float)
                                    (if (py-test (py-ne other-150
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py/ (py-float-to-scheme self-149)
                                              (py-float-to-scheme other-150)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float division by zero"))))
                                    (if (py-isinstance?
                                         other-150
                                         &py-builtin-int)
                                        (if (py-test (py-ne other-150
                                                            (py-int-from-scheme
                                                             0)))
                                            (py-float-from-scheme
                                             (py/ (py-float-to-scheme self-149)
                                                  (py-int-to-scheme
                                                   other-150)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float division by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 435))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__itruediv__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-149)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __mod__-990
                       (procedure->py-function
                        (lambda (self-151 other-152)
                          (letrec* ()
                            (if (py-isinstance? self-151 &py-builtin-float)
                                (if (py-isinstance?
                                     other-152
                                     &py-builtin-float)
                                    (if (py-test (py-ne other-152
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py% (py-float-to-scheme self-151)
                                              (py-float-to-scheme other-152)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float modulo by zero"))))
                                    (if (py-isinstance?
                                         other-152
                                         &py-builtin-int)
                                        (if (py-test (py-ne other-152
                                                            (py-int-from-scheme
                                                             0)))
                                            (py-float-from-scheme
                                             (py% (py-float-to-scheme self-151)
                                                  (py-int-to-scheme
                                                   other-152)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float modulo by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 443))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__mod__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-151)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rmod__-992
                       (procedure->py-function
                        (lambda (self-153 other-154)
                          (letrec* ()
                            (if (py-isinstance? self-153 &py-builtin-float)
                                (if (py-isinstance?
                                     other-154
                                     &py-builtin-float)
                                    (if (py-test (py-ne self-153
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py% (py-float-to-scheme other-154)
                                              (py-float-to-scheme self-153)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float modulo by zero"))))
                                    (if (py-isinstance?
                                         other-154
                                         &py-builtin-int)
                                        (if (py-test (py-ne self-153
                                                            (py-float-from-scheme
                                                             0.)))
                                            (py-float-from-scheme
                                             (py% (py-int-to-scheme other-154)
                                                  (py-float-to-scheme
                                                   self-153)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float modulo by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 451))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rmod__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-153)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __imod__-994
                       (procedure->py-function
                        (lambda (self-155 other-156)
                          (letrec* ()
                            (if (py-isinstance? self-155 &py-builtin-float)
                                (if (py-isinstance?
                                     other-156
                                     &py-builtin-float)
                                    (if (py-test (py-ne other-156
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py% (py-float-to-scheme self-155)
                                              (py-float-to-scheme other-156)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float modulo by zero"))))
                                    (if (py-isinstance?
                                         other-156
                                         &py-builtin-int)
                                        (if (py-test (py-ne other-156
                                                            (py-int-from-scheme
                                                             0)))
                                            (py-float-from-scheme
                                             (py% (py-float-to-scheme self-155)
                                                  (py-int-to-scheme
                                                   other-156)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float modulo by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 459))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__imod__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-155)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __eq__-996
                       (procedure->py-function
                        (lambda (self-157 other-158)
                          (letrec* ()
                            (if (py-isinstance? self-157 &py-builtin-float)
                                (if (py-isinstance?
                                     other-158
                                     &py-builtin-float)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py== (py-float-to-scheme self-157)
                                            (py-float-to-scheme other-158))))
                                    (if (py-isinstance?
                                         other-158
                                         &py-builtin-int)
                                        (py-bool-from-scheme-bool
                                         (py-test-from-scheme
                                          (py== (py-float-to-scheme self-157)
                                                (py-int-to-scheme other-158))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 465))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__eq__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-157)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ne__-998
                       (procedure->py-function
                        (lambda (self-159 other-160)
                          (letrec* ()
                            (if (py-isinstance? self-159 &py-builtin-float)
                                (if (py-isinstance?
                                     other-160
                                     &py-builtin-float)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py!= (py-float-to-scheme self-159)
                                            (py-float-to-scheme other-160))))
                                    (if (py-isinstance?
                                         other-160
                                         &py-builtin-int)
                                        (py-bool-from-scheme-bool
                                         (py-test-from-scheme
                                          (py!= (py-float-to-scheme self-159)
                                                (py-int-to-scheme other-160))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 471))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ne__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-159)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ge__-1000
                       (procedure->py-function
                        (lambda (self-161 other-162)
                          (letrec* ()
                            (if (py-isinstance? self-161 &py-builtin-float)
                                (if (py-isinstance?
                                     other-162
                                     &py-builtin-float)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py>= (py-float-to-scheme self-161)
                                            (py-float-to-scheme other-162))))
                                    (if (py-isinstance?
                                         other-162
                                         &py-builtin-int)
                                        (py-bool-from-scheme-bool
                                         (py-test-from-scheme
                                          (py>= (py-float-to-scheme self-161)
                                                (py-int-to-scheme other-162))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 477))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ge__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-161)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __gt__-1002
                       (procedure->py-function
                        (lambda (self-163 other-164)
                          (letrec* ()
                            (if (py-isinstance? self-163 &py-builtin-float)
                                (if (py-isinstance?
                                     other-164
                                     &py-builtin-float)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py> (py-float-to-scheme self-163)
                                           (py-float-to-scheme other-164))))
                                    (if (py-isinstance?
                                         other-164
                                         &py-builtin-int)
                                        (py-bool-from-scheme-bool
                                         (py-test-from-scheme
                                          (py> (py-float-to-scheme self-163)
                                               (py-int-to-scheme other-164))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 483))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__gt__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-163)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __le__-1004
                       (procedure->py-function
                        (lambda (self-165 other-166)
                          (letrec* ()
                            (if (py-isinstance? self-165 &py-builtin-float)
                                (if (py-isinstance?
                                     other-166
                                     &py-builtin-float)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py<= (py-float-to-scheme self-165)
                                            (py-float-to-scheme other-166))))
                                    (if (py-isinstance?
                                         other-166
                                         &py-builtin-int)
                                        (py-bool-from-scheme-bool
                                         (py-test-from-scheme
                                          (py<= (py-float-to-scheme self-165)
                                                (py-int-to-scheme other-166))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 489))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__le__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-165)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __lt__-1006
                       (procedure->py-function
                        (lambda (self-167 other-168)
                          (letrec* ()
                            (if (py-isinstance? self-167 &py-builtin-float)
                                (if (py-isinstance?
                                     other-168
                                     &py-builtin-float)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py< (py-float-to-scheme self-167)
                                           (py-float-to-scheme other-168))))
                                    (if (py-isinstance?
                                         other-168
                                         &py-builtin-int)
                                        (py-bool-from-scheme-bool
                                         (py-test-from-scheme
                                          (py< (py-float-to-scheme self-167)
                                               (py-int-to-scheme other-168))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 495))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__lt__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-167)
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
                        __lt__-1006
                        (& "__le__")
                        __le__-1004
                        (& "__gt__")
                        __gt__-1002
                        (& "__ge__")
                        __ge__-1000
                        (& "__ne__")
                        __ne__-998
                        (& "__eq__")
                        __eq__-996
                        (& "__imod__")
                        __imod__-994
                        (& "__rmod__")
                        __rmod__-992
                        (& "__mod__")
                        __mod__-990
                        (& "__itruediv__")
                        __itruediv__-988
                        (& "__rtruediv__")
                        __rtruediv__-986
                        (& "__truediv__")
                        __truediv__-984
                        (& "__ifloordiv__")
                        __ifloordiv__-982
                        (& "__rfloordiv__")
                        __rfloordiv__-980
                        (& "__floordiv__")
                        __floordiv__-978
                        (& "__neg__")
                        __neg__-976
                        (& "__pos__")
                        __pos__-974
                        (& "__isub__")
                        __isub__-972
                        (& "__rsub__")
                        __rsub__-970
                        (& "__sub__")
                        __sub__-968
                        (& "__ipow__")
                        __ipow__-966
                        (& "__rpow__")
                        __rpow__-964
                        (& "__pow__")
                        __pow__-962
                        (& "__imul__")
                        __imul__-960
                        (& "__rmul__")
                        __rmul__-958
                        (& "__mul__")
                        __mul__-956
                        (& "__iadd__")
                        __iadd__-954
                        (& "__radd__")
                        __radd__-952
                        (& "__add__")
                        __add__-950
                        (& "__bool__")
                        __bool__-948
                        (& "__new__")
                        __new__-945))
                 $%cls_2))))
     (set! &py-builtin-str
           (let (($%cls_3 py-absent))
             (letrec* ((__lt__-1360 #f)
                       (__le__-1358 #f)
                       (__gt__-1356 #f)
                       (__ge__-1354 #f)
                       (__ne__-1352 #f)
                       (__eq__-1350 #f)
                       (__rmul__-1348 #f)
                       (__mul__-1346 #f)
                       (__add__-1344 #f)
                       (__len__-1342 #f))
               (begin
                 (set! __len__-1342
                       (procedure->py-function
                        (lambda (self-169)
                          (letrec* ()
                            (if (py-isinstance? self-169 &py-builtin-str)
                                (py-int-from-scheme
                                 (py-str-len-to-scheme self-169))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__len__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-169)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __add__-1344
                       (procedure->py-function
                        (lambda (self-170 other-171)
                          (letrec* ()
                            (if (py-isinstance? self-170 &py-builtin-str)
                                (if (py-isinstance? other-171 &py-builtin-str)
                                    (py-str-from-scheme
                                     (py+ (py-str-to-scheme self-170)
                                          (py-str-to-scheme other-171)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 504)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__add__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-170)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __mul__-1346
                       (procedure->py-function
                        (lambda (self-172 other-173)
                          (letrec* ()
                            (if (py-isinstance? self-172 &py-builtin-str)
                                (if (py-isinstance? other-173 &py-builtin-int)
                                    (py-str-from-scheme
                                     (py* (py-str-to-scheme self-172)
                                          (py-int-to-scheme other-173)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 509)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__mul__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-172)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rmul__-1348
                       (procedure->py-function
                        (lambda (self-174 other-175)
                          (letrec* ()
                            (if (py-isinstance? self-174 &py-builtin-str)
                                (if (py-isinstance? other-175 &py-builtin-int)
                                    (py-str-from-scheme
                                     (py* (py-str-to-scheme self-174)
                                          (py-int-to-scheme other-175)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 514)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rmul__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-174)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __eq__-1350
                       (procedure->py-function
                        (lambda (self-176 other-177)
                          (letrec* ()
                            (if (py-isinstance? self-176 &py-builtin-str)
                                (if (py-isinstance? other-177 &py-builtin-str)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py== (py-str-to-scheme self-176)
                                            (py-str-to-scheme other-177))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 519)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__eq__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-176)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ne__-1352
                       (procedure->py-function
                        (lambda (self-178 other-179)
                          (letrec* ()
                            (if (py-isinstance? self-178 &py-builtin-str)
                                (if (py-isinstance? other-179 &py-builtin-str)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py!= (py-str-to-scheme self-178)
                                            (py-str-to-scheme other-179))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 524)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ne__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-178)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ge__-1354
                       (procedure->py-function
                        (lambda (self-180 other-181)
                          (letrec* ()
                            (if (py-isinstance? self-180 &py-builtin-str)
                                (if (py-isinstance? other-181 &py-builtin-str)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py>= (py-str-to-scheme self-180)
                                            (py-str-to-scheme other-181))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 529)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ge__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-180)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __gt__-1356
                       (procedure->py-function
                        (lambda (self-182 other-183)
                          (letrec* ()
                            (if (py-isinstance? self-182 &py-builtin-str)
                                (if (py-isinstance? other-183 &py-builtin-str)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py> (py-str-to-scheme self-182)
                                           (py-str-to-scheme other-183))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 534)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__gt__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-182)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __le__-1358
                       (procedure->py-function
                        (lambda (self-184 other-185)
                          (letrec* ()
                            (if (py-isinstance? self-184 &py-builtin-str)
                                (if (py-isinstance? other-185 &py-builtin-str)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py<= (py-str-to-scheme self-184)
                                            (py-str-to-scheme other-185))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 539)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__le__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-184)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __lt__-1360
                       (procedure->py-function
                        (lambda (self-186 other-187)
                          (letrec* ()
                            (if (py-isinstance? self-186 &py-builtin-str)
                                (if (py-isinstance? other-187 &py-builtin-str)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py< (py-str-to-scheme self-186)
                                           (py-str-to-scheme other-187))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 544)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__lt__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-186)
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
                        __lt__-1360
                        (& "__le__")
                        __le__-1358
                        (& "__gt__")
                        __gt__-1356
                        (& "__ge__")
                        __ge__-1354
                        (& "__ne__")
                        __ne__-1352
                        (& "__eq__")
                        __eq__-1350
                        (& "__rmul__")
                        __rmul__-1348
                        (& "__mul__")
                        __mul__-1346
                        (& "__add__")
                        __add__-1344
                        (& "__len__")
                        __len__-1342))
                 $%cls_3))))
     (set! &py-builtin-range_iterator
           (let (($%cls_4 py-absent))
             (letrec* ((__next__-1458 #f) (__iter__-1456 #f) (__new__-1454 #f))
               (begin
                 (set! __new__-1454
                       (procedure->py-function
                        (lambda (args-188)
                          (letrec* ()
                            (py-throw
                             (py-call &py-builtin-ValueError
                                      (&& "cannot create 'range_iterator' instances")))))
                        (make-signature vararg: args)))
                 (set! __iter__-1456
                       (procedure->py-function
                        (lambda (self-189) (letrec* () self-189))
                        (make-signature posonlyargs: (self))))
                 (set! __next__-1458
                       (procedure->py-function
                        (lambda (self-190)
                          (bind-exit
                           ($%return_74)
                           (letrec* ((step-1465 #f)
                                     (stop-1463 #f)
                                     (start-1460 #f))
                             (begin
                               (set! start-1460
                                     (PyObjectRangeIterator-start self-190))
                               (set! stop-1463
                                     (PyObjectRangeIterator-stop self-190))
                               (set! step-1465
                                     (PyObjectRangeIterator-step self-190))
                               (if (py-test (py-lt step-1465
                                                   (py-int-from-scheme 0)))
                                   (if (py-test (py-gt start-1460 stop-1463))
                                       (begin
                                         (PyObjectRangeIterator-start-set!
                                          self-190
                                          (py-add start-1460 step-1465))
                                         ($%return_74 start-1460))
                                       #f)
                                   (if (py-test (py-lt start-1460 stop-1463))
                                       (begin
                                         (PyObjectRangeIterator-start-set!
                                          self-190
                                          (py-add start-1460 step-1465))
                                         ($%return_74 start-1460))
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
                        __next__-1458
                        (& "__iter__")
                        __iter__-1456
                        (& "__new__")
                        __new__-1454))
                 $%cls_4))))
     (set! &py-builtin-range
           (let (($%cls_5 py-absent))
             (letrec* ((__repr__-1479 #f)
                       (__iter__-1477 #f)
                       (__contains__-1475 #f)
                       (__len__-1473 #f)
                       (__new__-1470 #f))
               (begin
                 (set! __new__-1470
                       (procedure->py-function
                        (lambda (cls-191 arg1-192 arg2-193 arg3-194)
                          (letrec* ()
                            (if (py-test (py-is cls-191 &py-builtin-range))
                                (if (py-test (py-isnot arg3-194 py-absent))
                                    (make-PyObjectRange
                                     py-range-hclass-of-instances
                                     '#()
                                     py-builtin-range
                                     arg1-192
                                     arg2-193
                                     arg3-194)
                                    (if (py-test (py-isnot arg2-193 py-absent))
                                        (make-PyObjectRange
                                         py-range-hclass-of-instances
                                         '#()
                                         py-builtin-range
                                         arg1-192
                                         arg2-193
                                         (py-int-from-scheme 1))
                                        (make-PyObjectRange
                                         py-range-hclass-of-instances
                                         '#()
                                         py-builtin-range
                                         (py-int-from-scheme 0)
                                         arg1-192
                                         (py-int-from-scheme 1))))
                                (if (and (py-isinstance?
                                          cls-191
                                          (global-get
                                           %global
                                           (& "type")
                                           (vector-ref %caches 552)))
                                         (py-test (py-call (global-get
                                                            %global
                                                            (& "issubclass")
                                                            (vector-ref
                                                             %caches
                                                             553))
                                                           cls-191
                                                           &py-builtin-range)))
                                    (py-throw &py-builtin-NotImplementedError)
                                    (py-throw
                                     (py-call &py-builtin-TypeError
                                              (&& "range.__new__ expected a subtype of 'range' as first argument")))))))
                        (make-signature
                         posonlyargs:
                         (cls arg1 arg2 arg3)
                         defaults:
                         (vector py-absent py-absent))))
                 (set! __len__-1473
                       (procedure->py-function
                        (lambda (self-195)
                          (letrec* ()
                            (py-floordiv
                             (py-sub (PyObjectRange-stop self-195)
                                     (PyObjectRange-start self-195))
                             (PyObjectRange-step self-195))))
                        (make-signature posonlyargs: (self))))
                 (set! __contains__-1475
                       (procedure->py-function
                        (lambda (self-196 item-197)
                          (bind-exit
                           ($%return_75)
                           (letrec* ((step-1497 #f)
                                     (stop-1495 #f)
                                     (start-1492 #f))
                             (begin
                               (set! start-1492 (PyObjectRange-start self-196))
                               (set! stop-1495 (PyObjectRange-stop self-196))
                               (set! step-1497 (PyObjectRange-step self-196))
                               (if (py-test (py-lt step-1497
                                                   (py-int-from-scheme 0)))
                                   (if (or (py-test (py-ge stop-1495 item-197))
                                           (py-test (py-gt item-197
                                                           start-1492)))
                                       ($%return_75 py-False)
                                       #f)
                                   (if (or (py-test (py-gt start-1492
                                                           item-197))
                                           (py-test (py-ge item-197
                                                           stop-1495)))
                                       ($%return_75 py-False)
                                       #f))
                               (py-eq (py-mod (py-sub item-197 start-1492)
                                              step-1497)
                                      (py-int-from-scheme 0))))))
                        (make-signature posonlyargs: (self item))))
                 (set! __iter__-1477
                       (procedure->py-function
                        (lambda (self-198)
                          (letrec* ()
                            (make-PyObjectRangeIterator
                             py-range_iterator-hclass-of-instances
                             '#()
                             py-builtin-range_iterator
                             (PyObjectRange-start self-198)
                             (PyObjectRange-stop self-198)
                             (PyObjectRange-step self-198))))
                        (make-signature posonlyargs: (self))))
                 (set! __repr__-1479
                       (procedure->py-function
                        (lambda (self-199)
                          (letrec* ((step-1486 #f)
                                    (stop-1484 #f)
                                    (start-1481 #f))
                            (begin
                              (set! start-1481 (PyObjectRange-start self-199))
                              (set! stop-1484 (PyObjectRange-stop self-199))
                              (set! step-1486 (PyObjectRange-step self-199))
                              (if (py-test (py-eq step-1486
                                                  (py-int-from-scheme 1)))
                                  (py-add (py-add (py-add (py-add (&& "range(")
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                          (py-call &py-builtin-str start-1481))
                  (&& ", "))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                  (py-call &py-builtin-str
                                                           stop-1484))
                                          (&& ")"))
                                  (py-add (py-add (py-add (py-add (py-add (py-add (&& "range(")
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                                          (py-call &py-builtin-str start-1481))
                                  (&& ", "))
                          (py-call &py-builtin-str stop-1484))
                  (&& ", "))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                  (py-call &py-builtin-str
                                                           step-1486))
                                          (&& ")"))))))
                        (make-signature args: (self)))))
               (begin
                 (set! $%cls_5
                       (py-make-builtin-class
                        (&& "range")
                        (&& "__main__")
                        (list)
                        (& "__repr__")
                        __repr__-1479
                        (& "__iter__")
                        __iter__-1477
                        (& "__contains__")
                        __contains__-1475
                        (& "__len__")
                        __len__-1473
                        (& "__new__")
                        __new__-1470))
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
             (letrec* ((__str__-1539 #f) (__init__-1537 #f))
               (begin
                 (set! __init__-1537
                       (procedure->py-function
                        (lambda (self-207 args-208)
                          (letrec* ()
                            (begin
                              (py-setattribute
                               (or self-207
                                   (py-throw-exception-with-message
                                    py-builtin-UnboundLocalError
                                    "local variable 'self' referenced before assignment"))
                               (& "args")
                               (or args-208
                                   (py-throw-exception-with-message
                                    py-builtin-UnboundLocalError
                                    "local variable 'args' referenced before assignment")))
                              py-None)))
                        (make-signature args: (self) vararg: args)))
                 (set! __str__-1539
                       (procedure->py-function
                        (lambda (self-209)
                          (letrec* ((args_len-1544 #f) (args-1541 #f))
                            (begin
                              (set! args-1541
                                    (py-getattribute self-209 (& "args")))
                              (set! args_len-1544
                                    (py-call (global-get
                                              %global
                                              (& "len")
                                              (vector-ref %caches 601))
                                             (py-getattribute
                                              self-209
                                              (& "args"))))
                              (if (py-test (py-eq args_len-1544
                                                  (py-int-from-scheme 0)))
                                  (&& "")
                                  (if (py-test (py-eq args_len-1544
                                                      (py-int-from-scheme 1)))
                                      (py-call &py-builtin-str
                                               (py-getitem
                                                args-1541
                                                (py-int-from-scheme 0)))
                                      (py-call &py-builtin-str args-1541))))))
                        (make-signature args: (self)))))
               (begin
                 (set! $%cls_6
                       (py-make-builtin-class
                        (&& "BaseException")
                        (&& "__main__")
                        (list)
                        (& "__str__")
                        __str__-1539
                        (& "__init__")
                        __init__-1537))
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
     (let ((caches (py-make-caches 737))
           (module (py-make-module name package __path__)))
       (begin)
       (py-module module caches)
       module))
   (py-end-module)))

