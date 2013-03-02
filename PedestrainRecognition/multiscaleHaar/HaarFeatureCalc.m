function [thresh] = HaarFeatureCalc(intImg,x,y,winWidth,winLength,classifier)
% calculates integral image
% x,y gives coordinates
% winWidth, winLength gives size of window
% classifier gives the classifier ( only 5)
% [start_row start_column width length]
if (classifier==1)
    firstRec = [x y ((winWidth/2)-1) (winLength-1)];
    secondRec = [x (y+winWidth/2) ((winWidth/2)-1) (winLength-1)];
    % gets the integral image
    thresh = CalcIntRec(intImg,firstRec) + CalcIntRec(intImg,secondRec);
elseif (classifier==2)
    firstRec = [x y (winWidth-1) ((winLength/2)-1)];
    secondRec = [(x + winLength/2) y (winWidth-1) ((winLength/2)-1)];
    % gets the integral image
    thresh = CalcIntRec(intImg,firstRec) + CalcIntRec(intImg,secondRec);
elseif (classifier==3)
    firstRec = [x y ((winWidth/3)-1) (winLength-1)];
    secondRec = [x (y+(winWidth/3)) ((winWidth/3)-1) (winLength-1)];
    thirdRec =  [x (y+((2*winWidth)/3)) ((winWidth/3)-1) (winLength-1)];
    thresh = CalcIntRec(intImg,firstRec) - CalcIntRec(intImg,secondRec) + CalcIntRec(intImg,thirdRec);
elseif (classifier==4)
    firstRec = [x y (winWidth-1) ((winLength/3) -1)];
    secondRec = [(x+(winLength/3)) y (winWidth-1) ((winLength/3) -1)];
    thirdRec = [(x+((2*winLength)/3)) y (winWidth-1) ((winLength/3) -1)];
    thresh = CalcIntRec(intImg,firstRec) - CalcIntRec(intImg,secondRec) + CalcIntRec(intImg,thirdRec);
elseif (classifier==5)
    firstRec = [x y (winWidth/2-1) (winLength/2-1)];
    secondRec = [x (y + winWidth/2) (winWidth/2-1) (winLength/2-1)];
    thirdRec = [(x + winLength/2) y (winWidth/2-1) (winLength/2-1)];
    fourthRec = [(x + winLength/2) (y + winWidth/2) (winWidth/2-1) (winLength/2-1)];
    thresh = CalcIntRec(intImg,firstRec) - CalcIntRec(intImg,secondRec) + CalcIntRec(intImg,thirdRec) - CalcIntRec(intImg,fourthRec);
end
