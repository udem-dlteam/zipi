# and

print(0b1100 & 0b1010)
print(0b0011 & 0b0010)
print(0b1111111111111111 & 0b1101010001)
print(0b0 & 0b11111111111)

for i in range(10):
    for j in range(10):
        print(i & j)

# or

print(0b1100 | 0b1010)
print(0b0011 | 0b0010)
print(0b1111111111111111 | 0b1101010001)
print(0b0 | 0b11111111111)

for i in range(10):
    for j in range(10):
        print(i | j)

# xor

print(0b1100 ^ 0b1010)
print(0b0011 ^ 0b0010)
print(0b1111111111111111 ^ 0b1101010001)
print(0b0 ^ 0b11111111111)

for i in range(10):
    for j in range(10):
        print(i ^ j)

# lshift

print(0b1 << 0)
print(0b1 << 1)
print(0b1 << 2)
print(0b1 << 256)

# rshift

print(0b10101010000111001010 >> 0)
print(0b10101010000111001010 >> 1)
print(0b10101010000111001010 >> 2)
print(0b10101010000111001010 >> 256)

# inverse

print(~0b01)
print(~0b0101)
print(~0b0100)
print(~10)


