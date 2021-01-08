from __compiler_intrinsics__ import absent, builtin_class, int_box, int_unbox, float_box, float_unbox

@builtin_class
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


    def __add__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return int_box(int_unbox(self) + int_unbox(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__add__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __radd__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return int_box(int_unbox(other) + int_unbox(self))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__radd__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __iadd__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return int_box(int_unbox(self) + int_unbox(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__iadd__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __and__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return int_box(int_unbox(self) & int_unbox(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__and__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __rand__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return int_box(int_unbox(other) & int_unbox(self))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__rand__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __iand__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return int_box(int_unbox(self) & int_unbox(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__iand__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __or__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return int_box(int_unbox(self) | int_unbox(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__or__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __ror__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return int_box(int_unbox(other) | int_unbox(self))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__ror__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __ior__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return int_box(int_unbox(self) | int_unbox(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__ior__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __lshift__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return int_box(int_unbox(self) << int_unbox(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__lshift__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __rlshift__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return int_box(int_unbox(other) << int_unbox(self))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__rlshift__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __ilshift__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return int_box(int_unbox(self) << int_unbox(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__ilshift__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __mul__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return int_box(int_unbox(self) * int_unbox(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__mul__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __rmul__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return int_box(int_unbox(other) * int_unbox(self))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__rmul__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __imul__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return int_box(int_unbox(self) * int_unbox(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__imul__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __pow__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return int_box(int_unbox(self) ** int_unbox(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__pow__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __rpow__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return int_box(int_unbox(other) ** int_unbox(self))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__rpow__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __ipow__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return int_box(int_unbox(self) ** int_unbox(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__ipow__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __rshift__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return int_box(int_unbox(self) >> int_unbox(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__rshift__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __rrshift__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return int_box(int_unbox(other) >> int_unbox(self))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__rrshift__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __irshift__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return int_box(int_unbox(self) >> int_unbox(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__irshift__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __sub__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return int_box(int_unbox(self) - int_unbox(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__sub__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __rsub__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return int_box(int_unbox(other) - int_unbox(self))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__rsub__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __isub__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return int_box(int_unbox(self) - int_unbox(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__isub__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __xor__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return int_box(int_unbox(self) ^ int_unbox(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__xor__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __rxor__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return int_box(int_unbox(other) ^ int_unbox(self))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__rxor__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __ixor__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return int_box(int_unbox(self) ^ int_unbox(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__ixor__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __floordiv__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                if other != 0:
                    return int_box(int_unbox(self) // int_unbox(other))
                else:
                    raise ZeroDivisionError("integer division by zero")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__floordiv__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __rfloordiv__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                if self != 0:
                    return int_box(int_unbox(other) // int_unbox(self))
                else:
                    raise ZeroDivisionError("integer division by zero")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__rfloordiv__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __ifloordiv__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                if other != 0:
                    return int_box(int_unbox(self) // int_unbox(other))
                else:
                    raise ZeroDivisionError("integer division by zero")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__ifloordiv__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __truediv__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                if other != 0:
                    return float_box(int_unbox(self) / int_unbox(other))
                else:
                    raise ZeroDivisionError("division by zero")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__truediv__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __rtruediv__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                if self != 0:
                    return float_box(int_unbox(other) / int_unbox(self))
                else:
                    raise ZeroDivisionError("division by zero")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__rtruediv__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __itruediv__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                if other != 0:
                    return float_box(int_unbox(self) / int_unbox(other))
                else:
                    raise ZeroDivisionError("division by zero")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__itruediv__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __mod__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                if other != 0:
                    return int_box(int_unbox(self) % int_unbox(other))
                else:
                    raise ZeroDivisionError("modulo by zero")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__mod__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __rmod__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                if self != 0:
                    return int_box(int_unbox(other) % int_unbox(self))
                else:
                    raise ZeroDivisionError("modulo by zero")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__rmod__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __imod__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                if other != 0:
                    return int_box(int_unbox(self) % int_unbox(other))
                else:
                    raise ZeroDivisionError("modulo by zero")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__imod__' requires a 'int' object but received a '" + type(self).__name__ + "'")


@builtin_class
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

    def __and__(self, other):
        if type(self) is bool:
            if type(other) is bool:
                return self and other
            elif isinstance(other, int):
                return int_box(int_unbox(self) & int_unbox(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__and__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __rand__(self, other):
        if type(self) is bool:
            if type(other) is bool:
                return other and self
            elif isinstance(other, int):
                return int_box(int_unbox(other) & int_unbox(self))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__rand__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __or__(self, other):
        if type(self) is bool:
            if type(other) is bool:
                return self or other
            elif isinstance(other, int):
                return int_box(int_unbox(self) | int_unbox(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__or__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __ror__(self, other):
        if type(self) is bool:
            if type(other) is bool:
                return other or self
            elif isinstance(other, int):
                return int_box(int_unbox(other) | int_unbox(self))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__ror__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __xor__(self, other):
        if type(self) is bool:
            if type(other) is bool:
                return self is not other
            elif isinstance(other, int):
                return int_box(int_unbox(self) ^ int_unbox(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__xor__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __rxor__(self, other):
        if type(self) is bool:
            if type(other) is bool:
                return other is not self
            elif isinstance(other, int):
                return int_box(int_unbox(other) ^ int_unbox(self))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__rxor__' requires a 'int' object but received a '" + type(self).__name__ + "'")


@builtin_class
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


    def __add__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return float_box(float_unbox(self) + float_unbox(other))
            elif isinstance(other, int):
                return float_box(float_unbox(self) + int_unbox(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__add__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __radd__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return float_box(float_unbox(other) + float_unbox(self))
            elif isinstance(other, int):
                return float_box(int_unbox(other) + float_unbox(self))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__radd__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __iadd__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return float_box(float_unbox(self) + float_unbox(other))
            elif isinstance(self, int):
                return float_box(float_unbox(self) + int_unbox(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__iadd__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __mul__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return float_box(float_unbox(self) * float_unbox(other))
            elif isinstance(other, int):
                return float_box(float_unbox(self) * int_unbox(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__mul__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __rmul__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return float_box(float_unbox(other) * float_unbox(self))
            elif isinstance(other, int):
                return float_box(int_unbox(other) * float_unbox(self))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__rmul__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __imul__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return float_box(float_unbox(self) * float_unbox(other))
            elif isinstance(self, int):
                return float_box(float_unbox(self) * int_unbox(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__imul__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __pow__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return float_box(float_unbox(self) ** float_unbox(other))
            elif isinstance(other, int):
                return float_box(float_unbox(self) ** int_unbox(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__pow__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __rpow__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return float_box(float_unbox(other) ** float_unbox(self))
            elif isinstance(other, int):
                return float_box(int_unbox(other) ** float_unbox(self))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__rpow__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __ipow__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return float_box(float_unbox(self) ** float_unbox(other))
            elif isinstance(self, int):
                return float_box(float_unbox(self) ** int_unbox(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__ipow__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __sub__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return float_box(float_unbox(self) - float_unbox(other))
            elif isinstance(other, int):
                return float_box(float_unbox(self) - int_unbox(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__sub__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __rsub__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return float_box(float_unbox(other) - float_unbox(self))
            elif isinstance(other, int):
                return float_box(int_unbox(other) - float_unbox(self))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__rsub__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __isub__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return float_box(float_unbox(self) - float_unbox(other))
            elif isinstance(self, int):
                return float_box(float_unbox(self) - int_unbox(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__isub__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __floordiv__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                if other != 0.0:
                    return float_box(float_unbox(self) // float_unbox(other))
                else:
                    raise ZeroDivisionError("float division by zero")
            elif isinstance(other, int):
                if other != 0:
                    return float_box(float_unbox(self) // int_unbox(other))
                else:
                    raise ZeroDivisionError("float division by zero")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__floordiv__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __rfloordiv__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                if self != 0.0:
                    return float_box(float_unbox(other) // float_unbox(self))
                else:
                    raise ZeroDivisionError("float division by zero")
            elif isinstance(other, int):
                if self != 0.0:
                    return float_box(int_unbox(other) // float_unbox(self))
                else:
                    raise ZeroDivisionError("float division by zero")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__rfloordiv__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __ifloordiv__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                if other != 0.0:
                    return float_box(float_unbox(self) // float_unbox(other))
                else:
                    raise ZeroDivisionError("float division by zero")
            elif isinstance(other, int):
                if other != 0:
                    return float_box(float_unbox(self) // int_unbox(other))
                else:
                    raise ZeroDivisionError("float division by zero")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__ifloordiv__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __truediv__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                if other != 0.0:
                    return float_box(float_unbox(self) / float_unbox(other))
                else:
                    raise ZeroDivisionError("float division by zero")
            elif isinstance(other, int):
                if other != 0:
                    return float_box(float_unbox(self) / int_unbox(other))
                else:
                    raise ZeroDivisionError("float division by zero")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__truediv__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __rtruediv__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                if self != 0.0:
                    return float_box(float_unbox(other) / float_unbox(self))
                else:
                    raise ZeroDivisionError("float division by zero")
            elif isinstance(other, int):
                if self != 0.0:
                    return float_box(int_unbox(other) / float_unbox(self))
                else:
                    raise ZeroDivisionError("float division by zero")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__rtruediv__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __itruediv__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                if other != 0.0:
                    return float_box(float_unbox(self) / float_unbox(other))
                else:
                    raise ZeroDivisionError("float division by zero")
            elif isinstance(other, int):
                if other != 0:
                    return float_box(float_unbox(self) / int_unbox(other))
                else:
                    raise ZeroDivisionError("float division by zero")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__itruediv__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __mod__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                if other != 0.0:
                    return float_box(float_unbox(self) % float_unbox(other))
                else:
                    raise ZeroDivisionError("float modulo by zero")
            elif isinstance(other, int):
                if other != 0:
                    return float_box(float_unbox(self) % int_unbox(other))
                else:
                    raise ZeroDivisionError("float modulo by zero")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__mod__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __rmod__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                if self != 0.0:
                    return float_box(float_unbox(other) % float_unbox(self))
                else:
                    raise ZeroDivisionError("float modulo by zero")
            elif isinstance(other, int):
                if self != 0.0:
                    return float_box(int_unbox(other) % float_unbox(self))
                else:
                    raise ZeroDivisionError("float modulo by zero")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__rmod__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __imod__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                if other != 0.0:
                    return float_box(float_unbox(self) % float_unbox(other))
                else:
                    raise ZeroDivisionError("float modulo by zero")
            elif isinstance(other, int):
                if other != 0:
                    return float_box(float_unbox(self) % int_unbox(other))
                else:
                    raise ZeroDivisionError("float modulo by zero")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__imod__' requires a 'float' object but received a '" + type(self).__name__ + "'")
