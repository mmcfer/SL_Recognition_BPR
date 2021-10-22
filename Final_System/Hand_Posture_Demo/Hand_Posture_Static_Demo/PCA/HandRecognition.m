function [Hand2]=HandRecognition(Hand,Matrix,gesture_names,Weights)

EigN=15;
NormThresh=1000*[1000 1000 1000 1000 800 1000 1000 1000];
% Projecting the detected mask to eigenspace
Weights2=Hand(:)'*Matrix(:,1:EigN);

% Calculating minimum Euclidian distance to the weights of groundtruth gesture images 
Norm=sum((Weights(:,1:EigN)-ones(8,1)*Weights2).^2,2);

% Defining the movement as the closest euclidian norm to the 'true'
% gestures projeted on the same set of eigenimages (eigengestures)
% If a gesture is too far from all of true gestures (determined by corresponding threshold), it is not detected.
[tmpNorm,tmpHand]=min(Norm);
if(tmpNorm<NormThresh(tmpHand))
    Hand2=gesture_names(tmpHand);
    fprintf(1,'The posture of the left hand is:\n%s\n',Hand2{1})
else
    Hand2='';
    fprintf(1,'The posture of the left hand is:\nDon`t know')
end
    
end