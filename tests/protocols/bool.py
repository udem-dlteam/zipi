class foo(object):
    def __bool__(self):
        return False

bool(foo())
