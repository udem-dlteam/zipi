# ======================================================================================================================
#   semantics templates
# ======================================================================================================================

semantics_template = \
    """from __compiler_intrinsics__ import define_semantics, use_static_builtins, use_simple_scoping, class_getattr, absent

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
        raise TypeError("unsupported operand type(s) for {symbol}: '" + type(x).__name__ + "' and '" + type(y).__name__ + "'")

    # {op}:start-body
    return normal()
    # {op}:end-body"""

arithmetic_info = {'add': {"op": "add", "magic_method": "add", "symbol": "+"},
                   'bitand': {"op": "bitand", "magic_method": "and", "symbol": "&"},
                   'bitor': {"op": "bitor", "magic_method": "or", "symbol": "|"},
                   'floordiv': {"op": "floordiv", "magic_method": "floordiv", "symbol": "//"},
                   'lshift': {"op": "lshift", "magic_method": "lshift", "symbol": "<<"},
                   'matmul': {"op": "matmul", "magic_method": "matmul", "symbol": "@"},
                   'mod': {"op": "mod", "magic_method": "mod", "symbol": "%"},
                   'mul': {"op": "mul", "magic_method": "mul", "symbol": "*"},
                   'pow': {"op": "pow", "magic_method": "pow", "symbol": "**"},
                   'rshift': {"op": "rshift", "magic_method": "rshift", "symbol": ">>"},
                   'sub': {"op": "sub", "magic_method": "sub", "symbol": "-"},
                   'truediv': {"op": "truediv", "magic_method": "truediv", "symbol": "/"},
                   'xor': {"op": "xor", "magic_method": "xor", "symbol": "^"},
                   }

inplace_arithmetic_template = \
    """# Auto-generated
@define_semantics
def i{op}(x, y):
    def inplace():
        magic_method = class_getattr(x, "__i{magic_method}__")
        if magic_method is absent:
            return normal()
        else:
            result = magic_method(x, y)
            if result is NotImplemented:
                return normal()
            else:
                return result

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
        raise TypeError("unsupported operand type(s) for {symbol}: '" + type(x).__name__ + "' and '" + type(y).__name__ + "'")

    # i{op}:start-body
    return inplace()
    # i{op}:end-body"""

inplace_arithmetic_info = {'iadd': {"op": "add", "magic_method": "add", "symbol": "+="},
                           'ibitand': {"op": "bitand", "magic_method": "and", "symbol": "&="},
                           'ibitor': {"op": "bitor", "magic_method": "or", "symbol": "|="},
                           'ifloordiv': {"op": "floordiv", "magic_method": "floordiv", "symbol": "//="},
                           'ilshift': {"op": "lshift", "magic_method": "lshift", "symbol": "<<="},
                           'imatmul': {"op": "matmul", "magic_method": "matmul", "symbol": "@="},
                           'imod': {"op": "mod", "magic_method": "mod", "symbol": "%="},
                           'imul': {"op": "mul", "magic_method": "mul", "symbol": "*="},
                           'ipow': {"op": "pow", "magic_method": "pow", "symbol": "**="},
                           'irshift': {"op": "rshift", "magic_method": "rshift", "symbol": ">>="},
                           'isub': {"op": "sub", "magic_method": "sub", "symbol": "-="},
                           'itruediv': {"op": "truediv", "magic_method": "truediv", "symbol": "/="},
                           'ixor': {"op": "xor", "magic_method": "xor", "symbol": "^="},
                           }

comparison_template = \
    """# Auto-generated
@define_semantics
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
        magic_method = class_getattr(y, "__{reflected_magic_method}__")
        if magic_method is absent:
            return err()
        else:
            result = magic_method(y, x)
            if result is NotImplemented:
                return err()
            else:
                return result

    def err():
        raise TypeError("'{symbol}' not supported between instances of '" + type(x).__name__ + "' and '" + type(y).__name__ + "'")

    # {op}:start-body
    return normal()
    # {op}:end-body"""

