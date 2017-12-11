function [ rgbim ] = color_objects( imb )
%%%%  Mukhil Azhagan Mallaiyan Sathiaseelan 
%%%%  Color Objects Code works for any number of objects
%%%%  With 4 neighbor connection ,as mentioned in book

%%% Created global variables for use in Stack function
global cel;
cel={};

% Determining the length of rows and columns
[r c]=size(imb);
d=3;



imb=255*uint8(imb);

%Creating a boundary extenened image for working
global im;
im=zeros(r+2,c+2);
im(2:r+1,2:c+1)=imb;

%%% Labelling Algorithm Part 
% Labels Regions

%Labelled image and Label
global il;
il=zeros(r+2,c+2);
global label
label=1;

for i=1:r
    for j=1:c
        if im(i,j)== 255 && il(i,j)==0
            il(i,j)=label;
            cel=cat(2,cel,[i,j]);
            % run thru the stack
            [ret]=floodfillstack();
            
            label=label+ret;
        end
    end
end
%%%%%%  End of Labelling region Part


%%% temporary image matrix
ilfinal=uint8(il(2:r+1,2:c+1));

rgbim=zeros(r,c,d);

%%% Beginning of Coloring region Part

% Finding the maximum number of regions using the labels
m=double(max(max(ilfinal)));




%%%NOTE on the other hand randomly assigns colors , Much more effective for
%%%higher no of regions
%%% creating random color intensities .

color=randi([50 255],1,m,3);

%%% Coloring each region with a different random color
for k=1:m
    for i=1:r
        for j=1:c
            if(ilfinal(i,j)==k )
               rgbim(i,j,:)=color(1,k,:); 
            end
        end
    end
end

rgbim=uint8(rgbim);
figure,imshow(rgbim);






%%%%%%%%%%%%%%%%%%%%% Local Functions 

function[flag]=floodfillstack()
%%% Fucntion for Flood filling using stack
%%%   Takes in global variables and returns a flag to say region has been
%%%   labelled
    while(not (isempty(cel)) )
        
        il(cel{1})=label;
        [n_r,n_c]=neighbor(cel{1});  % call neighbor function for every cell element
        
        for index=1:4
            [test]=cel{1};
                if ( im( n_r(index) , n_c(index) )== im(test(1) ,test(2)) && il( n_r(index) , n_c(index) ) == 0 ) % neighbor check with initial
                cel=cat(2,cel,[ n_r(index),n_c(index) ]); % queue neighbors
                il( n_r(index) , n_c(index) )=label;
                end
        end
        
        cel={cel{2:end}};
    end
    flag=1; % to indicate next label
end


function[nrow,ncol]=neighbor(dummy)
%%% Neighbor Index matrix [ Like structuring element]
% creating N4 Neighbor elements index


% Values of the cell input argument is separated to row and column
row=dummy(1,1);
col=dummy(1,2);

% Creating a neighborhood index matrix for accessing elements
nrow=[row-1;row;row;row+1];
ncol=[col;col-1;col+1;col];
end

%%%%%%%%%%%%%%%%%%    End of Local Functions


end