# list

def test_getitem(full, empty):
    
    # int
    print(full[0])
    try:
        full[10]
    except IndexError as e:
        print(e)

    #bool
    print(full[True])
    print(full[False])

    try:
        empty[True]
    except IndexError as e:
        print(e)

    try:
        empty[False]
    except IndexError as e:
        print(e)

    # slice
    print(full[0:1])
    print(full[0:100:2])

test_getitem([1, 2, 3, 4, 5], [])
test_getitem((1, 2, 3, 4, 5), ())
test_getitem("abcde", "")








