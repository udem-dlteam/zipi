
class TestBase:
    def __len__(self):
        return 10

class TestClass(TestBase):
    def __len__(self):
        return 20

class TestNoLen:
    pass

def funlen(self):
    return 30

foo = TestBase()
bar = TestClass()
baz = TestNoLen()

print(len(foo))
print(foo.__len__())

print(len(bar))
print(bar.__len__())

baz.__class__.__len__ = funlen
print(len(baz))
print(baz.__len__())
print(len(TestNoLen()))
print(TestNoLen().__len__())

print(len([1, 2, 3]))
print(len((1, 2, 3, 4)))
