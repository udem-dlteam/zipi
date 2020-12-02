main_template = \
"""from __compiler_intrinsics__ import define_semantics, inline, use_static_builtins, use_simple_scoping, class_getattr, absent

{arithmetic}

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
    # exit:end-body"""

arithmetic_template = \
"""# Auto-generated
@define_semantics
@inline
def {op}(x, y):
    def normal():
        magic_method = class_getattr(x, "__{magic_method}__")
        if magic_method is absent:
            return reflected()
        else:
            result = magic_method(x, y)
            if result is NotImplemented:
                return reflected()
            else:
                return result

    def reflected():
        magic_method = class_getattr(y, "__r{magic_method}__")
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

    # {op}:start-body
    return normal()
    # {op}:end-body"""

operations = {'add': 'add',
              'bitand': 'and',
              'bitor': 'or',
              'floordiv': 'floordiv',
              'lshift': 'lshift',
              'matmul': 'matmul',
              'mod': 'mod',
              'mul': 'mul',
              'pow': 'pow',
              'rshift': 'rshift',
              'sub': 'sub',
              'truediv': 'truediv',
              'xor': 'xor'}
