class Foo:
    pass

class Bar:
    pass

foo = Foo()

foo.__class__ = Bar # This is valid and it does change the TypeError

foo.__class__ = int # TypeError: __class__ assignment only supported for heap types or ModuleType subclasses
