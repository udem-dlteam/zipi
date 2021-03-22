"""Supporting definitions for the Python regression tests."""

if __name__ != 'test.support':
    raise ImportError('support must be imported from the test package')


def run_unittest(x):
    __import__("unittest")._run_tests(x)

def cpython_only(x):
    return x
