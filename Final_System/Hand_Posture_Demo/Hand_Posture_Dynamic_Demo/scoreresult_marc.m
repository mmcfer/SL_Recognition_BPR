function score=scoreresult_marc(matrix)

for i=1:size(matrix,2)
    
   [f, score(1,i)]=max(matrix(:,i));
     if(f==-Inf)
         score(1,i)=21;
     end
end