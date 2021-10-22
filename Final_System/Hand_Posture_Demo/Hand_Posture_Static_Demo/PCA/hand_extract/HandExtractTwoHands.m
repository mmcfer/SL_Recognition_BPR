function [finger,wrist,mins]=HandExtractTwoHands(a)

% athresh = roicolor(a,athreshLower,athreshUpper);        %isolate portions of image just above surface
% %athresh = bwareaopen(athresh,4000);                     %eliminate small objects within image smaller than 4000 pixels in area
% athresh = athresh-bwareaopen(athresh,10000);            %eliminate large objects within image greater than 10000 pixels in area
% 
% athresh(:,1:200) = 0;

%lb = bwlabel(athresh);                                  %label objects remaining in image (should be the hands)
lb = bwlabel(a);
lb = bwareaopen(lb,20);
lb = bwareaopen(lb,4000);
maximum = max(max(lb));                                 %determine how many objects are left (should be 1 or 2)

switch maximum
    case 2                                              %if there are two hands...
        first = lb;first(first==2)=0;second = lb;second(second==1)=0;second(second>0)=1; %separates the two hands

        y = 1:480;                                      %\
        x = 1:640;                                      % \
                                                        %  \
        [X Y] = meshgrid(x,y);                          %   determines centroid of hand
                                                        %  /
        cY = mean(Y(first==1));                         % /
        cX = mean(X(first==1));                         %/

        x=bwboundaries(first,8);                        %finds boundary points of hand
        x=x{1,1};                                       %re-index
        x(:,3)=sqrt((x(:,1)-cY).^2+(x(:,2)-cX).^2);     %finds distance from centroid to each boundary point
        [bf af]=butter(3,0.1,'low');
        X=filtfilt(bf,af,x(:,3));                       %filters values to produce a smooth distance curve without noise
        [maxpoint minpoint]=peakdet(X,1);               %finds max and min distances, smoothing prevents false peak detection

        X1=filtfilt(bf,af,x(:,1));
        X2=filtfilt(bf,af,x(:,2));
        X1(end+1)=X1(1);
        X2(end+1)=X2(1);

        for i=1:6
            mins.first(i,1) = X2(abs(abs(minpoint(i)))); %isolates minimum points (ridges between fingers)
            mins.first(i,2) = X1(abs(abs(minpoint(i))));
        end

        %arrange max and min points in order as they go around the hand
        %boundary. Boundary detection always starts with the left most
        %point/pixel on the image.
        %Peak points should be arranged as max,min,max,min,max...
        if maxpoint(1,1)<minpoint(1,1)
            maxpoint=maxpoint([find(maxpoint(:,1)>minpoint(1,1),1,'first'):end 1:find(maxpoint(:,1)>minpoint(1,1),1,'first')-1],1);
        end

        if minpoint(1,1)<maxpoint(1,1)
            minpoint=minpoint([find(minpoint(:,1)>maxpoint(1,1),1,'first'):end 1:find(minpoint(:,1)>maxpoint(1,1),1,'first')-1],1);
        end

        %Take consecutive max,min,max points and calculate a circle that
        %would fit all 3 points. Then record it radius. Radius should be
        %small if the max points are finger tips and the min point is the
        %valley between them. Radius will be large if the min point the
        %between the thumb and the wrist or the pinky and the wrist, ie
        %these are the sides of a hand.
        parfor i=1:length(minpoint)
            if i==length(minpoint)
                j=1;
            else
                j=i+1;
            end

            [~,rad]=calcCircle([X1(abs(maxpoint(i))) X2(abs(maxpoint(i)))],[X1(abs(minpoint(i))) X2(abs(minpoint(i)))],[X1(maxpoint(j)) X2(maxpoint(j))]);
            R(i)=rad;
        end
        handSide=find(R>2.5*median(R)); %locate hand sides

        if handSide(2)-handSide(1)>2 %rearrange fingertips in order
            label=[handSide(2):length(minpoint) 1:handSide(2)-1];
        else
            label=[handSide(1):length(minpoint) 1:handSide(1)-1];
        end

        fingertip=label([4:end 1]);                     %labels fingertips
        wristlbl=label([2 3]);                          %labels wrist
        finger.first=[x(maxpoint(fingertip),1) x(maxpoint(fingertip),2)]; %isolates fingertips
        wrist.first=[x(maxpoint(wristlbl),1) x(maxpoint(wristlbl),2)];    %isolates sides of wrist

        y = 1:480;                                      %repeats process for second hand
        x = 1:640;

        [X Y] = meshgrid(x,y);

        cY = mean(Y(second==1));
        cX = mean(X(second==1));

        x=bwboundaries(second,8);
        x=x{1,1};
        x(:,3)=sqrt((x(:,1)-cY).^2+(x(:,2)-cX).^2);
        [bf af]=butter(3,0.1,'low');
        X=filtfilt(bf,af,x(:,3));
        [maxpoint minpoint]=peakdet(X,1);

        X1=filtfilt(bf,af,x(:,1));
        X2=filtfilt(bf,af,x(:,2));
        X1(end+1)=X1(1);
        X2(end+1)=X2(1);

        for i=1:5
            mins.second(i,1) = X2(abs(minpoint(i)));
            mins.second(i,2) = X1(abs(minpoint(i)));
        end

        if maxpoint(1,1)<minpoint(1,1)
            maxpoint=maxpoint([find(maxpoint(:,1)>minpoint(1,1),1,'first'):end 1:find(maxpoint(:,1)>minpoint(1,1),1,'first')-1],1);
        end

        if minpoint(1,1)<maxpoint(1,1)
            minpoint=minpoint([find(minpoint(:,1)>maxpoint(1,1),1,'first'):end 1:find(minpoint(:,1)>maxpoint(1,1),1,'first')-1],1);
        end

        parfor i=1:length(minpoint)
            if i==length(minpoint)
                j=1;
            else
                j=i+1;
            end

            [~,rad]=calcCircle([X1(abs(maxpoint(i))) X2(abs(maxpoint(i)))],[X1(abs(minpoint(i))) X2(abs(minpoint(i)))],[X1(maxpoint(j)) X2(maxpoint(j))]); % plots individual maxima
            R(i)=rad;
        end
        handSide=find(R>2.5*median(R));

        if handSide(2)-handSide(1)>2
            label=[handSide(2):length(minpoint) 1:handSide(2)-1];
        else
            label=[handSide(1):length(minpoint) 1:handSide(1)-1];
        end

        fingertip=label([4:end 1]);
        wristlbl=label([2 3]);
        finger.second=[x(maxpoint(fingertip),1) x(maxpoint(fingertip),2)];
        wrist.second=[x(maxpoint(wristlbl),1) x(maxpoint(wristlbl),2)];
    case 1                                              %extracts hand information for single hand
        first = lb;
        y = 1:480;
        x = 1:640;

        [X Y] = meshgrid(x,y);

        cY = mean(Y(first==1));
        cX = mean(X(first==1));

        x=bwboundaries(first,8);
        x=x{1,1};
        x(:,3)=sqrt((x(:,1)-cY).^2+(x(:,2)-cX).^2);
        [bf af]=butter(3,0.1,'low');
        X=filtfilt(bf,af,x(:,3));
        [maxpoint minpoint]=peakdet(X,1);

        X1=filtfilt(bf,af,x(:,1));
        X2=filtfilt(bf,af,x(:,2));
        X1(end+1)=X1(1);
        X2(end+1)=X2(1);

      %  for i=1:7
        for i=1: length(minpoint)
            mins.first(i,1) = X2(abs(minpoint(i)));
            mins.first(i,2) = X1(abs(minpoint(i)));
        end

        if maxpoint(1,1)<minpoint(1,1)
            maxpoint=maxpoint([find(maxpoint(:,1)>minpoint(1,1),1,'first'):end 1:find(maxpoint(:,1)>minpoint(1,1),1,'first')-1],1);
        end

        if minpoint(1,1)<maxpoint(1,1)
            minpoint=minpoint([find(minpoint(:,1)>maxpoint(1,1),1,'first'):end 1:find(minpoint(:,1)>maxpoint(1,1),1,'first')-1],1);
        end

        parfor i=1:length(minpoint)
            if i==length(minpoint)
                j=1;
            else
                j=i+1;
            end

            [~,rad]=calcCircle([X1(abs(maxpoint(i))) X2(abs(maxpoint(i)))],[X1(abs(minpoint(i))) X2(abs(minpoint(i)))],[X1(maxpoint(j)) X2(maxpoint(j))]);
            R(i)=rad;
        end
       
        handSide=find(R>2.5*median(R))
        siz=size(handSide)
        if(siz(2)>=2)
            
        if handSide(2)-handSide(1)>2
            label=[handSide(2):length(minpoint) 1:handSide(2)-1];
        else
            label=[handSide(1):length(minpoint) 1:handSide(1)-1];
        end
        fingertip=label([4:end 1]);
        wristlbl=label([2 3]);
        finger.first=[x(maxpoint(fingertip),1) x(maxpoint(fingertip),2)];
        wrist.first=[x(maxpoint(wristlbl),1) x(maxpoint(wristlbl),2)];
        mins.second = 0;                                %indicates that there is no second hand
        finger.second = 0;
        wrist.second = 0;
        end
        
        
        if(siz(2)==1)
          
            label=[handSide(1):length(minpoint) 1:handSide(1)-1];
           
        fingertip=label([4:end 1]);
        wristlbl=label([2 3]);
        finger.first=[x(maxpoint(fingertip),1) x(maxpoint(fingertip),2)];
        wrist.first=[x(maxpoint(wristlbl),1) x(maxpoint(wristlbl),2)];
        mins.second = 0;                                %indicates that there is no second hand
        finger.second = 0;
        wrist.second = 0; 
        end
        if isempty(handSide) 
            
            mins.first = 0;                            
        finger.first = 0;
        wrist.first = 0; 
            
        end
        
    case 0
       mins.first = 0;                               
        finger.first = 0;
        wrist.first = 0;
        
end
end