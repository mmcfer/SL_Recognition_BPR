function Hands=extract_hand_posture_v4_right(filenameBase,introduced_sign)
tic



close all
filenameBase = filenameBase(1:length(filenameBase)-4);
folder=filenameBase;

filenameColor = strcat(folder, '/',filenameBase, '_color.mp4');
filenameDepth = strcat(folder, '/',filenameBase, '_depth.mp4');
filenameUser = strcat(folder, '/',filenameBase, '_user.mp4');
filenameAudio = strcat(folder, '/',filenameBase, '_audio.wav');
filenameMat = strcat(folder, '/',filenameBase, '_data.mat');


load(filenameMat)
 handles.colorVid = VideoReader(filenameColor);
handles.depthVid = VideoReader(filenameDepth);
handles.userVid = VideoReader(filenameUser);


    handles.labels=Video.Labels;
    P=size(handles.labels);
m=0;

for i = 1:P(1,2)
   
          names2{i,1}= handles.labels(1,i).Name;
      begin_end(i,:)=[handles.labels(1,i).Begin,handles.labels(1,i).End] ;
      [name2,ind_name]=sort(names2);     
      
end 
[name2,ind_name]=sort(names2); 
begins_end2=zeros(size(begin_end,1),2);
names=name2;


for i=1:length(ind_name)
    begins_end2(i,:)=begin_end(ind_name(i),:);
end
begin_end=begins_end2;

for g=1:size(names,1)
    
 
    if(strcmp(names{g,1},introduced_sign))
        h=g;
    
    end

end

 
count_plot=1;

tic

    begins=begin_end(h,1);
    ends=begin_end(h,2);
    if(begins==0)
        begins=1;
    end
        if(ends==0)
            ends=1;
    end    

   
[xdb,ydb]=meshgrid(1:640,1:480);
fx=524;
fy=524;
cx=320;
cy=240;
    for k = begins:ends
    

 Frame.RGB = read(handles.colorVid, k);
Frame.Depth =  getDepth(read(handles.depthVid, k),Video.MaxDepth);
Frame.Depth_x = (double(Frame.Depth)./fx).*(xdb-cx);
Frame.Depth_y =-(double(Frame.Depth)./fy).*(ydb-cy);
Frame.User= im2bw(read(handles.userVid, k));



  
  
 image_depth=double(Frame.Depth).*Frame.User;
image_depth_x=Frame.Depth_x.*Frame.User;
image_depth_y=Frame.Depth_y.*Frame.User;



  
  
  
skeleton2D=Video.Frames(1,k).Skeleton.PixelPosition;
skeleton3D=Video.Frames(1,k).Skeleton.WorldPosition;
skeleton3D=[skeleton3D;0 0 0];




% for r=1:20
% depth_point2D(r,1)=image_depth(skeleton2D(r,2),skeleton2D(r,1));
% end
% skeleton_hand=[skeleton_hand,depth_w_h];
for r1=1:20
x1_3D(r1)=(skeleton2D(r1,1)-cx).*1000*skeleton3D(r1,3)/fx;
y1_3D(r1)=-(skeleton2D(r1,2)-cy).*1000*skeleton3D(r1,3)/fy;


end
skeleton_3D_aprox=[x1_3D' y1_3D' 1000*skeleton3D(1:20,3)];
skeleton_3D_aprox=[skeleton_3D_aprox;0 0 0];


skeleton_hand3_aprox=[skeleton_3D_aprox(7,:);skeleton_3D_aprox(8,:);skeleton_3D_aprox(11,:);skeleton_3D_aprox(12,:)]/1000;

% 
 skeleton3D=skeleton_3D_aprox/1000;

skeleton_hand=[skeleton2D(7,:);skeleton2D(8,:);skeleton2D(11,:);skeleton2D(12,:)];
skeleton_hand3=[skeleton3D(7,:);skeleton3D(8,:);skeleton3D(11,:);skeleton3D(12,:)];


