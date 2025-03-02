clear all %torli a valtozokat
close all %torli az abrakat
clc %torli a command window tartalmat

A = [2 5 2.3; 1 0 3; 0 -4.1 5]
B = [1; -1; -2]
C = [-1 -2 3]
D = 0

rendszer = ss(A,B,C,D) 

s = eig(A)

figure()
step(rendszer)

figure()
impulse(rendszer)

tfRendszer = tf(ss(A,B,C,D))

%%
clear all
close all
clc

W = tf(2, [1 11 42.25 54.75])

p = pole(W)
z = zero(W)

figure()
step(W)

figure()
pzmap(W)

st = dcgain(W)

Wp = tf(2, conv(conv([3 1],[5 1]),[10 1]))
