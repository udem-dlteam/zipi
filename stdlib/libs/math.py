from __compiler_intrinsics__ import class_getattr, absent, call_host

def ceil(x):
    if isinstance(x, float):
        if isnan(x):
            return x
        elif isinf(x):
            raise OverflowError("cannot convert float infinity to integer")
        else:
            return call_host("(lambda (x) (py-int-from-scheme (exact (flceiling (py-float-to-scheme x)))))", x)
    elif isinstance(x, int):
        return x
    else:
        __ceil__ = class_getattr(x, "__ceil__")
        if __ceil__ is not absent:
            return __ceil__(x) # note: no check for Integral result
        else:
            #raise TypeError("type ??? doesn't define __ceil__ method")
            raise TypeError("must be real number")

def comb(n, k):
    raise NotImplementedError("math.comb(n, k) not implemented")

def copysign(x, y):
    if isinstance(x, float):
        if isinstance(y, float):
            return call_host("(lambda (x y) (py-float-from-scheme (flcopysign (py-float-to-scheme x) (py-float-to-scheme y))))", x, y)
        elif isinstance(y, int):
            return call_host("(lambda (x y) (py-float-from-scheme (flcopysign (py-float-to-scheme x) (py-float-to-scheme y))))", x, float(y))
        else:
            raise TypeError("must be real number")
    elif isinstance(x, int):
        if isinstance(y, float):
            return call_host("(lambda (x y) (py-float-from-scheme (flcopysign (py-float-to-scheme x) (py-float-to-scheme y))))", float(x), y)
        elif isinstance(y, int):
            return call_host("(lambda (x y) (py-float-from-scheme (flcopysign (py-float-to-scheme x) (py-float-to-scheme y))))", float(x), float(y))
        else:
            raise TypeError("must be real number")
    else:
        raise TypeError("must be real number")

def fabs(x):
    if isinstance(x, float):
        return abs(x)
    elif isinstance(x, int):
        return abs(float(x))
    else:
        raise TypeError("must be real number")

def factorial(x):
    if isinstance(x, int):
        if x >= 0:
            f = 1
            while x > 1:
                f *= x
                x -= 1
            return f
        else:
            return ValueError("factorial() not defined for negative values")
    else:
        return ValueError("factorial() only accepts integral values")

def floor(x):
    if isinstance(x, float):
        if isnan(x):
            return x
        elif isinf(x):
            raise OverflowError("cannot convert float infinity to integer")
        else:
            return call_host("(lambda (x) (py-int-from-scheme (exact (flfloor (py-float-to-scheme x)))))", x)
    elif isinstance(x, int):
        return x
    else:
        __floor__ = class_getattr(x, "__floor__")
        if __floor__ is not absent:
            return __floor__(x) # note: no check for Integral result
        else:
            #raise TypeError("type ??? doesn't define __floor__ method")
            raise TypeError("must be real number")

def fmod(x, y):
    if isinstance(x, float) or isinstance(x, int):
        if isinstance(y, float) or isinstance(y, int):
            if isinf(y):
                return x
            else:
                x = float(x)
                y = float(y)
                if y != 0.0:
                    f = x - floor(x/y)*y
                    if (f != 0.0) and (x < 0.0) is not (y < 0.0): f -= y
                    return f
                else:
                    return ValueError("math domain error")
        else:
            raise TypeError("must be real number")
    else:
        raise TypeError("must be real number")

def frexp(x):
    raise NotImplementedError("math.frexp(x) not implemented")

def fsum(iterable):
    raise NotImplementedError("math.fsum(iterable) not implemented")

def gcd(*integers):
    raise NotImplementedError("math.gcd(*integers) not implemented")

def isclose(a, b, *, rel_tol=1e-09, abs_tol=0.0):
    raise NotImplementedError("math.isclose(a, b, *, rel_tol=1e-09, abs_tol=0.0) not implemented")

