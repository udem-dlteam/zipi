from __compiler_intrinsics__ import define_behavior, int_box, int_unbox, float_box, float_unbox, int_subtype_unbox, sint_unbox, bint_unbox

@define_behavior
def py_add_intX_intY(self: int, other: int):
    return int_box(int_unbox(self) + int_unbox(other))

@define_behavior
def py_add_intX_floatY(self: int, other: float):
    return float_box(int_unbox(other) + float_unbox(self))

@define_behavior
def py_add_intX_boolY(self: int, other: bool):
    return int_box(int_unbox(self) + int_subtype_unbox(other))

@define_behavior
def py_add_intX_sintY(self: int, other: sint):
    return int_box(int_unbox(self) + sint_unbox(other))

@define_behavior
def py_add_intX_bintY(self: int, other: bint):
    return int_box(int_unbox(self) + bint_unbox(other))

@define_behavior
def py_add_floatX_intY(self: float, other: int):
    return float_box(float_unbox(self) + int_unbox(other))

@define_behavior
def py_add_floatX_floatY(self: float, other: float):
    return float_box(float_unbox(self) + float_unbox(other))

@define_behavior
def py_add_floatX_boolY(self: float, other: bool):
    return float_box(float_unbox(self) + int_subtype_unbox(other))

@define_behavior
def py_add_floatX_sintY(self: float, other: sint):
    return float_box(float_unbox(self) + sint_unbox(other))

@define_behavior
def py_add_floatX_bintY(self: float, other: bint):
    return float_box(float_unbox(self) + bint_unbox(other))

@define_behavior
def py_add_boolX_intY(self: bool, other: int):
    return int_box(int_subtype_unbox(self) + int_unbox(other))

@define_behavior
def py_add_boolX_floatY(self: bool, other: float):
    return float_box(int_subtype_unbox(other) + float_unbox(self))

@define_behavior
def py_add_boolX_boolY(self: bool, other: bool):
    return int_box(int_subtype_unbox(self) + int_subtype_unbox(other))

@define_behavior
def py_add_boolX_sintY(self: bool, other: sint):
    return int_box(int_subtype_unbox(self) + sint_unbox(other))

@define_behavior
def py_add_boolX_bintY(self: bool, other: bint):
    return int_box(int_subtype_unbox(self) + bint_unbox(other))

@define_behavior
def py_add_sintX_intY(self: sint, other: int):
    return int_box(sint_unbox(self) + int_unbox(other))

@define_behavior
def py_add_sintX_floatY(self: sint, other: float):
    return float_box(sint_unbox(other) + float_unbox(self))

@define_behavior
def py_add_sintX_boolY(self: sint, other: bool):
    return int_box(sint_unbox(self) + int_subtype_unbox(other))

@define_behavior
def py_add_sintX_sintY(self: sint, other: sint):
    return int_box(sint_unbox(self) + sint_unbox(other))

@define_behavior
def py_add_sintX_bintY(self: sint, other: bint):
    return int_box(sint_unbox(self) + bint_unbox(other))

@define_behavior
def py_add_bintX_intY(self: bint, other: int):
    return int_box(bint_unbox(self) + int_unbox(other))

@define_behavior
def py_add_bintX_floatY(self: bint, other: float):
    return float_box(bint_unbox(other) + float_unbox(self))

@define_behavior
def py_add_bintX_boolY(self: bint, other: bool):
    return int_box(bint_unbox(self) + int_subtype_unbox(other))

@define_behavior
def py_add_bintX_sintY(self: bint, other: sint):
    return int_box(bint_unbox(self) + sint_unbox(other))

@define_behavior
def py_add_bintX_bintY(self: bint, other: bint):
    return int_box(bint_unbox(self) + bint_unbox(other))

@define_behavior
def py_bitand_intX_intY(self: int, other: int):
    return int_box(int_unbox(self) & int_unbox(other))

@define_behavior
def py_bitand_intX_floatY(self: int, other: float):
    raise TypeError("unsupported operand type(s) for &: 'int' and 'float'")

@define_behavior
def py_bitand_intX_boolY(self: int, other: bool):
    return int_box(int_unbox(self) & int_subtype_unbox(other))

@define_behavior
def py_bitand_intX_sintY(self: int, other: sint):
    return int_box(int_unbox(self) & sint_unbox(other))

@define_behavior
def py_bitand_intX_bintY(self: int, other: bint):
    return int_box(int_unbox(self) & bint_unbox(other))

@define_behavior
def py_bitand_floatX_intY(self: float, other: int):
    raise TypeError("unsupported operand type(s) for &: 'float' and 'int'")

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
def py_bitand_boolX_intY(self: bool, other: int):
    return int_box(int_subtype_unbox(self) & int_unbox(other))

@define_behavior
def py_bitand_boolX_floatY(self: bool, other: float):
    raise TypeError("unsupported operand type(s) for &: 'bool' and 'float'")

@define_behavior
def py_bitand_boolX_boolY(self: bool, other: bool):
    return self and other

@define_behavior
def py_bitand_boolX_sintY(self: bool, other: sint):
    return int_box(int_subtype_unbox(self) & sint_unbox(other))

@define_behavior
def py_bitand_boolX_bintY(self: bool, other: bint):
    return int_box(int_subtype_unbox(self) & bint_unbox(other))

@define_behavior
def py_bitand_sintX_intY(self: sint, other: int):
    return int_box(sint_unbox(self) & int_unbox(other))

@define_behavior
def py_bitand_sintX_floatY(self: sint, other: float):
    raise TypeError("unsupported operand type(s) for &: 'int' and 'float'")

@define_behavior
def py_bitand_sintX_boolY(self: sint, other: bool):
    return int_box(sint_unbox(self) & int_subtype_unbox(other))

@define_behavior
def py_bitand_sintX_sintY(self: sint, other: sint):
    return int_box(sint_unbox(self) & sint_unbox(other))

@define_behavior
def py_bitand_sintX_bintY(self: sint, other: bint):
    return int_box(sint_unbox(self) & bint_unbox(other))

@define_behavior
def py_bitand_bintX_intY(self: bint, other: int):
    return int_box(bint_unbox(self) & int_unbox(other))

@define_behavior
def py_bitand_bintX_floatY(self: bint, other: float):
    raise TypeError("unsupported operand type(s) for &: 'int' and 'float'")

@define_behavior
def py_bitand_bintX_boolY(self: bint, other: bool):
    return int_box(bint_unbox(self) & int_subtype_unbox(other))

@define_behavior
def py_bitand_bintX_sintY(self: bint, other: sint):
    return int_box(bint_unbox(self) & sint_unbox(other))

@define_behavior
def py_bitand_bintX_bintY(self: bint, other: bint):
    return int_box(bint_unbox(self) & bint_unbox(other))

@define_behavior
def py_bitor_intX_intY(self: int, other: int):
    return int_box(int_unbox(self) | int_unbox(other))

@define_behavior
def py_bitor_intX_floatY(self: int, other: float):
    raise TypeError("unsupported operand type(s) for |: 'int' and 'float'")

@define_behavior
def py_bitor_intX_boolY(self: int, other: bool):
    return int_box(int_unbox(self) | int_subtype_unbox(other))

@define_behavior
def py_bitor_intX_sintY(self: int, other: sint):
    return int_box(int_unbox(self) | sint_unbox(other))

@define_behavior
def py_bitor_intX_bintY(self: int, other: bint):
    return int_box(int_unbox(self) | bint_unbox(other))

@define_behavior
def py_bitor_floatX_intY(self: float, other: int):
    raise TypeError("unsupported operand type(s) for |: 'float' and 'int'")

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
def py_bitor_boolX_intY(self: bool, other: int):
    return int_box(int_subtype_unbox(self) | int_unbox(other))

@define_behavior
def py_bitor_boolX_floatY(self: bool, other: float):
    raise TypeError("unsupported operand type(s) for |: 'bool' and 'float'")

@define_behavior
def py_bitor_boolX_boolY(self: bool, other: bool):
    return self or other

@define_behavior
def py_bitor_boolX_sintY(self: bool, other: sint):
    return int_box(int_subtype_unbox(self) | sint_unbox(other))

@define_behavior
def py_bitor_boolX_bintY(self: bool, other: bint):
    return int_box(int_subtype_unbox(self) | bint_unbox(other))

@define_behavior
def py_bitor_sintX_intY(self: sint, other: int):
    return int_box(sint_unbox(self) | int_unbox(other))

@define_behavior
def py_bitor_sintX_floatY(self: sint, other: float):
    raise TypeError("unsupported operand type(s) for |: 'int' and 'float'")

@define_behavior
def py_bitor_sintX_boolY(self: sint, other: bool):
    return int_box(sint_unbox(self) | int_subtype_unbox(other))

@define_behavior
def py_bitor_sintX_sintY(self: sint, other: sint):
    return int_box(sint_unbox(self) | sint_unbox(other))

@define_behavior
def py_bitor_sintX_bintY(self: sint, other: bint):
    return int_box(sint_unbox(self) | bint_unbox(other))

@define_behavior
def py_bitor_bintX_intY(self: bint, other: int):
    return int_box(bint_unbox(self) | int_unbox(other))

@define_behavior
def py_bitor_bintX_floatY(self: bint, other: float):
    raise TypeError("unsupported operand type(s) for |: 'int' and 'float'")

@define_behavior
def py_bitor_bintX_boolY(self: bint, other: bool):
    return int_box(bint_unbox(self) | int_subtype_unbox(other))

@define_behavior
def py_bitor_bintX_sintY(self: bint, other: sint):
    return int_box(bint_unbox(self) | sint_unbox(other))

@define_behavior
def py_bitor_bintX_bintY(self: bint, other: bint):
    return int_box(bint_unbox(self) | bint_unbox(other))

