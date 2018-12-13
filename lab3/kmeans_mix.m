function [segmentation, centers, empty, cen_idx, count] = kmeans_mix(Ivec, K, L, seed)
delta = 100 * ones(K, 3);
clus_centers = zeros(K, 3);
clus_centers_new = zeros(K, 3);
idx_old = zeros(1, size(Ivec, 1));
empty = false;
threshold = 0.01;
count = 0;
nthreshold = 2;

%Choose cluster centers from img pixels
idx = randperm(size(Ivec, 1), K);
for i = 1 : K
    clus_centers(i, :) = Ivec(idx(i), :);
end

% Compute all distances between pixels and cluster centers
D = pdist2(clus_centers, Ivec, 'euclidean');

% Iterate L times
for i = 1 : L
    % Assign each pixel to the cluster center for which the distance is minimum
    [~, cen_idx] = min(D);

    % Recompute each cluster center by taking the mean of all pixels assigned to it
    for j = 1 : K
        n_idx = find(cen_idx == j);
        if size(n_idx, 2) < nthreshold
            clus_centers(j, :) = rand(1, 3);
        else
            clus_centers(j, :) = double(mean(Ivec(n_idx, :)));
        end
    end
    % Recompute all distances between pixels and cluster centers
    D = pdist2(clus_centers, Ivec, 'euclidean');
end

[~, cen_idx] = min(D);
segmentation = cen_idx;
centers = clus_centers;