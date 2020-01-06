class B:
    def f(self, x):
        print(x)

class A(B):
    def f(self, x):
        super().f(x)
        pass

# expected: prints 1
A().f(1)
