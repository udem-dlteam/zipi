class A:
    def foo(self):
        print("A.foo")

    def bar(self):
        print("A.bar")


class B(A):
    def foo(self):
        print("B.foo")


for t in [A, B, A, B]:
    instance = t()
    t.foo(instance)
    instance.foo()
    t.bar(instance)
    instance.bar()
