class A:
    def foo(self):
        print("A.foo")

    def bar(self):
        print("A.bar")


class B(A):
    def foo(self):
        print("B.foo")

class C:
    def foo(self):
        print("C.foo")

    def bar(self):
        print("C.bar")


for t in [A, B, C, A, B, C]:
    instance = t()
    t.foo(instance)
    instance.foo()
    t.bar(instance)
    instance.bar()
