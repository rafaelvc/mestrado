function [targets_,targets_fold_,targets_fold_test_,outliers_fold_test_] = convertAndrasFold(tmp,tmp_test) 

    b_pca = true;
    
    ixtargets  =  find( tmp_test(:,end) == 1 );
    ixoutliers =  find( tmp_test(:,end) == 2 );
    
    targets_fold = tmp(:,1:end-1);
    targets_fold_test  =  tmp_test(ixtargets,1:end-1);
    outliers_fold_test =  tmp_test(ixoutliers,1:end-1);
    
    lim = size(targets_fold,1);
       
    %normalize
    X = [ targets_fold; targets_fold_test ];
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
    
    targets_  = X; 
    targets_fold_ = X(1:lim,:);
    targets_fold_test_ = X(lim+1:end,:);
    
    params.mean = Xm;
    params.PCA = PC;

    X = outliers_fold_test;
    for i=1:size(X,1)
        X(i,:)=(X(i,:)-diff)./len;
    end
        
    for i=1:size(X,1)
        X(i,:)=X(i,:)-params.mean;
    end

    if b_pca
        X=X*params.PCA;
    end
    
    outliers_fold_test_ = X;