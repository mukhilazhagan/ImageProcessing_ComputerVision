function [ Ifinal ] = regiongrow_seg( I )


% Converting to double for calculation purposes
I=double(I);
% performing a gaussian filter on Image
I=imgaussfilt(I,2);

% Initialization of varies required variables
[r c]=size(I);
Ifinal=zeros(r,c,3);
Ifinal=uint8(Ifinal);
label=0;
Z=zeros(r,c);

% to remove pseudocoloring and ending up with very dark images
color=randi([25 255],1500,3);
%

% the step is taken for 5 steps becauase we want to limit to 5 regions
for i=1:5:r
for j=1:5:c
if(Z(i,j)==0)            
label=label+1;
seed_pixel=[i,j]; %seed pixel location set to current pixel
newcolor=color(label,:);
%%% Growing single region
%
%Initializing the model 
    val=I(i,j);
    model_s=val;
    model_s1=val*val;
    model_n=1;
    model_t2=2*2;
    %%% setting frontier stack to zero 
    stack=zeros(1000,2);
    t=1;
    stack(t,:)=seed_pixel;
    Ifinal(i,j,:)=newcolor;
    Z(i,j)=label;
    while t>0
        p=stack(t,:);
        t=t-1;
        %%%% Initialize the model
        %Access neighbors
        N=[p(1)+1,p(2);p(1),p(2)+1;p(1)-1,p(2);p(1),p(2)-1;p(1)+1,p(2)+1;p(1)-1,p(2)-1;p(1)+1,p(2)-1;p(1)-1,p(2)+1];
        for k=1:8
            if((~(N(k,1)==0))&&(~(N(k,2)==0))&&(~(N(k,2)==c+1))&&(~(N(k,1)==r+1)))
            % checking if Is model similar
            val=I(N(k,1),N(k,2));
            mean=model_s/model_n;
            var=(model_s1/model_n)-(mean*mean);
            if(model_n==1)
                var=10;
            end
              d2=(val-mean)*(val-mean);   
              %using the mahalanobis distance and returning if
              %distance is less than particular distance
            if (d2<= (model_t2*var))
                out=[Ifinal(N(k,1),N(k,2),1),Ifinal(N(k,1),N(k,2),2),Ifinal(N(k,1),N(k,2),3)];
                if(~(out(1)==newcolor(1)&&out(2)==newcolor(2)&&out(3)==newcolor(3)))
                    t=t+1;
                    stack(t,:)=N(k,:);
                    Ifinal(N(k,1),N(k,2),:)=newcolor;
                    Z(N(k,1),N(k,2))=label;
                    
                    
                    model_s=model_s+val;
                    model_s1=model_s1+val*val;
                    model_n=model_n+1;
                    
                end
            end
            end
        end
    end
end
end
end
    figure;
    imshow(Ifinal);
    
end

