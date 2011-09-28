function [targets_train,targets_test,outliers_test]=dataimport_census

numHeaderLines=0;
% formatString='%*c%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%';

formatString='%*q%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f';
fileName='/media/SAMSUNG/rafael_notebook/rafael/Desktop/Mestrado/3/utils/Analise_Curry/census/census-income50Kplus.train.data';
numRows=5472;
fid=fopen(fileName,'rt');
data=textscan(fid,formatString,numRows,'Headerlines',numHeaderLines,'Delimiter',',','CollectOutput',true); 
targets_train=data{1};
status=fclose(fid);

fileName='/media/SAMSUNG/rafael_notebook/rafael/Desktop/Mestrado/3/utils/Analise_Curry/census/census-income50Kplus.test.data';
numRows=2683;
fid=fopen(fileName,'rt');
data=textscan(fid,formatString,numRows,'Headerlines',numHeaderLines,'Delimiter',',','CollectOutput',true); 
targets_test=data{1};
status=fclose(fid);

fileName='/media/SAMSUNG/rafael_notebook/rafael/Desktop/Mestrado/3/utils/Analise_Curry/census/census-income50KplusO.test.data';
numRows=34947;
fid=fopen(fileName,'rt');
data=textscan(fid,formatString,numRows,'Headerlines',numHeaderLines,'Delimiter',',','CollectOutput',true); 
outliers_test=data{1};
status=fclose(fid);




