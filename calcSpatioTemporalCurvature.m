%% This function returns the spatio temporal curvature of the x and y trajectories
function [curvature] = calcSpatioTemporalCurvature(xTrajectory, yTrajectory)

%Initializing vectors
firstDerivT = 1;
secondDerivT = 0;
[numR, ~] = size(xTrajectory);
firstDerivXTraj = zeros(numR, 1);
firstDerivYTraj = zeros(numR, 1);
secondDerivXTraj = zeros(numR, 1);
secondDerivYTraj = zeros(numR, 1);
curvature = zeros(numR, 1);

% the first element of the vector cannot have a first derivative
tempXTraj(1:numR-1, 1) = xTrajectory(2:numR, 1);
tempYTraj(1:numR-1, 1) = yTrajectory(2:numR, 1);

firstDerivXTraj(2:numR, 1) = tempXTraj - xTrajectory(1:numR-1, 1);
firstDerivYTraj(2:numR, 1) = tempYTraj - yTrajectory(1:numR-1, 1);

% the first two elements of the vector cannot have second derivative
tempFirstDerivXTraj(1:numR-2, 1) = firstDerivXTraj(2:numR-1, 1);
tempFirstDerivYTraj(1:numR-2, 1) = firstDerivYTraj(2:numR-1, 1);

secondDerivXTraj(3:numR, 1) = tempFirstDerivXTraj - firstDerivXTraj(1:numR-2, 1);
secondDerivYTraj(3:numR, 1) = tempFirstDerivYTraj - firstDerivYTraj(1:numR-2, 1);

% calculating the spatio temporal curvature
determinant1 = (firstDerivYTraj(3:numR, 1).*secondDerivT - secondDerivYTraj(3:numR).*firstDerivT);
determinant2 = (secondDerivXTraj(3:numR, 1).*firstDerivT - firstDerivXTraj(3:numR).*secondDerivT);
determinant3 = (firstDerivXTraj(3:numR, 1).*secondDerivYTraj(3:numR) - secondDerivYTraj(3:numR).*secondDerivXTraj(3:numR));

denominator = (firstDerivXTraj(3:numR, 1).^2 + firstDerivYTraj(3:numR, 1).^2 + firstDerivT^2);
tempCurv = sqrt(determinant1.^2 + determinant2.^2 + determinant3.^2) ./ (denominator.^(3/2));

% there would be valid curvature values for element number 3 onwards
curvature(3:numR,1) = tempCurv;

end