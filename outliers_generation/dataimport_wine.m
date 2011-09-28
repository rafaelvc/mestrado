function data=dataimport_wine
% Import data from wine_P.data
% Automatically generated 24-Nov-2010

% Define parameters
fileName='/home/rafael/Desktop/Mestrado/4/experiments/wine/wine_P.data';
numHeaderLines=0;
formatString='%*q%f%f%f%f%f%f%f%f%f%f%f%f%f';
numRows=71;

% Read data from file
fid=fopen(fileName,'rt');
data=textscan(fid,formatString,numRows,'headerlines',numHeaderLines,'delimiter',',','CollectOutput',true); % Option is MATLAB 7.4 feature
data=data{1};
status=fclose(fid);

