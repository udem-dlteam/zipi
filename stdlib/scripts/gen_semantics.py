#!/usr/bin/env python

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
        raise ValueError

    return normal()"""

def define_arithmetic_semantics(op, magic_method):
    return arithmetic_template.format(op=op, magic_method=magic_method)

if __name__ == "__main__":
    ops = [
        ("add", "add"),
        ("sub", "sub"),
        ("mul", "mul"),
        ("truediv", "truediv"),
        ("floordiv", "floordiv"),
        ("mod", "mod"),
        ("pow", "pow"),
        ("lshift", "lshift"),
        ("rshift", "rshift"),
        ("bitand", "and"),
        ("bitor", "or"),
        ("xor", "xor"),
        ("matmul", "matmul")]
    arithmetic_semantics = '\n\n'.join(define_arithmetic_semantics(op, magic_method) for op, magic_method in ops)

    with open("./zemantics.py.in", "r") as f:
        semantics = f.read().format(arithmetic_semantics)

    with open("../zemantics.py", "w") as f:
        f.write(semantics)
