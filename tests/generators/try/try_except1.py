def f():
    try:
        yield "try"
        raise ValueError
    except AttributeError:
        yield "Attribute"
    except ValueError:
        yield "Value"
    finally:
        yield "finally"

for x in f():
    print(x)
