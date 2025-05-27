clear all
close all
clc

%szakasz atv. fv
Wp = tf(10, conv(conv([1 1], [2 1]),[5 1]))

%szabalyozo atv. fv (P tag)
Ap = 0.25;
Wc = Ap

%felnyitott kor atv fv
Wo = Wp*Wc

%bode a felnyitott korre
figure()
margin(Wo)
[Gm, Pm, wcg, wcp] = margin(Wo)

%zart kor atv. fv
Wry = feedback(Wo,1,-1)

%ugrasvalasz Wry-ra (zart korre)
figure()
step(Wry)

%zart kor polusai
p = pole(Wry)

%marado hiba
e = 1-dcgain(Wry)

%informaciok a zart korre
info = stepinfo(Wry);
tulloves = info.Overshoot
T2 = info.SettlingTime

%Wru atviteli fv (beavatkozo jelet vizsgalja)
Wru = feedback(Wc,Wp,-1)
figure()
step(Wru)

%maximalis beavatkozo jel
infoWru = stepinfo(Wru);
maxBeavatkozo = infoWru.Peak
