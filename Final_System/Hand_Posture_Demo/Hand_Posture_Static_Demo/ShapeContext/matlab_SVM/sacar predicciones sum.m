%train
[hist_descrip1,hist_error1]=shape_context_histo_centr_per_gesture_sum(basta_right,centroids_shape_es,maxim);
 [hist_descrip2,hist_error2]=shape_context_histo_centr_per_gesture_sum(buonissimo_right,centroids_shape_es,maxim); 
 [hist_descrip3,hist_error3]=shape_context_histo_centr_per_gesture_sum(cheduepalle_right,centroids_shape_es,maxim);
 [hist_descrip4,hist_error4]=shape_context_histo_centr_per_gesture_sum(chevuoi_right,centroids_shape_es,maxim);
 [hist_descrip5,hist_error5]=shape_context_histo_centr_per_gesture_sum(combinato_right,centroids_shape_es,maxim);
  [hist_descrip6,hist_error6]=shape_context_histo_centr_per_gesture_sum(cosatifarei_right,centroids_shape_es,maxim);
 [hist_descrip7,hist_error7]=shape_context_histo_centr_per_gesture_sum(daccordo_right,centroids_shape_es,maxim);
 [hist_descrip8,hist_error8]=shape_context_histo_centr_per_gesture_sum(fame_right,centroids_shape_es,maxim); 
 [hist_descrip9,hist_error9]=shape_context_histo_centr_per_gesture_sum(freganiente_right,centroids_shape_es,maxim);
 
 [hist_descrip10,hist_error10]=shape_context_histo_centr_per_gesture_sum(furbo_right,centroids_shape_es,maxim);
 [hist_descrip11,hist_error11]=shape_context_histo_centr_per_gesture_sum(messidaccordo_right,centroids_shape_es,maxim);
  [hist_descrip12,hist_error12]=shape_context_histo_centr_per_gesture_sum(noncenepiu_right,centroids_shape_es,maxim); 
 [hist_descrip13,hist_error13]=shape_context_histo_centr_per_gesture_sum(ok_right,centroids_shape_es,maxim);
  [hist_descrip14,hist_error14]=shape_context_histo_centr_per_gesture_sum(perfetto_right,centroids_shape_es,maxim);
 [hist_descrip15,hist_error15]=shape_context_histo_centr_per_gesture_sum(prendere_right,centroids_shape_es,maxim);
 [hist_descrip16,hist_error16]=shape_context_histo_centr_per_gesture_sum(seipazzo_right,centroids_shape_es,maxim);
[hist_descrip17,hist_error17]=shape_context_histo_centr_per_gesture_sum(sonostufo_right,centroids_shape_es,maxim);
[hist_descrip18,hist_error18]=shape_context_histo_centr_per_gesture_sum(tantotempo_right,centroids_shape_es,maxim);
[hist_descrip19,hist_error19]=shape_context_histo_centr_per_gesture_sum(vattene_right,centroids_shape_es,maxim);
[hist_descrip20,hist_error20]=shape_context_histo_centr_per_gesture_sum(vieniqui_right,centroids_shape_es,maxim);



hist_descrip_all=[ hist_descrip1	;	hist_descrip2	;	hist_descrip3	;	hist_descrip4	;	hist_descrip5	;	hist_descrip6	;	hist_descrip7	;	hist_descrip8	;	hist_descrip9	;	hist_descrip10	;	hist_descrip11	;	hist_descrip12	;	hist_descrip13	;	hist_descrip14	;	hist_descrip15	;	hist_descrip16	;	hist_descrip17	;	hist_descrip18	;	hist_descrip19	;	hist_descrip20	];
 
 maxim_hist=max(hist_descrip_all);
for i=1:50
     
     hist_descrip_all(:,i)=hist_descrip_all(:,i)/maxim_hist(i);
    
end

