def f(x, y):
    print(x, y)

f(y=2, x=1)
f(2, y=3)


def g(x, y, **kwargs):
    print(x, y, list(kwargs))

g(y=2, x=1)
g(2, y=3)
g(1, 2, z=4)
g(y=1, x=2, z=4)
g(3, z=5, y=4, a=10)
g(1, 2, a=1, b=2, c=3, d=4)
g(1, 2, b=1, d=2, c=3, a=4)
