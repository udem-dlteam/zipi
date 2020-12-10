from __compiler_intrinsics__ import define_semantics, inline, use_static_builtins, use_simple_scoping, class_getattr, absent

# Auto-generated
@define_semantics
@inline
def add(x, y):
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

    # add:start-body
    return normal()
    # add:end-body

# Auto-generated
@define_semantics
@inline
def bitand(x, y):
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

    # bitand:start-body
    return normal()
    # bitand:end-body

# Auto-generated
@define_semantics
@inline
def bitor(x, y):
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

    # bitor:start-body
    return normal()
    # bitor:end-body

# Auto-generated
@define_semantics
@inline
def floordiv(x, y):
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

    # floordiv:start-body
    return normal()
    # floordiv:end-body

# Auto-generated
@define_semantics
@inline
def lshift(x, y):
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

    # lshift:start-body
    return normal()
    # lshift:end-body

# Auto-generated
@define_semantics
@inline
def matmul(x, y):
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

    # matmul:start-body
    return normal()
    # matmul:end-body

# Auto-generated
@define_semantics
@inline
def mod(x, y):
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

    # mod:start-body
    return normal()
    # mod:end-body

# Auto-generated
@define_semantics
@inline
def mul(x, y):
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

    # mul:start-body
    return normal()
    # mul:end-body

# Auto-generated
@define_semantics
@inline
def pow(x, y):
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

    # pow:start-body
    return normal()
    # pow:end-body

# Auto-generated
@define_semantics
@inline
def rshift(x, y):
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

    # rshift:start-body
    return normal()
    # rshift:end-body

# Auto-generated
@define_semantics
@inline
def sub(x, y):
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

    # sub:start-body
    return normal()
    # sub:end-body

# Auto-generated
@define_semantics
@inline
def truediv(x, y):
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

    # truediv:start-body
    return normal()
    # truediv:end-body

# Auto-generated
@define_semantics
@inline
def xor(x, y):
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

    # xor:start-body
    return normal()
    # xor:end-body

# Auto-generated
@define_semantics
@inline
def iadd(x, y):
    def inplace():
        magic_method = class_getattr(x, "__iadd__")
        if magic_method is absent:
            return reflected()
        else:
            result = magic_method(x, y)
            if result is NotImplemented:
                return normal()
            else:
                return result
                
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

    # add:start-body
    return inplace()
    # add:end-body

# Auto-generated
@define_semantics
@inline
def ibitand(x, y):
    def inplace():
        magic_method = class_getattr(x, "__iand__")
        if magic_method is absent:
            return reflected()
        else:
            result = magic_method(x, y)
            if result is NotImplemented:
                return normal()
            else:
                return result
                
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

    # bitand:start-body
    return inplace()
    # bitand:end-body

# Auto-generated
@define_semantics
@inline
def ibitor(x, y):
    def inplace():
        magic_method = class_getattr(x, "__ior__")
        if magic_method is absent:
            return reflected()
        else:
            result = magic_method(x, y)
            if result is NotImplemented:
                return normal()
            else:
                return result
                
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

    # bitor:start-body
    return inplace()
    # bitor:end-body

# Auto-generated
@define_semantics
@inline
def ifloordiv(x, y):
    def inplace():
        magic_method = class_getattr(x, "__ifloordiv__")
        if magic_method is absent:
            return reflected()
        else:
            result = magic_method(x, y)
            if result is NotImplemented:
                return normal()
            else:
                return result
                
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

    # floordiv:start-body
    return inplace()
    # floordiv:end-body

# Auto-generated
@define_semantics
@inline
def ilshift(x, y):
    def inplace():
        magic_method = class_getattr(x, "__ilshift__")
        if magic_method is absent:
            return reflected()
        else:
            result = magic_method(x, y)
            if result is NotImplemented:
                return normal()
            else:
                return result
                
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

    # lshift:start-body
    return inplace()
    # lshift:end-body

# Auto-generated
@define_semantics
@inline
def imatmul(x, y):
    def inplace():
        magic_method = class_getattr(x, "__imatmul__")
        if magic_method is absent:
            return reflected()
        else:
            result = magic_method(x, y)
            if result is NotImplemented:
                return normal()
            else:
                return result
                
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

    # matmul:start-body
    return inplace()
    # matmul:end-body

