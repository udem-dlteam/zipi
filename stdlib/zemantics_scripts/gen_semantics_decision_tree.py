#!/usr/bin/env python3

import argparse, inspect, sys
from functools import wraps
from pprint import pprint
from types import ModuleType

# ======================================================================================================================
#   Helpers
# ======================================================================================================================

def get_type_name(obj):
    return type(obj).__name__


def get_current_semantics_context(semantics_register):
    for frame in inspect.stack():
        function_name = frame.function
        if function_name in semantics_register:
            function = frame.frame.f_globals[function_name]
            signature = inspect.signature(function).parameters
            args = [frame.frame.f_locals[name] for name in signature.keys()]
            return function_name, args
    return None, None

# ======================================================================================================================
#   Semantics Instructions
# ======================================================================================================================

class Procedure:
    def __init__(self, method, semantics_args, method_args):
        self.method = method
        self.semantics_args = semantics_args
        self.method_args = method_args

    def __repr__(self):
        method_qualname = self.method.__qualname__
        method_owner = method_qualname.split('.')[0]
        method_name_id = method_qualname.split(".")[1].replace('_', '')

        args_info = [get_type_name(a) + id_ for a, id_ in zip(self.semantics_args, 'XYZW')]
        args_types = '-'.join(args_info)
        return f"procedure:py-{method_owner}-{method_name_id}-{args_types}"


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

    def register_semantics(name, f):
        semantics_register[name] = f
        return f

    # Module attributes
    absent = object()

    def inline(f):
        return register_semantics(f.__name__, f)

    def use_static_builtins(f):
        return f

    def use_simple_scoping(f):
        return f

    def define_semantics(f):
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
                    current_semantics, semantics_args = get_current_semantics_context(semantics_register)

                    # For which types is it being called?
                    decision_tree_branch = decision_tree.setdefault(current_semantics, {})
                    for argument in semantics_args[:-1]:
                        decision_tree_branch = decision_tree_branch.setdefault(get_type_name(argument), {})

                    last_type_name = get_type_name(semantics_args[-1])

                    try:
                        res = attr(*args)

                        # If NotImplemented is returned, this is not the final magic method so ignore it
                        if res is NotImplemented:
                            # This may or may not be the final magic method call
                            # if it is: then this registers TypeError raised due to illegal operation on those types
                            # if it is not: it will be overwritten on the next call
                            decision_tree_branch[last_type_name] = Error("NotImplemented")

                        else:
                            decision_tree_branch[last_type_name] = Procedure(attr, semantics_args, args)

                        return res

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

def main(filename):
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
                except (TypeError, ValueError):
                    # Silence exception, they were logged in the 'decision_tree'
                    pass

    pprint(decision_tree)

instances = [1, 1.0, True, "foo", []]

if __name__ == '__main__':
    parser = argparse.ArgumentParser()

    parser.add_argument("semantics_file")

    args = parser.parse_args()

    main(args.semantics_file)



