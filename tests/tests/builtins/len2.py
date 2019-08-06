
class MyTest:
    pass

def test(self):
    return 10

foo = MyTest()
foo.__len__ = test

print(len(foo)) # run time error
