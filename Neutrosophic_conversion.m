function [T, I, F]=Neutrosophic_conversion(g,w) 
g=double(g);                                   
for i = 3:size(g,1)-2 
    for j = 3 :size(g,2)-2
       s=0;
     for m=i-round(w/2):i+round(w/2)
        for n=j-round(w/2):j+round(w/2)
           s=s+g(m,n);
        end
     end
     g1(i,j)=s/(w*w);                          
     segma(i,j)=abs(g(i,j)-g1(i,j));          
   end
end
g1min = min(min(g1));                          % minumum of local mean intensity value,min g ¯(i, j)
g1max = max(max(g1));                          % maxmum of local mean intensity value,max g¯(i, j)
segmamin = min(min(segma));                  
segmamax = max(max(segma));   
% equation 2
for i = 3:size(g,1)-2 
    for j = 3:size(g,2)-2           
T(i,j)= ((g1(i,j)-g1min)./(g1max-g1min));                    %equation 2
I(i,j)=((segma(i,j)-segmamin)./(segmamax-segmamin));         %equation 3
F(i,j)=1-T(i,j);                                             %equation 4
end
end
figure,
sgtitle('Step 1:Convert to NS image');
subplot(1,3,1),imshow(T),title('T-domain');
subplot(1,3,2),imshow(I),title('I-domain');
subplot(1,3,3),imshow(F),title('F-domain');
end