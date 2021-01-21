l = [1, 1.0, True, 2, 2.0]

for x in l:
    for y in l:
        print(x, "==", y, x == y)
        print(x, "!=", y, x != y)
        print(x, "<=", y, x <= y)
        print(x, "<", y, x < y)
        print(x, ">=", y, x >= y)
        print(x, ">", y, x > y)
