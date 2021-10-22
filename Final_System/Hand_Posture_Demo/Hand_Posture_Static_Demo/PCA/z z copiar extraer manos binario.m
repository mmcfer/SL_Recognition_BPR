

Five=extract_data_hand_depth('TrainingSet\Static1\RGB','TrainingSet\Static1\Depth');
Five_test=extract_data_hand_depth('TestSet\Static1\RGB','TestSet\Static1\Depth');

Five2=extract_data_hand_depth('TrainingSet\Static2\RGB','TrainingSet\Static2\Depth');
Five2_test=extract_data_hand_depth('TestSet\Static2\RGB','TestSet\Static2\Depth');
Five2(:,:,1)=Five2(:,:,2);

Star=extract_data_hand_depth('TrainingSet\Static3\RGB','TrainingSet\Static3\Depth');
Star_test=extract_data_hand_depth('TestSet\Static3\RGB','TestSet\Static3\Depth');
Star(:,:,8)=fliplr(Star(:,:,8));
Star(:,:,9)=fliplr(Star(:,:,9));
Star(:,:,10)=fliplr(Star(:,:,10));
Star(:,:,11)=fliplr(Star(:,:,11));
Star(:,:,12)=fliplr(Star(:,:,12));
Star(:,:,14)=fliplr(Star(:,:,14));
Star(:,:,15)=fliplr(Star(:,:,15));
Star(:,:,16)=fliplr(Star(:,:,16));

Fist=extract_data_hand_depth('TrainingSet\Static4\RGB','TrainingSet\Static4\Depth');
Fist_test=extract_data_hand_depth('TestSet\Static4\RGB','TestSet\Static4\Depth');

%%%%% Assumption Rotation

Five_rot=extract_data_hand_depth('TrainingSet\Static5\RGB','TrainingSet\Static5\Depth');
Five_rot_test=extract_data_hand_depth('TestSet\Static5\RGB','TestSet\Static5\Depth');
Five_rot(:,:,3)=Five_rot(:,:,1);
Five_rot(:,:,4)=Five_rot(:,:,2);
Five_rot(:,:,5)=Five_rot(:,:,8);
Five_rot(:,:,6)=Five_rot(:,:,9);
Five_rot(:,:,7)=Five_rot(:,:,10);
Five_rot(:,:,29)=Five_rot(:,:,26);
Five_rot(:,:,30)=Five_rot(:,:,27);
Five_rot(:,:,31)=Five_rot(:,:,28);


Five2_rot=extract_data_hand_depth('TrainingSet\Static6\RGB','TrainingSet\Static6\Depth');
Five2_rot_test=extract_data_hand_depth('TestSet\Static6\RGB','TestSet\Static6\Depth');
Five2_rot(:,:,1)=rot90(Five2_rot(:,:,1),-1);
Five2_rot(:,:,2)=rot90(Five2_rot(:,:,2),-1);
Five2_rot(:,:,13)=rot90(Five2_rot(:,:,13),-1);
Five2_rot(:,:,24)=rot90(Five2_rot(:,:,24),-1);
Five2_rot(:,:,29)=rot90(Five2_rot(:,:,29),-1);
Five2_rot(:,:,30)=rot90(Five2_rot(:,:,30),-1);
Five2_rot(:,:,31)=rot90(Five2_rot(:,:,31),-1);
Five2_rot(:,:,32)=rot90(Five2_rot(:,:,32),-1);
Five2_rot(:,:,33)=rot90(Five2_rot(:,:,33),-1);
Five2_rot(:,:,34)=rot90(Five2_rot(:,:,34),-1);


Fist_rot=extract_data_hand_depth('TrainingSet\Static7\RGB','TrainingSet\Static7\Depth');
Fist_rot_test=extract_data_hand_depth('TestSet\Static7\RGB','TestSet\Static7\Depth');




Horns=extract_data_hand_depth('TrainingSet\Static8\RGB','TrainingSet\Static8\Depth');
Horns_test=extract_data_hand_depth('TestSet\Static8\RGB','TestSet\Static8\Depth');
Horns(:,:,4)=Horns(:,:,1);
Horns(:,:,5)=Horns(:,:,2);
Horns(:,:,6)=Horns(:,:,3);
Horns(:,:,7)=fliplr(Horns(:,:,7));
Horns(:,:,8)=fliplr(Horns(:,:,8));
Horns(:,:,9)=fliplr(Horns(:,:,9));
Horns(:,:,10)=fliplr(Horns(:,:,10));
Horns(:,:,11)=fliplr(Horns(:,:,11));
Horns(:,:,12)=fliplr(Horns(:,:,12));
Horns(:,:,14)=fliplr(Horns(:,:,14));
Horns(:,:,15)=fliplr(Horns(:,:,15));
Horns(:,:,16)=fliplr(Horns(:,:,16));


%testear en validation
[result,percent1] = Test_HandRecognition(Five(:,:,21:end));
[result,percent2] = Test_HandRecognition(Five2(:,:,21:end));
[result,percent3] = Test_HandRecognition(Five_rot(:,:,21:end));
[result,percent4] = Test_HandRecognition(Five2_rot(:,:,21:end));
[result,percent5] = Test_HandRecognition(Fist(:,:,21:end));
[result,percent6] = Test_HandRecognition(Fist_rot(:,:,21:end));
[result,percent7] = Test_HandRecognition(Horns(:,:,21:end));
[result,percent8] = Test_HandRecognition(Star(:,:,21:end));

matrixpercent=[percent1 percent2 percent3 percent4 percent5...
percent6 percent7 percent8 ];


% testear con imagenes de test


[result,percent1] = Test_HandRecognition(Five_test);
[result,percent2] = Test_HandRecognition(Five2_test);
[result,percent3] = Test_HandRecognition(Five_rot_test);
[result,percent4] = Test_HandRecognition(Five2_rot_test);
[result,percent5] = Test_HandRecognition(Fist_test);
[result,percent6] = Test_HandRecognition(Fist_rot_test);
[result,percent7] = Test_HandRecognition(Horns_test);
[result,percent8] = Test_HandRecognition(Star_test);






matrixpercent=[percent1 percent2 percent3 percent4 percent5...
percent6 percent7 percent8 ];

sum(diag(matrixpercent))/8
