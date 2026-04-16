gm=1.4

p1,p2 = map(float, input().split())

M,Ms=4,1

n=10
i=0

while abs(M-Ms)>0.00001 or i<n:
     Ms=M
     M=(gm-1)/(2*gm) + (gm+1)/(2*gm) * (p2/p1) **(1-gm) \
         * ((2/(gm+1))*(1/M + (gm-1)/2))**(-gm)
     print(M**0.5,M-Ms)
     i+=1
