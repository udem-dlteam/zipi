try:
    raise 0
except ValueError:
    print("Cannot raise object which is not subclass of BaseException")
