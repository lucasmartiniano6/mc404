a = [0, 1, 2, 3, 4, 5, 6, 7]
print(a)

for i in range(0, 8//2, 2):
    u,v = a[i], a[i+1] 
    a[i], a[i+1] = a[6-i], a[7-i]
    a[6-i], a[7-i] = u, v

print(a)
