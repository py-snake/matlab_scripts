close all
clear all
clc
%% első feladat
Wp = tf(10, conv(conv([5 1],[4 1]),[2 1]))

pole(Wp)
%PI szabalyozo atviteli fv
Ap = 0.034; % Gm szeriont 0.75 alatt van a megfelelő Ap (erősítés) 1-nél már elszáll a rendszer
Ti = 5; %integrálási idő
Wc = tf((Ap/Ti)*[Ti 1],[1 0])
Wo = minreal(Wp * Wc) %kiejtjük a leglassabb idejű pólust a minreal használatával!!!
[Gm,Pm,Wcg,Wcp] = margin(Wo) % Erősítés, Fázistartalék, erősítés frekvencia, vágási körfrekvencia
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
peak = info.PeakTime

Wru = feedback(Wc, Wp, -1) % a visszacsatoló ágban a Wp van!!!
figure()
step(Wru)
infoWru = stepinfo(Wru);
maxBeavatkozoJel = infoWru.Peak


%% Második feladat

close all
clear all
clc

Wp = tf (0.5,conv([1 0],conv([1 1],[4 1])))
pole(Wp)

%PD szabalyozo atviteli fv
Ap = 0.5; % 60-ig lehetne állítani
N = 10;%szürö együtthato az aluláteresztő szürönél
T = 4; % ő a leglassabb
Tc = T / (N+1)
Td = N * Tc % Deriválási idő

Wc = tf(Ap*[Td+Tc 1],[Tc 1])
Wo = minreal(Wp * Wc)


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
peak = info.PeakTime
T2 = info.SettlingTime % 2%-os beállási idő

%beavatkozó jel vizsgálata (maximális u)
Wru = feedback(Wc, Wp, -1) % a visszacsatoló ágban a Wp van!!!
%ugrasvalasz
figure()
step(Wru)

infoWru = stepinfo(Wru);
maxBeavatkozoJel = infoWru.Peak


% zavarás hatását számoljuk itt ki

Wde = -feedback(Wp,Wc,-1) %visszacsatoló ág az a Wc lesz, mert negatív visszacsatolást akarok
%ugrasvalasz
figure()
step(Wde)

%max hibajel
infoWde = stepinfo(Wde);
maxHibaJel = infoWde.Peak

%% Harmadik feladat
close all
clear all
clc

Wp = tf(10, conv(conv([5 1],[4 1]),[2 1]))
Wc = 0.103 % Ez lesz az Ap
Wo = minreal(Wc*Wp)
figure()
%bode(Wo)
margin(Wo)
[Gm,Pm,Wcg,Wcp] = margin(Wo) % Erősítés, Fázistartalék, erősítés frekvencia, vágási körfrekvencia

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
peak = info.PeakTime
T2 = info.SettlingTime % 2%-os beállási idő

%beavatkozó jel vizsgálata (maximális u)
Wru = feedback(Wc, Wp, -1) % a visszacsatoló ágban a Wp van!!!
%ugrasvalasz
figure()
step(Wru)

infoWru = stepinfo(Wru);
maxBeavatkozoJel = infoWru.Peak
%% a simulinkes dolgok ki vannak hagyva amit mondott Melánia
%% Negyedik feladat

Wp = tf(20,conv(conv([12 1], [10 1]),[11 1])) %20/(12s+1)(10s+1)(11s+1)
%PID szabalyozo atviteli fv
T1 = 11; 
T2 = 12; %integrálási idő
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

Ap = 0.08
%atviteli fv.
Wc = tf((Ap/Ti)*[Ti*(Td+Tc) Ti+Tc 1],conv([1 0], [Tc 1])) % controller- conv =konvolúció

%felnyitott kör egyenlete
Wo = minreal(Wp * Wc) %kiejtjük a leglassabb idejű pólust a minreal használatával!!!

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
peaktime = WryInfo.PeakTime