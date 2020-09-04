# _runtime.py
# Runtime for zp compiler


def nocompile(f):
    return f


###
# Dict operations
###

def make_dict():
    return dict()


def dict_get(d, key, default_value):
    return d.get(key, default_value)


def dict_set(d, key, value):
    d[key] = value


def dict_has(d, key):
    return key in d.keys()


###
# Int operations
###

def int_instance(n):
    return isinstance(n, int)


def int_from_num(u):
    return int(u)


def int_is_zero(u):
    return u == 0


def int_is_neg(u):
    return u < 0


def int_is_nonneg(u):
    return u >= 0


def int_cmp(u, v):
    if u < v:
        return -1
    elif u == v:
        return 0
    elif u > v:
        return 1


def int_eq(u, v):
    return u == v


def int_ne(u, v):
    return u != v


def int_lt(u, v):
    return u < v


def int_le(u, v):
    return u <= v


def int_gt(u, v):
    return u > v


def int_ge(u, v):
    return u >= v


def int_abs(u):
    return abs(u)


def int_neg(u):
    return -u


def int_add(u, v):
    return u + v


def int_sub(u, v):
    return u - v


def int_mul(u, v):
    return u * v


def int_div_floor(u, v):
    return u // v


def int_mod_floor(u, v):
    return u % v

def int_divmod_floor(u, v):
    return divmod(u, v)

def int_not(u):
    return ~u

inf = float("inf")
neg_inf = float("-inf")

def int_to_num(u, exact=None):
    try:
        float(u)
        return u
    except OverflowError:
        if exact:
            return False
        elif int_is_neg(u):
            return neg_inf
        else:
            return inf



def int_and(u, v):
    return u & v

def int_neg(n):
    return -n

def int_not(n):
    return ~n


def int_or(u, v):
    return u | v


def int_xor(u, v):
    return u ^ v


def int_lshift(u, v):
    return u << v


def int_rshift(u, v):
    return u >> v


def int_to_string(u, radix):
    if radix == 2:
        return format(u, "b")
    elif radix == 8:
        return format(u, "o")
    elif radix == 16:
        return format(u, "x")
    else:
        return str(u)

def int_pow_mod(u,v,m):
    return pow(u,v,m)

def int_pow(u,v):
    return pow(u,v)

def int_is_even(u):
    return u % 2 == 0

def int_round(x, ndigits):
    return round(x, ndigits)

def int_from_string(string, radix):
    try:
        return int(string, radix)
    except ValueError:
        return False

def int_from_substring(string, start, stop, radix):
    try:
        return int(string[start:stop], radix)
    except ValueError:
        return False


###
# Float operations
###

def float_instance(u):
    return isinstance(u, float)


def float_from_num(u):
    return u


def float_to_num(u):
    return u


def float_is_zero(u):
    return u == 0


def float_is_infinite(u):
    return math.isinf(u)


def float_is_finite(u):
    return math.isfinite(u)


def float_is_nan(u):
    return math.isnan(u)


def float_is_pos(u):
    return u > 0.0


def float_is_nonneg(u):
    return u >= 0.0


def float_eq(u, v):
    return u == v


def float_ne(u, v):
    return u != v


def float_lt(u, v):
    return u < v


def float_le(u, v):
    return u <= v


def float_gt(u, v):
    return u > v


def float_ge(u, v):
    return u >= v


def float_abs(u):
    return abs(u)


def float_neg(u):
    return -u


def float_add(u, v):
    return u + v


def float_sub(u, v):
    return u - v


def float_mul(u, v):
    return u * v


def float_div(u, v):
    return u / v


def float_mod(u, v):
    return u % v

def float_mod_floor(u, v):
    return u % v


def float_is_zero(u):
    return u == 0


def float_is_neg(u):
    return math.copysign(1.0, u) == -1.0

def float_from_string(string):
    return float(string)


def float_to_string(u):
    return str(u)

##
# module math
##

import math
import sys

def float_sqrt(u):
    return math.sqrt(u)

lowest_float_with_precision_1 = 2.0 ** 53

def float_floor(u):
    if abs(u) < lowest_float_with_precision_1:
        return float(math.floor(u))
    else:
        return u


def float_trunc(u):
    if abs(u) < lowest_float_with_precision_1:
        return float(math.trunc(u))
    else:
        return u


def float_ceil(u):
    if abs(u) < lowest_float_with_precision_1:
        return float(math.ceil(u))
    else:
        return u


def float_sin(u):
    return math.sin(u)


def float_cos(u):
    return math.cos(u)


def float_tan(u):
    return math.tan(u)


def float_asin(u):
    return math.asin(u)


def float_acos(u):
    return math.acos(u)


def float_atan(u):
    return math.atan(u)


def float_exp(u):
    return math.exp(u)


def float_log(u):
    return math.log(u)


def float_log10(u):
    return math.log10(u)


def float_pow(u, v):
    return math.pow(u, v)


def float_pi():
    return math.pi


def float_e():
    return math.e

def float_epsilon():
    return sys.float_info.epsilon

def float_round(x):
    return round(x, 0)

def float_round_to_digits(x, ndigits):
    return round(x, ndigits)

###
# List operations
###

def list_new(size, default_):
    return [default_] * size

def list_concat(l1, l2):
    new_lst = []
    for x in l1:
        new_lst.append(x)

    for y in l2:
       new_lst.append(y)

    return new_lst


###
# IO operations
###

def runtime_alert(msg):
    print(msg)

def runtime_confirm(msg):
    try:
        input(msg)
        return True
    except Exception:
        return False


def runtime_print(msg, rte):
    print(msg)

def runtime_input(msg):
    try:
        return input(msg)
    except Exception:
        return None

def runtime_prompt(msg):
    return runtime_input(msg)


# Module random
import random

def runtime_random():
    return random.random()

debug = False

if debug:
    for k, v in globals().copy().items():
        if "from_string" in k:
            def wrapper(*args, v=v):
                if all(isinstance(x, str) for x in args):
                    return v(*args)
                else:
                    raise TypeError(v, args)
            globals()[k] = wrapper
        elif k == "int_from_num":
            def wrapper(*args, v=v):
                if all(int(x) == x for x in args):
                    return v(*args)
                else:
                    raise TypeError(v, args)
            globals()[k] = wrapper
        elif k.startswith("int_"):
            def wrapper(*args, v=v):
                if all(isinstance(x, int) for x in args):
                    return v(*args)
                else:
                    raise TypeError(v, args)
            globals()[k] = wrapper

        elif k.startswith("float_"):
            def wrapper(*args, v=v):
                if all(isinstance(x, float) for x in args):
                    return v(*args)
                else:
                    raise TypeError(v, args)
            globals()[k] = wrapper
