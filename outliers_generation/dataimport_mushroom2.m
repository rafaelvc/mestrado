function [targets_train,targets_test,outliers_test]=dataimport_mushroom2

numHeaderLines=0;
% formatString='%*c%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%';
formatString='%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f' 

fileName='/media/SAMSUNG/rafael_notebook/rafael/Desktop/Mestrado/3/utils/Analise_Curry/mushroom/newbases/agaricus-lepiotaP.train.converted.data';
numRows=1617;
fid=fopen(fileName,'rt');
data=textscan(fid,formatString,numRows,'Headerlines',numHeaderLines,'Delimiter',',','CollectOutput',true); 
targets_train=data{1};
status=fclose(fid);

fileName='/media/SAMSUNG/rafael_notebook/rafael/Desktop/Mestrado/3/utils/Analise_Curry/mushroom/newbases/agaricus-lepiotaP.test.converted.data';
numRows=539;
fid=fopen(fileName,'rt');
data=textscan(fid,formatString,numRows,'Headerlines',numHeaderLines,'Delimiter',',','CollectOutput',true); 
targets_test=data{1};
status=fclose(fid);

fileName='/media/SAMSUNG/rafael_notebook/rafael/Desktop/Mestrado/3/utils/Analise_Curry/mushroom/newbases/agaricus-lepiotaE.converted.data';
numRows=872;
fid=fopen(fileName,'rt');
data=textscan(fid,formatString,numRows,'Headerlines',numHeaderLines,'Delimiter',',','CollectOutput',true); 
outliers_test=data{1};
status=fclose(fid);




