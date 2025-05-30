clear all
close all
clc

Wp = tf(0.5, conv(conv([1, 0], [1, 1]), [4, 1]))

P = pole(Wp)

K = dcgain(Wp)

Ap = 0.1
Ap = 0.5
T = 4
N = 10
Tc = T / (N + 1)
Td = N * Tc

Wc = Ap * tf([Tc + Td, 1], [Tc, 1])

Wo = minreal(Wp * Wc)

figure()
margin(Wo)
[Gm, Pm, Wcg, Wcp] = margin(Wo)

fazistartalek = Pm

Wry = feedback(Wo, 1, -1)

WryInfo = stepinfo(Wry)
tulloves = WryInfo.Overshoot
beallasiido = WryInfo.SettlingTime

e = 1- dcgain(Wry)

maxido = WryInfo.PeakTime

Wru = feedback(Wc, Wp, -1)

WruInfo = stepinfo(Wru)
maximum = WruInfo.Peak

Wde = -feedback(Wp, Wc, -1)
figure()
step(Wde)

