
def f():
    print ("in f")
    yield 1
    print ("after yield1")
    print ("y2=", (yield 2))
    print ("y3=", (yield 3))
    return 4

g = f();

print ("n1=", g.__next__())
print ("n2=", g.__next__())
print ("ns=", g.send(43))
print ("n3=", next(g))


    
