%% Select Feature

% Inputs
IMGS = '../Stimuli/frames/'; %Change this to the path on your local computer
MAPS = '../Fixation_Maps/TEA/'; %Change this to the path on your local computer
FEATURES = '../Stimuli_Features'
imagefiles = dir(fullfile(IMGS, '*.jpg'));
numImgs = length(imagefiles);
numtraining=150; % a good default is 100, make smaller to test
numTrials=10; % a good default is 5, make smaller to test
posPtsPerImg=150; % number of positive samples taken per image to do the learning
negPtsPerImg=50; % numbe of negative samples taken
p=60; % pos samples are taken from the top p percent salient pixels of the fixation map
q=40; % neg samples are taken from below the top q percent
c=1; % parameter for the liblinear machine learning 
w1=1; % parameter for the liblinear machine learning
M = 200; % size of the downsized images we work with
N = 200;
showResults = 1;

%for n=1:numTrials
    
    % randomize image order
    imgIndices=shuffle([1:1:numImgs]);
    trainingIndices = imgIndices([1:numtraining]);
   
    % find images needed for training and testing
    trainingImgs = imagefiles([trainingIndices]);
    
    % find features of training and testing images
    fprintf('Finding training features...'); tic
    featuresTraining = collectFeatures(trainingImgs, FEATURES, [M, N]); % this should be size [M*N*numImages, numFeatures]
    fprintf([num2str(toc), ' seconds \n']);
        
    % find fixation map labels of training images (ground truth saliency)
    fprintf('loading fixation maps...'); tic
    labels = loadMap(trainingImgs, MAPS, [M, N]); % should be size [M, N, 1, numImgs]
    labels = reshape(labels, [M*N*numtraining, 1]); % should be size [M*N*numImages, 1]
    [posIndices, negIndices] = selectSamplesPerImg(labels, p, q, numtraining, [M, N], posPtsPerImg, negPtsPerImg);
    X = double(featuresTraining([posIndices, negIndices], :)); %trainingFeatures
    Y = labels([posIndices,negIndices]);
    
    labels2 = loadMap(trainingImgs, '../Fixation_Maps/Teste/', [M, N]);
    labels2 = reshape(labels2, [M*N*numtraining, 1]); % should be size [M*N*numImages, 1]
    [posIndices2, negIndices2] = selectSamplesPerImg(labels2, p, q, numtraining, [M, N], posPtsPerImg, negPtsPerImg);
    X2 = double(featuresTraining([posIndices2, negIndices2], :)); %trainingFeatures
    Y2 = labels2([posIndices2,negIndices2]);  
    
    fprintf([num2str(toc), ' seconds \n']);
    
    fprintf('selecting features...'); tic
    
    [ranked,weights] = relieff(X,Y,30, 'method', 'regression');
    bar(weights(ranked));
    %mdl = fsrnca(X,Y);
    
    [rankedC,weightsC] = relieff(X2,Y2,30);
    bar(weightsC(rankedC));
    %mdlC = fsrnca(X2,Y2);
    
    xlabel('Predictor rank');
    ylabel('Predictor importance weight');
    
        
  %      Y = double([ones(1, length(posIndices)), zeros(1, length(negIndices))])'; %trainingLabels
        fprintf([num2str(toc), ' seconds \n']);
    
    %%%%%%%%%%%%
    % Training %
    %%%%%%%%%%%%
    
%       scatter3(X2(:,rankedC(1)),X2(:,rankedC(2)),Y2,'filled')
%       hold on
%       scatter3(X(:,ranked(1)),X(:,ranked(2)),Y,'filled')
%       hold off
%    fprintf([num2str(toc), ' seconds \n']);
%            
     
     %end

f = [16, 33, 34, 30, 2, 14, 32, 15, 4, 17];     
     
scatter(X(:,17),Y)
hold on
scatter(X2(:,17),Y2)






