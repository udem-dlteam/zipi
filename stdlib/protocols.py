from __compiler_intrinsics__ import define_protocol, class_getattr, absent

@define_protocol
def py_add_protocol(x, y):
    x__add__ = class_getattr(x, "__add__")
    if x__add__ is absent:
        result = NotImplemented
    else:
        result = x_add__(x, y)

    if result is NotImplemented:
        y__radd__ = class_getattr(y, "__radd__")
        if y__radd__ is absent:
            result = NotImplemented
        else:
            result = y__radd__(x, y)

        if result is NotImplemented:
            raise ValueError
    return result

@define_protocol
def py_sub_protocol(x, y):
    x__sub__ = class_getattr(x, "__sub__")
    if x__sub__ is absent:
        result = NotImplemented
    else:
        result = x_sub__(x, y)

    if result is NotImplemented:
        y__rsub__ = class_getattr(y, "__rsub__")
        if y__rsub__ is absent:
            result = NotImplemented
        else:
            result = y__rsub__(x, y)

        if result is NotImplemented:
            raise ValueError
    return result

@define_protocol
def py_getattribute_protocol(obj, attr)
    obj__getattribute__ = class_getattr(obj, "__getattribute__")
    try:
        return obj__getattribute__(obj, attr)
    except AttributeError:
        obj__getattr__ = class_getattr(obj, "__getattr__")
        if obj__getattr__ is absent:
            raise
        else:
            return __obj__getattr__(obj, attr)
