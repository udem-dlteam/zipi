class Foo:
    def __getattribute__(self, name):
        if name == 'x':
            return 1
        else:
            raise AttributeError

    def __getattr__(self, name):
        return 2

foo = Foo()

print(foo.y) # prints 2
