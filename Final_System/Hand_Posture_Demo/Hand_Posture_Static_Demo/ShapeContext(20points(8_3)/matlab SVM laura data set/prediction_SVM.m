function percent=prediction_SVM(model,gesture)
error=0;
for i=1:size(gesture,2)

gesture_in=gesture{1,i};
if(isempty(gesture_in))
    
    error=error+1;
else
[predicted,accu,prob] = predict(ones(1,size(gesture_in,1))', sparse(gesture_in), model,['-b 1']);

[h,pos]=max((prob'));
[h2,pos2]=max(h');
predfinal=pos(pos2);


percent(i)=predfinal;

end
end