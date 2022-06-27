# Make sure the compiler does not look when trying to guess hclasses

class A(B):
    pass

class B(A):
    pass
