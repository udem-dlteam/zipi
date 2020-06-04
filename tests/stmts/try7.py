def f():
    try:
        return 1
    except:
        pass
    finally:
        return 2

print(f())

def f():
    try:
        return 1
    except:
        pass
    finally:
        if False:
            return 2

print(f())
