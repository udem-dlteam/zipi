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


def num_to_string(u, radix):
    # XXX: radix is ignored
    return str(u)


def num_add(u, v):
    return u + v


def num_sub(u, v):
    return u - v


def num_mul(u, v):
    return u * v


def num_div(u, v):
    return u // v
