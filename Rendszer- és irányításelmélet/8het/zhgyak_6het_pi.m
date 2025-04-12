clear all
close all
clc

Wp = tf([10], conv(conv([1, 1], [2, 1]), [5, 1]))

Ti = 5

Ap = 1
Ap = 0.1
%Ap = 0.74

Wc = (Ap/Ti) * tf([Ti, 1], [1, 0])

% felnyitott kör átviteli függvénye
% pólus kiejtés minreal egyszerűsítés

Wo = minreal(Wc*Wp)

figure()
margin(Wo)
[Gm, Pm, wcg, wcperf] = margin(Wo)

erositestartalek = Gm
fazistartalek = Pm

Wry = feedback(Wo, 1, -1)

figure()
step(Wry)

% maradó hiba: 1 - zárt kör
e = 1 - dcgain(Wry)

% információk a zárt körről

infoWry = stepinfo(Wry)

