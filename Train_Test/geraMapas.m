function geraMapas(imgs, total)

for i =1:length(imgs)
    fprintf('.');
   imagename = strsplit(imgs(i).name, '.avi');
   img2 = imagename(2);
   img2 = strsplit(img2{1}, '.jpg');
   if(~isempty(find(not(cellfun('isempty',strfind(imagename(1), 'Video'))),1)))
       est = 1;
   elseif(~isempty(find(not(cellfun('isempty',strfind(imagename(1), 'Bind'))),1)))
       est = 7;
   elseif(~isempty(find(not(cellfun('isempty',strfind(imagename(1), '01'))),1)))
       est = 2;
   elseif(~isempty(find(not(cellfun('isempty',strfind(imagename(1), '02'))),1)))
       est = 3;
   elseif(~isempty(find(not(cellfun('isempty',strfind(imagename(1), '03'))),1)))
       est = 4;
   elseif(~isempty(find(not(cellfun('isempty',strfind(imagename(1), '07'))),1)))
       est = 5;
   elseif(~isempty(find(not(cellfun('isempty',strfind(imagename(1), '12'))),1)))
       est = 6;
   end
   fr = str2double(strrep(img2(1),'frame',''));
   generateFixationMaps('./Data/TEA/','./Fixation_Maps/TEA/')
   generateFixationMaps('./Data/CTRL/', 10, './Fixation_Maps/CTRL/')
end