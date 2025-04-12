clear all
close all
clc

Wp = tf([0.1], conv(conv([1, 0], [1, 1]), [2, 1]))

Ap = 1.6
%Ap = 15
Wc = Ap

Wo = minreal(Wp * Wc)

figure()
margin(Wo)
[Gm, Pm, wcg, wcp] = margin(Wo)

erosites_tartalek = Gm
fazistartalek = Pm

%fazistartalek > 60fok
%tulloves < 5%

% stabil

Wry = feedback(Wo, 1, -1)

figure()
step(Wry)

% maradó hiba: 1 - zárt kör
e = 1 - dcgain(Wry)

infoWry = stepinfo(Wry)

tulloves = infoWry.Overshoot

% Wru átviteli függvény (beavatkozó jelet vizsgálja)
Wru = feedback(Wc, Wp, -1)
figure()
step(Wru)

e = 1 - dcgain(Wry)

