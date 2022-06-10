# round

print(round(0.))
print(round(1.))
print(round(0.00000000001))
print(round(182482083.387429834))
print(round(-01282930.134134))

print((0.).__round__())
print((1.).__round__())
print((0.00000000001).__round__())
print((182482083.134).__round__())
print((-01282930.6789).__round__())


# trunc

print((0.).__trunc__())
print((1.).__trunc__())
print((0.00000000001).__trunc__())
print((182482083.124124).__trunc__())
print((-01282930.124124).__trunc__())

# is integer

print(0.1.is_integer())
print(0.0.is_integer())
print(0.118723891230.is_integer())
print(-19201930.1313.is_integer())
print(-2341289414124.000000000000000000000000.is_integer())
print(-1023801932.0000000000000000000000001.is_integer())
print(0.999999999999999.is_integer())
