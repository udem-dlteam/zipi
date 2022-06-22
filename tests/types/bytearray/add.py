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
y = bytearray(6)
x+=y

for i in range(len(x)):
    print(x[i])

# iadd

x = bytearray(10)
y = bytearray(5)

print(x)
print(y)

x_ref = x
x += y

print(x)
print(len(x))
print(x_ref)
print(len(x_ref))

print(x)
print(y)
