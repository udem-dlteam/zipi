#append

y=bytearray()
for i in range (0, 255):
    y.append(i)

for i in range(-255, 254):
    print(y[i])
