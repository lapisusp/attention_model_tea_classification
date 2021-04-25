function features = findObjectFeatures(img, dims)
%
% features = findObjectFeatures(img, dims)
% Find all the faces, cars and people in the images

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

[w h, c] = size(img);
% Cars=zeros(w, h);
People=zeros(w, h);
Faces=zeros(w,h);

%-----------------%
% Find People      
%----------------%
fprintf('Finding people...'); tic;
% 
%   [peopleData] = PersonDetect(img);
% % if length(peopleData) > 0 & peopleData{1} ~= -1
% %     for j=1:size(peopleData, 1)
% %         person = peopleData(j, :);
% %         People(person{j}(2):person{j}(2)+person{j}(4), person{j}(1):person{j}(1)+person{j}(3)) = 1;
% %     end
% % end
%  People = imresize(peopleData, dims);
%  features(:, 1) = People(:);
% imwrite(People, 'people.jpg');
% imshow(People);
% fprintf([num2str(toc), ' seconds \n']);
 features(:, 1) =  linspace(0,0,dims(1)*dims(2));

%-----------------%
% Find Faces      
%-----------------%
% fprintf('Finding faces...'); tic;
% 
% Run face detector
%  [Faces] = FaceDetect(img); 
% 
%  Faces = imresize(Faces, dims);
%  features(:, 2) = Faces(:);
% imwrite(Faces, 'faces.jpg');
%imshow(Faces);
features(:, 2) =  linspace(0,0,dims(1)*dims(2));
if nargout==0
subplot(121); imshow(reshape(features(:, 1), dims)); title('people channel');
subplot(122); imshow(reshape(features(:, 2), dims)); title('face channel');
end;
