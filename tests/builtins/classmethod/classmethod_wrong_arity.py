class A:
    @classmethod
    def f(cls, x):
        print(cls, x)

a = A()

a.f(1, 2)
