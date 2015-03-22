function [newLocation] = performMeanShiftTracking(img1, img2, location)

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

newLocation = Y;
% figure(3)
% plot(1:25, shiftedDistance, 'r-');
% 
% figure(4)
% imshow(img1)
% figure(5)
% imshow(img2)

end