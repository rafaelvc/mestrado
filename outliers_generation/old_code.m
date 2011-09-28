%    for k=1:klusters
    

%    fprintf('Getting cluster 1 centroid and ray ...\n');
%    centroid_k1 = centroide(k1); 
%    raio_k1 = raio(k1, centroid_k1); 
%    fprintf('Generating outliers for cluster 1...\n');    
%    out_k1 = outliers_hyph(k1, percent_out, dR_hyph_param );
%    n_outk1 = length(out_k1); 
  
%    fprintf('Getting cluster 2 centroid and ray ...\n');
%    centroid_k2 = centroide(k2); 
%    raio_k2 = raio(k2, centroid_k2); 
%    fprintf('Generating outliers for cluster 2...\n');    
%    out_k2 = outliers_hyph(k2, percent_out, dR_hyph_param );    
%    n_outk2 = length(out_k2);
    
%    fprintf('Filtering outliers for cluster 1...\n');        
%    out_k1 = filter_outliers(centroid_k1, raio_k1, out_k1);
%    out_k1 = filter_outliers(centroid_k2, raio_k2, out_k1);

 %   fprintf('Filtering outliers for cluster 2...\n');        
 %   out_k2 = filter_outliers(centroid_k2, raio_k2, out_k2);
 %   out_k2 = filter_outliers(centroid_k1, raio_k1, out_k2);

 %   outliers = [out_k1; out_k2];
 %   n_outk1_ = length(out_k1);
 %   n_outk2_ = length(out_k2);

  %  out_path=strcat(path,'_k2_hyph_',int2str(percent_out),'.data');
  %  save(out_path,'outliers','-ASCII');
  %  fprintf('Generated outliers for k=1: %i\n', n_outk1);
  %  fprintf('Removed outliers for k=1: %i\n', n_outk1-n_outk1_);
  %  fprintf('Generated outliers for k=2: %i\n', n_outk2);    
  %  fprintf('Removed outliers for k=2: %i\n', n_outk2-n_outk2_);    
  %  fprintf(1,'Hyph %i generation complete (clustering k=2).\n\n', percent_out);
    
  % klusters = 3;
    
  %  [cl, centers, distance] = dcKmeans(data, klusters);
  %  [k1,k2,k3,k4] = group_clusters(cl,data);
    
  %  out_k1 = outliers_hyph(k1, percent_out, dR_hyph_param );
  %  centroid_k1 = centroide(k1); 
  %  raio_k1 = raio(k1, centroid_k1); 
  %  n_outk1 = length(out_k1);
    
  %  out_k2 = outliers_hyph(k2, percent_out, dR_hyph_param );
  %  centroid_k2 = centroide(k2); 
  %  raio_k2 = raio(k2, centroid_k2); 
  %  n_outk2 = length(out_k2);
    
  %  out_k3 = outliers_hyph(k3, percent_out, dR_hyph_param );
  %  centroid_k3 = centroide(k3); 
  %  raio_k3 = raio(k3, centroid_k3); 
  %  n_outk3 = length(out_k3);
    
  %  out_k1 = filter_outliers(centroid_k1, raio_k1, out_k1);
  %  out_k1 = filter_outliers(centroid_k2, raio_k2, out_k1);
  %  out_k1 = filter_outliers(centroid_k3, raio_k3, out_k1);
    
  %  out_k2 = filter_outliers(centroid_k1, raio_k1, out_k2);
  %  out_k2 = filter_outliers(centroid_k2, raio_k2, out_k2);
  %  out_k2 = filter_outliers(centroid_k3, raio_k3, out_k2);
    
  %  out_k3 = filter_outliers(centroid_k1, raio_k1, out_k3);
  %  out_k3 = filter_outliers(centroid_k2, raio_k2, out_k3);
  %  out_k3 = filter_outliers(centroid_k3, raio_k3, out_k3);
    
  %  outliers = [out_k1; out_k2; out_k3];
  %  n_outk1_ = length(out_k1);
  %  n_outk2_ = length(out_k2);
  %  n_outk3_ = length(out_k3);
    
  %  out_path=strcat(path,'_k3_hyph_200.data');
  %  save(out_path,'outliers','-ASCII');
  %  fprintf('Outliers gerados para k=1: %i\n', n_outk1);
  %  fprintf('Outliers removidos para k=1: %i\n', n_outk1-n_outk1_);
  %  fprintf('Outliers gerados para k=2: %i\n', n_outk2);    
  %  fprintf('Outliers removidos para k=2: %i\n', n_outk2-n_outk2_);    
  %  fprintf('Outliers gerados para k=3: %i\n', n_outk3);    
  %  fprintf('Outliers removidos para k=3: %i\n', n_outk3-n_outk3_);    
  %  fprintf(1,'Hyph 200 complete (clustering k=3).\n\n');
