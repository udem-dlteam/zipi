class A:
    x = 1

    def __init__(self):
        self.y = 2

a = A()
print(getattr(a, "x"))
print(getattr(a, "y"))
print(getattr(a, "z", 10))
