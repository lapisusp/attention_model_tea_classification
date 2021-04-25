function allfeatures = collectFeatures(images, path, dims)
%
% allfeatures = collectFeatures(images, M, N)
% return allfeatures of size [M*N*numImgs, numFeatures]

% ----------------------------------------------------------------------
% Matlab tools for "Learning to Predict Where Humans Look" ICCV 2009
% Tilke Judd, Kristen Ehinger, Fredo Durand, Antonio Torralba
% 
% Copyright (c) 2010 Tilke Judd
% Distributed under the MIT License
% See MITlicense.txt file in the distribution folder.
% 
% Contact: Tilke Judd at <tjudd@csail.mit.edu>
% ----------------------------------------------------------------------

allfeatures = zeros(dims(1)*dims(2)*length(images), 32);
for i=1:length(images)
    name = images(i).name;
   %imagename = strsplit(name, '.jpg');
   index = (i-1)*(dims(1)*dims(2));
   %fix_path = fullfile(path, strcat(imagename(1), '.mat'));
   feat_path = fullfile(path, name);
   feat = load(feat_path);
   allfeatures(index+1:index+dims(1)*dims(2), 1:32) = feat.features;
end

% you can add any other features here that you'd like to test out
% the features that we used are available on our website under
% http://people.csail.mit.edu/tjudd/WherePeopleLook/Code/JuddSaliencyModel.zip