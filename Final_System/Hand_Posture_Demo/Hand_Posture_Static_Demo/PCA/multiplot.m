function multiplot(image)
count=1;
for j=1:size(image,3)
  subplot(6,6,count)
  imagesc(image(:,:,j))
  
   if count==36
      figure
      count=0;
  end
  count=count+1;
  
  
end