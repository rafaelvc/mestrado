function [targets,outliers_test]=dataimport_iris

numHeaderLines=0;
formatString='%*q%f%f%f%f';

fileName='/media/SAMSUNG/rafael_notebook/rafael/Desktop/Mestrado/4/experiments/iris/iris_N.data';
numRows=100;
fid=fopen(fileName,'rt');
data=textscan(fid,formatString,numRows,'headerlines',numHeaderLines,'delimiter',',','CollectOutput',true); % Option is MATLAB 7.4 feature
targets=data{1};
status=fclose(fid);

fileName='/media/SAMSUNG/rafael_notebook/rafael/Desktop/Mestrado/4/experiments/iris/iris_P.data';
numRows=50;
fid=fopen(fileName,'rt');
data=textscan(fid,formatString,numRows,'headerlines',numHeaderLines,'delimiter',',','CollectOutput',true); % Option is MATLAB 7.4 feature
outliers_test=data{1};
status=fclose(fid);
