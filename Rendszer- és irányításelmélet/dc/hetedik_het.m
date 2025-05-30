%hetedik óra - PID szabályozó
clear all
close all
clc

%Ez a szakasz átviteli függvény
Wp = tf(0.2,conv(conv([1 1], [10 1]),[11 1])) %0.2/(s+1)(10s+1)(11s+1)

%PID szabalyozo atviteli fv
T1 = 10; % Gm szeriont 0.75 alatt van a megfelelő Ap (erősítés) 1-nél már elszáll a rendszer
T2 = 11; %integrálási idő
N =10;
Tc12 = roots([-(N+1) (T1+T2)*(N+1) -(T1*T2)]); %ez egy vektor lesz 

if min(Tc12) > 0
    Tc = min(Tc12);
else
    if max(Tc12) < 0
        error("Nem lehet meghatározni, állítani kell az N paramétert")
    else
        Tc = max(Tc12);
    end
end

Ti = T1 + T2 - Tc
Td = N * Tc

Ap = 25.97 %ez úgymond a legjobb (sisotoolból meghatározva)
%atviteli fv.
Wc = tf((Ap/Ti)*[Ti*(Td+Tc) Ti+Tc 1],conv([1 0], [Tc 1])) % controller- conv =konvolúció

%felnyitott kör egyenlete
Wo = minreal(Wp * Wc) %kiejtjük a leglassabb idejű pólust a minreal használatával!!!
% ekkor nem kapunk bazinagy számokat

% bode diagram
figure()
%bode(Wo)
margin(Wo)
[Gm,Pm,Wcg,Wcp] = margin(Wo) % Erősítés, Fázistartalék, erősítés frekvencia, vágási körfrekvencia
% Itt a pm 89.2 fok lesz, szóval stabil!
%írjátok le a bode tétel alapján miért stabil vagy instabil?
% a bode azt mondja ha 0-nál nagyobb akkor stabil.

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
WryInfo = stepinfo(Wry);
tulloves = WryInfo.Overshoot
T2 = WryInfo.SettlingTime % 2%-os beállási idő