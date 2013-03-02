function [thresh] = LBPFeatureCalc(intImg,x,y,winWidth,winHeight)

Rect0 = [x y winWidth winHeight];
Rect1 = [x y+winWidth winWidth winHeight];
Rect2 = [x y+winWidth*2 winWidth winHeight];
Rect3 = [x+winHeight y winWidth winHeight];
Rect4 = [x+winHeight y+winWidth winWidth winHeight];
Rect5 = [x+winHeight y+winWidth*2 winWidth winHeight];
Rect6 = [x+winHeight*2 y winWidth winHeight];
Rect7 = [x+winHeight*2 y+winWidth winWidth winHeight];
Rect8 = [x+winHeight*2 y+winWidth*2 winWidth winHeight];

val0 = CalcIntRec(intImg,Rect0);
val1 = CalcIntRec(intImg,Rect1);
val2 = CalcIntRec(intImg,Rect2);
val3 = CalcIntRec(intImg,Rect3);
val4 = CalcIntRec(intImg,Rect4);
val5 = CalcIntRec(intImg,Rect5);
val6 = CalcIntRec(intImg,Rect6);
val7 = CalcIntRec(intImg,Rect7);
val8 = CalcIntRec(intImg,Rect8);

bit0 = conditionCmp(val0,val4,128);
bit1 = conditionCmp(val1,val4,64);
bit2 = conditionCmp(val2,val4,32);
bit3 = conditionCmp(val3,val4,16);
bit5 = conditionCmp(val5,val4,8);
bit6 = conditionCmp(val6,val4,4);
bit7 = conditionCmp(val7,val4,2);
bit8 = conditionCmp(val8,val4,1);
thresh =bitor(bitor(bitor(bitor(bitor(bitor(bitor(bit8,bit7),bit6),bit5),bit3),bit2),bit1),bit0);