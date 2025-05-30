%%% negyedik feladat teljes
clear all
close all
clc
Wp = tf(20,conv([12 1],conv([10 1],[11 1])))

T1 = 11
T2 = 12
N = 10
Ap = 0.09
Tc = min(roots([-(N+1) (T1+T2)*(N+1) -(T1*T2)]))

Ti = T1 + T2 - Tc
Td = N * Tc

Wc = tf((Ap/Ti)*[Ti*(Tc+Td) (Ti+Tc) 1],conv([1 0], [Tc 1]))
Wo = minreal(Wc*Wp)

[Gm, Pm, Wcg, Wcp] = margin(Wo)

Wry = feedback(Wo, 1, -1)
info = stepinfo(Wry);
hiba = 1- dcgain(Wry)
tulloves = info.Overshoot
T2szazalek = info.SettlingTime
peaktime = info.PeakTime

% 4.5-ös feladat itt jön!!!
Ts=1.5 % mintaveteli ido
phiRomlas = -Wcp*Ts/2*180/pi

%legyen a fázistartalék romlása max 0.1 fok. Mennyi a Ts?
phiR2 = 0.1
Ts = phiR2*2*pi/(Wcp*180)

%diszkrét idejű átviteli függvény
Dc = c2d(Wc,Ts,'zoh')
