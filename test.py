from _runtime import *

def make_empty_array_with_zero_chars(size):
    a = []
    while size > 0:
        a.append("0")
        size -= 1
    return a

def digit_to_char(x):
    return chr(x + 48)

def float_repr_scale(r, s, m_pos, m_neg, must_round, v):
    """
    r is an exact integer
    s is an exact integer
    m_pos is an exact integer
    m_neg is an exact integer
    must_round is a boolean
    v is a float
    """

    est = int_from_num(float_to_num(float_ceil(float_sub(float_log10(v), float_epsilon()))))

    if int_is_neg(est):
        factor = int_pow(int_from_num(10), int_neg(est))
        return float_repr_fixup(
            int_mul(r, factor),
            s,
            int_mul(m_pos, factor),
            int_mul(m_neg, factor),
            est,
            must_round)
    else:
        factor = int_pow(int_from_num(10), est)
        return float_repr_fixup(
            r,
            int_mul(s, factor),
            m_pos,
            m_neg,
            est,
            must_round)

def float_repr_fixup(r, s, m_pos, m_neg, k, must_round):
    if must_round:
        cond = int_ge(int_add(r, m_pos), s)
    else:
        cond = int_lt(s, int_add(r, m_pos))

    if cond:
        return (int_add(k, int_from_num(1)),
                float_repr_generate(r, s, m_pos, m_neg, must_round, int_from_num(0)))
    else:
        return (k,
                float_repr_generate(
                    int_mul(r, int_from_num(10)),
                    s,
                    int_mul(m_pos, int_from_num(10)),
                    int_mul(m_neg, int_from_num(10)),
                    must_round,
                    int_from_num(0)))

def float_repr_generate(r, s, m_pos, m_neg, must_round, n):
    dr = int_divmod_floor(r, s)
    d = dr[0]
    r = dr[1]
    if must_round:
        tc = int_ge(int_add(r, m_pos), s)
    else:
        tc = int_lt(s, int_add(r, m_pos))

    if must_round:
        cond = int_ge(m_neg, r)
    else:
        cond = int_lt(r, m_neg)

    n_num = int_to_num(n)
    if cond:
        if tc:
            _2r = int_lshift(r, int_from_num(1))
            if int_is_even(d) and int_eq(_2r, s) or int_lt(_2r, s):
                last_digit = d
            else:
                last_digit = int_add(d, int_from_num(1))
        else:
            last_digit = d
        str_chars = make_empty_array_with_zero_chars(n_num + 1)
        str_chars[n_num] = digit_to_char(int_to_num(last_digit))
        return str_chars
    elif tc:
        str_chars = make_empty_array_with_zero_chars(n_num + 1)
        str_chars[n_num] = digit_to_char(int_to_num(d) + 1)
        return str_chars
    else:
        str_chars = float_repr_generate(
            int_mul(r, int_from_num(10)),
            s,
            int_mul(m_pos, int_from_num(10)),
            int_mul(m_neg, int_from_num(10)),
            must_round,
            int_add(n, int_from_num(1)))
        str_chars[n_num] = digit_to_char(int_to_num(d))
        return str_chars

def float_repr_decompose(x):
    e_bias = 1023
    m_bits = 52
    m_min = 4503599627370496
    m_max = 9007199254740991

    def exp_form(x):
        if x < 1.0:
            r = exp_form_neg(x, 0.5, 1)
            return (r[0]*2.0, -1-r[1])
        else:
            return exp_form_pos(x, 2.0, 1)

    def exp_form_pos(x, y, i):
        i2 = i*2
        r = exp_form_pos(x, y*y, i2) if not e_bias<i2 and not x<y else (x, 0)
        a = r[0]
        b = r[1]
        ib = i+b
        return (a/y, ib) if not e_bias<ib and not a<y else r

    def exp_form_neg(x, y, i):
        i2 = i*2
        r = exp_form_neg(x, y*y, i2) if i2<e_bias-1 and x<y else (x, 0)
        a = r[0]
        b = r[1]
        ib = i+b
        return (a/y, ib) if ib<e_bias-1 and a<y else r

    r = exp_form(abs(x))
    y = r[0]
    sign = -1 if math.copysign(1.0, x) < 0 else 1
    if y < 2.0:
        return (int(r[0]*m_min), r[1]-m_bits, 1)
    else:
        if y > 0.0:
            return (m_min, e_bias+1-m_bits, sign) # inf
        else:
            return (m_max, e_bias+1-m_bits, sign) # nanprint(float_decompose(0.0))

