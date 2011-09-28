function [targets_std,targets_test_std] = standardizeAndras(targets,targets_test)
       
    data = [targets;targets_test];
    diff = mean(data);
    len_ = std(data);
    ntargets = length(targets); 
    ntargets_test = length(targets_test);
    targets_std = (targets - ones(ntargets, 1) * diff) ./ (ones(ntargets, 1) * len_);
    targets_test_std = (targets_test - ones(ntargets_test, 1) * diff) ./ (ones(ntargets_test, 1) * len_);
    return;
    
     
    X_P = targets;
    X_Pt = targets_test;
    % ripped out from Ce_main.m
    %X = unique(X, 'rows');
    %[X, colmean, coldev] = normalize(X, 'interval');
    min_x = min(X_P);
    max_x = max(X_P);
    diff = (max_x + min_x) / 2;
    len = (max_x - min_x) / 2;
    len(find(len==0))=1;
    for i=1:size(X_P,1)
        X_P(i,:)=(X_P(i,:)-diff)./len;
    end
    % ripped out from Train.m
    dim=size(X_P,2);
    %PCA
    Xm = mean(X_P);
    m=size(X_P,1);
    b_pca = false;
    if b_pca
        Xc = X_P - repmat(Xm, m, 1);
        [PC,SCORE,latent,tsquare] = princomp(Xc);
        X_P=SCORE;
        % modelparams.PCA=PC;
    else
        X_P = X_P - repmat(Xm, m, 1);
        %PC=eye(size(X_P,2));
    end

    for i=1:size(X_Pt,1)
        X_Pt(i,:)=((X_Pt(i,:)-diff)./len)-Xm;
    end