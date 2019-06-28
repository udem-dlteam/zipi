class A:
    pass

class B:
    pass

print(A)
print(A.__module__)
print(A.__name__)

print(A().__class__ is A)
print(A().__class__ is B)
print(B().__class__ is A)
print(B().__class__ is B)
