class TestCase():
    class _AssertRaise():
        def __init__(self, exc):
            self.exc = exc

        def __enter__(self):
            return self

        def __exit__(self, exc_type, exc_value, tb):
            if exc_type is None:
                exc_name = str(self.exc)
                self._fail(exc_name + " not raised")
            elif not isinstance(exc_value, self.exc):
                self._fail(str(self.exc) + " does not match " + str(exc_value))

    is_testcase = True

    def __init__(self):
        self._reset()

    def _reset(self):
        self.assert_count = 0
        self.message = ""
        self.long_message = ""

    def _fail(self, msg):
        self.message = "FAIL"
        self.long_message += "  " + repr(self.assert_count) + " " + msg + "\n"

    def _assert(self, comparison_func, name):
        self.assert_count += 1
        if not(comparison_func()):
            self._fail(str(name) + " FAILED")

    def _assertType(self, obj1, obj2, expected_type, name):
        if not (type(obj1) == type(obj2) and type(obj2) == expected_type):
            self._fail(str(name) + " FAILED")

    def _notImplemented(self, msg):
        self.message = "the assert function " +  msg + " is not implemented"
        raise NotImplementedError

    def run(self, func_list):
        success = 0
        not_implemented = 0
        total = len(func_list)
        for func_name in func_list:
            self._reset()

            func = getattr(self, func_name)
            try:
                func()
            except NotImplementedError:
                not_implemented+=1
                if self.message == "":
                    self.message = "NotImplementedError raised"
            except Exception as e:
                if self.message == "":
                    self.message = "An error was raised : " + str(e)

            if self.message == "":
                success += 1
                self.message = "OK"

            if total != 1:
                print(func_name, ":", self.message)
                if self.long_message != "":
                    print(self.long_message)

        if total != 1:
            print("success :", success)
            print("not implemented :", not_implemented)
            print("total :", total)
        else:
            print(self.message)
            print(self.long_message)
        if success == total:
            print("PASS")
        else:
            print("FAIL")

    def assertFalse(self, expr, msg=None):
        self._assert(lambda: expr, "assertFalse")
    def assertTrue(self, expr, msg=None):
        self._assert(lambda: not expr, "assertTrue")
    def assertEqual(self, first, second, msg=None):
        self._assert(lambda: first == second, "assertEqual")
    def assertNotEqual(self, first, second, msg=None):
        self._assert(lambda: first != second, "assertEqual")
    def assertIn(self, member, container, msg=None):
        self._assert(lambda: member in container, "assertIn")
    def assertNotIn(self, member, container, msg=None):
        self._assert(lambda: member not in container, "assertNotIn")
    def assertIs(self, expr1, expr2, msg=None):
        self._assert(lambda: expr1 is expr2,"assertIs")
    def assertIsNot(self, expr1, expr2, msg=None):
        self._assert(lambda: expr1 is not expr2,"assertIsNot")
    def assertListEqual(self, list1, list2, msg=None):
        self._assertType(list1, list2, list, "assertListEqual")
        self._assert(lambda: list1 == lise2, "assertListEqual")
    def assertTupleEqual(self, tuple1, tuple2, msg=None):
        self._assertType(tuple1, tuple2, tuple, "assertTupleEqual")
        self._assert(lambda: tuple1 == tuple2, "assertTupleEqual")
    def assertSetEqual(self, set1, set2, msg=None):
        self._assertType(set1, set2, set, "assertSetEqual")
        self._assert(lambda: set1 == set2, "assertSetEqual")
    def assertDictEqual(self, d1, d2, msg=None):
        self._assertType(d1, d2, dict, "assertDictEqual")
        self._assert(lambda: d1 == d2, "assertDictEqual")
    def assertLess(self, a, b, msg=None):
        self._assert(lambda: a < b, "assertLess")
    def assertLessEqual(self, a, b, msg=None):
        self._assert(lambda: a <= b, "assertLessEqual")
    def assertGreater(self, a, b, msg=None):
        self._assert(lambda: a > b, "assertGreater")
    def assertGreaterEqual(self, a, b, msg=None):
        self._assert(lambda: a >= b, "assertGreaterEqual")
    def assertIsNone(self, obj, msg=None):
        self._assert(lambda: a is None, "assertIsNone")
    def assertIsNotNone(self, obj, msg=None):
        self._assert(lambda: a is not None, "assertIsNotNone")
    # not quite the same implementation : https://github.com/python/cpython/blob/63298930fb531ba2bb4f23bc3b915dbf1e17e9e1/Lib/unittest/case.py#L1169
    def assertCountEqual(self, first, second, msg=None):
        self._assert(lambda: len(list(first)) == len(list(second)), "assertCountEqual")
    def assertIsInstance(self, obj, cls, msg=None):
        self._assert(lambda: isinstance(obj, cls), "assertIsInstance")
    def assertIsNotInstance(self, obj, cls, msg=None):
        self._assert(lambda: not isinstance(obj, cls), "assertIsNotInstance")
    def assertAlmostEqual(self, first, second, places=None, msg=None, delta=None):
        # code taken in part from https://github.com/python/cpython/blob/63298930fb531ba2bb4f23bc3b915dbf1e17e9e1/Lib/unittest/case.py#L850
        if delta is not None and places is not None:
            raise TypeError("specify delta or places not both")

        diff = abs(first - second)
        if delta is not None:
            self._assert(diff <= delta, "assertAlmostEqual")
        else:
            if places is None:
                places = 7

            self._assert(round(diff, places), "assertAlmostEqual")
    def assertNotAlmostEqual(self, first, second, places=None, msg=None, delta=None):
        if delta is not None and places is not None:
            raise TypeError("specify delta or places not both")

        diff = abs(first - second)
        if delta is not None:
            self._assert(diff <= delta, "assertAlmostEqual")
        else:
            if places is None:
                places = 7

            self._assert(round(diff, places), "assertAlmostEqual")

    def assertLogs(self, logger=None, level=None):
        self._notImplemented("assertLogs")
    def assertSequenceEqual(self, seq1, seq2, msg=None, seq_type=None):
        self._notImplemented("assertSequenceEqual")
    def assertDictContainsSubset(self, subset, dictionary, msg=None):
        self._notImplemented("assertDictContainsSubset")
    def assertMultiLineEqual(self, first, second, msg=None):
        self._notImplemented("assertMultiLineEqual")
    def assertRegex(self, text, expected_regex, msg=None):
        self._notImplemented("assertRegex")
    def assertNotRegex(self, text, unexpected_regex, msg=None):
        self._notImplemented("assertNotRegex")
    #real signature with **kwargs
    def assertRaises(self, expected_exception, *args, **kwargs):
        # Checks if no arguments are given. In this case, it is used as a with handler
        if not args and ("msg" in kwargs) == len(kwargs):
            return self._AssertRaise(expected_exception)
        else:
            with self._AssertRaise(expected_exception):
                print(args)
                object_to_call = args[0]
                args = args[1:]
                print(object_to_call)
                print(args)
                object_to_call(*args)

    #real signature with **kwargs
    def assertWarns(self, expected_warning, *args):
        self._notImplemented("assertWarns")
    #real signature with **kwargs
    def assertRaisesRegex(self, expected_exception, expected_regex, *args):
        self._notImplemented("assertRaisesRegex")
    #real signature with **kwargs
    def assertWarnsRegex(self, expected_warning, expected_regex, *args):
        self._notImplemented("assertWarnRegex")

