@builtin_type("PyObjectInt")
class int:
    def __add__(self, other):
        if isinstance(self, int) and isinstance(other, int):
            return self + other


@builtin_type("PyObjectFloat")
class float:
    def __add__(self, other):
        if isinstance(self, float) and isinstance(other, int):
            return float_box(float_unbox(self) + int_unbox(other))

def py_float_add_floatX_intY(x, y):
    return float_box(float_unbox(self) + int_unbox(other))
