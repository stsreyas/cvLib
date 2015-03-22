% Sreyas Srimath Tirumala
% CSE5524 - HW5
% 10/4/2014

clc
clear all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem 1

tic

modelCovMatrix = [47.917 0 -146.636 -141.572 -123.269;
    0 408.250 68.487 69.828 53.479;
    -146.636 68.487 2654.285 2621.672 2440.381;
    -141.572 69.828 2621.672 2597.818 2435.368;
    -123.269 53.479 2440.381 2435.368 2404.923];

numFeatures = 5;

targetImg = imread('target.jpg');
[numRows, numCols] = size(targetImg(:, :, 1));

targetNumR = 70;
targetNumC = 24;

featureImg = zeros(numRows, numCols, numFeatures);
featureImg(:,:, 3:numFeatures) = targetImg;

rowIdxVector = (1:numRows)';
rowIdxMatrix = repmat(rowIdxVector, [1, numCols]);
colIdxVector = 1:numCols;
colIdxMatrix = repmat(colIdxVector, [numRows, 1]);
featureImg(:, :, 1) = colIdxMatrix;
featureImg(:, :, 2) = rowIdxMatrix;

covarianceImg = zeros(numRows, numCols, numFeatures*numFeatures);
distanceImg = 10 * ones(numRows, numCols);

min = 10^7;
minLocR = 0;
minLocC = 0;

for i = 1:numRows - targetNumR
    for j = 1:numCols - targetNumC
        locR = round((i + targetNumR/2));
        locC = round((j + targetNumC/2));
        tempFeatMat = featureImg(i:i+targetNumR-1, j:j+targetNumC-1, :);
        tempFeatVec = reshape(tempFeatMat, [targetNumR * targetNumC, numFeatures]); 
        covMat = cov(tempFeatVec, 1);
        V = eig(modelCovMatrix, covMat);
        distance = sum(log(V).^2);
        distance = sqrt(distance);
        if distance < min
            minLocR = i;
            minLocC = j;
            min = distance;
        end
        covarianceImg(locR, locC, :) = reshape(covMat, [1, numFeatures*numFeatures]);
        distanceImg(i, j) = distance;
    end
end

toc

figure(1)
imshow(targetImg);
rectangle('position',[minLocC, minLocR, targetNumC, targetNumR], 'EdgeColor', 'r', 'LineWidth', 4);

figure(2)
surf(distanceImg);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem 2 - Function Used in Problem 5

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem 3 - Function Used in Problem 5

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem 4 - Function Used in Problem 5

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem 5

img1 = imread('img1.jpg');
img2 = imread('img2.jpg');

center = [150.0, 175.0];
radius = 25;
numBins = 16;

modelNeighbors = double(circularNeighbors(img1, center(1, 1), center(1, 2), radius));
[q_model, modBinIdxVec] = colorHistogram(modelNeighbors, numBins, center(1, 1), center(1, 2), radius);

numIterations = 25;

Y = center;
shiftedDistance = zeros(numIterations, 1);

for i = 1:numIterations
    
    candidateNeighbors = double(circularNeighbors(img2, Y(1, 1), Y(1, 2), radius));
    [p_candidate, candBinIdxVec] = colorHistogram(candidateNeighbors, numBins, Y(1, 1), Y(1, 2), radius);
    weightsVector = meanshiftWeights(q_model, p_candidate, candBinIdxVec);
    
    sumWeights = sum(weightsVector);
    candNeighborLocs = candidateNeighbors(:, 1:2);
    weightedCandNeighborLoc = zeros(size(candNeighborLocs));
    weightedCandNeighborLoc(:, 1) = candNeighborLocs(:, 1) .* weightsVector;
    weightedCandNeighborLoc(:, 2) = candNeighborLocs(:, 2) .* weightsVector;
    sumCandNeighborLocs = sum(weightedCandNeighborLoc);
    newY = sumCandNeighborLocs ./ sumWeights;
    
    shiftedDistance(i, 1) = norm(newY - Y);
    Y = newY;
    
end

figure(3)
plot(1:25, shiftedDistance, 'r-');

figure(4)
imshow(img1)
figure(5)
imshow(img2)