function [targets,outliers_test]=dataimport_sonar

numHeaderLines=0;
formatString='%*q%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f';

% Define parameters
fileName='/media/SAMSUNG/rafael_notebook/rafael/Desktop/Mestrado/4/experiments/sonar/sonar_M.data';
numRows=111;
fid=fopen(fileName,'rt');
data=textscan(fid,formatString,numRows,'headerlines',numHeaderLines,'delimiter',',','CollectOutput',true); % Option is MATLAB 7.4 feature
targets=data{1};
status=fclose(fid);

fileName='/media/SAMSUNG/rafael_notebook/rafael/Desktop/Mestrado/4/experiments/sonar/sonar_P.data';
numRows=97;
fid=fopen(fileName,'rt');
data=textscan(fid,formatString,numRows,'headerlines',numHeaderLines,'delimiter',',','CollectOutput',true); % Option is MATLAB 7.4 feature
outliers_test=data{1};
status=fclose(fid);