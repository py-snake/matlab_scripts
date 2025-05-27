
%PI feladat

clear all
close all
clc

%szakasz
Wp = tf(10, conv(conv([1 1],[2 1]),[5 1]))

%PI szablyozó
Ap = 0.12; 
Ti = 5;

Wc = (Ap/Ti)*tf([Ti 1],[1 0])

%felnyitott kor (poluskiejtes --> minreal)
Wo = minreal(Wp*Wc)

%bode
figure()
margin(Wo)
[Gm, Pm, wcg, wcp] = margin(Wo)


%zart kor
Wry = feedback(Wo, 1,-1)
figure()
step(Wry)
maradoHibaWry = 1-dcgain(Wry)
info = stepinfo(Wry)

%referencia jel --> beavatkozo jel
Wru = feedback(Wc,Wp,-1)
figure()
step(Wru)
beavatkozoInfo = stepinfo(Wru)