class A:
    a = 11
    o = 22 # should not resolve to global o (same scoping rule as when in def)

o = A()

print(A.a)
print(A.o)
