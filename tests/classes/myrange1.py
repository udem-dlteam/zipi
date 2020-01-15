class Range: pass
class RangeIterator: pass

def my_next(self):
    result = self.current
    if result < self.stop:
        self.current = result + 1
        return result
    else:
        raise StopIteration

RangeIterator.__next__ = my_next

def my_iter(self):
    iter = RangeIterator()
    iter.start = self.start
    iter.stop = self.stop
    iter.current = self.start
    return iter

Range.__iter__ = my_iter

def myrange(start, stop):
    self = Range()
    self.start = start
    self.stop = stop
    return self

r = myrange(0, 5)

print(list(r))

for i in r:
    print(i)
