%       Mukhil Azhagan Mallaiyan Sathiaseelan 



function [ h ] = myhist( I )                

[x,y]=size(I);          % Finding the length of rows 'x' and columns'y'

I=double(I);
h=zeros(1,256);         % declaring a vector with zero values


%       For loop through each pixel 
for i=1:x
    for j=1:y
        
        % Efficient Algorithm to calculate the histogram 
        h( I(i,j)+1 )= h( I(i,j)+1 ) + 1 ;
        
        % While the histogram ranges from 0-255 , the index values of
        % arrays in matlab is from 1-256.
        
    end
end


% stem plotting with labels for axes
stem(0:255,h);
xlabel('gray levels');
ylabel('Frequency');
title('Histogram');


end

