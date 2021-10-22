function demo_SContext(folder1,folder2)

% folder1 - RGB Images
% folder2 - Depth Images

%Example:
%demo_SContext('TestSet\Static1\RGB','TestSet\Static1\Depth')

close all

%Hand , shape context and histogram extraction 

[hand,histogram]=extract_data_hand_depth_no_binary_close(folder1,folder2);



%Test SVM
addpath('matlab_SVM')
load('Good_Experiment')
Testing_instance_matrix=sparse(histogram);
[predicted_label] = predict(1, Testing_instance_matrix, model );
