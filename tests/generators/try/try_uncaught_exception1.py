def f():
    try:
        yield "try"
        raise ValueError
    except AttributeError:
        yield "except"
    finally:
        yield "finally"

for x in f():
    print(x)
