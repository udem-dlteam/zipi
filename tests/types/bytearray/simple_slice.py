# Simple slices (step=1)
l2=bytearray()
for i in [1,2,3,4,5,6,7,8]:
    l2.append(i)
for i in l2:
    print(i)
l2[0:3] = [11, 12, 13]
for i in l2:
    print(i)

l2[0:3] = [1, 2, 3, 4, 5, 6]
for i in l2:
    print(i)

l2[0:3] = [42]
for i in l2:
    print(i)

l2[:] = [9, 8, 7]
for i in l2:
    print(i)

l2[::-1] = [10, 11, 12]
for i in l2:
    print(i)
