function outliers_filtered = GenerateOutliersTAXHYPH(data,dR)
    % data = dataimport_breast();
    % Calculates the proportion needed for outliers considering 
    % filtering phase in order to the number of outliers to be    
    % approximatelty equal to the normal samples number
    sizeNormals = length(data);
    sizeOutliers = sizeNormals / abs(dR - 1.0);
    [out_dataset,R,mean,Rorig] = gendatout(data,sizeOutliers,dR); 
    outliers = out_dataset.data(sizeNormals+1:end,:);
    
    % Hyphersphere parameters
    meanhyph = centroide(data);
    Rhyph = raio(data,meanhyph);
        
    outliers_filtered = filter_outliers(meanhyph,Rhyph*0.8,outliers);
    
    