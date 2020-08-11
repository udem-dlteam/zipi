# _unit_tests.py

from io import StringIO
from contextlib import redirect_stdout

# For Python tests
_tests = []


class Test:
    def __init__(self, result, *args):
        self.args = tuple(arg for arg in args)
        self.result = result


class Equals(Test):
    def __call__(self, f):

        def _f(*args):
            try:

                # Hijack print
                # buf = StringIO()
                with StringIO() as buf, redirect_stdout(buf):
                    res = f(*self.args)
                    if res is None:
                        res = buf.getvalue()

                if res == self.result:
                    print("Test '" + f.__name__ + "' passed.")
                    return True
                else:
                    print("Test '" + f.__name__ + "' FAILED.")
                    print(res)
                    return False
            except Exception as e:
                print("Failed to execute test '" + f.__name__ + "'.")
                print("Exception: " + str(e))
                return False

        _tests.append(_f)

        return _f


class Is(Test):
    def __call__(self, f):

        def _f(*args):
            try:
                res = f(*self.args)
                if res is self.result:
                    print("Test '" + f.__name__ + "' passed.")
                    return True
                else:
                    print("Test '" + f.__name__ + "' FAILED.")
                    return False
            except Exception as e:
                print("Failed to execute test '" + f.__name__ + "'.")
                print("Exception: " + str(e))
                return False

        _tests.append(_f)

        return _f


class IsInstance(Test):
    def __call__(self, f):

        def _f(*args):
            try:
                res = f(*self.args)
                if isinstance(res, self.result):
                    print("Test '" + f.__name__ + "' passed.")
                    return True
                else:
                    print("Test '" + f.__name__ + "' FAILED.")
                    return False
            except Exception as e:
                print("Failed to execute test '" + f.__name__ + "'.")
                print("Exception: " + str(e))
                return False

        _tests.append(_f)

        return _f
