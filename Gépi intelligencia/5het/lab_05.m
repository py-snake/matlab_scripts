clear all;
close all;
clc;

% Step 1: Load the data
data = readtable('data2.xlsx');  % Replace with your file name

% Step 2: Handle missing values
data = rmmissing(data);  % Remove rows with missing values

% Step 3: Prepare the data for clustering
numericData = data{:, :};  % Convert table to numeric matrix

% Step 4: Perform K-means clustering
k = 3;  % Number of clusters
[idx, centroids] = kmeans(numericData, k);

% Step 5: Visualize K-means clustering results
figure;
scatter3(numericData(:, 1), numericData(:, 2), numericData(:, 3), 10, idx, 'filled');
hold on;
plot3(centroids(:, 1), centroids(:, 2), centroids(:, 3), 'kx', 'MarkerSize', 10, 'LineWidth', 2);
title('K-means Clustering');
xlabel('Age');
ylabel('Gender');
zlabel('BMI');
legend('Cluster 1', 'Cluster 2', 'Cluster 3', 'Centroids');
hold off;

% Step 6: Save K-means clustering results
results = array2table([numericData, idx], 'VariableNames', {'Age', 'Gender', 'BMI', 'Cluster'});
writetable(results, 'clustered_results.xlsx');

% Step 7: Perform Hierarchical Clustering and Plot Dendrogram
Z = linkage(numericData, 'ward');  % Use 'ward' method for linkage
figure;
dendrogram(Z);
title('Dendrogram for Hierarchical Clustering');
xlabel('Data Points');
ylabel('Distance');

%%
clear all;
close all;
clc;

% Load the Iris dataset
load fisheriris;

% Combine the four features into a matrix
X = [meas(:, 1), meas(:, 2), meas(:, 3), meas(:, 4)];

% Apply k-means clustering with k=3
k = 3;
[idx, centroids] = kmeans(X, k);

% Plot the K-means clustering results
figure;
gscatter(X(:, 1), X(:, 2), idx, 'bgr', '.', 10);
hold on;
plot(centroids(:, 1), centroids(:, 2), 'kx', 'MarkerSize', 15, 'LineWidth', 3);
legend('Cluster 1', 'Cluster 2', 'Cluster 3', 'Centroids');
title('K-Means Clustering Results');
xlabel('Sepal Length');
ylabel('Sepal Width');
hold off;

% Perform Hierarchical Clustering and Plot Dendrogram
Z = linkage(X, 'ward');  % Use 'ward' method for hierarchical clustering
figure;
dendrogram(Z);
title('Dendrogram for Hierarchical Clustering');
xlabel('Data Points');
ylabel('Distance');
