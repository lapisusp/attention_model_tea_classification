function [resultados] = execClass(classify,select,numFeatures, pts)
% parâmetros
 P=78;
 N=30;

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

folds = 5;
% randomize image order
imgIndices=shuffle(1:1:numImgs);
c = cvpartition(imgIndices,'KFold',folds);
for f = 1:folds
    f
    trainingIndices = imgIndices(c.training(f));
    testingIndices =  imgIndices(c.test(f));

    % find images needed for training and testing
    trainingImgs = imagefiles(trainingIndices);
    testingImgs = imagefiles(testingIndices);

    numtesting = length(testingImgs)
    % training tea
    [ModelsTEA, featuresTEA] = trainAndTestModel(fixTEA, FEATURES, trainingImgs, pts, pts, 0.5, 5, 0, 1, classify, numFeatures);
    %ROCperformancesTEA = testModel(ModelsTEA, testingImgs, [200, 350], FEATURES, fixTEA, featuresTEA, classify);
    % perform
    %methodsMeanTEA = mean(ROCperformancesTEA)

    % training ctrl
    [ModelsCTRL,featuresCTRL] = trainAndTestModel(fixCTRL, FEATURES, trainingImgs, pts, pts, 0.5, 5, 0, 2, classify, numFeatures);
    %perform
    %ROCperformancesCTRL = testModel(ModelsCTRL, testingImgs, [200, 350], FEATURES, fixCTRL, featuresCTRL, classify);
    %methodsMeanCTRL = mean(ROCperformancesCTRL)
    % saving data
    resultados.ModTea = ModelsTEA;
    resultados.ModCTRL = ModelsCTRL;
    resultados.featuresTEA = featuresTEA;
    resultados.featuresCTRL = featuresCTRL;
    %resultados.ROCperformancesCTRL = methodsMeanCTRL;
    %resultados.ROCperformancesTEA = methodsMeanTEA;
    resultados.teaResults = cell([78,1]); 
    resultados.teaCtrlResults = cell([78,1]); 
    resultados.ctrlTeaResults = cell([30,1]);
    resultados.ctrlResults = cell([30,1]);
    save('testesort2','resultados');

    % testing individuos
    for i=1:numtesting
     resultados = testaPorImagem(testingImgs(i), i, fixTEA, fixCTRL, FEATURES, classify);
    end

    resultadosTea = cell2mat(resultados.teaResults);
    resultadosTeaCtrl = cell2mat(resultados.teaCtrlResults);
    resultadosCtrl = cell2mat(resultados.ctrlResults);
    resultadosCtrlTea = cell2mat(resultados.ctrlTeaResults);
    %limiar=numtesting/2;
    %avaliaty classifier
    RTP={};
    RFP={};
    for i = 1:numtesting
        limiar = i
        vTea = resultadosTea >= resultadosTeaCtrl;
        vCtrl = resultadosCtrlTea >= resultadosCtrl;   
        TP = sum(sum(vTea,2) >= limiar);
        FP = sum(sum(vCtrl,2) >= limiar);
        FN = P - TP;
        TN = N - FP;
        resultados.TP = TP;
        resultados.FP = FP;
        sens = TP/P;
        RFP{i} = FP/N;
        RTP{i} = sens;
        Prec = TP/(TP+FP)
        Espec = TN/(TN+FP)
        Error = (FP+FN)/(P+N)    
    end

    RTP
    RFP
    plot(cell2mat(RFP),cell2mat(RTP), '.b-')
    xlabel('False positive rate')
    ylabel('True positive rate')
    auc = trapz(cell2mat(RFP),cell2mat(RTP))
    title(['Area under ROC curve: ', num2str(auc)])
    saveas(gcf,['auc', num2str(classify), num2str(select), '-', num2str(f), '.png']);
    save(['results', num2str(classify), num2str(select), '-', num2str(f), '.mat'],'RTP','RFP','auc', 'resultados')
end