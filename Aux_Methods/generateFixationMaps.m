function generateFixationMaps(subjects_Path, outputPath)

% radius = 2;
% winSize = ceil(radius * 6);
% gaussian = fspecial('gaussian', [winSize winSize], radius);

load(fullfile(subjects_Path,['subject_fixationsTesteRuim.mat']), 'subjects_all');

frmEstimulo = {1604; 300; 269; 300; 239; 300; 1310};

% randons = randi([1 length(subjects_all)], 1,total);

for est = 1:1 % alterar
    tam = length(subjects_all(1).fixations(est).frames);
    w = subjects_all(1).fixations(est).width;
    h = subjects_all(1).fixations(est).height;
    if(iscell(h))
        h = h{1};
        w = w{1};
    end
    for fr = 1:1604 %alterar
        frames = {};
        mapFr = zeros([h w]);
        for sb = 1 :length(subjects_all)
            %        sb = randons(r);
            mapInd = zeros([h w]);
            framesXY = subjects_all(sb).fixations(est).frames(fr);
            for k = 1 : length(framesXY.coord)
                if( strcmp(framesXY.coord(k),'')==0)
                    xx = framesXY.coord(k,1);
                    yy = framesXY.coord(k,2);
                    if(iscell(framesXY.coord(k,1)))
                        xx = xx{1};
                        yy = yy{1};
                    end
                    x = max(1, min(round(xx), w));
                    y = max(1, min(round(yy), h));
                   mapFr(y, x) = mapFr(y, x)+1;
                   mapInd(y, x) = mapInd(y, x)+1;
                end
            end
           mapInd = imgaussfilt(mapInd,1);
           mapInd(mapInd>0)=1;
           mapInd = imcrop(mapInd,[0 180 1920 720]);
           mapInd = imresize(mapInd, [200,350]);
           frames{sb,2} = mapInd;
           frames{sb,1} = subjects_all(sb).subject;
        end
        filename = strcat(subjects_all(1).fixations(est).stimuli,' frame',num2str(fr));
        %      [~,ind] = sort(mapFr(:));
        %      mapFr(ind(2:end)) = 0;
        %      mapFr(ind(1:10)) = 1;
        %      save(fullfile(outputPath, [filename '.mat']),'mapFr')
        %mapFr = mapFr/total;
%         top = max(mapFr(:));
%         mapFr(mapFr<(0.2*top))=0;
        mapFr = imgaussfilt(mapFr,1);
        mapFr = imcrop(mapFr,[0 180 1920 720]);
        mapFr = imresize(mapFr, [200,350]);
        %imshow(mapFr);
        %m = imadjust(mapFr);
        %imshow(m);
        imwrite(mapFr, fullfile(outputPath, [filename 'C.jpg']));
       save(fullfile(outputPath, [filename '-individualC.mat']),'frames');
    end
end