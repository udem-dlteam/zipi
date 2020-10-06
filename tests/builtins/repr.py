print(repr(123))
print(repr(repr(123)))
print(repr("hello\n"))
print(repr('hello\n'))
print(repr('\'"'))
print(repr('a"b'))
print(repr("a'b"))
 #print(repr("\xff"))
 #print(repr("\U0000ffff"))

l1 = []
l1.append(l1)
print(l1)
l1.append([])
print(l1)

l2 = []
t2 = (l2,)
l2.append(t2)
print(l2)
print(t2)

