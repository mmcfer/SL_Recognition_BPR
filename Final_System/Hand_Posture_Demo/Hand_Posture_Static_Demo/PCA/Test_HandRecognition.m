function [result,percent] = Test_HandRecognition(setimage)

count=0;
count2=0;
count3=0;
count4=0;
count5=0;
count6=0;
count7=0;
count8=0;
count9=0;

% load('training_results_rgb.mat')
load('training_results.mat')
%load('training_results_depth_No_bin.mat')
%load('training_results_rgb_No_bin.mat')



for i=1:size(setimage,3)
    [Hand2]=HandRecognition(setimage(:,:,i),Matrix,gesture_names,Weights);
   result{i,1}=Hand2; 
  
 if(strcmp(result{i,1},'Five'))
     count=count+1;
 end
 if(strcmp(result{i,1},'Five2'))
     count2=count2+1;
 end
 if(strcmp(result{i,1},'Five_rot'))
     count3=count3+1;
 end
 if(strcmp(result{i,1},'Five2_rot'))
     count4=count4+1;
 end
 
 if(strcmp(result{i,1},'Fist'))
     count5=count5+1;
 end
 
 if(strcmp(result{i,1},'Fist_rot'))
     count6=count6+1;
 end
 
 if(strcmp(result{i,1},'Horns'))
     count7=count7+1;
 end
 
 if(strcmp(result{i,1},'Star'))
     count8=count8+1;
 end
 if(strcmp(result{i,1},''))
     count9=count9+1;
 end
end
 percent=[count/length(result);count2/length(result);count3/length(result);...
     count4/length(result);count5/length(result);count6/length(result);...
     count7/length(result);count8/length(result);count9/length(result)];
 
