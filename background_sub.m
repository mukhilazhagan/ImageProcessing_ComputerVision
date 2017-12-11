clc
clear all
close all

% Modify the input file for user input
v=VideoReader('FroggerHighway.avi');

video=read(v);
[r,c,d,f]=size(video);

sum=zeros(r,c);
threshold=40; % Threshold to qualify for foreground
sub_images=zeros(r,c,10);

pltflag=1;

%frames to consider in video
length_of_frames=100;

% FrameSkip interval for display as plot
interval_size=10;


for i=1:length_of_frames
    videon(:,:,:,i)=double(video(:,:,:,i));
    gryvideo(:,:,i)=(  videon(:,:,1,i)+2*videon(:,:,2,i)+videon(:,:,3,i)  )/4;

end


for i=1:length_of_frames
    sum=gryvideo(:,:,i)+sum;
end

avg=uint8(sum/100);

imshow(avg);
title('Background Subtracted image');
figure;


%% Moving Object Detection Part
for k=1:interval_size:length_of_frames
    for i=1:r
        for j=1:c
            
            if( abs(gryvideo(i,j,k)-avg(i,j)) >threshold)
            sub_images(i,j,k)=255;
            end
        end
    end
    
   
    
    subplot(2,5,pltflag)
    imshow(sub_images(:,:,k));
    pltflag=pltflag+1;
end