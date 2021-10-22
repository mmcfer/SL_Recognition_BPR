
% PCA based Hanf gesture recognition
%Script file written by Matt Merati of NEOS GeoSolutions , June 2012

% This function is an PCA based approach contains the training stage for
% the Hand gesture detection and recognition. An eigen space is stablished
% from the hand postures traininig images using PCA and the hand postures
% training images are  mapped to the eigenspace for classification

% Assume we have 4 sets of hand training images called 1)Hand fist 2) Hand
% Five 3) Hand Horizontal 4)Hand Vertical for each hand (Left & Right)

% We propose 4 video files with the resolution of 50*50 for each hand
% gesture. The length of each video file is 200 images. The hand gestures

% Each training image is treated as one vector, simply by concatenating the
% rows of pixels in the original image, resulting in a single row with r*c
% elements. For this implementation it is assumed that all images of the
% training set are stored in a single matrix Tr
% 

clear all
close all
clc
%addpath('Training_Bin')
% There are some holes in the captured training images, that's why we have
% to fill them
load('Fist.mat');
[~, ~, b]= size(Fist);
for bb=1:b
Fist(:,:,bb)=imfill(Fist(:,:,bb),'holes');
end

load('Fist_rot.mat');
[~, ~, b]= size(Fist_rot);
for bb=1:b
Fist_rot(:,:,bb)=imfill(Fist_rot(:,:,bb),'holes');
end


load('Five.mat');
[~, ~, b]= size(Five);
for bb=1:b
Five(:,:,bb)=imfill(Five(:,:,bb),'holes');
end

load('Five2.mat');
[~, ~, b]= size(Five2);
for bb=1:b
Five2(:,:,bb)=imfill(Five2(:,:,bb),'holes');
end


load('Five_rot.mat');
[~, ~, b]= size(Five_rot);
for bb=1:b
Five_rot(:,:,bb)=imfill(Five_rot(:,:,bb),'holes');
end


load('Five2_rot.mat');
[~, ~, b]= size(Five2_rot);
for bb=1:b
Five2_rot(:,:,bb)=imfill(Five2_rot(:,:,bb),'holes');
end
load('Horns.mat');
[r c b]= size(Horns);
for bb=1:b
Horns(:,:,bb)=imfill(Horns(:,:,bb),'holes');
end

load('Star.mat');
[~, ~, b]= size(Star);
for bb=1:b
Star(:,:,bb)=imfill(Star(:,:,bb),'holes');
end



Numgestures=8;
% Now we plot one sample (sample=50) of each gesture 
figure(1)
title('Sample of each training gesture image')
subplot(2,4,1)
imshow(Five(:,:,end),[ ])
subplot(2,4,2)
imshow(Five2(:,:,end), [ ])
subplot(2,4,3)
imshow(Five_rot(:,:,end), [ ])
subplot(2,4,4)
imshow(Five2_rot(:,:,end),[ ])
subplot(2,4,5)
imshow(Fist(:,:,end),[ ])
subplot(2,4,6)
imshow(Fist_rot(:,:,end), [ ])
subplot(2,4,7)
imshow(Horns(:,:,end), [ ])
subplot(2,4,8)
imshow(Star(:,:,end),[ ])



% Now we assign each gesture sample to an associated image 
[r c b]= size(Five);
imgFive=zeros(b,r*c);
for bb=1:b
    five=Five(:,:,bb);
    imgFive(bb,:)=five(:);
end

[r c b]= size(Five2);
imgFive2=zeros(b,r*c);
for bb=1:b
    five2=Five2(:,:,bb);
    imgFive2(bb,:)=five2(:);
end
[r c b]= size(Five_rot);
imgFive_rot=zeros(b,r*c);
for bb=1:b
    five_rot=Five_rot(:,:,bb);
    imgFive_rot(bb,:)=five_rot(:);
end

[r c b]= size(Five2_rot);
imgFive2_rot=zeros(b,r*c);
for bb=1:b
    five2_rot=Five2_rot(:,:,bb);
    imgFive2_rot(bb,:)=five2_rot(:);
end

[r c b]= size(Fist);
imgFist=zeros(b,r*c);
for bb=1:b
    fist=Fist(:,:,bb);
    imgFist(bb,:)=fist(:);
end

[r c b]= size(Fist_rot);
imgFist_rot=zeros(b,r*c);
for bb=1:b
    fist_rot=Fist_rot(:,:,bb);
    imgFist_rot(bb,:)=fist_rot(:);
