def f():
    for cmd in range(4):
        x = 0
        while x < 10:
            try:
                if cmd == 0:
                    yield "break0"
                    break
                elif cmd == 1:
                    yield "continue1"
                    continue
                elif cmd == 2:
                    yield "AttributeError2"
                    raise AttributeError
                else:
                    yield "ValueError3"
                    raise ValueError
            except AttributeError:
                yield "caught AttributeError"
            except ValueError:
                yield "caught ValueError"
                break
            else:
                yield "no exception!"
            finally:
                x += 1
                yield "finally"

for x in f():
    print(x)
