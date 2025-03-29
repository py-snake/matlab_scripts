%% MATLAB Cats vs Dogs Clustering Project (No Deep Learning Toolbox)
clear; close all; clc;

%% Step 1: Prepare Dataset
% Set paths
datasetPath = 'dogs_vs_cats/train';
outputPath = 'clustered_results';
if ~exist(outputPath, 'dir')
    mkdir(outputPath);
end

% Get image files
dogFiles = dir(fullfile(datasetPath, 'dog.*.jpg'));
catFiles = dir(fullfile(datasetPath, 'cat.*.jpg'));

% Use a subset for faster processing (100 from each)
numSamples = 20000;
dogFiles = dogFiles(1:min(numSamples, length(dogFiles)));
catFiles = catFiles(1:min(numSamples, length(catFiles)));

allFiles = [dogFiles; catFiles];
trueLabels = [ones(length(dogFiles), 1); 2*ones(length(catFiles), 1)]; % 1=dog, 2=cat

% Shuffle the dataset
rng(42); % For reproducibility
shuffleIdx = randperm(length(allFiles));
allFiles = allFiles(shuffleIdx);
trueLabels = trueLabels(shuffleIdx);

%% Step 2: Feature Extraction (No Deep Learning Toolbox)
% We'll use color histograms and texture features

% Parameters
histBins = 32; % Number of bins for color histograms
resizeSize = [256 256]; % Resize images to this size for consistency

% Prepare to store features
% Features: [Rhist Ghist Bhist GrayHist TextureFeatures]
features = zeros(length(allFiles), histBins*4 + 6); 

% Process each image
for i = 1:length(allFiles)
    imgPath = fullfile(allFiles(i).folder, allFiles(i).name);
    
    try
        img = imread(imgPath);
        
        % Resize image for consistency
        img = imresize(img, resizeSize);
        
        % Convert to appropriate color spaces
        if size(img, 3) == 1
            img = cat(3, img, img, img); % Convert grayscale to RGB
        end
        grayImg = rgb2gray(img);
        
        % 1. Color histograms (RGB)
        histR = imhist(img(:,:,1), histBins)';
        histG = imhist(img(:,:,2), histBins)';
        histB = imhist(img(:,:,3), histBins)';
        
        % 2. Grayscale histogram
        histGray = imhist(grayImg, histBins)';
        
        % 3. Texture features (using gray-level co-occurrence matrix)
        glcm = graycomatrix(grayImg, 'Offset', [0 1; -1 1; -1 0; -1 -1]);
        stats = graycoprops(glcm, {'Contrast', 'Correlation', 'Energy', 'Homogeneity'});
        textureFeatures = [mean(stats.Contrast) mean(stats.Correlation) ...
                         mean(stats.Energy) mean(stats.Homogeneity)];
        
        % 4. Edge features
        edgeDensity = sum(sum(edge(grayImg, 'canny'))) / numel(grayImg);
        sharpness = var(double(grayImg(:)));
        
        % Combine all features
        features(i, :) = [histR, histG, histB, histGray, textureFeatures, edgeDensity, sharpness];
        
        fprintf('Processed image %d/%d\n', i, length(allFiles));
    catch
        fprintf('Error processing image: %s\n', imgPath);
        features(i, :) = NaN;
    end
end

% Remove any images that failed processing
validIdx = ~any(isnan(features), 2);
features = features(validIdx, :);
allFiles = allFiles(validIdx);
trueLabels = trueLabels(validIdx);

%% Step 3: Normalize Features
% Normalize each feature to 0-1 range
minVals = min(features);
maxVals = max(features);
features = (features - minVals) ./ (maxVals - minVals);

%% Step 4: Dimensionality Reduction (for visualization)
% Reduce features to 2D using PCA
[coeff, score, ~, ~, explained] = pca(features);
reducedFeatures = features * coeff(:, 1:2);

% Plot the data in PCA space
figure;
gscatter(reducedFeatures(:, 1), reducedFeatures(:, 2), trueLabels, 'rb', 'xo');
title('PCA of Cat and Dog Images');
xlabel('Principal Component 1');
ylabel('Principal Component 2');
legend('Dog', 'Cat');
grid on;

%% Step 5: Clustering
% We'll use k-means clustering (k=2 for cats and dogs)
numClusters = 2;
[idx, centroids] = kmeans(features, numClusters, 'Replicates', 5);

% Evaluate clustering accuracy
% Find which cluster corresponds to which true label
cluster1DogRatio = sum(trueLabels(idx == 1) == 1) / sum(idx == 1);
if cluster1DogRatio < 0.5
    % If cluster 1 has mostly cats, swap labels
    idx = 3 - idx; % Swap 1 and 2
end

% Calculate accuracy
accuracy = sum(trueLabels == idx) / length(trueLabels);
fprintf('Clustering accuracy: %.2f%%\n', accuracy * 100);

% Plot clustered data
figure;
gscatter(reducedFeatures(:, 1), reducedFeatures(:, 2), idx, 'rb', 'xo');
title('K-means Clustering Results (2 clusters)');
xlabel('Principal Component 1');
ylabel('Principal Component 2');
legend('Dog Cluster', 'Cat Cluster');
grid on;

%% Step 6: Save Clustered Images to Folders
% Create folders for clustered results
clusterFolders = {'dogs', 'cats'};
for i = 1:length(clusterFolders)
    if ~exist(fullfile(outputPath, clusterFolders{i}), 'dir')
        mkdir(fullfile(outputPath, clusterFolders{i}));
    end
end

% Copy images to appropriate folders
for i = 1:length(allFiles)
    imgPath = fullfile(allFiles(i).folder, allFiles(i).name);
    if idx(i) == 1
        destination = fullfile(outputPath, 'dogs', allFiles(i).name);
    else
        destination = fullfile(outputPath, 'cats', allFiles(i).name);
    end
    copyfile(imgPath, destination);
end

fprintf('Clustered images saved to %s folder\n', outputPath);

%% Step 7: Visualize Some Results
% Display sample images from each cluster
numSamplesToShow = 5;

figure('Name', 'Sample Dog Cluster Images', 'Position', [100, 100, 800, 300]);
dogClusterFiles = dir(fullfile(outputPath, 'dogs', '*.jpg'));
for i = 1:min(numSamplesToShow, length(dogClusterFiles))
    subplot(1, numSamplesToShow, i);
    img = imread(fullfile(dogClusterFiles(i).folder, dogClusterFiles(i).name));
    imshow(img);
    title(sprintf('Dog %d', i));
end

figure('Name', 'Sample Cat Cluster Images', 'Position', [100, 100, 800, 300]);
catClusterFiles = dir(fullfile(outputPath, 'cats', '*.jpg'));
for i = 1:min(numSamplesToShow, length(catClusterFiles))
    subplot(1, numSamplesToShow, i);
    img = imread(fullfile(catClusterFiles(i).folder, catClusterFiles(i).name));
    imshow(img);
    title(sprintf('Cat %d', i));
end