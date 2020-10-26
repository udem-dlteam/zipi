sample = [
    "",
    " ",
    "foo",
    "Foo",
    "FOO",
    "123",
    "-",
    "123abc",
    "12.34",
    "£",
    "〻",
    "¯\_(ツ)_/¯",
]

for c in range(256):
    sample.append(chr(c))

for word in sample:
    print(word)
    print(word.isascii())