def g(x):
    for x in range(x):
        yield "loop"
        if x == 5:
            break
    else:
        yield "no break"
        return
    yield "break"

for x in g(10):
    print(x)

for x in g(3):
    print(x)
