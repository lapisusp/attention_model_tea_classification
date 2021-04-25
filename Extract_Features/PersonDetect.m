function [im] = PersonDetect(img) 
 
 im = im2bw(img, 1);
 
 img = img(1:720,1:960,:);
% 
 gr = cv.cvtColor(img,'RGB2GRAY');
 gr = cv.equalizeHist(gr);
%  bg = cv.BackgroundSubtractorMOG2();
%  fmask = bg.apply(img);
% 
cascade='haarcascade_fullbody.xml';
cascadealt='haarcascade_lowerbody.xml';
cascadeub='haarcascade_upperbody.xml';
cascade_tree='HS.xml';

xml_fileFace = fullfile(mexopencv.root(),'test',cascade);
classifier = cv.CascadeClassifier(xml_fileFace);
xml_fileFace1 = fullfile(mexopencv.root(),'test',cascadealt);
classifier1 = cv.CascadeClassifier(xml_fileFace1);
xml_fileFace2 = fullfile(mexopencv.root(),'test',cascade_tree);
classifier2 = cv.CascadeClassifier(xml_fileFace2);
xml_file3 = fullfile(mexopencv.root(),'test',cascadeub);
classifier3 = cv.CascadeClassifier(xml_file3);

% Detect faces
personData{1} = classifier.detect(gr,'ScaleFactor',1.3,...
        'MinNeighbors',3, 'MinSize',[10,10]);
personData{2} = classifier1.detect(gr,'ScaleFactor',1.3,...
        'MinNeighbors',3, 'MinSize',[10,10]);
personData{4} = classifier2.detect(gr,'ScaleFactor',1.3,...
        'MinNeighbors',3, 'MinSize',[100,60]);
personData{5} = classifier3.detect(gr,'ScaleFactor',1.3,...
        'MinNeighbors',3, 'MinSize',[100,60]);
    

% hog = cv.HOGDescriptor();
% 
% % detect and localize upright people in images
% hog.SvmDetector = 'DefaultPeopleDetector';
% personData = hog.detectMultiScale(im);

for f = 1:length(personData)
    people = personData{f};
    for i = 1:length(people)
       img = cv.rectangle(img, people{i}, 'Color',[255 255 255], 'Thickness',2);
%         facePoints = people{i};
%         facePoints(1) = facePoints(1)+960;
       im = cv.rectangle(im, people{i}, 'Color',[255 255 255], 'Thickness',-2);
       
    end
end
imshow(im);