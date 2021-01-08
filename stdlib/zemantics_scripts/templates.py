# ======================================================================================================================
#   semantics templates
# ======================================================================================================================

main_template = \
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

# ======================================================================================================================
#   int class templates
# ======================================================================================================================


int_binary_method_template = \
    """
    def __{method_name}__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return int_box(int_unbox(self) {op} int_unbox(other))
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
                return int_box(int_unbox(other) {op} int_unbox(self))
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
                return int_box(int_unbox(self) {op} int_unbox(other))
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
                    return {box_method}(int_unbox(self) {op} int_unbox(other))
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
                    return {box_method}(int_unbox(other) {op} int_unbox(self))
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
                    return {box_method}(int_unbox(self) {op} int_unbox(other))
                else:
                    raise ZeroDivisionError("{error_message}")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__i{method_name}__' requires a 'int' object but received a '" + type(self).__name__ + "'")
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
                return int_box(int_unbox(val))
            else:
                raise NotImplementedError
        else:
            raise NotImplementedError

{methods}"""


int_method_info = {
    'add': {"method_name": "add", "op": "+"},
    'bitand': {"method_name": "and", "op": "&"},
    'bitor': {"method_name": "or", "op": "|"},
    'lshift': {"method_name": "lshift", "op": "<<"},
    'mul': {"method_name": "mul", "op": "*"},
    'pow': {"method_name": "pow", "op": "**"},
    'rshift': {"method_name": "rshift", "op": ">>"},
    'sub': {"method_name": "sub", "op": "-"},
    'xor': {"method_name": "xor", "op": "^"}
}


int_division_method_info = {
    'floordiv': {"method_name": "floordiv", "box_method": "int_box", "op": "//", "error_message": "integer division by zero"},
    'truediv': {"method_name": "truediv", "box_method": "float_box", "op": "/", "error_message": "division by zero"},
    'mod': {"method_name": "mod", "box_method": "int_box", "op": "%", "error_message": "modulo by zero"}
}

# ======================================================================================================================
#   int class templates
# ======================================================================================================================


bool_binary_method_template = \
"""
    def __{method_name}__(self, other):
        if type(self) is bool:
            if type(other) is bool:
                return self {op} other
            elif isinstance(other, int):
                return int_box(int_unbox(self) {int_op} int_unbox(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__{method_name}__' requires a 'int' object but received a '" + type(self).__name__ + "'")
"""

bool_reflected_binary_method_template = \
"""
    def __r{method_name}__(self, other):
        if type(self) is bool:
            if type(other) is bool:
                return other {op} self
            elif isinstance(other, int):
                return int_box(int_unbox(other) {int_op} int_unbox(self))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__r{method_name}__' requires a 'int' object but received a '" + type(self).__name__ + "'")
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
    'bitand': {"method_name": "and", "op": "and", "int_op": "&"},
    'bitor': {"method_name": "or", "op": "or", "int_op": "|"},
    'xor': {"method_name": "xor", "op": "is not", "int_op": "^"}
}


# ======================================================================================================================
#   float class templates
# ======================================================================================================================


float_binary_method_template = \
"""
    def __{method_name}__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return float_box(float_unbox(self) {op} float_unbox(other))
            elif isinstance(other, int):
                return float_box(float_unbox(self) {op} int_unbox(other))
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
                return float_box(float_unbox(other) {op} float_unbox(self))
            elif isinstance(other, int):
                return float_box(int_unbox(other) {op} float_unbox(self))
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
                return float_box(float_unbox(self) {op} float_unbox(other))
            elif isinstance(self, int):
                return float_box(float_unbox(self) {op} int_unbox(other))
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
                    return float_box(float_unbox(self) {op} float_unbox(other))
                else:
                    raise ZeroDivisionError("{error_message}")
            elif isinstance(other, int):
                if other != 0:
                    return float_box(float_unbox(self) {op} int_unbox(other))
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
                    return float_box(float_unbox(other) {op} float_unbox(self))
                else:
                    raise ZeroDivisionError("{error_message}")
            elif isinstance(other, int):
                if self != 0.0:
                    return float_box(int_unbox(other) {op} float_unbox(self))
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
                    return float_box(float_unbox(self) {op} float_unbox(other))
                else:
                    raise ZeroDivisionError("{error_message}")
            elif isinstance(other, int):
                if other != 0:
                    return float_box(float_unbox(self) {op} int_unbox(other))
                else:
                    raise ZeroDivisionError("{error_message}")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__i{method_name}__' requires a 'float' object but received a '" + type(self).__name__ + "'")
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
                return float_box(float_unbox(val))
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


# ======================================================================================================================
#   builtins class templates
# =====================================================================================================================


builtins_template = """from __compiler_intrinsics__ import absent, builtin_class, int_box, int_unbox, float_box, float_unbox

{definitions}"""


# ======================================================================================================================
#   methods and names
# ======================================================================================================================


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

symbols = {'add': '+',
           'bitand': '&',
           'bitor': '|',
           'floordiv': '//',
           'lshift': '<<',
           'matmul': '@',
           'mod': '%',
           'mul': '*',
           'pow': '**',
           'rshift': '>>',
           'sub': '-',
           'truediv': '/',
           'xor': '^',
           'iadd': '+=',
           'ibitand': '&=',
           'ibitor': '|=',
           'ifloordiv': '//=',
           'ilshift': '<<=',
           'imatmul': '@=',
           'imod': '%=',
           'imul': '*=',
           'ipow': '**=',
           'irshift': '>>=',
           'isub': '-=',
           'itruediv': '/=',
           'ixor': '^='
           }
