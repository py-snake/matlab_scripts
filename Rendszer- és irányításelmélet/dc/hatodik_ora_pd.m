%hatodik óra - PD szabályozó
clear all
close all
clc

%Ez a szakasz átviteli függvény
Wp = tf(0.1,conv(conv([1 0], [1 1]),[2 1])) %10/(s+0)(s+1)(2s+1)

%PD szabalyozo atviteli fv
Ap = 3.55; % 60-ig lehetne állítani
N = 10;%szürö együtthato az aluláteresztő szürönél
T = 2; % ő a leglassabb
Tc = T / (N+1)
Td = N * Tc % Deriválási idő

Wc = tf(Ap*[Td+Tc 1],[Tc 1])

%felnyitott kör egyenlete
Wo = minreal(Wp * Wc) %kiejtjük a leglassabb idejű pólust a minreal használatával!!!
% ekkor nem kapunk bazinagy számokat

% bode diagram
figure()
%bode(Wo)
margin(Wo)
[Gm,Pm,Wcg,Wcp] = margin(Wo) % Erősítés, Fázistartalék, erősítés frekvencia, vágási körfrekvencia
% Itt a pm -7.52 fok lesz, szóval instabil!

%zárt kör átviteli függvénye
Wry = feedback(Wo,1,-1) % a -1 itt a negatív visszacsatolás (visszacsatolt 
% ágban nincs semmi azért 1 a közepén, de az előre csatoló ágba van a Wo)
figure()
%ugrásválasz
step(Wry)

%stepinfo, minosegi jellemzők

% marado hiba (e végtelen)

e = 1-dcgain(Wry)
% ugrasvalasz jellemzői
info = stepinfo(Wry);
tulloves = info.Overshoot
T2 = info.SettlingTime % 2%-os beállási idő

%beavatkozó jel vizsgálata (maximális u)
Wru = feedback(Wc, Wp, -1) % a visszacsatoló ágban a Wp van!!!

%ugrasvalasz
figure()
step(Wru)

infoWru = stepinfo(Wru);
maxBeavatkozoJel = infoWru.Peak %PI-nél nem ugyanaz lesz, pl Ap = 0.12, a beavatkozójel 0.164 lesz!


% zavarás hatását számoljuk itt ki

Wde = -feedback(Wp,Wc,-1) %visszacsatoló ág az a Wc lesz, mert negatív visszacsatolást akarok
%ugrasvalasz
figure()
step(Wde)

%max hibajel
infoWde = stepinfo(Wde);
maxHibaJel = infoWde.Peak

