# _runtime.py
# Runtime for zp compiler


def nocompile(f):
    return f


def make_dict():
    return dict()


def dict_get(d, key, default_value):
    return d.get(key, default_value)


def dict_set(d, key, value):
    d[key] = value


def dict_has(d, key):
    return key in d.keys()


def int_to_string(u, radix):
    if radix == 2:
        return bin(u)[2:]
    elif radix == 8:
        return oct(u)[2:]
    elif radix == 16:
        return hex(u)[2:]
    else:
        return str(u)


def int_add(u, v):
    return u + v


def int_sub(u, v):
    return u - v


def int_mul(u, v):
    return u * v


def int_div(u, v):
    return u // v


def int_mod(u, v):
    return u % v


def int_is_zero(u):
    return u == 0


def int_from_float(u):
    return u


def int_from_string(string, radix):
    return int(string, radix)


def float_from_string(string):
    return float(string)


def input_stdin(msg):
    try:
        return input(msg)
    except:
        return None


def print_stdout(msg, rte):
    print(msg)

def list_to_tuple(l):
    return tuple(l)

def tuple_to_list(t):
    return list(t)

# Checks if it is int.js Int class or BigInt
def int_instance(n):
    return isinstance(n, int)


# Floats
def float_from_string(string):
    return float(string)


def float_to_string(u):
    return str(u)


def float_from_float(u):
    return u


def float_instance(u):
    return isinstance(u, float)


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

# module math

import math
def float_sqrt(u):
    return math.sqrt(u)


def float_floor(u):
    return math.floor(u)


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
    return math.exp


def float_log(u):
    return math.log(u)


def float_pow(u, v):
    return math.pow(u, v)


def float_pi():
    return math.pi


def float_e():
    return math.e
