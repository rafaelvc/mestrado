% Generate outliers using Andras considering data input is already 
% standardized and with PCA transform. applied on. See also genOutliersDefaultAndras2
function outliers_data=genOutliersDefaultAndras(targets, dist, curv)
        
    % default parameters according the paper 
    if nargin < 2
	   dist = 1.0;
       curv = 0.5;
    end

    set.dist=dist; 
    set.curv=curv; 
    dim = size(targets,2);
    
    set.knn = 2 * dim;
    set.knn_check = 2 * dim;
    
    % set.knn = 20;
    % set.knn_check = 20;
    set.BoundaryMethod='SVM'; 
    set.CheckInnerMethod='SVM'; 
    
    outliers_data = GetCounterExamples(targets, 'SETTINGS', set);
    
    