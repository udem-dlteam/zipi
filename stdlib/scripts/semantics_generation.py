arithmetic_template = \
"""# Auto-generated
@define_semantics
def sem_{0}(x, y):
    def normal(x, y):
        __{0}__ = class_getattr(x, "__{0}__")
        if __{0}__ is absent:
            return reflected(x, y)
        else:
            result = __{0}__(x, y)
            if result is NotImplemented:
                return reflected(x, y)
            else:
                return result

    def reflected(x, y):
        __r{0}__ = class_getattr(y, "__r{0}__")
        if __r{0}__ is absent:
            return err()
        else:
            y_result = __r{0}__(y, x)
            if y_result is NotImplemented:
                return err()
            else:
                return y_result

    def err():
        raise ValueError

    return normal(x, y)"""

def define_arithmetic_semantics(op):
    return arithmetic_template.format(op)

if __name__ == "__main__":
    ops = [
        "add",
        "sub",
        "mul",
        "truediv",
        "floordiv",
        "mod",
        "pow",
        "lshift",
        "rshift",
        "and",
        "or",
        "xor",
        "matmul",
        "lt",
        "le",
        "gt",
        "ge"]
    arithmetic_semantics = '\n\n'.join(define_arithmetic_semantics(op) for op in ops)

    with open("../semantics.py.in", "r") as f:
        semantics = f.read().format(arithmetic_semantics)

    with open("../semantics.py", "w") as f:
        f.write(semantics)
