function [] = extractAllFeatures(inputPath, outputPath)
% inputPath = '..\Stimuli\frames\Biological Attention\';
% outputPath = '..\Stimuli_Features\';

% install mexopencv: https://github.com/kyamagu/mexopencv
% make sure that the version installed match the version of OpenCV in your
% computer
% with you want Itti Features, make sure use matlab 2011 or older
% if the installation didn't work run the commands bellow updating the
% paths
addpath('/hdd/mexopencv');
addpath('/hdd/mexopencv/opencv_contrib');
mexopencv.make('opencv_path','hdd/opencv_build/opencv/build/', 'opencv_contrib',true)
mexopencv.make();

if ~exist(outputPath, 'dir')
    mkdir(outputPath);
end
listing = dir([inputPath '*.jpg']);
prev = '';

%%%%%%%%%%%%%%%%%%%%%%
% IMPORTANTE!! variaveis relacionadas ao estímulo de movimento biológico utilizado
% caso use outro estímulo alterar essas variáveis
indFirstFrame=11;
indLastFrame=1590;
LeftX = {11,185,721,899,1433};
LeftY = {174,354,888,1065,1590};
Left = [LeftX; LeftY];
RightX = {365,543,1076,1254};
RightY = {532,710,1243,1422};
Right = [RightX; RightY];
%%%%%%%%%%%%%%%%%%%%%%%%

FEATURES = zeros(70000,32);

%% Primeira etapa: gerar características de saliencia por frame
for i = indFirstFrame:indLastFrame
    fprintf(['INDEX FRAME', i])
    nome = ['Video 2 - Teste2.aviframe', num2str(i), '.jpg'];
    if ~exist([inputPath nome], 'file')
        fprintf(nome)
        continue;
    else
        saliency(FEATURES, inputPath,outputPath, nome,prev);
        prev=nome;
    end
end

%% Segunda etapa: gera features que variam de acordo com a lateralidade do frame

% %Imagens com movimentoBiologico a Left
for ind=1:length(Left)
    for x=Left{1,ind}:Left{2,ind}
        fprintf(['',num2str(x)])
        nome = ['Video 2 - Teste2.aviframe', num2str(x)];
        featName = strcat(outputPath, nome, '.mat');
        FEATURES = load(featName).FEATURES;
        
        movBiologico = horzcat(ones(200,175), zeros(200,175));
        FEATURES(:,30) = movBiologico(:);
        movGeometrico = horzcat(zeros(200,175), ones(200,175));
        FEATURES(:,31) = movGeometrico(:);
        save(featName, 'FEATURES');
    end
end

%Imagens com movimentoBiologico a Right
for ind=1:length(Right)
    for x=Right{1,ind}:Right{2,ind}
        nome = ['Video 2 - Teste2.aviframe', num2str(x)];
        featName = strcat(outputPath, nome, '.mat');
        FEATURES = load(featName).FEATURES;
        
        movBiologico = horzcat(zeros(200,175), ones(200,175));
        FEATURES(:,30) = movBiologico(:);
        movGeometrico = horzcat(ones(200,175), zeros(200,175));
        FEATURES(:,31) = movGeometrico(:);
        save(featName, 'FEATURES');
    end
end

%% Terceira etapa: Calcula features de centro das cenas e da tela
for ind=indFirstFrame:indLastFrame
    nome = ['Video 2 - Teste2.aviframe', num2str(ind)];
    imgName = strcat(inputPath, nome, '.jpg');
    if ~exist(imgName, 'file')
        continue;
    else
        img = imread(imgName);
        featName = strcat(outputPath, nome, '.mat');
        FEATURES = load(featName).FEATURES;

        imgLeft = img(1:720,1:960,:);
        centroEsquerdo = findDistToCenterFeatures(imgLeft, [200,175]);
        imgRight = img(1:720,961:1920,:);
        centroDireito = findDistToCenterFeatures(imgRight, [200,175]);
        centroLados = horzcat(reshape(centroEsquerdo,[200,175]), reshape(centroDireito,[200,175]));
        centro = findDistToCenterFeatures(img, [200,350]);
        FEATURES(:,28) = centro(:);
        FEATURES(:,32) = centroLados(:);
        save(featName, 'FEATURES');
    end
end

%% Quarta e ultima etapa: agrupar os frames de acordo com o movimento
max_mov=0;
min_mov=0;

for i = indFirstFrame:indLastFrame
    nome = ['Video 2 - Teste2.aviframe', num2str(i)];
    featName = strcat(outputPath, nome, '.mat');
    if ~exist(featName, 'file')
        continue;
    else
        FEATURES = load(featName).FEATURES;
        movimento = FEATURES(:,29);

        maxM = max(movimento);
        minM = min(movimento);

        if maxM>max_mov
            max_mov=maxM;
        end

        if minM<min_mov
            min_mov=minM;
        end
    end
end

fprintf(['max', num2str(max_mov), '\n']);
fprintf(['min', num2str(min_mov), '\n']);   

features = zeros(70000,32);
mov = 0;
%lim = 0.33; % GERA OS FRAMES DE 198 nas features antigas
%lim = 0.25; % GERA OS FRAMES DE 25.. nas features antigas
lim = 0.34;
k=1;
list = cell(800);
if ~exist([outputPath, 'combined_features/'], 'dir')
    mkdir(fullfile(outputPath, 'combined_features/'));
end
for i = indFirstFrame+1:indLastFrame
    nome = ['Video 2 - Teste2.aviframe', num2str(i)];
    featName = strcat(outputPath, nome, '.mat');
    
    % se a feature nao existe eh porque chegou ao final daquela cena,
    % portanto o agrupamento eh realizado
    if ~exist(featName, 'file')
        if(~isempty(list{k}))
            fprintf(['terminou cena ',num2str(i)])
            features = features/length(list{k});
            nome = ['Video 2 - Teste2.aviframe', num2str(k)];
            save(fullfile(outputPath,['combined_features/' nome '.mat']),'features');
            save(fullfile(outputPath,['combined_features/frames.mat']),'list')
            mov = 0;
            features = zeros(70000,32);
            k = k + 1;
        end
        continue;
    end
    
    FEATURES = load(featName).FEATURES;
    movimento = FEATURES(:,29);
    movimento = (movimento - min_mov)/(max_mov -min_mov);
    mov = mov + movimento;
    if(sum(mov)/70000 < lim && i~=indLastFrame)
        features = features + FEATURES;
        list{k} = [list{k} i];
    else
        fprintf(['movimento parou ',num2str(i)])
        features = features/length(list{k});
        nome = ['Video 2 - Teste2.aviframe', num2str(k)];
        save(fullfile(outputPath,['combined_features/' nome '.mat']),'features');
        save(fullfile(outputPath,'combined_features/frames.mat'),'list')
        mov = movimento;
        features = FEATURES;
        k = k + 1;
        list{k} = [list{k} i];
    end
end
