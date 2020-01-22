try:
    raise 0
except TypeError:
    print("Cannot raise object which is not subclass of BaseException")
