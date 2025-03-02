clear all
close all
clc

% átviteli függvény
m = 100;
k = 15;
b = 10;

rendszer = tf(1, [m, b, k])

% pólus
polusok = pole(rendszer)
% negatív valós rész, komplex konjugált valós pár
% negatív rész miatt stabil
% komplex konjugált miatt van lengés

% statikus erősítés
erosites = dcgain(rendszer)

% ugrásválasz
figure()
step(rendszer)
% stabil és van benne lengés

% impulzusválasz
figure()
impulse(rendszer)

% bode diagram
figure()
bode(rendszer)

%%
clear all
close all
clc

%%
% 1.feladat
m = 100;
k = 150;
b = 10;

%%
% 2.feladat
m = 100;
k = 150;
b = 100;

%%
% 3.feladat
m = 100;
k = 150;
b = 2*sqrt(k*m);

% nincs lengés az ugrásválaszban
% jól szabályozott rendszer
% komplex konjugált pólus csillapítása miatt, nincs komplex rész jelenleg


%%
% 4.feladat
m = 100;
k = 150;
b = 4*sqrt(k*m);

%%

% átviteli függvény

rendszer = tf(1, [m, b, k])

% pólus
polusok = pole(rendszer)
% negatív valós rész, komplex konjugált valós pár
% negatív rész miatt stabil
% komplex konjugált miatt van lengés

% statikus erősítés
erosites = dcgain(rendszer)

% ugrásválasz
figure()
step(rendszer)
% stabil és van benne lengés

% impulzusválasz
figure()
impulse(rendszer)

% bode diagram
figure()
bode(rendszer)