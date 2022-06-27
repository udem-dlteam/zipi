class A:
    def __init__(self, c):
        self.c = c

def __setattr__(self, name, val):
    object.__setattr__(self, name, val + 100)

for i in range(10):
    if i == 5:
        A.__setattr__ = __setattr__

    a = A(3)

    print(a.c)

    a.c = 4

    print(a.c)
