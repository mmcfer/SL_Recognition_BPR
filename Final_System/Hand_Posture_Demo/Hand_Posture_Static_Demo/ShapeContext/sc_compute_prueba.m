function [BH,mean_dist]=sc_compute_prueba(Bsamp,Tsamp,mean_dist,nbins_theta,nbins_r,r_inner,r_outer,out_vec);
% [BH,mean_dist]=sc_compute(Bsamp,Tsamp,mean_dist,nbins_theta,nbins_r,r_inner,r_outer,out_vec);
%
% compute (r,theta) histograms for points along boundary 
%
% Bsamp is 2 x nsamp (x and y coords.)
% Tsamp is 1 x nsamp (tangent theta)
% out_vec is 1 x nsamp (0 for inlier, 1 for outlier)
%
% mean_dist is the mean distance, used for length normalization
% if it is not supplied, then it is computed from the data
%
% outliers are not counted in the histograms, but they do get
% assigned a histogram
%

nsamp=size(Bsamp,2);
in_vec=out_vec==0;

% compute r,theta arrays
r_array=real(sqrt(dist2(Bsamp',Bsamp'))); % real is needed to
                                          % prevent bug in Unix version
theta_array_abs=atan2(Bsamp(2,:)'*ones(1,nsamp)-ones(nsamp,1)*Bsamp(2,:),Bsamp(1,:)'*ones(1,nsamp)-ones(nsamp,1)*Bsamp(1,:))';
theta_array=theta_array_abs-Tsamp'*ones(1,nsamp);

% create joint (r,theta) histogram by binning r_array and
% theta_array

% normalize distance by mean, ignoring outliers
if isempty(mean_dist)
   tmp=r_array(in_vec,:);
   tmp=tmp(:,in_vec);
   mean_dist=mean(tmp(:));
end
% r_array_n=r_array/mean_dist;
 r_array_n=r_array;
figure(10)
subplot(121)
plot(Bsamp(1,:),Bsamp(2,:),'go');
 axis ij

% use a log. scale for binning the distances
r_bin_edges=logspace(log10(r_inner),log10(r_outer),3);
% r_bin_edges=r_bin_edges/mean_dist;
xx = -5:0.1:5;
 y1 = sqrt (r_bin_edges(1)^2-xx.^2);
y2 = sqrt (r_bin_edges(2)^2-xx.^2);
y3 = sqrt (r_bin_edges(3)^2-xx.^2);
hold on
plot(xx,y1,'y',xx,-y1,'y')
plot(xx,y2,'b',xx,-y2,'b')
plot(xx,y3,'r',xx,-y3,'r')
hold off
axis equal
r_array_q=zeros(nsamp,nsamp);
for m=1:nbins_r
   r_array_q=r_array_q+(r_array_n<r_bin_edges(m));
end
fz=r_array_q>0; % flag all points inside outer boundary

% put all angles in [0,2pi) range
theta_array_2 = rem(rem(theta_array,2*pi)+2*pi,2*pi);
% quantize to a fixed set of angles (bin edges lie on 0,(2*pi)/k,...2*pi
theta_array_q = 1+floor(theta_array_2/(2*pi/nbins_theta));

nbins=nbins_theta*nbins_r;
BH=zeros(nsamp,nbins);
for n=1:nsamp
   fzn=fz(n,:)&in_vec;
   Sn=sparse(theta_array_q(n,fzn),r_array_q(n,fzn),1,nbins_theta,nbins_r);
   BH(n,:)=Sn(:)';
end


subplot(122);imagesc(BH);colorbar;

