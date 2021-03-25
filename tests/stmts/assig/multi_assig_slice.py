lst = [None, None, None, None, None]

lst[0], *lst[2:3], lst[4] = range(10)
