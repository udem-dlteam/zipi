arithmetic_template = \
"""# Auto-generated
@define_semantics
@use_static_builtins
@no_dict_scope
def sem_{0}(x, y):
    def normal():
        magic_method = class_getattr(x, "__{0}__")
        if magic_method is absent:
            return reflected()
        else:
            result = magic_method(x, y)
            if result is NotImplemented:
                return reflected()
            else:
                return result

    def reflected():
        magic_method = class_getattr(y, "__r{0}__")
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
        "matmul"]
    arithmetic_semantics = '\n\n'.join(define_arithmetic_semantics(op) for op in ops)

    with open("./semantics.py.in", "r") as f:
        semantics = f.read().format(arithmetic_semantics)

    with open("../semantics.py", "w") as f:
        f.write(semantics)
