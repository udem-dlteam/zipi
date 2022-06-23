class A:
    @classmethod
    def f(cls):
        print(cls.__name__)

class B(A):
    pass

a = A()
b = B()

a.f()
b.f()
