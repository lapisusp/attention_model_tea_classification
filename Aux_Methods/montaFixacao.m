%function [] = montaFixacao(group, n)
pasta = ['./Data/TEA/grave/'];
listing = dir([pasta '*.xlsx']);

%load(fullfile(pasta,['subject_fixationsCTRL.mat']), 'subjects');

for e = 1: length(listing)
    fixations_Stimuli = struct('stimuli','','width',0,'height',0,'frames',struct('coord',zeros(1,2)));
    filename = fullfile(pasta, listing(e).name);
    %% Import the data
    [num, txt, raw] = xlsread(filename);
    ind = strfind(raw(1,:), 'AOI');
    indC = find(not(cellfun('isempty', ind)));
    raw(:,indC)=[];
    txt(:,indC)=[];
    dados = cell2table(raw(2:end,:));
    txt(1,:) = strrep(strrep(strrep(strrep(strrep(strrep(strrep(txt(1,:),']',''),'[',''),'ó','o'),')',''),'(',''),' ',''),'é','e');
    dados.Properties.VariableNames = txt(1,:);
    
    %% Clear temporary variables
    clearvars data raw txt num R;
    s = 1;
    linha = 1;
    while linha <= height(dados)
        mediaName = dados.MediaName(linha);
        if(~isempty(mediaName{1}) && strcmp(mediaName{1},'imagem separadora.png')==0)
            if(~isnan(mediaName{1}))
                f = 1;
                fixations_Stimuli(s).stimuli = mediaName{1};
                w = dados.MediaWidth(linha);
                h = dados.MediaHeight(linha);
                fixations_Stimuli(s).width = w;
                fixations_Stimuli(s).height = h;
                v = VideoReader(['.\Stimuli\vídeos\' mediaName{1}]);
                rate = 1000/v.FrameRate;
                recordStart = dados.RecordingTimestamp(linha);
                fixations = [];
                while(linha <= height(dados) && strcmp(mediaName, dados.MediaName(linha))==1)
                    new_line = [dados.GazePointXMCSpx(linha) dados.GazePointYMCSpx(linha)];
                    if(dados.RecordingTimestamp(linha)<=(recordStart+rate))
                        fixations = [fixations; new_line];
                        linha = linha + 1;
                    else
                        fixations_Stimuli(s).frames(f).coord = fixations;
                        fixations = [];
                        recordStart = recordStart+rate;
                        f = f+1;
                    end
                end
                s = s +1
            end
        end
        linha = linha +1;
    end
    subjects(e).fixations = fixations_Stimuli;
    subjects(e).subject = dados.ParticipantName(linha-1);
end
save(fullfile(pasta,['subject_fixations_grave.mat']), 'subjects');