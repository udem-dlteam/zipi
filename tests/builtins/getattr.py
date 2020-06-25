class A:
    x = 1
    foo = 2

    def __init__(self):
        self.y = 2

a = A()
print(getattr(a, "x"))
print(getattr(a, "y"))
print(getattr(a, "z", 10))

print(a.foo)
print(getattr(a, "foo"))
print(getattr(a, "f" + "oo"))
