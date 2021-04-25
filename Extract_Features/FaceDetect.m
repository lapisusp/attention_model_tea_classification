function [im] = FaceDetect(img) 

im = im2bw(img, 1);

img = img(1:720,1:960,:);
gr = cv.cvtColor(img,'RGB2GRAY');
gr = cv.equalizeHist(gr);

cascade_alt2='haarcascade_frontalface_alt2.xml';
cascade_profile='haarcascade_profileface.xml';

xml_fileFace3 = fullfile(mexopencv.root(),'test',cascade_alt2);
classifier3 = cv.CascadeClassifier(xml_fileFace3);
xml_fileFaceProfile = fullfile(mexopencv.root(),'test',cascade_profile);
classifierProfile = cv.CascadeClassifier(xml_fileFaceProfile);

% Detect faces
faceData{1} = classifier3.detect(gr,'ScaleFactor',1.1,...
         'MinNeighbors',3, 'MinSize',[10,10]);
faceData{2} = classifierProfile.detect(gr,'ScaleFactor',1.1,...
        'MinNeighbors',3, 'MinSize',[10,10]);    

for f = 1:length(faceData)
   faces = faceData{f};
   for i = 1:length(faces)
       img = cv.rectangle(img, faces{i}, 'Color',[255 255 0], 'Thickness',2);
%        facePoints = faces{i};
%         facePoints(1) = facePoints(1)+960;
       im = cv.rectangle(im, faces{i}, 'Color',[255 255 255], 'Thickness',-2);
   end
end
%  imshow(img);