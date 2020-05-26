class A:
    def __hash__(self):
        return 42

print(hash(A()))
print(hash(3))
print(hash(4))
print(hash(5))
print(hash(2** 70))
print(hash(-(2** 70)))