@define_behavior
def py_floordiv_intX_intY(self: int, other: int):
    if other != 0:
        return int_box(int_unbox(self) // int_unbox(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_floordiv_intX_floatY(self: int, other: float):
    if self != 0.0:
        return float_box(int_unbox(other) // float_unbox(self))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_floordiv_intX_boolY(self: int, other: bool):
    if other != 0:
        return int_box(int_unbox(self) // int_subtype_unbox(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_floordiv_intX_sintY(self: int, other: sint):
    if other != 0:
        return int_box(int_unbox(self) // sint_unbox(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_floordiv_intX_bintY(self: int, other: bint):
    if other != 0:
        return int_box(int_unbox(self) // bint_unbox(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_floordiv_floatX_intY(self: float, other: int):
    if other != 0:
        return float_box(float_unbox(self) // int_unbox(other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_floordiv_floatX_floatY(self: float, other: float):
    if other != 0.0:
        return float_box(float_unbox(self) // float_unbox(other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_floordiv_floatX_boolY(self: float, other: bool):
    if other != 0:
        return float_box(float_unbox(self) // int_subtype_unbox(other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_floordiv_floatX_sintY(self: float, other: sint):
    if other != 0:
        return float_box(float_unbox(self) // sint_unbox(other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_floordiv_floatX_bintY(self: float, other: bint):
    if other != 0:
        return float_box(float_unbox(self) // bint_unbox(other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_floordiv_boolX_intY(self: bool, other: int):
    if other != 0:
        return int_box(int_subtype_unbox(self) // int_unbox(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_floordiv_boolX_floatY(self: bool, other: float):
    if self != 0.0:
        return float_box(int_subtype_unbox(other) // float_unbox(self))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_floordiv_boolX_boolY(self: bool, other: bool):
    if other != 0:
        return int_box(int_subtype_unbox(self) // int_subtype_unbox(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_floordiv_boolX_sintY(self: bool, other: sint):
    if other != 0:
        return int_box(int_subtype_unbox(self) // sint_unbox(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_floordiv_boolX_bintY(self: bool, other: bint):
    if other != 0:
        return int_box(int_subtype_unbox(self) // bint_unbox(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_floordiv_sintX_intY(self: sint, other: int):
    if other != 0:
        return int_box(sint_unbox(self) // int_unbox(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_floordiv_sintX_floatY(self: sint, other: float):
    if self != 0.0:
        return float_box(sint_unbox(other) // float_unbox(self))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_floordiv_sintX_boolY(self: sint, other: bool):
    if other != 0:
        return int_box(sint_unbox(self) // int_subtype_unbox(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_floordiv_sintX_sintY(self: sint, other: sint):
    if other != 0:
        return int_box(sint_unbox(self) // sint_unbox(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_floordiv_sintX_bintY(self: sint, other: bint):
    if other != 0:
        return int_box(sint_unbox(self) // bint_unbox(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_floordiv_bintX_intY(self: bint, other: int):
    if other != 0:
        return int_box(bint_unbox(self) // int_unbox(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_floordiv_bintX_floatY(self: bint, other: float):
    if self != 0.0:
        return float_box(bint_unbox(other) // float_unbox(self))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_floordiv_bintX_boolY(self: bint, other: bool):
    if other != 0:
        return int_box(bint_unbox(self) // int_subtype_unbox(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_floordiv_bintX_sintY(self: bint, other: sint):
    if other != 0:
        return int_box(bint_unbox(self) // sint_unbox(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_floordiv_bintX_bintY(self: bint, other: bint):
    if other != 0:
        return int_box(bint_unbox(self) // bint_unbox(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_lshift_intX_intY(self: int, other: int):
    return int_box(int_unbox(self) << int_unbox(other))

@define_behavior
def py_lshift_intX_floatY(self: int, other: float):
    raise TypeError("unsupported operand type(s) for <<: 'int' and 'float'")

@define_behavior
def py_lshift_intX_boolY(self: int, other: bool):
    return int_box(int_unbox(self) << int_subtype_unbox(other))

@define_behavior
def py_lshift_intX_sintY(self: int, other: sint):
    return int_box(int_unbox(self) << sint_unbox(other))

@define_behavior
def py_lshift_intX_bintY(self: int, other: bint):
    return int_box(int_unbox(self) << bint_unbox(other))

@define_behavior
def py_lshift_floatX_intY(self: float, other: int):
    raise TypeError("unsupported operand type(s) for <<: 'float' and 'int'")

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
def py_lshift_boolX_intY(self: bool, other: int):
    return int_box(int_subtype_unbox(self) << int_unbox(other))

@define_behavior
def py_lshift_boolX_floatY(self: bool, other: float):
    raise TypeError("unsupported operand type(s) for <<: 'bool' and 'float'")

@define_behavior
def py_lshift_boolX_boolY(self: bool, other: bool):
    return int_box(int_subtype_unbox(self) << int_subtype_unbox(other))

@define_behavior
def py_lshift_boolX_sintY(self: bool, other: sint):
    return int_box(int_subtype_unbox(self) << sint_unbox(other))

@define_behavior
def py_lshift_boolX_bintY(self: bool, other: bint):
    return int_box(int_subtype_unbox(self) << bint_unbox(other))

@define_behavior
def py_lshift_sintX_intY(self: sint, other: int):
    return int_box(sint_unbox(self) << int_unbox(other))

@define_behavior
def py_lshift_sintX_floatY(self: sint, other: float):
    raise TypeError("unsupported operand type(s) for <<: 'int' and 'float'")

@define_behavior
def py_lshift_sintX_boolY(self: sint, other: bool):
    return int_box(sint_unbox(self) << int_subtype_unbox(other))

@define_behavior
def py_lshift_sintX_sintY(self: sint, other: sint):
    return int_box(sint_unbox(self) << sint_unbox(other))

@define_behavior
def py_lshift_sintX_bintY(self: sint, other: bint):
    return int_box(sint_unbox(self) << bint_unbox(other))

@define_behavior
def py_lshift_bintX_intY(self: bint, other: int):
    return int_box(bint_unbox(self) << int_unbox(other))

@define_behavior
def py_lshift_bintX_floatY(self: bint, other: float):
    raise TypeError("unsupported operand type(s) for <<: 'int' and 'float'")

@define_behavior
def py_lshift_bintX_boolY(self: bint, other: bool):
    return int_box(bint_unbox(self) << int_subtype_unbox(other))

@define_behavior
def py_lshift_bintX_sintY(self: bint, other: sint):
    return int_box(bint_unbox(self) << sint_unbox(other))

@define_behavior
def py_lshift_bintX_bintY(self: bint, other: bint):
    return int_box(bint_unbox(self) << bint_unbox(other))

@define_behavior
def py_matmul_intX_intY(self: int, other: int):
    raise TypeError("unsupported operand type(s) for @: 'int' and 'int'")

@define_behavior
def py_matmul_intX_floatY(self: int, other: float):
    raise TypeError("unsupported operand type(s) for @: 'int' and 'float'")

@define_behavior
def py_matmul_intX_boolY(self: int, other: bool):
    raise TypeError("unsupported operand type(s) for @: 'int' and 'bool'")

@define_behavior
def py_matmul_intX_sintY(self: int, other: sint):
    raise TypeError("unsupported operand type(s) for @: 'int' and 'int'")

@define_behavior
def py_matmul_intX_bintY(self: int, other: bint):
    raise TypeError("unsupported operand type(s) for @: 'int' and 'int'")

@define_behavior
def py_matmul_floatX_intY(self: float, other: int):
    raise TypeError("unsupported operand type(s) for @: 'float' and 'int'")

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
def py_matmul_boolX_intY(self: bool, other: int):
    raise TypeError("unsupported operand type(s) for @: 'bool' and 'int'")

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
def py_matmul_sintX_intY(self: sint, other: int):
    raise TypeError("unsupported operand type(s) for @: 'int' and 'int'")

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
def py_matmul_bintX_intY(self: bint, other: int):
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
def py_mod_intX_intY(self: int, other: int):
    if other != 0:
        return int_box(int_unbox(self) % int_unbox(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_mod_intX_floatY(self: int, other: float):
    if self != 0.0:
        return float_box(int_unbox(other) % float_unbox(self))
    else:
        raise ZeroDivisionError('float modulo by zero')

@define_behavior
def py_mod_intX_boolY(self: int, other: bool):
    if other != 0:
        return int_box(int_unbox(self) % int_subtype_unbox(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_mod_intX_sintY(self: int, other: sint):
    if other != 0:
        return int_box(int_unbox(self) % sint_unbox(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_mod_intX_bintY(self: int, other: bint):
    if other != 0:
        return int_box(int_unbox(self) % bint_unbox(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_mod_floatX_intY(self: float, other: int):
    if other != 0:
        return float_box(float_unbox(self) % int_unbox(other))
    else:
        raise ZeroDivisionError('float modulo by zero')

@define_behavior
def py_mod_floatX_floatY(self: float, other: float):
    if other != 0.0:
        return float_box(float_unbox(self) % float_unbox(other))
    else:
        raise ZeroDivisionError('float modulo by zero')

@define_behavior
def py_mod_floatX_boolY(self: float, other: bool):
    if other != 0:
        return float_box(float_unbox(self) % int_subtype_unbox(other))
    else:
        raise ZeroDivisionError('float modulo by zero')

@define_behavior
def py_mod_floatX_sintY(self: float, other: sint):
    if other != 0:
        return float_box(float_unbox(self) % sint_unbox(other))
    else:
        raise ZeroDivisionError('float modulo by zero')

@define_behavior
def py_mod_floatX_bintY(self: float, other: bint):
    if other != 0:
        return float_box(float_unbox(self) % bint_unbox(other))
    else:
        raise ZeroDivisionError('float modulo by zero')

@define_behavior
def py_mod_boolX_intY(self: bool, other: int):
    if other != 0:
        return int_box(int_subtype_unbox(self) % int_unbox(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_mod_boolX_floatY(self: bool, other: float):
    if self != 0.0:
        return float_box(int_subtype_unbox(other) % float_unbox(self))
    else:
        raise ZeroDivisionError('float modulo by zero')

@define_behavior
def py_mod_boolX_boolY(self: bool, other: bool):
    if other != 0:
        return int_box(int_subtype_unbox(self) % int_subtype_unbox(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_mod_boolX_sintY(self: bool, other: sint):
    if other != 0:
        return int_box(int_subtype_unbox(self) % sint_unbox(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_mod_boolX_bintY(self: bool, other: bint):
    if other != 0:
        return int_box(int_subtype_unbox(self) % bint_unbox(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_mod_sintX_intY(self: sint, other: int):
    if other != 0:
        return int_box(sint_unbox(self) % int_unbox(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_mod_sintX_floatY(self: sint, other: float):
    if self != 0.0:
        return float_box(sint_unbox(other) % float_unbox(self))
    else:
        raise ZeroDivisionError('float modulo by zero')

@define_behavior
def py_mod_sintX_boolY(self: sint, other: bool):
    if other != 0:
        return int_box(sint_unbox(self) % int_subtype_unbox(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_mod_sintX_sintY(self: sint, other: sint):
    if other != 0:
        return int_box(sint_unbox(self) % sint_unbox(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_mod_sintX_bintY(self: sint, other: bint):
    if other != 0:
        return int_box(sint_unbox(self) % bint_unbox(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_mod_bintX_intY(self: bint, other: int):
    if other != 0:
        return int_box(bint_unbox(self) % int_unbox(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_mod_bintX_floatY(self: bint, other: float):
    if self != 0.0:
        return float_box(bint_unbox(other) % float_unbox(self))
    else:
        raise ZeroDivisionError('float modulo by zero')

@define_behavior
def py_mod_bintX_boolY(self: bint, other: bool):
    if other != 0:
        return int_box(bint_unbox(self) % int_subtype_unbox(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_mod_bintX_sintY(self: bint, other: sint):
    if other != 0:
        return int_box(bint_unbox(self) % sint_unbox(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_mod_bintX_bintY(self: bint, other: bint):
    if other != 0:
        return int_box(bint_unbox(self) % bint_unbox(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_mul_intX_intY(self: int, other: int):
    return int_box(int_unbox(self) * int_unbox(other))

@define_behavior
def py_mul_intX_floatY(self: int, other: float):
    return float_box(int_unbox(other) * float_unbox(self))

@define_behavior
def py_mul_intX_boolY(self: int, other: bool):
    return int_box(int_unbox(self) * int_subtype_unbox(other))

@define_behavior
def py_mul_intX_sintY(self: int, other: sint):
    return int_box(int_unbox(self) * sint_unbox(other))

@define_behavior
def py_mul_intX_bintY(self: int, other: bint):
    return int_box(int_unbox(self) * bint_unbox(other))

@define_behavior
def py_mul_floatX_intY(self: float, other: int):
    return float_box(float_unbox(self) * int_unbox(other))

@define_behavior
def py_mul_floatX_floatY(self: float, other: float):
    return float_box(float_unbox(self) * float_unbox(other))

@define_behavior
def py_mul_floatX_boolY(self: float, other: bool):
    return float_box(float_unbox(self) * int_subtype_unbox(other))

@define_behavior
def py_mul_floatX_sintY(self: float, other: sint):
    return float_box(float_unbox(self) * sint_unbox(other))

@define_behavior
def py_mul_floatX_bintY(self: float, other: bint):
    return float_box(float_unbox(self) * bint_unbox(other))

@define_behavior
def py_mul_boolX_intY(self: bool, other: int):
    return int_box(int_subtype_unbox(self) * int_unbox(other))

@define_behavior
def py_mul_boolX_floatY(self: bool, other: float):
    return float_box(int_subtype_unbox(other) * float_unbox(self))

@define_behavior
def py_mul_boolX_boolY(self: bool, other: bool):
    return int_box(int_subtype_unbox(self) * int_subtype_unbox(other))

@define_behavior
def py_mul_boolX_sintY(self: bool, other: sint):
    return int_box(int_subtype_unbox(self) * sint_unbox(other))

@define_behavior
def py_mul_boolX_bintY(self: bool, other: bint):
    return int_box(int_subtype_unbox(self) * bint_unbox(other))

@define_behavior
def py_mul_sintX_intY(self: sint, other: int):
    return int_box(sint_unbox(self) * int_unbox(other))

@define_behavior
def py_mul_sintX_floatY(self: sint, other: float):
    return float_box(sint_unbox(other) * float_unbox(self))

@define_behavior
def py_mul_sintX_boolY(self: sint, other: bool):
    return int_box(sint_unbox(self) * int_subtype_unbox(other))

@define_behavior
def py_mul_sintX_sintY(self: sint, other: sint):
    return int_box(sint_unbox(self) * sint_unbox(other))

@define_behavior
def py_mul_sintX_bintY(self: sint, other: bint):
    return int_box(sint_unbox(self) * bint_unbox(other))

@define_behavior
def py_mul_bintX_intY(self: bint, other: int):
    return int_box(bint_unbox(self) * int_unbox(other))

@define_behavior
def py_mul_bintX_floatY(self: bint, other: float):
    return float_box(bint_unbox(other) * float_unbox(self))

@define_behavior
def py_mul_bintX_boolY(self: bint, other: bool):
    return int_box(bint_unbox(self) * int_subtype_unbox(other))

@define_behavior
def py_mul_bintX_sintY(self: bint, other: sint):
    return int_box(bint_unbox(self) * sint_unbox(other))

@define_behavior
def py_mul_bintX_bintY(self: bint, other: bint):
    return int_box(bint_unbox(self) * bint_unbox(other))

@define_behavior
def py_pow_intX_intY(self: int, other: int):
    return int_box(int_unbox(self) ** int_unbox(other))

@define_behavior
def py_pow_intX_floatY(self: int, other: float):
    return float_box(int_unbox(other) ** float_unbox(self))

@define_behavior
def py_pow_intX_boolY(self: int, other: bool):
    return int_box(int_unbox(self) ** int_subtype_unbox(other))

@define_behavior
def py_pow_intX_sintY(self: int, other: sint):
    return int_box(int_unbox(self) ** sint_unbox(other))

@define_behavior
def py_pow_intX_bintY(self: int, other: bint):
    return int_box(int_unbox(self) ** bint_unbox(other))

@define_behavior
def py_pow_floatX_intY(self: float, other: int):
    return float_box(float_unbox(self) ** int_unbox(other))

@define_behavior
def py_pow_floatX_floatY(self: float, other: float):
    return float_box(float_unbox(self) ** float_unbox(other))

@define_behavior
def py_pow_floatX_boolY(self: float, other: bool):
    return float_box(float_unbox(self) ** int_subtype_unbox(other))

@define_behavior
def py_pow_floatX_sintY(self: float, other: sint):
    return float_box(float_unbox(self) ** sint_unbox(other))

@define_behavior
def py_pow_floatX_bintY(self: float, other: bint):
    return float_box(float_unbox(self) ** bint_unbox(other))

@define_behavior
def py_pow_boolX_intY(self: bool, other: int):
    return int_box(int_subtype_unbox(self) ** int_unbox(other))

@define_behavior
def py_pow_boolX_floatY(self: bool, other: float):
    return float_box(int_subtype_unbox(other) ** float_unbox(self))

@define_behavior
def py_pow_boolX_boolY(self: bool, other: bool):
    return int_box(int_subtype_unbox(self) ** int_subtype_unbox(other))

@define_behavior
def py_pow_boolX_sintY(self: bool, other: sint):
    return int_box(int_subtype_unbox(self) ** sint_unbox(other))

@define_behavior
def py_pow_boolX_bintY(self: bool, other: bint):
    return int_box(int_subtype_unbox(self) ** bint_unbox(other))

@define_behavior
def py_pow_sintX_intY(self: sint, other: int):
    return int_box(sint_unbox(self) ** int_unbox(other))

@define_behavior
def py_pow_sintX_floatY(self: sint, other: float):
    return float_box(sint_unbox(other) ** float_unbox(self))

@define_behavior
def py_pow_sintX_boolY(self: sint, other: bool):
    return int_box(sint_unbox(self) ** int_subtype_unbox(other))

@define_behavior
def py_pow_sintX_sintY(self: sint, other: sint):
    return int_box(sint_unbox(self) ** sint_unbox(other))

@define_behavior
def py_pow_sintX_bintY(self: sint, other: bint):
    return int_box(sint_unbox(self) ** bint_unbox(other))

@define_behavior
def py_pow_bintX_intY(self: bint, other: int):
    return int_box(bint_unbox(self) ** int_unbox(other))

@define_behavior
def py_pow_bintX_floatY(self: bint, other: float):
    return float_box(bint_unbox(other) ** float_unbox(self))

@define_behavior
def py_pow_bintX_boolY(self: bint, other: bool):
    return int_box(bint_unbox(self) ** int_subtype_unbox(other))

@define_behavior
def py_pow_bintX_sintY(self: bint, other: sint):
    return int_box(bint_unbox(self) ** sint_unbox(other))

@define_behavior
def py_pow_bintX_bintY(self: bint, other: bint):
    return int_box(bint_unbox(self) ** bint_unbox(other))

@define_behavior
def py_rshift_intX_intY(self: int, other: int):
    return int_box(int_unbox(self) >> int_unbox(other))

@define_behavior
def py_rshift_intX_floatY(self: int, other: float):
    raise TypeError("unsupported operand type(s) for >>: 'int' and 'float'")

@define_behavior
def py_rshift_intX_boolY(self: int, other: bool):
    return int_box(int_subtype_unbox(self) >> int_unbox(other))

@define_behavior
def py_rshift_intX_sintY(self: int, other: sint):
    return int_box(sint_unbox(self) >> int_unbox(other))

@define_behavior
def py_rshift_intX_bintY(self: int, other: bint):
    return int_box(bint_unbox(self) >> int_unbox(other))

@define_behavior
def py_rshift_floatX_intY(self: float, other: int):
    raise TypeError("unsupported operand type(s) for >>: 'float' and 'int'")

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
def py_rshift_boolX_intY(self: bool, other: int):
    return int_box(int_unbox(self) >> int_subtype_unbox(other))

@define_behavior
def py_rshift_boolX_floatY(self: bool, other: float):
    raise TypeError("unsupported operand type(s) for >>: 'bool' and 'float'")

@define_behavior
def py_rshift_boolX_boolY(self: bool, other: bool):
    return int_box(int_subtype_unbox(self) >> int_subtype_unbox(other))

@define_behavior
def py_rshift_boolX_sintY(self: bool, other: sint):
    return int_box(sint_unbox(self) >> int_subtype_unbox(other))

@define_behavior
def py_rshift_boolX_bintY(self: bool, other: bint):
    return int_box(bint_unbox(self) >> int_subtype_unbox(other))

@define_behavior
def py_rshift_sintX_intY(self: sint, other: int):
    return int_box(int_unbox(self) >> sint_unbox(other))

@define_behavior
def py_rshift_sintX_floatY(self: sint, other: float):
    raise TypeError("unsupported operand type(s) for >>: 'int' and 'float'")

@define_behavior
def py_rshift_sintX_boolY(self: sint, other: bool):
    return int_box(int_subtype_unbox(self) >> sint_unbox(other))

@define_behavior
def py_rshift_sintX_sintY(self: sint, other: sint):
    return int_box(sint_unbox(self) >> sint_unbox(other))

@define_behavior
def py_rshift_sintX_bintY(self: sint, other: bint):
    return int_box(bint_unbox(self) >> sint_unbox(other))

@define_behavior
def py_rshift_bintX_intY(self: bint, other: int):
    return int_box(int_unbox(self) >> bint_unbox(other))

@define_behavior
def py_rshift_bintX_floatY(self: bint, other: float):
    raise TypeError("unsupported operand type(s) for >>: 'int' and 'float'")

@define_behavior
def py_rshift_bintX_boolY(self: bint, other: bool):
    return int_box(int_subtype_unbox(self) >> bint_unbox(other))

@define_behavior
def py_rshift_bintX_sintY(self: bint, other: sint):
    return int_box(sint_unbox(self) >> bint_unbox(other))

@define_behavior
def py_rshift_bintX_bintY(self: bint, other: bint):
    return int_box(bint_unbox(self) >> bint_unbox(other))

@define_behavior
def py_sub_intX_intY(self: int, other: int):
    return int_box(int_unbox(self) - int_unbox(other))

@define_behavior
def py_sub_intX_floatY(self: int, other: float):
    return float_box(int_unbox(other) - float_unbox(self))

@define_behavior
def py_sub_intX_boolY(self: int, other: bool):
    return int_box(int_unbox(self) - int_subtype_unbox(other))

@define_behavior
def py_sub_intX_sintY(self: int, other: sint):
    return int_box(int_unbox(self) - sint_unbox(other))

@define_behavior
def py_sub_intX_bintY(self: int, other: bint):
    return int_box(int_unbox(self) - bint_unbox(other))

@define_behavior
def py_sub_floatX_intY(self: float, other: int):
    return float_box(float_unbox(self) - int_unbox(other))

@define_behavior
def py_sub_floatX_floatY(self: float, other: float):
    return float_box(float_unbox(self) - float_unbox(other))

@define_behavior
def py_sub_floatX_boolY(self: float, other: bool):
    return float_box(float_unbox(self) - int_subtype_unbox(other))

@define_behavior
def py_sub_floatX_sintY(self: float, other: sint):
    return float_box(float_unbox(self) - sint_unbox(other))

@define_behavior
def py_sub_floatX_bintY(self: float, other: bint):
    return float_box(float_unbox(self) - bint_unbox(other))

@define_behavior
def py_sub_boolX_intY(self: bool, other: int):
    return int_box(int_subtype_unbox(self) - int_unbox(other))

@define_behavior
def py_sub_boolX_floatY(self: bool, other: float):
    return float_box(int_subtype_unbox(other) - float_unbox(self))

@define_behavior
def py_sub_boolX_boolY(self: bool, other: bool):
    return int_box(int_subtype_unbox(self) - int_subtype_unbox(other))

@define_behavior
def py_sub_boolX_sintY(self: bool, other: sint):
    return int_box(int_subtype_unbox(self) - sint_unbox(other))

@define_behavior
def py_sub_boolX_bintY(self: bool, other: bint):
    return int_box(int_subtype_unbox(self) - bint_unbox(other))

@define_behavior
def py_sub_sintX_intY(self: sint, other: int):
    return int_box(sint_unbox(self) - int_unbox(other))

@define_behavior
def py_sub_sintX_floatY(self: sint, other: float):
    return float_box(sint_unbox(other) - float_unbox(self))

@define_behavior
def py_sub_sintX_boolY(self: sint, other: bool):
    return int_box(sint_unbox(self) - int_subtype_unbox(other))

@define_behavior
def py_sub_sintX_sintY(self: sint, other: sint):
    return int_box(sint_unbox(self) - sint_unbox(other))

@define_behavior
def py_sub_sintX_bintY(self: sint, other: bint):
    return int_box(sint_unbox(self) - bint_unbox(other))

@define_behavior
def py_sub_bintX_intY(self: bint, other: int):
    return int_box(bint_unbox(self) - int_unbox(other))

@define_behavior
def py_sub_bintX_floatY(self: bint, other: float):
    return float_box(bint_unbox(other) - float_unbox(self))

@define_behavior
def py_sub_bintX_boolY(self: bint, other: bool):
    return int_box(bint_unbox(self) - int_subtype_unbox(other))

@define_behavior
def py_sub_bintX_sintY(self: bint, other: sint):
    return int_box(bint_unbox(self) - sint_unbox(other))

@define_behavior
def py_sub_bintX_bintY(self: bint, other: bint):
    return int_box(bint_unbox(self) - bint_unbox(other))

@define_behavior
def py_truediv_intX_intY(self: int, other: int):
    if other != 0:
        return int_box(int_unbox(self) / int_unbox(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_truediv_intX_floatY(self: int, other: float):
    if self != 0.0:
        return float_box(int_unbox(other) / float_unbox(self))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_truediv_intX_boolY(self: int, other: bool):
    if other != 0:
        return int_box(int_unbox(self) / int_subtype_unbox(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_truediv_intX_sintY(self: int, other: sint):
    if other != 0:
        return int_box(int_unbox(self) / sint_unbox(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_truediv_intX_bintY(self: int, other: bint):
    if other != 0:
        return int_box(int_unbox(self) / bint_unbox(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_truediv_floatX_intY(self: float, other: int):
    if other != 0:
        return float_box(float_unbox(self) / int_unbox(other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_truediv_floatX_floatY(self: float, other: float):
    if other != 0.0:
        return float_box(float_unbox(self) / float_unbox(other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_truediv_floatX_boolY(self: float, other: bool):
    if other != 0:
        return float_box(float_unbox(self) / int_subtype_unbox(other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_truediv_floatX_sintY(self: float, other: sint):
    if other != 0:
        return float_box(float_unbox(self) / sint_unbox(other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_truediv_floatX_bintY(self: float, other: bint):
    if other != 0:
        return float_box(float_unbox(self) / bint_unbox(other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_truediv_boolX_intY(self: bool, other: int):
    if other != 0:
        return int_box(int_subtype_unbox(self) / int_unbox(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_truediv_boolX_floatY(self: bool, other: float):
    if self != 0.0:
        return float_box(int_subtype_unbox(other) / float_unbox(self))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_truediv_boolX_boolY(self: bool, other: bool):
    if other != 0:
        return int_box(int_subtype_unbox(self) / int_subtype_unbox(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_truediv_boolX_sintY(self: bool, other: sint):
    if other != 0:
        return int_box(int_subtype_unbox(self) / sint_unbox(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_truediv_boolX_bintY(self: bool, other: bint):
    if other != 0:
        return int_box(int_subtype_unbox(self) / bint_unbox(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_truediv_sintX_intY(self: sint, other: int):
    if other != 0:
        return int_box(sint_unbox(self) / int_unbox(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_truediv_sintX_floatY(self: sint, other: float):
    if self != 0.0:
        return float_box(sint_unbox(other) / float_unbox(self))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_truediv_sintX_boolY(self: sint, other: bool):
    if other != 0:
        return int_box(sint_unbox(self) / int_subtype_unbox(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_truediv_sintX_sintY(self: sint, other: sint):
    if other != 0:
        return int_box(sint_unbox(self) / sint_unbox(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_truediv_sintX_bintY(self: sint, other: bint):
    if other != 0:
        return int_box(sint_unbox(self) / bint_unbox(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_truediv_bintX_intY(self: bint, other: int):
    if other != 0:
        return int_box(bint_unbox(self) / int_unbox(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_truediv_bintX_floatY(self: bint, other: float):
    if self != 0.0:
        return float_box(bint_unbox(other) / float_unbox(self))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_truediv_bintX_boolY(self: bint, other: bool):
    if other != 0:
        return int_box(bint_unbox(self) / int_subtype_unbox(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_truediv_bintX_sintY(self: bint, other: sint):
    if other != 0:
        return int_box(bint_unbox(self) / sint_unbox(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_truediv_bintX_bintY(self: bint, other: bint):
    if other != 0:
        return int_box(bint_unbox(self) / bint_unbox(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_xor_intX_intY(self: int, other: int):
    return int_box(int_unbox(self) ^ int_unbox(other))

@define_behavior
def py_xor_intX_floatY(self: int, other: float):
    raise TypeError("unsupported operand type(s) for ^: 'int' and 'float'")

@define_behavior
def py_xor_intX_boolY(self: int, other: bool):
    return int_box(int_unbox(self) ^ int_subtype_unbox(other))

@define_behavior
def py_xor_intX_sintY(self: int, other: sint):
    return int_box(int_unbox(self) ^ sint_unbox(other))

@define_behavior
def py_xor_intX_bintY(self: int, other: bint):
    return int_box(int_unbox(self) ^ bint_unbox(other))

@define_behavior
def py_xor_floatX_intY(self: float, other: int):
    raise TypeError("unsupported operand type(s) for ^: 'float' and 'int'")

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
def py_xor_boolX_intY(self: bool, other: int):
    return int_box(int_subtype_unbox(self) ^ int_unbox(other))

@define_behavior
def py_xor_boolX_floatY(self: bool, other: float):
    raise TypeError("unsupported operand type(s) for ^: 'bool' and 'float'")

@define_behavior
def py_xor_boolX_boolY(self: bool, other: bool):
    return self is not other

@define_behavior
def py_xor_boolX_sintY(self: bool, other: sint):
    return int_box(int_subtype_unbox(self) ^ sint_unbox(other))

@define_behavior
def py_xor_boolX_bintY(self: bool, other: bint):
    return int_box(int_subtype_unbox(self) ^ bint_unbox(other))

@define_behavior
def py_xor_sintX_intY(self: sint, other: int):
    return int_box(sint_unbox(self) ^ int_unbox(other))

@define_behavior
def py_xor_sintX_floatY(self: sint, other: float):
    raise TypeError("unsupported operand type(s) for ^: 'int' and 'float'")

@define_behavior
def py_xor_sintX_boolY(self: sint, other: bool):
    return int_box(sint_unbox(self) ^ int_subtype_unbox(other))

@define_behavior
def py_xor_sintX_sintY(self: sint, other: sint):
    return int_box(sint_unbox(self) ^ sint_unbox(other))

@define_behavior
def py_xor_sintX_bintY(self: sint, other: bint):
    return int_box(sint_unbox(self) ^ bint_unbox(other))

@define_behavior
def py_xor_bintX_intY(self: bint, other: int):
    return int_box(bint_unbox(self) ^ int_unbox(other))

@define_behavior
def py_xor_bintX_floatY(self: bint, other: float):
    raise TypeError("unsupported operand type(s) for ^: 'int' and 'float'")

@define_behavior
def py_xor_bintX_boolY(self: bint, other: bool):
    return int_box(bint_unbox(self) ^ int_subtype_unbox(other))

@define_behavior
def py_xor_bintX_sintY(self: bint, other: sint):
    return int_box(bint_unbox(self) ^ sint_unbox(other))

@define_behavior
def py_xor_bintX_bintY(self: bint, other: bint):
    return int_box(bint_unbox(self) ^ bint_unbox(other))

@define_behavior
def py_iadd_intX_intY(self: int, other: int):
    return int_box(int_unbox(self) + int_unbox(other))

@define_behavior
def py_iadd_intX_floatY(self: int, other: float):
    return float_box(int_unbox(other) + float_unbox(self))

@define_behavior
def py_iadd_intX_boolY(self: int, other: bool):
    return int_box(int_unbox(self) + int_subtype_unbox(other))

@define_behavior
def py_iadd_intX_sintY(self: int, other: sint):
    return int_box(int_unbox(self) + sint_unbox(other))

@define_behavior
def py_iadd_intX_bintY(self: int, other: bint):
    return int_box(int_unbox(self) + bint_unbox(other))

@define_behavior
def py_iadd_floatX_intY(self: float, other: int):
    return float_box(float_unbox(self) + int_unbox(other))

@define_behavior
def py_iadd_floatX_floatY(self: float, other: float):
    return float_box(float_unbox(self) + float_unbox(other))

@define_behavior
def py_iadd_floatX_boolY(self: float, other: bool):
    return float_box(float_unbox(self) + int_subtype_unbox(other))

@define_behavior
def py_iadd_floatX_sintY(self: float, other: sint):
    return float_box(float_unbox(self) + sint_unbox(other))

@define_behavior
def py_iadd_floatX_bintY(self: float, other: bint):
    return float_box(float_unbox(self) + bint_unbox(other))

@define_behavior
def py_iadd_boolX_intY(self: bool, other: int):
    return int_box(int_subtype_unbox(self) + int_unbox(other))

@define_behavior
def py_iadd_boolX_floatY(self: bool, other: float):
    return float_box(int_subtype_unbox(other) + float_unbox(self))

@define_behavior
def py_iadd_boolX_boolY(self: bool, other: bool):
    return int_box(int_subtype_unbox(self) + int_subtype_unbox(other))

@define_behavior
def py_iadd_boolX_sintY(self: bool, other: sint):
    return int_box(int_subtype_unbox(self) + sint_unbox(other))

@define_behavior
def py_iadd_boolX_bintY(self: bool, other: bint):
    return int_box(int_subtype_unbox(self) + bint_unbox(other))

@define_behavior
def py_iadd_sintX_intY(self: sint, other: int):
    return int_box(sint_unbox(self) + int_unbox(other))

@define_behavior
def py_iadd_sintX_floatY(self: sint, other: float):
    return float_box(sint_unbox(other) + float_unbox(self))

@define_behavior
def py_iadd_sintX_boolY(self: sint, other: bool):
    return int_box(sint_unbox(self) + int_subtype_unbox(other))

@define_behavior
def py_iadd_sintX_sintY(self: sint, other: sint):
    return int_box(sint_unbox(self) + sint_unbox(other))

@define_behavior
def py_iadd_sintX_bintY(self: sint, other: bint):
    return int_box(sint_unbox(self) + bint_unbox(other))

@define_behavior
def py_iadd_bintX_intY(self: bint, other: int):
    return int_box(bint_unbox(self) + int_unbox(other))

@define_behavior
def py_iadd_bintX_floatY(self: bint, other: float):
    return float_box(bint_unbox(other) + float_unbox(self))

@define_behavior
def py_iadd_bintX_boolY(self: bint, other: bool):
    return int_box(bint_unbox(self) + int_subtype_unbox(other))

@define_behavior
def py_iadd_bintX_sintY(self: bint, other: sint):
    return int_box(bint_unbox(self) + sint_unbox(other))

@define_behavior
def py_iadd_bintX_bintY(self: bint, other: bint):
    return int_box(bint_unbox(self) + bint_unbox(other))

@define_behavior
def py_ibitand_intX_intY(self: int, other: int):
    return int_box(int_unbox(self) & int_unbox(other))

@define_behavior
def py_ibitand_intX_floatY(self: int, other: float):
    raise TypeError("unsupported operand type(s) for &: 'int' and 'float'")

@define_behavior
def py_ibitand_intX_boolY(self: int, other: bool):
    return int_box(int_unbox(self) & int_subtype_unbox(other))

@define_behavior
def py_ibitand_intX_sintY(self: int, other: sint):
    return int_box(int_unbox(self) & sint_unbox(other))

@define_behavior
def py_ibitand_intX_bintY(self: int, other: bint):
    return int_box(int_unbox(self) & bint_unbox(other))

@define_behavior
def py_ibitand_floatX_intY(self: float, other: int):
    raise TypeError("unsupported operand type(s) for &: 'float' and 'int'")

@define_behavior
def py_ibitand_floatX_floatY(self: float, other: float):
    raise TypeError("unsupported operand type(s) for &: 'float' and 'float'")

@define_behavior
def py_ibitand_floatX_boolY(self: float, other: bool):
    raise TypeError("unsupported operand type(s) for &: 'float' and 'bool'")

@define_behavior
def py_ibitand_floatX_sintY(self: float, other: sint):
    raise TypeError("unsupported operand type(s) for &: 'float' and 'int'")

@define_behavior
def py_ibitand_floatX_bintY(self: float, other: bint):
    raise TypeError("unsupported operand type(s) for &: 'float' and 'int'")

@define_behavior
def py_ibitand_boolX_intY(self: bool, other: int):
    return int_box(int_subtype_unbox(self) & int_unbox(other))

@define_behavior
def py_ibitand_boolX_floatY(self: bool, other: float):
    raise TypeError("unsupported operand type(s) for &: 'bool' and 'float'")

@define_behavior
def py_ibitand_boolX_boolY(self: bool, other: bool):
    return self and other

@define_behavior
def py_ibitand_boolX_sintY(self: bool, other: sint):
    return int_box(int_subtype_unbox(self) & sint_unbox(other))

@define_behavior
def py_ibitand_boolX_bintY(self: bool, other: bint):
    return int_box(int_subtype_unbox(self) & bint_unbox(other))

@define_behavior
def py_ibitand_sintX_intY(self: sint, other: int):
    return int_box(sint_unbox(self) & int_unbox(other))

@define_behavior
def py_ibitand_sintX_floatY(self: sint, other: float):
    raise TypeError("unsupported operand type(s) for &: 'int' and 'float'")

@define_behavior
def py_ibitand_sintX_boolY(self: sint, other: bool):
    return int_box(sint_unbox(self) & int_subtype_unbox(other))

@define_behavior
def py_ibitand_sintX_sintY(self: sint, other: sint):
    return int_box(sint_unbox(self) & sint_unbox(other))

@define_behavior
def py_ibitand_sintX_bintY(self: sint, other: bint):
    return int_box(sint_unbox(self) & bint_unbox(other))

@define_behavior
def py_ibitand_bintX_intY(self: bint, other: int):
    return int_box(bint_unbox(self) & int_unbox(other))

@define_behavior
def py_ibitand_bintX_floatY(self: bint, other: float):
    raise TypeError("unsupported operand type(s) for &: 'int' and 'float'")

@define_behavior
def py_ibitand_bintX_boolY(self: bint, other: bool):
    return int_box(bint_unbox(self) & int_subtype_unbox(other))

@define_behavior
def py_ibitand_bintX_sintY(self: bint, other: sint):
    return int_box(bint_unbox(self) & sint_unbox(other))

@define_behavior
def py_ibitand_bintX_bintY(self: bint, other: bint):
    return int_box(bint_unbox(self) & bint_unbox(other))

@define_behavior
def py_ibitor_intX_intY(self: int, other: int):
    return int_box(int_unbox(self) | int_unbox(other))

@define_behavior
def py_ibitor_intX_floatY(self: int, other: float):
    raise TypeError("unsupported operand type(s) for |: 'int' and 'float'")

@define_behavior
def py_ibitor_intX_boolY(self: int, other: bool):
    return int_box(int_unbox(self) | int_subtype_unbox(other))

@define_behavior
def py_ibitor_intX_sintY(self: int, other: sint):
    return int_box(int_unbox(self) | sint_unbox(other))

@define_behavior
def py_ibitor_intX_bintY(self: int, other: bint):
    return int_box(int_unbox(self) | bint_unbox(other))

@define_behavior
def py_ibitor_floatX_intY(self: float, other: int):
    raise TypeError("unsupported operand type(s) for |: 'float' and 'int'")

@define_behavior
def py_ibitor_floatX_floatY(self: float, other: float):
    raise TypeError("unsupported operand type(s) for |: 'float' and 'float'")

@define_behavior
def py_ibitor_floatX_boolY(self: float, other: bool):
    raise TypeError("unsupported operand type(s) for |: 'float' and 'bool'")

@define_behavior
def py_ibitor_floatX_sintY(self: float, other: sint):
    raise TypeError("unsupported operand type(s) for |: 'float' and 'int'")

@define_behavior
def py_ibitor_floatX_bintY(self: float, other: bint):
    raise TypeError("unsupported operand type(s) for |: 'float' and 'int'")

@define_behavior
def py_ibitor_boolX_intY(self: bool, other: int):
    return int_box(int_subtype_unbox(self) | int_unbox(other))

@define_behavior
def py_ibitor_boolX_floatY(self: bool, other: float):
    raise TypeError("unsupported operand type(s) for |: 'bool' and 'float'")

@define_behavior
def py_ibitor_boolX_boolY(self: bool, other: bool):
    return self or other

@define_behavior
def py_ibitor_boolX_sintY(self: bool, other: sint):
    return int_box(int_subtype_unbox(self) | sint_unbox(other))

@define_behavior
def py_ibitor_boolX_bintY(self: bool, other: bint):
    return int_box(int_subtype_unbox(self) | bint_unbox(other))

@define_behavior
def py_ibitor_sintX_intY(self: sint, other: int):
    return int_box(sint_unbox(self) | int_unbox(other))

@define_behavior
def py_ibitor_sintX_floatY(self: sint, other: float):
    raise TypeError("unsupported operand type(s) for |: 'int' and 'float'")

@define_behavior
def py_ibitor_sintX_boolY(self: sint, other: bool):
    return int_box(sint_unbox(self) | int_subtype_unbox(other))

@define_behavior
def py_ibitor_sintX_sintY(self: sint, other: sint):
    return int_box(sint_unbox(self) | sint_unbox(other))

@define_behavior
def py_ibitor_sintX_bintY(self: sint, other: bint):
    return int_box(sint_unbox(self) | bint_unbox(other))

@define_behavior
def py_ibitor_bintX_intY(self: bint, other: int):
    return int_box(bint_unbox(self) | int_unbox(other))

@define_behavior
def py_ibitor_bintX_floatY(self: bint, other: float):
    raise TypeError("unsupported operand type(s) for |: 'int' and 'float'")

@define_behavior
def py_ibitor_bintX_boolY(self: bint, other: bool):
    return int_box(bint_unbox(self) | int_subtype_unbox(other))

@define_behavior
def py_ibitor_bintX_sintY(self: bint, other: sint):
    return int_box(bint_unbox(self) | sint_unbox(other))

@define_behavior
def py_ibitor_bintX_bintY(self: bint, other: bint):
    return int_box(bint_unbox(self) | bint_unbox(other))

@define_behavior
def py_ifloordiv_intX_intY(self: int, other: int):
    if other != 0:
        return int_box(int_unbox(self) // int_unbox(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_ifloordiv_intX_floatY(self: int, other: float):
    if self != 0.0:
        return float_box(int_unbox(other) // float_unbox(self))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_ifloordiv_intX_boolY(self: int, other: bool):
    if other != 0:
        return int_box(int_unbox(self) // int_subtype_unbox(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_ifloordiv_intX_sintY(self: int, other: sint):
    if other != 0:
        return int_box(int_unbox(self) // sint_unbox(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_ifloordiv_intX_bintY(self: int, other: bint):
    if other != 0:
        return int_box(int_unbox(self) // bint_unbox(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_ifloordiv_floatX_intY(self: float, other: int):
    if other != 0:
        return float_box(float_unbox(self) // int_unbox(other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_ifloordiv_floatX_floatY(self: float, other: float):
    if other != 0.0:
        return float_box(float_unbox(self) // float_unbox(other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_ifloordiv_floatX_boolY(self: float, other: bool):
    if other != 0:
        return float_box(float_unbox(self) // int_subtype_unbox(other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_ifloordiv_floatX_sintY(self: float, other: sint):
    if other != 0:
        return float_box(float_unbox(self) // sint_unbox(other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_ifloordiv_floatX_bintY(self: float, other: bint):
    if other != 0:
        return float_box(float_unbox(self) // bint_unbox(other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_ifloordiv_boolX_intY(self: bool, other: int):
    if other != 0:
        return int_box(int_subtype_unbox(self) // int_unbox(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_ifloordiv_boolX_floatY(self: bool, other: float):
    if self != 0.0:
        return float_box(int_subtype_unbox(other) // float_unbox(self))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_ifloordiv_boolX_boolY(self: bool, other: bool):
    if other != 0:
        return int_box(int_subtype_unbox(self) // int_subtype_unbox(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_ifloordiv_boolX_sintY(self: bool, other: sint):
    if other != 0:
        return int_box(int_subtype_unbox(self) // sint_unbox(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_ifloordiv_boolX_bintY(self: bool, other: bint):
    if other != 0:
        return int_box(int_subtype_unbox(self) // bint_unbox(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_ifloordiv_sintX_intY(self: sint, other: int):
    if other != 0:
        return int_box(sint_unbox(self) // int_unbox(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_ifloordiv_sintX_floatY(self: sint, other: float):
    if self != 0.0:
        return float_box(sint_unbox(other) // float_unbox(self))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_ifloordiv_sintX_boolY(self: sint, other: bool):
    if other != 0:
        return int_box(sint_unbox(self) // int_subtype_unbox(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_ifloordiv_sintX_sintY(self: sint, other: sint):
    if other != 0:
        return int_box(sint_unbox(self) // sint_unbox(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_ifloordiv_sintX_bintY(self: sint, other: bint):
    if other != 0:
        return int_box(sint_unbox(self) // bint_unbox(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_ifloordiv_bintX_intY(self: bint, other: int):
    if other != 0:
        return int_box(bint_unbox(self) // int_unbox(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_ifloordiv_bintX_floatY(self: bint, other: float):
    if self != 0.0:
        return float_box(bint_unbox(other) // float_unbox(self))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_ifloordiv_bintX_boolY(self: bint, other: bool):
    if other != 0:
        return int_box(bint_unbox(self) // int_subtype_unbox(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_ifloordiv_bintX_sintY(self: bint, other: sint):
    if other != 0:
        return int_box(bint_unbox(self) // sint_unbox(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_ifloordiv_bintX_bintY(self: bint, other: bint):
    if other != 0:
        return int_box(bint_unbox(self) // bint_unbox(other))
    else:
        raise ZeroDivisionError('integer division by zero')

@define_behavior
def py_ilshift_intX_intY(self: int, other: int):
    return int_box(int_unbox(self) << int_unbox(other))

@define_behavior
def py_ilshift_intX_floatY(self: int, other: float):
    raise TypeError("unsupported operand type(s) for <<: 'int' and 'float'")

@define_behavior
def py_ilshift_intX_boolY(self: int, other: bool):
    return int_box(int_unbox(self) << int_subtype_unbox(other))

@define_behavior
def py_ilshift_intX_sintY(self: int, other: sint):
    return int_box(int_unbox(self) << sint_unbox(other))

@define_behavior
def py_ilshift_intX_bintY(self: int, other: bint):
    return int_box(int_unbox(self) << bint_unbox(other))

@define_behavior
def py_ilshift_floatX_intY(self: float, other: int):
    raise TypeError("unsupported operand type(s) for <<: 'float' and 'int'")

@define_behavior
def py_ilshift_floatX_floatY(self: float, other: float):
    raise TypeError("unsupported operand type(s) for <<: 'float' and 'float'")

@define_behavior
def py_ilshift_floatX_boolY(self: float, other: bool):
    raise TypeError("unsupported operand type(s) for <<: 'float' and 'bool'")

@define_behavior
def py_ilshift_floatX_sintY(self: float, other: sint):
    raise TypeError("unsupported operand type(s) for <<: 'float' and 'int'")

@define_behavior
def py_ilshift_floatX_bintY(self: float, other: bint):
    raise TypeError("unsupported operand type(s) for <<: 'float' and 'int'")

@define_behavior
def py_ilshift_boolX_intY(self: bool, other: int):
    return int_box(int_subtype_unbox(self) << int_unbox(other))

@define_behavior
def py_ilshift_boolX_floatY(self: bool, other: float):
    raise TypeError("unsupported operand type(s) for <<: 'bool' and 'float'")

@define_behavior
def py_ilshift_boolX_boolY(self: bool, other: bool):
    return int_box(int_subtype_unbox(self) << int_subtype_unbox(other))

@define_behavior
def py_ilshift_boolX_sintY(self: bool, other: sint):
    return int_box(int_subtype_unbox(self) << sint_unbox(other))

@define_behavior
def py_ilshift_boolX_bintY(self: bool, other: bint):
    return int_box(int_subtype_unbox(self) << bint_unbox(other))

@define_behavior
def py_ilshift_sintX_intY(self: sint, other: int):
    return int_box(sint_unbox(self) << int_unbox(other))

@define_behavior
def py_ilshift_sintX_floatY(self: sint, other: float):
    raise TypeError("unsupported operand type(s) for <<: 'int' and 'float'")

@define_behavior
def py_ilshift_sintX_boolY(self: sint, other: bool):
    return int_box(sint_unbox(self) << int_subtype_unbox(other))

@define_behavior
def py_ilshift_sintX_sintY(self: sint, other: sint):
    return int_box(sint_unbox(self) << sint_unbox(other))

@define_behavior
def py_ilshift_sintX_bintY(self: sint, other: bint):
    return int_box(sint_unbox(self) << bint_unbox(other))

@define_behavior
def py_ilshift_bintX_intY(self: bint, other: int):
    return int_box(bint_unbox(self) << int_unbox(other))

@define_behavior
def py_ilshift_bintX_floatY(self: bint, other: float):
    raise TypeError("unsupported operand type(s) for <<: 'int' and 'float'")

@define_behavior
def py_ilshift_bintX_boolY(self: bint, other: bool):
    return int_box(bint_unbox(self) << int_subtype_unbox(other))

@define_behavior
def py_ilshift_bintX_sintY(self: bint, other: sint):
    return int_box(bint_unbox(self) << sint_unbox(other))

@define_behavior
def py_ilshift_bintX_bintY(self: bint, other: bint):
    return int_box(bint_unbox(self) << bint_unbox(other))

@define_behavior
def py_imatmul_intX_intY(self: int, other: int):
    raise TypeError("unsupported operand type(s) for @: 'int' and 'int'")

@define_behavior
def py_imatmul_intX_floatY(self: int, other: float):
    raise TypeError("unsupported operand type(s) for @: 'int' and 'float'")

@define_behavior
def py_imatmul_intX_boolY(self: int, other: bool):
    raise TypeError("unsupported operand type(s) for @: 'int' and 'bool'")

@define_behavior
def py_imatmul_intX_sintY(self: int, other: sint):
    raise TypeError("unsupported operand type(s) for @: 'int' and 'int'")

@define_behavior
def py_imatmul_intX_bintY(self: int, other: bint):
    raise TypeError("unsupported operand type(s) for @: 'int' and 'int'")

@define_behavior
def py_imatmul_floatX_intY(self: float, other: int):
    raise TypeError("unsupported operand type(s) for @: 'float' and 'int'")

@define_behavior
def py_imatmul_floatX_floatY(self: float, other: float):
    raise TypeError("unsupported operand type(s) for @: 'float' and 'float'")

@define_behavior
def py_imatmul_floatX_boolY(self: float, other: bool):
    raise TypeError("unsupported operand type(s) for @: 'float' and 'bool'")

@define_behavior
def py_imatmul_floatX_sintY(self: float, other: sint):
    raise TypeError("unsupported operand type(s) for @: 'float' and 'int'")

@define_behavior
def py_imatmul_floatX_bintY(self: float, other: bint):
    raise TypeError("unsupported operand type(s) for @: 'float' and 'int'")

@define_behavior
def py_imatmul_boolX_intY(self: bool, other: int):
    raise TypeError("unsupported operand type(s) for @: 'bool' and 'int'")

@define_behavior
def py_imatmul_boolX_floatY(self: bool, other: float):
    raise TypeError("unsupported operand type(s) for @: 'bool' and 'float'")

@define_behavior
def py_imatmul_boolX_boolY(self: bool, other: bool):
    raise TypeError("unsupported operand type(s) for @: 'bool' and 'bool'")

@define_behavior
def py_imatmul_boolX_sintY(self: bool, other: sint):
    raise TypeError("unsupported operand type(s) for @: 'bool' and 'int'")

@define_behavior
def py_imatmul_boolX_bintY(self: bool, other: bint):
    raise TypeError("unsupported operand type(s) for @: 'bool' and 'int'")

@define_behavior
def py_imatmul_sintX_intY(self: sint, other: int):
    raise TypeError("unsupported operand type(s) for @: 'int' and 'int'")

@define_behavior
def py_imatmul_sintX_floatY(self: sint, other: float):
    raise TypeError("unsupported operand type(s) for @: 'int' and 'float'")

@define_behavior
def py_imatmul_sintX_boolY(self: sint, other: bool):
    raise TypeError("unsupported operand type(s) for @: 'int' and 'bool'")

@define_behavior
def py_imatmul_sintX_sintY(self: sint, other: sint):
    raise TypeError("unsupported operand type(s) for @: 'int' and 'int'")

@define_behavior
def py_imatmul_sintX_bintY(self: sint, other: bint):
    raise TypeError("unsupported operand type(s) for @: 'int' and 'int'")

@define_behavior
def py_imatmul_bintX_intY(self: bint, other: int):
    raise TypeError("unsupported operand type(s) for @: 'int' and 'int'")

@define_behavior
def py_imatmul_bintX_floatY(self: bint, other: float):
    raise TypeError("unsupported operand type(s) for @: 'int' and 'float'")

@define_behavior
def py_imatmul_bintX_boolY(self: bint, other: bool):
    raise TypeError("unsupported operand type(s) for @: 'int' and 'bool'")

@define_behavior
def py_imatmul_bintX_sintY(self: bint, other: sint):
    raise TypeError("unsupported operand type(s) for @: 'int' and 'int'")

@define_behavior
def py_imatmul_bintX_bintY(self: bint, other: bint):
    raise TypeError("unsupported operand type(s) for @: 'int' and 'int'")

@define_behavior
def py_imod_intX_intY(self: int, other: int):
    if other != 0:
        return int_box(int_unbox(self) % int_unbox(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_imod_intX_floatY(self: int, other: float):
    if self != 0.0:
        return float_box(int_unbox(other) % float_unbox(self))
    else:
        raise ZeroDivisionError('float modulo by zero')

@define_behavior
def py_imod_intX_boolY(self: int, other: bool):
    if other != 0:
        return int_box(int_unbox(self) % int_subtype_unbox(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_imod_intX_sintY(self: int, other: sint):
    if other != 0:
        return int_box(int_unbox(self) % sint_unbox(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_imod_intX_bintY(self: int, other: bint):
    if other != 0:
        return int_box(int_unbox(self) % bint_unbox(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_imod_floatX_intY(self: float, other: int):
    if other != 0:
        return float_box(float_unbox(self) % int_unbox(other))
    else:
        raise ZeroDivisionError('float modulo by zero')

@define_behavior
def py_imod_floatX_floatY(self: float, other: float):
    if other != 0.0:
        return float_box(float_unbox(self) % float_unbox(other))
    else:
        raise ZeroDivisionError('float modulo by zero')

@define_behavior
def py_imod_floatX_boolY(self: float, other: bool):
    if other != 0:
        return float_box(float_unbox(self) % int_subtype_unbox(other))
    else:
        raise ZeroDivisionError('float modulo by zero')

@define_behavior
def py_imod_floatX_sintY(self: float, other: sint):
    if other != 0:
        return float_box(float_unbox(self) % sint_unbox(other))
    else:
        raise ZeroDivisionError('float modulo by zero')

@define_behavior
def py_imod_floatX_bintY(self: float, other: bint):
    if other != 0:
        return float_box(float_unbox(self) % bint_unbox(other))
    else:
        raise ZeroDivisionError('float modulo by zero')

@define_behavior
def py_imod_boolX_intY(self: bool, other: int):
    if other != 0:
        return int_box(int_subtype_unbox(self) % int_unbox(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_imod_boolX_floatY(self: bool, other: float):
    if self != 0.0:
        return float_box(int_subtype_unbox(other) % float_unbox(self))
    else:
        raise ZeroDivisionError('float modulo by zero')

@define_behavior
def py_imod_boolX_boolY(self: bool, other: bool):
    if other != 0:
        return int_box(int_subtype_unbox(self) % int_subtype_unbox(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_imod_boolX_sintY(self: bool, other: sint):
    if other != 0:
        return int_box(int_subtype_unbox(self) % sint_unbox(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_imod_boolX_bintY(self: bool, other: bint):
    if other != 0:
        return int_box(int_subtype_unbox(self) % bint_unbox(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_imod_sintX_intY(self: sint, other: int):
    if other != 0:
        return int_box(sint_unbox(self) % int_unbox(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_imod_sintX_floatY(self: sint, other: float):
    if self != 0.0:
        return float_box(sint_unbox(other) % float_unbox(self))
    else:
        raise ZeroDivisionError('float modulo by zero')

@define_behavior
def py_imod_sintX_boolY(self: sint, other: bool):
    if other != 0:
        return int_box(sint_unbox(self) % int_subtype_unbox(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_imod_sintX_sintY(self: sint, other: sint):
    if other != 0:
        return int_box(sint_unbox(self) % sint_unbox(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_imod_sintX_bintY(self: sint, other: bint):
    if other != 0:
        return int_box(sint_unbox(self) % bint_unbox(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_imod_bintX_intY(self: bint, other: int):
    if other != 0:
        return int_box(bint_unbox(self) % int_unbox(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_imod_bintX_floatY(self: bint, other: float):
    if self != 0.0:
        return float_box(bint_unbox(other) % float_unbox(self))
    else:
        raise ZeroDivisionError('float modulo by zero')

@define_behavior
def py_imod_bintX_boolY(self: bint, other: bool):
    if other != 0:
        return int_box(bint_unbox(self) % int_subtype_unbox(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_imod_bintX_sintY(self: bint, other: sint):
    if other != 0:
        return int_box(bint_unbox(self) % sint_unbox(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_imod_bintX_bintY(self: bint, other: bint):
    if other != 0:
        return int_box(bint_unbox(self) % bint_unbox(other))
    else:
        raise ZeroDivisionError('modulo by zero')

@define_behavior
def py_imul_intX_intY(self: int, other: int):
    return int_box(int_unbox(self) * int_unbox(other))

@define_behavior
def py_imul_intX_floatY(self: int, other: float):
    return float_box(int_unbox(other) * float_unbox(self))

@define_behavior
def py_imul_intX_boolY(self: int, other: bool):
    return int_box(int_unbox(self) * int_subtype_unbox(other))

@define_behavior
def py_imul_intX_sintY(self: int, other: sint):
    return int_box(int_unbox(self) * sint_unbox(other))

@define_behavior
def py_imul_intX_bintY(self: int, other: bint):
    return int_box(int_unbox(self) * bint_unbox(other))

@define_behavior
def py_imul_floatX_intY(self: float, other: int):
    return float_box(float_unbox(self) * int_unbox(other))

@define_behavior
def py_imul_floatX_floatY(self: float, other: float):
    return float_box(float_unbox(self) * float_unbox(other))

@define_behavior
def py_imul_floatX_boolY(self: float, other: bool):
    return float_box(float_unbox(self) * int_subtype_unbox(other))

@define_behavior
def py_imul_floatX_sintY(self: float, other: sint):
    return float_box(float_unbox(self) * sint_unbox(other))

@define_behavior
def py_imul_floatX_bintY(self: float, other: bint):
    return float_box(float_unbox(self) * bint_unbox(other))

@define_behavior
def py_imul_boolX_intY(self: bool, other: int):
    return int_box(int_subtype_unbox(self) * int_unbox(other))

@define_behavior
def py_imul_boolX_floatY(self: bool, other: float):
    return float_box(int_subtype_unbox(other) * float_unbox(self))

@define_behavior
def py_imul_boolX_boolY(self: bool, other: bool):
    return int_box(int_subtype_unbox(self) * int_subtype_unbox(other))

@define_behavior
def py_imul_boolX_sintY(self: bool, other: sint):
    return int_box(int_subtype_unbox(self) * sint_unbox(other))

@define_behavior
def py_imul_boolX_bintY(self: bool, other: bint):
    return int_box(int_subtype_unbox(self) * bint_unbox(other))

@define_behavior
def py_imul_sintX_intY(self: sint, other: int):
    return int_box(sint_unbox(self) * int_unbox(other))

@define_behavior
def py_imul_sintX_floatY(self: sint, other: float):
    return float_box(sint_unbox(other) * float_unbox(self))

@define_behavior
def py_imul_sintX_boolY(self: sint, other: bool):
    return int_box(sint_unbox(self) * int_subtype_unbox(other))

@define_behavior
def py_imul_sintX_sintY(self: sint, other: sint):
    return int_box(sint_unbox(self) * sint_unbox(other))

@define_behavior
def py_imul_sintX_bintY(self: sint, other: bint):
    return int_box(sint_unbox(self) * bint_unbox(other))

@define_behavior
def py_imul_bintX_intY(self: bint, other: int):
    return int_box(bint_unbox(self) * int_unbox(other))

@define_behavior
def py_imul_bintX_floatY(self: bint, other: float):
    return float_box(bint_unbox(other) * float_unbox(self))

@define_behavior
def py_imul_bintX_boolY(self: bint, other: bool):
    return int_box(bint_unbox(self) * int_subtype_unbox(other))

@define_behavior
def py_imul_bintX_sintY(self: bint, other: sint):
    return int_box(bint_unbox(self) * sint_unbox(other))

@define_behavior
def py_imul_bintX_bintY(self: bint, other: bint):
    return int_box(bint_unbox(self) * bint_unbox(other))

@define_behavior
def py_ipow_intX_intY(self: int, other: int):
    return int_box(int_unbox(self) ** int_unbox(other))

@define_behavior
def py_ipow_intX_floatY(self: int, other: float):
    return float_box(int_unbox(other) ** float_unbox(self))

@define_behavior
def py_ipow_intX_boolY(self: int, other: bool):
    return int_box(int_unbox(self) ** int_subtype_unbox(other))

@define_behavior
def py_ipow_intX_sintY(self: int, other: sint):
    return int_box(int_unbox(self) ** sint_unbox(other))

@define_behavior
def py_ipow_intX_bintY(self: int, other: bint):
    return int_box(int_unbox(self) ** bint_unbox(other))

@define_behavior
def py_ipow_floatX_intY(self: float, other: int):
    return float_box(float_unbox(self) ** int_unbox(other))

@define_behavior
def py_ipow_floatX_floatY(self: float, other: float):
    return float_box(float_unbox(self) ** float_unbox(other))

@define_behavior
def py_ipow_floatX_boolY(self: float, other: bool):
    return float_box(float_unbox(self) ** int_subtype_unbox(other))

@define_behavior
def py_ipow_floatX_sintY(self: float, other: sint):
    return float_box(float_unbox(self) ** sint_unbox(other))

@define_behavior
def py_ipow_floatX_bintY(self: float, other: bint):
    return float_box(float_unbox(self) ** bint_unbox(other))

@define_behavior
def py_ipow_boolX_intY(self: bool, other: int):
    return int_box(int_subtype_unbox(self) ** int_unbox(other))

@define_behavior
def py_ipow_boolX_floatY(self: bool, other: float):
    return float_box(int_subtype_unbox(other) ** float_unbox(self))

@define_behavior
def py_ipow_boolX_boolY(self: bool, other: bool):
    return int_box(int_subtype_unbox(self) ** int_subtype_unbox(other))

@define_behavior
def py_ipow_boolX_sintY(self: bool, other: sint):
    return int_box(int_subtype_unbox(self) ** sint_unbox(other))

@define_behavior
def py_ipow_boolX_bintY(self: bool, other: bint):
    return int_box(int_subtype_unbox(self) ** bint_unbox(other))

@define_behavior
def py_ipow_sintX_intY(self: sint, other: int):
    return int_box(sint_unbox(self) ** int_unbox(other))

@define_behavior
def py_ipow_sintX_floatY(self: sint, other: float):
    return float_box(sint_unbox(other) ** float_unbox(self))

@define_behavior
def py_ipow_sintX_boolY(self: sint, other: bool):
    return int_box(sint_unbox(self) ** int_subtype_unbox(other))

@define_behavior
def py_ipow_sintX_sintY(self: sint, other: sint):
    return int_box(sint_unbox(self) ** sint_unbox(other))

@define_behavior
def py_ipow_sintX_bintY(self: sint, other: bint):
    return int_box(sint_unbox(self) ** bint_unbox(other))

@define_behavior
def py_ipow_bintX_intY(self: bint, other: int):
    return int_box(bint_unbox(self) ** int_unbox(other))

@define_behavior
def py_ipow_bintX_floatY(self: bint, other: float):
    return float_box(bint_unbox(other) ** float_unbox(self))

@define_behavior
def py_ipow_bintX_boolY(self: bint, other: bool):
    return int_box(bint_unbox(self) ** int_subtype_unbox(other))

@define_behavior
def py_ipow_bintX_sintY(self: bint, other: sint):
    return int_box(bint_unbox(self) ** sint_unbox(other))

@define_behavior
def py_ipow_bintX_bintY(self: bint, other: bint):
    return int_box(bint_unbox(self) ** bint_unbox(other))

@define_behavior
def py_irshift_intX_intY(self: int, other: int):
    return int_box(int_unbox(self) >> int_unbox(other))

@define_behavior
def py_irshift_intX_floatY(self: int, other: float):
    raise TypeError("unsupported operand type(s) for >>: 'int' and 'float'")

@define_behavior
def py_irshift_intX_boolY(self: int, other: bool):
    return int_box(int_subtype_unbox(self) >> int_unbox(other))

@define_behavior
def py_irshift_intX_sintY(self: int, other: sint):
    return int_box(sint_unbox(self) >> int_unbox(other))

@define_behavior
def py_irshift_intX_bintY(self: int, other: bint):
    return int_box(bint_unbox(self) >> int_unbox(other))

@define_behavior
def py_irshift_floatX_intY(self: float, other: int):
    raise TypeError("unsupported operand type(s) for >>: 'float' and 'int'")

@define_behavior
def py_irshift_floatX_floatY(self: float, other: float):
    raise TypeError("unsupported operand type(s) for >>: 'float' and 'float'")

@define_behavior
def py_irshift_floatX_boolY(self: float, other: bool):
    raise TypeError("unsupported operand type(s) for >>: 'float' and 'bool'")

@define_behavior
def py_irshift_floatX_sintY(self: float, other: sint):
    raise TypeError("unsupported operand type(s) for >>: 'float' and 'int'")

@define_behavior
def py_irshift_floatX_bintY(self: float, other: bint):
    raise TypeError("unsupported operand type(s) for >>: 'float' and 'int'")

@define_behavior
def py_irshift_boolX_intY(self: bool, other: int):
    return int_box(int_unbox(self) >> int_subtype_unbox(other))

@define_behavior
def py_irshift_boolX_floatY(self: bool, other: float):
    raise TypeError("unsupported operand type(s) for >>: 'bool' and 'float'")

@define_behavior
def py_irshift_boolX_boolY(self: bool, other: bool):
    return int_box(int_subtype_unbox(self) >> int_subtype_unbox(other))

@define_behavior
def py_irshift_boolX_sintY(self: bool, other: sint):
    return int_box(sint_unbox(self) >> int_subtype_unbox(other))

@define_behavior
def py_irshift_boolX_bintY(self: bool, other: bint):
    return int_box(bint_unbox(self) >> int_subtype_unbox(other))

@define_behavior
def py_irshift_sintX_intY(self: sint, other: int):
    return int_box(int_unbox(self) >> sint_unbox(other))

@define_behavior
def py_irshift_sintX_floatY(self: sint, other: float):
    raise TypeError("unsupported operand type(s) for >>: 'int' and 'float'")

@define_behavior
def py_irshift_sintX_boolY(self: sint, other: bool):
    return int_box(int_subtype_unbox(self) >> sint_unbox(other))

@define_behavior
def py_irshift_sintX_sintY(self: sint, other: sint):
    return int_box(sint_unbox(self) >> sint_unbox(other))

@define_behavior
def py_irshift_sintX_bintY(self: sint, other: bint):
    return int_box(bint_unbox(self) >> sint_unbox(other))

@define_behavior
def py_irshift_bintX_intY(self: bint, other: int):
    return int_box(int_unbox(self) >> bint_unbox(other))

@define_behavior
def py_irshift_bintX_floatY(self: bint, other: float):
    raise TypeError("unsupported operand type(s) for >>: 'int' and 'float'")

@define_behavior
def py_irshift_bintX_boolY(self: bint, other: bool):
    return int_box(int_subtype_unbox(self) >> bint_unbox(other))

@define_behavior
def py_irshift_bintX_sintY(self: bint, other: sint):
    return int_box(sint_unbox(self) >> bint_unbox(other))

@define_behavior
def py_irshift_bintX_bintY(self: bint, other: bint):
    return int_box(bint_unbox(self) >> bint_unbox(other))

@define_behavior
def py_isub_intX_intY(self: int, other: int):
    return int_box(int_unbox(self) - int_unbox(other))

@define_behavior
def py_isub_intX_floatY(self: int, other: float):
    return float_box(int_unbox(other) - float_unbox(self))

@define_behavior
def py_isub_intX_boolY(self: int, other: bool):
    return int_box(int_unbox(self) - int_subtype_unbox(other))

@define_behavior
def py_isub_intX_sintY(self: int, other: sint):
    return int_box(int_unbox(self) - sint_unbox(other))

@define_behavior
def py_isub_intX_bintY(self: int, other: bint):
    return int_box(int_unbox(self) - bint_unbox(other))

@define_behavior
def py_isub_floatX_intY(self: float, other: int):
    return float_box(float_unbox(self) - int_unbox(other))

@define_behavior
def py_isub_floatX_floatY(self: float, other: float):
    return float_box(float_unbox(self) - float_unbox(other))

@define_behavior
def py_isub_floatX_boolY(self: float, other: bool):
    return float_box(float_unbox(self) - int_subtype_unbox(other))

@define_behavior
def py_isub_floatX_sintY(self: float, other: sint):
    return float_box(float_unbox(self) - sint_unbox(other))

@define_behavior
def py_isub_floatX_bintY(self: float, other: bint):
    return float_box(float_unbox(self) - bint_unbox(other))

@define_behavior
def py_isub_boolX_intY(self: bool, other: int):
    return int_box(int_subtype_unbox(self) - int_unbox(other))

@define_behavior
def py_isub_boolX_floatY(self: bool, other: float):
    return float_box(int_subtype_unbox(other) - float_unbox(self))

@define_behavior
def py_isub_boolX_boolY(self: bool, other: bool):
    return int_box(int_subtype_unbox(self) - int_subtype_unbox(other))

@define_behavior
def py_isub_boolX_sintY(self: bool, other: sint):
    return int_box(int_subtype_unbox(self) - sint_unbox(other))

@define_behavior
def py_isub_boolX_bintY(self: bool, other: bint):
    return int_box(int_subtype_unbox(self) - bint_unbox(other))

@define_behavior
def py_isub_sintX_intY(self: sint, other: int):
    return int_box(sint_unbox(self) - int_unbox(other))

@define_behavior
def py_isub_sintX_floatY(self: sint, other: float):
    return float_box(sint_unbox(other) - float_unbox(self))

@define_behavior
def py_isub_sintX_boolY(self: sint, other: bool):
    return int_box(sint_unbox(self) - int_subtype_unbox(other))

@define_behavior
def py_isub_sintX_sintY(self: sint, other: sint):
    return int_box(sint_unbox(self) - sint_unbox(other))

@define_behavior
def py_isub_sintX_bintY(self: sint, other: bint):
    return int_box(sint_unbox(self) - bint_unbox(other))

@define_behavior
def py_isub_bintX_intY(self: bint, other: int):
    return int_box(bint_unbox(self) - int_unbox(other))

@define_behavior
def py_isub_bintX_floatY(self: bint, other: float):
    return float_box(bint_unbox(other) - float_unbox(self))

@define_behavior
def py_isub_bintX_boolY(self: bint, other: bool):
    return int_box(bint_unbox(self) - int_subtype_unbox(other))

@define_behavior
def py_isub_bintX_sintY(self: bint, other: sint):
    return int_box(bint_unbox(self) - sint_unbox(other))

@define_behavior
def py_isub_bintX_bintY(self: bint, other: bint):
    return int_box(bint_unbox(self) - bint_unbox(other))

@define_behavior
def py_itruediv_intX_intY(self: int, other: int):
    if other != 0:
        return int_box(int_unbox(self) / int_unbox(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_itruediv_intX_floatY(self: int, other: float):
    if self != 0.0:
        return float_box(int_unbox(other) / float_unbox(self))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_itruediv_intX_boolY(self: int, other: bool):
    if other != 0:
        return int_box(int_unbox(self) / int_subtype_unbox(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_itruediv_intX_sintY(self: int, other: sint):
    if other != 0:
        return int_box(int_unbox(self) / sint_unbox(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_itruediv_intX_bintY(self: int, other: bint):
    if other != 0:
        return int_box(int_unbox(self) / bint_unbox(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_itruediv_floatX_intY(self: float, other: int):
    if other != 0:
        return float_box(float_unbox(self) / int_unbox(other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_itruediv_floatX_floatY(self: float, other: float):
    if other != 0.0:
        return float_box(float_unbox(self) / float_unbox(other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_itruediv_floatX_boolY(self: float, other: bool):
    if other != 0:
        return float_box(float_unbox(self) / int_subtype_unbox(other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_itruediv_floatX_sintY(self: float, other: sint):
    if other != 0:
        return float_box(float_unbox(self) / sint_unbox(other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_itruediv_floatX_bintY(self: float, other: bint):
    if other != 0:
        return float_box(float_unbox(self) / bint_unbox(other))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_itruediv_boolX_intY(self: bool, other: int):
    if other != 0:
        return int_box(int_subtype_unbox(self) / int_unbox(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_itruediv_boolX_floatY(self: bool, other: float):
    if self != 0.0:
        return float_box(int_subtype_unbox(other) / float_unbox(self))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_itruediv_boolX_boolY(self: bool, other: bool):
    if other != 0:
        return int_box(int_subtype_unbox(self) / int_subtype_unbox(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_itruediv_boolX_sintY(self: bool, other: sint):
    if other != 0:
        return int_box(int_subtype_unbox(self) / sint_unbox(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_itruediv_boolX_bintY(self: bool, other: bint):
    if other != 0:
        return int_box(int_subtype_unbox(self) / bint_unbox(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_itruediv_sintX_intY(self: sint, other: int):
    if other != 0:
        return int_box(sint_unbox(self) / int_unbox(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_itruediv_sintX_floatY(self: sint, other: float):
    if self != 0.0:
        return float_box(sint_unbox(other) / float_unbox(self))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_itruediv_sintX_boolY(self: sint, other: bool):
    if other != 0:
        return int_box(sint_unbox(self) / int_subtype_unbox(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_itruediv_sintX_sintY(self: sint, other: sint):
    if other != 0:
        return int_box(sint_unbox(self) / sint_unbox(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_itruediv_sintX_bintY(self: sint, other: bint):
    if other != 0:
        return int_box(sint_unbox(self) / bint_unbox(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_itruediv_bintX_intY(self: bint, other: int):
    if other != 0:
        return int_box(bint_unbox(self) / int_unbox(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_itruediv_bintX_floatY(self: bint, other: float):
    if self != 0.0:
        return float_box(bint_unbox(other) / float_unbox(self))
    else:
        raise ZeroDivisionError('float division by zero')

@define_behavior
def py_itruediv_bintX_boolY(self: bint, other: bool):
    if other != 0:
        return int_box(bint_unbox(self) / int_subtype_unbox(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_itruediv_bintX_sintY(self: bint, other: sint):
    if other != 0:
        return int_box(bint_unbox(self) / sint_unbox(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_itruediv_bintX_bintY(self: bint, other: bint):
    if other != 0:
        return int_box(bint_unbox(self) / bint_unbox(other))
    else:
        raise ZeroDivisionError('division by zero')

@define_behavior
def py_ixor_intX_intY(self: int, other: int):
    return int_box(int_unbox(self) ^ int_unbox(other))

@define_behavior
def py_ixor_intX_floatY(self: int, other: float):
    raise TypeError("unsupported operand type(s) for ^: 'int' and 'float'")

@define_behavior
def py_ixor_intX_boolY(self: int, other: bool):
    return int_box(int_unbox(self) ^ int_subtype_unbox(other))

@define_behavior
def py_ixor_intX_sintY(self: int, other: sint):
    return int_box(int_unbox(self) ^ sint_unbox(other))

@define_behavior
def py_ixor_intX_bintY(self: int, other: bint):
    return int_box(int_unbox(self) ^ bint_unbox(other))

@define_behavior
def py_ixor_floatX_intY(self: float, other: int):
    raise TypeError("unsupported operand type(s) for ^: 'float' and 'int'")

@define_behavior
def py_ixor_floatX_floatY(self: float, other: float):
    raise TypeError("unsupported operand type(s) for ^: 'float' and 'float'")

@define_behavior
def py_ixor_floatX_boolY(self: float, other: bool):
    raise TypeError("unsupported operand type(s) for ^: 'float' and 'bool'")

@define_behavior
def py_ixor_floatX_sintY(self: float, other: sint):
    raise TypeError("unsupported operand type(s) for ^: 'float' and 'int'")

@define_behavior
def py_ixor_floatX_bintY(self: float, other: bint):
    raise TypeError("unsupported operand type(s) for ^: 'float' and 'int'")

@define_behavior
def py_ixor_boolX_intY(self: bool, other: int):
    return int_box(int_subtype_unbox(self) ^ int_unbox(other))

@define_behavior
def py_ixor_boolX_floatY(self: bool, other: float):
    raise TypeError("unsupported operand type(s) for ^: 'bool' and 'float'")

@define_behavior
def py_ixor_boolX_boolY(self: bool, other: bool):
    return self is not other

@define_behavior
def py_ixor_boolX_sintY(self: bool, other: sint):
    return int_box(int_subtype_unbox(self) ^ sint_unbox(other))

@define_behavior
def py_ixor_boolX_bintY(self: bool, other: bint):
    return int_box(int_subtype_unbox(self) ^ bint_unbox(other))

@define_behavior
def py_ixor_sintX_intY(self: sint, other: int):
    return int_box(sint_unbox(self) ^ int_unbox(other))

@define_behavior
def py_ixor_sintX_floatY(self: sint, other: float):
    raise TypeError("unsupported operand type(s) for ^: 'int' and 'float'")

@define_behavior
def py_ixor_sintX_boolY(self: sint, other: bool):
    return int_box(sint_unbox(self) ^ int_subtype_unbox(other))

@define_behavior
def py_ixor_sintX_sintY(self: sint, other: sint):
    return int_box(sint_unbox(self) ^ sint_unbox(other))

@define_behavior
def py_ixor_sintX_bintY(self: sint, other: bint):
    return int_box(sint_unbox(self) ^ bint_unbox(other))

@define_behavior
def py_ixor_bintX_intY(self: bint, other: int):
    return int_box(bint_unbox(self) ^ int_unbox(other))

@define_behavior
def py_ixor_bintX_floatY(self: bint, other: float):
    raise TypeError("unsupported operand type(s) for ^: 'int' and 'float'")

@define_behavior
def py_ixor_bintX_boolY(self: bint, other: bool):
    return int_box(bint_unbox(self) ^ int_subtype_unbox(other))

@define_behavior
def py_ixor_bintX_sintY(self: bint, other: sint):
    return int_box(bint_unbox(self) ^ sint_unbox(other))

@define_behavior
def py_ixor_bintX_bintY(self: bint, other: bint):
    return int_box(bint_unbox(self) ^ bint_unbox(other))
