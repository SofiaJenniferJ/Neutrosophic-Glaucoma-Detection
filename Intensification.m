function [g1, g2, g3]=Intensification(T,I,F,w)
M=0.8;  % Optimal value of M
alpha=0.9;   % alpha value
for i = w:size(T,1)-(w-1)  
    for j = w :size(T,2)-(w-1) 
        if(T(i,j)<= alpha)
           g1(i,j)= M * (T(i,j))^2;    % Equation 8 for T-domain
        else
           g1(i,j)= 1-(2* (1-T(i,j))^2);
        end
    end
end
for i = w:size(I,1)-(w-1) 
    for j = w :size(I,2)-(w-1) 
        if(I(i,j)<= alpha)
           g2(i,j)= M * (I(i,j))^2;       % Equation 8 for I-domain
        else
           g2(i,j)= 1-(2* (1-I(i,j))^2);
        end
    end
end
for i = w:size(F,1)-(w-1) 
    for j = w :size(F,2)-(w-1) 
        if(F(i,j)<= alpha)
           g3(i,j)= M * (F(i,j))^2;     % Equation 8 for F-domain
        else
           g3(i,j)= 1-(2* (1-F(i,j))^2);
        end
    end
end
figure,
sgtitle('Step 2:Intensification image');
subplot(1,3,1),imshow(g1),title('T-domain');
subplot(1,3,2),imshow(g2),title('I-domain');
subplot(1,3,3),imshow(g3),title('F-domain');
end