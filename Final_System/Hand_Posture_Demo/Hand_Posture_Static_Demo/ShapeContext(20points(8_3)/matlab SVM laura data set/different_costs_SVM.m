

idx=linspace(-7,7,300);
for i=1:300

   a=['-s 4 -v 3 -c ' num2str(2^(idx(i)))];
model = train(training_label_vector, Training_instance_matrix ,[a]);

cross_val_accu(i)=model;
costs(i)=2^(idx(i));

end

[p p2]=max(cross_val_accu);
costs(p2)