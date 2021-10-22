function matrix_ord=ordering_centroids(matrix,ids)


[A,I]=sort(ids);
for i=1:size(A,1)
matrix_ord(i,:)=matrix(I(i),:);
i
end
