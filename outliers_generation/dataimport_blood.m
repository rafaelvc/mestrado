function data=dataimport_blood
% Import data from transfusion_P.data
% Automatically generated 25-Nov-2010

% Define parameters
fileName='/home/rafael/Desktop/Mestrado/4/experiments/blood_transfusion/transfusion_P.data';
numHeaderLines=0;
formatString='%*q%f%f%f%f';
numRows=571;

% Read data from file
fid=fopen(fileName,'rt');
data=textscan(fid,formatString,numRows,'headerlines',numHeaderLines,'delimiter',',','CollectOutput',true); % Option is MATLAB 7.4 feature
data=data{1};
status=fclose(fid);

