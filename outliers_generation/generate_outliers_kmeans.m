% Sample usage: 
% generate_outliers_kmeans(data, 'F:\\10Bases\\Pima_Indians\\pimas-indians-n-outliers\\pima-indians-diabetes.n', 3);
% generate_outliers_kmeans(data, 'F:\\10Bases\\Breast-cancer-wisconsin\\breast-outliers-B\\breast-B',3 );
% generate_outliers_kmeans(data, 'F:\\10Bases\\Letter\\letter-a-outliers\\letter-a', 3);

function ret = generate_outliers_kmeans(data, path, klusters) 

    dR_hyph_param = 2.0;  % see gendataout documentation 
    percent_out = 400;    % number of outliers to be generated, relative to number of targets

    fprintf('Clustering target data (%i clusters)...\n', klusters);
    [cl, centers, distance] = dcKmeans(data, klusters);
    
    for k=1:klusters
        kluster(k).content   = get_cluster(cl, data, k);      
        [kluster(k).size,c]   = size(kluster(k).content);
        kluster(k).orig_size = kluster(k).size;  
        fprintf('Getting cluster %i centroid and ray ...\n', k);
        kluster(k).centroid  = centroide(kluster(k).content);
        kluster(k).ray       = raio(kluster(k).content, kluster(k).centroid);
        
        fprintf('Generating outliers for cluster %i...\n', k);            
        kluster(k).outliers  = outliers_hyph( kluster(k).content , percent_out, dR_hyph_param );        
        [kluster(k).orig_out_size, c]  = size(kluster(k).outliers);        
        kluster(k).out_size = kluster(k).orig_out_size;                
    end

    fprintf('\n\n');
    
    outliers_SET = [];
    for k=1:klusters
        fprintf('Filtering outliers for cluster %i...\n', k);
        for k_=1:klusters
            kluster(k).outliers = filter_outliers(kluster(k_).centroid,  kluster(k_).ray, kluster(k).outliers);
        end
        [kluster(k).out_size, c] = size(kluster(k).outliers);
        outliers_SET = cat(1,outliers_SET,kluster(k).outliers);
        fprintf('Generated outliers for k=%i: %i\n', k, kluster(k).orig_out_size);
        fprintf('Removed outliers for k=%i: %i\n', k, (kluster(k).orig_out_size - kluster(k).out_size));
    end

    out_path=strcat(path,'_k',int2str(klusters),'_hyph_',int2str(percent_out),'.data');
    save(out_path,'outliers_SET','-ASCII');
    fprintf(1,'Hyph %i generation complete (clustering k=%i).\n\n', percent_out, klusters);   

    ret='OK';
    return;    
    
 
function cluster_ = get_cluster(cl, data, k_)
    cluster_ = [];
    i = 1;
    j = 1;
    for c = cl'        
            % fprintf('valork %i, valorc %i \n', k_,c );            
            if c == k_
               cluster_(j,:) = data(i,:);
               j = j + 1;
           end 
           i = i + 1;
    end
    
    
function [k1,k2,k3,k4] = group_clusters(cl, data)

    k1 = [];
    k2 = [];
    k3 = [];
    k4 = [];
    
    i_k1 = 1;
    i_k2 = 1;
    i_k3 = 1;
    i_k4 = 1;
    
    n_data = length(data);
    
    for i=1:n_data
        if cl(i,:) == 1
              k1(i_k1,:) = data(i,:);
              i_k1 = i_k1 + 1;
        elseif cl(i,:) == 2
              k2(i_k2,:) = data(i,:);
              i_k2 = i_k2 + 1;
        elseif cl(i,:) == 3
              k3(i_k3,:) = data(i,:);
              i_k3 = i_k3 + 1;
        else
              k4(i_k4,:) = data(i,:);
              i_k4 = i_k4 + 1;
        end
    end 
    
    
