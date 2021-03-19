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
     (lambda (l1-199 l2-200)
       (letrec* ((output-1499 #f) (i-1497 #f) (j-1495 #f))
         (begin
           (&& "\n    Merge all items from two sorted list into one sorted list.\n    Time complexity: O(n) where n is the total number of elements\n    ")
           (letrec* ((%tmp0-201 (py-int-from-scheme 0)))
             (begin
               (set! j-1495
                     (or %tmp0-201
                         (py-throw-exception-with-message
                          py-builtin-UnboundLocalError
                          "local variable '%tmp0' referenced before assignment")))
               (set! i-1497
                     (or %tmp0-201
                         (py-throw-exception-with-message
                          py-builtin-UnboundLocalError
                          "local variable '%tmp0' referenced before assignment")))))
           (set! output-1499 (py-make-list))
           (let $%while_77 ()
             (when (and
                    (py-test (py-lt (or i-1497
                                        (py-throw-exception-with-message
                                         py-builtin-UnboundLocalError
                                         "local variable 'i' referenced before assignment"))
                                    (py-call (global-get
                                              %global
                                              (& "len")
                                              (vector-ref %caches 561))
                                             l1-199)))
                    (py-test (py-lt (or j-1495
                                        (py-throw-exception-with-message
                                         py-builtin-UnboundLocalError
                                         "local variable 'j' referenced before assignment"))
                                    (py-call (global-get
                                              %global
                                              (& "len")
                                              (vector-ref %caches 562))
                                             l2-200))))
               (if (py-test (py-le (py-getitem
                                    l1-199
                                    (or i-1497
                                        (py-throw-exception-with-message
                                         py-builtin-UnboundLocalError
                                         "local variable 'i' referenced before assignment")))
                                   (py-getitem
                                    l2-200
                                    (or j-1495
                                        (py-throw-exception-with-message
                                         py-builtin-UnboundLocalError
                                         "local variable 'j' referenced before assignment")))))
                   (begin
                     (py-call (py-getattribute output-1499 (& "append"))
                              (py-getitem
                               l1-199
                               (or i-1497
                                   (py-throw-exception-with-message
                                    py-builtin-UnboundLocalError
                                    "local variable 'i' referenced before assignment"))))
                     (set! i-1497
                           (py-iadd (or i-1497
                                        (py-throw-exception-with-message
                                         py-builtin-UnboundLocalError
                                         "local variable 'i' referenced before assignment"))
                                    (py-int-from-scheme 1))))
                   (begin
                     (py-call (py-getattribute output-1499 (& "append"))
                              (py-getitem
                               l2-200
                               (or j-1495
                                   (py-throw-exception-with-message
                                    py-builtin-UnboundLocalError
                                    "local variable 'j' referenced before assignment"))))
                     (set! j-1495
                           (py-iadd (or j-1495
                                        (py-throw-exception-with-message
                                         py-builtin-UnboundLocalError
                                         "local variable 'j' referenced before assignment"))
                                    (py-int-from-scheme 1)))))
               ($%while_77)))
           (py-call (py-getattribute output-1499 (& "extend"))
                    (py-add (py-getitem
                             l1-199
                             (py-slice-from-scheme
                              (or i-1497
                                  (py-throw-exception-with-message
                                   py-builtin-UnboundLocalError
                                   "local variable 'i' referenced before assignment"))
                              py-None
                              py-None))
                            (py-getitem
                             l2-200
                             (py-slice-from-scheme
                              (or j-1495
                                  (py-throw-exception-with-message
                                   py-builtin-UnboundLocalError
                                   "local variable 'j' referenced before assignment"))
                              py-None
                              py-None))))
           output-1499))))
   (define procedure:&py-builtin-__merge_many
     (lambda (lsts-202)
       (letrec* ((right-1509 #f) (left-1507 #f))
         (begin
           (&& "\n    Merge all items from k lists into one sorted list.\n    Time complexity: O(n log(k)) where n is the total number of elements and k the number of lists\n    ")
           (if (py-test (py-not lsts-202))
               (py-make-list)
               (if (py-test (py-eq (py-call (global-get
                                             %global
                                             (& "len")
                                             (vector-ref %caches 570))
                                            lsts-202)
                                   (py-int-from-scheme 1)))
                   (py-getitem
                    (py-getitem lsts-202 (py-int-from-scheme 0))
                    (py-slice-from-scheme py-None py-None py-None))
                   (if (py-test (py-eq (py-call (global-get
                                                 %global
                                                 (& "len")
                                                 (vector-ref %caches 571))
                                                lsts-202)
                                       (py-int-from-scheme 2)))
                       (procedure:&py-builtin-__merge
                        (py-getitem lsts-202 (py-int-from-scheme 0))
                        (py-getitem lsts-202 (py-int-from-scheme 1)))
                       (begin
                         (set! left-1507
                               (py-getitem
                                lsts-202
                                (py-slice-from-scheme
                                 (py-floordiv
                                  (py-call (global-get
                                            %global
                                            (& "len")
                                            (vector-ref %caches 573))
                                           lsts-202)
                                  (py-int-from-scheme 2))
                                 py-None
                                 py-None)))
                         (set! right-1509
                               (py-getitem
                                lsts-202
                                (py-slice-from-scheme
                                 py-None
                                 (py-floordiv
                                  (py-call (global-get
                                            %global
                                            (& "len")
                                            (vector-ref %caches 574))
                                           lsts-202)
                                  (py-int-from-scheme 2))
                                 py-None)))
                         (procedure:&py-builtin-__merge
                          (procedure:&py-builtin-__merge_many left-1507)
                          (procedure:&py-builtin-__merge_many
                           right-1509))))))))))
   (define procedure:&py-builtin-sorted
     (lambda (lst-203 key-204 reversed-205)
       (letrec* ((i-1514 #f) (sublsts-1512 #f))
         (begin
           (&& "\n    Timsort is an improved version of Merge Sort which splits the list into monotonic sub-lists before merging them\n    into a sorted list.\n    Worst case time complexity: O(n log(n))\n    Best cast time complexity:  O(n) when the list is almost sorted\n        where n is the number of elements in the list\n    ")
           (set! sublsts-1512 (py-make-list))
           (set! i-1514 (py-int-from-scheme 0))
           (let $%while_78 ()
             (when (py-test
                    (py-lt i-1514
                           (py-call (global-get
                                     %global
                                     (& "len")
                                     (vector-ref %caches 579))
                                    lst-203)))
               (begin
                 (py-call (py-getattribute sublsts-1512 (& "append"))
                          (py-make-list (py-getitem lst-203 i-1514)))
                 (set! i-1514
                       (py-iadd (or i-1514
                                    (py-throw-exception-with-message
                                     py-builtin-UnboundLocalError
                                     "local variable 'i' referenced before assignment"))
                                (py-int-from-scheme 1)))
                 (if (and (py-test (py-lt i-1514
                                          (py-call (global-get
                                                    %global
                                                    (& "len")
                                                    (vector-ref %caches 582))
                                                   lst-203)))
                          (py-test (py-ge (py-getitem lst-203 i-1514)
                                          (py-getitem
                                           lst-203
                                           (py-sub i-1514
                                                   (py-int-from-scheme 1))))))
                     (let $%while_79 ()
                       (when (and
                              (py-test (py-lt i-1514
                                              (py-call (global-get
                                                        %global
                                                        (& "len")
                                                        (vector-ref
                                                         %caches
                                                         583))
                                                       lst-203)))
                              (py-test (py-ge (py-getitem lst-203 i-1514)
                                              (py-getitem
                                               lst-203
                                               (py-sub i-1514
                                                       (py-int-from-scheme
                                                        1))))))
                         (begin
                           (py-call (py-getattribute
                                     (py-getitem
                                      sublsts-1512
                                      (py-neg (py-int-from-scheme 1)))
                                     (& "append"))
                                    (py-getitem lst-203 i-1514))
                           (set! i-1514
                                 (py-iadd (or i-1514
                                              (py-throw-exception-with-message
                                               py-builtin-UnboundLocalError
                                               "local variable 'i' referenced before assignment"))
                                          (py-int-from-scheme 1))))
                         ($%while_79)))
                     (if (py-test (py-lt i-1514
                                         (py-call (global-get
                                                   %global
                                                   (& "len")
                                                   (vector-ref %caches 587))
                                                  lst-203)))
                         (begin
                           (let $%while_80 ()
                             (when (and
                                    (py-test (py-lt i-1514
                                                    (py-call (global-get
                                                              %global
                                                              (& "len")
                                                              (vector-ref
                                                               %caches
                                                               588))
                                                             lst-203)))
                                    (py-test (py-lt (py-getitem lst-203 i-1514)
                                                    (py-getitem
                                                     lst-203
                                                     (py-sub i-1514
                                                             (py-int-from-scheme
                                                              1))))))
                               (begin
                                 (py-call (py-getattribute
                                           (py-getitem
                                            sublsts-1512
                                            (py-neg (py-int-from-scheme 1)))
                                           (& "append"))
                                          (py-getitem lst-203 i-1514))
                                 (set! i-1514
                                       (py-iadd (or i-1514
                                                    (py-throw-exception-with-message
                                                     py-builtin-UnboundLocalError
                                                     "local variable 'i' referenced before assignment"))
                                                (py-int-from-scheme 1))))
                               ($%while_80)))
                           (py-setitem
                            (or sublsts-1512
                                (py-throw-exception-with-message
                                 py-builtin-UnboundLocalError
                                 "local variable 'sublsts' referenced before assignment"))
                            (py-neg (py-int-from-scheme 1))
                            (py-getitem
                             (py-getitem
                              (or sublsts-1512
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
           (procedure:&py-builtin-__merge_many sublsts-1512)))))
   (declare (separate))
   (define %global #f)
   (define %caches #f)
   (define init:&py-builtin-__merge #f)
   (define init:&py-builtin-__merge_many #f)
   (define init:&py-builtin-sorted #f)
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
   (define &py-builtin-float #f)
   (define &py-builtin-bool #f)
   (define &py-builtin-ZeroDivisionError #f)
   (define &py-builtin-ValueError #f)
   (define &py-builtin-TypeError #f)
   (define &py-builtin-NotImplementedError #f)
   (define &py-builtin-int #f)
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
             (letrec* ((__lt__-396 #f)
                       (__le__-394 #f)
                       (__gt__-392 #f)
                       (__ge__-390 #f)
                       (__ne__-388 #f)
                       (__eq__-386 #f)
                       (__imod__-384 #f)
                       (__rmod__-382 #f)
                       (__mod__-380 #f)
                       (__itruediv__-378 #f)
                       (__rtruediv__-376 #f)
                       (__truediv__-374 #f)
                       (__ifloordiv__-372 #f)
                       (__rfloordiv__-370 #f)
                       (__floordiv__-368 #f)
                       (__invert__-366 #f)
                       (__neg__-364 #f)
                       (__pos__-362 #f)
                       (__irshift__-360 #f)
                       (__rrshift__-358 #f)
                       (__rshift__-356 #f)
                       (__ilshift__-354 #f)
                       (__rlshift__-352 #f)
                       (__lshift__-350 #f)
                       (__ixor__-348 #f)
                       (__rxor__-346 #f)
                       (__xor__-344 #f)
                       (__isub__-342 #f)
                       (__rsub__-340 #f)
                       (__sub__-338 #f)
                       (__ipow__-336 #f)
                       (__rpow__-334 #f)
                       (__pow__-332 #f)
                       (__imul__-330 #f)
                       (__rmul__-328 #f)
                       (__mul__-326 #f)
                       (__ior__-324 #f)
                       (__ror__-322 #f)
                       (__or__-320 #f)
                       (__iand__-318 #f)
                       (__rand__-316 #f)
                       (__and__-314 #f)
                       (__iadd__-312 #f)
                       (__radd__-310 #f)
                       (__add__-308 #f)
                       (__abs__-306 #f)
                       (__index__-304 #f)
                       (__bool__-302 #f)
                       (__new__-299 #f))
               (begin
                 (set! __new__-299
                       (procedure->py-function
                        (lambda (cls-2 val-3)
                          (bind-exit
                           ($%return_73)
                           (letrec* ()
                             (if (py-test (py-is cls-2 &py-builtin-int))
                                 (begin
                                   (if (py-test (py-is val-3 py-absent))
                                       ($%return_73 (py-int-from-scheme 0))
                                       #f)
                                   (if (py-isinstance? val-3 &py-builtin-int)
                                       (py-int-from-scheme
                                        (py-int-to-scheme val-3))
                                       (py-throw
                                        &py-builtin-NotImplementedError)))
                                 (if (and (py-isinstance?
                                           cls-2
                                           (global-get
                                            %global
                                            (& "type")
                                            (vector-ref %caches 4)))
                                          (py-test (py-call (global-get
                                                             %global
                                                             (& "issubclass")
                                                             (vector-ref
                                                              %caches
                                                              5))
                                                            cls-2
                                                            &py-builtin-int)))
                                     (py-throw &py-builtin-NotImplementedError)
                                     (py-throw
                                      (py-call &py-builtin-TypeError
                                               (&& "int.__new__ expected a subtype of 'int' as first argument"))))))))
                        (make-signature
                         args:
                         (cls val)
                         defaults:
                         (vector py-absent))))
                 (set! __bool__-302
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
                 (set! __index__-304
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
                 (set! __abs__-306
                       (procedure->py-function
                        (lambda (self-6)
                          (letrec* ()
                            (if (py-isinstance? self-6 &py-builtin-int)
                                (if (py-test (py-lt self-6
                                                    (py-int-from-scheme 0)))
                                    (py-int-from-scheme
                                     (pyneg (py-int-to-scheme self-6)))
                                    (py-int-from-scheme
                                     (py-int-to-scheme self-6)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__abs__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-6)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __add__-308
                       (procedure->py-function
                        (lambda (self-7 other-8)
                          (letrec* ()
                            (if (py-isinstance? self-7 &py-builtin-int)
                                (if (py-isinstance? other-8 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py+ (py-int-to-scheme self-7)
                                          (py-int-to-scheme other-8)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 21)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__add__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-7)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __radd__-310
                       (procedure->py-function
                        (lambda (self-9 other-10)
                          (letrec* ()
                            (if (py-isinstance? self-9 &py-builtin-int)
                                (if (py-isinstance? other-10 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py+ (py-int-to-scheme other-10)
                                          (py-int-to-scheme self-9)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 26)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__radd__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-9)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __iadd__-312
                       (procedure->py-function
                        (lambda (self-11 other-12)
                          (letrec* ()
                            (if (py-isinstance? self-11 &py-builtin-int)
                                (if (py-isinstance? other-12 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py+ (py-int-to-scheme self-11)
                                          (py-int-to-scheme other-12)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 31)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__iadd__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-11)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __and__-314
                       (procedure->py-function
                        (lambda (self-13 other-14)
                          (letrec* ()
                            (if (py-isinstance? self-13 &py-builtin-int)
                                (if (py-isinstance? other-14 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py& (py-int-to-scheme self-13)
                                          (py-int-to-scheme other-14)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 36)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__and__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-13)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rand__-316
                       (procedure->py-function
                        (lambda (self-15 other-16)
                          (letrec* ()
                            (if (py-isinstance? self-15 &py-builtin-int)
                                (if (py-isinstance? other-16 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py& (py-int-to-scheme other-16)
                                          (py-int-to-scheme self-15)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 41)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rand__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-15)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __iand__-318
                       (procedure->py-function
                        (lambda (self-17 other-18)
                          (letrec* ()
                            (if (py-isinstance? self-17 &py-builtin-int)
                                (if (py-isinstance? other-18 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py& (py-int-to-scheme self-17)
                                          (py-int-to-scheme other-18)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 46)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__iand__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-17)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __or__-320
                       (procedure->py-function
                        (lambda (self-19 other-20)
                          (letrec* ()
                            (if (py-isinstance? self-19 &py-builtin-int)
                                (if (py-isinstance? other-20 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py+b (py-int-to-scheme self-19)
                                           (py-int-to-scheme other-20)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 51)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__or__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-19)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ror__-322
                       (procedure->py-function
                        (lambda (self-21 other-22)
                          (letrec* ()
                            (if (py-isinstance? self-21 &py-builtin-int)
                                (if (py-isinstance? other-22 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py+b (py-int-to-scheme other-22)
                                           (py-int-to-scheme self-21)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 56)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ror__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-21)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ior__-324
                       (procedure->py-function
                        (lambda (self-23 other-24)
                          (letrec* ()
                            (if (py-isinstance? self-23 &py-builtin-int)
                                (if (py-isinstance? other-24 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py+b (py-int-to-scheme self-23)
                                           (py-int-to-scheme other-24)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 61)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ior__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-23)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __mul__-326
                       (procedure->py-function
                        (lambda (self-25 other-26)
                          (letrec* ()
                            (if (py-isinstance? self-25 &py-builtin-int)
                                (if (py-isinstance? other-26 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py* (py-int-to-scheme self-25)
                                          (py-int-to-scheme other-26)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 66)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__mul__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-25)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rmul__-328
                       (procedure->py-function
                        (lambda (self-27 other-28)
                          (letrec* ()
                            (if (py-isinstance? self-27 &py-builtin-int)
                                (if (py-isinstance? other-28 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py* (py-int-to-scheme other-28)
                                          (py-int-to-scheme self-27)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 71)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rmul__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-27)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __imul__-330
                       (procedure->py-function
                        (lambda (self-29 other-30)
                          (letrec* ()
                            (if (py-isinstance? self-29 &py-builtin-int)
                                (if (py-isinstance? other-30 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py* (py-int-to-scheme self-29)
                                          (py-int-to-scheme other-30)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 76)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__imul__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-29)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __pow__-332
                       (procedure->py-function
                        (lambda (self-31 other-32)
                          (letrec* ()
                            (if (py-isinstance? self-31 &py-builtin-int)
                                (if (py-isinstance? other-32 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py** (py-int-to-scheme self-31)
                                           (py-int-to-scheme other-32)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 81)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__pow__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-31)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rpow__-334
                       (procedure->py-function
                        (lambda (self-33 other-34)
                          (letrec* ()
                            (if (py-isinstance? self-33 &py-builtin-int)
                                (if (py-isinstance? other-34 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py** (py-int-to-scheme other-34)
                                           (py-int-to-scheme self-33)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 86)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rpow__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-33)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ipow__-336
                       (procedure->py-function
                        (lambda (self-35 other-36)
                          (letrec* ()
                            (if (py-isinstance? self-35 &py-builtin-int)
                                (if (py-isinstance? other-36 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py** (py-int-to-scheme self-35)
                                           (py-int-to-scheme other-36)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 91)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ipow__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-35)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __sub__-338
                       (procedure->py-function
                        (lambda (self-37 other-38)
                          (letrec* ()
                            (if (py-isinstance? self-37 &py-builtin-int)
                                (if (py-isinstance? other-38 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py- (py-int-to-scheme self-37)
                                          (py-int-to-scheme other-38)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 96)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__sub__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-37)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rsub__-340
                       (procedure->py-function
                        (lambda (self-39 other-40)
                          (letrec* ()
                            (if (py-isinstance? self-39 &py-builtin-int)
                                (if (py-isinstance? other-40 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py- (py-int-to-scheme other-40)
                                          (py-int-to-scheme self-39)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 101)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rsub__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-39)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __isub__-342
                       (procedure->py-function
                        (lambda (self-41 other-42)
                          (letrec* ()
                            (if (py-isinstance? self-41 &py-builtin-int)
                                (if (py-isinstance? other-42 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py- (py-int-to-scheme self-41)
                                          (py-int-to-scheme other-42)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 106)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__isub__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-41)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __xor__-344
                       (procedure->py-function
                        (lambda (self-43 other-44)
                          (letrec* ()
                            (if (py-isinstance? self-43 &py-builtin-int)
                                (if (py-isinstance? other-44 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py^ (py-int-to-scheme self-43)
                                          (py-int-to-scheme other-44)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 111)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__xor__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-43)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rxor__-346
                       (procedure->py-function
                        (lambda (self-45 other-46)
                          (letrec* ()
                            (if (py-isinstance? self-45 &py-builtin-int)
                                (if (py-isinstance? other-46 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py^ (py-int-to-scheme other-46)
                                          (py-int-to-scheme self-45)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 116)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rxor__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-45)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ixor__-348
                       (procedure->py-function
                        (lambda (self-47 other-48)
                          (letrec* ()
                            (if (py-isinstance? self-47 &py-builtin-int)
                                (if (py-isinstance? other-48 &py-builtin-int)
                                    (py-int-from-scheme
                                     (py^ (py-int-to-scheme self-47)
                                          (py-int-to-scheme other-48)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 121)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ixor__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-47)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __lshift__-350
                       (procedure->py-function
                        (lambda (self-49 other-50)
                          (letrec* ()
                            (if (py-isinstance? self-49 &py-builtin-int)
                                (if (py-isinstance? other-50 &py-builtin-int)
                                    (if (py-test (py-ge other-50
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py<< (py-int-to-scheme self-49)
                                               (py-int-to-scheme other-50)))
                                        (py-throw
                                         (py-call &py-builtin-ValueError
                                                  (&& "negative shift count"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 127)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__lshift__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-49)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rlshift__-352
                       (procedure->py-function
                        (lambda (self-51 other-52)
                          (letrec* ()
                            (if (py-isinstance? self-51 &py-builtin-int)
                                (if (py-isinstance? other-52 &py-builtin-int)
                                    (if (py-test (py-ge self-51
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py<< (py-int-to-scheme self-51)
                                               (py-int-to-scheme other-52)))
                                        (py-throw
                                         (py-call &py-builtin-ValueError
                                                  (&& "negative shift count"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 133)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rlshift__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-51)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ilshift__-354
                       (procedure->py-function
                        (lambda (self-53 other-54)
                          (letrec* ()
                            (if (py-isinstance? self-53 &py-builtin-int)
                                (if (py-isinstance? other-54 &py-builtin-int)
                                    (if (py-test (py-ge other-54
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py<< (py-int-to-scheme self-53)
                                               (py-int-to-scheme other-54)))
                                        (py-throw
                                         (py-call &py-builtin-ValueError
                                                  (&& "negative shift count"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 139)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ilshift__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-53)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rshift__-356
                       (procedure->py-function
                        (lambda (self-55 other-56)
                          (letrec* ()
                            (if (py-isinstance? self-55 &py-builtin-int)
                                (if (py-isinstance? other-56 &py-builtin-int)
                                    (if (py-test (py-ge other-56
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py>> (py-int-to-scheme self-55)
                                               (py-int-to-scheme other-56)))
                                        (py-throw
                                         (py-call &py-builtin-ValueError
                                                  (&& "negative shift count"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 145)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rshift__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-55)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rrshift__-358
                       (procedure->py-function
                        (lambda (self-57 other-58)
                          (letrec* ()
                            (if (py-isinstance? self-57 &py-builtin-int)
                                (if (py-isinstance? other-58 &py-builtin-int)
                                    (if (py-test (py-ge self-57
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py>> (py-int-to-scheme self-57)
                                               (py-int-to-scheme other-58)))
                                        (py-throw
                                         (py-call &py-builtin-ValueError
                                                  (&& "negative shift count"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 151)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rrshift__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-57)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __irshift__-360
                       (procedure->py-function
                        (lambda (self-59 other-60)
                          (letrec* ()
                            (if (py-isinstance? self-59 &py-builtin-int)
                                (if (py-isinstance? other-60 &py-builtin-int)
                                    (if (py-test (py-ge other-60
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py>> (py-int-to-scheme self-59)
                                               (py-int-to-scheme other-60)))
                                        (py-throw
                                         (py-call &py-builtin-ValueError
                                                  (&& "negative shift count"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 157)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__irshift__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-59)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __pos__-362
                       (procedure->py-function
                        (lambda (self-61)
                          (letrec* ()
                            (if (py-isinstance? self-61 &py-builtin-int)
                                (py-int-from-scheme (py-int-to-scheme self-61))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__pos__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-61)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __neg__-364
                       (procedure->py-function
                        (lambda (self-62)
                          (letrec* ()
                            (if (py-isinstance? self-62 &py-builtin-int)
                                (py-int-from-scheme
                                 (pyneg (py-int-to-scheme self-62)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__neg__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-62)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __invert__-366
                       (procedure->py-function
                        (lambda (self-63)
                          (letrec* ()
                            (if (py-isinstance? self-63 &py-builtin-int)
                                (py-int-from-scheme
                                 (pyinvert (py-int-to-scheme self-63)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__invert__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-63)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __floordiv__-368
                       (procedure->py-function
                        (lambda (self-64 other-65)
                          (letrec* ()
                            (if (py-isinstance? self-64 &py-builtin-int)
                                (if (py-isinstance? other-65 &py-builtin-int)
                                    (if (py-test (py-ne other-65
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py// (py-int-to-scheme self-64)
                                               (py-int-to-scheme other-65)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "integer division by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 174)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__floordiv__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-64)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rfloordiv__-370
                       (procedure->py-function
                        (lambda (self-66 other-67)
                          (letrec* ()
                            (if (py-isinstance? self-66 &py-builtin-int)
                                (if (py-isinstance? other-67 &py-builtin-int)
                                    (if (py-test (py-ne self-66
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py// (py-int-to-scheme other-67)
                                               (py-int-to-scheme self-66)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "integer division by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 180)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rfloordiv__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-66)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ifloordiv__-372
                       (procedure->py-function
                        (lambda (self-68 other-69)
                          (letrec* ()
                            (if (py-isinstance? self-68 &py-builtin-int)
                                (if (py-isinstance? other-69 &py-builtin-int)
                                    (if (py-test (py-ne other-69
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py// (py-int-to-scheme self-68)
                                               (py-int-to-scheme other-69)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "integer division by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 186)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ifloordiv__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-68)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __truediv__-374
                       (procedure->py-function
                        (lambda (self-70 other-71)
                          (letrec* ()
                            (if (py-isinstance? self-70 &py-builtin-int)
                                (if (py-isinstance? other-71 &py-builtin-int)
                                    (if (py-test (py-ne other-71
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-float-from-scheme
                                         (py/ (py-int-to-scheme self-70)
                                              (py-int-to-scheme other-71)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "division by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 192)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__truediv__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-70)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rtruediv__-376
                       (procedure->py-function
                        (lambda (self-72 other-73)
                          (letrec* ()
                            (if (py-isinstance? self-72 &py-builtin-int)
                                (if (py-isinstance? other-73 &py-builtin-int)
                                    (if (py-test (py-ne self-72
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-float-from-scheme
                                         (py/ (py-int-to-scheme other-73)
                                              (py-int-to-scheme self-72)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "division by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 198)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rtruediv__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-72)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __itruediv__-378
                       (procedure->py-function
                        (lambda (self-74 other-75)
                          (letrec* ()
                            (if (py-isinstance? self-74 &py-builtin-int)
                                (if (py-isinstance? other-75 &py-builtin-int)
                                    (if (py-test (py-ne other-75
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-float-from-scheme
                                         (py/ (py-int-to-scheme self-74)
                                              (py-int-to-scheme other-75)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "division by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 204)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__itruediv__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-74)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __mod__-380
                       (procedure->py-function
                        (lambda (self-76 other-77)
                          (letrec* ()
                            (if (py-isinstance? self-76 &py-builtin-int)
                                (if (py-isinstance? other-77 &py-builtin-int)
                                    (if (py-test (py-ne other-77
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py% (py-int-to-scheme self-76)
                                              (py-int-to-scheme other-77)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "modulo by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 210)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__mod__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-76)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rmod__-382
                       (procedure->py-function
                        (lambda (self-78 other-79)
                          (letrec* ()
                            (if (py-isinstance? self-78 &py-builtin-int)
                                (if (py-isinstance? other-79 &py-builtin-int)
                                    (if (py-test (py-ne self-78
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py% (py-int-to-scheme other-79)
                                              (py-int-to-scheme self-78)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "modulo by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 216)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rmod__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-78)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __imod__-384
                       (procedure->py-function
                        (lambda (self-80 other-81)
                          (letrec* ()
                            (if (py-isinstance? self-80 &py-builtin-int)
                                (if (py-isinstance? other-81 &py-builtin-int)
                                    (if (py-test (py-ne other-81
                                                        (py-int-from-scheme
                                                         0)))
                                        (py-int-from-scheme
                                         (py% (py-int-to-scheme self-80)
                                              (py-int-to-scheme other-81)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "modulo by zero"))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 222)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__imod__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-80)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __eq__-386
                       (procedure->py-function
                        (lambda (self-82 other-83)
                          (letrec* ()
                            (if (py-isinstance? self-82 &py-builtin-int)
                                (if (py-isinstance? other-83 &py-builtin-int)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py== (py-int-to-scheme self-82)
                                            (py-int-to-scheme other-83))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 227)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__eq__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-82)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ne__-388
                       (procedure->py-function
                        (lambda (self-84 other-85)
                          (letrec* ()
                            (if (py-isinstance? self-84 &py-builtin-int)
                                (if (py-isinstance? other-85 &py-builtin-int)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py!= (py-int-to-scheme self-84)
                                            (py-int-to-scheme other-85))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 232)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ne__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-84)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ge__-390
                       (procedure->py-function
                        (lambda (self-86 other-87)
                          (letrec* ()
                            (if (py-isinstance? self-86 &py-builtin-int)
                                (if (py-isinstance? other-87 &py-builtin-int)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py>= (py-int-to-scheme self-86)
                                            (py-int-to-scheme other-87))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 237)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ge__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-86)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __gt__-392
                       (procedure->py-function
                        (lambda (self-88 other-89)
                          (letrec* ()
                            (if (py-isinstance? self-88 &py-builtin-int)
                                (if (py-isinstance? other-89 &py-builtin-int)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py> (py-int-to-scheme self-88)
                                           (py-int-to-scheme other-89))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 242)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__gt__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-88)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __le__-394
                       (procedure->py-function
                        (lambda (self-90 other-91)
                          (letrec* ()
                            (if (py-isinstance? self-90 &py-builtin-int)
                                (if (py-isinstance? other-91 &py-builtin-int)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py<= (py-int-to-scheme self-90)
                                            (py-int-to-scheme other-91))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 247)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__le__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-90)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __lt__-396
                       (procedure->py-function
                        (lambda (self-92 other-93)
                          (letrec* ()
                            (if (py-isinstance? self-92 &py-builtin-int)
                                (if (py-isinstance? other-93 &py-builtin-int)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py< (py-int-to-scheme self-92)
                                           (py-int-to-scheme other-93))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 252)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__lt__' requires a 'int' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-92)
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
                        __lt__-396
                        (& "__le__")
                        __le__-394
                        (& "__gt__")
                        __gt__-392
                        (& "__ge__")
                        __ge__-390
                        (& "__ne__")
                        __ne__-388
                        (& "__eq__")
                        __eq__-386
                        (& "__imod__")
                        __imod__-384
                        (& "__rmod__")
                        __rmod__-382
                        (& "__mod__")
                        __mod__-380
                        (& "__itruediv__")
                        __itruediv__-378
                        (& "__rtruediv__")
                        __rtruediv__-376
                        (& "__truediv__")
                        __truediv__-374
                        (& "__ifloordiv__")
                        __ifloordiv__-372
                        (& "__rfloordiv__")
                        __rfloordiv__-370
                        (& "__floordiv__")
                        __floordiv__-368
                        (& "__invert__")
                        __invert__-366
                        (& "__neg__")
                        __neg__-364
                        (& "__pos__")
                        __pos__-362
                        (& "__irshift__")
                        __irshift__-360
                        (& "__rrshift__")
                        __rrshift__-358
                        (& "__rshift__")
                        __rshift__-356
                        (& "__ilshift__")
                        __ilshift__-354
                        (& "__rlshift__")
                        __rlshift__-352
                        (& "__lshift__")
                        __lshift__-350
                        (& "__ixor__")
                        __ixor__-348
                        (& "__rxor__")
                        __rxor__-346
                        (& "__xor__")
                        __xor__-344
                        (& "__isub__")
                        __isub__-342
                        (& "__rsub__")
                        __rsub__-340
                        (& "__sub__")
                        __sub__-338
                        (& "__ipow__")
                        __ipow__-336
                        (& "__rpow__")
                        __rpow__-334
                        (& "__pow__")
                        __pow__-332
                        (& "__imul__")
                        __imul__-330
                        (& "__rmul__")
                        __rmul__-328
                        (& "__mul__")
                        __mul__-326
                        (& "__ior__")
                        __ior__-324
                        (& "__ror__")
                        __ror__-322
                        (& "__or__")
                        __or__-320
                        (& "__iand__")
                        __iand__-318
                        (& "__rand__")
                        __rand__-316
                        (& "__and__")
                        __and__-314
                        (& "__iadd__")
                        __iadd__-312
                        (& "__radd__")
                        __radd__-310
                        (& "__add__")
                        __add__-308
                        (& "__abs__")
                        __abs__-306
                        (& "__index__")
                        __index__-304
                        (& "__bool__")
                        __bool__-302
                        (& "__new__")
                        __new__-299))
                 $%cls_0))))
     (set! &py-builtin-bool
           (let (($%cls_1 py-absent))
             (letrec* ((__rxor__-857 #f)
                       (__xor__-855 #f)
                       (__ror__-853 #f)
                       (__or__-851 #f)
                       (__rand__-849 #f)
                       (__and__-847 #f)
                       (__repr__-845 #f)
                       (__new__-842 #f))
               (begin
                 (set! __new__-842
                       (procedure->py-function
                        (lambda (cls-94 val-95)
                          (letrec* ()
                            (if (py-test (py-is cls-94 &py-builtin-bool))
                                (if (py-test (py-is val-95 py-absent))
                                    py-False
                                    (if (py-test val-95) py-True py-False))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (&& "bool.__new__ expected a subtype of 'bool' as first argument"))))))
                        (make-signature
                         args:
                         (cls val)
                         defaults:
                         (vector py-absent))))
                 (set! __repr__-845
                       (procedure->py-function
                        (lambda (self-96)
                          (letrec* ()
                            (if (py-test (py-is self-96 py-True))
                                (&& "True")
                                (if (py-test (py-is self-96 py-False))
                                    (&& "False")
                                    (py-throw
                                     (py-call &py-builtin-TypeError
                                              (py-add (py-add (&& "descriptor '__repr__' requires a 'bool' object but received a '")
                                                              (py-getattribute
                                                               (py-obj-cls
                                                                self-96)
                                                               (& "__name__")))
                                                      (&& "'"))))))))
                        (make-signature args: (self))))
                 (set! __and__-847
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
                                         (py& (py-int-to-scheme self-97)
                                              (py-int-to-scheme other-98)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 263))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__and__' requires a 'bool' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-97)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rand__-849
                       (procedure->py-function
                        (lambda (self-99 other-100)
                          (letrec* ()
                            (if (py-test (py-is (py-obj-cls self-99)
                                                &py-builtin-bool))
                                (if (py-test (py-is (py-obj-cls other-100)
                                                    &py-builtin-bool))
                                    (if (py-test (py-is self-99 py-True))
                                        other-100
                                        py-False)
                                    (if (py-isinstance?
                                         other-100
                                         &py-builtin-int)
                                        (py-int-from-scheme
                                         (py& (py-int-to-scheme other-100)
                                              (py-int-to-scheme self-99)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 269))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rand__' requires a 'bool' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls self-99)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __or__-851
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
                                         (py+b (py-int-to-scheme self-101)
                                               (py-int-to-scheme other-102)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 275))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__or__' requires a 'bool' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-101)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ror__-853
                       (procedure->py-function
                        (lambda (self-103 other-104)
                          (letrec* ()
                            (if (py-test (py-is (py-obj-cls self-103)
                                                &py-builtin-bool))
                                (if (py-test (py-is (py-obj-cls other-104)
                                                    &py-builtin-bool))
                                    (if (py-test (py-is self-103 py-True))
                                        py-True
                                        other-104)
                                    (if (py-isinstance?
                                         other-104
                                         &py-builtin-int)
                                        (py-int-from-scheme
                                         (py+b (py-int-to-scheme other-104)
                                               (py-int-to-scheme self-103)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 281))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ror__' requires a 'bool' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-103)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __xor__-855
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
                                         (py^ (py-int-to-scheme self-105)
                                              (py-int-to-scheme other-106)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 287))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__xor__' requires a 'bool' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-105)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rxor__-857
                       (procedure->py-function
                        (lambda (self-107 other-108)
                          (letrec* ()
                            (if (py-test (py-is (py-obj-cls self-107)
                                                &py-builtin-bool))
                                (if (py-test (py-is (py-obj-cls other-108)
                                                    &py-builtin-bool))
                                    (py-isnot self-107 other-108)
                                    (if (py-isinstance?
                                         other-108
                                         &py-builtin-int)
                                        (py-int-from-scheme
                                         (py^ (py-int-to-scheme other-108)
                                              (py-int-to-scheme self-107)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 293))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rxor__' requires a 'bool' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-107)
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
                        __rxor__-857
                        (& "__xor__")
                        __xor__-855
                        (& "__ror__")
                        __ror__-853
                        (& "__or__")
                        __or__-851
                        (& "__rand__")
                        __rand__-849
                        (& "__and__")
                        __and__-847
                        (& "__repr__")
                        __repr__-845
                        (& "__new__")
                        __new__-842))
                 $%cls_1))))
     (set! &py-builtin-float
           (let (($%cls_2 py-absent))
             (letrec* ((__lt__-988 #f)
                       (__le__-986 #f)
                       (__gt__-984 #f)
                       (__ge__-982 #f)
                       (__ne__-980 #f)
                       (__eq__-978 #f)
                       (__imod__-976 #f)
                       (__rmod__-974 #f)
                       (__mod__-972 #f)
                       (__itruediv__-970 #f)
                       (__rtruediv__-968 #f)
                       (__truediv__-966 #f)
                       (__ifloordiv__-964 #f)
                       (__rfloordiv__-962 #f)
                       (__floordiv__-960 #f)
                       (__neg__-958 #f)
                       (__pos__-956 #f)
                       (__isub__-954 #f)
                       (__rsub__-952 #f)
                       (__sub__-950 #f)
                       (__ipow__-948 #f)
                       (__rpow__-946 #f)
                       (__pow__-944 #f)
                       (__imul__-942 #f)
                       (__rmul__-940 #f)
                       (__mul__-938 #f)
                       (__iadd__-936 #f)
                       (__radd__-934 #f)
                       (__add__-932 #f)
                       (__bool__-930 #f)
                       (__new__-927 #f))
               (begin
                 (set! __new__-927
                       (procedure->py-function
                        (lambda (cls-109 val-110)
                          (bind-exit
                           ($%return_74)
                           (letrec* ()
                             (if (py-test (py-is cls-109 &py-builtin-float))
                                 (begin
                                   (if (py-test (py-is val-110 py-absent))
                                       ($%return_74 (py-float-from-scheme 0.))
                                       #f)
                                   (if (py-isinstance?
                                        val-110
                                        &py-builtin-float)
                                       (py-float-from-scheme
                                        (py-float-to-scheme val-110))
                                       (py-throw
                                        &py-builtin-NotImplementedError)))
                                 (if (and (py-isinstance?
                                           cls-109
                                           (global-get
                                            %global
                                            (& "type")
                                            (vector-ref %caches 301)))
                                          (py-test (py-call (global-get
                                                             %global
                                                             (& "issubclass")
                                                             (vector-ref
                                                              %caches
                                                              302))
                                                            cls-109
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
                 (set! __bool__-930
                       (procedure->py-function
                        (lambda (self-111)
                          (letrec* ()
                            (if (py-isinstance? self-111 &py-builtin-float)
                                (py-ne self-111 (py-float-from-scheme 0.))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__bool__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-111)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __add__-932
                       (procedure->py-function
                        (lambda (self-112 other-113)
                          (letrec* ()
                            (if (py-isinstance? self-112 &py-builtin-float)
                                (if (py-isinstance?
                                     other-113
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py+ (py-float-to-scheme self-112)
                                          (py-float-to-scheme other-113)))
                                    (if (py-isinstance?
                                         other-113
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py+ (py-float-to-scheme self-112)
                                              (py-int-to-scheme other-113)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 312))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__add__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-112)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __radd__-934
                       (procedure->py-function
                        (lambda (self-114 other-115)
                          (letrec* ()
                            (if (py-isinstance? self-114 &py-builtin-float)
                                (if (py-isinstance?
                                     other-115
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py+ (py-float-to-scheme other-115)
                                          (py-float-to-scheme self-114)))
                                    (if (py-isinstance?
                                         other-115
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py+ (py-int-to-scheme other-115)
                                              (py-float-to-scheme self-114)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 318))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__radd__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-114)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __iadd__-936
                       (procedure->py-function
                        (lambda (self-116 other-117)
                          (letrec* ()
                            (if (py-isinstance? self-116 &py-builtin-float)
                                (if (py-isinstance?
                                     other-117
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py+ (py-float-to-scheme self-116)
                                          (py-float-to-scheme other-117)))
                                    (if (py-isinstance?
                                         self-116
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py+ (py-float-to-scheme self-116)
                                              (py-int-to-scheme other-117)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 324))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__iadd__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-116)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __mul__-938
                       (procedure->py-function
                        (lambda (self-118 other-119)
                          (letrec* ()
                            (if (py-isinstance? self-118 &py-builtin-float)
                                (if (py-isinstance?
                                     other-119
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py* (py-float-to-scheme self-118)
                                          (py-float-to-scheme other-119)))
                                    (if (py-isinstance?
                                         other-119
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py* (py-float-to-scheme self-118)
                                              (py-int-to-scheme other-119)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 330))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__mul__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-118)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rmul__-940
                       (procedure->py-function
                        (lambda (self-120 other-121)
                          (letrec* ()
                            (if (py-isinstance? self-120 &py-builtin-float)
                                (if (py-isinstance?
                                     other-121
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py* (py-float-to-scheme other-121)
                                          (py-float-to-scheme self-120)))
                                    (if (py-isinstance?
                                         other-121
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py* (py-int-to-scheme other-121)
                                              (py-float-to-scheme self-120)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 336))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rmul__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-120)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __imul__-942
                       (procedure->py-function
                        (lambda (self-122 other-123)
                          (letrec* ()
                            (if (py-isinstance? self-122 &py-builtin-float)
                                (if (py-isinstance?
                                     other-123
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py* (py-float-to-scheme self-122)
                                          (py-float-to-scheme other-123)))
                                    (if (py-isinstance?
                                         self-122
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py* (py-float-to-scheme self-122)
                                              (py-int-to-scheme other-123)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 342))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__imul__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-122)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __pow__-944
                       (procedure->py-function
                        (lambda (self-124 other-125)
                          (letrec* ()
                            (if (py-isinstance? self-124 &py-builtin-float)
                                (if (py-isinstance?
                                     other-125
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py** (py-float-to-scheme self-124)
                                           (py-float-to-scheme other-125)))
                                    (if (py-isinstance?
                                         other-125
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py** (py-float-to-scheme self-124)
                                               (py-int-to-scheme other-125)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 348))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__pow__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-124)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rpow__-946
                       (procedure->py-function
                        (lambda (self-126 other-127)
                          (letrec* ()
                            (if (py-isinstance? self-126 &py-builtin-float)
                                (if (py-isinstance?
                                     other-127
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py** (py-float-to-scheme other-127)
                                           (py-float-to-scheme self-126)))
                                    (if (py-isinstance?
                                         other-127
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py** (py-int-to-scheme other-127)
                                               (py-float-to-scheme self-126)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 354))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rpow__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-126)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ipow__-948
                       (procedure->py-function
                        (lambda (self-128 other-129)
                          (letrec* ()
                            (if (py-isinstance? self-128 &py-builtin-float)
                                (if (py-isinstance?
                                     other-129
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py** (py-float-to-scheme self-128)
                                           (py-float-to-scheme other-129)))
                                    (if (py-isinstance?
                                         self-128
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py** (py-float-to-scheme self-128)
                                               (py-int-to-scheme other-129)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 360))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ipow__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-128)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __sub__-950
                       (procedure->py-function
                        (lambda (self-130 other-131)
                          (letrec* ()
                            (if (py-isinstance? self-130 &py-builtin-float)
                                (if (py-isinstance?
                                     other-131
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py- (py-float-to-scheme self-130)
                                          (py-float-to-scheme other-131)))
                                    (if (py-isinstance?
                                         other-131
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py- (py-float-to-scheme self-130)
                                              (py-int-to-scheme other-131)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 366))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__sub__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-130)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rsub__-952
                       (procedure->py-function
                        (lambda (self-132 other-133)
                          (letrec* ()
                            (if (py-isinstance? self-132 &py-builtin-float)
                                (if (py-isinstance?
                                     other-133
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py- (py-float-to-scheme other-133)
                                          (py-float-to-scheme self-132)))
                                    (if (py-isinstance?
                                         other-133
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py- (py-int-to-scheme other-133)
                                              (py-float-to-scheme self-132)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 372))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rsub__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-132)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __isub__-954
                       (procedure->py-function
                        (lambda (self-134 other-135)
                          (letrec* ()
                            (if (py-isinstance? self-134 &py-builtin-float)
                                (if (py-isinstance?
                                     other-135
                                     &py-builtin-float)
                                    (py-float-from-scheme
                                     (py- (py-float-to-scheme self-134)
                                          (py-float-to-scheme other-135)))
                                    (if (py-isinstance?
                                         self-134
                                         &py-builtin-int)
                                        (py-float-from-scheme
                                         (py- (py-float-to-scheme self-134)
                                              (py-int-to-scheme other-135)))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 378))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__isub__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-134)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __pos__-956
                       (procedure->py-function
                        (lambda (self-136)
                          (letrec* ()
                            (if (py-isinstance? self-136 &py-builtin-float)
                                self-136
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__pos__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-136)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __neg__-958
                       (procedure->py-function
                        (lambda (self-137)
                          (letrec* ()
                            (if (py-isinstance? self-137 &py-builtin-float)
                                (py-float-from-scheme
                                 (pyneg (py-float-to-scheme self-137)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__neg__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-137)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __floordiv__-960
                       (procedure->py-function
                        (lambda (self-138 other-139)
                          (letrec* ()
                            (if (py-isinstance? self-138 &py-builtin-float)
                                (if (py-isinstance?
                                     other-139
                                     &py-builtin-float)
                                    (if (py-test (py-ne other-139
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py// (py-float-to-scheme self-138)
                                               (py-float-to-scheme other-139)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float division by zero"))))
                                    (if (py-isinstance?
                                         other-139
                                         &py-builtin-int)
                                        (if (py-test (py-ne other-139
                                                            (py-int-from-scheme
                                                             0)))
                                            (py-float-from-scheme
                                             (py// (py-float-to-scheme
                                                    self-138)
                                                   (py-int-to-scheme
                                                    other-139)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float division by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 393))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__floordiv__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-138)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rfloordiv__-962
                       (procedure->py-function
                        (lambda (self-140 other-141)
                          (letrec* ()
                            (if (py-isinstance? self-140 &py-builtin-float)
                                (if (py-isinstance?
                                     other-141
                                     &py-builtin-float)
                                    (if (py-test (py-ne self-140
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py// (py-float-to-scheme other-141)
                                               (py-float-to-scheme self-140)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float division by zero"))))
                                    (if (py-isinstance?
                                         other-141
                                         &py-builtin-int)
                                        (if (py-test (py-ne self-140
                                                            (py-float-from-scheme
                                                             0.)))
                                            (py-float-from-scheme
                                             (py// (py-int-to-scheme other-141)
                                                   (py-float-to-scheme
                                                    self-140)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float division by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 401))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rfloordiv__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-140)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ifloordiv__-964
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
                                         (py// (py-float-to-scheme self-142)
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
                                             (py// (py-float-to-scheme
                                                    self-142)
                                                   (py-int-to-scheme
                                                    other-143)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float division by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 409))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ifloordiv__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-142)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __truediv__-966
                       (procedure->py-function
                        (lambda (self-144 other-145)
                          (letrec* ()
                            (if (py-isinstance? self-144 &py-builtin-float)
                                (if (py-isinstance?
                                     other-145
                                     &py-builtin-float)
                                    (if (py-test (py-ne other-145
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py/ (py-float-to-scheme self-144)
                                              (py-float-to-scheme other-145)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float division by zero"))))
                                    (if (py-isinstance?
                                         other-145
                                         &py-builtin-int)
                                        (if (py-test (py-ne other-145
                                                            (py-int-from-scheme
                                                             0)))
                                            (py-float-from-scheme
                                             (py/ (py-float-to-scheme self-144)
                                                  (py-int-to-scheme
                                                   other-145)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float division by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 417))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__truediv__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-144)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rtruediv__-968
                       (procedure->py-function
                        (lambda (self-146 other-147)
                          (letrec* ()
                            (if (py-isinstance? self-146 &py-builtin-float)
                                (if (py-isinstance?
                                     other-147
                                     &py-builtin-float)
                                    (if (py-test (py-ne self-146
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py/ (py-float-to-scheme other-147)
                                              (py-float-to-scheme self-146)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float division by zero"))))
                                    (if (py-isinstance?
                                         other-147
                                         &py-builtin-int)
                                        (if (py-test (py-ne self-146
                                                            (py-float-from-scheme
                                                             0.)))
                                            (py-float-from-scheme
                                             (py/ (py-int-to-scheme other-147)
                                                  (py-float-to-scheme
                                                   self-146)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float division by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 425))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rtruediv__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-146)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __itruediv__-970
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
                                         (py/ (py-float-to-scheme self-148)
                                              (py-float-to-scheme other-149)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float division by zero"))))
                                    (if (py-isinstance?
                                         other-149
                                         &py-builtin-int)
                                        (if (py-test (py-ne other-149
                                                            (py-int-from-scheme
                                                             0)))
                                            (py-float-from-scheme
                                             (py/ (py-float-to-scheme self-148)
                                                  (py-int-to-scheme
                                                   other-149)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float division by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 433))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__itruediv__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-148)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __mod__-972
                       (procedure->py-function
                        (lambda (self-150 other-151)
                          (letrec* ()
                            (if (py-isinstance? self-150 &py-builtin-float)
                                (if (py-isinstance?
                                     other-151
                                     &py-builtin-float)
                                    (if (py-test (py-ne other-151
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py% (py-float-to-scheme self-150)
                                              (py-float-to-scheme other-151)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float modulo by zero"))))
                                    (if (py-isinstance?
                                         other-151
                                         &py-builtin-int)
                                        (if (py-test (py-ne other-151
                                                            (py-int-from-scheme
                                                             0)))
                                            (py-float-from-scheme
                                             (py% (py-float-to-scheme self-150)
                                                  (py-int-to-scheme
                                                   other-151)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float modulo by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 441))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__mod__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-150)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rmod__-974
                       (procedure->py-function
                        (lambda (self-152 other-153)
                          (letrec* ()
                            (if (py-isinstance? self-152 &py-builtin-float)
                                (if (py-isinstance?
                                     other-153
                                     &py-builtin-float)
                                    (if (py-test (py-ne self-152
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py% (py-float-to-scheme other-153)
                                              (py-float-to-scheme self-152)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float modulo by zero"))))
                                    (if (py-isinstance?
                                         other-153
                                         &py-builtin-int)
                                        (if (py-test (py-ne self-152
                                                            (py-float-from-scheme
                                                             0.)))
                                            (py-float-from-scheme
                                             (py% (py-int-to-scheme other-153)
                                                  (py-float-to-scheme
                                                   self-152)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float modulo by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 449))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rmod__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-152)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __imod__-976
                       (procedure->py-function
                        (lambda (self-154 other-155)
                          (letrec* ()
                            (if (py-isinstance? self-154 &py-builtin-float)
                                (if (py-isinstance?
                                     other-155
                                     &py-builtin-float)
                                    (if (py-test (py-ne other-155
                                                        (py-float-from-scheme
                                                         0.)))
                                        (py-float-from-scheme
                                         (py% (py-float-to-scheme self-154)
                                              (py-float-to-scheme other-155)))
                                        (py-throw
                                         (py-call &py-builtin-ZeroDivisionError
                                                  (&& "float modulo by zero"))))
                                    (if (py-isinstance?
                                         other-155
                                         &py-builtin-int)
                                        (if (py-test (py-ne other-155
                                                            (py-int-from-scheme
                                                             0)))
                                            (py-float-from-scheme
                                             (py% (py-float-to-scheme self-154)
                                                  (py-int-to-scheme
                                                   other-155)))
                                            (py-throw
                                             (py-call &py-builtin-ZeroDivisionError
                                                      (&& "float modulo by zero"))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 457))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__imod__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-154)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __eq__-978
                       (procedure->py-function
                        (lambda (self-156 other-157)
                          (letrec* ()
                            (if (py-isinstance? self-156 &py-builtin-float)
                                (if (py-isinstance?
                                     other-157
                                     &py-builtin-float)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py== (py-float-to-scheme self-156)
                                            (py-float-to-scheme other-157))))
                                    (if (py-isinstance?
                                         other-157
                                         &py-builtin-int)
                                        (py-bool-from-scheme-bool
                                         (py-test-from-scheme
                                          (py== (py-float-to-scheme self-156)
                                                (py-int-to-scheme other-157))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 463))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__eq__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-156)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ne__-980
                       (procedure->py-function
                        (lambda (self-158 other-159)
                          (letrec* ()
                            (if (py-isinstance? self-158 &py-builtin-float)
                                (if (py-isinstance?
                                     other-159
                                     &py-builtin-float)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py!= (py-float-to-scheme self-158)
                                            (py-float-to-scheme other-159))))
                                    (if (py-isinstance?
                                         other-159
                                         &py-builtin-int)
                                        (py-bool-from-scheme-bool
                                         (py-test-from-scheme
                                          (py!= (py-float-to-scheme self-158)
                                                (py-int-to-scheme other-159))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 469))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ne__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-158)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ge__-982
                       (procedure->py-function
                        (lambda (self-160 other-161)
                          (letrec* ()
                            (if (py-isinstance? self-160 &py-builtin-float)
                                (if (py-isinstance?
                                     other-161
                                     &py-builtin-float)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py>= (py-float-to-scheme self-160)
                                            (py-float-to-scheme other-161))))
                                    (if (py-isinstance?
                                         other-161
                                         &py-builtin-int)
                                        (py-bool-from-scheme-bool
                                         (py-test-from-scheme
                                          (py>= (py-float-to-scheme self-160)
                                                (py-int-to-scheme other-161))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 475))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ge__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-160)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __gt__-984
                       (procedure->py-function
                        (lambda (self-162 other-163)
                          (letrec* ()
                            (if (py-isinstance? self-162 &py-builtin-float)
                                (if (py-isinstance?
                                     other-163
                                     &py-builtin-float)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py> (py-float-to-scheme self-162)
                                           (py-float-to-scheme other-163))))
                                    (if (py-isinstance?
                                         other-163
                                         &py-builtin-int)
                                        (py-bool-from-scheme-bool
                                         (py-test-from-scheme
                                          (py> (py-float-to-scheme self-162)
                                               (py-int-to-scheme other-163))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 481))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__gt__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-162)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __le__-986
                       (procedure->py-function
                        (lambda (self-164 other-165)
                          (letrec* ()
                            (if (py-isinstance? self-164 &py-builtin-float)
                                (if (py-isinstance?
                                     other-165
                                     &py-builtin-float)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py<= (py-float-to-scheme self-164)
                                            (py-float-to-scheme other-165))))
                                    (if (py-isinstance?
                                         other-165
                                         &py-builtin-int)
                                        (py-bool-from-scheme-bool
                                         (py-test-from-scheme
                                          (py<= (py-float-to-scheme self-164)
                                                (py-int-to-scheme other-165))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 487))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__le__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-164)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __lt__-988
                       (procedure->py-function
                        (lambda (self-166 other-167)
                          (letrec* ()
                            (if (py-isinstance? self-166 &py-builtin-float)
                                (if (py-isinstance?
                                     other-167
                                     &py-builtin-float)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py< (py-float-to-scheme self-166)
                                           (py-float-to-scheme other-167))))
                                    (if (py-isinstance?
                                         other-167
                                         &py-builtin-int)
                                        (py-bool-from-scheme-bool
                                         (py-test-from-scheme
                                          (py< (py-float-to-scheme self-166)
                                               (py-int-to-scheme other-167))))
                                        (global-get
                                         %global
                                         (& "NotImplemented")
                                         (vector-ref %caches 493))))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__lt__' requires a 'float' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-166)
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
                        __lt__-988
                        (& "__le__")
                        __le__-986
                        (& "__gt__")
                        __gt__-984
                        (& "__ge__")
                        __ge__-982
                        (& "__ne__")
                        __ne__-980
                        (& "__eq__")
                        __eq__-978
                        (& "__imod__")
                        __imod__-976
                        (& "__rmod__")
                        __rmod__-974
                        (& "__mod__")
                        __mod__-972
                        (& "__itruediv__")
                        __itruediv__-970
                        (& "__rtruediv__")
                        __rtruediv__-968
                        (& "__truediv__")
                        __truediv__-966
                        (& "__ifloordiv__")
                        __ifloordiv__-964
                        (& "__rfloordiv__")
                        __rfloordiv__-962
                        (& "__floordiv__")
                        __floordiv__-960
                        (& "__neg__")
                        __neg__-958
                        (& "__pos__")
                        __pos__-956
                        (& "__isub__")
                        __isub__-954
                        (& "__rsub__")
                        __rsub__-952
                        (& "__sub__")
                        __sub__-950
                        (& "__ipow__")
                        __ipow__-948
                        (& "__rpow__")
                        __rpow__-946
                        (& "__pow__")
                        __pow__-944
                        (& "__imul__")
                        __imul__-942
                        (& "__rmul__")
                        __rmul__-940
                        (& "__mul__")
                        __mul__-938
                        (& "__iadd__")
                        __iadd__-936
                        (& "__radd__")
                        __radd__-934
                        (& "__add__")
                        __add__-932
                        (& "__bool__")
                        __bool__-930
                        (& "__new__")
                        __new__-927))
                 $%cls_2))))
     (set! &py-builtin-str
           (let (($%cls_3 py-absent))
             (letrec* ((__lt__-1342 #f)
                       (__le__-1340 #f)
                       (__gt__-1338 #f)
                       (__ge__-1336 #f)
                       (__ne__-1334 #f)
                       (__eq__-1332 #f)
                       (__rmul__-1330 #f)
                       (__mul__-1328 #f)
                       (__add__-1326 #f)
                       (__len__-1324 #f))
               (begin
                 (set! __len__-1324
                       (procedure->py-function
                        (lambda (self-168)
                          (letrec* ()
                            (if (py-isinstance? self-168 &py-builtin-str)
                                (py-int-from-scheme
                                 (py-str-len-to-scheme self-168))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__len__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-168)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self))))
                 (set! __add__-1326
                       (procedure->py-function
                        (lambda (self-169 other-170)
                          (letrec* ()
                            (if (py-isinstance? self-169 &py-builtin-str)
                                (if (py-isinstance? other-170 &py-builtin-str)
                                    (py-str-from-scheme
                                     (py+ (py-str-to-scheme self-169)
                                          (py-str-to-scheme other-170)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 502)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__add__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-169)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __mul__-1328
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
                                     (vector-ref %caches 507)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__mul__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-171)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __rmul__-1330
                       (procedure->py-function
                        (lambda (self-173 other-174)
                          (letrec* ()
                            (if (py-isinstance? self-173 &py-builtin-str)
                                (if (py-isinstance? other-174 &py-builtin-int)
                                    (py-str-from-scheme
                                     (py* (py-str-to-scheme self-173)
                                          (py-int-to-scheme other-174)))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 512)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__rmul__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-173)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __eq__-1332
                       (procedure->py-function
                        (lambda (self-175 other-176)
                          (letrec* ()
                            (if (py-isinstance? self-175 &py-builtin-str)
                                (if (py-isinstance? other-176 &py-builtin-str)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py== (py-str-to-scheme self-175)
                                            (py-str-to-scheme other-176))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 517)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__eq__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-175)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ne__-1334
                       (procedure->py-function
                        (lambda (self-177 other-178)
                          (letrec* ()
                            (if (py-isinstance? self-177 &py-builtin-str)
                                (if (py-isinstance? other-178 &py-builtin-str)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py!= (py-str-to-scheme self-177)
                                            (py-str-to-scheme other-178))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 522)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ne__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-177)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __ge__-1336
                       (procedure->py-function
                        (lambda (self-179 other-180)
                          (letrec* ()
                            (if (py-isinstance? self-179 &py-builtin-str)
                                (if (py-isinstance? other-180 &py-builtin-str)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py>= (py-str-to-scheme self-179)
                                            (py-str-to-scheme other-180))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 527)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__ge__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-179)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __gt__-1338
                       (procedure->py-function
                        (lambda (self-181 other-182)
                          (letrec* ()
                            (if (py-isinstance? self-181 &py-builtin-str)
                                (if (py-isinstance? other-182 &py-builtin-str)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py> (py-str-to-scheme self-181)
                                           (py-str-to-scheme other-182))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 532)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__gt__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-181)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __le__-1340
                       (procedure->py-function
                        (lambda (self-183 other-184)
                          (letrec* ()
                            (if (py-isinstance? self-183 &py-builtin-str)
                                (if (py-isinstance? other-184 &py-builtin-str)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py<= (py-str-to-scheme self-183)
                                            (py-str-to-scheme other-184))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 537)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__le__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-183)
                                                           (& "__name__")))
                                                  (&& "'")))))))
                        (make-signature args: (self other))))
                 (set! __lt__-1342
                       (procedure->py-function
                        (lambda (self-185 other-186)
                          (letrec* ()
                            (if (py-isinstance? self-185 &py-builtin-str)
                                (if (py-isinstance? other-186 &py-builtin-str)
                                    (py-bool-from-scheme-bool
                                     (py-test-from-scheme
                                      (py< (py-str-to-scheme self-185)
                                           (py-str-to-scheme other-186))))
                                    (global-get
                                     %global
                                     (& "NotImplemented")
                                     (vector-ref %caches 542)))
                                (py-throw
                                 (py-call &py-builtin-TypeError
                                          (py-add (py-add (&& "descriptor '__lt__' requires a 'str' object but received a '")
                                                          (py-getattribute
                                                           (py-obj-cls
                                                            self-185)
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
                        __lt__-1342
                        (& "__le__")
                        __le__-1340
                        (& "__gt__")
                        __gt__-1338
                        (& "__ge__")
                        __ge__-1336
                        (& "__ne__")
                        __ne__-1334
                        (& "__eq__")
                        __eq__-1332
                        (& "__rmul__")
                        __rmul__-1330
                        (& "__mul__")
                        __mul__-1328
                        (& "__add__")
                        __add__-1326
                        (& "__len__")
                        __len__-1324))
                 $%cls_3))))
     (set! &py-builtin-range_iterator
           (let (($%cls_4 py-absent))
             (letrec* ((__next__-1440 #f) (__iter__-1438 #f) (__new__-1436 #f))
               (begin
                 (set! __new__-1436
                       (procedure->py-function
                        (lambda (args-187)
                          (letrec* ()
                            (py-throw
                             (py-call &py-builtin-ValueError
                                      (&& "cannot create 'range_iterator' instances")))))
                        (make-signature vararg: args)))
                 (set! __iter__-1438
                       (procedure->py-function
                        (lambda (self-188) (letrec* () self-188))
                        (make-signature posonlyargs: (self))))
                 (set! __next__-1440
                       (procedure->py-function
                        (lambda (self-189)
                          (bind-exit
                           ($%return_75)
                           (letrec* ((step-1447 #f)
                                     (stop-1445 #f)
                                     (start-1442 #f))
                             (begin
                               (set! start-1442
                                     (PyObjectRangeIterator-start self-189))
                               (set! stop-1445
                                     (PyObjectRangeIterator-stop self-189))
                               (set! step-1447
                                     (PyObjectRangeIterator-step self-189))
                               (if (py-test (py-lt step-1447
                                                   (py-int-from-scheme 0)))
                                   (if (py-test (py-gt start-1442 stop-1445))
                                       (begin
                                         (PyObjectRangeIterator-start-set!
                                          self-189
                                          (py-add start-1442 step-1447))
                                         ($%return_75 start-1442))
                                       #f)
                                   (if (py-test (py-lt start-1442 stop-1445))
                                       (begin
                                         (PyObjectRangeIterator-start-set!
                                          self-189
                                          (py-add start-1442 step-1447))
                                         ($%return_75 start-1442))
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
                        __next__-1440
                        (& "__iter__")
                        __iter__-1438
                        (& "__new__")
                        __new__-1436))
                 $%cls_4))))
     (set! &py-builtin-range
           (let (($%cls_5 py-absent))
             (letrec* ((__repr__-1461 #f)
                       (__iter__-1459 #f)
                       (__contains__-1457 #f)
                       (__len__-1455 #f)
                       (__new__-1452 #f))
               (begin
                 (set! __new__-1452
                       (procedure->py-function
                        (lambda (cls-190 arg1-191 arg2-192 arg3-193)
                          (letrec* ()
                            (if (py-test (py-is cls-190 &py-builtin-range))
                                (if (py-test (py-isnot arg3-193 py-absent))
                                    (make-PyObjectRange
                                     py-range-hclass-of-instances
                                     '#()
                                     py-builtin-range
                                     arg1-191
                                     arg2-192
                                     arg3-193)
                                    (if (py-test (py-isnot arg2-192 py-absent))
                                        (make-PyObjectRange
                                         py-range-hclass-of-instances
                                         '#()
                                         py-builtin-range
                                         arg1-191
                                         arg2-192
                                         (py-int-from-scheme 1))
                                        (make-PyObjectRange
                                         py-range-hclass-of-instances
                                         '#()
                                         py-builtin-range
                                         (py-int-from-scheme 0)
                                         arg1-191
                                         (py-int-from-scheme 1))))
                                (if (and (py-isinstance?
                                          cls-190
                                          (global-get
                                           %global
                                           (& "type")
                                           (vector-ref %caches 550)))
                                         (py-test (py-call (global-get
                                                            %global
                                                            (& "issubclass")
                                                            (vector-ref
                                                             %caches
                                                             551))
                                                           cls-190
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
                 (set! __len__-1455
                       (procedure->py-function
                        (lambda (self-194)
                          (letrec* ()
                            (py-floordiv
                             (py-sub (PyObjectRange-stop self-194)
                                     (PyObjectRange-start self-194))
                             (PyObjectRange-step self-194))))
                        (make-signature posonlyargs: (self))))
                 (set! __contains__-1457
                       (procedure->py-function
                        (lambda (self-195 item-196)
                          (bind-exit
                           ($%return_76)
                           (letrec* ((step-1479 #f)
                                     (stop-1477 #f)
                                     (start-1474 #f))
                             (begin
                               (set! start-1474 (PyObjectRange-start self-195))
                               (set! stop-1477 (PyObjectRange-stop self-195))
                               (set! step-1479 (PyObjectRange-step self-195))
                               (if (py-test (py-lt step-1479
                                                   (py-int-from-scheme 0)))
                                   (if (or (py-test (py-ge stop-1477 item-196))
                                           (py-test (py-gt item-196
                                                           start-1474)))
                                       ($%return_76 py-False)
                                       #f)
                                   (if (or (py-test (py-gt start-1474
                                                           item-196))
                                           (py-test (py-ge item-196
                                                           stop-1477)))
                                       ($%return_76 py-False)
                                       #f))
                               (py-eq (py-mod (py-sub item-196 start-1474)
                                              step-1479)
                                      (py-int-from-scheme 0))))))
                        (make-signature posonlyargs: (self item))))
                 (set! __iter__-1459
                       (procedure->py-function
                        (lambda (self-197)
                          (letrec* ()
                            (make-PyObjectRangeIterator
                             py-range_iterator-hclass-of-instances
                             '#()
                             py-builtin-range_iterator
                             (PyObjectRange-start self-197)
                             (PyObjectRange-stop self-197)
                             (PyObjectRange-step self-197))))
                        (make-signature posonlyargs: (self))))
                 (set! __repr__-1461
                       (procedure->py-function
                        (lambda (self-198)
                          (letrec* ((step-1468 #f)
                                    (stop-1466 #f)
                                    (start-1463 #f))
                            (begin
                              (set! start-1463 (PyObjectRange-start self-198))
                              (set! stop-1466 (PyObjectRange-stop self-198))
                              (set! step-1468 (PyObjectRange-step self-198))
                              (if (py-test (py-eq step-1468
                                                  (py-int-from-scheme 1)))
                                  (py-add (py-add (py-add (py-add (&& "range(")
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                          (py-call &py-builtin-str start-1463))
                  (&& ", "))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                  (py-call &py-builtin-str
                                                           stop-1466))
                                          (&& ")"))
                                  (py-add (py-add (py-add (py-add (py-add (py-add (&& "range(")
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                                          (py-call &py-builtin-str start-1463))
                                  (&& ", "))
                          (py-call &py-builtin-str stop-1466))
                  (&& ", "))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                  (py-call &py-builtin-str
                                                           step-1468))
                                          (&& ")"))))))
                        (make-signature args: (self)))))
               (begin
                 (set! $%cls_5
                       (py-make-builtin-class
                        (&& "range")
                        (&& "__main__")
                        (list)
                        (& "__repr__")
                        __repr__-1461
                        (& "__iter__")
                        __iter__-1459
                        (& "__contains__")
                        __contains__-1457
                        (& "__len__")
                        __len__-1455
                        (& "__new__")
                        __new__-1452))
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
             (letrec* ((__str__-1521 #f) (__init__-1519 #f))
               (begin
                 (set! __init__-1519
                       (procedure->py-function
                        (lambda (self-206 args-207)
                          (letrec* ()
                            (begin
                              (py-setattribute
                               (or self-206
                                   (py-throw-exception-with-message
                                    py-builtin-UnboundLocalError
                                    "local variable 'self' referenced before assignment"))
                               (& "args")
                               (or args-207
                                   (py-throw-exception-with-message
                                    py-builtin-UnboundLocalError
                                    "local variable 'args' referenced before assignment")))
                              py-None)))
                        (make-signature args: (self) vararg: args)))
                 (set! __str__-1521
                       (procedure->py-function
                        (lambda (self-208)
                          (letrec* ((args_len-1526 #f) (args-1523 #f))
                            (begin
                              (set! args-1523
                                    (py-getattribute self-208 (& "args")))
                              (set! args_len-1526
                                    (py-call (global-get
                                              %global
                                              (& "len")
                                              (vector-ref %caches 599))
                                             (py-getattribute
                                              self-208
                                              (& "args"))))
                              (if (py-test (py-eq args_len-1526
                                                  (py-int-from-scheme 0)))
                                  (&& "")
                                  (if (py-test (py-eq args_len-1526
                                                      (py-int-from-scheme 1)))
                                      (py-call &py-builtin-str
                                               (py-getitem
                                                args-1523
                                                (py-int-from-scheme 0)))
                                      (py-call &py-builtin-str args-1523))))))
                        (make-signature args: (self)))))
               (begin
                 (set! $%cls_6
                       (py-make-builtin-class
                        (&& "BaseException")
                        (&& "__main__")
                        (list)
                        (& "__str__")
                        __str__-1521
                        (& "__init__")
                        __init__-1519))
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
     (let ((caches (py-make-caches 735))
           (module (py-make-module name package __path__)))
       (begin)
       (py-module module caches)
       module))
   (py-end-module)))

