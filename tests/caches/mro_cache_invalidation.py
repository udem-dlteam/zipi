class A(int):
    pass

a = A()

for _ in range(2):
    print(a.__add__(0))
    A.__add__ = lambda self, other: "foo"
