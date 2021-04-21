class A:
    def foo(self):
        print("A.foo")

    def bar(self):
        print("A.bar")


class B(A):
    def foo(self):
        print("B.foo")

a = A()
b = B()

for _ in range(2):
    a.foo()
    A.foo(a)
    b.foo()
    B.foo(b)

for _ in range(2):
    a.bar()
    A.bar(a)
    b.bar()
    B.bar(b)
