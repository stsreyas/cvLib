%% This function returns the background subtracted image
% it takes as inputs, the mean and std dev model images, the foreground
% image and a threshold value which will be squared and compared with the
% mahalanobis distance squared
function [bgSubImg] = subtractBackground(meanModelImage, stdDevModelImage, motionImg, mahalanobisThresh)

[rows, cols] = size(motionImg);
bgSubImg = zeros(rows, cols);

% iterating over all rows and columns
for i = 1:rows
    for j = 1:cols
        % taking care of the divide by 0 condition
        if (stdDevModelImage(i, j) == 0)
            stdDevModelImage(i, j) = 1;
        end
        % calculating the square mahalanobis distance
        mahalanobisDistanceSq = ((motionImg(i, j) - meanModelImage(i, j))^2) / (stdDevModelImage(i, j)^2);
        % thresholding the image using the square of the threshold supplied
        % in the function arguments
        if mahalanobisDistanceSq > mahalanobisThresh^2
            bgSubImg(i, j) = 255;
        end
    end
end

end