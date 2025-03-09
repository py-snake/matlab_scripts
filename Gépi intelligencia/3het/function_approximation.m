clear all
close all
clc

%%

% Adatok létrehozása
x = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];
y = [1.1052, 1.2214, 1.3499, 1.4918, 1.6487, 1.8221, 2.0138, 2.2255, 2.4596, 2.7183];

% Táblázat létrehozása
data_table = table(x', y', 'VariableNames', {'x', 'y'});

% Excel fájlba írás
writetable(data_table, 'data.xlsx');

%%

% Excel fájl beolvasása
data_table = readtable('data.xlsx');

% Adatok kinyerése
x = data_table.x;
y = data_table.y;

% Eredmények megjelenítése
disp('x értékek:');
disp(x);
disp('y értékek:');
disp(y);

%%

% Neurális háló létrehozása
hiddenLayerSize = [10, 10];  % Rejtett réteg mérete
net = fitnet(hiddenLayerSize);

% Tanítási adatok beállítása
net.divideParam.trainRatio = 70/100;  % 70% tanítási adat
net.divideParam.valRatio = 15/100;    % 15% validációs adat
net.divideParam.testRatio = 15/100;   % 15% tesztelési adat

net.trainParam.epochs = 1000;  % Alapértelmezett 1000 iteráció
net.trainParam.lr = 0.01;  % Alacsonyabb tanulási ráta a pontosabb eredményekért

% Neurális háló tanítása
[net, tr] = train(net, x', y');

% Tanítási eredmények megjelenítése
figure;
plotperform(tr);
title('Neurális háló tanítási teljesítménye');

%%

% Előrejelzés a tanított hálóval
x_pred = linspace(0.1, 3, 100);  % 100 pont az x tengelyen
y_pred = net(x_pred);              % Előrejelzés (x_pred már sorvektor)

% Eredeti adatok és előrejelzés ábrázolása
figure;
plot(x, y, 'bo', 'DisplayName', 'Eredeti adatok');
hold on;
plot(x_pred, y_pred, 'r-', 'DisplayName', 'Neurális háló előrejelzés');
xlabel('x');
ylabel('y');
legend;
title('e^x függvény közelítése neurális hálóval');
grid on;

%%

% Új pont előrejelzése (pl. x = 1.1)
x_new = 1.1;
y_new = net(x_new);

fprintf('Az előrejelzett érték x = %.2f-nél: %.4f\n', x_new, y_new);
