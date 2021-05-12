def f():
    for x in range(10):
        yield x
        try:
            yield "try"
            continue
        except:
            yield "except"
        finally:
            yield "finally"
            break

for x in f():
    print(x)
