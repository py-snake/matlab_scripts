clear all % torli a valtozokat
close all %bezarja az abrakat
clc %torli a commandot

%parameterek
m = 100;
k = 15;
b = 10;

%atviteli fv
mech = tf(1, [m b k])

%polusok
poles = pole(mech)

%statikus erosites
stat = dcgain(mech)

%uj abra
figure()
%impulzusvalasz
impulse(mech)

figure()
%ugrasvalasz
step(mech)

figure()
%Bode diagram
bode(mech)

figure()
%polus-zerus eloszlas
pzmap(mech)


