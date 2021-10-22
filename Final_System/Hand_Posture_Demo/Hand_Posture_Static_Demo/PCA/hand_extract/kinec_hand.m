function kinec_hand(depth,a)
% anew = a(220:260,300:340);              %center square of depth image
% anew = anew(anew>0);                    %removes "dead zones" that distort values
% center = mean(mean(anew));              %average depth of center image
% athreshUpper = center - 60;             %defines depth of surface
% athreshLower = athreshUpper - 275; 

[finger,wrist,mins] = HandExtractTwoHands(a); %runs hand extract function

if((finger.first(1)~=0)||(mins.first(1)~=0))
        if finger.second==0             %displays image if one hand is present
            

            imagesc(a);hold on;plot(mins.first(:,1),mins.first(:,2),'g.',...
                finger.first(:,2),finger.first(:,1),'b.',...
                wrist.first(:,2),wrist.first(:,1),'w.')
           
            axis image;
            hold off;
        else                            %displays image if two hands are present
            imagesc(a);hold on;plot(mins.first(:,1),mins.first(:,2),'g.',...
                finger.first(:,2),finger.first(:,1),'b.',...
                wrist.first(:,2),wrist.first(:,1),'w.',...
                mins.second(:,1),mins.second(:,2),'g.',...
                finger.second(:,2),finger.second(:,1),'b.',...
                wrist.second(:,2),wrist.second(:,1),'w.');
            axis image;
            hold off;
        end
end                              %displays image of depth without labeling fingers if no hands are found
   
    end
  