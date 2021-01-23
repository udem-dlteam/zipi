from __compiler_intrinsics__ import define_behavior, py_int_from_host, py_int_to_host, py_bool_to_host_int, py_float_from_host, py_float_to_host, py_sint_to_host, py_bint_to_host, py_bool_from_host_bool 

@define_behavior
def py_add_floatX_floatY(self: float, other: float):
    return py_float_from_host(py_float_to_host(self) + py_float_to_host(other))

@define_behavior
def py_add_floatX_boolY(self: float, other: bool):
    return py_float_from_host(py_float_to_host(self) + py_bool_to_host_int(
        other))

@define_behavior
def py_add_floatX_sintY(self: float, other: sint):
    return py_float_from_host(py_float_to_host(self) + py_sint_to_host(other))

@define_behavior
def py_add_floatX_bintY(self: float, other: bint):
    return py_float_from_host(py_float_to_host(self) + py_bint_to_host(other))

@define_behavior
def py_add_boolX_floatY(other: bool, self: float):
    return py_float_from_host(py_bool_to_host_int(other) + py_float_to_host
        (self))

@define_behavior
def py_add_boolX_boolY(self: bool, other: bool):
    return py_int_from_host(py_bool_to_host_int(self) + py_bool_to_host_int
        (other))

@define_behavior
def py_add_boolX_sintY(self: bool, other: sint):
    return py_int_from_host(py_bool_to_host_int(self) + py_sint_to_host(other))

@define_behavior
def py_add_boolX_bintY(self: bool, other: bint):
    return py_int_from_host(py_bool_to_host_int(self) + py_bint_to_host(other))

@define_behavior
def py_add_sintX_floatY(other: sint, self: float):
    return py_float_from_host(py_sint_to_host(other) + py_float_to_host(self))

@define_behavior
def py_add_sintX_boolY(self: sint, other: bool):
    return py_int_from_host(py_sint_to_host(self) + py_bool_to_host_int(other))

@define_behavior
def py_add_sintX_sintY(self: sint, other: sint):
    return py_int_from_host(py_sint_to_host(self) + py_sint_to_host(other))

@define_behavior
def py_add_sintX_bintY(self: sint, other: bint):
    return py_int_from_host(py_sint_to_host(self) + py_bint_to_host(other))

@define_behavior
def py_add_bintX_floatY(other: bint, self: float):
    return py_float_from_host(py_bint_to_host(other) + py_float_to_host(self))

@define_behavior
def py_add_bintX_boolY(self: bint, other: bool):
    return py_int_from_host(py_bint_to_host(self) + py_bool_to_host_int(other))

@define_behavior
def py_add_bintX_sintY(self: bint, other: sint):
    return py_int_from_host(py_bint_to_host(self) + py_sint_to_host(other))

@define_behavior
def py_add_bintX_bintY(self: bint, other: bint):
    return py_int_from_host(py_bint_to_host(self) + py_bint_to_host(other))

@define_behavior
def py_bitand_floatX_floatY(self: float, other: float):
    raise TypeError("unsupported operand type(s) for &: 'float' and 'float'")

@define_behavior
def py_bitand_floatX_boolY(self: float, other: bool):
    raise TypeError("unsupported operand type(s) for &: 'float' and 'bool'")

@define_behavior
def py_bitand_floatX_sintY(self: float, other: sint):
    raise TypeError("unsupported operand type(s) for &: 'float' and 'int'")

@define_behavior
def py_bitand_floatX_bintY(self: float, other: bint):
    raise TypeError("unsupported operand type(s) for &: 'float' and 'int'")

@define_behavior
def py_bitand_boolX_floatY(self: bool, other: float):
    raise TypeError("unsupported operand type(s) for &: 'bool' and 'float'")

@define_behavior
def py_bitand_boolX_boolY(self: bool, other: bool):
    return other if self is True else False

@define_behavior
def py_bitand_boolX_sintY(self: bool, other: sint):
    return py_int_from_host(py_bool_to_host_int(self) & py_sint_to_host(other))

@define_behavior
def py_bitand_boolX_bintY(self: bool, other: bint):
    return py_int_from_host(py_bool_to_host_int(self) & py_bint_to_host(other))

@define_behavior
def py_bitand_sintX_floatY(self: sint, other: float):
    raise TypeError("unsupported operand type(s) for &: 'int' and 'float'")

@define_behavior
def py_bitand_sintX_boolY(self: sint, other: bool):
    return py_int_from_host(py_sint_to_host(self) & py_bool_to_host_int(other))

@define_behavior
def py_bitand_sintX_sintY(self: sint, other: sint):
    return py_int_from_host(py_sint_to_host(self) & py_sint_to_host(other))

@define_behavior
def py_bitand_sintX_bintY(self: sint, other: bint):
    return py_int_from_host(py_sint_to_host(self) & py_bint_to_host(other))

@define_behavior
def py_bitand_bintX_floatY(self: bint, other: float):
    raise TypeError("unsupported operand type(s) for &: 'int' and 'float'")

@define_behavior
def py_bitand_bintX_boolY(self: bint, other: bool):
    return py_int_from_host(py_bint_to_host(self) & py_bool_to_host_int(other))

@define_behavior
def py_bitand_bintX_sintY(self: bint, other: sint):
    return py_int_from_host(py_bint_to_host(self) & py_sint_to_host(other))

@define_behavior
def py_bitand_bintX_bintY(self: bint, other: bint):
    return py_int_from_host(py_bint_to_host(self) & py_bint_to_host(other))

@define_behavior
def py_bitor_floatX_floatY(self: float, other: float):
    raise TypeError("unsupported operand type(s) for |: 'float' and 'float'")

@define_behavior
def py_bitor_floatX_boolY(self: float, other: bool):
    raise TypeError("unsupported operand type(s) for |: 'float' and 'bool'")

@define_behavior
def py_bitor_floatX_sintY(self: float, other: sint):
    raise TypeError("unsupported operand type(s) for |: 'float' and 'int'")

@define_behavior
def py_bitor_floatX_bintY(self: float, other: bint):
    raise TypeError("unsupported operand type(s) for |: 'float' and 'int'")

@define_behavior
def py_bitor_boolX_floatY(self: bool, other: float):
    raise TypeError("unsupported operand type(s) for |: 'bool' and 'float'")

@define_behavior
def py_bitor_boolX_boolY(self: bool, other: bool):
    return True if self is True else other

@define_behavior
def py_bitor_boolX_sintY(self: bool, other: sint):
    return py_int_from_host(py_bool_to_host_int(self) | py_sint_to_host(other))

@define_behavior
def py_bitor_boolX_bintY(self: bool, other: bint):
    return py_int_from_host(py_bool_to_host_int(self) | py_bint_to_host(other))

@define_behavior
def py_bitor_sintX_floatY(self: sint, other: float):
    raise TypeError("unsupported operand type(s) for |: 'int' and 'float'")

@define_behavior
def py_bitor_sintX_boolY(self: sint, other: bool):
    return py_int_from_host(py_sint_to_host(self) | py_bool_to_host_int(other))

@define_behavior
def py_bitor_sintX_sintY(self: sint, other: sint):
    return py_int_from_host(py_sint_to_host(self) | py_sint_to_host(other))

@define_behavior
def py_bitor_sintX_bintY(self: sint, other: bint):
    return py_int_from_host(py_sint_to_host(self) | py_bint_to_host(other))

@define_behavior
def py_bitor_bintX_floatY(self: bint, other: float):
    raise TypeError("unsupported operand type(s) for |: 'int' and 'float'")

@define_behavior
def py_bitor_bintX_boolY(self: bint, other: bool):
    return py_int_from_host(py_bint_to_host(self) | py_bool_to_host_int(other))

@define_behavior
def py_bitor_bintX_sintY(self: bint, other: sint):
    return py_int_from_host(py_bint_to_host(self) | py_sint_to_host(other))

@define_behavior
def py_bitor_bintX_bintY(self: bint, other: bint):
    return py_int_from_host(py_bint_to_host(self) | py_bint_to_host(other))

