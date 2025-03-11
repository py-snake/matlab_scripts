clear all
close all
clc

%% Adatok létrehozása
x = linspace(0.1, 1.0, 20);  % 20 pont az x tengelyen (0.1-től 1.0-ig egyenletesen elosztva)
y = exp(x);  % y = e^x értékek

% Adatok megjelenítése
disp('x értékek:');
disp(x);
disp('y értékek:');
disp(y);

%% Táblázat létrehozása és Excel fájlba írás
data_table = table(x', y', 'VariableNames', {'x', 'y'});
writetable(data_table, 'data.xlsx');
disp('Az adatok sikeresen ki lettek írva a data.xlsx fájlba.');

%% Excel fájl beolvasása (opcionális)
data_table = readtable('data.xlsx');
x = data_table.x;
y = data_table.y;

%% ANFIS modell létrehozása és tanítása
% Bemeneti-adat párok létrehozása
data = [x, y];

% ANFIS modell inicializálása
num_mfs = 5;  % Tagsági függvények száma
epoch_n = 100;  % Tanítási iterációk száma

% genfisOptions használata a tagsági függvények konfigurálásához
options = genfisOptions('GridPartition');  % Rács particionálás használata
options.NumMembershipFunctions = num_mfs;  % Tagsági függvények száma
options.InputMembershipFunctionType = 'gbellmf';  % Gomb-függvény használata

% ANFIS modell létrehozása
fis = genfis(data(:, 1), data(:, 2), options);

% ANFIS tanítása (csak 3 kimeneti argumentummal, mivel nincs validációs adat)
[fis, train_error, step_size] = anfis(data, fis, epoch_n);

%% Előrejelzés
x_pred = linspace(0.1, 3, 100);  % 100 pont az x tengelyen
y_pred = evalfis(x_pred', fis);  % Előrejelzés ANFIS-szel

%% Eredmények ábrázolása
figure;
plot(x, y, 'bo', 'DisplayName', 'Eredeti adatok');
hold on;
plot(x_pred, y_pred, 'r-', 'DisplayName', 'ANFIS előrejelzés');
xlabel('x');
ylabel('y');
legend;
title('e^x függvény közelítése ANFIS-szel');
grid on;

%% Új pont előrejelzése (pl. x = 1.1)
x_new = 1.1;
y_new = evalfis(x_new, fis);  % Előrejelzés ANFIS-szel

fprintf('Az előrejelzett érték x = %.2f-nél: %.4f\n', x_new, y_new);

