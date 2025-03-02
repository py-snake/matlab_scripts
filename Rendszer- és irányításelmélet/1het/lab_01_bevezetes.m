clear all
close all
clc

A = [2, 5, 2.3;
    1, 0, 3;
    0, -4.1, 5]
B = [1;
    -1;
    -2]
C = [-1, -2, 3]
D = 0

% ss=state space, állapottér
rendszer = ss(A, B, C, D)

%eig=mátrix sajátértéke
s = eig(A)

figure()
step(rendszer)

figure()
impulse(rendszer)

tfRendszer = tf(ss(A, B, C, D))

%tf tranfer function, átviteli függvény
% rendszer = tf(2, )

%%
clear all
close all
clc

W = tf(2, [1, 11, 42.25, 54.75])

% pólusok
p = pole(W)

% zérusok
z = zero(W)

% ugrásválasz
figure()
step(W)

% pólus-zérus eloszlás
figure()
pzmap(W)

% statikus erősítés
 st = dcgain(W)

 % conv utasítás
 Wp = tf(2, conv(conv([3, 1], [5, 1]), [10, 1]))

 