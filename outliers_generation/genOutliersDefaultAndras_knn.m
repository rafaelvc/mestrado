% Generate outliers using Andras considering data input is already 
% standardized and with PCA transform. applied on. See also genOutliersDefaultAndras2
function outliers_data=genOutliersDefaultAndras_knn(targets, dist, curv, knn)

    dim = size(targets,2);

    % default parameters according the paper 
    if nargin < 2
	   dist = 1.0;
       curv = 0.5;
       knn = 2*dim;
    end

    set.dist=dist; 
    set.curv=curv; 
    
    set.knn = knn ;
    set.knn_check = knn;
    
    % set.knn = 20;
    % set.knn_check = 20;
    set.BoundaryMethod='SVM'; 
    set.CheckInnerMethod='SVM'; 
    
    outliers_data = GetCounterExamples(targets, 'SETTINGS', set);
    
    