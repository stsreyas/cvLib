%% This function builds the background model by taking as an input a vector of images
% The vector of images is assumed to be a multi channel image with the
% channel number 3 holding all images of the sequence.
function [meanModelImage, stdDevModelImage] = buildBackgroundModel(vectorOfImages)

% Pre allocate mean and standard deviation model images 
meanModelImage = zeros(size(vectorOfImages(:,:,1)));
stdDevModelImage = zeros(size(vectorOfImages(:,:,1)));
[rows, cols] = size(vectorOfImages(:,:,1));

% iterate over all rows and columns
for i = 1:rows
    for j = 1:cols
        % calculate the mean and standard deviation of the pixel value of all the images of this
        % particular pixel location (i, j)
        meanModelImage(i, j) = mean(vectorOfImages(i, j, :));
        stdDevModelImage(i, j) = std(vectorOfImages(i, j, :));
    end
end

end