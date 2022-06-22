#test comparison

a = bytearray(4)
b = bytearray(4)
a[0] = 1
a[1] = 2
a[2] = 3
a[3] = 4
b[0] = 1
b[1] = 2
b[2] = 3
b[3] = 4


print(a < b)
print(a > b)
print(a <= b)
print(a >= b)
print(a == b)
print(a != b)

a.append(5)

print(a < b)
print(a > b)
print(a <= b)
print(a >= b)
print(a == b)
print(a != b)

b.append(6)

print(a < b)
print(a > b)
print(a <= b)
print(a >= b)
print(a == b)
print(a != b)