def float_repr_pow_mantissa_pair(v):
    float_num_e_min = int_from_num(-1074)
    float_m_pos_min = int_from_num(10000000000000000)

    x = float_repr_decompose(v)
    f = x[0]
    e = x [1]
    must_round = int_is_even(e)

    if int_is_neg(e):
        if int_ne(e, float_num_e_min) and int_eq(f, float_m_pos_min):
            return float_repr_scale(
                int_lshift(f, int_from_num(2)),
                int_lshift(int_from_num(1), int_sub(int_from_num(2), e)),
                int_from_num(2),
                int_from_num(1),
                must_round,
                v)
        else:
            return float_repr_scale(
                int_lshift(f, int_from_num(1)),
                int_lshift(int_from_num(1), int_sub(int_from_num(1), e)),
                int_from_num(1),
                int_from_num(1),
                must_round,
                v)
    else:
        _2_pow_e = int_lshift(1, e)
        if int_eq(f, float_m_pos_min):
            return float_repr_scale(
                int_lshift(f, int_add(e, int_from_num(2))),
                int_from_num(4),
                int_lshift(int_from_num(1), int_add(e, int_from_num(1))),
                _2_pow_e,
                must_round,
                v)
        else:
            return float_repr_scale(
                int_lshift(f, int_add(e, int_from_num(1))),
                int_from_num(2),
                _2_pow_e,
                _2_pow_e,
                must_round,
                v)

def format_float_repr(v):
    if float_is_neg(v):
        sign = "-"
    else:
        sign = ""

    if float_is_infinite(v):
        return sign + "inf"
    elif float_is_nan(v):
        return "nan"

    pow, m = float_repr_pow_mantissa_pair(float_abs(v))

    if int_ge(pow, int_from_num(17)):
        if len(m) == 1:
            return sign + m[0] + "e+" + int_to_string(int_sub(pow, int_from_num(1)), int_from_num(10))
        else:
            m[0] = m[0] + "."
            return sign + "".join(m) + "e+" + int_to_string(int_sub(pow, int_from_num(1)), int_from_num(10))
    elif int_ge(pow, int_from_num(1)):
        pow_num = int_to_num(pow)
        m_len = len(m)
        if pow_num >= m_len:
            m = m + make_empty_array_with_zero_chars(pow_num - m_len)
            m.append(".0")
        else:
            m[pow] = "." + m[pow]
        return sign + "".join(m)
    elif int_ge(pow, int_from_num(-4)):
        return sign + "0." + "".join(make_empty_array_with_zero_chars(int_to_num(int_neg(pow)))) + "".join(m)
    elif len(m) == 1:
        return sign + m[0] + "e" + int_to_string(int_sub(pow, int_from_num(1)), int_from_num(10))
    else:
        m[0] = m[0] + "."
        return sign + "".join(m) + "e" + int_to_string(int_sub(pow, int_from_num(1)), int_from_num(10))

import random

def random_norm_float():
    f = random.randrange(4503599627370496)+4503599627370496
    e = random.randrange(2046)-1022-52
    return f * 2.0**e

def random_denorm_float():
    f = random.randrange(4503599627370496)
    e = -1074
    return f * 2.0**e

def random_float():
    if random.randrange(2) == 0:
        return random_norm_float()
    else:
        return random_denorm_float()

def test_roundtrip():
    while True:
        x = random_float()
        a = format_float_repr(x)
        b = float(a)
        if x != b:
            print('not roundtrip:',x, b)

#test_roundtrip()
print(3.5947745401839132e+16)
print(format_float_repr(3.5947745401839132e+16))