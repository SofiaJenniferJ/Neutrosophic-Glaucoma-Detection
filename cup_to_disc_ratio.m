function c_ratio=cup_to_disc_ratio(S,cz)
% Cluster operation
[L, Centers]=imsegkmeans(uint8(S),cz);
B=labeloverlay(S,L);
figure(8);
imshow(B);
%% Segment individual components and its boundary box values
figure(9);
subplot(2,2,1);
imshow(B);
se = strel('line',11,90);
w=[];
for x = 1:cz
    mask1=L==x;
    cluster{x}=B.*uint8(mask1);
    cluster{x}= imdilate(cluster{x},se);
    labeledImage = cluster{x};
    labeledImage=labeledImage(:,:,1);
    E=edge(labeledImage,'canny');
    Ed=bwmorph(E,'fill');
    Ed1=imdilate(Ed, strel('disk',1));
    st = regionprops(Ed1, 'BoundingBox', 'Area');
    subplot(3,2,x);
    for ii = 1:length(st)
       Areai(ii)=st(ii).Area;
    end
    imshow(Ed1);
    hold on;
    largest_blob_id = find(Areai==max(Areai));
    thisBB = st(largest_blob_id).BoundingBox;
    rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],...
                      'EdgeColor','r','LineWidth',1 )
    w(x)=thisBB(3);
end
% %% Boundary box value for determining length and width of Optic disc and cup
 c_ratio=w(2)/w(1);
end