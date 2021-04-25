function ROCperformancesM = testModel(model, testingImgs, dims, FEATURES, pathClass1, columns,classify)

ROCperformancesM = zeros(length(testingImgs),9);
% Test model on one image at a time
for i=1:length(testingImgs)
    
    % get the features for this image
    features = collectFeatures(testingImgs(i), FEATURES, dims);
    X = features(:,columns);
    fixationPts = loadMap(testingImgs(i), pathClass1, dims, 1, zeros(dims(1), dims(2)));
   % X = double(X'*diag(fixationPts))'; %trainingFeatures
    switch logical(true)
        case classify==1,
            predictions = model(X');
        case classify==2,
            predictions = glmval(model,X,'logit');
        otherwise
            predictions = model.w*X';
    end;
    
    
    predictionsC = reshape(predictions, dims);
    ROCperformancesM(i) = AUC_Judd(predictionsC,fixationPts,1,1);
end
