strings = ["", "foo", "bar", "foobar", "bar fofofo bar", "1234", "11234"]
substrings = ["", "f", "1", "bar", "4", "ar", "o"]
starts = [-10, -2, -1, 0, None, 1, 2, 3, 10]
stops = [-10, -2, -1, 0, None, 1, 2, 3, 10]

for st in strings:
    for sub in substrings:
        for i in starts:
            for j in stops:
                print(st, sub, i, j)
                print(st.count(sub, i, j))