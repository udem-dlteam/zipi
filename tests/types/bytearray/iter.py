b = bytearray(300)
b[0] = 5
b[50] = 42
b[-3] = 111

for y in b:
    print(y)
