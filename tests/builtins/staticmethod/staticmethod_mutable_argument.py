# Some optimizations for skipping method binding duplicate the function object
# for calling it in different context. We check that the duplicate share the same
# mutable arguments

class A:
    @staticmethod
    def f(x, l=[]):
        l.append(x)
        print(l)

a = A()

f = a.f
a.f(1)
f(2)
a.f(3)
f(4)
