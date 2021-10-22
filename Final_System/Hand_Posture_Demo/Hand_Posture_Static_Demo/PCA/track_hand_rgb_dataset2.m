function [right_hand,left_hand]=track_hand_rgb_dataset(image,pos)

% pos :     An array with size 225 x 7
%           The columes are
%           1 : UserID, 
%           2: Tracking-Confidence, 
%           3,4,5 : X,Y,Z in world-coordinates (mm)
%           6,7 : X,Y in image coordinates (pixels)
%           The rows are the following:
%           HEAD,NECK, LEFT SHOULDER, LEFT ELBOW, LEFT HAND,RIGHT SHOULDER
%           RIGHT ELBOW, RIGHT HAND, TORSO, LEFT HIP, LEFT KNEE, LEFT FOOT
%           RIGHT HIP, RIGHT KNEE, RIGHT FOOT
%           The first user data is P(1:15,:), for the second user the
%           data stored P(16:30,:), for the third P(31:45) ...


 %person = find_person_marc(image);
%imagesc(person.*double(image))
 HandPatchSize=50;
image2=zeros(480,640,3);
% We are interesting with the following points
%  3 --LEFT SHOULDER, 4 --LEFT ELBOW, 5 --LEFT HAND --- LEFT ARM
%  6 --RIGHT SHOULDER,7 -- RIGHT ELBOW,8 --RIGHT HAND --- RIGHT ARM
 x0=pos(1:20,1);
    y0=pos(1:20,2);

y(1,1)=y0(4,1);
y(2,1)=y0(3,1);
y(3,1)=y0(5,1);
y(4,1)=y0(6,1);
y(5,1)=y0(8,1);
y(6,1)=y0(9,1);
y(7,1)=y0(10,1);
y(8,1)=y0(12,1);
y(9,1)=y0(2,1);
y(10,1)=y0(13,1);
y(11,1)=y0(14,1);
y(12,1)=y0(16,1);
y(13,1)=y0(17,1);
y(14,1)=y0(18,1);
y(15,1)=y0(20,1);

x(1,1)=x0(4,1);
x(2,1)=x0(3,1);
x(3,1)=x0(5,1);
x(4,1)=x0(6,1);
x(5,1)=x0(8,1);
x(6,1)=x0(9,1);
x(7,1)=x0(10,1);
x(8,1)=x0(12,1);
x(9,1)=x0(2,1);
x(10,1)=x0(13,1);
x(11,1)=x0(14,1);
x(12,1)=x0(16,1);
x(13,1)=x0(17,1);
x(14,1)=x0(18,1);
x(15,1)=x0(20,1);

    % be carefull with the plot and the image
    % plot(x,y)  --- image(y,x)
    
 pix=30;  
 
       %left_hand=image(round(y(5)),round(x(5)));
       n0=(round(y(5))-pix)-1;
        m0=(round(x(5))-pix)-1;
       
       for n=(round(y(5))-pix):(round(y(5))+pix-1)
        for m=(round(x(5))-pix):(round(x(5))+pix-1)
                twohands(n,m,1)=image(n,m,1);
                twohands(n,m,2)=image(n,m,2);
                twohands(n,m,3)=image(n,m,3);
                left_hand(n-n0,m-m0,1)=image(n,m,1);
                left_hand(n-n0,m-m0,2)=image(n,m,2);
                left_hand(n-n0,m-m0,3)=image(n,m,3);
        end
       end
       n0=(round(y(8))-pix)-1;
        m0=(round(x(8))-pix)-1;
        for n=(round(y(8))-pix):(round(y(8))+pix-1)
        for m=(round(x(8))-pix):(round(x(8))+pix-1)
                twohands(n,m,1)=image(n,m,1);
                twohands(n,m,2)=image(n,m,2);
                twohands(n,m,3)=image(n,m,3);
                right_hand(n-n0,m-m0,1)=image(n,m,1);
                right_hand(n-n0,m-m0,2)=image(n,m,2);
                right_hand(n-n0,m-m0,3)=image(n,m,3);
        end
        end
  
        
        
        [out bin] = generate_skinmap(uint8(twohands));
         [out_left  bin_left] = generate_skinmap(left_hand);
          [out_right  bin_right] = generate_skinmap(right_hand);
          
          
 [ sqim ] = drawSquare( image ,[round(x(5)),round(y(5))] , 255 );

 [ sqim ] = drawSquare( sqim ,[round(x(8)),round(y(8))] , 255 );
 
 
%%%%% LEFT HAND 
 
% to get the bigger object
CC = bwconncomp(bin_left);
 numPixels = cellfun(@numel,CC.PixelIdxList);
