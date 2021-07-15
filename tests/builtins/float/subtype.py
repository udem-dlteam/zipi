class A(float):
    pass

a = A(0.0)
b = A(1.0)
c = A(2.0)

for x in [a, b, c]:
    for y in [a, b, c]:
        print(x == y)
