function S=Score_fn(T,I,F,w)
 for i = w:size(T,1)-(w-1)  
    for j = w :size(T,2)-(w-1) 
        S(i,j) = T(i,j)+I(i,j)-F(i,j);   % Equation 9
    end
 end
figure,
imshow(S),title('Step 3:Score image');
end