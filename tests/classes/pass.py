class A:
    pass

class B:
    pass

print(A.__class__ is type)
print(B.__class__ is type)

print(A().__class__ is A)
print(A().__class__ is B)
print(B().__class__ is A)
print(B().__class__ is B)