def isfinite(x):
    if isinstance(x, float):
        return call_host("(lambda (x) (py-bool-from-scheme-bool (flfinite? (py-float-to-scheme x))))", x)
    elif isinstance(x, int):
        return call_host("(lambda (x) (py-bool-from-scheme-bool (flfinite? (py-float-to-scheme x))))", float(x))
    else:
        raise TypeError("must be real number")

def isinf(x):
    if isinstance(x, float):
        return call_host("(lambda (x) py-False #;(py-bool-from-scheme-bool (flinfinite? (py-float-to-scheme x))))", x)
    elif isinstance(x, int):
        return call_host("(lambda (x) (py-bool-from-scheme-bool (flinfinite? (py-float-to-scheme x))))", float(x))
    else:
        raise TypeError("must be real number")

def isnan(x):
    if isinstance(x, float):
        return call_host("(lambda (x) (py-bool-from-scheme-bool (flnan? (py-float-to-scheme x))))", x)
    elif isinstance(x, int):
        return call_host("(lambda (x) (py-bool-from-scheme-bool (flnan? (py-float-to-scheme x))))", float(x))
    else:
        raise TypeError("must be real number")

def isqrt(n):
    raise NotImplementedError("math.isqrt(n) not implemented")

def lcm(*integers):
    raise NotImplementedError("math.lcm(*integers) not implemented")

def ldexp(x, i):
    if isinstance(x, float):
        if isinstance(i, int):
            return x * (2.0 ** i)
        else:
            raise TypeError("Expected an int as second argument to ldexp.")
    elif isinstance(x, int):
        if isinstance(i, int):
            return float(x) * (2.0 ** i)
        else:
            raise TypeError("Expected an int as second argument to ldexp.")
    else:
        raise TypeError("must be real number")

def modf(x):
    raise NotImplementedError("math.modf(x) not implemented")

def nextafter(x, y):
    raise NotImplementedError("math.nextafter(x, y) not implemented")

def perm(n, k=None):
    raise NotImplementedError("math.perm(n, k=None) not implemented")

def prod(iterable, *, start=1):
    raise NotImplementedError("math.prod(iterable, *, start=1) not implemented")

def remainder(x, y):
    raise NotImplementedError("math.remainder(x, y) not implemented")

def trunc(x):
    if isinstance(x, float):
        if isnan(x):
            return x
        elif isinf(x):
            raise OverflowError("cannot convert float infinity to integer")
        else:
            return call_host("(lambda (x) (py-int-from-scheme (exact (fltruncate (py-float-to-scheme x)))))", x)
    elif isinstance(x, int):
        return x
    else:
        __trunc__ = class_getattr(x, "__trunc__")
        if __trunc__ is not absent:
            return __trunc__(x) # note: no check for Integral result
        else:
            raise TypeError("type ??? doesn't define __trunc__ method")
            #raise TypeError("must be real number")

def ulp(x):
    raise NotImplementedError("math.ulp(x) not implemented")

def exp(x):
    if isinstance(x, float):
        return call_host("(lambda (x) (py-float-from-scheme (flexp (py-float-to-scheme x))))", x)
    elif isinstance(x, int):
        return call_host("(lambda (x) (py-float-from-scheme (flexp (py-float-to-scheme x))))", float(x))
    else:
        raise TypeError("must be real number")

def expm1(x):
    if isinstance(x, float):
        return call_host("(lambda (x) (py-float-from-scheme (flexpm1 (py-float-to-scheme x))))", x)
    elif isinstance(x, int):
        return call_host("(lambda (x) (py-float-from-scheme (flexpm1 (py-float-to-scheme x))))", float(x))
    else:
        raise TypeError("must be real number")

