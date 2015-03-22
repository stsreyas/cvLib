function [ w ] = meanshiftWeights(q_model, p_test, binIdxVec)

[numR, ~] = size(binIdxVec);
w = zeros(numR, 1);

% centerLoc1 = binIdxVec(centerIdx, 1);
% centerLoc2 = binIdxVec(centerIdx, 2);
% centerLoc3 = binIdxVec(centerIdx, 3);

for i = 1:numR
    loc1 = binIdxVec(i, 1);
    loc2 = binIdxVec(i, 2);
    loc3 = binIdxVec(i, 3);
    w(i, 1) = sqrt(q_model(loc1, loc2, loc3) / p_test(loc1, loc2, loc3));
end

end