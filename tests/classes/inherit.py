class A:
    def __init__(self):
        print('A.__init__ called')
        self.x = 11

    a = 22

class B(A):
    b = 33

print(A.__class__ is type)

print(B.__class__ is type)

o = B()

print(o.__class__ is B)

print(A.a)
print(B.b)

print(o.a)
print(o.b)
print(o.x)

print('---------------')

A.a = 44

print(A.a)
#print(B.a) # B's a attribute should be inherited from A
print(o.a)

print('---------------')

B.a = 55

print(A.a)
print(B.a)
print(o.a)

print('---------------')

o.a = 66

print(A.a)
print(B.a)
print(o.a)
