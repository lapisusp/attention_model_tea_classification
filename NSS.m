
function score = NSS(saliencyMap, fixationMap)
% saliencyMap is the saliency map
% fixationMap is the human fixation map (binary matrix)
map = double(imresize(saliencyMap,size(fixationMap)));

% normalize saliency map
map = (map - mean(map(:)))/std(map(:)); 

% mean value at fixation locations
score = mean(map(logical(fixationMap))); 