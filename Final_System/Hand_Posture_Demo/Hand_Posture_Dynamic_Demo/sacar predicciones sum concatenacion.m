%train


both_hist1	=[ hist_descrip1		 hist_descrip1_left];
both_hist2=[ hist_descrip2 hist_descrip2_left];
both_hist3=[ hist_descrip3 hist_descrip3_left];
both_hist4=[ hist_descrip4 hist_descrip4_left];
both_hist5=[ hist_descrip5 hist_descrip5_left];
both_hist6=[ hist_descrip6 hist_descrip6_left];
both_hist7=[ hist_descrip7 hist_descrip7_left];
both_hist8=[ hist_descrip8 hist_descrip8_left];
both_hist9=[ hist_descrip9 hist_descrip9_left];
both_hist10=[ hist_descrip10 hist_descrip10_left];
both_hist11=[ hist_descrip11 hist_descrip11_left];
both_hist12=[ hist_descrip12 hist_descrip12_left];
both_hist13=[ hist_descrip13 hist_descrip13_left];
both_hist14=[ hist_descrip14 hist_descrip14_left];
both_hist15=[ hist_descrip15 hist_descrip15_left];
both_hist16=[ hist_descrip16 hist_descrip16_left];
both_hist17=[ hist_descrip17 hist_descrip17_left];
both_hist18=[ hist_descrip18 hist_descrip18_left];
both_hist19=[ hist_descrip19 hist_descrip19_left];
both_hist20=[ hist_descrip20 hist_descrip20_left];




both_hist_all=[ both_hist1	;	both_hist2	;	both_hist3	;	both_hist4	;	both_hist5	;	both_hist6	;	both_hist7	;	both_hist8	;	both_hist9	;	both_hist10	;	both_hist11	;	both_hist12	;	both_hist13	;	both_hist14	;	both_hist15	;	both_hist16	;	both_hist17	;	both_hist18	;	both_hist19	;	both_hist20	];
%  
% normalization per column
%  maxim_hist=max(both_hist_all);
% for i=1:100
%      
%      both_hist_all(:,i)=both_hist_all(:,i)/maxim_hist(i);
%     
% end

%normalization per descriptor

for i=1:size(both_hist_all,1)
     
     both_hist_all(i,:)=both_hist_all(i,:)/(sum(both_hist_all(i,:)));
    
end



max(both_hist_all(:))
min(both_hist_all(:))

training_label_vector=[ ones(1,size(both_hist1,1))	,	2*ones(1,size(both_hist2,1))	,	3*ones(1,size(both_hist3,1))	,	4*ones(1,size(both_hist4,1))	,	5*ones(1,size(both_hist5,1))	,	6*ones(1,size(both_hist6,1))	,	7*ones(1,size(both_hist7,1))	,	8*ones(1,size(both_hist8,1))	,	9*ones(1,size(both_hist9,1))	,	10*ones(1,size(both_hist10,1))	,	11*ones(1,size(both_hist11,1))	,	12*ones(1,size(both_hist12,1))	,	13*ones(1,size(both_hist13,1))	,	14*ones(1,size(both_hist14,1))	,	15*ones(1,size(both_hist15,1))	,	16*ones(1,size(both_hist16,1))	,	17*ones(1,size(both_hist17,1))	,	18*ones(1,size(both_hist18,1))	,	19*ones(1,size(both_hist19,1))	,	20*ones(1,size(both_hist20,1))	];
 training_label_vector=training_label_vector';
Training_instance_matrix=sparse(both_hist_all);


model = train(training_label_vector, Training_instance_matrix ,['-s 4' , '-c 1']);

%model = train(training_label_vector, Training_instance_matrix ,['-s 4 -v 3 -c 1']);



%sacar histogramas por gestos aislados testear con norm histo

