# Make sure the compiler does not look when trying to guess A's hclass

class A(A):
    pass