def log(x, base=2.718281828459045):
    if isinstance(x, float):
        if isinstance(base, float):
            if isnan(x):
                return x
            elif x > 0.0:
                if isnan(base):
                    return base
                elif base > 0.0:
                    return call_host("(lambda (x base) (py-float-from-scheme (fllog (py-float-to-scheme x) (py-float-to-scheme base))))", x, base)
                else:
                    return ValueError("math domain error")
            else:
                return ValueError("math domain error")
        elif isinstance(base, int):
            if isnan(x):
                return x
            elif x > 0.0:
                if base > 0:
                    return call_host("(lambda (x base) (py-float-from-scheme (fllog (py-float-to-scheme x) (py-float-to-scheme base))))", x, float(base))
                else:
                    return ValueError("math domain error")
            else:
                return ValueError("math domain error")
        else:
            raise TypeError("must be real number")
    elif isinstance(x, int):
        if isinstance(base, float):
            if x > 0:
                if isnan(base):
                    return base
                elif base > 0.0:
                    return call_host("(lambda (x base) (py-float-from-scheme (fllog (py-float-to-scheme x) (py-float-to-scheme base))))", float(x), base)
                else:
                    return ValueError("math domain error")
            else:
                return ValueError("math domain error")
        elif isinstance(base, int):
            if x > 0:
                if base > 0:
                    return call_host("(lambda (x base) (py-float-from-scheme (fllog (py-float-to-scheme x) (py-float-to-scheme base))))", float(x), float(base))
                else:
                    return ValueError("math domain error")
            else:
                return ValueError("math domain error")
        else:
            raise TypeError("must be real number")
    else:
        raise TypeError("must be real number")

def log1p(x):
    if isinstance(x, float):
        if x >= 0.0:
            return call_host("(lambda (x) (py-float-from-scheme (fllog1p (py-float-to-scheme x))))", x)
        else:
            return ValueError("math domain error")
    elif isinstance(x, int):
        if x >= 0:
            return call_host("(lambda (x) (py-float-from-scheme (fllog1p (py-float-to-scheme x))))", float(x))
        else:
            return ValueError("math domain error")
    else:
        raise TypeError("must be real number")

def log2(x):
    if isinstance(x, float):
        if isnan(x):
            return x
        elif x > 0.0:
            return call_host("(lambda (x) (py-float-from-scheme (fllog (py-float-to-scheme x) 2.0)))", x)
        else:
            return ValueError("math domain error")
    elif isinstance(x, int):
        if x > 0:
            return call_host("(lambda (x) (py-float-from-scheme (fllog (py-float-to-scheme x) 2.0)))", float(x))
        else:
            return ValueError("math domain error")
    else:
        raise TypeError("must be real number")

def log10(x):
    if isinstance(x, float):
        if isnan(x):
            return x
        elif x > 0.0:
            return call_host("(lambda (x) (py-float-from-scheme (fllog (py-float-to-scheme x) 10.0)))", x)
        else:
            return ValueError("math domain error")
    elif isinstance(x, int):
        if x > 0:
            return call_host("(lambda (x) (py-float-from-scheme (fllog (py-float-to-scheme x) 10.0)))", float(x))
        else:
            return ValueError("math domain error")
    else:
        raise TypeError("must be real number")

def pow(x, y):
    # TODO: handle edge cases
    if isinstance(x, float):
        if isinstance(y, float):
            return call_host("(lambda (x y) (py-float-from-scheme (flexpt (py-float-to-scheme x) (py-float-to-scheme y))))", x, y)
        elif isinstance(y, int):
            return call_host("(lambda (x y) (py-float-from-scheme (flexpt (py-float-to-scheme x) (py-float-to-scheme y))))", x, float(y))
        else:
            raise TypeError("must be real number")
    elif isinstance(x, int):
        if isinstance(y, float):
            return call_host("(lambda (x y) (py-float-from-scheme (flexpt (py-float-to-scheme x) (py-float-to-scheme y))))", float(x), y)
        elif isinstance(y, int):
            return call_host("(lambda (x y) (py-float-from-scheme (flexpt (py-float-to-scheme x) (py-float-to-scheme y))))", float(x), float(y))
        else:
            raise TypeError("must be real number")
    else:
        raise TypeError("must be real number")

