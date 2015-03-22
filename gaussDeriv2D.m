%% This function generates Gaussian Derivates wrt X and Y
% The gaussian function in 2D is of the following form:
% GExp = e^(-(x-x0)/(2*sigma^2))*e^(-(y-y0)/(2*sigma^2)) 
% G = A * GExp
% where A = 1/((2*pi)*sigma^2)
% It's derivatives wrt X and Y are as follows:
% Gx = A*(-1*(x-x0)/(2*sigma^4))*GExp (Using the chain rule)
% Gy = A*(-1*(y-y0)/(2*sigma^4))*GExp (Using the chain rule)

function [Gx, Gy] = gaussDeriv2D(sigma)

% The mask size is set using the following formula:
maskSize = ceil(3*sigma)*2 + 1;

% The mask is generated from -3*sigma to 3*sigma
startIdx = -1*ceil(3*sigma);
endIdx = ceil(3*sigma);

% The center location is 0, which we can gather from the above start and
% end indices
centerLoc = 0;

% The factor A for generating the masks
A = 1/((2*pi)*(sigma^2));

% Creating square matrices G, Gx and Gy with size maskSize
G = zeros(maskSize, maskSize);
Gx = zeros(maskSize, maskSize);
Gy = zeros(maskSize, maskSize);

% Iterating from -3*sigma to 3*sigma
% Note: here we consider r as y and c as x in our formula

y = -3*sigma;
sigmaSq = sigma^2;

for r = 1:maskSize
    x = -3*sigma;
    for c = 1:maskSize
        % Using the formula described at the top we can generate values of
        % Gx and Gy
        distx = (x - centerLoc);
        disty = (y - centerLoc);
        GExp = (exp(-1*(distx^2)/(2*sigmaSq))) * (exp(-1*(disty^2)/(2*sigmaSq))); 
        G(r, c) = A * GExp;
        Gx(r, c) = (-1)*((distx)/(2*sigmaSq^2))*GExp;
        Gy(r, c) = (-1)*((disty)/(2*sigmaSq^2))*GExp;
        x = x + 1;
    end
    y = y + 1;
end
end