function [targets_train,targets_test,outliers_test]=dataimport_lettera

numHeaderLines=0;
% formatString='%*c%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%';

formatString='%*q%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f';
fileName='/media/SAMSUNG/rafael_notebook/rafael/Desktop/Mestrado/3/utils/Analise_Curry/letter-a/letter-aA.train.data';
numRows=574;
fid=fopen(fileName,'rt');
data=textscan(fid,formatString,numRows,'Headerlines',numHeaderLines,'Delimiter',',','CollectOutput',true); 
targets_train=data{1};
status=fclose(fid);

fileName='/media/SAMSUNG/rafael_notebook/rafael/Desktop/Mestrado/3/utils/Analise_Curry/letter-a/letter-aA.test.data';
numRows=197;
fid=fopen(fileName,'rt');
data=textscan(fid,formatString,numRows,'Headerlines',numHeaderLines,'Delimiter',',','CollectOutput',true); 
targets_test=data{1};
status=fclose(fid);

fileName='/media/SAMSUNG/rafael_notebook/rafael/Desktop/Mestrado/3/utils/Analise_Curry/letter-a/letter-aO.test.data';
numRows=4803;
fid=fopen(fileName,'rt');
data=textscan(fid,formatString,numRows,'Headerlines',numHeaderLines,'Delimiter',',','CollectOutput',true); 
outliers_test=data{1};
status=fclose(fid);




