function outliers = generate_outliers_wang(data, nr_out)

  [row,col] = size(data);
  col1 = round(1 + (col-1)*rand(1));
  col2 = round(1 + (col-1)*rand(1));
  
  max_c1 = max(data(:,col1));
  max_c2 = max(data(:,col2));
  
  outliers = [];
  
  for i=1:nr_out
        out_i = round(1 + (row-1)*rand(1));
        new_out = data(out_i,:);
        new_out(:,col1) = max_c1;
        new_out(:,col2) = max_c2;
        outliers = [outliers; new_out];
  end
        
  
  
  