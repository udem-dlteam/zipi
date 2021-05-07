def g(x):
    while x < 10:
        yield x
        x += 1

for y in g(0):
    print(y)