comparison_info = {
    "ge": {"op": "ge", "magic_method": "ge", "reflected_magic_method": "le", "symbol": ">="},
    "gt": {"op": "gt", "magic_method": "gt", "reflected_magic_method": "lt", "symbol": ">"},
    "le": {"op": "le", "magic_method": "le", "reflected_magic_method": "ge", "symbol": "<="},
    "lt": {"op": "lt", "magic_method": "lt", "reflected_magic_method": "gt", "symbol": "<"}
}

equality_template = \
    """# Auto-generated
@define_semantics
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
        magic_method = class_getattr(y, "__{reflected_magic_method}__")
        if magic_method is absent:
            return default()
        else:
            result = magic_method(y, x)
            if result is NotImplemented:
                return default()
            else:
                return result

    def default():
        return x {default_symbol} y 

    # {op}:start-body
    return normal()
    # {op}:end-body"""

equality_info = {
    "eq": {"op": "eq", "magic_method": "eq", "reflected_magic_method": "eq", "default_symbol": "is"},
    "ne": {"op": "ne", "magic_method": "ne", "reflected_magic_method": "ne", "default_symbol": "is not"},
}

# ======================================================================================================================
#   int class templates
# ======================================================================================================================


int_binary_method_template = \
    """
    def __{method_name}__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return py_int_from_host(py_int_to_host(self) {op} py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__{method_name}__' requires a 'int' object but received a '" + type(self).__name__ + "'")
"""

int_reflected_binary_method_template = \
    """
    def __r{method_name}__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return py_int_from_host(py_int_to_host(other) {op} py_int_to_host(self))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__r{method_name}__' requires a 'int' object but received a '" + type(self).__name__ + "'")
"""

int_inplace_binary_method_template = \
    """
    def __i{method_name}__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return py_int_from_host(py_int_to_host(self) {op} py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__i{method_name}__' requires a 'int' object but received a '" + type(self).__name__ + "'")
"""

int_shift_method_template = \
    """
    def __{method_name}__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                if other >= 0:
                    return py_int_from_host(py_int_to_host(self) {op} py_int_to_host(other))
                else:
                    raise ValueError("negative shift count")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__{method_name}__' requires a 'int' object but received a '" + type(self).__name__ + "'")
"""

int_reflected_shift_method_template = \
    """
    def __r{method_name}__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                if self >= 0:
                    return py_int_from_host(py_int_to_host(self) {op} py_int_to_host(other))
                else:
                    raise ValueError("negative shift count")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__r{method_name}__' requires a 'int' object but received a '" + type(self).__name__ + "'")
"""

int_inplace_shift_method_template = \
    """
    def __i{method_name}__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                if other >= 0:
                    return py_int_from_host(py_int_to_host(self) {op} py_int_to_host(other))
                else:
                    raise ValueError("negative shift count")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__i{method_name}__' requires a 'int' object but received a '" + type(self).__name__ + "'")
"""

int_division_method_template = \
    """
    def __{method_name}__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                if other != 0:
                    return {box_method}(py_int_to_host(self) {op} py_int_to_host(other))
                else:
                    raise ZeroDivisionError("{error_message}")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__{method_name}__' requires a 'int' object but received a '" + type(self).__name__ + "'")
"""

int_reflected_division_method_template = \
    """
    def __r{method_name}__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                if self != 0:
                    return {box_method}(py_int_to_host(other) {op} py_int_to_host(self))
                else:
                    raise ZeroDivisionError("{error_message}")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__r{method_name}__' requires a 'int' object but received a '" + type(self).__name__ + "'")
"""

int_inplace_division_method_template = \
    """
    def __i{method_name}__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                if other != 0:
                    return {box_method}(py_int_to_host(self) {op} py_int_to_host(other))
                else:
                    raise ZeroDivisionError("{error_message}")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__i{method_name}__' requires a 'int' object but received a '" + type(self).__name__ + "'")
"""

int_comparison_method_template = \
    """
    def __{method_name}__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return py_bool_from_host_bool(py_int_to_host(self) {op} py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__{method_name}__' requires a 'int' object but received a '" + type(self).__name__ + "'")
"""

