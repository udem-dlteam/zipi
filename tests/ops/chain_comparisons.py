#order of evaluation

print("first") == print("second") == print("last")
print("first") == print("second") != print("last")


values = [True, 1, 2, 3, 2.5]

for x in values:
    for y in values:
        for z in values:
            print("<", x, y, z, x < y < z)

            if x < y < z:
                print("ok!")
            else:
                print("nope!")

            print(">", x, y, z, x > y > z)

            if x > y > z:
                print("ok!")
            else:
                print("nope!")

            print("< ==", x, y, z, x < y == z)

            if x > y == z:
                print("ok!")
            else:
                print("nope!")

            print("!= >=", x, y, z, x != y >= z)

            if x != y >= z:
                print("ok!")
            else:
                print("nope!")
