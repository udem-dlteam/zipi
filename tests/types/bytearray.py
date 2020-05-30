
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

#append

y=bytearray()
for i in range (0, 255):
    y.append(i)

for i in range(-255, 254):
    print(y[i])

# mul

print(len(y))
print(len(y*5))
z=y*5
for i in range(len(y*5)):
    print(z[i])

# imul
y*=5
for i in range(-len(y), len(y)):
    print(y[i])

#add

x1 = []
for i in range(1, 3):
    b=bytearray(i)
    b[0]=1
    b[-1]=1
    x1.append(b)

for i in range(2):
    for j in range(2):
        z=x1[i]+x1[j]
        for k in range(len(z)):
            print(z[k])

#iadd 

x=bytearray()
for i in range(255):
    x.append(255-i-1)

x+=bytearray(0)
x+=bytearray(1)
x+=y

for i in range(len(x)):
    print(x[i])

#slice get


l2 = bytearray(4)
l2[0] = 1
l2[1] = 2
l2[2] = 3
l2[3] = 4

#desole pour la syntaxe illisible
for start in range(-5, 5):
    for stop in range(-5, 5):
        for step in range(1, 2):
            tests = [l2[start:stop:step],
                    l2[:stop:step],
                    l2[start::step],
                    l2[start:stop],
                    l2[::step],
                    l2[start::]]
            for test in tests:
                for ii in range(len(test)):
                    print(test[ii])

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


