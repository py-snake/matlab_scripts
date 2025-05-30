%Matlab R2023a verzió van a gépen!!
clear all % töröljük a változókat
close all % bezárjuk az ábrákat
clc % töröljük a command window tartalmát

%rendszer mátrixait megadjuk
A = [2 5 2.3; 1 0 3; 0 -4.1 5]
B = [1;-1;-2]
C = [-1 -2 3]
D = 0 % ez egy konstans emiatt 0

%állapotteres leírás -> ez írja le a rendszert

rendszer = ss(A,B,C,D)

% stabilitás vizsgálat sajátértékekkel
s = eig(A) % instabil (nem minden sajátérték valós rész negatív), lesz lengés az ugrásválaszban (és el is száll a végén)

%ugrásválasz
figure()
step(rendszer) %nem tart 1-hez hanem a végtelenbe, instabil
%impulzusválasz
figure()
impulse(rendszer) %mivel nem tart 0-hoz, instabil

%% % mintha új script lenne ez
clear all % töröljük a változókat
close all % bezárjuk az ábrákat
clc % töröljük a command window tartalmát

%átviteli függvény 
rendszer = tf(2, [1 11 42.25 54.75]) % a kitevők s-nél csökkenő sorrendbe vannak elemenként
%futtasd a run section-ös cuccal hogy ne legyen hiba

% pólusok
p = pole(rendszer) % ez stabil de van benne lengés a komplex konjugált pár miatt

%zérus helyek
z = zero(rendszer) % üres a vektor

%pólus zérus eloszlás
figure()
pzmap(rendszer)

%statikus erősítés
statE = dcgain(rendszer)

%átviteli függvény (conv utasítással)
rendszer2 = tf(2, conv(conv([3 1],[5 1]),[10 1]))



