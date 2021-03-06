function features = findDistToCenterFeatures(img, dims)
%
% features = findDistToCenterFeatures(img, dims)

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


fprintf('Finding distance to the center...'); tic;
% calculate the feature.  Each pixel is the distance away from the
% center (should measure from the original image)
[imgr, imgc, cc] = size(img);
midpointx = floor(imgr/2);
midpointy = floor(imgc/2);
distMatrix = zeros(imgr, imgc);
for x=1:imgr
    for y=1:imgc
        distMatrix(x, y) = floor(sqrt((x-midpointx)^2 + (y-midpointy)^2));
        % perhaps should scale this down to btwn 0-1;
    end
end
distMatrix = distMatrix/max(distMatrix(:));
distMatrix = imresize(distMatrix, dims);
features = distMatrix(:);
% imwrite(distMatrix, 'center.jpg');
fprintf([num2str(toc), ' seconds \n']);

if nargout<1
    imshow(reshape(features, dims)); title(['Dist to Center']);
end