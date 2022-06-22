y=bytearray(5)

# mul

print(len(y))
print(len(y*3))
for i in y*3:
    print(i)

# imul
y*=3
for i in range(-len(y), len(y)):
    print(y[i])
