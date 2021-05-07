def f():
    yield 1
    yield 2

g = f()
next(g)
g.close()
next(g)
