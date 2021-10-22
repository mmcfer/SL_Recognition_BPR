function [handles,des]=extract_previous_frame_subtraction(filename,gesturename)



%[rgb,depth,user,data]=extract(filename)
 filenameBase = filename(1:length(filename)-4);

%  unzip(filename,filenameBase);
folder=filenameBase;


filenameColor = strcat(folder, '/',filenameBase, '_color.mp4');
filenameDepth = strcat(folder, '/',filenameBase, '_depth.mp4');
filenameUser = strcat(folder, '/',filenameBase, '_user.mp4');
filenameAudio = strcat(folder, '/',filenameBase, '_audio.wav');
filenameMat = strcat(folder, '/',filenameBase, '_data.mat');



handles.colorVid = VideoReader(filenameColor);
handles.depthVid = VideoReader(filenameDepth);
handles.userVid = VideoReader(filenameUser);


handles.Video = load(filenameMat);
handles.Video = handles.Video.Video;
handles.skeleton=handles.Video.Frames;
handles.labels=handles.Video.Labels;
P=size(handles.labels);
m=0;
count=1;

[xdb,ydb]=meshgrid(1:640,1:480);
fx=524;
fy=524;
cx=320;
cy=240;

for m = 1:P(1,2) 
 
    if strcmp(handles.labels(1,m).Name,gesturename) 
        starts=handles.labels(1,m).Begin;
        ends=handles.labels(1,m).End;
    
    for i=starts:ends
        A(:,:,i-starts+1)=handles.skeleton(1,i).Skeleton.WorldPosition;
        
        
    end


    
    
    for j=1:(ends-starts+1)
    
        normleft=A(8,:,j);
        normright=A(12,:,j);

        lefthand=zeros(11,3);
        righthand=zeros(11,3);

        lefthand(1,:)=A(4,:,j);
        lefthand(2,:)=A(3,:,j);
        lefthand(3,:)=A(5,:,j);
        lefthand(4,:)=A(6,:,j);
        lefthand(5,:)=A(8,:,j);
        lefthand(6,:)=A(9,:,j);
        lefthand(7,:)=A(10,:,j);
        lefthand(8,:)=A(12,:,j);
        lefthand(9,:)=A(2,:,j);
        lefthand(10,:)=A(13,:,j);
        lefthand(11,:)=A(17,:,j);

        righthand(1,:)=A(4,:,j);
        righthand(2,:)=A(3,:,j);
        righthand(3,:)=A(5,:,j);
        righthand(4,:)=A(6,:,j);
        righthand(5,:)=A(8,:,j);
        righthand(6,:)=A(9,:,j);
        righthand(7,:)=A(10,:,j);
        righthand(8,:)=A(12,:,j);
        righthand(9,:)=A(2,:,j);
        righthand(10,:)=A(13,:,j);
        righthand(11,:)=A(17,:,j);


            countB=0;
            countC=0;

    
        for k2 = 1:size(lefthand,1)    
        
            B(1,(1+countB):(3+countB)) = lefthand(k2,1:3);
             countB=countB+3;
        
            C(1,(1+countC):(3+countC)) = righthand(k2,1:3);
             countC=countC+3;
       
        end
        
            countB=0;
            countC=0;
            D=[B C];

            E(count,:)=D;

        if(count==1)
            F=zeros(1,size(E,2));
        else
            F(count-1,1:3)=E(count-1,1:3)-normleft;
            F(count-1,4:6)=E(count-1,4:6)-normleft;
            F(count-1,7:9)=E(count-1,7:9)-normleft;
            F(count-1,10:12)=E(count-1,10:12)-normleft;
            F(count-1,13:15)=E(count-1,13:15)-normleft;
            F(count-1,16:18)=E(count-1,16:18)-normleft;
            F(count-1,19:21)=E(count-1,19:21)-normleft;
            F(count-1,22:24)=E(count-1,22:24)-normleft;
            F(count-1,25:27)=E(count-1,25:27)-normleft;
            F(count-1,28:30)=E(count-1,28:30)-normleft;
            F(count-1,31:33)=E(count-1,31:33)-normleft;

            F(count-1,34:36)=E(count-1,34:36)-normright;
            F(count-1,37:39)=E(count-1,37:39)-normright;
            F(count-1,40:42)=E(count-1,40:42)-normright;
            F(count-1,43:45)=E(count-1,43:45)-normright;
            F(count-1,46:48)=E(count-1,46:48)-normright;
            F(count-1,49:51)=E(count-1,49:51)-normright;
            F(count-1,52:54)=E(count-1,52:54)-normright;
            F(count-1,55:57)=E(count-1,55:57)-normright;
            F(count-1,58:60)=E(count-1,58:60)-normright;
            F(count-1,61:63)=E(count-1,61:63)-normright;
            F(count-1,64:66)=E(count-1,64:66)-normright;

        end
    
    count=count+1;
 




    
    end 

