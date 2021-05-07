def g(x):
    for x in range(x):
        if x == 5:
            yield "continue"
            continue
        yield "loop"
    else:
        yield "no break"
        return
    yield "break"

for x in g(10):
    print(x)

for x in g(3):
    print(x)