training_label_vector=[ ones(1,length(hist_descrip1))	,	2*ones(1,length(hist_descrip2))	,	3*ones(1,length(hist_descrip3))	,	4*ones(1,length(hist_descrip4))	,	5*ones(1,length(hist_descrip5))	,	6*ones(1,length(hist_descrip6))	,	7*ones(1,length(hist_descrip7))	,	8*ones(1,length(hist_descrip8))	,	9*ones(1,length(hist_descrip9))	,	10*ones(1,length(hist_descrip10))	,	11*ones(1,length(hist_descrip11))	,	12*ones(1,length(hist_descrip12))	,	13*ones(1,length(hist_descrip13))	,	14*ones(1,length(hist_descrip14))	,	15*ones(1,length(hist_descrip15))	,	16*ones(1,length(hist_descrip16))	,	17*ones(1,length(hist_descrip17))	,	18*ones(1,length(hist_descrip18))	,	19*ones(1,length(hist_descrip19))	,	20*ones(1,length(hist_descrip20))	];
 training_label_vector=training_label_vector';
Training_instance_matrix=sparse(hist_descrip_all);

model = train(training_label_vector, Training_instance_matrix ,['-s 4 -v 3 -c 1']);



%sacar histogramas por gestos aislados testear con norm histo

[ges_hist1,hist_error1]=shape_context_histo_centr_per_gesture_sum(basta_right,centroids_shape_es,maxim);
 [ges_hist2,hist_error2]=shape_context_histo_centr_per_gesture_sum(buonissimo_right,centroids_shape_es,maxim); 
 [ges_hist3,hist_error3]=shape_context_histo_centr_per_gesture_sum(cheduepalle_right,centroids_shape_es,maxim);
 [ges_hist4,hist_error4]=shape_context_histo_centr_per_gesture_sum(chevuoi_right,centroids_shape_es,maxim);
 [ges_hist5,hist_error5]=shape_context_histo_centr_per_gesture_sum(combinato_right,centroids_shape_es,maxim);
  [ges_hist6,hist_error6]=shape_context_histo_centr_per_gesture_sum(cosatifarei_right,centroids_shape_es,maxim);
 [ges_hist7,hist_error7]=shape_context_histo_centr_per_gesture_sum(daccordo_right,centroids_shape_es,maxim);
 [ges_hist8,hist_error8]=shape_context_histo_centr_per_gesture_sum(fame_right,centroids_shape_es,maxim); 
 [ges_hist9,hist_error9]=shape_context_histo_centr_per_gesture_sum(freganiente_right,centroids_shape_es,maxim);
 
 [ges_hist10,hist_error10]=shape_context_histo_centr_per_gesture_sum(furbo_right,centroids_shape_es,maxim);
 [ges_hist11,hist_error11]=shape_context_histo_centr_per_gesture_sum(messidaccordo_right,centroids_shape_es,maxim);
  [ges_hist12,hist_error12]=shape_context_histo_centr_per_gesture_sum(noncenepiu_right,centroids_shape_es,maxim); 
 [ges_hist13,hist_error13]=shape_context_histo_centr_per_gesture_sum(ok_right,centroids_shape_es,maxim);
  [ges_hist14,hist_error14]=shape_context_histo_centr_per_gesture_sum(perfetto_right,centroids_shape_es,maxim);
 [ges_hist15,hist_error15]=shape_context_histo_centr_per_gesture_sum(prendere_right,centroids_shape_es,maxim);
 [ges_hist16,hist_error16]=shape_context_histo_centr_per_gesture_sum(seipazzo_right,centroids_shape_es,maxim);
[ges_hist17,hist_error17]=shape_context_histo_centr_per_gesture_sum(sonostufo_right,centroids_shape_es,maxim);
[ges_hist18,hist_error18]=shape_context_histo_centr_per_gesture_sum(tantotempo_right,centroids_shape_es,maxim);
[ges_hist19,hist_error19]=shape_context_histo_centr_per_gesture_sum(vattene_right,centroids_shape_es,maxim);
[ges_hist20,hist_error20]=shape_context_histo_centr_per_gesture_sum(vieniqui_right,centroids_shape_es,maxim);

