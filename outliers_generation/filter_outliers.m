% Return the outliers are out of an hyphersphere with a given 
% centroid and ray acording the euclidian distance 
function out = filter_outliers(centroid_, raio_, outliers_)
    [n_out,c] = size(outliers_);
    j = 1;
    x = 0;
    out = [];
    for i=1:n_out
        dist = sqrt( sum( (centroid_ - outliers_(i,:)).^2 ) );
        if dist > raio_
            out(j,:) = outliers_(i,:);
            j = j + 1;
        else
            x = x + 1;
        end 
    end
    %fprintf('Outliers gerados: %i\n',n_out);
    %fprintf('Outliers removidos: %i\n', x);