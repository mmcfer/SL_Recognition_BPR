%train

for i=1:184
    A=hist_descrip1(i,:);
    B=hist_descrip1_left(i,:);
    C=[A;B];
both_hist1(i,:)	=sum(C);
end
for i=1:184
    A=hist_descrip2(i,:);
    B=hist_descrip2_left(i,:);
    C=[A;B];
both_hist2(i,:)	=sum(C);
end
for i=1:184
    A=hist_descrip3(i,:);
    B=hist_descrip3_left(i,:);
    C=[A;B];
both_hist3(i,:)	=sum(C);
end
for i=1:184
    A=hist_descrip4(i,:);
    B=hist_descrip4_left(i,:);
    C=[A;B];
both_hist4(i,:)	=sum(C);
end

for i=1:184
    A=hist_descrip5(i,:);
    B=hist_descrip5_left(i,:);
    C=[A;B];
both_hist5(i,:)	=sum(C);
end
for i=1:184
    A=hist_descrip6(i,:);
    B=hist_descrip6_left(i,:);
    C=[A;B];
both_hist6(i,:)	=sum(C);
end

for i=1:184
    A=hist_descrip7(i,:);
    B=hist_descrip7_left(i,:);
    C=[A;B];
both_hist7(i,:)	=sum(C);
end

for i=1:184
    A=hist_descrip8(i,:);
    B=hist_descrip8_left(i,:);
    C=[A;B];
both_hist8(i,:)	=sum(C);
end

for i=1:184
    A=hist_descrip9(i,:);
    B=hist_descrip9_left(i,:);
    C=[A;B];
both_hist9(i,:)	=sum(C);
end

for i=1:184
    A=hist_descrip10(i,:);
    B=hist_descrip10_left(i,:);
    C=[A;B];
both_hist10(i,:)	=sum(C);
end

for i=1:184
    A=hist_descrip11(i,:);
    B=hist_descrip11_left(i,:);
    C=[A;B];
both_hist11(i,:)	=sum(C);
end

for i=1:184
    A=hist_descrip12(i,:);
    B=hist_descrip12_left(i,:);
    C=[A;B];
both_hist12(i,:)	=sum(C);
end

for i=1:184
    A=hist_descrip13(i,:);
    B=hist_descrip13_left(i,:);
    C=[A;B];
both_hist13(i,:)	=sum(C);
end

for i=1:184
    A=hist_descrip14(i,:);
    B=hist_descrip14_left(i,:);
    C=[A;B];
both_hist14(i,:)	=sum(C);
end

for i=1:184
    A=hist_descrip15(i,:);
    B=hist_descrip15_left(i,:);
    C=[A;B];
both_hist15(i,:)	=sum(C);
end

for i=1:184
    A=hist_descrip16(i,:);
    B=hist_descrip16_left(i,:);
    C=[A;B];
both_hist16(i,:)	=sum(C);
end

for i=1:184
    A=hist_descrip17(i,:);
    B=hist_descrip17_left(i,:);
    C=[A;B];
both_hist17(i,:)	=sum(C);
end

for i=1:184
    A=hist_descrip18(i,:);
    B=hist_descrip18_left(i,:);
    C=[A;B];
both_hist18(i,:)	=sum(C);
end

for i=1:184
    A=hist_descrip19(i,:);
    B=hist_descrip19_left(i,:);
    C=[A;B];
both_hist19(i,:)	=sum(C);
end

for i=1:184
    A=hist_descrip20(i,:);
    B=hist_descrip20_left(i,:);
    C=[A;B];
both_hist20(i,:)	=sum(C);
end




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

for i=1:64
    A=ges_hist1(i,:);
    B=ges_hist1_left(i,:);
    C=[A;B];
both_ges_hist1(i,:)	=sum(C);
end
for i=1:64
    A=ges_hist2(i,:);
    B=ges_hist2_left(i,:);
    C=[A;B];
both_ges_hist2(i,:)	=sum(C);
end
for i=1:64
    A=ges_hist3(i,:);
    B=ges_hist3_left(i,:);
    C=[A;B];
both_ges_hist3(i,:)	=sum(C);
end
for i=1:64
    A=ges_hist4(i,:);
    B=ges_hist4_left(i,:);
    C=[A;B];
both_ges_hist4(i,:)	=sum(C);
end

for i=1:64
    A=ges_hist5(i,:);
    B=ges_hist5_left(i,:);
    C=[A;B];
