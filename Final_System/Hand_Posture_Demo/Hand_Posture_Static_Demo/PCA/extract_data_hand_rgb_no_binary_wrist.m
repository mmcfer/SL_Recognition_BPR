function   hand_posture=extract_data_hand_rgb_no_binary(folder,folder2) 

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
pix=100; 

figure(1)
imagesc(image_depth)

 [x,y] = ginput(1);
 
  if(x>550)
  hand_posture(:,:,k)=hand_posture(:,:,k-1);
  
  else
      
 x=round(x);
 y=round(y);
 
       %left_hand=image(round(y(5)),round(x(5)));
      depth=image_depth(y,x)
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
     
   i2=round((double(depth)-490.5)/7.89)   
   j2=round((double(depth)-868)/11.8)  
       for i=(y1):(y2-1)
        for j=(x1):(x2-1)   
            if(image_depth(i,j)<(depth+15))
               depth_hand(i,j)=image_depth(i,j);
               hand(i,j,:)=image_rgb(i+i2,j+j2,:);
            else
               depth_hand(i,j)=0; 
            end
        end
       end
       
        imagesc(uint8(hand))     
 hand_2=rgb2gray(uint8(hand));
%  for i=1:size(hand_2,1)
%         for j=1:size(hand_2,2)   
%             if(hand_2(i,j)>(65))
%                hand_2(i,j)=hand_2(i,j);
%             else
%                hand_2(i,j)=0; 
%             end
%         end
%  end
 
 
 [ee,rr]=imhist(uint8(hand_2));
[tt,yy]=sort(ee(2:end),'descend')
yy=yy(1:30);
bin = roicolor(hand_2,min(yy),max(yy))      
 
 %   bin = im2bw(uint8(hand),0.25); 
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
hand_2= hand_2(BoundingBox(idx,2)+1:(BoundingBox(idx,2)+BoundingBox(idx,4)),BoundingBox(idx,1)+1:(BoundingBox(idx,1)+BoundingBox(idx,3)));

hand_2=double(hand_2).*bin;

left_hand=bin;


 % bin_left=imfill(bin_left,'holes');
[Lx,Ly,Lz]=size(left_hand);
    if (Lx>(Ly+40))
        left_hand=imresize(left_hand,[HandPatchSize, NaN]);
        left_hand=[left_hand, zeros(HandPatchSize,HandPatchSize-size(left_hand,2))];
    elseif(Ly>(Lx+40))     
        left_hand=imresize(left_hand,[NaN, HandPatchSize]);
        left_hand=[left_hand; zeros(HandPatchSize-size(left_hand,1),HandPatchSize)];
    
    else
        left_hand=imresize(left_hand,[HandPatchSize,HandPatchSize]); 
        
    end
        
   
   
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
    