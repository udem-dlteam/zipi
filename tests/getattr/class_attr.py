class A:
    def __init__(self, x):
        self.x = x

    def get_x(self):
        return self.x

    def get_y(self):
        return self.y

a = A(42)
a.y = 24

print(a.get_x() + a.get_y())