% scatter(image_depth_x(:),image_depth_y(:),'.','CDATA',image_depth(:)) ;colorbar;
% hold on
% scatter(1000*skeleton_hand3(:,1),1000*skeleton_hand3(:,2),'x','CDATA',[0,0,0,0]') ;colorbar;
% scatter(1000*skeleton_hand3_aprox(:,1),1000*skeleton_hand3_aprox(:,2),'.','CDATA',[0,0,0,0]') ;colorbar;
% hold off



y_right3=skeleton_hand3(4,2);
x_right3=skeleton_hand3(4,1);
z_right3=skeleton_hand3(4,3);
y_wrist_r3=skeleton_hand3(3,2);
x_wrist_r3=skeleton_hand3(3,1);
z_wrist_r3=skeleton_hand3(3,3);

y_left3=skeleton_hand3(2,2);
x_left3=skeleton_hand3(2,1);
z_left3=skeleton_hand3(2,3);
y_wrist_l3=skeleton_hand3(1,2);
x_wrist_l3=skeleton_hand3(1,1);
z_wrist_l3=skeleton_hand3(1,3);

disA=[0.0860    0.0846];
 dis=1*disA(1);

 skeleton3D(11,3)=z_wrist_r3+dis;
 skeleton3D(12,3)=z_right3+dis;

  skeleton3D(7,3)=z_wrist_l3+dis;
 skeleton3D(8,3)=z_left3+dis;
 
% y_right=skeleton_hand(4,2);
% x_right=skeleton_hand(4,1);
% y_wrist_r=skeleton_hand(3,2);
% x_wrist_r=skeleton_hand(3,1);



disA=[0.0860    0.0846];
 dis=1.7*disA(1);


 
 y1=1000*(y_right3-dis);
 y2=1000*(y_right3+dis);
 x1=1000*(x_right3-dis);
 x2=1000*(x_right3+dis);
 z1=1000*(z_right3-dis);
 z2=1000*(z_right3+dis);
% 
%  figure(5)
%  scatter(image_depth_x(:),image_depth_y(:),'.','CDATA',image_depth(:)) ;colorbar;
% hold on
%  scatter(x1,y1,'x','CDATA',0) ;colorbar;
%  scatter(x2,y2,'x','CDATA',0) ;colorbar;
%  scatter(x2,y1,'x','CDATA',0) ;colorbar;
%  scatter(x1,y2,'x','CDATA',0) ;colorbar;
% ss =skeleton_hand3*1000;
% plot(ss(1:4,1),ss(1:4,2),'go')
% hold off

 
% pix=50;
%  y12D=y_right-pix;
%  y22D=y_right+pix;
%  x12D=x_right-pix;
%  x22D=x_right+pix;
 
   y1_2D=floor(-y1*fy./z1+cy);  
 y2_2D=floor(-y2*fy./z2+cy);
 x1_2D=floor(x1*fx./z1+cx);
 x2_2D=floor(x2*fx./z2+cx);
 depth_hand_right=0;
 depth_hand_right_x=0;
 depth_hand_right_y=0;
      if((y1_2D)<=0)
          y1_2D=1;
      end
      if((x1_2D)<=0)
          x1_2D=1;
      end     
 
      if((y2_2D)<=50)
          y2_2D=101;
      end
      if((x2_2D)<=50)
          x2_2D=101;
      end  
      
      if((y1_2D)>480)
          y1_2D=480;
      end
       for i=(y2_2D):(y1_2D-1)
        for j=(x1_2D):(x2_2D-1)   
            
               depth_hand_right(i-y2_2D+1,j-x1_2D+1)=image_depth(i,j);
               depth_hand_right_x(i-y2_2D+1,j-x1_2D+1)=image_depth_x(i,j);
               depth_hand_right_y(i-y2_2D+1,j-x1_2D+1)=image_depth_y(i,j);
               depth_hand_right_RGB(i-y2_2D+1,j-x1_2D+1,:)=Frame.RGB(i,j,:);

        end
       end
minhand=unique(depth_hand_right(:));

if(size(minhand,1)>=2)
    if(skeleton3D(11,3)<(minhand(2)/1000))
minhand = minhand(2);

skeleton3D(11,3)=minhand/1000;
skeleton3D(12,3)=minhand/1000;
    end
end

image_depth_col=depth_hand_right(:);
image_depth_col_x=depth_hand_right_x(:);
image_depth_col_y=depth_hand_right_y(:);

im_handz=double(reshape(depth_hand_right,[size(depth_hand_right,1),size(depth_hand_right,2)]));
  im_handx=double(reshape(depth_hand_right_x,[size(depth_hand_right,1),size(depth_hand_right,2)]));
   im_handy=double(reshape(depth_hand_right_y,[size(depth_hand_right,1),size(depth_hand_right,2)]));
   
  
   
if(size(image_depth_col,1)==size(image_depth_col_x,1))
if(size(image_depth_col,1)==size(image_depth_col_y,1))
    
col3D=[ image_depth_col_x image_depth_col_y image_depth_col];

 observations = get_point_clusters_hand(col3D,1000*skeleton3D);
    im_obs=double(reshape(observations,[size(depth_hand_right,1),size(depth_hand_right,2)]));
    
  
%      im_obs=double(reshape(observations,[480,640]));
    
% figure(1)
% subplot(131)
% imagesc(im_obs)
%     axis equal
ob_hand_r=find(observations==12);
ob_wrist_r=find(observations==11);

ob_hand_l=find(observations==8);
ob_wrist_l=find(observations==7);

z_hand_R=image_depth_col(ob_hand_r);
z_wrist_R=image_depth_col(ob_wrist_r);

z_hand_L=image_depth_col(ob_hand_r);
z_wrist_L=image_depth_col(ob_wrist_r);

maxhand_depth_R=max(z_hand_R);
maxwrist_depth_R=max(z_wrist_R);
maxhand_depth_L=max(z_hand_L);
maxwrist_depth_L=max(z_wrist_L);

 


 if(z2<maxhand_depth_R)
     z2=maxhand_depth_R;
    T1=isempty(maxhand_depth_R);
    if(T1==1)
        z2=maxwrist_depth_R;
    end
 end
 
 if(z2<maxwrist_depth_R)
     z2=maxwrist_depth_R;
 end
 if(z2<maxwrist_depth_L)
     z2=maxwrist_depth_L;
 end
 if(z2<maxhand_depth_L)
     z2=maxhand_depth_L;
 end
 
 
con=1; 
con2=1;
p=0;
pob=0;
p2=0;
pob2=0;
p_id=0;
p_id2=0;
   for i=1:size(depth_hand_right,1)
        for j=1:size(depth_hand_right,2) 
 
 if(depth_hand_right(i,j)<z2)
 if(depth_hand_right(i,j)>z1)
  if(depth_hand_right_x(i,j)<x2)
      if(depth_hand_right_x(i,j)>x1)
          if(depth_hand_right_y(i,j)<y2)
              if(depth_hand_right_y(i,j)>y1)
                 
                 p(con,1)=round(depth_hand_right_x(i,j));
                 p(con,3)=round(depth_hand_right(i,j)) ; 
                 p(con,2)=round(depth_hand_right_y(i,j)) ;
                 
                 pob(con,1)=im_obs(i,j);
               p_id(con,1)=i;
               p_id(con,2)=j;
               
              if((pob(con,1)==11) ||(pob(con,1)==12)||(pob(con,1)==7)||(pob(con,1)==8))
  
        p2(con2,1)=p(con,1);
        p2(con2,2)=p(con,2);
        p2(con2,3)=p(con,3);
        pob2(con2,1)=pob(con,1);
        
      p_id2(con2,1)=p_id(con,1);
      p_id2(con2,2)=p_id(con,2);
     con2=con2+1; 
end
              
 con=con+1;                 
                      end
                  end
             
          end
      end
  end
 end
 end
   end

   
%     figure(7)
%     scatter(p(:,1),p(:,2),'.','CDATA',pob(:,1) ) ;colorbar;
% hold on
% ss =skeleton_hand3*1000;
% plot(ss(3:4,1),ss(3:4,2),'go')
%   hold off   

     
     
     
     
     
 y1=1000*(y_right3-dis);
 y2=1000*(y_right3+dis);
 x1=1000*(x_right3-dis);
 x2=1000*(x_right3+dis);
 z1=1000*(z_right3-dis);
 z2=1000*(z_right3+dis);   
 

   

dis=round(1000*dis);

con2=1;



 if(pob2~=0) 
 
  y1_2D=floor(-y1*fy./z1+cy);  
 y2_2D=floor(-y2*fy./z2+cy);
 x1_2D=floor(x1*fx./z1+cx);
 x2_2D=floor(x2*fx./z2+cx);
%  
% x2D= (p2(:,1)*fx./p2(:,3)) + cx;
% y2D= -(p2(:,2)*fy./p2(:,3)) + cy;
 
  depthmap_hand=zeros(y1_2D-y2_2D,x2_2D-x1_2D);
  
for tt=1:size(p2,1) 
dx=p_id2(tt,2);
dy=p_id2(tt,1);

if((dx>0) && (dy>0))
  depthmap_hand(dy, dx) = p2(tt,3);
end
end

hand_right_final=depthmap_hand;
hand_right_without_norm=depthmap_hand;

       depth_min=min(min(hand_right_final));
       hand_right_final=hand_right_final-depth_min;
       
       depth_max=max(max(hand_right_final));
       hand_right_final=hand_right_final./depth_max;
        hand_right_final = imresize(hand_right_final,[65 65]);
% imagesc(hand_right_final)
false=0;
else
   hand_right_final=zeros(65,65);
   false=1;
end
else
   hand_right_final=zeros(65,65);
    false=1;
end

else
   hand_right_final=zeros(65,65);
    false=1;
end


Hands.Posture{1,1}.hand_posture_depth_right(:,:,k-begins+1)=hand_right_final;
 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
disA=[0.0860    0.0846];
 dis=1.7*disA(1);


 y1=1000*(y_left3-dis);
 y2=1000*(y_left3+dis);
 x1=1000*(x_left3-dis);
 x2=1000*(x_left3+dis);
 z1=1000*(z_left3-dis);
 z2=1000*(z_left3+dis);
 
   y1_2D=floor(-y1*fy./z1+cy);  
 y2_2D=floor(-y2*fy./z2+cy);
 x1_2D=floor(x1*fx./z1+cx);
 x2_2D=floor(x2*fx./z2+cx);
 depth_hand_left=0;
 depth_hand_left_x=0;
 depth_hand_left_y=0;
      if((y1_2D)<=0)
          y1_2D=1;
      end
      if((x1_2D)<=0)
          x1_2D=1;
      end     
 
      if((y2_2D)<=50)
          y2_2D=101;
      end
      if((x2_2D)<=50)
          x2_2D=101;
      end  
       for i=(y2_2D):(y1_2D-1)
        for j=(x1_2D):(x2_2D-1)   
            
               depth_hand_left(i-y2_2D+1,j-x1_2D+1)=image_depth(i,j);
               depth_hand_left_x(i-y2_2D+1,j-x1_2D+1)=image_depth_x(i,j);
               depth_hand_left_y(i-y2_2D+1,j-x1_2D+1)=image_depth_y(i,j);
               hand_left_RGB(i-y2_2D+1,j-x1_2D+1,:)=Frame.RGB(i,j,:);

        end
       end
minhand=unique(depth_hand_left(:));

if(size(minhand,1)>=2)
    if(skeleton3D(11,3)<(minhand(2)/1000))
minhand = minhand(2);

skeleton3D(11,3)=minhand/1000;
skeleton3D(12,3)=minhand/1000;
    end
end

image_depth_col=depth_hand_left(:);
image_depth_col_x=depth_hand_left_x(:);
image_depth_col_y=depth_hand_left_y(:);


if(size(image_depth_col,1)==size(image_depth_col_x,1))
if(size(image_depth_col,1)==size(image_depth_col_y,1))
    
col3D=[ image_depth_col_x image_depth_col_y image_depth_col];

 observations = get_point_clusters_hand(col3D,1000*skeleton3D);
    im_obs_left=double(reshape(observations,[size(depth_hand_left,1),size(depth_hand_left,2)]));
    
    
   
     
%      im_obs=double(reshape(observations,[480,640]));
    
% figure(1)
% subplot(131)
% imagesc(im_obs)
%     axis equal
ob_hand_r=find(observations==12);
ob_wrist_r=find(observations==11);

ob_hand_l=find(observations==8);
ob_wrist_l=find(observations==7);

z_hand_R=image_depth_col(ob_hand_r);
z_wrist_R=image_depth_col(ob_wrist_r);

z_hand_L=image_depth_col(ob_hand_r);
z_wrist_L=image_depth_col(ob_wrist_r);

maxhand_depth_R=max(z_hand_R);
maxwrist_depth_R=max(z_wrist_R);
maxhand_depth_L=max(z_hand_L);
maxwrist_depth_L=max(z_wrist_L);



 if(z2<maxhand_depth_R)
     z2=maxhand_depth_R;
    T1=isempty(maxhand_depth_R);
    if(T1==1)
        z2=maxwrist_depth_R;
    end
 end
 
 if(z2<maxwrist_depth_R)
     z2=maxwrist_depth_R;
 end
 if(z2<maxwrist_depth_L)
     z2=maxwrist_depth_L;
 end
 if(z2<maxhand_depth_L)
     z2=maxhand_depth_L;
 end
 
 
con=1; 
con2=1;
p=0;
pob=0;
p2=0;
pob2=0;
p_id=0;
p_id2=0;
   for i=1:size(depth_hand_left,1)
        for j=1:size(depth_hand_left,2) 
 
 if(depth_hand_left(i,j)<z2)
 if(depth_hand_left(i,j)>z1)
  if(depth_hand_left_x(i,j)<x2)
      if(depth_hand_left_x(i,j)>x1)
          if(depth_hand_left_y(i,j)<y2)
              if(depth_hand_left_y(i,j)>y1)
                 
                 p(con,1)=round(depth_hand_left_x(i,j));
                 p(con,3)=round(depth_hand_left(i,j)) ; 
                 p(con,2)=round(depth_hand_left_y(i,j)) ;
                 
%                 p(con,1)=round(depth_hand_left_x(i,j)-1000*x_left3 );
%                  p(con,3)=round(depth_hand_left(i,j)-1000*z_left3) ; 
%                  p(con,2)=round(depth_hand_left_y(i,j)-1000*y_left3) ;
                 pob(con,1)=im_obs_left(i,j);
               p_id(con,1)=i;
               p_id(con,2)=j;
               
              if((pob(con,1)==11) ||(pob(con,1)==12)||(pob(con,1)==7)||(pob(con,1)==8))
  
        p2(con2,1)=p(con,1);
        p2(con2,2)=p(con,2);
        p2(con2,3)=p(con,3);
        pob2(con2,1)=pob(con,1);
        
      p_id2(con2,1)=p_id(con,1);
      p_id2(con2,2)=p_id(con,2);
     con2=con2+1; 
end
              
 con=con+1;                 
                      end
                  end
             
          end
      end
  end
 end
 end
   end
                  
%     figure(7)
%     scatter(p(:,1),p(:,2),'.','CDATA',pob(:,1) ) ;colorbar;
% hold on
% ss =skeleton_hand3*1000;
% plot(ss(3:4,1),ss(3:4,2),'go')
%   hold off   

     
     
     
     
     
 y1=1000*(y_left3-dis);
 y2=1000*(y_left3+dis);
 x1=1000*(x_left3-dis);
 x2=1000*(x_left3+dis);
 z1=1000*(z_left3-dis);
 z2=1000*(z_left3+dis); 
 

   

dis=round(1000*dis);

con2=1;



 if(pob2~=0) 
 
  y1_2D=floor(-y1*fy./z1+cy);  
 y2_2D=floor(-y2*fy./z2+cy);
 x1_2D=floor(x1*fx./z1+cx);
 x2_2D=floor(x2*fx./z2+cx);
%  
% x2D= (p2(:,1)*fx./p2(:,3)) + cx;
% y2D= -(p2(:,2)*fy./p2(:,3)) + cy;
 
  depthmap_hand=zeros(y1_2D-y2_2D,x2_2D-x1_2D);
  
%   minx2D=min(x2D)-x1_2D;
%   miny2D=min(y2D)-y1_2D;
%   y2D=y2D+miny2D+1;
%   x2D=x2D;
  
%   if((minx2D>0) && (miny2D>0))
for tt=1:size(p2,1) 
dx=p_id2(tt,2);
dy=p_id2(tt,1);

if((dx>0) && (dy>0))
  depthmap_hand(dy, dx) = p2(tt,3);
end
end





%  figure(1)
%  subplot(133)
%  imagesc(depthmap_hand)
%   axis equal
hand_left_without_norm=depthmap_hand;
hand_left_final=depthmap_hand;









       depth_min=min(min(hand_left_final));
       hand_left_final=hand_left_final-depth_min;
       
       depth_max=max(max(hand_left_final));
       hand_left_final=hand_left_final./depth_max;
        hand_left_final = imresize(hand_left_final,[65 65]);
% figure(2);imagesc(hand_left_final)
% axis equal
false=0;
else
   hand_left_final=zeros(65,65);
   false=1;
end
else
   hand_left_final=zeros(65,65);
    false=1;
end

else
   hand_left_final=zeros(65,65);
    false=1;
end


Hands.Posture{h,1}.hand_posture_depth_left(:,:,k-begins+1)=hand_left_final;

%  figure(1)
%      subplot(2,3,1)
%          imagesc(Frame.RGB)
%          title('RGB Image')
% 
%     skeleton2D_upper(1,:)=Video.Frames(1,k).Skeleton.PixelPosition(4,:);
%     skeleton2D_upper(2,:)=Video.Frames(1,k).Skeleton.PixelPosition(3,:);
%     skeleton2D_upper(3,:)=Video.Frames(1,k).Skeleton.PixelPosition(5,:);
%     skeleton2D_upper(4,:)=Video.Frames(1,k).Skeleton.PixelPosition(6,:);
%     skeleton2D_upper(5,:)=Video.Frames(1,k).Skeleton.PixelPosition(8,:);
%     skeleton2D_upper(6,:)=Video.Frames(1,k).Skeleton.PixelPosition(9,:);
%     skeleton2D_upper(7,:)=Video.Frames(1,k).Skeleton.PixelPosition(10,:);
%     skeleton2D_upper(8,:)=Video.Frames(1,k).Skeleton.PixelPosition(12,:);
%     skeleton2D_upper(9,:)=Video.Frames(1,k).Skeleton.PixelPosition(2,:);
%     skeleton2D_upper(10,:)=Video.Frames(1,k).Skeleton.PixelPosition(13,:);
%     skeleton2D_upper(11,:)=Video.Frames(1,k).Skeleton.PixelPosition(17,:);
% 
%     drawBones2D_pixels(skeleton2D_upper)
% 
%     subplot(2,3,2)
%         imagesc(Frame.Depth)
%         title('Depth Image')
% 
%     subplot(2,3,3)  
%         imagesc(Frame.User)
%         title('Mask  User')
% 
%     subplot(2,3,4)
%         imagesc(image_depth)
%         title('User Z Component')
% 
%     subplot(2,3,5)
%         imagesc(image_depth_x)
%         title('User X Component')
% 
%     subplot(2,3,6)
%         imagesc(image_depth_y)
%         title('User Y Component')
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%   figure(2)
%         subplot(2,2,1)  
%         imagesc(depth_hand_right_RGB)
%    
% 
%         subplot(2,2,2)
%         imagesc(im_handz)
%         
%         subplot(2,2,3)
%         imagesc(im_obs)
%         
%         subplot(2,2,4)
%         imagesc(hand_right_without_norm)
%         
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
%  figure(3)
%     subplot(2,2,1)
%     imagesc(hand_left_RGB)
%     
%     
%     subplot(2,2,2)
%     imagesc( depth_hand_left)
%     
%     subplot(2,2,3)
%     imagesc(im_obs_left)
% 
%     subplot(2,2,4)
%     imagesc(hand_left_without_norm)
% 


    end





function depth = getDepth(frame,maxDepth)
    depth = uint16(round(double(rgb2gray(frame))/255.0*maxDepth));
