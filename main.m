% function [] = main()

addpath(genpath('.'));

% initialize liblinear
addpath('Train_Test/lib/liblinear');
cd Train_Test/lib/liblinear
make
cd ../../..

%% Extrai características

% estimulos = '..\Stimuli\stimuli.txt';
% delimiter = '\t';
% formatSpec = '%s%f%[^\n\r]';
% fileID = fopen(filename,'r');
% dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);
% fclose(fileID);
% StimuliName = dataArray{:, 1};
% nFrame = dataArray{:, 2};
% clearvars filename delimiter formatSpec fileID dataArray ans;
%
% mexOpencvPath = 'C:\Users\Jéssica\mexopencv-master';
% extractFeatures(StimuliName, nFrame, mexOpencvPath)

%% GenerateFixationMaps
% n = 5; % number of subjects to generate fixation maps
% montaFixacao('TEA',n);
%montaFixacao('Teste', n);

%% Training and Teste Models
numtraining=150; % a good default is 100, make smaller to test
numtesting=50; % a good default is 500, make smaller to test
numTrials=3; % a good default is 5, make smaller to test
p=0.5; % pos samples are taken from the top p percent salient pixels of the fixation map
q=5; % neg samples are taken from below the top q percent
fixTEA = './Fixation_Maps/TEA/';
fixCTRL = './Fixation_Maps/CTRL/';
FEATURES = './Stimuli_Features/';
numMethod = 4;


IMGS = './Stimuli/frames/Biological Attention/';
imagefiles = dir(fullfile(IMGS, '*.jpg'));
numImgs = length(imagefiles);
trials = 1;

%% randomize image order
imgIndices=shuffle(1:1:numImgs);
trainingIndices = imgIndices(1:numtraining);
testingIndices =  imgIndices(numtraining+1:numtraining+numtesting);

%% find images needed for training and testing
trainingImgs = imagefiles(trainingIndices);
testingImgs = imagefiles(testingIndices);

[ModelsTEA, featuresTEA] = trainAndTestModel(fixTEA, FEATURES, trainingImgs, testingImgs, 15, 15, p, q, 'tea','nn','relief');
[ModelsCTRL,featuresCTRL] = trainAndTestModel(fixCTRL, FEATURES, trainingImgs, testingImgs, 15, 15, p, q, 'ctrl','nn','relief');

resultados(trials).ModTea = ModelsTEA;
resultados(trials).ModCTRL = ModelsCTRL;
resultados(trials).featuresTEA = featuresTEA;
resultados(trials).featuresCTRL = featuresCTRL;

save('resultados2.mat','resultados');

[t2TEA, t2CTRL] = testaIndividuos('nn', resultados(trials).ModTea, fixTEA, resultados(trials).ModCTRL, fixCTRL, testingImgs, [200, 350], FEATURES, featuresTEA,featuresCTRL);
tTea = sum(t2TEA,2);
tTea = tTea>23;
tCTRL = sum(t2CTRL,2);
tCTRL = tCTRL>23;
TP = sum(tTea);
FN= length(tTea) - TP;
FP = sum(tCTRL);
TN = length(tCTRL) - FP;
resultados(trials).TP = TP;
resultados(trials).TN = TN;
resultados(trials).FP = FP;
resultados(trials).FN = FN;

save('resultados2.mat','resultados');
