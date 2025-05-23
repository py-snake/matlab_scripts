clear all
close all
clc

% szakasz
Wp = tf(0.5, conv(conv([1, 0], [1, 1]), [4, 1]))

% pólusok
p = pole(Wp)

% stabil-e
% a stabilitás határán van a 0 miatt, majdnem stabil mert minden valós rész negatív
% azért stabil, mert minden valós rész negatív
% komplex konjugált rész: az ugrásválaszon lenne lengés

% statikus erősítés
K = dcgain(Wp)

% körerősítés
% a számlálóban lévő szám
% körerősítés = 0.5

% T = Td + Tc
% Td = N * Tc
% N = Td / Tc

% PD
% leglassabb pólus a nevezőben a legnagyobb s együttható
T = 4
N = 10
Tc = T / (N + 1)
Td = N * Tc

% PD átviteli függvény
%Ap = 0.1
Ap = 0.5
Wc = Ap * tf([Td + Tc, 1], [Tc, 1])

% felnyitott kör
Wo = minreal(Wc * Wp)
% papírra Wo leírása, minreal használatával

% bode
figure()
margin(Wo)
[Gm, Pm, wcg, wcp] = margin(Wo)
fazistartalek = Pm

% zárt kör
Wry = feedback(Wo, 1, -1)
infoWry = stepinfo(Wry)
tulloves = infoWry.Overshoot
beallasIdo = infoWry.SettlingTime
% fazistartalek = Pm

% zárt kör maradó hibája
e = 1 - dcgain(Wry)
% eltűnt a maradó hiba, mert a szakaszban van egy 0 pólus
% integrátor tag teszi be a 0 pólust

% maximumig terjedő idő: peaktime
maxido = infoWry.PeakTime

% beavatkozó jel max értéke
% Wru
Wru = feedback(Wc, Wp, -1)
infoWru = stepinfo(Wru)
maximum = infoWru.Peak

% zavarás hatása a hibajelre
Wde = -feedback(Wp, Wc, -1)

figure()
step(Wde)

