class A:
    def f(self):
        print(2)

class B(A):
    def f(self):
        print(1)
        super(B, self).f()
        print(3)

class C(B):
    def g(self):
        super(C, self).f()
        print(4)

C().g()
