function saliencyMap = saliency(FEATURES, inputPath, outputPath, imagefile, imgPrev)
%
% saliencyMap = saliency(imagefile)
% This finds the saliency map of a given input image

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

% load the image
img = imread([inputPath imagefile]);
[w, h, c] = size(img);
dims = [200, 350];
% find all the necessary features for this image
% this will create a [w*h, numFeatures] array
% be sure to attach all the necessary libraries for these features to work.
% See the README.txt
FEATURES(:, 1:14) = findSubbandFeatures(img, dims);
FEATURES(:, 15:17) = findIttiFeatures(img, dims);
FEATURES(:, 18:23) = findColorFeatures(img, dims);
FEATURES(:, 24) = findTorralbaSaliency(img, dims);
FEATURES(:, 25) = findHorizonFeatures(img, dims);
FEATURES(:, 26:27) = findObjectFeatures(img, dims);
FEATURES(:, 28) = findDistToCenterFeatures(img, dims);
if (~isempty(imgPrev))
    imgP = imread([inputPath imgPrev]);
    FEATURES(:, 29) = extractMovment(imgP, img, dims);
else
    FEATURES(:, 29) = linspace(0,0,dims(1)*dims(2));
end
shortname = imagefile(1 : end - length('.jpg'));
save(fullfile(outputPath,[shortname '.mat']),'FEATURES');