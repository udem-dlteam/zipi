# Test existence of BaseException
print(BaseException)

raise BaseException

class MyException(BaseException):
    pass

MyException()