@define_behavior
def py_floordiv_floatX_floatY(self: float, other: float):
    if other != 0.0:
        return py_float_from_host(py_float_to_host(self) //
            py_float_to_host(other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_floordiv_floatX_boolY(self: float, other: bool):
    if other != 0:
        return py_float_from_host(py_float_to_host(self) //
            py_bool_to_host_int(other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_floordiv_floatX_sintY(self: float, other: sint):
    if other != 0:
        return py_float_from_host(py_float_to_host(self) // py_sint_to_host
            (other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_floordiv_floatX_bintY(self: float, other: bint):
    if other != 0:
        return py_float_from_host(py_float_to_host(self) // py_bint_to_host
            (other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_floordiv_boolX_floatY(other: bool, self: float):
    if self != 0.0:
        return py_float_from_host(py_bool_to_host_int(other) //
            py_float_to_host(self))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_floordiv_boolX_boolY(self: bool, other: bool):
    if other != 0:
        return py_int_from_host(py_bool_to_host_int(self) //
            py_bool_to_host_int(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_floordiv_boolX_sintY(self: bool, other: sint):
    if other != 0:
        return py_int_from_host(py_bool_to_host_int(self) //
            py_sint_to_host(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_floordiv_boolX_bintY(self: bool, other: bint):
    if other != 0:
        return py_int_from_host(py_bool_to_host_int(self) //
            py_bint_to_host(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_floordiv_sintX_floatY(other: sint, self: float):
    if self != 0.0:
        return py_float_from_host(py_sint_to_host(other) //
            py_float_to_host(self))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_floordiv_sintX_boolY(self: sint, other: bool):
    if other != 0:
        return py_int_from_host(py_sint_to_host(self) //
            py_bool_to_host_int(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_floordiv_sintX_sintY(self: sint, other: sint):
    if other != 0:
        return py_int_from_host(py_sint_to_host(self) // py_sint_to_host(other)
            )
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_floordiv_sintX_bintY(self: sint, other: bint):
    if other != 0:
        return py_int_from_host(py_sint_to_host(self) // py_bint_to_host(other)
            )
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_floordiv_bintX_floatY(other: bint, self: float):
    if self != 0.0:
        return py_float_from_host(py_bint_to_host(other) //
            py_float_to_host(self))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_floordiv_bintX_boolY(self: bint, other: bool):
    if other != 0:
        return py_int_from_host(py_bint_to_host(self) //
            py_bool_to_host_int(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_floordiv_bintX_sintY(self: bint, other: sint):
    if other != 0:
        return py_int_from_host(py_bint_to_host(self) // py_sint_to_host(other)
            )
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_floordiv_bintX_bintY(self: bint, other: bint):
    if other != 0:
        return py_int_from_host(py_bint_to_host(self) // py_bint_to_host(other)
            )
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_lshift_floatX_floatY(self: float, other: float):
    raise TypeError("unsupported operand type(s) for <<: 'float' and 'float'")

@define_behavior
def py_lshift_floatX_boolY(self: float, other: bool):
    raise TypeError("unsupported operand type(s) for <<: 'float' and 'bool'")

@define_behavior
def py_lshift_floatX_sintY(self: float, other: sint):
    raise TypeError("unsupported operand type(s) for <<: 'float' and 'int'")

@define_behavior
def py_lshift_floatX_bintY(self: float, other: bint):
    raise TypeError("unsupported operand type(s) for <<: 'float' and 'int'")

@define_behavior
def py_lshift_boolX_floatY(self: bool, other: float):
    raise TypeError("unsupported operand type(s) for <<: 'bool' and 'float'")

@define_behavior
def py_lshift_boolX_boolY(self: bool, other: bool):
    if other >= 0:
        return py_int_from_host(py_bool_to_host_int(self) <<
            py_bool_to_host_int(other))
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_lshift_boolX_sintY(self: bool, other: sint):
    if other >= 0:
        return py_int_from_host(py_bool_to_host_int(self) <<
            py_sint_to_host(other))
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_lshift_boolX_bintY(self: bool, other: bint):
    if other >= 0:
        return py_int_from_host(py_bool_to_host_int(self) <<
            py_bint_to_host(other))
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_lshift_sintX_floatY(self: sint, other: float):
    raise TypeError("unsupported operand type(s) for <<: 'int' and 'float'")

@define_behavior
def py_lshift_sintX_boolY(self: sint, other: bool):
    if other >= 0:
        return py_int_from_host(py_sint_to_host(self) <<
            py_bool_to_host_int(other))
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_lshift_sintX_sintY(self: sint, other: sint):
    if other >= 0:
        return py_int_from_host(py_sint_to_host(self) << py_sint_to_host(other)
            )
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_lshift_sintX_bintY(self: sint, other: bint):
    if other >= 0:
        return py_int_from_host(py_sint_to_host(self) << py_bint_to_host(other)
            )
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_lshift_bintX_floatY(self: bint, other: float):
    raise TypeError("unsupported operand type(s) for <<: 'int' and 'float'")

@define_behavior
def py_lshift_bintX_boolY(self: bint, other: bool):
    if other >= 0:
        return py_int_from_host(py_bint_to_host(self) <<
            py_bool_to_host_int(other))
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_lshift_bintX_sintY(self: bint, other: sint):
    if other >= 0:
        return py_int_from_host(py_bint_to_host(self) << py_sint_to_host(other)
            )
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_lshift_bintX_bintY(self: bint, other: bint):
    if other >= 0:
        return py_int_from_host(py_bint_to_host(self) << py_bint_to_host(other)
            )
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_matmul_floatX_floatY(self: float, other: float):
    raise TypeError("unsupported operand type(s) for @: 'float' and 'float'")

@define_behavior
def py_matmul_floatX_boolY(self: float, other: bool):
    raise TypeError("unsupported operand type(s) for @: 'float' and 'bool'")

@define_behavior
def py_matmul_floatX_sintY(self: float, other: sint):
    raise TypeError("unsupported operand type(s) for @: 'float' and 'int'")

@define_behavior
def py_matmul_floatX_bintY(self: float, other: bint):
    raise TypeError("unsupported operand type(s) for @: 'float' and 'int'")

@define_behavior
def py_matmul_boolX_floatY(self: bool, other: float):
    raise TypeError("unsupported operand type(s) for @: 'bool' and 'float'")

@define_behavior
def py_matmul_boolX_boolY(self: bool, other: bool):
    raise TypeError("unsupported operand type(s) for @: 'bool' and 'bool'")

@define_behavior
def py_matmul_boolX_sintY(self: bool, other: sint):
    raise TypeError("unsupported operand type(s) for @: 'bool' and 'int'")

@define_behavior
def py_matmul_boolX_bintY(self: bool, other: bint):
    raise TypeError("unsupported operand type(s) for @: 'bool' and 'int'")

@define_behavior
def py_matmul_sintX_floatY(self: sint, other: float):
    raise TypeError("unsupported operand type(s) for @: 'int' and 'float'")

@define_behavior
def py_matmul_sintX_boolY(self: sint, other: bool):
    raise TypeError("unsupported operand type(s) for @: 'int' and 'bool'")

@define_behavior
def py_matmul_sintX_sintY(self: sint, other: sint):
    raise TypeError("unsupported operand type(s) for @: 'int' and 'int'")

@define_behavior
def py_matmul_sintX_bintY(self: sint, other: bint):
    raise TypeError("unsupported operand type(s) for @: 'int' and 'int'")

@define_behavior
def py_matmul_bintX_floatY(self: bint, other: float):
    raise TypeError("unsupported operand type(s) for @: 'int' and 'float'")

@define_behavior
def py_matmul_bintX_boolY(self: bint, other: bool):
    raise TypeError("unsupported operand type(s) for @: 'int' and 'bool'")

@define_behavior
def py_matmul_bintX_sintY(self: bint, other: sint):
    raise TypeError("unsupported operand type(s) for @: 'int' and 'int'")

@define_behavior
def py_matmul_bintX_bintY(self: bint, other: bint):
    raise TypeError("unsupported operand type(s) for @: 'int' and 'int'")

@define_behavior
def py_mod_floatX_floatY(self: float, other: float):
    if other != 0.0:
        return py_float_from_host(py_float_to_host(self) % py_float_to_host
            (other))
    else:
        raise ZeroDivisionError('float modulo by zero')

@define_behavior
def py_mod_floatX_boolY(self: float, other: bool):
    if other != 0:
        return py_float_from_host(py_float_to_host(self) %
            py_bool_to_host_int(other))
    else:
        raise ZeroDivisionError('float modulo by zero')

@define_behavior
def py_mod_floatX_sintY(self: float, other: sint):
    if other != 0:
        return py_float_from_host(py_float_to_host(self) % py_sint_to_host(
            other))
    else:
        raise ZeroDivisionError('float modulo by zero')

@define_behavior
def py_mod_floatX_bintY(self: float, other: bint):
    if other != 0:
        return py_float_from_host(py_float_to_host(self) % py_bint_to_host(
            other))
    else:
        raise ZeroDivisionError('float modulo by zero')

@define_behavior
def py_mod_boolX_floatY(other: bool, self: float):
    if self != 0.0:
        return py_float_from_host(py_bool_to_host_int(other) %
            py_float_to_host(self))
    else:
        raise ZeroDivisionError('float modulo by zero')

@define_behavior
def py_mod_boolX_boolY(self: bool, other: bool):
    if other != 0:
        return py_int_from_host(py_bool_to_host_int(self) %
            py_bool_to_host_int(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_mod_boolX_sintY(self: bool, other: sint):
    if other != 0:
        return py_int_from_host(py_bool_to_host_int(self) % py_sint_to_host
            (other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_mod_boolX_bintY(self: bool, other: bint):
    if other != 0:
        return py_int_from_host(py_bool_to_host_int(self) % py_bint_to_host
            (other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_mod_sintX_floatY(other: sint, self: float):
    if self != 0.0:
        return py_float_from_host(py_sint_to_host(other) % py_float_to_host
            (self))
    else:
        raise ZeroDivisionError('float modulo by zero')

@define_behavior
def py_mod_sintX_boolY(self: sint, other: bool):
    if other != 0:
        return py_int_from_host(py_sint_to_host(self) % py_bool_to_host_int
            (other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_mod_sintX_sintY(self: sint, other: sint):
    if other != 0:
        return py_int_from_host(py_sint_to_host(self) % py_sint_to_host(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_mod_sintX_bintY(self: sint, other: bint):
    if other != 0:
        return py_int_from_host(py_sint_to_host(self) % py_bint_to_host(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_mod_bintX_floatY(other: bint, self: float):
    if self != 0.0:
        return py_float_from_host(py_bint_to_host(other) % py_float_to_host
            (self))
    else:
        raise ZeroDivisionError('float modulo by zero')

@define_behavior
def py_mod_bintX_boolY(self: bint, other: bool):
    if other != 0:
        return py_int_from_host(py_bint_to_host(self) % py_bool_to_host_int
            (other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_mod_bintX_sintY(self: bint, other: sint):
    if other != 0:
        return py_int_from_host(py_bint_to_host(self) % py_sint_to_host(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_mod_bintX_bintY(self: bint, other: bint):
    if other != 0:
        return py_int_from_host(py_bint_to_host(self) % py_bint_to_host(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_mul_floatX_floatY(self: float, other: float):
    return py_float_from_host(py_float_to_host(self) * py_float_to_host(other))

@define_behavior
def py_mul_floatX_boolY(self: float, other: bool):
    return py_float_from_host(py_float_to_host(self) * py_bool_to_host_int(
        other))

@define_behavior
def py_mul_floatX_sintY(self: float, other: sint):
    return py_float_from_host(py_float_to_host(self) * py_sint_to_host(other))

@define_behavior
def py_mul_floatX_bintY(self: float, other: bint):
    return py_float_from_host(py_float_to_host(self) * py_bint_to_host(other))

@define_behavior
def py_mul_boolX_floatY(other: bool, self: float):
    return py_float_from_host(py_bool_to_host_int(other) * py_float_to_host
        (self))

@define_behavior
def py_mul_boolX_boolY(self: bool, other: bool):
    return py_int_from_host(py_bool_to_host_int(self) * py_bool_to_host_int
        (other))

@define_behavior
def py_mul_boolX_sintY(self: bool, other: sint):
    return py_int_from_host(py_bool_to_host_int(self) * py_sint_to_host(other))

@define_behavior
def py_mul_boolX_bintY(self: bool, other: bint):
    return py_int_from_host(py_bool_to_host_int(self) * py_bint_to_host(other))

@define_behavior
def py_mul_sintX_floatY(other: sint, self: float):
    return py_float_from_host(py_sint_to_host(other) * py_float_to_host(self))

@define_behavior
def py_mul_sintX_boolY(self: sint, other: bool):
    return py_int_from_host(py_sint_to_host(self) * py_bool_to_host_int(other))

@define_behavior
def py_mul_sintX_sintY(self: sint, other: sint):
    return py_int_from_host(py_sint_to_host(self) * py_sint_to_host(other))

@define_behavior
def py_mul_sintX_bintY(self: sint, other: bint):
    return py_int_from_host(py_sint_to_host(self) * py_bint_to_host(other))

@define_behavior
def py_mul_bintX_floatY(other: bint, self: float):
    return py_float_from_host(py_bint_to_host(other) * py_float_to_host(self))

@define_behavior
def py_mul_bintX_boolY(self: bint, other: bool):
    return py_int_from_host(py_bint_to_host(self) * py_bool_to_host_int(other))

@define_behavior
def py_mul_bintX_sintY(self: bint, other: sint):
    return py_int_from_host(py_bint_to_host(self) * py_sint_to_host(other))

@define_behavior
def py_mul_bintX_bintY(self: bint, other: bint):
    return py_int_from_host(py_bint_to_host(self) * py_bint_to_host(other))

@define_behavior
def py_pow_floatX_floatY(self: float, other: float):
    return py_float_from_host(py_float_to_host(self) ** py_float_to_host(other)
        )

@define_behavior
def py_pow_floatX_boolY(self: float, other: bool):
    return py_float_from_host(py_float_to_host(self) ** py_bool_to_host_int
        (other))

@define_behavior
def py_pow_floatX_sintY(self: float, other: sint):
    return py_float_from_host(py_float_to_host(self) ** py_sint_to_host(other))

@define_behavior
def py_pow_floatX_bintY(self: float, other: bint):
    return py_float_from_host(py_float_to_host(self) ** py_bint_to_host(other))

@define_behavior
def py_pow_boolX_floatY(other: bool, self: float):
    return py_float_from_host(py_bool_to_host_int(other) **
        py_float_to_host(self))

@define_behavior
def py_pow_boolX_boolY(self: bool, other: bool):
    return py_int_from_host(py_bool_to_host_int(self) **
        py_bool_to_host_int(other))

@define_behavior
def py_pow_boolX_sintY(self: bool, other: sint):
    return py_int_from_host(py_bool_to_host_int(self) ** py_sint_to_host(other)
        )

@define_behavior
def py_pow_boolX_bintY(self: bool, other: bint):
    return py_int_from_host(py_bool_to_host_int(self) ** py_bint_to_host(other)
        )

@define_behavior
def py_pow_sintX_floatY(other: sint, self: float):
    return py_float_from_host(py_sint_to_host(other) ** py_float_to_host(self))

@define_behavior
def py_pow_sintX_boolY(self: sint, other: bool):
    return py_int_from_host(py_sint_to_host(self) ** py_bool_to_host_int(other)
        )

@define_behavior
def py_pow_sintX_sintY(self: sint, other: sint):
    return py_int_from_host(py_sint_to_host(self) ** py_sint_to_host(other))

@define_behavior
def py_pow_sintX_bintY(self: sint, other: bint):
    return py_int_from_host(py_sint_to_host(self) ** py_bint_to_host(other))

@define_behavior
def py_pow_bintX_floatY(other: bint, self: float):
    return py_float_from_host(py_bint_to_host(other) ** py_float_to_host(self))

@define_behavior
def py_pow_bintX_boolY(self: bint, other: bool):
    return py_int_from_host(py_bint_to_host(self) ** py_bool_to_host_int(other)
        )

@define_behavior
def py_pow_bintX_sintY(self: bint, other: sint):
    return py_int_from_host(py_bint_to_host(self) ** py_sint_to_host(other))

@define_behavior
def py_pow_bintX_bintY(self: bint, other: bint):
    return py_int_from_host(py_bint_to_host(self) ** py_bint_to_host(other))

@define_behavior
def py_rshift_floatX_floatY(self: float, other: float):
    raise TypeError("unsupported operand type(s) for >>: 'float' and 'float'")

@define_behavior
def py_rshift_floatX_boolY(self: float, other: bool):
    raise TypeError("unsupported operand type(s) for >>: 'float' and 'bool'")

@define_behavior
def py_rshift_floatX_sintY(self: float, other: sint):
    raise TypeError("unsupported operand type(s) for >>: 'float' and 'int'")

@define_behavior
def py_rshift_floatX_bintY(self: float, other: bint):
    raise TypeError("unsupported operand type(s) for >>: 'float' and 'int'")

@define_behavior
def py_rshift_boolX_floatY(self: bool, other: float):
    raise TypeError("unsupported operand type(s) for >>: 'bool' and 'float'")

@define_behavior
def py_rshift_boolX_boolY(self: bool, other: bool):
    if other >= 0:
        return py_int_from_host(py_bool_to_host_int(self) >>
            py_bool_to_host_int(other))
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_rshift_boolX_sintY(self: bool, other: sint):
    if other >= 0:
        return py_int_from_host(py_bool_to_host_int(self) >>
            py_sint_to_host(other))
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_rshift_boolX_bintY(self: bool, other: bint):
    if other >= 0:
        return py_int_from_host(py_bool_to_host_int(self) >>
            py_bint_to_host(other))
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_rshift_sintX_floatY(self: sint, other: float):
    raise TypeError("unsupported operand type(s) for >>: 'int' and 'float'")

@define_behavior
def py_rshift_sintX_boolY(self: sint, other: bool):
    if other >= 0:
        return py_int_from_host(py_sint_to_host(self) >>
            py_bool_to_host_int(other))
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_rshift_sintX_sintY(self: sint, other: sint):
    if other >= 0:
        return py_int_from_host(py_sint_to_host(self) >> py_sint_to_host(other)
            )
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_rshift_sintX_bintY(self: sint, other: bint):
    if other >= 0:
        return py_int_from_host(py_sint_to_host(self) >> py_bint_to_host(other)
            )
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_rshift_bintX_floatY(self: bint, other: float):
    raise TypeError("unsupported operand type(s) for >>: 'int' and 'float'")

@define_behavior
def py_rshift_bintX_boolY(self: bint, other: bool):
    if other >= 0:
        return py_int_from_host(py_bint_to_host(self) >>
            py_bool_to_host_int(other))
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_rshift_bintX_sintY(self: bint, other: sint):
    if other >= 0:
        return py_int_from_host(py_bint_to_host(self) >> py_sint_to_host(other)
            )
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_rshift_bintX_bintY(self: bint, other: bint):
    if other >= 0:
        return py_int_from_host(py_bint_to_host(self) >> py_bint_to_host(other)
            )
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_sub_floatX_floatY(self: float, other: float):
    return py_float_from_host(py_float_to_host(self) - py_float_to_host(other))

@define_behavior
def py_sub_floatX_boolY(self: float, other: bool):
    return py_float_from_host(py_float_to_host(self) - py_bool_to_host_int(
        other))

@define_behavior
def py_sub_floatX_sintY(self: float, other: sint):
    return py_float_from_host(py_float_to_host(self) - py_sint_to_host(other))

@define_behavior
def py_sub_floatX_bintY(self: float, other: bint):
    return py_float_from_host(py_float_to_host(self) - py_bint_to_host(other))

@define_behavior
def py_sub_boolX_floatY(other: bool, self: float):
    return py_float_from_host(py_bool_to_host_int(other) - py_float_to_host
        (self))

@define_behavior
def py_sub_boolX_boolY(self: bool, other: bool):
    return py_int_from_host(py_bool_to_host_int(self) - py_bool_to_host_int
        (other))

@define_behavior
def py_sub_boolX_sintY(self: bool, other: sint):
    return py_int_from_host(py_bool_to_host_int(self) - py_sint_to_host(other))

@define_behavior
def py_sub_boolX_bintY(self: bool, other: bint):
    return py_int_from_host(py_bool_to_host_int(self) - py_bint_to_host(other))

@define_behavior
def py_sub_sintX_floatY(other: sint, self: float):
    return py_float_from_host(py_sint_to_host(other) - py_float_to_host(self))

@define_behavior
def py_sub_sintX_boolY(self: sint, other: bool):
    return py_int_from_host(py_sint_to_host(self) - py_bool_to_host_int(other))

@define_behavior
def py_sub_sintX_sintY(self: sint, other: sint):
    return py_int_from_host(py_sint_to_host(self) - py_sint_to_host(other))

@define_behavior
def py_sub_sintX_bintY(self: sint, other: bint):
    return py_int_from_host(py_sint_to_host(self) - py_bint_to_host(other))

@define_behavior
def py_sub_bintX_floatY(other: bint, self: float):
    return py_float_from_host(py_bint_to_host(other) - py_float_to_host(self))

@define_behavior
def py_sub_bintX_boolY(self: bint, other: bool):
    return py_int_from_host(py_bint_to_host(self) - py_bool_to_host_int(other))

@define_behavior
def py_sub_bintX_sintY(self: bint, other: sint):
    return py_int_from_host(py_bint_to_host(self) - py_sint_to_host(other))

@define_behavior
def py_sub_bintX_bintY(self: bint, other: bint):
    return py_int_from_host(py_bint_to_host(self) - py_bint_to_host(other))

@define_behavior
def py_truediv_floatX_floatY(self: float, other: float):
    if other != 0.0:
        return py_float_from_host(py_float_to_host(self) / py_float_to_host
            (other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_truediv_floatX_boolY(self: float, other: bool):
    if other != 0:
        return py_float_from_host(py_float_to_host(self) /
            py_bool_to_host_int(other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_truediv_floatX_sintY(self: float, other: sint):
    if other != 0:
        return py_float_from_host(py_float_to_host(self) / py_sint_to_host(
            other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_truediv_floatX_bintY(self: float, other: bint):
    if other != 0:
        return py_float_from_host(py_float_to_host(self) / py_bint_to_host(
            other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_truediv_boolX_floatY(other: bool, self: float):
    if self != 0.0:
        return py_float_from_host(py_bool_to_host_int(other) /
            py_float_to_host(self))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_truediv_boolX_boolY(self: bool, other: bool):
    if other != 0:
        return py_float_from_host(py_bool_to_host_int(self) /
            py_bool_to_host_int(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_truediv_boolX_sintY(self: bool, other: sint):
    if other != 0:
        return py_float_from_host(py_bool_to_host_int(self) /
            py_sint_to_host(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_truediv_boolX_bintY(self: bool, other: bint):
    if other != 0:
        return py_float_from_host(py_bool_to_host_int(self) /
            py_bint_to_host(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_truediv_sintX_floatY(other: sint, self: float):
    if self != 0.0:
        return py_float_from_host(py_sint_to_host(other) / py_float_to_host
            (self))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_truediv_sintX_boolY(self: sint, other: bool):
    if other != 0:
        return py_float_from_host(py_sint_to_host(self) /
            py_bool_to_host_int(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_truediv_sintX_sintY(self: sint, other: sint):
    if other != 0:
        return py_float_from_host(py_sint_to_host(self) / py_sint_to_host(
            other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_truediv_sintX_bintY(self: sint, other: bint):
    if other != 0:
        return py_float_from_host(py_sint_to_host(self) / py_bint_to_host(
            other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_truediv_bintX_floatY(other: bint, self: float):
    if self != 0.0:
        return py_float_from_host(py_bint_to_host(other) / py_float_to_host
            (self))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_truediv_bintX_boolY(self: bint, other: bool):
    if other != 0:
        return py_float_from_host(py_bint_to_host(self) /
            py_bool_to_host_int(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_truediv_bintX_sintY(self: bint, other: sint):
    if other != 0:
        return py_float_from_host(py_bint_to_host(self) / py_sint_to_host(
            other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_truediv_bintX_bintY(self: bint, other: bint):
    if other != 0:
        return py_float_from_host(py_bint_to_host(self) / py_bint_to_host(
            other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_xor_floatX_floatY(self: float, other: float):
    raise TypeError("unsupported operand type(s) for ^: 'float' and 'float'")

@define_behavior
def py_xor_floatX_boolY(self: float, other: bool):
    raise TypeError("unsupported operand type(s) for ^: 'float' and 'bool'")

@define_behavior
def py_xor_floatX_sintY(self: float, other: sint):
    raise TypeError("unsupported operand type(s) for ^: 'float' and 'int'")

@define_behavior
def py_xor_floatX_bintY(self: float, other: bint):
    raise TypeError("unsupported operand type(s) for ^: 'float' and 'int'")

@define_behavior
def py_xor_boolX_floatY(self: bool, other: float):
    raise TypeError("unsupported operand type(s) for ^: 'bool' and 'float'")

@define_behavior
def py_xor_boolX_boolY(self: bool, other: bool):
    return self is not other

@define_behavior
def py_xor_boolX_sintY(self: bool, other: sint):
    return py_int_from_host(py_bool_to_host_int(self) ^ py_sint_to_host(other))

@define_behavior
def py_xor_boolX_bintY(self: bool, other: bint):
    return py_int_from_host(py_bool_to_host_int(self) ^ py_bint_to_host(other))

@define_behavior
def py_xor_sintX_floatY(self: sint, other: float):
    raise TypeError("unsupported operand type(s) for ^: 'int' and 'float'")

@define_behavior
def py_xor_sintX_boolY(self: sint, other: bool):
    return py_int_from_host(py_sint_to_host(self) ^ py_bool_to_host_int(other))

@define_behavior
def py_xor_sintX_sintY(self: sint, other: sint):
    return py_int_from_host(py_sint_to_host(self) ^ py_sint_to_host(other))

@define_behavior
def py_xor_sintX_bintY(self: sint, other: bint):
    return py_int_from_host(py_sint_to_host(self) ^ py_bint_to_host(other))

@define_behavior
def py_xor_bintX_floatY(self: bint, other: float):
    raise TypeError("unsupported operand type(s) for ^: 'int' and 'float'")

@define_behavior
def py_xor_bintX_boolY(self: bint, other: bool):
    return py_int_from_host(py_bint_to_host(self) ^ py_bool_to_host_int(other))

@define_behavior
def py_xor_bintX_sintY(self: bint, other: sint):
    return py_int_from_host(py_bint_to_host(self) ^ py_sint_to_host(other))

@define_behavior
def py_xor_bintX_bintY(self: bint, other: bint):
    return py_int_from_host(py_bint_to_host(self) ^ py_bint_to_host(other))

@define_behavior
def py_iadd_floatX_floatY(self: float, other: float):
    return py_float_from_host(py_float_to_host(self) + py_float_to_host(other))

@define_behavior
def py_iadd_floatX_boolY(self: float, other: bool):
    return py_float_from_host(py_float_to_host(self) + py_bool_to_host_int(
        other))

@define_behavior
def py_iadd_floatX_sintY(self: float, other: sint):
    return py_float_from_host(py_float_to_host(self) + py_sint_to_host(other))

@define_behavior
def py_iadd_floatX_bintY(self: float, other: bint):
    return py_float_from_host(py_float_to_host(self) + py_bint_to_host(other))

@define_behavior
def py_iadd_boolX_floatY(other: bool, self: float):
    return py_float_from_host(py_bool_to_host_int(other) + py_float_to_host
        (self))

@define_behavior
def py_iadd_boolX_boolY(self: bool, other: bool):
    return py_int_from_host(py_bool_to_host_int(self) + py_bool_to_host_int
        (other))

@define_behavior
def py_iadd_boolX_sintY(self: bool, other: sint):
    return py_int_from_host(py_bool_to_host_int(self) + py_sint_to_host(other))

@define_behavior
def py_iadd_boolX_bintY(self: bool, other: bint):
    return py_int_from_host(py_bool_to_host_int(self) + py_bint_to_host(other))

@define_behavior
def py_iadd_sintX_floatY(other: sint, self: float):
    return py_float_from_host(py_sint_to_host(other) + py_float_to_host(self))

@define_behavior
def py_iadd_sintX_boolY(self: sint, other: bool):
    return py_int_from_host(py_sint_to_host(self) + py_bool_to_host_int(other))

@define_behavior
def py_iadd_sintX_sintY(self: sint, other: sint):
    return py_int_from_host(py_sint_to_host(self) + py_sint_to_host(other))

@define_behavior
def py_iadd_sintX_bintY(self: sint, other: bint):
    return py_int_from_host(py_sint_to_host(self) + py_bint_to_host(other))

@define_behavior
def py_iadd_bintX_floatY(other: bint, self: float):
    return py_float_from_host(py_bint_to_host(other) + py_float_to_host(self))

@define_behavior
def py_iadd_bintX_boolY(self: bint, other: bool):
    return py_int_from_host(py_bint_to_host(self) + py_bool_to_host_int(other))

@define_behavior
def py_iadd_bintX_sintY(self: bint, other: sint):
    return py_int_from_host(py_bint_to_host(self) + py_sint_to_host(other))

@define_behavior
def py_iadd_bintX_bintY(self: bint, other: bint):
    return py_int_from_host(py_bint_to_host(self) + py_bint_to_host(other))

@define_behavior
def py_ibitand_floatX_floatY(self: float, other: float):
    raise TypeError("unsupported operand type(s) for &=: 'float' and 'float'")

@define_behavior
def py_ibitand_floatX_boolY(self: float, other: bool):
    raise TypeError("unsupported operand type(s) for &=: 'float' and 'bool'")

@define_behavior
def py_ibitand_floatX_sintY(self: float, other: sint):
    raise TypeError("unsupported operand type(s) for &=: 'float' and 'int'")

@define_behavior
def py_ibitand_floatX_bintY(self: float, other: bint):
    raise TypeError("unsupported operand type(s) for &=: 'float' and 'int'")

@define_behavior
def py_ibitand_boolX_floatY(self: bool, other: float):
    raise TypeError("unsupported operand type(s) for &=: 'bool' and 'float'")

@define_behavior
def py_ibitand_boolX_boolY(self: bool, other: bool):
    return other if self is True else False

@define_behavior
def py_ibitand_boolX_sintY(self: bool, other: sint):
    return py_int_from_host(py_bool_to_host_int(self) & py_sint_to_host(other))

@define_behavior
def py_ibitand_boolX_bintY(self: bool, other: bint):
    return py_int_from_host(py_bool_to_host_int(self) & py_bint_to_host(other))

@define_behavior
def py_ibitand_sintX_floatY(self: sint, other: float):
    raise TypeError("unsupported operand type(s) for &=: 'int' and 'float'")

@define_behavior
def py_ibitand_sintX_boolY(self: sint, other: bool):
    return py_int_from_host(py_sint_to_host(self) & py_bool_to_host_int(other))

@define_behavior
def py_ibitand_sintX_sintY(self: sint, other: sint):
    return py_int_from_host(py_sint_to_host(self) & py_sint_to_host(other))

@define_behavior
def py_ibitand_sintX_bintY(self: sint, other: bint):
    return py_int_from_host(py_sint_to_host(self) & py_bint_to_host(other))

@define_behavior
def py_ibitand_bintX_floatY(self: bint, other: float):
    raise TypeError("unsupported operand type(s) for &=: 'int' and 'float'")

@define_behavior
def py_ibitand_bintX_boolY(self: bint, other: bool):
    return py_int_from_host(py_bint_to_host(self) & py_bool_to_host_int(other))

@define_behavior
def py_ibitand_bintX_sintY(self: bint, other: sint):
    return py_int_from_host(py_bint_to_host(self) & py_sint_to_host(other))

@define_behavior
def py_ibitand_bintX_bintY(self: bint, other: bint):
    return py_int_from_host(py_bint_to_host(self) & py_bint_to_host(other))

@define_behavior
def py_ibitor_floatX_floatY(self: float, other: float):
    raise TypeError("unsupported operand type(s) for |=: 'float' and 'float'")

@define_behavior
def py_ibitor_floatX_boolY(self: float, other: bool):
    raise TypeError("unsupported operand type(s) for |=: 'float' and 'bool'")

@define_behavior
def py_ibitor_floatX_sintY(self: float, other: sint):
    raise TypeError("unsupported operand type(s) for |=: 'float' and 'int'")

@define_behavior
def py_ibitor_floatX_bintY(self: float, other: bint):
    raise TypeError("unsupported operand type(s) for |=: 'float' and 'int'")

@define_behavior
def py_ibitor_boolX_floatY(self: bool, other: float):
    raise TypeError("unsupported operand type(s) for |=: 'bool' and 'float'")

@define_behavior
def py_ibitor_boolX_boolY(self: bool, other: bool):
    return True if self is True else other

@define_behavior
def py_ibitor_boolX_sintY(self: bool, other: sint):
    return py_int_from_host(py_bool_to_host_int(self) | py_sint_to_host(other))

@define_behavior
def py_ibitor_boolX_bintY(self: bool, other: bint):
    return py_int_from_host(py_bool_to_host_int(self) | py_bint_to_host(other))

@define_behavior
def py_ibitor_sintX_floatY(self: sint, other: float):
    raise TypeError("unsupported operand type(s) for |=: 'int' and 'float'")

@define_behavior
def py_ibitor_sintX_boolY(self: sint, other: bool):
    return py_int_from_host(py_sint_to_host(self) | py_bool_to_host_int(other))

@define_behavior
def py_ibitor_sintX_sintY(self: sint, other: sint):
    return py_int_from_host(py_sint_to_host(self) | py_sint_to_host(other))

@define_behavior
def py_ibitor_sintX_bintY(self: sint, other: bint):
    return py_int_from_host(py_sint_to_host(self) | py_bint_to_host(other))

@define_behavior
def py_ibitor_bintX_floatY(self: bint, other: float):
    raise TypeError("unsupported operand type(s) for |=: 'int' and 'float'")

@define_behavior
def py_ibitor_bintX_boolY(self: bint, other: bool):
    return py_int_from_host(py_bint_to_host(self) | py_bool_to_host_int(other))

@define_behavior
def py_ibitor_bintX_sintY(self: bint, other: sint):
    return py_int_from_host(py_bint_to_host(self) | py_sint_to_host(other))

@define_behavior
def py_ibitor_bintX_bintY(self: bint, other: bint):
    return py_int_from_host(py_bint_to_host(self) | py_bint_to_host(other))

@define_behavior
def py_ifloordiv_floatX_floatY(self: float, other: float):
    if other != 0.0:
        return py_float_from_host(py_float_to_host(self) //
            py_float_to_host(other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_ifloordiv_floatX_boolY(self: float, other: bool):
    if other != 0:
        return py_float_from_host(py_float_to_host(self) //
            py_bool_to_host_int(other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_ifloordiv_floatX_sintY(self: float, other: sint):
    if other != 0:
        return py_float_from_host(py_float_to_host(self) // py_sint_to_host
            (other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_ifloordiv_floatX_bintY(self: float, other: bint):
    if other != 0:
        return py_float_from_host(py_float_to_host(self) // py_bint_to_host
            (other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_ifloordiv_boolX_floatY(other: bool, self: float):
    if self != 0.0:
        return py_float_from_host(py_bool_to_host_int(other) //
            py_float_to_host(self))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_ifloordiv_boolX_boolY(self: bool, other: bool):
    if other != 0:
        return py_int_from_host(py_bool_to_host_int(self) //
            py_bool_to_host_int(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_ifloordiv_boolX_sintY(self: bool, other: sint):
    if other != 0:
        return py_int_from_host(py_bool_to_host_int(self) //
            py_sint_to_host(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_ifloordiv_boolX_bintY(self: bool, other: bint):
    if other != 0:
        return py_int_from_host(py_bool_to_host_int(self) //
            py_bint_to_host(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_ifloordiv_sintX_floatY(other: sint, self: float):
    if self != 0.0:
        return py_float_from_host(py_sint_to_host(other) //
            py_float_to_host(self))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_ifloordiv_sintX_boolY(self: sint, other: bool):
    if other != 0:
        return py_int_from_host(py_sint_to_host(self) //
            py_bool_to_host_int(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_ifloordiv_sintX_sintY(self: sint, other: sint):
    if other != 0:
        return py_int_from_host(py_sint_to_host(self) // py_sint_to_host(other)
            )
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_ifloordiv_sintX_bintY(self: sint, other: bint):
    if other != 0:
        return py_int_from_host(py_sint_to_host(self) // py_bint_to_host(other)
            )
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_ifloordiv_bintX_floatY(other: bint, self: float):
    if self != 0.0:
        return py_float_from_host(py_bint_to_host(other) //
            py_float_to_host(self))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_ifloordiv_bintX_boolY(self: bint, other: bool):
    if other != 0:
        return py_int_from_host(py_bint_to_host(self) //
            py_bool_to_host_int(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_ifloordiv_bintX_sintY(self: bint, other: sint):
    if other != 0:
        return py_int_from_host(py_bint_to_host(self) // py_sint_to_host(other)
            )
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_ifloordiv_bintX_bintY(self: bint, other: bint):
    if other != 0:
        return py_int_from_host(py_bint_to_host(self) // py_bint_to_host(other)
            )
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_ilshift_floatX_floatY(self: float, other: float):
    raise TypeError("unsupported operand type(s) for <<=: 'float' and 'float'")

@define_behavior
def py_ilshift_floatX_boolY(self: float, other: bool):
    raise TypeError("unsupported operand type(s) for <<=: 'float' and 'bool'")

@define_behavior
def py_ilshift_floatX_sintY(self: float, other: sint):
    raise TypeError("unsupported operand type(s) for <<=: 'float' and 'int'")

@define_behavior
def py_ilshift_floatX_bintY(self: float, other: bint):
    raise TypeError("unsupported operand type(s) for <<=: 'float' and 'int'")

@define_behavior
def py_ilshift_boolX_floatY(self: bool, other: float):
    raise TypeError("unsupported operand type(s) for <<=: 'bool' and 'float'")

@define_behavior
def py_ilshift_boolX_boolY(self: bool, other: bool):
    if other >= 0:
        return py_int_from_host(py_bool_to_host_int(self) <<
            py_bool_to_host_int(other))
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_ilshift_boolX_sintY(self: bool, other: sint):
    if other >= 0:
        return py_int_from_host(py_bool_to_host_int(self) <<
            py_sint_to_host(other))
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_ilshift_boolX_bintY(self: bool, other: bint):
    if other >= 0:
        return py_int_from_host(py_bool_to_host_int(self) <<
            py_bint_to_host(other))
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_ilshift_sintX_floatY(self: sint, other: float):
    raise TypeError("unsupported operand type(s) for <<=: 'int' and 'float'")

@define_behavior
def py_ilshift_sintX_boolY(self: sint, other: bool):
    if other >= 0:
        return py_int_from_host(py_sint_to_host(self) <<
            py_bool_to_host_int(other))
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_ilshift_sintX_sintY(self: sint, other: sint):
    if other >= 0:
        return py_int_from_host(py_sint_to_host(self) << py_sint_to_host(other)
            )
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_ilshift_sintX_bintY(self: sint, other: bint):
    if other >= 0:
        return py_int_from_host(py_sint_to_host(self) << py_bint_to_host(other)
            )
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_ilshift_bintX_floatY(self: bint, other: float):
    raise TypeError("unsupported operand type(s) for <<=: 'int' and 'float'")

@define_behavior
def py_ilshift_bintX_boolY(self: bint, other: bool):
    if other >= 0:
        return py_int_from_host(py_bint_to_host(self) <<
            py_bool_to_host_int(other))
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_ilshift_bintX_sintY(self: bint, other: sint):
    if other >= 0:
        return py_int_from_host(py_bint_to_host(self) << py_sint_to_host(other)
            )
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_ilshift_bintX_bintY(self: bint, other: bint):
    if other >= 0:
        return py_int_from_host(py_bint_to_host(self) << py_bint_to_host(other)
            )
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_imatmul_floatX_floatY(self: float, other: float):
    raise TypeError("unsupported operand type(s) for @=: 'float' and 'float'")

@define_behavior
def py_imatmul_floatX_boolY(self: float, other: bool):
    raise TypeError("unsupported operand type(s) for @=: 'float' and 'bool'")

@define_behavior
def py_imatmul_floatX_sintY(self: float, other: sint):
    raise TypeError("unsupported operand type(s) for @=: 'float' and 'int'")

@define_behavior
def py_imatmul_floatX_bintY(self: float, other: bint):
    raise TypeError("unsupported operand type(s) for @=: 'float' and 'int'")

@define_behavior
def py_imatmul_boolX_floatY(self: bool, other: float):
    raise TypeError("unsupported operand type(s) for @=: 'bool' and 'float'")

@define_behavior
def py_imatmul_boolX_boolY(self: bool, other: bool):
    raise TypeError("unsupported operand type(s) for @=: 'bool' and 'bool'")

@define_behavior
def py_imatmul_boolX_sintY(self: bool, other: sint):
    raise TypeError("unsupported operand type(s) for @=: 'bool' and 'int'")

@define_behavior
def py_imatmul_boolX_bintY(self: bool, other: bint):
    raise TypeError("unsupported operand type(s) for @=: 'bool' and 'int'")

@define_behavior
def py_imatmul_sintX_floatY(self: sint, other: float):
    raise TypeError("unsupported operand type(s) for @=: 'int' and 'float'")

@define_behavior
def py_imatmul_sintX_boolY(self: sint, other: bool):
    raise TypeError("unsupported operand type(s) for @=: 'int' and 'bool'")

@define_behavior
def py_imatmul_sintX_sintY(self: sint, other: sint):
    raise TypeError("unsupported operand type(s) for @=: 'int' and 'int'")

@define_behavior
def py_imatmul_sintX_bintY(self: sint, other: bint):
    raise TypeError("unsupported operand type(s) for @=: 'int' and 'int'")

@define_behavior
def py_imatmul_bintX_floatY(self: bint, other: float):
    raise TypeError("unsupported operand type(s) for @=: 'int' and 'float'")

@define_behavior
def py_imatmul_bintX_boolY(self: bint, other: bool):
    raise TypeError("unsupported operand type(s) for @=: 'int' and 'bool'")

@define_behavior
def py_imatmul_bintX_sintY(self: bint, other: sint):
    raise TypeError("unsupported operand type(s) for @=: 'int' and 'int'")

@define_behavior
def py_imatmul_bintX_bintY(self: bint, other: bint):
    raise TypeError("unsupported operand type(s) for @=: 'int' and 'int'")

@define_behavior
def py_imod_floatX_floatY(self: float, other: float):
    if other != 0.0:
        return py_float_from_host(py_float_to_host(self) % py_float_to_host
            (other))
    else:
        raise ZeroDivisionError('float modulo by zero')

@define_behavior
def py_imod_floatX_boolY(self: float, other: bool):
    if other != 0:
        return py_float_from_host(py_float_to_host(self) %
            py_bool_to_host_int(other))
    else:
        raise ZeroDivisionError('float modulo by zero')

@define_behavior
def py_imod_floatX_sintY(self: float, other: sint):
    if other != 0:
        return py_float_from_host(py_float_to_host(self) % py_sint_to_host(
            other))
    else:
        raise ZeroDivisionError('float modulo by zero')

@define_behavior
def py_imod_floatX_bintY(self: float, other: bint):
    if other != 0:
        return py_float_from_host(py_float_to_host(self) % py_bint_to_host(
            other))
    else:
        raise ZeroDivisionError('float modulo by zero')

@define_behavior
def py_imod_boolX_floatY(other: bool, self: float):
    if self != 0.0:
        return py_float_from_host(py_bool_to_host_int(other) %
            py_float_to_host(self))
    else:
        raise ZeroDivisionError('float modulo by zero')

@define_behavior
def py_imod_boolX_boolY(self: bool, other: bool):
    if other != 0:
        return py_int_from_host(py_bool_to_host_int(self) %
            py_bool_to_host_int(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_imod_boolX_sintY(self: bool, other: sint):
    if other != 0:
        return py_int_from_host(py_bool_to_host_int(self) % py_sint_to_host
            (other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_imod_boolX_bintY(self: bool, other: bint):
    if other != 0:
        return py_int_from_host(py_bool_to_host_int(self) % py_bint_to_host
            (other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_imod_sintX_floatY(other: sint, self: float):
    if self != 0.0:
        return py_float_from_host(py_sint_to_host(other) % py_float_to_host
            (self))
    else:
        raise ZeroDivisionError('float modulo by zero')

@define_behavior
def py_imod_sintX_boolY(self: sint, other: bool):
    if other != 0:
        return py_int_from_host(py_sint_to_host(self) % py_bool_to_host_int
            (other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_imod_sintX_sintY(self: sint, other: sint):
    if other != 0:
        return py_int_from_host(py_sint_to_host(self) % py_sint_to_host(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_imod_sintX_bintY(self: sint, other: bint):
    if other != 0:
        return py_int_from_host(py_sint_to_host(self) % py_bint_to_host(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_imod_bintX_floatY(other: bint, self: float):
    if self != 0.0:
        return py_float_from_host(py_bint_to_host(other) % py_float_to_host
            (self))
    else:
        raise ZeroDivisionError('float modulo by zero')

@define_behavior
def py_imod_bintX_boolY(self: bint, other: bool):
    if other != 0:
        return py_int_from_host(py_bint_to_host(self) % py_bool_to_host_int
            (other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_imod_bintX_sintY(self: bint, other: sint):
    if other != 0:
        return py_int_from_host(py_bint_to_host(self) % py_sint_to_host(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_imod_bintX_bintY(self: bint, other: bint):
    if other != 0:
        return py_int_from_host(py_bint_to_host(self) % py_bint_to_host(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_imul_floatX_floatY(self: float, other: float):
    return py_float_from_host(py_float_to_host(self) * py_float_to_host(other))

@define_behavior
def py_imul_floatX_boolY(self: float, other: bool):
    return py_float_from_host(py_float_to_host(self) * py_bool_to_host_int(
        other))

@define_behavior
def py_imul_floatX_sintY(self: float, other: sint):
    return py_float_from_host(py_float_to_host(self) * py_sint_to_host(other))

@define_behavior
def py_imul_floatX_bintY(self: float, other: bint):
    return py_float_from_host(py_float_to_host(self) * py_bint_to_host(other))

@define_behavior
def py_imul_boolX_floatY(other: bool, self: float):
    return py_float_from_host(py_bool_to_host_int(other) * py_float_to_host
        (self))

@define_behavior
def py_imul_boolX_boolY(self: bool, other: bool):
    return py_int_from_host(py_bool_to_host_int(self) * py_bool_to_host_int
        (other))

@define_behavior
def py_imul_boolX_sintY(self: bool, other: sint):
    return py_int_from_host(py_bool_to_host_int(self) * py_sint_to_host(other))

@define_behavior
def py_imul_boolX_bintY(self: bool, other: bint):
    return py_int_from_host(py_bool_to_host_int(self) * py_bint_to_host(other))

@define_behavior
def py_imul_sintX_floatY(other: sint, self: float):
    return py_float_from_host(py_sint_to_host(other) * py_float_to_host(self))

@define_behavior
def py_imul_sintX_boolY(self: sint, other: bool):
    return py_int_from_host(py_sint_to_host(self) * py_bool_to_host_int(other))

@define_behavior
def py_imul_sintX_sintY(self: sint, other: sint):
    return py_int_from_host(py_sint_to_host(self) * py_sint_to_host(other))

@define_behavior
def py_imul_sintX_bintY(self: sint, other: bint):
    return py_int_from_host(py_sint_to_host(self) * py_bint_to_host(other))

@define_behavior
def py_imul_bintX_floatY(other: bint, self: float):
    return py_float_from_host(py_bint_to_host(other) * py_float_to_host(self))

@define_behavior
def py_imul_bintX_boolY(self: bint, other: bool):
    return py_int_from_host(py_bint_to_host(self) * py_bool_to_host_int(other))

@define_behavior
def py_imul_bintX_sintY(self: bint, other: sint):
    return py_int_from_host(py_bint_to_host(self) * py_sint_to_host(other))

@define_behavior
def py_imul_bintX_bintY(self: bint, other: bint):
    return py_int_from_host(py_bint_to_host(self) * py_bint_to_host(other))

@define_behavior
def py_ipow_floatX_floatY(self: float, other: float):
    return py_float_from_host(py_float_to_host(self) ** py_float_to_host(other)
        )

@define_behavior
def py_ipow_floatX_boolY(self: float, other: bool):
    return py_float_from_host(py_float_to_host(self) ** py_bool_to_host_int
        (other))

@define_behavior
def py_ipow_floatX_sintY(self: float, other: sint):
    return py_float_from_host(py_float_to_host(self) ** py_sint_to_host(other))

@define_behavior
def py_ipow_floatX_bintY(self: float, other: bint):
    return py_float_from_host(py_float_to_host(self) ** py_bint_to_host(other))

@define_behavior
def py_ipow_boolX_floatY(other: bool, self: float):
    return py_float_from_host(py_bool_to_host_int(other) **
        py_float_to_host(self))

@define_behavior
def py_ipow_boolX_boolY(self: bool, other: bool):
    return py_int_from_host(py_bool_to_host_int(self) **
        py_bool_to_host_int(other))

@define_behavior
def py_ipow_boolX_sintY(self: bool, other: sint):
    return py_int_from_host(py_bool_to_host_int(self) ** py_sint_to_host(other)
        )

@define_behavior
def py_ipow_boolX_bintY(self: bool, other: bint):
    return py_int_from_host(py_bool_to_host_int(self) ** py_bint_to_host(other)
        )

@define_behavior
def py_ipow_sintX_floatY(other: sint, self: float):
    return py_float_from_host(py_sint_to_host(other) ** py_float_to_host(self))

@define_behavior
def py_ipow_sintX_boolY(self: sint, other: bool):
    return py_int_from_host(py_sint_to_host(self) ** py_bool_to_host_int(other)
        )

@define_behavior
def py_ipow_sintX_sintY(self: sint, other: sint):
    return py_int_from_host(py_sint_to_host(self) ** py_sint_to_host(other))

@define_behavior
def py_ipow_sintX_bintY(self: sint, other: bint):
    return py_int_from_host(py_sint_to_host(self) ** py_bint_to_host(other))

@define_behavior
def py_ipow_bintX_floatY(other: bint, self: float):
    return py_float_from_host(py_bint_to_host(other) ** py_float_to_host(self))

@define_behavior
def py_ipow_bintX_boolY(self: bint, other: bool):
    return py_int_from_host(py_bint_to_host(self) ** py_bool_to_host_int(other)
        )

@define_behavior
def py_ipow_bintX_sintY(self: bint, other: sint):
    return py_int_from_host(py_bint_to_host(self) ** py_sint_to_host(other))

@define_behavior
def py_ipow_bintX_bintY(self: bint, other: bint):
    return py_int_from_host(py_bint_to_host(self) ** py_bint_to_host(other))

@define_behavior
def py_irshift_floatX_floatY(self: float, other: float):
    raise TypeError("unsupported operand type(s) for >>=: 'float' and 'float'")

@define_behavior
def py_irshift_floatX_boolY(self: float, other: bool):
    raise TypeError("unsupported operand type(s) for >>=: 'float' and 'bool'")

@define_behavior
def py_irshift_floatX_sintY(self: float, other: sint):
    raise TypeError("unsupported operand type(s) for >>=: 'float' and 'int'")

@define_behavior
def py_irshift_floatX_bintY(self: float, other: bint):
    raise TypeError("unsupported operand type(s) for >>=: 'float' and 'int'")

@define_behavior
def py_irshift_boolX_floatY(self: bool, other: float):
    raise TypeError("unsupported operand type(s) for >>=: 'bool' and 'float'")

@define_behavior
def py_irshift_boolX_boolY(self: bool, other: bool):
    if other >= 0:
        return py_int_from_host(py_bool_to_host_int(self) >>
            py_bool_to_host_int(other))
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_irshift_boolX_sintY(self: bool, other: sint):
    if other >= 0:
        return py_int_from_host(py_bool_to_host_int(self) >>
            py_sint_to_host(other))
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_irshift_boolX_bintY(self: bool, other: bint):
    if other >= 0:
        return py_int_from_host(py_bool_to_host_int(self) >>
            py_bint_to_host(other))
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_irshift_sintX_floatY(self: sint, other: float):
    raise TypeError("unsupported operand type(s) for >>=: 'int' and 'float'")

@define_behavior
def py_irshift_sintX_boolY(self: sint, other: bool):
    if other >= 0:
        return py_int_from_host(py_sint_to_host(self) >>
            py_bool_to_host_int(other))
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_irshift_sintX_sintY(self: sint, other: sint):
    if other >= 0:
        return py_int_from_host(py_sint_to_host(self) >> py_sint_to_host(other)
            )
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_irshift_sintX_bintY(self: sint, other: bint):
    if other >= 0:
        return py_int_from_host(py_sint_to_host(self) >> py_bint_to_host(other)
            )
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_irshift_bintX_floatY(self: bint, other: float):
    raise TypeError("unsupported operand type(s) for >>=: 'int' and 'float'")

@define_behavior
def py_irshift_bintX_boolY(self: bint, other: bool):
    if other >= 0:
        return py_int_from_host(py_bint_to_host(self) >>
            py_bool_to_host_int(other))
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_irshift_bintX_sintY(self: bint, other: sint):
    if other >= 0:
        return py_int_from_host(py_bint_to_host(self) >> py_sint_to_host(other)
            )
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_irshift_bintX_bintY(self: bint, other: bint):
    if other >= 0:
        return py_int_from_host(py_bint_to_host(self) >> py_bint_to_host(other)
            )
    else:
        raise ValueError('negative shift count')

@define_behavior
def py_isub_floatX_floatY(self: float, other: float):
    return py_float_from_host(py_float_to_host(self) - py_float_to_host(other))

@define_behavior
def py_isub_floatX_boolY(self: float, other: bool):
    return py_float_from_host(py_float_to_host(self) - py_bool_to_host_int(
        other))

@define_behavior
def py_isub_floatX_sintY(self: float, other: sint):
    return py_float_from_host(py_float_to_host(self) - py_sint_to_host(other))

@define_behavior
def py_isub_floatX_bintY(self: float, other: bint):
    return py_float_from_host(py_float_to_host(self) - py_bint_to_host(other))

@define_behavior
def py_isub_boolX_floatY(other: bool, self: float):
    return py_float_from_host(py_bool_to_host_int(other) - py_float_to_host
        (self))

@define_behavior
def py_isub_boolX_boolY(self: bool, other: bool):
    return py_int_from_host(py_bool_to_host_int(self) - py_bool_to_host_int
        (other))

@define_behavior
def py_isub_boolX_sintY(self: bool, other: sint):
    return py_int_from_host(py_bool_to_host_int(self) - py_sint_to_host(other))

@define_behavior
def py_isub_boolX_bintY(self: bool, other: bint):
    return py_int_from_host(py_bool_to_host_int(self) - py_bint_to_host(other))

@define_behavior
def py_isub_sintX_floatY(other: sint, self: float):
    return py_float_from_host(py_sint_to_host(other) - py_float_to_host(self))

@define_behavior
def py_isub_sintX_boolY(self: sint, other: bool):
    return py_int_from_host(py_sint_to_host(self) - py_bool_to_host_int(other))

@define_behavior
def py_isub_sintX_sintY(self: sint, other: sint):
    return py_int_from_host(py_sint_to_host(self) - py_sint_to_host(other))

@define_behavior
def py_isub_sintX_bintY(self: sint, other: bint):
    return py_int_from_host(py_sint_to_host(self) - py_bint_to_host(other))

@define_behavior
def py_isub_bintX_floatY(other: bint, self: float):
    return py_float_from_host(py_bint_to_host(other) - py_float_to_host(self))

@define_behavior
def py_isub_bintX_boolY(self: bint, other: bool):
    return py_int_from_host(py_bint_to_host(self) - py_bool_to_host_int(other))

@define_behavior
def py_isub_bintX_sintY(self: bint, other: sint):
    return py_int_from_host(py_bint_to_host(self) - py_sint_to_host(other))

@define_behavior
def py_isub_bintX_bintY(self: bint, other: bint):
    return py_int_from_host(py_bint_to_host(self) - py_bint_to_host(other))

@define_behavior
def py_itruediv_floatX_floatY(self: float, other: float):
    if other != 0.0:
        return py_float_from_host(py_float_to_host(self) / py_float_to_host
            (other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_itruediv_floatX_boolY(self: float, other: bool):
    if other != 0:
        return py_float_from_host(py_float_to_host(self) /
            py_bool_to_host_int(other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_itruediv_floatX_sintY(self: float, other: sint):
    if other != 0:
        return py_float_from_host(py_float_to_host(self) / py_sint_to_host(
            other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_itruediv_floatX_bintY(self: float, other: bint):
    if other != 0:
        return py_float_from_host(py_float_to_host(self) / py_bint_to_host(
            other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_itruediv_boolX_floatY(other: bool, self: float):
    if self != 0.0:
        return py_float_from_host(py_bool_to_host_int(other) /
            py_float_to_host(self))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_itruediv_boolX_boolY(self: bool, other: bool):
    if other != 0:
        return py_float_from_host(py_bool_to_host_int(self) /
            py_bool_to_host_int(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_itruediv_boolX_sintY(self: bool, other: sint):
    if other != 0:
        return py_float_from_host(py_bool_to_host_int(self) /
            py_sint_to_host(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_itruediv_boolX_bintY(self: bool, other: bint):
    if other != 0:
        return py_float_from_host(py_bool_to_host_int(self) /
            py_bint_to_host(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_itruediv_sintX_floatY(other: sint, self: float):
    if self != 0.0:
        return py_float_from_host(py_sint_to_host(other) / py_float_to_host
            (self))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_itruediv_sintX_boolY(self: sint, other: bool):
    if other != 0:
        return py_float_from_host(py_sint_to_host(self) /
            py_bool_to_host_int(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_itruediv_sintX_sintY(self: sint, other: sint):
    if other != 0:
        return py_float_from_host(py_sint_to_host(self) / py_sint_to_host(
            other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_itruediv_sintX_bintY(self: sint, other: bint):
    if other != 0:
        return py_float_from_host(py_sint_to_host(self) / py_bint_to_host(
            other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_itruediv_bintX_floatY(other: bint, self: float):
    if self != 0.0:
        return py_float_from_host(py_bint_to_host(other) / py_float_to_host
            (self))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_itruediv_bintX_boolY(self: bint, other: bool):
    if other != 0:
        return py_float_from_host(py_bint_to_host(self) /
            py_bool_to_host_int(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_itruediv_bintX_sintY(self: bint, other: sint):
    if other != 0:
        return py_float_from_host(py_bint_to_host(self) / py_sint_to_host(
            other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_itruediv_bintX_bintY(self: bint, other: bint):
    if other != 0:
        return py_float_from_host(py_bint_to_host(self) / py_bint_to_host(
            other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_ixor_floatX_floatY(self: float, other: float):
    raise TypeError("unsupported operand type(s) for ^=: 'float' and 'float'")

@define_behavior
def py_ixor_floatX_boolY(self: float, other: bool):
    raise TypeError("unsupported operand type(s) for ^=: 'float' and 'bool'")

@define_behavior
def py_ixor_floatX_sintY(self: float, other: sint):
    raise TypeError("unsupported operand type(s) for ^=: 'float' and 'int'")

@define_behavior
def py_ixor_floatX_bintY(self: float, other: bint):
    raise TypeError("unsupported operand type(s) for ^=: 'float' and 'int'")

@define_behavior
def py_ixor_boolX_floatY(self: bool, other: float):
    raise TypeError("unsupported operand type(s) for ^=: 'bool' and 'float'")

@define_behavior
def py_ixor_boolX_boolY(self: bool, other: bool):
    return self is not other

@define_behavior
def py_ixor_boolX_sintY(self: bool, other: sint):
    return py_int_from_host(py_bool_to_host_int(self) ^ py_sint_to_host(other))

@define_behavior
def py_ixor_boolX_bintY(self: bool, other: bint):
    return py_int_from_host(py_bool_to_host_int(self) ^ py_bint_to_host(other))

@define_behavior
def py_ixor_sintX_floatY(self: sint, other: float):
    raise TypeError("unsupported operand type(s) for ^=: 'int' and 'float'")

@define_behavior
def py_ixor_sintX_boolY(self: sint, other: bool):
    return py_int_from_host(py_sint_to_host(self) ^ py_bool_to_host_int(other))

@define_behavior
def py_ixor_sintX_sintY(self: sint, other: sint):
    return py_int_from_host(py_sint_to_host(self) ^ py_sint_to_host(other))

@define_behavior
def py_ixor_sintX_bintY(self: sint, other: bint):
    return py_int_from_host(py_sint_to_host(self) ^ py_bint_to_host(other))

@define_behavior
def py_ixor_bintX_floatY(self: bint, other: float):
    raise TypeError("unsupported operand type(s) for ^=: 'int' and 'float'")

@define_behavior
def py_ixor_bintX_boolY(self: bint, other: bool):
    return py_int_from_host(py_bint_to_host(self) ^ py_bool_to_host_int(other))

@define_behavior
def py_ixor_bintX_sintY(self: bint, other: sint):
    return py_int_from_host(py_bint_to_host(self) ^ py_sint_to_host(other))

@define_behavior
def py_ixor_bintX_bintY(self: bint, other: bint):
    return py_int_from_host(py_bint_to_host(self) ^ py_bint_to_host(other))

@define_behavior
def py_ge_floatX_floatY(self: float, other: float):
    return py_bool_from_host_bool(py_float_to_host(self) >=
        py_float_to_host(other))

@define_behavior
def py_test_ge_floatX_floatY(self: float, other: float):
    return py_float_to_host(self) >= py_float_to_host(other)

@define_behavior
def py_ge_floatX_boolY(self: float, other: bool):
    return py_bool_from_host_bool(py_float_to_host(self) >=
        py_bool_to_host_int(other))

@define_behavior
def py_test_ge_floatX_boolY(self: float, other: bool):
    return py_float_to_host(self) >= py_bool_to_host_int(other)

@define_behavior
def py_ge_floatX_sintY(self: float, other: sint):
    return py_bool_from_host_bool(py_float_to_host(self) >= py_sint_to_host
        (other))

@define_behavior
def py_test_ge_floatX_sintY(self: float, other: sint):
    return py_float_to_host(self) >= py_sint_to_host(other)

@define_behavior
def py_ge_floatX_bintY(self: float, other: bint):
    return py_bool_from_host_bool(py_float_to_host(self) >= py_bint_to_host
        (other))

@define_behavior
def py_test_ge_floatX_bintY(self: float, other: bint):
    return py_float_to_host(self) >= py_bint_to_host(other)

@define_behavior
def py_ge_boolX_floatY(other: bool, self: float):
    return py_bool_from_host_bool(py_float_to_host(self) <=
        py_bool_to_host_int(other))

@define_behavior
def py_test_ge_boolX_floatY(other: bool, self: float):
    return py_float_to_host(self) <= py_bool_to_host_int(other)

@define_behavior
def py_ge_boolX_boolY(self: bool, other: bool):
    return py_bool_from_host_bool(py_bool_to_host_int(self) >=
        py_bool_to_host_int(other))

@define_behavior
def py_test_ge_boolX_boolY(self: bool, other: bool):
    return py_bool_to_host_int(self) >= py_bool_to_host_int(other)

@define_behavior
def py_ge_boolX_sintY(self: bool, other: sint):
    return py_bool_from_host_bool(py_bool_to_host_int(self) >=
        py_sint_to_host(other))

@define_behavior
def py_test_ge_boolX_sintY(self: bool, other: sint):
    return py_bool_to_host_int(self) >= py_sint_to_host(other)

@define_behavior
def py_ge_boolX_bintY(self: bool, other: bint):
    return py_bool_from_host_bool(py_bool_to_host_int(self) >=
        py_bint_to_host(other))

@define_behavior
def py_test_ge_boolX_bintY(self: bool, other: bint):
    return py_bool_to_host_int(self) >= py_bint_to_host(other)

@define_behavior
def py_ge_sintX_floatY(other: sint, self: float):
    return py_bool_from_host_bool(py_float_to_host(self) <= py_sint_to_host
        (other))

@define_behavior
def py_test_ge_sintX_floatY(other: sint, self: float):
    return py_float_to_host(self) <= py_sint_to_host(other)

@define_behavior
def py_ge_sintX_boolY(self: sint, other: bool):
    return py_bool_from_host_bool(py_sint_to_host(self) >=
        py_bool_to_host_int(other))

@define_behavior
def py_test_ge_sintX_boolY(self: sint, other: bool):
    return py_sint_to_host(self) >= py_bool_to_host_int(other)

@define_behavior
def py_ge_sintX_sintY(self: sint, other: sint):
    return py_bool_from_host_bool(py_sint_to_host(self) >= py_sint_to_host(
        other))

@define_behavior
def py_test_ge_sintX_sintY(self: sint, other: sint):
    return py_sint_to_host(self) >= py_sint_to_host(other)

@define_behavior
def py_ge_sintX_bintY(self: sint, other: bint):
    return py_bool_from_host_bool(py_sint_to_host(self) >= py_bint_to_host(
        other))

@define_behavior
def py_test_ge_sintX_bintY(self: sint, other: bint):
    return py_sint_to_host(self) >= py_bint_to_host(other)

@define_behavior
def py_ge_bintX_floatY(other: bint, self: float):
    return py_bool_from_host_bool(py_float_to_host(self) <= py_bint_to_host
        (other))

@define_behavior
def py_test_ge_bintX_floatY(other: bint, self: float):
    return py_float_to_host(self) <= py_bint_to_host(other)

@define_behavior
def py_ge_bintX_boolY(self: bint, other: bool):
    return py_bool_from_host_bool(py_bint_to_host(self) >=
        py_bool_to_host_int(other))

@define_behavior
def py_test_ge_bintX_boolY(self: bint, other: bool):
    return py_bint_to_host(self) >= py_bool_to_host_int(other)

@define_behavior
def py_ge_bintX_sintY(self: bint, other: sint):
    return py_bool_from_host_bool(py_bint_to_host(self) >= py_sint_to_host(
        other))

@define_behavior
def py_test_ge_bintX_sintY(self: bint, other: sint):
    return py_bint_to_host(self) >= py_sint_to_host(other)

@define_behavior
def py_ge_bintX_bintY(self: bint, other: bint):
    return py_bool_from_host_bool(py_bint_to_host(self) >= py_bint_to_host(
        other))

@define_behavior
def py_test_ge_bintX_bintY(self: bint, other: bint):
    return py_bint_to_host(self) >= py_bint_to_host(other)

@define_behavior
def py_gt_floatX_floatY(self: float, other: float):
    return py_bool_from_host_bool(py_float_to_host(self) > py_float_to_host
        (other))

@define_behavior
def py_test_gt_floatX_floatY(self: float, other: float):
    return py_float_to_host(self) > py_float_to_host(other)

@define_behavior
def py_gt_floatX_boolY(self: float, other: bool):
    return py_bool_from_host_bool(py_float_to_host(self) >
        py_bool_to_host_int(other))

@define_behavior
def py_test_gt_floatX_boolY(self: float, other: bool):
    return py_float_to_host(self) > py_bool_to_host_int(other)

@define_behavior
def py_gt_floatX_sintY(self: float, other: sint):
    return py_bool_from_host_bool(py_float_to_host(self) > py_sint_to_host(
        other))

@define_behavior
def py_test_gt_floatX_sintY(self: float, other: sint):
    return py_float_to_host(self) > py_sint_to_host(other)

@define_behavior
def py_gt_floatX_bintY(self: float, other: bint):
    return py_bool_from_host_bool(py_float_to_host(self) > py_bint_to_host(
        other))

@define_behavior
def py_test_gt_floatX_bintY(self: float, other: bint):
    return py_float_to_host(self) > py_bint_to_host(other)

@define_behavior
def py_gt_boolX_floatY(other: bool, self: float):
    return py_bool_from_host_bool(py_float_to_host(self) <
        py_bool_to_host_int(other))

@define_behavior
def py_test_gt_boolX_floatY(other: bool, self: float):
    return py_float_to_host(self) < py_bool_to_host_int(other)

@define_behavior
def py_gt_boolX_boolY(self: bool, other: bool):
    return py_bool_from_host_bool(py_bool_to_host_int(self) >
        py_bool_to_host_int(other))

@define_behavior
def py_test_gt_boolX_boolY(self: bool, other: bool):
    return py_bool_to_host_int(self) > py_bool_to_host_int(other)

@define_behavior
def py_gt_boolX_sintY(self: bool, other: sint):
    return py_bool_from_host_bool(py_bool_to_host_int(self) >
        py_sint_to_host(other))

@define_behavior
def py_test_gt_boolX_sintY(self: bool, other: sint):
    return py_bool_to_host_int(self) > py_sint_to_host(other)

@define_behavior
def py_gt_boolX_bintY(self: bool, other: bint):
    return py_bool_from_host_bool(py_bool_to_host_int(self) >
        py_bint_to_host(other))

@define_behavior
def py_test_gt_boolX_bintY(self: bool, other: bint):
    return py_bool_to_host_int(self) > py_bint_to_host(other)

@define_behavior
def py_gt_sintX_floatY(other: sint, self: float):
    return py_bool_from_host_bool(py_float_to_host(self) < py_sint_to_host(
        other))

@define_behavior
def py_test_gt_sintX_floatY(other: sint, self: float):
    return py_float_to_host(self) < py_sint_to_host(other)

@define_behavior
def py_gt_sintX_boolY(self: sint, other: bool):
    return py_bool_from_host_bool(py_sint_to_host(self) >
        py_bool_to_host_int(other))

@define_behavior
def py_test_gt_sintX_boolY(self: sint, other: bool):
    return py_sint_to_host(self) > py_bool_to_host_int(other)

@define_behavior
def py_gt_sintX_sintY(self: sint, other: sint):
    return py_bool_from_host_bool(py_sint_to_host(self) > py_sint_to_host(
        other))

@define_behavior
def py_test_gt_sintX_sintY(self: sint, other: sint):
    return py_sint_to_host(self) > py_sint_to_host(other)

@define_behavior
def py_gt_sintX_bintY(self: sint, other: bint):
    return py_bool_from_host_bool(py_sint_to_host(self) > py_bint_to_host(
        other))

@define_behavior
def py_test_gt_sintX_bintY(self: sint, other: bint):
    return py_sint_to_host(self) > py_bint_to_host(other)

@define_behavior
def py_gt_bintX_floatY(other: bint, self: float):
    return py_bool_from_host_bool(py_float_to_host(self) < py_bint_to_host(
        other))

@define_behavior
def py_test_gt_bintX_floatY(other: bint, self: float):
    return py_float_to_host(self) < py_bint_to_host(other)

@define_behavior
def py_gt_bintX_boolY(self: bint, other: bool):
    return py_bool_from_host_bool(py_bint_to_host(self) >
        py_bool_to_host_int(other))

@define_behavior
def py_test_gt_bintX_boolY(self: bint, other: bool):
    return py_bint_to_host(self) > py_bool_to_host_int(other)

@define_behavior
def py_gt_bintX_sintY(self: bint, other: sint):
    return py_bool_from_host_bool(py_bint_to_host(self) > py_sint_to_host(
        other))

@define_behavior
def py_test_gt_bintX_sintY(self: bint, other: sint):
    return py_bint_to_host(self) > py_sint_to_host(other)

@define_behavior
def py_gt_bintX_bintY(self: bint, other: bint):
    return py_bool_from_host_bool(py_bint_to_host(self) > py_bint_to_host(
        other))

@define_behavior
def py_test_gt_bintX_bintY(self: bint, other: bint):
    return py_bint_to_host(self) > py_bint_to_host(other)

@define_behavior
def py_le_floatX_floatY(self: float, other: float):
    return py_bool_from_host_bool(py_float_to_host(self) <=
        py_float_to_host(other))

@define_behavior
def py_test_le_floatX_floatY(self: float, other: float):
    return py_float_to_host(self) <= py_float_to_host(other)

@define_behavior
def py_le_floatX_boolY(self: float, other: bool):
    return py_bool_from_host_bool(py_float_to_host(self) <=
        py_bool_to_host_int(other))

@define_behavior
def py_test_le_floatX_boolY(self: float, other: bool):
    return py_float_to_host(self) <= py_bool_to_host_int(other)

@define_behavior
def py_le_floatX_sintY(self: float, other: sint):
    return py_bool_from_host_bool(py_float_to_host(self) <= py_sint_to_host
        (other))

@define_behavior
def py_test_le_floatX_sintY(self: float, other: sint):
    return py_float_to_host(self) <= py_sint_to_host(other)

@define_behavior
def py_le_floatX_bintY(self: float, other: bint):
    return py_bool_from_host_bool(py_float_to_host(self) <= py_bint_to_host
        (other))

@define_behavior
def py_test_le_floatX_bintY(self: float, other: bint):
    return py_float_to_host(self) <= py_bint_to_host(other)

@define_behavior
def py_le_boolX_floatY(other: bool, self: float):
    return py_bool_from_host_bool(py_float_to_host(self) >=
        py_bool_to_host_int(other))

@define_behavior
def py_test_le_boolX_floatY(other: bool, self: float):
    return py_float_to_host(self) >= py_bool_to_host_int(other)

@define_behavior
def py_le_boolX_boolY(self: bool, other: bool):
    return py_bool_from_host_bool(py_bool_to_host_int(self) <=
        py_bool_to_host_int(other))

@define_behavior
def py_test_le_boolX_boolY(self: bool, other: bool):
    return py_bool_to_host_int(self) <= py_bool_to_host_int(other)

@define_behavior
def py_le_boolX_sintY(self: bool, other: sint):
    return py_bool_from_host_bool(py_bool_to_host_int(self) <=
        py_sint_to_host(other))

@define_behavior
def py_test_le_boolX_sintY(self: bool, other: sint):
    return py_bool_to_host_int(self) <= py_sint_to_host(other)

@define_behavior
def py_le_boolX_bintY(self: bool, other: bint):
    return py_bool_from_host_bool(py_bool_to_host_int(self) <=
        py_bint_to_host(other))

@define_behavior
def py_test_le_boolX_bintY(self: bool, other: bint):
    return py_bool_to_host_int(self) <= py_bint_to_host(other)

@define_behavior
def py_le_sintX_floatY(other: sint, self: float):
    return py_bool_from_host_bool(py_float_to_host(self) >= py_sint_to_host
        (other))

@define_behavior
def py_test_le_sintX_floatY(other: sint, self: float):
    return py_float_to_host(self) >= py_sint_to_host(other)

@define_behavior
def py_le_sintX_boolY(self: sint, other: bool):
    return py_bool_from_host_bool(py_sint_to_host(self) <=
        py_bool_to_host_int(other))

@define_behavior
def py_test_le_sintX_boolY(self: sint, other: bool):
    return py_sint_to_host(self) <= py_bool_to_host_int(other)

@define_behavior
def py_le_sintX_sintY(self: sint, other: sint):
    return py_bool_from_host_bool(py_sint_to_host(self) <= py_sint_to_host(
        other))

@define_behavior
def py_test_le_sintX_sintY(self: sint, other: sint):
    return py_sint_to_host(self) <= py_sint_to_host(other)

@define_behavior
def py_le_sintX_bintY(self: sint, other: bint):
    return py_bool_from_host_bool(py_sint_to_host(self) <= py_bint_to_host(
        other))

@define_behavior
def py_test_le_sintX_bintY(self: sint, other: bint):
    return py_sint_to_host(self) <= py_bint_to_host(other)

@define_behavior
def py_le_bintX_floatY(other: bint, self: float):
    return py_bool_from_host_bool(py_float_to_host(self) >= py_bint_to_host
        (other))

@define_behavior
def py_test_le_bintX_floatY(other: bint, self: float):
    return py_float_to_host(self) >= py_bint_to_host(other)

@define_behavior
def py_le_bintX_boolY(self: bint, other: bool):
    return py_bool_from_host_bool(py_bint_to_host(self) <=
        py_bool_to_host_int(other))

@define_behavior
def py_test_le_bintX_boolY(self: bint, other: bool):
    return py_bint_to_host(self) <= py_bool_to_host_int(other)

@define_behavior
def py_le_bintX_sintY(self: bint, other: sint):
    return py_bool_from_host_bool(py_bint_to_host(self) <= py_sint_to_host(
        other))

@define_behavior
def py_test_le_bintX_sintY(self: bint, other: sint):
    return py_bint_to_host(self) <= py_sint_to_host(other)

@define_behavior
def py_le_bintX_bintY(self: bint, other: bint):
    return py_bool_from_host_bool(py_bint_to_host(self) <= py_bint_to_host(
        other))

@define_behavior
def py_test_le_bintX_bintY(self: bint, other: bint):
    return py_bint_to_host(self) <= py_bint_to_host(other)

@define_behavior
def py_lt_floatX_floatY(self: float, other: float):
    return py_bool_from_host_bool(py_float_to_host(self) < py_float_to_host
        (other))

@define_behavior
def py_test_lt_floatX_floatY(self: float, other: float):
    return py_float_to_host(self) < py_float_to_host(other)

@define_behavior
def py_lt_floatX_boolY(self: float, other: bool):
    return py_bool_from_host_bool(py_float_to_host(self) <
        py_bool_to_host_int(other))

@define_behavior
def py_test_lt_floatX_boolY(self: float, other: bool):
    return py_float_to_host(self) < py_bool_to_host_int(other)

@define_behavior
def py_lt_floatX_sintY(self: float, other: sint):
    return py_bool_from_host_bool(py_float_to_host(self) < py_sint_to_host(
        other))

@define_behavior
def py_test_lt_floatX_sintY(self: float, other: sint):
    return py_float_to_host(self) < py_sint_to_host(other)

@define_behavior
def py_lt_floatX_bintY(self: float, other: bint):
    return py_bool_from_host_bool(py_float_to_host(self) < py_bint_to_host(
        other))

@define_behavior
def py_test_lt_floatX_bintY(self: float, other: bint):
    return py_float_to_host(self) < py_bint_to_host(other)

@define_behavior
def py_lt_boolX_floatY(other: bool, self: float):
    return py_bool_from_host_bool(py_float_to_host(self) >
        py_bool_to_host_int(other))

@define_behavior
def py_test_lt_boolX_floatY(other: bool, self: float):
    return py_float_to_host(self) > py_bool_to_host_int(other)

@define_behavior
def py_lt_boolX_boolY(self: bool, other: bool):
    return py_bool_from_host_bool(py_bool_to_host_int(self) <
        py_bool_to_host_int(other))

@define_behavior
def py_test_lt_boolX_boolY(self: bool, other: bool):
    return py_bool_to_host_int(self) < py_bool_to_host_int(other)

@define_behavior
def py_lt_boolX_sintY(self: bool, other: sint):
    return py_bool_from_host_bool(py_bool_to_host_int(self) <
        py_sint_to_host(other))

@define_behavior
def py_test_lt_boolX_sintY(self: bool, other: sint):
    return py_bool_to_host_int(self) < py_sint_to_host(other)

@define_behavior
def py_lt_boolX_bintY(self: bool, other: bint):
    return py_bool_from_host_bool(py_bool_to_host_int(self) <
        py_bint_to_host(other))

@define_behavior
def py_test_lt_boolX_bintY(self: bool, other: bint):
    return py_bool_to_host_int(self) < py_bint_to_host(other)

@define_behavior
def py_lt_sintX_floatY(other: sint, self: float):
    return py_bool_from_host_bool(py_float_to_host(self) > py_sint_to_host(
        other))

@define_behavior
def py_test_lt_sintX_floatY(other: sint, self: float):
    return py_float_to_host(self) > py_sint_to_host(other)

@define_behavior
def py_lt_sintX_boolY(self: sint, other: bool):
    return py_bool_from_host_bool(py_sint_to_host(self) <
        py_bool_to_host_int(other))

@define_behavior
def py_test_lt_sintX_boolY(self: sint, other: bool):
    return py_sint_to_host(self) < py_bool_to_host_int(other)

@define_behavior
def py_lt_sintX_sintY(self: sint, other: sint):
    return py_bool_from_host_bool(py_sint_to_host(self) < py_sint_to_host(
        other))

@define_behavior
def py_test_lt_sintX_sintY(self: sint, other: sint):
    return py_sint_to_host(self) < py_sint_to_host(other)

@define_behavior
def py_lt_sintX_bintY(self: sint, other: bint):
    return py_bool_from_host_bool(py_sint_to_host(self) < py_bint_to_host(
        other))

@define_behavior
def py_test_lt_sintX_bintY(self: sint, other: bint):
    return py_sint_to_host(self) < py_bint_to_host(other)

@define_behavior
def py_lt_bintX_floatY(other: bint, self: float):
    return py_bool_from_host_bool(py_float_to_host(self) > py_bint_to_host(
        other))

@define_behavior
def py_test_lt_bintX_floatY(other: bint, self: float):
    return py_float_to_host(self) > py_bint_to_host(other)

@define_behavior
def py_lt_bintX_boolY(self: bint, other: bool):
    return py_bool_from_host_bool(py_bint_to_host(self) <
        py_bool_to_host_int(other))

@define_behavior
def py_test_lt_bintX_boolY(self: bint, other: bool):
    return py_bint_to_host(self) < py_bool_to_host_int(other)

@define_behavior
def py_lt_bintX_sintY(self: bint, other: sint):
    return py_bool_from_host_bool(py_bint_to_host(self) < py_sint_to_host(
        other))

@define_behavior
def py_test_lt_bintX_sintY(self: bint, other: sint):
    return py_bint_to_host(self) < py_sint_to_host(other)

@define_behavior
def py_lt_bintX_bintY(self: bint, other: bint):
    return py_bool_from_host_bool(py_bint_to_host(self) < py_bint_to_host(
        other))

@define_behavior
def py_test_lt_bintX_bintY(self: bint, other: bint):
    return py_bint_to_host(self) < py_bint_to_host(other)

@define_behavior
def py_eq_floatX_floatY(self: float, other: float):
    return py_bool_from_host_bool(py_float_to_host(self) ==
        py_float_to_host(other))

@define_behavior
def py_test_eq_floatX_floatY(self: float, other: float):
    return py_float_to_host(self) == py_float_to_host(other)

@define_behavior
def py_eq_floatX_boolY(self: float, other: bool):
    return py_bool_from_host_bool(py_float_to_host(self) ==
        py_bool_to_host_int(other))

@define_behavior
def py_test_eq_floatX_boolY(self: float, other: bool):
    return py_float_to_host(self) == py_bool_to_host_int(other)

@define_behavior
def py_eq_floatX_sintY(self: float, other: sint):
    return py_bool_from_host_bool(py_float_to_host(self) == py_sint_to_host
        (other))

@define_behavior
def py_test_eq_floatX_sintY(self: float, other: sint):
    return py_float_to_host(self) == py_sint_to_host(other)

@define_behavior
def py_eq_floatX_bintY(self: float, other: bint):
    return py_bool_from_host_bool(py_float_to_host(self) == py_bint_to_host
        (other))

@define_behavior
def py_test_eq_floatX_bintY(self: float, other: bint):
    return py_float_to_host(self) == py_bint_to_host(other)

@define_behavior
def py_eq_boolX_floatY(other: bool, self: float):
    return py_bool_from_host_bool(py_float_to_host(self) ==
        py_bool_to_host_int(other))

@define_behavior
def py_test_eq_boolX_floatY(other: bool, self: float):
    return py_float_to_host(self) == py_bool_to_host_int(other)

@define_behavior
def py_eq_boolX_boolY(self: bool, other: bool):
    return py_bool_from_host_bool(py_bool_to_host_int(self) ==
        py_bool_to_host_int(other))

@define_behavior
def py_test_eq_boolX_boolY(self: bool, other: bool):
    return py_bool_to_host_int(self) == py_bool_to_host_int(other)

@define_behavior
def py_eq_boolX_sintY(self: bool, other: sint):
    return py_bool_from_host_bool(py_bool_to_host_int(self) ==
        py_sint_to_host(other))

@define_behavior
def py_test_eq_boolX_sintY(self: bool, other: sint):
    return py_bool_to_host_int(self) == py_sint_to_host(other)

@define_behavior
def py_eq_boolX_bintY(self: bool, other: bint):
    return py_bool_from_host_bool(py_bool_to_host_int(self) ==
        py_bint_to_host(other))

@define_behavior
def py_test_eq_boolX_bintY(self: bool, other: bint):
    return py_bool_to_host_int(self) == py_bint_to_host(other)

@define_behavior
def py_eq_sintX_floatY(other: sint, self: float):
    return py_bool_from_host_bool(py_float_to_host(self) == py_sint_to_host
        (other))

@define_behavior
def py_test_eq_sintX_floatY(other: sint, self: float):
    return py_float_to_host(self) == py_sint_to_host(other)

@define_behavior
def py_eq_sintX_boolY(self: sint, other: bool):
    return py_bool_from_host_bool(py_sint_to_host(self) ==
        py_bool_to_host_int(other))

@define_behavior
def py_test_eq_sintX_boolY(self: sint, other: bool):
    return py_sint_to_host(self) == py_bool_to_host_int(other)

@define_behavior
def py_eq_sintX_sintY(self: sint, other: sint):
    return py_bool_from_host_bool(py_sint_to_host(self) == py_sint_to_host(
        other))

@define_behavior
def py_test_eq_sintX_sintY(self: sint, other: sint):
    return py_sint_to_host(self) == py_sint_to_host(other)

@define_behavior
def py_eq_sintX_bintY(self: sint, other: bint):
    return py_bool_from_host_bool(py_sint_to_host(self) == py_bint_to_host(
        other))

@define_behavior
def py_test_eq_sintX_bintY(self: sint, other: bint):
    return py_sint_to_host(self) == py_bint_to_host(other)

@define_behavior
def py_eq_bintX_floatY(other: bint, self: float):
    return py_bool_from_host_bool(py_float_to_host(self) == py_bint_to_host
        (other))

@define_behavior
def py_test_eq_bintX_floatY(other: bint, self: float):
    return py_float_to_host(self) == py_bint_to_host(other)

@define_behavior
def py_eq_bintX_boolY(self: bint, other: bool):
    return py_bool_from_host_bool(py_bint_to_host(self) ==
        py_bool_to_host_int(other))

@define_behavior
def py_test_eq_bintX_boolY(self: bint, other: bool):
    return py_bint_to_host(self) == py_bool_to_host_int(other)

@define_behavior
def py_eq_bintX_sintY(self: bint, other: sint):
    return py_bool_from_host_bool(py_bint_to_host(self) == py_sint_to_host(
        other))

@define_behavior
def py_test_eq_bintX_sintY(self: bint, other: sint):
    return py_bint_to_host(self) == py_sint_to_host(other)

@define_behavior
def py_eq_bintX_bintY(self: bint, other: bint):
    return py_bool_from_host_bool(py_bint_to_host(self) == py_bint_to_host(
        other))

@define_behavior
def py_test_eq_bintX_bintY(self: bint, other: bint):
    return py_bint_to_host(self) == py_bint_to_host(other)

@define_behavior
def py_ne_floatX_floatY(self: float, other: float):
    return py_bool_from_host_bool(py_float_to_host(self) !=
        py_float_to_host(other))

@define_behavior
def py_test_ne_floatX_floatY(self: float, other: float):
    return py_float_to_host(self) != py_float_to_host(other)

@define_behavior
def py_ne_floatX_boolY(self: float, other: bool):
    return py_bool_from_host_bool(py_float_to_host(self) !=
        py_bool_to_host_int(other))

@define_behavior
def py_test_ne_floatX_boolY(self: float, other: bool):
    return py_float_to_host(self) != py_bool_to_host_int(other)

@define_behavior
def py_ne_floatX_sintY(self: float, other: sint):
    return py_bool_from_host_bool(py_float_to_host(self) != py_sint_to_host
        (other))

@define_behavior
def py_test_ne_floatX_sintY(self: float, other: sint):
    return py_float_to_host(self) != py_sint_to_host(other)

@define_behavior
def py_ne_floatX_bintY(self: float, other: bint):
    return py_bool_from_host_bool(py_float_to_host(self) != py_bint_to_host
        (other))

@define_behavior
def py_test_ne_floatX_bintY(self: float, other: bint):
    return py_float_to_host(self) != py_bint_to_host(other)

@define_behavior
def py_ne_boolX_floatY(other: bool, self: float):
    return py_bool_from_host_bool(py_float_to_host(self) !=
        py_bool_to_host_int(other))

@define_behavior
def py_test_ne_boolX_floatY(other: bool, self: float):
    return py_float_to_host(self) != py_bool_to_host_int(other)

@define_behavior
def py_ne_boolX_boolY(self: bool, other: bool):
    return py_bool_from_host_bool(py_bool_to_host_int(self) !=
        py_bool_to_host_int(other))

@define_behavior
def py_test_ne_boolX_boolY(self: bool, other: bool):
    return py_bool_to_host_int(self) != py_bool_to_host_int(other)

@define_behavior
def py_ne_boolX_sintY(self: bool, other: sint):
    return py_bool_from_host_bool(py_bool_to_host_int(self) !=
        py_sint_to_host(other))

@define_behavior
def py_test_ne_boolX_sintY(self: bool, other: sint):
    return py_bool_to_host_int(self) != py_sint_to_host(other)

@define_behavior
def py_ne_boolX_bintY(self: bool, other: bint):
    return py_bool_from_host_bool(py_bool_to_host_int(self) !=
        py_bint_to_host(other))

@define_behavior
def py_test_ne_boolX_bintY(self: bool, other: bint):
    return py_bool_to_host_int(self) != py_bint_to_host(other)

@define_behavior
def py_ne_sintX_floatY(other: sint, self: float):
    return py_bool_from_host_bool(py_float_to_host(self) != py_sint_to_host
        (other))

@define_behavior
def py_test_ne_sintX_floatY(other: sint, self: float):
    return py_float_to_host(self) != py_sint_to_host(other)

@define_behavior
def py_ne_sintX_boolY(self: sint, other: bool):
    return py_bool_from_host_bool(py_sint_to_host(self) !=
        py_bool_to_host_int(other))

@define_behavior
def py_test_ne_sintX_boolY(self: sint, other: bool):
    return py_sint_to_host(self) != py_bool_to_host_int(other)

@define_behavior
def py_ne_sintX_sintY(self: sint, other: sint):
    return py_bool_from_host_bool(py_sint_to_host(self) != py_sint_to_host(
        other))

@define_behavior
def py_test_ne_sintX_sintY(self: sint, other: sint):
    return py_sint_to_host(self) != py_sint_to_host(other)

@define_behavior
def py_ne_sintX_bintY(self: sint, other: bint):
    return py_bool_from_host_bool(py_sint_to_host(self) != py_bint_to_host(
        other))

@define_behavior
def py_test_ne_sintX_bintY(self: sint, other: bint):
    return py_sint_to_host(self) != py_bint_to_host(other)

@define_behavior
def py_ne_bintX_floatY(other: bint, self: float):
    return py_bool_from_host_bool(py_float_to_host(self) != py_bint_to_host
        (other))

@define_behavior
def py_test_ne_bintX_floatY(other: bint, self: float):
    return py_float_to_host(self) != py_bint_to_host(other)

@define_behavior
def py_ne_bintX_boolY(self: bint, other: bool):
    return py_bool_from_host_bool(py_bint_to_host(self) !=
        py_bool_to_host_int(other))

@define_behavior
def py_test_ne_bintX_boolY(self: bint, other: bool):
    return py_bint_to_host(self) != py_bool_to_host_int(other)

@define_behavior
def py_ne_bintX_sintY(self: bint, other: sint):
    return py_bool_from_host_bool(py_bint_to_host(self) != py_sint_to_host(
        other))

@define_behavior
def py_test_ne_bintX_sintY(self: bint, other: sint):
    return py_bint_to_host(self) != py_sint_to_host(other)

@define_behavior
def py_ne_bintX_bintY(self: bint, other: bint):
    return py_bool_from_host_bool(py_bint_to_host(self) != py_bint_to_host(
        other))

@define_behavior
def py_test_ne_bintX_bintY(self: bint, other: bint):
    return py_bint_to_host(self) != py_bint_to_host(other)

