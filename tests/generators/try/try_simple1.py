def f():
    try:
        yield "try"
    except:
        yield "except"
    else:
        yield "else"
    finally:
        yield "finally"

for x in f():
    print(x)
