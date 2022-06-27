class A:
    def __init__(self, c):
        self.c = c


for _ in range(10):
    a = A(3)

    print(a.c)

    a.c = 4

    print(a.c)
