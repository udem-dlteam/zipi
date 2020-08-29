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

def int_pow(u, v):
    return pow(u, v)

def int_not(u):
    return ~u

def int_to_num(u, exact=None):
    if exact:
        try:
            float(u)
            return u
        except OverflowError:
            return False
    else:
        return u


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


def float_from_float(u):
    return u


def float_is_zero(u):
    return u == 0


def float_is_pos(u):
    return u > 0.0


def float_is_neg(u):
    return u < 0.0


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


def float_is_zero(u):
    return u == 0


def float_is_neg(u):
    return (u < 0)


def float_from_string(string):
    return float(string)


def float_to_string(u):
    return str(u)

##
# module math
##

import math
def float_sqrt(u):
    return math.sqrt(u)


def float_floor(u):
    return float(math.floor(u))


def float_ceil(u):
    return math.ceil(u)


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


def float_pow(u, v):
    return math.pow(u, v)


def float_pi():
    return math.pi


def float_e():
    return math.e


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