both_hist_ges1	=[ges_hist1		ges_hist1_left];
both_hist_ges2=[ges_hist2 ges_hist2_left];
both_hist_ges3=[ges_hist3 ges_hist3_left];
both_hist_ges4=[ges_hist4 ges_hist4_left];
both_hist_ges5=[ges_hist5 ges_hist5_left];
both_hist_ges6=[ges_hist6 ges_hist6_left];
both_hist_ges7=[ges_hist7 ges_hist7_left];
both_hist_ges8=[ges_hist8 ges_hist8_left];
both_hist_ges9=[ges_hist9 ges_hist9_left];
both_hist_ges10=[ges_hist10 ges_hist10_left];
both_hist_ges11=[ges_hist11 ges_hist11_left];
both_hist_ges12=[ges_hist12 ges_hist12_left];
both_hist_ges13=[ges_hist13 ges_hist13_left];
both_hist_ges14=[ges_hist14 ges_hist14_left];
both_hist_ges15=[ges_hist15 ges_hist15_left];
both_hist_ges16=[ges_hist16 ges_hist16_left];
both_hist_ges17=[ges_hist17 ges_hist17_left];
both_hist_ges18=[ges_hist18 ges_hist18_left];
both_hist_ges19=[ges_hist19 ges_hist19_left];
both_hist_ges20=[ges_hist20 ges_hist20_left];


ges__both_hist_all=[ both_hist_ges1	;	both_hist_ges2	;	both_hist_ges3	;	both_hist_ges4	;	both_hist_ges5	;	both_hist_ges6	;	both_hist_ges7	;	both_hist_ges8	;	both_hist_ges9	;	both_hist_ges10	;	both_hist_ges11	;	both_hist_ges12	;	both_hist_ges13	;	both_hist_ges14	;	both_hist_ges15	;	both_hist_ges16	;	both_hist_ges17	;	both_hist_ges18	;	both_hist_ges19	;	both_hist_ges20	];
 
% for i=1:100
%      
%      ges__both_hist_all(:,i)=ges__both_hist_all(:,i)/maxim_hist(i);
%     
% end




for i=1:size(ges__both_hist_all,1)
     
     ges__both_hist_all(i,:)=ges__both_hist_all(i,:)/(sum(ges__both_hist_all(i,:)));
    
end

max(ges__both_hist_all(:,1))
min(ges__both_hist_all(:,1))
%testing 

testing_label_vector=[ ones(1,size(both_hist_ges1,1))	,	2*ones(1,size(both_hist_ges2,1))	,	3*ones(1,size(both_hist_ges3,1))	,	4*ones(1,size(both_hist_ges4,1))	,	5*ones(1,size(both_hist_ges5,1))	,	6*ones(1,size(both_hist_ges6,1))	,	7*ones(1,size(both_hist_ges7,1))	,	8*ones(1,size(both_hist_ges8,1))	,	9*ones(1,size(both_hist_ges9,1))	,	10*ones(1,size(both_hist_ges10,1))	,	11*ones(1,size(both_hist_ges11,1))	,	12*ones(1,size(both_hist_ges12,1))	,	13*ones(1,size(both_hist_ges13,1))	,	14*ones(1,size(both_hist_ges14,1))	,	15*ones(1,size(both_hist_ges15,1))	,	16*ones(1,size(both_hist_ges16,1))	,	17*ones(1,size(both_hist_ges17,1))	,	18*ones(1,size(both_hist_ges18,1))	,	19*ones(1,size(both_hist_ges19,1))	,	20*ones(1,size(both_hist_ges20,1))	];

[predicted_label] = predict( testing_label_vector', sparse(ges__both_hist_all), model );

% [predicted_label] = predict( randi(20,1280,1), sparse(ges__both_hist_all), model );

matrix=reshape(predicted_label,64,20);
predictions=hist(matrix,1:20);
imagesc(predictions')

predictions=predictions';
imagesc(predictions)

 for i=1:20
predictions_norm(i,:)=predictions(i,:)./(sum(predictions(i,:,1)));
end
imagesc(predictions_norm,[0 1]);colorbar

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
