"""
Provide a mock version of __compiler_intrinsics__ which registers
cPython method calls to build a virtual table of procedures to be called
for each type combinations of each operation
"""

register = {}

__all__ = ["define_semantics", "inline", "use_static_builtins", "use_simple_scoping", "class_getattr", "absent"]




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


# __compiler_instrinsics__

absent = object()

def inline(f):
    return f

def use_static_builtins(f):
    return f

def use_simple_scoping(f):
    return f

def define_semantics(f):
    register[f.__name__] = f
    return f

def get_own_attr(obj, name):
    return obj.__dict__.get(name, None)

def class_getattr(instance, name):
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
