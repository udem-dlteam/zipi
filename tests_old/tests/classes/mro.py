print(object)            # <class 'object'>
print(object.__name__)   # object
print(object.__module__) # builtins
print(object.__mro__)    # (<class 'object'>,)
print(object.__bases__)  # ()

print(int)            # <class 'int'>
print(int.__name__)   # int
print(int.__module__) # builtins
print(int.__mro__)    # (<class 'int'>,)
print(int.__bases__)  # (<class 'object'>,)

print(bool)            # <class 'bool'>
print(bool.__name__)   # bool
print(bool.__module__) # builtins
print(bool.__mro__)    # (<class 'bool'>,)
print(bool.__bases__)  # (<class 'int'>, <class 'object'>)

class A:
    pass

print(A)            # <class '__main__.A'>
print(A.__name__)   # A
print(A.__module__) # __main__
print(A.__mro__)    # (<class '__main__.A'>, <class 'object'>)
print(A.__bases__)  # (<class 'object'>,)

class B(A):
    pass

print(B)            # <class '__main__.B'>
print(B.__name__)   # B
print(B.__module__) # __main__
print(B.__mro__)    # (<class '__main__.B'>, <class '__main__.A'>, <class 'object'>)
print(B.__bases__)  # (<class '__main__.A'>,)


class C(A):
    pass

print(C)            # <class '__main__.C'>
print(C.__name__)   # C
print(C.__module__) # __main__
print(C.__mro__)    # (<class '__main__.C'>, <class '__main__.A'>, <class 'object'>)
print(C.__bases__)  # (<class '__main__.A'>,)

class D(B, C):
    pass

print(D)            # <class '__main__.D'>
print(D.__name__)   # D
print(D.__module__) # __main__
print(D.__mro__)    # (<class '__main__.D'>, <class '__main__.B'>, <class '__main__.C'>, <class '__main__.A'>, <class 'object'>)
print(D.__bases__)  # (<class '__main__.B'>, <class '__main__.C'>)
