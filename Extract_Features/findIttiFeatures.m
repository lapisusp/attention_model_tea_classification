function features = findIttiFeatures(img, dims)
%
% features = findIttiFeatures(img, dims)
% the three channels of Itti and Koch's saliency model

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

fprintf('Finding Itti&Koch channels...'); tic;
features=zeros(dims(1)*dims(2), 4);

img = initializeImage(img);
params = defaultSaliencyParams(img.size, 'dyadic');
[salmap, salData] = makeSaliencyMap(img, params);

colorCM = imresize(salData(1).CM.data, dims);
intensityCM = imresize(salData(2).CM.data, dims);
orientationCM = imresize(salData(3).CM.data, dims);
skinCM = imresize(salData(4).CM.data, dims);

features(:, 1) = colorCM(:);
% imwrite(colorCM, 'color.jpg');
features(:, 2) = intensityCM(:);
% imwrite(intensityCM, 'intensity.jpg');
features(:, 3) = orientationCM(:);
% imwrite(orientationCM, 'orientationCM.jpg')
features(:, 4) = skinCM(:);
% imwrite(skinCM, 'skinCM.jpg')
% imshow(skinCM);
fprintf([num2str(toc), ' seconds \n']);

if nargout==0
    subplot(141); imshow(reshape(features(:, 1), dims)); title('color channel');
    subplot(142); imshow(reshape(features(:, 2), dims)); title('intensity channel');
    subplot(143); imshow(reshape(features(:, 3), dims)); title('orientation channel');
    subplot(144); imshow(reshape(features(:, 4), dims)); title('skin channel');
end