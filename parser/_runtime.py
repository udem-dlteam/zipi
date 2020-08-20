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
    # XXX: radix is ignored
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


def print_stdout(msg, rte):
    print(msg)


# Checks if it is int.js Int class or BigInt
def int_instance(n):
    return isinstance(n, int)
