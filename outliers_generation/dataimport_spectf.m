function [targets,outliers_test]=dataimport_spectf

numHeaderLines=0;
formatString='%*q%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f';

fileName='/media/SAMSUNG/rafael_notebook/rafael/Desktop/Mestrado/4/experiments/spectf/SPECTF_P.data';
numRows=212;
fid=fopen(fileName,'rt');
data=textscan(fid,formatString,numRows,'headerlines',numHeaderLines,'delimiter',',','CollectOutput',true); % Option is MATLAB 7.4 feature
targets=data{1};
status=fclose(fid);

fileName='/media/SAMSUNG/rafael_notebook/rafael/Desktop/Mestrado/4/experiments/spectf/SPECTF_N.data';
numRows=55;
fid=fopen(fileName,'rt');
data=textscan(fid,formatString,numRows,'headerlines',numHeaderLines,'delimiter',',','CollectOutput',true); % Option is MATLAB 7.4 feature
outliers_test=data{1};
status=fclose(fid);