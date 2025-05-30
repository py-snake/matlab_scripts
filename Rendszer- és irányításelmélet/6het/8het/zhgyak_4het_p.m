clear all
close all
clc

% szakasz átviteli függvénye
Wp = tf(10, conv(conv([1, 1], [2, 1]), [5, 1]))

% szabályozó átviteli függvénye, P tag
%Ap = 1
Ap = 0.2
Wc = Ap

% felnyitott kör átviteli függvénye
Wo = Wp * Wc

% bode diagram margin
figure()
margin(Wo)
[Gm, Pm, wcg, wcp] = margin(Wo)

% margin utasítás
% Gm erősítés tartalék
% Pm fázistartalék
% Wcg erősítés tartalék frekvenciája
% Wcp fázistartalék frekvenciája, vágási körfrekvencia Wc

% zárt kör átviteli függvénye
Wry = feedback(Wo, 1, -1)

% ugrásválasz Wry-ra zárt körre
figure()
step(Wry)

% zártkör pólusai
p = pole(Wry)

% stabil, van benne lengés

% maradó hiba
e = 1 - dcgain(Wry)

% információk a zárt körre
info = stepinfo(Wry)
tulloves = info.Overshoot
T2 = info.SettlingTime

% tervezési feltételek
% fi t > 60fok PM
% T2 % < 20 sec SettlingTime
% túllövés < 24% Overshoot

% Ap            % rad/sec   % 1         % 1.2   % 0.25  <-- Ap változtatása manuálisan
% Wc            % fok       % 0.8       % 0.87  % 0.33
% fi t          %           % 7.2       % 1.4   % 67.92
% fi végtelen   %           % 0.09      % 1.87  % 0.28
% túllövés      % százalék  % 76.9      % 85.86 % 23.73
% T2            % sec       % 100.27    % 458   % 16.91

% Wru átviteli függvény (beavatkozó jelet vizsgálja)
Wru = feedback(Wc, Wp, -1)
figure()
step(Wru)

% maximális beavatkozó jel
infoWru = stepinfo(Wru)
maxBeavatkozo = infoWru.Peak
