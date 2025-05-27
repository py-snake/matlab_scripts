clear all
close all
clc

%szakasz megadása
b=100; %súrlódási együttható
k=1000; %rugóállandó
m=10000; %tehetetlenségi tömeg

A = [0 1;-k/m -b/m]
B = [0;1/m]
C = [1 0]
D = 0

suspension = ss(A,B,C,D)

figure()
step(suspension)

figure()
impulse(suspension)

%A sajátértékei
eig(A)
T = -1./real(eig(A))


%% Állapotteres irányítás

%irányíthatósági mátrix
Mc = ctrb(A,B) %controlability matrix
det(Mc) %ha nem nulla, akkor a rendszer irányítható

%zárt kör dinamikája
sc1 = -1/2 %T=2 sec, nincs lengés
sc2 = -10/2 %T=0.2 sec, nincs lengés

K = acker(A,B,[sc1 sc2])