function [M,Z,NumberRemoved] = RemoveOutliers(X,Y)
%Return a Matrix X with the outliers (certain rows) removed
%   An instance is an outlier if it has two or more column values
%that are 3 (or more) standard deviations away from thee mean

[n,p] = size(X);

mu = mean(X);
sigma = std(X);

MeanMat = repmat(mu,n,1);
SigmaMat = repmat(sigma,n,1);

outliers = abs(X - MeanMat) > 3*SigmaMat;

% If the number of features in a feature vector is more than 10
% the have to check if there are two or more outliers
% in a row to remove it.
% If there are less than 10 features
% can remove a row that has any outliers

if p > 10

    X((sum(outliers,2)>=2),:) = [];
    Y((sum(outliers,2)>=2),:) = [];
    
else
    X(any(outliers,2),:) = [];
    Y(any(outliers,2),:) = [];
end
    

M = X;
Z = Y;

[r,s] = size(M);
NumberRemoved = abs(r-n);

end

