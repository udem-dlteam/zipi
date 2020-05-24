from __compiler_intrinsics__ import define_semantics, class_getattr, absent,

# Auto-generated
@define_semantics
def sem_add(x, y):
    def normal(x, y):
        __add__ = class_getattr(x, "__add__")
        if __add__ is absent:
            return reflected(x, y)
        else:
            result = __add__(x, y)
            if result is NotImplemented:
                return reflected(x, y)
            else:
                return result

    def reflected(x, y):
        __radd__ = class_getattr(y, "__radd__")
        if __radd__ is absent:
            return err()
        else:
            y_result = __radd__(y, x)
            if y_result is NotImplemented:
                return err()
            else:
                return y_result

    def err():
        raise ValueError

    return normal(x, y)

# Auto-generated
@define_semantics
def sem_sub(x, y):
    def normal(x, y):
        __sub__ = class_getattr(x, "__sub__")
        if __sub__ is absent:
            return reflected(x, y)
        else:
            result = __sub__(x, y)
            if result is NotImplemented:
                return reflected(x, y)
            else:
                return result

    def reflected(x, y):
        __rsub__ = class_getattr(y, "__rsub__")
        if __rsub__ is absent:
            return err()
        else:
            y_result = __rsub__(y, x)
            if y_result is NotImplemented:
                return err()
            else:
                return y_result

    def err():
        raise ValueError

    return normal(x, y)

# Auto-generated
@define_semantics
def sem_mul(x, y):
    def normal(x, y):
        __mul__ = class_getattr(x, "__mul__")
        if __mul__ is absent:
            return reflected(x, y)
        else:
            result = __mul__(x, y)
            if result is NotImplemented:
                return reflected(x, y)
            else:
                return result

    def reflected(x, y):
        __rmul__ = class_getattr(y, "__rmul__")
        if __rmul__ is absent:
            return err()
        else:
            y_result = __rmul__(y, x)
            if y_result is NotImplemented:
                return err()
            else:
                return y_result

    def err():
        raise ValueError

    return normal(x, y)

# Auto-generated
@define_semantics
def sem_truediv(x, y):
    def normal(x, y):
        __truediv__ = class_getattr(x, "__truediv__")
        if __truediv__ is absent:
            return reflected(x, y)
        else:
            result = __truediv__(x, y)
            if result is NotImplemented:
                return reflected(x, y)
            else:
                return result

    def reflected(x, y):
        __rtruediv__ = class_getattr(y, "__rtruediv__")
        if __rtruediv__ is absent:
            return err()
        else:
            y_result = __rtruediv__(y, x)
            if y_result is NotImplemented:
                return err()
            else:
                return y_result

    def err():
        raise ValueError

    return normal(x, y)

# Auto-generated
@define_semantics
def sem_floordiv(x, y):
    def normal(x, y):
        __floordiv__ = class_getattr(x, "__floordiv__")
        if __floordiv__ is absent:
            return reflected(x, y)
        else:
            result = __floordiv__(x, y)
            if result is NotImplemented:
                return reflected(x, y)
            else:
                return result

    def reflected(x, y):
        __rfloordiv__ = class_getattr(y, "__rfloordiv__")
        if __rfloordiv__ is absent:
            return err()
        else:
            y_result = __rfloordiv__(y, x)
            if y_result is NotImplemented:
                return err()
            else:
                return y_result

    def err():
        raise ValueError

    return normal(x, y)

# Auto-generated
@define_semantics
def sem_mod(x, y):
    def normal(x, y):
        __mod__ = class_getattr(x, "__mod__")
        if __mod__ is absent:
            return reflected(x, y)
        else:
            result = __mod__(x, y)
            if result is NotImplemented:
                return reflected(x, y)
            else:
                return result

    def reflected(x, y):
        __rmod__ = class_getattr(y, "__rmod__")
        if __rmod__ is absent:
            return err()
        else:
            y_result = __rmod__(y, x)
            if y_result is NotImplemented:
                return err()
            else:
                return y_result

    def err():
        raise ValueError

    return normal(x, y)

# Auto-generated
@define_semantics
def sem_pow(x, y):
    def normal(x, y):
        __pow__ = class_getattr(x, "__pow__")
        if __pow__ is absent:
            return reflected(x, y)
        else:
            result = __pow__(x, y)
            if result is NotImplemented:
                return reflected(x, y)
            else:
                return result

    def reflected(x, y):
        __rpow__ = class_getattr(y, "__rpow__")
        if __rpow__ is absent:
            return err()
        else:
            y_result = __rpow__(y, x)
            if y_result is NotImplemented:
                return err()
            else:
                return y_result

    def err():
        raise ValueError

    return normal(x, y)

