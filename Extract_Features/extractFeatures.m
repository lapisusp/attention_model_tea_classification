function [] = extractFeatures()

addpath(genpath('.'));
% cd('C:\mexopencv-master')
% addpath('C:\mexopencv-master')
% addpath('C:\mexopencv-master\opencv_contrib')
% mexopencv.make('opencv_path','C:\opencv\opencv\build\', 'opencv_contrib',true)
% %mexopencv.make();
inputPath = '..\Stimuli\frames\Biological Attention\';
outputPath = '..\Stimuli_Features\';
if ~exist(outputPath, 'dir')
    mkdir(outputPath);
end
listing = dir([inputPath '*.jpg']);
prev = '';

%Esquerda = [11:174;185:354;721:888;899:1065;1433:1594];
% Direita =[365:532;543:710;1076:1243;1254:1422];

features = zeros(70000,32);
mov = 0;
lim = 0.33;
k=1
list = cell(800);
for i = 11:1593
        nome = ['Video 2 - Teste2.aviframe', num2str(i)];
        featName = strcat(outputPath, nome, '.mat');
        if ~exist(featName, 'file')
            if(length(list{k})~=0)
                features = features/length(list{k});
                nome = ['Video 2 - Teste2.aviframe', num2str(k)];
                save(fullfile(outputPath,['combined_features\' nome '.mat']),'features');
                save(fullfile(outputPath,['combined_features\frames.mat']),'list')
                mov = 0;
                features = zeros(70000,32);
                k = k + 1
            end
            continue;
        end
        FEATURES = load(featName);
        movimento = FEATURES(:,29);
        imshow(reshape(movimento, [200 350]))
        mov = mov + movimento;
        if(sum(mov)/70000 < lim & i~=1593)
            features = features + FEATURES;
            list{k} = [list{k} i];
        else
            features = features/length(list{k});
            nome = ['Video 2 - Teste2.aviframe', num2str(k)];
            save(fullfile(outputPath,['combined_features\' nome '.mat']),'features');
            save(fullfile(outputPath,['combined_features\frames.mat']),'list')
            mov = movimento;
            features = FEATURES;
            k = k + 1
            list{k} = [list{k} i];
        end
%        imgName = strcat(inputPath, nome, '.jpg');
%        img = imread(imgName);
        
%         movBiologico = horzcat(zeros(200,175), ones(200,175));
%         FEATURES(:,30) = movBiologico(:);
%         movGeometrico = horzcat(ones(200,175), zeros(200,175));
%         FEATURES(:,31) = movGeometrico(:);
%         imgEsquerda = img(1:720,1:960,:);
%         centroEsquerdo = findDistToCenterFeatures(imgEsquerda, [200,175]);
%         imgDireita = img(1:720,961:1920,:);
%         centroDireito = findDistToCenterFeatures(imgDireita, [200,175]);
%         centroLados = horzcat(reshape(centroEsquerdo,[200,175]), reshape(centroDireito,[200,175]));
%         centro = findDistToCenterFeatures(img, [200,350]);
%         FEATURES(:,28) = centro(:);
%         FEATURES(:,32) = centroLados(:);
%         save(featName, 'FEATURES');
       % saliency(inputPath,outputPath, nome,prev);
        prev = nome;
%    end
end