clear all
close all
clc

b = 100
k = 1000
m = 10000

A = [0 1 ; -k/m -b/m]
B = [0 ; 1/m]
C = [1 0]
D = 0

suspension = ss(A,B,C,D)

figure()
step(suspension)

figure()
impulse(suspension)

sajatertek = eig(A)

T = -1./real(eig(A))

Mc = ctrb(A, B)
det(Mc)


sc1 = -5/2
sc2 = -10/2

K = acker(A, B, [sc1 sc2])


%%
clear all
close all
clc

b = 100
k = 1000
m = 10000

A = [0 1 ; -k/m -b/m]
B = [0 ; 1/m]
C = [1 0]
D = 0

suspension = ss(A, B, C, D)

figure()
step(suspension)

figure()
impulse(suspension)

sajatertek = eig(A)
T = -1./real(eig(A))

Mc = ctrb(A, B)
sc1 = -5/2
sc2 = -10/2
K = acker(A, B, [sc1 sc2])

Amat = [A B ; C 0]
Bvec = [0 ; 0; 1]
Mxu = Amat\Bvec
Mx = Mxu(1:2)
Mu = Mxu(end)

Mo = obsv(A, C)
det(Mo)

so1 = 10 * sc1
so2 = 10 * sc2

G = acker(A', C', [so1 so2])'

Az = [A B ; 0 0 0]
Bz = [B ; 0]
Cz = [C 0]

Moz = obsv(Az, Cz)
det(Moz)

so1 = 10 * sc1
so2 = 10 * sc2
so3 = sc2

Gz = acker(Az', Cz', [so1 so2 so3])'

%%

clear all
close all
clc

