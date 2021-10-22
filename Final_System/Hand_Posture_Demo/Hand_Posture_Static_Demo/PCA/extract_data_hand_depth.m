function   hand_posture=extract_data_hand_depth(folder,folder2) 

addpath(folder)

HandPatchSize=75;


lee_archivos_rgb = dir(strcat(folder,'\*.png'));
lee_archivos_depth = dir(strcat(folder2,'\*.png'));
for k = 1:length(lee_archivos_depth) 
archivo_rgb = lee_archivos_rgb(k).name;
archivo_depth = lee_archivos_depth(k).name;
nombre_rgb=strcat(folder,'\');
nombre_depth=strcat(folder2,'\');
image_rgb= imread(strcat(nombre_rgb,archivo_rgb));
image_depth= imread(strcat(nombre_depth,archivo_depth));


left_hand=[];
depth_hand=[];
hand=[];
pix=150; 

figure(1)
imagesc(image_depth)
minpoint=min(min(image_depth));
                 [row,col]=find(image_depth<minpoint+3);
                 
                 media1=round(median(row));
                 media2=round(median(col));
                 hold on
 plot(media2,media1,'g*')
 hold off
%  if(x>550)
%   hand_posture(:,:,k)=hand_posture(:,:,k-1);
%  
%  else
     
     
 y=round(media1);
 x=round(media2);
 
       %left_hand=image(round(y(5)),round(x(5)));
      depth=minpoint+10;
 
 y1=y-pix;
 y2=y+pix;
 x1=x-pix;
 x2=x+pix;
      if((y1)<=0)
          y1=1;
      end
      if((x1)<=0)
          x1=1;
      end     
 
       for i=(y1):(y2-1)
        for j=(x1):(x2-1)   
            if(image_depth(i,j)<(depth+30))
               depth_hand(i,j)=image_depth(i,j);
               else
               depth_hand(i,j)=0; 
            end
        end
       end
       
%        depth_min=min(reshape(depth_hand,numel(depth_hand),1));
%        depth_hand=depth_hand-depth_min;
%        
%        depth_max=max(reshape(depth_hand,numel(depth_hand),1));
%        depth_hand=depth_hand./depth_max;
%        
%        
%      %  depth_hand=depth_hand/norm(depth_hand);
       
        imagesc(uint8(depth_hand))     
 
    bin = im2bw(uint8(depth_hand)); 
%     
% [out bin] = generate_skinmap2(uint8(hand));
% figure(2)
% subplot(1,2,1)
% imagesc(uint8(out))
% subplot(1,2,2)
 
%%%%% LEFT HAND 
 
% to get the bigger object
CC = bwconncomp(bin);
 numPixels = cellfun(@numel,CC.PixelIdxList);
[biggest,idx] = max(numPixels);
STATS = regionprops(CC, 'BoundingBox');
BoundingBox=floor(cat(1,STATS.BoundingBox));
 imagesc(bin)
 rectangle('Position',STATS(idx,1).BoundingBox, 'EdgeColor', 'g', 'Linewidth', 2);


 for i=1:size(CC.PixelIdxList,2)
 if(i~=idx) 
     bin(CC.PixelIdxList{i}) = 0;
 end
 end
bin= bin(BoundingBox(idx,2)+1:(BoundingBox(idx,2)+BoundingBox(idx,4)),BoundingBox(idx,1)+1:(BoundingBox(idx,1)+BoundingBox(idx,3)));

left_hand=bin;
 % bin_left=imfill(bin_left,'holes');
 
   [Lx,Ly,Lz]=size(left_hand);
%     if (Lx>Ly)
%         left_hand=imresize(left_hand,[HandPatchSize, NaN]);
%         left_hand=[left_hand, zeros(HandPatchSize,HandPatchSize-size(left_hand,2))];
%     else        
%         left_hand=imresize(left_hand,[NaN, HandPatchSize]);
%         left_hand=[left_hand; zeros(HandPatchSize-size(left_hand,1),HandPatchSize)];
%     end 
 

        left_hand=imresize(left_hand,[HandPatchSize,HandPatchSize]);
        
   
   
% 
%     level = graythresh(left_hand);  %# Compute an appropriate threshold
%     left_hand = im2bw(left_hand,level);    %# Convert grayscale to binary
    
    figure(2)
    subplot(1,2,1)
    imagesc(bin)
    subplot(1,2,2)
    imagesc(left_hand)
    hand_posture(:,:,k)=left_hand;
    
 end

end   