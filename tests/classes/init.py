class A:
    def __init__(self):
        print('A.__init__ called')
        self.x = 11

o = A()

print(A.__class__ is type)
print(o.__class__ is A)

print(o.x)