for k=starts:ends
        
        
       
    
    Frame.RGB = read(handles.colorVid, k);
    Frame.Depth =  getDepth(read(handles.depthVid, k),handles.Video.MaxDepth);
    Frame.Depth_x = (double(Frame.Depth)./fx).*(xdb-cx);
    Frame.Depth_y =-(double(Frame.Depth)./fy).*(ydb-cy);
    Frame.User= im2bw(read(handles.userVid, k));
    
        image_depth=double(Frame.Depth).*Frame.User;
        image_depth_x=Frame.Depth_x.*Frame.User;
        image_depth_y=Frame.Depth_y.*Frame.User;

     figure(1)

     
         imagesc(Frame.RGB);
         title('RGB Image')
         
         skeleton2D_upper(1,:)=handles.skeleton(k).Skeleton.PixelPosition(4,:);
    skeleton2D_upper(2,:)=handles.skeleton(k).Skeleton.PixelPosition(3,:);
    skeleton2D_upper(3,:)=handles.skeleton(k).Skeleton.PixelPosition(5,:);
    skeleton2D_upper(4,:)=handles.skeleton(k).Skeleton.PixelPosition(6,:);
    skeleton2D_upper(5,:)=handles.skeleton(k).Skeleton.PixelPosition(8,:);
    skeleton2D_upper(6,:)=handles.skeleton(k).Skeleton.PixelPosition(9,:);
    skeleton2D_upper(7,:)=handles.skeleton(k).Skeleton.PixelPosition(10,:);
    skeleton2D_upper(8,:)=handles.skeleton(k).Skeleton.PixelPosition(12,:);
    skeleton2D_upper(9,:)=handles.skeleton(k).Skeleton.PixelPosition(2,:);
    skeleton2D_upper(10,:)=handles.skeleton(k).Skeleton.PixelPosition(13,:);
    skeleton2D_upper(11,:)=handles.skeleton(k).Skeleton.PixelPosition(17,:);

    drawBones2D_pixels(skeleton2D_upper)

    figure(2)
    
         subplot(2,3,1)
         imagesc(Frame.RGB);
         title('RGB Image')

    

    subplot(2,3,2)
        imagesc(Frame.Depth);colorbar;
        title('Depth Image')

    subplot(2,3,3)  
        imagesc(Frame.User);colorbar;
        title('Mask  User')

        
       
        
    subplot(2,3,4)
        imagesc(image_depth);colorbar;
        title('User Z Component')

    subplot(2,3,5)
        imagesc(image_depth_x)
        title('User X Component');colorbar;

    subplot(2,3,6)
        imagesc(image_depth_y)
        title('User Y Component');colorbar;


        pause
end

end

end


des=F; 


function depth = getDepth(frame,maxDepth)
    depth = uint16(round(double(rgb2gray(frame))/255.0*maxDepth));
