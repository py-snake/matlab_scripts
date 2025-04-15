clear all
close all
clc

Wp = tf(10, conv(conv([5, 1], [4, 1]), [2, 1]))

pole(Wp)

K = dcgain(Wp)

Ap = 0.1
Ti = 5

Wc = (Ap / Ti) * tf([Ti, 1], [1, 0])

Wo = Wc * Wp
Wo = minreal(Wc * Wp)

[Gm, Pm, Wcg, Wcp] = margin(Wo)

fazistartalek = Pm

Wry = feedback(Wo, 1, -1)

infoWry = stepinfo(Wry)

e = 1 - dcgain(Wry)

Wru = feedback(Wp, Wc, -1)