ges_hist_all=[ ges_hist1	;	ges_hist2	;	ges_hist3	;	ges_hist4	;	ges_hist5	;	ges_hist6	;	ges_hist7	;	ges_hist8	;	ges_hist9	;	ges_hist10	;	ges_hist11	;	ges_hist12	;	ges_hist13	;	ges_hist14	;	ges_hist15	;	ges_hist16	;	ges_hist17	;	ges_hist18	;	ges_hist19	;	ges_hist20	];
 




for i=1:50
     
     ges_hist_all(:,i)=ges_hist_all(:,i)/maxim_hist(i);
    
end

%testing 

testing_label_vector=[ ones(1,length(ges_hist1))	,	2*ones(1,length(ges_hist2))	,	3*ones(1,length(ges_hist3))	,	4*ones(1,length(ges_hist4))	,	5*ones(1,length(ges_hist5))	,	6*ones(1,length(ges_hist6))	,	7*ones(1,length(ges_hist7))	,	8*ones(1,length(ges_hist8))	,	9*ones(1,length(ges_hist9))	,	10*ones(1,length(ges_hist10))	,	11*ones(1,length(ges_hist11))	,	12*ones(1,length(ges_hist12))	,	13*ones(1,length(ges_hist13))	,	14*ones(1,length(ges_hist14))	,	15*ones(1,length(ges_hist15))	,	16*ones(1,length(ges_hist16))	,	17*ones(1,length(ges_hist17))	,	18*ones(1,length(ges_hist18))	,	19*ones(1,length(ges_hist19))	,	20*ones(1,length(ges_hist20))	];

[predicted_label] = predict( testing_label_vector', sparse(ges_hist_all), model );

% [predicted_label] = predict( randi(20,1280,1), sparse(ges_hist_all), model );

matrix=reshape(predicted_label,64,20);
predictions=hist(matrix,1:20);
predictions=predictions';
imagesc(predictions)

 for i=1:20
predictions_norm(i,:)=predictions(i,:)./(sum(predictions(i,:)));
end
imagesc(predictions_norm)
%predictions


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% "Usage: model = train(training_label_vector, training_instance_matrix, 'liblinear_options', 'col');\n"
% 	"liblinear_options:\n"
% 	"-s type : set type of solver (default 1)\n"
% 	"	0 -- L2-regularized logistic regression (primal)\n"
% 	"	1 -- L2-regularized L2-loss support vector classification (dual)\n"	
% 	"	2 -- L2-regularized L2-loss support vector classification (primal)\n"
% 	"	3 -- L2-regularized L1-loss support vector classification (dual)\n"
% 	"	4 -- multi-class support vector classification by Crammer and Singer\n"
% 	"	5 -- L1-regularized L2-loss support vector classification\n"
% 	"	6 -- L1-regularized logistic regression\n"
% 	"	7 -- L2-regularized logistic regression (dual)\n"
% 	"-c cost : set the parameter C (default 1)\n"
% 	"-e epsilon : set tolerance of termination criterion\n"
% 	"	-s 0 and 2\n" 
% 	"		|f'(w)|_2 <= eps*min(pos,neg)/l*|f'(w0)|_2,\n" 
% 	"		where f is the primal function and pos/neg are # of\n" 
% 	"		positive/negative data (default 0.01)\n"
% 	"	-s 1, 3, 4 and 7\n"
% 	"		Dual maximal violation <= eps; similar to libsvm (default 0.1)\n"
% 	"	-s 5 and 6\n"
% 	"		|f'(w)|_1 <= eps*min(pos,neg)/l*|f'(w0)|_1,\n"
% 	"		where f is the primal function (default 0.01)\n"
% 	"-B bias : if bias >= 0, instance x becomes [x; bias]; if < 0, no bias term added (default -1)\n"
% 	"-wi weight: weights adjust the parameter C of different classes (see README for details)\n"
% 	"-v n: n-fold cross validation mode\n"
% 	"-q : quiet mode (no outputs)\n"
% 	"col:\n"
% 	"	if 'col' is setted, training_instance_matrix is parsed in column format, otherwise is in row format\n"
% 


%prueba basta
