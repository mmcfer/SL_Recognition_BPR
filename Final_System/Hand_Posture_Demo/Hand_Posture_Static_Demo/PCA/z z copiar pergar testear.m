copiar pegar testear


Five=extract_data_hand_depth_no_binary('TrainingSet\Static1\RGB','TrainingSet\Static1\Depth');
Five2=extract_data_hand_depth_no_binary('TrainingSet\Static2\RGB','TrainingSet\Static2\Depth');
Five2(:,:,1)=Five2(:,:,2);
Star=extract_data_hand_depth_no_binary('TrainingSet\Static3\RGB','TrainingSet\Static3\Depth');
Star(:,:,8)=fliplr(Star(:,:,8));
Star(:,:,9)=fliplr(Star(:,:,9));
Star(:,:,10)=fliplr(Star(:,:,10));
Star(:,:,11)=fliplr(Star(:,:,11));
Star(:,:,12)=fliplr(Star(:,:,12));
Star(:,:,14)=fliplr(Star(:,:,14));
Star(:,:,15)=fliplr(Star(:,:,15));
Star(:,:,16)=fliplr(Star(:,:,16));

Fist=extract_data_hand_depth_no_binary('TrainingSet\Static4\RGB','TrainingSet\Static4\Depth');


Five_rot=extract_data_hand_depth_no_binary('TrainingSet\Static5\RGB','TrainingSet\Static5\Depth');
Five_rot(:,:,3)=Five_rot(:,:,1);
Five_rot(:,:,4)=Five_rot(:,:,2);
Five_rot(:,:,5)=Five_rot(:,:,8);
Five_rot(:,:,6)=Five_rot(:,:,9);
Five_rot(:,:,7)=Five_rot(:,:,10);
Five_rot(:,:,29)=Five_rot(:,:,26);
Five_rot(:,:,30)=Five_rot(:,:,27);
Five_rot(:,:,31)=Five_rot(:,:,28);

Five2_rot=extract_data_hand_depth_no_binary('TrainingSet\Static6\RGB','TrainingSet\Static6\Depth');
Fist_rot=extract_data_hand_depth_no_binary('TrainingSet\Static7\RGB','TrainingSet\Static7\Depth');
Horns=extract_data_hand_depth_no_binary('TrainingSet\Static8\RGB','TrainingSet\Static8\Depth');



Five_test=extract_data_hand_depth_no_binary('TestSet\Static1\RGB','TestSet\Static1\Depth');
Five2_test=extract_data_hand_depth_no_binary('TestSet\Static2\RGB','TestSet\Static2\Depth')
Star_test=extract_data_hand_depth_no_binary('TestSet\Static3\RGB','TestSet\Static3\Depth');
Fist_test=extract_data_hand_depth_no_binary('TestSet\Static4\RGB','TestSet\Static4\Depth');
Five_rot_test=extract_data_hand_depth_no_binary('TestSet\Static5\RGB','TestSet\Static5\Depth');
Five2_rot_test=extract_data_hand_depth_no_binary('TestSet\Static6\RGB','TestSet\Static6\Depth');
Fist_rot_test=extract_data_hand_depth_no_binary('TestSet\Static7\RGB','TestSet\Static7\Depth');
Horns_test=extract_data_hand_depth_no_binary('TestSet\Static8\RGB','TestSet\Static8\Depth');



% testear con imagenes de training
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
matrixpercent=matrixpercent';

%para quitar la ultima columna que es cuando no encuentra nada ---------
matrixpercent=matrixpercent(:,1:8);

xlswrite('ConfusionMatrix_PCA_rgb', matrixpercent,'hoja1')
 xlswrite('ConfusionMatrix_PCA_depth', matrixpercent,'hoja1','B2')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%para depth


[result,percent1] = Test_HandRecognition(Five_depth);
[result,percent2] = Test_HandRecognition(Five2_depth);
[result,percent3] = Test_HandRecognition(Five_rot_depth);
[result,percent4] = Test_HandRecognition(Five2_rot_depth);
[result,percent5] = Test_HandRecognition(Fist_depth);
[result,percent6] = Test_HandRecognition(Fist_rot_depth);
[result,percent7] = Test_HandRecognition(Horns_depth);
[result,percent8] = Test_HandRecognition(Star_depth);


matrixpercent=[percent1 percent2 percent3 percent4 percent5...
percent6 percent7 percent8 ];

%para quitar la ultima columna que es cuando no encuentra nada ---------
matrixpercent=matrixpercent(:,1:8);

xlswrite('ConfusionMatrix_PCA_depth2', matrixpercent,'hoja1')