def sqrt(x):
    if isinstance(x, float):
        if isnan(x):
            return x
        elif x >= 0.0:
            return call_host("(lambda (x) (py-float-from-scheme (flsqrt (py-float-to-scheme x))))", x)
        else:
            return ValueError("math domain error")
    elif isinstance(x, int):
        if x >= 0:
            return call_host("(lambda (x) (py-float-from-scheme (flsqrt (py-float-to-scheme x))))", float(x))
        else:
            return ValueError("math domain error")
    else:
        raise TypeError("must be real number")

def acos(x):
    if isinstance(x, float):
        if isnan(x):
            return x
        elif x >= -1.0 and x <= 1.0:
            return call_host("(lambda (x) (py-float-from-scheme (flacos (py-float-to-scheme x))))", x)
        else:
            return ValueError("math domain error")
    elif isinstance(x, int):
        if x >= -1 and x <= 1:
            return call_host("(lambda (x) (py-float-from-scheme (flacos (py-float-to-scheme x))))", float(x))
        else:
            return ValueError("math domain error")
        return x
    else:
        raise TypeError("must be real number")

def asin(x):
    if isinstance(x, float):
        if isnan(x):
            return x
        elif x >= -1.0 and x <= 1.0:
            return call_host("(lambda (x) (py-float-from-scheme (flasin (py-float-to-scheme x))))", x)
        else:
            return ValueError("math domain error")
    elif isinstance(x, int):
        if x >= -1 and x <= 1:
            return call_host("(lambda (x) (py-float-from-scheme (flasin (py-float-to-scheme x))))", float(x))
        else:
            return ValueError("math domain error")
        return x
    else:
        raise TypeError("must be real number")

def atan(x):
    if isinstance(x, float):
        return call_host("(lambda (x) (py-float-from-scheme (flatan (py-float-to-scheme x))))", x)
    elif isinstance(x, int):
        return call_host("(lambda (x) (py-float-from-scheme (flatan (py-float-to-scheme x))))", float(x))
    else:
        raise TypeError("must be real number")

def atan2(y, x):
    if isinstance(y, float):
        if isinstance(x, float):
            return call_host("(lambda (y x) (py-float-from-scheme (flatan (py-float-to-scheme y) (py-float-to-scheme x))))", y, x)
        elif isinstance(x, int):
            return call_host("(lambda (y x) (py-float-from-scheme (flatan (py-float-to-scheme y) (py-float-to-scheme x))))", y, float(x))
        else:
            raise TypeError("must be real number")
    elif isinstance(y, int):
        if isinstance(x, float):
            return call_host("(lambda (y x) (py-float-from-scheme (flatan (py-float-to-scheme y) (py-float-to-scheme x))))", float(y), x)
        elif isinstance(x, int):
            return call_host("(lambda (y x) (py-float-from-scheme (flatan (py-float-to-scheme y) (py-float-to-scheme x))))", float(y), float(x))
        else:
            raise TypeError("must be real number")
    else:
        raise TypeError("must be real number")

def cos(x):
    if isinstance(x, float):
        return call_host("(lambda (x) (py-float-from-scheme (flcos (py-float-to-scheme x))))", x)
    elif isinstance(x, int):
        return call_host("(lambda (x) (py-float-from-scheme (flcos (py-float-to-scheme x))))", float(x))
    else:
        raise TypeError("must be real number")

def dist(p, q):
    raise NotImplementedError("math.dist(p, q) not implemented")

def hypot(*coordinates):
    raise NotImplementedError("math.hypot(*coordinates) not implemented")

