clear all
close all
clc

Wp = tf(10, conv(conv([5, 1], [4, 1]), [2, 1]))

P = pole(Wp)

% stabil a rendszer, mert csak negatív valós pólusok vannak

K = dcgain(Wp)

%Ap = 0.1
Ap = 0.001

Ti = 5

%Wc = Ap * tf([T, 1], [T, 0])
Wc = (Ap / Ti) * tf([Ti, 1], [1, 0])

Wo = Wc * Wp
Wo = minreal(Wc * Wp)

figure()
margin(Wo)
[Gm, Pm, wcg, wcp] = margin(Wo)
fazistartalek = Pm

Wry = feedback(Wo, 1, -1)

InfoWry = stepinfo(Wry)
tulloves = InfoWry.Overshoot
beallasiido = InfoWry.SettlingTime

e = 1 - dcgain(Wry)

maxido = InfoWry.PeakTime

Wru = feedback(Wc, Wp, -1)

WruInfo = stepinfo(Wru)
maximum = WruInfo.Peak

Wde = -feedback(Wp, Wc, -1)
figure()
step(Wde)
