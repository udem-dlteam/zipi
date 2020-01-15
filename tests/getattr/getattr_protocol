class Prop:
    def __get__(self, instance, owner):
        if owner is None:
            print('property recovered on class')
            return 3
        else:
            print('property recovered on instance')
            return 4

class Foo:
    def __getattribute__(self, name):
        print('called __getattribute__')
        return 1

class Bar:
    def __getattr__(self, name):
        print('called __getattr__')
        return 2

class Baz:
    prop = Prop()

print(Foo().x)
print(Bar().y)
print(Baz.prop)
print(Baz().prop)
