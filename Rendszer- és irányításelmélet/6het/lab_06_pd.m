clear all
close all
clc

% szakasz átviteli függvénye

Wp = tf(0.1, conv(conv([1, 0], [1, 1]), [2, 1]))

% PD szabályozó átviteli függvénye

% Ap = 1
% Ap = 3.5
Ap = 2.5
T = 2

N = 10
Tc = T / (N+1)
Td = N * Tc

Wc = Ap*tf([Td+Tc, 1], [Tc, 1])

% Tf(Ap*[Td+Tc, 1], [Tc, 1])

% felnyitott kör átviteli függvénye
% pólus kiejtés minreal egyszerűsítés

Wo = minreal(Wc*Wp)

% bode

figure()
margin(Wo)
[Gm, Pm, wcg, wcperf] = margin(Wo)

% zárt kör átviteli függvénye

Wry = feedback(Wo, 1, -1)

figure()
step(Wry)

% maradó hiba: 1 - zárt kör
e = 1 - dcgain(Wry)

% információk a zárt körről

infoWry = stepinfo(Wry)

% zavaró jel és hibajel közötti átviteli függvény

Wde = -feedback(Wp, Wc, -1)

figure()
step(Wde)

