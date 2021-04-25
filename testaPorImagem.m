function resultados = testaPorImagem(imagename, i, fixTEA, fixCTRL, FEATURES, classify)
load 'testesort2'

img = strsplit(imagename.name, '.mat');
%%Testa TEA
fixationsTEA = fullfile(fixTEA, strcat(img(1),'-individual.mat'));
fixationsTEA = load(fixationsTEA{1});

for f =1:length(fixationsTEA.videosIndividuos)
    fixationPts = fixationsTEA.videosIndividuos{f,1};
    [t2TEA, t2CTRL] = testaIndividuos(resultados.ModTea, resultados.ModCTRL, imagename, [200, 350], FEATURES, resultados.featuresTEA, resultados.featuresCTRL, classify, fixationPts);
    resultados.teaResults{f} = [resultados.teaResults{f}, t2TEA];
    resultados.teaCtrlResults{f} = [resultados.teaCtrlResults{f}, t2CTRL];
end

%%Testa CTRLu
fixationsCTRL = fullfile(fixCTRL, strcat(img(1), '-individual.mat'));
fixationsCTRL = load(fixationsCTRL{1});
for f =1:length(fixationsCTRL.videosIndividuos)
    fixationPts = fixationsCTRL.videosIndividuos{f,1};
    [t2TEA, t2CTRL] = testaIndividuos(resultados.ModTea, resultados.ModCTRL, imagename, [200, 350], FEATURES, resultados.featuresTEA, resultados.featuresCTRL, classify, fixationPts);
    resultados.ctrlTeaResults{f} = [resultados.ctrlTeaResults{f}, t2TEA];
    resultados.ctrlResults{f} = [resultados.ctrlResults{f}, t2CTRL];
end

save('testesort2','resultados');



