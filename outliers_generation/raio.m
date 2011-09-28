function r_ = raio(data, centroid_)  
    [l,c] = size(data);
    for i=1:l    
        vet_dist(:,i) = sqrt( sum( (centroid_ - data(i,:)).^2 ) );
    end
    r_ = 1.0 * max( vet_dist );
    