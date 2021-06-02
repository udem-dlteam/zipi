def g(y):
    it = list(range(y))
    for x in it:
        yield x

for x in g(10):
    print(x)
