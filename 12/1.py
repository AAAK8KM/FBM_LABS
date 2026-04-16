
gm=1.4

f=float(input())

M, Mn = 2,0

merr=0.005

while M-Mn>merr:
 Mn=M
 M=((gm+1)/(gm-1) * (f*M)**(2*(gm-1)/(gm+1)) - 2/(gm-1))**0.5
 print(M,M-Mn)

