function cluster=IFCM(clusteres)
MainOrg=imread('S2.jpg');
InpMat= double(MainOrg);
%% Basics
[s1,s2]=size(InpMat);
X=InpMat;
X = (X-min(X(:)))/(max(X(:))-min(X(:)));
X = [X(:)];
%% Cost Function and Parameters
% Cost Function
%% Initialise clustering using FCM
% opt.Exponent = NaN;
% opt.MaxNumIteration = 15; 
% opt.MinImprovement = 0.001;
% opt.Verbose = 0;
option1=[NaN 25 0.001 1];
[centers] = fcm(X,clusteres,option1);  % Equation 10, 11
%% 
CostFunction=@(m) CLuCosPSOSA(m, X, clusteres);  
% Decision Variables
VarSize=[clusteres size(X,2)];  
% Number of Decision Variables
nVar=prod(VarSize);
% Lower Bound of Variables
VarMin= repmat(min(X),1,clusteres);      
% Upper Bound of Variables
VarMax= repmat(max(X),1,clusteres);
%% PSOClustering Option and Run
% Iterations count
Itr=50;
%  PSO body
SA_opts = optimoptions('simulannealbnd','display','iter','MaxTime',Itr,'PlotFcn',@pswplotbestf);
options.SwarmSize = 250;
% PSO-SA Run
disp(['PSO Segmentation Is Started ... ']);
[centers, Error] = particleswarm(CostFunction, nVar,VarMin,VarMax,SA_opts); % % Equation 12, 13
disp(['PSO Segmentation Is Ended. ']);
%% Calculate Distance Matrix
% Create the Cluster Center 
g=reshape(centers,1,clusteres)'; 
% Create a Distance Matrix (Euclidean Distance)
d = pdist2(X, g); 
% Assign Clusters and Find Closest Distances
[dmin, ind] = min(d, [], 2);
% Sum of Cluster Distance
WCD = sum(dmin);
% Fitness Function of Centers Sum
z=WCD; 
% Final Segmented Image
SA_Segmented=reshape(ind,s1,s2);
PSOSAuint=uint8(SA_Segmented);
ColorSeg = labeloverlay(MainOrg,PSOSAuint);
title(['Improved Fuzzy Clustering Method, Clusters = ' num2str(clusteres)]);
cluster=PSOSAuint;
imwrite(ColorSeg,'S3.jpg')
figure()
imshow(ColorSeg);
end