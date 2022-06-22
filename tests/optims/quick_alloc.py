# Quick alloc deactivated after setting __new__
class A:
    pass

a = A()
print(type(a) is A)

A.__new__ = lambda *args: 1

a = A()
print(a)


# __init__ called in both quick alloc and no-quick alloc modes

class B:
    def __init__(self):
        self.x = 5

b = B()
print(getattr(b, "x", None))
print(getattr(b, "y", None))

def B__new__(cls):
    o = object.__new__(cls)
    o.y = 4
    return o

B.__new__ = B__new__

b = B()
print(getattr(b, "x", None))
print(getattr(b, "y", None))
