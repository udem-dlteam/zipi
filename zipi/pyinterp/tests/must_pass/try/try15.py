def trying():
    try:
        1//0
    except Exception as e:
        return e
    else:
        print("hello")
    finally:
        print("hello 2")
print(trying())
