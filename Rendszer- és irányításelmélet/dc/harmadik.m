clear all
close all
clc

% szakasz
Wp = tf(1, conv([1 1],[10,1]));
% szabályzó (P)
Wc = tf(1.5,1); %Wp = 1.5 (erősítésként viselkedik)
% ez negatív visszacsatolás
%felnyitott kör 
Wo = Wc * Wp;
%atviteli fv alapjel (referencia jel) --> kimeneti jel között
% r --> y
Wry = feedback(Wo, 1,-1) %1 = nincs semmi a visszacsatoló ágban, -1, mert negatív visszacsatolás
%átviteli fv alapjel ---> beavatkozó jel között
% r --> u

Wru = feedback(Wc, Wp, -1)

%zárt kör és a felnyitott kör ugrásválasza
figure()
step(Wo,Wry)
legend('Felnyitott kör','Zárt kör')

% zavarás és a hibajel közötti átviteli fv.
% d ---> e

Wde = feedback(-Wp, Wc, 1)
Wde = -feedback(Wp, Wc, -1) % ezt szeretjük
figure()
step(Wde)
