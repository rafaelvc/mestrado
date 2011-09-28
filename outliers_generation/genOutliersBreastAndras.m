function outliers_breast=genOutliersBreastAndras(data)

    set.dist=1.0; 
    set.curv=0.5; 
    set.knn = 2 * size(data(1:end,:));
    set.knn_check = 2 * size(data(1:end,:));
    set.BoundaryMethod='SVM'; 
    set.CheckInnerMethod='SVM'; 
    outliers_breast = GetCounterExamples(data, 'SETTINGS', set);