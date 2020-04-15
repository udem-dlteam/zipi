l1 = [1, 2, 3]
print(l1[0])
print(l1[1])
print(l1[2])
print(l1[-1])
print(l1[-2])
print(l1[-3])

l1[0] = 42
l1[-1] = 43

print(l1)

del l1[0]

print(len(l1))
print(l1)

del l1[-1]

print(len(l1))
print(l1)

del l1[0]

print(l1)

l2 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
print(l2[0:5])
print(l2[2:])
print(l2[:7])
print(l2[3:8:2])
print(l2[6:0:-1])
print(l2[6:0:-2])
print(l2[::-1])
print(l2[4:1])
print(l2[::])
l3 = l2[:]
l3[0] = 42
print(l2, l3)
