def hello():
    yield (yield 42)

for x in hello():
    print(x)

gen = hello()

print(next(gen))
print(gen.send("foo"))
