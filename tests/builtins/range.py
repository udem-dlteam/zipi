r = range(5)

i = iter(r)

x = next(i, 999)

while x != 999:
    print(x)
    x = next(i, 999)
