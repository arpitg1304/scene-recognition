% Starter code prepared by James Hays for Computer Vision

% This function will extract a set of feature descriptors from the training images,
% cluster them into a visual vocabulary with k-means,
% and then return the cluster centers.

% Notes:
% - To save computation time, we might consider sampling from the set of training images.
% - Per image, we could randomly sample descriptors, or densely sample descriptors,
% or even try extracting descriptors at interest points.
% - For dense sampling, we can set a stride or step side, e.g., extract a feature every 20 pixels.
% - Recommended first feature descriptor to try: HOG.

% Function inputs: 
% - 'image_paths': a N x 1 cell array of image paths.
% - 'vocab_size' the size of the vocabulary.

% Function outputs:
% - 'vocab' should be vocab_size x descriptor length. Each row is a cluster centroid / visual word.

function vocab = build_vocabulary( image_paths, vocab_size )

feats = [];
[N, ~] = size(image_paths);

for i = 1:N
    image = single(imread(image_paths{i}));

    % gray scale
    if size(image, 3) > 1
        image =rgb2gray(image);
    end
    
    points = detectSURFFeatures(image, 'MetricThreshold', 100);
    points = points.selectStrongest(120);
    [feats_temp, ~] = extractHOGFeatures(image, points, 'NumBins', 8, 'CellSize', [16 16], 'BlockSize', [4 4]);
    
    feats = [feats, feats_temp'];
end

[~,C] = kmeans(double(feats'), vocab_size);

vocab = C;