end
[r c b]= size(Horns);
imgHorns=zeros(b,r*c);
for bb=1:b
    horns=Horns(:,:,bb);
    imgHorns(bb,:)=horns(:);
end
[r c b]= size(Star);
imgStar=zeros(b,r*c);
for bb=1:b
    star=Star(:,:,bb);
    imgStar(bb,:)=star(:);
end

% now we generate a matrix that each of its rows contains a training image
Tr=[imgFive;imgFive2;imgFive_rot;imgFive2_rot; imgFist; imgFist_rot; imgHorns;imgStar];

%The average hand gesture vector is computes by adding all the training
%images and then dividing the result by the number of all the training
%images. Each training image is normalized by subtracting it from the mean
% Remove the mean row_wise

 %Tr_Left=Tr_Left-repmat(mean(Tr_Left,2),1,size(Tr_Left,2));

% Calculate eigenvectors V , and eigenvalues of the covariance matrix
tic

[Matrix, EvalueMatrix]=eig(cov(Tr));
Evalues=diag(EvalueMatrix);
 toc
% Order by largest eigenvalue
Evalues=Evalues(end:-1:1);
Matrix=Matrix(:,end:-1:1);

% Eigenvectors are the columns of the V_Left matrix
figure(2),
plot(Evalues);
title('Eigenvalues plot for hand gestures')
hold on
plot(Evalues,'*')
hold off
xlabel('Principal Component Number')
ylabel('Eigenvalues');
axis([0 40 0 180]);

% Determine the M most eigenvectors
M=15;
Matrix=Matrix(:,1:M);
figure(3);
%title('M=10 most Eigenimages') 
for ii=1:M
    subplot(3,5,ii)
 imshow(reshape(Matrix(:,ii),r,c), [ ]);
end



% Now we project the hand posture training images into the eigenspace and
% store the wights (PCA component spcace/ PCA scores)

W_Five=mean(imgFive,1)* Matrix(:,1:M);
W_Five2=mean(imgFive2,1)* Matrix(:,1:M);
W_Five_rot=mean(imgFive_rot,1)*Matrix(:,1:M);
W_Five2_rot=mean(imgFive2_rot,1)*Matrix(:,1:M);
W_Fist=mean(imgFist,1)*Matrix(:,1:M);
W_Fist_rot=mean(imgFist_rot,1)*Matrix(:,1:M);
W_Horns=mean(imgHorns,1)*Matrix(:,1:M);
W_Star=mean(imgStar,1)*Matrix(:,1:M);

Weights=[W_Five;W_Five2;W_Five_rot;W_Five2_rot;W_Fist;W_Fist_rot;W_Horns;W_Star];

mean_Five=reshape(mean(imgFive,1),r,c);
mean_Five2=reshape(mean(imgFive2,1),r,c);
mean_Five_rot=reshape(mean(imgFive_rot,1),r,c);
mean_Five2_rot=reshape(mean(imgFive2_rot,1),r,c);
mean_Fist=reshape(mean(imgFist,1),r,c);
mean_Fist_rot=reshape(mean(imgFist_rot,1),r,c);
mean_Horns=reshape(mean(imgHorns,1),r,c);
mean_Star=reshape(mean(imgStar,1),r,c);

figure(4)
title('Mean image of each training set')
subplot(2,4,1)
imshow(mean_Five, [ ]);
title('Hand Five')
subplot(2,4,2)
imshow(mean_Five2,[ ] );
title('Hand Five2')
subplot(2,4,3)
imshow(mean_Five_rot, [ ]);
title('Hand Five Rot')
subplot(2,4,4)
imshow(mean_Five2_rot, [ ]);
title('Hand Five2 Rot')

subplot(2,4,5)
imshow(mean_Fist, [ ]);
title('Hand Fist')
subplot(2,4,6)
imshow(mean_Fist_rot,[ ] );
title('Hand Fist Rot')
subplot(2,4,7)
imshow(mean_Horns, [ ]);
title('Hand Horns')
subplot(2,4,8)
imshow(mean_Star, [ ]);
title('Hand Star')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

gesture_names={'Five', 'Five2', 'Five_rot', 'Five2_rot' , 'Fist','Fist_rot','Horns', 'Star'};

save('training_results.mat','Matrix','Weights', ...
 'Numgestures','gesture_names');

