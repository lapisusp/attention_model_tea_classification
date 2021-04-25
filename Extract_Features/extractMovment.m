function features = extractMovment(prevImg, nextImg, dims)
prevImg = cv.cvtColor(prevImg,'RGB2GRAY');

nextImg = cv.cvtColor(nextImg,'RGB2GRAY');

flow = cv.calcOpticalFlowFarneback(prevImg, nextImg, 'WinSize',32);
validateattributes(flow, {'single'}, ...
                {'3d', 'size',[size(prevImg,1) size(prevImg,2) 2]});
            
[gm, ga] = imgradient(flow(:,:,1),flow(:,:,2));
movmentMap = imresize(gm, dims);
features = movmentMap(:);
% imshow(movmentMap);
% imwrite(movmentMap,'movemnt.jpg')