

tests = ["_", "@", "a", "1", "100", "Z", "z", "A", "", "", "ÿ", "aa"]

for a in tests:
    for b in tests:
        print(a == b)
        print(a != b)
        print(a < b)
        print(a <= b)
        print(a > b)
        print(a >= b)

print(sorted(tests))
print(sorted(["1", "2", "", "ÿ", "", "þ" , "" ]))
print(sorted(["1", "2", "_", "_ÿ", "_","þ_", ""]))
print(sorted(["11111", "1111", "111", "11", "1",""]))
