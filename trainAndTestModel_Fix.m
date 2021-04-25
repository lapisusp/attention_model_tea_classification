function [model, features] = trainAndTestModel_Fix(pathClassTea, pathClassCtrl, FEATURES, trainingImgs, posPtsPerImg, negPtsPerImg, p, q, select, classify,numFeatures)

M = 200; N = 350;
dims = [M, N];
numtraining = length(trainingImgs);

% initialize the return objects
fprintf('Finding training features...'); tic
featuresTraining = collectFeatures(trainingImgs, FEATURES, [M, N]); 
fprintf([num2str(toc), ' seconds \n']);

% find fixation map labels of training images (ground truth saliency)
fprintf('loading fixation maps...'); tic
labelsTea = zeros(dims(1), dims(2), length(trainingImgs));
for i=1:length(trainingImgs)
    labelsTea = loadMap(trainingImgs(i), pathClassTea, dims, i, labelsTea); 
end
labelsTea = reshape(labelsTea, [M*N*numtraining, 1]); 

labelsCtrl = zeros(dims(1), dims(2), length(trainingImgs));
for i=1:length(trainingImgs)
    labelsCtrl = loadMap(trainingImgs(i), pathClassCtrl, dims, i, labelsCtrl); 
end
labelsCtrl = reshape(labelsCtrl, [M*N*numtraining, 1]); 

fprintf([num2str(toc), 'seconds \n']);

% Select pixels
fprintf('Finding random pos and neg samples per image...');
tam = (posPtsPerImg + negPtsPerImg)*numtraining;

[posIndices, negIndices] = selectSamplesPerImg(labelsTea, p, q, numtraining, [M, N], posPtsPerImg, negPtsPerImg);
X = double(featuresTraining([posIndices, negIndices], :)'*diag(labelsTea([posIndices, negIndices])))'; %trainingFeatures

[posIndices, negIndices] = selectSamplesPerImg(labelsCtrl, p, q, numtraining, [M, N], posPtsPerImg, negPtsPerImg);
X = [X; double(featuresTraining([posIndices, negIndices], :)'*diag(labelsCtrl([posIndices, negIndices])))']; %trainingFeatures

Y = double([ones(1, tam), zeros(1, tam)])'; %trainingLabels

% Select Features
fprintf('Selecting features...');
switch logical(true)
case select==1, 
    [r,w] = relieff(X,Y,60);
    numFeatures = 3
    features = r(1:numFeatures)
    X = X(:,features);
case select==2, 
    features = GA_feature_selector(numFeatures,X,Y);
    X = X(:,features);
    otherwise
        features = linspace(1,length(X(1,:)),length(X(1,:)));
end;

%%%%%%%%%%%%
% Training %
%%%%%%%%%%%
fprintf('Training the model...');
switch logical(true)
case classify==1, 
%     net = fitnet(2);
%     model{1} = train(net,X',Y');
%     net = fitnet(10);
%     model{2} = train(net,X',Y');
%     net = fitnet(20);
%     model{3} = train(net,X',Y');
%     net = fitnet(50);
%     model{4} = train(net,X',Y');
    
%     net = fitnet(2);
%     model{5} = trainbr(net,X',Y');
    net = fitnet(10);
    model= trainbr(net,X',Y');
%     net = fitnet(20);
%     model{7} = trainbr(net,X',Y');
%     net = fitnet(50);
%     model{8} = trainbr(net,X',Y');
    
%     net = fitnet(2);
%     model{9} = trainscg(net,X',Y');
%     net = fitnet(10);
%     model{10} = trainscg(net,X',Y');
%     net = fitnet(20);
%     model{11} = trainscg(net,X',Y');
%     net = fitnet(50);
%     model{12} = trainscg(net,X',Y');
    
case classify==2, 
    model = glmfit(X,Y,'binomial','link','logit');
    otherwise
     svm_params = '-s 2 -c 0.1 -B -1';
     model = train(Y, sparse(X), svm_params);   
end;