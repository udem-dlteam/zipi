from __compiler_intrinsics__ import absent, builtin, private, alloc, py_int_from_host, py_int_to_host, py_float_from_host, py_float_to_host, py_bool_from_host_bool, py_bool_to_host_bool, py_str_to_host, py_str_from_host, py_str_len_to_host, semantics_maybe_integer, semantics_maybe_index, semantics_maybe_trunc


@builtin
@private
def convert_to_int(obj):
    int_conversion = semantics_maybe_integer(obj)
    if int_conversion is absent:
        index_conversion = semantics_maybe_index(obj)
        if index_conversion is absent:
            trunc_conversion = semantics_maybe_trunc(obj)
            if trunc_conversion is absent:
                raise TypeError("int() argument must be a string, a bytes-like object or a number, not '" + type(obj).__name__ + "'")
            else:
                return trunc_conversion
        else:
            return index_conversion
    else:
        return int_conversion

@builtin
class int:
    def __new__(cls, val=absent):
        if cls is int:
            if val is absent:
                return 0
            else:
                return convert_to_int(val)
        elif isinstance(cls, type) and issubclass(cls, int):
            if val is absent:
                return alloc(int, cls=cls, value=py_int_to_host(0))
            else:
                return alloc(int, cls=cls, value=py_int_to_host(convert_to_int(val)))
        else:
            raise TypeError("int.__new__ expected a subtype of 'int' as first argument")

    def __bool__(self):
        if isinstance(self, int):
            return self != 0
        else:
            raise TypeError("descriptor '__bool__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __index__(self):
        if isinstance(self, int):
            return py_int_from_host(py_int_to_host(self))
        else:
            raise TypeError("descriptor '__index__' requires a 'int' object but received a '" + type(self).__name__ + "'")

    def __abs__(self):
        if isinstance(self, int):
            if self < 0:
                return py_int_from_host(-py_int_to_host(self))
            else:
                return py_int_from_host(py_int_to_host(self))
        else:
            raise TypeError("descriptor '__abs__' requires a 'int' object but received a '" + type(self).__name__ + "'")

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
            return py_int_from_host(py_int_to_host(self))
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


@builtin
class bool(int):
    def __new__(cls, val=absent):
        if cls is bool:
            if val is absent:
                return False
            else:
                return True if val else False
        else:
            raise TypeError("bool.__new__ expected a subtype of 'bool' as first argument")

    def __repr__(self):
        if self is True:
            return "True"
        elif self is False:
            return "False"
        else:
            raise TypeError("descriptor '__repr__' requires a 'bool' object but received a '" + type(self).__name__ + "'")

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


@builtin
class float:
    def __new__(cls, val=absent):
        if cls is float:
            if val is absent:
                return 0.0
            if isinstance(val, float):
                return py_float_from_host(py_float_to_host(val))
            else:
                raise NotImplementedError
        elif isinstance(cls, type) and issubclass(cls, float):
            raise NotImplementedError
        else:
            raise TypeError("float.__new__ expected a subtype of 'float' as first argument")

    def __bool__(self):
        if isinstance(self, float):
            return self != 0.0
        else:
            raise TypeError("descriptor '__bool__' requires a 'float' object but received a '" + type(self).__name__ + "'")

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


@builtin
class str:
    def __len__(self):
        if isinstance(self, str):
            return py_int_from_host(py_str_len_to_host(self))
        else:
            raise TypeError("descriptor '__len__' requires a 'str' object but received a '" + type(self).__name__ + "'")

    def __add__(self, other):
        if isinstance(self, str):
            if isinstance(other, str):
                return py_str_from_host(py_str_to_host(self) + py_str_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__add__' requires a 'str' object but received a '" + type(self).__name__ + "'")

    def __mul__(self, other):
        if isinstance(self, str):
            if isinstance(other, int):
                return py_str_from_host(py_str_to_host(self) * py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__mul__' requires a 'str' object but received a '" + type(self).__name__ + "'")

    def __rmul__(self, other):
        if isinstance(self, str):
            if isinstance(other, int):
                return py_str_from_host(py_str_to_host(self) * py_int_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__rmul__' requires a 'str' object but received a '" + type(self).__name__ + "'")

    def __eq__(self, other):
        if isinstance(self, str):
            if isinstance(other, str):
                return py_bool_from_host_bool(py_str_to_host(self) == py_str_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__eq__' requires a 'str' object but received a '" + type(self).__name__ + "'")

    def __ne__(self, other):
        if isinstance(self, str):
            if isinstance(other, str):
                return py_bool_from_host_bool(py_str_to_host(self) != py_str_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__ne__' requires a 'str' object but received a '" + type(self).__name__ + "'")

    def __ge__(self, other):
        if isinstance(self, str):
            if isinstance(other, str):
                return py_bool_from_host_bool(py_str_to_host(self) >= py_str_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__ge__' requires a 'str' object but received a '" + type(self).__name__ + "'")

    def __gt__(self, other):
        if isinstance(self, str):
            if isinstance(other, str):
                return py_bool_from_host_bool(py_str_to_host(self) > py_str_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__gt__' requires a 'str' object but received a '" + type(self).__name__ + "'")

    def __le__(self, other):
        if isinstance(self, str):
            if isinstance(other, str):
                return py_bool_from_host_bool(py_str_to_host(self) <= py_str_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__le__' requires a 'str' object but received a '" + type(self).__name__ + "'")

    def __lt__(self, other):
        if isinstance(self, str):
            if isinstance(other, str):
                return py_bool_from_host_bool(py_str_to_host(self) < py_str_to_host(other))
            else:
                return NotImplemented
        else:
            raise TypeError("descriptor '__lt__' requires a 'str' object but received a '" + type(self).__name__ + "'")



@builtin
@private
class range_iterator:
    def __new__(*args):
        raise ValueError("cannot create 'range_iterator' instances")

    def __iter__(self, /):
        return self

    def __next__(self, /):
        start = self.start
        stop = self.stop
        step = self.step

        if step < 0:
            if start > stop:
                self.start = start + step
                return start
        else:
            if start < stop:
                self.start = start + step
                return start

        raise StopIteration

@builtin
class range:
    def __new__(cls, arg1, arg2=absent, arg3=absent, /):
        if cls is range:
            if arg3 is not absent:
                return alloc(range, start=arg1, stop=arg2, step=arg3)
            elif arg2 is not absent:
                return alloc(range, start=arg1, stop=arg2, step=1)
            else:
                return alloc(range, start=0, stop=arg1, step=1)
        elif isinstance(cls, type) and issubclass(cls, range):
            raise NotImplementedError
        else:
            raise TypeError("range.__new__ expected a subtype of 'range' as first argument")

    def __len__(self, /):
        return (self.stop - self.start) // self.step

    def __contains__(self, item, /):
        start = self.start
        stop = self.stop
        step = self.step

        if step < 0:
            if stop >= item or item > start:
                return False
        else:
            if start > item or item >= stop:
                return False

        return (item - start) % step == 0

    def __iter__(self, /):
        return alloc(range_iterator, start=self.start, stop=self.stop, step=self.step)

    def __repr__(self):
        start = self.start
        stop = self.stop
        step = self.step

        if step == 1:
            return "range(" + str(start) + ", " + str(stop) + ")"
        else:
            return "range(" + str(start) + ", " + str(stop) + ", " + str(step) + ")"

@private
@builtin
def __merge(l1, l2):
    """
    Merge all items from two sorted list into one sorted list.
    Time complexity: O(n) where n is the total number of elements
    """
    i = j = 0
    output = []

    while i < len(l1) and j < len(l2):
        if l1[i] <= l2[j]:
            output.append(l1[i])
            i += 1
        else:
            output.append(l2[j])
            j += 1

    output.extend(l1[i:] + l2[j:])

    return output

@private
@builtin
def __merge_many(lsts):
    """
    Merge all items from k lists into one sorted list.
    Time complexity: O(n log(k)) where n is the total number of elements and k the number of lists
    """
    if not lsts:
        return []
    elif len(lsts) == 1:
        return lsts[0][:]
    elif len(lsts) == 2:
        return __merge(lsts[0], lsts[1])
    else:
        left = lsts[len(lsts) // 2:]
        right = lsts[:len(lsts) // 2]

        return __merge(__merge_many(left), __merge_many(right))


# TODO: key and reversed must be kwonlyargs
@builtin
def sorted(lst, key=None, reversed=False):
    """
    Timsort is an improved version of Merge Sort which splits the list into monotonic sub-lists before merging them
    into a sorted list.
    Worst case time complexity: O(n log(n))
    Best cast time complexity:  O(n) when the list is almost sorted
        where n is the number of elements in the list
    """
    sublsts = []

    i = 0
    while i < len(lst):
        sublsts.append([lst[i]])
        i += 1

        if i < len(lst) and lst[i] >= lst[i - 1]:
            while i < len(lst) and lst[i] >= lst[i - 1]:
                sublsts[-1].append(lst[i])
                i += 1
        elif i < len(lst):
            while i < len(lst) and lst[i] < lst[i - 1]:
                sublsts[-1].append(lst[i])
                i += 1

            sublsts[-1] = sublsts[-1][::-1]

    return __merge_many(sublsts)

# ==============================================================================
# Exceptions
# ==============================================================================

@builtin
class BaseException:
    def __init__(self, *args):
        self.args = args

    def __str__(self):
        args = self.args
        args_len = len(self.args)

        if args_len == 0:
            return ""
        elif args_len == 1:
            return str(args[0])
        else:
            return str(args)

@builtin
class Exception(BaseException):
    pass

@builtin
class GeneratorExit(BaseException):
    pass


@builtin
class KeyboardInterrupt(BaseException):
    pass


@builtin
class SystemExit(BaseException):
    pass


@builtin
class ArithmeticError(Exception):
    pass


@builtin
class AssertionError(Exception):
    pass


@builtin
class AttributeError(Exception):
    pass


@builtin
class BufferError(Exception):
    pass


@builtin
class EOFError(Exception):
    pass


@builtin
class ImportError(Exception):
    pass


@builtin
class LookupError(Exception):
    pass


@builtin
class MemoryError(Exception):
    pass


@builtin
class NameError(Exception):
    pass


@builtin
class EnvironmentError(Exception):
    pass


@builtin
class IOError(Exception):
    pass


@builtin
class OSError(Exception):
    pass


@builtin
class WindowsError(Exception):
    pass


@builtin
class ReferenceError(Exception):
    pass


@builtin
class RuntimeError(Exception):
    pass


@builtin
class StopAsyncIteration(Exception):
    pass


@builtin
class StopIteration(Exception):
    pass


@builtin
class SyntaxError(Exception):
    pass


@builtin
class SystemError(Exception):
    pass


@builtin
class TypeError(Exception):
    pass


@builtin
class ValueError(Exception):
    pass


@builtin
class Warning(Exception):
    pass


@builtin
class FloatingPointError(ArithmeticError):
    pass


@builtin
class OverflowError(ArithmeticError):
    pass


@builtin
class ZeroDivisionError(ArithmeticError):
    pass


@builtin
class ModuleNotFoundError(ImportError):
    pass


@builtin
class IndexError(LookupError):
    pass


@builtin
class KeyError(LookupError):
    pass


@builtin
class UnboundLocalError(NameError):
    pass


@builtin
class BlockingIOError(OSError):
    pass


@builtin
class ChildProcessError(OSError):
    pass


@builtin
class ConnectionError(OSError):
    pass


@builtin
class FileExistsError(OSError):
    pass


@builtin
class FileNotFoundError(OSError):
    pass


@builtin
class InterruptedError(OSError):
    pass


@builtin
class IsADirectoryError(OSError):
    pass


@builtin
class NotADirectoryError(OSError):
    pass


@builtin
class PermissionError(OSError):
    pass


@builtin
class ProcessLookupError(OSError):
    pass


@builtin
class TimeoutError(OSError):
    pass


@builtin
class NotImplementedError(RuntimeError):
    pass


@builtin
class RecursionError(RuntimeError):
    pass


@builtin
class IndentationError(SyntaxError):
    pass


@builtin
class UnicodeError(ValueError):
    pass


@builtin
class BytesWarning(Warning):
    pass


@builtin
class DeprecationWarning(Warning):
    pass


@builtin
class FutureWarning(Warning):
    pass


@builtin
class ImportWarning(Warning):
    pass


@builtin
class PendingDeprecationWarning(Warning):
    pass


@builtin
class ResourceWarning(Warning):
    pass


@builtin
class RuntimeWarning(Warning):
    pass


@builtin
class SyntaxWarning(Warning):
    pass


@builtin
class UnicodeWarning(Warning):
    pass


@builtin
class UserWarning(Warning):
    pass


@builtin
class BrokenPipeError(ConnectionError):
    pass


@builtin
class ConnectionAbortedError(ConnectionError):
    pass


@builtin
class ConnectionRefusedError(ConnectionError):
    pass


@builtin
class ConnectionResetError(ConnectionError):
    pass


@builtin
class TabError(IndentationError):
    pass


@builtin
class UnicodeDecodeError(UnicodeError):
    pass


@builtin
class UnicodeEncodeError(UnicodeError):
    pass


@builtin
class UnicodeTranslateError(UnicodeError):
    pass
