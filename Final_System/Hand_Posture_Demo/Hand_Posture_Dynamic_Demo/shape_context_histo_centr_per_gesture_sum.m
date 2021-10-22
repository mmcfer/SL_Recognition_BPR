function [gesture_out,error]=shape_context_histo_centr_per_gesture_sum(gesture,centroids)
b1=1;
tic
error=0;
for s_ind=1:1

close all


%%%
%%%Define flags and parameters:
%%%
display_flag=1;
affine_start_flag=1;
polarity_flag=1;
nsamp=60;
eps_dum=0.25;
ndum_frac=0.25;        
mean_dist_global=[];
ori_weight=0.1;
nbins_theta=12;
nbins_r=5;
r_inner=6;
r_outer=65/2;
tan_eps=1.0;
n_iter=6;
beta_init=1;
r=1; % annealing rate
w=4;
sf=2.5;

% cmap=flipud(gray);

%%%
%%% image loading
V=gesture;
for ij=1:size(V,3)
    
V1=V(:,:,ij);


[N1,N2]=size(V1);

% if display_flag
%    figure(1)
%    subplot(1,2,1)
%    imagesc(V1);axis('image')
%   
%   
%    drawnow
% end

%%%
%%% edge detection
%%%


% get boundary points

[x1,y1,t1]=bdry_extract_3(V1);

nsamp1=length(x1);
if nsamp1>=nsamp

       if(ij==538)
        ij
    end
%    [x1,y1,t1]=get_samples_1(x1,y1,t1,nsamp);

X=[x1 y1];

% if display_flag
%    subplot(1,2,2)
%    plot(X(:,1),X(:,2),'b+')
%    hold on
%    quiver(X(:,1),X(:,2),cos(t1),sin(t1),0.5,'b')
%    hold off
%    axis('ij');axis([1 N2 1 N1])
%    title([int2str(length(x1)) ' samples'])
%    
%    drawnow	
% end

if display_flag
   [x,y]=meshgrid(linspace(1,N2,36),linspace(1,N1,36));
   x=x(:);y=y(:);M=length(x);
end
%  idx = round(linspace(1,size(X,1),20));
%  figure
% 
%  plot(X(idx,1),X(idx,2),'go')
%  axis('ij');axis([1 N2 1 N1])
%%
%% compute correspondences
%%
Xk=[X(:,1),X(:,2)];
nsamp_new=length(Xk);
tk=t1;
k=1;
s=1;
ndum=round(ndum_frac*nsamp);
out_vec_1=zeros(1,nsamp_new);
out_vec_2=zeros(1,nsamp);

   [BH1,mean_dist_1]=sc_compute(Xk',zeros(1,nsamp_new),mean_dist_global,nbins_theta,nbins_r,r_inner,r_outer,out_vec_1);
 
 idx = round(linspace(1,size(X,1),20));

   
   idx = round(linspace(1,size(X,1),20));
   
   BH1=BH1(idx,:);
    for ii=1:size(BH1,1)
   a(ii,:)=BH1(ii,1:49);
    a(ii,49)=sum(BH1(ii,49:60));
    a(ii,:)=a(ii,:)/sum(a(ii,:));
   end
 
 %
  
  observations = knnsearch(centroids,a);
%    imagesc(V1)
    histogram=hist(observations,1:100);
 
%     for i=1:50
%      
%      histogram(:,i)=histogram(:,i)/maxim_hist(i);
%     
%  end
    
   descrip(b1,:)=histogram;
   
%    plot_descriptor_shape(BH1(1,:))
   
   b1=b1+1;
 
   
   else
 error=error+1;
end
end
descrip=sum(descrip);
gesture_out(s_ind,:)=descrip;
descrip=[];
b1=1;
end

toc