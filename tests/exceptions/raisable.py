try:
    raise []
except TypeError:
    print("Cannot raise object which is not subclass of BaseException")
