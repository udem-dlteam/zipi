#!/usr/bin/env python

arithmetic_template = \
"""# Auto-generated
@define_semantics
@inline
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
"""

arithmetic_template_body = """
    # <{op}_body>
{body}
    # </{op}_body>"""

def define_arithmetic_semantics(op, magic_method, body=None):
    if body is None:
        body = "    return normal()"

    template = arithmetic_template.format(op=op, magic_method=magic_method)
    body = arithmetic_template_body.format(op=op, body=body)

    return template + body

def parse_bodies(semantics):
    ops = {"add", "sub", "mul", "truediv", "floordiv", "mod", "pow",
           "lshift", "rshift", "bitand", "bitor", "xor", "matmul"}
    tags = {f"    # <{op}_body>":op for op in ops}

    # All the collected op bodies
    bodies = {op:None for op in ops}
    # The current op body
    body = []
    in_body = False
    # Current op
    op = None

    for line in semantics:
        if line in tags.keys():
            in_body = True
            op = tags[line]
            continue

        if in_body:
            if line != f"    # </{op}_body>":
                body.append(line)
            else:
                in_body = False
                bodies[op] = '\n'.join(body)
                body = []
                op = None

    return bodies

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

    with open("./zemantics.py.old", "r") as f:
        old_semantics = f.read().splitlines()
        bodies = parse_bodies(old_semantics)

    arithmetic_semantics = '\n\n'.join(define_arithmetic_semantics(op, magic_method, bodies[op]) for op, magic_method in ops)

    with open("./zemantics.py.in", "r") as f:
        semantics = f.read().format(arithmetic_semantics)

    with open("../zemantics.py", "w") as f:
        f.write(semantics)
