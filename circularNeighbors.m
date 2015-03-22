function [X] = circularNeighbors(img,x,y,radius)

[numR, numC] = size(img);
if floor(y - radius) >= 1
    startR = floor(y - radius);
else
    startR = 1;
end

if ceil(y + radius) <= numR
    endR = ceil(y + radius);
else
    endR = numR;
end

if floor(x - radius) >= 1
    startC = floor(x - radius);
else
    startC = 1;
end

if ceil(x + radius) <= numC
    endC = ceil(x + radius);
else
    endC = numC;
end
% regionOfInterest = img(startR:endR, startC:endC);

featureVec = [];
for i = startR:endR
    for j = startC:endC
        distanceFromCenter = sqrt( (i - y)^2 + (j - x)^2);
        if distanceFromCenter < radius
            tempVec = [j, i, img(i, j, 1), img(i, j, 2), img(i, j, 3)];
            featureVec = vertcat(featureVec, tempVec);
        end
    end
end
X = featureVec;
end