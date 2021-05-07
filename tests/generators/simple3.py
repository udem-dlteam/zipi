def hello():
    yield 1
    yield 2
    yield 3

g1 = hello()
g2 = hello()

print(next(g1))
print(next(g2))
print(next(g2))
print(next(g1))

for x in g1:
    print(x)

for x in g2:
    print(x)
