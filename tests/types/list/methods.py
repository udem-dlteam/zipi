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

l2 = [1, 1, 2, 3, 4, 5, 1]
print(l2.count(1))
print(l2.count(2))
print(l2.count(10))

print(l2.index(1))
print(l2.index(5))

l2.pop()
l2.append(2)

print(l2.count(1))
print(l2.count(2))
print(l2.count(10))
