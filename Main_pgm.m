%Read the file in GUI
[fn,pn] = uigetfile('*.png','select file');
g = imread([pn,fn]);
%Resize the image
g=imresize(g,[250 250]);
figure();
imshow(g),title('Input retinal image');
%% Intialise the values
w1=3; % Neutrosophic w=3
clusteres=4; % Cluster size
%% Step 1: Convert image to neutrosophic image
[T1, I1, F1]=Neutrosophic_conversion(g,w1);
%% Step 2: Intensify the resultant image
[T1x, I1x, F1x]=Intensification(T1,I1,F1,w1);
% %% Step 3: Perform score function on the resultant image 
S=Score_fn(T1x, I1x, F1x,w1);
imwrite(S,'S2.jpg');
%% Step 4: Perform IFCM Clustering
c1=IFCM(clusteres);
%% Step 5: Calculate cup to disc ratio
c_ratio=cup_to_disc_ratio(c1,clusteres);