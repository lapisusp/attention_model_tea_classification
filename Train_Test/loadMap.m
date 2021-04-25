function labels = loadMap(image, path, dims, i, labels)
   imagename = strsplit(image.name, '.mat');
   fix_path = fullfile(path, strcat(imagename(1),'.jpg'));
   fixation = imread(fix_path{1});
   %fixation = imresize(double(fixation), [dims(1),dims(2)]); %%retirar depois
   labels(1:dims(1), 1:dims(2), i) = fixation;
   fprintf('.')