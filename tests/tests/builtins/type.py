
class MyTest:
    pass

print(type)

print(type(1))
print(type(float))
print(type(MyTest))
print(type(MyTest()))
print(type([1, 2, 3]))
print(type("Hello"))

foo = MyTest()
print(type(foo))
print(foo.__class__)
print(type(foo) is foo.__class__)
print(foo.__class__.__class__ == foo.__class__.__class__.__class__.__class__.__class__)
