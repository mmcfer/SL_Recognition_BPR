

[descrip1,error1]=marc_shape_context(Five);
 [descrip2,error2]=marc_shape_context(Five2); 
 [descrip3,error3]=marc_shape_context(Five_rot);
 [descrip4,error4]=marc_shape_context(Five2_rot);
 [descrip5,error5]=marc_shape_context(Fist);
  [descrip6,error6]=marc_shape_context(Fist_rot);
 [descrip7,error7]=marc_shape_context(Horns);
 [descrip8,error8]=marc_shape_context(Star); 

 
  
descrip_all=[ descrip1	;	descrip2	;	descrip3	;	descrip4	;	descrip5	;	descrip6	;	descrip7	;	descrip8];
 maxim=max(descrip_all);
 for i=1:60
     
     descrip_all(:,i)=descrip_all(:,i)/maxim(i);
    
 end
 
 
 tic
opts = statset('MaxIter', 2000);
[idsNORM_shape_des,centroids_shape_es] = kmeans(descrip_all, 100, 'options',opts);
toc


%guardar maxim

 [hist_descrip1,hist_error1]=shape_context_histo_centr(Five,centroids_shape_es,maxim);
 [hist_descrip2,hist_error2]=shape_context_histo_centr(Five2,centroids_shape_es,maxim); 
 [hist_descrip3,hist_error3]=shape_context_histo_centr(Five_rot,centroids_shape_es,maxim);
 [hist_descrip4,hist_error4]=shape_context_histo_centr(Five2_rot,centroids_shape_es,maxim);
 [hist_descrip5,hist_error5]=shape_context_histo_centr(Fist,centroids_shape_es,maxim);
  [hist_descrip6,hist_error6]=shape_context_histo_centr(Fist_rot,centroids_shape_es,maxim);
 [hist_descrip7,hist_error7]=shape_context_histo_centr(Horns,centroids_shape_es,maxim);
 [hist_descrip8,hist_error8]=shape_context_histo_centr(Star,centroids_shape_es,maxim); 
 

hist_descrip_all=[ hist_descrip1	;	hist_descrip2	;	hist_descrip3	;	hist_descrip4	;	hist_descrip5	;	hist_descrip6	;	hist_descrip7	;	hist_descrip8	];
 maxim_hist=max(hist_descrip_all);
 %comprovar la normalització

 
for i=1:100
     
     hist_descrip_all(:,i)=hist_descrip_all(:,i)/maxim_hist(i);
    
end
 max(hist_descrip_all(:))

min(hist_descrip_all(:))
%  tic
% opts = statset('MaxIter', 2000);
% [idsNORM_hist,centroids_hist] = kmeans(hist_descrip_all, 55, 'options',opts);
% toc


 
 %train de SVM
 training_label_vector=[ ones(1,size(hist_descrip1,1))	,	2*ones(1,size(hist_descrip2,1))	,	3*ones(1,size(hist_descrip3,1))	,	4*ones(1,size(hist_descrip4,1))	,	5*ones(1,size(hist_descrip5,1))	,	6*ones(1,size(hist_descrip6,1))	,	7*ones(1,size(hist_descrip7,1))	,	8*ones(1,size(hist_descrip8,1))	]; 
 training_label_vector=training_label_vector';
 
Training_instance_matrix=sparse(hist_descrip_all);
model = train(training_label_vector, Training_instance_matrix ,[' -s 4' , ' -c 1']);
 

% testing SVM


 [hist_descrip1_test,hist_error1]=shape_context_histo_centr(Five_test,centroids_shape_es,maxim);
 [hist_descrip2_test,hist_error2]=shape_context_histo_centr(Five2_test,centroids_shape_es,maxim); 
 [hist_descrip3_test,hist_error3]=shape_context_histo_centr(Five_rot_test,centroids_shape_es,maxim);
 [hist_descrip4_test,hist_error4]=shape_context_histo_centr(Five2_rot_test,centroids_shape_es,maxim);
 [hist_descrip5_test,hist_error5]=shape_context_histo_centr(Fist_test,centroids_shape_es,maxim);
  [hist_descrip6_test,hist_error6]=shape_context_histo_centr(Fist_rot_test,centroids_shape_es,maxim);
 [hist_descrip7_test,hist_error7]=shape_context_histo_centr(Horns_test,centroids_shape_es,maxim);
 [hist_descrip8_test,hist_error8]=shape_context_histo_centr(Star_test,centroids_shape_es,maxim); 
 
 
 hist_descrip_all_test=[ hist_descrip1_test	;	hist_descrip2_test	;	hist_descrip3_test	;	hist_descrip4_test	;	hist_descrip5_test	;	hist_descrip6_test	;	hist_descrip7_test	;	hist_descrip8_test	];

 
 %normalizar por los maximos encontrados en training (tambien comprobar si
 %el minimo es 0 (siempre es)
 for i=1:100
     
     hist_descrip_all_test(:,i)=hist_descrip_all_test(:,i)/maxim_hist(i);
    
end
 
testing_label_vector=[ ones(1,size(hist_descrip1_test,1))	,	2*ones(1,size(hist_descrip2_test,1))	,	3*ones(1,size(hist_descrip3_test,1))	,	4*ones(1,size(hist_descrip4_test,1))	,	5*ones(1,size(hist_descrip5_test,1))	,	6*ones(1,size(hist_descrip6_test,1))	,	7*ones(1,size(hist_descrip7_test,1))	,	8*ones(1,size(hist_descrip8_test,1))	]; 
testing_label_vector=testing_label_vector';
 
Testing_instance_matrix=sparse(hist_descrip_all_test);

[predicted_label] = predict(testing_label_vector, Testing_instance_matrix, model );

matrix=reshape(predicted_label,50,8);
predictions=hist(matrix,1:8);
predictions=predictions';
imagesc(predictions)

 for i=1:8
predictions_norm(i,:)=predictions(i,:)./(sum(predictions(i,:)));
end
imagesc(predictions_norm);colorbar

% [predicted_label, accuracy, decision_values/prob_estimates] = predict(training_label_vector, Training_instance_matrix, model ['col']);


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
for i=1:50
     
     descrip_basta_prueba_hist(:,i)=descrip_basta_prueba_hist(:,i)/maxim_hist(i);
    
end


 