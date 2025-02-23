%%
% Legyen egy LTI rendszer állapotteres alakja az alábbi egyenletekkel leírható:
% x1 = 2x1 + 5x2 + 2.3x3 + u
% x2 = x1 + 3x3 - u
% x3 = -4.1x2 + 5x3 -2u
% y = -x1 - 2x2 + 3x3

clear all
close all
clc

% x1= x1, x2, x3
A = [2, 5, 2.3;
    1, 0, 3;
    0, -4.1, 5]

%    u
B = [1;
    -1;
    -2]

% y= x1 x2 x3
C = [-1, -2, 3]

% y  u
D = [0]

% állapotváltozók száma: 3 (x1, x2, x3)
% bemenetek száma: 1 (u)
% kimenetek száma: 1 (y)
% SISO rendszer (egy bemenet, egy kimenet)

% Adjuk meg a rendszert Matlabban! Számítsuk ki az 𝐴 mátrix
% sajátértékeit! Döntsük el, hogy a rendszer stabil-e! Lehet-e a rendszer
% ugrás- és impulzusválaszában lengés? Rajzoltassuk ki a rendszer
% ugrásválaszát és impulzusválaszát!

% létrehozzuk a rendszert az ss függvénnyel (state-space, azaz állapottér)
rendszer = ss(A, B, C, D)

% egy mátrix sajátértékeit az eig (eigenvalue) paranccsal számíttathatjuk ki

sajatertek = eig(A)

% az ugrásválaszt a step függvénnyel rajzoltatjuk ki

figure()
step(rendszer)

% az impulzusválaszt a impulse függvénnyel rajzoltatjuk ki

figure()
impulse(rendszer)

%  az ugrásválasz és az impulzusválasz összehasonlítása a [0,1] intervallumban

t = 0:0.01:1;
figure()
step(rendszer, t)
hold on
figure()
impulse(rendszer, t)
hold off

