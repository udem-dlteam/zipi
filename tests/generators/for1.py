def closed_range(start, stop):
    yield "start"
    for x in range(start, stop):
        yield x
    yield 999

for y in closed_range(3, 8):
    print(y)
