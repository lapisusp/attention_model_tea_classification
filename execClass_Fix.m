function [resultados] = execClass(classify,select,numtraining,numtesting,numFeatures)
% parâmetros

%%258 imagens

addpath(genpath('.'));
% svm lib
addpath('Train_Test/lib/liblinear');
cd Train_Test/lib/liblinear
make
cd ../../..

% sets iniciais
resultados = struct();
fixTEA = './Fixation_Maps/TEA/mapasConsolidados_2/';
fixCTRL = './Fixation_Maps/CTRL/mapasConsolidados_2/';
FEATURES = './Stimuli_Features/combined_features_2/';
IMGS = './Stimuli_Features/combined_features_2/';
imagefiles = dir(fullfile(IMGS, '*.mat'));
numImgs = length(imagefiles);

% randomize image order
imgIndices=shuffle(1:1:numImgs);
trainingIndices = imgIndices(1:numtraining);
testingIndices =  imgIndices(numtraining+1:numtraining+numtesting);

% find images needed for training and testing
trainingImgs = imagefiles(trainingIndices);
testingImgs = imagefiles(testingIndices);
% training tea
[ModelsTEA, featuresTEA] = trainAndTestModel_Fix(fixTEA, fixCTRL, FEATURES, trainingImgs, 30, 30, 0.5, 5, select, classify, numFeatures);
ROCperformancesTEA = testModel(ModelsTEA, testingImgs, [200, 350], FEATURES, fixTEA, featuresTEA, classify);
% perform
methodsMeanTEA = mean(ROCperformancesTEA)

% saving data
resultados.ModTea = ModelsTEA;
resultados.ModCTRL = ModelsCTRL;
resultados.featuresTEA = featuresTEA;
resultados.featuresCTRL = featuresCTRL;
resultados.ROCperformancesCTRL = methodsMeanCTRL;
resultados.ROCperformancesTEA = methodsMeanTEA;
resultados.teaResults = cell([78,1]); 
resultados.teaCtrlResults = cell([78,1]); 
resultados.ctrlTeaResults = cell([30,1]);
resultados.ctrlResults = cell([30,1]);
save('testesort','resultados');

numtesting = 58;
% testing individuos
for i=1:numtesting
 resultados = testaPorImagem(testingImgs(i), i, fixTEA, fixCTRL, FEATURES, classify);
end

resultadosTea = cell2mat(resultados.teaResults);
resultadosTeaCtrl = cell2mat(resultados.teaCtrlResults);
resultadosCtrl = cell2mat(resultados.ctrlResults);
resultadosCtrlTea = cell2mat(resultados.ctrlTeaResults);
limiar=numtesting/2;
%avaliaty classifier
for i = 1:11
    resultadosTeal1 = resultadosTea(:,linspace(i,(numtesting*11)-11+i,numtesting))
    resultadosTeaCtrll1 = resultadosTeaCtrl(:,linspace(i,(numtesting*11)-11+i,numtesting))
    resultadosCtrll1 = resultadosCtrl(:,linspace(i,(numtesting*11)-11+i,numtesting))
    resultadosCtrlTeal1 = resultadosCtrlTea(:,linspace(i,(numtesting*11)-11+i,numtesting))
    vTea = resultadosTeal1 > resultadosTeaCtrll1
    vCtrl = resultadosCtrlTeal1 > resultadosCtrll1   
    TP = sum(sum(vTea,2) <= limiar)
    FP = sum(sum(vCtrl,2) <= limiar)
    FN = P - TP
    TN = N - FP
    resultados.TP = TP
    resultados.FP = FP
    RTP{i} = TP/P
    RFP{i} = TN/N
end
plot(cell2mat(RTP),cell2mat(RFP))
print([num2str(classify),'-', num2str(select),'-','curve'],'-dpng')
save('Teste4-resultados.mat','resultados');