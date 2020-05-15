
# test de bytearray avec un seul argument

a = bytearray(255)
b = bytearray(300)
c = bytearray(0)
d = bytearray(-10)
e = bytearray("crash")
f = bytearray(0.1)
g = bytearray(-0.00001)
h = bytearray()
# set item

a[10] = 3
a[-4] = 300
a[3] = 1500
a[8] = 4
a[3] = 0

c[0] = 1

a[254] = 0
a[255] = 0
a[256] = 0

a[-254] = 0
a[-255] = 0
a[-256] = 0

a["hello"] = 3
a[0.3] = 3
a[3:2:2] = 3


# get item

z = a[-4]
y = a[300]
x = a[0.1]


g = 1
for i in range(0, 255):
    g += a[i]

y=bytearray()
for i in range (0, 255):
    y.append(i)

for i in range(-260, 257):
    print(y[i])
