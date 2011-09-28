function data=dataimport_pimas
% Import data from pima-indians-diabetes_P.data
% Automatically generated 24-Nov-2010

% Define parameters
fileName='/media/SAMSUNG/rafael_notebook/rafael/Desktop/Mestrado/4/experiments/pimas-indians-diabetes/pima-indians-diabetes_P.data';
numHeaderLines=0;
formatString='%*q%f%f%f%f%f%f%f%f';
numRows=501;

% Read data from file
fid=fopen(fileName,'rt');
data=textscan(fid,formatString,numRows,'headerlines',numHeaderLines,'delimiter',',','CollectOutput',true); % Option is MATLAB 7.4 feature
data=data{1};
status=fclose(fid);

