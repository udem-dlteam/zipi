# zp_unit_tests.py

# For JS tests, make a global variable.
tests = []

if __name__ == "__main__":
    from _unit_tests import Test, Equals, Is, IsInstance, _tests

    import sys
    sys.path.append("../../etc")
    sys.path.append("../../parser")

    # For Python tests, use _tests from _unit_tests module.
    tests = _tests


from pyinterp import *


def count(a, b):
    s = 0
    for i in a:
        if i == b:
            s += 1
    return s


def run_tests():
    results = []
    for test in tests:
        results.append(test())

    if len(tests) == count(results, True):
        print("-----")
        print("All tests have passed. (" + str(len(tests)) + ")")
        print("-----")
    else:
        print("-----")
        print(str(len(tests)) + " tests in total.")
        print(str(count(results, True)) + " tests have passed.")
        print(str(count(results, False)) + " tests have failed.")
        print("-----")


# Mock tests

@Equals(False)
def returns_False():
    return False


@Equals(True)
def returns_True():
    return True


@Equals(2, 2)
def foo(x):
    return x


@Equals(6, 1, 2, 3)
def bar(x, y, z):
    return x + y + z


@Equals("""
def foo(x):
    return x""")
def returns_foo():
    foo = """
def foo(x):
    return x"""
    return foo


@Is(None)
def returns_None():
    return None


class Foo:
    pass


@IsInstance(Foo)
def makes_Foo():
    foo = Foo()
    return foo


# pyinterp unit tests

@Is(absent)
def test_dict_get():
    d = {'a': 0}
    name = 'b'
    return dict_get(d, name, absent)


@Equals("""at 1.1-2.11
at 3.1-3.4<function foo #0>
at 3.5-3.710
at 2.10-2.1110
at 3.1-3.810
""")
def test_pyinterp():
    source = "def foo(x):\n  return x\nfoo(10)"
    return interp_source(source)


@Equals("""at 1.5-1.61
at 1.1-1.6
at 2.1-2.21
at 2.1-2.12<class 'int'>
at 3.1-3.4<class 'int'>
at 3.1-3.14<class 'type'>
at 4.1-4.21
at 4.1-4.10<method-wrapper '__add__' of int object #0>
at 4.1-4.20<class 'method-wrapper'>
at 5.1-5.4<class 'int'>
at 5.1-5.12<slot wrapper '__add__' of 'int' objects>
at 5.1-5.22<class 'wrapper_descriptor'>
at 6.1-6.6'str'
at 6.1-6.16<class 'str'>
at 7.1-7.4<class 'str'>
at 7.1-7.14<class 'type'>
at 8.1-8.13<module 'builtins' (built-in)>
at 8.1-8.23<class 'module'>
""")
def test_class_attribute():
    source = """x = 1
x.__class__
int.__class__
x.__add__.__class__
int.__add__.__class__
'str'.__class__
str.__class__
__builtins__.__class__
    """
    return interp_source(source)


@Equals("""at 1.1-1.14<class 'BaseException'>
at 2.1-2.10<class 'Exception'>
at 3.1-3.10<class 'NameError'>
at 4.1-4.10<class 'TypeError'>
at 5.1-5.11<class 'ValueError'>
at 6.1-6.16<class 'ArithmeticError'>
at 7.1-7.18<class 'ZeroDivisionError'>
""")
def test_exception_class():
    source = """BaseException
Exception
NameError
TypeError
ValueError
ArithmeticError
ZeroDivisionError
"""
    return interp_source(source)


# int methods
# Only test some cases for now...
@Equals("""at 1.1-1.4<class 'int'>
at 1.1-1.12<slot wrapper '__add__' of 'int' objects>
at 1.13-1.142
at 1.16-1.19'a'
at 1.1-1.20NotImplemented
""")
def test_int__add__0():
    source = "int.__add__(2, 'a')"
    return interp_source(source)


@Equals("""at 1.1-1.28
at 1.5-1.61
at 1.1-1.67
""")
def test_int__sub__0():
    source = "8 - 1"
    return interp_source(source)


@Equals("""at 1.1-1.22
at 1.5-1.68
at 1.1-1.616
""")
def test_int__mul__0():
    source = "2 * 8"
    return interp_source(source)


@Equals("""at 1.1-1.28
at 1.6-1.72
at 1.1-1.74
""")
def test_int__div__0():
    source = "8 // 2"
    return interp_source(source)


@Equals("""at 1.1-1.28
at 1.5-1.62
at 1.1-1.60
""")
def test_int__mod__0():
    source = "8 % 2"
    return interp_source(source)


if __name__ == "__main__":
    run_tests()
