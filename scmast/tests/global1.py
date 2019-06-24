def f( x ):
    global a;
    a = 30
    print ("a1=", a)

try:    
    print ("a2=", a)
except:
    print ("ok")
