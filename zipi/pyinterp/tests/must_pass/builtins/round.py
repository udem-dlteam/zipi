for sign in (-1, 1):
    for x in (0, 1,2,3,4,5,6,7,8,9,10):
        for y in (1,2,3,4,5,6,7,8,9,10):
            z = sign * (x * 10 + y)
            for r in (-3, -2, -1, 0, 1, 2, 3):
                print(round(z, r))