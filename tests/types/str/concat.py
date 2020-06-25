s0 = ""
s1 = "foo"
s2 = "bar"
s3 = "baz"

print(s0)
print(s1)
print(s2)
print(s3)

s4 = s1 + s2
s5 = s2 + s3
s6 = s3 + s1 + s0 + s3 + s2

print(s4)
print(s5)
print(s6)

print(s4 == s1 + s2)
print(s5 == s2 + s3)
print(s6 == s3 + s1 + s0 + s3 + s2)

print(s5 == s1 + s2)
print(s6 == s2 + s3)
print(s1 == s0)
