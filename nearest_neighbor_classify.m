% Starter code prepared by James Hays for Computer Vision

%This function will predict the category for every test image by finding
%the training image with most similar features. Instead of 1 nearest
%neighbor, you can vote based on k nearest neighbors which will increase
%performance (although you need to pick a reasonable value for k).

function predicted_categories = nearest_neighbor_classify(train_image_feats, train_labels, test_image_feats, dist_met)
% image_feats is an N x d matrix, where d is the dimensionality of the
%  feature representation.
% train_labels is an N x 1 cell array, where each entry is a string
%  indicating the ground truth category for each training image.
% test_image_feats is an M x d matrix, where d is the dimensionality of the
%  feature representation. You can assume M = N unless you've modified the
%  starter code.
% predicted_categories is an M x 1 cell array, where each entry is a string
%  indicating the predicted category for each test image.

% Useful functions:
%  matching_indices = strcmp(string, cell_array_of_strings)
%    This can tell you which indices in train_labels match a particular
%    category. Not necessary for simple one nearest neighbor classifier.
 
%   [Y,I] = MIN(X) if you're only doing 1 nearest neighbor, or
%   [Y,I] = SORT(X) if you're going to be reasoning about many nearest
%   neighbors

%Calculating thr distance pairs using eucledian distance
train_image_feats = train_image_feats';
test_image_feats = test_image_feats';
dist = pdist2(train_image_feats', test_image_feats', dist_met);
dist = dist';

% predicted category for each test image
predicted_categories = [];
for i = 1:size(test_image_feats',1)
    [~, x] = min(dist(i, :));
    label = train_labels(x, 1);
    predicted_categories = [predicted_categories; label];
end












