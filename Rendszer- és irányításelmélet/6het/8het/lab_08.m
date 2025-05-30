% PID szabályozó

clear all
close all
clc

% szakasz
Wp = tf(0.2, conv(conv([1, 1], [10, 1]), [11, 1]))

% PID szabályozó
N = 10
T1 = 10
T2 = 11

TcVec = roots([-(N+1), (T1+T2)*(N+1), -T1*T2])

%Tc = TcVec(2)

if min(TcVec) > 0
    Tc = min(TcVec)
else
    if max(TcVec) < 0
        error('Nem lehet beállítani a Tc-t')
    else
        Tc = max(TcVec)
    end
end

Ti = T1 + T2 - Tc
Td = N*Tc

% PID átviteli függvény
%Ap = 1
Ap = 29
Wc = Ap/Ti * tf([Ti*(Td+Tc), Ti+Tc, 1], conv([1, 0], [Tc, 1]))

% Felnyitott kör átviteli függvénye
Wo = minreal(Wc * Wp)

% Bode
figure()
margin(Wo)
[Gm, Pm, wcg, wcp] = margin(Wo)

% Pm = 89.2 ami > 0 tehát stabil a rendszer
% Ha Pm negatív lenne, akkor instabil, Ha 0 akkor a stabilitás határán van

% Gm erősítés tartalék
% wcp vágási körfrekvencia

% Zárt kör átviteli függvénye
Wry = feedback(Wo, 1, -1)

infoWry = stepinfo(Wry)

figure()
step(Wry)

