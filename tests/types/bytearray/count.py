# count

x=bytearray(10)
x[0] = 10
x[2] = 3


print(x.rfind(10))
print(x.rfind(10, 2, 3))
print(x.rfind(0))
print(x.rfind(0, 3))
print(x.rfind(3))
print(x.rfind(3, 3, 3))
print(x.find(10))
print(x.find(10, 2, 3))
print(x.find(0))
print(x.find(0, 3))
print(x.find(3))
print(x.find(3, 3, 3))
print(x.index(10))
print(x.index(0))
print(x.index(0, 3))
print(x.index(3))
print(x.rindex(10))
print(x.rindex(0))
print(x.rindex(0, 3))
print(x.rindex(3))
