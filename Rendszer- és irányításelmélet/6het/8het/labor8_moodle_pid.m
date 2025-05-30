clear all
close all
clc

%szakasz
Wp = tf(0.2,conv(conv([1 1],[10 1]),[11 1]))

%PID szabályozó
%előírások
T1 = 10; % T1 időállandójú pólust kiejtjük
T2 = 11; % T2 időállandójú pólust kiejtjük
N = 10; % Td/Tc arány

%Tc
Tc12 = roots([-(N+1) (N+1)*(T1+T2) -T1*T2]);

if min(Tc12) > 0
    Tc = min(Tc12);
else
    if max(Tc12) < 0
        error('Nem lehet beállítani az időállandót')
    else
        Tc = max(Tc12);
    end
end

Ti = T1+T2 - Tc;
Td = N*Tc;

Ap = 29;  

% a szabályozó átviteli függvénye
Wc = tf(Ap/Ti*[Ti*(Td+Tc) Ti+Tc 1],conv([1 0],[Tc 1]))

%felnyitott kör
Wopen = minreal(Wp*Wc)

%bode
[Gm,Pm,wcg,wcp] = margin(Wopen)
figure()
margin(Wopen)

%zárt kör 
Wry = feedback(Wopen,tf(1,1),-1)
figure()
step(Wry)
title('Zárt kör ugrásválasza')

%maradoHiba
maradoHiba = 1-dcgain(Wry)

%infok a zart korrol
info = stepinfo(Wry)
tulloves = yinfo.Overshoot
beallasiIdo = yinfo.SettlingTime

