def f():
    try:
        yield "try"
        raise ValueError
    except:
        yield "except"
    finally:
        yield "finally"

for x in f():
    print(x)
