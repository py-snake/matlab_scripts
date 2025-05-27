clear all
close all
clc

%szakasz megadása
b=10000; %súrlódási együttható
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
T = -1./eig(A)

