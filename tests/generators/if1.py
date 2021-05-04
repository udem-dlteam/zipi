def test1(x):
    yield "starting"
    if x > 0:
        yield "x > 0"
    else:
        yield "x <= 0"
    yield "ending"

g1 = test1(-5)
g2 = test1(5)

for x in g1:
    print(x)

for y in g2:
    print(y)

def test2():
    if (yield "test"):
        yield "then"
    else:
        yield "else"

g3 = test2()

for z in g3:
    print(z)

g4 = test2()

print(next(g4))
print(g4.send(True))
for w in g4:
    print(w)
