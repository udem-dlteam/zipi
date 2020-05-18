class Opener:
    def __enter__(self):
        print("opened!")
        return self

    def __exit__(self, exc_type, exc_value, exc_traceback):
        if exc_type:
            print("Wow!, a", exc_type.__name__, "was raised")
        print("exited!")

    def __str__(self):
        return "Yes, I am an Opener object!"

class Silencer:
    def __init__(self, excs):
        self.excs = excs

    def __enter__(self):
        return None

    def __exit__(self, exc_type, exc_value, exc_traceback):
        if exc_type in self.excs:
            print("Silencing exception")
            return True


with Opener() as o:
    print("inside!")
    print(o)
    print("ok, about to leave now")

with Silencer([ValueError]):
    raise ValueError
