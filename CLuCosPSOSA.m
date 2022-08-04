function [z] = CLuCosPSOSA(m, X, clusteres)
% Calculate Distance Matrix
% create a cluster center 
g=reshape(m,1,clusteres)';
% create a distance matrix 
d = pdist2(X, g);
% Assign Clusters and Find Closest Distances
[dmin, ind] = min(d, [], 2);
% Sum of Within-Cluster Distance
WCD = sum(dmin);
% Fitness Function 
z=WCD; 
end