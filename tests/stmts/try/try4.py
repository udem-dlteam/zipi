try:
    raise ValueError("foo bar baz")
except ValueError:
    print("in except block")
    raise ValueError

# Unreachable
print(1)
