% Sample usage: 
% generate_outliers(data, 'F:\\10Bases\\Pima_Indians\\pimas-indians-n-outliers\\pima-indians-diabetes.n');
% generate_outliers(data, 'F:\\10Bases\\Breast-cancer-wisconsin\\breast-outliers-B\\breast-B');
% generate_outliers(data, 'F:\\10Bases\\Letter\\letter-a-outliers\\letter-a');


% Generate outliers outside hyphersphere where data is inside
% Outliers generated inside the hyphersphere are removed 
function ret_gen_out = generate_outliers(data, path) 

    dR_hyph_param = 2.0;  % see gendataout documentation 
    percent_out = 400;    % number of outliers to be generated, relative to number of targets
        
    fprintf('Getting centroid and ray of target data...\n');    
    centroid_ = centroide(data); 
    raio_ = raio(data, centroid_); 
    
    fprintf('Generating outliers...\n');
    outliers = outliers_hyph(data, percent_out, dR_hyph_param );
    [n_out,c] = size(outliers);

    fprintf('Filtering outliers...\n');
    outliers_ = filter_outliers(centroid_, raio_, outliers);
    [n_out_,c] = size(outliers_);
    
    fprintf('\n\n');
        
    out_path=strcat(path,'_hyph_',int2str(percent_out),'.data');
    save(out_path,'outliers_','-ASCII');
    fprintf('Generated outliers %i\n', n_out);
    fprintf('Removed outliers %i\n', n_out-n_out_);
    fprintf(1,'Hyph %i generation complete.\n\n', percent_out);
    
    ret_gen_out='OK';
    return;



    

    


    

    


    


