clear all
close all
clc

% 1. Szakasz megadása
disp("Súrlódási együttható:")
b=100 % súrlódási együttható
disp("Rugóállandó:")
k=1000 % rugóállandó
disp("Tehetetlenségi tömeg:")
m=10000 % tehetetlenségi tömeg

% 2. Állapotteres felírás
A = [0 1 ; -k/m -b/m]
B = [0 ; 1/m]
C = [1 0]
D = 0

suspension = ss(A,B,C,D)

% 3. Rendszer kiértékelése
figure()
step(suspension)

figure()
impulse(suspension)

% 4. Sajátértékei, időállandója
eig(A)
% ./ elemenként végzi az osztást
% időállandók
T = -1./real(eig(A))

% 5. Állapotteres irányítás

%irányíthatósági mátrix
Mc = ctrb(A,B) %controlability matrix
det(Mc) %ha nem nulla, akkor a rendszer irányítható

%zárt kör dinamikája
sc1 = -5/2 %T=2/5 sec, nincs lengés
sc2 = -10/2 %T=0.2 sec, nincs lengés

K = acker(A,B,[sc1 sc2])

% 6. Alapjel miatti korrekció
AMat = [A B;C 0]
bVec = [0;0;1]
Mxu = AMat\bVec

Mx = Mxu(1:2)
Mu = Mxu(end)

% 7. Állapotmegfigyelő tervezése
Mo = obsv(A,C) %observability matrix
det(Mo) %ha nem nulla, akkor megfigyelhető a rendszer

%becslési hiba dinamika
so1 = 10*sc1;
so2 = 10*sc2;

% 8. Állapotmegfigyelő mátrix
G = acker(A',C',[so1 so2])' % a jelek a transzponálást jelentik


% 9. Terhelésbecslő tervezése
%kibővített rendszer
Az = [A B;0 0 0]
Bz = [B;0]
Cz = [C 0]


Moz = obsv(Az,Cz) %observability matrix
det(Moz) %ha nem nulla, akkor megfigyelhető a rendszer

% 10. Becslési hiba dinamika
so1 = 10*sc1;
so2 = 10*sc2;
so3 = so2;

Gz = acker(Az',Cz',[so1 so2 so3])'

