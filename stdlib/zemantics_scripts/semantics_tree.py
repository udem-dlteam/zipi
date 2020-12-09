import operator

from pprint import pprint
from functools import wraps

def get_type_name(obj):
    return type(obj).__name__

def get_own_attr(obj, name):
    return obj.__dict__.get(name, None)

def class_getattr_with_owner(instance, name):
    cls = type(instance)

    for super_cls in cls.mro():
        attr = get_own_attr(super_cls, name)

        if attr is not None:

            if callable(attr):
                @wraps(attr)
                def wrapped_attr(*args):
                    try:
                        return attr(*args)
                    except Exception as e:
                        return Error(type(e).__name__)
                return super_cls, wrapped_attr

            return super_cls, attr

    return None, None

class Procedure:
    def __init__(self, owner, method, left, right):
        self.owner = owner
        self.method = method
        self.left = left
        self.right = right

    def __repr__(self):
        return f"procedure:{self.method.__qualname__}-{get_type_name(self.right)}"

class ReflectedProcedure(Procedure):
    def __repr__(self):
        return f"reflected:{self.method.__qualname__}-{get_type_name(self.left)}"

class Semantics:
    def __init__(self, semantics, left, right):
        self.semantics = semantics
        self.left = left
        self.right = right

    def __repr__(self):
        return f"goto:{self.semantics}-{get_type_name(self.left)}-{get_type_name(self.right)}"

class Error:
    def __init__(self, reason):
        self.reason = reason

    def __repr__(self):
        return f"error:{self.reason}"


def make_semantics_methods_table(ops):
    return {sem: (f"__{sem}__", f"__r{sem}__") for sem in ops}


def make_virtual_table(semantics_methods, instances):
    virtual_table = {}

    for semantics, (method_name, rmethod_name) in semantics_methods.items():
        virtual_table_semantics = virtual_table.setdefault(semantics, {})

        for left in instances:
            for right in instances:

                left_type_name = get_type_name(left)
                right_type_name = get_type_name(right)

                virtual_table_semantics_left_type = virtual_table_semantics.setdefault(left_type_name, {})

                def normal():
                    owner, method = class_getattr_with_owner(left, method_name)

                    res = method(left, right) if method else NotImplemented

                    if res is NotImplemented:
                        if type(left) is not type(right):
                            reflected()
                        else:
                            pass # virtual_table_semantics_left_type[right_type_name] = Error("NotImplemented")
                    elif isinstance(res, Error):
                        virtual_table_semantics_left_type[right_type_name] = res
                    else:
                        virtual_table_semantics_left_type[right_type_name] = Procedure(owner, method, left, right)

                def reflected():
                    owner, method = class_getattr_with_owner(right, rmethod_name)

                    res = method(right, left) if method else NotImplemented

                    if res is NotImplemented:
                        pass # virtual_table_semantics_left_type[right_type_name] = Error("NotImplemented")
                    elif isinstance(res, Error):
                        virtual_table_semantics_left_type[right_type_name] = res
                    else:
                        virtual_table_semantics_left_type[right_type_name] = Procedure(owner, method, right, left)

                normal()

    return virtual_table

instances = [1, True, 1.0, object(), "foo", list(), dict(), set()]
ops = ['add', 'and', 'contains', 'floordiv', 'lshift', 'matmul', 'mod', 'mul',
       'or', 'pos', 'pow', 'rshift', 'sub', 'truediv',  'xor']

semantics_methods = make_semantics_methods_table(ops)

pprint(make_virtual_table(semantics_methods, instances))