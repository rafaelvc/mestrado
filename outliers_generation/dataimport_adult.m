function [targets_train,targets_test,outliers_test]=dataimport_adult

numHeaderLines=0;
formatString='%f%f%f%f%f%f%f%f%f%f%f%f%f%f';

% formatString='%*q%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f';
fileName='/media/SAMSUNG/rafael_notebook/rafael/Desktop/Mestrado/3/utils/Analise_Curry/adult/newbases/adultG50K.train.converted';
numRows=7506;
fid=fopen(fileName,'rt');
data=textscan(fid,formatString,numRows,'Headerlines',numHeaderLines,'Delimiter',',','CollectOutput',true); 
targets_train=data{1};
status=fclose(fid);

fileName='/media/SAMSUNG/rafael_notebook/rafael/Desktop/Mestrado/3/utils/Analise_Curry/adult/newbases/adultG50K.test.converted';
numRows=3700;
fid=fopen(fileName,'rt');
data=textscan(fid,formatString,numRows,'Headerlines',numHeaderLines,'Delimiter',',','CollectOutput',true); 
targets_test=data{1};
status=fclose(fid);

fileName='/media/SAMSUNG/rafael_notebook/rafael/Desktop/Mestrado/3/utils/Analise_Curry/adult/newbases/adultL50K.test.converted';
numRows=11355;
fid=fopen(fileName,'rt');
data=textscan(fid,formatString,numRows,'Headerlines',numHeaderLines,'Delimiter',',','CollectOutput',true); 
outliers_test=data{1};
status=fclose(fid);




