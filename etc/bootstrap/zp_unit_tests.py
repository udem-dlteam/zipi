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
def test_om_rawget():
    d = {'a': 0}
    name = 'b'
    return om_rawget(d, name)


@Equals("""at 1.1-2.11
at 3.1-3.4: value = <function foo #0>
at 3.5-3.7: value = 10
at 2.10-2.11: value = 10
at 3.1-3.8: value = 10
""")
def test_pyinterp():
    source = "def foo(x):\n  return x\nfoo(10)"
    return interp_source(source)


if __name__ == "__main__":
    run_tests()