class_int_template = \
    """@builtin_class
class int:
    @staticmethod
    def __new__(cls, val=absent):
        if cls is int:
            if val is absent:
                return 0
            if isinstance(val, int):
                return py_int_from_host(py_int_to_host(val))
            else:
                raise NotImplementedError
        else:
            raise NotImplementedError

{methods}"""

int_method_info = {
    'add': {"method_name": "add", "op": "+"},
    'bitand': {"method_name": "and", "op": "&"},
    'bitor': {"method_name": "or", "op": "|"},
    'mul': {"method_name": "mul", "op": "*"},
    'pow': {"method_name": "pow", "op": "**"},
    'sub': {"method_name": "sub", "op": "-"},
    'xor': {"method_name": "xor", "op": "^"}
}

int_shift_method_info = {
    'lshift': {"method_name": "lshift", "op": "<<"},
    'rshift': {"method_name": "rshift", "op": ">>"},
}

int_division_method_info = {
    'floordiv': {"method_name": "floordiv", "box_method": "py_int_from_host", "op": "//",
                 "error_message": "integer division by zero"},
    'truediv': {"method_name": "truediv", "box_method": "py_float_from_host", "op": "/", "error_message": "division by zero"},
    'mod': {"method_name": "mod", "box_method": "py_int_from_host", "op": "%", "error_message": "modulo by zero"}
}

int_comparison_method_info = {
    'eq': {"method_name": "eq", "op": "=="},
    'ne': {"method_name": "ne", "op": "!="},
    'ge': {"method_name": "ge", "op": ">="},
    'gt': {"method_name": "gt", "op": ">"},
    'le': {"method_name": "le", "op": "<="},
    'lt': {"method_name": "lt", "op": "<"}
}

# ======================================================================================================================
#   int class templates
# ======================================================================================================================


bool_binary_method_template = \
    """
    def __{method_name}__(self, other):
        if type(self) is bool:
            if type(other) is bool:
                return {bool_expr}
            elif isinstance(other, int):
                return py_int_from_host(py_int_to_host(self) {int_op} py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__{method_name}__' requires a 'bool' object but received a '" + type(self).__name__ + "'")
"""

bool_reflected_binary_method_template = \
    """
    def __r{method_name}__(self, other):
        if type(self) is bool:
            if type(other) is bool:
                return {bool_expr}
            elif isinstance(other, int):
                return py_int_from_host(py_int_to_host(other) {int_op} py_int_to_host(self))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__r{method_name}__' requires a 'bool' object but received a '" + type(self).__name__ + "'")
"""

class_bool_template = \
    """@builtin_class
class bool(int):
    @staticmethod
    def __new__(cls, val=absent):
        if cls is int:
            if val is absent:
                return False
            else:
                return bool(val)
        else:
            raise NotImplementedError
{methods}"""

bool_method_info = {
    'bitand': {"method_name": "and",
               "bool_expr": "other if self is True else False",
               "int_op": "&"},
    'bitor': {"method_name": "or",
              "base": "True",
              "bool_expr": "True if self is True else other",
              "int_op": "|"},
    'xor': {"method_name": "xor", "base": "True",
            "bool_expr": "self is not other",
            "int_op": "^"}
}

# ======================================================================================================================
#   float class templates
# ======================================================================================================================


float_binary_method_template = \
    """
    def __{method_name}__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return py_float_from_host(py_float_to_host(self) {op} py_float_to_host(other))
            elif isinstance(other, int):
                return py_float_from_host(py_float_to_host(self) {op} py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__{method_name}__' requires a 'float' object but received a '" + type(self).__name__ + "'")
"""

float_reflected_binary_method_template = \
    """
    def __r{method_name}__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return py_float_from_host(py_float_to_host(other) {op} py_float_to_host(self))
            elif isinstance(other, int):
                return py_float_from_host(py_int_to_host(other) {op} py_float_to_host(self))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__r{method_name}__' requires a 'float' object but received a '" + type(self).__name__ + "'")
"""

