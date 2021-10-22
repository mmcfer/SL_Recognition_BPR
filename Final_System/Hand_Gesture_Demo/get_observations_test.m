function [observationsmatrix,observations] = get_observations_test_demo(datos,centroids)


observationsmatrix=zeros(150,40);


t=datos;


%t=t/norm(t);
%t=normalization(t);
t=zscore(t,[],2);
%t=normalization_marc(t);
ob = get_point_clusters_RPBD_2(t,centroids);
%ob=knnsearch(centroids,t);
ob2=ob;

 ob2(size(ob,1)+1:150,1)=0;
 observationsmatrix(:,1)=ob2;

observations{1}=ob';



