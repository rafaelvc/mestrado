    function [targets_,outliers,outtest,params]=genOutliersDefaultAndras2(targets, outliers_test, dist, curv)

    b_pca = false;
      
    %normalize
    X = targets;
    min_x = min(X);
    max_x = max(X);
    diff = (max_x + min_x) / 2;
    len = (max_x - min_x) / 2;
    len(find(len<1e-8))=1;
    for i=1:size(X,1)
        X(i,:)=(X(i,:)-diff)./len;
    end
    
    %PCA
    Xm = mean(X);
    m=size(X,1);
    if b_pca
        Xc = X - repmat(Xm, m, 1);
        [PC,SCORE,latent,tsquare] = princomp(Xc);
        X=SCORE;
    else
        X = X - repmat(Xm, m, 1);
        PC=eye(size(X,2));
    end
    
    params.mean = Xm;
    params.PCA = PC;
    
    % default parameters according the paper 
    if nargin < 3
	   dist = 1.0;
       curv = 0.5;
    end

    set.dist=dist; 
    set.curv=curv; 
    dim = size(targets,2);
    set.knn = 2 * dim;
    set.knn_check = 2 * dim;
    % set.knn = 136;
    % set.knn_check = 136;
    set.BoundaryMethod='PERC'; 
    set.CheckInnerMethod='PERC'; 
    
    targets_ = X;
    outliers = GetCounterExamples(X, 'SETTINGS', set);
    % outliers = GetInverseBorderSVM(X);
    
    if isempty(outliers_test)
        outtest = [];
        return;
    end
    
    X = outliers_test;
    for i=1:size(X,1)
        X(i,:)=(X(i,:)-diff)./len;
    end
        
    for i=1:size(X,1)
        X(i,:)=X(i,:)-params.mean;
    end

    if b_pca
        X=X*params.PCA;
    end
    
    outtest = X;
    