float_inplace_binary_method_template = \
    """
    def __i{method_name}__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return py_float_from_host(py_float_to_host(self) {op} py_float_to_host(other))
            elif isinstance(self, int):
                return py_float_from_host(py_float_to_host(self) {op} py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__i{method_name}__' requires a 'float' object but received a '" + type(self).__name__ + "'")
"""

float_division_method_template = \
    """
    def __{method_name}__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                if other != 0.0:
                    return py_float_from_host(py_float_to_host(self) {op} py_float_to_host(other))
                else:
                    raise ZeroDivisionError("{error_message}")
            elif isinstance(other, int):
                if other != 0:
                    return py_float_from_host(py_float_to_host(self) {op} py_int_to_host(other))
                else:
                    raise ZeroDivisionError("{error_message}")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__{method_name}__' requires a 'float' object but received a '" + type(self).__name__ + "'")
"""

float_reflected_division_method_template = \
    """
    def __r{method_name}__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                if self != 0.0:
                    return py_float_from_host(py_float_to_host(other) {op} py_float_to_host(self))
                else:
                    raise ZeroDivisionError("{error_message}")
            elif isinstance(other, int):
                if self != 0.0:
                    return py_float_from_host(py_int_to_host(other) {op} py_float_to_host(self))
                else:
                    raise ZeroDivisionError("{error_message}")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__r{method_name}__' requires a 'float' object but received a '" + type(self).__name__ + "'")
"""

float_inplace_division_method_template = \
    """
    def __i{method_name}__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                if other != 0.0:
                    return py_float_from_host(py_float_to_host(self) {op} py_float_to_host(other))
                else:
                    raise ZeroDivisionError("{error_message}")
            elif isinstance(other, int):
                if other != 0:
                    return py_float_from_host(py_float_to_host(self) {op} py_int_to_host(other))
                else:
                    raise ZeroDivisionError("{error_message}")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__i{method_name}__' requires a 'float' object but received a '" + type(self).__name__ + "'")
"""

float_comparison_method_template = \
    """
    def __{method_name}__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return py_bool_from_host_bool(py_float_to_host(self) {op} py_float_to_host(other))
            elif isinstance(other, int):
                return py_bool_from_host_bool(py_float_to_host(self) {op} py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__{method_name}__' requires a 'float' object but received a '" + type(self).__name__ + "'")
"""

class_float_template = \
    """@builtin_class
class float:
    @staticmethod
    def __new__(cls, val=absent):
        if cls is int:
            if val is absent:
                return 0.0
            if isinstance(val, float):
                return py_float_from_host(py_float_to_host(val))
            else:
                raise NotImplementedError
        else:
            raise NotImplementedError

{methods}"""

float_method_info = {
    'add': {"method_name": "add", "op": "+"},
    'mul': {"method_name": "mul", "op": "*"},
    'pow': {"method_name": "pow", "op": "**"},
    'sub': {"method_name": "sub", "op": "-"},
}

float_division_method_info = {
    'floordiv': {"method_name": "floordiv", "op": "//", "error_message": "float division by zero"},
    'truediv': {"method_name": "truediv", "op": "/", "error_message": "float division by zero"},
    'mod': {"method_name": "mod", "op": "%", "error_message": "float modulo by zero"}
}

float_comparison_method_info = {
    'eq': {"method_name": "eq", "op": "=="},
    'ne': {"method_name": "ne", "op": "!="},
    'ge': {"method_name": "ge", "op": ">="},
    'gt': {"method_name": "gt", "op": ">"},
    'le': {"method_name": "le", "op": "<="},
    'lt': {"method_name": "lt", "op": "<"}
}

# ======================================================================================================================
#   builtins class templates
# =====================================================================================================================


builtins_template = """\
from __compiler_intrinsics__ import absent, builtin_class, py_int_from_host, py_int_to_host, py_float_from_host, py_float_to_host, py_bool_from_host_bool 

{definitions}"""
