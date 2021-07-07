from itertools import product

from .utils import unknown, get_behavior_name


class Specializations:
    def __init__(self, *, module, function, types, prefix=None, as_test=False):
        self.module = module
        self.function = function
        self.types = types
        if prefix is None:
            if as_test:
                self.prefix = f"py_test_{function}" if prefix is None else prefix
            else:
                self.prefix = f"py_{function}" if prefix is None else prefix
        else:
            self.prefix = prefix
        self.as_test = as_test

    def __iter__(self):
        prefix = self.prefix

        for type_combination in product(*self.types):
            yield get_behavior_name(prefix, type_combination), type_combination


_SPECIALIZATIONS = []


def add_specializations(*args, **kwargs):
    _SPECIALIZATIONS.append(Specializations(*args, **kwargs))


def get_specializations():
    return _SPECIALIZATIONS


default_types = ["sint", "bint", "bool", "float", "str"]
default_binary_types = (default_types, default_types)


def defaults_except(*exceptions):
    return [t for t in default_types if t not in exceptions]

# =============================================================================
# Specializations
# =============================================================================


# Arithmetic semantics
add_specializations(module="semantics", function="add", types=default_binary_types)
add_specializations(module="semantics", function="bitand", types=default_binary_types)
add_specializations(module="semantics", function="bitor", types=default_binary_types)
add_specializations(module="semantics", function="floordiv", types=default_binary_types)
add_specializations(module="semantics", function="lshift", types=default_binary_types)
add_specializations(module="semantics", function="matmul", types=default_binary_types)
add_specializations(module="semantics", function="mod", types=(defaults_except("str"), default_types))
add_specializations(module="semantics", function="mul", types=default_binary_types)
add_specializations(module="semantics", function="pow", types=default_binary_types)
add_specializations(module="semantics", function="rshift", types=default_binary_types)
add_specializations(module="semantics", function="sub", types=default_binary_types)
add_specializations(module="semantics", function="truediv", types=default_binary_types)
add_specializations(module="semantics", function="xor", types=default_binary_types)

# Inplace semantics
add_specializations(module="semantics", function="iadd", types=default_binary_types)
add_specializations(module="semantics", function="ibitand", types=default_binary_types)
add_specializations(module="semantics", function="ibitor", types=default_binary_types)
add_specializations(module="semantics", function="ifloordiv", types=default_binary_types)
add_specializations(module="semantics", function="ilshift", types=default_binary_types)
add_specializations(module="semantics", function="imatmul", types=default_binary_types)
add_specializations(module="semantics", function="imod", types=(defaults_except("str"), default_types))
add_specializations(module="semantics", function="imul", types=default_binary_types)
add_specializations(module="semantics", function="ipow", types=default_binary_types)
add_specializations(module="semantics", function="irshift", types=default_binary_types)
add_specializations(module="semantics", function="isub", types=default_binary_types)
add_specializations(module="semantics", function="itruediv", types=default_binary_types)
add_specializations(module="semantics", function="ixor", types=default_binary_types)

# Comparison semantics
add_specializations(module="semantics", function="ge", types=default_binary_types)
add_specializations(module="semantics", function="gt", types=default_binary_types)
add_specializations(module="semantics", function="le", types=default_binary_types)
add_specializations(module="semantics", function="lt", types=default_binary_types)
add_specializations(module="semantics", function="eq", types=default_binary_types)
add_specializations(module="semantics", function="ne", types=default_binary_types)

add_specializations(module="semantics", function="ge", types=default_binary_types, as_test=True)
add_specializations(module="semantics", function="gt", types=default_binary_types, as_test=True)
add_specializations(module="semantics", function="le", types=default_binary_types, as_test=True)
add_specializations(module="semantics", function="lt", types=default_binary_types, as_test=True)
add_specializations(module="semantics", function="eq", types=default_binary_types, as_test=True)
add_specializations(module="semantics", function="ne", types=default_binary_types, as_test=True)

# Unary semantics
add_specializations(module="semantics", function="pos", types=(default_types,))
add_specializations(module="semantics", function="neg", types=(default_types,))
add_specializations(module="semantics", function="invert", types=(default_types,))
add_specializations(module="semantics", function="truth", types=(default_types,))
add_specializations(module="semantics", function="test", types=(default_types,))

# Other
add_specializations(module="semantics", function="descriptor_get", types=[("function",), (unknown,), (unknown,)])
