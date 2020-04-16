print(slice(1).indices(10))
print(slice(1, 4).indices(10))
print(slice(1, 6, 2).indices(10))

print(slice(-3).indices(10))
print(slice(-6, -2).indices(10))
print(slice(9, 3, -1).indices(10))


print(slice(-9, -3, 1).indices(10))
print(slice(9, 3, 1).indices(10))
