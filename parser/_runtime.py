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


def int_from_float(u):
    return u


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


def int_div(u, v):
    return u // v


def int_mod(u, v):
    return u % v


def int_divmod(u, v):
    return divmod(u, v)


def int_not(u):
    return ~u


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
        return bin(u)[2:]
    elif radix == 8:
        return oct(u)[2:]
    elif radix == 16:
        return hex(u)[2:]
    else:
        return str(u)


def int_from_string(string, radix):
    return int(string, radix)


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

def float_from_string(string):
    return float(string)


def float_to_string(u):
    return str(u)


###
# IO operations
###

def input_stdin(msg):
    try:
        return input(msg)
    except Exception:
        return None


def print_stdout(msg, rte):
    print(msg)
