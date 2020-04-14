l = [1, 2, 3]
print(l[0])
print(l[1])
print(l[2])
print(l[-1])
print(l[-2])
print(l[-3])

l[0] = 42
l[-1] = 43

print(l)

del l[0]

print(len(l))
print(l)

del l[-1]

print(len(l))
print(l)

del l[0]

print(l)
