class A:
    def __add__(self, other):
        print("A.__add__")
        return 1


class B(A):
    def __radd__(self, other):
        print("B.__radd__")
        return 2


print(A() + B())
# expected:
# B.__radd__
# 2


class C:
    def __add__(self, other):
        print("C.__add__")
        return NotImplemented

    def __radd__(self, other):
        print("C.__radd__")
        return 3


try:
    print(C() + C())
except TypeError:
    print("TypeError")
# expected:
# C.__add__
# TypeError
