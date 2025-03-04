clear all
close all
clc

% szakasz átviteli függvény
Wp = tf(1, conv([1, 1], [10, 1]))

% szabályozó átviteli függvény
Wc = tf(1.5, 1) % Wc = 1.5

% felnyitott kör
Wo = Wc * Wp

% ugrásválasz (felnyitott kör)
%figure()
%step(Wo)

% zárt kör átviteli fügvénye
Wry = feedback(Wo, 1, -1)

% ugrásválasz Wry
%figure()
%step(Wry)

% ugrásválaszok
figure()
step(Wo)
hold on
step(Wry)
legend("Felnyitott kör", "Zárt kör")

% zárt kör erősítése (statikus erősítés)
statikus_erosites = dcgain(Wry)

% referencia (r) és a hibajel (e) közötti átviteli függvény
Wre = feedback(1, Wo, -1)

figure()
step(Wre)

% maradó hiba: 1-dcgain zártkör
e = 1-dcgain(Wry)

% A P-szabályozó nem tudja a maradék hibát eltűntetni, mert nincs benne
% integrátor. Nincs 0 pólus a rendszerben.

% stepinfo zárt körre
info = stepinfo(Wry)

% pólusok zárt rendszerben
polusok = pole(Wry)
% negatív valós pólus: stabil és beáll valahová

