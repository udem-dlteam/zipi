def f(a):
    b = 20
    c = 30

    l1 = locals()
    print(l1)

    del b
    
    l2 = locals()
    print(l2)

    print(l1==l2)

f(10)    
    
