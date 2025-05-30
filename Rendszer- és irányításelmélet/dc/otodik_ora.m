clear all
close all
clc

%szakasz atviteli fv
Wp = tf(10, conv([1 1],conv([2,1],[5,1])));

% szakasz polus-zerus eloszlasa
figure()
pzmap(Wp) %nincs zerusa, es stabil, ha lenne zerusa akkor karikazott lenne
%Wc(s) = Ap (ez a P-szabályozó egyenlete)

% P szabályozó
Ap = 0.12 %itt amúgy az alap érték 1.. :)
Wc = Ap; %tf(Ap,1) = ez egy konstans

%felnyitott kör egyenlete
Wo = Wp * Wc %nem kell ennel tobb, a megoldast leirod amit kapsz

% bode diagram
figure()
%bode(Wo)
margin(Wo)

[Gm,Pm,Wcg,wcp] = margin(Wo)
% Gm = 1.2603 (ez nem decibel)
% a tanárok decibelbe szeretik, és itt ez 2.01 dB
%Zh : szabályozd be a szabályozót, hogy a feltételeknek megfeleljen

%stepinfo értelmezése
%túllövés: v(végtelen) = végértékbe fog beállni a rendszer
% az ugrásválasz az egybe tart. e(végtelen) = 1 - v(végtelen)
% az értéke megmondja hogy mekkora lesz a lengés
% beállási idő: 2%

%zárt kör átviteli függvénye
Wry = feedback(Wo,1,-1) % a -1 itt a negatív visszacsatolás

%ugrásválasz zárt körre
figure()
step(Wry)

% marado hiba (e végtelen)

e = 1-dcgain(Wry)
% ugrasvalasz jellemzői
info = stepinfo(Wry);
tulloves = info.Overshoot
T2 = info.SettlingTime

%átviteli függvény r--->u (beavatkozó jel)
Wru = feedback(Wc, Wp, -1) % a visszacsatoló ágban a Wp van!!!

%ugrasvalasz
figure()
step(Wru)

%maximális beavatkozó jel
infoWru = stepinfo(Wru);
maxBeavatkozoJel = infoWru.Peak % akkora lesz ez, mint az erősítés, persze ez PID-nél igaz ez, PD-nél nem...
%P szabályozónál az Ap lesz a maxBeavatkozoJel!!!


% zavarás hatását számoljuk itt ki

Wde = -feedback(Wp,Wc,-1) %visszacsatoló ág az a Wc lesz, mert negatív visszacsatolást akarok
%ugrasvalasz
figure()
step(Wde)

%max hibajel
infoWde = stepinfo(Wde);
maxHibaJel = infoWde.Peak