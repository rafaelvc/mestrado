function outliers_sonar_filtered = GenerateOutliersTAX_sonar(dR)
    data = dataimport_sonar();
    % Calculates the proportion needed for outliers considering 
    % filtering phase in order to the number of outliers to be    
    % approximatelty equal to the normal samples number
    sizeNormals = length(data);
    sizeOutliers = sizeNormals / abs(dR - 1.0);
    [out_dataset,R,mean,Rorig] = gendatout(data,sizeOutliers,dR); 
    outliers_sonar = out_dataset.data(sizeNormals+1:end,:);
    outliers_sonar_filtered = filter_outliers(mean,Rorig,outliers_sonar);
    
    
