class Foo:
    def method(self):
        print('hello world!')

foo = Foo()

foo.method() # binding is done implicitly
Foo.method.__get__(foo, Foo)() # mechanic of the above

foo.__class__.method(foo) # binding must be done exlicitly
Foo.method.__get__(None, Foo)(foo) # mechanic of the above
