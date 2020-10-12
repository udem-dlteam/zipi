lst1 = [1,2,3]
lst1[0] += 2
lst1[-1] += 9
print(lst1)

lst1[0] -= 2
lst1[-1] -= 9
print(lst1)

lst1[0] *= 2
lst1[-1] *= 9
print(lst1)

lst1[0] //= 2
lst1[-1] //= 9
print(lst1)

lst2=[[],[]]
lst2.append(lst2[0])
lst2[0] += [1,2,3]
print(lst2)