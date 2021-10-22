function skin(frame)
imagesc(frame)




frame=double(frame);
        R=frame(:,:,1);
        G=frame(:,:,2);
        B=frame(:,:,3);
               
        % Calculating normalized RGB to get rid of brightness changes/
        % shadows etc
        R_Norm=R./(R+G+B);
        G_Norm=G./(R+G+B);
        %B_Norm=B./(R+G+B); % redundant
        
        R_Norm_skin=double(R_Norm(idx));
        G_Norm_skin=double(G_Norm(idx));
        % B_Norm_skin=double(B_Norm(idx));
        
        % Working in 2D R_normalized-G_normalized space (
        R_cent=mean((R_Norm_skin));
        G_cent=mean((G_Norm_skin));
        
        CorC=corrcoef(double([R_Norm_skin G_Norm_skin]));
        theta=atan(CorC(1,2));
        
        % Coordinate transformation into a basis with axis along main
        % ellipse axis
        RGBCos=cos(theta);
        RGBSin=sin(theta);
        alpha=RGBCos*R_Norm_skin+RGBSin*G_Norm_skin;
        beta=-RGBSin*R_Norm_skin+RGBCos*G_Norm_skin;
        
        % Calculating ellipse half widths
        R_r=2*std(alpha);
        G_r=2*std(beta);
        
        figure(3);
        R_plot=R_Norm_skin+0.01*rand(length(R_Norm_skin),1);  % Just for visualization so that points don't overlap.
        G_plot=G_Norm_skin+0.01*rand(length(G_Norm_skin),1);
        h=plot(R_plot,G_plot,'-o');
        set(h,'LineStyle','none');
        set(h,'MarkerSize',3);
        xlabel('Normalized R');
        ylabel('Normalized G');
        xlim([0 1]);
        ylim([0 1]);
        hold on;
        % ellipse.m creates tiled ellipse in a figure. Downloaded from
        % MathWorks (see code for details and copyright)
        ellipse(R_r,G_r,theta,R_cent,G_cent,'r')
        hold off;
        




IM_RGB=frame;




RGBSum=(double(IM_RGB(:,:,1))+double(IM_RGB(:,:,2))+double(IM_RGB(:,:,3)));
figure
 imagesc(uint8(RGBSum))
    R_Norm=double(IM_RGB(:,:,1))./RGBSum;
    G_Norm=double(IM_RGB(:,:,2))./RGBSum;
    d_R=(R_Norm-R_cent);
    d_G=(G_Norm-G_cent);
    % Masking in tilted coordinates
    Mask=((((RGBCos*d_R+RGBSin*d_G).^2)/R_r^2+...
        ((-RGBSin*d_R+RGBCos*d_G).^2)/G_r^2)<1);
    
    imagesc(Mask)
    
    
 %  Mask=imclose(Mask,SE);
% Filling the holes
Mask=imfill(Mask,'holes');

CC = bwconncomp(Mask);
STATS = regionprops(CC, 'Area');
RegProps=cat(1,STATS.Area);
[~,idx] = sort(RegProps);
% Getting 3 largest areas
Mask = ismember(labelmatrix(CC), idx(max(1,length(idx)-2):end));

% If we detected face and both hands:
if(length(idx)>2)
    % Calculating centroids for all regions
    CC = bwconncomp(Mask);
    STATS = regionprops(CC, 'Centroid');
    RegProps=cat(1,STATS.Centroid);
    STATS = regionprops(CC, 'BoundingBox');
    RegBoundingBox=round(cat(1,STATS.BoundingBox));
    % The uppermost part of the mask
    [~,idx]=min(RegProps(:,2));
    Face.Centroid=RegProps(idx,:);
    % The leftmost part of the mask
    [~,idx]=min(RegProps(:,1));
    LeftHand.Centroid=RegProps(idx,:);
    
    % Getting the content of the bounding box around left hand
    LeftHand=ismember(labelmatrix(CC), idx);
    LeftHand=imcrop(MainGui.LeftHand.IM,RegBoundingBox(idx,:));
    
end