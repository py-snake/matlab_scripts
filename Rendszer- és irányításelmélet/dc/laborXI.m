clear all
close all
clc

%mechanikai lengőrendszer állapotteres leírása
m = 100
b = 2
k = 1

A = [0 1;-k/m -b/m]
B = [0;1/m]
C = [1 0]
D = 0

rendszer = ss(A,B,C,D)

%minőségi viselkedés
sajatertekek = eig(A)

% figure()
% step(rendszer) %ugrásválasz
% impulse(rendszer) % impulzusválasz
%irányíthatóság
Mc = ctrb(A,B) %irányíthatósági mátrix
det(Mc) % ha nem nulla, akkor irányítható a rendszer

%állapotvisszacsatolás
sc1 = -1/4 % ezt kell kiszámolni a lecsengés alapján!
sc2 = 5*sc1 %ez csak gyorsabb hogy domináns legyen az sc1.

K = acker(A,B,[sc1 sc2])

%zárt kör dinamikája
zartSajatertekek = eig(A-B*K)

%alapjel miatti korrekció

Mxu = [A B;C 0]\[0;0;1] %[x1;x2;y] az osztóba, és csak ott lenne a változás
Mx = Mxu(1:2) % ez az x változós történet
Mu = Mxu(3) % ez a kimenet

%megfigyelő

%megfigyelhetőség
Mo = obsv(A,C) %megfigyelhetőségi mátrix
det(Mo) %ha nem nulla, akkor megfigyelhető a rendszer

%állapotbecslés hibájának a dinamikája
so1 = 10*sc1 %nem tudni mitől 10-es szorzás
so2 = 10*sc2

G = acker(A',C',[so1 so2])' %először Gtranszponáltat kapok és ezért kell transzponálni mert (A' - C'G')

%terhelésbecslő

%kibővített rendszer modellje (zavarás egy fiktív állapot)
Ah = [A B; 0 0 0] % Az A az x-ektől függ, B a zavarástól (d)-től függ; a 0-ák: x1, x2, d
%ha már x1,x2,x3,d lenne, akkor Ah = [A B; 0 0 0 0]
Bh = [B;0] % megfelelő méretű a mátrix, ki kell bővíteni 1-el ugye a vektor miatt, mert a zavarás állapota nem függ a bemenettől (ez a B0 u lesz)
Ch = [C 0] %ne függjön a zavarástól, zavarás mentes legyen

%megfigyelhetőség
Moh = obsv(Ah,Ch) %megfigyelhetőségi mátrix
det(Moh) % ha nem nulla, akkor a kibővített rendszer megfigyelhető

%terhelésbecslő hibadinamikája
soh1 = so1
soh2 = so2
soh3 = so2 %azért 2 db so2, mert 3x3-as mátrix lett az állapot mátrix x1, x2, d-s lett, és mivel van egy 0-ás sor, emiatt egyik saját érték multiplicitása 2.

Gh = acker(Ah',Ch',[soh1 soh2 soh3])'

