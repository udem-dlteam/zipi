class Foo:
    def __getattr__(self, name):
        return 'default'

foo = Foo()

foo.y = 7

print(foo.x) # prints 'default'
print(foo.y) # prints 7
