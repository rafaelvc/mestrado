function [targets_train,targets_test,outliers_test]=dataimport_lettere

numHeaderLines=0;
% formatString='%*c%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%';

formatString='%*q%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f';
fileName='/media/SAMSUNG/rafael_notebook/rafael/Desktop/Mestrado/3/utils/Analise_Curry/letter-e/letter-eE.train.data';
numRows=545;
fid=fopen(fileName,'rt');
data=textscan(fid,formatString,numRows,'Headerlines',numHeaderLines,'Delimiter',',','CollectOutput',true); 
targets_train=data{1};
status=fclose(fid);

fileName='/media/SAMSUNG/rafael_notebook/rafael/Desktop/Mestrado/3/utils/Analise_Curry/letter-e/letter-eE.test.data';
numRows=192;
fid=fopen(fileName,'rt');
data=textscan(fid,formatString,numRows,'Headerlines',numHeaderLines,'Delimiter',',','CollectOutput',true); 
targets_test=data{1};
status=fclose(fid);

fileName='/media/SAMSUNG/rafael_notebook/rafael/Desktop/Mestrado/3/utils/Analise_Curry/letter-e/letter-eO.test.data';
numRows=4808;
fid=fopen(fileName,'rt');
data=textscan(fid,formatString,numRows,'Headerlines',numHeaderLines,'Delimiter',',','CollectOutput',true); 
outliers_test=data{1};
status=fclose(fid);




