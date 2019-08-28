class MyNumber:
    def __init__(self, x):
        self.x = x

    def __add__(self, oth):
        return self.x + oth.x

print("aa" + "bb")
print("aa" + "bb" == "aabb")

print(10 + 20)
print(10 + 20.5)
print(10.5 + 20)
print(10.5 + 20.5)

print(True + True)
print(True + False)
print(False + True)
print(False + False)

print(True + 10)
print(10 + True)
print(False + 10)
print(10 + False)

n1 = MyNumber(10)
n2 = MyNumber(100)

print(n1 + n2)
print(n2 + n1)
