def hello():
    yield 1
    yield 2

for x in hello():
    print(x)
