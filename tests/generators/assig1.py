def do():
    command = yield "Starting!"
    while True:
        if command == "exit":
            yield "exiting now, don't send anything else"
            return
        else:
            command = yield "I am doing: " + command

doer = do()

print(next(doer))
print(doer.send("eat"))
print(doer.send("fly"))
print(doer.send("sleep"))
print(doer.send("exit"))

for foo in doer:
    print(foo)
