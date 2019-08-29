class Empty:
    pass

class A:
    def __init__(self, x):
        print('A.__init__ called')
        self.x = x

# check __init__ identity
print(Empty.__init__ is object.__init__)
print(A.__init__ is object.__init__)

# test object __init__
print(object.__init__(1, 2))
print(object.__init__(1))

# test default __init__
empty = Empty()
print(empty.__class__)
print(empty.__init__())

# test defined __init__
o = A(10)
print(A.__class__ is type)
print(o.__class__ is A)
print(o.x)
o.x = 100
print(o.x)
o.__init__(20)
print(o.x)
