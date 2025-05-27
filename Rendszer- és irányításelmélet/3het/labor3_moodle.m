clear all
close all
clc

%szakasz atv. fv
Wp = tf(40, conv([1 1],[10 1]))

%szabalyozo atv. fv
Wc = tf(1.5,1) % Wc = 1.5

%felnyitot kor
Wo = Wc*Wp

%ugrasvalasz a Wo-ra
%figure()
%step(Wo)

%zart kor atviteli fv
Wry = feedback(Wo,1,-1)

%ugrasvalasz Wry-ra
%figure()
%step(Wry)

%ugrasvalaszok
figure()
step(Wo)
hold on
step(Wry)
legend('Felnyitott kör','Zárt kör')

%zart kor erositese (statikus erosites)
sE = dcgain(Wry)

%referencia (r) --> hibajel(e) atv. fv
Wre = feedback(1,Wo,-1)
figure()
step(Wre)

%marado hiba
e = 1-dcgain(Wry)

%stepinfo zart korre
info = stepinfo(Wry)

%polusok
p = pole(Wry)
