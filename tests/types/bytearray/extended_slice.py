# Extended slices
l1=bytearray()
for i in [1,2,3,4,5,6]:
    l1.append(i)

for i in l1:
    print(i)

l1[1:4:2] = [9, 10]
for i in l1:
    print(i)

l1[-1::-2] = [0, 1, 2]
for i in l1:
    print(i)

l1[::-1] = [0, 0, 0, 0, 0, 0]
for i in l1:
    print(i)

l1[1:3:-1] = []
for i in l1:
    print(i)

l1[5:0:-3] = [11, 12]
for i in l1:
    print(i)
