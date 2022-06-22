l2 = bytearray(4)
l2[0] = 1
l2[1] = 2
l2[2] = 3
l2[3] = 4

for start in range(-5, 5):
    for stop in range(-5, 5):
        for step in range(1, 2):
            tests = l2[start:stop:step] + l2[:stop:step] + l2[start::step] + l2[start:stop] + l2[::step] + l2[start::]
            for byte in tests:
                print(byte)
