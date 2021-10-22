function [handles,des]=extract_previous_frame_subtraction(filename,gesturename)





% es spherical descriptor o en el torso -----------puedes elegir poniendo
% en verde uno o el otro










%[rgb,depth,user,data]=extract(filename)
 filenameBase = filename(1:length(filename)-4);

%  unzip(filename,filenameBase);


% filenameColor = strcat(filenameBase, '/',filenameBase, '_color.mp4');
% filenameDepth = strcat(filenameBase, '/',filenameBase, '_depth.mp4');
% filenameUser = strcat(filenameBase, '/',filenameBase, '_user.mp4');
% filenameAudio = strcat(filenameBase, '/',filenameBase, '_audio.wav');
 filenameMat = strcat(filenameBase, '/',filenameBase, '_data.mat');

handles.Video = load(filenameMat);
handles.Video = handles.Video.Video;
handles.skeleton=handles.Video.Frames;
handles.labels=handles.Video.Labels;
P=size(handles.labels);
m=0;
count=1;


for m = 1:P(1,2) 
 
if strcmp(handles.labels(1,m).Name,gesturename) 
    starts=handles.labels(1,m).Begin;
    ends=handles.labels(1,m).End;
 for i=starts:ends
A(:,:,i-starts+1)=handles.skeleton(1,i).Skeleton.WorldPosition;
end


% for j=1:(ends-starts+1)
%     
% normleft=A(8,:,j);
% normright=A(12,:,j);
% 
% lefthand=zeros(11,3);
% righthand=zeros(11,3);
% 
% lefthand(1,:)=A(4,:,j)- normleft;
% lefthand(2,:)=A(3,:,j)- normleft;
% lefthand(3,:)=A(5,:,j)- normleft;
% lefthand(4,:)=A(6,:,j)- normleft;
% lefthand(5,:)=A(8,:,j)- normleft;
% lefthand(6,:)=A(9,:,j)- normleft;
% lefthand(7,:)=A(10,:,j)- normleft;
% lefthand(8,:)=A(12,:,j)- normleft;
% lefthand(9,:)=A(2,:,j)- normleft;
% lefthand(10,:)=A(13,:,j)- normleft;
% lefthand(11,:)=A(17,:,j)- normleft;
% 
% righthand(1,:)=A(4,:,j)- normright;
% righthand(2,:)=A(3,:,j)- normright;
% righthand(3,:)=A(5,:,j)- normright;
% righthand(4,:)=A(6,:,j)- normright;
% righthand(5,:)=A(8,:,j)- normright;
% righthand(6,:)=A(9,:,j)- normright;
% righthand(7,:)=A(10,:,j)- normright;
% righthand(8,:)=A(12,:,j)- normright;
% righthand(9,:)=A(2,:,j)- normright;
% righthand(10,:)=A(13,:,j)- normright;
% righthand(11,:)=A(17,:,j)- normright;
% 
% 
% 
% 
% countB=0;
% countC=0;
% 
%     
%         for k2 = 1:size(lefthand,1)    
%         if k2~=5
%             B(1,(1+countB):(3+countB)) = lefthand(k2,1:3);
%              countB=countB+3;
%         end
%         if k2~=8
%             C(1,(1+countC):(3+countC)) = righthand(k2,1:3);
%              countC=countC+3;
%         end
%        
%         end
%     countB=0;
%     countC=0;
%     D=[B C];
%     
%         E(count,:)=D;
% 
%     if(count==1)
%    F=zeros(1,size(E,2));
%     else
%         F(count-1,:)=E(count,:)-E(count-1,:);
%     end
%     
%     count=count+1;
%  
% 
% 
% 
% 
%     
% end 
% 
% end
% 
% end
% 
% 
% des=F; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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

end

end


des=F; 
