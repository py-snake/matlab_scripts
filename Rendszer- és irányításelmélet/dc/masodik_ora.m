%Lengőrendszerek
clear all
close all
clc

%paraméterek
m = 100
k = 150
b = 2*sqrt(k*m)
%paraméterek
%m = 100
%b = 100 % itt alig van kilengés
%k = 150
%paraméterek
%m = 100
%b = 10
%k = 150 % itt hatalmas a kilengés

%paraméterek
%m = 100
%b = 10
%k = 15

% átviteli függvény
lengoRendszer = tf(1,[m b k])

%polusok 
p = pole(lengoRendszer) % stabil és leng a rendszer

% statikus erősítés
s = dcgain(lengoRendszer) % ide fog a rendszer beállni

%pólus zérus eloszlás
figure()
pzmap(lengoRendszer)

%ugrásválasz
figure()
step(lengoRendszer)

%impulzusválasz
figure()
impulse(lengoRendszer)

% Bode diagram
figure()
bode(lengoRendszer)