# Auto-generated
@define_semantics
@inline
def imod(x, y):
    def inplace():
        magic_method = class_getattr(x, "__imod__")
        if magic_method is absent:
            return reflected()
        else:
            result = magic_method(x, y)
            if result is NotImplemented:
                return normal()
            else:
                return result
                
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

    # mod:start-body
    return inplace()
    # mod:end-body

# Auto-generated
@define_semantics
@inline
def imul(x, y):
    def inplace():
        magic_method = class_getattr(x, "__imul__")
        if magic_method is absent:
            return reflected()
        else:
            result = magic_method(x, y)
            if result is NotImplemented:
                return normal()
            else:
                return result
                
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

    # mul:start-body
    return inplace()
    # mul:end-body

# Auto-generated
@define_semantics
@inline
def ipow(x, y):
    def inplace():
        magic_method = class_getattr(x, "__ipow__")
        if magic_method is absent:
            return reflected()
        else:
            result = magic_method(x, y)
            if result is NotImplemented:
                return normal()
            else:
                return result
                
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

    # pow:start-body
    return inplace()
    # pow:end-body

# Auto-generated
@define_semantics
@inline
def irshift(x, y):
    def inplace():
        magic_method = class_getattr(x, "__irshift__")
        if magic_method is absent:
            return reflected()
        else:
            result = magic_method(x, y)
            if result is NotImplemented:
                return normal()
            else:
                return result
                
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

    # rshift:start-body
    return inplace()
    # rshift:end-body

# Auto-generated
@define_semantics
@inline
def isub(x, y):
    def inplace():
        magic_method = class_getattr(x, "__isub__")
        if magic_method is absent:
            return reflected()
        else:
            result = magic_method(x, y)
            if result is NotImplemented:
                return normal()
            else:
                return result
                
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

    # sub:start-body
    return inplace()
    # sub:end-body

# Auto-generated
@define_semantics
@inline
def itruediv(x, y):
    def inplace():
        magic_method = class_getattr(x, "__itruediv__")
        if magic_method is absent:
            return reflected()
        else:
            result = magic_method(x, y)
            if result is NotImplemented:
                return normal()
            else:
                return result
                
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

    # truediv:start-body
    return inplace()
    # truediv:end-body

# Auto-generated
@define_semantics
@inline
def ixor(x, y):
    def inplace():
        magic_method = class_getattr(x, "__ixor__")
        if magic_method is absent:
            return reflected()
        else:
            result = magic_method(x, y)
            if result is NotImplemented:
                return normal()
            else:
                return result
                
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

    # xor:start-body
    return inplace()
    # xor:end-body

@define_semantics
def getattribute(obj, attr):
    # getattribute:start-body
    __getattribute__ = class_getattr(obj, "__getattribute__")
    try:
        return __getattribute__(obj, attr)
    except AttributeError:
        __getattr__ = class_getattr(obj, "__getattr__")
        if __getattr__ is absent:
            raise
        else:
            return __getattr__(obj, attr)
    # getattribute:end-body

@define_semantics
def getitem(obj, index):
    # getitem:start-body
    __getitem__ = class_getattr(obj, "__getitem__")
    if __getitem__ is absent:
        raise TypeError("object is not subscriptable")
    else:
        return __getitem__(obj, index)
    # getitem:end-body

@define_semantics
def setitem(obj, index, value):
    # setitem:start-body
    __setitem__ = class_getattr(obj, "__setitem__")
    if __setitem__ is absent:
        raise TypeError("object does not support item assignment")
    else:
        return __setitem__(obj, index, value)
    # setitem:end-body

@define_semantics
def delitem(obj, index):
    # delitem:start-body
    __delitem__ = class_getattr(obj, "__delitem__")
    if __delitem__ is absent:
        raise TypeError("object does not support item deletion")
    else:
        return __delitem__(obj, index)
    # delitem:end-body

@define_semantics
def enter(obj):
    # enter:start-body
    __enter__ = class_getattr(obj, "__enter__")
    if __enter__ is absent:
        raise AttributeError("__enter__")
    else:
        return __enter__(obj)
    # enter:end-body

@define_semantics
def exit(obj, exc):
    # exit:start-body
    __exit__ = class_getattr(obj, "__exit__")
    if __exit__ is absent:
        raise AttributeError("__exit__")
    elif exc is None:
        return __exit__(obj, None, None, None)
    else:
        # TODO: pass traceback as 4th arg to __exit__ once it exists
        exit_result = __exit__(obj, type(exc), exc, None)
        if exit_result:
            return
        else:
            raise exc
    # exit:end-body