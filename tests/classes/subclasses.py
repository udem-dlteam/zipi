print(tuple())
for t in [int, str, float, list, tuple, bytearray]:
    print(t.__name__)
    class A(t):
        pass
    a = A()
    b = A(t())
    print(a == b)
    print(b == a)


# types without a __new__ function yet
for t in [set, dict, complex]:
    print(t.__name__)
    class B(t):
        pass
    b = B()
    print(b == b)


class B(object):
    pass

b = B()

