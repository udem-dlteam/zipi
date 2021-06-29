def g():
    def f(x):
        return True

    if not f(1):
        print("foo")
    else:
        print("bar")

g()

def f2(x):
    return False

if not f2(1):
    print("foo")
else:
    print("bar")
