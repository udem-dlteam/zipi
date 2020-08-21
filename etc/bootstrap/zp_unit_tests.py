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

    print("-----")
    print(str(len(tests)) + " tests in total.")
    print(str(count(results, True)) + " tests have passed.")
    print(str(count(results, False)) + " tests have failed.")
    print("-----")


@Is(absent)
def test_dict_get():
    d = {'a': 0}
    name = 'b'
    return dict_get(d, name, absent)


@Equals("""at 1.1-2.11 foo ← <function foo #0>
at 3.1-3.4 <function foo #0>
at 3.5-3.7 10
at 2.10-2.11 10
at 3.1-3.8 10
""")
def test_pyinterp():
    source = "def foo(x):\n  return x\nfoo(10)"
    return interp_source(source)


@Equals("""at 1.5-1.6 1
at 1.1-1.6 x ← 1
at 2.1-2.2 1
at 2.1-2.12 <class 'int'>
at 3.1-3.4 <class 'int'>
at 3.1-3.14 <class 'type'>
at 4.1-4.2 1
at 4.1-4.10 <method-wrapper '__add__' of int object #0>
at 4.1-4.20 <class 'method-wrapper'>
at 5.1-5.4 <class 'int'>
at 5.1-5.12 <slot wrapper '__add__' of 'int' objects>
at 5.1-5.22 <class 'wrapper_descriptor'>
at 6.1-6.6 'str'
at 6.1-6.16 <class 'str'>
at 7.1-7.4 <class 'str'>
at 7.1-7.14 <class 'type'>
at 8.1-8.13 <module 'builtins' (built-in)>
at 8.1-8.23 <class 'module'>
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


@Equals("""at 1.1-1.14 <class 'BaseException'>
at 2.1-2.10 <class 'Exception'>
at 3.1-3.10 <class 'NameError'>
at 4.1-4.10 <class 'TypeError'>
at 5.1-5.11 <class 'ValueError'>
at 6.1-6.16 <class 'ArithmeticError'>
at 7.1-7.18 <class 'ZeroDivisionError'>
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


###
# Ints
###

@Equals("""at 1.1-1.4 <class 'int'>
at 1.1-1.12 <slot wrapper '__add__' of 'int' objects>
at 1.13-1.14 2
at 1.16-1.19 'a'
at 1.1-1.20 NotImplemented
""")
def test_int__add__0():
    source = "int.__add__(2, 'a')"
    return interp_source(source)


@Equals("""at 1.1-1.2 8
at 1.5-1.6 1
at 1.1-1.6 7
""")
def test_int__sub__0():
    source = "8 - 1"
    return interp_source(source)


@Equals("""at 1.1-1.2 2
at 1.5-1.6 8
at 1.1-1.6 16
""")
def test_int__mul__0():
    source = "2 * 8"
    return interp_source(source)


@Equals("""at 1.1-1.2 8
at 1.6-1.7 2
at 1.1-1.7 4
""")
def test_int__div__0():
    source = "8 // 2"
    return interp_source(source)


@Equals("""at 1.1-1.2 8
at 1.5-1.6 2
at 1.1-1.6 0
""")
def test_int__mod__0():
    source = "8 % 2"
    return interp_source(source)


@Equals("""at 1.2-1.4 42
at 1.1-1.4 -42
""")
def test_int__neg__0():
    source = "-42"
    return interp_source(source)


@Equals("""at 1.2-1.4 42
at 1.1-1.4 42
""")
def test_int__pos__0():
    source = "+42"
    return interp_source(source)


@Equals("""at 1.2-1.4 42
at 1.1-1.4 -43
""")
def test_int__invert__0():
    source = "~42"
    return interp_source(source)


@Equals("""at 1.1-1.2 2
at 1.6-1.7 2
at 1.1-1.7 True
""")
def test_int__eq__0():
    source = "2 == 2"
    return interp_source(source)


@Equals("""at 1.1-1.2 2
at 1.6-1.7 2
at 1.1-1.7 False
""")
def test_int__ne__0():
    source = "2 != 2"
    return interp_source(source)


@Equals("""at 1.1-1.2 2
at 1.5-1.6 3
at 1.1-1.6 True
""")
def test_int__lt__0():
    source = "2 < 3"
    return interp_source(source)


@Equals("""at 1.1-1.2 2
at 1.6-1.7 3
at 1.1-1.7 True
""")
def test_int__le__0():
    source = "2 <= 3"
    return interp_source(source)


@Equals("""at 1.1-1.2 2
at 1.5-1.6 3
at 1.1-1.6 False
""")
def test_int__gt__0():
    source = "2 > 3"
    return interp_source(source)


@Equals("""at 1.1-1.2 2
at 1.6-1.7 3
at 1.1-1.7 False
""")
def test_int__ge__0():
    source = "2 >= 3"
    return interp_source(source)


@Equals("""at 1.1-1.2 2
at 1.6-1.7 1
at 1.1-1.7 4
""")
def test_int__lshift__0():
    source = "2 << 1"
    return interp_source(source)


@Equals("""at 1.1-1.2 2
at 1.6-1.7 1
at 1.1-1.7 1
""")
def test_int__rshift__0():
    source = "2 >> 1"
    return interp_source(source)


@Equals("""at 1.1-1.2 2
at 1.5-1.8 128
at 1.1-1.8 130
""")
def test_int__or__0():
    source = "2 | 128"
    return interp_source(source)


@Equals("""at 1.1-1.2 2
at 1.5-1.6 2
at 1.1-1.6 0
""")
def test_int__xor__0():
    source = "2 ^ 2"
    return interp_source(source)


###
# Floats
###

@Equals("""at 1.1-1.4 0.1
at 1.7-1.10 0.2
at 1.1-1.10 0.30000000000000004
""")
def test_float__add__0():
    source = "0.1 + 0.2"
    return interp_source(source)


@Equals("""at 1.1-1.4 0.3
at 1.7-1.10 0.1
at 1.1-1.10 0.19999999999999998
""")
def test_float__sub__0():
    source = "0.3 - 0.1"
    return interp_source(source)


# NOTE: The repr of N.0 in JS is N (e.g. 1.0 -> 1)
@Equals("""at 1.1-1.4 2.2
at 1.7-1.10 3.3
at 1.1-1.10 7.26
""")
def test_float__mul__0():
    source = "2.2 * 3.3"
    return interp_source(source)


@Equals("""at 1.1-1.4 2.2
at 1.7-1.10 3.3
at 1.1-1.10 0.6666666666666667
""")
def test_float__truediv__0():
    source = "2.2 / 3.3"
    return interp_source(source)


@Equals("""at 1.1-1.4 2.2
at 1.7-1.10 3.3
at 1.1-1.10 2.2
""")
def test_float__mod__0():
    source = "2.2 % 3.3"
    return interp_source(source)

# Test built-in modules

# module Math

@Equals("""at 1.1-1.5 <module 'math'>
at 1.1-1.10 <function sqrt #0>
at 1.11-1.12 4
at 1.1-1.13 2.0
""")
def test_math_sqrt_0():
    source = "math.sqrt(4)"
    return interp_source(source)

@Equals("""at 1.1-1.5 <module 'math'>
at 1.1-1.10 <function sqrt #0>
at 1.11-1.12 0
at 1.13-1.14 1
at 1.11-1.14 -1
at 1.1-1.15: exception = ValueError: math domain error
""")
def test_math_sqrt_1():
    source = "math.sqrt(0-1)"
    return interp_source(source)

@Equals("""at 1.1-1.5 <module 'math'>
at 1.1-1.11 <function floor #0>
at 1.12-1.15 2.2
at 1.1-1.16 2
""")
def test_math_floor_0():
    source = "math.floor(2.2)"
    return interp_source(source)


@Equals("""at 1.1-1.5 <module 'math'>
at 1.1-1.11 <function floor #0>
at 1.12-1.15 0.0
at 1.18-1.21 2.2
at 1.12-1.21 -2.2
at 1.1-1.22 -3
""")
def test_math_floor_1():
    source = "math.floor(0.0 - 2.2)"
    return interp_source(source)


@Equals("""at 1.1-1.5 <module 'math'>
at 1.1-1.11 <function floor #0>
at 1.12-1.13 3
at 1.1-1.14 3
""")
def test_math_floor_2():
    source = "math.floor(3)"
    return interp_source(source)

@Equals("""at 1.1-1.5 <module 'math'>
at 1.1-1.10 <function ceil #0>
at 1.11-1.14 2.2
at 1.1-1.15 3
""")
def test_math_ceil_0():
    source = "math.ceil(2.2)"
    return interp_source(source)


@Equals("""at 1.1-1.5 <module 'math'>
at 1.1-1.10 <function ceil #0>
at 1.11-1.14 0.0
at 1.17-1.20 2.2
at 1.11-1.20 -2.2
at 1.1-1.21 -2
""")
def test_math_ceil_1():
    source = "math.ceil(0.0 - 2.2)"
    return interp_source(source)


@Equals("""at 1.1-1.5 <module 'math'>
at 1.1-1.10 <function ceil #0>
at 1.11-1.12 3
at 1.1-1.13 3
""")
def test_math_ceil_2():
    source = "math.ceil(3)"
    return interp_source(source)

@Equals("""at 1.1-1.5 <module 'math'>
at 1.1-1.9 <function pow #0>
at 1.10-1.11 2
at 1.12-1.13 3
at 1.1-1.14 8.0
""")
def test_math_pow_0():
    source = "math.pow(2,3)"
    return interp_source(source) 

@Equals("""at 1.1-1.5 <module 'math'>
at 1.1-1.9 <function exp #0>
at 1.10-1.11 2
at 1.1-1.12 7.38905609893065
""")
def test_math_exp_0():
    source = "math.exp(2)"
    return interp_source(source)

@Equals("""at 1.1-1.5 <module 'math'>
at 1.1-1.9 <function log #0>
at 1.10-1.11 2
at 1.1-1.12 0.9092974268256817
""")
def test_math_log_0():
    source = "math.log(2)"
    return interp_source(source)

@Equals("""at 1.1-1.5 <module 'math'>
at 1.1-1.9 <function log #0>
at 1.10-1.11 0
at 1.1-1.12: exception = ValueError: math domain error
""")
def test_math_log_1():
    source = "math.log(0)"
    return interp_source(source)

@Equals("""at 1.1-1.5 <module 'math'>
at 1.1-1.9 <function log #0>
at 1.10-1.11 0
at 1.12-1.13 2
at 1.10-1.13 -2
at 1.1-1.14: exception = ValueError: math domain error
""")
def test_math_log_2():
    source = "math.log(0-2)"
    return interp_source(source)

@Equals("""at 1.1-1.5 <module 'math'>
at 1.1-1.9 <function sin #0>
at 1.10-1.11 0
at 1.1-1.12 0.0
""")
def test_math_sin_0():
    source = "math.sin(0)"
    return interp_source(source)

@Equals("""at 1.1-1.5 <module 'math'>
at 1.1-1.9 <function cos #0>
at 1.10-1.11 0
at 1.1-1.12 1.0
""")
def test_math_cos_0():
    source = "math.cos(0)"
    return interp_source(source)

@Equals("""at 1.1-1.5 <module 'math'>
at 1.1-1.9 <function tan #0>
at 1.10-1.11 0
at 1.1-1.12 0.0
""")
def test_math_tan_0():
    source = "math.tan(0)"
    return interp_source(source)

@Equals("""at 1.1-1.5 <module 'math'>
at 1.1-1.10 <function asin #0>
at 1.11-1.12 0
at 1.1-1.13 0.0
""")
def test_math_asin_0():
    source = "math.asin(0)"
    return interp_source(source)

@Equals("""at 1.1-1.5 <module 'math'>
at 1.1-1.10 <function acos #0>
at 1.11-1.12 0
at 1.1-1.13 1.5707963267948966
""")
def test_math_acos_0():
    source = "math.acos(0)"
    return interp_source(source)

@Equals("""at 1.1-1.5 <module 'math'>
at 1.1-1.10 <function atan #0>
at 1.11-1.12 0
at 1.1-1.13 0.0
""")
def test_math_atan_0():
    source = "math.atan(0)"
    return interp_source(source)

@Equals("""at 1.1-1.5 <module 'math'>
at 1.1-1.8 3.141592653589793
""")
def test_math_pi_0():
    source = "math.pi"
    return interp_source(source)

@Equals("""at 1.1-1.5 <module 'math'>
at 1.1-1.7 2.718281828459045
""")
def test_math_e_0():
    source = "math.e"
    return interp_source(source)

@Equals("""at 1.2-1.9 42.4242
at 1.1-1.9 -42.4242
""")
def test_float__neg__0():
    source = "-42.4242"
    return interp_source(source)


@Equals("""at 1.2-1.9 42.4242
at 1.1-1.9 42.4242
""")
def test_float__pos__0():
    source = "+42.4242"
    return interp_source(source)


if __name__ == "__main__":
    run_tests()
