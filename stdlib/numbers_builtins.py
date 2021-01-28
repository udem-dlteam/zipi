from __compiler_intrinsics__ import absent, builtin_class, py_int_from_host, py_int_to_host, py_float_from_host, py_float_to_host, py_bool_from_host_bool 

@builtin_class
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


    def __add__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return py_int_from_host(py_int_to_host(self) + py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__add__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __radd__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return py_int_from_host(py_int_to_host(other) + py_int_to_host(self))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__radd__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __iadd__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return py_int_from_host(py_int_to_host(self) + py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__iadd__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __and__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return py_int_from_host(py_int_to_host(self) & py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__and__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __rand__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return py_int_from_host(py_int_to_host(other) & py_int_to_host(self))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__rand__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __iand__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return py_int_from_host(py_int_to_host(self) & py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__iand__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __or__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return py_int_from_host(py_int_to_host(self) | py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__or__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __ror__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return py_int_from_host(py_int_to_host(other) | py_int_to_host(self))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__ror__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __ior__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return py_int_from_host(py_int_to_host(self) | py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__ior__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __mul__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return py_int_from_host(py_int_to_host(self) * py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__mul__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __rmul__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return py_int_from_host(py_int_to_host(other) * py_int_to_host(self))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__rmul__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __imul__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return py_int_from_host(py_int_to_host(self) * py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__imul__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __pow__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return py_int_from_host(py_int_to_host(self) ** py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__pow__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __rpow__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return py_int_from_host(py_int_to_host(other) ** py_int_to_host(self))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__rpow__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __ipow__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return py_int_from_host(py_int_to_host(self) ** py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__ipow__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __sub__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return py_int_from_host(py_int_to_host(self) - py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__sub__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __rsub__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return py_int_from_host(py_int_to_host(other) - py_int_to_host(self))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__rsub__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __isub__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return py_int_from_host(py_int_to_host(self) - py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__isub__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __xor__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return py_int_from_host(py_int_to_host(self) ^ py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__xor__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __rxor__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return py_int_from_host(py_int_to_host(other) ^ py_int_to_host(self))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__rxor__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __ixor__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return py_int_from_host(py_int_to_host(self) ^ py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__ixor__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __lshift__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                if other >= 0:
                    return py_int_from_host(py_int_to_host(self) << py_int_to_host(other))
                else:
                    raise ValueError("negative shift count")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__lshift__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __rlshift__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                if self >= 0:
                    return py_int_from_host(py_int_to_host(self) << py_int_to_host(other))
                else:
                    raise ValueError("negative shift count")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__rlshift__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __ilshift__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                if other >= 0:
                    return py_int_from_host(py_int_to_host(self) << py_int_to_host(other))
                else:
                    raise ValueError("negative shift count")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__ilshift__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __rshift__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                if other >= 0:
                    return py_int_from_host(py_int_to_host(self) >> py_int_to_host(other))
                else:
                    raise ValueError("negative shift count")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__rshift__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __rrshift__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                if self >= 0:
                    return py_int_from_host(py_int_to_host(self) >> py_int_to_host(other))
                else:
                    raise ValueError("negative shift count")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__rrshift__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __irshift__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                if other >= 0:
                    return py_int_from_host(py_int_to_host(self) >> py_int_to_host(other))
                else:
                    raise ValueError("negative shift count")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__irshift__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __pos__(self):
        if isinstance(self, int):
            return self
        else:
            raise TypeError("descriptor '__pos__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __neg__(self):
        if isinstance(self, int):
            return py_int_from_host(-py_int_to_host(self))
        else:
            raise TypeError("descriptor '__neg__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __invert__(self):
        if isinstance(self, int):
            return py_int_from_host(~py_int_to_host(self))
        else:
            raise TypeError("descriptor '__invert__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __floordiv__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                if other != 0:
                    return py_int_from_host(py_int_to_host(self) // py_int_to_host(other))
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
                    return py_int_from_host(py_int_to_host(other) // py_int_to_host(self))
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
                    return py_int_from_host(py_int_to_host(self) // py_int_to_host(other))
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
                    return py_float_from_host(py_int_to_host(self) / py_int_to_host(other))
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
                    return py_float_from_host(py_int_to_host(other) / py_int_to_host(self))
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
                    return py_float_from_host(py_int_to_host(self) / py_int_to_host(other))
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
                    return py_int_from_host(py_int_to_host(self) % py_int_to_host(other))
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
                    return py_int_from_host(py_int_to_host(other) % py_int_to_host(self))
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
                    return py_int_from_host(py_int_to_host(self) % py_int_to_host(other))
                else:
                    raise ZeroDivisionError("modulo by zero")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__imod__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __eq__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return py_bool_from_host_bool(py_int_to_host(self) == py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__eq__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __ne__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return py_bool_from_host_bool(py_int_to_host(self) != py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__ne__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __ge__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return py_bool_from_host_bool(py_int_to_host(self) >= py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__ge__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __gt__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return py_bool_from_host_bool(py_int_to_host(self) > py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__gt__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __le__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return py_bool_from_host_bool(py_int_to_host(self) <= py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__le__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __lt__(self, other):
        if isinstance(self, int):
            if isinstance(other, int):
                return py_bool_from_host_bool(py_int_to_host(self) < py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__lt__' requires a 'int' object but received a '" + type(self).__name__ + "'")


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
                return other if self is True else False
            elif isinstance(other, int):
                return py_int_from_host(py_int_to_host(self) & py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__and__' requires a 'bool' object but received a '" + type(self).__name__ + "'")

    def __rand__(self, other):
        if type(self) is bool:
            if type(other) is bool:
                return other if self is True else False
            elif isinstance(other, int):
                return py_int_from_host(py_int_to_host(other) & py_int_to_host(self))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__rand__' requires a 'bool' object but received a '" + type(self).__name__ + "'")

    def __or__(self, other):
        if type(self) is bool:
            if type(other) is bool:
                return True if self is True else other
            elif isinstance(other, int):
                return py_int_from_host(py_int_to_host(self) | py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__or__' requires a 'bool' object but received a '" + type(self).__name__ + "'")

    def __ror__(self, other):
        if type(self) is bool:
            if type(other) is bool:
                return True if self is True else other
            elif isinstance(other, int):
                return py_int_from_host(py_int_to_host(other) | py_int_to_host(self))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__ror__' requires a 'bool' object but received a '" + type(self).__name__ + "'")

    def __xor__(self, other):
        if type(self) is bool:
            if type(other) is bool:
                return self is not other
            elif isinstance(other, int):
                return py_int_from_host(py_int_to_host(self) ^ py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__xor__' requires a 'bool' object but received a '" + type(self).__name__ + "'")

    def __rxor__(self, other):
        if type(self) is bool:
            if type(other) is bool:
                return self is not other
            elif isinstance(other, int):
                return py_int_from_host(py_int_to_host(other) ^ py_int_to_host(self))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__rxor__' requires a 'bool' object but received a '" + type(self).__name__ + "'")


@builtin_class
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


    def __add__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return py_float_from_host(py_float_to_host(self) + py_float_to_host(other))
            elif isinstance(other, int):
                return py_float_from_host(py_float_to_host(self) + py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__add__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __radd__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return py_float_from_host(py_float_to_host(other) + py_float_to_host(self))
            elif isinstance(other, int):
                return py_float_from_host(py_int_to_host(other) + py_float_to_host(self))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__radd__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __iadd__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return py_float_from_host(py_float_to_host(self) + py_float_to_host(other))
            elif isinstance(self, int):
                return py_float_from_host(py_float_to_host(self) + py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__iadd__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __mul__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return py_float_from_host(py_float_to_host(self) * py_float_to_host(other))
            elif isinstance(other, int):
                return py_float_from_host(py_float_to_host(self) * py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__mul__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __rmul__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return py_float_from_host(py_float_to_host(other) * py_float_to_host(self))
            elif isinstance(other, int):
                return py_float_from_host(py_int_to_host(other) * py_float_to_host(self))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__rmul__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __imul__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return py_float_from_host(py_float_to_host(self) * py_float_to_host(other))
            elif isinstance(self, int):
                return py_float_from_host(py_float_to_host(self) * py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__imul__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __pow__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return py_float_from_host(py_float_to_host(self) ** py_float_to_host(other))
            elif isinstance(other, int):
                return py_float_from_host(py_float_to_host(self) ** py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__pow__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __rpow__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return py_float_from_host(py_float_to_host(other) ** py_float_to_host(self))
            elif isinstance(other, int):
                return py_float_from_host(py_int_to_host(other) ** py_float_to_host(self))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__rpow__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __ipow__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return py_float_from_host(py_float_to_host(self) ** py_float_to_host(other))
            elif isinstance(self, int):
                return py_float_from_host(py_float_to_host(self) ** py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__ipow__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __sub__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return py_float_from_host(py_float_to_host(self) - py_float_to_host(other))
            elif isinstance(other, int):
                return py_float_from_host(py_float_to_host(self) - py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__sub__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __rsub__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return py_float_from_host(py_float_to_host(other) - py_float_to_host(self))
            elif isinstance(other, int):
                return py_float_from_host(py_int_to_host(other) - py_float_to_host(self))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__rsub__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __isub__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return py_float_from_host(py_float_to_host(self) - py_float_to_host(other))
            elif isinstance(self, int):
                return py_float_from_host(py_float_to_host(self) - py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__isub__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __pos__(self):
        if isinstance(self, float):
            return self
        else:
            raise TypeError("descriptor '__pos__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __neg__(self):
        if isinstance(self, float):
            return py_float_from_host(-py_float_to_host(self))
        else:
            raise TypeError("descriptor '__neg__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __floordiv__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                if other != 0.0:
                    return py_float_from_host(py_float_to_host(self) // py_float_to_host(other))
                else:
                    raise ZeroDivisionError("float division by zero")
            elif isinstance(other, int):
                if other != 0:
                    return py_float_from_host(py_float_to_host(self) // py_int_to_host(other))
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
                    return py_float_from_host(py_float_to_host(other) // py_float_to_host(self))
                else:
                    raise ZeroDivisionError("float division by zero")
            elif isinstance(other, int):
                if self != 0.0:
                    return py_float_from_host(py_int_to_host(other) // py_float_to_host(self))
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
                    return py_float_from_host(py_float_to_host(self) // py_float_to_host(other))
                else:
                    raise ZeroDivisionError("float division by zero")
            elif isinstance(other, int):
                if other != 0:
                    return py_float_from_host(py_float_to_host(self) // py_int_to_host(other))
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
                    return py_float_from_host(py_float_to_host(self) / py_float_to_host(other))
                else:
                    raise ZeroDivisionError("float division by zero")
            elif isinstance(other, int):
                if other != 0:
                    return py_float_from_host(py_float_to_host(self) / py_int_to_host(other))
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
                    return py_float_from_host(py_float_to_host(other) / py_float_to_host(self))
                else:
                    raise ZeroDivisionError("float division by zero")
            elif isinstance(other, int):
                if self != 0.0:
                    return py_float_from_host(py_int_to_host(other) / py_float_to_host(self))
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
                    return py_float_from_host(py_float_to_host(self) / py_float_to_host(other))
                else:
                    raise ZeroDivisionError("float division by zero")
            elif isinstance(other, int):
                if other != 0:
                    return py_float_from_host(py_float_to_host(self) / py_int_to_host(other))
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
                    return py_float_from_host(py_float_to_host(self) % py_float_to_host(other))
                else:
                    raise ZeroDivisionError("float modulo by zero")
            elif isinstance(other, int):
                if other != 0:
                    return py_float_from_host(py_float_to_host(self) % py_int_to_host(other))
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
                    return py_float_from_host(py_float_to_host(other) % py_float_to_host(self))
                else:
                    raise ZeroDivisionError("float modulo by zero")
            elif isinstance(other, int):
                if self != 0.0:
                    return py_float_from_host(py_int_to_host(other) % py_float_to_host(self))
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
                    return py_float_from_host(py_float_to_host(self) % py_float_to_host(other))
                else:
                    raise ZeroDivisionError("float modulo by zero")
            elif isinstance(other, int):
                if other != 0:
                    return py_float_from_host(py_float_to_host(self) % py_int_to_host(other))
                else:
                    raise ZeroDivisionError("float modulo by zero")
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__imod__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __eq__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return py_bool_from_host_bool(py_float_to_host(self) == py_float_to_host(other))
            elif isinstance(other, int):
                return py_bool_from_host_bool(py_float_to_host(self) == py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__eq__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __ne__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return py_bool_from_host_bool(py_float_to_host(self) != py_float_to_host(other))
            elif isinstance(other, int):
                return py_bool_from_host_bool(py_float_to_host(self) != py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__ne__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __ge__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return py_bool_from_host_bool(py_float_to_host(self) >= py_float_to_host(other))
            elif isinstance(other, int):
                return py_bool_from_host_bool(py_float_to_host(self) >= py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__ge__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __gt__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return py_bool_from_host_bool(py_float_to_host(self) > py_float_to_host(other))
            elif isinstance(other, int):
                return py_bool_from_host_bool(py_float_to_host(self) > py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__gt__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __le__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return py_bool_from_host_bool(py_float_to_host(self) <= py_float_to_host(other))
            elif isinstance(other, int):
                return py_bool_from_host_bool(py_float_to_host(self) <= py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__le__' requires a 'float' object but received a '" + type(self).__name__ + "'")

    def __lt__(self, other):
        if isinstance(self, float):
            if isinstance(other, float):
                return py_bool_from_host_bool(py_float_to_host(self) < py_float_to_host(other))
            elif isinstance(other, int):
                return py_bool_from_host_bool(py_float_to_host(self) < py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__lt__' requires a 'float' object but received a '" + type(self).__name__ + "'")
