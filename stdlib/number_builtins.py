from __compiler_intrinsics__ import absent, builtin_class, int_box, int_subtype_unbox, int_unbox, float_box, float_subtype_unbox, float_unbox

@builtin_type("PyObjectInt")
class int:
    @staticmethod
    def __new__(cls, val=absent):
        if cls is int:
            if val is absent:
                return int_box(0)
            elif type(val) is int:
                return val
            elif isinstance(val, int):
                return int_box(int_subtype_unbox(val))
            else:
                raise NotImplementedError
        else:
            raise NotImplementedError

    def __add__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return int_box(int_unbox(self) + int_unbox(other))
            else:
                return NotImplemented
        else:
            raise TypeError(f"unsupported operand type(s) for +: '{type(self).__name__}' and '{type(other).__name__}'")


@builtin_type("PyObjectInt")
class bool(int):
    pass


@builtin_type("PyObjectFloat")
class float:
    @staticmethod
    def __new__(cls, val=absent):
        if cls is float:
            if val is absent:
                return float_box(0.0)
            elif type(val) is float:
                return val
            elif isinstance(val, float):
                return float_box(float_subtype_unbox(val))
            else:
                raise NotImplementedError
        else:
            raise NotImplementedError

    def __add__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return float_box(float_unbox(self) + float_unbox(other))
            elif isinstance(other, int):
                return float_box(float_unbox(self) + int_unbox(other))
            else:
                return NotImplemented
        else:
            raise TypeError(f"unsupported operand type(s) for +: '{type(self).__name__}' and '{type(other).__name__}'")
