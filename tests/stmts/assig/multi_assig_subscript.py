l1 = [1, 2, 3]
l1[0], foo, l1[1] = range(3)
print(l1, foo)

l2 = [1, 2, 3]
l2[0], foo, l2[1] = l2
print(l2, foo)
