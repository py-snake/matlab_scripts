clear all
close all
clc

%%

% szakasz átviteli függvénye
Wp = tf(10, conv(conv([1, 1], [2, 1]]), [5, 1]))

% szabályozó átviteli függvénye, P tag
Ap = 1
Wc = Ap

% felnyitott kör átviteli függvénye
Wo = Wp * Wc

% margin utasítás
% Gm erősítés tartalék
% Pm fázistartalék
% Wcg erősítés tartalék frekvenciája
% Wcp fázistartalék frekvenciája, vágási körfrekvencia Wc

% bode a felnyitott körre
figure()
margin(Wo)
[Gm, Pm, wcg, wcp] = margin(Wo)

% fi t > 0 ezért stabil a rendszer

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

%%

% tervezési feltételek
% fi t > 60fok PM
% T2 % < 20 sec SettlingTime
% túllövés < 24% Overshoot

% Ap            % rad/sec   % 1
% Wc            % fok       % 0.8
% fi t          %           % 7.2
% fi végtelen   %           % 0.09
% túllövés      % százalék  % 76.9
% T2%           % sec       % 100.27

