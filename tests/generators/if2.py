def test1():
    if (yield "test"):
        print("then")
    else:
        print("else")
    yield "end"

g1 = test1()

for z in g1:
    print(z)

g2 = test1()

print(next(g2))
print(g2.send(True))
for w in g2:
    print(w)
