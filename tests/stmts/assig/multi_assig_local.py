def f(a, b, c):
    a, b, c = range(3)
    print(a, b, c)

f(1, 2, 3)

def g(x, mid, z):
    x, *mid, z = range(10)
    print(x, mid, z)

g(1, 2, 3)
