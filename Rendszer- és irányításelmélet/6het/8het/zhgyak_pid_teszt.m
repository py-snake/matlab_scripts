clear all
close all
clc

Wp = tf(20, conv(conv([12, 1], [10, 1]), [11, 1]))

T1 = 12
T2 = 11
N = 10

TcVec = roots([-(N+1), (T1+T2)*(N+1), -T1*T2])
Tc = TcVec(2)

Ti = T1 + T2 - Tc
Td = N * Tc

Ap = 0.1
Ap = 0.08

Wc = (Ap / Ti) * tf([Ti * (Td + Tc), Ti + Tc, 1], conv([1, 0], [Tc, 1]))

Wo = minreal(Wc * Wp)

[Gm, Pm, wcg, wcp] = margin(Wo)

Wry = feedback(Wo, 1, -1)

stepinfoWry = stepinfo(Wry)

tulloves = stepinfoWry.Overshoot
beallasiido = stepinfoWry.SettlingTime
fazistartalek = Pm

maxido = stepinfoWry.PeakTime