def _get_tests_to_run_from_instance(instance):
    arr = []
    for method_name in dir(instance):
        # name is testSOMETHING
        if "test" < method_name and method_name < "tesu":
            arr.append(method_name)
    return arr

def _display_test_cases(class_instance, show_class = False):
    try:
        #if the test didn't crash, this means that _o is a TestCase object
        #as it has an is_testcase object
        getattr(class_instance, "is_testcase")
        instance = class_instance()
        instance_tests = _get_tests_to_run_from_instance(instance)

        for i in instance_tests:
            if show_class:
                print(class_instance.__name__, i)
            else:
                print(i)

    except AttributeError:
        pass


# second entry point
def _run_tests(class_instance):
    sys = __import__("sys")

    if len(sys.argv) == 2:
        if sys.argv[1] == "print_tests":
            print("success")
            _display_test_cases(class_instance)
        elif sys.argv[1] == "run_all_tests":
            instance = class_instance()
            all_tests = _get_tests_to_run_from_instance(instance)
            instance.run(all_tests)

    if len(sys.argv) >= 3 and sys.argv[1] == "run_test":
        selfmod = sys.modules["__main__"]
        try:
            getattr(class_instance, "is_testcase")

            class_instance().run([sys.argv[2]])
        except AttributeError:
            pass

def main():
    sys = __import__("sys")

    if len(sys.argv) == 2:
        selfmod = sys.modules["__main__"]
        if sys.argv[1] == "print_tests":
            print("success")
            for class_name in dir(selfmod):
                try:
                    class_instance = getattr(selfmod, class_name)
                    _display_test_cases(class_instance, True)

                except AttributeError:
                    pass

        elif sys.argv[1] == "run_all_tests":
            for class_name in dir(selfmod):
                try:
                    class_instance = getattr(selfmod, class_name)
                    getattr(class_instance, 'is_testcase')
                    instance = class_instance()
                    all_tests = _get_tests_to_run_from_instance(instance)
                    instance.run(all_tests)

                except AttributeError:
                    pass

    if len(sys.argv) >= 4 and sys.argv[1] == "run_test":
        selfmod = sys.modules["__main__"]
        try:
            _o = getattr(selfmod, sys.argv[2])
            getattr(_o, "is_testcase")

            _o().run([sys.argv[3]])
        except AttributeError:
            pass



