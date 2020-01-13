
def foo(b):
    a = 5
    def gee():
        nonlocal a
        a = 3;
    gee()
    return a

print(foo(1))
