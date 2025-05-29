clear all
close all
clc

% 1. szakasz megadása (10. hét)
b=100;      %súrlódási együttható
k=1000;     %rugóállandó
m=10000;    %tehetetlenségi tömeg

% 2. Állapotteres felírás
A = [0 1;-k/m -b/m];
B = [0;1/m];
C = [1 0];
D = 0;

suspension = ss(A,B,C,D)

% 3. A rendszer kiértékelése
figure()
step(suspension)

figure()
impulse(suspension)

% A sajátértékei
eig(A)
% A rendszer időállandója
T = -1./real(eig(A))

%% ÁLLAPOTTERES IRÁNYÍTÁS (11. hét)

% 1. Irányíthatósági mátrix
Mc = ctrb(A,B)
det(Mc)                  % a rszr. irányítható <=> Mc teljes rangú <=> det(Mc) != 0

% 2. zárt kör dinamikája
% zárt kör mátrixa: A-B*K
%   -> sajátértékei: sc1, sc2 (...)
%       - ne legyen rezgés <=> Im(sc1) = 0 és Im(sc2) = 0
%       - legyen stabil <=> sc1 < 0 és sc2 < 0
% sc -> T = -1/sc -> lecsengés = 5*T (ha Im != 0)

sc1 = -1/2      % -> T = 2 és nincs lecsengés
sc2 = -10/2     % -> T = 1/5 és nincs lecsengés

% Ackermann-formula (A-BK (állapotvisszacsatolás): A és B ismert, sajátértékek adottak -> K a kérdés)
K= acker(A,B, [sc1 sc2])

%% Állapotmegfigyelő (12. hét)

% 1. Alapjel miatti korrekció (cél: alapjel követése; y:=r)
%   AMx + BMu   = 0
%   CMx + 0u    = 1
%       -> Amat*Mxu = bVec
%       -> Mxu: sorvektor, amelynek első két eleme Mx, harmadik (utolsó)
%       eleme pedig Mu
Amat = [A B; C 0];
bVec = [0;0;1];
Mxu = Amat\bVec

% Mx és Mu kell a korrekciós erősítésekhez Simulinkben
Mx = Mxu(1:2)
Mu = Mxu(end)

% 2. Állapotmegfigyelő tervezése
%   Becslési hiba: x' = (A-GC)x
%       -> A-GC sajátértékei: so1, so2 (...)
%       -> a hiba lecseng, ha R(so1) < 0 és R(so2) < 0

% Megfigyelhetőségi mátrix
Mo = obsv(A, C)
det(Mo)             % a rendszer megfigyelhető <=> Mc teljes rangú <=> det(Mc) != 0

% Becslési hiba dinamika (sajátértékek, általában konstans szorosai az irányíthatóságinak)
so1 = 10 * sc1
so2 = 10 * sc2

% Állapotmegfigyelő mátrix az Ackermann formulávan (A-GC)
G = acker(A', C', [so1 so2])'