both_ges_hist5(i,:)	=sum(C);
end
for i=1:64
    A=ges_hist6(i,:);
    B=ges_hist6_left(i,:);
    C=[A;B];
both_ges_hist6(i,:)	=sum(C);
end

for i=1:64
    A=ges_hist7(i,:);
    B=ges_hist7_left(i,:);
    C=[A;B];
both_ges_hist7(i,:)	=sum(C);
end

for i=1:64
    A=ges_hist8(i,:);
    B=ges_hist8_left(i,:);
    C=[A;B];
both_ges_hist8(i,:)	=sum(C);
end

for i=1:64
    A=ges_hist9(i,:);
    B=ges_hist9_left(i,:);
    C=[A;B];
both_ges_hist9(i,:)	=sum(C);
end

for i=1:64
    A=ges_hist10(i,:);
    B=ges_hist10_left(i,:);
    C=[A;B];
both_ges_hist10(i,:)	=sum(C);
end

for i=1:64
    A=ges_hist11(i,:);
    B=ges_hist11_left(i,:);
    C=[A;B];
both_ges_hist11(i,:)	=sum(C);
end

for i=1:64
    A=ges_hist12(i,:);
    B=ges_hist12_left(i,:);
    C=[A;B];
both_ges_hist12(i,:)	=sum(C);
end

for i=1:64
    A=ges_hist13(i,:);
    B=ges_hist13_left(i,:);
    C=[A;B];
both_ges_hist13(i,:)	=sum(C);
end

for i=1:64
    A=ges_hist14(i,:);
    B=ges_hist14_left(i,:);
    C=[A;B];
both_ges_hist14(i,:)	=sum(C);
end

for i=1:64
    A=ges_hist15(i,:);
    B=ges_hist15_left(i,:);
    C=[A;B];
both_ges_hist15(i,:)	=sum(C);
end

for i=1:64
    A=ges_hist16(i,:);
    B=ges_hist16_left(i,:);
    C=[A;B];
both_ges_hist16(i,:)	=sum(C);
end

for i=1:64
    A=ges_hist17(i,:);
    B=ges_hist17_left(i,:);
    C=[A;B];
both_ges_hist17(i,:)	=sum(C);
end

for i=1:64
    A=ges_hist18(i,:);
    B=ges_hist18_left(i,:);
    C=[A;B];
both_ges_hist18(i,:)	=sum(C);
end

for i=1:64
    A=ges_hist19(i,:);
    B=ges_hist19_left(i,:);
    C=[A;B];
both_ges_hist19(i,:)	=sum(C);
end

for i=1:64
    A=ges_hist20(i,:);
    B=ges_hist20_left(i,:);
    C=[A;B];
both_ges_hist20(i,:)	=sum(C);
end



ges__both_hist_all=[ both_ges_hist1	;	both_ges_hist2	;	both_ges_hist3	;	both_ges_hist4	;	both_ges_hist5	;	both_ges_hist6	;	both_ges_hist7	;	both_ges_hist8	;	both_ges_hist9	;	both_ges_hist10	;	both_ges_hist11	;	both_ges_hist12	;	both_ges_hist13	;	both_ges_hist14	;	both_ges_hist15	;	both_ges_hist16	;	both_ges_hist17	;	both_ges_hist18	;	both_ges_hist19	;	both_ges_hist20	];
 
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

testing_label_vector=[ ones(1,size(both_ges_hist1,1))	,	2*ones(1,size(both_ges_hist2,1))	,	3*ones(1,size(both_ges_hist3,1))	,	4*ones(1,size(both_ges_hist4,1))	,	5*ones(1,size(both_ges_hist5,1))	,	6*ones(1,size(both_ges_hist6,1))	,	7*ones(1,size(both_ges_hist7,1))	,	8*ones(1,size(both_ges_hist8,1))	,	9*ones(1,size(both_ges_hist9,1))	,	10*ones(1,size(both_ges_hist10,1))	,	11*ones(1,size(both_ges_hist11,1))	,	12*ones(1,size(both_ges_hist12,1))	,	13*ones(1,size(both_ges_hist13,1))	,	14*ones(1,size(both_ges_hist14,1))	,	15*ones(1,size(both_ges_hist15,1))	,	16*ones(1,size(both_ges_hist16,1))	,	17*ones(1,size(both_ges_hist17,1))	,	18*ones(1,size(both_ges_hist18,1))	,	19*ones(1,size(both_ges_hist19,1))	,	20*ones(1,size(both_ges_hist20,1))	];

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
