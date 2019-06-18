
def g():
    yield 1
    yield 2
    yield 3
    return 4

i = g();

print (next(i))
print (next(i))
print (next(i))
print (next(i))
print (next(i))

    
