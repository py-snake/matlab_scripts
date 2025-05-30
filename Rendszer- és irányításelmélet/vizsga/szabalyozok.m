%% P szabályozó

clear all
close all
clc

Wp = tf(0.1, conv(conv([1 0], [1 1]), [2 1]))

Ap = 1.6

Wc = Ap

Wo = (Wp * Wc)

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

Wo = (Wc * Wp)

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

