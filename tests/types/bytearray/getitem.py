# test de bytearray avec un seul argument

a = bytearray(255)
b = bytearray(300)
c = bytearray(0)
h = bytearray()
# set item

a[10] = 3
a[8] = 4
a[3] = 0

a[254] = 0

a[-254] = 0
a[-255] = 0

# get item

z = a[-4]


g = 1
for i in range(0, 255):
    g += a[i]

print(a)
print(b)
print(c)
print(h)
print(z)
print(g)
