from __compiler_intrinsics__ import define_semantics,
                                    use_static_builtins,
                                    use_simple_scoping,
                                    class_getattr,
                                    absent

# Auto-generated
@define_semantics
@use_static_builtins
@use_simple_scoping
def sem_add(x, y):
    def normal():
        magic_method = class_getattr(x, "__add__")
        if magic_method is absent:
            return reflected()
        else:
            result = magic_method(x, y)
            if result is NotImplemented:
                return reflected()
            else:
                return result

    def reflected():
        magic_method = class_getattr(y, "__radd__")
        if magic_method is absent:
            return err()
        else:
            result = magic_method(y, x)
            if result is NotImplemented:
                return err()
            else:
                return result

    def err():
        raise ValueError

    return normal()

# Auto-generated
@define_semantics
@use_static_builtins
@use_simple_scoping
def sem_sub(x, y):
    def normal():
        magic_method = class_getattr(x, "__sub__")
        if magic_method is absent:
            return reflected()
        else:
            result = magic_method(x, y)
            if result is NotImplemented:
                return reflected()
            else:
                return result

    def reflected():
        magic_method = class_getattr(y, "__rsub__")
        if magic_method is absent:
            return err()
        else:
            result = magic_method(y, x)
            if result is NotImplemented:
                return err()
            else:
                return result

    def err():
        raise ValueError

    return normal()

# Auto-generated
@define_semantics
@use_static_builtins
@use_simple_scoping
def sem_mul(x, y):
    def normal():
        magic_method = class_getattr(x, "__mul__")
        if magic_method is absent:
            return reflected()
        else:
            result = magic_method(x, y)
            if result is NotImplemented:
                return reflected()
            else:
                return result

    def reflected():
        magic_method = class_getattr(y, "__rmul__")
        if magic_method is absent:
            return err()
        else:
            result = magic_method(y, x)
            if result is NotImplemented:
                return err()
            else:
                return result

    def err():
        raise ValueError

    return normal()

# Auto-generated
@define_semantics
@use_static_builtins
@use_simple_scoping
def sem_truediv(x, y):
    def normal():
        magic_method = class_getattr(x, "__truediv__")
        if magic_method is absent:
            return reflected()
        else:
            result = magic_method(x, y)
            if result is NotImplemented:
                return reflected()
            else:
                return result

    def reflected():
        magic_method = class_getattr(y, "__rtruediv__")
        if magic_method is absent:
            return err()
        else:
            result = magic_method(y, x)
            if result is NotImplemented:
                return err()
            else:
                return result

    def err():
        raise ValueError

    return normal()

# Auto-generated
@define_semantics
@use_static_builtins
@use_simple_scoping
def sem_floordiv(x, y):
    def normal():
        magic_method = class_getattr(x, "__floordiv__")
        if magic_method is absent:
            return reflected()
        else:
            result = magic_method(x, y)
            if result is NotImplemented:
                return reflected()
            else:
                return result

    def reflected():
        magic_method = class_getattr(y, "__rfloordiv__")
        if magic_method is absent:
            return err()
        else:
            result = magic_method(y, x)
            if result is NotImplemented:
                return err()
            else:
                return result

    def err():
        raise ValueError

    return normal()

# Auto-generated
@define_semantics
@use_static_builtins
@use_simple_scoping
def sem_mod(x, y):
    def normal():
        magic_method = class_getattr(x, "__mod__")
        if magic_method is absent:
            return reflected()
        else:
            result = magic_method(x, y)
            if result is NotImplemented:
                return reflected()
            else:
                return result

    def reflected():
        magic_method = class_getattr(y, "__rmod__")
        if magic_method is absent:
            return err()
        else:
            result = magic_method(y, x)
            if result is NotImplemented:
                return err()
            else:
                return result

    def err():
        raise ValueError

    return normal()

# Auto-generated
@define_semantics
@use_static_builtins
@use_simple_scoping
def sem_pow(x, y):
    def normal():
        magic_method = class_getattr(x, "__pow__")
        if magic_method is absent:
            return reflected()
        else:
            result = magic_method(x, y)
            if result is NotImplemented:
                return reflected()
            else:
                return result

    def reflected():
        magic_method = class_getattr(y, "__rpow__")
        if magic_method is absent:
            return err()
        else:
            result = magic_method(y, x)
            if result is NotImplemented:
                return err()
            else:
                return result

    def err():
        raise ValueError

    return normal()

