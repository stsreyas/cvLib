%% This function finds the local minimas in the region described by minPeakWidth
function [localMaximas] = findLocalMaximas(data, minPeakWidth, numPeaks)

[numR, ~] = size(data);
peakVals = [];
peakLocs = [];
ctr = 0;
for i = (minPeakWidth/2) + 1:(numR - minPeakWidth/2 - 1)
    dataSubSample = data((i - minPeakWidth/2) : (i + minPeakWidth/2));
    val = data(i, 1);
    maxVal = max(dataSubSample);
    if val == maxVal
        peakVals = vertcat(peakVals, val);
        peakLocs = vertcat(peakLocs, i);
        ctr = ctr + 1;
    end
end

peakVals = sort(peakVals);
if numPeaks < ctr
    localMaximas = peakVals(end - numPeaks + 1:end);
else
    localMaximas = peakVals(end - ctr + 1:end);
end    

end