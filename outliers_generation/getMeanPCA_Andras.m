function X = getMeanPCA_Andras( db ) 
    
    b_pca = true;

    %normalize
    X = db;
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
    