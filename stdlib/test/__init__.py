support = object()
support.cpython_only = lambda x:x

support.run_unittest = __import__("unittest")._run_test
