function data=dataimport_breast
% Import data from wdbc_B.data
% Automatically generated 18-Oct-2010

% Define parameters
fileName='/media/SAMSUNG/rafael_notebook/rafael/Desktop/Mestrado/4/experiments/wisconcin-diagnostic-breast-cancer/wdbc_B.data'; 
numHeaderLines=0;
formatString='%*q%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f';
numRows=357;

% Read data from file
fid=fopen(fileName,'rt');
data=textscan(fid,formatString,numRows,'headerlines',numHeaderLines,'delimiter',',','CollectOutput',true); % Option is MATLAB 7.4 feature
data=data{1};
status=fclose(fid);

