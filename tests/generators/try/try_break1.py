def f():
    for x in range(10):
        yield x
        try:
            yield "try"
            break
        except:
            yield "except"
        finally:
            yield "finally"

for x in f():
    print(x)
