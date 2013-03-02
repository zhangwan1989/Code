%%%%%%%%%%%%%%%
%Extract Haar Feature%%%%%%%
function HaarFeature = MultiScaleHaarCaculate(winSize, image, featureFlag, multiScaleFlag)

X=rgb2gray(image);
if strcmp(multiScaleFlag, 'true')

    str_wave = 'db1'; % 小波基类型
    [c,s] = wavedec2(X,2,'db1');%两层二维小波分解，使用db1小波
    app1 = appcoef2(c,s,'db1',1);%取得第一层分解后的近似系数
    [chd1,cvd1,cdd1] = detcoef2('all',c,s,1);%取得第一层分解后的各细节系数
    app2 = appcoef2(c,s,'db1',2);%取得第二层分解后的近似系数
    [chd2,cvd2,cdd2] = detcoef2('all',c,s,2);%取得第二层分解后的各细节系数
    I_wave1=[mat2gray(app1),chd1;cvd1,cdd1];%第一层分解后系数
    I_wave2=[mat2gray(app2),chd2;cvd2,cdd2];%第二层分解后系数
    size_half = size(app1);
    I_wave3=[I_wave2(1:size_half(1),1:size_half(2)),chd1;cvd1,cdd1];%二层分解后最终的全部系数   
  
    image2= uint8(app1);
    image3= uint8(app2);
    process_imgs = {X,image2,image3};
else 
    process_imgs = {X};
end

feat_idx = 1;
intImg = IntImg(X);
length = size(process_imgs);
for id=1:length
    cur_image = process_imgs{id};
    intImg = IntImg(cur_image);
    winSize = size(cur_image);
    winWidth = winSize(2);
    winHeight = winSize(1);
    if strcmp(featureFlag,'haar')
            % There are 5 rectangles associated with haar features
            feature = [1 2; 2 1; 1 3; 3 1; 2 2];
            for i = 1:5
                sizeX = feature(i,1);   % length
                sizeY = feature(i,2);   % width
                % for all pixels inside the boundaries of our feature
                child_idx = 0;
                for x=2:winHeight-sizeX
                    for y=2:winWidth-sizeY
                        % for each width and length possible in frameSize
                        for stepHeight = sizeX*4:sizeX*4:winHeight-x
                             for stepWidth = sizeY*4:sizeY*4: winWidth-y;
                                 if (x+stepHeight<=winHeight&&y+stepWidth<=winWidth)
                                     child_idx = child_idx + 1;
                                     disp('parent feature');
                                     i
                                     disp('child feature');
                                     child_idx
                                     HaarFeature(feat_idx) = HaarFeatureCalc(intImg,x,y,stepWidth,winHeight,i);
                                     feat_idx = feat_idx + 1;
                                 end
                            end
                        end
                    end
                end
            end
    elseif strcmp(featureFlag,'lbp')
            for x=2:winHeight
                for y=2:winWidth
                    for stepWidth = 1:2:winWidth/3
                        for stepHeight = 1:2:winHeight/3
                            if(y+stepWidth*3 <= winWidth && x+stepHeight*3 <= winHeight)
                                HaarFeature(feat_idx) = LBPFeatureCalc(intImg,x,y,stepWidth,stepHeight);
                                feat_idx = feat_idx + 1;
                            end
                        end
                    end
                end
            end
    elseif strcmp(featureFlag,'haar_lbp')
            feature = [1 2; 2 1; 1 3; 3 1; 2 2];
            for i = 1:5
                sizeX = feature(i,1);   % length
                sizeY = feature(i,2);   % width
                % for all pixels inside the boundaries of our feature
                child_idx = 0;
                for x=2:winHeight-sizeX
                    for y=2:winWidth-sizeY
                        % for each width and length possible in frameSize
                        for stepHeight = sizeX*4:sizeX*4:winHeight-x
                             for stepWidth = sizeY*4:sizeY*4: winWidth-y;
                                 if (x+stepHeight<=winHeight&&y+stepWidth<=winWidth)
                                     child_idx = child_idx + 1;
                                     disp('parent feature');
                                     i
                                     disp('child feature');
                                     child_idx
                                     HaarFeature(feat_idx) = HaarFeatureCalc(intImg,x,y,stepWidth,winHeight,i);
                                     feat_idx = feat_idx + 1;
                                 end
                            end
                        end
                    end
                end
            end
            for x=2:winHeight
                for y=2:winWidth
                    for stepWidth = 1:2:winWidth/3
                        for stepHeight = 1:2:winHeight/3
                            if(y+stepWidth*3 <= winWidth && x+stepHeight*3 <= winHeight)
                                HaarFeature(feat_idx) = LBPFeatureCalc(intImg,x,y,stepWidth,stepHeight);
                                feat_idx = feat_idx + 1;
                            end
                        end
                    end
                end
            end
    end
end