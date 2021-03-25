class foo(object):
    def __bool__(self):
        return self

bool(foo())
