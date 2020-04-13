l = [1,2,3]
l2 = l.copy()

print(l.pop())
print(len(l))
print(l)

print(l.pop(0))
print(len(l))
print(l)

print(l.pop())
print(len(l))
print(l)

l.append(9)
print(len(l))
print(l)

l.append(42)
print(len(l))
print(l)

l.pop(1)
print(len(l))
print(l)

l.clear()

print(l)
print(l2)