# Auto-generated
@define_semantics
@use_static_builtins
@use_simple_scoping
def sem_lshift(x, y):
    def normal():
        magic_method = class_getattr(x, "__lshift__")
        if magic_method is absent:
            return reflected()
        else:
            result = magic_method(x, y)
            if result is NotImplemented:
                return reflected()
            else:
                return result

    def reflected():
        magic_method = class_getattr(y, "__rlshift__")
        if magic_method is absent:
            return err()
        else:
            result = magic_method(y, x)
            if result is NotImplemented:
                return err()
            else:
                return result

    def err():
        raise ValueError

    return normal()

# Auto-generated
@define_semantics
@use_static_builtins
@use_simple_scoping
def sem_rshift(x, y):
    def normal():
        magic_method = class_getattr(x, "__rshift__")
        if magic_method is absent:
            return reflected()
        else:
            result = magic_method(x, y)
            if result is NotImplemented:
                return reflected()
            else:
                return result

    def reflected():
        magic_method = class_getattr(y, "__rrshift__")
        if magic_method is absent:
            return err()
        else:
            result = magic_method(y, x)
            if result is NotImplemented:
                return err()
            else:
                return result

    def err():
        raise ValueError

    return normal()

# Auto-generated
@define_semantics
@use_static_builtins
@use_simple_scoping
def sem_and(x, y):
    def normal():
        magic_method = class_getattr(x, "__and__")
        if magic_method is absent:
            return reflected()
        else:
            result = magic_method(x, y)
            if result is NotImplemented:
                return reflected()
            else:
                return result

    def reflected():
        magic_method = class_getattr(y, "__rand__")
        if magic_method is absent:
            return err()
        else:
            result = magic_method(y, x)
            if result is NotImplemented:
                return err()
            else:
                return result

    def err():
        raise ValueError

    return normal()

# Auto-generated
@define_semantics
@use_static_builtins
@use_simple_scoping
def sem_or(x, y):
    def normal():
        magic_method = class_getattr(x, "__or__")
        if magic_method is absent:
            return reflected()
        else:
            result = magic_method(x, y)
            if result is NotImplemented:
                return reflected()
            else:
                return result

    def reflected():
        magic_method = class_getattr(y, "__ror__")
        if magic_method is absent:
            return err()
        else:
            result = magic_method(y, x)
            if result is NotImplemented:
                return err()
            else:
                return result

    def err():
        raise ValueError

    return normal()

# Auto-generated
@define_semantics
@use_static_builtins
@use_simple_scoping
def sem_xor(x, y):
    def normal():
        magic_method = class_getattr(x, "__xor__")
        if magic_method is absent:
            return reflected()
        else:
            result = magic_method(x, y)
            if result is NotImplemented:
                return reflected()
            else:
                return result

    def reflected():
        magic_method = class_getattr(y, "__rxor__")
        if magic_method is absent:
            return err()
        else:
            result = magic_method(y, x)
            if result is NotImplemented:
                return err()
            else:
                return result

    def err():
        raise ValueError

    return normal()

# Auto-generated
@define_semantics
@use_static_builtins
@use_simple_scoping
def sem_matmul(x, y):
    def normal():
        magic_method = class_getattr(x, "__matmul__")
        if magic_method is absent:
            return reflected()
        else:
            result = magic_method(x, y)
            if result is NotImplemented:
                return reflected()
            else:
                return result

    def reflected():
        magic_method = class_getattr(y, "__rmatmul__")
        if magic_method is absent:
            return err()
        else:
            result = magic_method(y, x)
            if result is NotImplemented:
                return err()
            else:
                return result

    def err():
        raise ValueError

    return normal()

@define_semantics
@use_static_builtins
@use_simple_scoping
def sem_getattribute(obj, attr):
    __getattribute__ = class_getattr(obj, "__getattribute__")
    try:
        return __getattribute__(obj, attr)
    except AttributeError:
        __getattr__ = class_getattr(obj, "__getattr__")
        if __getattr__ is absent:
            raise
        else:
            return __getattr__(obj, attr)
