def simple():
  i = 20
  i += 10

  print(i)

def lst():  
  l = [1,2,3];
  l[1] += 10;

  print(l[1])

def obj():
  class C():
     def __init__(self, _a):
        self.a = _a;

  o = C(1);
  o.a += 10

  print(o.a)


simple()
lst()
obj()
