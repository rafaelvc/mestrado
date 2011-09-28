function outliers_filtered = GenerateOutliersTAXSVDD(data,dR,sizeOutliers,R_filter)


    % data = dataimport_breast();
%     % Calculates the proportion needed for outliers considering 
%     % filtering phase in order to the number of outliers to be    
%     % approximatelty equal to the normal samples number
%     sizeNormals = length(data);
%     sizeOutliers = sizeNormals / abs(dR - 1.0);

   

    sizeNormals = length(data);
    [out_dataset,R,mean,Rorig] = gendatout(data,sizeOutliers,dR); 
    outliers = out_dataset.data(sizeNormals+1:end,:);
    outliers_filtered = filter_outliers(mean,Rorig * R_filter,outliers);
    
    