# Auto-generated
@define_semantics
def sem_lshift(x, y):
    def normal(x, y):
        __lshift__ = class_getattr(x, "__lshift__")
        if __lshift__ is absent:
            return reflected(x, y)
        else:
            result = __lshift__(x, y)
            if result is NotImplemented:
                return reflected(x, y)
            else:
                return result

    def reflected(x, y):
        __rlshift__ = class_getattr(y, "__rlshift__")
        if __rlshift__ is absent:
            return err()
        else:
            y_result = __rlshift__(y, x)
            if y_result is NotImplemented:
                return err()
            else:
                return y_result

    def err():
        raise ValueError

    return normal(x, y)

# Auto-generated
@define_semantics
def sem_rshift(x, y):
    def normal(x, y):
        __rshift__ = class_getattr(x, "__rshift__")
        if __rshift__ is absent:
            return reflected(x, y)
        else:
            result = __rshift__(x, y)
            if result is NotImplemented:
                return reflected(x, y)
            else:
                return result

    def reflected(x, y):
        __rrshift__ = class_getattr(y, "__rrshift__")
        if __rrshift__ is absent:
            return err()
        else:
            y_result = __rrshift__(y, x)
            if y_result is NotImplemented:
                return err()
            else:
                return y_result

    def err():
        raise ValueError

    return normal(x, y)

# Auto-generated
@define_semantics
def sem_and(x, y):
    def normal(x, y):
        __and__ = class_getattr(x, "__and__")
        if __and__ is absent:
            return reflected(x, y)
        else:
            result = __and__(x, y)
            if result is NotImplemented:
                return reflected(x, y)
            else:
                return result

    def reflected(x, y):
        __rand__ = class_getattr(y, "__rand__")
        if __rand__ is absent:
            return err()
        else:
            y_result = __rand__(y, x)
            if y_result is NotImplemented:
                return err()
            else:
                return y_result

    def err():
        raise ValueError

    return normal(x, y)

# Auto-generated
@define_semantics
def sem_or(x, y):
    def normal(x, y):
        __or__ = class_getattr(x, "__or__")
        if __or__ is absent:
            return reflected(x, y)
        else:
            result = __or__(x, y)
            if result is NotImplemented:
                return reflected(x, y)
            else:
                return result

    def reflected(x, y):
        __ror__ = class_getattr(y, "__ror__")
        if __ror__ is absent:
            return err()
        else:
            y_result = __ror__(y, x)
            if y_result is NotImplemented:
                return err()
            else:
                return y_result

    def err():
        raise ValueError

    return normal(x, y)

# Auto-generated
@define_semantics
def sem_xor(x, y):
    def normal(x, y):
        __xor__ = class_getattr(x, "__xor__")
        if __xor__ is absent:
            return reflected(x, y)
        else:
            result = __xor__(x, y)
            if result is NotImplemented:
                return reflected(x, y)
            else:
                return result

    def reflected(x, y):
        __rxor__ = class_getattr(y, "__rxor__")
        if __rxor__ is absent:
            return err()
        else:
            y_result = __rxor__(y, x)
            if y_result is NotImplemented:
                return err()
            else:
                return y_result

    def err():
        raise ValueError

    return normal(x, y)

# Auto-generated
@define_semantics
def sem_matmul(x, y):
    def normal(x, y):
        __matmul__ = class_getattr(x, "__matmul__")
        if __matmul__ is absent:
            return reflected(x, y)
        else:
            result = __matmul__(x, y)
            if result is NotImplemented:
                return reflected(x, y)
            else:
                return result

    def reflected(x, y):
        __rmatmul__ = class_getattr(y, "__rmatmul__")
        if __rmatmul__ is absent:
            return err()
        else:
            y_result = __rmatmul__(y, x)
            if y_result is NotImplemented:
                return err()
            else:
                return y_result

    def err():
        raise ValueError

    return normal(x, y)

@define_semantics
def sem_getattribute(obj, attr)
    __getattribute__ = class_getattr(obj, "__getattribute__")
    try:
        return __getattribute__(obj, attr)
    except AttributeError:
        __getattr__ = class_getattr(obj, "__getattr__")
        if __getattr__ is absent:
            raise
        else:
            return __getattr__(obj, attr)
