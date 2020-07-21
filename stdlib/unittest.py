
class TestCase():
    def __init__(self):
        self._reset()

    def _reset(self):
        self.assert_count = 0
        self.message = ""
        self.long_message = ""

    is_testcase = True

    def _assert(self, comparison_func, name):
        self.assert_count += 1
        if not(comparison_func()):
            self.message = "FAIL"
            self.long_message += "  " + repr(self.assert_count) + " " + repr(name) + " FAILLED\n"

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
                    self.message = "An error was raised : " + repr(e)

            if self.message == "":
                success += 1
                self.message = "OK"

            print(func_name, ":", self.message)
            if self.long_message != "":
                print(self.long_message)

        print()
        print("success :", success)
        print("not implemented :", not_implemented)
        print("total :", total)
        if success == total:
            print("PASS | ", total, "tests passed ! yay !")
        else:
            print("FAIL |", total, "tests runned. PASSED =", success, "   FAILLED =", repr(total-success))

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

    def assertLogs(self, logger=None, level=None):
        self._notImplemented("assertLogs")
    def assertSequenceEqual(self, seq1, seq2, msg=None, seq_type=None):
        self._notImplemented("assertSequenceEqual")
    def assertListEqual(self, list1, list2, msg=None):
        self._notImplemented("assertListEqual")
    def assertTupleEqual(self, tuple1, tuple2, msg=None):
        self._notImplemented("assertTupleEqual")
    def assertSetEqual(self, set1, set2, msg=None):
        self._notImplemented("assertSetEqual")
    def assertDictEqual(self, d1, d2, msg=None):
        self._notImplemented("assertDictEqual")
    def assertDictContainsSubset(self, subset, dictionary, msg=None):
        self._notImplemented("assertDictContainsSubset")
    def assertCountEqual(self, first, second, msg=None):
        self._notImplemented("assertCountEqual")
    def assertMultiLineEqual(self, first, second, msg=None):
        self._notImplemented("assertMultiLineEqual")
    def assertLess(self, a, b, msg=None):
        self._notImplemented("assertLess")
    def assertLessEqual(self, a, b, msg=None):
        self._notImplemented("assertLessEqual")
    def assertGreater(self, a, b, msg=None):
        self._notImplemented("assertGreater")
    def assertGreaterEqual(self, a, b, msg=None):
        self._notImplemented("assertGreaterEqual")
    def assertIsNone(self, obj, msg=None):
        self._notImplemented("assertIsNone")
    def assertIsNotNone(self, obj, msg=None):
        self._notImplemented("assertIsNotNone")
    def assertIsInstance(self, obj, cls, msg=None):
        self._notImplemented("assertIsInstance")
    def assertNotIsInstance(self, obj, cls, msg=None):
        self._notImplemented("assertNotIsInstance")
    def assertRegex(self, text, expected_regex, msg=None):
        self._notImplemented("assertRegex")
    def assertNotRegex(self, text, unexpected_regex, msg=None):
        self._notImplemented("assertNotRegex")
    def assertAlmostEqual(self, first, second, places=None, msg=None, delta=None):
        self._notImplemented("assertAlmostEqual")
    def assertNotAlmostEqual(self, first, second, places=None, msg=None, delta=None):
        self._notImplemented("assertNotAlmostEqual")
    #real signature with **kwargs
    def assertRaises(self, expected_exception, *args):
        self._notImplemented("assertRaises")
    #real signature with **kwargs
    def assertWarns(self, expected_warning, *args):
        self._notImplemented("assertWarns")
    #real signature with **kwargs
    def assertRaisesRegex(self, expected_exception, expected_regex, *args):
        self._notImplemented("assertRaisesRegex")
    #real signature with **kwargs
    def assertWarnsRegex(self, expected_warning, expected_regex, *args):
        self._notImplemented("assertWarnRegex")

def _run_test(obj_type):
    instance = obj_type()
    arr = []
    excluded_methods = []#"test_sane_len", "test_non_numeric_input_types", "test_int_subclass_with_index"]
    for method_name in dir(instance):
        # name is testSOMETHING
        if "test" < method_name and method_name < "tesu" \
                and method_name not in excluded_methods:
            arr.append(method_name)
    instance.run(arr)

def main():
    import sys
    selfmod = sys.modules["__main__"]
    for class_name in dir(selfmod):
        _o = getattr(selfmod, class_name)
        try:
            #if the test didn't crash, this means that _o is a TestCase object
            #as it has an is_testcase object
            getattr(_o, "is_testcase")
            print("running ", class_name)
            _run_test(_o)
        except AttributeError:
            pass
