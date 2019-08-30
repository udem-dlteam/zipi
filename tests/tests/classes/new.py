class A:
    pass

class B:
    def __init__(self, x):
        print('B.__init__ called')
        self.x = x

class C:
    def __new__(cls):
        print('C.__new__ called')
        return 10

class D:
    def __new__(cls):
        print('D.__new__ called')
        return C()
    def __init__(self):
        print('D.__init__ called')

print(object.__new__(A).__class__)

print(A.__new__ is object.__new__)
print(A.__init__ is object.__init__)
print(B.__new__ is object.__new__)
print(B.__init__ is object.__init__)
print(C.__new__ is object.__new__)
print(C.__init__ is object.__init__)
print(D.__new__ is object.__new__)
print(D.__init__ is object.__init__)


a = A()
b = B(10)
c = C()
d = D()

print(a.__class__)
print(b.__class__)
print(c.__class__)
print(d.__class__)
