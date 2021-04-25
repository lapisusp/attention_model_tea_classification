inputPath = './Stimuli/frames/Biological Attention/';
outputPath = './Stimuli_Features/';
indFirstFrame=11;
indLastFrame=1590;
max_mov=0;
min_mov=0;

for i = indFirstFrame:indLastFrame
    nome = ['Video 2 - Teste2.aviframe', num2str(i)];
    featName = strcat(outputPath, nome, '.mat');
    if ~exist(featName, 'file')
        fprintf(nome)
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

fprintf(['max', num2str(max_mov)]);
fprintf(['min', num2str(min_mov)]);   