# Test existence of BaseException
print(BaseException)

class MyException(BaseException):
    pass

raise MyException
