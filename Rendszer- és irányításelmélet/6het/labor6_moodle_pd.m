clear all
close all
clc

%szakasz
Wp = tf(0.1, conv(conv([1 0], [1 1]), [2 1]))

%PD szabalyozo atv. fv.
Ap = 3.55
N = 10;
T = 2;

Tc = T/(N+1)
Td = N*Tc

Wc = Ap*tf([Td+Tc 1],[Tc 1]) % tf(Ap*[Td+Tc 1],[Tc 1])

%felnyitott kor atv. fv
Wo = minreal(Wp*Wc)

%erositestartalek és fazistartalek
figure()
margin(Wo)
[Gm, Pm, wcg, wcp] = margin(Wo)

%zart atv. fv
Wry = feedback(Wo,1,-1)
figure()
step(Wry)

%marado hiba
e = 1-dcgain(Wry)

%informaciok zart korre
infoWry = stepinfo(Wry)
infoWry.Overshoot

%zaravo jel es hibajel kozotti atv. fv
Wde1 = -feedback(Wp,Wc,-1) %ez ugyanaz: Wde = feedback(-Wp,Wc,1)
figure()
step(Wde1)
figure()
step(Wde2)

%referencia jel es beavatkozo jel kozott atv. fv
Wru = feedback(Wc,Wp,-1)
figure()
step(Wru)
infoWru = stepinfo(Wru)

