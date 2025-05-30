close all
clear all
clc

Wp = tf(10,conv(conv([5 1],[4 1]),[2 1]))
pole(Wp)

% pi szabalyozo fuggvenye

Ti = 5;
Ap = 0.035;
Wc = tf((Ap/Ti)*[Ti 1],[1 0]);

Wo = minreal(Wc * Wp);

[Gm, Pm, Wcg, Wcp] = margin(Wo)

Wry = feedback(Wo,1, -1); %előre mutató ág, visszamutató ág, és ez egy negatív visszacsatolás
figure()
step(Wry)
%ugrasvalasz
maradohiba = 1-dcgain(Wry)
info = stepinfo(Wry);
tulloves = info.Overshoot
T2 = info.SettlingTime % 2%-os cucc
peak = info.PeakTime

Wru = feedback(Wc, Wp, -1);
info2 = stepinfo(Wru);
peak = info2.Peak

%legyen a fázistartalék romlása max 0.9 fok. Mennyi a Ts?
phiR2 = 0.9
Ts = phiR2*2*pi/(Wcp*180)

%diszkrét idejű átviteli függvény
Dc = c2d(Wc,Ts,'zoh')

%% Második
Wp = tf(0.5,conv([1 0],conv([1 1], [4 1])))
pole(Wp)
Ap = 0.6
N = 10; %szürö együtthato az aluláteresztő szürönél
T = 4; % ő a leglassabb
Tc = T / (N+1)
Td = N * Tc

Wc= tf(Ap*[Td+Tc 1],[Tc 1]);
Wo = minreal(Wc * Wp)

[Gm, Pm, Wcg, Wcp] = margin(Wo)

Wry = feedback(Wo,1, -1); %előre mutató ág, visszamutató ág, és ez egy negatív visszacsatolás
figure()
step(Wry)
%ugrasvalasz
maradohiba = 1-dcgain(Wry)
info = stepinfo(Wry);
tulloves = info.Overshoot
T2 = info.SettlingTime % 2%-os cucc
peaktime = info.PeakTime

Wru = feedback(Wc, Wp, -1);
info2 = stepinfo(Wru);
peak = info2.Peak

Wde = -feedback(Wp,Wc,-1) %visszacsatoló ág az a Wc lesz, mert negatív visszacsatolást akarok
figure()
step(Wde)

%legyen a fázistartalék romlása max 0.9 fok. Mennyi a Ts?
phiR2 = 0.9
Ts = phiR2*2*pi/(Wcp*180)

%diszkrét idejű átviteli függvény
Dc = c2d(Wc,Ts,'zoh')


%% Harmadik
Wc = 0.11;
Wp = tf(10,conv([5 1],conv([4 1],[2 1])))
Wo = minreal(Wc*Wp)
[Gm, Pm, Wcg, Wcp] = margin(Wo)


Wry = feedback(Wo,1, -1) %előre mutató ág, visszamutató ág, és ez egy negatív visszacsatolás
figure()
step(Wry)
%ugrasvalasz
maradohiba = 1-dcgain(Wry)
info = stepinfo(Wry);
tulloves = info.Overshoot
T2 = info.SettlingTime % 2%-os cucc
peak = info.PeakTime

Wde = -feedback(Wp,Wc,-1) %visszacsatoló ág az a Wc lesz, mert negatív visszacsatolást akarok
figure()
step(Wde)

%% negyedik
Ap = 0.09
Wp = tf(20, conv([12 1],conv([10 1], [11 1])))

T1 = 11 %egyik leglassabb
T2 = 12 %másik leglassabb pólus

N = 10;

Tc = min(roots([-(N+1) (T1+T2)*(N+1) -(T1*T2)]))
Ti = T1 + T2 - Tc
Td = N * Tc
Wc = tf((Ap/Ti)*[Ti*(Td+Tc) Ti+Tc 1],conv([1 0], [Tc 1]))

Wo = minreal(Wc*Wp)

[Gm,Pm,Wcg,Wcp] = margin(Wo) 
Wry = feedback(Wo,1, -1); %előre mutató ág, visszamutató ág, és ez egy negatív visszacsatolás
figure()
step(Wry)
%ugrasvalasz
maradohiba = 1-dcgain(Wry)
info = stepinfo(Wry);
tulloves = info.Overshoot
T2 = info.SettlingTime % 2%-os cucc
peaktime = info.PeakTime
