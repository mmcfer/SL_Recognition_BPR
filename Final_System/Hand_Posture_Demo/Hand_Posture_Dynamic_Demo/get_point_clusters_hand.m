function observations = get_point_clusters(data,centroids)

% INPUT:
% data i x j
% centroids n x j

K = size(centroids,1);

for i = 1:size(data,1)
        temp = zeros(K,1);
        for n = 1:K
              temp(n) = sqrt( (centroids(n,1) - data(i,1))^2 + ...
              (centroids(n,2) - data(i,2))^2 + (centroids(n,3) - data(i,3))^2 );
        end
        [id,I] = min(temp);
        observations(i,1) = I;
    end
end