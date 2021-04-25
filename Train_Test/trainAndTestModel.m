function [model, features] = trainAndTestModel(pathClass, FEATURES, trainingImgs, posPtsPerImg, negPtsPerImg, p, q, select, group, classify,numFeatures)

M = 200; N = 350;
dims = [M, N];
numtraining = length(trainingImgs);

% initialize the return objects
fprintf('Finding training features...'); tic
featuresTraining = collectFeatures(trainingImgs, FEATURES, [M, N]); 
fprintf([num2str(toc), ' seconds \n']);

% find fixation map labels of training images (ground truth saliency)
fprintf('loading fixation maps...'); tic
labels = zeros(dims(1), dims(2), length(trainingImgs));
for i=1:length(trainingImgs)
    labels = loadMap(trainingImgs(i), pathClass, dims, i, labels); 
end
labels = reshape(labels, [M*N*numtraining, 1]); 
fprintf([num2str(toc), 'seconds \n']);

% Select pixels
fprintf('Finding random pos and neg samples per image...');
[posIndices, negIndices] = selectSamplesPerImg(labels, p, q, numtraining, [M, N], posPtsPerImg, negPtsPerImg);

X = double(featuresTraining([posIndices, negIndices], :)); %trainingFeatures
Y = double([ones(1, length(posIndices)), zeros(1, length(negIndices))])'; %trainingLabels

% Select Features
fprintf('Selecting features...');
switch logical(true)
case select==0, 
        case group==1,
            fprintf('Features TEA');
            features = [6, 10, 13, 14, 17, 18, 20, 24, 25, 26, 28, 29, 30, 31, 32]
        case group==2,
            fprintf('Features CTRL');
            features = [6, 7, 9, 10, 13, 14, 17, 18, 20, 24, 25, 26, 28, 29, 32]
case select==1,
    [r,w] = relieff(X,Y,60);
    numFeatures = length(w(w>mean(w)))
    features = r(1:numFeatures)
    X = X(:,features);
case select==2, 
    features = GA_feature_selector(numFeatures,X,Y)
    X = X(:,features);
    otherwise
        features = linspace(1,length(X(1,:)),length(X(1,:)));
end;

X = X(:,features);

%%%%%%%%%%%%
% Training %
%%%%%%%%%%%
fprintf('Training the model...');
switch logical(true)
case classify==1, 
      net = fitnet(10);
      model= trainbr(net,X',Y');
    
case classify==2,
    svm_params = '-s 2 -c 0.1 -B -1';
    model = train(Y, sparse(X), svm_params); 
    otherwise
    model = glmfit(X,Y,'binomial','link','logit');   
end;