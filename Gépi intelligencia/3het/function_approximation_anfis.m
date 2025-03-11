%% Környezet tisztítása
clear; close all; clc;

%% Adatok inicializálása
filename = 'data.xlsx';

% Ha a fájl nem létezik, létrehozzuk
if ~isfile(filename)
    disp('Az adatfájl nem található, létrehozás...');
    x = linspace(0, 5, 200)'; % 200 egyenletes pont [0,5] között
    y = exp(x);               % e^x függvény kiszámítása
    data = [x, y];
    writematrix(data, filename); % Újabb MATLAB verziókhoz (xlswrite helyett)
    disp('Adatfájl létrehozva!');
end

%% Adatok beolvasása
disp('Adatok beolvasása...');
data = readmatrix(filename);
x = data(:,1); % Bemeneti adatok
y = data(:,2); % Kimeneti adatok

%% Normalizáció (logaritmikus transzformáció az e^x miatt)
disp('Adatok normalizálása...');
x_min = min(x);
x_max = max(x);
x_norm = (x - x_min) / (x_max - x_min); % Normalizált x

y_log = log(y); % Logaritmikus transzformáció az y-ra
y_min = min(y_log);
y_max = max(y_log);
y_norm = (y_log - y_min) / (y_max - y_min); % Normalizált y

%% ANFIS modell létrehozása és tanítása
disp('ANFIS modell létrehozása...');
% Adatok előkészítése
data_norm = [x_norm, y_norm]; % Normalizált adatok

% A genfis paraméterei: rács alapú felosztás (GridPartition), 5 szabály, gaussian görbék
fis = genfis1(data_norm, 5, 'gbellmf'); % Genfis a megfelelő beállításokkal

% Tanítás
disp('ANFIS tanítása...');
[train_fis, train_error] = anfis(data_norm, fis, 100);

%% Előrejelzés készítése
disp('Előrejelzés készítése...');
y_pred_norm = evalfis(train_fis, x_norm); % MATLAB új szintaxis

% Denormalizáció és visszaalakítás exponenciális skálára
y_pred_log = y_pred_norm * (y_max - y_min) + y_min;
y_pred = exp(y_pred_log);

%% Eredmények ábrázolása
disp('Eredmények megjelenítése...');
figure;
plot(x, y, 'bo', 'DisplayName', 'Valós e^x adatok');
hold on;
plot(x, y_pred, 'r-', 'LineWidth', 2, 'DisplayName', 'ANFIS előrejelzés');
legend;
xlabel('x');
ylabel('e^x');
title('ANFIS Model - Exponenciális függvény becslése');
grid on;

disp('ANFIS model tréning és előrejelzés befejezve.');
