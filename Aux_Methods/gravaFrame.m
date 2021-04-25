filename = '..\Stimuli\stimuli.txt';
delimiter = '\t';
formatSpec = '%s%f%[^\n\r]';
%% Open the text file.
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);
%% Close the text file.
fclose(fileID);
%% Allocate imported array to column variable names
StimuliName = dataArray{:, 1};
%% Clear temporary variables
clearvars filename delimiter formatSpec fileID dataArray ans;

    outputPath = ['..\Stimuli\frames\Biological Attention\'];
        if ~exist(outputPath, 'dir')
            mkdir(outputPath);
        end
   
    for e = 7:7
        stimuli = StimuliName(e);
        v = VideoReader(['..\Stimuli\' stimuli{1}]);
        i = 0;
        while hasFrame(v)
            videoFrame = readFrame(v);
            i=i+1;
            nome = strcat(stimuli{1},'frame',int2str(i),'.jpg');
            videoFrame = imcrop(videoFrame,[0 180 1920 720]);
            imwrite(videoFrame, fullfile(outputPath,nome));
        end
    end