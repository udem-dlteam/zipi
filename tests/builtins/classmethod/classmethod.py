class A:
    @classmethod
    def f(cls, x):
        print(type(cls) is A, x)

a = A()

a.f(1)
