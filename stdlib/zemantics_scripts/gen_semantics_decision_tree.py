import inspect, sys
from functools import wraps
from pprint import pprint
from types import ModuleType

# ======================================================================================================================
#   Helpers
# ======================================================================================================================

def get_type_name(obj):
    return type(obj).__name__


def iter_stack_functions():
    for frame in inspect.stack():
        yield frame.function


def get_current_semantics_name(semantics_register):
    for name in iter_stack_functions():
        if name in semantics_register:
            return name
    return None

# ======================================================================================================================
#   Semantics Instructions
# ======================================================================================================================

class Procedure:
    def __init__(self, method, *args):
        self.method = method
        self.args = args

    def __repr__(self):
        args_types = '-'.join(map(get_type_name, self.args))
        return f"procedure:{self.method.__qualname__}-{args_types}"


class Error:
    def __init__(self, reason):
        self.reason = reason

    def __repr__(self):
        return f"error:{self.reason}"

# ======================================================================================================================
#   __compiler_intrinsics__ module
# ======================================================================================================================

def make_compiler_intrinsics_module():
    # Registers for this module
    semantics_register = {}
    decision_tree = {}

    # Module attributes
    absent = object()

    def inline(f):
        return f

    def use_static_builtins(f):
        return f

    def use_simple_scoping(f):
        return f

    def define_semantics(f):
        semantics_register[f.__name__] = f
        return f

    def get_own_attr(obj, name):
        return obj.__dict__.get(name, None)

    def class_getattr(instance, name):
        cls = type(instance)

        for super_cls in cls.mro():
            attr = get_own_attr(super_cls, name)

            if attr is not None:

                @wraps(attr)
                def wrapped_method(*args):
                    """
                    Wrapper that registers behaviour of the recovered method
                    """

                    # Gather positional information: in which semantics is this method being called?
                    current_semantics = get_current_semantics_name(semantics_register)

                    # For which types is it being called?
                    decision_tree_branch = decision_tree.setdefault(current_semantics, {})
                    for argument in args[:-1]:
                        decision_tree_branch = decision_tree_branch.setdefault(get_type_name(argument), {})

                    last_type_name = get_type_name(args[-1])

                    try:
                        res = attr(*args)

                        # If NotImplemented is returned, this is not the final magic method so ignore it
                        if res is NotImplemented:
                            # This may or may not be the final magic method call
                            # if it is: then this registers TypeError raised due to illegal operation on those types
                            # if it is not: it will be overwritten on the next call
                            decision_tree_branch[last_type_name] = Error("NotImplemented")

                        else:
                            decision_tree_branch[last_type_name] = Procedure(attr, *args)

                    except Exception as e:
                        # An exception can come from a magic method or from
                        decision_tree_branch[last_type_name] = Error(get_type_name(e))
                        raise

                return wrapped_method

        return absent

    # Create module
    _all = ["define_semantics", "inline", "use_static_builtins", "use_simple_scoping", "class_getattr", "absent"]
    _doc = "A mock version of __compiler_intrinsics__ which registers cPython method calls"

    module = ModuleType("__compiler_intrinsics__")

    module.__all__ = _all
    module.__doc__ = _doc

    for name in _all:
        setattr(module, name, locals()[name])

    return module, semantics_register, decision_tree

def main(filename, types):
    instances = [eval(tp)() for tp in types]
    compiler_intrinsics_module, semantics_register, decision_tree = make_compiler_intrinsics_module()

    with open(filename, 'r') as f:
        content = f.read()
        sys.modules["__compiler_intrinsics__"] = compiler_intrinsics_module

        exec(content, {})

    for name, semantics in semantics_register.items():
        for left in instances:
            for right in instances:
                try:
                    semantics(left, right)
                except Exception:
                    # Silence exception, they were logged in the 'decision_tree'
                    pass

    pprint(decision_tree)


main("../zemantics.py", ["int", "float"])



