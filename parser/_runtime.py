# _runtime.py
# Runtime for zp compiler
# TODO: Change to bigi.js


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


def print_stdout(obj, rte):
    print("STDOUT:", obj)
