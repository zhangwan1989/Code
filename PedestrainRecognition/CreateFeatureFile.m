posPath = 'E:\_learn\_research\Samples\DB47_18_36\pos_18_36\';
negPath = 'E:\_learn\_research\Samples\DB47_18_36\neg_18_36\';
posSize = 1000
negSize = 1000
winSize = [18,32];
fid = fopen('data.txt', 'w');
mydir = cd;
newpath = [mydir,'\multiscaleHaar'];
path(path,newpath);

posfh = dir([posPath,'*.jpg'])
for i = 1:posSize
    i
    img = imread([posPath,posfh(i).name]); 
    tic;
    HaarFeature = MultiScaleHaarCaculate(winSize, img, 'lbp','true');
    toc;
    %HOGFeature = hog(single(img),8,9);
    dims = size(HaarFeature);
    fprintf(fid, '1');
    for j = 1:dims(2)
        fprintf(fid, ',%f', HaarFeature(j));
    end
    fprintf(fid, '\n');
end


negfh = dir([negPath,'*.jpg']);
for i = 1:negSize
    i+posSize
    img = imread([negPath,negfh(i).name]); 
    tic;
    HaarFeature = MultiScaleHaarCaculate(winSize, img,'lbp', 'true');
    toc;
    dims = size(HaarFeature);
    fprintf(fid, '0');
    for j = 1:dims(2)
        fprintf(fid, ',%f', HaarFeature(j));
    end
    fprintf(fid, '\n');
end

fclose(fid);