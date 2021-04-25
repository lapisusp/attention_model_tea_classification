function [allfeatures, Y]  = loadFeaturesJessica(indTrain, images, path_features, dims, path_maps, p, q, posPtsPerImg, negPtsPerImg,group)

allfeatures = [];
Y = [];
for i=1:length(images)
    imagename = strsplit(images(i).name, '.avi');
    subname= imagename(2);
    subname = strsplit(subname{1},'.jpg');
    fix_path = fullfile(path_maps, strcat(group, '/',imagename(1), {'.avi '}, subname(1),'.mat'));
    fixations = load(fix_path{1});
    fix_pathCTRL = fullfile(path_maps, strcat('Teste/',imagename(1), {'.avi '}, subname(1),'.mat'));
    fixationsCTRL = load(fix_pathCTRL{1});
    imagename = strsplit(images(i).name, '.jpg');
    feat_path = fullfile(path_features, strcat(imagename(1), '.mat'));
    features = load(feat_path{1});
    for d = 1:length(indTrain)
        fixation = fixations.frames{d};
        fixation = imresize(fixation, [dims(1),dims(2)]); %%retirar depois
        fixation = fixation(:);
        posIndices = find(fixation>0);
        negIndices = find(fixation==0);
        if(length(posIndices)>posPtsPerImg)
            p = randperm(length(posIndices));
            posIndices = posIndices(p(1:posPtsPerImg));
        end
        if(length(negIndices)>negPtsPerImg)
            n = randperm(length(negIndices));
            negIndices = negIndices(n(1:negPtsPerImg));
        end
        X = double(features.FEATURES(vertcat(posIndices, negIndices), [17,34]));
        allfeatures = vertcat(allfeatures, X);
        Y = vertcat(Y,fixation(vertcat(posIndices,negIndices)));
    end
        fprintf('.')
end

fprintf('.')