# File: test1.py

# Expressions

x
42
"a"
"a" "b"
...
None
True
False

f ( )
f ( x )
f ( x , )
f ( x , y )
f ( x , y , z )
f ( x , y , z , )

t [ x ]
t [ x , ]
t [ x , y ]
t [ x , y , z ]
t [ x , y , z , ]

obj . x

obj . f ( x ) [ y ] . x

x if y else z

x or y
x or y or z

x and y
x and y and z

not x
not not x

x < y
x > y
x == y
x <= y
x >= y

x < y > z
x > y < z
x == y < z
x <= y < z
x >= y < z

x | y
x | y | z

x ^ y
x ^ y ^ z

x & y
x & y & z

x << y
x >> y
x << y >> z

x + y
x - y

x + y - z

x * y
x @ y
x / y
x % y
x // y
x * y @ z / x % y // z

+ x
- x
~ x

x ** y
x ** - y

lambda : x

# Expressions in parentheses to check for proper location information

( x )
( 42 )
( "a" )
( "a" "b" )
( ... )
( None )
( True )
( False )

( f ( ) )
( f ( x ) )
( f ( x , ) )
( f ( x , y ) )
( f ( x , y , z ) )
( f ( x , y , z , ) )

( t [ x ] )
( t [ x , ] )
( t [ x , y ] )
( t [ x , y , z ] )
( t [ x , y , z , ] )

( obj . x )

( obj . f ( x ) [ y ] . x )

( x if y else z )

( x or y )
( x or y or z )

( x and y )
( x and y and z )

( not x )
( not not x )

( x < y )
( x > y )
( x == y )
( x <= y )
( x >= y )

( x < y > z )
( x > y < z )
( x == y < z )
( x <= y < z )
( x >= y < z )

( x | y )
( x | y | z )

( x ^ y )
( x ^ y ^ z )

( x & y )
( x & y & z )

( x << y )
( x >> y )
( x << y >> z )

( x + y )
( x - y )

( x + y - z )

( x * y )
( x @ y )
( x / y )
( x % y )
( x // y )
( x * y @ z / x % y // z )

( + x )
( - x )
( ~ x )

( x ** y )
( x ** - y )

( lambda : x )

( yield x )
( yield from x )

# Statements

del a

pass

break

continue

return
return x
return x , y

yield
yield x
yield x , y
yield x , y, *z
yield from x

raise
raise x
raise x from y

x = y
x , y = z
