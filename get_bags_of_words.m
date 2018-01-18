% Starter code prepared by James Hays for Computer Vision

%This feature representation is described in the handout, lecture
%materials, and Szeliski chapter 14.

function image_feats = get_bags_of_words(image_paths, split)
% image_paths is an N x 1 cell array of strings where each string is an
% image path on the file system.

% This function assumes that 'vocab.mat' exists and contains an N x feature vector length
% matrix 'vocab' where each row is a kmeans centroid or visual word. This
% matrix is saved to disk rather than passed in a parameter to avoid
% recomputing the vocabulary every run.

% image_feats is an N x d matrix, where d is the dimensionality of the
% feature representation. In this case, d will equal the number of clusters
% or equivalently the number of entries in each image's histogram
% ('vocab_size') below.

% You will want to construct feature descriptors here in the same way you
% did in build_vocabulary.m (except for possibly changing the sampling
% rate) and then assign each local feature to its nearest cluster center
% and build a histogram indicating how many times each cluster was used.
% Don't forget to normalize the histogram, or else a larger image with more
% feature descriptors will look very different from a smaller version of the same
% **********************************************************************Note**************************************************
% Uncomment the code from here till line # 105 to build the bag of words
% again, also comment the code from line 107 to 111. Delete the files
% test_feat.mat and train_feat.mat from the working directory to crrate new
% ones through the code

% load('vocab.mat')
% noOfClusters = size(vocab, 1);
% 
% noOfFeat = 0;
% 
% %number of entries in each image histogram
% vocab_size = size(vocab, 2);
% 
% %Number of images
% noOfImages = size(image_paths,1);
% 
% %initialise result
% image_feats = zeros(noOfImages,noOfClusters);
% 
% fprintf('Processing images (of %d): ',noOfImages);
% 
% t1 = cputime;
% %processing each image
% for i = 1:noOfImages
%     
%     if mod(i,100)==0
%         fprintf('%d, Time Taken: %d\n',i, cputime - t1);
%         t1 = cputime;
%     end
%     
%     %read each line of image
%     img = imread(char(image_paths(i)));
%     points = detectSURFFeatures(img, 'MetricThreshold', 100);
%     [feats_temp, valid_points] = extractHOGFeatures(img, points, 'NumBins', 8, 'CellSize', [16 16], 'BlockSize', [4 4]);
%     
%     features = feats_temp';
%     [p1, p2] = size(features);
%     noOfFeat = size(features,2);
%     
% %     startTime = cputime;
%     %compare each feature
%     for j = 1:noOfFeat
%         
%         dist = zeros(1,noOfClusters);
%         
%         tempFeat = double(features(:,j));
%         %measure distance between feature from each cluster center
%         for k=1:noOfClusters
%             tempCluster = vocab(k,:);
%             dist(k) = sqrt(sum((tempFeat - tempCluster') .^ 2));
%         end
%            
%         %get closest cluster center matched
%         [minVal ind] = min(dist);
%         
%         
%         image_feats(i,ind) = image_feats(i,ind) + 1;
%     end
% %     endTime = cputime;
%     
% %     fprintf('time taken = %d\n',endTime-startTime);
% 
%     %%
%         
%     % normalise histogram  
%     maxVal = max(image_feats(i,:));
%     %meanVal = mean(image_feats(i,:));
%     minVal = min(image_feats(i,:));
%     image_feats(i,:) = (image_feats(i,:)) ./ (maxVal - minVal);
%     
% end
% fprintf('\n Done!\n');
% 
% if split == 'train'
%     save('train_feat.mat', 'image_feats');
% else
%     save('test_feat.mat', 'image_feats');
% end


if split == 'train'
    load('train_feat.mat')
else
    load('test_feat.mat')
end

end