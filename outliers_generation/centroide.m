function c_ = centroide(data) 
    [l,n_features] = size(data(1,:));
    for i=1:n_features
        c_(:,i) = mean( data(:,i) );
    end