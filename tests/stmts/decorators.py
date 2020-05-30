def decorator1(f):
    def g(x):
        print('in decorator1')
        return f(x)
    return g

def decorator2(f):
    def g(x):
        print('in decorator2')
        return f(x)
    return g

@decorator1
@decorator2
def f(x):
    print(x)

f(1)
f(2)
f(3)
