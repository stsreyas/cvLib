%% This function returns the similitude moments vector for a given image
% This function does not assume a binary image input and grayscale images
% can be given as arguments.
function [similitudeMomentsVec] = CalculateSimilitudeMoments(img)

% calculate the first order moments
[m00, m01, m10] = CalculateFirstOrderMoments(img);

% calculate the centroid (xBar, yBar)
xBar = m10 / m00;
yBar = m01 / m00;

similitudeMomentsVec = zeros(1, 7);
% calculate the sum of all image pixel values
[rows, cols] = size(img);
sumImgVals = sum(img(:));

mu02 = 0;
mu03 = 0;
mu11 = 0;
mu12 = 0;
mu20 = 0;
mu21 = 0;
mu30 = 0;

% i(rows) correspond to y in the equation and j(columns) correspond to x
for i = 1:rows
    for j = 1:cols
        % calculating the moment values according to the formula
        xMinusXBar = j - xBar;
        yMinusYBar = i - yBar;
        mu02 = mu02 + xMinusXBar^0 * yMinusYBar^2 * img(i,j);
        mu03 = mu03 + xMinusXBar^0 * yMinusYBar^3 * img(i,j);
        mu11 = mu11 + xMinusXBar^1 * yMinusYBar^1 * img(i,j);
        mu12 = mu12 + xMinusXBar^1 * yMinusYBar^2 * img(i,j);
        mu20 = mu20 + xMinusXBar^2 * yMinusYBar^0 * img(i,j);
        mu21 = mu21 + xMinusXBar^2 * yMinusYBar^1 * img(i,j);
        mu30 = mu30 + xMinusXBar^3 * yMinusYBar^0 * img(i,j);
    end
end

% dividing with the ((i+j)/2) + 1 raised power of the image summation
mu02 = mu02 / sumImgVals^2;
mu03 = mu03 / sumImgVals^2.5;
mu11 = mu11 / sumImgVals^2;
mu12 = mu12 / sumImgVals^2.5;
mu20 = mu20 / sumImgVals^2;
mu21 = mu21 / sumImgVals^2.5;
mu30 = mu30 / sumImgVals^2.5;

% populating the similitude moments vector.
similitudeMomentsVec(1,1) = mu02;
similitudeMomentsVec(1,2) = mu03;
similitudeMomentsVec(1,3) = mu11;
similitudeMomentsVec(1,4) = mu12;
similitudeMomentsVec(1,5) = mu20;
similitudeMomentsVec(1,6) = mu21;
similitudeMomentsVec(1,7) = mu30;

end

% function for generating the first order moments
function [m00, m01, m10] = CalculateFirstOrderMoments(img)

[rows, cols] = size(img);

m00 = 0;
m01 = 0;
m10 = 0;

% iterating over all rows and columns
for i = 1:rows
    for j = 1:cols
        m00 = m00 + img(i, j);
        m01 = m01 + i*img(i, j); % r corresponds to y
        m10 = m10 + j*img(i, j); % c corresponds to x
    end
end
end 