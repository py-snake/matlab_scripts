clear all
close all
clc

% szakasz átviteli függvénye

Wp = tf(0.1, conv(conv([1, 1], [2, 1]), [5, 1]))

% PI szabályozó átviteli függvénye

Ap = 0.1
% Ap = 75 stabilitás határa
Ti = 5

Wc = Ap/Ti*tf([Ti, 1], [1, 0])

% Tf(Ap/Ti*[Ti, 1], [1, 0])

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

