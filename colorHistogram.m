%% This function generates a weighted color histogram of the pixels given in X
% the histogram cube is bins x bins x bins size and is weighted using the
% epanechnikov kernel around x,y with a bandwidth of h
function [H, binIdxVec] = colorHistogram(X, bins, x, y, h)

% Assuming an x,y,r,g,b format
numC = 5;
H = zeros(bins, bins, bins);
[numR, ~] = size(X);

binSize = round(256/bins);
startVal = 0;
endVal = binSize - 1;

binVec = zeros(bins, 2);
binIdxVec = zeros(numR, 3);

for i = 1:bins
    binVec(i, 1) = startVal;
    binVec(i, 2) = endVal;
    startVal = endVal + 1;
    endVal = endVal + binSize;
end

centerVec = [x, y];
% centerVecRep = repmat(centerVec, [numR, 1]);
% distMat = norm(X(:, 1:2) - centerVecRep);
% minDist = min(distMat);
% [centerIdx, ~] = find(distMat == minDist);

for i = 1:numR
    
    locX = X(i, 1);
    locY = X(i, 2);
    loc = double([locX, locY]);
    distance = norm((loc - centerVec) / h)^2;
    kr = epanichnikovKernel(distance);
    r = X(i, 3);
    g = X(i, 4);
    b = X(i, 5);
    idxVec = zeros(3, 1);
    for j = 1:bins
        if r >= binVec(j, 1) && r <= binVec(j, 2)
            idxVec(1, 1) = j;
        end
        if g >= binVec(j, 1) && g <= binVec(j, 2)
            idxVec(2, 1) = j;
        end
        if b >= binVec(j, 1) && b <= binVec(j, 2)
            idxVec(3, 1) = j;
        end
    end
    
    H(idxVec(1, 1), idxVec(2, 1), idxVec(3, 1)) = H(idxVec(1, 1), idxVec(2, 1), idxVec(3, 1)) + kr;
    binIdxVec(i, :) = idxVec';
end

% normalize to ensure that the histogram sums to 1
histSum = sum(H(:));
H = H ./ histSum;

end

function [output] = epanichnikovKernel(distance)

if distance < 1
    output = 1 - distance;
else
    output = 0;
end

end