[biggest,idx] = max(numPixels);
STATS = regionprops(CC, 'BoundingBox');
BoundingBox=floor(cat(1,STATS.BoundingBox));
% imagesc(bin_left)
% rectangle('Position',STATS(idx,1).BoundingBox, 'EdgeColor', 'g', 'Linewidth', 2);

bin_left= bin_left(BoundingBox(idx,2)+1:(BoundingBox(idx,2)+BoundingBox(idx,4)),BoundingBox(idx,1)+1:(BoundingBox(idx,1)+BoundingBox(idx,3)));

% for i=1:size(CC.PixelIdxList,2)
% if(i~=idx) 
%     bin_left(CC.PixelIdxList{i}) = 0;
% end
% end
left_hand2=left_hand;
left_hand=bin_left;
 % bin_left=imfill(bin_left,'holes');
 
   [Lx,Ly,Lz]=size(left_hand);
    if (Lx>Ly)
        left_hand=imresize(left_hand,[HandPatchSize, NaN]);
        left_hand=[left_hand, zeros(HandPatchSize,HandPatchSize-size(left_hand,2))];
    else        
        left_hand=imresize(left_hand,[NaN, HandPatchSize]);
        left_hand=[left_hand; zeros(HandPatchSize-size(left_hand,1),HandPatchSize)];
    end 
 
    level = graythresh(left_hand);  %# Compute an appropriate threshold
    left_hand = im2bw(left_hand,level);    %# Convert grayscale to binary
    
    
    
    
 %%%%% RIGHT HAND
 
% to get the bigger object
 
CC = bwconncomp(bin_right);
 numPixels = cellfun(@numel,CC.PixelIdxList);
[biggest,idx] = max(numPixels);
STATS = regionprops(CC, 'BoundingBox');
BoundingBox=floor(cat(1,STATS.BoundingBox));
% imagesc(bin_left)
% rectangle('Position',STATS(idx,1).BoundingBox, 'EdgeColor', 'g', 'Linewidth', 2);

% for i=1:size(CC.PixelIdxList,2)
% if(i~=idx) 
%     bin_right(CC.PixelIdxList{i}) = 0;
% end
% end


bin_right= bin_right(BoundingBox(idx,2)+1:(BoundingBox(idx,2)+BoundingBox(idx,4)),BoundingBox(idx,1)+1:(BoundingBox(idx,1)+BoundingBox(idx,3)));

right_hand2=right_hand;

right_hand=bin_right;


 % bin_left=imfill(bin_left,'holes');
 
   [Lx,Ly,Lz]=size(right_hand);
    if (Lx>Ly)
        right_hand=imresize(right_hand,[HandPatchSize, NaN]);
        right_hand=[right_hand, zeros(HandPatchSize,HandPatchSize-size(right_hand,2))];
    else        
        right_hand=imresize(right_hand,[NaN, HandPatchSize]);
        right_hand=[right_hand; zeros(HandPatchSize-size(right_hand,1),HandPatchSize)];
    end 
     
    level = graythresh(right_hand);  %# Compute an appropriate threshold
    right_hand = im2bw(right_hand,level);    %# Convert grayscale to binary
    
    
%  subplot(1,2,1)
%  imagesc(left_hand2)
%  subplot(1,2,2)
%  imagesc(bin2)
%  figure
%  subplot(1,2,1)
%  imagesc(left_hand3)
%  subplot(1,2,2)
%  imagesc(bin3)
%  figure
%  
% % imagesc(left_hand.*double(image))
%  subplot(1,2,1)
%  imagesc(uint8(out))
%  subplot(1,2,2)
%  imagesc(sqim)

figure
subplot(4,4,[1,5]);
imagesc(left_hand)
subplot(4,4,[2,6]);
imagesc(bin_left)

subplot(4,4,[9,13]);
imagesc(right_hand)
subplot(4,4,[10,14]);
imagesc(bin_right)

subplot(4,4,[3,7,11,15]);
 imagesc(uint8(out))
subplot(4,4,[4,8,12,16]);
 imagesc(sqim)

 
       hold on
    hh(1)=plot(x,y,'r.');% points
    hh(2)=plot(x([13 14 15]),y([13 14 15]),'g');%left leg
    hh(3)=plot(x([10 11 12]),y([10 11 12]),'g');%right leg
    hh(4)=plot(x([9 10]),y([9 10]),'m');%stomach and waist
    hh(5)=plot(x([9 13]),y([9 13]),'m');%stomach and waist
    hh(6)=plot(x([2 3 4 5]),y([2 3 4 5]),'b');%right arm
    hh(7)=plot(x([2 6 7 8]),y([2 6 7 8]),'b');% left arm
    hh(8)=plot(x([1 2]),y([1 2]),'c');%head
    hh(9)=plot(x([2 9]),y([2 9]),'c');%chest