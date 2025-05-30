%% P szabályozó

clear all
close all
clc

Wp = tf(0.1, conv(conv([1 0], [1 1]), [2 1]))

Ap = 1.6

Wc = Ap

Wo = minreal(Wp * Wc)

figure()
margin(Wo)
[Gm, Pm, wcg, wcp] = margin(Wo)

erositestartalek = Gm
fazistartalek = Pm

Wry = feedback(Wo, 1, -1)

figure()
step(Wry)

p = pole(Wry)

e = 1 - dcgain(Wry)

infoWry = stepinfo(Wry)

tulloves = infoWry.Overshoot
T2 = infoWry.SettlingTime

Wru = feedback(Wc, Wp, -1)

figure()
step(Wru)

infoWru = stepinfo(Wru)
maxBeavatkozo = infoWru.Peak

%% PI szabályozó

clear all
close all
clc

Wp = tf([10], conv(conv([1, 1], [2, 1]), [5, 1]))

Ti = 5
Ap = 0.1

Wc = (Ap/Ti) * tf([Ti, 1], [1, 0])

Wo = minreal(Wc * Wp)

figure()
margin(Wo)
[Gm, Pm, wcg, wcp] = margin(Wo)

erositestartalek = Gm
fazistartalek = Pm

Wry = feedback(Wo, 1, -1)

figure()
step(Wry)

e = 1 - dcgain(Wry)

infoWry = stepinfo(Wry)
tulloves = infoWry.Overshoot
beallasiido = infoWry.SettlingTime
maxido = infoWry.PeakTime

Wru = feedback(Wc, Wp, -1)

WruInfo = stepinfo(Wru)
maximum = WruInfo.Peak

Wde = -feedback(Wp, Wc, -1)
figure()
step(Wde)

%% PID szabályozó

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

%% PI

clear all
close all
clc

Wp = tf(0.01, conv(conv([10 1], [8 1]), [5 1]))

Ap = 30
Ti = 10

Wc = (Ap/Ti) * tf([Ti 1], [1 0])

Wo = minreal(Wp * Wc)

[Gm, Pm, wcg, wcp] = margin(Wo)

Wry = feedback(Wo, 1, -1)

infoWry = stepinfo(Wry)
tulloves = infoWry.Overshoot % < 3%
beallasiido = infoWry.SettlingTime % < 80sec
fazistartalek = Pm % > 60fok

e = 1 - dcgain(Wry)

