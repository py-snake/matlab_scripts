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

%%
clear all
close all
clc

A = [-3, 0.8165, 0;
    0, -4, 1.5;
    0, -1.5, -4]

B = [0;
    0;
    1.633]

C = [1, 0, 0]

D = [0]

rendszer = ss(A, B, C, D)

sajatertek = eig(A)

% az első sajátérték egy valós szám, ami negatív (emiatt a rendszer stabil lenne)
% a második és harmadik sajátérték komplex konjugált párt alkot, valós részük negatív, így stabil rendszert eredményeznek

figure()
step(rendszer)

figure()
impulse(rendszer)

%%
clear all
close all
clc

A = [0, 1, 0;
    -0.25, 0, 1;
    0, 0, -4]

B = [0;
    0;
    1]

C = [1, 0, 0]

D = [0]

rendszer = ss(A, B, C, D)

sajatertek = eig(A)

figure()
step(rendszer)

figure()
impulse(rendszer)

% az egyik sajátérték egy valós szám, ami negatív (emiatt a rendszer stabil lenne)
% a másik két sajátérték komplex konjugált párt alkot, valós részük éppen nulla, így a rendszer a stabilitás határán van

t = 0:0.1:100;
figure()
step(rendszer, t)

figure()
impulse(rendszer, t)

%%

clear all
close all
clc

A = [-3, 0.8165, 0;
    0, -4, 1.5;
    0, -1.5, -4]

B = [0;
    0;
    1.6330]

C = [1, 0, 0]

D = [0]

rendszer = ss(A, B, C, D)

% Mi a karakterisztikus polinom? Mik a rendszer zérusai és pólusai?
% Ábrázoljuk a pólusokat és a zérusokat a komplex számsíkon. Mennyi a rendszer statikus erősítése?

szamlalo = 2
nevezo = [1, 11, 42.25, 54.75]

rendszer = tf(szamlalo, nevezo)

polusok = pole(rendszer)

gyokok = roots(nevezo)

sajatertek = eig(A)

% az első sajátérték egy valós szám, ami negatív; a második és
% harmadik sajátérték komplex konjugált párt alkot, valós részük
% negatív, így stabil rendszert eredményeznek

% az átviteli függvény számlálójának gyökei a zérusok
% a pólusokhoz hasonlóan a zérusokat is többféleképpen számíthatjuk Matlabban
% számíthatjuk a zero függvénnyel, amit a teljes rendszerre kell hívni

zerusokv1 = zero(rendszer)
zerusokv2 = roots(szamlalo)

% mindegyik esetben ugyanazt kapjuk, egy üres vektort, mivel ennek
% a rendszernek nincsenek zérusai (a számláló csak egy konstans)

% a rendszer pólusait és zérusait a pzmap (pole-zero map) segítségével ábrázolhatjuk; a pólusokat x, a zérusokat o jelöli

figure()
pzmap(rendszer)

% a rendszer statikus erősítését a dcgain segítségével számíthatjuk

statikus_erosites = dcgain(rendszer)

% a statikus erősítés megmondja, hogy a rendszer ugrásválasza hová áll be állandósult állapotban (ha a rendszer stabil)

figure()
step(rendszer)

%%

clear al
close all
clc

szamlalo = 2
nevezo = conv(conv([3, 1], [5, 1]), [10, 1])

rendszer = tf(szamlalo, nevezo)

%%

clear all
close all
clc

z = []
p = [-3, -4.0000 + 1.5000i, -4.0000 - 1.5000i]
k = 2

rendszer = zpk(z, p, k)

figure()
bode(rendszer)
grid

%%

clear all
close all
clc