def sin(x):
    if isinstance(x, float):
        return call_host("(lambda (x) (py-float-from-scheme (flsin (py-float-to-scheme x))))", x)
    elif isinstance(x, int):
        return call_host("(lambda (x) (py-float-from-scheme (flsin (py-float-to-scheme x))))", float(x))
    else:
        raise TypeError("must be real number")

def tan(x):
    if isinstance(x, float):
        return call_host("(lambda (x) (py-float-from-scheme (fltan (py-float-to-scheme x))))", x)
    elif isinstance(x, int):
        return call_host("(lambda (x) (py-float-from-scheme (fltan (py-float-to-scheme x))))", float(x))
    else:
        raise TypeError("must be real number")

def degrees(x):
    if isinstance(x, float) or isinstance(x, int):
        return x * 57.29577951308232
    else:
        raise TypeError("must be real number")

def radians(x):
    if isinstance(x, float) or isinstance(x, int):
        return x * 0.017453292519943295
    else:
        raise TypeError("must be real number")

def acosh(x):
    if isinstance(x, float):
        if isnan(x):
            return x
        elif x >= 1.0:
            return call_host("(lambda (x) (py-float-from-scheme (flacosh (py-float-to-scheme x))))", x)
        else:
            return ValueError("math domain error")
    elif isinstance(x, int):
        if x >= 1:
            return call_host("(lambda (x) (py-float-from-scheme (flacosh (py-float-to-scheme x))))", float(x))
        else:
            return ValueError("math domain error")
    else:
        raise TypeError("must be real number")

def asinh(x):
    if isinstance(x, float):
        return call_host("(lambda (x) (py-float-from-scheme (flasinh (py-float-to-scheme x))))", x)
    elif isinstance(x, int):
        return call_host("(lambda (x) (py-float-from-scheme (flasinh (py-float-to-scheme x))))", float(x))
    else:
        raise TypeError("must be real number")

def atanh(x):
    if isinstance(x, float):
        if isnan(x):
            return x
        elif x > -1.0:
            return call_host("(lambda (x) (py-float-from-scheme (flatanh (py-float-to-scheme x))))", x)
        else:
            return ValueError("math domain error")
    elif isinstance(x, int):
        if x > -1:
            return call_host("(lambda (x) (py-float-from-scheme (flatanh (py-float-to-scheme x))))", float(x))
        else:
            return ValueError("math domain error")
    else:
        raise TypeError("must be real number")

def cosh(x):
    if isinstance(x, float):
        return call_host("(lambda (x) (py-float-from-scheme (flcosh (py-float-to-scheme x))))", x)
    elif isinstance(x, int):
        return call_host("(lambda (x) (py-float-from-scheme (flcosh (py-float-to-scheme x))))", float(x))
    else:
        raise TypeError("must be real number")

def sinh(x):
    if isinstance(x, float):
        return call_host("(lambda (x) (py-float-from-scheme (flsinh (py-float-to-scheme x))))", x)
    elif isinstance(x, int):
        return call_host("(lambda (x) (py-float-from-scheme (flsinh (py-float-to-scheme x))))", float(x))
    else:
        raise TypeError("must be real number")

def tanh(x):
    if isinstance(x, float):
        return call_host("(lambda (x) (py-float-from-scheme (fltanh (py-float-to-scheme x))))", x)
    elif isinstance(x, int):
        return call_host("(lambda (x) (py-float-from-scheme (fltanh (py-float-to-scheme x))))", float(x))
    else:
        raise TypeError("must be real number")

def erf(x):
    raise NotImplementedError("math.erf(x) not implemented")

def erfc(x):
    raise NotImplementedError("math.erfc(x) not implemented")

def gamma(x):
    raise NotImplementedError("math.gamma(x) not implemented")

def lgamma(x):
    raise NotImplementedError("math.lgamma(x) not implemented")

pi = 3.141592653589793
e = 2.718281828459045
tau = 6.283185307179586
inf = 2.0**2000 # float("inf")
nan = inf-inf # float("nan")
