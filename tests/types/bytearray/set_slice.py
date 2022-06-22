# Set slice to iterable
l3 = bytearray()
l3[:] = range(10)
for i in l3:
    print(i)

l3[:5] = [0, 0, 0, 0, 0]
for i in l3:
    print(i)

l3[7:1:-2] = (1, 2, 3)
for i in l3:
    print(i)
