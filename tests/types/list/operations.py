print([1, 2, 3])
print([1, 2, 3] + [1, 2, 3])
print([1, 2, 3] + [])
print([] +  [1, 2, 3])
print([1, 2, 3] + [4, 5, 6] + [7, 8, 9])

print([1, 2, 3] * 5)
print(4 * [6, 7, 8])
print(2 * [])
print(0 * [1, 2, 3])

l = [1, 2, 3]
print(len(l))
print(len(l + l))
print(len(8 * l))
print(len([]))
print(len([] * 9))
print(len(l + l + 8 * l))
print(len(l * 0))
