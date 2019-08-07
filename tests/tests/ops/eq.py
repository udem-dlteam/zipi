# int
print(10 == 20)
print(10 == 10)

# bool
print(True == True)
print(True == False)
print(False == True)
print(False == False)

# float
print(0.3 == 0.2)
print(0.1 + 0.2 == 0.3)
print(0.3 == 0.3)

# string
print("Hello" == "World")
print("Hello" == "Hello")

# object
class Pair:
    def __init__(self, first, second):
        self.first = first
        self.second = second

    def __eq__(self, other):
        print("PairEq")
        if other.__class__.__name__ == self.__class__.__name__:
            if self.first == other.first:
                return self.second == other.second
            else:
                return False
        else:
            return False

class PairNoEq:
    def __init__(self, first, second):
        self.first = first
        self.second = second


p1 = Pair(1, 2)
p2 = Pair(1, 3)
p3 = Pair(1, 2)
p4 = PairNoEq(1, 2)

print(p1 == p1)
print(p1 == p2)
print(p1 == p3)
print(p1 == p4)
print(p2 == p1)
print(p2 == p2)
print(p2 == p3)
print(p2 == p4)
print(p3 == p1)
print(p3 == p2)
print(p3 == p3)
print(p3 == p4)
print(p4 == p1)
print(p4 == p2)
print(p4 == p3)
print(p4 == p4)

# mixed

print(True == 10)
print(True == 1)
print(10 == False)
print(0 == False)

print(10 == 10.1)
print(10 == 10.0)
print(10.1 == 10)
print(10.0 == 10)

print(0.0 == False)
print(0.1 == False)
print(True == 1.0)
print(True == 1.1)

print("Hello" == 0)
print(3.14 == "pi")


print(p1 == 10)
print(10.0 == p1)
print(p4 == "10")
print(False == p4)
print("hello" == p4)
