function [resultsTEA, resultsCTRL] = testaIndividuos(modelTEA, modelCTRL, img, dims, featuresPath, columnsTEA, columnsCTRL, classify, fixationPts)

features = collectFeatures(img, featuresPath, dims);
Xtea = features(:,columnsTEA);
Xctrl = features(:,columnsCTRL);

posPtsPerImg = 75;
negPtsPerImg = 75;

resultsTEA = 75;
resultsCTRL = 75;

switch logical(true)
    case classify==1,
        predictionsTEA = modelTEA(Xtea');
        predictionsCTRL = modelCTRL(Xctrl');
    case classify==2,
        predictionsTEA = glmval(modelTEA,Xtea,'logit');
        predictionsCTRL = glmval(modelCTRL,Xctrl,'logit');
    otherwise
        predictionsTEA = modelTEA.w*Xtea';
        predictionsCTRL = modelCTRL.w*Xctrl';
end;


Stea = predictionsTEA(:);
Stea = (Stea-min(Stea(:)))/(max(Stea(:))-min(Stea(:)));
Stea = reshape(Stea, dims);
% Stea(Stea>=0.7) = 1;
% Stea(Stea<1) = 0;

Sctrl = predictionsCTRL(:);
Sctrl = (Sctrl-min(Sctrl(:)))/(max(Sctrl(:))-min(Sctrl(:)));
Sctrl = reshape(Sctrl, dims);
% Sctrl(Sctrl>=0.7) = 1;
% Sctrl(Sctrl<1) = 0;

fixationPts(fixationPts>0)=1;
imageLabels = fixationPts;
% rearrange as a square and eliminate the borders
border = 5; %num of pixels along the border that one should not choose from.
imageLabels=reshape(imageLabels, dims);
imageLabels(1:border, :) = -1;
imageLabels(end-border+1:end, :) = -1;
imageLabels(:, 1:border) = -1;
imageLabels(:, end-border+1:end) = -1;

imageLabels=reshape(imageLabels, [dims(1)*dims(2), 1]);
tam = length(find(imageLabels>0));

if(tam>0)
    [~, IX] = sort(imageLabels, 'descend');
    % Find the positive examples in the top p percent
    i = ceil(tam*rand([posPtsPerImg, 1]));
    posIndices = IX(i);
    
    % Find the negative examples from below top q percent
    % in practice, we find indices between [a, b]
    a = tam+10; % top q percent
    b = length(imageLabels)-length(find(imageLabels==-1)); % index before border
    j = ceil(a + (b-a).*rand(negPtsPerImg,1));
    negIndices = IX(j);
    
    
      l = 0.75;
        resultsTEA = length(find(Stea(posIndices)>l))+length(find(Stea(negIndices)<=l));
        resultsCTRL =  length(find(Sctrl(posIndices)>l))+length(find(Sctrl(negIndices)<=l));
        
        Stea(Stea<l)=0;
        Sctrl(Sctrl<l)=0;
        
%         subplot(121); imshow(Stea, []); title('SaliencyMap with fixations to be predicted');
%         hold on;
%         [y, x] = find(fixationPts);
%         plot(x, y, '.r');
%         subplot(122); imshow(Sctrl, []);   title(['CTRL: '])
end