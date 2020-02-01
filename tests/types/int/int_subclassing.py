class MyInt(int):
    def __add__(self, other):
        return MyInt(int(self) + int(other) + 1)

print(MyInt(1) + MyInt(2))
print(MyInt(1) - MyInt(2))
